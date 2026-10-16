Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFBDCCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHir7-00065R-LU; Fri, 16 Oct 2026 10:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiq8-0004Tm-V2
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:23:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiq7-0006oD-18
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:23:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE58va1681992; Fri, 16 Oct 2026 07:22:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ziHP+FkR99iqwYK3tusXaSde8vh37ejRC7j5NAZW7
 bU=; b=BDJpZ+D5fl2bnzCge47aa3Kd1YMsIzH1CqzfKsH97l5o04uWQmmbrA13R
 0Mf8g2tcxatYv+bIqISS5ToXhvQRlyzkkrKih7xgTVGt228e1ks3ugq6QUJfG7r2
 X7Htt1UUiPGL7tNfDrzy9zer5mKsTBYux6Ql1wzNsFQzuMeC1tJzpqsCUdnZq88w
 K8a5uGCt5hAMOLRxO14HnugvQjRh0n40UqOkjPx2NaasMqGdDuyKbBuOxcwcOsSU
 07CjAA1FnzI+eixe+E/tX0KtJtp3Qtbzd9nb7DYvjmJTQ8Awc70ZtWDXplllFfDH
 KgEVWt2gH+BoSK+uOSSmQ1BaI6mDQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021130.outbound.protection.outlook.com [52.101.62.130])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hberu10kd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2Rur7h1PDySYewi74qnmCGEGY3oIY0KIuXiQigUWMiNC7JNhAqmLGtB0bv2hxswK/tQLGHH72+N0Z7k2RMPDxFoF2PoHHYXSBO6zfhJ55qjs6zNdD4KRKDLM6H+pDmknD9I0EyWkDZwOOB9VQKbQW3ga2CIfj+3Oo7h9zjKF0APmVJ3R9GUWufKz2lSdzRgVX3MCPIIUoY7v+yPLRFiCflVPBBfpk2mfg23V71iCkwXR9tZ9XxdHFg07lvIJHDWdBevStK4zlF8TxwSezQzmhkNpRq5rxx4viv3gEsnxkajSsXVWNy+0cZySJ5jwRnh53AE2HWXJ8PypZHoDxEy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziHP+FkR99iqwYK3tusXaSde8vh37ejRC7j5NAZW7bU=;
 b=WpB6iVs4Avpd+5jpIQQROMTCKzHjxGtkTYT8yI8o9yCEnDVgk6TpMJlCDu7LophTU1X8Mwq8YtC92dQc4oCl1trxNhBmSkwEze9aG8FKuoZh47xenZ/RqHGrTQ57qlB6KwkjBJ0QV63s5JJJ5alnJe6GPPflDa+UIrT0wIvp+VGaeLsNkAbH4tkiZYmMK+yrUH3XrAYmCQ3jI+HUDUtef6hsCAbLazlKLnfCNeCpKPuoX1RLRSpH2tCzjj1NlvHh5LNtz4XmXezRjI+RLaT288jBwqREtazj5yQONT419f5pVLjZ1QgL1W1pf0KSfo5AUW1uylNlqsBYaWdSQeirkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziHP+FkR99iqwYK3tusXaSde8vh37ejRC7j5NAZW7bU=;
 b=BR9T0uSbhJl3b67zhBEpFsQqhAC96UlwOWQtNoTOJFyt/poYWP0YHXbN9SX6rqEQ1/OPK+Z/Wd4YXVwhFL5oUjrmN/VPLSBvSUD3MShvPLDFY0ARi5vItnuu3uQIFBifxj8Wdkq/KVFQLtdhR7bORfpJYs7Bo10pMyJZO/lGkMf6GSt9c9/fRjkuzUxxYNpGOsZaYCx2dxRnDbiBSy8zqxDLTtuJwwxqVpyo/2k/r3K6uRovF0vJbP8NLeUS5/pJetrlUD5kdLVlKHpwEI0Rvnvn3ILYyNADsQPRWXcPpUMi6/zogQdzsLIsdQUAjxX4N9Glv5OgWdDu8zjnlQwaFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9592.namprd02.prod.outlook.com (2603:10b6:208:3f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 14:22:17 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:22:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 24/27] i8259: move InterruptStatsProviderClass
 get_statistics() from i8259 to PIC
Date: Fri, 16 Oct 2026 15:19:30 +0100
Message-ID: <20261016142031.1204281-25-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: b9799841-b194-49b9-1fbf-08df2b90e172
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: FTTeuAPqd5r9QrqgjwLPY4mU12Lzl2aiSSKnvQFxGAf+5PYcOfiCG0Eljkgn/q3NsosIqgrDf1BJw4DRho38E+OBM3Kc3CkPZ2vsSA6eUD6ZsytOa5aOOqirYQqgpiBvNLNGishjV63rCE+xPVVAhGBY/Bb5LqYeSD0f14zu3tQ92R3xADzN7bFrcZBFuVin6SxpqrdlckAo+9MEL1DHKo07Psu7+cCNSjrXJDQnhP00r3x+iIY3sKB23hUs95R7MWpORmpamOUEhSX0mH9tiGzIkNyQLRvP1VIKf6DysI0cTrkvCw0fGwihRGhKzVe6uV6FfZcgCTpmyacQfI83az/WLCDVf1qpnZLm4TBXFLywfqzym5Hw/JnC5y19qzRk40chxpDj8F+/6anPzRufElhduxuZPgSormDJo8XUvebVItt7SrcmaMTiKLgqvwHZ2D1Yezz5TsxCKjydXV+sQRbVvKth4g4hFpgQJzAu4Rhsc3lCDDf5E+kP3dBGbnyoyQnBntR7bCPWP01PXFnaegYAATuxm7EhImBCTm4Z0bBSr8FDqcQlkjoH+ymN1w5Zxtanebs2U/vXXDufT4it8JbuBKwuKFVVby5uPSNg9NLaZOHCxcPGVrs9YY60ATUqELRe+ZrjrjePbnb9VXo2suHZgmrQfTxalAlWBNBAv6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C12UZidlEpEulCwXgv9ijkwPRRDqJOFaHppr0MORGZwmts7fLUKrTpTJzgmA?=
 =?us-ascii?Q?ot7Vb6ig6KJvWlbUf74udwe2H5AAmSwzEQRu3ZnHE0wry4nSOGqmqvzP9ymw?=
 =?us-ascii?Q?rfzFIbR1PAtctE70NTZ+b0KL8MBHfPmTQMAnGVq2lrj+7NHDV4xkStPZ7jtP?=
 =?us-ascii?Q?VoQGWlOSjbRhd+CYzJ1Hro/kb10q/LW88nrJdUNgaEsji9oFfXJ+v33VY3kZ?=
 =?us-ascii?Q?Ww69xKunOFw4V1HA7Iak/WaybSfvZdSdDvjUUDRjOIOepvDh3PQvxYh4w0lD?=
 =?us-ascii?Q?wj67orIkCZaBqOuQtnPJNZxHHL7sqhg/Y8O/sqHuyhZHU8lCIbdeb23QgMGJ?=
 =?us-ascii?Q?QqdZkhdmASkfCZEJHCi/TjIK0WFtnR/YfKtGXjzZa9wFXe0y4gEKMrACr22F?=
 =?us-ascii?Q?UduiD+zNpGUAM4sZgf3K0P7G8zzgZz6K6Np31My9ZW1qql+X1Z7fZ6O//nvg?=
 =?us-ascii?Q?0/6cvxS+ygvOign4+agu7uLpU/2DhHscXICclEJxiNXMTwvl/VDg1J431zbp?=
 =?us-ascii?Q?0q7ctcOW/nC55022c0LWeoLEYyhGRF18dynuj6MkWIo2TjS0rE00/ytlI1Wk?=
 =?us-ascii?Q?HS/UxDrnFrKhvgl9E/kdfu6lT3209h0b9EP4p/jLgamby4db79H3s4IoGq52?=
 =?us-ascii?Q?iKq8hYGUar/tEGWh/wO3epS89NuqVcIJRhj3nSBC0aRN8gou1d1TbQKpJU4B?=
 =?us-ascii?Q?mv4Xr3UnYzkCw8RYC58GgnsXSOXnJ5pyT24UGor4iPs++SXGQES+pI0F9lHE?=
 =?us-ascii?Q?XpC1CRDEC36rzbZa53uWfsQKYVsP13pCrg2UWuVOa4PsyN5ZO92Hw48hDlC0?=
 =?us-ascii?Q?e/C9V5Z/xIs3uejvMevmUC9Wq68+JPWB5Qf5tT5pZJHUq65sDPcbOuvA/SSg?=
 =?us-ascii?Q?1eHLeR0BxwGQ5lNkLx6ezI5uF6vdjMLudhH3L5FPJSOcxGNAGXSbGGbvqlRg?=
 =?us-ascii?Q?f/MYt4aqwElWkG1Tsxp4C37rGsUy4EnYHItzvAzK/DMtYmD8NWN7E18EHUM9?=
 =?us-ascii?Q?2fot5GZUqV8VbXag9WmYvxjqtqskKORMqtyoo+pExsI9iy1uB8KHfbxSKofz?=
 =?us-ascii?Q?k82pCVLBHPddjWdZTl5aIMBGFohXIZI09skWVxw0DST+xHlTULAyBje162mt?=
 =?us-ascii?Q?+Ie6pOcN/jZpLqhpgaPDD65A9tV7WobWtqOaf1zZGncwyIwKWTMo5idQfsC6?=
 =?us-ascii?Q?zHBPg3H63m2luYl1n8g4+tCYTlTbvJbZpCnXimR8gI6+grUhPDnysa4AtrNK?=
 =?us-ascii?Q?ndNfj9wAP0Aa2GfPF5/EEA8dN5XMBwgNb3Qw+GyWc+UiYsYozgaTx6rerBw3?=
 =?us-ascii?Q?IhHpQ+Fd4nzcxOaypjyL2buoaj7Wjer1TKxkZs0PE+sMvF0O0V1WmsO/fbFj?=
 =?us-ascii?Q?jNYq3wKvNWKsfXHZQN0A3p5H2ZfmY6t+deTN1el3sFghiIVAnbC1sZcDIO4I?=
 =?us-ascii?Q?Qh6tz9DXubruqr1/5Mxw27EkxKYXwofZztxbFTiaLLoj3HZCjTAlKASApRho?=
 =?us-ascii?Q?MhgStw4+wd3tm/WlIiu2aR8oCTFrCCZh/5IbxtwcYFfa5/ID/RKGE0M91D/s?=
 =?us-ascii?Q?yaquWwjYMp29isQJP/mRzM62Y+J6OU1BfzEjG0u6/t2l6xfR8640yuy3qyvf?=
 =?us-ascii?Q?QVH3RzRtkKwRV4b7HKU/Ljvlp1tvlQiXAasRUSU4y/jO2octB8yA5kPuM3pY?=
 =?us-ascii?Q?ayOkKwUHLl11Gf7yNFWFUD9mY/vmsE7DioU5SeSspeFd43Jk6FBcZXbFyEY2?=
 =?us-ascii?Q?9P8hte6JMNoCr3rPciNzmOd0FhDTUvg=3D?=
X-Exchange-RoutingPolicyChecked: mf7gKKFnmPmPWbzvFh52vIJALLCO/UHqWtdDMQAgNpEE9JABVV7jS9k1hGym6+NJRSMcPg1a5S7IoKpxRlly6KABcvcSoHdoGGeQg/y8q+yRSuJKxP91O20EoNc0NXUGSPw3y80WZhiZUNQajUhtL6r8p7IiiCMJcLYv619qSC4dPQKbs221IvTSxqTKwrleZOORvfe4vkTkiDOgLYvPe9UuXNi0TeBjsLWkPDH4Tmso0sFookAA97ptgkS+PWRWF3ls71nz5A3e90q/qCIhYxoQD4wJ0l18yhSoPRIBTvhcLjrtp78LwhpY2oxg6+UeUWemHnR6cfkqUm0bty4hmQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9799841-b194-49b9-1fbf-08df2b90e172
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:22:16.9635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieLJutlzFNfRUzut5ESdIcaQVqcqj3CFiJuI8Uy4cLVEwojcIrOfl/RCB3FoZLAePyyKdBnce5R4VyaoKt2LlBL9R+YhkTOlvzetyKWUgUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9592
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX2981SBWjMKmu
 DIwJiERFGBNgOVJ/VkVUSwBB9h1D1eRv6Fah2NVAb+hsvikY4ovGahiYG/rDgREefRMjn6Hxlgm
 Hx1DqrSvKXVM6sVKFvOmNS6kKU1L6/OhEuwaXawsyT+rcLN8uB1pJCK0Hkk577x8UeTBfpwnRdC
 zc2FUJzBjs3OaldpUsLAKwy0ywvZZXsj2udfAsTT2uX61NLGCCy/GHOMXa7TQIJAKmZ45nDSK6M
 FabVNubmS3i87Muxo/eSG+p+Luq9icggtj8NDyt+LsOHmq3KVB0CryYW8WUdzY1E4oKrib8gmEf
 V3ebcPZ1PkzZNyUqy9MzVwXspCMHAXUj1RB1ZDkjHh8I2So5gJWPIwGX+h4gyQqmxpbtTEEhojV
 jCnZLcoqY4nteOvihhsVbntuclRcVBEiPGzmJaiq0DoWaO/7ok9wqKVchscvuCaMdSN2FbhhFyS
 XGBZevq8oK0QWeUIe/Q==
X-Proofpoint-GUID: VXFWM2bAgemZzatva8USUijwobgDTMul
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX0f8IOizkHlZS
 5qYHu6El3erG2hD/ldQNGVud2ZntCoM0jC9TngVQ/DkNhGdpY1A9NJeFjksMYcbQqc+/Evm9tn5
 8u20PWtne1PpKpOz4/NHXcjXltLX4JM=
X-Proofpoint-ORIG-GUID: VXFWM2bAgemZzatva8USUijwobgDTMul
X-Authority-Analysis: v=2.4 cv=KMLPn1Fo c=1 sm=1 tr=0 ts=6ad23340 cx=c_pps
 a=7kgNGXaSmB15KJ6u7rEBag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=A7cMN0_0mIGH7w_oRUwA:9
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

The internal i8259 implementation has workaround logic for storing interrupt
statistics since these are currently recorded at the PIC level (i.e. for all
16 interrupt lines) whilst being stored in the master i8259 device which only
has 8 physical interrupt lines.

Move the get_statistics() implementation from the individual i8259 device to
the containing PIC device in preparation for removing this hack. Note that
this has a visible change to the "info pic" HMP monitor output since the named
device displayed by "info irq" is now the PIC and not the individual i8259:

Before (TCG):

(qemu) info irq
IRQ statistics for ioapic:
 0: 68
 4: 1
IRQ statistics for isa-i8259:
 0: 68
 4: 1

After (TCG):

(qemu) info irq
IRQ statistics for ioapic:
 0: 47
 4: 1
IRQ statistics for isa-i8259-pic:
 0: 47
 4: 1

Before (KVM):

(qemu) info irq
IRQ statistics for kvm-ioapic:
 4: 1
IRQ statistics for kvm-i8259:
 4: 1

After (KVM):

(qemu) info irq
IRQ statistics for kvm-ioapic:
 1: 3
 4: 1
IRQ statistics for kvm-i8259-pic:
 1: 3
 4: 1

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/i8259.h         |  6 ++++++
 include/hw/isa/i8259_internal.h |  1 -
 hw/i386/kvm/i8259.c             |  7 +++++++
 hw/intc/i8259.c                 |  7 +++++++
 hw/intc/i8259_common.c          | 27 ++++++++++++++++++---------
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 87ccd55a4d..d51a7fde32 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -1,6 +1,8 @@
 #ifndef HW_I8259_H
 #define HW_I8259_H
 
+#include "hw/intc/intc.h"
+
 /* i8259.c */
 
 typedef struct I8259State I8259State;
@@ -18,5 +20,9 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
 int pic_get_output(I8259State *s);
 int pic_read_irq(I8259State *s);
+bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                              uint64_t **irq_counts,
+                              unsigned int *nb_irqs);
+void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index dd255fac24..2807409eff 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -26,7 +26,6 @@
 #define QEMU_I8259_INTERNAL_H
 
 #include "hw/isa/isa.h"
-#include "hw/intc/intc.h"
 #include "hw/intc/i8259.h"
 #include "qom/object.h"
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index c51738dd44..b56e4fced4 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -223,9 +223,12 @@ static const Property kvm_i8259_pic_properties[] = {
 static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
     dc->realize = kvm_i8259_pic_realize;
     device_class_set_props(dc, kvm_i8259_pic_properties);
+    ic->get_statistics = i8259_pic_get_statistics;
+    ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
      */
@@ -246,6 +249,10 @@ static const TypeInfo kvm_i8259_type_infos[] = {
         .class_init = kvm_i8259_pic_class_init,
         .instance_init = kvm_i8259_pic_init,
         .instance_size = sizeof(KVMI8259PICState),
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 5f90edbe60..842507f9f8 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -535,9 +535,12 @@ static const Property i8259_pic_properties[] = {
 static void i8259_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
     dc->realize = i8259_pic_realize;
     device_class_set_props(dc, i8259_pic_properties);
+    ic->get_statistics = i8259_pic_get_statistics;
+    ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
      */
@@ -558,6 +561,10 @@ static const TypeInfo i8259_type_infos[] = {
         .class_init    = i8259_pic_class_init,
         .instance_init = i8259_pic_init,
         .instance_size = sizeof(I8259PICState),
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 5fa38fbc5f..684290fb2d 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -99,19 +99,28 @@ void i8259_stat_update_irq(int irq, int level)
     }
 }
 
+bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                              uint64_t **irq_counts,
+                              unsigned int *nb_irqs)
+{
+    *irq_counts = irq_count;
+    *nb_irqs = ARRAY_SIZE(irq_count);
+
+    return true;
+}
+
+void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf)
+{
+    /* No information for i8259-based PICs */
+    return;
+}
+
 static bool i8259_common_get_statistics(InterruptStatsProvider *obj,
                                         uint64_t **irq_counts,
                                         unsigned int *nb_irqs)
 {
-    I8259CommonState *cs = I8259_COMMON(obj);
-
-    if (cs->master) {
-        *irq_counts = irq_count;
-        *nb_irqs = ARRAY_SIZE(irq_count);
-    } else {
-        *irq_counts = NULL;
-        *nb_irqs = 0;
-    }
+    /* No statistics for individual i8259s */
+    *nb_irqs = 0;
 
     return true;
 }
-- 
2.43.0


