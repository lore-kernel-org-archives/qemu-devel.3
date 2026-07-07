Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63040C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1H2-0003sn-Hz; Tue, 07 Jul 2026 04:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1H0-0003q0-7a; Tue, 07 Jul 2026 04:35:22 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gy-0008Pe-93; Tue, 07 Jul 2026 04:35:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1jhgsS2vyrocg3eRZ1A8KOnTVUG2Mg8AtD3vIpCkQ4ToErZfn+94YPTQMBPauk6A1vjdn+pmRn0IcEvgRBvnABankX2VUo40hz1voyGfeM8lzRlxVb4aIEaFrLFt3QdtEavXuPmM9KjTX4GasAcqX4FroPZfLk+ggGTlU3W/iDrFxqAHXtjw8GvUfX0yMTtv1DDMI8HuG0Bz4FMHOHl08x3DiZvE6BMP2xh3yPEmPeT8H96WOxEB6ZKCFnaNyNB0C2uyF+/a0nxPd/Yfu5DUI7pFUYrxF/zwMjNhsnE0JFfc7ukW3482T072tE25pzeKnp5qMPByJtYkWF41nPiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1w2aeUCGKqCAr5MuxiRUuc2L2LaMbHCV5Fuutid9E0=;
 b=S9221LXJ5bAYKTKhvksjducxCKkgc6i46dZSIMuFDe5YS1GkgA6ET2NCte9jNbcep1n/8zRnzqHdEH467mwf+0pH3PuAYT4UK8rNDXg8nyC4nyCqHOIX0yRsJlic/77mDcKSwE/LMbn9Xc/KaUIME8vE8DNOfZ5SZu32M9qHaYEwv0I5FCFnvTjAc0RypTqmG5U8qxPUDEg2w2XikQjo+Zu0Qrbi1trtfu7TCNJ3RoXIu4lDWODyemPodsKjwXl0/ipDMlejTREepTrg1rpY2YTYKjSsvEaxV3PXBxJ+oSY0QtWebDh1lwn1R1p6XYtVWYMPhRaJx6e/Op5cSpweyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1w2aeUCGKqCAr5MuxiRUuc2L2LaMbHCV5Fuutid9E0=;
 b=lC7zF/Al0byA4gbHdUGE/0HLmXDKORjevAbqPbq++VroVpsMnbS1WGJMSyQNjs6j7IcY3RsCZwvLh5dt1LTy2NMPj92vzs3jSXtBBk7/aAxBti00WJuXp3y29WlzzbuaeumSjc/w8gJ2lQ0RzXmG9yrsqBMSAiCZJG5HaGI9ncwIB1T8MxVztiaEfpeiFTQEQ6K2PXGsHt7uXygLjSeIcFmR32BMlx08chI8YBnUAlMzd8dWm0UYCDmxKvWWYbh62h/rk0aWLK0es7SbzQlmmGQlJWEzN3QKjrUcDumYg2S6eniIXPYQvJ+GNW+pkS3DA+VwcPijxGpX8kSvI0xnBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TY1PPF1A8DB1DA4.apcprd02.prod.outlook.com (2603:1096:408::94b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:35:13 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:35:13 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v2 09/10] Revert "aspeed/smc: snoop SPI transfers to fake
 dummy cycles"
Date: Tue,  7 Jul 2026 16:34:28 +0800
Message-ID: <20260707083431.219671-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707083431.219671-1-bin.meng@processmission.com>
References: <20260707083431.219671-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0106.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::6) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TY1PPF1A8DB1DA4:EE_
X-MS-Office365-Filtering-Correlation-Id: a27b6148-31c3-4499-9943-08dedc02aa01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|34096008|7416014|376014|1800799024|23010399003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GLivfzo8orlyu9xkv7GnqKmnomg89hDhTZP7Z2prHV858tL9NJdfvTZE4E6LWpvBSgQ9bMWjGiqI7fYkhlrfCUGLpNywzY91Y1FewCjctnCsyM6keprXiQ612A6PTMalsHFuQbGReGHc9ZQDpOOJDyJ1goOadLhComvJvRLKBBGs/W+Rm1KOx3qFKZlIc8wxKq+QLHB8fNmQX9echva9fWs+VsWNN8SefnwFWXxOH2esdyGgcU50ZDJ+JyoRPMFHMudrg4ZdCjFlpzhkGKjW6UrhZijvMXDMRGe85ZAuzI5vEE4/M1CcpT9+ZlPTPS2z1vmZaYD776pjyQK4LVGQrhLkQcg9A7XEgXmTm0Kqvh4OrcyjYWBofRWSRWQn+00CuXazoSIV24Y/Y2wj3rRmnQ5hRD8FKnaXyUx9g+MtBFcIQyvsHylzjuWmy5Li0NG+gGecKxytCZWZSjysAmDVfgHUZs+8w/gFBZ7xgAiizsheJ6+Z2jhSsbFKKCdMopw8a3banGqhIHelKH/WrbcTfrUSaM/0MPXIZWs2Lp8/EjSp9NzBtWvYfmwrd/gQPYXNBdvcxHC7hBe2IBhsZO2KDJ3VATAoPDZa2aRd/i21tBvK7reEI2Sa++EqSsuT/nP3n2m0a5iWOA0FKm/wwHNIeRQhmeJw+H0AFlyqbbrAipY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(34096008)(7416014)(376014)(1800799024)(23010399003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE45NFlRTGI4dDNsRE9ycEY4ekZ6dlVhVUM0ejc3c0l3K05TRkxrM0RyalFo?=
 =?utf-8?B?S0FyYUxzMk44WXBreGpKQmdQWHU4cWE2SVhlbndKc1FPWCtEaU9FejRuYmtR?=
 =?utf-8?B?bGlvbDdNNCs4dEpZZWhZVldmUEh5eEJqREVYMDIvTGxBNE9NOUVkeXNBdG9U?=
 =?utf-8?B?UmpHVUpSZjcvM0loNTZYdS91QkdUbEdSRDluY0VRTzlUZ1o3bC9TRUp6ZFgw?=
 =?utf-8?B?MHMxU1U4MDhZZlRvSUI4OXpuM2x1dTlvK3dZYmdtbHVNcCtLbm5aTVoycGdD?=
 =?utf-8?B?YXA5WEhMNUdZd0x6eWNoQThYTGpHODNNQVA3aStSSFlCdDZTUU9MT3lOQ1M1?=
 =?utf-8?B?WEhPVUdtS1JPWXRsalRZNmRiODF5MkIvTDVOZk01K1IxY3FiWDN4aENVbVVC?=
 =?utf-8?B?UWJBeEZRVFE1dE9CVmd0cU5lMUFudDhTdjg4cUdRbnA3STRLTWgzWjdWR2M1?=
 =?utf-8?B?V1BRUHFXYjdodGFQbGtRY2R3WXJYYXBFdDZPS09LQ1l3QzJRdHh3SWpTc3NG?=
 =?utf-8?B?aTRCZ0pWQ21kbFNaai9MdkNPeS9RY3Z6d1ExSDhuWG0vMW4rZ2FQM2crVnFS?=
 =?utf-8?B?UUVvUmY5MG1LVmI0WWlmejlKRzBJUjVTbmhYWTJ6elBBV293YllXSGpZNXhj?=
 =?utf-8?B?cUpUYlZNOXFFdThaeWR4TWgyeVRaLzFVQjR4YVhob3R0N2ovTThtWmNPVFgv?=
 =?utf-8?B?UTRkVGc5UDNKOGZZNVY0KzBoM28yaEpCL1lRdDdvSXlkMzU2NW1PYVJKdGln?=
 =?utf-8?B?WEZtdXZ4c0hKOWFXT3czZ3VkRGtVV053OGtUazRSd3ErZ2ZYSGxzRUg3ekpk?=
 =?utf-8?B?MFBuM1NFNXdkTllxbG9kcVcxWFBidytQTjYxa2F2TG1icHhSZGJtN2pmeWdp?=
 =?utf-8?B?WTduTXBhTXJqUXhIaGdycmVzRVJzS3p4N0ZYNCs4YXVmM01qb1ErTDE4SkF2?=
 =?utf-8?B?NCtpUjgwUEFZaVd4UEplTVM4elJmVzMxOXRSd3V5WE9yM2tXYzJYbHVxYjdW?=
 =?utf-8?B?MXdtQ1BhOGE4WXVYVjdGbUxJWkVuV0NINWhCeTBkVUxtbTFxWTFCZGc3RXhu?=
 =?utf-8?B?aWtCLytqWjlPejdxdldFYTNSYnUrcDFzUnBzaFR5elo3UlpFV3FFK21sUXFW?=
 =?utf-8?B?cXdDVCtqWG9nMWhYekZDeXU3OHlkKy81ZjlvcnJ4YUJZdy85aE1GRHZXeXM3?=
 =?utf-8?B?Q3kyNktzNEdtTmFYSzhIUHIyaENaMUF2UkliazMxVEUwck9XYk1WeForOFgx?=
 =?utf-8?B?RzdYeUF2czhYRk42OEZOeGo3Sy83QW5NRUN3SzY2Q29qN2dIK2kwbXJtWktV?=
 =?utf-8?B?YzMvWG1URWlZdEE1NklYQW4ydXZxUWV3cjd6NktsbkNyN3k5ZDJ5aUFDQ3Nv?=
 =?utf-8?B?V1UyK0NKWldTZDBKTk5kWThnODFZQldzSkIyeUIwK1p6ekRVM2loV0dBRk43?=
 =?utf-8?B?Zm11YjJhZ083RnhHOCtoWXN6RW90SmU5YTJhWjUrVnFVVzhhNDNTTTRoRksy?=
 =?utf-8?B?NEpnOEw0eEwzSHVBYjNXNUd4TlVkSHRuVzFEVjNlbmNhQWcyOUV3dEgyaysy?=
 =?utf-8?B?L0txalErY0VEVGV2bmxxSUlJNGJCUCtpUzhyK0E0a29TZUZzdTYrTitWSktW?=
 =?utf-8?B?eXd1MURyOFZkVGpUQ1N5Z1JPNHNOa0lVSExndFlLYTB0NFo1YlM1S2dHMWZ2?=
 =?utf-8?B?ZWtGUmVxTWtIOUI4WjdIbzlKazR0R0Zmc3VGTll0cEIwQ29hbWhXb20xQmJi?=
 =?utf-8?B?QStGaDhTS0xOenFzTVZtdmczS2FnY0ZWYWxuemZyYjVHNUNUc3FtTlJYV09u?=
 =?utf-8?B?NXRPOHdGWVFwbCtwMmRQQm1zazlQeXI1OUJ6bS94ZTZBUTFudGFaUjJ1ZjZG?=
 =?utf-8?B?OXdRUlhsd2ZvcEt3VzdYV3lWdGFVNG1hZGVzWm9RT3RlRzRLd2ZNcG5XQVZq?=
 =?utf-8?B?WEhhN09abkFUMk9RYjUwSUgyaUVZeXE4LzRWazlmdTZGZG1laGh2a3d5QWJH?=
 =?utf-8?B?d1FjSW9lYkdWYVpNZUZMMjJFWElBTmI0THpHYWtJN1czU2lYTUFYbUZPR3dZ?=
 =?utf-8?B?aWJoejVlYUVKazhiZnNrRzJ4TEJ1SWhwdWJOazN4MkhMN3dMREFMcWdFbnNO?=
 =?utf-8?B?c3NFdHhKdm1xQlRvOXppK1AxRUkyaGpOaGJvYWdOZ1BJdGp6enhFcHErQW9Y?=
 =?utf-8?B?Qms4RDVOSTNvZU82RlpiR3ZxUHhreFFDaVJmOGVKQzc4VXlnL014ZnQ4N2dV?=
 =?utf-8?B?dHo5Wnd0bWZkTjROVHBJTGJCNkdxY3NoRCtvSlNiVGo1STlYL3AwdWI5SVRi?=
 =?utf-8?B?eElxN29vTTJTaGNoaVRHdnpkaCt6MGRXZnExb3V5RG5XMllXZlAzWERjemdn?=
 =?utf-8?Q?bgdKbFQruv2p0A4I=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27b6148-31c3-4499-9943-08dedc02aa01
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:35:13.5666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ob27UzEen3LrJJySNf6EyBvPUHQxRuVGadRWuDiT2kj6f4VETEVX/DDF1QSOFZR6obIW929HZvJbRaCHYGJL2Y5x6nEXy9m2Y8nsMbZOMTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF1A8DB1DA4
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This reverts commit f95c4bffdc4c53b29f89762cab4adc5a43f95daf.

The m25p80 model now accounts for fast-read dummy bytes in its
command decoder. In ASPEED SMC model user mode, guest software
already sends the complete byte stream, including any dummy
bytes needed by the flash. Hence the model should just forward
exactly the bytes supplied by the guest without the need of
decoding guest-supplied flash op codes to inject extra dummy
transfers.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
---

(no changes since v1)

 hw/ssi/aspeed_smc.c         | 114 +-----------------------------------
 hw/ssi/trace-events         |   1 -
 include/hw/ssi/aspeed_smc.h |   2 -
 3 files changed, 2 insertions(+), 115 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 58e5087b57..c8cc6cfa56 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -197,9 +197,6 @@
 /* Flash opcodes. */
 #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
 
-#define SNOOP_OFF         0xFF
-#define SNOOP_START       0x0
-
 /*
  * Default segments mapping addresses and size for each peripheral per
  * controller. These can be changed when board is initialized with the
@@ -537,104 +534,6 @@ static MemTxResult aspeed_smc_flash_read(void *opaque, hwaddr addr,
     return MEMTX_OK;
 }
 
-/*
- * TODO (clg@kaod.org): stolen from xilinx_spips.c. Should move to a
- * common include header.
- */
-typedef enum {
-    READ = 0x3,         READ_4 = 0x13,
-    FAST_READ = 0xb,    FAST_READ_4 = 0x0c,
-    DOR = 0x3b,         DOR_4 = 0x3c,
-    QOR = 0x6b,         QOR_4 = 0x6c,
-    DIOR = 0xbb,        DIOR_4 = 0xbc,
-    QIOR = 0xeb,        QIOR_4 = 0xec,
-
-    PP = 0x2,           PP_4 = 0x12,
-    DPP = 0xa2,
-    QPP = 0x32,         QPP_4 = 0x34,
-} FlashCMD;
-
-static int aspeed_smc_num_dummies(uint8_t command)
-{
-    switch (command) { /* check for dummies */
-    case READ: /* no dummy bytes/cycles */
-    case PP:
-    case DPP:
-    case QPP:
-    case READ_4:
-    case PP_4:
-    case QPP_4:
-        return 0;
-    case FAST_READ:
-    case DOR:
-    case QOR:
-    case DOR_4:
-    case QOR_4:
-        return 1;
-    case DIOR:
-    case FAST_READ_4:
-    case DIOR_4:
-        return 2;
-    case QIOR:
-    case QIOR_4:
-        return 4;
-    default:
-        return -1;
-    }
-}
-
-static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
-                                unsigned size)
-{
-    AspeedSMCState *s = fl->controller;
-    uint8_t addr_width = aspeed_smc_flash_addr_width(fl);
-
-    trace_aspeed_smc_do_snoop(fl->cs, s->snoop_index, s->snoop_dummies,
-                              (uint8_t) data & 0xff);
-
-    if (s->snoop_index == SNOOP_OFF) {
-        return false; /* Do nothing */
-
-    } else if (s->snoop_index == SNOOP_START) {
-        uint8_t cmd = data & 0xff;
-        int ndummies = aspeed_smc_num_dummies(cmd);
-
-        /*
-         * No dummy cycles are expected with the current command. Turn
-         * off snooping and let the transfer proceed normally.
-         */
-        if (ndummies <= 0) {
-            s->snoop_index = SNOOP_OFF;
-            return false;
-        }
-
-        s->snoop_dummies = ndummies * 8;
-
-    } else if (s->snoop_index >= addr_width + 1) {
-
-        /* The SPI transfer has reached the dummy cycles sequence */
-        for (; s->snoop_dummies; s->snoop_dummies--) {
-            ssi_transfer(s->spi, s->regs[R_DUMMY_DATA] & 0xff);
-        }
-
-        /* If no more dummy cycles are expected, turn off snooping */
-        if (!s->snoop_dummies) {
-            s->snoop_index = SNOOP_OFF;
-        } else {
-            s->snoop_index += size;
-        }
-
-        /*
-         * Dummy cycles have been faked already. Ignore the current
-         * SPI transfer
-         */
-        return true;
-    }
-
-    s->snoop_index += size;
-    return false;
-}
-
 static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
                                    uint64_t data, unsigned size, MemTxAttrs attrs)
 {
@@ -652,10 +551,6 @@ static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
 
     switch (aspeed_smc_flash_mode(fl)) {
     case CTRL_USERMODE:
-        if (aspeed_smc_do_snoop(fl, data, size)) {
-            break;
-        }
-
         for (i = 0; i < size; i++) {
             ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
         }
@@ -717,7 +612,6 @@ static void aspeed_smc_flash_update_ctrl(AspeedSMCFlash *fl, uint32_t value)
     s->regs[s->r_ctrl0 + fl->cs] = value;
 
     if (unselect != s->unselect) {
-        s->snoop_index = unselect ? SNOOP_OFF : SNOOP_START;
         aspeed_smc_flash_do_select(fl, unselect);
     }
 }
@@ -763,9 +657,6 @@ static void aspeed_smc_reset_hold(Object *obj, ResetType type)
         aspeed_smc_flash_set_segment_region(s, i,
                     asc->segment_to_reg(s, &asc->segments[i]));
     }
-
-    s->snoop_index = SNOOP_OFF;
-    s->snoop_dummies = 0;
 }
 
 static MemTxResult aspeed_smc_read(void *opaque, hwaddr addr, uint64_t *data,
@@ -1293,11 +1184,10 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 static const VMStateDescription vmstate_aspeed_smc = {
     .name = "aspeed.smc",
     .version_id = 3,
-    .minimum_version_id = 2,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
-        VMSTATE_UINT8(snoop_index, AspeedSMCState),
-        VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
+        VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */
         VMSTATE_BOOL_V(unselect, AspeedSMCState, 3),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 2f36cf96b8..b9d8648297 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -2,7 +2,6 @@
 
 aspeed_smc_flash_set_segment(int cs, uint64_t reg, uint64_t start, uint64_t end) "CS%d segreg=0x%"PRIx64" [ 0x%"PRIx64" - 0x%"PRIx64" ]"
 aspeed_smc_flash_read(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
-aspeed_smc_do_snoop(int cs, int index, int dummies, int data) "CS%d index:0x%x dummies:%d data:0x%x"
 aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
 aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 76831422c6..a273365689 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -80,8 +80,6 @@ struct AspeedSMCState {
 
     AspeedSMCFlash flashes[ASPEED_SMC_CS_MAX];
 
-    uint8_t snoop_index;
-    uint8_t snoop_dummies;
     bool unselect;
 };
 
-- 
2.53.0


