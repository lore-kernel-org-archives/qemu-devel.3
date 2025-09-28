Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E0BCCA468
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 16:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2uK1-00037g-NS; Sun, 28 Sep 2025 12:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uJz-00036w-29
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uJj-0005y8-J3
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-28832ad6f64so3814975ad.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759077118; x=1759681918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H3d7H8XovfFDI+ME0yUN7n1tyhLF4vt5e6dSGVMQOB0=;
 b=GPbzmJRGYkHSk00RKOO4/rxMXerjebLIf62/H0dxIq4b9MC8+Tb0DcnEBFV36cmzS9
 wzEwfli9A1ST8n5wmiIy5U2F2W79oySIBYT3+1b7+0zzwTnxFVanXa/I5Q1smbsyjoJe
 Bgcw/ySpcegDnv/ytpZyj0i5y3PKO8dwZUTrG5JFmihO/y38zB0wpIs/8ANKdje/5gRK
 MHF3qhtPmflzuIbphzi5LWFYI0U95quTavc2oCUpMpGSPITrAClBtsHzP9FRoz/sNOUt
 FGl8DcssDSKogvqj89wZfOOX/0eVSfJoFSy9ZrXUTeffgcq9ZREbxDH9KcbF0cRdyDgw
 aK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759077118; x=1759681918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H3d7H8XovfFDI+ME0yUN7n1tyhLF4vt5e6dSGVMQOB0=;
 b=BOqqa/NifWoJjfUKtQdCulOUsWNQKyfePA2p7Wdxi5kkIEiuMj8dqklWEFBPMM28KC
 7/5lR5etpFV1WB1WUm85AjgRKaUmwLHCufHPwYoNlbOCzspjHOcj2vNcviDFJgCBXge9
 wY0Cb7808A4FfK/4eMwzTldppq37fro1E3QZNoGM7WZCCoa2W65+HrNNbW0bwV7CJCZS
 /z2OJFN9eN0Fesm0dvev3PDguM5nK4E7zayte3kITXEzhyYpLqgHk3sF7H4zguxlHyGm
 EhF2Y/nblSxgSX5n2vzv1lO1bQuG3KC6o7myFEyCdEusz3HS1yertprv4xfJqeOiyW7P
 HRxA==
X-Gm-Message-State: AOJu0YxgnSIHjscuPi/lw7Vw1PrN7tUJIu2JmGjZxopuALZQ61Z89FkS
 vsd2tm0CiXSyjn+wnnyZJAAs0gwMIEYOZNmuafbv8ctlFi9STya2XWmNU84Es2/YmLbycpR/ghR
 icTDlG48=
X-Gm-Gg: ASbGncsQxAm65aHqsym0wzxvd9pJpSTI8hy75OOtryqvKqHSgO0+nW/JS+o1bQQqWwL
 DBiGTvinQ0MJt/9S/X32hZOZ43Ep9Bm6049t/m7cFeV6oNDxQiHIqZbCRKdrohughur4QVI10Q4
 p/9xXCpVeXzxf7Hb3Ef6F5LDoADJF/TIaPBax/Jb+JFpq24YwvedyDKPa+2HCiqj/CO8sBczVdv
 hMjXDsa+mGchW0xFr53AfzwxYy0oASkSW3TrQEgLp2/BUonwclhT9KJmbAjWOOtLckQgfc34BLJ
 np3KFm/siRUhre37tU6vLYtGjAXR62/jmZ6/CeHDAvFnfy08vJAExkCoRjq2KwDVA0I/Y8SHOe5
 UTXl7FHI9LFdE9FyAqdE/IBTVWCgbFG3qRFYPU9Y=
X-Google-Smtp-Source: AGHT+IHNRi0VE/2ylg1KB5sZs+2jf16X0EwpDgsC6dHyRQszvPkMNK+4+rDwExxMvTjPpYSjrEfZsA==
X-Received: by 2002:a17:903:ac4:b0:25c:76f1:b024 with SMTP id
 d9443c01a7336-27ed4a0e498mr172315075ad.25.1759077118135; 
 Sun, 28 Sep 2025 09:31:58 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6996963sm107236335ad.104.2025.09.28.09.31.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Sep 2025 09:31:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] tcg/optimize: Lower unsupported deposit during optimize
Date: Sun, 28 Sep 2025 09:31:52 -0700
Message-ID: <20250928163155.1472914-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250928163155.1472914-1-richard.henderson@linaro.org>
References: <20250928163155.1472914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

The expansions that we chose in tcg-op.c may be less than optimial.
Delay lowering until optimize, so that we have propagated constants
and have computed known zero/one masks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 194 +++++++++++++++++++++++++++++++++++++++++++------
 tcg/tcg-op.c   | 189 +++++++++++++++--------------------------------
 2 files changed, 230 insertions(+), 153 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f69702b26e..5df57049c2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1865,12 +1865,17 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 
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
@@ -1878,35 +1883,182 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
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
index ab7b409be6..abce307f26 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -884,9 +884,6 @@ void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
-    uint32_t mask;
-    TCGv_i32 t1;
-
     tcg_debug_assert(ofs < 32);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 32);
@@ -894,39 +891,9 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
 
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
@@ -940,28 +907,10 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
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
 
@@ -2523,9 +2472,6 @@ void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-    uint64_t mask;
-    TCGv_i64 t1;
-
     tcg_debug_assert(ofs < 64);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 64);
@@ -2533,55 +2479,40 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 
     if (len == 64) {
         tcg_gen_mov_i64(ret, arg2);
-        return;
-    }
-
-    if (TCG_TARGET_REG_BITS == 64) {
-        if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
-            tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-            return;
-        }
+    } else if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
+    } else if (ofs >= 32) {
+        tcg_gen_deposit_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1),
+                            TCGV_LOW(arg2), ofs - 32, len);
+        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
+    } else if (ofs + len <= 32) {
+        tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(arg1),
+                            TCGV_LOW(arg2), ofs, len);
+        tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
+    } else if (ofs == 0) {
+        tcg_gen_deposit_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1),
+                            TCGV_HIGH(arg2), 0, len - 32);
+        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg2));
     } else {
-        if (ofs >= 32) {
-            tcg_gen_deposit_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1),
-                                TCGV_LOW(arg2), ofs - 32, len);
-            tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
-            return;
-        }
-        if (ofs + len <= 32) {
-            tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(arg1),
-                                TCGV_LOW(arg2), ofs, len);
-            tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
-            return;
-        }
-    }
+        /* The 64-bit deposit is split across the 32-bit halves. */
+        unsigned lo_len = 32 - ofs;
+        unsigned hi_len = len - lo_len;
+        TCGv_i32 tl = tcg_temp_ebb_new_i32();
+        TCGv_i32 th = tcg_temp_ebb_new_i32();
 
-    t1 = tcg_temp_ebb_new_i64();
-
-    if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
-        if (ofs + len == 64) {
-            tcg_gen_shli_i64(t1, arg1, len);
-            tcg_gen_extract2_i64(ret, t1, arg2, len);
-            goto done;
+        tcg_gen_deposit_i32(tl, TCGV_LOW(arg1), TCGV_LOW(arg2), ofs, lo_len);
+        if (len <= 32) {
+            tcg_gen_shri_i32(th, TCGV_LOW(arg2), lo_len);
+        } else {
+            tcg_gen_extract2_i32(th, TCGV_LOW(arg2), TCGV_HIGH(arg2), lo_len);
         }
-        if (ofs == 0) {
-            tcg_gen_extract2_i64(ret, arg1, arg2, len);
-            tcg_gen_rotli_i64(ret, ret, len);
-            goto done;
-        }
-    }
+        tcg_gen_deposit_i32(th, TCGV_HIGH(arg1), th, 0, hi_len);
 
-    mask = (1ull << len) - 1;
-    if (ofs + len < 64) {
-        tcg_gen_andi_i64(t1, arg2, mask);
-        tcg_gen_shli_i64(t1, t1, ofs);
-    } else {
-        tcg_gen_shli_i64(t1, arg2, ofs);
+        tcg_gen_mov_i32(TCGV_LOW(ret), tl);
+        tcg_gen_mov_i32(TCGV_HIGH(ret), th);
+        tcg_temp_free_i32(tl);
+        tcg_temp_free_i32(th);
     }
-    tcg_gen_andi_i64(ret, arg1, ~(mask << ofs));
-    tcg_gen_or_i64(ret, ret, t1);
- done:
-    tcg_temp_free_i64(t1);
 }
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
@@ -2596,41 +2527,35 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_shli_i64(ret, arg, ofs);
     } else if (ofs == 0) {
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else if (TCG_TARGET_REG_BITS == 64 &&
-               TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
+    } else if (TCG_TARGET_REG_BITS == 64) {
         TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
+    } else if (ofs >= 32) {
+        tcg_gen_deposit_z_i32(TCGV_HIGH(ret), TCGV_LOW(arg), ofs - 32, len);
+        tcg_gen_movi_i32(TCGV_LOW(ret), 0);
+    } else if (ofs + len <= 32) {
+        tcg_gen_deposit_z_i32(TCGV_LOW(ret), TCGV_LOW(arg), ofs, len);
+        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    } else if (ofs == 0) {
+        tcg_gen_deposit_z_i32(TCGV_HIGH(ret), TCGV_HIGH(arg), 0, len - 32);
+        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
     } else {
-        if (TCG_TARGET_REG_BITS == 32) {
-            if (ofs >= 32) {
-                tcg_gen_deposit_z_i32(TCGV_HIGH(ret), TCGV_LOW(arg),
-                                      ofs - 32, len);
-                tcg_gen_movi_i32(TCGV_LOW(ret), 0);
-                return;
-            }
-            if (ofs + len <= 32) {
-                tcg_gen_deposit_z_i32(TCGV_LOW(ret), TCGV_LOW(arg), ofs, len);
-                tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-                return;
-            }
+        /* The 64-bit deposit is split across the 32-bit halves. */
+        unsigned lo_len = 32 - ofs;
+        unsigned hi_len = len - lo_len;
+        TCGv_i32 tl = tcg_temp_ebb_new_i32();
+        TCGv_i32 th = TCGV_HIGH(ret);
+
+        tcg_gen_shli_i32(tl, TCGV_LOW(arg), ofs);
+        if (len <= 32) {
+            tcg_gen_extract_i32(th, TCGV_LOW(arg), lo_len, hi_len);
+        } else {
+            tcg_gen_extract2_i32(th, TCGV_LOW(arg), TCGV_HIGH(arg), lo_len);
+            tcg_gen_extract_i32(th, th, 0, hi_len);
         }
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
+
+        tcg_gen_mov_i32(TCGV_LOW(ret), tl);
+        tcg_temp_free_i32(tl);
     }
 }
 
-- 
2.43.0


