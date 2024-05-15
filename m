Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57FBC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8K-0006SR-6w; Wed, 15 May 2024 05:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8C-0005u2-4h
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B87-0001fA-R4
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:02 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42016c8daa7so20102705e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766058; x=1716370858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9vD3QA0hSAnzVhzL4fCLzND1tEPhJQEChXFiX7AsQA=;
 b=xtZLFfLUFZqQxAo61KzEsBADV3Gm7tvww4hAJ3mVtiw83Xy9R37TfCACUAyqvoWIK8
 yskQH3LfYCFSMyivXkmr1CyOXvUvo/r9Io0mZred9feo/j6HZFLqGfsgA6QMBFHVYaLt
 8Aio7vvlkQmYdhXoKba3ofJigdHAzfl2moG7jxERaL/qmZPGIoXVtcoo2zb0CuG6JJIx
 nx6oi+juiJyRyydwZhRh6iDeR2JAWVutUvccriyplqPyajwXi3txUkIUX91s/lDsDMWj
 1lGQ+tbc+3CP9BnHVkaOra09rv/2npfnjZt7QUAKUBNc8U1y8x8czX1yxwVKhOZ2h7Z4
 MOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766058; x=1716370858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9vD3QA0hSAnzVhzL4fCLzND1tEPhJQEChXFiX7AsQA=;
 b=KNK9Pk3XUCNjOxiErCyNz57aaiN+Ukz/fqJ6e1nsgiDY7tMD7f2hu4DUgAIUVg0ywo
 syr9uCeOeulb/tqTDgmlvFuC7w574wyElYMRCZ3mJ9s/767h3nm75et2uYb9uhLCmjHm
 7NdvaFRvqlmydOyveuZn3yULT9oHpkZIpG78D+NPNDEdz+zH0PlsaPiTTDZZ6pkHkksH
 Xy5OqwxBloJljcqcr3DwD8a9kE1Mom9zlcuamp6LCSgIYiBUoF2snt42VKJCZgcJ6b7u
 p3kGdfRbxhuRN4yWJJAlwMMYAFCEVGvKczNRw6Kptdo7eDe6L8ZSAPrbBfTqvIu9fd09
 L3og==
X-Gm-Message-State: AOJu0Yx0ZCbNJFHjHG8I54p1BDdg8MSPur07DzrwPBp4OKDyTt1XhCr5
 Sxyb954kXc86fjeS1i5630V/IYyRdaymvJ+3lbwVVeZeO6uqz1rEs5EpD/Ha1mE/GNKx40BTc85
 cwhg=
X-Google-Smtp-Source: AGHT+IFOUc7feOWKgttyZ0YmikABSlKRDIjGrie7ovnngwZtrLHyAMsLwxJJZtDGUhUI3TF6y2hiLA==
X-Received: by 2002:adf:facb:0:b0:34d:9f92:28e3 with SMTP id
 ffacd0b85a97d-3504a632e3dmr9952936f8f.20.1715766058055; 
 Wed, 15 May 2024 02:40:58 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 17/43] target/hppa: Introduce and use DisasIAQE for branch
 management
Date: Wed, 15 May 2024 11:40:17 +0200
Message-Id: <20240515094043.82850-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

Wrap offset and space together in one structure, ensuring
that they're copied together as required.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 378 +++++++++++++++++++++-------------------
 1 file changed, 198 insertions(+), 180 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1ede4bd725..e0e4db75ee 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -42,21 +42,23 @@ typedef struct DisasCond {
     TCGv_i64 a0, a1;
 } DisasCond;
 
+typedef struct DisasIAQE {
+    /* IASQ; may be null for no change from TB. */
+    TCGv_i64 space;
+    /* IAOQ base; may be null for immediate absolute address. */
+    TCGv_i64 base;
+    /* IAOQ addend; absolute immedate address if base is null. */
+    int64_t disp;
+} DisasIAQE;
+
 typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
 
-    uint64_t iaoq_f;
-    uint64_t iaoq_b;
-    uint64_t iaoq_n;
-    TCGv_i64 iaoq_n_var;
-    /*
-     * Null when IASQ_Back unchanged from IASQ_Front,
-     * or cpu_iasq_b, when IASQ_Back has been changed.
-     */
-    TCGv_i64 iasq_b;
-    /* Null when IASQ_Next unchanged from IASQ_Back, or set by branch. */
-    TCGv_i64 iasq_n;
+    /* IAQ_Front, IAQ_Back. */
+    DisasIAQE iaq_f, iaq_b;
+    /* IAQ_Next, for jumps, otherwise null for simple advance. */
+    DisasIAQE iaq_j, *iaq_n;
 
     DisasCond null_cond;
     TCGLabel *null_lab;
@@ -602,49 +604,67 @@ static bool nullify_end(DisasContext *ctx)
     return true;
 }
 
+static bool iaqe_variable(const DisasIAQE *e)
+{
+    return e->base || e->space;
+}
+
+static DisasIAQE iaqe_incr(const DisasIAQE *e, int64_t disp)
+{
+    return (DisasIAQE){
+        .space = e->space,
+        .base = e->base,
+        .disp = e->disp + disp,
+    };
+}
+
+static DisasIAQE iaqe_branchi(DisasContext *ctx, int64_t disp)
+{
+    return (DisasIAQE){
+        .space = ctx->iaq_b.space,
+        .disp = ctx->iaq_f.disp + 8 + disp,
+    };
+}
+
+static DisasIAQE iaqe_next_absv(DisasContext *ctx, TCGv_i64 var)
+{
+    return (DisasIAQE){
+        .space = ctx->iaq_b.space,
+        .base = var,
+    };
+}
+
 static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
-                            uint64_t ival, TCGv_i64 vval)
+                            const DisasIAQE *src)
 {
     uint64_t mask = gva_offset_mask(ctx->tb_flags);
 
-    if (ival != -1) {
-        tcg_gen_movi_i64(dest, ival & mask);
-        return;
-    }
-    tcg_debug_assert(vval != NULL);
-
-    /*
-     * We know that the IAOQ is already properly masked.
-     * This optimization is primarily for "iaoq_f = iaoq_b".
-     */
-    if (vval == cpu_iaoq_f || vval == cpu_iaoq_b) {
-        tcg_gen_mov_i64(dest, vval);
+    if (src->base == NULL) {
+        tcg_gen_movi_i64(dest, src->disp & mask);
+    } else if (src->disp == 0) {
+        tcg_gen_andi_i64(dest, src->base, mask);
     } else {
-        tcg_gen_andi_i64(dest, vval, mask);
+        tcg_gen_addi_i64(dest, src->base, src->disp);
+        tcg_gen_andi_i64(dest, dest, mask);
     }
 }
 
-static void install_iaq_entries(DisasContext *ctx,
-                                uint64_t bi, TCGv_i64 bv, TCGv_i64 bs,
-                                uint64_t ni, TCGv_i64 nv, TCGv_i64 ns)
+static void install_iaq_entries(DisasContext *ctx, const DisasIAQE *f,
+                                const DisasIAQE *b)
 {
-    copy_iaoq_entry(ctx, cpu_iaoq_f, bi, bv);
+    DisasIAQE b_next;
 
-    /* Allow ni variable, with nv null, to indicate a trivial advance. */
-    if (ni != -1 || nv) {
-        copy_iaoq_entry(ctx, cpu_iaoq_b, ni, nv);
-    } else if (bi != -1) {
-        copy_iaoq_entry(ctx, cpu_iaoq_b, bi + 4, NULL);
-    } else {
-        tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_f, 4);
-        tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
-                         gva_offset_mask(ctx->tb_flags));
+    if (b == NULL) {
+        b_next = iaqe_incr(f, 4);
+        b = &b_next;
     }
-    if (bs) {
-        tcg_gen_mov_i64(cpu_iasq_f, bs);
+    copy_iaoq_entry(ctx, cpu_iaoq_f, f);
+    copy_iaoq_entry(ctx, cpu_iaoq_b, b);
+    if (f->space) {
+        tcg_gen_mov_i64(cpu_iasq_f, f->space);
     }
-    if (ns || bs) {
-        tcg_gen_mov_i64(cpu_iasq_b, ns ? ns : bs);
+    if (b->space || f->space) {
+        tcg_gen_mov_i64(cpu_iasq_b, b->space ? : f->space);
     }
 }
 
@@ -654,10 +674,11 @@ static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
     if (!link) {
         return;
     }
-    if (ctx->iaoq_b == -1) {
-        tcg_gen_addi_i64(cpu_gr[link], cpu_iaoq_b, 4);
+    if (ctx->iaq_b.base) {
+        tcg_gen_addi_i64(cpu_gr[link], ctx->iaq_b.base,
+                         ctx->iaq_b.disp + 4);
     } else {
-        tcg_gen_movi_i64(cpu_gr[link], ctx->iaoq_b + 4);
+        tcg_gen_movi_i64(cpu_gr[link], ctx->iaq_b.disp + 4);
     }
 #ifndef CONFIG_USER_ONLY
     if (with_sr0) {
@@ -666,11 +687,6 @@ static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
 #endif
 }
 
-static inline uint64_t iaoq_dest(DisasContext *ctx, int64_t disp)
-{
-    return ctx->iaoq_f + disp + 8;
-}
-
 static void gen_excp_1(int exception)
 {
     gen_helper_excp(tcg_env, tcg_constant_i32(exception));
@@ -678,8 +694,7 @@ static void gen_excp_1(int exception)
 
 static void gen_excp(DisasContext *ctx, int exception)
 {
-    install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f, NULL,
-                        ctx->iaoq_b, cpu_iaoq_b, NULL);
+    install_iaq_entries(ctx, &ctx->iaq_f, &ctx->iaq_b);
     nullify_save(ctx);
     gen_excp_1(exception);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -711,10 +726,12 @@ static bool gen_illegal(DisasContext *ctx)
     } while (0)
 #endif
 
-static bool use_goto_tb(DisasContext *ctx, uint64_t bofs, uint64_t nofs)
+static bool use_goto_tb(DisasContext *ctx, const DisasIAQE *f,
+                        const DisasIAQE *b)
 {
-    return (bofs != -1 && nofs != -1 &&
-            translator_use_goto_tb(&ctx->base, bofs));
+    return (!iaqe_variable(f) &&
+            (b == NULL || !iaqe_variable(b)) &&
+            translator_use_goto_tb(&ctx->base, f->disp));
 }
 
 /* If the next insn is to be nullified, and it's on the same page,
@@ -724,20 +741,19 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t bofs, uint64_t nofs)
 static bool use_nullify_skip(DisasContext *ctx)
 {
     return (!(tb_cflags(ctx->base.tb) & CF_BP_PAGE)
-            && ctx->iaoq_b != -1
-            && is_same_page(&ctx->base, ctx->iaoq_b));
+            && !iaqe_variable(&ctx->iaq_b)
+            && is_same_page(&ctx->base, ctx->iaq_b.disp));
 }
 
 static void gen_goto_tb(DisasContext *ctx, int which,
-                        uint64_t b, uint64_t n)
+                        const DisasIAQE *f, const DisasIAQE *b)
 {
-    if (use_goto_tb(ctx, b, n)) {
+    if (use_goto_tb(ctx, f, b)) {
         tcg_gen_goto_tb(which);
-        install_iaq_entries(ctx, b, NULL, NULL, n, NULL, NULL);
+        install_iaq_entries(ctx, f, b);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
-        install_iaq_entries(ctx, b, cpu_iaoq_b, ctx->iasq_b,
-                            n, ctx->iaoq_n_var, ctx->iasq_n);
+        install_iaq_entries(ctx, f, b);
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -1818,37 +1834,35 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
 static bool do_dbranch(DisasContext *ctx, int64_t disp,
                        unsigned link, bool is_n)
 {
-    uint64_t dest = iaoq_dest(ctx, disp);
+    ctx->iaq_j = iaqe_branchi(ctx, disp);
 
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, false);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
                 nullify_set(ctx, 0);
-                gen_goto_tb(ctx, 0, dest, dest + 4);
+                gen_goto_tb(ctx, 0, &ctx->iaq_j, NULL);
                 ctx->base.is_jmp = DISAS_NORETURN;
                 return true;
             }
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
-        ctx->iaoq_n = dest;
-        ctx->iaoq_n_var = NULL;
+        ctx->iaq_n = &ctx->iaq_j;
     } else {
         nullify_over(ctx);
 
         install_link(ctx, link, false);
         if (is_n && use_nullify_skip(ctx)) {
             nullify_set(ctx, 0);
-            gen_goto_tb(ctx, 0, dest, dest + 4);
+            gen_goto_tb(ctx, 0, &ctx->iaq_j, NULL);
         } else {
             nullify_set(ctx, is_n);
-            gen_goto_tb(ctx, 0, ctx->iaoq_b, dest);
+            gen_goto_tb(ctx, 0, &ctx->iaq_b, &ctx->iaq_j);
         }
-
         nullify_end(ctx);
 
         nullify_set(ctx, 0);
-        gen_goto_tb(ctx, 1, ctx->iaoq_b, ctx->iaoq_n);
+        gen_goto_tb(ctx, 1, &ctx->iaq_b, NULL);
         ctx->base.is_jmp = DISAS_NORETURN;
     }
     return true;
@@ -1859,7 +1873,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
 static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
                        DisasCond *cond)
 {
-    uint64_t dest = iaoq_dest(ctx, disp);
+    DisasIAQE next;
     TCGLabel *taken = NULL;
     TCGCond c = cond->c;
     bool n;
@@ -1879,26 +1893,29 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
     n = is_n && disp < 0;
     if (n && use_nullify_skip(ctx)) {
         nullify_set(ctx, 0);
-        gen_goto_tb(ctx, 0, ctx->iaoq_n, ctx->iaoq_n + 4);
+        next = iaqe_incr(&ctx->iaq_b, 4);
+        gen_goto_tb(ctx, 0, &next, NULL);
     } else {
         if (!n && ctx->null_lab) {
             gen_set_label(ctx->null_lab);
             ctx->null_lab = NULL;
         }
         nullify_set(ctx, n);
-        gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
+        gen_goto_tb(ctx, 0, &ctx->iaq_b, NULL);
     }
 
     gen_set_label(taken);
 
     /* Taken: Condition satisfied; nullify on forward branches.  */
     n = is_n && disp >= 0;
+
+    next = iaqe_branchi(ctx, disp);
     if (n && use_nullify_skip(ctx)) {
         nullify_set(ctx, 0);
-        gen_goto_tb(ctx, 1, dest, dest + 4);
+        gen_goto_tb(ctx, 1, &next, NULL);
     } else {
         nullify_set(ctx, n);
-        gen_goto_tb(ctx, 1, ctx->iaoq_b, dest);
+        gen_goto_tb(ctx, 1, &ctx->iaq_b, &next);
     }
 
     /* Not taken: the branch itself was nullified.  */
@@ -1912,45 +1929,36 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
     return true;
 }
 
-/* Emit an unconditional branch to an indirect target.  This handles
-   nullification of the branch itself.  */
-static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 dspc,
-                       unsigned link, bool with_sr0, bool is_n)
+/*
+ * Emit an unconditional branch to an indirect target, in ctx->iaq_j.
+ * This handles nullification of the branch itself.
+ */
+static bool do_ibranch(DisasContext *ctx, unsigned link,
+                       bool with_sr0, bool is_n)
 {
-    TCGv_i64 next;
-
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
-        next = tcg_temp_new_i64();
-        tcg_gen_mov_i64(next, dest);
-
         install_link(ctx, link, with_sr0);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
-                install_iaq_entries(ctx, -1, next, dspc, -1, NULL, NULL);
+                install_iaq_entries(ctx, &ctx->iaq_j, NULL);
                 nullify_set(ctx, 0);
                 ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
                 return true;
             }
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
-        ctx->iaoq_n = -1;
-        ctx->iaoq_n_var = next;
-        ctx->iasq_n = dspc;
+        ctx->iaq_n = &ctx->iaq_j;
         return true;
     }
 
     nullify_over(ctx);
 
-    next = tcg_temp_new_i64();
-    tcg_gen_mov_i64(next, dest);
-
     install_link(ctx, link, with_sr0);
     if (is_n && use_nullify_skip(ctx)) {
-        install_iaq_entries(ctx, -1, next, dspc, -1, NULL, NULL);
+        install_iaq_entries(ctx, &ctx->iaq_j, NULL);
         nullify_set(ctx, 0);
     } else {
-        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
-                            -1, next, dspc);
+        install_iaq_entries(ctx, &ctx->iaq_b, &ctx->iaq_j);
         nullify_set(ctx, is_n);
     }
 
@@ -1997,8 +2005,6 @@ static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
    aforementioned BE.  */
 static void do_page_zero(DisasContext *ctx)
 {
-    TCGv_i64 tmp;
-
     /* If by some means we get here with PSW[N]=1, that implies that
        the B,GATE instruction would be skipped, and we'd fault on the
        next insn within the privileged page.  */
@@ -2018,11 +2024,11 @@ static void do_page_zero(DisasContext *ctx)
        non-sequential instruction execution.  Normally the PSW[B] bit
        detects this by disallowing the B,GATE instruction to execute
        under such conditions.  */
-    if (ctx->iaoq_b != ctx->iaoq_f + 4) {
+    if (iaqe_variable(&ctx->iaq_b) || ctx->iaq_b.disp != ctx->iaq_f.disp + 4) {
         goto do_sigill;
     }
 
-    switch (ctx->iaoq_f & -4) {
+    switch (ctx->iaq_f.disp & -4) {
     case 0x00: /* Null pointer call */
         gen_excp_1(EXCP_IMP);
         ctx->base.is_jmp = DISAS_NORETURN;
@@ -2034,11 +2040,15 @@ static void do_page_zero(DisasContext *ctx)
         break;
 
     case 0xe0: /* SET_THREAD_POINTER */
-        tcg_gen_st_i64(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
-        tmp = tcg_temp_new_i64();
-        tcg_gen_ori_i64(tmp, cpu_gr[31], 3);
-        install_iaq_entries(ctx, -1, tmp, NULL, -1, NULL, NULL);
-        ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
+        {
+            DisasIAQE next = { .base = tcg_temp_new_i64() };
+
+            tcg_gen_st_i64(cpu_gr[26], tcg_env,
+                           offsetof(CPUHPPAState, cr[27]));
+            tcg_gen_ori_i64(next.base, cpu_gr[31], 3);
+            install_iaq_entries(ctx, &next, NULL);
+            ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
+        }
         break;
 
     case 0x100: /* SYSCALL */
@@ -2077,11 +2087,12 @@ static bool trans_sync(DisasContext *ctx, arg_sync *a)
 
 static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
 {
-    unsigned rt = a->t;
-    TCGv_i64 tmp = dest_gpr(ctx, rt);
-    tcg_gen_movi_i64(tmp, ctx->iaoq_f & ~3ULL);
-    save_gpr(ctx, rt, tmp);
+    TCGv_i64 dest = dest_gpr(ctx, a->t);
 
+    copy_iaoq_entry(ctx, dest, &ctx->iaq_f);
+    tcg_gen_andi_i64(dest, dest, -4);
+
+    save_gpr(ctx, a->t, dest);
     cond_free(&ctx->null_cond);
     return true;
 }
@@ -2781,8 +2792,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
             nullify_over(ctx);
 
             /* Advance the instruction queue.  */
-            install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
-                                ctx->iaoq_n, ctx->iaoq_n_var, ctx->iasq_n);
+            install_iaq_entries(ctx, &ctx->iaq_b, NULL);
             nullify_set(ctx, 0);
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
@@ -3916,18 +3926,18 @@ static bool trans_depi_sar(DisasContext *ctx, arg_depi_sar *a)
 
 static bool trans_be(DisasContext *ctx, arg_be *a)
 {
-    TCGv_i64 dest = tcg_temp_new_i64();
-    TCGv_i64 space = NULL;
-
-    tcg_gen_addi_i64(dest, load_gpr(ctx, a->b), a->disp);
-    dest = do_ibranch_priv(ctx, dest);
-
 #ifndef CONFIG_USER_ONLY
-    space = tcg_temp_new_i64();
-    load_spr(ctx, space, a->sp);
+    ctx->iaq_j.space = tcg_temp_new_i64();
+    load_spr(ctx, ctx->iaq_j.space, a->sp);
 #endif
 
-    return do_ibranch(ctx, dest, space, a->l, true, a->n);
+    ctx->iaq_j.base = tcg_temp_new_i64();
+    ctx->iaq_j.disp = 0;
+
+    tcg_gen_addi_i64(ctx->iaq_j.base, load_gpr(ctx, a->b), a->disp);
+    ctx->iaq_j.base = do_ibranch_priv(ctx, ctx->iaq_j.base);
+
+    return do_ibranch(ctx, a->l, true, a->n);
 }
 
 static bool trans_bl(DisasContext *ctx, arg_bl *a)
@@ -3937,7 +3947,7 @@ static bool trans_bl(DisasContext *ctx, arg_bl *a)
 
 static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 {
-    uint64_t dest = iaoq_dest(ctx, a->disp);
+    int64_t disp = a->disp;
 
     nullify_over(ctx);
 
@@ -3952,7 +3962,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
      *    b  evil
      * in which instructions at evil would run with increased privs.
      */
-    if (ctx->iaoq_b == -1 || ctx->iaoq_b != ctx->iaoq_f + 4) {
+    if (iaqe_variable(&ctx->iaq_b) || ctx->iaq_b.disp != ctx->iaq_f.disp + 4) {
         return gen_illegal(ctx);
     }
 
@@ -3970,10 +3980,11 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         }
         /* No change for non-gateway pages or for priv decrease.  */
         if (type >= 4 && type - 4 < ctx->privilege) {
-            dest = deposit64(dest, 0, 2, type - 4);
+            disp -= ctx->privilege;
+            disp += type - 4;
         }
     } else {
-        dest &= -4;  /* priv = 0 */
+        disp -= ctx->privilege;  /* priv = 0 */
     }
 #endif
 
@@ -3986,17 +3997,23 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         save_gpr(ctx, a->l, tmp);
     }
 
-    return do_dbranch(ctx, dest - iaoq_dest(ctx, 0), 0, a->n);
+    return do_dbranch(ctx, disp, 0, a->n);
 }
 
 static bool trans_blr(DisasContext *ctx, arg_blr *a)
 {
     if (a->x) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_shli_i64(tmp, load_gpr(ctx, a->x), 3);
-        tcg_gen_addi_i64(tmp, tmp, ctx->iaoq_f + 8);
+        DisasIAQE next = iaqe_incr(&ctx->iaq_f, 8);
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        TCGv_i64 t1 = tcg_temp_new_i64();
+
         /* The computation here never changes privilege level.  */
-        return do_ibranch(ctx, tmp, NULL, a->l, false, a->n);
+        copy_iaoq_entry(ctx, t0, &next);
+        tcg_gen_shli_i64(t1, load_gpr(ctx, a->x), 3);
+        tcg_gen_add_i64(t0, t0, t1);
+
+        ctx->iaq_j = iaqe_next_absv(ctx, t0);
+        return do_ibranch(ctx, a->l, false, a->n);
     } else {
         /* BLR R0,RX is a good way to load PC+8 into RX.  */
         return do_dbranch(ctx, 0, a->l, a->n);
@@ -4015,20 +4032,22 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
         tcg_gen_add_i64(dest, dest, load_gpr(ctx, a->b));
     }
     dest = do_ibranch_priv(ctx, dest);
-    return do_ibranch(ctx, dest, NULL, 0, false, a->n);
+    ctx->iaq_j = iaqe_next_absv(ctx, dest);
+
+    return do_ibranch(ctx, 0, false, a->n);
 }
 
 static bool trans_bve(DisasContext *ctx, arg_bve *a)
 {
     TCGv_i64 b = load_gpr(ctx, a->b);
-    TCGv_i64 dest = do_ibranch_priv(ctx, b);
-    TCGv_i64 space = NULL;
 
 #ifndef CONFIG_USER_ONLY
-    space = space_select(ctx, 0, b);
+    ctx->iaq_j.space = space_select(ctx, 0, b);
 #endif
+    ctx->iaq_j.base = do_ibranch_priv(ctx, b);
+    ctx->iaq_j.disp = 0;
 
-    return do_ibranch(ctx, dest, space, a->l, false, a->n);
+    return do_ibranch(ctx, a->l, false, a->n);
 }
 
 static bool trans_nopbts(DisasContext *ctx, arg_nopbts *a)
@@ -4600,9 +4619,8 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = MMU_IDX_TO_PRIV(MMU_USER_IDX);
     ctx->mmu_idx = MMU_USER_IDX;
-    ctx->iaoq_f = ctx->base.pc_first | ctx->privilege;
-    ctx->iaoq_b = ctx->base.tb->cs_base | ctx->privilege;
-    ctx->iasq_b = NULL;
+    ctx->iaq_f.disp = ctx->base.pc_first | ctx->privilege;
+    ctx->iaq_b.disp = ctx->base.tb->cs_base | ctx->privilege;
     ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
@@ -4615,9 +4633,13 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     uint64_t iasq_f = cs_base & ~0xffffffffull;
     int32_t diff = cs_base;
 
-    ctx->iaoq_f = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
-    ctx->iaoq_b = (diff ? ctx->iaoq_f + diff : -1);
-    ctx->iasq_b = (diff ? NULL : cpu_iasq_b);
+    ctx->iaq_f.disp = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
+    if (diff) {
+        ctx->iaq_b.disp = ctx->iaq_f.disp + diff;
+    } else {
+        ctx->iaq_b.base = cpu_iaoq_b;
+        ctx->iaq_b.space = cpu_iasq_b;
+    }
 #endif
 
     ctx->zero = tcg_constant_i64(0);
@@ -4645,7 +4667,10 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->iaoq_f, ctx->iaoq_b, 0);
+    tcg_debug_assert(!iaqe_variable(&ctx->iaq_f));
+    tcg_gen_insn_start(ctx->iaq_f.disp,
+                       iaqe_variable(&ctx->iaq_b) ? -1 : ctx->iaq_b.disp,
+                       0);
     ctx->insn_start_updated = false;
 }
 
@@ -4668,11 +4693,12 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
            the page permissions for execute.  */
         uint32_t insn = translator_ldl(env, &ctx->base, ctx->base.pc_next);
 
-        /* Set up the IA queue for the next insn.
-           This will be overwritten by a branch.  */
-        ctx->iasq_n = NULL;
-        ctx->iaoq_n_var = NULL;
-        ctx->iaoq_n = ctx->iaoq_b == -1 ? -1 : ctx->iaoq_b + 4;
+        /*
+         * Set up the IA queue for the next insn.
+         * This will be overwritten by a branch.
+         */
+        ctx->iaq_n = NULL;
+        memset(&ctx->iaq_j, 0, sizeof(ctx->iaq_j));
 
         if (unlikely(ctx->null_cond.c == TCG_COND_ALWAYS)) {
             ctx->null_cond.c = TCG_COND_NEVER;
@@ -4693,7 +4719,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         return;
     }
     /* Note this also detects a priority change. */
-    if (ctx->iaoq_b != ctx->iaoq_f + 4 || ctx->iasq_b) {
+    if (iaqe_variable(&ctx->iaq_b)
+        || ctx->iaq_b.disp != ctx->iaq_f.disp + 4) {
         ctx->base.is_jmp = DISAS_IAQ_N_STALE;
         return;
     }
@@ -4702,20 +4729,25 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
      * Advance the insn queue.
      * The only exit now is DISAS_TOO_MANY from the translator loop.
      */
-    ctx->iaoq_f = ctx->iaoq_b;
-    ctx->iaoq_b = ctx->iaoq_n;
-    if (ctx->iaoq_b == -1) {
-        if (ctx->iaoq_n_var) {
-            copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
-        } else {
-            tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_b, 4);
-            tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
-                             gva_offset_mask(ctx->tb_flags));
-        }
+    ctx->iaq_f.disp = ctx->iaq_b.disp;
+    if (!ctx->iaq_n) {
+        ctx->iaq_b.disp += 4;
+        return;
     }
-    if (ctx->iasq_n) {
-        tcg_gen_mov_i64(cpu_iasq_b, ctx->iasq_n);
-        ctx->iasq_b = cpu_iasq_b;
+    /*
+     * If IAQ_Next is variable in any way, we need to copy into the
+     * IAQ_Back globals, in case the next insn raises an exception.
+     */
+    if (ctx->iaq_n->base) {
+        copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaq_n);
+        ctx->iaq_b.base = cpu_iaoq_b;
+        ctx->iaq_b.disp = 0;
+    } else {
+        ctx->iaq_b.disp = ctx->iaq_n->disp;
+    }
+    if (ctx->iaq_n->space) {
+        tcg_gen_mov_i64(cpu_iasq_b, ctx->iaq_n->space);
+        ctx->iaq_b.space = cpu_iasq_b;
     }
 }
 
@@ -4723,43 +4755,29 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     DisasJumpType is_jmp = ctx->base.is_jmp;
-    uint64_t fi, bi;
-    TCGv_i64 fv, bv;
-    TCGv_i64 fs, bs;
-
     /* Assume the insn queue has not been advanced. */
-    fi = ctx->iaoq_b;
-    fv = cpu_iaoq_b;
-    fs = ctx->iasq_b;
-    bi = ctx->iaoq_n;
-    bv = ctx->iaoq_n_var;
-    bs = ctx->iasq_n;
+    DisasIAQE *f = &ctx->iaq_b;
+    DisasIAQE *b = ctx->iaq_n;
 
     switch (is_jmp) {
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
         /* The insn queue has not been advanced. */
-        bi = fi;
-        bv = fv;
-        bs = fs;
-        fi = ctx->iaoq_f;
-        fv = NULL;
-        fs = NULL;
+        f = &ctx->iaq_f;
+        b = &ctx->iaq_b;
         /* FALLTHRU */
     case DISAS_IAQ_N_STALE:
-        if (fs == NULL
-            && bs == NULL
-            && use_goto_tb(ctx, fi, bi)
+        if (use_goto_tb(ctx, f, b)
             && (ctx->null_cond.c == TCG_COND_NEVER
                 || ctx->null_cond.c == TCG_COND_ALWAYS)) {
             nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
-            gen_goto_tb(ctx, 0, fi, bi);
+            gen_goto_tb(ctx, 0, f, b);
             break;
         }
         /* FALLTHRU */
     case DISAS_IAQ_N_STALE_EXIT:
-        install_iaq_entries(ctx, fi, fv, fs, bi, bv, bs);
+        install_iaq_entries(ctx, f, b);
         nullify_save(ctx);
         if (is_jmp == DISAS_IAQ_N_STALE_EXIT) {
             tcg_gen_exit_tb(NULL, 0);
@@ -4815,6 +4833,6 @@ static const TranslatorOps hppa_tr_ops = {
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
                            vaddr pc, void *host_pc)
 {
-    DisasContext ctx;
+    DisasContext ctx = { };
     translator_loop(cs, tb, max_insns, pc, host_pc, &hppa_tr_ops, &ctx.base);
 }
-- 
2.34.1


