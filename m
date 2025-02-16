Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7BCC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjntr-0003bl-5h; Sun, 16 Feb 2025 18:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntF-0002aV-JV
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:37 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntB-00062W-Sb
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:33 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220dc3831e3so52076345ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747848; x=1740352648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fNtGq0SsbbChHJewFvtgUXvfR0PgNhS/AisQUr8LYFg=;
 b=PTIbQtgl2OPwdO3zxAwAnxYY827z0B69Dxkfqo+B4sSBHHvzt5ZhXfJvXV5gYaqqeH
 Lm8WoOupiQhQXNO7wA/6VnMAQDEcvCxC42odGVVu2mhZe3A6LnNTbj7qYts7Gry1vIzf
 2nNY9a1eRHAcNL609vLVuvcCDu7Iz21ZBDQcVd5i6AyO4C+gtYFVhaO7bSZ/1xQI8l6v
 5I5OTIhlbgLBGcNkL+wusWzblwdm8rQ+VGHZ5P5ctyxZA2j7lAyRdS77bW3NMRWekGL3
 ezGX7IQN909OhF4Nz29I43Wm0shm+tfwNtU+BOjGWxa/1+qmll8ddfXFpBrAMs6XdiDS
 F/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747848; x=1740352648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNtGq0SsbbChHJewFvtgUXvfR0PgNhS/AisQUr8LYFg=;
 b=M7uvbn8J7zvaRALNXM/vVo6kWQTBG+KXKG0UXsBGbif/nQYuzsqn5fxwXW7J4DUS3O
 5wuC3ZZaofVOsEgzLv5OECKjoKU8aXrJvLQntBIRu8z9JbgDvpR9IpUXPkggkSBLCF/p
 AAx83qRyU+cwzwuC7P/VaBOb5FRJBkgSl5VHN6HhpOiZ/9/uYjWsjXeJ6uLCBSv0fYRI
 rIxnb+EcqCEkiY9k5P6Ef/NtnaUKrT2zjshrrcuag7sfMHmCUZlnUYzjCxVC94inXhU0
 AVif6PbjYYY3Lt/yHXCnCtfFoDlEPFkHS9jWg+mHfKrnpMDRKsJNxvhHBvfX9G2CC/Ij
 HGCg==
X-Gm-Message-State: AOJu0Yy3NKkhtkM8tMoy9kpJwnWKHcE+DFpjFk2om+T3UIlLPuRHRrXe
 7Wdjn1Cr0CogABqE3++cPGAN0gou66gdrdhwtTiWuthbQHMrNqFAdQv411sFAFTH9LBAg+12nh4
 +
X-Gm-Gg: ASbGnct2K1vqXSRK/4eYwgUzg+hZEGANTF9lSCPc1cr7g0ufpd7KL21pF095woaswKk
 rBslOjXJYMWclSs98RcNWYi1RSk5VigViXuKwDMS7ryvXjJlozHunkXe9M0q7Dbl2V/kc9KRv7Q
 IdvdEBm0xICn5/Qsi52otEnyDaWOYq6h4vZGgqkkTrsdiZaA4r2xvWbwjt1Dp9DOO2TwM7Cjfmv
 u1n/pB1TeqP9O5arNxFDeyNcS6PgAaDuTjTx2sZLiej4EdPy1X00pjVmWzbDqPJfMd8WCgMRJOE
 QDCmDGb1gxhaqNaIR4kO2VgG8HFeIq6NQSZj+GcQ9L/OWyc=
X-Google-Smtp-Source: AGHT+IGgiUaa05BErLG+qRsRVRTyhlmFpkxF+cNrRJ/2oiPqbhiMqgwG8DDw06vyIjBiXjCYSMe/rw==
X-Received: by 2002:a17:902:ce06:b0:21f:40de:ae4e with SMTP id
 d9443c01a7336-2210458f528mr128119965ad.9.1739747848187; 
 Sun, 16 Feb 2025 15:17:28 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 098/162] tcg: Convert extrl_i64_i32 to TCGOutOpUnary
Date: Sun, 16 Feb 2025 15:09:07 -0800
Message-ID: <20250216231012.2808572-99-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
index a247096582..a3d9493673 100644
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
@@ -5435,10 +5446,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
@@ -5491,6 +5498,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_bswap64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
         assert(TCG_TARGET_REG_BITS == 64);
         /* fall through */
     case INDEX_op_ctpop:
@@ -6648,6 +6656,22 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
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
@@ -6690,6 +6714,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
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
index ea43316121..0594aba59b 100644
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
index 2a2eab314e..07dc69cb6f 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2370,7 +2370,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
@@ -2395,7 +2394,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
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


