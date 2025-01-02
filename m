Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94E8E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPf6-00017I-Uz; Thu, 02 Jan 2025 13:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPef-0007PA-EW
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:47 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPea-0006F2-Q0
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:45 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21619108a6bso147178095ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841439; x=1736446239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1yYd9uZdhd5WJWMblGsXTmk2eVnpljaZvYq26OLV+BA=;
 b=AQBpZBRlQ5uH2gHoTYYnxQ9OVCraseoaTfgLPzr+/hGNn1HwE+lJCI0gjcDRZC0KqB
 3C6X3K3HUga4JeKwnaMONSxKgkeMFVX+fNTHuz06gB9afiXSauHGQXrTH8HpEsNCiYYM
 dWSN4qXeBiiQaMalN8H7cB0LqTUWxn3fuFPpn0cgn4SlkNZ/QC1qwJqXZwZhQaK8cJOJ
 OcV7MDhjf/qkWwQE58JeR0ZahWjI9Xx6pywXKfSo606mbkMxg04yguEFx6oJMQxBN97M
 i/rRBVOyZ5p9Tyy5WUUEoNIZWKXs6hjDJMI2jM4GAA0TshIeBWI3sbBBYEf55TAQtWJf
 8jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841439; x=1736446239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yYd9uZdhd5WJWMblGsXTmk2eVnpljaZvYq26OLV+BA=;
 b=UIxhu88Km/bXR6lW2JjqfAuTA8VKJU3potweDzwmi1CC7xi91dCWQ4hYnHoyUE23FL
 LXeAlO840xTo4qIxcEf6ko4SMC0lDfZDO4SgtIMbXJ5ZPXNG1PhGSV0IF+oz8M2OdwDS
 wt1WdI6XIYmNFSFguNoCq9Xz1bsPh6JpcbYeS7X1x6kpNCxCtMbylALkwBdWlk6XyaXu
 wWgRDdvKx8Wwm6NNYARLtOIXWJ4aCm31VcVhzoFuHN6UXJoySmhhJc0BO95wvlSflo7G
 y3gjGq2ARS97Lpqda3K+/fQxJprwFJxv3WC3mNYMaRJm7oO4sTT0fFlNkfy7CTsS9Go4
 /mPw==
X-Gm-Message-State: AOJu0YxwPVJj+tPp1litFdYmtwCHbpyr/mYGhTUOEAxIibQ4mad0OYjY
 ji3knYPbDkdwvVokKuyEaQOCJIJYgC35Uz8XmM/iLOg8IKxBXzA7nPpopRzsHAmGFVRFCzce97E
 2
X-Gm-Gg: ASbGncum4ojBsqJ/xvJlKM5vBWaSdrNHA4x+nJzm48+QZwbVV1xeHF49siVBSGMP0w9
 sgHW6w9au7lxk/qSxfajcZEFAa0C/7k1Y0us3KepWsalpJdLqqhwrTavVMux7wHQ/kDcTYNnARo
 JAuOmzK224wwgZDaJ5p9CRZPsDMjO7TZwdqJNBbK8h3qTxPUhyzid2gQMA3c43qi+iSiqUYj5Au
 amPdYWwSvX4IDKrb/cmrKLH8DkPW9sJvj2W3LrbqsLrR5z00WvNnXwIQFTTug==
X-Google-Smtp-Source: AGHT+IFecLW1ITIYmgg7h7wlU1evQ4kob6jdX80t+WqsmFsvoucgBHZUrfKQZdD5h+C7bLg33LWmZQ==
X-Received: by 2002:a05:6a20:9f0f:b0:1e6:8f30:df53 with SMTP id
 adf61e73a8af0-1e68f30fa59mr70579637.16.1735841438193; 
 Thu, 02 Jan 2025 10:10:38 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 55/73] tcg: Merge INDEX_op_{ld,st}*_{i32_i64}
Date: Thu,  2 Jan 2025 10:06:35 -0800
Message-ID: <20250102180654.1420056-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
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

Add a 4th argument containing a MemOp operand which
specifies the memory operation within the type.
This mirrors what we already to for qemu_{ld,st},
except that alignment, endianness, and atomicity are
not supported.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  23 +----
 tcg/optimize.c                   | 168 ++++++++++---------------------
 tcg/tcg-op-vec.c                 |   6 +-
 tcg/tcg-op.c                     |  54 +++++-----
 tcg/tcg.c                        |  54 ++++++----
 tcg/tci.c                        |  38 +++----
 tcg/aarch64/tcg-target.c.inc     | 103 +++++++++----------
 tcg/arm/tcg-target.c.inc         |  59 ++++++-----
 tcg/i386/tcg-target.c.inc        | 150 +++++++++++++--------------
 tcg/loongarch64/tcg-target.c.inc |  94 ++++++++---------
 tcg/mips/tcg-target.c.inc        |  95 ++++++++---------
 tcg/ppc/tcg-target.c.inc         |  95 ++++++++---------
 tcg/riscv/tcg-target.c.inc       |  94 ++++++++---------
 tcg/s390x/tcg-target.c.inc       | 120 ++++++++++------------
 tcg/sparc64/tcg-target.c.inc     |  93 +++++++++--------
 tcg/tci/tcg-target-opc.h.inc     |   7 ++
 tcg/tci/tcg-target.c.inc         |  74 ++++++++------
 17 files changed, 620 insertions(+), 707 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index eb64012b62..efe2db5343 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -42,14 +42,8 @@ DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
 DEF(movcond_i32, 1, 4, 1, 0)
 /* load/store */
-DEF(ld8u_i32, 1, 1, 1, 0)
-DEF(ld8s_i32, 1, 1, 1, 0)
-DEF(ld16u_i32, 1, 1, 1, 0)
-DEF(ld16s_i32, 1, 1, 1, 0)
-DEF(ld_i32, 1, 1, 1, 0)
-DEF(st8_i32, 0, 2, 1, 0)
-DEF(st16_i32, 0, 2, 1, 0)
-DEF(st_i32, 0, 2, 1, 0)
+DEF(ld_i32, 1, 1, 2, 0)
+DEF(st_i32, 0, 2, 2, 0)
 /* arith */
 DEF(add_i32, 1, 2, 0, 0)
 DEF(sub_i32, 1, 2, 0, 0)
@@ -103,17 +97,8 @@ DEF(setcond_i64, 1, 2, 1, TCG_OPF_64BIT)
 DEF(negsetcond_i64, 1, 2, 1, TCG_OPF_64BIT)
 DEF(movcond_i64, 1, 4, 1, TCG_OPF_64BIT)
 /* load/store */
-DEF(ld8u_i64, 1, 1, 1, TCG_OPF_64BIT)
-DEF(ld8s_i64, 1, 1, 1, TCG_OPF_64BIT)
-DEF(ld16u_i64, 1, 1, 1, TCG_OPF_64BIT)
-DEF(ld16s_i64, 1, 1, 1, TCG_OPF_64BIT)
-DEF(ld32u_i64, 1, 1, 1, TCG_OPF_64BIT)
-DEF(ld32s_i64, 1, 1, 1, TCG_OPF_64BIT)
-DEF(ld_i64, 1, 1, 1, TCG_OPF_64BIT)
-DEF(st8_i64, 0, 2, 1, TCG_OPF_64BIT)
-DEF(st16_i64, 0, 2, 1, TCG_OPF_64BIT)
-DEF(st32_i64, 0, 2, 1, TCG_OPF_64BIT)
-DEF(st_i64, 0, 2, 1, TCG_OPF_64BIT)
+DEF(ld_i64, 1, 1, 2, TCG_OPF_64BIT)
+DEF(st_i64, 0, 2, 2, TCG_OPF_64BIT)
 /* arith */
 DEF(add_i64, 1, 2, 0, TCG_OPF_64BIT)
 DEF(sub_i64, 1, 2, 0, TCG_OPF_64BIT)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 32173ecb23..c55ad116bc 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2654,119 +2654,70 @@ static bool fold_sub2(OptContext *ctx, TCGOp *op)
 static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask = -1, s_mask = 0;
+    MemOp memop = op->args[3];
+    unsigned size = memop_size(memop);
 
-    /* We can't do any folding with a load, but we can record bits. */
-    switch (op->opc) {
-    CASE_OP_32_64(ld8s):
-        s_mask = INT8_MIN;
-        break;
-    CASE_OP_32_64(ld8u):
-        z_mask = MAKE_64BIT_MASK(0, 8);
-        break;
-    CASE_OP_32_64(ld16s):
-        s_mask = INT16_MIN;
-        break;
-    CASE_OP_32_64(ld16u):
-        z_mask = MAKE_64BIT_MASK(0, 16);
-        break;
-    case INDEX_op_ld32s_i64:
-        s_mask = INT32_MIN;
-        break;
-    case INDEX_op_ld32u_i64:
-        z_mask = MAKE_64BIT_MASK(0, 32);
-        break;
-    default:
-        g_assert_not_reached();
+    if (size == tcg_type_size(ctx->type)) {
+        TCGTemp *dst, *src;
+        intptr_t ofs;
+
+        if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
+            return finish_folding(ctx, op);
+        }
+
+        ofs = op->args[2];
+        dst = arg_temp(op->args[0]);
+        src = find_mem_copy_for(ctx, op->type, ofs);
+        if (src && src->base_type == op->type) {
+            return tcg_opt_gen_mov(ctx, op, temp_arg(dst), temp_arg(src));
+        }
+
+        reset_ts(ctx, dst);
+        record_mem_copy(ctx, op->type, dst, ofs, ofs + size - 1);
+        return true;
+    }
+
+    if (memop & MO_SIGN) {
+        s_mask = -1ull << (size * 8 - 1);
+    } else {
+        z_mask = MAKE_64BIT_MASK(0, size * 8);
     }
     return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
-static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
-{
-    TCGTemp *dst, *src;
-    intptr_t ofs;
-    TCGType type;
-
-    if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
-        return finish_folding(ctx, op);
-    }
-
-    type = ctx->type;
-    ofs = op->args[2];
-    dst = arg_temp(op->args[0]);
-    src = find_mem_copy_for(ctx, type, ofs);
-    if (src && src->base_type == type) {
-        return tcg_opt_gen_mov(ctx, op, temp_arg(dst), temp_arg(src));
-    }
-
-    reset_ts(ctx, dst);
-    record_mem_copy(ctx, type, dst, ofs, ofs + tcg_type_size(type) - 1);
-    return true;
-}
-
 static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
 {
     intptr_t ofs = op->args[2];
-    intptr_t lm1;
+    MemOp memop = op->args[3];
+    unsigned size = memop_size(memop);
+    intptr_t last = ofs + size - 1;
 
-    if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
-        remove_mem_copy_all(ctx);
+    if (size == tcg_type_size(ctx->type)) {
+        TCGTemp *src = arg_temp(op->args[0]);
+
+        if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
+            remove_mem_copy_all(ctx);
+            return true;
+        }
+
+        /*
+         * Eliminate duplicate stores of a constant.
+         * This happens frequently when the target ISA zero-extends.
+         */
+        if (ts_is_const(src)) {
+            TCGTemp *prev = find_mem_copy_for(ctx, op->type, ofs);
+            if (src == prev) {
+                tcg_op_remove(ctx->tcg, op);
+                return true;
+            }
+        }
+
+        remove_mem_copy_in(ctx, ofs, last);
+        record_mem_copy(ctx, op->type, src, ofs, last);
         return true;
     }
 
-    switch (op->opc) {
-    CASE_OP_32_64(st8):
-        lm1 = 0;
-        break;
-    CASE_OP_32_64(st16):
-        lm1 = 1;
-        break;
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i32:
-        lm1 = 3;
-        break;
-    case INDEX_op_st_i64:
-        lm1 = 7;
-        break;
-    case INDEX_op_st_vec:
-        lm1 = tcg_type_size(ctx->type) - 1;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    remove_mem_copy_in(ctx, ofs, ofs + lm1);
-    return true;
-}
-
-static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
-{
-    TCGTemp *src;
-    intptr_t ofs, last;
-    TCGType type;
-
-    if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
-        return fold_tcg_st(ctx, op);
-    }
-
-    src = arg_temp(op->args[0]);
-    ofs = op->args[2];
-    type = ctx->type;
-
-    /*
-     * Eliminate duplicate stores of a constant.
-     * This happens frequently when the target ISA zero-extends.
-     */
-    if (ts_is_const(src)) {
-        TCGTemp *prev = find_mem_copy_for(ctx, type, ofs);
-        if (src == prev) {
-            tcg_op_remove(ctx->tcg, op);
-            return true;
-        }
-    }
-
-    last = ofs + tcg_type_size(type) - 1;
     remove_mem_copy_in(ctx, ofs, last);
-    record_mem_copy(ctx, type, src, ofs, last);
     return true;
 }
 
@@ -2900,28 +2851,15 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_extrh_i64_i32:
             done = fold_extu(&ctx, op);
             break;
-        CASE_OP_32_64(ld8s):
-        CASE_OP_32_64(ld8u):
-        CASE_OP_32_64(ld16s):
-        CASE_OP_32_64(ld16u):
-        case INDEX_op_ld32s_i64:
-        case INDEX_op_ld32u_i64:
-            done = fold_tcg_ld(&ctx, op);
-            break;
         case INDEX_op_ld_i32:
         case INDEX_op_ld_i64:
         case INDEX_op_ld_vec:
-            done = fold_tcg_ld_memcopy(&ctx, op);
-            break;
-        CASE_OP_32_64(st8):
-        CASE_OP_32_64(st16):
-        case INDEX_op_st32_i64:
-            done = fold_tcg_st(&ctx, op);
+            done = fold_tcg_ld(&ctx, op);
             break;
         case INDEX_op_st_i32:
         case INDEX_op_st_i64:
         case INDEX_op_st_vec:
-            done = fold_tcg_st_memcopy(&ctx, op);
+            done = fold_tcg_st(&ctx, op);
             break;
         case INDEX_op_mb:
             done = fold_mb(&ctx, op);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 26652bb88c..879a2441f0 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -267,8 +267,9 @@ static void vec_gen_ldst(TCGOpcode opc, TCGv_vec r, TCGv_ptr b, TCGArg o)
     TCGArg bi = tcgv_ptr_arg(b);
     TCGTemp *rt = arg_temp(ri);
     TCGType type = rt->base_type;
+    MemOp memop = (type - TCG_TYPE_V64) + MO_64;
 
-    vec_gen_3(opc, type, 0, ri, bi, o);
+    vec_gen_4(opc, type, 0, ri, bi, o, memop);
 }
 
 void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr b, TCGArg o)
@@ -287,10 +288,11 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr b, TCGArg o, TCGType low_type)
     TCGArg bi = tcgv_ptr_arg(b);
     TCGTemp *rt = arg_temp(ri);
     TCGType type = rt->base_type;
+    MemOp memop = (low_type - TCG_TYPE_V64) + MO_64;
 
     tcg_debug_assert(low_type >= TCG_TYPE_V64);
     tcg_debug_assert(low_type <= type);
-    vec_gen_3(INDEX_op_st_vec, low_type, 0, ri, bi, o);
+    vec_gen_4(INDEX_op_st_vec, low_type, 0, ri, bi, o, memop);
 }
 
 void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2da74ea134..92d8678211 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -159,18 +159,18 @@ static void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
     tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
 }
 
-static void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
-                                    TCGv_ptr base, TCGArg offset)
+static void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val, TCGv_ptr base,
+                                    TCGArg offset, MemOp memop)
 {
-    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(val),
-                tcgv_ptr_arg(base), offset);
+    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(val),
+                tcgv_ptr_arg(base), offset, memop);
 }
 
-static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
-                                    TCGv_ptr base, TCGArg offset)
+static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val, TCGv_ptr base,
+                                    TCGArg offset, MemOp memop)
 {
-    tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(val),
-                tcgv_ptr_arg(base), offset);
+    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(val),
+                tcgv_ptr_arg(base), offset, memop);
 }
 
 static void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
@@ -1352,42 +1352,42 @@ void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld8u_i32, ret, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset, MO_UB);
 }
 
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld8s_i32, ret, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset, MO_SB);
 }
 
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld16u_i32, ret, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset, MO_UW);
 }
 
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld16s_i32, ret, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset, MO_SW);
 }
 
 void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_ld_i32, ret, arg2, offset, MO_32);
 }
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_st8_i32, arg1, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_st_i32, arg1, arg2, offset, MO_8);
 }
 
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_st16_i32, arg1, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_st_i32, arg1, arg2, offset, MO_16);
 }
 
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    tcg_gen_ldst_op_i32(INDEX_op_st_i32, arg1, arg2, offset);
+    tcg_gen_ldst_op_i32(INDEX_op_st_i32, arg1, arg2, offset, MO_32);
 }
 
 
@@ -1436,7 +1436,7 @@ void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld8u_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_UB);
     } else {
         tcg_gen_ld8u_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
@@ -1446,7 +1446,7 @@ void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld8s_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_SB);
     } else {
         tcg_gen_ld8s_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
@@ -1456,7 +1456,7 @@ void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld16u_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_UW);
     } else {
         tcg_gen_ld16u_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
@@ -1466,7 +1466,7 @@ void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld16s_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_SW);
     } else {
         tcg_gen_ld16s_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
@@ -1476,7 +1476,7 @@ void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld32u_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_UL);
     } else {
         tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
@@ -1486,7 +1486,7 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld32s_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_SL);
     } else {
         tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
@@ -1500,7 +1500,7 @@ void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
      * they cannot be the same temporary -- no chance of overlap.
      */
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_ld_i64, ret, arg2, offset, MO_64);
     } else if (HOST_BIG_ENDIAN) {
         tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset);
         tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset + 4);
@@ -1513,7 +1513,7 @@ void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st8_i64, arg1, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset, MO_8);
     } else {
         tcg_gen_st8_i32(TCGV_LOW(arg1), arg2, offset);
     }
@@ -1522,7 +1522,7 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st16_i64, arg1, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset, MO_16);
     } else {
         tcg_gen_st16_i32(TCGV_LOW(arg1), arg2, offset);
     }
@@ -1531,7 +1531,7 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st32_i64, arg1, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset, MO_32);
     } else {
         tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
     }
@@ -1540,7 +1540,7 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset);
+        tcg_gen_ldst_op_i64(INDEX_op_st_i64, arg1, arg2, offset, MO_64);
     } else if (HOST_BIG_ENDIAN) {
         tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset);
         tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset + 4);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index fb8b1f2a2d..ba01e0a580 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2173,13 +2173,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_setcond_i32:
     case INDEX_op_brcond_i32:
     case INDEX_op_movcond_i32:
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
     case INDEX_op_add_i32:
     case INDEX_op_sub_i32:
@@ -2254,16 +2248,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_setcond_i64:
     case INDEX_op_brcond_i64:
     case INDEX_op_movcond_i64:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
     case INDEX_op_add_i64:
     case INDEX_op_sub_i64:
@@ -2684,6 +2669,17 @@ static const char * const ldst_name[(MO_BSWAP | MO_SSIZE) + 1] =
     [MO_128 + MO_LE] = "leo",
 };
 
+static const char * const ldst_noend_name[MO_SSIZE + 1] = {
+    [MO_UB] = "ub",
+    [MO_SB] = "sb",
+    [MO_UW] = "uw",
+    [MO_SW] = "sw",
+    [MO_UL] = "ul",
+    [MO_SL] = "sl",
+    [MO_64] = "uq",
+    [MO_128] = "uo",
+};
+
 static const char * const alignment_name[(MO_AMASK >> MO_ASHIFT) + 1] = {
     [MO_UNALN >> MO_ASHIFT]    = "un+",
     [MO_ALIGN >> MO_ASHIFT]    = "al+",
@@ -2876,6 +2872,25 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                     i = 1;
                 }
                 break;
+            case INDEX_op_ld_i32:
+            case INDEX_op_ld_i64:
+            case INDEX_op_st_i32:
+            case INDEX_op_st_i64:
+                {
+                    tcg_target_long ofs = op->args[k++];
+                    MemOp mop = op->args[k++];
+                    const char *s_op = ldst_noend_name[mop & MO_SSIZE];
+
+                    if (!(mop & ~MO_SSIZE) && s_op) {
+                        col += ne_fprintf(f, ",$0x%" TCG_PRIlx ",%s",
+                                          ofs, s_op);
+                    } else {
+                        col += ne_fprintf(f, ",$0x%" TCG_PRIlx ",0x%x",
+                                          ofs, mop);
+                    }
+                    i = 2;
+                }
+                break;
             case INDEX_op_bswap16_i32:
             case INDEX_op_bswap16_i64:
             case INDEX_op_bswap32_i32:
@@ -4199,11 +4214,12 @@ liveness_pass_2(TCGContext *s)
                                   ? INDEX_op_ld_i32
                                   : INDEX_op_ld_i64);
                 TCGOp *lop = tcg_op_insert_before(s, op, lopc,
-                                                  arg_ts->type, 3);
+                                                  arg_ts->type, 4);
 
                 lop->args[0] = temp_arg(dir_ts);
                 lop->args[1] = temp_arg(arg_ts->mem_base);
                 lop->args[2] = arg_ts->mem_offset;
+                lop->args[3] = arg_ts->type - TCG_TYPE_I32 + MO_32;
 
                 /* Loaded, but synced with memory.  */
                 arg_ts->state = TS_MEM;
@@ -4263,7 +4279,7 @@ liveness_pass_2(TCGContext *s)
                                       ? INDEX_op_st_i32
                                       : INDEX_op_st_i64);
                     TCGOp *sop = tcg_op_insert_after(s, op, sopc,
-                                                     arg_ts->type, 3);
+                                                     arg_ts->type, 4);
                     TCGTemp *out_ts = dir_ts;
 
                     if (IS_DEAD_ARG(0)) {
@@ -4277,6 +4293,7 @@ liveness_pass_2(TCGContext *s)
                     sop->args[0] = temp_arg(out_ts);
                     sop->args[1] = temp_arg(arg_ts->mem_base);
                     sop->args[2] = arg_ts->mem_offset;
+                    sop->args[3] = arg_ts->type - TCG_TYPE_I32 + MO_32;
                 } else {
                     tcg_debug_assert(!IS_DEAD_ARG(0));
                 }
@@ -4300,11 +4317,12 @@ liveness_pass_2(TCGContext *s)
                                       ? INDEX_op_st_i32
                                       : INDEX_op_st_i64);
                     TCGOp *sop = tcg_op_insert_after(s, op, sopc,
-                                                     arg_ts->type, 3);
+                                                     arg_ts->type, 4);
 
                     sop->args[0] = temp_arg(dir_ts);
                     sop->args[1] = temp_arg(arg_ts->mem_base);
                     sop->args[2] = arg_ts->mem_offset;
+                    sop->args[3] = arg_ts->type - TCG_TYPE_I32 + MO_32;
 
                     arg_ts->state = TS_MEM;
                 }
diff --git a/tcg/tci.c b/tcg/tci.c
index d0194dc5af..d7fa1bac2a 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -488,44 +488,42 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Load/store operations (32 bit). */
 
-        CASE_32_64(ld8u)
+        case INDEX_op_tci_ld8u:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(uint8_t *)ptr;
             break;
-        CASE_32_64(ld8s)
+        case INDEX_op_tci_ld8s:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(int8_t *)ptr;
             break;
-        CASE_32_64(ld16u)
+        case INDEX_op_tci_ld16u:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(uint16_t *)ptr;
             break;
-        CASE_32_64(ld16s)
+        case INDEX_op_tci_ld16s:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(int16_t *)ptr;
             break;
         case INDEX_op_ld_i32:
-        CASE_64(ld32u)
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(uint32_t *)ptr;
             break;
-        CASE_32_64(st8)
+        case INDEX_op_tci_st8:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             *(uint8_t *)ptr = regs[r0];
             break;
-        CASE_32_64(st16)
+        case INDEX_op_tci_st16:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             *(uint16_t *)ptr = regs[r0];
             break;
         case INDEX_op_st_i32:
-        CASE_64(st32)
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             *(uint32_t *)ptr = regs[r0];
@@ -692,7 +690,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 #if TCG_TARGET_REG_BITS == 64
             /* Load/store operations (64 bit). */
 
-        case INDEX_op_ld32s_i64:
+        case INDEX_op_tci_ld32s:
             tci_args_rrs(insn, &r0, &r1, &ofs);
             ptr = (void *)(regs[r1] + ofs);
             regs[r0] = *(int32_t *)ptr;
@@ -1045,23 +1043,15 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), ptr);
         break;
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
+    case INDEX_op_tci_ld8u:
+    case INDEX_op_tci_ld8s:
+    case INDEX_op_tci_ld16u:
+    case INDEX_op_tci_ld16s:
+    case INDEX_op_tci_ld32s:
     case INDEX_op_ld_i32:
     case INDEX_op_ld_i64:
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
+    case INDEX_op_tci_st8:
+    case INDEX_op_tci_st16:
     case INDEX_op_st_i32:
     case INDEX_op_st_i64:
         tci_args_rrs(insn, &r0, &r1, &s2);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index acc6dadfe5..6b6603a512 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2142,51 +2142,61 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_goto_label(s, arg_label(a0));
         break;
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-        tcg_out_ldst(s, I3312_LDRB, a0, a1, a2, 0);
-        break;
-    case INDEX_op_ld8s_i32:
-        tcg_out_ldst(s, I3312_LDRSBW, a0, a1, a2, 0);
-        break;
-    case INDEX_op_ld8s_i64:
-        tcg_out_ldst(s, I3312_LDRSBX, a0, a1, a2, 0);
-        break;
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-        tcg_out_ldst(s, I3312_LDRH, a0, a1, a2, 1);
-        break;
-    case INDEX_op_ld16s_i32:
-        tcg_out_ldst(s, I3312_LDRSHW, a0, a1, a2, 1);
-        break;
-    case INDEX_op_ld16s_i64:
-        tcg_out_ldst(s, I3312_LDRSHX, a0, a1, a2, 1);
-        break;
     case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-        tcg_out_ldst(s, I3312_LDRW, a0, a1, a2, 2);
-        break;
-    case INDEX_op_ld32s_i64:
-        tcg_out_ldst(s, I3312_LDRSWX, a0, a1, a2, 2);
-        break;
     case INDEX_op_ld_i64:
-        tcg_out_ldst(s, I3312_LDRX, a0, a1, a2, 3);
+        switch (args[3]) {
+        case MO_UB:
+            tcg_out_ldst(s, I3312_LDRB, a0, a1, a2, 0);
+            break;
+        case MO_SB:
+            if (ext) {
+                tcg_out_ldst(s, I3312_LDRSBX, a0, a1, a2, 0);
+            } else {
+                tcg_out_ldst(s, I3312_LDRSBW, a0, a1, a2, 0);
+            }
+            break;
+        case MO_UW:
+            tcg_out_ldst(s, I3312_LDRH, a0, a1, a2, 1);
+            break;
+        case MO_SW:
+            if (ext) {
+                tcg_out_ldst(s, I3312_LDRSHX, a0, a1, a2, 1);
+            } else {
+                tcg_out_ldst(s, I3312_LDRSHW, a0, a1, a2, 1);
+            }
+            break;
+        case MO_UL:
+            tcg_out_ldst(s, I3312_LDRW, a0, a1, a2, 2);
+            break;
+        case MO_SL:
+            tcg_out_ldst(s, I3312_LDRSWX, a0, a1, a2, 2);
+            break;
+        case MO_UQ:
+            tcg_out_ldst(s, I3312_LDRX, a0, a1, a2, 3);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        tcg_out_ldst(s, I3312_STRB, REG0(0), a1, a2, 0);
-        break;
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-        tcg_out_ldst(s, I3312_STRH, REG0(0), a1, a2, 1);
-        break;
     case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        tcg_out_ldst(s, I3312_STRW, REG0(0), a1, a2, 2);
-        break;
     case INDEX_op_st_i64:
-        tcg_out_ldst(s, I3312_STRX, REG0(0), a1, a2, 3);
+        switch (args[3]) {
+        case MO_8:
+            tcg_out_ldst(s, I3312_STRB, REG0(0), a1, a2, 0);
+            break;
+        case MO_16:
+            tcg_out_ldst(s, I3312_STRH, REG0(0), a1, a2, 1);
+            break;
+        case MO_32:
+            tcg_out_ldst(s, I3312_STRW, REG0(0), a1, a2, 2);
+            break;
+        case MO_64:
+            tcg_out_ldst(s, I3312_STRX, REG0(0), a1, a2, 3);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
 
     case INDEX_op_add_i32:
@@ -2967,17 +2977,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_neg_i32:
     case INDEX_op_neg_i64:
@@ -2998,12 +2998,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index e8908702d2..2b93054146 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1862,29 +1862,42 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_goto_label(s, COND_AL, arg_label(args[0]));
         break;
 
-    case INDEX_op_ld8u_i32:
-        tcg_out_ld8u(s, COND_AL, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld8s_i32:
-        tcg_out_ld8s(s, COND_AL, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld16u_i32:
-        tcg_out_ld16u(s, COND_AL, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld16s_i32:
-        tcg_out_ld16s(s, COND_AL, args[0], args[1], args[2]);
-        break;
     case INDEX_op_ld_i32:
-        tcg_out_ld32u(s, COND_AL, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_st8_i32:
-        tcg_out_st8(s, COND_AL, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_st16_i32:
-        tcg_out_st16(s, COND_AL, args[0], args[1], args[2]);
+        switch (args[3]) {
+        case MO_UB:
+            tcg_out_ld8u(s, COND_AL, args[0], args[1], args[2]);
+            break;
+        case MO_SB:
+            tcg_out_ld8s(s, COND_AL, args[0], args[1], args[2]);
+            break;
+        case MO_UW:
+            tcg_out_ld16u(s, COND_AL, args[0], args[1], args[2]);
+            break;
+        case MO_SW:
+            tcg_out_ld16s(s, COND_AL, args[0], args[1], args[2]);
+            break;
+        case MO_UL:
+            tcg_out_ld32u(s, COND_AL, args[0], args[1], args[2]);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
+
     case INDEX_op_st_i32:
-        tcg_out_st32(s, COND_AL, args[0], args[1], args[2]);
+        switch (args[3]) {
+        case MO_8:
+            tcg_out_st8(s, COND_AL, args[0], args[1], args[2]);
+            break;
+        case MO_16:
+            tcg_out_st16(s, COND_AL, args[0], args[1], args[2]);
+            break;
+        case MO_32:
+            tcg_out_st32(s, COND_AL, args[0], args[1], args[2]);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
 
     case INDEX_op_movcond_i32:
@@ -2168,10 +2181,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
@@ -2181,8 +2190,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sextract_i32:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index aa6b72f591..89b2eaf0cd 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2658,52 +2658,77 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_br:
         tcg_out_jxx(s, JCC_JMP, arg_label(a0), 0);
         break;
-    OP_32_64(ld8u):
-        /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
-        tcg_out_modrm_offset(s, OPC_MOVZBL, a0, a1, a2);
-        break;
-    OP_32_64(ld8s):
-        tcg_out_modrm_offset(s, OPC_MOVSBL + rexw, a0, a1, a2);
-        break;
-    OP_32_64(ld16u):
-        /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
-        tcg_out_modrm_offset(s, OPC_MOVZWL, a0, a1, a2);
-        break;
-    OP_32_64(ld16s):
-        tcg_out_modrm_offset(s, OPC_MOVSWL + rexw, a0, a1, a2);
-        break;
+
+    OP_32_64(ld):
+        switch (args[3]) {
+        case MO_UB:
+            /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
+            tcg_out_modrm_offset(s, OPC_MOVZBL, a0, a1, a2);
+            break;
+        case MO_SB:
+            tcg_out_modrm_offset(s, OPC_MOVSBL + rexw, a0, a1, a2);
+            break;
+        case MO_UW:
+            /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
+            tcg_out_modrm_offset(s, OPC_MOVZWL, a0, a1, a2);
+            break;
+        case MO_SW:
+            tcg_out_modrm_offset(s, OPC_MOVSWL + rexw, a0, a1, a2);
+            break;
+        case MO_UL:
+            tcg_out_ld(s, TCG_TYPE_I32, a0, a1, a2);
+            break;
 #if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_ld32u_i64:
+        case MO_SL:
+            tcg_out_modrm_offset(s, OPC_MOVSLQ, a0, a1, a2);
+            break;
+        case MO_UQ:
+            tcg_out_ld(s, TCG_TYPE_I64, a0, a1, a2);
+            break;
 #endif
-    case INDEX_op_ld_i32:
-        tcg_out_ld(s, TCG_TYPE_I32, a0, a1, a2);
+        default:
+            g_assert_not_reached();
+        }
         break;
 
-    OP_32_64(st8):
-        if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVB_EvIz, 0, a1, a2);
-            tcg_out8(s, a0);
-        } else {
-            tcg_out_modrm_offset(s, OPC_MOVB_EvGv | P_REXB_R, a0, a1, a2);
-        }
-        break;
-    OP_32_64(st16):
-        if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_DATA16, 0, a1, a2);
-            tcg_out16(s, a0);
-        } else {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvGv | P_DATA16, a0, a1, a2);
-        }
-        break;
+    OP_32_64(st):
+        switch (args[3]) {
+        case MO_8:
+            if (const_args[0]) {
+                tcg_out_modrm_offset(s, OPC_MOVB_EvIz, 0, a1, a2);
+                tcg_out8(s, a0);
+            } else {
+                tcg_out_modrm_offset(s, OPC_MOVB_EvGv | P_REXB_R, a0, a1, a2);
+            }
+            break;
+        case MO_16:
+            if (const_args[0]) {
+                tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_DATA16, 0, a1, a2);
+                tcg_out16(s, a0);
+            } else {
+                tcg_out_modrm_offset(s, OPC_MOVL_EvGv | P_DATA16, a0, a1, a2);
+            }
+            break;
+        case MO_32:
+            if (const_args[0]) {
+                tcg_out_modrm_offset(s, OPC_MOVL_EvIz, 0, a1, a2);
+                tcg_out32(s, a0);
+            } else {
+                tcg_out_st(s, TCG_TYPE_I32, a0, a1, a2);
+            }
+            break;
 #if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_st32_i64:
+        case MO_64:
+            if (const_args[0]) {
+                tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_REXW, 0, a1, a2);
+                tcg_out32(s, a0);
+            } else {
+                tcg_out_st(s, TCG_TYPE_I64, a0, a1, a2);
+            }
+            break;
 #endif
-    case INDEX_op_st_i32:
-        if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvIz, 0, a1, a2);
-            tcg_out32(s, a0);
-        } else {
-            tcg_out_st(s, TCG_TYPE_I32, a0, a1, a2);
+        default:
+            g_assert_not_reached();
         }
         break;
 
@@ -2978,21 +3003,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_setcond2(s, args, const_args);
         break;
 #else /* TCG_TARGET_REG_BITS == 64 */
-    case INDEX_op_ld32s_i64:
-        tcg_out_modrm_offset(s, OPC_MOVSLQ, a0, a1, a2);
-        break;
-    case INDEX_op_ld_i64:
-        tcg_out_ld(s, TCG_TYPE_I64, a0, a1, a2);
-        break;
-    case INDEX_op_st_i64:
-        if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_REXW, 0, a1, a2);
-            tcg_out32(s, a0);
-        } else {
-            tcg_out_st(s, TCG_TYPE_I64, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_bswap64_i64:
         tcg_out_bswap64(s, a0);
         break;
@@ -3667,32 +3677,22 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
     case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        return C_O0_I2(qi, r);
-
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
     case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        return C_O0_I2(ri, r);
-
     case INDEX_op_st_i64:
-        return C_O0_I2(re, r);
+        switch (op->args[3]) {
+        case MO_8:
+            return C_O0_I2(qi, r);
+        case MO_16:
+        case MO_32:
+            return C_O0_I2(ri, r);
+        case MO_64:
+            return C_O0_I2(re, r);
+        }
+        g_assert_not_reached();
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 293bf36656..eff98fb02c 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1632,47 +1632,56 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_movcond(s, args[5], a0, a1, a2, c2, args[3], args[4]);
         break;
 
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-        tcg_out_ldst(s, OPC_LD_B, a0, a1, a2);
-        break;
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-        tcg_out_ldst(s, OPC_LD_BU, a0, a1, a2);
-        break;
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-        tcg_out_ldst(s, OPC_LD_H, a0, a1, a2);
-        break;
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-        tcg_out_ldst(s, OPC_LD_HU, a0, a1, a2);
-        break;
     case INDEX_op_ld_i32:
-    case INDEX_op_ld32s_i64:
-        tcg_out_ldst(s, OPC_LD_W, a0, a1, a2);
-        break;
-    case INDEX_op_ld32u_i64:
-        tcg_out_ldst(s, OPC_LD_WU, a0, a1, a2);
-        break;
     case INDEX_op_ld_i64:
-        tcg_out_ldst(s, OPC_LD_D, a0, a1, a2);
+        switch (args[3]) {
+        case MO_SB:
+            tcg_out_ldst(s, OPC_LD_B, a0, a1, a2);
+            break;
+        case MO_UB:
+            tcg_out_ldst(s, OPC_LD_BU, a0, a1, a2);
+            break;
+        case MO_SW:
+            tcg_out_ldst(s, OPC_LD_H, a0, a1, a2);
+            break;
+        case MO_UW:
+            tcg_out_ldst(s, OPC_LD_HU, a0, a1, a2);
+            break;
+        case MO_UL:
+            if (opc == INDEX_op_ld_i64) {
+                tcg_out_ldst(s, OPC_LD_WU, a0, a1, a2);
+                break;
+            }
+            /* FALLTHRU -- TCG_TYPE_I32 is canonically sign-extended. */
+        case MO_SL:
+            tcg_out_ldst(s, OPC_LD_W, a0, a1, a2);
+            break;
+        case MO_UQ:
+            tcg_out_ldst(s, OPC_LD_D, a0, a1, a2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        tcg_out_ldst(s, OPC_ST_B, a0, a1, a2);
-        break;
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-        tcg_out_ldst(s, OPC_ST_H, a0, a1, a2);
-        break;
     case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        tcg_out_ldst(s, OPC_ST_W, a0, a1, a2);
-        break;
     case INDEX_op_st_i64:
-        tcg_out_ldst(s, OPC_ST_D, a0, a1, a2);
+        switch (args[3]) {
+        case MO_8:
+            tcg_out_ldst(s, OPC_ST_B, a0, a1, a2);
+            break;
+        case MO_16:
+            tcg_out_ldst(s, OPC_ST_H, a0, a1, a2);
+            break;
+        case MO_32:
+            tcg_out_ldst(s, OPC_ST_W, a0, a1, a2);
+            break;
+        case MO_64:
+            tcg_out_ldst(s, OPC_ST_D, a0, a1, a2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
 
     case INDEX_op_qemu_ld_a32_i32:
@@ -2215,11 +2224,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
     case INDEX_op_st_i32:
     case INDEX_op_st_i64:
     case INDEX_op_qemu_st_a32_i32:
@@ -2257,16 +2261,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i32:
     case INDEX_op_ld_i64:
     case INDEX_op_qemu_ld_a32_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 8d3b005f2d..df016ae65a 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1711,46 +1711,54 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                        arg_label(a0));
         break;
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-        i1 = OPC_LBU;
-        goto do_ldst;
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-        i1 = OPC_LB;
-        goto do_ldst;
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-        i1 = OPC_LHU;
-        goto do_ldst;
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-        i1 = OPC_LH;
-        goto do_ldst;
     case INDEX_op_ld_i32:
-    case INDEX_op_ld32s_i64:
-        i1 = OPC_LW;
-        goto do_ldst;
-    case INDEX_op_ld32u_i64:
-        i1 = OPC_LWU;
-        goto do_ldst;
     case INDEX_op_ld_i64:
-        i1 = OPC_LD;
-        goto do_ldst;
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        i1 = OPC_SB;
-        goto do_ldst;
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-        i1 = OPC_SH;
-        goto do_ldst;
+        switch (args[3]) {
+        case MO_UB:
+            i1 = OPC_LBU;
+            goto do_ldst;
+        case MO_SB:
+            i1 = OPC_LB;
+            goto do_ldst;
+        case MO_UW:
+            i1 = OPC_LHU;
+            goto do_ldst;
+        case MO_SW:
+            i1 = OPC_LH;
+            goto do_ldst;
+        case MO_UL:
+            if (opc == INDEX_op_ld_i64) {
+                i1 = OPC_LWU;
+                goto do_ldst;
+            }
+            /* FALLTHRU -- TCG_TYPE_I32 is canonically sign-extended. */
+        case MO_SL:
+            i1 = OPC_LW;
+            goto do_ldst;
+        case MO_UQ:
+            i1 = OPC_LD;
+            goto do_ldst;
+        }
+        g_assert_not_reached();
+
     case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        i1 = OPC_SW;
-        goto do_ldst;
     case INDEX_op_st_i64:
-        i1 = OPC_SD;
+        switch (args[3]) {
+        case MO_8:
+            i1 = OPC_SB;
+            goto do_ldst;
+        case MO_16:
+            i1 = OPC_SH;
+            goto do_ldst;
+        case MO_32:
+            i1 = OPC_SW;
+            goto do_ldst;
+        case MO_64:
+            i1 = OPC_SD;
+            goto do_ldst;
+        }
+        g_assert_not_reached();
+
     do_ldst:
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
@@ -2174,10 +2182,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
@@ -2185,12 +2189,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
@@ -2205,12 +2203,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 0cb04241fa..07619b697e 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2966,47 +2966,55 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
             tcg_out32(s, insn);
         }
         break;
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-        tcg_out_mem_long(s, LBZ, LBZX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-        tcg_out_mem_long(s, LBZ, LBZX, args[0], args[1], args[2]);
-        tcg_out_ext8s(s, TCG_TYPE_REG, args[0], args[0]);
-        break;
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-        tcg_out_mem_long(s, LHZ, LHZX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-        tcg_out_mem_long(s, LHA, LHAX, args[0], args[1], args[2]);
-        break;
+
     case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-        tcg_out_mem_long(s, LWZ, LWZX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_ld32s_i64:
-        tcg_out_mem_long(s, LWA, LWAX, args[0], args[1], args[2]);
-        break;
     case INDEX_op_ld_i64:
-        tcg_out_mem_long(s, LD, LDX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        tcg_out_mem_long(s, STB, STBX, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-        tcg_out_mem_long(s, STH, STHX, args[0], args[1], args[2]);
+        switch (args[3]) {
+        case MO_UB:
+        case MO_SB:
+            tcg_out_mem_long(s, LBZ, LBZX, args[0], args[1], args[2]);
+            if (args[3] & MO_SIGN) {
+                tcg_out_ext8s(s, TCG_TYPE_REG, args[0], args[0]);
+            }
+            break;
+        case MO_UW:
+            tcg_out_mem_long(s, LHZ, LHZX, args[0], args[1], args[2]);
+            break;
+        case MO_SW:
+            tcg_out_mem_long(s, LHA, LHAX, args[0], args[1], args[2]);
+            break;
+        case MO_UL:
+            tcg_out_mem_long(s, LWZ, LWZX, args[0], args[1], args[2]);
+            break;
+        case MO_SL:
+            tcg_out_mem_long(s, LWA, LWAX, args[0], args[1], args[2]);
+            break;
+        case MO_UQ:
+            tcg_out_mem_long(s, LD, LDX, args[0], args[1], args[2]);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
+
     case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        tcg_out_mem_long(s, STW, STWX, args[0], args[1], args[2]);
-        break;
     case INDEX_op_st_i64:
-        tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
+        switch (args[3]) {
+        case MO_8:
+            tcg_out_mem_long(s, STB, STBX, args[0], args[1], args[2]);
+            break;
+        case MO_16:
+            tcg_out_mem_long(s, STH, STHX, args[0], args[1], args[2]);
+            break;
+        case MO_32:
+            tcg_out_mem_long(s, STW, STWX, args[0], args[1], args[2]);
+            break;
+        case MO_64:
+            tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
 
     case INDEX_op_add_i32:
@@ -4167,10 +4175,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_ctpop_i32:
     case INDEX_op_neg_i32:
@@ -4179,12 +4183,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_ctpop_i64:
     case INDEX_op_neg_i64:
@@ -4200,12 +4198,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 37a2be0551..707c0e4984 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1979,47 +1979,56 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, 0);
         break;
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-        tcg_out_ldst(s, OPC_LBU, a0, a1, a2);
-        break;
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-        tcg_out_ldst(s, OPC_LB, a0, a1, a2);
-        break;
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-        tcg_out_ldst(s, OPC_LHU, a0, a1, a2);
-        break;
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
-        tcg_out_ldst(s, OPC_LH, a0, a1, a2);
-        break;
-    case INDEX_op_ld32u_i64:
-        tcg_out_ldst(s, OPC_LWU, a0, a1, a2);
-        break;
     case INDEX_op_ld_i32:
-    case INDEX_op_ld32s_i64:
-        tcg_out_ldst(s, OPC_LW, a0, a1, a2);
-        break;
     case INDEX_op_ld_i64:
-        tcg_out_ldst(s, OPC_LD, a0, a1, a2);
+        switch (args[3]) {
+        case MO_UB:
+            tcg_out_ldst(s, OPC_LBU, a0, a1, a2);
+            break;
+        case MO_SB:
+            tcg_out_ldst(s, OPC_LB, a0, a1, a2);
+            break;
+        case MO_UW:
+            tcg_out_ldst(s, OPC_LHU, a0, a1, a2);
+            break;
+        case MO_SW:
+            tcg_out_ldst(s, OPC_LH, a0, a1, a2);
+            break;
+        case MO_UL:
+            if (opc == INDEX_op_ld_i64) {
+                tcg_out_ldst(s, OPC_LWU, a0, a1, a2);
+                break;
+            }
+            /* FALLTHRU -- TCG_TYPE_I32 is canonically sign-extended. */
+        case MO_SL:
+            tcg_out_ldst(s, OPC_LW, a0, a1, a2);
+            break;
+        case MO_UQ:
+            tcg_out_ldst(s, OPC_LD, a0, a1, a2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-        tcg_out_ldst(s, OPC_SB, a0, a1, a2);
-        break;
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
-        tcg_out_ldst(s, OPC_SH, a0, a1, a2);
-        break;
     case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        tcg_out_ldst(s, OPC_SW, a0, a1, a2);
-        break;
     case INDEX_op_st_i64:
-        tcg_out_ldst(s, OPC_SD, a0, a1, a2);
+        switch (args[3]) {
+        case MO_8:
+            tcg_out_ldst(s, OPC_SB, a0, a1, a2);
+            break;
+        case MO_16:
+            tcg_out_ldst(s, OPC_SH, a0, a1, a2);
+            break;
+        case MO_32:
+            tcg_out_ldst(s, OPC_SW, a0, a1, a2);
+            break;
+        case MO_64:
+            tcg_out_ldst(s, OPC_SD, a0, a1, a2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
 
     case INDEX_op_add_i32:
@@ -2617,19 +2626,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_not_i32:
     case INDEX_op_neg_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32s_i64:
-    case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_not_i64:
     case INDEX_op_neg_i64:
@@ -2650,12 +2649,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 35a9d6ee45..89993fb3ac 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2162,43 +2162,59 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, a0);
         break;
 
-    OP_32_64(ld8u):
-        /* ??? LLC (RXY format) is only present with the extended-immediate
-           facility, whereas LLGC is always present.  */
-        tcg_out_mem(s, 0, RXY_LLGC, args[0], args[1], TCG_REG_NONE, args[2]);
+    OP_32_64(ld):
+        switch (args[3]) {
+        case MO_UB:
+            tcg_out_mem(s, 0, RXY_LLGC,
+                        args[0], args[1], TCG_REG_NONE, args[2]);
+            break;
+        case MO_SB:
+            tcg_out_mem(s, 0, RXY_LGB,
+                        args[0], args[1], TCG_REG_NONE, args[2]);
+            break;
+        case MO_UW:
+            tcg_out_mem(s, 0, RXY_LLGH,
+                        args[0], args[1], TCG_REG_NONE, args[2]);
+            break;
+        case MO_SW:
+            tcg_out_mem(s, 0, RXY_LGH,
+                        args[0], args[1], TCG_REG_NONE, args[2]);
+            break;
+        case MO_UL:
+            tcg_out_mem(s, 0, RXY_LLGF,
+                        args[0], args[1], TCG_REG_NONE, args[2]);
+            break;
+        case MO_SL:
+            tcg_out_mem(s, 0, RXY_LGF,
+                        args[0], args[1], TCG_REG_NONE, args[2]);
+            break;
+        case MO_UQ:
+            tcg_out_ld(s, TCG_TYPE_I64, args[0], args[1], args[2]);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
 
-    OP_32_64(ld8s):
-        /* ??? LB is no smaller than LGB, so no point to using it.  */
-        tcg_out_mem(s, 0, RXY_LGB, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-
-    OP_32_64(ld16u):
-        /* ??? LLH (RXY format) is only present with the extended-immediate
-           facility, whereas LLGH is always present.  */
-        tcg_out_mem(s, 0, RXY_LLGH, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-
-    case INDEX_op_ld16s_i32:
-        tcg_out_mem(s, RX_LH, RXY_LHY, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-
-    case INDEX_op_ld_i32:
-        tcg_out_ld(s, TCG_TYPE_I32, args[0], args[1], args[2]);
-        break;
-
-    OP_32_64(st8):
-        tcg_out_mem(s, RX_STC, RXY_STCY, args[0], args[1],
-                    TCG_REG_NONE, args[2]);
-        break;
-
-    OP_32_64(st16):
-        tcg_out_mem(s, RX_STH, RXY_STHY, args[0], args[1],
-                    TCG_REG_NONE, args[2]);
-        break;
-
-    case INDEX_op_st_i32:
-        tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
+    OP_32_64(st):
+        switch (args[3]) {
+        case MO_8:
+            tcg_out_mem(s, RX_STC, RXY_STCY, args[0], args[1],
+                        TCG_REG_NONE, args[2]);
+            break;
+        case MO_16:
+            tcg_out_mem(s, RX_STH, RXY_STHY, args[0], args[1],
+                        TCG_REG_NONE, args[2]);
+            break;
+        case MO_32:
+            tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
+            break;
+        case MO_64:
+            tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
 
     case INDEX_op_add_i32:
@@ -2480,25 +2496,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_ld16s_i64:
-        tcg_out_mem(s, 0, RXY_LGH, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-    case INDEX_op_ld32u_i64:
-        tcg_out_mem(s, 0, RXY_LLGF, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-    case INDEX_op_ld32s_i64:
-        tcg_out_mem(s, 0, RXY_LGF, args[0], args[1], TCG_REG_NONE, args[2]);
-        break;
-    case INDEX_op_ld_i64:
-        tcg_out_ld(s, TCG_TYPE_I64, args[0], args[1], args[2]);
-        break;
-
-    case INDEX_op_st32_i64:
-        tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_st_i64:
-        tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
-        break;
 
     case INDEX_op_add_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
@@ -3241,26 +3238,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
     case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
     case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 6d28498815..3368ccb9fd 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1315,32 +1315,53 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         glue(glue(case INDEX_op_, x), _i32):    \
         glue(glue(case INDEX_op_, x), _i64)
 
-    OP_32_64(ld8u):
-        tcg_out_ldst(s, a0, a1, a2, LDUB);
+    OP_32_64(ld):
+        switch (args[3]) {
+        case MO_UB:
+            tcg_out_ldst(s, a0, a1, a2, LDUB);
+            break;
+        case MO_SB:
+            tcg_out_ldst(s, a0, a1, a2, LDSB);
+            break;
+        case MO_UW:
+            tcg_out_ldst(s, a0, a1, a2, LDUH);
+            break;
+        case MO_SW:
+            tcg_out_ldst(s, a0, a1, a2, LDSH);
+            break;
+        case MO_UL:
+            tcg_out_ldst(s, a0, a1, a2, LDUW);
+            break;
+        case MO_SL:
+            tcg_out_ldst(s, a0, a1, a2, LDSW);
+            break;
+        case MO_UQ:
+            tcg_out_ldst(s, a0, a1, a2, LDX);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
-    OP_32_64(ld8s):
-        tcg_out_ldst(s, a0, a1, a2, LDSB);
-        break;
-    OP_32_64(ld16u):
-        tcg_out_ldst(s, a0, a1, a2, LDUH);
-        break;
-    OP_32_64(ld16s):
-        tcg_out_ldst(s, a0, a1, a2, LDSH);
-        break;
-    case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-        tcg_out_ldst(s, a0, a1, a2, LDUW);
-        break;
-    OP_32_64(st8):
-        tcg_out_ldst(s, a0, a1, a2, STB);
-        break;
-    OP_32_64(st16):
-        tcg_out_ldst(s, a0, a1, a2, STH);
-        break;
-    case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
-        tcg_out_ldst(s, a0, a1, a2, STW);
+
+    OP_32_64(st):
+        switch (args[3]) {
+        case MO_8:
+            tcg_out_ldst(s, a0, a1, a2, STB);
+            break;
+        case MO_16:
+            tcg_out_ldst(s, a0, a1, a2, STH);
+            break;
+        case MO_32:
+            tcg_out_ldst(s, a0, a1, a2, STW);
+            break;
+        case MO_64:
+            tcg_out_ldst(s, a0, a1, a2, STX);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
+
     OP_32_64(add):
         c = ARITH_ADD;
         goto gen_arith;
@@ -1443,15 +1464,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
 
-    case INDEX_op_ld32s_i64:
-        tcg_out_ldst(s, a0, a1, a2, LDSW);
-        break;
-    case INDEX_op_ld_i64:
-        tcg_out_ldst(s, a0, a1, a2, LDX);
-        break;
-    case INDEX_op_st_i64:
-        tcg_out_ldst(s, a0, a1, a2, STX);
-        break;
     case INDEX_op_shl_i64:
         c = SHIFT_SLLX;
     do_shift64:
@@ -1541,17 +1553,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i32:
-    case INDEX_op_ld16s_i64:
     case INDEX_op_ld_i32:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_neg_i32:
     case INDEX_op_neg_i64:
@@ -1569,12 +1571,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_qemu_ld_a64_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st16_i64:
     case INDEX_op_st_i32:
-    case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
     case INDEX_op_qemu_st_a32_i32:
     case INDEX_op_qemu_st_a64_i32:
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index ecc8c4e55e..2e19c8252b 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -2,3 +2,10 @@
 /* These opcodes for use between the tci generator and interpreter. */
 DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_ld8u, 1, 1, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_ld8s, 1, 1, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_ld16u, 1, 1, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_ld16s, 1, 1, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_ld32s, 1, 1, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_st8, 1, 1, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_st16, 1, 1, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 583cec1ecf..f4cabe5d3d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -42,17 +42,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_goto_ptr:
         return C_O0_I1(r);
 
-    case INDEX_op_ld8u_i32:
-    case INDEX_op_ld8s_i32:
-    case INDEX_op_ld16u_i32:
-    case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_ld8u_i64:
-    case INDEX_op_ld8s_i64:
-    case INDEX_op_ld16u_i64:
-    case INDEX_op_ld16s_i64:
-    case INDEX_op_ld32u_i64:
-    case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
@@ -75,12 +65,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
@@ -702,19 +687,52 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                           args[3], args[4], args[5]);
         break;
 
-    CASE_32_64(ld8u)
-    CASE_32_64(ld8s)
-    CASE_32_64(ld16u)
-    CASE_32_64(ld16s)
-    case INDEX_op_ld_i32:
-    CASE_64(ld32u)
-    CASE_64(ld32s)
-    CASE_64(ld)
-    CASE_32_64(st8)
-    CASE_32_64(st16)
-    case INDEX_op_st_i32:
-    CASE_64(st32)
-    CASE_64(st)
+    CASE_32_64(ld)
+        switch (args[3]) {
+        case MO_UB:
+            opc = INDEX_op_tci_ld8u;
+            break;
+        case MO_SB:
+            opc = INDEX_op_tci_ld8s;
+            break;
+        case MO_UW:
+            opc = INDEX_op_tci_ld16u;
+            break;
+        case MO_SW:
+            opc = INDEX_op_tci_ld16s;
+            break;
+        case MO_UL:
+            opc = INDEX_op_ld_i32;
+            break;
+        case MO_SL:
+            opc = INDEX_op_tci_ld32s;
+            break;
+        case MO_UQ:
+            opc = INDEX_op_ld_i64;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        tcg_out_ldst(s, opc, args[0], args[1], args[2]);
+        break;
+
+    CASE_32_64(st)
+        switch (args[3]) {
+        case MO_8:
+            opc = INDEX_op_tci_st8;
+            break;
+        case MO_16:
+            opc = INDEX_op_tci_st16;
+            break;
+        case MO_32:
+            opc = INDEX_op_st_i32;
+            break;
+        case MO_64:
+            opc = INDEX_op_st_i64;
+            break;
+        default:
+            g_assert_not_reached();
+        }
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-- 
2.43.0


