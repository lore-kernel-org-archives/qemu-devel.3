Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B9C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc3l-0005IQ-Oj; Tue, 15 Jul 2025 05:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1S-0001QF-Km; Tue, 15 Jul 2025 05:32:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1M-0005qI-T9; Tue, 15 Jul 2025 05:32:26 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F94iUQ013681;
 Tue, 15 Jul 2025 02:32:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rLiuJD3AEt2twRvOTCwJBhQImCynC3M1rWgvRUTf1
 gQ=; b=DQizu995rO2W932PUT5PrADPf6BcwBETQzxldilx9XE1xCUyHJWpAvi90
 ApmxZPW2GQ5+gK0Uu4zMgDscq1zkYCy8UwFes+FTvQSgi8N/vZIhGi0mquA2fwY9
 d5qgphp0XL7gJ08khq4l93QnXcN2AeU6MZJDNnx42P8UT6Uui1f+fZKW0n8BqGKH
 Zzcq9OlLyog2m1U2fbVKa4F03RJu9ZgquH4Qf9I0hOCyjVa9FNF/40ud3RjkZLod
 EF3jvzMYeXf4sVwt2tQPuVJcODtVxvkvPjcwArfkjGsuw7gcovVbP/DJ33Y9Snok
 Fm5jEHeo6v6EDZga2qNsHKpkLCj6g==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2123.outbound.protection.outlook.com [40.107.244.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47wm1s8243-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrbQ2EtB7U4uPFhLUX4awIQLF/YMEEOzpdHqg5OLbl2D1cbEf5G7t/8X/b5x9+OqpWwB/UdDXEYBdJBnFrZBK9YZ4raAG3HC/VUxenygUCQGbccHg0xXjTcw3KZGYa1YcCP6VhjfiECrcPP2BWC+KR6XqzGooiB+RbNJk/Ew0spm7Mb2kWmhz6SBZsOw10To3wsSngxwjIvM0CIETHop2KTcqjxpXabjfyuD9ghK/4BqorQnmqVVo7vMaxorLbaaLbbWDcC5C+M51+M5E45qAZRlv++RAaSine2Y60QlLBN7qPO4eLg94w3wyieGagRJbJlDAtHEAFpiTXbnpgjWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLiuJD3AEt2twRvOTCwJBhQImCynC3M1rWgvRUTf1gQ=;
 b=jFp9LdmdOnAeQZsQkbST5HRnkuS1c4a3xVIs4INPzyNIX6Ni65Ei5YmzeO69QoabqcuwCLjW9HC8oT5hThXB+85jm8gFNlXgHCu2OWxqZO9sW9KL9yb7MuY6ZDAi4eZnVdGEpXzRAkvDA2O/uxg7ej9XrKIVjEeAEEEiO2TghGN422PlxGSbmcFbwPyqp1Y34IS57anm/kNk1WmNyQ8R9NrRoPvBVZzpSzoQJct19ll06c07ZMHX2q8n8ue2L1xETxgY1AeG2NGwEji/3HJx7TOCukhGUbjgX6Z2Zos0FZLASL0Rbn8nZ/KjuB3+uZ0Nt5O5V7GcP6W/X6ODHfh7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLiuJD3AEt2twRvOTCwJBhQImCynC3M1rWgvRUTf1gQ=;
 b=dJufljn9N/P97YQLq8eANTWs/Y9d9EIuz/8Xs1D/a0cGp8W+HEoejXni1NM4/2MGRbevMa7eEBll6iDFULBil5K9RvHWDAU1etmqCfGodPf0nETz6E+tSCYLj5DLd5r9DJlC5WZ29gp02wLCV45H597X1VahOKZAjoQzgGc1Qu9igc0d1H3fGxgYBSP0uuEKxictmboO+sb1mAXzlYltn0XCqn9qE2zvEyApLdrnqqzJkyb3+tDJZdF0uCd5ovjiKAcHWLTUk3pZHfZjhKBYw06Sjw0zAV9WjaiyCQtcyU0zc4UznyfMfoU1T3rUJMcyUvk/foL47Sjz/4WudtVJiQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:32:08 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:32:08 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 15/22] vfio/pci.h: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:25:55 +0100
Message-ID: <20250715093110.107317-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ecef1a-ae21-4ab0-34f2-08ddc382781f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7D+PFkSn2/niDcdPT9U+ldChnFFocTCNfMmP0IT5MI3QqHDrjAkLuX3293mv?=
 =?us-ascii?Q?fpjcZWV8W1S5HuieT60xPJaMhFDPsnXKDgRU7W06W9hAzKV8mCBxWkheHbdp?=
 =?us-ascii?Q?MH0nYOdn+WpnLGckOCRVpAfbWzyo2w7UItAxA6DzvlX/pishTtvDSFAuUe3o?=
 =?us-ascii?Q?pkpmfVFp1XQYBWB9+NIRzZkG4vPsN+kh2NxuKsqZsakI04zo7bNE77rCmfJn?=
 =?us-ascii?Q?7Yah9rGnRTjC/QF6DhYWPDS3/LrQKOEeIUdrwoMGGNlk+3Qu8U2fMhTZWGzz?=
 =?us-ascii?Q?/DK4SZDl3KaRq6k1+7KcGM20SPo49Pt0PYi3Ijy2keJByXzT6V+axxzRYc+L?=
 =?us-ascii?Q?1kSrXi0TUHqS6YhiXeP1SvELDzRLfWHSYzYgyUy5++UYwFWu3XvDvCZfKaKL?=
 =?us-ascii?Q?pvuANUmzuXe3NqCqC7lKRQ57FbjMLd9GpLkDtMraPIYYl0Cmsxte/TLqJ8mA?=
 =?us-ascii?Q?Z9a22iaslXdvaonk/w6R1Z6vc/cnIwx2KW/4qtKb0Yf9Udr7Oa1FoFoAQjHr?=
 =?us-ascii?Q?LWBcwbIyhDkVoftHit/qEUMsuu7NjxUMBh4QbWXZWq7ilumyRoRYCcViFfSC?=
 =?us-ascii?Q?WSsCRSC+MpSYW0a9TPANodZ7oVk8w5i4+soeb7X04PKsxnPijWZZQhRT1VJo?=
 =?us-ascii?Q?8J/JYBKS3N5hjlieysb1ixEsXB7dlsxuWWYBYlBbMdtEudkL+TNKeFc3keJI?=
 =?us-ascii?Q?ckneytxtqt3bYon9UugHdQeTpTpI88BxEqhjOjyYgdo2QYNHhmi31nZvV92a?=
 =?us-ascii?Q?FrhpXIgWTHsZoUsq+F9uivlviPrGIvrIyc+YAmb289Clu012Hr0XFXkXtrK8?=
 =?us-ascii?Q?4zl5C/+P5RQQj7evjTG6iysuAezB60msuoOhE8JakQwrjwV/eRPl8ioi7Zq1?=
 =?us-ascii?Q?A5ZlRkFyfZ8Ikte4d+9z+ZSutScRYIeWRZAmghYl8OeN30UBG7N02JVplAls?=
 =?us-ascii?Q?xs5Hn806dh9Mjvx2IaJQId1QXDOk07BUknRIAnmVL/XTf7KCz/iMr87uv5Hh?=
 =?us-ascii?Q?TGRX7QkZFqD+cPyaRPAlpud3/P3tb00jK2HK1hPQGFLpQ7hy8SQTEDZdt5CO?=
 =?us-ascii?Q?odojK5GhLTOdEs4kxI+flup9ft5ver0jc0yw1KtTyfSxSL8drb93IllS1KgL?=
 =?us-ascii?Q?du7j9aLdRpAATbzBTr1Avh33hwZT6G89PFQnFEvJzHXHGYrsfvshlpX2PCL+?=
 =?us-ascii?Q?gtR1SxqQfugcGEnj3C7+z8cgKOlyaYAVVgJ38DLk3nbTyaMp2GA2ClIBKhfk?=
 =?us-ascii?Q?iNtaq+B16wa2N9C1gvm7aQRYHwm4R5NQL3vaAvvyw41zkVdC/Iv1YkacK+4c?=
 =?us-ascii?Q?RoKHxWS3jdFL5LnX1pSD80xb9vR9Ye96mBosNIG+nESmkZEqNb1cT9Oy3DDf?=
 =?us-ascii?Q?nYWzZA+soleNc7+NxQmOdPAynaBngjKnTHKXhxNG/UHmJz8/Rcqzij+5BVOe?=
 =?us-ascii?Q?E7Hvwd6Abkho7SRhd7JVdsJabI1W5JEEOXcInTenX3qaH0olYCukyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7tM1FYIfG6VbhzLbLcn7Ilc0vSrtRKnn0bN61/KbBSCjo5IiazdGG6R+ltWO?=
 =?us-ascii?Q?DpUKmG94WTQ+yIMCIwE7kCwUsz4VTOIyFcv/Ya/bhBCPguJwUMvrahCsPreg?=
 =?us-ascii?Q?6XjVcc8+VYJY6eWwi6NFCoUnD40b+XH2qMfjhc4C6tKphJN+HtF94NbN3fyl?=
 =?us-ascii?Q?qeTmTH/fLG7HBRZUrXxzmv1gqewipG8w4StdNjGhVcx7bYTHylmaeQuru40Q?=
 =?us-ascii?Q?2crpmojMCWZnQL3nSnyX6XdfyrVqGT7XCmuKWjkZr+cU/rqBjsGbjfvJ0CTs?=
 =?us-ascii?Q?usLD15rYrCfO0B/mhzce/MRHc7WFfudSy8N6IGsWBkmxP0HmD/XRGi0ecNFB?=
 =?us-ascii?Q?l344hTlvPK+3mqYw5p4Av/71dEnU244nLGj0S2jKeuwZxuMR2tPgAxxPsHjE?=
 =?us-ascii?Q?7fykF3C6gyMTq04jZXdQGMIv+Yh8QTfHeFJjKsf4gGEIMxjz+OS2UJcl0jnc?=
 =?us-ascii?Q?CJLxQlIHZXm1aEQS7MufTgF9k+bklnTc0sHWBgEjIQi8G8RqF9oCs2jZa2rx?=
 =?us-ascii?Q?V90iHvSys1326rC4OYMKqavsvUpkyuRY93g5zeWNPBmbEBwnLSMZdyDkbKKo?=
 =?us-ascii?Q?0GNIv5GtWINCy4+9HqZFZV5bFOJ2B3kOaM9cyFAD3+Gk8oLJXzRXvw6eTPWK?=
 =?us-ascii?Q?YeJbnm8x304CAHveUCMbTYX8Si0Yl9QqKH7PJGTyt2urf1dNcSGt/KQGL6K7?=
 =?us-ascii?Q?mFgamQ5RkrIKqI+DsWcavuL+wCwVFWl/NyArin4bgn9p0Tno6efsS70DGk+s?=
 =?us-ascii?Q?Rs1meAcx0oAJ2nrqD6jIoI1uFdKBdj0ozuCRGMt0JUKbai5e6ua0j3iYIOFN?=
 =?us-ascii?Q?8nTPFQIXiEO6/9xhZQ65w1mt+jMHrOaJiV1yBRSZoWG+ja0DiPglxueSMa74?=
 =?us-ascii?Q?wqa0vmGPkt0NtyGkfRsYdhsmxy7XOPmGHomlgWsGBtXgsvbOyrGwvv4Qntym?=
 =?us-ascii?Q?gF0LtQ3YMoufjX4YX898fCPgh2CG4SyG7Y6e4Dtizk7oRfNaMQDO9T/V4izt?=
 =?us-ascii?Q?0N0eI0Qb9/EFh9d+P027s7J7dQ5F/0Hq6+xmwp405+iJ3XdVEu0+kuvNXJwC?=
 =?us-ascii?Q?c4YkOC9hx4qYN6/t9k2FfKfiDc8oar1xYIpA+owhiUvNCQMfopEul6HJ+QiF?=
 =?us-ascii?Q?JxXJIYjPE2U5O4aWGnTEDPq9WrlLrjwQDBObNv5o541BaIC4HHLD8E0GCoYZ?=
 =?us-ascii?Q?npHsyqJbl3jo1QwZkPfJdTgZmlyQlPFx66f93o1W5yQXp0CEnV6Im00789Yh?=
 =?us-ascii?Q?7wPr07EPDjKBIVzXofsyJ4YooixUCFIi7HiLrZXMwXrEf/QeQPuF9ckOxSQm?=
 =?us-ascii?Q?5OBaoyTsL021HoYJP9Sb1JT1ZxbK25jpDYdPL3upGbU4XBwQYzFuwm8rSUm8?=
 =?us-ascii?Q?Rt/d+klIFLw3ucCTtteC54c76+OWGMxnZK1+fjkB0YURdnYIInnz9+Z6wHoS?=
 =?us-ascii?Q?PlASG7p/fWE9O4yCtjzLTRyKSHjho+eGAW50LyPDlAsrgMkcAMsOay6TRivL?=
 =?us-ascii?Q?Rnb7wVQ5hw8T+SsjPg+lAg1yK9ETWUBmWl9vPAmv7lRREb0Saeh0C6nUYe62?=
 =?us-ascii?Q?JfQbligxy2MFQmj1P12nUF9UyHEjUzTr6KrIBmU2m7mRQs69M8rl/FHmM51C?=
 =?us-ascii?Q?jCkpKxP9sZ91KCi4qePw4yUA4Cxnc8dAhzFiTUYbrtrQN8NOrmEnTcT4tYCi?=
 =?us-ascii?Q?yJ9UQA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ecef1a-ae21-4ab0-34f2-08ddc382781f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:32:08.5718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcVH/1M6F15fHB+MaAbTNdAZlZNvYYTf4zYI251PHCbIJYpKQd7s5eb65N3fUqZsJLluWqfhoTlEt6Rnr4o7OqMkL6NlCRSmS323uEZ0OYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfXwSnQIEjJhIF1
 cPSqtFfATQk9RXzBIgGL72NSXIZi3aJdYne9C8YfYVzG4b0YE7pzzw9F+GKE57zrLZubDzXfPLg
 vfFWUTeTc8Odjp3+dfzZ59WhKZyoHlSjW75+7A8msJwIaaFQbxqLhYYy4rNq20Qe11q/wGcN0hq
 kZNaRWtIjUjgonoOGrKS/v2OieEIMc8uxM4Ctj/mTj28XD9BswDtBHSud/s+srTHtEyt6ktdqZo
 xQsweHCC4DygRLRkRSdxIKs5blKlOjHGYVSqHbuLOrh2ZHL+7GEPI/YOHRDauzMLz4rpYycyxWN
 MLoDDx7iNQaamfavqjMvvoABzRDDlXSnUWKcGi7gmPujd+n7A35qz76fnz+9GygMaopZ7/ilLaf
 ZNHmMM9N+pxyAHJq9u5BBroq7+oeGjJqC7Oc+cLaMgrvJlAzP8hVcR3sNAPXzbRmLNLOuJvR
X-Proofpoint-ORIG-GUID: VogmM2qOEF2SqKz9csRXd2BNkDhUtW-x
X-Authority-Analysis: v=2.4 cv=fZity1QF c=1 sm=1 tr=0 ts=6876201f cx=c_pps
 a=iT0IPLB/rXRz/LGl7erAeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=lr1z4tAQMV6RJt3gFfoA:9
X-Proofpoint-GUID: VogmM2qOEF2SqKz9csRXd2BNkDhUtW-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
accessing pdev directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 16f092a0c6..c0c3d68742 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -206,7 +206,7 @@ static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t de
 
 static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint16_t class = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
 
     return class == PCI_CLASS_DISPLAY_VGA;
-- 
2.43.0


