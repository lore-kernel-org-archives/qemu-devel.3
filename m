Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7488ECA9EDE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJNJ-00005P-O6; Mon, 12 Oct 2026 12:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMW-00080b-ML; Mon, 12 Oct 2026 12:59:01 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMU-0006D5-2T; Mon, 12 Oct 2026 12:58:56 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4j3Nw15VJ9z8BMd;
 Mon, 12 Oct 2026 18:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1791824321;
 bh=Y4dIddh8wrXNQIag2FJxhCu0Ew2R8fkEe1PbPB0nr1E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kY1JQc4dS1522jPy11gmUEF1Fr1vCTy3U+xDeDcMdTJPQw5ziuNVI5++xD7iqN/BY
 9DTvYYxvrzH6Nxa8adS7pB42WStso+/cVWtE3X4y5ddBecJJEvVhMmfLiE6CwX5HXI
 48qcg6NFamsV4Jts95ACLyoKNjfUdDwCG+4g9A+EeKrDk4bAz4vSG4n5fqJEbCFxNL
 HZZtbW8spa37eLq+vJxHFAdLuZvuczofx5QvV6shB0kX9OLxbBl2QPUZtBB34eJmNG
 QNj+V0H21fWZv99Vv0RgQ/+XZJJxtAwIaq7QCrCKF5KUZzTnRXbkiPzkb0j65pVODP
 Fx1XjpyDJCHpw==
Received: from localhost.localdomain (unknown [134.206.205.113])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4j3Nw13zzdz83nb;
 Mon, 12 Oct 2026 18:58:41 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH 3/9] hw/arm: add RP2040 SoC and Raspberry Pi Pico machine
Date: Mon, 12 Oct 2026 18:58:33 +0200
Message-ID: <20261012165840.99050-4-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
References: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Continue the Raspberry Pi Pico machine model introduced by Alex Bennée's
2022 RFC on current QEMU APIs. Add the RP2040 QOM skeleton, internal ROM and
SRAM map, the board XIP window, two PL011-backed UARTs, and explicit
unimplemented-device placeholders for the remaining MMIO blocks.

Instantiate both Cortex-M0+ cores from the initial machine model. Give each
core a separate memory container over the shared SoC address map so later
patches can add per-core views for banked peripherals. Keep core 1 powered
off until SIO and the boot ROM launch protocol are implemented.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 configs/devices/arm-softmmu/default.mak |   1 +
 hw/arm/Kconfig                          |  12 ++
 hw/arm/meson.build                      |   2 +
 hw/arm/raspi_pico.c                     |  83 ++++++++
 hw/arm/rp2040.c                         | 263 ++++++++++++++++++++++++
 include/hw/arm/rp2040.h                 |  49 +++++
 6 files changed, 410 insertions(+)
 create mode 100644 hw/arm/raspi_pico.c
 create mode 100644 hw/arm/rp2040.c
 create mode 100644 include/hw/arm/rp2040.h

diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 22caa6a63e..11a5cac093 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -32,6 +32,7 @@
 # CONFIG_OLIMEX_STM32_H405=n
 # CONFIG_MPS2=n
 # CONFIG_RASPI=n
+CONFIG_RASPI_PICO=y
 # CONFIG_DIGIC=n
 # CONFIG_SABRELITE=n
 # CONFIG_EMCRAFT_SF2=n
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4445f16f45..73faefb1d7 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -353,6 +353,18 @@ config RASPI
     select BCM2835_SPI
     select BCM2835_I2C
 
+config RASPI_PICO
+    bool
+    default y
+    depends on TCG && ARM
+    select RP2040
+
+config RP2040
+    bool
+    select ARM_V7M
+    select PL011
+    select UNIMP
+
 config STM32F100_SOC
     bool
     select ARM_V7M
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index bcc068de04..a61a45840b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -31,6 +31,8 @@ arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'raspi.c',
   'raspi4b.c'
 ))
+arm_common_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040.c'))
+arm_common_ss.add(when: 'CONFIG_RASPI_PICO', if_true: files('raspi_pico.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
diff --git a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c
new file mode 100644
index 0000000000..dff897085a
--- /dev/null
+++ b/hw/arm/raspi_pico.c
@@ -0,0 +1,83 @@
+/*
+ * Raspberry Pi Pico machine
+ *
+ * Copyright (c) 2021 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/rp2040.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
+#include "system/address-spaces.h"
+#include "system/system.h"
+#include "qom/object.h"
+
+#define TYPE_RASPI_PICO_MACHINE MACHINE_TYPE_NAME("raspi-pico")
+OBJECT_DECLARE_SIMPLE_TYPE(RaspiPicoMachineState, RASPI_PICO_MACHINE)
+
+#define PICO_FLASH_SIZE (2 * MiB)
+
+struct RaspiPicoMachineState {
+    MachineState parent_obj;
+
+    RP2040State soc;
+    MemoryRegion flash;
+};
+
+static void raspi_pico_init(MachineState *machine)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RP2040);
+    qdev_prop_set_chr(DEVICE(&s->soc), "serial0", serial_hd(0));
+    qdev_prop_set_chr(DEVICE(&s->soc), "serial1", serial_hd(1));
+    if (machine->firmware) {
+        qdev_prop_set_string(DEVICE(&s->soc), "bootrom-file",
+                             machine->firmware);
+    }
+    object_property_set_link(OBJECT(&s->soc), "memory",
+                             OBJECT(system_memory), &error_fatal);
+
+    memory_region_init_rom(&s->flash, NULL, "raspi-pico.flash",
+                           PICO_FLASH_SIZE, &error_fatal);
+    memory_region_add_subregion(system_memory, RP2040_XIP_BASE, &s->flash);
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+
+    armv7m_load_kernel(s->soc.armv7m[0].cpu, machine->kernel_filename,
+                       RP2040_XIP_BASE, PICO_FLASH_SIZE);
+}
+
+static void raspi_pico_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Raspberry Pi Pico (Cortex-M0+)";
+    mc->init = raspi_pico_init;
+    mc->default_cpus = RP2040_NUM_CORES;
+    mc->min_cpus = RP2040_NUM_CORES;
+    mc->max_cpus = RP2040_NUM_CORES;
+    mc->default_ram_size = 0;
+    mc->no_parallel = 1;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+}
+
+static const TypeInfo raspi_pico_machine_info = {
+    .name = TYPE_RASPI_PICO_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(RaspiPicoMachineState),
+    .class_init = raspi_pico_machine_class_init,
+};
+
+static void raspi_pico_machine_init(void)
+{
+    type_register_static(&raspi_pico_machine_info);
+}
+type_init(raspi_pico_machine_init)
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
new file mode 100644
index 0000000000..d5398e67e4
--- /dev/null
+++ b/hw/arm/rp2040.c
@@ -0,0 +1,263 @@
+/*
+ * RP2040 SoC emulation
+ *
+ * Copyright (c) 2021 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/arm/rp2040.h"
+#include "hw/core/loader.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/unimp.h"
+#include "qemu/datadir.h"
+#include "target/arm/cpu-qom.h"
+
+#define RP2040_SYSCLK_FRQ 125000000
+
+#define RP2040_UART0_BASE 0x40034000
+#define RP2040_UART0_IRQ  20
+#define RP2040_UART1_BASE 0x40038000
+#define RP2040_UART1_IRQ  21
+
+/*
+ * Temporary boot ROM used until the synthetic ROM is introduced. It loads
+ * the reset handler from a vector table at the base of the XIP window.
+ */
+static const uint8_t rp2040_bootrom[] = {
+    0x00, 0x20, 0x04, 0x20, /* initial SP: 0x20042000 */
+    0x09, 0x00, 0x00, 0x00, /* reset handler: 0x00000009 */
+    0x03, 0x48,             /* ldr r0, vtor */
+    0x04, 0x49,             /* ldr r1, xip_base */
+    0x01, 0x60,             /* str r1, [r0] */
+    0x04, 0x48,             /* ldr r0, xip_reset_vector */
+    0x01, 0x68,             /* ldr r1, [r0] */
+    0x08, 0x47,             /* bx r1 */
+    0xfe, 0xe7,             /* b . */
+    0xc0, 0x46,             /* nop */
+    0x08, 0xed, 0x00, 0xe0, /* VTOR: 0xe000ed08 */
+    0x00, 0x00, 0x00, 0x10, /* XIP base: 0x10000000 */
+    0x04, 0x00, 0x00, 0x10, /* XIP reset vector: 0x10000004 */
+};
+
+static const struct {
+    const char *name;
+    hwaddr base;
+    hwaddr size;
+} rp2040_unimplemented[] = {
+    { "rp2040.sysinfo",  0x40000000, 0x4000 },
+    { "rp2040.syscfg",   0x40004000, 0x4000 },
+    { "rp2040.clocks",   0x40008000, 0x4000 },
+    { "rp2040.resets",   0x4000c000, 0x4000 },
+    { "rp2040.psm",      0x40010000, 0x4000 },
+    { "rp2040.iobank0",  0x40014000, 0x4000 },
+    { "rp2040.ioqspi",   0x40018000, 0x4000 },
+    { "rp2040.padsbank0", 0x4001c000, 0x4000 },
+    { "rp2040.padsqspi", 0x40020000, 0x4000 },
+    { "rp2040.xosc",     0x40024000, 0x4000 },
+    { "rp2040.pll_sys",  0x40028000, 0x4000 },
+    { "rp2040.pll_usb",  0x4002c000, 0x4000 },
+    { "rp2040.busctrl",  0x40030000, 0x4000 },
+    { "rp2040.uart0_aliases", 0x40035000, 0x3000 },
+    { "rp2040.uart1_aliases", 0x40039000, 0x3000 },
+    { "rp2040.spi0",     0x4003c000, 0x4000 },
+    { "rp2040.spi1",     0x40040000, 0x4000 },
+    { "rp2040.i2c0",     0x40044000, 0x4000 },
+    { "rp2040.i2c1",     0x40048000, 0x4000 },
+    { "rp2040.adc",      0x4004c000, 0x4000 },
+    { "rp2040.pwm",      0x40050000, 0x4000 },
+    { "rp2040.timer",    0x40054000, 0x4000 },
+    { "rp2040.watchdog", 0x40058000, 0x4000 },
+    { "rp2040.rtc",      0x4005c000, 0x4000 },
+    { "rp2040.rosc",     0x40060000, 0x4000 },
+    { "rp2040.vreg_and_chip_reset", 0x40064000, 0x4000 },
+    { "rp2040.tbman",    0x4006c000, 0x4000 },
+    { "rp2040.dma",      0x50000000, 0x1000 },
+    { "rp2040.usbctrl_dpram", 0x50100000, 0x10000 },
+    { "rp2040.usbctrl_regs",  0x50110000, 0x10000 },
+    { "rp2040.pio0",     0x50200000, 0x10000 },
+    { "rp2040.pio1",     0x50300000, 0x10000 },
+    { "rp2040.sio",      0xd0000000, 0x1000 },
+};
+
+static void rp2040_soc_init(Object *obj)
+{
+    RP2040State *s = RP2040(obj);
+    int i;
+
+    for (i = 0; i < RP2040_NUM_CORES; i++) {
+        g_autofree char *name = g_strdup_printf("proc%d", i);
+
+        object_initialize_child(obj, name, &s->armv7m[i], TYPE_ARMV7M);
+        qdev_prop_set_string(DEVICE(&s->armv7m[i]), "cpu-type",
+                             ARM_CPU_TYPE_NAME("cortex-m0plus"));
+        qdev_prop_set_uint32(DEVICE(&s->armv7m[i]), "num-irq",
+                             RP2040_NUM_IRQS);
+        qdev_prop_set_uint32(DEVICE(&s->armv7m[i]), "mpu-ns-regions", 8);
+    }
+    qdev_prop_set_bit(DEVICE(&s->armv7m[1]), "start-powered-off", true);
+
+    for (i = 0; i < ARRAY_SIZE(s->uart); i++) {
+        g_autofree char *name = g_strdup_printf("uart%d", i);
+        g_autofree char *property = g_strdup_printf("serial%d", i);
+
+        object_initialize_child(obj, name, &s->uart[i], TYPE_PL011);
+        object_property_add_alias(obj, property, OBJECT(&s->uart[i]),
+                                  "chardev");
+    }
+
+    s->sysclk = clock_new(obj, "sysclk");
+    clock_set_hz(s->sysclk, RP2040_SYSCLK_FRQ);
+}
+
+static bool rp2040_init_memory(RP2040State *s, Error **errp)
+{
+    int i;
+
+    if (!memory_region_init_rom(&s->rom, OBJECT(s), "rp2040.rom",
+                                RP2040_ROM_SIZE, errp)) {
+        return false;
+    }
+    memory_region_add_subregion(s->board_memory, RP2040_ROM_BASE, &s->rom);
+
+    for (i = 0; i < 4; i++) {
+        g_autofree char *name = g_strdup_printf("rp2040.sram%d", i);
+
+        if (!memory_region_init_ram(&s->sram[i], OBJECT(s), name,
+                                    RP2040_SRAM_BANK_SIZE, errp)) {
+            return false;
+        }
+        memory_region_add_subregion(s->board_memory,
+                                    RP2040_SRAM_BASE +
+                                    i * RP2040_SRAM_BANK_SIZE,
+                                    &s->sram[i]);
+    }
+
+    if (!memory_region_init_ram(&s->sram[4], OBJECT(s), "rp2040.sram4",
+                                RP2040_SRAM_HI_SIZE, errp)) {
+        return false;
+    }
+    memory_region_add_subregion(s->board_memory, RP2040_SRAM4_BASE,
+                                &s->sram[4]);
+
+    if (!memory_region_init_ram(&s->sram[5], OBJECT(s), "rp2040.sram5",
+                                RP2040_SRAM_HI_SIZE, errp)) {
+        return false;
+    }
+    memory_region_add_subregion(s->board_memory, RP2040_SRAM5_BASE,
+                                &s->sram[5]);
+
+    return true;
+}
+
+static bool rp2040_load_bootrom(RP2040State *s, Error **errp)
+{
+    g_autofree char *filename = NULL;
+
+    if (!s->bootrom_file) {
+        rom_add_blob_fixed("rp2040.bootrom", rp2040_bootrom,
+                           sizeof(rp2040_bootrom), RP2040_ROM_BASE);
+        return true;
+    }
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, s->bootrom_file);
+    if (!filename) {
+        error_setg(errp, "could not find RP2040 boot ROM image '%s'",
+                   s->bootrom_file);
+        return false;
+    }
+
+    return load_image_targphys(filename, RP2040_ROM_BASE,
+                               RP2040_ROM_SIZE, errp) >= 0;
+}
+
+static void rp2040_soc_realize(DeviceState *dev, Error **errp)
+{
+    RP2040State *s = RP2040(dev);
+    static const hwaddr uart_base[] = { RP2040_UART0_BASE, RP2040_UART1_BASE };
+    static const int uart_irq[] = { RP2040_UART0_IRQ, RP2040_UART1_IRQ };
+    Error *err = NULL;
+    int i;
+
+    if (!s->board_memory) {
+        error_setg(errp, "memory property was not set");
+        return;
+    }
+    if (!rp2040_init_memory(s, errp) || !rp2040_load_bootrom(s, errp)) {
+        return;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(rp2040_unimplemented); i++) {
+        create_unimplemented_device(rp2040_unimplemented[i].name,
+                                    rp2040_unimplemented[i].base,
+                                    rp2040_unimplemented[i].size);
+    }
+
+    for (i = 0; i < RP2040_NUM_CORES; i++) {
+        g_autofree char *memory_name =
+            g_strdup_printf("rp2040.proc%d-memory", i);
+        g_autofree char *alias_name =
+            g_strdup_printf("rp2040.proc%d-board-memory", i);
+
+        memory_region_init(&s->cpu_memory[i], OBJECT(dev), memory_name,
+                           UINT64_C(1) << 32);
+        memory_region_init_alias(&s->cpu_board_alias[i], OBJECT(dev),
+                                 alias_name, s->board_memory, 0,
+                                 UINT64_C(1) << 32);
+        memory_region_add_subregion(&s->cpu_memory[i], 0,
+                                    &s->cpu_board_alias[i]);
+        qdev_connect_clock_in(DEVICE(&s->armv7m[i]), "cpuclk", s->sysclk);
+        object_property_set_link(OBJECT(&s->armv7m[i]), "memory",
+                                 OBJECT(&s->cpu_memory[i]), &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m[i]), errp)) {
+            return;
+        }
+    }
+
+    for (i = 0; i < ARRAY_SIZE(s->uart); i++) {
+        qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", s->sysclk);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, uart_base[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->armv7m[0]),
+                                            uart_irq[i]));
+    }
+}
+
+static const Property rp2040_soc_properties[] = {
+    DEFINE_PROP_LINK("memory", RP2040State, board_memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_STRING("bootrom-file", RP2040State, bootrom_file),
+};
+
+static void rp2040_soc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rp2040_soc_realize;
+    device_class_set_props(dc, rp2040_soc_properties);
+}
+
+static const TypeInfo rp2040_soc_info = {
+    .name = TYPE_RP2040,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040State),
+    .instance_init = rp2040_soc_init,
+    .class_init = rp2040_soc_class_init,
+};
+
+static void rp2040_soc_types(void)
+{
+    type_register_static(&rp2040_soc_info);
+}
+type_init(rp2040_soc_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
new file mode 100644
index 0000000000..ccab548275
--- /dev/null
+++ b/include/hw/arm/rp2040.h
@@ -0,0 +1,49 @@
+/*
+ * RP2040 SoC emulation
+ *
+ * Copyright (c) 2021 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_RP2040_H
+#define HW_ARM_RP2040_H
+
+#include "hw/arm/armv7m.h"
+#include "hw/char/pl011.h"
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040 "rp2040"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040State, RP2040)
+
+#define RP2040_ROM_BASE       0x00000000
+#define RP2040_ROM_SIZE       (16 * KiB)
+#define RP2040_XIP_BASE       0x10000000
+#define RP2040_SRAM_BASE      0x20000000
+#define RP2040_SRAM_BANK_SIZE (64 * KiB)
+#define RP2040_SRAM4_BASE     0x20040000
+#define RP2040_SRAM5_BASE     0x20041000
+#define RP2040_SRAM_HI_SIZE   (4 * KiB)
+
+#define RP2040_NUM_CORES      2
+#define RP2040_NUM_IRQS       32
+
+struct RP2040State {
+    SysBusDevice parent_obj;
+
+    ARMv7MState armv7m[RP2040_NUM_CORES];
+    PL011State uart[2];
+
+    MemoryRegion *board_memory;
+    MemoryRegion cpu_memory[RP2040_NUM_CORES];
+    MemoryRegion cpu_board_alias[RP2040_NUM_CORES];
+    MemoryRegion rom;
+    MemoryRegion sram[6];
+    char *bootrom_file;
+
+    Clock *sysclk;
+};
+
+#endif
-- 
2.55.0


