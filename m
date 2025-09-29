Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0796BCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H99-0005vI-2o; Mon, 29 Sep 2025 12:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8E-0003WY-4x
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H85-0002uQ-4r
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahlIDfeDVUpHhDrjEgVTd7H1oIb9R2fpsphOku2d9D4=;
 b=TsrG8/YXgfYwjvQ3TASpMhOKd8vLxIy1cFHMt31aqd2M8bdDvzysE4OX3AXLHSgrRwPP/X
 9nkw25j7N7zJvDxsYrJPlnpqpPOj1YDT8ON2QjFKEGCBshuPOUIa818Eb0s0HoP0Mfo1ik
 ha5MBViwzycAXTMY94Ie6NCuGMTILDI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-8DvbaqLcNcKZ_toZgyksYg-1; Mon,
 29 Sep 2025 12:53:33 -0400
X-MC-Unique: 8DvbaqLcNcKZ_toZgyksYg-1
X-Mimecast-MFC-AGG-ID: 8DvbaqLcNcKZ_toZgyksYg_1759164812
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96750195609F; Mon, 29 Sep 2025 16:53:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F30CA1800446; Mon, 29 Sep 2025 16:53:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/32] hw/arm/aspeed_ast27x0: Introduce 3 PCIe RCs for AST2700
Date: Mon, 29 Sep 2025 18:52:23 +0200
Message-ID: <20250929165230.797471-26-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add PCIe Root Complex support to the AST2700 SoC model.

The AST2700 A1 silicon revision provides three PCIe Root Complexes:

PCIe0 with its PHY at 0x12C15000, config (H2X) block at 0x120E0000,
MMIO window at 0x60000000, and GIC IRQ 56.

PCIe1 with its PHY at 0x12C15800, config (H2X) block at 0x120F0000,
MMIO window at 0x80000000, and GIC IRQ 57.

PCIe2 with its PHY at 0x14C1C000, config (H2X) block at 0x140D0000,
MMIO window at 0xA0000000, and IRQ routed through INTC4 bit 31
mapped to GIC IRQ 196.

Each RC instantiates a PHY device, a PCIe config (H2X) bridge, and an MMIO
alias region. The per-RC MMIO alias size is 0x20000000. The AST2700 A0
silicon revision does not support PCIe Root Complexes, so pcie_num is set
to 0 in that variant.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250919093017.338309-13-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  1 +
 hw/arm/aspeed_ast27x0.c     | 74 +++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index a0cf43377507..aaf518d1799e 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -186,6 +186,7 @@ struct AspeedSoCClass {
     uint32_t silicon_rev;
     uint64_t sram_size;
     uint64_t secsram_size;
+    int pcie_num;
     int spis_num;
     int ehcis_num;
     int wdts_num;
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 6aa3841b6911..853339119ff6 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -38,6 +38,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_EHCI2]     =  0x12063000,
     [ASPEED_DEV_HACE]      =  0x12070000,
     [ASPEED_DEV_EMMC]      =  0x12090000,
+    [ASPEED_DEV_PCIE0]     =  0x120E0000,
+    [ASPEED_DEV_PCIE1]     =  0x120F0000,
     [ASPEED_DEV_INTC]      =  0x12100000,
     [ASPEED_GIC_DIST]      =  0x12200000,
     [ASPEED_GIC_REDIST]    =  0x12280000,
@@ -45,6 +47,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_SCU]       =  0x12C02000,
     [ASPEED_DEV_RTC]       =  0x12C0F000,
     [ASPEED_DEV_TIMER1]    =  0x12C10000,
+    [ASPEED_DEV_PCIE_PHY0] =  0x12C15000,
+    [ASPEED_DEV_PCIE_PHY1] =  0x12C15800,
     [ASPEED_DEV_SLI]       =  0x12C17000,
     [ASPEED_DEV_UART4]     =  0x12C1A000,
     [ASPEED_DEV_IOMEM1]    =  0x14000000,
@@ -59,6 +63,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_ETH2]      =  0x14060000,
     [ASPEED_DEV_ETH3]      =  0x14070000,
     [ASPEED_DEV_SDHCI]     =  0x14080000,
+    [ASPEED_DEV_PCIE2]     =  0x140D0000,
     [ASPEED_DEV_EHCI3]     =  0x14121000,
     [ASPEED_DEV_EHCI4]     =  0x14123000,
     [ASPEED_DEV_ADC]       =  0x14C00000,
@@ -66,6 +71,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_GPIO]      =  0x14C0B000,
     [ASPEED_DEV_I2C]       =  0x14C0F000,
     [ASPEED_DEV_INTCIO]    =  0x14C18000,
+    [ASPEED_DEV_PCIE_PHY2] =  0x14C1C000,
     [ASPEED_DEV_SLIIO]     =  0x14C1E000,
     [ASPEED_DEV_VUART]     =  0x14C30000,
     [ASPEED_DEV_UART0]     =  0x14C33000,
@@ -81,6 +87,9 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_UART11]    =  0x14C33A00,
     [ASPEED_DEV_UART12]    =  0x14C33B00,
     [ASPEED_DEV_WDT]       =  0x14C37000,
+    [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
+    [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
+    [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
     [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
     [ASPEED_DEV_LTPI]      =  0x300000000,
     [ASPEED_DEV_SDRAM]     =  0x400000000,
@@ -156,6 +165,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_DP]        = 28,
     [ASPEED_DEV_EHCI1]     = 33,
     [ASPEED_DEV_EHCI2]     = 37,
+    [ASPEED_DEV_PCIE0]     = 56,
+    [ASPEED_DEV_PCIE1]     = 57,
     [ASPEED_DEV_LPC]       = 192,
     [ASPEED_DEV_IBT]       = 192,
     [ASPEED_DEV_KCS]       = 192,
@@ -166,6 +177,7 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_WDT]       = 195,
     [ASPEED_DEV_PWM]       = 195,
     [ASPEED_DEV_I3C]       = 195,
+    [ASPEED_DEV_PCIE2]     = 196,
     [ASPEED_DEV_UART0]     = 196,
     [ASPEED_DEV_UART1]     = 196,
     [ASPEED_DEV_UART2]     = 196,
@@ -233,6 +245,7 @@ static const int ast2700_gic132_gic196_intcmap[] = {
     [ASPEED_DEV_UART12]    = 18,
     [ASPEED_DEV_EHCI3]     = 28,
     [ASPEED_DEV_EHCI4]     = 29,
+    [ASPEED_DEV_PCIE2]     = 31,
 };
 
 /* GICINT 133 */
@@ -519,6 +532,17 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);
     object_initialize_child(obj, "hace", &s->hace, typename);
+
+    for (i = 0; i < sc->pcie_num; i++) {
+        snprintf(typename, sizeof(typename), "aspeed.pcie-phy-%s", socname);
+        object_initialize_child(obj, "pcie-phy[*]", &s->pcie_phy[i], typename);
+        object_property_set_int(OBJECT(&s->pcie_phy[i]), "id", i, &error_abort);
+
+        snprintf(typename, sizeof(typename), "aspeed.pcie-cfg-%s", socname);
+        object_initialize_child(obj, "pcie-cfg[*]", &s->pcie[i], typename);
+        object_property_set_int(OBJECT(&s->pcie[i]), "id", i, &error_abort);
+    }
+
     object_initialize_child(obj, "dpmcu", &s->dpmcu,
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "ltpi", &s->ltpi,
@@ -610,6 +634,49 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
     return true;
 }
 
+static bool aspeed_soc_ast2700_pcie_realize(DeviceState *dev, Error **errp)
+{
+    AspeedSoCState *s = ASPEED_SOC(dev);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    MemoryRegion *mmio_mr = NULL;
+    char name[64];
+    qemu_irq irq;
+    int i;
+
+    for (i = 0; i < sc->pcie_num; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy[i]), errp)) {
+            return false;
+        }
+        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie_phy[i]), 0,
+                        sc->memmap[ASPEED_DEV_PCIE_PHY0 + i]);
+
+        object_property_set_int(OBJECT(&s->pcie[i]), "dram-base",
+                                sc->memmap[ASPEED_DEV_SDRAM],
+                                &error_abort);
+        object_property_set_link(OBJECT(&s->pcie[i]), "dram",
+                                 OBJECT(s->dram_mr), &error_abort);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie[i]), errp)) {
+            return false;
+        }
+        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie[i]), 0,
+                        sc->memmap[ASPEED_DEV_PCIE0 + i]);
+        irq = aspeed_soc_get_irq(s, ASPEED_DEV_PCIE0 + i);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie[i].rc), 0, irq);
+
+        mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie[i].rc), 1);
+        snprintf(name, sizeof(name), "aspeed.pcie-mmio.%d", i);
+        memory_region_init_alias(&s->pcie_mmio_alias[i], OBJECT(&s->pcie[i].rc),
+                                 name, mmio_mr,
+                                 sc->memmap[ASPEED_DEV_PCIE_MMIO0 + i],
+                                 0x20000000);
+        memory_region_add_subregion(s->memory,
+                                    sc->memmap[ASPEED_DEV_PCIE_MMIO0 + i],
+                                    &s->pcie_mmio_alias[i]);
+    }
+
+    return true;
+}
+
 static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
 {
     int i;
@@ -936,6 +1003,11 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
 
+    /* PCIe Root Complex (RC) */
+    if (!aspeed_soc_ast2700_pcie_realize(dev, errp)) {
+        return;
+    }
+
     aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->dpmcu),
                                   "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
@@ -974,6 +1046,7 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, const void *data)
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2700_A0_SILICON_REV;
     sc->sram_size    = 0x20000;
+    sc->pcie_num     = 0;
     sc->spis_num     = 3;
     sc->ehcis_num    = 2;
     sc->wdts_num     = 8;
@@ -1002,6 +1075,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev  = AST2700_A1_SILICON_REV;
     sc->sram_size    = 0x20000;
+    sc->pcie_num     = 3;
     sc->spis_num     = 3;
     sc->ehcis_num    = 4;
     sc->wdts_num     = 8;
-- 
2.51.0


