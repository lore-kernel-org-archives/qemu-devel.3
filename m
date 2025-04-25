Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FB4C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4j-0003RV-W4; Fri, 25 Apr 2025 17:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4W-0002TJ-J0
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:59:00 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4T-0000u4-Le
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:59:00 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2264aefc45dso44703845ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618336; x=1746223136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJil/TRU3UWjoX273nzb7paaZXZAqhzIc0tNzzmAm7s=;
 b=aLG443wYurg+CEGjTQM9HwvNQP0pz+pZYRxJDCcn1bz0jjUv+CkP++RMd2GEtNQfEI
 8aWb7YpStoyBNwlMQRgPio5H/Whh+Kchij1BvU6AuJRgnyTRFYnrb0lDpRGV77iGHC1w
 ERuz0j/rlu8K5EjquivG1dBrEJ3Ue3AobYX7wRC2K+PhfABYJ5C7+4TUYLTmpSnEOHix
 wLwiS8cwb5HiEmYcd4/9ccYbuH4thfGCMNlmaqJoxwHNFsTBU7rKLXGLPRaZ87rVmrp9
 zBFHIgPN9fEE4D7UqE7Y8HTTlMjzqTaJDQf5m/YkyTA0hnQFejAIRUrjMCdcfcmtL5Z7
 BMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618336; x=1746223136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJil/TRU3UWjoX273nzb7paaZXZAqhzIc0tNzzmAm7s=;
 b=r7nQhIKr5jsFbZFMrsQlWDwZdy6H5chSRnf2H7vCR5ZNr3M0Wv8gFePmbBoGwFFMRt
 ESpbPQ74MchVBSdGcAYUC2KJiPthBtFjGdLz16MMQBcYJYI8NX5ZJbHiqewV9A1WzIV+
 cKVH5Xx1Y/2WeYm3/mxcro4gnptHyMjxY1SHODn0KXG5JTCCRRKEjxVoeoCytQ3Xqs1z
 8A49ZZjWrMf2pBr+IBP2y2wX1eJ3dhU0PwrVv1Jm2kvFG97krKy5YT5MrJKJZAoglny7
 uU/HFkCfCgyM3+sqmQ43lSG5iaJfzFJ0KCLjhF7l3nIuKNMiVCBZUZtWh467iwGOOVHy
 4c/A==
X-Gm-Message-State: AOJu0Yz0x1RsJeN1i7CH2oK9s7dFMUDqU+6grZmpkEfnZ+TxDbFVbAJV
 N/gahbMJ7burYEiy0VrVEyvXqHwrm5LW4ItAzfZnnYaCwlEe/Sh74e2vYuSalHOhFR4rvI6AyC2
 t
X-Gm-Gg: ASbGncu+mGek7QJ56yHKzqJS7wlc7/5X6D45wpbbCrL7FE159lC86wg9QzZontPbSI+
 /Is4HJR9Rqmk6SFsA/6ggYaR5wUOk8Kc/p067owfhCVG4jQKuHbhIqf+ZdzB9+VOlPAhzLQBNH0
 YGvaOFAhYUNNyS3E7697i8+hOqdLanqmTzEzOChdT5HFLs8ys+CWUxPNLDxBHTqjrzWQi58YR+V
 LMeM5uSJsbkD0j7gm0ZIvi8KtvVvy586N1lB1MHxQhKHfDR0uj8cItVOr4UEd0qGlyCloHfUXJT
 Y0p7NYE7s69kE2pDUC8C2H922K586u5YZyGypi2CcLcICkDDVqV+YrILdK6baEZ8pqjMocm8P18
 =
X-Google-Smtp-Source: AGHT+IEICeshZDx9QMLwFKZcsq4DBm0xQU00F/GlpbQnZRsu8B8ndRdi+9Lqix2ftwDe49CuK5YdNA==
X-Received: by 2002:a17:903:8c5:b0:227:e74a:a05a with SMTP id
 d9443c01a7336-22dbf740429mr65903885ad.44.1745618335814; 
 Fri, 25 Apr 2025 14:58:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 079/159] tcg: Remove TCG_TARGET_HAS_negsetcond_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:33 -0700
Message-ID: <20250425215454.886111-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

All targets now provide negsetcond, so remove the conditional.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h     |  2 --
 tcg/arm/tcg-target-has.h         |  1 -
 tcg/i386/tcg-target-has.h        |  2 --
 tcg/loongarch64/tcg-target-has.h |  2 --
 tcg/mips/tcg-target-has.h        |  2 --
 tcg/ppc/tcg-target-has.h         |  2 --
 tcg/riscv/tcg-target-has.h       |  2 --
 tcg/s390x/tcg-target-has.h       |  2 --
 tcg/sparc64/tcg-target-has.h     |  2 --
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 --
 tcg/optimize.c                   | 24 +++++++++---------------
 tcg/tcg-op.c                     | 12 +++---------
 tcg/tcg.c                        |  6 ++----
 14 files changed, 14 insertions(+), 48 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 0c370d7dda..22a574e703 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -16,7 +16,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_extr_i64_i32     0
@@ -26,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
-#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index ccbc39a23e..bfa3be8028 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -27,7 +27,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index c92a049fd7..aaf8764cc9 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -29,7 +29,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 
@@ -40,7 +39,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
-#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index e9bb913961..90f0a131ae 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -10,7 +10,6 @@
 #include "host/cpuinfo.h"
 
 /* optional instructions */
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
@@ -19,7 +18,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
-#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_bswap16_i64      1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index c77d4296cf..c6cecba28b 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -41,7 +41,6 @@ extern bool use_mips32r2_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_negsetcond_i32   1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
@@ -51,7 +50,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_negsetcond_i64   1
 #endif
 
 /* optional instructions detected at runtime */
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 5cc059fe9a..5c4fc2bc34 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -31,7 +30,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #endif
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 9b86b8bf48..e18b5cb8ec 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -10,7 +10,6 @@
 #include "host/cpuinfo.h"
 
 /* optional instructions */
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -18,7 +17,6 @@
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 894a9f64e0..41cd8a1d0d 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -32,7 +32,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_extract2_i32   0
-#define TCG_TARGET_HAS_negsetcond_i32 1
 #define TCG_TARGET_HAS_add2_i32       1
 #define TCG_TARGET_HAS_sub2_i32       1
 #define TCG_TARGET_HAS_extr_i64_i32   0
@@ -42,7 +41,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_extract2_i64   0
-#define TCG_TARGET_HAS_negsetcond_i64 1
 #define TCG_TARGET_HAS_add2_i64       1
 #define TCG_TARGET_HAS_sub2_i64       1
 
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 258c978b5e..6ed27b8fcc 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -17,7 +17,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -27,7 +26,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index d4fc7148b4..315dfd05aa 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -16,7 +16,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 /* Turn some undef macros into true macros.  */
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 7787347e05..f45a0688f9 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -10,7 +10,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -19,7 +18,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 14d943cf97..0affde323b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1996,23 +1996,19 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
     if (ti_is_const(tt) && ti_is_const(ft)) {
         uint64_t tv = ti_const_val(tt);
         uint64_t fv = ti_const_val(ft);
-        TCGOpcode opc, negopc = 0;
+        TCGOpcode opc, negopc;
         TCGCond cond = op->args[5];
 
         switch (ctx->type) {
         case TCG_TYPE_I32:
             opc = INDEX_op_setcond_i32;
-            if (TCG_TARGET_HAS_negsetcond_i32) {
-                negopc = INDEX_op_negsetcond_i32;
-            }
+            negopc = INDEX_op_negsetcond_i32;
             tv = (int32_t)tv;
             fv = (int32_t)fv;
             break;
         case TCG_TYPE_I64:
             opc = INDEX_op_setcond_i64;
-            if (TCG_TARGET_HAS_negsetcond_i64) {
-                negopc = INDEX_op_negsetcond_i64;
-            }
+            negopc = INDEX_op_negsetcond_i64;
             break;
         default:
             g_assert_not_reached();
@@ -2024,14 +2020,12 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         } else if (fv == 1 && tv == 0) {
             op->opc = opc;
             op->args[3] = tcg_invert_cond(cond);
-        } else if (negopc) {
-            if (tv == -1 && fv == 0) {
-                op->opc = negopc;
-                op->args[3] = cond;
-            } else if (fv == -1 && tv == 0) {
-                op->opc = negopc;
-                op->args[3] = tcg_invert_cond(cond);
-            }
+        } else if (tv == -1 && fv == 0) {
+            op->opc = negopc;
+            op->args[3] = cond;
+        } else if (fv == -1 && tv == 0) {
+            op->opc = negopc;
+            op->args[3] = tcg_invert_cond(cond);
         }
     }
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 22af3b12bc..413b68352d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -569,11 +569,8 @@ void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
         tcg_gen_movi_i32(ret, -1);
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_movi_i32(ret, 0);
-    } else if (TCG_TARGET_HAS_negsetcond_i32) {
-        tcg_gen_op4i_i32(INDEX_op_negsetcond_i32, ret, arg1, arg2, cond);
     } else {
-        tcg_gen_setcond_i32(cond, ret, arg1, arg2);
-        tcg_gen_neg_i32(ret, ret);
+        tcg_gen_op4i_i32(INDEX_op_negsetcond_i32, ret, arg1, arg2, cond);
     }
 }
 
@@ -1950,17 +1947,14 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
         tcg_gen_movi_i64(ret, -1);
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_movi_i64(ret, 0);
-    } else if (TCG_TARGET_HAS_negsetcond_i64) {
+    } else if (TCG_TARGET_REG_BITS == 64) {
         tcg_gen_op4i_i64(INDEX_op_negsetcond_i64, ret, arg1, arg2, cond);
-    } else if (TCG_TARGET_REG_BITS == 32) {
+    } else {
         tcg_gen_op6i_i32(INDEX_op_setcond2_i32, TCGV_LOW(ret),
                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
                          TCGV_LOW(arg2), TCGV_HIGH(arg2), cond);
         tcg_gen_neg_i32(TCGV_LOW(ret), TCGV_LOW(ret));
         tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_LOW(ret));
-    } else {
-        tcg_gen_setcond_i64(cond, ret, arg1, arg2);
-        tcg_gen_neg_i64(ret, ret);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 685408f0f9..38a329b876 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2268,6 +2268,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return has_type;
 
     case INDEX_op_setcond_i32:
+    case INDEX_op_negsetcond_i32:
     case INDEX_op_brcond_i32:
     case INDEX_op_movcond_i32:
     case INDEX_op_ld8u_i32:
@@ -2283,8 +2284,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i32:
         return true;
 
-    case INDEX_op_negsetcond_i32:
-        return TCG_TARGET_HAS_negsetcond_i32;
     case INDEX_op_extract2_i32:
         return TCG_TARGET_HAS_extract2_i32;
     case INDEX_op_add2_i32:
@@ -2301,6 +2300,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_REG_BITS == 32;
 
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i64:
     case INDEX_op_brcond_i64:
     case INDEX_op_movcond_i64:
     case INDEX_op_ld8u_i64:
@@ -2321,8 +2321,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
-    case INDEX_op_negsetcond_i64:
-        return TCG_TARGET_HAS_negsetcond_i64;
     case INDEX_op_extract2_i64:
         return TCG_TARGET_HAS_extract2_i64;
     case INDEX_op_extrl_i64_i32:
-- 
2.43.0


