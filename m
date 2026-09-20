Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AB9C982E1
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 11:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8G8j-0006Zs-ET; Sun, 20 Sep 2026 07:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x8G8g-0006Xc-Sh; Sun, 20 Sep 2026 07:55:23 -0400
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x8G8e-0001cW-EP; Sun, 20 Sep 2026 07:55:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A8360200018;
 Sun, 20 Sep 2026 13:55:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 71896200008;
 Sun, 20 Sep 2026 13:55:18 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8089018000BE;
 Sun, 20 Sep 2026 19:55:16 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv3 09/10] hw/arm: Add IRQ splitter for i.MX8MP AMP interrupt
 routing
Date: Sun, 20 Sep 2026 17:24:57 +0530
Message-Id: <20260920115458.481605-10-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
References: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.21;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva021.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Wire all 160 SoC SPI interrupt lines through SplitIRQ splitters so
that each interrupt is delivered to both the Cortex-A53 GICv3 and the
Cortex-M7 NVIC simultaneously. As per i.MX8MP RM Table 7-2 the
same interrupt lines are routed to both cores.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 hw/arm/fsl-imx8mp.c         | 59 +++++++++++++++++++++++++------------
 include/hw/arm/fsl-imx8mp.h |  2 ++
 2 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index e7dafa2403..17733c7270 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -200,6 +200,12 @@ static void fsl_imx8mp_init(Object *obj)
     FslImx8mpState *s = FSL_IMX8MP(obj);
     int i;
 
+    for (i = 0; i < FSL_IMX8MP_NUM_IRQS; i++) {
+        g_autofree char *name = g_strdup_printf("irq-splitter%d", i);
+        object_initialize_child(obj, name, &s->cpu_irq_splitter[i],
+                                TYPE_SPLIT_IRQ);
+    }
+
     object_initialize_child(obj, "cm7", &s->cm7, TYPE_ARMV7M);
 
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
@@ -286,6 +292,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     FslImx8mpState *s = FSL_IMX8MP(dev);
     DeviceState *gicdev = DEVICE(&s->gic);
     const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
+    qemu_irq spi_irq[FSL_IMX8MP_NUM_IRQS];
     int i;
 
     for (i = 0; i < FSL_IMX8MP_NUM_A53; i++) {
@@ -407,6 +414,15 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_IRQS; i++) {
+        DeviceState *splitter = DEVICE(&s->cpu_irq_splitter[i]);
+        qdev_prop_set_uint16(splitter, "num-lines", 2);
+        qdev_realize(splitter, NULL, &error_abort);
+        spi_irq[i] = qdev_get_gpio_in(splitter, 0);
+        qdev_connect_gpio_out(splitter, 0,
+                              qdev_get_gpio_in(gicdev, i));
+    }
+
     /* CCM */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
@@ -440,7 +456,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           qdev_get_gpio_in(gicdev, serial_table[i].irq));
+                           spi_irq[serial_table[i].irq]);
     }
 
     /* GPC */
@@ -482,6 +498,11 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         }
 
         arm_set_cpu_off(arm_cpu_mp_affinity(s->cm7.cpu));
+
+        for (i = 0; i < FSL_IMX8MP_NUM_IRQS; i++) {
+            qdev_connect_gpio_out(DEVICE(&s->cpu_irq_splitter[i]), 1,
+                                  qdev_get_gpio_in(DEVICE(&s->cm7), i));
+        }
     }
 
     qdev_prop_set_uint32(DEVICE(&s->src), "cm7-vector-base",
@@ -508,7 +529,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_connect_gpio_out(DEVICE(&s->gpt5_gpt6_irq), 0,
-                          qdev_get_gpio_in(gicdev, FSL_IMX8MP_GPT5_GPT6_IRQ));
+                          spi_irq[FSL_IMX8MP_GPT5_GPT6_IRQ]);
 
     for (i = 0; i < FSL_IMX8MP_NUM_GPTS; i++) {
         hwaddr gpt_addrs[FSL_IMX8MP_NUM_GPTS] = {
@@ -537,7 +558,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
             };
 
             sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
-                               qdev_get_gpio_in(gicdev, gpt_irqs[i]));
+                               spi_irq[gpt_irqs[i]]);
         } else {
             int irq = i - FSL_IMX8MP_NUM_GPTS + 2;
 
@@ -572,7 +593,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     }
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mu[0].a), 0,
-                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_MU1_A_IRQ));
+                       spi_irq[FSL_IMX8MP_MU1_A_IRQ]);
 
     /* I2Cs */
     for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
@@ -594,7 +615,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
-                           qdev_get_gpio_in(gicdev, i2c_table[i].irq));
+                           spi_irq[i2c_table[i].irq]);
     }
 
     /* GPIOs */
@@ -641,9 +662,9 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
-                           qdev_get_gpio_in(gicdev, gpio_table[i].irq_low));
+                           spi_irq[gpio_table[i].irq_low]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
-                           qdev_get_gpio_in(gicdev, gpio_table[i].irq_high));
+                           spi_irq[gpio_table[i].irq_high]);
     }
 
     /* USDHCs */
@@ -663,7 +684,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, usdhc_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
-                           qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
+                           spi_irq[usdhc_table[i].irq]);
     }
 
     /* USBs */
@@ -684,7 +705,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0, usb_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i].sysbus_xhci), 0,
-                           qdev_get_gpio_in(gicdev, usb_table[i].irq));
+                           spi_irq[usb_table[i].irq]);
     }
 
     /* ECSPIs */
@@ -704,7 +725,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                           qdev_get_gpio_in(gicdev, spi_table[i].irq));
+                           spi_irq[spi_table[i].irq]);
     }
 
     /* ENET1 */
@@ -718,9 +739,9 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->enet), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_ENET1].addr);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
-                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_ENET1_MAC_IRQ));
+                       spi_irq[FSL_IMX8MP_ENET1_MAC_IRQ]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
-                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+                       spi_irq[FSL_IMX6_ENET1_MAC_1588_IRQ]);
 
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
@@ -748,7 +769,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, wdog_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                           qdev_get_gpio_in(gicdev, wdog_table[i].irq));
+                           spi_irq[wdog_table[i].irq]);
     }
 
     /* PCIe */
@@ -759,15 +780,15 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                     fsl_imx8mp_memmap[FSL_IMX8MP_PCIE1].addr);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0,
-                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_PCI_INTA_IRQ));
+                       spi_irq[FSL_IMX8MP_PCI_INTA_IRQ]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1,
-                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_PCI_INTB_IRQ));
+                       spi_irq[FSL_IMX8MP_PCI_INTB_IRQ]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2,
-                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_PCI_INTC_IRQ));
+                       spi_irq[FSL_IMX8MP_PCI_INTC_IRQ]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3,
-                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_PCI_INTD_IRQ));
+                       spi_irq[FSL_IMX8MP_PCI_INTD_IRQ]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 4,
-                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_PCI_MSI_IRQ));
+                       spi_irq[FSL_IMX8MP_PCI_MSI_IRQ]);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy), errp)) {
         return;
@@ -800,7 +821,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
                         flexcan_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
-                           qdev_get_gpio_in(gicdev, flexcan_table[i].irq));
+                           spi_irq[flexcan_table[i].irq]);
     }
 
     /* On-Chip RAM */
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index e8d84f82b5..1685938a0b 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -25,6 +25,7 @@
 #include "hw/net/flexcan.h"
 #include "hw/net/imx_fec.h"
 #include "hw/core/or-irq.h"
+#include "hw/core/split-irq.h"
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
@@ -93,6 +94,7 @@ struct FslImx8mpState {
     FslImx8mPciePhyState   pcie_phy;
     FlexcanState       flexcan[FSL_IMX8MP_NUM_CANS];
     OrIRQState         gpt5_gpt6_irq;
+    SplitIRQ           cpu_irq_splitter[FSL_IMX8MP_NUM_IRQS];
     MemoryRegion       ocram;
     MemoryRegion       itcm;
     MemoryRegion       dtcm;
-- 
2.34.1


