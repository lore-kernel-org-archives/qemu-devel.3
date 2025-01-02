Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EC4E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbh-00079t-HU; Thu, 02 Jan 2025 13:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbO-00070k-5w
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:26 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbL-0005Aw-HO
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:21 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216281bc30fso182968245ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841238; x=1736446038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ao/ZcsNyzkku4Sf0eHWLMDWswHRTIo2fa6ltaDkIns0=;
 b=FsW+c+B5BibwlOh+WeSO+S4P8TqzdAIqnoq/NEkGKbziUfWezE5W6znkAv3jjBZOI7
 LDsYCChcd7qkqP4vB+3P2miHM4UkpVguNLKmXlyyadiENsrAjXm78jkjTqMz1Eqd1VeG
 K5WWg31Y3HC3jYTiJPt4e4JrSCpD0S/7dPBc38kBliuIPWnwy5wSA9iBWuN1k5RJGu03
 JYy7J6M7b6rW9WnHyFhjaaAM54WHOMdTqvCGvmlFAS4RGF0S6d4gdEWXCZN+EnFwu6TO
 T2VvT4DaKdt6cefmYW0p9J9SxZRxUxIYpYEr9j5tkskjzl5JBZ4Zm4OaoO4ijnRGUr4E
 xMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841238; x=1736446038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ao/ZcsNyzkku4Sf0eHWLMDWswHRTIo2fa6ltaDkIns0=;
 b=DrCO60tfW81co5BxE/2T8VCjLxIkdyj8EO7Z1sqX9qAzLJDC6onSC1y9NXLiABUDQl
 G3nqxNJgDGsNYphhr1eqfgYoIrL9zgg860CNnQyinRx9IIXvJOGoyFozVtz8pgLS9tKd
 Lh6glRI3xEUi8I54S7DlhvDZU44YhV/Uu4OAC7Q0Jj3Raz2pu/bHUv/J2FdAaBkuhjxb
 dmOjGYpX9CkVI77SwSbq/EA1hnIWPFuNyl76lzkx2oy+qssdYZAcKDADuMgXGeRHHRiD
 mucV0bkRI60QzobDpNmL0VqGFgOFhErAVbfPFzSvlPJu+Z0b7ZvcOI6mLyWf0rvYN2z+
 Yf+g==
X-Gm-Message-State: AOJu0Yyjhcs3iCSt+O38EgRohdwgynAaIqdjJOp9A9QkpVAgh7oRkfhT
 4+E2ng5JUNg6bDq3TYEe34G3OUtmYKddpxcfGJGhLSZxxtT/4lgeYBBrl7g6e27MlVA+IV3goyA
 o
X-Gm-Gg: ASbGncvnUmbc60MyVe+rpjaKp2q2363s9PgOQYSOMAnUYkMQDnGVEOE6uwe301ArXn+
 +H35p8f1cHAwmxr0ql2Lqu0ukvdsCVYsthXW3z4oh1GKqq5aTA/tQKvZ4XFNsrcRBzWTLO7DPC3
 i+fLRw/YodbNDc0g2OeBI/FgvjXfI4hriMSZBv+S4GvKstzb4Zh8YuqiFPNZojv/7oGrBBbKKQ+
 2uPTxQyoni46H9WncRRZ+4q4PuSsxEnRwzAr8fn6f4WfvsTRLjLmcpUbpdsQw==
X-Google-Smtp-Source: AGHT+IEbeVEnQ2+AW+f15FIq5/TqnJfqHhGtI5gGw8vC0VWnyDD0svt5z0u/vTZYqDD5q/2wYpUnCQ==
X-Received: by 2002:a05:6a20:c907:b0:1e0:e07f:2f01 with SMTP id
 adf61e73a8af0-1e5df939d84mr63729312637.0.1735841238135; 
 Thu, 02 Jan 2025 10:07:18 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/73] tcg: Merge TCG_TARGET_HAS_negsetcond_{i32,i64}
Date: Thu,  2 Jan 2025 10:06:09 -0800
Message-ID: <20250102180654.1420056-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            | 4 ++--
 tcg/aarch64/tcg-target-has.h     | 3 +--
 tcg/arm/tcg-target-has.h         | 2 +-
 tcg/i386/tcg-target-has.h        | 3 +--
 tcg/loongarch64/tcg-target-has.h | 3 +--
 tcg/mips/tcg-target-has.h        | 4 +---
 tcg/ppc/tcg-target-has.h         | 3 +--
 tcg/riscv/tcg-target-has.h       | 3 +--
 tcg/s390x/tcg-target-has.h       | 3 +--
 tcg/sparc64/tcg-target-has.h     | 3 +--
 tcg/tcg-has.h                    | 1 -
 tcg/tci/tcg-target-has.h         | 3 +--
 tcg/optimize.c                   | 4 ++--
 tcg/tcg-op.c                     | 6 +++---
 tcg/tcg.c                        | 4 ++--
 15 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 4861b47f56..beebba7c52 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -46,7 +46,7 @@ DEF(mb, 0, 0, 1, 0)
 
 DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i32, 1, 2, 1, 0)
-DEF(negsetcond_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_negsetcond_i32))
+DEF(negsetcond_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32)))
 DEF(movcond_i32, 1, 4, 1, 0)
 /* load/store */
 DEF(ld8u_i32, 1, 1, 1, 0)
@@ -112,7 +112,7 @@ DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop(TCG_TYPE_I32)))
 
 DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, IMPL64)
-DEF(negsetcond_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_negsetcond_i64))
+DEF(negsetcond_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_negsetcond(TCG_TYPE_I64)))
 DEF(movcond_i64, 1, 4, 1, IMPL64)
 /* load/store */
 DEF(ld8u_i64, 1, 1, 1, IMPL64)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 67c61fef9a..bba3694338 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -23,6 +23,7 @@
 #define TCG_TARGET_HAS_mulu2(T)         0
 #define TCG_TARGET_HAS_mulsh(T)         (T == TCG_TYPE_I64)
 #define TCG_TARGET_HAS_muluh(T)         (T == TCG_TYPE_I64)
+#define TCG_TARGET_HAS_negsetcond(T)    1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          1
@@ -43,7 +44,6 @@
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -57,7 +57,6 @@
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     1
-#define TCG_TARGET_HAS_negsetcond_i64   1
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index dabb8249f1..cd9b68a024 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -34,6 +34,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_mulu2(T)         1
 #define TCG_TARGET_HAS_mulsh(T)         0
 #define TCG_TARGET_HAS_muluh(T)         0
+#define TCG_TARGET_HAS_negsetcond(T)    1
 #define TCG_TARGET_HAS_rem(T)           0
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          1
@@ -54,7 +55,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
 #define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index b1d28054a9..da99f64421 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -36,6 +36,7 @@
 #define TCG_TARGET_HAS_mulu2(T)         1
 #define TCG_TARGET_HAS_mulsh(T)         0
 #define TCG_TARGET_HAS_muluh(T)         0
+#define TCG_TARGET_HAS_negsetcond(T)    1
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          1
 
@@ -55,7 +56,6 @@
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_negsetcond_i32   1
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
@@ -70,7 +70,6 @@
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     1
-#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index b2fea0f2e1..2716f9d0bc 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -20,6 +20,7 @@
 #define TCG_TARGET_HAS_mulu2(T)         0
 #define TCG_TARGET_HAS_mulsh(T)         1
 #define TCG_TARGET_HAS_muluh(T)         1
+#define TCG_TARGET_HAS_negsetcond(T)    0
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          0
@@ -32,7 +33,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -46,7 +46,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
-#define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index a81e54ff8d..d01f74a48f 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -49,6 +49,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_mulu2(T)         (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_mulsh(T)         1
 #define TCG_TARGET_HAS_muluh(T)         1
+#define TCG_TARGET_HAS_negsetcond(T)    0
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           use_mips32r2_instructions
 #define TCG_TARGET_HAS_sub2(T)          (TCG_TARGET_REG_BITS == 32)
@@ -62,13 +63,10 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           0
 
-#define TCG_TARGET_HAS_negsetcond_i32   0
-
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_negsetcond_i64   0
 #endif
 
 /* optional instructions detected at runtime */
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 96d7806ee0..fba392613b 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -27,6 +27,7 @@
 #define TCG_TARGET_HAS_mulu2(T)         0
 #define TCG_TARGET_HAS_mulsh(T)         1
 #define TCG_TARGET_HAS_muluh(T)         1
+#define TCG_TARGET_HAS_negsetcond(T)    1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          (T == TCG_TYPE_REG)
@@ -49,7 +50,6 @@
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -64,7 +64,6 @@
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   1
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 4707bff7a8..08096d0625 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -20,6 +20,7 @@
 #define TCG_TARGET_HAS_mulu2(T)         0
 #define TCG_TARGET_HAS_mulsh(T)         (T == TCG_TYPE_I64)
 #define TCG_TARGET_HAS_muluh(T)         (T == TCG_TYPE_I64)
+#define TCG_TARGET_HAS_negsetcond(T)    1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_sub2(T)          1
@@ -32,7 +33,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
 
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -45,7 +45,6 @@
 #define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index fe3e77107f..93f1a67bd1 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -39,6 +39,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_mulu2(T)       (T == TCG_TYPE_I64)
 #define TCG_TARGET_HAS_mulsh(T)       0
 #define TCG_TARGET_HAS_muluh(T)       0
+#define TCG_TARGET_HAS_negsetcond(T)  1
 #define TCG_TARGET_HAS_rot(T)         1
 #define TCG_TARGET_HAS_sub2(T)        1
 
@@ -58,7 +59,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_extract_i32    1
 #define TCG_TARGET_HAS_sextract_i32   0
 #define TCG_TARGET_HAS_extract2_i32   0
-#define TCG_TARGET_HAS_negsetcond_i32 1
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
@@ -72,7 +72,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_extract_i64    1
 #define TCG_TARGET_HAS_sextract_i64   0
 #define TCG_TARGET_HAS_extract2_i64   0
-#define TCG_TARGET_HAS_negsetcond_i64 1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index d6376a1b8d..188201eb80 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -24,6 +24,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_mulu2(T)         (T == TCG_TYPE_I32)
 #define TCG_TARGET_HAS_mulsh(T)         0
 #define TCG_TARGET_HAS_muluh(T)         (T == TCG_TYPE_I64 && use_vis3_instructions)
+#define TCG_TARGET_HAS_negsetcond(T)    1
 #define TCG_TARGET_HAS_rem(T)           0
 #define TCG_TARGET_HAS_rot(T)           0
 #define TCG_TARGET_HAS_sub2(T)          1
@@ -44,7 +45,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
@@ -58,7 +58,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 56f9725122..88e8cedab6 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -22,7 +22,6 @@
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   0
 #endif
 
 #ifndef TCG_TARGET_deposit_i32_valid
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 27d48670e8..d6073dc743 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -18,6 +18,7 @@
 #define TCG_TARGET_HAS_mulu2(T)         1
 #define TCG_TARGET_HAS_mulsh(T)         0
 #define TCG_TARGET_HAS_muluh(T)         0
+#define TCG_TARGET_HAS_negsetcond(T)    0
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          1
@@ -38,7 +39,6 @@
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -53,7 +53,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_negsetcond_i64   0
 #endif /* TCG_TARGET_REG_BITS == 64 */
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8e3141eb77..6cb2232d74 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2004,7 +2004,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         switch (ctx->type) {
         case TCG_TYPE_I32:
             opc = INDEX_op_setcond_i32;
-            if (TCG_TARGET_HAS_negsetcond_i32) {
+            if (TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32)) {
                 negopc = INDEX_op_negsetcond_i32;
             }
             tv = (int32_t)tv;
@@ -2012,7 +2012,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
             break;
         case TCG_TYPE_I64:
             opc = INDEX_op_setcond_i64;
-            if (TCG_TARGET_HAS_negsetcond_i64) {
+            if (TCG_TARGET_HAS_negsetcond(TCG_TYPE_I64)) {
                 negopc = INDEX_op_negsetcond_i64;
             }
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index dde9734615..c8892794c8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -560,7 +560,7 @@ void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
         tcg_gen_movi_i32(ret, -1);
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_movi_i32(ret, 0);
-    } else if (TCG_TARGET_HAS_negsetcond_i32) {
+    } else if (TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32)) {
         tcg_gen_op4i_i32(INDEX_op_negsetcond_i32, ret, arg1, arg2, cond);
     } else {
         tcg_gen_setcond_i32(cond, ret, arg1, arg2);
@@ -2024,14 +2024,14 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
         tcg_gen_movi_i64(ret, -1);
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_movi_i64(ret, 0);
-    } else if (TCG_TARGET_HAS_negsetcond_i64) {
-        tcg_gen_op4i_i64(INDEX_op_negsetcond_i64, ret, arg1, arg2, cond);
     } else if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_op6i_i32(INDEX_op_setcond2_i32, TCGV_LOW(ret),
                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
                          TCGV_LOW(arg2), TCGV_HIGH(arg2), cond);
         tcg_gen_neg_i32(TCGV_LOW(ret), TCGV_LOW(ret));
         tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_LOW(ret));
+    } else if (TCG_TARGET_HAS_negsetcond(TCG_TYPE_I64)) {
+        tcg_gen_op4i_i64(INDEX_op_negsetcond_i64, ret, arg1, arg2, cond);
     } else {
         tcg_gen_setcond_i64(cond, ret, arg1, arg2);
         tcg_gen_neg_i64(ret, ret);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b7ac97efcc..f8f9f7d9f2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2209,7 +2209,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return true;
 
     case INDEX_op_negsetcond_i32:
-        return TCG_TARGET_HAS_negsetcond_i32;
+        return TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32);
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
         return TCG_TARGET_HAS_div(TCG_TYPE_I32);
@@ -2306,7 +2306,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_REG_BITS == 64;
 
     case INDEX_op_negsetcond_i64:
-        return TCG_TARGET_HAS_negsetcond_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_negsetcond(TCG_TYPE_I64);
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_div(TCG_TYPE_I64);
-- 
2.43.0


