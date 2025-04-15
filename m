Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA4AC369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lws-0003W8-SJ; Tue, 15 Apr 2025 15:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lv1-0000Bg-NB
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:26:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lul-000845-NG
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:52 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-739be717eddso4666935b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745144; x=1745349944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mt2mf8tksUGMPAYQDlKKqeudb0RUPlNVHOCkOyZjbFk=;
 b=jd+bc94vnUcNPtEcAnWoMU6C+8bdoLoVNlks3l7q37VOhjwZ33tRnrVdtlIzqOQbBP
 X5KnNNN2Orxr7/TOAraELOQaIkCGtYGW/HNVaKD3240DPyx5cwRQvcdUxCd+W7ydt+nL
 cnxCoS4pp7Phh1mZ8GnzRfA4LFY9f3g3uJ4LmOEp022YAASTdn5ZFDrxPSJz0/GSIVw9
 NJqZsx4HgeObKB6SJyt5FxGqm0cGFulm0ijFndGzfAZ/scCbUgKfNcKkTb/MoNdVUaN3
 LTMcoH0XbsZ4z4hpP6s+X5a4pKVz9mJBmVmc2+fLfVRXWe78jWMvE6+/XBEnwEVj2Jo9
 ax7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745144; x=1745349944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mt2mf8tksUGMPAYQDlKKqeudb0RUPlNVHOCkOyZjbFk=;
 b=EFZrHvyoAMfqGnvxhWgmKRXeiERkhH4cuWp9Zbn1MSvWZDG2TLZjg5djpqWMLK885d
 cqGc3DM1k7t6uOzuAihaXsb3nZ2hilkiPXI/0SbqzWvNme9M1AhTczoYSsRRklvKqX0k
 DIvEBUtv4B2cucGv8q5M7gAgiP85KpGBQfqetj4xNn0AL/bEPsk5asRY9kJqaW4E4N9U
 uA8+W8qHqVp3mB05j+ZgYGxI3/1d+AVPbaD7ThuCeYdwmb6MDepWXF+m8uMHBb60R/lH
 PgrrDwowvAMhivdpRFQisA0pnF9G/AXIRBwoLB5P3UOGMkDm+KlsB4EJ2kg+mVFx9v9c
 ustA==
X-Gm-Message-State: AOJu0YzD8VawXEpqprAeux9iPL0rc2sUEboqFUJtn8L9ofXEa/vgqR7t
 M6y+bRO8jTEw6+aUVZAv0Q2BEa2Q6iLm6a9hINIqeNbXl39xAYqY6lSb0QhTIJIhStCRRUCZXON
 0
X-Gm-Gg: ASbGncssu9A849k7ntcwy4lUWjZe+6Rr+2jIMeSasAAkBTwMH2ZVzk7oiplpiArSpz7
 xcSqh3UvCxWJC3ua2BftHIcsDigE47fk8g2pWJ782ukXHyejhE1h15GEMbZbDsZpi45opVUbgPx
 qSuo/zrAoZjV/VccZEb81G8rmdY8jcAe6EzcDkfHXBB2i/nxd4q7W/MHJSi2DnnLR7TujUPll+1
 nElwoucWiR+fWgeD9beeMQNDTFT9HcONUaGwYq37hEnq1fGiK40oc+0Ck7PYJ9gdIi5gM7TKAcK
 sWuNhEv1GC0pksgvVLkhhbD93ulEYsWQ0OUhxZwGHyC+Q8zFtJcnBXDGrEaJFGfcuVcCTf00Zn6
 M9FqVe0pDjw==
X-Google-Smtp-Source: AGHT+IG1YVV9pKV/zlojL8H3BCEE1DjlxupEQ2/2eDY4UDVtaJq7XlWNbGKsSOgAQRD3o6P3qIhxnQ==
X-Received: by 2002:a05:6a00:140f:b0:736:51a6:78b1 with SMTP id
 d2e1a72fcca58-73c1f925ba1mr752255b3a.11.1744745144079; 
 Tue, 15 Apr 2025 12:25:44 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 031/163] tcg: Convert neg to TCGOutOpUnary
Date: Tue, 15 Apr 2025 12:23:02 -0700
Message-ID: <20250415192515.232910-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 21 +++++++++++++++++++--
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
 11 files changed, 125 insertions(+), 67 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index b97d0946d4..8e1bc82758 100644
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
@@ -5468,6 +5473,18 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_neg_i32:
+    case INDEX_op_neg_i64:
+        {
+            const TCGOutOpUnary *out =
+                container_of(all_outop[op->opc], TCGOutOpUnary, base);
+
+            /* Constants should have been folded. */
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
index 13b78f0ada..5ea4488606 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1951,6 +1951,16 @@ static const TCGOutOpBinary outop_xor = {
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
@@ -2040,9 +2050,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
-    case INDEX_op_neg_i32:
-        tcg_out_dat_imm(s, COND_AL, ARITH_RSB, args[0], args[1], 0);
-        break;
     case INDEX_op_not_i32:
         tcg_out_dat_reg(s, COND_AL,
                         ARITH_MVN, args[0], 0, args[1], SHIFT_IMM_LSL(0));
@@ -2226,7 +2233,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 104f1b010a..082aa982fb 100644
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


