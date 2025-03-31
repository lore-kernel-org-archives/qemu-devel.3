Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C892EC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL8q-0002HI-Ev; Mon, 31 Mar 2025 15:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8L-0002Gk-NK
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8J-0003PI-QA
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:21 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso37292135e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450558; x=1744055358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j17i4NSW+jisbn3eQFtLedISxNwsl/F0+zMCrogQ6BQ=;
 b=AbjQKg4IDJUM477NGMmteQ0Nv15fS87i5RwKoF8/3sdmMJ2cwsXhtQl4aCQSjL6Xwj
 5nSwUbmLa6HmNCpaKZmNv9WRzXMRbBY1MaaXekima8N79dzYAtb/3uD1+H2G7ViDoEiY
 HGFy3FquQ1nqFE2jU+p/TK6XhaODrEvIxsZZVn0e2el5vbSYltSRHvq1ebSWeumOG0k+
 5GL+lYykQ0Hwl/aKVDwefhfjQqU3Ipgo5o8A4Rb4dOYF7AmUwaPl/N0FGwa+tPv9gbJ4
 4M2F/Cyn0OkCzOqyrR5OewTAnV1mr+NHVPyBmjcMb0bDQCJiGPFJ0Y4drNQz1FKrSjTP
 lKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450558; x=1744055358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j17i4NSW+jisbn3eQFtLedISxNwsl/F0+zMCrogQ6BQ=;
 b=iz+4bf/nMhn+ia4htN+2LkX3XCxGYAnUw7ZMqh372h5gUrnx++u+TZeL0nxYDARJRw
 FjESfsAzPQ4hSjh2vYersLPepQmDulDA3HB9dDNHvQJ8GEby6YtefoyCS4SFxM7FtjK6
 8x3yT/nh5JcqeSnwz2zlaw1mmxUmB+7YKD57ZYB1FqAFG5WTF6iP8gc7KyrUgjdhO/4X
 nCuLyT52SZC8dX/WdX2oHNV4Zgt5PqJQ0/V14MXj7jgXFaSM/nWIZs1eB7cg07KUf6H2
 G5993wmUqYegx1ZIxOnMzBpDt9rkujs0xWljRdtpww0QgezAdfGEzmDe7jRGOWeGnpo4
 nh/Q==
X-Gm-Message-State: AOJu0Yw/q9w7q79/Z03N1KvFQlolpfsfOxv6Cg//vYDiV3StxmnWbts/
 2ldy1RJfJ6rpHI1AL25HnLo1qfDBlEidLk7SQzcfdTTh0XFt3mer8plLDelFwxuyPGLEOFp1CK/
 r
X-Gm-Gg: ASbGncu+g0MtcCxs0XndtmHBSVMtoaBVsMkkOUOA49wiS8CpVjIYO1ASBfzeeTeFkXU
 1W5oXArNob90LcmRSjANo7qWWMh3h9lVHaZ4KgEzr077LYhtu0ozI2FoRsIMA3F6jkS5iKee2B7
 quuifbwNTOzutww6o9iyOGnb4KfgcZGUSY6Iu10mO3KXcHXM2UZh0oW/Aqvj8lhZmJNFG8jbA2G
 lD4ReeBeB07KAlRxyt4orOii4GJkYMQXsnDJnwoMYrD2/R1wZMxOoxxitpBOhvc3nWW/S7hv4+0
 mTSxjnG+gH2fMLEWtkRIRKVBZxUtnb3q7KE6uBRrl+RMbxeDipGICI2Stv4tR0wbm7XkgitnIAJ
 JlHnIqtUX3V5btrGk+Jd1C61wCZKF+A==
X-Google-Smtp-Source: AGHT+IEBGRtTMs2za+2wYpF43h06j2sr+vVkDXCUd9XfS55BitmQh6pHFvNTyX37mP65VX+G5FLSYA==
X-Received: by 2002:a05:600c:c08:b0:43d:563:6fef with SMTP id
 5b1f17b1804b1-43db62bd2b2mr77560595e9.21.1743450557865; 
 Mon, 31 Mar 2025 12:49:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fbbfeaasm132436685e9.9.2025.03.31.12.49.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 11/23] hw/misc/pll: Do not expose as user-creatable
Date: Mon, 31 Mar 2025 21:48:09 +0200
Message-ID: <20250331194822.77309-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

All these devices are part of SoC components and can not
be created manually.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250325224310.8785-9-philmd@linaro.org>
---
 hw/misc/bcm2835_cprman.c | 8 ++++++++
 hw/misc/npcm_clk.c       | 6 ++++++
 hw/misc/stm32l4x5_rcc.c  | 4 ++++
 3 files changed, 18 insertions(+)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index aa14cd931f5..0c4d4b7de50 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -137,6 +137,8 @@ static void pll_class_init(ObjectClass *klass, void *data)
 
     device_class_set_legacy_reset(dc, pll_reset);
     dc->vmsd = &pll_vmstate;
+    /* Reason: Part of BCM2835CprmanState component */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo cprman_pll_info = {
@@ -241,6 +243,8 @@ static void pll_channel_class_init(ObjectClass *klass, void *data)
 
     device_class_set_legacy_reset(dc, pll_channel_reset);
     dc->vmsd = &pll_channel_vmstate;
+    /* Reason: Part of BCM2835CprmanState component */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo cprman_pll_channel_info = {
@@ -362,6 +366,8 @@ static void clock_mux_class_init(ObjectClass *klass, void *data)
 
     device_class_set_legacy_reset(dc, clock_mux_reset);
     dc->vmsd = &clock_mux_vmstate;
+    /* Reason: Part of BCM2835CprmanState component */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo cprman_clock_mux_info = {
@@ -416,6 +422,8 @@ static void dsi0hsck_mux_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &dsi0hsck_mux_vmstate;
+    /* Reason: Part of BCM2835CprmanState component */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo cprman_dsi0hsck_mux_info = {
diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index 0e85974cf96..b6a893ffb22 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -1108,6 +1108,8 @@ static void npcm7xx_clk_pll_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "NPCM7xx Clock PLL Module";
     dc->vmsd = &vmstate_npcm7xx_clk_pll;
+    /* Reason: Part of NPCMCLKState component */
+    dc->user_creatable = false;
 }
 
 static void npcm7xx_clk_sel_class_init(ObjectClass *klass, void *data)
@@ -1116,6 +1118,8 @@ static void npcm7xx_clk_sel_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "NPCM7xx Clock SEL Module";
     dc->vmsd = &vmstate_npcm7xx_clk_sel;
+    /* Reason: Part of NPCMCLKState component */
+    dc->user_creatable = false;
 }
 
 static void npcm7xx_clk_divider_class_init(ObjectClass *klass, void *data)
@@ -1124,6 +1128,8 @@ static void npcm7xx_clk_divider_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "NPCM7xx Clock Divider Module";
     dc->vmsd = &vmstate_npcm7xx_clk_divider;
+    /* Reason: Part of NPCMCLKState component */
+    dc->user_creatable = false;
 }
 
 static void npcm_clk_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index fd8466dff34..158b743cae7 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -150,6 +150,8 @@ static void clock_mux_class_init(ObjectClass *klass, void *data)
     rc->phases.hold = clock_mux_reset_hold;
     rc->phases.exit = clock_mux_reset_exit;
     dc->vmsd = &clock_mux_vmstate;
+    /* Reason: Part of Stm32l4x5RccState component */
+    dc->user_creatable = false;
 }
 
 static void clock_mux_set_enable(RccClockMuxState *mux, bool enabled)
@@ -302,6 +304,8 @@ static void pll_class_init(ObjectClass *klass, void *data)
     rc->phases.hold = pll_reset_hold;
     rc->phases.exit = pll_reset_exit;
     dc->vmsd = &pll_vmstate;
+    /* Reason: Part of Stm32l4x5RccState component */
+    dc->user_creatable = false;
 }
 
 static void pll_set_vco_multiplier(RccPllState *pll, uint32_t vco_multiplier)
-- 
2.47.1


