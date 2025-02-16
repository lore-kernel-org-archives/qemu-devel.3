Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F58FC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnqc-0001yT-8C; Sun, 16 Feb 2025 18:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpl-0000jq-MA
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:00 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpi-0005Qh-CF
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:57 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2212a930001so11582015ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747633; x=1740352433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3UHQ0Y6xXSXU2PF+BBXyorscbQP1Nm6+XteWwkDEJ0U=;
 b=BjyLK9turpQ8UNAgvlceZi1mvw4LsCTopvL4Q3x7McVPIlwGhIvFx7RrQyYgpGT66R
 0uJ8VYcck0u+oBkNuEoV8A7mhaK5oaN+V6HWHw+YFGrCjFQ8W1BY0mq8NPLPfJwFRr3z
 3m9UKgj1f88QAuvHt4pKCX+yqzqB0tXj49ee5Krc3+Dvf3vkp8Pn6lcmDZrRRMuu3rCx
 W8qkSEKs6cOCHbRy+9kTwNiNqWaJTE3fkrX8/IUy3XyYFrswVUjj/LpJdjNOUO28CFWt
 NgDyTQZsXbAUyAzmNRLKihcAtmu7itxOMARfe0EpYEgiKmaCwC0unu2/2Xr1H82zvri3
 N+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747633; x=1740352433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UHQ0Y6xXSXU2PF+BBXyorscbQP1Nm6+XteWwkDEJ0U=;
 b=AeM2DTOsBfswbilXp8T5hwGBVR8lWT9FSy/905qHl33dG0Tduzi9Mu4h1QMqZbFX0O
 e2WfjmWv+R7Yw8E8K+LO8basFlBdxkEzGIS/0p0R5zMcE8peUAYna9cbV96AedPnrqvC
 ezjcTt8bwhal1aYTdvcvqqV7AItESCDGue4ihBOl16jo4AcuOFRrGiY0CvRDJqX5wrhT
 YGLlK5pVAGpGxDzPsXdxMhOoRTyx0qVy1Cga2EsiSsBZ3xVU9AdzmrGFB8b1J/yv1CQO
 DCLyeCxd86x5eKF1uDth4lpUtIeknjCC5VhZ1ri1SqWZLvb4HFh8OQMFrLgCgbs8mWM6
 hv2w==
X-Gm-Message-State: AOJu0Yxp0QLaafuTThNHpzAELYMl5YiVyuKSr7bbGgzab/krg3azaV0Y
 rvKHRfAJ2Gb4VapcPO68tEHSMtHlfkahoDTZwDZGvMc6VT2ktWI2fGrW9G7UM011fNn8VlU0mvb
 d
X-Gm-Gg: ASbGncuzow/HfQufDyy5cMZ3Qs/Wehw9eqRTfJ4AhwQkKXzlb39GTSWXxoVIiDiTEnF
 Xu74rI452rqDadiHrLjCGHMa5dx1cnDGIhg1yl6xUdPryiu2gsTi13r46CRqCgmxKcWzHVFVMtO
 mKjoAMw6OktEkvaSP2x/ks7zff3U7y2+5F6tI8xFqy7/c+c0UqQaRhfuqcia0jXWWgz72GkoBQ4
 PTyylQ2Wu5xu6A8qTGEsO9bDfm7QiBkNw+/ShdZADLRdhOhuQ2Tvj9Kwe7mIq/b0f8hdsESQQGz
 JNeQ8zHtdQkMxSIOZcneJXOSXJkZMEYy9XyG05s8o8iOAeA=
X-Google-Smtp-Source: AGHT+IFqXqJ8AJCBnhWwBxlD7IaMoa/SqcXMseONropy0yegHSGKJhzCVFOa+PYVmFo9++gkCdKt2Q==
X-Received: by 2002:a17:903:2308:b0:220:d69d:78bd with SMTP id
 d9443c01a7336-221040c0aebmr88916015ad.51.1739747632525; 
 Sun, 16 Feb 2025 15:13:52 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 050/162] tcg: Convert remu to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:08:19 -0800
Message-ID: <20250216231012.2808572-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

For TCI, we're losing type information in the interpreter.
Introduce a tci-specific opcode to handle the difference.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h         |  2 --
 tcg/arm/tcg-target-has.h             |  1 -
 tcg/loongarch64/tcg-target-con-set.h |  1 -
 tcg/loongarch64/tcg-target-has.h     |  2 --
 tcg/mips/tcg-target-has.h            |  2 --
 tcg/ppc/tcg-target-has.h             |  2 --
 tcg/riscv/tcg-target-con-set.h       |  1 -
 tcg/riscv/tcg-target-has.h           |  2 --
 tcg/sparc64/tcg-target-has.h         |  2 --
 tcg/tcg-has.h                        |  9 ------
 tcg/tci/tcg-target-has.h             |  2 --
 tcg/tcg-op.c                         |  4 +--
 tcg/tcg.c                            |  8 +++---
 tcg/tci.c                            |  4 +--
 tcg/aarch64/tcg-target.c.inc         | 22 ++++++++-------
 tcg/arm/tcg-target.c.inc             |  4 +++
 tcg/i386/tcg-target.c.inc            |  4 +++
 tcg/loongarch64/tcg-target.c.inc     | 26 ++++++++++--------
 tcg/mips/tcg-target.c.inc            | 41 ++++++++++++++--------------
 tcg/ppc/tcg-target.c.inc             | 25 +++++++++--------
 tcg/riscv/tcg-target.c.inc           | 23 ++++++++--------
 tcg/s390x/tcg-target.c.inc           |  4 +++
 tcg/sparc64/tcg-target.c.inc         |  4 +++
 tcg/tci/tcg-target-opc.h.inc         |  1 +
 tcg/tci/tcg-target.c.inc             | 17 ++++++++++--
 25 files changed, 112 insertions(+), 101 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index e961668ef0..1fdff25d05 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -13,7 +13,6 @@
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_rot_i32          1
@@ -29,7 +28,6 @@
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 6ed2b49c84..32d73d3443 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -34,7 +34,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_rem_i32          0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index b4af4f5423..da84e4d49c 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -31,7 +31,6 @@ C_O1_I2(r, r, rW)
 C_O1_I2(r, 0, rz)
 C_O1_I2(r, rz, ri)
 C_O1_I2(r, rz, rJ)
-C_O1_I2(r, rz, rz)
 C_O1_I2(w, w, w)
 C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index aecd2879b8..5dfc69ae6a 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -11,7 +11,6 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_negsetcond_i32   0
-#define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
@@ -27,7 +26,6 @@
 
 /* 64-bit operations */
 #define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 9aa5bf9f1b..ab6a134796 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -39,7 +39,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_bswap16_i32      1
@@ -50,7 +49,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index f8e4c0ad3c..37e88a3193 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -17,7 +17,6 @@
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_rem_i32          have_isa_3_00
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
@@ -34,7 +33,6 @@
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_rem_i64          have_isa_3_00
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index f3a6f7a7ed..f0d3cb81bd 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -16,7 +16,6 @@ C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
-C_O1_I2(r, rz, rz)
 C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rz, rz, rM, rM)
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index e5861e5260..b3c6899887 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -11,7 +11,6 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
@@ -26,7 +25,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 35f0dd4230..42de99efbf 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,7 +14,6 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_rem_i32		0
 #define TCG_TARGET_HAS_rot_i32          0
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
@@ -30,7 +29,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_rot_i64          0
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index bae9918024..0bb829be36 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -12,8 +12,6 @@
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_div_i64          0
-#define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_rot_i64          0
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
@@ -32,13 +30,6 @@
 #define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
-#ifndef TCG_TARGET_HAS_rem_i32
-#define TCG_TARGET_HAS_rem_i32          0
-#endif
-#ifndef TCG_TARGET_HAS_rem_i64
-#define TCG_TARGET_HAS_rem_i64          0
-#endif
-
 #if !defined(TCG_TARGET_HAS_v64) \
     && !defined(TCG_TARGET_HAS_v128) \
     && !defined(TCG_TARGET_HAS_v256)
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index ccec96b610..bd51b9346d 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -9,7 +9,6 @@
 
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
@@ -25,7 +24,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6da8b30547..4ff6c9f0ab 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -649,7 +649,7 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_rem_i32) {
+    if (tcg_op_supported(INDEX_op_remu_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_remu_i32, ret, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2017,7 +2017,7 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_rem_i64) {
+    if (tcg_op_supported(INDEX_op_remu_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_remu_i64, ret, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c740d310cd..41371823d4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1041,6 +1041,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
+    OUTOP(INDEX_op_remu_i32, TCGOutOpBinary, outop_remu),
+    OUTOP(INDEX_op_remu_i64, TCGOutOpBinary, outop_remu),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
@@ -2271,8 +2273,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_negsetcond_i32:
         return TCG_TARGET_HAS_negsetcond_i32;
-    case INDEX_op_remu_i32:
-        return TCG_TARGET_HAS_rem_i32;
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
         return TCG_TARGET_HAS_rot_i32;
@@ -2327,8 +2327,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_negsetcond_i64:
         return TCG_TARGET_HAS_negsetcond_i64;
-    case INDEX_op_remu_i64:
-        return TCG_TARGET_HAS_rem_i64;
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
         return TCG_TARGET_HAS_rot_i64;
@@ -5419,6 +5417,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_rems:
+    case INDEX_op_remu_i32:
+    case INDEX_op_remu_i64:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/tcg/tci.c b/tcg/tci.c
index 6ca033f3be..bd5817a382 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -590,7 +590,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int32_t)regs[r1] % (int32_t)regs[r2];
             break;
-        case INDEX_op_remu_i32:
+        case INDEX_op_tci_remu32:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint32_t)regs[r1] % (uint32_t)regs[r2];
             break;
@@ -1082,7 +1082,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_rems:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
@@ -1101,6 +1100,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_tci_divs32:
     case INDEX_op_tci_divu32:
     case INDEX_op_tci_rems32:
+    case INDEX_op_tci_remu32:
         tci_args_rrr(insn, &r0, &r1, &r2);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
                            op_name, str_r(r0), str_r(r1), str_r(r2));
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 6e80e18a6a..8aa11e9d9d 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2287,6 +2287,18 @@ static const TCGOutOpBinary outop_rems = {
     .out_rrr = tgen_rems,
 };
 
+static void tgen_remu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3508, UDIV, type, TCG_REG_TMP0, a1, a2);
+    tcg_out_insn(s, 3509, MSUB, type, a0, TCG_REG_TMP0, a2, a1);
+}
+
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_remu,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2404,12 +2416,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_remu_i64:
-    case INDEX_op_remu_i32:
-        tcg_out_insn(s, 3508, UDIV, ext, TCG_REG_TMP0, a1, a2);
-        tcg_out_insn(s, 3509, MSUB, ext, a0, TCG_REG_TMP0, a2, a1);
-        break;
-
     case INDEX_op_shl_i64:
     case INDEX_op_shl_i32:
         if (c2) {
@@ -3085,10 +3091,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_remu_i32:
-    case INDEX_op_remu_i64:
-        return C_O1_I2(r, r, r);
-
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 318a4c3dd8..c3d0d37ca4 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1965,6 +1965,10 @@ static const TCGOutOpBinary outop_rems = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index b127a4034d..645a6956f0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2740,6 +2740,10 @@ static const TCGOutOpBinary outop_rems = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 1049563f80..cedfcda4a1 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1462,6 +1462,21 @@ static const TCGOutOpBinary outop_rems = {
     .out_rrr = tgen_rems,
 };
 
+static void tgen_remu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_mod_wu(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_mod_du(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_remu,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1712,13 +1727,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_remu_i32:
-        tcg_out_opc_mod_wu(s, a0, a1, a2);
-        break;
-    case INDEX_op_remu_i64:
-        tcg_out_opc_mod_du(s, a0, a1, a2);
-        break;
-
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
         tcg_out_setcond(s, args[3], a0, a1, a2, c2);
@@ -2383,10 +2391,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rz, rJ);
 
-    case INDEX_op_remu_i32:
-    case INDEX_op_remu_i64:
-        return C_O1_I2(r, rz, rz);
-
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, rz, rJ, rz, rz);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 079bc00d96..2ece79c746 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1893,6 +1893,27 @@ static const TCGOutOpBinary outop_rems = {
     .out_rrr = tgen_rems,
 };
 
+static void tgen_remu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (use_mips32r6_instructions) {
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_reg(s, OPC_MODU, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_DMODU, a0, a1, a2);
+        }
+    } else {
+        MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_DIVU : OPC_DDIVU;
+        tcg_out_opc_reg(s, insn, 0, a1, a2);
+        tcg_out_opc_reg(s, OPC_MFHI, a0, 0, 0);
+    }
+}
+
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_remu,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2016,24 +2037,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_remu_i32:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_MODU, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DIVU, i2 = OPC_MFHI;
-        goto do_hilo1;
-    case INDEX_op_remu_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DMODU, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DDIVU, i2 = OPC_MFHI;
-    do_hilo1:
-        tcg_out_opc_reg(s, i1, 0, a1, a2);
-        tcg_out_opc_reg(s, i2, a0, 0, 0);
-        break;
-
     case INDEX_op_muls2_i32:
         i1 = OPC_MULT;
         goto do_hilo2;
@@ -2288,9 +2291,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_remu_i32:
     case INDEX_op_setcond_i32:
-    case INDEX_op_remu_i64:
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rz, rz);
     case INDEX_op_muls2_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index c331f0d672..80ee4d04c9 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3109,6 +3109,19 @@ static const TCGOutOpBinary outop_rems = {
     .out_rrr = tgen_rems,
 };
 
+static void tgen_remu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? MODUW : MODUD;
+    tcg_out32(s, insn | TAB(a0, a1, a2));
+}
+
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mod,
+    .out_rrr = tgen_remu,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3259,10 +3272,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
         break;
 
-    case INDEX_op_remu_i32:
-        tcg_out32(s, MODUW | TAB(args[0], args[1], args[2]));
-        break;
-
     case INDEX_op_shl_i32:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
@@ -3355,10 +3364,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_remu_i64:
-        tcg_out32(s, MODUD | TAB(args[0], args[1], args[2]));
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
@@ -4213,10 +4218,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_remu_i32:
-    case INDEX_op_remu_i64:
-        return C_O1_I2(r, r, r);
-
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
     case INDEX_op_clz_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index b0a98273f1..38ba898042 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2132,6 +2132,18 @@ static const TCGOutOpBinary outop_rems = {
     .out_rrr = tgen_rems,
 };
 
+static void tgen_remu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_REMUW : OPC_REMU;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_remu,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2245,13 +2257,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_remu_i32:
-        tcg_out_opc_reg(s, OPC_REMUW, a0, a1, a2);
-        break;
-    case INDEX_op_remu_i64:
-        tcg_out_opc_reg(s, OPC_REMU, a0, a1, a2);
-        break;
-
     case INDEX_op_shl_i32:
         if (c2) {
             tcg_out_opc_imm(s, OPC_SLLIW, a0, a1, a2 & 0x1f);
@@ -2753,10 +2758,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_remu_i32:
-    case INDEX_op_remu_i64:
-        return C_O1_I2(r, rz, rz);
-
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 320268669a..8702d8c928 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2441,6 +2441,10 @@ static const TCGOutOpBinary outop_rems = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 23cca5c664..d465c8dd06 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1480,6 +1480,10 @@ static const TCGOutOpBinary outop_rems = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 2822fbffc8..82d2a38cae 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -5,3 +5,4 @@ DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_remu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 2b05da7d06..421a2a8ac7 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -79,8 +79,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_remu_i32:
-    case INDEX_op_remu_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
@@ -766,6 +764,20 @@ static const TCGOutOpBinary outop_rems = {
     .out_rrr = tgen_rems,
 };
 
+static void tgen_remu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_remu32
+                     : INDEX_op_remu_i64);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_remu,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -855,7 +867,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     CASE_32_64(sar)
     CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
-    CASE_32_64(remu)     /* Optional (TCG_TARGET_HAS_div_*). */
     CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
     CASE_32_64(ctz)      /* Optional (TCG_TARGET_HAS_ctz_*). */
         tcg_out_op_rrr(s, opc, args[0], args[1], args[2]);
-- 
2.43.0


