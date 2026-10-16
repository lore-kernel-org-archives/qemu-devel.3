Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9B6CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHinz-0001yn-HP; Fri, 16 Oct 2026 10:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHins-0001y0-9w
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHinp-0006aN-P4
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:20:59 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE4wvO1681736; Fri, 16 Oct 2026 07:20:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NIlAnp4VAldnLceUySYWQNWAeTWWwprg269Vv5DQ4
 Tg=; b=HO73wnsiTrg/yLKyFFRPwjkZ6FBrHf/du9JjfUW2Hv33SUUTYZctDbUBh
 oJmxTz0+fzgI563760BffRYVFFyfLl5wMfHQ2DR1w4ilmL1RVBb1J1R36j+HDWEn
 Ag0x6rsK699X1Yx4kGoQDlXsKRVHWAk7Dt1y3o1IJF7OfGyIFYw0aq6qp7UG5ejn
 qAD2HIiOUCXKFJtpbvMYgFUqw7WiOfonxiBGUeUwNF2/Za4rCeWHSZVqy8nt2ErT
 W9pLB7a99ppSknGs76fW2r5FSRrr3rCk9+E1G0KDOTEv4xoLTuu6J/iFitjji5X4
 e9PJrbs/WuKS4idjUoGcsvBEbuIoQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020076.outbound.protection.outlook.com [52.101.85.76])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hberu10eh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHc0q06T9rRmXvxShGiOPb/snPVXuCTujSJJDhimehRtn0xZNpvk/GSEjgS1pX1eYWHZnloR338groTC1wvfXzyzT/r7iFV7cdQingm9BECLeuK7tF+Ayt0/JD1MDhFy4mvZwESBQK6AWLu7kO4L84JBD3jDxoTBmHMlKvoWaqNjK67UnIpvZSfd8SwOGbYj2bak18yu/0X/gXCtVA+VGHhENIfRjvo8RBmtJiVoo5zNstUgN+WJyfBw5qNlp7sXKqwyCAxIcGZw2tElmFzpRKHNua/m3WWeAs0eEWyYkFHim1l4xUrFoDgJiGtW6nT1THNLbXqGyGI8intv/buvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIlAnp4VAldnLceUySYWQNWAeTWWwprg269Vv5DQ4Tg=;
 b=I8wTTqCMlDbA3NqpiNv69Vqn7OfC46SpQZTPh57hfLAHmd+gVs+64PkFphAUQLOHWv5qUFw8OAS5AeCJJOlSLkrTdqT3NNzVpNHiWsmiZ7/NnLBATZBiJ6SWXXRbQxHGPTfK7zPeN56SCp1CNeT+sYQzPgJN9/rvo3GxDwgUaWTJxQ6aiEVkIjISvRJZol15NBcs8Nsnm0NonS3H3pxOuMq1JajsRHSv8m7Vp5T2pRhgOeB946dGysk4MfDFJXBBPh0hd6eYTWG3Iv7mxoYyhegXuPhfBeR+5AUKCuImO9rtiXfYNVTm2o1J4QKCcdyLJA1Inf3r50DdxPXG2MQaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIlAnp4VAldnLceUySYWQNWAeTWWwprg269Vv5DQ4Tg=;
 b=GbIJEdRdZ7NX6yZWw2CTel3LputhFhILPxDvu+LDICpzEhChsjq/7VTdJbP0WRwxNBitxz1WRr8AdY1UU4xMEs5oeh+SCnFpvKxu3K22RhbZHrr7H2qWcEo0SATXwiSPBdEAdvvfCgE9I0ebvqPAjvsyFv7fGS1apdjuP6O27aUmAZALKWNqGSi12rjU/+oRpd3A1HLQNWWhNLLzNEAoK06zeumFI/aQuP8TDntiAXLj0Ez+sOkP9GP8yk191wGJh/nzj+9Y7YEw9bRtWx+wQ9c/JckWdM/j6WZrNdXQLoubcMvPg7r9M9ZdIMe0LW4+5o1gNk2QXYZmkBJy8239Eg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6547.namprd02.prod.outlook.com (2603:10b6:208:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:20:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:20:50 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 03/27] i8259_internal.h: rename PICCommonState to
 I8259CommonState
Date: Fri, 16 Oct 2026 15:19:09 +0100
Message-ID: <20261016142031.1204281-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:a03:333::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bfa6cb-4d4d-470c-2a14-08df2b90ad76
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|10067099003|3023799007|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Z+P3wcbxYQflMMVdqOSqvz61eLkdwyDhI7NLiLkxIOTs9NNreblc8MZxUd3kKkrnyOeyRMz3D+pDM/Ju1Q5pHLLxmnEVIfqARcSHsAaxKDW4Uvi7lozNsh9/JwsenKgW20WZyL1l7tVaGap72yp6QOlgjYMOw+6bJHgE3HR6T/gApXJoxrE1T6UnKn7t1PWu7s2eJu7jN5vbApHsxl7o0Ml1gnh+5TaIi+HYNPx674Ab3ooB4y66iqq6gsx0oNAUQsVgwKhBkvxFbvKMgBKq6hYVVbmOUfLHGcJgQCxc+cKIklthpzhWEYhFKmaTTk69/iG7MOGlnuuMg6M6q2hWV8ZbuE+in6bM1RLMiO05qUmwzUtwAuErRqSwz6M0cpJQew3dLrc23edGyrrttvjM3t2M1XR3PcCfhWXoVXgWEO4iSmVDKLW8GJW2ICjSJ86CTQSkviR3QU+H9K59EL+VcA2BW2UOpsvitXg3Sv42Zo1Dvb3dS9rSd2fnhOIUPr3VV/spAafzxuOranvo+m1CWzzUd83WFF/6yuMYkpuSXMVbpVkZ4tpz81BC+TbPgQfkThJ720WKo3fdtGQXCYmkdAIazRTrDnbL+D2Fr41wRiQwZq3B/sFofvQtFuaeLNITmOrwmh5nEsX6hM2J+7P/gh0+78X2rXEPcbkQyJI4m2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(10067099003)(3023799007)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Ke1GC+wQLL2D9iJJYQAG+DH6VUD+0SNclBch/C/7cqUkOsFO9140U9lsjkX?=
 =?us-ascii?Q?wVng0gJdGLPQZIsSrTd5v7AmHKW4MaVW7LTnK7qmiFV/t+XAP2B0CqJDxaEx?=
 =?us-ascii?Q?WULvrGrYDQk+dvswecqSy91hF1ol4AjkP9pyekDH0TxWKMLf2JmCM42jHWXq?=
 =?us-ascii?Q?NHBofo9cAN9eUw6erKAq7tfrXuT01WmWIv+4qDIrLt3VMeUkDPFVq4xK/2n/?=
 =?us-ascii?Q?ukgREwaZGYIlgsZaEGBWb3RF+Mn1UQ8CpNIffLL+Nh+RlRbQrjiX1nv4NxRS?=
 =?us-ascii?Q?Zap98MxRcZi0pn+zloYyJ+bD6eutUZ8LNXq9MS67tEfl6AEtw7qSMGhu+n/M?=
 =?us-ascii?Q?QntfSya0iDxLVxeZQ05YrDWPdLl0Dmzms6EeHvHZUxb4L+EYONXnoi0WNq+C?=
 =?us-ascii?Q?cd/w6+hNKEw4R7WYtWRBF6MwsIxNrMDTbDQZqeeGbDwvQWNsfKEdw8FmCTJx?=
 =?us-ascii?Q?hNcw7Q45IJiP9zcLMrFnohk/DgJQyx6Tgn0M04NIWmwWtBktJ2MoH0ofyH31?=
 =?us-ascii?Q?ds8EMtX7jtOBDiyxKX72bhFu6ZXecEzdB+YlyBdNIzZLUdIpR9s5N9guIq0l?=
 =?us-ascii?Q?we89XKHE4Q3WHeObEba0p7MJ+QYdaPhwOSElkPnw2iFmKHDCNlVEpG6cYWAH?=
 =?us-ascii?Q?HLccyGpawjedIf3Rq/CHOPxgFxoRPFTGna+LJFFTTZIbTLenAxD8Vy9gTi+X?=
 =?us-ascii?Q?Qui214vYpYwcEHHOQyzMQK6T9cVx8nmfWT0sN27FAOAy4dJT1mHRXDPNFEPW?=
 =?us-ascii?Q?/iLR6S4X4Mh3xfB5yrmn++bdkI2V4P6Gj7df+l0dHaPReAdKIQwIZmUZLbm4?=
 =?us-ascii?Q?0qAmLnoL2xIwN3KtbbaceVeeX6OwMZ9RJCSLCpOaJvv4dY/dCBxSIvSz6FED?=
 =?us-ascii?Q?h5XJf7FdVIQIxxKW62CH9h3u1Edbm1S+iFRqz4KaIwwyez/H5HyKBz3nayb8?=
 =?us-ascii?Q?jJyK4mVPjv3xjpgUDZ816eMX7AaJIpyi7oaKGpEJaXbtGh11rioDBJMElHGb?=
 =?us-ascii?Q?g0C6Cy06hkAdjaOjEaMfRyGOsdLSnhOyiTprqOdcW1qZu1C6eX9Nf8XMGpfR?=
 =?us-ascii?Q?DL9MmMLlwqYThmsHftopbbpNDWmv8gunZ2zpTpqO8ZQDMs9ZY3DW8Rruu1CT?=
 =?us-ascii?Q?0pVXmTSmcTkIq2UpzN38NLbpwPo3e23fSW6yLJV6I+xYy2iPUw8rWxS3vTAq?=
 =?us-ascii?Q?5hspYRb9Cw23we3ZpjOczBuI8Tfu8hYlT+RWs7HCJ+gAkltvU2+0asgGhxSH?=
 =?us-ascii?Q?DT1ZPq5sZK8r9IyxrC2Nd+NiON6czMsMWgWC1W5nGbcUsdytNErHhf2hI0zg?=
 =?us-ascii?Q?mY1/iU3DpAxpAM6kaQIw2bUzk2IzdXB8E23F062zpoZpXTE1l7pWLToYtJnH?=
 =?us-ascii?Q?yfJw005XP679VmC1eiGmHhIsDuOsrXZINfY3fusELqKNSmcMtNw00ei1yANO?=
 =?us-ascii?Q?A1XiAXFWErv4zQt1oo7pWHATe3cC+bmML9YDmw8D9i4HCpeKIyh7I+57OORf?=
 =?us-ascii?Q?bixpXF+4vjJcv4WqvdHAjTbOr0fUnuqrSgJ/z7R7z48WKKTu9nEp1+R13QhE?=
 =?us-ascii?Q?Nn+e4RD7MpEfCMR9tF2dJt5fJnkDobcmkH9UWthTII1p1zm+xbdC2YgFZQ/j?=
 =?us-ascii?Q?ZkZO+ddarMiQLgViei+iSpF9o+X6JXek6qWm8u350lyL6JbpQrRs814s18br?=
 =?us-ascii?Q?eoAH/A8/XpySu7RMzpqO8fSKe5+lgjl1aua+4PROXtdve+U/YFoMeQIwXpeT?=
 =?us-ascii?Q?1FDtp/aCwLLNlJg8DGXFaZ2t0zNlqK0=3D?=
X-Exchange-RoutingPolicyChecked: XKVztMYcPftvuNC9QR6uw4bIWDSiBBpdb+1ElYSE/zyxDlVBJ4p3p+8xJHgnELsRnjqCCNJquY6uX/SwjMlGwK2e855WIuBO8EYW9xcP76mlo+UkH8OQGFqTgWjhqpFyd9gBibPffnbuRiUY+oY5HxYeuETx1jJrhVmWevyx4lZTEfQNl3XMSbZFHm8iYCOyfuJ065CMrczvXg5lkfl66rUerPuT78srO9Vp2CBdYfN9ThVKithxc3697iMsbyOVycIR9FPUouulsJlIS4w50JfIcV47TQiZxBQ0g3zd+3aXKVbx0baGhbDM4eO85xvN+q0auvInJ1hWIQzW1l2W6w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bfa6cb-4d4d-470c-2a14-08df2b90ad76
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:20:49.9984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXeTpwI14S6o9nztJogqIc+gNK+f0Fxt/r0EZOry+PCtfUagom8vCRX00RRj6KzcWunN/79B/VeHPyciZYZSpft/fNiCgU0YidrL5vFHlko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6547
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfXyyGl4V7kUtc4
 ERQSO2msQynlhrxlQUJtnVbAE11BtdcI3A1x4WZKDWZVOWZndtbNjmAOP5aRTjJy4Cbyo76HIa6
 clYVcEtYc9aKWp5GHX5WszaLowa+Vv2DxUqk4h2BLL1yKnQUA9hR9hJoRa1FinN+bEyiJnkxJaZ
 mPUhssRyDlgi9aKZQZEqT865e6JlFcyv4P/otLj/8ouaWTJIV+UfftjHQchYM6N1Zq0dsUPKjdX
 qQnzKZJpBww97sA8IPTdJ9KLV968DNpGMSGuKBiMygb9LipVdb2Ny8cfmuUxxi2ZUEODtVGIezA
 YSMbQaTpxEnzuTzMohQcMD4HWwirzigmHYl3NvCwa/Tm7rqpqd+5eXpfF6EYMR1ytAeSkF3fY2j
 2HdBBlY0hwYtmKl8PrPxivyil/wgwv99AqdqOEdNO687rXg+v2WQCK3v5TT4uevtvtqVu+dAzm0
 lZkaHo574Fz5JzJFGBg==
X-Proofpoint-GUID: lW-jekKSqD5MBh2xS0uEqkzVgoQyPVlA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX/iFMH0fkz+Mm
 8Z36LMaWKpT7kpsTU4FKUU6bUt8p2wJsWCnpMu0ac992mca2+7eF3AUXNKCyFeWZkSJaEB1Js70
 9sz+87rMMN5JPXi48FlfXfH/Ap5Ty+E=
X-Proofpoint-ORIG-GUID: lW-jekKSqD5MBh2xS0uEqkzVgoQyPVlA
X-Authority-Analysis: v=2.4 cv=KMLPn1Fo c=1 sm=1 tr=0 ts=6ad232c3 cx=c_pps
 a=PU2v30DqrLDYHXTVxoobRg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=01ND9n3NiX1-kDoXiQMA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/i8259.h         |  8 ++---
 include/hw/isa/i8259_internal.h | 10 +++---
 hw/i386/kvm/i8259.c             | 10 +++---
 hw/intc/i8259.c                 | 34 +++++++++----------
 hw/intc/i8259_common.c          | 58 ++++++++++++++++-----------------
 5 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 1f2420231f..1921a30371 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -3,9 +3,9 @@
 
 /* i8259.c */
 
-typedef struct PICCommonState PICCommonState;
+typedef struct I8259CommonState I8259CommonState;
 
-extern PICCommonState *isa_pic;
+extern I8259CommonState *isa_pic;
 
 /*
  * i8259_init()
@@ -16,7 +16,7 @@ extern PICCommonState *isa_pic;
  */
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_get_output(PICCommonState *s);
-int pic_read_irq(PICCommonState *s);
+int pic_get_output(I8259CommonState *s);
+int pic_read_irq(I8259CommonState *s);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 289d08b7d7..7a2f9addaf 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -32,16 +32,16 @@
 
 
 #define TYPE_I8259_COMMON "i8259-common"
-OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
+OBJECT_DECLARE_TYPE(I8259CommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
     DeviceClass parent_class;
 
-    void (*pre_save)(PICCommonState *s);
-    void (*post_load)(PICCommonState *s);
+    void (*pre_save)(I8259CommonState *s);
+    void (*post_load)(I8259CommonState *s);
 };
 
-struct PICCommonState {
+struct I8259CommonState {
     ISADevice parent_obj;
 
     uint8_t last_irr; /* edge detection */
@@ -70,7 +70,7 @@ struct PICCommonState {
     MemoryRegion elcr_io;
 };
 
-void pic_reset_common(PICCommonState *s);
+void pic_reset_common(I8259CommonState *s);
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
 void pic_stat_update_irq(int irq, int level);
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 14029783e5..f10643a120 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -34,7 +34,7 @@ struct KVMPICClass {
     DeviceRealize parent_realize;
 };
 
-static void kvm_pic_get(PICCommonState *s)
+static void kvm_pic_get(I8259CommonState *s)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -67,7 +67,7 @@ static void kvm_pic_get(PICCommonState *s)
     s->elcr_mask = kpic->elcr_mask;
 }
 
-static void kvm_pic_put(PICCommonState *s)
+static void kvm_pic_put(I8259CommonState *s)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
@@ -103,7 +103,7 @@ static void kvm_pic_put(PICCommonState *s)
 
 static void kvm_pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     pic_reset_common(s);
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
@@ -154,7 +154,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
     .parent = TYPE_I8259_COMMON,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMPICClass),
 };
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 52e24d333e..45db87a2ad 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -52,12 +52,12 @@ struct PICClass {
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
-PICCommonState *isa_pic;
-static PICCommonState *slave_pic;
+I8259CommonState *isa_pic;
+static I8259CommonState *slave_pic;
 
 /* return the highest priority found in mask (highest = smallest
    number). Return 8 if no irq */
-static int get_priority(PICCommonState *s, int mask)
+static int get_priority(I8259CommonState *s, int mask)
 {
     int priority;
 
@@ -72,7 +72,7 @@ static int get_priority(PICCommonState *s, int mask)
 }
 
 /* return the pic wanted interrupt. return -1 if none */
-static int pic_get_irq(PICCommonState *s)
+static int pic_get_irq(I8259CommonState *s)
 {
     int mask, cur_priority, priority;
 
@@ -101,7 +101,7 @@ static int pic_get_irq(PICCommonState *s)
 }
 
 /* Update INT output. Must be called every time the output may have changed. */
-static void pic_update_irq(PICCommonState *s)
+static void pic_update_irq(I8259CommonState *s)
 {
     int irq;
 
@@ -117,7 +117,7 @@ static void pic_update_irq(PICCommonState *s)
 /* set irq level. If an edge is detected, then the IRR is set to 1 */
 static void pic_set_irq(void *opaque, int irq, int level)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     int mask = 1 << irq;
     int irq_index = s->master ? irq : irq + 8;
 
@@ -154,7 +154,7 @@ static void pic_set_irq(void *opaque, int irq, int level)
 }
 
 /* acknowledge interrupt 'irq' */
-static void pic_intack(PICCommonState *s, int irq)
+static void pic_intack(I8259CommonState *s, int irq)
 {
     if (s->auto_eoi) {
         if (s->rotate_on_auto_eoi) {
@@ -170,7 +170,7 @@ static void pic_intack(PICCommonState *s, int irq)
     pic_update_irq(s);
 }
 
-int pic_read_irq(PICCommonState *s)
+int pic_read_irq(I8259CommonState *s)
 {
     int irq, intno;
 
@@ -210,7 +210,7 @@ int pic_read_irq(PICCommonState *s)
     return intno;
 }
 
-static void pic_init_reset(PICCommonState *s)
+static void pic_init_reset(I8259CommonState *s)
 {
     pic_reset_common(s);
     pic_update_irq(s);
@@ -218,7 +218,7 @@ static void pic_init_reset(PICCommonState *s)
 
 static void pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     s->ltim = 0;
@@ -228,7 +228,7 @@ static void pic_reset(DeviceState *dev)
 static void pic_ioport_write(void *opaque, hwaddr addr64,
                              uint64_t val64, unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     uint32_t addr = addr64;
     uint32_t val = val64;
     int priority, cmd, irq;
@@ -321,7 +321,7 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
 static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     int ret;
 
     if (s->poll) {
@@ -348,7 +348,7 @@ static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-int pic_get_output(PICCommonState *s)
+int pic_get_output(I8259CommonState *s)
 {
     return (pic_get_irq(s) >= 0);
 }
@@ -356,14 +356,14 @@ int pic_get_output(PICCommonState *s)
 static void elcr_ioport_write(void *opaque, hwaddr addr,
                               uint64_t val, unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     s->elcr = val & s->elcr_mask;
 }
 
 static uint64_t elcr_ioport_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     return s->elcr;
 }
 
@@ -387,7 +387,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     PICClass *pc = PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
@@ -444,7 +444,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(PICClass),
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index e2f997e161..17040bdb1e 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -33,7 +33,7 @@
 static int irq_level[16];
 static uint64_t irq_count[16];
 
-void pic_reset_common(PICCommonState *s)
+void pic_reset_common(I8259CommonState *s)
 {
     s->last_irr = 0;
     s->irr &= s->elcr;
@@ -55,7 +55,7 @@ void pic_reset_common(PICCommonState *s)
 
 static int pic_dispatch_pre_save(void *opaque)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
@@ -67,7 +67,7 @@ static int pic_dispatch_pre_save(void *opaque)
 
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
-    PICCommonState *s = opaque;
+    I8259CommonState *s = opaque;
     PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
@@ -78,7 +78,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = I8259_COMMON(dev);
+    I8259CommonState *s = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
     isa_register_ioport(isa, &s->base_io, s->iobase);
@@ -118,7 +118,7 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    PICCommonState *s = I8259_COMMON(obj);
+    I8259CommonState *s = I8259_COMMON(obj);
 
     if (s->master) {
         *irq_counts = irq_count;
@@ -133,7 +133,7 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    PICCommonState *s = I8259_COMMON(obj);
+    I8259CommonState *s = I8259_COMMON(obj);
 
     pic_dispatch_pre_save(s);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
@@ -146,7 +146,7 @@ static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static bool ltim_state_needed(void *opaque)
 {
-    PICCommonState *s = I8259_COMMON(opaque);
+    I8259CommonState *s = I8259_COMMON(opaque);
 
     return !!s->ltim;
 }
@@ -157,7 +157,7 @@ static const VMStateDescription vmstate_pic_ltim = {
     .minimum_version_id = 1,
     .needed = ltim_state_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(ltim, PICCommonState),
+        VMSTATE_UINT8(ltim, I8259CommonState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -169,22 +169,22 @@ static const VMStateDescription vmstate_pic_common = {
     .pre_save = pic_dispatch_pre_save,
     .post_load = pic_dispatch_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(last_irr, PICCommonState),
-        VMSTATE_UINT8(irr, PICCommonState),
-        VMSTATE_UINT8(imr, PICCommonState),
-        VMSTATE_UINT8(isr, PICCommonState),
-        VMSTATE_UINT8(priority_add, PICCommonState),
-        VMSTATE_UINT8(irq_base, PICCommonState),
-        VMSTATE_UINT8(read_reg_select, PICCommonState),
-        VMSTATE_UINT8(poll, PICCommonState),
-        VMSTATE_UINT8(special_mask, PICCommonState),
-        VMSTATE_UINT8(init_state, PICCommonState),
-        VMSTATE_UINT8(auto_eoi, PICCommonState),
-        VMSTATE_UINT8(rotate_on_auto_eoi, PICCommonState),
-        VMSTATE_UINT8(special_fully_nested_mode, PICCommonState),
-        VMSTATE_UINT8(init4, PICCommonState),
-        VMSTATE_UINT8(single_mode, PICCommonState),
-        VMSTATE_UINT8(elcr, PICCommonState),
+        VMSTATE_UINT8(last_irr, I8259CommonState),
+        VMSTATE_UINT8(irr, I8259CommonState),
+        VMSTATE_UINT8(imr, I8259CommonState),
+        VMSTATE_UINT8(isr, I8259CommonState),
+        VMSTATE_UINT8(priority_add, I8259CommonState),
+        VMSTATE_UINT8(irq_base, I8259CommonState),
+        VMSTATE_UINT8(read_reg_select, I8259CommonState),
+        VMSTATE_UINT8(poll, I8259CommonState),
+        VMSTATE_UINT8(special_mask, I8259CommonState),
+        VMSTATE_UINT8(init_state, I8259CommonState),
+        VMSTATE_UINT8(auto_eoi, I8259CommonState),
+        VMSTATE_UINT8(rotate_on_auto_eoi, I8259CommonState),
+        VMSTATE_UINT8(special_fully_nested_mode, I8259CommonState),
+        VMSTATE_UINT8(init4, I8259CommonState),
+        VMSTATE_UINT8(single_mode, I8259CommonState),
+        VMSTATE_UINT8(elcr, I8259CommonState),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -194,10 +194,10 @@ static const VMStateDescription vmstate_pic_common = {
 };
 
 static const Property pic_properties_common[] = {
-    DEFINE_PROP_UINT32("iobase", PICCommonState, iobase,  -1),
-    DEFINE_PROP_UINT32("elcr_addr", PICCommonState, elcr_addr,  -1),
-    DEFINE_PROP_UINT8("elcr_mask", PICCommonState, elcr_mask,  -1),
-    DEFINE_PROP_BIT("master", PICCommonState, master,  0, false),
+    DEFINE_PROP_UINT32("iobase", I8259CommonState, iobase,  -1),
+    DEFINE_PROP_UINT32("elcr_addr", I8259CommonState, elcr_addr,  -1),
+    DEFINE_PROP_UINT8("elcr_mask", I8259CommonState, elcr_mask,  -1),
+    DEFINE_PROP_BIT("master", I8259CommonState, master,  0, false),
 };
 
 static void pic_common_class_init(ObjectClass *klass, const void *data)
@@ -222,7 +222,7 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo pic_common_type = {
     .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(PICCommonState),
+    .instance_size = sizeof(I8259CommonState),
     .class_size = sizeof(PICCommonClass),
     .class_init = pic_common_class_init,
     .abstract = true,
-- 
2.43.0


