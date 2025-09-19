Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81EACAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXTl-0004ph-Nm; Fri, 19 Sep 2025 05:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzXSu-00047U-TW; Fri, 19 Sep 2025 05:31:46 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzXSm-0001GX-9P; Fri, 19 Sep 2025 05:31:39 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 19 Sep
 2025 17:30:21 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 19 Sep 2025 17:30:21 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, <wuhaotsh@google.com>, <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 08/14] hw/arm/aspeed_ast2600: Add PCIe RC support (RC_H
 only)
Date: Fri, 19 Sep 2025 17:30:07 +0800
Message-ID: <20250919093017.338309-9-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919093017.338309-1-jamin_lin@aspeedtech.com>
References: <20250919093017.338309-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Wire up the PCIe Root Complex in the AST2600 SoC model.

According to the AST2600 firmware driver, only the RC_H controller is
supported. RC_H uses PCIe PHY1 at 0x1e6ed200 and the PCIe config (H2X)
register block at 0x1e770000. The RC_H MMIO window is mapped at
0x70000000–0x80000000. RC_L is not modeled. The RC_H interrupt is
wired to IRQ 168. Only RC_H is realized and connected to the SoC
interrupt controller.

The SoC integration initializes PCIe PHY1, instantiates a single RC
instance, wires its MMIO regions, and connects its interrupt. An alias
region is added to map the RC MMIO space into the guest physical address
space.

This provides enough functionality for firmware and guest drivers to
discover and use the AST2600 RC_H Root Complex while leaving RC_L
unimplemented.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  1 +
 hw/arm/aspeed_ast2600.c     | 74 +++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 79fe353f83..a0cf433775 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -62,6 +62,7 @@ struct AspeedSoCState {
     MemoryRegion spi_boot_container;
     MemoryRegion spi_boot;
     MemoryRegion vbootrom;
+    MemoryRegion pcie_mmio_alias[ASPEED_PCIE_NUM];
     AddressSpace dram_as;
     AspeedRtcState rtc;
     AspeedTimerCtrlState timerctrl;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index d12707f0ab..17c3ae8bb0 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -48,11 +48,13 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_DEV_XDMA]      = 0x1E6E7000,
     [ASPEED_DEV_ADC]       = 0x1E6E9000,
     [ASPEED_DEV_DP]        = 0x1E6EB000,
+    [ASPEED_DEV_PCIE_PHY1] = 0x1E6ED200,
     [ASPEED_DEV_SBC]       = 0x1E6F2000,
     [ASPEED_DEV_EMMC_BC]   = 0x1E6f5000,
     [ASPEED_DEV_VIDEO]     = 0x1E700000,
     [ASPEED_DEV_SDHCI]     = 0x1E740000,
     [ASPEED_DEV_EMMC]      = 0x1E750000,
+    [ASPEED_DEV_PCIE0]     = 0x1E770000,
     [ASPEED_DEV_GPIO]      = 0x1E780000,
     [ASPEED_DEV_GPIO_1_8V] = 0x1E780800,
     [ASPEED_DEV_RTC]       = 0x1E781000,
@@ -79,6 +81,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_DEV_FSI1]      = 0x1E79B000,
     [ASPEED_DEV_FSI2]      = 0x1E79B100,
     [ASPEED_DEV_I3C]       = 0x1E7A0000,
+    [ASPEED_DEV_PCIE_MMIO1] = 0x70000000,
     [ASPEED_DEV_SDRAM]     = 0x80000000,
 };
 
@@ -127,6 +130,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_DEV_LPC]       = 35,
     [ASPEED_DEV_IBT]       = 143,
     [ASPEED_DEV_I2C]       = 110,   /* 110 -> 125 */
+    [ASPEED_DEV_PCIE0]     = 168,
     [ASPEED_DEV_PECI]      = 38,
     [ASPEED_DEV_ETH1]      = 2,
     [ASPEED_DEV_ETH2]      = 3,
@@ -191,6 +195,10 @@ static void aspeed_soc_ast2600_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
     object_initialize_child(obj, "i2c", &s->i2c, typename);
 
+    object_initialize_child(obj, "pcie-cfg", &s->pcie[0], TYPE_ASPEED_PCIE_CFG);
+    object_initialize_child(obj, "pcie-phy[*]", &s->pcie_phy[0],
+                            TYPE_ASPEED_PCIE_PHY);
+
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
 
     snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
@@ -285,6 +293,67 @@ static uint64_t aspeed_calc_affinity(int cpu)
     return (0xf << ARM_AFF1_SHIFT) | cpu;
 }
 
+/*
+ * PCIe Root Complex (RC)
+ *
+ * H2X register space (single block 0x00-0xFF):
+ *   0x00-0x7F : shared by RC_L (PCIe0) and RC_H (PCIe1)
+ *   0x80-0xBF : RC_L only
+ *   0xC0-0xFF : RC_H only
+ *
+ * Model scope / limitations:
+ *   - Firmware supports RC_H only; this QEMU model does not support RC_L.
+ *   - RC_H uses PHY1 and the MMIO window [0x70000000, 0x80000000]
+ *     (aka MMIO1).
+ *
+ * Indexing convention (this model):
+ *   - Expose a single logical instance at index 0.
+ *   - pcie[0] -> hardware RC_H (PCIe1)
+ *   - phy[0]  -> hardware PHY1
+ *   - mmio.0 -> guest address range MMIO1: 0x70000000-0x80000000
+ *   - RC_L / PCIe0 is not created and mapped.
+ */
+static bool aspeed_soc_ast2600_pcie_realize(DeviceState *dev, Error **errp)
+{
+    Aspeed2600SoCState *a = ASPEED2600_SOC(dev);
+    AspeedSoCState *s = ASPEED_SOC(dev);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    MemoryRegion *mmio_mr = NULL;
+    qemu_irq irq;
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy[0]), errp)) {
+        return false;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie_phy[0]), 0,
+                    sc->memmap[ASPEED_DEV_PCIE_PHY1]);
+
+    object_property_set_int(OBJECT(&s->pcie[0]), "dram-base",
+                            sc->memmap[ASPEED_DEV_SDRAM],
+                            &error_abort);
+    object_property_set_link(OBJECT(&s->pcie[0]), "dram", OBJECT(s->dram_mr),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie[0]), errp)) {
+        return false;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie[0]), 0,
+                    sc->memmap[ASPEED_DEV_PCIE0]);
+
+    irq = qdev_get_gpio_in(DEVICE(&a->a7mpcore),
+                           sc->irqmap[ASPEED_DEV_PCIE0]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie[0].rc), 0, irq);
+
+    mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie[0].rc), 1);
+    memory_region_init_alias(&s->pcie_mmio_alias[0], OBJECT(&s->pcie[0].rc),
+                             "aspeed.pcie-mmio", mmio_mr,
+                             sc->memmap[ASPEED_DEV_PCIE_MMIO1],
+                             0x10000000);
+    memory_region_add_subregion(s->memory,
+                                sc->memmap[ASPEED_DEV_PCIE_MMIO1],
+                                &s->pcie_mmio_alias[0]);
+
+    return true;
+}
+
 static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 {
     int i;
@@ -438,6 +507,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
 
+    /* PCIe Root Complex (RC) */
+    if (!aspeed_soc_ast2600_pcie_realize(dev, errp)) {
+        return;
+    }
+
     /* FMC, The number of CS is set at the board level */
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
                              &error_abort);
-- 
2.43.0


