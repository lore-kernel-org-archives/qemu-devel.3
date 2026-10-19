Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C58CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8s-0001pC-QN; Mon, 19 Oct 2026 08:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8b-0001NW-6N
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8Z-0004B9-HW
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:44 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QSQV3508828; Mon, 19 Oct 2026 05:06:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AbKFGCy6bi6Di+SjRTibND8oFXMooQqZd57pXAx9H
 zs=; b=BexHW3YkOkiqmixFUVy2Qp1/kd4vwMG2OiIAhrOPp7ieXj1c6cbtmfzwK
 9z6ql4hAGcYm2ItPbTS/HZypwMwP8AgWKsvMOxfIUv3+Vk37c9CrLhCFG7yQFSjr
 qxLNU+mBkSrjdE8VWrzGpdbG5OKgQNluHRsH4ejo0viJ+SfsJdFL3sT/A1SbAaaL
 RtFwBT2Q5sgOGtxF0i2zumMzq0Y7A0Lh3pkqBJNvm168EhNTt5G1MJSNyzq/iRj/
 2a+z0o4LAbkcBEOuK4VocDYO5jCnAVfX8w63EMQJyKVZYJo8ObjYLB9J9VLUhJGW
 p+bGGpVNPBz3ZRo6SEKOMVj8TfqFA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021128.outbound.protection.outlook.com [40.107.208.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc4x43qqy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bi8p4BXwFLqpPgeqYATRm8MNI0zBbrTWvpjAVZkEKsXoyiyOpbZZHvsxuPvPXoVVFfjaTfu3geoLJ99LeWQ982Xj1xjkAXzEFTjbN3YtRfzHY8CL9BWaOdul4Tb7DQbKnlWJ4QUVSkkqCnsu0sOoGUv0lJ9wc9M0nzbuZ8DVqPY/OHYhV/woSp8ck1LnMNnwO/mqC7Ic7QhJUs6kUhXJMPxypNN9g/kPoglisydeJHQQqkA7C8oDxQZK46NMJpZnuqGR1xmxOF9Q071gp5uLTKD7orH50Z1Rnc0bHxag7AGookS3hI7Rkvf0HV7YjnZAyeRgorlhW+sWsnWpbVNllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbKFGCy6bi6Di+SjRTibND8oFXMooQqZd57pXAx9Hzs=;
 b=ANhEa3rpGGCiKw98xmIY+SQ4xhtwVW9v91oqFB6WKlmJ2r8blNBuME2hjM3OfIPa27EwiaAwi2ChA0NTClAyR9Dz+F2/dGz8f0hhH/zhmOm1dfPn5d4F/HDg+mL+/Bre5DmYV3BwLOcWNa8KN22TW0dvo6vArplMlWzmJVqld4OwTnfGw9pbd1j1MESaX77bfuKW2SZQuzy/esddtMOxzAU0XFQvgpj0jJBedxKXt/RJhXgXrhp5EI6C3ZlHPIoim19/u23F2Iz5NpVBolujU6D/nsyO6hCdrB+WgmJFupKy8Vgf+azYOrKvzKVQuiX96CbWl3QZC1xh9dAf/ZlhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbKFGCy6bi6Di+SjRTibND8oFXMooQqZd57pXAx9Hzs=;
 b=EliVQ2rtjhURbkeHEpIoLl+VIRiKjxNY1119GUXQLN23UIgh4+eY/VvkmQnue3FbS//qLZxZykj26H4alJiupbpaVA5uiZpznXEQ43HIXuWtNVddk62PIQx4N+8K/kHfarCHiwWxCokN7ygs82iNOibA6FhdzHqoRibYb+WUDdOJNzI5+3SU9AGC1LTbxuJGgRi2kOa9QSLQGMMx/GyGdDJzV1o9zJxdJ3lRs2shQ/zS0ti5aDkzHa0nYRzuRGuvYDhZC5sED3ijQ79eVfvXIWcT2EOWMr+SXJAxev4o8Bm8PQ1Ee5bj4IEB+gyldwoSH1/Ex4UNlWCFjUFUuSgHAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 23/28] xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC device
Date: Mon, 19 Oct 2026 13:04:55 +0100
Message-ID: <20261019120517.1448687-24-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: df20da01-0b12-4afb-838c-08df2dd96c43
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: mrUtXT5iNAoPMSImOxngGGKgtq/Nk+Idi1ZNQwXcYbA0ffSRwxbwF/DYVEd9odGRsEC28saT3Fy/+XchkrseW30IZrz6hZbEGBTuMLoPTHg6tCpouO4mIdqxm4TbvANsu+MkCMia0G3y9Am+LEJQOe7GOi8ceC/UfKuU+eKvqacQilEwHbouhI10/uUseYxYOPMPS3XL+TpfAk2mN4Z+zIp1puoFfAyWkbhbzxVIPof93tHNR0w4LgU9O9YJeujxAI7YnSczRRs9+m0y6ugx6lt0uhf1oTvwqQ/mHaNc0ZzZiLTqZoRUtGNfIOEo+kgzKSqYbw8AgtTl4RQTEAS7KRPQ24E9rS9lhIT/SJOSb8BViXf7F2sxj+SwJUY58r8PJ2GtdRj/Y7pGt8D4m4V0cg2Kky8FMlOMQJfWL/5PEAeiSY/IVjb6LZTZ+zEHfe34CgkQEiMrE2QPQ3H+EWdar6nmov9qk1GCG6YrYyOYTrLhws3Ma/13upDmzpSnCszzh8D1T1PKTmw/aD4ygbBGjC8C6NJ5f8Gy8jYgW63xXr4/3+MfsRpDSUw4BMowaA6EiFA5ufyu+hyzdGaatDwBVLZMP02xprBUEGldPQKHMCluKMQfufE6B5csZAAZv8b+KRC227EZSn9eYt1z6edtNPFOACKqlgvjFJ8pdhD2cHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pgKimP+VDRGcI4gXBGZ240N5OOOgBEZTZKv1L/y+EO0MWAvjmMADYTwPFsa1?=
 =?us-ascii?Q?zmjPpSAcovRFWtAbA6Cp7KnoKym/5G8R+BjL3GdTodofO3o7TSN20TvfNY4T?=
 =?us-ascii?Q?X0sci0CI+wMnkyoZTGyDreixWfYu11wtNZ0m/sx6IQ/4bBXbZMBAiuoA0tnz?=
 =?us-ascii?Q?g3yjqZOhvfNkfL9a35GNW7LAWCpSOQnNqDEafaqIKLH/DPBP+IU0XX1pLrQn?=
 =?us-ascii?Q?aauJwQvjkh2o4yTfJ/Ps/C+QVnWk5lY7vy469oBr+HspmNxJ5cwYSieKE1Mq?=
 =?us-ascii?Q?Clcung4YjXO1/xAl1pCvMPR+z16ttAAaznmnvJSloT1xPd+qePLTIGTA+LLl?=
 =?us-ascii?Q?hjc8D3ejsaf/AkL73zOWZ2OE0CA0SDH7ijEG2q8a/aqKKQggg1Ke1/MxAjdI?=
 =?us-ascii?Q?uYV+1Fc3+l55USwLGO/gGb2uVKw2hLO7zay3yxnDPfM5VW+HHOLEMx4QHkcf?=
 =?us-ascii?Q?QJZD/onm8vnv5sTwZgY++d636TIH/vxIBYjA1rmNTvlgmsv5kXd0GTjv5vtr?=
 =?us-ascii?Q?ED3i/lTfDCPnHUwPgHmvG1v4idzw0kLBZJF16CajJUQ1RlDMLij3TEnNu+wj?=
 =?us-ascii?Q?nQpF3yh7th3A4wiN3COsXc54Zs60sZHsXxyfqzTPNPLKFh+dzIPIgS48R3Cc?=
 =?us-ascii?Q?4lu33LS+OrwQ1K7QEZpnauSj23R61rZ+J5V7oWLhQVOvHJJ3VLSH6nJJ+Esf?=
 =?us-ascii?Q?OhI4v+z6Nc7JbrJ3P09TGi9TE0qCC+oDcA40kU+kPqDEz7qVx65IY1dDjCxX?=
 =?us-ascii?Q?OUjr1hRh7y3S/YlhglKUyvsr5l4eTEsooNeiEBs2PQ4g1GdxoOmOEmDdczXi?=
 =?us-ascii?Q?dig12R0jA4qrjO39PTV2URdljE7AGl+dkjn5I0OVQ7+8W6aC5dnthxLjVxwI?=
 =?us-ascii?Q?enJsHwuJAnNStTpeQiO04jWwEpNqOOaLpLSvVoITMczFPDHF/s3GlCglniSm?=
 =?us-ascii?Q?HkM8/64OL2YJkkC5p5kbEeR3S50iJ3Jis868JlBLlDTDueQzRguYfkm9eo5k?=
 =?us-ascii?Q?ZOaOboijtvcGmSneulLNrexFXsUezHHtPvXE2QZ5d377O3Y0pceCkQB2z7Br?=
 =?us-ascii?Q?2WHUk7UIh0qv0fTzegWdRpgNiRpxcanK4H4HsutvSmv/8kT0HqeX36wQC9RO?=
 =?us-ascii?Q?VgRyRpYH80Dd6rvF7R4yRBb7jAbUNphqIjUSG+oWO2GFuYnLZHc5zYTS/ETT?=
 =?us-ascii?Q?Wyn9Z49XfnelQ5zejba1A6cun5uePbiY/DslmhIN4QlgOtFqZiTIIEP3/Lnv?=
 =?us-ascii?Q?oCsMawjlTv0VU8tcLph6inC8j1kXriTyIYuF4lNh6TkGC2hs38svKGiSaggs?=
 =?us-ascii?Q?Osin5rVBqDeEvxK/rFzPCtdVbYyRjKlHK3vzHCYZFiawGgLYkIJR9luUjk3+?=
 =?us-ascii?Q?zTO10pmsoTvxcX+/xP//WWKa8nsjKdPH9piKH5KzfZy7bLGOLkhy5API3bq9?=
 =?us-ascii?Q?PhzuTYnDVZuxyOkk3bI42n8k1gbf0AGABSsgvqq7/OjKZZJ9q2KfI2gXgHy1?=
 =?us-ascii?Q?mcP8UPw8YBvk3DrraLHUXyN0p+Vo4e795X4wdp6M9rzzrPNh/BLKJVGbWTFR?=
 =?us-ascii?Q?6yNoZgYXuUy192VzqwXH13+l4v5/d1ParNZv49RFY8eu4z+1R5cBl6j7EYQ/?=
 =?us-ascii?Q?cMmD3oz9JpVfDpmbJ9MiMXWcQlEu80eq7iwunXWCiaMomYy8a63zL/gHWja/?=
 =?us-ascii?Q?9jRpIwTVBXqcmfcaBlfnKeNl44LQEJrQBtXuy1s8Og3hFZnfSLzhotTU2hvQ?=
 =?us-ascii?Q?ourOrO8ekwwRDETBOqZrpSR87EjdXTQ=3D?=
X-Exchange-RoutingPolicyChecked: hda0Ne5LRgxZndcFe+UbmQX13CpMIBnX5UvKtm48MijsyMKTsPx+a4pbUdMyY+tXooPwTf5Yh1uKhjxoWLTXy9ba58yaZp+2DCeVAGHRuRQjHZAzY7KhLqYwA/8H4NanKm9nHFN0jrfZ5x5yNeQRXwog94ioL//U9NtElawhbUEPj1lwFxk2URqbfR86F9SVkb6kPkRk84npf1UyOdVV7Wyp/P8+02BxecY6ntHbc/icm98GoBW8xwcIcRXaf1SAeY/nwTuSe89ik29/qNyK7NLQqAyJ9wXsKrh+vIqGXTuIiw1xIXpsWAiz1X9hFCiyf02rI+ne8qAbVzplDivEQA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df20da01-0b12-4afb-838c-08df2dd96c43
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:35.8357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgSpoE7Nn7l425ii3sZz1lTnLwuQP/zoeLONII8Am2VzxhMKBBJm10XDJRVRq8O0h2XZBc1zi4ah7M3NjjTuUWdAUyj2sZSziNq85i5Wb+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Proofpoint-ORIG-GUID: 7hT8YounA0wJWlf2RGeb9zgeUtXMAIjy
X-Proofpoint-GUID: 7hT8YounA0wJWlf2RGeb9zgeUtXMAIjy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX5KNoUZ6EWuA3
 2rJMkJanZ2YduW/iOkSzR5WHNR2dOeTfKwBl7ENmWsWB/v/OIu6wC+hlaiwUjGdD/CNJz46vddH
 LGm4B7icLrvC1L7OL2OrODskaInwtoo=
X-Authority-Analysis: v=2.4 cv=DqHDa2/+ c=1 sm=1 tr=0 ts=6ad607cd cx=c_pps
 a=HH4JkQGtkLi2X7RbypODRQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=tqVLSPGIGyqkaOPIRdYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX/Al4jhd3a+dU
 hgCPyKt7lFWJt+q+a+Y+C9Clhw/p0lq68OJks8kbTzRYSVcba1y7vUKU61woW8iw8fIBNX8ZuoC
 riOhEewYXVBOrB/CdyTWJSsob0VpoB/i4iGpu6TcMw8qyxdb2nzUv/xkKl8y1XpQUnmu2QUJFSO
 IjbXPoGvbwwVIlDcflP9OClSZhu0Xi6eRDrYoev0o5aoS3HC5dm33+suemZIQC7FCzZQLozPDlV
 QULE5MgOc0AYcyA9+BeLP4F8Lzl8Md37XBnDbebnymDsadZAuhZsMfVI4zkHV+h7hyb25mN7ySl
 /etFMo0SjzpmqmaJPUmWSUc43+emkmMV7xpFsigolH0XqfhBllJoQrlUbHhwhyZBR/TGZxI/nXr
 BcmcXO8nu6O9VMDyU/2ISB38jlT/big+oC9uBJuopz9RZPJVMWnvkptbDkmoRpXWl1MiNPy+1Mc
 p9CBfclzlAJvYPIMC2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

This device represents the Xen PIC for an x86 machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/xen/xen-hvm.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index af3a90987c..b2378fe3f0 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
+#include "qom/object.h"
 #include "trace.h"
 
 #include "hw/core/hw-error.h"
@@ -69,6 +70,12 @@ static unsigned long *dirty_bitmap;
 static Notifier suspend;
 static Notifier wakeup;
 
+#define TYPE_XEN_I8259_PIC "xen-i8259-pic"
+
+DECLARE_OBJ_CHECKERS(DeviceState, DeviceClass, XEN_I8259_PIC,
+                     TYPE_XEN_I8259_PIC)
+
+
 /* Xen specific function for piix pci */
 
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
@@ -114,9 +121,28 @@ static void xen_set_irq(void *opaque, int irq, int level)
 
 qemu_irq *xen_i8259_init(void)
 {
-    return qemu_allocate_irqs(xen_set_irq, NULL, 16);
+    qemu_irq *irq_set;
+    DeviceState *dev;
+    int i;
+
+    irq_set = g_new0(qemu_irq, 16);
+
+    dev = qdev_new(TYPE_XEN_I8259_PIC);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
+
+    for (i = 0 ; i < 16; i++) {
+        irq_set[i] = qdev_get_gpio_in(dev, i);
+    }
+
+    return irq_set;
 }
 
+static void xen_i8259_pic_init(Object *obj)
+{
+    qdev_init_gpio_in(DEVICE(obj), xen_set_irq, 16);
+}
+
+
 /* Memory Ops */
 
 static void xen_ram_init(PCMachineState *pcms,
@@ -760,3 +786,13 @@ void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
         hw_error("Invalid ioreq type 0x%x\n", req->type);
     }
 }
+
+static const TypeInfo xen_i8259_type_infos[] = {
+    {
+        .name = TYPE_XEN_I8259_PIC,
+        .parent = TYPE_DEVICE,
+        .instance_init = xen_i8259_pic_init,
+    },
+};
+
+DEFINE_TYPES(xen_i8259_type_infos)
-- 
2.43.0


