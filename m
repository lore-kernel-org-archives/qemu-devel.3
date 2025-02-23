Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1617C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASX-0000AU-7L; Sun, 23 Feb 2025 06:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASV-00009f-I8; Sun, 23 Feb 2025 06:47:43 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmAST-0005y9-Rw; Sun, 23 Feb 2025 06:47:43 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e0813bd105so5933837a12.1; 
 Sun, 23 Feb 2025 03:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311259; x=1740916059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+if4DS/w59ucP7EmR+9yjY+B9ICc0Ae4mwKIeo0DX0=;
 b=d2X2Ba5TCrFx1Ue+c+lJzpOsw9N4ImKKbltfV7liSmoAcToEqszc68DBwWcemx0NyL
 9l3KKuDMb6yDilsqGTPUGr4dV9u/OIhS10hySuXhZHV6DXTU4v95MDL/pj+MfOOU5tSq
 cfU3xTNI1MxHf7vLygIEkbH8z267g1M6LVmfoibfw70Dihx6NKlSuEaKKfDtQKHkOZjA
 8iezj0DTJ8MDO1/Uw1WUy0l7iQIHI7pcgHJjJ7o+UL3kz5P63RmvclWUHm5ZTooPGLP0
 ZLBHwzLJ76lC3DG5DC9ot6jmktYDR7ZLfsfrZRrOEehQOEM9NfS82vPNgI5Kc7211tPr
 flwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311259; x=1740916059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+if4DS/w59ucP7EmR+9yjY+B9ICc0Ae4mwKIeo0DX0=;
 b=IWlJchpr/lbpOTKDILPGPCZCodMTVvPf6Ag2IlwuW8/n0DRBSuT+/qoNAy0enSsx2u
 7pJlltxSxSmTAQpEHjlyiIy+AW9Z5ty6kESFsN9x8xsQwF/5wQKQNXOhDMPbkObzls+G
 mIlLUpb51ROZO9lNTRZkemid7a0mHBhxEHMNq95+tpaeG3Fi2dEzyyfgXsM6OHDpmxFL
 /uMLVDra8aJiqAqBfXEuGwpxyncFaRc1iCuS24AuO00qAU2OTywIbyb+9sTwnGeL9atO
 MFAaZzfb84Lzc0US8U5j4BTl8VtofjUs9OhN7IQGvZDAy0hTo13DSFlq438toSKkvKKx
 gbgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRpC8oPgl84qOQlDzuwmOGfJKvugnkdFe2h8UNzIR3J0W2z3qKdZJC8cQmrQw9Pk1zdt+weywhug==@nongnu.org
X-Gm-Message-State: AOJu0YyOCR+Y9Qnua48yeD8ClwsFU8iG4HQT1hFZtkPg6NQRRr0Cp6HW
 s8ApMDTG55Qjq5/niv7jv+dUg7XK7kD7kthXWhkXNhTJNT28wB0p5QBVOg==
X-Gm-Gg: ASbGncvl76C3LMqCozpy9VQVAOJETHTAYjtTsD1ypZBEwQ9iC0CMJIVQPnRL7pAYQfI
 a99fupYMbl7HhCs4g/I0pE80k2bnAToaHhWKNJsMIme198m/cTktRKc2dTHD8xqUKxbOG7Pe4ea
 PBkTBFk74vjq/ERi85u5JBVRdVQ41M4YUiDNIEiSHwW/Fq0VYK1EaUNCLXRnU2aX0fbT4FEda5f
 gJ5GXz/D5eZArxp3VEyU5exaqsxKjhGRoCRvM2aufIBevHzeF6EkyYUexqyPn4EDj+73ygnAuhm
 zbhCMPR8M0upChBd+AOF38XUZEBMACHdXORD4kRWkcPMxbOveD72vzc5ns7RHyhA7SlNTYOFEvT
 27zFv65V8Nv0A
X-Google-Smtp-Source: AGHT+IG62hfA6TRu9Ej5mDF0l3d+9fLaBVvnKt4o1gn+bAfZH+v8RNAcyjV3Ynr9e7mZqSHE8bNR/A==
X-Received: by 2002:a17:906:32d8:b0:abb:9d27:290b with SMTP id
 a640c23a62f3a-abc099b3566mr842209066b.9.1740311258574; 
 Sun, 23 Feb 2025 03:47:38 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:37 -0800 (PST)
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
Subject: [PATCH v2 12/18] hw/arm/fsl-imx8mp: Add watchdog support
Date: Sun, 23 Feb 2025 12:47:02 +0100
Message-ID: <20250223114708.1780-13-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    |  7 +++++++
 hw/arm/fsl-imx8mp.c            | 28 ++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |  1 +
 4 files changed, 37 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 66e5865107..904de9aa7d 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -17,6 +17,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
+ * 3 Watchdogs
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 296a87eb50..dfbdc6ac7f 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -21,6 +21,7 @@
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -38,6 +39,7 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
     FSL_IMX8MP_NUM_USDHCS       = 3,
+    FSL_IMX8MP_NUM_WDTS         = 3,
 };
 
 struct FslImx8mpState {
@@ -53,6 +55,7 @@ struct FslImx8mpState {
     IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
+    IMX2WdtState       wdt[FSL_IMX8MP_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
 };
@@ -235,6 +238,10 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_I2C5_IRQ     = 76,
     FSL_IMX8MP_I2C6_IRQ     = 77,
 
+    FSL_IMX8MP_WDOG1_IRQ    = 78,
+    FSL_IMX8MP_WDOG2_IRQ    = 79,
+    FSL_IMX8MP_WDOG3_IRQ    = 10,
+
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 14f317be70..0e031b8c5e 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -228,6 +228,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_WDTS; i++) {
+        g_autofree char *name = g_strdup_printf("wdt%d", i);
+        object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
+    }
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -491,6 +496,28 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_SNVS_HP].addr);
 
+    /* Watchdogs */
+    for (i = 0; i < FSL_IMX8MP_NUM_WDTS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } wdog_table[FSL_IMX8MP_NUM_WDTS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_WDOG1].addr, FSL_IMX8MP_WDOG1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_WDOG2].addr, FSL_IMX8MP_WDOG2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_WDOG3].addr, FSL_IMX8MP_WDOG3_IRQ },
+        };
+
+        object_property_set_bool(OBJECT(&s->wdt[i]), "pretimeout-support",
+                                 true, &error_abort);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, wdog_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                           qdev_get_gpio_in(gicdev, wdog_table[i].irq));
+    }
+
     /* PCIe */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie), errp)) {
         return;
@@ -531,6 +558,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
         case FSL_IMX8MP_USDHC1 ... FSL_IMX8MP_USDHC3:
+        case FSL_IMX8MP_WDOG1 ... FSL_IMX8MP_WDOG3:
             /* device implemented and treated above */
             break;
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 28ae409c85..98ac93a23f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -606,6 +606,7 @@ config FSL_IMX8MP
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
     select UNIMP
+    select WDT_IMX2
 
 config FSL_IMX8MP_EVK
     bool
-- 
2.48.1


