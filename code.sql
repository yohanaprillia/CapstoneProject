SELECT COUNT (DISTINCT utm_campaign) AS 'Number_of_Campaigns'
FROM page_visits;

SELECT COUNT (DISTINCT utm_source) AS 'Number_of_Sources'
FROM page_visits;

SELECT DISTINCT utm_source AS 'Sources', utm_campaign AS 'Campaign_Name'
FROM page_visits;

SELECT DISTINCT page_name AS 'Page_Name'
FROM page_visits;

WITH first_touch AS (
SELECT user_id, 
  MIN(timestamp) AS 'first_touch_at'
  FROM page_visits
  GROUP BY user_id),
ft_attr AS (  
SELECT ft.user_id, 
ft.first_touch_at,
pv.utm_source,
pv.utm_campaign
FROM first_touch AS 'ft'
JOIN page_visits AS 'pv'
ON ft.user_id = pv.user_id
AND ft.first_touch_at = pv.timestamp)
SELECT ft_attr.utm_source AS 'First_Attr_Source',
			 ft_attr.utm_campaign AS 'First_Attr_Campaign',
       COUNT (*) AS 'Total'
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

WITH last_touch AS(
SELECT user_id,
MAX(timestamp) AS 'last_touch_at'
FROM page_visits
GROUP BY user_id),
lt_attr AS (
SELECT lt.user_id,
lt.last_touch_at,
pv.utm_source,
pv.utm_campaign,
pv.page_name
FROM last_touch AS 'lt'
JOIN page_visits AS 'pv'
ON lt.user_id = pv.user_id
AND lt.last_touch_at = pv.timestamp)
SELECT lt_attr.utm_source AS 'Last_Attr_Source', 
lt_attr.utm_campaign AS 'Last_Attr_Campaign', 
COUNT(*) AS 'Total'
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

SELECT COUNT(DISTINCT user_id) AS 'Purchased_Visitors'
FROM page_visits
WHERE page_name = '4 - purchase';

WITH last_touch AS(
SELECT user_id,
MAX(timestamp) AS 'last_touch_at'
FROM page_visits
WHERE page_name = '4 - purchase'
GROUP BY user_id),
lt_attr AS (
SELECT lt.user_id,
lt.last_touch_at,
pv.utm_source,
pv.utm_campaign,
pv.page_name
FROM last_touch AS 'lt'
JOIN page_visits AS 'pv'
ON lt.user_id = pv.user_id
AND lt.last_touch_at = pv.timestamp)
SELECT lt_attr.utm_source AS 'Last_Attr_Source', 
lt_attr.utm_campaign AS 'Last_Attr_Campaign', 
COUNT(*) AS 'Total'
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;