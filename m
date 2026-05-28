Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC78CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjHi-0000KD-0R; Thu, 28 May 2026 18:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wSi1b-0008Vb-KD
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:12:19 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wSi1X-000550-40
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:12:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so55163775e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780002733; x=1780607533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVzECgyF01S+q9muu/ENfuD5x4p2aYVjPbQI66GQ+mw=;
 b=GXTp5Sfng68JHt/rEt6+xJntDK1hbMSr1pwT6/fjqs4xNCUvunI/nZLQGuzNumRoFs
 QDVysP2DNkrHy11PgTKYvjELh7TzS+V17gtm0eKewC8J8WlCEQkpfW2i8q2xg2vlwbxL
 u5V7Eo+7FYBlaHYCBFjb0eI8hhjC+NRfsH6GCprs9qaOP/e5hvRpr8mDCobDSXOC1DKQ
 YTYEHDXsbQss0dImYGQSntovgGQiKkr5R2Ual+wZNQs2bVELw05SYywHCLs/MPD0agbH
 Ddu2IfprdQK9BtxswH0Hp4pAm5VHqZayNkjGjyD55SBhdbafct7KfWgt2sNRFNKHp+aU
 E6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780002733; x=1780607533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pVzECgyF01S+q9muu/ENfuD5x4p2aYVjPbQI66GQ+mw=;
 b=iRlIvWkKknhChTaSTDn/mOv40P7SqiffxhORd3Zk2K5sXCfocGKQEVpyHFVpC/XDvC
 MI8Xy3prK6v+97yZRClIcTHReuVa1ij3ini38vaxEyMLgd5O8M7J1RmKTriLtN2qzVQU
 xRLMl50UgQ2se14D775LcS1Z0qY7UJXH+O/nhMGySb/2ItMjt9jyEKp1+Rxx4wLR/Tjm
 GyThxe5TUY+I5WklI0XFFaUarWU8nzh2uVKnBCoUmVyx1VI8NY5fDrTIsmR2GiUtFlDf
 1uT689uFAGJctPjpHmrCElFQSEspLRm4UFqI4RpBW2cfs6J1nbJ9h+rAjLSwpt8S4P23
 8vGg==
X-Gm-Message-State: AOJu0Yy58NJEuejVrDaPJ4WsJzzNlHDuSN22hVTkeg33ez0YYNCVTRs5
 yTmrAqI++QbaihOXEGCr7E+I+GRi5AoIq3Xez4ygYipjDEO/gqjlc30X3NHeH2FI
X-Gm-Gg: Acq92OEuS1ZSuD3l7o2dmoreOxFWJCSUfeKhz/+KBrfrYmTGvZSaMvXR9wIB0qWTsCP
 RYIUXMjClmTxmS6FGW5k2S7RroMJfXkrgbXlImrUn9hS3IpyJ0KRaFE5Cv4SiVi4bRCilOaK6rA
 rimXvG53zfR3quwI/5GENAC2SYPpotp3axeMMVCLZjaANmKdMxiCDBLPzwiVyoEqLi9XvJD3DVK
 z/xovGaDLJQzyqOBjjq4x2llRIowO7dnBifo/U8uc+P83nI4O+sx7YhdrNHSHfPDSGUxkEiKhv1
 hID3Nnr+Lq8rGUn2EyQ4g1uFrOp+kYWUuvJSVQA9v1JMPtiGmLkDNLf+Q/hCKrXB3wWEaCc5L2S
 jeOgGp/dumniPH4d6C2zgDPp6tFn/r33VdsRkEiibLZ6wANjEZyM4hBaLJnZcedu1DsvCilU0No
 T5F1BxULBz3+1Mt4M=
X-Received: by 2002:a05:600c:e489:20b0:490:688b:f9f8 with SMTP id
 5b1f17b1804b1-4909c0ba255mr2069975e9.27.1780002733054; 
 Thu, 28 May 2026 14:12:13 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c609787sm108365e9.6.2026.05.28.14.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:12:12 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v0 1/2] hw/arm: Add minimal TI K3 AM64x SoC model
Date: Thu, 28 May 2026 23:12:09 +0200
Message-ID: <20260528211210.74266-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528211210.74266-1-wafgo01@gmail.com>
References: <20260528211210.74266-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=wafgo01@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2026 18:32:56 -0400
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

Add an initial model of the TI K3 AM64x SoC family. This first patch
covers the bare minimum needed to bring up a Linux kernel on the
Cortex-A53 cluster:

  - Up to two Cortex-A53 CPUs
  - ARM GIC at the GICSS0 base address
  - Two MAIN-domain 16550-style UARTs at their real-hardware addresses,
    backed by the existing TYPE_SERIAL_MM model

The CPU count is read directly from the machine's smp.cpus, matching
the pattern in hw/arm/fsl-imx8mp.c. EL2/EL3 are only enabled under
TCG.

Note: real AM64x hardware uses a GIC-500 (GICv3). This initial drop
uses the GICv2 model (arm_gic, revision 2) to keep the bring-up
mechanically simple; moving to GICv3 is on the follow-up roadmap.
Additional SoC blocks (Cortex-M4F MCU, Cortex-R5F cores, mailbox,
secure proxy, DMSC/TISCI service, RAT) are intentionally not modelled
here and will be added in subsequent patches.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 MAINTAINERS               |   8 ++
 hw/arm/Kconfig            |   5 +
 hw/arm/meson.build        |   1 +
 hw/arm/ti-am64x.c         | 212 ++++++++++++++++++++++++++++++++++++++
 include/hw/arm/ti-am64x.h |  36 +++++++
 5 files changed, 262 insertions(+)
 create mode 100644 hw/arm/ti-am64x.c
 create mode 100644 include/hw/arm/ti-am64x.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..95cadde5dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1186,6 +1186,14 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/olimex-stm32-h405.c
 
+TI K3 AM64x
+M: Wadim Mueller <wafgo01@gmail.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/am64-virt.c
+F: hw/arm/ti-am64x.c
+F: include/hw/arm/ti-am64x.h
+
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7877506384..96cb0f5185 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -626,6 +626,11 @@ config FSL_IMX8MP_EVK
     depends on TCG
     select FSL_IMX8MP
 
+config TI_AM64X
+    bool
+    select ARM_GIC
+    select SERIAL_MM
+
 config ARM_SMMUV3
     bool
 
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index aeaf654790..89fad790f5 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -84,6 +84,7 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
+arm_common_ss.add(when: 'CONFIG_TI_AM64X', if_true: files('ti-am64x.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
diff --git a/hw/arm/ti-am64x.c b/hw/arm/ti-am64x.c
new file mode 100644
index 0000000000..4026fe23e8
--- /dev/null
+++ b/hw/arm/ti-am64x.c
@@ -0,0 +1,212 @@
+/*
+ * TI K3 AM64x SoC
+ *
+ * Copyright (c) 2026 CMBlu
+ * Written by Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/ti-am64x.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "system/kvm.h"
+#include "system/system.h"
+
+#define TI_AM64X_GIC_DIST_ADDR  0x01800000
+#define TI_AM64X_GIC_CPU_ADDR   0x01810000
+#define TI_AM64X_MAIN_UART0_ADDR 0x02800000
+#define TI_AM64X_MAIN_UART1_ADDR 0x02810000
+#define TI_AM64X_MAIN_UART_SIZE  0x100
+#define TI_AM64X_MAIN_UART_REGSHIFT 2
+
+/* SPI = AM64x TRM GIC INTID - GIC_INTERNAL. */
+#define TI_AM64X_MAIN_UART0_SPI 146  /* MAIN_UART0_USART_IRQ */
+#define TI_AM64X_MAIN_UART1_SPI 147  /* MAIN_UART1_USART_IRQ */
+
+static const struct {
+    hwaddr addr;
+    unsigned int spi;
+} ti_am64x_main_uart_table[TI_AM64X_NUM_MAIN_UARTS] = {
+    { TI_AM64X_MAIN_UART0_ADDR, TI_AM64X_MAIN_UART0_SPI },
+    { TI_AM64X_MAIN_UART1_ADDR, TI_AM64X_MAIN_UART1_SPI },
+};
+
+static void ti_am64x_init(Object *obj)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    TIAM64xState *s = TI_AM64X(obj);
+    unsigned int num_cpus = MIN(ms->smp.cpus, TI_AM64X_NUM_A53_CPUS);
+    unsigned int i;
+
+    for (i = 0; i < num_cpus; i++) {
+        object_initialize_child(obj, "a53[*]", &s->a53[i],
+                                ARM_CPU_TYPE_NAME("cortex-a53"));
+    }
+
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
+
+    for (i = 0; i < TI_AM64X_NUM_MAIN_UARTS; i++) {
+        object_initialize_child(obj, "main-uart[*]", &s->main_uart[i],
+                                TYPE_SERIAL_MM);
+    }
+}
+
+static bool ti_am64x_realize_cpus(TIAM64xState *s, unsigned int num_cpus,
+                                  Error **errp)
+{
+    unsigned int i;
+
+    for (i = 0; i < num_cpus; i++) {
+        Object *cpuobj = OBJECT(&s->a53[i]);
+
+        if (!object_property_set_int(cpuobj, "mp-affinity", i, errp)) {
+            return false;
+        }
+
+        if (object_property_find(cpuobj, "has_el3")) {
+            object_property_set_bool(cpuobj, "has_el3", !kvm_enabled(),
+                                     &error_abort);
+        }
+        if (object_property_find(cpuobj, "has_el2")) {
+            object_property_set_bool(cpuobj, "has_el2", !kvm_enabled(),
+                                     &error_abort);
+        }
+        object_property_set_bool(cpuobj, "start-powered-off", i != 0,
+                                 &error_abort);
+
+        if (!qdev_realize(DEVICE(cpuobj), NULL, errp)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static bool ti_am64x_realize_gic(TIAM64xState *s, unsigned int num_cpus,
+                                 Error **errp)
+{
+    DeviceState *gicdev = DEVICE(&s->gic);
+    SysBusDevice *gicsbd = SYS_BUS_DEVICE(&s->gic);
+    unsigned int i;
+
+    qdev_prop_set_uint32(gicdev, "revision", 2);
+    qdev_prop_set_uint32(gicdev, "num-cpu", num_cpus);
+    qdev_prop_set_uint32(gicdev, "num-irq",
+                         TI_AM64X_NUM_SPIS + GIC_INTERNAL);
+
+    if (!sysbus_realize(gicsbd, errp)) {
+        return false;
+    }
+
+    sysbus_mmio_map(gicsbd, 0, TI_AM64X_GIC_DIST_ADDR);
+    sysbus_mmio_map(gicsbd, 1, TI_AM64X_GIC_CPU_ADDR);
+
+    for (i = 0; i < num_cpus; i++) {
+        DeviceState *cpudev = DEVICE(&s->a53[i]);
+        int ppi_base = TI_AM64X_NUM_SPIS + i * GIC_INTERNAL;
+        static const int timer_irqs[] = {
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+        };
+        int j;
+
+        for (j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
+            qdev_connect_gpio_out(cpudev, j,
+                                  qdev_get_gpio_in(gicdev,
+                                                   ppi_base + timer_irqs[j]));
+        }
+
+        sysbus_connect_irq(gicsbd, i,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gicsbd, i + num_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicsbd, i + 2 * num_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicsbd, i + 3 * num_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    }
+
+    return true;
+}
+
+static bool ti_am64x_realize_uarts(TIAM64xState *s, Error **errp)
+{
+    DeviceState *gicdev = DEVICE(&s->gic);
+    int i;
+
+    for (i = 0; i < TI_AM64X_NUM_MAIN_UARTS; i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->main_uart[i]);
+
+        qdev_prop_set_uint8(DEVICE(sbd), "regshift",
+                            TI_AM64X_MAIN_UART_REGSHIFT);
+        qdev_prop_set_uint32(DEVICE(sbd), "baudbase", 48000000);
+        qdev_prop_set_chr(DEVICE(sbd), "chardev", serial_hd(i));
+
+        if (!sysbus_realize(sbd, errp)) {
+            return false;
+        }
+
+        sysbus_mmio_map(sbd, 0, ti_am64x_main_uart_table[i].addr);
+        sysbus_connect_irq(sbd, 0,
+                           qdev_get_gpio_in(gicdev,
+                                            ti_am64x_main_uart_table[i].spi));
+    }
+
+    return true;
+}
+
+static void ti_am64x_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    TIAM64xState *s = TI_AM64X(dev);
+    unsigned int num_cpus = ms->smp.cpus;
+
+    if (num_cpus < 1 || num_cpus > TI_AM64X_NUM_A53_CPUS) {
+        error_setg(errp,
+                   "%s: only between 1 and %u Cortex-A53 CPUs are supported "
+                   "(%u requested)",
+                   TYPE_TI_AM64X, TI_AM64X_NUM_A53_CPUS, num_cpus);
+        return;
+    }
+
+    if (!ti_am64x_realize_cpus(s, num_cpus, errp)) {
+        return;
+    }
+
+    if (!ti_am64x_realize_gic(s, num_cpus, errp)) {
+        return;
+    }
+
+    if (!ti_am64x_realize_uarts(s, errp)) {
+        return;
+    }
+}
+
+static void ti_am64x_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = ti_am64x_realize;
+    /* Mapped at fixed locations on the system bus by board code. */
+    dc->user_creatable = false;
+    dc->desc = "TI K3 AM64x SoC";
+}
+
+static const TypeInfo ti_am64x_types[] = {
+    {
+        .name = TYPE_TI_AM64X,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(TIAM64xState),
+        .instance_init = ti_am64x_init,
+        .class_init = ti_am64x_class_init,
+    },
+};
+
+DEFINE_TYPES(ti_am64x_types)
diff --git a/include/hw/arm/ti-am64x.h b/include/hw/arm/ti-am64x.h
new file mode 100644
index 0000000000..73f56c3b2a
--- /dev/null
+++ b/include/hw/arm/ti-am64x.h
@@ -0,0 +1,36 @@
+/*
+ * TI K3 AM64x SoC
+ *
+ * Copyright (c) 2026 CMBlu
+ * Written by Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_TI_AM64X_H
+#define HW_ARM_TI_AM64X_H
+
+#include "hw/sysbus.h"
+#include "hw/intc/arm_gic.h"
+#include "hw/char/serial-mm.h"
+#include "qom/object.h"
+#include "target/arm/cpu.h"
+
+#define TYPE_TI_AM64X "ti-am64x"
+OBJECT_DECLARE_SIMPLE_TYPE(TIAM64xState, TI_AM64X)
+
+#define TI_AM64X_NUM_A53_CPUS 2
+#define TI_AM64X_NUM_MAIN_UARTS 2
+#define TI_AM64X_NUM_SPIS 256  /* AM64x GICSS0 supports up to 992 SPIs */
+
+struct TIAM64xState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    ARMCPU a53[TI_AM64X_NUM_A53_CPUS];
+    GICState gic;
+    SerialMM main_uart[TI_AM64X_NUM_MAIN_UARTS];
+};
+
+#endif /* HW_ARM_TI_AM64X_H */
-- 
2.52.0


