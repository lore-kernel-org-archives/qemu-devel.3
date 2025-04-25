Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0667EC369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R48-0000n6-8U; Fri, 25 Apr 2025 17:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R42-0000Qd-1q
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R3z-0000m4-3l
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22438c356c8so33160435ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618305; x=1746223105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B375QJd4lHVOy9hIcrKJe83RSoV/3SQZ1Lgg8Cwlbog=;
 b=GjI7kUFoRERDjJdTBZlHZVp4aSVhkfpHYBCH+3jLAez5dxlscKhXldkJ+esBcBOfWl
 GteilWet8EIXkufLBYzo8LHQEjl0RkAtCdZvykmp/UlhZ3GuE8c7N9JPUxP2X4a8GN5y
 DmIKUotud1zhOl1HJs8WWT6GagGBjNUu2Li26SkCMONnHExGXSMiYZOZEJY1YXHw5N/2
 HycFsDP2MK9KpJequpRU+6IPKzHoVJqyfHWZOvsa0acduTtw0ROVosmTUDfNw+Hw85PU
 f+xDrgquodbuw5Rw4xQayA1dWgifGZElNhcz53PCvFRadUBBQ/C/BPKnYNuav8wcrMLp
 0Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618305; x=1746223105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B375QJd4lHVOy9hIcrKJe83RSoV/3SQZ1Lgg8Cwlbog=;
 b=V4N9sHwXsVqx3XPjdyOpqycoBbJ4MSmDoQyoZ0nVUdG/35kkMHOijX+sb675ZerN0/
 OvzI3hiDHDXVjSzITEgv51YTj9qTSmfF627FTLl50DgDtxwh0qzDfdPjN3+GyCV9FuKA
 uTGeFSENNAGJK77ZC9EfIh+AuTllP6jD3RlVRWvOXl1YSUgq4UtDAWPHC23MnPbhS3Fh
 HkTuNmKc64ghXffVwL8roCN0jQjo7hK86Uk42r4vGly4zm9WRbhNgZ6rbpEoGUbF7Mk2
 WomMh3wunRCY8WcF91rGIp2/vf95aieOcMuH0ZDa0gObuUKzYGTfZQuJApEQE3QEporJ
 tx/A==
X-Gm-Message-State: AOJu0Yx+X0GoVSwzpUJPLpwJq9YZ9jBEspS+ZJMTGw0WCWGY8Pt4ES3S
 nNSgVR2mXIC2il9QCEMQo3ZPGDQPycJFkVC1/haY1fWKDIo/wsZvSz+AYNH7h+ZtIZi35ofWQ8w
 8
X-Gm-Gg: ASbGncuu0nS3SuEOgV9222G4Q+aIIiF3iZUvFJbzMRpYn9MdTIoxuhcZ2sTKb3WsNsM
 lY5SXQNyGzCP9wLpu6o6Xz9yOXa9v84/Sd5ZCBk0pGN7maKP8mycaGw1C/rx8sh8tT/6Eo+2b+m
 Q4LipC8qBVrxact2aNOc351UbpZNIyZRDlaRtmsDBLH/paqWNTNmLpV4u9vSpx/XeAGsGtdGBDX
 2VRPTsU1LDK5+qwPHt13o8UKHwBj6tO2HfCBeG1TFz8TaObxWEv9liz97HI5waPz8zxZHyKiAWH
 V6mZ1qRiX8rfP+pJWMhtSix3BxSwQDdGX7df4Tw/XgZAsYZrhbxOnMrmsrmkHRKSfhBVl5COOxX
 Yk70+KetZew==
X-Google-Smtp-Source: AGHT+IFwFpQRj6J7Cj0erUE+ZnVcgAnbnrm5aVKQMsXWzDV6+bZ7mYWiXeKEbgrRne/IhgNZoFmzkA==
X-Received: by 2002:a17:903:3d0d:b0:223:669f:ca2d with SMTP id
 d9443c01a7336-22dbf62c774mr65331705ad.35.1745618305099; 
 Fri, 25 Apr 2025 14:58:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 040/159] tcg: Merge INDEX_op_mul_{i32,i64}
Date: Fri, 25 Apr 2025 14:52:54 -0700
Message-ID: <20250425215454.886111-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 tcg/optimize.c           |  4 ++--
 tcg/tcg-op.c             | 12 ++++++------
 tcg/tcg.c                | 14 ++++++--------
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index d0fcdfd241..4ecba62fda 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
+DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(neg, 1, 1, 0, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
@@ -65,7 +66,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(mul_i32, 1, 2, 0, 0)
 DEF(div_i32, 1, 2, 0, 0)
 DEF(divu_i32, 1, 2, 0, 0)
 DEF(rem_i32, 1, 2, 0, 0)
@@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(mul_i64, 1, 2, 0, 0)
 DEF(div_i64, 1, 2, 0, 0)
 DEF(divu_i64, 1, 2, 0, 0)
 DEF(rem_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 315ee0a8bc..653246f3d2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -430,7 +430,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_sub:
         return x - y;
 
-    CASE_OP_32_64(mul):
+    case INDEX_op_mul:
         return x * y;
 
     case INDEX_op_and:
@@ -2963,7 +2963,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(movcond):
             done = fold_movcond(&ctx, op);
             break;
-        CASE_OP_32_64(mul):
+        case INDEX_op_mul:
             done = fold_mul(&ctx, op);
             break;
         CASE_OP_32_64(mulsh):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ddc1f465a4..76d5b67fba 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -585,7 +585,7 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
 
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_mul_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_mul, ret, arg1, arg2);
 }
 
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1134,7 +1134,7 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op4_i32(INDEX_op_mulu2_i32, rl, rh, arg1, arg2);
     } else if (TCG_TARGET_HAS_muluh_i32) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul_i32, t, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
         tcg_gen_op3_i32(INDEX_op_muluh_i32, rh, arg1, arg2);
         tcg_gen_mov_i32(rl, t);
         tcg_temp_free_i32(t);
@@ -1158,7 +1158,7 @@ void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op4_i32(INDEX_op_muls2_i32, rl, rh, arg1, arg2);
     } else if (TCG_TARGET_HAS_mulsh_i32) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul_i32, t, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
         tcg_gen_op3_i32(INDEX_op_mulsh_i32, rh, arg1, arg2);
         tcg_gen_mov_i32(rl, t);
         tcg_temp_free_i32(t);
@@ -1636,7 +1636,7 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     TCGv_i32 t1;
 
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_mul_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
         return;
     }
 
@@ -2844,7 +2844,7 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
     } else if (TCG_TARGET_HAS_muluh_i64) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
         tcg_gen_op3_i64(INDEX_op_muluh_i64, rh, arg1, arg2);
         tcg_gen_mov_i64(rl, t);
         tcg_temp_free_i64(t);
@@ -2863,7 +2863,7 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op4_i64(INDEX_op_muls2_i64, rl, rh, arg1, arg2);
     } else if (TCG_TARGET_HAS_mulsh_i64) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
         tcg_gen_op3_i64(INDEX_op_mulsh_i64, rh, arg1, arg2);
         tcg_gen_mov_i64(rl, t);
         tcg_temp_free_i64(t);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4d221cea6f..d16ed332c8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1021,8 +1021,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
-    OUTOP(INDEX_op_mul_i32, TCGOutOpBinary, outop_mul),
-    OUTOP(INDEX_op_mul_i64, TCGOutOpBinary, outop_mul),
+    OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
@@ -4035,22 +4034,22 @@ liveness_pass_1(TCGContext *s)
             goto do_not_remove;
 
         case INDEX_op_mulu2_i32:
-            opc_new = INDEX_op_mul_i32;
+            opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_muluh_i32;
             have_opc_new2 = TCG_TARGET_HAS_muluh_i32;
             goto do_mul2;
         case INDEX_op_muls2_i32:
-            opc_new = INDEX_op_mul_i32;
+            opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh_i32;
             have_opc_new2 = TCG_TARGET_HAS_mulsh_i32;
             goto do_mul2;
         case INDEX_op_mulu2_i64:
-            opc_new = INDEX_op_mul_i64;
+            opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_muluh_i64;
             have_opc_new2 = TCG_TARGET_HAS_muluh_i64;
             goto do_mul2;
         case INDEX_op_muls2_i64:
-            opc_new = INDEX_op_mul_i64;
+            opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh_i64;
             have_opc_new2 = TCG_TARGET_HAS_mulsh_i64;
             goto do_mul2;
@@ -5436,8 +5435,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
+    case INDEX_op_mul:
     case INDEX_op_nand:
     case INDEX_op_nor:
     case INDEX_op_or:
diff --git a/tcg/tci.c b/tcg/tci.c
index 96e3667ab2..61c0ccf21e 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -531,7 +531,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] - regs[r2];
             break;
-        CASE_32_64(mul)
+        case INDEX_op_mul:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] * regs[r2];
             break;
@@ -1072,14 +1072,13 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
+    case INDEX_op_mul:
     case INDEX_op_nand:
     case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_mul_i32:
-    case INDEX_op_mul_i64:
     case INDEX_op_div_i32:
     case INDEX_op_div_i64:
     case INDEX_op_rem_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 96dddc5fd3..6c36e72242 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -273,7 +273,7 @@ Arithmetic
 
      - | *t0* = -*t1* (two's complement)
 
-   * - mul_i32/i64 *t0*, *t1*, *t2*
+   * - mul *t0*, *t1*, *t2*
 
      - | *t0* = *t1* * *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index ce17079ffc..ffc8654427 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -662,7 +662,7 @@ static const TCGOutOpBinary outop_eqv = {
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_mul_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_mul, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_mul = {
-- 
2.43.0


