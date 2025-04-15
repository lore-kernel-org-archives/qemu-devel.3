Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3333C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mG6-0008BT-NV; Tue, 15 Apr 2025 15:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m8S-0003E1-8S
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:39:59 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m7K-0005fR-0I
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:39:55 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3feaedb6670so3968123b6e.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745920; x=1745350720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T7A5a3IRYSE8JMYxVl126vfxyyM6fGr0hdFmuEefY6k=;
 b=pM9Ug6LELqqEZm7wM1H6/9vIN1TAsd08xn9hpMAjS6FicxkHcS2X3Ezy26mAGntmVm
 DNBxVNdcfocCpASvkNLfFj541VEFBwNTsrAJeDntDIFKC8BiqaEtCDXEVH5jXcY5pMzH
 Biw9wg14U8Cy7hLsfK1DwHepKWlQhafqu+pwiSJDarhU4vStyGbzKhcDi7G/Qo8LOdR5
 srDHRbkk9fAX01KtPZJ6mDlHnenuajZ7qemHX3hgfgkEx7cVaSLK4eyDQuImILJlvZh9
 rCkiAWmj6CR7qMCnuU9aTotSUD3pnYNnN8/Ilck73yHWa+rY422kRTvl4IteFkEiU8lO
 Bgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745920; x=1745350720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7A5a3IRYSE8JMYxVl126vfxyyM6fGr0hdFmuEefY6k=;
 b=M6RkTxIql2WiwwjoBkQ9fTZF6wHPKoeXsOnSmauISV2+saa7CHtCepu+L5SO4gsz9I
 VYY9sz+UJwThDknd3cw4eWeHM3PBZZEVxz0uFKlVzV6ZDJnBchpXPu/wpMN9KN35HeLg
 YlFxx8yA/mQer7LYav50iY2oc19y1REACFXb2lS+KzGaGBpwXHVcm80tVZbnjt/jn+zn
 ivlh89O2aMdHaCVWn02QhtvP0qjvViPjbUEjWDOQt/+u6U9Y3kkS2BD0glfVDlAHRR26
 cvzOyqkyybN8cs9Eyr8wgRmJXQAPolyCyVbZtmHry1qoIp+pVW4Ox/6wtnyw+cYUUrn4
 P2Tg==
X-Gm-Message-State: AOJu0Ywpx9ittEMHNwy2V20BF+biZDQoB1mlc5PhGmx4p7SX22FQV2sk
 Uo5eyoizwwVLoFFkl7HsDJlsr3MelPkzgcyk8YwE5coyHamOY2kcB7uC/SqUfOLgdFPzv+/qZLI
 Q
X-Gm-Gg: ASbGnctUJLjzmcw970mNbKFcAf9LF9Fh6DnnEw0VNdKDSmgSye2jOdR2dbdkE1qQngf
 mJLFLiV/Z9sJLF2pydzSRurjf+/VBWuVThT8XhB5CtuEg0McbnLlb5GR4w3PIj14Cw4FHfnKErX
 h6P5mVNFH1GiK9bs2G9RBHgroDBshfSbOpuwPho5LUk6UY6/o5HwPSfJu6poDQvnlNyO3A1Euj7
 JJqK6t3DtmZzjMmVKOiwEGjTkevk1XndYphMW9mQycqVMnLX65VSxa7NmvxbrsSnRx9D1YE3QC9
 D+q2C8VMA8aYWl9T+7Mqe4Uyk41JFNEGmuSLoEt1dN5EAVNaTB2vfM/cdp0UXz6hhucFUCR6YLx
 /xoTbIDBjrQ==
X-Google-Smtp-Source: AGHT+IFbHsr+vRVWMZfHd+MmCQWLKWXRrrKi8D7iqUaL/N6p1hdTviCnLRuG5x4as7H6W3Y+ZjIZ3A==
X-Received: by 2002:a17:902:c951:b0:223:65dc:4580 with SMTP id
 d9443c01a7336-22c31ac30fdmr4937255ad.52.1744745560349; 
 Tue, 15 Apr 2025 12:32:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 099/163] tcg: Convert extrl_i64_i32 to TCGOutOpUnary
Date: Tue, 15 Apr 2025 12:24:10 -0700
Message-ID: <20250415192515.232910-100-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

Drop the cast from TCGv_i64 to TCGv_i32 in tcg_gen_extrl_i64_i32
an emit extrl_i64_i32 unconditionally.  Move that special case
to tcg_gen_code when we find out if the output is live or dead.
In this way even hosts that canonicalize truncations can make
use of a store directly from the 64-bit host register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c                     |  4 +---
 tcg/tcg.c                        | 35 +++++++++++++++++++++++++++-----
 tcg/aarch64/tcg-target.c.inc     |  1 -
 tcg/i386/tcg-target.c.inc        |  4 ----
 tcg/loongarch64/tcg-target.c.inc |  2 --
 tcg/mips/tcg-target.c.inc        |  2 --
 tcg/ppc/tcg-target.c.inc         |  1 -
 tcg/riscv/tcg-target.c.inc       |  2 --
 tcg/s390x/tcg-target.c.inc       |  1 -
 tcg/tci/tcg-target.c.inc         |  1 -
 10 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d3f3c9d248..7ecd1f6c8f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2962,11 +2962,9 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_LOW(arg));
-    } else if (TCG_TARGET_HAS_extr_i64_i32) {
+    } else {
         tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
-    } else {
-        tcg_gen_mov_i32(ret, (TCGv_i32)arg);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b6c1efa828..84083d133d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1093,6 +1093,16 @@ static const TCGOutOpUnary outop_extu_i32_i64 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_extu_i32_i64,
 };
+
+static void tgen_extrl_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_extrl_i64_i32(s, a0, a1);
+}
+
+static const TCGOutOpUnary outop_extrl_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = TCG_TARGET_HAS_extr_i64_i32 ? tgen_extrl_i64_i32 : NULL,
+};
 #endif
 
 /*
@@ -1151,6 +1161,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
     OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
     OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
+    OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
 #endif
 };
 
@@ -2400,12 +2411,12 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
     case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
     case INDEX_op_extract2_i64:
         return TCG_TARGET_HAS_extract2_i64;
-    case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return TCG_TARGET_HAS_extr_i64_i32;
     case INDEX_op_add2_i64:
@@ -5438,10 +5449,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     /* emit instruction */
     TCGType type = TCGOP_TYPE(op);
     switch (op->opc) {
-    case INDEX_op_extrl_i64_i32:
-        tcg_out_extrl_i64_i32(s, new_args[0], new_args[1]);
-        break;
-
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
@@ -5499,6 +5506,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_bswap64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
         assert(TCG_TARGET_REG_BITS == 64);
         /* fall through */
     case INDEX_op_ctpop:
@@ -6657,6 +6665,22 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         TCGOpcode opc = op->opc;
 
         switch (opc) {
+        case INDEX_op_extrl_i64_i32:
+            assert(TCG_TARGET_REG_BITS == 64);
+            /*
+             * If TCG_TYPE_I32 is represented in some canonical form,
+             * e.g. zero or sign-extended, then emit as a unary op.
+             * Otherwise we can treat this as a plain move.
+             * If the output dies, treat this as a plain move, because
+             * this will be implemented with a store.
+             */
+            if (TCG_TARGET_HAS_extr_i64_i32) {
+                TCGLifeData arg_life = op->life;
+                if (!IS_DEAD_ARG(0)) {
+                    goto do_default;
+                }
+            }
+            /* fall through */
         case INDEX_op_mov:
         case INDEX_op_mov_vec:
             tcg_reg_alloc_mov(s, op);
@@ -6699,6 +6723,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
             }
             /* fall through */
         default:
+        do_default:
             /* Sanity check that we've not introduced any unhandled opcodes. */
             tcg_debug_assert(tcg_op_supported(opc, TCGOP_TYPE(op),
                                               TCGOP_FLAGS(op)));
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 44314f6a0f..8abc5f26da 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2710,7 +2710,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 8371cfaf5a..9bae60d3b6 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3413,7 +3413,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
@@ -3999,9 +3998,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
-    case INDEX_op_extrl_i64_i32:
-        return C_O1_I1(r, r);
-
     case INDEX_op_extract2_i32:
     case INDEX_op_extract2_i64:
         return C_O1_I2(r, 0, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 3a85b6f4ba..59457c4323 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1931,7 +1931,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
@@ -2457,7 +2456,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(r, r, r);
 
-    case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index b6b7070fbb..095eb8f672 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2364,7 +2364,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
@@ -2389,7 +2388,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
 
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index e1767f1d6c..bb03efe055 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3640,7 +3640,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 48d4325097..76ad2df410 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2630,7 +2630,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
@@ -2872,7 +2871,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index d81b8fb8f4..1ea041c75f 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2997,7 +2997,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 3cf2913acd..e9b46d5e66 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1107,7 +1107,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


