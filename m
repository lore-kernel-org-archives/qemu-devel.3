Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55A0CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOcs-0004u0-N2; Wed, 07 Oct 2026 06:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcV-0004IR-Gl; Wed, 07 Oct 2026 06:11:33 -0400
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xEOcT-0004RR-95; Wed, 07 Oct 2026 06:11:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DB24C1A0023;
 Wed,  7 Oct 2026 12:11:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A5AE51A0025;
 Wed,  7 Oct 2026 12:11:27 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AF0BC180023B;
 Wed,  7 Oct 2026 18:11:25 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv4 10/11] hw/arm: Add IRQ splitter for i.MX8MP AMP interrupt
 routing
Date: Wed,  7 Oct 2026 15:41:04 +0530
Message-Id: <20261007101105.3917771-11-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
References: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.13;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva020.nxp.com
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

Route the i.MX8MP peripheral interrupt sources through two-output
SplitIRQ devices.
Connect the first splitter output to the Cortex-A53 GIC. The second
output will be connected to the Cortex-M7 NVIC when CM7 support is
added.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 hw/arm/fsl-imx8mp.c         | 56 ++++++++++++++++++++++++-------------
 include/hw/arm/fsl-imx8mp.h |  2 ++
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 18d2b17ca8..395356bc13 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -196,6 +196,12 @@ static void fsl_imx8mp_init(Object *obj)
     FslImx8mpState *s = FSL_IMX8MP(obj);
     int i;
 
+    for (i = 0; i < FSL_IMX8MP_NUM_IRQS; i++) {
+        g_autofree char *name = g_strdup_printf("irq-splitter%d", i);
+        object_initialize_child(obj, name, &s->cpu_irq_splitter[i],
+                                TYPE_SPLIT_IRQ);
+    }
+
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
@@ -280,6 +286,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     FslImx8mpState *s = FSL_IMX8MP(dev);
     DeviceState *gicdev = DEVICE(&s->gic);
     const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
+    qemu_irq spi_irq[FSL_IMX8MP_NUM_IRQS];
     int i;
 
     if (ms->smp.cpus > FSL_IMX8MP_NUM_A53) {
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
 
     /* SRC */
@@ -472,7 +488,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_connect_gpio_out(DEVICE(&s->gpt5_gpt6_irq), 0,
-                          qdev_get_gpio_in(gicdev, FSL_IMX8MP_GPT5_GPT6_IRQ));
+                          spi_irq[FSL_IMX8MP_GPT5_GPT6_IRQ]);
 
     for (i = 0; i < FSL_IMX8MP_NUM_GPTS; i++) {
         hwaddr gpt_addrs[FSL_IMX8MP_NUM_GPTS] = {
@@ -501,7 +517,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
             };
 
             sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
-                               qdev_get_gpio_in(gicdev, gpt_irqs[i]));
+                               spi_irq[gpt_irqs[i]]);
         } else {
             int irq = i - FSL_IMX8MP_NUM_GPTS + 2;
 
@@ -536,9 +552,9 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     }
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mu[0].a), 0,
-                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_MU1_A_IRQ));
+                       spi_irq[FSL_IMX8MP_MU1_A_IRQ]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mu[0].b), 0,
-                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_MU1_B_IRQ));
+                       spi_irq[FSL_IMX8MP_MU1_B_IRQ]);
 
     /* I2Cs */
     for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
@@ -560,7 +576,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
-                           qdev_get_gpio_in(gicdev, i2c_table[i].irq));
+                           spi_irq[i2c_table[i].irq]);
     }
 
     /* GPIOs */
@@ -607,9 +623,9 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
-                           qdev_get_gpio_in(gicdev, gpio_table[i].irq_low));
+                           spi_irq[gpio_table[i].irq_low]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
-                           qdev_get_gpio_in(gicdev, gpio_table[i].irq_high));
+                           spi_irq[gpio_table[i].irq_high]);
     }
 
     /* USDHCs */
@@ -629,7 +645,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, usdhc_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
-                           qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
+                           spi_irq[usdhc_table[i].irq]);
     }
 
     /* USBs */
@@ -650,7 +666,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0, usb_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i].sysbus_xhci), 0,
-                           qdev_get_gpio_in(gicdev, usb_table[i].irq));
+                           spi_irq[usb_table[i].irq]);
     }
 
     /* ECSPIs */
@@ -670,7 +686,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                           qdev_get_gpio_in(gicdev, spi_table[i].irq));
+                           spi_irq[spi_table[i].irq]);
     }
 
     /* ENET1 */
@@ -684,9 +700,9 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
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
@@ -714,7 +730,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, wdog_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                           qdev_get_gpio_in(gicdev, wdog_table[i].irq));
+                           spi_irq[wdog_table[i].irq]);
     }
 
     /* PCIe */
@@ -725,15 +741,15 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
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
@@ -766,7 +782,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
                         flexcan_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
-                           qdev_get_gpio_in(gicdev, flexcan_table[i].irq));
+                           spi_irq[flexcan_table[i].irq]);
     }
 
     /* On-Chip RAM */
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index f547cbae42..2824f38355 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -24,6 +24,7 @@
 #include "hw/net/flexcan.h"
 #include "hw/net/imx_fec.h"
 #include "hw/core/or-irq.h"
+#include "hw/core/split-irq.h"
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
@@ -89,6 +90,7 @@ struct FslImx8mpState {
     FslImx8mPciePhyState   pcie_phy;
     FlexcanState       flexcan[FSL_IMX8MP_NUM_CANS];
     OrIRQState         gpt5_gpt6_irq;
+    SplitIRQ           cpu_irq_splitter[FSL_IMX8MP_NUM_IRQS];
     MemoryRegion       ocram;
     MemoryRegion       itcm;
     MemoryRegion       dtcm;
-- 
2.34.1


