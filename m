Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F3BC7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFO7-0004fQ-9f; Thu, 19 Jun 2025 09:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNq-0004PV-AI
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNm-0008GW-8U
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:49 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JAvH25013023;
 Thu, 19 Jun 2025 06:32:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QxcXZhSRAeQ7QaN/9leAb3bkGCeXKMOPqXIAf2vlf
 CE=; b=EJs4u0AUw6/+ntFOTuRY20gh1JDkLwFADqrG5D8ZJ52fE0/ydmtpp7LS2
 EtHiZIYFiLAuMrmu5rIAjxQ4Q6B1QAT1EsJzx+MHSh9EpYEyhp0BMQkzmqmSQ/O7
 qZuiqj73qgY36PGZYpAIBaafU0ki+LmNZBTIFWU9nyEtM0j5p1IWrWcEUsbv0IN7
 nIxFtUmJYZcXmniXNrC1LPwYtPSJNfIhrbRLQbCwY3D/8TbnyGZSeIi98Q1F8kvI
 LuOu/KAEb3Xiy//kE9xH8AhRIu7qQPnXfubHMjccnt4ZjhIPz2SEvkV4ttGHaYka
 5sHAYXwCm38Ot5eg53uLBZnh5MiFA==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazon11023091.outbound.protection.outlook.com [52.101.44.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47976j3rag-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSj5JHUmeZNy7QTRAwWorTu4CIuiVv1EkkAimlObIWeZW9cn5eSKQjsIaBbdQP+ILSUAKFuAA+lwgTGr7pkOWmLGsknntqNt++gRwkc5Is7QJf6E9P8hTwTCl9+296qxW9Fy1CaIWiAfIPwX4NX31SxOWjBm/SGHX4jwwK3PXyXCtrqThNmA8xi0YRtmbUBEA+3sjSLcvVdLq8nvVscHFdZSDuLarHxd569VVAe3sTqi0KY6WjjeeRE1l64JsJNveFwQwB7VUtkgOcYP1lWWu13HBZP/R3n+syzSu0KF9kqEMHRPBSpJlGBbxHpnVqjUZGvn4llGz++SDxrbNV3xYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxcXZhSRAeQ7QaN/9leAb3bkGCeXKMOPqXIAf2vlfCE=;
 b=BmPkKWEXb7h72xe6dce6S0omu5WCtvrIEBxxmDO1oz0m6g6cmq8YonvFoX7ybjIr5AN6UWOAuJFo8bBLhWETCZgZVmeHrM1ftNiMGlYwgw4/rHc/Hh4BgS1+vL4P/Q2QqIwqrxl0CRpvYVDgfXwFYyXRChUxEUr7NMOkB+5ZhaHFxEDbFNHOgwx/+ev+fX+iSqOG+aPMNZytZcEzCLDmDS23OJ1gt2+OjZ6G5f68BD+NZ/7GJ5ClBtumhle+ZnF1VCoH5kjqvXmsFSOKNa7IZtpr2jC88nPfg4DWx4G2s5qIg73tidS+sJWtMMBZbvVprqhiQyBhvaccw8umupbc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxcXZhSRAeQ7QaN/9leAb3bkGCeXKMOPqXIAf2vlfCE=;
 b=j8o/d8Dtzj5m4iAhu3z1AxnCRs0tH5yHxvr3/Oj7pcKu2Xn2RB6Wc3hybrm01ybD/G7M3mRfOovZ2VKyDizy22mxTXsW7oWfazl5Oppy6mFQS9yDMY3MuixkndsOriiWbc4/FvNRETMuJXssz/kYcEHsN7UCxtE6ba5h/E4OpsYQl5uqvRB3yxERlisDlaP99BepAzl+2h+fYLwfKWOEtwj2pkDapmFnSN+UG5NijCzi/xWL74lO9EpAtDWTckmVvh7vINiyuEI9H481eabrSYzosSHRFAZM82PEUCbb08tct7/wnjCFppX43iGhcRb52F9a9yK0HjY4MuFBIlvJ+A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:38 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 16/19] vfio-user: support posted writes
Date: Thu, 19 Jun 2025 06:31:50 -0700
Message-ID: <20250619133154.264786-17-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6704c8-e9d1-440e-311f-08ddaf35c1bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e17mp9OzvRT5N2blCEO5NuJQYfyIBRfzkuIG7dITh5lG+ukae7vZqNNmAdFZ?=
 =?us-ascii?Q?8+bDrvAg/nKeAQ45k+zleyMlLOcmf9e7evsCkRLhFJ4CBnJcTeDBuObU7hME?=
 =?us-ascii?Q?X3FEZk/GA+JVf/QiMeHlTqZIjMrlSwqRvqWGRj2CatkY42bpq1PCPjW4zyfL?=
 =?us-ascii?Q?x7EwY8eWT/HlpSj1dnb5OKspljfiZ+gXcaduTHCiBCyFpMh0fSYzd/zi6I6O?=
 =?us-ascii?Q?QuL755Z5XOn42yASGJWijFG57PWn/JLD2rKQBbZUMX/okwzFcSzdQM4kYKcG?=
 =?us-ascii?Q?Ago1YTVrIL+qNQS/MGAgiLXBCBdxDRLlaonnyjUiml9MckCFuCfKG0iCHDa6?=
 =?us-ascii?Q?RiVrU8lcYV+Zc7iGsNKz32QRFuNpkHJFBQZAA7TNFkS5WiPAKfNFX1Fda123?=
 =?us-ascii?Q?ZXgdL0xGeKWeEjTtVdIxrP/uyiHvzjh4Vtcw4i20ZkclREq32ORWszxHHpdJ?=
 =?us-ascii?Q?Q8PyUrBG2jlAopQ02JMCNbmvNHjL0BSj1u6tS7zmLgzLot7xv3xyBRppOT7F?=
 =?us-ascii?Q?ocU3yiiQZR/PYhO4HQITd1gno2mF7bQ9yjxg+Zd7yierJ9IG+gJTuDjLDmR0?=
 =?us-ascii?Q?/z2V86h35qyaEOQPzTY+YlQAcxnE1Ki/Og5ZLQEmHrN/4GKAhOYYONkWyL2/?=
 =?us-ascii?Q?rsMaU/MWfRhbibheUL57msfPVx3Aciiu+okY0znKAR96VQA52YrIan15t3up?=
 =?us-ascii?Q?U4vObYYhdluJGS2tRVtD0h5oVbfKcOkfNP3Br45h2dCB6ZxIh8qF/uWE3D3r?=
 =?us-ascii?Q?9g1354pBJNWSsUQ+E2akJofaIW4thyk/DmQqhfH7pdir7/xld4V4HGJ9zY+2?=
 =?us-ascii?Q?QLHR8QhdL72FDqjVc4q2ANupugCY89UWwCA9jvHOrneTFWRE6Q2iWW3Y55je?=
 =?us-ascii?Q?pvUWboByGOwNoh9t6xug7+1kEgejzLRr+qvV+XDv/ycgvA6wNS2BMjQElcV0?=
 =?us-ascii?Q?2VZnFek0zQl1JqaoUDAPFRb6h4W5e3QFxpqb1sabyo61aW9T8YnEKIPLd04q?=
 =?us-ascii?Q?KIJfEb4MCFdoqg78t2r3WYDfM7z/vpBGHx9KG8biPL4k6pktPCiuVZ+KV3Xk?=
 =?us-ascii?Q?zVd7QWsiCg0iaZoAYaaq/G8REcSXMHo56YTE5fXhEHr3MjN5Viodl3A+Ugqy?=
 =?us-ascii?Q?e6VVG8E3iqqxcy7gsrtSI8BYG5ZmZKUk22EuYG98zjpSNGiYs+R+Zx5I7+tO?=
 =?us-ascii?Q?LDCGpcfugxUN92lOdt5XlXq7SMIsXJwu8f5fmJiZDgc7dAG/gsPSBL5V7mcL?=
 =?us-ascii?Q?VVpu2DiKwYmw+2Y6zEIC3OL1jFgv6jZX6kMH+HnxFSUaA4nxE2M778Fjegzw?=
 =?us-ascii?Q?wQAE0R/LZ2wtf2bgJKP4irdyw2JwJwCpm4EZ6ph9KE+/aKFv9y9kuTLqB2bD?=
 =?us-ascii?Q?yQqI2aIZaP8/cIG4nrdFQ3MNX5s5Yq9cauG2+lNiMqxAhjB1OopLtbqAqjLq?=
 =?us-ascii?Q?JPoTzzczliU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UkjC07OHhvBDbC+bIQp/3cD/CPh2XWlkYBhXdghDA/TCJK6dZMwlOINUdMks?=
 =?us-ascii?Q?KH17CyX3+wzskDkIcMy9VKCAGqm8tM7hokXCL8i4jR/37o7bVK0dOMxT90O5?=
 =?us-ascii?Q?uWytVlMJc6k34V8JPIlZEbb5QwtZruozxOtKCbl7OUdfpZBX0fwNCZepCeZQ?=
 =?us-ascii?Q?xl2xCdUXNZPYItPKq8PeQNyLz3O0gNpeEIexZGXB9JCTyGUlis6xpaFBGzgy?=
 =?us-ascii?Q?QZg1CyVSVgM4tU2gM8g/L3vjz9GJ8qY3biwr5aiKVLJXGwVyFvINFlDYrKUS?=
 =?us-ascii?Q?uj7Yr4zCixEnGLCDsUxZh6m0PZkQCENeGtu3zqDNDW+BfwEjTIf60W2wZysk?=
 =?us-ascii?Q?eBV7cN+y4UDL0l1vgY0OEEbhHMK+3hniV+SEjYh9YiXgz7iVK4d5X+nxDVwG?=
 =?us-ascii?Q?VvZXqj1GE0pPxf8UKdOUGUwL8vMXr9L2u8y618t238MCZjIfCKS59zYR6API?=
 =?us-ascii?Q?FlVYhSWfzRx6MtHiptA3eHS8e4lPUQ/C0AIAWb9KveJxsj5wleim2AmPE6Tz?=
 =?us-ascii?Q?8Ze6Vbrhm1LE1OQF4qyDUOOI39Ww2asGh+8p7+5xfzH/Y3+SI/wnGbPH7IEs?=
 =?us-ascii?Q?R3r0y++k8TzDMLtA54oyCW8XnvKBIH1MYjP2JhIMKIevuv3IW3rgiaQNjH0D?=
 =?us-ascii?Q?pl46LcjAKscESSCB1a6W/Mra1P6W7ELzEKCyjzNGdlhisP1lnhKPuJb6ziRH?=
 =?us-ascii?Q?/e4mWtjuLiQfxvlS2tEx7AKPYDt6M5Zo6wLzjOeStOUYsPKxN78godrxX5yP?=
 =?us-ascii?Q?TOtvptQBq+lkcvyZRrUc/WgX7E1h6OLDy0M439EITzgnahRU8smVp6yoyFyR?=
 =?us-ascii?Q?/yo4fyT5ZEgjKaueOL+qCCwdCwKLxKeq3lWNVmcizxbjXw67V+dXy97Bsw9K?=
 =?us-ascii?Q?v1e8K7syI6DG2/gcWcFh7PUv34Y8WJNb/oIhSAjLOOTtZ5muEcz4CK6dKu6D?=
 =?us-ascii?Q?CtZ4xTYxAoDpv+8T4Ok/gL6qKgP33YXTmcvl/FrqLwOXdWcKEyJVf5ph1pUr?=
 =?us-ascii?Q?RzTjBjzbUkUYwn1ffeCkIB0h4vy971lTuDirLvSKopWF++pvub9GUPaqS2Ve?=
 =?us-ascii?Q?gua+OUUi2atWWb+YyujSKGsbTLo8PMvpiQWA3VI6lLCMP6HBAcWpbAghw3iN?=
 =?us-ascii?Q?YmJwaOzLQNfm2JAGVcsUKlojiymraABEfklTEkZj8hzx2zJiv+9WkaFNFZVb?=
 =?us-ascii?Q?kE3QetwiVI79rosqI10bkXjeSU+rcqy5bNEG7WtDnXzYFrqTh0TcQoMgoEZC?=
 =?us-ascii?Q?nEpI/05/DGMoDr/ODsz/Dw7+KWlqoTSOfs7DfU+x3BdTgOlxLYhwoTaUDi/J?=
 =?us-ascii?Q?mjXH30j/7vRQKNiZwve/iH92GWn7+Xov7Wsel1FJtPSzRTeymWWfbHhwuYmC?=
 =?us-ascii?Q?VfMayHPcdWajkZlyuhaI5F1hv6TX3EsKj2uZlmmmbdXZTeJnSzomCX20fKbK?=
 =?us-ascii?Q?zrz69pmV6cihwSvw9evE4BYwQtnoRejUXeXgcufa4pZhwIxK9VqenqW2QJ5J?=
 =?us-ascii?Q?m+JiOg8BJkfEdxTmdTIlwI1Kqkk7HHh3JNqOQwY4pB4VnX2Naa6WRQ7inKY2?=
 =?us-ascii?Q?aBuO37G/dr4iKLRHsCJZCllSwXI33irbQgjlcXRT?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6704c8-e9d1-440e-311f-08ddaf35c1bf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:37.9802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4yEqa2/9WBJX0G0jKixFGv2XMLi5fpnB0Q4pd+asTaPRaHIkELyVcTyXLFWcseqQ2xkHYBLO89QuP+vZz1jBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMyBTYWx0ZWRfX6Mum987ymqCB
 08fvBIfp5MSFKgzxD0V36NtByXvSnZjgbQleUkjRR44xoAolWAIVYMmfnULk+JOAzV+yS+zAg2O
 TFnr2dVBpkGTWlkwjyzIGMWBznyGViwHo5RUH0htMwPdlEc0JqV2xUF+r91/kQ+xJkIWiBV1ZQF
 OHw3VY9d+Uu/NqyyqaUWvG2GPlEyl249hnlh/RcIv6Pr/8bxBUTwb0ujF/QoLpD0oflH8Kaao4S
 LaGf4Iln/3u1+/OYO+UvAHflGaHYma0lRv2LWQ8AD8mRaVxaJYUcx5L0AVj6xx8IWNJp8GuheqW
 lJEUe4vrzTNUXOhYR7o+nwLQMaBaNnMsX5fYpLXEvb7uohU5U+bXnDptxEpKaEb+1ezYLfZ6Rgy
 dPzcNWmNbK2TP1OVhKHgKqT3d687yzd4UU20JVozPIopjfsAn/x0ZThvs2sdBs1FkYkYxDqt
X-Authority-Analysis: v=2.4 cv=RcqQC0tv c=1 sm=1 tr=0 ts=6854117b cx=c_pps
 a=b9bpObgcEOTp51h0EtjbnQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=hLZCMK2IaNhFlHKNMJgA:9
X-Proofpoint-ORIG-GUID: XW4aMGBnZhdBRocmKlUOnMXBnEi3MPAd
X-Proofpoint-GUID: XW4aMGBnZhdBRocmKlUOnMXBnEi3MPAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Support an asynchronous send of a vfio-user socket message (no wait for
a reply) when the write is posted. This is only safe when no regions are
mappable by the VM. Add an option to explicitly disable this as well.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h  |  5 +++++
 hw/vfio-user/device.c | 37 ++++++++++++++++++++++++++++++++++---
 hw/vfio-user/pci.c    |  6 ++++++
 hw/vfio-user/proxy.c  | 12 ++++++++++--
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 127defaefb..28233f0d33 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -91,6 +91,7 @@ typedef struct VFIOUserProxy {
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
+#define VFIO_PROXY_NO_POST       0x8
 
 typedef struct VFIODevice VFIODevice;
 
@@ -104,6 +105,8 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 VFIOUserFDs *vfio_user_getfds(int numfds);
 void vfio_user_putfds(VFIOUserMsg *msg);
 
+void vfio_user_disable_posted_writes(VFIOUserProxy *proxy);
+
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
 void vfio_user_wait_reqs(VFIOUserProxy *proxy);
@@ -111,6 +114,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
 void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize);
+void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                          VFIOUserFDs *fds);
 void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
 void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 5e67cd56e3..e787fd542d 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -91,10 +91,21 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
     trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
 
     memcpy(info, &msgp->argsz, info->argsz);
+
+    /*
+     * If at least one region is directly mapped into the VM, then we can no
+     * longer rely on the sequential nature of vfio-user request handling to
+     * ensure that posted writes are completed before a subsequent read. In this
+     * case, disable posted write support. This is a per-device property, not
+     * per-region.
+     */
+    if (info->flags & VFIO_REGION_INFO_FLAG_MMAP) {
+        vfio_user_disable_posted_writes(proxy);
+    }
+
     return 0;
 }
 
-
 static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
                                                struct vfio_region_info *info,
                                                int *fd)
@@ -270,6 +281,12 @@ static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
     return msgp->count;
 }
 
+/*
+ * If this is a posted write, and VFIO_PROXY_NO_POST is not set, then we are OK
+ * to send the write to the socket without waiting for the server's reply:
+ * a subsequent read (of any region) will not pass the posted write, as all
+ * messages are handled sequentially.
+ */
 static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
                                             off_t off, unsigned count,
                                             void *data, bool post)
@@ -277,21 +294,35 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     VFIOUserRegionRW *msgp = NULL;
     VFIOUserProxy *proxy = vbasedev->proxy;
     int size = sizeof(*msgp) + count;
+    int flags = 0;
     int ret;
 
     if (count > proxy->max_xfer_size) {
         return -EINVAL;
     }
 
+    if (proxy->flags & VFIO_PROXY_NO_POST) {
+        post = false;
+    }
+
+    if (post) {
+        flags |= VFIO_USER_NO_REPLY;
+    }
+
     msgp = g_malloc0(size);
-    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, 0);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
     msgp->offset = off;
     msgp->region = index;
     msgp->count = count;
     memcpy(&msgp->data, data, count);
     trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
 
-    /* Ignore post: all writes are synchronous/non-posted. */
+    /* async send will free msg after it's sent */
+    if (post) {
+        vfio_user_send_async(proxy, &msgp->hdr, NULL);
+        return count;
+    }
+
     vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
     if (msgp->hdr.flags & VFIO_USER_ERROR) {
         ret = -msgp->hdr.error_reply;
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index f260bea490..be71c77729 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -24,6 +24,7 @@ struct VFIOUserPCIDevice {
     SocketAddress *socket;
     bool send_queued;   /* all sends are queued */
     uint32_t wait_time; /* timeout for message replies */
+    bool no_post;       /* all region writes are sync */
 };
 
 /*
@@ -268,6 +269,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
 
+    if (udev->no_post) {
+        proxy->flags |= VFIO_PROXY_NO_POST;
+    }
+
     /* user specified or 5 sec default */
     proxy->wait_time = udev->wait_time;
 
@@ -403,6 +408,7 @@ static const Property vfio_user_pci_dev_properties[] = {
                        sub_device_id, PCI_ANY_ID),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
+    DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
 };
 
 static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 33c3532021..0436994647 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -680,8 +680,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 /*
  * async send - msg can be queued, but will be freed when sent
  */
-static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                 VFIOUserFDs *fds)
+void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                          VFIOUserFDs *fds)
 {
     VFIOUserMsg *msg;
     int ret;
@@ -802,6 +802,14 @@ void vfio_user_putfds(VFIOUserMsg *msg)
     msg->fds = NULL;
 }
 
+void
+vfio_user_disable_posted_writes(VFIOUserProxy *proxy)
+{
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+         proxy->flags |= VFIO_PROXY_NO_POST;
+    }
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-- 
2.43.0


