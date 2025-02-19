Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0A7C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklQI-0006Vc-SA; Wed, 19 Feb 2025 09:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPz-0005n2-2t; Wed, 19 Feb 2025 09:51:21 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPv-0007gP-Vg; Wed, 19 Feb 2025 09:51:18 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9MNpB023984;
 Wed, 19 Feb 2025 06:50:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VVfuLbKvyGRDB+8NToYZ0v+0jzdF+wvxukjmVQLeH
 Gg=; b=w5qsa69YYXJjidBrzfLLWPwZWzZ5MUSkWBST9jJX4z5mzsoV5PABTidgu
 RAiFCFMg7mJyL9OHXYsWcBcCFWbvkRDwIBNhDcCBN0ViR5e2QmBrVod4B6ZyTKgg
 iE9ZQSoMfQADOWEUDG3ey4VH/mVmnH7dqsRaPkGNs4qOnHyiaOAi8pv/2wIaZcvG
 +lzqejEmSkG7ueEST7JUYSzP322llu09f+mqEKvMh6SEqRpI92bdjDnn3s3ADq92
 d5x3yyDH3XLRDBlON/fCKG7GRPcZse5m7JmYGVL8c/q9mqGQQHhVKMIRDQArdvoZ
 sC2cVSPkdqwL17EHbbjVWs1awmkxQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basycj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPWnE3DEgpEkidBDq2bcGD/hKL1qvyyxdy0fgg6iA/FGSdW0XT79pYrvoO4S4nQicuV4Tw2xLyFd+5o3kt6SSmhHFZFwUl6ilTuvqN7HZtSypShzsHj0D2g+Nso5BQfEjUk4sl7xQKKx5daR85VDfeUnVffoYjSgO9U3CWZmJ0uhhsmMpAsAeL8QpXGTYNrdMjVv094pwtqJNS3yZv0HkCy5RcV9HaMcx8Y4k64kLIk/zUcqANFI33ITm90MTtoSLpfRcCmvYY3nxY8L9BIxXwALZab9YNEdnrnoPClBPuP6qkDhRkfsLPJZmknrICRNnsq/ufXdLbPOZm5iOgT/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVfuLbKvyGRDB+8NToYZ0v+0jzdF+wvxukjmVQLeHGg=;
 b=LXRtE7CLSHrymhQfCtIBY8PJyBtUAfmI0X03elh2lhPLfYr9pajMJok1qjkqmKID90xkakNtRBH4k/ePOh3Zn7l7GTWRjsvRy8o1DuEwjV/zI4GsYDttFfoeEXZacqwGQFzpPqzpSnbqPUD7Lx0afVvjBTkhBdkFwJU6HwYldKXS3gdkcYMWIgJ9awHbysAjQAq+vv//VxCKRYitD9oDCVtT6+LIItOlq34NwxqXjWVBqmqYQcoKc9MwsS4JFxX7b/E6Qcj5DfkG1rn1kZtkK5I7IkW+zAEj5Y6A3qmSzskuQieflUE0Q908t8gDFaXdTawfRH0+BzR9lZZVKuWT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVfuLbKvyGRDB+8NToYZ0v+0jzdF+wvxukjmVQLeHGg=;
 b=icdWuITG+O8oYV9/AojU+8XL+mTX4WUvDz4zFh35+cR++atHBdIC149a9zwFiHaUMMyQffXiFmnkWyRSevTAjVB3Yd985iDPYxPIRfonCH4tomIYPuqYB7BPxedwBuPh/Opbk3CtfbKOq00OqAmSnLsd6cWogZz9rKfhz4jfQxHq0EtualJ4o8ryTZkSuT7mxd4IpF9UB4c+U1ZC9zzldL/fhHRt6zTpMMIMoOQ4CZlrd3kXHXPSOIlKiwLY3hW7A+tkzxmYFqxKflIbKgcoKv1UmHI3LGPmjjlQSPeNhSdXSp81zEWpMfOoDaq7RA3a3dYihVLbxiPZakoYi3xGVw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:47 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:47 +0000
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 28/28] vfio-user: add coalesced posted writes
Date: Wed, 19 Feb 2025 15:48:58 +0100
Message-Id: <20250219144858.266455-29-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV8PR02MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9d199d-f5e6-44e7-f656-08dd50f4cb8a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AOBAh3nXUgKOhGtDNYMCpGBBKScJl0fCa4GLQzje5J0x6Q9nJXvEjr55j38N?=
 =?us-ascii?Q?h8+E8OmpXgS7BikUgJCZtxaGGMybRJGbngIu7BYn+gFkf+VHC05ga82wecwL?=
 =?us-ascii?Q?qdI9vDYO1icsRS5F9G6TY9gcbuWp0mgqKb9cyFZaehYyyfC+l317FCIMedNY?=
 =?us-ascii?Q?aqQaY4LG7xiywWEOPMAjHWSAN1CMbjbDqrzSa63y7118Hp6aTdkO7l1tFujz?=
 =?us-ascii?Q?h5feMYvptgaxx0Tbm6cTlMBZNyrdOn7OjcxnOGllA09XAsPyvs31bKwEgvu0?=
 =?us-ascii?Q?FqOzdG8R/LpFvX1VJpJJf6198cLc/1sWBLVZJHDqCPi89lWBYmU6Hv1xFx+k?=
 =?us-ascii?Q?JtQfZBoiOS4iOwNw/2mf7yJ/JCLgnFtB86ZP3zU6kN3rd4zge7uAhfOaDHgQ?=
 =?us-ascii?Q?KIpA+p0R1zNYq7xVUnwSqeeTHz19S/QO/Qfby03A+a5DPPOdnvpZIOzdDCue?=
 =?us-ascii?Q?NuHKg3UERlFrXEHgfdIaBkcHEbvfskQ35lmHK8vX0HqhXYgXWatPFc76FjTm?=
 =?us-ascii?Q?+/k9NAUkJYDeriWldTsDQy4lmb8JPUgDM3690NKfEzkFxZ28xPXlUlmwvxxj?=
 =?us-ascii?Q?ZFJKwvcyyw/kpFqIdzGPRForVB4NTaongeLq7D2xnl94uPfU/hgX9ke5rgeG?=
 =?us-ascii?Q?OrvBVCbl960HLmF0k0EnDerVG7seQgwGDDCdaGzi+cHKaL9zJxyGhbZs2Dyq?=
 =?us-ascii?Q?W+8h5LAyiEt2MASFuY61Sc/Icf3LfZaXHwW8H+UJN/Tma5hB6AHt8qNhsKTv?=
 =?us-ascii?Q?1TkZYUiiw5bAaKyz9rRy6Qf3wSdidyGYNKxQhE4mUh23GyVaSk3fn+gUfnoq?=
 =?us-ascii?Q?5pqwDVhMn7DRJyJtAGZvqD4KXDaNyJ8rbBzX8o65sUvxAhYvo6uW+gcaKvcT?=
 =?us-ascii?Q?c+XWMSBcjTp6I4aDtaG4aw/gJC8jC+GefTYXxqVYe7aEm4rhGjsJNiVZv0Hr?=
 =?us-ascii?Q?YPPL4Mw/qy9uKYv4LDVUdayvkoyVqZoBPVu34wzaBMCPwZ2cq0RFlTMmM+Kw?=
 =?us-ascii?Q?qu2bU8GZpnnrR8lfkEOUCMLsDkgvt2lSUIVm+NKavp4yxslrJ3X5Uq9eAGrD?=
 =?us-ascii?Q?7Q4aCwDjHzWlJy+jLch5qyov80pesCuGE7q5FhTvzJDoVqOjSxMyWcanzqcj?=
 =?us-ascii?Q?4bvKCDpbbgu1wYr9f0W8WSpyECrjYSroo4VpmLkmTvtwpsvnmGOfg7s0gW0K?=
 =?us-ascii?Q?8+epM7Mh1pLkNL8noshHHQ5QzthzzlSglLEvmDn4kqxuWHrdm4S8buh5UFVs?=
 =?us-ascii?Q?sskYUHdAn2l3tkw7P48Jv97AfbfCqny4lZAH8f1ZkY+nALRcOPk7GGV3uCSZ?=
 =?us-ascii?Q?bNE5wMkC50qzbdR8p8cKFYxiQiCQbuI7Wt2ZHjQrDNG7mycFs9FAi7iuO7hD?=
 =?us-ascii?Q?qVKbvwfdaY3gACneGshhrnLLa9rP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QKjVhNqCY2lzv0Ci6YiKm6ALfad1p7hymQ0efXaVQUJVMUQI0ZLqirwtwYIC?=
 =?us-ascii?Q?9yLVxhqLbm93bDIN+mNVWAOb41QQ1XVCRQaF22PEVTVDofVNDz6B7EqOXs09?=
 =?us-ascii?Q?CYcA0PHNQYWul6eHys/+7kmuAuPifiLzNvZD0CP/wT8JgSTM2VXMVRdA47/5?=
 =?us-ascii?Q?EK+PWc1cox9+zn8Sr5eEcTqxI++JlWpPLsdBy5AWY3ignbSKkBOFkeB3WOj9?=
 =?us-ascii?Q?a53lQZNiXI3tkcW18KrRgBArK1wJyvxsLHQ05gkid580tvbGopgVV0l/FMk6?=
 =?us-ascii?Q?rN7v8VcJbgQvGVo9eOIZtYNciO+jUdXzy85sWoG09X6LHomWmIOEBbiRg1r8?=
 =?us-ascii?Q?UzK7zUYN3B4eOwzqPXU6rxmRCUm3EnfFK3+Cm7ffEn8rRA7SAa2NpLCimBrk?=
 =?us-ascii?Q?9QyB6HRhO6tc+YSjTKb96KOCsDJ5Pcf2YBX8frWoRB3kmyFM0noQ1Sjue4xc?=
 =?us-ascii?Q?5NVZPOf5XZ3Z6/3O96PBC02Eh8pmkG6fjU4YRr1ULXmlxFuMc5gEPJmpemDf?=
 =?us-ascii?Q?S61F50uMAim+hvejiMWSYc4Q4dU5FJ32Se4GTt01AVQ3p5Z95W4EZl5V3gj5?=
 =?us-ascii?Q?kGVEF5dctIlrtvRmR7Q8AmmqLrKN2p9+t1IIvuCsETv9UGiZZfJf/Bh1A+zI?=
 =?us-ascii?Q?UlOizVk749sNFcRk0SMo0ETccdvq81c6uq/w61xgXwoCk9gCkw3UorYDkzwW?=
 =?us-ascii?Q?rmOnCbyO6uxCIk9A5I2NPuPAcYrm5DWIDLr1uzo2G8NTklzU3K6QmFwJZJqg?=
 =?us-ascii?Q?fu0amJB6h2QqJHrtwD0svIRkc5byS1sJD1t3iiBwtJIIkr6nqAfNWE2/5rCr?=
 =?us-ascii?Q?Jn45vNDBTcGHiA9tc5evzZjZE1GSv12XHX+Yvje1ctFVHngJfqWNvUfa0A5Y?=
 =?us-ascii?Q?kxgaMoXj8alai0z4Vh4PijLKSeTXjLvEZBZPBuvjpW4L8wilKy8AYBwIVSqU?=
 =?us-ascii?Q?B5R+lNDSk2WBUmCdhD/fVIp3wOrVdPIQ1UBUDrKYZI6xzQmOJ0vLkYQuzXxG?=
 =?us-ascii?Q?VGXKwaBgM9lH4ZU0eXyG/bd+A4amiUltCAn8gqIqfb/D3oR1Y4U6sv804Ih/?=
 =?us-ascii?Q?cFXIiOfZsOlYgWI79uSHaOuq3hQSA2Y30lTqnnGfRP/cHGLNQbhbdAYOg5b1?=
 =?us-ascii?Q?/Bt3WgstOW5VQmyyeiXrPRxCCnXjhacUXUZBe9SkViX1f2BA7Hq3EeuisN/P?=
 =?us-ascii?Q?PuuA3OkkRwEMSJrOJ3VzRheqr8H3cbATg/KFT6zRaqdjE3aCHQeC4bRy0H5D?=
 =?us-ascii?Q?gVEfOz9m2q6TV62ihitkV8A6dQsrGwXST37Htfkb2OW1c4vy1btcV4lN7T5N?=
 =?us-ascii?Q?Cq2sq1oD63n6Cdq8uZwllAzeR7fI4mv+5hhM9z+izwN6vkfjBjU96JdRDXDg?=
 =?us-ascii?Q?f9T1+wDoHXyKlku4r6xdJbik3pZIIbI72FPMNlb761VSHXVEhy2c91Z8/p6D?=
 =?us-ascii?Q?BfNQDVx09DHEj7O4f13lRiIZVxxECw3qn01yKE/IBHZdsWr3owJGwVgaES3r?=
 =?us-ascii?Q?RjdjRpCJT9d+Gm7KemodvCWSqlHR0DA4mdTqvV0nvP7eXWkjApqWMaRYU6ob?=
 =?us-ascii?Q?Dg1xkMLd3Ikj9sajaMhaoDQ9EkH33/W3nk5oi8+C?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9d199d-f5e6-44e7-f656-08dd50f4cb8a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:47.5216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvIawW2hYSrXjNfJkb9D7Tmlwm6q7nvfgbJvFdXHWeD1C0lKc7vgjTj5KwLbcAMCQadOKv+2pzJTUZrkz3ncpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-GUID: RiRuC0fzvSg13kVYajf3ojKaZywH7RF6
X-Proofpoint-ORIG-GUID: RiRuC0fzvSg13kVYajf3ojKaZywH7RF6
X-Authority-Analysis: v=2.4 cv=d58PyQjE c=1 sm=1 tr=0 ts=67b5efcb cx=c_pps
 a=YkRwJB1Lcas13D3J5+BQ6w==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=L0C8xICtdHRruC6hUNIA:9
 a=14NRyaPF5x3gF6G45PvQ:22
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

From: Jagannathan Raman <jag.raman@oracle.com>

Add new message to send multiple writes to server in a single message.
Prevents the outgoing queue from overflowing when a long latency
operation is followed by a series of posted writes.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c     | 131 +++++++++++++++++++++++++++++++++++++-
 hw/vfio-user/common.h     |   7 ++
 hw/vfio-user/protocol.h   |  21 ++++++
 hw/vfio-user/trace-events |   1 +
 4 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
index e44c8a2568..809c8e6614 100644
--- a/hw/vfio-user/common.c
+++ b/hw/vfio-user/common.c
@@ -20,6 +20,7 @@
 #include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "qapi/error.h"
+#include "qobject/qbool.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qstring.h"
@@ -55,6 +56,7 @@ static void vfio_user_request(void *opaque);
 static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                  VFIOUserFDs *fds);
+static void vfio_user_flush_multi(VFIOUserProxy *proxy);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -459,6 +461,11 @@ static void vfio_user_send(void *opaque)
         }
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, NULL, NULL, proxy);
+
+        /* queue empty - send any pending multi write msgs */
+        if (proxy->wr_multi != NULL) {
+            vfio_user_flush_multi(proxy);
+        }
     }
 }
 
@@ -479,6 +486,7 @@ static int vfio_user_send_one(VFIOUserProxy *proxy)
     }
 
     QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    proxy->num_outgoing--;
     if (msg->type == VFIO_MSG_ASYNC) {
         vfio_user_recycle(proxy, msg);
     } else {
@@ -586,11 +594,18 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
 {
     int ret;
 
+    /* older coalesced writes go first */
+    if (proxy->wr_multi != NULL &&
+        ((msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REQUEST)) {
+        vfio_user_flush_multi(proxy);
+    }
+
     /*
      * Unsent outgoing msgs - add to tail
      */
     if (!QTAILQ_EMPTY(&proxy->outgoing)) {
         QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
+        proxy->num_outgoing++;
         return 0;
     }
 
@@ -604,6 +619,7 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     }
     if (ret == QIO_CHANNEL_ERR_BLOCK) {
         QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        proxy->num_outgoing = 1;
         qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
                                        vfio_user_recv, proxy->ctx,
                                        vfio_user_send, proxy);
@@ -1119,12 +1135,27 @@ static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
     return caps_parse(proxy, qdict, caps_migr, errp);
 }
 
+static bool check_multi(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QBool *qb = qobject_to(QBool, qobj);
+
+    if (qb == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MULTI);
+        return false;
+    }
+    if (qbool_get_bool(qb)) {
+        proxy->flags |= VFIO_PROXY_USE_MULTI;
+    }
+    return true;
+}
+
 static struct cap_entry caps_cap[] = {
     { VFIO_USER_CAP_MAX_FDS, check_max_fds },
     { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
     { VFIO_USER_CAP_PGSIZES, check_pgsizes },
     { VFIO_USER_CAP_MAP_MAX, check_max_dma },
     { VFIO_USER_CAP_MIGR, check_migr },
+    { VFIO_USER_CAP_MULTI, check_multi },
     { NULL }
 };
 
@@ -1183,6 +1214,7 @@ static GString *caps_json(void)
     qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
     qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
     qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+    qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
 
     qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
 
@@ -1451,19 +1483,114 @@ static int vfio_user_region_read(VFIOUserProxy *proxy, uint8_t index,
     return msgp->count;
 }
 
+static void vfio_user_flush_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    int ret;
+
+    proxy->wr_multi = NULL;
+
+    /* adjust size for actual # of writes */
+    wm->hdr.size -= (VFIO_USER_MULTI_MAX - wm->wr_cnt) * sizeof(VFIOUserWROne);
+
+    msg = vfio_user_getmsg(proxy, &wm->hdr, NULL);
+    msg->id = wm->hdr.id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+    trace_vfio_user_wrmulti("flush", wm->wr_cnt);
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
+static void vfio_user_create_multi(VFIOUserProxy *proxy)
+{
+    VFIOUserWRMulti *wm;
+
+    wm = g_malloc0(sizeof(*wm));
+    vfio_user_request_msg(&wm->hdr, VFIO_USER_REGION_WRITE_MULTI,
+                          sizeof(*wm), VFIO_USER_NO_REPLY);
+    proxy->wr_multi = wm;
+}
+
+static void vfio_user_add_multi(VFIOUserProxy *proxy, uint8_t index,
+                                off_t offset, uint32_t count, void *data)
+{
+    VFIOUserWRMulti *wm = proxy->wr_multi;
+    VFIOUserWROne *w1 = &wm->wrs[wm->wr_cnt];
+
+    w1->offset = offset;
+    w1->region = index;
+    w1->count = count;
+    memcpy(&w1->data, data, count);
+
+    wm->wr_cnt++;
+    trace_vfio_user_wrmulti("add", wm->wr_cnt);
+    if (wm->wr_cnt == VFIO_USER_MULTI_MAX ||
+        proxy->num_outgoing < VFIO_USER_OUT_LOW) {
+        vfio_user_flush_multi(proxy);
+    }
+}
+
 static int vfio_user_region_write(VFIOUserProxy *proxy, uint8_t index,
                                   off_t offset, uint32_t count, void *data,
                                   bool post)
 {
     VFIOUserRegionRW *msgp = NULL;
-    int flags = post ? VFIO_USER_NO_REPLY : 0;
+    int flags;
     int size = sizeof(*msgp) + count;
+    bool can_multi;
     int ret;
 
     if (count > proxy->max_xfer_size) {
         return -EINVAL;
     }
 
+    if (proxy->flags & VFIO_PROXY_NO_POST) {
+        post = false;
+    }
+
+    /* write eligible to be in a WRITE_MULTI msg ? */
+    can_multi = (proxy->flags & VFIO_PROXY_USE_MULTI) && post &&
+        count <= VFIO_USER_MULTI_DATA;
+
+    /*
+     * This should be a rare case, so first check without the lock,
+     * if we're wrong, vfio_send_queued() will flush any posted writes
+     * we missed here
+     */
+    if (proxy->wr_multi != NULL ||
+        (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi)) {
+
+        /*
+         * re-check with lock
+         *
+         * if already building a WRITE_MULTI msg,
+         *  add this one if possible else flush pending before
+         *  sending the current one
+         *
+         * else if outgoing queue is over the highwater,
+         *  start a new WRITE_MULTI message
+         */
+        WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+            if (proxy->wr_multi != NULL) {
+                if (can_multi) {
+                    vfio_user_add_multi(proxy, index, offset, count, data);
+                    return count;
+                }
+                vfio_user_flush_multi(proxy);
+            } else if (proxy->num_outgoing > VFIO_USER_OUT_HIGH && can_multi) {
+                vfio_user_create_multi(proxy);
+                vfio_user_add_multi(proxy, index, offset, count, data);
+                return count;
+            }
+        }
+    }
+
+    flags = post ? VFIO_USER_NO_REPLY : 0;
     msgp = g_malloc0(size);
     vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
     msgp->offset = offset;
@@ -1473,7 +1600,7 @@ static int vfio_user_region_write(VFIOUserProxy *proxy, uint8_t index,
     trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
 
     /* async send will free msg after it's sent */
-    if (post && !(proxy->flags & VFIO_PROXY_NO_POST)) {
+    if (post) {
         vfio_user_send_async(proxy, &msgp->hdr, NULL);
         return count;
     }
diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
index 9acf634ca7..96efc32bd7 100644
--- a/hw/vfio-user/common.h
+++ b/hw/vfio-user/common.h
@@ -80,6 +80,8 @@ typedef struct VFIOUserProxy {
     VFIOUserMsg *last_nowait;
     VFIOUserMsg *part_recv;
     size_t recv_left;
+    VFIOUserWRMulti *wr_multi;
+    int num_outgoing;
     enum proxy_state state;
 } VFIOUserProxy;
 
@@ -88,6 +90,11 @@ typedef struct VFIOUserProxy {
 #define VFIO_PROXY_NO_MMAP       0x2
 #define VFIO_PROXY_FORCE_QUEUED  0x4
 #define VFIO_PROXY_NO_POST       0x8
+#define VFIO_PROXY_USE_MULTI     0x10
+
+/* coalescing high and low water marks for VFIOProxy num_outgoing */
+#define VFIO_USER_OUT_HIGH       1024
+#define VFIO_USER_OUT_LOW        128
 
 typedef struct VFIODevice VFIODevice;
 
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 6bc5809cce..98cd0e1920 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -40,6 +40,7 @@ enum vfio_user_command {
     VFIO_USER_DMA_WRITE                 = 12,
     VFIO_USER_DEVICE_RESET              = 13,
     VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_REGION_WRITE_MULTI        = 15,
     VFIO_USER_MAX,
 };
 
@@ -73,6 +74,7 @@ typedef struct {
 #define VFIO_USER_CAP_PGSIZES   "pgsizes"
 #define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
 #define VFIO_USER_CAP_MIGR      "migration"
+#define VFIO_USER_CAP_MULTI     "write_multiple"
 
 /* "migration" members */
 #define VFIO_USER_CAP_PGSIZE            "pgsize"
@@ -219,4 +221,23 @@ typedef struct {
     char data[];
 } VFIOUserBitmap;
 
+/*
+ * VFIO_USER_REGION_WRITE_MULTI
+ */
+#define VFIO_USER_MULTI_DATA  8
+#define VFIO_USER_MULTI_MAX   200
+
+typedef struct {
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[VFIO_USER_MULTI_DATA];
+} VFIOUserWROne;
+
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t wr_cnt;
+    VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
+} VFIOUserWRMulti;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 7ef98813b3..64fac9137f 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -11,6 +11,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+vfio_user_wrmulti(const char *s, uint64_t wr_cnt) " %s count 0x%"PRIx64
 
 # container.c
 vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.34.1


