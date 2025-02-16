Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E137FC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnzv-00059u-0x; Sun, 16 Feb 2025 18:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnzs-0004zP-Da
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:24:24 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnzp-0006eE-HS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:24:24 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220e989edb6so68707615ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748259; x=1740353059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iZD6i0yX9mYoq/l1Qlw8Cml8zkcNSR9plgtvagLXob8=;
 b=Rqjf4IuueROtjcneEXlk+UWW1R5I7QbbZXIWJWxDK/S4ZX/dy7jI26ZXHWwUfNBAxG
 TZARd3NpaeqFBzqF8mbz/9NSxOrmM8XrUMxf3XfvyzAxCiQqgZbVASJwtVrqoMZcKUVW
 BuUmtNMHItmVFK3ZBAPcxukiPXuMx76WBJ0F+rVI/M1QTJukHZlQdMnZhfQhulxKcA+/
 GAp4LxuI0k2G0IawuxHo1GNMkoBTwAbb4M38kRt0pmayGiQs1xa/U01WPwYr5WG2vEl+
 AUiW3CGp5GzRsWiBmkDrm/WigBBYLKQpLQF9gMftKWfMWyYRSeit5zC331wWhu2hox8O
 Oh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748259; x=1740353059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZD6i0yX9mYoq/l1Qlw8Cml8zkcNSR9plgtvagLXob8=;
 b=AxJ3pOTMIEp0H+yRmBOUz/WWgIuDyRNWNb7/1Ou05oYDMKgbilumId4W+8sGgGTgY1
 DxN8W6UM38IAzFGdYYcG1CvhXnS0avz+dxCP0O7/817nmMUU2jZdGSWS83hG0ur9NNnY
 rNWEO62ghoNbjpWngF/aRMPk8A/+mH7zpLWNQqXyPeZqF7ZOdebfstyAA5XLT3V2bWAg
 Wmt4DC7kArxRGONN7ojhuMKu5dIrU8cXt1rTgErN1egFZ2GUosQeKTn8s97Ak5VElRHp
 3E7zhiqTu5p7XBNrqy2sudDYZQGixrFD+VwftZgDkQ+Xs0XLASHUXYt+x81wAjzY5lsv
 yGuw==
X-Gm-Message-State: AOJu0YzBmyBAS+2riDbwp2S8iAa07SwbpxM/dnsQNaaBwZLyJzt+RiGa
 1hjQqCGZ1yYGMf8ncMlD2RBzr810nom5L+PCC01+iyPd28oXLa+fpttaNnNKReIhlcqq4AB+ucK
 c
X-Gm-Gg: ASbGnctYLzGrX2HG5dp7uc5YCmIbNlnU6QQ3vj+iGvv954bNVJEBefl8P2QUUZw1y8v
 R7UcsvQCdWTqe9+/1vZqTWQyW/TrdTCGYU0gpN2TColKfQoTA3Xl0VeJ+J4wBvhucK13d/y/PC0
 9bCF5ms+xKhOa4YYNXqKteZr8ssVKHsKuBQjTqeIT2jhfOW29Az8Xf5xoqoRywkyf8Bq4fAyMt4
 65p9F1Vh8qaiGWKISjIVlP7RbLmTU/rcv7/+5RfN8F8t4DLZUrOei3CcR7WxMtcNEG0PTATAcXc
 XakLIaXd1eiE3qZkISH7uXai+vx9YHbS924x6JAnUqHE/gs=
X-Google-Smtp-Source: AGHT+IFiG3JMQKa4mtbBe4PrZK5sOmf5kJpE9jlM3AFbLQgiTn+EK1SpA/WOPeIBFg83UzhqWmKK2g==
X-Received: by 2002:a05:6a20:3944:b0:1ee:60fd:bcfa with SMTP id
 adf61e73a8af0-1ee8cc4b616mr16504867637.35.1739748259566; 
 Sun, 16 Feb 2025 15:24:19 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adc9ff10056sm4640529a12.72.2025.02.16.15.24.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:24:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 162/162] tcg: Remove tcg_out_op
Date: Sun, 16 Feb 2025 15:10:11 -0800
Message-ID: <20250216231012.2808572-163-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

All integer opcodes are now converted to TCGOutOp.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 12 +++---------
 tcg/aarch64/tcg-target.c.inc     |  7 -------
 tcg/arm/tcg-target.c.inc         |  7 -------
 tcg/i386/tcg-target.c.inc        |  7 -------
 tcg/loongarch64/tcg-target.c.inc |  7 -------
 tcg/mips/tcg-target.c.inc        |  7 -------
 tcg/ppc/tcg-target.c.inc         |  7 -------
 tcg/riscv/tcg-target.c.inc       |  7 -------
 tcg/s390x/tcg-target.c.inc       |  7 -------
 tcg/sparc64/tcg-target.c.inc     |  7 -------
 tcg/tci/tcg-target.c.inc         |  7 -------
 11 files changed, 3 insertions(+), 79 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8c2c61f7fa..89859c3713 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -138,9 +138,6 @@ static void tcg_out_mb(TCGContext *s, unsigned bar);
 static void tcg_out_br(TCGContext *s, TCGLabel *l);
 static void tcg_out_set_carry(TCGContext *s);
 static void tcg_out_set_borrow(TCGContext *s);
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS]);
 #if TCG_TARGET_MAYBE_vec
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src);
@@ -5884,12 +5881,9 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     default:
-        if (def->flags & TCG_OPF_VECTOR) {
-            tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
-                           TCGOP_VECE(op), new_args, const_args);
-        } else {
-            tcg_out_op(s, op->opc, type, new_args, const_args);
-        }
+        tcg_debug_assert(def->flags & TCG_OPF_VECTOR);
+        tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
+                       TCGOP_VECE(op), new_args, const_args);
         break;
     }
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index be1ca74bc4..e56dc135b6 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2897,13 +2897,6 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 55eef16743..52f1520098 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2646,13 +2646,6 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index ea5c96cbde..fe21ec2634 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3602,13 +3602,6 @@ static const TCGOutOpStore outop_st = {
     .out_i = tgen_st_i,
 };
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static int const umin_insn[4] = {
     OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_VPMINUQ
 };
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 49522dcd72..b5d00876cb 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2030,13 +2030,6 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index e5e1b98d13..b3647cc5ad 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2450,13 +2450,6 @@ static const TCGOutOpStore outop_st = {
 };
 
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 824cced94a..2e94778104 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3828,13 +3828,6 @@ static const TCGOutOpStore outop_st = {
 };
 
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
     switch (opc) {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index eca1283742..f9417d15f7 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2642,13 +2642,6 @@ static const TCGOutOpStore outop_st = {
 };
 
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 123e74290a..c0dd9636d9 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3160,13 +3160,6 @@ static const TCGOutOpStore outop_st = {
 };
 
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 49a4f4f281..09380799e9 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -2069,13 +2069,6 @@ static const TCGOutOpStore outop_st = {
 };
 
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 50e205211d..35c66a4836 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1235,13 +1235,6 @@ static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
         TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_st2,
 };
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
-                       const TCGArg args[TCG_MAX_OP_ARGS],
-                       const int const_args[TCG_MAX_OP_ARGS])
-{
-    g_assert_not_reached();
-}
-
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
                        intptr_t offset)
 {
-- 
2.43.0


