Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10329C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmo-0005me-LR; Sun, 16 Feb 2025 18:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmQ-0005X1-Ei
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:31 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmM-0005EG-RK
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:30 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2211acda7f6so15078365ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747425; x=1740352225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vZonYmIBrRZDLHSyotdTOM9L85/OluCqKapCVoWuB4Y=;
 b=ncTqPbvAgPGGX9RQuNoDtAtBTSUwfycaNt3WPmEXyky7a9b+buK/5OLlxHHGFnjQKC
 auMMRy3/6S+fc2vLra3gjontqYn90lgmXwSOZ1AmDBO9GLHkcdnk2cafuOFi9Ck/+KCd
 Oak4hsbwbN0jHFe68L121RhZNOY5tuJ7ibAL6swmRivz1R5bWdmY33+q2ZNj3wLKqx10
 UQ1MjU1LtfERjozyCKPqhBQc1nGo/FLknR/dMLaDbAQn97NwksjTog8KP29AbnYUOQ0W
 bd6n+XjbmIoSEQqIHJmM2uYcBdnD3qvy6f5QhpR6P5DHl65tAe24mw0xmRLxHXWB9QC+
 42tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747425; x=1740352225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZonYmIBrRZDLHSyotdTOM9L85/OluCqKapCVoWuB4Y=;
 b=iIkDFbaWHY5Wgz+DdtvkVCXi4ftZitxkf8c5j2uRCq0aGTst3ODJzF95sxajHuGJC5
 2DUX16A1XvCW3eKX6allS3FTY0g3wY+zfNgfgA+WEEpdAnoS/x3jT6e2sxcQage1u9Hz
 l3i8NtGSVbzdGJ0KSK2Xpx5Rf1lzegmSnfYBcZzscE2IKv1h1igqEY2JNj3SVonv394R
 pv2Ti3C9IDkoue8DubHYXbeK8dA8as9540SyOR6Wk51keuwJ6kRh2n5pIicGwJizeS/0
 rUPi109VQ6UuvahxIBHq+2Ne4GgS/CfKKnnaixrPrJcDtYHDRF3jCnOGzulJg3GyqY1X
 JiqA==
X-Gm-Message-State: AOJu0YzdgxjxUV2pM7lWjYIAgRMaDL2hBPBVBbq4LiEqfspOI4F0ELrY
 ynPuJrJJ1Ha1L+cZOyk/Er6cw+LtdwfdpxkSKgzKcyBI+nZil0uoPirtzd3/4Wr+jwH+9GCQ51d
 D
X-Gm-Gg: ASbGncuhAbGWvB8EyIdKIcoXEqe6wY6ehMcdL3XdwVIswCKLrpSCM4gXCcbCvmMkTTp
 trnGqQ9w+e3Q4yJ8FX/0vxj9IAeN5iPzsd6WV8uPSSH+hFOauj4bkupF+Jiq7/VzbRy6aO6vuH7
 wfL5H1aRKTh+XMUCQlD6Gg8LBrJnfZTwh3vffraFhNahxsIecj5xYpQ1cccGXEg6CGvtAhUCYN9
 CghfFP8YCA+y6UpMU0yI0AF2psJpDpBJVgVT3QOTyaNojnq6D41qWdeWzoWhjNrWGbmuoSSa1bk
 9JR2/MJ0kcusnBBU/hYls1mCrBxbT05qpoFi2YfbR2t5ajA=
X-Google-Smtp-Source: AGHT+IFdxuA/My6Hmf7DhbLCZAxjRH+65AGCT5cQIYe399iF++/cuDz3Q0NF74PaVbIHB9ruefKoRw==
X-Received: by 2002:a17:902:e88d:b0:220:cab1:810e with SMTP id
 d9443c01a7336-22103ef206cmr114344465ad.6.1739747425151; 
 Sun, 16 Feb 2025 15:10:25 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 015/162] tcg: Convert orc to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:07:44 -0800
Message-ID: <20250216231012.2808572-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
 tcg/aarch64/tcg-target.c.inc         | 24 ++++++++---------
 tcg/arm/tcg-target.c.inc             |  4 +++
 tcg/i386/tcg-target.c.inc            |  4 +++
 tcg/loongarch64/tcg-target.c.inc     | 40 ++++++++++------------------
 tcg/mips/tcg-target.c.inc            |  4 +++
 tcg/ppc/tcg-target.c.inc             | 22 +++++++--------
 tcg/riscv/tcg-target.c.inc           | 22 ++++++++-------
 tcg/s390x/tcg-target.c.inc           | 36 +++++++++++--------------
 tcg/sparc64/tcg-target.c.inc         | 16 +++++++----
 tcg/tci/tcg-target.c.inc             | 14 +++++++---
 26 files changed, 104 insertions(+), 118 deletions(-)

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
index b7c9b89e9e..b4af4f5423 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -23,7 +23,6 @@ C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
 C_O1_I2(r, r, r)
-C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
diff --git a/tcg/loongarch64/tcg-target-con-str.h b/tcg/loongarch64/tcg-target-con-str.h
index 99759120b4..e5e57452d6 100644
--- a/tcg/loongarch64/tcg-target-con-str.h
+++ b/tcg/loongarch64/tcg-target-con-str.h
@@ -23,7 +23,6 @@ REGS('w', ALL_VECTOR_REGS)
 CONST('I', TCG_CT_CONST_S12)
 CONST('J', TCG_CT_CONST_S32)
 CONST('U', TCG_CT_CONST_U12)
-CONST('C', TCG_CT_CONST_C12)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('M', TCG_CT_CONST_VCMP)
 CONST('A', TCG_CT_CONST_VADD)
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 71d91fec19..fb1142958c 100644
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
@@ -46,7 +45,6 @@
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
index a3918bf7f5..7b8f4386c9 100644
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
@@ -45,7 +44,6 @@
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
index 88ab792814..f216dfda6b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1008,6 +1008,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
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
@@ -5436,6 +5434,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_or:
+    case INDEX_op_orc_i32:
+    case INDEX_op_orc_i64:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 3e361be6bd..7a926b30db 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -551,12 +551,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
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
index 4b62e4e382..13592303a8 100644
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
@@ -2256,17 +2267,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
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
@@ -3025,8 +3025,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
         return C_O1_I2(r, r, rL);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index cd9010a357..76d24e0440 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1905,6 +1905,10 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 3e974924d4..d278e61b85 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2653,6 +2653,10 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 2853563405..9bfe1d6d6b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -176,10 +176,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_S12   0x100
 #define TCG_CT_CONST_S32   0x200
 #define TCG_CT_CONST_U12   0x400
-#define TCG_CT_CONST_C12   0x800
-#define TCG_CT_CONST_WSZ   0x1000
-#define TCG_CT_CONST_VCMP  0x2000
-#define TCG_CT_CONST_VADD  0x4000
+#define TCG_CT_CONST_WSZ   0x800
+#define TCG_CT_CONST_VCMP  0x1000
+#define TCG_CT_CONST_VADD  0x2000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -205,9 +204,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_U12) && val >= 0 && val <= 0xfff) {
         return true;
     }
-    if ((ct & TCG_CT_CONST_C12) && ~val >= 0 && ~val <= 0xfff) {
-        return true;
-    }
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return true;
     }
@@ -1338,6 +1334,17 @@ static const TCGOutOpBinary outop_or = {
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
@@ -1388,16 +1395,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2280,15 +2277,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_ld_i64:
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
index 74eef1d3b3..f6987963ec 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1730,6 +1730,10 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b638a5f813..ccd7812016 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2972,6 +2972,17 @@ static const TCGOutOpBinary outop_or = {
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
@@ -3066,15 +3077,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -4140,7 +4142,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O0_I2(r, r);
 
     case INDEX_op_xor_i32:
-    case INDEX_op_orc_i32:
     case INDEX_op_eqv_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -4166,7 +4167,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_nor_i32:
     case INDEX_op_muluh_i32:
     case INDEX_op_mulsh_i32:
-    case INDEX_op_orc_i64:
     case INDEX_op_eqv_i64:
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 9bacd109d4..14216e9dff 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2031,6 +2031,18 @@ static const TCGOutOpBinary outop_or = {
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
@@ -2118,14 +2130,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2699,8 +2703,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
         return C_O1_I2(r, r, rJ);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 9267aef544..97587939bd 100644
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
@@ -2585,15 +2592,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -3292,10 +3290,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rK);
 
-    case INDEX_op_orc_i32:
     case INDEX_op_eqv_i32:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_orc_i64:
     case INDEX_op_eqv_i64:
         return C_O1_I2(r, r, rNK);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index b01d55c80b..38b325e8a9 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1351,6 +1351,17 @@ static const TCGOutOpBinary outop_or = {
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
@@ -1408,9 +1419,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(orc):
-        c = ARITH_ORN;
-        goto gen_arith;
     OP_32_64(xor):
         c = ARITH_XOR;
         goto gen_arith;
@@ -1627,8 +1635,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
     case INDEX_op_shl_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4214b76b34..2e45cc4768 100644
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
@@ -677,6 +675,17 @@ static const TCGOutOpBinary outop_or = {
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
@@ -722,7 +731,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     CASE_32_64(sub)
     CASE_32_64(mul)
     CASE_32_64(xor)
-    CASE_32_64(orc)      /* Optional (TCG_TARGET_HAS_orc_*). */
     CASE_32_64(eqv)      /* Optional (TCG_TARGET_HAS_eqv_*). */
     CASE_32_64(nand)     /* Optional (TCG_TARGET_HAS_nand_*). */
     CASE_32_64(nor)      /* Optional (TCG_TARGET_HAS_nor_*). */
-- 
2.43.0


