Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88860C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaw-00014z-Fs; Tue, 27 Feb 2024 08:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaT-0000mN-Ro
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:37 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaO-0002uP-EA
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33da51fd636so2564887f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040810; x=1709645610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KGqC5ypYFTpj73/g0BzMEjHLRiV0ye31/N/3xIe2N+0=;
 b=LeSqz6ouiBiA311Y9iJpd/ReqGP43NnoVb91ASMogJbiDkVk2vr0mATBQeX4UmHqwp
 sIbqgr7uhPDx/hkmZECMX8l3rIYWfDfEedTkeVu8Zc1fPLlC43JkI3lHFMN8akQYhVcO
 6zC0SqYppU4p++YejOwyaBY2YoB3BBAyYDBYZL+VS1oIAhhAeJQTsUCZ+NDUs9iJNDRr
 AB/Dim+nRycNPvPRnaUTO9Iko9yvFqwpryG7VlApr71d2/+qntIwWV90c2NcA80sUjJO
 EEQt8BjbjK7EmMxwibCO0gRWIF74G24wdXZTTBk8PpIxIzJeELFL0Dym3YEu/K+M3bih
 MT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040810; x=1709645610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGqC5ypYFTpj73/g0BzMEjHLRiV0ye31/N/3xIe2N+0=;
 b=e7sOwJq18TluJK6Mg/cPRSGcK/pDnEt864fCE27UtqNGIqd0kD+XEhuCz+Sxu1T57g
 a3sqfJsJp004K3IJaRcBA1zB+Vu6i6NRoeCZ44aN/C8YC6n+9mwbLSs5x7f098tvb+5N
 em/qjXA29bjLGxpPJAWvkCHNzGiXCRWaRPakxT+7eikT28HvnGOmEH2EVaXlJFMm14nM
 ATz+Sk0q3TpPoPN6Ot4NrQBRnK1sfe4Elvcl3ReIWDOYMQoTJAaNX50HnOK8260HAIcr
 5fMvQQZCqG3+Gfm61DEpO0n3X7czk4XCSQNYSTU7Myn4cTlFu9TsvBVfW5hY9yrX0phh
 HMsg==
X-Gm-Message-State: AOJu0YwS13KyWKVUaEYVChRJ+5fSZXuMjnK6PkHsoqv32YOW60WLwFY6
 yFBDc/1St65OTYnoTBb8eGd28LLUDkP8R9j7m7RcuEpxnQ2dzrpBV/b8L2Ob0i2YHF62ydXrtPr
 P
X-Google-Smtp-Source: AGHT+IE/X7p2WtyDa4HObjPqLYosDJte+s2dZlP+7o4uTmHHcAq1aj5wyjnaANvPS2CRdZTIfGUt/A==
X-Received: by 2002:a5d:42c1:0:b0:33d:11e1:47d9 with SMTP id
 t1-20020a5d42c1000000b0033d11e147d9mr6202495wrr.68.1709040810526; 
 Tue, 27 Feb 2024 05:33:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/45] hw/gpio: Connect SD controller to BCM2838 GPIO
Date: Tue, 27 Feb 2024 13:32:57 +0000
Message-Id: <20240227133314.1721857-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sergey Kambalin <serg.oker@gmail.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240226000259.2752893-9-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/gpio/bcm2838_gpio.h |  5 ++++
 hw/gpio/bcm2838_gpio.c         | 52 +++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/hw/gpio/bcm2838_gpio.h b/include/hw/gpio/bcm2838_gpio.h
index 06d48e0c191..f2a57a697f2 100644
--- a/include/hw/gpio/bcm2838_gpio.h
+++ b/include/hw/gpio/bcm2838_gpio.h
@@ -14,6 +14,7 @@
 #ifndef BCM2838_GPIO_H
 #define BCM2838_GPIO_H
 
+#include "hw/sd/sd.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
@@ -29,6 +30,10 @@ struct BCM2838GpioState {
 
     MemoryRegion iomem;
 
+    /* SDBus selector */
+    SDBus sdbus;
+    SDBus *sdbus_sdhci;
+    SDBus *sdbus_sdhost;
 
     uint8_t fsel[BCM2838_GPIO_NUM];
     uint32_t lev0, lev1;
diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 69d15dbb497..2ddf62f6959 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
+#include "hw/sd/sd.h"
 #include "hw/gpio/bcm2838_gpio.h"
 #include "hw/irq.h"
 
@@ -63,6 +64,16 @@
 
 #define BYTES_IN_WORD        4
 
+/* bcm,function property */
+#define BCM2838_FSEL_GPIO_IN    0
+#define BCM2838_FSEL_GPIO_OUT   1
+#define BCM2838_FSEL_ALT5       2
+#define BCM2838_FSEL_ALT4       3
+#define BCM2838_FSEL_ALT0       4
+#define BCM2838_FSEL_ALT1       5
+#define BCM2838_FSEL_ALT2       6
+#define BCM2838_FSEL_ALT3       7
+
 static uint32_t gpfsel_get(BCM2838GpioState *s, uint8_t reg)
 {
     int i;
@@ -86,6 +97,31 @@ static void gpfsel_set(BCM2838GpioState *s, uint8_t reg, uint32_t value)
             s->fsel[index] = fsel;
         }
     }
+
+    /* SD controller selection (48-53) */
+    if (s->sd_fsel != BCM2838_FSEL_GPIO_IN
+        && (s->fsel[48] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[49] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[50] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[51] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[52] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[53] == BCM2838_FSEL_GPIO_IN)
+       ) {
+        /* SDHCI controller selected */
+        sdbus_reparent_card(s->sdbus_sdhost, s->sdbus_sdhci);
+        s->sd_fsel = BCM2838_FSEL_GPIO_IN;
+    } else if (s->sd_fsel != BCM2838_FSEL_ALT0
+               && (s->fsel[48] == BCM2838_FSEL_ALT0) /* SD_CLK_R */
+               && (s->fsel[49] == BCM2838_FSEL_ALT0) /* SD_CMD_R */
+               && (s->fsel[50] == BCM2838_FSEL_ALT0) /* SD_DATA0_R */
+               && (s->fsel[51] == BCM2838_FSEL_ALT0) /* SD_DATA1_R */
+               && (s->fsel[52] == BCM2838_FSEL_ALT0) /* SD_DATA2_R */
+               && (s->fsel[53] == BCM2838_FSEL_ALT0) /* SD_DATA3_R */
+              ) {
+        /* SDHost controller selected */
+        sdbus_reparent_card(s->sdbus_sdhci, s->sdbus_sdhost);
+        s->sd_fsel = BCM2838_FSEL_ALT0;
+    }
 }
 
 static int gpfsel_is_out(BCM2838GpioState *s, int index)
@@ -266,6 +302,11 @@ static void bcm2838_gpio_reset(DeviceState *dev)
 
     memset(s->fsel, 0, sizeof(s->fsel));
 
+    s->sd_fsel = 0;
+
+    /* SDHCI is selected by default */
+    sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci);
+
     s->lev0 = 0;
     s->lev1 = 0;
 
@@ -304,6 +345,8 @@ static void bcm2838_gpio_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
+    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, DEVICE(s), "sd-bus");
+
     memory_region_init_io(&s->iomem, obj, &bcm2838_gpio_ops, s,
                           "bcm2838_gpio", BCM2838_GPIO_REGS_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
@@ -312,7 +355,14 @@ static void bcm2838_gpio_init(Object *obj)
 
 static void bcm2838_gpio_realize(DeviceState *dev, Error **errp)
 {
-    /* Temporary stub. Do nothing */
+    BCM2838GpioState *s = BCM2838_GPIO(dev);
+    Object *obj;
+
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhci", &error_abort);
+    s->sdbus_sdhci = SD_BUS(obj);
+
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhost", &error_abort);
+    s->sdbus_sdhost = SD_BUS(obj);
 }
 
 static void bcm2838_gpio_class_init(ObjectClass *klass, void *data)
-- 
2.34.1


