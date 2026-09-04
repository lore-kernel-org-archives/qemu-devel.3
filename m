Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A952C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJy-0005eU-NG; Fri, 04 Sep 2026 11:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJt-0005In-Bi; Fri, 04 Sep 2026 11:59:15 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJq-0004Wv-3h; Fri, 04 Sep 2026 11:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxiUF4plbi/vN7tJnALugCOVq6N6SSTEMJvA5dTPBVdihMmjg/mMLJQ+8WidlZGyzfa+9vof4mvfZMeBUMscVlCU0G2wqL2jfh42IYAyGQ29GWyj3cUlTcc4o4UU4VMW2ayzL4fvUivPaT3ozQ9YhbM7uY4Z/UwKOGWZxOrfYftE46sGiKc9qRuSnH7O3JunD4mcTNZrc31mgtNxasNcwcNYbNbWNteoMkMi6D4IqcCnXEIY4HJ1tjW1CHjhRG9AaJLVE1aX6zZH76AkvSUmnnmBCNdpnL4hTsoMCQTry2SdpHWKQtvH1Rx6dLE7cZoHMLchHWVa1eMzSZ50v0pJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWOQWtIRgxdYi9GRu0h2YY9cte+z4sK5AdlSD1GySRU=;
 b=xrv/6v2RNJnut4VEL3JUtHteMDWG06YE5VeYfo8vjApmdupC/iP30wUcdiNnzGBmEq9AXc8LfQiwiZHGunr6RbVSFjOB0O9L0w+ou6jTEVWvhlevlQ/zf39ALS0f6u5NW7WOByxdaxKSWcIOsCpd/X/zWpln7SeylrnIuAIdKz3GoE6rK0eI1ObniRU0GHPWv5QmfRMzTTopxRDfbeBNmYCgR/bLkfyY/JIk/IDZ7aQm9dwmaLBHz/eyvCrUlkIUSureB6zDran0yKC81b8xydQOpE/Yk9SrPcCY3f8mMx3bi1gk+h3sJrkMMOYRCKw6o5d7RsZMZWJf/KOsRMbQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWOQWtIRgxdYi9GRu0h2YY9cte+z4sK5AdlSD1GySRU=;
 b=Oj4/ROERAUDmDMResnbFRGRauku5ZOCa1TYYoOMhfKVSShOT8rpE6jBI3RHrM163WXTI2Axgz6eFokTyec3ba2bsNBPfzLqIrw2Y42yg01Ij0xutBkKtvURHdLEm1ZmOT7e6OwJtg2kerOfAX+alZTpJZ9OnN6kMtP9XgQJoSPSWtzHQQn8mIpiZRpCOMmX9IyiRmX2Yy68i9iux10ElsO4to+DGwpKzNSuSVyIl4RGaVAToAzlG9khrf2H7LMMmBt3ArX++RbrerFMawZNfLn1S/F/KrZn1MCR68hN9XsLgprC7+uO9H2JACOsVoqNfXIg+IGAklDLb647iNkPXlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYSPR02MB7490.apcprd02.prod.outlook.com (2603:1096:405:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:59:02 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:59:02 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 17/24] hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
Date: Fri,  4 Sep 2026 23:57:36 +0800
Message-ID: <20260904155758.3833179-18-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYSPR02MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: fc998c6a-ad02-4a6d-ccfd-08df0a9d7095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: jEKUSt827jdcwSfkH3VnojI7snuDhS52VmEawOwZBMqifXYcLfT75YqQ6E2CrM2GUCRHbmZil1bxLVjxxGiSOS8nminZhf/CPLaASNd+cbKZLeb1jHh5kS+2e96+W9ppPc+FOcaT5EvVMr7L0F6AsmsVbMPyQO7eNqsRTkR8qw/is3oCZ/+SQGCKn+gtUmiQpJeiM3GNmpC0gKugw502t3AZEtSBhpLk4TPVRr/NALYAb/p0/IGWgjblfFC/6LVyRMB0qSKIgNum2l2lt30+C3Vfv3MLICm8Bf1bIVdHjWWXEpLRrk5OCflgls+/r5VjtHsy3CWmYLzcRB1ThYFU0jqgtt0nSlNbs0D64wJxV+ANtfwh2E35GzRkj+JBbLioNNol4fCDuJ7b3/EOa3k1vhUEyHeyVgTBkoiS/vFbXgRSDoeECL68F7lxZxp3PXowNZCcKi8oFSTrttspLIEAHh923HiR0D8UE6VoNW5ptNCrJXmp+KLTlKQ3KS8dJQCOUxK2k3nORitRdyYqUz+Ly6qXQNusI39+BnXx9A7W7Tgj0VfHwrtKWzOng0WylkAaCnSNFBco19ucs1UHh/6qSbSPzLXqyzk8yjnGN3cETaCbVBl34zaSmWlGvn9eY6sy3F4P9yU1gtTFltEcRwDBmjO8JOOtumAWr///C5TgRVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(5023799004)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ukS84pjeyEXrP4YImT2uSkpHziiuDiMhML3Z6FHGfpPlu6EP4kYSzJfN7w0I?=
 =?us-ascii?Q?rYZtjV6AlMPeZctt0U5afEctcItVW/J9yHJvS2xOmmsi4SCEICU8h+bxAOAe?=
 =?us-ascii?Q?El1q8ke6+X8MrUkQ0K+fbEYNUfjOPPeBslCqoq38AobW8FUUfql0JdnL+KK7?=
 =?us-ascii?Q?oD1gtgy0e6KAohi8+kSQiYBmxrPZOqPkeFeVfCB4hI9qnRwuurhgPEiBcomd?=
 =?us-ascii?Q?LDt7lAuI/PdskPXyggdV6jVmKxKX27BVJ6JS0CZ8muMXGWdOQONqHzBlH1ku?=
 =?us-ascii?Q?+PX7tsjIhI4BjD9iKodGgeF9n2pdGmbAbJos2k5d57zCa0/yy+uH82EH/x0T?=
 =?us-ascii?Q?vqGTz5iZyVtdD0LTpWWgnHUmODh0DwRRRx/CW2OBwXd8/G3WWu0mWUUNMUht?=
 =?us-ascii?Q?CcatfbtUQsNLhFaGtVOMj6Go6MX8TcikFIlQbSzFTglxpwU9zLAqPOgfSujd?=
 =?us-ascii?Q?0cZzrLtq7IzimXm3ywO4VK2XNgAtsUZ3PiD1srgQ9e2taoMlmMCz4lXx/hc4?=
 =?us-ascii?Q?bN2iEmNM0L2GR/MR0mwtOTtbXl+9y/YQGmXFAoQB2d61zeKuRh+GPI5iLo7k?=
 =?us-ascii?Q?rbwXt8CBeoUzlFalZIlC2wbtvID+FpHTI787fo/0LdiGqvnw2zryj4vf1fAu?=
 =?us-ascii?Q?tAzDH2TyC97D0FWbynl63UmfE8wSaHltfm9auEAJUQ3uZC3p+l8GsoV2si45?=
 =?us-ascii?Q?R7Bwklx8Hj1QyFakIZt6UTKniubbH1XM+E2nN4GWu3uSRF+1LkKtUJgOOTla?=
 =?us-ascii?Q?jPGgtFij0D1hlTzkmiZqcboL/A2sZzsXvuxZk7pOSI0q3ESObZ+L7BvjE3L0?=
 =?us-ascii?Q?vlTbDXS4kx8tEswc3OptpMho25W+r9uoUKd+jZuyuChq3E3F6Zz81fhz2hE/?=
 =?us-ascii?Q?J5wF0wm8antlioHAGem8THfoE/IHWN1QZTNRPVZny1GX8gSMOdRs7SipAzhC?=
 =?us-ascii?Q?JzaGfyQG9SOI2uLbw7Pg6ukH70bzo86WTM1vjpVA8OZ4lIxXdj0EPHjDL8Iq?=
 =?us-ascii?Q?IrU2H5MnfdanXO/4pLb/3J1HpLhcJOZKBTuBq6QsLd/VNbKw7XlbWbcX2sq5?=
 =?us-ascii?Q?NAPdp1ulkqu3e3oHLiaXttNl3Yv8R2IjBoZgDMUr+a58yq+TSp/fzTA7J3Du?=
 =?us-ascii?Q?YYoUV6OU7CD3n7e/8veUNKF2F13rwgbH90WDofgegkvZ8jNhor8mZPBP04Vq?=
 =?us-ascii?Q?aaPsJpgm2noP86DLbvghxcYjYR7FZIvjOXWRZV5Ph+ilArdTwxyYM5uN3MUT?=
 =?us-ascii?Q?Y8zuEZG9m7fWELQbK1sYZL+hPimgUrNmZVq4CwUbUfV+21bt+NUB0CK7jK65?=
 =?us-ascii?Q?aRw7oSW4d3t9etlYzAGhf0W6/eyC9K7OFTF2QXftJ9J8jUTBDX7FZUZC2YdR?=
 =?us-ascii?Q?JFIEgQlqHEe84UEC4naGjYCwRUh9SCYair6wHmSuh7gyk+X+wySo809/0Gi3?=
 =?us-ascii?Q?tNV55JicsWjDwV5taul5g7oRSzFKBEuwiDz0cEnKCGfS2pfUEY5ksO5OuK/k?=
 =?us-ascii?Q?2Cbre6+5KiF122uw8yhI6WaIPdIhIbCDvVx7CUO14RbqkOPBqcaBOiiLSrSV?=
 =?us-ascii?Q?quiXAiDWMZbUi9+k32O18kvEY/S1TzVhHP5zzKvZhk75LlrUm4dWAHJG0S2e?=
 =?us-ascii?Q?hib75xmagGcGEb+FZcydswkm4/cilK1XYHpgsdFjmc7dTNKfXWCu9lShYGTf?=
 =?us-ascii?Q?qC9QXvxfmNXNoLxtA6AfayosZvlpvjenY9iYdSinHAJjk0H1XyB5KUSFI6zn?=
 =?us-ascii?Q?TqhIVRhPlIafeLyuT/CMQ6cZ/5KMjd0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc998c6a-ad02-4a6d-ccfd-08df0a9d7095
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:59:02.6374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2Wyj18e+Rljrn8lNgrJ3bVtfPMqJMdxKdDJV1UgarH2I4GFFHO4VsDB6TASFsBt/Q1EV5zH41UmyCUsz57cyBIVeJh7GjwZ7sbBNb2iTmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7490
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
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---

(no changes since v1)

 hw/riscv/microchip_pfsoc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 87c9c89cb0..83ac352c1e 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -573,15 +573,27 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
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
2.53.0


