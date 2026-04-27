Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04F5FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLP7-0000qo-AA; Mon, 27 Apr 2026 08:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNP-0007nS-TO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNM-0005Tw-S1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so73659755e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294067; x=1777898867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fbBhWQytfoalSexEb/LcbiWO60wmmMN2iBOzllNIQM8=;
 b=fstvomouKDHmK7GY9blQzWwmBiNkDJjHHc2a1CgNwKIGwhsDCQRJjelwZ9uI8Sm10o
 NJaMfePV/JkpyMgahJecUB7m2XPjlE9EiAlFcrKI9WY4JDq9NuCKSldnosoOY6K41nZ+
 fgjY87fCA2UagAE6HMsudi/SPJLE4Ys4aITOwTIdooR/0DCWJzPjugz8w7aG/x4XeU5P
 5d4L6wl1yCxx+A4xfjXMKPs900e3yLBEm/j6NO6Zh760HJCEYPI3VrNet2ffVAbdyDHe
 P4L2ObiFwIlyplQmGodyVVw+fbHq3gxDTDJ1CFR1fGG/yB96TCl4W8AMEO8Dxpbq/Xew
 kd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294067; x=1777898867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fbBhWQytfoalSexEb/LcbiWO60wmmMN2iBOzllNIQM8=;
 b=awSykLSKvNYumpAbqifBXHuJTbYX+T+b3z1qMtyPbrCXmXVMvFg7lrjIeV7xSgh6MD
 CWnfBwzZ6EX5GxjhuxkM2a1hK+/zZtlp62VaQoMRYfLx7Hn1yElwhbDsxtkVbN1pJOPi
 bR1jpDksJPs97Dk8c3fbdikjOyiozS2/1kk8tyV/x9gx/qfRRldHx1ILTUoaYXmjFhaA
 cW+n4vxcauhKCJuTw48nYNwGAzkBiBMSgVBxG6qpk9KpmfSz8Cqs+k8stNJbRrg++58v
 fU1BV1bkNaykEKtWWBuM/ThlS5T7naZI33CzKUfoM0vhbdPAyKjXFuT22ZDbdS1Xsr5k
 GIfA==
X-Gm-Message-State: AOJu0YwMxFVM62jLWSbKHZfPpe41XNBQhTf+50lxBOQipk4IzfpHQML3
 7m9+fpe0lWlQy4g0Ildqrl9zln9eYFkyPltS6wFEalhedNY2zjxcCWzrRcS8TVPs6z6hnBnqALs
 BGZlJ
X-Gm-Gg: AeBDieuCnuiQOc3XtGUi58SgX8gvqoA19xlmmmCtvDgMeng0hMIpOMFhybFdqv46m4X
 mKIhjDVwU1tBNR2L9FkfaIHVzb5xyPhFSWfxwBBhfT+tRQ1BoObepvVcbgu0stDetEgqibGrBWr
 cxPtk9GB1Q2KzVIo8cgvBoI7QhJ4kHoIQ0IY5rklpaOP5WSl+7mDE8ObMQxWmYislfhayiXz9b1
 t8UcmuT5kbjSy1gdrzGaf+FTUQ4o21Jp4xnsPdBBbQENx9/MC+bVaF9gx9MVFfI3E0t/L1FjMaT
 BDrCV9h6JTUSVJ8VQEa4X4v/bCPtShd/4mcETNIivE2F7d5zU8tHzIjmeziEYUcuKhtYWjV5C+A
 OsiKE1vcPe44hqn0pMvpY2ZydVyO5dCNIr3tX6HuX1jxDdTXQF0H8lYpcQIrGWKMIwfMP78qItO
 GSrzkGKkLdXDZ6tkTCFvT/5a2vx8cYjp7zglJWasCkLLMvzHxNk9huSO4NXpFsJpVrLbyUjHkEO
 QBMDRGJjFbYrgfVvVmIevrP6yEy5IT9LbbWpJ+V6Q==
X-Received: by 2002:a05:600c:3b14:b0:48a:52d9:54ab with SMTP id
 5b1f17b1804b1-48a52d95604mr449733475e9.30.1777294067124; 
 Mon, 27 Apr 2026 05:47:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/63] hw/arm/fsl-imx8mm: Add GPIO controllers
Date: Mon, 27 Apr 2026 13:46:43 +0100
Message-ID: <20260427124738.966578-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Enabled GPIO controller emulation
Also updated the GPIO IRQ lines of iMX8MM

Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx8mm.c         | 54 +++++++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx8mm.h | 14 ++++++++++
 2 files changed, 68 insertions(+)

diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 633b121630..85bce5a788 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -180,6 +180,11 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_GPIOS; i++) {
+        g_autofree char *name = g_strdup_printf("gpio%d", i + 1);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
+    }
+
     for (i = 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
         g_autofree char *name = g_strdup_printf("usdhc%d", i + 1);
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
@@ -365,6 +370,54 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                                 fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM].addr,
                                 &s->ocram);
 
+    /* GPIOs */
+    for (i = 0; i < FSL_IMX8MM_NUM_GPIOS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq_low;
+            unsigned int irq_high;
+        } gpio_table[FSL_IMX8MM_NUM_GPIOS] = {
+            {
+                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO1].addr,
+                FSL_IMX8MM_GPIO1_LOW_IRQ,
+                FSL_IMX8MM_GPIO1_HIGH_IRQ
+            },
+            {
+                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO2].addr,
+                FSL_IMX8MM_GPIO2_LOW_IRQ,
+                FSL_IMX8MM_GPIO2_HIGH_IRQ
+            },
+            {
+                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO3].addr,
+                FSL_IMX8MM_GPIO3_LOW_IRQ,
+                FSL_IMX8MM_GPIO3_HIGH_IRQ
+            },
+            {
+                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO4].addr,
+                FSL_IMX8MM_GPIO4_LOW_IRQ,
+                FSL_IMX8MM_GPIO4_HIGH_IRQ
+            },
+            {
+                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO5].addr,
+                FSL_IMX8MM_GPIO5_LOW_IRQ,
+                FSL_IMX8MM_GPIO5_HIGH_IRQ
+            },
+        };
+        object_property_set_bool(OBJECT(&s->gpio[i]), "has-edge-sel", true,
+                                 &error_abort);
+        object_property_set_bool(OBJECT(&s->gpio[i]), "has-upper-pin-irq",
+                                 true, &error_abort);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
+                           qdev_get_gpio_in(gicdev, gpio_table[i].irq_low));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
+                           qdev_get_gpio_in(gicdev, gpio_table[i].irq_high));
+    }
+
     /* USDHCs */
     for (i = 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
         static const struct {
@@ -423,6 +476,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_CCM:
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
+        case FSL_IMX8MM_GPIO1 ... FSL_IMX8MM_GPIO5:
         case FSL_IMX8MM_PCIE1:
         case FSL_IMX8MM_PCIE_PHY1:
         case FSL_IMX8MM_RAM:
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 3181c02574..4fe27b9575 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -12,6 +12,7 @@
 
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
+#include "hw/gpio/imx_gpio.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
@@ -30,6 +31,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
 
 enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_CPUS         = 4,
+    FSL_IMX8MM_NUM_GPIOS        = 5,
     FSL_IMX8MM_NUM_IRQS         = 128,
     FSL_IMX8MM_NUM_UARTS        = 4,
     FSL_IMX8MM_NUM_USDHCS       = 3,
@@ -40,6 +42,7 @@ struct FslImx8mmState {
 
     ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
     GICv3State         gic;
+    IMXGPIOState       gpio[FSL_IMX8MM_NUM_GPIOS];
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
@@ -171,6 +174,17 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_UART3_IRQ    = 28,
     FSL_IMX8MM_UART4_IRQ    = 29,
 
+    FSL_IMX8MM_GPIO1_LOW_IRQ  = 64,
+    FSL_IMX8MM_GPIO1_HIGH_IRQ = 65,
+    FSL_IMX8MM_GPIO2_LOW_IRQ  = 66,
+    FSL_IMX8MM_GPIO2_HIGH_IRQ = 67,
+    FSL_IMX8MM_GPIO3_LOW_IRQ  = 68,
+    FSL_IMX8MM_GPIO3_HIGH_IRQ = 69,
+    FSL_IMX8MM_GPIO4_LOW_IRQ  = 70,
+    FSL_IMX8MM_GPIO4_HIGH_IRQ = 71,
+    FSL_IMX8MM_GPIO5_LOW_IRQ  = 72,
+    FSL_IMX8MM_GPIO5_HIGH_IRQ = 73,
+
     FSL_IMX8MM_PCI_INTA_IRQ = 122,
     FSL_IMX8MM_PCI_INTB_IRQ = 123,
     FSL_IMX8MM_PCI_INTC_IRQ = 124,
-- 
2.43.0


