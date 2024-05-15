Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08BAC25B7D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8M-0006j5-F5; Wed, 15 May 2024 05:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B82-0005m4-Bz
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:56 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7z-0001co-3S
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34ef66c0178so4459096f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766049; x=1716370849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6KGcMVwWSn7kVLgoZwm5idlDPcCsf80saUhPLfhVY8=;
 b=RaAIFog9F4b75VjwYY1I1ZVvizByW/FpfZsv2JCdO0cJ3Rkwe47YJhD4gCTqnIBM77
 PWVrznQiDoLIDWdKN4lRTU+laIAkNA2l5tdYdjLWQm8PMA5AoxCuiJsd55WIL+7wv1P5
 KHM8T7mr8BKPSJQsjfFkvygtxEBD64FG3gyfWmmTIisIPjXu0V+zB5xqxGdIRfcjkT87
 v+JKKCazeV1u6aC1Szas2SNjYixVDGlEOoN5wIF1lKMbqPubo0ApBp+8WEVr6+zu/nuf
 XPjbQQ8Gce7jit6jgTi5lRIzrBoqv+LPLlXPIj+xDayzxy4/1FQ60aqvdD4mG4hroBhp
 sJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766049; x=1716370849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6KGcMVwWSn7kVLgoZwm5idlDPcCsf80saUhPLfhVY8=;
 b=kz3iUZxiW5xudj24IFOXxrrrmO1KByN1xs2g9nMLpdHZEgMAh5i0OCAeslK3wMOY+t
 z1XkGD/dFxCOBfMHVPmzxjIJuBKyybQRm5+EQGMSjAqq7s11IR0c0J+q5q8uMGVJ1Hl9
 l/jyH0HXYsYDjQq1d9WCYoMIKLOOZt+akc7ayJc0VreyKIv5dwWbpeHY7symptVfE5iy
 y9M0CYjLiTSVPImh71I1rSCYRZcB2i2w7scuoyJWPK32T4hdSEQ4yya9k6NGX1ypXasM
 HwGYClAupp+4hATXdJe401fUdzqT3O9676jjgB8CU8nCB3gI/FMBXQuLoCx/ujlCZZfc
 mTfw==
X-Gm-Message-State: AOJu0YwjY9+bfD+SXH4Y2dniYUoW+ls4FQsZXZmCrUyY4WKFw9cwW5Eu
 7BY4GbzWJRbK0M0kCARnnUUx6ZliiAnHbo0R1MrZuHud8dpTJh69e8W6BXE9horuzh421PswRD1
 ynMA=
X-Google-Smtp-Source: AGHT+IE94YDL4KOZKXburWr7rGAydJ07Ua6B2ggMrFFY4ThEvw3f1Deusznx2xkQLvBvKhFTW6R7IQ==
X-Received: by 2002:adf:e501:0:b0:34d:b79c:511 with SMTP id
 ffacd0b85a97d-3504a632b2cmr16504473f8f.20.1715766049633; 
 Wed, 15 May 2024 02:40:49 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 07/43] target/hppa: Add install_iaq_entries
Date: Wed, 15 May 2024 11:40:07 +0200
Message-Id: <20240515094043.82850-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

Instead of two separate cpu_iaoq_entry calls, use one call to update
both IAQ_Front and IAQ_Back.  Simplify with an argument combination
that automatically handles a simple increment from Front to Back.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 64 +++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d272be0e6e..08d5e2a4bc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -617,6 +617,23 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
     }
 }
 
+static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
+                                uint64_t ni, TCGv_i64 nv)
+{
+    copy_iaoq_entry(ctx, cpu_iaoq_f, bi, bv);
+
+    /* Allow ni variable, with nv null, to indicate a trivial advance. */
+    if (ni != -1 || nv) {
+        copy_iaoq_entry(ctx, cpu_iaoq_b, ni, nv);
+    } else if (bi != -1) {
+        copy_iaoq_entry(ctx, cpu_iaoq_b, bi + 4, NULL);
+    } else {
+        tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_f, 4);
+        tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
+                         gva_offset_mask(ctx->tb_flags));
+    }
+}
+
 static inline uint64_t iaoq_dest(DisasContext *ctx, int64_t disp)
 {
     return ctx->iaoq_f + disp + 8;
@@ -629,8 +646,7 @@ static void gen_excp_1(int exception)
 
 static void gen_excp(DisasContext *ctx, int exception)
 {
-    copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
-    copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+    install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
     nullify_save(ctx);
     gen_excp_1(exception);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -684,12 +700,10 @@ static void gen_goto_tb(DisasContext *ctx, int which,
 {
     if (use_goto_tb(ctx, b, n)) {
         tcg_gen_goto_tb(which);
-        copy_iaoq_entry(ctx, cpu_iaoq_f, b, NULL);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, n, NULL);
+        install_iaq_entries(ctx, b, NULL, n, NULL);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, b, cpu_iaoq_b);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, n, ctx->iaoq_n_var);
+        install_iaq_entries(ctx, b, cpu_iaoq_b, n, ctx->iaoq_n_var);
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -1883,9 +1897,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         }
         if (is_n) {
             if (use_nullify_skip(ctx)) {
-                copy_iaoq_entry(ctx, cpu_iaoq_f, -1, next);
-                tcg_gen_addi_i64(next, next, 4);
-                copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
+                install_iaq_entries(ctx, -1, next, -1, NULL);
                 nullify_set(ctx, 0);
                 ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
                 return true;
@@ -1900,14 +1912,10 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
     nullify_over(ctx);
 
     if (is_n && use_nullify_skip(ctx)) {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, dest);
-        next = tcg_temp_new_i64();
-        tcg_gen_addi_i64(next, dest, 4);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
+        install_iaq_entries(ctx, -1, dest, -1, NULL);
         nullify_set(ctx, 0);
     } else {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, dest);
+        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
         nullify_set(ctx, is_n);
     }
     if (link != 0) {
@@ -1998,9 +2006,7 @@ static void do_page_zero(DisasContext *ctx)
         tcg_gen_st_i64(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
         tmp = tcg_temp_new_i64();
         tcg_gen_ori_i64(tmp, cpu_gr[31], 3);
-        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
-        tcg_gen_addi_i64(tmp, tmp, 4);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
+        install_iaq_entries(ctx, -1, tmp, -1, NULL);
         ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
         break;
 
@@ -2744,8 +2750,8 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
             nullify_over(ctx);
 
             /* Advance the instruction queue.  */
-            copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
-            copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+            install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b,
+                                ctx->iaoq_n, ctx->iaoq_n_var);
             nullify_set(ctx, 0);
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
@@ -3898,18 +3904,15 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
         tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
     }
     if (a->n && use_nullify_skip(ctx)) {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
-        tcg_gen_addi_i64(tmp, tmp, 4);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
+        install_iaq_entries(ctx, -1, tmp, -1, NULL);
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
         tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
         nullify_set(ctx, 0);
     } else {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, tmp);
         if (ctx->iaoq_b == -1) {
             tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
         }
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
         tcg_gen_mov_i64(cpu_iasq_b, new_spc);
         nullify_set(ctx, a->n);
     }
@@ -4018,11 +4021,10 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
     nullify_over(ctx);
     dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
 
-    copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+    install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
     if (ctx->iaoq_b == -1) {
         tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
     }
-    copy_iaoq_entry(ctx, cpu_iaoq_b, -1, dest);
     tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
     if (a->l) {
         copy_iaoq_entry(ctx, cpu_gr[a->l], ctx->iaoq_n, ctx->iaoq_n_var);
@@ -4721,8 +4723,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     case DISAS_IAQ_N_STALE:
     case DISAS_IAQ_N_STALE_EXIT:
         if (ctx->iaoq_f == -1) {
-            copy_iaoq_entry(ctx, cpu_iaoq_f, -1, cpu_iaoq_b);
-            copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+            install_iaq_entries(ctx, -1, cpu_iaoq_b,
+                                ctx->iaoq_n, ctx->iaoq_n_var);
 #ifndef CONFIG_USER_ONLY
             tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
 #endif
@@ -4751,8 +4753,8 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     case DISAS_TOO_MANY:
     case DISAS_IAQ_N_STALE:
     case DISAS_IAQ_N_STALE_EXIT:
-        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+        install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f,
+                            ctx->iaoq_b, cpu_iaoq_b);
         nullify_save(ctx);
         /* FALLTHRU */
     case DISAS_IAQ_N_UPDATED:
-- 
2.34.1


