Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0568DC021B3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASR-000064-5I; Sun, 23 Feb 2025 06:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASQ-00005a-C2; Sun, 23 Feb 2025 06:47:38 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASO-0005x8-Hw; Sun, 23 Feb 2025 06:47:38 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so561367666b.2; 
 Sun, 23 Feb 2025 03:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311254; x=1740916054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AieNCuXJCXf3WSAGsRoruSJQCi8pXIbogaJCtAJEy7M=;
 b=RGp8wwEO9Og1tAtYFgZQqEMTznRZcPDmkg3GbbUpRx10bSzci4KnWd+ln3kAwQXMrP
 3npzXWBdYQklE3R7AecrHsmjtzP5NZdxacTf0CN07PfdfLaQQR6fo/aYE1Om7b+v3DwG
 xcl4/pSJEfUkuEheYMXK8XHqqivzgzIZ3V/Rks5rBZd0M5jP7HhX1/N9+qJ0Pc/LjNkQ
 weI7zlCXL6rzWQyfg5D+oI6z7WEZhQ90ZOC9ThVceTwblUFmH0CoRRBZ9kNhlcsS6uzc
 5jn7LPEWLiGwmFRbDtzpsqId1mm7zbKJ92lu8Qn2FwRaxmvuY7uIGUBkH9E+IuxV8GwI
 pnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311254; x=1740916054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AieNCuXJCXf3WSAGsRoruSJQCi8pXIbogaJCtAJEy7M=;
 b=GbJa2JUBCm3eGMu3ZFJwn2a79rOrXSvmo59IufVdXB/lxpLNXUed15gFN3uVXFsif8
 CegXm4f+kK1xVrg5CzgzM2LIowzYsFUKzfSZfyFg4PoTKylIXaqTtrymgh+8hy7zLWio
 0oh1qbOwNvkA2++pPPSv4NhN5OVC9ahMQaX4Gj4MpdYAVAGDxIh8Q70xDkYwO8btGRPw
 /m5vIsRyIX1gMH6U4EVf8nBEYCH2poXcR7RGbPiedy9ukfxssRq6QJRxp20SRlmroMEq
 /I3cnHCjVVlV/jwPX1QpDALBsJ0zLIzk70uTMxnnMO3WqsBxIhm0z6I55OegtBN9q/Ll
 APvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGayZoXi3pQPn3wkI6WvROhQjDz5umBFKr0HJIOFy+U3/5e2iUsdt3OQ7r2lrIbLreb3uAPkZ36w==@nongnu.org
X-Gm-Message-State: AOJu0Yw6dm3LgRSsfzvvIQMXpvZBW+wL+HBuUmWYF+EMtD6RFhS4Xiew
 yx8Az30wS4Bi+zp6RBjoQL604Ah7WDRXj2ckDlMEuYTGaNIqSnnDtEp4Og==
X-Gm-Gg: ASbGncvNk74SQ43PnQeGgHzRkhPgyNL7yvIJg5venVu40KSCnZySX4/bfldOm/v4hY6
 IYINjqQik8A9ioxuJuxIHag5tbAyns48p9ofKDFYWmE7ZHwnCNhQTAYQUMMHDTY6cGryiGpkXCJ
 fQidvPtDaGhqvHx6Fy1+fBqp+tOvyLEWAB9xsTqFQZLFUEYbyYLUgUaDU5JTIMK9Jjba17srYXV
 sRHYnGemJV7ijoqFJSu7Ifwhncxi3cNXBWNpqDYjA6qf/cGDjhAmC5nUpCncb7Y4K4CyvzRU8rl
 R6oZR22tT5DmjGMLtcvMI56sqpnu/6QaII//zRN7Y7tFJ8K5WmKYnjeaBBdZyBpC5cc5ent3/PM
 6TFs7RoCC2PXP
X-Google-Smtp-Source: AGHT+IGmZUv3Wjo2P3Fyk+/tLdRaeqBO2iTxLhXqGn4xQw+1j9a+sAxdINvcl6ESWdP2d5gcUJpMdg==
X-Received: by 2002:a17:906:f596:b0:ab2:b5f1:567d with SMTP id
 a640c23a62f3a-abc0da30be2mr936458666b.32.1740311253819; 
 Sun, 23 Feb 2025 03:47:33 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:33 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/18] hw/arm/fsl-imx8mp: Add GPIO controllers
Date: Sun, 23 Feb 2025 12:46:59 +0100
Message-ID: <20250223114708.1780-10-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    | 14 +++++++++
 hw/arm/fsl-imx8mp.c            | 55 ++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 18a8fdd278..37d3630d09 100644
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
index 791d24eec9..456fa47dc7 100644
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
@@ -415,6 +469,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_CCM:
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
+        case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
-- 
2.48.1


