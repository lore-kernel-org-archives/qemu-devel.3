Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A1BE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bl-0005un-D3; Tue, 07 Jan 2025 03:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4av-0001aC-Sd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:45 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4am-0003fM-FC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:45 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so17955462a91.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237135; x=1736841935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sU+BFTvQDWkwP402ArE9dx27VJs93mtYw3GL7XCqBYs=;
 b=Zj+4Doaxtwz55gaRFWkllvBVF/oIlxxhVJNqrgwTwYPyKdVd7ffSIdyl1V679zU66W
 gJXoSFJaZgW91lzAz1qo+iaEPsSVg8UlwIEKH9VQwMQ6BeOFuxZrE/FGBL7Pi+o6J/cN
 H7l17ygNSNRDsv+78cCnbWII9Ps9gLDXiMKEn5wtqIIqizN2Gi+ZVhLDvT0fovLl7q12
 oegQpP6VUJcyeFvRluWJpXWbi8u5CXsfL2xujllY5a2e0e9fFrir8bHEzn2WuvLf0sRS
 dBE9/5/ym0ip1Vfl+6BUHlAvMW0d3jGtXRgUCXeqXG77NtcB4gGYGWrXT3qACIJv7nJ5
 zBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237135; x=1736841935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sU+BFTvQDWkwP402ArE9dx27VJs93mtYw3GL7XCqBYs=;
 b=jYsusW6UkuiX3sdOX3rChA+U2PGzV/tLGYDlsvaTAeUxkCHzu0q9CrAZN8HR1K7RQ3
 khKXrFkq8ISqgtzYq4/9EJLxDamRPbtVkPEDhLB/imfNcjcjCsXWnv1xo8e2zoEeY73A
 lZqJCLiaX5cqw4mCOnvWKiCvgsYXNiBJ3i2ZSYhSSPl4sL/r9F67RdxnuIjDjr2qpmpS
 WmVdcl5Nf6UIznMJeOKXpU5zuhSP+nto/YTD/bXgb3FsBNHM5UvTT/lctcqvPmNxbcZ2
 hIrnuks5926F9zTuyd0w8h8DN7sNTymarZB4HSzbi6S4uh+Pyd+nE6sNODQ+pWc08pLO
 v9lQ==
X-Gm-Message-State: AOJu0YxXkagLs7xCx5VqoM1iBQf1/OvexQ2WSfzj4CK3v5lHfeYlI/vr
 WGk0UqiH8AcRt0jgTRQN8EhhVZV1n9WP/bvbjgzN1NdwbFwrVyocOED2Bq5lvr9ZYS34QpAOYGe
 Q
X-Gm-Gg: ASbGncuDxCCZJzdPm4YvqjcqSWCo5c95OWF6p0eqBV05K73vfBbVzuNg87ec1ChUPDI
 wGpVONf0ZPwXMLhvqskzFkIc+hDvvUILphhgJWSyawYNHmz1pmTLCePiVhroWLwbSkN9B7jYyPC
 b9VPDBuIIQMvvvvxQAZb7TA8C+Ic5OItG/owpXQrDLh/rvRTkZV9QACsuVRRglPhvEeoUSAAuOU
 a1dRzjN8GZZ61BM0hUq9PSp3Af3nItF4QoE65pAgauHjhMfRyLSbzZtaN1FH6ODrjbh671g0anT
 173lKEjSuhG3pkhpHA==
X-Google-Smtp-Source: AGHT+IFifRxE1jm4h6k0IjAo8g5ntkHMZVNERScLt7oajNYF+vtLExHJu6Y4sjQg3uVmEUvEL0Oqyg==
X-Received: by 2002:a05:6a00:ac2:b0:72a:ae66:3050 with SMTP id
 d2e1a72fcca58-72abde40466mr81048983b3a.1.1736237134770; 
 Tue, 07 Jan 2025 00:05:34 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 76/81] tcg: Convert sub to TCGOutOpSubtract
Date: Tue,  7 Jan 2025 00:01:07 -0800
Message-ID: <20250107080112.1175095-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
 tcg/mips/tcg-target-con-set.h    |  1 -
 tcg/ppc/tcg-target-con-set.h     |  3 +-
 tcg/riscv/tcg-target-con-set.h   |  1 -
 tcg/riscv/tcg-target-con-str.h   |  1 -
 tcg/tcg.c                        | 26 ++++++++++++++--
 tcg/aarch64/tcg-target.c.inc     | 24 +++++++--------
 tcg/arm/tcg-target.c.inc         | 29 +++++++++++-------
 tcg/i386/tcg-target.c.inc        | 23 +++++++-------
 tcg/loongarch64/tcg-target.c.inc | 32 +++++++++-----------
 tcg/mips/tcg-target.c.inc        | 31 ++++++++-----------
 tcg/ppc/tcg-target.c.inc         | 52 +++++++++++---------------------
 tcg/riscv/tcg-target.c.inc       | 45 +++++++++------------------
 tcg/s390x/tcg-target.c.inc       | 41 +++++++++++--------------
 tcg/sparc64/tcg-target.c.inc     | 16 +++++++---
 tcg/tci/tcg-target.c.inc         | 14 +++++++--
 15 files changed, 165 insertions(+), 174 deletions(-)

diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
index 864034f468..1b9803eba3 100644
--- a/tcg/mips/tcg-target-con-set.h
+++ b/tcg/mips/tcg-target-con-set.h
@@ -24,7 +24,6 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rIK)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rWZ)
-C_O1_I2(r, rZ, rN)
 C_O1_I2(r, rZ, rZ)
 C_O1_I4(r, rZ, rZ, rZ, 0)
 C_O1_I4(r, rZ, rZ, rZ, rZ)
diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index 453abde6c1..77a1038d51 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -22,8 +22,7 @@ C_O1_I1(v, r)
 C_O1_I1(v, v)
 C_O1_I1(v, vr)
 C_O1_I2(r, 0, rZ)
-C_O1_I2(r, rI, ri)
-C_O1_I2(r, rI, rT)
+C_O1_I2(r, rI, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rC)
diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 32a435092a..2449647845 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -16,7 +16,6 @@ C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
-C_O1_I2(r, rZ, rN)
 C_O1_I2(r, rZ, rZ)
 C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index 33577da7bf..ff03a08bbd 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -18,6 +18,5 @@ REGS('v', ALL_VECTOR_REGS)
 CONST('I', TCG_CT_CONST_S12)
 CONST('K', TCG_CT_CONST_S5)
 CONST('L', TCG_CT_CONST_CMP_VI)
-CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 59577784db..a87aac8a32 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -970,6 +970,14 @@ typedef struct TCGOutOpBinary {
                     TCGReg a0, TCGReg a1, tcg_target_long a2);
 } TCGOutOpBinary;
 
+typedef struct TCGOutOpSubtract {
+    TCGOutOp base;
+    void (*out_rrr)(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2);
+    void (*out_rir)(TCGContext *s, TCGType type,
+                    TCGReg a0, tcg_target_long a1, TCGReg a2);
+} TCGOutOpSubtract;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -999,6 +1007,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
+    OUTOP(INDEX_op_sub_i32, TCGOutOpSubtract, outop_sub),
+    OUTOP(INDEX_op_sub_i64, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
 
@@ -2231,7 +2241,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_sub_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
     case INDEX_op_shl_i32:
@@ -2301,7 +2310,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_sub_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
     case INDEX_op_shl_i64:
@@ -5433,6 +5441,20 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+        {
+            const TCGOutOpSubtract *out = &outop_sub;
+
+            tcg_debug_assert(!const_args[2]);
+            if (const_args[1]) {
+                out->out_rir(s, type, new_args[0], new_args[1], new_args[2]);
+            } else {
+                out->out_rrr(s, type, new_args[0], new_args[1], new_args[2]);
+            }
+        }
+        break;
+
     default:
         if (def->flags & TCG_OPF_VECTOR) {
             tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 966af79314..0d417169d2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2205,6 +2205,17 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3502, SUB, type, a0, a1, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2294,15 +2305,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, REG0(0), a1, a2, 3);
         break;
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        if (c2) {
-            tgen_addi(s, ext, a0, a1, -a2);
-        } else {
-            tcg_out_insn(s, 3502, SUB, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_neg_i64:
     case INDEX_op_neg_i32:
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
@@ -3026,10 +3028,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, r, rA);
-
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 52a1ca5a4e..6e567da031 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1941,6 +1941,24 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_SUB, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_subfi(TCGContext *s, TCGType type,
+                       TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tcg_out_dat_imm(s, COND_AL, ARITH_RSB, a0, a2, encode_imm_nofail(a1));
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, rI, r),
+    .out_rrr = tgen_sub,
+    .out_rir = tgen_subfi,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2008,15 +2026,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_dat_rIK(s, tcg_cond_to_arm_cond[c], ARITH_MOV,
                         ARITH_MVN, args[0], 0, args[3], const_args[3]);
         break;
-    case INDEX_op_sub_i32:
-        if (const_args[1]) {
-            tcg_out_dat_imm(s, COND_AL, ARITH_RSB,
-                            args[0], args[2], encode_imm_nofail(args[1]));
-        } else {
-            tcg_out_dat_rIN(s, COND_AL, ARITH_SUB, ARITH_ADD,
-                            args[0], args[1], args[2], const_args[2]);
-        }
-        break;
     case INDEX_op_add2_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
         a3 = args[3], a4 = args[4], a5 = args[5];
@@ -2277,8 +2286,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
-    case INDEX_op_sub_i32:
-        return C_O1_I2(r, rI, r);
 
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 47d0323426..11704a7bad 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2734,6 +2734,18 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_SUB + rexw, a0, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, 0, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2836,15 +2848,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(sub):
-        c = ARITH_SUB;
-        if (const_a2) {
-            tgen_arithi(s, c + rexw, a0, a2, 0);
-        } else {
-            tgen_arithr(s, c + rexw, a0, a2);
-        }
-        break;
-
     OP_32_64(mul):
         if (const_a2) {
             int32_t val;
@@ -3784,8 +3787,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
         return C_O1_I2(r, 0, re);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index efc483a550..07ed40c5c4 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1371,6 +1371,21 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sub_w(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_sub_d(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1591,21 +1606,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_sub_i32:
-        if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I32, a0, a1, -a2);
-        } else {
-            tcg_out_opc_sub_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_sub_i64:
-        if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I64, a0, a1, -a2);
-        } else {
-            tcg_out_opc_sub_d(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_neg_i32:
         tcg_out_opc_sub_w(s, a0, TCG_REG_ZERO, a1);
         break;
@@ -2337,10 +2337,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         /* Must deposit into the same register as input */
         return C_O1_I2(r, 0, rZ);
 
-    case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
         return C_O1_I2(r, rZ, ri);
-    case INDEX_op_sub_i64:
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rZ, rJ);
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 3a039a805d..3f42835fef 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1776,6 +1776,18 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_SUBU : OPC_DSUBU;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1872,22 +1884,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    do_binaryv:
-        tcg_out_opc_reg(s, i1, a0, a1, a2);
-        break;
-
-    case INDEX_op_sub_i32:
-        i1 = OPC_SUBU, i2 = OPC_ADDIU;
-        goto do_subtract;
-    case INDEX_op_sub_i64:
-        i1 = OPC_DSUBU, i2 = OPC_DADDIU;
-    do_subtract:
-        if (c2) {
-            tcg_out_opc_imm(s, i2, a0, a1, -a2);
-            break;
-        }
-        goto do_binaryv;
-
     case INDEX_op_mul_i32:
         if (use_mips32_instructions) {
             tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
@@ -2288,9 +2284,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, rZ, rN);
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_muluh_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index fe43583e8b..74ab9e43f5 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3054,6 +3054,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, SUBF | TAB(a0, a2, a1));
+}
+
+static void tgen_subfi(TCGContext *s, TCGType type,
+                       TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, rI, r),
+    .out_rrr = tgen_sub,
+    .out_rir = tgen_subfi,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3142,21 +3160,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_sub_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[1]) {
-            if (const_args[2]) {
-                tcg_out_movi(s, TCG_TYPE_I32, a0, a1 - a2);
-            } else {
-                tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
-            }
-        } else if (const_args[2]) {
-            tgen_addi(s, type, a0, a1, (int32_t)-a2);
-        } else {
-            tcg_out32(s, SUBF | TAB(a0, a2, a1));
-        }
-        break;
-
     case INDEX_op_clz_i32:
         tcg_out_cntxz(s, TCG_TYPE_I32, CNTLZW, args[0], args[1],
                       args[2], const_args[2]);
@@ -3269,21 +3272,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, NOR | SAB(args[1], args[0], args[1]));
         break;
 
-    case INDEX_op_sub_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[1]) {
-            if (const_args[2]) {
-                tcg_out_movi(s, TCG_TYPE_I64, a0, a1 - a2);
-            } else {
-                tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
-            }
-        } else if (const_args[2]) {
-            tgen_addi(s, type, a0, a1, -a2);
-        } else {
-            tcg_out32(s, SUBF | TAB(a0, a2, a1));
-        }
-        break;
-
     case INDEX_op_shl_i64:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
@@ -4269,10 +4257,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muluh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_sub_i32:
-        return C_O1_I2(r, rI, ri);
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, rI, rT);
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
     case INDEX_op_clz_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 6d600a9940..70d1479e7d 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -114,10 +114,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 
 #define TCG_CT_CONST_ZERO    0x100
 #define TCG_CT_CONST_S12     0x200
-#define TCG_CT_CONST_N12     0x400
-#define TCG_CT_CONST_M12     0x800
-#define TCG_CT_CONST_S5     0x1000
-#define TCG_CT_CONST_CMP_VI 0x2000
+#define TCG_CT_CONST_M12     0x400
+#define TCG_CT_CONST_S5      0x800
+#define TCG_CT_CONST_CMP_VI 0x1000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -403,13 +402,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_S12) && val >= -0x800 && val <= 0x7ff) {
         return 1;
     }
-    /*
-     * Sign extended from 12 bits, negated: [-0x7ff, 0x800].
-     * Used for subtraction, where a constant must be handled by ADDI.
-     */
-    if ((ct & TCG_CT_CONST_N12) && val >= -0x7ff && val <= 0x800) {
-        return 1;
-    }
     /*
      * Sign extended from 12 bits, +/- matching: [-0x7ff, 0x7ff].
      * Used by addsub2 and movcond, which may need the negative value,
@@ -2058,6 +2050,18 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SUBW : OPC_SUB;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2139,21 +2143,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_sub_i32:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, -a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_SUBW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_sub_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDI, a0, a1, -a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_SUB, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
         tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
@@ -2714,10 +2703,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, rZ, rN);
-
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_muluh_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 3b55ec4ac8..dbc8641baf 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2331,6 +2331,23 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, SGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, SR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, SRK, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2413,17 +2430,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_sub_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tgen_addi(s, type, a0, a1, (int32_t)-a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RR, SR, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, SRK, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_neg_i32:
         tcg_out_insn(s, RR, LCR, args[0], args[1]);
         break;
@@ -2624,15 +2630,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_sub_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tgen_addi(s, type, a0, a1, -a2);
-        } else {
-            tcg_out_insn(s, RRFa, SGRK, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_neg_i64:
         tcg_out_insn(s, RRE, LCGR, args[0], args[1]);
         break;
@@ -3308,10 +3305,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, r, ri);
-
     case INDEX_op_mul_i32:
         return (HAVE_FACILITY(MISC_INSN_EXT2)
                 ? C_O1_I2(r, r, ri)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 06772166bd..4b2549c82e 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1377,6 +1377,17 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_SUB);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1449,9 +1460,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_st32_i64:
         tcg_out_ldst(s, a0, a1, a2, STW);
         break;
-    OP_32_64(sub):
-        c = ARITH_SUB;
-        goto gen_arith;
     case INDEX_op_shl_i32:
         c = SHIFT_SLL;
     do_shift32:
@@ -1671,8 +1679,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_div_i64:
     case INDEX_op_divu_i32:
     case INDEX_op_divu_i64:
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index c4fa585c30..519a16b31d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -91,8 +91,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_shl_i32:
@@ -733,6 +731,17 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_sub_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -786,7 +795,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(sub)
     CASE_32_64(mul)
     CASE_32_64(shl)
     CASE_32_64(shr)
-- 
2.43.0


