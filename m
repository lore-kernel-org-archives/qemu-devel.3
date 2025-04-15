Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADAAC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m1y-0003e1-GL; Tue, 15 Apr 2025 15:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzB-0007xk-Vw
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:22 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly5-0000nN-Lu
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:20 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-306b78ae2d1so5608239a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745347; x=1745350147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAacU+RP03yhT8N38xAqmT6Y0wi159EKhW0yfV91dXw=;
 b=LuuFzlA0RXBLGwbSzVxZLv/R+1upwJpbJ1Epbe/ppu0NvKxpyOz72w8kFl596zxNKl
 Y+HcKI5uGYFNejaAok9Lkp4CfEAhaoFLNf3mkreCq+OI5GWNiLKfeBMqbqM/Ul81ryYu
 pEuhLJDbUH81pva3W4+Q7JVtMkRno/fczWPMKJvelAIsHYZ/7Vm/yxyc251RBB5R5aKO
 hYIJMRHBHzW9fAK8ewZq1g2uQ5xK76d5RtKeAOZCJy1Ie59DARRjItqK3j5WoAPepMMz
 jSxBg6O1dusUx0+ggApXRaX4HcSCuHC4HXMOHunJWQwH8Kdcma4MtspcV4wjz/Zp0GXU
 iVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745347; x=1745350147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sAacU+RP03yhT8N38xAqmT6Y0wi159EKhW0yfV91dXw=;
 b=I3GnSExzxEesrNWRGyIZFPf6HYkPijPPqI7/k9eHwClGv1XF20lMQfwLSbmvA54+aS
 +dsGAt8QRmQCIKMtn2ebmh26dIbGn21DPDoJrQlK1O87Et/8FKtW/YY1Qk3cP/EHAhgr
 Vt5PtXstNLJftfhvOFjhj/Mf4UwyfQKL8ZaWLA8dxYKnLDDI9x+gX8hv1x/4OJB8gLBr
 rSgp00376vqwRn0eJJ9EAt1Hmhh8Mz5a1J1Ubknp9hpRe6rS5/oD2XY4gjH7MEEvdyEp
 HJOyTw9pRXUv8BijS1oKPSo41Rvh6pPdk9coj1dLngaffotdcSfySysawJ8AVPYGVuj4
 dQEA==
X-Gm-Message-State: AOJu0YwFP78hJW89Gq31FdRVkFScODkFlkqgtfl7nz77BV4gjI14IFHJ
 pJCg0dXMjVl9AM2RxDrA2FwSkSn1j/GtxAJ8IKeGmF1HuBzh3fFkwnNCI1sobq790SRI5zfOZZm
 b
X-Gm-Gg: ASbGnctwRPE1ittfEXgNMTCkrpBmT3i1U+s3y2d+TOxPI3ZLQICbPI4djGEPI54xpI1
 lX/d464ZY16X92SK7bMHbWhPYRyYNZvgro7p3wEGTI9O4EUvY+24qR/eLK7BX1s2KDAdnIFBlX9
 GuSOkpwzSJmFIerz1g4rmpDbUa4Qf3rXGe6ejwWRz6RlNuOTiRrQXuLhapzgP1otouWeMF2CD54
 thYIgbuCa4f9nGDpFJCcKFVfYuKvIk+yIodh8zX7xb+SFIkvICLstEWhswoVSExVLXG08CZfRdd
 TMx7GSpoCFBsadFKZP/9X20okw/S3L3eeCIy3ZZR3OlPaoeJ10r0E+WhCEwYM+RvQ0PnJ4dt8aY
 =
X-Google-Smtp-Source: AGHT+IE2+Y0tyPMQK3TyhQGJeBYKPDWSUCgdALiy4elQwBOFyqjCAE/fzZkegbqd9SbK9K4p1EAnkg==
X-Received: by 2002:a17:90b:1f8c:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-3085ef3669amr589118a91.17.1744745347132; 
 Tue, 15 Apr 2025 12:29:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 058/163] tcg: Merge INDEX_op_sar_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:29 -0700
Message-ID: <20250415192515.232910-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
 tcg/optimize.c           | 12 ++++++------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                | 12 ++++--------
 docs/devel/tcg-ops.rst   |  4 ++--
 tcg/tci/tcg-target.c.inc |  3 +--
 7 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 35e0be8f80..cb8c134e94 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -58,6 +58,7 @@ DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(rems, 1, 2, 0, TCG_OPF_INT)
 DEF(remu, 1, 2, 0, TCG_OPF_INT)
+DEF(sar, 1, 2, 0, TCG_OPF_INT)
 DEF(shl, 1, 2, 0, TCG_OPF_INT)
 DEF(shr, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
@@ -76,7 +77,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(sar_i32, 1, 2, 0, 0)
 DEF(rotl_i32, 1, 2, 0, 0)
 DEF(rotr_i32, 1, 2, 0, 0)
 DEF(deposit_i32, 1, 2, 2, 0)
@@ -115,7 +115,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(sar_i64, 1, 2, 0, 0)
 DEF(rotl_i64, 1, 2, 0, 0)
 DEF(rotr_i64, 1, 2, 0, 0)
 DEF(deposit_i64, 1, 2, 2, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index a10fb67da8..edf5c1c77a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -446,10 +446,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (uint64_t)x >> (y & 63);
 
-    case INDEX_op_sar_i32:
-        return (int32_t)x >> (y & 31);
-
-    case INDEX_op_sar_i64:
+    case INDEX_op_sar:
+        if (type == TCG_TYPE_I32) {
+            return (int32_t)x >> (y & 31);
+        }
         return (int64_t)x >> (y & 63);
 
     case INDEX_op_rotr_i32:
@@ -2588,7 +2588,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
     }
 
     switch (op->opc) {
-    CASE_OP_32_64(sar):
+    case INDEX_op_sar:
         /*
          * Arithmetic right shift will not reduce the number of
          * input sign repetitions.
@@ -3015,7 +3015,7 @@ void tcg_optimize(TCGContext *s)
             break;
         CASE_OP_32_64(rotl):
         CASE_OP_32_64(rotr):
-        CASE_OP_32_64(sar):
+        case INDEX_op_sar:
         case INDEX_op_shl:
         case INDEX_op_shr:
             done = fold_shift(&ctx, op);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ef8cf5a1ac..43848ebc4f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -511,7 +511,7 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_sar_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_sar, ret, arg1, arg2);
 }
 
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1624,7 +1624,7 @@ void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_sar_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
     } else {
         gen_helper_sar_i64(ret, arg1, arg2);
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b5d7aeea83..e3ab8bf7f0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1042,8 +1042,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
-    OUTOP(INDEX_op_sar_i32, TCGOutOpBinary, outop_sar),
-    OUTOP(INDEX_op_sar_i64, TCGOutOpBinary, outop_sar),
+    OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -5418,8 +5417,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
-    case INDEX_op_sar_i32:
-    case INDEX_op_sar_i64:
+    case INDEX_op_sar:
     case INDEX_op_shl:
     case INDEX_op_shr:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 376b1b1ece..2a2f216898 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -625,9 +625,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] >> (regs[r2] % TCG_TARGET_REG_BITS);
             break;
-        case INDEX_op_sar_i32:
+        case INDEX_op_sar:
             tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int32_t)regs[r1] >> (regs[r2] & 31);
+            regs[r0] = ((tcg_target_long)regs[r1]
+                        >> (regs[r2] % TCG_TARGET_REG_BITS));
             break;
 #if TCG_TARGET_HAS_rot_i32
         case INDEX_op_rotl_i32:
@@ -787,10 +788,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (64 bit). */
 
-        case INDEX_op_sar_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int64_t)regs[r1] >> (regs[r2] & 63);
-            break;
 #if TCG_TARGET_HAS_rot_i64
         case INDEX_op_rotl_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
@@ -1073,12 +1070,11 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
+    case INDEX_op_sar:
     case INDEX_op_shl:
     case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_sar_i32:
-    case INDEX_op_sar_i64:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index f9fd4b0087..be82fed41a 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -389,10 +389,10 @@ Shifts/Rotates
      - | *t0* = *t1* >> *t2* (unsigned)
        | Unspecified behavior for negative or out-of-range shifts.
 
-   * - sar_i32/i64 *t0*, *t1*, *t2*
+   * - sar *t0*, *t1*, *t2*
 
      - | *t0* = *t1* >> *t2* (signed)
-       | Unspecified behavior if *t2* < 0 or *t2* >= 32 (resp 64)
+       | Unspecified behavior for negative or out-of-range shifts.
 
    * - rotl_i32/i64 *t0*, *t1*, *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index f50a2d6574..feaa13dff0 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -779,7 +779,7 @@ static void tgen_sar(TCGContext *s, TCGType type,
         tcg_out_ext32s(s, TCG_REG_TMP, a1);
         a1 = TCG_REG_TMP;
     }
-    tcg_out_op_rrr(s, glue(INDEX_op_sar_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_sar, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_sar = {
@@ -897,7 +897,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(sar)
     CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
-- 
2.43.0


