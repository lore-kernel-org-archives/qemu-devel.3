Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2DBC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m1k-0003IV-8q; Tue, 15 Apr 2025 15:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzF-0008Co-MB
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:26 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly8-0000j6-Ei
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:24 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso6528a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745334; x=1745350134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CJNnqregflCERX0Tv4dkFZXdsjoUvA+C+rZmS/KC6/o=;
 b=zZxbTWpvTHI5ZNixtJBLVx8sP8PLsy/0Ki4syMZL30XxQwqOIeBzADN8YFM1n/TXum
 PJ567f/1XbN21bOSbb1pdMhPy2VkbbHUEUmHvQSOlT+B/x8bZst79wPovuhtnRFcvgfg
 peJSbKGeFSMg2ytgECyjMkL7RGx59HQaZMUEbb/l9GhuvqJ72GoZzJw9xtOqfeboqG5X
 QRdijkTpEiShhrV83ITBc3fKjgImIDXoXtAozk+snWy8yUB3M86+82IH1+hRMP5pMVUg
 qw7NGijmmLuryJwoek9UUyLj+JLRVBbNw2BCem5eUxJoLX/MdNgB4cnsHzJ6yycLFfp7
 plYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745334; x=1745350134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJNnqregflCERX0Tv4dkFZXdsjoUvA+C+rZmS/KC6/o=;
 b=PBQwPKgO+BjgA0bna23mJVsFuFwQrtyzEKUK/IfKrHkZZo7NMiV9BDgjiR4RjQ1ppa
 AvOf/9TIPKVgDpW2xIECOkwKwQzLEeJZWzNsBOSFyG19/zkxRtgyaN668LgWAMupyMTR
 GUvysC6HkG09DWQ3o5/61sMbnttt699MPzcUXDaZko68KbmWZ0/BQ5zJzDTDG8wfkdth
 1fGUiF0xAOx7KH5EsGZz9tDoq5ipNozzhdLyhLnTgOTRqskcUaYJwkakUL6XL5kbmt0q
 SSS1MvDfUJJWWXyV7Ew8V9DWGJy7qXXVfC1QIbdxK3lehhvP2CoLuzuAw5A6J3lYMqXZ
 u7Kw==
X-Gm-Message-State: AOJu0Ywsm9gqWoT2Z4tfFv2Y+msTP4SzjEvmCNaEpg88qEoN2opjZytT
 rToEneq3CH4uI8QjyhIzyjSVtZ5s2U6DnZe8AAo1SP0nHYraMHEJ9TAZSOS28BJASZE9IXonIIj
 6
X-Gm-Gg: ASbGncuyuhRvdcSo6spTIzH+h4LZGbN41qjHG6Svu66h6xv21eNcE3NSLgMAhAxDaUV
 FfTKOB/LB+BegnSwkQ3Nx0yoA6XCOMLF3WcKQssV0pJ192tZWnHfQtAr54wlYAcfdtJX6H4KDkj
 8+Si7BYlJvTxV5CvLbRORoCYf1uHTqjLaVVjy7IXxSKV4uFlS45KZEvqtLpiDD/vvmV2kMoGtso
 xbf31HhhUkWosl3Vr/5YECxbgDJDpl0ow64+nk12p9iMpMtr171PZN5Qt7etozWxLiZs8BmTmSt
 kq5xq0lzdF2vI1R4TO6DfiS0cMcta9O149RvKP3wNImGUBocHrRsMP1N+UCzAGHxoRp8osC9cXo
 =
X-Google-Smtp-Source: AGHT+IGWoaZiAqjVjTSzm1NfOsxhOsBjhqY/eVepBKll4M4NQ2NrD3RD/05v8yPANrzwwolGUjsSKA==
X-Received: by 2002:a17:90b:2c83:b0:2fa:1e56:5d82 with SMTP id
 98e67ed59e1d1-3085dfed981mr1021711a91.17.1744745334081; 
 Tue, 15 Apr 2025 12:28:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.28.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:28:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 042/163] tcg: Merge INDEX_op_div_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:13 -0700
Message-ID: <20250415192515.232910-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Rename to INDEX_op_divs to emphasize signed inputs,
and mirroring INDEX_op_divu_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 12 +++++++-----
 tcg/tcg-op.c             | 16 ++++++++--------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index a9d7938a52..6d4edd0b16 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -42,6 +42,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
+DEF(divs, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
@@ -68,7 +69,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(div_i32, 1, 2, 0, 0)
 DEF(divu_i32, 1, 2, 0, 0)
 DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
@@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(div_i64, 1, 2, 0, 0)
 DEF(divu_i64, 1, 2, 0, 0)
 DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index f8d9a4d90e..127d0f9390 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -544,13 +544,15 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         muls64(&l64, &h64, x, y);
         return h64;
 
-    case INDEX_op_div_i32:
+    case INDEX_op_divs:
         /* Avoid crashing on divide by zero, otherwise undefined.  */
-        return (int32_t)x / ((int32_t)y ? : 1);
+        if (type == TCG_TYPE_I32) {
+            return (int32_t)x / ((int32_t)y ? : 1);
+        }
+        return (int64_t)x / ((int64_t)y ? : 1);
+
     case INDEX_op_divu_i32:
         return (uint32_t)x / ((uint32_t)y ? : 1);
-    case INDEX_op_div_i64:
-        return (int64_t)x / ((int64_t)y ? : 1);
     case INDEX_op_divu_i64:
         return (uint64_t)x / ((uint64_t)y ? : 1);
 
@@ -2893,7 +2895,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(deposit):
             done = fold_deposit(&ctx, op);
             break;
-        CASE_OP_32_64(div):
+        case INDEX_op_divs:
         CASE_OP_32_64(divu):
             done = fold_divide(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 69e50f968f..9dba520d40 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -601,8 +601,8 @@ void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_div_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_div_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_divs, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i32) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t0, arg1, 31);
@@ -617,9 +617,9 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rem_i32) {
         tcg_gen_op3_i32(INDEX_op_rem_i32, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_div_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_div_i32, t0, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_divs, t0, arg1, arg2);
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
@@ -1969,8 +1969,8 @@ void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_div_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_div_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_divs, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i64) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_sari_i64(t0, arg1, 63);
@@ -1985,9 +1985,9 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_rem_i64) {
         tcg_gen_op3_i64(INDEX_op_rem_i64, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_div_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_div_i64, t0, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_divs, t0, arg1, arg2);
         tcg_gen_mul_i64(t0, t0, arg2);
         tcg_gen_sub_i64(ret, arg1, t0);
         tcg_temp_free_i64(t0);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 52a8842cd3..0edac806e7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1020,8 +1020,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_div_i32, TCGOutOpBinary, outop_divs),
-    OUTOP(INDEX_op_div_i64, TCGOutOpBinary, outop_divs),
+    OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -5414,8 +5413,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
-    case INDEX_op_div_i32:
-    case INDEX_op_div_i64:
+    case INDEX_op_divs:
     case INDEX_op_eqv:
     case INDEX_op_mul:
     case INDEX_op_mulsh:
diff --git a/tcg/tci.c b/tcg/tci.c
index 4ecbb2d335..4b3ca53bc5 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -720,7 +720,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Arithmetic operations (64 bit). */
 
-        case INDEX_op_div_i64:
+        case INDEX_op_divs:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int64_t)regs[r1] / (int64_t)regs[r2];
             break;
@@ -1071,6 +1071,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_divs:
     case INDEX_op_eqv:
     case INDEX_op_mul:
     case INDEX_op_nand:
@@ -1079,8 +1080,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_orc:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_div_i32:
-    case INDEX_op_div_i64:
     case INDEX_op_rem_i32:
     case INDEX_op_rem_i64:
     case INDEX_op_divu_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index fe922d1dac..a833b3b7b2 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -277,7 +277,7 @@ Arithmetic
 
      - | *t0* = *t1* * *t2*
 
-   * - div_i32/i64 *t0*, *t1*, *t2*
+   * - divs *t0*, *t1*, *t2*
 
      - | *t0* = *t1* / *t2* (signed)
        | Undefined behavior if division by zero or overflow.
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index c8e86a3253..4a556e2ce7 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -651,7 +651,7 @@ static void tgen_divs(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_divs32
-                     : INDEX_op_div_i64);
+                     : INDEX_op_divs);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


