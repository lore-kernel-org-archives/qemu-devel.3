Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E876C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m34-0005i6-4D; Tue, 15 Apr 2025 15:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzB-0007vE-3y
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:21 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly4-0000ks-UV
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:18 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-ad51f427054so4334750a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745340; x=1745350140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y2U5arwQvdrmWqz1pxG0P8lhplP2h8SsF0zj0uJ9k6I=;
 b=D0OKC4XNX6QV75t7CpH0eRYKzTEVUT+gYCKWM73mGXRtBJJEsb9Cq10KeGBvpfUGEt
 0P1ryFfOm4INSrV/ZP0Zx7w8BJB1wbqKiXOwCwRd1d0jveQvZXyFZlAIt2paDJ5c21Cr
 BPDz0GP+pC6jQdQH6dQds+fH4Myyh03IAbE2090dvgthT5SDUl4GajhpJjROau31Ibqg
 m6FRUxU9qIPUbdWU4+Le9cPNB8mO55+MccFWoRf+nZC4EciWMLzC7WMje34KYn7nRY30
 GBhW2mFMaDRj5KizmnVoFSqjdYuLXGtgXWAX2vMDvSk0wttI7STeQ8ct1NJRhxUWtFK2
 5CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745340; x=1745350140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2U5arwQvdrmWqz1pxG0P8lhplP2h8SsF0zj0uJ9k6I=;
 b=KzJaKqeLSZD4nFB1qi9XXnoGvbMYrggMVD3taD+IntxXIQIdNuTrWl9uAPBNUEguww
 hQ7dHCraV1ESZNLvVXDLbiWpkq6jT6DM0Z9kDyEtC3+h+WFDFImUFGnY/yOeOovoE99G
 Q1c/yqKKn69cIMR/VW9aLiYEQCA8iRgeSHGqq4ovvC7omrEKedqax5nupIB+Uph6sPC7
 +ISL5oHSSKFBb6PXOYF2bsXGMmK+HLSWj5FJaugh9OsLpsqv7sF188pTViX7I19zNyYt
 tqKhMPYjR9fimT0IjNSriyWvawY24QUk4FY3m68MuzFFHOFBiNz6j9I1UtgiwFgvclEd
 EGYQ==
X-Gm-Message-State: AOJu0YyPf/4c9ujMMeOeMq7M4lTC+UraTzUU4gXIPR71sgtvFAKCRt88
 sKRDUZ5zJcYk4opD0UuGTwmAw58w4SqioDvjj/kTUqEK2x/UR+4yfCOqZUjk/4tKqN+YzbsEXT0
 X
X-Gm-Gg: ASbGnctaB8npSOw+oD6JN6n3UPbUn11MJT5yHsa7Sv1hIsPhqQI9jzfHqYseHLimOKj
 zf7tS7DfTTIfqEBQBdA06xvyEfbpIpGRPc6yax+6wYKF/cyKI69I1BPBzkBStzazoLWJemgVy7e
 GRMFVzAZCkI0Y6/wTCnowQwUzVAxZz9T3bZVFdaBLKX94fC844aPB54FCkp3inVGKD3shP0JfBU
 Rf8LnldkSOmzfOXq08GlSy3XFZ/IZAU8/TvKVNXG3q9AzGhlQ3EPmU+iPJcNzeOa4pxs4Ny91Eu
 w9yA+TbjMkkj/MgQFFzcSR0AgiJPCxdfUDW4DUq7SFhmlVupoUS1ly4YyE1EGdltoYhQFvcrfzw
 =
X-Google-Smtp-Source: AGHT+IHPmtNgaeDlOcN2BfNFgahO53wqMA2z28ckLVkSb5tA6XozLR+tPhW2Cg/QvprxrWkcEscUZQ==
X-Received: by 2002:a17:90b:1f8c:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-3085ef3669amr588710a91.17.1744745340394; 
 Tue, 15 Apr 2025 12:29:00 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.28.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:28:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 050/163] tcg: Merge INDEX_op_rem_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:21 -0700
Message-ID: <20250415192515.232910-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Rename to INDEX_op_rems to emphasize signed inputs,
and mirroring INDEX_op_remu_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 12 +++++++-----
 tcg/tcg-op.c             |  8 ++++----
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                |  4 ++--
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 61e5e185cc..040f4da835 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -56,6 +56,7 @@ DEF(nor, 1, 2, 0, TCG_OPF_INT)
 DEF(not, 1, 1, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
+DEF(rems, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
@@ -72,7 +73,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
@@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 77386eacb7..55663ff4c3 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -557,12 +557,14 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (uint64_t)x / ((uint64_t)y ? : 1);
 
-    case INDEX_op_rem_i32:
-        return (int32_t)x % ((int32_t)y ? : 1);
+    case INDEX_op_rems:
+        if (type == TCG_TYPE_I32) {
+            return (int32_t)x % ((int32_t)y ? : 1);
+        }
+        return (int64_t)x % ((int64_t)y ? : 1);
+
     case INDEX_op_remu_i32:
         return (uint32_t)x % ((uint32_t)y ? : 1);
-    case INDEX_op_rem_i64:
-        return (int64_t)x % ((int64_t)y ? : 1);
     case INDEX_op_remu_i64:
         return (uint64_t)x % ((uint64_t)y ? : 1);
 
@@ -3009,7 +3011,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_qemu_st_i128:
             done = fold_qemu_st(&ctx, op);
             break;
-        CASE_OP_32_64(rem):
+        case INDEX_op_rems:
         CASE_OP_32_64(remu):
             done = fold_remainder(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7ed92157de..6da8b30547 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -615,8 +615,8 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_rem_i32) {
-        tcg_gen_op3_i32(INDEX_op_rem_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rems, ret, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_divs, t0, arg1, arg2);
@@ -1983,8 +1983,8 @@ void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_rem_i64) {
-        tcg_gen_op3_i64(INDEX_op_rem_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rems, ret, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_divs, t0, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5e5082b3cd..9ec10168a8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1040,8 +1040,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_not, TCGOutOpUnary, outop_not),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
-    OUTOP(INDEX_op_rem_i32, TCGOutOpBinary, outop_rems),
-    OUTOP(INDEX_op_rem_i64, TCGOutOpBinary, outop_rems),
+    OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
@@ -5422,8 +5421,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
-    case INDEX_op_rem_i32:
-    case INDEX_op_rem_i64:
+    case INDEX_op_rems:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/tcg/tci.c b/tcg/tci.c
index 65f493c3d4..6ca033f3be 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -728,7 +728,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint64_t)regs[r1] / (uint64_t)regs[r2];
             break;
-        case INDEX_op_rem_i64:
+        case INDEX_op_rems:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int64_t)regs[r1] % (int64_t)regs[r2];
             break;
@@ -1079,9 +1079,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
+    case INDEX_op_rems:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
     case INDEX_op_shl_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 8f3b5e91b2..1f4160a585 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -287,7 +287,7 @@ Arithmetic
      - | *t0* = *t1* / *t2* (unsigned)
        | Undefined behavior if division by zero.
 
-   * - rem_i32/i64 *t0*, *t1*, *t2*
+   * - rems *t0*, *t1*, *t2*
 
      - | *t0* = *t1* % *t2* (signed)
        | Undefined behavior if division by zero or overflow.
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4d9c142a00..2b05da7d06 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -757,7 +757,7 @@ static void tgen_rems(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_rems32
-                     : INDEX_op_rem_i64);
+                     : INDEX_op_rems);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


