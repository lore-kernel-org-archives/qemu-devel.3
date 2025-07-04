Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6610C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh7c-0000h0-5S; Fri, 04 Jul 2025 10:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7Z-0000ga-8l
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7X-0004cY-D1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:32 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564C0wd8009938;
 Fri, 4 Jul 2025 07:10:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pPuDxY4QWTE7Efc+/14RO1CaZk+qNTAYIF/jv+iHM
 rI=; b=P2Sza43QI1G1Gg3bVakTKQLoVQt950xFXdofRCBjwgED8qcfKj8OPjpjh
 jweP9TToZL1udIy4+dM3/ToUrdUr6WI/M5S4gUie9miupwnjlBQR1xhJKBnnZfLY
 YdoUUsllZz+YHFplFViPBSHW7771uAVIGZG9174SOO4wcHJqWQrPwMZJwcxcHMpE
 BYQSPJx+85IeaWRKXALE2ckc7YHxJF7v+psTHlAONUpndAMedfzidH4tSZDEcV5K
 JZl5dkFnPEFIaPH0XuNfI4tpaIko4EZcC4i+4zLemAWBM7WRYRWKA7TtcooZeiPA
 DBjW9jPDGXO857PNM5fMEybwfgxhg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2091.outbound.protection.outlook.com [40.107.244.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47jfx10gd3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAaOzOaJzkoVj8MC2ZzQKmryIlUMJjjLlFa6Ajh647nu+1dUIYajmPuvi4EHHSrnkGMMJd0gsIWhIRfa1Ew6FunBZyp6MQFoOXwXp0si4E4eisCjOW5SaESufuAdodjYF3uWwTvc9xo8yU6ISmpPkulYHUKRFmLWEx17zeXDy51ThspoqvJgMUQztpeqwilQl10jpAoJ4+dr90MUL74nCb7stydAU/WSONcDwlvTixNGTjJUYru5N01KwHTFTBAlG8GltthxC4/UmkQVPt8Y1LeTvPc6dL3kfB0jaPO/s9l/LV2zwJgcjkx9iVPFOuvne6WkbHnU5pXGYZgST6Nl0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPuDxY4QWTE7Efc+/14RO1CaZk+qNTAYIF/jv+iHMrI=;
 b=fhDY+Y0hySyFWYJpGtGwrICr5jJJSP+SDD87mn0xQQzqcDSRrAdgw/Sc8279w7nGahiki/gr1Oe5HufdvmZRZIFtqioy4yeiZNyP56LTs8B3nlJf0T/+1JY7jeED9ApfUA4lGx0/9QTNBQtX642a2PfRZ0BHyp+3Y3oH9a1A5PK/cLtMp7suZFZt0hC35ffqj5cPZafb+32p8eSz9fcTrlo324Nvbt0nAS5zHM/HsYkX4O5WT0UxG06X6Rkq14Ajl1sOLyc8X04Ypz57K9RvCth037eUZz3gi/KRfQc7QMJhuZzszUd/IBUob96MWftI5PYgjniekPxkK6Q6xPPxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPuDxY4QWTE7Efc+/14RO1CaZk+qNTAYIF/jv+iHMrI=;
 b=U7OyjHLeBHvJueHagoK40WPBTSj6aicLbm28IL5dQJ8rIQEnHmULdzN7yqzhxn/OeBGqpeBLFYSyXBBiJFCQ1CSBDG7QJSL+WTbUyeJ1Z1FWZwIuqG4Z4/iF/bx7MCzMbGoV7MndZkFOUDYxiz+urn4L482yVwqA/TJQpaT1otDqCaHz+sarZpR9lJKOX6RG4gIlEE0/+Yguk0tYTsdyOxT4n396phkhInEIFkntbh/26Ktnn8Ph2ghdQwMG+QQhvLTB1t58ZLyavijnad6c88VV3Pam/yl6rb0b+v0TsCTp3wBA1sl+DTnaTZQO7SciPZAwgIygONgwmxGolOGzRQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8045.namprd02.prod.outlook.com (2603:10b6:408:16d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 14:10:25 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:10:25 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 01/14] hw/i386/pc_piix.c: restrict isapc machine to 32-bit
 CPUs
Date: Fri,  4 Jul 2025 15:09:28 +0100
Message-ID: <20250704141018.674268-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0151.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 442873ce-00da-45ef-733c-08ddbb0485bb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RT+aBgKs+T4iqL44Kp6BlfX/LFO54SRliD8A7MIZ/YbskToUQid64fXE/96s?=
 =?us-ascii?Q?6eQ3YYvKOQL42cMZcukLQIS+fZYLdwnOPBBcFvaohGNP7Fg/1rJFGX8o/ojz?=
 =?us-ascii?Q?kFkNMNs89PbM//Y9q+LVLG9agI2RPQDeT8DCP4+joOHMIgBPxjqTHHh1pSXL?=
 =?us-ascii?Q?RKPF+VIoZ8wsCmiVn+YrDeybObOCcCmT0R+7ABC57JfsdX82C3k6zPIVUogN?=
 =?us-ascii?Q?4DGJilSc8Crz0cO1PoBP2BcAyQHzMqmuCww4J2GoVpAg9vbY5ffiiB3/P3hG?=
 =?us-ascii?Q?RxJUTR5Edm+ErUbdbLJCN8AB5aT1Afl0HK/mxOk4RfY2Duq96Hud6V+Fi+/0?=
 =?us-ascii?Q?t/FaTUobz0WRVvbIK7Z2DqNfUgtrTFxkxL6jQabALXwLTcZaSiAzBm6iW8Ni?=
 =?us-ascii?Q?nCadJ9WweVfD5kglqU7woLjefmK8AqnQI7NoYJaqkzhgPo3Zox/gLABv0AGw?=
 =?us-ascii?Q?N78kVyD/HNf0r7tS6cfLY6cetKnKpST3oUlQQyn8gsE4SnPgePqrU30a6Ce/?=
 =?us-ascii?Q?Lvj34fqhgr00yiXL9rLmBPaPbIhzyQ4oV4zRKVdPr/NiX/8BzkN11Af/+jin?=
 =?us-ascii?Q?ubzl51P2QqEY4iidgJ2wNRPYnY+iJzSMtdTZmWu02+MO6U86Blorx23QorYQ?=
 =?us-ascii?Q?iF55bMbcQHppBsfIEsVeR2mcHIyxZRshxcI2bb3NpyQs49VcEe9eQE1YlrPr?=
 =?us-ascii?Q?hC/RBB+XCNwOJmnHchm8RJ124/7aLisiA9xnqj7WIo/U0/XopN4diJR0SAB7?=
 =?us-ascii?Q?YOxoLK43C1JAn1iYySPcvQB9bA5TjpXKb3wbKrkHxus+InCjF//A68T1kLM6?=
 =?us-ascii?Q?Gzv084j5i1LLRMcOf1cgo4DUZCg8abLI65igFu+6Ht8yLO60JWk3v6pneTBL?=
 =?us-ascii?Q?yOgOGPJk4fqQTv4KO5vYX+ueUesRSwkQDlUBZplyQHxbGx0ZvUBF7MUmF4YD?=
 =?us-ascii?Q?JXMQiPQhZbMr19Od+U+90TN9h0LvuaA5PDiHVtBzWgKzZeHAPjkappZN7gP3?=
 =?us-ascii?Q?xVjQ2F4CUZYL/C33Ov99XEz8y93XabYwU4Hb0Xc5rP38Ase/O65sRnxpMTQ9?=
 =?us-ascii?Q?o51jH4kz8b1BgaTAV+5eA9889lKQrq4gFgnaMJ5e3Cf0hxOTd/NjPiMHxcpD?=
 =?us-ascii?Q?ctlTL5sEzDlDdQo+ETLYN0shi8c0XEVEQhJ8+3k1+ORxMLQ2Jo+xroIHTbDa?=
 =?us-ascii?Q?USXaBMS4gMnsp9TQ7wqbjrzxzn/wMudfOkZGECd2jJvIWVuFXFu8Dztls4e4?=
 =?us-ascii?Q?/799j8CO4uM9iOdNEe9GkUO8/tbaoiorlBKmkdPx24SzoAzc4RogmJxo5z5p?=
 =?us-ascii?Q?VlFhBiu9tLLvqL44CQuSBZGUzjLkBqr0DJHUVBjdc6cz360TwNfg2bs59fBX?=
 =?us-ascii?Q?afaeDOZ/RfPWk/dxrKTdbGTIOCJsxLXYq+jNZnaUgCMUG76XoMTY55bbAIT2?=
 =?us-ascii?Q?9X2PiYpoX6E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rbiI9NxUf/I5pNjFECDoLUseV9yS9ocDO5rLFGVmCJdei+d3t7/k7q/o3mgw?=
 =?us-ascii?Q?ZNL4r+1Auf209FdMzlhPpa5kUyRJipXrdr3kr2QIs0GzgE4eRyKZg0lv46TB?=
 =?us-ascii?Q?Oq6KfqDH3wun+HhvA7Nt2OAtH7f82FAhWQzsURbsjC7kwbu30ZCn4R07Z1Qt?=
 =?us-ascii?Q?D38zw5BXx32W4R+zQAzYrIQ5bYfCr903OkaoJH9LW66wvw/Dac2dwSPAQAjV?=
 =?us-ascii?Q?Xofq1IGNiyXwZph7bsrwQsBWpTvrea1AE45mb9xUnE5XDVg6cyUMPBEl2QmK?=
 =?us-ascii?Q?DnO8/ruUnIlQGgoGo+dDbo+ST2FB+ma9KWRK9lW9l/XujZfmpA6wUmXD3CxT?=
 =?us-ascii?Q?4ZZO/kCmXOVRhbNLYREz6vAknl2Ar4sm8i1xDq9us08ONtOIN4zQyRwaJZRR?=
 =?us-ascii?Q?6V+KoKmbH6woBMHB5Aw5K6XWJTIaTQ8F2u2/ZQpoqM6rR8lEB+zxR9P8bEx6?=
 =?us-ascii?Q?nj3MuerJ7Xhj5JtsTHsYqDdxJbfrtyc3Ha7I/wsaVX6V+CEEsB2C0uFY4+xF?=
 =?us-ascii?Q?QrQjgpXkASkc5d/J3vi3ck4oqWIqjol1gjeBeKSAdm0GLOYf4RRKkmCfnBYm?=
 =?us-ascii?Q?wJ+Mxr+fiTcn/HaoJPQI3oJh8QunDLA4Er/YHTIQ1A4dIYVGHtmaQ5PIa0Qd?=
 =?us-ascii?Q?zOOz+VI5Wld2RnSvBTI91Q0tOvHVzMtthB4we2gqd2RvfElH5cjT9/FLLYvz?=
 =?us-ascii?Q?dOi+bzQAuhCZ4cL7ttJtoSlpzrk/XQDjjIrt8anDxf0I5WjPHWCfpcTwR4bU?=
 =?us-ascii?Q?2QcPbj0fwQ6f1ZYToT/V/ArrQ1IG9Ydlhx9350bjbr8NXvjBlkwL7P+08T7G?=
 =?us-ascii?Q?07PbZHlvpssV9NWUDHb3D7IF1gqP2DY8WgHD9Ja74VyM2kYCwL2VXV3ZIhT+?=
 =?us-ascii?Q?RQS9bulsdW+rwkllT6tk8njLNi5jRMAVksFnoom1YQOyT6GCU+iI0aRa0NkH?=
 =?us-ascii?Q?BAijkQUDhzcCt0CATDdyW0G40nh8FHdRVCuHy0s86pfmPhlgq7OEpqlluy/6?=
 =?us-ascii?Q?AvMi9mCzSHxMxmy9bqmxhXSKCXPX8i8UdPzgGvn4BZzZRbpbj4c1oe7bNoYk?=
 =?us-ascii?Q?DWwjdHDRAM6r3JwAd8YdzK3LMcMv0fpYDpDga7nKKizYnsNtcR6Tv8ksr3Ac?=
 =?us-ascii?Q?lGOWp+qT3Oi3JooJa7hIWpvxUbGYFGbdi7RGkFX6KPitMahOcOQyUCdsP40u?=
 =?us-ascii?Q?oku6Bak5OZA32m/NQf/IYSmweK8sBHBB94nBWUX7JJE+6Hu2PWRnw/eFMlHe?=
 =?us-ascii?Q?JJJlzAv7yzQk1VVUHuc/iS/tZSIexUyXspz505XWpYhfTxt0l1rh6cN9MCM3?=
 =?us-ascii?Q?csXBVKMByRomk4f+wTPXp7wiQJpPYB5OPqkIbvpboDXF9d6Ipo34cSBdYC3s?=
 =?us-ascii?Q?EBrK75LCaURDy2WLKh5rF4knTMC35aNFW25INsRLKyzikakrHqV9gNjbss4H?=
 =?us-ascii?Q?DvDttnmMIOgGC7VBby27IkCTsXPq1Mfi3Zrz7vXT3TQjiwvFyPthR+C4DS94?=
 =?us-ascii?Q?uspeMJ8B4bKNFekq/HxIQX8bBVlWoMtDX86N4byaNlj5dJ1nydqwPp94LIvC?=
 =?us-ascii?Q?IDi3saubVVKw9rR8qSMOtuL4/YGxeplccTIPKt5Mf5PR49cR9UiEQ5xOz5zI?=
 =?us-ascii?Q?PH6YYCbu3L2p8SpVKDiEf7kyNvTbFoxeiTryDP5KTroEETom/OD0oY3OnAj5?=
 =?us-ascii?Q?lTXWgA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442873ce-00da-45ef-733c-08ddbb0485bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:10:25.4986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDg2MEdVgEE1FjnLIj+I4UzWTfB1k4DsNPU88GRDc2u93RLKrB0E+5Y0uQ+REIbycHWK5o3ercvURgJtaEFyt8zphKFWrUfT7xv3ESdsgFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8045
X-Proofpoint-ORIG-GUID: JMZLHlhyImqV4BkE0Sd092khOQV9DA3x
X-Proofpoint-GUID: JMZLHlhyImqV4BkE0Sd092khOQV9DA3x
X-Authority-Analysis: v=2.4 cv=c4qrQQ9l c=1 sm=1 tr=0 ts=6867e0d3 cx=c_pps
 a=1grIbyKvDpWKlhKqFVAn8Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=nuetpX4ixqIVgyrW5aIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfX/pEhs+tPSbDy
 Y3gXBgnkK/fUC17dn+cy81+S3vkS4X5EQV7htXvsTeStVN5aSXAOvdNgbGHce8XLxiT41ZmEH2e
 9wMSz+xjAyaYZnD8aq48nOFX3PNVRQleghVBR+s+Vxtfv/6RSrjcRWOgc0wwObUgpSLWK9Q/bsP
 rrzOFooSBcdY3jwJSR1GJklV/ZbW0vdKItQTcX9dxOwe0Rw6Rplr1ybtbUKW+fopla52Y37iUQV
 PXXV5HoO+Mkt8OHmwnI9OwcphaaNQbER5vRH41r+2j7fcbSSopT9c+k3Qe3rcMFCnVgSGFWE3l3
 ISbGOEY8aq0bEmfXp57Y3SUQgYjD9a0MlHxbA5Tna4bby7PuVu6avK+FjclahOjjUZDEez0fuyY
 0N9n8mjb3ePr2hkMYAAg9xIgkrRR9ADrrSRnXocYALcEGKaxqunw4Z0CtcJR7cLw1fAnLe+6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
possible to specify any CPU via -cpu on the command line, it makes no
sense to allow modern 64-bit CPUs to be used.

Restrict the isapc machine to the available 32-bit CPUs, taking care to
handle the case where if a user inadvertently uses -cpu max then the "best"
32-bit CPU is used (in this case the pentium3).

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ea7572e783..67c52d79b2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -418,6 +418,18 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+    }
+
     pc_init1(machine, NULL);
 }
 #endif
@@ -786,7 +798,19 @@ DEFINE_I440FX_MACHINE(2, 6);
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        NULL
+    };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     m->desc = "ISA-only PC";
     m->max_cpus = 1;
     m->option_rom_has_mr = true;
@@ -799,6 +823,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
     m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
-- 
2.43.0


