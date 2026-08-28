Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB35FC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jl-00010C-Lp; Fri, 28 Aug 2026 18:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jk-0000zB-1Z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:00 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jh-0004Lv-Uy
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:44:59 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3966791a6eeso1946267a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957095; x=1788561895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZIRC0JScoH9896L1OJzf3rQzLn6ug+3UA6NiOF3ZVbI=;
 b=tdN5R3E7bm/L6P40aP1not2CvBoeShylG1SBaPVVLY5LOIwMq9SNLh800Q+NRICeaT
 9c66KFA+W/IC5Be5YDdSvpKLpkQ0g6Gj3Vif3q82LKrPsKsFNujvmjeyBMqxh/H6RLY1
 Iq0idfy2f9apE2aeuj+FiTeIb7bt2cdoY3lNL3zuwAsqXvNvGroauRs5J/66Qq2F+1d9
 emdJLPT5h3azQaKyOgi2K6MKd9TD4V8lDxQeJ4fQ7GjLW7Xs3UWe2fcqCJ79vP9TXoKa
 QvpFp5bIc5x0PfBxckN6zLbc+QccTZJq61N85ZcKE1kv/0JWqEBZ9TRRZViWhAwoyC/x
 XiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957095; x=1788561895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZIRC0JScoH9896L1OJzf3rQzLn6ug+3UA6NiOF3ZVbI=;
 b=IWkwWz3AVFQ+q6saOWk9xx2NwQLXuqIun9IUR0MOykeBRHgmGdx1EudpUxvtJCPOYx
 fZPfMeg1SOajgN/RIbUhSxsXCFpbVkWl6wMVxWGJwb+dgGTiAc8bGCi7p3y3uyqvP/U5
 4XJe8ZCSs6jlC8kHqABWe+uzsmMxS7faAOXqkx1QvC/u+63XNZg8rDPD77xuXMI8Itah
 r+bWO7JJBUDu/qfWrtd6TFm0wg0BXEG93L+MB102rIR278Sk3IZxtXiSqJpmsoulLsnC
 OfZzkpmnbYcRv/7LEDB+dETucNGXeHtMeiBxxpTlB/9wuAjxhdEDZ0lXY4JfVyhmOa7/
 7ZjA==
X-Gm-Message-State: AFuF++nNc1poMrAeYDd4jYUbeIzKbCrrqQXdO8N+ekEIdb9a3xVi8fyg
 g7wb1znE50F5IRnL7r7mta2kNpYBnWQsEO3hrUz5JjGijDdSbk7IJAVuo9WyJecvliRbSPgEWKo
 qOQay
X-Gm-Gg: AYBFou2wOyFoYnTdCjjXVB8VUUmZSpiDyVcNThKkz/ulLhOZaufFFlfrVCJuN1SE6X3
 FritgZnXop3ZsQ2yBF178dbfrfP7yQLA0KHk8e9Lfq7zajgOeQ1sgfQLoUlEqKWraL86Q3gOWjd
 K3BA8kp7JlNfAu2LLKdAdOdJriMC03LxYU44lCnSKn/wqzr7BbYXXbmISgtxf6b8uxnjCfcuJq7
 w6RO+yFO850rtZYI+gy1JRTxOvaLpm/Fa7MK/EopW9L9Aux/aBKl9k9a4b9A1eoGH5EPEd50C5/
 H7UloBoxIjD1Zcsh4L2IWQYhWeUm2yGWzZzvsu66xD6EqfyCKq0QQF1xSDwQovAbz4ATlwFGSIQ
 S0gbpl8qmZP0W4fIdoqBODc/HZhTZJg9fd3DHJUOIog4vH3tyWb29dURcJKIwU8/Mhek7uNLtFi
 hcVI0HO9NB6hoYb569YVdCdOwPcWS5/lnm/z+tOb1tT25rewz+a94i9ekSw1cYlv4+H3JiykZHW
 0HlxyYWXpC8aXmDvhm3
X-Received: by 2002:a17:90b:3ec3:b0:37f:e177:f58 with SMTP id
 98e67ed59e1d1-396d0ebd7eemr17176348a91.9.1787957095190; 
 Fri, 28 Aug 2026 15:44:55 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:44:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 02/16] tcg: Add INDEX_op_lea
Date: Fri, 28 Aug 2026 15:44:37 -0700
Message-ID: <20260828224451.1564072-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add an opcode for compound address formation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  1 +
 tcg/aarch64/tcg-target-has.h     |  3 +++
 tcg/loongarch64/tcg-target-has.h |  3 +++
 tcg/ppc64/tcg-target-has.h       |  3 +++
 tcg/riscv64/tcg-target-has.h     |  3 +++
 tcg/s390x/tcg-target-has.h       |  3 +++
 tcg/sparc64/tcg-target-has.h     |  3 +++
 tcg/tci/tcg-target-has.h         |  3 +++
 tcg/x86_64/tcg-target-has.h      |  3 +++
 tcg/tcg.c                        | 22 ++++++++++++++++++++++
 docs/devel/tcg-ops.rst           |  4 ++++
 tcg/aarch64/tcg-target.c.inc     |  4 ++++
 tcg/loongarch64/tcg-target.c.inc |  4 ++++
 tcg/ppc64/tcg-target.c.inc       |  3 +++
 tcg/riscv64/tcg-target.c.inc     |  3 +++
 tcg/s390x/tcg-target.c.inc       |  3 +++
 tcg/sparc64/tcg-target.c.inc     |  3 +++
 tcg/tci/tcg-target.c.inc         |  4 ++++
 tcg/x86_64/tcg-target.c.inc      |  4 ++++
 19 files changed, 79 insertions(+)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index f3a81d5d7fb..884345afe56 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -64,6 +64,7 @@ DEF(ld16s, 1, 1, 1, TCG_OPF_INT)
 DEF(ld32u, 1, 1, 1, TCG_OPF_INT)
 DEF(ld32s, 1, 1, 1, TCG_OPF_INT)
 DEF(ld, 1, 1, 1, TCG_OPF_INT)
+DEF(lea, 1, 2, 2, TCG_OPF_INT)
 DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 69e83efb69d..86672b2eab4 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -57,4 +57,7 @@
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
 #define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 32abc6f4574..31e6ea9632d 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -54,4 +54,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/ppc64/tcg-target-has.h b/tcg/ppc64/tcg-target-has.h
index a3711feeae2..d11d82f1844 100644
--- a/tcg/ppc64/tcg-target-has.h
+++ b/tcg/ppc64/tcg-target-has.h
@@ -66,4 +66,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/riscv64/tcg-target-has.h b/tcg/riscv64/tcg-target-has.h
index aef10c2d9d6..93f8baad09f 100644
--- a/tcg/riscv64/tcg-target-has.h
+++ b/tcg/riscv64/tcg-target-has.h
@@ -69,4 +69,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 
 #define TCG_TARGET_deposit_valid(type, ofs, len)  0
 
+#define TCG_TARGET_lea_sh_valid(type, sh)         0
+#define TCG_TARGET_lea_imm_valid(type, imm)       0
+
 #endif
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 0aeb5ba01a9..58e3afe5266 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -77,4 +77,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index b29fd177f69..4182a7c1aae 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -19,4 +19,7 @@
 
 #define TCG_TARGET_deposit_valid(type, ofs, len) 0
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 64742cf0b71..f4f9ddf595f 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -17,4 +17,7 @@
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
 #define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/x86_64/tcg-target-has.h b/tcg/x86_64/tcg-target-has.h
index d249c1b3e7f..6ffae51f923 100644
--- a/tcg/x86_64/tcg-target-has.h
+++ b/tcg/x86_64/tcg-target-has.h
@@ -105,4 +105,7 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
+#define TCG_TARGET_lea_sh_valid(type, sh)          0
+#define TCG_TARGET_lea_imm_valid(type, imm)        0
+
 #endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ecc1f54c1bf..c0e149e7eab 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1095,6 +1095,12 @@ typedef struct TCGOutOpSubtract {
                     TCGReg a0, tcg_target_long a1, TCGReg a2);
 } TCGOutOpSubtract;
 
+typedef struct TCGOutOpLea {
+    TCGOutOp base;
+    void (*out)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                TCGReg a2, unsigned sh, tcg_target_long imm);
+} TCGOutOpLea;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -1191,6 +1197,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_ld16u, TCGOutOpLoad, outop_ld16u),
     OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
     OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
+    OUTOP(INDEX_op_lea, TCGOutOpLea, outop_lea),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -5788,6 +5795,21 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_lea:
+        {
+            const TCGOutOpLea *out = &outop_lea;
+            int sh = new_args[3];
+            tcg_target_long imm = new_args[4];
+
+            tcg_debug_assert(!const_args[1]);
+            tcg_debug_assert(!const_args[2]);
+            tcg_debug_assert(TCG_TARGET_lea_sh_valid(type, sh));
+            tcg_debug_assert(TCG_TARGET_lea_imm_valid(type, imm));
+
+            out->out(s, type, new_args[0], new_args[1], new_args[2], sh, imm);
+        }
+        break;
+
     case INDEX_op_goto_ptr:
         tcg_debug_assert(!const_args[0]);
         tcg_out_goto_ptr(s, new_args[0]);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 88d48a1f99a..51fa183e911 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -524,6 +524,10 @@ Misc
 
      - | Reverse the 64 bits of input *t1* with output in *dest*.
 
+   * - lea *dest*, *t1*, *t2*, *sh*, *imm*
+
+     - | *dest* = *t1* + (*t2* << *sh*) + *imm*.
+
 Conditional moves
 -----------------
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 4ebdef7e077..76adb2256f9 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3081,6 +3081,10 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 69e76807d6e..17784d8bbe2 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2098,6 +2098,10 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
diff --git a/tcg/ppc64/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
index cd1c2343672..99f4469f4b9 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -3633,6 +3633,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 2ce9d47a633..df4c4a9789b 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2725,6 +2725,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 4d1a779c47c..2fd7012d047 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3187,6 +3187,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 35cd14a5b65..cb457453ff9 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -2120,6 +2120,9 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
 
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4cd1c1431ce..6942fdbb4e0 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1220,6 +1220,10 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 /* Test if a constant matches the constraint. */
 static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece)
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 2c8f1f3e580..660350b963d 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -3327,6 +3327,10 @@ static const TCGOutOpStore outop_st = {
     .out_i = tgen_st_i,
 };
 
+static const TCGOutOpLea outop_lea = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static int const umin_insn[4] = {
     OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_VPMINUQ
 };
-- 
2.53.0


