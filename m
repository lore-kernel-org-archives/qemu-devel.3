Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36F3C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXR-0003zt-MZ; Mon, 20 Jan 2025 15:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXN-0003wK-18; Mon, 20 Jan 2025 15:38:22 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXK-0002Xm-Kj; Mon, 20 Jan 2025 15:38:20 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d88c355e0dso9450577a12.0; 
 Mon, 20 Jan 2025 12:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405496; x=1738010296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ONrk2DXA5tqPrNgZ/ambBuTQ+C/SH3/b3GMNdOLUNM=;
 b=eoQDuYIs4698S1TLYGfcxc/uLGHqTugtgpfKMy+agIVd/pTLtqFr2V90hIZx0YKwYl
 kRsxOgbKyqylPwvpn3OXZq3+zW8mvrI9GeFJ/2eFxWeZSYQmnNBrp++jWK9Z/HqUQLHC
 RjDrKZUapld6UJc0GrSJCYMw5EhjIMStOgIEh98J6fe8FW5ChgTyng7488KGCcN3s4Bp
 b57grHF9CEsTC2e0QbjNFGQH1GJoYEyk6gHRXIkg+hFnpM6Te0F4eX7WXVIDPVliVrvd
 2QKj77P9OsdSofOjvmyJbllvhrYCtEg4qV8vrrpuMwVU5qej3k6pEc60K4aRZ6TcoT+d
 Mrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405496; x=1738010296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ONrk2DXA5tqPrNgZ/ambBuTQ+C/SH3/b3GMNdOLUNM=;
 b=l2f6OWLHBJU1qTsAiP/asnuKtb8LGGMZOQXEC/UBgEAUKEkh6cIDAN6gywix5TVmcW
 nwMSjYpIn/19whOpuVIXuhccHA3Lf4y7qNMgdGINaLYlnCdZMPswvWDC/jXgMtQcK8Mk
 WwFQ1+Czql1IKut6F1S13Ytg+8Q50ZJtzNJ/8yTzFnieCmEwcwPI1QSj1jS1XLm6O728
 uqMFkeReiol7fz4EdJYRHhehadZGtPe3QNxHWYbeCM192RgcfBTAb+ibqhZKmlR6UeGm
 ZROngpiNdQfxvRpRWkD6559Cq5kXCNxqQ760U65I8crJPfvZY8Qgc9SnvOCQmL9NI0XQ
 aC1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Le8qQ6jS2AqoNrMB9H+OyfQkQKBN51tKkd3yx2mPg4JNZDonO8QRwyc2mUGo/rWtBj5axoK+0A==@nongnu.org
X-Gm-Message-State: AOJu0YxHq0WEsEbMRFI/TfdSsSrwZvGqismEQhDKV57gtf+pk89VDtTC
 3ZKJBVN49REhet6mvCXeYoifqfVtRZZb5nFuCFMjRSUbG+4d++AY+5b6L9xZ
X-Gm-Gg: ASbGncs1ydb7MZJexn7kJlqcsfZ80ZVyA2rs5oG70/fR+KUo4h3bMAUEphx/3JoGlNe
 Z/1BfgSl9YgGD9t71I9x56UEtKpPG/UkH+ZWTpGJyIt92RHPodSPbLWR2FnBoKIcaXZDw28Ubmg
 5fb4lhMIx2JXEiakWW1+wynZDmZvxcgPjv5Dhw8fEopuIx9GsbkH2QCfnONC5j+pUsT6sAH6WXu
 gIwBVQPiTH1r7v7doEdv4t7hcDFNDJndJw1lH7OEwDyZvduotwucOnIQqQsDtRUK0bkYtH+fvVE
 vULknocq/4ZyDDUXO/njZaim72Y6bJz80Qz2anLrjlOVv7xEDUoMcAGFwNeQ
X-Google-Smtp-Source: AGHT+IFpBl2cM9B0Dov2VxPMzHvZTaBFEE0mVSVXIF3OQibM84Ioakwy2VAAyEoypUoC9OMADjolvw==
X-Received: by 2002:a05:6402:5188:b0:5db:67a7:e74e with SMTP id
 4fb4d7f45d1cf-5db7d2f9de2mr15208176a12.13.1737405496198; 
 Mon, 20 Jan 2025 12:38:16 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:15 -0800 (PST)
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
Subject: [PATCH 13/21] hw/arm/fsl-imx8mp: Add watchdog support
Date: Mon, 20 Jan 2025 21:37:40 +0100
Message-ID: <20250120203748.4687-14-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
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
 include/hw/arm/fsl-imx8mp.h    |  7 +++++++
 hw/arm/fsl-imx8mp.c            | 28 ++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |  1 +
 4 files changed, 37 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index da0435fe55..4f964a715f 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -18,6 +18,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
+ * 3 Watchdogs
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index f019687cd2..81948a2a5e 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -20,6 +20,7 @@
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -37,6 +38,7 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
     FSL_IMX8MP_NUM_USDHCS       = 3,
+    FSL_IMX8MP_NUM_WDTS         = 3,
 };
 
 struct FslImx8mpState {
@@ -52,6 +54,7 @@ struct FslImx8mpState {
     IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
+    IMX2WdtState       wdt[FSL_IMX8MP_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
 };
@@ -234,6 +237,10 @@ enum FslImx8mpIrqs {
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
index 5897c34922..2e0cd4e911 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -231,6 +231,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_WDTS; i++) {
+        snprintf(name, NAME_SIZE, "wdt%d", i);
+        object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
+    }
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -495,6 +500,28 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
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
@@ -535,6 +562,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
         case FSL_IMX8MP_USDHC1 ... FSL_IMX8MP_USDHC3:
+        case FSL_IMX8MP_WDOG1 ... FSL_IMX8MP_WDOG3:
             /* device implemented and treated above */
             break;
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 8d796e05c8..a1910db717 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -589,6 +589,7 @@ config FSL_IMX8MP
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
     select UNIMP
+    select WDT_IMX2
 
 config FSL_IMX8MP_EVK
     bool
-- 
2.48.1


