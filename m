Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2ADD12694
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjht-0004Wa-0b; Wed, 03 Dec 2025 05:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjhr-0004U1-4N
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:31 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjho-0002yU-Ug
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:30 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B37xXUV834742; Wed, 3 Dec 2025 02:03:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=b6vuXBj0iftB1FSlsAvcYTTwMB25XsaCAqfvt+3WY
 W0=; b=X2RmZ23fBRh5SRHZz78t9ErCsaZwP4pX6mclrvgkPMJ23ojCUrFWyg5hu
 zxNcSJrSS3aBRk/manBcG8RMlzSN5hVdrW1f8V1JqILkl0U8ZqVe/s1bPDIo/gHj
 XoBs63CD2T2PttJADy5SiDSEcKA+R8WLf9GDKJaGDRAMQSGgmNZOaBMSYR/vQIgf
 bKpF/KBkQoi1fmpX5fsjLBdm+BenAEIWbVBB27oU/BzKxUBv4XS797Py2KFAgBB0
 fhLwk7WLIzKX1jBv2nfUY1eeWG/jKIx5esDY54BRli7gbkY3q7QF/PUcLCLvkqNQ
 RuIxfUC+QUyBQXgRzjvRtVFGX18eg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020112.outbound.protection.outlook.com [52.101.85.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4at4909wwb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 02:03:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0/2F8m9bAM+SGwirZZErXM/2XBvwuEaA1YABr6AuyGj4eABeZb8l7jxQgY72uGVGyROEnpU4UtVKB55l87TBAFo6Pj+8a/EBP3PNsFVzEvjOCXUUBSOvDq4GUuYpIvf71gPIuuDp8htb9ZGuXiVR5VnyNMbkPp8XwJTU+4uAxY9mxsGMK6diBoqAwuFiP1TgLzV0hWDiwBVZmnqIzQCWhVHwAJ41g/XnJA/nk4Vwt8U6UHeLbYgRrX0Wwusd+lR5FbIjlRWutTAPDY45beUB1VPpLlmkQzfblTtGs3NkUvFmuPFijze1i34ZhIBbc70We7GpZDkt0RE1AUzqBzw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6vuXBj0iftB1FSlsAvcYTTwMB25XsaCAqfvt+3WYW0=;
 b=muLjNLMnXBNKXEDpKi7SEdtYql1z6x5PjQqAJzcQyxHPsZeEyfamS3ym8iNMYZhx0todpU2GgecKzMHcgXDWct5Nzktz6vfBBQzuw400qC2J22vR1Abtjhz6etRWy8VhpAdpgICfIxgCtq4TCz8UOWEBSPg++PT2BEeKsBZn9sSe23Woof85+ZpJ5t6i9gFnVoDxJdR+FiRfzzRMfuyaROHqRt/H1r+SFokBfLKvO8+zE2mzCtavaKsmqabKp7hV+maUUH7hhr4Mix1ao+012R7b29iJ8JL1ZfZL0fz+hZCr7VisCQZQBVKFmEXvsqQ2LtgUzqP/ZXxvzMOuTJRnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6vuXBj0iftB1FSlsAvcYTTwMB25XsaCAqfvt+3WYW0=;
 b=Q0IdA9ys2hLNQCWUGD2/eglH74pA0OHEMrg0raT2MtXQAxnyGnUKn34uA8Q62iBeifD3p3jl0KQjaqKQhzdJry4Z2HkneYuBUWeB0H1FlhiiECFR07LQVE95UfDmRGpGu0mLflsjuZavMYZ1udYPPnTTqTZAx/lZtelT1JC2imoQDwtOg0GHLrFephzR40wdnamn7Zni4CnngLTRtBYLhdOJUbiwl4iNqPzn0BOliGBvnY1qHT/OPgHaI16lV+Gim5Y6lhapDihbd1rj8aczgg6GwNstE4sOPSxp3Z/x11m4ZbiGfqV1joQwFwIqdt9YJ2R2DzPv8Lchgl4aOMi76Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB8927.namprd02.prod.outlook.com (2603:10b6:8:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 10:03:20 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 10:03:20 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 1/5] vfio-user: simplify vfio_user_process()
Date: Wed,  3 Dec 2025 15:33:11 +0530
Message-ID: <20251203100316.3604456-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203100316.3604456-1-john.levon@nutanix.com>
References: <20251203100316.3604456-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 675a2028-ed0e-4096-8682-08de3253301a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aD4/msJreDOnjVYSBUHOUgwXhOHtIniV/gwQmLeT9jzq2G0C52D7a3i8k4co?=
 =?us-ascii?Q?jXxbMMq3BNwUnHpN5qc+KhsyxET4/kfxGKkmwF0SDA04Y3E0PoEX9btdAUFO?=
 =?us-ascii?Q?Ixl9IyZkHbmduzKhiPEpgH2tBb0UXELiPBMDg7UJ896xNJCYTBI1zvjvwEd1?=
 =?us-ascii?Q?mdJErfL0uffr4Dt8vTjKP6ktUKtVsG5riNMWVebcWCcdc7jOlonOk9XaD/GY?=
 =?us-ascii?Q?tfw8V9YQlNvN3A87qMBIHmHhneT6NI+aG4BN6jE+b+f//bdbANnFhbwjm9LG?=
 =?us-ascii?Q?vUirPii4dzXRBhaaMG7WR2dhK3u3ESgfNmZoZ2bKUwh1PKDlplWWeVuLolFS?=
 =?us-ascii?Q?uyt7OJzlUsojkzK/veIr9s5jsudOxBGuqRhh1tBnTs5zS4hY0ko5QgjDQDfL?=
 =?us-ascii?Q?hQLa3y0YIdv0H+N7M2bBwdy/xfausY5TWxmTq2WyJzF1EUvHy4IilcQI1Qt2?=
 =?us-ascii?Q?ZoxhYEU9NxFqw/joDKAPEhpAA4sKY2EsIBS2e/DlfyE403o+X8wNY+yeECdb?=
 =?us-ascii?Q?xoPGF0dNVVuWYDigIHhOBDn4Hmm9hXIahLMrpXS3P2z4lTdn22FpB82lg+ZD?=
 =?us-ascii?Q?LM9KIfDy96/1NLsu7xY2cxW0IDH/Cs9amfrswVdTxQ6OGI4lg7xshE8CZnZC?=
 =?us-ascii?Q?xXQ9ESR39ujVccvQ6u+7+l1CIARWzDrNsSws1dUGu0lh3wC6B2kD1/f2m6yJ?=
 =?us-ascii?Q?U6pl4w0GN/FMkNCeV2hPF4GbR/140kjyuU0W+fpWiMX6+3R8rVRUyLXfGyAU?=
 =?us-ascii?Q?3SLtit4w42HrlzJUNgeh8mC82My9a7TXS5B0FL1FeMLw0CZxQbXzPViHd350?=
 =?us-ascii?Q?DKWWGbCASZY9wtD6BaOF1zcd9Lqyn9K5a7xk777OGInLwUet3hDDfhUCwAXM?=
 =?us-ascii?Q?rB3vpaqDRr1iEMKhG4AoS3y3jBgouMdkrG5/Wpvm7eIjNveTX4z/Xcd2LLBK?=
 =?us-ascii?Q?faLyk//vhCcyYs7IADxk9JJdH633dNzGLomrP6tzdWlEyxIoTp+8720+47k1?=
 =?us-ascii?Q?FSbfVcg37wXHwAoEz8iBEykKhrkAhUdFsbxGFkkQOGWKeNSrXlsqZRaClb4t?=
 =?us-ascii?Q?tJc10nk6ubt+uHg75sKTI9nDe1w6Z5BY523SHJPhW+kgMIAj282Ssan3/fL5?=
 =?us-ascii?Q?q8KQ10s+p5TrdOGHKkw+Km40HvnkfRR6LrdxgZadb9fHe3LjQX5p9s7Ufuhs?=
 =?us-ascii?Q?b1dTyIfO1bjyzrveAme41ygbCl7YPQi5Nq8b6G+Ha6Ur3TBJPf7/Vave9FA3?=
 =?us-ascii?Q?G1u+PM2BNBfjW/myiQrIoWiM2Y+bqRvrzhffufxC5ga3FpaW4BspKnZo/uRC?=
 =?us-ascii?Q?EuqYeaqm5mREp7hQ9ZyKo3+/gUH9UkwXPy6r/zaN2bTj5kw6R9Ekz/9GerRI?=
 =?us-ascii?Q?Vax4r25dVynUIe4o8cdr2LcfUiX5BUidpZm4FPd3UzOLynz5t7zBTNO76Kc4?=
 =?us-ascii?Q?iE58/qbnx+PZB7rpMw989Pflw4QDDMco?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q/kUrYJq4/SDsLjt5FdcfvZg1fgqCdWVrUGJPErdYjfmHtLY7ps3gjl1dcG+?=
 =?us-ascii?Q?ksvHhKTpfqQ2S8Hz9716M07YKZfOCh4cwyJjw9ey3C/26dlnYm4TJzXN/IwO?=
 =?us-ascii?Q?TRysVImw0P7CxdFNrW4QuIttwcHHETkNuQiWNAw5g3keuyHHqkHCnyhqh95A?=
 =?us-ascii?Q?5EVsb4jVH7v2v9sRP2H1alHBePzV2hHn1bGdCle+jpJ2bNU97NEX6Qglt0pT?=
 =?us-ascii?Q?p5KlgoWiPOtP1ZNyT3Nv2dLTxYMtGd+DQgv98TJjQ0iOd2BrxdDeTGH+9i49?=
 =?us-ascii?Q?wnWeFdzxxZLovQHA6l1JKEfSJhcQJVfR4fw/W78oC5P1iicgnrzDbdtqfxU/?=
 =?us-ascii?Q?aER8Rf1ML2cfnk90u61qeCcvuINJ+meRqTrtt34Qjt+f5G6o/EHYShWyJBhi?=
 =?us-ascii?Q?K5Owhk4TnyK0ZMqdZWz9ARq4Ika4yCG16nBZzIl8qL+neZvYzRR6L2j38GP5?=
 =?us-ascii?Q?IPvbM0FDm550H0e6BhQbpFp44ILSt+hT/gOK6gmFFMiEazQJsj8GMMhwDMFp?=
 =?us-ascii?Q?NEZeMcyIKJ8tfTmoYyDOSshGVdxGVSlAWXxwsvkg7T7Hl3Y/YhRs4s/IbNK9?=
 =?us-ascii?Q?I/uM5xmEfyIrZhFIfVsgMXhbVmG4iP6u+Up0wSWeAB4TcLILRxTjncpdydZR?=
 =?us-ascii?Q?bWV+TZGLScdVbZGwR1pIt24zSFQ6s1zMG9ZTTwDeEWUmzNnMIS0sqjtXROKW?=
 =?us-ascii?Q?f8C27lLUgA+Y+FWe7ArjehWejU+DJ8m+2Us3cn85fn1jsZrO47qGW93K51Tm?=
 =?us-ascii?Q?NLtx4aeag+Y/XOFQTCGKpo8Z4r1b6AZ8eVMjCT47ovNQMLEGzjFFtsbbdeSL?=
 =?us-ascii?Q?99Tn2QFd1WgNjwoRQxVSk4UaJ9j4sIkJnFLsCSLDiXfDvqx7XS5Jp6zINwMH?=
 =?us-ascii?Q?s4SKKYYi1XDctnwDs+t7cwPcQyiQbIJ9QJnbWr2nd6KOjgnOLZerrfWO66V1?=
 =?us-ascii?Q?vDXSHPIZwnmGxJNr+ciJlMN0r823N4VguOgdMgC1970V757Or95bMMfkHvvT?=
 =?us-ascii?Q?rG32nB3vz6BobknJynmsXHxPP4BSBhYsOj0vZkEo/EOrxdIy50aBWntkPXvT?=
 =?us-ascii?Q?Fg+H1EiVfTbXkI38H2mssYXcvgujCKOwLOsDpnbrbqI5ku6Wo9E2ygSBU0HD?=
 =?us-ascii?Q?2WnTxyUL91jlSr2wQz6Yl2FrYfW9IcMMTeyMmidx0CgDRsBUsv9uWvnnQ1P5?=
 =?us-ascii?Q?MnO6vn6NEXY7f2m1Roty29LCiz5tJXGd4+ihO4/afVLathFoldi+GIFGSmcB?=
 =?us-ascii?Q?TOTA6GmIIOTUmAz8Q5yojOjHwa+HKDyRmX4RjHKehZJxSg97tkoVaB7Fm5AL?=
 =?us-ascii?Q?qsi7CuB+PyQfGPc9tvNz/wBea7bu75VdNPo/uwqThsXCcM3UZR8XpuwzxBgs?=
 =?us-ascii?Q?ujIdoKo1vp1r0Kv3uUqSEgv5sTH8LDpq2sgMKFz2WBS4IIQytD0I+ip5Y6qQ?=
 =?us-ascii?Q?jmzJ0CzgGQocgd34a7NeGjbIQ64asXXhG4u1QvA4z4ErbhoZKmhBQy+E1ucz?=
 =?us-ascii?Q?w5Mo9IGE9uYNzZeX8Ii7JHf95Y0g9chGD2vBfPXp8WBEqYUm+Tco+IHhtYRb?=
 =?us-ascii?Q?HGPRFaVxcmx5c85go62pPK4VX9y4R9lbkxmxdwAu?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675a2028-ed0e-4096-8682-08de3253301a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 10:03:20.5267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6h8UXOfZn1SpM1UJo4+pH0cGrZpwKfaAh/smhOYs8Ymc3Poy+bsuD30WLiSrQ0kxIC+1mtqIGBJQkTzftY0cCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8927
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA3OSBTYWx0ZWRfX+sLYm4UH9r+T
 scfeFdxwXy9Wtb+9EmTPjmaZI0fjd7O8WqUw6g5TStnTp6+/CppPcoCkkmdVpyB3Df8c6oBYZyI
 RVE65WoLCwA8xm5pjJI+vUUAG19rnjulxPNLT5VKjCAL/VaK3CMMMVUTYd5UTC+dxyiMUCt2l9n
 i/7iht7bf52ndAcEZ2hV5sCX+YFZztRGOrLLQVMadFXBeP8Z9cNNpxQ2VceT4vg7zsw37QQ7+0Y
 QD7nU6xzDR7eWcOcoSEwc0K2kvCLUlJH7NEKYOifQLVAknmooEwY60ASK7w6hyx+gI/hX/I21oS
 3/eqaOEJFCT57FgAmSb/Gkt9SiUYWUJsK2TG1q/TV/7KbZnTxpXQk1vW4dPLKGjLhLYUBwKPvnz
 5rgFcPQJTLm7x6hip1EfRCi4SNedDg==
X-Proofpoint-GUID: hc3rFn-xoIo2_sy2bc7mzuBqmw9IiGUc
X-Authority-Analysis: v=2.4 cv=Gu1PO01C c=1 sm=1 tr=0 ts=69300aeb cx=c_pps
 a=1sVWB/l5Kn3omZIicXSEwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=v8IRLEuh6JSOYo15BCQA:9
X-Proofpoint-ORIG-GUID: hc3rFn-xoIo2_sy2bc7mzuBqmw9IiGUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It can figure out if it's a reply by itself, rather than passing that
information in.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index bbd7ec243d..75845d7c89 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -147,8 +147,7 @@ VFIOUserFDs *vfio_user_getfds(int numfds)
 /*
  * Process a received message.
  */
-static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
-                              bool isreply)
+static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg)
 {
 
     /*
@@ -157,7 +156,7 @@ static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
      *
      * Requests get queued for the BH.
      */
-    if (isreply) {
+    if ((msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY) {
         msg->complete = true;
         if (msg->type == VFIO_MSG_WAIT) {
             qemu_cond_signal(&msg->cv);
@@ -187,7 +186,6 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
 {
     VFIOUserMsg *msg = proxy->part_recv;
     size_t msgleft = proxy->recv_left;
-    bool isreply;
     char *data;
     int ret;
 
@@ -214,8 +212,7 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
      */
     proxy->part_recv = NULL;
     proxy->recv_left = 0;
-    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
-    vfio_user_process(proxy, msg, isreply);
+    vfio_user_process(proxy, msg);
 
     /* return positive value */
     return 1;
@@ -381,7 +378,7 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         data += ret;
     }
 
-    vfio_user_process(proxy, msg, isreply);
+    vfio_user_process(proxy, msg);
     return 0;
 
     /*
-- 
2.43.0


