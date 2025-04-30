Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0F7C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIy-00008g-1d; Wed, 30 Apr 2025 15:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIq-0008J9-ES; Wed, 30 Apr 2025 15:41:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIl-0006Ft-1V; Wed, 30 Apr 2025 15:41:08 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UEdDAg018664;
 Wed, 30 Apr 2025 12:41:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FzdC18c+KVGK8WvDlt0A4ZDg2JJohZx2YmBquIcK+
 es=; b=jhMUodzVKgK2FDZnmBLxpfTYk6lSj4cxjjSqSY3rWMeyziLrr4XMbvIdW
 jS5wFYpLw/+GZo/3vrB1u/Y5nHwAPsbDExxVJpPJokyyaI3OevQYjzA0GUfQFNNQ
 M2uFm+TCu1dFPpSEzxymNsg+DrSVjDEUNa+4jx9De629GBufsay1H6qLjnaa7T98
 tWzoe4AqaA9KO75pIwWH9W9+FzuB0oHQ69+hiELRXDSZFK2wd8VDsEYLqx6YeJ+V
 Q0mF/ZNfVh96bZoOrMbbVNCWoXa437vkvhuyNaPL70nWwEIceHBTxdtsD2kPo5iK
 Lyjw6V5q4qJzVLI0pl3+fGpTbvUJw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17012015.outbound.protection.outlook.com
 [40.93.14.15])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468w18247s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbgAT7um44yaJI0peYYjRhFo7zgFasLviYuuSP2GaIEOFpjXYfF3jnhUZtmL7D/Vx6tbpmhOjfq/qwMyd0psP2lLPCLc7rGobbQtlEW08KqhBpB6TaqgXWkQWoGHVGYMvCUqRpAItFzGtWh5oekIi8Ws9fwjbm4BK3aUg2bbjhm8ZYebZr9CIGimlvC91eFgnu4/lSFvJnKDREcfSv/RDAIePiChsNBSccDnvfWCtKVbBm2OTalbk10cskHinNEdMLQdkt6HsoiySHzxSHRmCmGTpu/zGA3JnPPlMtRx0JH+zKPfa3w/6fVNnKLPj+UK6ad10H+vc8m32DdwdaDzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzdC18c+KVGK8WvDlt0A4ZDg2JJohZx2YmBquIcK+es=;
 b=Zz+Dh2Hkc1vjvMO8DLDU8kh/5wgIVzspdKSo5qJ8u2E0QAR0IM/cEVtm8R64cPpV6kG8MKuHCHc6xLZ5MdhDp1r8MxFBzY3P2S5oc4/Ux7j4t+YknbuIkuMUm7o7Ore3iLVPmkD7ONx6egzxEx+I0KPBQ42QivGlCwAuiOkOxqu4oR/Co+PdIRKg03dONCXraCjBPNE3r6uKvDIcZrvu+Bi54A5fDT376UOUoI3/focHv7eojEDlLr3a0k+IdRc+2jqZzyXGOUS39aJYu1oxuNXLH9KOE4rIf9+K3WVjOtjSmD1MewJArcsrxQayEQZkQKJcB4ArLPx1BaA9spbO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzdC18c+KVGK8WvDlt0A4ZDg2JJohZx2YmBquIcK+es=;
 b=XhdvhCZoH3XPezheqaCGE8f+SZWEdgq6UawghTIINy8/Hg9fRGTp8nEhJAWp8a/a5Lm8TDt1duD8FQxyQJNZjMQMlNolPY4Xsffm28jzeRJwpCPEjZWpC7M9kxPiIsQwb/GHBhArVowmDH+tx2/lPfFxbF6J1l9PRkqYMdrnUI5emRuh0YUIxMVfrkDd6jCyP4/rEkmh69SK1vxJcMjMfIInx3Uh+TVJLG9I7/M+r3l2Fe9rkiWpL54kzOV1OQHyPVQfwY8heeUGbixUTvJhrcn3BWaA7KMG6Xv/BOHu+5up7/jYTXnE/xFZWZgXy1iMd3Mtry4W1btUPN+5eexqpQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9931.namprd02.prod.outlook.com (2603:10b6:610:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 30 Apr
 2025 19:40:58 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:57 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v2 15/15] vfio/container: pass MemoryRegion to DMA operations
Date: Wed, 30 Apr 2025 20:40:03 +0100
Message-ID: <20250430194003.2793823-16-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: e05a24c0-f921-494c-518f-08dd881eedc7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OAHUGgE5KjK4PrJdXhJzfesyeH6TehJyQn6PX/Jlk2IX3tlsnnNnE3qeno+6?=
 =?us-ascii?Q?sFtGXt+W5XAE/5RNIx9cw5lIDLEtxX9bpJGLs8R7uFmiiPwu8+m/83llbXQj?=
 =?us-ascii?Q?nTqGBcdYxuoP7F2YS15a6Y5+XocrGF9AGW3NzHsUOg/hDhAC8Pyf/0V/ahCf?=
 =?us-ascii?Q?1Xpnbt0J8Iy2OOr+jumBZVeTR/43PwKnjk1zCyH6krkOrbhauQNTFj0a5xhz?=
 =?us-ascii?Q?mFv05ir9oulYZ4R1HP0hYvR41kHxQ9vpVAksbL2dpqYHbs70rEfU2DOziNap?=
 =?us-ascii?Q?xPt84PLGmwuKs3QdcNvUDUMT/W8khRIU1rF5e35pTR4Dj4RIE+UlfrO0LZWL?=
 =?us-ascii?Q?xWFJIvX3B7H+sxOQU2rL0mLiDgW9a56oOqlaXrhqxuq9q2xnysX9iUybmfVk?=
 =?us-ascii?Q?ZMP7BKb60x3YSSeDqp74z9j1IvjWkVZkTvesxi2zUSY1EPw8T2MzGoFz1Z+Z?=
 =?us-ascii?Q?hTwfoPXsnHCbUqR6T13A4xeHbXvZ0bJ45HR8PvvY20/pvNyDZ6A/GKppwvEL?=
 =?us-ascii?Q?xT5m+K3mVFmWw3hrYUlyUidQC4nqpxgp2SOFZ3ep03kw/GEneuNvGZ2QcPMM?=
 =?us-ascii?Q?V1Xht8aOg57R9hzoirhABe2TvqBkIRN7SRL3V74/Hp8UptS/2jZwJxt5fQw+?=
 =?us-ascii?Q?rvTj5PLldCAIcKij+GbB5DuxAsN4zXVN718Gvt2Pc8zZ3clfJU+V+vHMRDhV?=
 =?us-ascii?Q?ku2E+8bEQElexW1/sxWToDR/1M878uuPCAbo6GoSFaTQ8I5Lm2wZpMA4dXCd?=
 =?us-ascii?Q?WLrK27uC9WRMwntsGdyG/FHKAga7cwfYlyLM356cko/NtepklMtOIqoXNamm?=
 =?us-ascii?Q?eGBe8adlqA6ju5sWyv4ksVd3PWf5CgJwIiYOd5chK3QgLpipE+LCR79hJIBS?=
 =?us-ascii?Q?v6n4rkwoFEGIbHZxh7hCbEY+kw9h9fe/kJXxy+jO+SkrQqUK6jhGWb/lTeO7?=
 =?us-ascii?Q?FF7eJ0eaf9KxQLLNaZd/EIqIe3Hzn7YTKDeBSR7Z/AqBL57LzgI29lUkg78e?=
 =?us-ascii?Q?8Bsbl5JAzK7tvf7rboH/c/la0jLA5/kK5SP5koEwvH6Zn68A3VxIXonsRdRa?=
 =?us-ascii?Q?SR0quMxpo0nlmDQW6WrUjgFsx4h15mlQ3eP9rsvmufii0w19I++zuNRBSMDj?=
 =?us-ascii?Q?agD/x4Ri7k6f1zs20XoahYMwGa242MkCNgn6Ft+Qxl6HQfITZETLO7p7xMFJ?=
 =?us-ascii?Q?mDVTVP9sdPz3pF9F/2FtgQBQ/5qYs1lkjOlh2E6nzFM8usdeO4Mt3+boZVoP?=
 =?us-ascii?Q?RF7MfHsiZh2QlHIKVC66gTDoK3hgV/ipPFXPAVpx3O/OWmFQ4WdFXi2BuPg7?=
 =?us-ascii?Q?Bg4nza6Eisekvr4An55/Hn69RkJM+XcoLA7DOjmomRP4b1PCCJqPYRcd8X/b?=
 =?us-ascii?Q?a2cIbSEl4b+iUYp69zS3pgRKnMSw2hGN0DKYXy0TaLEFxeqHlgwyw3pvrT30?=
 =?us-ascii?Q?0Cbjpz8bF7s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mU2vcmJL8xOe95u8teQr+xtDIZ6qTgeZwfxTlPMUtilBJj7wnTV1SsWYgZme?=
 =?us-ascii?Q?G4xtGAgeHx88tvzAerPUPZ/KRZb7sECO6WKzt2efBmO02CvXZ4Pte8XZLAN7?=
 =?us-ascii?Q?o2fE4Lii2DBDmpNUMdJUH5zNDz4O/Pez+ZcYCTx3F51p81YTz4AWjzcy5+Ct?=
 =?us-ascii?Q?uWHS0s25F6oH4XECItlV6XRxudmj7gmve0EK+s4/5m/tq2XFCVua1joFROe5?=
 =?us-ascii?Q?L9p3aLfhmQJc+H4jf44dQbq4DtEL5Hp+EVxTbfcHdDo7lbdYbq27fYz4mC0Q?=
 =?us-ascii?Q?HenlItjb7ZuIKFZA4n9n/daoTBNfXut7m2lb589P8/Nun2ShHFt4GKgTBSLy?=
 =?us-ascii?Q?27HOI5iQ24KIOhpyZjFmMSN5OB18CECU/v1DYXm5fqcnk0NBEsHtaV/WAZr8?=
 =?us-ascii?Q?361UegGnVcpinRo7620oXCQvxHYwafTjPC624wtPglpwJyChQndM3d7iDbN9?=
 =?us-ascii?Q?zxHxjgxEJFXl5B42tqmAFZceTc18g9ccF/bPUTux4UsJp3cikmaXw+dBEOf5?=
 =?us-ascii?Q?G5MLWoMJTyUQGo9ULIV3xpDwXu66vHLzrFLOdWON0kzpcjPMw6Shs/crGwry?=
 =?us-ascii?Q?did7TxdPe8uSEx2ZKK1njxJXaIiZp17I0vAb+hd5ftvvffbJ28CH0RPNOaQP?=
 =?us-ascii?Q?BrRwrzQXzxWD3vZxSXVCBxDExQQ4lLnV5GOxckX/gdi81GNUXX6FFxWaeVSb?=
 =?us-ascii?Q?6q2tji/q/JADDGO185YwGD8lUXHBEo5J5AoHOKsP9CwJJIL43VD604ocnFen?=
 =?us-ascii?Q?XwuFl4RnDPm9VgvS5CkCDQty4frB4P+v+tRGYn+XOgWESRAfrV2jGJR3a/Uv?=
 =?us-ascii?Q?mjB6UPthmzvVyPWggHTyuPZFrsMAOSl9jWXY5qfj369KzYiAQqWQF9yb+p/c?=
 =?us-ascii?Q?iPSO5YxYZbl4lKuziLMxsNSoa5D8qZEt+Bq+AapOydJyNaQukzvd5cWkvtMU?=
 =?us-ascii?Q?RXJYUbDDcaiaZo3o2oOsmb5R1hyDCveQkjnMJlhHBXvrZoTZmR/zW6qUs5Vg?=
 =?us-ascii?Q?OlvafTVU8XsGDnSbEKyGzAutynxqEw7Q6sAzhtOuoDUBh0ys5IugdR3418uC?=
 =?us-ascii?Q?g8lI7sdx2hzmLVoBn56c6c1TIUSHwKH57Yau9CajiukNAeTO47ivGAz/YJ7i?=
 =?us-ascii?Q?DoYLfg78+JV8tdrcfxGXcYn95FX+ONKsM+UDVcj8aY9YINb82Fd+/9gXTlqT?=
 =?us-ascii?Q?oezQaeBzgr44TMmo06hO8Smj7XnEIzClNFczd1LZGdhx23YU0ya6Zrn3Vr4M?=
 =?us-ascii?Q?vZGED1uyA8ucZr7l/FGf3MvU+//SywqjLDajksM7bjLGzdCA9k3ArMVF0aD/?=
 =?us-ascii?Q?i82GJtIR6GUiwSxTvWFGibOTzkq6L9ByLEnIKH+UAD8o/zuAqIJ8OZ63CO/m?=
 =?us-ascii?Q?x/x4kUaeLuAGf/2lG2Dy2Wt30wfHLu1mZ6tEbKStOpwqeOzADOvSVd0+sEas?=
 =?us-ascii?Q?FZclgCrt0krg1pMF9xQr/NyXd1zsIL6+UrWJnlPabVcYg6bAjUYi2UTKlXaV?=
 =?us-ascii?Q?SrLzdFnevqsqM6qSzHd/aOP4zBNyj5Akk2aESlv4qNBW4ugMfGJpLW9nTTms?=
 =?us-ascii?Q?59lp7l0pnLUHum7CPcqjHPjIBxhp7ldX6N3o0vAP?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05a24c0-f921-494c-518f-08dd881eedc7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:57.7989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIefED1t7uo0BCSDMzoIac1wnMKTFoqpE6xneO+rR9J3hndSJ+FTp5M75ENn/vN9Vb1OCHGIaZ98O4AZXccReA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9931
X-Proofpoint-ORIG-GUID: XBSfDpBJma3sMyDrdmafNH-B8eL0qBY-
X-Proofpoint-GUID: XBSfDpBJma3sMyDrdmafNH-B8eL0qBY-
X-Authority-Analysis: v=2.4 cv=VITdn8PX c=1 sm=1 tr=0 ts=68127ccc cx=c_pps
 a=/gCfq7Ne1cdKKt0NGwu3qQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=7zwm0VwvlM8wVqh4CGEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfX+GcrP1BwrJEI
 XJnjnR+wq13Vkx1W6uC1A9Ssn1zUL/gDUvNh9puVHLd0W9F+ym2gT4g9jCTvYFtGvaHodV6Mm+j
 RdhFR0LyhxfCPau6/mbJYzuiqGqKsLfV+NLM3IgtzZBMyFUtMNkPZ72FWhuMXOZS+eBwEgkZYLT
 ayTiz6SB3iPYI2aPR311VWX/J1TtQtIyYD41J77Mci99huYvwiYAPuiqbmTskAw91lydiZfKrw5
 pe5cS2N6Upq0qqhrYacZq6yPr6emnZyYBjPn3e9GKtmQ4oqJinW6pYS8+WLSlsd8WEKRoXxEf6x
 tuKbmwMGQuvM+diZ2QP1okEy8kQ64sKTaVzglXn9UD1o9eE8wXxX+46Qa8Tik5SJA1hlnFMuu/K
 mXIxIWNa8VIFc5ref1XsySmcLu9SSiN+ZFa44grAyuOjOKlLPU4zQ+uv5NvmHdbn10JxyCf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Pass through the MemoryRegion to DMA operation handlers of vfio
containers. The vfio-user container will need this later.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container-base.c              |  4 ++--
 hw/vfio/container.c                   |  3 ++-
 hw/vfio/iommufd.c                     |  3 ++-
 hw/vfio/listener.c                    | 18 +++++++++++-------
 hw/virtio/vhost-vdpa.c                |  2 +-
 include/hw/vfio/vfio-container-base.h |  4 ++--
 include/system/memory.h               |  4 +++-
 system/memory.c                       |  7 ++++++-
 8 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 1c6ca94b60..a677bb6694 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -75,12 +75,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly)
+                           void *vaddr, bool readonly, MemoryRegion *mrp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_map);
-    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
+    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mrp);
 }
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 1000f3c241..aaaca33c8e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -211,7 +211,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+                               ram_addr_t size, void *vaddr, bool readonly,
+                               MemoryRegion *mrp)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index af1c7ab10a..a2518c4a5d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -34,7 +34,8 @@
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly)
+                            ram_addr_t size, void *vaddr, bool readonly,
+                            MemoryRegion *mrp)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index bfacb3d8d9..71f336a31c 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -93,12 +93,12 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 /* Called with rcu_read_lock held.  */
 static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                                ram_addr_t *ram_addr, bool *read_only,
-                               Error **errp)
+                               MemoryRegion **mrp, Error **errp)
 {
     bool ret, mr_has_discard_manager;
 
     ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
-                               &mr_has_discard_manager, errp);
+                               &mr_has_discard_manager, mrp, errp);
     if (ret && mr_has_discard_manager) {
         /*
          * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
@@ -126,6 +126,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
+    MemoryRegion *mrp;
     void *vaddr;
     int ret;
     Error *local_err = NULL;
@@ -150,7 +151,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &mrp,
+                                &local_err)) {
             error_report_err(local_err);
             goto out;
         }
@@ -163,7 +165,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          */
         ret = vfio_container_dma_map(bcontainer, iova,
                                      iotlb->addr_mask + 1, vaddr,
-                                     read_only);
+                                     read_only, mrp);
         if (ret) {
             error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -233,7 +235,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
         ret = vfio_container_dma_map(bcontainer, iova, next - start,
-                                     vaddr, section->readonly);
+                                     vaddr, section->readonly, section->mr);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -557,7 +559,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     }
 
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
-                                 vaddr, section->readonly);
+                                 vaddr, section->readonly, section->mr);
     if (ret) {
         error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -1021,7 +1023,9 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, NULL,
+                            &local_err)) {
+        error_report_err(local_err);
         goto out_unlock;
     }
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 1ab2c11fa8..4c4b3d1371 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -228,7 +228,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
+        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL, NULL,
                                   &local_err)) {
             error_report_err(local_err);
             return;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index e29f7126c5..09b72e9969 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly);
+                           void *vaddr, bool readonly, MemoryRegion *mrp);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all);
@@ -121,7 +121,7 @@ struct VFIOIOMMUClass {
     void (*listener_commit)(VFIOContainerBase *bcontainer);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
-                   void *vaddr, bool readonly);
+                   void *vaddr, bool readonly, MemoryRegion *mrp);
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb, bool unmap_all);
diff --git a/include/system/memory.h b/include/system/memory.h
index fbbf4cf911..eca1d9f32e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -746,13 +746,15 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
  * @read_only: indicates if writes are allowed
  * @mr_has_discard_manager: indicates memory is controlled by a
  *                          RamDiscardManager
+ * @mrp: if non-NULL, fill in with MemoryRegion
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Return: true on success, else false setting @errp with error.
  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp);
+                          bool *mr_has_discard_manager, MemoryRegion **mrp,
+                          Error **errp);
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
diff --git a/system/memory.c b/system/memory.c
index 71434e7ad0..79671943ce 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2176,7 +2176,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 /* Called with rcu_read_lock held.  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp)
+                          bool *mr_has_discard_manager, MemoryRegion **mrp,
+                          Error **errp)
 {
     MemoryRegion *mr;
     hwaddr xlat;
@@ -2241,6 +2242,10 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
         *read_only = !writable || mr->readonly;
     }
 
+    if (mrp != NULL) {
+        *mrp = mr;
+    }
+
     return true;
 }
 
-- 
2.43.0


