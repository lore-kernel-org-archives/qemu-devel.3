Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F76C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmZ-0005ai-OX; Sun, 16 Feb 2025 18:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmP-0005Wu-S0
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:30 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmN-0005EJ-Hd
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:29 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso56349535ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747426; x=1740352226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5bOVcmz7yu7lmO7IhVAc2pra9v7wHlSfSzhbUZHk7Y=;
 b=qVAHQHZgGFuvjdWaLKOhXz+9bijbkQbi7KCNzTz8P/HqrUNzb/kpWoF2hKjHcR9MMR
 4F2zEJHd45iguaL5v17uDih7VP9oZCAyddxXpAhodDRpjYRNatsBz5GRUT1ZPKz1nioj
 6WGiYoIzGTTOXYyX6HI+6G+OstmYEyXM1pe/LZ2TZH239rxyDgOSiaChuvAk8o/SlBup
 txOhpFHTD40pSfcIhsTGqf92n8i5aksxt2izGmqTS5/NW/0IqW9xvv9KXkLlh8LiM6YZ
 bMST9Fs5uNcxORXk08yAwoY6GEfAK+CiP09Ba1AZr7Vt3EJo+a61cp7YY9xu033rNY0b
 2M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747426; x=1740352226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5bOVcmz7yu7lmO7IhVAc2pra9v7wHlSfSzhbUZHk7Y=;
 b=dPQLHIhR6qh7WaBfNSEHnBfPWsPEI6bbdhvNCUnaO+NJgXJHDHdE9Mrh6ZUlb3O87q
 bRJY19uEd7Hg1pS8qJR7bdif1HQSmvT1pjNBKZPSqRWsZzTpKj7GiLz/Nt4i9fT7Qonr
 2e4omUSt7VnvI9J60IJaVSbTexkcWCxo4dOB7lMbR59iEW+B0oTWKGK7Zet24GNe9UP7
 AcI/ttKavm1N75bKYHpGT0Y7pdM3my7GwGMlA+oSE0kR3Dxc+67vnnvGnPJZ2fjmAcZT
 7R1it18ah/vmobXh94uIdZtkAzPIqSVkvSHoG8Hp5PU6gOi49z5RxE6MsRBKo9223dbX
 lHdQ==
X-Gm-Message-State: AOJu0Yyo6ebGpe+c9ByPnrB02xPQydx+atSWcr74XnRwYwNiApFIWCVo
 ckbuT+34p84A1PdRahALi+ABh4fs+fAWqaLr/QamiWj4I63An+iOt985CSWygM/3DCVV8M5EHlW
 f
X-Gm-Gg: ASbGnctwJlSl8OrER+I2N3qgwiVHeMFC2sgfr8NO1d4Tk0JrEX0Q23g1xLflfKELp7U
 jsO2s1JMvaJctdWfyfAena8PnV7ICvK6dUuskwvBJSafKF+bPsWZnq0WrMS+v9fxjq4Vi+FU0DQ
 lSS+qMcNKBA5s2FWETMuvV98aCbBx2Df/T6bvjg1OmWrQ3NJk4fdogk46oHCtrIcdNU+bRmwrR4
 8Q1KSuGFYGxpVQ7ILU8Ia80qK/hV5kLhe5HT/cXn+KtqDfRsaFo+ZTnjHxw6+PLBmaA2x2NM7HH
 5Gq0hmELK6dx4+FJT/hTnnzA5/ZNwfYFKTOuGd5f5hDctL8=
X-Google-Smtp-Source: AGHT+IHmiYCE+KPCnrgz5hjRRebDrG+CBmc+Vo08BUYgSgXhmqlGwvIB4kp625GfEzNpRoAySzAiMw==
X-Received: by 2002:a17:902:e80b:b0:215:58be:334e with SMTP id
 d9443c01a7336-221045971f4mr112923945ad.10.1739747425905; 
 Sun, 16 Feb 2025 15:10:25 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 016/162] tcg: Merge INDEX_op_orc_{i32,i64}
Date: Sun, 16 Feb 2025 15:07:45 -0800
Message-ID: <20250216231012.2808572-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h          | 3 +--
 target/arm/tcg/translate-sve.c | 2 +-
 target/tricore/translate.c     | 2 +-
 tcg/optimize.c                 | 6 ++++--
 tcg/tcg-op.c                   | 8 ++++----
 tcg/tcg.c                      | 6 ++----
 tcg/tci.c                      | 5 ++---
 docs/devel/tcg-ops.rst         | 2 +-
 tcg/tci/tcg-target.c.inc       | 2 +-
 9 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 95608d6d31..caf0f01042 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
+DEF(orc, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -92,7 +93,6 @@ DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(orc_i32, 1, 2, 0, 0)
 DEF(eqv_i32, 1, 2, 0, 0)
 DEF(nand_i32, 1, 2, 0, 0)
 DEF(nor_i32, 1, 2, 0, 0)
@@ -148,7 +148,6 @@ DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(orc_i64, 1, 2, 0, 0)
 DEF(eqv_i64, 1, 2, 0, 0)
 DEF(nand_i64, 1, 2, 0, 0)
 DEF(nor_i64, 1, 2, 0, 0)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d23be477b4..f3cf028cb9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -629,7 +629,7 @@ static void gen_bsl2n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
      *       =         | ~(m | k)
      */
     tcg_gen_and_i64(n, n, k);
-    if (tcg_op_supported(INDEX_op_orc_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
         tcg_gen_or_i64(m, m, k);
         tcg_gen_orc_i64(d, n, m);
     } else {
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 1f8b3e6d91..5ae685cc5b 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -4113,7 +4113,7 @@ static void decode_bit_orand(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_or_tl);
         break;
     case OPC2_32_BIT_OR_NOR_T:
-        if (tcg_op_supported(INDEX_op_orc_i32, TCG_TYPE_I32, 0)) {
+        if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_orc_tl);
         } else {
diff --git a/tcg/optimize.c b/tcg/optimize.c
index c75413c48c..9a7238832f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -472,7 +472,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_andc_vec:
         return x & ~y;
 
-    CASE_OP_32_64_VEC(orc):
+    case INDEX_op_orc:
+    case INDEX_op_orc_vec:
         return x | ~y;
 
     CASE_OP_32_64_VEC(eqv):
@@ -2975,7 +2976,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_or_vec:
             done = fold_or(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(orc):
+        case INDEX_op_orc:
+        case INDEX_op_orc_vec:
             done = fold_orc(&ctx, op);
             break;
         case INDEX_op_qemu_ld_i32:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 503d395ac8..bf481060fa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -710,8 +710,8 @@ void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_orc_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_orc_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_orc, ret, arg1, arg2);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_not_i32(t0, arg2);
@@ -2318,8 +2318,8 @@ void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_orc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_orc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_orc_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_orc_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_orc, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_not_i64(t0, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f216dfda6b..dc45df2869 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1008,8 +1008,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
-    OUTOP(INDEX_op_orc_i32, TCGOutOpBinary, outop_orc),
-    OUTOP(INDEX_op_orc_i64, TCGOutOpBinary, outop_orc),
+    OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
 };
 
 #undef OUTOP
@@ -5434,8 +5433,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_or:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
+    case INDEX_op_orc:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 7a926b30db..68636e70da 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -551,7 +551,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & ~regs[r2];
             break;
-        CASE_32_64(orc)
+        case INDEX_op_orc:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | ~regs[r2];
             break;
@@ -1082,14 +1082,13 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_or:
+    case INDEX_op_orc:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
     case INDEX_op_nand_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 8d67b0cdeb..c5c5a4d19e 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -335,7 +335,7 @@ Logical
 
      - | *t0* = ~(*t1* | *t2*)
 
-   * - orc_i32/i64 *t0*, *t1*, *t2*
+   * - orc *t0*, *t1*, *t2*
 
      - | *t0* = *t1* | ~\ *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 2e45cc4768..b9309e2fb9 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -678,7 +678,7 @@ static const TCGOutOpBinary outop_or = {
 static void tgen_orc(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_orc_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_orc, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_orc = {
-- 
2.43.0


