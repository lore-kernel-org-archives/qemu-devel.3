Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DF7C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4o-0003oz-UA; Fri, 25 Apr 2025 17:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4I-0001Yz-C3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:47 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4E-0000qE-2m
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:45 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-225df540edcso40620995ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618320; x=1746223120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPaxO8+4JcFwI976uGjZhs8Qv1j0JWdDf2s0X9CAKew=;
 b=gQsRYMjPEuKwyTTOJE3UXBuUk+fpe7VlDBiRUrGZFuhzNBn2MJV6fXlY1HtHLdOO1L
 uQgTfWUlF9sdzQNQJbX8OdFe0+tJ5IeJRXPYZMF8DUA7B7MZqg4Un1aI/3Io+H10CSes
 CjBVc7NZ3PHci/ngI4WOp6Y+GlnP5R3buXAaUoURRD5BRDnojmse3qVWVUdi3SB6qILh
 Huil1Jn/Yru3yDBU/LqATuWTxRU1qlw1xcDKcLU/ZeaNdVPZI38bcZAdYjU0/8JVYbVl
 GL5YaZw38lSSQFBP+qSLRccdSl03lGYNfDTLofBA3VXDlMkUbEy2O4araBE3oT8L5VzZ
 rABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618320; x=1746223120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPaxO8+4JcFwI976uGjZhs8Qv1j0JWdDf2s0X9CAKew=;
 b=JWPsnskEbEZAwsD5/MtghsdVq68A5YcwqeWT/zAmytH284eoUZMMMc7Qaj3bNREN69
 PcZu4Au8sFGJ1H3E5RQ4ERngLIFclJHBX+41Rgx5iq2+4kW72+DAMub6qk+YGeNxxujQ
 0CnVPoBWJrd1wm8MN8uvHwzJeuTpvp/bN/jexD+U0oEsx736u3U1qK60mFcSsoE+D7+M
 tbroexGsa/IgfXG0UXFiMk2qiqWc8XWXlkWA0q1KJLgvdBJ1McI4RnQdTDVdbAU9GkO2
 GRWRUTuwhMZaNqkn9vcUlrgFQiEemxwr4u0QbiEISUAulwb5/vXkU6zqz+juNVwytghV
 4DSw==
X-Gm-Message-State: AOJu0YxFp33rMTA3PWTVsMHayFnROCxSCi0LkStv40zQ8X4Q5r1/CEMK
 ADKTy0Z5RcYZtx2CK2bYRpz/OB/0i5F76Vum5pMA1aQJMiuECH8A9e64XVTb+vyEx81uhjQ8Vmo
 P
X-Gm-Gg: ASbGncuocCPpb35f/9W9ot6GJZx7IUu75UTpD07kqlgn5NzTbLmuJDvdbZpHG61+8dZ
 Fd6IWkEW4yCzk4ihllQ1FHiUrQE5nvP6OOtMwjCBNm0PvLQ9h3avViQcYeUrylXb4BUuu7Q40H1
 zXak8s6Sgi2iZA7oN3jB1HFg1IfkqOGh9VUo7NP+UBUR2e37LGmPu4AMmQ0Yil9isBapxhYYqLt
 XgOKyU8XCxjDI93pjcdot+7+BxUzxTa/fXAbnyyU0sZHdaBhditDM9d/FgTdDP3VhRDkI55g0Zm
 lFH2fcRebbXwL+Nr0GtATphSRn3Fz8hK9Akkp/GRbp9hkiOKk8wEmqn4qtkw1YGd137aHmRyzUo
 =
X-Google-Smtp-Source: AGHT+IFvXJuQmUq1jbNJCyHqaFYC1GKONaCsIUDjnHk7KdemYC5VdH3BS2ZaZLtPa5NShYQwTEjfqg==
X-Received: by 2002:a17:903:2f85:b0:220:cfb7:56eb with SMTP id
 d9443c01a7336-22dbf993914mr53978385ad.26.1745618320094; 
 Fri, 25 Apr 2025 14:58:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 057/159] tcg: Convert shl to TCGOutOpBinary
Date: Fri, 25 Apr 2025 14:53:11 -0700
Message-ID: <20250425215454.886111-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        |  6 ++--
 tcg/aarch64/tcg-target.c.inc     | 38 ++++++++++----------
 tcg/arm/tcg-target.c.inc         | 25 +++++++++----
 tcg/i386/tcg-target.c.inc        | 60 +++++++++++++++++++++++---------
 tcg/loongarch64/tcg-target.c.inc | 43 ++++++++++++++---------
 tcg/mips/tcg-target.c.inc        | 35 ++++++++++++-------
 tcg/ppc/tcg-target.c.inc         | 42 ++++++++++++----------
 tcg/riscv/tcg-target.c.inc       | 38 +++++++++++---------
 tcg/s390x/tcg-target.c.inc       | 37 ++++++++++++++++----
 tcg/sparc64/tcg-target.c.inc     | 27 ++++++++++----
 tcg/tci/tcg-target.c.inc         | 14 ++++++--
 11 files changed, 241 insertions(+), 124 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index cd89ef1faa..369a1e6d48 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1042,6 +1042,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
+    OUTOP(INDEX_op_shl_i32, TCGOutOpBinary, outop_shl),
+    OUTOP(INDEX_op_shl_i64, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
@@ -2262,7 +2264,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_extract_i32:
@@ -2314,7 +2315,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_ext_i32_i64:
@@ -5423,6 +5423,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
+    case INDEX_op_shl_i32:
+    case INDEX_op_shl_i64:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 8aa11e9d9d..b57baa1eec 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1347,14 +1347,6 @@ static inline void tcg_out_extr(TCGContext *s, TCGType ext, TCGReg rd,
     tcg_out_insn(s, 3403, EXTR, ext, rd, rn, rm, a);
 }
 
-static inline void tcg_out_shl(TCGContext *s, TCGType ext,
-                               TCGReg rd, TCGReg rn, unsigned int m)
-{
-    int bits = ext ? 64 : 32;
-    int max = bits - 1;
-    tcg_out_ubfm(s, ext, rd, rn, (bits - m) & max, (max - m) & max);
-}
-
 static inline void tcg_out_shr(TCGContext *s, TCGType ext,
                                TCGReg rd, TCGReg rn, unsigned int m)
 {
@@ -2299,6 +2291,25 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3508, LSLV, type, a0, a1, a2);
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int max = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_ubfm(s, type, a0, a1, -a2 & max, ~a2 & max);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2416,15 +2427,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_shl_i64:
-    case INDEX_op_shl_i32:
-        if (c2) {
-            tcg_out_shl(s, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3508, LSLV, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_shr_i64:
     case INDEX_op_shr_i32:
         if (c2) {
@@ -3091,12 +3093,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index c08cd712b1..2b9e52914c 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1963,6 +1963,25 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, a0, 0, a1, SHIFT_REG_LSL(a2));
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, a0, 0, a1,
+                    SHIFT_IMM_LSL(a2 & 0x1f));
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2114,11 +2133,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_muls2_i32:
         tcg_out_smull32(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
-    /* XXX: Perhaps args[2] & 0x1f is wrong */
-    case INDEX_op_shl_i32:
-        c = const_args[2] ?
-                SHIFT_IMM_LSL(args[2] & 0x1f) : SHIFT_REG_LSL(args[2]);
-        goto gen_shift32;
     case INDEX_op_shr_i32:
         c = const_args[2] ? (args[2] & 0x1f) ? SHIFT_IMM_LSR(args[2] & 0x1f) :
                 SHIFT_IMM_LSL(0) : SHIFT_REG_LSR(args[2]);
@@ -2300,7 +2314,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
 
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 02dd440052..648d9ee66c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2744,6 +2744,49 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static TCGConstraintSetIndex cset_shift(TCGType type, unsigned flags)
+{
+    return have_bmi2 ? C_O1_I2(r, r, ri) : C_O1_I2(r, 0, ci);
+}
+
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    if (have_bmi2) {
+        tcg_out_vex_modrm(s, OPC_SHLX + rexw, a0, a2, a1);
+    } else {
+        tcg_out_modrm(s, OPC_SHIFT_cl + rexw, SHIFT_SHL, a0);
+    }
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+
+    /* For small constant 3-operand shift, use LEA.  */
+    if (a0 != a1 && a2 >= 1 && a2 <= 3) {
+        if (a2 == 1) {
+            /* shl $1,a1,a0 -> lea (a1,a1),a0 */
+            tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a1, 0, 0);
+        } else {
+            /* shl $n,a1,a0 -> lea 0(,a1,n),a0 */
+            tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, -1, a1, a2, 0);
+        }
+        return;
+    }
+    tcg_out_mov(s, type, a0, a1);
+    tcg_out_shifti(s, SHIFT_SHL + rexw, a0, a2);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_shift,
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2879,21 +2922,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(shl):
-        /* For small constant 3-operand shift, use LEA.  */
-        if (const_a2 && a0 != a1 && (a2 - 1) < 3) {
-            if (a2 - 1 == 0) {
-                /* shl $1,a1,a0 -> lea (a1,a1),a0 */
-                tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a1, 0, 0);
-            } else {
-                /* shl $n,a1,a0 -> lea 0(,a1,n),a0 */
-                tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, -1, a1, a2, 0);
-            }
-            break;
-        }
-        c = SHIFT_SHL;
-        vexop = OPC_SHLX;
-        goto gen_shift_maybe_vex;
     OP_32_64(shr):
         c = SHIFT_SHR;
         vexop = OPC_SHRX;
@@ -3759,8 +3787,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a0313b1140..9e34c37e62 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1489,6 +1489,32 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sll_w(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_sll_d(s, a0, a1, a2);
+    }
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_slli_w(s, a0, a1, a2 & 0x1f);
+    } else {
+        tcg_out_opc_slli_d(s, a0, a1, a2 & 0x3f);
+    }
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1660,21 +1686,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_clzctz(s, OPC_CTZ_D, a0, a1, a2, c2, false);
         break;
 
-    case INDEX_op_shl_i32:
-        if (c2) {
-            tcg_out_opc_slli_w(s, a0, a1, a2 & 0x1f);
-        } else {
-            tcg_out_opc_sll_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_shl_i64:
-        if (c2) {
-            tcg_out_opc_slli_d(s, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_sll_d(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_shr_i32:
         if (c2) {
             tcg_out_opc_srli_w(s, a0, a1, a2 & 0x1f);
@@ -2369,8 +2380,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index bd38c7ab95..30d8872b4f 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1908,6 +1908,29 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_SLLV : OPC_DSLLV;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sa(s, OPC_SLL, a0, a1, a2);
+    } else {
+        tcg_out_dsll(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2068,9 +2091,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_sar_i32:
         i1 = OPC_SRAV, i2 = OPC_SRA;
         goto do_shift;
-    case INDEX_op_shl_i32:
-        i1 = OPC_SLLV, i2 = OPC_SLL;
-        goto do_shift;
     case INDEX_op_shr_i32:
         i1 = OPC_SRLV, i2 = OPC_SRL;
         goto do_shift;
@@ -2099,13 +2119,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         i1 = OPC_DSRAV;
         goto do_shiftv;
-    case INDEX_op_shl_i64:
-        if (c2) {
-            tcg_out_dsll(s, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DSLLV;
-        goto do_shiftv;
     case INDEX_op_shr_i64:
         if (c2) {
             tcg_out_dsrl(s, a0, a1, a2);
@@ -2293,12 +2306,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotr_i32:
     case INDEX_op_rotl_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotr_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 80ee4d04c9..88cfcd1d91 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3122,6 +3122,30 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? SLW : SLD;
+    tcg_out32(s, insn | SAB(a1, a0, a2));
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    /* Limit immediate shift count lest we create an illegal insn.  */
+    if (type == TCG_TYPE_I32) {
+        tcg_out_shli32(s, a0, a1, a2 & 31);
+    } else {
+        tcg_out_shli64(s, a0, a1, a2 & 63);
+    }
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3272,14 +3296,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
         break;
 
-    case INDEX_op_shl_i32:
-        if (const_args[2]) {
-            /* Limit immediate shift count lest we create an illegal insn.  */
-            tcg_out_shli32(s, args[0], args[1], args[2] & 31);
-        } else {
-            tcg_out32(s, SLW | SAB(args[1], args[0], args[2]));
-        }
-        break;
     case INDEX_op_shr_i32:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
@@ -3325,14 +3341,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond2(s, args, const_args);
         break;
 
-    case INDEX_op_shl_i64:
-        if (const_args[2]) {
-            /* Limit immediate shift count lest we create an illegal insn.  */
-            tcg_out_shli64(s, args[0], args[1], args[2] & 63);
-        } else {
-            tcg_out32(s, SLD | SAB(args[1], args[0], args[2]));
-        }
-        break;
     case INDEX_op_shr_i64:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
@@ -4206,12 +4214,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 38ba898042..372c4e1651 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2144,6 +2144,27 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SLLW : OPC_SLL;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SLLIW : OPC_SLLI;
+    unsigned mask = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_opc_imm(s, insn, a0, a1, a2 & mask);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2257,21 +2278,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_shl_i32:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_SLLIW, a0, a1, a2 & 0x1f);
-        } else {
-            tcg_out_opc_reg(s, OPC_SLLW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_shl_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_SLLI, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_reg(s, OPC_SLL, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_shr_i32:
         if (c2) {
             tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2 & 0x1f);
@@ -2758,12 +2764,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 8702d8c928..ed68054664 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2445,6 +2445,36 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_shl_int(TCGContext *s, TCGType type, TCGReg dst,
+                         TCGReg src, TCGReg v, tcg_target_long i)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_sh64(s, RSY_SLLG, dst, src, v, i);
+    } else if (dst == src) {
+        tcg_out_sh32(s, RS_SLL, dst, v, i);
+    } else {
+        tcg_out_sh64(s, RSY_SLLK, dst, src, v, i);
+    }
+}
+
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tgen_shl_int(s, type, a0, a1, a2, 0);
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_shl_int(s, type, a0, a1, TCG_REG_NONE, a2);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2574,9 +2604,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_shl_i32:
-        op = RS_SLL;
-        op2 = RSY_SLLK;
     do_shift32:
         a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
         if (a0 == a1) {
@@ -2746,8 +2773,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RRFa, MGRK, args[1], args[2], args[3]);
         break;
 
-    case INDEX_op_shl_i64:
-        op = RSY_SLLG;
     do_shift64:
         if (const_args[2]) {
             tcg_out_sh64(s, op, args[0], args[1], TCG_REG_NONE, args[2]);
@@ -3346,7 +3371,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i32:
@@ -3363,7 +3387,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
         return C_O1_I2(r, r, ri);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index d465c8dd06..6b320a8622 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1484,6 +1484,27 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? SHIFT_SLL : SHIFT_SLLX;
+    tcg_out_arith(s, a0, a1, a2, insn);
+}
+
+static void tgen_shli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? SHIFT_SLL : SHIFT_SLLX;
+    uint32_t mask = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_arithi(s, a0, a1, a2 & mask, insn);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_shl,
+    .out_rri = tgen_shli,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1587,8 +1608,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_st32_i64:
         tcg_out_ldst(s, a0, a1, a2, STW);
         break;
-    case INDEX_op_shl_i32:
-        c = SHIFT_SLL;
     do_shift32:
         /* Limit immediate shift count lest we create an illegal insn.  */
         tcg_out_arithc(s, a0, a1, a2 & 31, c2, c);
@@ -1656,8 +1675,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_st_i64:
         tcg_out_ldst(s, a0, a1, a2, STX);
         break;
-    case INDEX_op_shl_i64:
-        c = SHIFT_SLLX;
     do_shift64:
         /* Limit immediate shift count lest we create an illegal insn.  */
         tcg_out_arithc(s, a0, a1, a2 & 63, c2, c);
@@ -1751,8 +1768,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index eb30fd04ba..748bb8118f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -79,8 +79,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
@@ -778,6 +776,17 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_shl_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_shl,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -862,7 +871,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(shl)
     CASE_32_64(shr)
     CASE_32_64(sar)
     CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
-- 
2.43.0


