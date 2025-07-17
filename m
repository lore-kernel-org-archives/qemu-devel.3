Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2942C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFVo-00045S-0H; Wed, 16 Jul 2025 23:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUd-0003PZ-Rp; Wed, 16 Jul 2025 23:41:12 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUb-0000ZH-9U; Wed, 16 Jul 2025 23:41:10 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:40:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:40:55 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 01/21] hw/arm/aspeed_ast27x0-fc: Support VBootRom
Date: Thu, 17 Jul 2025 11:40:29 +0800
Message-ID: <20250717034054.1903991-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
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

Introduces support for loading a vbootrom image into the dedicated vbootrom
memory region in the AST2700 Full Core machine.

Additionally, it implements a mechanism to extract the content of fmc_cs0
flash data(backend file) and copy it into the memory-mapped region
corresponding to ASPEED_DEV_SPI_BOOT.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0-fc.c | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 7087be4288..e2eee6183f 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/datadir.h"
 #include "qapi/error.h"
 #include "system/block-backend.h"
 #include "system/system.h"
@@ -35,6 +36,7 @@ struct Ast2700FCState {
 
     MemoryRegion ca35_memory;
     MemoryRegion ca35_dram;
+    MemoryRegion ca35_boot_rom;
     MemoryRegion ssp_memory;
     MemoryRegion tsp_memory;
 
@@ -55,12 +57,65 @@ struct Ast2700FCState {
 #define AST2700FC_HW_STRAP2 0x00000003
 #define AST2700FC_FMC_MODEL "w25q01jvq"
 #define AST2700FC_SPI_MODEL "w25q512jv"
+#define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
+
+static void ast2700fc_ca35_load_vbootrom(AspeedSoCState *soc,
+                                         const char *bios_name, Error **errp)
+{
+    g_autofree char *filename = NULL;
+    int ret;
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!filename) {
+        error_setg(errp, "Could not find vbootrom image '%s'", bios_name);
+        return;
+    }
+
+    ret = load_image_mr(filename, &soc->vbootrom);
+    if (ret < 0) {
+        error_setg(errp, "Failed to load vbootrom image '%s'", bios_name);
+        return;
+    }
+}
+
+static void ast2700fc_ca35_write_boot_rom(DriveInfo *dinfo, hwaddr addr,
+                                         size_t rom_size, Error **errp)
+{
+    BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
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
 
 static void ast2700fc_ca35_init(MachineState *machine)
 {
     Ast2700FCState *s = AST2700A1FC(machine);
+    const char *bios_name = NULL;
     AspeedSoCState *soc;
     AspeedSoCClass *sc;
+    uint64_t rom_size;
+    DriveInfo *mtd0;
 
     object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");
     soc = ASPEED_SOC(&s->ca35);
@@ -118,6 +173,26 @@ static void ast2700fc_ca35_init(MachineState *machine)
     ast2700fc_board_info.ram_size = machine->ram_size;
     ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
 
+    /* Install first FMC flash content as a boot rom. */
+    if (!s->mmio_exec) {
+        mtd0 = drive_get(IF_MTD, 0, 0);
+
+        if (mtd0) {
+            rom_size = memory_region_size(&soc->spi_boot);
+            memory_region_init_rom(&s->ca35_boot_rom, NULL, "aspeed.boot_rom",
+                                   rom_size, &error_abort);
+            memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
+                                                &s->ca35_boot_rom, 1);
+            ast2700fc_ca35_write_boot_rom(mtd0,
+                                          sc->memmap[ASPEED_DEV_SPI_BOOT],
+                                          rom_size, &error_abort);
+        }
+    }
+
+    /* VBOOTROM */
+    bios_name = machine->firmware ?: VBOOTROM_FILE_NAME;
+    ast2700fc_ca35_load_vbootrom(soc, bios_name, &error_abort);
+
     arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
 }
 
-- 
2.43.0


