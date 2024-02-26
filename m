Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F53DC47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 00:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOSu-0006gb-A7; Sun, 25 Feb 2024 19:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOSo-0006bG-Hz; Sun, 25 Feb 2024 19:03:22 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOSf-0000Hh-G4; Sun, 25 Feb 2024 19:03:22 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-607eefeea90so24209507b3.1; 
 Sun, 25 Feb 2024 16:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905789; x=1709510589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vmo1HF5GS3GgWgt3hxXbpVkMYCYCmwGEA7vcz+en818=;
 b=jAOpW2vBeZjwRkHxG31fEQ4mQmLwT/0ydRvXUcx0y599k+AMmBdJS942YG90FAyB2j
 lWphJEkASqDFgpFmvqGKb3G1io8CDJDushcb1xKTzTjzOdwLSuPwFg/szaSIby1j2Exe
 VR6wruJ7VEdOKkxvEwylQFs+FBw/At++/wjtVDQ7mMjT2di/17CDPB76jks+IWJzrzTy
 AVKkT/PJpABGbb1Pm98pxg8LQocuXSoS+8qAEIe9Pcj4s8LgPAJ1mePOjh4nHkD4ezsh
 3krafker1UdT1QYtcgUichkw/XZEGhRmIMTG4+FMpoaygACgK4JjzjqWhXNCxFExcgni
 V2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905789; x=1709510589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vmo1HF5GS3GgWgt3hxXbpVkMYCYCmwGEA7vcz+en818=;
 b=PGk89WvtaygXZHZ9hjqGHnp9x1Z3Uk0xFy+I4ddAeAv7VWrQV/eXTEoBE1K9bmUx0p
 HhG+mn09SVTBn2U3LLvg0bW57axSlt27Uc4bnPoguvXl8HMtbDpy2H9LkHTW7lbDnpZC
 YdURtpPCkHVoxl1LRBcag0sIY68QsOzr0Nc7WUQLg9C+lReTbwOLeR8bVm34h4le5fc3
 kBTN1gRGjmo9D+nWd0Ce1k3BYI4xU3P40n5gp3jcxhWuj5wPZhrjo8iCDJzzF+Qd7H2t
 mWxfF+LFiKwDYeJvKjTg/0xUGPta9vDXo9iP39DlZX0Pw0UnpumwW7W5S/ItmfUhLXS9
 7+nw==
X-Gm-Message-State: AOJu0Yxv5tTN2zKlPShi8LtfEprMveNzdYAf2fbPaVwauHBw7A3gxI6p
 ugUr5ObD7LdJ1cPSlax9B7+kaWhh9RvUfgWx0urd6kA9lL2r6iddmYdoj3ub4LzWig==
X-Google-Smtp-Source: AGHT+IGmmBTbLkJkOtfskUbzWnrh9Roz1/0pFNzqHNoDfbq8inaWvutN1ckdzkAXr2q8cDzXMF1uAA==
X-Received: by 2002:a81:6d8d:0:b0:608:3cab:c57c with SMTP id
 i135-20020a816d8d000000b006083cabc57cmr3713334ywc.17.1708905789147; 
 Sun, 25 Feb 2024 16:03:09 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:08 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 05/41] Add GIC-400 to BCM2838 SoC
Date: Sun, 25 Feb 2024 18:02:23 -0600
Message-Id: <20240226000259.2752893-6-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2838.c                     | 167 ++++++++++++++++++++++++++-
 hw/arm/trace-events                  |   3 +
 include/hw/arm/bcm2838.h             |   2 +
 include/hw/arm/bcm2838_peripherals.h |  37 ++++++
 4 files changed, 207 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 05281e247f..332e906a84 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -14,8 +14,36 @@
 #include "hw/arm/bcm2838.h"
 #include "trace.h"
 
+#define GIC400_MAINTENANCE_IRQ      9
+#define GIC400_TIMER_NS_EL2_IRQ     10
+#define GIC400_TIMER_VIRT_IRQ       11
+#define GIC400_LEGACY_FIQ           12
+#define GIC400_TIMER_S_EL1_IRQ      13
+#define GIC400_TIMER_NS_EL1_IRQ     14
+#define GIC400_LEGACY_IRQ           15
+
+/* Number of external interrupt lines to configure the GIC with */
+#define GIC_NUM_IRQS                192
+
+#define PPI(cpu, irq) (GIC_NUM_IRQS + (cpu) * GIC_INTERNAL + GIC_NR_SGIS + irq)
+
+#define GIC_BASE_OFS                0x0000
+#define GIC_DIST_OFS                0x1000
+#define GIC_CPU_OFS                 0x2000
+#define GIC_VIFACE_THIS_OFS         0x4000
+#define GIC_VIFACE_OTHER_OFS(cpu)  (0x5000 + (cpu) * 0x200)
+#define GIC_VCPU_OFS                0x6000
+
 #define VIRTUAL_PMU_IRQ 7
 
+static void bcm2838_gic_set_irq(void *opaque, int irq, int level)
+{
+    BCM2838State *s = (BCM2838State *)opaque;
+
+    trace_bcm2838_gic_set_irq(irq, level);
+    qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->gic), irq), level);
+}
+
 static void bcm2838_init(Object *obj)
 {
     BCM2838State *s = BCM2838(obj);
@@ -28,11 +56,12 @@ static void bcm2838_init(Object *obj)
                               "vcram-size");
     object_property_add_alias(obj, "command-line", OBJECT(&s->peripherals),
                               "command-line");
+
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
 }
 
 static void bcm2838_realize(DeviceState *dev, Error **errp)
 {
-    int n;
     BCM2838State *s = BCM2838(dev);
     BCM283XBaseState *s_base = BCM283X_BASE(dev);
     BCM283XBaseClass *bc_base = BCM283X_BASE_GET_CLASS(dev);
@@ -40,6 +69,8 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     BCMSocPeripheralBaseState *ps_base =
         BCM_SOC_PERIPHERALS_BASE(&s->peripherals);
 
+    DeviceState *gicdev = NULL;
+
     if (!bcm283x_common_realize(dev, ps_base, errp)) {
         return;
     }
@@ -52,11 +83,15 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s_base->control), 0, bc_base->ctrl_base);
 
     /* Create cores */
-    for (n = 0; n < bc_base->core_count; n++) {
+    for (int n = 0; n < bc_base->core_count; n++) {
 
         object_property_set_int(OBJECT(&s_base->cpu[n].core), "mp-affinity",
                                 (bc_base->clusterid << 8) | n, &error_abort);
 
+        /* set periphbase/CBAR value for CPU-local registers */
+        object_property_set_int(OBJECT(&s_base->cpu[n].core), "reset-cbar",
+                                bc_base->peri_base, &error_abort);
+
         /* start powered off if not enabled */
         object_property_set_bool(OBJECT(&s_base->cpu[n].core),
                                  "start-powered-off",
@@ -66,6 +101,134 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+
+    if (!object_property_set_uint(OBJECT(&s->gic), "revision", 2, errp)) {
+        return;
+    }
+
+    if (!object_property_set_uint(OBJECT(&s->gic), "num-cpu", BCM283X_NCPUS,
+                                  errp)) {
+        return;
+    }
+
+    if (!object_property_set_uint(OBJECT(&s->gic), "num-irq",
+                                  GIC_NUM_IRQS + GIC_INTERNAL, errp)) {
+        return;
+    }
+
+    if (!object_property_set_bool(OBJECT(&s->gic),
+                                  "has-virtualization-extensions", true,
+                                  errp)) {
+        return;
+    }
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
+                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_DIST_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
+                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_CPU_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
+                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_VIFACE_THIS_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
+                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_VCPU_OFS);
+
+    for (int n = 0; n < BCM283X_NCPUS; n++) {
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 4 + n,
+                        bc_base->ctrl_base + BCM2838_GIC_BASE
+                            + GIC_VIFACE_OTHER_OFS(n));
+    }
+
+    gicdev = DEVICE(&s->gic);
+
+    for (int n = 0; n < BCM283X_NCPUS; n++) {
+        DeviceState *cpudev = DEVICE(&s_base->cpu[n]);
+
+        /* Connect the GICv2 outputs to the CPU */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + BCM283X_NCPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 2 * BCM283X_NCPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 3 * BCM283X_NCPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 4 * BCM283X_NCPUS,
+                           qdev_get_gpio_in(gicdev,
+                                            PPI(n, GIC400_MAINTENANCE_IRQ)));
+
+        /* Connect timers from the CPU to the interrupt controller */
+        qdev_connect_gpio_out(cpudev, GTIMER_PHYS,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_NS_EL1_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_VIRT_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_HYP,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_NS_EL2_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_SEC,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_S_EL1_IRQ)));
+        /* PMU interrupt */
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                    qdev_get_gpio_in(gicdev, PPI(n, VIRTUAL_PMU_IRQ)));
+    }
+
+    /* Connect UART0 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->uart0), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_UART0));
+
+    /* Connect AUX / UART1 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->aux), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_AUX_UART1));
+
+    /* Connect VC mailbox to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->mboxes), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_MBOX));
+
+    /* Connect SD host to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->sdhost), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_SDHOST));
+
+    /* According to DTS, EMMC and EMMC2 share one irq */
+    DeviceState *mmc_irq_orgate = DEVICE(&ps->mmc_irq_orgate);
+
+    /* Connect EMMC and EMMC2 to the interrupt controller */
+    qdev_connect_gpio_out(mmc_irq_orgate, 0,
+                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_EMMC_EMMC2));
+
+    /* Connect USB OTG and MPHI to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->mphi), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_MPHI));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dwc2), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DWC2));
+
+    /* Connect DMA 0-6 to the interrupt controller */
+    for (int n = GIC_SPI_INTERRUPT_DMA_0; n <= GIC_SPI_INTERRUPT_DMA_6; n++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dma),
+                           n - GIC_SPI_INTERRUPT_DMA_0,
+                           qdev_get_gpio_in(gicdev, n));
+    }
+
+    /* According to DTS, DMA 7 and 8 share one irq */
+    DeviceState *dma_7_8_irq_orgate = DEVICE(&ps->dma_7_8_irq_orgate);
+
+    /* Connect DMA 7-8 to the interrupt controller */
+    qdev_connect_gpio_out(dma_7_8_irq_orgate, 0,
+                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_7_8));
+
+    /* According to DTS, DMA 9 and 10 share one irq */
+    DeviceState *dma_9_10_irq_orgate = DEVICE(&ps->dma_9_10_irq_orgate);
+
+    /* Connect DMA 9-10 to the interrupt controller */
+    qdev_connect_gpio_out(dma_9_10_irq_orgate, 0,
+                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_9_10));
+
+    /* Pass through inbound GPIO lines to the GIC */
+    qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
+
+    /* Pass through outbound IRQ lines from the GIC */
+    qdev_pass_gpios(DEVICE(&s->gic), DEVICE(&s->peripherals), NULL);
 }
 
 static void bcm2838_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index fd0d92762e..f1a54a02df 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -70,3 +70,6 @@ z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
 xen_create_virtio_mmio_devices(int i, int irq, uint64_t base) "Created virtio-mmio device %d: irq %d base 0x%"PRIx64
 xen_init_ram(uint64_t machine_ram_size) "Initialized xen ram with size 0x%"PRIx64
 xen_enable_tpm(uint64_t addr) "Connected tpmdev at address 0x%"PRIx64
+
+# bcm2838.c
+bcm2838_gic_set_irq(int irq, int level) "gic irq:%d lvl:%d"
diff --git a/include/hw/arm/bcm2838.h b/include/hw/arm/bcm2838.h
index bddc25ca9a..e53c7bedf9 100644
--- a/include/hw/arm/bcm2838.h
+++ b/include/hw/arm/bcm2838.h
@@ -10,6 +10,7 @@
 #define BCM2838_H
 
 #include "hw/arm/bcm2836.h"
+#include "hw/intc/arm_gic.h"
 #include "hw/arm/bcm2838_peripherals.h"
 
 #define BCM2838_PERI_LOW_BASE 0xfc000000
@@ -24,6 +25,7 @@ struct BCM2838State {
     BCM283XBaseState parent_obj;
     /*< public >*/
     BCM2838PeripheralState peripherals;
+    GICState gic;
 };
 
 #endif /* BCM2838_H */
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 7039b67cc9..d07831753a 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -11,6 +11,39 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 
+/* SPI */
+#define GIC_SPI_INTERRUPT_MBOX         33
+#define GIC_SPI_INTERRUPT_MPHI         40
+#define GIC_SPI_INTERRUPT_DWC2         73
+#define GIC_SPI_INTERRUPT_DMA_0        80
+#define GIC_SPI_INTERRUPT_DMA_6        86
+#define GIC_SPI_INTERRUPT_DMA_7_8      87
+#define GIC_SPI_INTERRUPT_DMA_9_10     88
+#define GIC_SPI_INTERRUPT_AUX_UART1    93
+#define GIC_SPI_INTERRUPT_SDHOST       120
+#define GIC_SPI_INTERRUPT_UART0        121
+#define GIC_SPI_INTERRUPT_RNG200       125
+#define GIC_SPI_INTERRUPT_EMMC_EMMC2   126
+#define GIC_SPI_INTERRUPT_PCI_INT_A    143
+#define GIC_SPI_INTERRUPT_GENET_A      157
+#define GIC_SPI_INTERRUPT_GENET_B      158
+
+
+/* GPU (legacy) DMA interrupts */
+#define GPU_INTERRUPT_DMA0      16
+#define GPU_INTERRUPT_DMA1      17
+#define GPU_INTERRUPT_DMA2      18
+#define GPU_INTERRUPT_DMA3      19
+#define GPU_INTERRUPT_DMA4      20
+#define GPU_INTERRUPT_DMA5      21
+#define GPU_INTERRUPT_DMA6      22
+#define GPU_INTERRUPT_DMA7_8    23
+#define GPU_INTERRUPT_DMA9_10   24
+#define GPU_INTERRUPT_DMA11     25
+#define GPU_INTERRUPT_DMA12     26
+#define GPU_INTERRUPT_DMA13     27
+#define GPU_INTERRUPT_DMA14     28
+#define GPU_INTERRUPT_DMA15     31
 
 #define TYPE_BCM2838_PERIPHERALS "bcm2838-peripherals"
 OBJECT_DECLARE_TYPE(BCM2838PeripheralState, BCM2838PeripheralClass,
@@ -24,6 +57,10 @@ struct BCM2838PeripheralState {
     MemoryRegion peri_low_mr;
     MemoryRegion peri_low_mr_alias;
     MemoryRegion mphi_mr_alias;
+
+    OrIRQState mmc_irq_orgate;
+    OrIRQState dma_7_8_irq_orgate;
+    OrIRQState dma_9_10_irq_orgate;
 };
 
 struct BCM2838PeripheralClass {
-- 
2.34.1


