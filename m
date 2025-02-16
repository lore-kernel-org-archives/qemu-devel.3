Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA678C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuC-00040t-Ou; Sun, 16 Feb 2025 18:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt6-00021i-97
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:26 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt2-00060P-KF
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:22 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-221050f3f00so23670145ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747838; x=1740352638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jZqnak8gxpz6OwI6Hagc/2xEjsU0/bVVkIW/7kWJi58=;
 b=vFZFSHFuOvns66oqBdyIs4ENsPZjmX6WxlbDtxLEVDuSA/YUCanAhVopbO2W1e1XBw
 /mcVzFVOVQDKZIlfcGpph+AxOVU3dGnZUjKZ7yigNxxAbTatzYcZb5Feeiv4wMLSrW0W
 XBBMbjW4ZyD/EIbk5g6sneXa1IyuMUa+0TE0WvFC8fOaXJFfR6FqvyymoP+sA5+IZKUh
 rkCBkDMtAdk90BzughtDEM6grNSrVN3pCe49tEbKezj8xsLidccSgEYCWfAYkcm1NDEi
 sexYfLGofmUQEVJagC7t9bJ1W3l9HQKBkwyu606BGI5e4EfyTfeWtdiPRQl7+XPmQeS6
 CO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747838; x=1740352638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZqnak8gxpz6OwI6Hagc/2xEjsU0/bVVkIW/7kWJi58=;
 b=fEFp2yma4zA9YfIzq4uutW823cH2DWS/OvWxvb6xDkIxUWndcb0OiPnBBrq985Gjsf
 h7TBKCUVcdwRqceiu+xyMpuINk/KC3nz6ZBxoyao3m5Z3umNU3MbjZd+uQK0B2q68ynI
 iVq64c3VELsoDbJJG1r53EqbljZE+k6gSbH0PVJI9XdbS00beLoj54E1VWVQJt2npwy+
 2H/oWqqM9euG5+qpUacA7NvrtllggX9gW5yustflF5+CjRWO58GYwmnZXHKwXSEFEOH6
 eXAq9v3tlVKZrOM5sF7wH7g5TJhuAJhQba9mCyVaFG7VHyXpJr++uuKqyF+9iIe7uPw5
 Ox6g==
X-Gm-Message-State: AOJu0YzfcLnrcq5HgfKVokel5chbp6z3c8d4ZtcMJ5n6xOfo0zYyIBLC
 qFUcYklfqGOJo48265cZQNsBxf8jHFwHk4T291F0DKY7zxlvLBfGBKSbySM8LeLNG+sl5DTJ1FP
 z
X-Gm-Gg: ASbGncvNq2thjhSphL3yovOJ3b77Wfv36AxC8R7s9QNEPFiFAz+kVWYvZWbWSb6HovF
 iQI5pvu0dC3kDj+c3uZr+a7NTBZu/RT8xfhhqkNIwmnC1uII4F26tsKLneyqotzqu7Wn7hzF1BM
 rHApLhkvKKCr3P3mf5ghB1vLu20FnRk1B1bHWi2q6x9JQLcP9zVI0R3O1kOdbB2G0n+cqik7kbg
 xWQ2WQBN05LyWvP5J23/XAq8OtCtbGpNWo8p6OB9KVGmBQwWk2EYHuHbPBe7ndUaJcioW/CL+My
 hJTLbpOU/Mhnejze28mnDK7MIIQcHoVidXln1X/9qJOnJsY=
X-Google-Smtp-Source: AGHT+IFwBkhrxtqArAHr80wpAvoVtV8Xe06rwfEgAGrz/CkluE2sbMONfHOfLBYrKUJ7972abGx1Mg==
X-Received: by 2002:a17:902:ce0d:b0:221:85:f384 with SMTP id
 d9443c01a7336-22103f19fe7mr132112735ad.16.1739747838543; 
 Sun, 16 Feb 2025 15:17:18 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 087/162] tcg: Merge INDEX_op_bswap16_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:56 -0800
Message-ID: <20250216231012.2808572-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 include/tcg/tcg-opc.h    | 3 +--
 tcg/optimize.c           | 7 +++----
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 9 +++------
 tcg/tci.c                | 5 ++---
 docs/devel/tcg-ops.rst   | 2 +-
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 5e085607d5..acfbaa05b4 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
+DEF(bswap16, 1, 1, 1, TCG_OPF_INT)
 DEF(clz, 1, 2, 0, TCG_OPF_INT)
 DEF(ctpop, 1, 1, 0, TCG_OPF_INT)
 DEF(ctz, 1, 2, 0, TCG_OPF_INT)
@@ -95,7 +96,6 @@ DEF(sub2_i32, 2, 4, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
-DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 
 /* load/store */
@@ -122,7 +122,6 @@ DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8783447e29..75849a1495 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -506,7 +506,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
     case INDEX_op_ctpop:
         return type == TCG_TYPE_I32 ? ctpop32(x) : ctpop64(x);
 
-    CASE_OP_32_64(bswap16):
+    case INDEX_op_bswap16:
         x = bswap16(x);
         return y & TCG_BSWAP_OS ? (int16_t)x : x;
 
@@ -1560,8 +1560,7 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
 
     z_mask = t1->z_mask;
     switch (op->opc) {
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap16:
         z_mask = bswap16(z_mask);
         sign = INT16_MIN;
         break;
@@ -2858,7 +2857,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_brcond2_i32:
             done = fold_brcond2(&ctx, op);
             break;
-        CASE_OP_32_64(bswap16):
+        case INDEX_op_bswap16:
         CASE_OP_32_64(bswap32):
         case INDEX_op_bswap64_i64:
             done = fold_bswap(&ctx, op);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c5b3bc8148..917f52b04a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1257,8 +1257,8 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
 
-    if (tcg_op_supported(INDEX_op_bswap16_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3i_i32(INDEX_op_bswap16_i32, ret, arg, flags);
+    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3i_i32(INDEX_op_bswap16, ret, arg, flags);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
@@ -2087,8 +2087,8 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         } else {
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         }
-    } else if (tcg_op_supported(INDEX_op_bswap16_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3i_i64(INDEX_op_bswap16_i64, ret, arg, flags);
+    } else if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3i_i64(INDEX_op_bswap16, ret, arg, flags);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d4635d510f..26ac33edb3 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1075,8 +1075,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_brcond, TCGOutOpBrcond, outop_brcond),
-    OUTOP(INDEX_op_bswap16_i32, TCGOutOpBswap, outop_bswap16),
-    OUTOP(INDEX_op_bswap16_i64, TCGOutOpBswap, outop_bswap16),
+    OUTOP(INDEX_op_bswap16, TCGOutOpBswap, outop_bswap16),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
@@ -2941,8 +2940,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                     i = 1;
                 }
                 break;
-            case INDEX_op_bswap16_i32:
-            case INDEX_op_bswap16_i64:
+            case INDEX_op_bswap16:
             case INDEX_op_bswap32_i32:
             case INDEX_op_bswap32_i64:
             case INDEX_op_bswap64_i64:
@@ -5477,8 +5475,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap16:
         {
             const TCGOutOpBswap *out =
                 container_of(all_outop[op->opc], TCGOutOpBswap, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index ae447e91bd..905ca154fc 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -686,7 +686,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_write_reg64(regs, r1, r0, T1 - T2);
             break;
 #endif
-        CASE_32_64(bswap16)
+        case INDEX_op_bswap16:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap16(regs[r1]);
             break;
@@ -1005,14 +1005,13 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), s2);
         break;
 
+    case INDEX_op_bswap16:
     case INDEX_op_ctpop:
     case INDEX_op_mov:
     case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 26dc3bad49..509cfe7db1 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -415,7 +415,7 @@ Misc
      - | *t0* = *t1*
        | Move *t1* to *t0*.
 
-   * - bswap16_i32/i64 *t0*, *t1*, *flags*
+   * - bswap16 *t0*, *t1*, *flags*
 
      - | 16 bit byte swap on the low bits of a 32/64 bit input.
        |
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 2a8ba07e37..4d3d9569cc 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -905,7 +905,7 @@ static const TCGOutOpUnary outop_ctpop = {
 static void tgen_bswap16(TCGContext *s, TCGType type,
                          TCGReg a0, TCGReg a1, unsigned flags)
 {
-    tcg_out_op_rr(s, INDEX_op_bswap16_i32, a0, a1);
+    tcg_out_op_rr(s, INDEX_op_bswap16, a0, a1);
     if (flags & TCG_BSWAP_OS) {
         tcg_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 16);
     }
-- 
2.43.0


