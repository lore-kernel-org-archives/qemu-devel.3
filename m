Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2FCC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeMr-0002O1-5x; Fri, 03 Jul 2026 09:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMo-0002Mh-JH; Fri, 03 Jul 2026 09:55:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMm-0006U7-EH; Fri, 03 Jul 2026 09:55:42 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635r4wp1963741; Fri, 3 Jul 2026 06:55:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=RJm8R7jXNGYolIE5+sTrPiZKOCt0OSw1QrO3vvNIC
 4s=; b=BhKyuIVwg4lsfqzofXiBY1BSrxnMceWw42XDotuRVEPMWpJn/OkugNVC8
 RJGE57b1khZcqX9Xj7oqm5uXgmo0OySMIrlP/mMeo++g+ppwDzzgGlcb2Ki9shLl
 kQMplMHIWcf3JxAYAGexz1CqZUrHGDWlHIj/gz2wzThArFuFds86SJSIqQ6B0SQl
 Q7Bl9OtKURqYeIRfbfRK6tdRAUH8y1L0W4l18fpTy6MrgmI27pgpF1spPNvCA/JI
 5zrQj1MC8eo2HcI5NzILhuYtTUVCx5/En0GxkDcnq7vjl7BHyTNmh1AoqjNsNbwV
 JRs/fFmzRY5UnKMsmZuCYllo0cEQA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020120.outbound.protection.outlook.com
 [40.93.198.120])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f6080spx6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOzjTGaMw5Az7g55a3ai590BLRU7I0bVHO4cllQUomQ/6HJSpHQmH+U33t44MOsSed5ILCWJwQ/2nMXk7dwKpTTXwVeuBrAwkvbPBk7NYsOQegoMzoPljyEW+zkw5v2GWZMzFXYoNnRsAAej6I2NPh/PYIUxm7IvvQaRvaA5YCeMmmOl2GhHcmUbrJGKUdJBtcvaHRg+CSf5L1sK2rzk2iakr3jvA8paFwHQyzexcQjBpeeLsVO9OQOqb4cC1g2ppPJxRJ6oCrUQT4REUViu6zNnujF9avTeoTn/VNO+GOARCuvQfObcnGqMHpbdKMLZPW40jSIOTTvnDRdJxhXyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJm8R7jXNGYolIE5+sTrPiZKOCt0OSw1QrO3vvNIC4s=;
 b=KxZaIGneGW3EdgM/tu1dv8jXwCffWf2XGUzj+63VQyiXZj1LwUP2RU9lE5CWs5xN0q3VBa6XCP3YGDBcjhDXY2eJb5HDK/UsMUp094pO8ELlT3735A6vpazmrpyBXx/qcms7NBKr0UHUFM34nEm/PB5dnY7TzUre6VyTt6CGVCryq1MqyKr+vyhA9VjeKVS7w+rI0AAbT7jkb4NP9ClcAIrCh1EaUPdqsXnlv/pMntrbcMrr5uM9Zze5bxCUqucdTgceCtNAEENtTvtQsDwPWaAkbD7C6MM5Fukm0BYsnrVpfMhDtis2Gh6UBwWZhWYvKhLPAfElZLx+gcupSxlstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJm8R7jXNGYolIE5+sTrPiZKOCt0OSw1QrO3vvNIC4s=;
 b=twk3y6pVL3HRkW3MNVG59N/92ytCaAhRdOm9uYRGMqMQ2ufNor7i2UpSkPaa57QosQRg3KkcoiM0KqLvtF/RsxwrbY++hn4obh08xxXnEjfLrE7WQ1nwFHAqVoRK3uarF3cEZrVJoGX3GD6Bu0TH3PER8Xem5laD6HHtf4fI/wIz/2wi0GTMqLITHLkOKoxeTHno9LYUjgal+tYT72xHW2TeRMkwIwmryV4/4MnCoqu1uGAmDb9TqJUoCCNcWx7A3tOt+pqME6v4mVtY4mAUyEh2FyXmj7R5gywUIPW0AnhntMZ6gA7LbbkDb4jycvD87khiNM3z1t08hy2IFD3gyw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11394.namprd02.prod.outlook.com (2603:10b6:8:353::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 13:55:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 03/12] qom/object.c: add
 object_class_property_add_uint16_ptr()
Date: Fri,  3 Jul 2026 14:53:05 +0100
Message-ID: <20260703135512.3213964-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11394:EE_
X-MS-Office365-Filtering-Correlation-Id: 606fdcde-7b37-445d-4fc5-08ded90abbf6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: yWcLMVrBkK0gn+vr2ZYc6hzijeqmzgpqSyt4J7Ncy8npHOBp5oZ34oSO9BbFoMTe0NAHvZ5kN6AAdvnNHwXudGONIWzR67zVPS0QX3RCQWfdd3y5/7iOd/HUi0Nel7roLQC2e0nOY0XGZKk41iBgPq9SreGVaCoxS2EU7uqsp91D83lAHqncwx1G9ofv4cK8FBwvs4WXU289jgKdC6txBag/T0Jl0wCzKjSMJfBWUrja9/KqfabMGd/vnlExmsRs92npDoEz7lZeaWdHcJbak1faINrvXBpLWWmVR0/pE6idTpx7jSFIQ7AQuqF0RNA2Pw6o39byEW/WFpuf8HVbteyUemcVdwuk1PrV/caw3sxFi9Evd9wMl56iDeuWI+RrzymBFcFTUv/3OzCOHnmUpUif8OgQWaE3lqIVoiR/u0FfqY2JoW3Q5Aczr2icuU8uZg3sZx0rHA6KeITXCO//DsWBNdhyAWwE88nGqKtKCU94tGuKUCfNijz1VpmtB2ffZ5OJePh+oUxYqvSCMu6EsC1j+gFGEddj4JYqwLZGJ7bzHaMRb4MQHxjxuzGL5COfoNO9sb72t0+K2kR2T31YhlWlCsvRei0BmVMEHvwSynlPVezTRwD4HLgR6CwEvb+n+09Jc1E5QKlRVc/gbtbWWktjzPGX5cGAQfqayz0ilTsnOJ4BBOdcuCjrdsquBcy+oKOd5D3W8HkSrG8UnUyHWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z+7soAufEmUPXjdfPotn5qO86sGWjKUqrSZRv/8Ww4+Eh8DGkGXjN7+PLwM2?=
 =?us-ascii?Q?xu1l3e2zsgg+NY9VP3XOEV1w964e9/JnN2TM5ETtL1+VQWSWnBd69++1dgg/?=
 =?us-ascii?Q?5BceUKeB893c/rukDgkfP00FHeWTzhx0TeewDQhEnVjWdqs5ahOeXzT7HxXO?=
 =?us-ascii?Q?B0vxfD3NquAvyz7Vy6gHr7Nshc1EyNiOtJWOReBJkxqu63QK5fC9kJTbwRJy?=
 =?us-ascii?Q?CGMc/B/nkgR1qboDBamGjUMxit0tGnsV11LxiloD08FBzMz5DS59F5vmjRBo?=
 =?us-ascii?Q?3mDRG7Nrz1Q0HKYsE5jYNwHpzxh5ncLuK9qFP2MBenPDlI6q5fXD1fewuirR?=
 =?us-ascii?Q?PqdcibPnFwi1VExuOT9RPrME1G214EUFvw0oSKpExTKuApaqdoba8V0/SHef?=
 =?us-ascii?Q?Wm187IMykBG9M79pehA2s+q4gaSvsIbUGA3LnUE6JLeg5QX3psdHQSbm0Egw?=
 =?us-ascii?Q?Z0B1/sdGx+c3VZsQjDV1OKurGnwK6Rt2e2x4yR7s/stRN+wIWh9ObXrVvzYR?=
 =?us-ascii?Q?9qvVSbxopU99rW0vCVKwXZaa7ghRmeoaNlBoRhT3uWHtfmIxDjaGUAfR2voo?=
 =?us-ascii?Q?FBIvGgcfn1n3BSCJula0rYnOHwccC678VhcN67D0wmG/TpbeQ+4PVQ5gNgLn?=
 =?us-ascii?Q?4KEAtrY1sWIzb8BFkqBwm8s2AzhIiiNbsat3k41QIbu1iyovq3jPPUByf94D?=
 =?us-ascii?Q?gmzweZnzQu2opkrP60jgkIKzYDmQ+DQNbkIUxt1qyCiDmqlsyxUFKHmpDhbY?=
 =?us-ascii?Q?SkK2+r+CLVd67NOTbzfpZJeDyGnSs2U6meNRD3Zzc7bc+sU4RBnNRk8W+uDd?=
 =?us-ascii?Q?3A5u9N4Im48pau56iBqlzLlJQB8fhUhSTm4J0weKcGFyvf7eCpkkdG6VkVPU?=
 =?us-ascii?Q?ksEYQASCrAluoqDbAQfLCTQ6U8owwk3dtWH9CfyCBV9z6hcn10vxrkkbNz4+?=
 =?us-ascii?Q?IjjwHtEa+YWzuP0VsSq9LlF9hGUAcp/zNwc35jaNmu0lTxpDwPn/H6AM1H7p?=
 =?us-ascii?Q?pVUPP3bYmBsG7+QexFzCOV92glZJt6F0jB0Xt7MBd81bJXwXmZMiVkLNPXXE?=
 =?us-ascii?Q?Vl/TaDFBiIivyqRPfWhFlGKjkxvQG7siZHiAiCUVxV3leczbejPYHT3KgAGX?=
 =?us-ascii?Q?DOVm+5XutKcKWmSBeUMWT27J+kZenAVjrAt0CkiFZ70wqz2KfhSPH8KnUxsn?=
 =?us-ascii?Q?u9Pa9DQTVdjQ7JpJGFDOW3b1V+5R4OMVwNc8ImmkdiOAOWNUGdicBdY0eSIo?=
 =?us-ascii?Q?HMbNevs0CXtcPDfKiRnzdHbkC/ydxGTpJolYyEXzQ7wfTKNZjvQmxLwjEb/c?=
 =?us-ascii?Q?tth08dXrOhcs/r1q0MVaSNQaeuFuYah8qasqaIhUxsnh4nDRmMtOKZdn30TI?=
 =?us-ascii?Q?dFtXe54+A/hHnsquKs9sJOHBeSbi8gTtxH+d+a157aWHpoXdArG+ipNsyt+6?=
 =?us-ascii?Q?xCIGFdrj953wUhliVWXCoxPSqsdcHSVDfosFSEWrSJWZ/GyCXY7dOEhUGxS2?=
 =?us-ascii?Q?tPrGYM/e9X7stWeR2/OHhuI0v7DKF+QsosFFgfkRH191cAyFiM9l9dfTKpEL?=
 =?us-ascii?Q?IMAvm102oSHNuDgO6j8tu7LuUMam0wn07v0vs8pLKhFeRXLFNuir4w5eAIce?=
 =?us-ascii?Q?w40nmPOVFs8aTGKfEh0zBN2qsfWv5usTnfM2YEK0OpVsuaurWeaSVF+1JOCb?=
 =?us-ascii?Q?jtYlxrnVvq1AOvGcNeqJ9yyoAKVJLezX33zrk3jbXe3B9IvsCJIs4MIiNUwM?=
 =?us-ascii?Q?uwHMwt20Qq8pnAax2iaFUKg0dT1ecVA=3D?=
X-Exchange-RoutingPolicyChecked: RjcyIxxjYZJRZBZ56VTF8MY4csDAHAI1CIhfb9h0xe74Q+syBkKQTBmq4YFyya2vCwvGEwHus8CiZQimlNKyGO6+dgojzmFDQf8xsllTqfS3ehFwBSkFkpq+6v/5TKTi9b4d59gnUMFa/ipsK21VUztwPaLFTVgwBf+GqQlRKmD/lCZ1QQcPF74mNGTn+KPsbI3H/WNNqV+XYK5jSrKyyxotzdTfbGqhOATmke/Bam2Wz4h6O9hkXmrGPkt+0Bf5rrCGMhO+Byfgc50zZIVqwVvzTHeA29afcxX7T4PIsbIJ3aKmOsSeLFL593QjU+sVUhvz53lg3oktqk9bjmJAGw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606fdcde-7b37-445d-4fc5-08ded90abbf6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:26.1537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVSWUoryxhrUlu20bRlaDcRUk5VrcwuThqRsYFrQ0YDFwSa2WIZj2goCDF0u5+f3Pge8w+wpzSD9weOmxYPPhu9qbFcIgHJMd4O0F1/boKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11394
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX6RubJO6CQzxG
 6kdxwijuNOaxa/TICwXAyRPME2kszVeQvPgRsBqRWnHNrCS+/UUd7ZRuuB2dRJmnSG4mxgOdK3S
 AkvCaQJongfIb2DSNksbdygg29dIT5M=
X-Proofpoint-ORIG-GUID: p0qXKUij15bHAC-S61AggFxHHIz4fOb_
X-Proofpoint-GUID: p0qXKUij15bHAC-S61AggFxHHIz4fOb_
X-Authority-Analysis: v=2.4 cv=ftLsol4f c=1 sm=1 tr=0 ts=6a47bf4f cx=c_pps
 a=OsHIvx7z5txkqQhXuj38dg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX7iJI1U09jj8J
 kNTniibRtBsl1zQ7Z8dHOsoizswCA6UnoJbYkhPtfoNww+mbzbzZZXOkob2/XUXtrfZ/rQGa6R+
 1DaOTQWpPqXM1saI6afOW2HiHj+8enHg5wlHEFA+59VhGlo3YadWM461onMoOhDp5jiSMretsxU
 kpbNUNOGGhlqB+iN0oaYV+o4+Fdg7ux3WmYdlOtfuZK3agtdm1pxxw/+xjsqf0rwY2yq+jOTN0Q
 eIHzTRsdnbBoMrAuEq3akakHfumzL7UssROQgI+rLcMfWqGhds/sTS9lbb8DVC1/JDxWV6W89Mz
 92DCc1yFvRlWcgABs+BUvaFDyyxyPYyOC056fmUf3JiCZp051Cc4265s0iKJUE/9jCqtoxPhLqv
 azG4WrqOgp+NRUa1mu1HbGEW1oF2y4pTlPeyrLE4LeJDiuEaa/cGgkxN3khNcDE1cTwgPLLDgn1
 USPmdnP3ZRUYyTFsgDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This adds a class property that references a uint16_t within the object instance
and is intended to be a replacement for object_property_add_uint16_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h |  5 +++++
 qom/object.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index a55f9d0e97..a175505d40 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1982,6 +1982,11 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v,
                                     ObjectPropertyFlags flags);
 
+ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
+                                    const char *name,
+                                    ptrdiff_t v,
+                                    ObjectPropertyFlags flags);
+
 ObjectProperty *object_class_static_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint16_t *v,
diff --git a/qom/object.c b/qom/object.c
index 263c313cd2..52e47068ed 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2773,6 +2773,30 @@ static void property_class_set_uint8_ptr(Object *obj, Visitor *v,
     *field = value;
 }
 
+static void property_class_get_uint16_ptr(Object *obj, Visitor *v,
+                                          const char *name,
+                                          void *opaque, Error **errp)
+{
+    uint16_t value = *(uint16_t *)object_class_prop_ptr(obj,
+                                                        (ptrdiff_t)opaque);
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static void property_class_set_uint16_ptr(Object *obj, Visitor *v,
+                                          const char *name,
+                                          void *opaque, Error **errp)
+{
+    uint16_t *field = (uint16_t *)object_class_prop_ptr(obj,
+                                                        (ptrdiff_t)opaque);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
@@ -2854,6 +2878,26 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t v,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint16_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint16_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint16",
+                                     getter, setter, NULL, (void *)v);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint16_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


