Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC9AC021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyT-0007uc-TS; Sun, 16 Feb 2025 18:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwq-0004Wo-FD
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:17 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwk-0006UW-7m
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:15 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso95184805ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748068; x=1740352868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D6KnqAoGs09FK6AnAjzUXt13HNu7no9XA9RZ0FrxjO4=;
 b=Iu2RBUwsOM43GZm91adz/jTlHMPz3pesIlN4YVwnTzCIHeJ+nCznMUNzIxS54WcY3Y
 Vqc7lF3nb3puaQB+W1fUYatGTyZ+jV1RoZn6bhqL/pLajnQLnMWyf1I54+IulsTdRB8h
 IS6f4AeL1fZhFncNjaAfmsYOJTUsKp9GXTRXtoddMJoQmqLTk06uG87eNaF5APJPwW9o
 n+UrZNR+C7LoY5BnoLquvk2UGmyC6yLr9Nle0sJMQhAUxPzd3B3YbQQmTPIdSg6NCf2h
 +apTHoU0XTbxcwQYbpjJiK4LCQNS+nBvdRHwJeKKvbE4fGEBrqfuztZR6XuJxAPaiLaj
 nyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748068; x=1740352868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6KnqAoGs09FK6AnAjzUXt13HNu7no9XA9RZ0FrxjO4=;
 b=Yn52Us2uiRMKXiJY29GCuzTs/cGS7MoYhuCTyKEcxzrcnvR1QELIZ8Is330j9eU5vi
 7ASI3ylxdeDZ8OyA8cLODDAqXEALZP/fXbrTjDUv/8kGBfrCCIOxPU78cMhqPm9r4lO+
 50XRWS/y5xyh0H3y3wr2Dll3aJNRaqbD1USOzA3wk51kRzNF+i+0qHvNJURrez48BSar
 upOakM/FSNDTgxLXJps9E8SXM6S9cLggi8SQAfeufg+goyo4S6/Ps1bEEq+vXogP9T0g
 /Mm4j1ER7qb9Qe3YA8I1CB5AvA3OlX0rCGMto62JaS24NnoN95O48EaJ6MA/Kylzh3iP
 k98g==
X-Gm-Message-State: AOJu0Yyj3byb1I5eLCsSkIlrbe93OU9wZpJZPl4EWE7Y8GUqk4ZCdM1u
 x6cVWJtZd50YpnnbtKsLjWHV8AIlfA3Qac3xPLGsdkZI8H73+AqkDqcXMKs68hho+7AT77IBczQ
 6
X-Gm-Gg: ASbGnctpbEAPgV6u7h2+UvlmYNbvJ5FeW1lTof+3dhIbs9PzzmR0baf3tS/T7Xdj5EJ
 0xpY5xQIsSP89ZsdVgOYJH6ygWI0VvHYV1+36aQerPtL0fPgSHj11kw1tBsIqA8VBmAOAHqAX4m
 3qXHqGWwwHZhfM+2l4yre7Wb0RRAfXzivWh0JOPJtJORCvOoHrDooGHwPUIBBMIJo9q3uBop+Q3
 qStvvrUv/TSHNUEDam9u9e1EPsvEhg5eT+FUEHAxWufTyj4WsxpzAAwH3ayJf2VvGFETmvfqUjY
 kNIezTy/eERkS5NDQQfF15nvpPgz0wTOwuaXnc/FKg59+fQ=
X-Google-Smtp-Source: AGHT+IG/589+p2K30dPrhu5ZCkGvh+U46Smag9+HTGLMxqcrAL8yyzmozqLxb7e4fB6Qog+OrZYmuQ==
X-Received: by 2002:a17:902:cccc:b0:21f:454:953c with SMTP id
 d9443c01a7336-221040d6c4bmr121657395ad.52.1739748067893; 
 Sun, 16 Feb 2025 15:21:07 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 148/162] tcg: Remove add2/sub2 opcodes
Date: Sun, 16 Feb 2025 15:09:57 -0800
Message-ID: <20250216231012.2808572-149-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

All uses have been replaced by add/sub carry opcodes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  5 --
 tcg/aarch64/tcg-target-has.h     |  5 --
 tcg/arm/tcg-target-has.h         |  4 --
 tcg/i386/tcg-target-has.h        |  5 --
 tcg/loongarch64/tcg-target-has.h |  4 --
 tcg/mips/tcg-target-has.h        |  5 --
 tcg/ppc/tcg-target-has.h         |  4 --
 tcg/riscv/tcg-target-has.h       |  5 --
 tcg/s390x/tcg-target-has.h       |  7 ---
 tcg/sparc64/tcg-target-has.h     |  7 ---
 tcg/tcg-has.h                    |  2 -
 tcg/tci/tcg-target-has.h         |  4 --
 tcg/optimize.c                   | 87 --------------------------------
 tcg/tcg-op.c                     | 26 ----------
 tcg/tcg.c                        | 36 -------------
 15 files changed, 206 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 9cc20cd62c..30ba15723a 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -102,8 +102,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 
-DEF(add2_i32, 2, 4, 0, 0)
-DEF(sub2_i32, 2, 4, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
@@ -126,9 +124,6 @@ DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(add2_i64, 2, 4, 0, 0)
-DEF(sub2_i64, 2, 4, 0, 0)
-
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
 /* There are tcg_ctx->insn_start_words here, not just one. */
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 695effd77c..b155e37639 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -13,14 +13,9 @@
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
  * which requires writable pages.  We must defer to the helper for user-only,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index f4bd15c68a..187269e5bd 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,12 +24,8 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
-
 #define TCG_TARGET_HAS_tst              1
 
 #define TCG_TARGET_HAS_v64              use_neon_instructions
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index a984a6af2e..628e736de7 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,14 +26,9 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
-
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index a1bd71db6a..9c118bd1f6 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -10,14 +10,10 @@
 #include "host/cpuinfo.h"
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
 
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 9d86906bf3..d8f9f7beef 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -39,13 +39,8 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
-
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
 #endif
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 4dda668706..b978c91a62 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -18,13 +18,9 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index c95dc1921e..8cd099546f 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -11,13 +11,8 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
-
 #define TCG_TARGET_HAS_tst              0
 
 /* vector instructions */
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 17e61130cd..c04cc4e377 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -29,16 +29,9 @@ extern uint64_t s390_facilities[3];
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32       0
-#define TCG_TARGET_HAS_sub2_i32       0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
-
-#define TCG_TARGET_HAS_add2_i64       0
-#define TCG_TARGET_HAS_sub2_i64       0
-
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
-
 #define TCG_TARGET_HAS_tst            1
 
 #define TCG_TARGET_HAS_v64            HAVE_FACILITY(VECTOR)
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index caf7679595..d9f5ef3fc9 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,16 +14,9 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
-
 #define TCG_TARGET_HAS_tst              1
 
 #define TCG_TARGET_extract_valid(type, ofs, len) \
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 50e8d0cda4..2fc0e50d20 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -12,8 +12,6 @@
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 #endif
 
 #if !defined(TCG_TARGET_HAS_v64) \
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 310d45ba62..497e8152b7 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -8,13 +8,9 @@
 #define TCG_TARGET_HAS_H
 
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 #endif /* TCG_TARGET_REG_BITS == 64 */
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 442f5b75e6..0f661a8c0b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1387,82 +1387,6 @@ static bool fold_addco(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
-{
-    bool a_const = arg_is_const(op->args[2]) && arg_is_const(op->args[3]);
-    bool b_const = arg_is_const(op->args[4]) && arg_is_const(op->args[5]);
-
-    if (a_const && b_const) {
-        uint64_t al = arg_info(op->args[2])->val;
-        uint64_t ah = arg_info(op->args[3])->val;
-        uint64_t bl = arg_info(op->args[4])->val;
-        uint64_t bh = arg_info(op->args[5])->val;
-        TCGArg rl, rh;
-        TCGOp *op2;
-
-        if (ctx->type == TCG_TYPE_I32) {
-            uint64_t a = deposit64(al, 32, 32, ah);
-            uint64_t b = deposit64(bl, 32, 32, bh);
-
-            if (add) {
-                a += b;
-            } else {
-                a -= b;
-            }
-
-            al = sextract64(a, 0, 32);
-            ah = sextract64(a, 32, 32);
-        } else {
-            Int128 a = int128_make128(al, ah);
-            Int128 b = int128_make128(bl, bh);
-
-            if (add) {
-                a = int128_add(a, b);
-            } else {
-                a = int128_sub(a, b);
-            }
-
-            al = int128_getlo(a);
-            ah = int128_gethi(a);
-        }
-
-        rl = op->args[0];
-        rh = op->args[1];
-
-        /* The proper opcode is supplied by tcg_opt_gen_mov. */
-        op2 = tcg_op_insert_before(ctx->tcg, op, 0, 2);
-
-        tcg_opt_gen_movi(ctx, op, rl, al);
-        tcg_opt_gen_movi(ctx, op2, rh, ah);
-        return true;
-    }
-
-    /* Fold sub2 r,x,i to add2 r,x,-i */
-    if (!add && b_const) {
-        uint64_t bl = arg_info(op->args[4])->val;
-        uint64_t bh = arg_info(op->args[5])->val;
-
-        /* Negate the two parts without assembling and disassembling. */
-        bl = -bl;
-        bh = ~bh + !bl;
-
-        op->opc = (ctx->type == TCG_TYPE_I32
-                   ? INDEX_op_add2_i32 : INDEX_op_add2_i64);
-        op->args[4] = arg_new_constant(ctx, bl);
-        op->args[5] = arg_new_constant(ctx, bh);
-    }
-    return finish_folding(ctx, op);
-}
-
-static bool fold_add2(OptContext *ctx, TCGOp *op)
-{
-    /* Note that the high and low parts may be independently swapped. */
-    swap_commutative(op->args[0], &op->args[2], &op->args[4]);
-    swap_commutative(op->args[1], &op->args[3], &op->args[5]);
-
-    return fold_addsub2(ctx, op, true);
-}
-
 static bool fold_and(OptContext *ctx, TCGOp *op)
 {
     uint64_t z1, z2, z_mask, s_mask;
@@ -2799,11 +2723,6 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_sub2(OptContext *ctx, TCGOp *op)
-{
-    return fold_addsub2(ctx, op, false);
-}
-
 static void squash_prev_borrowout(OptContext *ctx, TCGOp *op)
 {
     TempOptInfo *t2;
@@ -3138,9 +3057,6 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_addco:
             done = fold_addco(&ctx, op);
             break;
-        CASE_OP_32_64(add2):
-            done = fold_add2(&ctx, op);
-            break;
         case INDEX_op_and:
         case INDEX_op_and_vec:
             done = fold_and(&ctx, op);
@@ -3330,9 +3246,6 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_sub_vec:
             done = fold_sub_vec(&ctx, op);
             break;
-        CASE_OP_32_64(sub2):
-            done = fold_sub2(&ctx, op);
-            break;
         case INDEX_op_xor:
         case INDEX_op_xor_vec:
             done = fold_xor(&ctx, op);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b0a29278ab..b0139ce05d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -249,24 +249,6 @@ static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4, a5);
 }
 
-static void DNI tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                TCGv_i32 a3, TCGv_i32 a4,
-                                TCGv_i32 a5, TCGv_i32 a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5),
-                tcgv_i32_arg(a6));
-}
-
-static void DNI tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                TCGv_i64 a3, TCGv_i64 a4,
-                                TCGv_i64 a5, TCGv_i64 a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5),
-                tcgv_i64_arg(a6));
-}
-
 static void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                  TCGv_i32 a3, TCGv_i32 a4,
                                  TCGv_i32 a5, TCGArg a6)
@@ -1108,8 +1090,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
         tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
         tcg_gen_mov_i32(rl, t0);
         tcg_temp_free_i32(t0);
-    } else if (TCG_TARGET_HAS_add2_i32) {
-        tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
@@ -1159,8 +1139,6 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
         tcg_gen_op3_i32(INDEX_op_subbi, rh, ah, bh);
         tcg_gen_mov_i32(rl, t0);
         tcg_temp_free_i32(t0);
-    } else if (TCG_TARGET_HAS_sub2_i32) {
-        tcg_gen_op6_i32(INDEX_op_sub2_i32, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
@@ -2880,8 +2858,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 
         tcg_gen_mov_i64(rl, t0);
         tcg_temp_free_i64(t0);
-    } else if (TCG_TARGET_HAS_add2_i64) {
-        tcg_gen_op6_i64(INDEX_op_add2_i64, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
@@ -2985,8 +2961,6 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 
         tcg_gen_mov_i64(rl, t0);
         tcg_temp_free_i64(t0);
-    } else if (TCG_TARGET_HAS_sub2_i64) {
-        tcg_gen_op6_i64(INDEX_op_sub2_i64, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 6f28caf02e..7e7ba252fa 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2430,11 +2430,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return true;
 
-    case INDEX_op_add2_i32:
-        return TCG_TARGET_HAS_add2_i32;
-    case INDEX_op_sub2_i32:
-        return TCG_TARGET_HAS_sub2_i32;
-
     case INDEX_op_brcond2_i32:
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
@@ -2456,11 +2451,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrh_i64_i32:
         return TCG_TARGET_REG_BITS == 64;
 
-    case INDEX_op_add2_i64:
-        return TCG_TARGET_HAS_add2_i64;
-    case INDEX_op_sub2_i64:
-        return TCG_TARGET_HAS_sub2_i64;
-
     case INDEX_op_mov_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_dupm_vec:
@@ -4101,32 +4091,6 @@ liveness_pass_1(TCGContext *s)
             la_reset_pref(ts);
             break;
 
-        case INDEX_op_add2_i32:
-        case INDEX_op_add2_i64:
-            opc_new = INDEX_op_add;
-            goto do_addsub2;
-        case INDEX_op_sub2_i32:
-        case INDEX_op_sub2_i64:
-            opc_new = INDEX_op_sub;
-        do_addsub2:
-            assert_carry_dead(s);
-            /* Test if the high part of the operation is dead, but not
-               the low part.  The result can be optimized to a simple
-               add or sub.  This happens often for x86_64 guest when the
-               cpu mode is set to 32 bit.  */
-            if (arg_temp(op->args[1])->state == TS_DEAD) {
-                if (arg_temp(op->args[0])->state == TS_DEAD) {
-                    goto do_remove;
-                }
-                /* Replace the opcode and adjust the args in place,
-                   leaving 3 unused args at the end.  */
-                op->opc = opc = opc_new;
-                op->args[1] = op->args[2];
-                op->args[2] = op->args[4];
-                /* Fall through and mark the single-word operation live.  */
-            }
-            goto do_not_remove;
-
         case INDEX_op_muls2:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh;
-- 
2.43.0


