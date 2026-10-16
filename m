Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EF1CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHir8-00066k-09; Fri, 16 Oct 2026 10:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHipN-0003HI-RQ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:41 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHipM-0006lx-04
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:33 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5G7K3551949; Fri, 16 Oct 2026 07:22:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AbKFGCy6bi6Di+SjRTibND8oFXMooQqZd57pXAx9H
 zs=; b=bU5Vyd05eMr3Hu2NPbXOnfrUIiqH3TDDscLl/o0KZdhCeAEyf7U3Evdbs
 caNpomMWH3W3KRbDdtEqBS2R0mIe9V+n5Z1ZV00hQ8nb7TO41snecTq9AsklDNJm
 F9ayDGBJbvP2pc72lI5gpJGAbn4YLcfDB2a5WwUXMP/5Dv6Ht8qRzc8vPet/TPuV
 eQQwO+JWBnFuNJaOF1rvhS6B36X0u5AWlcuksDhdaLu0I9wuRflGblfPCsfbkPsJ
 hPHa89pO3Bbn3Gi4GHYHoXoHnBC9oA453y8hm0oGvl2FKT/4ft9h/AdrqVTTjJt3
 IGmXte74XoQZk5fWmexEjQSRMmD3g==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022137.outbound.protection.outlook.com [52.101.53.137])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hbmjc04ym-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xogJEyJAzhv2IVwibE+qP0EM1PhGPdmGP1nEEHDejLVFcbL8mP5/bDnOB3jqH60mPwBppJyiTHdiDvnq9qujdeUnO7qxw08l40VCQmDjm6P3NyiiJP5ftcbVuvsKNWWymGS3SOqioW1Fwp7w2M3Zzo0UXqdW4V+GlxHWXLugF/0z8Y8ZEB6lifQxuP32ldupxDwr4UcYwCOROG+3JMzdxEshXaaWky6OeYtStzY4cnDuIfxAOYu4vWS+tMmspLHmucvRlrIOFn1m5jC0bAeoFciq1cI5aRFaNAY/4NcwqQP0cYktj/jNn3jsYdAoJFjvERTG0b9/p3Wuols5v9fLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbKFGCy6bi6Di+SjRTibND8oFXMooQqZd57pXAx9Hzs=;
 b=uz2dV//ik4ZEcr6WnkuNIE1Hc9E2ke2aWQXVmVRaTsHZm8Atxd4nwqBq1YlwZ6mUQAjuHI41GQj0lMz1Q+Kg+TSfyzslQ4U7FI83CxD19F/KOGsOwmbzNtl7Y3t2fENLis/s+pv9QZf5RAe5k3JUQv57zJ6K0UyY1+n3xs/+ynrgC7imJivUihdOM8sO32dDwZD1fYUPmcGUAT4aftgfZcIVYF1AAWYxDUXvwWLIsViadYiNFA/kqw7R+2a3cQwLpTJboXJlYhSSPsT21ZYrY2N4OZqlUFEEwd+KUp9u5jp6+MZ68ti9ahWAwcoD6A6PDFnIAjeCEUcwHvRafru/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbKFGCy6bi6Di+SjRTibND8oFXMooQqZd57pXAx9Hzs=;
 b=TjReIKquWeQvqpCVVHUEMk9tQhiTEZhvMVC9NsklYjg49/waw+U6Cx+Sf/w7svTTqDAknJOHroQSwY3fSqPqzToOUpoE0fyR76eMhQcfp+/vlct08Rf+Kc+YXsOEHotql6A1VmxQS9QTMDFnj2qRHxu+pNMhScD+mfmhAKa5Xg+gDPMrqk28fYZUK8m0Ho2vQyalcaO1uhxhQbkfLnbrkvB31by0KDNRMrUDFezt5MAXK0Sz08I32SdQXx9IY+KMTYU2BKfsEPnYx+0lwLdS6um04tFLiulcg0Gox8Z+pdtkDdJSmKAi/czB9RElkVFEMSpmiuVqoKSVD5lO9Z5ctA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9592.namprd02.prod.outlook.com (2603:10b6:208:3f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 14:22:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:22:07 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 22/27] xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC device
Date: Fri, 16 Oct 2026 15:19:28 +0100
Message-ID: <20261016142031.1204281-23-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 10889001-150b-43e7-a002-08df2b90dbb1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: PkEVfLxaucb2zP1v959XIFKxe48X49VR79aG7G3NxBW2ltUani9cAL1AhaToC4Vy+SgEGLSfAtLYcLiyL0zU/bSMd6FITrWFQ87/riEK3ZrREu2iYtxMlhM2VdxASE3Cr/qpoL0SVWLgpZn2RfCHNXAEg+jsQXUpBBTDy1gAmUFx92dMuOb1G4nzrxQMvhFxyBl7qI1aL6VVMVaHjhOQMj/BK4AwpBJ1bQ6m7QfoYkU9k/a6x5ThP46hi/BTmqx+0ykMggUMEIi6w5wQfqKKaGdYx+L0L6BylhSPLiVDtr/QCNuxjB/JM6C3koMHaoaJ1rZyR92yv6orgkAhn2Idn+OIDxGv8MqTFO6Ka6P0s0NcvdbKo4XHDdoQh/tzWApLg3wHklNkEfSU6BCMLnquEACCbRloOHvrKMoVV/00V//rM8LaojEVx/plQPzJLtuHMFX/prLIx/LldurFx9xu4owIZmjlfAAsRttB2qZFU3R54E7CFn40ljnClHCcIgyr6xz8UFMojsk6Cd3lT2xnpXZU3qlze8Z9kERk97cpVC18/zYBsI7xjvL5W/rUUNP8kHs1uzp7W3YtRqEee7/wMPUfNDjpRKUutzBQ9uvd6OwHp7a6qEsAthpL5iQLkzZurqNeulWWokQNEHB5YIrIAEdIUgC+jvnQ9mHK/4iDM+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ijjZV0wT+0F3kD/iYfXJzNcwpvhi4XLOJKV/zS5dOSp7gjoGUmCc5XAD5kyq?=
 =?us-ascii?Q?sja5VIJdc/0KS0N2PyF5foA4I3WZUAETsYc2nSBES0675oL/RG6Jxt5UNO3P?=
 =?us-ascii?Q?bdSDvr/gjFAIbLAe3nhoPofH/GMYMip0QmU2ePEORaiedxC3EumPRAObi6In?=
 =?us-ascii?Q?l5Z9yFBbddOCpi2nuLL9QGnruyLoqmZX4sZaj7K3QpKcgnQLC7S+n6PSFh+0?=
 =?us-ascii?Q?h8FjEC/dhQEEzVsUdJqUveZM+0OEEZ+SjmATbvf2YPA9hrG8WzQiKBt3lwVd?=
 =?us-ascii?Q?PegOZCtMfz4OgzZ3USReavsCfhiSCHia4aFPz/4/REaKYbtOA/ck6zukOp0B?=
 =?us-ascii?Q?fuuwaeTt2sWvnZiq2iYFsjdNadDf/KzHzod0R90RwW5ZUr6r1ZgTjzEAw330?=
 =?us-ascii?Q?9/y9Z1RJZvbWU6BDgdixQVp+WydNbcpS+tdUTiyWue+QV74qJbktFQYnpNs1?=
 =?us-ascii?Q?aQigsV18scR+sPzKGRtnXpu0h5vlRfv5X7Uo4MOCqiOta4xn+XNVur54h4Kw?=
 =?us-ascii?Q?UKBnSnztkI2IMjTJxA3d62jowecbfbIIH4WT49sZFjaeROq4a6lhfDb/4Fuc?=
 =?us-ascii?Q?YddQUgX+Bf5eynzZiH6BT+H5WV8k6C840ie8I24pdLWZvz6fX5JoJZHyi65J?=
 =?us-ascii?Q?HT9JuHqPjS36yotIstEyCeluN9MBzaQIhqDOjo8d9ZA6P5qK+LbtFPTxze3z?=
 =?us-ascii?Q?RL2+wL4eYDTJwGEZ6A9k0FHM1E0CKhe14dymiOoT2DLNyP6lCej6kLA+i1wK?=
 =?us-ascii?Q?y3IrrvPHIAfFKyGjvUmj8HOa8CWQggvQHScsXqTfKsSMJYEUMsdppjeocNWd?=
 =?us-ascii?Q?jGKIVY+orZjNziwkRWUwe8dqOxP8n26//iUN1JnW3N7ZcNL6gBDifvC9X+xe?=
 =?us-ascii?Q?vnKTs82+Dkuq4BIKtBAKhXcIHyUgZY5aPXBZKy19GUM+crr/QR1GFQ//P+kC?=
 =?us-ascii?Q?eHP2fGxD3VWFTcIU4mr0hactGwhukPDg0ix1Da3zi8LSYbm7BsCtUQb6f9Ot?=
 =?us-ascii?Q?QpCCqiQwm++ObR90LbrdfLjPNOF/XU9KRz4x1OGpzjdwVi+grZzW7Wo6MLyY?=
 =?us-ascii?Q?rAHw78pO5ufxHmrDu+lUTert6Ji7PMp335sQZ/3s4z182D94xjkX1gIJWdI0?=
 =?us-ascii?Q?8zNp6F0LNNpUalqG124WFX3fFVcQdr7TUHdmrjNz2/I8cwHcd3eOD13GZV6D?=
 =?us-ascii?Q?H7eCD5yDkhyqrNaooexYWrQpxa2OU/gFF5mTCSdg7betX/y0p3B0RnGWyCR9?=
 =?us-ascii?Q?ilpeG60/BPZyFMxb4Xbb1DiGL0MjIeFu0SeTbrQD66MnYVAoRYD7XlXtRBLo?=
 =?us-ascii?Q?TSfzgI8uh+eVXmDLyyEeBwyZGC7wgW4AFGbb+5gU3YpJ1tBX1mCRaPh6i/yq?=
 =?us-ascii?Q?9tC+V4l/D+L8Hd1o0TxJdo53qjsr7oiKV0Z/fMkiKEQKvOMPnZt1PwvupT0+?=
 =?us-ascii?Q?2XtvpjiXWH87du72Plpj+1eKutTKNqdNQA8vIgQNAFt/acJXW9N9mjTtnJMK?=
 =?us-ascii?Q?HozGSI9iX52z8912EHuvMILo9qXMKi9Pp5akf4+AkcQWq35znTsmf4t9l1YY?=
 =?us-ascii?Q?Rp2Hu0+32aqBiIa5A2n3aQcZBPcvvUHRkQJCqMDNDY+BYy81gHI3+f3Zxbxc?=
 =?us-ascii?Q?MFXjGXts3t5T4BXLB/H/ytzI5GwaVWJ1G4SJ6NbddJFuDxfuTmDvFttjjWrO?=
 =?us-ascii?Q?DeGEDIvfX1A8yN9BZJJ6FUoVylUvRr3BAfOkUTLDi4wnPzD8WBca1N32kdgJ?=
 =?us-ascii?Q?zBecfQoNUBAlufAr87n9UhrvTQm92Rw=3D?=
X-Exchange-RoutingPolicyChecked: BErXZDCPp1FzU78zIdZzvW6AccKILXH6+PB6blu/JI++miUFsGymMw6tSymv84XI+8cNx/n+/h2IULaL40dXs8oFI64FsVkgPAGUKHerdZmr2fPiQNdNqbijc2c5P1q7S0GQWtunSoA6SAc5wKOQLrqpFhjRlG/j59H8P204rwcF8SUMAeMsUQydCZq0x8pgGFT75Rvo7YzrclX3G0y+TUVOk+O/fRhqWCeWPnzz9ErB1E5E6NZZW/hkbRyS0Lc1UGVocHZLZsPR/boIMDHzIjgBV4mUj+wAdoaTNhLW7yC50XZqkBHt7xwsyk6ZtnShkEnC/YhCkee0+jJA/y/qkg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10889001-150b-43e7-a002-08df2b90dbb1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:22:07.1990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWiDnBG3xRLj/QXoBXJhdXO0w66Ceh45x8wJ+IWIZ2CQUf3+COUcVTWyyY+OAS4tE3kNWTu7GTzPgVdvq9pMu+MoP0NgOUpUfnOHNqWGzUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9592
X-Authority-Analysis: v=2.4 cv=dasVTnXe c=1 sm=1 tr=0 ts=6ad23310 cx=c_pps
 a=XMkfF010lpKDMmMg3xIHFw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=tqVLSPGIGyqkaOPIRdYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX47XJvywn92Hn
 TjwBZsyJOG9namOQlbuGvDKkVNAs3V5QpMW//6T2jla9wOcEbt26QH5jNiux7C6gMLrWUNCi+WE
 XCXWgHGj4qI7hegQmsnfr6Rq4/EeW+IB4YidHe3NWG4AMCp36RBY97VJtB2vU42J3HxO8vdo7+8
 EIpsyDPAC2Cv8KZ+8QPphS+kDn5fX/rz56sMH3Xs/90OyqbSAruDHT/nAzTzQ3TwYzM++mRbGXw
 TQJnO3QCPTlmjoH8gLek1OLEOguTU6xTobPKTYdokeV7YGbVvqsABUtfJvDBKSP3f4/x+qV3q5X
 ttJcBA+bjHLG5mZmd5HLwL8lwsz+jDh/Eqf4dF7fGYDs37l4wDV6Fwa8ZKsD8hPdsufgXqygGGG
 cj2tPGEYgPy9I2uy3798WMoLkExVZlqiqmtLleoY2wwT38I/DyIqD5JTHvB7ZWFDQnjffZ0p3Kr
 3Jk2KKD6U802EGilKHA==
X-Proofpoint-GUID: DkJIZ-r-yw6uhv4bJ7X1Ic5EhhPLUhqw
X-Proofpoint-ORIG-GUID: DkJIZ-r-yw6uhv4bJ7X1Ic5EhhPLUhqw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX/RR+ch8ahAsW
 P0M4q3nAJ9wYQZu1XCwr/Rx1+eONLzkEuQf0hHiud5TSEVZPyz3kE3Dr0JAK+nfUP0W0+eolY4S
 JF/sMkLncC6Hj3hbUx1VvRhAadJbV34=
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


