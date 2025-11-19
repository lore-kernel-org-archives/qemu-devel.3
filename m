Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1348CF34AE
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 13:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLhns-0001RF-RQ; Wed, 19 Nov 2025 08:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vLhnc-0001IM-6D
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:00:40 -0500
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vLhna-0002CB-89
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:00:39 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 980B61A3BC0;
 Wed, 19 Nov 2025 14:00:33 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6125B1A0880;
 Wed, 19 Nov 2025 14:00:33 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D7FBB1800241;
 Wed, 19 Nov 2025 21:00:32 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv3 11/13] hw/arm/fsl-imx8mm: Adding support for ENET ethernet
 controller
Date: Wed, 19 Nov 2025 18:30:25 +0530
Message-Id: <20251119130027.3312971-12-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.13;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva020.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It enables emulation of ENET ethernet controller in iMX8MM
Enables testing and debugging of network dependent drivers
Added ENET MAC IRQ lines

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8mm-evk.rst |  1 +
 hw/arm/Kconfig                 |  1 +
 hw/arm/fsl-imx8mm.c            | 24 ++++++++++++++++++++++++
 hw/arm/imx8mm-evk.c            |  1 +
 include/hw/arm/fsl-imx8mm.h    |  8 ++++++++
 5 files changed, 35 insertions(+)

diff --git a/docs/system/arm/imx8mm-evk.rst b/docs/system/arm/imx8mm-evk.rst
index 96981bf27d..c8445099e8 100644
--- a/docs/system/arm/imx8mm-evk.rst
+++ b/docs/system/arm/imx8mm-evk.rst
@@ -14,6 +14,7 @@ The ``imx8mm-evk`` machine implements the following devices:
  * 4 UARTs
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
+ * 1 Ethernet Controller
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 733baea384..d41d03d728 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -634,6 +634,7 @@ config FSL_IMX8MM
     select FSL_IMX8MM_ANALOG
     select FSL_IMX8MM_CCM
     select IMX
+    select IMX_FEC
     select IMX_I2C
     select OR_IRQ
     select SDHCI
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index e5599b1c48..7be0bb8664 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -209,6 +209,8 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
     }
 
+    object_initialize_child(obj, "eth0", &s->enet, TYPE_IMX_ENET);
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -532,6 +534,21 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, spi_table[i].irq));
     }
 
+    /* ENET1 */
+    object_property_set_uint(OBJECT(&s->enet), "phy-num", s->phy_num,
+                             &error_abort);
+    object_property_set_uint(OBJECT(&s->enet), "tx-ring-num", 3, &error_abort);
+    qemu_configure_nic_device(DEVICE(&s->enet), true, NULL);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->enet), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->enet), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_ENET1].addr);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_ENET1_MAC_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
+                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
         return;
@@ -594,6 +611,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_GPIO1 ... FSL_IMX8MM_GPIO5:
         case FSL_IMX8MM_ECSPI1 ... FSL_IMX8MM_ECSPI3:
+        case FSL_IMX8MM_ENET1:
         case FSL_IMX8MM_I2C1 ... FSL_IMX8MM_I2C4:
         case FSL_IMX8MM_PCIE1:
         case FSL_IMX8MM_PCIE_PHY1:
@@ -614,10 +632,16 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static const Property fsl_imx8mm_properties[] = {
+    DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mmState, phy_num, 0),
+    DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mmState, phy_connected, true),
+};
+
 static void fsl_imx8mm_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, fsl_imx8mm_properties);
     dc->realize = fsl_imx8mm_realize;
 
     dc->desc = "i.MX 8MM SoC";
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 1366f84d4a..d57b56d1d5 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -77,6 +77,7 @@ static void imx8mm_evk_init(MachineState *machine)
     };
 
     s = FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
+    object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 6b70be81d2..356627ab82 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -17,6 +17,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mm_analog.h"
 #include "hw/misc/imx8mm_ccm.h"
+#include "hw/net/imx_fec.h"
 #include "hw/or-irq.h"
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
@@ -58,11 +59,15 @@ struct FslImx8mmState {
     IMXSPIState        spi[FSL_IMX8MM_NUM_ECSPIS];
     IMXI2CState        i2c[FSL_IMX8MM_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
+    IMXFECState        enet;
     SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
     IMX2WdtState       wdt[FSL_IMX8MM_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
+
+    uint32_t           phy_num;
+    bool               phy_connected;
 };
 
 enum FslImx8mmMemoryRegions {
@@ -216,6 +221,9 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_WDOG2_IRQ    = 79,
     FSL_IMX8MM_WDOG3_IRQ    = 10,
 
+    FSL_IMX8MM_ENET1_MAC_IRQ    = 118,
+    FSL_IMX6_ENET1_MAC_1588_IRQ = 121,
+
     FSL_IMX8MM_PCI_INTA_IRQ = 122,
     FSL_IMX8MM_PCI_INTB_IRQ = 123,
     FSL_IMX8MM_PCI_INTC_IRQ = 124,
-- 
2.34.1


