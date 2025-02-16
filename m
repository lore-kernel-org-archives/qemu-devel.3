Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37769C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnrR-0004Qt-5M; Sun, 16 Feb 2025 18:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqA-00015R-TF
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:25 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpz-0005TP-EK
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:15 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220c4159f87so49434705ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747649; x=1740352449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gi6QUN8ccCnBHbGiO1XT6qenO2GF6a6XX8PZVpQvhug=;
 b=F7fhLipWS26AMdqLfCIDSobA7373yGejcEwPUjrVTzDON4jmHMlraX7ol1yXgXRc1c
 8O1p5fSGuZn3JcKkQHoynH9kaBMhQ+KLRRLoWACb5bi/k2hVkUsEYWZRRvmMaFOYICOi
 x3LSM3lDronoI0PYXchHA5hvevGzBJKu2Rkx5+LssmI1URVyGKfRkyflrURKWbJvYDPO
 YFLsiIQN44s6Cjt0oKLgWpYmU92hF6+QSyhxxDaI0fONuk4NN7GYPNagSaTavInn+ePw
 N8DrET1J+MHka1Oq6Uwbth1H7ZNWdazwGcj0I21Vy1lgJfmDfx9I3vJdDH2My6SrejIx
 taLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747649; x=1740352449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gi6QUN8ccCnBHbGiO1XT6qenO2GF6a6XX8PZVpQvhug=;
 b=PL+80VcAt/kXxE+MEV/GnKatvpNdv+mtCklzT2k2kJOxq2eyONmX91XpBH3ojsN8HG
 iRSQYxv5p7y4dayL7nhOoII9ld3e9Mf1VGbRCnk1saKePVSyIBxRRM1Y+YeDzFEN5B78
 qDq+3JBogb/J3W8MGhwTPpTW3e5iZaHRf4FIJSBzAMtAmYaYsVLBrBWEBWEPItTYvCkt
 BQUHVD4HSm7SqHYFpYs1Lu6iq9Of+KZfS4uGhTRA2KGqMhIT+MDxdMv8QezaXuCuW+E0
 /VCGidUnTFrFwPFgkR9B3suV55IBTijSGATXpdrtKCHs2SRxUO4oMyTLw1nfB6vvZoGL
 47Yg==
X-Gm-Message-State: AOJu0YwLrpxmyoJZ1PLvL5ak67EdgAzn8wBxwsmw6yWXZAY62Lz6R+yY
 n8T+AJc6KWz7B8EjF2IO7nu/Gin8CMVYUuJyarlV9uPHheZv6CCVEtcpfKVjxADdzMWpoHP2O2I
 c
X-Gm-Gg: ASbGncsR1IyKe8ZM3P4xeDkYBIEW1aOOwK6pEASaQfF4Y+aJBkhnRFe5gYD5UwLk0m8
 p1k/M/ljcKnzWuGd6T+nR36/zzhWjXDrpIgS4AnS9v/RQO5wTpcIZVuc9cPWVJqMEccbwOQfAAL
 g3ZhmisAN+YmBAc0ODKABSojp8vWKvGDwi4U62z9oV+0+YhiJBIsXI0P7XPS0PcFvjgipdF1pvr
 0++bQjtQAKuU6RiAgvVxP8uF+DNifHm46pPHy9aN1oPHdZOcWVRXkD6Ac3KqrrZCokqEmXPCrmj
 rxRMAQxugibmcGDqI8jfVuX7YgSZM1vy7ttJ4jfopbCGTLg=
X-Google-Smtp-Source: AGHT+IHVjm60kEHmBqL+WYy5dUNSj+tPYR+bZzQ+HsHUqOTGC0RyI6Vk9rWyMnGRkJBDIb6ow4sG/Q==
X-Received: by 2002:a17:902:da8e:b0:21f:2ded:76ea with SMTP id
 d9443c01a7336-221040bd2a8mr115665465ad.36.1739747649125; 
 Sun, 16 Feb 2025 15:14:09 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.14.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:14:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 074/162] tcg: Remove TCG_TARGET_HAS_negsetcond_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:43 -0800
Message-ID: <20250216231012.2808572-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
index a4b9e5dec0..9acf63e4cd 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1984,23 +1984,19 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
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
@@ -2012,14 +2008,12 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
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
index 5ee15ec116..58f764c8a4 100644
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


