Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C19AC369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m65-0000VG-Us; Tue, 15 Apr 2025 15:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzH-0008MV-7p
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly8-0000mJ-Oq
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:26 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so5054303b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745344; x=1745350144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mpjDSImYM39bxOF0uzODvxoy+1Zg4zxowbFJ9taEfo=;
 b=yAXrCEGLWej/PUBUcu3JLWkvCBHoCeh7BBdtsuTfoL24vzSNfWYGlMi6QF33j1elVK
 K1ZP6duD/AzOqSITpTCWfFvI5yRqGg+jU0mO6+JyMm58vBlXLoix0UmbciTjIkZ9GfCu
 5wbcvvhF9xfefu7NS3l85fauP4lWGtKJxoYG3hOXAC+z0KgnQtAOBdW/fH/qokdXynXb
 YSnc/wKbms2tFfrj++S+8h59vYBF6f4ZkQ47QYVfVHWL5QwpemiyrDVmhGZHfbMqyqm6
 uhQsjSUht1/Jr/WP5eY1LmI64X3wDsqQKZ/uPje8bDPGkBWUImn4O/cA7ssaSc5CjKQj
 GdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745344; x=1745350144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mpjDSImYM39bxOF0uzODvxoy+1Zg4zxowbFJ9taEfo=;
 b=RYoCQr7LADM/nlmciAuNFjCitkrv22h7roFoyTYzw6KwT9omhKNXJD0sBaNEGvIV9F
 ZyDZMmztyJXgmKn3GbeFwtEUZxRVXkvHEQ+nSyoFsDrKcCdaENdQ3R6G7waheUMAalhw
 30r5zPP76FeYckk9MP/lBPEVSxEmjSg18qMCvMLFEE7S23toYTI0lUGsRIstdDpR9JV2
 6Q+pjDWqiXSPjCHut2jkUN/zYDfpOj3r087TYGxn1JruCbMlS1RJJ7OxFdOU4eGYFhBx
 GMFpgHzz2XTfYpgzSJyz+6WOzIg8ZpixmyN68BiqCXm2W3q5zKQp8pmiX2p/muM1X2BU
 3/nA==
X-Gm-Message-State: AOJu0YxFrMgtmxwa3Wx1lTrT8flFTtQ9lfeNXmbBCmPQ4H54tiPT2Gvv
 AFBNPmB6jwaONWZyMynRaKLzUuCqIqIzghdpYtP0I9qv6YI2Ok30s9C30A5PiRiwrHoDAo6O7Hv
 i
X-Gm-Gg: ASbGnct7xH8Sd7RvmXFtKeplX0GpqM92zZqk3hD4/75wmUGAVmZ5idWN/XNwDg4wWrA
 l119cRDD6aIlZ96VaB2MLW1Id2EPy/GgEvVYFeB1J1QWxburtNJxz3ekiOKyLcMSR6CnJIm8CLJ
 ec/2rwu6e2dzQCiSnAca74bzOpJ82Q25vIEvexW97AHp2xKhtS/Vw2S2WOryQuY18NMXcm6nb50
 FGzsdQsk3OuqUqy0CSqEK9CdBzpG/6UuiX3Hh5qENFUYYoVsZnNEj9Ucd2Di43ZLCUKNwZ3ANvV
 UGq6LEtpVgYLNGy9ITkx5KJEoU3HyTR9f8FHl+TzueOxvX8vNCzd2CXIK8vdDjQ+fYYRXEtuU90
 =
X-Google-Smtp-Source: AGHT+IH1DqufhFecXMBlXDCx8yAkMacPBzQCR8SR33Z9EFX1fCk7Nng8ULQx8zz5Vyyb7bcpDvgP7A==
X-Received: by 2002:a17:90b:5686:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-3085eecc283mr576165a91.5.1744745343726; 
 Tue, 15 Apr 2025 12:29:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 054/163] tcg: Merge INDEX_op_shl_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:25 -0700
Message-ID: <20250415192515.232910-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 10 +++++-----
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                | 13 ++++---------
 docs/devel/tcg-ops.rst   |  4 ++--
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index ebb23347e9..c2ac25d1b6 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -58,6 +58,7 @@ DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(rems, 1, 2, 0, TCG_OPF_INT)
 DEF(remu, 1, 2, 0, TCG_OPF_INT)
+DEF(shl, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
@@ -74,7 +75,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
 DEF(sar_i32, 1, 2, 0, 0)
 DEF(rotl_i32, 1, 2, 0, 0)
@@ -115,7 +115,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(shl_i64, 1, 2, 0, 0)
 DEF(shr_i64, 1, 2, 0, 0)
 DEF(sar_i64, 1, 2, 0, 0)
 DEF(rotl_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6f0887f808..bc882dbe31 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -434,10 +434,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
     case INDEX_op_xor_vec:
         return x ^ y;
 
-    case INDEX_op_shl_i32:
-        return (uint32_t)x << (y & 31);
-
-    case INDEX_op_shl_i64:
+    case INDEX_op_shl:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x << (y & 31);
+        }
         return (uint64_t)x << (y & 63);
 
     case INDEX_op_shr_i32:
@@ -3019,7 +3019,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(rotl):
         CASE_OP_32_64(rotr):
         CASE_OP_32_64(sar):
-        CASE_OP_32_64(shl):
+        case INDEX_op_shl:
         CASE_OP_32_64(shr):
             done = fold_shift(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0f1e83a49f..c85c056726 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -481,7 +481,7 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_shl_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_shl, ret, arg1, arg2);
 }
 
 void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1606,7 +1606,7 @@ void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_shl_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
     } else {
         gen_helper_shl_i64(ret, arg1, arg2);
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a203a60e87..83a7f2c1df 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1042,8 +1042,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
-    OUTOP(INDEX_op_shl_i32, TCGOutOpBinary, outop_shl),
-    OUTOP(INDEX_op_shl_i64, TCGOutOpBinary, outop_shl),
+    OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
@@ -5420,8 +5419,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
+    case INDEX_op_shl:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/tcg/tci.c b/tcg/tci.c
index 5d2cba4941..22401ce1f6 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -615,11 +615,11 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             break;
 #endif
 
-            /* Shift/rotate operations (32 bit). */
+            /* Shift/rotate operations. */
 
-        case INDEX_op_shl_i32:
+        case INDEX_op_shl:
             tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (uint32_t)regs[r1] << (regs[r2] & 31);
+            regs[r0] = regs[r1] << (regs[r2] % TCG_TARGET_REG_BITS);
             break;
         case INDEX_op_shr_i32:
             tci_args_rrr(insn, &r0, &r1, &r2);
@@ -787,10 +787,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (64 bit). */
 
-        case INDEX_op_shl_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = regs[r1] << (regs[r2] & 63);
-            break;
         case INDEX_op_shr_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] >> (regs[r2] & 63);
@@ -1081,10 +1077,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
+    case INDEX_op_shl:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index bceecb0596..f64c881530 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -379,10 +379,10 @@ Shifts/Rotates
 
 .. list-table::
 
-   * - shl_i32/i64 *t0*, *t1*, *t2*
+   * - shl *t0*, *t1*, *t2*
 
      - | *t0* = *t1* << *t2*
-       | Unspecified behavior if *t2* < 0 or *t2* >= 32 (resp 64)
+       | Unspecified behavior for negative or out-of-range shifts.
 
    * - shr_i32/i64 *t0*, *t1*, *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 748bb8118f..ca83a097ab 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -779,7 +779,7 @@ static const TCGOutOpBinary outop_remu = {
 static void tgen_shl(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_shl_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_shl, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_shl = {
-- 
2.43.0


