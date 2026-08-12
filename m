Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6F2C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7t5-0004UR-4O; Wed, 12 Aug 2026 08:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t0-0004Dj-N6
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sy-0008Vd-3V
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so10116455e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537002; x=1787141802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nCz1KUICojyw1swWpGy2FXgpXvTeFdwZsUVFSci4gcA=;
 b=P4MMRdAj109rZ57+PR6isXndrwlR/ESbvrHLzhU7i9D3hnTKdPxSWbBeJBQvQNPR4G
 N3MS2CbEksxzGS1e6FFtdkX4Z3hm9Q/qhyO0HrNaXwmcoXPZLOSQPNwBfD1puGDeuwjo
 r0mAagrND4GiuFk8rF2FXTlLvngXiA4mMc6pyftzaTC48iteBCbMIfm19BDwSQRpIzhC
 PjATEaECIXdfi/ULML6rFsZmNbSgqZXqZPwfofVzFGC2Kkn6l/fMD4ZIUCB95c02/tqc
 czvRMqEmoJv/oO0Fls2UWjIcggXnA8LsSJ8USR4a1m6dYSrFtbJ67JYiJTYRnaJX0Yo+
 fGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537002; x=1787141802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nCz1KUICojyw1swWpGy2FXgpXvTeFdwZsUVFSci4gcA=;
 b=AV+fuv5yN9tjWgCFHVAs/nLR4zs0tKXm5whHy8Jeu9aAuSNtUeNJzgpPj7OzvVzyUD
 qii48N6j0jaPCAe9AOPn8q73Kp5Pt3OOqsbBrypj8ylF/9JCDQgQo003mlbvHeb57EZZ
 Cqb+XW7WewOKXMZvd/jQ0c62kGcsmqvQCQgifPvl1iikKnWCX92wwHPbTwiXa/U2bkBA
 0ycwNExZE3fImrcTGvhvjOVxOfD2HhQgWRWFElHqYh/pu6DzwZhvXVEaViXDq9OKGgWL
 F8JfrCHzgoBrdp2gO4ROzyDXZU6PiqrUelW7TNmbiqAS4ebqMdNUgwQdJF0vWz4bW1Kc
 sffA==
X-Gm-Message-State: AOJu0YzPE20Rxiq4iUc8RhMsBI0yW0wKYPnUXTlMMj9GaFfjCsZmBJXJ
 5BFIV52zUmr+h53Ioyz3VckKwQVLHGA2DjDY0zfD+u+RKplcFqB8QyCnbBsoZfoo3172SmFTfod
 Jkv4T
X-Gm-Gg: AR+sD13y2vCEhnXwpdxVw6Wg2udBb47qod0VejaTU6ua8rfvZ/VPtJ7IEKerirRMsIJ
 Qdb0m0AwFCzmQRhq892WebpLIgPjSkG4Cttn063S85kctZQFmrgLb0Ro5zdXm8nYrosoqFGUWtF
 wmnSfbVaEYsibkMkRnnnCQO2bzRH4rNtDnF/elaIYnwhSTQyydnnbyXhvoDxO0Zo0Jv/0BTZY++
 lgj8Jkw2DTpN3O8j1eRbEtueSxZtDUzDyFqGLCqmwwY9+WwynImPgAM8TP6kDMHoD/IOlYEsiHn
 9s/EpZZ0dpyG14qNxcVSdlWEs0vdku+lvI4MqB4P+4XO5C8OArz+WirP6dcl8tDY8SKLLyBSEWu
 6wVHbtlujpEDrWK4RK1Hiq1esj7W1gNMV7frgg6UyLJ2wmXdOka3JXj4u/UQaxY1ImcXojqkt3p
 BZD+MNozvyXAVrS0tGZ/RN5oHPN+gm+XdVOm4Lu69LBEmLBQU9tdZN2FYHUyYeKPUyutYAlcFEc
 qHr8q7cXUZSfc0bZ1s8SevMzgczX/LyAZ//vSPpIB8Z2SiY7mmMQ2X/rTi4jYplkCpZkCAY1618
 9C9w
X-Received: by 2002:a05:600c:4f87:b0:499:48be:3189 with SMTP id
 5b1f17b1804b1-4997bf81217mr49838035e9.0.1786537002515; 
 Wed, 12 Aug 2026 05:16:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/26] hw/arm: Add Axiado SoC AX3000
Date: Wed, 12 Aug 2026 13:16:07 +0100
Message-ID: <20260812121622.649730-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Kuan-Jui Chiu <kchiu@axiado.com>

This patch adds new model for Axiado SoC AX3000 which supports
    4 Cortex-A53 ARM64 CPUs
    Arm Generic Interrupt Controller v3
    4 Cadence UARTs

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Message-id: 20260713073033.3883619-2-kchiu@axiado.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: Kconfig for the SoC shouldn't depend on ARM]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                 |   7 ++
 hw/arm/Kconfig              |   6 ++
 hw/arm/ax3000-soc.c         | 182 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   3 +
 include/hw/arm/ax3000-soc.h |  68 ++++++++++++++
 5 files changed, 266 insertions(+)
 create mode 100644 hw/arm/ax3000-soc.c
 create mode 100644 include/hw/arm/ax3000-soc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4628793dde..fce65e370f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1300,6 +1300,13 @@ M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: rust/hw/char/pl011/
 
+Axiado SoCs and EVKs
+M: Kuan-Jui Chiu <kchiu@axiado.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/ax3000*.c
+F: include/hw/arm/ax3000*.h
+
 AVR Machines
 -------------
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 82e0bc2e70..2ed2c2c6e8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -725,3 +725,9 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config AXIADO_SOC
+    bool
+    select ARM_GIC
+    select CADENCE # UART
+    select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
new file mode 100644
index 0000000000..b528f8af53
--- /dev/null
+++ b/hw/arm/ax3000-soc.c
@@ -0,0 +1,182 @@
+/*
+ * Axiado SoC AX3000
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/address-spaces.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/ax3000-soc.h"
+#include "hw/misc/unimp.h"
+#include "system/system.h"
+#include "qobject/qlist.h"
+#include "qom/object.h"
+#include "hw/core/boards.h"
+
+static void ax3000_init(Object *obj)
+{
+    Ax3000SoCState *s = AX3000_SOC(obj);
+    Ax3000SoCClass *sc = AX3000_SOC_GET_CLASS(s);
+
+    for (int i = 0; i < sc->num_cpus; i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(obj, name, &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a53"));
+    }
+
+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
+
+    for (int i = 0; i < AX3000_NUM_UARTS; i++) {
+        g_autofree char *name = g_strdup_printf("uart%d", i);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
+    }
+}
+
+static void ax3000_realize(DeviceState *dev, Error **errp)
+{
+    Ax3000SoCState *s = AX3000_SOC(dev);
+    Ax3000SoCClass *sc = AX3000_SOC_GET_CLASS(s);
+    SysBusDevice *gic_sbd = SYS_BUS_DEVICE(&s->gic);
+    DeviceState *gic_dev = DEVICE(&s->gic);
+    QList *redist_region_count;
+    SysBusDevice *sdhci0_sbd;
+    DeviceState *card;
+
+    /* CPUs */
+    for (int i = 0; i < sc->num_cpus; i++) {
+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
+                                &error_abort);
+
+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
+                                     false, &error_abort);
+        }
+
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
+            return;
+        }
+    }
+
+    /* GIC */
+    qdev_prop_set_uint32(gic_dev, "num-cpu", sc->num_cpus);
+    qdev_prop_set_uint32(gic_dev, "num-irq",
+                         AX3000_NUM_IRQS + GIC_INTERNAL);
+
+    redist_region_count = qlist_new();
+    qlist_append_int(redist_region_count, sc->num_cpus);
+    qdev_prop_set_array(gic_dev, "redist-region-count", redist_region_count);
+
+    if (!sysbus_realize(gic_sbd, errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(gic_sbd, 0, AX3000_GIC_DIST_BASE);
+    sysbus_mmio_map(gic_sbd, 1, AX3000_GIC_REDIST_BASE);
+
+    /*
+     * Mapping from the output timer irq lines from the CPU to the
+     * GIC PPI inputs.
+     */
+    const int timer_irqs[] = {
+        [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+        [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+        [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+        [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ
+    };
+
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs, and
+     * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
+     */
+    for (int i = 0; i < sc->num_cpus; i++) {
+        DeviceState *cpu_dev = DEVICE(&s->cpu[i]);
+        int intidbase = AX3000_NUM_IRQS + i * GIC_INTERNAL;
+        qemu_irq irq;
+
+        for (int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
+            irq = qdev_get_gpio_in(gic_dev, intidbase + timer_irqs[j]);
+            qdev_connect_gpio_out(cpu_dev, j, irq);
+        }
+
+        irq = qdev_get_gpio_in(gic_dev, intidbase + ARCH_GIC_MAINT_IRQ);
+        qdev_connect_gpio_out_named(cpu_dev, "gicv3-maintenance-interrupt",
+                                        0, irq);
+
+        sysbus_connect_irq(gic_sbd, i,
+                           qdev_get_gpio_in(cpu_dev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gic_sbd, i + sc->num_cpus,
+                           qdev_get_gpio_in(cpu_dev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gic_sbd, i + 2 * sc->num_cpus,
+                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gic_sbd, i + 3 * sc->num_cpus,
+                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VFIQ));
+    }
+
+    /* DRAM */
+    const struct {
+        hwaddr addr;
+        size_t size;
+        const char *name;
+    } dram_table[] = {
+        { AX3000_DRAM0_BASE, AX3000_DRAM0_SIZE, "dram0" },
+        { AX3000_DRAM1_BASE, AX3000_DRAM1_SIZE, "dram1" }
+    };
+
+    for (int i = 0; i < AX3000_NUM_BANKS; i++) {
+        memory_region_init_ram(&s->dram[i], OBJECT(s), dram_table[i].name,
+                               dram_table[i].size, &error_fatal);
+        memory_region_add_subregion(get_system_memory(), dram_table[i].addr,
+                                    &s->dram[i]);
+    }
+
+    /* UARTs */
+    const struct {
+        hwaddr addr;
+        unsigned int irq;
+    } serial_table[] = {
+        { AX3000_UART0_BASE, AX3000_UART0_IRQ },
+        { AX3000_UART1_BASE, AX3000_UART1_IRQ },
+        { AX3000_UART2_BASE, AX3000_UART2_IRQ },
+        { AX3000_UART3_BASE, AX3000_UART3_IRQ }
+    };
+
+    for (int i = 0; i < AX3000_NUM_UARTS; i++) {
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           qdev_get_gpio_in(gic_dev, serial_table[i].irq));
+    }
+
+    /* Timer control */
+    create_unimplemented_device("ax3000.timerctrl", AX3000_TIMER_CTRL, 32);
+}
+
+static void ax3000_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    Ax3000SoCClass *sc = AX3000_SOC_CLASS(oc);
+
+    dc->desc = "Axiado SoC AX3000";
+    dc->realize = ax3000_realize;
+    sc->num_cpus = AX3000_NUM_CPUS;
+}
+
+static const TypeInfo axiado_soc_types[] = {
+    {
+        .name           = TYPE_AX3000_SOC,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(Ax3000SoCState),
+        .instance_init  = ax3000_init,
+        .class_init     = ax3000_class_init,
+    }
+};
+
+DEFINE_TYPES(axiado_soc_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 4233a800be..0254b82df1 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -110,6 +110,9 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
+arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
+  'ax3000-soc.c'))
+
 arm_common_ss.add(files('boot.c'))
 
 hw_common_arch += {'arm': arm_common_ss}
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
new file mode 100644
index 0000000000..b984d7a8ec
--- /dev/null
+++ b/include/hw/arm/ax3000-soc.h
@@ -0,0 +1,68 @@
+/*
+ * Axiado SoC AX3000
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef AXIADO_AX3000_H
+#define AXIADO_AX3000_H
+
+#include "cpu.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "hw/char/cadence_uart.h"
+#include "hw/core/sysbus.h"
+#include "qemu/units.h"
+
+#define TYPE_AX3000_SOC "ax3000"
+OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
+
+#define AX3000_DRAM0_BASE       0x3C000000
+#define AX3000_DRAM0_SIZE       (1088 * MiB)
+#define AX3000_DRAM1_BASE       0x400000000
+#define AX3000_DRAM1_SIZE       (2 * GiB)
+
+#define AX3000_GIC_DIST_BASE    0x80300000
+#define AX3000_GIC_DIST_SIZE    (64 * KiB)
+#define AX3000_GIC_REDIST_BASE  0x80380000
+#define AX3000_GIC_REDIST_SIZE  (512 * KiB)
+
+#define AX3000_UART0_BASE       0x80520000
+#define AX3000_UART1_BASE       0x805a0000
+#define AX3000_UART2_BASE       0x80620000
+#define AX3000_UART3_BASE       0x80520800
+
+#define AX3000_TIMER_CTRL       0x8A020000
+#define AX3000_PLL_BASE         0x80000000
+
+enum Ax3000Configuration {
+    AX3000_NUM_CPUS     = 4,
+    AX3000_NUM_IRQS     = 224,
+    AX3000_NUM_BANKS    = 2,
+    AX3000_NUM_UARTS    = 4,
+};
+
+typedef struct Ax3000SoCState {
+    SysBusDevice        parent;
+
+    ARMCPU              cpu[AX3000_NUM_CPUS];
+    GICv3State          gic;
+    MemoryRegion        dram[AX3000_NUM_BANKS];
+    CadenceUARTState    uart[AX3000_NUM_UARTS];
+} Ax3000SoCState;
+
+typedef struct Ax3000SoCClass {
+    SysBusDeviceClass   parent;
+
+    uint32_t            num_cpus;
+} Ax3000SoCClass;
+
+enum Ax3000Irqs {
+    AX3000_UART0_IRQ    = 112,
+    AX3000_UART1_IRQ    = 113,
+    AX3000_UART2_IRQ    = 114,
+    AX3000_UART3_IRQ    = 170,
+};
+
+#endif /* AXIADO_AX3000_H */
-- 
2.43.0


