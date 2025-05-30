Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD97C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBc-00020s-0Z; Fri, 30 May 2025 08:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBX-00020U-A2
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBR-0001cj-FO
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442f4a3a4d6so12632245e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609398; x=1749214198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C0W1BuPIUQgNPV7dMFC8ap0qCTYM2rhxKm0rzwEBiDM=;
 b=yXBq1yMWCCw8PjQV+KIzdYL9zpymXeQNsxeg2l0z5XzvUZc95OjsP4CzemE9oZwn/J
 LfdpSZNSp7b5FH3gCMb+SLQqTWbLA8mfiJBv9wEzW2n85IRklTk2PAvyTX5TPLEvBj9c
 ZESfcE1WFAECZGMoeS5JHp2jvhwl7afArKMpMnBDaubfrbgyY1F3bFBK48IfbCMuhj+f
 B5L+TiOLAdgxofN+gsKvWXmVlzUYiD41jDeFH1W0rtMPwUFYjrn9SuQdYXKHFlxTmP2y
 nYd8v8ujAaA27D2bGL6lD1yL1J8FXCalK9x62KphH65aUnMlHJJ4b+5/a+Kw5sTSXTRa
 tlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609398; x=1749214198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0W1BuPIUQgNPV7dMFC8ap0qCTYM2rhxKm0rzwEBiDM=;
 b=awHwCSAPoNMuoPMWprtMeEGR60S86af5sH/dlFHMM1hqvuAGdc8JK6azly3wft3pYr
 A6vhisqf3BsMGIMkmJ2db6W/OjpPE4VzMAowCV8e+z4SjmK0QkhDB/xJfOQYe7h+YJ1B
 nAX083bAw6bhueqerjcGaIMQCBef1vNOr+wi3uMBxBT2RZgzPaIv4w5BGt5WBnqgSOYt
 WG4NFLUwCgiMkb5TjD7CP5T4hs0ekLORTFJdRUIiKa6K1+dW5yuIQaLFLm0S+7ZctqkL
 P7PgQfRpN6gOdPrCW9P6eCxWvOCE0kkGkTyNfaNuhC+oQD7wuclmrSmOTtt0IWC1PCgs
 x+Lg==
X-Gm-Message-State: AOJu0YwRJQjdi57QAt29HfHC6FAKtcfd7h2K/Hlb6/EE/TMtlQVhSAsn
 ///72wv2IJUwKZ7R1XMsJeK/iLw0iVR3jjtsB+DvOHhqFgiXhhHJYr29TvIJeBQuFUwZhZYuW39
 Zt3J6
X-Gm-Gg: ASbGncvvijcTc1shSU9wh8fR8WXfTWCzB2RRycI64phmXPCqO5x1If/PR35ZcVTOR0U
 9He4l4pkOXLpTAKGV4aM/uh9baJA5DcTPeLVx8eansOcSWNMbVLmwRIsvx4HUdYaYSO/EL+jZZT
 t0qQRqVg94TP5PIY8lBNLWLdc8m0/khH3694m5Z9hrpss5ssni9O7lPff/JJO8my4iBCQy2Hbcd
 cUDT0iZkXocf/jRm0ca9YGN2zp0bNCBjC+sPkYG67GFcSNMypjINIrUfE4Yn83+u0r84u5o1rIb
 R1R5X47wVktVHhPMt4hHkVkE29L0h8vnTf46QqEYlj3XSRMyhXkO0SR5ug==
X-Google-Smtp-Source: AGHT+IGAt5DrntpUNuLFywSCCJ9ZQKav4fMM1eK4U60IdnZKWvlq4AiuUjzpk0qta1mqBTQBlhCNuA==
X-Received: by 2002:a05:600c:6992:b0:44a:b468:87b1 with SMTP id
 5b1f17b1804b1-450d6b3ed5amr28999525e9.4.1748609398361; 
 Fri, 30 May 2025 05:49:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.49.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:49:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/15] hw/arm: Add GMAC devices to NPCM8XX SoC
Date: Fri, 30 May 2025 13:49:38 +0100
Message-ID: <20250530124953.383687-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Hao Wu <wuhaotsh@google.com>

The GMAC was originally created for the 8xx machine. During upstreaming
both the GMAC and the 8XX we removed it so they would not depend on each
other for the process, that connection should be added back in.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Message-id: 20250508220718.735415-2-nabihestefan@google.com
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/npcm8xx.h |  5 +++-
 hw/arm/npcm8xx.c         | 54 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
index 3436abff998..a8377db4905 100644
--- a/include/hw/arm/npcm8xx.h
+++ b/include/hw/arm/npcm8xx.h
@@ -28,7 +28,8 @@
 #include "hw/misc/npcm7xx_mft.h"
 #include "hw/misc/npcm7xx_pwm.h"
 #include "hw/misc/npcm7xx_rng.h"
-#include "hw/net/npcm7xx_emc.h"
+#include "hw/net/npcm_gmac.h"
+#include "hw/net/npcm_pcs.h"
 #include "hw/nvram/npcm7xx_otp.h"
 #include "hw/sd/npcm7xx_sdhci.h"
 #include "hw/timer/npcm7xx_timer.h"
@@ -99,6 +100,8 @@ struct NPCM8xxState {
     EHCISysBusState     ehci[2];
     OHCISysBusState     ohci[2];
     NPCM7xxFIUState     fiu[3];
+    NPCMGMACState       gmac[4];
+    NPCMPCSState        pcs;
     NPCM7xxSDHCIState   mmc;
     NPCMPSPIState       pspi;
 };
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index d7ee306de7a..d14bf55cd71 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -67,6 +67,9 @@
 /* SDHCI Modules */
 #define NPCM8XX_MMC_BA          0xf0842000
 
+/* PCS Module */
+#define NPCM8XX_PCS_BA          0xf0780000
+
 /* PSPI Modules */
 #define NPCM8XX_PSPI_BA         0xf0201000
 
@@ -85,6 +88,10 @@ enum NPCM8xxInterrupt {
     NPCM8XX_ADC_IRQ             = 0,
     NPCM8XX_PECI_IRQ            = 6,
     NPCM8XX_KCS_HIB_IRQ         = 9,
+    NPCM8XX_GMAC1_IRQ           = 14,
+    NPCM8XX_GMAC2_IRQ,
+    NPCM8XX_GMAC3_IRQ,
+    NPCM8XX_GMAC4_IRQ,
     NPCM8XX_MMC_IRQ             = 26,
     NPCM8XX_PSPI_IRQ            = 28,
     NPCM8XX_TIMER0_IRQ          = 32,   /* Timer Module 0 */
@@ -260,6 +267,14 @@ static const hwaddr npcm8xx_smbus_addr[] = {
     0xfff0a000,
 };
 
+/* Register base address for each GMAC Module */
+static const hwaddr npcm8xx_gmac_addr[] = {
+    0xf0802000,
+    0xf0804000,
+    0xf0806000,
+    0xf0808000,
+};
+
 /* Register base address for each USB host EHCI registers */
 static const hwaddr npcm8xx_ehci_addr[] = {
     0xf0828100,
@@ -444,6 +459,11 @@ static void npcm8xx_init(Object *obj)
         object_initialize_child(obj, "mft[*]", &s->mft[i], TYPE_NPCM7XX_MFT);
     }
 
+    for (i = 0; i < ARRAY_SIZE(s->gmac); i++) {
+        object_initialize_child(obj, "gmac[*]", &s->gmac[i], TYPE_NPCM_GMAC);
+    }
+    object_initialize_child(obj, "pcs", &s->pcs, TYPE_NPCM_PCS);
+
     object_initialize_child(obj, "mmc", &s->mmc, TYPE_NPCM7XX_SDHCI);
     object_initialize_child(obj, "pspi", &s->pspi, TYPE_NPCM_PSPI);
 }
@@ -668,6 +688,35 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(sbd, 0, npcm8xx_irq(s, NPCM8XX_MFT0_IRQ + i));
     }
 
+    /*
+     * GMAC Modules. Cannot fail.
+     */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_gmac_addr) != ARRAY_SIZE(s->gmac));
+    for (i = 0; i < ARRAY_SIZE(s->gmac); i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->gmac[i]);
+
+        /* This is used to make sure that the NIC can create the device */
+        qemu_configure_nic_device(DEVICE(sbd), false, NULL);
+
+        /*
+         * The device exists regardless of whether it's connected to a QEMU
+         * netdev backend. So always instantiate it even if there is no
+         * backend.
+         */
+        sysbus_realize(sbd, &error_abort);
+        sysbus_mmio_map(sbd, 0, npcm8xx_gmac_addr[i]);
+        /*
+         * N.B. The values for the second argument sysbus_connect_irq are
+         * chosen to match the registration order in npcm7xx_emc_realize.
+         */
+        sysbus_connect_irq(sbd, 0, npcm8xx_irq(s, NPCM8XX_GMAC1_IRQ + i));
+    }
+    /*
+     * GMAC Physical Coding Sublayer(PCS) Module. Cannot fail.
+     */
+    sysbus_realize(SYS_BUS_DEVICE(&s->pcs), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcs), 0, NPCM8XX_PCS_BA);
+
     /*
      * Flash Interface Unit (FIU). Can fail if incorrect number of chip selects
      * specified, but this is a programming error.
@@ -741,12 +790,7 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm8xx.ahbpci",       0xf0400000,   1 * MiB);
     create_unimplemented_device("npcm8xx.dap",          0xf0500000, 960 * KiB);
     create_unimplemented_device("npcm8xx.mcphy",        0xf05f0000,  64 * KiB);
-    create_unimplemented_device("npcm8xx.pcs",          0xf0780000, 256 * KiB);
     create_unimplemented_device("npcm8xx.tsgen",        0xf07fc000,   8 * KiB);
-    create_unimplemented_device("npcm8xx.gmac1",        0xf0802000,   8 * KiB);
-    create_unimplemented_device("npcm8xx.gmac2",        0xf0804000,   8 * KiB);
-    create_unimplemented_device("npcm8xx.gmac3",        0xf0806000,   8 * KiB);
-    create_unimplemented_device("npcm8xx.gmac4",        0xf0808000,   8 * KiB);
     create_unimplemented_device("npcm8xx.copctl",       0xf080c000,   4 * KiB);
     create_unimplemented_device("npcm8xx.tipctl",       0xf080d000,   4 * KiB);
     create_unimplemented_device("npcm8xx.rst",          0xf080e000,   4 * KiB);
-- 
2.43.0


