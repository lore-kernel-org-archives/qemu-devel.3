Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E26C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnrr-0006fF-DT; Sun, 16 Feb 2025 18:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqB-00015U-07
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:26 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpz-0005Ss-EB
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:16 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220c92c857aso58800245ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747645; x=1740352445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rQkab8R6NlZIx4s5DQX8QUkpSSy9KXILJEuUlpFZ37g=;
 b=KN7jwe0PetJ60KA3qYdjUwk1XXDWV6FfxLUWkxORUDQnLjVT2g4dd/wZR9HkjoYmrH
 qknyPyVMYZ/quupZUmffcr8nnqi+yGetiaj3VO57nhVPtWh2N8pD5+AEvC6Youzm2CLG
 YgcyqDet+YkIuOizPc0iVgaSxRn0xEuySUEjOa2SvZ2umLjk7JCRuyErMObTNomi0xnF
 N8VpCyeKABbR7ZVRbHG92tRiUIqWmS7EdrVmRrx0QAa6H9YHC5Feu25Cy8qOQnorPgfr
 d7l/5OeE8vCKvKfZiRLNDGj2A+8jvkhdMrQT2vLLMtEKvMPKi0CRFCSxFVffE0zL5OaN
 OylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747645; x=1740352445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQkab8R6NlZIx4s5DQX8QUkpSSy9KXILJEuUlpFZ37g=;
 b=KjztNdL10hgUMsUlOtlR3dHW5xxp7w9opXSwh+z7xpyEFx2tkHafOPJK+Kf4ow1QQa
 Xxri45UNuAiGbc7n3d6xyXjwHMfnj4jxEgGXCzDoJi81FoomWpg4irpMgmpWFfdGLKAu
 nk244T0iI6rLRFyTH28i+pLIVtqA10FsRKCxYGdOXlZs2zAyayzpH2kZuqtKLKuEa4Dl
 VrE0OojUW0HBJLN72FMDg3eMXXBz5eos6rfXeP4r9r+XpJQmq/9FwRwR+FnGbb/SBwcJ
 HI1BgwnYAmL/XkarXV+FL0/VefRvj8lbbSaCP0a7hMn01YDTb332b64fxfoRxz1r0ocQ
 TswA==
X-Gm-Message-State: AOJu0YxpT+tQOVJP4pG7dhY7fHP1uCxKjV1OW7y/bq8y6wzWIdaT5By+
 bImEhQ03f4BVpV4Shu2tps6qfeGKhuom0Ie3koRBOHpbwXO676Ml4LYs+GfbmT99Wq/RXu1rBWh
 T
X-Gm-Gg: ASbGnctWGcF6H1WFVGqZ4BMWXWKX9MeJbuIpbt9lMd+W2vlcQSnqkiIGqqroLIxGlc8
 NzR0CJt92Nx7C7qlLNq2iSNyt+4W3vfq54/HYlLqZDD+wAXu8Tr3dtrUpDlKYkfA8f41f9hvHm6
 rIl/CtY2RX6JXcBSG4Qm+QTIfX6k1Zk3tJYlGUV5EvEO4te8E8FUaO5NFEvBxSbTHErJ/7wf6tW
 Hv1d8EKmS/1wysW1bRr2dQ3BzIEuvFpLe9xgBj0O8cbvkapufTPU0CKDze5thiS2RfTEt+4eV8W
 vqu0EyDcjXSsSCMy0xOWOFh9lsKf35ogRJb8u1dtC57CXqk=
X-Google-Smtp-Source: AGHT+IHNg2DukKKkAQmhsYTORo989z3IySCU1Uyrb1kMxIAZnMOuHLksxOf1bZ7qeaK/RitRjVGijQ==
X-Received: by 2002:a17:902:f54e:b0:215:ba2b:cd55 with SMTP id
 d9443c01a7336-221043950c0mr116023595ad.2.1739747644775; 
 Sun, 16 Feb 2025 15:14:04 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.14.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:14:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 067/162] tcg: Convert muls2 to TCGOutOpMul2
Date: Sun, 16 Feb 2025 15:08:36 -0800
Message-ID: <20250216231012.2808572-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 tcg/riscv/tcg-target-has.h       |  2 --
 tcg/s390x/tcg-target-has.h       |  2 --
 tcg/sparc64/tcg-target-con-set.h |  1 +
 tcg/sparc64/tcg-target-has.h     |  2 --
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 --
 tcg/tcg-op.c                     |  4 ++--
 tcg/tcg.c                        | 26 ++++++++++++++++++++++----
 tcg/tci.c                        | 23 ++++++++++-------------
 tcg/aarch64/tcg-target.c.inc     |  4 ++++
 tcg/arm/tcg-target.c.inc         | 25 +++++++++++++------------
 tcg/i386/tcg-target.c.inc        | 17 ++++++++++++-----
 tcg/loongarch64/tcg-target.c.inc |  4 ++++
 tcg/mips/tcg-target.c.inc        | 28 ++++++++++++++++++++--------
 tcg/ppc/tcg-target.c.inc         |  4 ++++
 tcg/riscv/tcg-target.c.inc       |  4 ++++
 tcg/s390x/tcg-target.c.inc       | 27 ++++++++++++++++++++-------
 tcg/sparc64/tcg-target.c.inc     | 29 ++++++++++++++++++++++++-----
 tcg/tci/tcg-target.c.inc         | 21 ++++++++++++++++++---
 25 files changed, 158 insertions(+), 79 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 4f1840f44e..c351db223d 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -32,7 +31,6 @@
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 1cf3911613..e1f19ffbc9 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -29,7 +29,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        1
-#define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index a71f8c7370..d63b3a3a89 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -33,7 +33,6 @@
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        1
-#define TCG_TARGET_HAS_muls2_i32        1
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
@@ -46,7 +45,6 @@
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        1
-#define TCG_TARGET_HAS_muls2_i64        1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 33a1cf2326..491ebf0d06 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -15,7 +15,6 @@
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -30,7 +29,6 @@
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
 
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 470aa16452..fd0b674402 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -40,7 +40,6 @@ extern bool use_mips32r2_instructions;
 
 /* optional instructions */
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   0
@@ -52,7 +51,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muls2_i64        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_negsetcond_i64   0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index f071435d98..e711aa0731 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -22,7 +22,6 @@
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -37,7 +36,6 @@
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index a3b634570b..7e260da61e 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -15,7 +15,6 @@
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -29,7 +28,6 @@
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 87f117ce58..52a76fc0b5 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -36,7 +36,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_add2_i32       1
 #define TCG_TARGET_HAS_sub2_i32       1
 #define TCG_TARGET_HAS_mulu2_i32      0
-#define TCG_TARGET_HAS_muls2_i32      0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
@@ -48,7 +47,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_add2_i64       1
 #define TCG_TARGET_HAS_sub2_i64       1
 #define TCG_TARGET_HAS_mulu2_i64      1
-#define TCG_TARGET_HAS_muls2_i64      HAVE_FACILITY(MISC_INSN_EXT2)
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index d90ba11443..d2ea184fa2 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -17,5 +17,6 @@ C_O1_I2(r, r, r)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, rz, rJ)
 C_O1_I4(r, rz, rJ, rI, 0)
+C_O2_I2(r, r, r, r)
 C_O2_I2(r, r, rz, rJ)
 C_O2_I4(r, r, rz, rz, rJ, rJ)
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 40e54e1543..dea0941cac 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -21,7 +21,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        1
-#define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
@@ -33,7 +32,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 97f4e83303..ac387b2544 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
 /* Turn some undef macros into true macros.  */
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 774fb149fc..a3d04b0ee2 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -11,7 +11,6 @@
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   0
-#define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -21,7 +20,6 @@
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_muls2_i64        1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0eeec47b83..8a0846a8d2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1162,7 +1162,7 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_muls2_i32) {
+    if (tcg_op_supported(INDEX_op_muls2_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op4_i32(INDEX_op_muls2_i32, rl, rh, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -2880,7 +2880,7 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_muls2_i64) {
+    if (tcg_op_supported(INDEX_op_muls2_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op4_i64(INDEX_op_muls2_i64, rl, rh, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d64e3ab2aa..8efb37fcc5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -992,6 +992,12 @@ typedef struct TCGOutOpDivRem {
                       TCGReg a0, TCGReg a1, TCGReg a4);
 } TCGOutOpDivRem;
 
+typedef struct TCGOutOpMul2 {
+    TCGOutOp base;
+    void (*out_rrrr)(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3);
+} TCGOutOpMul2;
+
 typedef struct TCGOutOpUnary {
     TCGOutOp base;
     void (*out_rr)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1);
@@ -1035,6 +1041,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
+    OUTOP(INDEX_op_muls2_i32, TCGOutOpMul2, outop_muls2),
+    OUTOP(INDEX_op_muls2_i64, TCGOutOpMul2, outop_muls2),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
     OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
@@ -2285,8 +2293,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_sub2_i32;
     case INDEX_op_mulu2_i32:
         return TCG_TARGET_HAS_mulu2_i32;
-    case INDEX_op_muls2_i32:
-        return TCG_TARGET_HAS_muls2_i32;
     case INDEX_op_bswap16_i32:
         return TCG_TARGET_HAS_bswap16_i32;
     case INDEX_op_bswap32_i32:
@@ -2336,8 +2342,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_sub2_i64;
     case INDEX_op_mulu2_i64:
         return TCG_TARGET_HAS_mulu2_i64;
-    case INDEX_op_muls2_i64:
-        return TCG_TARGET_HAS_muls2_i64;
 
     case INDEX_op_mov_vec:
     case INDEX_op_dup_vec:
@@ -5461,6 +5465,20 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_muls2_i32:
+    case INDEX_op_muls2_i64:
+        {
+            const TCGOutOpMul2 *out =
+                container_of(all_outop[op->opc], TCGOutOpMul2, base);
+
+            tcg_debug_assert(!const_args[2]);
+            tcg_debug_assert(!const_args[3]);
+            out->out_rrrr(s, type, new_args[0], new_args[1],
+                          new_args[2], new_args[3]);
+        }
+        break;
+
+
     default:
         if (def->flags & TCG_OPF_VECTOR) {
             tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
diff --git a/tcg/tci.c b/tcg/tci.c
index d58a94ff28..51cbb5760a 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -581,6 +581,16 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop_tr(regs[r1]);
             break;
+        case INDEX_op_muls2_i32:
+        case INDEX_op_muls2_i64:
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+#if TCG_TARGET_REG_BITS == 32
+            tmp64 = (int64_t)(int32_t)regs[r2] * (int32_t)regs[r3];
+            tci_write_reg64(regs, r1, r0, tmp64);
+#else
+            muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
+#endif
+            break;
 
             /* Arithmetic operations (32 bit). */
 
@@ -675,13 +685,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_write_reg64(regs, r1, r0, tmp64);
             break;
 #endif
-#if TCG_TARGET_HAS_muls2_i32
-        case INDEX_op_muls2_i32:
-            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-            tmp64 = (int64_t)(int32_t)regs[r2] * (int32_t)regs[r3];
-            tci_write_reg64(regs, r1, r0, tmp64);
-            break;
-#endif
 #if TCG_TARGET_HAS_bswap16_i32 || TCG_TARGET_HAS_bswap16_i64
         CASE_32_64(bswap16)
             tci_args_rr(insn, &r0, &r1);
@@ -745,12 +748,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             mulu64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
             break;
 #endif
-#if TCG_TARGET_HAS_muls2_i64
-        case INDEX_op_muls2_i64:
-            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-            muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
-            break;
-#endif
 #if TCG_TARGET_HAS_add2_i64
         case INDEX_op_add2_i64:
             tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 0f01fa8c20..0996c6234b 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2205,6 +2205,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static TCGConstraintSetIndex cset_mulh(TCGType type, unsigned flags)
 {
     return type == TCG_TYPE_I64 ? C_O1_I2(r, r, r) : C_NotImplemented;
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 49061d0adb..94b9aa1cd0 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -935,14 +935,6 @@ static void tcg_out_umull32(TCGContext *s, ARMCond cond, TCGReg rd0,
               (rd1 << 16) | (rd0 << 12) | (rm << 8) | rn);
 }
 
-static void tcg_out_smull32(TCGContext *s, ARMCond cond, TCGReg rd0,
-                            TCGReg rd1, TCGReg rn, TCGReg rm)
-{
-    /* smull */
-    tcg_out32(s, (cond << 28) | 0x00c00090 |
-              (rd1 << 16) | (rd0 << 12) | (rm << 8) | rn);
-}
-
 static void tcg_out_ext8s(TCGContext *s, TCGType t, TCGReg rd, TCGReg rn)
 {
     /* sxtb */
@@ -1979,6 +1971,19 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static void tgen_muls2(TCGContext *s, TCGType type,
+                       TCGReg rd0, TCGReg rd1, TCGReg rn, TCGReg rm)
+{
+    /* smull */
+    tcg_out32(s, (COND_AL << 28) | 0x00c00090 |
+              (rd1 << 16) | (rd0 << 12) | (rm << 8) | rn);
+}
+
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_O2_I2(r, r, r, r),
+    .out_rrrr = tgen_muls2,
+};
+
 static const TCGOutOpBinary outop_mulsh = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2252,9 +2257,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_mulu2_i32:
         tcg_out_umull32(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
-    case INDEX_op_muls2_i32:
-        tcg_out_smull32(s, COND_AL, args[0], args[1], args[2], args[3]);
-        break;
 
     case INDEX_op_brcond_i32:
         c = tcg_out_cmp(s, args[2], args[0], args[1], const_args[1]);
@@ -2379,7 +2381,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O1_I2(r, r, rIN);
 
     case INDEX_op_mulu2_i32:
-    case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
 
     case INDEX_op_brcond_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index b746776d09..28453e6046 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2743,6 +2743,18 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+static void tgen_muls2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_IMUL, a3);
+}
+
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_O2_I2(a, d, a, r),
+    .out_rrrr = tgen_muls2,
+};
+
 static const TCGOutOpBinary outop_mulsh = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -3136,9 +3148,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(mulu2):
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_MUL, args[3]);
         break;
-    OP_32_64(muls2):
-        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_IMUL, args[3]);
-        break;
     OP_32_64(add2):
         if (const_args[4]) {
             tgen_arithi(s, ARITH_ADD + rexw, a0, args[4], 1);
@@ -3928,8 +3937,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_mulu2_i32:
     case INDEX_op_mulu2_i64:
-    case INDEX_op_muls2_i32:
-    case INDEX_op_muls2_i64:
         return C_O2_I2(a, d, a, r);
 
     case INDEX_op_add2_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 41a4f6e2ea..b7c05a3969 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1409,6 +1409,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_mulsh(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 06831628f9..69d3f673bb 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1823,6 +1823,26 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static void tgen_muls2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
+{
+    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_MULT : OPC_DMULT;
+    tcg_out_opc_reg(s, insn, 0, a2, a3);
+    tcg_out_opc_reg(s, OPC_MFLO, a0, 0, 0);
+    tcg_out_opc_reg(s, OPC_MFHI, a1, 0, 0);
+}
+
+static TCGConstraintSetIndex cset_mul2(TCGType type, unsigned flags)
+{
+    return use_mips32r6_instructions ? C_NotImplemented : C_O2_I2(r, r, r, r);
+}
+
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mul2,
+    .out_rrrr = tgen_muls2,
+};
+
 static void tgen_mulsh(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2167,15 +2187,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_muls2_i32:
-        i1 = OPC_MULT;
-        goto do_hilo2;
     case INDEX_op_mulu2_i32:
         i1 = OPC_MULTU;
         goto do_hilo2;
-    case INDEX_op_muls2_i64:
-        i1 = OPC_DMULT;
-        goto do_hilo2;
     case INDEX_op_mulu2_i64:
         i1 = OPC_DMULTU;
     do_hilo2:
@@ -2353,9 +2367,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rz, rz);
-    case INDEX_op_muls2_i32:
     case INDEX_op_mulu2_i32:
-    case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
 
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index ab56c623c7..d4e34e3e7d 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3079,6 +3079,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_mulsh(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index a5cd18c99e..316621b285 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2117,6 +2117,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static TCGConstraintSetIndex cset_mulh(TCGType type, unsigned flags)
 {
     return type == TCG_TYPE_I32 ? C_NotImplemented : C_O1_I2(r, r, r);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 71adb0964d..71f0eb40f8 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2391,6 +2391,26 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+static void tgen_muls2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
+{
+    tcg_debug_assert((a1 & 1) == 0);
+    tcg_debug_assert(a0 == a1 + 1);
+    tcg_out_insn(s, RRFa, MGRK, a1, a2, a3);
+}
+
+static TCGConstraintSetIndex cset_muls2(TCGType type, unsigned flags)
+{
+    return (type == TCG_TYPE_I64 && HAVE_FACILITY(MISC_INSN_EXT2)
+            ? C_O2_I2(o, m, r, r) : C_NotImplemented);
+}
+
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_muls2,
+    .out_rrrr = tgen_muls2,
+};
+
 static const TCGOutOpBinary outop_mulsh = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2846,11 +2866,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_debug_assert(args[0] == args[1] + 1);
         tcg_out_insn(s, RRE, MLGR, args[1], args[3]);
         break;
-    case INDEX_op_muls2_i64:
-        tcg_debug_assert((args[1] & 1) == 0);
-        tcg_debug_assert(args[0] == args[1] + 1);
-        tcg_out_insn(s, RRFa, MGRK, args[1], args[2], args[3]);
-        break;
 
     case INDEX_op_add2_i64:
         if (const_args[4]) {
@@ -3451,8 +3466,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_mulu2_i64:
         return C_O2_I2(o, m, 0, r);
-    case INDEX_op_muls2_i64:
-        return C_O2_I2(o, m, r, r);
 
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 43ca23f593..be2072c027 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1429,6 +1429,30 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+/*
+ * The 32-bit multiply insns produce a full 64-bit result.
+ * Supporting 32-bit mul[us]2 opcodes avoids sign/zero-extensions
+ * before the actual multiply; we only need extract the high part
+ * into the separate operand.
+ */
+static TCGConstraintSetIndex cset_mul2(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_I32 ? C_O2_I2(r, r, r, r) : C_NotImplemented;
+}
+
+static void tgen_muls2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
+{
+    tcg_out_arith(s, a0, a2, a3, ARITH_SMUL);
+    tcg_out_arithi(s, a1, a0, 32, SHIFT_SRLX);
+}
+
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mul2,
+    .out_rrrr = tgen_muls2,
+};
+
 static const TCGOutOpBinary outop_mulsh = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -1696,10 +1720,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
     case INDEX_op_mulu2_i32:
         c = ARITH_UMUL;
-        goto do_mul2;
-    case INDEX_op_muls2_i32:
-        c = ARITH_SMUL;
-    do_mul2:
         /* The 32-bit multiply insns produce a full 64-bit result. */
         tcg_out_arithc(s, a0, a2, args[3], const_args[3], c);
         tcg_out_arithi(s, a1, a0, 32, SHIFT_SRLX);
@@ -1828,7 +1848,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub2_i64:
         return C_O2_I4(r, r, rz, rz, rJ, rJ);
     case INDEX_op_mulu2_i32:
-    case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, rz, rJ);
 
     default:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 1d696a087e..f568d4edb9 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -100,8 +100,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_mulu2_i32:
     case INDEX_op_mulu2_i64:
-    case INDEX_op_muls2_i32:
-    case INDEX_op_muls2_i64:
         return C_O2_I2(r, r, r, r);
 
     case INDEX_op_movcond_i32:
@@ -710,6 +708,24 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static TCGConstraintSetIndex cset_mul2(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O2_I2(r, r, r, r) : C_NotImplemented;
+}
+
+static void tgen_muls2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
+{
+    tcg_out_op_rrrr(s, glue(INDEX_op_muls2_i,TCG_TARGET_REG_BITS),
+                    a0, a1, a2, a3);
+}
+
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mul2,
+    .out_rrrr = tgen_muls2,
+};
+
 static const TCGOutOpBinary outop_mulsh = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -1009,7 +1025,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 #endif
 
     CASE_32_64(mulu2)
-    CASE_32_64(muls2)
         tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], args[3]);
         break;
 
-- 
2.43.0


