Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BC5E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bL-0003PF-Me; Tue, 07 Jan 2025 03:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aj-0000kk-7Y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:35 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aZ-0003Qj-Vz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:32 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so229446695ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237122; x=1736841922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zF1utvuRJTcSexB3Zueskj1+Bi3IMh2EmDHkZCqSvb0=;
 b=ye7Bz0kjTY/XD4T7vh4FK4YcR2dLXtZfuzAJyb31Lb+u9BihfihMHbP1fSma4gEjIh
 bMiDe7lWjjUlcG4wwa6Xt6Bf2dOFhFDIz3CvgH9Hbu6KN2cL0frkyC5kMEz6ZIS/3/U3
 D5f6RqSUKTvjbmSL9Phlmm8S4k0ePoJv/GstXaxAd/Zfud3ORK9X7rbvVMCCB6+cPws1
 /NkQMZ9MK1uwXYl+XQN/IyAJli3gPM6qYxklmtIjHO2cl0NOhIFLULYeDo7mFDsmxsck
 bZuDWoHsH3KFaWFSLX1iXvtc7UIb1VTXaUQLEGbxh8cD5Ox5YIXYrWKqUXFJcLwpOK4g
 RMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237122; x=1736841922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zF1utvuRJTcSexB3Zueskj1+Bi3IMh2EmDHkZCqSvb0=;
 b=CwtxfS8/CW3I5Q14NUt9Kclbt4XjX6vb+zfOruTODsYiA3vWmZ3eXR2aZUG7kQOeit
 LbLQHTRicI3PaoC7UNgf3/WMu3hi4FW5sk/R0TeYmkWXmcvNl+Hg1iFCjXjpCfBOATkh
 klKC86d/Rav7fs4LUUQGfDblzzZknunt+5xqCfP1d+siDMuvMIQzeq7KKbtfwjoTRPAD
 PGkxxxkS5wurc2mK1RcZBtcBVkMDpWMtoRip1g8/ktjYKqLNEalPL6rZC0Xkvh3s1cTp
 J7dkFUCiiF8HBIks+MvjprZFDYWS02gLAY1KrJsxxyq5Hre8v16BzcmNs/ssrDUqsPly
 S/lw==
X-Gm-Message-State: AOJu0YznaxMG6hpa+9fSVmpFOuUZ8CdSZYlRh38CgC8kqllN9/6Xf95a
 0yy5uBnLnwewD8YZNRscqeOchZuCBcoEtddkZMa/tBIv5u2Z0ONoJ5Pi7c4sfyWort63Tj+dZ2T
 f
X-Gm-Gg: ASbGncsKuWpowqImDYrzZn4gBgvI1sS83k1Wavl08muOu2iV8feeHAXOmiBEb1UiFVn
 9yeaH2rUpaLoMRtXGKxgLmNyFkOhQD66+3pKHNKX2pscTWe8VWA7Zr2TdKPVeFZw3EOawo8/HpL
 ECp4ARBBI3J3uvWgOiQBbg0mq5BLoT+vrKCnXrz+5XvsnlKnt8+lZ/Ia5OiqU78Q58kRxw5HM3F
 lrdRn07apeeWlSZLCKzL+/l8cpkOd4eKBTUPQMGsrJPdAtdI9wJX3iEngLaXTOuMPvVvAGZe0g6
 09eamswn02ALiNzg2g==
X-Google-Smtp-Source: AGHT+IFFs4IUMOIwzmPS295HdisbWmZfKfMmrRcDbJLlitHslFu0pt8mfIGE9VUvdv5IieNsGhTyxw==
X-Received: by 2002:a05:6a20:a111:b0:1e1:b878:de64 with SMTP id
 adf61e73a8af0-1e7374422e8mr3447247637.6.1736237121475; 
 Tue, 07 Jan 2025 00:05:21 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 63/81] tcg: Convert orc to TCGOutOpBinary
Date: Tue,  7 Jan 2025 00:00:54 -0800
Message-ID: <20250107080112.1175095-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
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

At the same time, drop all backend support for immediate
operands, as we now transform orc to or during optimize.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h         |  2 --
 tcg/arm/tcg-target-has.h             |  1 -
 tcg/i386/tcg-target-has.h            |  2 --
 tcg/loongarch64/tcg-target-con-set.h |  1 -
 tcg/loongarch64/tcg-target-con-str.h |  1 -
 tcg/loongarch64/tcg-target-has.h     |  2 --
 tcg/mips/tcg-target-has.h            |  2 --
 tcg/ppc/tcg-target-has.h             |  2 --
 tcg/riscv/tcg-target-has.h           |  2 --
 tcg/s390x/tcg-target-has.h           |  2 --
 tcg/sparc64/tcg-target-has.h         |  2 --
 tcg/tcg-has.h                        |  1 -
 tcg/tci/tcg-target-has.h             |  2 --
 tcg/tcg-op.c                         |  4 +--
 tcg/tcg.c                            |  8 +++---
 tcg/tci.c                            |  2 --
 tcg/aarch64/tcg-target.c.inc         | 24 +++++++++---------
 tcg/arm/tcg-target.c.inc             |  4 +++
 tcg/i386/tcg-target.c.inc            |  4 +++
 tcg/loongarch64/tcg-target.c.inc     | 37 +++++++++++-----------------
 tcg/mips/tcg-target.c.inc            |  4 +++
 tcg/ppc/tcg-target.c.inc             | 22 ++++++++---------
 tcg/riscv/tcg-target.c.inc           | 22 +++++++++--------
 tcg/s390x/tcg-target.c.inc           | 36 ++++++++++++---------------
 tcg/sparc64/tcg-target.c.inc         | 16 ++++++++----
 tcg/tci/tcg-target.c.inc             | 14 ++++++++---
 26 files changed, 104 insertions(+), 115 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 851f6b01b4..8469a9446f 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -19,7 +19,6 @@
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
@@ -44,7 +43,6 @@
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          1
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 0268858a3b..39dcc87fe8 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -28,7 +28,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_orc_i32          0
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index b29b70357a..e525f23c05 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -31,7 +31,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_orc_i32          0
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
@@ -56,7 +55,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_orc_i64          0
 #define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index cae6c2aad6..6517d0309f 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -22,7 +22,6 @@ C_O0_I3(r, r, r)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
-C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
diff --git a/tcg/loongarch64/tcg-target-con-str.h b/tcg/loongarch64/tcg-target-con-str.h
index 2ba9c135ac..e7d2686db3 100644
--- a/tcg/loongarch64/tcg-target-con-str.h
+++ b/tcg/loongarch64/tcg-target-con-str.h
@@ -24,7 +24,6 @@ CONST('I', TCG_CT_CONST_S12)
 CONST('J', TCG_CT_CONST_S32)
 CONST('U', TCG_CT_CONST_U12)
 CONST('Z', TCG_CT_CONST_ZERO)
-CONST('C', TCG_CT_CONST_C12)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('M', TCG_CT_CONST_VCMP)
 CONST('A', TCG_CT_CONST_VADD)
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 76d731abad..46300f22cd 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -25,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          1
@@ -48,7 +47,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 6a6d4377e7..b3dfa390f9 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -43,7 +43,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_orc_i32          0
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
@@ -62,7 +61,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_nor_i64          1
-#define TCG_TARGET_HAS_orc_i64          0
 #define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_add2_i64         0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 63bb66f446..6f3ab41ebb 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -23,7 +23,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         1
 #define TCG_TARGET_HAS_nor_i32          1
@@ -49,7 +48,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          1
 #define TCG_TARGET_HAS_nand_i64         1
 #define TCG_TARGET_HAS_nor_i64          1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 8d18c4d88a..f541a36c43 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -25,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_orc_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_eqv_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
@@ -47,7 +46,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_orc_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_eqv_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 15ec0dc2ff..850c16a164 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -34,7 +34,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_orc_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_eqv_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nand_i32       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nor_i32        HAVE_FACILITY(MISC_INSN_EXT3)
@@ -58,7 +57,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_orc_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_eqv_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nand_i64       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nor_i64        HAVE_FACILITY(MISC_INSN_EXT3)
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 510b9e64a4..8e20e4cdeb 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -20,7 +20,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
@@ -45,7 +44,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 7e4301521e..df9c951262 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_not_i64          0
-#define TCG_TARGET_HAS_orc_i64          0
 #define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index e09d366517..d247774e52 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -19,7 +19,6 @@
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
@@ -42,7 +41,6 @@
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_muls2_i64        1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6807f4eebd..503d395ac8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -710,7 +710,7 @@ void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_orc_i32) {
+    if (tcg_op_supported(INDEX_op_orc_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_orc_i32, ret, arg1, arg2);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2318,7 +2318,7 @@ void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_orc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_orc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (TCG_TARGET_HAS_orc_i64) {
+    } else if (tcg_op_supported(INDEX_op_orc_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_orc_i64, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1edb422fff..672e8ce40e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -995,6 +995,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
+    OUTOP(INDEX_op_orc_i32, TCGOutOpBinary, outop_orc),
+    OUTOP(INDEX_op_orc_i64, TCGOutOpBinary, outop_orc),
 };
 
 #undef OUTOP
@@ -2271,8 +2273,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap32_i32;
     case INDEX_op_not_i32:
         return TCG_TARGET_HAS_not_i32;
-    case INDEX_op_orc_i32:
-        return TCG_TARGET_HAS_orc_i32;
     case INDEX_op_eqv_i32:
         return TCG_TARGET_HAS_eqv_i32;
     case INDEX_op_nand_i32:
@@ -2345,8 +2345,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap64_i64;
     case INDEX_op_not_i64:
         return TCG_TARGET_HAS_not_i64;
-    case INDEX_op_orc_i64:
-        return TCG_TARGET_HAS_orc_i64;
     case INDEX_op_eqv_i64:
         return TCG_TARGET_HAS_eqv_i64;
     case INDEX_op_nand_i64:
@@ -5427,6 +5425,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_or:
+    case INDEX_op_orc_i32:
+    case INDEX_op_orc_i64:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 2c0366e2dd..9f31af67b1 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -561,12 +561,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & ~regs[r2];
             break;
-#if TCG_TARGET_HAS_orc_i32 || TCG_TARGET_HAS_orc_i64
         CASE_32_64(orc)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | ~regs[r2];
             break;
-#endif
 #if TCG_TARGET_HAS_eqv_i32 || TCG_TARGET_HAS_eqv_i64
         CASE_32_64(eqv)
             tci_args_rrr(insn, &r0, &r1, &r2);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index cf7758b39a..e6960366bc 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2175,6 +2175,17 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static void tgen_orc(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3510, ORN, type, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_orc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2260,17 +2271,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_orc_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_orc_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_ORRI, ext, a0, a1, ~a2);
-        } else {
-            tcg_out_insn(s, 3510, ORN, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_xor_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -3037,8 +3037,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
         return C_O1_I2(r, r, rL);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index f935d13138..9e66a3be92 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1925,6 +1925,10 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 22dd190cf3..c312950477 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2718,6 +2718,10 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 498d560538..0b91380e52 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -177,10 +177,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_S12   0x200
 #define TCG_CT_CONST_S32   0x400
 #define TCG_CT_CONST_U12   0x800
-#define TCG_CT_CONST_C12   0x1000
-#define TCG_CT_CONST_WSZ   0x2000
-#define TCG_CT_CONST_VCMP  0x4000
-#define TCG_CT_CONST_VADD  0x8000
+#define TCG_CT_CONST_WSZ   0x1000
+#define TCG_CT_CONST_VCMP  0x2000
+#define TCG_CT_CONST_VADD  0x4000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -1342,6 +1341,17 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static void tgen_orc(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_orn(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_orc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1392,16 +1402,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
-        if (c2) {
-            /* guaranteed to fit due to constraint */
-            tcg_out_opc_ori(s, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_orn(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
         if (c2) {
@@ -2296,15 +2296,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_ld_a64_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
-        /*
-         * LoongArch insns for these ops don't have reg-imm forms, but we
-         * can express using andi/ori if ~constant satisfies
-         * TCG_CT_CONST_U12.
-         */
-        return C_O1_I2(r, r, rC);
-
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index c4f5f2492a..6ace0c501d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1753,6 +1753,10 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 8fd73ea4d1..b8e80ca8a9 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3010,6 +3010,17 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static void tgen_orc(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, ORC | SAB(a1, a0, a2));
+}
+
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_orc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3104,15 +3115,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out32(s, XOR | SAB(a1, a0, a2));
         }
         break;
-    case INDEX_op_orc_i32:
-        if (const_args[2]) {
-            tcg_out_ori32(s, args[0], args[1], ~args[2]);
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_orc_i64:
-        tcg_out32(s, ORC | SAB(args[1], args[0], args[2]));
-        break;
     case INDEX_op_eqv_i32:
         if (const_args[2]) {
             tcg_out_xori32(s, args[0], args[1], ~args[2]);
@@ -4214,7 +4216,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O0_I2(r, r);
 
     case INDEX_op_xor_i32:
-    case INDEX_op_orc_i32:
     case INDEX_op_eqv_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -4240,7 +4241,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_nor_i32:
     case INDEX_op_muluh_i32:
     case INDEX_op_mulsh_i32:
-    case INDEX_op_orc_i64:
     case INDEX_op_eqv_i64:
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index ff0741b12c..0712a24d1c 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2034,6 +2034,18 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static void tgen_orc(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_ORN, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zbb_rrr,
+    .out_rrr = tgen_orc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2121,14 +2133,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ORI, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_ORN, a0, a1, a2);
-        }
-        break;
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
         if (c2) {
@@ -2700,8 +2704,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
         return C_O1_I2(r, r, rJ);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 35feaeb35c..159fe925b6 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2267,6 +2267,22 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori_3,
 };
 
+static void tgen_orc(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, OCRK, a0, a1, a2);
+    } else {
+        tcg_out_insn(s, RRFa, OCGRK, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_misc3_rrr,
+    .out_rrr = tgen_orc,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2347,15 +2363,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_orc_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_ori(s, a0, (uint32_t)~a2);
-        } else {
-            tcg_out_insn(s, RRFa, OCRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_eqv_i32:
         a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
@@ -2591,15 +2598,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_orc_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_ori(s, a0, ~a2);
-        } else {
-            tcg_out_insn(s, RRFa, OCGRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_eqv_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
@@ -3298,10 +3296,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rK);
 
-    case INDEX_op_orc_i32:
     case INDEX_op_eqv_i32:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_orc_i64:
     case INDEX_op_eqv_i64:
         return C_O1_I2(r, r, rNK);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 4c50b33105..343faf099f 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1354,6 +1354,17 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static void tgen_orc(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_ORN);
+}
+
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_orc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1411,9 +1422,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(orc):
-        c = ARITH_ORN;
-        goto gen_arith;
     OP_32_64(xor):
         c = ARITH_XOR;
         goto gen_arith;
@@ -1638,8 +1646,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
     case INDEX_op_shl_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index c8b0d8c631..7ad0d44b82 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -101,8 +101,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
     case INDEX_op_shl_i32:
@@ -699,6 +697,17 @@ static const TCGOutOpBinary outop_or = {
     .out_rrr = tgen_or,
 };
 
+static void tgen_orc(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_orc_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_orc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -744,7 +753,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     CASE_32_64(sub)
     CASE_32_64(mul)
     CASE_32_64(xor)
-    CASE_32_64(orc)      /* Optional (TCG_TARGET_HAS_orc_*). */
     CASE_32_64(eqv)      /* Optional (TCG_TARGET_HAS_eqv_*). */
     CASE_32_64(nand)     /* Optional (TCG_TARGET_HAS_nand_*). */
     CASE_32_64(nor)      /* Optional (TCG_TARGET_HAS_nor_*). */
-- 
2.43.0


