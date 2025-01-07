Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EC9E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bY-0004JH-CT; Tue, 07 Jan 2025 03:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4as-0001ND-Eo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:42 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ak-0003en-K5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:42 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21619108a6bso206256945ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237133; x=1736841933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6J6RaJAg4Z8uPx4sI3H7ZwSla5sRsW548XguXmJXNU=;
 b=ehUAxt5Fp5T/G7F+i8GGrX0DvU8Pp2yf1lMz8NWg2iqrhrpVCZpHPwabnOqvIxDGJY
 MFn1oIs36sKyyxqSFt87OzPNhQ73ifbSVMJo9iw9J24Ypiijjb7GVYMtgKfZumv1iBHH
 eWbpsvc6FZsSYpPqMjw3n0cML/7izaNtX8Ce/2d7dztQ56EHsqurD5h73ER93e3qckIt
 LvmIoUYqJruqktg8OOw13g2aZsf7xdPDFaXjjxA3cZGEmoMAMBqqgnoN7pOFomkCeC3Y
 Y2ivBuK55aP8xJ2JRmTJEtZA+5dEyoU5XFSXSeOofaT3L3P641h+AvKoVN3HqGWpqol+
 GAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237133; x=1736841933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6J6RaJAg4Z8uPx4sI3H7ZwSla5sRsW548XguXmJXNU=;
 b=k5yLaeRQoKNU2CdvCzLDkjxBhZ6zsNYJEuR4twFaSEV7g3Pd56YIPUqvI1L8SMIzBI
 F+fztLL7juAT+MmCPhQGc6YaudKuPx1pW6HxoQZbrA4thHotwlLx+g71pCpgUlIvVVTS
 SnjTflr9F5By76fcAd7aCVgfdLU+faCv3b6UYXyJVcIKWR3uA7jOGxYg/JxPdpXVOJp2
 nY1VDcM3QK0Fv9FhAL2QxFs8pVVVFypI3zYQrzmoXJEIcsEOjjoYS2pMSQTdm2gsIBDd
 vhL3+wfvuGYhtXZnJu/dsczgL4pXAAlP1DyIO/UYqg3WQIkHlLe+zlz58PB6jaci5WpV
 Mp9w==
X-Gm-Message-State: AOJu0YyL2XVKN0PKTQejm2g3X/609Oz7OMNqWa9FKNHWdFJj4c5Tjdut
 A+BVctmR9+fFvVohIGG+DJoYb3/nauCEMHDZZxuSn63qYdPiVO7kwn3e5Y5w8buKTI9sOPeDX62
 a
X-Gm-Gg: ASbGncthLl1HmrgcGDguLLWlJiA02vQZIIQM7ND5MNCda6s6v0WKxmSlkFD5at9o0xO
 2yac8Q3UPUSRE+bpQVKEVlvOpwEn5/h4dFLbeTM6IiRk1FjAFOCjn3rCbWWst+6jZr4kRZZyRZe
 z64KNvCRdVRD13IOd6XQmT/rXncZ4eQAkRVuvd+GjKgBq24xzhdw+iujROe0iBGHaC5S5ZnEbvx
 cwlMGkLadFWjC+s8JZrV9AJnhyDhR3YbgF45Up8GTB05rveIrFty3+r9ursTnVrB3HJPq0Zk/yU
 DCEcky88+glwvH2L3A==
X-Google-Smtp-Source: AGHT+IGJbz9iRpVz2Hla//1Igv3xTV5I/anlxXSA9lSOuKZxa2KHNfAx9qdh7axbKqJKWGfP6SOydA==
X-Received: by 2002:a05:6a00:2407:b0:729:597:4faa with SMTP id
 d2e1a72fcca58-72abde9c004mr83778774b3a.16.1736237132879; 
 Tue, 07 Jan 2025 00:05:32 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 74/81] tcg: Merge INDEX_op_nor_{i32,i64}
Date: Tue,  7 Jan 2025 00:01:05 -0800
Message-ID: <20250107080112.1175095-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
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
index 4c07095eb9..b374fd39e8 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -44,6 +44,7 @@ DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
+DEF(nor, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
@@ -95,7 +96,6 @@ DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(nor_i32, 1, 2, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
@@ -147,7 +147,6 @@ DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(nor_i64, 1, 2, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index f80a6d1170..9352528684 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -485,7 +485,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_nand_vec:
         return ~(x & y);
 
-    CASE_OP_32_64_VEC(nor):
+    case INDEX_op_nor:
+    case INDEX_op_nor_vec:
         return ~(x | y);
 
     case INDEX_op_clz_i32:
@@ -2985,7 +2986,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(neg):
             done = fold_neg(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(nor):
+        case INDEX_op_nor:
+        case INDEX_op_nor_vec:
             done = fold_nor(&ctx, op);
             break;
         CASE_OP_32_64_VEC(not):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ac939bb4ea..228aa8f088 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -700,8 +700,8 @@ void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_nor_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nor_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_nor, ret, arg1, arg2);
     } else {
         tcg_gen_or_i32(ret, arg1, arg2);
         tcg_gen_not_i32(ret, ret);
@@ -2305,8 +2305,8 @@ void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_nor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_nor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_nor_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nor_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_nor, ret, arg1, arg2);
     } else {
         tcg_gen_or_i64(ret, arg1, arg2);
         tcg_gen_not_i64(ret, ret);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 85101b36c6..59577784db 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -996,8 +996,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
-    OUTOP(INDEX_op_nor_i32, TCGOutOpBinary, outop_nor),
-    OUTOP(INDEX_op_nor_i64, TCGOutOpBinary, outop_nor),
+    OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -5417,8 +5416,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_eqv:
     case INDEX_op_nand:
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
+    case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index de3edcc8d2..d2a5192128 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -573,7 +573,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] & regs[r2]);
             break;
-        CASE_32_64(nor)
+        case INDEX_op_nor:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] | regs[r2]);
             break;
@@ -1133,6 +1133,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_andc:
     case INDEX_op_eqv:
     case INDEX_op_nand:
+    case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
@@ -1140,8 +1141,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
     case INDEX_op_div_i32:
     case INDEX_op_div_i64:
     case INDEX_op_rem_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index d66176a81d..c4fa585c30 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -703,7 +703,7 @@ static const TCGOutOpBinary outop_nand = {
 static void tgen_nor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_nor_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_nor, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_nor = {
-- 
2.43.0


