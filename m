Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A05C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmp-0005o1-Bk; Sun, 16 Feb 2025 18:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmN-0005Vu-MS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:28 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmK-0005DN-Sb
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:27 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220c8f38febso67431695ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747423; x=1740352223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Er23FRZD2s6MKUIrzr46nVEECMUwuWF4N+SbgNJbwto=;
 b=q/tjwOb6vZMXz6qI1SBddi6tC4soC3vaDOPcphwoztFfsdpvStYvlowkenGo4L7iiN
 eG6Aewqn8j8TuDoJuBYMRAfQwCXxlGcnLaxxSsemp8U7GBSA6BY75Rmr8sZ9Qm6pt6Zm
 7wrunSnzhRy8PUFhDXulCsBDVAY70MLmA96Ui+cRowGj8XVPJ5RwGcWEIuzBi3nbDNyd
 nV5Asr1PN4an5vtfCbKp/8Ft3JxI7igrF9mitSjNnc8CFFMDIM6yHh6M0zgR9LFGujlm
 ADRVQNR4P5z4J/TT+XxQe4t4FA0sk6jtWnBR6FTfpOfpZ2oovSOdbCSMtDOZGZTf4b88
 qAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747423; x=1740352223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Er23FRZD2s6MKUIrzr46nVEECMUwuWF4N+SbgNJbwto=;
 b=xOpkK8yyASknKsLG7DOAUaDHoovGZDYZTF6DyOFfBu9Uk2UULWinRJuUwRtqNeybz6
 LmZ0Br5hPx+6Gj5zShiL4S3McmHEmHaz5R4XQFSs1o6w5nFeAnmlF/WUDlB/ereOZ9TY
 UcApmAk0PQO/0XJZ3J4txlztfLgptuC4FiAAcjMx49AwH76xMshNR0ApfljiEzmaXuNI
 uIWLDaI/YilE4PUUukKuqoVZ/m1imkg421Om/ltnwSryhH6/yqptxqgE2FOQaayBrFdU
 y1wUjQXiJ7PBzbXuuO0hGqHkwr+wq7CmLMzMbtIAQr/HUiYIuarpr343ha7n+VQmQ4dJ
 bvUA==
X-Gm-Message-State: AOJu0YzmQkfdO22TYjwiXts+pp842w9T+P7AUtw93z+ePRZsmVf+G/bG
 g7jsv9dr+MsWUCtwqgRucTLAGci+CThvYxpvwAWmvg3qFqzRJg/ReEYfRZfKQm9tkImCufTPicl
 +
X-Gm-Gg: ASbGncvPz9Ix9tpB3AnL2iGg3bIKcLNTvrKHwYuJ1YgImXngWRJthvRxt9fPPprtpz4
 Q2H88wtiDSAGhUVluHkde0mYDg7WzDV7QGSofA2eE4V2MTULhZGopIUEG/q5WJRbyuDYdiFI6RO
 oV37BcrUnGnWaC93+NgDnRtzICLr7g28lgA95f8AtEq22b+2S5eqZc2214+jvX8JbPw1wpHA767
 L/egtecVIsD0LJ1DFv/kw3mG9Ol99SKPyI/dCT9SRsjF7Le7i/nS0FcRWMB3fyQC5fMLYDhXa67
 uJJ/j1bQud2rHcgh5Jz0CWjKr0DtICHKMoleBWmZudMgqv4=
X-Google-Smtp-Source: AGHT+IH/kpYPtt5lUMkQiIdoNZ8XnybDCqo3/K81nfFuC6U/Y6D8u/m2++AuRMxuKXEwch2xMkdspA==
X-Received: by 2002:a17:903:41c8:b0:216:3466:7414 with SMTP id
 d9443c01a7336-221040bcc46mr136161645ad.44.1739747423122; 
 Sun, 16 Feb 2025 15:10:23 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 012/162] tcg: Convert or to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:07:41 -0800
Message-ID: <20250216231012.2808572-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        |  4 +++
 tcg/aarch64/tcg-target.c.inc     | 31 ++++++++++++---------
 tcg/arm/tcg-target.c.inc         | 24 ++++++++++++----
 tcg/i386/tcg-target.c.inc        | 25 +++++++++++++----
 tcg/loongarch64/tcg-target.c.inc | 29 ++++++++++++--------
 tcg/mips/tcg-target.c.inc        | 25 ++++++++++++-----
 tcg/ppc/tcg-target.c.inc         | 29 ++++++++++++--------
 tcg/riscv/tcg-target.c.inc       | 29 ++++++++++++--------
 tcg/s390x/tcg-target.c.inc       | 47 +++++++++++++++++---------------
 tcg/sparc64/tcg-target.c.inc     | 23 ++++++++++++----
 tcg/tci/tcg-target.c.inc         | 14 ++++++++--
 11 files changed, 186 insertions(+), 94 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7f164ca3e4..8edbb98596 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1007,6 +1007,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
+    OUTOP(INDEX_op_or_i32, TCGOutOpBinary, outop_or),
+    OUTOP(INDEX_op_or_i64, TCGOutOpBinary, outop_or),
 };
 
 #undef OUTOP
@@ -5435,6 +5437,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index c7167cad15..4b62e4e382 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2157,6 +2157,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3510, ORR, type, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_logicali(s, I3404_ORRI, type, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rL),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2238,17 +2256,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_or_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_or_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_ORRI, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3510, ORR, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_orc_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -3016,8 +3023,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
     case INDEX_op_orc_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 3220b16945..cd9010a357 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1887,6 +1887,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_ORR, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_imm(s, COND_AL, ARITH_ORR, a0, a1, encode_imm_nofail(a2));
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1949,13 +1967,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             args[0], args[1], args[2], const_args[2]);
         }
         break;
-    case INDEX_op_or_i32:
-        c = ARITH_ORR;
-        goto gen_arith;
     case INDEX_op_xor_i32:
         c = ARITH_EOR;
-        /* Fall through.  */
-    gen_arith:
         tcg_out_dat_rI(s, COND_AL, c, args[0], args[1], args[2], const_args[2]);
         break;
     case INDEX_op_add2_i32:
@@ -2215,7 +2228,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
 
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
         return C_O1_I2(r, r, rI);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index f67ecf01ba..3e974924d4 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2633,6 +2633,26 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_OR + rexw, a0, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_OR + rexw, a0, a2, 0);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2717,9 +2737,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(or):
-        c = ARITH_OR;
-        goto gen_arith;
     OP_32_64(xor):
         c = ARITH_XOR;
         goto gen_arith;
@@ -3645,8 +3662,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, 0, re);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c2b5a36aef..2853563405 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1320,6 +1320,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_or(s, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_ori(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1380,15 +1398,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-        if (c2) {
-            tcg_out_opc_ori(s, a0, a1, a2);
-        } else {
-            tcg_out_opc_or(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         if (c2) {
@@ -2294,8 +2303,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         /* LoongArch reg-imm bitops have their imms ZERO-extended */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ab57c78095..74eef1d3b3 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1712,6 +1712,24 @@ static const TCGOutOpBinary outop_andc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_OR, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1785,14 +1803,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-        i1 = OPC_OR, i2 = OPC_ORI;
-        goto do_binary;
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         i1 = OPC_XOR, i2 = OPC_XORI;
-    do_binary:
         if (c2) {
             tcg_out_opc_imm(s, i2, a0, a1, a2);
             break;
@@ -2218,9 +2231,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rI);
     case INDEX_op_shl_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 7b1a82c9fa..b638a5f813 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2954,6 +2954,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, OR | SAB(a1, a0, a2));
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_ori32(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3039,15 +3057,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i64:
-    case INDEX_op_or_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_ori32(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, OR | SAB(a1, a0, a2));
-        }
-        break;
     case INDEX_op_xor_i64:
     case INDEX_op_xor_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
@@ -4130,7 +4139,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
     case INDEX_op_orc_i32:
     case INDEX_op_eqv_i32:
@@ -4172,7 +4180,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
         return C_O1_I2(r, rI, ri);
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rU);
     case INDEX_op_sub_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f637604e98..9bacd109d4 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2013,6 +2013,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_OR, a0, a1, a2);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2091,15 +2109,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_OR, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         if (c2) {
@@ -2682,9 +2691,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index e4b60d1924..9267aef544 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2242,6 +2242,31 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, OGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, OR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, ORK, a0, a1, a2);
+    }
+}
+
+static void tgen_ori_3(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    tgen_ori(s, a0, type == TCG_TYPE_I32 ? (uint32_t)a2 : a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rK),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori_3,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2310,17 +2335,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_ori(s, a0, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RR, OR, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, ORK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_xor_i32:
         a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
@@ -2561,15 +2575,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_ori(s, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, OGRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_xor_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
@@ -3282,10 +3287,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rK);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index fe9175aa1a..b01d55c80b 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1333,6 +1333,24 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_OR);
+}
+
+static void tgen_ori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_OR);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_or,
+    .out_rri = tgen_ori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1390,9 +1408,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(or):
-        c = ARITH_OR;
-        goto gen_arith;
     OP_32_64(orc):
         c = ARITH_ORN;
         goto gen_arith;
@@ -1612,8 +1627,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
     case INDEX_op_xor_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 92c588305a..6fdfcab061 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -101,8 +101,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
     case INDEX_op_xor_i32:
@@ -668,6 +666,17 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_or_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_or,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -712,7 +721,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     CASE_32_64(sub)
     CASE_32_64(mul)
-    CASE_32_64(or)
     CASE_32_64(xor)
     CASE_32_64(orc)      /* Optional (TCG_TARGET_HAS_orc_*). */
     CASE_32_64(eqv)      /* Optional (TCG_TARGET_HAS_eqv_*). */
-- 
2.43.0


