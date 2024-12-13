Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C991AE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB43-0006YU-Vm; Fri, 13 Dec 2024 14:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3T-0005bY-UQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:31 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3Q-00071R-PY
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:27 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71e35be77b5so458107a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117023; x=1734721823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4K+Ow/kpxla1hHfSMb1r5BWBj60XilhZFUT+PuNLeCM=;
 b=rJ1zB70ld3fkZYYS0SLH3sC+Yp5bJPEKdCsDse0YW66Ci8Oa8wijrkO/QtCUvdUuKK
 BkTph2MufouxJuk1CoSXxN6ZG+GsTdGYCIqV4WSnaP9wSCyEVqrJMDR/zOlv7c6hPDGT
 HHRDKl8S8LsgAJeYUmj75S/3vXagjzZe9k/bn9XBoZn+hdiOaFejx89Y9O6voIQITUvv
 FaGTUiFC3KRuqyUQB1RypQY1FkdRti+5pkJktA9TGbYdVFqWC5/PFGX7HTcm0wqKcI4Q
 G0zRMu2A3LYBAclAmIsc9WjleMsQFfIrKfpJFsmnndU89iYyz9ZfbbYYTv0xTiOm6cW3
 c/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117023; x=1734721823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4K+Ow/kpxla1hHfSMb1r5BWBj60XilhZFUT+PuNLeCM=;
 b=b9PNUvzlbi1/IjVjUSBHzxyY8Jh85zznaol8fiStpqAP0q3q9xnTNAZnsxoBQ2U8Ug
 WWlX9mD4i2sK1mNKJci0lOtnCS5k1vKwWwc0Yexu6HxhlNut6wDEeeJ3AKkZJtJe/0UP
 2TBq4zkXAkFzC5DDOQ9ZMAzwSihTleun4ahvL49BQPf0eQCurDunQe6O0gs0hVM3faXT
 lI4yRyvCGwOWmnmyvtMJAeJ0mGWgORd5gjiVMLcs6wlDL3CM7liF35T97gCE5q5soL6c
 Ozs00Zsn3ClwT+qC+D9GZ76KzLcKCf+aPrVXnuGkVc6rGAjc8KGJSVGYefwpicc0YIWo
 pBog==
X-Gm-Message-State: AOJu0YxCwxpvT9JUTQ52FHZHkD+QaPVmCuaum71kURKoFFoejg8PP6bH
 iV67mQboWTUtar3LQPljCYqiUGk68aYouoBPOhM8isiV7tHx3MbUffitLaHvids5RJZUw1coG0I
 4EK0qJaiZ
X-Gm-Gg: ASbGnct/Ntc+4k36BGxP97MR37UMqyIi3/zXojdhVSuoSsYeDwYUIcLUwiKAwVgdX52
 5GfKw9SvRN607+X2GE9R7iQqrLxVHrEil86W2PF0LaNRYDXGsjc5vc6NagU50AMymo6IB5sHF/r
 yNq2C+vo/DcVWo/Pkd5WYH19dhrJQuSMeLaP+TVthX2MuozjaxlALysBaCmg92MkfHwyzt6NYk6
 FWpMKs7j0Uy+emyLxgThggElKGk5JsE9+hp41nvsbX5Nc0nFjWa46L+Y/oAq9AT
X-Google-Smtp-Source: AGHT+IFZH/Qbth4WBfUBFT9Z4/ZH2zjE99ESl/+3I1fhz0CO0ozfa3EVmFNd2aZBP2ZrZzKbflvUVg==
X-Received: by 2002:a05:6830:258c:b0:710:fef4:3c92 with SMTP id
 46e09a7af769-71e3ba26862mr2771330a34.21.1734117023633; 
 Fri, 13 Dec 2024 11:10:23 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:10:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Corey Minyard <cminyard@mvista.com>,
 Patrick Leis <venture@google.com>,
 qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PATCH 28/71] hw/i2c: Constify all Property
Date: Fri, 13 Dec 2024 13:07:02 -0600
Message-ID: <20241213190750.2513964-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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


