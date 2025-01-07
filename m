Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385B4E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4az-0001qi-Sw; Tue, 07 Jan 2025 03:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ae-0000fC-9V
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:30 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aV-0003Pq-HL
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:28 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166360285dso224284985ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237116; x=1736841916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5eHItbZu7nLkdr5m7FpVkWJijjohJbcFFPOfDPCt+U=;
 b=njoxMoLfyfs+ZsAwMmeca9ffIQzfck3QP061hidxlI418HYKrRiXm1iu/ZVmzpdEPi
 q9qaIj18mXL/mRrpJOtTcOD5WWJdw5dvaTwvkheI5CTeuDGvuPGw8UDBeCABBdHZiJ3k
 IuTwq1AuHhuXf37H+CvNgOTkMn5etAEvSctoz6orBhl/RSJyeqYYfqwoxI7jZOKSFVSa
 3dMhlMhHE1RreDc/up0k/Vn2o+0DeUovp3G8zsqBweKYlxXAB2icgAWEHarHSV4H13tw
 rUEJOb5mLpjf0XZQnYvE9J/1NEtlBC86MHrKD/14C++2z/AWaeN2XSwyOOqjQMdKwtGN
 /LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237116; x=1736841916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5eHItbZu7nLkdr5m7FpVkWJijjohJbcFFPOfDPCt+U=;
 b=ptDg6rH6hdp/KtCNX1rsPv3qp8al55BEI/ipgbtUwcTCS5twe0jBl7Hn55HRgAFwra
 qJCe8K6h67dQpo6bqP528XOaKHsOB31ss7UvBPXeU502NYbABCzMhPzbkSkJDL97kS5j
 3KW7hHua2wGalPt3WSsBo0fGHyA/373lpBwi+y+b0awEH58AgxlcwBLA2fFW9WoUvPBH
 oN2DhJsMVjcIC5M0gKoYXXteZrZ1dU3WBOOEMNUCoooWl15TrTNfdlHmx+zurMXTtmXI
 UGyhk2qI4S6H7WeWSLD7Dea5sfrdiQr+F+TwUYBeNmIuSifxMN6K4759J2Qd8LslKVA5
 T3yQ==
X-Gm-Message-State: AOJu0YxIKO9eJJiSoJKYkcHGz6lRY14zXucsABkrt3YqhdviNaoX3ZJO
 SV08Rmq/S2qjG6r8OBchEd3ouJAlZS0BqNhR51wmbw3Tf7g40vGT6x/cIeHWs1s6puTV/Fia047
 h
X-Gm-Gg: ASbGncsLYDA4Y1xZUU+hpv1ukILPteW4CL/Vc07yYNWvG9wcjJW+xo+snHt8HWRXGhh
 QpiYxuGyp5gezHVl+nTIqqNPogkHbcm0nYfQlIHfmnN2SDLQXUM54fGveY/YIO0yrj8VKx/gRHI
 8uVz5JhwX/EI4kV6rVveJvFHHJ08yAo9FUFBO2gs+RWDai0fDpa6WonmSK2mCx+eQ1EUHroC5+Z
 xCxG+h6ElapsaJ4gxHde67zDSdOpz7k3k8kqnhITeXT73NFFtaLcr/TqC3InxrMByASdhcNqhvv
 cu7HnzwfuxOMj1Hgwg==
X-Google-Smtp-Source: AGHT+IET1lUSVOsGMOOXg+D/rKkXaQlInC69gpRVb4W/Han7bzFyWmtfaLv/0C5AOjaXUn7yG579+g==
X-Received: by 2002:a05:6a20:d487:b0:1e1:ab51:f53e with SMTP id
 adf61e73a8af0-1e5e045869emr90333793637.5.1736237116283; 
 Tue, 07 Jan 2025 00:05:16 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 58/81] tcg: Convert andc to TCGOutOpBinary
Date: Tue,  7 Jan 2025 00:00:49 -0800
Message-ID: <20250107080112.1175095-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
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

At the same time, drop all backend support for immediate
operands, as we now transform andc to and during optimize.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h     |  2 --
 tcg/arm/tcg-target-has.h         |  1 -
 tcg/i386/tcg-target-con-set.h    |  2 +-
 tcg/i386/tcg-target-has.h        |  2 --
 tcg/loongarch64/tcg-target-has.h |  2 --
 tcg/mips/tcg-target-has.h        |  2 --
 tcg/ppc/tcg-target-has.h         |  2 --
 tcg/riscv/tcg-target-con-set.h   |  1 +
 tcg/riscv/tcg-target-has.h       |  2 --
 tcg/s390x/tcg-target-con-set.h   |  1 -
 tcg/s390x/tcg-target-has.h       |  2 --
 tcg/sparc64/tcg-target-has.h     |  2 --
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 --
 tcg/tcg-op.c                     |  4 +--
 tcg/tcg.c                        |  8 +++---
 tcg/tci.c                        |  2 --
 tcg/aarch64/tcg-target.c.inc     | 24 +++++++++---------
 tcg/arm/tcg-target.c.inc         | 16 ++++++++----
 tcg/i386/tcg-target.c.inc        | 31 +++++++++++++----------
 tcg/loongarch64/tcg-target.c.inc | 23 +++++++++--------
 tcg/mips/tcg-target.c.inc        |  4 +++
 tcg/ppc/tcg-target.c.inc         | 29 +++++++++-------------
 tcg/riscv/tcg-target.c.inc       | 27 ++++++++++++--------
 tcg/s390x/tcg-target.c.inc       | 42 ++++++++++++++++----------------
 tcg/sparc64/tcg-target.c.inc     | 16 ++++++++----
 tcg/tci/tcg-target.c.inc         | 14 ++++++++---
 27 files changed, 134 insertions(+), 130 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index bfd587c0fc..851f6b01b4 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -19,7 +19,6 @@
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         0
@@ -45,7 +44,6 @@
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          1
 #define TCG_TARGET_HAS_nand_i64         0
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 8398c80c8e..0268858a3b 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -28,7 +28,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          0
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 06e6521001..0ae9775944 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -42,9 +42,9 @@ C_O1_I2(r, 0, reZ)
 C_O1_I2(r, 0, ri)
 C_O1_I2(r, 0, rI)
 C_O1_I2(r, L, L)
+C_O1_I2(r, r, r)
 C_O1_I2(r, r, re)
 C_O1_I2(r, r, ri)
-C_O1_I2(r, r, rI)
 C_O1_I2(x, x, x)
 C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index bbf55c86b6..b29b70357a 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -31,7 +31,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         have_bmi1
 #define TCG_TARGET_HAS_orc_i32          0
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
@@ -57,7 +56,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         have_bmi1
 #define TCG_TARGET_HAS_orc_i64          0
 #define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 93885a9192..76d731abad 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -25,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
@@ -49,7 +48,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index fd96905484..6a6d4377e7 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -43,7 +43,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_andc_i32         0
 #define TCG_TARGET_HAS_orc_i32          0
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
@@ -63,7 +62,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_nor_i64          1
-#define TCG_TARGET_HAS_andc_i64         0
 #define TCG_TARGET_HAS_orc_i64          0
 #define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 9acfc574c5..63bb66f446 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -23,7 +23,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         1
@@ -50,7 +49,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          1
 #define TCG_TARGET_HAS_nand_i64         1
diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 3c4ef44eb0..e98add0429 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -13,6 +13,7 @@ C_O0_I1(r)
 C_O0_I2(rZ, r)
 C_O0_I2(rZ, rZ)
 C_O1_I1(r, r)
+C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index d4cd0fbc21..8d18c4d88a 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -25,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_orc_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_eqv_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_nand_i32         0
@@ -48,7 +47,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_orc_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_eqv_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_nand_i64         0
diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 370e4b1295..39903a60ad 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -31,7 +31,6 @@ C_O1_I2(r, r, rC)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rK)
-C_O1_I2(r, r, rKR)
 C_O1_I2(r, r, rNK)
 C_O1_I2(r, r, rNKR)
 C_O1_I2(r, rZ, r)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index aea805455f..15ec0dc2ff 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -34,7 +34,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_andc_i32       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_orc_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_eqv_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nand_i32       HAVE_FACILITY(MISC_INSN_EXT3)
@@ -59,7 +58,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_andc_i64       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_orc_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_eqv_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nand_i64       HAVE_FACILITY(MISC_INSN_EXT3)
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index ad6f35da17..510b9e64a4 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -20,7 +20,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
@@ -46,7 +45,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 4ccdc6bbee..7e4301521e 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_not_i64          0
-#define TCG_TARGET_HAS_andc_i64         0
 #define TCG_TARGET_HAS_orc_i64          0
 #define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index cb0964c3d4..e09d366517 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -11,7 +11,6 @@
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         1
@@ -36,7 +35,6 @@
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_eqv_i64          1
 #define TCG_TARGET_HAS_nand_i64         1
 #define TCG_TARGET_HAS_nor_i64          1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 82f3ad501f..68818cbb0c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -668,7 +668,7 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_andc_i32) {
+    if (tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_andc_i32, ret, arg1, arg2);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2264,7 +2264,7 @@ void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_andc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_andc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (TCG_TARGET_HAS_andc_i64) {
+    } else if (tcg_op_supported(INDEX_op_andc_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_andc_i64, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e77a24adc7..a037295710 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -993,6 +993,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     [0 ... NB_OPS - 1] = &outop_notreached,
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
+    OUTOP(INDEX_op_andc_i32, TCGOutOpBinary, outop_andc),
+    OUTOP(INDEX_op_andc_i64, TCGOutOpBinary, outop_andc),
 };
 
 #undef OUTOP
@@ -2269,8 +2271,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap32_i32;
     case INDEX_op_not_i32:
         return TCG_TARGET_HAS_not_i32;
-    case INDEX_op_andc_i32:
-        return TCG_TARGET_HAS_andc_i32;
     case INDEX_op_orc_i32:
         return TCG_TARGET_HAS_orc_i32;
     case INDEX_op_eqv_i32:
@@ -2346,8 +2346,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap64_i64;
     case INDEX_op_not_i64:
         return TCG_TARGET_HAS_not_i64;
-    case INDEX_op_andc_i64:
-        return TCG_TARGET_HAS_andc_i64;
     case INDEX_op_orc_i64:
         return TCG_TARGET_HAS_orc_i64;
     case INDEX_op_eqv_i64:
@@ -5428,6 +5426,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     case INDEX_op_add:
     case INDEX_op_and:
+    case INDEX_op_andc_i32:
+    case INDEX_op_andc_i64:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index ce7cbe566b..8d7fb385a5 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -557,12 +557,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ^ regs[r2];
             break;
-#if TCG_TARGET_HAS_andc_i32 || TCG_TARGET_HAS_andc_i64
         CASE_32_64(andc)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & ~regs[r2];
             break;
-#endif
 #if TCG_TARGET_HAS_orc_i32 || TCG_TARGET_HAS_orc_i64
         CASE_32_64(orc)
             tci_args_rrr(insn, &r0, &r1, &r2);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 8da2703bb4..06d082ffd9 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2146,6 +2146,17 @@ static const TCGOutOpBinary outop_and = {
     .out_rri = tgen_andi,
 };
 
+static void tgen_andc(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3510, BIC, type, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_andc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2231,17 +2242,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_andc_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_andc_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_ANDI, ext, a0, a1, ~a2);
-        } else {
-            tcg_out_insn(s, 3510, BIC, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_or_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -3032,8 +3032,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 87571f2621..9db2a59be1 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1896,6 +1896,17 @@ static const TCGOutOpBinary outop_and = {
     .out_rri = tgen_andi,
 };
 
+static void tgen_andc(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_BIC, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_andc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1958,10 +1969,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             args[0], args[1], args[2], const_args[2]);
         }
         break;
-    case INDEX_op_andc_i32:
-        tcg_out_dat_rIK(s, COND_AL, ARITH_BIC, ARITH_AND,
-                        args[0], args[1], args[2], const_args[2]);
-        break;
     case INDEX_op_or_i32:
         c = ARITH_ORR;
         goto gen_arith;
@@ -2233,7 +2240,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
 
-    case INDEX_op_andc_i32:
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
         return C_O1_I2(r, r, rIK);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 6d8c7a8d5c..7fc4fdd9d6 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2680,6 +2680,24 @@ static const TCGOutOpBinary outop_and = {
     .out_rri = tgen_andi,
 };
 
+static void tgen_andc(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_vex_modrm(s, OPC_ANDN + rexw, a0, a2, a1);
+}
+
+static TCGConstraintSetIndex cset_andc(TCGType type, unsigned flags)
+{
+    return have_bmi1 ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_andc,
+    .out_rrr = tgen_andc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2779,15 +2797,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(andc):
-        if (const_a2) {
-            tcg_out_mov(s, rexw ? TCG_TYPE_I64 : TCG_TYPE_I32, a0, a1);
-            tgen_arithi(s, ARITH_AND + rexw, a0, ~a2, 0);
-        } else {
-            tcg_out_vex_modrm(s, OPC_ANDN + rexw, a0, a2, a1);
-        }
-        break;
-
     OP_32_64(mul):
         if (const_a2) {
             int32_t val;
@@ -3737,10 +3746,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_xor_i64:
         return C_O1_I2(r, 0, re);
 
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
-        return C_O1_I2(r, r, rI);
-
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a0c57dad40..7503c3f25c 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1313,6 +1313,17 @@ static const TCGOutOpBinary outop_and = {
     .out_rri = tgen_andi,
 };
 
+static void tgen_andc(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_andn(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_andc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1363,16 +1374,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
-        if (c2) {
-            /* guaranteed to fit due to constraint */
-            tcg_out_opc_andi(s, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_andn(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
         if (c2) {
@@ -2286,8 +2287,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_ld_a64_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
         /*
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 2fd88b4ab8..1720ec45cd 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1731,6 +1731,10 @@ static const TCGOutOpBinary outop_and = {
     .out_rri = tgen_andi,
 };
 
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 7d282bc7aa..563471497f 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2981,6 +2981,17 @@ static const TCGOutOpBinary outop_and = {
     .out_rri = tgen_andi,
 };
 
+static void tgen_andc(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, ANDC | SAB(a1, a0, a2));
+}
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_andc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3084,22 +3095,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out32(s, XOR | SAB(a1, a0, a2));
         }
         break;
-    case INDEX_op_andc_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_andi32(s, a0, a1, ~a2);
-        } else {
-            tcg_out32(s, ANDC | SAB(a1, a0, a2));
-        }
-        break;
-    case INDEX_op_andc_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_andi64(s, a0, a1, ~a2);
-        } else {
-            tcg_out32(s, ANDC | SAB(a1, a0, a2));
-        }
-        break;
     case INDEX_op_orc_i32:
         if (const_args[2]) {
             tcg_out_ori32(s, args[0], args[1], ~args[2]);
@@ -4211,7 +4206,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_andc_i32:
     case INDEX_op_orc_i32:
     case INDEX_op_eqv_i32:
     case INDEX_op_shl_i32:
@@ -4219,7 +4213,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_andc_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 8f178a5eb7..8d56d887e0 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1999,6 +1999,23 @@ static const TCGOutOpBinary outop_and = {
     .out_rri = tgen_andi,
 };
 
+static void tgen_andc(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_ANDN, a0, a1, a2);
+}
+
+static TCGConstraintSetIndex cset_zbb_rrr(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_ZBB ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zbb_rrr,
+    .out_rrr = tgen_andc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2095,14 +2112,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_ANDN, a0, a1, a2);
-        }
-        break;
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
         if (c2) {
@@ -2684,8 +2693,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 4a2661c7ff..789e68a061 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2221,6 +2221,27 @@ static const TCGOutOpBinary outop_and = {
     .out_rri = tgen_andi_3,
 };
 
+static void tgen_andc(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, NCRK, a0, a1, a2);
+    } else {
+        tcg_out_insn(s, RRFa, NCGRK, a0, a1, a2);
+    }
+}
+
+static TCGConstraintSetIndex cset_misc3_rrr(TCGType type, unsigned flags)
+{
+    return HAVE_FACILITY(MISC_INSN_EXT3) ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_misc3_rrr,
+    .out_rrr = tgen_andc,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2312,15 +2333,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_andc_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_andi(s, TCG_TYPE_I32, a0, (uint32_t)~a2);
-	} else {
-            tcg_out_insn(s, RRFa, NCRK, a0, a1, a2);
-	}
-        break;
     case INDEX_op_orc_i32:
         a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
@@ -2574,15 +2586,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_andc_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_andi(s, TCG_TYPE_I64, a0, ~a2);
-        } else {
-            tcg_out_insn(s, RRFa, NCGRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_orc_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
@@ -3292,12 +3295,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rK);
 
-    case INDEX_op_andc_i32:
     case INDEX_op_orc_i32:
     case INDEX_op_eqv_i32:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_andc_i64:
-        return C_O1_I2(r, r, rKR);
     case INDEX_op_orc_i64:
     case INDEX_op_eqv_i64:
         return C_O1_I2(r, r, rNK);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 7af1f9824d..87a496f4a8 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1325,6 +1325,17 @@ static const TCGOutOpBinary outop_and = {
     .out_rri = tgen_andi,
 };
 
+static void tgen_andc(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_ANDN);
+}
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_andc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1382,9 +1393,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(andc):
-        c = ARITH_ANDN;
-        goto gen_arith;
     OP_32_64(or):
         c = ARITH_OR;
         goto gen_arith;
@@ -1615,8 +1623,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
     case INDEX_op_orc_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4830c3b24d..3a4c65fcec 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -95,8 +95,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
     case INDEX_op_nand_i32:
@@ -681,6 +679,17 @@ static const TCGOutOpBinary outop_and = {
     .out_rrr = tgen_and,
 };
 
+static void tgen_andc(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_andc_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_andc,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -727,7 +736,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     CASE_32_64(mul)
     CASE_32_64(or)
     CASE_32_64(xor)
-    CASE_32_64(andc)     /* Optional (TCG_TARGET_HAS_andc_*). */
     CASE_32_64(orc)      /* Optional (TCG_TARGET_HAS_orc_*). */
     CASE_32_64(eqv)      /* Optional (TCG_TARGET_HAS_eqv_*). */
     CASE_32_64(nand)     /* Optional (TCG_TARGET_HAS_nand_*). */
-- 
2.43.0


