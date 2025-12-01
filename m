Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A52D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 09:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0e5-00069M-8c; Mon, 01 Dec 2025 04:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0e1-00064K-3K
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:33 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQ0dy-0001vY-Td
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:56:32 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AUNapLc2237071; Mon, 1 Dec 2025 01:56:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=b6vuXBj0iftB1FSlsAvcYTTwMB25XsaCAqfvt+3WY
 W0=; b=oZOPNbqVVBcGpQm2e5rhWB+lR9SQOITHlvYDJL0npu2e6fP5enm+nzHWE
 WQxQaBnEifioGRaUqv4SfMvNEFyQ+v5B32cFYJnqvaRxXOYrxY/2xPha9LGNHz5r
 AhzVEf1rnjwHqqCOEy5Kqfus7XxNFkJXe5S7v/2zdzEnDbjZHNvY2Hkivs6AXO58
 OGS2HnkP4rCQSdbWj+apa5PcI07q+rA8H5Yyy/Tn5s3ciOvqx/yx+wUF3mnU667T
 3zWBisl14QJvZPLfQ+5hsbIsGQyZQcqXE82bsojhUFLUMZXXFYJvxVgyYWsO1nEh
 s3+s+Fl7JkyLJiNRu54XhV+SFwgQQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022079.outbound.protection.outlook.com [52.101.53.79])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4aqy8camk8-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Dec 2025 01:56:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/M1SrTzeC3BPrC96WQM9FryDhoGHbK6hduGWvLN76KUm6xXCnFy83yzrAxJGTnnLSc47YlWii558u1rI1GPYJvuySCmVSR/W+xaoP9lWiGqqJfsEEsGN3/4WDPv2Y7Cb4DD1DVwpJhBMC9O6N/malCUShR9E5Y8xRx+6k2Sp5bvTTD4P/SyGANfNk6ukgMzT+u8QV884MKgrOjj03vIxkUP2InLc0Iy6FJ+ccmrlwqXcbM5KwQfeB3Pq8kzvD4DqC8PusxCSS7pcUQnUg6r9D+ksuFtgiLge/m9LUH1hTTEln9wmdqnbMIQPbog66GOOvfyYBzJhrtWQ/RepIYPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6vuXBj0iftB1FSlsAvcYTTwMB25XsaCAqfvt+3WYW0=;
 b=rUqTHixyJdYyICpNn6kgXBbtaQO79XPlbSBjfB+QtWcVwo67oI6tciMNWLPPCy3Na1yT9GBy4VU10LAA8+YBmqab3DrRukbBPQUyHSrIZESsS1wzQwiNgN6OhExZ+117zZTmelBizETRwnJa79G1XMnE9kfUedM8EYzbjYiIXsNKRBSUBHmkhm1zdOrIT1x2SSzF2bYSbPEtI+liN/sRRFKK3Q0y2RLd61NQXD5JdMouBJJM0SRC54TIksCWnemrOkJTGSRj+ZDa7I3CHLuvZ2Zh1npYEXS0ZSLMQLNPERszWOAm5a6XbdNXHkkDbQQ7IDzPyNCtJWPbvnIIgWjsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6vuXBj0iftB1FSlsAvcYTTwMB25XsaCAqfvt+3WYW0=;
 b=CbQD+Exm637F3ttDFdBgH0lW7AmjXeo1lICTgYwCjLnLpWhG/0OzayS4ssjTEosdh2tHeYspmVDGmA/JUUAkAAnsxGBZCp6+GqILIhfZzC5VABzvufFmArfcKw43KseHDtnB8dx2fyblPZvtiPsWPejad1CB7h3b1YOK9HmG6VL34vY20b3VICx09AC0VpFL0XzKtwfPjPVqrFvSm4C13qKkgFapkViXgGIbiRe0L3ceCozIjadeJj8R+QTawDmAM1ZdnruP9v9FZGbl7bEJ5CJ7vaJXfGHvTPq0rwoIDyArTijb+0U/MKpCkG6RVOKi5mXLqILVGwTYZ8kNfHgs8w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB9865.namprd02.prod.outlook.com (2603:10b6:806:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:56:26 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:56:26 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 1/5] vfio-user: simplify vfio_user_process()
Date: Mon,  1 Dec 2025 15:26:17 +0530
Message-ID: <20251201095621.2786318-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201095621.2786318-1-john.levon@nutanix.com>
References: <20251201095621.2786318-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0576.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::23) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af92298-1b44-4b75-bc02-08de30bfe467
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sTvVp7iHN4oVdAxSPvPUdAFPvRwtEKSG2Hu8UKOplfvTl8OaFuA1jW/z4x0a?=
 =?us-ascii?Q?UUnzZoahXwsHqA0UbCgL+cr1bqAgncsHtPdzEC4dFGt9uTcYV+LAQn5lf4N7?=
 =?us-ascii?Q?hLo36VvWJlNWVuPKL8c5mggcU9ouSalnTnl7hKG1QnDlOzb1chiHMoEKvosz?=
 =?us-ascii?Q?svDdmgJWzP28zRa2Zr8rDyGl/EGr0eSYl3kMKxie1d1JuIWIjvfNGu527U39?=
 =?us-ascii?Q?KATUQOurHDr5IOB1jjsC/WftUlkDDOiTslzh1w91CbV8XqRPQqqQZquE5beN?=
 =?us-ascii?Q?buFO556UH3O6jMzB8VM9NXCqPXSI2RRIc1RkU6NJrqwnxG3rPgCzvcBmnjPT?=
 =?us-ascii?Q?6ZPzzj1bDj64TIuwtlRwbmoJbVJla+XJcNmEAz6cnJSaC660q2AA4RtWugMx?=
 =?us-ascii?Q?BADop+6rDFnM7a7+myufTLNKK59DoaEfeWNdBEo0GoC47x0l4mGcLfJ1of1l?=
 =?us-ascii?Q?4wS/H6QWHsdwDWAH4OWMOZ8xW420mQE+eCW8LOX9kwqQCoBTlYkduXLKbwQ4?=
 =?us-ascii?Q?dc3LMY8wJ4zTyL6jekhHkLEnsytYFY0GulguJR6F/+bXYNg469z4TSsI0CoP?=
 =?us-ascii?Q?E15qA9id1d7fj+Mp7PHbTBRClCj68ndRr/RLRMY13WZnXlltCVy4eY0NO63Y?=
 =?us-ascii?Q?eh1Co9s8Vu6fC7vMUO/wHK97loZsbDQOO9+RZQGwi+tmFzveDprPqBwOpAlN?=
 =?us-ascii?Q?mqY/Eymj0oaNnb3K9QzZf7F4e4TTnzt4u1CCTo975S88FSaWR+Et3UNOWCLF?=
 =?us-ascii?Q?/J3ZNUae2ITH0qnBqJKOFu9mHyGFHQNhX3Hn+fJ9d8FeiwVpv2MS9S0XEm1C?=
 =?us-ascii?Q?QkyQdECrPI9pZjbX0Y0VRXAxJ2F9tn6vT0Hlr/GTTgnm3PUC9/H2ZOBChk8W?=
 =?us-ascii?Q?RJ4BIEHaS66FlZ+yuVtaudxNvUIF1Nwy1l6ho+TziwvwVFA4QyE98EQWb9Yt?=
 =?us-ascii?Q?T5jz46R+z4ogV9kHCZJo/5O6xIlRiDE6NWRHpmTN8I2Jc79bZZf2w/o4zXVK?=
 =?us-ascii?Q?lIanBY7UzLGv+MVYf7l/oLn07YoPEwu1uKN1KrzsGdc6Fub4DDMHhnloa6cs?=
 =?us-ascii?Q?fTyWw75c2o8CsHAfKQl1ZepVT0bY6gj+gp+hpNCBcft9PA3BE37ckGs0BvwH?=
 =?us-ascii?Q?OUe4pWk9puDgcT5MTGuNDGIZ1GUbsf7g3jDPUrhUBsWhNklF4WQY5YZR8f1V?=
 =?us-ascii?Q?m5I6HmlmXL6/QeyCHIx/pbbG2km55YLVOcsVpmmmOwfWqQiKX2p59VGs7lfa?=
 =?us-ascii?Q?YweGdGrOdQVvyl8rxfvV2mk9ZCoJ6M6yewGA8ni6K14lhjWs+V1R+6ZwjlZf?=
 =?us-ascii?Q?Us8QBHAMrVIRIclz3UzmmRKAlxPVr4zgQ/C+QZPEuatVNsyIWkDlv3I+fzDm?=
 =?us-ascii?Q?149Yachr7cPmRwQxuy0NzRMYiWShCmKFctx+4lx1tRf+HDmzFzGj15LLDRcP?=
 =?us-ascii?Q?q0i6ATzqY8piz6pFbO1Pvzi5im5x0pRR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t76xgn79+h0ewgM8owmcEN0yFPqaFfRfQGsCYdbbQ77L4HWubN9GypD5V/o7?=
 =?us-ascii?Q?a0Ofpfe4BgNAXb1lEo/RwLjikgdY5tP3CZrPv01lOp3Hl9FyeV0QkpuIn5CQ?=
 =?us-ascii?Q?EK3So7M2WUipkykMUjG2t6Pg/+TLhuQr42w2w8t1qH217YRKkRyUR1nCxOuu?=
 =?us-ascii?Q?Sk+VgXm5WAJLzYIXZchcXUyYj5gP+neh8UFp0HP8aQiI1AOm4CWtwtuTAtpD?=
 =?us-ascii?Q?4pCXc9lsgilWkQKb/ZW9dsmhTpnJh8DkFuVZPXm12ciVEme+0PHxEqpqHSnx?=
 =?us-ascii?Q?SuuI15NhupXrRdRyiIdWX8nA5t3eHjQJ38LYJyJ91Jipv6OrxUFd8VzN5U6n?=
 =?us-ascii?Q?h5h0ZeRtDQHZ3Vat3GkO1+wgHz6QswCApVethM2Cd6N/2NYwb/5C4oCCutAr?=
 =?us-ascii?Q?o/LnYkAr+Oi0dcqcloQDCOI7N37f2mDIyO0WideYAaBbbVgBn5WJYJLk50Lo?=
 =?us-ascii?Q?mzGvpuDJFASmosfIcVMtL2cGf5bL0mRN29vnoAsFEoAJeWvFsy2QFvdGTVZI?=
 =?us-ascii?Q?URU8VaWAIbA5ObYjUu6cyuO7KlK5zMC/okqN9W0JyWY/j+KWCE9bq4V5lehC?=
 =?us-ascii?Q?k2aDcxwtx3bAJs2JKruFXBY1qYFQ/W+kMvMZ+w+0yP0s78E72mvEevL4PxAj?=
 =?us-ascii?Q?cJKCMbRDHFuw3nMavIoKjuPkQ0hd4wsCRE2ex08UTBJQFksLlgB7ngn5G8U5?=
 =?us-ascii?Q?CyomQDNQFVAR8+DhrxY0odNbm+Kdag9ZiiGFr9iamQNHRewEFCKfo8Twg9ah?=
 =?us-ascii?Q?oQ6WFYt17+DfgC94ztHUdcmcK2/dowCtY/0uBgkdHQzC9mp/eW+rrL4VYHKH?=
 =?us-ascii?Q?W6IAMhAYanA7qHP8pauN48wNNDZfJU9EHPuu9pspV3yMYQ7PyeL1gKEGuaki?=
 =?us-ascii?Q?rBVAtHnu/hS51+nmPZMcpa9Sk0WAFpBED9bPyCb1wjZyBzm7JyDYsi7tpT5z?=
 =?us-ascii?Q?9Byq6OEczrrUcHklg0SXm1NYN+tCEfjzI+4UMx22RAsZKbd5ngsvdKSm16KB?=
 =?us-ascii?Q?wKwXqn/InMLCUexqBOh0GPbNM/v4zVT1uBsEzQlC+5r+jnKO1hNxxYhV2+UC?=
 =?us-ascii?Q?Lrp9DJtTGuAbIzt1uemWf5sqIOi5N95nJHk2rmhIFxrRLiapdQWG/OiBzIej?=
 =?us-ascii?Q?N40iTxswj0VHA9hekEUGbq7bA2+RCKzvlePIdt/fwUKkzr9UQJKI9HRIvj0V?=
 =?us-ascii?Q?Q37z924Jscuxn3z7yrdJ65adb810/foGYnKI7LJjaoKZSkoWhM9KjBHx4BS/?=
 =?us-ascii?Q?7c1bFc0vHuUdciwNk7OeZI/CSsGrv5tnTRuVzUTko1cRMkz3Nn1o2V9yIS01?=
 =?us-ascii?Q?GmFdkQLy1g1y/vcfLqgLjr55R/FH5fYa8CreilZ2NSlIEMV0lVQhAAq3GXPf?=
 =?us-ascii?Q?JiSX8MkKNOcoh8Q697p2gLACTMa3IJ1O2El2QzfytDN56a9YzwAfEgU1G2pn?=
 =?us-ascii?Q?eUaSIuXSUvI1tt8Qdioy7DXYKoh1FPP0yXcSmiVfFv9cqtwBtpHDKmYCwf/o?=
 =?us-ascii?Q?8MwjdmUQzfDwYqniwcyz2L85eoMnvynt9aupd1biW2FUd6nmM8c6eBnBs36+?=
 =?us-ascii?Q?T/wjsV49KSEhnbJmLfq7BPX4/sl0zuSHeQXmK5w2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af92298-1b44-4b75-bc02-08de30bfe467
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:56:26.3497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgOpM3yk/18CWtP3AbnTgjlod5buxTDP7UBKLrXR6DxO8BYRMYtUfy/DYLHdtENDOKvd1Nl4V3X3uv6h8qs4kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9865
X-Proofpoint-GUID: hHZ8u3vR60u2o4MAqCBo-MgGDpHYR-s1
X-Authority-Analysis: v=2.4 cv=Q4ffIo2a c=1 sm=1 tr=0 ts=692d664b cx=c_pps
 a=Y1/fp9MKcFODYkh4PiV91Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=v8IRLEuh6JSOYo15BCQA:9
X-Proofpoint-ORIG-GUID: hHZ8u3vR60u2o4MAqCBo-MgGDpHYR-s1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA4MCBTYWx0ZWRfX9CfWze5wdbLb
 p30hFq5SqnQh+IxZvy1e1ApMgqRdFc9ydPPO+adxWTG1N2VPyKf9+GPJHMmCVi57DisGTWmkNOu
 lNU/OPmzrAc1sbO1y/IQlTiea0loFPK6LjmkjRkR8VsiSWBzEkcgt62Mf/WflYGAGlomVebxzyv
 Lw7grBpMV6HMdJo4RxEUZiucgK0IDO/Zq2G6TfvEV0ns45gs+N+5JxhOhx5A/Rxq6xt5lSEVZuA
 awdDdTDh5xB1EMdMNkefypvB4gTpkKtvpMnzthtD4UwyGn20oM1esR2q3ZSW6U2jNt8BBZX5vzi
 MS61fTARjNIo1ZLwXM/QM5qnasbKLBB0NCujatUar71qgg6P5A509x0ewCNW0UKNchpIHunZS4O
 R0l7wwu0c/a9D1LhTDLUXbyGiEghEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


