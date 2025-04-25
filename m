Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DF0C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4E-0001Bz-EG; Fri, 25 Apr 2025 17:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R45-0000ei-HM
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:34 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R41-0000mK-GN
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:33 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so43060135ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618307; x=1746223107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfaIT6HAj9OsZJMC70slTKvkfoE4KQymAJKFpVOpejc=;
 b=vy9gtZ0sfRnfbwiWPMGSRPuerkwxIFfUcBmoEByn777e8Qy95g47o6tMUbMPpLfFGP
 91Q3erjNKlkeVGmOxly3Dy28nbRaK+kXwO/FxiSJawmQ6f5WgDBxDm6W3/W1o0/Zysf7
 dW0aAQKn/wJALEBI+bGWDh50V7x7GLuAHWgqadZXPz++KLU69PuZz5iWMS0cVoCTZ78h
 t7OGRElzxHWf9g9RwDc53uH95rKvfUTWSdP/TVRnWv7WfuQiscpv7eLv8h3eWA+rZDDs
 cKkxs5jCmnZmG6ORvvTzZuBIKzT+zbMON9Luuw6W2OONuMeC6CFDEdeMrbtyT5YwZKP+
 XoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618307; x=1746223107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfaIT6HAj9OsZJMC70slTKvkfoE4KQymAJKFpVOpejc=;
 b=hfDAAAPgR/E7Bi3YAyNd9HKL75pFRmBY/e2FkPlTwoDXcWZD5ooCoW1FPn8tFM8qNb
 MJqy+oHQ70Z2xa6uJFA0hs3r7/cko/sfmcVe2ZdBM4PF5EkywNvupd8vlm/zdLFGh+Vc
 XUqM2e+OlpG0MwANJKsPcTPJ7pcVSSe5ogzDGiaNKl6/ZWix42XIu5w96UGPD+4MHAU/
 mYXmcB5cmVdTzGLUGPwU1R8paaJyi8UQYJNQDWpZttyIGqEGwWjUJcDzFUEFHe6ieOyN
 V7/O1qd5nasuc4mnjnQlmqAJPFQmoxFyGOBqfgto5r2cCMDwaKcDZAuZ+fDsnK1IGqnd
 OPzQ==
X-Gm-Message-State: AOJu0YxaOGbKjPxfQTdFRf8jdjhhMu8nq169AG3u2d58U171x2G6KDKN
 J5NptG+OEQbujX0urC9bUQWxtXTq/3NLpWvZeyvPkR3JOeEYzAeoTpNQFlAGBPkQ88ekHY9U79z
 r
X-Gm-Gg: ASbGnctHQy/w+XP5PK+MJ4ZNyLJaqZ9gmcju/BCuu9yq1fylvUA4G5Zz1e/o0JtwbpM
 lmH2sr67yDEppKUS6++0FAwPN2ei/Tc0YS7T+489KLojnQv5P1Z/ZXVthE/4V/2LKkuyucpxeIS
 vV01X1rdfzdvGHqgrOrNPla4OUTdJn3WkYrHKAExaEzHE6uj+DLrA0ms8zziSsCxqNkm2cJVFFM
 ZDx+5o1w/JdDBVn8LjAsJKYjZyIig1WxIR+oE+QNRC8k8RlE+r+YfUKIEfjHB4Omd8k1uXm3phB
 ZpsK1zAJ+oxaZQ9g70nJxz2p3c/KQiS3qqFVhDsK1evx5Kpi4jeAwPzlFg5kJCpmr+qzuiaUmJs
 =
X-Google-Smtp-Source: AGHT+IGphDVLPaT+kNhAmRc20ljN1LfGsO0wZ4/tZ8BiHe3zlJ6hhn8QY7wju7Ytjyy4WtuDP0vjCQ==
X-Received: by 2002:a17:902:e404:b0:225:ac99:ae0f with SMTP id
 d9443c01a7336-22dbf5d8b00mr59717765ad.1.1745618307364; 
 Fri, 25 Apr 2025 14:58:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 043/159] tcg: Convert mulsh to TCGOutOpBinary
Date: Fri, 25 Apr 2025 14:52:57 -0700
Message-ID: <20250425215454.886111-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
 tcg/tcg.c                        |  8 ++++----
 tcg/aarch64/tcg-target.c.inc     | 17 +++++++++++-----
 tcg/arm/tcg-target.c.inc         |  4 ++++
 tcg/i386/tcg-target.c.inc        |  4 ++++
 tcg/loongarch64/tcg-target.c.inc | 24 +++++++++++++---------
 tcg/mips/tcg-target.c.inc        | 34 +++++++++++++++++---------------
 tcg/ppc/tcg-target.c.inc         | 21 +++++++++++---------
 tcg/riscv/tcg-target.c.inc       | 19 +++++++++++-------
 tcg/s390x/tcg-target.c.inc       |  4 ++++
 tcg/sparc64/tcg-target.c.inc     |  4 ++++
 tcg/tci/tcg-target.c.inc         |  4 ++++
 23 files changed, 95 insertions(+), 72 deletions(-)

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
index 808ac8c431..4bfda0a38f 100644
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
@@ -5426,6 +5424,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index b08e23d0dc..1c19004e6e 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1890,6 +1890,10 @@ static const TCGOutOpBinary outop_mul = {
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
index 5fdca05c9d..d0391157a4 100644
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
index 738fdd1a9e..7503270ca3 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1347,6 +1347,21 @@ static const TCGOutOpBinary outop_mul = {
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
@@ -1656,13 +1671,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2349,8 +2357,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rz, rJ);
 
-    case INDEX_op_mulsh_i32:
-    case INDEX_op_mulsh_i64:
     case INDEX_op_div_i32:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 24f8184c33..a1c215c25d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1743,6 +1743,24 @@ static const TCGOutOpBinary outop_mul = {
     .out_rrr = tgen_mul,
 };
 
+static void tgen_mulsh(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (use_mips32r6_instructions) {
+        MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_MUH : OPC_DMUH;
+        tcg_out_opc_reg(s, insn, a0, a1, a2);
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
@@ -1921,13 +1939,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -1956,13 +1967,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2249,13 +2253,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
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


