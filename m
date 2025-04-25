Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C0DC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RDn-0001Zs-IX; Fri, 25 Apr 2025 18:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB5-0003zm-QO
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:48 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB2-0001tw-1k
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso3047177b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618743; x=1746223543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FxjDZrL7QXgBNqKRRmF2Tbv8Lp1vw/QDQ2FOR514CI=;
 b=lX2WATBcBy1gmoYMxrez63xrdHOBBj5JgOugnmCAPf3y6BJOUwyNkvb+ssKPXex5qs
 ZY7oj2uMSTSJXMW5hElctVVqcfVpgN7JXPn0bKEX+Dmqs7/W/VovQIObG0PouqL3L9e9
 03Nx55Qhk3SuyZ5ffWM4mb/sWM3J4dgg7zNFiko18GIIlEAg7Kuuv17sdR52F99bangb
 nTIrR5EMG3O9N9kF3HwjM7zQ8jWrZVGYrtJ5hB4eXRBhqP8rLW95IiofaBMIXGQMYLWb
 lW1hWKN4JpV33/GSBCx99czt0uEn+jpWZfHpEXsmvJFh2/R1hYCFmkBKlvwBqMzeX6Mu
 vCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618743; x=1746223543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FxjDZrL7QXgBNqKRRmF2Tbv8Lp1vw/QDQ2FOR514CI=;
 b=n+vk3WZ74iwCE0MHinNVe6Qllk1Q+gr+OykVoCsv3QNKwL2cagfaJBWTxCn0Q54JVX
 QpMAr0DfeMDVSFr+Q5ASf2p6px4Pw9p0200Czt1kwMUmOM7n0cgSjdxXn/vBs1Igwtva
 FayxfM8uiJu9R3E6BhwIt2a5D2YUflUNmNo5kmSe8e1gV5hniizYhromZPpiGqh5EDM6
 kYJnj5kp/Jq+IVBL4OqD5fx9FGtuRWxVfqvNggtN3q4d3ildDS9K5BA1cxini0fqRUFS
 UkIyEC+fS4V+zglP/V2Ad1dCFkT1FXkj9+PHj9An/FgMFXrGVMlMgs6DadA70/Rtrd7z
 ig4g==
X-Gm-Message-State: AOJu0YyBebMAnocd/Ng1a2WT/Ywdr/U6mhMU0dSHsi/5+qCcMNSAHLcK
 0qzO0z/+lulq7rvapufvUo/bypvhhuQFkb0GjyzVnu3ZaFoqul8sFmiKrMfi68sQY6bYSuezflr
 z
X-Gm-Gg: ASbGncui5GjvNBar230QErkKz61uxGFaHvBZ1hxXSw5hhId0ouvHTgs3T5HZXCwQxdm
 2fEFvp1JseA7cEpXwia+7m0GgvVyo8pBOY3CRiOHdC/go1N+b2d46MbB/ZXGogv6VoRgqaM1bbx
 NaBu2PfCYr9H02dMaY59ZW4ZV9Sy6cq0bt0qveCYl4sxRDTIM0ONbcIn88PhQENjiRVL2Sjnrgn
 PI9bDTH+cS7Su5YIJ4gCg26J9+v7jny1mYNJjw4t/HlPA1dCRRAH0FL1KKaHYfGU5xuAV+/tqPh
 bNypmHtAh4XV+8FITKN0mIULlN2I4O7TkRveWlPclG9ikXwRxuwKNXpdrq1ZTJMgFnb0E5HWaqE
 =
X-Google-Smtp-Source: AGHT+IEDtAFPuDrJiAB/I87V7FMcf7k/xsjzNQ3J93kL3eY+rWloTNy59C1Tna/7CCKD1CrP+m5aNA==
X-Received: by 2002:a05:6a00:2d11:b0:73e:970:731 with SMTP id
 d2e1a72fcca58-73fd88663d7mr5028991b3a.16.1745618742592; 
 Fri, 25 Apr 2025 15:05:42 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 146/159] tcg: Remove add2/sub2 opcodes
Date: Fri, 25 Apr 2025 14:54:40 -0700
Message-ID: <20250425215454.886111-147-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

All uses have been replaced by add/sub carry opcodes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  5 --
 tcg/aarch64/tcg-target-has.h     |  5 --
 tcg/arm/tcg-target-has.h         |  4 --
 tcg/i386/tcg-target-has.h        |  5 --
 tcg/loongarch64/tcg-target-has.h |  4 --
 tcg/mips/tcg-target-has.h        |  5 --
 tcg/ppc/tcg-target-has.h         |  4 --
 tcg/riscv/tcg-target-has.h       |  5 --
 tcg/s390x/tcg-target-has.h       |  7 ---
 tcg/sparc64/tcg-target-has.h     |  7 ---
 tcg/tcg-has.h                    |  2 -
 tcg/tci/tcg-target-has.h         |  4 --
 tcg/optimize.c                   | 87 --------------------------------
 tcg/tcg-op.c                     | 26 ----------
 tcg/tcg.c                        | 36 -------------
 docs/devel/tcg-ops.rst           | 14 ++---
 16 files changed, 3 insertions(+), 217 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 9cc20cd62c..30ba15723a 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -102,8 +102,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 
-DEF(add2_i32, 2, 4, 0, 0)
-DEF(sub2_i32, 2, 4, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
@@ -126,9 +124,6 @@ DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(add2_i64, 2, 4, 0, 0)
-DEF(sub2_i64, 2, 4, 0, 0)
-
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
 /* There are tcg_ctx->insn_start_words here, not just one. */
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 695effd77c..b155e37639 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -13,14 +13,9 @@
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
  * which requires writable pages.  We must defer to the helper for user-only,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index f4bd15c68a..187269e5bd 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,12 +24,8 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
-
 #define TCG_TARGET_HAS_tst              1
 
 #define TCG_TARGET_HAS_v64              use_neon_instructions
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index a984a6af2e..628e736de7 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,14 +26,9 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
-
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index a1bd71db6a..9c118bd1f6 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -10,14 +10,10 @@
 #include "host/cpuinfo.h"
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
 
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 9d86906bf3..d8f9f7beef 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -39,13 +39,8 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
-
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
 #endif
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 4dda668706..b978c91a62 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -18,13 +18,9 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index c95dc1921e..8cd099546f 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -11,13 +11,8 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
-
 #define TCG_TARGET_HAS_tst              0
 
 /* vector instructions */
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 17e61130cd..c04cc4e377 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -29,16 +29,9 @@ extern uint64_t s390_facilities[3];
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32       0
-#define TCG_TARGET_HAS_sub2_i32       0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
-
-#define TCG_TARGET_HAS_add2_i64       0
-#define TCG_TARGET_HAS_sub2_i64       0
-
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
-
 #define TCG_TARGET_HAS_tst            1
 
 #define TCG_TARGET_HAS_v64            HAVE_FACILITY(VECTOR)
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index caf7679595..d9f5ef3fc9 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,16 +14,9 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
-
 #define TCG_TARGET_HAS_tst              1
 
 #define TCG_TARGET_extract_valid(type, ofs, len) \
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 50e8d0cda4..2fc0e50d20 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -12,8 +12,6 @@
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 #endif
 
 #if !defined(TCG_TARGET_HAS_v64) \
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 310d45ba62..497e8152b7 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -8,13 +8,9 @@
 #define TCG_TARGET_HAS_H
 
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 #endif /* TCG_TARGET_REG_BITS == 64 */
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 95ec3b426d..52e194aaa9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1399,82 +1399,6 @@ static bool fold_addco(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
-{
-    bool a_const = arg_is_const(op->args[2]) && arg_is_const(op->args[3]);
-    bool b_const = arg_is_const(op->args[4]) && arg_is_const(op->args[5]);
-
-    if (a_const && b_const) {
-        uint64_t al = arg_info(op->args[2])->val;
-        uint64_t ah = arg_info(op->args[3])->val;
-        uint64_t bl = arg_info(op->args[4])->val;
-        uint64_t bh = arg_info(op->args[5])->val;
-        TCGArg rl, rh;
-        TCGOp *op2;
-
-        if (ctx->type == TCG_TYPE_I32) {
-            uint64_t a = deposit64(al, 32, 32, ah);
-            uint64_t b = deposit64(bl, 32, 32, bh);
-
-            if (add) {
-                a += b;
-            } else {
-                a -= b;
-            }
-
-            al = sextract64(a, 0, 32);
-            ah = sextract64(a, 32, 32);
-        } else {
-            Int128 a = int128_make128(al, ah);
-            Int128 b = int128_make128(bl, bh);
-
-            if (add) {
-                a = int128_add(a, b);
-            } else {
-                a = int128_sub(a, b);
-            }
-
-            al = int128_getlo(a);
-            ah = int128_gethi(a);
-        }
-
-        rl = op->args[0];
-        rh = op->args[1];
-
-        /* The proper opcode is supplied by tcg_opt_gen_mov. */
-        op2 = opt_insert_before(ctx, op, 0, 2);
-
-        tcg_opt_gen_movi(ctx, op, rl, al);
-        tcg_opt_gen_movi(ctx, op2, rh, ah);
-        return true;
-    }
-
-    /* Fold sub2 r,x,i to add2 r,x,-i */
-    if (!add && b_const) {
-        uint64_t bl = arg_info(op->args[4])->val;
-        uint64_t bh = arg_info(op->args[5])->val;
-
-        /* Negate the two parts without assembling and disassembling. */
-        bl = -bl;
-        bh = ~bh + !bl;
-
-        op->opc = (ctx->type == TCG_TYPE_I32
-                   ? INDEX_op_add2_i32 : INDEX_op_add2_i64);
-        op->args[4] = arg_new_constant(ctx, bl);
-        op->args[5] = arg_new_constant(ctx, bh);
-    }
-    return finish_folding(ctx, op);
-}
-
-static bool fold_add2(OptContext *ctx, TCGOp *op)
-{
-    /* Note that the high and low parts may be independently swapped. */
-    swap_commutative(op->args[0], &op->args[2], &op->args[4]);
-    swap_commutative(op->args[1], &op->args[3], &op->args[5]);
-
-    return fold_addsub2(ctx, op, true);
-}
-
 static bool fold_and(OptContext *ctx, TCGOp *op)
 {
     uint64_t z1, z2, z_mask, s_mask;
@@ -2811,11 +2735,6 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_sub2(OptContext *ctx, TCGOp *op)
-{
-    return fold_addsub2(ctx, op, false);
-}
-
 static void squash_prev_borrowout(OptContext *ctx, TCGOp *op)
 {
     TempOptInfo *t2;
@@ -3150,9 +3069,6 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_addco:
             done = fold_addco(&ctx, op);
             break;
-        CASE_OP_32_64(add2):
-            done = fold_add2(&ctx, op);
-            break;
         case INDEX_op_and:
         case INDEX_op_and_vec:
             done = fold_and(&ctx, op);
@@ -3342,9 +3258,6 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_sub_vec:
             done = fold_sub_vec(&ctx, op);
             break;
-        CASE_OP_32_64(sub2):
-            done = fold_sub2(&ctx, op);
-            break;
         case INDEX_op_xor:
         case INDEX_op_xor_vec:
             done = fold_xor(&ctx, op);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b0a29278ab..b0139ce05d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -249,24 +249,6 @@ static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4, a5);
 }
 
-static void DNI tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                TCGv_i32 a3, TCGv_i32 a4,
-                                TCGv_i32 a5, TCGv_i32 a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5),
-                tcgv_i32_arg(a6));
-}
-
-static void DNI tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                TCGv_i64 a3, TCGv_i64 a4,
-                                TCGv_i64 a5, TCGv_i64 a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5),
-                tcgv_i64_arg(a6));
-}
-
 static void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                  TCGv_i32 a3, TCGv_i32 a4,
                                  TCGv_i32 a5, TCGArg a6)
@@ -1108,8 +1090,6 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
         tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
         tcg_gen_mov_i32(rl, t0);
         tcg_temp_free_i32(t0);
-    } else if (TCG_TARGET_HAS_add2_i32) {
-        tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
@@ -1159,8 +1139,6 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
         tcg_gen_op3_i32(INDEX_op_subbi, rh, ah, bh);
         tcg_gen_mov_i32(rl, t0);
         tcg_temp_free_i32(t0);
-    } else if (TCG_TARGET_HAS_sub2_i32) {
-        tcg_gen_op6_i32(INDEX_op_sub2_i32, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
@@ -2880,8 +2858,6 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 
         tcg_gen_mov_i64(rl, t0);
         tcg_temp_free_i64(t0);
-    } else if (TCG_TARGET_HAS_add2_i64) {
-        tcg_gen_op6_i64(INDEX_op_add2_i64, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
@@ -2985,8 +2961,6 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 
         tcg_gen_mov_i64(rl, t0);
         tcg_temp_free_i64(t0);
-    } else if (TCG_TARGET_HAS_sub2_i64) {
-        tcg_gen_op6_i64(INDEX_op_sub2_i64, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3b9f519ef6..5a498b48b6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2430,11 +2430,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return true;
 
-    case INDEX_op_add2_i32:
-        return TCG_TARGET_HAS_add2_i32;
-    case INDEX_op_sub2_i32:
-        return TCG_TARGET_HAS_sub2_i32;
-
     case INDEX_op_brcond2_i32:
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
@@ -2456,11 +2451,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrh_i64_i32:
         return TCG_TARGET_REG_BITS == 64;
 
-    case INDEX_op_add2_i64:
-        return TCG_TARGET_HAS_add2_i64;
-    case INDEX_op_sub2_i64:
-        return TCG_TARGET_HAS_sub2_i64;
-
     case INDEX_op_mov_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_dupm_vec:
@@ -4101,32 +4091,6 @@ liveness_pass_1(TCGContext *s)
             la_reset_pref(ts);
             break;
 
-        case INDEX_op_add2_i32:
-        case INDEX_op_add2_i64:
-            opc_new = INDEX_op_add;
-            goto do_addsub2;
-        case INDEX_op_sub2_i32:
-        case INDEX_op_sub2_i64:
-            opc_new = INDEX_op_sub;
-        do_addsub2:
-            assert_carry_dead(s);
-            /* Test if the high part of the operation is dead, but not
-               the low part.  The result can be optimized to a simple
-               add or sub.  This happens often for x86_64 guest when the
-               cpu mode is set to 32 bit.  */
-            if (arg_temp(op->args[1])->state == TS_DEAD) {
-                if (arg_temp(op->args[0])->state == TS_DEAD) {
-                    goto do_remove;
-                }
-                /* Replace the opcode and adjust the args in place,
-                   leaving 3 unused args at the end.  */
-                op->opc = opc = opc_new;
-                op->args[1] = op->args[2];
-                op->args[2] = op->args[4];
-                /* Fall through and mark the single-word operation live.  */
-            }
-            goto do_not_remove;
-
         case INDEX_op_muls2:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh;
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 93bcc70639..a7147407de 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -654,14 +654,6 @@ Multiword arithmetic support
          code generator will use ``tcg_out_set_borrow`` and then
          the output routine for *subbio*.
 
-   * - add2_i32/i64 *t0_low*, *t0_high*, *t1_low*, *t1_high*, *t2_low*, *t2_high*
-
-       sub2_i32/i64 *t0_low*, *t0_high*, *t1_low*, *t1_high*, *t2_low*, *t2_high*
-
-     - | Similar to add/sub, except that the double-word inputs *t1* and *t2* are
-         formed from two single-word arguments, and the double-word output *t0*
-         is returned in two single-word outputs.
-
    * - mulu2 *t0_low*, *t0_high*, *t1*, *t2*
 
      - | Similar to mul, except two unsigned inputs *t1* and *t2* yielding the full
@@ -952,9 +944,9 @@ Assumptions
 The target word size (``TCG_TARGET_REG_BITS``) is expected to be 32 bit or
 64 bit. It is expected that the pointer has the same size as the word.
 
-On a 32 bit target, all 64 bit operations are converted to 32 bits. A
-few specific operations must be implemented to allow it (see add2_i32,
-sub2_i32, brcond2_i32).
+On a 32 bit target, all 64 bit operations are converted to 32 bits.
+A few specific operations must be implemented to allow it
+(see brcond2_i32, setcond2_i32).
 
 On a 64 bit target, the values are transferred between 32 and 64-bit
 registers using the following ops:
-- 
2.43.0


