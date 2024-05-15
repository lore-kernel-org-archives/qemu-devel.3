Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8B8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8I-0006Qa-Pp; Wed, 15 May 2024 05:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B86-0005pL-Cg
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:03 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B84-0001dn-2w
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41fd5dc0480so41348145e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766054; x=1716370854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMb5zREhSXLC82TThYEUSCGBhHh5HnCaaLKrwiRaSAU=;
 b=WQ30g4llW2Uo7JB40KE3LSZ0z8Dl6o2uUWcWiZkGfoGRyU8Our3Av6lvA4RUEDrd8u
 Mdy/gYrREY13wNUN1Ipj0ipA13kZ5lNnGoBNYkp7xgWpB6p/XAV1Et2c6FLpKzNo92aX
 NbfFaBlsogsZRkZ0H8LfHgyo4Ot8EkJLYXF0Pg9hiEbEjCoOjCWTK0e8U2KN4nqh/7CQ
 GnoAtwIBZMoqYXjZV7+qGC5SH00vTeOdHqo8cVR0mXXXr5q6e1bhEetHR2by3vM9K9ew
 FPq99P1TEOgiUvFGxIEWUXooysnHC4oUUUfMzIgePpanOb7BXtek0FuMQYw97Ac8DJ9R
 FRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766054; x=1716370854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMb5zREhSXLC82TThYEUSCGBhHh5HnCaaLKrwiRaSAU=;
 b=wP4vzfVWsluj/lCeJ1k8fz0DFClHjWsxORVYGb+HjCXAIVGHgPmp/DOsZUBw/GS3BG
 RgNRr9Adoarff/IGf4LY4c0XNBdEr3xQOF3XlIYZuxn9HyhU+74sjfG674HvUONQnHf8
 V8clBRU5q4/bjGCAM3SkjQA67+eharTokJWT9Njnvs33RXqf/MZ59F9pb1lKQag6Q679
 pHCYPKHW6vLnjcPvqrjrdCWz3s+9UxEvp0vcqBvGSZ7RGvdfPDIM4X4HujyWB6bAZyHN
 8EyG61hznrEN4XvtVDkC2aUBCPmrZwN0v509wpUWtL5q+uRzkoXCAJcQDGSmUCXQJi4S
 5isg==
X-Gm-Message-State: AOJu0YzNPgeTwYxabmF4AyzLuFNz9Pzk+Xq78q0Fz+/WuCjWD5SCesDn
 qnQffTtO5O2ax6bdLOzOfRDWce1h9mYTyPlOVNqTFhyj2jwIWfjammbrlR0MnRsLcflFtBuEpzx
 OY7k=
X-Google-Smtp-Source: AGHT+IHburxRXZk3FJNHFf5WyOra/1Ni3yQwBUtM1Rjyqsnv77vSl3eR9SMAP1ak/2m3R3t2MBkRmg==
X-Received: by 2002:a05:600c:458f:b0:41b:fad8:45de with SMTP id
 5b1f17b1804b1-41feac5a454mr108238855e9.30.1715766054342; 
 Wed, 15 May 2024 02:40:54 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 13/43] target/hppa: Add space arguments to install_iaq_entries
Date: Wed, 15 May 2024 11:40:13 +0200
Message-Id: <20240515094043.82850-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

Move space assighments to a central location.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 58 +++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b4e384baa3..eed0f92db4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -624,8 +624,9 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
     }
 }
 
-static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
-                                uint64_t ni, TCGv_i64 nv)
+static void install_iaq_entries(DisasContext *ctx,
+                                uint64_t bi, TCGv_i64 bv, TCGv_i64 bs,
+                                uint64_t ni, TCGv_i64 nv, TCGv_i64 ns)
 {
     copy_iaoq_entry(ctx, cpu_iaoq_f, bi, bv);
 
@@ -639,6 +640,12 @@ static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
         tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
                          gva_offset_mask(ctx->tb_flags));
     }
+    if (bs) {
+        tcg_gen_mov_i64(cpu_iasq_f, bs);
+    }
+    if (ns || bs) {
+        tcg_gen_mov_i64(cpu_iasq_b, ns ? ns : bs);
+    }
 }
 
 static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
@@ -671,7 +678,8 @@ static void gen_excp_1(int exception)
 
 static void gen_excp(DisasContext *ctx, int exception)
 {
-    install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+    install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f, NULL,
+                        ctx->iaoq_b, cpu_iaoq_b, NULL);
     nullify_save(ctx);
     gen_excp_1(exception);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -725,10 +733,11 @@ static void gen_goto_tb(DisasContext *ctx, int which,
 {
     if (use_goto_tb(ctx, b, n)) {
         tcg_gen_goto_tb(which);
-        install_iaq_entries(ctx, b, NULL, n, NULL);
+        install_iaq_entries(ctx, b, NULL, NULL, n, NULL, NULL);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
-        install_iaq_entries(ctx, b, cpu_iaoq_b, n, ctx->iaoq_n_var);
+        install_iaq_entries(ctx, b, cpu_iaoq_b, ctx->iasq_b,
+                            n, ctx->iaoq_n_var, ctx->iasq_n);
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -1917,7 +1926,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         install_link(ctx, link, false);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
-                install_iaq_entries(ctx, -1, next, -1, NULL);
+                install_iaq_entries(ctx, -1, next, NULL, -1, NULL, NULL);
                 nullify_set(ctx, 0);
                 ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
                 return true;
@@ -1936,10 +1945,11 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
 
     install_link(ctx, link, false);
     if (is_n && use_nullify_skip(ctx)) {
-        install_iaq_entries(ctx, -1, next, -1, NULL);
+        install_iaq_entries(ctx, -1, next, NULL, -1, NULL, NULL);
         nullify_set(ctx, 0);
     } else {
-        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, next);
+        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
+                            -1, next, NULL);
         nullify_set(ctx, is_n);
     }
 
@@ -2027,7 +2037,7 @@ static void do_page_zero(DisasContext *ctx)
         tcg_gen_st_i64(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
         tmp = tcg_temp_new_i64();
         tcg_gen_ori_i64(tmp, cpu_gr[31], 3);
-        install_iaq_entries(ctx, -1, tmp, -1, NULL);
+        install_iaq_entries(ctx, -1, tmp, NULL, -1, NULL, NULL);
         ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
         break;
 
@@ -2771,8 +2781,8 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
             nullify_over(ctx);
 
             /* Advance the instruction queue.  */
-            install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b,
-                                ctx->iaoq_n, ctx->iaoq_n_var);
+            install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
+                                ctx->iaoq_n, ctx->iaoq_n_var, ctx->iasq_n);
             nullify_set(ctx, 0);
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
@@ -3922,16 +3932,11 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     load_spr(ctx, new_spc, a->sp);
     install_link(ctx, a->l, true);
     if (a->n && use_nullify_skip(ctx)) {
-        install_iaq_entries(ctx, -1, tmp, -1, NULL);
-        tcg_gen_mov_i64(cpu_iasq_f, new_spc);
-        tcg_gen_mov_i64(cpu_iasq_b, new_spc);
+        install_iaq_entries(ctx, -1, tmp, new_spc, -1, NULL, new_spc);
         nullify_set(ctx, 0);
     } else {
-        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, tmp);
-        if (ctx->iasq_b) {
-            tcg_gen_mov_i64(cpu_iasq_f, ctx->iasq_b);
-        }
-        tcg_gen_mov_i64(cpu_iasq_b, new_spc);
+        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
+                            -1, tmp, new_spc);
         nullify_set(ctx, a->n);
     }
     tcg_gen_lookup_and_goto_ptr();
@@ -4042,11 +4047,8 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
     dest = do_ibranch_priv(ctx, dest);
 
     install_link(ctx, a->l, false);
-    install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
-    if (ctx->iasq_b) {
-        tcg_gen_mov_i64(cpu_iasq_f, ctx->iasq_b);
-    }
-    tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
+    install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
+                        -1, dest, space_select(ctx, 0, dest));
     nullify_set(ctx, a->n);
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -4782,13 +4784,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         }
         /* FALLTHRU */
     case DISAS_IAQ_N_STALE_EXIT:
-        install_iaq_entries(ctx, fi, fv, bi, bv);
-        if (fs) {
-            tcg_gen_mov_i64(cpu_iasq_f, fs);
-        }
-        if (bs) {
-            tcg_gen_mov_i64(cpu_iasq_b, bs);
-        }
+        install_iaq_entries(ctx, fi, fv, fs, bi, bv, bs);
         nullify_save(ctx);
         if (is_jmp == DISAS_IAQ_N_STALE_EXIT) {
             tcg_gen_exit_tb(NULL, 0);
-- 
2.34.1


