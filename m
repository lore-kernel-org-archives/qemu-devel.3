Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48E3C9EC98
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJJi-0007i1-0q; Mon, 12 Jan 2026 09:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJe-0007dC-8y
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:46 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJb-0001W6-P6
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:45 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b8718187eb6so167283866b.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768229680; x=1768834480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ajg8LOL78oqsr/dK0/gBGuSs986fyLyreKG66qhOt5s=;
 b=SeOxX0ghPi0d7cmaa3vGutUuwNZXm7b8W8YtEY3rAniUG59tYTsQrA37xdV23vYAsf
 Cv3Yolst86zfulwbF6wkRx2bS6xywYcP9LclrTRq+/WT4sZHhwhmlGaBK7E0nAjQfjEI
 RzUp7iRQLQHceRrnqzSHaOTJDd9ESS/jQOhE/tkmm07dy9NAroiSzIczc5xYPTJDyQmd
 eelc3CfXcxyEOfbDgLIcvplAib/vxxkus7T4Oh6fxNs2r3hp0jUi5TwwWOvtFQFIfP2F
 WlZFIV5Up1zyRxcZ+qCR+5EgBnXMTmfI+yqr07qAzFEydC1cToZ6rUrwY+J/V9LTmi2Q
 BWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229680; x=1768834480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ajg8LOL78oqsr/dK0/gBGuSs986fyLyreKG66qhOt5s=;
 b=csaKFIQyYFJeCbgaOLG97DlGAhXtv8Ab7MFIkjpjESac5uFkQAee0otWzB1dOTRYDo
 snoP5GqXWqty1K9xuEtbs0xXrOCXNM3XpdeOEOIvGQQCvEHwwijc+SjOITVtTu0y6Qq9
 S2bjTOyR2ix9p1E5P7gH/+DphBYUbhD8GKgUd+00vjF9h/hOWxN8UvDa9FbPqXZsICxf
 qCfj3FWnwmnEeR337hp78Sik0+WCRzeKyqyFoKpicPXEebiAWQWBSha74eR072Ylo2KY
 iX/XCPxCjnQC4+IPlzGGF1WGHFF7JtAOZZ3xHJifIJFgA5VpC5PUSjCDZQxxfkduARAW
 ndQA==
X-Gm-Message-State: AOJu0YxAmyZbJ0qP7X5qb/OSpbQ2n6O6+hN0nJlIPk4KppDqzq+hAIN8
 VgcWGvnKvccbKzLq6EuS7bniBJdedTj0ta/3BinElRb4WaCuSCLvwpmh7u23Y6KA
X-Gm-Gg: AY/fxX4XCDBbEKeOOF8kd4UxmRwgHlBEarbi7G348PlIcEBoCiDwCKLZn3aRJ4MNwSB
 abzdMGV4acmt27K4M3nC7wKXlQjXayBf2FTb/xpKtwluZmqDGqGEjn2TahUD0bIMDFUPJifHhns
 HpwYRJIF5TNvAtXlYjQqBnVGvj/y+5sldTOdYHIgozW/rM2ASl27nLy617XC0VPk6Ah9S69IwYq
 MVnPkBToUqjNdVmlo0NOdLvinWkjcgkvu6ol4a2PbU6yO/W/Q5isiweIh9vcUQHZPM9wzahVEmN
 eWnQJMAMfZ9G02Ks80Y1zu3rqp3xk6y+kmvAxfSliM1Qvs2iDYJukRijKClHd/Z246BMi5H6AC+
 4uCtnx7eE3pOciBjG4XFWwAL/mZJnGz2kceFglgNGrMW8O3llR629NWgFQ/8g0IeCqNoMVOSsxY
 3UwkzhQz7LtwZTVBcQEvt41n97vaxHaf65dC6B2TQQXQCpEdUeZ+6+nnrEx26q+QZEU8/iFOIG
X-Google-Smtp-Source: AGHT+IHt6hvwrkl2S51/GHXcSlJ2ZrVxeImVfSHIsHfBTTwgtjxtM7ExNgN+idBCW+UV8wr5hQaq0g==
X-Received: by 2002:a17:907:6ea6:b0:b87:2780:1b1e with SMTP id
 a640c23a62f3a-b8727804cfemr177722366b.41.1768229680425; 
 Mon, 12 Jan 2026 06:54:40 -0800 (PST)
Received: from archlinux (dynamic-077-188-226-222.77.188.pool.telefonica.de.
 [77.188.226.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8731f0718asm37387966b.67.2026.01.12.06.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:54:40 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 03/14] hw/arm/fsl-imx6: Fix naming of SDHCI related constants
 and attributes
Date: Mon, 12 Jan 2026 15:54:07 +0100
Message-ID: <20260112145418.220506-4-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
References: <20260112145418.220506-1-shentey@gmail.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The i.MX 6 SoC features uSDHC controllers which are the successors of eSDHC.
Fix the naming to make this clear.

Fixes: ec46eaa83a3c ("i.MX: Add i.MX6 SOC implementation.")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx6.h |  4 ++--
 hw/arm/fsl-imx6.c         | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 5520473ba0..bb866994df 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -46,7 +46,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6State, FSL_IMX6)
 #define FSL_IMX6_NUM_EPITS 2
 #define FSL_IMX6_NUM_I2CS 3
 #define FSL_IMX6_NUM_GPIOS 7
-#define FSL_IMX6_NUM_ESDHCS 4
+#define FSL_IMX6_NUM_USDHCS 4
 #define FSL_IMX6_NUM_ECSPIS 5
 #define FSL_IMX6_NUM_WDTS 2
 #define FSL_IMX6_NUM_USB_PHYS 2
@@ -67,7 +67,7 @@ struct FslIMX6State {
     IMXEPITState       epit[FSL_IMX6_NUM_EPITS];
     IMXI2CState        i2c[FSL_IMX6_NUM_I2CS];
     IMXGPIOState       gpio[FSL_IMX6_NUM_GPIOS];
-    SDHCIState         esdhc[FSL_IMX6_NUM_ESDHCS];
+    SDHCIState         usdhc[FSL_IMX6_NUM_USDHCS];
     IMXSPIState        spi[FSL_IMX6_NUM_ECSPIS];
     IMX2WdtState       wdt[FSL_IMX6_NUM_WDTS];
     IMXUSBPHYState     usbphy[FSL_IMX6_NUM_USB_PHYS];
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 46967b7488..39667c4a49 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -79,9 +79,9 @@ static void fsl_imx6_init(Object *obj)
         object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
     }
 
-    for (i = 0; i < FSL_IMX6_NUM_ESDHCS; i++) {
+    for (i = 0; i < FSL_IMX6_NUM_USDHCS; i++) {
         snprintf(name, NAME_SIZE, "sdhc%d", i + 1);
-        object_initialize_child(obj, name, &s->esdhc[i], TYPE_IMX_USDHC);
+        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_USB_PHYS; i++) {
@@ -311,11 +311,11 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
 
     /* Initialize all SDHC */
-    for (i = 0; i < FSL_IMX6_NUM_ESDHCS; i++) {
+    for (i = 0; i < FSL_IMX6_NUM_USDHCS; i++) {
         static const struct {
             hwaddr addr;
             unsigned int irq;
-        } esdhc_table[FSL_IMX6_NUM_ESDHCS] = {
+        } esdhc_table[FSL_IMX6_NUM_USDHCS] = {
             { FSL_IMX6_uSDHC1_ADDR, FSL_IMX6_uSDHC1_IRQ },
             { FSL_IMX6_uSDHC2_ADDR, FSL_IMX6_uSDHC2_IRQ },
             { FSL_IMX6_uSDHC3_ADDR, FSL_IMX6_uSDHC3_IRQ },
@@ -323,13 +323,13 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         /* UHS-I SDIO3.0 SDR104 1.8V ADMA */
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
+        object_property_set_uint(OBJECT(&s->usdhc[i]), "capareg",
                                  IMX6_ESDHC_CAPABILITIES, &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
             return;
         }
-        sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->esdhc[i]), 0,
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, esdhc_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
                            qdev_get_gpio_in(gic, esdhc_table[i].irq));
     }
 
-- 
2.52.0


