Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCC0C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1ro-0005mb-VA; Sat, 08 Mar 2025 16:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1qs-0005Mf-0l
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:36:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1qp-0003sM-6A
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:36:57 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bc30adad5so17910095e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469813; x=1742074613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+yC7kcIFYBDlEb5elpDYxZqmpjHBPCkNQfWZnM7SA0=;
 b=BjCbZPjCwiRdfpWd2AJ8TCcOhjpi8MKu7taByejvKxvlnbmv4QiHkaqKXziS72QewF
 bPIvVg6V+V8rFOHbCOgL7rO69AX4wWBzagddevAw+0d4xXA2r9PX187OCs7T4p6jMcYI
 /7Z8doYz1PAjpqdzRyjMwrsxSc74bKbijphEsc7G54NzXVC+YpxF64ZoXV3/+H/zYCj1
 0GOMCDJeBV+sel9BFRF6JoQLcm2GPIK1JvW8ursl+CJ3ZsFBqlWyHMa+CJGKrxEU4wMu
 bZVBNRoUYqVKGEdzrZ6pYMNhkEpJO2vNETrs/CnUu25hnt9N3JI7ytQsm5Vm9KQeTtl8
 N1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469813; x=1742074613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+yC7kcIFYBDlEb5elpDYxZqmpjHBPCkNQfWZnM7SA0=;
 b=evxl20X8u/mRQ0da7z4USmXPJtaKn5ZGYAJJJMVQC1yr2UESEDyVDzA41cUNjqcDmT
 dycMiecsWHLbhMUiYzs2NhrjhpM31ihFUFs18E8jqE0yQmC4aexi2HcoIXJFPjNcCBJy
 yk90iHD2QKQ0cUPHNYhEinifd7gK01W+r0WbilroZf9lexJdZUaPj+9D9aE43DKgAj5J
 ZmePvikQhuaWBWj/zIkdOTnZJUbrE4VUfh7X3TccXtJSdYvV5fBlnGF2kqquK+qR9wc8
 +ViRtgPoIVeebbAnfMarRuPIVJlByVjc1qnJFx1r1JwE7riSSueqKmTUlK02SclHA/am
 YSFg==
X-Gm-Message-State: AOJu0YxONpxILVHG38bb1Pbsc0eKB2+16vSe39pG389zZiztTgXNwcgg
 jWdtELIe9lYrIee2CiHFiZF9WO/0WCsW/bZfOKOfEaKTS9EOQ7I+ZJkHe2hof8eNBvfYG5QB9ol
 lLCs=
X-Gm-Gg: ASbGncuL/NITF98OEr8D0YsYkWhKIhRelqyojqsT/U0g5pQXFQWCGomuRvSLfyk+wPl
 S7PWzxVFnAInyRV9iFZVoA16pRTencD1B5xsXvxy8u6ISkQuGgxAjaUnUFmxZDG+cNSd6XIw4G2
 bKDXhgzHin4dTw/3xqE6awbve7QcCURTFp1cFUOFe3BzYjPbixiZ0oq94WY5DNjKbRne/t6o50t
 JaVmtLlze/shPNqpDCzICP0fqdUZhBnd4PmLOKtiCXR0WcVVb7kykxfLaBIi/rdUpbnC1lQPvDl
 A05z3Wq9p4FVIgbo51YfP+528OadvrTl5ZFgGC2FRXKAlQTRFUHi2Ayv+dbXURpL6aeaPQB3JqS
 gE0XJeijN+/mCokPYT+oNd2fYuNF/kA==
X-Google-Smtp-Source: AGHT+IFHjkrBjNK+vU42cXFq1l4E4fzb+I1phPIj62EvXzGL93tqo+Sx7Ik+APXV8YAiPb6fOS8khA==
X-Received: by 2002:a05:600c:4fc8:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-43ce9f7da7emr21678035e9.13.1741469813197; 
 Sat, 08 Mar 2025 13:36:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e3250sm9966420f8f.61.2025.03.08.13.36.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:36:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 02/14] hw/sd/sdhci: Remove need for SDHCIState::vendor field
Date: Sat,  8 Mar 2025 22:36:28 +0100
Message-ID: <20250308213640.13138-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All instances of TYPE_IMX_USDHC set vendor=SDHCI_VENDOR_IMX.
No need to special-case it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci-internal.h |  1 -
 include/hw/sd/sdhci.h  |  4 ----
 hw/arm/fsl-imx25.c     |  2 --
 hw/arm/fsl-imx6.c      |  2 --
 hw/arm/fsl-imx6ul.c    |  2 --
 hw/arm/fsl-imx7.c      |  2 --
 hw/arm/fsl-imx8mp.c    |  2 --
 hw/sd/sdhci.c          | 14 ++++----------
 8 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 9f768c418e0..9072b06bdde 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -311,7 +311,6 @@ extern const VMStateDescription sdhci_vmstate;
     DEFINE_PROP_UINT8("endianness", _state, endianness, DEVICE_LITTLE_ENDIAN), \
     DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
     DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
-    DEFINE_PROP_UINT8("vendor", _state, vendor, SDHCI_VENDOR_NONE), \
     \
     /* Capabilities registers provide information on supported
      * features of this specific host controller implementation */ \
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 38c08e28598..48247e9a20f 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -99,7 +99,6 @@ struct SDHCIState {
     uint8_t endianness;
     uint8_t sd_spec_version;
     uint8_t uhs_mode;
-    uint8_t vendor;        /* For vendor specific functionality */
     /*
      * Write Protect pin default active low for detecting SD card
      * to be protected. Set wp_inverted to invert the signal.
@@ -108,9 +107,6 @@ struct SDHCIState {
 };
 typedef struct SDHCIState SDHCIState;
 
-#define SDHCI_VENDOR_NONE       0
-#define SDHCI_VENDOR_IMX        1
-
 /*
  * Controller does not provide transfer-complete interrupt when not
  * busy.
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 5359a6d8d3b..02214ca1a1c 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -243,8 +243,6 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
                                  IMX25_ESDHC_CAPABILITIES, &error_abort);
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
-                                 SDHCI_VENDOR_IMX, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index dc86338b3a5..a114dc0d63d 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -327,8 +327,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
                                  IMX6_ESDHC_CAPABILITIES, &error_abort);
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
-                                 SDHCI_VENDOR_IMX, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 34c4aa15cd0..ce8d3ef535f 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -531,8 +531,6 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_USDHC2_IRQ,
         };
 
-        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
-                                 SDHCI_VENDOR_IMX, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 3374018cde0..ed1f10bca26 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -471,8 +471,6 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_USDHC3_IRQ,
         };
 
-        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
-                                 SDHCI_VENDOR_IMX, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 1ea98e14635..c3f6da63220 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -524,8 +524,6 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
             { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC3].addr, FSL_IMX8MP_USDHC3_IRQ },
         };
 
-        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
-                                 SDHCI_VENDOR_IMX, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
             return;
         }
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1f45a77566c..149b748cbee 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1731,16 +1731,10 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 
     case USDHC_VENDOR_SPEC:
         s->vendor_spec = value;
-        switch (s->vendor) {
-        case SDHCI_VENDOR_IMX:
-            if (value & USDHC_IMX_FRC_SDCLK_ON) {
-                s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
-            } else {
-                s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
-            }
-            break;
-        default:
-            break;
+        if (value & USDHC_IMX_FRC_SDCLK_ON) {
+            s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
+        } else {
+            s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
         }
         break;
 
-- 
2.47.1


