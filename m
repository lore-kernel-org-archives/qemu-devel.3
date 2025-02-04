Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60F4C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF81-00057m-2q; Tue, 04 Feb 2025 04:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7j-0004yV-7D; Tue, 04 Feb 2025 04:21:39 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7h-00055I-5X; Tue, 04 Feb 2025 04:21:38 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso3057712f8f.3; 
 Tue, 04 Feb 2025 01:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660894; x=1739265694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9b9MhWB64XM3f/tyhWqPfQt24MqKWi4OOX42U2hnzc=;
 b=VcXovbvMX38BEe3iZRwwxrX2kGMxvnLr7h6BQRCUB0nfiCD4QfBeLBTElyQlm5TerW
 hPQu8K+71dc75Z37BfLc+eLSABGtcFEN/VtxofdxRshaRdsu/R1CNSVtBtUMvYBZruHA
 5BI1fvoiJvaizWmTvoEGF3yOl+tkYhmyIeFfDPRub4dEygyy3mUpN37UVAbxMnf2Nk/C
 BRzncUDUS32stWlMWd5wABRGehpAmcJguylHILNSakOEZguPZeDNHVkgzzH2xNCT2YWf
 ziB7xwgOoPZ1cCy/cAs6Z1Wyek4Oy3LGe2/I5OsWQCsgcY7Q4wfY+B9Cb4zdvSAoLRhj
 9WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660894; x=1739265694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9b9MhWB64XM3f/tyhWqPfQt24MqKWi4OOX42U2hnzc=;
 b=wG6s9z0GFYt6chLV8Yyfr10sHqzgaiC+GjhIlIzq9IRji8tz5XFfGfe80Rygws9NTk
 27U32ydogoKCZpYOiC1so2J+77LjnQW+0DeBY1rS6SKp+3HnxzIxN1qLGbKaGLNUxMc8
 6DgO8dS6xK/5TbatcoR4YDbFYD/RFseNyDKko3LZaPWoyptVcxCFejG8oXTrR2QyI5Xy
 245ey7LtrfcyVr/itSK+0apGPg2sAIrnvHy7RmdoB9PmwOEOZu9hLfnvZf32yJbT3QbX
 hs9hfNwkqkAQMC3tuVSXvRo0wvv48avau0UMGCJ4g3yued5DYfFhUChot+S1qHwfRJQ9
 sSBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL2ldJZxO4X25dF0UrzJddBFLjTqeLSC2P45T2NZLw6GZ0WLC6Q0/Cr1Hi7n76tcn1L7fh80LZrw==@nongnu.org
X-Gm-Message-State: AOJu0YyXBL1w26Dworr2+SC6oCiS56MTBZLTZqTMUUANPrbzk4r7kKZO
 wPuU723zRR5N7WjDcoeaQ/4XebreLzzI6nd5keXE3QDMhKs51UkyGoaOrQ==
X-Gm-Gg: ASbGncvMJwuuCavvmXrMmessvM0YZVVypYtH5wb6KbYXde/MvADsTCFK7fKHhuyfODr
 ntTaPZrWMbJshXt7xYdcBa0jp+mbH8z1RON+tFJkwBfxWJevL9zsLbw/qZbBW9nQfevaxu6jmqS
 y8V7hE5R4zx8fv8rbpxVcvwrI8LTUpQUSgm3ZTmchrZuNts6isTG6zwmanMXVTH8ZbcEqyI9uuY
 CSCmjMPQqUsP3Cj8y4jmGxtXGMZ7zv3+ZwW/YaSD8oNtsrCh6Ylrc2YGaO9qkGBybi2Vm9urWuF
 yj89VhmZbym9GjzCdwmoSgGsT7LZsW/EZoENnUDAY0iGdfrtjMRsm605OqK0AAV3C9amxfFXlG2
 fUZxFmldZGA==
X-Google-Smtp-Source: AGHT+IGSyZc/LUJkTextBMURD85GSkHP9M+J8hoq/cThL2dELxPbfHhGx0QbckPOBTjebj/SCnl2uw==
X-Received: by 2002:a5d:64ab:0:b0:385:f7a3:fea6 with SMTP id
 ffacd0b85a97d-38c5195f6c9mr21836594f8f.13.1738660894477; 
 Tue, 04 Feb 2025 01:21:34 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:34 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 12/18] hw/arm/fsl-imx8mp: Add watchdog support
Date: Tue,  4 Feb 2025 10:21:06 +0100
Message-ID: <20250204092112.26957-13-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
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
index eb7df2059f..15514055b5 100644
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
index fa39dfd2da..6646f1c8b4 100644
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
index 4a8695f22a..71102ac0a9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -590,6 +590,7 @@ config FSL_IMX8MP
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
     select UNIMP
+    select WDT_IMX2
 
 config FSL_IMX8MP_EVK
     bool
-- 
2.48.1


