Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4663E77186
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwz-0001kX-Si; Sun, 15 Dec 2024 14:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwX-0001LE-1U
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:18 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwV-00019R-AA
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:16 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-29fae583cc8so1738219fac.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289574; x=1734894374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6dtc5tKm0SDV+tByDsBCG2rfZqXnqrfnrDqNh1eC2Y=;
 b=gljS5p4gv73CnBlfDuYkx9mATlO/Rol4RjI+MU3woz9GAr5qZh2K9iK8SdZesVpy4G
 HZB79p/W7NKVBgC2XhW3Y5ljAqSyHGXp/1Dq6S11yO1QSiW34JWdl+Yd3K+4zo58zy6K
 2GkgDBRhKr6nE8X0dsfI8x/Q4t/8Aci4QJBk9Ei6uu21RfaKnETx+tkBrt0Kw9B80IIZ
 FjfTHjlhVIQLV+I4Z/dT3jUv1Xa3Mp/+OZoTD0UilUPgvBHQKD6p5iODDEhsICpKhEyf
 nv6haiNLfFV+eS5Tl5DkGqxyKAlWj7ydGmW+NyHybpJWkI/TCbJYQkQ26AnI03T7t8cK
 kUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289574; x=1734894374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6dtc5tKm0SDV+tByDsBCG2rfZqXnqrfnrDqNh1eC2Y=;
 b=s5nQus3vt44Ay/XBBAzG0n+9Ph8HsuFOTVcOnyrpdsE41n3yJkN4+jyrwuJJ3vvPcU
 7Xz8GwGK6vGIyQvr7oNyIZNEHlIjwA/YPgaqF6GWgStvM4snUv9lFgP1W/9NWT/yF4hf
 5qA3hMT4jpbQev68rSaej05WIqzG1oCNOyC6We0eblJuRokmmM//JP4ERuMBIwcqRWxt
 9o3xteyBybx4OhC9eUzbzwEMsscxIQzdCNGiUTplwytkKXuN8ZFmMQzZwlXsePU6keVD
 xwVMmkbzogcaYoA4LN+tlc7QYzbnr91IC2IKf1LwmiTTnGFQWl9vdXhIENutOcTQn5KT
 NCLQ==
X-Gm-Message-State: AOJu0Yw2YlwPAQjRcL+yw6GaT04BfrS+RctGtXF8upHovCVm35mDPkmX
 nI5FiXjosTSfNufA/Hzqz3PiA+u79ZTE8kJziV9JnAR0O20nNdC57qNRpZx1R0hvRAEU9LmhJ1L
 jODHgCfVP
X-Gm-Gg: ASbGncupzi5eETC0162hfoT3bD8XQTb2SIlHaBur98yAG9PIhVfcYpvsMNngBLj+haH
 XqutBAJDZ2IIw9P+iWsCLfulh9tAl1GVSeujmmJkNfZCycdnBwctibiOglzDJDCxmkXe4gXAewI
 EpI2kvUtcfClVXqA001mY8js3s6GK3p/KbhC7j9t8Ht9t35T29/wXhAPXjx1+9K7FUOqm1fvJq5
 1Wxnb4O0jIpyQ8qt1/3ESLolLJL8hnYyzF6YSA1tVwUGssJk8jW9S/gzj8D406YLN1C/W3ulxYo
 KPRdGE1Ne8u9QEHrLjSoxd9ke4/zVAwqIPG3My1Ffk4=
X-Google-Smtp-Source: AGHT+IHgl2wkhz5wc1Qn4DDZdsF2GT79jrVPlhY1jTWyoUisUtCZYp44j8k1vty/CY2nQwywBIN4mg==
X-Received: by 2002:a05:6870:7805:b0:29a:ea55:3bfe with SMTP id
 586e51a60fabf-2a3af18d1a5mr4296198fac.11.1734289573944; 
 Sun, 15 Dec 2024 11:06:13 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/67] hw/gpio: Constify all Property
Date: Sun, 15 Dec 2024 13:04:51 -0600
Message-ID: <20241215190533.3222854-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/gpio/imx_gpio.c       | 2 +-
 hw/gpio/npcm7xx_gpio.c   | 2 +-
 hw/gpio/omap_gpio.c      | 2 +-
 hw/gpio/pca9552.c        | 2 +-
 hw/gpio/pca9554.c        | 2 +-
 hw/gpio/pl061.c          | 2 +-
 hw/gpio/sifive_gpio.c    | 2 +-
 hw/gpio/stm32l4x5_gpio.c | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 27535a577f..919d53701f 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -290,7 +290,7 @@ static const VMStateDescription vmstate_imx_gpio = {
     }
 };
 
-static Property imx_gpio_properties[] = {
+static const Property imx_gpio_properties[] = {
     DEFINE_PROP_BOOL("has-edge-sel", IMXGPIOState, has_edge_sel, true),
     DEFINE_PROP_BOOL("has-upper-pin-irq", IMXGPIOState, has_upper_pin_irq,
                      false),
diff --git a/hw/gpio/npcm7xx_gpio.c b/hw/gpio/npcm7xx_gpio.c
index ba19b9ebad..db6792b2ad 100644
--- a/hw/gpio/npcm7xx_gpio.c
+++ b/hw/gpio/npcm7xx_gpio.c
@@ -386,7 +386,7 @@ static const VMStateDescription vmstate_npcm7xx_gpio = {
     },
 };
 
-static Property npcm7xx_gpio_properties[] = {
+static const Property npcm7xx_gpio_properties[] = {
     /* Bit n set => pin n has pullup enabled by default. */
     DEFINE_PROP_UINT32("reset-pullup", NPCM7xxGPIOState, reset_pu, 0),
     /* Bit n set => pin n has pulldown enabled by default. */
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index a47a2167a6..03ee9e47c6 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -225,7 +225,7 @@ void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk)
     gpio->clk = clk;
 }
 
-static Property omap_gpio_properties[] = {
+static const Property omap_gpio_properties[] = {
     DEFINE_PROP_INT32("mpu_model", Omap1GpioState, mpu_model, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 59b233339a..427419d218 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -428,7 +428,7 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, pca955x_gpio_in_handler, k->pin_count);
 }
 
-static Property pca955x_properties[] = {
+static const Property pca955x_properties[] = {
     DEFINE_PROP_STRING("description", PCA955xState, description),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 68cc9e1de4..e8b0458aac 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -291,7 +291,7 @@ static void pca9554_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, pca9554_gpio_in_handler, PCA9554_PIN_COUNT);
 }
 
-static Property pca9554_properties[] = {
+static const Property pca9554_properties[] = {
     DEFINE_PROP_STRING("description", PCA9554State, description),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index d5838b8e98..9b8ca6de32 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -562,7 +562,7 @@ static void pl061_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property pl061_props[] = {
+static const Property pl061_props[] = {
     DEFINE_PROP_UINT32("pullups", PL061State, pullups, 0xff),
     DEFINE_PROP_UINT32("pulldowns", PL061State, pulldowns, 0x0),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/gpio/sifive_gpio.c b/hw/gpio/sifive_gpio.c
index e85c0406a2..5603f0c235 100644
--- a/hw/gpio/sifive_gpio.c
+++ b/hw/gpio/sifive_gpio.c
@@ -349,7 +349,7 @@ static const VMStateDescription vmstate_sifive_gpio = {
     }
 };
 
-static Property sifive_gpio_properties[] = {
+static const Property sifive_gpio_properties[] = {
     DEFINE_PROP_UINT32("ngpio", SIFIVEGPIOState, ngpio, SIFIVE_GPIO_PINS),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index 30d8d6cba4..d1394f3f55 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -447,7 +447,7 @@ static const VMStateDescription vmstate_stm32l4x5_gpio = {
     }
 };
 
-static Property stm32l4x5_gpio_properties[] = {
+static const Property stm32l4x5_gpio_properties[] = {
     DEFINE_PROP_STRING("name", Stm32l4x5GpioState, name),
     DEFINE_PROP_UINT32("mode-reset", Stm32l4x5GpioState, moder_reset, 0),
     DEFINE_PROP_UINT32("ospeed-reset", Stm32l4x5GpioState, ospeedr_reset, 0),
-- 
2.43.0


