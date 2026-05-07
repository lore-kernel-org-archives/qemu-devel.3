Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E401CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL125-0005qu-LM; Thu, 07 May 2026 11:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL123-0005nK-20
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL121-00043E-E8
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so9005185e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169176; x=1778773976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g3Ne1jJeN18OBsdPIflujrejDJaHthbKJQHwQQvf22Q=;
 b=fWtIzvFEraOjYz2flSEWZin3W3a9g61A2kIaT62yHx3zIU2FhbIcsWsi/vIddpFpe8
 AKrDtBjrRkqF4dGptdPZJvcUkOgQD1H02m8HmC8BiDqFzLvWf/CyQ1akkjyEzY/Ayx6R
 Z2TD+wZ5up9ifbzN/6udAo6kazZ90+k/HGRvl/szVav1vw31B1PeTclWxOezbw0bCToi
 vwWhdS6/b0DngYuqfmKbpsVM3JF2XnZdd2GsJ9ELoSXt9SLoKM5kVvWnP9ekrsUMCK42
 pCDTt9LmFya2RUySPXUkaixIkCRqySj7Vxvt+UF0KLmpjHNy3M5Ji7vIgQgbOlJmG/Es
 OgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169176; x=1778773976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g3Ne1jJeN18OBsdPIflujrejDJaHthbKJQHwQQvf22Q=;
 b=CqFWVtq+B9O9LPs+ZsVvsJcI+1bbxAWISqoIGdoUCPhfocga2WDbUfetm4hDu7UNhT
 o8F8/91G+Go7FzR607hvRD/Ohf6dYhFGUgABmZ+YEZ6I+Rm4ri71Lbp+Ij9/DlpmeEnj
 7MOBHQ+Rp1YPde74ELG0NipdpebvmaNPn8SV60bZqS63iCmcJSL8PjErvWXVv/9MHH3Q
 uTpHKAMwU5k2SsvvKCkPWsXYbL66wgDzgnaE9EE4sY0nDX4ZtSjdBziKNvt+qIkVTSQn
 NIHf4wwcR8KdGUy18I+9W4rvTp+S7C65q+QCJ5EOiOoqOqzRIoWj8n565Sc0Q6Zg92IT
 Iq+g==
X-Gm-Message-State: AOJu0YzKqjLIVdGvR5pRmbBunB5O5JEGPvq9gqjj1lF1MgLGTbVRUVAD
 lKr6RXDNLIJcfDHlV1wQdrHZwSefL8K++P0gcob9G+AYCVceAy6bKXpui0JQc3sPrA8gq4OmrJV
 Zq+U8
X-Gm-Gg: AeBDiesJhwKHbAJLKF7NG3+WKHua5rDAMT0qKqGj/ULq/WTBsj1mKeybgyHB/Px4Z2y
 0qdwH5SNP4rg7xeFNmqZORGvkz4tVQcDTwu3ou2QX2KWdG5VqlwbeishvRvUpiRE0302TxCqsBg
 4pD4atpGAZVNAZDkkL/JtUBGxgUnoLP+lWPw60KJnFUKvo7JfqHM/R45d+Br0Wa3c1PrzVwjDzP
 dvG8N7jsHEh0a5iJ75/0i5k6ZZjFbCKysbxdQQHtQJPAGqI/ReMgGyB9Tec0Js0B8psGQSlT0lh
 uqNVzycJ4yDyrVNJylrukIIChcggNNK9FqlDUBcAvGQ9jzYW7ozU1a1UvgCaTIiBEFnGNqIliHr
 nVEs9SAZZldfL2IKF4kKfiI+O2DFQso2qGfHAAzeCxTduGT+JpEu+ueDFRNtFfxhWrRBWprN3Kp
 xirroz1jH3Py8eEBLz84w9WgraCyvUwn+XbFnU040DlFeXgIu5IlS1B6KgwmbEdyKmbyvJ7LswK
 D2Kxxyq+n2N9768
X-Received: by 2002:a05:600c:8b0c:b0:48a:7a10:4f47 with SMTP id
 5b1f17b1804b1-48e51e0a620mr146365155e9.3.1778169175914; 
 Thu, 07 May 2026 08:52:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/67] hw/arm/virt: Handle GICv5 in interrupt bindings for PPIs
Date: Thu,  7 May 2026 16:51:49 +0100
Message-ID: <20260507155154.1886557-63-peter.maydell@linaro.org>
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

The GICv5 devicetree binding specifies the "interrupts" property
differently to GICv2 and GICv3 for PPIs: the first field is the
architectural INTID.TYPE, and the second is the architectural
INTID.ID.  (The third field defining the level/edge trigger mode has
the same values for GICv5 as it did for the older GICs.)

In the places in the virt board where we wire up PPIs (the timer and
the PMU), handle the GICv5:

 * use the architectural constant GICV5_PPI for the type
 * use the architected GICv5 PPI numbers for the interrupt sources
   (which differ from the old ones and don't need to be adjusted via
   INTID_TO_PPI())
 * leave the irqflags as-is

Add some commentary in our include/hw/arm/fdt.h file about what the
the constants defined there are valid for.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-63-peter.maydell@linaro.org
---
 hw/arm/virt.c        | 23 +++++++++++++++++++----
 include/hw/arm/fdt.h | 10 ++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3caba6e5d3..09474c55d1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -500,7 +500,15 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
                                 "arm,armv7-timer");
     }
     qemu_fdt_setprop(ms->fdt, "/timer", "always-on", NULL, 0);
-    if (vms->ns_el2_virt_timer_irq) {
+    if (vms->gic_version == VIRT_GIC_VERSION_5) {
+        /* The GICv5 architects the PPI numbers differently */
+        qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
+                               GICV5_PPI, GICV5_PPI_CNTPS, irqflags,
+                               GICV5_PPI, GICV5_PPI_CNTP, irqflags,
+                               GICV5_PPI, GICV5_PPI_CNTV, irqflags,
+                               GICV5_PPI, GICV5_PPI_CNTHP, irqflags,
+                               GICV5_PPI, GICV5_PPI_CNTHV, irqflags);
+    } else if (vms->ns_el2_virt_timer_irq) {
         qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
                                GIC_FDT_IRQ_TYPE_PPI,
                                INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ), irqflags,
@@ -1025,11 +1033,18 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
     qemu_fdt_add_subnode(ms->fdt, "/pmu");
     if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
         const char compat[] = "arm,armv8-pmuv3";
+
         qemu_fdt_setprop(ms->fdt, "/pmu", "compatible",
                          compat, sizeof(compat));
-        qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
-                               GIC_FDT_IRQ_TYPE_PPI,
-                               INTID_TO_PPI(VIRTUAL_PMU_IRQ), irqflags);
+        if (vms->gic_version == VIRT_GIC_VERSION_5) {
+            qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
+                                   GICV5_PPI, GICV5_PPI_PMUIRQ, irqflags);
+        } else {
+            qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
+                                   GIC_FDT_IRQ_TYPE_PPI,
+                                   INTID_TO_PPI(VIRTUAL_PMU_IRQ),
+                                   irqflags);
+        }
     }
 }
 
diff --git a/include/hw/arm/fdt.h b/include/hw/arm/fdt.h
index c3d5015013..995652c27a 100644
--- a/include/hw/arm/fdt.h
+++ b/include/hw/arm/fdt.h
@@ -20,9 +20,19 @@
 #ifndef QEMU_ARM_FDT_H
 #define QEMU_ARM_FDT_H
 
+/*
+ * These are for GICv2/v3/v4 only; GICv5 encodes the interrupt type in
+ * the DTB "interrupts" properties differently, using constants that
+ * match the architectural INTID.Type. In QEMU those are available as
+ * the GICV5_PPI and GICV5_SPI enum values in arm_gicv5_types.h.
+ */
 #define GIC_FDT_IRQ_TYPE_SPI 0
 #define GIC_FDT_IRQ_TYPE_PPI 1
 
+/*
+ * The trigger type/level field in the DTB "interrupts" property has
+ * the same encoding for GICv2/v3/v4 and v5.
+ */
 #define GIC_FDT_IRQ_FLAGS_EDGE_LO_HI 1
 #define GIC_FDT_IRQ_FLAGS_EDGE_HI_LO 2
 #define GIC_FDT_IRQ_FLAGS_LEVEL_HI 4
-- 
2.43.0


