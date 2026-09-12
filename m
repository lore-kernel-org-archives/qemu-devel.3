Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4048AC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L8L-0006l0-2b; Sat, 12 Sep 2026 06:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L8H-0006jo-QQ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:38:54 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L8F-0000bX-Cb
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:38:53 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso1820696a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209529; x=1789814329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=baXAlzN6SUZ/28JUDqdTNn15iwERXkS9cPzuvqcCx48=;
 b=goZE30hsnyUhSbwRr2yww66xOzw9NE0pIvjWv6LFaSKLXQKKJhJDPLGn/uvFzspZ/X
 GWuShIeFvJawC29EYxFEbzaRzhQXrgRN3q3Gn8KevrAHT93vlyrTJtvemdPRuv2JH5ZN
 NBwjgCrUKe7iNWvYqfRfxR6AbmdfcLlZSwEefhRy1u3JCTlg2h7oXLErz6xnKCK2KDsG
 moQQ0+xQ4IfR0cwVfebhtYrX3H7zIC7K4ayph2BYgNKEk9ukTt4JXXx4jmD8sd6O1GuP
 l8WB6X+clMqInThl65eM13jZ8fiuE5Vtu6O9VNKqYX8GH+LczqoPBKlX1ud74cut/WUk
 dByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209529; x=1789814329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=baXAlzN6SUZ/28JUDqdTNn15iwERXkS9cPzuvqcCx48=;
 b=F8lqCzrCh1iIZcQcWFdAKqhFCdzawQW8E66yB6WEb1hvBuUJK1Rt28x5qdm7LjjAIa
 NLI94u2CsxygZFDF0WcnEkZ9Das/VJJZtkO5TVuTARHOiSocmZWs4Jc8fH68QXNt2h48
 muhfR7wAW4ZRYLOxCgJ4mWuYyglQJC8olLqIYAgv9IlB/IuY/jH4JQXVykVPOVsjyKbB
 aRwNY/8vkCSxTN2J7Ue+Mv5mhYveju9royvBhvG6nMPYVXXs9RKSpymhERqhjT/hJTEd
 ppxkZYKZCw8sjq7zh4s0uZVq31tnqk5D9emTaxjicMC+alaR7+Rqr5Ol9S1EvfYI4yFs
 YLYg==
X-Gm-Message-State: AFuF++kaFlEclFUSlmnzlMDMHcfFwXXR/QCse5/i2jMLLXc5fO0rIk9N
 rmuR04gMHThDfzKQMm/iM76TfK7Mq+MtlqOOGsRrIMFsGF9XSZb+vN4QhCm0d0107SkQuIqghPo
 IO9Rd4cQ=
X-Gm-Gg: AYBFou1IiERGfM5DjH1dp7BgDJoqgiZcNjUMjEjy5nwhRzuzh/bnK+bCt1+PKXi0/q/
 ewDs8SDxRDRm7uIjuUg52f9v4pTa5cvfqizOsht+XZaTqZaMgrZDoPAmmiH3B7iGlR27LyO8aZo
 rLdg+TrRsA9zUy20kAkBF6gL3DVqZ7u7DZr0Ty6TU7VSG/drYPAqjk0twWQpMIeiC/qAB7r9Uw3
 EP3a3Hb7qT18XzrDGqb6caz/XzAfzA3O5FYwcWiJTKzFlZ60G01Wty0UuyYykSJQZ7zuCaAQuXc
 Fq1p6M+X3w88ezPCMi6GgzzUqja6KP0f8CWIV8AW+R7+ITQkVQlBxmX3HRf7OYUXgj3Ap1MN9pi
 04c/812YBmOilkeXF+yxSfuvpVaEiIjwyKt99tG5UZfs4UYIchYl4J7FEL9WijbjzIDW0d+fowR
 5qqe+7bO54UzMTEH4rdeoHNTdTmjOWjvI/LekRupEuYLAEzISLxE+P4yAb1D6g8v4lIovwg9MzY
 ffjdSQ=
X-Received: by 2002:a17:90b:4fc5:b0:398:ceed:b903 with SMTP id
 98e67ed59e1d1-39d77962e6fmr17963897a91.11.1789209529241; 
 Sat, 12 Sep 2026 03:38:49 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9b359sm12702231eec.14.2026.09.12.03.38.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:38:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 82/82] tcg: Expand missing mulu2_i64 during liveness
Date: Sat, 12 Sep 2026 00:31:26 -1000
Message-ID: <20260912103126.598030-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

During liveness, we finally know whether the high part
of the double-word multiply is actually used.  If we were
to decompose the operation earlier, we would prevent the
removal of the unused value.  This is fairly common with
translated x86 code, where the high part of the multiply
may only be used for condition codes, which may easily be
dead code eliminated.

Once we know the computation is required, expand the multiply
by parts for hosts without ISA support.  At present this is
older s390x and sparc64.  This is far more efficient than the
out-of-line helper.

Since this is after the normal tcg_optmize pass, do some
minimal constant decomposition and value propagation for
the subexpressions within the double-word multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h |   3 -
 accel/tcg/tcg-runtime.c |  14 ---
 tcg/tcg-op.c            |  34 ++-----
 tcg/tcg.c               | 214 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 218 insertions(+), 47 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 003c963bc7d..0dda2079fd0 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -1,6 +1,3 @@
-DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-
 DEF_HELPER_FLAGS_2(clz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(ctz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(clz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 77c4024148f..44b48a1ea79 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -32,20 +32,6 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-uint64_t HELPER(muluh_i64)(uint64_t arg1, uint64_t arg2)
-{
-    uint64_t l, h;
-    mulu64(&l, &h, arg1, arg2);
-    return h;
-}
-
-int64_t HELPER(mulsh_i64)(int64_t arg1, int64_t arg2)
-{
-    uint64_t l, h;
-    muls64(&l, &h, arg1, arg2);
-    return h;
-}
-
 uint32_t HELPER(clz_i32)(uint32_t arg, uint32_t zero_val)
 {
     return arg ? clz32(arg) : zero_val;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 829a400ff1b..08b44fc5254 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -871,8 +871,7 @@ static void gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
 
         tcg_temp_free_internal(t0);
         tcg_temp_free_internal(t1);
-    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
-               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
+    } else {
         TCGTemp *t0 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
         TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
         TCGTemp *t2 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
@@ -893,24 +892,13 @@ static void gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
         tcg_temp_free_internal(t1);
         tcg_temp_free_internal(t2);
         tcg_temp_free_internal(t3);
-    } else {
-        TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
-
-        gen_mul(TCG_TYPE_I64, t, src1, src2);
-        gen_helper_mulsh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
-                             temp_tcgv_i64(src2));
-        gen_mov(TCG_TYPE_I64, rl, t);
-
-        tcg_temp_free_internal(t);
     }
 }
 
 static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
                       TCGTemp *src1, TCGTemp *src2)
 {
-    if (tcg_op_supported(INDEX_op_mulu2, type, 0)) {
-        gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
-    } else if (tcg_op_supported(INDEX_op_muluh, type, 0)) {
+    if (tcg_op_supported(INDEX_op_muluh, type, 0)) {
         TCGTemp *t = tcg_temp_new_internal(type, TEMP_EBB);
 
         gen_mul(type, t, src1, src2);
@@ -918,7 +906,14 @@ static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
         gen_mov(type, rl, t);
 
         tcg_temp_free_internal(t);
-    } else if (type == TCG_TYPE_I32) {
+    } if (type == TCG_TYPE_I64 ||
+          tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
+        /*
+         * Unsupported mulu2_i64 is expanded after liveness analysis
+         * has a chance to discard an unused high-part.
+         */
+        gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
+    } else {
         TCGTemp *t0 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
         TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
 
@@ -931,15 +926,6 @@ static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
 
         tcg_temp_free_internal(t0);
         tcg_temp_free_internal(t1);
-    } else {
-        TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
-
-        gen_mul(TCG_TYPE_I64, t, src1, src2);
-        gen_helper_muluh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
-                             temp_tcgv_i64(src2));
-        gen_mov(TCG_TYPE_I64, rl, t);
-
-        tcg_temp_free_internal(t);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 489df0e7386..8cdca81ceb2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3687,6 +3687,32 @@ static inline void la_reset_pref(TCGTemp *ts)
         = (ts->state == TS_DEAD ? 0 : tcg_target_available_regs[ts->type]);
 }
 
+/* For liveness_pass_1, allocate a new dead temporary. */
+static TCGTemp *la_temp_new(TCGType type)
+{
+    TCGTemp *t = tcg_temp_new_internal(type, TEMP_EBB);
+
+    t->state_ptr = tcg_malloc(sizeof(TCGRegSet));
+    t->state = TS_DEAD;
+    la_reset_pref(t);
+
+    return t;
+}
+
+/* For liveness_pass_1, allocate a new constant. */
+static TCGTemp *la_const_new(TCGType type, int64_t val)
+{
+    TCGTemp *t = tcg_constant_internal(type, val);
+
+    /* This constant may already be live within the TB. */
+    if (!t->state_ptr) {
+        t->state_ptr = tcg_malloc(sizeof(TCGRegSet));
+        t->state = TS_DEAD;
+        la_reset_pref(t);
+    }
+    return t;
+}
+
 /* liveness analysis: end of function: all temps are dead, and globals
    should be in memory. */
 static void la_func_end(TCGContext *s, int ng, int nt)
@@ -3890,9 +3916,184 @@ static void assert_carry_dead(TCGContext *s)
     tcg_debug_assert(!s->carry_live);
 }
 
-/* Liveness analysis : update the opc_arg_life array to tell if a
-   given input arguments is dead. Instructions updating dead
-   temporaries are removed. */
+/*
+ * Expand missing mulu2.  This is delayed until liveness because x86
+ * translation generates double-word multiplies which may turn out to
+ * be dead with condition codes, and we may be able to simplify to
+ * just a single-word multiply.
+ */
+
+static TCGTemp *la_mulu2_ext32u(TCGContext *ctx, TCGOp *op,
+                                TCGTemp *dst, TCGTemp *src)
+{
+    TCGOp *op2 = tcg_op_insert_before(ctx, op, INDEX_op_extract,
+                                      TCG_TYPE_I64, 4);
+
+    op2->args[0] = temp_arg(dst);
+    op2->args[1] = temp_arg(src);
+    op2->args[2] = 0;
+    op2->args[3] = 32;
+    return dst;
+}
+
+static TCGTemp *la_mulu2_mov(TCGContext *ctx, TCGOp *op,
+                             TCGTemp *dst, TCGTemp *src)
+{
+    TCGOp *op2 = tcg_op_insert_before(ctx, op, INDEX_op_mov, TCG_TYPE_I64, 2);
+
+    op2->args[0] = temp_arg(dst);
+    op2->args[1] = temp_arg(src);
+    return dst;
+}
+
+static TCGTemp *la_mulu2_op3(TCGContext *ctx, TCGOp *op, TCGOpcode opc,
+                             TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    TCGOp *op2 = tcg_op_insert_before(ctx, op, opc, TCG_TYPE_I64, 3);
+
+    op2->args[0] = temp_arg(dst);
+    op2->args[1] = temp_arg(src1);
+    op2->args[2] = temp_arg(src2);
+    return dst;
+}
+
+static TCGTemp *la_mulu2_op3c(TCGContext *ctx, TCGOp *op, TCGOpcode opc,
+                              TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (src2->kind != TEMP_CONST && (src1->kind == TEMP_CONST || dst == src2)) {
+        TCGTemp *t = src1;
+        src1 = src2;
+        src2 = t;
+    }
+    return la_mulu2_op3(ctx, op, opc, dst, src1, src2);
+}
+
+static TCGOp *la_expand_mulu2_i64(TCGContext *s, TCGOp *op)
+{
+    TCGTemp *o0_orig = arg_temp(op->args[0]);
+    TCGTemp *o1_orig = arg_temp(op->args[1]);
+    TCGTemp *i0 = arg_temp(op->args[2]);
+    TCGTemp *i1 = arg_temp(op->args[3]);
+    TCGTemp *o0, *o1, *l0, *l1, *h0, *h1, *m0, *m1, *t0 = NULL, *t1 = NULL;
+    TCGTemp *t32 = la_const_new(TCG_TYPE_I64, 32);
+    TCGTemp *tzero = la_const_new(TCG_TYPE_I64, 0);
+    TCGOp *ret;
+
+    /*
+     * At present, the only two hosts missing some form of double-word or
+     * high-part multiply are s390x without misc-insn-ext-2 (before z14)
+     * or sparc64 without vis3 (before ultrasparc t3).
+     * Both of these have ext32u and addci.
+     */
+    tcg_debug_assert(op->opc == INDEX_op_mulu2);
+    tcg_debug_assert(TCGOP_TYPE(op) == TCG_TYPE_I64);
+    tcg_debug_assert(TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, 32));
+    tcg_debug_assert(tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0));
+
+    /*
+     * Split the two 64-bit multiplicands into unsigned halves.
+     * Via fold_multiply2, i0 must be non-constant.
+     */
+    l0 = la_mulu2_ext32u(s, op, la_temp_new(TCG_TYPE_I64), i0);
+    h0 = la_mulu2_op3(s, op, INDEX_op_shr, la_temp_new(TCG_TYPE_I64), i0, t32);
+
+    if (i1->kind == TEMP_CONST) {
+        l1 = la_const_new(TCG_TYPE_I64, extract64(i1->val, 0, 32));
+        h1 = la_const_new(TCG_TYPE_I64, extract64(i1->val, 32, 32));
+    } else {
+        l1 = la_mulu2_ext32u(s, op, la_temp_new(TCG_TYPE_I64), i1);
+        h1 = la_mulu2_op3(s, op, INDEX_op_shr,
+                          la_temp_new(TCG_TYPE_I64), i1, t32);
+    }
+
+    /*
+     * Compute partial products.
+     */
+    if (l1 == tzero) {
+        o0 = tzero;
+        m0 = tzero;
+    } else {
+        o0 = la_mulu2_op3c(s, op, INDEX_op_mul, o0_orig, l0, l1);
+        m0 = la_mulu2_op3c(s, op, INDEX_op_mul,
+                           la_temp_new(TCG_TYPE_I64), h0, l1);
+    }
+    if (h1 == tzero) {
+        m1 = tzero;
+        o1 = tzero;
+    } else {
+        m1 = la_mulu2_op3c(s, op, INDEX_op_mul,
+                           la_temp_new(TCG_TYPE_I64), l0, h1);
+        o1 = la_mulu2_op3c(s, op, INDEX_op_mul, o1_orig, h0, h1);
+    }
+
+    /*
+     * The middle partial products need shifting up by 32, producing
+     * bits within [63:32] and [95:64].
+     */
+    if (m0 != tzero) {
+        t0 = la_mulu2_op3(s, op, INDEX_op_shr,
+                          la_temp_new(TCG_TYPE_I64), m0, t32);
+        la_mulu2_op3(s, op, INDEX_op_shl, m0, m0, t32);
+        if (o0 == tzero) {
+            o0 = m0;
+            if (o1 == tzero) {
+                o1 = t0;
+            } else {
+                o1 = la_mulu2_op3c(s, op, INDEX_op_add, o0_orig, o1, t0);
+            }
+        } else {
+            o0 = la_mulu2_op3c(s, op, INDEX_op_addco, o0_orig, o0, m0);
+            o1 = la_mulu2_op3c(s, op, INDEX_op_addci, o1_orig, o1, t0);
+        }
+    }
+    if (m1 != tzero) {
+        t1 = la_mulu2_op3(s, op, INDEX_op_shr,
+                          la_temp_new(TCG_TYPE_I64), m1, t32);
+        la_mulu2_op3(s, op, INDEX_op_shl, m1, m1, t32);
+        if (o0 == tzero) {
+            o0 = m1;
+            if (o1 == tzero) {
+                o1 = t1;
+            } else {
+                o1 = la_mulu2_op3c(s, op, INDEX_op_add, o0_orig, o1, t1);
+            }
+        } else {
+            o0 = la_mulu2_op3c(s, op, INDEX_op_addco, o0_orig, o0, m1);
+            o1 = la_mulu2_op3c(s, op, INDEX_op_addci, o1_orig, o1, t1);
+        }
+    }
+
+    /* Final write-back, if necessary. */
+    if (o0 != o0_orig) {
+        la_mulu2_mov(s, op, o0_orig, o0);
+    }
+    if (o1 != o1_orig) {
+        la_mulu2_mov(s, op, o1_orig, o1);
+    }
+
+    tcg_temp_free_internal(l0);
+    tcg_temp_free_internal(l1);
+    tcg_temp_free_internal(h0);
+    tcg_temp_free_internal(h1);
+    tcg_temp_free_internal(m0);
+    tcg_temp_free_internal(m1);
+    if (t0) {
+        tcg_temp_free_internal(t0);
+    }
+    if (t1) {
+        tcg_temp_free_internal(t1);
+    }
+
+    ret = QTAILQ_PREV(op, link);
+    tcg_op_remove(s, op);
+    return ret;
+}
+
+/*
+ * Liveness analysis : update the opc_arg_life array to tell if a
+ * given input arguments is dead. Instructions updating dead
+ * temporaries are removed.
+ */
 static void __attribute__((noinline))
 liveness_pass_1(TCGContext *s)
 {
@@ -4067,10 +4268,11 @@ liveness_pass_1(TCGContext *s)
                 op->args[0] = op->args[1];
                 op->args[1] = op->args[2];
                 op->args[2] = op->args[3];
-            } else {
-                goto do_not_remove;
+            } else if (!tcg_op_supported(opc, TCGOP_TYPE(op), 0)) {
+                op = la_expand_mulu2_i64(s, op);
+                op_prev = QTAILQ_PREV(op, link);
+                opc = op->opc;
             }
-            /* Mark the single-word operation live.  */
             goto do_not_remove;
 
         case INDEX_op_addco:
-- 
2.53.0


