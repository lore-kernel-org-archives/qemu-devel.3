Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB9BC021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzL0-0001xa-3C; Tue, 25 Feb 2025 13:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJj-0000JV-TU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:12 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJe-0002M1-5Q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:01 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4399ee18a57so404655e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506754; x=1741111554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=763FsgHv/y0ddB1Yc59uQpK+OQvhicTdLrmuE07GXxA=;
 b=IpQxsAyxQR4vVB/qGFjAheW2UO6bxQHoYCaIB3NDrF0fze0X+5Qnqxh4OubzNFZMGz
 oJdZuG1ptKy6djViLzn8t3xulIexqEYV8K2KzQuh7TUG9ZyG4DDypjeojAg4xvKJVN6c
 iQDIvg4GIkAAYloKsMpiIEA1bCEgF5jAeuIboWaJSD13vzDm5Fh6JpXoaZqUXoU8Qse0
 bQ2AP31wQSsibxwANhufy1nC+TDBTp6f9q9p9RQ+K1jq5w009oLVSIKAPG8LdNq4ASRt
 vQr3t1DU1Ci1SyLTv20nUufsIHZZJlGCZAHVlc9tYk9//5VCteJpsK8G/K3J7z4t2jK2
 WmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506754; x=1741111554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=763FsgHv/y0ddB1Yc59uQpK+OQvhicTdLrmuE07GXxA=;
 b=eqeKE/67LpGc8Jg/lWr2vi8H7k6X7Nt23qvwkeoJGjJaKBJICfHbRkb7MowaJYJXc8
 rqRR4IiYgoGTdm5/4voe5WYDOrgkdAMHMAmxFTj4StFhMhV7DyRJSOaZ3haQj/TNvS8R
 4BVCC+d823iYI8MA6c9IU5A/SNdNnGa4kqJ1Iav3t4JBY/Bl+CCQFg7fyNnyaxSAxB//
 fpzEQl0Dcd8tsQZ4vUBNsPWKtrQ0HqS4cP1/+AfCW/19cXDs9XP4rw019bvcI0ZTooT+
 XQ1d3xyDb8cbfCGIri2UB2rrIDaf26o+gtckLVWbvjlNCFTagnEiwlViEoFSGaJr28Vi
 Ckng==
X-Gm-Message-State: AOJu0YyYkA0withlEfPyGahYP+DTR/ENLRMXgEVccx+AjEY9gC20Tq21
 Z5JyivdwpTNv5cP9VyqhP+fXkX1vknUmRmNv9quu/QayeMczlj//UP58HJcg2XFbBK4qie+j4WP
 F
X-Gm-Gg: ASbGncv5PEgUuosW/9hSnWg/JYSRyl0pqt43CyBXqwxI+4QsCA7j7zI0rs8UU6uosAv
 lGiRe0pIDScCYzgSJQ4UxVnvj+A52UccGPdki5ST9c+IgiwfGD7qSWLrgReZZz/4gC/48EuUrla
 mZoxD6TaCtww2Vxhg56y4P8mtqGWefrsjHwq6WhqrNfiqdmIua3gB8XBh7xdBGFmnSQeNgc6XGq
 JnPXIAUr576j25UkTk/i9iXC25bXNSPbxnieJ3dqH1SWRf4QLCJb4qMKUCToDW1bsXbr+oaAsR4
 D/+6SRe0DnXpUF3lhldEeN6/qIZ7FiTA
X-Google-Smtp-Source: AGHT+IF/6mD7WqOkxdbgXdNdsMhsrxjE3PbOw4MEPHedHz3ZnAbDADX1k4Che+BLj20G/VMxj5YRIg==
X-Received: by 2002:a05:600c:1c85:b0:439:968b:6669 with SMTP id
 5b1f17b1804b1-439ae2d254bmr150573555e9.1.1740506753766; 
 Tue, 25 Feb 2025 10:05:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/43] hw/arm/fsl-imx8mp: Add GPIO controllers
Date: Tue, 25 Feb 2025 18:05:02 +0000
Message-ID: <20250225180510.1318207-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-10-shentey@gmail.com
[PMM: drop static const from gpio_table for GCC 7.5]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    | 14 +++++++++
 hw/arm/fsl-imx8mp.c            | 55 ++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 18a8fdd2785..37d3630d09c 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -14,6 +14,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 4 UARTs
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
+ * 5 GPIO Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 4c70c887a89..18ea52d0839 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -11,6 +11,7 @@
 
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
+#include "hw/gpio/imx_gpio.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
@@ -29,6 +30,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 
 enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
+    FSL_IMX8MP_NUM_GPIOS        = 5,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
     FSL_IMX8MP_NUM_USDHCS       = 3,
@@ -39,6 +41,7 @@ struct FslImx8mpState {
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
     GICv3State         gic;
+    IMXGPIOState       gpio[FSL_IMX8MP_NUM_GPIOS];
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
@@ -202,6 +205,17 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_UART5_IRQ    = 30,
     FSL_IMX8MP_UART6_IRQ    = 16,
 
+    FSL_IMX8MP_GPIO1_LOW_IRQ  = 64,
+    FSL_IMX8MP_GPIO1_HIGH_IRQ = 65,
+    FSL_IMX8MP_GPIO2_LOW_IRQ  = 66,
+    FSL_IMX8MP_GPIO2_HIGH_IRQ = 67,
+    FSL_IMX8MP_GPIO3_LOW_IRQ  = 68,
+    FSL_IMX8MP_GPIO3_HIGH_IRQ = 69,
+    FSL_IMX8MP_GPIO4_LOW_IRQ  = 70,
+    FSL_IMX8MP_GPIO4_HIGH_IRQ = 71,
+    FSL_IMX8MP_GPIO5_LOW_IRQ  = 72,
+    FSL_IMX8MP_GPIO5_HIGH_IRQ = 73,
+
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 1ee681ac1d7..541e4ab5b63 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -208,6 +208,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
+        g_autofree char *name = g_strdup_printf("gpio%d", i + 1);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
+    }
+
     for (i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
         g_autofree char *name = g_strdup_printf("usdhc%d", i + 1);
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
@@ -355,6 +360,55 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* GPIOs */
+    for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq_low;
+            unsigned int irq_high;
+        } gpio_table[FSL_IMX8MP_NUM_GPIOS] = {
+            {
+                fsl_imx8mp_memmap[FSL_IMX8MP_GPIO1].addr,
+                FSL_IMX8MP_GPIO1_LOW_IRQ,
+                FSL_IMX8MP_GPIO1_HIGH_IRQ
+            },
+            {
+                fsl_imx8mp_memmap[FSL_IMX8MP_GPIO2].addr,
+                FSL_IMX8MP_GPIO2_LOW_IRQ,
+                FSL_IMX8MP_GPIO2_HIGH_IRQ
+            },
+            {
+                fsl_imx8mp_memmap[FSL_IMX8MP_GPIO3].addr,
+                FSL_IMX8MP_GPIO3_LOW_IRQ,
+                FSL_IMX8MP_GPIO3_HIGH_IRQ
+            },
+            {
+                fsl_imx8mp_memmap[FSL_IMX8MP_GPIO4].addr,
+                FSL_IMX8MP_GPIO4_LOW_IRQ,
+                FSL_IMX8MP_GPIO4_HIGH_IRQ
+            },
+            {
+                fsl_imx8mp_memmap[FSL_IMX8MP_GPIO5].addr,
+                FSL_IMX8MP_GPIO5_LOW_IRQ,
+                FSL_IMX8MP_GPIO5_HIGH_IRQ
+            },
+        };
+
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
     for (i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
         struct {
@@ -415,6 +469,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_CCM:
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
+        case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
-- 
2.43.0


