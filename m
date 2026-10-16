Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE84CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHcze-0003sz-KX; Fri, 16 Oct 2026 04:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHczP-0003pJ-SI; Fri, 16 Oct 2026 04:08:33 -0400
Received: from mailsender.cdac.in ([196.1.113.117]
 helo=mailsender-core1.pune.cdac.in)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHczK-0005xf-Ki; Fri, 16 Oct 2026 04:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
 t=1792138086; bh=KiWcE4WCJ1a/zJGVsIfItYxBqmqXpYzt76ubD+KXQ7s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hIY/rGWS6KZpSOuhsigZfMOToXO10xCc8IcotWB18mQhXO65R/29RhX90ppsXcCF+
 xKYvtzBKL6KUFRfcBFz6rlpSrhXf41pwD9imiz/JYIQMahlHFS43pEW0OrdAykTQab
 kIRucfDMTJSikDAmqPpZVYHjdwmEgK9PqCgmHSm0=
Received: from mscr-int2.pune.cdac.in (mscr-int2.pune.cdac.in [10.208.193.12])
 by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69G880pH3825216; Fri, 16 Oct 2026 13:38:01 +0530
Received: from mailgw-cip.pune.cdac.in (mscr-haproxy.pune.cdac.in
 [10.208.193.46])
 by mscr-int2.pune.cdac.in (Postfix) with ESMTP id 4D45B100234DA;
 Fri, 16 Oct 2026 13:37:50 +0530 (IST)
X-Auth: karthika.b@cdac.in
Received: from hdg164.tvm.cdac.in (hd_hdg164.tvm.cdac.in [10.176.18.107])
 (Authenticated sender: karthika.b@cdac.in)
 by mailgw-cip.pune.cdac.in (Postfix) with ESMTPSA id C3E9414E17D2;
 Fri, 16 Oct 2026 13:37:49 +0530 (IST)
From: Karthika B <karthika.b@cdac.in>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, sreenadh@cdac.in, raokk@cdac.in,
 Karthika B <karthika.b@cdac.in>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH 4/7] hw/riscv: Add CDAC VEGA machine model
Date: Fri, 16 Oct 2026 13:37:04 +0530
Message-ID: <20261016080709.17331-5-karthika.b@cdac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016080709.17331-1-karthika.b@cdac.in>
References: <385625713.441366.1761727810206@webmail2.cdac.in>
 <20261016080709.17331-1-karthika.b@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more
 information
X-CDAC-PUNE-MailScanner-ID: 4D45B100234DA.A259C
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.999, required 6, ALL_TRUSTED -1.00, URIBL_BLOCKED 0.00)
X-CDAC-PUNE-MailScanner-From: karthika.b@cdac.in
Received-SPF: pass client-ip=196.1.113.117; envelope-from=karthika.b@cdac.in;
 helo=mailsender-core1.pune.cdac.in
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Karthika B <karthika.b@cdac.in>
---
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/riscv/Kconfig                            |  11 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/vega.c                             | 502 ++++++++++++++++++++
 include/hw/riscv/vega.h                     | 136 ++++++
 5 files changed, 651 insertions(+)
 create mode 100644 hw/riscv/vega.c
 create mode 100644 include/hw/riscv/vega.h

diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
index a8e4d0ab33..5454fded22 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -11,5 +11,6 @@
 # CONFIG_RISCV_VIRT=n
 # CONFIG_MICROCHIP_PFSOC=n
 # CONFIG_SHAKTI_C=n
+# CONFIG_VEGA=n
 # CONFIG_XIANGSHAN_KUNMINGHU=n
 # CONFIG_MIPS_BOSTON_AIA=n
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 2518b04175..dc95cad9d8 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -120,6 +120,17 @@ config SPIKE
     select RISCV_ACLINT
     select SIFIVE_PLIC
 
+config VEGA
+    bool
+    default y
+    depends on RISCV32 || RISCV64
+    select DEVICE_TREE
+    select RISCV_NUMA
+    select SERIAL_MM
+    select VEGA_ACLINT
+    select VEGA_PLIC
+    select VIRTIO_MMIO
+
 config XIANGSHAN_KUNMINGHU
     bool
     default y
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 533472e22a..74bea26bef 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -13,6 +13,7 @@ riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
+riscv_ss.add(when: 'CONFIG_VEGA', if_true: files('vega.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
 
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
diff --git a/hw/riscv/vega.c b/hw/riscv/vega.c
new file mode 100644
index 0000000000..835c90571a
--- /dev/null
+++ b/hw/riscv/vega.c
@@ -0,0 +1,502 @@
+/*
+ * QEMU RISC-V VEGA SoC machine emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2025 C-DAC (Centre for Development of Advanced Computing)
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
+#include "qemu/error-report.h"
+#include "qemu/guest-random.h"
+#include "qapi/error.h"
+#include "hw/core/boards.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/char/serial-mm.h"
+#include "target/riscv/cpu.h"
+#include "target/riscv/pmu.h"
+#include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/vega.h"
+#include "hw/riscv/machines-qom.h"
+#include "hw/riscv/boot.h"
+#include "hw/riscv/numa.h"
+#include "kvm/kvm_riscv.h"
+#include "hw/intc/vega_aclint.h"
+#include "hw/intc/vega_plic.h"
+#include "hw/misc/sifive_test.h"
+#include "chardev/char.h"
+#include "system/device_tree.h"
+#include "system/system.h"
+#include "system/tcg.h"
+#include "system/kvm.h"
+#include "system/qtest.h"
+#include "hw/misc/unimp.h"
+
+static bool vega_aclint_allowed(void)
+{
+    return tcg_enabled() || qtest_enabled();
+}
+
+/*
+ * Memory map — entries match the enum in vega.h exactly, same order.
+ * DRAM size is filled in from machine->ram_size during vega_machine_init.
+ */
+static MemMapEntry vega_memmap[] = {
+    [VEGA_DEBUG]       = {        0x0,         0x100 },
+    [VEGA_MROM]        = {     0x1000,        0xf000 },
+    [VEGA_TEST]        = {   0x100000,        0x1000 },
+    [VEGA_CLINT]       = { 0x20010000,       0x10000 },
+    [VEGA_ACLINT_SSWI] = {  0x3F00000,        0x4000 },
+    [VEGA_PLIC_ID]     = { 0x20010000,         0x400 },
+    [VEGA_UART0]       = { 0x10000100,         0x100 },
+#if defined(TARGET_RISCV32)
+    [VEGA_DRAM] = { 0x200000, 0x0 },
+#else
+    [VEGA_DRAM] = { 0x400000000, 0x0 },
+#endif
+    [VEGA_SRAM]        = {    0x20000,       0x10000 },
+    [VEGA_UART1]       = { 0x10000200,         0x100 },
+    [VEGA_UART2]       = { 0x10000300,         0x100 },
+    [VEGA_UART3]       = { 0x10000400,         0x100 },
+    [VEGA_UART4]       = { 0x10000500,         0x100 },
+    [VEGA_SPI0]        = { 0x10000600,         0x100 },
+    [VEGA_SPI1]        = { 0x10000700,         0x100 },
+    [VEGA_IIC0]        = { 0x10000800,         0x100 },
+    [VEGA_IIC1]        = { 0x10000900,         0x100 },
+    [VEGA_SDHCI]       = { 0x20040000,        0x1000 },
+    [VEGA_VIRTIO]      = { 0x10002000,         0x100 },
+};
+
+/*
+ * UART init
+ *
+ * Baremetal (no DTB / no-fdt=on):
+ *   Always use shift=2 / io-width=4. The CDAC UART places every 16550
+ *   register at a 4-byte boundary on a 32-bit bus.
+ *
+ * Linux (-dtb supplied):
+ *   Read reg-shift and reg-io-width from the /soc/serial node in the DTB.
+ *   If absent, the baremetal defaults are kept.
+ */
+
+static void vega_uart_init(RISCVVegaState *s, MachineState *machine,
+                           MemoryRegion *system_memory,
+                           DeviceState *mmio_irqchip)
+{
+    int reg_shift = VEGA_UART_DEFAULT_REGSHIFT;
+
+    /*
+     * Linux boot path: -kernel bbl -dtb riscv.dtb
+     *   machine->dtb is set → read reg-shift from the DTB uart node.
+     *
+     * Baremetal path: -bios baremetal.elf
+     *   machine->firmware is set, machine->dtb is NULL →
+     *   use the hardware default (shift=2, 4-byte stride).
+     */
+    /*
+     * machine->dtb is set when the user passes -dtb <file>.
+     * machine->fdt is only non-NULL after load_device_tree() has run.
+     * Both must be checked: dtb may be set but fdt not yet loaded when
+     * vega_uart_init is called early in vega_machine_init.
+     */
+    if (machine->dtb && machine->fdt) {
+        char uart_path[64];
+        int  val = 0;
+        snprintf(uart_path, sizeof(uart_path), "/soc/serial@%lx",
+                 (unsigned long)s->memmap[VEGA_UART0].base);
+        if (qemu_fdt_getprop_cell(machine->fdt, uart_path,
+                                  "reg-shift", &val, NULL) == 0)
+            reg_shift = val;
+    }
+
+    serial_mm_init(system_memory,
+                   s->memmap[VEGA_UART0].base,
+                   reg_shift,
+                   qdev_get_gpio_in(mmio_irqchip, UART0_IRQ),
+                   399193,
+                   serial_hd(0),
+                   DEVICE_LITTLE_ENDIAN);
+}
+
+/*
+ * VIRTIO-MMIO: QEMU-side device realization
+ *
+ * Instantiates the actual virtio-mmio transport slots so that -device
+ * virtio-*-device has a virtio-bus to attach to. VEGA does not generate
+ * its own FDT (see vega_machine_init below) — the caller is responsible
+ * for supplying a -dtb whose virtio_mmio nodes match these addresses and
+ * IRQs exactly.
+ */
+static void vega_virtio_init(RISCVVegaState *s, DeviceState *mmio_irqchip)
+{
+    int i;
+
+    for (i = 0; i < VEGA_VIRTIO_COUNT; i++) {
+        hwaddr addr = s->memmap[VEGA_VIRTIO].base +
+                      i * s->memmap[VEGA_VIRTIO].size;
+
+        sysbus_create_simple("virtio-mmio", addr,
+                             qdev_get_gpio_in(mmio_irqchip,
+                                              VEGA_VIRTIO_IRQ + i));
+    }
+}
+
+/* PLIC creation */
+
+static DeviceState *vega_create_plic(const MemMapEntry *memmap, int socket,
+                                     int base_hartid, int hart_count)
+{
+    g_autofree char *plic_hart_config =
+        riscv_plic_hart_config_string(hart_count);
+
+    return vega_plic_create(
+             memmap[VEGA_PLIC_ID].base + socket * memmap[VEGA_PLIC_ID].size,
+             plic_hart_config, hart_count, base_hartid,
+             VEGA_IRQCHIP_NUM_SOURCES,
+             ((1U << VEGA_IRQCHIP_NUM_PRIO_BITS) - 1),
+             VEGA_PLIC_PRIORITY_BASE, VEGA_PLIC_PENDING_BASE,
+             VEGA_PLIC_ENABLE_BASE,   VEGA_PLIC_ENABLE_STRIDE,
+             VEGA_PLIC_CONTEXT_BASE,  VEGA_PLIC_CONTEXT_STRIDE,
+             memmap[VEGA_PLIC_ID].size);
+}
+
+/* Machine done notifier */
+
+static void vega_machine_done(Notifier *notifier, void *data)
+{
+    RISCVVegaState *s = container_of(notifier, RISCVVegaState, machine_done);
+    MachineState *machine = MACHINE(s);
+    hwaddr start_addr = s->memmap[VEGA_DRAM].base;
+    target_ulong firmware_end_addr, kernel_start_addr;
+    const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
+    uint64_t fdt_load_addr = 0;
+    uint64_t kernel_entry  = 0;
+    RISCVBootInfo boot_info;
+
+    /*
+     * Baremetal path (-bios baremetal.elf, no -dtb):
+     *   machine->firmware is set and machine->dtb is NULL.
+     *   Load the ELF via the firmware slot, set the reset vector to the
+     *   ELF entry point, and return — no DTB is generated or loaded.
+     */
+    if (machine->firmware && strcmp(machine->firmware, "none") != 0
+            && !machine->dtb) {
+        firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+                                                         &start_addr, NULL);
+        (void)firmware_end_addr;
+        riscv_boot_info_init(&boot_info, &s->soc[0]);
+        riscv_setup_rom_reset_vec(machine, &s->soc[0],
+                                  s->memmap[VEGA_DRAM].base,
+                                  s->memmap[VEGA_MROM].base,
+                                  s->memmap[VEGA_MROM].size,
+                                  0, 0);
+        return;
+    }
+
+    /*
+     * Nothing to boot at all: no -kernel, no -dtb, no real -bios firmware.
+     * This is a valid, inert machine state (e.g. qtest's generic qom/hmp
+     * smoke tests just instantiate "-M vega" with nothing to run). The
+     * rest of this function assumes machine->fdt exists in order to
+     * compute an FDT load address and place a kernel, so it must not run
+     * in this case.
+     */
+    if (!machine->kernel_filename && !machine->dtb
+            && (!machine->firmware || !strcmp(machine->firmware, "none"))) {
+        return;
+    }
+
+    if (kvm_enabled()) {
+        if (machine->firmware) {
+            if (strcmp(machine->firmware, "none")) {
+                error_report("Machine mode firmware is not supported with KVM.");
+                exit(1);
+            }
+        } else {
+            machine->firmware = g_strdup("none");
+        }
+    }
+
+    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+                                                     &start_addr, NULL);
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
+
+    if (machine->kernel_filename && !kernel_entry) {
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
+                                                         firmware_end_addr);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr, true, NULL);
+        kernel_entry = boot_info.image_low_addr;
+    }
+
+    /*
+     * Use machine->ram_size (not s->memmap[VEGA_DRAM].size) so that the DTB
+     * is placed at the top of actual RAM.  DRAM size is set in the memmap for
+     * MMIO range registration but ram_size is the authoritative value for
+     * address-space arithmetic here.
+     */
+    fdt_load_addr = riscv_compute_fdt_addr(s->memmap[VEGA_DRAM].base,
+                                           machine->ram_size,
+                                           machine, &boot_info);
+    riscv_load_fdt(fdt_load_addr, machine->fdt);
+    riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
+                              s->memmap[VEGA_MROM].base,
+                              s->memmap[VEGA_MROM].size,
+                              kernel_entry, fdt_load_addr);
+    if (kvm_enabled()) {
+        riscv_setup_direct_kernel(kernel_entry, fdt_load_addr);
+    }
+}
+
+/* Machine init */
+
+static void vega_machine_init(MachineState *machine)
+{
+    RISCVVegaState *s = RISCV_VEGA_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    DeviceState *mmio_irqchip = NULL;
+    int i, base_hartid, hart_count;
+    int socket_count = riscv_socket_count(machine);
+
+    s->memmap = vega_memmap;
+
+    if (VEGA_SOCKETS_MAX < socket_count) {
+        error_report("number of sockets/nodes should be less than %d",
+                     VEGA_SOCKETS_MAX);
+        exit(1);
+    }
+    if (!vega_aclint_allowed() && s->have_aclint) {
+        error_report("'aclint' is only available with TCG acceleration");
+        exit(1);
+    }
+
+    for (i = 0; i < socket_count; i++) {
+        g_autofree char *soc_name = g_strdup_printf("soc%d", i);
+
+        if (!riscv_socket_check_hartids(machine, i)) {
+            error_report("discontinuous hartids in socket%d", i); exit(1);
+        }
+        base_hartid = riscv_socket_first_hartid(machine, i);
+        if (base_hartid < 0) {
+            error_report("can't find hartid base for socket%d", i); exit(1);
+        }
+        hart_count = riscv_socket_hart_count(machine, i);
+        if (hart_count < 0) {
+            error_report("can't find hart count for socket%d", i); exit(1);
+        }
+
+        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
+                                TYPE_RISCV_HART_ARRAY);
+        object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
+                                machine->cpu_type, &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
+                                base_hartid, &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]), "num-harts",
+                                hart_count, &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
+
+        /* Timer */
+        if (vega_aclint_allowed() && s->have_aclint) {
+            vega_aclint_swi_create(
+                s->memmap[VEGA_CLINT].base + i * s->memmap[VEGA_CLINT].size,
+                base_hartid, hart_count, false);
+            vega_aclint_mtimer_create(
+                s->memmap[VEGA_CLINT].base + i * s->memmap[VEGA_CLINT].size +
+                    VEGA_ACLINT_SWI_SIZE,
+                VEGA_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
+                VEGA_ACLINT_DEFAULT_MTIMECMP, VEGA_ACLINT_DEFAULT_MTIME,
+                VEGA_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
+            vega_aclint_swi_create(
+                s->memmap[VEGA_ACLINT_SSWI].base +
+                    i * s->memmap[VEGA_ACLINT_SSWI].size,
+                base_hartid, hart_count, true);
+        } else if (tcg_enabled()) {
+            vega_aclint_swi_create(
+                s->memmap[VEGA_CLINT].base + i * s->memmap[VEGA_CLINT].size +
+                    VEGA_CLINT_MSWI_OFFSET,
+                base_hartid, hart_count, false);
+            vega_aclint_mtimer_create(
+                s->memmap[VEGA_CLINT].base + i * s->memmap[VEGA_CLINT].size +
+                    VEGA_ACLINT_SWI_SIZE,
+                VEGA_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
+                VEGA_ACLINT_DEFAULT_MTIMECMP, VEGA_ACLINT_DEFAULT_MTIME,
+                VEGA_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
+        }
+
+        s->irqchip[i] = vega_create_plic(s->memmap, i,
+                                         base_hartid, hart_count);
+
+        if (i == 0) {
+            mmio_irqchip = s->irqchip[i];
+        }
+    }
+
+    /* DRAM — set base and size before any FDT address computation */
+    if (!s->dram_base) {
+        s->dram_base = vega_memmap[VEGA_DRAM].base;
+        warn_report("dram-base not specified, using default 0x%"PRIx64,
+                    s->dram_base);
+    } else {
+        vega_memmap[VEGA_DRAM].base = s->dram_base;
+    }
+    vega_memmap[VEGA_DRAM].size = machine->ram_size;
+
+    memory_region_add_subregion(system_memory, s->memmap[VEGA_DRAM].base,
+                                machine->ram);
+
+    /* SRAM */
+    {
+        MemoryRegion *sram = g_new(MemoryRegion, 1);
+        memory_region_init_ram(sram, NULL, "riscv_vega_board.sram",
+                               s->memmap[VEGA_SRAM].size, &error_fatal);
+        memory_region_add_subregion(system_memory,
+                                    s->memmap[VEGA_SRAM].base, sram);
+    }
+
+    /* Boot ROM */
+    memory_region_init_rom(mask_rom, NULL, "riscv_vega_board.mrom",
+                           s->memmap[VEGA_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[VEGA_MROM].base, mask_rom);
+
+    /* SiFive Test device — reboot / poweroff */
+    sifive_test_create(s->memmap[VEGA_TEST].base);
+
+    /* UART0 — shift/width from DTB (Linux) or hardcoded defaults (baremetal) */
+    vega_uart_init(s, machine, system_memory, mmio_irqchip);
+
+    /*
+     * VIRTIO-MMIO — must match whatever the user's -dtb describes.
+     * VEGA does not generate its own FDT (see below); the caller is
+     * responsible for supplying a DTB whose virtio_mmio nodes match
+     * these addresses/IRQs exactly.
+     */
+    vega_virtio_init(s, mmio_irqchip);
+
+    /* Peripheral address stubs */
+    create_unimplemented_device("vega.uart1",
+        s->memmap[VEGA_UART1].base, s->memmap[VEGA_UART1].size);
+    create_unimplemented_device("vega.uart2",
+        s->memmap[VEGA_UART2].base, s->memmap[VEGA_UART2].size);
+    create_unimplemented_device("vega.uart3",
+        s->memmap[VEGA_UART3].base, s->memmap[VEGA_UART3].size);
+    create_unimplemented_device("vega.uart4",
+        s->memmap[VEGA_UART4].base, s->memmap[VEGA_UART4].size);
+    create_unimplemented_device("vega.spi0",
+        s->memmap[VEGA_SPI0].base, s->memmap[VEGA_SPI0].size);
+    create_unimplemented_device("vega.spi1",
+        s->memmap[VEGA_SPI1].base, s->memmap[VEGA_SPI1].size);
+    create_unimplemented_device("vega.i2c0",
+        s->memmap[VEGA_IIC0].base, s->memmap[VEGA_IIC0].size);
+    create_unimplemented_device("vega.i2c1",
+        s->memmap[VEGA_IIC1].base, s->memmap[VEGA_IIC1].size);
+    create_unimplemented_device("vega.sdhci",
+        s->memmap[VEGA_SDHCI].base, s->memmap[VEGA_SDHCI].size);
+
+    /* VIRTIO_MMIO */
+    for (i = 0; i < VEGA_VIRTIO_COUNT; i++) {
+        sysbus_create_simple("virtio-mmio",
+            s->memmap[VEGA_VIRTIO].base + i * s->memmap[VEGA_VIRTIO].size,
+            qdev_get_gpio_in(mmio_irqchip, VEGA_VIRTIO_IRQ + i));
+    }
+
+    /*
+     * Device tree:
+     *   Linux (-kernel + -dtb): load the user-supplied DTB.
+     *   Baremetal (-bios): skip entirely — no DTB needed.
+     *   Linux without -dtb is not currently supported.
+     */
+    if (machine->dtb) {
+        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
+        if (!machine->fdt) {
+            error_report("load_device_tree() failed");
+            exit(1);
+        }
+    } else if (machine->firmware && strcmp(machine->firmware, "none") != 0) {
+        /* baremetal: no DTB needed, handled entirely in vega_machine_done */
+    } else if (machine->kernel_filename) {
+        /*
+         * Only a -kernel boot actually needs a DTB. A bare machine
+         * instantiation with neither -kernel nor -bios (e.g. qtest's
+         * generic qom/hmp smoke tests, or a user just probing -M vega)
+         * is a valid, inert state and must not be treated as an error.
+         */
+        error_report("VEGA requires -dtb when booting with -kernel; "
+                     "internal device-tree generation is not yet supported");
+        exit(1);
+    }
+
+    s->machine_done.notify = vega_machine_done;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
+}
+
+/* Instance init */
+
+static void vega_machine_instance_init(Object *obj)
+{
+    RISCVVegaState *s = RISCV_VEGA_MACHINE(obj);
+
+    object_property_add_uint64_ptr(obj, "dram-base", &s->dram_base,
+                                   OBJ_PROP_FLAG_WRITE);
+    object_property_set_description(obj, "dram-base",
+        "Base address of DRAM");
+}
+
+static bool vega_get_aclint(Object *obj, Error **errp)
+{
+    return RISCV_VEGA_MACHINE(obj)->have_aclint;
+}
+
+static void vega_set_aclint(Object *obj, bool value, Error **errp)
+{
+    RISCV_VEGA_MACHINE(obj)->have_aclint = value;
+}
+
+/* Class init */
+
+static void vega_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc                        = "CDAC VEGA series RISC-V SoC";
+    mc->init                        = vega_machine_init;
+    mc->max_cpus                    = VEGA_CPUS_MAX;
+    mc->default_cpu_type            = VEGA_CPU;
+    mc->default_ram_id              = "riscv_vega_board.ram";
+
+    object_class_property_add_bool(oc, "aclint",
+                                   vega_get_aclint, vega_set_aclint);
+    object_class_property_set_description(oc, "aclint",
+        "(TCG only) Enable ACLINT devices");
+}
+
+/* Type registration */
+
+static const TypeInfo vega_machine_typeinfo = {
+    .name          = MACHINE_TYPE_NAME("vega"),
+    .parent        = TYPE_MACHINE,
+    .class_init    = vega_machine_class_init,
+    .instance_init = vega_machine_instance_init,
+    .instance_size = sizeof(RISCVVegaState),
+    .interfaces    = riscv32_64_machine_interfaces,
+};
+
+static void vega_machine_init_register_types(void)
+{
+    type_register_static(&vega_machine_typeinfo);
+}
+
+type_init(vega_machine_init_register_types)
diff --git a/include/hw/riscv/vega.h b/include/hw/riscv/vega.h
new file mode 100644
index 0000000000..85993fd77c
--- /dev/null
+++ b/include/hw/riscv/vega.h
@@ -0,0 +1,136 @@
+/*
+ * QEMU RISC-V VEGA machine interface
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2025 C-DAC (Centre for Development of Advanced Computing)
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
+#ifndef HW_RISCV_VEGA_H
+#define HW_RISCV_VEGA_H
+
+#include "hw/core/boards.h"
+#include "hw/riscv/riscv_hart.h"
+#include "hw/core/sysbus.h"
+
+#if defined(TARGET_RISCV32)
+#define VEGA_CPU TYPE_RISCV_CPU_VEGA32
+#elif defined(TARGET_RISCV64)
+#define VEGA_CPU TYPE_RISCV_CPU_VEGA64
+#else
+#error "Unknown RISCV target"
+#endif
+
+#define VEGA_CPUS_MAX_BITS             2
+#define VEGA_CPUS_MAX                  (1 << VEGA_CPUS_MAX_BITS)   /* 4 */
+#define VEGA_SOCKETS_MAX_BITS          1
+#define VEGA_SOCKETS_MAX               (1 << VEGA_SOCKETS_MAX_BITS) /* 2 */
+#define VEGA_VIRTIO_COUNT 4
+#define VEGA_VIRTIO_IRQ   1
+
+#define TYPE_RISCV_VEGA_MACHINE MACHINE_TYPE_NAME("vega")
+typedef struct RISCVVegaState RISCVVegaState;
+DECLARE_INSTANCE_CHECKER(RISCVVegaState, RISCV_VEGA_MACHINE,
+                         TYPE_RISCV_VEGA_MACHINE)
+
+
+struct RISCVVegaState {
+    /*< private >*/
+    MachineState parent;
+
+    /*< public >*/
+    Notifier machine_done;
+    RISCVHartArrayState soc[VEGA_SOCKETS_MAX];
+    DeviceState *irqchip[VEGA_SOCKETS_MAX];
+
+    int fdt_size;
+    bool have_aclint;
+    const MemMapEntry *memmap;
+
+    uint64_t dram_base;   /* configurable DRAM base address */
+
+};
+
+/*
+ * Memory-map index enum.
+ * Entries are tightly packed — the array in vega.c must follow the same order.
+ */
+enum {
+    VEGA_DEBUG,
+    VEGA_MROM,
+    VEGA_TEST,
+    VEGA_CLINT,
+    VEGA_ACLINT_SSWI,
+    VEGA_PLIC_ID,
+    VEGA_UART0,
+    VEGA_DRAM,
+    VEGA_SRAM,
+    VEGA_UART1,
+    VEGA_UART2,
+    VEGA_UART3,
+    VEGA_UART4,
+    VEGA_SPI0,
+    VEGA_SPI1,
+    VEGA_IIC0,
+    VEGA_IIC1,
+    VEGA_SDHCI,
+    VEGA_VIRTIO,
+};
+
+/* IRQ numbers */
+enum {
+    UART0_IRQ = 10,
+    UART1_IRQ = 10,
+    UART2_IRQ = 10,
+    UART3_IRQ = 10,
+    UART4_IRQ = 10,
+};
+
+/*
+ * UART defaults for baremetal (-bios mode, no DTB).
+ * When booting Linux (-kernel + -dtb), reg-shift is read from
+ * the /soc/serial node in the DTB at runtime.
+ * Baremetal is detected by machine->firmware being set.
+ */
+#define VEGA_UART_DEFAULT_REGSHIFT   2   /* 4-byte stride */
+#define VEGA_UART_DEFAULT_IOWIDTH    4   /* 32-bit bus access */
+
+/* CLINT layout (TCG default path) */
+#define VEGA_CLINT_MSWI_OFFSET    0x400
+
+/* Interrupt controller sizing */
+#define VEGA_IRQCHIP_NUM_SOURCES    128  /* IRQ 0 (none) + IRQ 1-127 = 128 entries */
+#define VEGA_IRQCHIP_NUM_PRIO_BITS   4
+#define VEGA_IRQCHIP_MAX_GUESTS_BITS 3
+#define VEGA_IRQCHIP_MAX_GUESTS     ((1U << VEGA_IRQCHIP_MAX_GUESTS_BITS) - 1U)
+
+/* PLIC register layout */
+#define VEGA_PLIC_PRIORITY_BASE  0x00
+#define VEGA_PLIC_PENDING_BASE   0x80
+#define VEGA_PLIC_ENABLE_BASE    0x100  /* M-mode enables start at 0x100 */
+#define VEGA_PLIC_ENABLE_STRIDE  0x20   /* stride between M and S contexts */
+#define VEGA_PLIC_CONTEXT_BASE   0x300  /* M-mode context starts at 0x300 */
+#define VEGA_PLIC_CONTEXT_STRIDE 0x10
+
+#define VEGA_PLIC_SIZE(__num_context) \
+    (VEGA_PLIC_CONTEXT_BASE + (__num_context) * VEGA_PLIC_CONTEXT_STRIDE)
+
+/* FDT cell-size constants */
+#define FDT_PLIC_ADDR_CELLS     0
+#define FDT_PLIC_INT_CELLS      1
+#define FDT_APLIC_INT_CELLS     2
+#define FDT_APLIC_ADDR_CELLS    0
+
+#endif /* HW_RISCV_VEGA_H */
-- 
2.43.0


------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
------------------------------------------------------------------------------------------------------------


