Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9AFCAC5AA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 05:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1eCQ-0000eD-9h; Thu, 25 Sep 2025 01:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1eCM-0000XT-GF; Thu, 25 Sep 2025 01:07:18 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1eC2-0006xw-36; Thu, 25 Sep 2025 01:07:15 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 25 Sep
 2025 13:05:36 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 25 Sep 2025 13:05:36 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 3/8] hw/arm/aspeed: Move aspeed_install_boot_rom to common
 SoC code
Date: Thu, 25 Sep 2025 13:05:29 +0800
Message-ID: <20250925050535.2657256-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925050535.2657256-1-jamin_lin@aspeedtech.com>
References: <20250925050535.2657256-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.399,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the boot ROM install helper into common SoC code so it can be reused
by all ASPEED boards, and decouple the API from AspeedMachineState.

Specifically:
 - Move aspeed_install_boot_rom() to hw/arm/aspeed_soc_common.c and
   declare it in include/hw/arm/aspeed_soc.h.
 - Change the helper’s signature to take AspeedSoCState * and a
   MemoryRegion * provided by the caller, instead of AspeedMachineState *.
 - Update aspeed_machine_init() call sites accordingly.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  2 ++
 hw/arm/aspeed.c             | 23 +++--------------------
 hw/arm/aspeed_soc_common.c  | 17 +++++++++++++++++
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 5567bdcb69..aea210a8e2 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -314,6 +314,8 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
                                unsigned int count, int unit0);
 void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
                            Error **errp);
+void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
+                             MemoryRegion *boot_rom, uint64_t rom_size);
 
 static inline int aspeed_uart_index(int uart_dev)
 {
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 4d0d935836..429f4c6d77 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -263,24 +263,6 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
-/*
- * Create a ROM and copy the flash contents at the expected address
- * (0x0). Boots faster than execute-in-place.
- */
-static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
-                                    uint64_t rom_size)
-{
-    AspeedSoCState *soc = bmc->soc;
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(soc);
-
-    memory_region_init_rom(&bmc->boot_rom, NULL, "aspeed.boot_rom", rom_size,
-                           &error_abort);
-    memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
-                                        &bmc->boot_rom, 1);
-    aspeed_write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT], rom_size,
-                          &error_abort);
-}
-
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
 
 /*
@@ -460,9 +442,10 @@ static void aspeed_machine_init(MachineState *machine)
 
         if (fmc0 && !boot_emmc) {
             uint64_t rom_size = memory_region_size(&bmc->soc->spi_boot);
-            aspeed_install_boot_rom(bmc, fmc0, rom_size);
+            aspeed_install_boot_rom(bmc->soc, fmc0, &bmc->boot_rom, rom_size);
         } else if (emmc0) {
-            aspeed_install_boot_rom(bmc, blk_by_legacy_dinfo(emmc0), 64 * KiB);
+            aspeed_install_boot_rom(bmc->soc, blk_by_legacy_dinfo(emmc0),
+                                    &bmc->boot_rom, 64 * KiB);
         }
     }
 
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index d0a400725f..7f104f8de5 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -178,6 +178,23 @@ void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
     rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
 }
 
+/*
+ * Create a ROM and copy the flash contents at the expected address
+ * (0x0). Boots faster than execute-in-place.
+ */
+void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
+                             MemoryRegion *boot_rom, uint64_t rom_size)
+{
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(soc);
+
+    memory_region_init_rom(boot_rom, NULL, "aspeed.boot_rom", rom_size,
+                           &error_abort);
+    memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
+                                        boot_rom, 1);
+    aspeed_write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT], rom_size,
+                          &error_abort);
+}
+
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 {
     AspeedSoCState *s = ASPEED_SOC(dev);
-- 
2.43.0


