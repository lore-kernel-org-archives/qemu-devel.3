Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790EFC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjntQ-0002ys-MW; Sun, 16 Feb 2025 18:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt6-00021v-QR
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:26 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt1-00060L-TC
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:23 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22128b7d587so7779795ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747838; x=1740352638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j4jaSPEFIeBqbbyLO5//Sf/+Lt/C1TIlJP+shr8NNvU=;
 b=HQ/AMNqvaeq8lvATo8/xArBDziRMC92IaepZJWa8MBKW7aqDvki9de+21JZJDLWWY1
 am3wMeuqL1cWhX6ZupwtAWfYi/Yz8qdChKRslhkPfA66a0MimMQMRPUXJof7nqevoGy1
 D/oAMPIhxL9PMucM4wY4zktN450NhUq1DB7wcPhSwtrBqoW396aO61vVQn9fCrYPdOrW
 zXEjB/TgBSng5JtbeeCqqr/FCxt13GJtqIIwxlmd42QCYtddWnUT6xd62Q8GrkS7AMQ2
 VyBnUK+E3if/uNXVIOmF8SpURvwJkYU+D2BO9FFIMlmNQooqgE+CEuwov3TP483+EXv2
 Xl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747838; x=1740352638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4jaSPEFIeBqbbyLO5//Sf/+Lt/C1TIlJP+shr8NNvU=;
 b=a3UlmYAf2oLnLDNRSFKHOTew7o4GrX7/zwvWW0FfJltN0lxChwyaAGDyDWlW5m2xfY
 /vHpgln3tcpoSuXE9XvxX2EY9coU5XVqWNO+9d5yNBxyr4t9AI/jXj1YRNdJV/FlvDEY
 DObQGDFgaGm+yoYrnohzdQL7F4w5nw6NM9qGV+shN5YofTixN3waI7qK4MiUhb8WMvUX
 uv0DjqzGGw9nN4Or6qCrFPGzlzCqFyf2WvpVWhgBnmbB1tD1GzZ1FfuE5ZTpPcyIG3we
 fDbxLkT18Lnh8svfAdS8mXV+50ABU9PRz86jlK4/DM6m0ZdTZ4YQ9+KB1gBmBf+46Okt
 9IKA==
X-Gm-Message-State: AOJu0Yzs0olVK8in25Fhv68lX+p/ZqgwbkNWzR6XuOudJ1ugbOPIdvu2
 rzJ4dALXYSL78CYPI2smz8DEyRhGYVZyw20K8OL0ay0ENKfsYA9j5NvOU40jhtdi3AZhxTaKmvo
 u
X-Gm-Gg: ASbGncuElf7dJwiJp4oVJlk9ifI9/32nIb7q1xOzDQpOfTaIcierd+nrbFJI01O12oy
 KocZAQcJ7CBSGoslrC3S/iSYfoRv9N/r6gY8TjR7rm9LJ7gTjBtxOO65VYAKbpnTQcAOHovaKVG
 +w2nGT8ySTGgmLzXIREpmYKjA3W/zH0GmYWFIAqVzRmIoa6y0kX7Da5SAX97K2bAMjqRhm2DE4o
 Syg8LX36iK2OO/ryP3YHnjF7AO+jgc7IjGhi07PG1bL/o8aK6TvxyTAJcmrJH2xwF6XbM18pOE0
 PyKJ5KNAEJVi8EHeBpk1jlzgweN7eTIZI3VDdelDUtwj9SM=
X-Google-Smtp-Source: AGHT+IE6Ila7SV1s6VTEUBE6Gt4smq/Wp1BOcfVFVDyKDooJ9vXuz1rr522QqtdPNprtWFvXESst2g==
X-Received: by 2002:a17:903:230f:b0:220:c4e8:3b9d with SMTP id
 d9443c01a7336-221040ac0eemr112016785ad.37.1739747837955; 
 Sun, 16 Feb 2025 15:17:17 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 086/162] tcg: Convert bswap16 to TCGOutOpBswap
Date: Sun, 16 Feb 2025 15:08:55 -0800
Message-ID: <20250216231012.2808572-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 tcg/aarch64/tcg-target-has.h     |  2 -
 tcg/arm/tcg-target-has.h         |  1 -
 tcg/i386/tcg-target-has.h        |  2 -
 tcg/loongarch64/tcg-target-has.h |  2 -
 tcg/mips/tcg-target-has.h        |  2 -
 tcg/ppc/tcg-target-has.h         |  2 -
 tcg/riscv/tcg-target-has.h       |  2 -
 tcg/s390x/tcg-target-has.h       |  2 -
 tcg/sparc64/tcg-target-has.h     |  2 -
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 -
 tcg/tcg-op.c                     |  4 +-
 tcg/tcg.c                        | 23 ++++++++--
 tcg/tci.c                        |  2 -
 tcg/aarch64/tcg-target.c.inc     | 30 +++++++------
 tcg/arm/tcg-target.c.inc         | 42 +++++++++---------
 tcg/i386/tcg-target.c.inc        | 48 +++++++++++---------
 tcg/loongarch64/tcg-target.c.inc | 28 +++++++-----
 tcg/mips/tcg-target.c.inc        | 74 +++++++++++++++----------------
 tcg/ppc/tcg-target.c.inc         | 76 ++++++++++++++++----------------
 tcg/riscv/tcg-target.c.inc       | 33 +++++++++-----
 tcg/s390x/tcg-target.c.inc       | 40 ++++++++---------
 tcg/sparc64/tcg-target.c.inc     |  4 ++
 tcg/tci/tcg-target.c.inc         | 21 ++++++---
 24 files changed, 235 insertions(+), 210 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 22a574e703..4797409467 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -13,7 +13,6 @@
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -21,7 +20,6 @@
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index bfa3be8028..5972def558 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,7 +24,6 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index aaf8764cc9..fd44ed8168 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,7 +26,6 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -35,7 +34,6 @@
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 90f0a131ae..11a93afd8b 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -13,14 +13,12 @@
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
-#define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_add2_i64         0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index c6cecba28b..6c967d9c9f 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -39,7 +39,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 
 #if TCG_TARGET_REG_BITS == 64
@@ -57,7 +56,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 5c4fc2bc34..b73fca9789 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -17,7 +17,6 @@
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -26,7 +25,6 @@
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index e18b5cb8ec..85bb5cd591 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -13,13 +13,11 @@
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 41cd8a1d0d..6cd92fa240 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -29,7 +29,6 @@ extern uint64_t s390_facilities[3];
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_add2_i32       1
@@ -37,7 +36,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
-#define TCG_TARGET_HAS_bswap16_i64    1
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_extract2_i64   0
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 6ed27b8fcc..eb1e16c0e2 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,7 +14,6 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
@@ -22,7 +21,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 315dfd05aa..3d1c805d59 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -12,7 +12,6 @@
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index f45a0688f9..d7228246ab 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -7,14 +7,12 @@
 #ifndef TCG_TARGET_HAS_H
 #define TCG_TARGET_HAS_H
 
-#define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3527952c66..c5b3bc8148 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1257,7 +1257,7 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
 
-    if (TCG_TARGET_HAS_bswap16_i32) {
+    if (tcg_op_supported(INDEX_op_bswap16_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3i_i32(INDEX_op_bswap16_i32, ret, arg, flags);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2087,7 +2087,7 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         } else {
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         }
-    } else if (TCG_TARGET_HAS_bswap16_i64) {
+    } else if (tcg_op_supported(INDEX_op_bswap16_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3i_i64(INDEX_op_bswap16_i64, ret, arg, flags);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d920a3158e..d4635d510f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1001,6 +1001,12 @@ typedef struct TCGOutOpBrcond2 {
                 TCGArg bh, bool const_bh, TCGLabel *l);
 } TCGOutOpBrcond2;
 
+typedef struct TCGOutOpBswap {
+    TCGOutOp base;
+    void (*out_rr)(TCGContext *s, TCGType type,
+                   TCGReg a0, TCGReg a1, unsigned flags);
+} TCGOutOpBswap;
+
 typedef struct TCGOutOpDivRem {
     TCGOutOp base;
     void (*out_rr01r)(TCGContext *s, TCGType type,
@@ -1069,6 +1075,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_brcond, TCGOutOpBrcond, outop_brcond),
+    OUTOP(INDEX_op_bswap16_i32, TCGOutOpBswap, outop_bswap16),
+    OUTOP(INDEX_op_bswap16_i64, TCGOutOpBswap, outop_bswap16),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
@@ -2335,8 +2343,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_add2_i32;
     case INDEX_op_sub2_i32:
         return TCG_TARGET_HAS_sub2_i32;
-    case INDEX_op_bswap16_i32:
-        return TCG_TARGET_HAS_bswap16_i32;
     case INDEX_op_bswap32_i32:
         return TCG_TARGET_HAS_bswap32_i32;
 
@@ -2367,8 +2373,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return TCG_TARGET_HAS_extr_i64_i32;
-    case INDEX_op_bswap16_i64:
-        return TCG_TARGET_HAS_bswap16_i64;
     case INDEX_op_bswap32_i64:
         return TCG_TARGET_HAS_bswap32_i64;
     case INDEX_op_bswap64_i64:
@@ -5473,6 +5477,17 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap16_i64:
+        {
+            const TCGOutOpBswap *out =
+                container_of(all_outop[op->opc], TCGOutOpBswap, base);
+
+            tcg_debug_assert(!const_args[1]);
+            out->out_rr(s, type, new_args[0], new_args[1], new_args[2]);
+        }
+        break;
+
     case INDEX_op_divs2:
     case INDEX_op_divu2:
         {
diff --git a/tcg/tci.c b/tcg/tci.c
index 9c3f58242e..ae447e91bd 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -686,12 +686,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_write_reg64(regs, r1, r0, T1 - T2);
             break;
 #endif
-#if TCG_TARGET_HAS_bswap16_i32 || TCG_TARGET_HAS_bswap16_i64
         CASE_32_64(bswap16)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap16(regs[r1]);
             break;
-#endif
 #if TCG_TARGET_HAS_bswap32_i32 || TCG_TARGET_HAS_bswap32_i64
         CASE_32_64(bswap32)
             tci_args_rr(insn, &r0, &r1);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index ee45e7e244..03961b34aa 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2438,6 +2438,23 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_bswap16(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_rev(s, TCG_TYPE_I32, MO_16, a0, a1);
+    if (flags & TCG_BSWAP_OS) {
+        /* Output must be sign-extended. */
+        tcg_out_ext16s(s, type, a0, a0);
+    } else if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
+        /* Output must be zero-extended, but input isn't. */
+        tcg_out_ext16u(s, a0, a0);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap16,
+};
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
@@ -2618,17 +2635,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     case INDEX_op_bswap32_i32:
         tcg_out_rev(s, TCG_TYPE_I32, MO_32, a0, a1);
         break;
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap16_i32:
-        tcg_out_rev(s, TCG_TYPE_I32, MO_16, a0, a1);
-        if (a2 & TCG_BSWAP_OS) {
-            /* Output must be sign-extended. */
-            tcg_out_ext16s(s, ext, a0, a0);
-        } else if ((a2 & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
-            /* Output must be zero-extended, but input isn't. */
-            tcg_out_ext16u(s, a0, a0);
-        }
-        break;
 
     case INDEX_op_deposit_i64:
     case INDEX_op_deposit_i32:
@@ -3148,9 +3154,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 884d057177..65ddedb166 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -975,23 +975,6 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rn)
     g_assert_not_reached();
 }
 
-static void tcg_out_bswap16(TCGContext *s, ARMCond cond,
-                            TCGReg rd, TCGReg rn, int flags)
-{
-    if (flags & TCG_BSWAP_OS) {
-        /* revsh */
-        tcg_out32(s, 0x06ff0fb0 | (cond << 28) | (rd << 12) | rn);
-        return;
-    }
-
-    /* rev16 */
-    tcg_out32(s, 0x06bf0fb0 | (cond << 28) | (rd << 12) | rn);
-    if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
-        /* uxth */
-        tcg_out32(s, 0x06ff0070 | (cond << 28) | (rd << 12) | rd);
-    }
-}
-
 static void tcg_out_bswap32(TCGContext *s, ARMCond cond, TCGReg rd, TCGReg rn)
 {
     /* rev */
@@ -2159,6 +2142,27 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_bswap16(TCGContext *s, TCGType type,
+                         TCGReg rd, TCGReg rn, unsigned flags)
+{
+    if (flags & TCG_BSWAP_OS) {
+        /* revsh */
+        tcg_out32(s, 0x06ff0fb0 | (COND_AL << 28) | (rd << 12) | rn);
+        return;
+    }
+
+    /* rev16 */
+    tcg_out32(s, 0x06bf0fb0 | (COND_AL << 28) | (rd << 12) | rn);
+    if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
+        tcg_out_ext16u(s, rd, rd);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap16,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_subfi(s, type, a0, 0, a1);
@@ -2380,9 +2384,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
         break;
 
-    case INDEX_op_bswap16_i32:
-        tcg_out_bswap16(s, COND_AL, args[0], args[1], args[2]);
-        break;
     case INDEX_op_bswap32_i32:
         tcg_out_bswap32(s, COND_AL, args[0], args[1]);
         break;
@@ -2443,7 +2444,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 6bd7e2663b..7caaeb1f0c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3062,6 +3062,34 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_bswap16(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+
+    if (flags & TCG_BSWAP_OS) {
+        /* Output must be sign-extended. */
+        if (rexw) {
+            tcg_out_bswap64(s, a0);
+            tcg_out_shifti(s, SHIFT_SAR + rexw, a0, 48);
+        } else {
+            tcg_out_bswap32(s, a0);
+            tcg_out_shifti(s, SHIFT_SAR, a0, 16);
+        }
+    } else if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
+        /* Output must be zero-extended, but input isn't. */
+        tcg_out_bswap32(s, a0);
+        tcg_out_shifti(s, SHIFT_SHR, a0, 16);
+    } else {
+        tcg_out_rolw_8(s, a0);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_O1_I1(r, 0),
+    .out_rr = tgen_bswap16,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
@@ -3165,24 +3193,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(bswap16):
-        if (a2 & TCG_BSWAP_OS) {
-            /* Output must be sign-extended. */
-            if (rexw) {
-                tcg_out_bswap64(s, a0);
-                tcg_out_shifti(s, SHIFT_SAR + rexw, a0, 48);
-            } else {
-                tcg_out_bswap32(s, a0);
-                tcg_out_shifti(s, SHIFT_SAR, a0, 16);
-            }
-        } else if ((a2 & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
-            /* Output must be zero-extended, but input isn't. */
-            tcg_out_bswap32(s, a0);
-            tcg_out_shifti(s, SHIFT_SHR, a0, 16);
-        } else {
-            tcg_out_rolw_8(s, a0);
-        }
-        break;
     OP_32_64(bswap32):
         tcg_out_bswap32(s, a0);
         if (rexw && (a2 & TCG_BSWAP_OS)) {
@@ -3962,8 +3972,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 6f0c241cf9..2c2b6708d3 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1723,6 +1723,22 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_bswap16(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_opc_revb_2h(s, a0, a1);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_ext16s(s, TCG_TYPE_REG, a0, a0);
+    } else if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
+        tcg_out_ext16u(s, a0, a0);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap16,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
@@ -1814,16 +1830,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_bstrins_d(s, a0, a2, args[3], args[3] + args[4] - 1);
         break;
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
-        tcg_out_opc_revb_2h(s, a0, a1);
-        if (a2 & TCG_BSWAP_OS) {
-            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a0);
-        } else if ((a2 & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
-            tcg_out_ext16u(s, a0, a0);
-        }
-        break;
-
     case INDEX_op_bswap32_i32:
         /* All 32-bit values are computed sign-extended in the register.  */
         a2 = TCG_BSWAP_OS;
@@ -2442,8 +2448,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 83a45f4a33..351174ae73 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -702,39 +702,6 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg rd, TCGReg rs,
     g_assert_not_reached();
 }
 
-static void tcg_out_bswap16(TCGContext *s, TCGReg ret, TCGReg arg, int flags)
-{
-    /* ret and arg can't be register tmp0 */
-    tcg_debug_assert(ret != TCG_TMP0);
-    tcg_debug_assert(arg != TCG_TMP0);
-
-    /* With arg = abcd: */
-    if (use_mips32r2_instructions) {
-        tcg_out_opc_reg(s, OPC_WSBH, ret, 0, arg);                 /* badc */
-        if (flags & TCG_BSWAP_OS) {
-            tcg_out_opc_reg(s, OPC_SEH, ret, 0, ret);              /* ssdc */
-        } else if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
-            tcg_out_opc_imm(s, OPC_ANDI, ret, ret, 0xffff);        /* 00dc */
-        }
-        return;
-    }
-
-    tcg_out_opc_sa(s, OPC_SRL, TCG_TMP0, arg, 8);                  /* 0abc */
-    if (!(flags & TCG_BSWAP_IZ)) {
-        tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP0, TCG_TMP0, 0x00ff);  /* 000c */
-    }
-    if (flags & TCG_BSWAP_OS) {
-        tcg_out_opc_sa(s, OPC_SLL, ret, arg, 24);                  /* d000 */
-        tcg_out_opc_sa(s, OPC_SRA, ret, ret, 16);                  /* ssd0 */
-    } else {
-        tcg_out_opc_sa(s, OPC_SLL, ret, arg, 8);                   /* bcd0 */
-        if (flags & TCG_BSWAP_OZ) {
-            tcg_out_opc_imm(s, OPC_ANDI, ret, ret, 0xff00);        /* 00d0 */
-        }
-    }
-    tcg_out_opc_reg(s, OPC_OR, ret, ret, TCG_TMP0);                /* ssdc */
-}
-
 static void tcg_out_bswap_subr(TCGContext *s, const tcg_insn_unit *sub)
 {
     if (!tcg_out_opc_jmp(s, OPC_JAL, sub)) {
@@ -2174,6 +2141,41 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_bswap16(TCGContext *s, TCGType type,
+                         TCGReg ret, TCGReg arg, unsigned flags)
+{
+    /* With arg = abcd: */
+    if (use_mips32r2_instructions) {
+        tcg_out_opc_reg(s, OPC_WSBH, ret, 0, arg);                 /* badc */
+        if (flags & TCG_BSWAP_OS) {
+            tcg_out_opc_reg(s, OPC_SEH, ret, 0, ret);              /* ssdc */
+        } else if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
+            tcg_out_opc_imm(s, OPC_ANDI, ret, ret, 0xffff);        /* 00dc */
+        }
+        return;
+    }
+
+    tcg_out_opc_sa(s, OPC_SRL, TCG_TMP0, arg, 8);                  /* 0abc */
+    if (!(flags & TCG_BSWAP_IZ)) {
+        tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP0, TCG_TMP0, 0x00ff);  /* 000c */
+    }
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_opc_sa(s, OPC_SLL, ret, arg, 24);                  /* d000 */
+        tcg_out_opc_sa(s, OPC_SRA, ret, ret, 16);                  /* ssd0 */
+    } else {
+        tcg_out_opc_sa(s, OPC_SLL, ret, arg, 8);                   /* bcd0 */
+        if (flags & TCG_BSWAP_OZ) {
+            tcg_out_opc_imm(s, OPC_ANDI, ret, ret, 0xff00);        /* 00d0 */
+        }
+    }
+    tcg_out_opc_reg(s, OPC_OR, ret, ret, TCG_TMP0);                /* ssdc */
+}
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap16,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
@@ -2265,10 +2267,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
-        tcg_out_bswap16(s, a0, a1, a2);
-        break;
     case INDEX_op_bswap32_i32:
         tcg_out_bswap32(s, a0, a1, 0);
         break;
@@ -2379,7 +2377,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
@@ -2390,7 +2387,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 4cdbf246d2..3454254624 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1012,38 +1012,6 @@ static void tcg_out_addpcis(TCGContext *s, TCGReg dst, intptr_t imm)
     tcg_out32(s, ADDPCIS | RT(dst) | (d1 << 16) | (d0 << 6) | d2);
 }
 
-static void tcg_out_bswap16(TCGContext *s, TCGReg dst, TCGReg src, int flags)
-{
-    TCGReg tmp = dst == src ? TCG_REG_R0 : dst;
-
-    if (have_isa_3_10) {
-        tcg_out32(s, BRH | RA(dst) | RS(src));
-        if (flags & TCG_BSWAP_OS) {
-            tcg_out_ext16s(s, TCG_TYPE_REG, dst, dst);
-        } else if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
-            tcg_out_ext16u(s, dst, dst);
-        }
-        return;
-    }
-
-    /*
-     * In the following,
-     *   dep(a, b, m) -> (a & ~m) | (b & m)
-     *
-     * Begin with:                              src = xxxxabcd
-     */
-    /* tmp = rol32(src, 24) & 0x000000ff            = 0000000c */
-    tcg_out_rlw(s, RLWINM, tmp, src, 24, 24, 31);
-    /* tmp = dep(tmp, rol32(src, 8), 0x0000ff00)    = 000000dc */
-    tcg_out_rlw(s, RLWIMI, tmp, src, 8, 16, 23);
-
-    if (flags & TCG_BSWAP_OS) {
-        tcg_out_ext16s(s, TCG_TYPE_REG, dst, tmp);
-    } else {
-        tcg_out_mov(s, TCG_TYPE_REG, dst, tmp);
-    }
-}
-
 static void tcg_out_bswap32(TCGContext *s, TCGReg dst, TCGReg src, int flags)
 {
     TCGReg tmp = dst == src ? TCG_REG_R0 : dst;
@@ -3378,6 +3346,44 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_bswap16(TCGContext *s, TCGType type,
+                         TCGReg dst, TCGReg src, unsigned flags)
+{
+    TCGReg tmp = dst == src ? TCG_REG_R0 : dst;
+
+    if (have_isa_3_10) {
+        tcg_out32(s, BRH | RA(dst) | RS(src));
+        if (flags & TCG_BSWAP_OS) {
+            tcg_out_ext16s(s, TCG_TYPE_REG, dst, dst);
+        } else if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
+            tcg_out_ext16u(s, dst, dst);
+        }
+        return;
+    }
+
+    /*
+     * In the following,
+     *   dep(a, b, m) -> (a & ~m) | (b & m)
+     *
+     * Begin with:                              src = xxxxabcd
+     */
+    /* tmp = rol32(src, 24) & 0x000000ff            = 0000000c */
+    tcg_out_rlw(s, RLWINM, tmp, src, 24, 24, 31);
+    /* tmp = dep(tmp, rol32(src, 8), 0x0000ff00)    = 000000dc */
+    tcg_out_rlw(s, RLWIMI, tmp, src, 8, 16, 23);
+
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_ext16s(s, TCG_TYPE_REG, dst, tmp);
+    } else {
+        tcg_out_mov(s, TCG_TYPE_REG, dst, tmp);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap16,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out32(s, NEG | RT(a0) | RA(a1));
@@ -3500,10 +3506,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
-        tcg_out_bswap16(s, args[0], args[1], args[2]);
-        break;
     case INDEX_op_bswap32_i32:
         tcg_out_bswap32(s, args[0], args[1], 0);
         break;
@@ -4250,7 +4252,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
@@ -4263,7 +4264,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_extract_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 8d106d7f28..c6cd2100f8 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2402,6 +2402,28 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static TCGConstraintSetIndex cset_bswap(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_ZBB ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static void tgen_bswap16(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
+    if (flags & TCG_BSWAP_OZ) {
+        tcg_out_opc_imm(s, OPC_SRLI, a0, a0, 48);
+    } else {
+        tcg_out_opc_imm(s, OPC_SRAI, a0, a0, 48);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_bswap,
+    .out_rr = tgen_bswap16,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
@@ -2498,15 +2520,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out_opc_imm(s, OPC_SRAI, a0, a0, 32);
         }
         break;
-    case INDEX_op_bswap16_i64:
-    case INDEX_op_bswap16_i32:
-        tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
-        if (a2 & TCG_BSWAP_OZ) {
-            tcg_out_opc_imm(s, OPC_SRLI, a0, a0, 48);
-        } else {
-            tcg_out_opc_imm(s, OPC_SRAI, a0, a0, 48);
-        }
-        break;
 
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
@@ -2845,9 +2858,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
-    case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fbf39ca529..e90c03628a 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2741,6 +2741,25 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori_3,
 };
 
+static void tgen_bswap16(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRE, LRVR, a0, a1);
+        tcg_out_sh32(s, (flags & TCG_BSWAP_OS ? RS_SRA : RS_SRL),
+                     a0, TCG_REG_NONE, 16);
+    } else {
+        tcg_out_insn(s, RRE, LRVGR, a0, a1);
+        tcg_out_sh64(s, (flags & TCG_BSWAP_OS ? RSY_SRAG : RSY_SRLG),
+                     a0, a0, TCG_REG_NONE, 48);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap16,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     if (type == TCG_TYPE_I32) {
@@ -2827,25 +2846,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_bswap16_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        tcg_out_insn(s, RRE, LRVR, a0, a1);
-        if (a2 & TCG_BSWAP_OS) {
-            tcg_out_sh32(s, RS_SRA, a0, TCG_REG_NONE, 16);
-        } else {
-            tcg_out_sh32(s, RS_SRL, a0, TCG_REG_NONE, 16);
-        }
-        break;
-    case INDEX_op_bswap16_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        tcg_out_insn(s, RRE, LRVGR, a0, a1);
-        if (a2 & TCG_BSWAP_OS) {
-            tcg_out_sh64(s, RSY_SRAG, a0, a0, TCG_REG_NONE, 48);
-        } else {
-            tcg_out_sh64(s, RSY_SRLG, a0, a0, TCG_REG_NONE, 48);
-        }
-        break;
-
     case INDEX_op_bswap32_i32:
         tcg_out_insn(s, RRE, LRVR, args[0], args[1]);
         break;
@@ -3459,8 +3459,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index d99b9e42ce..5111f173e1 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1725,6 +1725,10 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
      tgen_sub(s, type, a0, TCG_REG_G0, a1);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 88dc7e24e3..2a8ba07e37 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -57,8 +57,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
@@ -904,6 +902,20 @@ static const TCGOutOpUnary outop_ctpop = {
     .out_rr = tgen_ctpop,
 };
 
+static void tgen_bswap16(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_op_rr(s, INDEX_op_bswap16_i32, a0, a1);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 16);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap16,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
@@ -1055,13 +1067,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rr(s, opc, args[0], args[1]);
         break;
 
-    case INDEX_op_bswap16_i32: /* Optional (TCG_TARGET_HAS_bswap16_i32). */
-    case INDEX_op_bswap16_i64: /* Optional (TCG_TARGET_HAS_bswap16_i64). */
-        width = 16;
-        goto do_bswap;
     case INDEX_op_bswap32_i64: /* Optional (TCG_TARGET_HAS_bswap32_i64). */
         width = 32;
-    do_bswap:
         /* The base tci bswaps zero-extend, and ignore high bits. */
         tcg_out_op_rr(s, opc, args[0], args[1]);
         if (args[2] & TCG_BSWAP_OS) {
-- 
2.43.0


