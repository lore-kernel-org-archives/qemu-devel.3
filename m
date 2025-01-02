Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6EEE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbq-0007bQ-51; Thu, 02 Jan 2025 13:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbM-00070d-Cd
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:23 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbJ-0005AP-6T
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:20 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21631789fcdso118436095ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841235; x=1736446035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3C9I9yq422os5GioorvqGiqZWB6D/gcJKS+r5Qx8OBo=;
 b=lgyT8rj8NMI5U1rbsI3/5lZmCgKwmxcmj6AvScSP0SS4I+cnpWEjIVRciCvKw9KycG
 9RqdXf3Dv3yDzGAitZeL7IzDxqQnT+eTgIxXECFxy6e7RdVasATeSywonWZKBmO0Y7vE
 yUAC8ZOIIs2cJE/s0m+nEmO7HkT6GMpNvO4fSkLfdeLSX4I6nYmW5hvxfc5ufH20XLNW
 TMWF+wkDmVmUvHGn6B9zDjleBAsMDTmIVF83bRTtwBp3YTuCUvgKSHRhDFKPjonXWlRY
 kPBgHdFCAZFfZaVR3F0Var4EmVj4XgGXAGGswzzYFiIaOb67DBjqHfbhe1BrfXsos0Jq
 TjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841235; x=1736446035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3C9I9yq422os5GioorvqGiqZWB6D/gcJKS+r5Qx8OBo=;
 b=ZpMC3V8UwgjE69ZOOAPwKElxuhCN2angtXrh7FynNZ2epG59r1jCQ/AZCzirm9mxai
 wi9pXyYVGyfZUm2VEy9DvyublhGGsyP7ubuw3DcZ+/A7ixd0m/d4dblMO+RP11YPtNQ3
 3iX1Bh/EfLCoFieLbhmmX/7XwxUeJA+TPrbYRuwgJmjUN/OmkDpYV2JXvTTO/U39nwKS
 lpC0pksGueke5SKs+UMoFWP/rPJikt4Hhs/z4WQReXkBM2DS9Fh5DRttmMCP8FdZjpRK
 5QlUNuz9Eeve5WMZ6Njk/Pd+uttjYef/35up3BBl33TuttMe8RXLulOnYBzEdTLI+6n0
 chaQ==
X-Gm-Message-State: AOJu0YzWnUoXyXEPlotDffFye2GEm5fqXuOuoDiHDFwKdzWxsMmYRjoV
 IoN0XF3JDWg5PkBHuByayaDHUeJHRicStIe5ifU5GvrkUBiIVfWYiVO6Ck/qwG6h/YMGRt8R2Uz
 7
X-Gm-Gg: ASbGncvxLHME+3KN8lmczmtsc8G1ZjjrBv0BWkE+L1LBo5yOmF17Fkg6VPYjYIELSXz
 TxAvg8zX1rluAl9Hi8urxhHlO2QsVRA31a64z9N2f9xRUEKVvAoKik7r57C80F3mWY8ohpOij3o
 /+SX2dovoF6Q8ZOVh/fEu7pidvdL5zkDOFze9YHkciV6qqO9GsFYLdm8rpsEMAD+Mgtne+ngPQg
 A79k6o1AAqPGb1o1Nb74/MkIWIIJEHkyvjeaDOS9783rgTS871ftg+ftaQV0Q==
X-Google-Smtp-Source: AGHT+IFMNZh3GmmUCxixw2uQx25FRB3U5O/7jyo9kr0o5PlXW2AwYP34uBsn2oVspUVnznrEeiG53A==
X-Received: by 2002:aa7:85d3:0:b0:727:39a4:30cc with SMTP id
 d2e1a72fcca58-72aa9a106acmr71897947b3a.1.1735841235039; 
 Thu, 02 Jan 2025 10:07:15 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/73] tcg: Merge TCG_TARGET_HAS_rot_{i32,i64}
Date: Thu,  2 Jan 2025 10:06:05 -0800
Message-ID: <20250102180654.1420056-26-richard.henderson@linaro.org>
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

Only the integer opcodes handled here; the vector rotates
are left for a future patch, as they are split by immediate,
scalar, and vector shift count.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  8 ++++----
 tcg/aarch64/tcg-target-has.h     |  3 +--
 tcg/arm/tcg-target-has.h         |  2 +-
 tcg/i386/tcg-target-has.h        |  3 +--
 tcg/loongarch64/tcg-target-has.h |  3 +--
 tcg/mips/tcg-target-has.h        |  3 +--
 tcg/ppc/tcg-target-has.h         |  3 +--
 tcg/riscv/tcg-target-has.h       |  3 +--
 tcg/s390x/tcg-target-has.h       |  3 +--
 tcg/sparc64/tcg-target-has.h     |  3 +--
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  3 +--
 tcg/tcg-op.c                     | 15 +++++++++------
 tcg/tcg.c                        |  4 ++--
 tcg/tci.c                        |  4 ----
 15 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index cbc8b358f6..511dd04b39 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -74,8 +74,8 @@ DEF(xor_i32, 1, 2, 0, 0)
 DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
 DEF(sar_i32, 1, 2, 0, 0)
-DEF(rotl_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot_i32))
-DEF(rotr_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot_i32))
+DEF(rotl_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I32)))
+DEF(rotr_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I32)))
 DEF(deposit_i32, 1, 2, 2, IMPL(TCG_TARGET_HAS_deposit_i32))
 DEF(extract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_extract_i32))
 DEF(sextract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_sextract_i32))
@@ -143,8 +143,8 @@ DEF(xor_i64, 1, 2, 0, IMPL64)
 DEF(shl_i64, 1, 2, 0, IMPL64)
 DEF(shr_i64, 1, 2, 0, IMPL64)
 DEF(sar_i64, 1, 2, 0, IMPL64)
-DEF(rotl_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot_i64))
-DEF(rotr_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot_i64))
+DEF(rotl_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I64)))
+DEF(rotr_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I64)))
 DEF(deposit_i64, 1, 2, 2, IMPL64 | IMPL(TCG_TARGET_HAS_deposit_i64))
 DEF(extract_i64, 1, 1, 2, IMPL64 | IMPL(TCG_TARGET_HAS_extract_i64))
 DEF(sextract_i64, 1, 1, 2, IMPL64 | IMPL(TCG_TARGET_HAS_sextract_i64))
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 128d1dc7c9..fcf4b68454 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -16,6 +16,7 @@
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
+#define TCG_TARGET_HAS_rot(T)           1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -29,7 +30,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -53,7 +53,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 69579e8fb0..1bc6081e17 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -27,6 +27,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           use_idiv_instructions
 #define TCG_TARGET_HAS_rem(T)           0
+#define TCG_TARGET_HAS_rot(T)           1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -40,7 +41,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
 #define TCG_TARGET_HAS_ctpop_i32        0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index fcd10fde95..ba6c9ff71a 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -28,6 +28,7 @@
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div2(T)          1
+#define TCG_TARGET_HAS_rot(T)           1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          (T >= TCG_TYPE_V64 || have_bmi1)
@@ -37,7 +38,6 @@
 #define TCG_TARGET_HAS_not(T)           (T <= TCG_TYPE_REG || have_avx512vl)
 #define TCG_TARGET_HAS_orc(T)           (T >= TCG_TYPE_V64 && have_avx512vl)
 
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
@@ -60,7 +60,6 @@
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 36d3dbc00b..0f15c678ce 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -13,6 +13,7 @@
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
+#define TCG_TARGET_HAS_rot(T)           1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -23,7 +24,6 @@
 #define TCG_TARGET_HAS_orc(T)           1
 
 #define TCG_TARGET_HAS_negsetcond_i32   0
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -47,7 +47,6 @@
 
 /* 64-bit operations */
 #define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index d17d464b8b..14d8609d73 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -42,6 +42,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
+#define TCG_TARGET_HAS_rot(T)           use_mips32r2_instructions
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          0
@@ -79,7 +80,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
-#define TCG_TARGET_HAS_rot_i32          use_mips32r2_instructions
 #define TCG_TARGET_HAS_clz_i32          use_mips32r2_instructions
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -92,7 +92,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
-#define TCG_TARGET_HAS_rot_i64          use_mips32r2_instructions
 #define TCG_TARGET_HAS_clz_i64          use_mips32r2_instructions
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 8ddf606d63..68c7ff70c9 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -20,6 +20,7 @@
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
+#define TCG_TARGET_HAS_rot(T)           1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -33,7 +34,6 @@
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
 #define TCG_TARGET_HAS_ext16u_i32       0
 
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_clz_i32          1
@@ -54,7 +54,6 @@
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 32edc4e484..abc806ce4b 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -13,6 +13,7 @@
 #define TCG_TARGET_HAS_bswap(T)         (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
+#define TCG_TARGET_HAS_rot(T)           (cpuinfo & CPUINFO_ZBB)
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
@@ -23,7 +24,6 @@
 #define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
 
 #define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -46,7 +46,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index ba83f64e76..543fd146b3 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -31,6 +31,7 @@ extern uint64_t s390_facilities[3];
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)       1
 #define TCG_TARGET_HAS_div2(T)        1
+#define TCG_TARGET_HAS_rot(T)         1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)        (T >= TCG_TYPE_V64 || HAVE_FACILITY(MISC_INSN_EXT3))
@@ -40,7 +41,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_not(T)         (T >= TCG_TYPE_V64 || HAVE_FACILITY(MISC_INSN_EXT3))
 #define TCG_TARGET_HAS_orc(T)         (T >= TCG_TYPE_V64 ? HAVE_FACILITY(VECTOR_ENH1) : HAVE_FACILITY(MISC_INSN_EXT3))
 
-#define TCG_TARGET_HAS_rot_i32        1
 #define TCG_TARGET_HAS_ext8s_i32      1
 #define TCG_TARGET_HAS_ext16s_i32     1
 #define TCG_TARGET_HAS_ext8u_i32      1
@@ -62,7 +62,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
-#define TCG_TARGET_HAS_rot_i64        1
 #define TCG_TARGET_HAS_ext8s_i64      1
 #define TCG_TARGET_HAS_ext16s_i64     1
 #define TCG_TARGET_HAS_ext32s_i64     1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 7816a11c09..a3674cabe6 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -17,6 +17,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap(T)         0
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           0
+#define TCG_TARGET_HAS_rot(T)           0
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -26,7 +27,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_rot_i32          0
 #define TCG_TARGET_HAS_ext8s_i32        0
 #define TCG_TARGET_HAS_ext16s_i32       0
 #define TCG_TARGET_HAS_ext8u_i32        0
@@ -48,7 +48,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_rot_i64          0
 #define TCG_TARGET_HAS_ext8s_i64        0
 #define TCG_TARGET_HAS_ext16s_i64       0
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 6f04e8cf5a..074c0bcbd2 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -12,7 +12,6 @@
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_rot_i64          0
 #define TCG_TARGET_HAS_ext8s_i64        0
 #define TCG_TARGET_HAS_ext16s_i64       0
 #define TCG_TARGET_HAS_ext32s_i64       0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index bf3c454255..28e413d5dc 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -11,6 +11,7 @@
 #define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
+#define TCG_TARGET_HAS_rot(T)           1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -31,7 +32,6 @@
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        1
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
@@ -53,7 +53,6 @@
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
-#define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_muls2_i64        1
 #define TCG_TARGET_HAS_add2_i32         1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2923a33cf6..8cfaad0ece 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -820,7 +820,7 @@ void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
 
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i32) {
+    if (TCG_TARGET_HAS_rot(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, arg2);
     } else {
         TCGv_i32 t0, t1;
@@ -842,7 +842,7 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
-    } else if (TCG_TARGET_HAS_rot_i32) {
+    } else if (TCG_TARGET_HAS_rot(TCG_TYPE_I32)) {
         tcg_gen_rotl_i32(ret, arg1, tcg_constant_i32(arg2));
     } else {
         TCGv_i32 t0, t1;
@@ -858,7 +858,7 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i32) {
+    if (TCG_TARGET_HAS_rot(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, arg2);
     } else {
         TCGv_i32 t0, t1;
@@ -2580,7 +2580,8 @@ void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
 
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i64) {
+    if (TCG_TARGET_REG_BITS == 64 &&
+        TCG_TARGET_HAS_rot(TCG_TYPE_I64)) {
         tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, arg2);
     } else {
         TCGv_i64 t0, t1;
@@ -2601,7 +2602,8 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
-    } else if (TCG_TARGET_HAS_rot_i64) {
+    } else if (TCG_TARGET_REG_BITS == 64 &&
+               TCG_TARGET_HAS_rot(TCG_TYPE_I64)) {
         tcg_gen_rotl_i64(ret, arg1, tcg_constant_i64(arg2));
     } else {
         TCGv_i64 t0, t1;
@@ -2617,7 +2619,8 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i64) {
+    if (TCG_TARGET_REG_BITS == 64 &&
+        TCG_TARGET_HAS_rot(TCG_TYPE_I64)) {
         tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, arg2);
     } else {
         TCGv_i64 t0, t1;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d3ede3e6ab..0f3e03b7f5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2221,7 +2221,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_HAS_div2(TCG_TYPE_I32);
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-        return TCG_TARGET_HAS_rot_i32;
+        return TCG_TARGET_HAS_rot(TCG_TYPE_I32);
     case INDEX_op_deposit_i32:
         return TCG_TARGET_HAS_deposit_i32;
     case INDEX_op_extract_i32:
@@ -2318,7 +2318,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_div2(TCG_TYPE_I64);
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
-        return TCG_TARGET_HAS_rot_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_rot(TCG_TYPE_I64);
     case INDEX_op_deposit_i64:
         return TCG_TARGET_HAS_deposit_i64;
     case INDEX_op_extract_i64:
diff --git a/tcg/tci.c b/tcg/tci.c
index e2926bce61..54838650b7 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -631,7 +631,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int32_t)regs[r1] >> (regs[r2] & 31);
             break;
-#if TCG_TARGET_HAS_rot_i32
         case INDEX_op_rotl_i32:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = rol32(regs[r1], regs[r2] & 31);
@@ -640,7 +639,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ror32(regs[r1], regs[r2] & 31);
             break;
-#endif
 #if TCG_TARGET_HAS_deposit_i32
         case INDEX_op_deposit_i32:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
@@ -833,7 +831,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int64_t)regs[r1] >> (regs[r2] & 63);
             break;
-#if TCG_TARGET_HAS_rot_i64
         case INDEX_op_rotl_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = rol64(regs[r1], regs[r2] & 63);
@@ -842,7 +839,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ror64(regs[r1], regs[r2] & 63);
             break;
-#endif
 #if TCG_TARGET_HAS_deposit_i64
         case INDEX_op_deposit_i64:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
-- 
2.43.0


