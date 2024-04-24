Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5614FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY9-0008O4-1n; Wed, 24 Apr 2024 20:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXe-0008Az-47
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXZ-0006EH-Pm
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:44 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso3766425ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003240; x=1714608040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NMh1gjymklr1tDAtllO8vmcq7cYQz/9E3LdP6tKYKzg=;
 b=uWfjLYi7wZJbDk6sc+V5/ypmTy7WKPXwXrrG+TgBeFof1vA+KXErLkVhGm3gqVR0WP
 hZCiILnbN+6/Q86OiGTwjnEb8XUuZtYXJaMIfR7CFwyom3ZAajQBd7Bq+Cxxe9XV4Z6W
 lsXd4gM2VWfQgJGbC66snf9SWMqaw16R6jPT/L7A1jvSe4tEYgkCLgSKCnA4ZN4dmzsu
 CErX4FLG4U4CZYwTakZHwR+mVhNEBowExOtXuMrtID2428/NBnSc0X9Z6iBRQSNc297N
 mbt+0hvKs0AI3XPOXACBtmZh0XlTfhA/3MDMZ2G3C0T/mktgcipIsuz2AC39EpKkjq61
 ehmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003240; x=1714608040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NMh1gjymklr1tDAtllO8vmcq7cYQz/9E3LdP6tKYKzg=;
 b=RBFuaB8EyuogwKkFVaZkQhJ9kIpGCXR8/yVDCDKrYDFlFCs8rOiI3hVEVm3Lz8W3X8
 ZTjnFOMfrvP5q6zPA+A1aTsQBpHTS15q3FalOEnf1qMMMqADpOUu4bIe7BfUm/MGpzsT
 ICaXkfcCCpGgOFkENZf3yyShiV/WfSn4rrQCFKN2OhjVm2kPmMtizKPl7LKinjCu2Yf2
 P1QQL+tehpzFSPx/TyljX1tfQlGG+OUC4qyrGwBJcDtgcyRq/zUTjFazEDNmiRgWqltW
 JB028hcRBoOjbVIXOaxEHvg4gkJ0ja6/KlES8xYmRiEC5+06P8ZtAlWJq8iX3Z+Qlvb9
 UyVg==
X-Gm-Message-State: AOJu0YxDO4X9yqU5UqiJgsMjdjCWfBpejpEKhsmge8IOXg6re1FPs6ml
 /9a0sktcYcqQRuKMoNi0N1R/A8xMts1yxSFA7pJgMciCiMjEUEKbvz1mVWOJBlL6N66iycwNYx1
 g
X-Google-Smtp-Source: AGHT+IEiDUd8qV2GnqhQk5nlujj1hhfeOiL+ZL8NTB3Ca6P8mOtaIsVa+ZWV4ygOoBVNRYj2gX16Gw==
X-Received: by 2002:a17:902:f54f:b0:1e4:1932:b0a5 with SMTP id
 h15-20020a170902f54f00b001e41932b0a5mr5591953plf.68.1714003238392; 
 Wed, 24 Apr 2024 17:00:38 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/45] target/hppa: Add space arguments to install_iaq_entries
Date: Wed, 24 Apr 2024 16:59:51 -0700
Message-Id: <20240425000023.1002026-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 58 +++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 43a74dafcf..6b3b298678 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -623,8 +623,9 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
     }
 }
 
-static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
-                                uint64_t ni, TCGv_i64 nv)
+static void install_iaq_entries(DisasContext *ctx,
+                                uint64_t bi, TCGv_i64 bv, TCGv_i64 bs,
+                                uint64_t ni, TCGv_i64 nv, TCGv_i64 ns)
 {
     copy_iaoq_entry(ctx, cpu_iaoq_f, bi, bv);
 
@@ -638,6 +639,12 @@ static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
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
@@ -669,7 +676,8 @@ static void gen_excp_1(int exception)
 
 static void gen_excp(DisasContext *ctx, int exception)
 {
-    install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+    install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f, NULL,
+                        ctx->iaoq_b, cpu_iaoq_b, NULL);
     nullify_save(ctx);
     gen_excp_1(exception);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -723,10 +731,11 @@ static void gen_goto_tb(DisasContext *ctx, int which,
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
@@ -1915,7 +1924,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         install_link(ctx, link, false);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
-                install_iaq_entries(ctx, -1, next, -1, NULL);
+                install_iaq_entries(ctx, -1, next, NULL, -1, NULL, NULL);
                 nullify_set(ctx, 0);
                 ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
                 return true;
@@ -1934,10 +1943,11 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
 
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
 
@@ -2025,7 +2035,7 @@ static void do_page_zero(DisasContext *ctx)
         tcg_gen_st_i64(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
         tmp = tcg_temp_new_i64();
         tcg_gen_ori_i64(tmp, cpu_gr[31], 3);
-        install_iaq_entries(ctx, -1, tmp, -1, NULL);
+        install_iaq_entries(ctx, -1, tmp, NULL, -1, NULL, NULL);
         ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
         break;
 
@@ -2769,8 +2779,8 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
             nullify_over(ctx);
 
             /* Advance the instruction queue.  */
-            install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b,
-                                ctx->iaoq_n, ctx->iaoq_n_var);
+            install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
+                                ctx->iaoq_n, ctx->iaoq_n_var, ctx->iasq_n);
             nullify_set(ctx, 0);
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
@@ -3920,16 +3930,11 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
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
@@ -4040,11 +4045,8 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
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
@@ -4780,13 +4782,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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


