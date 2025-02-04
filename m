Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75990C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF7k-0004zT-LV; Tue, 04 Feb 2025 04:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7f-0004qi-Kt; Tue, 04 Feb 2025 04:21:35 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7d-00054F-Kx; Tue, 04 Feb 2025 04:21:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so61803165e9.1; 
 Tue, 04 Feb 2025 01:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660891; x=1739265691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sgl4Tbpc4IGB3MJowPyxnvzMhk+F/3TQyhbBvOfmDJw=;
 b=F4L51f+o/+79VrIB3sZPcSZiZWZnkI4tPvHjeMqlFayj+RMmbQivdbyw7uxiO5dF/s
 LkprzefsBSU5eVQ+I2tBYfYcRc4kiO1DCXwooN00xkoJWt8sEa+yHqqKiZEgtkwE5sWU
 Zb/xpy10Pp0Pr8A9uLzu0NZbo+57P2dFvavu+fuGj3fRyfDECm62OpvSNqqEFZUJWGu3
 zFPSSNQtsfEe/NIJd/bqETM80A4a6fIRachZUodlda4OwMpu2UblQTLEn/qh29iZ50kq
 iPsFjoH1wrI7G9Q8SN6TiLKCczjJeHAUXfhaQk8IL6ocIm+zseoPuT+XH7Swz5ZlvNH7
 p+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660891; x=1739265691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sgl4Tbpc4IGB3MJowPyxnvzMhk+F/3TQyhbBvOfmDJw=;
 b=MRJTmjFm7ioHeZGCgo6Phj/T330gD85QrMO1AbQlILv0J9Q/f7tcReuBnsWbXlM2Yn
 B3MxXtoUnCMJ+4k3hSRzrguHeo6Rq/FWb+I6px9+g1kUE6DcNBks2glFPKo4VISGgJf+
 EktIj6HQHvQ3rxHzdv1Xq6R6uZ15/MIbKJisUV1coc7hxHfbUHDcNpq/RYH4XN1M7dqC
 Wj5lfLatF24hlNNcAfjm4CfJVJTZ/OCplE2YSS1QNQgR9KClg8VSgqntS1RngjXJ/NUQ
 qjtcXp7oQeuGzmjJ4Ky0mFr565uK6UZsdWScwVw8jeBawmVW2d+SYe/KBIxQLBiBOmX6
 MdtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjVO80Lf/e4EaedyW7wDysc35lNKDqgjJu6TFdorKexJJHpIxmMxFKHDBpX6I/6jKYOo8D4NUPZQ==@nongnu.org
X-Gm-Message-State: AOJu0YwD3m+FyGDsUdr41DNq1FFhf5B8FcU6HF0x+5rzFbd6inUShzoo
 RUETYG8pYmeWyqllWx3brqpUAQwGvOicBmEzj1IWcf7jfs00curAGdVQZg==
X-Gm-Gg: ASbGnctjFJqyZjt3VQVTLMMt0fCVxkyAW4Sq0IZ8KZzJI90y19X9EJft2O9RTuqiwc6
 HG9mo3FgYW9bAUlrXNNA8U83mHEt+hUu03Oa2vQSeGsac8HtnP0gjr4pVyjYWsgUS+r1j1JsP1p
 tOLsSTNkyAyKdN6OogdwDIep/khuMX2h2t/wQKfQml5psXPWN3SI/4+QmvVRLth6uTr/ERfuS7c
 1UktzumgSxr0dAedA2En1oV9UOlKB7r4oLyrUL59nN3A4edOarFzyTwRG3v1zvJKGw5pILlMdXU
 95gAqjR/OsJf7JyB7vyawrEdkn9QSebrRrDg82ZsBWf5dPgy/mCtm72juEjLcjX5U+DSw3m3KIR
 wJM8+gxnJDg==
X-Google-Smtp-Source: AGHT+IEkt89PwNO/1zMrz/DzfbQPiu1CXQMR6mEelajYZNh4uEQGI6jwRfcZ95s/QYmHff1PYZJqgQ==
X-Received: by 2002:a05:600c:1c1a:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-438dc3c4623mr239646785e9.10.1738660891105; 
 Tue, 04 Feb 2025 01:21:31 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:30 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 09/18] hw/arm/fsl-imx8mp: Add GPIO controllers
Date: Tue,  4 Feb 2025 10:21:03 +0100
Message-ID: <20250204092112.26957-10-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    | 14 +++++++++
 hw/arm/fsl-imx8mp.c            | 55 ++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 39df695df7..a89aad6f92 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -15,6 +15,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 4 UARTs
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
+ * 5 GPIO Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 4c70c887a8..18ea52d083 100644
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
index faa6ada183..13910dc44a 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -211,6 +211,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
+        snprintf(name, NAME_SIZE, "gpio%d", i + 1);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
+    }
+
     for (i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
         snprintf(name, NAME_SIZE, "usdhc%d", i + 1);
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
@@ -359,6 +364,55 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* GPIOs */
+    for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
+        static const struct {
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
         static const struct {
@@ -419,6 +473,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_CCM:
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
+        case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
-- 
2.48.1


