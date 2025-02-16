Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3CAC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmV-0005ZQ-HC; Sun, 16 Feb 2025 18:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmL-0005VF-Ei
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:25 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmF-0005CJ-KX
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:25 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso56348605ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747417; x=1740352217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ztNaeswgAk8ivX4ZGL0BhChPm4bHYPSWoiHTgSrIjGw=;
 b=IOBWpaZLlDjbSniLcsKrXacNF9edX2kjy/IeXzCqu3bdTstWRBjuHoYRhWwd7pzJK6
 8D7GRS5QJn566bPsGyenZUlAXpLFx6Z0oHRXQ0SiziAXGwzYjRhMebj0kEHWk+eSLDfo
 +WYrdoYUZvCM08avMQd/sJepRv0RtRjqmTOJxhGMhcNL4xwls25i5iUJSotaHJ4xOUtp
 a0GXN4Bo2/CA85KB2/M8s3zC7yLMbBE7UBnasHKRSIcT/SuIMX9/3sjp7Q+QbmwEZkWE
 H9EWreEmMqNx8w9RssEvq9B0z7m54FY3Y3j/Mx4iVRwFvCSGXqH3IvbrSSllJY2CP9C/
 xlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747417; x=1740352217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ztNaeswgAk8ivX4ZGL0BhChPm4bHYPSWoiHTgSrIjGw=;
 b=AYx3bMBx2pHr+vDMUWtTD7AbBdKmvOtb8MGpTzethj7MF1445i3DEy/Wg9AlHQW44n
 eWXyEVqR2wcf0NI+hio8s6xMBq8q2vgYbG4/7OVxDp5wzQIfQ0ypYvFjVCX3E0BspeMH
 4CAoi/Gjtb14yFzPsORdn6a9SrCi2JolK7HcMEdVeUXw4lSH3ygexkxujacBKfG/6n80
 sjWP1sGr6JEx32tMI2eZNRkZQ8W1bvAXaxaQGyptcbhvcz0ymdIbG6Ksg3OCdJZ/Hloh
 QC5oAksc7TLpMCptUWXjtE1BrPP4nluEowmX7KIhQRE7b6QDdA6+Lekge7MdYLYUTk8h
 WKYA==
X-Gm-Message-State: AOJu0YzLX3lF6SDKYSBnunuSAbGErm6gkBc3c42RKsPsf54aa/e+GhgX
 rvR8mizvRvqgCLhXTfBypQycMP3CFCn+joCi1NxteED/J/IeoMl/RK1BGDu8tfOf6r+KZeH4H2K
 G
X-Gm-Gg: ASbGnctMsH7UJQmyetPhCgwlx+aGWPtCNiR9DDesaP3rCJqmHvH71dz5wdqDZRJIFza
 QPq9XOVaQq47BmTFsLWV7E5Mnm0ofIYf4EdX2FcC6rcsFVPaTaX0tFjvwQ69xKmSAgpikePAPwV
 1wkyUVhuUSomnsEWKpAHqdewoxFcZnGVurzyqwbmnrj1+dFJaM3vXPjOXiim6c/2XNZkyGsE0sn
 G3BVsaNsrDSWj1jrbXV605yUQIbjL3AJ++69DxQNqdTC/Wr21ZEQdaOo6321kJja3Lm2s8+8Cf6
 Dj0pHUGhUBXCx0M3bAMAU05LeAR5JUWjW/psYLuwxiTvJEs=
X-Google-Smtp-Source: AGHT+IFRmyu3UsXsrU0H+W2A0X9HN1h4OGjN+7LiFzhiZbfKPJPjW2gCpVRIVvoLo0eOpbMcUEJeQA==
X-Received: by 2002:a17:902:ecc4:b0:215:8847:4377 with SMTP id
 d9443c01a7336-221045c8b55mr94059125ad.15.1739747417034; 
 Sun, 16 Feb 2025 15:10:17 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 004/162] tcg: Convert add to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:07:33 -0800
Message-ID: <20250216231012.2808572-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target-con-set.h |   1 +
 tcg/tcg.c                        |  40 ++++++++++-
 tcg/aarch64/tcg-target.c.inc     |  51 +++++++-------
 tcg/arm/tcg-target.c.inc         |  43 ++++++++----
 tcg/i386/tcg-target.c.inc        |  56 +++++++++-------
 tcg/loongarch64/tcg-target.c.inc |  38 +++++------
 tcg/mips/tcg-target.c.inc        |  31 ++++++---
 tcg/ppc/tcg-target.c.inc         |  47 +++++++------
 tcg/riscv/tcg-target.c.inc       |  39 ++++++-----
 tcg/s390x/tcg-target.c.inc       | 110 +++++++++++++++----------------
 tcg/sparc64/tcg-target.c.inc     |  25 +++++--
 tcg/tci/tcg-target.c.inc         |  15 ++++-
 12 files changed, 301 insertions(+), 195 deletions(-)

diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index 61f9fa3d9f..d90ba11443 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -14,6 +14,7 @@ C_O0_I2(rz, r)
 C_O0_I2(rz, rJ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
+C_O1_I2(r, r, rJ)
 C_O1_I2(r, rz, rJ)
 C_O1_I4(r, rz, rJ, rI, 0)
 C_O2_I2(r, r, rz, rJ)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 99f6371fd8..fcc38ea8c8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -978,6 +978,14 @@ typedef struct TCGOutOp {
     TCGConstraintSetIndex (*dynamic_constraint)(TCGType type, unsigned flags);
 } TCGOutOp;
 
+typedef struct TCGOutOpBinary {
+    TCGOutOp base;
+    void (*out_rrr)(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2);
+    void (*out_rri)(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, tcg_target_long a2);
+} TCGOutOpBinary;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -987,10 +995,21 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                   < MIN_TLB_MASK_TABLE_OFS);
 #endif
 
+/*
+ * Register V as the TCGOutOp for O.
+ * This verifies that V is of type T, otherwise give a nice compiler error.
+ * This prevents trivial mistakes within each arch/tcg-target.c.inc.
+ */
+#define OUTOP(O, T, V)  [O] = _Generic(V, T: &V.base)
+
 /* Register allocation descriptions for every TCGOpcode. */
 static const TCGOutOp * const all_outop[NB_OPS] = {
+    OUTOP(INDEX_op_add_i32, TCGOutOpBinary, outop_add),
+    OUTOP(INDEX_op_add_i64, TCGOutOpBinary, outop_add),
 };
 
+#undef OUTOP
+
 /*
  * All TCG threads except the parent (i.e. the one that called tcg_context_init
  * and registered the target's TCG globals) must register with this function
@@ -5408,6 +5427,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     }
 
     /* emit instruction */
+    TCGType type = TCGOP_TYPE(op);
     switch (op->opc) {
     case INDEX_op_ext_i32_i64:
         tcg_out_exts_i32_i64(s, new_args[0], new_args[1]);
@@ -5418,12 +5438,28 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_extrl_i64_i32:
         tcg_out_extrl_i64_i32(s, new_args[0], new_args[1]);
         break;
+
+    case INDEX_op_add_i32:
+    case INDEX_op_add_i64:
+        {
+            const TCGOutOpBinary *out =
+                container_of(all_outop[op->opc], TCGOutOpBinary, base);
+
+            tcg_debug_assert(!const_args[1]);
+            if (const_args[2]) {
+                out->out_rri(s, type, new_args[0], new_args[1], new_args[2]);
+            } else {
+                out->out_rrr(s, type, new_args[0], new_args[1], new_args[2]);
+            }
+        }
+        break;
+
     default:
         if (def->flags & TCG_OPF_VECTOR) {
-            tcg_out_vec_op(s, op->opc, TCGOP_TYPE(op) - TCG_TYPE_V64,
+            tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
                            TCGOP_VECE(op), new_args, const_args);
         } else {
-            tcg_out_op(s, op->opc, TCGOP_TYPE(op), new_args, const_args);
+            tcg_out_op(s, op->opc, type, new_args, const_args);
         }
         break;
     }
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 466042a577..a181b7e65a 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1592,16 +1592,6 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rn)
     tcg_out_mov(s, TCG_TYPE_I32, rd, rn);
 }
 
-static void tcg_out_addsubi(TCGContext *s, int ext, TCGReg rd,
-                            TCGReg rn, int64_t aimm)
-{
-    if (aimm >= 0) {
-        tcg_out_insn(s, 3401, ADDI, ext, rd, rn, aimm);
-    } else {
-        tcg_out_insn(s, 3401, SUBI, ext, rd, rn, -aimm);
-    }
-}
-
 static void tcg_out_addsub2(TCGContext *s, TCGType ext, TCGReg rl,
                             TCGReg rh, TCGReg al, TCGReg ah,
                             tcg_target_long bl, tcg_target_long bh,
@@ -2115,6 +2105,30 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3502, ADD, type, a0, a1, a2);
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 >= 0) {
+        tcg_out_insn(s, 3401, ADDI, type, a0, a1, a2);
+    } else {
+        tcg_out_insn(s, 3401, SUBI, type, a0, a1, -a2);
+    }
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rA),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2181,23 +2195,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_add_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_add_i64:
-        if (c2) {
-            tcg_out_addsubi(s, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3502, ADD, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_sub_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
     case INDEX_op_sub_i64:
         if (c2) {
-            tcg_out_addsubi(s, ext, a0, a1, -a2);
+            tgen_addi(s, ext, a0, a1, -a2);
         } else {
             tcg_out_insn(s, 3502, SUB, ext, a0, a1, a2);
         }
@@ -2984,8 +2985,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
         return C_O1_I2(r, r, rA);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 0a959578d2..4b7358a4e8 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -896,6 +896,17 @@ static void tcg_out_dat_rIK(TCGContext *s, ARMCond cond, ARMInsn opc,
     }
 }
 
+static void tcg_out_dat_IN(TCGContext *s, ARMCond cond, ARMInsn opc,
+                           ARMInsn opneg, TCGReg dst, TCGReg lhs, TCGArg rhs)
+{
+    int imm12 = encode_imm(rhs);
+    if (imm12 < 0) {
+        imm12 = encode_imm_nofail(-rhs);
+        opc = opneg;
+    }
+    tcg_out_dat_imm(s, cond, opc, dst, lhs, imm12);
+}
+
 static void tcg_out_dat_rIN(TCGContext *s, ARMCond cond, ARMInsn opc,
                             ARMInsn opneg, TCGReg dst, TCGReg lhs, TCGArg rhs,
                             bool rhs_is_const)
@@ -904,12 +915,7 @@ static void tcg_out_dat_rIN(TCGContext *s, ARMCond cond, ARMInsn opc,
      * rhs must satisfy the "rIN" constraint.
      */
     if (rhs_is_const) {
-        int imm12 = encode_imm(rhs);
-        if (imm12 < 0) {
-            imm12 = encode_imm_nofail(-rhs);
-            opc = opneg;
-        }
-        tcg_out_dat_imm(s, cond, opc, dst, lhs, imm12);
+        tcg_out_dat_IN(s, cond, opc, opneg, dst, lhs, rhs);
     } else {
         tcg_out_dat_reg(s, cond, opc, dst, lhs, rhs, SHIFT_IMM_LSL(0));
     }
@@ -1827,6 +1833,26 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_ADD, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_IN(s, COND_AL, ARITH_ADD, ARITH_SUB, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rIN),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1875,10 +1901,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_dat_rIK(s, tcg_cond_to_arm_cond[c], ARITH_MOV,
                         ARITH_MVN, args[0], 0, args[3], const_args[3]);
         break;
-    case INDEX_op_add_i32:
-        tcg_out_dat_rIN(s, COND_AL, ARITH_ADD, ARITH_SUB,
-                        args[0], args[1], args[2], const_args[2]);
-        break;
     case INDEX_op_sub_i32:
         if (const_args[1]) {
             if (const_args[2]) {
@@ -2148,7 +2170,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add_i32:
     case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 75c8665d74..1115d1e38d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2562,6 +2562,40 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* no need to flush icache explicitly */
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+
+    if (a0 == a1) {
+        tgen_arithr(s, ARITH_ADD + rexw, a0, a2);
+    } else if (a0 == a2) {
+        tgen_arithr(s, ARITH_ADD + rexw, a0, a1);
+    } else {
+        tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a2, 0, 0);
+    }
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+
+    if (a0 == a1) {
+        tgen_arithi(s, ARITH_ADD + rexw, a0, a2, false);
+    } else {
+        tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, -1, 0, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, re),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2642,24 +2676,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(add):
-        /* For 3-operand addition, use LEA.  */
-        if (a0 != a1) {
-            TCGArg c3 = 0;
-            if (const_a2) {
-                c3 = a2, a2 = -1;
-            } else if (a0 == a2) {
-                /* Watch out for dest = src + dest, since we've removed
-                   the matching constraint on the add.  */
-                tgen_arithr(s, ARITH_ADD + rexw, a0, a1);
-                break;
-            }
-
-            tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a2, 0, c3);
-            break;
-        }
-        c = ARITH_ADD;
-        goto gen_arith;
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
@@ -3599,10 +3615,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
-        return C_O1_I2(r, r, re);
-
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a0f050ff9c..08106b6e4c 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1274,6 +1274,24 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_add_w(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_add_d(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_add,
+    .out_rri = tcg_out_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1532,21 +1550,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_add_i32:
-        if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I32, a0, a1, a2);
-        } else {
-            tcg_out_opc_add_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_add_i64:
-        if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I64, a0, a1, a2);
-        } else {
-            tcg_out_opc_add_d(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_sub_i32:
         if (c2) {
             tcg_out_addi(s, TCG_TYPE_I32, a0, a1, -a2);
@@ -2281,11 +2284,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_add_i32:
-        return C_O1_I2(r, r, ri);
-    case INDEX_op_add_i64:
-        return C_O1_I2(r, r, rJ);
-
     case INDEX_op_and_i32:
     case INDEX_op_and_i64:
     case INDEX_op_nor_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 4d52e0bde0..263e7e66c9 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1655,6 +1655,28 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* Always indirect, nothing to do */
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_ADDU : OPC_DADDU;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_ADDIU : OPC_DADDIU;
+    tcg_out_opc_imm(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1727,12 +1749,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_add_i32:
-        i1 = OPC_ADDU, i2 = OPC_ADDIU;
-        goto do_binary;
-    case INDEX_op_add_i64:
-        i1 = OPC_DADDU, i2 = OPC_DADDIU;
-        goto do_binary;
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
         i1 = OPC_OR, i2 = OPC_ORI;
@@ -2159,9 +2175,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
-        return C_O1_I2(r, r, rJ);
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
         return C_O1_I2(r, rz, rN);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 11dcfe66f3..6b27238499 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2902,6 +2902,26 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, ADD | TAB(a0, a1, a2));
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mem_long(s, ADDI, ADD, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rT),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2971,15 +2991,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-        do_addi_32:
-            tcg_out_mem_long(s, ADDI, ADD, a0, a1, (int32_t)a2);
-        } else {
-            tcg_out32(s, ADD | TAB(a0, a1, a2));
-        }
-        break;
     case INDEX_op_sub_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[1]) {
@@ -2989,8 +3000,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                 tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
             }
         } else if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_32;
+            tgen_addi(s, type, a0, a1, (int32_t)-a2);
         } else {
             tcg_out32(s, SUBF | TAB(a0, a2, a1));
         }
@@ -3185,15 +3195,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, NOR | SAB(args[1], args[0], args[1]));
         break;
 
-    case INDEX_op_add_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-        do_addi_64:
-            tcg_out_mem_long(s, ADDI, ADD, a0, a1, a2);
-        } else {
-            tcg_out32(s, ADD | TAB(a0, a1, a2));
-        }
-        break;
     case INDEX_op_sub_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[1]) {
@@ -3203,8 +3204,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                 tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
             }
         } else if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_64;
+            tgen_addi(s, type, a0, a1, -a2);
         } else {
             tcg_out32(s, SUBF | TAB(a0, a2, a1));
         }
@@ -4129,7 +4129,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add_i32:
     case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
@@ -4176,8 +4175,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
         return C_O1_I2(r, rI, ri);
-    case INDEX_op_add_i64:
-        return C_O1_I2(r, r, rT);
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rU);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 6f9d87df48..135137ff53 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1957,6 +1957,28 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_ADDW : OPC_ADD;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_ADDIW : OPC_ADDI;
+    tcg_out_opc_imm(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2019,21 +2041,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_add_i32:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_ADDW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_add_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDI, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_ADD, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_sub_i32:
         if (c2) {
             tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, -a2);
@@ -2657,11 +2664,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_add_i32:
     case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_add_i64:
     case INDEX_op_and_i64:
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 30fa26e884..f5441d2033 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2145,6 +2145,58 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* no need to flush icache explicitly */
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (a0 != a1) {
+        tcg_out_insn(s, RX, LA, a0, a1, a2, 0);
+    } else if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RR, AR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRE, AGR, a0, a2);
+    }
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a0 == a1) {
+        if (type == TCG_TYPE_I32) {
+            if (a2 == (int16_t)a2) {
+                tcg_out_insn(s, RI, AHI, a0, a2);
+            } else {
+                tcg_out_insn(s, RIL, AFI, a0, a2);
+            }
+            return;
+        }
+        if (a2 == (int16_t)a2) {
+            tcg_out_insn(s, RI, AGHI, a0, a2);
+            return;
+        }
+        if (a2 == (int32_t)a2) {
+            tcg_out_insn(s, RIL, AGFI, a0, a2);
+            return;
+        }
+        if (a2 == (uint32_t)a2) {
+            tcg_out_insn(s, RIL, ALGFI, a0, a2);
+            return;
+        }
+        if (-a2 == (uint32_t)-a2) {
+            tcg_out_insn(s, RIL, SLGFI, a0, -a2);
+            return;
+        }
+    }
+    tcg_out_mem(s, RX_LA, RXY_LAY, a0, a1, TCG_REG_NONE, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
         case glue(glue(INDEX_op_,x),_i64)
@@ -2201,30 +2253,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add_i32:
-        a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
-        if (const_args[2]) {
-        do_addi_32:
-            if (a0 == a1) {
-                if (a2 == (int16_t)a2) {
-                    tcg_out_insn(s, RI, AHI, a0, a2);
-                    break;
-                }
-                tcg_out_insn(s, RIL, AFI, a0, a2);
-                break;
-            }
-            tcg_out_mem(s, RX_LA, RXY_LAY, a0, a1, TCG_REG_NONE, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RR, AR, a0, a2);
-        } else {
-            tcg_out_insn(s, RX, LA, a0, a1, a2, 0);
-        }
-        break;
     case INDEX_op_sub_i32:
-        a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_32;
+            tgen_addi(s, type, a0, a1, (int32_t)-a2);
         } else if (a0 == a1) {
             tcg_out_insn(s, RR, SR, a0, a2);
         } else {
@@ -2494,40 +2526,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-        do_addi_64:
-            if (a0 == a1) {
-                if (a2 == (int16_t)a2) {
-                    tcg_out_insn(s, RI, AGHI, a0, a2);
-                    break;
-                }
-                if (a2 == (int32_t)a2) {
-                    tcg_out_insn(s, RIL, AGFI, a0, a2);
-                    break;
-                }
-                if (a2 == (uint32_t)a2) {
-                    tcg_out_insn(s, RIL, ALGFI, a0, a2);
-                    break;
-                }
-                if (-a2 == (uint32_t)-a2) {
-                    tcg_out_insn(s, RIL, SLGFI, a0, -a2);
-                    break;
-                }
-            }
-            tcg_out_mem(s, RX_LA, RXY_LAY, a0, a1, TCG_REG_NONE, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RRE, AGR, a0, a2);
-        } else {
-            tcg_out_insn(s, RX, LA, a0, a1, a2, 0);
-        }
-        break;
     case INDEX_op_sub_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_64;
+            tgen_addi(s, type, a0, a1, -a2);
         } else {
             tcg_out_insn(s, RRFa, SGRK, a0, a1, a2);
         }
@@ -3253,8 +3255,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index cb5e8d554d..f43d95b025 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1285,6 +1285,26 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 {
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_ADD);
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_ADD);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1338,9 +1358,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_st32_i64:
         tcg_out_ldst(s, a0, a1, a2, STW);
         break;
-    OP_32_64(add):
-        c = ARITH_ADD;
-        goto gen_arith;
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
@@ -1564,8 +1581,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_div_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 9a5d3c2875..e6ec31e351 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -91,8 +91,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
@@ -643,6 +641,18 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* Always indirect, nothing to do */
 }
 
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_add_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_add,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -684,7 +694,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(add)
     CASE_32_64(sub)
     CASE_32_64(mul)
     CASE_32_64(and)
-- 
2.43.0


