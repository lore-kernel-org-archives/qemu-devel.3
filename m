Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B4BC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBi-0006O6-N0; Fri, 25 Apr 2025 18:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RBA-0004Ia-JB
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:53 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB4-0001uO-Fo
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:52 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso3815365b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618745; x=1746223545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgH31EIOoHZBtZMQ+xoW6soihNJSddCWtIN1WDBSFRs=;
 b=gAXdGoex5L9B+ovxOsp03sp4hEznhhp6VfGwierfamdvhta9z9TuB931M16LE74rjA
 Jb96Ir1dQ7K4ayTwzEgMzJ4NZRG4pXWn9bAxx1iN5bCX/cEwd2Ra+Dn7YJvKyfjbJvQy
 KWc9FML+Lg0BpGAcuPvbZjAWXqAONhn7ApVeFr0MPMjtjbAD9LDWWzvz4jEa4JJK9I0x
 GkSHJIRB7BMa0Awga3/fd4imuyZWzZLl2BvAKpSsNUt7h45pj0+FGFOpUQ6fOiOD6QUX
 DH7MtAJtcifBmx03deG2UCtzqb02uoF/kTaN1Q3njNjHpebj5rgacE9XldrEYier7til
 bdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618745; x=1746223545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pgH31EIOoHZBtZMQ+xoW6soihNJSddCWtIN1WDBSFRs=;
 b=vFPFHqYD8fyTm6LFTVSimAxZBsSV7aMQDN3ePvXxOvpXt/CXe8h+uLmZZpTzUg+kFB
 gmPisu82K8oPFKRKFu+U6D/4V3yifRJRYCH0VmlIGTsReEsYInxyyDgazeTpmx9Ut5KH
 kalXr1ZDIJzxQvDnhZ17xHJbiFLkJTU5cJZGq04H5Sa/vPeFv7YL/Dq0HiTRWJgPNUPD
 oxAcyalcPPqhXeRqZprZGd0mz6VTjVyIop+znV53O9eJOVSqpZhMWrG9s9VOubdoph8K
 3D9VjUYE5dBvPSSAaxFgIMtMyGCrspsiyoG4uXMr08rujcPbsecQVZq4tmXmexyoV/1J
 EgPQ==
X-Gm-Message-State: AOJu0YybUQGpxGEJQQzWaEF1Xg9zVIAGb+mgn/CfuFDP18gORdH4+rnl
 l9I9xcf/TZzLBQrX85rTvtugwTrd3mtP+H5f56C+93AFPijDdFvh8tQSwYP7Z9y3gcXmg8TfbT2
 g
X-Gm-Gg: ASbGncsJQbmC8N67jEKtU/Q6GC3DcASlSW75/GmftV+FhFRPfZ63Ra1lPK7I/9T1LLM
 DX0Y7tpabEvt/+lxVguXbFLF3/Ll0f9q5LrQPvZD9MYN87NQtTCrGOixh5AgrHKIYr6ZzKaCsml
 Jf9bpqg46BwmKfyfpFZgaynbwR+RPujk12t0/PW9DoOcedwcej+g/NefUtWJCrPeSlWCd4Mr2pk
 fKcxjgr2bfYCQCHN6dxZC7+dtj6mq6z/bOI4ZuZoqtq/gkA7E1fuOHNkWziTOb4heuwFJLbgd3a
 MC645o84umoGy2DxAERP0xsnVOwkn6z5J51vytJeCSBztvS7ZEqhWA9gvrKJ3sDXh7M+G3OZXiE
 =
X-Google-Smtp-Source: AGHT+IGMeJ1BxJboyyO8ypMocbAEiSMq2wyaiIEWXJejm/GwFsxnj9I/T5xS19coc8vNYQVzEA1TVw==
X-Received: by 2002:a05:6a00:1742:b0:736:5822:74b4 with SMTP id
 d2e1a72fcca58-73fd8f4e0c7mr5357603b3a.21.1745618744804; 
 Fri, 25 Apr 2025 15:05:44 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 149/159] tcg: Formalize tcg_out_goto_ptr
Date: Fri, 25 Apr 2025 14:54:43 -0700
Message-ID: <20250425215454.886111-150-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Split these functions out from tcg_out_op.
Define outop_goto_ptr generically.
Call tcg_out_goto_ptr from tcg_reg_alloc_op.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 12 ++++++++++++
 tcg/aarch64/tcg-target.c.inc     | 12 +++++-------
 tcg/arm/tcg-target.c.inc         | 12 +++++-------
 tcg/i386/tcg-target.c.inc        | 13 ++++++-------
 tcg/loongarch64/tcg-target.c.inc | 12 +++++-------
 tcg/mips/tcg-target.c.inc        | 22 ++++++++++------------
 tcg/ppc/tcg-target.c.inc         | 15 +++++++--------
 tcg/riscv/tcg-target.c.inc       | 12 +++++-------
 tcg/s390x/tcg-target.c.inc       | 15 +++++----------
 tcg/sparc64/tcg-target.c.inc     | 14 ++++++--------
 tcg/tci/tcg-target.c.inc         | 12 +++++-------
 11 files changed, 71 insertions(+), 80 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index fbb1a43efc..5ab4f5e752 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -133,6 +133,7 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg, TCGReg, tcg_target_long);
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2);
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg);
 static void tcg_out_goto_tb(TCGContext *s, int which);
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg dest);
 static void tcg_out_mb(TCGContext *s, unsigned bar);
 static void tcg_out_br(TCGContext *s, TCGLabel *l);
 static void tcg_out_set_carry(TCGContext *s);
@@ -1137,6 +1138,10 @@ static const TCGOutOpUnary outop_extrl_i64_i32 = {
 };
 #endif
 
+static const TCGOutOp outop_goto_ptr = {
+    .static_constraint = C_O0_I1(r),
+};
+
 /*
  * Register V as the TCGOutOp for O.
  * This verifies that V is of type T, otherwise give a nice compiler error.
@@ -1198,6 +1203,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_subb1o, TCGOutOpAddSubCarry, outop_subbio),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 
+    [INDEX_op_goto_ptr] = &outop_goto_ptr,
+
 #if TCG_TARGET_REG_BITS == 32
     OUTOP(INDEX_op_brcond2_i32, TCGOutOpBrcond2, outop_brcond2),
     OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
@@ -5823,6 +5830,11 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         g_assert_not_reached();
 #endif
 
+    case INDEX_op_goto_ptr:
+        tcg_debug_assert(!const_args[0]);
+        tcg_out_goto_ptr(s, new_args[0]);
+        break;
+
     default:
         if (def->flags & TCG_OPF_VECTOR) {
             tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index fceb6e2796..2678e1f176 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1986,6 +1986,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     tcg_out_bti(s, BTI_J);
 }
 
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    tcg_out_insn(s, 3207, BR, a0);
+}
+
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
                               uintptr_t jmp_rx, uintptr_t jmp_rw)
 {
@@ -2775,10 +2780,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     TCGArg a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_goto_ptr:
-        tcg_out_insn(s, 3207, BR, a0);
-        break;
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
         tcg_out_ldst(s, I3312_LDRB, a0, a1, a2, 0);
@@ -3293,9 +3294,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_goto_ptr:
-        return C_O0_I1(r);
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld16u_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 327b01d377..64be0a7e6d 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1795,6 +1795,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     set_jmp_reset_offset(s, which);
 }
 
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    tcg_out_b_reg(s, COND_AL, a0);
+}
+
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
                               uintptr_t jmp_rx, uintptr_t jmp_rw)
 {
@@ -2524,10 +2529,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_goto_ptr:
-        tcg_out_b_reg(s, COND_AL, args[0]);
-        break;
-
     case INDEX_op_ld8u_i32:
         tcg_out_ld8u(s, COND_AL, args[0], args[1], args[2]);
         break;
@@ -2579,9 +2580,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_goto_ptr:
-        return C_O0_I1(r);
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld16u_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index f89982378b..5ea4a44264 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2593,6 +2593,12 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     set_jmp_reset_offset(s, which);
 }
 
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    /* Jump to the given host address (could be epilogue) */
+    tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, a0);
+}
+
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
                               uintptr_t jmp_rx, uintptr_t jmp_rw)
 {
@@ -3437,10 +3443,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
 
     switch (opc) {
-    case INDEX_op_goto_ptr:
-        /* jmp to the given host address (could be epilogue) */
-        tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, a0);
-        break;
     OP_32_64(ld8u):
         /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
         tcg_out_modrm_offset(s, OPC_MOVZBL, a0, a1, a2);
@@ -4093,9 +4095,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_goto_ptr:
-        return C_O0_I1(r);
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index cbdc42c157..d89c27c67f 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1307,6 +1307,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     set_jmp_reset_offset(s, which);
 }
 
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    tcg_out_opc_jirl(s, TCG_REG_ZERO, a0, 0);
+}
+
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
                               uintptr_t jmp_rx, uintptr_t jmp_rw)
 {
@@ -1923,10 +1928,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a3 = args[3];
 
     switch (opc) {
-    case INDEX_op_goto_ptr:
-        tcg_out_opc_jirl(s, TCG_REG_ZERO, a0, 0);
-        break;
-
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
         tcg_out_ldst(s, OPC_LD_B, a0, a1, a2);
@@ -2491,9 +2492,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_goto_ptr:
-        return C_O0_I1(r);
-
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
     case INDEX_op_st16_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f4d6ee10b9..9455a0a17b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1571,6 +1571,16 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     }
 }
 
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    tcg_out_opc_reg(s, OPC_JR, 0, a0, 0);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, a0);
+    } else {
+        tcg_out_nop(s);
+    }
+}
+
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
                               uintptr_t jmp_rx, uintptr_t jmp_rw)
 {
@@ -2277,15 +2287,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_goto_ptr:
-        /* jmp to the given host address (could be epilogue) */
-        tcg_out_opc_reg(s, OPC_JR, 0, a0, 0);
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, a0);
-        } else {
-            tcg_out_nop(s);
-        }
-        break;
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
         i1 = OPC_LBU;
@@ -2364,9 +2365,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_goto_ptr:
-        return C_O0_I1(r);
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld16u_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index d88ec8d690..a2a5b1e570 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2843,6 +2843,13 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     set_jmp_reset_offset(s, which);
 }
 
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    tcg_out32(s, MTSPR | RS(a0) | CTR);
+    tcg_out32(s, ADDI | TAI(TCG_REG_R3, 0, 0));
+    tcg_out32(s, BCCTR | BO_ALWAYS);
+}
+
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
                               uintptr_t jmp_rx, uintptr_t jmp_rw)
 {
@@ -3676,11 +3683,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_goto_ptr:
-        tcg_out32(s, MTSPR | RS(args[0]) | CTR);
-        tcg_out32(s, ADDI | TAI(TCG_REG_R3, 0, 0));
-        tcg_out32(s, BCCTR | BO_ALWAYS);
-        break;
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
         tcg_out_mem_long(s, LBZ, LBZX, args[0], args[1], args[2]);
@@ -4371,9 +4373,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_goto_ptr:
-        return C_O0_I1(r);
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld16u_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 5d8d8213cb..c1bfd93569 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1915,6 +1915,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     set_jmp_reset_offset(s, which);
 }
 
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, a0, 0);
+}
+
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
                               uintptr_t jmp_rx, uintptr_t jmp_rw)
 {
@@ -2535,10 +2540,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_goto_ptr:
-        tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, a0, 0);
-        break;
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
         tcg_out_ldst(s, OPC_LBU, a0, a1, a2);
@@ -2824,9 +2825,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_goto_ptr:
-        return C_O0_I1(r);
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld16u_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index cdc61de4f8..2b2e00c609 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2213,6 +2213,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     set_jmp_reset_offset(s, which);
 }
 
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, a0);
+}
+
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
                               uintptr_t jmp_rx, uintptr_t jmp_rw)
 {
@@ -3033,14 +3038,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0;
-
     switch (opc) {
-    case INDEX_op_goto_ptr:
-        a0 = args[0];
-        tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, a0);
-        break;
-
     OP_32_64(ld8u):
         /* ??? LLC (RXY format) is only present with the extended-immediate
            facility, whereas LLGC is always present.  */
@@ -3567,9 +3565,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_goto_ptr:
-        return C_O0_I1(r);
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 0cc7567786..208b96487e 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1300,6 +1300,12 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     }
 }
 
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    tcg_out_arithi(s, TCG_REG_G0, a0, 0, JMPL);
+    tcg_out_mov_delay(s, TCG_REG_TB, a0);
+}
+
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
                               uintptr_t jmp_rx, uintptr_t jmp_rw)
 {
@@ -1968,11 +1974,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     a2 = args[2];
 
     switch (opc) {
-    case INDEX_op_goto_ptr:
-        tcg_out_arithi(s, TCG_REG_G0, a0, 0, JMPL);
-        tcg_out_mov_delay(s, TCG_REG_TB, a0);
-        break;
-
 #define OP_32_64(x)                             \
         glue(glue(case INDEX_op_, x), _i32):    \
         glue(glue(case INDEX_op_, x), _i64)
@@ -2039,9 +2040,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_goto_ptr:
-        return C_O0_I1(r);
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 55a1a74fb6..d9cd62ed3d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -40,9 +40,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_goto_ptr:
-        return C_O0_I1(r);
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld16u_i32:
@@ -534,6 +531,11 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     set_jmp_reset_offset(s, which);
 }
 
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    tcg_out_op_r(s, INDEX_op_goto_ptr, a0);
+}
+
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
                               uintptr_t jmp_rx, uintptr_t jmp_rw)
 {
@@ -1146,10 +1148,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     switch (opc) {
-    case INDEX_op_goto_ptr:
-        tcg_out_op_r(s, opc, args[0]);
-        break;
-
     CASE_32_64(ld8u)
     CASE_32_64(ld8s)
     CASE_32_64(ld16u)
-- 
2.43.0


