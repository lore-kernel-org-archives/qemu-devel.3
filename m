Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D91FF886F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 05:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJPrM-0001GV-VY; Sun, 03 May 2026 01:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM6H-0004x9-0Z
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:29 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM6C-0000Ye-BO
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:28 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-12dbd0f7ecaso6827179c88.0
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 18:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777773503; x=1778378303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bxTylT5zdHOxeOuQ+JQtXcO2yUlfuze6HxbUoeHOzw=;
 b=R2NcN/kwpqEJHSe2KmvaTsPNTRYb5GH7JOt5zF+dr9HEWfbFwAl0ixNfO4clI+iiqC
 VYgRJD6k1Z0qkksTnO0cWZWKNt8QnVf8/4MInDYHLpxBqt5o6Di1Pcf6mNitAGof9t0N
 yi85kHqfEthbXyA6y0QxSAF34RxDlShXXflBdRCBaPNCJCQuT/URG01875s0V/SfCoCD
 A7aiTbVBRkws25SK6MenjRGz5XF0UwUf/eQ57S/YAOqaV4eeUqRVrLoRzc5glUeZrHid
 unRgFQuXQ+4gNRNgamxZLFPwqwiPUP2SACT/JaQPSh4gh4/Gc3JZEaEiDBJFigQ4CbRH
 qWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777773503; x=1778378303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8bxTylT5zdHOxeOuQ+JQtXcO2yUlfuze6HxbUoeHOzw=;
 b=epkwBLyZFGxByfvLAisG9su9iNFS2+D0ayoAtRult7OcDKLoweQaT+rl2n/qsPp3gc
 +GyNRGC7Qx9I00azikdwlvn5a7lVH6juu0UmcJWktVKEpdU9l0ZM6IaSzXfI2lkp+5TV
 i4kSePFi/TsIUy2G8H6GldcCqUwrpAZU1/xky6re8AA0W2HXaM9C1BrkcZs9gRGbhJaA
 cCnh+IPkPAcn2oSPezinsTQlC5GlFbG8i+QRhmfQ9UqVfqxiCdkq4e/a9sa/0+ot07ch
 JhCmhltjWmS/Fv6Q1SSJcWWZPVt8ZIo8t0GqEogJvpq5ZrlTWwisHEgQTE9FO67Nap0j
 zIhA==
X-Gm-Message-State: AOJu0Yw2mv7A4oGGME+PouRrDNCV/U1xWZNqseepqSxWIM65l1oUrUaq
 x09CbkoTGhwsDzo2wQ07Qv/2ROCLIGUaGC/RgNpWi8kqCMJo5yN+RDE9mr8Mww==
X-Gm-Gg: AeBDiesqPvIPQnqaMX7IsWPFl4Sliw6Oq30VKKzxMdKhNhhl+4LdOs6QohbvvmsMtOS
 ZHsDFFNF3RXxKOO8mQV1Afw9dAQAAWZhH2MSC45ufmHA0UY4h14ZNlSrpt5+cFkKunz5GeXK42h
 NCsHFg/ba++9T/xDeROGKx9XBntYsA4cC3Ch5IHwmNtnAooVhFm92ZBd8sV3/s9EQAAtQ90LLZR
 wqvw840312GtLVEArh6oNOooFdBvdaFo0sCnt6Gnf9hoKcbQg/8hYQfw0cmyknh34UwHdfaC/0x
 sfdyWyNORlEPr5m/45tsnXktSSArMKriLosq0CM7yUwIrju2O9S+K9BHXZXd6oqjOQvACKix/6f
 Bpd0ecT7KbGebLNjj0jnHBc3bLUTZ3wQvHcE4RM2B7d/MK15npeGGcpkqhJVBiO7gACUh8TPils
 sm9h0HNcOoS1IRd2DSFTD5KjJa8dxMCV7sWPonwZPrQxHlOLf8WcTfgbr28RgW
X-Received: by 2002:a05:7022:401:b0:12d:b3f8:60e7 with SMTP id
 a92af1059eb24-12dfd85ed7fmr2551232c88.34.1777773501751; 
 Sat, 02 May 2026 18:58:21 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38d79eb9sm14361735eec.8.2026.05.02.18.58.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 02 May 2026 18:58:21 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	thuth@redhat.com,
	54weasels <54weasels@gmail.com>
Subject: [PATCH 5/7] hw/m68k: Overhaul Sun-3 MMU and Boot PROM mapping
Date: Sat,  2 May 2026 18:57:54 -0700
Message-ID: <20260503015756.99176-6-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503015756.99176-1-54weasels@gmail.com>
References: <20260503015756.99176-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=54weasels@gmail.com; helo=mail-dl1-x1234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 May 2026 01:59:18 -0400
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

This heavily refactors the Sun-3 machine initialization to support its proprietary Custom MMU implementation, which replaces the standard Motorola 68851 MMU. It maps the diagnostic EEPROM, sets the correct 28-bit address bus masks, implements the OBIO aliasing rules for the Boot PROM, and connects the newly added LANCE, ESCC, and Intersil 7170 peripherals.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 hw/m68k/Kconfig            |   8 +
 hw/m68k/meson.build        |   1 +
 hw/m68k/sun3.c             | 499 ++++++++++++++++++++++++++
 hw/m68k/sun3_eeprom_data.h | 259 ++++++++++++++
 hw/m68k/sun3mmu.c          | 705 +++++++++++++++++++++++++++++++++++++
 include/hw/m68k/sun3mmu.h  |  65 ++++
 6 files changed, 1537 insertions(+)
 create mode 100644 hw/m68k/sun3.c
 create mode 100644 hw/m68k/sun3_eeprom_data.h
 create mode 100644 hw/m68k/sun3mmu.c
 create mode 100644 include/hw/m68k/sun3mmu.h

diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index aff769b30f..59b36c75ee 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -46,3 +46,11 @@ config M68K_VIRT
     select GOLDFISH_TTY
     select GOLDFISH_RTC
     select VIRTIO_MMIO
+
+config SUN3
+    bool
+    default y
+    depends on M68K
+    select ESCC
+    select LANCE
+    select INTERSIL7170
diff --git a/hw/m68k/meson.build b/hw/m68k/meson.build
index 84bc68fa4e..c8b07d81fb 100644
--- a/hw/m68k/meson.build
+++ b/hw/m68k/meson.build
@@ -3,6 +3,7 @@ m68k_ss.add(when: 'CONFIG_AN5206', if_true: files('an5206.c', 'mcf5206.c'))
 m68k_ss.add(when: 'CONFIG_MCF5208', if_true: files('mcf5208.c', 'mcf_intc.c'))
 m68k_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-kbd.c', 'next-cube.c'))
 m68k_ss.add(when: 'CONFIG_Q800', if_true: files('q800.c', 'q800-glue.c'))
+m68k_ss.add(when: 'CONFIG_SUN3', if_true: files('sun3.c', 'sun3mmu.c'))
 m68k_ss.add(when: 'CONFIG_M68K_VIRT', if_true: files('virt.c'))
 
 hw_arch += {'m68k': m68k_ss}
diff --git a/hw/m68k/sun3.c b/hw/m68k/sun3.c
new file mode 100644
index 0000000000..16ad8b063d
--- /dev/null
+++ b/hw/m68k/sun3.c
@@ -0,0 +1,499 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU Sun-3 Board Emulation
+ *
+ * Copyright (c) 2026
+ */
+
+#include "qemu/osdep.h"
+
+#include "chardev/char.h"
+#include "hw/char/escc.h"
+#include "hw/core/boards.h"
+#include "hw/core/irq.h"
+#include "hw/core/loader.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/sysbus.h"
+#include "hw/net/lance.h"
+#include "hw/intc/m68k_irqc.h"
+#include "hw/m68k/sun3mmu.h"
+#include "hw/timer/intersil7170.h"
+#include "qapi/error.h"
+#include "system/qtest.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "sun3_eeprom_data.h"
+#include "system/address-spaces.h"
+#include "system/reset.h"
+#include "system/system.h"
+#include "target/m68k/cpu.h"
+#include "qom/object.h"
+
+#define SUN3_PROM_BASE 0x0FEF0000
+#define SUN3_PROM_SIZE (64 * 1024)
+
+#define TYPE_SUN3_MACHINE MACHINE_TYPE_NAME("sun3")
+OBJECT_DECLARE_SIMPLE_TYPE(Sun3MachineState, SUN3_MACHINE)
+
+struct Sun3MachineState {
+    MachineState parent_obj;
+
+    /* Embedded Memory Regions */
+    MemoryRegion rom;
+    MemoryRegion rom_alias;
+    MemoryRegion idprom;
+    MemoryRegion intreg_iomem;
+    MemoryRegion memerr_iomem;
+    MemoryRegion eeprom;
+    MemoryRegion nvram;
+    MemoryRegion timeout_net;
+
+    /* Devices */
+    DeviceState *irqc_dev;
+    DeviceState *sun3mmu;
+
+    /* Boot State */
+    uint32_t boot_sp;
+    uint32_t boot_pc;
+
+    /* Interrupt Register State */
+    uint8_t intreg;
+    bool clock_pending;
+
+    /* Memory Error Register (Parity Spoof) State */
+    uint8_t memerr_reg;
+    uint8_t spoof_parity_lane;
+    uint8_t parity_bit_counter;
+    bool test_parity_written;
+};
+
+static void sun3_update_clock_irq(Sun3MachineState *s)
+{
+    if (!s->irqc_dev) {
+        return;
+    }
+
+    /* Lower everything first */
+    qemu_irq_lower(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_5));
+    qemu_irq_lower(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_7));
+
+    /* Assert the currently enabled level if the clock is pulsing */
+    if (s->clock_pending && (s->intreg & 0x01)) {
+        if (s->intreg & 0x20) {
+            qemu_irq_raise(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_5));
+        } else if (s->intreg & 0x80) {
+            qemu_irq_raise(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_7));
+        }
+    }
+}
+
+static void sun3_clock_irq_handler(void *opaque, int n, int level)
+{
+    Sun3MachineState *s = SUN3_MACHINE(opaque);
+    s->clock_pending = !!level;
+    sun3_update_clock_irq(s);
+}
+
+static uint64_t sun3_intreg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    Sun3MachineState *s = SUN3_MACHINE(opaque);
+    return s->intreg;
+}
+
+static void sun3_intreg_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    Sun3MachineState *s = SUN3_MACHINE(opaque);
+    s->intreg = val;
+
+    qemu_log_mask(
+        LOG_GUEST_ERROR,
+        "[SUN3 INTREG] Write: 0x%02x (Enable=%d, L1=%d, L2=%d, L3=%d)\n",
+        (uint8_t)val, !!(val & 0x01), !!(val & 0x02), !!(val & 0x04),
+        !!(val & 0x08));
+
+    if ((val & 0x01) == 0) {
+        /* Master Interrupt Enable is CLEAR. Mask everything! */
+        qemu_set_irq(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_1), 0);
+        qemu_set_irq(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_2), 0);
+        qemu_set_irq(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_3), 0);
+        sun3_update_clock_irq(s);
+        return;
+    }
+
+    /* Master Enable is SET. Fire the Soft Interrupts! */
+    qemu_set_irq(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_1),
+                 !!(val & 0x02));
+    qemu_set_irq(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_2),
+                 !!(val & 0x04));
+    qemu_set_irq(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_3),
+                 !!(val & 0x08));
+
+    /*
+     * Retrigger clock IRQs because the Master Enable or Local Enables might
+     * have changed
+     */
+    sun3_update_clock_irq(s);
+}
+
+static const MemoryRegionOps sun3_intreg_ops = {.read = sun3_intreg_read,
+                                                .write = sun3_intreg_write,
+                                                .endianness =
+                                                    DEVICE_BIG_ENDIAN,
+                                                .valid = {
+                                                    .min_access_size = 1,
+                                                    .max_access_size = 4,
+                                                } };
+
+static uint64_t sun3_memerr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    Sun3MachineState *s = SUN3_MACHINE(opaque);
+    return s->memerr_reg;
+}
+
+static void sun3_memerr_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    Sun3MachineState *s = SUN3_MACHINE(opaque);
+
+    if (addr == 4) {
+        s->memerr_reg &= ~0x80;
+        if (s->irqc_dev) {
+            qemu_irq_lower(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_7));
+        }
+        return;
+    }
+
+    s->memerr_reg = val & 0xFF;
+    if (val == 0x20) {
+        s->test_parity_written = true;
+    } else if (val == 0) {
+        s->test_parity_written = false;
+    }
+
+    if (s->irqc_dev) {
+        if ((val & 0x10) && (val & 0x40) && s->test_parity_written) {
+            s->memerr_reg |=
+                0x80 | s->spoof_parity_lane; /* active & spoofed bit lane */
+            s->parity_bit_counter++;
+            if (s->parity_bit_counter == 8) {
+                s->parity_bit_counter = 0;
+                s->spoof_parity_lane >>= 1;
+                if (s->spoof_parity_lane == 0) {
+                    s->spoof_parity_lane = 8;
+                }
+            }
+
+            qemu_irq_raise(qdev_get_gpio_in(
+                s->irqc_dev, M68K_IRQC_LEVEL_7)); /* M68K_IRQC_LEVEL_7 */
+        } else {
+            s->memerr_reg &= ~0x80;
+            qemu_irq_lower(qdev_get_gpio_in(s->irqc_dev, M68K_IRQC_LEVEL_7));
+        }
+    }
+}
+
+static const MemoryRegionOps sun3_memerr_ops = {
+    .read = sun3_memerr_read,
+    .write = sun3_memerr_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+            .unaligned = true,
+        },
+    .impl = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+            .unaligned = true,
+        },
+};
+
+static MemTxResult sun3_timeout_read_with_attrs(void *opaque, hwaddr addr,
+                                                uint64_t *data, unsigned size,
+                                                MemTxAttrs attrs)
+{
+    Sun3MMUState *mmu = SUN3_MMU(opaque);
+    mmu->buserr_reg |= 0x20; /* Timeout */
+    return MEMTX_ERROR;
+}
+
+static MemTxResult sun3_timeout_write_with_attrs(void *opaque, hwaddr addr,
+                                                 uint64_t val, unsigned size,
+                                                 MemTxAttrs attrs)
+{
+    Sun3MMUState *mmu = SUN3_MMU(opaque);
+    mmu->buserr_reg |= 0x20; /* Timeout */
+    return MEMTX_ERROR;
+}
+
+static const MemoryRegionOps sun3_timeout_ops = {
+    .read_with_attrs = sun3_timeout_read_with_attrs,
+    .write_with_attrs = sun3_timeout_write_with_attrs,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void sun3_cpu_reset(void *opaque)
+{
+    M68kCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+    CPUM68KState *env = cpu_env(cs);
+    Sun3MachineState *s = SUN3_MACHINE(current_machine);
+
+    /*
+     * Execute generic QEMU system reset (wipes everything to 0).
+     * This includes setting env->pc = 0 and env->aregs[7] = 0.
+     */
+    cpu_reset(cs);
+
+    /*
+     * Forcefully inject the Boot PROM SP/PC vectors on EVERY reset.
+     * The Sun-3 hardware uses a temporary MMU override to map the PROM to
+     * 0x00000000 during the first few cycles of reset. Since QEMU does not
+     * emulate this specific micro-architectural quirk, we must manually
+     * restore the vectors here to prevent the CPU from executing uninitialized
+     * RAM at 0x00000000 and getting stuck in a zero-pitch orib loop.
+     */
+    env->aregs[7] = s->boot_sp;
+    env->sp[0] = s->boot_sp; /* M68K_SSP (Master) */
+    env->sp[1] = s->boot_sp; /* M68K_USP (User) */
+    env->sp[2] = s->boot_sp; /* M68K_ISP (Interrupt) */
+    env->pc = s->boot_pc;
+}
+
+static void sun3_init(MachineState *machine)
+{
+    Sun3MachineState *s_mach = SUN3_MACHINE(machine);
+    M68kCPU *cpu;
+    CPUM68KState *env;
+    DeviceState *sun3mmu;
+    DeviceState *dev;
+    DeviceState *irqc_dev;
+    SysBusDevice *s;
+
+    /* Initialize defaults */
+    s_mach->memerr_reg = 0x40;
+    s_mach->spoof_parity_lane = 8;
+    s_mach->parity_bit_counter = 0;
+    s_mach->test_parity_written = false;
+    s_mach->intreg = 0;
+    s_mach->clock_pending = false;
+
+    /* Initialize the CPU. The Sun 3/60 uses a 68020. */
+    cpu = M68K_CPU(cpu_create(machine->cpu_type));
+    env = &cpu->env;
+    qemu_register_reset(sun3_cpu_reset, cpu);
+
+    /* Use automatically allocated main RAM */
+    memory_region_add_subregion(get_system_memory(), 0x00000000, machine->ram);
+
+    /* Allocate and map ROM as writable RAM! */
+    memory_region_init_ram(&s_mach->rom, NULL, "sun3.prom",
+                           SUN3_PROM_SIZE, &error_fatal);
+    memory_region_set_readonly(&s_mach->rom, false);
+    memory_region_add_subregion(get_system_memory(), SUN3_PROM_BASE,
+                                &s_mach->rom);
+
+    memory_region_init_alias(&s_mach->rom_alias, NULL, "sun3.prom.alias",
+                             &s_mach->rom, 0,
+                             SUN3_PROM_SIZE);
+    memory_region_add_subregion(get_system_memory(), 0x0FF00000,
+                                &s_mach->rom_alias);
+
+    const char *bios_name = machine->firmware ?: "sun3.prom";
+    if (bios_name) {
+        int load_size = load_image_targphys(bios_name, SUN3_PROM_BASE,
+                                            SUN3_PROM_SIZE,
+                             qtest_enabled() ? NULL : &error_fatal);
+        if (load_size < 0) {
+            if (!qtest_enabled()) {
+                error_report("sun3: could not load prom '%s'", bios_name);
+                exit(1);
+            }
+        }
+        error_report("Sun3 Init: Loaded %d bytes from '%s' at 0x%08x",
+                     load_size,
+                     bios_name, SUN3_PROM_BASE);
+
+        /* Initial PC is always at offset 4 in firmware binaries */
+        uint8_t *ptr = rom_ptr(SUN3_PROM_BASE, 8);
+        if (ptr) {
+            s_mach->boot_sp = ldl_be_p(ptr);
+            s_mach->boot_pc = ldl_be_p(ptr + 4);
+            error_report("Sun3 Init: Saved Firmware Vectors "
+                         "SP=0x%08x PC=0x%08x",
+                         s_mach->boot_sp, s_mach->boot_pc);
+        }
+    } else {
+        error_report(
+            "Sun3 Init: No firmware specified! Use -bios or -machine firmware=");
+    }
+
+    /* Set up the custom Sun-3 MMU */
+    sun3mmu = qdev_new(TYPE_SUN3_MMU);
+    s_mach->sun3mmu = sun3mmu;
+    s = SYS_BUS_DEVICE(sun3mmu);
+    sysbus_realize_and_unref(s, &error_fatal);
+
+    /* Intercept CPU memory translations with our custom MMU hook */
+    env->custom_mmu_opaque = sun3mmu;
+    env->custom_mmu_get_physical_address = sun3mmu_get_physical_address;
+
+    sysbus_mmio_map(s, 0, 0x80000000); /* Context Register */
+    sysbus_mmio_map(s, 1, 0x90000000); /* Segment Map */
+    sysbus_mmio_map(s, 2, 0xA0000000); /* Page Map */
+    sysbus_mmio_map(s, 3, 0xB0000000); /* Control / System Enable */
+    sysbus_mmio_map(s, 4, 0xC0000000); /* Bus Error Register */
+
+    memory_region_init_ram(&s_mach->idprom, NULL, "sun3.idprom", 8192,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(), 0x08000000,
+                                &s_mach->idprom);
+
+    uint8_t idprom_data[32] = {
+        0x01,                               /* Format: 1 */
+        0x17,                               /* Machine Type: Sun-3/60 (0x17) */
+        0x08, 0x00, 0x20, 0x00, 0x00, 0x01, /* MAC Address */
+        0x00, 0x00, 0x00, 0x00,             /* Date */
+        0x00, 0x00, 0x01,                   /* Serial */
+        0x00                                /* Checksum */
+    };
+    uint8_t chksum = 0;
+    for (int i = 0; i < 15; i++) {
+        chksum ^= idprom_data[i];
+    }
+    idprom_data[15] = chksum;
+
+    rom_add_blob_fixed("sun3.idprom_content", idprom_data, sizeof(idprom_data),
+                       0x08000000);
+
+    /*
+     * Set up the Interrupt Controller (IRQC) to route IRQs to
+     * CPU autovectors
+     */
+    irqc_dev = qdev_new(TYPE_M68K_IRQC);
+    object_property_set_link(OBJECT(irqc_dev), "m68k-cpu", OBJECT(cpu),
+                             &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(irqc_dev), &error_fatal);
+    s_mach->irqc_dev = irqc_dev;
+
+    dev = qdev_new(TYPE_INTERSIL_7170);
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_mmio_map(s, 0, 0x0FE60000);
+    sysbus_connect_irq(s, 0,
+                       qemu_allocate_irq(sun3_clock_irq_handler, s_mach, 0));
+
+    dev = qdev_new(TYPE_ESCC);
+    qdev_prop_set_bit(dev, "force-hw-ready", true);
+    qdev_prop_set_uint32(dev, "disabled", 0);
+    qdev_prop_set_uint32(dev, "frequency", 4915200); /* 4.9152 MHz */
+    qdev_prop_set_uint32(dev, "it_shift", 1);
+    qdev_prop_set_bit(dev, "bit_swap", false); /* Control/Data interleaving */
+    qdev_prop_set_uint32(dev, "mmio_size", 8192);
+    qdev_prop_set_chr(dev, "chrB", serial_hd(0)); /* Keyboard/Mouse A */
+    qdev_prop_set_chr(dev, "chrA", serial_hd(1)); /* Keyboard/Mouse B */
+    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
+    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_mmio_map(s, 0, 0x0FE00000);
+    sysbus_connect_irq(s, 0,
+                       qdev_get_gpio_in(irqc_dev, M68K_IRQC_LEVEL_6));
+    /* IPL 6 */
+    sysbus_connect_irq(s, 1,
+                       qdev_get_gpio_in(irqc_dev, M68K_IRQC_LEVEL_6));
+    /* IPL 6 */
+
+    dev = qdev_new(TYPE_ESCC);
+    qdev_prop_set_bit(dev, "force-hw-ready", true);
+    qdev_prop_set_uint32(dev, "disabled", 0);
+    qdev_prop_set_uint32(dev, "frequency", 4915200); /* 4.9152 MHz */
+    qdev_prop_set_uint32(dev, "it_shift", 1);
+    qdev_prop_set_bit(dev, "bit_swap", false); /* Control/Data interleaving */
+    qdev_prop_set_uint32(dev, "mmio_size", 8192);
+    qdev_prop_set_chr(dev, "chrB", serial_hd(2)); /* Serial B */
+    qdev_prop_set_chr(dev, "chrA", serial_hd(3)); /* Serial A */
+    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
+    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_mmio_map(s, 0, 0x0FE20000);
+    sysbus_connect_irq(s, 0,
+                       qdev_get_gpio_in(irqc_dev, M68K_IRQC_LEVEL_6));
+    /* IPL 6 */
+    sysbus_connect_irq(s, 1,
+                       qdev_get_gpio_in(irqc_dev, M68K_IRQC_LEVEL_6));
+    /* IPL 6 */
+
+    memory_region_init_io(&s_mach->intreg_iomem, NULL, &sun3_intreg_ops, s_mach,
+                          "sun3.intreg", 8192);
+    memory_region_add_subregion(get_system_memory(), 0x0FEA0000,
+                                &s_mach->intreg_iomem);
+
+    memory_region_init_io(&s_mach->memerr_iomem, NULL, &sun3_memerr_ops, s_mach,
+                          "sun3.memerr", 32);
+    memory_region_add_subregion(get_system_memory(), 0x0FE80000,
+                                &s_mach->memerr_iomem);
+
+    dev = qdev_new("lance");
+    qemu_configure_nic_device(dev, true, NULL);
+    object_property_set_link(OBJECT(dev), "dma_mr",
+                             OBJECT(&SUN3_MMU(sun3mmu)->dvma_iommu),
+                             &error_abort);
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_mmio_map(s, 0, 0x0FF20000);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(irqc_dev, M68K_IRQC_LEVEL_3));
+
+    memory_region_init_ram(&s_mach->eeprom, NULL, "sun3.eeprom", 2048,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(), 0x0FE40000,
+                                &s_mach->eeprom);
+    memcpy(memory_region_get_ram_ptr(&s_mach->eeprom), sun3_eeprom_blob,
+           sizeof(sun3_eeprom_blob));
+
+    memory_region_init_ram(&s_mach->nvram, NULL, "sun3.nvram", 8192,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(), 0x0FE50000,
+                                &s_mach->nvram);
+
+    memory_region_init_io(&s_mach->timeout_net, NULL, &sun3_timeout_ops,
+                          sun3mmu,
+                          "sun3.timeout", 0x06000000);
+    memory_region_add_subregion_overlap(get_system_memory(), 0x0A000000,
+                                        &s_mach->timeout_net, -10);
+}
+
+static void sun3_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Sun-3 (3/60)";
+    mc->init = sun3_init;
+    mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68020");
+    /* Minimum of 4MB for a 3/60, typical maximum ~24MB */
+    mc->default_ram_size = 4 * MiB;
+    mc->default_ram_id = "sun3.ram";
+
+    mc->ignore_memory_transaction_failures = false;
+}
+
+static const TypeInfo sun3_machine_type = {
+    .name = TYPE_SUN3_MACHINE,
+    .parent = TYPE_MACHINE,
+    .class_init = sun3_machine_class_init,
+    .instance_size = sizeof(Sun3MachineState),
+};
+
+static void sun3_machine_register_types(void)
+{
+    type_register_static(&sun3_machine_type);
+}
+
+type_init(sun3_machine_register_types)
diff --git a/hw/m68k/sun3_eeprom_data.h b/hw/m68k/sun3_eeprom_data.h
new file mode 100644
index 0000000000..fbe3a84d6d
--- /dev/null
+++ b/hw/m68k/sun3_eeprom_data.h
@@ -0,0 +1,259 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+static const uint8_t sun3_eeprom_blob[2048] = {
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x00, 0x3c,
+    0x00, 0x3c, 0x00, 0x00, 0xc4, 0xc4, 0xc4, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x04, 0x04, 0x00, 0x00,
+    0x12, 0x73, 0x64, 0x00, 0x08, 0x00, 0x03, 0x12,
+    0x12, 0x00, 0x73, 0x64, 0x00, 0x08, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x57, 0x65, 0x6c, 0x63, 0x6f, 0x6d, 0x65, 0x20,
+    0x74, 0x6f, 0x20, 0x53, 0x2f, 0x57, 0x20, 0x77,
+    0x6f, 0x72, 0x6b, 0x73, 0x74, 0x61, 0x74, 0x69,
+    0x6f, 0x6e, 0x20, 0x4c, 0x4d, 0x53, 0x32, 0x20,
+    0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x0d, 0x0a, 0x0a, 0x0a,
+    0x00, 0x00, 0x00, 0x00, 0x01, 0x04, 0x01, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x0c, 0x03, 0x01, 0x01,
+    0x02, 0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
+    0xf0, 0xf0, 0xf0, 0xf0, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf0,
+};
diff --git a/hw/m68k/sun3mmu.c b/hw/m68k/sun3mmu.c
new file mode 100644
index 0000000000..a0192b5677
--- /dev/null
+++ b/hw/m68k/sun3mmu.c
@@ -0,0 +1,705 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU Sun-3 MMU Model
+ *
+ * Copyright (c) 2026
+ */
+#include "qemu/osdep.h"
+
+#include "exec/cputlb.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/sysbus.h"
+#include "hw/m68k/sun3mmu.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "system/runstate.h"
+#include "target/m68k/cpu.h"
+#include "system/address-spaces.h"
+
+#define SUN3_MMU_CONTEXT(addr) ((addr >> 28) & 0x7)
+
+static uint64_t sun3_mmu_context_read(void *opaque, hwaddr addr,
+                                      unsigned size)
+{
+    Sun3MMUState *s = SUN3_MMU(opaque);
+    return s->context_reg;
+}
+
+static void sun3_mmu_context_write(void *opaque, hwaddr addr, uint64_t val,
+                                   unsigned size)
+{
+    Sun3MMUState *s = SUN3_MMU(opaque);
+    s->context_reg = val & 0x7;
+    tlb_flush(CPU(first_cpu));
+}
+
+static const MemoryRegionOps sun3_mmu_context_ops = {
+    .read = sun3_mmu_context_read,
+    .write = sun3_mmu_context_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
+};
+
+static uint64_t sun3_mmu_segment_read(void *opaque, hwaddr addr,
+                                      unsigned size)
+{
+    Sun3MMUState *s = SUN3_MMU(opaque);
+    uint32_t ctx = s->context_reg & (SUN3_MMU_CONTEXTS - 1);
+    /*
+     * The Segment Map index is determined by bits 17..27 of the virtual address
+     */
+    uint16_t seg_index = (addr >> 17) & 0x7FF;
+    uint32_t index = (ctx << 11) | seg_index;
+    return s->segment_map[index];
+}
+
+static void sun3_mmu_segment_write(void *opaque, hwaddr addr, uint64_t val,
+                                   unsigned size)
+{
+    Sun3MMUState *s = SUN3_MMU(opaque);
+    uint32_t ctx = s->context_reg & (SUN3_MMU_CONTEXTS - 1);
+    /*
+     * The Segment Map index is determined by bits 17..27 of the virtual address
+     */
+    uint16_t seg_index = (addr >> 17) & 0x7FF;
+    s->segment_map[(ctx * SUN3_MMU_SEGMENTS_PER_CONTEXT) + seg_index] =
+        val & 0xFF;
+    tlb_flush(CPU(first_cpu));
+}
+
+static const MemoryRegionOps sun3_mmu_segment_ops = {
+    .read = sun3_mmu_segment_read,
+    .write = sun3_mmu_segment_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
+    .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
+};
+
+static uint64_t sun3_mmu_page_read(void *opaque, hwaddr addr, unsigned size)
+{
+    Sun3MMUState *s = SUN3_MMU(opaque);
+    uint32_t ctx = s->context_reg & (SUN3_MMU_CONTEXTS - 1);
+
+    /*
+     * The Page Map address offset contains the virtual segment AND page
+     * index.
+     */
+    uint16_t vtr_seg = (addr >> 17) & 0x7FF;
+    uint16_t vtr_page = (addr >> 13) & 0xF;
+    uint32_t pmeg = s->segment_map[(ctx << 11) | vtr_seg];
+    uint32_t index = (pmeg << 4) | vtr_page;
+    return s->page_map[index];
+}
+
+static void sun3_mmu_page_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    Sun3MMUState *s = SUN3_MMU(opaque);
+    uint32_t ctx = s->context_reg & (SUN3_MMU_CONTEXTS - 1);
+
+    uint16_t vtr_seg = (addr >> 17) & 0x7FF;
+    uint16_t vtr_page = (addr >> 13) & 0xF;
+    uint32_t pmeg = s->segment_map[(ctx << 11) | vtr_seg];
+    uint32_t index = (pmeg << 4) | vtr_page;
+
+    if (size == 4) {
+        s->page_map[index] = val;
+    } else if (size == 2) {
+        uint32_t shift = (addr & 2) ? 0 : 16;
+        s->page_map[index] = (s->page_map[index] & ~(0xFFFF << shift)) |
+                             ((val & 0xFFFF) << shift);
+    } else if (size == 1) {
+        uint32_t shift = (3 - (addr & 3)) * 8;
+        s->page_map[index] = (s->page_map[index] & ~(0xFF << shift)) |
+                             ((val & 0xFF) << shift);
+    }
+
+    tlb_flush(CPU(first_cpu));
+}
+
+static const MemoryRegionOps sun3_mmu_page_ops = {
+    .read = sun3_mmu_page_read,
+    .write = sun3_mmu_page_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+    .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
+};
+
+static uint64_t sun3_mmu_control_read(void *opaque, hwaddr addr,
+                                      unsigned size)
+{
+    Sun3MMUState *s = SUN3_MMU(opaque);
+    /* The region covers multiple 32-bit mapped registers now */
+    if (addr == 0x0) {
+        /*
+         * The hardware diagnostic switch on the Sun-3 CPU board is checked
+         * here. Setting bit 0 to 1 forces the extended memory test.
+         */
+        return s->enable_reg | 0x01;
+    }
+
+    /* Diagnostic LEDs */
+    if (addr == 0x30000000) {
+        return 0xFF; /* Typically inverted, 0xFF means all off */
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "sun3_mmu_control_read at offset 0x%" HWADDR_PRIx
+                  " (size=%u)\n",
+                  addr, size);
+    return 0;
+}
+
+static uint64_t sun3_mmu_buserr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    Sun3MMUState *s = SUN3_MMU(opaque);
+
+    uint8_t ret = s->buserr_reg;
+    s->buserr_reg = 0; /* Hardware clears on read */
+
+    return ret;
+}
+
+static void sun3_mmu_buserr_write(void *opaque, hwaddr addr, uint64_t val,
+                                  unsigned size)
+{
+    Sun3MMUState *s = SUN3_MMU(opaque);
+    s->buserr_reg = 0;
+}
+
+static const MemoryRegionOps sun3_mmu_buserr_ops = {
+    .read = sun3_mmu_buserr_read,
+    .write = sun3_mmu_buserr_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
+};
+
+static void sun3_mmu_control_write(void *opaque, hwaddr addr, uint64_t val,
+                                   unsigned size)
+{
+    Sun3MMUState *s = SUN3_MMU(opaque);
+    if (addr == 0x0) {
+        /* System Enable Register at 0x40000000 */
+        uint8_t enable_old = s->enable_reg;
+        s->enable_reg = (enable_old & 0x01) | (val & 0xFE);
+
+        tlb_flush(CPU(first_cpu));
+        return;
+    }
+
+    if (addr == 0x30000000) {
+        /* Otherwise Diagnostic LEDs (e.g. 0xFF to clear) */
+        return;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "sun3_mmu_control_write at offset 0x%" HWADDR_PRIx
+                  "\n", addr);
+}
+
+static const MemoryRegionOps sun3_mmu_control_ops = {
+    .read = sun3_mmu_control_read,
+    .write = sun3_mmu_control_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
+};
+
+static void sun3_mmu_reset(DeviceState *dev)
+{
+    Sun3MMUState *s = SUN3_MMU(dev);
+
+    s->context_reg = 0;
+
+    /*
+     * On a Cold Boot, the Bus Error Register MUST be 0x00.
+     * Bit 0 is NOT a Watchdog flag that must be 1. In fact, if the register
+     * reads
+     * non-zero, the PROM assumes it is returning from a Watchdog/Bus Error
+     * Panic and attempts to dump CPU state to memory (moveml) before the
+     * MMU is initialized, causing a Double Fault.
+     */
+    s->buserr_reg = 0x00;
+
+    /*
+     * CRITICAL: Do NOT wipe the Segment Map or Page Map!
+       The Sun-3 Boot PROM relies on the physical MMU SRAM persisting across
+     * Watchdog Resets so it can trace and push exception vectors back
+     * into mapped physical RAM!
+     */
+}
+
+static void sun3_mmu_init(Object *obj)
+{
+    Sun3MMUState *s = SUN3_MMU(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    /* Context Map */
+    /*
+     * Note: Control space regions decode the top nibble of a 32-bit address.
+       The PROM uses the raw virtual address as the offset when accessing
+       these regions, so they must handle sparsely distributed addresses up to
+       256MB.
+    */
+    memory_region_init_io(&s->context_mem, obj, &sun3_mmu_context_ops, s,
+                          "sun3-mmu-context", 0x10000000);
+    sysbus_init_mmio(sbd, &s->context_mem);
+
+    /* Segment Map */
+    memory_region_init_io(&s->segment_mem, obj, &sun3_mmu_segment_ops, s,
+                          "sun3-mmu-segment", 0x10000000);
+    sysbus_init_mmio(sbd, &s->segment_mem);
+
+    /* Page Map */
+    memory_region_init_io(&s->page_mem, obj, &sun3_mmu_page_ops, s,
+                          "sun3-mmu-page", 0x10000000);
+    sysbus_init_mmio(sbd, &s->page_mem);
+
+    /* Other control bits (Enable Register, Diagnostic LEDs) */
+    memory_region_init_io(&s->control_mem, obj, &sun3_mmu_control_ops, s,
+                          "sun3-mmu-control", 0x40000000);
+    sysbus_init_mmio(sbd, &s->control_mem);
+
+    /*
+     * Bus Error Register dedicated mapping
+     */
+    memory_region_init_io(&s->buserr_mem, obj, &sun3_mmu_buserr_ops, s,
+                          "sun3-mmu-buserr", 1);
+    sysbus_init_mmio(sbd, &s->buserr_mem);
+
+    /* DVMA IOMMU interception region */
+    memory_region_init_iommu(&s->dvma_iommu, sizeof(s->dvma_iommu),
+                             TYPE_SUN3_DVMA_IOMMU_MEMORY_REGION,
+                             obj, "sun3-dvma", 0x1000000);
+}
+
+static void sun3_mmu_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, sun3_mmu_reset);
+    dc->vmsd = NULL; /* TODO: Add migration state later */
+}
+
+static IOMMUTLBEntry sun3_dvma_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
+                                         IOMMUAccessFlags flag, int iommu_idx)
+{
+    Sun3MMUState *s = container_of(iommu, Sun3MMUState, dvma_iommu);
+    CPUState *cs = first_cpu;
+    CPUM68KState *env = cs ? cpu_env(cs) : NULL;
+
+    IOMMUTLBEntry ret = {
+        .target_as = &address_space_memory,
+        .iova = addr,
+        .translated_addr = 0,
+        .addr_mask = ~(hwaddr)0,
+        .perm = IOMMU_NONE,
+    };
+
+    if (!env) {
+        return ret;
+    }
+
+    hwaddr physical;
+    int prot;
+    hwaddr page_size;
+    /*
+     * Lance DVMA translates 24-bit requests implicitly onto the top 16MB of
+     * the 28-bit virtual Bus (0x0Fxxxxxx) tied rigidly to Context 0.
+     */
+    uint32_t vaddr = addr + 0x0F000000;
+
+    int access_type = ACCESS_DATA | ACCESS_SUPER | (5 << 8);
+    if (flag == IOMMU_WO || flag == IOMMU_RW) {
+        access_type |= ACCESS_STORE;
+    }
+
+    uint8_t old_ctx = s->context_reg;
+    s->context_reg = 0; /* Hardware forces Context 0 during DVMA */
+
+    if (sun3mmu_get_physical_address(env, &physical, &prot, vaddr,
+                                     access_type, &page_size) == 0) {
+        ret.translated_addr = physical & ~(page_size - 1);
+        ret.addr_mask = page_size - 1;
+        if (prot & PAGE_WRITE) {
+            ret.perm = IOMMU_RW;
+        } else if (prot & PAGE_READ) {
+            ret.perm = IOMMU_RO;
+        }
+    }
+    s->context_reg = old_ctx; /* Restore pre-DVMA context */
+    return ret;
+}
+
+static void sun3_dvma_iommu_memory_region_class_init(ObjectClass *klass,
+                                                     const void *data)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
+    imrc->translate = sun3_dvma_translate;
+}
+
+static const TypeInfo sun3_dvma_iommu_memory_region_info = {
+    .name = TYPE_SUN3_DVMA_IOMMU_MEMORY_REGION,
+    .parent = TYPE_IOMMU_MEMORY_REGION,
+    .class_init = sun3_dvma_iommu_memory_region_class_init,
+};
+
+static const TypeInfo sun3_mmu_info = {
+    .name = TYPE_SUN3_MMU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Sun3MMUState),
+    .instance_init = sun3_mmu_init,
+    .class_init = sun3_mmu_class_init,
+};
+
+static void sun3_mmu_register_types(void)
+{
+    type_register_static(&sun3_mmu_info);
+    type_register_static(&sun3_dvma_iommu_memory_region_info);
+}
+
+type_init(sun3_mmu_register_types)
+
+static bool is_valid_sun3_phys(hwaddr p, ram_addr_t ram_size)
+{
+    if (p < ram_size) {
+        return true;
+    }
+    if (p >= 0x0FE50000 && p <= 0x0FE7FFFF) {
+        return true; /* NVRAM and OBIO RAM */
+    }
+    if (p >= 0x08000000 && p <= 0x08001FFF) {
+        return true; /* IDPROM */
+    }
+    if (p >= 0x0FEF0000 && p <= 0x0FEFFFFF) {
+        return true; /* PROM */
+    }
+    if (p >= 0x0FF00000 && p <= 0x0FF0FFFF) {
+        return true; /* PROM Alias */
+    }
+
+    /* Specific OBIO devices for Sun-3/60 (Ferrari) */
+    if (p >= 0x0FE00000 && p <= 0x0FE00007) {
+        return true; /* ZS1 (Kbd/Mouse) */
+    }
+    if (p >= 0x0FE20000 && p <= 0x0FE20007) {
+        return true; /* ZS0 (Serial) */
+    }
+    if (p >= 0x0FE40000 && p <= 0x0FE407FF) {
+        return true; /* EEPROM */
+    }
+    if (p >= 0x0FF20000 && p <= 0x0FF201FF) {
+        return true; /* LANCE Am7990 */
+    }
+    if (p >= 0x0FE60000 && p <= 0x0FE6003F) {
+        return true; /* Timer */
+    }
+    if (p >= 0x0FE80000 && p <= 0x0FE8001F) {
+        return true; /* Memerr */
+    }
+    if (p >= 0x0FEA0000 && p <= 0x0FEA0003) {
+        return true; /* Intreg */
+    }
+
+    return false;
+}
+
+int sun3mmu_get_physical_address(void *env, hwaddr *physical, int *prot,
+                                 vaddr address, int access_type,
+                                 hwaddr *page_size)
+{
+    /*
+     * Translate the virtual address using the Sun-3 MMU maps.
+     */
+    CPUM68KState *m68k_env = env;
+    Sun3MMUState *s = SUN3_MMU(m68k_env->custom_mmu_opaque);
+
+    uint8_t context;
+    uint16_t pmeg = 0;
+    uint32_t pte;
+    uint32_t pte_index = 0;
+    uint32_t pte_offset = 0;
+    uint32_t phys_addr;
+
+    /*
+     * access_type from m68k TCG:
+       ACCESS_CODE (0x10), ACCESS_DATA (0x20)
+        * ACCESS_SUPER (0x01) *
+        */
+    bool is_write = access_type & ACCESS_STORE;
+    bool is_supervisor = access_type & ACCESS_SUPER;
+
+    *page_size = TARGET_PAGE_SIZE;
+
+    /*
+     * QEMU Pipeline Prefetch Workaround:
+     * The Sun-3 PROM executes `movesb %d0, 0x40000000` out of ROM (0x0FEFxxxx)
+     * to enable the MMU (`enable_reg |= 0x80`). On real M68020 hardware, the
+     * subsequent instruction(s) have already been prefetched while the MMU
+     * was off. QEMU attempts to fetch the next sequential instruction
+     * synchronously with the MMU fully active. Because the PROM has not mapped
+     * 0x0FEF0000 in the Page Table (it only maps Virtual 0x00000000 to
+     * the ROM),
+     * QEMU triggers an immediate Translation Fault Exception Loop! We must
+     * manually bless instruction fetches originating mechanically from the
+     * physical ROM space to emulate the prefetch cache. *
+     */
+    if ((access_type & ACCESS_CODE) &&
+        (address >= 0x0FEF0000 && address <= 0x0FEFFFFF)) {
+        *physical = address;
+        *prot = PAGE_READ | PAGE_EXEC;
+        return 0;
+    }
+
+    /*
+     * Boot Mode PROM Bypass:
+       If the Not-Boot bit (0x80) in the Enable Register is clear (System is in
+       Boot State): ONLY Instruction Fetches bypass the MMU mapping mechanism!
+       Data accesses and Stack Pushes (such as the Exception Frame push to
+       0x0FEEFFFE) proceed through the MMU mapped tables normally because the
+        * PROM sets up its stack logically! *
+        */
+
+
+
+    qemu_log_mask(CPU_LOG_MMU,
+                  "[SUN3MMU] get_physical_address(0x%08" VADDR_PRIx
+                  ") enable_reg=0x%02x\n",
+                  address, s->enable_reg);
+
+    /*
+     * Sun-3 Hardware Architectural Demultiplexer:
+     * The M68020 emulator now seamlessly passes the Source/Destination Function
+     * Code inside the top 8 bits of the `access_type` bitmask, directly
+     * supplied
+     * via an isolation index in the QEMU TCG pipeline. This mirrors
+     * how the physical M68K processor provides 3 explicit FC pins in
+     * addition to
+     * the 32-bit physical address bus!
+     *
+     * If the extracted FC equals 3 (Control Space / Hardware Registers), it
+     * NEVER enters the MMU Segment Map. It is universally 1:1 mapped to
+     * physical memory for raw HW device configuration (0x60000000, 0x10000000)!
+     */
+    uint8_t true_fc = (access_type >> 8) & 0x07;
+    if (true_fc == 3) {
+        /*
+         * Direct Physical Bypass Mapping to discrete SysBus devices.
+         * The top nibble of the virtual address selects the Control Space
+         * target. All lower bits are aliases.
+         */
+        uint32_t device_base = address & 0x70000000;
+
+        if (device_base == 0x00000000) {
+            /*
+             * IDPROM is logically at 0x0 and occupies 32 bytes in hardware. We
+             * shift it to 0x08000000 linearly in QEMU and force a 5-bit wrap
+             * so it safely avoids physical Main RAM/ROM collisions! *
+             */
+            *physical = 0x08000000 | (address & 0x1F);
+        } else {
+            switch (device_base) {
+            case 0x10000000: /* Page Map */
+                /*
+                 * Hardware Page Map physically contains 256 PMEGs *
+                 * 16 PTEs * 4 bytes = 16,384 bytes
+                 */
+                *physical = 0xA0000000 | (address & 0x0FFFFFFF);
+                break;
+            case 0x20000000: /* Segment Map */
+                /*
+                 * Hardware Segment Map structurally is 8 Contexts *
+                 * 2048 segments * 1 byte = 16,384 bytes
+                 */
+                *physical = 0x90000000 | (address & 0x0FFFFFFF);
+                break;
+            case 0x30000000: /* Context Register */
+                /*
+                 * Context register physically uniquely masks natively
+                 * strictly functionally inside hardware
+                 */
+                *physical = 0x80000000 | (address & 0x07);
+                break;
+            case 0x40000000: /* System Enable */
+                *physical = 0xB0000000 | (address & 0x0FFFFFFF);
+                break;
+            case 0x60000000: /* Bus Error Register */
+                *physical = 0xC0000000 | (address & 0x0FFFFFFF);
+                break;
+            case 0x70000000:
+                /* Diagnostic Register (Aliases into Enable mem region) */
+                *physical = 0xB0000000ULL + 0x30000000ULL +
+                            (address & 0x0FFFFFFF);
+                break;
+            default:
+                s->buserr_reg |= 0x20; /* Timeout */
+                return 1;
+            }
+      }
+
+      *prot = PAGE_READ | PAGE_WRITE;
+      *page_size = SUN3_PAGE_SIZE;
+
+      qemu_log_mask(
+          CPU_LOG_MMU,
+          "[SUN3MMU] TRUE FC=3 CONTROL SPACE DECODE: vaddr=0x%08" VADDR_PRIx
+          " mapped directly to physical 0x%08x\n",
+          address, (unsigned int)*physical);
+
+      return 0;
+    }
+
+    /*
+     * For all standard memory operations, the Sun-3 physically masks the
+     * Address Bus to 28 virtual bits before hitting the MMU Arrays.
+     */
+    address &= 0x0FFFFFFF;
+
+    if (!(s->enable_reg & 0x80)) {
+        /* Boot State: Not-Boot bit (0x80) is CLEAR */
+
+        /*
+         * Address < 0x01000000 && Supervisor Program:
+         *    Bypass MMU and map to the physical PROM (0x0FEF0000).
+         */
+        if (true_fc == 6 && (address < 0x01000000 ||
+                             (address >= 0x0FEF0000 && address < 0x0FF00000))) {
+            *physical = 0x0FEF0000 | (address & 0x0001FFFF);
+            *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+            *page_size = SUN3_PAGE_SIZE;
+            return 0;
+        }
+    }
+
+    context = s->context_reg & (SUN3_MMU_CONTEXTS - 1);
+
+    /* Segment map lookup: top 11 bits of 28-bit virtual address (bits 17-27) */
+    uint32_t seg_index = (address >> 17) & (SUN3_MMU_SEGMENTS_PER_CONTEXT - 1);
+    pmeg = s->segment_map[(context * SUN3_MMU_SEGMENTS_PER_CONTEXT) +
+                          seg_index];
+
+    /* Page map lookup: bits 13-16 of virtual address */
+    pte_index = (address >> SUN3_PAGE_SHIFT) & (SUN3_MMU_PTE_PER_PMEG - 1);
+    pte_offset = (pmeg * SUN3_MMU_PTE_PER_PMEG) + pte_index;
+    pte = s->page_map[pte_offset];
+
+    /* Update PTE Accessed/Modified bits */
+    if (pte & SUN3_PTE_VALID) {
+        uint32_t new_pte = pte | SUN3_PTE_REF;
+        if (is_write) {
+            new_pte |= SUN3_PTE_MOD;
+        }
+        if (new_pte != pte) {
+            s->page_map[pte_offset] = new_pte;
+        }
+    }
+
+    if (!(pte & SUN3_PTE_VALID)) {
+        s->buserr_reg |= 0x80; /* Invalid */
+        return 1;              /* Translation fault */
+    }
+
+    /* Protection check */
+    uint8_t mmu_prot = (pte >> 29) & 3;
+
+    if (!is_supervisor && (mmu_prot & 1)) {
+        s->buserr_reg |= 0x40; /* Protection */
+        return 1;              /* User access to supervisor page */
+    }
+
+    *prot = PAGE_READ | PAGE_EXEC;
+    if (mmu_prot & 2) {
+        if (is_write || (pte & SUN3_PTE_MOD)) {
+            *prot |= PAGE_WRITE;
+        }
+    }
+
+    if (is_write && !(mmu_prot & 2)) {
+        s->buserr_reg |= 0x40; /* Protection */
+        return 1;
+    }
+
+    /*
+     * Extract physical address. The top 15 bits come from the PTE's
+     * PGFRAME. Bottom 13 bits (0x1FFF) come directly from the virtual
+     * address.
+     */
+    phys_addr = ((pte & SUN3_PTE_PGFRAME) << SUN3_PAGE_SHIFT) |
+                (address & (SUN3_PAGE_SIZE - 1));
+
+    /*
+     * Address space Mapping reference:
+     *   - OBMEM:   0x00000000 (Follows native Map)
+     *   - OBIO:    0x0FE00000 (Relocated above typical 24MB RAM)
+     *   - VME_D16: 0x40000000 (Relocated out of bounds)
+     *   - VME_D32: 0x50000000
+     */
+    uint32_t pgbase = ((pte & SUN3_PTE_PGFRAME) << SUN3_PAGE_SHIFT);
+    uint32_t pgtype = (pte & SUN3_PTE_PGTYPE) >> 26;
+
+    /*
+     * Sun-3 Hardware Quirk:
+     * The Boot PROM maps Virtual `0x00000000` to its ROM header using OBIO
+     * Page `0x80` (`0xC4000080`). Native hardware intercepts OBIO offset
+     * `0x100000` and transparently aliases it back to OBMEM PROM
+     * (`0x0FEF0000`) using the virtual address to index the ROM! *
+     */
+    if (pgtype == SUN3_PGTYPE_OBIO &&
+        (pgbase >= 0x100000 && pgbase < 0x120000)) {
+        phys_addr = 0x0FEF0000 | (address & 0x1FFFF);
+    } else {
+        switch (pgtype) {
+        case SUN3_PGTYPE_OBMEM:
+            break;
+        case SUN3_PGTYPE_OBIO:
+            phys_addr += 0x0FE00000;
+            break;
+        case SUN3_PGTYPE_VME_D16:
+            phys_addr += 0x40000000;
+            break;
+        case SUN3_PGTYPE_VME_D32:
+            phys_addr += 0x50000000;
+            break;
+        }
+    }
+
+    /* NXM (Non-Existent Memory) Bounds Checking */
+    if (!is_valid_sun3_phys(phys_addr, current_machine->ram_size)) {
+        s->buserr_reg |= 0x20; /* Timeout */
+        return 1;
+    }
+
+    /*
+     * The QEMU TLB works in 4KB frames, not Sun-3's 8KB native frames.
+     * We MUST explicitly append the intra-page offset within the 8KB page,
+     * otherwise accesses to the upper 4KB (e.g. 0x1000, 0x3000) will be
+     * truncated and overwrite the physical memory of the lower 4KB!
+     */
+    *physical = phys_addr | (address & (SUN3_PAGE_SIZE - 1));
+
+    *page_size = TARGET_PAGE_SIZE;
+
+    return 0; /* 0 = success, no fault */
+}
diff --git a/include/hw/m68k/sun3mmu.h b/include/hw/m68k/sun3mmu.h
new file mode 100644
index 0000000000..bdd79d963b
--- /dev/null
+++ b/include/hw/m68k/sun3mmu.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef HW_M68K_SUN3MMU_H
+#define HW_M68K_SUN3MMU_H
+
+#include "exec/cpu-common.h"
+#include "exec/hwaddr.h"
+#include "exec/target_page.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_SUN3_MMU "sun3-mmu"
+OBJECT_DECLARE_SIMPLE_TYPE(Sun3MMUState, SUN3_MMU)
+
+#define TYPE_SUN3_DVMA_IOMMU_MEMORY_REGION "sun3-dvma-iommu-memory-region"
+
+#define SUN3_MMU_CONTEXTS 8
+#define SUN3_MMU_PMEGS 256
+#define SUN3_MMU_PTE_PER_PMEG 16
+#define SUN3_MMU_SEGMENTS_PER_CONTEXT 2048
+
+#define SUN3_PAGE_SIZE 0x2000 /* 8 KB */
+#define SUN3_PAGE_MASK (~(SUN3_PAGE_SIZE - 1))
+#define SUN3_PAGE_SHIFT 13
+
+/* PTE bits */
+#define SUN3_PTE_VALID (1U << 31)
+#define SUN3_PTE_WRITE (1U << 30)
+#define SUN3_PTE_SYSTEM (1U << 29)
+#define SUN3_PTE_NC (1U << 28)
+#define SUN3_PTE_PGTYPE (3U << 26)
+#define SUN3_PTE_REF (1U << 25)
+#define SUN3_PTE_MOD (1U << 24)
+#define SUN3_PTE_PGFRAME 0x0007FFFF
+
+/* PTE PGTYPE values */
+#define SUN3_PGTYPE_OBMEM 0
+#define SUN3_PGTYPE_OBIO 1
+#define SUN3_PGTYPE_VME_D16 2
+#define SUN3_PGTYPE_VME_D32 3
+
+struct Sun3MMUState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion context_mem;
+    MemoryRegion segment_mem;
+    MemoryRegion page_mem;
+    MemoryRegion control_mem;
+    MemoryRegion buserr_mem;
+    IOMMUMemoryRegion dvma_iommu;
+
+    uint8_t sys_enable_reg; /* Reserved mapping for testing */
+
+    uint8_t context_reg;
+    uint8_t enable_reg;
+    uint8_t buserr_reg;
+    uint8_t int_reg;
+    uint8_t segment_map[SUN3_MMU_CONTEXTS * SUN3_MMU_SEGMENTS_PER_CONTEXT];
+    uint32_t page_map[SUN3_MMU_PMEGS * SUN3_MMU_PTE_PER_PMEG];
+};
+
+int sun3mmu_get_physical_address(void *env, hwaddr *physical, int *prot,
+                                 vaddr address, int access_type,
+                                 hwaddr *page_size);
+
+#endif
-- 
2.50.1 (Apple Git-155)


