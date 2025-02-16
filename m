Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE34C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnn5-0006SD-QS; Sun, 16 Feb 2025 18:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmh-0005e7-DV
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:47 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnme-0005Ib-7S
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:47 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so78621715ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747443; x=1740352243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n4QipxK9jxeL3/8dBDpI8l4w6tiEnOBn61Ul3WnAPE4=;
 b=URDfMKfNu2hpZ7g8HzxzxxSrBuHMCSEy0jNpOtVn1YDFoZJIS/G2UnjL0PLAdSFUt2
 81UpMIAPU1FHix6b/0OJ6Qvc3ZLoKBdj1zAhyEwWXAPvxm6FPqXiExYBzLb3qqoB+MQ/
 sMMMGr29FglyrosUXdam4tIfvpEAJv+umDq0b3mcUZs6wamv2NvL9waKFGtONcVI2lnN
 QK2F4Jz9qZFEtzH52D1SWSeiin0KTiOlRQwWw6VARdCKjekWcD8ku7iS2YvtibAtuYJ/
 vZvNHxzJkv21vLxdiPf4JVNKuCzBAoQZWlU1QBQRe7ymgz+C73TsYcPE8DRwUNBwqhhw
 Y7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747443; x=1740352243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4QipxK9jxeL3/8dBDpI8l4w6tiEnOBn61Ul3WnAPE4=;
 b=nejHwWrmsOMA8MhmcUqsJ/WmXFnXjF7frGwG8s35xskFQgbGIIYgr0DlejhDPaV3dp
 9VINj0/Z+4RSU+xju6q14HCy/9YhD2Jg4+3MK837Hk0OCmpkB9OpTOQPp5GTJvmhbGNp
 /VryyaHScIMntu8vhTYumhcgfCpqhmYTYBWcqZHBZkMtIzpaEDF0F2K79ZSR2mF1PFCQ
 PaV3s9KbzrCWSIlkpyjYcpoB4HFjDXSqNqhyMLgQUqpfzuRs07b5zM95zJR0krxWghio
 SJxSgitsdFT9wOHlyZLIsVdJyt1dDC895yEgb9UWS2UCt4sYnwkQTyEDzM+cVrNPpVu1
 AgMQ==
X-Gm-Message-State: AOJu0YxPsivJZB1B83etXIevjGBieCxzRHvMCz2TcE8mCTiK9JjIaysd
 4V8Zq+E8u+DlEffevh1UTmzf6yHcH8zcnrJIf+ikvfLfX+jKWNDfgYu3P2m5+gK08vc7LYQia2F
 N
X-Gm-Gg: ASbGncvGaI5VaS1mnwHY6dL7JVfAEu8snnxUJ4MVVCNdXDzSeCFJK9ZTM2ebvTRB7GC
 +ttoJGoHqqK0mcFkF27cRu0sGmfrHCpEJris5LUHLuYF96PeRDBGM1dXqtQ8LjkGpf1NvBetn9U
 gxyB3zijmhWmlARVHiVpyCrJMwesrT0zi7exXp94XehsBhTnlaFbCrMWathjSqZGorI8yIsQqiU
 eUDsSAeQDoP6/LG2hfaxSuXR6Q6IMus2w6Bd51miH9mAeXBJQs1nOljIDKxpcZb9eeb/QhyxLK2
 L7ARzDwg0qfgOWsX5FMfAJDyEHjqh3Iuf8xCM1rW4cxV3ys=
X-Google-Smtp-Source: AGHT+IGhebTEtJKk7uNKrZpFKF+FAygqfKIWV1+IjsPozUi7Ayq2STNT6ZC01+NS4tab1oIOxMphqA==
X-Received: by 2002:a17:902:d50d:b0:216:3633:36e7 with SMTP id
 d9443c01a7336-22104062006mr124247475ad.26.1739747442800; 
 Sun, 16 Feb 2025 15:10:42 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 038/162] tcg: Convert mulsh to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:08:07 -0800
Message-ID: <20250216231012.2808572-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 tcg/sparc64/tcg-target-has.h     |  2 --
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 --
 tcg/tcg-op.c                     |  4 ++--
 tcg/tcg.c                        |  8 +++----
 tcg/aarch64/tcg-target.c.inc     | 17 ++++++++++-----
 tcg/arm/tcg-target.c.inc         |  4 ++++
 tcg/i386/tcg-target.c.inc        |  4 ++++
 tcg/loongarch64/tcg-target.c.inc | 24 +++++++++++++--------
 tcg/mips/tcg-target.c.inc        | 37 ++++++++++++++++++--------------
 tcg/ppc/tcg-target.c.inc         | 21 ++++++++++--------
 tcg/riscv/tcg-target.c.inc       | 19 ++++++++++------
 tcg/s390x/tcg-target.c.inc       |  4 ++++
 tcg/sparc64/tcg-target.c.inc     |  4 ++++
 tcg/tci/tcg-target.c.inc         |  4 ++++
 23 files changed, 98 insertions(+), 72 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 207a85ed61..bde6db8f2a 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -27,7 +27,6 @@
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        0
 #define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -46,7 +45,6 @@
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        1
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index d6b06e96bf..ab9b7b6162 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -34,7 +34,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_div_i32          use_idiv_instructions
 #define TCG_TARGET_HAS_rem_i32          0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index f4487ac1fc..121fb95ee0 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -39,7 +39,6 @@
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_mulsh_i32        0
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
@@ -58,7 +57,6 @@
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        1
 #define TCG_TARGET_HAS_muls2_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 53335b2cdb..e29c892756 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_mulu2_i32        0
 #define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_clz_i32          1
@@ -46,7 +45,6 @@
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
 
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index b559ab3846..ebaaa49cdd 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -43,7 +43,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   0
@@ -58,7 +57,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i64        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_mulsh_i64        1
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_negsetcond_i64   0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 18ec573f7e..bbbd8de2c7 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -29,7 +29,6 @@
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        0
 #define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -51,7 +50,6 @@
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        1
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 453942a6a5..f7e1ef82fc 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        0
 #define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
@@ -45,7 +44,6 @@
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index ac808e21e5..64f1805641 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -42,7 +42,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_sub2_i32       1
 #define TCG_TARGET_HAS_mulu2_i32      0
 #define TCG_TARGET_HAS_muls2_i32      0
-#define TCG_TARGET_HAS_mulsh_i32      0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
@@ -60,7 +59,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_sub2_i64       1
 #define TCG_TARGET_HAS_mulu2_i64      1
 #define TCG_TARGET_HAS_muls2_i64      HAVE_FACILITY(MISC_INSN_EXT2)
-#define TCG_TARGET_HAS_mulsh_i64      0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 093de87a1d..5a517b6835 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -28,7 +28,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
@@ -47,7 +46,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 7f3ef73f2e..3d4c67698f 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -28,7 +28,6 @@
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        0
 #define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
 /* Turn some undef macros into true macros.  */
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index b99b12c24c..0627585097 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -18,7 +18,6 @@
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -41,7 +40,6 @@
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        0
 #else
 #define TCG_TARGET_HAS_mulu2_i32        1
 #endif /* TCG_TARGET_REG_BITS == 64 */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7a37b21c56..a043c4554b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1156,7 +1156,7 @@ void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_muls2_i32) {
         tcg_gen_op4_i32(INDEX_op_muls2_i32, rl, rh, arg1, arg2);
-    } else if (TCG_TARGET_HAS_mulsh_i32) {
+    } else if (tcg_op_supported(INDEX_op_mulsh_i32, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
         tcg_gen_op3_i32(INDEX_op_mulsh_i32, rh, arg1, arg2);
@@ -2861,7 +2861,7 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_muls2_i64) {
         tcg_gen_op4_i64(INDEX_op_muls2_i64, rl, rh, arg1, arg2);
-    } else if (TCG_TARGET_HAS_mulsh_i64) {
+    } else if (tcg_op_supported(INDEX_op_mulsh_i64, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
         tcg_gen_op3_i64(INDEX_op_mulsh_i64, rh, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dc7a15ccd5..22fc90debe 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1022,6 +1022,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
+    OUTOP(INDEX_op_mulsh_i32, TCGOutOpBinary, outop_mulsh),
+    OUTOP(INDEX_op_mulsh_i64, TCGOutOpBinary, outop_mulsh),
     OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
@@ -2281,8 +2283,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_mulu2_i32;
     case INDEX_op_muls2_i32:
         return TCG_TARGET_HAS_muls2_i32;
-    case INDEX_op_mulsh_i32:
-        return TCG_TARGET_HAS_mulsh_i32;
     case INDEX_op_bswap16_i32:
         return TCG_TARGET_HAS_bswap16_i32;
     case INDEX_op_bswap32_i32:
@@ -2361,8 +2361,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_mulu2_i64;
     case INDEX_op_muls2_i64:
         return TCG_TARGET_HAS_muls2_i64;
-    case INDEX_op_mulsh_i64:
-        return TCG_TARGET_HAS_mulsh_i64;
 
     case INDEX_op_mov_vec:
     case INDEX_op_dup_vec:
@@ -5420,6 +5418,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_eqv:
     case INDEX_op_mul:
+    case INDEX_op_mulsh_i32:
+    case INDEX_op_mulsh_i64:
     case INDEX_op_muluh:
     case INDEX_op_nand:
     case INDEX_op_nor:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index bd0b7938c8..493c504682 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2184,6 +2184,18 @@ static TCGConstraintSetIndex cset_mulh(TCGType type, unsigned flags)
     return type == TCG_TYPE_I64 ? C_O1_I2(r, r, r) : C_NotImplemented;
 }
 
+static void tgen_mulsh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3508, SMULH, TCG_TYPE_I64, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mulh,
+    .out_rrr = tgen_mulsh,
+};
+
 static void tgen_muluh(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2543,10 +2555,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                         args[5], const_args[4], const_args[5], true);
         break;
 
-    case INDEX_op_mulsh_i64:
-        tcg_out_insn(s, 3508, SMULH, TCG_TYPE_I64, a0, a1, a2);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -3057,7 +3065,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
-    case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
     case INDEX_op_shl_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index e08252497b..b83d221dbc 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1896,6 +1896,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_muluh = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0a481f8ee9..c20612ff7c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2664,6 +2664,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_muluh = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index d65e5db98b..65a93050cc 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1335,6 +1335,21 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static void tgen_mulsh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_mulh_w(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_mulh_d(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mulsh,
+};
+
 static void tgen_muluh(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1644,13 +1659,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mulsh_i32:
-        tcg_out_opc_mulh_w(s, a0, a1, a2);
-        break;
-    case INDEX_op_mulsh_i64:
-        tcg_out_opc_mulh_d(s, a0, a1, a2);
-        break;
-
     case INDEX_op_div_i32:
         tcg_out_opc_div_w(s, a0, a1, a2);
         break;
@@ -2343,8 +2351,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rz, rJ);
 
-    case INDEX_op_mulsh_i32:
-    case INDEX_op_mulsh_i64:
     case INDEX_op_div_i32:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ad62d877c7..08d98f49f7 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1743,6 +1743,27 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static void tgen_mulsh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (use_mips32r6_instructions) {
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_reg(s, OPC_MUH, a0, a1, a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_DMUH, a0, a1, a2);
+        }
+    } else {
+        MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_MULT : OPC_DMULT;
+        tcg_out_opc_reg(s, insn, 0, a1, a2);
+        tcg_out_opc_reg(s, OPC_MFHI, a0, 0, 0);
+    }
+}
+
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mulsh,
+};
+
 static void tgen_muluh(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1924,13 +1945,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_mulsh_i32:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_MUH, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_MULT, i2 = OPC_MFHI;
-        goto do_hilo1;
     case INDEX_op_div_i32:
         if (use_mips32r6_instructions) {
             tcg_out_opc_reg(s, OPC_DIV_R6, a0, a1, a2);
@@ -1959,13 +1973,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         i1 = OPC_DIVU, i2 = OPC_MFHI;
         goto do_hilo1;
-    case INDEX_op_mulsh_i64:
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_reg(s, OPC_DMUH, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DMULT, i2 = OPC_MFHI;
-        goto do_hilo1;
     case INDEX_op_div_i64:
         if (use_mips32r6_instructions) {
             tcg_out_opc_reg(s, OPC_DDIV_R6, a0, a1, a2);
@@ -2252,13 +2259,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_mulsh_i32:
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
     case INDEX_op_setcond_i32:
-    case INDEX_op_mulsh_i64:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 06a7abf2ba..7ebadf396a 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2984,6 +2984,18 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+static void tgen_mulsh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? MULHW : MULHD;
+    tcg_out32(s, insn | TAB(a0, a1, a2));
+}
+
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mulsh,
+};
+
 static void tgen_muluh(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3499,13 +3511,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_mulsh_i32:
-        tcg_out32(s, MULHW | TAB(args[0], args[1], args[2]));
-        break;
-    case INDEX_op_mulsh_i64:
-        tcg_out32(s, MULHD | TAB(args[0], args[1], args[2]));
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, args[0]);
         break;
@@ -4183,12 +4188,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_mulsh_i32:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
-    case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
     case INDEX_op_clz_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 65246cc450..82f76b8e0c 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2026,6 +2026,18 @@ static TCGConstraintSetIndex cset_mulh(TCGType type, unsigned flags)
     return type == TCG_TYPE_I32 ? C_NotImplemented : C_O1_I2(r, r, r);
 }
 
+static void tgen_mulsh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_MULH, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mulh,
+    .out_rrr = tgen_mulsh,
+};
+
 static void tgen_muluh(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2391,11 +2403,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_imm(s, OPC_SRAI, a0, a1, 32);
         break;
 
-    case INDEX_op_mulsh_i32:
-    case INDEX_op_mulsh_i64:
-        tcg_out_opc_reg(s, OPC_MULH, a0, a1, a2);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -2723,12 +2730,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_mulsh_i32:
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_mulsh_i64:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index e3d70ca236..2685e6ffa1 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2309,6 +2309,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_muluh = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 31bdaecafa..95a138ef56 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1357,6 +1357,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rri = tgen_muli,
 };
 
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_muluh(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index e4a2b171df..1dcce543ec 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -670,6 +670,10 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_muluh = {
     .base.static_constraint = C_NotImplemented,
 };
-- 
2.43.0


