Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D8EC369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R5J-00054F-Ka; Fri, 25 Apr 2025 17:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4H-0001RT-1Y
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:45 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4E-0000qI-Ia
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:44 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2264aefc45dso44701585ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618321; x=1746223121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDyqMXu9FMncM6B2zfmDw44VdGlW7EFYL04imGTOLJ0=;
 b=TR4c1fY9ot4rDn3fJPmzrC7O2noTsJMSpjj3jx/yOe21DRGjdby2FiFCWH4mxqp3gO
 jae1n1kTOPIAlIvpegM+DW9+vr7kQ3JLTjw3yj5qsKx5x8fEndiDbCV8c9k/X7wKzjED
 aQhw+0fiuM2fAR7aqX5I4Oo45daHb8Y2vcboQLEcQ9Whtl/nAYO2jNOf8xsjQ7XgUDWm
 Oqic/8IICN2NxxI60DIOH8bTse5rihczN2Fhbrw+0xoPgaoURUOZqLjXCXPAbx7U07Rs
 6Ue7bAA+Z2pEKQxVUrJe5PqF5wJ2Ag1TVnq0TYSPypSndhlhlbXzD8d1V5X2u1Zw7y06
 c1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618321; x=1746223121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDyqMXu9FMncM6B2zfmDw44VdGlW7EFYL04imGTOLJ0=;
 b=qM45U5EAaiGBwq4YP1janwkmHt+A1+96wogWhHWTOpEb0Jf4B3NgfK/S0K0tW9rcZc
 68icGCubony76PoFTT/rU2qeBzNUJPwtOygtd6PpF5Q7wvCDGTxkvYBziWNIv8bCkn7T
 Yn/1QHmrai9ndTtvGeEPK1qLVmeaqpVwi4JdNItMWiqfCcLn7nYZFDsHQpCeMBPDwlhl
 Ci8/p6XOqmtsD9/Eai7QCaXwmWFET4I/vAWPnwRriA3Yib6OqEE1CrBbga3L5E+M4bQY
 dBucEg4lPfbhzkBYF31iTQ+GrlkfrH+4ocambHqO1HKQgJDQVRf7RsSxXb/CBCmwi1sl
 QU+A==
X-Gm-Message-State: AOJu0Yz8Cot1d/Qfu4UcCym7RJqNlkf0SNK3+p5ESshN5MsnK82/XY3G
 5vtKNtSXKnCzI8P/QO0i0B7038JwDEtD2DIyBpF8AUcyK9J35Y7/kgukkM1xGkNIaxCHZGuVqRh
 N
X-Gm-Gg: ASbGncv9fIEwAAnoTrNUoO/jGcQ+JGYc25n/BREh80w6+Uaty+FaUB8VzK3ekEbva/Z
 QtBDuhEACQ65hgKAT6OUCg1QGmqAYPpf1xhg59he8DSHrhCALj/1C7Kw6laWRQx0uXzmTjy5MRG
 i4/T0B2pcrb78XtrWHSY4tnhvMD4TEagqVCHtZIaxiIJuQN2pG2UXMZs6CCNNv8LHHzyVG21jVz
 TDV1knoU4PWH1s907fo2dKr+Bu8SqJbfMwzXR6EbpPcrWzF8r6tfzEtKPauSW+7be1kuSTFTHf0
 xHQ1wH11BZaRjtH8SMiqFjxFdphTjCldx5Mkcwpvq6n9V8oW+AY/fQC3hsaOGCzMNfVOkNk2Pnr
 dNmL7SNBgjw==
X-Google-Smtp-Source: AGHT+IFw8JzKtpAsiEhAIycJbWuhUgCl8tj087OAp2GSaabre7exLlEgi1NDIzUY0xcmtC8iWe0B0g==
X-Received: by 2002:a17:902:d4ca:b0:220:f87d:9d5b with SMTP id
 d9443c01a7336-22dbf5faf1emr65267025ad.24.1745618320851; 
 Fri, 25 Apr 2025 14:58:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 058/159] tcg: Merge INDEX_op_shl_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:12 -0700
Message-ID: <20250425215454.886111-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
index 69f9ba1555..3142daa800 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -446,10 +446,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
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
@@ -3031,7 +3031,7 @@ void tcg_optimize(TCGContext *s)
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
index 369a1e6d48..50935b7e03 100644
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
@@ -5423,8 +5422,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


