Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8A9CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHipz-00040k-Er; Fri, 16 Oct 2026 10:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHioo-0002kc-2r
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiom-0006j2-A7
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:57 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5MK93333355; Fri, 16 Oct 2026 07:21:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rQp9h/2ajwF1qe/Mp8V/9gopdrz0ooiX8EYLWq59a
 vk=; b=BVZz4p1LerFy3PNcVvgEKNaK0AD0f/sJwbwBN0VGlptHvoB4A/PDV58bD
 w4Tsd/aPRMYJXc4hDGE2HStbESH5x2KsLd0W9/TERNPua+JbpHZYMbWFx6IoTt3P
 7wS1nuqCDQz4p83TgP/xRbMEKnBrQVtAtqBAX9PmiMuzX0VhUzdQimiDFQswL1P5
 lWnTPE45H28H3frpQejG4K+ZmzhI/CqMjO6qlTIHHTFvzZLRnBOOAnrvaNw5CGjE
 adUVX6fc86PvpHfDzEdyP1InzXvS4zJaBcpkreDtKXuACAD4oydhYNwrtdIVlkpS
 a/9b1t90S3fo0bJX+lAy/uV/3KdVA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020128.outbound.protection.outlook.com [52.101.61.128])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4haukukqe3-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikSKsOyH1KWIZzeqXeHlCrbU2BfiT1YDv+POEnD/SHm1ZWRoJCy7lttTvW11l+J0XTQ0NlaIOLZ2dcDB6aR7aPBbexXQF11zc7nu3x/dS3yb93QIpRSqG/kewXYogFM9dvEs4Y8yF4aNTuqbxgZY4jwxFf452CHcsfy2f2jpT6zwZC3THu9Lhyrfd8GR+bPoK5yDc54S/q3CBs/uekIaLNoxITFiPs73d1mMR8H7gWQAl6BibgVY4/rE9DhV4IJIhc4y7DGPUBYJ4wHPET2Pl4R0Yl1FUcbBCB1x4gTbShBvZ7EXgtxYmWOZwKIMdUS74Zr9wtjH8iIdf+nnT6NWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQp9h/2ajwF1qe/Mp8V/9gopdrz0ooiX8EYLWq59avk=;
 b=a9OeALpQDl5dmw3N4/VmoN9IVzLuQzfolX9lbSUmn16DgJ21jdUY0mcv6mqCrfUDjSRqwKG/ZrOtB6PiCFivwygWpzCdCaHgQCb/6uoyLGfOPWQX8X/BdE4GkXQ024N+SVaXbigN2K5Kv0+COD7IDVZoS81lpH1H+JkQWOR7hMW4MI95sDlJarsefMBR4+1iE92ElUcY/oDrxNDm15zN3VlT1KzR23bWqJ0le5nLLWvbaUCwRjHUz8jsnzNWNH1T3NNXzgiV2gGs5blPgoyVaPmFvAN7UjF4XX50hzZBaPmOCFfi1bB8HSOCrKp0WvSgDGOP3PSe23WyF/FhAIpazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQp9h/2ajwF1qe/Mp8V/9gopdrz0ooiX8EYLWq59avk=;
 b=VznEc69NPcS/hroBaq+pElWN5lkMo2kNZflUhgByi2Ah7wY+etfxV5XzacT6tHv9ph4RmhPz65uUprnWPYsYh9JieJA2HUsQiiSckhmhRPMYIZNy75DFlM/x33hm50YRgDrXZFg3GoN6Q8ELYdS5Br9pKwMtDnfRwAZ0OUy4N/8uSdK+mrgPChB8AWUgGc8YjqPsAvK3Yudi1jXYjs3nMm7V/oXXdOBnoBd8KvxDG9ECqf0AL3G49S466ioi5wg0invRRjKrwhvcfQfXT5Kl1lADRNp1yy7mXFvm6wYoka7dPE8WAeCWcqcaLZZH336zaRN3rOv1RKze1xracAcTFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6547.namprd02.prod.outlook.com (2603:10b6:208:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:18 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 10/27] kvm/i8259.c: always use cs for I8259CommonState
 variables
Date: Fri, 16 Oct 2026 15:19:16 +0100
Message-ID: <20261016142031.1204281-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb69322-591a-4a5c-8fa7-08df2b90be6a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: h3+4dWHUokHciwAntrMGHlrzYxoniCNtGJhojn1OP2KW1Y1bWdTKXx5ScDBQfLlhnso4wQIbawdCq8zKzvI5B7EDS1ApL5e3Z6pjIdU8fn3QLx63JTJmnhCMDKLYMHmWBxHVF6p2aKPutiQuZH9gF+IoLPHp6LoRM2QOwuZerBW9WKHoJ0yfLhGl+jOdZ3fPn7ZsH6xA1y0DSnUpPLbybD+bHSbbrlw4Y499yWko3SahJezoOu36hIYvqOr/qzTHgsbAU85aYuUG7UXKjckp6TT+fV8empH1Alqxql2uMJTBCvQ2LHAlw1phneTxNtA0/7fzMv3Iu2XUzSfdglst9f0XIaZy/0azTrZD5++HWnTV2+5i3EIxi5VklDc2DbX0qdEvqOgL2ocZlU9j303xYfuG+7zvzOKmYqLYgMbV8yI/fBC2EvA3DI2W9x/JnG+ZjZBEieV2XZWeYnqdUHpAkgbe9EPWQ5qE3ZhdSVCOloES3r/shhEayPRicOrsQ4HHTObkyQtqeLOQQyHZFXtii4ND+Vx3niTVkcxAENeFQKIkgku/Kx4LdTB2F27OP6R3VhkqxY6euHpsilobpj3YR1H0s7C8tBYgGDXo+ErjGFe6XbP/FNyzwlYYsBnnBWdmm4+S9HBxnYoAyvAx9UBa2pE/TxbpxVL0/69sIvF5wtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NNNscgb8dKtq3S0Poi1usa9G+LKHgzUj33tSC84e/0gIx96JRQMEMuqoOTAy?=
 =?us-ascii?Q?0GSWHh7cpdgQOcrfOaxTez2I61HSOtyhhGUvDQeQbabkkauBVMaI2fhZfoD0?=
 =?us-ascii?Q?koppSNPTDsYgmDZbgx07CG5DGMHWGCvTXmYzqL7gs5wr4zgLKKDbrPUMH1xK?=
 =?us-ascii?Q?G/iQzUNmsreYD5Pgf6EWtkbEEVqD76vGEQm4kLTCs3w2PS/ItqyCKLFad/ju?=
 =?us-ascii?Q?fTPM7pDOX07kD9/tvgq93EOdfzn6u2eP/PgHPvLzBx/z+XQbgjsUP+0cu8GK?=
 =?us-ascii?Q?myF+l25/TlzL2C0akRlVHKaLXpkp2LitRQ8P28iDTwRk2SjQqmBxMFNr6TDR?=
 =?us-ascii?Q?c7Jz6nmB9HTpe3447t6GdfRAZzGv5V2vsq+ot9z5eUln1Pv1OHmsZZg1bBA4?=
 =?us-ascii?Q?SoBwpv+pV6DbTH4Lh8o4cQpBSG8p7cM5Oc53wB41YxfrPFk5ZLnzDGF7orUl?=
 =?us-ascii?Q?lrFvecS8EONdhsexHa+h4QJEJq++lygrEvyRyhuOCqjCrkMAQC9+LO/4XyhF?=
 =?us-ascii?Q?joq+045BeFhI23zT6aUTOapGgADsIp+nsZtdCRQgFUOCGsgGM/siVRsSnjkD?=
 =?us-ascii?Q?QuyEjG6fsENH+rCnl2jCMA42jQJCMXerDb00/C83MFtSpsGPHapiMWCKlw7e?=
 =?us-ascii?Q?t9sPdW3TpurhrtQTiY9xT8UjngjMVYbOw988DFjL4UvDJezZMNJjxixud+x8?=
 =?us-ascii?Q?f/0k2LGdn0xlEAmQlUo5CEX4qLtPtRyheM0V1XvxQDe07jX/04y2om0ajMzW?=
 =?us-ascii?Q?5cDuVcvQ1CNYlR0FJY2EHEELsJC+YJvEbTXE6/kLd2rYLVL7VuE8aP3oCebG?=
 =?us-ascii?Q?G1JAVcKMjzEzfc/RaJxPY5EfG/hUpXfwjpRzP5qJAsrp2LdkobUiF9X2dRtg?=
 =?us-ascii?Q?8VMf7zJO38zMFHyttEmXiL3kOtLwjOkOn3Lk0tMo8hN0EqlFj2lngvYVZfwx?=
 =?us-ascii?Q?fQOQ/Vd/Ivkx0swFKWaog6L7x85qvZbSm9RCunpsgM0y0mgP2OyGrZFOTNJy?=
 =?us-ascii?Q?egfyN2DFjWWnZU+pgn6GMk89271+I5eYuvKse3khL331JnEutdmOacPLjN7o?=
 =?us-ascii?Q?64vRGHeUnFxSd2fxXVAFT8BG33mjVNmryWFO3HvzMTDkFcjbeMjZ8VaNQiSg?=
 =?us-ascii?Q?mudWJ89Ps43XIWhbxxmaJT75V1GFcTCgssKST4uFdEd/upFm3aOAbTvpTG/g?=
 =?us-ascii?Q?eV+CCQ5u0j/R+9qi5U8xGvrCFDu31c8aPcwsiOims3xvfBF15yxmwOUsy6i5?=
 =?us-ascii?Q?FnoOvrwPosQjHB7vN3C5S6fu3PvhAtkATFtBmDDiS4N6Z2jQfvLOfbAqCMU1?=
 =?us-ascii?Q?x5UnN4JBXAi6BQINCXuPCGEYwU8G7/AzD45JfaaomOpCT5p2edcffJ1NFYgi?=
 =?us-ascii?Q?x1cWxz7Brpz9QZA44tdMwuQrx3ucSlzffOualulyvfLwYRsZ/PfrHqHXW+hT?=
 =?us-ascii?Q?sRCuoTED63bjcshY+eF7Kwi9+vzpQeIcl7wuAd/ndsCprrFA6Sr5KPxTwh25?=
 =?us-ascii?Q?IlSR5TLkcTp+y47J4EuawqpCzhHH909oCLyT9A8lTkfytkLq1syTT76SiZx/?=
 =?us-ascii?Q?25+tZO3x36xEd3kpP2qWDvvp8ThNn130By5WnsK6TvkBOuquDsMowa4TaU9Q?=
 =?us-ascii?Q?TwV9Op0Zl+Mf4hPyL8kVNdsv+yyTb37tGwO52F0wWEhVK6t2vnE4ZTQVPF73?=
 =?us-ascii?Q?d2t/6GMcc0qZ0NSfThgdyc+QlJnLYBp7+F4QUbvVkuY4dCr+g7iXvq4BA3dz?=
 =?us-ascii?Q?+pBVJ0R5rlEDJggfOSld+PS5FuRKAUM=3D?=
X-Exchange-RoutingPolicyChecked: EOo56rIx5CTJC554u9DZf3LHzx3+epWkAPMfAn0AI4l4meQchYxu5+xkMC1dcBoHsk4/qLO9Hp/w5/K82Ds2EmTUOAN78SZROVskZP9I8eCHmRpaSCRsghZmyU2BCUwQ2Fl1FxW69Eu1Am9SwHdctCwyW62qoUGufQ+K3NbeIac3ZYlD3r6yu72xQDT+7PSkVwZU/XtYkesrnm1RsCObalDk15mRuSXkMtNH9eS0lhtQFfmcbhdNyCRRnxN0MJB8wfHxIYGZnuWusAq262qCrTXZvfLq4dK3vpcCoQ3oBMfiUuKRr/sZcUHKSdSz0Oe8TLnKqx7o/C5ETbOkkx8W6Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb69322-591a-4a5c-8fa7-08df2b90be6a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:18.3323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CPyAiDUUj3XGCyDLiAftW8srhRxKFch2lhjINPQOssQd/1Ygqgp9Va3R4o9gqH42zrmSlmHAhHxi3GKPY0fCx08w+ZnvWbC+qBK1M9ERNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6547
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX40ymsmU7s2WA
 AXr0jAkO/bJYaRKBZ7lluad81MvyyinZ6fRX5cdoQCubrtk9wnKx1CAyiuo1Sm94yk+EMPalN9A
 Evzao9IbwFiNEe7Sam1ykxV97zdhp2Q=
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ad232f8 cx=c_pps
 a=8h7WK4dQWB09CNKj11a7yw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=zNa_6NNZsa7Vo5epgMYA:9
X-Proofpoint-GUID: 8JBZLFG7-_g7VBHSOCD5LHGfV5f6xg-5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX2hpyj0/o1IvH
 /0qzXsZN3qzZXIHhrPEUxfUHiefDS6Jz+cht86Au2RBZOtGpy7FKSeiaMkf5UGJJSBaW5aUzIhh
 zi5zZyD7jb+xyIn0EMFhSMdjh0L9nv2svTvofqG9okxJoCgXEIJss2lsWsxrUmedrzAN/8zCyZL
 fBpjpajLDjy+7KwSxfBbP9NG+6KbgwxM4JSidG2Z6arqG/R81cEC6FgQcSgAPOQl9a9EcnMI5v+
 sKCv2A/JZF3Iu3KrBebyi+oNxTq8FjBbAGw8y8WIREWUroRPFthSlEBg5k15g6d9UgkEth9aAcG
 9HRxHEzCI82COMWn+Lv6YmuZqj4Bbjx05s0a/mMBUgnY19nq8jQBOQn/0JS78wwbU6SpSSCIgvg
 1jgZqwObweX6JbSSsEVIkOEFTQPoSyqzTUFHBRgBmV838BtKWSkoNidy2tughzYxIPRAvevW0BX
 4OSAmtGIhP26mBsIFyw==
X-Proofpoint-ORIG-GUID: 8JBZLFG7-_g7VBHSOCD5LHGfV5f6xg-5
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

The use of consistent variable names makes it much easier to follow which
fields are being accessed from I8259CommonState.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 86 ++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 8ae5dd39b5..86b1ffea4e 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -36,13 +36,13 @@ struct KVMI8259Class {
     DeviceRealize parent_realize;
 };
 
-static void kvm_pic_get(I8259CommonState *s)
+static void kvm_pic_get(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
     int ret;
 
-    chip.chip_id = s->master ? KVM_IRQCHIP_PIC_MASTER : KVM_IRQCHIP_PIC_SLAVE;
+    chip.chip_id = cs->master ? KVM_IRQCHIP_PIC_MASTER : KVM_IRQCHIP_PIC_SLAVE;
     ret = kvm_vm_ioctl(kvm_state, KVM_GET_IRQCHIP, &chip);
     if (ret < 0) {
         fprintf(stderr, "KVM_GET_IRQCHIP failed: %s\n", strerror(-ret));
@@ -51,50 +51,50 @@ static void kvm_pic_get(I8259CommonState *s)
 
     kpic = &chip.chip.pic;
 
-    s->last_irr = kpic->last_irr;
-    s->irr = kpic->irr;
-    s->imr = kpic->imr;
-    s->isr = kpic->isr;
-    s->priority_add = kpic->priority_add;
-    s->irq_base = kpic->irq_base;
-    s->read_reg_select = kpic->read_reg_select;
-    s->poll = kpic->poll;
-    s->special_mask = kpic->special_mask;
-    s->init_state = kpic->init_state;
-    s->auto_eoi = kpic->auto_eoi;
-    s->rotate_on_auto_eoi = kpic->rotate_on_auto_eoi;
-    s->special_fully_nested_mode = kpic->special_fully_nested_mode;
-    s->init4 = kpic->init4;
-    s->elcr = kpic->elcr;
-    s->elcr_mask = kpic->elcr_mask;
+    cs->last_irr = kpic->last_irr;
+    cs->irr = kpic->irr;
+    cs->imr = kpic->imr;
+    cs->isr = kpic->isr;
+    cs->priority_add = kpic->priority_add;
+    cs->irq_base = kpic->irq_base;
+    cs->read_reg_select = kpic->read_reg_select;
+    cs->poll = kpic->poll;
+    cs->special_mask = kpic->special_mask;
+    cs->init_state = kpic->init_state;
+    cs->auto_eoi = kpic->auto_eoi;
+    cs->rotate_on_auto_eoi = kpic->rotate_on_auto_eoi;
+    cs->special_fully_nested_mode = kpic->special_fully_nested_mode;
+    cs->init4 = kpic->init4;
+    cs->elcr = kpic->elcr;
+    cs->elcr_mask = kpic->elcr_mask;
 }
 
-static void kvm_pic_put(I8259CommonState *s)
+static void kvm_pic_put(I8259CommonState *cs)
 {
     struct kvm_irqchip chip;
     struct kvm_pic_state *kpic;
     int ret;
 
-    chip.chip_id = s->master ? KVM_IRQCHIP_PIC_MASTER : KVM_IRQCHIP_PIC_SLAVE;
+    chip.chip_id = cs->master ? KVM_IRQCHIP_PIC_MASTER : KVM_IRQCHIP_PIC_SLAVE;
 
     kpic = &chip.chip.pic;
 
-    kpic->last_irr = s->last_irr;
-    kpic->irr = s->irr;
-    kpic->imr = s->imr;
-    kpic->isr = s->isr;
-    kpic->priority_add = s->priority_add;
-    kpic->irq_base = s->irq_base;
-    kpic->read_reg_select = s->read_reg_select;
-    kpic->poll = s->poll;
-    kpic->special_mask = s->special_mask;
-    kpic->init_state = s->init_state;
-    kpic->auto_eoi = s->auto_eoi;
-    kpic->rotate_on_auto_eoi = s->rotate_on_auto_eoi;
-    kpic->special_fully_nested_mode = s->special_fully_nested_mode;
-    kpic->init4 = s->init4;
-    kpic->elcr = s->elcr;
-    kpic->elcr_mask = s->elcr_mask;
+    kpic->last_irr = cs->last_irr;
+    kpic->irr = cs->irr;
+    kpic->imr = cs->imr;
+    kpic->isr = cs->isr;
+    kpic->priority_add = cs->priority_add;
+    kpic->irq_base = cs->irq_base;
+    kpic->read_reg_select = cs->read_reg_select;
+    kpic->poll = cs->poll;
+    kpic->special_mask = cs->special_mask;
+    kpic->init_state = cs->init_state;
+    kpic->auto_eoi = cs->auto_eoi;
+    kpic->rotate_on_auto_eoi = cs->rotate_on_auto_eoi;
+    kpic->special_fully_nested_mode = cs->special_fully_nested_mode;
+    kpic->init4 = cs->init4;
+    kpic->elcr = cs->elcr;
+    kpic->elcr_mask = cs->elcr_mask;
 
     ret = kvm_vm_ioctl(kvm_state, KVM_SET_IRQCHIP, &chip);
     if (ret < 0) {
@@ -105,12 +105,12 @@ static void kvm_pic_put(I8259CommonState *s)
 
 static void kvm_pic_reset(DeviceState *dev)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
 
-    s->elcr = 0;
-    pic_reset_common(s);
+    cs->elcr = 0;
+    pic_reset_common(cs);
 
-    kvm_pic_put(s);
+    kvm_pic_put(cs);
 }
 
 static void kvm_pic_set_irq(void *opaque, int irq, int level)
@@ -124,11 +124,11 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
-    I8259CommonState *s = I8259_COMMON(dev);
+    I8259CommonState *cs = I8259_COMMON(dev);
     KVMI8259Class *kpc = KVM_I8259_GET_CLASS(dev);
 
-    memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
-    memory_region_init_io(&s->elcr_io, OBJECT(dev), NULL, NULL, "kvm-elcr", 1);
+    memory_region_init_io(&cs->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
+    memory_region_init_io(&cs->elcr_io, OBJECT(dev), NULL, NULL, "kvm-elcr", 1);
 
     kpc->parent_realize(dev, errp);
 }
-- 
2.43.0


