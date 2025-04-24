Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC957C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ktv-0006Lf-CV; Wed, 23 Apr 2025 20:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktN-0005fb-7a
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:41 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktL-00054G-4E
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:40 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so359765b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456197; x=1746060997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzXShXwzyB8CledzBeBuUJAwXnIfvn4Gim3OOlxSSgw=;
 b=pnypngI6uF2OGpN7yQpQ8xvmGc53t+vJe+rCjlOzXSNVkiBBf+3n+1glAB8kOXqpim
 arjjD37lAQipysU2zmd4CzfAIZ25/3hE4bCxP9SwqAPvdEPNHO76of3IvP08t2PG8jVB
 KSEyUCLBaA7tBtQHSR6Nr40XUSMsSmCytE+xV7y303qCQFktBkJMEhJimmsP7YV09pyV
 it1E5YldEDYBMHebNrsBEQnCo3L/OgEFHRBZPTdDRoadG+ocbRZQ5n5AB4Fz6Z+fZQpy
 4PB/USaQKoTY907SNbZa5UYCR5xE7/Ok46pojUVNCuIr7rEvwh1yPCyK+ChJT2qZ+TRF
 Ln6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456197; x=1746060997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzXShXwzyB8CledzBeBuUJAwXnIfvn4Gim3OOlxSSgw=;
 b=L3qnINzSkNN0V4aqw1pu73T1LJkC1moQ0o94jfG9QoIhkp6/JjXq4a7R9z3hrpTzaR
 yTa7Oh+yZpVM6WYUkctLShZ//CjL1X1gcYOQS6PPU8vl+m0k1R26j0SLlIS3ACQYSsMi
 TpEfXs/GtY28EzrAK9hgef6tpLxkJMTaX57EyGEEBFFiCtZ4bg/YmofvVQZuHSAB2T/o
 OzJK78eO6c1zoWyo/35xZ8FWY1wuUm4+X31HeUcUiphHJT2Te9cd9Od21ppRQg0lMRDb
 3DD5YflCFW3/5C5Yt8wrt5Zy/4ADa38ev5XrOnupiGG3hKnwU4Ru4SJ7YQwvMjLSp3Wa
 yc2A==
X-Gm-Message-State: AOJu0YzZnuPesa7A5xfDgq1cb3PfuwyMheYEsJj5VW7MXNU/RJfCQsdY
 yDpBDSu+QbAyGBpQp77DywyoIl9zq116kGlkKpEW5hm4lueyU8iLFNoeWSd0mOEq/LSEXWOZxek
 i
X-Gm-Gg: ASbGnctS+usiukZdP9gAGnhyiV+1LUU17gGmnK3P6inK9/uFF9rSKMUvtNUS3fRnD3+
 XSC0qFNLljBAAsPV1RnXKlKp+XoUaQrWkrCQw4x3Mxf/AbAejbk/Wl9T84lg0SrX2vM44Sm6sEm
 tIn3GjVHpmquZGc/At+H1NP2LpWEq5H9iI6nfLxV44myQlmUZ9D/JKzn5umvNC+rqEkXohiKHNH
 P4UDynxq+jxLMQ6yqhkNATrAkF0niWl/4NzTXKgLoD6RFgnji6TbfYLAVWzLxSQk5t7Y8VRLESa
 oYW1KVSebNl77rRBrMsNQBY+z2Q2uFgftMtoIuQ90O/vZsZ2e69xfAv/ysn+XvWoWhsRfAy8dP4
 =
X-Google-Smtp-Source: AGHT+IHREUSNNFKh05BV0930DDgztjiquqxWQpbga4UJxGCI/t+bB4IU13ugYuE9x0xeRzLUatJAjA==
X-Received: by 2002:a05:6a20:7493:b0:1f5:8678:1820 with SMTP id
 adf61e73a8af0-20444e9a69cmr879139637.12.1745456197199; 
 Wed, 23 Apr 2025 17:56:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 084/148] target/mips: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:29 -0700
Message-ID: <20250424004934.598783-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-14-philmd@linaro.org>
---
 target/mips/cpu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 47df563e12..cb0d6dde0e 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -182,11 +182,6 @@ static bool mips_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
-{
-    return mips_env_mmu_index(cpu_env(cs));
-}
-
 #include "cpu-defs.c.inc"
 
 static void mips_cpu_reset_hold(Object *obj, ResetType type)
@@ -549,11 +544,18 @@ static const Property mips_cpu_properties[] = {
 
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
+
+static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
+{
+    return mips_env_mmu_index(cpu_env(cs));
+}
+
 static const TCGCPUOps mips_tcg_ops = {
     .initialize = mips_tcg_init,
     .translate_code = mips_translate_code,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
+    .mmu_index = mips_cpu_mmu_index,
 
 #if !defined(CONFIG_USER_ONLY)
     .tlb_fill = mips_cpu_tlb_fill,
@@ -581,7 +583,6 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
-    cc->mmu_index = mips_cpu_mmu_index;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->get_pc = mips_cpu_get_pc;
-- 
2.43.0


