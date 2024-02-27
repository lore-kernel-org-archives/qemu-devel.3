Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0681CC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaw-00014w-4u; Tue, 27 Feb 2024 08:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaT-0000mK-Pr
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:37 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaN-0002tj-Am
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:35 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33de64c91abso799153f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040809; x=1709645609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ommNmOrQ47/Ozr7tANJi0FPpzUehs1D2sJfCH09Bk8A=;
 b=OPU9TV9rAwg2YuIwloba8i1qzCrSfiqOWLKY/BSysYlyXAq+Y7JhUU5Sjm4PBCjQJw
 in3p63vhMwuSPXlOvx0bxMcIVdcN9yCWxQNY6lM2iJZ7Agns1LO8OoomGu/juCRjm7KK
 IZtPK+yf077ABPLRQLpBYnU0vSmbdT/Ir/tYlnkirK1tOxd510JQVOCW+PCIN9haINNL
 xYDbG8+LfvUkVaScDMFhARB4ubVjsljUQ7m4yqccJrgikUp+OEH7PwOMKZTj5h5F+3WQ
 rg+e7yMdAcdltrmzVDrvoYe9sZtv4cprOlaEg+Euo+9tD/PGQ0VNSG/xUmdsXY+40KOL
 WGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040809; x=1709645609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ommNmOrQ47/Ozr7tANJi0FPpzUehs1D2sJfCH09Bk8A=;
 b=XT9xYWNjIGNNlmGDrdZ1RDfiUcW41sQL4ULWCuHl4WyGjshaVkwPEXRtkDeq6zbihA
 rBP2TTYjQLBhVzx3J88HpJHL8NwO39QhArXFyEAcOBc/Sb76IwU5WSgieAowJFSDhDtQ
 2mCBeroNwtrnCLe+Dz0SL9HHYSl3ZS9ERbBMM0W2TFZAPa7geWxton43Lo+vYRn05jB7
 1ejoZ51P1b+ncYCcNuhjidwjPb7Wj/k6Qd55CnmaDV2BfGWnL2xy9dPPz46/TsN7OGh9
 MaIjeJSeDQC6fnb4fREaElR05lmxDLdStivVHI4RxIL3VYXXH1UhyYB1VT//egHd5Xnl
 7wrQ==
X-Gm-Message-State: AOJu0YzgqA3mQKIcb2Jg0Cfx3v9/2IZ1KOPMu+GhYw79h44UhTcStme5
 i1myn5v7zE5eTN6fSlf2ejCYcvPotCSQ40e/QYfxlDsILr+RPrbCwOKv93aJ9HfwwnR2vgtXpkN
 3
X-Google-Smtp-Source: AGHT+IHim+Wv4kFz2RRhAmqorZaml8Ynuz9j9bQo1o0f9voWj3OPatgLgKfuT5Vf3PfnNdusnhrQcQ==
X-Received: by 2002:adf:fd8e:0:b0:33d:af84:2a59 with SMTP id
 d14-20020adffd8e000000b0033daf842a59mr6371499wrr.28.1709040809215; 
 Tue, 27 Feb 2024 05:33:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/45] hw/arm/bcm2838: Add GIC-400 to BCM2838 SoC
Date: Tue, 27 Feb 2024 13:32:54 +0000
Message-Id: <20240227133314.1721857-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Sergey Kambalin <serg.oker@gmail.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240226000259.2752893-6-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2838.h             |   2 +
 include/hw/arm/bcm2838_peripherals.h |  37 ++++++
 hw/arm/bcm2838.c                     | 167 ++++++++++++++++++++++++++-
 hw/arm/trace-events                  |   3 +
 4 files changed, 207 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/bcm2838.h b/include/hw/arm/bcm2838.h
index bddc25ca9af..e53c7bedf92 100644
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
index 7039b67cc96..d07831753ab 100644
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
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 05281e247fe..332e906a84f 100644
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
index fd0d92762e4..f1a54a02dfc 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -70,3 +70,6 @@ z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
 xen_create_virtio_mmio_devices(int i, int irq, uint64_t base) "Created virtio-mmio device %d: irq %d base 0x%"PRIx64
 xen_init_ram(uint64_t machine_ram_size) "Initialized xen ram with size 0x%"PRIx64
 xen_enable_tpm(uint64_t addr) "Connected tpmdev at address 0x%"PRIx64
+
+# bcm2838.c
+bcm2838_gic_set_irq(int irq, int level) "gic irq:%d lvl:%d"
-- 
2.34.1


