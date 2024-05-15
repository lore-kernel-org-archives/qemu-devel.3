Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4C9C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8J-0006Mn-EY; Wed, 15 May 2024 05:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B84-0005p7-SS
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B82-0001dW-1L
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42017f8de7aso19992995e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766052; x=1716370852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMyHqhS5OxS8Cmc1XYDwE2yVlV/PBlI3c6TyUB0pUZg=;
 b=ThxXjMjcjjowhO8peU0hySoUulSQFzYD8+hJLJwO5Q+dcWoRiC9gZiEdLOvJ2RO6Db
 7SJz9Pa3lJUee5IK4/v4nQrDc9kIpIAveFUGmmgyxBB43F7dr0dWXDZ1eduf7EP0PYDC
 XP4vuiO+65FzUazdeQuZvCcAFYKduUQk1LCgWx0bsfEut33S70R45ms4OXBFHy3PkJ2E
 53j+Zxf3iYKZCR9Esj1RyCyh/JI/PK0qyB6tPUrYNgoYIZT2CfZ3jlQeyumRHB4wz4Zn
 1SfAS481hpdtCs1Dvz/6ntG5+4S9KtC0W2TM50etQmxN7Rh9m9+ehBAH4Y/gBVR3XBHW
 gbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766052; x=1716370852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMyHqhS5OxS8Cmc1XYDwE2yVlV/PBlI3c6TyUB0pUZg=;
 b=rdYVgvmRxtwAdh4mO8VRmyOtMqSQY6j3AxgbLV4maolZAQqQgfV0H/XbZBzJEVqlq0
 51sV3Qn2utx6xY15MM4DeZElOuCJbLfSHVQIzl7BxPE1Uh3J0K+KYby34En3dJg6VZor
 UCnB2dVYO6TZm+IT/ADMeFRn9AkZmMu8eP0IF/ATsoT18dydutYtogAnU6DUQSpygk7X
 qp2c1xOT5ZnVa70B3Aq3gJT+/4141x9j0fRBqfcDRz2LuauQTtvtqDJloiE9INvuFQuJ
 mOBuJvveWK+8QffLRBbYuai6XybVqhZoNhPjTgO4RTkllUlfVgrC7tdq1Uko+FTCKuma
 RiCQ==
X-Gm-Message-State: AOJu0YySJ1fqYRm9uytmGBk5N5dhtqLWAu7fdG85YATixwbK3ZHohOTm
 MKUC7ejEMtkQCYaMHzbcqprrj2biZmVIoDvWlNFTQGaMs30xe7SGdmhcHwI4e1kafEpDB+b5Y+A
 L/wA=
X-Google-Smtp-Source: AGHT+IG3EsljQXGFmOf1dS/5cdBeR4/NDeZfa0YRYGiiHCc2+gr1QFyfiyc0bIi/VMuYiUOZjUuNUw==
X-Received: by 2002:a05:600c:4f12:b0:420:18e9:86d5 with SMTP id
 5b1f17b1804b1-42018e98859mr52776095e9.10.1715766052723; 
 Wed, 15 May 2024 02:40:52 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 11/43] target/hppa: Simplify TB end
Date: Wed, 15 May 2024 11:40:11 +0200
Message-Id: <20240515094043.82850-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

Minimize the amount of code in hppa_tr_translate_insn advancing the
insn queue for the next insn.  Move the goto_tb path to hppa_tr_tb_stop.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 109 +++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6c5efb0023..b79c44bd49 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4700,54 +4700,31 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         }
     }
 
-    /* Advance the insn queue.  Note that this check also detects
-       a priority change within the instruction queue.  */
-    if (ret == DISAS_NEXT && ctx->iaoq_b != ctx->iaoq_f + 4) {
-        if (use_goto_tb(ctx, ctx->iaoq_b, ctx->iaoq_n)
-            && (ctx->null_cond.c == TCG_COND_NEVER
-                || ctx->null_cond.c == TCG_COND_ALWAYS)) {
-            nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
-            gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
-            ctx->base.is_jmp = ret = DISAS_NORETURN;
-        } else {
-            ctx->base.is_jmp = ret = DISAS_IAQ_N_STALE;
-        }
+    /* If the TranslationBlock must end, do so. */
+    ctx->base.pc_next += 4;
+    if (ret != DISAS_NEXT) {
+        return;
     }
+    /* Note this also detects a priority change. */
+    if (ctx->iaoq_b != ctx->iaoq_f + 4) {
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+        return;
+    }
+
+    /*
+     * Advance the insn queue.
+     * The only exit now is DISAS_TOO_MANY from the translator loop.
+     */
     ctx->iaoq_f = ctx->iaoq_b;
     ctx->iaoq_b = ctx->iaoq_n;
-    ctx->base.pc_next += 4;
-
-    switch (ret) {
-    case DISAS_NORETURN:
-    case DISAS_IAQ_N_UPDATED:
-        break;
-
-    case DISAS_NEXT:
-    case DISAS_IAQ_N_STALE:
-    case DISAS_IAQ_N_STALE_EXIT:
-        if (ctx->iaoq_f == -1) {
-            install_iaq_entries(ctx, -1, cpu_iaoq_b,
-                                ctx->iaoq_n, ctx->iaoq_n_var);
-#ifndef CONFIG_USER_ONLY
-            tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
-#endif
-            nullify_save(ctx);
-            ctx->base.is_jmp = (ret == DISAS_IAQ_N_STALE_EXIT
-                                ? DISAS_EXIT
-                                : DISAS_IAQ_N_UPDATED);
-        } else if (ctx->iaoq_b == -1) {
-            if (ctx->iaoq_n_var) {
-                copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
-            } else {
-                tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_b, 4);
-                tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
-                                 gva_offset_mask(ctx->tb_flags));
-            }
+    if (ctx->iaoq_b == -1) {
+        if (ctx->iaoq_n_var) {
+            copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
+        } else {
+            tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_b, 4);
+            tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
+                             gva_offset_mask(ctx->tb_flags));
         }
-        break;
-
-    default:
-        g_assert_not_reached();
     }
 }
 
@@ -4755,23 +4732,51 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     DisasJumpType is_jmp = ctx->base.is_jmp;
+    uint64_t fi, bi;
+    TCGv_i64 fv, bv;
+    TCGv_i64 fs;
+
+    /* Assume the insn queue has not been advanced. */
+    fi = ctx->iaoq_b;
+    fv = cpu_iaoq_b;
+    fs = fi == -1 ? cpu_iasq_b : NULL;
+    bi = ctx->iaoq_n;
+    bv = ctx->iaoq_n_var;
 
     switch (is_jmp) {
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
-    case DISAS_IAQ_N_STALE:
-    case DISAS_IAQ_N_STALE_EXIT:
-        install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f,
-                            ctx->iaoq_b, cpu_iaoq_b);
-        nullify_save(ctx);
+        /* The insn queue has not been advanced. */
+        bi = fi;
+        bv = fv;
+        fi = ctx->iaoq_f;
+        fv = NULL;
+        fs = NULL;
         /* FALLTHRU */
-    case DISAS_IAQ_N_UPDATED:
-        if (is_jmp != DISAS_IAQ_N_STALE_EXIT) {
-            tcg_gen_lookup_and_goto_ptr();
+    case DISAS_IAQ_N_STALE:
+        if (use_goto_tb(ctx, fi, bi)
+            && (ctx->null_cond.c == TCG_COND_NEVER
+                || ctx->null_cond.c == TCG_COND_ALWAYS)) {
+            nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
+            gen_goto_tb(ctx, 0, fi, bi);
             break;
         }
         /* FALLTHRU */
+    case DISAS_IAQ_N_STALE_EXIT:
+        install_iaq_entries(ctx, fi, fv, bi, bv);
+        if (fs) {
+            tcg_gen_mov_i64(cpu_iasq_f, fs);
+        }
+        nullify_save(ctx);
+        if (is_jmp == DISAS_IAQ_N_STALE_EXIT) {
+            tcg_gen_exit_tb(NULL, 0);
+            break;
+        }
+        /* FALLTHRU */
+    case DISAS_IAQ_N_UPDATED:
+        tcg_gen_lookup_and_goto_ptr();
+        break;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
-- 
2.34.1


