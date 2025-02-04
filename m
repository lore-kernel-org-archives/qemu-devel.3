Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D68C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF81-00057n-3s; Tue, 04 Feb 2025 04:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7i-0004xO-6w; Tue, 04 Feb 2025 04:21:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7g-000553-8f; Tue, 04 Feb 2025 04:21:37 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so36472845e9.2; 
 Tue, 04 Feb 2025 01:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660894; x=1739265694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpJHicVT0FshEM/1uOuPzVqalFFdkNXqbR5+B54/jBU=;
 b=DVT38+hBAZNZT6UDgrNyyFDzn58ATmghg7fpvwjF75nVJhlLoZF+SMSvQ9yuHl6Qhs
 W7j6S1DLkWzoUe813dhErA50PfZZgbOzV1yXLlliN5s2qT6ODPiuB2Kvrw8Mkfu9Z1gw
 dzp6dm9LJqG7VrpFyHoYiV0xKr6uhKpocLKL8UhvNrHig33tTd4sd45yv+8iMzEk+eED
 MjDK91gEkjuMR6vpOCGaV4oG138oRQ5bTKKDlyx1J/VAfb/N3R7Nvyk+eq6nWoH18Ov/
 Yoj0y6x3kNHLm0qswbLeOv5xbBPLiCxtDx5YFZf2u+KJNgvLIXd3+DG27JrG9Ridenzi
 hQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660894; x=1739265694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpJHicVT0FshEM/1uOuPzVqalFFdkNXqbR5+B54/jBU=;
 b=rX5Bed/FlQIWOHAhQPL6EOGuNC0bkHw5z7UdJ3C2yqArxxlXdvsM7iipxqEM03G8Bf
 6laJ5RfyW4qCVQAwmqlN2d75DAu6XgY1AbDpVNVked246lTV2zEBPA7LwJ96YWtvNZ07
 876bG5L7toerPwmm8IST0P7gq2qGIaXFLV7D6TDMjUQGI+gd+99PXLdqCd20oDwhXUIS
 fJyq42uqVoIdxnVCkDMD91LGmf15z7dOdmNk5x7R7RUMphe+dR+hn39ZtHcoPsb+ppTU
 afd6KOG4ll5os2ts4L/tVZ6+t8HI8XcJFOn7y1bzzyamA7a345O0+yU02XASQF1JF15g
 nJPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfScKK1BUXW5Upz0OeJjXaJYiCo6+OJnHnaXO/EGVjEQmtPn/f4zi96cDDUiTjdGTP9fmnTxBbHw==@nongnu.org
X-Gm-Message-State: AOJu0YwV/TqwgO8V7zz62K6Urmv8yrtAoRngtFDP4YVXtpl97zMfJObZ
 OXN8TlU+yhwU8LMJwy2uUTrvrVBWdv21lzTBJAUUGRhlGXAVA6blqk2IYA==
X-Gm-Gg: ASbGncuk2XRXUguy+6gqSkXpZymFUMCNHKk09lu70e/edQW4PmahdGMLiPqydBNpn6A
 XBQZJhVvBb+XZ4SNXPrmEG9aHS9vAT4+D9MzbSRfFJXn5qeJm95zKdzIpvNHnklnD4uFkaCcETA
 +hc1S4lVI+Al6zEu5fmNaB/biMFZ8zdz+Dpl7qj803/A6YV1YjKK5oub3DuuRNNpeDcRvS52Sxx
 hkjcGlMh2MX+KfDYhhbXlSdCxtobXfwkRbSSVgycK+3bmhysn2Ua76ys2vJu96olLO9rKgCiAvv
 PpwjmKtlyDmZenD9NDCbGs6PJsrssc8tG/FSrdND4siDlstFXNDkQ07hbGpGNjLIXWo14Ax2xl8
 aq/ijAad4MA==
X-Google-Smtp-Source: AGHT+IGDNL0RcR25CXj/hZMLBVrtPLIwVAERajSxDT7CBoq4uXhcIfgynDLfSWbqRSqKc0IIVCY9hQ==
X-Received: by 2002:a05:600c:3d19:b0:431:6083:cd38 with SMTP id
 5b1f17b1804b1-438dc3a81ccmr204265755e9.6.1738660893775; 
 Tue, 04 Feb 2025 01:21:33 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:32 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 11/18] hw/arm/fsl-imx8mp: Add SPI controllers
Date: Tue,  4 Feb 2025 10:21:05 +0100
Message-ID: <20250204092112.26957-12-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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
 include/hw/arm/fsl-imx8mp.h    |  8 ++++++++
 hw/arm/fsl-imx8mp.c            | 26 ++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index e63c5b7118..eb7df2059f 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -17,6 +17,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 1 Designware PCI Express Controller
  * 5 GPIO Controllers
  * 6 I2C Controllers
+ * 3 SPI Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 2590056627..296a87eb50 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -20,6 +20,7 @@
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
+#include "hw/ssi/imx_spi.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -31,6 +32,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 
 enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
+    FSL_IMX8MP_NUM_ECSPIS       = 3,
     FSL_IMX8MP_NUM_GPIOS        = 5,
     FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
@@ -47,6 +49,7 @@ struct FslImx8mpState {
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
+    IMXSPIState        spi[FSL_IMX8MP_NUM_ECSPIS];
     IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
@@ -208,6 +211,11 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_UART5_IRQ    = 30,
     FSL_IMX8MP_UART6_IRQ    = 16,
 
+    FSL_IMX8MP_ECSPI1_IRQ   = 31,
+    FSL_IMX8MP_ECSPI2_IRQ   = 32,
+    FSL_IMX8MP_ECSPI3_IRQ   = 33,
+    FSL_IMX8MP_ECSPI4_IRQ   = 34,
+
     FSL_IMX8MP_I2C1_IRQ     = 35,
     FSL_IMX8MP_I2C2_IRQ     = 36,
     FSL_IMX8MP_I2C3_IRQ     = 37,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 1971c76aaa..fa39dfd2da 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -226,6 +226,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_ECSPIS; i++) {
+        snprintf(name, NAME_SIZE, "spi%d", i + 1);
+        object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
+    }
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -463,6 +468,26 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
     }
 
+    /* ECSPIs */
+    for (i = 0; i < FSL_IMX8MP_NUM_ECSPIS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } spi_table[FSL_IMX8MP_NUM_ECSPIS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_ECSPI1].addr, FSL_IMX8MP_ECSPI1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_ECSPI2].addr, FSL_IMX8MP_ECSPI2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_ECSPI3].addr, FSL_IMX8MP_ECSPI3_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           qdev_get_gpio_in(gicdev, spi_table[i].irq));
+    }
+
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
         return;
@@ -502,6 +527,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
+        case FSL_IMX8MP_ECSPI1 ... FSL_IMX8MP_ECSPI3:
         case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
-- 
2.48.1


