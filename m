Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5FDC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4x-0004Ic-Ot; Fri, 25 Apr 2025 17:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4S-0002Ch-NQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:57 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4P-0000sp-Gj
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:56 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2295d78b433so32364495ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618332; x=1746223132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhzSQ6GVtyI136z9cDu2oM8AfJY4R4BApeks+9VIt3A=;
 b=qKRLck3trtrpGdKUI3/IkFeW5LIrTv35rYnPEvgTNmOsJAZ+UTfdBN2dkEVQQlWziS
 U0QLKUwKoh9Yv147mGetJpYs7nEXR5kjBhL5R/OMabgBTQlJHXkJpAOi+bXcJpxlZFeO
 teMewSeBhusX9uHisnfmC0NIBs5GnCtl0pzUVUTpW55YawrLkNIQw3SGUJyfNtxFeis+
 oHhOCOCb6w26fANTJnazL9HAn4mZ0ZyT5Nw01SztS3r6/Ms+zmQsxF/EDme+yoUH6vXM
 j5PGik3rQD6wAC6Gvq/nwb3rFaLbHaNvfy8h6s0bQnQY9HSDEB9tIdUNnhmAqIFF10MK
 KcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618332; x=1746223132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lhzSQ6GVtyI136z9cDu2oM8AfJY4R4BApeks+9VIt3A=;
 b=jO0GUM9ZLXGm/NCO1EHLMcDu+Czc3Ed4A1KmZt/HLpf1XMx8vnioMRdjEa9iC93mbs
 a+EVh3ks0HE0KGuahLaRnGUlB4EeXrjTxkj/GJpRQjK7OPv0aHA1Exi2ECChb0uQJ/lb
 WuMcOhi2TUBL7kwkPB4fjKbLIijcEwsAtrnkFKyNxXHEVU1A3TxLo4MGzRkZq6oCLhVX
 HkwznosLgrK46gGZwrXewTYCxzZ0J1meEZTRDf/7An5vyqERGAPnZ/B/rKLBuN86j+u+
 kPzAb9roIBmMNkwg93dpwbeM+reRAwaS93fe1/tUSm41olGwGniQUqqYMcGdI8ZfARvC
 T4gg==
X-Gm-Message-State: AOJu0Yz+HPTrnLoZOgc+QKDcct4I8cPpF9EkrDvRXx9MNgBNIR1e+AFG
 SSdhTbiXXZvH/5hWjtvyfEJMNVBOgGHA7XEu6OmBmfAgecgtpcBYI2zrhWr1CocJpmFz32mU/dX
 q
X-Gm-Gg: ASbGncssMfOT1QEaRuiTcLQ8zs1a/2pAhPxDSpoCeffO4hKZ/6/BkHt0lsF309xlMfv
 G6N+8HwQSUypzXl3lj1LVuu/UdrVfuCppbXYZeJAKvajOzDXEGpCMxL9PPiZCub95ZeTFqY7neT
 VIYtz4VNCKPMU1DJMKlxuKtw7p2B/phkQmDg9T4siicg3lyOTwMmP2vw0NHrZrP9aGpGsuL0DMc
 xQj4cFoy3zNyhHje5XeknOgedCVkUfzVjUPM3CQpqo0JmWnuOKjQUkkfoOOwJuEnFqc/EenJsq/
 4PkX2JIHLfgywH9ocSHjNKh4t7FuTkH/PxK0Z8ZAIjgqka1MfJDEjJP02Y6M1+JJkZcmhpItVtw
 =
X-Google-Smtp-Source: AGHT+IFIbEZQESJJygImTxomtrmGlSPeh5mvzbx6OQzs37EYXT9sMa5OrWJD0ZNhUDF7/rboUn4GLw==
X-Received: by 2002:a17:903:2306:b0:223:628c:199 with SMTP id
 d9443c01a7336-22dc6a83602mr14957875ad.52.1745618331720; 
 Fri, 25 Apr 2025 14:58:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 073/159] tcg: Merge INDEX_op_muls2_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:27 -0700
Message-ID: <20250425215454.886111-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 17 +++++++++--------
 tcg/tcg-op.c             |  8 ++++----
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                |  6 ++----
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  3 +--
 7 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index f4ccde074b..a45b22ca1a 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -51,6 +51,7 @@ DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
+DEF(muls2, 2, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
 DEF(muluh, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
@@ -92,7 +93,6 @@ DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(add2_i32, 2, 4, 0, 0)
 DEF(sub2_i32, 2, 4, 0, 0)
 DEF(mulu2_i32, 2, 2, 0, 0)
-DEF(muls2_i32, 2, 2, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
@@ -134,7 +134,6 @@ DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(add2_i64, 2, 4, 0, 0)
 DEF(sub2_i64, 2, 4, 0, 0)
 DEF(mulu2_i64, 2, 2, 0, 0)
-DEF(muls2_i64, 2, 2, 0, 0)
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index bf625f770c..756f681e88 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2074,16 +2074,17 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
             h = (int32_t)(l >> 32);
             l = (int32_t)l;
             break;
-        case INDEX_op_muls2_i32:
-            l = (int64_t)(int32_t)a * (int32_t)b;
-            h = l >> 32;
-            l = (int32_t)l;
-            break;
         case INDEX_op_mulu2_i64:
             mulu64(&l, &h, a, b);
             break;
-        case INDEX_op_muls2_i64:
-            muls64(&l, &h, a, b);
+        case INDEX_op_muls2:
+            if (ctx->type == TCG_TYPE_I32) {
+                l = (int64_t)(int32_t)a * (int32_t)b;
+                h = l >> 32;
+                l = (int32_t)l;
+            } else {
+                muls64(&l, &h, a, b);
+            }
             break;
         default:
             g_assert_not_reached();
@@ -2973,7 +2974,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_muluh:
             done = fold_mul_highpart(&ctx, op);
             break;
-        CASE_OP_32_64(muls2):
+        case INDEX_op_muls2:
         CASE_OP_32_64(mulu2):
             done = fold_multiply2(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8a0846a8d2..0f48484dfe 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1162,8 +1162,8 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_muls2_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_muls2_i32, rl, rh, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I32, 0)) {
+        tcg_gen_op4_i32(INDEX_op_muls2, rl, rh, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
@@ -2880,8 +2880,8 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_muls2_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_muls2_i64, rl, rh, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I64, 0)) {
+        tcg_gen_op4_i64(INDEX_op_muls2, rl, rh, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b1efc44725..5b22c75d2e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1041,8 +1041,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
-    OUTOP(INDEX_op_muls2_i32, TCGOutOpMul2, outop_muls2),
-    OUTOP(INDEX_op_muls2_i64, TCGOutOpMul2, outop_muls2),
+    OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
     OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
@@ -4008,8 +4007,7 @@ liveness_pass_1(TCGContext *s)
             }
             goto do_not_remove;
 
-        case INDEX_op_muls2_i32:
-        case INDEX_op_muls2_i64:
+        case INDEX_op_muls2:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh;
             goto do_mul2;
@@ -5477,8 +5475,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_muls2_i32:
-    case INDEX_op_muls2_i64:
+    case INDEX_op_muls2:
         {
             const TCGOutOpMul2 *out =
                 container_of(all_outop[op->opc], TCGOutOpMul2, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 51cbb5760a..708ded34c7 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -581,8 +581,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop_tr(regs[r1]);
             break;
-        case INDEX_op_muls2_i32:
-        case INDEX_op_muls2_i64:
+        case INDEX_op_muls2:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
 #if TCG_TARGET_REG_BITS == 32
             tmp64 = (int64_t)(int32_t)regs[r2] * (int32_t)regs[r3];
@@ -1095,10 +1094,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            str_r(r3), str_r(r4), str_c(c));
         break;
 
+    case INDEX_op_muls2:
     case INDEX_op_mulu2_i32:
     case INDEX_op_mulu2_i64:
-    case INDEX_op_muls2_i32:
-    case INDEX_op_muls2_i64:
         tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
                            op_name, str_r(r0), str_r(r1),
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index fb7764e3c0..0394767291 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -604,7 +604,7 @@ Multiword arithmetic support
      - | Similar to mul, except two unsigned inputs *t1* and *t2* yielding the full
          double-word product *t0*. The latter is returned in two single-word outputs.
 
-   * - muls2_i32/i64 *t0_low*, *t0_high*, *t1*, *t2*
+   * - muls2 *t0_low*, *t0_high*, *t1*, *t2*
 
      - | Similar to mulu2, except the two inputs *t1* and *t2* are signed.
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index f568d4edb9..aa3ce929b4 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -716,8 +716,7 @@ static TCGConstraintSetIndex cset_mul2(TCGType type, unsigned flags)
 static void tgen_muls2(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
 {
-    tcg_out_op_rrrr(s, glue(INDEX_op_muls2_i,TCG_TARGET_REG_BITS),
-                    a0, a1, a2, a3);
+    tcg_out_op_rrrr(s, INDEX_op_muls2, a0, a1, a2, a3);
 }
 
 static const TCGOutOpMul2 outop_muls2 = {
-- 
2.43.0


