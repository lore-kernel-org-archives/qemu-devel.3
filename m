Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDE8C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmeHB-0005xF-JX; Tue, 19 Mar 2024 14:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmeHA-0005wy-Jp
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:33:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmeH7-0004Ro-6O
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:33:28 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc29f1956cso35942965ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710873202; x=1711478002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1xOReG56nPVqALA8vDFB6RY7onswCEF2rmvjMkp6vpY=;
 b=d1JHBB9kARQXpOwqpi5hPSlM/PsyAbut/OODvKfgKrNdHnh9/dX8yGCAIfmbf8sSeh
 G04TGlzhHxxSfDkHzWDOvKmY9kgtN0J0oFfYWNJ/N2T3wyMiFQ76ktEuB+lMRZUFpzwv
 i79tdRs62IqKBMuPG7ZN6EmLMj2QLIZZhsypGLCDiHYLcgobQ/ROyfoiMdtFgsoTK8e8
 GNKfstS/pyt48jXL2lb8gYYrB0wacw6ryrNV54N1A3l56Xpw9/dHTxm1YcWAYuc+RKlW
 NtqdfaCdVSBLJTfkr4XAwZGUyfSfRXhIkjh8uDywfXJmjNAyucG9PII5YsIyV2PiqOjI
 0mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710873202; x=1711478002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1xOReG56nPVqALA8vDFB6RY7onswCEF2rmvjMkp6vpY=;
 b=oLhB7gs8IVL5ku1Bso37/Pnl6odDAd5YEt1xAJ3LPGgvo06Hg3LxGCAuc1lL+syi1p
 nM6cjnH6uBy+sBoZBniEMAfQsT6td6XiQJvUi/NFSdJKFS40VKA+aOSdgl5BMjV7/uhs
 YDLnzDKm3X7yquqbCAbiSo/e6yKuK/9utW3SmHp8laE7e+dmY+AYW1R4y4u8OpCB7FNm
 KZa+V/mNljOyv6yONLohj04TXwWR2M3c2QV4JWW/oa9zCm+8NZX6jthCkj9wiSioHG4a
 1jlbyqELy8ayrR2OtlAabS/1GNfKISxnHh5ttpiAlE69+lf9KW8KyBTyt2WLcXuVdRR7
 ZJMw==
X-Gm-Message-State: AOJu0YxmwoIPLzhm+Fa+gMTZWxsqiA3Kl7JOwbYUDkOcZFvhh6uyB/r4
 gMrloUtCrKPyB97TN85yy5JpO75DMPrDrs82d13hbZ0igWB8HclcrwHy1gvQt3SopQ1Ud0cPvdf
 y
X-Google-Smtp-Source: AGHT+IEvbOmgPo/+U4zwKKQkMh5b47meopoLXxDjsZ8PKDvGBrMTWbzYPEBBe33kmsVTZBuKcFvT7Q==
X-Received: by 2002:a17:903:1209:b0:1dd:61a6:ecd1 with SMTP id
 l9-20020a170903120900b001dd61a6ecd1mr15127988plh.32.1710873202448; 
 Tue, 19 Mar 2024 11:33:22 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a170902d2d200b001dee0e175c1sm11050890plc.118.2024.03.19.11.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 11:33:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [RFC PATCH] target/hppa: Introduce and use IAQEntry
Date: Tue, 19 Mar 2024 08:33:19 -1000
Message-Id: <20240319183319.379531-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Wrap offset and space into a single structure, with
offset represented either as a constant or as variable.
This enhances copy_iaoq_entry to copy the space, and at
the same time simplifying the code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Sven, I think this might solve your branch-with-space-change issue.
There are a couple of places where it does appear as if we might be
losing a space change, with a branch within a branch delay slot.
I'm trying to solve this by keeping both queue entries together.

r~

---
 target/hppa/translate.c | 498 +++++++++++++++++++++-------------------
 1 file changed, 263 insertions(+), 235 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index be0b0494d0..e555d542c8 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -41,15 +41,31 @@ typedef struct DisasCond {
     TCGv_i64 a0, a1;
 } DisasCond;
 
+/* Describe a complete Instruction Address Queue entry. */
+typedef struct IAQEntry {
+    /*
+     * Non-constant value of ia space.
+     * When null, IASQ_Front, IASQ_Back, and IASQ_Next are all equal.
+     */
+    TCGv_i64 space;
+    /*
+     * Non-constant value of ia offset, or env destination.
+     * If non-null, will always be set on copy.
+     */
+    TCGv_i64 ofsv;
+    /*
+     * Known constant value of ia offset with no change to ia space.
+     * Unused if either spc or ofsv are non-null.
+     */
+    uint64_t ofsc;
+} IAQEntry;
+
 typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
     TCGOp *insn_start;
 
-    uint64_t iaoq_f;
-    uint64_t iaoq_b;
-    uint64_t iaoq_n;
-    TCGv_i64 iaoq_n_var;
+    IAQEntry iaq_f, iaq_b, iaq_n;
 
     DisasCond null_cond;
     TCGLabel *null_lab;
@@ -221,15 +237,13 @@ static int cmpbid_c(DisasContext *ctx, int val)
 static TCGv_i64 cpu_gr[32];
 static TCGv_i64 cpu_sr[4];
 static TCGv_i64 cpu_srH;
-static TCGv_i64 cpu_iaoq_f;
-static TCGv_i64 cpu_iaoq_b;
-static TCGv_i64 cpu_iasq_f;
-static TCGv_i64 cpu_iasq_b;
 static TCGv_i64 cpu_sar;
 static TCGv_i64 cpu_psw_n;
 static TCGv_i64 cpu_psw_v;
 static TCGv_i64 cpu_psw_cb;
 static TCGv_i64 cpu_psw_cb_msb;
+static IAQEntry cpu_iaq_f;
+static IAQEntry cpu_iaq_b;
 
 void hppa_translate_init(void)
 {
@@ -242,8 +256,6 @@ void hppa_translate_init(void)
         DEF_VAR(psw_v),
         DEF_VAR(psw_cb),
         DEF_VAR(psw_cb_msb),
-        DEF_VAR(iaoq_f),
-        DEF_VAR(iaoq_b),
     };
 
 #undef DEF_VAR
@@ -282,12 +294,18 @@ void hppa_translate_init(void)
         *v->var = tcg_global_mem_new(tcg_env, v->ofs, v->name);
     }
 
-    cpu_iasq_f = tcg_global_mem_new_i64(tcg_env,
-                                        offsetof(CPUHPPAState, iasq_f),
-                                        "iasq_f");
-    cpu_iasq_b = tcg_global_mem_new_i64(tcg_env,
-                                        offsetof(CPUHPPAState, iasq_b),
-                                        "iasq_b");
+    cpu_iaq_f.ofsv = tcg_global_mem_new_i64(tcg_env,
+                                            offsetof(CPUHPPAState, iaoq_f),
+                                            "iaoq_f");
+    cpu_iaq_b.ofsv = tcg_global_mem_new_i64(tcg_env,
+                                            offsetof(CPUHPPAState, iaoq_b),
+                                            "iaoq_b");
+    cpu_iaq_f.space = tcg_global_mem_new_i64(tcg_env,
+                                             offsetof(CPUHPPAState, iasq_f),
+                                             "iasq_f");
+    cpu_iaq_b.space = tcg_global_mem_new_i64(tcg_env,
+                                             offsetof(CPUHPPAState, iasq_b),
+                                             "iasq_b");
 }
 
 static void set_insn_breg(DisasContext *ctx, int breg)
@@ -593,31 +611,48 @@ static uint64_t gva_offset_mask(DisasContext *ctx)
             : MAKE_64BIT_MASK(0, 32));
 }
 
-static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
-                            uint64_t ival, TCGv_i64 vval)
+static void copy_iaq_entry(DisasContext *ctx, IAQEntry *d, IAQEntry *s)
 {
     uint64_t mask = gva_offset_mask(ctx);
 
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
+    if (s->ofsv == NULL) {
+        /* With ofs constant, space is unchanged. */
+        assert(s->space == NULL);
+        if (d->ofsv) {
+            tcg_gen_movi_i64(d->ofsv, s->ofsc & mask);
+        } else {
+            d->ofsc = s->ofsc & mask;
+        }
     } else {
-        tcg_gen_andi_i64(dest, vval, mask);
+        assert(d->ofsv != NULL);
+        /*
+         * We know that the IAOQ is already properly masked.
+         * This optimization is primarily for "iaoq_f = iaoq_b".
+         */
+        if (s->ofsv == cpu_iaq_f.ofsv || s->ofsv == cpu_iaq_b.ofsv) {
+            tcg_gen_mov_i64(d->ofsv, s->ofsv);
+        } else {
+            tcg_gen_andi_i64(d->ofsv, s->ofsv, mask);
+        }
+        if (s->space) {
+            if (d->space) {
+                tcg_gen_mov_i64(d->space, s->space);
+            } else {
+                d->space = s->space;
+            }
+        }
     }
 }
 
-static inline uint64_t iaoq_dest(DisasContext *ctx, int64_t disp)
+static void copy_iaq_offset(DisasContext *ctx, TCGv_i64 dest, IAQEntry *s)
 {
-    return ctx->iaoq_f + disp + 8;
+    IAQEntry d = { .ofsv = dest };
+    copy_iaq_entry(ctx, &d, s);
+}
+
+static uint64_t iaoq_dest(DisasContext *ctx, int64_t disp)
+{
+    return ctx->iaq_f.ofsc + disp + 8;
 }
 
 static void gen_excp_1(int exception)
@@ -627,8 +662,9 @@ static void gen_excp_1(int exception)
 
 static void gen_excp(DisasContext *ctx, int exception)
 {
-    copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
-    copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+    /* Writeback constant IAQ offsets. */
+    copy_iaq_entry(ctx, &cpu_iaq_f, &ctx->iaq_f);
+    copy_iaq_entry(ctx, &cpu_iaq_b, &ctx->iaq_b);
     nullify_save(ctx);
     gen_excp_1(exception);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -660,9 +696,10 @@ static bool gen_illegal(DisasContext *ctx)
     } while (0)
 #endif
 
-static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
+static bool use_goto_tb(DisasContext *ctx, IAQEntry *b, IAQEntry *n)
 {
-    return translator_use_goto_tb(&ctx->base, dest);
+    return (b->ofsv == NULL && n->ofsv == NULL &&
+            translator_use_goto_tb(&ctx->base, b->ofsc));
 }
 
 /* If the next insn is to be nullified, and it's on the same page,
@@ -671,21 +708,21 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
    executing a TB that merely branches to the next TB.  */
 static bool use_nullify_skip(DisasContext *ctx)
 {
-    return (((ctx->iaoq_b ^ ctx->iaoq_f) & TARGET_PAGE_MASK) == 0
-            && !cpu_breakpoint_test(ctx->cs, ctx->iaoq_b, BP_ANY));
+    return ctx->iaq_b.ofsv == NULL
+           && ((ctx->iaq_b.ofsc ^ ctx->iaq_f.ofsc) & TARGET_PAGE_MASK) == 0
+           && !cpu_breakpoint_test(ctx->cs, ctx->iaq_b.ofsc, BP_ANY);
 }
 
-static void gen_goto_tb(DisasContext *ctx, int which,
-                        uint64_t f, uint64_t b)
+static void gen_goto_tb(DisasContext *ctx, int which, IAQEntry *b, IAQEntry *n)
 {
-    if (f != -1 && b != -1 && use_goto_tb(ctx, f)) {
+    if (use_goto_tb(ctx, b, n)) {
         tcg_gen_goto_tb(which);
-        copy_iaoq_entry(ctx, cpu_iaoq_f, f, NULL);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, b, NULL);
+        copy_iaq_entry(ctx, &cpu_iaq_f, b);
+        copy_iaq_entry(ctx, &cpu_iaq_b, n);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, f, cpu_iaoq_b);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, b, ctx->iaoq_n_var);
+        copy_iaq_entry(ctx, &cpu_iaq_f, b);
+        copy_iaq_entry(ctx, &cpu_iaq_b, n);
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -1705,35 +1742,62 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
 static bool do_dbranch(DisasContext *ctx, uint64_t dest,
                        unsigned link, bool is_n)
 {
+    IAQEntry n1, n2;
+
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
+            copy_iaq_offset(ctx, cpu_gr[link], &ctx->iaq_n);
         }
-        ctx->iaoq_n = dest;
+
+        /* Perform an unconditional branch by changing IAQ_Next. */
+        n1.space = NULL;
+        n1.ofsv = NULL;
+        n1.ofsc = dest;
+        copy_iaq_entry(ctx, &ctx->iaq_n, &n1);
+
         if (is_n) {
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
-    } else {
-        nullify_over(ctx);
-
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
-
-        if (is_n && use_nullify_skip(ctx)) {
-            nullify_set(ctx, 0);
-            gen_goto_tb(ctx, 0, dest, dest + 4);
-        } else {
-            nullify_set(ctx, is_n);
-            gen_goto_tb(ctx, 0, ctx->iaoq_b, dest);
-        }
-
-        nullify_end(ctx);
-
-        nullify_set(ctx, 0);
-        gen_goto_tb(ctx, 1, ctx->iaoq_b, ctx->iaoq_n);
-        ctx->base.is_jmp = DISAS_NORETURN;
+        return true;
     }
+
+    /* Conditional branch by virtue of nullification. */
+    nullify_over(ctx);
+
+    if (link != 0) {
+        copy_iaq_offset(ctx, cpu_gr[link], &ctx->iaq_n);
+    }
+
+    /*
+     * Retain any space change already in the queue.
+     * This can happen with B in delay slot of BE.
+     */
+    if (ctx->iaq_n.space) {
+        n1.space = n2.space = ctx->iaq_n.space;
+        n1.ofsv = tcg_constant_i64(dest);
+        n2.ofsv = tcg_constant_i64(dest + 4);
+        n1.ofsc = n2.ofsc = 0;
+    } else {
+        n1.space = n2.space = NULL;
+        n1.ofsv = n2.ofsv = NULL;
+        n1.ofsc = dest;
+        n2.ofsc = dest + 4;
+    }
+
+    if (is_n && use_nullify_skip(ctx)) {
+        nullify_set(ctx, 0);
+        gen_goto_tb(ctx, 0, &n1, &n2);
+    } else {
+        nullify_set(ctx, is_n);
+        gen_goto_tb(ctx, 0, &ctx->iaq_b, &n1);
+    }
+
+    nullify_end(ctx);
+
+    /* Branch not taken. */
+    nullify_set(ctx, 0);
+    gen_goto_tb(ctx, 1, &ctx->iaq_b, &ctx->iaq_n);
+    ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
 
@@ -1745,17 +1809,15 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
     uint64_t dest = iaoq_dest(ctx, disp);
     TCGLabel *taken = NULL;
     TCGCond c = cond->c;
+    IAQEntry n1, n2;
     bool n;
 
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
-    /* Handle TRUE and NEVER as direct branches.  */
+    /* Handle ALWAYS as a direct branch.  */
     if (c == TCG_COND_ALWAYS) {
         return do_dbranch(ctx, dest, 0, is_n && disp >= 0);
     }
-    if (c == TCG_COND_NEVER) {
-        return do_dbranch(ctx, ctx->iaoq_n, 0, is_n && disp < 0);
-    }
 
     taken = gen_new_label();
     tcg_gen_brcond_i64(c, cond->a0, cond->a1, taken);
@@ -1763,33 +1825,40 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 
     /* Not taken: Condition not satisfied; nullify on backward branches. */
     n = is_n && disp < 0;
-    if (n && use_nullify_skip(ctx)) {
-        nullify_set(ctx, 0);
-        gen_goto_tb(ctx, 0, ctx->iaoq_n, ctx->iaoq_n + 4);
-    } else {
-        if (!n && ctx->null_lab) {
-            gen_set_label(ctx->null_lab);
-            ctx->null_lab = NULL;
-        }
-        nullify_set(ctx, n);
-        if (ctx->iaoq_n == -1) {
-            /* The temporary iaoq_n_var died at the branch above.
-               Regenerate it here instead of saving it.  */
-            tcg_gen_addi_i64(ctx->iaoq_n_var, cpu_iaoq_b, 4);
-        }
-        gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
+    if (!n && ctx->null_lab) {
+        gen_set_label(ctx->null_lab);
+        ctx->null_lab = NULL;
     }
+    nullify_set(ctx, n);
+    gen_goto_tb(ctx, 0, &ctx->iaq_b, &ctx->iaq_n);
 
     gen_set_label(taken);
 
     /* Taken: Condition satisfied; nullify on forward branches.  */
     n = is_n && disp >= 0;
+
+    /*
+     * Retain any space change already in the queue.
+     * This can happen with ADDB in delay slot of BE.
+     */
+    if (ctx->iaq_n.space) {
+        n1.space = n2.space = ctx->iaq_n.space;
+        n1.ofsv = tcg_constant_i64(dest);
+        n2.ofsv = tcg_constant_i64(dest + 4);
+        n1.ofsc = n2.ofsc = 0;
+    } else {
+        n1.space = n2.space = NULL;
+        n1.ofsv = n2.ofsv = NULL;
+        n1.ofsc = dest;
+        n2.ofsc = dest + 4;
+    }
+
     if (n && use_nullify_skip(ctx)) {
         nullify_set(ctx, 0);
-        gen_goto_tb(ctx, 1, dest, dest + 4);
+        gen_goto_tb(ctx, 1, &n1, &n2);
     } else {
         nullify_set(ctx, n);
-        gen_goto_tb(ctx, 1, ctx->iaoq_b, dest);
+        gen_goto_tb(ctx, 1, &ctx->iaq_b, &n1);
     }
 
     /* Not taken: the branch itself was nullified.  */
@@ -1808,84 +1877,59 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
                        unsigned link, bool is_n)
 {
-    TCGv_i64 a0, a1, next, tmp;
-    TCGCond c;
+    IAQEntry next = {
+        .space = ctx->iaq_n.space,
+        .ofsv = tcg_temp_new_i64()
+    };
 
     assert(ctx->null_lab == NULL);
 
     if (ctx->null_cond.c == TCG_COND_NEVER) {
+        tcg_gen_mov_i64(next.ofsv, dest);
+
         if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
+            copy_iaq_offset(ctx, cpu_gr[link], &ctx->iaq_n);
         }
-        next = tcg_temp_new_i64();
-        tcg_gen_mov_i64(next, dest);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
-                copy_iaoq_entry(ctx, cpu_iaoq_f, -1, next);
-                tcg_gen_addi_i64(next, next, 4);
-                copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
+                copy_iaq_entry(ctx, &cpu_iaq_f, &next);
+                tcg_gen_addi_i64(next.ofsv, next.ofsv, 4);
+                copy_iaq_entry(ctx, &cpu_iaq_b, &next);
                 nullify_set(ctx, 0);
                 ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
                 return true;
             }
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
-        ctx->iaoq_n = -1;
-        ctx->iaoq_n_var = next;
-    } else if (is_n && use_nullify_skip(ctx)) {
+        ctx->iaq_n = next;
+        return true;
+    }
+
+    nullify_over(ctx);
+
+    tcg_gen_mov_i64(next.ofsv, dest);
+    if (link != 0) {
+        copy_iaq_offset(ctx, cpu_gr[link], &ctx->iaq_n);
+    }
+
+    if (is_n && use_nullify_skip(ctx)) {
         /* The (conditional) branch, B, nullifies the next insn, N,
            and we're allowed to skip execution N (no single-step or
            tracepoint in effect).  Since the goto_ptr that we must use
            for the indirect branch consumes no special resources, we
            can (conditionally) skip B and continue execution.  */
-        /* The use_nullify_skip test implies we have a known control path.  */
-        tcg_debug_assert(ctx->iaoq_b != -1);
-        tcg_debug_assert(ctx->iaoq_n != -1);
-
-        /* We do have to handle the non-local temporary, DEST, before
-           branching.  Since IOAQ_F is not really live at this point, we
-           can simply store DEST optimistically.  Similarly with IAOQ_B.  */
-        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, dest);
-        next = tcg_temp_new_i64();
-        tcg_gen_addi_i64(next, dest, 4);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
-
-        nullify_over(ctx);
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
-        tcg_gen_lookup_and_goto_ptr();
-        return nullify_end(ctx);
+        copy_iaq_entry(ctx, &cpu_iaq_f, &next);
+        tcg_gen_addi_i64(next.ofsv, next.ofsv, 4);
+        copy_iaq_entry(ctx, &cpu_iaq_b, &next);
+        nullify_set(ctx, 0);
     } else {
-        c = ctx->null_cond.c;
-        a0 = ctx->null_cond.a0;
-        a1 = ctx->null_cond.a1;
-
-        tmp = tcg_temp_new_i64();
-        next = tcg_temp_new_i64();
-
-        copy_iaoq_entry(ctx, tmp, ctx->iaoq_n, ctx->iaoq_n_var);
-        tcg_gen_movcond_i64(c, next, a0, a1, tmp, dest);
-        ctx->iaoq_n = -1;
-        ctx->iaoq_n_var = next;
-
-        if (link != 0) {
-            tcg_gen_movcond_i64(c, cpu_gr[link], a0, a1, cpu_gr[link], tmp);
-        }
-
-        if (is_n) {
-            /* The branch nullifies the next insn, which means the state of N
-               after the branch is the inverse of the state of N that applied
-               to the branch.  */
-            tcg_gen_setcond_i64(tcg_invert_cond(c), cpu_psw_n, a0, a1);
-            cond_free(&ctx->null_cond);
-            ctx->null_cond = cond_make_n();
-            ctx->psw_n_nonzero = true;
-        } else {
-            cond_free(&ctx->null_cond);
-        }
+        copy_iaq_entry(ctx, &cpu_iaq_f, &ctx->iaq_b);
+        copy_iaq_entry(ctx, &cpu_iaq_b, &next);
+        nullify_set(ctx, is_n);
     }
-    return true;
+    tcg_gen_lookup_and_goto_ptr();
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return nullify_end(ctx);
 }
 
 /* Implement
@@ -1927,7 +1971,7 @@ static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
    aforementioned BE.  */
 static void do_page_zero(DisasContext *ctx)
 {
-    TCGv_i64 tmp;
+    IAQEntry next = { };
 
     /* If by some means we get here with PSW[N]=1, that implies that
        the B,GATE instruction would be skipped, and we'd fault on the
@@ -1948,11 +1992,11 @@ static void do_page_zero(DisasContext *ctx)
        non-sequential instruction execution.  Normally the PSW[B] bit
        detects this by disallowing the B,GATE instruction to execute
        under such conditions.  */
-    if (ctx->iaoq_b != ctx->iaoq_f + 4) {
+    if (ctx->iaq_b.ofsv || ctx->iaq_b.ofsc != ctx->iaq_f.ofsc + 4) {
         goto do_sigill;
     }
 
-    switch (ctx->iaoq_f & -4) {
+    switch (ctx->iaq_f.ofsc & -4) {
     case 0x00: /* Null pointer call */
         gen_excp_1(EXCP_IMP);
         ctx->base.is_jmp = DISAS_NORETURN;
@@ -1965,11 +2009,11 @@ static void do_page_zero(DisasContext *ctx)
 
     case 0xe0: /* SET_THREAD_POINTER */
         tcg_gen_st_i64(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
-        tmp = tcg_temp_new_i64();
-        tcg_gen_ori_i64(tmp, cpu_gr[31], 3);
-        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
-        tcg_gen_addi_i64(tmp, tmp, 4);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
+        next.ofsv = tcg_temp_new_i64();
+        tcg_gen_ori_i64(next.ofsv, cpu_gr[31], 3);
+        copy_iaq_entry(ctx, &cpu_iaq_f, &next);
+        tcg_gen_addi_i64(next.ofsv, next.ofsv, 4);
+        copy_iaq_entry(ctx, &cpu_iaq_b, &next);
         ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
         break;
 
@@ -2011,7 +2055,8 @@ static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
 {
     unsigned rt = a->t;
     TCGv_i64 tmp = dest_gpr(ctx, rt);
-    tcg_gen_movi_i64(tmp, ctx->iaoq_f);
+
+    tcg_gen_movi_i64(tmp, ctx->iaq_f.ofsc);
     save_gpr(ctx, rt, tmp);
 
     cond_free(&ctx->null_cond);
@@ -2678,8 +2723,8 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
             nullify_over(ctx);
 
             /* Advance the instruction queue.  */
-            copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
-            copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+            copy_iaq_entry(ctx, &cpu_iaq_f, &ctx->iaq_b);
+            copy_iaq_entry(ctx, &cpu_iaq_b, &ctx->iaq_n);
             nullify_set(ctx, 0);
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
@@ -3805,26 +3850,21 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
 #ifdef CONFIG_USER_ONLY
     return do_ibranch(ctx, tmp, a->l, a->n);
 #else
-    TCGv_i64 new_spc = tcg_temp_new_i64();
+    IAQEntry next = { .ofsv = tmp, .space = tcg_temp_new_i64() };
+    load_spr(ctx, next.space, a->sp);
 
-    load_spr(ctx, new_spc, a->sp);
     if (a->l) {
-        copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
-        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_f);
+        copy_iaq_offset(ctx, cpu_gr[31], &ctx->iaq_n);
+        tcg_gen_mov_i64(cpu_sr[0], ctx->iaq_n.space ? : cpu_iaq_b.space);
     }
     if (a->n && use_nullify_skip(ctx)) {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
+        copy_iaq_entry(ctx, &cpu_iaq_f, &next);
         tcg_gen_addi_i64(tmp, tmp, 4);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
-        tcg_gen_mov_i64(cpu_iasq_f, new_spc);
-        tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
+        copy_iaq_entry(ctx, &cpu_iaq_b, &next);
+        nullify_set(ctx, 0);
     } else {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
-        if (ctx->iaoq_b == -1) {
-            tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
-        }
-        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
-        tcg_gen_mov_i64(cpu_iasq_b, new_spc);
+        copy_iaq_entry(ctx, &cpu_iaq_f, &ctx->iaq_b);
+        copy_iaq_entry(ctx, &cpu_iaq_b, &next);
         nullify_set(ctx, a->n);
     }
     tcg_gen_lookup_and_goto_ptr();
@@ -3855,7 +3895,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
      *    b  evil
      * in which instructions at evil would run with increased privs.
      */
-    if (ctx->iaoq_b == -1 || ctx->iaoq_b != ctx->iaoq_f + 4) {
+    if (ctx->iaq_b.ofsv || ctx->iaq_b.ofsc != ctx->iaq_f.ofsc + 4) {
         return gen_illegal(ctx);
     }
 
@@ -3897,12 +3937,12 @@ static bool trans_blr(DisasContext *ctx, arg_blr *a)
     if (a->x) {
         TCGv_i64 tmp = tcg_temp_new_i64();
         tcg_gen_shli_i64(tmp, load_gpr(ctx, a->x), 3);
-        tcg_gen_addi_i64(tmp, tmp, ctx->iaoq_f + 8);
+        tcg_gen_addi_i64(tmp, tmp, ctx->iaq_f.ofsc + 8);
         /* The computation here never changes privilege level.  */
         return do_ibranch(ctx, tmp, a->l, a->n);
     } else {
         /* BLR R0,RX is a good way to load PC+8 into RX.  */
-        return do_dbranch(ctx, ctx->iaoq_f + 8, a->l, a->n);
+        return do_dbranch(ctx, ctx->iaq_f.ofsc + 8, a->l, a->n);
     }
 }
 
@@ -3923,23 +3963,23 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
 
 static bool trans_bve(DisasContext *ctx, arg_bve *a)
 {
-    TCGv_i64 dest;
 
 #ifdef CONFIG_USER_ONLY
-    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
+    TCGv_i64 dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
     return do_ibranch(ctx, dest, a->l, a->n);
 #else
-    nullify_over(ctx);
-    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
+    IAQEntry next;
 
-    copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
-    if (ctx->iaoq_b == -1) {
-        tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
-    }
-    copy_iaoq_entry(ctx, cpu_iaoq_b, -1, dest);
-    tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
+    nullify_over(ctx);
+
+    next.ofsc = 0;
+    next.ofsv = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
+    next.space = space_select(ctx, 0, next.ofsv);
+
+    copy_iaq_entry(ctx, &cpu_iaq_f, &ctx->iaq_b);
+    copy_iaq_entry(ctx, &cpu_iaq_b, &next);
     if (a->l) {
-        copy_iaoq_entry(ctx, cpu_gr[a->l], ctx->iaoq_n, ctx->iaoq_n_var);
+        copy_iaq_offset(ctx, cpu_gr[a->l], &ctx->iaq_n);
     }
     nullify_set(ctx, a->n);
     tcg_gen_lookup_and_goto_ptr();
@@ -4489,8 +4529,8 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = MMU_IDX_TO_PRIV(MMU_USER_IDX);
     ctx->mmu_idx = MMU_USER_IDX;
-    ctx->iaoq_f = ctx->base.pc_first | ctx->privilege;
-    ctx->iaoq_b = ctx->base.tb->cs_base | ctx->privilege;
+    ctx->iaq_f.ofsc = ctx->base.pc_first | ctx->privilege;
+    ctx->iaq_b.ofsc = ctx->base.tb->cs_base | ctx->privilege;
     ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
@@ -4503,12 +4543,18 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     uint64_t iasq_f = cs_base & ~0xffffffffull;
     int32_t diff = cs_base;
 
-    ctx->iaoq_f = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
-    ctx->iaoq_b = (diff ? ctx->iaoq_f + diff : -1);
-#endif
-    ctx->iaoq_n = -1;
-    ctx->iaoq_n_var = NULL;
+    ctx->iaq_f.ofsc = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
+    ctx->iaq_f.ofsv = NULL;
+    ctx->iaq_f.space = NULL;
 
+    if (diff) {
+        ctx->iaq_b.ofsc = ctx->iaq_f.ofsc + diff;
+        ctx->iaq_b.ofsv = NULL;
+        ctx->iaq_b.space = NULL;
+    } else {
+        ctx->iaq_b = cpu_iaq_b;
+    }
+#endif
     ctx->zero = tcg_constant_i64(0);
 
     /* Bound the number of instructions by those left on the page.  */
@@ -4533,8 +4579,13 @@ static void hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
 static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    uint64_t b_ofs;
 
-    tcg_gen_insn_start(ctx->iaoq_f, ctx->iaoq_b, 0);
+    assert(ctx->iaq_f.ofsv == NULL);
+    assert(ctx->iaq_f.space == NULL);
+    assert(ctx->iaq_f.ofsc != -1);
+    b_ofs = ctx->iaq_b.ofsv ? -1 : ctx->iaq_b.ofsc;
+    tcg_gen_insn_start(ctx->iaq_f.ofsc, b_ofs, 0);
     ctx->insn_start = tcg_last_op();
 }
 
@@ -4559,13 +4610,16 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
-        if (ctx->iaoq_b == -1) {
-            ctx->iaoq_n = -1;
-            ctx->iaoq_n_var = tcg_temp_new_i64();
-            tcg_gen_addi_i64(ctx->iaoq_n_var, cpu_iaoq_b, 4);
+        if (ctx->iaq_b.ofsv) {
+            ctx->iaq_n.ofsc = 0;
+            ctx->iaq_n.ofsv = tcg_temp_new_i64();
+            tcg_gen_addi_i64(ctx->iaq_n.ofsv, ctx->iaq_b.ofsv, 4);
+            ctx->iaq_n.space = ctx->iaq_b.space;
         } else {
-            ctx->iaoq_n = ctx->iaoq_b + 4;
-            ctx->iaoq_n_var = NULL;
+            assert(ctx->iaq_b.space == NULL);
+            ctx->iaq_n.ofsc = ctx->iaq_b.ofsc + 4;
+            ctx->iaq_n.ofsv = NULL;
+            ctx->iaq_n.space = NULL;
         }
 
         if (unlikely(ctx->null_cond.c == TCG_COND_ALWAYS)) {
@@ -4583,48 +4637,22 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
     /* Advance the insn queue.  Note that this check also detects
        a priority change within the instruction queue.  */
-    if (ret == DISAS_NEXT && ctx->iaoq_b != ctx->iaoq_f + 4) {
-        if (ctx->iaoq_b != -1 && ctx->iaoq_n != -1
-            && use_goto_tb(ctx, ctx->iaoq_b)
+    if (ret == DISAS_NEXT
+        && (ctx->iaq_b.ofsv != NULL ||
+            ctx->iaq_b.ofsc != ctx->iaq_f.ofsc + 4)) {
+        if (use_goto_tb(ctx, &ctx->iaq_b, &ctx->iaq_n)
             && (ctx->null_cond.c == TCG_COND_NEVER
                 || ctx->null_cond.c == TCG_COND_ALWAYS)) {
             nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
-            gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
+            gen_goto_tb(ctx, 0, &ctx->iaq_b, &ctx->iaq_n);
             ctx->base.is_jmp = ret = DISAS_NORETURN;
         } else {
             ctx->base.is_jmp = ret = DISAS_IAQ_N_STALE;
         }
     }
-    ctx->iaoq_f = ctx->iaoq_b;
-    ctx->iaoq_b = ctx->iaoq_n;
+    ctx->iaq_f = ctx->iaq_b;
+    ctx->iaq_b = ctx->iaq_n;
     ctx->base.pc_next += 4;
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
-            copy_iaoq_entry(ctx, cpu_iaoq_f, -1, cpu_iaoq_b);
-            copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
-#ifndef CONFIG_USER_ONLY
-            tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
-#endif
-            nullify_save(ctx);
-            ctx->base.is_jmp = (ret == DISAS_IAQ_N_STALE_EXIT
-                                ? DISAS_EXIT
-                                : DISAS_IAQ_N_UPDATED);
-        } else if (ctx->iaoq_b == -1) {
-            copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
 }
 
 static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
@@ -4638,8 +4666,8 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     case DISAS_TOO_MANY:
     case DISAS_IAQ_N_STALE:
     case DISAS_IAQ_N_STALE_EXIT:
-        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+        copy_iaq_entry(ctx, &cpu_iaq_f, &ctx->iaq_f);
+        copy_iaq_entry(ctx, &cpu_iaq_b, &ctx->iaq_b);
         nullify_save(ctx);
         /* FALLTHRU */
     case DISAS_IAQ_N_UPDATED:
@@ -4694,6 +4722,6 @@ static const TranslatorOps hppa_tr_ops = {
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
                            vaddr pc, void *host_pc)
 {
-    DisasContext ctx;
+    DisasContext ctx = { };
     translator_loop(cs, tb, max_insns, pc, host_pc, &hppa_tr_ops, &ctx.base);
 }
-- 
2.34.1


