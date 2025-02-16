Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49272C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnms-0005rY-Dh; Sun, 16 Feb 2025 18:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnma-0005bU-N0
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:43 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmX-0005H5-J6
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:40 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so67697395ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747436; x=1740352236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/5xsqqsOILe6onQcn3OwNdwu+66176d8PA9Cxh+BGX8=;
 b=I3nxd/wqjTAcZ18UQ5XWsvX5hMlUdXJ7GmmYZTwX6E1wqjn4Eg2+D+bP3NXkt8d53W
 9fNv+b2WbxP0vej8GfTthwmsQEcaRB0jZcol98bAmnSbhfdPqhner1tZNqPr/TRNa2GR
 NmEUqUVy5YQjnA9Lwb5ZQSrqNertQXfqer1OyMIUdlI+E/X4NhC5s80odZIGkY8SGiPw
 xoorVArv/e1M1TIhqmW71KeRK2iNZZ2Jzotlbs/TExCENBcGc57mlpPT7gJbHzMHtf8u
 y/Vr65Mfym9DGWlfJ6OLci0mhLgxxPG4OKM4vRXYvggInVGXg8bqahHcnaXT+WFw7aTp
 Ej0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747436; x=1740352236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5xsqqsOILe6onQcn3OwNdwu+66176d8PA9Cxh+BGX8=;
 b=pZWBp7D7BsTsLXRUzOFCx1LRbJbJjUKqgG5Y4wg/WxVrzu7NUomteYbjkqAFZ+38MZ
 6W3uOFSCzmxSVd1nOYlyHmsYXapaPV+mz/Voy064yE3KCGcv2ZbiAdm+jhy8gllfMf6d
 KtfXumE7lNvfPzhBEY0/qQJtnveF55u3kLMFL4ZjUiI/t3YCpyms4GVS4NWxQi41nkuB
 BcQKyKZFKXBzqTD4f2iwAbrV+XKBekYUGdJjbJzL4wLu4zo4eoAQPd5XXpItJYcT5g9S
 lnObh7RmIqbP4I+pNZ12bK5+fAg47IJ5mPtcTlz/24RWmhY6AmNNfIhoscP+CxdKqY4W
 u/rQ==
X-Gm-Message-State: AOJu0Yxce9ugl42JDoYkJaCy19NetXZWLjd9f1YrAE9jKWExzRXmewi+
 BTdM3OThpCqTSR1iMNxZ9wWYa7QK0njKBCJnSqPO9L57KGcMYfZGJaqtttdwhppHGn9LRXtYR1/
 k
X-Gm-Gg: ASbGncu7yz1ga4HYicYBKHqz9BTl1z6C0FIopHzXj5RL0Dyq4in/56Obmd31aPuP+m/
 4TktjEcS5gyZ5UkfqB9yafl7G9fos8ISOzD3nni+gtt4sK/igrofwvx67q64diIR2i5RST0YxOx
 d7LWzYgj8mmCeL5aWovGxURw4Hb0Zv6cICO8jwFP8y/UAE0btmQ6KNePzDEE+kZy19RnGNgVx7L
 nCZrfTQ5nJMC9qDOQoMvoFWXdXMTkEh54r2ZoplLtwmXtRlKI9dxjaoLnKnj/8GQvXRZBA3eJCT
 7r9DjQZV+akC6Y/Wp114xgVoVqNgNrfAFQtBEVdO9MY1v5E=
X-Google-Smtp-Source: AGHT+IHWhStKHswaQb2DaXHWG19GSnzSJWqCbPCruWFigfXUpfhB07bSss8FJh13BQ3bGu/5U+L1eQ==
X-Received: by 2002:a17:902:ce82:b0:21f:1bd:efd4 with SMTP id
 d9443c01a7336-22104030d71mr123078045ad.19.1739747436127; 
 Sun, 16 Feb 2025 15:10:36 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 030/162] tcg: Convert neg to TCGOutOpUnary
Date: Sun, 16 Feb 2025 15:07:59 -0800
Message-ID: <20250216231012.2808572-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
index ee2af15cf8..612437cd21 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -986,6 +986,11 @@ typedef struct TCGOutOpBinary {
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
@@ -1017,6 +1022,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
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
@@ -5460,6 +5465,17 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index dfe67c1261..cf7a3f2632 100644
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
@@ -2301,11 +2312,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_neg_i64:
-    case INDEX_op_neg_i32:
-        tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
-        break;
-
     case INDEX_op_not_i64:
     case INDEX_op_not_i32:
         tcg_out_insn(s, 3510, ORN, ext, a0, TCG_REG_XZR, a1);
@@ -2990,8 +2996,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_bswap16_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 07c0f40912..b7d84d6483 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1957,6 +1957,16 @@ static const TCGOutOpBinary outop_xor = {
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
@@ -2046,9 +2056,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
-    case INDEX_op_neg_i32:
-        tcg_out_dat_imm(s, COND_AL, ARITH_RSB, args[0], args[1], 0);
-        break;
     case INDEX_op_not_i32:
         tcg_out_dat_reg(s, COND_AL,
                         ARITH_MVN, args[0], 0, args[1], SHIFT_IMM_LSL(0));
@@ -2232,7 +2239,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 488a7e8d42..84c88ca92d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2701,6 +2701,17 @@ static const TCGOutOpBinary outop_xor = {
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
@@ -2900,9 +2911,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(neg):
-        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, a0);
-        break;
     OP_32_64(not):
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, a0);
         break;
@@ -3719,8 +3727,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 9d71ec2a86..f1db0f4ebb 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1397,6 +1397,16 @@ static const TCGOutOpBinary outop_xor = {
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
@@ -1599,13 +1609,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2266,8 +2269,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_extract_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 15c5661fb8..0fda255a7b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1783,6 +1783,16 @@ static const TCGOutOpBinary outop_xor = {
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
@@ -1975,12 +1985,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2195,7 +2199,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
@@ -2208,7 +2211,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index bfbfdc2dfa..da45436a5a 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3052,6 +3052,16 @@ static const TCGOutOpBinary outop_xor = {
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
@@ -3224,11 +3234,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -4119,7 +4124,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_ctpop_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
@@ -4133,7 +4137,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_ctpop_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 54da432ab1..4e16c44aa5 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2077,6 +2077,16 @@ static const TCGOutOpBinary outop_xor = {
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
@@ -2145,13 +2155,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2660,7 +2663,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_not_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -2669,7 +2671,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_not_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 662984f733..08e65834d7 100644
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
@@ -2624,9 +2635,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_neg_i64:
-        tcg_out_insn(s, RRE, LCGR, args[0], args[1]);
-        break;
     case INDEX_op_not_i64:
         tcg_out_insn(s, RRFa, NOGRK, args[0], args[1], args[1]);
         break;
@@ -3323,8 +3331,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 04b2b3b195..a3926ea1c3 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1403,6 +1403,16 @@ static const TCGOutOpBinary outop_xor = {
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
@@ -1473,9 +1483,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         c = ARITH_UMUL;
         goto gen_arith;
 
-    OP_32_64(neg):
-	c = ARITH_SUB;
-	goto gen_arith1;
     OP_32_64(not):
 	c = ARITH_ORN;
 	goto gen_arith1;
@@ -1639,8 +1646,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 67a46c6321..200b256e73 100644
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
@@ -731,6 +729,16 @@ static const TCGOutOpBinary outop_xor = {
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
@@ -804,7 +812,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rl(s, opc, TCG_REG_TMP, arg_label(args[3]));
         break;
 
-    CASE_32_64(neg)      /* Optional (TCG_TARGET_HAS_neg_*). */
     CASE_32_64(not)      /* Optional (TCG_TARGET_HAS_not_*). */
     CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
     case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap32_i32). */
-- 
2.43.0


