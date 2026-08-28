Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D6CC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzy77-0002Pb-48; Fri, 28 Aug 2026 11:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy75-0002PH-OK
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy74-0008Fv-07
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:27 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDV0L73119167; Fri, 28 Aug 2026 08:03:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EaY69DkDJTBzHvj+eup9NF+JOS9n/aZottvBb0haL
 qg=; b=nGA/1UEXXHsF6LAaYJsLJkM5JQMHS3p6ecUl3Hr6tSXx4FMhfjyIcYTba
 1RKa0vAqc13fUqcVX7rj37j3vyYQfWDrRScu9VAS6JCUkTQXLrgjGcMlBjI+FHq1
 iT9dGSq+V/LBMu+LCs6PU3e0P3/CR+DT+zrORa/7RN6O3PPuCoe6zAecZ7GuLU1Z
 iXZy/8L/w4oiWBk4kX9V7rAClrsHXodRDRgRqCymHlbV5EtgjqukHDh3xWQtgWwT
 3OCXXO1mZSKgIGVssANM/kuEMJcxbsBJv7dlI1YfDRwFqaoh070obSuoEWW4dJ0D
 2xFFps8C6QcMMs21/c6CJcG/+aTwA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021084.outbound.protection.outlook.com [52.101.52.84])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gau3wjfxn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 08:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVFulEdacxLKRWU1oChD0G5hrmHruXGdrJ2PgjyOVu6e9E8pnlNgC13eveySSVfVqGBqRktG6ovFcJ81YwHzrGdLYt/X19GZmo+XtnJpWIBCSlDCR9d2GPDMTTECOTN6v/3soQLzGaPHjuA2zPdC1vpeKC7vEZhTNAb/Re5Xo8jTRCwKNvIbpOdTfjvZWwLDeNpXiNzLmAi7UMrx/ejqVvcXYhvJZJ/JxebR+vY6NvBPDCM+J1fC0t98lKYwiXqVm7HZUWGj64txiUQKu/wbVw2CDazJ2Y/EPFO76im6y4YKMc9maAoq5ni7CAYhvDd+OHz3o7tltnaFSb7TZunznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaY69DkDJTBzHvj+eup9NF+JOS9n/aZottvBb0haLqg=;
 b=pUNMcR3XdxvD07qpdgyw47p06OZnpT54Tt/XNteKmptmnYCWB6MhmoaeqKVKtvg7LMbhAjo7OXkBSkNRBi1DddGyUSMnqze8M2p/w+ZQPLyRYr8Kc3XBXlqvT5rN7NnxqLKLRKrpDeh3Yac3cL7kJq6fiTdMb3QMNKJjKItdQfMjNcrz+RAOaQfU+qKtYCKIM2T1gInSYRP1+ug986pzS6BwlU/G8LeyVyb2zf42pe4o0rIwhUBq787oj2CJruT+S5NbsR9JGvKYr62K/RJiazG1y2SXycHM2h19jLh9yY7ySCAQdNMmjOtK05WSsvSIQy22c1sDpUR7JPGFk9Bhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaY69DkDJTBzHvj+eup9NF+JOS9n/aZottvBb0haLqg=;
 b=cdpleWTO6y2zWfkB4DUb06gPy7vr92hVMU3I3qyeN0q3RkbeggTyZUfbJyT2hLs0n2bkPLIQcD2fdCTZy84trkdZ8P9fkeX7phzsGK4GwlraVPNk3epvkVg5TEjqCcw31X7PX0dpBKHi3Aw+toduj/FXZhFS93Z2FUhFCdM5rkvolBQnRNS3z62Na6VjWH2QRQNmf2GJM4BsYSmFzFVIhSNccDTi72ibNNrgmVzI5fF4VVNH8fIGp94lIZVAR/y3ld2lEH168hXIge4jCS8C13lyHhmtm9DCOeT+5q6ZXaK25AkejCRN/e2E2ZlS1RF5SKyckjU5a56Ba0tzOzvoEw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB11917.namprd02.prod.outlook.com (2603:10b6:8:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:03:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:03:20 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 1/8] qom/object.c: introduce object_alias_get_targetp()
 lookup function
Date: Fri, 28 Aug 2026 16:01:57 +0100
Message-ID: <20260828150313.1883999-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0208.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB11917:EE_
X-MS-Office365-Filtering-Correlation-Id: 625202d1-7fdb-4f73-0fd2-08df05157fab
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: K/Gl+gSwXh0MBaThyiHGC3dDczS1b/xjrlENUBoazAUklti/VP4HDwwLrXsZFCTgK8p80BSBS0SS+hv7Dpx+IUoYMYbfFYKg5ubnOZIih5gIWUyZyUYim1/qNwZwffO6URyej8x+Kg62ruw99IDcIv2sFs4OgX7e4fY7E/eMKJyvAPvXw4GTTs47j5c3kbo8Y1XENErqkeBAwlNO4jlwIjbQPecoHmeG0e3Xzx1SbLuocZHzNfkmHo6jStQ/EmeLLa9WsCEnq46GxFka57ItPpHU+hUWDWcXvTzeDvcpbivj/F2KdkpbTl5/Wrnsyg01rlCWRmbg6V9Gs1OcPvG9dSKGTMKHN+DWTI8ZXkzlyS74aZZRZ4Mi06zDxNTuj1ouW7Lun75cs7st3iwWYhV4ce0X9fW9MpGb9ohsreON0mhunFA2Tbd/OzadND0RGmhTBcFVr6QKI/Hl/J1lPWtuD2L7vU9Z9yUqD4V0Y16PTfYzdwPIkYu7SPkGZE/SMq9iBEdMgRQjx/M7U6dA8CkryHwHmt54qlxjwEgiufw3hNkO4H45s6HH9IBJRG+uFLBW5zyKRU5+5CbN66q4Iaqp8Rr1a9VM+tw5mZH0Bm+GnyrYGFFasPT6aXf03OA8k8b1dCtHyzr4p14Js+LdJP9zlvefWOlscGOb8K78AuNFQaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+zSKisvcdfal0dOleEpgmm0l2OXKfNnOsybTKrmsxLrY5IzqBeUA1A0aoUzm?=
 =?us-ascii?Q?8rYDC4MajWcek9vDd+AysN0HVMYR2h6C881omizadmTCy5ZG/nUBk470jXko?=
 =?us-ascii?Q?vjG/wklXUG2IMyZsOuKY+taNYQR1Non3i3ONuQ5scLSKgYKq81Mi0RBjxrZ/?=
 =?us-ascii?Q?RSHmEiv6aQBl7JfuNMUrZQKaLbFvIn73FtBLjWUzQHhr/2PRBwVMoVuNxVcR?=
 =?us-ascii?Q?DmpcxqSFdJExXBATasST9DLDox9bJidHZ/CQ8twVy8D7QFzIN78V0Ox9RB4S?=
 =?us-ascii?Q?IaPQJwrmlF5QfMb/vmSIy+4LZbIAdOs5tDpU5tofzNoY27rUFKkRLwomDoEV?=
 =?us-ascii?Q?br+6VcMCuqcbqtisKhTfoAczVcCfsrgkzAz4y3DqjbUKx5vd5cc+CayOPZ1Z?=
 =?us-ascii?Q?/u5vA+/3h3f94k48sZXKbCZEfmf/wuH0+lcXVpJpsAeMCF1ybuPeUmOBNNMU?=
 =?us-ascii?Q?bXZPmwvgtvfMbujTyUpy9hjvwZEeWuYobTRhzM/3WdkQxEZRtPKR095DZALf?=
 =?us-ascii?Q?glkKRk0aTk3ilau/7WgSDEsKq0efOtN5TkoAqToKe8wSiAe606A7xOIWz4wZ?=
 =?us-ascii?Q?+wV8Tlb5CO5a7I3L+iAJU5y2X3kNyYxcF5KE62yNGHUFjIzLBs2V+4af2igc?=
 =?us-ascii?Q?BHGE8KuJVM4Z/4syD0YfLkruPocWddS+iltXKO4qfvDiNYPFnsOTjEKw3OxA?=
 =?us-ascii?Q?uOxWKEM8qx1Ec188EndiLCTkYDG+8XVhC0hGs3P694Rs1fLWOtqWSBQN2OXq?=
 =?us-ascii?Q?S36fng/nbGmCIJsXfhAHmGHxemwqaA0k5pFJtgVSZ6krnoi+MMq/12OiqMTa?=
 =?us-ascii?Q?c82xpmjrENYC/yzgouKBYR9lq73CV+3ABXjI72SUkM8lHvZFRBfvb1jW70aU?=
 =?us-ascii?Q?pK9c7Rsxu8wtIU0kII1THilbrqP/mW9YrOX3Noq5Mx8MtqP/xGHeUsAIHaRH?=
 =?us-ascii?Q?974VUheaNKPEBNAunt8mD+6iFXNg9PPAYcG5jESENDu0DawfIF4xnhD/yRc6?=
 =?us-ascii?Q?5Ei3gr1Z/VlfsC5dmfLDIvjWPqKtZqVu6PtxJlKA31DMmSMDhXkdYi4vEOLL?=
 =?us-ascii?Q?5jH/E7lmbeNzAgyvkA36ujX69wJ1c/+vajToh2jeX7fn8L2RIYiGwmj5UYhT?=
 =?us-ascii?Q?LnweitnrB3VklNUe1L5YRHQPBCGtq9nDmQjcQY80CQi3RRmA1Fy8GDH4GOZb?=
 =?us-ascii?Q?mnNAf+oW7evcpFsqxMsxc1+saC/jqjkBbTUbCNaQUx/AQhK9jUACZp5DDc0/?=
 =?us-ascii?Q?Ikrt2GViH7DpJ+O7WrzloFaJHJ/HGk6X2YqHr2OTmmIrFs2d7k3bk3J01WWD?=
 =?us-ascii?Q?vHze3igmDdHJLbhuNw2OOKuaqjkoQQVs64enhdn5NzBo8WDEN992XeMdnbLf?=
 =?us-ascii?Q?PfGXV3TEkadR7EcKD2njhtx0E4VbwPIOawJi68MyJl655lBqckwC/zbcK64L?=
 =?us-ascii?Q?qtvyNwgFNBYW91/1OMqmnQFy9cvAgh1TQO1ao8TaVo9c7ISzCyK4mPPtfJu8?=
 =?us-ascii?Q?lTViCSt4GfFuk4F7D8zH7QDdLRIJ3OR9JLy6G9H8y5Pg6CNyI4ifMzQVJPZM?=
 =?us-ascii?Q?CwoUWG21qq5AmmxWvQZ4CbEu51DrAP+1Ssk7UVrUkuR4/bWUzy7GaiMT8pWB?=
 =?us-ascii?Q?QKks6QCzr5cieFXTD3KbQqj5vePanI8pbCEpNnMB9aUMxkj2Di5mBeAcUeLC?=
 =?us-ascii?Q?EMbOcxCMo6+RtbAGh24KvbuXRx5+ttwhsNO7hs5B7Atu4tQMtg/9v2DeM/6c?=
 =?us-ascii?Q?XZVreiW235aIulA3hKfcscshveTxqvI=3D?=
X-Exchange-RoutingPolicyChecked: D9aj3vwsZBhgEYUlkPeiziMkpXR2YqjbVibW2T30maobFdPggRtCEJJrEiD9gwk3ir9LGkqB6SCMlTwEjd6cw4olEQacPqnf5uUlK52JrtOPTnUmvBsFGnD1mmSlOYcC7/yiYV0kZBlOI8/oz6Ow5jPapcg2yeqJlbtaR2O+wI3qRuVxEhHRDWFK5RNDcMcsFv49dQr0ENw24mU4tpaw0DKVXhekieHwmSboi4PSzLyZBDXZvcenDHTwq8sMOga5NSPORt02jo7ML+U3CQ9pYRLcE3l0+hLpWLPpDWHahSE1KMSO6f/1lqFESOox5sGYn91nSJNYLCAhJgws5Ju82Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625202d1-7fdb-4f73-0fd2-08df05157fab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:03:20.6072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASXY6qsbuAVtME9Z4Fe5R+BVgoMQpobRMV/MegOzbEfWeO3vgvQaOINhZAfNLlZrvfPdzPuGZ/dqOASaG5XaYN5TBCZsrVfGLwpCO3oUiwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11917
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX01kcqXi8OPSo
 ErYA9GKWhyvF0+mQ33x+9Geh+TWoGkACnzHl/ybVCk/yty2RMPte5TANMGI0xGCOs3cQoGdvY0L
 rzAwC2Bf0Uf65AAPEDPagSyfH+n+gD0MWefC/HsVEzQ0kheGpO4Sz1gJgYChEaWG4ahAY1kihLw
 QneIVWt1zsBSuzTXGkd5vdHjZtuOIglGmaX2ke5KkzAzbBpFJvlE1ZLLLpNsvXKbldrqDiUifS7
 s+cp36aC8AX6n0MAL8pHq9OeNzKpns8fndSXhbq3wIst9OtU6gS6xb+gQaaf0PsiddkxYs4Q2Mm
 Tr65B5qpUBBQRp5Z4ztD4L7Gmj0KbV22H5fOyK6fyZV0LRNKft9Sut8ncz3r98Pf4YKRzG3NSfM
 ZqxshfZnzyYvl4goZnBN78dl5Xwmbj1ape6NY4YfG/ej2uHo9KkMtb0gmMQKiX+iVDN956aIe3F
 GSiveTH34WIyK1rXTxQ==
X-Authority-Analysis: v=2.4 cv=W4oIkxWk c=1 sm=1 tr=0 ts=6a91a33a cx=c_pps
 a=0I/lWAHw6mYlwhxI0+EZog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=H8dXxoQVm5bDt5vjS9MA:9
X-Proofpoint-ORIG-GUID: QbXiVboK0gZM7rorYBke59bZGpb95RSc
X-Proofpoint-GUID: QbXiVboK0gZM7rorYBke59bZGpb95RSc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX1aO4sqGtXsfF
 sZufQAze5DbwOMjAZE52sDmr7ZXa6cYpkY+Arr9AvCICDwJINDOusDQiiV8KuWUOkl1WUGRnEhH
 hPgSxQUZdIHyEWGENdRARslG5xffOAQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

This will be used later to add support for alias class properties.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qom/object.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 85bbd7f9fe..a904f53ed6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3043,13 +3043,20 @@ typedef struct {
     char *target_name;
 } AliasProperty;
 
+static Object **
+object_alias_get_targetp(Object *obj, AliasProperty *lprop)
+{
+    return &lprop->target_obj;
+}
+
 static void property_get_alias(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
     Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_get(prop->target_obj, prop->target_name, alias_v, errp);
+    object_property_get(*target_obj, prop->target_name, alias_v, errp);
     visit_free(alias_v);
 }
 
@@ -3057,9 +3064,10 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
     Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_set(prop->target_obj, prop->target_name, alias_v, errp);
+    object_property_set(*target_obj, prop->target_name, alias_v, errp);
     visit_free(alias_v);
 }
 
@@ -3067,8 +3075,9 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
                                       const char *part)
 {
     AliasProperty *prop = opaque;
+    Object **target_obj = object_alias_get_targetp(obj, prop);
 
-    return object_resolve_path_component(prop->target_obj, prop->target_name);
+    return object_resolve_path_component(*target_obj, prop->target_name);
 }
 
 static void property_release_alias(Object *obj, const char *name, void *opaque)
-- 
2.43.0


