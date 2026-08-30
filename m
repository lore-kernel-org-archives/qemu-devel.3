Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8DAC61DB9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 06:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0YrE-0002U9-Mu; Sun, 30 Aug 2026 02:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0YrC-0002Sk-Le; Sun, 30 Aug 2026 02:17:30 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Yr8-0005GS-3g; Sun, 30 Aug 2026 02:17:30 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXhjn1zZBzBqYZ;
 Sun, 30 Aug 2026 08:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788070637;
 bh=VnNL4Vhac2Gl5CCzXIjMMSPGgp/BomdyeKTVTuTnGFk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WO+pN7/hWmdhifpyuSaHbpystV0OERHLmKFw+Rg9fewkR3YGCp4vj8ybhRkGYHa7a
 V6C2qmEjxAXvTdUq2/R/NQPF0fQx35c3koX/0ZvPs9d3Y1anijgnKtkjbwk7yaxpQ/
 A6Mw1wq/I99OB1GCLe446nKzsVfFH4Ni2++Sf7LzK8AQCFroMTactxLbJ1LBgtlYfe
 BtjevpT9GWn3Bd/yNDGgTA/w4Cz4chrkVbKKPMOFM0v6hma7HkDr3jHZJhVOAzXv7W
 dL9QeD3B6W2/KidSEgknPxw7s88jsvKJ6B4OGXpYvn4LNBoquDHYITyHCCHZQdhMxR
 GYioZ+WtVq5Kg==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXhjn0Wxqz7xSW;
 Sun, 30 Aug 2026 08:17:17 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH RFC v2 16/30] hw/misc: add RP2040 SIO and multicore support
Date: Sun, 30 Aug 2026 08:15:47 +0200
Message-ID: <20260830061601.52136-2-gilles.grimaud@univ-lille.fr>
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

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/Kconfig                |   1 +
 hw/arm/raspi_pico.c           |   9 +-
 hw/arm/rp2040.c               | 187 +++++--
 hw/misc/Kconfig               |   3 +
 hw/misc/meson.build           |   1 +
 hw/misc/rp2040_sio.c          | 905 ++++++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h       |  12 +-
 include/hw/misc/rp2040_sio.h  |  57 +++
 tests/qtest/meson.build       |   2 +
 tests/qtest/rp2040-psm-test.c |  81 +++
 tests/qtest/rp2040-sio-test.c | 270 ++++++++++
 11 files changed, 1484 insertions(+), 44 deletions(-)
 create mode 100644 hw/misc/rp2040_sio.c
 create mode 100644 include/hw/misc/rp2040_sio.h
 create mode 100644 tests/qtest/rp2040-psm-test.c
 create mode 100644 tests/qtest/rp2040-sio-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a1b94532b4..a5cbbaef28 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -387,6 +387,7 @@ config RP2040
     select RP2040_PSM
     select RP2040_RESETS
     select RP2040_ROSC
+    select RP2040_SIO
     select RP2040_SYSCFG
     select RP2040_SYSINFO
     select RP2040_TBMAN
diff --git a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c
index e75d61ca07..dd07c58801 100644
--- a/hw/arm/raspi_pico.c
+++ b/hw/arm/raspi_pico.c
@@ -81,6 +81,7 @@ static void raspi_pico_init(MachineState *machine)
                          s->rosc_random_seed_value);
     qdev_prop_set_bit(DEVICE(&s->soc.rosc), "random-seed-set",
                       s->rosc_random_seed_set);
+    qdev_prop_set_uint32(DEVICE(&s->soc.sio), "gpio-hi-in", 1u << 1);
     if (machine->firmware) {
         qdev_prop_set_string(DEVICE(&s->soc), "bootrom-file",
                              machine->firmware);
@@ -94,7 +95,7 @@ static void raspi_pico_init(MachineState *machine)
 
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
-    armv7m_load_kernel(s->soc.armv7m.cpu, machine->kernel_filename,
+    armv7m_load_kernel(s->soc.armv7m[0].cpu, machine->kernel_filename,
                        RP2040_XIP_BASE, PICO_FLASH_SIZE);
 }
 
@@ -133,9 +134,9 @@ static void raspi_pico_machine_class_init(ObjectClass *oc, const void *data)
 
     mc->desc = "Raspberry Pi Pico (Cortex-M0+)";
     mc->init = raspi_pico_init;
-    mc->default_cpus = 1;
-    mc->min_cpus = 1;
-    mc->max_cpus = 1;
+    mc->default_cpus = RP2040_NUM_CORES;
+    mc->min_cpus = RP2040_NUM_CORES;
+    mc->max_cpus = RP2040_NUM_CORES;
     mc->default_ram_size = 0;
     mc->no_parallel = 1;
     mc->no_floppy = 1;
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index c8fe2c0934..6067d53246 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -16,6 +16,7 @@
 #include "hw/core/irq.h"
 #include "hw/misc/unimp.h"
 #include "qemu/datadir.h"
+#include "target/arm/cpu.h"
 #include "target/arm/cpu-qom.h"
 
 #define RP2040_UART0_BASE 0x40034000
@@ -23,25 +24,42 @@
 #define RP2040_UART1_BASE 0x40038000
 #define RP2040_UART1_IRQ  21
 #define RP2040_IO_IRQ_BANK0 13
+#define RP2040_SIO_IRQ_PROC0 15
+#define RP2040_SIO_IRQ_PROC1 16
+#define RP2040_PROC1          1
 
 /*
- * Temporary boot ROM used until the synthetic ROM is introduced. It loads
- * the reset handler from a vector table at the base of the XIP window.
+ * Minimal synthetic ROM. Core 0 enters the XIP image while core 1 waits for
+ * the RP2040 ROM FIFO launch sequence: { 0, 0, 1, VTOR, SP, PC }.
  */
 static const uint8_t rp2040_bootrom[] = {
-    0x00, 0x20, 0x04, 0x20, /* initial SP: 0x20042000 */
-    0x09, 0x00, 0x00, 0x00, /* reset handler: 0x00000009 */
-    0x03, 0x48,             /* ldr r0, vtor */
-    0x04, 0x49,             /* ldr r1, xip_base */
-    0x01, 0x60,             /* str r1, [r0] */
-    0x04, 0x48,             /* ldr r0, xip_reset_vector */
-    0x01, 0x68,             /* ldr r1, [r0] */
-    0x08, 0x47,             /* bx r1 */
-    0xfe, 0xe7,             /* b . */
-    0xc0, 0x46,             /* nop */
-    0x08, 0xed, 0x00, 0xe0, /* VTOR: 0xe000ed08 */
-    0x00, 0x00, 0x00, 0x10, /* XIP base: 0x10000000 */
-    0x04, 0x00, 0x00, 0x10, /* XIP reset vector: 0x10000004 */
+    0x00, 0x20, 0x04, 0x20, 0x41, 0x00, 0x00, 0x00,
+    0x97, 0x00, 0x00, 0x00, 0x97, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x1f, 0x4c, 0x20, 0x68, 0x00, 0x28, 0x05, 0xd1,
+    0x1e, 0x48, 0x1f, 0x49, 0x01, 0x60, 0x1f, 0x48,
+    0x01, 0x68, 0x08, 0x47, 0x1e, 0x4d, 0x00, 0x26,
+    0x00, 0xf0, 0x1e, 0xf8, 0x03, 0x2e, 0x07, 0xd2,
+    0xb1, 0x00, 0x6a, 0x58, 0x90, 0x42, 0x0c, 0xd0,
+    0x00, 0x26, 0x00, 0xf0, 0x1c, 0xf8, 0xf3, 0xe7,
+    0x03, 0x2e, 0x01, 0xd1, 0x07, 0x46, 0x04, 0xe0,
+    0x04, 0x2e, 0x01, 0xd1, 0x03, 0x46, 0x00, 0xe0,
+    0x05, 0x46, 0x00, 0xf0, 0x10, 0xf8, 0x01, 0x36,
+    0x06, 0x2e, 0xe5, 0xd1, 0x0d, 0x49, 0x0f, 0x60,
+    0x83, 0xf3, 0x08, 0x88, 0x28, 0x47, 0xfe, 0xe7,
+    0x09, 0x4c, 0x20, 0x6d, 0x01, 0x21, 0x08, 0x42,
+    0xfb, 0xd0, 0xa0, 0x6d, 0x70, 0x47, 0x06, 0x4c,
+    0x21, 0x6d, 0x02, 0x22, 0x11, 0x42, 0xfb, 0xd0,
+    0x60, 0x65, 0x70, 0x47, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0xd0, 0x08, 0xed, 0x00, 0xe0,
+    0x00, 0x00, 0x00, 0x10, 0x04, 0x00, 0x00, 0x10,
+    0xb4, 0x00, 0x00, 0x00,
 };
 
 static const struct {
@@ -63,7 +81,6 @@ static const struct {
     { "rp2040.usbctrl_regs",  0x50110000, 0x10000 },
     { "rp2040.pio0",     0x50200000, 0x10000 },
     { "rp2040.pio1",     0x50300000, 0x10000 },
-    { "rp2040.sio",      0xd0000000, 0x1000 },
 };
 
 static MemTxResult rp2040_powered_off_read(void *opaque, hwaddr addr,
@@ -117,10 +134,12 @@ static void rp2040_update_nmi(RP2040State *s)
     for (i = 0; i < RP2040_NUM_IRQS; i++) {
         bool route_to_nmi = nmi_mask & BIT(i);
 
-        qemu_set_irq(s->cpu_irq[i], s->irq_level[i] && !route_to_nmi);
-        nmi_level |= s->irq_level[i] && route_to_nmi;
+        bool irq_level = s->irq_level[0][i];
+
+        qemu_set_irq(s->cpu_irq[0][i], irq_level && !route_to_nmi);
+        nmi_level |= irq_level && route_to_nmi;
     }
-    qemu_set_irq(s->nmi_irq, nmi_level);
+    qemu_set_irq(s->nmi_irq[0], nmi_level);
 }
 
 static void rp2040_syscfg_update(void *opaque)
@@ -136,10 +155,75 @@ static void rp2040_set_irq(void *opaque, int irq, int level)
     RP2040State *s = opaque;
 
     assert(irq >= 0 && irq < RP2040_NUM_IRQS);
-    s->irq_level[irq] = level;
+    s->irq_level[0][irq] = level;
     rp2040_update_nmi(s);
 }
 
+static void rp2040_start_core1_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    cpu_reset(cs);
+    cpu->power_state = PSCI_ON;
+    env->halt_reason = NOT_HALTED;
+    arm_rebuild_hflags(env);
+    cs->halted = 0;
+    cpu_resume(cs);
+}
+
+static bool rp2040_core1_powered_off(RP2040State *s)
+{
+    ARMCPU *cpu = s->armv7m[RP2040_PROC1].cpu;
+
+    return !cpu || cpu->power_state == PSCI_OFF;
+}
+
+static void rp2040_start_core1(RP2040State *s)
+{
+    if (!s->armv7m[RP2040_PROC1].cpu ||
+        !rp2040_core1_powered_off(s)) {
+        return;
+    }
+
+    async_run_on_cpu(CPU(s->armv7m[RP2040_PROC1].cpu),
+                     rp2040_start_core1_async_work, RUN_ON_CPU_NULL);
+}
+
+static void rp2040_stop_core1_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    cpu->power_state = PSCI_OFF;
+    cpu->env.halt_reason = HALT_PSCI;
+    cs->halted = 1;
+    cs->exception_index = EXCP_HLT;
+}
+
+static void rp2040_stop_core1(RP2040State *s)
+{
+    if (!s->armv7m[RP2040_PROC1].cpu ||
+        rp2040_core1_powered_off(s)) {
+        return;
+    }
+
+    async_run_on_cpu(CPU(s->armv7m[RP2040_PROC1].cpu),
+                     rp2040_stop_core1_async_work, RUN_ON_CPU_NULL);
+}
+
+static void rp2040_psm_update(void *opaque)
+{
+    RP2040State *s = opaque;
+    bool proc1_forced_off = rp2040_psm_get_frce_off(&s->psm) &
+                            RP2040_PSM_PROC1;
+
+    if (proc1_forced_off) {
+        rp2040_stop_core1(s);
+    } else {
+        rp2040_start_core1(s);
+    }
+}
+
 static void rp2040_update_uart_pins(RP2040State *s)
 {
     pl011_set_tx_connected(&s->uart[0],
@@ -188,11 +272,18 @@ static void rp2040_soc_init(Object *obj)
     qdev_init_gpio_in_named(DEVICE(obj), rp2040_set_uart_pin,
                             "uart-pin", 4);
 
-    object_initialize_child(obj, "proc0", &s->armv7m, TYPE_ARMV7M);
-    qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type",
-                         ARM_CPU_TYPE_NAME("cortex-m0"));
-    qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq", RP2040_NUM_IRQS);
-    qdev_prop_set_uint32(DEVICE(&s->armv7m), "mpu-ns-regions", 8);
+    for (i = 0; i < RP2040_NUM_CORES; i++) {
+        g_autofree char *name = g_strdup_printf("proc%d", i);
+
+        object_initialize_child(obj, name, &s->armv7m[i], TYPE_ARMV7M);
+        qdev_prop_set_string(DEVICE(&s->armv7m[i]), "cpu-type",
+                             ARM_CPU_TYPE_NAME("cortex-m0"));
+        qdev_prop_set_uint32(DEVICE(&s->armv7m[i]), "num-irq",
+                             RP2040_NUM_IRQS);
+        qdev_prop_set_uint32(DEVICE(&s->armv7m[i]), "mpu-ns-regions", 8);
+    }
+    qdev_prop_set_bit(DEVICE(&s->armv7m[RP2040_PROC1]),
+                      "start-powered-off", true);
 
     for (i = 0; i < ARRAY_SIZE(s->uart); i++) {
         g_autofree char *name = g_strdup_printf("uart%d", i);
@@ -230,6 +321,7 @@ static void rp2040_soc_init(Object *obj)
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_RP2040_SYSCFG);
     object_initialize_child(obj, "sysinfo", &s->sysinfo, TYPE_RP2040_SYSINFO);
     object_initialize_child(obj, "rosc", &s->rosc, TYPE_RP2040_ROSC);
+    object_initialize_child(obj, "sio", &s->sio, TYPE_RP2040_SIO);
     object_initialize_child(obj, "tbman", &s->tbman, TYPE_RP2040_TBMAN);
     object_initialize_child(obj, "vreg", &s->vreg, TYPE_RP2040_VREG);
     object_initialize_child(obj, "watchdog", &s->watchdog,
@@ -378,26 +470,45 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->psm), 0, RP2040_PSM_BASE);
+    rp2040_psm_set_update_callback(&s->psm, rp2040_psm_update, s);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->resets), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->resets), 0, RP2040_RESETS_BASE);
 
-    qdev_connect_clock_in(DEVICE(&s->armv7m), "cpuclk", s->sysclk);
-    object_property_set_link(OBJECT(&s->armv7m), "memory",
-                             OBJECT(s->board_memory), &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sio), errp)) {
         return;
     }
-    for (i = 0; i < RP2040_NUM_IRQS; i++) {
-        s->cpu_irq[i] = qdev_get_gpio_in(DEVICE(&s->armv7m), i);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sio), 0, RP2040_SIO_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sio), 0,
+                       s->irq[RP2040_SIO_IRQ_PROC0]);
+
+    for (i = 0; i < RP2040_NUM_CORES; i++) {
+        int irq;
+        g_autofree char *name = g_strdup_printf("rp2040.proc%d-memory", i);
+
+        qdev_connect_clock_in(DEVICE(&s->armv7m[i]), "cpuclk", s->sysclk);
+        memory_region_init_alias(&s->cpu_memory[i], OBJECT(dev), name,
+                                 s->board_memory, 0,
+                                 memory_region_size(s->board_memory));
+        object_property_set_link(OBJECT(&s->armv7m[i]), "memory",
+                                 OBJECT(&s->cpu_memory[i]), &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m[i]), errp)) {
+            return;
+        }
+        for (irq = 0; irq < RP2040_NUM_IRQS; irq++) {
+            s->cpu_irq[i][irq] = qdev_get_gpio_in(DEVICE(&s->armv7m[i]),
+                                                  irq);
+        }
+        s->nmi_irq[i] = qdev_get_gpio_in_named(DEVICE(&s->armv7m[i]),
+                                               "NMI", 0);
     }
-    s->nmi_irq = qdev_get_gpio_in_named(DEVICE(&s->armv7m), "NMI", 0);
+    rp2040_update_nmi(s);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
         return;
@@ -417,6 +528,8 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->iobank0), 0, RP2040_IOBANK0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->iobank0), 0,
                        s->irq[RP2040_IO_IRQ_BANK0]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->iobank0), 1,
+                       s->cpu_irq[RP2040_PROC1][RP2040_IO_IRQ_BANK0]);
     qdev_connect_gpio_out_named(DEVICE(&s->iobank0), "uart0-pin", 0,
                                 qdev_get_gpio_in_named(dev, "uart-pin", 0));
     qdev_connect_gpio_out_named(DEVICE(&s->iobank0), "uart0-pin", 1,
@@ -425,6 +538,8 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
                                 qdev_get_gpio_in_named(dev, "uart-pin", 2));
     qdev_connect_gpio_out_named(DEVICE(&s->iobank0), "uart1-pin", 1,
                                 qdev_get_gpio_in_named(dev, "uart-pin", 3));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sio), 1,
+                       s->cpu_irq[RP2040_PROC1][RP2040_SIO_IRQ_PROC1]);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioqspi), errp)) {
         return;
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 553a92d4b6..0168f85810 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -128,6 +128,9 @@ config RP2040_RESETS
 config RP2040_ROSC
     bool
 
+config RP2040_SIO
+    bool
+
 config RP2040_SYSCFG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 5e4910e83d..5cdbde9b37 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -107,6 +107,7 @@ system_ss.add(when: 'CONFIG_RP2040_PLL', if_true: files('rp2040_pll.c'))
 system_ss.add(when: 'CONFIG_RP2040_PSM', if_true: files('rp2040_psm.c'))
 system_ss.add(when: 'CONFIG_RP2040_RESETS', if_true: files('rp2040_resets.c'))
 system_ss.add(when: 'CONFIG_RP2040_ROSC', if_true: files('rp2040_rosc.c'))
+system_ss.add(when: 'CONFIG_RP2040_SIO', if_true: files('rp2040_sio.c'))
 system_ss.add(when: 'CONFIG_RP2040_SYSCFG', if_true: files('rp2040_syscfg.c'))
 system_ss.add(when: 'CONFIG_RP2040_SYSINFO', if_true: files('rp2040_sysinfo.c'))
 system_ss.add(when: 'CONFIG_RP2040_TBMAN', if_true: files('rp2040_tbman.c'))
diff --git a/hw/misc/rp2040_sio.c b/hw/misc/rp2040_sio.c
new file mode 100644
index 0000000000..1a04c426a7
--- /dev/null
+++ b/hw/misc/rp2040_sio.c
@@ -0,0 +1,905 @@
+/*
+ * RP2040 single-cycle IO block emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_sio.h"
+#include "hw/core/cpu.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define SIO_CPUID               0x000
+#define SIO_GPIO_IN             0x004
+#define SIO_GPIO_HI_IN          0x008
+#define SIO_GPIO_OUT            0x010
+#define SIO_GPIO_OUT_SET        0x014
+#define SIO_GPIO_OUT_CLR        0x018
+#define SIO_GPIO_OUT_XOR        0x01c
+#define SIO_GPIO_OE             0x020
+#define SIO_GPIO_OE_SET         0x024
+#define SIO_GPIO_OE_CLR         0x028
+#define SIO_GPIO_OE_XOR         0x02c
+#define SIO_GPIO_HI_OUT         0x030
+#define SIO_GPIO_HI_OUT_SET     0x034
+#define SIO_GPIO_HI_OUT_CLR     0x038
+#define SIO_GPIO_HI_OUT_XOR     0x03c
+#define SIO_GPIO_HI_OE          0x040
+#define SIO_GPIO_HI_OE_SET      0x044
+#define SIO_GPIO_HI_OE_CLR      0x048
+#define SIO_GPIO_HI_OE_XOR      0x04c
+#define SIO_FIFO_ST             0x050
+#define SIO_FIFO_WR             0x054
+#define SIO_FIFO_RD             0x058
+#define SIO_SPINLOCK_ST         0x05c
+#define SIO_DIV_UDIVIDEND       0x060
+#define SIO_DIV_UDIVISOR        0x064
+#define SIO_DIV_SDIVIDEND       0x068
+#define SIO_DIV_SDIVISOR        0x06c
+#define SIO_DIV_QUOTIENT        0x070
+#define SIO_DIV_REMAINDER       0x074
+#define SIO_DIV_CSR             0x078
+#define SIO_INTERP0_BASE        0x080
+#define SIO_INTERP1_BASE        0x0c0
+#define SIO_INTERP_BLOCK_SIZE   0x040
+#define SIO_INTERP_ACCUM0       0x00
+#define SIO_INTERP_ACCUM1       0x04
+#define SIO_INTERP_BASE0        0x08
+#define SIO_INTERP_BASE1        0x0c
+#define SIO_INTERP_BASE2        0x10
+#define SIO_INTERP_POP_LANE0    0x14
+#define SIO_INTERP_POP_LANE1    0x18
+#define SIO_INTERP_POP_FULL     0x1c
+#define SIO_INTERP_PEEK_LANE0   0x20
+#define SIO_INTERP_PEEK_LANE1   0x24
+#define SIO_INTERP_PEEK_FULL    0x28
+#define SIO_INTERP_CTRL_LANE0   0x2c
+#define SIO_INTERP_CTRL_LANE1   0x30
+#define SIO_INTERP_ACCUM0_ADD   0x34
+#define SIO_INTERP_ACCUM1_ADD   0x38
+#define SIO_INTERP_BASE_1AND0   0x3c
+#define SIO_SPINLOCK_BASE       0x100
+#define SIO_SPINLOCK_LAST       0x17c
+
+#define SIO_GPIO_MASK           0x3fffffff
+#define SIO_GPIO_HI_MASK        0x3f
+#define SIO_FIFO_ST_VLD         BIT(0)
+#define SIO_FIFO_ST_RDY         BIT(1)
+#define SIO_FIFO_ST_WC_MASK     (BIT(3) | BIT(2))
+#define SIO_DIV_CSR_READY       BIT(0)
+#define SIO_DIV_CSR_DIRTY       BIT(1)
+#define SIO_INTERP_CTRL_FORCE_MSB_SHIFT 19
+#define SIO_INTERP_CTRL_ADD_RAW         BIT(18)
+#define SIO_INTERP_CTRL_CROSS_RESULT    BIT(17)
+#define SIO_INTERP_CTRL_CROSS_INPUT     BIT(16)
+#define SIO_INTERP_CTRL_SIGNED          BIT(15)
+#define SIO_INTERP_CTRL_MASK_MSB_SHIFT  10
+#define SIO_INTERP_CTRL_MASK_LSB_SHIFT  5
+#define SIO_INTERP_CTRL_SHIFT_MASK      0x1f
+#define SIO_INTERP_CTRL_LSB_MASK        (0x1f << 5)
+#define SIO_INTERP_CTRL_MSB_MASK        (0x1f << 10)
+#define SIO_INTERP0_CTRL_BLEND          BIT(21)
+#define SIO_INTERP1_CTRL_CLAMP          BIT(22)
+#define SIO_INTERP_CTRL_OVERF           BIT(25)
+#define SIO_INTERP_CTRL_OVERF1          BIT(24)
+#define SIO_INTERP_CTRL_OVERF0          BIT(23)
+#define SIO_INTERP_CTRL_OVERF_MASK      (SIO_INTERP_CTRL_OVERF | \
+                                         SIO_INTERP_CTRL_OVERF1 | \
+                                         SIO_INTERP_CTRL_OVERF0)
+
+typedef struct RP2040SioInterpResult {
+    uint32_t raw[RP2040_SIO_INTERP_NUM_LANES];
+    uint32_t lane[RP2040_SIO_INTERP_NUM_LANES];
+    uint32_t full;
+} RP2040SioInterpResult;
+
+static unsigned rp2040_sio_current_core(void)
+{
+    /*
+     * current_cpu is QEMU's thread-local pointer to the currently executing
+     * guest vCPU, not a host CPU identifier.
+     */
+    if (current_cpu && current_cpu->cpu_index == 1) {
+        return 1;
+    }
+
+    return 0;
+}
+
+static void rp2040_sio_update_fifo_irq(RP2040SioState *s)
+{
+    int i;
+
+    for (i = 0; i < RP2040_SIO_NUM_CORES; i++) {
+        qemu_set_irq(s->fifo_irq[i], s->fifo_level[i] != 0);
+    }
+}
+
+static uint32_t rp2040_sio_fifo_status(RP2040SioState *s, unsigned core)
+{
+    unsigned peer = core ^ 1;
+    uint32_t value = s->fifo_sticky[core] & SIO_FIFO_ST_WC_MASK;
+
+    if (s->fifo_level[core] != 0) {
+        value |= SIO_FIFO_ST_VLD;
+    }
+    if (s->fifo_level[peer] < RP2040_SIO_FIFO_DEPTH) {
+        value |= SIO_FIFO_ST_RDY;
+    }
+
+    return value;
+}
+
+static void rp2040_sio_fifo_push(RP2040SioState *s, unsigned core,
+                                 uint32_t value)
+{
+    unsigned peer = core ^ 1;
+
+    if (s->fifo_level[peer] == RP2040_SIO_FIFO_DEPTH) {
+        s->fifo_sticky[core] |= BIT(2);
+        return;
+    }
+
+    s->fifo[peer][s->fifo_wptr[peer]] = value;
+    s->fifo_wptr[peer] = (s->fifo_wptr[peer] + 1) % RP2040_SIO_FIFO_DEPTH;
+    s->fifo_level[peer]++;
+    rp2040_sio_update_fifo_irq(s);
+}
+
+static uint32_t rp2040_sio_fifo_pop(RP2040SioState *s, unsigned core)
+{
+    uint32_t value;
+
+    if (s->fifo_level[core] == 0) {
+        s->fifo_sticky[core] |= BIT(3);
+        return 0;
+    }
+
+    value = s->fifo[core][s->fifo_rptr[core]];
+    s->fifo_rptr[core] = (s->fifo_rptr[core] + 1) % RP2040_SIO_FIFO_DEPTH;
+    s->fifo_level[core]--;
+    rp2040_sio_update_fifo_irq(s);
+
+    return value;
+}
+
+static bool rp2040_sio_spinlock_offset(hwaddr offset, unsigned *index)
+{
+    if (offset < SIO_SPINLOCK_BASE || offset > SIO_SPINLOCK_LAST ||
+        (offset & 0x3)) {
+        return false;
+    }
+
+    *index = (offset - SIO_SPINLOCK_BASE) / sizeof(uint32_t);
+    return *index < 32;
+}
+
+static int32_t rp2040_sio_sign32(uint32_t value)
+{
+    int32_t signed_value = (int32_t)value;
+
+    if (signed_value > 0) {
+        return 1;
+    }
+    if (signed_value < 0) {
+        return -1;
+    }
+    return 0;
+}
+
+static void rp2040_sio_divide(RP2040SioState *s, unsigned core,
+                              bool is_signed)
+{
+    uint32_t dividend = s->div_dividend[core];
+    uint32_t divisor = s->div_divisor[core];
+    uint32_t quotient;
+    uint32_t remainder;
+
+    if (is_signed) {
+        int32_t signed_dividend = (int32_t)dividend;
+        int32_t signed_divisor = (int32_t)divisor;
+
+        if (signed_divisor == 0) {
+            quotient = -rp2040_sio_sign32(dividend);
+            remainder = dividend;
+        } else if (signed_dividend == INT32_MIN && signed_divisor == -1) {
+            quotient = dividend;
+            remainder = 0;
+        } else {
+            quotient = signed_dividend / signed_divisor;
+            remainder = signed_dividend % signed_divisor;
+        }
+    } else if (divisor == 0) {
+        quotient = UINT32_MAX;
+        remainder = dividend;
+    } else {
+        quotient = dividend / divisor;
+        remainder = dividend % divisor;
+    }
+
+    s->div_quotient[core] = quotient;
+    s->div_remainder[core] = remainder;
+    s->div_dirty[core] = true;
+}
+
+static uint32_t rp2040_sio_div_csr(RP2040SioState *s, unsigned core)
+{
+    return SIO_DIV_CSR_READY |
+           (s->div_dirty[core] ? SIO_DIV_CSR_DIRTY : 0);
+}
+
+static unsigned rp2040_sio_interp_index(unsigned interp, unsigned lane)
+{
+    return interp * RP2040_SIO_INTERP_NUM_LANES + lane;
+}
+
+static unsigned rp2040_sio_interp_base_index(unsigned interp, unsigned base)
+{
+    return interp * RP2040_SIO_INTERP_NUM_BASES + base;
+}
+
+static uint32_t rp2040_sio_interp_ctrl_mask(unsigned interp, unsigned lane)
+{
+    uint32_t mask = SIO_INTERP_CTRL_SHIFT_MASK |
+                    SIO_INTERP_CTRL_LSB_MASK |
+                    SIO_INTERP_CTRL_MSB_MASK |
+                    SIO_INTERP_CTRL_SIGNED |
+                    SIO_INTERP_CTRL_CROSS_INPUT |
+                    SIO_INTERP_CTRL_CROSS_RESULT |
+                    SIO_INTERP_CTRL_ADD_RAW |
+                    (0x3 << SIO_INTERP_CTRL_FORCE_MSB_SHIFT);
+
+    if (interp == 0 && lane == 0) {
+        mask |= SIO_INTERP0_CTRL_BLEND;
+    } else if (interp == 1 && lane == 0) {
+        mask |= SIO_INTERP1_CTRL_CLAMP;
+    }
+
+    return mask;
+}
+
+static bool rp2040_sio_interp_offset(hwaddr addr, unsigned *interp,
+                                     hwaddr *reg)
+{
+    if (addr >= SIO_INTERP0_BASE &&
+        addr < SIO_INTERP0_BASE + SIO_INTERP_BLOCK_SIZE) {
+        *interp = 0;
+        *reg = addr - SIO_INTERP0_BASE;
+        return true;
+    }
+
+    if (addr >= SIO_INTERP1_BASE &&
+        addr < SIO_INTERP1_BASE + SIO_INTERP_BLOCK_SIZE) {
+        *interp = 1;
+        *reg = addr - SIO_INTERP1_BASE;
+        return true;
+    }
+
+    return false;
+}
+
+static uint32_t rp2040_sio_interp_mask(unsigned lsb, unsigned msb)
+{
+    if (msb < lsb) {
+        return 0;
+    }
+
+    if (msb == 31) {
+        return UINT32_MAX << lsb;
+    }
+
+    return (BIT(msb + 1) - 1) & ~(BIT(lsb) - 1);
+}
+
+static uint32_t rp2040_sio_interp_sign_extend(uint32_t value, unsigned msb)
+{
+    if (msb == 31 || !(value & BIT(msb))) {
+        return value;
+    }
+
+    return value | (UINT32_MAX << (msb + 1));
+}
+
+static uint32_t rp2040_sio_interp_raw(RP2040SioState *s, unsigned core,
+                                      unsigned interp, unsigned lane)
+{
+    uint32_t ctrl = s->interp_ctrl[core]
+                                  [rp2040_sio_interp_index(interp, lane)];
+    uint32_t input;
+    uint32_t shifted;
+    uint32_t value;
+    unsigned shift = ctrl & SIO_INTERP_CTRL_SHIFT_MASK;
+    unsigned lsb = (ctrl & SIO_INTERP_CTRL_LSB_MASK) >>
+                   SIO_INTERP_CTRL_MASK_LSB_SHIFT;
+    unsigned msb = (ctrl & SIO_INTERP_CTRL_MSB_MASK) >>
+                   SIO_INTERP_CTRL_MASK_MSB_SHIFT;
+
+    input = s->interp_accum[core][rp2040_sio_interp_index(
+                                  interp,
+                                  (ctrl & SIO_INTERP_CTRL_CROSS_INPUT) ?
+                                  (lane ^ 1) : lane)];
+    if (ctrl & SIO_INTERP_CTRL_ADD_RAW) {
+        return input;
+    }
+
+    shifted = input >> shift;
+    value = shifted & rp2040_sio_interp_mask(lsb, msb);
+    if (ctrl & SIO_INTERP_CTRL_SIGNED) {
+        value = rp2040_sio_interp_sign_extend(value, msb);
+    }
+
+    return value;
+}
+
+static uint32_t rp2040_sio_interp_force_msb(RP2040SioState *s, unsigned core,
+                                            unsigned interp, unsigned lane,
+                                            uint32_t value)
+{
+    uint32_t ctrl = s->interp_ctrl[core]
+                                  [rp2040_sio_interp_index(interp, lane)];
+    uint32_t force = (ctrl >> SIO_INTERP_CTRL_FORCE_MSB_SHIFT) & 0x3;
+
+    return value | (force << 28);
+}
+
+static uint32_t rp2040_sio_interp_blend_result(RP2040SioState *s,
+                                               unsigned core, uint32_t alpha)
+{
+    uint32_t ctrl1 = s->interp_ctrl[core][rp2040_sio_interp_index(0, 1)];
+    uint32_t base0 = s->interp_base[core][rp2040_sio_interp_base_index(0, 0)];
+    uint32_t base1 = s->interp_base[core][rp2040_sio_interp_base_index(0, 1)];
+    int64_t start;
+    int64_t end;
+
+    if (ctrl1 & SIO_INTERP_CTRL_SIGNED) {
+        start = (int16_t)base0;
+        end = (int16_t)base1;
+    } else {
+        start = (uint16_t)base0;
+        end = (uint16_t)base1;
+    }
+
+    return start + (((end - start) * (alpha & 0xff)) >> 8);
+}
+
+static void rp2040_sio_interp_compute(RP2040SioState *s, unsigned core,
+                                      unsigned interp,
+                                      RP2040SioInterpResult *result)
+{
+    bool blend = interp == 0 &&
+                 (s->interp_ctrl[core][rp2040_sio_interp_index(0, 0)] &
+                  SIO_INTERP0_CTRL_BLEND);
+    bool clamp = interp == 1 &&
+                 (s->interp_ctrl[core][rp2040_sio_interp_index(1, 0)] &
+                  SIO_INTERP1_CTRL_CLAMP);
+    uint32_t base0 = s->interp_base[core]
+                                   [rp2040_sio_interp_base_index(interp, 0)];
+    uint32_t base1 = s->interp_base[core]
+                                   [rp2040_sio_interp_base_index(interp, 1)];
+    uint32_t base2 = s->interp_base[core]
+                                   [rp2040_sio_interp_base_index(interp, 2)];
+
+    result->raw[0] = rp2040_sio_interp_raw(s, core, interp, 0);
+    result->raw[1] = rp2040_sio_interp_raw(s, core, interp, 1);
+    result->lane[0] = base0 + result->raw[0];
+    result->lane[1] = base1 + result->raw[1];
+    result->full = base2 + result->raw[0] + result->raw[1];
+
+    if (blend) {
+        uint32_t alpha = result->raw[1] & 0xff;
+
+        result->lane[0] = alpha;
+        result->lane[1] = rp2040_sio_interp_blend_result(s, core, alpha);
+        result->full = base2 + result->raw[0];
+    } else if (clamp) {
+        uint32_t ctrl0 = s->interp_ctrl[core][rp2040_sio_interp_index(1, 0)];
+
+        if (ctrl0 & SIO_INTERP_CTRL_SIGNED) {
+            int32_t value = result->raw[0];
+            int32_t lower = base0;
+            int32_t upper = base1;
+
+            result->lane[0] = value < lower ? lower :
+                              value > upper ? upper : value;
+        } else {
+            result->lane[0] = result->raw[0] < base0 ? base0 :
+                              result->raw[0] > base1 ? base1 :
+                              result->raw[0];
+        }
+    }
+}
+
+static uint32_t rp2040_sio_interp_pop(RP2040SioState *s, unsigned core,
+                                      unsigned interp, unsigned lane)
+{
+    RP2040SioInterpResult result;
+    uint32_t ctrl0 = s->interp_ctrl[core]
+                                   [rp2040_sio_interp_index(interp, 0)];
+    uint32_t ctrl1 = s->interp_ctrl[core]
+                                   [rp2040_sio_interp_index(interp, 1)];
+    uint32_t next0;
+    uint32_t next1;
+
+    rp2040_sio_interp_compute(s, core, interp, &result);
+    next0 = (ctrl0 & SIO_INTERP_CTRL_CROSS_RESULT) ?
+            result.lane[1] : result.lane[0];
+    next1 = (ctrl1 & SIO_INTERP_CTRL_CROSS_RESULT) ?
+            result.lane[0] : result.lane[1];
+
+    s->interp_accum[core][rp2040_sio_interp_index(interp, 0)] = next0;
+    s->interp_accum[core][rp2040_sio_interp_index(interp, 1)] = next1;
+
+    return lane < 2 ? rp2040_sio_interp_force_msb(s, core, interp, lane,
+                                                  result.lane[lane]) :
+                      result.full;
+}
+
+static uint32_t rp2040_sio_interp_overf(RP2040SioState *s, unsigned core,
+                                        unsigned interp, unsigned lane)
+{
+    uint32_t ctrl = s->interp_ctrl[core]
+                                  [rp2040_sio_interp_index(interp, lane)];
+    unsigned shift = ctrl & SIO_INTERP_CTRL_SHIFT_MASK;
+    unsigned lsb = (ctrl & SIO_INTERP_CTRL_LSB_MASK) >>
+                   SIO_INTERP_CTRL_MASK_LSB_SHIFT;
+    unsigned msb = (ctrl & SIO_INTERP_CTRL_MSB_MASK) >>
+                   SIO_INTERP_CTRL_MASK_MSB_SHIFT;
+    uint32_t input = s->interp_accum[core][rp2040_sio_interp_index(
+                                           interp,
+                                           (ctrl &
+                                            SIO_INTERP_CTRL_CROSS_INPUT) ?
+                                           (lane ^ 1) : lane)];
+    uint32_t shifted = input >> shift;
+
+    return (shifted & ~rp2040_sio_interp_mask(lsb, msb)) != 0;
+}
+
+static uint32_t rp2040_sio_interp_ctrl_read(RP2040SioState *s, unsigned core,
+                                            unsigned interp, unsigned lane)
+{
+    uint32_t ctrl = s->interp_ctrl[core]
+                                  [rp2040_sio_interp_index(interp, lane)];
+    bool overf0 = rp2040_sio_interp_overf(s, core, interp, 0);
+    bool overf1 = rp2040_sio_interp_overf(s, core, interp, 1);
+
+    ctrl &= ~SIO_INTERP_CTRL_OVERF_MASK;
+    if (overf0) {
+        ctrl |= SIO_INTERP_CTRL_OVERF0;
+    }
+    if (overf1) {
+        ctrl |= SIO_INTERP_CTRL_OVERF1;
+    }
+    if (overf0 || overf1) {
+        ctrl |= SIO_INTERP_CTRL_OVERF;
+    }
+
+    return ctrl;
+}
+
+static uint32_t rp2040_sio_interp_read(RP2040SioState *s, unsigned core,
+                                       unsigned interp, hwaddr reg)
+{
+    RP2040SioInterpResult result;
+
+    switch (reg) {
+    case SIO_INTERP_ACCUM0:
+    case SIO_INTERP_ACCUM1:
+        return s->interp_accum[core][rp2040_sio_interp_index(
+                                     interp, reg == SIO_INTERP_ACCUM1)];
+    case SIO_INTERP_BASE0:
+    case SIO_INTERP_BASE1:
+    case SIO_INTERP_BASE2:
+        return s->interp_base[core][rp2040_sio_interp_base_index(
+                                  interp, (reg - SIO_INTERP_BASE0) /
+                                          sizeof(uint32_t))];
+    case SIO_INTERP_POP_LANE0:
+        return rp2040_sio_interp_pop(s, core, interp, 0);
+    case SIO_INTERP_POP_LANE1:
+        return rp2040_sio_interp_pop(s, core, interp, 1);
+    case SIO_INTERP_POP_FULL:
+        return rp2040_sio_interp_pop(s, core, interp, 2);
+    case SIO_INTERP_PEEK_LANE0:
+    case SIO_INTERP_PEEK_LANE1:
+    case SIO_INTERP_PEEK_FULL:
+        rp2040_sio_interp_compute(s, core, interp, &result);
+        if (reg == SIO_INTERP_PEEK_LANE0) {
+            return rp2040_sio_interp_force_msb(s, core, interp, 0,
+                                               result.lane[0]);
+        }
+        if (reg == SIO_INTERP_PEEK_LANE1) {
+            return rp2040_sio_interp_force_msb(s, core, interp, 1,
+                                               result.lane[1]);
+        }
+        return result.full;
+    case SIO_INTERP_CTRL_LANE0:
+    case SIO_INTERP_CTRL_LANE1:
+        return rp2040_sio_interp_ctrl_read(s, core, interp,
+                                           reg == SIO_INTERP_CTRL_LANE1);
+    case SIO_INTERP_ACCUM0_ADD:
+    case SIO_INTERP_ACCUM1_ADD:
+        return rp2040_sio_interp_raw(s, core, interp,
+                                     reg == SIO_INTERP_ACCUM1_ADD);
+    case SIO_INTERP_BASE_1AND0:
+        return 0;
+    default:
+        return 0;
+    }
+}
+
+static void rp2040_sio_interp_write(RP2040SioState *s, unsigned core,
+                                    unsigned interp, hwaddr reg,
+                                    uint32_t value)
+{
+    unsigned lane;
+    unsigned base;
+    bool base01_signed;
+
+    switch (reg) {
+    case SIO_INTERP_ACCUM0:
+    case SIO_INTERP_ACCUM1:
+        lane = reg == SIO_INTERP_ACCUM1;
+        s->interp_accum[core][rp2040_sio_interp_index(interp, lane)] = value;
+        break;
+    case SIO_INTERP_BASE0:
+    case SIO_INTERP_BASE1:
+    case SIO_INTERP_BASE2:
+        base = (reg - SIO_INTERP_BASE0) / sizeof(uint32_t);
+        s->interp_base[core][rp2040_sio_interp_base_index(interp, base)] =
+            value;
+        break;
+    case SIO_INTERP_CTRL_LANE0:
+    case SIO_INTERP_CTRL_LANE1:
+        lane = reg == SIO_INTERP_CTRL_LANE1;
+        s->interp_ctrl[core][rp2040_sio_interp_index(interp, lane)] =
+            value & rp2040_sio_interp_ctrl_mask(interp, lane);
+        break;
+    case SIO_INTERP_ACCUM0_ADD:
+    case SIO_INTERP_ACCUM1_ADD:
+        lane = reg == SIO_INTERP_ACCUM1_ADD;
+        s->interp_accum[core][rp2040_sio_interp_index(interp, lane)] +=
+            value & 0x00ffffff;
+        break;
+    case SIO_INTERP_BASE_1AND0:
+        base01_signed = interp == 0 &&
+                        (s->interp_ctrl[core]
+                                       [rp2040_sio_interp_index(0, 0)] &
+                         SIO_INTERP0_CTRL_BLEND) ?
+                        (s->interp_ctrl[core]
+                                       [rp2040_sio_interp_index(0, 1)] &
+                         SIO_INTERP_CTRL_SIGNED) : false;
+
+        for (base = 0; base < 2; base++) {
+            uint16_t half = value >> (base * 16);
+            bool sign = base01_signed ||
+                        (s->interp_ctrl[core]
+                                       [rp2040_sio_interp_index(interp,
+                                                                base)] &
+                         SIO_INTERP_CTRL_SIGNED);
+
+            s->interp_base[core][rp2040_sio_interp_base_index(interp, base)] =
+                sign ? (uint32_t)(int16_t)half : half;
+        }
+        break;
+    default:
+        break;
+    }
+}
+
+static uint64_t rp2040_sio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040SioState *s = opaque;
+    unsigned core = rp2040_sio_current_core();
+    unsigned interp;
+    unsigned index;
+    unsigned shift = (addr & 3) * 8;
+    hwaddr interp_reg;
+    hwaddr reg = addr & ~3ULL;
+    uint64_t value;
+
+    if (rp2040_sio_interp_offset(reg, &interp, &interp_reg)) {
+        value = rp2040_sio_interp_read(s, core, interp, interp_reg);
+        return extract64(value, shift, size * 8);
+    }
+
+    switch (reg) {
+    case SIO_CPUID:
+        value = core;
+        break;
+    case SIO_GPIO_IN:
+        value = s->gpio_in;
+        break;
+    case SIO_GPIO_HI_IN:
+        value = s->gpio_hi_in;
+        break;
+    case SIO_GPIO_OUT:
+        value = s->gpio_out;
+        break;
+    case SIO_GPIO_OE:
+        value = s->gpio_oe;
+        break;
+    case SIO_GPIO_HI_OUT:
+        value = s->gpio_hi_out;
+        break;
+    case SIO_GPIO_HI_OE:
+        value = s->gpio_hi_oe;
+        break;
+    case SIO_FIFO_ST:
+        value = rp2040_sio_fifo_status(s, core);
+        break;
+    case SIO_FIFO_RD:
+        value = rp2040_sio_fifo_pop(s, core);
+        break;
+    case SIO_SPINLOCK_ST:
+        value = s->spinlock_st;
+        break;
+    case SIO_DIV_UDIVIDEND:
+    case SIO_DIV_SDIVIDEND:
+        value = s->div_dividend[core];
+        break;
+    case SIO_DIV_UDIVISOR:
+    case SIO_DIV_SDIVISOR:
+        value = s->div_divisor[core];
+        break;
+    case SIO_DIV_QUOTIENT:
+        value = s->div_quotient[core];
+        s->div_dirty[core] = false;
+        break;
+    case SIO_DIV_REMAINDER:
+        value = s->div_remainder[core];
+        break;
+    case SIO_DIV_CSR:
+        value = rp2040_sio_div_csr(s, core);
+        break;
+    default:
+        if (rp2040_sio_spinlock_offset(reg, &index)) {
+            value = (s->spinlock_st & BIT(index)) ? 0 : BIT(index);
+            s->spinlock_st |= BIT(index);
+        } else {
+            value = 0;
+            rp2040_log_unimplemented_read("sio", size,
+                                          RP2040_SIO_BASE + addr, addr,
+                                          value);
+        }
+        break;
+    }
+
+    return extract64(value, shift, size * 8);
+}
+
+static void rp2040_sio_write(void *opaque, hwaddr addr,
+                             uint64_t value64, unsigned size)
+{
+    RP2040SioState *s = opaque;
+    unsigned core = rp2040_sio_current_core();
+    unsigned interp;
+    unsigned index;
+    unsigned shift = (addr & 3) * 8;
+    hwaddr interp_reg;
+    hwaddr reg = addr & ~3ULL;
+    uint32_t value = (uint32_t)value64 << shift;
+
+    if (rp2040_sio_interp_offset(reg, &interp, &interp_reg)) {
+        rp2040_sio_interp_write(s, core, interp, interp_reg, value);
+        return;
+    }
+
+    switch (reg) {
+    case SIO_GPIO_OUT:
+        s->gpio_out = value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_OUT_SET:
+        s->gpio_out |= value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_OUT_CLR:
+        s->gpio_out &= ~(value & SIO_GPIO_MASK);
+        break;
+    case SIO_GPIO_OUT_XOR:
+        s->gpio_out ^= value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_OE:
+        s->gpio_oe = value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_OE_SET:
+        s->gpio_oe |= value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_OE_CLR:
+        s->gpio_oe &= ~(value & SIO_GPIO_MASK);
+        break;
+    case SIO_GPIO_OE_XOR:
+        s->gpio_oe ^= value & SIO_GPIO_MASK;
+        break;
+    case SIO_GPIO_HI_OUT:
+        s->gpio_hi_out = value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_GPIO_HI_OUT_SET:
+        s->gpio_hi_out |= value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_GPIO_HI_OUT_CLR:
+        s->gpio_hi_out &= ~(value & SIO_GPIO_HI_MASK);
+        break;
+    case SIO_GPIO_HI_OUT_XOR:
+        s->gpio_hi_out ^= value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_GPIO_HI_OE:
+        s->gpio_hi_oe = value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_GPIO_HI_OE_SET:
+        s->gpio_hi_oe |= value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_GPIO_HI_OE_CLR:
+        s->gpio_hi_oe &= ~(value & SIO_GPIO_HI_MASK);
+        break;
+    case SIO_GPIO_HI_OE_XOR:
+        s->gpio_hi_oe ^= value & SIO_GPIO_HI_MASK;
+        break;
+    case SIO_FIFO_ST:
+        s->fifo_sticky[core] &= ~(value & SIO_FIFO_ST_WC_MASK);
+        break;
+    case SIO_FIFO_WR:
+        rp2040_sio_fifo_push(s, core, value);
+        break;
+    case SIO_DIV_UDIVIDEND:
+        s->div_dividend[core] = value;
+        rp2040_sio_divide(s, core, false);
+        break;
+    case SIO_DIV_UDIVISOR:
+        s->div_divisor[core] = value;
+        rp2040_sio_divide(s, core, false);
+        break;
+    case SIO_DIV_SDIVIDEND:
+        s->div_dividend[core] = value;
+        rp2040_sio_divide(s, core, true);
+        break;
+    case SIO_DIV_SDIVISOR:
+        s->div_divisor[core] = value;
+        rp2040_sio_divide(s, core, true);
+        break;
+    case SIO_DIV_QUOTIENT:
+        s->div_quotient[core] = value;
+        s->div_dirty[core] = true;
+        break;
+    case SIO_DIV_REMAINDER:
+        s->div_remainder[core] = value;
+        s->div_dirty[core] = true;
+        break;
+    default:
+        if (rp2040_sio_spinlock_offset(reg, &index)) {
+            s->spinlock_st &= ~BIT(index);
+        } else {
+            rp2040_log_unimplemented_write("sio", size,
+                                           RP2040_SIO_BASE + addr, addr,
+                                           value64);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_sio_ops = {
+    .read = rp2040_sio_read,
+    .write = rp2040_sio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void rp2040_sio_reset(DeviceState *dev)
+{
+    RP2040SioState *s = RP2040_SIO(dev);
+
+    s->gpio_in &= SIO_GPIO_MASK;
+    s->gpio_hi_in &= SIO_GPIO_HI_MASK;
+    s->gpio_out = 0;
+    s->gpio_oe = 0;
+    s->gpio_hi_out = 0;
+    s->gpio_hi_oe = 0;
+    memset(s->fifo, 0, sizeof(s->fifo));
+    memset(s->fifo_rptr, 0, sizeof(s->fifo_rptr));
+    memset(s->fifo_wptr, 0, sizeof(s->fifo_wptr));
+    memset(s->fifo_level, 0, sizeof(s->fifo_level));
+    memset(s->fifo_sticky, 0, sizeof(s->fifo_sticky));
+    memset(s->div_dividend, 0, sizeof(s->div_dividend));
+    memset(s->div_divisor, 0, sizeof(s->div_divisor));
+    memset(s->div_quotient, 0, sizeof(s->div_quotient));
+    memset(s->div_remainder, 0, sizeof(s->div_remainder));
+    memset(s->div_dirty, 0, sizeof(s->div_dirty));
+    memset(s->interp_accum, 0, sizeof(s->interp_accum));
+    memset(s->interp_base, 0, sizeof(s->interp_base));
+    memset(s->interp_ctrl, 0, sizeof(s->interp_ctrl));
+    s->spinlock_st = 0;
+    rp2040_sio_update_fifo_irq(s);
+}
+
+static void rp2040_sio_init(Object *obj)
+{
+    RP2040SioState *s = RP2040_SIO(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_sio_ops, s,
+                          TYPE_RP2040_SIO, 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->fifo_irq[0]);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->fifo_irq[1]);
+}
+
+static const VMStateDescription vmstate_rp2040_sio = {
+    .name = TYPE_RP2040_SIO,
+    .version_id = 3,
+    .minimum_version_id = 2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(gpio_out, RP2040SioState),
+        VMSTATE_UINT32(gpio_in, RP2040SioState),
+        VMSTATE_UINT32(gpio_hi_in, RP2040SioState),
+        VMSTATE_UINT32(gpio_oe, RP2040SioState),
+        VMSTATE_UINT32(gpio_hi_out, RP2040SioState),
+        VMSTATE_UINT32(gpio_hi_oe, RP2040SioState),
+        VMSTATE_UINT32_2DARRAY(fifo, RP2040SioState, RP2040_SIO_NUM_CORES,
+                               RP2040_SIO_FIFO_DEPTH),
+        VMSTATE_UINT8_ARRAY(fifo_rptr, RP2040SioState,
+                            RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT8_ARRAY(fifo_wptr, RP2040SioState,
+                            RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT8_ARRAY(fifo_level, RP2040SioState,
+                            RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_ARRAY(fifo_sticky, RP2040SioState,
+                             RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_ARRAY(div_dividend, RP2040SioState,
+                             RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_ARRAY(div_divisor, RP2040SioState,
+                             RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_ARRAY(div_quotient, RP2040SioState,
+                             RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_ARRAY(div_remainder, RP2040SioState,
+                             RP2040_SIO_NUM_CORES),
+        VMSTATE_BOOL_ARRAY(div_dirty, RP2040SioState,
+                           RP2040_SIO_NUM_CORES),
+        VMSTATE_UINT32_2DARRAY_V(interp_accum, RP2040SioState,
+                                 RP2040_SIO_NUM_CORES,
+                                 RP2040_SIO_NUM_INTERPS *
+                                 RP2040_SIO_INTERP_NUM_LANES, 3),
+        VMSTATE_UINT32_2DARRAY_V(interp_base, RP2040SioState,
+                                 RP2040_SIO_NUM_CORES,
+                                 RP2040_SIO_NUM_INTERPS *
+                                 RP2040_SIO_INTERP_NUM_BASES, 3),
+        VMSTATE_UINT32_2DARRAY_V(interp_ctrl, RP2040SioState,
+                                 RP2040_SIO_NUM_CORES,
+                                 RP2040_SIO_NUM_INTERPS *
+                                 RP2040_SIO_INTERP_NUM_LANES, 3),
+        VMSTATE_UINT32(spinlock_st, RP2040SioState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property rp2040_sio_properties[] = {
+    DEFINE_PROP_UINT32("gpio-in", RP2040SioState, gpio_in, 0),
+    DEFINE_PROP_UINT32("gpio-hi-in", RP2040SioState, gpio_hi_in, 0),
+};
+
+static void rp2040_sio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_sio_reset);
+    device_class_set_props(dc, rp2040_sio_properties);
+    dc->vmsd = &vmstate_rp2040_sio;
+}
+
+static const TypeInfo rp2040_sio_info = {
+    .name = TYPE_RP2040_SIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040SioState),
+    .instance_init = rp2040_sio_init,
+    .class_init = rp2040_sio_class_init,
+};
+
+static void rp2040_sio_register_types(void)
+{
+    type_register_static(&rp2040_sio_info);
+}
+type_init(rp2040_sio_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index aa4b6f4736..5c0047c0f7 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -21,6 +21,7 @@
 #include "hw/misc/rp2040_psm.h"
 #include "hw/misc/rp2040_resets.h"
 #include "hw/misc/rp2040_rosc.h"
+#include "hw/misc/rp2040_sio.h"
 #include "hw/misc/rp2040_syscfg.h"
 #include "hw/misc/rp2040_sysinfo.h"
 #include "hw/misc/rp2040_tbman.h"
@@ -41,12 +42,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(RP2040State, RP2040)
 #define RP2040_SRAM5_BASE     0x20041000
 #define RP2040_SRAM_HI_SIZE   (4 * KiB)
 
+#define RP2040_NUM_CORES      2
 #define RP2040_NUM_IRQS       32
 
 struct RP2040State {
     SysBusDevice parent_obj;
 
-    ARMv7MState armv7m;
+    ARMv7MState armv7m[RP2040_NUM_CORES];
     PL011State uart[2];
     RP2040ClocksState clocks;
     RP2040IoBank0State iobank0;
@@ -60,12 +62,14 @@ struct RP2040State {
     RP2040SysCfgState syscfg;
     RP2040SysInfoState sysinfo;
     RP2040RoscState rosc;
+    RP2040SioState sio;
     RP2040TbmanState tbman;
     RP2040VregState vreg;
     RP2040WatchdogState watchdog;
     RP2040XoscState xosc;
 
     MemoryRegion *board_memory;
+    MemoryRegion cpu_memory[RP2040_NUM_CORES];
     MemoryRegion rom;
     MemoryRegion rom_poweroff;
     MemoryRegion sram[6];
@@ -73,9 +77,9 @@ struct RP2040State {
     char *bootrom_file;
 
     qemu_irq *irq;
-    qemu_irq cpu_irq[RP2040_NUM_IRQS];
-    qemu_irq nmi_irq;
-    bool irq_level[RP2040_NUM_IRQS];
+    qemu_irq cpu_irq[RP2040_NUM_CORES][RP2040_NUM_IRQS];
+    qemu_irq nmi_irq[RP2040_NUM_CORES];
+    bool irq_level[RP2040_NUM_CORES][RP2040_NUM_IRQS];
     bool mempowerdown_ready;
     bool strict_uart_pins;
     bool uart0_tx_pin_enabled;
diff --git a/include/hw/misc/rp2040_sio.h b/include/hw/misc/rp2040_sio.h
new file mode 100644
index 0000000000..e2a79a8a34
--- /dev/null
+++ b/include/hw/misc/rp2040_sio.h
@@ -0,0 +1,57 @@
+/*
+ * RP2040 single-cycle IO block emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_SIO_H
+#define HW_MISC_RP2040_SIO_H
+
+#include "hw/core/irq.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_SIO "rp2040-sio"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040SioState, RP2040_SIO)
+
+#define RP2040_SIO_BASE 0xd0000000
+#define RP2040_SIO_NUM_CORES 2
+#define RP2040_SIO_FIFO_DEPTH 8
+#define RP2040_SIO_NUM_INTERPS 2
+#define RP2040_SIO_INTERP_NUM_LANES 2
+#define RP2040_SIO_INTERP_NUM_BASES 3
+
+struct RP2040SioState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq fifo_irq[RP2040_SIO_NUM_CORES];
+    uint32_t gpio_in;
+    uint32_t gpio_hi_in;
+    uint32_t gpio_out;
+    uint32_t gpio_oe;
+    uint32_t gpio_hi_out;
+    uint32_t gpio_hi_oe;
+    uint32_t fifo[RP2040_SIO_NUM_CORES][RP2040_SIO_FIFO_DEPTH];
+    uint8_t fifo_rptr[RP2040_SIO_NUM_CORES];
+    uint8_t fifo_wptr[RP2040_SIO_NUM_CORES];
+    uint8_t fifo_level[RP2040_SIO_NUM_CORES];
+    uint32_t fifo_sticky[RP2040_SIO_NUM_CORES];
+    uint32_t div_dividend[RP2040_SIO_NUM_CORES];
+    uint32_t div_divisor[RP2040_SIO_NUM_CORES];
+    uint32_t div_quotient[RP2040_SIO_NUM_CORES];
+    uint32_t div_remainder[RP2040_SIO_NUM_CORES];
+    bool div_dirty[RP2040_SIO_NUM_CORES];
+    uint32_t interp_accum[RP2040_SIO_NUM_CORES]
+                          [RP2040_SIO_NUM_INTERPS *
+                           RP2040_SIO_INTERP_NUM_LANES];
+    uint32_t interp_base[RP2040_SIO_NUM_CORES]
+                         [RP2040_SIO_NUM_INTERPS *
+                          RP2040_SIO_INTERP_NUM_BASES];
+    uint32_t interp_ctrl[RP2040_SIO_NUM_CORES]
+                         [RP2040_SIO_NUM_INTERPS *
+                          RP2040_SIO_INTERP_NUM_LANES];
+    uint32_t spinlock_st;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b093f5da8a..3054809620 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -260,8 +260,10 @@ qtests_arm = \
                                                        'rp2040-iobank0-test',
                                                        'rp2040-ioqspi-test',
                                                        'rp2040-pads-test',
+                                                       'rp2040-psm-test',
                                                        'rp2040-resets-test',
                                                        'rp2040-rosc-test',
+                                                       'rp2040-sio-test',
                                                        'rp2040-tbman-test',
                                                        'rp2040-uart-test',
                                                        'rp2040-vreg-test',
diff --git a/tests/qtest/rp2040-psm-test.c b/tests/qtest/rp2040-psm-test.c
new file mode 100644
index 0000000000..aa04880a89
--- /dev/null
+++ b/tests/qtest/rp2040-psm-test.c
@@ -0,0 +1,81 @@
+/*
+ * QTest testcase for the RP2040 power-on state machine.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define PSM_BASE       0x40010000
+#define PSM_FRCE_ON    0x00
+#define PSM_FRCE_OFF   0x04
+#define PSM_WDSEL      0x08
+#define PSM_DONE       0x0c
+#define PSM_VALID_MASK 0x0001ffff
+#define PSM_PROC1      BIT(16)
+
+#define ATOMIC_SET     0x2000
+#define ATOMIC_CLR     0x3000
+
+static QTestState *rp2040_psm_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_reset_values(void)
+{
+    QTestState *qts = rp2040_psm_start();
+
+    g_assert_cmphex(qtest_readl(qts, PSM_BASE + PSM_FRCE_ON), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, PSM_BASE + PSM_FRCE_OFF), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, PSM_BASE + PSM_WDSEL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, PSM_BASE + PSM_DONE), ==,
+                    PSM_VALID_MASK);
+
+    qtest_quit(qts);
+}
+
+static void test_proc1_force_off(void)
+{
+    QTestState *qts = rp2040_psm_start();
+
+    qtest_writel(qts, PSM_BASE + ATOMIC_SET + PSM_FRCE_OFF, PSM_PROC1);
+    g_assert_cmphex(qtest_readl(qts, PSM_BASE + PSM_FRCE_OFF), ==,
+                    PSM_PROC1);
+    g_assert_cmphex(qtest_readl(qts, PSM_BASE + PSM_DONE) & PSM_PROC1, ==,
+                    0);
+
+    qtest_writel(qts, PSM_BASE + ATOMIC_CLR + PSM_FRCE_OFF, PSM_PROC1);
+    g_assert_cmphex(qtest_readl(qts, PSM_BASE + PSM_FRCE_OFF), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, PSM_BASE + PSM_DONE) & PSM_PROC1, ==,
+                    PSM_PROC1);
+
+    qtest_quit(qts);
+}
+
+static void test_register_masks(void)
+{
+    QTestState *qts = rp2040_psm_start();
+
+    qtest_writel(qts, PSM_BASE + PSM_FRCE_ON, UINT32_MAX);
+    qtest_writel(qts, PSM_BASE + PSM_WDSEL, UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts, PSM_BASE + PSM_FRCE_ON), ==,
+                    PSM_VALID_MASK);
+    g_assert_cmphex(qtest_readl(qts, PSM_BASE + PSM_WDSEL), ==,
+                    PSM_VALID_MASK);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-psm/reset-values", test_reset_values);
+    qtest_add_func("/rp2040-psm/proc1-force-off", test_proc1_force_off);
+    qtest_add_func("/rp2040-psm/register-masks", test_register_masks);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/rp2040-sio-test.c b/tests/qtest/rp2040-sio-test.c
new file mode 100644
index 0000000000..13ee513ebe
--- /dev/null
+++ b/tests/qtest/rp2040-sio-test.c
@@ -0,0 +1,270 @@
+/*
+ * QTest testcase for the RP2040 SIO block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define SIO_BASE                0xd0000000
+#define SIO_CPUID               0x000
+#define SIO_GPIO_IN             0x004
+#define SIO_GPIO_HI_IN          0x008
+#define SIO_GPIO_OUT            0x010
+#define SIO_GPIO_OUT_SET        0x014
+#define SIO_GPIO_OUT_CLR        0x018
+#define SIO_GPIO_OUT_XOR        0x01c
+#define SIO_GPIO_HI_OUT         0x030
+#define SIO_GPIO_HI_OUT_SET     0x034
+#define SIO_GPIO_HI_OUT_CLR     0x038
+#define SIO_GPIO_HI_OUT_XOR     0x03c
+#define SIO_FIFO_ST             0x050
+#define SIO_FIFO_RD             0x058
+#define SIO_SPINLOCK_ST         0x05c
+#define SIO_SPINLOCK0           0x100
+#define SIO_DIV_UDIVIDEND       0x060
+#define SIO_DIV_UDIVISOR        0x064
+#define SIO_DIV_SDIVIDEND       0x068
+#define SIO_DIV_SDIVISOR        0x06c
+#define SIO_DIV_QUOTIENT        0x070
+#define SIO_DIV_REMAINDER       0x074
+#define SIO_DIV_CSR             0x078
+#define SIO_INTERP0_ACCUM0      0x080
+#define SIO_INTERP0_ACCUM1      0x084
+#define SIO_INTERP0_BASE0       0x088
+#define SIO_INTERP0_BASE1       0x08c
+#define SIO_INTERP0_POP_LANE1   0x098
+#define SIO_INTERP0_PEEK_LANE0  0x0a0
+#define SIO_INTERP0_PEEK_LANE1  0x0a4
+#define SIO_INTERP0_CTRL_LANE0  0x0ac
+#define SIO_INTERP0_CTRL_LANE1  0x0b0
+#define SIO_INTERP0_ACCUM0_ADD  0x0b4
+#define SIO_INTERP0_BASE_1AND0  0x0bc
+#define SIO_INTERP1_ACCUM0      0x0c0
+#define SIO_INTERP1_BASE0       0x0c8
+#define SIO_INTERP1_BASE1       0x0cc
+#define SIO_INTERP1_PEEK_LANE0  0x0e0
+#define SIO_INTERP1_CTRL_LANE0  0x0ec
+
+#define INTERP_CTRL_SHIFT(n)    (n)
+#define INTERP_CTRL_MASK(lsb, msb) (((lsb) << 5) | ((msb) << 10))
+#define INTERP_CTRL_SIGNED      BIT(15)
+#define INTERP_CTRL_CROSS_RESULT BIT(17)
+#define INTERP0_CTRL_BLEND      BIT(21)
+#define INTERP1_CTRL_CLAMP      BIT(22)
+
+#define DIV_CSR_READY           BIT(0)
+#define DIV_CSR_DIRTY           BIT(1)
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_sio_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_CPUID), ==, 0);
+    g_assert_cmphex(qtest_readb(qts, SIO_BASE + SIO_CPUID), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_IN), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_HI_IN), ==, BIT(1));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_OUT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_HI_OUT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_FIFO_ST), ==, BIT(1));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_SPINLOCK_ST), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_sio_gpio_alias_registers(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_OUT, BIT(3));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_OUT_SET, BIT(5));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_OUT_CLR, BIT(3));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_OUT_XOR, BIT(7));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_OUT), ==,
+                    BIT(5) | BIT(7));
+
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_HI_OUT, BIT(0));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_HI_OUT_SET, BIT(2));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_HI_OUT_CLR, BIT(0));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_HI_OUT_XOR, BIT(5));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_HI_OUT), ==,
+                    BIT(2) | BIT(5));
+
+    qtest_quit(qts);
+}
+
+static void test_sio_fifo_empty_read_sets_roe(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_readl(qts, SIO_BASE + SIO_FIFO_RD);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_FIFO_ST), ==,
+                    BIT(3) | BIT(1));
+
+    qtest_writel(qts, SIO_BASE + SIO_FIFO_ST, BIT(3));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_FIFO_ST), ==, BIT(1));
+
+    qtest_quit(qts);
+}
+
+static void test_sio_spinlock_claim_release(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_SPINLOCK0), ==, BIT(0));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_SPINLOCK0), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_SPINLOCK_ST), ==, BIT(0));
+
+    qtest_writel(qts, SIO_BASE + SIO_SPINLOCK0, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_SPINLOCK_ST), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_sio_divider(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SIO_BASE + SIO_DIV_UDIVIDEND, 100);
+    qtest_writel(qts, SIO_BASE + SIO_DIV_UDIVISOR, 7);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_DIV_CSR), ==,
+                    DIV_CSR_READY | DIV_CSR_DIRTY);
+    g_assert_cmpuint(qtest_readl(qts, SIO_BASE + SIO_DIV_REMAINDER), ==, 2);
+    g_assert_cmpuint(qtest_readl(qts, SIO_BASE + SIO_DIV_QUOTIENT), ==, 14);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_DIV_CSR), ==,
+                    DIV_CSR_READY);
+
+    qtest_writel(qts, SIO_BASE + SIO_DIV_SDIVIDEND, -100);
+    qtest_writel(qts, SIO_BASE + SIO_DIV_SDIVISOR, 7);
+    g_assert_cmpint((int32_t)qtest_readl(qts,
+                                        SIO_BASE + SIO_DIV_QUOTIENT),
+                    ==, -14);
+    g_assert_cmpint((int32_t)qtest_readl(qts,
+                                        SIO_BASE + SIO_DIV_REMAINDER),
+                    ==, -2);
+
+    qtest_quit(qts);
+}
+
+static void test_sio_interp_mask_and_sign(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_ACCUM0, 0x1234abcd);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE0,
+                 INTERP_CTRL_MASK(4, 7));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_ACCUM0_ADD),
+                    ==, 0x000000c0);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE0,
+                 INTERP_CTRL_MASK(4, 7) | INTERP_CTRL_SIGNED);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_ACCUM0_ADD),
+                    ==, 0xffffffc0);
+
+    qtest_quit(qts);
+}
+
+static void test_sio_interp_pop_cross_result(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t full_mask = INTERP_CTRL_MASK(0, 31);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_ACCUM0, 123);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_ACCUM1, 456);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_BASE0, 1);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_BASE1, 0);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE0,
+                 full_mask | INTERP_CTRL_CROSS_RESULT);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE1,
+                 full_mask | INTERP_CTRL_CROSS_RESULT);
+
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_PEEK_LANE0),
+                    ==, 124);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_POP_LANE1),
+                    ==, 456);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_PEEK_LANE0),
+                    ==, 457);
+
+    qtest_quit(qts);
+}
+
+static void test_sio_interp_blend(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t full_mask = INTERP_CTRL_MASK(0, 31);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE0,
+                 full_mask | INTERP0_CTRL_BLEND);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE1, full_mask);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_ACCUM1, 128);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_BASE_1AND0, 0x30005000);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_PEEK_LANE1),
+                    ==, 0x00004000);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_BASE_1AND0, 0xe000f000);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_PEEK_LANE1),
+                    ==, 0x0000e800);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE1,
+                 full_mask | INTERP_CTRL_SIGNED);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_BASE_1AND0, 0xe000f000);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_PEEK_LANE1),
+                    ==, 0xffffe800);
+
+    qtest_quit(qts);
+}
+
+static void test_sio_interp_clamp(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_CTRL_LANE0,
+                 INTERP1_CTRL_CLAMP | INTERP_CTRL_SIGNED |
+                 INTERP_CTRL_SHIFT(2) | INTERP_CTRL_MASK(0, 29));
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_BASE0, 0);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_BASE1, 255);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_ACCUM0, -1024);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP1_PEEK_LANE0),
+                    ==, 0);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_ACCUM0, 512);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP1_PEEK_LANE0),
+                    ==, 128);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_ACCUM0, 1024);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP1_PEEK_LANE0),
+                    ==, 255);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-sio/reset-values", test_sio_reset_values);
+    qtest_add_func("/rp2040-sio/gpio-alias-registers",
+                   test_sio_gpio_alias_registers);
+    qtest_add_func("/rp2040-sio/fifo-empty-read-sets-roe",
+                   test_sio_fifo_empty_read_sets_roe);
+    qtest_add_func("/rp2040-sio/spinlock-claim-release",
+                   test_sio_spinlock_claim_release);
+    qtest_add_func("/rp2040-sio/divider", test_sio_divider);
+    qtest_add_func("/rp2040-sio/interp-mask-and-sign",
+                   test_sio_interp_mask_and_sign);
+    qtest_add_func("/rp2040-sio/interp-pop-cross-result",
+                   test_sio_interp_pop_cross_result);
+    qtest_add_func("/rp2040-sio/interp-blend", test_sio_interp_blend);
+    qtest_add_func("/rp2040-sio/interp-clamp", test_sio_interp_clamp);
+
+    return g_test_run();
+}
-- 
2.55.0


