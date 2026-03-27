Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0334C10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65EB-0003Ed-Ii; Fri, 27 Mar 2026 07:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Cb-0007qY-TD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:09 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CX-0000Hh-Sf
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:09 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b7c2788dso1186502f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610282; x=1775215082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVpl4q4Ew+AJPdH2wb74AVCkix8tQh3kXY3l2KghFQY=;
 b=W1BOGURdIr9YoqmLB/mtIQnBr9YBAhED60FgNcYiV/83dGa6RPMDRmFZcAKVrK9cDK
 F8v9HQAIpTt0B8qembESSDYFMGjpNdNkFyWRrmRoyNePXAX1ofc621IleNfke8sv7QfC
 BDq4cqmZpdxhOZhTXJ9BY6U627G1St0sZBPkSO8LAxIPj6bf9SbQislI7BV3SjXGQROq
 CImRCxhKcts1H7pV9BYowadPxq9NDMY3oQUzK+6bUGlANN/GUQ9oQqfxxTw0V4+6JBcI
 EbnPjHID0Fl8YdD9LSopYb/V99T9U4GfmBoF3C2ye/HBiYBgmh4DS6jkA/A7JC1WZmEh
 +LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610282; x=1775215082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qVpl4q4Ew+AJPdH2wb74AVCkix8tQh3kXY3l2KghFQY=;
 b=Bz+oHJztTZl9Y2sVIVpcH0TPN6qBas/N/v8MhdweQFm3QKAoWIFeIdVwjMAAsoj7+2
 uGuq/bTeP8O558C2rGa7dbnSbAnJnz7ZWEpwqz3Pw+euYR8xBbMQmZ9pU2qmSKhExha6
 vyt3BL9WN0JlrvwHu279QhESzYCiTBbdBOIMG1wETfNh2BMTK5vDULbVYySxM3cHkrFJ
 ctzJqaKD2/n200toO8486SDGOuB1q00oZQm2eCYRK0BrU7kAfzg13qfHD39wWPZgJPix
 O3XbO/kMQTmjEyWi2eCDwKdLY7rwUndNCdPVUM1K1VbD/StZbo/g+gRZsNobPXDKf9Pv
 7TQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkYg11bX7DEYDoc6x4W/RBGRoXLZVu5jRio4SIO8beF2qc/fbgowbAGA8Ke/h9opRAuDLxTk+HDZ/h@nongnu.org
X-Gm-Message-State: AOJu0YznaO0u8sovkZkVgXWJ6FB1n3Ww6Ac94L3Sh3GFQ0HDsVs09IQK
 TbzK4Y+7TkXRiNfxXtIt9mtCsOtBvgFwJuUGD+vn1QHc9McOpIuL/jhLIA1a+bKFr5nIQYWmPrB
 ytZ7D7FE=
X-Gm-Gg: ATEYQzwe/jFuK+PK/Umb9tsjoB5jVDvkspOS4P82MMcVscm2uoCtqLIGHLzY/KNFye9
 gPhkZbAZv7M7a6grneBJ1E6OvPPMlNueq1sZPrWZxLv233OGhyPxeHNSlSMFgubhrlqVB4dYqi6
 xZsVI/91RtxF1Z0ojmi/06CKL3X5R9MXma/XJsRxKuSU9p97yA5gMLqq8RpXJJNoHJtsoLZjNxR
 u/dO8FzHPAYTpjL0iBcRLuMyhWnFhmqDglodgD06e+4jyPgMMjM9cwP7W3RDwPRegyFf5bMP8ep
 cmAtbC/fvHhDihhapo0agIb1x0eGThpxATvWzBEz0vyX+7LnNS9iw4eARTDGPk3U0DFNhw0qEEw
 gdioTbbGhYUTkaeOznpYJZpSa8X75zmn9Jhw2XeSG9HraqZIr3xinJh8SLmXOR10dD0c8QAwXUm
 785MJfgXY6JxSDfPlnQA683X4PzCpbPAu22Uy0yFrOoddaefGJxy3H7ezBMrlpSVVyhj5kMFEdr
 4rbhjaxOCqjdRMeKZzP8nTjLJVsQqQ=
X-Received: by 2002:a05:6000:4212:b0:439:cb10:dfcd with SMTP id
 ffacd0b85a97d-43b9ea623eamr3195847f8f.39.1774610282128; 
 Fri, 27 Mar 2026 04:18:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:18:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 63/65] hw/arm/virt: Use correct interrupt type for GICv5
 SPIs in the DTB
Date: Fri, 27 Mar 2026 11:16:58 +0000
Message-ID: <20260327111700.795099-64-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

The GICv5 devicetree binding specifies that the "interrupts" property
for devices connected to it should use the architectural INTID.TYPE
values to specify whether the interrupt is an SPI, LPI or PPI.  This
is different to the GICv2 and GICv3, so instead of hardcoding the
GIC_FDT_IRQ_TYPE_SPI constant when we create "interrupts" bindings,
create a new function gic_fdt_irq_type_spi() that returns the right
value for the interrupt controller in use.

For SPIs, the INTID.ID and the trigger-mode fields of the
"interrupts" property remain the same for GICv5 and the older GIC
versions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/arm/virt.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bc49cf244f..15d833ad8f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -295,6 +295,16 @@ static bool ns_el2_virt_timer_present(void)
         arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
 }
 
+/*
+ * The correct value to use in a DTB "interrupts" property for an SPI
+ * depends on the GIC version.
+ */
+static int gic_fdt_irq_type_spi(const VirtMachineState *vms)
+{
+    return vms->gic_version == VIRT_GIC_VERSION_5 ?
+        GICV5_SPI : GIC_FDT_IRQ_TYPE_SPI;
+}
+
 static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -1183,7 +1193,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                      2, base, 2, size);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               gic_fdt_irq_type_spi(vms), irq,
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "clocks",
                                vms->clock_phandle, vms->clock_phandle);
@@ -1225,7 +1235,7 @@ static void create_rtc(const VirtMachineState *vms)
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base, 2, size);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                           GIC_FDT_IRQ_TYPE_SPI, irq,
+                           gic_fdt_irq_type_spi(vms), irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
     qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
@@ -1344,7 +1354,7 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
     qemu_fdt_setprop_cell(ms->fdt, nodename, "#gpio-cells", 2);
     qemu_fdt_setprop(ms->fdt, nodename, "gpio-controller", NULL, 0);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                           GIC_FDT_IRQ_TYPE_SPI, irq,
+                           gic_fdt_irq_type_spi(vms), irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
     qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
@@ -1425,7 +1435,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
         qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                      2, base, 2, size);
         qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               gic_fdt_irq_type_spi(vms), irq,
                                GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
         qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
         g_free(nodename);
@@ -1625,10 +1635,11 @@ static void create_pcie_irq_map(const MachineState *ms,
     int devfn, pin;
     uint32_t full_irq_map[4 * 4 * 10] = { 0 };
     uint32_t *irq_map = full_irq_map;
+    const VirtMachineState *vms = VIRT_MACHINE(ms);
 
     for (devfn = 0; devfn <= 0x18; devfn += 0x8) {
         for (pin = 0; pin < 4; pin++) {
-            int irq_type = GIC_FDT_IRQ_TYPE_SPI;
+            int irq_type = gic_fdt_irq_type_spi(vms);
             int irq_nr = first_irq + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
             int irq_level = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
             int i;
@@ -1669,10 +1680,10 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
     qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
 
     qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
-            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+            gic_fdt_irq_type_spi(vms), irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            gic_fdt_irq_type_spi(vms), irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            gic_fdt_irq_type_spi(vms), irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            gic_fdt_irq_type_spi(vms), irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
 
     qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
                      sizeof(irq_names));
-- 
2.43.0


