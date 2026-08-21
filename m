Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19905C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNEc-0006jQ-Oz; Fri, 21 Aug 2026 07:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEa-0006iK-PJ; Fri, 21 Aug 2026 07:16:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEY-0002Dy-Ur; Fri, 21 Aug 2026 07:16:28 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9PQ8E1872098; Fri, 21 Aug 2026 04:16:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QKFl5ha0SmKTt8JpgZvNaEhuRK609N0Nu90aJcCTs
 Mo=; b=uZHoJbt25WBXxsyKSJWyRaEO0iZP3nLOrOc6FdlCfBmjR6K8gsCbAldaU
 LBpzMDb7zYDXW+lgjvF8xB17HxnDq635lN4E9JV+7/zmcu4OeWaoj4dY0wzJixCr
 Fun0BCaTmLiKPeYSDJ16qpWXzHFKJ44wcFrEkcmI+17FGf2ktFIuuZpzmQOysccT
 q22aqozSYnWhCL1gQsa3qCJwZWuEdWwCG6rF+XmxpLskR7tGXVHJAFgUtPrCjTPS
 k9FZhiP1Dg4PZPVY8TPa4ztPSe83J1m8huwZEWYF+632Yya9nyA6HA+aQJB/6DmW
 f/LodltTPRwhD9/hPYXKlp85yM8nA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020137.outbound.protection.outlook.com [52.101.85.137])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6aw696he-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkNniLDmknvGTitJ7/RJQQxdUV8NQRJcx7LDzGbe2iX4jPpsy0TTNpBtAbbL52Aoy/pRIUruJCbPIDxUFINMouHqw3U+vP42lIUU/IS0y8qY7Q/tUxfkvyvzaITv9PEHb5EvG+MK1QpiKWjnRBpHWBf3rzMzVCIvJxiFvtllYkliSB/JR5BUeI2+rK2GaZ85rEyryrLNGxFOT4B5qa12TMaJem4ymnHWJHdu1U+0OHo7uF6bPLDXyBTxkc0S7OZqu9OCXz+cDX7hPNqF3h0tvkqlcEWoOO0LAx9/GaHFFAK4ZfKlxU6CyfVCova5s6SEHik5bWKi08vZLV7NvzxuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKFl5ha0SmKTt8JpgZvNaEhuRK609N0Nu90aJcCTsMo=;
 b=H0z0LjVnkf5rUdKwZYYqaA4H92G5TItjP9Kj5X5tAXh/uQT8scLXA1ttyng6Jt0qj2pLo1sFDVp5WekmG8swgma7NwN7NJN7uc7PFRCuaS0hSWK+aSiH0xOhiHbYgmK3QRYl+25sj3qxEWOnCQX0sBppnNK4hRm1c4CDh5C+0OcZjp066wLp1GxwxPso1dSkkxyteIq3Kcheqjqwc7pN3DH05qo8l0SoUCW4KNYO6TI3jJyEx4o7FiE8ZX4GAw94P6dHfTTj3N56IUqveHYleXWrxPCAaZ/VWZV7K4ptQh/oCBu8pFyy9ttJZ1xm7dkwLAFHxSWGrDmxILpPEeCOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKFl5ha0SmKTt8JpgZvNaEhuRK609N0Nu90aJcCTsMo=;
 b=YK7Ek8+QO3Knre1Y+kTRJHOI3I+CeILWlmu/+SQ0zIfGplLlOaj5v07igmVtsMxMnA0/sCpZRMNMIMNG3w1udWkzLT461EeE+JYOt8pPQVEmSM1mN9FVfwhU9HfAwMQyLQckrQ42GTp1nJ4mI7yi29U9tfY/DReIGqY/pV/b2X9Eg6rzI85XMt13X1yH04OMix+orvEJKWYBAsBY95GFADaQOJ7xb+/4eaSECKLrvDUaJDVOsll87vgRJQC0Na0JjwUVkuJazKF0G8yTVRGyLnoYS446rQpVO9R40UXxlzPtNqSI1zms9V2LFSDKkSjsd1QSfkJgKKxOVNMo/6XvNg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:14 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 06/16] hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object
 props to class props
Date: Fri, 21 Aug 2026 12:14:18 +0100
Message-ID: <20260821111550.276011-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:806:125::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c624a8a-79a5-4e01-7d0a-08deff759ca9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: 2/4hEwhQJgS7p2phBYY7PJki0VcWt+uMdypNpPb2CQkvu77UeJv40eBg90tpUrdn/Q+/h3Bn7C6/rYxQS0phHLGarXQ44+lo8s8ABh5sZkqkWhJ8Np7PoFfxkYsRLxyUNJymhlMNNr43jZj4T0o64I0iCOVTqOuzDRP2uWvsyB/QAko+fdUmMszt+IfhRvDDNi+1U+cp5QlZmga+eaTKQAMQKVvDKGZ2IinrgbkwTXY84QN6wUUrw8hWW3lHXrU+ZDBsvwACoAPFUfZzCjz84C+aFm5ArRBg3sFcsdlB5cmeJ1uqvGj2H2o5CVSFIme7ITidw6shxNWWCT/JtH4z1rIcjajkSfKjOYCZ14524yg5KyGaVAJyct8/09zi3kLw2uBHlaqSWakJRMckcnKJlBPEugXb+J+pCfkWfXZnIbQizsajHxa7VFaKenLlY2tgbBSSVPmM8ZvtLghTnD7bk8bNhV0N4Gpv33+jYJfuSYMlaaS9Qj5T+sKpRFhWAaMhcUvOj6r4VcpLqO3hJjsx8ncmdnegqeTqsIoYe/sgte2C3uZ0upCxLFpglTXqbGpemGd5SBQaMBjnFfYR/M0GCa29tWylnxk8eEIgxEiYhu9Wh+oK+EULr3smPVze29nQYmXRoz8pAYeafK6cK9Ar3yEeLAEARPbUFTqgkxajZHHsD+5I403ihfJCeN6siauVCv77DN81Rfk+OHj21ZjtdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dNF8yX+26W/FFOqlPzI6wbA4J+lesk75x6cb4rWZ4Uz22CMM0kNn9if72jIF?=
 =?us-ascii?Q?bBOwB09Htl20TsJh5BTk+kybMWqTm4Rt19TvwtEqL9iqu0T1Z7OQ+U97OC62?=
 =?us-ascii?Q?J3GTsPdSJmkcC1Q7TGrFZoNVnupZcAwkhQhjIkQVQja/cNhtrbXTrhicYZSB?=
 =?us-ascii?Q?+t2N/35xDG3uRSZFzTZAuFig3bU8u0wanHGvCZ0TOQeRP44d++J+x5zxYgBA?=
 =?us-ascii?Q?I9w13TogBcWOw6EER1qK3eJ3KJX+0JhyycFr0+whhFp5dsUZayD4LrleybzI?=
 =?us-ascii?Q?ES8a8VTjfaDCSFhAT1cz0kC1XXGO/ygW6fEFq4gZLkN7m2HX6VHrkXWQ5otf?=
 =?us-ascii?Q?USrWC6/uytQtfbqh9eKsWciD24eoGBMHBxV/qmZGYQxmlFXS7NRj5llQeK77?=
 =?us-ascii?Q?O+Fk7jrTLkm7KFzJ+sw0Fo0KN3YfbHNDrZ+S/SqH2xriVa8cr+APR3oY6+/n?=
 =?us-ascii?Q?3NkzqhWx3nHe2sFGP+XciULCY8g8T5P9eo1JLaHj1pr9XSV3F6CE6t0LW7Z8?=
 =?us-ascii?Q?NQLA1cOvYSUCcQBg5rS2Luaq9fGW542Hr8sbMbya4xmNPGEgP95wQFDbQA/x?=
 =?us-ascii?Q?Oh8ks5H/7Zv9twGl6Smch0G+C/omGc1TohDoxm33ENGrdZ3/H/NXbAx89uDl?=
 =?us-ascii?Q?njkDpCtwqoxrj0mNQegGO4pO2Ss39C5rX+76gMFNa5c/5D9D8yMJn1rHkmqb?=
 =?us-ascii?Q?Fd/9RtqbKL/8WySWR/zU+wCKgUyEjU7cNixNG1x7IklHzo9uN5m0iHW4vzmm?=
 =?us-ascii?Q?WM4b1JTp6DZ+s3VoJpo8lL7L173nYoT8HxSDBzGukmG72fK3DPFyEv9z7JOJ?=
 =?us-ascii?Q?H3PuvtDotfEBWf7IIcWfoiDrNmWF3yCNMD7Zrk4pa1iQFZAfExNJGEhznHdt?=
 =?us-ascii?Q?TqYu9CVAJuVv0WcwGqou/JgUcOCvXczlZcmmRpDqZsYJYZ8aJjZT+k5f5oXm?=
 =?us-ascii?Q?fmZbptzgFL9RL6wKJSm5vBOFCSbB3qX5FZIB1/L0gwp3hg6nyFnnkVVyrgVP?=
 =?us-ascii?Q?ifM6frZNAUWQtnoW167ccrm1gI2XWHgkUiz+h2yMLGL0HGYjdrE6vWjtXgcG?=
 =?us-ascii?Q?yoLrLsqDTYYtI9Vd5dQcoJOzYhVWWeRXpjixZE4nufkAeFtKOwEHH3LBEdqw?=
 =?us-ascii?Q?K8jm4whHA9a2v63MCD9wr2H8x+sceJYWXJDUolyK/Gz1bLl/FCR2oQgmfbqU?=
 =?us-ascii?Q?l530tk+U4V6jHRzk+nfCq+M/l3nJnvsyrgnpdpBPZi1X2whn+qN2fLUe4M3n?=
 =?us-ascii?Q?rlQWLfxxfSbsczj870rMISfmglfqXGBS9uuomoQD1SAmGk/t25bwr+Hz4M8D?=
 =?us-ascii?Q?Q9Paq5Ihf9k6MNoSGYnSswp1E5owtHVG4KrKmLyTzWkwvEwhUPbepYEtS3HI?=
 =?us-ascii?Q?4UoGkhFp3WYliTwnv4FbjhY922BSsKatL3vmQWndTxlOaaiTwDzu5CJOTaZp?=
 =?us-ascii?Q?o37OxbL31knytQF/E9S611NJnpdvpENSxnRuy3IuRE78q4G7PmPHLrZ8AYIS?=
 =?us-ascii?Q?2xZ1MIMJ0L+XuNK47B89Y+CuSE0UEZmKm9OSdYFhVPZ2fvxWk4gmW2LkoOw+?=
 =?us-ascii?Q?MqDDHRNTIpvuOL3tn+Z9o5BXE0qU5zkJm4JHiUQUs0hUsHD2uYZPisvnHz6J?=
 =?us-ascii?Q?5W8eJiEd+CiH//5wr+b6LaP3OnkMw2gCM3r2aCsbTK2NRTt4gEC4w8hC6FY3?=
 =?us-ascii?Q?60xDln6NZ5bM3WlgFf/i+OIV4J1VhF6eWOpX01wu3Zfm0GfmEPMadd0ja8ej?=
 =?us-ascii?Q?C+KBl9INT+SmOmXMT2PIs/7ZkNis7Ls=3D?=
X-Exchange-RoutingPolicyChecked: WcpzokCsBYGmgXkvu9yG3MTmf0cshXIQV5IEJjHm3kOs9xEGuPC+4shMQ7IDxWK96Cict4jlSmsK7whtTUjn5KddkKe3kISTOedFA0LiTTLoqgMOqZQBnmBC8bTSNhGwUCgC2uSY1byXjMK8xc4McJESXl+QWFQ2A10May+r5pBVErlsdgx9bWqfPsUGTKhiVS4w87IZADrmV3H48eQpQlr0nBg3p0ELqxLqos2VJvzlqvdxIy7l/HUyjar6mEUoLvQLNRp2RpEgbnU/KMNC9zbPkeNJFngwTMY7HPauWi0c7FIiMVH7ZaGPBG1US+KV7bLRMjvKeQ1kMmYJqxaWKw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c624a8a-79a5-4e01-7d0a-08deff759ca9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:13.9540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19Yk4zOA25zC7LPkcb5fh446RlNPpPkyZyBDslm+4YzTL6fsEqtu0kt4Gjegl2FHvRHnD9mMOJXoUxhYuaM+NucCu6fTO08iJflwlUTlAuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Authority-Analysis: v=2.4 cv=PdDPQChd c=1 sm=1 tr=0 ts=6a88337f cx=c_pps
 a=1umFaVqrme/hcr+f+MpLMA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=oOh_xqB7XwJDYdBhmPMA:9
X-Proofpoint-GUID: hkPkANreo5xgYvccw7f5PrXqILq1G6OL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX9LTCuvthgmKZ
 YhJ2g8Xc6IwLb/JdGklvJpCMXcdU8tGY/0Vg/NoC+2mOFRK8lgslo9CAZoIsCp1PBBhDlA9v9rp
 NsPrGFC59mGesoGs3+CEzBd9QgeqYR9Pb3kkekBSeP6rhAc3pFnfVjOGyWC6GXNs7SZm+VYvrF8
 eRqY8kxIboAbpJM4NQBLmz09pWmFg70j+2uq0EKtHd+Rs4zu6CrTHp0MlKwgs11vwxeC0c993bi
 Ufvfwo9W72KV1rw8TcKQjN1ptCxLqejdI/eKRGINF0D49HtG/QBEUaMPNw0KeAp1GE2Xvj6lKXO
 I+aSoEsJ6BsKDN5KQtY0SgeIPubhQQkk4cWtD9+0a/f5YtADnuTV0fcHnQkIrGHYQ0Ofj4eu0/o
 B4vrlea8UODe4OFKu89hX/C0ZyrkYROHmEfqdP1d0KLNfVuBe9YW+Ow7AtBu7lyrBf8EOSLumhi
 h0cup9N4surT4n5BxGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfXx0eUOnB3nnHY
 FKxf4XvsoPMQgl3QlWikw9Jhlg6JecHkllzW9qUJbCx6qSXVZhjGoVVuihzhK1a4nUThrdfN90X
 zlz0nNvK0da+BlmMIC5ecEbdekPXhtU=
X-Proofpoint-ORIG-GUID: hkPkANreo5xgYvccw7f5PrXqILq1G6OL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

ACPI_PM_PROP_SCI_INT can be updated to use object_class_property_add_uint8_ptr()
with OBJ_PROP_FLAG_READ, whilst ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP can be updated
to use object_class_property_add_uint64_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/isa/lpc_ich9.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index edf9783ec8..07c9509cf4 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -683,24 +683,11 @@ static void ich9_lpc_initfn(Object *obj)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
 
-    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
-    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
-
     object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
 
     qdev_init_gpio_out_named(DEVICE(lpc), lpc->gsi, ICH9_GPIO_GSI,
                              IOAPIC_NUM_PINS);
 
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
-                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint64_ptr(obj, ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
-                                   &lpc->smi_negotiated_features,
-                                   OBJ_PROP_FLAG_READ);
-
     ich9_pm_reset_properties(&lpc->pm);
     ich9_pm_add_properties(obj, &lpc->pm);
 }
@@ -888,6 +875,9 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(klass);
     AcpiDevAmlIfClass *amldevc = ACPI_DEV_AML_IF_CLASS(klass);
 
+    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
+    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
+
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_legacy_reset(dc, ich9_lpc_reset);
     k->realize = ich9_lpc_realize;
@@ -912,6 +902,23 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
     amldevc->build_dev_aml = build_ich9_isa_aml;
+
+    object_class_property_add_uint8_ptr(klass, ACPI_PM_PROP_SCI_INT,
+                                        offsetof(ICH9LPCState, sci_gsi),
+                                        OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint64_ptr(klass,
+                                         ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
+                                         offsetof(ICH9LPCState,
+                                                  smi_negotiated_features),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(klass,
+                                               ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                               &acpi_enable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(klass,
+                                               ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                               &acpi_disable_cmd,
+                                               OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


