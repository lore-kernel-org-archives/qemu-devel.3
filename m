Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10A0C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXR-000406-RU; Mon, 20 Jan 2025 15:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXL-0003wG-UM; Mon, 20 Jan 2025 15:38:22 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXJ-0002XS-Ul; Mon, 20 Jan 2025 15:38:19 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3ecae02beso6857100a12.0; 
 Mon, 20 Jan 2025 12:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405495; x=1738010295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weJccw4T99I7vTGm3QItShv2l9pPh0ZQ8otXT2NBe34=;
 b=MOj0wOvY3Ow7oBaKp7QtyP/D1eyevEtO6MYJzv8i6+6LE5H5flO0avhqYNXyjnskBv
 Febsxa1z9Cae0T5nd66e122quqOqwb+B2zgulc14uFO8dlFBbsl3/t7UwqS6FLUf+Q00
 GInZQ/NfBHk9k0vbToKrB5LrdyCV12/FL5TcDhLTOkbI/kxnWUlkRcp0FMBzhA3IC0zv
 7u7v6E6Rx6fzHIavrfpWAcoVAHzQLFNOr/EpzLwE0oxVvk9NYdnqt6VqAsJTA7y5e+6M
 /ZDBV+Y9bJkmLElOSvXaeOCwaTXHJWxErEKfwzR3ytba5YxqdO7JEk9p/j8GDnWDGeZ+
 EDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405495; x=1738010295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=weJccw4T99I7vTGm3QItShv2l9pPh0ZQ8otXT2NBe34=;
 b=tdTKo47IxTPXa9umASzKRGsQYVTlTbhRAXGHD/EFfmNBi1fNhpx43bO1ozyJIT4q82
 EPYsVkC9jRRKybqwkLhgEefy37c+bBfiemgoIcHSiXEpqBaEsyms4hLsmyz1je5J6Fxz
 46GvbyTdPGK6VVcVeiVprMRRF+4PLh17E/OK5Ux+pzVggeVljvzPNy9k3uLF1koWMhqu
 0ulUk06ZGSXSQDmNG2aB+Xr/xs9Xe/JYQx4pB/KmqjMIoLhzhbSqOu/0WE54ncX4Paky
 /l4/ivfNKkniTLLx8kXc7AQlSpD5mtwGOTopnMk9iRVsPFMi8kGz0EyfP1UTEQcZY162
 gdDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhA4xOV6qRnYRCyMlL2wfh91PfT2W1mZteOo/sOiDOWaEcW3jRc5dPx2DRUWvlhoIMNYYSn8gQvg==@nongnu.org
X-Gm-Message-State: AOJu0Yyom5557+F52uaUg/OgGs6+QDuzjkeBtal29m9fzLnpDC6NMH54
 L35MrMC8sHuOhRwDh7b46VeHoNelCuJqPIsbCpCh1hgU+gSxkcd325F0Sz+j
X-Gm-Gg: ASbGncsYTrarJxkvgAv7MeiYdySoL3Um9h/+w8cUtHVEtXS+gxoazLXjCBCHCiAiL/b
 vi5fS9ePwFfMCIqHHvzYVB3+GVs5/z9gUmI9nnL7exaZaI6fuB8SzJrRXh1b5FLXETVj4bhotoV
 qdZNBSrXXbafjUwJGSEy3Bkm8rhugcaVmAZab4vDzGVHBJlmIHWz8N1wmyocURl7wBPu1cZ8nX2
 zhnVwTmCXJ+6WUn9N0vkbVUMlcDyJlUnyjhYv9l1Y+rsB+LKOC9VoFEF5mMaqYB2BcMWkvB1ig/
 HN2f5xjHjXleg082LPY7+NWe1E6iMo+ss/q53xKJMYUCwySptzkGmn/1chG+
X-Google-Smtp-Source: AGHT+IF+kLgruZdfZICXTvGfks/QI0gXDEbBnkqmHkgXkXk7GC9kPOeOlNyOw9QkmtaMIIbcmQbf4A==
X-Received: by 2002:a05:6402:2808:b0:5d3:bab1:513f with SMTP id
 4fb4d7f45d1cf-5db7d3009b3mr15649921a12.18.1737405493615; 
 Mon, 20 Jan 2025 12:38:13 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:12 -0800 (PST)
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
Subject: [PATCH 11/21] hw/arm/fsl-imx8mp: Add I2C controllers
Date: Mon, 20 Jan 2025 21:37:38 +0100
Message-ID: <20250120203748.4687-12-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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
 include/hw/arm/fsl-imx8mp.h    | 11 +++++++++++
 hw/arm/fsl-imx8mp.c            | 29 +++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index d974581fb1..2bcfe34f48 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -16,6 +16,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
  * 5 GPIO Controllers
+ * 6 I2C Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index c91964a465..7e6f997d37 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/i2c/imx_i2c.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_ccm.h"
@@ -30,6 +31,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_GPIOS        = 5,
+    FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
     FSL_IMX8MP_NUM_USDHCS       = 3,
@@ -44,6 +46,7 @@ struct FslImx8mpState {
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
+    IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
     DesignwarePCIEHost pcie;
@@ -204,6 +207,11 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_UART5_IRQ    = 30,
     FSL_IMX8MP_UART6_IRQ    = 16,
 
+    FSL_IMX8MP_I2C1_IRQ     = 35,
+    FSL_IMX8MP_I2C2_IRQ     = 36,
+    FSL_IMX8MP_I2C3_IRQ     = 37,
+    FSL_IMX8MP_I2C4_IRQ     = 38,
+
     FSL_IMX8MP_GPIO1_LOW_IRQ  = 64,
     FSL_IMX8MP_GPIO1_HIGH_IRQ = 65,
     FSL_IMX8MP_GPIO2_LOW_IRQ  = 66,
@@ -215,6 +223,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_GPIO5_LOW_IRQ  = 72,
     FSL_IMX8MP_GPIO5_HIGH_IRQ = 73,
 
+    FSL_IMX8MP_I2C5_IRQ     = 76,
+    FSL_IMX8MP_I2C6_IRQ     = 77,
+
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index c62d0e4479..f2d890ffb3 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -211,6 +211,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
+        snprintf(name, NAME_SIZE, "i2c%d", i + 1);
+        object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
+    }
+
     for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
         snprintf(name, NAME_SIZE, "gpio%d", i + 1);
         object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
@@ -364,6 +369,29 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* I2Cs */
+    for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } i2c_table[FSL_IMX8MP_NUM_I2CS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C1].addr, FSL_IMX8MP_I2C1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C2].addr, FSL_IMX8MP_I2C2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C3].addr, FSL_IMX8MP_I2C3_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C4].addr, FSL_IMX8MP_I2C4_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C5].addr, FSL_IMX8MP_I2C5_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C6].addr, FSL_IMX8MP_I2C6_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
+                           qdev_get_gpio_in(gicdev, i2c_table[i].irq));
+    }
+
     /* GPIOs */
     for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
         static const struct {
@@ -474,6 +502,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
+        case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f065718416..8d796e05c8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -581,8 +581,10 @@ config FSL_IMX8MP
     bool
     imply PCI_DEVICES
     imply TEST_DEVICES
+    imply I2C_DEVICES
     select ARM_GIC
     select IMX
+    select IMX_I2C
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
-- 
2.48.1


