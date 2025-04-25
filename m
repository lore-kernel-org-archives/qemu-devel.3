Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88634C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R9n-0000sk-Ck; Fri, 25 Apr 2025 18:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7m-0005Ts-BM
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:22 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7h-0001NV-V9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:21 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3014678689aso2455321a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618536; x=1746223336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9A9UQW6ksvEnp1QJ4zvAXyeSLWJkKQ9TlEaStC1qvE0=;
 b=qqKEQJaAbfyQqe+eZxKC8FudZ2PJbRmkkJu5FxSpcXh0dTMkCEr7UxFd/B6q0/fwZP
 WW2djBK2C1nOYoDzD5wy3sdf64Kf2ZWFxQRK6hjR1a6mWgElzmvkLlMvVliv60Go1mGa
 3S+Lc7jQbZ5wn0uz10ep+aG1ueTr6jfhvop6JhOqBgpMwY5C35chXCsRGj4Rjv+wdK12
 br7xgziq7Feiwpss/gHvgUmsJk0LzlOziJQkPtgqUhfQ0Z8knKN9y6DSnrtUBxVsoy/s
 1GBigbmvybe6wYhjafqEZh+0ylNiN+yy/rqca7yjwZ3V6SOg47rdbr8o9RCeqkXr2oRu
 HEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618536; x=1746223336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9A9UQW6ksvEnp1QJ4zvAXyeSLWJkKQ9TlEaStC1qvE0=;
 b=EL/64Ddi4NaC3KeuNjmvy+YExvIaRX8IUQFKwDCmpzGZv7fvmD7J1kWe593ICkYwwe
 2kb19CEF3QuPrQ9ib3fDHUB4txV7aIU7NE6QbejSwYYpcfqvkKF8XYQ89HyqrQX0N7E4
 1iqLlelwNG8di7MkGEWvVOKLCI4WA1v7JYzG5sB8u0mdYyPi3XDixzlQfztfvy8UBwZ9
 QuRIQsR8Tho8AOqbCg9/xi1jLL6mHKFpUIrxvxFKd20tLpAbT4xRZB2Y7L8WuizO6Ma4
 ltgWS+AycKP1DTRXcd95kAIELthKvtkCC35NZ4f1/zHkpA2pE5OvsK5NdkGwjoRwWBOl
 ej+g==
X-Gm-Message-State: AOJu0Yx2ywa+R6xOy6PAJDdXQ+r1yvl8M0/PJCJ4HD+9bXvrkw5SJOnN
 jx2vYzC0EE8QfXcfF/zeIM/MA8V2dhGO6TXw3WLQGHthbPBPglX01Yn4yX2jR6E/dkkLVaj68QV
 A
X-Gm-Gg: ASbGncvGjAk+Qmji/qmThXGbxrEFDY1YMJWpA3ckddqKaqq6oaW1SKOjgrBPpDq8MU+
 RdHoM2cVQqKZzC5uAGvRoZiPza20kMdTz+WI626m+KTFAN5yNAEjBm7NcXIj/8xBoVCN9r3OBKI
 q1kaV9cfJvBbKOGyGwJchyPOK9KKBDM+Acq92NvEqbvYaYlijT+5kxE3ImhOA3eBIKtzIkgFW+q
 +NnlQxxXtK0mCJVqRIErRKiFbSP6TvPOIQ5YsofOplC72FJ2RMZJ1DDSlUT8DrOhY0FLP0q/wrB
 r9ZvrnhHXtH2ermJzy15PT36bWR88i4FXvBBrREHWmZp1Nq3DCeWmAnuLWuU7/VPSG3fx/lNPx+
 m6wOIEn7aAw==
X-Google-Smtp-Source: AGHT+IGzzChX222TMYgVzH/wGgTKXrOkuuwXR3BczacyalJ3i94Jg68GYwpETiVBqE5sWKVD0n9Xgw==
X-Received: by 2002:a17:90b:4b4e:b0:301:1d03:93cd with SMTP id
 98e67ed59e1d1-30a013988efmr1662367a91.24.1745618535958; 
 Fri, 25 Apr 2025 15:02:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 107/159] tcg: Merge INDEX_op_deposit_{i32,i64}
Date: Fri, 25 Apr 2025 14:54:01 -0700
Message-ID: <20250425215454.886111-108-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
 tcg/optimize.c           | 2 +-
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 9 +++------
 tcg/tci.c                | 6 ++----
 docs/devel/tcg-ops.rst   | 6 ++++--
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 4ace1f85c4..c6848b3c63 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -49,6 +49,7 @@ DEF(bswap64, 1, 1, 1, TCG_OPF_INT)
 DEF(clz, 1, 2, 0, TCG_OPF_INT)
 DEF(ctpop, 1, 1, 0, TCG_OPF_INT)
 DEF(ctz, 1, 2, 0, TCG_OPF_INT)
+DEF(deposit, 1, 2, 2, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
 DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
@@ -90,7 +91,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(deposit_i32, 1, 2, 2, 0)
 DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(add2_i32, 2, 4, 0, 0)
@@ -111,7 +111,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(deposit_i64, 1, 2, 2, 0)
 DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index d324cbf7fe..acc566ed76 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2858,7 +2858,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_ctpop:
             done = fold_ctpop(&ctx, op);
             break;
-        CASE_OP_32_64(deposit):
+        case INDEX_op_deposit:
             done = fold_deposit(&ctx, op);
             break;
         case INDEX_op_divs:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b88f411ece..961a39f446 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -915,7 +915,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
         return;
     }
     if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, arg1, arg2, ofs, len);
+        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
         return;
     }
 
@@ -961,7 +961,7 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
     } else if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
         TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
+        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, zero, arg, ofs, len);
     } else {
         /*
          * To help two-operand hosts we prefer to zero-extend first,
@@ -2533,7 +2533,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 
     if (TCG_TARGET_REG_BITS == 64) {
         if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
-            tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, arg1, arg2, ofs, len);
+            tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
             return;
         }
     } else {
@@ -2594,7 +2594,7 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     } else if (TCG_TARGET_REG_BITS == 64 &&
                TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
         TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, zero, arg, ofs, len);
+        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
     } else {
         if (TCG_TARGET_REG_BITS == 32) {
             if (ofs >= 32) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b9e9454654..6b49fd4acf 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1133,8 +1133,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
-    OUTOP(INDEX_op_deposit_i32, TCGOutOpDeposit, outop_deposit),
-    OUTOP(INDEX_op_deposit_i64, TCGOutOpDeposit, outop_deposit),
+    OUTOP(INDEX_op_deposit, TCGOutOpDeposit, outop_deposit),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
@@ -2379,6 +2378,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_brcond:
+    case INDEX_op_deposit:
     case INDEX_op_extract:
     case INDEX_op_mov:
     case INDEX_op_movcond:
@@ -2397,7 +2397,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_deposit_i32:
         return true;
 
     case INDEX_op_extract2_i32:
@@ -2426,7 +2425,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
-    case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
     case INDEX_op_extract2_i64:
@@ -5549,8 +5547,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
         {
             const TCGOutOpDeposit *out = &outop_deposit;
 
diff --git a/tcg/tci.c b/tcg/tci.c
index 595416a192..dc916eb112 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -655,8 +655,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ror32(regs[r1], regs[r2] & 31);
             break;
-        case INDEX_op_deposit_i32:
-        case INDEX_op_deposit_i64:
+        case INDEX_op_deposit:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit_tr(regs[r1], pos, len, regs[r2]);
             break;
@@ -1042,8 +1041,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), str_r(r2));
         break;
 
-    case INDEX_op_deposit_i32:
-    case INDEX_op_deposit_i64:
+    case INDEX_op_deposit:
         tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %d, %d",
                            op_name, str_r(r0), str_r(r1), str_r(r2), pos, len);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index ca7550f68c..aea8a897bd 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -442,7 +442,7 @@ Misc
      - | Indicate that the value of *t0* won't be used later. It is useful to
          force dead code elimination.
 
-   * - deposit_i32/i64 *dest*, *t1*, *t2*, *pos*, *len*
+   * - deposit *dest*, *t1*, *t2*, *pos*, *len*
 
      - | Deposit *t2* as a bitfield into *t1*, placing the result in *dest*.
        |
@@ -451,10 +451,12 @@ Misc
        |     *len* - the length of the bitfield
        |     *pos* - the position of the first bit, counting from the LSB
        |
-       | For example, "deposit_i32 dest, t1, t2, 8, 4" indicates a 4-bit field
+       | For example, "deposit dest, t1, t2, 8, 4" indicates a 4-bit field
          at bit 8. This operation would be equivalent to
        |
        |     *dest* = (*t1* & ~0x0f00) | ((*t2* << 8) & 0x0f00)
+       |
+       | on TCG_TYPE_I32.
 
    * - extract *dest*, *t1*, *pos*, *len*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 566c2fb0d0..ef14e81609 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -622,7 +622,7 @@ static const TCGOutOpBinary outop_ctz = {
 static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          TCGReg a2, unsigned ofs, unsigned len)
 {
-    tcg_out_op_rrrbb(s, INDEX_op_deposit_i64, a0, a1, a2, ofs, len);
+    tcg_out_op_rrrbb(s, INDEX_op_deposit, a0, a1, a2, ofs, len);
 }
 
 static const TCGOutOpDeposit outop_deposit = {
-- 
2.43.0


