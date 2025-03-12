Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE726C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJ7N-0001Tl-A3; Wed, 12 Mar 2025 06:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJ7E-0001NM-HH
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:15:09 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJ7B-00073A-VN
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:15:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so38749475e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741774503; x=1742379303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwsN7Sji2LRfEhBwDQKA18+pD8AQLk8f7ip/gMXP/tM=;
 b=RhS/mYtKmupJhH5DMpKYMqH5gtd0cB/YzRW84RQaleR4/whjvRd/V4jFxqIems46pe
 hVoa69voHel6Ys01fjgTJE14NuwGQmGMPn9tgYtj482PiSWsuwQZ0QiNuIFISju+IH+U
 s0lZpi3GA/odruCn19AXB+yznU3dovyOvTuQxp49T7vL8hDfaMcdgksN7AMKPokDMGyY
 /47tkYfwVRVx/pVdxq69UVpO61QEPZtAFxwizZG1Y2Nh+PvgVbLjo6mCsX3rsxRPzIia
 Jw5hgszGLJgIr9EC7G2k0t9hV/jmqRgM9Wx0ftywYM0gfO3zM/4Adwk43JW5VbXynKUC
 2udA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741774503; x=1742379303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwsN7Sji2LRfEhBwDQKA18+pD8AQLk8f7ip/gMXP/tM=;
 b=qidWgl60k/Twv5WPqbc8pfg6/HEUQjHeaZr1VH+lP0CqQhT554yxxb2PaRarOgEGwu
 qdEnuooRPkc2EF0gHcUV8csbD1iln8qoF8gNTXXxopdoKjflCzQOEngavSEkJHzpWa9b
 2I9zFRoWxoP2HlridHDmHM7BsQ85Y+nrjDe+421OI75Aleeu4yZTw08gAMZiBq0iLMI9
 /YMj50gS3rZHq8KZXKV0tRjQ1UFCNhHBwpDPJgf9CSB7MxCae0lCMJVec1leJoisNywn
 4MImVzQcyjmK8nSwzuNzAHOwzPlMxo2J1oUAW/yzk6577UxvGtqmy8WMgjKpSsCZ3lL/
 DFRg==
X-Gm-Message-State: AOJu0YyM7Izv6mDiTcpYdPP7XO+gx8sPLdoKApefTcrSvXZU197QrTlE
 NuGQ/qhD4ZGog8Waqwimuf8pLJBk8Bt6iV/fOT6ieuBGGK2XnXOiHL0cQwjXI4wWyN1TnJuPnR2
 S
X-Gm-Gg: ASbGncsT6zV8zyhij9AAfr5Q32akSIHgGLqXomojU30xKZvHnkgmlPw8oePgIr/Gtgo
 BrWBTRt7sv80QcnvjRrJMe5ml4LMSTKO5NOR86yIlJ2HS/zf9iFfIqwIvOOcExm8NgZqN3CjtTZ
 WHEg6Qo9TT2Bt74jp7umzFB44UYJ0oJT4zob3jr7VufAn/G7f7KtKTsBUg1jehidncARKzWvIDQ
 KV/U2l1757RFKo5DfvrqBEfmb41vJxSwpzBau61ccwxJQEYxVj1cYJpcgWEEtYwhDTJM6zh3RDC
 02SUYcN2YzwHO8xJriXXz6nH4bSjO4XyxpcpFAmF0+yFTfEFXaPH5QeJfVTFBMxUFcZ/WsDG+4l
 c/hhjjsi2A8yEcQ==
X-Google-Smtp-Source: AGHT+IEy+7Mf6XiOIVpcFbM+w+w8xx1HoqdsIIKQ4yxPwBnG3TRJQZ+kp43L5vBImUm/JbpBlvNp8A==
X-Received: by 2002:a05:600c:3542:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-43d01bdbc01mr81484055e9.10.1741774503435; 
 Wed, 12 Mar 2025 03:15:03 -0700 (PDT)
Received: from localhost.localdomain (99.167.185.81.rev.sfr.net.
 [81.185.167.99]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a72eeecsm16584845e9.3.2025.03.12.03.15.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Mar 2025 03:15:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>
Subject: [PULL v2 14/14] hw/sd/sdhci: Remove need for SDHCI_VENDOR_IMX
 definition
Date: Wed, 12 Mar 2025 11:14:55 +0100
Message-ID: <20250312101455.99631-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312101455.99631-1-philmd@linaro.org>
References: <20250312101455.99631-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

All instances of TYPE_IMX_USDHC set vendor=SDHCI_VENDOR_IMX.
No need to special-case it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20250308213640.13138-3-philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  1 -
 hw/arm/fsl-imx25.c    |  2 --
 hw/arm/fsl-imx6.c     |  2 --
 hw/arm/fsl-imx6ul.c   |  2 --
 hw/arm/fsl-imx7.c     |  2 --
 hw/arm/fsl-imx8mp.c   |  2 --
 hw/sd/sdhci.c         | 14 ++++----------
 7 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index f722d8eb1cc..51fb30ea528 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -109,7 +109,6 @@ struct SDHCIState {
 typedef struct SDHCIState SDHCIState;
 
 #define SDHCI_VENDOR_NONE       0
-#define SDHCI_VENDOR_IMX        1
 #define SDHCI_VENDOR_FSL        2
 
 /*
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
index fe87e18d5d2..69baf73ae9b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1735,16 +1735,10 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 
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


