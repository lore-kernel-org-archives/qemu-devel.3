Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4400AC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzM4-0006Uz-DK; Tue, 25 Feb 2025 13:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJl-0000LJ-4p
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:12 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJf-0002Ml-8l
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:03 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso51751f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506756; x=1741111556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lpJldWyhvK0u3UuLZitJZjzUO1O37LpZkKZ6sW7L+AQ=;
 b=NLBNrKK2S47wdg+4zml3pLNb7FdRGp9jEJ7xA2+hH5plLchKDBB2GQMYbYz07oRZF9
 cuf6KBXu8jCbB1s+U0AvWQ/u+Oxa8gbwwe6l/u0LFtdvml+D5Q4LRNN/YXTOZrnEA+xb
 vV8f0rJO4/VdvRaTcB04qv177i54OcGTG2I//m5M4Iif/huza06eLeNsr3bXBPYoPEUO
 oqWxO7IyIQj5gEfOerVugYP0XEpWVLOZjlzoOCKxIKcZpKfMO0Az8Ayr4sdbDqKF9ykG
 ukLpVtzaEbShFJT7htoyICGKXiHfsknjV3+elXjLvLLT/fPhSoOQ+dIhZrbfwahspYCX
 80pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506756; x=1741111556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lpJldWyhvK0u3UuLZitJZjzUO1O37LpZkKZ6sW7L+AQ=;
 b=wlmZi+A8c81LAoE37UyyiIbAwikrAkx2lf1EzbKPJcd6G8qbjNDPTt5MLqACFx+VJO
 XhWamsl/mJVCTgUAM0P8GOx9SvNKVCJCgGkw0kfLeiURVpoNaogTV2MhLxadhuPJ6nvZ
 e7VZrd22dihtNdFeg42ZZsvvlICKNZihRufeE5rVmHHcAmg3FcwLw6NpmBxIz4mJh4CV
 kqjTlDXOm7c97l3wQ2mqNz4yFGCSatHs00lGjuj0j/DG8Vfd3/nM35HeRf+mTKbDLHwg
 bgPniqLugUDjW1D3H5x59o5uJ0PN5u5E5b6udMR98MjaDreEqAX5D0LpIjPxIF/b++qB
 1dxw==
X-Gm-Message-State: AOJu0YzWR7/kWNR7p/qb71SdJXnVo8z3JElQ/tJOktsJ1CaFYh8HeFb5
 9F/F2F+aFA9iUPUHIsmRl1xQMFmI2WadLmeXnsPrhvXNGyU2Zv6h2USYM3kzXyzLg1Ty1zdSlri
 h
X-Gm-Gg: ASbGncsb8b8bsjcDJ256IpJ6szm3cKWpTT3M+hdrrJQM5dgsDPbzJWThW2bsngldthu
 3a0GOBiuxDoIlAS1WLDgb0tH4swl8epAf5zSBDyxt66hb8JpmxfCPeqiQXfMIOEYDtjrsJKjMpT
 RO7xFWk29bh1POCe1iCdyi6fUkeSKGtGRTjqR+YmvVTLZnaIkHWolnf5qPGNIhuvrBEzhaolwGY
 N49xaSvr9XlGAdLdotmmQGTa9hxnGjyjmnBBJjssxsTZ874iXEopZ6+vqDlDEPQc0+YNOr3KhqS
 QV7aBzQVy5/S49S56EquJZQI+Edt/f3/
X-Google-Smtp-Source: AGHT+IGpI3eu+I8C62gypsewBykxBH0c6QzHwZ5mvgFL4epOXBvKUBtf3lVY/eHmTrSH1glcDLftBw==
X-Received: by 2002:a05:6000:4601:b0:38d:e363:494b with SMTP id
 ffacd0b85a97d-38f614b6e05mr17785156f8f.8.1740506755823; 
 Tue, 25 Feb 2025 10:05:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/43] hw/arm/fsl-imx8mp: Add SPI controllers
Date: Tue, 25 Feb 2025 18:05:04 +0000
Message-ID: <20250225180510.1318207-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
Message-id: 20250223114708.1780-12-shentey@gmail.com
[PMM: drop static const from spi_table for GCC 7.5]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    |  8 ++++++++
 hw/arm/fsl-imx8mp.c            | 26 ++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index ef0d997250b..66e58651079 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -16,6 +16,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 1 Designware PCI Express Controller
  * 5 GPIO Controllers
  * 6 I2C Controllers
+ * 3 SPI Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 25900566272..296a87eb504 100644
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
index 750dbf9eab9..63f07eca8a4 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -223,6 +223,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_ECSPIS; i++) {
+        g_autofree char *name = g_strdup_printf("spi%d", i + 1);
+        object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
+    }
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -459,6 +464,26 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
     }
 
+    /* ECSPIs */
+    for (i = 0; i < FSL_IMX8MP_NUM_ECSPIS; i++) {
+        struct {
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
@@ -498,6 +523,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
+        case FSL_IMX8MP_ECSPI1 ... FSL_IMX8MP_ECSPI3:
         case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
-- 
2.43.0


