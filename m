Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309BBC369C4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mH5-0002uK-4l; Tue, 15 Apr 2025 15:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m9R-0005dg-71
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:41:02 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m7z-0005wr-TI
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:34 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c081915cf3so742364085a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745956; x=1745350756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PY+uyjMWHg9Qs+bFRR6Q7Wmj3jIniEUJF/xblFMVCbw=;
 b=hsYPlN5NnhtCTWA8oSlf659FD/0ZlhQLKLIy5UfLL2zzRmC0LOQbwRth0mMNO3ilmO
 i5WBM8CcXsGMaLLdt6uhTLCwkv7nVlDnbXKgdW5fB5FMfjD29uENhF7VZurRcIHjzMvu
 nwDrdT90jJX0iv0cuS0belOtSJJfhQOIAKkWgxYIXVPXflhvi5rPaXudFSdNcIEiLFCP
 biLkIw87aNOe5FnzdJOYh3soGeFUnfgT42MYMBU8vZqXcBkccMMvxcpwKzY6ZPgsS0IG
 X2mMyX7Z5QcfBThAvlSdifS8iuhxHxgurm3QBFbYZnjDmd9Q/D4pLlbfaVViWi1Ghc5u
 dBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745956; x=1745350756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PY+uyjMWHg9Qs+bFRR6Q7Wmj3jIniEUJF/xblFMVCbw=;
 b=HCcTqNyaKKrtGtONG3kKzksdvV387xeIrdrdYa2CunE1apowZSW97IagRNz2ZdzZjH
 zu5IPTG95DrkgIoyilhcY6o5bsSNLRKaRJFJK6RSNv0fjW/1CBJ/8mBD4UVNPAscGKs6
 4cTeFqcOPX4KuU8IVs6RrwEZN6PU4ISQaDMi45YaLpcmaJpvCivKpLXks/B3RONqFNhK
 D7ATQbx1Zd5iPhe0aJ/MVUXJSs/fJ7INOedZvj8M1oj3nZ1ZORsfYXndaluddvQxvukl
 QvuC3UMndZxtnfkVh/Wb0GoL1VZ6OMFIEtIOXoFi2dQzZwwsecKQuXiWRCMnVZ38/kof
 NWdw==
X-Gm-Message-State: AOJu0Yz0W4C6WyGDiEVHZhTKoIfC5XeVsv5iKe0x5GXEZ3fMsScQGtxX
 HGxYJmad+aZxi2kcfrk2eA3os9K7zVeAbw1m1jkAODcpAn+2cxPy5Kl+Pyii49Zq6ylgo4848aU
 I
X-Gm-Gg: ASbGncuQMUj4c4redxTKZqd/u97F7FMgv53vDRU7KpgvcXMYr2nc+Q1S4bn2SUQ++vK
 qI2Ph638vvvxGwM4Hh6QP37kh60SLPAlTYG0MPpclm3yazhEctMYcI1DviUadlQ7Nf3kEhLd2rI
 QtpYZw+ir6ymc3u0s5u2mWgj1errqbNY1XjqqJ9PusEybQlzh2myoHBOoXr/q9chAkUMiMH4TX9
 nt3a8a+8hvyxTfu/nrHr/7kEhaukj4YhzNlbJzB0PCdluBa+UUuQmMnlqIUtuDdtEhwZ0yNfmNq
 tdCTWqVSu3dPI1ZrBzmXK7zn2MGpbbFDF38V4w+ErgCCThsIZy4WjuCQiBfo7rZnG7fd449jQ9h
 mdUnNuB68TA==
X-Google-Smtp-Source: AGHT+IFnPkzeUOb2wjDQnBoOryjUgi+Z3HaH8sNJq9rFn8ozinX9tecHtvTJUxb0c9NaphBG+QzX9A==
X-Received: by 2002:a17:902:f78c:b0:216:2bd7:1c4a with SMTP id
 d9443c01a7336-22c319f63c4mr6465455ad.26.1744745552866; 
 Tue, 15 Apr 2025 12:32:32 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 090/163] tcg: Merge INDEX_op_bswap32_{i32,i64}
Date: Tue, 15 Apr 2025 12:24:01 -0700
Message-ID: <20250415192515.232910-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
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
index 75849a1495..be9d09467d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -510,7 +510,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         x = bswap16(x);
         return y & TCG_BSWAP_OS ? (int16_t)x : x;
 
-    CASE_OP_32_64(bswap32):
+    case INDEX_op_bswap32:
         x = bswap32(x);
         return y & TCG_BSWAP_OS ? (int32_t)x : x;
 
@@ -1564,8 +1564,7 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
         z_mask = bswap16(z_mask);
         sign = INT16_MIN;
         break;
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap32:
         z_mask = bswap32(z_mask);
         sign = INT32_MIN;
         break;
@@ -2858,7 +2857,7 @@ void tcg_optimize(TCGContext *s)
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
index 117021f610..51f9cc7fe1 100644
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
@@ -5483,8 +5481,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


