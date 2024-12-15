Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D443E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtx4-00021n-TI; Sun, 15 Dec 2024 14:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwa-0001M1-KK
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:20 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwY-0001Au-Qp
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:20 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5f2d8f62290so1754863eaf.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289576; x=1734894376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhWboubb5SD2Tb3kEHoXaDk4aNSp8HDO/dk92ZtG/zg=;
 b=umQLr6cEIxKwJLhmN1n0d7G5tJ5s82wNevRaBBDaDwjZlagLhKYidDHzq8PpTI3EES
 znCkrkWW2FomB8efZMALZtyL0bmIxGgCeJTH25FuIgjOZ5JHDqs3KRYjLdgDgiHW/Fc6
 PF0UjdwWbdqkqCuxJuQZNIbfiinvwllh3XWhJNB8H8kDHfMvcQdOFhKEWEm6O8tGUlSf
 lizEc/pLfBVj9ADsIK+CHR103YGbE93o6TGRT92qQ4ykSIm9eOeQwVzVaSb5QMj0mfh6
 lWed2vgLemfdLT1Xrm+pHliurk3YKBrDmK//7M6cW9w+AHbEtWbx9pYc0GOSfeF+OYzI
 nNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289576; x=1734894376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhWboubb5SD2Tb3kEHoXaDk4aNSp8HDO/dk92ZtG/zg=;
 b=rFqbsRbWMEbhpP52q5cM6qQ4CiqbyQFaxNs47Zw/DYfFg9GoXl0lVGifdspNC5vmAx
 eEG2cg5WUVQ1ZrTi/SOCHJkqc/hK5NPuanNMcKNVFO4YZ+AtmoSuTDalOU82AmfKyqsf
 GMJVrxWtLYEuV7d7Azd3cPl2KuMGt4mqsS4YxhwELR9hlJtHHbFT+HyYrPECpKJVIjvM
 gRJ01nwfXhD4drGWMysh1wJwNqQBmD/8loraQLOaCR+5xZeTrz9gMh9nSxSDm3BE/vpa
 W7b0qGYdTH72az4Qs+n0mtGHVMzsi9BUY4ySM+cFrO4sxYLlPN8XPFg6MKBhCU/MjTHb
 1y9A==
X-Gm-Message-State: AOJu0Yz/TNpJEZhHfsezuXj+aXk+Tw2yKuRQzq+CVxDzn5+I42h8iBuu
 cU/xRxH+TEdiwMqaqTBuK/7rNQ7thIOgpWkxgP6WxPEzgejciJvjzwAg6qtO8jT0m9blnEUsOQP
 x4GDTsapS
X-Gm-Gg: ASbGncv56VBOSF+jbBGcvOs4qPZqYvU0xLZOwRZu6lm15BcVXQnAZRJuxSEfZfr4fMS
 F2OMQwmekivGR/V5vNWukBnsNHgiVfJskdaFqFZ0vpvpoaaUjuJftJ4+AHuuz6jZO+MQuP4hJ2O
 i3FTnJnIDLnCclch1R3bgCQ0ZWI8EJ++fnah9DKlzvxSP8dfw5tpWwz+jeFYKxWscl3sNC3z0I7
 Qv89j4nliN22numc7fsuLkEd3Jt2ywwkQW4rlMY47O64G5ySk6hDoX4bKoJHmTDIOWu7ez1fynw
 Af9ZPdDVx3JUemM/1OaTJ5bGBqa4ZSatqA9tkKlwqBs=
X-Google-Smtp-Source: AGHT+IGkZzE7+yFJQmJC/QjGjfFQbP0LE8HZAYEQwg1hWGqNZ10Gm5KeuxpyVwrAR6FDKtY2hltEJw==
X-Received: by 2002:a05:6870:e313:b0:29e:443b:edcd with SMTP id
 586e51a60fabf-2a3ac914920mr5178427fac.37.1734289576737; 
 Sun, 15 Dec 2024 11:06:16 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/67] hw/i2c: Constify all Property
Date: Sun, 15 Dec 2024 13:04:53 -0600
Message-ID: <20241215190533.3222854-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

Acked-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/i2c/aspeed_i2c.c      | 4 ++--
 hw/i2c/core.c            | 2 +-
 hw/i2c/i2c_mux_pca954x.c | 2 +-
 hw/i2c/omap_i2c.c        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 3ae22cb052..2ea68c3090 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1258,7 +1258,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property aspeed_i2c_properties[] = {
+static const Property aspeed_i2c_properties[] = {
     DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
@@ -1446,7 +1446,7 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr_pool);
 }
 
-static Property aspeed_i2c_bus_properties[] = {
+static const Property aspeed_i2c_bus_properties[] = {
     DEFINE_PROP_UINT8("bus-id", AspeedI2CBus, id, 0),
     DEFINE_PROP_LINK("controller", AspeedI2CBus, controller, TYPE_ASPEED_I2C,
                      AspeedI2CState *),
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 4cf30b2c86..4118d3db50 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -18,7 +18,7 @@
 
 #define I2C_BROADCAST 0x00
 
-static Property i2c_props[] = {
+static const Property i2c_props[] = {
     DEFINE_PROP_UINT8("address", struct I2CSlave, address, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index db5db956a6..80c570fd10 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -211,7 +211,7 @@ static void pca954x_init(Object *obj)
     }
 }
 
-static Property pca954x_props[] = {
+static const Property pca954x_props[] = {
     DEFINE_PROP_STRING("name", Pca954xState, name),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index e78505ebdd..172df135f5 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -511,7 +511,7 @@ void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk)
     i2c->fclk = clk;
 }
 
-static Property omap_i2c_properties[] = {
+static const Property omap_i2c_properties[] = {
     DEFINE_PROP_UINT8("revision", OMAPI2CState, revision, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


