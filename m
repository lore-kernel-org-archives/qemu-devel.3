Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C36C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyf-0008JG-CB; Sun, 16 Feb 2025 18:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnww-0004cZ-HK
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:22 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwm-0006Uj-Pk
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:21 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fc11834404so5076031a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748069; x=1740352869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JkSxvdKPKBucvNFks+Wou7/OF+ISSUIc8+NEOMbPQsM=;
 b=ttkTJ4hxB6yQYUr2Ys71pRgh4pAUk5ZtqSKTIy/Z+XyMJA0sjIdC9MIMAWz1L4Mr3R
 T8rIcM4p1jONBWGIoc1OkPHiKb24/b7tOOS+qFqCmlapnI9NRKO3o9XEfJrrLFliRQBN
 8mkbu83JOAvHi91zcY8k1+oBN4/H7p/HyrKfJLlJM2yVx/QtrSHGLisbrTUsmRWZPGey
 ob/CBXd+MaC2y3e1S8ntf63GYw25Vo6LEUEAiXihCk81iv0Ez0fmHWXw5PSOuT+u2LEH
 KUL+btZZm8G9x4yFpp9O8/9zBK/BeiFJocKltrImGs/G92lw7OvVET/ftnMkal6Wnd5O
 6PSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748069; x=1740352869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JkSxvdKPKBucvNFks+Wou7/OF+ISSUIc8+NEOMbPQsM=;
 b=W+TzUYhxUKls/XU0P6V4eRDpj3VVSII4n0xpKDZs9fd8WKUKJ8suGKiHfGZuQsOM/K
 YFt0ULXUXPMv7Udy0oWXvcYt8V1xxMXDTBb2JSZcT7qMuOTA1Jo/LSlcRmJ3yqy8Hzz0
 qReonvj5GniZOQK/42LJ+VelnDkqr0BP48hShdDb8HbkiuefAN3C5PG6r2cn8YMYMMBX
 pbTcgTDnyeVslnDsqTHUgUeG2zr7jm3yvs1JmLArmtw2eGgnyoZLC+pBxVaNACUIDVbD
 j9+8jGyHch/ssezJBzd+z6N5m2R8JSkIIBtvFup6Hdkb2Q1PImrtXv+AUg2ooRFm0G3o
 L37A==
X-Gm-Message-State: AOJu0YzOoyVwkiE3RFSI+vzM40EuWsz2lk9xemk7sgg32XCWx+Vf2wH6
 I7m3U4zK+qnSnP1batEDeQb/PVp7RXwrxoX8oA1E/z61CR1IfhFlMNTJBuh6uBrs3Hy4Jww/Ugt
 A
X-Gm-Gg: ASbGncuT4H/hK2Ie2U2JbxmZU016Sqx/Wg51uzNAdo9JB8+AiCf4e1FEoJERD168HhP
 1s7M8EwksTcnm+rfGqXuXwliAjgWST8iv9VissFMcIx/pRwH7EvCaJ9VEeKMxWaY0GyoG/DMtJ1
 xaia+VUomXQrcCJMU41ut+PrR5Rsf1x6/PzQ0EIYEkQf8ZQn0mvjoeaSuHfDxO3YXc6Xd++ujbP
 j9tMsowPWeUaWXFhu7irJziqq45Yi/xemECkMBYp5pn8ru/1p9CXYNiqghqXt6dYJ4NHD30M+dA
 xCFwLs9xSfEgWpceTt5D4vXwwP2vLZyN/ktecwCqlAAJ8Ow=
X-Google-Smtp-Source: AGHT+IE52qmZTGJiXNPWKjs0oS42hsomwMFRDJmqm4Aa/wUDrnG4Ikv1mio67e+XAJ3OP9/GZsjGVw==
X-Received: by 2002:a17:90b:3949:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-2fc4104516dmr11164228a91.28.1739748069265; 
 Sun, 16 Feb 2025 15:21:09 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 150/162] tcg: Formalize tcg_out_br
Date: Sun, 16 Feb 2025 15:09:59 -0800
Message-ID: <20250216231012.2808572-151-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
Call it directly from tcg_gen_code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        |  4 ++++
 tcg/aarch64/tcg-target.c.inc     |  6 +-----
 tcg/arm/tcg-target.c.inc         |  8 +++++---
 tcg/i386/tcg-target.c.inc        |  8 +++++---
 tcg/loongarch64/tcg-target.c.inc | 12 ++++++------
 tcg/mips/tcg-target.c.inc        | 10 +++++-----
 tcg/ppc/tcg-target.c.inc         | 26 ++++++++++++--------------
 tcg/riscv/tcg-target.c.inc       | 11 ++++++-----
 tcg/s390x/tcg-target.c.inc       |  9 +++++----
 tcg/sparc64/tcg-target.c.inc     | 10 ++++++----
 tcg/tci/tcg-target.c.inc         |  9 +++++----
 11 files changed, 60 insertions(+), 53 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2f203af7c0..9106413876 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -134,6 +134,7 @@ static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2);
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg);
 static void tcg_out_goto_tb(TCGContext *s, int which);
 static void tcg_out_mb(TCGContext *s, unsigned bar);
+static void tcg_out_br(TCGContext *s, TCGLabel *l);
 static void tcg_out_set_carry(TCGContext *s);
 static void tcg_out_set_borrow(TCGContext *s);
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
@@ -6861,6 +6862,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         case INDEX_op_goto_tb:
             tcg_out_goto_tb(s, op->args[0]);
             break;
+        case INDEX_op_br:
+            tcg_out_br(s, arg_label(op->args[0]));
+            break;
         case INDEX_op_mb:
             tcg_out_mb(s, op->args[0]);
             break;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index d2babd9bab..fceb6e2796 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1407,7 +1407,7 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target,
     tcg_out_call_int(s, target);
 }
 
-static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
+static void tcg_out_br(TCGContext *s, TCGLabel *l)
 {
     if (!l->has_value) {
         tcg_out_reloc(s, s->code_ptr, R_AARCH64_JUMP26, l, 0);
@@ -2779,10 +2779,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3207, BR, a0);
         break;
 
-    case INDEX_op_br:
-        tcg_out_goto_label(s, arg_label(a0));
-        break;
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
         tcg_out_ldst(s, I3312_LDRB, a0, a1, a2, 0);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index f903929ad5..dfeadc9a22 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1209,6 +1209,11 @@ static void tcg_out_goto_label(TCGContext *s, ARMCond cond, TCGLabel *l)
     }
 }
 
+static void tcg_out_br(TCGContext *s, TCGLabel *l)
+{
+    tcg_out_goto_label(s, COND_AL, l);
+}
+
 static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     if (use_armv7_instructions) {
@@ -2528,9 +2533,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_goto_ptr:
         tcg_out_b_reg(s, COND_AL, args[0]);
         break;
-    case INDEX_op_br:
-        tcg_out_goto_label(s, COND_AL, arg_label(args[0]));
-        break;
 
     case INDEX_op_ld8u_i32:
         tcg_out_ld8u(s, COND_AL, args[0], args[1], args[2]);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 8bff8710b0..305280bf6c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1546,6 +1546,11 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
     }
 }
 
+static void tcg_out_br(TCGContext *s, TCGLabel *l)
+{
+    tcg_out_jxx(s, JCC_JMP, l, 0);
+}
+
 static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
                        TCGArg arg2, int const_arg2, int rexw)
 {
@@ -3436,9 +3441,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         /* jmp to the given host address (could be epilogue) */
         tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, a0);
         break;
-    case INDEX_op_br:
-        tcg_out_jxx(s, JCC_JMP, arg_label(a0), 0);
-        break;
     OP_32_64(ld8u):
         /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
         tcg_out_modrm_offset(s, OPC_MOVZBL, a0, a1, a2);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index b9b05b8c25..78d1542153 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -744,6 +744,12 @@ static const TCGOutOpMovcond outop_movcond = {
  * Branch helpers
  */
 
+static void tcg_out_br(TCGContext *s, TCGLabel *l)
+{
+    tcg_out_reloc(s, s->code_ptr, R_LOONGARCH_BR_SD10K16, l, 0);
+    tcg_out_opc_b(s, 0);
+}
+
 static const struct {
     LoongArchInsn op;
     bool swap;
@@ -1909,12 +1915,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_jirl(s, TCG_REG_ZERO, a0, 0);
         break;
 
-    case INDEX_op_br:
-        tcg_out_reloc(s, s->code_ptr, R_LOONGARCH_BR_SD10K16, arg_label(a0),
-                      0);
-        tcg_out_opc_b(s, 0);
-        break;
-
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
         tcg_out_ldst(s, OPC_LD_B, a0, a1, a2);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 0ace175da3..56c6e6e3e1 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -921,6 +921,11 @@ static const TCGOutOpBrcond outop_brcond = {
     .out_rr = tgen_brcond,
 };
 
+void tcg_out_br(TCGContext *s, TCGLabel *l)
+{
+    tgen_brcond(s, TCG_TYPE_I32, TCG_COND_EQ, TCG_REG_ZERO, TCG_REG_ZERO, l);
+}
+
 static int tcg_out_setcond2_int(TCGContext *s, TCGCond cond, TCGReg ret,
                                 TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
 {
@@ -2287,11 +2292,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out_nop(s);
         }
         break;
-    case INDEX_op_br:
-        tgen_brcond(s, TCG_TYPE_I32, TCG_COND_EQ,
-                    TCG_REG_ZERO, TCG_REG_ZERO, arg_label(a0));
-        break;
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
         i1 = OPC_LBU;
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index ae18c84ae6..d88ec8d690 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1990,6 +1990,18 @@ static const TCGOutOpSetcond outop_negsetcond = {
     .out_rri = tgen_negsetcondi,
 };
 
+void tcg_out_br(TCGContext *s, TCGLabel *l)
+{
+    uint32_t insn = B;
+
+    if (l->has_value) {
+        insn |= reloc_pc24_val(tcg_splitwx_to_rx(s->code_ptr), l->u.value_ptr);
+    } else {
+        tcg_out_reloc(s, s->code_ptr, R_PPC_REL24, l, 0);
+    }
+    tcg_out32(s, insn);
+}
+
 static void tcg_out_bc(TCGContext *s, TCGCond cond, int bd)
 {
     tcg_out32(s, tcg_to_bc[cond] | bd);
@@ -3669,20 +3681,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, ADDI | TAI(TCG_REG_R3, 0, 0));
         tcg_out32(s, BCCTR | BO_ALWAYS);
         break;
-    case INDEX_op_br:
-        {
-            TCGLabel *l = arg_label(args[0]);
-            uint32_t insn = B;
-
-            if (l->has_value) {
-                insn |= reloc_pc24_val(tcg_splitwx_to_rx(s->code_ptr),
-                                       l->u.value_ptr);
-            } else {
-                tcg_out_reloc(s, s->code_ptr, R_PPC_REL24, l, 0);
-            }
-            tcg_out32(s, insn);
-        }
-        break;
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
         tcg_out_mem_long(s, LBZ, LBZX, args[0], args[1], args[2]);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index df271752b7..5d8d8213cb 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1107,6 +1107,12 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
 }
 
+static void tcg_out_br(TCGContext *s, TCGLabel *l)
+{
+    tcg_out_reloc(s, s->code_ptr, R_RISCV_JAL, l, 0);
+    tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, 0);
+}
+
 static const struct {
     RISCVInsn op;
     bool swap;
@@ -2533,11 +2539,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, a0, 0);
         break;
 
-    case INDEX_op_br:
-        tcg_out_reloc(s, s->code_ptr, R_RISCV_JAL, arg_label(a0), 0);
-        tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, 0);
-        break;
-
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
         tcg_out_ldst(s, OPC_LBU, a0, a1, a2);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 020d8ba73f..cdc61de4f8 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1689,6 +1689,11 @@ static void tgen_branch(TCGContext *s, int cc, TCGLabel *l)
     }
 }
 
+static void tcg_out_br(TCGContext *s, TCGLabel *l)
+{
+    tgen_branch(s, S390_CC_ALWAYS, l);
+}
+
 static void tgen_compare_branch(TCGContext *s, S390Opcode opc, int cc,
                                 TCGReg r1, TCGReg r2, TCGLabel *l)
 {
@@ -3075,10 +3080,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_br:
-        tgen_branch(s, S390_CC_ALWAYS, arg_label(args[0]));
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], args[1], args[2], TCG_TYPE_I32);
         break;
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 56b68fe841..e4073b7732 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -641,6 +641,12 @@ static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
     tcg_out_bpcc0(s, scond, flags, off19);
 }
 
+static void tcg_out_br(TCGContext *s, TCGLabel *l)
+{
+    tcg_out_bpcc(s, COND_A, BPCC_PT, l);
+    tcg_out_nop(s);
+}
+
 static void tcg_out_cmp(TCGContext *s, TCGCond cond,
                         TCGReg c1, int32_t c2, int c2const)
 {
@@ -1961,10 +1967,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_arithi(s, TCG_REG_G0, a0, 0, JMPL);
         tcg_out_mov_delay(s, TCG_REG_TB, a0);
         break;
-    case INDEX_op_br:
-        tcg_out_bpcc(s, COND_A, BPCC_PT, arg_label(a0));
-        tcg_out_nop(s);
-        break;
 
 #define OP_32_64(x)                             \
         glue(glue(case INDEX_op_, x), _i32):    \
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 64d4ac07cd..55a1a74fb6 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1136,6 +1136,11 @@ static void tcg_out_mb(TCGContext *s, unsigned a0)
     tcg_out_op_v(s, INDEX_op_mb);
 }
 
+static void tcg_out_br(TCGContext *s, TCGLabel *l)
+{
+    tcg_out_op_l(s, INDEX_op_br, l);
+}
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1145,10 +1150,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_r(s, opc, args[0]);
         break;
 
-    case INDEX_op_br:
-        tcg_out_op_l(s, opc, arg_label(args[0]));
-        break;
-
     CASE_32_64(ld8u)
     CASE_32_64(ld8s)
     CASE_32_64(ld16u)
-- 
2.43.0


