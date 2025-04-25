Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF0C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RCj-00005w-MJ; Fri, 25 Apr 2025 18:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB4-0003oz-11
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB0-0001te-O9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:45 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso2855276b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618741; x=1746223541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pl3tIA8cvby9X2r2XYfTk5O+0gbJEB0K7O9EymV2pVw=;
 b=Y1seVgr63KfmTYYVy3srDCDTwmcSAhPO/4t8AwRffWk0pGvtNWhp+oKXOTbi24upWY
 UeKM9jPXbAfGBBe6E8k6RVvaSfD2MEBUtgc55CvWz3poKFZM2V7uv2LUApgnMV7/LI9a
 CU8hc0MQleXUetzWBA3RiOEh4jV1uSCuPQyKPxKddAJaxyEeEu+8O/JnbfFvve/Da+9n
 Gy7cjR9OB1BQ5PqTeL0bKN3WWeex5ic7WK319kyWBJ32dR0VZUtzoFZ+UfnUfz1H3NQr
 IW/4Tvqvj27ITAYEcZATiVXNfQf1Sup2ltEnSZ+j8TMPyNfIlsRaQD9x68SeWk88BKuO
 WVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618741; x=1746223541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pl3tIA8cvby9X2r2XYfTk5O+0gbJEB0K7O9EymV2pVw=;
 b=wolVAKpAWcDmVlJDqEaRh8X4G/9wZGdgKcZnMQ95NuflhD0pfwMLMCMcLlOmWh+sld
 trijGjkru8TWg7fRCF8BxtjNhb4AlhUwW506QQwNF2t8XJGKP6Q33mx2DiPbftx6yjZ1
 /6OTfpU+jf3rteOoxcr+JyP5wfRfTesOsAvl/pO8lB3WwGvnwmHB3Pktr68L8qzKFt/d
 eA5qwC8ueDu5hul9cBhjXzsU9mQuPNIE8o+owWv9qrb8IoL3V4974iFzmyhrBALGSN3x
 gyRp00CDsGAUe/pXiSuzvjOcrWwugN+dCWRKY9HtOe5WMZ/XUUJbCT4KqfGS2KusmJRb
 5o2Q==
X-Gm-Message-State: AOJu0YxraJmJ+jACmLqSV8ewtjRfkeie1yFslf/rwkhn3AOtLA+aPB/d
 QB0d3Q5b2oBR92nyjA8GKvp/sDEmUVLdSwYDVf6/YMRE5JmzVeMZ+1XlQNG9EkCfIWdClNEjxk8
 Y
X-Gm-Gg: ASbGncuPiTjzgFx0WRJK2pXsqFYddOTtiMkBjDnhJSPYHHchp2PAC85RNGrRAYjQhAL
 i7B33D2wEuXPxhiklI5DKIaaryIu2bIlpQa7hFNOHQZAtucXF1vKkB+hHn+R7rhAlF3+j1LuM1l
 vGePsEsWlJMZkzjrFTK3XoKEJY3lPeMP1eVtCRTb8zhkjfZvNt6ALDdRbwofkyCKDQQppM/Jy1Z
 rZV/GNsP5+dBsHaNAh3qQ4J0lC9r/74ohM1CIfgBCUZ/3NKQoiuTPJwcStyWA1gAvkrd0ZPTdrv
 qaOORti18x/UZA/NLKC77cCsav+tdmwt/I/amAR1QR/izbNdx8Ok5qfN7dw1jhOKb2kXJuCCHcs
 =
X-Google-Smtp-Source: AGHT+IElapN6ay8U2wb4xDabdSLalvOMvMmYzczV/8Yc8Z2ocoDoOL5q/LTiytrbphQ3fUwMEbxrLA==
X-Received: by 2002:a05:6a21:9203:b0:1f5:6a1a:329b with SMTP id
 adf61e73a8af0-2045b99e11dmr6708411637.32.1745618741099; 
 Fri, 25 Apr 2025 15:05:41 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 144/159] tcg/sparc64: Implement add/sub carry opcodes
Date: Fri, 25 Apr 2025 14:54:38 -0700
Message-ID: <20250425215454.886111-145-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target-con-set.h |   3 +-
 tcg/sparc64/tcg-target-has.h     |   8 +-
 tcg/sparc64/tcg-target.c.inc     | 300 ++++++++++++++++++++-----------
 3 files changed, 201 insertions(+), 110 deletions(-)

diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index 8cec396173..1a57adc0e8 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -15,6 +15,7 @@ C_O0_I2(r, rJ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, rJ)
+C_O1_I2(r, rz, rJ)
+C_O1_I2(r, rz, rz)
 C_O1_I4(r, r, rJ, rI, 0)
 C_O2_I2(r, r, r, r)
-C_O2_I4(r, r, rz, rz, rJ, rJ)
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index b8760dd154..caf7679595 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,13 +14,13 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 3f97261626..c2251a6927 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -199,7 +199,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define ARITH_SUB  (INSN_OP(2) | INSN_OP3(0x04))
 #define ARITH_SUBCC (INSN_OP(2) | INSN_OP3(0x14))
 #define ARITH_ADDC (INSN_OP(2) | INSN_OP3(0x08))
+#define ARITH_ADDCCC (INSN_OP(2) | INSN_OP3(0x18))
 #define ARITH_SUBC (INSN_OP(2) | INSN_OP3(0x0c))
+#define ARITH_SUBCCC (INSN_OP(2) | INSN_OP3(0x1c))
 #define ARITH_UMUL (INSN_OP(2) | INSN_OP3(0x0a))
 #define ARITH_SMUL (INSN_OP(2) | INSN_OP3(0x0b))
 #define ARITH_UDIV (INSN_OP(2) | INSN_OP3(0x0e))
@@ -211,6 +213,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define ARITH_MOVR (INSN_OP(2) | INSN_OP3(0x2f))
 
 #define ARITH_ADDXC (INSN_OP(2) | INSN_OP3(0x36) | INSN_OPF(0x11))
+#define ARITH_ADDXCCC (INSN_OP(2) | INSN_OP3(0x36) | INSN_OPF(0x13))
 #define ARITH_UMULXHI (INSN_OP(2) | INSN_OP3(0x36) | INSN_OPF(0x16))
 
 #define SHIFT_SLL  (INSN_OP(2) | INSN_OP3(0x25))
@@ -223,6 +226,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 
 #define RDY        (INSN_OP(2) | INSN_OP3(0x28) | INSN_RS1(0))
 #define WRY        (INSN_OP(2) | INSN_OP3(0x30) | INSN_RD(0))
+#define WRCCR      (INSN_OP(2) | INSN_OP3(0x30) | INSN_RD(2))
 #define JMPL       (INSN_OP(2) | INSN_OP3(0x38))
 #define RETURN     (INSN_OP(2) | INSN_OP3(0x39))
 #define SAVE       (INSN_OP(2) | INSN_OP3(0x3c))
@@ -366,7 +370,7 @@ static void tcg_out_arithi(TCGContext *s, TCGReg rd, TCGReg rs1,
 }
 
 static void tcg_out_arithc(TCGContext *s, TCGReg rd, TCGReg rs1,
-			   int32_t val2, int val2const, int op)
+                           int32_t val2, int val2const, int op)
 {
     tcg_out32(s, op | INSN_RD(rd) | INSN_RS1(rs1)
               | (val2const ? INSN_IMM13(val2) : INSN_RS2(val2)));
@@ -733,7 +737,7 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
         }
         c1 = TCG_REG_G0, c2const = 0;
         cond = (cond == TCG_COND_EQ ? TCG_COND_GEU : TCG_COND_LTU);
-	break;
+        break;
 
     case TCG_COND_TSTEQ:
     case TCG_COND_TSTNE:
@@ -742,7 +746,7 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
         c1 = TCG_REG_G0;
         c2 = TCG_REG_T1, c2const = 0;
         cond = (cond == TCG_COND_TSTEQ ? TCG_COND_GEU : TCG_COND_LTU);
-	break;
+        break;
 
     case TCG_COND_GTU:
     case TCG_COND_LEU:
@@ -915,74 +919,6 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
-static void tcg_out_addsub2_i32(TCGContext *s, TCGReg rl, TCGReg rh,
-                                TCGReg al, TCGReg ah, int32_t bl, int blconst,
-                                int32_t bh, int bhconst, int opl, int oph)
-{
-    TCGReg tmp = TCG_REG_T1;
-
-    /* Note that the low parts are fully consumed before tmp is set.  */
-    if (rl != ah && (bhconst || rl != bh)) {
-        tmp = rl;
-    }
-
-    tcg_out_arithc(s, tmp, al, bl, blconst, opl);
-    tcg_out_arithc(s, rh, ah, bh, bhconst, oph);
-    tcg_out_mov(s, TCG_TYPE_I32, rl, tmp);
-}
-
-static void tcg_out_addsub2_i64(TCGContext *s, TCGReg rl, TCGReg rh,
-                                TCGReg al, TCGReg ah, int32_t bl, int blconst,
-                                int32_t bh, int bhconst, bool is_sub)
-{
-    TCGReg tmp = TCG_REG_T1;
-
-    /* Note that the low parts are fully consumed before tmp is set.  */
-    if (rl != ah && (bhconst || rl != bh)) {
-        tmp = rl;
-    }
-
-    tcg_out_arithc(s, tmp, al, bl, blconst, is_sub ? ARITH_SUBCC : ARITH_ADDCC);
-
-    if (use_vis3_instructions && !is_sub) {
-        /* Note that ADDXC doesn't accept immediates.  */
-        if (bhconst && bh != 0) {
-           tcg_out_movi_s13(s, TCG_REG_T2, bh);
-           bh = TCG_REG_T2;
-        }
-        tcg_out_arith(s, rh, ah, bh, ARITH_ADDXC);
-    } else if (bh == TCG_REG_G0) {
-	/* If we have a zero, we can perform the operation in two insns,
-           with the arithmetic first, and a conditional move into place.  */
-	if (rh == ah) {
-            tcg_out_arithi(s, TCG_REG_T2, ah, 1,
-			   is_sub ? ARITH_SUB : ARITH_ADD);
-            tcg_out_movcc(s, COND_CS, MOVCC_XCC, rh, TCG_REG_T2, 0);
-	} else {
-            tcg_out_arithi(s, rh, ah, 1, is_sub ? ARITH_SUB : ARITH_ADD);
-            tcg_out_movcc(s, COND_CC, MOVCC_XCC, rh, ah, 0);
-	}
-    } else {
-        /*
-         * Otherwise adjust BH as if there is carry into T2.
-         * Note that constant BH is constrained to 11 bits for the MOVCC,
-         * so the adjustment fits 12 bits.
-         */
-        if (bhconst) {
-            tcg_out_movi_s13(s, TCG_REG_T2, bh + (is_sub ? -1 : 1));
-        } else {
-            tcg_out_arithi(s, TCG_REG_T2, bh, 1,
-                           is_sub ? ARITH_SUB : ARITH_ADD);
-        }
-        /* ... smoosh T2 back to original BH if carry is clear ... */
-        tcg_out_movcc(s, COND_CC, MOVCC_XCC, TCG_REG_T2, bh, bhconst);
-	/* ... and finally perform the arithmetic with the new operand.  */
-        tcg_out_arith(s, rh, ah, TCG_REG_T2, is_sub ? ARITH_SUB : ARITH_ADD);
-    }
-
-    tcg_out_mov(s, TCG_TYPE_I64, rl, tmp);
-}
-
 static void tcg_out_jmpl_const(TCGContext *s, const tcg_insn_unit *dest,
                                bool in_prologue, bool tail_call)
 {
@@ -1382,21 +1318,132 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_ADDCC);
+}
+
+static void tgen_addco_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_ADDCC);
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_addco_rrr,
+    .out_rri = tgen_addco_rri,
 };
 
+static void tgen_addci_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_arith(s, a0, a1, a2, ARITH_ADDC);
+    } else if (use_vis3_instructions) {
+        tcg_out_arith(s, a0, a1, a2, ARITH_ADDXC);
+    } else {
+        tcg_out_arith(s, TCG_REG_T1, a1, a2, ARITH_ADD);  /* for CC */
+        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_ADD);  /* for CS */
+        /* Select the correct result based on actual carry value. */
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
+    }
+}
+
+static void tgen_addci_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_arithi(s, a0, a1, a2, ARITH_ADDC);
+        return;
+    }
+    /* !use_vis3_instructions */
+    if (a2 != 0) {
+        tcg_out_arithi(s, TCG_REG_T1, a1, a2, ARITH_ADD); /* for CC */
+        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_ADD);  /* for CS */
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
+    } else if (a0 == a1) {
+        tcg_out_arithi(s, TCG_REG_T1, a1, 1, ARITH_ADD);
+        tcg_out_movcc(s, COND_CS, MOVCC_XCC, a0, TCG_REG_T1, false);
+    } else {
+        tcg_out_arithi(s, a0, a1, 1, ARITH_ADD);
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, a1, false);
+    }
+}
+
+static TCGConstraintSetIndex cset_addci(TCGType type, unsigned flags)
+{
+    if (use_vis3_instructions && type == TCG_TYPE_I64) {
+        /* Note that ADDXC doesn't accept immediates.  */
+        return C_O1_I2(r, rz, rz);
+    }
+    return C_O1_I2(r, rz, rJ);
+}
+
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addci,
+    .out_rrr = tgen_addci_rrr,
+    .out_rri = tgen_addci_rri,
 };
 
+/* Copy %xcc.c to %icc.c */
+static void tcg_out_dup_xcc_c(TCGContext *s)
+{
+    if (use_vis3_instructions) {
+        tcg_out_arith(s, TCG_REG_T1, TCG_REG_G0, TCG_REG_G0, ARITH_ADDXC);
+    } else {
+        tcg_out_movi_s13(s, TCG_REG_T1, 0);
+        tcg_out_movcc(s, COND_CS, MOVCC_XCC, TCG_REG_T1, 1, true);
+    }
+    /* Write carry-in into %icc via {0,1} + -1. */
+    tcg_out_arithi(s, TCG_REG_G0, TCG_REG_T1, -1, ARITH_ADDCC);
+}
+
+static void tgen_addcio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        if (use_vis3_instructions) {
+            tcg_out_arith(s, a0, a1, a2, ARITH_ADDXCCC);
+            return;
+        }
+        tcg_out_dup_xcc_c(s);
+    }
+    tcg_out_arith(s, a0, a1, a2, ARITH_ADDCCC);
+}
+
+static void tgen_addcio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type != TCG_TYPE_I32) {
+        /* !use_vis3_instructions */
+        tcg_out_dup_xcc_c(s);
+    }
+    tcg_out_arithi(s, a0, a1, a2, ARITH_ADDCCC);
+}
+
+static TCGConstraintSetIndex cset_addcio(TCGType type, unsigned flags)
+{
+    if (use_vis3_instructions && type == TCG_TYPE_I64) {
+        /* Note that ADDXCCC doesn't accept immediates.  */
+        return C_O1_I2(r, rz, rz);
+    }
+    return C_O1_I2(r, rz, rJ);
+}
+
 static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addcio,
+    .out_rrr = tgen_addcio_rrr,
+    .out_rri = tgen_addcio_rri,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    /* 0x11 -> xcc = nzvC, icc = nzvC */
+    tcg_out_arithi(s, 0, TCG_REG_G0, 0x11, WRCCR);
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -1735,21 +1782,90 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tgen_subbo_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_SUBCC);
+}
+
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_SUBCC);
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rz, rJ),
+    .out_rrr = tgen_subbo_rrr,
+    .out_rri = tgen_subbo_rri,
 };
 
+static void tgen_subbi_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    /* TODO: OSA 2015 added SUBXC */
+    if (type == TCG_TYPE_I32) {
+        tcg_out_arith(s, a0, a1, a2, ARITH_SUBC);
+    } else {
+        tcg_out_arith(s, TCG_REG_T1, a1, a2, ARITH_SUB);  /* for CC */
+        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_SUB);  /* for CS */
+        /* Select the correct result based on actual borrow value. */
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
+    }
+}
+
+static void tgen_subbi_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_arithi(s, a0, a1, a2, ARITH_SUBC);
+    } else if (a2 != 0) {
+        tcg_out_arithi(s, TCG_REG_T1, a1, a2, ARITH_SUB);  /* for CC */
+        tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_SUB);   /* for CS */
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
+    } else if (a0 == a1) {
+        tcg_out_arithi(s, TCG_REG_T1, a1, 1, ARITH_SUB);
+        tcg_out_movcc(s, COND_CS, MOVCC_XCC, a0, TCG_REG_T1, false);
+    } else {
+        tcg_out_arithi(s, a0, a1, 1, ARITH_SUB);
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, a1, false);
+    }
+}
+
 static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rz, rJ),
+    .out_rrr = tgen_subbi_rrr,
+    .out_rri = tgen_subbi_rri,
 };
 
+static void tgen_subbio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        /* TODO: OSA 2015 added SUBXCCC */
+        tcg_out_dup_xcc_c(s);
+    }
+    tcg_out_arith(s, a0, a1, a2, ARITH_SUBCCC);
+}
+
+static void tgen_subbio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_dup_xcc_c(s);
+    }
+    tcg_out_arithi(s, a0, a1, a2, ARITH_SUBCCC);
+}
+
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rz, rJ),
+    .out_rrr = tgen_subbio_rrr,
+    .out_rri = tgen_subbio_rri,
 };
 
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_set_carry(s);  /* borrow == carry */
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
@@ -1886,17 +2002,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, a0, a1, a2, STW);
         break;
 
-    case INDEX_op_add2_i32:
-        tcg_out_addsub2_i32(s, args[0], args[1], args[2], args[3],
-                            args[4], const_args[4], args[5], const_args[5],
-                            ARITH_ADDCC, ARITH_ADDC);
-        break;
-    case INDEX_op_sub2_i32:
-        tcg_out_addsub2_i32(s, args[0], args[1], args[2], args[3],
-                            args[4], const_args[4], args[5], const_args[5],
-                            ARITH_SUBCC, ARITH_SUBC);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
         break;
@@ -1920,15 +2025,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, a0, a1, a2, STX);
         break;
 
-    case INDEX_op_add2_i64:
-        tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
-                            const_args[4], args[5], const_args[5], false);
-        break;
-    case INDEX_op_sub2_i64:
-        tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
-                            const_args[4], args[5], const_args[5], true);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -1975,12 +2071,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, rz, rz, rJ, rJ);
-
     default:
         return C_NotImplemented;
     }
-- 
2.43.0


