Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E62FE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB4A-0006ce-1h; Fri, 13 Dec 2024 14:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3S-0005ax-Ga
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:29 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3P-000710-Af
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:26 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-288fa5ce8f0so584940fac.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117021; x=1734721821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdY3dpYi7vhtPasvRS2TH4CuRkN2+rNlovkFrA09YtY=;
 b=Drzv1QJJxtheV98fd/3HUJN0hDDDzCtRXGIPV/xbCGp3A2bt8aD+8FKV0DyVGsjvPb
 5a0fjup0G7kp1IB1KdbLgwGyCuxZoUZ0GqwIvuUHDXArn2KqudBG8hlRZMyKLTdqYqqf
 IDGG/i+20deHJxt2SM8CAzwIcT611h/XAirGnOdy+XRRTWIcXvQigBPVmSg8BJyuIZKv
 oNk6z4ubABR3DaRo8IzR+yn3WcPsM0wXhVryNlNHI6byiBsRI7TYLqjL/pLulNLf2EdF
 f8ISD7iRXb2aiXnfTDXv6G43/SS/OIAH3Alsy87ckm1J/f5VjjMoejVriZ5lbqlIUv9c
 g/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117021; x=1734721821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdY3dpYi7vhtPasvRS2TH4CuRkN2+rNlovkFrA09YtY=;
 b=RL+RdjOwlQxIVBuCPMlHTaC+SNfqPZsCOtcRtUd2d/Sobo2onM/pF8ps/2uxQ2lHtl
 eCn3lZUNUYOGG0z9QpdOBYwYUgVnwSFiHekne9XrxZEqS3EDFfvEbwhOf74ma9LKFDa8
 KUL1LitXIi1gRarN7XdPqqrSTDuEAOm21cLEvNXeHNY9IpbnWmQS7gLRfvFsjxRtJwI0
 SCaToJNXAsLk07PmOD0YejhlX1iUV30sJ9BB74PxeUhN+uxn8WblfrWNqk+Hbi7xlbEr
 //4ga1uQ0k/JSEX60Lh5+gipCRxs/MHJu72DSwDE1djBpGdRIpSDO+83xkoEMmOQy6LV
 43sQ==
X-Gm-Message-State: AOJu0YyAb1ExfS5/31jF6ENiULGq+K3GxjyWeDc1mQFo4vNomAjbJYdN
 e03/GmYYhSanJHiw8oePoX5ut0Xff/5oLgp8jtF1XERrCekcoW90wuyalUyR0249Gw1zEODzuH8
 UcaiQ/JwI
X-Gm-Gg: ASbGncuIhrII9QkSn5SwiSmuzUsnjDq/8iu8GJLYY5IMRLd4JZhZyTnIpAgFMFb2Av9
 4dNCq8yTra3YtbjYlfKm495DwmZsB0FsYLzPONPuuM7kgIuM06YNkOTZIhp2sZWRTtQHwfyLJvd
 RG+uThx1U7wKMbVLd4ago4q74uqHWtqiTAYFea2KW+LU2WW6Yk5BbOo7B3gaIYanxdJ/o3ZW2yl
 psQBxoT3012LZraLpDPuKZOYZubualSV9Y3cBQ/PCBxRFSNIR2kXiC4fM4+C6vG
X-Google-Smtp-Source: AGHT+IEBK9VVHbD+tMcR1PhVRRR/hATZTW94X31wfpiTyqoyvbzPK4bOeFlnV1nroIYqbLs+yji2tA==
X-Received: by 2002:a05:6808:1b10:b0:3eb:4f4d:c298 with SMTP id
 5614622812f47-3eba6872124mr1614521b6e.15.1734117021214; 
 Fri, 13 Dec 2024 11:10:21 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:10:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Glenn Miles <milesg@linux.ibm.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm)),
 qemu-ppc@nongnu.org (open list:pca955x),
 qemu-riscv@nongnu.org (open list:SiFive Machines)
Subject: [PATCH 26/71] hw/gpio: Constify all Property
Date: Fri, 13 Dec 2024 13:07:00 -0600
Message-ID: <20241213190750.2513964-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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


