Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDB1CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLKU-00074A-Qp; Sun, 04 Oct 2026 08:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKR-0006yK-W5
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:32 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKP-0007Em-1X
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:31 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso3000675e9.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116898; x=1791721698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TmWpyCZJB38ya4ghlv3eWQDO8zJ8A5jsKzsbpA38XS0=;
 b=Q33imAyYg+uBZETOGRtxHSdzFpdAl7KSBQs9y11B+nZDTQhXARpJyT42389SWmd/Q3
 emaV7NlVmfEywtBALIzRz8/xHZ8puu+IFJCUyWLAcwBXqvShVj3WiKgsAi3gD61/t+FL
 4e+exFJdkMpFXKz7QiSSol+/lCzluJvUk4Fyb181jJi4piHNnH8AX+McMWad+vOc9QVO
 zTrF81bfEVyzDKtS8KfQlbSYW1pcOeXgRLtRuEImd5qpOQ/ky/aXfBX1gjEX8I8cyoNH
 ASTkvUf8vOGdUoWXdemuQ2c9lhm2Mbb/pcozSxJttq22N4Kx6aga21VbNnJB4lqxoYz0
 x8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116898; x=1791721698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TmWpyCZJB38ya4ghlv3eWQDO8zJ8A5jsKzsbpA38XS0=;
 b=ZY/k+uVVYrsSahVFuQTAwhpb8ytfwrVpwzgjr6QuoCa2YozmR4bT1Stjh9S+J3z5Ic
 DUXjzA6OYWUaAcCOWiGJPZrSJ/1ai4zpQQzAqotx2FNTfdQxbDfvE3hsvbyBw/XtkqTW
 WGWmMyBmGTeoxlOibwq9NGZwx/3eLcKpSkxGW5v0mB3g6udBQ6H8Mgpx7Apt64vRkVw6
 21ihM2x999U+c21VKUd8151XAPaXjDAGNizUhnh2LPGHSvidg2ix26GROA1iXlFM7wN8
 RfJvstZ3/Wmkrqe31jttZxY35LSdto2meRKJoTmpDh8OsMDmAnbRDjzsHvKwq445mMLI
 Z0WQ==
X-Gm-Message-State: AFuF++ns/f6Y5efb2HNYHTqRDReCOxIt6FxfdLdXoWnmMqA1UwgJyI+u
 JOHNr/S+DYv+XSKkwpFvQr3ehQ3jaajPfmOBpaabfSZ/HxRJerqphtYi1eM7tg==
X-Gm-Gg: AYBFou1euVyIRdW/Q1j4/2vO5c7Y7YlxYzVRvvKVNAxqDp0J/N0wUbE+ss9iBqGWOEP
 h5a6NyfxSpbPXGNotI4GXdeMabjVfQqg8tgQuE7ILcAtXuGSEldlbXiAPlMM+hM8/U8RYsbl6JK
 +s9xowP/cNBQ4rzNx0Nk4L1MxPOsmHk1tCVEtW4MSxyigEKoiMpvjLt+DWWXDoBgSAXmJU9U/s4
 FOhLiVV7mbtnlreZaS+q3EWXcr37GN+T21yIHOlkd+zzG79J91qjlmFtNsHqDI0lsfTmsupgqfv
 r7QrzIyMOfq4dArLaHRuOsmh1oy8OQESBvknTGKPS5pppyDcYTa1iuMbntECBS2hbZtpGaUZy/t
 q1lbgS/QB4bc8tiRfbssZc88BuW4G01WwLivqinbrU7sEWx2oTQWIdzD8+Qh0oW3bdqDyhcMJ+M
 2OHynd/RTu9dVjmG/XljkvEJsGMmDcKrhPydD5uQaFAprLnmzae8TcPJftMdboShqMhB4VSfD8w
 +SVFRQXyvWSJesVcIaJ8HSirknTHW0W7DvZXQ==
X-Received: by 2002:a05:600c:6090:b0:4a1:6282:1cf3 with SMTP id
 5b1f17b1804b1-4a162821d88mr114098545e9.9.1791116897651; 
 Sun, 04 Oct 2026 05:28:17 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:28:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 27/30] Kconfig: Extract config IMX_SPI from config IMX
Date: Sun,  4 Oct 2026 14:26:43 +0200
Message-ID: <20261004122647.3913-28-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_SPI to eventually eliminate config IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig     | 5 +++++
 hw/misc/Kconfig    | 1 -
 hw/ssi/Kconfig     | 4 ++++
 hw/ssi/meson.build | 2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c21ad260a1..3f502685f4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -522,6 +522,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select IMX_USBPHY
     select CAN_FLEXCAN
     select WDT_IMX2
@@ -604,6 +605,7 @@ config FSL_IMX7
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
@@ -625,6 +627,7 @@ config FSL_IMX8MP
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
@@ -653,6 +656,7 @@ config FSL_IMX8MM
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select OR_IRQ
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
@@ -697,6 +701,7 @@ config FSL_IMX6UL
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select IMX_USBPHY
     select WDT_IMX2
     select SDHCI
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index dbdef58505..ab238767b8 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -91,7 +91,6 @@ config ECCMEMCTL
 
 config IMX
     bool
-    select SSI
 
 config IMX_CCM
     bool
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 1bd56463c1..d477d20e9b 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -32,3 +32,7 @@ config PNV_SPI
 config ALLWINNER_A10_SPI
     bool
     select SSI
+
+config IMX_SPI
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 6afb1ea200..f334e48e2f 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -9,7 +9,7 @@ system_ss.add(when: 'CONFIG_STM32F2XX_SPI', if_true: files('stm32f2xx_spi.c'))
 system_ss.add(when: 'CONFIG_XILINX_SPI', if_true: files('xilinx_spi.c'))
 system_ss.add(when: 'CONFIG_XILINX_SPIPS', if_true: files('xilinx_spips.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-ospi.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
+system_ss.add(when: 'CONFIG_IMX_SPI', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
-- 
2.56.0


