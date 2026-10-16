Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04355CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiq1-00049X-12; Fri, 16 Oct 2026 10:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHip6-000340-SC
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:22 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHip4-0006kc-J1
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:22:16 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5G7J3551949; Fri, 16 Oct 2026 07:22:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aSoQnzPVPKCptsUfYQKIegr73fefTWafbQ2RSswwh
 KA=; b=vkAco6d7o43f8AP4p16DppFGsnuJz4Wg0pFzvWt7LJmsl82vNRnGRaGR3
 aqUytr8K6PTZVL6aM7zZ/maX3COHXMo702E06/XZiq4MJ0cmhAfudk60qvi4iVeB
 pYBRgHjqZNuMQFYFt2qqUMn0rn8fvORpeY4UN3ZeBopWReVh+P7qzPNJPWFEXQ89
 bj07W4xMqMACBJ57Kcdh0VW8VaAQH/t2pnfPrBO5EK5xtstZnchFEBF2Veub7NQw
 kJWwjXqzlT47Ii+i0crAqGhkU4uN6OlOEMDIY9kbizSU/jP/65cNkeUYT3vFOoWa
 lzpRtsTgxdwuw23Z5NErB/bC7XSnQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022137.outbound.protection.outlook.com [52.101.53.137])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hbmjc04ym-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KY7DLngDo8hpl0Anym4YXCv3s0cVTp7HY5x3nufUho94b2D1WdXCmu63chw+Qpx/bbGroJDhTTUYiw0mi7ihTWkZDw613QoKb+m2y5m/bAocf0s3GWSrHg5HS3Er7/y1hnvLqGJx6aEA3XXmtnM7pqxvmRXGQDkWMQOjf10sSwUJ7XxBFMc11mL4iy1IzOHV1F7U7YtcxM0VNNX7rmmjUsEpwzbIMrV1+2t748jw+Y1MDrayKqu+oB6RdBnbT5dJE2jyzgHANtFvvA09BgueMlAbE5sHBw4V0rZmZttmwnKVq4USx8iSlMHyjLFsgL6yroSV/mEigOcMvRHklyN/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSoQnzPVPKCptsUfYQKIegr73fefTWafbQ2RSswwhKA=;
 b=hh6OVtxpLFTtSFFEKtZwcrSma5psJcQhPFZKhpA3DVRHFCieSldTtd183516qN1x4e17Qe7nnDxoPLxVPiOarLeBSTmU9xyjCUSvRWrmDtzBynbKL4rncndsKhHwZrgfg7VsGKRPtughWh+w1XlwxWESDGKoFP1J/q10tzEav26xn/vv1WSWm0hW9Cno0C4poTjvGIc7TqD4obhpvTpL1ydCY3zHfl0KLh3RNprzTRltuyB/PiczVw5q4SCdrPDl72fq8Ez3dRp9dWQyb307RG98KqNFNxI6maej2VPmIQVWrY6wkmG72t0MNXwQTbUwWh1UrekSDaRyg58ZiO4Ixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSoQnzPVPKCptsUfYQKIegr73fefTWafbQ2RSswwhKA=;
 b=SMuySsvMwJxnIw0Z6qAGvLJJ6YbPn82TtozZW3CY3wp88ZIzHqsUtuGQr5aXxCprKjdYF4Z0BxO/7qH/L0nid7MiCV/bcwwYdZYa1Q6Vs8rklrQ7hxBF4K0glz9y9ob1lrhHtB6+7l3kaV72QupfaCO1KWy2Atiz7AZbeg0v5CmoJVf8iTko4akWEENSVyWEn5peut0+rh2tq50OvSQdyzUzghz5XAG/Jb0vVmbRzP7Xi1A+jRm7VziwmxbR8RD2rlP86Igwzsy4L6mO5KPHW2JCSg5STc4ZpwHNGsh/JTY7QXz9MZmXbS9LU/ZlhbTjU/CrD7f2OCpKm1K8dhW5rw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9592.namprd02.prod.outlook.com (2603:10b6:208:3f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 14:22:05 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:22:03 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 21/27] xen-hvm.c: rename xen_interrupt_controller_init() to
 xen_i8259_init()
Date: Fri, 16 Oct 2026 15:19:27 +0100
Message-ID: <20261016142031.1204281-22-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: b0553bcc-60bf-4ab2-f69f-08df2b90d94e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MnXqs3CIcxDGUcSn9MkKNbshtP4yfSjslKriu0p10v+WnKywAKuORuRjXOEi5TbKsrw43rjc4yolrMKvGD4zRX8OmkHA8dWdtE9jDGvhiIrFla5poISGjE5oyqOImdwUyf6lkt+VicRzCpokR3/GO2rhbrlg4fCDikK4BotKVKKD/LOaOEpCG3lm+YO20J8xFKjC8/ZS24eU5ukY91C5B8lvi3BqZGrdpusV98QrdeO0BZFTS1EyZbtAYy+UIlwijvwW79BQIPM66Loko7ibeX3AH+AOso/HrdRGA32xTDSpm42t3BSZRD0MEZPZa1ZNShhFYUxXPB3W81i3Tz3ra3/stph9CK6MtEjmb+vokt3lGUqfVD/29sP32yYIujSdRfKz0CNVesSILEEnRVHsyPOj5FaHWsEk+spmwaZgwTK3bWk1pGmGgRmAiZLpkdhVlZrBd2cJggUTP5C4ESczOscdVha+etpgLsOj3G+8I5M16oY4p5SIl7U39P0Bf5i6LZInUY7lAHCNwxigvgmqyxhCz58/E5kv8+pl3mou3TRpzPgM/Tc/0OnQO31e4KqyfrqL2eaCbh0l0QrkPFtSqVD+b4tuwKYimo1dgo7+UMBJO89tGZ4xMKhOXRSmvdHtR/HtXglK4ymzw096kgrApQKqx/QeH8k1ML6YygDknM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bXCUn+1o1IpiNx3jsc7l0PRyalnu65mP/DnQIJJwgljUysbkmsKnX33xuOfC?=
 =?us-ascii?Q?yHuCevbPnKBsIyQ3esBe8gmp51yeyfJDxZIeC+QW4fQeLWEHNfxg9Q78CNKQ?=
 =?us-ascii?Q?B7r+QGG0z6unSG5WON68pi5xuUr0FA/1PGkVyULgD8omkyEbXRz6WoFuFolb?=
 =?us-ascii?Q?qJTzpuaak32sNBL00MsbcL7RJFIlv7sA6IIJQRRG2jUwrLVLYLMCOzor3Hho?=
 =?us-ascii?Q?u6pfTYQXwH89Q5YIpAe/xQ6eoGtSQMKjS8wOv2zCWz5E5ZjOPl2zbXBBfjz8?=
 =?us-ascii?Q?scSRC1c+O9Q9b5bhZmwaL9gcgWPbwIFVmQy8tsLkuiyXn2/CXoM7MEaN6TJ6?=
 =?us-ascii?Q?ZeeZLobu3P/PZEKzvAuz77xTbw3+WyZXBrBm/xUs4cKD5BoSUv4mm+wKXIO7?=
 =?us-ascii?Q?k38cVoUQFKgpt2XNuSYcB0rG0DWADqWMJfHP5Nsjo4wKNUFMxfzxtYx8FGII?=
 =?us-ascii?Q?nQsDd4BAyQyc67j/1NorH7SWzRe33P3svoJKgbJP5P01hZiYsLi0pNr2yjsb?=
 =?us-ascii?Q?F0I3kOtoS1+M37gfC7LkT3xPdaUZWqGyGGxNirNJ3W3aF+EZd3GZMoyvHiKs?=
 =?us-ascii?Q?Ptm6VS4QHw7nMLgYtWoDAstyrEy9uf6MwZXCtI0bX1EFrZ+BmZDEmmkxF8K8?=
 =?us-ascii?Q?lCkalgV+PphvMMmfaltuN7+j7FrMgfWYqU6slgqKCYKLhHprpjTiswxJrfOX?=
 =?us-ascii?Q?GrCzC0zJKcCU1ewlaADh/DvIuDCDy4hy9jCA1d4OlRd9D4bNrlRzMj2eajXZ?=
 =?us-ascii?Q?6p0aa4XpMtvCAaq3PDkmTA6CYGK7KmuDbln8WIwv7gdusaP/x4jNe4RDC4vs?=
 =?us-ascii?Q?GA5B9uZ3qKAiurYrm/vf/iWVjTfv7V7Zng2np1fyh5Qs2RCt/dCCXTl0ESE+?=
 =?us-ascii?Q?atD+XYA8nqgc6D/6IFgdrjK8CXkdSVR9LsNQIUhYPNObRv7QxB6XXq0blQOh?=
 =?us-ascii?Q?v3UMfv86SB8u8R8UUaitzwKKkhxu07tDXgru3msMlJLFsn8mQAZCs0UbzJcI?=
 =?us-ascii?Q?o6mAAi5DWT+ZzsCheRHdhBJQMEWye32j74Km8eUFXHHaWw2CpP0gRcSAewhK?=
 =?us-ascii?Q?fxxE0YEBQeKjBLe/UckcWzBb+RR4wiT/NRO1Kxb928VopMaD0kR7YMxi+gnl?=
 =?us-ascii?Q?DmmwvLpvf3aIeiVt+vAZpy+Kjh6NYLx1X/gcdJT7yu7ZqmVW7sHZ1lCMOMUC?=
 =?us-ascii?Q?+EgJmV/iccb+jBv+y6/OCdVoemlDQFITFrU8SNxzx7bKO+jBts1eIYCJ+PLF?=
 =?us-ascii?Q?5vYHJUyGzGHaIesaGujT6/RbhoagF4KYIdlaegDX85A8+Bcrz07x99HpT69s?=
 =?us-ascii?Q?zP9iD2VIa0kC0JNBoqOE/zDJQdbThKIeBIcdlchbX5ebYW/z63BxBOJhLqDw?=
 =?us-ascii?Q?PDE6rDZcv8aA6IIVIlE3fBp8Nvj4bgw/Pvii5FHjDU9gKzQBWFPxOCNzwnuC?=
 =?us-ascii?Q?StCrqKEN0Hw8CcD4sudWSq8Q6K1GxrFotT7KMyhPcLx8uv6vVIsLOv0JFLK3?=
 =?us-ascii?Q?oHidki/KUujvhCPS1QsaiyubHiC3MtG204521fpYvhBQTGxGOjdAhXUNjS/C?=
 =?us-ascii?Q?ryTWZYMoZnIG7hLGL9/+ADlQUmDxYkzb8WbJ8la7MPL/3APYHShUqrgGFzxO?=
 =?us-ascii?Q?dCHVYkZfOLpvZ9hljJzeX5vflT+UvPh2DbA7h1nq7WQo/tKUkO1b3r7oUjnV?=
 =?us-ascii?Q?eJQ9QA9b8bumwCAhTjnK3w2VoGnlMKENxui0Vah6wBYHEK3XoH1qaiOBqpa0?=
 =?us-ascii?Q?vE5MBM28w8Mhyx0UjEtduRVfkBGsFb4=3D?=
X-Exchange-RoutingPolicyChecked: FX0tCw4TYGJ3DRo4NiMp+yOdaNqqbhlrnQ4W/KagyussV6cUnhoDuRHYmHucmu+x+wepGaXR1ajxylM4pK2iNohKu5sq/lKp+uPvZKFs+kglyJYxBDshmENLW8xQElewONJ7kwsXKBmXpoBaCAY+r0TcrR0j7InZZ/eVkpem1CvDfBQ8fPVfUfi14u/2PQQQgA3vAHiRScHMtK2HsjI0jrNIzCnQay2vt5fyroSJBPSCsiBptwSeLmbwG06XqjDn4/Rr3K4ZP/aaAT15zq0gaLZHbwjDK/Rzp++kc86X1HRnYu5acsLkyeV+tVSWYHN7rep9C/5uaSO0A50N3Qceqw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0553bcc-60bf-4ab2-f69f-08df2b90d94e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:22:03.5699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjhzjaMP7tW7a/EuJp5Cf6d9yXMFvXxigQHFmkHgyl+ipz+WTazTj5A+nUiPFreONEtfpkfZDi7f4LLW/Y1dU5t6c0+BVZRYaYD8Mk2V/P8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9592
X-Authority-Analysis: v=2.4 cv=dasVTnXe c=1 sm=1 tr=0 ts=6ad23310 cx=c_pps
 a=XMkfF010lpKDMmMg3xIHFw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=ufYRZG4kn_nPcl-B8swA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX/15dpH6RJmRN
 FwwoPyPOX9/HITiYv0s9SAmwea12y6nHOPs5WLCLqe0erKxYbp8kvaKvDmonRW9nBMy27QR5cpp
 pLmX0WxDwxxpvTRFOQcP1KNGBxi2ZevqpM19SsOBWCjehZZlT0CdnWHCaKiYsnRoDz9BdSOyvyD
 6XNq25EMCAG9UogwsTganewXa6+4A1tpQP3Bqz2KqeTk6G/8frXa11djaaN5Z8gn3I/v6Q+Kcs9
 8+VwVxwj9hS++aoqr8gbGiJ8FShG7CycbY8mTXYD1GBLfEqefjUkYCzBpJlDgRmp1lGblw/ppg2
 EfG+iqu8hB26a+EH5U2LGOVeCGoWnapxo2RoUgPUPxvF1uHaB9LhGmd1AyZ3jzmwRlFu4rabM9f
 ymqM5jPohYRYSSqPTQgnT9noVTrWTwEXnnvpFVCp/dVWul2NdJiB28RxW24rb1v3na+FAUVrGir
 80C+yw3HUImqwNsQoTA==
X-Proofpoint-GUID: F0rQwAs9UDk2jRV65-XabXt6yg0qkyRR
X-Proofpoint-ORIG-GUID: F0rQwAs9UDk2jRV65-XabXt6yg0qkyRR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX9blZG0h6UF/c
 ZtyP8XTH5atsm/y8v1dyOVzlTTjp7YGXyiNfY3ng6hsNKHbmEloQbUmsnVsXlXzbTLWL4rpO90Y
 LxjyP0fF3j7XTtbulMccsqcJiJ0FKyM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

This clarifies that the interrupt controller being modelled is an emulated
i8259 implementation, and brings the naming convention in line with the
in-built i8259 and KVM i8259 implementations.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/xen/xen.h  | 2 +-
 hw/i386/pc.c          | 2 +-
 hw/i386/xen/xen-hvm.c | 2 +-
 stubs/xen-hw-stub.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index e94c6e5a31..ee4ed4f11b 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -42,7 +42,7 @@ void xen_intx_set_irq(void *opaque, int irq_num, int level);
 void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
 int xen_is_pirq_msi(uint32_t msi_data);
 
-qemu_irq *xen_interrupt_controller_init(void);
+qemu_irq *xen_i8259_init(void);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2d8c87b0e3..dbfd55de30 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1167,7 +1167,7 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
     if (kvm_pic_in_kernel()) {
         i8259 = kvm_i8259_init(isa_bus);
     } else if (xen_enabled()) {
-        i8259 = xen_interrupt_controller_init();
+        i8259 = xen_i8259_init();
     } else {
         i8259 = i8259_init(isa_bus, x86_allocate_cpu_irq());
     }
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d3ce082e07..af3a90987c 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -112,7 +112,7 @@ static void xen_set_irq(void *opaque, int irq, int level)
     xen_set_isa_irq_level(xen_domid, irq, level);
 }
 
-qemu_irq *xen_interrupt_controller_init(void)
+qemu_irq *xen_i8259_init(void)
 {
     return qemu_allocate_irqs(xen_set_irq, NULL, 16);
 }
diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index 6cf0e9a4c1..b3e27f0292 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -29,7 +29,7 @@ int xen_is_pirq_msi(uint32_t msi_data)
     return 0;
 }
 
-qemu_irq *xen_interrupt_controller_init(void)
+qemu_irq *xen_i8259_init(void)
 {
     return NULL;
 }
-- 
2.43.0


