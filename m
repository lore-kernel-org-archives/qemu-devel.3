Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BD4C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nBH-00032f-AB; Wed, 16 Sep 2026 06:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8u-0001Gt-1L
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8s-000335-1B
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:31 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G83uAY353108; Wed, 16 Sep 2026 03:45:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=GeiLRjmqXC7pnl0xUqlMjcIIuJxuKXS5eOpzhsJsz
 4E=; b=dtgz3oDYS/p6TQ9xHyEtPGQ7SOdVB44WwYKYxMFMHqI5CnEaRb7LcV3Ng
 pjUSvPkwaLbp6YMBdHBd9f9IDGzZRI840vXK9gFG8BJMh54MZgmErumWVM8cJ234
 /kq49kS/W3nb838f5STVHIPhoGPDb6zGOFGbLghvfqQRA32dQOEnCYJOYthMwi9q
 v95HmtEmXgBk0JneIkDzgHtRpdv0/f9SlsK2Poc2BYMx/d8Wn5R4odxNhRfbqkga
 ALbmo0+ZexS1CeXiyGlVPUBuHd+NnbLU5iCnQnU/rvPq/wqOc99QdmN/Ew/Ap28q
 xzB8B115tSRBEIUNZq/lCn988ilqg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021074.outbound.protection.outlook.com [40.107.208.74])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gq9drte6d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlf4q3wuc4mtJNyQDaGQAFvVDA3352BNuMmFZKh6P/A8DNfDdOxKx8k5b7yVFMie+6oyHeRz09vP214q0kGiB7WQ1ijhA4jMBTXSCfN8kSpDGVKersTv7ATeHGV1GkOUz1+tidOKPvQUFb9DMKdjj3IkqOdn4aATb8kTbkPRG8VCJJvY5odQlZiFlR8/5j2oDZ6MV54MLqFDmpeLoRqqpZSul8n9/Y4uxZCKcVkXL4q/xY9FRbCFA8vLCNuz3jUcz/lqG078y5CgSCzolAUEnFW/X7nxe+b/tjk/WvwPWz2JNzZcoHnt2U55JsrbwdqGg4lxMYyqDEhmwj8RiSnRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeiLRjmqXC7pnl0xUqlMjcIIuJxuKXS5eOpzhsJsz4E=;
 b=c6X3GcL9bsfYwe+QO7kCB/jqGDIQDiIaa6fXMW3tJiHBb2rr1NqyqZ4+au3l5VUlEeUSVvK4qxa9BGsWYIh5yle1TaMihQNB4e1x417gCHnkldhLRTuEt0TcD9LAnRDi/wqLlkCTMMPZPoTOBaoUOC/k0wJRmAfixUuTqgB4fvUkHdSCKOUBsv4Vmw/x49SNFyd0mik2p6EB6l0XIXzWSrnZrEQZIX03CPSP5l9qa7acdquTWYLlA5aqW6kIILpVkCop67WfnLu3UgSNwPho2OifbyHI/uCuOlP7KQ3Jr9MkxIsHUo/5C+V2VpJYZJB9ObmAPHJ3aFYasQosnG0kHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeiLRjmqXC7pnl0xUqlMjcIIuJxuKXS5eOpzhsJsz4E=;
 b=dJJ6Ik/oPfwZCcvmmPqW/m5TsQGLzUGlcEtccVgZwMHqWZxswRNcp3t6ZEeJCGyffmCKUIijo++2U6Vr+R0oKseR9dvYumcpmTwXcBAn8nRspBfvXKVH2hVCt+Rs2LbCzK4Joc4OJ2L90XSdzItdLXKl8hht6pFCKTiIhYMxmVDVFGrwAX4LVehl69PN+JqBX3D7HHynfEbhMxPI40fClDY+bhUpi9PhEYxln3/3Hz+WqgpNfsR9rEAPAO9F+56JK2tf8GWiT98C0lrGHPiU4lXXjcK51T/2xYseMEBPpH8yXFirufU7G18XJILXSB1dD265QYM3+p0jlbNsdnHcOg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 12/22] kvm/i8259.c: convert to use DEFINE_TYPES() macro
Date: Wed, 16 Sep 2026 11:43:40 +0100
Message-ID: <20260916104435.600211-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c17469-b1c6-4396-bd73-08df13df9b5d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: SZgu+T00QUcGv3RCctNJLGqm3X+vaLNyJxcGm3gR8HFF03HWJewtNf0M2DGY1hC0TRq3L4MH1UCKrZnEkzODmRofoABu6KBZ6LfCi0Tvnm146Kz/ULsYMX+nTRPWdPG/OxW3RsDJYZYBjhFM8q2eSTPSZ04b4IStKN7sjCiM8wcA3sh78Z1qMkkpM0ciL8dFCDIN2wHrlwTdsMeyZPRa+bocAKFMR55iFrDlShPALhyDfaAnCcIekO/7NWY+7kmg+UmebIa+inaHtjKyHXO7fv7YSQbvfNl/V4DRH+qsQ6i9d6Oyg5eVLGB8WCE38KMLPB9GAoiXXX8CsU+rfuci+TfEcZRyLzH2lc68V1CiA9OZoD0UqCVbVmZN/hBIYjK5RwvzgAgof0KkWfXVJ1dP9ZUNdMkpB8RjC37pTbld9Un9buESEy13turlW5vP29emgkgOTIq7Zie+M4nKb990xY8Hf5z1BlGXKVr7qZt2fP0M+t00o5fMg8IlPudZ/XlwZ0oYMHMgVHbbnfgwvIK18zmFhXTQvjqPET7kgBhqLV4wJkY4Esbu4NceDEc6M6BufkpG3a8inb1LwJYAIuz4Ljq6k2X88LhwrHLckkkZ7UW/GcJu4qFSjxt9YcGvMQzokG4Yk36q1bFeLE5Rg+vfY3d7GxyK6f5wVE5jv26BcaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ojhDwRMRuP0ldhUeCzvfgkMqGEpUlRcGnZzp6ilSV+SrM2lNvjhCriE4aJIN?=
 =?us-ascii?Q?g/cYh3dIL/JWynrihGV4Jv/WEvsF4EsOx534KHTG0IIwTRVRQ8CpHKBCxuAo?=
 =?us-ascii?Q?0zaTantCaRraRJUF3eNDnZpq5jKctxqpPiDs8z14c2690LWuC7NXGmKpuVID?=
 =?us-ascii?Q?/K18mh6GapVw6/53Trj7O7K800WRWWHx2kFMa4aYdIdbWk9JeeUN6Ea2h8fl?=
 =?us-ascii?Q?uwXuLW2FaIt+RjCYzaek+1zUlp94NKho26XcWjzntQ7gj+X1WeZxQ7NUwd5R?=
 =?us-ascii?Q?g6MzxF3jTVyuM3R6Nrqqp0Sp6JtHEmPsZpmIz7GUEldx5KTJGnQzKCuFBFgZ?=
 =?us-ascii?Q?vUKayhH4FKNJ1+AWJ5OGp14LOxk/pjEMVMyBAGIDYWuIUVZUNJyHaPmGYVHB?=
 =?us-ascii?Q?r1WiO/46SgDd+AfcnUe46JPpEiw4Wmtq6WZGnb4+ctOuISqtKRvpRFhxnRtw?=
 =?us-ascii?Q?5Y87/9ahZncP+U5JpEEmHIvc16tJYa71y4EawRVN8Vdxlo+itDrda0nfEvmm?=
 =?us-ascii?Q?7SCxzS/di72+uJ9r38aUPrk3qWY3nNgWP44nXAGmEwVteiu20LxE/anyfDFj?=
 =?us-ascii?Q?o4w/Wc0QJDsCrSg1TDVSGrdPjbRoPEZ0PEN0eOS8z23Z2ciowhSWbzDBphhb?=
 =?us-ascii?Q?Ay52kWj24evlqaodxI923knEGcnXdwf0c8zNqVGhJj7QHG82WW+gzt5kk4ig?=
 =?us-ascii?Q?JA4C5u0VMB8EBYjm/ZW5CKD4f0covco0+kciIT/iJv5y5T0/TFLw/sRD4har?=
 =?us-ascii?Q?HIPCoo6QDAE6IJbWjeEqPdGtmBC3EyT4BMnnbSx2AB+SYOfqCt4hzEv44fnZ?=
 =?us-ascii?Q?YZx5K5NoVa8xk1NHDTNpmzRSmbvIFuJsW6kuS1ACPID2WKZFexTZ5rILruCv?=
 =?us-ascii?Q?WkF8sYYKTU4ITWfyPjCU9qeqITgyl/ipG16zuLFJobwVtymLjY6aS3L+lkXF?=
 =?us-ascii?Q?rxgfUWQ5YWelDdyN8eyzzX85lbfb4kYJVeQMMao3OqMq8cnafvyQvwS3CDi5?=
 =?us-ascii?Q?4ZvKRtX4wf23jZzgAL9XnO8uRfB7nFadJgKi8xYIFUJuK9q4EySqqDzlhITo?=
 =?us-ascii?Q?uXmkGhDjsde2ybOgB0pXswIeAu0BQkCZIMUeib1xt6H1HaW9X8PqC0nb6hF+?=
 =?us-ascii?Q?0vV8iakuTLXXCU8bBW2sKVEGD6XHrcAiyYu4ZSawSLQD/Mx5UiHQ1Mt7VMG2?=
 =?us-ascii?Q?pD6WYpdLHuTh1Cn5QEHP32pbTbwNNLopbMeacTpesZemPFqP0rzBoBGZeGug?=
 =?us-ascii?Q?AT1HeJqjgrfaM5DY18CRsoZf/Y1BJOa00e/g5IEJDjCx5KvDSR0n3jQUm57Y?=
 =?us-ascii?Q?VS2Jkk5eMRi01/kBD8hteoL9oJhlO7mbx1YNEHlaIwgMycPAsRv4vZuY9iqF?=
 =?us-ascii?Q?0k8rO0T7Ps4U27RWRC4mPTXB395iZCa/ecJjoQZ8u7STtO9SvidTM6UbEXyI?=
 =?us-ascii?Q?SyAHNam9mFVh3UDqfi552Dh4qm+Hq9c3lG4ZXTkpZDbvVdXYWRfqahZd/5sP?=
 =?us-ascii?Q?4+J1uaFhFnjknwqnKm9FlV3qbbXYSky2zuLGpwKIDD8NaqhmwmTK4qNCz0qz?=
 =?us-ascii?Q?dYihB4DBqSbOU+G+mZaaxiBxNhCHd9XP9itoSqTz6a6QnSdk6Msbq9taXefY?=
 =?us-ascii?Q?s70KlC66U+oUVvrX+WpW48YIN1zo/Pe1g6ijeGKOP0kqm1Yov5+nay1SLsfk?=
 =?us-ascii?Q?AMoP3h236wqSh01VSKQoJDNFbBYGbe7GFLfNwf2+4VMGHkLTjh28SaALvsLI?=
 =?us-ascii?Q?6dSU3XxWYcTHuC9dETomiGOg21Kd+VQ=3D?=
X-Exchange-RoutingPolicyChecked: JL22umKvd0v3nk8hOR1fY25JA0L4r0LIwgis+yvClCkhRbUMPXKicsjQgATepJoPX1Nf/9UH9LmZcMsaT1dUNJrolhSgzhKoOO6v8MEetRjvGgwNdWqe63Jntnh163joCwk2fQ0hlwXR35nXzBqrakc5VwaLtjw2v3uBO+jNSj6yrMjAoYkAdvlxnV4OjJ4zAkwzWWfTs6c9QDOHX+N7GCfW5T5Y0daskPKd/tv+fK1KxrY1MdodW9Geojjk2eLY2pfjCsU5XBNFtRAztoghqplfr4HC31dFg/2kqqR8En57xcTgjJDQ7TbKMtM9KsbhyouZ3weKxYARl+/+ZWgSHA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c17469-b1c6-4396-bd73-08df13df9b5d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:21.6800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABjGaAYpoy2dJKk5f2EzK6bFcjqC9QYlZgRU2XOTVO38UvWBcS3Eggzj119tjlZUr2Hut0P4YsNsFKD9tBL/5Z3TAPpWel0xl3xmaNold30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXxTDLGFL8AyqA
 PJPgH8XpyN3vlQxtndYYE9wTnobK3lkTudDgQH4dVzOT+AKwSLsl8bCX1JNGwDz5b4zHZ0JPqh1
 0yFYgvO91MWYYw0+IvGHgQwL/FiaJ/QHFN55vGokY8rEX1R8SQvyub4oXg7/UinVkUQGHVc5Z4d
 wo8lf7HuvFkg6yAAKmBoMRbODUolvjfu5agxHqZy2NBNYxTeyYVjtritIlrf8WK+S0ghEkoUqQ0
 /pPt01oA4UrGi9RbFCpuLBiBr3W2wgvWB8+sYzAB1DMymedfb/skQxh9zKm3torDwenA8KwXl95
 Tdg61Mf2JK3dGIcLoCGu48Na38o0YXNr1ycg/Bo9TgsG5hmixDkSs7Uyyu5/jnE4gS9KkIwueC6
 eAWNmCsi/q3cmBdE1AIy5ht7qmTKse63cO5uqOiZtvSUl1/kbCzStIk+lOMmAaKIPIrD0MIdaE5
 laymsUU9yzDnDq5fqFQ==
X-Authority-Analysis: v=2.4 cv=XO2l2ghE c=1 sm=1 tr=0 ts=6aaa7342 cx=c_pps
 a=QrNjdqYeTG6M0XQO4N/sOg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=AnAY-G272_MYj7koicQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXy3hCaGO24Dnv
 Tf5DCCUWRRyNelbW0P5uC/AZMJv1gPs6rTSMHuRWMBZoRGX3jH/TGZIZr6sallFuLLPN9JSb3ch
 k/wEtuWTFpKZQg8EMHvCS8KsgTNob80=
X-Proofpoint-ORIG-GUID: Ye0svMxooe8ZJkyyGMnl99pJQBNl6-pF
X-Proofpoint-GUID: Ye0svMxooe8ZJkyyGMnl99pJQBNl6-pF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 28e6e40bd2..9793473163 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -137,15 +137,12 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     k->post_load  = kvm_i8259_put;
 }
 
-static const TypeInfo kvm_i8259_info = {
-    .name = TYPE_KVM_I8259,
-    .parent = TYPE_I8259_COMMON,
-    .class_init = kvm_i8259_class_init,
+static const TypeInfo kvm_i8259_type_infos[] = {
+    {
+        .name = TYPE_KVM_I8259,
+        .parent = TYPE_I8259_COMMON,
+        .class_init = kvm_i8259_class_init,
+    },
 };
 
-static void kvm_i8259_register_types(void)
-{
-    type_register_static(&kvm_i8259_info);
-}
-
-type_init(kvm_i8259_register_types)
+DEFINE_TYPES(kvm_i8259_type_infos)
-- 
2.43.0


