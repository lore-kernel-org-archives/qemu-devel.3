Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B9DE77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bi-0005VT-1U; Tue, 07 Jan 2025 03:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4an-0000wt-KP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:38 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ae-0003dZ-Rr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:37 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso1652705ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237127; x=1736841927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qn3z8B10v9s5TbwsCxj33DICOvDaXspiQ2OJoQxqZX8=;
 b=TIWRts4Bxa9RITX9tVBmlhIhEWkYZbHvQrgH78sP53pWIInMVqNjFGbWhzpYEoILtz
 rBH/N4KfdxMCmFbaOGcgKJPGrfvq2snXUBwAJ7Z+6cjTefblgQ4t+PhvOOdG9pgYiOyK
 ClHR5OOhUvYutqagq02X3zOPA+QVCfVzDKkoOg6lvX/1l+FvUOE90NUqyujzxxpuEEDY
 iSPsp+wXAxX+FVgdHpeLBQp9k7nhTIl282/083qTKTSoBWC2vaO04H8PARBR3wd9b26E
 1DUGZiNgK3++A9aMTbb9KH5MExAN/UabjZRhT7W2Ir4jmwqrQmzvJ+3xKube3P25EQJf
 4bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237127; x=1736841927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qn3z8B10v9s5TbwsCxj33DICOvDaXspiQ2OJoQxqZX8=;
 b=HP21+JRlKFI/KhZobPi8wHEFk7lLtYcV7y4fmMcw2gZUHp6IBJB62k6wWp/OjHMMPw
 +s4386LhVbcLtW8nnRI5yB+ymW9chzVvNAeOqca6wY4giC04TT1kDzupZwEQWtxaF8/8
 IgHT77r1AUSk+gyxUcWn3mYdGLBB86wM4jSab4lvdOHoQgp6Yh89W6Al4WOsVgu2vIwV
 UHdq2btvBOIothq5senowcAurXiA1qkG7iVeFfE0ePJ7ygaQn2Jp5C/zYPzU6pjrPlZ4
 YgCYZH0QV0/2vzahz4pF+dns/U/0z1SYt2ZbBJlhiNA/D9dq810nHb5WfkbCMLUPqGmj
 vGSA==
X-Gm-Message-State: AOJu0YyJB/KSGeVEJcjALxJBhAM1OfA5+ZN/LQ3m49Bs9agdQ991YvOa
 2S2aK9dDkcs8ELERybKmTv0Gd6OgYWDPJOHh/K8PW2pov3jV4maZewOKtVPYXaxkhdlf0311Wd9
 +
X-Gm-Gg: ASbGnctSRY1o63F/VHTahnGVJ7XJafyo1rDAtbC2hozoq3azVTvGT81poiX5YD9IE8W
 WTbe7Bqma4kPDEY0UspYf9G+nkSr//Av4xTgH5/onKsmA4tMndyCyPppno41VHukHIa/xRhr7HG
 SWDBgsAjkOcSwCux+A+pZ+y/73NsbCOFoNywlZhnfsCbg3msibTv3pLfFWoVn2MS57FrW0EcO7G
 PCiCG64Lm9tbbyJkCrtsUJgj/qF0cS8MZM/5i498H05CsGIxxM50exAqbKYdOYsbiG5vzy8xj+u
 MascCAP0aYTBbZ5CkA==
X-Google-Smtp-Source: AGHT+IEeKRbkkFou9dVl1pnIzlTI4sKQz8OLs5uAxYlic+fP8lO813YmjI4JKiqM8ElE/hZrPmGaDg==
X-Received: by 2002:a05:6a21:164e:b0:1e1:ffec:b1bf with SMTP id
 adf61e73a8af0-1e5e04a3461mr94709728637.26.1736237127625; 
 Tue, 07 Jan 2025 00:05:27 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 69/81] tcg: Merge INDEX_op_eqv_{i32,i64}
Date: Tue,  7 Jan 2025 00:01:00 -0800
Message-ID: <20250107080112.1175095-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 3 +--
 tcg/optimize.c           | 6 ++++--
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 6 ++----
 tcg/tci.c                | 5 ++---
 tcg/tci/tcg-target.c.inc | 2 +-
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 4db374e03a..4df1520186 100644
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
index 485efb1018..eed3d03e65 100644
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
@@ -2914,7 +2915,8 @@ void tcg_optimize(TCGContext *s)
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
index a3ba8278ac..37ef2bb392 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -994,8 +994,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_eqv_i32, TCGOutOpBinary, outop_eqv),
-    OUTOP(INDEX_op_eqv_i64, TCGOutOpBinary, outop_eqv),
+    OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -5421,8 +5420,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index e42251fc41..093a48ddfb 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -565,7 +565,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | ~regs[r2];
             break;
-        CASE_32_64(eqv)
+        case INDEX_op_eqv:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] ^ regs[r2]);
             break;
@@ -1135,6 +1135,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_eqv:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
@@ -1142,8 +1143,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
     case INDEX_op_nand_i32:
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 420bab3f94..f2724d2cf3 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -685,7 +685,7 @@ static const TCGOutOpBinary outop_andc = {
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_eqv_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_eqv, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_eqv = {
-- 
2.43.0


