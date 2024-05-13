Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EEAC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPU-0002v5-4v; Mon, 13 May 2024 03:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPG-0002pT-ME
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:34 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPB-0001LQ-Uh
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:34 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51ef64d051bso4515284e87.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586447; x=1716191247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJWeNRY/eXd8vSY+AX7pwEwfAqiZIocZhPOl7aCY6u0=;
 b=dPxZpqDZ6Eu02Fi0z+c2vsO3Q5uiVE/CYd9r4M/cWI6Ayg/tFAmpe8nvBvW9HCLMU3
 DepWpJqkyVFWMvLPaSJSN//MswOe5X13zBf4U/LdcEm6Zf7qkv2SyHPKt0NPgpT6e7er
 qkIoVCfQD+wBvRu3dQaYdhYDwyOkmsxHKhRKGH2k4hFKQSGxUhdSY+/Lhzptl4JO/DGk
 8OsF8iInKW5fqr7VZ0185gLTsDQA7583SgCylj5GpwJCLzOY4EjgB8PgZ3W/Y2ROX1OG
 VLgOLod/LUQoHhEzC2ySFq/LHY4xH5BGyf3J+gTR7J453cVoH4hmJjfNQ/jBCVHl7p99
 Hvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586447; x=1716191247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJWeNRY/eXd8vSY+AX7pwEwfAqiZIocZhPOl7aCY6u0=;
 b=Ey9IQON242ExngT/Ec9qx60eUurEwQz4A5STXdekxwHzeWdO/05qIz49GdOX00N210
 ZHaF0TbqYYkP8mVPS+CG4taSFqRNu8rtS8aw5h4BPGH2b10boNfvaCLys6wFpOmpRqqq
 68o6I05Usvd8NRIM4GDOyrSJQFWjXtLpkOdOobU80ZplCQTYfgC09lEIApVCHvBJlNPq
 W8MmEDIXclo2Yi0moDU6zVm5MxfOqbv2mUjZs7b/XFTc6/SAVvl/nHGsvMdqisI0ZtcD
 esPO9Ly3zhRISw5bptvYSUk//LMLV6n0FwUDK3Xm1vQpXSBEbnP9TC1w0EknX1zwVHao
 4T+g==
X-Gm-Message-State: AOJu0YwryvQ2rL+Rm+SHFyMbvTzA5kttw1BkKo/zQNishdt8F9bKIjXD
 NA7oMBYZFP49hjPYZ6CXUsvzM2CqfBN6072RKG0b1IvFi/bNV6FN5p6oG2HPbgb/W3hBDAFolhC
 AxGw=
X-Google-Smtp-Source: AGHT+IEwpgRqihyaPAfvfqsKbcV/+hQa1/ZYjCHacHylDNbNgfRxECP3PG+pBFI7YJ8Zp2tDoxUPmg==
X-Received: by 2002:a05:6512:707:b0:520:b0fe:653f with SMTP id
 2adb3069b0e04-5220ff72ef3mr5313104e87.67.1715586447225; 
 Mon, 13 May 2024 00:47:27 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 11/45] target/hppa: Simplify TB end
Date: Mon, 13 May 2024 09:46:43 +0200
Message-Id: <20240513074717.130949-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 109 +++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ca979f4137..13a48d1b6c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4699,54 +4699,31 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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
 
@@ -4754,23 +4731,51 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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


