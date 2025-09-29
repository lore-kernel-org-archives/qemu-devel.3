Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AD1CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H93-0005bS-BF; Mon, 29 Sep 2025 12:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H83-0003Aj-9v
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7x-0002sN-OP
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjUUHHNcZxiZuqkZCcmbvxeBuUGZmKnaqGvTcwPCnMI=;
 b=I2bJFHrwM63C2xSlSuB6uRbDlKs44a0m1WYWpkqqT0waNu2V291v7DZRZ60QJgZqBDbbP4
 rpI3BTE02P8XWXMSTLQw2Mi5AD5qcnqTfCCBAiRLTTj1sKCUCAfE7jeV2QfCUBmjS6NhP7
 37afl7hKlsayiX/OtdEdSKSfBaw4yqk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-J3kpDFXoNaGoa2ww0PS7Qg-1; Mon,
 29 Sep 2025 12:53:24 -0400
X-MC-Unique: J3kpDFXoNaGoa2ww0PS7Qg-1
X-Mimecast-MFC-AGG-ID: J3kpDFXoNaGoa2ww0PS7Qg_1759164804
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D76ED1956055; Mon, 29 Sep 2025 16:53:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23BC91800446; Mon, 29 Sep 2025 16:53:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/32] hw/arm/aspeed_ast2600: Add PCIe RC support (RC_H only)
Date: Mon, 29 Sep 2025 18:52:19 +0200
Message-ID: <20250929165230.797471-22-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

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
Link: https://lore.kernel.org/qemu-devel/20250919093017.338309-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  1 +
 hw/arm/aspeed_ast2600.c     | 74 +++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 79fe353f83b0..a0cf43377507 100644
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
index 59ffd41a4ab0..03e5df96bb4f 100644
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
2.51.0


