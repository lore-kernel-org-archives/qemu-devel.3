Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF3ACD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL126-0005s7-9Q; Thu, 07 May 2026 11:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL124-0005o6-0q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:53:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL122-00043U-9B
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso9363485e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169177; x=1778773977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A2rbZVeHCOSUq1JlEYVxVfCFNJM+6hAsFXZx0ftnNdg=;
 b=sID4SS0T6x5qa8RLPbHvwIkVi2OKSPGcZ8t7nqzPFrpeshZMX9e4Gk/ex0i/ITmTi4
 s1BYePi93r14CSC+7pnEAey8cnS4S3oczAn0cRTYuhVI351BbYLEAlTUqYjj0ArYLDMH
 fs4EqQQaes2UomB8P2cVewCUzlCQtY/hDRepwoCajR/lTWrjvCrFn4kXd/A1t1NGggKn
 6Yi/RtJ3ocu3UjKIR4yqDlc4Dqszs2xQyuNrf6bF7no6DGzkWWIPvwsw/YFJdbUkNzLd
 RQJh8WWlR3ge4rUMZnNI5Y1TRnraJ7q+ezXbJGJraL5Sfi79Er0kp5GD+ah5jHuM/7Kd
 guNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169177; x=1778773977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A2rbZVeHCOSUq1JlEYVxVfCFNJM+6hAsFXZx0ftnNdg=;
 b=sOmTH7iAp4Jxj/25xaJnYhap1n/KqKZiOX4Wz7T7SrH0tf2DVaFiF3zuAjGRMJNTnV
 qGfkhy3SH7dZI/nOmKS8EQkUfuMj13cjFOgtBebvXEy9Pr2vIJLlGsD6CeDN8Um10URu
 sha/0dNrvuo17vk+eHDKgWhYidImvPiFsnUzb4uKGRsD5z+tbx+iVZiifkiT0r3PjVrZ
 v4EUHRRrfuF8Hb6b6SIwrGd+HsTMTkg/OEEvtli28SnzxjjDfdSq2k5IYPitiX5xrxTF
 PsFSiosSK00cNxku2U9NBUrIFrKYF4wU0TOk14hgEkkTx5g/+mKBV1Z5Vdifb21QGUF8
 yf7g==
X-Gm-Message-State: AOJu0YzLh2Z8YpYfB9pXW+aDfi+tupo8/+wGyS2DJ2CScf6o1AKZkI1t
 le7U6afHO84GGOxx6OP7mO2grb2tVxc4poLTY6SB0Vfb3w+Jr699oH9f1yKOaCvT/pTEEzrH9w/
 BXB78
X-Gm-Gg: AeBDietAqkAIGflF0I7spQNZGkiH3Yb4Yb+XbBXRAai9kAry0UFRJtf5vXYKL8Mz20V
 EAGMNfe5EcDsnbnADgju+KSw1ghc0ZMQGvlwNV4lRQlTmEbCseL6sLVozS2f+hEHfQ/yoMHIebJ
 FOD2DJPJoND7CKRXnJjd2BwAbIvoaj1YFH1t4iaWtGVJLrh7pQPkAhJ0TSXUv7cLQ8ht7h2C5Mr
 257gKxBJQy9MOarO4IsjQNtkKR0Qtu7Mripo15EPx65LjHvg0Na5yHjlkUXiYnlO6Ck6FrYF/4o
 BlOJ9Al2L7pIMlRw9Cy1ulGYkCZpp5y+S4QITvtymYp5I21q3UnkMYj6eKVY13mNX9TkSB8cKKH
 ukSZg/giwLTApgycluiYtuxbQ7qC0HKF/Gr9TCn8GgcqxkWrvfZMi9vVSnApIY86e9V77ejUItC
 vIxNv+mnbft+oBJqqAJgZNu3ZEufyKEWQg9hX++vSZJMXqWvNc2yuXNEPbLq6sfWRVqauNN7X4J
 FmighBtra1xzhwUchhK7g5gz/QlTSA=
X-Received: by 2002:a05:600c:4e0c:b0:48a:54a6:b29f with SMTP id
 5b1f17b1804b1-48e51f2f793mr144296915e9.17.1778169176781; 
 Thu, 07 May 2026 08:52:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 63/67] hw/arm/virt: Use correct interrupt type for GICv5 SPIs
 in the DTB
Date: Thu,  7 May 2026 16:51:50 +0100
Message-ID: <20260507155154.1886557-64-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Message-id: 20260327111700.795099-64-peter.maydell@linaro.org
---
 hw/arm/virt.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 09474c55d1..7da92e7746 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -375,6 +375,16 @@ unsigned int virt_get_caches(const VirtMachineState *vms, CPUCoreCaches *caches)
     return num_cache;
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
@@ -1510,7 +1520,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                      2, base, 2, size);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               gic_fdt_irq_type_spi(vms), irq,
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "clocks",
                                vms->clock_phandle, vms->clock_phandle);
@@ -1552,7 +1562,7 @@ static void create_rtc(const VirtMachineState *vms)
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base, 2, size);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                           GIC_FDT_IRQ_TYPE_SPI, irq,
+                           gic_fdt_irq_type_spi(vms), irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
     qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
@@ -1671,7 +1681,7 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
     qemu_fdt_setprop_cell(ms->fdt, nodename, "#gpio-cells", 2);
     qemu_fdt_setprop(ms->fdt, nodename, "gpio-controller", NULL, 0);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                           GIC_FDT_IRQ_TYPE_SPI, irq,
+                           gic_fdt_irq_type_spi(vms), irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
     qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
@@ -1752,7 +1762,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
         qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                      2, base, 2, size);
         qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               gic_fdt_irq_type_spi(vms), irq,
                                GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
         qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
         g_free(nodename);
@@ -1952,10 +1962,11 @@ static void create_pcie_irq_map(const MachineState *ms,
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
@@ -1996,10 +2007,10 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
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


