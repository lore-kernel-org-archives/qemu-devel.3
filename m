Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4B0CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiol-0002Xn-HH; Fri, 16 Oct 2026 10:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiof-0002TJ-TZ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiod-0006hQ-T3
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:49 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE60JU3247562; Fri, 16 Oct 2026 07:21:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=dsWOAxmohqRbnu8OIkKy3L5qtCU9Q47z4B6UIej1I
 lQ=; b=AfdKqOJTyzjIGYdIFwPAFG2Xi4UmhJE7JndCg+BzuwLe7aEZGoTbZdlYT
 U6tniKyQOnN6pIswCNok4bjy4X+lBcJm1uPk6qzVcraSjS7tdbA1zi/1hJFqud79
 TyaJ6BjDeZIpoUndMV/UyWRcvGbzJxu8kpHa3vdn3sFgBN3Bs41Fec8TVK8CVvtJ
 z9Ksh/FarBYNVqEpdWV9G665L26ivP9QQAYBvstYdvvBJb7F51TdmXN23hYC9i06
 LaC3uyl53VjCgg/YwwUtZlMTknQGgvdocZ3iLizKxjtw6B7BWI5aD1v6E1IableJ
 ZrbOwpZfHb8+OfxEvOVyFTnu1LN9A==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021116.outbound.protection.outlook.com [52.101.52.116])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4haxj9389v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISij/P50Ow7LetdTqfgnqY2l0S7UngSeXllVBUKQHxTs4QDl36kuJq993DQfjSI2aX5sd21VDynzcM2XI/WvngAVf0GQl3oBVcwi4frmp8jcY+5ez5601qQly61BoPeSNahm+jKVn3PNkoDLc1D8tJ/g8t/bzIuV7x5qHmGx0p8LzaiSWayBFIQ39nTc4V3FFrlXSAb2UZFS0XV3f4SmOYVKtjInYpiei1Wsx1ls4fhUCefB00wkcZehYxinnzzcIw/9F8Eq4tLrOiNErTbgt2brCkmpBRYlMnQX1fzsZeQIjU6z35SpCtx4DymFNb40lkQZyu+vJKrUsSK8u2yLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsWOAxmohqRbnu8OIkKy3L5qtCU9Q47z4B6UIej1IlQ=;
 b=Vx3xeHk/QJfQ7UwCt9DDHhFuq1AarygssVSzmZxQAKjZKkrbIFzZrtowxp7NSHDPiwouO83kh+7wH1Lx4zctzGwUn8p8I0pQK8fVzxT45dHGEkIaalM2/19oL2SNkon0i7lWZKrFBGYRWReivLxNensHGVtLgILjpyyLKSgqnEpd6wYr2vPQcuZeQ3CakWLWKaIbFQT8YZ/Br6Us+AVUpfu31Ia27LBUpnfZSlQ3ceU/ybwPKhDSYcWRIApkuPa2bQev/nmiLzABL7nfxua0BjsHgLo8kAsdChNTj10lR3l8i6IM5hVp+ywApEGxxAAmEircZTpsuCi/YSNRLW5vEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsWOAxmohqRbnu8OIkKy3L5qtCU9Q47z4B6UIej1IlQ=;
 b=oP7bBQsxDXsiLiOQgJD/Ktqxq2cF7pfMFsFuxjh3FkIYXGcDqmcyzuj8qzSTK5wmXIH8cBXSBt2QXxNERVS8/7Rx7gkAihSmhhLyLMtRq30CJH13IzSMdjXKovRh+SrnjcmkYzmCA9vZyXSGf4nIIJrsygV9MJkmIXVeUN6Fr9n/bo/QzeIznwCrlIy3B0zVGZ14txuq4dnSHbooRtUVHrM9XHfPUhYU3VJkkxiD2leFB3UdQ2KnTJPrreZjlnf2YOjM/+uYefwIzNZqw42V7KMgSd109RHLuu8UP+sSSA/Ku6BiLWKPFrJn3BOCmyTVeERU2YffMARs+NV7iObJsw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11424.namprd02.prod.outlook.com (2603:10b6:8:352::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:22 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:22 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 11/27] i8259_common.c: always use cs for I8259CommonState
 variables
Date: Fri, 16 Oct 2026 15:19:17 +0100
Message-ID: <20261016142031.1204281-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b07bedf-54ff-4e0a-fa2d-08df2b90c0d1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: vYZjL7dvl3NX4wgj8lniT8Md1rmbV5fqYKMk+5QdammVoBiipmxVOapI5DbQIPD9GTUxew1h1+GqvWYK74squV3ureRbmLfzARMauLZiMjP89O6vPAZBukRhOyT1CUwmxFAUV8b00K+bf8u1iDXfJSiigKXxuqBSM/s8M6wMovba4qkjtvPLfyFrvikL//YpeNEs+6etv3hY+ZgFr0/yDWV/9yS2NipYdY27K630dINgoLOU7S+5ULsfx12MI+rDgA6YfbljfiPZ7WWxn/8wuerlr2GUblDZMJxGgxyTTgYIrgXS3rHFr8z+AnmP83e1r4mPaZ5SnT7YGCzALCeUZ/Jl0eoDUIuqg3n5Cc0mfbQPeKqFwQ0GoEU0+xhqk2JhuK8LvtzvtcvVCQIiElAXH25tvzjd9OvJudCiVTiSz7I90JnWwPp18F/PUTdlGyzgPVMipfjD2VLXwN9JDZWDUfrcWvbb9wRGmDDH+ZYGkIR2Zt668k3hszM+9ziGD5rVMtxy7gESq3xMu0G9qk8nj2HncsYdz4jrPvDRrY2NMsPWY8Z6s22ZJSQb+nspsxDgHdhlCWFjHhhd8O+a8aQB7r2ti2ZBzwSFmZvC8KFWqBCuHH2yTCI16QF8wqh0RaMnKgVSSr3vCUFZEpLZCAR8FW0wcJS/FbY8O1l4vCdOxic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/wMVCwbfMV1TvYqYxCZWLwkhGFgoJ0MKtJyntibnAsGaR3PC2PXF7n+fW7I4?=
 =?us-ascii?Q?LXHJmTPjeKdQNjRYUjVV6x12ZtOKNO0mQ7r53q8DBGPvTqQTMvWhDz7+WMOf?=
 =?us-ascii?Q?sfStaIkM9+mcKGwhzLlN+RH5kym6R2PxH1NIKk9kGjY71RNRAnXSjZr6d72x?=
 =?us-ascii?Q?WTKUw5Vxm3eAUlUfOWAWfT4le/vytRGpnIBunHPaepLNuvHfVetruk5Gca7r?=
 =?us-ascii?Q?+p8b3lQTxlFEPI/kG3hbqY+icPSi8+5H0WV2agR/HXhlUXHMcu6S5czXUMGu?=
 =?us-ascii?Q?q7BOebhO87jwZ0q98K8C3GjldUWGTyReTm9PzhDRr15dqXdXluszoiV4mmaJ?=
 =?us-ascii?Q?9GbjI5cTpKuCNBBg9xzFhrf3OToIkoTZHxh1Ku/O5TP87xuaUouRPFtKaqj+?=
 =?us-ascii?Q?ttvK2jlLmfD1usGXLzgglBWbcITL6SmiI4iwgmlKaOZ9DO1C9GCT5crnTPi7?=
 =?us-ascii?Q?xRgxHNOlFlnBCLsrslaGWRizPyL47JeiKbi3aU8H6Cl/67NRSfpQwAZOpQIC?=
 =?us-ascii?Q?IWmt/NoLfX2Od3IgXrx1fEdtH4uqt6dGZ726PTAzQ/u9xjjbqo1VoBNXHZGI?=
 =?us-ascii?Q?XSce6pJ+nZCyYr2jIdG4r50in/00LSM1y3TBL/2gM1+VD2oypv5qfIvRHHTu?=
 =?us-ascii?Q?P4UCs4H6VViXrMaR5x/q4CSXag0cqKWfY8nZdgGuCkzd1RaX5HHDZtBfMZmw?=
 =?us-ascii?Q?1a3/mTEHnhqe2aJsaRksJJZQy+cbss95cmk4wya2DamiweIZPGjiZObGny2u?=
 =?us-ascii?Q?Um+tuHT71hry2VD5FmHSXz45tpWVgAtB6q6qxIPW4ODeip0BRRU91z0CYZhx?=
 =?us-ascii?Q?0EfeIAEES3w0P3oCg73NR2aFqmaDuaxxUttef4rRGrWrQcQMH+j80I+tBbeR?=
 =?us-ascii?Q?sV40Gh8D9J/MjuD14vXns7AhbUndBYzs4aTjjKpHBdDOaFpiUzLVrenurSdz?=
 =?us-ascii?Q?2ifoi//TXbiutv+YevnKFXsNRigwOqtBaEt8/jGCvTouB7oOsP6nh273dtKi?=
 =?us-ascii?Q?fOKsiM9uz0kxiaHNWALWsV1Du7sOEgOc9yZSImQxxJ8PudETb5wvXn76+tsQ?=
 =?us-ascii?Q?CQOy+7tIqLU3tYqm/ekO8s3Gy2EClqzdQVDP9kePvnKJo0FrkJQseMU6tgrN?=
 =?us-ascii?Q?68EBr+GZjb4m5MgAooaQYqgrVrlmmffjs8DR0Xw+ey+D1ftNXe/9bNy65mT+?=
 =?us-ascii?Q?iQNN+giiBbWDjrCYpoLS8qMidWqrmEFXOKA6zd/UjH9TjISjrvuzS1QWfwXI?=
 =?us-ascii?Q?XtvOClPscP2MyAHPEcD52LHTRLnZpXU5e6fPdPTcS6ygWwTmdhd5u4qROo1G?=
 =?us-ascii?Q?ElgOngil2sQhyBOJ9yoXUPDDTT1v6TEreHBy2NvmJywOLGdbzPnA/7dHBByX?=
 =?us-ascii?Q?XRxd0dWpIyGCfIKK1x/Xw+fb5MuS+mmnlE7eCqnlnFPk6syLp/B/wLv8T1hN?=
 =?us-ascii?Q?BQJlVyvsb/AUrZt0ClTThZ0IMpR1xUKSbPMv1PkznmRXPaqTcLAemx83HuFc?=
 =?us-ascii?Q?nu2o4+zDPa0R5Z0PfwSJRqbaOh464KDRAoa7h/wuD0bXUcjJWZJ8aSAZX9IP?=
 =?us-ascii?Q?OucuMFSbYqOTVrUOKstdeaT7/TCMSgvBRzi+DsYr2oXk5YMttD01BkAg0/RF?=
 =?us-ascii?Q?y8bST6VCPnHIwYE+OFwBJ8DJGSXBEfAH+NS9Vj9CZXGgUoHPjoyivoVmTS/I?=
 =?us-ascii?Q?dBMGvDejRBls3CP57H7a5gUG3FhgY3XeVA3hzIYDureDlyCsZCTN1q/zPmSn?=
 =?us-ascii?Q?/AxS+Qc8SZVUcw/xuIwD9aCYGsIvOQo=3D?=
X-Exchange-RoutingPolicyChecked: cQ70Z37VyagmqNCLYgPAW5hSXjKwLZWTBT6iHIhRvq8gusm84WjcyChirr462s0L9qxuSRmBmpt48N9yRg+sx1qyw7IMPdhUxwt67zeeDpgWe14tvtftnm8iKBKZN2yC1A3O4ewysKMfWJei7s/aFulI45kc32cXXp4ifpp/gTrF4nY58STP3BqhP6fLYRs2b+1BC0X+WWy/9jjR3qtP2bNgafTWAjPRBQt57gxK7upz7CEijKOJbMfySBBa4QKVtdVgEFsryx8dHHjj4fUtmcyfR3Pk60KFn0cTjPKKQ5jO5BPg2QaZqrmE9virWBW1lGm74OxU1pt6aqMxLbhJQw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b07bedf-54ff-4e0a-fa2d-08df2b90c0d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:22.3596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VssWmOWAkKQkuzpSL9/aeKqq2z+bVClEJOEUlZjbYivNtdu4XeJ0Wfz+AkXF0KYzlMdOS+LIrmsyQZqOSJnAH4+rkGBOUXT5e+HZ1ebEn60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11424
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX214Jpu7KER7K
 IVCJ6vs3vorFa6AjXJM7jEVZWpYvQt7taaRPfnnZuQAr70RLWTauuUTEIhuz6aPJ+66mninQg5t
 aa8nQr3MJ5kKOnG07WV9WpntE0ldUls=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX8V7JcSpRk3of
 FWn69VnTgmDIUTvnH4NqcVk9uaSjuNnqPZyjlECjzt+GRML6WLEwDxfgw8tgaeScALEPy85ACrU
 Q+yMKDzV1VK6gVshfHYrtLqy8PXr96cLHisc1IYtLEAcDsXrC/GJG/QALtJo+6XfKWX/EPCMydL
 HzLGObYK5quOmsRyI4kkkTa7VSvs6uOBMqVdyfI92ogJuY7b6a27ZWy6Kq6yNw8nbkdOzHhYpLw
 Pq8c5sRzwH8XX7Q63bt/d4tn2NWveyVND+Qz0iavMytETDf4vn/XLJItnqHiew8XEnt6pLM/pDy
 qhRezVMxvzd+aeIpQ3jKhMWMIf4hfF/fJI36EYrg3KVTM5Crx5Mqwo3TiGJwGA5tWrEWq+WfeP1
 /m3oOY/luuv8Rm4b9r0+grrnzMXp7AqHLoWepBYcL0fooFmnVZcvK0kaq2brFxxh0LlS/LUpRAC
 4hs+0m6OSET5biSc6Eg==
X-Proofpoint-ORIG-GUID: 9BijS6P-u8FfvluJ6mff_JSI0miuWALB
X-Authority-Analysis: v=2.4 cv=ItOL47/g c=1 sm=1 tr=0 ts=6ad232e4 cx=c_pps
 a=LbO2ZyHrMbRaCxC771SosA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=m1qT39pvC01PgN2II3AA:9
X-Proofpoint-GUID: 9BijS6P-u8FfvluJ6mff_JSI0miuWALB
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

The use of consistent variable names makes it much easier to follow which
fields are being accessed from I8259CommonState.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h |  6 +--
 hw/intc/i8259_common.c          | 74 ++++++++++++++++-----------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index e039d6f067..71fdd74266 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -37,8 +37,8 @@ OBJECT_DECLARE_TYPE(I8259CommonState, I8259CommonClass, I8259_COMMON)
 struct I8259CommonClass {
     DeviceClass parent_class;
 
-    void (*pre_save)(I8259CommonState *s);
-    void (*post_load)(I8259CommonState *s);
+    void (*pre_save)(I8259CommonState *cs);
+    void (*post_load)(I8259CommonState *cs);
 };
 
 struct I8259CommonState {
@@ -70,7 +70,7 @@ struct I8259CommonState {
     MemoryRegion elcr_io;
 };
 
-void pic_reset_common(I8259CommonState *s);
+void pic_reset_common(I8259CommonState *cs);
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
 void pic_stat_update_irq(int irq, int level);
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index ac8dc7cf00..705a28ecbf 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -33,33 +33,33 @@
 static int irq_level[16];
 static uint64_t irq_count[16];
 
-void pic_reset_common(I8259CommonState *s)
+void pic_reset_common(I8259CommonState *cs)
 {
-    s->last_irr = 0;
-    s->irr &= s->elcr;
-    s->imr = 0;
-    s->isr = 0;
-    s->priority_add = 0;
-    s->irq_base = 0;
-    s->read_reg_select = 0;
-    s->poll = 0;
-    s->special_mask = 0;
-    s->init_state = 0;
-    s->auto_eoi = 0;
-    s->rotate_on_auto_eoi = 0;
-    s->special_fully_nested_mode = 0;
-    s->init4 = 0;
-    s->single_mode = 0;
+    cs->last_irr = 0;
+    cs->irr &= cs->elcr;
+    cs->imr = 0;
+    cs->isr = 0;
+    cs->priority_add = 0;
+    cs->irq_base = 0;
+    cs->read_reg_select = 0;
+    cs->poll = 0;
+    cs->special_mask = 0;
+    cs->init_state = 0;
+    cs->auto_eoi = 0;
+    cs->rotate_on_auto_eoi = 0;
+    cs->special_fully_nested_mode = 0;
+    cs->init4 = 0;
+    cs->single_mode = 0;
     /* Note: ELCR and LTIM are not reset */
 }
 
 static int pic_dispatch_pre_save(void *opaque)
 {
-    I8259CommonState *s = opaque;
-    I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
+    I8259CommonState *cs = opaque;
+    I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
 
     if (info->pre_save) {
-        info->pre_save(s);
+        info->pre_save(cs);
     }
 
     return 0;
@@ -67,26 +67,26 @@ static int pic_dispatch_pre_save(void *opaque)
 
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
-    I8259CommonState *s = opaque;
-    I8259CommonClass *info = I8259_COMMON_GET_CLASS(s);
+    I8259CommonState *cs = opaque;
+    I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
 
     if (info->post_load) {
-        info->post_load(s);
+        info->post_load(cs);
     }
     return 0;
 }
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
-    isa_register_ioport(isa, &s->base_io, s->iobase);
-    if (s->elcr_addr != -1) {
-        isa_register_ioport(isa, &s->elcr_io, s->elcr_addr);
+    isa_register_ioport(isa, &cs->base_io, cs->iobase);
+    if (cs->elcr_addr != -1) {
+        isa_register_ioport(isa, &cs->elcr_io, cs->elcr_addr);
     }
 
-    qdev_set_legacy_instance_id(dev, s->iobase, 1);
+    qdev_set_legacy_instance_id(dev, cs->iobase, 1);
 }
 
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
@@ -118,9 +118,9 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    I8259CommonState *s = I8259_COMMON(obj);
+    I8259CommonState *cs = I8259_COMMON(obj);
 
-    if (s->master) {
+    if (cs->master) {
         *irq_counts = irq_count;
         *nb_irqs = ARRAY_SIZE(irq_count);
     } else {
@@ -133,22 +133,22 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    I8259CommonState *s = I8259_COMMON(obj);
+    I8259CommonState *cs = I8259_COMMON(obj);
 
-    pic_dispatch_pre_save(s);
+    pic_dispatch_pre_save(cs);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
                            "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
-                           s->master ? 0 : 1, s->irr, s->imr, s->isr,
-                           s->priority_add,
-                           s->irq_base, s->read_reg_select, s->elcr,
-                           s->special_fully_nested_mode);
+                           cs->master ? 0 : 1, cs->irr, cs->imr, cs->isr,
+                           cs->priority_add,
+                           cs->irq_base, cs->read_reg_select, cs->elcr,
+                           cs->special_fully_nested_mode);
 }
 
 static bool ltim_state_needed(void *opaque)
 {
-    I8259CommonState *s = I8259_COMMON(opaque);
+    I8259CommonState *cs = I8259_COMMON(opaque);
 
-    return !!s->ltim;
+    return !!cs->ltim;
 }
 
 static const VMStateDescription vmstate_pic_ltim = {
-- 
2.43.0


