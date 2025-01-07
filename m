Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6281DE77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bk-0005pp-LW; Tue, 07 Jan 2025 03:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4av-0001aB-S5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:45 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4an-0003fU-MX
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:45 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2163b0c09afso219737695ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237136; x=1736841936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54ChltdfZjTQSs898C7Oh4sLXNp7n5Qx5C2mSs6v/nI=;
 b=VDDWt0YyqQyb795ttutfomas0HpVWmCVN2Zf+f53e5+J1PdfsbFRhnzBVGNZAStj1c
 tB6onSL6EMpZWPorsQEJlUtfFNMWTLKhu3j0drMvdELyWDIrQr/cv3cKKtDujPPoYpRI
 Ao4jkLO4/1Y8Gw4Rpbyzx6wH3w+bA9GsFrSqWqmSAEUZd3QGvbOQIBPb9XW0rC4grLP9
 1itbpWAGBGT724AkZ8J+qCftfmRGrPDc79/R9PmM8vdU1v3I9vYD+w3RDxJcr0mBLR3f
 Tm1lc9QV8jqZ8Jm4H+bBsWrYntpdwXiiNcrUjMFScnDQEq0DoL8eehYaR4f9MLqjyRoS
 CRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237136; x=1736841936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54ChltdfZjTQSs898C7Oh4sLXNp7n5Qx5C2mSs6v/nI=;
 b=XvHYD6d980+qyFqAfMswPqtaNGCM9ZGQGzwqWk1msa2IvKtggEOMcr9ImlTv9WPdJO
 RG95u/udfdf+XkPeZMzVVND+oiuUlV4uH4XzcSJEhD984YP1DcCfSOQNIh+j0r8xRcpX
 +3W35XwHfc/ZRfmY6zqeeWXEwnfi6alW8kvRJPCqoXJplmOZeD1n8WSiVJOvox31kPDk
 3krQY3BB5dJs3c7gyRumF4GGX8kWZahgwxuDnukJ6YrKwunEcYCE6hHe2FAgiN3b0fKi
 NxEr5Z2qCxDqh/+gRyT06lEIel490ZinfqBDiTfS28D/KTV++VLkeaNbhWWSekWayCPi
 mjwg==
X-Gm-Message-State: AOJu0YwiCtMdQS1cilAQeVpVKjPBYd4x4dhhLgkc5jpuyyt0VZxNzcl5
 YuJgP+jLD1FLvQNI/ADxMw0ICZdxTugfiuMSweL+hxYLbDMkEdDw15soEuglVOb6G5R2f0A2y4w
 4
X-Gm-Gg: ASbGncvDXBTlVxwp8IAE/OM5YuonXXsIoPFDJS9JkxFbOVLk8KP7w2HFhEK4HKYKz3K
 dbFVMRRNF30VDqiN3ZPSJtj1hFwJr1UhJ8lyDwVJolILogRvnBEnYypVmtVQiFEpjyHqYwSNCJZ
 Lptw/OPR+HhN+CSkTgSYWWVDX1+mbYD96jcu1Tc/c7FABMA6bHLftjI0w6H5uDmTw0XQRRjRuK3
 NF1AtzyidEDT/u27laGqEP2aB8kS5uy9fHpChQyDtxGkEzE2GCdoDign4+ctdTMDwaKub8+Cr/o
 4MRW2vT2t8Lf6nCQcQ==
X-Google-Smtp-Source: AGHT+IFXLXUIce+h2Hw1P/AyQagX+oAiUlEJ4tm6rUT/KEouSlkDEPXM++XhiywNzz1lPUuThDTsRA==
X-Received: by 2002:a05:6a21:328d:b0:1e0:f495:50bb with SMTP id
 adf61e73a8af0-1e5e084326emr89779992637.44.1736237136065; 
 Tue, 07 Jan 2025 00:05:36 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 77/81] tcg: Merge INDEX_op_sub_{i32,i64}
Date: Tue,  7 Jan 2025 00:01:08 -0800
Message-ID: <20250107080112.1175095-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           |  4 ++--
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                | 10 +++-------
 tcg/tci.c                |  5 ++---
 tcg/tci/tcg-target.c.inc |  2 +-
 6 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index b374fd39e8..69fa55f3c6 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -47,6 +47,7 @@ DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
+DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
@@ -62,7 +63,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(sub_i32, 1, 2, 0, 0)
 DEF(mul_i32, 1, 2, 0, 0)
 DEF(div_i32, 1, 2, 0, 0)
 DEF(divu_i32, 1, 2, 0, 0)
@@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(sub_i64, 1, 2, 0, 0)
 DEF(mul_i64, 1, 2, 0, 0)
 DEF(div_i64, 1, 2, 0, 0)
 DEF(divu_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9352528684..2acff375b7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -415,7 +415,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_add:
         return x + y;
 
-    CASE_OP_32_64(sub):
+    case INDEX_op_sub:
         return x - y;
 
     CASE_OP_32_64(mul):
@@ -3058,7 +3058,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(sextract):
             done = fold_sextract(&ctx, op);
             break;
-        CASE_OP_32_64(sub):
+        case INDEX_op_sub:
             done = fold_sub(&ctx, op);
             break;
         case INDEX_op_sub_vec:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 228aa8f088..15faf4dc57 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -377,7 +377,7 @@ void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_sub_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
 }
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
@@ -1565,7 +1565,7 @@ void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_sub_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
     } else {
         tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
                          TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a87aac8a32..65582828ea 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1007,8 +1007,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
-    OUTOP(INDEX_op_sub_i32, TCGOutOpSubtract, outop_sub),
-    OUTOP(INDEX_op_sub_i64, TCGOutOpSubtract, outop_sub),
+    OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
 
@@ -4011,10 +4010,8 @@ liveness_pass_1(TCGContext *s)
             opc_new = INDEX_op_add;
             goto do_addsub2;
         case INDEX_op_sub2_i32:
-            opc_new = INDEX_op_sub_i32;
-            goto do_addsub2;
         case INDEX_op_sub2_i64:
-            opc_new = INDEX_op_sub_i64;
+            opc_new = INDEX_op_sub;
         do_addsub2:
             nb_iargs = 4;
             nb_oargs = 2;
@@ -5441,8 +5438,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
+    case INDEX_op_sub:
         {
             const TCGOutOpSubtract *out = &outop_sub;
 
diff --git a/tcg/tci.c b/tcg/tci.c
index d2a5192128..1e176f03ee 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -537,7 +537,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] + regs[r2];
             break;
-        CASE_32_64(sub)
+        case INDEX_op_sub:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] - regs[r2];
             break;
@@ -1136,9 +1136,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
+    case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_div_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 519a16b31d..c083dd604f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -734,7 +734,7 @@ static const TCGOutOpBinary outop_orc = {
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_sub_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_sub, a0, a1, a2);
 }
 
 static const TCGOutOpSubtract outop_sub = {
-- 
2.43.0


