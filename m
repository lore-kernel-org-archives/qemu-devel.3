Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3AECCF2E4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8y-00020k-Nk; Mon, 19 Oct 2026 08:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8e-0001US-6F
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8c-0004C6-IR
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:47 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Om2S1634634; Mon, 19 Oct 2026 05:06:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=WyA/oexDigpjp1MqIVZSX3oyJADfec6ddFmZwK/KF
 s4=; b=mycBKSmnXP56E8nOzCpZHEoXtJ0UP98j1TqbUJ5zeHkGOkJ58dWLu0nre
 3J5Le4YItZVsS27HFICFMvZJ7fN8obtkTRCfhNgI0S2A1FRj2NZ7+GZxBI2OiMlq
 1eDnKd7OVshtyJAZQ3N3ve78C3D6UK2DUVewraVCazjCz8xHDUp4U7OksHk35+d6
 1cwY5iQMSPQDq/SQZJi1utEN1geywzvaT2cYdFzdGHk+xlRYu15J1V96YcAPrphv
 lXIvz0Om+3a00IOg9wXV6VeLyyPpZa/ruxp9IEplv0v5P/tjBV6QvE/HqLm+XaEk
 8MLeT5+n8ura0ToMfoFI3VH/q43nQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021114.outbound.protection.outlook.com [52.101.52.114])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc8bckgca-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMgyNCUcUYf2OVlyKzYGszOKvHn88PYi/fvrR2cgAAih5Dcg2+Gg66IanO60FgjGnBbNK/8sTM1NzM/dg3p6YvmaGIOALN4ZsqeLBZ8zkQmL5n6JmBDUBrGk4kmJmuvCsWALJkswtK+4T3jihZaMTl8Bwt5i9ANkHEZdyIp4uEMihOENTE+xoG/T61rNVX06haitx6rCjSsF6Ivrn5UJVCLhYreuoQ7hEpsWXSExrJ+PP55NL6+kw4syoD62kyeNNWcPdRSrctWSxh+fNphEtPyP3azIqiV18ObdLUSR5ag9QP2tTEgjYXxojObbK0CC+PMyssg+WGnnlUnE0/Qqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyA/oexDigpjp1MqIVZSX3oyJADfec6ddFmZwK/KFs4=;
 b=e7G52uuha3zPYSwdkkVTR2EWVMbYHI0LffcGz8pWu8kYfIIVc3XNxAZNT5Mk7e0aXXZ4DpUuMS0n7vLdisk0+nd67L5HtBNDlU6wia+t72t5oSqmR6wO5ABOW6+dpYJs7lWSPVLy1tXVmFrkrmRutcqLCxljCwYcAtLybId6n1E7MfKwqqym0fCgGMGpGm6VcdIY7k+PwqH7Tecf4k4TvcJtuq3QPokuGvvXabzW2Punk+swatv4T8a1gdWznOlktKyvKIvYjvNQb9Ygl0HDLCAj7vKY480/GJJ9Y5ABZUbxl7o6TZzn5//vjbeV0O4EO6rgTKj8c+zdAdNwA2sRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyA/oexDigpjp1MqIVZSX3oyJADfec6ddFmZwK/KFs4=;
 b=YW7XUx3ylt530mxcN+FNS2uBiqTm0kuOS3CsJOm0cQ0v04TpKyJuUSUbq2Anyv8ZO9lXFWZce9mIfctSvh8RFUrnQ7rSwmPhRY3cPAFuoEC7JhOaz9CPpfJFMQtdMaJChHe8Cu0XPuBsSt39u9DW003JG+E0avdy1X1v+N0Q/vSAUvlFGqNKeua4IagiUmop9KCrWsxU7jiIpRTrh7QeDmCXT1bnLI/QdS8KfE8jXj+G1dr9/V6Q/rFPgbFWyts2WZhoqS8VSKkfJ/F/uH4HyzTRWWjkZ4kyMMnHW6qy0XOzjwt4td+AVPxd2yLNMKwhBmU/GauetLEuYTfcKnhW7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 24/28] i8259_common.c: remove unused i8259_init_chip()
 function
Date: Mon, 19 Oct 2026 13:04:56 +0100
Message-ID: <20261019120517.1448687-25-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6fde36-aba7-4327-37c2-08df2dd96e11
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2xy2Jq3EA33hKKwi8YxuPCp+EfPnVXH2cWqc9ItYvQ6ZZIKfT6cyw4X/SlaKw9otmIx1d6K5Ji2EBi+9vvO0C+R/a/dl1gRuuFKN9Hoq/z8DJu2MEjjuT1xfLvKJYv/5JecKjQ4vKzy6rHEY4uk6XuH7pcxe5yD8TmrJ5DGlxqv7sDkyFu1c7EwUQjvoCdgBZ+pxFHwAh1AnWLwGSyv7GRRrnzTTlUHDS2nETXdaPMwuHvDgBP/3lAIUwt393jhU5rkmlvb+H17jffbAE4/SfXwTIDO5wgTpG29S/uiEcadmEIO+W1zghB3G7Q+FFQLNZ1Ty8mar+m6VZfDL+2lztOo80ArBQpdOKR3qbKn0yz+oihNrQTn7qTFJZZJZTWD7oDrkoGBzO+W73vTKuE+0D6IgLedd67ka/0zQVtQP1Qnj9NhrYqv+cN2qQcjNTGZ2nrccHoVNu+457XNepUflJcQO25jSlAZ45wjnv4tCE7K4vQvgKuHGLpF/XipMRoOKIwmcSaqk6ZskFC9mK4VIAU04cIEBIbk7QuTsAZQ5FGzs/0xkpTKfBGKpIlOtzelTk6v7h+XmxzSwzTDdWw/xhcIokb+YehkNlT1OoMvUGIntYD6eDg/TPpuzS/MCUXPjJ3oizMsTDbjpugvByt35V3BUZzYRF4oRjd3uaZxiEqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dKHweXxhBkbNK1bVEOe5MXQEx8CV3uLkfpINCIQDeERBxQkZI4SiXbjuG/Mc?=
 =?us-ascii?Q?nIY1GzwNqCl2Z+a43wxIGUn1uaPFLVj6BUgDxV5e+3PknIpG5zSouXW4A3x1?=
 =?us-ascii?Q?h3DuOwMMSo4WKOCopsn5m6lQOnbJUoJzYhn6wmA2bGdXrfmQApvfA/Am6Vvl?=
 =?us-ascii?Q?GE/2cfeKHhw69qcb2CpyzaYnNDCNs75+g39esWuyGFU77hSzxNLGDq0C1ppB?=
 =?us-ascii?Q?T9x+QMDTcKpHIWRxqlB+++UuuyylD4wFOzUiJqpGYDtsV0yRgh+eb4nj/z0F?=
 =?us-ascii?Q?dtsmB8QGUFjUFhP1QLF/zihJkLY/xavVHJxp9ay/ZSo8s7OYCbXOO/JwTDgs?=
 =?us-ascii?Q?84uUt9cWENOd9b0ird52rSSpRMwgayVErsTNNAwlbR1BNlDhClFfRCMHYPKY?=
 =?us-ascii?Q?WSBycOg+ljk0PPE0sQVp1TUUbzdI4YastzM8p3ThweM22Fb6IEFOvZYiIR6u?=
 =?us-ascii?Q?J3cNM5bvktcz+ZlRuqFVci4Gi3q051xSn1n20mH4ufBy/1BSerSujKlzd/pv?=
 =?us-ascii?Q?gQvfZV2a02d5OvDmJ42mXgw1c3+KtDv3GSNcSTqbHe6RYVqUZoElSmbgJSMX?=
 =?us-ascii?Q?KCyNyEM1kXNX9lrgcoxh62+TrINXftMwB4i0iwoOd4iBBSNNJ1lz3zMGORDe?=
 =?us-ascii?Q?ipa8IL8NotYDfbFcPE+OEHETQfguQfihEdyOVt594X5f0Vf0L3tvZDBWsDVm?=
 =?us-ascii?Q?tlp7MlWH7Mi8lSG5A3/0iT5YZsS3S1sl9Tau4ak2il5cEQqgAIkSyYcKbqGq?=
 =?us-ascii?Q?+V63vnttiW3r0iuwAKc7wpeeptZeq+FG04JCCqtyjmLEyS/hZhEy8087AM89?=
 =?us-ascii?Q?sg/mcAYu8zQjEGhn68++PFfMqmrYmel+nEj5htXm+i61SOwctkL/12Ya2EY2?=
 =?us-ascii?Q?e5lid9/9mrC7I9ep13vaqhiOZP3XLeBS3VDCln1PqgwhLXx99zmHxzHQTcX8?=
 =?us-ascii?Q?gyU1EJ8vJM+LYpTMhwWu9xnXVW1+zdjdP1aRM+w3VvlC2Ny5MZ8Bsgqg9bTU?=
 =?us-ascii?Q?FTPWgdnBfiIj9Jm3QRZQJlHFV3DPIGUVkEG65naxsEEz78usumeMyeCamjkV?=
 =?us-ascii?Q?JzHbb/4ZywHuiaypJIU8QF7Bvg4Er2sjT15eA4JZ7Hb9smJVJvsDxpcMX/tY?=
 =?us-ascii?Q?aaV9/Pnn/quG0ocy52z1s/dvZmFUs73y81gqwH0G7FhbW/reSMh26pmJrUN2?=
 =?us-ascii?Q?ur/Bpixk/yYK/7p8kvd31svFFbrJCQ1iRNXP7jKv5KxxCdpU5bOpUJwdGlRp?=
 =?us-ascii?Q?y2gCEJb7ho7mI2Wf/pi/TWXf0zSbH9odH0/HgJUIlzMx89gXGMKJORkAx6oG?=
 =?us-ascii?Q?xTcXfhvigUVfypd+0qfi0RFBQgJh6yH1pliNyDtMblQK0YYbT33WIrs4atYM?=
 =?us-ascii?Q?q/kENTGCdjn/SwUhblNfv+HGtfBAWdBA2pB7WzTIsGGbPeoIFZGxCeCh4RSf?=
 =?us-ascii?Q?iQU2GwjAjHk6Wpp10OE1VcAWvtpSGUyk7fmhTtC4al0l/RFIV+oZh8BbuvyH?=
 =?us-ascii?Q?oQ1BwlkWqS1dIzUXwk6qm79k+dzu1J4dfMP30NssoFqypsUuoYCi0ji/k+nu?=
 =?us-ascii?Q?CflZgt0Xwle1rZVXWMMC0ZMN2rWhLkovzaIRvl3ca2Qo9tEV+hkjlbIJrn29?=
 =?us-ascii?Q?Ig0XkUuGtJhR8zTcm+nLhfQlamaD+/1gd53YdBhYLipYTgfb0uph/104VGVr?=
 =?us-ascii?Q?jfTS54xm1deeWzCnSr2AZRxo1VZmbmROCkmrCl4jorPyjj+qYTNj3+6+U7au?=
 =?us-ascii?Q?tu7id8aNTPPxdT645pvgY5vOIGTJY3A=3D?=
X-Exchange-RoutingPolicyChecked: HB664yAc1QCUAuYdgk6xVa1T0ojtJEpvDvLKOzg3C9jAABO7ArP4yOmeU0qsDI7XA4kcNLEDpphW1KLTGtFSKNVpkZrYbUo4hBGbiKarVVa6T2lWh/KlSIUDta8J04ArO9BZ0dd3m2FGdp0OSvZ+RxGfVtrnWe1z8kWz5dy6+xHeUsYR7M568jlRep76vnXv7Km41qqWFLpm3qEpeNCbtrJRsXDMRROL9KQo1ebAJ1qSSuuk+6bypTE7g0bN4huWyPwYj9lALdc3ZMkT2vVhCYDuozftY35OGDCAOUlN7ZEGzhaNw2JF5e3QUoAG8IgElUd1yrL57AZP4Mk88IsDxQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6fde36-aba7-4327-37c2-08df2dd96e11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:38.8231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkaWEsPnGm2pVPQkszWB45ipN9e3kHcjPT68oM96uhPIq8UNdTIMctx1FfURs4XX1xRA9UDM7oQcwJCyj5FYX0gP2K1NLHqHqS18XtU6pPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX5uVg75pVWslY
 x0Cr4u2ujQni+wGSQxuSIxcjty9AN695kDRF6w+uZSCtRYTF8IpvS4gupptRh/SrgdEYEeJFk0p
 9RsRqHeo3bkwpIQAC/yDoNS9bqP6zgQ=
X-Proofpoint-GUID: -IV53k1Livxz_40hyx5wQcyKGE2vFe5p
X-Authority-Analysis: v=2.4 cv=V8joQuni c=1 sm=1 tr=0 ts=6ad607d0 cx=c_pps
 a=iJ0/73tnBOJCmN8OdmQeBQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=fn9E0C1quIHmE1dKZfwA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -IV53k1Livxz_40hyx5wQcyKGE2vFe5p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX5zswkFbffTdH
 0NGm5t/i/Yaq8CH1muTM4gw6HKAT6znC7yu1mUqfdTPzMre5DVxAI9iuvGNJYP9/ju8Zi2xa765
 5KsH/1L2wV0DhmR2pZF8UwdXgd+vDpf9tRDgh5zuR1OSRfuWQ9KUTthWkGLhK3qYHEjMIfQBgRq
 L/Xv2l1vjZfltKweEwmMi1thD33X4JZLqG8lsiGOAkPblNNLLPi4oUFe22gLL/Mmr9CsnXK3/yh
 WHP/WyoXPCPg988Hy+jsUMEFeeqO9NZGQ1ybM574AcTPKThweuDLy5uyqzhu2o5thOtAzZfuwFH
 d25A7tja11t9lwToBE+mdRQ1ykADUS4+fklCFT4Udg3sdJNMBV6MQCEN6c+yupY/GEbzSlIZzaY
 sGytOGUKFEB8wIBRAIBNAj/lMR5Wz2mv/TNz90C/HMKEeWjKMgA7rM1LQ/2Y21HWml6JNxenoIj
 6jK0P3Rw9IjITjUOzPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

This function is now unused and can be removed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/i8259_internal.h |  1 -
 hw/intc/i8259_common.c          | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 644508a44e..dd255fac24 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -71,7 +71,6 @@ struct I8259CommonState {
 };
 
 void i8259_common_reset(I8259CommonState *cs);
-ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
 void i8259_stat_update_irq(int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 09b761321a..5fa38fbc5f 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -89,22 +89,6 @@ static void i8259_common_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, cs->iobase, 1);
 }
 
-ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
-{
-    DeviceState *dev;
-    ISADevice *isadev;
-
-    isadev = isa_new(name);
-    dev = DEVICE(isadev);
-    qdev_prop_set_uint32(dev, "iobase", master ? 0x20 : 0xa0);
-    qdev_prop_set_uint32(dev, "elcr_addr", master ? 0x4d0 : 0x4d1);
-    qdev_prop_set_uint8(dev, "elcr_mask", master ? 0xf8 : 0xde);
-    qdev_prop_set_bit(dev, "master", master);
-    isa_realize_and_unref(isadev, bus, &error_fatal);
-
-    return isadev;
-}
-
 void i8259_stat_update_irq(int irq, int level)
 {
     if (level != irq_level[irq]) {
-- 
2.43.0


