Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FDAE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfy-0007Mb-DV; Thu, 02 Jan 2025 13:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPea-0007ND-AD
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:44 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeX-0006EW-Gz
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:39 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21634338cfdso227845265ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841436; x=1736446236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sp3faTRt8dx1vNjUULVLSymPF1mdBCJ43DjAg/EoWLw=;
 b=XVtzFY3LRFPrd1Gp1SE0I8+agDrVBTOPgcpkhBSOEpzUdeDPjhULJEpm8aNNZPVOE1
 sgbTpSndEoEZk1XPL3Pv8tJukvgAXFPaUEs/zzxyu4TIudammHotC2t3KRe1lXrQtKqK
 I3F1iJJKzP1uznTSvq4m3HDwCS4hy/umt+kkbcb+p8jQJI9OXtBE5YBlYCH9GQ8mU5JF
 +tqaBheKw6vgLz2MFEv3SAYxrxRxmL3bziSc8yIRLvbg7uGCWAMqfgGSZv2X20l8utw/
 P2ER+me3CanXUUE8vg7FM8OiB222zEzVgnzoeNkp9TeX/FhMyQPOtUOqSnxETtAjxfmo
 VT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841436; x=1736446236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sp3faTRt8dx1vNjUULVLSymPF1mdBCJ43DjAg/EoWLw=;
 b=sviU4ISiVrVyDN4U252cfaobkRsK4yM1k3Xl5vMt1mcBawIAEwi54ZfIzfgPBA16Ql
 G+UAvoo9TkUPszUcjLVRy3vF/2G5mmn50VmA1UFoJ/Zm4X0ZEMZw7jT2TheMhoFq35ZT
 OqJlZgnBPNrA3rzyVNRfQ0izOAx17fprzWwsjiY5rU1L6VGu7DkrIDst4gjOSlFTN5Sy
 uuKz4RtHdsUQ3EWWH8guaISfdlX61NKRsU8Na5N9T8FPEAMoQFqyCd6mBBPKSUkYIxUO
 kodTq7U8We1rDOpEWGfuXSdE2YUJLFkavtfJDgZG9rJn1OIXvUYJOEwJauxRcbtcNvVs
 dC1A==
X-Gm-Message-State: AOJu0YwJ8YIG0wHbtt0Yu7Arp1jBbu3NKOSab4NFnIh0N9Xt+er20z3F
 gWnluRw4ZjhRuVxNUzSqA9jgPyemh6FFHrZxvXb4HtdKLtoki5MTR78zkH47p4BNOv7HIJ0fCl+
 o
X-Gm-Gg: ASbGncv7NXtS/66KgTeZGxDTF1N1QLskbPkhWcywwCdEZEKvkxP4RGRW5KLg5Qmldfn
 oXbeIOnMHtQxJMGqoNirTqlOTBbFH/bE19x1tlfQlQjDzhxVIMQVYC6PfL4kEKK0ZNNY1a9nQkG
 SSW4D0dH/rlVVIMSmr/rqV6dwc3TBAngTmOz6wVbBTNbgTM4wJJDKfVgERItXCVkD0Fzh03RLsR
 mS48XJQODvwN0oKCd9LUwyZVDWUe7sF6OTJz8DbO4i/Mrh58qdcdyc3nSqUVw==
X-Google-Smtp-Source: AGHT+IEUyMEhGhv1xEGiviFY+SbYQS7qacebEkCvplbCcsqGjdZZrkIteH6KFidHemhxCKwCjx6RNw==
X-Received: by 2002:a05:6a21:100f:b0:1e0:d851:cda5 with SMTP id
 adf61e73a8af0-1e5e0459bd1mr72647085637.14.1735841436269; 
 Thu, 02 Jan 2025 10:10:36 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 53/73] tcg: Use C_NotImplemented in tcg_target_op_def
Date: Thu,  2 Jan 2025 10:06:33 -0800
Message-ID: <20250102180654.1420056-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Return C_NotImplemented instead of asserting for opcodes
not implemented by the backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 12 ++++++------
 tcg/aarch64/tcg-target.c.inc     |  2 +-
 tcg/arm/tcg-target.c.inc         |  2 +-
 tcg/i386/tcg-target.c.inc        |  2 +-
 tcg/loongarch64/tcg-target.c.inc |  2 +-
 tcg/mips/tcg-target.c.inc        |  2 +-
 tcg/ppc/tcg-target.c.inc         |  2 +-
 tcg/riscv/tcg-target.c.inc       |  2 +-
 tcg/s390x/tcg-target.c.inc       |  2 +-
 tcg/sparc64/tcg-target.c.inc     |  2 +-
 tcg/tci/tcg-target.c.inc         |  2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7ba6c45824..095008ac25 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -871,6 +871,7 @@ static int tcg_out_pool_finalize(TCGContext *s)
 #define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I1, I2, I3, I4),
 
 typedef enum {
+    C_NotImplemented = -1,
 #include "tcg-target-con-set.h"
 } TCGConstraintSetIndex;
 
@@ -3326,7 +3327,7 @@ static void process_op_defs(TCGContext *s)
     for (TCGOpcode op = 0; op < NB_OPS; op++) {
         const TCGOpDef *def = &tcg_op_defs[op];
         const TCGConstraintSet *tdefs;
-        unsigned con_set;
+        TCGConstraintSetIndex con_set;
         TCGType type;
 
         if (def->flags & TCG_OPF_NOT_PRESENT) {
@@ -3342,11 +3343,10 @@ static void process_op_defs(TCGContext *s)
 
         /*
          * Macro magic should make it impossible, but double-check that
-         * the array index is in range.  Since the signness of an enum
-         * is implementation defined, force the result to unsigned.
+         * the array index is in range.
          */
         con_set = tcg_target_op_def(op);
-        tcg_debug_assert(con_set < ARRAY_SIZE(constraint_sets));
+        tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
 
         /* The constraint arguments must match TCGOpcode arguments. */
         tdefs = &constraint_sets[con_set];
@@ -3359,7 +3359,7 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
 {
     TCGOpcode opc = op->opc;
     const TCGOpDef *def = &tcg_op_defs[opc];
-    unsigned con_set;
+    TCGConstraintSetIndex con_set;
 
     if (def->flags & TCG_OPF_NOT_PRESENT) {
         return empty_cts;
@@ -3368,7 +3368,7 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
     tcg_debug_assert(tcg_op_supported(opc, op->type));
 
     con_set = tcg_target_op_def(opc);
-    tcg_debug_assert(con_set < ARRAY_SIZE(constraint_sets));
+    tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
     return all_args_cts[con_set];
 }
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index c0fe10e657..72e64c7dba 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3149,7 +3149,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(w, 0, w);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index cd770d2e20..d0c39f7122 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2295,7 +2295,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bitsel_vec:
         return C_O1_I3(w, w, w, w);
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index c73f1039e1..b6b15723b4 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3908,7 +3908,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I4(x, x, x, xO, x);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 395579774d..900558d301 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2401,7 +2401,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I3(w, w, w, w);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index a8987528e4..d2ace88aae 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2305,7 +2305,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
                 : C_O0_I4(rZ, rZ, r, r));
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 2b3d46af46..62110619f0 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -4374,7 +4374,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I4(v, v, v, vZM, v);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 9e981c5111..8e0a2d967e 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2789,7 +2789,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_cmpsel_vec:
         return C_O1_I4(v, v, vL, vK, vK);
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 9696ff6515..cb0b7ff25e 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3449,7 +3449,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
                 : C_O1_I4(v, v, v, vZ, v));
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index caa462249f..c104636cf7 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1632,7 +1632,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(r, r, r);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4ab19e93cc..57293e1458 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -178,7 +178,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(r, r) : C_O0_I4(r, r, r, r);
 
     default:
-        g_assert_not_reached();
+        return C_NotImplemented;
     }
 }
 
-- 
2.43.0


