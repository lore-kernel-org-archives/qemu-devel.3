Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54615CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcm0-0004RX-E6; Mon, 22 Jun 2026 07:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclm-0004JP-Fy; Mon, 22 Jun 2026 07:24:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclk-0001S0-Cs; Mon, 22 Jun 2026 07:24:50 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MApovc4141281; Mon, 22 Jun 2026 04:24:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/Lq0rMm7d1mzzQvxh3Xp+0T8a1hDDqjFGSZvYDn7C
 Rk=; b=hDZqcGkOx49aJy6z6aulusOS4TmuOCzZosqu2k9x6WJwPLumQOxgRtjsa
 u0/dfw7BNI8TQ+63dETK2b6bupfDS3D5aSpmF9UxyZdmWifNWjOrPwrQVOHjxlyI
 boJWy3oJD6yAorA1QbFSxYmxK/IwL6bHNjEgs3dsDx21+tT0VC5ALutUUsiQf/Z+
 IHagO2pTR9SQEP8NIhtjqlHo3kYFetdeMI8bwOdj4zqNK/ht807Ihfza60fb/Uh3
 tMEl7myPZViB/TOytFE4M6E0ldVSkXNtMupAzTc+b6B5+8vV0igydLOJOlzvJ40N
 b+9jjzqyXoyC3NNaoIWZrQNodGH4Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021113.outbound.protection.outlook.com
 [40.93.194.113])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ewsxd3fa6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 04:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i712m5icxJ/vSnBnYbCZKZzlbYeSxDexIwG2jjGTmspqJMk5hukFgJI+oTqfLioa32+vF2abHo0MP9JH00++ofuduboMCuhizDO6ThOCqObU6EgoXnalqVYhgkSNXqK1reDfu2xiHXO4QEzRAZdq8v5m0vIvtUW09KTPQbZAUDBVw/v61pn/77V5pUzfKO04eSt+us5FsIDShrRj2ek86VTJXHyxnnRkFCLBkeXKJSUzHx6hHb/gETo4aZSx6TsEDopNSte17ijkEsV1jC9wuK8Lxr4Gf6H0KrasIZ76WjYOq1Zn9JU+BrDGj/ddeqIMx0dxnboKIN01vvei+DiZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Lq0rMm7d1mzzQvxh3Xp+0T8a1hDDqjFGSZvYDn7CRk=;
 b=VEaObNQVxtjSdItFeqvnGcHqvNZJ1nW5a3TXArn/QQNmLVr8J5Jd2xQGvcrCg+rimfjIy5+0shA5asPgeOi6PNv8iZnp96kE4+v4Rj2ucplSSk1K3INwTSIpOa53jzrE0FE7sVjZG7dALrkjyNOzbmY7pY/DKwUEMD4qDf3MJDhx52nhA1DJMiieUMJFII1hh/4Q2JuDNGhmzjfXPhbFFbMb4KFMVH2bWAInt0oRPjE96Q+tqWODv4Fycfbn6Y/6+Zhe2elPhbg1TabsaBj3jv1dDs+KVUoUH1Nc8JtY/VnRy8ImZS8/a7RnN9MDFGXzlU1CAazzY+dwkhZyhHYiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Lq0rMm7d1mzzQvxh3Xp+0T8a1hDDqjFGSZvYDn7CRk=;
 b=Hs9SSegtuvictvKKPDzdD8t6+PGdjZYgPYs9+3q4aYePxVtV3ccOkuw2DNrio4s7x0cfT9OB9DKhGE/WRX4+sgYr3xR42X7aNrKsa9dhE8kcCngNt5XilhlPEBwZZllwjIVTCeC858AjlUAHcnyJA1kxUN2gJ1z23EESCj9pxYZQ4CjWA6CHXskmRs/Mh+ke2FfUCb5l40YmZjwim3m1RSp/TivvYVTOEhCmnfeiBu8JcfdEEJKXNNIkuyq/VoeeJbZzdJUutxViPL0ZhlSVI6f340oxn4iqYQqM9qF5YBlwQf9tr1VxZb5ynpC7o/XnrWWzOsul73zxl5A6II4x2g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10661.namprd02.prod.outlook.com (2603:10b6:8:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:24:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 11:24:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 7/7] hw/acpi/piix4.c: convert object props in PIIX4_PM to
 class props
Date: Mon, 22 Jun 2026 12:22:39 +0100
Message-ID: <20260622112403.928954-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622112403.928954-1-mark.caveayland@nutanix.com>
References: <20260622112403.928954-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR19CA0098.namprd19.prod.outlook.com
 (2603:10b6:930:83::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: 68402c39-57f3-476f-db0a-08ded050d624
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: 4Km02XQemb/R7HQLrvRw+J0vi4jq/EeGVGhNnI8w+NX+0l8CpzZWdxGgTgZLpCb1e0RO9TL0LeoCOrnbG7tOaGWDIQXs5GeyaV22l4HIeNXRYM1iJFty3wxL1nTYzJ3eHBlLrhET+7nVBRFT4SQqmWkxd9BD1AcCfgmr9ALZV84qS2UO9mYZI/WSmxDdygTC9Czh8EjGGq2jXKgNegREafRv/JgL85HHyMUp/I7Yw33ksqlslezCsWuhqDUIY/SwYQC8U4DObKZxQZGAggiUSmR/IebJpMqyBE/3QcUTxLrK592mRGtrU6MErdwc8pZ612nYZuZfOpFUu/G3gmi81Vem/m0V1lRMwDyPSJ+xDjnyI/FpfiunVmL3gYaujHjPek2zkjb/QWLgYkUX//yfFt7f7025nbEi4WJVnyGcXWAf6O8WiVBdFnUdfaoQC4oP8oYLXHseoM4aDvy5sh3fOeTqEls2NAFzHb8jk1VVAyyBMDVIATPI5YLC88w/gkTzcCLGKVcoWaTAsOASClOp2rO6ZB9F3S+zX2nDXJLK5XJGGT5pVN8ubhv8Z0hbg0nYF9mlgpFbH8n4jFhAe13eV+FOefwZJPQXMsTmWl0XczpBYreVKqOj/k7LOXxd/BSSNjYZExhzWST5noP+W5tK7HyyMflqmcN7B2cBoXVQuZ8IjAXBTzVn0+uIPG690L9NRouCHyj4MvPfvunmV4Fc4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?InT0NeyOW7cr+t4VD1N5B5OBj+cRkhv4wm9R3i33pFEC4oOuPIfSLl3vu72d?=
 =?us-ascii?Q?OxApxNndgges/FaHIRl5Vl8+YCIvPqFnPL8ubmQNXd82Mrzf0w01FPuv2/4q?=
 =?us-ascii?Q?PAPYP0mKJxe8JhtLyNUfswMwEN881iHedggiBbY1bQqFdotB+i6thcxpcV7Q?=
 =?us-ascii?Q?oTg8KtIF9v6tdBjWBpTZ2WYgwwahcEuXHevhJ5jpH4sE0z3Yuqpm3s7VXV/X?=
 =?us-ascii?Q?XUFLJ26SuxZ8Ws02BIH1aVuJlTebkIK371CVLAlNvfX75l66gdxzSG8B30OS?=
 =?us-ascii?Q?VpGVtzsi4Grk6bLufyjilOGOx0H/7T+G5I9/ri259lMmlaO2SWL7fxbDmY9M?=
 =?us-ascii?Q?wkaJc4opAiln6co+LcavbDkB/cQ7vXk+UkhdtWbUbJprVtLJLG/JSM1b1TYf?=
 =?us-ascii?Q?pEeVo1X15t+s6TYK3b4pGL/lTCO0Fa6DtceJbP2RmqMRnsx64xrNZYZvfw5k?=
 =?us-ascii?Q?kDoagI8/1ybcmUWcPegnALh4WfCpqrZEo6KLFfmHyBT3sIRh1Msm6rmrcx9o?=
 =?us-ascii?Q?Zg//0iIJsp8krBCRPLUWkMXMk8NUbQpT2QuRrGNIpM/2B9115FYYPNy0PQrx?=
 =?us-ascii?Q?whO4h3S6P1iZVWjbGXmFTNTRJHjJyloLS4+4E9i06YwHFaYX5b1WKBkGoRTB?=
 =?us-ascii?Q?aFE2LRY5EYkAT1a+KpUIHukmaiW05KUaJXFojjjLyEqLszSNwzUgBBEINxLQ?=
 =?us-ascii?Q?ux/Jks/o4yCG/CGbicvkBY2AFfy8wekNaXoS0kzOSK7i6uQZmjaHACHtHGCD?=
 =?us-ascii?Q?6cJspZ6KgDS6wCcAjODzd2GwQq2eWkf3IR8Oh9csRR4Mb04VvnTEbzpDAW98?=
 =?us-ascii?Q?EF6NiyaUOp7hXE45Uhsp6mw/UGkx0C+u9lfhkW/FFiNDw+spZ40eS72+5p8m?=
 =?us-ascii?Q?Flnp0Igum7JkepqgjpHXANauh3JysjZNOyvZjS17A4nqGZAk0TMHPeRwE6GU?=
 =?us-ascii?Q?n1ifdtEs2hwvWXmB7p83W86xGgADRIx4cDxwCe5w9rObn/lXBhzf8PvhG8GD?=
 =?us-ascii?Q?1RPQAdYb9mnv/pZwZVx07aowK3/jxKt4FbJRWg4nVdEJQKHcWhfv7enttpks?=
 =?us-ascii?Q?36naHdCa/MjYk7xfxg5Io6vDYpc2NxlRxOVv/CBLhUaUn3atmKPDAa/nOM1f?=
 =?us-ascii?Q?wT8pUoe5SZ71K5diuz98YLoJsr5urxLN0L5TKGcI9FfVTj/uyeAt354mGvDA?=
 =?us-ascii?Q?NeEEQ4qo5rtR/Zd8Qb/krvh25prnhc7VhwWUi6tQpHZzQoSSjNq5uaWOW92t?=
 =?us-ascii?Q?yrSK/BBQks2leFLDgbtCGHFlTZ7nHcmWrALt4q6UvH/3vgljYg7yOBuwhF55?=
 =?us-ascii?Q?xyf6lE0y3WfQNfg0m0K4kROHYG+BQVKCxmeOGmJZvjjkwj5K5xEvSaaoXpGq?=
 =?us-ascii?Q?nAbxVNa+7U8mKbSpt9m0xPZNCJgF5FhI2mSDXPFy4Hd+WeSwHB3HeW/U1qpi?=
 =?us-ascii?Q?F17eKxS2CGHbXoUUFFlNYM21/5cq21a4XuddiywprU+R1Ro60oBGIoQhhQzK?=
 =?us-ascii?Q?Mgmy6ImAT8mAxcDGyg2I0anf0nHgat0JXKRTFJfX/eER8IPD6xoBEBqrD81z?=
 =?us-ascii?Q?dAKuA9cwYxwp6FEXDIhhID4I7b1vJPaTnCpM7qgpN2fzKwuRGBuB2ESJ6vel?=
 =?us-ascii?Q?x4AFF8Rt3EOCEiWUEP8IHjmwllaruVhEixR9xbq8VNqmjdSVwHCqiknD/Vx9?=
 =?us-ascii?Q?JhuEBEq1z03SDJdCvAgHg5SvKlOpGHDdB+2GA8aUyXEav9pYvos7OjTSsJvV?=
 =?us-ascii?Q?RNaU90Oy+hdCb8Bs3YK6NTtMjjnQPoo=3D?=
X-Exchange-RoutingPolicyChecked: DGgD0+zqDg4bARTKdDE9IHAxVBCCUkBR11SMWR4Gb8FCizlIP/T7JLFZ9guJHKrjNftKLJ9Wbk6Y1tb8JHs0vImLMpcfj103yLrPIHyzw26B5SXLP57+WOcwDUWVleyUiSdY6nft1NwqE0vYF7Yu5r6DwxgoEFt3vIUvbJccBwX5rUMaKuQyAGNgq9QhhScp5lcNgY2sO9QjwDPDP76HYKYGQ9N7MBJ8QzSf438lMK0ML3rFhd8/W+9CtOKqkcMZJ0p2F/pIVS8/nfUzUByZB2/QbMsI4T/1Rg/b9ZBvp4UbsV0GU4oO5MPBGHdaybunaU/7yA4U3paMy2welhLXlA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68402c39-57f3-476f-db0a-08ded050d624
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:24:34.3883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBnpe4yVDGJiJhk+FNl99/fDkBKYgK7E0v4/3r1AjZ6q327jQlKQp6ymhEKvFcqhdgDz693b4A/FPyI9ej+Sy//4q66oMbWHV0P6kxQpRVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10661
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX82Vezg5CAco8
 qaTmG0/LrBOwzYzssk5+YqkZtlWYggZrMdqQMVG/cQVL1Vh8iqkHKLi+2qI+eGOisNbhM2QqoXP
 +/TVCfinQEMWieiER7pD/KEUIG+pCsW/9bbCYD9X6ubfoYR57DJs10QP2+yoiPbYNBd4j5pkYCD
 a8nvuUN/5/vcfyBQLjCYrC27NzAdNYcTA6T2+bpBS3IEXK6ph8m7ZoTJVyys76tjjIQkdNJYOdA
 0gDbeFsk6T3Yj/lwyGcobKG/r8fs1gCHWfd17hb2INXmLwFhYoLCL8AMvyjATuubs3QTgSoB8wC
 iwEm/T1/SBeEETTmcXAKD/VZGgiJ/thdN4jgAmfHgjCzZp9AvflJRGDKcA1viaTu9MHFWfwNwit
 zLH1gzoChvfb+4Hdoz553RQuZTSBDmhusto8GvA24Wmkf4Ct2khS/ckLxOKjgDfDTVb/CBreQo8
 0HFizBaoiju2UKDuBOA==
X-Authority-Analysis: v=2.4 cv=WYg8rUhX c=1 sm=1 tr=0 ts=6a391b73 cx=c_pps
 a=+jjOclGHkOGhuepu6R0Llw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=BSwvxqYPP3kZS5870RIA:9
X-Proofpoint-ORIG-GUID: IdXpOiJ4T9Ux0BZHZmDqoC4A4T-mD74p
X-Proofpoint-GUID: IdXpOiJ4T9Ux0BZHZmDqoC4A4T-mD74p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX1I2G/pBeufAw
 zSK26yiiECQXeZreSFsymozJoG52YsFrfNuJePmLlKfgj+QF52Dv24WjeNLAP/P6qq+Cf1GnM8z
 KstzPeoxaoaFM35rUFx/8FE/qH+6m2w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/acpi/piix4.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 4bfe3caa0d..1aaf53e438 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -406,6 +406,16 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
         (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
 }
 
+static void piix4_pm_get_io_base(Object *obj, Visitor *v,
+                                 const char *name, void *opaque,
+                                 Error **errp)
+{
+    PIIX4PMState *s = PIIX4_PM(obj);
+    uint32_t io_base = s->io_base;
+
+    visit_type_uint32(v, name, &io_base, errp);
+}
+
 static void piix4_pm_get_pcihp_io_base(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
@@ -426,7 +436,7 @@ static void piix4_pm_get_pcihp_io_len(Object *obj, Visitor *v,
     visit_type_uint16(v, name, &io_len, errp);
 }
 
-static void piix4_pm_add_properties(PIIX4PMState *s)
+static void piix4_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ACPI_DISABLE;
@@ -434,18 +444,20 @@ static void piix4_pm_add_properties(PIIX4PMState *s)
     static const uint32_t gpe0_blk_len = GPE_LEN;
     static const uint16_t sci_int = 9;
 
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
-                                  &gpe0_blk, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
-                                  &gpe0_blk_len, OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
-                                  &sci_int, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                  &s->io_base, OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                        &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                        &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_GPE0_BLK,
+                                         &gpe0_blk, OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_GPE0_BLK_LEN,
+                                         &gpe0_blk_len, OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(oc, ACPI_PM_PROP_SCI_INT,
+                                         &sci_int, OBJ_PROP_FLAG_READ);
+    object_class_property_add(oc, ACPI_PM_PROP_PM_IO_BASE, "uint32",
+                              piix4_pm_get_io_base,
+                              NULL,
+                              NULL, NULL);
 }
 
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
@@ -501,8 +513,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
 
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
-
-    piix4_pm_add_properties(s);
 }
 
 static void piix4_pm_init(Object *obj)
@@ -637,6 +647,8 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
                               piix4_pm_get_pcihp_io_len,
                               NULL,
                               NULL, NULL);
+
+    piix4_pm_add_class_properties(klass);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


