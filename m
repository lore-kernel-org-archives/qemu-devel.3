Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3E8C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n9A-0001Km-Rf; Wed, 16 Sep 2026 06:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8h-00012q-Mj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8f-00030l-6K
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:19 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G83uAV353108; Wed, 16 Sep 2026 03:45:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rqR4OCxXqweOsL/Jai/0JNZHCvy6zRsE6FKKgK6aI
 jY=; b=H0kEaFEAk0x7mAXoWd6tNILZjvshdU9zZNf3G0EmkYPl2SUvBN/9aHhe6
 f9QqX7HYjp79po2IF+6cgQO7e9pYp5vp/wKOhk1//rqDRnMtLM8/zGplVKxzt0U+
 4J7niN1uwSe6fjRh9iIEMh4IzpXV9+cflNlO01AIr4ju7zujJck5yCfeYZ+BU3e/
 KPV4R56lbxxmaIVP54hxvjF3alMC4ExD8H2wbuCPTFkBUrDrdwcjHc18bWp9ML3z
 vpwPTxxD2K4YISOPRZIhqziVF7LqN182HYMjsphglDIJSjBgc8IIEOmFi//JWhaW
 Q+ekL0KJhUWr7xDjFrdtstiwXVrsw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021110.outbound.protection.outlook.com
 [40.93.194.110])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gq9drte5n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTa+P3NbkbGcSQVfHFiBBmzGHTE4TbgzPEiEAfspzTqnYKbS7tlPLYHywt1oKlpjXhtvUUK1UCYQ5ofKMSmfClgRJnvhj2zWRSFeJV8dtKnluATOKH6tR/R/VbWMBbZy4Lm3piFrbcYzir0M6vYvKXciLh9LLcw84YxweKAcUm/cCpJxI1crKMcWeBKJ8hOmGdEm6UpX9pgCVhscRpWEkXkDDgrn91cKSGg6Od+wJjouFDE8LD2O/V0FBr3sVXK8ca0DRDLG8P+Ow6/y5UsnlmW2RNOjureKhdNUT+KaLjOLGiDyFuSiblfPZ2+xE5eHeCtj2Ux3WZDyw0b64o75fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqR4OCxXqweOsL/Jai/0JNZHCvy6zRsE6FKKgK6aIjY=;
 b=v436zD+6gmFY3AlR0Easw+y+nQDH/rD0YxprzFKXWZnAitPAtmMBSCqowUIGACBGuhlckABFT8+kFKHdPVuPN0nd6fRrhKQCsMv2aCGBhv60u+j4l+LYaObSszH4XlN6KCoojswqpiNvnMcjixbPkwLqgE4BFD93hffI8uCH1ZIlQeDpvVNUifBGkeQ99flpBmHqOlinA6EgWxVeXTX0ncrxgPjoOn4sljcboczRb8XAZXiAtu3zoJOLDb26xTwVNmLB6hXPqRFJGNWGOOY0+SoL9qixUQ2RlEWLMtbMzQmB9ukYmE0XXTaHyPlEJq4upzKskdIOK2k3ib/cUtyKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqR4OCxXqweOsL/Jai/0JNZHCvy6zRsE6FKKgK6aIjY=;
 b=MeViRYOai88j4s90fB9SIlPLROpBc4cgsxWi0V2lJ0Aa/3k2RcOi9E3SycAcGQz/UbcrBOts754tqcIB7wCtRShxF4KjyOuKYjPDpNyP0HoiRZeF5+gKv8mfBEvc8/9p2/119qiSNsk1niHPDo+f4xf40ulhzIrAo9qDCTkMBtFlbIspQGwraV3zMr5a5127Gh/+PJE+7WNghhA4DYL1+iaPYFN3OKL5TLxjcVfiBK78DEzGqyxLILwcwKEIZs0jkGxVpXTCeHdSYmEM9P6cUyikVdHaqWGc2JN80pnrU9czcf9h9lxA3VfWKPTL/LfI4E8eAuv5eFROFiZroymcbw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:06 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 08/22] i8259.c: use i8259 prefix for functions
Date: Wed, 16 Sep 2026 11:43:36 +0100
Message-ID: <20260916104435.600211-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5269b4fb-f3a4-4e56-f155-08df13df925e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|3023799007|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: SXbMYsg9PDJTvWMSgZQzZCkvXjgTQ2+TLB0GhvRj+V6lHb/EmBlvF88+J7O6LC0olFrmnNJRUHvPDUa1oIhBMrPyg8AGlDRx2xFjug4DLUaOo2PWH53IB8BO2fYmPy0RsXYfjV4uvDNAe3O1PaakYeekjLGtc5cvoE5ItY0snjOJejNoiR+ebcXRwWf+cIzShQrQQM3cktPT9TZTBzdALUApnmtCEP5dxWM7VHbNBIKA7PrbYDfPlUXyQ50gx9xeGBCDgXcs0j1bf46EMLeTtQRgXnSjE1ZX0gRg8xyCgsqL7vKGGG+KhdR1vVd4zzQbPEGEFOl8YYhnDR2uPc34UlfIeNkIBaDcpL9VXxg09BtxvrKihlj3UFFzkPIezXzmjh+982ubGUt6Ct5EocB2adghobQpwO3G+a7M0mJB53Beisb/BcXtB5VZFoJxDG291NkUqt1cOVJNADj/vHivoTMaEkrGRspjqJ5qx6U8SKJyEMTt0bD3b25IjzkCMuzry2b1rVEcrRKs23BcvHRX5qX6IMaXZi8JqnbOGwzrmUX1RsjMC/Or0XnESkOx7GdNJSFNmnEwh9kmCrcNX4UzlUla1RVzaitzLphTCz0HQ3ChuQJ+yNWVMwnYPifO4ccpEVXyXUaCKDT6osfDXxHnncmjOP73hmfuwjBCeVIVUL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(3023799007)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P1Je7kpW/EvkbA5e7LlZ18HfjbEI6+lpILEQjUrTYR4C7EsLgQtSr6MOoQfA?=
 =?us-ascii?Q?idHi5b6lKEAUJKYlqUgaRBEbtBXoIahhb8VT217/4j/mOKaZjKaLGfvoDYU/?=
 =?us-ascii?Q?vLPYrQ5eSWk4Ldpvt92G6YvjLniq3VoOTPtF1YH3A9P2BH6pPvTMrfZy0HvD?=
 =?us-ascii?Q?f6LOo0d9hm0PQPGWiT0aNPoKwHQsnw5R5GHTmXrZr8g86Vp0+71H2Qysv9FK?=
 =?us-ascii?Q?5kzXqDU/SGATK1rOeWX7zMUDF9vOqFjzeSsObFiZYNaKCQRpa5vYO0gT+/1p?=
 =?us-ascii?Q?Aqlqr9aL1KQ6bYCgCvJCZ/DaOMmbnOPVljHqMEasVdZucoiqLKnlfBLS3CXs?=
 =?us-ascii?Q?cK3jGebr5BUJxBjGM/9T1FE2hAOVvT9BOPzJKjQqEofL/dIivLFEU1R2Ok5u?=
 =?us-ascii?Q?7nT0hHSTBiuiOKVRgG9OhF4l2Vy0YAAC5tHyDvlRLG1PzNXh3q1sCvpxJcRJ?=
 =?us-ascii?Q?zgi1nRbFjFnHKDMDZw5TBHTjziY1IUCcADFqDlsAUDvIz7pqijtUWmepMKJH?=
 =?us-ascii?Q?P/yVFLIdFN7BW2edaQFru/dVCf0acgZ5O9MzEbZgUAKRSXxqUu0Xz8nvfk+s?=
 =?us-ascii?Q?1VBtXn4nY1yhgSXZYGKCb4E+qlIATTS2kP2ZuHAQpBOk0MzclcRNIVGzMp+H?=
 =?us-ascii?Q?ruZAX81HquedrY/tcPqhggLKs1rNJLTb8N4LU621Q3b+7KZt4wH/2QBnM5mU?=
 =?us-ascii?Q?QLGjlooX3g6I6BhH1Q7Q4BDWi7a6cK5k2wWSjhzgLFTB10AEeirpo31T8hQw?=
 =?us-ascii?Q?vLugoblKCs2xw7jS3pbTAsNPp+eAcg5lJWa8IIBVqP4qZW1wjZscknWbX2cw?=
 =?us-ascii?Q?MJzeKA9v5+q0CheeT690etezrKiGPdwWERZSlioA84DLGqOEDvXfAvKKWTRa?=
 =?us-ascii?Q?dBjml10v+oZj1JQlma0cDwmAu2mxfZ0a4TIcUP196IgHNixXNOeOBi2kg6o2?=
 =?us-ascii?Q?79HMDIT1dusYtyhYgoDYoPF60XgpTYsL+SkwGL5hO7o5K6LWktbGoEkIa4X7?=
 =?us-ascii?Q?SoCI6fNzRshBtLnLHPrHDuGRensix/akXGK08Ytaf0oMYkBFF94W5TXCOPIr?=
 =?us-ascii?Q?L3+83z3rMpNhSiuWLi/RVO9ZAtj0rJSzjyTfLNFDLYtJsDZoI9aQO6Med0Qu?=
 =?us-ascii?Q?VWGYNJQKnF7ym/d7NkUnCNHBBWUziwxP4SdPSW6hnm/u9lCfotBZiEIX4AEx?=
 =?us-ascii?Q?4qgNKREWcCX0lA2fCPvLApNnKhbXzUPshRvKvnNtklq1EETVp7kKtRBhALaF?=
 =?us-ascii?Q?QIzcLBaf3nLrXV2GYDtB/ex1quYX62+k8WkXFYLISm9PqQTae6s1A0cNAdfY?=
 =?us-ascii?Q?trS8Xj8xuXc2qW1/O00geHp4J1g/bXcaQB0nq56IdfJITDdWub7r8MY9vl9V?=
 =?us-ascii?Q?FMlzdj0OvdjgT49hOA9F/nr294iB7LRxGWJ+rHI938f+GWjhh/uMYTyfAkfY?=
 =?us-ascii?Q?6jfINCCZ+YUhcHxx0GnP161J7DN8vKD6qgJtwR101bbc5TMMU2gF1U/3TpS3?=
 =?us-ascii?Q?fi/2EBT4BwCU/BbCBjo2EVDfg/yEdhgpECFjKsfaJPIzYq0LoJNvLE3WHNnJ?=
 =?us-ascii?Q?M7aBd/MP2STWP626BxOEg5bfCtF5bQLTGJPnD37GYJkQa4TWVhRiBigqN8C/?=
 =?us-ascii?Q?g7fBu/MuSuec+lPZRmILPoBr7xQveN6bdoCDvPrpPvl7+2Wv4xOQPxNoWKbl?=
 =?us-ascii?Q?Lb5ryQYd0GmTpMFGu25Eb30otf7mhukMno9hKRt1x7X+J9cq40t/2JyosgCY?=
 =?us-ascii?Q?hLSxuhJpM+ae8zfJzH8LyqM6aX8NLBg=3D?=
X-Exchange-RoutingPolicyChecked: Cy4e4t7YytaJLNU/lWLKjarCPi/7bMQaBpUfm9LZSFU8Kz9o7sRLOVOi6QfIr6rL5OSok1BbwqY9147cne3A0wVJYftaMVQ6bIP59h98jP64o3gGjQwju4F4z61sCcCOgV/UPI2qY2IrC6C+NY+HeUaPT3390TPsl4Pel7Eh3pAZOYVFHiBIQ4BM7szTxmNDBdGPeAzlC6hbePHwFYHO/NjZnP7GzDNnIjS3n3u8jFLC0yuSE68js17KwFAR3PWyvk4aHCLZ0f4YWXpDS5blmX5ujAZP7L0SLZQMScgr1bfDBE5jbGMoWqoYC1E63Z53rAskEwFhw+JGBCDZr4XfEQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5269b4fb-f3a4-4e56-f155-08df13df925e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:06.6799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNvxgy2qQDgJT2Y4XeDnr6kOQYB1MEYjN1+V92FUi0rUqAHOYa2JinLQx+MWSUiEFP1eTJ1YI2RdO+TJyInslXpGI55FNE+VDbpuIsGE/04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX82gp2FDuEBHv
 Qcsl7T+xAtQ+rY5vFovefwtSFR/hzq10ufPcduLb7/T/0Qrj4ROxb1OLjNOsirmc/nqOKQoXth0
 kNPcUe+FNPkiv5xjzlHZunL9so9n+YCDb3iJXDRalDXqt1r/icHobVaKjuGBdKTwB7SzgQ1fmO2
 dwokE06wAsjpeQvUXoHVDNCs4eTSJQRvUEzE3OIIcc48XgJbH2ebQjr3QbW1+FxJA+VQvayXSn6
 kl8jNu8J3U4drObBYonq0H+3TWsL/uMhKC2Lj8HJ0M4sVCruwyzTybLsZXYoiTHjezjHejNX3QM
 fByXxQHB5sLNbHvlgnyF3pu6hMtZ6ISQuoanpfh+BeaKnnkVvNwpgCd3fIEorjp8UhOEqkDLwuW
 8O58iUAmGHFNyxbJMzFCS+TqpPK+hgSH71yLNY4MOX63FRkR4CDFQFibr4VVER6JFcgxoPvuPC4
 oC1bPExP0kDDDI50MzQ==
X-Authority-Analysis: v=2.4 cv=XO2l2ghE c=1 sm=1 tr=0 ts=6aaa7335 cx=c_pps
 a=is1TPszdXRKtgCc8Qn4wPQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=BS222h8BhpbHzx9SlcQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXxWnwiWtsqE83
 OYoNWSplpst/B0FCIEvDMBHcCGGiLgWzs5bo0mB5eH+c0t9+dko21ENL7DXw0oG70nIBSUmsqa6
 goxqbtI37E9+GQkqU6ToYUxGAL9rjfw=
X-Proofpoint-ORIG-GUID: FgC-zqXhrwH76hr1rGkCGWtBbHOJ5WVj
X-Proofpoint-GUID: FgC-zqXhrwH76hr1rGkCGWtBbHOJ5WVj
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

This ensures consistency with our normal QOM-based naming convention.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
FIXME: rename trace events?
---
 hw/intc/i8259.c | 96 ++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 0f823f9824..f2d8cb1489 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -58,8 +58,8 @@ static int get_priority(I8259CommonState *s, int mask)
     return priority;
 }
 
-/* return the pic wanted interrupt. return -1 if none */
-static int pic_get_irq(I8259CommonState *s)
+/* return the i8259 wanted interrupt. return -1 if none */
+static int i8259_get_irq(I8259CommonState *s)
 {
     int mask, cur_priority, priority;
 
@@ -88,11 +88,11 @@ static int pic_get_irq(I8259CommonState *s)
 }
 
 /* Update INT output. Must be called every time the output may have changed. */
-static void pic_update_irq(I8259CommonState *s)
+static void i8259_update_irq(I8259CommonState *s)
 {
     int irq;
 
-    irq = pic_get_irq(s);
+    irq = i8259_get_irq(s);
     if (irq >= 0) {
         trace_pic_update_irq(s->master, s->imr, s->irr, s->priority_add);
         qemu_irq_raise(s->int_out[0]);
@@ -102,7 +102,7 @@ static void pic_update_irq(I8259CommonState *s)
 }
 
 /* set irq level. If an edge is detected, then the IRR is set to 1 */
-static void pic_set_irq(void *opaque, int irq, int level)
+static void i8259_set_irq(void *opaque, int irq, int level)
 {
     I8259CommonState *s = opaque;
     int mask = 1 << irq;
@@ -137,11 +137,11 @@ static void pic_set_irq(void *opaque, int irq, int level)
             s->last_irr &= ~mask;
         }
     }
-    pic_update_irq(s);
+    i8259_update_irq(s);
 }
 
 /* acknowledge interrupt 'irq' */
-static void pic_intack(I8259CommonState *s, int irq)
+static void i8259_intack(I8259CommonState *s, int irq)
 {
     if (s->auto_eoi) {
         if (s->rotate_on_auto_eoi) {
@@ -154,31 +154,31 @@ static void pic_intack(I8259CommonState *s, int irq)
     if (!s->ltim && !(s->elcr & (1 << irq))) {
         s->irr &= ~(1 << irq);
     }
-    pic_update_irq(s);
+    i8259_update_irq(s);
 }
 
 int pic_read_irq(I8259CommonState *s)
 {
     int irq, intno;
 
-    irq = pic_get_irq(s);
+    irq = i8259_get_irq(s);
     if (irq >= 0) {
         int irq2;
 
         if (irq == 2) {
-            irq2 = pic_get_irq(slave_pic);
+            irq2 = i8259_get_irq(slave_pic);
             if (irq2 >= 0) {
-                pic_intack(slave_pic, irq2);
+                i8259_intack(slave_pic, irq2);
             } else {
                 /* spurious IRQ on slave controller */
                 irq2 = 7;
             }
             intno = slave_pic->irq_base + irq2;
-            pic_intack(s, irq);
+            i8259_intack(s, irq);
             irq = irq2 + 8;
         } else {
             intno = s->irq_base + irq;
-            pic_intack(s, irq);
+            i8259_intack(s, irq);
         }
     } else {
         /* spurious IRQ on host controller */
@@ -197,23 +197,23 @@ int pic_read_irq(I8259CommonState *s)
     return intno;
 }
 
-static void pic_init_reset(I8259CommonState *s)
+static void i8259_init_reset(I8259CommonState *s)
 {
     i8259_common_reset(s);
-    pic_update_irq(s);
+    i8259_update_irq(s);
 }
 
-static void pic_reset(DeviceState *dev)
+static void i8259_reset(DeviceState *dev)
 {
     I8259CommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     s->ltim = 0;
-    pic_init_reset(s);
+    i8259_init_reset(s);
 }
 
-static void pic_ioport_write(void *opaque, hwaddr addr64,
-                             uint64_t val64, unsigned size)
+static void i8259_base_ioport_write(void *opaque, hwaddr addr64,
+                                    uint64_t val64, unsigned size)
 {
     I8259CommonState *s = opaque;
     uint32_t addr = addr64;
@@ -224,7 +224,7 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
 
     if (addr == 0) {
         if (val & 0x10) {
-            pic_init_reset(s);
+            i8259_init_reset(s);
             s->init_state = 1;
             s->init4 = val & 1;
             s->single_mode = val & 2;
@@ -255,23 +255,23 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
                     if (cmd == 5) {
                         s->priority_add = (irq + 1) & 7;
                     }
-                    pic_update_irq(s);
+                    i8259_update_irq(s);
                 }
                 break;
             case 3:
                 irq = val & 7;
                 s->isr &= ~(1 << irq);
-                pic_update_irq(s);
+                i8259_update_irq(s);
                 break;
             case 6:
                 s->priority_add = (val + 1) & 7;
-                pic_update_irq(s);
+                i8259_update_irq(s);
                 break;
             case 7:
                 irq = val & 7;
                 s->isr &= ~(1 << irq);
                 s->priority_add = (irq + 1) & 7;
-                pic_update_irq(s);
+                i8259_update_irq(s);
                 break;
             default:
                 /* no operation */
@@ -283,7 +283,7 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
         case 0:
             /* normal mode */
             s->imr = val;
-            pic_update_irq(s);
+            i8259_update_irq(s);
             break;
         case 1:
             s->irq_base = val & 0xf8;
@@ -305,16 +305,16 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
     }
 }
 
-static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
-                                unsigned size)
+static uint64_t i8259_base_ioport_read(void *opaque, hwaddr addr,
+                                       unsigned size)
 {
     I8259CommonState *s = opaque;
     int ret;
 
     if (s->poll) {
-        ret = pic_get_irq(s);
+        ret = i8259_get_irq(s);
         if (ret >= 0) {
-            pic_intack(s, ret);
+            i8259_intack(s, ret);
             ret |= 0x80;
         } else {
             ret = 0;
@@ -337,53 +337,53 @@ static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
 
 int pic_get_output(I8259CommonState *s)
 {
-    return (pic_get_irq(s) >= 0);
+    return (i8259_get_irq(s) >= 0);
 }
 
-static void elcr_ioport_write(void *opaque, hwaddr addr,
-                              uint64_t val, unsigned size)
+static void i8259_elcr_ioport_write(void *opaque, hwaddr addr,
+                                    uint64_t val, unsigned size)
 {
     I8259CommonState *s = opaque;
     s->elcr = val & s->elcr_mask;
 }
 
-static uint64_t elcr_ioport_read(void *opaque, hwaddr addr,
-                                 unsigned size)
+static uint64_t i8259_elcr_ioport_read(void *opaque, hwaddr addr,
+                                       unsigned size)
 {
     I8259CommonState *s = opaque;
     return s->elcr;
 }
 
-static const MemoryRegionOps pic_base_ioport_ops = {
-    .read = pic_ioport_read,
-    .write = pic_ioport_write,
+static const MemoryRegionOps i8259_base_ioport_ops = {
+    .read = i8259_base_ioport_read,
+    .write = i8259_base_ioport_write,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
 };
 
-static const MemoryRegionOps pic_elcr_ioport_ops = {
-    .read = elcr_ioport_read,
-    .write = elcr_ioport_write,
+static const MemoryRegionOps i8259_elcr_ioport_ops = {
+    .read = i8259_elcr_ioport_read,
+    .write = i8259_elcr_ioport_write,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
 };
 
-static void pic_realize(DeviceState *dev, Error **errp)
+static void i8259_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *s = I8259_COMMON(dev);
     I8259CommonClass *k = I8259_COMMON_GET_CLASS(dev);
 
-    memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
+    memory_region_init_io(&s->base_io, OBJECT(s), &i8259_base_ioport_ops, s,
                           "pic", 2);
-    memory_region_init_io(&s->elcr_io, OBJECT(s), &pic_elcr_ioport_ops, s,
+    memory_region_init_io(&s->elcr_io, OBJECT(s), &i8259_elcr_ioport_ops, s,
                           "elcr", 1);
 
     qdev_init_gpio_out(dev, s->int_out, ARRAY_SIZE(s->int_out));
-    qdev_init_gpio_in(dev, pic_set_irq, 8);
+    qdev_init_gpio_in(dev, i8259_set_irq, 8);
 
     k->parent_realize(dev, errp);
 }
@@ -425,8 +425,8 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
     I8259CommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_parent_realize(dc, pic_realize, &k->parent_realize);
-    device_class_set_legacy_reset(dc, pic_reset);
+    device_class_set_parent_realize(dc, i8259_realize, &k->parent_realize);
+    device_class_set_legacy_reset(dc, i8259_reset);
 }
 
 static const TypeInfo i8259_info = {
@@ -435,9 +435,9 @@ static const TypeInfo i8259_info = {
     .class_init = i8259_class_init,
 };
 
-static void pic_register_types(void)
+static void i8259_register_types(void)
 {
     type_register_static(&i8259_info);
 }
 
-type_init(pic_register_types)
+type_init(i8259_register_types)
-- 
2.43.0


