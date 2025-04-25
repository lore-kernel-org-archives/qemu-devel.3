Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A44EC369D8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R9G-0007T7-Q3; Fri, 25 Apr 2025 18:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7f-00056B-D4
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7Z-0001LG-Bj
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22401f4d35aso35465275ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618528; x=1746223328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTU6et99/dqXtC8W4lIBaWpsuZbBzde4v5RAzlwoL2A=;
 b=xYMdGoqAWDOOYmcoPDMrbzliCnM8RBXueBNR8Yiqv4Q12hWiXYo3bbbw+3e0MVJZ4q
 Yw9AFTXcRMEKg/BBfn+EnjXoFnVBiJFsOyJdYhYVKqXAj/Z/uPl63GhGGKLHUo5/+mg1
 AsPHtWpI0l3oDx42ygT+CVx69k+tbchwU2Je/TztxItB5QswmAAjwTSrASbX4m+FSAXb
 7WPTeMceYvKmdVjx5DaDEcD0sPjpy76DHaK54MkKxDJw80SeIEKz9Gzkinjr3Imtgy9s
 HpbgFmiPRVOUBeYiqkoYOazYujNaJhbkc+kxf3DdkhuCJD/VCTboAT7tDnpPmHr7UdzE
 J7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618528; x=1746223328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTU6et99/dqXtC8W4lIBaWpsuZbBzde4v5RAzlwoL2A=;
 b=jOmmdb4wlfIQdAPvNlAX+n2t3ZGwdRhtG2Qih/LEgIQ/OyCTl20fUjm1P/JxxEB8fP
 bdomSbJVB9hmKUxKik54EN36SQVezimUfAr2LzUPU6dmr1Yi4OQV/O4aF78CNEMMlV5z
 V4odiaZ6ut9Xmjv01YD5UON3/xR+p4IcBM7y8990GCQDqPwqg3C1Ee1VspJd0Bt/rG80
 n0Br7MrZ/lbt58qjgaHO57vNnVtseFwd703BSCsvaI//7Ww67dsZPdf4TJrfhh9iUfWR
 nBvg5FU72vyHyf0NvhmPuvMlM4elSeZqciW1+xzKgSFxROfYeXcIyLVL4z5wf0TDDV3M
 6ueg==
X-Gm-Message-State: AOJu0YzL6O3c9uANkAGdfSqYeh9P9L54dmZRpw2cpD9WASHuS87fUIKH
 g24Bs2GSkIVMEIjv+3rN1gcAJIuT2aXn90CD/AHiGUsN3hUIHXpAhCtrTvRUqHHf7P4vXQXDMiO
 a
X-Gm-Gg: ASbGnctYArtLmJql4taNewlkb8RDQ8Cms0VloZ9cXldrZpIauHj9ccyqc8U8w/Rtyqz
 ffBbDBZ2wiY0LspQHq0ax/gjElPFmJ5pIxlKSqH/DsOBdKA62X5ITjyOux3jNbmGqYhJO1itlZl
 /nJtfPlmp9e70GmjX1BnmvaeLxJ188ed0/OhOu69Kih5bT6hs6GWfVhVh0EDYg+uTZg/C15mmxe
 rxSS7BtOvu78Tnv+Lu5r0LCzJS8PZ76msb5R/rn6S4d76lEpmbrfbi5tITxn1hfqOhKPC1lOSvt
 8ZGPYCWxASOhIiv3HresHz3skduJrDxcXXmHLNp/1giCNemIZMaeSC9XwyeqkmyEzAYkPg9ai8o
 =
X-Google-Smtp-Source: AGHT+IF4mtuSKeefJM922X9x4gSSj1+q50lZS1SMKaWOmnDW/K35JnnPG/0F26allYUirs6vu2mFiw==
X-Received: by 2002:a17:90b:264b:b0:2ff:58e1:2bc9 with SMTP id
 98e67ed59e1d1-309f7e679aamr5927286a91.25.1745618527521; 
 Fri, 25 Apr 2025 15:02:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 095/159] tcg: Convert bswap64 to TCGOutOpUnary
Date: Fri, 25 Apr 2025 14:53:49 -0700
Message-ID: <20250425215454.886111-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Use TCGOutOpUnary instead of TCGOutOpBswap because the
flags are not used with this opcode; they are merely
present for uniformity with the smaller bswaps.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h     |  1 -
 tcg/i386/tcg-target-has.h        |  1 -
 tcg/loongarch64/tcg-target-has.h |  1 -
 tcg/mips/tcg-target-has.h        |  1 -
 tcg/ppc/tcg-target-has.h         |  1 -
 tcg/riscv/tcg-target-has.h       |  1 -
 tcg/s390x/tcg-target-has.h       |  1 -
 tcg/sparc64/tcg-target-has.h     |  1 -
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  1 -
 tcg/tcg-op.c                     |  2 +-
 tcg/tcg.c                        |  7 ++-
 tcg/tci.c                        |  2 -
 tcg/aarch64/tcg-target.c.inc     | 15 ++++--
 tcg/arm/tcg-target.c.inc         |  4 ++
 tcg/i386/tcg-target.c.inc        | 16 ++++--
 tcg/loongarch64/tcg-target.c.inc | 15 ++++--
 tcg/mips/tcg-target.c.inc        | 37 ++++++++------
 tcg/ppc/tcg-target.c.inc         | 88 ++++++++++++++++----------------
 tcg/riscv/tcg-target.c.inc       | 16 ++++--
 tcg/s390x/tcg-target.c.inc       | 15 ++++--
 tcg/sparc64/tcg-target.c.inc     |  4 ++
 tcg/tci/tcg-target.c.inc         | 17 ++++--
 23 files changed, 144 insertions(+), 104 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 7c3d3fc637..82d8cd5965 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -19,7 +19,6 @@
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index ca533ab5cf..6b91b23fe8 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -33,7 +33,6 @@
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index e66df31954..10090102f7 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -18,7 +18,6 @@
 /* 64-bit operations */
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 2391f5d8bf..24b00f1eec 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -55,7 +55,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #endif
 
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index ad0885d635..bd9c3d92ed 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -24,7 +24,6 @@
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index fbe294474a..88fadc2428 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -17,7 +17,6 @@
 
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 76cfe4f323..95407f61cf 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -35,7 +35,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
-#define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_add2_i64       1
 #define TCG_TARGET_HAS_sub2_i64       1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 22837beca9..2ced6f7c1c 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -20,7 +20,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 4034c73cca..21bef070fe 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -12,7 +12,6 @@
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index c5c64f4f5d..90aa5c8bbb 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -12,7 +12,6 @@
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b1174f60cc..27e700161f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2184,7 +2184,7 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
         tcg_gen_mov_i32(TCGV_HIGH(ret), t0);
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
-    } else if (TCG_TARGET_HAS_bswap64_i64) {
+    } else if (tcg_op_supported(INDEX_op_bswap64_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3i_i64(INDEX_op_bswap64_i64, ret, arg, 0);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 571f15626c..f2f2c0dd74 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1112,6 +1112,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
 #if TCG_TARGET_REG_BITS == 32
     OUTOP(INDEX_op_brcond2_i32, TCGOutOpBrcond2, outop_brcond2),
     OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
+#else
+    OUTOP(INDEX_op_bswap64_i64, TCGOutOpUnary, outop_bswap64),
 #endif
 };
 
@@ -2371,8 +2373,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return TCG_TARGET_HAS_extr_i64_i32;
-    case INDEX_op_bswap64_i64:
-        return TCG_TARGET_HAS_bswap64_i64;
     case INDEX_op_add2_i64:
         return TCG_TARGET_HAS_add2_i64;
     case INDEX_op_sub2_i64:
@@ -5470,6 +5470,9 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_bswap64_i64:
+        assert(TCG_TARGET_REG_BITS == 64);
+        /* fall through */
     case INDEX_op_ctpop:
     case INDEX_op_neg:
     case INDEX_op_not:
diff --git a/tcg/tci.c b/tcg/tci.c
index f98c437100..903f996f02 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -788,12 +788,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (uint32_t)regs[r1];
             break;
-#if TCG_TARGET_HAS_bswap64_i64
         case INDEX_op_bswap64_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap64(regs[r1]);
             break;
-#endif
 #endif /* TCG_TARGET_REG_BITS == 64 */
 
             /* QEMU specific operations. */
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index a2e45ca5c8..79c0e2e097 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2470,6 +2470,16 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
+static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_rev(s, TCG_TYPE_I64, MO_64, a0, a1);
+}
+
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap64,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_XZR, a1);
@@ -2637,10 +2647,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
         break;
 
-    case INDEX_op_bswap64_i64:
-        tcg_out_rev(s, TCG_TYPE_I64, MO_64, a0, a1);
-        break;
-
     case INDEX_op_deposit_i64:
     case INDEX_op_deposit_i32:
         tcg_out_dep(s, ext, a0, a2, args[3], args[4]);
@@ -3159,7 +3165,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_bswap64_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 4ca23bb718..3bbc28c63c 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2163,6 +2163,10 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_subfi(s, type, a0, 0, a1);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 6d90666ba7..347e01c076 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3104,6 +3104,18 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_bswap64(s, a0);
+}
+
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_O1_I1(r, 0),
+    .out_rr = tgen_bswap64,
+};
+#endif
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
@@ -3279,9 +3291,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_bswap64_i64:
-        tcg_out_bswap64(s, a0);
-        break;
     case INDEX_op_extrh_i64_i32:
         tcg_out_shifti(s, SHIFT_SHR + P_REXW, a0, 32);
         break;
@@ -3979,7 +3988,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_bswap64_i64:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index d4bcb06a5f..f3b2f709d2 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1769,6 +1769,16 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
+static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_opc_revb_d(s, a0, a1);
+}
+
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap64,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
@@ -1860,10 +1870,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_bstrins_d(s, a0, a2, args[3], args[3] + args[4] - 1);
         break;
 
-    case INDEX_op_bswap64_i64:
-        tcg_out_opc_revb_d(s, a0, a1);
-        break;
-
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
         tcg_out_ldst(s, OPC_LD_B, a0, a1, a2);
@@ -2459,7 +2465,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
-    case INDEX_op_bswap64_i64:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld8u_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ab8f8c9994..baaf0e416b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -710,19 +710,6 @@ static void tcg_out_bswap_subr(TCGContext *s, const tcg_insn_unit *sub)
     }
 }
 
-static void tcg_out_bswap64(TCGContext *s, TCGReg ret, TCGReg arg)
-{
-    if (use_mips32r2_instructions) {
-        tcg_out_opc_reg(s, OPC_DSBH, ret, 0, arg);
-        tcg_out_opc_reg(s, OPC_DSHD, ret, 0, ret);
-    } else {
-        tcg_out_bswap_subr(s, bswap64_addr);
-        /* delay slot -- never omit the insn, like tcg_out_mov might.  */
-        tcg_out_opc_reg(s, OPC_OR, TCG_TMP0, arg, TCG_REG_ZERO);
-        tcg_out_mov(s, TCG_TYPE_I32, ret, TCG_TMP3);
-    }
-}
-
 static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
@@ -2176,6 +2163,26 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    if (use_mips32r2_instructions) {
+        tcg_out_opc_reg(s, OPC_DSBH, ret, 0, arg);
+        tcg_out_opc_reg(s, OPC_DSHD, ret, 0, ret);
+    } else {
+        tcg_out_bswap_subr(s, bswap64_addr);
+        /* delay slot -- never omit the insn, like tcg_out_mov might.  */
+        tcg_out_opc_reg(s, OPC_OR, TCG_TMP0, arg, TCG_REG_ZERO);
+        tcg_out_mov(s, TCG_TYPE_I32, ret, TCG_TMP3);
+    }
+}
+
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap64,
+};
+#endif /* TCG_TARGET_REG_BITS == 64 */
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
@@ -2267,9 +2274,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_bswap64_i64:
-        tcg_out_bswap64(s, a0, a1);
-        break;
     case INDEX_op_extrh_i64_i32:
         tcg_out_dsra(s, a0, a1, 32);
         break;
@@ -2380,7 +2384,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_bswap64_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 4527ed3eee..083137d211 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1012,44 +1012,6 @@ static void tcg_out_addpcis(TCGContext *s, TCGReg dst, intptr_t imm)
     tcg_out32(s, ADDPCIS | RT(dst) | (d1 << 16) | (d0 << 6) | d2);
 }
 
-static void tcg_out_bswap64(TCGContext *s, TCGReg dst, TCGReg src)
-{
-    TCGReg t0 = dst == src ? TCG_REG_R0 : dst;
-    TCGReg t1 = dst == src ? dst : TCG_REG_R0;
-
-    if (have_isa_3_10) {
-        tcg_out32(s, BRD | RA(dst) | RS(src));
-        return;
-    }
-
-    /*
-     * In the following,
-     *   dep(a, b, m) -> (a & ~m) | (b & m)
-     *
-     * Begin with:                              src = abcdefgh
-     */
-    /* t0 = rol32(src, 8) & 0xffffffff              = 0000fghe */
-    tcg_out_rlw(s, RLWINM, t0, src, 8, 0, 31);
-    /* t0 = dep(t0, rol32(src, 24), 0xff000000)     = 0000hghe */
-    tcg_out_rlw(s, RLWIMI, t0, src, 24, 0, 7);
-    /* t0 = dep(t0, rol32(src, 24), 0x0000ff00)     = 0000hgfe */
-    tcg_out_rlw(s, RLWIMI, t0, src, 24, 16, 23);
-
-    /* t0 = rol64(t0, 32)                           = hgfe0000 */
-    tcg_out_rld(s, RLDICL, t0, t0, 32, 0);
-    /* t1 = rol64(src, 32)                          = efghabcd */
-    tcg_out_rld(s, RLDICL, t1, src, 32, 0);
-
-    /* t0 = dep(t0, rol32(t1, 24), 0xffffffff)      = hgfebcda */
-    tcg_out_rlw(s, RLWIMI, t0, t1, 8, 0, 31);
-    /* t0 = dep(t0, rol32(t1, 24), 0xff000000)      = hgfedcda */
-    tcg_out_rlw(s, RLWIMI, t0, t1, 24, 0, 7);
-    /* t0 = dep(t0, rol32(t1, 24), 0x0000ff00)      = hgfedcba */
-    tcg_out_rlw(s, RLWIMI, t0, t1, 24, 16, 23);
-
-    tcg_out_mov(s, TCG_TYPE_REG, dst, t0);
-}
-
 /* Emit a move into ret of arg, if it can be done in one insn.  */
 static bool tcg_out_movi_one(TCGContext *s, TCGReg ret, tcg_target_long arg)
 {
@@ -3390,6 +3352,51 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
+{
+    TCGReg t0 = dst == src ? TCG_REG_R0 : dst;
+    TCGReg t1 = dst == src ? dst : TCG_REG_R0;
+
+    if (have_isa_3_10) {
+        tcg_out32(s, BRD | RA(dst) | RS(src));
+        return;
+    }
+
+    /*
+     * In the following,
+     *   dep(a, b, m) -> (a & ~m) | (b & m)
+     *
+     * Begin with:                              src = abcdefgh
+     */
+    /* t0 = rol32(src, 8) & 0xffffffff              = 0000fghe */
+    tcg_out_rlw(s, RLWINM, t0, src, 8, 0, 31);
+    /* t0 = dep(t0, rol32(src, 24), 0xff000000)     = 0000hghe */
+    tcg_out_rlw(s, RLWIMI, t0, src, 24, 0, 7);
+    /* t0 = dep(t0, rol32(src, 24), 0x0000ff00)     = 0000hgfe */
+    tcg_out_rlw(s, RLWIMI, t0, src, 24, 16, 23);
+
+    /* t0 = rol64(t0, 32)                           = hgfe0000 */
+    tcg_out_rld(s, RLDICL, t0, t0, 32, 0);
+    /* t1 = rol64(src, 32)                          = efghabcd */
+    tcg_out_rld(s, RLDICL, t1, src, 32, 0);
+
+    /* t0 = dep(t0, rol32(t1, 24), 0xffffffff)      = hgfebcda */
+    tcg_out_rlw(s, RLWIMI, t0, t1, 8, 0, 31);
+    /* t0 = dep(t0, rol32(t1, 24), 0xff000000)      = hgfedcda */
+    tcg_out_rlw(s, RLWIMI, t0, t1, 24, 0, 7);
+    /* t0 = dep(t0, rol32(t1, 24), 0x0000ff00)      = hgfedcba */
+    tcg_out_rlw(s, RLWIMI, t0, t1, 24, 16, 23);
+
+    tcg_out_mov(s, TCG_TYPE_REG, dst, t0);
+}
+
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap64,
+};
+#endif /* TCG_TARGET_REG_BITS == 64 */
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out32(s, NEG | RT(a0) | RA(a1));
@@ -3512,10 +3519,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_bswap64_i64:
-        tcg_out_bswap64(s, args[0], args[1]);
-        break;
-
     case INDEX_op_deposit_i32:
         if (const_args[2]) {
             uint32_t mask = ((2u << (args[4] - 1)) - 1) << args[3];
@@ -4263,7 +4266,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap64_i64:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 9b6ca54ae7..00b097d171 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2441,6 +2441,17 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
+static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
+}
+
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_bswap,
+    .out_rr = tgen_bswap64,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
@@ -2523,10 +2534,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_bswap64_i64:
-        tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
-        break;
-
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
                         const_args[4], const_args[5], false, true);
@@ -2864,7 +2871,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
-    case INDEX_op_bswap64_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index ed2da3f31d..2ed288cfe0 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2776,6 +2776,16 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
+static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_insn(s, RRE, LRVGR, a0, a1);
+}
+
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap64,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     if (type == TCG_TYPE_I32) {
@@ -2922,10 +2932,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_bswap64_i64:
-        tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
-        break;
-
     case INDEX_op_add2_i64:
         if (const_args[4]) {
             if ((int64_t)args[4] >= 0) {
@@ -3462,7 +3468,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_bswap64_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index cbe9c759ec..96ffba9af6 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1733,6 +1733,10 @@ static const TCGOutOpBswap outop_bswap32 = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
      tgen_sub(s, type, a0, TCG_REG_G0, a1);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 7478ada393..cbfe92adf3 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -57,7 +57,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap64_i64:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
@@ -928,6 +927,18 @@ static const TCGOutOpBswap outop_bswap32 = {
     .out_rr = tgen_bswap32,
 };
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, INDEX_op_bswap64_i64, a0, a1);
+}
+
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap64,
+};
+#endif
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
@@ -1072,10 +1083,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rrbb(s, opc, args[0], args[1], args[2], args[3]);
         break;
 
-    case INDEX_op_bswap64_i64: /* Optional (TCG_TARGET_HAS_bswap64_i64). */
-        tcg_out_op_rr(s, opc, args[0], args[1]);
-        break;
-
     CASE_32_64(add2)
     CASE_32_64(sub2)
         tcg_out_op_rrrrrr(s, opc, args[0], args[1], args[2],
-- 
2.43.0


