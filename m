Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31A8C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R0n-0007HK-A1; Fri, 25 Apr 2025 17:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0h-0007E7-AO
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:03 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0f-0000IW-0x
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:02 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so2394130b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618099; x=1746222899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eO5DfNMHmibDzC5S7R129uJ9XbuwIQeM7aiNNCULxXU=;
 b=GFDSyLlmnsv+mYUcuKdFBgTT6xxdvUoOi3eC/4rWUusPEdaz0/PfmLcEXpWGbi4G5z
 ASTUcxsD7RMI0BKiwsG82+hDxKyehxS3xABSSzek13o19gugUUY8kC14rC++gmQzaBws
 L9o8KaZSpKwrzSNK7jqT2YX7MzEseLuJUwYpK7FcUq8PmMrOqWMTAE9j7KkI9Zy5Ns+A
 BzrLFoxelOXGiiiBTx9MEgPLloRXSd/rHP0r58678uqFVFovtRFn6Y6opfSZ3lclxPvZ
 GZTz18MAZvMyGtBIHvuoVYgF1av1gRa3+kX7BxL0ox8Wa27b/clmBuUgZLXPen0l1TiB
 +Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618099; x=1746222899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eO5DfNMHmibDzC5S7R129uJ9XbuwIQeM7aiNNCULxXU=;
 b=gkqWaq/clT5CbquQh0VdyAN66OxvtnQxTQmF/jnD8/3tJ+GjGzt0vVELUScSwdLFuf
 lPhjhrrltCjqsXcx+RxvPxb75mtZeE12tScDGFuE/RYhgk+Q1NsABZ9dbW17N7B8u3ig
 HdR6z9YgPUgmhTrFzMFklhugEaiU7jbtPcqPUPOJvwIqhqWxxNJCkMTaXkmHGfzgIaUq
 mNdkWVCtspHPmkG1P1winlCevR0trQ0LRO6xQKqwmgklytWdJfe589gezkQ0eFrYLVPa
 LjFFSGWrMJCmK/TSuFubw401YNwcj6GESvsQRXNwXERkFOIS2pJ5TMfCcJfIRBSUcCps
 rofg==
X-Gm-Message-State: AOJu0YwiUh1cZlXBOHeYp/ctq6dJRCKzlkAAYVUS8cstJ7X6KPRE80xT
 u6V9Hz//acN18lYxBf4Pf2e2ITh96HZag0lDdwBBjdxR68yDkNXPrAGNOqjIo6M20oaBa39yzK8
 T
X-Gm-Gg: ASbGncsz6l9YA5LPwk5KOaUgrjblhte+tz04oVDOC1hNP23/WKAm0K4HBPzdJPwUcoU
 ojqL8VHo2UieUG3GhcSSOD0CRPGTrx+Z8WODKM8RAmsbRuda3YkoK3soVkBhNqlOIi1O3ClpvFE
 E/Gog3WfxQNxFDXJ0qHafwyNycvQf5uHhSAC7bAWioIyFY5foGtztvatbUdfhm+Fn6BdpUr3kTM
 u2Oz3jIUWEdOtDT3EJThcOTxjX3i3ceJQUYFM9M22Ld6G1rmNyzUF9WFKhCTVZ3MR4Cqx1ESLlc
 Ew5K/a+J50tHL//AbDcGAn5Je/5HmkcCxyie3w9NUPnPg2dtOtADBoTG9H3IK27IA2IrM0A0aRU
 =
X-Google-Smtp-Source: AGHT+IF06vOodccV2VbZ6VbM1pNfI2xQ34VcwOAes2g25a2twrOTel6z6Xar9WRvekg5NwSpcnTAJQ==
X-Received: by 2002:a05:6a00:80f:b0:730:75b1:7219 with SMTP id
 d2e1a72fcca58-73fd74c7b87mr5018604b3a.12.1745618098864; 
 Fri, 25 Apr 2025 14:54:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:54:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 005/159] tcg: Add all_outop[]
Date: Fri, 25 Apr 2025 14:52:19 -0700
Message-ID: <20250425215454.886111-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add infrastructure for more consolidated output of opcodes.
The base structure allows for constraints to be either static
or dynamic, and for the existence of those constraints to
replace TCG_TARGET_HAS_* and the bulk of tcg_op_supported.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 198d6181d9..5090cdb3c6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -861,6 +861,7 @@ static int tcg_out_pool_finalize(TCGContext *s)
 #define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4),
 
 typedef enum {
+    C_Dynamic = -2,
     C_NotImplemented = -1,
 #include "tcg-target-con-set.h"
 } TCGConstraintSetIndex;
@@ -954,6 +955,29 @@ static const TCGConstraintSet constraint_sets[] = {
 #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4)
 #define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4)
 
+/*
+ * TCGOutOp is the base class for a set of structures that describe how
+ * to generate code for a given TCGOpcode.
+ *
+ * @static_constraint:
+ *   C_NotImplemented: The TCGOpcode is not supported by the backend.
+ *   C_Dynamic:        Use @dynamic_constraint to select a constraint set
+ *                     based on any of @type, @flags, or host isa.
+ *   Otherwise:        The register allocation constrains for the TCGOpcode.
+ *
+ * Subclasses of TCGOutOp will define a set of output routines that may
+ * be used.  Such routines will often be selected by the set of registers
+ * and constants that come out of register allocation.  The set of
+ * routines that are provided will guide the set of constraints that are
+ * legal.  In particular, assume that tcg_optimize() has done its job in
+ * swapping commutative operands and folding operations for which all
+ * operands are constant.
+ */
+typedef struct TCGOutOp {
+    TCGConstraintSetIndex static_constraint;
+    TCGConstraintSetIndex (*dynamic_constraint)(TCGType type, unsigned flags);
+} TCGOutOp;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -963,6 +987,10 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                   < MIN_TLB_MASK_TABLE_OFS);
 #endif
 
+/* Register allocation descriptions for every TCGOpcode. */
+static const TCGOutOp * const all_outop[NB_OPS] = {
+};
+
 /*
  * All TCG threads except the parent (i.e. the one that called tcg_context_init
  * and registered the target's TCG globals) must register with this function
@@ -2416,8 +2444,32 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return has_type && TCG_TARGET_HAS_cmpsel_vec;
 
     default:
-        tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
+        if (op < INDEX_op_last_generic) {
+            const TCGOutOp *outop;
+            TCGConstraintSetIndex con_set;
+
+            if (!has_type) {
+                return false;
+            }
+
+            outop = all_outop[op];
+            tcg_debug_assert(outop != NULL);
+
+            con_set = outop->static_constraint;
+            if (con_set == C_Dynamic) {
+                con_set = outop->dynamic_constraint(type, flags);
+            }
+            if (con_set >= 0) {
+                return true;
+            }
+            tcg_debug_assert(con_set == C_NotImplemented);
+            return false;
+        }
+        tcg_debug_assert(op < NB_OPS);
         return true;
+
+    case INDEX_op_last_generic:
+        g_assert_not_reached();
     }
 }
 
@@ -3335,19 +3387,27 @@ static void process_constraint_sets(void)
 
 static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
 {
-    const TCGOpDef *def = &tcg_op_defs[op->opc];
+    TCGOpcode opc = op->opc;
+    TCGType type = TCGOP_TYPE(op);
+    unsigned flags = TCGOP_FLAGS(op);
+    const TCGOpDef *def = &tcg_op_defs[opc];
+    const TCGOutOp *outop = all_outop[opc];
     TCGConstraintSetIndex con_set;
 
-#ifdef CONFIG_DEBUG_TCG
-    assert(tcg_op_supported(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op)));
-#endif
-
     if (def->flags & TCG_OPF_NOT_PRESENT) {
         return empty_cts;
     }
 
-    con_set = tcg_target_op_def(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
-    tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
+    if (outop) {
+        con_set = outop->static_constraint;
+        if (con_set == C_Dynamic) {
+            con_set = outop->dynamic_constraint(type, flags);
+        }
+    } else {
+        con_set = tcg_target_op_def(opc, type, flags);
+    }
+    tcg_debug_assert(con_set >= 0);
+    tcg_debug_assert(con_set < ARRAY_SIZE(constraint_sets));
 
     /* The constraint arguments must match TCGOpcode arguments. */
     tcg_debug_assert(constraint_sets[con_set].nb_oargs == def->nb_oargs);
-- 
2.43.0


