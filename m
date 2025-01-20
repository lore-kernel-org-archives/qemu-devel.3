Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A183C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXQ-0003z4-Pm; Mon, 20 Jan 2025 15:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXJ-0003v2-Rh; Mon, 20 Jan 2025 15:38:18 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXH-0002Wx-0n; Mon, 20 Jan 2025 15:38:16 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3d143376dso7382601a12.3; 
 Mon, 20 Jan 2025 12:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405492; x=1738010292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfQsW8y69ysVAOwPMEos9JLto5GHPp9lHNegH7ssiK0=;
 b=UEfOIvw4k69XY2ecv2wtVekom1IENclfTUu+T8xNPQsoO4t98Pg9KPkwhbYD5JFJO9
 nCFB2MXQEwRSYOsmOc1flTzu2DP9s180SF6eiREW1Tla7p+W495MIaBS0z4zDQWneSHl
 C/IEnBUY/2fSllFAoOe/Qkke50fZfnJK9hUJL/eLoZOnZDO6ebSby5mqt2T5GUA+LOyX
 x/xU+l0hdE77DRFlkslbtfX5zYZNYwi6VyEFxWNwWzExCamY8UhGo5DO6JUB5PKZoHrv
 amxJiALnsUPDt7liQdXivfBU4+6GXjhH2QylbJwDBWDS3TJwZb1NEf79lZEVw6rGaT5R
 X+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405492; x=1738010292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfQsW8y69ysVAOwPMEos9JLto5GHPp9lHNegH7ssiK0=;
 b=ZKmw4LVi2kRpHH7Bku3yuHtEbARn5kxBroEP9N3hicuBXYQqUyjX+x6HOP0iKyl9lS
 fNVKms1JCs0rpLYzTonY9z4sUa3vp+lpJgmUpaqNyvsLE7k4MuqrY83KaNhVeVdm+srt
 NuQaLvXMKuzRR8OD9zAH39VHCSoB+DrWrYczzik32sunHSlBx4gW63PG5r9x+cdGEO6/
 m7uh+uUskEg74QK4qJZAJckR8aXFjeIqOq8VN7406p2xYQyaw3F0FgGSfHEDAZNdEVHp
 C+3ziGXRmRrrZnHMNcUEdbrrK5afQ2WubMF6ehWJpFEOlI0TpIM+7zYZTPS1aCjbe2np
 YFUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf5sk9HD97QKK7Mk2Btn2NN4U17qA25uevAjRQdwHTrUBSFem1p19vC7JRVhribBBADZYTCCsDeQ==@nongnu.org
X-Gm-Message-State: AOJu0YxgG0fd13M1BslRvH+RXPQpA7uFfcHenkF640DOn38ZetDrew04
 Kn6A+OvEbKq7JHcJruRajnIBzczwzMEehS/uhYspSQ68BI0uvCelA0PySh3J
X-Gm-Gg: ASbGnctmzCoSq03OyGKC8ORwpdhJX3yj4QCVnJhb9/o0okin2/6f7EiktAAAgS2L4c5
 dTcpRJrcdi+WqH0ig8MW/DEK9IW0WB+4RIy0WJ4uY7ATX5186mfzF1cYHJKQEaDQmsol2h7sJ4q
 ZgiDTHaNYdUhIp8VSrnMw3JmmZzii75dJfHqn7Ec8gX2kwe4q6jAeAP7aA6hRmn62+hJmoMuQvg
 yqYnLNNnI6DT1zxKrXR072AQqJxdn2muwagnZC9NFQeL+oeU04zuVB7vm5ZPIqw3UXSflKUJGb/
 YtWpR5waybWDl9K5afe14pHmQ0KanpkJaJ6ZhsHKv/z89UOix/CpCH7SNTNt
X-Google-Smtp-Source: AGHT+IEpiiWiPMn5DZ/gAG3eUcaWFLGeVeo4a4ICzaKt7SrzScmMbGzBRr54bOawR6wT9fEHBvnC0A==
X-Received: by 2002:a05:6402:26c2:b0:5d2:7199:ae5 with SMTP id
 4fb4d7f45d1cf-5db7d2e3014mr14020504a12.5.1737405491964; 
 Mon, 20 Jan 2025 12:38:11 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:10 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 10/21] hw/arm/fsl-imx8mp: Add GPIO controllers
Date: Mon, 20 Jan 2025 21:37:37 +0100
Message-ID: <20250120203748.4687-11-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
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
index 8d48580cb4..d974581fb1 100644
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
index bc80a21966..c91964a465 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -11,6 +11,7 @@
 
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
+#include "hw/gpio/imx_gpio.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_ccm.h"
@@ -28,6 +29,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 
 enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
+    FSL_IMX8MP_NUM_GPIOS        = 5,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
     FSL_IMX8MP_NUM_USDHCS       = 3,
@@ -38,6 +40,7 @@ struct FslImx8mpState {
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
     GICv3State         gic;
+    IMXGPIOState       gpio[FSL_IMX8MP_NUM_GPIOS];
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
@@ -201,6 +204,17 @@ enum FslImx8mpIrqs {
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
index d15dcaa9de..c62d0e4479 100644
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


