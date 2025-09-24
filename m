Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11D3CAC5B1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 05:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1IUn-0003ty-0O; Wed, 24 Sep 2025 01:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1IUR-00034B-QT; Wed, 24 Sep 2025 01:56:33 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1IUK-0000It-M5; Wed, 24 Sep 2025 01:56:30 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 24 Sep
 2025 13:56:03 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 24 Sep 2025 13:56:03 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v2 2/7] hw/arm/aspeed: Move write_boot_rom to common SoC code
Date: Wed, 24 Sep 2025 13:55:56 +0800
Message-ID: <20250924055602.294857-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
References: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the write_boot_rom helper from hw/arm/aspeed.c into
hw/arm/aspeed_soc_common.c so it can be reused by all ASPEED
machines. Export the API as aspeed_write_boot_rom() in
include/hw/arm/aspeed_soc.h and update the existing call site
to use the new helper.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  2 ++
 hw/arm/aspeed.c             | 33 ++-------------------------------
 hw/arm/aspeed_soc_common.c  | 31 +++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index aaf518d179..5567bdcb69 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -312,6 +312,8 @@ void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
                                    uint64_t size);
 void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
                                unsigned int count, int unit0);
+void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
+                           Error **errp);
 
 static inline int aspeed_uart_index(int uart_dev)
 {
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 55f0afe0a4..4d0d935836 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -263,35 +263,6 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
-static void write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
-                           Error **errp)
-{
-    g_autofree void *storage = NULL;
-    int64_t size;
-
-    /*
-     * The block backend size should have already been 'validated' by
-     * the creation of the m25p80 object.
-     */
-    size = blk_getlength(blk);
-    if (size <= 0) {
-        error_setg(errp, "failed to get flash size");
-        return;
-    }
-
-    if (rom_size > size) {
-        rom_size = size;
-    }
-
-    storage = g_malloc0(rom_size);
-    if (blk_pread(blk, 0, rom_size, storage, 0) < 0) {
-        error_setg(errp, "failed to read the initial flash content");
-        return;
-    }
-
-    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
-}
-
 /*
  * Create a ROM and copy the flash contents at the expected address
  * (0x0). Boots faster than execute-in-place.
@@ -306,8 +277,8 @@ static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
                            &error_abort);
     memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
                                         &bmc->boot_rom, 1);
-    write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT],
-                   rom_size, &error_abort);
+    aspeed_write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT], rom_size,
+                          &error_abort);
 }
 
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 31b1e683c3..d0a400725f 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -17,6 +17,8 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/char/serial-mm.h"
 #include "system/blockdev.h"
+#include "system/block-backend.h"
+#include "hw/loader.h"
 
 
 const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
@@ -147,6 +149,35 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
     }
 }
 
+void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
+                           Error **errp)
+{
+    g_autofree void *storage = NULL;
+    int64_t size;
+
+    /*
+     * The block backend size should have already been 'validated' by
+     * the creation of the m25p80 object.
+     */
+    size = blk_getlength(blk);
+    if (size <= 0) {
+        error_setg(errp, "failed to get flash size");
+        return;
+    }
+
+    if (rom_size > size) {
+        rom_size = size;
+    }
+
+    storage = g_malloc0(rom_size);
+    if (blk_pread(blk, 0, rom_size, storage, 0) < 0) {
+        error_setg(errp, "failed to read the initial flash content");
+        return;
+    }
+
+    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
+}
+
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 {
     AspeedSoCState *s = ASPEED_SOC(dev);
-- 
2.43.0


