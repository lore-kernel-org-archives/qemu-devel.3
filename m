Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D040C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrqr-0003pg-LU; Mon, 05 May 2025 05:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrnb-0008Rv-NW
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrnY-0006QB-Mh
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfNul9Pnmpg9XDMwR+0BDH8PRRWL8D5nnNWvz7sA+Mg=;
 b=NCaR8FM5Vq6ZEkpkLjNL/c8a0gkynITv0E6PyTa+CZQclgzyCKOTfjuZW1zpOJNKGF3cV8
 NPQYuRxfJKggq4BC6GqDq263GnNNIupkE2TCafcod3ZqiWPYnfqGbds7sITZAqDqCKVKNi
 CrmAp0wL2Q7bosbohIsdZRZZbkcz144=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-g-rLpsnIOoS2wi_3W1Llyg-1; Mon,
 05 May 2025 05:07:36 -0400
X-MC-Unique: g-rLpsnIOoS2wi_3W1Llyg-1
X-Mimecast-MFC-AGG-ID: g-rLpsnIOoS2wi_3W1Llyg_1746436055
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B52C1955DDA; Mon,  5 May 2025 09:07:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 974AF30001A2; Mon,  5 May 2025 09:07:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/23] hw/arm: Introduce ASPEED AST2700 A1 full core machine
Date: Mon,  5 May 2025 11:06:33 +0200
Message-ID: <20250505090635.778785-22-clg@redhat.com>
In-Reply-To: <20250505090635.778785-1-clg@redhat.com>
References: <20250505090635.778785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steven Lee <steven_lee@aspeedtech.com>

- Added new machine type `ast2700fc` with full core support.
- Defined `Ast2700FCState` structure for the new machine type.
- Implemented initialization functions for CA35, SSP, and TSP components.
- Updated `ast2700fc_types` to include the new machine type.
- Set machine class properties for `ast2700fc`.

Test Step:
- Download ast2700-default-obmc.tar.gz from AspeedTech-BMC OpenBmc
  release page.
- Run the following QEMU command:

  ```
  IMGDIR=~/path/to/image
  UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)

  ./qemu-system-aarch64 -machine ast2700fc \
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
Change-Id: I32447b9372a78eb53a07135afef59c2a19202328
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250502103449.3091642-8-steven_lee@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-fc.c | 192 +++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build         |   4 +-
 2 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/aspeed_ast27x0-fc.c

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
new file mode 100644
index 000000000000..125a3ade4092
--- /dev/null
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -0,0 +1,192 @@
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
+#define TYPE_AST2700A1FC MACHINE_TYPE_NAME("ast2700fc")
+OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700A1FC);
+
+static struct arm_boot_info ast2700fc_board_info = {
+    .board_id = -1, /* device-tree-only board */
+};
+
+struct Ast2700FCState {
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
+static void ast2700fc_ca35_init(MachineState *machine)
+{
+    Ast2700FCState *s = AST2700A1FC(machine);
+    AspeedSoCState *soc;
+    AspeedSoCClass *sc;
+
+    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");
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
+
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
+static void ast2700fc_ssp_init(MachineState *machine)
+{
+    AspeedSoCState *soc;
+    Ast2700FCState *s = AST2700A1FC(machine);
+    s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
+    clock_set_hz(s->ssp_sysclk, 200000000ULL);
+
+    object_initialize_child(OBJECT(s), "ssp", &s->ssp, TYPE_ASPEED27X0SSP_SOC);
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
+static void ast2700fc_tsp_init(MachineState *machine)
+{
+    AspeedSoCState *soc;
+    Ast2700FCState *s = AST2700A1FC(machine);
+    s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
+    clock_set_hz(s->tsp_sysclk, 200000000ULL);
+
+    object_initialize_child(OBJECT(s), "tsp", &s->tsp, TYPE_ASPEED27X0TSP_SOC);
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
+    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
+    if (!qdev_realize(DEVICE(&s->tsp), NULL, &error_abort)) {
+        return;
+    }
+}
+
+static void ast2700fc_init(MachineState *machine)
+{
+    ast2700fc_ca35_init(machine);
+    ast2700fc_ssp_init(machine);
+    ast2700fc_tsp_init(machine);
+}
+
+static void ast2700fc_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->alias = "ast2700fc";
+    mc->desc = "ast2700 full core support";
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
+    },
+};
+
+DEFINE_TYPES(ast2700fc_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 98c563150640..5098795f61de 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -49,7 +49,9 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files('aspeed_ast27x0.c'))
+arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
+  'aspeed_ast27x0.c',
+  'aspeed_ast27x0-fc.c',))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
 arm_common_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
-- 
2.49.0


