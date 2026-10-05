Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1826CCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfql-0000LF-0G; Mon, 05 Oct 2026 06:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmn-0002OZ-EL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:19:11 -0400
Received: from mail-wr2-x0d.google.com ([2a00:1450:4864:30::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmj-00013r-9L
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:19:08 -0400
Received: by mail-wr2-x0d.google.com with SMTP id
 ffacd0b85a97d-48b104f6aa3so824295f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195542; x=1791800342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Bx/gBQbJwyEOeNleYcut8SB9gX8DfSUE1/YplwZCUY=;
 b=hh0qoYL12xShSL8VUmTHmCf0//hHHM4c3aOXAGChTezqDl9DC2SGwnkgITCzVJ28P3
 7TrGe1y/BXLmOlXDMF1XKiQWWsvUQ8HEvKvADhRb163vR6FcLIQKYIVG0rHxlDD6yR/6
 VJAyvMw74TojcW/hB0IkOmG0PSpe0F8EEFLe9o6tCNvNZOmUV/CAwrrBiyyPIQMiWYyN
 pCI908G8gqFHo1lx+0b/bmFzxdZLgkkwKxEXUr1z4PmaHhyAxwBcAIyiFXC5ezw5oMKE
 xwbZFDuA4P7wHEOsMfWL/O9Gyy5iLYgp5UHKGEo/dpa+MapFbOI0aIVWSHsv+0DgoU/n
 C3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195542; x=1791800342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Bx/gBQbJwyEOeNleYcut8SB9gX8DfSUE1/YplwZCUY=;
 b=zN+7H3hkPiEZu36lPVUit4eEz5GmEVozfrbw78ReORuCGmvRR9VYCIAUuZYjN4pq1t
 7ZVMjuitrJg6vbc/3kkfA4g3MEDhl8AgdaM2YRBhFz+Asm8V8HF9CFssqNxrV7v8+uiq
 6YF8H4bUmoYtPSgCziCvnQb7AYqonQbtZr5QILCM6HpA+fFvgnH5PfWsIv9jM5J+VR5y
 Z2qOJAt3xxq/kOQOSw9KwoPInhatn8+qkBJbB+Xg+6W7OE1xh7conJSlJRnEokSj8S3q
 hMVq1KYHkGgPZfpC9dynumDncVU517doRJ9IDa9w13iWG13IgFp9skrUghkpXSyJd6nP
 bSxA==
X-Gm-Message-State: AFq9FYIIGsNRTmeasZr7Z6ejxARMVavnUvCV1htPYbXpyOH4kiqaNcDv
 fDmUI5tgBYtUr0Y07vESy7UxHBaCoW0j+Lf3GXvoB5OsawIc8oUOssbeBginUg==
X-Gm-Gg: AYBFou3VZf4vSVt6hDHiohvfru2APCcO+rG/S+PsaPc3G5VVYFp51xcDMPLyY/owF7C
 0POX58aHC5W/YmyWYE2o1Qvd2KcLcghohhBnZf5tmrSKp/OgBAi2WuyGAnGJyVAKNsE+SSRx5vh
 tkUD3TnH4JXs0HDp683cykDo95jUFfZd4VdiwaRV4q1AvdaqQ5pUacuvgqO+YLnS/pJI/9THol9
 ESN69++TGNefr42f1cCH3ha09JsG/aqtF5ZxLItHy+rmAJkwImRVbP/c1ZdEQ78kf2E/h/wu0H8
 fBReNW2NgRVaf8S6KY2FzpuQ8Ao1gYJUiNOeocgE8EqPm5yD6FVXUbYbF9gmv0eC6BUrLWxwxd7
 y4qDYzKD5oGjNYMg8WrT06vCeX0GXeuur5EJDoVb8HvTXumPlEM+AijkCZT39syXj5fT43aAv4q
 vXWgQJg2a7dE+ky0RuHxUJX7/MiDcrDwmnDzE4ZMrU2y9ZKG+lc6+NtGwDbKPYLWL7ycMbvubU8
 u8zr1zSYsCoNMCzcNZVYCAPYfgYWzo9jmWHim8=
X-Received: by 2002:a05:6000:c7:b0:48b:50e:5dc6 with SMTP id
 ffacd0b85a97d-48b12763406mr12855633f8f.34.1791195541899; 
 Mon, 05 Oct 2026 03:19:01 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:19:01 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 29/31] Kconfig: Extract config IMX_SERIAL from config IMX
Date: Mon,  5 Oct 2026 12:17:56 +0200
Message-ID: <20261005101800.10821-30-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::d;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0d.google.com
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
config IMX_SERIAL to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 7 +++++++
 hw/char/Kconfig     | 3 +++
 hw/char/meson.build | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3f502685f4..543220be6b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -488,6 +488,7 @@ config FSL_IMX25
     select IMX_GPT
     select IMX_I2C
     select IMX_RNG
+    select IMX_SERIAL
     select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
@@ -505,6 +506,7 @@ config FSL_IMX31
     select IMX_EPIT
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select WDT_IMX2
     select LAN9118
 
@@ -522,6 +524,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select IMX_USBPHY
     select CAN_FLEXCAN
@@ -605,6 +608,7 @@ config FSL_IMX7
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -627,6 +631,7 @@ config FSL_IMX8MP
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
@@ -656,6 +661,7 @@ config FSL_IMX8MM
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select OR_IRQ
     select SDHCI
@@ -701,6 +707,7 @@ config FSL_IMX6UL
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select IMX_USBPHY
     select WDT_IMX2
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..54f9936534 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -48,6 +48,9 @@ config VIRTIO_SERIAL
     default y
     depends on VIRTIO
 
+config IMX_SERIAL
+    bool
+
 config MAX78000_UART
     bool
 
diff --git a/hw/char/meson.build b/hw/char/meson.build
index fc3d7ee506..65351c39de 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -3,7 +3,7 @@ system_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-uart.c'))
 system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
+system_ss.add(when: 'CONFIG_IMX_SERIAL', if_true: files('imx_serial.c'))
 system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true: files('ipoctal232.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugcon.c'))
-- 
2.56.0


