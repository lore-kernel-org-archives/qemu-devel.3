Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB090C47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPZp-00071w-Cf; Tue, 23 Jan 2024 17:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPZm-00071L-L1
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:49:02 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPZi-0004IA-1V
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:49:02 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40ec34160baso5446575e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706050135; x=1706654935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rLt+18wiq79FMT/YlMa8u073Rtk4hJW2iJ8pfUwdG0=;
 b=MUNIN/J+CSBDqTuwGxTvAMMtblKyk2IkBhe+FbMK+UAFfHHgJ3AzHgcl5G6CKBH+QN
 25PaKU+6oWPj+YSvR27tM9mlsSeYmeS4noxKX6ongTYYok6afskEy1mv+bc7qmEMI2gg
 db8qwIf5yVG+2JBMqv9RZIYpnnowXiiX+JhE3LVDxVxrjiV17ugf3vne1aaCCxZ6I8KY
 ZO/LtWa1geWgMe/ey8MGT8LIdjARMzIcKBLCMarxEENE7+tjaVyX84vt80/j7YOOkZwF
 +4isZASagDbB3EprQXA2FShYNSXmjaA1E23XXn9AqCda0Gp9kdZSrdzX0NZX8wtQL9XJ
 IPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706050135; x=1706654935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5rLt+18wiq79FMT/YlMa8u073Rtk4hJW2iJ8pfUwdG0=;
 b=btFvQcKeKZL1/jAEOegAkbYtcb84ZscH2OLJLOqz9m70EHA8IfuzVMgAoLYXGROtZ7
 7t3XnicrF7UIgWevnEfWYHcTwVZhX2hiA+MMgtc5EjK6BWxP/dLj4h6sZMOCXI/37dDl
 DI890lrBB6KV1n2ecHJcOMf0cskFjBswHA135HnDyZSbh2iE2AD20Ge/3Sduuvtn/zgH
 so6XVBI7BJTezFVmXFljz3iT8DKkWC5zjktlwir453oPsYOjhWIRy2bwdr/7kDHCxl/x
 XliAemHW1ZsDNDy559Eq1qTQQZQxyRF5y+VqeNq8dy2N1HpoEiHLiRnau9cN+FHtUB7M
 kGXw==
X-Gm-Message-State: AOJu0Yw9EUKmgn14fWRpETj1seNC9HhOWMWRRkCLpi0P0RcHItWk5bSo
 w/GT2dL4CcWtwxSTBpVL/DQ1Ozsm31i+hW5vqyfy3wHdYL5iUBykjYpX7rVUQgportBufLFyTtr
 p
X-Google-Smtp-Source: AGHT+IEmZGFhl083RqesXDoxAJ+nCMKUFR50AEB0bhlYRUXg1Hg4uCWkhEhKSXqN8Obx3WtCrbDGog==
X-Received: by 2002:a05:600c:1c16:b0:40e:88be:4ef0 with SMTP id
 j22-20020a05600c1c1600b0040e88be4ef0mr1089273wms.0.1706050135639; 
 Tue, 23 Jan 2024 14:48:55 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 l39-20020a05600c1d2700b0040e50d82af5sm43887923wms.32.2024.01.23.14.48.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 14:48:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/5] hw/arm/aspeed: Set default CPU count using
 aspeed_soc_num_cpus()
Date: Tue, 23 Jan 2024 23:48:39 +0100
Message-ID: <20240123224842.18485-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123224842.18485-1-philmd@linaro.org>
References: <20240123224842.18485-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since commit b7f1a0cb76 ("arm/aspeed: Compute the number
of CPUs from the SoC definition") Aspeed machines use the
aspeed_soc_num_cpus() helper to set the number of CPUs.

Use it for the ast1030-evb (commit 356b230ed1 "aspeed/soc:
Add AST1030 support") and supermicrox11-bmc (commit 40a38df55e
"hw/arm/aspeed: Add board model for Supermicro X11 BMC") machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 4bc292ff84..5b01a4dd28 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1212,6 +1212,8 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
     mc->default_ram_size = 256 * MiB;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
 }
 
 static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
@@ -1586,11 +1588,12 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     mc->init = aspeed_minibmc_machine_init;
     amc->i2c_init = ast1030_evb_i2c_init;
     mc->default_ram_size = 0;
-    mc->default_cpus = mc->min_cpus = mc->max_cpus = 1;
     amc->fmc_model = "sst25vf032b";
     amc->spi_model = "sst25vf032b";
     amc->num_cs = 2;
     amc->macs_mask = 0;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
 }
 
 static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
-- 
2.41.0


