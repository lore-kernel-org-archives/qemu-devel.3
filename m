Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C98FC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R9o-0000tj-0Z; Fri, 25 Apr 2025 18:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7k-0005LG-0P
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:20 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7f-0001Mj-0d
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:19 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3015001f862so2492033a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618533; x=1746223333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dFu3erw8QebCT2bQbR33ezjocRDUb/YaKz+rrW9bXM=;
 b=X8w6rtJCnFRxxiqNF2hx8NvbeyGbXlN2uXo92eJ9hlq9qBfMeT13hKLhBbns7MYLb5
 7V4Um19WiLLiSxqJzr7lKDakPhEVDyJ92lZi0beR8dNVYyvxZP8ymlxsRzqaIdHQzTn4
 hm0VlpeXr1hr17LiLj5DbMQtCBrIMmDtj9q/AnyVrCJNs4FPET6IGYtzEeqcGdRmjYx4
 hoFv90ZOuUSpkwCFLnlFlGcfAjmucMlhN9iZ4Ww8bPreE4QtesyLanDSV+Sq/TXMEqdg
 fOs49OYx5mauVGry2hSDHM/Gh14xZCyyhNMA4FB7FE8HQu4ah2pOz9pMplee9jbbpdAr
 XutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618533; x=1746223333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dFu3erw8QebCT2bQbR33ezjocRDUb/YaKz+rrW9bXM=;
 b=NRUbyOC1rmrHG9+KXGaeO7qrvuKDsfxBXIlpR/0ffhkpyQMzLJj7JdY+blYNUp4qeb
 ew8jC/fpdZX19eRevlaCausw43cB9M5uuw0SA3SLwp4uliUdmKT9spRZ+XtDRqaSpycz
 V7Xr4Ek+WQk7B1BACz4IVwBs0tz0nNkkUzL3S/Y5vouKwqqlXCxowWcv8HqhYQVgXqCH
 1XwjdrQ0JNCcw32ZlFFC5mlL2P518qh+Tx8dl+XnGKxj8SfYwhDqo2NZ+ztedjGOmm6b
 vDOJNN1LwdCyHd9dbE+rVmq8rcR96Opg7k/ilW21Jdb5WLkZ12C8HA7Zt6PxaHIlMDNf
 MABA==
X-Gm-Message-State: AOJu0YxoSIsmcal9beIJ8OhkvTLzpzsPiNYJ8U7B/R5Dt1ZyZpybPs4w
 5FH/R7mMyBUezFG4xru90abiK+csy+a9zZrISIUG/vEbYEibxfhvnB/zQj7mp7abMOAqGTuMgk8
 1
X-Gm-Gg: ASbGnctPSF/3C1lrjaQ5TNFvXWpeDqxPeOK0lxIrBW4vpeDVaief3rF3OPkTM7hvlb9
 3EMyjBV8TihEoFE87HVMB5QQmqn7sWO+jarMZJbTDSTi6c9Orny0BIJMhytwg7toqtnGxHlJH8x
 BErVMZC/700/3AmLirG/l7DPJSfbC89pNzWRQrnrytYQEAzDc1+PX754MVpTTFviCvRgrWLMuBG
 XYId9C10IJg8x+YJGzKnu7dPowurwJ8t7TJvVxfd8T99IgyaFLwaj8G24JhtoVyE3a/12Q8JI7t
 tsI4lG6wopeHr4Y7gWlhVuLY6HPMg8Fg5N7oWKt6HQkORPpcwmc+nJWfABXx/TS1pzpMSby/+ek
 =
X-Google-Smtp-Source: AGHT+IHCnxMbQJ3/2n/GX7g2rr8FKgEEHpOfHDk9rfyJ+k1pP/wj4mkxpsLBW7BQnvdsQJgbRFwy8w==
X-Received: by 2002:a17:90b:38c7:b0:2ff:698d:ef7c with SMTP id
 98e67ed59e1d1-309f7e8f486mr5414635a91.29.1745618533006; 
 Fri, 25 Apr 2025 15:02:13 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 103/159] tcg: Convert extrl_i64_i32 to TCGOutOpUnary
Date: Fri, 25 Apr 2025 14:53:57 -0700
Message-ID: <20250425215454.886111-104-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 0b2dc17600..8fcaf54d32 100644
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
@@ -5441,10 +5452,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
@@ -5502,6 +5509,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_bswap64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
         assert(TCG_TARGET_REG_BITS == 64);
         /* fall through */
     case INDEX_op_ctpop:
@@ -6660,6 +6668,22 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
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
@@ -6702,6 +6726,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
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
index 60356d5dfd..fae1a58c94 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1943,7 +1943,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
@@ -2463,7 +2462,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
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


