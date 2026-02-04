Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1EEE8B39D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVO5-0000WB-LT; Wed, 04 Feb 2026 00:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVO1-0000Ve-56
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:09 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVNy-0003Gm-VG
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:08 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a7b23dd036so31239355ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770182705; x=1770787505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAkc222DnVlZAYEVs59TD8Lx74BTiYYPg03o07EYwlg=;
 b=vccjlMeAtLwVZHPl6vxalGSYV9XVAck6jWkX0Bp31lZTk79h3Ow/c/LXa8Dq5U8lzx
 o09VE8CROgYZ3EfagQMEeYlbmnTwT2yyrnLjER4w3iQX2f0dRyim8wfRcxPyzU0GGiZg
 YkWF+kGT2IAvZQfGQn6FxbtuGp7oRYrRbrI7YaoJs9Ku5Z/gpYGQie1IW0T+EYwGEAlp
 NJVeaPKrbWz1P/Xocpb806+6Qi3Ekp4pkuncmHEI8tOTFJuTiQo/Qu9tDq1/G6epohBb
 2wcJzkdZZkQK6xYk2Iq51pTNVksrST70CmEtl+WdrXDHHzNiUtzqeJcF/bndPPcL6t1X
 B6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182705; x=1770787505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QAkc222DnVlZAYEVs59TD8Lx74BTiYYPg03o07EYwlg=;
 b=wdO211GWXXq+/t+e+39FN+a6Y+l0TZZZ+jUbIjC8s6FnIlskYlGUlG5Vgi8RvjIdyi
 RlwI0DBwJYyvvvCy6MaqEq/408izhOqY5bxbqUu7v6U0QqUGzRshGE1RQ7Ad+U1/IU30
 5Rq1Ixp/bGLHDg6fMtKsARDHfYBSwC/RqVs0UmHJKzhMvxND0qrDk4S8j2qvg7ppC1N8
 gqz+UoaUAGORwt14C2cJ+Ri8VgFHMJ18l7f0W/9KLmLf240ZB3lrSpCUxwtXLYKQX8XD
 xpdp9bD+CpSCPTD6RI6TmE4ecv7zoWqeNDepPqAHcaDKn/Zg+Il739hTL+YiJuQbv82n
 Wvfw==
X-Gm-Message-State: AOJu0YwVJPRS8gKAbT+HdI4Lto2zzO5frCoMUpxCJ+DTIRKOxGrAHsDd
 9OL7oRHcNFf/rAeTdvDHPpEN4aKRndAjYsAWgX98+LDIOl7QnoxYc76iB5qnR5MUemmAJ0kr2cp
 ZIXlaYdM=
X-Gm-Gg: AZuq6aK9sXNtHOgh1MBBB2QEPC1kHyZjBu7hlNuvzxgwUucd6bjetqfeXVywRbg+KqJ
 cU+cglqvHbl0i76Fg5cJdWSi39JcaJFHH0XzMKCJ47Yh6MTc13GjFHOAZqwKsABN9W0PfAplUBp
 ywE5X73OCTYlJsVfMpa+i0xAAOTDzC42bLVoqEiFfPVNynZxAPVaLgLluH6z0T9TwxpWO6a3Eby
 ot7JPUusQRXFpZNisu/gC3ZfjjuhAx5+XLJ/1KVhAqlev1dNHO9wfnwTWx2fQPWFNnirhWtKiyf
 w08xOYYbckGdJ4Fjpyr+c18HNhj5XBAS+yjAca2/J0eEJ6kFfzbnzvg2buzo5QAWF347YhBTBhe
 f8UeOx+Cg+b7uX+ZFylD4+X/5g6spKsKFlCGe8/M0OQmmeYvcdR+ADLc/wXnYRcIXqcrhtZT01H
 4+b1feqitaWx8lw8Lp5P0UBtoq/Ffc9IoXKDjP7XPQMyEzfiWWgUpNIWiC3s4=
X-Received: by 2002:a17:903:191:b0:2a9:57b:2c9f with SMTP id
 d9443c01a7336-2a93413512cmr18167645ad.58.1770182704968; 
 Tue, 03 Feb 2026 21:25:04 -0800 (PST)
Received: from stoup.. (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933965c3esm10062015ad.67.2026.02.03.21.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:25:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 1/6] tcg/optimize: Lower unsupported deposit during optimize
Date: Wed,  4 Feb 2026 15:24:51 +1000
Message-ID: <20260204052456.970605-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204052456.970605-1-richard.henderson@linaro.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
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

The expansions that we chose in tcg-op.c may be less than optimial.
Delay lowering until optimize, so that we have propagated constants
and have computed known zero/one masks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 194 +++++++++++++++++++++++++++++++++++++++++++------
 tcg/tcg-op.c   | 113 ++--------------------------
 2 files changed, 178 insertions(+), 129 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 801a0a2c68..890c8068fb 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1652,12 +1652,17 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
 {
-    TempOptInfo *t1 = arg_info(op->args[1]);
-    TempOptInfo *t2 = arg_info(op->args[2]);
+    TCGArg ret = op->args[0];
+    TCGArg arg1 = op->args[1];
+    TCGArg arg2 = op->args[2];
     int ofs = op->args[3];
     int len = op->args[4];
-    int width = 8 * tcg_type_size(ctx->type);
-    uint64_t z_mask, o_mask, s_mask;
+    TempOptInfo *t1 = arg_info(arg1);
+    TempOptInfo *t2 = arg_info(arg2);
+    int width;
+    uint64_t z_mask, o_mask, s_mask, type_mask, len_mask;
+    TCGOp *op2;
+    bool valid;
 
     if (ti_is_const(t1) && ti_is_const(t2)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
@@ -1665,35 +1670,182 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
                                           ti_const_val(t2)));
     }
 
-    /* Inserting a value into zero at offset 0. */
-    if (ti_is_const_val(t1, 0) && ofs == 0) {
-        uint64_t mask = MAKE_64BIT_MASK(0, len);
+    width = 8 * tcg_type_size(ctx->type);
+    type_mask = MAKE_64BIT_MASK(0, width);
+    len_mask = MAKE_64BIT_MASK(0, len);
 
+    /* Inserting all-zero into a value. */
+    if ((t2->z_mask & len_mask) == 0) {
         op->opc = INDEX_op_and;
-        op->args[1] = op->args[2];
-        op->args[2] = arg_new_constant(ctx, mask);
+        op->args[2] = arg_new_constant(ctx, ~(len_mask << ofs));
         return fold_and(ctx, op);
     }
 
-    /* Inserting zero into a value. */
-    if (ti_is_const_val(t2, 0)) {
-        uint64_t mask = deposit64(-1, ofs, len, 0);
-
-        op->opc = INDEX_op_and;
-        op->args[2] = arg_new_constant(ctx, mask);
-        return fold_and(ctx, op);
+    /* Inserting all-one into a value. */
+    if ((t2->o_mask & len_mask) == len_mask) {
+        op->opc = INDEX_op_or;
+        op->args[2] = arg_new_constant(ctx, len_mask << ofs);
+        return fold_or(ctx, op);
     }
 
-    /* The s_mask from the top portion of the deposit is still valid. */
-    if (ofs + len == width) {
-        s_mask = t2->s_mask << ofs;
-    } else {
-        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
+    valid = TCG_TARGET_deposit_valid(ctx->type, ofs, len);
+
+    /* Lower invalid deposit of constant as AND + OR. */
+    if (!valid && ti_is_const(t2)) {
+        uint64_t ins_val = (ti_const_val(t2) & len_mask) << ofs;
+
+        op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
+        op2->args[0] = ret;
+        op2->args[1] = arg1;
+        op2->args[2] = arg_new_constant(ctx, ~(len_mask << ofs));
+        fold_and(ctx, op2);
+
+        op->opc = INDEX_op_or;
+        op->args[1] = ret;
+        op->args[2] = arg_new_constant(ctx, ins_val);
+        return fold_or(ctx, op);
     }
 
+    /*
+     * Compute result masks before calling other fold_* subroutines
+     * which could modify the masks of our inputs.
+     */
     z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
     o_mask = deposit64(t1->o_mask, ofs, len, t2->o_mask);
+    if (ofs + len < width) {
+        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
+    } else {
+        s_mask = t2->s_mask << ofs;
+    }
 
+    /* Inserting a value into zero. */
+    if (ti_is_const_val(t1, 0)) {
+        uint64_t need_mask;
+
+        /* Always lower deposit into zero at 0 as AND. */
+        if (ofs == 0) {
+            op->opc = INDEX_op_and;
+            op->args[1] = arg2;
+            op->args[2] = arg_new_constant(ctx, len_mask);
+            return fold_and(ctx, op);
+        }
+
+        /*
+         * If the portion of the value outside len that remains after
+         * shifting is zero, we can elide the mask and just shift.
+         */
+        need_mask = t2->z_mask & ~len_mask;
+        need_mask = (need_mask << ofs) & type_mask;
+        if (!need_mask) {
+            op->opc = INDEX_op_shl;
+            op->args[1] = arg2;
+            op->args[2] = arg_new_constant(ctx, ofs);
+            goto done;
+        }
+
+        /* Lower invalid deposit into zero as AND + SHL or SHL + AND. */
+        if (!valid) {
+            if (TCG_TARGET_extract_valid(ctx->type, 0, ofs + len) &&
+                !TCG_TARGET_extract_valid(ctx->type, 0, len)) {
+                op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = arg_new_constant(ctx, ofs);
+
+                op->opc = INDEX_op_extract;
+                op->args[1] = ret;
+                op->args[2] = 0;
+                op->args[3] = ofs + len;
+                goto done;
+            }
+
+            op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
+            op2->args[0] = ret;
+            op2->args[1] = arg2;
+            op2->args[2] = arg_new_constant(ctx, len_mask);
+            fold_and(ctx, op2);
+
+            op->opc = INDEX_op_shl;
+            op->args[1] = ret;
+            op->args[2] = arg_new_constant(ctx, ofs);
+            goto done;
+        }
+    }
+
+    /* After special cases, lower invalid deposit. */
+    if (!valid) {
+        TCGArg tmp;
+        bool has_ext2 = tcg_op_supported(INDEX_op_extract2, ctx->type, 0);
+        bool has_rotl = tcg_op_supported(INDEX_op_rotl, ctx->type, 0);
+
+        /*
+         * ret = arg2:arg1 >> len
+         * ret = rotl(ret, len)
+         */
+        if (ofs == 0 && has_ext2 && has_rotl) {
+            op2 = opt_insert_before(ctx, op, INDEX_op_extract2, 4);
+            op2->args[0] = ret;
+            op2->args[1] = arg1;
+            op2->args[2] = arg2;
+            op2->args[3] = len;
+
+            op->opc = INDEX_op_rotl;
+            op->args[1] = ret;
+            op->args[2] = arg_new_constant(ctx, len);
+            goto done;
+        }
+
+        /*
+         * tmp = arg1 << len
+         * ret = arg2:tmp >> len
+         */
+        if (ofs + len == width && has_ext2) {
+            tmp = ret == arg2 ? arg_new_temp(ctx) : ret;
+
+            op2 = opt_insert_before(ctx, op, INDEX_op_shl, 4);
+            op2->args[0] = tmp;
+            op2->args[1] = arg1;
+            op2->args[2] = arg_new_constant(ctx, len);
+
+            op->opc = INDEX_op_extract2;
+            op->args[0] = ret;
+            op->args[1] = tmp;
+            op->args[2] = arg2;
+            op->args[3] = len;
+            goto done;
+        }
+
+        /*
+         * tmp = arg2 & mask
+         * ret = arg1 & ~(mask << ofs)
+         * tmp = tmp << ofs
+         * ret = ret | tmp
+         */
+        tmp = arg_new_temp(ctx);
+
+        op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
+        op2->args[0] = tmp;
+        op2->args[1] = arg2;
+        op2->args[2] = arg_new_constant(ctx, len_mask);
+        fold_and(ctx, op2);
+
+        op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
+        op2->args[0] = tmp;
+        op2->args[1] = tmp;
+        op2->args[2] = arg_new_constant(ctx, ofs);
+
+        op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
+        op2->args[0] = ret;
+        op2->args[1] = arg1;
+        op2->args[2] = arg_new_constant(ctx, ~(len_mask << ofs));
+        fold_and(ctx, op2);
+
+        op->opc = INDEX_op_or;
+        op->args[1] = ret;
+        op->args[2] = tmp;
+    }
+
+ done:
     return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8d67acc4fc..96f72ba381 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -876,9 +876,6 @@ void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
-    uint32_t mask;
-    TCGv_i32 t1;
-
     tcg_debug_assert(ofs < 32);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 32);
@@ -886,39 +883,9 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
 
     if (len == 32) {
         tcg_gen_mov_i32(ret, arg2);
-        return;
-    }
-    if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-        return;
-    }
-
-    t1 = tcg_temp_ebb_new_i32();
-
-    if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
-        if (ofs + len == 32) {
-            tcg_gen_shli_i32(t1, arg1, len);
-            tcg_gen_extract2_i32(ret, t1, arg2, len);
-            goto done;
-        }
-        if (ofs == 0) {
-            tcg_gen_extract2_i32(ret, arg1, arg2, len);
-            tcg_gen_rotli_i32(ret, ret, len);
-            goto done;
-        }
-    }
-
-    mask = (1u << len) - 1;
-    if (ofs + len < 32) {
-        tcg_gen_andi_i32(t1, arg2, mask);
-        tcg_gen_shli_i32(t1, t1, ofs);
     } else {
-        tcg_gen_shli_i32(t1, arg2, ofs);
+        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
     }
-    tcg_gen_andi_i32(ret, arg1, ~(mask << ofs));
-    tcg_gen_or_i32(ret, ret, t1);
- done:
-    tcg_temp_free_i32(t1);
 }
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -932,28 +899,10 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     if (ofs + len == 32) {
         tcg_gen_shli_i32(ret, arg, ofs);
     } else if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-    } else if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
+        tcg_gen_extract_i32(ret, arg, 0, len);
+    } else {
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5ii_i32(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    } else {
-        /*
-         * To help two-operand hosts we prefer to zero-extend first,
-         * which allows ARG to stay live.
-         */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
-            tcg_gen_extract_i32(ret, arg, 0, len);
-            tcg_gen_shli_i32(ret, ret, ofs);
-            return;
-        }
-        /* Otherwise prefer zero-extension over AND for code size.  */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-            tcg_gen_shli_i32(ret, arg, ofs);
-            tcg_gen_extract_i32(ret, ret, 0, ofs + len);
-            return;
-        }
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-        tcg_gen_shli_i32(ret, ret, ofs);
     }
 }
 
@@ -2148,9 +2097,6 @@ void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-    uint64_t mask;
-    TCGv_i64 t1;
-
     tcg_debug_assert(ofs < 64);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 64);
@@ -2158,40 +2104,9 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 
     if (len == 64) {
         tcg_gen_mov_i64(ret, arg2);
-        return;
-    }
-
-    if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-        return;
-    }
-
-    t1 = tcg_temp_ebb_new_i64();
-
-    if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
-        if (ofs + len == 64) {
-            tcg_gen_shli_i64(t1, arg1, len);
-            tcg_gen_extract2_i64(ret, t1, arg2, len);
-            goto done;
-        }
-        if (ofs == 0) {
-            tcg_gen_extract2_i64(ret, arg1, arg2, len);
-            tcg_gen_rotli_i64(ret, ret, len);
-            goto done;
-        }
-    }
-
-    mask = (1ull << len) - 1;
-    if (ofs + len < 64) {
-        tcg_gen_andi_i64(t1, arg2, mask);
-        tcg_gen_shli_i64(t1, t1, ofs);
     } else {
-        tcg_gen_shli_i64(t1, arg2, ofs);
+        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
     }
-    tcg_gen_andi_i64(ret, arg1, ~(mask << ofs));
-    tcg_gen_or_i64(ret, ret, t1);
- done:
-    tcg_temp_free_i64(t1);
 }
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
@@ -2206,27 +2121,9 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_shli_i64(ret, arg, ofs);
     } else if (ofs == 0) {
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
+    } else {
         TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    } else {
-        /*
-         * To help two-operand hosts we prefer to zero-extend first,
-         * which allows ARG to stay live.
-         */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
-            tcg_gen_extract_i64(ret, arg, 0, len);
-            tcg_gen_shli_i64(ret, ret, ofs);
-            return;
-        }
-        /* Otherwise prefer zero-extension over AND for code size.  */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-            tcg_gen_shli_i64(ret, arg, ofs);
-            tcg_gen_extract_i64(ret, ret, 0, ofs + len);
-            return;
-        }
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-        tcg_gen_shli_i64(ret, ret, ofs);
     }
 }
 
-- 
2.43.0


