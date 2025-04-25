Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4F0C3ABA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8REN-0002ve-Cv; Fri, 25 Apr 2025 18:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB7-00049T-GU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:50 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB3-0001uB-UL
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:49 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so3020737b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618744; x=1746223544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuQpIoNlf+pIMrqTZDf6L1hdTZVSvMuz91nTWVKNIaM=;
 b=hSG5ALE68kZLYfk6L2nlFKdrBtRqVhRoyGqFSrxBtdH+O2dHilKzjzu6r5l5jgIlSz
 gZyeF1lpIj0YnMQ7EvKzCgxuybB1mYXwshGXRMp4T6o3sBOcRRSyFKCOViFMtTfFF0G5
 k6ifSIT4cIftiDN5Ttca8uisWvY9ge5kZRSpP5rdj9dvimLtKDhlh1BChRwwXpl9SfoP
 EVMWF26ekOfq2b5GGCTfh5yc92iiF2iN0QcsTxreVoWT9tydcQ7mz6xvYmZZwMHEzETs
 GKYd8sNP2bJPOm2Ei0H3XusShTo8aw9Vu43lPTqAgG6YY2cjPje2Rh5SN8WSJ4aidVUm
 vVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618744; x=1746223544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuQpIoNlf+pIMrqTZDf6L1hdTZVSvMuz91nTWVKNIaM=;
 b=TiCZ2DMDWmatzSSmQyAt+GFt+1NCaxqpUf25mNqPGJuN5YmfY6yY7cN5zu4sW8EeVv
 26mUrVGBvTpc+VHaYN7ILGBjqsax5UvVHTNUYwFyPKr8gO+6KpKCPx62fD7Y7i1BPqg9
 9hAMbsHTSf7mtTbj1HX/2uh8K7Z4g9gRJS1dtO7NVdSEn4LpURaIjqYRtdMtDdgyRQxH
 FbhdJKZpluSD0aJANtSsj4P546hSTd9nrIM+1bOqM9n/ZbUQmJIFtuFVOHZZW8pVWaSe
 AjEbRcsleGXelqZZtAUGOaHzn5XXpGoZ5ASoJT1GVxpfhfJm++Sav9qarayw/ZAoNMTs
 MDaw==
X-Gm-Message-State: AOJu0YyW6udZItzHeGSurP0fdq/1e3HOBQb6HfYTZniVy4t0VQWOCzLO
 P1T1LlsA1xyjj4sSN6gud7GXTSih+wHPBZtkl4AYrXu4sYeAKNywlBEf9dx2p+MBqU9JQfVZius
 u
X-Gm-Gg: ASbGncusYC14bideaDcLJy5/2kT5RuXnGlJ+mKjQXZ6X3LPTVGX2tAazWZoNoZwmsWN
 TdFyZEztnu8Y0OHIUOacvC4z78LNTzwz2UwHC2PiVdDI/xkAovIMojFaDyyiPclwmN3mii0hokt
 82APVxXruCn0MkO/Vc0Gfh18olbneVxO7i8i/a1ZjzgjsNK+WYH/fW6r6Dn8tsuOJbM2a8a57wD
 D6GJyJXENZXFlpRXD1Ky6NKHchegKANyhCzvLQZGlbeqbO5K93hRxewdQsK4hGjiwx2IYimnswK
 QbJzBRAOlfnyeEVOC3OBzBzKbxWNFDPKjeqok7umECC0FO0AueLRew2EyxH3MwWANWRtTU9M4XU
 =
X-Google-Smtp-Source: AGHT+IG2yY+6jr2ONStivXZaLP+29SQcxO1VSAupP7eLnDdBP7qVps8TkT/27Dq+7VcvrARMKVuftg==
X-Received: by 2002:a05:6a00:3e2a:b0:736:34a2:8a23 with SMTP id
 d2e1a72fcca58-73fd896a139mr4589747b3a.15.1745618744165; 
 Fri, 25 Apr 2025 15:05:44 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 148/159] tcg: Formalize tcg_out_br
Date: Fri, 25 Apr 2025 14:54:42 -0700
Message-ID: <20250425215454.886111-149-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index e7478bef77..fbb1a43efc 100644
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
@@ -6900,6 +6901,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
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
index 131901dabc..327b01d377 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1203,6 +1203,11 @@ static void tcg_out_goto_label(TCGContext *s, ARMCond cond, TCGLabel *l)
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
@@ -2522,9 +2527,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_goto_ptr:
         tcg_out_b_reg(s, COND_AL, args[0]);
         break;
-    case INDEX_op_br:
-        tcg_out_goto_label(s, COND_AL, arg_label(args[0]));
-        break;
 
     case INDEX_op_ld8u_i32:
         tcg_out_ld8u(s, COND_AL, args[0], args[1], args[2]);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index bf84f9f455..f89982378b 100644
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
index 1ad577ad8d..cbdc42c157 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -756,6 +756,12 @@ static const TCGOutOpMovcond outop_movcond = {
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
@@ -1921,12 +1927,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
index b0da661561..f4d6ee10b9 100644
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
@@ -2281,11 +2286,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
index 7754627a5d..0cc7567786 100644
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
@@ -1966,10 +1972,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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


