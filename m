Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43734CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHir8-0006Aa-Kd; Fri, 16 Oct 2026 10:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHipA-00035Y-Gw
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHip8-0006kn-TG
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:20 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5N4R3502701; Fri, 16 Oct 2026 07:21:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zJLaHMP800ZLe/QLftrXKhy1QBGER7Qp7toLitf2O
 64=; b=CGCdnm8T99Lr0ZjgM2T9R6laORwrKoHUw0O0cZ/EblhDAIEBl+6NgXlRg
 QCtexDjQCT2Ky2mOYq/NqeRL0RLhTXhj1HE/Dn3GsvIsI15zG6o1jsbSq20J90Db
 3seEuU4oKy3bPxRUDQqCMI28K/6/XNmORZS45suieULSjgguO6DYQWVYSP8TcUT/
 F3qvn9f3GW2HKuRK6qMvVDwcXcAEIshz2pMsiATcstMCNgGnTKKhw3hUtJcjP7N8
 XTPwMw+00XIk5XaOvOY1gBfZYTe7BcMCjjMKns2koT7nO/7qVjOkMWHLv8N8FsIg
 yH92yMqjM+K6GvPDKvJ1tY/+j+zeg==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020115.outbound.protection.outlook.com
 [52.101.193.115])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hbg268s49-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msLAGvLrzh3XOHIHFv1gDlfjhqJQGeYmwiu70oCinv6TKfM2Az2Ppd+3nM71Z9Zv1WosBrwqbgGBjAYmmEzeDS67QECsZgh8+fy1ToY6ulAJ67HH0zZsqVeGQU/R46DdbfhW+srrfW7W32xDMIzSbTcy6Q6O8oB9IW5oTgnXNAkjIRjF/C9GIq4iL/FEueTgAsS6lOVtdV6WBDzrOn7KdN92hmdLkRRkNELLMFNFIXjNM/RjATxjoW9+oXoxLsN4bSRQb5zRRx7rebM+HgA4DfjPMfei4aG189z69xjbX8Gbi1yL1UYRpokXMHmh2YvRTtION/jxMSBBTnjC3aRCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJLaHMP800ZLe/QLftrXKhy1QBGER7Qp7toLitf2O64=;
 b=yPd9eUoxOEy5Ikxa+wR1cAvGtFz919fXRPRw38QK3hSCNkBJTwwoWddOBjXw5i5YoM1evXuVwxQPVrGSMEmERt9z3/RRtLW8GFJPtogl17Pw0UHUFF1sZRbd6rMVtHqilFGBSTWTLg/Zck/NiPWNKebgacHCrN0HFiM/Z/ukpduPv3k39GlG3wL3jmlEEHql3DXh4gVgfku5wwWJ5FzeMSu5RDjHJjkebwXqRmfuBqcwPXJs24CLm/SJFg9cg1uIS0qgTwwmdWGzn+0xqpcd5SBKqmxYZXAHu8PfgUtGnVknqH2CHhxbOMM9OM5BU+oZvEN88S+pwUAD9Y7sYqVliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJLaHMP800ZLe/QLftrXKhy1QBGER7Qp7toLitf2O64=;
 b=UTniDOq88F5464cVZKayfm9pbUK/veXSWQS12kzxnYyzv6ImU57rqtQnIog3T09LSarJV06cgeWJ7/Y4xHUyn5geHuf/FhxyMCSMuXrJA2bkYOmDOwskKtToHEo/wqrgTxYwgcFTV/4xV3emQRP6eBhQR3ialQ8t2bFSyQg1klEDG0DlMdj1iECTk2L22n8MyQFP8c9K1qhmRE04MUtu9NjwW2N3wNqf528QbTKiz15p63e+yQuPw4+YZcLp2Y9+yobdRFfdQUFK99YhKsxmWab8lAOuGryyGraEECfS7ZQ7VaPSilVkQXdrf5zBr3w2cN/mnCafY/9aAzIT35TsfQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11424.namprd02.prod.outlook.com (2603:10b6:8:352::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:55 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 19/27] i8259.c: properly cascade secondary i8259 from
 primary i8259
Date: Fri, 16 Oct 2026 15:19:25 +0100
Message-ID: <20261016142031.1204281-20-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::32) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: 6186d3bd-a8a9-45a8-6338-08df2b90d49c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|10067099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: J/AXQHDrD6uAKR1PJG5Rg9FAzcvcauy8cPdjHmbmrcaL8dUtuUWvXuDJ+W7PXZCqseSKxLN4L+zPJW+IlvA9BCCNFLqilOxaL9wU0b16ErH6xT3kEoyUiQlWezvJDTFBAcjPGbxS5UZM4gstL0fIFQkCBoG/RHv2qQ9yAqt51W8ukIxH8hu9oxMg28H3wzjwVpYjnbX+wTTmIEQcE8e5Zit+VDyKzsrTrh4CvzRWzPTz1CJm08ZM8NPzGddpO1k05MXf3SREpkvIJWzYpLFGyRLEQDknEaMP9OOZ1INJ8LOSR/dFPh/Gh+7CRyLVKXB0xlTrpWddqQmdsUwzG2Q6RkGHnDO6Rg+Vj9lNQANYuA+78DqRGzgPv+tozVrv4Tp76VmJGjjum8TA4GCKN1yoXXO7NtB5177sNidGxX2Dcx2AAVWq/dqdDmBcWvAD7+LpqHi5z58cI/Ltowh+5TOCe0Za1geAibMrA9yWY4RYsSP+7yXpfacB/qwVamoFra5+FSUQTg0s4p6amlPtq/DPGmdGL91QRgsw+jJMdOkEo4YdDb5layxx8Obd5sSYdBirNdStPtOsWR35xrjcPj0SMFL/ToeXkOdmzYG9oWgUgDih09ZnNraseM092P1uncPP+zOEHNcUXLy+t+AHeWmzUP2X151vng7+XBeDMAJPncc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(10067099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qDCaOc4q95Ron4SJodoCM/RrlFJa6t6eG6dz1yC+946HRC5eJhH/Nx5WMPtK?=
 =?us-ascii?Q?f17ryAzNVUvGINP0vRWFcP3eTEnr7CYFP/WzfEQ0ks3ZDGkCkFBDhX0XGH1b?=
 =?us-ascii?Q?qlI9Cz1qV6GSfxRu0SmlpI9j44TvaW2IN/ulcmMuRMnXyyGajMhz4iD/iXYj?=
 =?us-ascii?Q?IL+/ilh7X5Uyfq39IiWT/jHp+r99j+amIRPs4PvtpOnOAYHbw7wZB6DB0X9/?=
 =?us-ascii?Q?KYz2rHi2rydThqFDT1cPRfB+6hsX7PJaP/5apRqJOSKcQZ7V7aT67Q+cIZgJ?=
 =?us-ascii?Q?zh02C9SllytarMEPZlDvB1l5LRs9yqwXaO4nkn9prnpMywZwxDMnqXXkXS71?=
 =?us-ascii?Q?VQ80yWHR2peoWMNuwoI4ykK6bXhWd5d7Adr95uz5wuSkMUfO5oOuW04jftMM?=
 =?us-ascii?Q?bZ0bTumtRkr5aDCurfF8208vmZCo3QLaddL92nvXupV+bolhS/pvlRi+NER1?=
 =?us-ascii?Q?EdztLNOQacnu+l+6qYQRAOezreK2g+Tb7seNL74D9yLDOaDYrnkIJWZATnC4?=
 =?us-ascii?Q?cVNoDwrDIc2hzyU+K6SZ55dY/Zdx+LqWPpJ3kb4lKDXzWESRfUyLfJKCop2R?=
 =?us-ascii?Q?bUtZNYf6+GTHeQCImVdDdO/ZeYw/QPya2uaPrYxGjt8N8pvUJhxgkBkSzlYX?=
 =?us-ascii?Q?tYj0ZwCf4i5XI8pbNH63cvhVtUln0KaRAL9ETSXKSCn9PZO7RURoKa9PuLFg?=
 =?us-ascii?Q?2L/ZZOC0kjVR9GNpHfK0l9z/qkTXFqWrP9zgYdUHOtNiNfaOfOl7HvMG9Z2h?=
 =?us-ascii?Q?jFnBuAqgloT/33OX6dzJJwialCqy9JNQWRTZPuz/ctFPxyam4fIrnhVESHFy?=
 =?us-ascii?Q?OFxBuFVrZDDuyyj9lciIcBKzwlEdU9Ykhffk1vgFFKn5uJafHhqdub72khD5?=
 =?us-ascii?Q?/JmfP8FL1uuX0ztoQfPKyasIXjRGGfJ7CGWRzAY0XPSJ14i5LuPIhwf+8Yff?=
 =?us-ascii?Q?VXjLNHIcRz2nvR46xB/lcY9xJBmyafe1zpK2Rc9TS4tg+sP6XklsHqQ6cDbq?=
 =?us-ascii?Q?CfKgN/AsOfaiooiICEH6yHKlDurNdmzWrVMG1M8ri/qj8Nj6tguU/+2LmHgj?=
 =?us-ascii?Q?1hhOHmgFAuUP1wo/Hr34EBtIIiRXIJVQ9omlFafLvU9INpC9VReKiigRQHG+?=
 =?us-ascii?Q?s9LN4PkYa48fVdOVaXBmaNBX2K80mQNCT2zF6fkgPIG/0VPcZFNNqa3VF1dG?=
 =?us-ascii?Q?ZjB9mOI1Co6F5Z80JsImdZENaiOSuuQ+VAUJz6CyjsS5IAPbRmne/do7FUa0?=
 =?us-ascii?Q?I4KMIgeraCWLqNAunk6GAmWOLclI1oNPf8LDd0zj4gAuTBuS70aaz2cioLre?=
 =?us-ascii?Q?vTRaaIVTxi24O3I83n4Pa+iPbA3Imy/dHUvxR27b3+CXlWEqfC3uagdgjwFJ?=
 =?us-ascii?Q?56PSPEekq4G+27eMuCW7yYePCRUyEopvYYb1h2iA1DkJZrN6R2xx5tsWDlYz?=
 =?us-ascii?Q?/aaM3KhW4qb1JWIgC10AR9k/vTr2x6KDByooYlbqDOwUef0F5rZAcJKj4re3?=
 =?us-ascii?Q?i3d3dSGsq+P737fFJyD3A6/9hm3iQEunzAghXgKy+U5y5Wu5S4MijahSIPb5?=
 =?us-ascii?Q?SuNtta0L3YxTjqDpTIBWy0jQTZ+KcXQXkMTISa7R+dZPcb5yYXlmXbCW2zAr?=
 =?us-ascii?Q?yc/WUoxZ4njpNZ7E6OK48UODoBax7MGg5SU5Y3w0kA+j81BUYVLi18nHwoVk?=
 =?us-ascii?Q?nWPtbDYVygHWxCrIs6m4shyHukU0xHCNX50Dy7AqUmYdRG90r5W8t2XYC5Ji?=
 =?us-ascii?Q?1RgUcwfKXjxqCBm9GIHCBnytvgvO9xs=3D?=
X-Exchange-RoutingPolicyChecked: enMb00uz3c9uBuBfLvVnTSaCmW1dQzaADCkaCkdOUvbSrns5Ytan6JtXLsIHpEI3PeWbCn5GEp7YaIQRf9vfFcAs3aacwGQqLhCPCXEfWstD3z14LNKahGCdF+OAg3mNJZHFcyECflhkxfS4lxV/aW57i0SoBM30x0OUDLVztQpmcCHXHX4vICWDIrDK+IQfdwDYm6WyOVCQ+onG3ZvQEBTXokM1oJDto+I9YqZPt0RvxqoM1PxYJSDtxi8WfVuScUYX/A/U0YdFgntZPJzgQQtyO2kIXchwKox3AICkWaA7Bl/+3VhNcaRnRZ11Tr/lxmwRLHk91F2PUpqrxi1HIQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6186d3bd-a8a9-45a8-6338-08df2b90d49c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:55.3735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhlLLmABL68CLZAse4TMBcrNE4Hdkors8wv4Dgj/j2L5xjva7YNZ3mvyIK5N5+fhm+w0W408TB534a3AD/epNuQ9lA8ZF0Nrd/JkdoFtefc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11424
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX+8P3W4aKMO7z
 8E9f6tmoqAhlaGkrNhbJuzr/AdlpzgKx7gzff03/cGroxhUfGyTgt0rs+vqsYa2IQHWfaLKnp0S
 oNCsriNZYo6PI+GDiytFiaMI1BV5YsI=
X-Proofpoint-GUID: 29ctTzvAopVc6NTtCJX8QK7a7WYUy-h2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX65lhDD62t7Hr
 xQ8CbwW1SBdXUts7SrpEQX8yKSTlY0Jq2otTsQRPWuOf8OeFNqKq2ojdHU9OJDugkvubiB9efnJ
 XkmXq4fk5nGw/A7mCLBqnUh2PwKyFa5Z3v+xmsLtwLF6GwjI7/pdJErT2YRjBjwjpyFuGDaJgp5
 NmNNTMd6VnjaAohH9hKc1URHSJ+KJCtYgYm3ANbBY6WAKOZhz1lSHbZBnl1PNaPkb5DRR7CtFH1
 oyGOuzdEz/QO5CuXVC7gczJm9yOZk7LV+mpwkQ+osKN7C1pw5NvVReAjv+ricz9hN+tOFJ6qert
 to80CNMEZLacXoFzXI6fYtahCA+6xWlKipHezmXUbregG/6thoUK1oP8OKss1A05k4UbaGwmhIx
 OuqUFZo7QZLwUW2/R4/DRQuoQagVp5owmIdUP3/ZPQuHzfhAGu730p9Qeo6lsI3nEFDiSs1d2VI
 0xd8l/5c4kte6Fem38A==
X-Authority-Analysis: v=2.4 cv=G5OJgNk5 c=1 sm=1 tr=0 ts=6ad23304 cx=c_pps
 a=1UxUaKSOIsEpFYfBxZ3OzQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=BYTbfossBeh0jvsGI5kA:9
X-Proofpoint-ORIG-GUID: 29ctTzvAopVc6NTtCJX8QK7a7WYUy-h2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently the cascaded output from the secondary i8259 is returned directly in
the pass_irqs[] array, instead of being connected to the relevant input of the
primary i8259.

This is a bug fix since in a cascaded configuration on real hardware it is
possible (although unlikely) that the cascaded input from the secondary i8259
can be masked on the primary i8259.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index bfe01067b7..5f90edbe60 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -519,7 +519,8 @@ static void i8259_pic_realize(DeviceState *dev, Error **errp)
     }
 
     /* Wire up secondary cascade */
-    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
+    qdev_connect_gpio_out(sec_dev, 0,
+                          qdev_get_gpio_in(pri_dev, 2));
 
     for (i = 8; i < ISA_NUM_IRQS; i++) {
         s->pass_irqs[i] = qdev_get_gpio_in(sec_dev, i - 8);
-- 
2.43.0


