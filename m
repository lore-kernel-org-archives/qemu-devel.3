Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B9ACEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuO-0005Ku-AE; Tue, 01 Oct 2024 12:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuL-0005KQ-TQ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuJ-00061b-OD
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:29 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37ce8458ae3so2216175f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800766; x=1728405566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+hRRD4dJSZ61uxok5Ri4s/vdxniggz48zYTa8EvGuZ4=;
 b=HCBTsLcYkabK0VoFAwJy4IJoB40bQR3qJoeno3RigRFSsOdM5fUt9cPWrs6Y78+HMk
 ACpwjIIMCtGvqCg7eGYG3DWmhYgrzJFjKuCTH1yiS16FYENZ7o/N6v5wgLIKHzaovx1w
 N+YJet5kK8b12qqyAys7wlQJaqCO5PpjIL47A/psToh71O5oVFzNDbIsLc1D2EbSjV2C
 PiKhUrWAn7D6g6ub4Bc3Gdxc9nkmDKwOKBiC8/nczCcJFrbM86gyhLggeX7zH7Kbfyy2
 B8Lvd80pQdSdAVRhRjrjNs76NBP1w+MSxPmplqnRRp6UB+Ltzqiv8ZLHSShXzE+92SbV
 /NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800766; x=1728405566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hRRD4dJSZ61uxok5Ri4s/vdxniggz48zYTa8EvGuZ4=;
 b=vWhXbHG3q/GMipcNIb9oORKxtn8Z4z9TQ8hC+lIM9Ts6vrYLnA76lMIaccUHggfCne
 Te1igaSq7zzbEYvVLAe3LIWdzLOrCv+RtKsMY/heka4Vm3Sk/pk+lxVkNXDUFMN71wZ5
 xO6DjeYKa0AvVXEpoPKFLKijF0yO088ukjolxbZiUEZv42mJWT8vrFS8bk28+4K4Wcia
 4LT+QE4p2tdcBUWSNgS0e3P32+2+xJYzNXrDOVMj+QPMnUzb6jGaoSDZhU6vdHc4Zs0G
 UOdCsZFgj+9tt4JhewKePkDi0fKRh0TYfRXBCzt3uEDpYkxflCq/7jRzUOnIqPmHJMN3
 QFMQ==
X-Gm-Message-State: AOJu0YxkM7PUNxdIXahizVnshIBAms41KxtA/t5SNgoVx+ijYdw3mvqB
 aHjre9vu2YvvwObd91jVI8aCtrPbDs6z7VJIhLe63jklM8lx2o4rkAXjiBmcUvRJ6l0+frAl0Lc
 Q
X-Google-Smtp-Source: AGHT+IG1UZncQ3LBAYjynvdUnUhOjxbSYc8d6m92tsKm5eFdbW8+9e/s4Ww7QUKwpY2q+3vBYsO4wg==
X-Received: by 2002:a05:6000:1211:b0:37c:d1ea:f1ce with SMTP id
 ffacd0b85a97d-37cfb9d318amr162747f8f.25.1727800766268; 
 Tue, 01 Oct 2024 09:39:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/54] hw/arm/KConfig: Replace ZAURUS with ZAURUS_SCOOP
Date: Tue,  1 Oct 2024 17:38:35 +0100
Message-Id: <20241001163918.1275441-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

The ZAURUS KConfig symbol used to do multiple things:
 * pull in the tc6393xb display device
 * pull in the Zaurus SCOOP GPIO device
 * pull in hw/block/nand.c code
 * pull in hw/block/ecc.c code
and was used by multiple machine types in the Zaurus family.

Now that we've removed all the Zaurus machine types except
"collie" (which is not currently deprecated), we can simplify
this. "collie" doesn't need any of the above things except
for the SCOOP GPIO device.

Remove the does-lots-of-things ZAURUS KConfig symbol and instead have
collie pull in ZAURUS_SCOOP, a new KConfig symbol which exists only
to control the presence of the SCOOP GPIO device.  Move the
associated source file lines in MAINTAINERS into the Collie
subsection, since this is now its only user.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-8-peter.maydell@linaro.org
---
 MAINTAINERS         | 4 ++--
 hw/arm/Kconfig      | 7 +------
 hw/gpio/Kconfig     | 3 +++
 hw/gpio/meson.build | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb74aff54c0..d917343a6fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -937,12 +937,10 @@ F: hw/arm/mainstone.c
 F: hw/arm/z2.c
 F: hw/*/pxa2xx*
 F: hw/gpio/max7310.c
-F: hw/gpio/zaurus.c
 F: hw/misc/mst_fpga.c
 F: hw/adc/max111x.c
 F: include/hw/adc/max111x.h
 F: include/hw/arm/pxa.h
-F: include/hw/arm/sharpsl.h
 F: docs/system/arm/mainstone.rst
 
 SABRELITE / i.MX6
@@ -981,6 +979,8 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/collie.c
 F: hw/arm/strongarm*
+F: hw/gpio/zaurus.c
+F: include/hw/arm/sharpsl.h
 F: docs/system/arm/collie.rst
 
 Stellaris
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 32c5e601d1c..c8c57497c5b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -300,7 +300,7 @@ config COLLIE
     default y
     depends on TCG && ARM
     select PFLASH_CFI01
-    select ZAURUS  # scoop
+    select ZAURUS_SCOOP
     select STRONGARM
 
 config SX1
@@ -662,11 +662,6 @@ config MSF2
     select SSI
     select UNIMP
 
-config ZAURUS
-    bool
-    select NAND
-    select ECC
-
 config ARMSSE
     bool
     select ARM_V7M
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index 19c97cc823f..843630d4f5f 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -23,3 +23,6 @@ config STM32L4X5_GPIO
 config PCF8574
     bool
     depends on I2C
+
+config ZAURUS_SCOOP
+    bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index a7495d196ae..089b24802ef 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -5,7 +5,7 @@ system_ss.add(when: 'CONFIG_MAX7310', if_true: files('max7310.c'))
 system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
 system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
-system_ss.add(when: 'CONFIG_ZAURUS', if_true: files('zaurus.c'))
+system_ss.add(when: 'CONFIG_ZAURUS_SCOOP', if_true: files('zaurus.c'))
 
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_gpio.c'))
-- 
2.34.1


