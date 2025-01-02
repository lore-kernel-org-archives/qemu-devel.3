Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8952CE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbq-0007dQ-Mk; Thu, 02 Jan 2025 13:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbM-00070b-8E
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:23 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbI-0005A7-QN
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21a1e6fd923so115851445ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841234; x=1736446034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gWHE5tJx4/rCVSwc4AbfjkYVaA2xhdcCVPqUqB4QrQE=;
 b=zB978zrfVwRRiYjdcdnkeXeUV/KeMwLjUDzEJR7ACVJnTtHQnnx3oblPfz1xtkpCgC
 pGQaoQ0EHbnJuYXRDvBOOwufwHsnmo5mWYjy0eGCT16kL3rM6en7fZAk17ia4a4J9ss/
 zXJ2uouIvYp45DkCFgfJ87GHsUfKbr81ySfb5OVXz3p+idzUG8R+HmI+K1SzIczarH9C
 SnwIFGWGtAJ7G+MZ1VH6JEVUMdof20JyTXN3dolnUOfRZNA2V0YcaEyKDH9Tj0Qp6Pb3
 S6kqHVy3li0K3PCZ6ok7oemnvUvnWj8kz01GAd2/UNF4sk5XDnYGIj3YwiobrEIgE/pP
 e8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841234; x=1736446034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWHE5tJx4/rCVSwc4AbfjkYVaA2xhdcCVPqUqB4QrQE=;
 b=Ki4seclBn0DiHdDYxApUCql1smy3ZHrkzr0zVfRAJXx8UN4ApcYc/NqIApwPHEX6N/
 GEeLdmuZhKukGCL3r9pQN8Xg9uXP8kI4aHnvKvGcyk4bFriz4tkPQU4eKGtrLATfArCr
 jfT+1WnryO+4XtRKxsry8vz9J6X0dNn11W2vjuHoUOjjxXujx/Ie5RUSU65FFgsgYx9w
 bC9K14PIr7PMcloQUNTBbO8eaewbAADcMAOeqifN6lzcq1KrO5XC8xxOWLG4bxXOE+ca
 zZZ39O927ECFY5ZK5jZDbLs/2kjcItggdOBGMzausDLZUFBY3RxbQpz62ApoVfKDxrxt
 fagg==
X-Gm-Message-State: AOJu0YxN85tlQUtqt+s97zNNE0mwEyWg5SDTGiTkz1VL6xoXRnAPjB0c
 9A3QxIiWSptzf/D+WdaqDn9R/HeBSoWzdXKps+6SnN2WbwrXVM4Txy9JoD0rds6aJfOhcBdqfwY
 K
X-Gm-Gg: ASbGncs7LZ+LUsXBtftegciqv3PUevB24tmDwVoX6sBXcoi8BfUNRCJ5/V9eODODWtS
 MOIE/8zY6Smo95asDyYCUfq2mQ4TgaZsPV0m95gtZaScc1aJQwl2pjWxlMoHN+ZnjakDoYpDPS2
 +zhESOYaRXeejiI4s0Nr4EoxQmNQzYkHX6MVVH8/vl791n+iZVr2elcDx9t20zgC9OBwZxjJYDh
 R8LASBSJMMCb4/aofI3XbEwE9TV6x/Ws8Ra8kP6nrYrBDTA8EgIF2Bep43G7Q==
X-Google-Smtp-Source: AGHT+IFsDL3rgLeRWClwjubvzAa3c2mAfevfvxXBDzGujDfX1DRL+DDO/RxzsHgrFuNY8gaTwPXxiw==
X-Received: by 2002:a05:6a00:3287:b0:727:3cd0:112b with SMTP id
 d2e1a72fcca58-72abdd7bc3bmr54484392b3a.9.1735841234344; 
 Thu, 02 Jan 2025 10:07:14 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/73] tcg: Merge TCG_TARGET_HAS_bswap*
Date: Thu,  2 Jan 2025 10:06:04 -0800
Message-ID: <20250102180654.1420056-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Merge not only the i32 and i64 alternatives, but all
of the different input bit sizes as well.  For each
tcg target they are all the same.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            | 10 +++++-----
 tcg/aarch64/tcg-target-has.h     |  6 +-----
 tcg/arm/tcg-target-has.h         |  3 +--
 tcg/i386/tcg-target-has.h        |  6 +-----
 tcg/loongarch64/tcg-target-has.h |  6 +-----
 tcg/mips/tcg-target-has.h        |  6 +-----
 tcg/ppc/tcg-target-has.h         |  6 +-----
 tcg/riscv/tcg-target-has.h       |  6 +-----
 tcg/s390x/tcg-target-has.h       |  6 +-----
 tcg/sparc64/tcg-target-has.h     |  6 +-----
 tcg/tcg-has.h                    |  3 ---
 tcg/tci/tcg-target-has.h         |  6 +-----
 tcg/tcg-op.c                     | 10 +++++-----
 tcg/tcg.c                        |  7 ++-----
 tcg/tci.c                        |  9 ---------
 tcg/tci/tcg-target.c.inc         | 10 +++++-----
 16 files changed, 27 insertions(+), 79 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index f1330e5828..cbc8b358f6 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -97,8 +97,8 @@ DEF(ext8s_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext8s_i32))
 DEF(ext16s_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext16s_i32))
 DEF(ext8u_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext8u_i32))
 DEF(ext16u_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext16u_i32))
-DEF(bswap16_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap16_i32))
-DEF(bswap32_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap32_i32))
+DEF(bswap16_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I32)))
+DEF(bswap32_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I32)))
 DEF(not_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_not(TCG_TYPE_I32)))
 DEF(neg_i32, 1, 1, 0, 0)
 DEF(andc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_andc(TCG_TYPE_I32)))
@@ -167,9 +167,9 @@ DEF(ext32s_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext32s_i64))
 DEF(ext8u_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext8u_i64))
 DEF(ext16u_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext16u_i64))
 DEF(ext32u_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext32u_i64))
-DEF(bswap16_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap16_i64))
-DEF(bswap32_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap32_i64))
-DEF(bswap64_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap64_i64))
+DEF(bswap16_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I64)))
+DEF(bswap32_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I64)))
+DEF(bswap64_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I64)))
 DEF(not_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_not(TCG_TYPE_I64)))
 DEF(neg_i64, 1, 1, 0, IMPL64)
 DEF(andc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_andc(TCG_TYPE_I64)))
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index e25c08d2ee..128d1dc7c9 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -13,6 +13,7 @@
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
@@ -28,8 +29,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
@@ -54,9 +53,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      1
-#define TCG_TARGET_HAS_bswap32_i64      1
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 4e76720fc1..69579e8fb0 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,6 +24,7 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           use_idiv_instructions
 #define TCG_TARGET_HAS_rem(T)           0
 
@@ -39,8 +40,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index bdd2a6d65a..fcd10fde95 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,6 +26,7 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div2(T)          1
 
 /* optional integer and vector instructions */
@@ -41,8 +42,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        have_popcnt
@@ -68,9 +67,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      1
-#define TCG_TARGET_HAS_bswap32_i64      1
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        have_popcnt
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 581d96dbfc..36d3dbc00b 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -10,6 +10,7 @@
 #include "host/cpuinfo.h"
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
@@ -37,8 +38,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -60,9 +59,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      1
-#define TCG_TARGET_HAS_bswap32_i64      1
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 1a8b6d571a..d17d464b8b 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -39,6 +39,7 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
@@ -54,8 +55,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -87,9 +86,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_bswap16_i64      1
-#define TCG_TARGET_HAS_bswap32_i64      1
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 1f3ba6ed89..8ddf606d63 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -17,6 +17,7 @@
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
@@ -35,8 +36,6 @@
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
@@ -62,9 +61,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_bswap16_i64      1
-#define TCG_TARGET_HAS_bswap32_i64      1
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 96380b5729..32edc4e484 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -10,6 +10,7 @@
 #include "host/cpuinfo.h"
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_bswap(T)         (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
@@ -37,8 +38,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
@@ -59,9 +58,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 8cb5da1a3d..ba83f64e76 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -29,6 +29,7 @@ extern uint64_t s390_facilities[3];
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_bswap(T)       1
 #define TCG_TARGET_HAS_div2(T)        1
 
 /* optional integer and vector instructions */
@@ -44,8 +45,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext16s_i32     1
 #define TCG_TARGET_HAS_ext8u_i32      1
 #define TCG_TARGET_HAS_ext16u_i32     1
-#define TCG_TARGET_HAS_bswap16_i32    1
-#define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_clz_i32        0
 #define TCG_TARGET_HAS_ctz_i32        0
 #define TCG_TARGET_HAS_ctpop_i32      1
@@ -70,9 +69,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext8u_i64      1
 #define TCG_TARGET_HAS_ext16u_i64     1
 #define TCG_TARGET_HAS_ext32u_i64     1
-#define TCG_TARGET_HAS_bswap16_i64    1
-#define TCG_TARGET_HAS_bswap32_i64    1
-#define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_clz_i64        1
 #define TCG_TARGET_HAS_ctz_i64        0
 #define TCG_TARGET_HAS_ctpop_i64      1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index a0dbfea13f..7816a11c09 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,6 +14,7 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_bswap(T)         0
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           0
 
@@ -30,8 +31,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext16s_i32       0
 #define TCG_TARGET_HAS_ext8u_i32        0
 #define TCG_TARGET_HAS_ext16u_i32       0
-#define TCG_TARGET_HAS_bswap16_i32      0
-#define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_clz_i32          0
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -56,9 +55,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      0
-#define TCG_TARGET_HAS_bswap32_i64      0
-#define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 801aa5090c..6f04e8cf5a 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -19,9 +19,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_bswap16_i64      0
-#define TCG_TARGET_HAS_bswap32_i64      0
-#define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 2642450b08..bf3c454255 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -8,6 +8,7 @@
 #define TCG_TARGET_HAS_H
 
 /* optional integer instructions */
+#define TCG_TARGET_HAS_bswap(T)         1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 
@@ -19,8 +20,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
@@ -41,9 +40,6 @@
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap16_i64      1
-#define TCG_TARGET_HAS_bswap32_i64      1
-#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 42104d3612..2923a33cf6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1327,7 +1327,7 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
 
-    if (TCG_TARGET_HAS_bswap16_i32) {
+    if (TCG_TARGET_HAS_bswap(TCG_TYPE_I32)) {
         tcg_gen_op3i_i32(INDEX_op_bswap16_i32, ret, arg, flags);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -1364,7 +1364,7 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
  */
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_bswap32_i32) {
+    if (TCG_TARGET_HAS_bswap(TCG_TYPE_I32)) {
         tcg_gen_op3i_i32(INDEX_op_bswap32_i32, ret, arg, 0);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2228,7 +2228,7 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         } else {
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         }
-    } else if (TCG_TARGET_HAS_bswap16_i64) {
+    } else if (TCG_TARGET_HAS_bswap(TCG_TYPE_I64)) {
         tcg_gen_op3i_i64(INDEX_op_bswap16_i64, ret, arg, flags);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -2278,7 +2278,7 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         } else {
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         }
-    } else if (TCG_TARGET_HAS_bswap32_i64) {
+    } else if (TCG_TARGET_HAS_bswap(TCG_TYPE_I64)) {
         tcg_gen_op3i_i64(INDEX_op_bswap32_i64, ret, arg, flags);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -2325,7 +2325,7 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
         tcg_gen_mov_i32(TCGV_HIGH(ret), t0);
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
-    } else if (TCG_TARGET_HAS_bswap64_i64) {
+    } else if (TCG_TARGET_HAS_bswap(TCG_TYPE_I64)) {
         tcg_gen_op3i_i64(INDEX_op_bswap64_i64, ret, arg, 0);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ee2701d100..d3ede3e6ab 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2251,9 +2251,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_ext16u_i32:
         return TCG_TARGET_HAS_ext16u_i32;
     case INDEX_op_bswap16_i32:
-        return TCG_TARGET_HAS_bswap16_i32;
     case INDEX_op_bswap32_i32:
-        return TCG_TARGET_HAS_bswap32_i32;
+        return TCG_TARGET_HAS_bswap(TCG_TYPE_I32);
     case INDEX_op_not_i32:
         return TCG_TARGET_HAS_not(TCG_TYPE_I32);
     case INDEX_op_andc_i32:
@@ -2344,11 +2343,9 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_ext32u_i64:
         return TCG_TARGET_HAS_ext32u_i64;
     case INDEX_op_bswap16_i64:
-        return TCG_TARGET_HAS_bswap16_i64;
     case INDEX_op_bswap32_i64:
-        return TCG_TARGET_HAS_bswap32_i64;
     case INDEX_op_bswap64_i64:
-        return TCG_TARGET_HAS_bswap64_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_bswap(TCG_TYPE_I64);
     case INDEX_op_not_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_not(TCG_TYPE_I64);
     case INDEX_op_andc_i64:
diff --git a/tcg/tci.c b/tcg/tci.c
index 783cb7e3ab..e2926bce61 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -701,13 +701,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = (int8_t)regs[r1];
             break;
 #endif
-#if TCG_TARGET_HAS_ext16s_i32 || TCG_TARGET_HAS_ext16s_i64 || \
-    TCG_TARGET_HAS_bswap16_i32 || TCG_TARGET_HAS_bswap16_i64
         CASE_32_64(ext16s)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (int16_t)regs[r1];
             break;
-#endif
 #if TCG_TARGET_HAS_ext8u_i32 || TCG_TARGET_HAS_ext8u_i64
         CASE_32_64(ext8u)
             tci_args_rr(insn, &r0, &r1);
@@ -720,18 +717,14 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = (uint16_t)regs[r1];
             break;
 #endif
-#if TCG_TARGET_HAS_bswap16_i32 || TCG_TARGET_HAS_bswap16_i64
         CASE_32_64(bswap16)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap16(regs[r1]);
             break;
-#endif
-#if TCG_TARGET_HAS_bswap32_i32 || TCG_TARGET_HAS_bswap32_i64
         CASE_32_64(bswap32)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap32(regs[r1]);
             break;
-#endif
         CASE_32_64(not)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ~regs[r1];
@@ -884,12 +877,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
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
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 5f88ca0537..b7c58671f0 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -808,18 +808,18 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     CASE_32_64(neg)      /* Optional (TCG_TARGET_HAS_neg_*). */
     CASE_32_64(not)      /* Optional (TCG_TARGET_HAS_not_*). */
     CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
-    case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap32_i32). */
-    case INDEX_op_bswap64_i64: /* Optional (TCG_TARGET_HAS_bswap64_i64). */
+    case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap). */
+    case INDEX_op_bswap64_i64: /* Optional (TCG_TARGET_HAS_bswap). */
         tcg_out_op_rr(s, opc, args[0], args[1]);
         break;
 
-    case INDEX_op_bswap16_i32: /* Optional (TCG_TARGET_HAS_bswap16_i32). */
+    case INDEX_op_bswap16_i32: /* Optional (TCG_TARGET_HAS_bswap). */
         exts = INDEX_op_ext16s_i32;
         goto do_bswap;
-    case INDEX_op_bswap16_i64: /* Optional (TCG_TARGET_HAS_bswap16_i64). */
+    case INDEX_op_bswap16_i64: /* Optional (TCG_TARGET_HAS_bswap). */
         exts = INDEX_op_ext16s_i64;
         goto do_bswap;
-    case INDEX_op_bswap32_i64: /* Optional (TCG_TARGET_HAS_bswap32_i64). */
+    case INDEX_op_bswap32_i64: /* Optional (TCG_TARGET_HAS_bswap). */
         exts = INDEX_op_ext32s_i64;
     do_bswap:
         /* The base tci bswaps zero-extend, and ignore high bits. */
-- 
2.43.0


