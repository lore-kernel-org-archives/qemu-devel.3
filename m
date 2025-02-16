Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D341BC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjns7-0008DW-KJ; Sun, 16 Feb 2025 18:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqU-0001TK-IY
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:42 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqC-0005SQ-M0
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:32 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22128b7d587so7754525ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747641; x=1740352441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WjjZA9EAeNncDPaGvDkzQXUhj41ZxHjt3x6qHChyIvA=;
 b=D5McoVnw8lITOTVMCfo2+qqI7+jZD3KTM/dWOPCRi+RqJSvUGpYvBkIE5zS2+LpC1t
 POeCf8/ZFNI/jZ8PNKNu8g9NCePjgDgkSyVvhWdVCtZ1/vWTfQM3cRCcjvL11OkUcstx
 fJSGIt7A4bWoQ1iXyAGnp5Q2jY8ZV8FdL9R82Q1lec2iQ4ncxnyzjX/z8iVwU3qah2UB
 LLO10yHfoQ2Qv+9SPoLLrr1+0Ae4InEAlBgPHbLHglUTJmndhYvyqLmPjHTwjB264ShW
 InIFpVC0cAArHzjxb+5/19QRzeCZ1zhF9oHVFpUdF+9gv5YaXdsNGxXJL3imZ1F+CySi
 nOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747641; x=1740352441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjjZA9EAeNncDPaGvDkzQXUhj41ZxHjt3x6qHChyIvA=;
 b=K+dyN1BRGS78XTeoPrWgbE17cTOwic0JvZI9kzA8amIo4UvWB7PwU2tPTwpvv2R81I
 m8VTnqAOEMjaui5c/gDwWBSAzOx3mdGlHfz0AJMKE5TJ2L/tMCIPgI25vkDDTiBf0dZ6
 kb8OPaOO5fkDTiB5B2mtKgdDw8NVLHtTiNVfgRU16+PNMP2uxKHLPofLy/jyrfWpvhwO
 vPPAQSaFjDG1//4zRtAIOJ0xbQ2aVrOwNnPZbg18ikzFW0h6/QhMCqqbHO1B1CWW14q7
 VaYq+2zgwQ2KU+Pyu6Z8GERg19wacXNjdEXF4rnNDLihA1r4/oLaT/9mAOyEM6Iamlv3
 jTiw==
X-Gm-Message-State: AOJu0Yx5Ja8q9tIDuwnfnVScNqIpny3auW/QT2AtLkTglYdiwAeCo3cZ
 NR1lXk8XU8F4MWJoW/zU9bHeqSFlKkm2AXeeWnN/QblCdBsIS3/dCV0Da4TFe5hRTsEH0omc2K2
 7
X-Gm-Gg: ASbGnctaP81mjkNorgkZznvLpmCUMNn1sP2i1cd52m2ty3QQaLt0wSjeWHa3nKfsV+S
 G1hYv2+Qez7uDSzTcjjTLsrMv6S5EGMk/rg3M2VBSkh3RXLoF+iebLL7WL6XZUAPTYEv83YWywN
 E7w1u+lLzwStoO3X3BE4YBIYOLeZLkQAw9LRdH/hafm/8sAlvIoxb9iKJ9k98zGNtC9JjIa9tj/
 nWNBFB2NUK9r4/pTzs9UDD/0+y3m+j74uImCMvMuRiblGIjkyCtP/XIsI7zbITKfSBnQ6AxCYlL
 s44v4MVR5QI85O+XCsNodFLKQVeAkTyMds6jKk6CTuLXbUs=
X-Google-Smtp-Source: AGHT+IGM9LpeMnwxwHs2n6/uqcfUbQ/w/6QGNQLFLT/vcaU4zuk8z/G0DFZrZ4XwIoeTyWM+dw0/Vw==
X-Received: by 2002:a17:902:d4d0:b0:215:6995:1ef3 with SMTP id
 d9443c01a7336-22103f050d9mr111030755ad.3.1739747640808; 
 Sun, 16 Feb 2025 15:14:00 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.14.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:14:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 061/162] tcg: Convert clz to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:08:30 -0800
Message-ID: <20250216231012.2808572-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 tcg/aarch64/tcg-target-has.h     |   2 -
 tcg/arm/tcg-target-has.h         |   1 -
 tcg/i386/tcg-target-has.h        |   2 -
 tcg/loongarch64/tcg-target-has.h |   2 -
 tcg/mips/tcg-target-has.h        |   2 -
 tcg/ppc/tcg-target-has.h         |   2 -
 tcg/riscv/tcg-target-has.h       |   2 -
 tcg/s390x/tcg-target-has.h       |   2 -
 tcg/sparc64/tcg-target-has.h     |   2 -
 tcg/tcg-has.h                    |   1 -
 tcg/tci/tcg-target-has.h         |   2 -
 tcg/tcg-op.c                     | 108 ++++++++++++++++---------------
 tcg/tcg.c                        |   8 +--
 tcg/tci.c                        |   8 +--
 tcg/aarch64/tcg-target.c.inc     |  83 +++++++++++++-----------
 tcg/arm/tcg-target.c.inc         |  47 +++++++++-----
 tcg/i386/tcg-target.c.inc        |  72 +++++++++++----------
 tcg/loongarch64/tcg-target.c.inc |  36 ++++++++---
 tcg/mips/tcg-target.c.inc        |  86 +++++++++++++-----------
 tcg/ppc/tcg-target.c.inc         |  30 ++++++---
 tcg/riscv/tcg-target.c.inc       |  34 +++++++---
 tcg/s390x/tcg-target.c.inc       |  75 +++++++++++++--------
 tcg/sparc64/tcg-target.c.inc     |   4 ++
 tcg/tci/tcg-target-opc.h.inc     |   1 +
 tcg/tci/tcg-target.c.inc         |  17 ++++-
 25 files changed, 365 insertions(+), 264 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index fa79cbc1f0..8c839d8949 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -15,7 +15,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_extract2_i32     1
@@ -30,7 +29,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_extract2_i64     1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 12ffbcda2b..fceec2f0ca 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -26,7 +26,6 @@ extern bool use_neon_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_extract2_i32     1
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index a7199463df..2277872ff3 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -28,7 +28,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        have_popcnt
 #define TCG_TARGET_HAS_extract2_i32     1
@@ -44,7 +43,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        have_popcnt
 #define TCG_TARGET_HAS_extract2_i64     1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 303134390a..2eba2132b8 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -18,7 +18,6 @@
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -30,7 +29,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_add2_i64         0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 880eb084eb..c27ca7e543 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -60,7 +60,6 @@ extern bool use_mips32r2_instructions;
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_clz_i32          use_mips32r2_instructions
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -70,7 +69,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_clz_i64          use_mips32r2_instructions
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
 #endif
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 71c02d88b9..cd7346011b 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -19,7 +19,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
 #define TCG_TARGET_HAS_extract2_i32     0
@@ -35,7 +34,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
 #define TCG_TARGET_HAS_extract2_i64     0
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index c7745a6462..41e287130d 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -18,7 +18,6 @@
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -29,7 +28,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index eaddf7005e..85a4f23e95 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -31,7 +31,6 @@ extern uint64_t s390_facilities[3];
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
-#define TCG_TARGET_HAS_clz_i32        0
 #define TCG_TARGET_HAS_ctz_i32        0
 #define TCG_TARGET_HAS_ctpop_i32      1
 #define TCG_TARGET_HAS_extract2_i32   0
@@ -46,7 +45,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i64    1
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
-#define TCG_TARGET_HAS_clz_i64        1
 #define TCG_TARGET_HAS_ctz_i64        0
 #define TCG_TARGET_HAS_ctpop_i64      1
 #define TCG_TARGET_HAS_extract2_i64   0
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 1dd86c363d..21fa0f3663 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -16,7 +16,6 @@ extern bool use_vis3_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
-#define TCG_TARGET_HAS_clz_i32          0
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_extract2_i32     0
@@ -31,7 +30,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_extract2_i64     0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 7bfa55adb1..27d6ec7636 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -15,7 +15,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_extract2_i64     0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 04d341a8d2..ae1f724702 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -10,7 +10,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        1
 #define TCG_TARGET_HAS_negsetcond_i32   0
@@ -23,7 +22,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
 #define TCG_TARGET_HAS_negsetcond_i64   0
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1989d8d12c..e1e57ff3f8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -723,9 +723,9 @@ void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_clz_i32) {
+    if (tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_clz_i32, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_clz_i64) {
+    } else if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t1, arg1);
@@ -748,9 +748,13 @@ void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
+    TCGv_i32 z, t;
+
     if (TCG_TARGET_HAS_ctz_i32) {
         tcg_gen_op3_i32(INDEX_op_ctz_i32, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_ctz_i64) {
+        return;
+    }
+    if (TCG_TARGET_HAS_ctz_i64) {
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t1, arg1);
@@ -759,29 +763,28 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_extrl_i64_i32(ret, t1);
         tcg_temp_free_i64(t1);
         tcg_temp_free_i64(t2);
-    } else if (TCG_TARGET_HAS_ctpop_i32
-               || TCG_TARGET_HAS_ctpop_i64
-               || TCG_TARGET_HAS_clz_i32
-               || TCG_TARGET_HAS_clz_i64) {
-        TCGv_i32 z, t = tcg_temp_ebb_new_i32();
-
-        if (TCG_TARGET_HAS_ctpop_i32 || TCG_TARGET_HAS_ctpop_i64) {
-            tcg_gen_subi_i32(t, arg1, 1);
-            tcg_gen_andc_i32(t, t, arg1);
-            tcg_gen_ctpop_i32(t, t);
-        } else {
-            /* Since all non-x86 hosts have clz(0) == 32, don't fight it.  */
-            tcg_gen_neg_i32(t, arg1);
-            tcg_gen_and_i32(t, t, arg1);
-            tcg_gen_clzi_i32(t, t, 32);
-            tcg_gen_xori_i32(t, t, 31);
-        }
-        z = tcg_constant_i32(0);
-        tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
-        tcg_temp_free_i32(t);
+        return;
+    }
+    if (TCG_TARGET_HAS_ctpop_i32 || TCG_TARGET_HAS_ctpop_i64) {
+        t = tcg_temp_ebb_new_i32();
+        tcg_gen_subi_i32(t, arg1, 1);
+        tcg_gen_andc_i32(t, t, arg1);
+        tcg_gen_ctpop_i32(t, t);
+    } else if (tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0) ||
+               tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+        t = tcg_temp_ebb_new_i32();
+        tcg_gen_neg_i32(t, arg1);
+        tcg_gen_and_i32(t, t, arg1);
+        tcg_gen_clzi_i32(t, t, 32);
+        tcg_gen_xori_i32(t, t, 31);
     } else {
         gen_helper_ctz_i32(ret, arg1, arg2);
+        return;
     }
+
+    z = tcg_constant_i32(0);
+    tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
+    tcg_temp_free_i32(t);
 }
 
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
@@ -800,7 +803,8 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_clz_i32) {
+    if (tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0) ||
+        tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t, arg, 31);
         tcg_gen_xor_i32(t, t, arg);
@@ -2336,7 +2340,7 @@ void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_clz_i64) {
+    if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_clz_i64, ret, arg1, arg2);
     } else {
         gen_helper_clz_i64(ret, arg1, arg2);
@@ -2346,8 +2350,8 @@ void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
     if (TCG_TARGET_REG_BITS == 32
-        && TCG_TARGET_HAS_clz_i32
-        && arg2 <= 0xffffffffu) {
+        && arg2 <= 0xffffffffu
+        && tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_clzi_i32(t, TCGV_LOW(arg1), arg2 - 32);
         tcg_gen_addi_i32(t, t, 32);
@@ -2361,45 +2365,47 @@ void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
+    TCGv_i64 z, t;
+
     if (TCG_TARGET_HAS_ctz_i64) {
         tcg_gen_op3_i64(INDEX_op_ctz_i64, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_ctpop_i64 || TCG_TARGET_HAS_clz_i64) {
-        TCGv_i64 z, t = tcg_temp_ebb_new_i64();
-
-        if (TCG_TARGET_HAS_ctpop_i64) {
-            tcg_gen_subi_i64(t, arg1, 1);
-            tcg_gen_andc_i64(t, t, arg1);
-            tcg_gen_ctpop_i64(t, t);
-        } else {
-            /* Since all non-x86 hosts have clz(0) == 64, don't fight it.  */
-            tcg_gen_neg_i64(t, arg1);
-            tcg_gen_and_i64(t, t, arg1);
-            tcg_gen_clzi_i64(t, t, 64);
-            tcg_gen_xori_i64(t, t, 63);
-        }
-        z = tcg_constant_i64(0);
-        tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
-        tcg_temp_free_i64(t);
-        tcg_temp_free_i64(z);
+        return;
+    }
+    if (TCG_TARGET_HAS_ctpop_i64) {
+        t = tcg_temp_ebb_new_i64();
+        tcg_gen_subi_i64(t, arg1, 1);
+        tcg_gen_andc_i64(t, t, arg1);
+        tcg_gen_ctpop_i64(t, t);
+    } else if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+        t = tcg_temp_ebb_new_i64();
+        tcg_gen_neg_i64(t, arg1);
+        tcg_gen_and_i64(t, t, arg1);
+        tcg_gen_clzi_i64(t, t, 64);
+        tcg_gen_xori_i64(t, t, 63);
     } else {
         gen_helper_ctz_i64(ret, arg1, arg2);
+        return;
     }
+
+    z = tcg_constant_i64(0);
+    tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
+    tcg_temp_free_i64(t);
 }
 
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
     if (TCG_TARGET_REG_BITS == 32
-        && TCG_TARGET_HAS_ctz_i32
-        && arg2 <= 0xffffffffu) {
+        && arg2 <= 0xffffffffu
+        && tcg_op_supported(INDEX_op_ctz_i32, TCG_TYPE_I32, 0)) {
         TCGv_i32 t32 = tcg_temp_ebb_new_i32();
         tcg_gen_ctzi_i32(t32, TCGV_HIGH(arg1), arg2 - 32);
         tcg_gen_addi_i32(t32, t32, 32);
         tcg_gen_ctz_i32(TCGV_LOW(ret), TCGV_LOW(arg1), t32);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         tcg_temp_free_i32(t32);
-    } else if (!TCG_TARGET_HAS_ctz_i64
-               && TCG_TARGET_HAS_ctpop_i64
-               && arg2 == 64) {
+    } else if (arg2 == 64
+               && !tcg_op_supported(INDEX_op_ctz_i64, TCG_TYPE_I64, 0)
+               && TCG_TARGET_HAS_ctpop_i64) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_subi_i64(t, arg1, 1);
@@ -2413,7 +2419,7 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_HAS_clz_i64 || TCG_TARGET_HAS_clz_i32) {
+    if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_sari_i64(t, arg, 63);
         tcg_gen_xor_i64(t, t, arg);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1345b785e7..6b9d624696 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1026,6 +1026,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
+    OUTOP(INDEX_op_clz_i32, TCGOutOpBinary, outop_clz),
+    OUTOP(INDEX_op_clz_i64, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
@@ -2288,8 +2290,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap16_i32;
     case INDEX_op_bswap32_i32:
         return TCG_TARGET_HAS_bswap32_i32;
-    case INDEX_op_clz_i32:
-        return TCG_TARGET_HAS_clz_i32;
     case INDEX_op_ctz_i32:
         return TCG_TARGET_HAS_ctz_i32;
     case INDEX_op_ctpop_i32:
@@ -2333,8 +2333,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap32_i64;
     case INDEX_op_bswap64_i64:
         return TCG_TARGET_HAS_bswap64_i64;
-    case INDEX_op_clz_i64:
-        return TCG_TARGET_HAS_clz_i64;
     case INDEX_op_ctz_i64:
         return TCG_TARGET_HAS_ctz_i64;
     case INDEX_op_ctpop_i64:
@@ -5398,6 +5396,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_clz_i32:
+    case INDEX_op_clz_i64:
     case INDEX_op_divs:
     case INDEX_op_divu:
     case INDEX_op_eqv:
diff --git a/tcg/tci.c b/tcg/tci.c
index b1ee14e65f..11b11ce642 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -594,13 +594,11 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint32_t)regs[r1] % (uint32_t)regs[r2];
             break;
-#if TCG_TARGET_HAS_clz_i32
-        case INDEX_op_clz_i32:
+        case INDEX_op_tci_clz32:
             tci_args_rrr(insn, &r0, &r1, &r2);
             tmp32 = regs[r1];
             regs[r0] = tmp32 ? clz32(tmp32) : regs[r2];
             break;
-#endif
 #if TCG_TARGET_HAS_ctz_i32
         case INDEX_op_ctz_i32:
             tci_args_rrr(insn, &r0, &r1, &r2);
@@ -735,12 +733,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint64_t)regs[r1] % (uint64_t)regs[r2];
             break;
-#if TCG_TARGET_HAS_clz_i64
         case INDEX_op_clz_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
             break;
-#endif
 #if TCG_TARGET_HAS_ctz_i64
         case INDEX_op_ctz_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
@@ -1073,10 +1069,10 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
+    case INDEX_op_tci_clz32:
     case INDEX_op_tci_divs32:
     case INDEX_op_tci_divu32:
     case INDEX_op_tci_rems32:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 00fca43840..3bd8231117 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1618,37 +1618,6 @@ static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
     tcg_out32(s, sync[a0 & TCG_MO_ALL]);
 }
 
-static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
-                         TCGReg a0, TCGArg b, bool const_b, bool is_ctz)
-{
-    TCGReg a1 = a0;
-    if (is_ctz) {
-        a1 = TCG_REG_TMP0;
-        tcg_out_insn(s, 3507, RBIT, ext, a1, a0);
-    }
-    if (const_b && b == (ext ? 64 : 32)) {
-        tcg_out_insn(s, 3507, CLZ, ext, d, a1);
-    } else {
-        AArch64Insn sel = I3506_CSEL;
-
-        tcg_out_cmp(s, ext, TCG_COND_NE, a0, 0, 1);
-        tcg_out_insn(s, 3507, CLZ, ext, TCG_REG_TMP0, a1);
-
-        if (const_b) {
-            if (b == -1) {
-                b = TCG_REG_XZR;
-                sel = I3506_CSINV;
-            } else if (b == 0) {
-                b = TCG_REG_XZR;
-            } else {
-                tcg_out_movi(s, ext, d, b);
-                b = d;
-            }
-        }
-        tcg_out_insn_3506(s, sel, ext, d, TCG_REG_TMP0, b, TCG_COND_NE);
-    }
-}
-
 typedef struct {
     TCGReg base;
     TCGReg index;
@@ -2121,6 +2090,45 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_clz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_cmp(s, type, TCG_COND_NE, a1, 0, true);
+    tcg_out_insn(s, 3507, CLZ, type, TCG_REG_TMP0, a1);
+    tcg_out_insn(s, 3506, CSEL, type, a0, TCG_REG_TMP0, a2, TCG_COND_NE);
+}
+
+static void tgen_clzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 == (type == TCG_TYPE_I32 ? 32 : 64)) {
+        tcg_out_insn(s, 3507, CLZ, type, a0, a1);
+        return;
+    }
+
+    tcg_out_cmp(s, type, TCG_COND_NE, a1, 0, true);
+    tcg_out_insn(s, 3507, CLZ, type, a0, a1);
+
+    switch (a2) {
+    case -1:
+        tcg_out_insn(s, 3506, CSINV, type, a0, a0, TCG_REG_XZR, TCG_COND_NE);
+        break;
+    case 0:
+        tcg_out_insn(s, 3506, CSEL, type, a0, a0, TCG_REG_XZR, TCG_COND_NE);
+        break;
+    default:
+        tcg_out_movi(s, type, TCG_REG_TMP0, a2);
+        tcg_out_insn(s, 3506, CSEL, type, a0, a0, TCG_REG_TMP0, TCG_COND_NE);
+        break;
+    }
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_O1_I2(r, r, rAL),
+    .out_rrr = tgen_clz,
+    .out_rri = tgen_clzi,
+};
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2460,13 +2468,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_clz_i64:
-    case INDEX_op_clz_i32:
-        tcg_out_cltz(s, ext, a0, a1, a2, c2, false);
-        break;
     case INDEX_op_ctz_i64:
     case INDEX_op_ctz_i32:
-        tcg_out_cltz(s, ext, a0, a1, a2, c2, true);
+        tcg_out_insn(s, 3507, RBIT, ext, TCG_REG_TMP0, a1);
+        if (c2) {
+            tgen_clzi(s, ext, a0, TCG_REG_TMP0, a2);
+        } else {
+            tgen_clz(s, ext, a0, TCG_REG_TMP0, a2);
+        }
         break;
 
     case INDEX_op_brcond_i32:
@@ -3089,9 +3098,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
-    case INDEX_op_clz_i64:
     case INDEX_op_ctz_i64:
         return C_O1_I2(r, r, rAL);
 
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 78120622e7..f8f76014f8 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1868,6 +1868,32 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_clz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_imm(s, COND_AL, ARITH_CMP, 0, a1, 0);
+    tcg_out_dat_reg(s, COND_NE, INSN_CLZ, a0, 0, a1, 0);
+    tcg_out_mov_reg(s, COND_EQ, a0, a2);
+}
+
+static void tgen_clzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 == 32) {
+        tcg_out_dat_reg(s, COND_AL, INSN_CLZ, a0, 0, a1, 0);
+    } else {
+        tcg_out_dat_imm(s, COND_AL, ARITH_CMP, 0, a1, 0);
+        tcg_out_dat_reg(s, COND_NE, INSN_CLZ, a0, 0, a1, 0);
+        tcg_out_movi32(s, COND_EQ, a0, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_O1_I2(r, r, rIK),
+    .out_rrr = tgen_clz,
+    .out_rri = tgen_clzi,
+};
+
 static TCGConstraintSetIndex cset_idiv(TCGType type, unsigned flags)
 {
     return use_idiv_instructions ? C_O1_I2(r, r, r) : C_NotImplemented;
@@ -2202,23 +2228,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     case INDEX_op_ctz_i32:
         tcg_out_dat_reg(s, COND_AL, INSN_RBIT, TCG_REG_TMP, 0, args[1], 0);
-        a1 = TCG_REG_TMP;
-        goto do_clz;
-
-    case INDEX_op_clz_i32:
-        a1 = args[1];
-    do_clz:
-        a0 = args[0];
-        a2 = args[2];
-        c = const_args[2];
-        if (c && a2 == 32) {
-            tcg_out_dat_reg(s, COND_AL, INSN_CLZ, a0, 0, a1, 0);
-            break;
-        }
-        tcg_out_dat_imm(s, COND_AL, ARITH_CMP, 0, a1, 0);
-        tcg_out_dat_reg(s, COND_NE, INSN_CLZ, a0, 0, a1, 0);
-        if (c || a0 != a2) {
-            tcg_out_dat_rIK(s, COND_EQ, ARITH_MOV, ARITH_MVN, a0, 0, a2, c);
+        if (const_args[2]) {
+            tgen_clzi(s, TCG_TYPE_I32, args[0], TCG_REG_TMP, args[2]);
+        } else {
+            tgen_clz(s, TCG_TYPE_I32, args[0], TCG_REG_TMP, args[2]);
         }
         break;
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a01bb212cd..50b9df0dcb 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1869,32 +1869,6 @@ static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
     }
 }
 
-static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
-                        TCGArg arg2, bool const_a2)
-{
-    if (have_lzcnt) {
-        tcg_out_modrm(s, OPC_LZCNT + rexw, dest, arg1);
-        if (const_a2) {
-            tcg_debug_assert(arg2 == (rexw ? 64 : 32));
-        } else {
-            tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
-        }
-    } else {
-        tcg_debug_assert(!const_a2);
-        tcg_debug_assert(dest != arg1);
-        tcg_debug_assert(dest != arg2);
-
-        /* Recall that the output of BSR is the index not the count.  */
-        tcg_out_modrm(s, OPC_BSR + rexw, dest, arg1);
-        tgen_arithi(s, ARITH_XOR + rexw, dest, rexw ? 63 : 31, 0);
-
-        /* Since we have destroyed the flags from BSR, we have to re-test.  */
-        int jcc = tcg_out_cmp(s, TCG_COND_EQ, arg1, 0, 1, rexw);
-        tcg_out_cmov(s, jcc, rexw, dest, arg2);
-    }
-}
-
 static void tcg_out_branch(TCGContext *s, int call, const tcg_insn_unit *dest)
 {
     intptr_t disp = tcg_pcrel_diff(s, dest) - 5;
@@ -2633,6 +2607,45 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_clz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    int jcc;
+
+    if (have_lzcnt) {
+        tcg_out_modrm(s, OPC_LZCNT + rexw, a0, a1);
+        jcc = JCC_JB;
+    } else {
+        /* Recall that the output of BSR is the index not the count.  */
+        tcg_out_modrm(s, OPC_BSR + rexw, a0, a1);
+        tgen_arithi(s, ARITH_XOR + rexw, a0, rexw ? 63 : 31, 0);
+
+        /* Since we have destroyed the flags from BSR, we have to re-test.  */
+        jcc = tcg_out_cmp(s, TCG_COND_EQ, a1, 0, 1, rexw);
+    }
+    tcg_out_cmov(s, jcc, rexw, a0, a2);
+}
+
+static void tgen_clzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_LZCNT + rexw, a0, a1);
+}
+
+static TCGConstraintSetIndex cset_clz(TCGType type, unsigned flags)
+{
+    return have_lzcnt ? C_N1_I2(r, r, rW) : C_N1_I2(r, r, r);
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_clz,
+    .out_rrr = tgen_clz,
+    .out_rri = tgen_clzi,
+};
+
 static const TCGOutOpBinary outop_divs = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -3019,9 +3032,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(ctz):
         tcg_out_ctz(s, rexw, args[0], args[1], args[2], const_args[2]);
         break;
-    OP_32_64(clz):
-        tcg_out_clz(s, rexw, args[0], args[1], args[2], const_args[2]);
-        break;
     OP_32_64(ctpop):
         tcg_out_modrm(s, OPC_POPCNT + rexw, a0, a1);
         break;
@@ -3907,10 +3917,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ctz_i64:
         return have_bmi1 ? C_N1_I2(r, r, rW) : C_N1_I2(r, r, r);
 
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
-        return have_lzcnt ? C_N1_I2(r, r, rW) : C_N1_I2(r, r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, L);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index d7f4eeaa8b..338e0b351a 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1316,6 +1316,33 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_clzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    /* a2 is constrained to exactly the type width. */
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_clz_w(s, a0, a1);
+    } else {
+        tcg_out_opc_clz_d(s, a0, a1);
+    }
+}
+
+static void tgen_clz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tgen_clzi(s, type, TCG_REG_TMP0, a1, /* ignored */ 0);
+    /* a0 = a1 ? REG_TMP0 : a2 */
+    tcg_out_opc_maskeqz(s, TCG_REG_TMP0, TCG_REG_TMP0, a1);
+    tcg_out_opc_masknez(s, a0, a2, a1);
+    tcg_out_opc_or(s, a0, a0, TCG_REG_TMP0);
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_O1_I2(r, r, rW),
+    .out_rrr = tgen_clz,
+    .out_rri = tgen_clzi,
+};
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1742,13 +1769,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_revb_d(s, a0, a1);
         break;
 
-    case INDEX_op_clz_i32:
-        tcg_out_clzctz(s, OPC_CLZ_W, a0, a1, a2, c2, true);
-        break;
-    case INDEX_op_clz_i64:
-        tcg_out_clzctz(s, OPC_CLZ_D, a0, a1, a2, c2, false);
-        break;
-
     case INDEX_op_ctz_i32:
         tcg_out_clzctz(s, OPC_CTZ_W, a0, a1, a2, c2, true);
         break;
@@ -2392,8 +2412,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
         return C_O1_I2(r, r, rW);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f94c3678c1..fd8d3046ca 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1563,33 +1563,6 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
     tcg_out32(s, sync[a0 & TCG_MO_ALL]);
 }
 
-static void tcg_out_clz(TCGContext *s, MIPSInsn opcv2, MIPSInsn opcv6,
-                        int width, TCGReg a0, TCGReg a1, TCGArg a2)
-{
-    if (use_mips32r6_instructions) {
-        if (a2 == width) {
-            tcg_out_opc_reg(s, opcv6, a0, a1, 0);
-        } else {
-            tcg_out_opc_reg(s, opcv6, TCG_TMP0, a1, 0);
-            tcg_out_movcond(s, TCG_COND_EQ, a0, a1, 0, a2, TCG_TMP0);
-        }
-    } else {
-        if (a2 == width) {
-            tcg_out_opc_reg(s, opcv2, a0, a1, a1);
-        } else if (a0 == a2) {
-            tcg_out_opc_reg(s, opcv2, TCG_TMP0, a1, a1);
-            tcg_out_opc_reg(s, OPC_MOVN, a0, TCG_TMP0, a1);
-        } else if (a0 != a1) {
-            tcg_out_opc_reg(s, opcv2, a0, a1, a1);
-            tcg_out_opc_reg(s, OPC_MOVZ, a0, a2, a1);
-        } else {
-            tcg_out_opc_reg(s, opcv2, TCG_TMP0, a1, a1);
-            tcg_out_opc_reg(s, OPC_MOVZ, TCG_TMP0, a2, a1);
-            tcg_out_mov(s, TCG_TYPE_REG, a0, TCG_TMP0);
-        }
-    }
-}
-
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
 {
     TCGReg base = TCG_REG_ZERO;
@@ -1712,6 +1685,55 @@ static const TCGOutOpBinary outop_andc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_clz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (use_mips32r6_instructions) {
+        MIPSInsn opcv6 = type == TCG_TYPE_I32 ? OPC_CLZ_R6 : OPC_DCLZ_R6;
+        tcg_out_opc_reg(s, opcv6, TCG_TMP0, a1, 0);
+        tcg_out_movcond(s, TCG_COND_EQ, a0, a1, 0, a2, TCG_TMP0);
+    } else {
+        MIPSInsn opcv2 = type == TCG_TYPE_I32 ? OPC_CLZ : OPC_DCLZ;
+        if (a0 == a2) {
+            tcg_out_opc_reg(s, opcv2, TCG_TMP0, a1, a1);
+            tcg_out_opc_reg(s, OPC_MOVN, a0, TCG_TMP0, a1);
+        } else if (a0 != a1) {
+            tcg_out_opc_reg(s, opcv2, a0, a1, a1);
+            tcg_out_opc_reg(s, OPC_MOVZ, a0, a2, a1);
+        } else {
+            tcg_out_opc_reg(s, opcv2, TCG_TMP0, a1, a1);
+            tcg_out_opc_reg(s, OPC_MOVZ, TCG_TMP0, a2, a1);
+            tcg_out_mov(s, type, a0, TCG_TMP0);
+        }
+    }
+}
+
+static void tgen_clzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 == 0) {
+        tgen_clz(s, type, a0, a1, TCG_REG_ZERO);
+    } else if (use_mips32r6_instructions) {
+        MIPSInsn opcv6 = type == TCG_TYPE_I32 ? OPC_CLZ_R6 : OPC_DCLZ_R6;
+        tcg_out_opc_reg(s, opcv6, a0, a1, 0);
+    } else {
+        MIPSInsn opcv2 = type == TCG_TYPE_I32 ? OPC_CLZ : OPC_DCLZ;
+        tcg_out_opc_reg(s, opcv2, a0, a1, a1);
+    }
+}
+
+static TCGConstraintSetIndex cset_clz(TCGType type, unsigned flags)
+{
+    return use_mips32r2_instructions ? C_O1_I2(r, r, rzW) : C_NotImplemented;
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_clz,
+    .out_rrr = tgen_clz,
+    .out_rri = tgen_clzi,
+};
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2171,13 +2193,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_dsra(s, a0, a1, 32);
         break;
 
-    case INDEX_op_clz_i32:
-        tcg_out_clz(s, OPC_CLZ, OPC_CLZ_R6, 32, a0, a1, a2);
-        break;
-    case INDEX_op_clz_i64:
-        tcg_out_clz(s, OPC_DCLZ, OPC_DCLZ_R6, 64, a0, a1, a2);
-        break;
-
     case INDEX_op_deposit_i32:
         tcg_out_opc_bf(s, OPC_INS, a0, a2, args[3] + args[4] - 1, args[3]);
         break;
@@ -2335,9 +2350,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
-        return C_O1_I2(r, r, rzW);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 687b66af54..518cf1e9ef 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2954,6 +2954,26 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_clz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? CNTLZW : CNTLZD;
+    tcg_out_cntxz(s, type, insn, a0, a1, a2, false);
+}
+
+static void tgen_clzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? CNTLZW : CNTLZD;
+    tcg_out_cntxz(s, type, insn, a0, a1, a2, true);
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_O1_I2(r, r, rZW),
+    .out_rrr = tgen_clz,
+    .out_rri = tgen_clzi,
+};
+
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3350,10 +3370,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_clz_i32:
-        tcg_out_cntxz(s, TCG_TYPE_I32, CNTLZW, args[0], args[1],
-                      args[2], const_args[2]);
-        break;
     case INDEX_op_ctz_i32:
         tcg_out_cntxz(s, TCG_TYPE_I32, CNTTZW, args[0], args[1],
                       args[2], const_args[2]);
@@ -3362,10 +3378,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, CNTPOPW | SAB(args[1], args[0], 0));
         break;
 
-    case INDEX_op_clz_i64:
-        tcg_out_cntxz(s, TCG_TYPE_I64, CNTLZD, args[0], args[1],
-                      args[2], const_args[2]);
-        break;
     case INDEX_op_ctz_i64:
         tcg_out_cntxz(s, TCG_TYPE_I64, CNTTZD, args[0], args[1],
                       args[2], const_args[2]);
@@ -4228,9 +4240,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
-    case INDEX_op_clz_i64:
     case INDEX_op_ctz_i64:
         return C_O1_I2(r, r, rZW);
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 4dd892d98d..77eef02db5 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1997,6 +1997,32 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_clz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_CLZW : OPC_CLZ;
+    tcg_out_cltz(s, type, insn, a0, a1, a2, false);
+}
+
+static void tgen_clzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_CLZW : OPC_CLZ;
+    tcg_out_cltz(s, type, insn, a0, a1, a2, true);
+}
+
+static TCGConstraintSetIndex cset_clzctz(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_ZBB ? C_N1_I2(r, r, rM) : C_NotImplemented;
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_clzctz,
+    .out_rrr = tgen_clz,
+    .out_rri = tgen_clzi,
+};
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2398,12 +2424,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_imm(s, OPC_CPOP, a0, a1, 0);
         break;
 
-    case INDEX_op_clz_i32:
-        tcg_out_cltz(s, TCG_TYPE_I32, OPC_CLZW, a0, a1, a2, c2);
-        break;
-    case INDEX_op_clz_i64:
-        tcg_out_cltz(s, TCG_TYPE_I64, OPC_CLZ, a0, a1, a2, c2);
-        break;
     case INDEX_op_ctz_i32:
         tcg_out_cltz(s, TCG_TYPE_I32, OPC_CTZW, a0, a1, a2, c2);
         break;
@@ -2793,8 +2813,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
         return C_N1_I2(r, r, rM);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 76180dabcb..adfe403bef 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1514,27 +1514,6 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
     tgen_movcond_int(s, type, dest, v3, v3const, v4, cc, inv_cc);
 }
 
-static void tgen_clz(TCGContext *s, TCGReg dest, TCGReg a1,
-                     TCGArg a2, int a2const)
-{
-    /* Since this sets both R and R+1, we have no choice but to store the
-       result into R0, allowing R1 == TCG_TMP0 to be clobbered as well.  */
-    QEMU_BUILD_BUG_ON(TCG_TMP0 != TCG_REG_R1);
-    tcg_out_insn(s, RRE, FLOGR, TCG_REG_R0, a1);
-
-    if (a2const && a2 == 64) {
-        tcg_out_mov(s, TCG_TYPE_I64, dest, TCG_REG_R0);
-        return;
-    }
-
-    /*
-     * Conditions from FLOGR are:
-     *   2 -> one bit found
-     *   8 -> no one bit found
-     */
-    tgen_movcond_int(s, TCG_TYPE_I64, dest, a2, a2const, TCG_REG_R0, 8, 2);
-}
-
 static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
     /* With MIE3, and bit 0 of m4 set, we get the complete result. */
@@ -2242,6 +2221,53 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_clz_int(TCGContext *s, TCGReg dest, TCGReg a1,
+                         TCGArg a2, int a2const)
+{
+    /*
+     * Since this sets both R and R+1, we have no choice but to store the
+     * result into R0, allowing R1 == TCG_TMP0 to be clobbered as well.
+     */
+    QEMU_BUILD_BUG_ON(TCG_TMP0 != TCG_REG_R1);
+    tcg_out_insn(s, RRE, FLOGR, TCG_REG_R0, a1);
+
+    if (a2const && a2 == 64) {
+        tcg_out_mov(s, TCG_TYPE_I64, dest, TCG_REG_R0);
+        return;
+    }
+
+    /*
+     * Conditions from FLOGR are:
+     *   2 -> one bit found
+     *   8 -> no one bit found
+     */
+    tgen_movcond_int(s, TCG_TYPE_I64, dest, a2, a2const, TCG_REG_R0, 8, 2);
+}
+
+static void tgen_clz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tgen_clz_int(s, a0, a1, a2, false);
+}
+
+static void tgen_clzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_clz_int(s, a0, a1, a2, true);
+}
+
+static TCGConstraintSetIndex cset_clz(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_I64 ? C_O1_I2(r, r, rI) : C_NotImplemented;
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_clz,
+    .out_rrr = tgen_clz,
+    .out_rri = tgen_clzi,
+};
+
 static const TCGOutOpBinary outop_divs = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2884,10 +2910,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tgen_sextract(s, args[0], args[1], args[2], args[3]);
         break;
 
-    case INDEX_op_clz_i64:
-        tgen_clz(s, args[0], args[1], args[2], const_args[2]);
-        break;
-
     case INDEX_op_ctpop_i32:
         tgen_ctpop(s, TCG_TYPE_I32, args[0], args[1]);
         break;
@@ -3387,9 +3409,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_clz_i64:
-        return C_O1_I2(r, r, rI);
-
     case INDEX_op_brcond_i32:
         return C_O0_I2(r, ri);
     case INDEX_op_brcond_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 57b26ae33b..a4fb41764b 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1318,6 +1318,10 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divs_rJ(TCGContext *s, TCGType type,
                          TCGReg a0, TCGReg a1, TCGArg a2, bool c2)
 {
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index cff215490a..04774ca9c4 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -2,6 +2,7 @@
 /* These opcodes for use between the tci generator and interpreter. */
 DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_clz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 0d15547c9f..ee7e6f15eb 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -83,8 +83,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i64:
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
         return C_O1_I2(r, r, r);
@@ -630,6 +628,20 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_clz(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_clz32
+                     : INDEX_op_clz_i64);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_clz,
+};
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -921,7 +933,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
     CASE_32_64(ctz)      /* Optional (TCG_TARGET_HAS_ctz_*). */
         tcg_out_op_rrr(s, opc, args[0], args[1], args[2]);
         break;
-- 
2.43.0


