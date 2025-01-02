Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55835E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbb-00074u-2O; Thu, 02 Jan 2025 13:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbP-00070u-7a
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:26 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbL-0005Ao-Gm
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:22 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so15795867a91.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841237; x=1736446037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lPwKBw32p4aNsEQUutGi6vuAUtCJtI+tiP9dqFE78To=;
 b=xuTLlfJIQXUjvulFmSLHctWmDISvQe3uM9gQLKm6GGI8EQ3qLCOW0gT7FKU+Mdk4zx
 QqN3vz+CR0rwgN9xjY5CRa80GF8Hcvf7HIJU7Tldc+sbZJ9EKMBWkCktZK+WfKXYX/yy
 QQ9khvj4TEGkPHQbDYlliBDBAFLjHcABdPkrRuuuzbAide5//k+DG9bwSL7rsnJk2P+a
 wo4iYu7S9dzwGZslmzAeopSZfRZwvGcTAnpTyg2HSnXSWQZpTTeP/yqEzBBqn2KB7qLA
 CLOBpOwKaTQJF5Hz6Q5KGlIiTEL1i2XSS9xShC0/RGqgy4e0Oaq2vJWDrpMFNRE4IzYK
 Z8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841237; x=1736446037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPwKBw32p4aNsEQUutGi6vuAUtCJtI+tiP9dqFE78To=;
 b=g3kMzIyXnVe1YzwvGhxTxLT7jeWpmAXe3Rbz3g3B1z49hjR8comXa2B/Xz82kj8DGS
 wbos4ySeJ7OQ7/qqkcH0qDrfVGYT2AtY/Cc+lxom5/Z8YMRneUhxOY2JIqn/bw+dPMb8
 Kxm8ZLX7/LwFYb5BTT8wzwDs4v2lvLkINeor1xv+HWzXa2EMti7pP7OCxeZZXPwFoTZT
 MDByjDFru258qZXk7p3c0fVIw5gODKEqcVVYs5HCzlt89PbZy5bwvDzG6aZer0bTQFiA
 C4suMLhF29vQ1P8zwt3Vmy6BC4ZGbQJkw66mRfPK1PMFq3p1PdO41AR9M4sevMxqYrBQ
 PCnA==
X-Gm-Message-State: AOJu0Yz/12dXC2M8r/beA1m/aR77c6lLq2kVU2wLWtj3QWhS8W+hDVWT
 wlEVRe5J1wVy6wWuZ8FvvWO9I5gCOsyORhURLlmOXV3gLIzRSHOzbqDCynWtsAGvPpXQ7AGrgtA
 V
X-Gm-Gg: ASbGncuN2Kqe+Cp4nAXbJTMfLIuLIgmIJFydKX+gFAAkizVpXlAToKTxnm6Nsmvdi46
 NMqsLHpEnN5L6fKVTotLPhzAhxj403/VZnc4bMEr4+0FWG9qbk3F9eH+oVPf2uSZnN0B88qTJOa
 mwq8rntRxQkYPCEKB481tl+iQ3ZBwVInnGPlIqwqfiJYzaHwtwHLNwAHlkvhY+aiffrpHDheyzg
 7S7B7TuAuvIDxSMP7auPG8r70/Yi0pXyCECO+lS0bBL6nXurwXihMWRibbLAQ==
X-Google-Smtp-Source: AGHT+IHzcRXcbexY6zFsMlmzsWICC1U2DoSi2OppnkwzAxl96SfiiRkxS0XjbH4hqkJ9cCWVO9YxMQ==
X-Received: by 2002:a05:6a00:1944:b0:71d:f4ef:6b3a with SMTP id
 d2e1a72fcca58-72abdeb6e80mr67711840b3a.21.1735841237426; 
 Thu, 02 Jan 2025 10:07:17 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/73] tcg: Merge TCG_TARGET_HAS_{add2,sub2}
Date: Thu,  2 Jan 2025 10:06:08 -0800
Message-ID: <20250102180654.1420056-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 include/tcg/tcg-opc.h            |  8 ++++----
 tcg/aarch64/tcg-target-has.h     |  6 ++----
 tcg/arm/tcg-target-has.h         |  2 ++
 tcg/i386/tcg-target-has.h        |  6 ++----
 tcg/loongarch64/tcg-target-has.h |  6 ++----
 tcg/mips/tcg-target-has.h        |  7 +++----
 tcg/ppc/tcg-target-has.h         |  6 ++----
 tcg/riscv/tcg-target-has.h       |  6 ++----
 tcg/s390x/tcg-target-has.h       |  6 ++----
 tcg/sparc64/tcg-target-has.h     |  6 ++----
 tcg/tcg-has.h                    |  5 -----
 tcg/tci/tcg-target-has.h         |  6 ++----
 tcg/tcg-op.c                     | 10 ++++++----
 tcg/tcg.c                        |  8 ++++----
 tcg/tci.c                        |  8 --------
 15 files changed, 35 insertions(+), 61 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index fbd759764c..4861b47f56 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -83,8 +83,8 @@ DEF(extract2_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_extract2_i32))
 
 DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 
-DEF(add2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_add2_i32))
-DEF(sub2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_sub2_i32))
+DEF(add2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_add2(TCG_TYPE_I32)))
+DEF(sub2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_sub2(TCG_TYPE_I32)))
 DEF(mulu2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_mulu2(TCG_TYPE_I32)))
 DEF(muls2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_muls2(TCG_TYPE_I32)))
 DEF(muluh_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_muluh(TCG_TYPE_I32)))
@@ -181,8 +181,8 @@ DEF(clz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_clz(TCG_TYPE_I64)))
 DEF(ctz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctz(TCG_TYPE_I64)))
 DEF(ctpop_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)))
 
-DEF(add2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_add2_i64))
-DEF(sub2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_sub2_i64))
+DEF(add2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_add2(TCG_TYPE_I64)))
+DEF(sub2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_sub2(TCG_TYPE_I64)))
 DEF(mulu2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulu2(TCG_TYPE_I64)))
 DEF(muls2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muls2(TCG_TYPE_I64)))
 DEF(muluh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muluh(TCG_TYPE_I64)))
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 53182cca6a..67c61fef9a 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -13,6 +13,7 @@
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_add2(T)          1
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_clz(T)           1
 #define TCG_TARGET_HAS_ctpop(T)         0
@@ -24,6 +25,7 @@
 #define TCG_TARGET_HAS_muluh(T)         (T == TCG_TYPE_I64)
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
+#define TCG_TARGET_HAS_sub2(T)          1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -42,8 +44,6 @@
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -58,8 +58,6 @@
 #define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 1352d3c25a..dabb8249f1 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,6 +24,7 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_add2(T)          1
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_clz(T)           1
 #define TCG_TARGET_HAS_ctpop(T)         0
@@ -35,6 +36,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_muluh(T)         0
 #define TCG_TARGET_HAS_rem(T)           0
 #define TCG_TARGET_HAS_rot(T)           1
+#define TCG_TARGET_HAS_sub2(T)          1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index fc6bd85ba2..b1d28054a9 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,6 +26,7 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_add2(T)          1
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_clz(T)           1
 #define TCG_TARGET_HAS_ctpop(T)         have_popcnt
@@ -36,6 +37,7 @@
 #define TCG_TARGET_HAS_mulsh(T)         0
 #define TCG_TARGET_HAS_muluh(T)         0
 #define TCG_TARGET_HAS_rot(T)           1
+#define TCG_TARGET_HAS_sub2(T)          1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          (T >= TCG_TYPE_V64 || have_bmi1)
@@ -54,8 +56,6 @@
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
@@ -71,8 +71,6 @@
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 932acac497..b2fea0f2e1 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -10,6 +10,7 @@
 #include "host/cpuinfo.h"
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_add2(T)          0
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_clz(T)           1
 #define TCG_TARGET_HAS_ctpop(T)         0
@@ -21,6 +22,7 @@
 #define TCG_TARGET_HAS_muluh(T)         1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
+#define TCG_TARGET_HAS_sub2(T)          0
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -35,8 +37,6 @@
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
@@ -58,8 +58,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
 
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index f81218178e..a81e54ff8d 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -39,6 +39,7 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_add2(T)          (TCG_TARGET_REG_BITS == 32)
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_clz(T)           use_mips32r2_instructions
 #define TCG_TARGET_HAS_ctpop(T)         0
@@ -50,6 +51,8 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_muluh(T)         1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           use_mips32r2_instructions
+#define TCG_TARGET_HAS_sub2(T)          (TCG_TARGET_REG_BITS == 32)
+#define TCG_TARGET_HAS_extract2(T)      0
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          0
@@ -62,11 +65,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_negsetcond_i32   0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_negsetcond_i64   0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 60da23a66a..96d7806ee0 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -17,6 +17,7 @@
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_add2(T)          (T == TCG_TYPE_REG)
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_clz(T)           1
 #define TCG_TARGET_HAS_ctpop(T)         have_isa_2_06
@@ -28,6 +29,7 @@
 #define TCG_TARGET_HAS_muluh(T)         1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
+#define TCG_TARGET_HAS_sub2(T)          (T == TCG_TYPE_REG)
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -51,8 +53,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
@@ -65,8 +65,6 @@
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 00eee4cafb..4707bff7a8 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -10,6 +10,7 @@
 #include "host/cpuinfo.h"
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_add2(T)          1
 #define TCG_TARGET_HAS_bswap(T)         (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_clz(T)           (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop(T)         (cpuinfo & CPUINFO_ZBB)
@@ -21,6 +22,7 @@
 #define TCG_TARGET_HAS_muluh(T)         (T == TCG_TYPE_I64)
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_sub2(T)          1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
@@ -35,8 +37,6 @@
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
@@ -57,8 +57,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 7c0d4708c9..fe3e77107f 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -29,6 +29,7 @@ extern uint64_t s390_facilities[3];
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_add2(T)        1
 #define TCG_TARGET_HAS_bswap(T)       1
 #define TCG_TARGET_HAS_clz(T)         (T == TCG_TYPE_I64)
 #define TCG_TARGET_HAS_ctpop(T)       1
@@ -39,6 +40,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_mulsh(T)       0
 #define TCG_TARGET_HAS_muluh(T)       0
 #define TCG_TARGET_HAS_rot(T)         1
+#define TCG_TARGET_HAS_sub2(T)        1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)        (T >= TCG_TYPE_V64 || HAVE_FACILITY(MISC_INSN_EXT3))
@@ -57,8 +59,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_sextract_i32   0
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_negsetcond_i32 1
-#define TCG_TARGET_HAS_add2_i32       1
-#define TCG_TARGET_HAS_sub2_i32       1
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
@@ -73,8 +73,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_sextract_i64   0
 #define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_negsetcond_i64 1
-#define TCG_TARGET_HAS_add2_i64       1
-#define TCG_TARGET_HAS_sub2_i64       1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 86b109fc6d..d6376a1b8d 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,6 +14,7 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_add2(T)          1
 #define TCG_TARGET_HAS_bswap(T)         0
 #define TCG_TARGET_HAS_clz(T)           0
 #define TCG_TARGET_HAS_ctpop(T)         0
@@ -25,6 +26,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_muluh(T)         (T == TCG_TYPE_I64 && use_vis3_instructions)
 #define TCG_TARGET_HAS_rem(T)           0
 #define TCG_TARGET_HAS_rot(T)           0
+#define TCG_TARGET_HAS_sub2(T)          1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -43,8 +45,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
@@ -59,8 +59,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 199facbe37..56f9725122 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -23,11 +23,6 @@
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-/* Turn some undef macros into true macros.  */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
 #ifndef TCG_TARGET_deposit_i32_valid
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index e0bf8b14bd..27d48670e8 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -8,6 +8,7 @@
 #define TCG_TARGET_HAS_H
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_add2(T)          1
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_clz(T)           1
 #define TCG_TARGET_HAS_ctpop(T)         1
@@ -19,6 +20,7 @@
 #define TCG_TARGET_HAS_muluh(T)         0
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
+#define TCG_TARGET_HAS_sub2(T)          1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -52,10 +54,6 @@
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
 #endif /* TCG_TARGET_REG_BITS == 64 */
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8786aa5903..dde9734615 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1158,7 +1158,7 @@ void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
-    if (TCG_TARGET_HAS_add2_i32) {
+    if (TCG_TARGET_HAS_add2(TCG_TYPE_I32)) {
         tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -1175,7 +1175,7 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
-    if (TCG_TARGET_HAS_sub2_i32) {
+    if (TCG_TARGET_HAS_sub2(TCG_TYPE_I32)) {
         tcg_gen_op6_i32(INDEX_op_sub2_i32, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -3064,7 +3064,8 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-    if (TCG_TARGET_HAS_add2_i64) {
+    if (TCG_TARGET_REG_BITS == 64 &&
+        TCG_TARGET_HAS_add2(TCG_TYPE_I64)) {
         tcg_gen_op6_i64(INDEX_op_add2_i64, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -3082,7 +3083,8 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-    if (TCG_TARGET_HAS_sub2_i64) {
+    if (TCG_TARGET_REG_BITS == 64 &&
+        TCG_TARGET_HAS_sub2(TCG_TYPE_I64)) {
         tcg_gen_op6_i64(INDEX_op_sub2_i64, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1befe0c4d7..b7ac97efcc 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2231,9 +2231,9 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_extract2_i32:
         return TCG_TARGET_HAS_extract2_i32;
     case INDEX_op_add2_i32:
-        return TCG_TARGET_HAS_add2_i32;
+        return TCG_TARGET_HAS_add2(TCG_TYPE_I32);
     case INDEX_op_sub2_i32:
-        return TCG_TARGET_HAS_sub2_i32;
+        return TCG_TARGET_HAS_sub2(TCG_TYPE_I32);
     case INDEX_op_mulu2_i32:
         return TCG_TARGET_HAS_mulu2(TCG_TYPE_I32);
     case INDEX_op_muls2_i32:
@@ -2365,9 +2365,9 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_ctpop_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_ctpop(TCG_TYPE_I64);
     case INDEX_op_add2_i64:
-        return TCG_TARGET_HAS_add2_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_add2(TCG_TYPE_I64);
     case INDEX_op_sub2_i64:
-        return TCG_TARGET_HAS_sub2_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_sub2(TCG_TYPE_I64);
     case INDEX_op_mulu2_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_mulu2(TCG_TYPE_I64);
     case INDEX_op_muls2_i64:
diff --git a/tcg/tci.c b/tcg/tci.c
index e71bf82c41..c478988d60 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -657,22 +657,18 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 tb_ptr = ptr;
             }
             break;
-#if TCG_TARGET_REG_BITS == 32 || TCG_TARGET_HAS_add2_i32
         case INDEX_op_add2_i32:
             tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
             T1 = tci_uint64(regs[r3], regs[r2]);
             T2 = tci_uint64(regs[r5], regs[r4]);
             tci_write_reg64(regs, r1, r0, T1 + T2);
             break;
-#endif
-#if TCG_TARGET_REG_BITS == 32 || TCG_TARGET_HAS_sub2_i32
         case INDEX_op_sub2_i32:
             tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
             T1 = tci_uint64(regs[r3], regs[r2]);
             T2 = tci_uint64(regs[r5], regs[r4]);
             tci_write_reg64(regs, r1, r0, T1 - T2);
             break;
-#endif
         case INDEX_op_mulu2_i32:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
             tmp64 = (uint64_t)(uint32_t)regs[r2] * (uint32_t)regs[r3];
@@ -778,7 +774,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
             muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
             break;
-#if TCG_TARGET_HAS_add2_i64
         case INDEX_op_add2_i64:
             tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
             T1 = regs[r2] + regs[r4];
@@ -786,8 +781,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = T1;
             regs[r1] = T2;
             break;
-#endif
-#if TCG_TARGET_HAS_add2_i64
         case INDEX_op_sub2_i64:
             tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
             T1 = regs[r2] - regs[r4];
@@ -795,7 +788,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = T1;
             regs[r1] = T2;
             break;
-#endif
 
             /* Shift/rotate operations (64 bit). */
 
-- 
2.43.0


