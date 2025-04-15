Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8372FC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4luh-00005T-9U; Tue, 15 Apr 2025 15:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luc-0008Us-08
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:38 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luV-0007z8-Tb
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227b828de00so55511475ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745130; x=1745349930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saostd+yr/VgPLec0btbnT1OYZ0Gl7FjuT3pBrUOfAY=;
 b=pOqzJ/bO6NpU/OA5FntEa44GVdYPFSGX0A0golGy/0PRYwwQK1LCMgMpJ0KN1jUECG
 CsoVZ09vpbisUDNN/5RhYqD8ucm3ffQmPlCYqBiGrGtp3Yzr6Ae8G4CpO8CU6RPhGozm
 Ne0dnU3f011U8EOuHPbbstuYo4WllquHqriQVHAAGurg9jzwGTMRFYQDcLeJcWLwq+bn
 dlRyUdmSRBKYTiSCud0yMlYjpVWoTN6h7c7KX1Usa6rZXSqPOKf3hWacNcOg2NsJwzpC
 E5D0HhoQGbZOuNp71NPlzma0d/RszfefbWU2QRftAzHxEskEsNxG4aRUANM9juGMbDfI
 IRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745130; x=1745349930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=saostd+yr/VgPLec0btbnT1OYZ0Gl7FjuT3pBrUOfAY=;
 b=trkCgA4c2atS1yC4zHzFR6NoGHilfNScugaRi0FapMAV/j9BYmSCuR4giMM7utgjz+
 NCwUcrThp9t8vorMXJCK0LMKDptovlsyRaAVwmZp+nLRC9EMrItf8Yfa03zn8DUNg/b4
 jtbR21Y7ZUw0MmMe34oV3swPtWLFWASJCXbpu1Dnq1a3/Si10Pmy//6tkYPBGuJvYL/M
 YX/O/ofr+CHMZmWqGNgiFS3cX1OPD0fG2BnlO838I3IWI3i2K4Lz/LVP1UVVLQ3xCuS+
 sdkzRY8uIKpIOImG9HC5m60XLAueCIdysBQYRk7tmxEaPmvk9xSrUvZEDJ/6x7NnXtW6
 tRgw==
X-Gm-Message-State: AOJu0YxTJmXqHogiPqe3B2vznvmFHD51oie5HC+3Hmo5OpKvXyxtPxPY
 zIvv37z5eTpSdsTuMv67rwQaBToQexSrwzy1FMp7mpIZnN84t0CYkGXbzbUYJ6YdrYv+8K9sWu0
 P
X-Gm-Gg: ASbGnctar+YRhxV12SXHU/VkZHl1OzSFprI0nJEABi2XSh9jTGVdeb+wj4FLwn8Po9X
 XmqdMky9DDaiyCru+Je/tPsPcGRglpYvZVZg23eMst0VWTyawsiRYU/2iu/DV6QmRDTU9uQIY9/
 Q6gnEwHlpaTg8iEPXuKrW7RbfmSIzoME/pq/KG7rkT5yFNBFd2GQt5Z2iUVacotB7cB5MoXz4sm
 WBxqDVBzOV3qzx/yT+DqFTHov8uE1rr93sHYaz+Lc7baNW4BjWNY4dF/ByVmzFF7PX4FC0PNDxo
 HWa6ukL2BN2lwZ87Sptsgtbd3G/E01kE7gayTPY+4wh1OkMmuVpNZvBq3ISqd7NdIQ/8Y0X+T2k
 =
X-Google-Smtp-Source: AGHT+IH0MhZ/wEQwj2ziSN0FPzzFS0OXxvpY5VqmuaYNTfvNmBRErexrpsrS+9aQ2jghRwrIy3CuzQ==
X-Received: by 2002:a17:903:904:b0:220:c813:dfce with SMTP id
 d9443c01a7336-22c31a7ca93mr4717795ad.39.1744745130156; 
 Tue, 15 Apr 2025 12:25:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 017/163] tcg: Merge INDEX_op_orc_{i32,i64}
Date: Tue, 15 Apr 2025 12:22:48 -0700
Message-ID: <20250415192515.232910-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 577a69fe3b..a5850b0a32 100644
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
@@ -5437,8 +5436,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


