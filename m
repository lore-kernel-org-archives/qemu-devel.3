Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA389C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmp-0005ol-Uf; Sun, 16 Feb 2025 18:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmT-0005YH-5Y
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:33 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmR-0005FP-5L
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:32 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22128b7d587so7727475ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747429; x=1740352229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpN3WXt3NI/RpPnO7AAMle82qaAELBNZojqP2YFIifM=;
 b=bkmhnjfoNAw9g0WsFO1iCEruOdlSEehRoF/q0DdMrq/bV+yEKXc98/tPmoSCRp893s
 93herB1P+TPRH7JDqb7B94r9SaAF/J+0Z3ojMLZu37+LAYbVDLayiuRuCDxVcVssz81Y
 zBvZ961+qymY0ly3oYJTVoD7oGZ+o7Omgu/I939K/sl73raM1xZzH8KGolcOII1kvRDX
 c4zUHgstlazPns+grGT50pF9rY9rpJUO9tFDdr80VXLI6kQy185DE0QxhNEQFtDWXOqC
 x54gaPpTuXHo0UtA+4cH3FnThQHJPeR0veMKmwRjnDG6YV8eZOrI+ey+ax+aNd0au+bB
 YAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747429; x=1740352229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bpN3WXt3NI/RpPnO7AAMle82qaAELBNZojqP2YFIifM=;
 b=VsACIxGUa8EWOFEVEk7J4m/7LFytPjV9WdSYCn+yNehHk+cglpZ8Y9DTvcdqwORWyh
 QVRqXiGOKjFteHjmtE/GkGjuNnFv5gU5KzXtwbONa/UH/JgfMnrF50CaM5/zr3fluxrR
 FC+uWpshD/aQyI8r/qS1mEJuBEMF23H53nzX5afrU0rjUsAFc8Si6c0Otuvbo31jxkTY
 IZt3++UmxsfcI56l7lV7x4u3PjKv12ZSabSbH8wvuWNdK/yeCDnd1eMhxzcApKH48buw
 FhWFarGx59f2F5liP791HPNmzK08FndG19CK9zLCB7IxLwhMTo9uIA9LtIRW55bmrEWg
 iDKw==
X-Gm-Message-State: AOJu0YyaviEQoIMbTk5YvdZiirhkOj/tVxtQE4+ht+dwNL0EPh2K7loS
 cGYOWRi1KlM8aFaUAw3xFj6cbcMeGh3mBq9VWnRqldAaC4+6p6IqNfb6nn4H5Y3EKi00cGhC6AR
 /
X-Gm-Gg: ASbGncvXVzCCn/Qa0Ike+Ag1AGuROw8ejY7gxUmBtOnuGGaID6BNu33Wm1p7n5k0Wwy
 3HQIa+7kWYJlKYmm6yUcAR7ATi6X8vVFIbT1A2tnGgKiaM0Px7WHumgwQes89DX0jSKl/Bbf7z5
 EQy+bt0Qb14unK5+rIs0cz9TbgIpWNqTwLYFkyZ4Tv2snlXUhuNVUDKTdubDMFs40n4mrQDNIJl
 cj1okp1hK8Oo4FjhVJ33UIi7NizmOiO46wqC1Clx+0QSY/Rk/Y+PDdrXjQF0PO+QLKBwxkEikvB
 CWU8b1HAbcp/AG5iw9ayqlSs+vi+5EwFnnoJXAGn9YMJrnk=
X-Google-Smtp-Source: AGHT+IE++zqN99kwVzG0yE04w3Y+v/rWZoCUrHHGuv0dmWbo0yO7jJHBcrf32xGm4GEyGPfVuUYP3g==
X-Received: by 2002:a17:902:ea05:b0:220:f449:7415 with SMTP id
 d9443c01a7336-221040c0af6mr125504115ad.44.1739747429482; 
 Sun, 16 Feb 2025 15:10:29 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 021/162] tcg: Merge INDEX_op_eqv_{i32,i64}
Date: Sun, 16 Feb 2025 15:07:50 -0800
Message-ID: <20250216231012.2808572-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 3 +--
 tcg/optimize.c           | 6 ++++--
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 6 ++----
 tcg/tci.c                | 5 ++---
 docs/devel/tcg-ops.rst   | 2 +-
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 8f6115bedb..c6869de244 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -42,6 +42,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
+DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
@@ -93,7 +94,6 @@ DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(eqv_i32, 1, 2, 0, 0)
 DEF(nand_i32, 1, 2, 0, 0)
 DEF(nor_i32, 1, 2, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
@@ -147,7 +147,6 @@ DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(eqv_i64, 1, 2, 0, 0)
 DEF(nand_i64, 1, 2, 0, 0)
 DEF(nor_i64, 1, 2, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index a49d51f0d7..4efd6a1b2c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -477,7 +477,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_orc_vec:
         return x | ~y;
 
-    CASE_OP_32_64_VEC(eqv):
+    case INDEX_op_eqv:
+    case INDEX_op_eqv_vec:
         return ~(x ^ y);
 
     CASE_OP_32_64_VEC(nand):
@@ -2917,7 +2918,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_dup2_vec:
             done = fold_dup2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(eqv):
+        case INDEX_op_eqv:
+        case INDEX_op_eqv_vec:
             done = fold_eqv(&ctx, op);
             break;
         CASE_OP_32_64(extract):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8008b0d3e0..2520a60cee 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -680,8 +680,8 @@ void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_eqv_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_eqv_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_eqv, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i32(ret, arg1, arg2);
         tcg_gen_not_i32(ret, ret);
@@ -2279,8 +2279,8 @@ void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_eqv_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_eqv_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_eqv_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_eqv_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_eqv, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i64(ret, arg1, arg2);
         tcg_gen_not_i64(ret, ret);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4da76320c9..aaef2ed3e3 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1007,8 +1007,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_eqv_i32, TCGOutOpBinary, outop_eqv),
-    OUTOP(INDEX_op_eqv_i64, TCGOutOpBinary, outop_eqv),
+    OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -5430,8 +5429,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
+    case INDEX_op_eqv:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 26a271e71f..d2baa8d3fc 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -555,7 +555,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | ~regs[r2];
             break;
-        CASE_32_64(eqv)
+        case INDEX_op_eqv:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] ^ regs[r2]);
             break;
@@ -1079,6 +1079,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_eqv:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
@@ -1086,8 +1087,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
     case INDEX_op_nand_i32:
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index a4aa4f8824..fe149e012d 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -323,7 +323,7 @@ Logical
 
      - | *t0* = *t1* & ~\ *t2*
 
-   * - eqv_i32/i64 *t0*, *t1*, *t2*
+   * - eqv *t0*, *t1*, *t2*
 
      - | *t0* = ~(*t1* ^ *t2*), or equivalently, *t0* = *t1* ^ ~\ *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4c9e055614..fe3450373e 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -663,7 +663,7 @@ static const TCGOutOpBinary outop_andc = {
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_eqv_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_eqv, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_eqv = {
-- 
2.43.0


