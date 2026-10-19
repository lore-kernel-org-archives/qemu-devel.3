Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF76CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8g-0001OG-Hq; Mon, 19 Oct 2026 08:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8X-0001GE-FL
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8V-0004AD-AD
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:41 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QPJk3199051; Mon, 19 Oct 2026 05:06:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ojnPbeqBzxvW8ef/Ffu9RV9uInJCYb6lWSzAf8/lS
 tQ=; b=XWbdxJnVRkIOGAFQCUohzwz+x0+WRz2utVV9zBDkT/Kwz0PBCDxvUss1X
 VNSBKveilwCjupNRgMZFWLi2L5BVp93+kAPEnzbqpDxXFMKLArULTaZKBJOS08Lf
 cjK7Uq5+gtgn4qLQ+6N7EXiSiCa9JpXvUNdkcyzK2rnmYQiW1Vd/J7LsF3xYt0wh
 Gp74bYhnLjc52eiuRhhzz5ItAYRWMJGikz27RS8UYTkclML1oNJXsPEVkpMdfXRA
 bHfEQ7JVGanYBVQzCpMij6vKhrZpo1ViWg4eYlsT+MW0e0YfVy1HiCeAK/F74hvC
 d9hWJLHpPOYccwvLvUbxJlmWSPnyg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021079.outbound.protection.outlook.com [52.101.52.79])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc83euh1a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0DpSua5ECADkZhvp4RpVLkmgzxrbYCk3Xnt/tv4qhBV7hIPUVUgRGyDGRSauBRGKX4eRvSrcI+7nh0KmHdeVFp3vbREiaYwACc2zUVOBVolJNlwMs/M3kpNrqwZKqL9LMRcfWoCZf3zpT7ehRx7mJmQOizPC7go3gNVynyOrQ+4cGzWQ6m4vQuUnwwSes4QiNChobpjMnf8thYhQR4Pqvh7SsALFlCJXiQHkfNXY2yFM+f1sqzctlX2hP+XhSrq11rVG55eN4rMlXUkCA9QcXHx5RNYL516askFU85xXDkX29Y2kMJitfhP5CVS0Z3Sa0C6JfSMShCtXGhLOOwBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojnPbeqBzxvW8ef/Ffu9RV9uInJCYb6lWSzAf8/lStQ=;
 b=YXSvj32dnqP+WNboOTyoQbIK4yG+qSOubrh5asw5rttPk4hysMgNIXmh6WOddh9DvhkYHZhQSFF5809yrFG8g+kl9NP0KEySUPOUlOny5Wxfh2QRkWp37IPhiIkz9kISqH8nz/MwuKhCbRuptFKgxOdSg1uLxWz3CxIOHKTTnMEIhJ5ZQAb3HhY+ELRZ13nDc+5j3tlo242YEA7JLcpen2/BAcGotfKG9aCNSo/Gtw5l9yu5ZOOWaJTZELEOVSDRQkxfeQ/ao1abolCOq8GtuaFDROdkUT2JJS8IJFMrSU61UDp6u0ytz4peXi1ztU1QaSS+9FjHXamU0lIcsGNmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojnPbeqBzxvW8ef/Ffu9RV9uInJCYb6lWSzAf8/lStQ=;
 b=N8NR5thR3X1JR78q1kcK/ZRThP5DX/mGMjrOWsTgHfKncrrMqYw9e2FJf8QyXMbwhDJSz7db6KL6emMLCk1yILJLGTNJUa2E4OencXobWFXLpEs35IAbK2Ii8MFlkoXBNDU9nbcS/eiiUInKq9Zr6ap/sxkluUUB+qTQ1s0BVYASdH/Twp33CD2DC02HvAaJ8DkkPkAvvxjGSAru+BQA7rEfIWzzHWJ8TIYhSqbcBn7WJ5hAE63Z93JM9a2AT7/2SNNPDlv8+VHhgXcQcSeAfBDBhEeUnAyHBcy4QOpuXugnSqSD5XMlfFAywLyCziqwaheNJ/wVRLm8A2EFkaHt9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:29 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 21/28] kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
Date: Mon, 19 Oct 2026 13:04:53 +0100
Message-ID: <20261019120517.1448687-22-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: ff895f13-58d4-476a-d1ee-08df2dd9683d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WWDhQ7ShZaaFydn6u+fxG0L8DKicMcc6ae07vYJu9nXbyoOWSY+Y9T1TKhyjCHL51YIPXe3JmIwFuQgrtanaMx272n/52z8zphGip6jS0hGVl8Cq+n4YP5OUuU+kYzQCPstnn/jg1loo1unMJjC/Ux+KgPS3ZfNd4lhLlzPT2L7OyvMSreVUxFd/qBY6HcFqujRNHpwELleWpUMrTSXTWeeQ2qN89D6Ww3HILL1aRCk96004oly7ZjmGy6/ZZxGvXodGQ4sUp+gFB5/SVzaWG3fflQeDVTsMxMRxPNFHlZl3hCeBhq9KIrh3YYXtmmwGKVfX5000ntWDyDXFyHJ+uJ3SVlxCoZkauM9NxtRqGsd9+BqqpK5XP4frgsdf2LEjnEkxnQ2o0pD/vvzwsTP1SstF7+Y0HItmiTHlujsdiPEfaNTV14RyT4CNjVBiJLjeuNKYaK8LCtDZ7aYFm2s/Mrphq1LK6hb87P8sbhrtFTgXq9ZVXVgBIClGrOiQcw5F6ux/45nhyqcFhIf7CTfQ5h0SzON1uH5yUKb64jrRRR8aYP/Z8tDwKb/+3cAqtgBs+LLcDPqOQsgt8fnIzhfozQw6UsJb+Cd9++ApAHB2+M6j/nc0oXxLFVyc2Qk3lCuOoUyC2dgiorGTH7bOFMn7GjynsQqCsvAhkcqW8ZGnSYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RwE4X86iDgMsmzpXt2KJuqbtbllaa68Zo2ynDu5q5yle6hDtqLtMEqRhuS+t?=
 =?us-ascii?Q?e/XigAYriqN/6Rf8N7iIELgYASKqbAtGCFQyQjkaqCEAS+1qJRME1Q8SN1F2?=
 =?us-ascii?Q?v4hZ4KLB3edNW4Ff9C9hsg79BB1BaVZT8IHZ1w1Xmo7zs+MZNdpLhDIhnlUA?=
 =?us-ascii?Q?3uFhJozfL5yToGDg/VCAW2bRepOr3xUHbR0C1oBzc7v3qi8GlVepD6dcEyJJ?=
 =?us-ascii?Q?Ohrxwk53Ui5+8djTLxEkBjnSqsicglFV0SdKj2KAMCFF2MlQK/Vb/WPusW4B?=
 =?us-ascii?Q?LJ5yETLNV1IAVLKd+xM0JOqM6Je0oPnCWYVYyugjjcQWCHFX8on4uUwuykfQ?=
 =?us-ascii?Q?XPcA6B3fAKgBo5m8IJEmJ3WTGHwuSwqQuv132e/a8x76U9uzvK8L1WR/vyo3?=
 =?us-ascii?Q?QvNgvoL5PBUGVrQiJsn/FxsAK28AveLX0UVkHlueNIOPasP3WnI0wu8A+AJK?=
 =?us-ascii?Q?FB3gMXSUUf/LSbe0Tq0buj5Si/uDP3UwsklwttfzhjwXQBfQDZ6Q+qI4ggK/?=
 =?us-ascii?Q?KHxLliDVs1ZZaZglokpCTT0umD1ZoMiRaszki9kFsPmrOrY4zGGdcmqlifzZ?=
 =?us-ascii?Q?D8x6RDZSkrxxEdSP3gJzXjP/dqrBIWyjsMSAjPJNsX+GCF/ZEHS6vgt5EYTn?=
 =?us-ascii?Q?5UExutUPjf4PZB/Nw9QhJtYqw2wKMNwvyBxrs+KKTb9AhD6wm2ixAIHT4JfX?=
 =?us-ascii?Q?OalKYATdJh7qzoWV0sq8yeX8YaftJ1dSp8nTyfRIExGxB9Nyrh6EeicqJrE+?=
 =?us-ascii?Q?3cPVBGnLJ2FqQdx7R2jR9BoL/UMq1y0xSpW+VTeG+FFnHkcgTMGweOHWY8ta?=
 =?us-ascii?Q?Sx/gDBorNXI+lT6v8Vo77YudxSfxv6V1UgDLsl5BXBUh8wF10HWxVlHFn79W?=
 =?us-ascii?Q?uc4BsaWP2Drz/wz4l143IQtw/YkpdQoG8hjJ7CltDCbaz61sHUIyrxBVw9Xc?=
 =?us-ascii?Q?0StaQstiwX90/YnRRVQQryEI6tHgEVmr8bRXev38YwZ0S+KrChhSTGwIlm8D?=
 =?us-ascii?Q?F8qJYVo+5wl7WeN6l5A7n7Ery+KAL4wqWPsZhrCzCmO0ud2bgG02gttPUyom?=
 =?us-ascii?Q?ibuhHPz1YVO0QNAtw98ZkGz8wulyYWzhg2NkLo4GX+kgBytFpvkRwZqdiS3E?=
 =?us-ascii?Q?3UqxTaY+uIEKeDbodpMwZR2J6rTsBYmDOFxPNFnQ/fYUNULQh36Qoc2JL2jt?=
 =?us-ascii?Q?HXRzHNlVRx8jk3A2ma5eDf9lmrJCbfuXYnywa05OmXDfU/NKFeX2nBEWbOhp?=
 =?us-ascii?Q?b1f1jNHFOyZVg219IXqefWpSUHHv7xuYG8zV1JSZ+Buh3dkkrGH4q0L4bLSd?=
 =?us-ascii?Q?LSrk/HhmNaufmk3CRpZSNLx/V9FYiROZQlOpxcSD3sl+llbv4GV4YvRnNbaU?=
 =?us-ascii?Q?6l79lr5Kd8U2u2ELhOAXso/zaOeBvV6U5sElxe7ZLNtUqwGx3+q34A0+uguR?=
 =?us-ascii?Q?6VqzmwbHc4HNt2VGZKEEJ3PG/wwtO3/KUK/7ucZjY+ix7y+lLfBscdGVaV84?=
 =?us-ascii?Q?a9xeDDDQtEUN+p+YSQkLfebcOAQm2Ktf1Jta+mQmNEFOaCFAHs27YdAJxb01?=
 =?us-ascii?Q?S5HYp9mS6vr4ERhZ0k0br0VSAmaA8trO9Q4RiWkRpTKxVjFRvxjN1xfAUEmW?=
 =?us-ascii?Q?EHICNxDWNZEUGM8EOAgdY4rpDLBIe3KGQK21c06RR/janvPBe0Hvntx8RacH?=
 =?us-ascii?Q?mKFWpjgftIWL5MFY+1v5SkmGtLR3OWNRHq5DZdnKnSCdnqU4rVc2JbxyrTLM?=
 =?us-ascii?Q?AGJG7G7o9QHx/q/ZjkayRjoubZjgPsk=3D?=
X-Exchange-RoutingPolicyChecked: 3cWlCkv5//vFoQjJnT31JCaW94trqfUYE94VtTroJnXhUL6Tv/gJOFdkjMgSz6IemKpWPcLzOdXFaViXtIFPex0nWOaWPuKwNDJbaCPU6iV2tGMzteFyCz2Du0pEYWytW7+v5zjEJ5/ymhMywqNascfutDVMRorcFXq9K9UsK3oLdshESz/3HQzYpBuyv0fjGksrmfH6cEHVOVHfzpHfwrdcNhcFrVHPg7INZHLuBpuSy29VcNVixMQXuuG/+7FdUrfXXYwybaUMEIxy0Ug+Op1HqvDfl/8yRlVXOk51srQNMncVZU+9VDt8YXPguVmJ/Z4Blg6sXUWpRp5FUlUJ3Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff895f13-58d4-476a-d1ee-08df2dd9683d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:29.2293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YcF1HpIR5brjz6WMvFRJRiMeii+eaX4i8QpqDkL45QRYgW+0EkyQgOGQzHVM7dpsB2fJyA1MERV8dDC6GZIOTkWmDebZ1l5TnMwerGvq3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX9UTjCZ9vKc6g
 Dru6FQVztUmvwsl1ToZOPAieCbeW9YQN3PMNd5H22Y3EfaZ/7qS90onowXs88YCJ1wMjbTefujD
 jVlg/6eIM1AcNYlCHRqG+nuLddGullizrDYBcBzuQaWWqIEPXgF8xstXOIRZKksYg2LATgvwnUs
 nY0xidq3uqvFFM72iBNzjjq8N8+L1mtthQbffbO8f1b1/RUtQix9NhQYd10FrRAoEjmrhKbw2Gi
 b1I6ayOA98PitZ/M1i0eVEpPF6EKzJvv9lIi6YcKQkO9inXAA1RpPgjPD4X1NQKisvRad33KR7t
 AE9czdWDE5PJqderMFdFOZc6eRp9YtAdvMzoFNSjgSLkHIleyBoy9FAH1gs9tprg4eB+6Sa1Ze2
 dMhXOvAH4ENOEtuizhcpNxWNYtrtBIP+1RRHj2Tuz9RVLxSwWVvGzE6oD7KM6x2NjrBmpiXPB47
 9Fe51qbP+UHckR2s7sg==
X-Proofpoint-ORIG-GUID: 3BYfKqASBupiI0H_2GLgE--YuR5qKaTf
X-Authority-Analysis: v=2.4 cv=RI8mjIi+ c=1 sm=1 tr=0 ts=6ad607c7 cx=c_pps
 a=Lzux+ftsp8NJ2nFuhgYiNA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=CV9Lyex1vB-al1NDbmIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXxwB8YHKWs2mn
 31V/BFKsE/b6ViPyHIceq4W1Js49PCwSMH8pUYqaUmN2gd01rCZk9p/FXc6Wmyky59kCBZ7VSVy
 ocT/5vVwwOwM2GbIw30UtwV7nK/uZ/Y=
X-Proofpoint-GUID: 3BYfKqASBupiI0H_2GLgE--YuR5qKaTf
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

This device represents the KVM in-kernel PIC for an x86 machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 91 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 9ee23b5695..48282db58e 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -16,7 +16,9 @@
 #include "qemu/module.h"
 #include "hw/intc/kvm_irqcount.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
+#include "qapi/error.h"
 #include "qom/object.h"
 
 #define TYPE_KVM_I8259 "kvm-i8259"
@@ -36,6 +38,18 @@ struct KVMI8259Class {
     DeviceRealize parent_realize;
 };
 
+#define TYPE_KVM_I8259_PIC "kvm-i8259-pic"
+
+struct KVMI8259PICState {
+    DeviceState parent_obj;
+
+    ISABus *isabus;
+    KVMI8259State i8259[2];
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(KVMI8259PICState, KVM_I8259_PIC)
+
+
 static void kvm_i8259_get(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
@@ -135,10 +149,21 @@ static void kvm_i8259_realize(DeviceState *dev, Error **errp)
 
 qemu_irq *kvm_i8259_init(ISABus *bus)
 {
-    i8259_init_chip(TYPE_KVM_I8259, bus, true);
-    i8259_init_chip(TYPE_KVM_I8259, bus, false);
+    qemu_irq *irq_set;
+    DeviceState *dev;
+    int i;
+
+    irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
+
+    dev = qdev_new(TYPE_KVM_I8259_PIC);
+    object_property_set_link(OBJECT(dev), "bus", OBJECT(bus), &error_fatal);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
-    return qemu_allocate_irqs(kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
+    for (i = 0 ; i < ISA_NUM_IRQS; i++) {
+        irq_set[i] = qdev_get_gpio_in(dev, i);
+    }
+
+    return irq_set;
 }
 
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
@@ -154,6 +179,59 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     k->post_load  = kvm_i8259_put;
 }
 
+
+static void kvm_i8259_pic_init(Object *obj)
+{
+    KVMI8259PICState *s = KVM_I8259_PIC(obj);
+
+    object_initialize_child(obj, "primary", &s->i8259[0], TYPE_KVM_I8259);
+    object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_KVM_I8259);
+
+    qdev_init_gpio_in(DEVICE(obj), kvm_pic_set_irq, ISA_NUM_IRQS);
+}
+
+static void kvm_i8259_pic_realize(DeviceState *dev, Error **errp)
+{
+    KVMI8259PICState *s = KVM_I8259_PIC(dev);
+    DeviceState *pri_dev, *sec_dev;
+
+    /* Primary */
+    pri_dev = DEVICE(&s->i8259[0]);
+    qdev_prop_set_uint32(pri_dev, "iobase", 0x20);
+    qdev_prop_set_uint32(pri_dev, "elcr_addr", 0x4d0);
+    qdev_prop_set_uint8(pri_dev, "elcr_mask", 0xf8);
+    qdev_prop_set_bit(pri_dev, "master", 1);
+    if (!isa_realize(ISA_DEVICE(pri_dev), s->isabus, errp)) {
+        return;
+    }
+
+    /* Secondary */
+    sec_dev = DEVICE(&s->i8259[1]);
+    qdev_prop_set_uint32(sec_dev, "iobase", 0xa0);
+    qdev_prop_set_uint32(sec_dev, "elcr_addr", 0x4d1);
+    qdev_prop_set_uint8(sec_dev, "elcr_mask", 0xde);
+    if (!isa_realize(ISA_DEVICE(sec_dev), s->isabus, errp)) {
+        return;
+    }
+}
+
+static const Property kvm_i8259_pic_properties[] = {
+    DEFINE_PROP_LINK("bus", KVMI8259PICState, isabus, TYPE_ISA_BUS,
+                     ISABus *),
+};
+
+static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = kvm_i8259_pic_realize;
+    device_class_set_props(dc, kvm_i8259_pic_properties);
+    /*
+     * Reason: must be wired to the ISA bus via the "bus" property
+     */
+    dc->user_creatable = false;
+}
+
 static const TypeInfo kvm_i8259_type_infos[] = {
     {
         .name = TYPE_KVM_I8259,
@@ -162,6 +240,13 @@ static const TypeInfo kvm_i8259_type_infos[] = {
         .class_init = kvm_i8259_class_init,
         .class_size = sizeof(KVMI8259Class),
     },
+    {
+        .name = TYPE_KVM_I8259_PIC,
+        .parent = TYPE_DEVICE,
+        .class_init = kvm_i8259_pic_class_init,
+        .instance_init = kvm_i8259_pic_init,
+        .instance_size = sizeof(KVMI8259PICState),
+    },
 };
 
 DEFINE_TYPES(kvm_i8259_type_infos)
-- 
2.43.0


