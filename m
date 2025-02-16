Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659F4C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmx-00061S-U3; Sun, 16 Feb 2025 18:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmX-0005Zb-4R
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:37 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmV-0005GQ-04
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:36 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220c8eb195aso78700355ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747433; x=1740352233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gf7AnWeJhPi2orAAKos1Bsyd6vzZ9LDQ/13vCQ40fQs=;
 b=pSIfsHBzTmSuCMhq7DHacklW53pzm1SeG0pHUeZjfrqHmFf2/zJa+FMddWSYrKA0cI
 cC3ZVgo2rx34vEpXspFoKjEphWyObT8gBYsGAJf4j0UIpek5LdvxeubtJ6i5AJzsYHT9
 VG+naFZxJAKNzCiNatZCjQZxdvvOeC+7ymuPcKrMZnPpNjYKChZwp/iylScvXvYjcpRc
 sNErwswKq7RBDrNaFNMTkJxmY38LH13R/n6P80FVnY2DrYyXEEHWy7f4zYSSev4jNrEE
 85Ddbp1QkxK3AjahFCoa1aFt3PI0piH/40HmKjTPeymb5FqqzcMKjrUAdxv70qGxL3xO
 A0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747433; x=1740352233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gf7AnWeJhPi2orAAKos1Bsyd6vzZ9LDQ/13vCQ40fQs=;
 b=i8y8saO7P87FR/k1LvsBtlslF4FfT8eLfQBGae/bLcKOAo1Z4o4fULByfT1F0NJrge
 /QXRxu/eNcpTYv5ARLgSiwpbRLwszrJ0TeahJus/o7JqDi+tFV1vnjCiSZVlYOgUWdGE
 mGM2QSU5eOp6MYaARtElgulF0ioUALrRxO79GTTIb+noOc9B9twZnidbZcT0MnWtn9aW
 tgXmDz5Y/4HfWJ2+NjFscezo+37rw9YriHEu6iqRbjF64sBkZIxBVT2eurqGKOYF80kC
 eTOFX262jbbJ/fsbMnCytsPZc5BJ52GiRV38GzOB+vewS4juU6Qt17PWt4r7LTO9H4pf
 q8ow==
X-Gm-Message-State: AOJu0YxaNEWrnu0T6g36tiofHH6ehPfxA/BcdmTU62zA0OfAHWj0Bq3P
 MBFSpYEYYca8PyCYLOyyjmM9+X7wnuz35Qjfwapv0ROnPD1KPIczkBXj94smvnPfmupkmw+CDh4
 A
X-Gm-Gg: ASbGnctuI5jFodYfsswa6A/UknZO1S88To39oC1IIzhhTilWofZRCANNULah/dg8mGa
 ZXeGDMn7S2jTby/kOXRKgk94kwhXOko5ykBL/fLtADX1kSPATJzFTcxvf5WhnuRT8EyFLeHqAkP
 XK29jJmeNYvoBsyBlN0vmEfy+1YdT7e3zWALvfE4F3LRMZpYMLeM2RBiLxFRNePw3XAbW7jUT78
 hf5TcuFK3Z4+5O+m2RVSUtorebVfsEOPFZrLw7pybDsve7/UwU4jDqGkfnYY74CJSmfZwXXrG8E
 rDMbsAIEpQarpJw1ik3afXy/ET6Eck7SlNDGlwlWO7lLm+0=
X-Google-Smtp-Source: AGHT+IEqpBV5W7Vdu/v4w+u3QMnFXlFLyJIS7c/U91q/IYEynenn/hwfbGiyjYPwqIAOU9ZZZ2S3SQ==
X-Received: by 2002:a17:902:ce89:b0:221:183:5bea with SMTP id
 d9443c01a7336-221040d74d8mr128015905ad.50.1739747433515; 
 Sun, 16 Feb 2025 15:10:33 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 026/162] tcg: Merge INDEX_op_nor_{i32,i64}
Date: Sun, 16 Feb 2025 15:07:55 -0800
Message-ID: <20250216231012.2808572-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
index 1acdd7cfda..aa9ed393c9 100644
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
index b4dc34b9b1..1fe73f70ed 100644
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
@@ -2988,7 +2989,8 @@ void tcg_optimize(TCGContext *s)
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
index e55ea24177..b740609c03 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1009,8 +1009,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
-    OUTOP(INDEX_op_nor_i32, TCGOutOpBinary, outop_nor),
-    OUTOP(INDEX_op_nor_i64, TCGOutOpBinary, outop_nor),
+    OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -5426,8 +5425,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index 3ea93fa5a6..ff129266c2 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -563,7 +563,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] & regs[r2]);
             break;
-        CASE_32_64(nor)
+        case INDEX_op_nor:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] | regs[r2]);
             break;
@@ -1077,6 +1077,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_andc:
     case INDEX_op_eqv:
     case INDEX_op_nand:
+    case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
@@ -1084,8 +1085,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
     case INDEX_op_div_i32:
     case INDEX_op_div_i64:
     case INDEX_op_rem_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 7703dfbc51..26d464fa38 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -331,7 +331,7 @@ Logical
 
      - | *t0* = ~(*t1* & *t2*)
 
-   * - nor_i32/i64 *t0*, *t1*, *t2*
+   * - nor *t0*, *t1*, *t2*
 
      - | *t0* = ~(*t1* | *t2*)
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index a0f4c58be8..dec51692f0 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -681,7 +681,7 @@ static const TCGOutOpBinary outop_nand = {
 static void tgen_nor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_nor_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_nor, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_nor = {
-- 
2.43.0


