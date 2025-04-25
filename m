Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5CCC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R82-0006GW-6W; Fri, 25 Apr 2025 18:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7c-000530-QY
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:14 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7Y-0001LB-Jf
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:12 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22438c356c8so33181665ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618527; x=1746223327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/SFC5JqeM55blK4o2CyGdKip3u6se4OgiK9jEGoWb8=;
 b=kBtT2bvbM+i9cuCeLTiYVMTbgaD/eaogRyPhqRArDIQ14L3Fh4jHoVmi4G9FQe5s+S
 tc1yXT0mb9sGJ27QvlMXMlW+PLs5mR2/lXefdJjwebXwsLu8GYAsu8eUuhJ0+C1A6Qkk
 rNNY5m6Tg24us9tBIcc5bLBdkR5YW42Y1L2Wll9onuBcOikV4ROxjinmJyPMujP1nHIJ
 vQQUmmcdbBFItpjNmwzLiD61edX0VbA1I88LPiNAJ7zpF4NJSHhXjMjs4jzJM8iCQbkb
 PCmpIBqErd53sZKe6gy89JlS5B8Y6kfIW4ik6HgcT0m7OzhqxzL7HBmoOafAr5dEx6/J
 NfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618527; x=1746223327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/SFC5JqeM55blK4o2CyGdKip3u6se4OgiK9jEGoWb8=;
 b=u8LAXIMkGc+gnue3tDYVhHjDDcbBMlzHUud1cSoJ0qEHZhE9NZk+cKO36YrS54AKYa
 qU6MyJrGEUJezA8TLxyAgHdOox9y4/2GCyWlmHxBU82LkopcEsr6JbHq8ZPWLcDaF/jd
 DZAfFSpaLGtoZpOt6ksssbgMqg+GVNpG6Tik4fHSoPOfXr4OFrxfi2zXrRV4T7/eDFhX
 iC5/Dy+hy09v9WmejaZwh470wzbtVRFc9Smnt4PfXSTJ7RJpsl95DY9PavvAqSpPYhkF
 jyfbRC0qz+81w652D9GPDF4ZJ0KaYtCL3S9nG2xI7Ga07tgZYt3JEFGdAbVXd90L98yc
 5Geg==
X-Gm-Message-State: AOJu0YzeWDhF85OL1ZkvzMOzJYO3+ukBBZsp/VGG1LgNN99syzyGdn3O
 XHXTTa4NJIZTLkC6EJMpwTVbQprH8bPUAUioxI3uHJz6Ass5jFKu0Fl7If2UXF0cDqkjF5dOryF
 N
X-Gm-Gg: ASbGncun/X542k1es0s0Hd3k69nsrAlRhJ4FFJbvr9sYNAUGQ8xgqSXCyWdFkwKQ9/d
 zer3Rr76hZkIGANYq2dy/fe0C/kL5GNQxVOHnGvO3ewfYpTpg+QWezPFuwDc3QrarXibz2h24C6
 aQdszUGCc3BDJn5iwpP6ta0avi04qD/2doqf538Nj9SCSek6NShDEqIrKRCM4AnZ6xgNUKqI9qO
 wGSTBFujd86yMM282Hr/XrRK7SF4FWjGOTJXVppSatBLYqPzSklqlrbLnAby9M6O5xR51VGi3+R
 eiYeDd9Q/NVF05rPBxAElU7sxftEN92xj8z6Zw1sWNQsL1mOuqeFEFSJGYpxVFLMqZ6D4G0TkU8
 =
X-Google-Smtp-Source: AGHT+IGYNMmW19gv1UsOYynLc0TocLo3BIfxVdZPIkyBP+dj+QgtIEzn8YVuQ9KHmD9k5b7ZaTUwZw==
X-Received: by 2002:a17:90b:5647:b0:305:5f32:d9f5 with SMTP id
 98e67ed59e1d1-309f7d87dbcmr6784372a91.7.1745618526863; 
 Fri, 25 Apr 2025 15:02:06 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 094/159] tcg: Merge INDEX_op_bswap32_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:48 -0700
Message-ID: <20250425215454.886111-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  4 +---
 tcg/optimize.c           |  7 +++----
 tcg/tcg-op.c             |  8 ++++----
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   | 13 ++++++-------
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index acfbaa05b4..296dffe99a 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -44,6 +44,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(bswap16, 1, 1, 1, TCG_OPF_INT)
+DEF(bswap32, 1, 1, 1, TCG_OPF_INT)
 DEF(clz, 1, 2, 0, TCG_OPF_INT)
 DEF(ctpop, 1, 1, 0, TCG_OPF_INT)
 DEF(ctz, 1, 2, 0, TCG_OPF_INT)
@@ -96,8 +97,6 @@ DEF(sub2_i32, 2, 4, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
-DEF(bswap32_i32, 1, 1, 1, 0)
-
 /* load/store */
 DEF(ld8u_i64, 1, 1, 1, 0)
 DEF(ld8s_i64, 1, 1, 1, 0)
@@ -122,7 +121,6 @@ DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 
 DEF(add2_i64, 2, 4, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1d535a9fae..6fa968624d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -522,7 +522,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         x = bswap16(x);
         return y & TCG_BSWAP_OS ? (int16_t)x : x;
 
-    CASE_OP_32_64(bswap32):
+    case INDEX_op_bswap32:
         x = bswap32(x);
         return y & TCG_BSWAP_OS ? (int32_t)x : x;
 
@@ -1576,8 +1576,7 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
         z_mask = bswap16(z_mask);
         sign = INT16_MIN;
         break;
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap32:
         z_mask = bswap32(z_mask);
         sign = INT32_MIN;
         break;
@@ -2870,7 +2869,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_brcond2(&ctx, op);
             break;
         case INDEX_op_bswap16:
-        CASE_OP_32_64(bswap32):
+        case INDEX_op_bswap32:
         case INDEX_op_bswap64_i64:
             done = fold_bswap(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 68e53a9c85..b1174f60cc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1294,8 +1294,8 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
  */
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (tcg_op_supported(INDEX_op_bswap32_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3i_i32(INDEX_op_bswap32_i32, ret, arg, 0);
+    if (tcg_op_supported(INDEX_op_bswap32, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3i_i32(INDEX_op_bswap32, ret, arg, 0);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
@@ -2137,8 +2137,8 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         } else {
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         }
-    } else if (tcg_op_supported(INDEX_op_bswap32_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3i_i64(INDEX_op_bswap32_i64, ret, arg, flags);
+    } else if (tcg_op_supported(INDEX_op_bswap32, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3i_i64(INDEX_op_bswap32, ret, arg, flags);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 89ef2ef89c..571f15626c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1076,8 +1076,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_brcond, TCGOutOpBrcond, outop_brcond),
     OUTOP(INDEX_op_bswap16, TCGOutOpBswap, outop_bswap16),
-    OUTOP(INDEX_op_bswap32_i32, TCGOutOpBswap, outop_bswap32),
-    OUTOP(INDEX_op_bswap32_i64, TCGOutOpBswap, outop_bswap32),
+    OUTOP(INDEX_op_bswap32, TCGOutOpBswap, outop_bswap32),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
@@ -2939,8 +2938,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                 }
                 break;
             case INDEX_op_bswap16:
-            case INDEX_op_bswap32_i32:
-            case INDEX_op_bswap32_i64:
+            case INDEX_op_bswap32:
             case INDEX_op_bswap64_i64:
                 {
                     TCGArg flags = op->args[k];
@@ -5486,8 +5484,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_bswap16:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap32:
         {
             const TCGOutOpBswap *out =
                 container_of(all_outop[op->opc], TCGOutOpBswap, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 0cb89f3256..f98c437100 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -690,7 +690,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap16(regs[r1]);
             break;
-        CASE_32_64(bswap32)
+        case INDEX_op_bswap32:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap32(regs[r1]);
             break;
@@ -1004,14 +1004,13 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
     case INDEX_op_ctpop:
     case INDEX_op_mov:
     case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
         tci_args_rr(insn, &r0, &r1);
         info->fprintf_func(info->stream, "%-12s  %s, %s",
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 509cfe7db1..e89ede54fa 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -425,16 +425,15 @@ Misc
        |
        | If neither ``TCG_BSWAP_OZ`` nor ``TCG_BSWAP_OS`` are set, then the bits of *t0* above bit 15 may contain any value.
 
-   * - bswap32_i64 *t0*, *t1*, *flags*
+   * - bswap32 *t0*, *t1*, *flags*
 
-     - | 32 bit byte swap on a 64-bit value.  The flags are the same as for bswap16,
-         except they apply from bit 31 instead of bit 15.
+     - | 32 bit byte swap.  The flags are the same as for bswap16, except
+         they apply from bit 31 instead of bit 15.  On TCG_TYPE_I32, the
+         flags should be zero.
 
-   * - bswap32_i32 *t0*, *t1*, *flags*
+   * - bswap64_i64 *t0*, *t1*, *flags*
 
-       bswap64_i64 *t0*, *t1*, *flags*
-
-     - | 32/64 bit byte swap. The flags are ignored, but still present
+     - | 64 bit byte swap. The flags are ignored, but still present
          for consistency with the other bswap opcodes.
 
    * - discard_i32/i64 *t0*
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 1b2f18e370..7478ada393 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -917,7 +917,7 @@ static const TCGOutOpBswap outop_bswap16 = {
 static void tgen_bswap32(TCGContext *s, TCGType type,
                          TCGReg a0, TCGReg a1, unsigned flags)
 {
-    tcg_out_op_rr(s, INDEX_op_bswap32_i32, a0, a1);
+    tcg_out_op_rr(s, INDEX_op_bswap32, a0, a1);
     if (flags & TCG_BSWAP_OS) {
         tcg_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 32);
     }
-- 
2.43.0


