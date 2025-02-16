Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A601C021A7
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmS-0005Xi-ID; Sun, 16 Feb 2025 18:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmR-0005X2-1Q
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:31 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmO-0005Ed-9X
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:30 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22128b7d587so7727145ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747427; x=1740352227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T+0SPD3i0CQVTq8BTbt2UNnx632RdA7XFo28yxrUi/I=;
 b=jMsykohsU15duG1vqOdvtk+f6DKY38DVtJIMTdoaymqTsRlhzE97MorgRx6m2IFYnQ
 HcygIk739YuvdTkq2+1ZyKYci9S1Z9MXUa4jrLOD8AdCYfSbEmbcxwaihVxbyC8ii38B
 G/BjmSvkpb1khMbzf040HkchTRaT8HE5j9+yzMzKpUsrFx43MGh1CIIcjJpXxn0Dd3zf
 4UkzbL7f3mDWPsJbTxtUNGa4p11YzIiv1KL8FNw56PKvldHMT+qMGIWbrjLoJ826VQQ1
 E0tNlUI89Mr/Arfs/4dYHgw9O8gdCpJt1W45ewv+eoiboKLiausU3Hc+wAPdRUCi2emr
 F1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747427; x=1740352227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+0SPD3i0CQVTq8BTbt2UNnx632RdA7XFo28yxrUi/I=;
 b=SYiAWibKgMbzRyvmBBoHsyko8p2bL/2v3TgR/kIVGMhxIqmfpUU3T3WFjVv4gBqQ8t
 aCGgDsSfCvFhguPIpKHB2dTz5gb/4ImOeRjVoljD7lAblylS9hekh8rroOGX3pTsY2QQ
 JCFRGrZkLg+ZyqXYuTG+XDdTsX7xm9G8zloYI9/vgQmXRS7XBVHGnyEG5pUax0EBXo2z
 L/QzdkMqymO8QGTOZ7Z5tPx1Ukci940WIjLkL77vRKOhGWGFZKFFt7ecuPXzrgsPAi6d
 PF66hEZFhgaifCg/TVHzqgj/UfSTutqyjYenIWnE4kRsCPu663EOYaeM6rJ1Azr2Sn5O
 SaUA==
X-Gm-Message-State: AOJu0YztVWxq+3WVxrGeE6EEPfGd9lYbpKgvKO3nLQwY0exYl6aa+ouH
 5z65gkp9Gw/2rAKTldvMlvZWj/g03YXLipvsK3t7ldZqJ6biI9JFHZYCWgg5WyNrv8QvqIJnDz4
 V
X-Gm-Gg: ASbGnctdg9SWsOiz6oOggaJ2U2GPb1SUdtbMSsfG18xN0lUnbn0vFdf1Muo0hLfGtfP
 SjPOj/ttReiZWJNOXBFfm3YLjfE1uLJ90+6yA5wwXwpsTlDJfXaQZ/DVG3mwweNF7KqPdORgqXL
 YzqJaMptgOYqyTPAVqw5SLpE9RNND8JCK/YrwfPY6xsFNa4NROLQqTLGJmCe7qWWvCQ+cd247cJ
 pAYvG5Baqd+baJCI9ardIB4jUjSAIK3wyCRurSShbSQxwsLUsAGNyxI6A/ad5N8x4f5QDrZZLcl
 9r+YGHdy90ywcgbWXvEVmfWsM7ZgCpBO8VbTE6AGnMZz/Ho=
X-Google-Smtp-Source: AGHT+IGa+9lqPNawGQkfXLXMm1wo8OE48/Hng+MvUDeC3RbGQHqU8rRspANsihKlW17pGsUHJ9NUmg==
X-Received: by 2002:a17:902:d502:b0:220:e63c:5aff with SMTP id
 d9443c01a7336-221040c0a63mr130134035ad.47.1739747426596; 
 Sun, 16 Feb 2025 15:10:26 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 017/162] tcg: Convert xor to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:07:46 -0800
Message-ID: <20250216231012.2808572-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 tcg/aarch64/tcg-target.c.inc     | 31 +++++++++++---------
 tcg/arm/tcg-target.c.inc         | 25 +++++++++++-----
 tcg/i386/tcg-target.c.inc        | 27 ++++++++++++-----
 tcg/loongarch64/tcg-target.c.inc | 29 +++++++++++-------
 tcg/mips/tcg-target.c.inc        | 28 +++++++++++-------
 tcg/ppc/tcg-target.c.inc         | 30 +++++++++++--------
 tcg/riscv/tcg-target.c.inc       | 29 +++++++++++-------
 tcg/s390x/tcg-target.c.inc       | 50 ++++++++++++++++----------------
 tcg/sparc64/tcg-target.c.inc     | 23 +++++++++++----
 tcg/tci/tcg-target.c.inc         | 14 +++++++--
 11 files changed, 186 insertions(+), 104 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index dc45df2869..d704ef8643 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1009,6 +1009,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
+    OUTOP(INDEX_op_xor_i32, TCGOutOpBinary, outop_xor),
+    OUTOP(INDEX_op_xor_i64, TCGOutOpBinary, outop_xor),
 };
 
 #undef OUTOP
@@ -5434,6 +5436,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_or:
     case INDEX_op_orc:
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 13592303a8..d575635fe0 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2186,6 +2186,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3510, EOR, type, a0, a1, a2);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_logicali(s, I3404_EORI, type, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rL),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2267,17 +2285,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_xor_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_xor_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_EORI, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3510, EOR, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_eqv_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -3023,8 +3030,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
         return C_O1_I2(r, r, rL);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 76d24e0440..00963d6f93 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1909,6 +1909,24 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_EOR, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_imm(s, COND_AL, ARITH_EOR, a0, a1, encode_imm_nofail(a2));
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1971,10 +1989,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             args[0], args[1], args[2], const_args[2]);
         }
         break;
-    case INDEX_op_xor_i32:
-        c = ARITH_EOR;
-        tcg_out_dat_rI(s, COND_AL, c, args[0], args[1], args[2], const_args[2]);
-        break;
     case INDEX_op_add2_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
         a3 = args[3], a4 = args[4], a5 = args[5];
@@ -2232,9 +2246,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
 
-    case INDEX_op_xor_i32:
-        return C_O1_I2(r, r, rI);
-
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d278e61b85..928938509e 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2657,6 +2657,26 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_XOR + rexw, a0, a2);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_XOR + rexw, a0, a2, 0);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2740,11 +2760,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     OP_32_64(sub):
         c = ARITH_SUB;
-        goto gen_arith;
-    OP_32_64(xor):
-        c = ARITH_XOR;
-        goto gen_arith;
-    gen_arith:
         if (const_a2) {
             tgen_arithi(s, c + rexw, a0, a2, 0);
         } else {
@@ -3666,8 +3681,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
         return C_O1_I2(r, 0, re);
 
     case INDEX_op_shl_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 9bfe1d6d6b..3775777db4 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1345,6 +1345,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_xor(s, a0, a1, a2);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_xori(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1395,15 +1413,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
-        if (c2) {
-            tcg_out_opc_xori(s, a0, a1, a2);
-        } else {
-            tcg_out_opc_xor(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_extract_i32:
         if (a2 == 0 && args[3] <= 12) {
             tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
@@ -2291,8 +2300,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
         /* LoongArch reg-imm bitops have their imms ZERO-extended */
         return C_O1_I2(r, r, rU);
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f6987963ec..30fb01cb0a 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1734,6 +1734,24 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_XOR, a0, a1, a2);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_XORI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1807,13 +1825,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
-        i1 = OPC_XOR, i2 = OPC_XORI;
-        if (c2) {
-            tcg_out_opc_imm(s, i2, a0, a1, a2);
-            break;
-        }
     do_binaryv:
         tcg_out_opc_reg(s, i1, a0, a1, a2);
         break;
@@ -2235,9 +2246,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
-        return C_O1_I2(r, r, rI);
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index ccd7812016..16d3dbd841 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2983,6 +2983,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, XOR | SAB(a1, a0, a2));
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_xori32(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3068,15 +3086,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i64:
-    case INDEX_op_xor_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_xori32(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, XOR | SAB(a1, a0, a2));
-        }
-        break;
     case INDEX_op_eqv_i32:
         if (const_args[2]) {
             tcg_out_xori32(s, args[0], args[1], ~args[2]);
@@ -4141,7 +4150,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_xor_i32:
     case INDEX_op_eqv_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -4180,8 +4188,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
         return C_O1_I2(r, rI, ri);
-    case INDEX_op_xor_i64:
-        return C_O1_I2(r, r, rU);
     case INDEX_op_sub_i64:
         return C_O1_I2(r, rI, rT);
     case INDEX_op_clz_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 14216e9dff..c981ea389a 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2043,6 +2043,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_XOR, a0, a1, a2);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_XORI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2121,15 +2139,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_XORI, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_XOR, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
         if (c2) {
@@ -2695,8 +2704,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 97587939bd..bedad7137b 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2283,6 +2283,31 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, XGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, XR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, XRK, a0, a1, a2);
+    }
+}
+
+static void tgen_xori_3(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    tgen_xori(s, a0, type == TCG_TYPE_I32 ? (uint32_t)a2 : a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rK),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori_3,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2351,18 +2376,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tcg_out_insn(s, RIL, XILF, a0, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RR, XR, args[0], args[2]);
-        } else {
-            tcg_out_insn(s, RRFa, XRK, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_eqv_i32:
         a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
@@ -2582,16 +2595,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_xori(s, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, XGRK, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_eqv_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
@@ -3285,10 +3288,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_xor_i32:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_xor_i64:
-        return C_O1_I2(r, r, rK);
 
     case INDEX_op_eqv_i32:
         return C_O1_I2(r, r, ri);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 38b325e8a9..8a6c9852d2 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1362,6 +1362,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_XOR);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_XOR);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1419,9 +1437,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(xor):
-        c = ARITH_XOR;
-        goto gen_arith;
     case INDEX_op_shl_i32:
         c = SHIFT_SLL;
     do_shift32:
@@ -1635,8 +1650,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index b9309e2fb9..85caff300f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -101,8 +101,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
@@ -686,6 +684,17 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_xor_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_xor,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -730,7 +739,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     CASE_32_64(sub)
     CASE_32_64(mul)
-    CASE_32_64(xor)
     CASE_32_64(eqv)      /* Optional (TCG_TARGET_HAS_eqv_*). */
     CASE_32_64(nand)     /* Optional (TCG_TARGET_HAS_nand_*). */
     CASE_32_64(nor)      /* Optional (TCG_TARGET_HAS_nor_*). */
-- 
2.43.0


