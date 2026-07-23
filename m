Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10031C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDj-0004vY-HY; Thu, 23 Jul 2026 11:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDK-0004LQ-Qk; Thu, 23 Jul 2026 11:20:00 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDH-00085x-0o; Thu, 23 Jul 2026 11:19:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD3MgIYzVzWardmPpCbnkZuLHHo0VU59vmLQRPOUabx0A7WpyKK7aAtbrn60nm9FIhZoiIKlUrrUsVSTTzzdMqcK60gvAPjLtJYCbd9yKhHq5bV7hNageajbzKSTBjDDhdjtw/7yZpdQPQU6U8Gi87bwGDYoJp9IMRBTNm+fzZgnJ/lBoNcFwgpJCAJEfCd1WCAnpD+PEdhgCBAW6BlgAiCJuC1pqa6mRfQNLa8wJWVlrr8pxx9FZ9IjvnF7E7Le9HRZvRXCkRWccMZ7QWT5oziQaTEQ2R1VoYbq042+v8Nm0KN1IkfCNHH66GfIskVciAAG1hBl5SFXr1Gntt+UEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhfcHWlRoqwl5tzBmG4h1hrmaVqbsctsfi2knzV6aoo=;
 b=h7N6vhXEY7979W+G5fuBgFXmI5XAnnOXYP5o3BLI/42cK1DVyR6PKY5ygw1s2j+jvQwW1lTXu0p8vtXTsVpJZG1UoSSgqXrUClsXkF2v1tINJPsjbq5dMWqyXvsUhucleY8KbqH3sjLm+eQMVkS/OqxQazI82SjKGNT73HK7/4I/ub+bS1N5V8VK3x/Ni7pjyZe/c4Lsg7Wd0VSfEu+x5gb7RFJYTsbVqAEX9rZg3blQI3I+45fcZp7wPzWW2Zv1921gIdboBa+vZ/vwNno2COoNsw5aMLy2Sy5QDqS+RVepLoF8yxRIdUGJYI6ysblnTRz5NBaK0plcDLc7E3ZkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhfcHWlRoqwl5tzBmG4h1hrmaVqbsctsfi2knzV6aoo=;
 b=VYpRuHLTtvlU0Ljb2VXenBgrCTFiPYFtkProhwU2BFxFylkxRIZC0mla76a/uLkVP6cHJw/B2DG681nSY574S4L7/MROlUjsHJb+vDdXZHk2oFsNp4VIeRMSoPOvt1itb4nh7BEuSSQNL18HjW2vAKOGRTPBtOoAKPsuhpqzwNCP0tG3knHnaG4Tm9PIfRjvKnxOvWPPsGz76QLngT766XLUxIT678sm3ADpM7i+vmHNEPQ9Bdw+FNWPVdhcWWnA6OsixkLvBbDuEffCvpvyK1kf6pCJpI9Qv1viXwrCPssJw0juOhWHYuXqV7cn4WYLEKXNLt5mXf3iLLSqPHj8RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:19:41 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:41 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH 20/26] hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
Date: Thu, 23 Jul 2026 23:18:47 +0800
Message-Id: <20260723151853.2143177-21-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: af8ebccf-eb05-45ac-86b6-08dee8cdd149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|366016|23010399003|1800799024|22082099003|18002099003|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: OuYWk1KvqNpPMPmqIgpZ9IDqQo8MD+92+AqCjRFhUJ7tL+AqKkX4nc7o/yJZw7qyvGrZUBgYE9H6pvz/6mzayUA7yXt5WaOaf1y9vGWgwIWnurN9X8HPkB4+PiO8PQGE4Q1vEoC3rdLgeSOPk7QHYZ02O48Ycn5jrrt3sNRoH9aSuq2cxsZruisK1b+ORVlHJlghsDDxv7u9xEHjH86Pk7tNVoeVbjBoZcDfQdbRTu9a+Xb2uWryTgM2WkoYd5KHq/oWwuKywOJgVOzhjqY9njgm8UWxDwYhKRkJ/UWU0Ip5XFcyn/h4udUvH8tyihTG5a59L34xfbYjW0spvkVrBF3iiNpHv7jv0izP+yASzPOyIX0zX7CqVoYMrnaeC0iTkkmsvHEotr5T9sWeb/IRySuzDKlwcXEERArB6Y0WnmsuEnGkEP8RglJv6FYK2nYJUTvmgYL7tETEz0xhprTariZRPZYEtKhaE1ZrNN2dhFeyvCoIN/G4p5BOANN3rrP8lFieKx8qrizuNrte/KhAQt7JL8getKUFE+elupGa45ERoBGXG5rPb86O2EBs/AngQgUM13aOVjc8CUT9pyqR6DEyusHFkaBMafcA5/bcJ3KxWHI/exqbAWu+setl7QzCLPZcGm49izgqzEjSsZDmN/RYmAeBG+KJV2a/p1aRZ5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(5023799004)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y/fkgkboXFrzwLKNr9Vt0S2S5PSpcDYyoaO5pY8RlZrK7zm4XAIJnSTDEgbI?=
 =?us-ascii?Q?pUct94WMfElvwEsVGtWdApZa3jrTYCy2cwF5pKSykbRX5n4VQ6Q23uAyccGX?=
 =?us-ascii?Q?6dBsvJpUgZjEVTAXjYmLgxGimEqtsbn8+ogr1XPdvp+Eg23K3jF+jF+xcblo?=
 =?us-ascii?Q?NjrzAPTqLEri4wbXnysaJLWgJgIt/ikO1qjgNeKoOhpQG/X7ju67+UZWjtbD?=
 =?us-ascii?Q?DaEeqLfFwQAFXhYyVLq33zOpgMjR7Wuy2FgX7unuvzXd48/CmNXQy56hS2u6?=
 =?us-ascii?Q?pHqwbEXZ6fEF8lT5RqSph2aVHkijfWVffsNT159TYP2w96fe5T6CIbBUj36O?=
 =?us-ascii?Q?+yKp501MThpf6nWOD3ha3fm5xFuxZbLphzK8LUX/RGVvsReHftz0hZkDtye9?=
 =?us-ascii?Q?Hs8FoeRuLBAGBIIHucfVDkAcfICTjNMzOzwBkao//fs6b8Fphd/jhLbhofSd?=
 =?us-ascii?Q?e9kaD1ZGvdNDXux7F7fqlce96XEyFmaGPtpFz/UfI8vmdNY0P5CYDVH3P1rw?=
 =?us-ascii?Q?kGTjU9VH7fB2a/8VPt4SU7pZDJ2OxFxvSdIHXLnnFlqFCk/ZSyVrA6otNfY9?=
 =?us-ascii?Q?ciJ2Xmp4Eif32WR3CENB69HaM/P/PhCkhS8l3UNtbzefTwdMcdc35/50OGiR?=
 =?us-ascii?Q?nqzXzpbbrRyFkKnA722Ma9fJqaw2hlVCWIHCvmgRDWbFonvg95yvJHBpCMMI?=
 =?us-ascii?Q?gPfZOoxxw1+m/jh5r1h9F342Z0jx+geHzGVAefjJffUFkR6yiMLc78Zx0DuO?=
 =?us-ascii?Q?rd2ffahUaJv2+VfusmLfmZw5G7Ao5B8SBA3m16JRUrxf9G00OMc06C/G2BO9?=
 =?us-ascii?Q?G9GElJOg5g/RA4xpnKyFrDQAUPebPAjw+vdcuGtOUyCdmX04wjMM4tdrCd/N?=
 =?us-ascii?Q?Ftlw+u3lGkcNV5eKqS+wapMtRe/2YPXJzJOBM8TjJhPHotBjDaKL8xk+lkqF?=
 =?us-ascii?Q?yd4irLDxoY/gmLzBag5Fv0/VZBfWy7reUQZfXNcHG0XarluweFykcKJz6c0g?=
 =?us-ascii?Q?jX37hJ7JQGfpVELzUmTTkIoJuxeaqChTorQT9aBPU/T+ETkg4CAgzhnYmtK3?=
 =?us-ascii?Q?U7lHWTVXef/F5SWOrKDobr4SK0F1Ispdt06/XF/MuMSb7ASFwTdupyGMkK5e?=
 =?us-ascii?Q?7KTUJgatpE2qkJb/bn3egrtiuSyhCdoZ+KFwhxLTmKFTMz99W/BNsfJhTfcB?=
 =?us-ascii?Q?IsMsTd+8mwivZ4YKD5tKIjJSeXRIletXP0NnTX5WBaB+hScBcgaWN//Mgm2J?=
 =?us-ascii?Q?ZyFy8EtKrlv9o1s/B1yI3XNaI1VZX/4/GFtiOf15OKemUl4BIleZjXp/7hvV?=
 =?us-ascii?Q?IGwRxHsOOkmhWNwQQARLYoW6jQoMrH8HN0cRspI0tuKklDgMyQxg9RHR1N9s?=
 =?us-ascii?Q?OmPP+ch1EibxT/XKnJd95b+EdwWnPgphMvuw7OMON3NTfY1jk4siUGEz3R63?=
 =?us-ascii?Q?6Mm5dmUH2a8DEDx6OKLRd59yr88Weg1IURDyOqSPkiitpLLhoBpZ5k2dDuWj?=
 =?us-ascii?Q?Abb82y6BLtYvQ+RwB9KcidF2YDeT7j9HXIZ4fm+YR6KYaLIk3j32wh/DsKBx?=
 =?us-ascii?Q?+YurnvzbL4k1lxTxxS3RvZpBH8ls5kxWHbW5GOm9ey+yjUmEPtCbe+OpSBJ6?=
 =?us-ascii?Q?nKQvsz52BMn/WPtipSTyZGlGbwHFNUkn+HejKD6r+GcjzazyS/Ko0UAVo08r?=
 =?us-ascii?Q?0AHgYADLPpM9yhXM6kB7bdTk8vZE4Cw4zxiKA3+zn03ROR3xCVwcIUE9Qvrc?=
 =?us-ascii?Q?9FgJ8IhEgids8TlqlP09C6ApqjNdJP0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8ebccf-eb05-45ac-86b6-08dee8cdd149
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:41.2097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Soz1vNoWXhOAOd0bKcCgH9fwyZ6egStLHVlcCMdrBQUtoj9YnfTaxRnN3YSS2OG8bU4w131EC7WVcIKVsCs2IvAQaLCIIXwIo4y7+sNTBg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The 64-bit cached and non-cached windows alias the complete physical
DDR from offset zero. Treating them as only the portion above 1 GiB
leaves valid Icicle Kit memory nodes unbacked with the board's 2 GiB.

Map both high windows over the full machine RAM.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/riscv/microchip_pfsoc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index f348de6fd4..a2fbc89222 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -570,15 +570,27 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
                             TYPE_MICROCHIP_PFSOC);
     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
-    /* Split RAM into low and high regions using aliases to machine->ram */
+    /*
+     * The four CPU-visible windows alias the same physical DDR from offset
+     * zero. For the Icicle Kit's 2 GiB of DDR, they map as follows:
+     *
+     * CPU address     Attribute           Visible size   DDR range
+     * 0x0080000000    32-bit cached       1 GiB          [0, 1 GiB)
+     * 0x00c0000000    32-bit non-cached   1 GiB          [0, 1 GiB)
+     * 0x1000000000    64-bit cached       2 GiB          [0, 2 GiB)
+     * 0x1400000000    64-bit non-cached   2 GiB          [0, 2 GiB)
+     *
+     * "Low" and "high" describe the CPU address windows, not the lower and
+     * upper portions of physical DDR.
+     */
     mem_low_size = memmap[MICROCHIP_PFSOC_DRAM_LO].size;
-    mem_high_size = machine->ram_size - mem_low_size;
+    mem_high_size = machine->ram_size;
     memory_region_init_alias(mem_low, NULL,
                              "microchip.icicle.kit.ram_low", machine->ram,
                              0, mem_low_size);
     memory_region_init_alias(mem_high, NULL,
                              "microchip.icicle.kit.ram_high", machine->ram,
-                             mem_low_size, mem_high_size);
+                             0, mem_high_size);
 
     /* Register RAM */
     memory_region_add_subregion(system_memory,
-- 
2.34.1


