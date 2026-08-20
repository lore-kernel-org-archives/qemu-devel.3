Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5360C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CE-0004pO-7A; Thu, 20 Aug 2026 08:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CC-0004oF-8q
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:36 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CA-0001Wt-Fp
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:35 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so3823949a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230113; x=1787834913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r9eBQ66b0pZml6duWgsrSsCww3MfIS9oHdUnfpbvlXc=;
 b=RGwLHUe9OKcoStjuamBz00cmZpGli800BhrAfWKdaEaGmhd+Js53Z+e/picmNryD0A
 8bBqwAuhaK33VYlIkXm06cRhXw6Poh2NRzyuWyaGj3ML+W2ZEgwDY1GxT+lrkU4O7/Vp
 3+Gl9lf+41jQpG3Km/1fa/4LMw85q4sfHLOgefYhX/R4UKIuzj1w3rA9CWHRGpzQ2hZQ
 FLXazvW7RLqyYPEr4rQd3/juxjfMZWBguH/tNOox7IC5aaUKsn7+Pn0lDMFVFqliVaNC
 N00cH/Mfjb6twyiqpFZPklgmFEuVHhWE862/nevPq6bQUdNq0JNYSt1tpzXsTxwxFG0N
 nHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230113; x=1787834913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r9eBQ66b0pZml6duWgsrSsCww3MfIS9oHdUnfpbvlXc=;
 b=Jyv7fESuy6FN5kg6esaHZJpKE6x9OCOz8ui3xXwvcjxeXC3uk9NXnhm0RlqhwENQhC
 4inwLSBb3DJYEPmgOlCToJmA3XXpxm+7oJwqBOVl8tFlssMJIMgwRZ17tBXn9mRTZm20
 R86LWVj7b7rggxUFmVFYoVhjiBgU5wYeczRAx0212med2KlXLUdvwa/hHlhjm4axSeYw
 GKA7uvZkAl70w4VB7K7XoqctpaG11jMlf527q4Mjf16OfhxVXWNpWLuRfnnn7+FHoPxX
 +X8x1iQVarbFsm5kVnsQFoOkSgyAWImfuA9VeLcXwobMaQ6Clhx+/AkFBJnacGsvYh+F
 72qw==
X-Gm-Message-State: AFuF++kVkolEZ8P4p9lElXHZ/2/K9KghYJDvBFvkmSasYJ5agh1r8Bsh
 HTN06oY4w3T5V33LMg7L3rxXAx2tbzvaP5cDNKoXI1bpAwvk4poEtPqCpkJLXg5P
X-Gm-Gg: AR+sD11inNTk6MyVfbtjE522aphBOl/+DVKuLL88y/SYn5hMJTvv8dKbnt7siIFbCje
 XK56qEO2HjsBOYyoN3giLut/cXNV95WBjVGxvowo4hFYJ5pvmzxQajJSjU3mvY3sKzVHaLXSjuz
 9thjxC8F3/3wAG0Q6R5D8nlqHQ3UCIN9X4CMv69EBKrm3B9xPjkJVS4LNARqwCsD05JcdaInBKT
 zm2emIG9l4s0ohNhg1Nvhc1WeGdqW62kk2bbqtFUG6ln0/kxP9Yrqpe981Y4kyw89X0wrjSD18Y
 ydvtjhIhhkEO7rge4Mn14JvzPW2yQCey76pttBi2WpLrz5JvNsrFVN8tniMkKetKGeU8WtCxBBZ
 qWRuI31DkKHzqpFz1YXHiSg/IxDTJgspbLbeqJVjHwfCIkvq1AjnkKSPx9Hy831ubGFhkn8Hb41
 kxN8fD9+tgIOJ+zRjTEi15wfVqY/hFzRmJJhWvUVUKig6Ylvb2uAoJO5qSLzagZOdjEbxhQr/Mf
 Hbz69h5lLqX
X-Received: by 2002:a05:6402:190a:b0:6a1:df2c:cfa3 with SMTP id
 4fb4d7f45d1cf-6a40325446emr7813268a12.4.1787230112538; 
 Thu, 20 Aug 2026 05:48:32 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:32 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 01/14] hw/i2c/omap_i2c: add a dedicated CONFIG_OMAP_I2C
 symbol
Date: Thu, 20 Aug 2026 14:48:01 +0200
Message-ID: <20260820124824.618671-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=wafgo01@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The OMAP I2C controller model was only buildable as part of the full OMAP1
SoC (CONFIG_OMAP). The same IP is used by the TI K3 family (AM64x and
friends), which shares nothing else with OMAP1.

Give the device its own Kconfig symbol and select it from CONFIG_OMAP, so
that other SoCs can reuse the model without pulling in OMAP1.

No functional change.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/arm/Kconfig     | 1 +
 hw/i2c/Kconfig     | 4 ++++
 hw/i2c/meson.build | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 260d2f0751..b2dc2714c0 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -137,6 +137,7 @@ config OMAP
     bool
     select FRAMEBUFFER
     select I2C
+    select OMAP_I2C
     select PFLASH_CFI01
     select SD
     select SERIAL_MM
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 0766130b59..e7c0e2f8bf 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -54,3 +54,7 @@ config PMBUS
 config BCM2835_I2C
     bool
     select I2C
+
+config OMAP_I2C
+    bool
+    select I2C
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index 88aea35662..760724e7bb 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -14,7 +14,7 @@ i2c_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_smbus.c'))
 i2c_ss.add(when: 'CONFIG_DESIGNWARE_I2C', if_true: files('designware_i2c.c'))
 i2c_ss.add(when: 'CONFIG_SMBUS_EEPROM', if_true: files('smbus_eeprom.c'))
 i2c_ss.add(when: 'CONFIG_ARM_SBCON_I2C', if_true: files('arm_sbcon_i2c.c'))
-i2c_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_i2c.c'))
+i2c_ss.add(when: 'CONFIG_OMAP_I2C', if_true: files('omap_i2c.c'))
 i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
 i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
 i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
-- 
2.43.0


