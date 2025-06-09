Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEEEC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 12:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uObCD-0006zJ-Tq; Mon, 09 Jun 2025 08:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uObCB-0006yA-KM
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 08:01:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uObC4-0005Tf-QV
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 08:01:42 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5598Qkql003503;
 Mon, 9 Jun 2025 05:01:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=u2JibLQgfnJx4vW
 z/Ai+ERhHmIf64UdGh/4ovQ1+mVU=; b=Ys5Ff6tfKa9hAE3G8S1Y6jimUzsSdPL
 cUuJU21tegKT/+yb+0Msn4uOydyr7NqbyDa1lOwcQtXQcwhtiqbKswSYBWe7mrt/
 UGLQ9zPj80tlMKRYCOV0veTS+gxS2AudkBqR/3+5nO3zvur28exop98uHjfWIAR4
 g6ADnshs6SW7w2+YNHs5vE5UyF5bxpaDCnARMYaY3h2QnwqcECk0l/Mlrhdr16Oo
 PN3Ev7MDdZtvgaDMO0Uz93/1GOGNBwmOd1Yh4X4oPya+O4VH3EhTJn+gmQWyrA9t
 ns78jqsAf9nRdH6NoDJNjr1rYEOyxLSglx1fFFD/klcugsZ2x0vHzfQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2118.outbound.protection.outlook.com [40.107.244.118])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 474sdgarb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 05:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUbr6ThEw6UiEilNBoC4avfhBo7gF5WVouMYmkGGh97+iB+xZk9wOMp1S25FrNmoNFL8bLnJ6vFMAwKt5mxjmsgr09oDS7WK/JU6C4dubzrlz5tACHSNEpsc8D0Z4wy9dxrx5ibcBOc8X7gdOBwqRLo4Kb+qNhddRsmvASriv0zICYXGU3tXk31q0jSOm6jNQ9FlT0m1jMtme4xSWqIZBNV70QE8Zd7+FUa5WKRStfT3JSI0T2YVTkojBAiRZT4Mbyb0zeV+iptRcmU9FkseDJ+G1l/n68nZDg4xVXVOdicSbAs2XHULa9w8shd7/cTxrsTSK0vziD4sunX5s3RohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2JibLQgfnJx4vWz/Ai+ERhHmIf64UdGh/4ovQ1+mVU=;
 b=MJ2XO12Vi0WlY/NTcSAoPqdOApOQgemGFZwKNH4LKC1mduqZxYsa/3HRiV2Bt85rIZ2YVV4aW8yzhx/bCw2rQAaV3nO1ztZkCKnGB8oQHBndBokREd/d4Aym/HJ1eIJ6zBCMA3AlLanfHxPn/GPbeWR7goAoeVmWUFeeOtzRGy3XGTQSLvD7I9CGxr5NjRh2sZKNuwfbgRf1jZ1kfCO7hxpHGkNqmz/tFz3CQJTphDEV9nAPlhSSqavQtUxcBIaPJBTLuws0gdCTMG17hNfpg+GbUJZOq0WvqNqEBphXkf+ZqAEpbwqHf/g9dDVpaaGgeAtXtnurDggRby0/BI1EIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2JibLQgfnJx4vWz/Ai+ERhHmIf64UdGh/4ovQ1+mVU=;
 b=mJz65qHgTQl4wokKzUkX7RnptkBESk/rZhIyH5RCvtfkFqyWP2Vd3VKDqTodAvhL74uyYEJs6NTC6kZElk5E/E1W/5m6QTJbFeG32zCRi3yX9lOP6y0q2Q0HwIppEEK1Hhzv0luPijWqG+bFtvOELhv68oFTdiqk+4RWfiTzzSerM0/8gWVdT8buLP70hIZJI2ZkF7GLL5mR9ycmoqWiuaZdg64dmo23zP+4Ybv7rQ2/aPhvdyvlcN7bMwdlnJaTGeRActK2Zy0/8GkXyCrdwbawARn4ri8zPZxJ6VCOwSN/6ykCco5HN7yOHu1Fb+u7A5K4bc5s7XPLPbsC+hO7uw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH2PR02MB6871.namprd02.prod.outlook.com (2603:10b6:610:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Mon, 9 Jun
 2025 12:01:23 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 12:01:17 +0000
Date: Mon, 9 Jun 2025 05:01:13 -0700
From: John Levon <john.levon@nutanix.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, chao.p.peng@intel.com,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] vfio/container: Fix vfio_listener_commit()
Message-ID: <aEbNCd-RPr_XKjBW@lent>
References: <20250609115433.401775-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609115433.401775-1-zhenzhong.duan@intel.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR04CA0066.eurprd04.prod.outlook.com
 (2603:10a6:208:1::43) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH2PR02MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 97fa94d3-004b-484e-4dc6-08dda74d56de
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QHG+ZGBQFHgPOzDvBbnD9rN2hGAlYWGL4LRhRxe+iVjhzgqDYMdZ0mgRLmOS?=
 =?us-ascii?Q?vLWP8Im/93muw4tiu8sgBYYTHsfcPU3qC9EZFcVuUYxceAAdLH5AlYElPDGY?=
 =?us-ascii?Q?YFZonM5YUhSCXiKl8sPMQfelz2KKatZfn1/jaVxGJCqkC5aBaSM8NQl0NggG?=
 =?us-ascii?Q?TqPy82dJkUHVgqEpG5P4V8fF66N+z8B2Jom/Hp9/xpdes7xmVxJtcAKfRLQD?=
 =?us-ascii?Q?WcXNUjOU5518+NxvNj9hIkutBF94EyTdwolpodvkYozR+SIdrjmqrelv8iFZ?=
 =?us-ascii?Q?xWNnCOj0rBeV1cJ5Rl5r74BWh6yLYhtLacVVk+RNOPTFztyb5pAXXVwYRsnT?=
 =?us-ascii?Q?AlYGHwCUjfRdXuE9Qkc/4VylieovrS/dRg3j1ieC6aU9fSJwZt/JBA0nJlsC?=
 =?us-ascii?Q?4tXHrrx8BbuU+jP1WMHac+rhmEuXs536B3pZW/0uGh1MObAhmu2oNhUkyH9F?=
 =?us-ascii?Q?jM0k7FmekZCbEycj1CriCyQlHF3SgbV+zAh394YGfTS5eUtdAJQuoLNbTZvN?=
 =?us-ascii?Q?26NDADP+QToWl4KQIAjusexpXW+F6L77ZYY1Qt85bcfecVcXBaBpLQT/rysT?=
 =?us-ascii?Q?g0wtTTne2mq6lEBTZg3ij2uxAtMVeg8jOrE1jlW3uvQTVTrVgnWEDuTHh6ce?=
 =?us-ascii?Q?sCRk8OUhttZLPtJ7ONynpLlTbQKhmc4jRoJAlTtWD/WuzM5DvlZ3QTxRMhfK?=
 =?us-ascii?Q?sdmI/5yZXn2jabQnC81MIvBUA8WBTzF878sDwgFgEJqgngeSXIoB1lfZqfnt?=
 =?us-ascii?Q?dbmhkwyTuf9fWTWnRGrA5yINDkAcQez3VdBCzZzYsqFtS4ficMuM7Ka3oUOa?=
 =?us-ascii?Q?vtA9HcmwzZ+/RtFVrc2/sj+msNIoyh5faKtU5RR2zHSt5oOYPkPrnI/F4oGM?=
 =?us-ascii?Q?ul7p+SrhMLyuGTA4kJdDzTP/oJBqGrUUldwgfmNwX3Ck4L0CXcKgYzoe0J85?=
 =?us-ascii?Q?qHM+D2evWX0XrVIGJZAzGqvPoWoHKF+EVlam80wZI3P4ZjUiWBu1uDKP2TfQ?=
 =?us-ascii?Q?PjcHA5iPsClR6aARAfIHCOc3jSTHKJvNp00YPPv3SkrhtlmTDip57huHYeX8?=
 =?us-ascii?Q?80AVG2D+fY+jvRABEqxY5wv8JUazZlP7qUjPMSuJEYbqKi/Z4B2YnXZvSQSa?=
 =?us-ascii?Q?BIuO4TMdlvW1cY5IuluZhe8g2YGJrr2fKKldRQEcaAvgBWxXyWTp7RY/FYSr?=
 =?us-ascii?Q?JUNBMse4jwbF0RDO5oyAwCYAKMVLOecNWsEosi9BQs2xex6yPOK3CNfwaQlZ?=
 =?us-ascii?Q?7v0p1VUSJVFnrZEYg/jxAvW65e1hxgFdqnN7CShu6SMNwuaOrHd4Xcgj+u8u?=
 =?us-ascii?Q?BjqA9/aPqfQxiKFmBYcR8q+qDR1G4iWN27RudJ3ri9UH25sLVaAcVfdURYyL?=
 =?us-ascii?Q?16aRyGVYAPCGsubxPlnyZLAO5h3j+Dw9degD7+ya226c/CheThG14VSyrsdx?=
 =?us-ascii?Q?jpedZgFrH7g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v9sY4rwylG8QSicwBkzqkbB5Lmz89IqsMAmYOPn6fzl6PznxQGjC58N67irJ?=
 =?us-ascii?Q?pjtJJmhCstNJiu3lXe69XWMbWvEVbP+fktbZuWiBM1na7UHxI0uf0zzJsHRj?=
 =?us-ascii?Q?Dv5JufdU/Qvqlkwgm1Fn3BqsiSO+quhmoabktiwjU1LDClUkoywpJP/WLRy1?=
 =?us-ascii?Q?jxCbmwdfOVXPbny9WC4lvkxcIHuldSud0UcwUDddwiWODPq7zEKxrTwgU/Oq?=
 =?us-ascii?Q?1mFAO8vHMLITEF83ewGKFU3YN0EA4ZWpyxOpvNAzeuWv4C7U0kUjftqcvwj4?=
 =?us-ascii?Q?BDNdZUDL6Hqq9ty1Bu/nZd5I/R7iKpd2HoapPWGH4cKSJDOAonNOOF/5Rs7P?=
 =?us-ascii?Q?TT+FjGCi+EvP3rTLRxq8Z3PuCiPfJUchIqpN5fZ9UJgk3AQZ72CBD7Mh0f6g?=
 =?us-ascii?Q?IBZfQCtdhHE3d6MlAdgS9cSWbDvxMVQS7tF+Ce543Jx4mxxtvFN9FgCJIXP8?=
 =?us-ascii?Q?YjyPlpD4ueEbWW5Q1LhZUy5mqcgfZV5o1SFxF7L7scwDlIJf1meHdvMOPUKG?=
 =?us-ascii?Q?IuQ+7zjmnvcDUDr9RSHIoRTX3WuUtWXDOclYuCAEUTbH1Qai/MWhHYqyLdZo?=
 =?us-ascii?Q?ncJcuU7xZ6lfGwxBa1TFvh71+oQJa+GKE4vVmJsjZaEwHDbipHChXMHF/1II?=
 =?us-ascii?Q?zD4A1Y8YwYb9DQnJqNVl7HxtBzDhq4e/gPtY+KvQm2Lrw9COgbkQcQD1j0Ic?=
 =?us-ascii?Q?Rc2u+JN6VZJRnyzpGmUTrwx9JcmkgK3UHh7IBiTLUKm0RuAghc+Byr6Fw9c3?=
 =?us-ascii?Q?vg1o5Z+jcRZE2ZPOVcovpVDtmxmpXKa8vphAg270uS/eoyS/3ANxWujQN0G7?=
 =?us-ascii?Q?96aJU/bEh766Bux7Hh+48BFkd/wX/x1FVHDFNRnYtyYxtRxYYjeIdBjy/BHZ?=
 =?us-ascii?Q?BOyV7q0Y6+6eesFVRCRLglKQhUjYbuT80GKSgitfABWLHp4HyXwsHeqm7vyS?=
 =?us-ascii?Q?vC4isT1vUO/ZlBjgLJK/PGKoXWuq/x4WRcwbBgXB5ddQQT7vaRZ8mByYnAwU?=
 =?us-ascii?Q?AkWLzDcAbb0y/6SiGNcFTMVjNctCq3wLhzmwI9g3QCwcTa8JKFCeG7sogTgM?=
 =?us-ascii?Q?st1ut6H9GqBx3vG4C2DEUf1gM+0+wANdW9/vzXyDVqLqfztvPoURyurMR1OC?=
 =?us-ascii?Q?Z93vrrj63lnJnW9uvZBNHnLtJa6zuElpWcEWwZHCt0gxeN0PaGr0cAKEHrXK?=
 =?us-ascii?Q?nLIpqP/wTmNQuQW65jxIo5u5gksFLWo12HsHL59IJGtLFvenaAqlc157gJ/c?=
 =?us-ascii?Q?RGPAEYQ7So/3lCSCOzQtOdlrJWesyOoR9KHCoy5NirpBLuuUrrloNuv2u7m7?=
 =?us-ascii?Q?8yWlQ84aXQil+2JprAF1Z612L+R0wOopkZtUkY62jmmTEvJ+j9847vIRwchZ?=
 =?us-ascii?Q?NOnL1dh0gOqdGT2TgjiqgwPPtTtf8GA6uk4cUEzkVLVehtKKCjE3/yWiqZ5f?=
 =?us-ascii?Q?9iTuzOWwd7iQCgje3MzemST8r6mdHVD3r6i3Gu9qoB57kqaCfj4tUgMTWJin?=
 =?us-ascii?Q?iXkjMVgbNb77tJwplkiZnw2ViMnG+r4BMuz4pdd+OuUAKE050dyhw/3xcf5n?=
 =?us-ascii?Q?OpEj6G3SIQTexUy+dcX0LtR0u12ndzmDnSs1ipo7?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fa94d3-004b-484e-4dc6-08dda74d56de
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:01:17.1154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyXhiDbdkbmiBYGJIPhnw7ZyOGCqrKIWRJkO7cPRoTkqboGpqu2mkeJhXW3950VePyMghLwDm7/lXlzGUDiZvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6871
X-Proofpoint-GUID: PZlgsUtLJNgp9860R_z5FDC63huF1UG-
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=6846cd17 cx=c_pps
 a=kYxjtQCH8jYJXwz0hAM5nw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8 a=bW6W4euIG2zeyCu8l1YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: PZlgsUtLJNgp9860R_z5FDC63huF1UG-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA5MSBTYWx0ZWRfX6L5cVZNBKTjG
 cGnTXjEc/LILROCJusLlK+k+qG0dGyKGDy89EPdgCxEA3Vm08/SO6FjVTkxOQBz+qsBCLKcLZc+
 CDvLUBk80vPPGoVW8QkX4dPkvbVFrgO28cyQ+Kn4MRSxx7X3+pBxk4EzTlf/6Z1Smw1/3RbAt3N
 3TIbOHtnddR0fnJ/Sv7aXgzfIy9u8HhzY+zHI7gWgy6oWHkcuroEZ1cNItOd97m1sBjFh8DUpmr
 wilUmCiCFQrL3i4empFLk1yQwj7poX9uRuQDZhpr80R9j0Yrq5H6gYOHNRZSen3arlaC0OM7R2L
 pKmcvEs0VBr6DhfW2ysQsAAjb5QyaTvr1b+zBLYJESZ1ue3sUWOVWvVNA+MKArBEQ/m1GcmpYlY
 15jiGXSqdDdbEbIHBeN4jqZVnSvy5pl2jmX54vTkJm4rg/1XpFAVM52LmOsiL/igSYq6w8E4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Jun 09, 2025 at 07:54:33PM +0800, Zhenzhong Duan wrote:

> It's wrong to call into listener_begin callback in vfio_listener_commit().
> Currently this impacts vfio-user.
> 
> Fixes: d9b7d8b6993b ("vfio/container: pass listener_begin/commit callbacks")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

D'oh, copy-and-paste error, thanks. Somewhat impressive this didn't show up as
any failure in my testing.

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

