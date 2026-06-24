Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5052ECDE001
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPbm-0006LL-9A; Wed, 24 Jun 2026 11:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wcPbi-0006Kk-SR; Wed, 24 Jun 2026 11:33:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wcPbh-0005zK-4V; Wed, 24 Jun 2026 11:33:42 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEfdTO3352932; Wed, 24 Jun 2026 08:33:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=HBrIrn5Ptaedf6Bauy8qIxuwUEFpibOxQqmXQRXrz
 8c=; b=xD34EvvFhXCQRg7s2h+VgDOi3zdo1rfwGi0PGG9iGPl+80UcL5ehWvqJN
 YreXuoWsgg7AtTTmRoC9XWisAm2IlLzabOs3D4m1ykU7rHGt+vhTGNT/csO3d95V
 1bCssgMCtC/ykK09Zhf6e1dfybcBlKmOHbVlbnaSvzVr8/KAs7DkQD8iuE4zp8yR
 RxFWtzvcAnJ+mxo7M600Ygc6e/z7Hog/iqfjxJy/cIcpRd3oPWAe3zIpIKxa97fz
 YeAWFvamNbHS49TxF1Iy3rp0JjjHUQoIwJEPQBdRp/zs4HV1y2mSGfLM/SN8Qppg
 VKdYzZnJOu+IwD70shH5L4Unb1/lw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021098.outbound.protection.outlook.com [40.107.208.98])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f00gx2cab-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 08:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJiS7PbcEi/p1dspdRQQRczlw4LqqyZl/9HVBIB7TLErn7j64lWV1CLhh2XlrCiuacZWnRm0JIHaWwQGLRXl51iRoHo+3xmvyq8eMTA8fme4Xuf1lQAI/3RzOOHD0iNKP1IzsXoSUXZa/cY4SJ7x5A+tfuFHJFiiIw5gwIjLCl8KoiCBrD78S5ct7576MGFBKQK4iVvh+440VP0AdHLARmVqoazAkrONcKlHeNht1U/erL+WrcTX8vi/h41I6csEbESprOaDz7nq963W+2jx7H1MuFGmQsxwldJde42mnVJQs+JGlUlo+qjfxFz5g/iI57Vm4Gj8pEGduzfZfUfLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBrIrn5Ptaedf6Bauy8qIxuwUEFpibOxQqmXQRXrz8c=;
 b=GcE8AqoQ1q0uHjC2mdZlJDKPoyyZhZpWpmQLdprDEpMn/KiIIlUjFK0bftPVDVFl/yOLkw2oFu6A1ezgziVd3uGkTgMg5iicGOy3BYXi1cBtK0UVj6qmLdTcnY2ESR5lBnQjMc8uI7Bvx44VxdasUb01KCKrB9/he4hJssduX2exIScm4E1DlB5t/BWQiOvcfXn7RvvjxemVyo0iZU1aKDF3Cv6Y851RtVZw15Oomjy//20IeE0F/EvXZ4ptvH0zA9aE8D676MhSOv6HKYBXsYeRkQdkLASpEhWS8BAVVJc3pgPM73H7xWjFsChtrPIcxLkyFpaOF9EHst6iYoPO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBrIrn5Ptaedf6Bauy8qIxuwUEFpibOxQqmXQRXrz8c=;
 b=cqBSNNOD6Wzo4AoBb4zOricl5UnIljGo9xVrt9artW4YpTxc+hWrlRrkS2XDFlrn52HHS5m+B3j3R1jZ+eIH8lPGj+Oe86vjOKBvbcxtbUlHVjkVrx88YUjUlcgpxtpNxyZBPh0iWGs/JR+KD2hobXK5D+yOH9E6+74GBS3RNwt3tbAd/NDdf+2IzEPB7ED8k8wzslY5YrFcbILf0nZMshE6e8gLE2ZUa9kbX1MqQ15jdXUMEndf+p2r/YedbyhZFwXumreZ+bHZousul1/NFcL2+T8sciBPp3AdiNmveoRZPWKsSge00fueISwZ7x1uHswCCIuxh0hvediBla5lYA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB10474.namprd02.prod.outlook.com (2603:10b6:303:284::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 15:33:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0159.015; Wed, 24 Jun 2026
 15:33:32 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: alistair@alistair23.me, peter.maydell@linaro.org, kfting@nuvoton.com,
 wuhaotsh@google.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object props to
 class props
Date: Wed, 24 Jun 2026 16:32:30 +0100
Message-ID: <20260624153322.1470576-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624153322.1470576-1-mark.caveayland@nutanix.com>
References: <20260624153322.1470576-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:32b::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB10474:EE_
X-MS-Office365-Filtering-Correlation-Id: 857c621c-8d95-4c8b-6da6-08ded205f29a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: S5BoOlPqzAyvHu+tCdYO2O4ejihMIb4FXxC3pZeVwzvTl/fLbtFRLFNEvywf1HU3VDHni+rulaNPlDvH7Jjt1vPjFqbq+khrpF2+7n7Pp6PBHhtojJQEz4D82typqsZT172JtYiPGkuzUE3EVeJbxSmnXt8yv2Ken0fxo/cqYvSAaYd4iVcnvrt091p63yVIDfFmFYS+7Elm+TNR9nHCOdrXmTfycbX7kZrXcSFrQV9eA12ENVSm1vZDaXXlzUhcQpr9PKX8fmjokkagUmiSN5Jxr57xvA8BDTwodm32//4ytVBPIQDcOJjR2EYAj2+O5+DvrejEdGDyjxWKJU5eZcxng8pd8wcEr6Uaaw3Oz7BASEs9rPzYXdO2j/6bT/2w1S0RWOGwXtO7RERtc3qLrLc+BsdHb/YNt9emdCXHX9jspldnhh48DN2BEmVGtMuc/EaAwVPjVuSU5LDAt0TpyoF+gyjujkJdYDHUa29wKjIQkw+tgypOzpFOpkOBC8EDAchLLftqKVn9MryYd7d5xXXft6MQx8SQGwNscmc6Bj5AJcdVUJnINIYMIhJMfZq4oA5yxbaykJPwXs43N+qgDQeohvQF3wYn3AnU1AIOQvqr0WBSuparCPceMW6Bvxl9bAImoYG+x3jm9wgSjPZWznYQD8SYeJEEVyY2v/MLVxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PHoK8V+LG/oB00DfXVIrHLC1SL+TdCx8udnQ+nIMAZAIGL+H+515qB+DVbII?=
 =?us-ascii?Q?ozDnAepLd75hbGvuxdFITq/ZCj4mwDKR1jhtEU1iqw7JYhf9oPoWFTOI5xIM?=
 =?us-ascii?Q?KW3GRWJu41xGHSf5w8ReWa3Srwl6v4o2h6ObPGTc/kKbIDyu+QCgxgdjJplG?=
 =?us-ascii?Q?FkLERFrDBLqHSPJAiOV7v9mQdYMzg+mjOxnbdAFa1nOOtR4lLpsPaO6gJyz4?=
 =?us-ascii?Q?yTOpXWG/ORyvYXRE6cyfNtZKURWfsbc5Z/tvSU1UG+d+bIBU47vb6uqXv0uW?=
 =?us-ascii?Q?/jBQ3Xro8xyXnAnKQ4BNjlk86X5A1zJHgVP7d6RAr5icSCdIFL41/nZPDxBo?=
 =?us-ascii?Q?H34HEwVHZmND/FsYccJOtOgh608A0litxJZkUtS7eYesIu9bZSr+tvwhsfC8?=
 =?us-ascii?Q?WRKdP2FJKkYZ/sZS1FFG//SMAfHuSMXGw7f26UjPEAfTWFO5LEEoP2zRGAV4?=
 =?us-ascii?Q?S9pOnavZNTDXcbgpDGaRFsXLX0kfN4mlqxzgnn4x0hR7IJR/uSYV+s78kHA9?=
 =?us-ascii?Q?er5v/Yqnq45Fn995pT7zi4WujX5PoKABIiGWudzqXwYGZBg4POrwpMalHk8e?=
 =?us-ascii?Q?iQs2M2Ez+SF5D/IXDaOQYs/+Ox45/KxMT3sfRafOp4NPN0y9tfZEw/zNU0uk?=
 =?us-ascii?Q?kTU/dyCf5dIeBDZalNiNMkDgx++NnBhV3nq98NERkdEb+dgwzUrwOeVRhRi6?=
 =?us-ascii?Q?VwcHqSglTnAYNWR8giwb7g8P8rDGuKUbLHbN3gyfhN8RTR/NcqxcHcLktbun?=
 =?us-ascii?Q?nxUxESlu8Wc3OvI3yZ59otKWPqbxM3Df2THc0bb2jL8CJlfN9FsQxfErVYwm?=
 =?us-ascii?Q?q+X33q/vQPyXrivnIk09DByEOrlu73Lsq01+3N8W0FT5cEt7vkaNxnrQ7XSg?=
 =?us-ascii?Q?c/oBt59wVjjkrUYqlSqLEzGVjtihu4ZdMLI7sLRoc5m4jj7pvN58q1PzQnPM?=
 =?us-ascii?Q?36l5eAt3xl9VFZz3KJJfKKtbKa5a7cVBjekr4r3tbnZ18O0Fwh9cGJiddvEz?=
 =?us-ascii?Q?9b+YRS/KHk4LyvyNWBNDp4pnB7BLv43qCqpiIzybGTJAFJFQFqoTXMnzLmwl?=
 =?us-ascii?Q?p1j9V3azqPz84WEV74m3hnRHDm/3lmeGi9Fal+vuuActWJ/vcmZEXKo3aslc?=
 =?us-ascii?Q?Qm9CrXLJw+ZUQttk1GahQxoUz5cD3w7m7/BjTl1gPHMmC6bjznRKa7pY+hEI?=
 =?us-ascii?Q?vFxQlRiInsG3TBnbIRxPvTomyxXcJH3LIO6cBc+RbHTDbo4KdemzE1xO1CSc?=
 =?us-ascii?Q?BYTbZlSxk6uFzf0t1eMl45BFNDpXk0OvKN8veJQBRXjmU8LXI4ytW3oVKoP2?=
 =?us-ascii?Q?u+VtBOr8r8oWQYnjyBkNBuKw82czplKGZNXr/f7hfw7nuGLFg3tmj7w/qm+K?=
 =?us-ascii?Q?RxEHVqSre9jyjLptOmgXSf3Tdc3b5+XdBmnyJKDQlVaUoU2wanzSF5UihYIu?=
 =?us-ascii?Q?0so8XwhhbGDhnXxAcHahJZmDvF4KfCXWh8tBcRW5litB0TSHlxZ1r1idVTLp?=
 =?us-ascii?Q?bwnWKD25DdVvbOJD5uqd7W0FYD3KWP0KEPWr8C0tGkfVInkcx1VuyHzK0H47?=
 =?us-ascii?Q?oK1FoBuyxWPRF1wnwzlq8qrxD4cfOy3JJ/lQtuyYCz2ixcocaDkL0r02yjbE?=
 =?us-ascii?Q?ANIuNcoci/IZIQfbMGrtv0ahLSfC4CdW8k+mlDUQsw0yC1X7QyEL2jwcgh8M?=
 =?us-ascii?Q?whUB7M7QnqOM1k1zff4nxHSPx78statYhc47l4AvRdTLc3QYfCI1Cnk94n/u?=
 =?us-ascii?Q?PHYDr9L8kW9IU4tHO24HYRhgYkSbV4s=3D?=
X-Exchange-RoutingPolicyChecked: iCz2l2Khq5FkeixLX4mYw6rmjoSmtqvGcxCsYOgcK2CbrvvnyoQvQtsCCwAJMr7rhh1/Erf6GUFJ1DZfRG/e/sNRzU/GS4/gdsB837N1694DwHn6WuNdxlAQlSR5Z7ESiSsgOwSbH3PVWG4BvsSNS3RvNoYUz9reOUdrCcCH0D4R2y6Tqf7Sv5HL5YUwZxog9ua94ti/wMvEPKjDZLbrcH1X0U+uMBKFSkjofYagV5bfGhnvfcoDnDljw9AMbXG5eb+0byBejh1SK57Dyx9LzrzMChcdMwc9S/0ZH4Wi1OBj8VpAPGEwoQN2qNAMIZ3c5zKkcG29U4fofXwkQbnIcg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857c621c-8d95-4c8b-6da6-08ded205f29a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:33:32.2233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHBT+q58z5DpzaQV34igb4Awpmo/DU4iEvnzm9EN6EAM6IlMJaC1HKWJi3srGEZs3i1HCVoDee4ZGWSELFJ1FbUZF4GqdwYvJw0RdPaPuM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10474
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEzMCBTYWx0ZWRfX7qD2aR/o9Dc7
 z6OCd3mSSqx/hNjxAGPIgGdpJ6svuzGgTFmT1+brjWcszHTmp3SQzQ3d9eMQvmBtOsM+BLSTfVQ
 T9DTDi07CC0upnsApoao5f8VFT3//rM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEzMCBTYWx0ZWRfX1FI+2Pwzke9G
 WE8cwmdN5MONa+Q2CiF1kGL8zfyc4NsqQuXusetOD/rLKjOzPknh42N+llr5sviUFKHpWeqTpNY
 vJA70OIuohJhCsmh9hqrv69ibTdUtW41MxPSKbo9QX1C2p6yiheptCOUnhAXc8kiExMdXO7c0Vn
 JTDisQTYeSfYbmLLam9WM2qsBlhAmQS/bovjel3G+8ZPslChyVxBXBiHSZopQwndJIj+adKxwun
 X6guWTpqwa2s1XKix20JnU3x8EEo9Ong1zprEIsRKtxtEYZklFCox00ECEPsyCwq07hHUY8wnVS
 xh8fCWjE5ff+/v63iHI0CI8Dt7emE9ao6FmbAxcCvcE9eQdlUOi26TCeWo2U4D3A57ps2Nel6yQ
 rgVos7+yVJqRImejeEhXdmnSjfHg3VeKxpvOGCVcaq8Z4Fhh+W5sX35mdXzL7h9L6UEYcvFKeAR
 G85gdpONIIA/u0cTPvQ==
X-Proofpoint-ORIG-GUID: cFNY5l4SK9u109XV3G0goLDKFhQl1Z3p
X-Authority-Analysis: v=2.4 cv=EMQ2FVZC c=1 sm=1 tr=0 ts=6a3bf8ce cx=c_pps
 a=E8OgLIcutAPxqg9pSkKNiA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=S-_rI3sWpzOQp-ENfYcA:9
X-Proofpoint-GUID: cFNY5l4SK9u109XV3G0goLDKFhQl1Z3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/adc/npcm7xx_adc.c | 75 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 7 deletions(-)

diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index 3584c27c75..accaaf2620 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -20,6 +20,8 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
@@ -229,7 +231,6 @@ static void npcm7xx_adc_init(Object *obj)
 {
     NPCM7xxADCState *s = NPCM7XX_ADC(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    int i;
 
     sysbus_init_irq(sbd, &s->irq);
 
@@ -240,15 +241,63 @@ static void npcm7xx_adc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
     s->clock = qdev_init_clock_in(DEVICE(s), "clock", NULL, NULL, 0);
 
-    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
-        object_property_add_uint32_ptr(obj, "adci[*]",
-                &s->adci[i], OBJ_PROP_FLAG_READWRITE);
-    }
-    object_property_add_uint32_ptr(obj, "vref",
-            &s->vref, OBJ_PROP_FLAG_WRITE);
     npcm7xx_adc_calibrate(s);
 }
 
+static void npcm7xx_adc_get_input(Object *obj, Visitor *v,
+                                  const char *name, void *opaque,
+                                  Error **errp)
+{
+    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
+    uint32_t idx, val;
+    int res;
+
+    res = sscanf(name, "adci[%u]", &idx);
+    if (res == EOF || res != 1) {
+        error_setg(errp, "unable to parse index from %s", name);
+        return;
+    }
+
+    val = s->adci[idx];
+    visit_type_uint32(v, name, &val, errp);
+}
+
+static void npcm7xx_adc_set_input(Object *obj, Visitor *v,
+                                  const char *name, void *opaque,
+                                  Error **errp)
+{
+    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
+    uint32_t idx, val;
+    int res;
+
+    res = sscanf(name, "adci[%u]", &idx);
+    if (res == EOF || res != 1) {
+        error_setg(errp, "unable to parse index from %s", name);
+        return;
+    }
+
+    val = s->adci[idx];
+    if (!visit_type_uint32(v, name, &val, errp)) {
+        return;
+    }
+
+    s->adci[idx] = val;
+}
+
+static void npcm7xx_adc_set_vref(Object *obj, Visitor *v,
+                                 const char *name, void *opaque,
+                                 Error **errp)
+{
+    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
+    uint32_t vref = s->vref;
+
+    if (!visit_type_uint32(v, name, &vref, errp)) {
+        return;
+    }
+
+    s->vref = vref;
+}
+
 static const VMStateDescription vmstate_npcm7xx_adc = {
     .name = "npcm7xx-adc",
     .version_id = 0,
@@ -275,6 +324,7 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    int i;
 
     dc->desc = "NPCM7xx ADC Module";
     dc->vmsd = &vmstate_npcm7xx_adc;
@@ -282,6 +332,17 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
     rc->phases.hold = npcm7xx_adc_hold_reset;
 
     device_class_set_props(dc, npcm7xx_timer_properties);
+
+    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
+        object_class_property_add(klass, "adci[*]", "uint32",
+                                  npcm7xx_adc_get_input,
+                                  npcm7xx_adc_set_input,
+                                  NULL, NULL);
+    }
+    object_class_property_add(klass, "vref", "uint32",
+                              NULL,
+                              npcm7xx_adc_set_vref,
+                              NULL, NULL);
 }
 
 static const TypeInfo npcm7xx_adc_info = {
-- 
2.43.0


