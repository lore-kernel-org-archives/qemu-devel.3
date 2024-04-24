Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E263DC10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmXx-0008Ia-T3; Wed, 24 Apr 2024 20:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXY-0008AY-2e
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXU-0006BA-JI
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:38 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e65b29f703so3493095ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003234; x=1714608034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IYeP6b8MmHZVDWhGv2pjfTgnSIDzPsYfhG3pp0jo1l8=;
 b=yVKd6IiJ4WLPh8JbNIhaign1XAlfQNSu2aZE2QI3692m99Ti08I05AuSITWJiclf6K
 UvmsD51Ltx7z2Fv/IP0CJ1FMSlQlTu4LCGT2iJhtcTpo01XNPDWj0qd8A8yw9uLSR35h
 bQsKOmjSKcM+fQiFaVtxuIYA6crOZUkSzcgyTO3CEOuDzVR9NEJCyFeibrmsRAjMBHNI
 S9I8sNCQL6eMsa5984DEmFNJ3S6d7W37jRSg6r04TITGaARZ4/kXTwNmtYQNSOu57F5+
 K49ffYZe5ftXdRrk2/yRG4IavyKZ2KIkZxA/WUkfZSwMEvt2a3MdbVE+HqPphpY/FRGX
 ggyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003234; x=1714608034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IYeP6b8MmHZVDWhGv2pjfTgnSIDzPsYfhG3pp0jo1l8=;
 b=nM/9rOqjVfAB/oNXaKHyQOIbAiCpJd0QKzQs/DVlLV+o92lMoDop3kdlW0cmVEoF50
 CludbvIxNtQKSka0P1YAPmVIszbpbgIuveKkWs8P9H7toHd/H6Az3YEYzRGyRpJRK5vk
 ga4JBH9bGKNz8qSGnzRq/D9Ha0b+XW1+SIR8e8CpkfrX4OMAq9EeLnO/ZH06mDt5ZKUE
 2N5px0cz9sFslsTAcHIqe837TbUAT7w1s1PKWKq3Qb9rpHuV8Ey0xgYTUM+Lyjf3fCj4
 a/giJX2A29+ts6Zc4u5U3ZhMWTyyTOEDgaZeGerI0muoF3d8U3/Et+6cseni0vodpAAO
 QmGg==
X-Gm-Message-State: AOJu0YwWTpkkvstC5Dr1Kic7tbfPKmWt8OjccpLtZvc/+J6nOhXL8H0z
 J4zfYyGKt4SEbkMFvrG8qn8b9NjXO2UboYXRuuBFeo0LDTdvrNVeP8rTlYhN16gZ/HMzi92e75i
 s
X-Google-Smtp-Source: AGHT+IG+wXwIJ5DDKBE3v2vjMbwMT6fB2BoQ4sqn243jVbM9ko+vdsLJK+uOzzneJxEoCrcq4jq/dg==
X-Received: by 2002:a17:902:7488:b0:1e2:a91c:9836 with SMTP id
 h8-20020a170902748800b001e2a91c9836mr3972979pll.33.1714003233839; 
 Wed, 24 Apr 2024 17:00:33 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/45] target/hppa: Add install_link
Date: Wed, 24 Apr 2024 16:59:46 -0700
Message-Id: <20240425000023.1002026-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Add a common routine for writing the return address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 54 +++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index cad33e7aa6..195a0e7e79 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -633,6 +633,23 @@ static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
     }
 }
 
+static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
+{
+    tcg_debug_assert(ctx->null_cond.c == TCG_COND_NEVER);
+    if (link) {
+        if (ctx->iaoq_b == -1) {
+            tcg_gen_addi_i64(cpu_gr[link], cpu_iaoq_b, 4);
+        } else {
+            tcg_gen_movi_i64(cpu_gr[link], ctx->iaoq_b + 4);
+        }
+#ifndef CONFIG_USER_ONLY
+        if (with_sr0) {
+            tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
+        }
+#endif
+    }
+}
+
 static inline uint64_t iaoq_dest(DisasContext *ctx, int64_t disp)
 {
     return ctx->iaoq_f + disp + 8;
@@ -1786,9 +1803,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
     uint64_t dest = iaoq_dest(ctx, disp);
 
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
+        install_link(ctx, link, false);
         ctx->iaoq_n = dest;
         if (is_n) {
             ctx->null_cond.c = TCG_COND_ALWAYS;
@@ -1796,10 +1811,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
     } else {
         nullify_over(ctx);
 
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
-
+        install_link(ctx, link, false);
         if (is_n && use_nullify_skip(ctx)) {
             nullify_set(ctx, 0);
             gen_goto_tb(ctx, 0, dest, dest + 4);
@@ -1891,9 +1903,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         next = tcg_temp_new_i64();
         tcg_gen_mov_i64(next, dest);
 
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
+        install_link(ctx, link, false);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
                 install_iaq_entries(ctx, -1, next, -1, NULL);
@@ -1910,16 +1920,17 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
 
     nullify_over(ctx);
 
+    next = tcg_temp_new_i64();
+    tcg_gen_mov_i64(next, dest);
+
+    install_link(ctx, link, false);
     if (is_n && use_nullify_skip(ctx)) {
-        install_iaq_entries(ctx, -1, dest, -1, NULL);
+        install_iaq_entries(ctx, -1, next, -1, NULL);
         nullify_set(ctx, 0);
     } else {
-        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
+        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, next);
         nullify_set(ctx, is_n);
     }
-    if (link != 0) {
-        copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-    }
 
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -3898,10 +3909,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     nullify_over(ctx);
 
     load_spr(ctx, new_spc, a->sp);
-    if (a->l) {
-        copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
-        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
-    }
+    install_link(ctx, a->l, true);
     if (a->n && use_nullify_skip(ctx)) {
         install_iaq_entries(ctx, -1, tmp, -1, NULL);
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
@@ -4018,16 +4026,16 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
     return do_ibranch(ctx, dest, a->l, a->n);
 #else
     nullify_over(ctx);
-    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
+    dest = tcg_temp_new_i64();
+    tcg_gen_mov_i64(dest, load_gpr(ctx, a->b));
+    dest = do_ibranch_priv(ctx, dest);
 
+    install_link(ctx, a->l, false);
     install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
     if (ctx->iaoq_b == -1) {
         tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
     }
     tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
-    if (a->l) {
-        copy_iaoq_entry(ctx, cpu_gr[a->l], ctx->iaoq_n, ctx->iaoq_n_var);
-    }
     nullify_set(ctx, a->n);
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
-- 
2.34.1


