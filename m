Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB6EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nEE-0001UO-UW; Fri, 03 May 2024 03:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nE4-0001MI-Cb
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:21:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nE2-0001NK-JX
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:21:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41bab13ca81so69549705e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714720856; x=1715325656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lknL/ATTWgGI9RKDIzgYaRoy5BVwYjHb6qLBuptERQ=;
 b=gmvnklvdSRHj6/8v0Sb0sTrGwiHc7V3WW4ZV4sryBYOXiuMsF2k0Cq8C7JzhBsy/S+
 pwocgyPTrREP40MkSVAF36bXzWt8l9Z5GwEC+LZhXpfpiJzNffRVmhe06xhe1+yDP7H9
 l50nVb2hsc587MpNiVjBJBo0A4vjmJ0rvHqYljI/myLRqB0sVngZt374QZUxlHR3IIIB
 KkdEWdI5A9ewxHOph6pB7Y4kQxTPazDOFLsneUa36EFaV8YzKP+aqbiWoLX5HPfZ3YYB
 0U2l1SLdBLbAXRwWkeAdjEoHGK8zswmJncYrmXs4JftHV7FnlD0sGAMwd31nSgc1Yx5G
 WNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720856; x=1715325656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lknL/ATTWgGI9RKDIzgYaRoy5BVwYjHb6qLBuptERQ=;
 b=m6GgDUCkE7cM0sInLTCCgfKlek/PR4a/4Tw2jwkG5jksnFsMpaPR7pRqIUSmtsiFdi
 HGPSKTdrViZ/z61+5SSuhkQ8STjO8xJp57dQJ8D1kJIaY6KfC+0KuUkZfyVjFlE9czvC
 ArCgH4Ll3SVNJ8F5Y3Hrs6v/OjPEGWIrI1b/9Wa1l4Puc8vmcbVroSdAkrhzXVuDJBni
 P/qE6vIXllUcjUKMmvPAMQ0UdrOJ+L/+RNKIpy2pN9cAwsux9WgD4mG6ze/EhG1cFTtI
 rO44AzapfI8aaBrzkpjq96kXcv/JusTXxfxqLmfGcDKhI5tMHs5tk4kRnlBuctaFpvFp
 RI+A==
X-Gm-Message-State: AOJu0Yw+j7hJE5G0CVVxwioicOvwiaFg6dFY4wj+X4+brEUdKaip3I7o
 /pjp8Kd0qVtrFve9NlktWPuv/q5QeJOZ863mr5UHPalax8yHBz97bUkI6rMYIW7yEZpfUPaawfY
 H
X-Google-Smtp-Source: AGHT+IExUT94RUMGYghUOHY4iysM9FQFvR2GY2/TGByA9xcngQSuTyCrc8onR9bwJjDd3lrzgXz4BQ==
X-Received: by 2002:a05:600c:1d0a:b0:41b:fa34:9e48 with SMTP id
 l10-20020a05600c1d0a00b0041bfa349e48mr1849850wms.30.1714720856215; 
 Fri, 03 May 2024 00:20:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a05600c4fc300b0041aa570bcd3sm8383822wmq.35.2024.05.03.00.20.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 00:20:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/9] target/alpha: Split out gen_goto_tb
Date: Fri,  3 May 2024 09:20:11 +0200
Message-ID: <20240503072014.24751-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503072014.24751-1-philmd@linaro.org>
References: <20240503072014.24751-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
[PMD: Split bigger patch, part 5/5]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 51 +++++++++++++---------------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 079bd5d3fd..c1a55e5153 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -425,15 +425,22 @@ static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int rb,
     return DISAS_NEXT;
 }
 
-static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
+static void gen_goto_tb(DisasContext *ctx, int idx, int32_t disp)
 {
-    return translator_use_goto_tb(&ctx->base, dest);
+    uint64_t dest = ctx->base.pc_next + disp;
+
+    if (translator_use_goto_tb(&ctx->base, dest)) {
+        tcg_gen_goto_tb(idx);
+        tcg_gen_movi_i64(cpu_pc, dest);
+        tcg_gen_exit_tb(ctx->base.tb, idx);
+    } else {
+        tcg_gen_movi_i64(cpu_pc, dest);
+        tcg_gen_lookup_and_goto_ptr();
+    }
 }
 
 static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + disp;
-
     if (ra != 31) {
         tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
     }
@@ -442,41 +449,19 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
     if (disp == 0) {
         return DISAS_NEXT;
     }
-
-    if (use_goto_tb(ctx, dest)) {
-        tcg_gen_goto_tb(0);
-        tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_exit_tb(ctx->base.tb, 0);
-    } else {
-        tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
-    }
-
+    gen_goto_tb(ctx, 0, disp);
     return DISAS_NORETURN;
 }
 
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
                                         TCGv cmp, uint64_t imm, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + disp;
     TCGLabel *lab_true = gen_new_label();
 
     tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
-    if (use_goto_tb(ctx, ctx->base.pc_next)) {
-        tcg_gen_goto_tb(0);
-        tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
-        tcg_gen_exit_tb(ctx->base.tb, 0);
-    }
-    /* FALLTHRU */
+    gen_goto_tb(ctx, 0, 0);
     gen_set_label(lab_true);
-    if (use_goto_tb(ctx, dest)) {
-        tcg_gen_goto_tb(1);
-        tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_exit_tb(ctx->base.tb, 1);
-    } else {
-        tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_lookup_and_goto_ptr();
-    }
+    gen_goto_tb(ctx, 1, disp);
 
     return DISAS_NORETURN;
 }
@@ -2920,12 +2905,8 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
-        if (use_goto_tb(ctx, ctx->base.pc_next)) {
-            tcg_gen_goto_tb(0);
-            tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
-            tcg_gen_exit_tb(ctx->base.tb, 0);
-        }
-        /* FALLTHRU */
+        gen_goto_tb(ctx, 0, 0);
+        break;
     case DISAS_PC_STALE:
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
         /* FALLTHRU */
-- 
2.41.0


