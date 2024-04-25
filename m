Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF87CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWc-0002EF-AP; Thu, 25 Apr 2024 06:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWX-000235-HC
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:17 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWV-0007Ds-FT
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34b3374ae22so806296f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041614; x=1714646414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AMYxQWHy5jEXXCF6WIQ+tbnHt/CyfwoIHxTcgJbKUq8=;
 b=LJ95vDO1mf4Z5f0OZy1hGXtbZNHXhcxT/KZSiZWh5PO+jrIY5CtWhmM1XCqSnPOVZz
 tu5K+/KKjF6JPsR+PqzJ3ZP3lck1tMiTaHFr48/l2Sx0iOcA09Vg2JjLHDaa7+X5Ektj
 LuGIkiFcbiip/i533WdbWb6I808tLgbJNEwQJD0ssEF3M0uWSlhxqKCjHbKbhma5JaMv
 SsVSJHfuLx4eTsCldVA+L0VJ56vyKDBnfI4qlE6UbmHaTF6dgjPRrH9NVTXocYp0aaaa
 XfCqK/jaWU4lAnXHLycQ0aqA1hxOyMLvSTq6b5cUM1hQUDTRBCythyjVj+0cd5k2+4Jc
 ezog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041614; x=1714646414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMYxQWHy5jEXXCF6WIQ+tbnHt/CyfwoIHxTcgJbKUq8=;
 b=FV3nmbHkFyxYlo0JOZMBc0YkdlQrL1ggBWZKq/QMN/2UPbjhJ82aOY+86QtATozFIb
 rLzhDKG7nOKUSeq3EboMSzFaegVorRMG/5H32cSJkP3UsW2u9EOk6CVFyv+CUXbq8w0z
 pCUO+jMqubN43fJl6djMmTF/sBM/3ktMVZhhMIy79N1jX87u74PO26hNjXhsuN1QNfde
 p2nnxfd0QfYOBkzdFiwA81SIv0JVapxTyQwHdNBoAbSCfPN+lcF/ZIxwUy8H1Zf9Zlsr
 rTXpW4V9YxbqJs5f8agPQkLEb0WCmsOdRIAdHFa5RvBH0hrSf8IDZf3l6jZ3/f1hWFOs
 RNLw==
X-Gm-Message-State: AOJu0YxtlM0EcF1H6YguGAquW6MeEknPQqe+SSAJADjKjivQpgG99GU9
 hk4VDjCU7aM+8GWa9DmC+fMj6/qZkmoKetaftT61dwTsKLb0G3zJfMAioV2BDpqUQ20LPTrtW2p
 l
X-Google-Smtp-Source: AGHT+IHC3B9r6BAmcmuzdkAiOsnAbf7VH2QjRphyVF1OKN+Q2k5hrvE5Nh2R5gC+0Vx5Id6Kxticiw==
X-Received: by 2002:adf:e101:0:b0:34a:4f1c:3269 with SMTP id
 t1-20020adfe101000000b0034a4f1c3269mr4319379wrz.0.1714041613951; 
 Thu, 25 Apr 2024 03:40:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/37] hw/misc: Don't special case RESET_TYPE_COLD in
 npcm7xx_clk, gcr
Date: Thu, 25 Apr 2024 11:39:48 +0100
Message-Id: <20240425103958.3237225-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The npcm7xx_clk and npcm7xx_gcr device reset methods look at
the ResetType argument and only handle RESET_TYPE_COLD,
producing a warning if another reset type is passed. This
is different from how every other three-phase-reset method
we have works, and makes it difficult to add new reset types.

A better pattern is "assume that any reset type you don't know
about should be handled like RESET_TYPE_COLD"; switch these
devices to do that. Then adding a new reset type will only
need to touch those devices where its behaviour really needs
to be different from the standard cold reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-id: 20240412160809.1260625-2-peter.maydell@linaro.org
---
 hw/misc/npcm7xx_clk.c | 13 +++----------
 hw/misc/npcm7xx_gcr.c | 12 ++++--------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
index ac1622c38aa..2098c85ee01 100644
--- a/hw/misc/npcm7xx_clk.c
+++ b/hw/misc/npcm7xx_clk.c
@@ -873,20 +873,13 @@ static void npcm7xx_clk_enter_reset(Object *obj, ResetType type)
 
     QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
 
-    switch (type) {
-    case RESET_TYPE_COLD:
-        memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
-        s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        npcm7xx_clk_update_all_clocks(s);
-        return;
-    }
-
+    memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
+    s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    npcm7xx_clk_update_all_clocks(s);
     /*
      * A small number of registers need to be reset on a core domain reset,
      * but no such reset type exists yet.
      */
-    qemu_log_mask(LOG_UNIMP, "%s: reset type %d not implemented.",
-                  __func__, type);
 }
 
 static void npcm7xx_clk_init_clock_hierarchy(NPCM7xxCLKState *s)
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
index 9252f9d1488..c4c4e246d7e 100644
--- a/hw/misc/npcm7xx_gcr.c
+++ b/hw/misc/npcm7xx_gcr.c
@@ -159,14 +159,10 @@ static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
 
     QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
 
-    switch (type) {
-    case RESET_TYPE_COLD:
-        memcpy(s->regs, cold_reset_values, sizeof(s->regs));
-        s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
-        s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
-        s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
-        break;
-    }
+    memcpy(s->regs, cold_reset_values, sizeof(s->regs));
+    s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
+    s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
+    s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
 }
 
 static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
-- 
2.34.1


