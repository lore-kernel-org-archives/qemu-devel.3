Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65F3C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVg-00010I-7x; Wed, 19 Aug 2026 09:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVb-0000wI-3V; Wed, 19 Aug 2026 09:39:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVY-0000lL-Dg; Wed, 19 Aug 2026 09:39:10 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCmM10511116; Wed, 19 Aug 2026 06:38:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=chViCMe/uA7hEFdfconNaCS0V/m56w7+9rnhE2xmR
 Bk=; b=rSD5qwWAoQM22Z9B3j22OXWiE7Rtu70YtD9bYSBZYkdOPigx7FoMyyTE6
 ttzKzwZRPXC7+WENoZ1g2XPs7QKLiIUVRg70/6AcXeUORKrQcdOb8HmBCqoGkWwJ
 JddP2w0gyjunXFBtNcRRm/DxSI2r2yPB2qZ4jrmRC5bggYGTxcrr1amQ2FguAzuE
 PmaLQuKTMksvQsDgki1j6p7bONENJRaehbDDzEAq31JzR/Lw9dAzsyBL9xPGHldL
 TWyeA2tKMFjcuTFIkwDO8bjXr7Ung7ztf25nPLnh8jXM2iAL4zccd0adIZi0EFVj
 WGt9wwxhLhGHxNbbjJ/pvNo5zK5Ww==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020081.outbound.protection.outlook.com [52.101.85.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4wgrtc8m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEz6teyKmzohd/JnENcsqEuL9cmpJIU38TenxbpF/GBOCQtISqSAPXW9I5cDyNFftX71cLfBn8SqnhJXj4iUk485sBDoRZttp4cFJYfHfdhrBB4LbMwAJcfJAGYC36XcT3p9nbVbBUXaPsmoigWJnwmWPlpotlKRoZTjjQlV7Eif5SC3DKEc1opTtn9WVJePFVmpk8JnkXN6MZd6Ayz9S6rMEEeY7Gl68qG99B8PP0O8TumNA+SCGmgxMoYh3ArdHwuk7tWF93MGGHpAqj8xW1UiRTwusmf1Mg9jo+Kay4DtSmaF7E/w0I0CWQZd8zI2Qp4CQn0oTB+rmbFtPTRYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chViCMe/uA7hEFdfconNaCS0V/m56w7+9rnhE2xmRBk=;
 b=Ft03XYQRHZcJ6P7bD5bZ8TU3FJSvsCDSjHSlQEkNCRYxF5PpRhj/UYkRpvuFcpPLtXBmlai+kS09s99P4ujPv5YQa3VubFfI3q29e7vd5vUmGRIcbIgZXba1KBfa4fYhRBojVA3gKA5TpWnRq4vpyfcqSt87fVSC3hOENGVBRjZphfx32SVZCChuvBqQ9RDrCAWURiBQOTIANRzqoXO/PIqcsqLip0MnDezmyjn/o9NmTSqT+WfVU5Gh7YRMJabqsL8DTaiHUvYej5vQPWydgevsOv7LIHi1WExvf5z51ni1ZI1Fm6bxtmiaGzpmm0+6OIhnbqCJxIu/kAYtvsASmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chViCMe/uA7hEFdfconNaCS0V/m56w7+9rnhE2xmRBk=;
 b=nLhIHdBbJPSYNL+Tf4P0SWmhVcEdsDATpi9VQkRoIjykkVO4DpggrB7ET6Agy1yOH1/lFpownOnWm5e2tXlBzZfwDY62ub5gQNkcxz2AJVF9LaX0XnvbUvCFAiQxqvW9C+XDMttFCtI5CpbJUeFBqRNrCRoW+5tlgBi9ow5X5o/Ka15sKv+GBjURKEue+LCtLG00krT7MPHBGzVEfspr0EoVIQqnqlmJCTB9P/KADZlpYNk0S26WgeYtm9tEEgJh+moCunpWnjbLkjmlF4spWtXdoVi/WB0RnNakALN6qUDNZujpHkXt0lDHK3124gSVgn3ENNZ52tzgmGoJ+8kYog==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:38:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:38:56 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 10/15] hw/acpi/ich9.c: convert object props in
 ICH9_LPC_DEVICE to class props
Date: Wed, 19 Aug 2026 14:35:49 +0100
Message-ID: <20260819133816.3497033-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:806:126::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fea0b6-dcee-46b5-216f-08defdf73734
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KeGB1yF7L/wn3HpN6/HlFYHwVnn9pXxU0RKQ+2gUpltZmakoaBEbXTryRuPybKnD86w4LyX9i9v25EwzSCi62s259dOT9TKdpEVOKgypbL5er/Il3GrgHOusW0lfKHS36YCEt4GkYe02IgyZiqfmcA+6XalyZ49GRZGT2+CMVjEWKWqdCbqu/e5C6jhHETdABd4UljS/qJaTAjg6FdIBbzwXs6822F55sjRMz8spK9wvZhz/UXRjzk2z4a8CdXeh8dt7GPSMuaPodDOvV+bxZtd/GUXkj8iyIAOAnFhfVQ9KruuKQoNqYJST2ZQt/o+tl3U/GDk4L3CJ4nSEWajUYCRX+xzunOMMaj8GfYbz9dZdAIfNYmO93Odo+83kPbpg8gkg+emCg1G8pc7R1WbS5vCjPp02ai1nn4tFPxL5jh73R61f4oMemKYvTg2zqZ0Q+Tf40lTPZHctF5q02O34sIyFxuwQ6eim7oi2Zyid5UgM7hgRKWgs6Ah+BHzXm6YwgHyavuxaiU7LGvWZEe+Qi9wNJf9jFf9hPYek9O5QPPVjSc+G7055bpKrM9EIV4vIi+gIH7vLEq0gIwq02x3jDyDpwEKZ0ar67IbygWOZM3+khcF5nwx9S1HZsBdrxekp+Wk7oax1GBPECrAIAtm/i1VVw9aO5V0FAi83mP0RJcrzzEkti4CMiWvioHKa5/V8IA55fBi9OIrn4tZi/zJxFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JUz3avCA/e2JNfUmQ7DYWHj9EioSURUtn/+ZAVaxeJ2AZSHZjWSsKz+ht7UF?=
 =?us-ascii?Q?gy65XqZYcy5VgFDy1Mcnknc7pyy8Br5780Yolzd9656ufLVtDdd55/bpCs7U?=
 =?us-ascii?Q?V/jTYhJL9gW0rwcrxJKEy+awVm+Ql41a1mv3dGRaAGqXhyOmfmMcH4Ne6R8x?=
 =?us-ascii?Q?oguui5Q8QgMQdif+c33GLzn9HDI30OVyIC8wt4S3FXsAlI9tyt8lC/Tk1wJj?=
 =?us-ascii?Q?s3GC56yecpuacHEkfoVBe/ILzaN/YqoIMi4zlHkMqGnRWtDA16Bz5J41MAfR?=
 =?us-ascii?Q?ea53Eqa2x/MemT2inG1VegQkTxfKHVWagxp1OC8T5Yg6T3omFUDOCbAOAANH?=
 =?us-ascii?Q?qBSX3LvrVfHC6rleAWU7oPBHImMEou22cOSYyECjHFowBMI9Wwrpv1thgea3?=
 =?us-ascii?Q?UEj7TjJR5UgqxQil29N6tHMzOBYiOhxCundR2uppUYG5risgp6mdX1bfDlCs?=
 =?us-ascii?Q?7YqzVezOFxFVsnrEI7L3nRfSERK2lUoRLo9zVKwcCW5O52wPN3LagsdvETGZ?=
 =?us-ascii?Q?MBttsE1kME9PmH6MZf6TYEX/p3MCpM1vdb4Mo2wPyOd08axmShGGqb1Iw/ib?=
 =?us-ascii?Q?ePty4B7ZSfszBnX/B99uZEZqdYVfcR+GLkTVtH5mMI2o5Ss2QuTZnUN96zOM?=
 =?us-ascii?Q?94wgFygWWC7T5sY18Gt219vJ+z4rGWfj3zAPcGISIrHqBOa6PdojQirK46A6?=
 =?us-ascii?Q?YTXx4dXW24H9i4WZzECivKAMYOCC8wrgHPzp3W8vj8FVixj91u+rv44ZYnTr?=
 =?us-ascii?Q?cx4i9kETd+bxh5Dj6I+gI47wOWT08gRwTOaLMPsx6TF2fVGsv1DS52UOoWrg?=
 =?us-ascii?Q?Ktf/Yx5NtwA/fnjpNA1/Jm8g/sBeBrWjOhPFM0VXJmsLFr1oxwmDz8OeKHDz?=
 =?us-ascii?Q?YMZ0ndA5+CVXWJ2DEDryPnZi28Mp5eMWqX/Yw8FvFC9ofAf9NZ8WyTmYViFe?=
 =?us-ascii?Q?uwEWOzmBoKoFw8ntZbdlMDoLHuF0UWAtlLKMSNyS1EeRqgZSa1bCMIAPmLOZ?=
 =?us-ascii?Q?n+k+707wolJihfOKHG6uZR9f/NtUSLBlK/nfCaSdccqgR0rzv+4vdoO+SfMp?=
 =?us-ascii?Q?RaO7+W5p8+jsAttRWxuv/CREFJUtSV/f8NU9c/ROmiqIxQ3Thz4vhTx5cwRQ?=
 =?us-ascii?Q?cHa1QUuQXYmrwXOpXcHhgWuFiIGVIvyohY5y3IWZJd5xxy56GSOd2M80Fyc7?=
 =?us-ascii?Q?0VIiKCiQqiwsewbVzNdQ9+apsNlH8pfy4X2krnxb+PGphRFhDP1XGDoZT7uZ?=
 =?us-ascii?Q?8Z9FI5cpBNawoit62GSVKROyauPKubqQVBHllc36Ujf9DoAngBdEoQNk/R+W?=
 =?us-ascii?Q?+NqFaEZ8Kc7zmJnI07TzDxfiVXUkfSiNgyybhaef0k0KX8gfyjJuNcDRLXyB?=
 =?us-ascii?Q?vkFNViIqkFlpUHfxWWilmUrYxBqn9mUjgJjZVlXT5rWX2d6Qg1S3khuKT+6O?=
 =?us-ascii?Q?EscYiJkedq/aMVGVa57e75Wsw26RrlbLne2nGt5aIYTUfkFxSulFP/HZcFLW?=
 =?us-ascii?Q?8ceKNp/kLBB2fFuZyhtIly7Z7Zj5bU4+xgMxgg69EQ2sEN/s7kRf2TiOKNh+?=
 =?us-ascii?Q?NJAdfTZXR9LASCBySNHes7nNJZHK7fQCV7lPI3m5IWZnK/acJjDGTySw7E3T?=
 =?us-ascii?Q?qWd6692UMGC+qAJ6U5AL2AnUGFLS3Iheeo+9dXsFHKNcyGeOmPplmklseA+a?=
 =?us-ascii?Q?vybePlHp9dakOPk79IyT5bTs7eYx1XQXtsLj4W1fNr0r4UNrOaGuC98aG32U?=
 =?us-ascii?Q?QW23SHDiCrszqYUFYo558ZTQAeYDSDE=3D?=
X-Exchange-RoutingPolicyChecked: XA/JBs6G/vDa7kLFFKCCIu3FoC8pIOwe2OGW7NvNtTmRG8E+PtCLf5h0hQbLP5uENqz34PGD+p7eM3PRAlsbaipoGjfG6bfLecvexPJIF/HxRtuBD4Xla/+33N9fag5noYwps1aWELpDSEUKxEf6qAjHW/YYmF6lTghAD9YyCS5bT1mfmqYXVASdX6HLm8joQgVo4T3jI0g53ArRIrUDWvoVveoYEaijmSZoz7/qmSuTtGWAiR+MmLGIHb1pVIT2KaV+JlhMQbNpfcY360G+2Ww5zND/Tl0hDHAo1fKdv94flAKbcCecjGYODXIwJXJkDV/wR3T+U3mqUIR86GonyA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fea0b6-dcee-46b5-216f-08defdf73734
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:38:56.0112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkoc5SIvyUUU4j6+nb9chSnVIhBBaPnYXuAQviy2/oyvV5/75w3c/oL8PY9z2eD6gnXdZKGvNk4RE3cRpWj2X6QIah1kDc3rx9XUki+BcYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfXyHiXXpmUaU/v
 VoI6Fi1muwmIuPz7n2bl8P8uHBHMe1lOKYPAEFcGNqdRkS3BcWCK8UyiN4k1usd/y3noJjGtloj
 ruqrTIDOqyk3Ay4WlNVsJIPKp6vwTwr/0j/f3Q09j7kNUI0Ex5dyPOT+xwXD8FgHH+lW/AVRzeL
 2Q9jvYb1Y47we7bFfKLozCMVrd1eTqmTVxtkjHYm/UR+/aZr/0A9+bb0e4KROeEpOQ1JH4a/w6D
 vBDYo2y74i1GvlfZKS7JyC+zYALHYV8uMqFV8jgoXN1icWKW1ZNsWxEM9bTULWXmn9U4pt7qTO0
 BrjwPADDu1sHRjOTmCK0qh68T3y9JDWOiXK72QSbrSuNwT8UaeJnhkM13FBfkCFEG+QN9n5knTR
 FyGLuyFoQks4CWahz/yXlPChRBWxlILV4q7yC4ZeybanlTLmn65pb8x63M3Zf06nv0sd0Jh2bXR
 olF3xCN6Lls6+88pJFw==
X-Proofpoint-GUID: t9yBf9hPQ4cGBdHGHYiA0TDSw_31mYRW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX2cIDI6hp2Ld8
 Dtby77bg2Q6UTIypl0MsSKOTyLZ1N774wUVdI/bxBHtN5tT7o19wUkuUzmOZuzGhQhqqb7fVR9Z
 /Z6cF9gYuK7+lof4RkPONPQ0FA9RyRc=
X-Proofpoint-ORIG-GUID: t9yBf9hPQ4cGBdHGHYiA0TDSw_31mYRW
X-Authority-Analysis: v=2.4 cv=CcY4Irrl c=1 sm=1 tr=0 ts=6a85b1f1 cx=c_pps
 a=PrKk0R3FxLq9+u45pGB2Yw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=HwAbVaYSD3iTdclZ3UcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

ACPI_PM_PROP_TCO_ENABLED, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE and x-keep-pci-slot-hpc
properties can be converted to use object_class_property_add_bool_ptr(). Remove
the now unused ich9_pm_add_properties() function.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/acpi/ich9.h |   3 +-
 hw/acpi/ich9.c         | 111 ++++++++++++++++-------------------------
 hw/isa/lpc_ich9.c      |   3 +-
 3 files changed, 44 insertions(+), 73 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 3fb993bb9e..6d14544751 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -83,8 +83,7 @@ extern const VMStateDescription vmstate_ich9_pm;
 
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
-void ich9_pm_add_class_properties(ObjectClass *oc);
+void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 774b34195f..4aa8d36f54 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -349,46 +349,6 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-    return s->pm.enable_tco;
-}
-
-static void ich9_pm_set_enable_tco(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-    s->pm.enable_tco = value;
-}
-
-static bool ich9_pm_get_acpi_pci_hotplug(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.acpi_pci_hotplug.use_acpi_hotplug_bridge;
-}
-
-static void ich9_pm_set_acpi_pci_hotplug(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    s->pm.acpi_pci_hotplug.use_acpi_hotplug_bridge = value;
-}
-
-static bool ich9_pm_get_keep_pci_slot_hpc(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.keep_pci_slot_hpc;
-}
-
-static void ich9_pm_set_keep_pci_slot_hpc(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    s->pm.keep_pci_slot_hpc = value;
-}
-
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 {
     pm->acpi_memory_hotplug.is_enabled = true;
@@ -400,35 +360,7 @@ void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
     pm->enable_tco = true;
 }
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
-{
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
-                                   &pm->pm_io_base, OBJ_PROP_FLAG_READ);
-    object_property_add_link(obj, "bus", TYPE_PCI_BUS,
-                             (Object **)&pm->acpi_pci_hotplug.root,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
-                        ich9_pm_get_gpe0_blk,
-                        NULL, NULL, NULL);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-                                  &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
-                                  &pm->disable_s4, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
-                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
-                             ich9_pm_get_enable_tco,
-                             ich9_pm_set_enable_tco);
-    object_property_add_bool(obj, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
-                             ich9_pm_get_acpi_pci_hotplug,
-                             ich9_pm_set_acpi_pci_hotplug);
-    object_property_add_bool(obj, "x-keep-pci-slot-hpc",
-                             ich9_pm_get_keep_pci_slot_hpc,
-                             ich9_pm_set_keep_pci_slot_hpc);
-}
-
-void ich9_pm_add_class_properties(ObjectClass *oc)
+void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset)
 {
     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
 
@@ -436,6 +368,47 @@ void ich9_pm_add_class_properties(ObjectClass *oc)
                                                 ACPI_PM_PROP_GPE0_BLK_LEN,
                                                 &gpe0_len,
                                                 OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_PM_IO_BASE,
+                                         pm_offset +
+                                         offsetof(ICH9LPCPMRegs,
+                                                  pm_io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_link(oc, "bus",
+                                   TYPE_PCI_BUS,
+                                   pm_offset +
+                                   offsetof(ICH9LPCPMRegs,
+                                            acpi_pci_hotplug.root),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32",
+                              ich9_pm_get_gpe0_blk,
+                              NULL, NULL, NULL);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S3_DISABLED,
+                                        pm_offset +
+                                        offsetof(ICH9LPCPMRegs, disable_s3),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_DISABLED,
+                                        pm_offset +
+                                        offsetof(ICH9LPCPMRegs, disable_s4),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_VAL,
+                                        pm_offset +
+                                        offsetof(ICH9LPCPMRegs, s4_val),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_TCO_ENABLED,
+                                       pm_offset +
+                                       offsetof(ICH9LPCPMRegs, enable_tco),
+                                       OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
+                               pm_offset +
+                               offsetof(ICH9LPCPMRegs,
+                                   acpi_pci_hotplug.use_acpi_hotplug_bridge),
+                               OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, "x-keep-pci-slot-hpc",
+                                       pm_offset +
+                                       offsetof(ICH9LPCPMRegs,
+                                                keep_pci_slot_hpc),
+                                       OBJ_PROP_FLAG_READWRITE);
 }
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index c968f4444e..8155e9e7dd 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -689,7 +689,6 @@ static void ich9_lpc_initfn(Object *obj)
                              IOAPIC_NUM_PINS);
 
     ich9_pm_reset_properties(&lpc->pm);
-    ich9_pm_add_properties(obj, &lpc->pm);
 }
 
 static void ich9_lpc_realize(PCIDevice *d, Error **errp)
@@ -917,7 +916,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
                                                &acpi_disable_cmd,
                                                OBJ_PROP_FLAG_READ);
 
-    ich9_pm_add_class_properties(klass);
+    ich9_pm_add_class_properties(klass, offsetof(ICH9LPCState, pm));
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


