Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D50C61DD6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0SiS-00086l-Mj; Sat, 29 Aug 2026 19:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiR-000862-0M; Sat, 29 Aug 2026 19:44:03 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiN-0006Dr-Fh; Sat, 29 Aug 2026 19:44:02 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXWzc2xq2zBqXm;
 Sun, 30 Aug 2026 01:43:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047020;
 bh=hLD3i3oCRJDl49ntg36l1fO5NhcwYmoduEeC9J/CmiU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=yFRLdgAaisbizj0BOi428ZfNMv173Hy9WINqzm9+Y0/ESbThTSDqc6atN+CIlsO5l
 5ph0TcwkwqnctZab+JKVj0CiMk4KIIJoT6i+JrWujWA4GseT8Slx5kelxd8EeYQmQ2
 rSptC3SD+e4HnPpMVQEjOfz9OhdNRxHyAG5sZ2UwigEmLnX30q1ZSG2U/oqPaSOrVF
 NUHvHlF3heJgkkkPuVd9Acd9AMF7UXF+X4m90WGSVqsxQMm9QLfW9KIvuxz6O+nqJH
 ywWTKAmXKlu+nG2wW3BTgR79YrtK3fYb+RhupGR3Yxl+kw96TEJFR6lm+V+756FNJJ
 eHGluTON1fahQ==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzc0gnnz7v19;
 Sun, 30 Aug 2026 01:43:40 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH RFC v2 06/30] hw/misc: add RP2040 SYSINFO and SYSCFG
Date: Sun, 30 Aug 2026 01:42:40 +0200
Message-ID: <20260829234308.33725-7-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
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

From: gilles grimaud <gilles.grimaud@univ-lille.fr>

Model the RP2040 identification and system configuration registers, including APB atomic aliases and documented reset and write masks. Wire SYSCFG into the SoC so NMI masks reroute interrupt inputs and MEMPOWERDOWN blocks access to powered-off ROM and SRAM banks.\n\nAdd focused qtests for register values, aliases, power-down behavior, and UART0 IRQ routing to NMI.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 MAINTAINERS                              |   1 +
 hw/arm/Kconfig                           |   2 +
 hw/arm/rp2040.c                          | 129 +++++++++++-
 hw/misc/Kconfig                          |   6 +
 hw/misc/meson.build                      |   2 +
 hw/misc/rp2040_syscfg.c                  | 244 +++++++++++++++++++++++
 hw/misc/rp2040_sysinfo.c                 | 103 ++++++++++
 include/hw/arm/rp2040.h                  |  12 ++
 include/hw/misc/rp2040_syscfg.h          |  42 ++++
 include/hw/misc/rp2040_sysinfo.h         |  25 +++
 tests/qtest/meson.build                  |   1 +
 tests/qtest/rp2040-sysinfo-syscfg-test.c | 176 ++++++++++++++++
 12 files changed, 740 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/rp2040_syscfg.c
 create mode 100644 hw/misc/rp2040_sysinfo.c
 create mode 100644 include/hw/misc/rp2040_syscfg.h
 create mode 100644 include/hw/misc/rp2040_sysinfo.h
 create mode 100644 tests/qtest/rp2040-sysinfo-syscfg-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b000b3287d..fd35521947 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1042,6 +1042,7 @@ S: Maintained
 F: hw/*/rp2040*
 F: include/hw/*/rp2040*
 F: hw/arm/raspi_pico.c
+F: tests/qtest/rp2040*
 F: tests/tcg/arm/system/rp2040*
 
 Real View
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d93303ab80..5d55ca06fd 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -379,6 +379,8 @@ config RP2040
     select ARM_V7M
     select PL011
     select RP2040_NYI
+    select RP2040_SYSCFG
+    select RP2040_SYSINFO
     select UNIMP
 
 config STM32F100_SOC
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 2196bad18d..a184d527e1 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -13,6 +13,7 @@
 #include "hw/core/loader.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/core/irq.h"
 #include "hw/misc/unimp.h"
 #include "qemu/datadir.h"
 #include "target/arm/cpu-qom.h"
@@ -49,8 +50,6 @@ static const struct {
     hwaddr base;
     hwaddr size;
 } rp2040_unimplemented[] = {
-    { "rp2040.sysinfo",  0x40000000, 0x4000 },
-    { "rp2040.syscfg",   0x40004000, 0x4000 },
     { "rp2040.clocks",   0x40008000, 0x4000 },
     { "rp2040.resets",   0x4000c000, 0x4000 },
     { "rp2040.psm",      0x40010000, 0x4000 },
@@ -84,6 +83,80 @@ static const struct {
     { "rp2040.sio",      0xd0000000, 0x1000 },
 };
 
+static MemTxResult rp2040_powered_off_read(void *opaque, hwaddr addr,
+                                           uint64_t *data, unsigned size,
+                                           MemTxAttrs attrs)
+{
+    *data = 0;
+    return MEMTX_ERROR;
+}
+
+static MemTxResult rp2040_powered_off_write(void *opaque, hwaddr addr,
+                                            uint64_t data, unsigned size,
+                                            MemTxAttrs attrs)
+{
+    return MEMTX_ERROR;
+}
+
+static const MemoryRegionOps rp2040_powered_off_ops = {
+    .read_with_attrs = rp2040_powered_off_read,
+    .write_with_attrs = rp2040_powered_off_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_update_mempowerdown(RP2040State *s)
+{
+    uint32_t mempowerdown;
+    int i;
+
+    if (!s->mempowerdown_ready) {
+        return;
+    }
+
+    mempowerdown = rp2040_syscfg_get_mempowerdown(&s->syscfg);
+    for (i = 0; i < ARRAY_SIZE(s->sram_poweroff); i++) {
+        memory_region_set_enabled(&s->sram_poweroff[i],
+                                  mempowerdown & BIT(i));
+    }
+    memory_region_set_enabled(&s->rom_poweroff, mempowerdown & BIT(7));
+}
+
+static void rp2040_update_nmi(RP2040State *s)
+{
+    uint32_t nmi_mask = rp2040_syscfg_get_proc0_nmi_mask(&s->syscfg);
+    bool nmi_level = false;
+    int i;
+
+    for (i = 0; i < RP2040_NUM_IRQS; i++) {
+        bool route_to_nmi = nmi_mask & BIT(i);
+
+        qemu_set_irq(s->cpu_irq[i], s->irq_level[i] && !route_to_nmi);
+        nmi_level |= s->irq_level[i] && route_to_nmi;
+    }
+    qemu_set_irq(s->nmi_irq, nmi_level);
+}
+
+static void rp2040_syscfg_update(void *opaque)
+{
+    RP2040State *s = opaque;
+
+    rp2040_update_mempowerdown(s);
+    rp2040_update_nmi(s);
+}
+
+static void rp2040_set_irq(void *opaque, int irq, int level)
+{
+    RP2040State *s = opaque;
+
+    assert(irq >= 0 && irq < RP2040_NUM_IRQS);
+    s->irq_level[irq] = level;
+    rp2040_update_nmi(s);
+}
+
 static void rp2040_soc_init(Object *obj)
 {
     RP2040State *s = RP2040(obj);
@@ -104,6 +177,10 @@ static void rp2040_soc_init(Object *obj)
                                   "chardev");
     }
 
+    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_RP2040_SYSCFG);
+    object_initialize_child(obj, "sysinfo", &s->sysinfo, TYPE_RP2040_SYSINFO);
+
+    s->irq = qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
     s->sysclk = clock_new(obj, "sysclk");
     clock_set_hz(s->sysclk, RP2040_SYSCLK_FRQ);
 }
@@ -117,9 +194,17 @@ static bool rp2040_init_memory(RP2040State *s, Error **errp)
         return false;
     }
     memory_region_add_subregion(s->board_memory, RP2040_ROM_BASE, &s->rom);
+    memory_region_init_io(&s->rom_poweroff, OBJECT(s),
+                          &rp2040_powered_off_ops, s,
+                          "rp2040.rom.poweroff", RP2040_ROM_SIZE);
+    memory_region_add_subregion_overlap(s->board_memory, RP2040_ROM_BASE,
+                                        &s->rom_poweroff, 1);
+    memory_region_set_enabled(&s->rom_poweroff, false);
 
     for (i = 0; i < 4; i++) {
         g_autofree char *name = g_strdup_printf("rp2040.sram%d", i);
+        g_autofree char *poweroff_name =
+            g_strdup_printf("rp2040.sram%d.poweroff", i);
 
         if (!memory_region_init_ram(&s->sram[i], OBJECT(s), name,
                                     RP2040_SRAM_BANK_SIZE, errp)) {
@@ -129,6 +214,14 @@ static bool rp2040_init_memory(RP2040State *s, Error **errp)
                                     RP2040_SRAM_BASE +
                                     i * RP2040_SRAM_BANK_SIZE,
                                     &s->sram[i]);
+        memory_region_init_io(&s->sram_poweroff[i], OBJECT(s),
+                              &rp2040_powered_off_ops, s, poweroff_name,
+                              RP2040_SRAM_BANK_SIZE);
+        memory_region_add_subregion_overlap(s->board_memory,
+                                            RP2040_SRAM_BASE +
+                                            i * RP2040_SRAM_BANK_SIZE,
+                                            &s->sram_poweroff[i], 1);
+        memory_region_set_enabled(&s->sram_poweroff[i], false);
     }
 
     if (!memory_region_init_ram(&s->sram[4], OBJECT(s), "rp2040.sram4",
@@ -137,6 +230,12 @@ static bool rp2040_init_memory(RP2040State *s, Error **errp)
     }
     memory_region_add_subregion(s->board_memory, RP2040_SRAM4_BASE,
                                 &s->sram[4]);
+    memory_region_init_io(&s->sram_poweroff[4], OBJECT(s),
+                          &rp2040_powered_off_ops, s,
+                          "rp2040.sram4.poweroff", RP2040_SRAM_HI_SIZE);
+    memory_region_add_subregion_overlap(s->board_memory, RP2040_SRAM4_BASE,
+                                        &s->sram_poweroff[4], 1);
+    memory_region_set_enabled(&s->sram_poweroff[4], false);
 
     if (!memory_region_init_ram(&s->sram[5], OBJECT(s), "rp2040.sram5",
                                 RP2040_SRAM_HI_SIZE, errp)) {
@@ -144,6 +243,14 @@ static bool rp2040_init_memory(RP2040State *s, Error **errp)
     }
     memory_region_add_subregion(s->board_memory, RP2040_SRAM5_BASE,
                                 &s->sram[5]);
+    memory_region_init_io(&s->sram_poweroff[5], OBJECT(s),
+                          &rp2040_powered_off_ops, s,
+                          "rp2040.sram5.poweroff", RP2040_SRAM_HI_SIZE);
+    memory_region_add_subregion_overlap(s->board_memory, RP2040_SRAM5_BASE,
+                                        &s->sram_poweroff[5], 1);
+    memory_region_set_enabled(&s->sram_poweroff[5], false);
+
+    s->mempowerdown_ready = true;
 
     return true;
 }
@@ -201,6 +308,22 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
         return;
     }
+    for (i = 0; i < RP2040_NUM_IRQS; i++) {
+        s->cpu_irq[i] = qdev_get_gpio_in(DEVICE(&s->armv7m), i);
+    }
+    s->nmi_irq = qdev_get_gpio_in_named(DEVICE(&s->armv7m), "NMI", 0);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->syscfg), 0, RP2040_SYSCFG_BASE);
+    rp2040_syscfg_set_update_callback(&s->syscfg, rp2040_syscfg_update, s);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysinfo), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, RP2040_SYSINFO_BASE);
+    rp2040_syscfg_update(s);
 
     for (i = 0; i < ARRAY_SIZE(s->uart); i++) {
         qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", s->sysclk);
@@ -209,7 +332,7 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, uart_base[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->armv7m), uart_irq[i]));
+                           s->irq[uart_irq[i]]);
     }
 }
 
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index de7a0f56fa..f6f344ab51 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -104,6 +104,12 @@ config FSL_IMX8MP_CCM
 config RP2040_NYI
     bool
 
+config RP2040_SYSCFG
+    bool
+
+config RP2040_SYSINFO
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 8611d59437..7be9f45c78 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -99,6 +99,8 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_powermgt.c',
 ))
 system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: files('rp2040_nyi.c'))
+system_ss.add(when: 'CONFIG_RP2040_SYSCFG', if_true: files('rp2040_syscfg.c'))
+system_ss.add(when: 'CONFIG_RP2040_SYSINFO', if_true: files('rp2040_sysinfo.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: files('xlnx-zynq-ddrc.c'))
diff --git a/hw/misc/rp2040_syscfg.c b/hw/misc/rp2040_syscfg.c
new file mode 100644
index 0000000000..69b4164ccd
--- /dev/null
+++ b/hw/misc/rp2040_syscfg.c
@@ -0,0 +1,244 @@
+/*
+ * RP2040 syscfg emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_syscfg.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+
+#define SYSCFG_PROC0_NMI_MASK          0x00
+#define SYSCFG_PROC1_NMI_MASK          0x04
+#define SYSCFG_PROC_CONFIG             0x08
+#define SYSCFG_PROC_IN_SYNC_BYPASS     0x0c
+#define SYSCFG_PROC_IN_SYNC_BYPASS_HI  0x10
+#define SYSCFG_DBGFORCE                0x14
+#define SYSCFG_MEMPOWERDOWN            0x18
+
+#define PROC_CONFIG_RW_MASK            0xff000000
+#define PROC_CONFIG_RESET              0x10000000
+#define PROC_IN_SYNC_BYPASS_MASK       0x3fffffff
+#define PROC_IN_SYNC_BYPASS_HI_MASK    0x0000003f
+#define DBGFORCE_RW_MASK               0x000000ee
+#define DBGFORCE_RESET                 0x00000066
+#define MEMPOWERDOWN_MASK              0x000000ff
+
+#define ATOMIC_ALIAS_MASK              0x3000
+#define ATOMIC_XOR                     0x1000
+#define ATOMIC_SET                     0x2000
+#define ATOMIC_CLR                     0x3000
+
+static uint32_t rp2040_syscfg_apply_alias(uint32_t old, uint32_t value,
+                                          hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static void rp2040_syscfg_update(RP2040SysCfgState *s)
+{
+    if (s->update) {
+        s->update(s->update_opaque);
+    }
+}
+
+void rp2040_syscfg_set_update_callback(RP2040SysCfgState *s,
+                                       RP2040SysCfgUpdateFn update,
+                                       void *opaque)
+{
+    s->update = update;
+    s->update_opaque = opaque;
+}
+
+uint32_t rp2040_syscfg_get_proc0_nmi_mask(RP2040SysCfgState *s)
+{
+    return s->proc0_nmi_mask;
+}
+
+uint32_t rp2040_syscfg_get_mempowerdown(RP2040SysCfgState *s)
+{
+    return s->mempowerdown;
+}
+
+static uint64_t rp2040_syscfg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040SysCfgState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case SYSCFG_PROC0_NMI_MASK:
+        value = s->proc0_nmi_mask;
+        break;
+    case SYSCFG_PROC1_NMI_MASK:
+        value = s->proc1_nmi_mask;
+        break;
+    case SYSCFG_PROC_CONFIG:
+        value = s->proc_config;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS:
+        value = s->proc_in_sync_bypass;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS_HI:
+        value = s->proc_in_sync_bypass_hi;
+        break;
+    case SYSCFG_DBGFORCE:
+        value = s->dbgforce;
+        break;
+    case SYSCFG_MEMPOWERDOWN:
+        value = s->mempowerdown;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("syscfg", size,
+                                      RP2040_SYSCFG_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_syscfg_write(void *opaque, hwaddr addr,
+                                uint64_t value64, unsigned size)
+{
+    RP2040SysCfgState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case SYSCFG_PROC0_NMI_MASK:
+        s->proc0_nmi_mask =
+            rp2040_syscfg_apply_alias(s->proc0_nmi_mask, value, alias);
+        rp2040_syscfg_update(s);
+        break;
+    case SYSCFG_PROC1_NMI_MASK:
+        s->proc1_nmi_mask =
+            rp2040_syscfg_apply_alias(s->proc1_nmi_mask, value, alias);
+        break;
+    case SYSCFG_PROC_CONFIG:
+        s->proc_config =
+            rp2040_syscfg_apply_alias(s->proc_config, value, alias) &
+            PROC_CONFIG_RW_MASK;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS:
+        s->proc_in_sync_bypass =
+            rp2040_syscfg_apply_alias(s->proc_in_sync_bypass, value, alias) &
+            PROC_IN_SYNC_BYPASS_MASK;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS_HI:
+        s->proc_in_sync_bypass_hi =
+            rp2040_syscfg_apply_alias(s->proc_in_sync_bypass_hi, value,
+                                      alias) &
+            PROC_IN_SYNC_BYPASS_HI_MASK;
+        break;
+    case SYSCFG_DBGFORCE:
+        s->dbgforce =
+            rp2040_syscfg_apply_alias(s->dbgforce, value, alias) &
+            DBGFORCE_RW_MASK;
+        break;
+    case SYSCFG_MEMPOWERDOWN:
+        s->mempowerdown =
+            rp2040_syscfg_apply_alias(s->mempowerdown, value, alias) &
+            MEMPOWERDOWN_MASK;
+        rp2040_syscfg_update(s);
+        break;
+    default:
+        rp2040_log_unimplemented_write("syscfg", size,
+                                       RP2040_SYSCFG_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_syscfg_ops = {
+    .read = rp2040_syscfg_read,
+    .write = rp2040_syscfg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_syscfg_reset(DeviceState *dev)
+{
+    RP2040SysCfgState *s = RP2040_SYSCFG(dev);
+
+    s->proc0_nmi_mask = 0;
+    s->proc1_nmi_mask = 0;
+    s->proc_config = PROC_CONFIG_RESET;
+    s->proc_in_sync_bypass = 0;
+    s->proc_in_sync_bypass_hi = 0;
+    s->dbgforce = DBGFORCE_RESET;
+    s->mempowerdown = 0;
+    rp2040_syscfg_update(s);
+}
+
+static int rp2040_syscfg_post_load(void *opaque, int version_id)
+{
+    RP2040SysCfgState *s = opaque;
+
+    rp2040_syscfg_update(s);
+    return 0;
+}
+
+static void rp2040_syscfg_init(Object *obj)
+{
+    RP2040SysCfgState *s = RP2040_SYSCFG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_syscfg_ops, s,
+                          "rp2040.syscfg", RP2040_SYSCFG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_syscfg_vmstate = {
+    .name = TYPE_RP2040_SYSCFG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = rp2040_syscfg_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(proc0_nmi_mask, RP2040SysCfgState),
+        VMSTATE_UINT32(proc1_nmi_mask, RP2040SysCfgState),
+        VMSTATE_UINT32(proc_config, RP2040SysCfgState),
+        VMSTATE_UINT32(proc_in_sync_bypass, RP2040SysCfgState),
+        VMSTATE_UINT32(proc_in_sync_bypass_hi, RP2040SysCfgState),
+        VMSTATE_UINT32(dbgforce, RP2040SysCfgState),
+        VMSTATE_UINT32(mempowerdown, RP2040SysCfgState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_syscfg_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_syscfg_reset);
+    dc->vmsd = &rp2040_syscfg_vmstate;
+}
+
+static const TypeInfo rp2040_syscfg_info = {
+    .name          = TYPE_RP2040_SYSCFG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040SysCfgState),
+    .instance_init = rp2040_syscfg_init,
+    .class_init    = rp2040_syscfg_class_init,
+};
+
+static void rp2040_syscfg_register_types(void)
+{
+    type_register_static(&rp2040_syscfg_info);
+}
+type_init(rp2040_syscfg_register_types)
diff --git a/hw/misc/rp2040_sysinfo.c b/hw/misc/rp2040_sysinfo.c
new file mode 100644
index 0000000000..15c50df6af
--- /dev/null
+++ b/hw/misc/rp2040_sysinfo.c
@@ -0,0 +1,103 @@
+/*
+ * RP2040 sysinfo emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_sysinfo.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define SYSINFO_CHIP_ID        0x00
+#define SYSINFO_PLATFORM       0x04
+#define SYSINFO_GITREF_RP2040  0x40
+
+#define SYSINFO_PLATFORM_ASIC  BIT(1)
+
+static uint64_t rp2040_sysinfo_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case SYSINFO_CHIP_ID:
+    case SYSINFO_GITREF_RP2040:
+        value = 0;
+        break;
+    case SYSINFO_PLATFORM:
+        value = SYSINFO_PLATFORM_ASIC;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("sysinfo", size,
+                                      RP2040_SYSINFO_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_sysinfo_write(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+
+    qemu_log_mask(LOG_GUEST_ERROR, "rp2040.sysinfo: write to read-only "
+                  "register (size %d, addr 0x%08" HWADDR_PRIx
+                  ", offset 0x%04" HWADDR_PRIx
+                  ", value 0x%0*" PRIx64 ")\n",
+                  size, RP2040_SYSINFO_BASE + addr, offset, size << 1, value);
+}
+
+static const MemoryRegionOps rp2040_sysinfo_ops = {
+    .read = rp2040_sysinfo_read,
+    .write = rp2040_sysinfo_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_sysinfo_init(Object *obj)
+{
+    RP2040SysInfoState *s = RP2040_SYSINFO(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_sysinfo_ops, s,
+                          "rp2040.sysinfo", RP2040_SYSINFO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_sysinfo_vmstate = {
+    .name = TYPE_RP2040_SYSINFO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_sysinfo_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &rp2040_sysinfo_vmstate;
+}
+
+static const TypeInfo rp2040_sysinfo_info = {
+    .name          = TYPE_RP2040_SYSINFO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040SysInfoState),
+    .instance_init = rp2040_sysinfo_init,
+    .class_init    = rp2040_sysinfo_class_init,
+};
+
+static void rp2040_sysinfo_register_types(void)
+{
+    type_register_static(&rp2040_sysinfo_info);
+}
+type_init(rp2040_sysinfo_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 4e5cd06add..caa1f9127f 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -13,6 +13,8 @@
 #include "hw/char/pl011.h"
 #include "hw/core/clock.h"
 #include "hw/core/sysbus.h"
+#include "hw/misc/rp2040_syscfg.h"
+#include "hw/misc/rp2040_sysinfo.h"
 #include "qom/object.h"
 
 #define TYPE_RP2040 "rp2040"
@@ -34,12 +36,22 @@ struct RP2040State {
 
     ARMv7MState armv7m;
     PL011State uart[2];
+    RP2040SysCfgState syscfg;
+    RP2040SysInfoState sysinfo;
 
     MemoryRegion *board_memory;
     MemoryRegion rom;
+    MemoryRegion rom_poweroff;
     MemoryRegion sram[6];
+    MemoryRegion sram_poweroff[6];
     char *bootrom_file;
 
+    qemu_irq *irq;
+    qemu_irq cpu_irq[RP2040_NUM_IRQS];
+    qemu_irq nmi_irq;
+    bool irq_level[RP2040_NUM_IRQS];
+    bool mempowerdown_ready;
+
     Clock *sysclk;
 };
 
diff --git a/include/hw/misc/rp2040_syscfg.h b/include/hw/misc/rp2040_syscfg.h
new file mode 100644
index 0000000000..c31799ae7a
--- /dev/null
+++ b/include/hw/misc/rp2040_syscfg.h
@@ -0,0 +1,42 @@
+/*
+ * RP2040 syscfg emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_SYSCFG_H
+#define HW_MISC_RP2040_SYSCFG_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_SYSCFG "rp2040-syscfg"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040SysCfgState, RP2040_SYSCFG)
+
+#define RP2040_SYSCFG_BASE 0x40004000
+#define RP2040_SYSCFG_SIZE 0x4000
+
+typedef void (*RP2040SysCfgUpdateFn)(void *opaque);
+
+struct RP2040SysCfgState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    RP2040SysCfgUpdateFn update;
+    void *update_opaque;
+    uint32_t proc0_nmi_mask;
+    uint32_t proc1_nmi_mask;
+    uint32_t proc_config;
+    uint32_t proc_in_sync_bypass;
+    uint32_t proc_in_sync_bypass_hi;
+    uint32_t dbgforce;
+    uint32_t mempowerdown;
+};
+
+void rp2040_syscfg_set_update_callback(RP2040SysCfgState *s,
+                                       RP2040SysCfgUpdateFn update,
+                                       void *opaque);
+uint32_t rp2040_syscfg_get_proc0_nmi_mask(RP2040SysCfgState *s);
+uint32_t rp2040_syscfg_get_mempowerdown(RP2040SysCfgState *s);
+
+#endif
diff --git a/include/hw/misc/rp2040_sysinfo.h b/include/hw/misc/rp2040_sysinfo.h
new file mode 100644
index 0000000000..d521659488
--- /dev/null
+++ b/include/hw/misc/rp2040_sysinfo.h
@@ -0,0 +1,25 @@
+/*
+ * RP2040 sysinfo emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_SYSINFO_H
+#define HW_MISC_RP2040_SYSINFO_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_SYSINFO "rp2040-sysinfo"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040SysInfoState, RP2040_SYSINFO)
+
+#define RP2040_SYSINFO_BASE 0x40000000
+#define RP2040_SYSINFO_SIZE 0x4000
+
+struct RP2040SysInfoState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5555ce4eae..692d51a78a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -255,6 +255,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-syscfg-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test'] : []) + \
diff --git a/tests/qtest/rp2040-sysinfo-syscfg-test.c b/tests/qtest/rp2040-sysinfo-syscfg-test.c
new file mode 100644
index 0000000000..18da6561bd
--- /dev/null
+++ b/tests/qtest/rp2040-sysinfo-syscfg-test.c
@@ -0,0 +1,176 @@
+/*
+ * QTest testcase for the RP2040 sysinfo and syscfg blocks.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define SYSINFO_BASE                  0x40000000
+#define SYSINFO_CHIP_ID               0x00
+#define SYSINFO_PLATFORM              0x04
+#define SYSINFO_GITREF_RP2040         0x40
+#define SYSINFO_PLATFORM_ASIC         BIT(1)
+
+#define SYSCFG_BASE                   0x40004000
+#define SYSCFG_PROC0_NMI_MASK         0x00
+#define SYSCFG_PROC1_NMI_MASK         0x04
+#define SYSCFG_PROC_CONFIG            0x08
+#define SYSCFG_PROC_IN_SYNC_BYPASS    0x0c
+#define SYSCFG_PROC_IN_SYNC_BYPASS_HI 0x10
+#define SYSCFG_DBGFORCE               0x14
+#define SYSCFG_MEMPOWERDOWN           0x18
+
+#define SRAM0_BASE                    0x20000000
+#define UART0_BASE                    0x40034000
+#define UARTDR                        0x00
+#define UARTCR                        0x30
+#define UARTIMSC                      0x38
+#define UARTICR                       0x44
+#define UART_INT_TX                   BIT(5)
+#define UART0_IRQ                     20
+#define NVIC_ISPR                     0xe000e200
+#define NVIC_ICPR                     0xe000e280
+#define NVIC_ICSR                     0xe000ed04
+#define NVIC_ICSR_NMIPENDSET          BIT(31)
+
+#define PROC_CONFIG_RESET             0x10000000
+#define DBGFORCE_RESET                0x00000066
+
+#define ATOMIC_SET_ALIAS              0x2000
+#define ATOMIC_CLR_ALIAS              0x3000
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_sysinfo_read_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + SYSINFO_CHIP_ID), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + SYSINFO_PLATFORM), ==,
+                    SYSINFO_PLATFORM_ASIC);
+    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + SYSINFO_GITREF_RP2040),
+                    ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC1_NMI_MASK),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC_CONFIG), ==,
+                    PROC_CONFIG_RESET);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_DBGFORCE), ==,
+                    DBGFORCE_RESET);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_rw_masks(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, 0xa5a5a5a5);
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC1_NMI_MASK, 0x5a5a5a5a);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK),
+                    ==, 0xa5a5a5a5);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC1_NMI_MASK),
+                    ==, 0x5a5a5a5a);
+
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS, 0xffffffff);
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS_HI,
+                 0xffffffff);
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts,
+                                SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS),
+                    ==, 0x3fffffff);
+    g_assert_cmphex(qtest_readl(qts,
+                                SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS_HI),
+                    ==, 0x0000003f);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN), ==,
+                    0x000000ff);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_atomic_aliases(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, 0);
+    qtest_writel(qts, SYSCFG_BASE + ATOMIC_SET_ALIAS + SYSCFG_PROC0_NMI_MASK,
+                 0x0000000f);
+    qtest_writel(qts, SYSCFG_BASE + ATOMIC_CLR_ALIAS + SYSCFG_PROC0_NMI_MASK,
+                 0x00000003);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK),
+                    ==, 0x0000000c);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_mempowerdown_blocks_sram(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SRAM0_BASE, 0x11223344);
+    g_assert_cmphex(qtest_readl(qts, SRAM0_BASE), ==, 0x11223344);
+
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, BIT(0));
+    qtest_writel(qts, SRAM0_BASE, 0xaabbccdd);
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, 0);
+
+    g_assert_cmphex(qtest_readl(qts, SRAM0_BASE), ==, 0x11223344);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_nmi_mask_routes_uart0_irq(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, UART0_BASE + UARTCR, BIT(0) | BIT(8));
+    qtest_writel(qts, UART0_BASE + UARTIMSC, UART_INT_TX);
+
+    qtest_writel(qts, UART0_BASE + UARTICR, UART_INT_TX);
+    qtest_writel(qts, NVIC_ICPR, BIT(UART0_IRQ));
+    qtest_writel(qts, UART0_BASE + UARTDR, 'a');
+    g_assert_cmphex(qtest_readl(qts, NVIC_ISPR) & BIT(UART0_IRQ), ==,
+                    BIT(UART0_IRQ));
+
+    qtest_writel(qts, UART0_BASE + UARTICR, UART_INT_TX);
+    qtest_writel(qts, NVIC_ICPR, BIT(UART0_IRQ));
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, BIT(UART0_IRQ));
+    qtest_writel(qts, UART0_BASE + UARTDR, 'b');
+    g_assert_cmphex(qtest_readl(qts, NVIC_ISPR) & BIT(UART0_IRQ), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, NVIC_ICSR) & NVIC_ICSR_NMIPENDSET, ==,
+                    NVIC_ICSR_NMIPENDSET);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-sysinfo/read-values", test_sysinfo_read_values);
+    qtest_add_func("/rp2040-syscfg/reset-values", test_syscfg_reset_values);
+    qtest_add_func("/rp2040-syscfg/rw-masks", test_syscfg_rw_masks);
+    qtest_add_func("/rp2040-syscfg/atomic-aliases",
+                   test_syscfg_atomic_aliases);
+    qtest_add_func("/rp2040-syscfg/mempowerdown-blocks-sram",
+                   test_syscfg_mempowerdown_blocks_sram);
+    qtest_add_func("/rp2040-syscfg/nmi-mask-routes-uart0-irq",
+                   test_syscfg_nmi_mask_routes_uart0_irq);
+
+    return g_test_run();
+}
-- 
2.55.0


