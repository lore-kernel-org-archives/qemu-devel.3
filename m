Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672FBE7718D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 02:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQGpF-00082r-AK; Tue, 24 Dec 2024 21:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tQGpD-00082N-M3; Tue, 24 Dec 2024 21:08:39 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tQGpB-0002ew-RX; Tue, 24 Dec 2024 21:08:39 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 25 Dec
 2024 10:03:14 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 25 Dec 2024 10:03:14 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <steven_lee@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH 4/5] aspeed: Introduce ast2700-fc machine
Date: Wed, 25 Dec 2024 10:03:10 +0800
Message-ID: <20241225020311.3718080-5-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch introduces a new machine, ast2700-fc, which supports all cores
available in the AST27x0 SoC. In this machine
- The first 4 cores are Cortex-A35 cores.
- CPU 4 is designated as the SSP core.
- CPU 5 is designated as the TSP core.

Test Step:
    wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/ast2700-ssp.elf
    wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/ast2700-tsp.elf
    wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/bl31.bin
    wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/tee-raw.bin
    wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/u-boot-nodtb.bin
    wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/u-boot.dtb
    wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/image-bmc.tar.zst
    tar --zstd -xvf image-bmc.tar.zst

    qemu-system-aarch64 -machine ast2700fc \
      -device loader,force-raw=on,addr=0x400000000,file=u-boot-nodtb.bin \
      -device loader,force-raw=on,addr=$((0x400000000 + 748896)),file=u-boot.dtb\
      -device loader,force-raw=on,addr=0x430000000,file=bl31.bin\
      -device loader,force-raw=on,addr=0x430080000,file=tee-raw.bin\
      -device loader,file=ast2700-ssp.elf,cpu-num=4 \
      -device loader,file=ast2700-tsp.elf,cpu-num=5 \
      -device loader,cpu-num=0,addr=0x430000000 \
      -device loader,cpu-num=1,addr=0x430000000 \
      -device loader,cpu-num=2,addr=0x430000000 \
      -device loader,cpu-num=3,addr=0x430000000 \
      -m 1G \
      -drive file=image-bmc,if=mtd,format=raw \
      -serial pty -serial pty -serial pty \
      -S -nographic
    char device redirected to /dev/pts/51 (label serial0)
    char device redirected to /dev/pts/52 (label serial1)
    char device redirected to /dev/pts/53 (label serial2)

    tio /dev/pts/51
    tio /dev/pts/52
    tio /dev/pts/53
    (qemu) c

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0-fc.c  | 211 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   4 +-
 include/hw/arm/aspeed_soc.h |  12 ++
 3 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/aspeed_ast27x0-fc.c

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
new file mode 100644
index 0000000000..aeb0996a97
--- /dev/null
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -0,0 +1,211 @@
+/*
+ * ASPEED SoC 2700 family
+ *
+ * Copyright (C) 2024 ASPEED Technology Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Implementation extracted from the AST2600 and adapted for AST2700.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "system/block-backend.h"
+#include "system/system.h"
+#include "hw/arm/aspeed.h"
+#include "hw/boards.h"
+#include "hw/qdev-clock.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/loader.h"
+#include "hw/arm/boot.h"
+#include "hw/block/flash.h"
+
+#define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
+OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);
+
+static struct arm_boot_info ast2700fc_board_binfo = {
+    .board_id = -1, /* device-tree-only board */
+};
+
+struct Ast2700FCState {
+    MachineState parent_obj;
+
+    MemoryRegion ca35_memory;
+    MemoryRegion ca35_dram;
+    MemoryRegion ca35_boot_rom;
+    MemoryRegion ssp_memory;
+    MemoryRegion tsp_memory;
+
+    Clock *ssp_sysclk;
+    Clock *tsp_sysclk;
+
+    Aspeed27x0SoCState ca35;
+    Aspeed27x0CM4SoCState ssp;
+    Aspeed27x0CM4SoCState tsp;
+
+    bool mmio_exec;
+};
+
+#define AST2700FC_BMC_RAM_SIZE (1 * GiB)
+#define AST2700FC_BMC_SRAM_SIZE (1 * GiB)
+
+#define AST2700FC_HW_STRAP1 0x000000C0
+#define AST2700FC_HW_STRAP2 0x00000003
+#define AST2700FC_FMC_MODEL "w25q01jvq"
+#define AST2700FC_SPI_MODEL "w25q512jv"
+
+static void ast2700fc_install_boot_rom(Ast2700FCState *s, BlockBackend *blk,
+                                    uint64_t rom_size)
+{
+    AspeedSoCState *soc = ASPEED_SOC(&s->ca35);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(soc);
+
+    memory_region_init_rom(&s->ca35_boot_rom, NULL, "aspeed.boot_rom", rom_size,
+                           &error_abort);
+    memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
+                                        &s->ca35_boot_rom, 1);
+    write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT],
+                   rom_size, &error_abort);
+}
+
+static void ast2700fc_ca35_init(MachineState *machine)
+{
+    Ast2700FCState *s = AST2700FC(machine);
+    AspeedSoCState *soc;
+    AspeedSoCClass *sc;
+    DriveInfo *emmc0 = NULL;
+    bool boot_emmc;
+    int i;
+
+    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a0");
+    soc = ASPEED_SOC(&s->ca35);
+    sc = ASPEED_SOC_GET_CLASS(soc);
+
+    memory_region_init(&s->ca35_memory, OBJECT(&s->ca35), "ca35-memory",
+                       UINT64_MAX);
+
+    memory_region_init_ram(&s->ca35_dram, OBJECT(&s->ca35), "ca35-dram",
+                           AST2700FC_BMC_SRAM_SIZE, &error_abort);
+    object_property_set_link(OBJECT(&s->ca35), "memory",
+                             OBJECT(&s->ca35_memory),
+                             &error_abort);
+    object_property_set_link(OBJECT(&s->ca35), "dram", OBJECT(&s->ca35_dram),
+                             &error_abort);
+    object_property_set_int(OBJECT(&s->ca35), "ram-size",
+                            AST2700FC_BMC_RAM_SIZE,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->ca35), "hw-strap1", AST2700FC_HW_STRAP1,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->ca35), "hw-strap2", AST2700FC_HW_STRAP2,
+                            &error_abort);
+    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
+    qdev_realize(DEVICE(&s->ca35), NULL, &error_abort);
+
+    aspeed_board_init_flashes(&soc->fmc, AST2700FC_FMC_MODEL, 2, 0);
+    aspeed_board_init_flashes(&soc->spi[0], AST2700FC_SPI_MODEL, 1, 2);
+
+    for (i = 0; i < soc->sdhci.num_slots; i++) {
+        sdhci_attach_drive(&soc->sdhci.slots[i],
+                           drive_get(IF_SD, 0, i), false, false);
+    }
+    boot_emmc = sc->boot_from_emmc(soc);
+
+    if (soc->emmc.num_slots) {
+        emmc0 = drive_get(IF_SD, 0, soc->sdhci.num_slots);
+        sdhci_attach_drive(&soc->emmc.slots[0], emmc0, true, boot_emmc);
+    }
+
+    if (!s->mmio_exec) {
+        DeviceState *dev = ssi_get_cs(soc->fmc.spi, 0);
+        BlockBackend *fmc0 = dev ? m25p80_get_blk(dev) : NULL;
+
+        if (fmc0 && !boot_emmc) {
+            uint64_t rom_size = memory_region_size(&soc->spi_boot);
+            ast2700fc_install_boot_rom(s, fmc0, rom_size);
+        } else if (emmc0) {
+            ast2700fc_install_boot_rom(s, blk_by_legacy_dinfo(emmc0), 64 * KiB);
+        }
+    }
+
+    ast2700fc_board_binfo.ram_size = machine->ram_size;
+    ast2700fc_board_binfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_binfo);
+}
+
+static void ast2700fc_ssp_init(MachineState *machine)
+{
+    AspeedSoCState *soc;
+    Ast2700FCState *s = AST2700FC(machine);
+    s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
+    clock_set_hz(s->ssp_sysclk, 200000000ULL);
+
+    object_initialize_child(OBJECT(s), "ssp", &s->ssp, "ast2700ssp-a0");
+    memory_region_init(&s->ssp_memory, OBJECT(&s->ssp), "ssp-memory",
+                       UINT64_MAX);
+
+    qdev_connect_clock_in(DEVICE(&s->ssp), "sysclk", s->ssp_sysclk);
+    object_property_set_link(OBJECT(&s->ssp), "memory", OBJECT(&s->ssp_memory),
+                             &error_abort);
+
+    soc = ASPEED_SOC(&s->ssp);
+    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
+    qdev_realize(DEVICE(&s->ssp), NULL, &error_abort);
+}
+
+static void ast2700fc_tsp_init(MachineState *machine)
+{
+    AspeedSoCState *soc;
+    Ast2700FCState *s = AST2700FC(machine);
+    s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
+    clock_set_hz(s->tsp_sysclk, 200000000ULL);
+
+    object_initialize_child(OBJECT(s), "tsp", &s->tsp, "ast2700tsp-a0");
+    memory_region_init(&s->tsp_memory, OBJECT(&s->tsp), "tsp-memory",
+                       UINT64_MAX);
+
+    qdev_connect_clock_in(DEVICE(&s->tsp), "sysclk", s->tsp_sysclk);
+    object_property_set_link(OBJECT(&s->tsp), "memory", OBJECT(&s->tsp_memory),
+                             &error_abort);
+
+    soc = ASPEED_SOC(&s->tsp);
+    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(2));
+    qdev_realize(DEVICE(&s->tsp), NULL, &error_abort);
+}
+
+static void ast2700fc_init(MachineState *machine)
+{
+    ast2700fc_ca35_init(machine);
+    ast2700fc_ssp_init(machine);
+    ast2700fc_tsp_init(machine);
+}
+
+static void ast2700fc_instance_init(Object *obj)
+{
+    AST2700FC(obj)->mmio_exec = false;
+}
+
+static void ast2700fc_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "ast2700 full cores support";
+    mc->init = ast2700fc_init;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->min_cpus = mc->max_cpus = mc->default_cpus = 6;
+}
+
+static const TypeInfo ast2700fc_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("ast2700fc"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = ast2700fc_class_init,
+        .instance_size  = sizeof(Ast2700FCState),
+        .instance_init  = ast2700fc_instance_init,
+    },
+};
+
+DEFINE_TYPES(ast2700fc_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index cd7780b997..7b99f78aed 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -47,7 +47,9 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-arm_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files('aspeed_ast27x0.c'))
+arm_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
+  'aspeed_ast27x0.c',
+  'aspeed_ast27x0-fc.c'))
 arm_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
 arm_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
 arm_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 7de69dc57d..f6b38a0666 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -129,6 +129,18 @@ struct Aspeed2600SoCState {
 #define TYPE_ASPEED2600_SOC "aspeed2600-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2600SoCState, ASPEED2600_SOC)
 
+struct Aspeed27x0CA35SoCState {
+    AspeedSoCState parent;
+
+    ARMCPU cpu[ASPEED_CPUS_NUM];
+    AspeedINTCState intc;
+    GICv3State gic;
+    MemoryRegion dram_empty;
+};
+
+#define TYPE_ASPEED27X0CA35_SOC "aspeed27x0ca35-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CA35SoCState, ASPEED27X0CA35_SOC)
+
 struct Aspeed27x0CM4SoCState {
     AspeedSoCState parent;
 
-- 
2.34.1


