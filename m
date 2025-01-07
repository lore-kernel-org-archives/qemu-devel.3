Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E492DE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4c4-0006pM-SK; Tue, 07 Jan 2025 03:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4an-0000wh-Fn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:38 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ae-0003dF-72
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:37 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21634338cfdso1927815ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237127; x=1736841927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CskswLFNyUz/TTkusI0hOFc4HJhYB1Cbnl+fXteNrSM=;
 b=PseqMgNOKWfU2Pf+EbtHkl5SkFZfg9VdcbSShTRwn4I8VIH8cObVlcqGptsq5K9brJ
 uiet1SyUk2s73/HsVp4NymxwrgwyK+B8R9rM2tS0Qbw8RdgLGrmcn5EmyCj8KXX7ONjo
 9o7id2btppISNkWaY1UTn5ayd79ozaC7djF7rCpdhGbfXnFMdi1LZGPT9zhmmOK+cDQu
 kw63eOm5CW9xgAt92OPO1ecwNfWSQr5mOF8YTpLNMlJK8GsNkeM0Lg6NaxMqdQpH+2oN
 jpVz3h8XgSQN/Cu22OTSZSQ9lTNzaCmnDrDyxGlcHvBREmiZi2ut19yjsQCFzTX/bqAT
 hXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237127; x=1736841927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CskswLFNyUz/TTkusI0hOFc4HJhYB1Cbnl+fXteNrSM=;
 b=lkNDctvjZ+B6Xb0hNWlAnzu36hLkvtsaRZtSzZsseyX4TjS9lIXIhVi7NgvGfuEax+
 7c7ZHbEALgJEc1CXgFQ6QgG3pDGNvDAkzHmTJ2nd33e1U3hNptDun0gmQVhoiSaQ4s7L
 FOyx7ZTXuX6Wrh3ZbPU13skgIMWngaVPOdCOSTLM0ZaAE88YpDy5MgK70CcZf3Flix76
 KFRr7qpKDcU1oMJm88dufzvomK5uMzI76OWBRl+j0075eKW8synMtAUrT2qhhg01Rdph
 PjyQxbKe5xLq7JOzRmvWw5oXtDE08T9eKI5O71vFgjrkJf48vgXqkQoZ08oNhATuvmcu
 CbQA==
X-Gm-Message-State: AOJu0Yzs8bynayu+rc9pX5dftdOs9UNFZEAHhofOzV6gTPQ6eFwsYCSp
 p7HTSHnlsdQn8+fGWDegDeDruU4KI26+tcHcxADLEimy6lEfsgWwCMJlPbg0bNgVvh7/VRFFR7q
 I
X-Gm-Gg: ASbGncvRt/oaKmPxK9+7LDLqLzeOKenu0HVNyrzQYfr3VQxFdfO3GKnSqxM6sAxQhRZ
 bCO8vyGBTydxPmVsNAL38RErcsf+bh7LB+jVXXH/gG8j82HYI1IX8ByuE5jF58D0y5R6R/FggTb
 P3GBS/xxAfmNbwVns3iW63PiP4IfWkzJO0Lzpcu0/WlPXVOfCnFn+u7YliIJbhrg1ExDXQ+n9J/
 jsrF3D7UHb4/c45XOm7hSlZVMQ4HZb5d2ZpW+PZgK5wW1V82eurExWW1x2vFJ9uqVt9qN1azGz2
 ya6tGw5J6dk+kqVfYQ==
X-Google-Smtp-Source: AGHT+IE2dPmRmzZn/pDI7hAkkpvwXJTbKmYvc+rDyKhHnvpJwLzCqrTCIWaOWlI+FnL25SEUKUzZFQ==
X-Received: by 2002:a05:6a21:100f:b0:1e0:d851:cda5 with SMTP id
 adf61e73a8af0-1e5e0459bd1mr96627566637.14.1736237126711; 
 Tue, 07 Jan 2025 00:05:26 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 68/81] tcg: Convert eqv to TCGOutOpBinary
Date: Tue,  7 Jan 2025 00:00:59 -0800
Message-ID: <20250107080112.1175095-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 tcg/aarch64/tcg-target-has.h     |  2 --
 tcg/arm/tcg-target-has.h         |  1 -
 tcg/i386/tcg-target-has.h        |  2 --
 tcg/loongarch64/tcg-target-has.h |  2 --
 tcg/mips/tcg-target-has.h        |  2 --
 tcg/ppc/tcg-target-has.h         |  2 --
 tcg/riscv/tcg-target-con-set.h   |  1 -
 tcg/riscv/tcg-target-con-str.h   |  1 -
 tcg/riscv/tcg-target-has.h       |  2 --
 tcg/s390x/tcg-target-con-set.h   |  1 -
 tcg/s390x/tcg-target-has.h       |  2 --
 tcg/sparc64/tcg-target-has.h     |  2 --
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 --
 tcg/tcg-op.c                     |  4 ++--
 tcg/tcg.c                        |  8 +++----
 tcg/tci.c                        |  2 --
 tcg/aarch64/tcg-target.c.inc     | 26 +++++++++------------
 tcg/arm/tcg-target.c.inc         |  4 ++++
 tcg/i386/tcg-target.c.inc        |  4 ++++
 tcg/loongarch64/tcg-target.c.inc |  4 ++++
 tcg/mips/tcg-target.c.inc        |  4 ++++
 tcg/ppc/tcg-target.c.inc         | 22 +++++++++---------
 tcg/riscv/tcg-target.c.inc       | 37 ++++++++++++------------------
 tcg/s390x/tcg-target.c.inc       | 39 +++++++++++++-------------------
 tcg/sparc64/tcg-target.c.inc     |  4 ++++
 tcg/tci/tcg-target.c.inc         | 14 +++++++++---
 27 files changed, 89 insertions(+), 106 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 8469a9446f..c17aafc3bb 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -19,7 +19,6 @@
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
@@ -43,7 +42,6 @@
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_eqv_i64          1
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 39dcc87fe8..9ed85798e7 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -28,7 +28,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index e525f23c05..0183cafe61 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -31,7 +31,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
@@ -55,7 +54,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 46300f22cd..4c38ed7b42 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -25,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
@@ -47,7 +46,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index b3dfa390f9..9745c64db1 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -43,7 +43,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
@@ -61,7 +60,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_nor_i64          1
-#define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 6f3ab41ebb..8ede19bfad 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -23,7 +23,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         1
 #define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
@@ -48,7 +47,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_eqv_i64          1
 #define TCG_TARGET_HAS_nand_i64         1
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index e98add0429..32a435092a 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -16,7 +16,6 @@ C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
-C_O1_I2(r, r, rJ)
 C_O1_I2(r, rZ, rN)
 C_O1_I2(r, rZ, rZ)
 C_N1_I2(r, r, rM)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index 089efe96ca..33577da7bf 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -16,7 +16,6 @@ REGS('v', ALL_VECTOR_REGS)
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
 CONST('I', TCG_CT_CONST_S12)
-CONST('J', TCG_CT_CONST_J12)
 CONST('K', TCG_CT_CONST_S5)
 CONST('L', TCG_CT_CONST_CMP_VI)
 CONST('N', TCG_CT_CONST_N12)
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index f541a36c43..b44cd71e9c 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -25,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_eqv_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
@@ -46,7 +45,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_eqv_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 39903a60ad..86af067965 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -31,7 +31,6 @@ C_O1_I2(r, r, rC)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rK)
-C_O1_I2(r, r, rNK)
 C_O1_I2(r, r, rNKR)
 C_O1_I2(r, rZ, r)
 C_O1_I2(v, v, r)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 850c16a164..722a2ede1c 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -34,7 +34,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_eqv_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nand_i32       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nor_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i32        0
@@ -57,7 +56,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_eqv_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nand_i64       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nor_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i64        1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 8e20e4cdeb..2ec5f5657c 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -20,7 +20,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          0
@@ -44,7 +43,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index df9c951262..a5808dcc0a 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_not_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index d247774e52..2c0876a0fd 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -12,7 +12,6 @@
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         1
 #define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
@@ -34,7 +33,6 @@
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_eqv_i64          1
 #define TCG_TARGET_HAS_nand_i64         1
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b10f61435c..8008b0d3e0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -680,7 +680,7 @@ void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_eqv_i32) {
+    if (tcg_op_supported(INDEX_op_eqv_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_eqv_i32, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i32(ret, arg1, arg2);
@@ -2279,7 +2279,7 @@ void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_eqv_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_eqv_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (TCG_TARGET_HAS_eqv_i64) {
+    } else if (tcg_op_supported(INDEX_op_eqv_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_eqv_i64, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i64(ret, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b93e68fb12..a3ba8278ac 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -994,6 +994,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
+    OUTOP(INDEX_op_eqv_i32, TCGOutOpBinary, outop_eqv),
+    OUTOP(INDEX_op_eqv_i64, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -2273,8 +2275,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap32_i32;
     case INDEX_op_not_i32:
         return TCG_TARGET_HAS_not_i32;
-    case INDEX_op_eqv_i32:
-        return TCG_TARGET_HAS_eqv_i32;
     case INDEX_op_nand_i32:
         return TCG_TARGET_HAS_nand_i32;
     case INDEX_op_nor_i32:
@@ -2344,8 +2344,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap64_i64;
     case INDEX_op_not_i64:
         return TCG_TARGET_HAS_not_i64;
-    case INDEX_op_eqv_i64:
-        return TCG_TARGET_HAS_eqv_i64;
     case INDEX_op_nand_i64:
         return TCG_TARGET_HAS_nand_i64;
     case INDEX_op_nor_i64:
@@ -5423,6 +5421,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_eqv_i32:
+    case INDEX_op_eqv_i64:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 2a1ae3ec42..e42251fc41 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -565,12 +565,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | ~regs[r2];
             break;
-#if TCG_TARGET_HAS_eqv_i32 || TCG_TARGET_HAS_eqv_i64
         CASE_32_64(eqv)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] ^ regs[r2]);
             break;
-#endif
 #if TCG_TARGET_HAS_nand_i32 || TCG_TARGET_HAS_nand_i64
         CASE_32_64(nand)
             tci_args_rrr(insn, &r0, &r1, &r2);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 52aba83936..e0d8a8e428 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2157,6 +2157,17 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_eqv(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3510, EON, type, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_eqv,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2289,17 +2300,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_eqv_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_eqv_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_EORI, ext, a0, a1, ~a2);
-        } else {
-            tcg_out_insn(s, 3510, EON, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_not_i64:
     case INDEX_op_not_i32:
         tcg_out_insn(s, 3510, ORN, ext, a0, TCG_REG_XZR, a1);
@@ -3042,10 +3042,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
-        return C_O1_I2(r, r, rL);
-
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index b7deca60f1..f1a6d89453 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1907,6 +1907,10 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 20bf02fb3c..8c10668b65 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2698,6 +2698,10 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 5afc825396..55e3cc6244 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1323,6 +1323,10 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 2a5546d710..c5589de2c6 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1735,6 +1735,10 @@ static const TCGOutOpBinary outop_andc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 044f41748f..32b18a2014 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2992,6 +2992,17 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_eqv(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, EQV | SAB(a1, a0, a2));
+}
+
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_eqv,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3124,15 +3135,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_eqv_i32:
-        if (const_args[2]) {
-            tcg_out_xori32(s, args[0], args[1], ~args[2]);
-            break;
-        }
-        /* FALLTHRU */
-    case INDEX_op_eqv_i64:
-        tcg_out32(s, EQV | SAB(args[1], args[0], args[2]));
-        break;
     case INDEX_op_nand_i32:
     case INDEX_op_nand_i64:
         tcg_out32(s, NAND | SAB(args[1], args[0], args[2]));
@@ -4224,7 +4226,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_eqv_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
@@ -4249,7 +4250,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_nor_i32:
     case INDEX_op_muluh_i32:
     case INDEX_op_mulsh_i32:
-    case INDEX_op_eqv_i64:
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i64:
     case INDEX_op_div_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 4d034712f7..f468eff28f 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -116,9 +116,8 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_S12     0x200
 #define TCG_CT_CONST_N12     0x400
 #define TCG_CT_CONST_M12     0x800
-#define TCG_CT_CONST_J12    0x1000
-#define TCG_CT_CONST_S5     0x2000
-#define TCG_CT_CONST_CMP_VI 0x4000
+#define TCG_CT_CONST_S5     0x1000
+#define TCG_CT_CONST_CMP_VI 0x2000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -419,13 +418,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_M12) && val >= -0x7ff && val <= 0x7ff) {
         return 1;
     }
-    /*
-     * Inverse of sign extended from 12 bits: ~[-0x800, 0x7ff].
-     * Used to map ANDN back to ANDI, etc.
-     */
-    if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
-        return 1;
-    }
     /*
      * Sign extended from 5 bits: [-0x10, 0x0f].
      * Used for vector-immediate.
@@ -2016,6 +2008,18 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_eqv(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_XNOR, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zbb_rrr,
+    .out_rrr = tgen_eqv,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2142,15 +2146,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_XORI, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_XNOR, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
         tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
@@ -2711,10 +2706,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
-        return C_O1_I2(r, r, rJ);
-
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
         return C_O1_I2(r, rZ, rN);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 585d0a73f8..d7c3059e66 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2242,6 +2242,22 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_eqv(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, NXRK, a0, a1, a2);
+    } else {
+        tcg_out_insn(s, RRFa, NXGRK, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_misc3_rrr,
+    .out_rrr = tgen_eqv,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2376,15 +2392,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_eqv_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tcg_out_insn(s, RIL, XILF, a0, ~a2);
-        } else {
-            tcg_out_insn(s, RRFa, NXRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_nand_i32:
         tcg_out_insn(s, RRFa, NNRK, args[0], args[1], args[2]);
         break;
@@ -2601,15 +2608,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_eqv_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_xori(s, a0, ~a2);
-        } else {
-            tcg_out_insn(s, RRFa, NXGRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_nand_i64:
         tcg_out_insn(s, RRFa, NNGRK, args[0], args[1], args[2]);
         break;
@@ -3296,11 +3294,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_eqv_i32:
-        return C_O1_I2(r, r, ri);
-    case INDEX_op_eqv_i64:
-        return C_O1_I2(r, r, rNK);
-
     case INDEX_op_nand_i32:
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 28150cd5b0..f0d4d8a6ea 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1342,6 +1342,10 @@ static void tgen_or(TCGContext *s, TCGType type,
     tcg_out_arith(s, a0, a1, a2, ARITH_OR);
 }
 
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_ori(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 628db04e0c..420bab3f94 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -95,8 +95,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
     case INDEX_op_nand_i32:
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
@@ -684,6 +682,17 @@ static const TCGOutOpBinary outop_andc = {
     .out_rrr = tgen_andc,
 };
 
+static void tgen_eqv(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_eqv_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_eqv,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -761,7 +770,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     CASE_32_64(sub)
     CASE_32_64(mul)
-    CASE_32_64(eqv)      /* Optional (TCG_TARGET_HAS_eqv_*). */
     CASE_32_64(nand)     /* Optional (TCG_TARGET_HAS_nand_*). */
     CASE_32_64(nor)      /* Optional (TCG_TARGET_HAS_nor_*). */
     CASE_32_64(shl)
-- 
2.43.0


