Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F62EC282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 05:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsbOx-00059s-Hj; Thu, 13 Mar 2025 01:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbOY-0004sH-J8; Thu, 13 Mar 2025 01:46:15 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbOW-0005Ve-MW; Thu, 13 Mar 2025 01:46:14 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 13 Mar
 2025 13:40:23 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 13 Mar 2025 13:40:23 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <yunlin.tang@aspeedtech.com>
Subject: [PATCH 09/13] hw/arm: Introduce ASPEED AST2700 a0 full core machine
Date: Thu, 13 Mar 2025 13:40:13 +0800
Message-ID: <20250313054020.2583556-10-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
References: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This commit introduces support for the ASPEED AST2700 full core
machine. It includes the initialization of CA35, SSP, and TSP components
with their respective memory regions and clocks. The new file
aspeed_ast27x0-fc.c defines the machine type "ast2700fc-a0" and its
initialization functions. Additionally, the meson.build file is updated
to include the new source file for the ASPEED SoC configuration.

Key features of the machine:
- The first four cores are Cortex-A35 cores.
- CPU 4 is designated as the SSP core (Cortex-M4).
- CPU 5 is designated as the TSP core (Cortex-M4).

Test Step:
- Download ast2700-a0-default-obmc.tar.gz and ast2700-a0-ssp-tsp.tar.gz
from AspeedTech-BMC OpenBmc release page.
- Run the following QEMU command:

  ```
  IMGDIR=~/path/to/image
  UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)

  ./qemu-system-aarch64 -machine ast2700fc-a0 \
  -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin \
  -device loader,force-raw=on,addr=$((0x400000000 + ${UBOOT_SIZE})),file=${IMGDIR}/u-boot.dtb \
  -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
  -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/tee-raw.bin \
  -device loader,cpu-num=0,addr=0x430000000 \
  -device loader,cpu-num=1,addr=0x430000000 \
  -device loader,cpu-num=2,addr=0x430000000 \
  -device loader,cpu-num=3,addr=0x430000000 \
  -device loader,file=${IMGDIR}/ast2700-ssp.elf,cpu-num=4 \
  -device loader,file=${IMGDIR}/ast2700-tsp.elf,cpu-num=5 \
  -drive file=${IMGDIR}/image-bmc,if=mtd,format=raw \
  -serial pty -serial pty -serial pty \
  -snapshot \
  -S -nographic
  ```

- After starting QEMU, serial devices will be redirected:

  char device redirected to /dev/pts/51 (label serial0)
  char device redirected to /dev/pts/52 (label serial1)
  char device redirected to /dev/pts/53 (label serial2)

- serial0 is the console for the four Cortex-A35 primary processors,
  serial1 and serial2 are the consoles for the two Cortex-M4 coprocessors.

- Connect to the consoles using a terminal emulator.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Change-Id: Ifebfd7a19be0f8bcbebb20b2116f1ea353f422ab
---
 hw/arm/aspeed_ast27x0-fc.c | 190 +++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build         |   4 +-
 2 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/aspeed_ast27x0-fc.c

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
new file mode 100644
index 0000000000..d03a1b5f1e
--- /dev/null
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -0,0 +1,190 @@
+/*
+ * ASPEED SoC 2700 family
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+
+#define TYPE_AST2700A0FC MACHINE_TYPE_NAME("ast2700fc-a0")
+OBJECT_DECLARE_SIMPLE_TYPE(Ast2700a0FCState, AST2700A0FC);
+
+static struct arm_boot_info ast2700fc_board_info = {
+    .board_id = -1, /* device-tree-only board */
+};
+
+struct Ast2700a0FCState {
+    MachineState parent_obj;
+
+    MemoryRegion ca35_memory;
+    MemoryRegion ca35_dram;
+    MemoryRegion ssp_memory;
+    MemoryRegion tsp_memory;
+
+    Clock *ssp_sysclk;
+    Clock *tsp_sysclk;
+
+    Aspeed27x0SoCState ca35;
+    Aspeed27x0SSPSoCState ssp;
+    Aspeed27x0TSPSoCState tsp;
+
+    bool mmio_exec;
+};
+
+#define AST2700FC_BMC_RAM_SIZE (2 * GiB)
+#define AST2700FC_CM4_DRAM_SIZE (32 * MiB)
+
+#define AST2700FC_HW_STRAP1 0x000000C0
+#define AST2700FC_HW_STRAP2 0x00000003
+#define AST2700FC_FMC_MODEL "w25q01jvq"
+#define AST2700FC_SPI_MODEL "w25q512jv"
+
+static void ast2700a0fc_ca35_init(MachineState *machine)
+{
+    Ast2700a0FCState *s = AST2700A0FC(machine);
+    AspeedSoCState *soc;
+    AspeedSoCClass *sc;
+
+    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a0");
+    soc = ASPEED_SOC(&s->ca35);
+    sc = ASPEED_SOC_GET_CLASS(soc);
+
+    memory_region_init(&s->ca35_memory, OBJECT(&s->ca35), "ca35-memory",
+                       UINT64_MAX);
+
+    if (!memory_region_init_ram(&s->ca35_dram, OBJECT(&s->ca35), "ca35-dram",
+                                AST2700FC_BMC_RAM_SIZE, &error_abort)) {
+        return;
+    }
+    if (!object_property_set_link(OBJECT(&s->ca35), "memory",
+                                  OBJECT(&s->ca35_memory),
+                                  &error_abort)) {
+        return;
+    };
+    if (!object_property_set_link(OBJECT(&s->ca35), "dram",
+                                  OBJECT(&s->ca35_dram), &error_abort)) {
+        return;
+    }
+    if (!object_property_set_int(OBJECT(&s->ca35), "ram-size",
+                                 AST2700FC_BMC_RAM_SIZE, &error_abort)) {
+        return;
+    }
+    if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap1",
+                                 AST2700FC_HW_STRAP1, &error_abort)) {
+        return;
+    }
+    if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
+                                 AST2700FC_HW_STRAP2, &error_abort)) {
+        return;
+    }
+    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
+    if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
+        return;
+    }
+    /*
+     * AST2700 EVB has a LM75 temperature sensor on I2C bus 0 at address 0x4d.
+     */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "tmp105", 0x4d);
+
+    aspeed_board_init_flashes(&soc->fmc, AST2700FC_FMC_MODEL, 2, 0);
+    aspeed_board_init_flashes(&soc->spi[0], AST2700FC_SPI_MODEL, 1, 2);
+
+    ast2700fc_board_info.ram_size = machine->ram_size;
+    ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
+}
+
+static void ast2700a0fc_ssp_init(MachineState *machine)
+{
+    AspeedSoCState *soc;
+    Ast2700a0FCState *s = AST2700A0FC(machine);
+    s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
+    clock_set_hz(s->ssp_sysclk, 200000000ULL);
+
+    object_initialize_child(OBJECT(s), "ssp", &s->ssp, "ast2700ssp-a0");
+    memory_region_init(&s->ssp_memory, OBJECT(&s->ssp), "ssp-memory",
+                       UINT64_MAX);
+
+    qdev_connect_clock_in(DEVICE(&s->ssp), "sysclk", s->ssp_sysclk);
+    if (!object_property_set_link(OBJECT(&s->ssp), "memory",
+                                  OBJECT(&s->ssp_memory), &error_abort)) {
+        return;
+    }
+
+    soc = ASPEED_SOC(&s->ssp);
+    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
+    if (!qdev_realize(DEVICE(&s->ssp), NULL, &error_abort)) {
+        return;
+    }
+}
+
+static void ast2700a0fc_tsp_init(MachineState *machine)
+{
+    AspeedSoCState *soc;
+    Ast2700a0FCState *s = AST2700A0FC(machine);
+    s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
+    clock_set_hz(s->tsp_sysclk, 200000000ULL);
+
+    object_initialize_child(OBJECT(s), "tsp", &s->tsp, "ast2700tsp-a0");
+    memory_region_init(&s->tsp_memory, OBJECT(&s->tsp), "tsp-memory",
+                       UINT64_MAX);
+
+    qdev_connect_clock_in(DEVICE(&s->tsp), "sysclk", s->tsp_sysclk);
+    if (!object_property_set_link(OBJECT(&s->tsp), "memory",
+                                  OBJECT(&s->tsp_memory), &error_abort)) {
+        return;
+    }
+
+    soc = ASPEED_SOC(&s->tsp);
+    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(2));
+    if (!qdev_realize(DEVICE(&s->tsp), NULL, &error_abort)) {
+        return;
+    }
+}
+
+static void ast2700a0fc_init(MachineState *machine)
+{
+    ast2700a0fc_ca35_init(machine);
+    ast2700a0fc_ssp_init(machine);
+    ast2700a0fc_tsp_init(machine);
+}
+
+static void ast2700a0fc_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "ast2700-a0 full core support";
+    mc->init = ast2700a0fc_init;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->min_cpus = mc->max_cpus = mc->default_cpus = 6;
+}
+
+static const TypeInfo ast2700fc_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("ast2700fc-a0"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = ast2700a0fc_class_init,
+        .instance_size  = sizeof(Ast2700a0FCState),
+    },
+};
+
+DEFINE_TYPES(ast2700fc_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index ac6657d3ec..b0923b45df 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -49,7 +49,9 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
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
-- 
2.34.1


