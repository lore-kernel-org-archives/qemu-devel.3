Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA8CE7719A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bm-00061v-2X; Tue, 07 Jan 2025 03:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aw-0001g1-EX
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:46 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ao-0003ft-DC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:46 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2163b0c09afso219737905ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237137; x=1736841937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8iGSFQ3GjJ+nO3B+P42YW6+5djAuHp/xiBGiUu7++w=;
 b=B8YDVxcxpGrxh19x3yGAVDhApLaIJ6xoLlYdNpIa0aFQORA0sim4ao4ImUzZ8BW5An
 DMDCXSMHVOQKOreaU6bVm1mhp/hBANswcDYxIf9bRjn5pOF21KCcZ/FWPLm70wcIYwPb
 t/+EW13qz8dKGRhV1s8AWhVF8gZtRjxK9LRC/RfPw04hP6SVnqqMomgknyVs4OzJGa5S
 pwuB7BCJfhRLNcsvhCMRUEJv+6seH1G5bx2AyLQ3XxmdDHhe5tVOBWkZxMspkgaTu+xS
 nSXkEBadrjOp5dJZQM8m10PzKL72vdePrCkEvpFMVnJzF0Tft/hgHgdhsevU1TuF6WVY
 b56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237137; x=1736841937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8iGSFQ3GjJ+nO3B+P42YW6+5djAuHp/xiBGiUu7++w=;
 b=upbyK4+nldXavK+We1E4pWMrN8cLTzZXcamWQFfDKfLZFaUmHYLBqepb2Kzt0g7M7q
 lz/Cveor56gmmYo36NmCSlkwSFaZZhWYAg+/UgLw730leRvt6/djOLdrT6ZIsu/CioSU
 zLnvOqcpwMxwr4gty6+/NeCxhvpUFKgVlxhftReG4lDUp9sl/k4socxABEzuHAAYcnHO
 zU0BBROt6J7FBUPpzkKbzROKpVdB0XQ8eWig73palzeUvausU4orVVsPLdqzePVhim7X
 8508lDWl+FnPvu26KzppkrHtWlg5bUBuZQKKM7f8+dda3x81H++QEM5jWPW4h/MoHQnl
 v8Vg==
X-Gm-Message-State: AOJu0YyA17FaXF12BRCtF1CCU2GFt9JP1nvOUP0NZxGaJb0DdH6ez6G/
 iIQrCtVli0VeowMgCTdvnMhArvCHuYtmSUd8r/AzfVCTRjuBtLle8qpwOv8j6x1HwOvNRMhLSzo
 5
X-Gm-Gg: ASbGncs5vYnc46aVBJjcSQV+uxmoN4XUzmbrBEvwJ1jq1dvFjJjVQBcf+WK8vQb+Dqf
 65/lHkIO0lg5snrGhvKmiES9hrLNcXRvGId2QFLfLRKLdTXd52NCZPyjSqdXhvwbWI+xX3RdPZR
 jF1o1xqxP+HIjw+XHEbYt6ONwrOdJFWdbwKVVkvLfjMw6ASMGgh1MKCY4TNGcHFxqXlR0vpXlo+
 l1dndmrBdBVq+XsIQZpvJkZXMrgkmuFy69+X+oeybIr4WEK4JMjthitdnrrbUB2wr0Jvru/vc02
 nwD63uDoMkLucybvvg==
X-Google-Smtp-Source: AGHT+IGxhjW76Ip4zJgOl125CVv3YPXuxwuvgXi9CWcUuuOISjh7B19zaSjWeyPBERfp3PmQkNg1bw==
X-Received: by 2002:a05:6a00:32cb:b0:729:1c0f:b957 with SMTP id
 d2e1a72fcca58-72abded050amr91953825b3a.25.1736237136987; 
 Tue, 07 Jan 2025 00:05:36 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 78/81] tcg: Convert neg to TCGOutOpUnary
Date: Tue,  7 Jan 2025 00:01:09 -0800
Message-ID: <20250107080112.1175095-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 tcg/tcg.c                        | 20 ++++++++++++++++++--
 tcg/aarch64/tcg-target.c.inc     | 18 +++++++++++-------
 tcg/arm/tcg-target.c.inc         | 14 ++++++++++----
 tcg/i386/tcg-target.c.inc        | 16 +++++++++++-----
 tcg/loongarch64/tcg-target.c.inc | 19 ++++++++++---------
 tcg/mips/tcg-target.c.inc        | 18 ++++++++++--------
 tcg/ppc/tcg-target.c.inc         | 17 ++++++++++-------
 tcg/riscv/tcg-target.c.inc       | 19 ++++++++++---------
 tcg/s390x/tcg-target.c.inc       | 22 ++++++++++++++--------
 tcg/sparc64/tcg-target.c.inc     | 15 ++++++++++-----
 tcg/tci/tcg-target.c.inc         | 13 ++++++++++---
 11 files changed, 124 insertions(+), 67 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 65582828ea..2bbc4297c9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -970,6 +970,11 @@ typedef struct TCGOutOpBinary {
                     TCGReg a0, TCGReg a1, tcg_target_long a2);
 } TCGOutOpBinary;
 
+typedef struct TCGOutOpUnary {
+    TCGOutOp base;
+    void (*out_rr)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1);
+} TCGOutOpUnary;
+
 typedef struct TCGOutOpSubtract {
     TCGOutOp base;
     void (*out_rrr)(TCGContext *s, TCGType type,
@@ -1004,6 +1009,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
+    OUTOP(INDEX_op_neg_i32, TCGOutOpUnary, outop_neg),
+    OUTOP(INDEX_op_neg_i64, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
@@ -2240,7 +2247,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -2309,7 +2315,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
@@ -5451,6 +5456,17 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_neg_i32:
+    case INDEX_op_neg_i64:
+        {
+            const TCGOutOpUnary *out =
+                container_of(all_outop[op->opc], TCGOutOpUnary, base);
+
+            tcg_debug_assert(!const_args[1]);
+            out->out_rr(s, type, new_args[0], new_args[1]);
+        }
+        break;
+
     default:
         if (def->flags & TCG_OPF_VECTOR) {
             tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 0d417169d2..042773a6fc 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2235,6 +2235,17 @@ static const TCGOutOpBinary outop_xor = {
 };
 
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_sub(s, type, a0, TCG_REG_XZR, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2305,11 +2316,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, REG0(0), a1, a2, 3);
         break;
 
-    case INDEX_op_neg_i64:
-    case INDEX_op_neg_i32:
-        tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
-        break;
-
     case INDEX_op_not_i64:
     case INDEX_op_not_i32:
         tcg_out_insn(s, 3510, ORN, ext, a0, TCG_REG_XZR, a1);
@@ -3002,8 +3008,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_bswap16_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 6e567da031..6b6dc29ec9 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1977,6 +1977,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_subfi(s, type, a0, 0, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2066,9 +2076,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
-    case INDEX_op_neg_i32:
-        tcg_out_dat_imm(s, COND_AL, ARITH_RSB, args[0], args[1], 0);
-        break;
     case INDEX_op_not_i32:
         tcg_out_dat_reg(s, COND_AL,
                         ARITH_MVN, args[0], 0, args[1], SHIFT_IMM_LSL(0));
@@ -2270,7 +2277,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 11704a7bad..af8463bfa0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2766,6 +2766,17 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, a0);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, 0),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2966,9 +2977,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(neg):
-        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, a0);
-        break;
     OP_32_64(not):
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, a0);
         break;
@@ -3814,8 +3822,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 07ed40c5c4..257a5b122b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1404,6 +1404,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1606,13 +1616,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_neg_i32:
-        tcg_out_opc_sub_w(s, a0, TCG_REG_ZERO, a1);
-        break;
-    case INDEX_op_neg_i64:
-        tcg_out_opc_sub_d(s, a0, TCG_REG_ZERO, a1);
-        break;
-
     case INDEX_op_mul_i32:
         tcg_out_opc_mul_w(s, a0, a1, a2);
         break;
@@ -2283,8 +2286,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_extract_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 3f42835fef..9a72d3dbba 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1806,6 +1806,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2003,12 +2013,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_reg(s, OPC_MFHI, a1, 0, 0);
         break;
 
-    case INDEX_op_neg_i32:
-        i1 = OPC_SUBU;
-        goto do_unary;
-    case INDEX_op_neg_i64:
-        i1 = OPC_DSUBU;
-        goto do_unary;
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
         i1 = OPC_NOR;
@@ -2249,7 +2253,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
@@ -2262,7 +2265,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 74ab9e43f5..eecdbe96ff 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3090,6 +3090,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out32(s, NEG | RT(a0) | RA(a1));
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3262,11 +3272,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond2(s, args, const_args);
         break;
 
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
-        tcg_out32(s, NEG | RT(args[0]) | RA(args[1]));
-        break;
-
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
         tcg_out32(s, NOR | SAB(args[1], args[0], args[1]));
@@ -4193,7 +4198,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_ctpop_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
@@ -4207,7 +4211,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_ctpop_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 70d1479e7d..2498d9169f 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2080,6 +2080,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2148,13 +2158,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
         break;
 
-    case INDEX_op_neg_i32:
-        tcg_out_opc_reg(s, OPC_SUBW, a0, TCG_REG_ZERO, a1);
-        break;
-    case INDEX_op_neg_i64:
-        tcg_out_opc_reg(s, OPC_SUB, a0, TCG_REG_ZERO, a1);
-        break;
-
     case INDEX_op_mul_i32:
         tcg_out_opc_reg(s, OPC_MULW, a0, a1, a2);
         break;
@@ -2661,7 +2664,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_not_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -2670,7 +2672,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_not_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index dbc8641baf..2e9306a65c 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2373,6 +2373,20 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori_3,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RR, LCR, a0, a1);
+    } else {
+        tcg_out_insn(s, RRE, LCGR, a0, a1);
+    }
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2430,9 +2444,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_neg_i32:
-        tcg_out_insn(s, RR, LCR, args[0], args[1]);
-        break;
     case INDEX_op_not_i32:
         tcg_out_insn(s, RRFa, NORK, args[0], args[1], args[1]);
         break;
@@ -2630,9 +2641,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_neg_i64:
-        tcg_out_insn(s, RRE, LCGR, args[0], args[1]);
-        break;
     case INDEX_op_not_i64:
         tcg_out_insn(s, RRFa, NOGRK, args[0], args[1], args[1]);
         break;
@@ -3329,8 +3337,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 4b2549c82e..1724d31230 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1406,6 +1406,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+     tgen_sub(s, type, a0, TCG_REG_G0, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1476,9 +1486,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         c = ARITH_UMUL;
         goto gen_arith;
 
-    OP_32_64(neg):
-	c = ARITH_SUB;
-	goto gen_arith1;
     OP_32_64(not):
 	c = ARITH_ORN;
 	goto gen_arith1;
@@ -1646,8 +1653,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index c083dd604f..45115d7e82 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -57,8 +57,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
@@ -753,6 +751,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rrr = tgen_xor,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, glue(INDEX_op_neg_i,TCG_TARGET_REG_BITS), a0, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -826,7 +834,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rl(s, opc, TCG_REG_TMP, arg_label(args[3]));
         break;
 
-    CASE_32_64(neg)      /* Optional (TCG_TARGET_HAS_neg_*). */
     CASE_32_64(not)      /* Optional (TCG_TARGET_HAS_not_*). */
     CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
     case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap32_i32). */
-- 
2.43.0


