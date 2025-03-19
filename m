Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1413DC282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 02:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuj4Y-0007P1-Sz; Tue, 18 Mar 2025 22:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huangborong@bosc.ac.cn>)
 id 1tuj4V-0007O4-Hj; Tue, 18 Mar 2025 22:22:19 -0400
Received: from out28-74.mail.aliyun.com ([115.124.28.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huangborong@bosc.ac.cn>)
 id 1tuj4R-0006Si-7k; Tue, 18 Mar 2025 22:22:19 -0400
Received: from DESKTOP-MLVKPO8.(mailfrom:huangborong@bosc.ac.cn
 fp:SMTPD_---.bxmrF8z_1742350610 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 19 Mar 2025 10:16:57 +0800
From: Huang Borong <huangborong@bosc.ac.cn>
To: qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org,
 Huang Borong <huangborong@bosc.ac.cn>
Subject: [PATCH v1 2/2] hw/riscv: initial support for BOSC's Xiangshan
 Kunminghu SoC
Date: Wed, 19 Mar 2025 10:16:26 +0800
Message-Id: <20250319021626.11646-1-huangborong@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.74;
 envelope-from=huangborong@bosc.ac.cn; helo=out28-74.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

This implementation provides emulation for the Xiangshan Kunminghu SoC,
including support for UART, CLINT, IMSIC, and APLIC devices.
More details can be found at
https://github.com/OpenXiangShan/XiangShan

Please note the following parameters when running the Xiangshan Kunminghu machine:
1.`-m`: Configure RAM size of the machine.
1.`-cpu`: Only the `xiangshan-kunminghu` type is acceptable.
2.`-smp`: Specify the number of harts, ranging from 1 to 16.
3.`-bios`: This is the only parameter accepted by the Xiangshan Kunminghu machine
  to obtain the boot image. You need to compile and link the firmware, kernel,
  and Device Tree (FDT) into a single binary file, such as `fw_payload.bin`.

Signed-off-by: qinshaoqing <qinshaoqing@bosc.ac.cn>
Signed-off-by: Yang Wang <wangyang@bosc.ac.cn>
Signed-off-by: Yu Hu <huyu@bosc.ac.cn>
Signed-off-by: Ran Wang <wangran@bosc.ac.cn>
Signed-off-by: Borong Huang <huangborong@bosc.ac.cn>
---
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/riscv/Kconfig                            |   9 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/xiangshan_kmh.c                    | 214 ++++++++++++++++++++
 include/hw/riscv/xiangshan_kmh.h            |  77 +++++++
 5 files changed, 302 insertions(+)
 create mode 100644 hw/riscv/xiangshan_kmh.c
 create mode 100644 include/hw/riscv/xiangshan_kmh.h

diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
index 39ed3a0061..e485bbd1a3 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -11,3 +11,4 @@
 # CONFIG_RISCV_VIRT=n
 # CONFIG_MICROCHIP_PFSOC=n
 # CONFIG_SHAKTI_C=n
+# CONFIG_XIANGSHAN_KUNMINGHU=n
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e6a0ac1fa1..fc9c35bd98 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -119,3 +119,12 @@ config SPIKE
     select HTIF
     select RISCV_ACLINT
     select SIFIVE_PLIC
+
+config XIANGSHAN_KUNMINGHU
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_ACLINT
+    select RISCV_APLIC
+    select RISCV_IMSIC
+    select SERIAL_MM
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index c22f3a7216..2a8d5b136c 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -13,5 +13,6 @@ riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
+riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
new file mode 100644
index 0000000000..c64b7fc2c7
--- /dev/null
+++ b/hw/riscv/xiangshan_kmh.c
@@ -0,0 +1,214 @@
+/*
+ * Xiangshan Kunminghu SoC emulation
+ *
+ * Copyright (c) 2025 Beijing Institute of Open Source Chip (BOSC)
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides a board compatible with the Xiangshan Kunminghu SoC platform:
+ *
+ * 0) UART (16550A)
+ * 1) CLINT (Core-Local Interruptor)
+ * 2) IMSIC (Incoming MSI Controller)
+ * 3) APLIC (Advanced Platform-Level Interrupt Controller)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
+#include "hw/boards.h"
+#include "hw/char/serial-mm.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+#include "hw/qdev-properties.h"
+#include "hw/riscv/boot.h"
+#include "hw/riscv/xiangshan_kmh.h"
+#include "hw/riscv/riscv_hart.h"
+#include "system/system.h"
+
+static const MemMapEntry xiangshan_kmh_memmap[] = {
+    [XIANGSHAN_KMH_ROM] =          {     0x1000,        0xF000 },
+    [XIANGSHAN_KMH_UART0] =        { 0x310B0000,       0x10000 },
+    [XIANGSHAN_KMH_CLINT] =        { 0x38000000,       0x10000 },
+    [XIANGSHAN_KMH_APLIC_M] =      { 0x31100000,        0x4000 },
+    [XIANGSHAN_KMH_APLIC_S] =      { 0x31120000,        0x4000 },
+    [XIANGSHAN_KMH_IMSIC_M] =      { 0x3A800000,       0x10000 },
+    [XIANGSHAN_KMH_IMSIC_S] =      { 0x3B000000,       0x80000 },
+    [XIANGSHAN_KMH_DRAM] =         { 0x80000000,           0x0 },
+};
+
+static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
+{
+    int i;
+    const MemMapEntry *memmap = xiangshan_kmh_memmap;
+    hwaddr addr = 0;
+    DeviceState *aplic_m = NULL;
+
+    /* M-level IMSICs */
+    addr = memmap[XIANGSHAN_KMH_IMSIC_M].base;
+    for (i = 0; i < num_harts; i++) {
+        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0), i, true,
+                           1, XIANGSHAN_KMH_IMSIC_NUM_IDS);
+    }
+
+    /* S-level IMSICs */
+    addr = memmap[XIANGSHAN_KMH_IMSIC_S].base;
+    for (i = 0; i < num_harts; i++) {
+        riscv_imsic_create(addr +
+                           i * IMSIC_HART_SIZE(XIANGSHAN_KMH_IMSIC_GUEST_BITS),
+                           i, false, 1 + XIANGSHAN_KMH_IMSIC_GUEST_BITS,
+                           XIANGSHAN_KMH_IMSIC_NUM_IDS);
+    }
+
+    /* M-level APLIC */
+    aplic_m = riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_M].base,
+                                 memmap[XIANGSHAN_KMH_APLIC_M].size,
+                                 0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
+                                 1, true, true, NULL);
+
+    /* S-level APLIC */
+    riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_S].base,
+                       memmap[XIANGSHAN_KMH_APLIC_S].size,
+                       0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
+                       1, true, false, aplic_m);
+
+    return aplic_m;
+}
+
+static void xiangshan_kmh_soc_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    XiangshanKmhSoCState *s = XIANGSHAN_KMH_SOC(dev);
+    const MemMapEntry *memmap = xiangshan_kmh_memmap;
+    MemoryRegion *system_memory = get_system_memory();
+    uint32_t num_harts = ms->smp.cpus;
+
+    qdev_prop_set_uint32(DEVICE(&s->cpus), "num-harts", num_harts);
+    qdev_prop_set_uint32(DEVICE(&s->cpus), "hartid-base", 0);
+    qdev_prop_set_string(DEVICE(&s->cpus), "cpu-type",
+                         TYPE_RISCV_CPU_XIANGSHAN_KMH);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
+
+    /* AIA */
+    s->irqchip = xiangshan_kmh_create_aia(num_harts);
+
+    /* UART */
+    serial_mm_init(system_memory, memmap[XIANGSHAN_KMH_UART0].base, 2,
+                   qdev_get_gpio_in(s->irqchip, XIANGSHAN_KMH_UART0_IRQ),
+                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    /* CLINT */
+    riscv_aclint_swi_create(memmap[XIANGSHAN_KMH_CLINT].base,
+                            0, num_harts, false);
+    riscv_aclint_mtimer_create(memmap[XIANGSHAN_KMH_CLINT].base +
+                               RISCV_ACLINT_SWI_SIZE,
+                               RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                               0, num_harts, RISCV_ACLINT_DEFAULT_MTIMECMP,
+                               RISCV_ACLINT_DEFAULT_MTIME,
+                               XIANGSHAN_KMH_CLINT_TIMEBASE_FREQ, true);
+
+    /* ROM */
+    memory_region_init_rom(&s->rom, OBJECT(dev), "xiangshan.kunminghu.rom",
+                           memmap[XIANGSHAN_KMH_ROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                memmap[XIANGSHAN_KMH_ROM].base, &s->rom);
+}
+
+static void xiangshan_kmh_soc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = xiangshan_kmh_soc_realize;
+    dc->user_creatable = false;
+}
+
+static void xiangshan_kmh_soc_instance_init(Object *obj)
+{
+    XiangshanKmhSoCState *s = XIANGSHAN_KMH_SOC(obj);
+
+    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
+}
+
+static const TypeInfo xiangshan_kmh_soc_info = {
+    .name = TYPE_XIANGSHAN_KMH_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(XiangshanKmhSoCState),
+    .instance_init = xiangshan_kmh_soc_instance_init,
+    .class_init = xiangshan_kmh_soc_class_init,
+};
+
+static void xiangshan_kmh_soc_register_types(void)
+{
+    type_register_static(&xiangshan_kmh_soc_info);
+}
+type_init(xiangshan_kmh_soc_register_types)
+
+static void xiangshan_kmh_machine_init(MachineState *machine)
+{
+    XiangshanKmhState *s = XIANGSHAN_KMH_MACHINE(machine);
+    const MemMapEntry *memmap = xiangshan_kmh_memmap;
+    MemoryRegion *system_memory = get_system_memory();
+    hwaddr start_addr = memmap[XIANGSHAN_KMH_DRAM].base;
+
+    /* Initialize SoC */
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_XIANGSHAN_KMH_SOC);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+
+    /* Register RAM */
+    memory_region_add_subregion(system_memory,
+                                memmap[XIANGSHAN_KMH_DRAM].base,
+                                machine->ram);
+
+    /* ROM reset vector */
+    riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
+                              start_addr,
+                              memmap[XIANGSHAN_KMH_ROM].base,
+                              memmap[XIANGSHAN_KMH_ROM].size, 0, 0);
+    if (machine->firmware) {
+        riscv_load_firmware(machine->firmware, &start_addr, NULL);
+    }
+
+    /* Note: dtb has been integrated into firmware(OpenSBI) when compiling */
+}
+
+static void xiangshan_kmh_machine_class_init(ObjectClass *klass, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(klass);
+    static const char *const valid_cpu_types[] = {
+        TYPE_RISCV_CPU_XIANGSHAN_KMH,
+        NULL
+    };
+
+    mc->desc = "RISC-V Board compatible with Xiangshan Kunminghu SoC platform";
+    mc->init = xiangshan_kmh_machine_init;
+    mc->max_cpus = XIANGSHAN_KMH_MAX_CPUS;
+    mc->default_cpu_type = TYPE_RISCV_CPU_XIANGSHAN_KMH;
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->default_ram_id = "xiangshan.kunminghu.ram";
+}
+
+static const TypeInfo xiangshan_kmh_machine_info = {
+    .name = TYPE_XIANGSHAN_KMH_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(XiangshanKmhState),
+    .class_init = xiangshan_kmh_machine_class_init,
+};
+
+static void xiangshan_kmh_machine_register_types(void)
+{
+    type_register_static(&xiangshan_kmh_machine_info);
+}
+type_init(xiangshan_kmh_machine_register_types)
diff --git a/include/hw/riscv/xiangshan_kmh.h b/include/hw/riscv/xiangshan_kmh.h
new file mode 100644
index 0000000000..41ce1eb69e
--- /dev/null
+++ b/include/hw/riscv/xiangshan_kmh.h
@@ -0,0 +1,77 @@
+/*
+ * Xiangshan Kunminghu SoC emulation
+ *
+ * Copyright (c) 2025 Beijing Institute of Open Source Chip (BOSC)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_XIANGSHAN_KMH_H
+#define HW_XIANGSHAN_KMH_H
+
+#include "hw/boards.h"
+#include "hw/riscv/riscv_hart.h"
+
+#define XIANGSHAN_KMH_MAX_CPUS 16
+
+typedef struct XiangshanKmhSoCState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    RISCVHartArrayState cpus;
+    DeviceState *irqchip;
+    MemoryRegion rom;
+} XiangshanKmhSoCState;
+
+#define TYPE_XIANGSHAN_KMH_SOC "xiangshan.kunminghu.soc"
+DECLARE_INSTANCE_CHECKER(XiangshanKmhSoCState, XIANGSHAN_KMH_SOC,
+                         TYPE_XIANGSHAN_KMH_SOC)
+
+typedef struct XiangshanKmhState {
+    /*< private >*/
+    MachineState parent_obj;
+
+    /*< public >*/
+    XiangshanKmhSoCState soc;
+} XiangshanKmhState;
+
+#define TYPE_XIANGSHAN_KMH_MACHINE MACHINE_TYPE_NAME("xiangshan-kunminghu")
+DECLARE_INSTANCE_CHECKER(XiangshanKmhState, XIANGSHAN_KMH_MACHINE,
+                         TYPE_XIANGSHAN_KMH_MACHINE)
+
+enum {
+    XIANGSHAN_KMH_ROM,
+    XIANGSHAN_KMH_UART0,
+    XIANGSHAN_KMH_CLINT,
+    XIANGSHAN_KMH_APLIC_M,
+    XIANGSHAN_KMH_APLIC_S,
+    XIANGSHAN_KMH_IMSIC_M,
+    XIANGSHAN_KMH_IMSIC_S,
+    XIANGSHAN_KMH_DRAM,
+};
+
+enum {
+    XIANGSHAN_KMH_UART0_IRQ = 10,
+};
+
+/* Indicating Timebase-freq (1MHZ) */
+#define XIANGSHAN_KMH_CLINT_TIMEBASE_FREQ 1000000
+
+#define XIANGSHAN_KMH_IMSIC_NUM_IDS 255
+#define XIANGSHAN_KMH_IMSIC_NUM_GUESTS 7
+#define XIANGSHAN_KMH_IMSIC_GUEST_BITS 3
+
+#define XIANGSHAN_KMH_APLIC_NUM_SOURCES 96
+
+#endif
-- 
2.34.1


