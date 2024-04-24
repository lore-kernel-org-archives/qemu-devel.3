Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BB8C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmXx-0008I5-Mh; Wed, 24 Apr 2024 20:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXW-0008AO-U3
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXT-0006Ap-Ga
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:38 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e5715a9ebdso3122205ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003233; x=1714608033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HEk6ePzdOD91iD1Fiz0j8oXWLMklE2R7qPe+xWaLhBM=;
 b=TGuM1eYElqbhUqq171sVwRisyHb1sb+MgRiAZz70Oe2yXhuvlXKh8NsUih3MbJvn0u
 lSMuVDKMPg7i+rFn+Z98Z92cCLd7KnKvZ8oAoawphfRen5y2wOY8Iwozzz6zdmnFKGSI
 CT2uRgZzmYUBZJUq/MdkRbPtR80PsazhZhbImbF8BP4pXoyFtMr7ni4c10mhxG2xh6Ks
 DijZpyUwQhq2sJTm6Z9FQtmsNtQgdbsS/ru/VZzvEaxy6oXLRYCdvZDcq7HfL7gKp6eC
 8bOhWb9p2azh+J7qVdmkFYi10gTY7CG5752pAYJTa6PkKBgBvy8i2NWk3hLSR7V5WgCB
 XWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003233; x=1714608033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HEk6ePzdOD91iD1Fiz0j8oXWLMklE2R7qPe+xWaLhBM=;
 b=P2CI3juW8zmsuQ6vA4RuwwmnGnlfRFj4zQ8YlSHp9SmcUGLIh+9Q4yXiHjrBEDOPnP
 lD5AvVuEPUW3tVRm9e9kEZR8ySEp2OqPWQc3X+QBoYOUVveNNV6SYDxJ6UrmuHlN7qMC
 L3IJkIrYoIimMeiIalllZ1WHAL/qMP9G7OMdwCNOYSSfNYKZRfdoSnjpWPWODQIqBK5n
 hEGhhJ2s3VFcHw2HvBaiz2XrRq+o4UoBUu2dBI6yW0wMp4i7kiVzhKX9Q883AsE/GoAX
 faVk9Pi6TuMG3taQZTY6X0jn7IGMWDD3hrH7VQQLif3N2DK6aZkQUB0anRq5x/cUvBEk
 lp5A==
X-Gm-Message-State: AOJu0Yxk7YoALAWH+HgNSziH3mYf6DxHKhBAwQU2z9dtx1xaU1+znMaf
 +b+pKAXAJbGZs93YPKRVcE2+apvoRoy4aB88pGLl/TAbCIyitwqsi+0EnZ1EjfLBot6n9gDTYH+
 m
X-Google-Smtp-Source: AGHT+IE9y/LI70UFRh20PA25li4kYl5pU4OZmheLRO9/VgEt5IGUbpUHoQfIb37DEu1jSdcSVUgTKQ==
X-Received: by 2002:a17:903:41d0:b0:1e4:6243:8543 with SMTP id
 u16-20020a17090341d000b001e462438543mr4985568ple.5.1714003232982; 
 Wed, 24 Apr 2024 17:00:32 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/45] target/hppa: Add install_iaq_entries
Date: Wed, 24 Apr 2024 16:59:45 -0700
Message-Id: <20240425000023.1002026-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 64 +++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index dfdcb3e23c..cad33e7aa6 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -616,6 +616,23 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
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
@@ -628,8 +645,7 @@ static void gen_excp_1(int exception)
 
 static void gen_excp(DisasContext *ctx, int exception)
 {
-    copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
-    copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+    install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
     nullify_save(ctx);
     gen_excp_1(exception);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -683,12 +699,10 @@ static void gen_goto_tb(DisasContext *ctx, int which,
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
@@ -1882,9 +1896,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
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
@@ -1899,14 +1911,10 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
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
@@ -1997,9 +2005,7 @@ static void do_page_zero(DisasContext *ctx)
         tcg_gen_st_i64(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
         tmp = tcg_temp_new_i64();
         tcg_gen_ori_i64(tmp, cpu_gr[31], 3);
-        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
-        tcg_gen_addi_i64(tmp, tmp, 4);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
+        install_iaq_entries(ctx, -1, tmp, -1, NULL);
         ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
         break;
 
@@ -2743,8 +2749,8 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
             nullify_over(ctx);
 
             /* Advance the instruction queue.  */
-            copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
-            copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+            install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b,
+                                ctx->iaoq_n, ctx->iaoq_n_var);
             nullify_set(ctx, 0);
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
@@ -3897,18 +3903,15 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
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
@@ -4017,11 +4020,10 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
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
@@ -4720,8 +4722,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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
@@ -4750,8 +4752,8 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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


