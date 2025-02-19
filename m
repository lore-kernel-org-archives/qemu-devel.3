Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8C8C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOM-0003IY-Fp; Wed, 19 Feb 2025 09:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOI-0003Gz-U0; Wed, 19 Feb 2025 09:49:34 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOG-0007Aw-8O; Wed, 19 Feb 2025 09:49:34 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBVcSY008853;
 Wed, 19 Feb 2025 06:49:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kz3u18mEdU21JsXHlve7g/kWa7hW13gZEodmiWHxe
 hY=; b=Tz8QpMH9y8rpJjDBPgDO02hEduXc99o1hb1eSiSqCBdTGf/nS/lIcrLEh
 CmDUoaSeIa0sdpx1GkDNA8THujh+BaZ7yl9zuh6yc5zN/CWlM56CiZ+Ygd18rfm4
 p/MOTdDNoU49l7GLZAVkDC2pc+Q6tPi62a+e8vftsEgSh2ViYfVu/ZWKTkMZgMnt
 DWPfISlAjoHvGWH8onV8Ybi3tS+miM/M8xEZWJpAH//co/GEyDRoopDPr9HHIhlY
 WkjVe7hlHlAdBNp5K3fnbk1JCWv5emkuIxJtlKjecR2b2MfWFWi7KJa/tuJseWpq
 hgBLcgRnEfMvbAfKuuJ2C2Hf7ldNw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013060.outbound.protection.outlook.com
 [40.93.20.60])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basy8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:49:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efy0pf22cBbu+C6k4chphdK4rhC9xAzso/068DOLb3LzxfX4jsHqI52R9w7a/5DvtpumItvK4yLZ7CxwCeeGbLEv/vcICOXwYjpnOmI1Xo/eA468NDJc3rNemmnkHzQvK4sZd7HMt9Ax8wLdFEpYzcmqtINy06EezbRHMwvSgj0je08ZW5GyacTTN4xgvlnlAdVQILVKm8JJ8A0MhCpIkbnrN5YuZFq6wxBjbPCYUDQx4FCDATcXigFKJlww6EBPnGHk/rBWyKrEc9XAFXWqWrhayMzh9pXH5z7jPqAWp+iohx2FoVb9oNmnDkMyn6zkkWq4FhVTEq/ExhAh0kRjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz3u18mEdU21JsXHlve7g/kWa7hW13gZEodmiWHxehY=;
 b=Z36G5/ERnxZE8GrlRKLn69delAegfwyymHPHGuPq/HCplxJg7M5aI8ZWqhz5wN4y4BpbMuoH2oKbtavYXZJwF0xHAssGySAcz+XwMp/cLcco3jXKqM6M+xGMxV6fH6BpJ6HuYRRluXI2YFV9YLP4heWtizCRzIEyRlHS/QOPZGRnyGvo40uFs4xa5dJAu6QViMpWmOdJKULNmmWETJ2/KVVW25i7ABhyCN/e4pUlPdXCxZdZTsoBbPGUpzwYD4rBctzEnASDyLKKGyFEnYV++D2NZA6S/x/UxRC0ACUPm6BOXOQLTegxezDM/N0FAHUJcIn6HHz9f6BMZelTMxw4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz3u18mEdU21JsXHlve7g/kWa7hW13gZEodmiWHxehY=;
 b=qERcCwF8bV3ewyHp4Sy8aGbtlaR+Joscz967tetmKs/afcf/JqHIytRBDDuq6RhNEWzsVZuK9Uncd6QtJGMy1iM3r9xfMc6BGtHlhVAycfVj4r+DO+AK+Oa07jbMUDI5HyhZWioSOZWifEUNU60BozeaVhUPlsChVArcVv/FAe49wC0VUGbjBq1+HDkWr16+7GNxU4RrBxxkKadmHn07QOHeA4anlMkW9Uu/tciyBPXhQdwQeRP1hYID7rUcwU80DxV9EAWkuikHXG6u4v0HD38VQZlbeMZgmm8X2jFccVuyHv+JHb2uovcZ/GNOgdJQ7uln0y4jepwyDdoOiTvOQg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:49:18 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:18 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Levon <levon@movementarian.org>
Subject: [PATCH v8 02/28] vfio/container: pass listener_begin/commit callbacks
Date: Wed, 19 Feb 2025 15:48:32 +0100
Message-Id: <20250219144858.266455-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10559:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed5c253-d4fe-4e31-94ec-08dd50f49678
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ncpHu3Eqw278G/WHrs5z2rG9LpO5M4Y0vtll1RLbxrAfiKPQlcJuemRxxtJz?=
 =?us-ascii?Q?5t+Fp9vneDnRFlrTAkfRv8cmZvYZqSw4x26AEhj0mTyUas+HoliAINP1Z6Hd?=
 =?us-ascii?Q?VwsDYjSYU+8D7hfHM/dh9VSku5677ro0x9wMn5l3PSSD4skjlXGa9VWdVVn0?=
 =?us-ascii?Q?VWvUA+ar1wzFUrrcXBTbK5x1WhijPZq4Tms2GRptm4OWuojE+UIUnc+UvDnE?=
 =?us-ascii?Q?0Cese0DEoUU9+2VugqQWtLBZXVLQ086KVuLMWEY5WIY98Enyx8hD+Z28D/wo?=
 =?us-ascii?Q?t+D/gkJktzyP0S7jenJMzsOEB2f4AYf0GuwXvOBhLwNN01BVDhbmKWZgzmOd?=
 =?us-ascii?Q?cre4nvGUYJEIcZZKNdD6Uc+DOjQ+mYwZ3tJmJWRE/sUIPhPxdZfzcvRXimIg?=
 =?us-ascii?Q?n+Th+5UtVUY8qVfeAhnhznsmgY9ax4QIpUn/w3Re5i0HfLGxDbNs8MqJmHUB?=
 =?us-ascii?Q?dGn+wstju4yXb9eXCB8e1aRup2FzEkIGj5cbxp2Y4N+ErxpU0IZqPHQ95yu+?=
 =?us-ascii?Q?hK7wLPvAE6bERSXGNtvo4gmxgeJjlIuiyDoK0LCIsyIAwgEcSOLUm0ZPwSFh?=
 =?us-ascii?Q?92eCyyWwShM1ghXb1taX8j8qAIl4a/otxdJjwSRNuOLIuXNoLGAnvAvqNvuZ?=
 =?us-ascii?Q?lvaa15VEnnGunx42yQusTQ0ghmUOgvtP1aTSrpqthE8UwFgQ7+UEBjHhQy3O?=
 =?us-ascii?Q?kuUTXXMkkC9MVIDTuH/U+PmILfrGvaksA/iOdZM73E4WkYds6Cppb5a9JIhE?=
 =?us-ascii?Q?U/njX5LoqzyFRAUOuL8UDs+HLVBXuYj+7Huf1KNrxIhCokIjfP5zb2RMhzVs?=
 =?us-ascii?Q?wtl9jfWFZ36WoP/aGL3SnHvZgsQPkiO/HwCnnon/yvq32aAmINTkm/alyZwf?=
 =?us-ascii?Q?fXoxKjmpGEqSbCxP0IxytM3H4M4wYyGBgPlf0vrcI5YHVsFd5WkYwt37U7DT?=
 =?us-ascii?Q?q58ke+0jWKyTNxI5eBt5WD4EQu4cbgZFeWi+aub8tY1d3BiaZEajxQVNvvZt?=
 =?us-ascii?Q?7RUQtKKWJ1yWafBqevita3P1X/9qdq/VKmb4j4vHqHwOoFWuqFfHYkhpAlrg?=
 =?us-ascii?Q?8igN0l5ItsG58UjiZdMdbUmGbW7Hyo2KmMYAbA4pHrLaE6gFMxF1qV1GECjw?=
 =?us-ascii?Q?tgS8pksAK8iiibCtUiBdaJfQvg3B6GUuh5bE7mVB4ZBtvMwO4s2piyiBshaL?=
 =?us-ascii?Q?d3wRCFOtNJywGTaIKq8+i/UOD7mJE3WQlCvKpZ+Qu0IjwkYrqATFj0IcSD4k?=
 =?us-ascii?Q?OP0inQtXYSPjFo9qCwFfNRt7jSgzvmMxWqoCh7TANfSehq7dwhglu259e+s3?=
 =?us-ascii?Q?DXULiTeoZO9XcsZbvmT56BUILPiBNBekpC2R6UD87svSq5uLDEVcXcLYmtUy?=
 =?us-ascii?Q?c/l+QfA0fVc76efim+2HmLmeLOui?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qZfEYDMKOi+9yDo7gbEFAhOTiP+gj6qxXoNzUyMpFic7LcxvBlQa3BKm25T6?=
 =?us-ascii?Q?NWTpacGBN4NCsvXzeN4jAkFa/m9w/ZngbBZwSrM6A2/SUGoIxQFK4wyhqax5?=
 =?us-ascii?Q?Y6BFmy5kU2h7H7BPI3Mti4jkqxdgsk4hWsUIB9lRX+Ar7KzW0EkvGrAZFg8S?=
 =?us-ascii?Q?AGvEQZJmc9Hg+vO1h+luQH99dIjacOYnyUSQb/Ev64GcGQT1wAW6AvqrY03t?=
 =?us-ascii?Q?fP4uLR7SaAczNzoUrTI9THtJRTiyzUT9LVYgsOyPiTa/x035IDCwRUNyXfPQ?=
 =?us-ascii?Q?BCpBv9SSKXMrVGgkzBp2pNltYRmZ4gu17HXOuPqSAF+ekQW/X9F4Xv+5xO7+?=
 =?us-ascii?Q?eyelEGJOmGoXniaqq0gFlMZhCkJCf+409LHooPuPA0L6ggdD65DFav83mY6v?=
 =?us-ascii?Q?rCZxDqMoZwzZ9Cn41x8D3tkN6xdumOX42U6bj4/EP5xmZ9H/dpfdWhcqPmYv?=
 =?us-ascii?Q?FEqlub49zQNbRxk28F4eayjMDK3TprCcMLNKmN2/pvvixVxGdEzVwpu3tdWc?=
 =?us-ascii?Q?jNUiXqW3PLhphzw8Rm6JPipEml3GpgfinzBnc7nFJBkGkjA7CgaaaX5X4MSs?=
 =?us-ascii?Q?/4nyvqLkePlUtP1Xrh6PP26mTxDrThDZU3NRNxGYUeFeD3wzZCCTBAGtrOsK?=
 =?us-ascii?Q?uwbN+uoGkLIMlBr8o47JR1QTRObPvig16rPNZEu31ae6mpxI7Slk6oW+McLW?=
 =?us-ascii?Q?Ho69vC9DIVNzkmy0XQLrT03ITSoCMZJVXy4x8kwnIoPuX/GMHEJf53ZFC4m9?=
 =?us-ascii?Q?68oQP+tepe+XLaNbZ0DJDqAFfR+lphz4wovO8zdnByK9NjQO0koZ5XKvXkbT?=
 =?us-ascii?Q?c7ZB13oLQQq7YtK47Jnk5JGI8pFPLOmtBmv4/jDZ2BPUZeTmOCI6+fbMyVj5?=
 =?us-ascii?Q?j4+SUxomFJMGsYNV4F3PiXqXwIlcGI9PFxIdT4LNl/n8l7mMyhni7wBZNVL4?=
 =?us-ascii?Q?29FllE6Y+6Exm1WGjv/f+K1+UFCHE2K4FbhoDj80TVKXBnbzZN2GUv0/h+Rp?=
 =?us-ascii?Q?+H5WUxJVoTFyaiU/cfKougK3fJSjHUHg4jIxN26NGJ7JS4DaCEY3edTJWh5u?=
 =?us-ascii?Q?A3RYBcvIfGLkTfBvWYqmvn9ksV5MV5jmp+XPcUeqDsrb3Xb78gF3MYjq74Bt?=
 =?us-ascii?Q?Xrch3QQwF92ZIkFcXNFuAyNarHmeUkIOsPYaUXbEvvUvQnb+Fr/S5jFO5NZr?=
 =?us-ascii?Q?3tVm3Ijde4g8PhvFzXwdcepsQ3slCNQEHXGASied6AejS8cxhiFCshpGUyij?=
 =?us-ascii?Q?NsYCDxSIBRAYyT8BoJthZCrIDxtmuPXyzH7v8h7osevsakRbwmj4DPFK+eCZ?=
 =?us-ascii?Q?McYvL2rNlc5NGx+9FRS3mEmmiXkFhbgeOEn05SOAWe7Gr+/XxUhZ4coGyhJN?=
 =?us-ascii?Q?eM+jln4xQN4GNEjRKfdrfl9CJdzXb6r1/pv44VUybixb9OzyoMJUEOudYra/?=
 =?us-ascii?Q?nuM3+IBwIfIRV0XJN1X6tWXVZsHADU6ekmVOFO6jvGHorWDxtrVqAn4UWvpQ?=
 =?us-ascii?Q?xkQMi8uh17dFot/ODo+/QhRx0GS9D7PIJkbD6fg/dKNEhqQ5N63pSJFFgZwg?=
 =?us-ascii?Q?46SRw1c3+NHBDu6683Qb8dFCFH76M+TkI7jjpwyp?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed5c253-d4fe-4e31-94ec-08dd50f49678
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:18.4357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRQALOEq8xME3IKIs5ffsaK1QKSS3pkLenxDjf5xvovR3Kgi3m2aJGSIYpMyLOHpbSwERx9kwFFksGFWo1J9Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-GUID: eOULesTb5VjrgI3V1H_xtVSJGy6vRbGa
X-Proofpoint-ORIG-GUID: eOULesTb5VjrgI3V1H_xtVSJGy6vRbGa
X-Authority-Analysis: v=2.4 cv=d58PyQjE c=1 sm=1 tr=0 ts=67b5ef76 cx=c_pps
 a=4HTA/yvmbQxnAJvhdENERA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=RQZ_2NmkAAAA:8 a=64Cc0HZtAAAA:8 a=vU0vC_IIgwTtBsNJuTcA:9
 a=46pEW5UW3zrkaSsnLxuo:22 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

From: John Levon <levon@movementarian.org>

The vfio-user container will later need to hook into these callbacks;
set up vfio to use them, and optionally pass them through to the
container.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c                      | 28 +++++++++++++++++++++++++++
 include/hw/vfio/vfio-container-base.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8d3d425c63..6f106167fd 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -557,6 +557,32 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
     return true;
 }
 
+static void vfio_listener_begin(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+
+    listener_begin = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_begin) {
+        listener_begin(bcontainer);
+    }
+}
+
+static void vfio_listener_commit(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
+
+    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_commit) {
+        listener_commit(bcontainer);
+    }
+}
+
 static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 {
     /*
@@ -1396,6 +1422,8 @@ static void vfio_listener_log_sync(MemoryListener *listener,
 
 const MemoryListener vfio_memory_listener = {
     .name = "vfio",
+    .begin = vfio_listener_begin,
+    .commit = vfio_listener_commit,
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
     .log_global_start = vfio_listener_log_global_start,
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index c9d339383e..0a863df0dc 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -111,6 +111,8 @@ struct VFIOIOMMUClass {
 
     /* basic feature */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly, MemoryRegion *mrp);
-- 
2.34.1


