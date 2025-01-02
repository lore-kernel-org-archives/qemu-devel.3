Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EA7E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfR-0003jD-St; Thu, 02 Jan 2025 13:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeY-0007MX-97
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:43 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeU-0006Df-1i
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:38 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso154754225ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841433; x=1736446233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J+630BuOS9L/wojuaNf1py82Jogb0hEYTe8w0benMCA=;
 b=ti2NpMuK79Tzl6PTrWUg8HAigAPMncBVdTmDPg6lGCkGEzqyw8zyx+m4AGWd0fnBLh
 ywBIdEQscWFcn9pbMtzYYsxmopka561IEBi6cvJspy0SioMII6vxnC50sZCO2CVQ7H6M
 NZiy963tNSkr8VNlAvWxJFeuMP0Ub8i7N4QF2rD8w7KXZFczPeYtTbZrxRt8Ek/4gIQq
 gX+k7Sqtp6hrJaNzPu4vFQhjzezNE36IkES3g+3Uy7t4WoQ2nI34FEmNfXDwtXgjSfpm
 +rNXjRNGmB2ShmL1tIpGLO2LovrbnA6P0Yc0HRncEdAIaw560YTuqQ4By7vKOFh61jkf
 nrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841433; x=1736446233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+630BuOS9L/wojuaNf1py82Jogb0hEYTe8w0benMCA=;
 b=XAKhxbdtoIMgbTs5WedOSbb1KF+bPxLhrzSq+FanpRSVwJXeapfDEYMOadivwwFB8/
 UU+f4iGmMRmsvzS/oUTHUXH4KhDo1c6ugh8hiNMFWGnt0bOL0WRkAKBQriKdURg+RCph
 hiOBgWdFo6BEGdzoZ41gOiJNGtYOw+koAwGHWZYKufOT33/dAc71xe36sB6TeyAjHjcn
 l7zQXEHCqfGH09JOiIL7Kfr7EB2GyIvPhzB4GKyZAT8N4SM/TQ5VyfYOYXMsmjM4a02D
 zysUi0VxAPEVl0g4NjDw6Bt6mL7bvtg6sIBF7FVNFOg5WAxZLLtEKnpQ2NMnxammULzD
 qNHw==
X-Gm-Message-State: AOJu0YwmF7LRNUiuFDEu76CP9JMYQmdH4su6IVWelsOZu0ZJ6HWE8q6E
 st3d/RFiJfLejkplSUPKvqqO/X742iMCaY4fXVUwoLTOLAXIg7iGRqQHMHgX2EiFkXa/XJ9IK/n
 H
X-Gm-Gg: ASbGncsjlZ/Hu8ypMZiOg7rN/SEdo0/EaypjZCZDHyrLXNuLBK+k/waR6z3G5MN2P9D
 Hj9q0XPI5cTCI8taU0GaQc+OnFNGboxU5YO+ikdrZHeNKDQjvT0l687oMAYgO8v9GwD676BZKyl
 872ui1FZNlC/pAQa7MKZvFs8vMs9iGXwU5sEBTkIt/APma/zaoaruZ46HrkDYyem2/GpOgZR4Oj
 qzildR++eiTwfaOIH2JaUU1VJnlrpJH9TPaGpdZqnc3T+ATdhCwby/waQB7VQ==
X-Google-Smtp-Source: AGHT+IGW5Ol1w4nH9IwmVcWnb5fYVpY4tgjgPJe5KBsA4TsngTszNksXosQXzPWKauEdu+xnE60gpQ==
X-Received: by 2002:a05:6a21:100f:b0:1e1:a693:d5fd with SMTP id
 adf61e73a8af0-1e5e04a3432mr74075397637.25.1735841432506; 
 Thu, 02 Jan 2025 10:10:32 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 48/73] tcg: Remove INDEX_op_ext{8,16,32}{us}
Date: Thu,  2 Jan 2025 10:06:28 -0800
Message-ID: <20250102180654.1420056-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Use the fully general extract opcodes instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  10 -
 tcg/aarch64/tcg-target-has.h     |  11 -
 tcg/arm/tcg-target-has.h         |   6 -
 tcg/i386/tcg-target-has.h        |  11 -
 tcg/loongarch64/tcg-target-has.h |  16 --
 tcg/mips/tcg-target-has.h        |  23 --
 tcg/ppc/tcg-target-has.h         |  15 --
 tcg/riscv/tcg-target-has.h       |  15 --
 tcg/s390x/tcg-target-has.h       |  13 -
 tcg/sparc64/tcg-target-has.h     |  13 -
 tcg/tcg-has.h                    |  10 -
 tcg/tci/tcg-target-has.h         |  15 --
 tcg/optimize.c                   |  61 +----
 tcg/tcg-op.c                     | 430 ++++++++-----------------------
 tcg/tcg.c                        |  46 ----
 tcg/tci.c                        |  33 ---
 docs/devel/tcg-ops.rst           |  14 -
 tcg/aarch64/tcg-target.c.inc     |  22 +-
 tcg/arm/tcg-target.c.inc         |   7 -
 tcg/i386/tcg-target.c.inc        |  24 +-
 tcg/loongarch64/tcg-target.c.inc |  22 +-
 tcg/mips/tcg-target.c.inc        |  20 +-
 tcg/ppc/tcg-target.c.inc         |  17 +-
 tcg/riscv/tcg-target.c.inc       |  22 +-
 tcg/s390x/tcg-target.c.inc       |  22 +-
 tcg/sparc64/tcg-target.c.inc     |  14 +-
 tcg/tci/tcg-target.c.inc         | 102 +++-----
 27 files changed, 148 insertions(+), 866 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 477fdc4235..c0b78aab98 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -93,10 +93,6 @@ DEF(brcond2_i32, 0, 4, 2,
     TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | IMPL(TCG_TARGET_REG_BITS == 32))
 DEF(setcond2_i32, 1, 4, 1, IMPL(TCG_TARGET_REG_BITS == 32))
 
-DEF(ext8s_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext8s_i32))
-DEF(ext16s_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext16s_i32))
-DEF(ext8u_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext8u_i32))
-DEF(ext16u_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext16u_i32))
 DEF(bswap16_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I32)))
 DEF(bswap32_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I32)))
 DEF(not_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_not(TCG_TYPE_I32)))
@@ -157,12 +153,6 @@ DEF(extrl_i64_i32, 1, 1, 0, TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0)
 DEF(extrh_i64_i32, 1, 1, 0, TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0)
 
 DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | IMPL64)
-DEF(ext8s_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext8s_i64))
-DEF(ext16s_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext16s_i64))
-DEF(ext32s_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext32s_i64))
-DEF(ext8u_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext8u_i64))
-DEF(ext16u_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext16u_i64))
-DEF(ext32u_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext32u_i64))
 DEF(bswap16_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I64)))
 DEF(bswap32_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I64)))
 DEF(bswap64_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap(TCG_TYPE_I64)))
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 1bd2598d91..75344c301d 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -37,19 +37,8 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
-
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
  * which requires writable pages.  We must defer to the helper for user-only,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 6489a20662..5ff32e96a4 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -48,14 +48,8 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           (T >= TCG_TYPE_V64)
 
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
-#define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
-
 #define TCG_TARGET_HAS_tst              1
 
 #define TCG_TARGET_HAS_v64              use_neon_instructions
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 6c57dbb4ed..71277b3f28 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -49,18 +49,7 @@
 #define TCG_TARGET_HAS_not(T)           (T <= TCG_TYPE_REG || have_avx512vl)
 #define TCG_TARGET_HAS_orc(T)           (T >= TCG_TYPE_V64 && have_avx512vl)
 
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 61216884db..a141205322 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -34,24 +34,8 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_brcond2          0
-#define TCG_TARGET_HAS_setcond2         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
-/* 64-bit operations */
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
-
 #define TCG_TARGET_HAS_tst              0
 
 #define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_LSX)
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 0a5b7f9356..f6ccba95e5 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -63,30 +63,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           0
 
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
-#endif
-
-/* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
-#define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
-#define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
-#endif
-
-/* optional instructions automatically implemented */
-#define TCG_TARGET_HAS_ext8u_i32        0 /* andi rt, rs, 0xff   */
-#define TCG_TARGET_HAS_ext16u_i32       0 /* andi rt, rs, 0xffff */
-
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_ext8u_i64        0 /* andi rt, rs, 0xff   */
-#define TCG_TARGET_HAS_ext16u_i64       0 /* andi rt, rs, 0xffff */
-#endif
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              0
 
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 7eb3a06bba..1247bc873c 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -41,23 +41,8 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG || have_isa_2_07)
 
-/* optional instructions automatically implemented */
-#define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
-#define TCG_TARGET_HAS_ext16u_i32       0
-
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       0
-#endif
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
     (TCG_TARGET_REG_BITS == 64 && have_isa_2_07)
 
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 18c7a6f3b9..88c022256f 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -34,23 +34,8 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
 
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_brcond2          1
-#define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
-
 #define TCG_TARGET_HAS_tst              0
 
 /* vector instructions */
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index bce6432087..56d452bc7d 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -52,21 +52,8 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_not(T)         (T >= TCG_TYPE_V64 || HAVE_FACILITY(MISC_INSN_EXT3))
 #define TCG_TARGET_HAS_orc(T)         (T >= TCG_TYPE_V64 ? HAVE_FACILITY(VECTOR_ENH1) : HAVE_FACILITY(MISC_INSN_EXT3))
 
-#define TCG_TARGET_HAS_ext8s_i32      1
-#define TCG_TARGET_HAS_ext16s_i32     1
-#define TCG_TARGET_HAS_ext8u_i32      1
-#define TCG_TARGET_HAS_ext16u_i32     1
 #define TCG_TARGET_HAS_qemu_st8_i32   0
-
-#define TCG_TARGET_HAS_ext8s_i64      1
-#define TCG_TARGET_HAS_ext16s_i64     1
-#define TCG_TARGET_HAS_ext32s_i64     1
-#define TCG_TARGET_HAS_ext8u_i64      1
-#define TCG_TARGET_HAS_ext16u_i64     1
-#define TCG_TARGET_HAS_ext32u_i64     1
-
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
-
 #define TCG_TARGET_HAS_tst            1
 
 #define TCG_TARGET_HAS_v64            HAVE_FACILITY(VECTOR)
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 7d87761de7..e81f2bbe30 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -38,21 +38,8 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_ext8s_i32        0
-#define TCG_TARGET_HAS_ext16s_i32       0
-#define TCG_TARGET_HAS_ext8u_i32        0
-#define TCG_TARGET_HAS_ext16u_i32       0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#define TCG_TARGET_HAS_ext8s_i64        0
-#define TCG_TARGET_HAS_ext16s_i64       0
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       1
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
-
 #define TCG_TARGET_HAS_tst              1
 
 #define TCG_TARGET_extract_valid(type, ofs, len) \
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index dc35017852..23d0492fd0 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -9,16 +9,6 @@
 
 #include "tcg-target-has.h"
 
-#if TCG_TARGET_REG_BITS == 32
-/* Turn some undef macros into false macros.  */
-#define TCG_TARGET_HAS_ext8s_i64        0
-#define TCG_TARGET_HAS_ext16s_i64       0
-#define TCG_TARGET_HAS_ext32s_i64       0
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       0
-#endif
-
 /* Only one of DIV or DIV2 should be defined.  */
 #if defined(TCG_TARGET_HAS_div)
 #define TCG_TARGET_HAS_div2(T)          0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 260b252aa4..796769c574 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -32,23 +32,8 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
-#endif /* TCG_TARGET_REG_BITS == 64 */
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
-
 #define TCG_TARGET_HAS_tst              1
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6ca64b876a..32173ecb23 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -501,18 +501,6 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_ctpop_i64:
         return ctpop64(x);
 
-    CASE_OP_32_64(ext8s):
-        return (int8_t)x;
-
-    CASE_OP_32_64(ext16s):
-        return (int16_t)x;
-
-    CASE_OP_32_64(ext8u):
-        return (uint8_t)x;
-
-    CASE_OP_32_64(ext16u):
-        return (uint16_t)x;
-
     CASE_OP_32_64(bswap16):
         x = bswap16(x);
         return y & TCG_BSWAP_OS ? (int16_t)x : x;
@@ -525,12 +513,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
         return bswap64(x);
 
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_ext32s_i64:
         return (int32_t)x;
 
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
-    case INDEX_op_ext32u_i64:
         return (uint32_t)x;
 
     case INDEX_op_extrh_i64_i32:
@@ -1856,8 +1842,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask_old, s_mask, z_mask;
-    bool type_change = false;
+    uint64_t s_mask, z_mask;
     TempOptInfo *t1;
 
     if (fold_const1(ctx, op)) {
@@ -1867,72 +1852,38 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
     t1 = arg_info(op->args[1]);
     z_mask = t1->z_mask;
     s_mask = t1->s_mask;
-    s_mask_old = s_mask;
 
     switch (op->opc) {
-    CASE_OP_32_64(ext8s):
-        s_mask |= INT8_MIN;
-        z_mask = (int8_t)z_mask;
-        break;
-    CASE_OP_32_64(ext16s):
-        s_mask |= INT16_MIN;
-        z_mask = (int16_t)z_mask;
-        break;
     case INDEX_op_ext_i32_i64:
-        type_change = true;
-        QEMU_FALLTHROUGH;
-    case INDEX_op_ext32s_i64:
         s_mask |= INT32_MIN;
         z_mask = (int32_t)z_mask;
         break;
     default:
         g_assert_not_reached();
     }
-
-    if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
-        return true;
-    }
-
     return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask_old, z_mask;
-    bool type_change = false;
+    uint64_t z_mask;
 
     if (fold_const1(ctx, op)) {
         return true;
     }
 
-    z_mask_old = z_mask = arg_info(op->args[1])->z_mask;
-
+    z_mask = arg_info(op->args[1])->z_mask;
     switch (op->opc) {
-    CASE_OP_32_64(ext8u):
-        z_mask = (uint8_t)z_mask;
-        break;
-    CASE_OP_32_64(ext16u):
-        z_mask = (uint16_t)z_mask;
-        break;
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extu_i32_i64:
-        type_change = true;
-        QEMU_FALLTHROUGH;
-    case INDEX_op_ext32u_i64:
         z_mask = (uint32_t)z_mask;
         break;
     case INDEX_op_extrh_i64_i32:
-        type_change = true;
         z_mask >>= 32;
         break;
     default:
         g_assert_not_reached();
     }
-
-    if (!type_change && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
-        return true;
-    }
-
     return fold_masks_z(ctx, op, z_mask);
 }
 
@@ -2941,15 +2892,9 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(extract2):
             done = fold_extract2(&ctx, op);
             break;
-        CASE_OP_32_64(ext8s):
-        CASE_OP_32_64(ext16s):
-        case INDEX_op_ext32s_i64:
         case INDEX_op_ext_i32_i64:
             done = fold_exts(&ctx, op);
             break;
-        CASE_OP_32_64(ext8u):
-        CASE_OP_32_64(ext16u):
-        case INDEX_op_ext32u_i64:
         case INDEX_op_extu_i32_i64:
         case INDEX_op_extrl_i64_i32:
         case INDEX_op_extrh_i64_i32:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c62e4a3b2d..2da74ea134 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -408,17 +408,19 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     case -1:
         tcg_gen_mov_i32(ret, arg1);
         return;
-    case 0xff:
-        /* Don't recurse with tcg_gen_ext8u_i32.  */
-        if (TCG_TARGET_HAS_ext8u_i32) {
-            tcg_gen_op2_i32(INDEX_op_ext8u_i32, ret, arg1);
-            return;
-        }
-        break;
-    case 0xffff:
-        if (TCG_TARGET_HAS_ext16u_i32) {
-            tcg_gen_op2_i32(INDEX_op_ext16u_i32, ret, arg1);
-            return;
+    default:
+        /*
+         * Canonicalize on extract, if valid.  This aids x86 with its
+         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
+         * which does not require matching operands.  Other backends can
+         * trivially expand the extract to AND during code generation.
+         */
+        if (!(arg2 & (arg2 + 1))) {
+            unsigned len = ctz32(~arg2);
+            if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
+                tcg_gen_extract_i32(ret, arg1, 0, len);
+                return;
+            }
         }
         break;
     }
@@ -953,40 +955,20 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
     } else {
-        /* To help two-operand hosts we prefer to zero-extend first,
-           which allows ARG to stay live.  */
-        switch (len) {
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i32) {
-                tcg_gen_ext16u_i32(ret, arg);
-                tcg_gen_shli_i32(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i32) {
-                tcg_gen_ext8u_i32(ret, arg);
-                tcg_gen_shli_i32(ret, ret, ofs);
-                return;
-            }
-            break;
+        /*
+         * To help two-operand hosts we prefer to zero-extend first,
+         * which allows ARG to stay live.
+         */
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
+            tcg_gen_extract_i32(ret, arg, 0, len);
+            tcg_gen_shli_i32(ret, ret, ofs);
+            return;
         }
         /* Otherwise prefer zero-extension over AND for code size.  */
-        switch (ofs + len) {
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i32) {
-                tcg_gen_shli_i32(ret, arg, ofs);
-                tcg_gen_ext16u_i32(ret, ret);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i32) {
-                tcg_gen_shli_i32(ret, arg, ofs);
-                tcg_gen_ext8u_i32(ret, ret);
-                return;
-            }
-            break;
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
+            tcg_gen_shli_i32(ret, arg, ofs);
+            tcg_gen_extract_i32(ret, ret, 0, ofs + len);
+            return;
         }
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
         tcg_gen_shli_i32(ret, ret, ofs);
@@ -1006,32 +988,21 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_shri_i32(ret, arg, 32 - len);
         return;
     }
-    if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-        return;
-    }
 
     if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
         tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, ofs, len);
         return;
     }
+    if (ofs == 0) {
+        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
+        return;
+    }
 
     /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    switch (ofs + len) {
-    case 16:
-        if (TCG_TARGET_HAS_ext16u_i32) {
-            tcg_gen_ext16u_i32(ret, arg);
-            tcg_gen_shri_i32(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8u_i32) {
-            tcg_gen_ext8u_i32(ret, arg);
-            tcg_gen_shri_i32(ret, ret, ofs);
-            return;
-        }
-        break;
+    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
+        tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, 0, ofs + len);
+        tcg_gen_shri_i32(ret, ret, ofs);
+        return;
     }
 
     /* ??? Ideally we'd know what values are available for immediate AND.
@@ -1062,16 +1033,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_sari_i32(ret, arg, 32 - len);
         return;
     }
-    if (ofs == 0) {
-        switch (len) {
-        case 16:
-            tcg_gen_ext16s_i32(ret, arg);
-            return;
-        case 8:
-            tcg_gen_ext8s_i32(ret, arg);
-            return;
-        }
-    }
 
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
         tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, ofs, len);
@@ -1079,37 +1040,15 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 
     /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    switch (ofs + len) {
-    case 16:
-        if (TCG_TARGET_HAS_ext16s_i32) {
-            tcg_gen_ext16s_i32(ret, arg);
-            tcg_gen_sari_i32(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8s_i32) {
-            tcg_gen_ext8s_i32(ret, arg);
-            tcg_gen_sari_i32(ret, ret, ofs);
-            return;
-        }
-        break;
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, ofs + len)) {
+        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, 0, ofs + len);
+        tcg_gen_sari_i32(ret, ret, ofs);
+        return;
     }
-    switch (len) {
-    case 16:
-        if (TCG_TARGET_HAS_ext16s_i32) {
-            tcg_gen_shri_i32(ret, arg, ofs);
-            tcg_gen_ext16s_i32(ret, ret);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8s_i32) {
-            tcg_gen_shri_i32(ret, arg, ofs);
-            tcg_gen_ext8s_i32(ret, ret);
-            return;
-        }
-        break;
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, len)) {
+        tcg_gen_shri_i32(ret, arg, ofs);
+        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, ret, 0, len);
+        return;
     }
 
     tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
@@ -1279,40 +1218,22 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_ext8s_i32) {
-        tcg_gen_op2_i32(INDEX_op_ext8s_i32, ret, arg);
-    } else {
-        tcg_gen_shli_i32(ret, arg, 24);
-        tcg_gen_sari_i32(ret, ret, 24);
-    }
+    tcg_gen_sextract_i32(ret, arg, 0, 8);
 }
 
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_ext16s_i32) {
-        tcg_gen_op2_i32(INDEX_op_ext16s_i32, ret, arg);
-    } else {
-        tcg_gen_shli_i32(ret, arg, 16);
-        tcg_gen_sari_i32(ret, ret, 16);
-    }
+    tcg_gen_sextract_i32(ret, arg, 0, 16);
 }
 
 void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_ext8u_i32) {
-        tcg_gen_op2_i32(INDEX_op_ext8u_i32, ret, arg);
-    } else {
-        tcg_gen_andi_i32(ret, arg, 0xffu);
-    }
+    tcg_gen_extract_i32(ret, arg, 0, 8);
 }
 
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_ext16u_i32) {
-        tcg_gen_op2_i32(INDEX_op_ext16u_i32, ret, arg);
-    } else {
-        tcg_gen_andi_i32(ret, arg, 0xffffu);
-    }
+    tcg_gen_extract_i32(ret, arg, 0, 16);
 }
 
 /*
@@ -1792,23 +1713,19 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     case -1:
         tcg_gen_mov_i64(ret, arg1);
         return;
-    case 0xff:
-        /* Don't recurse with tcg_gen_ext8u_i64.  */
-        if (TCG_TARGET_HAS_ext8u_i64) {
-            tcg_gen_op2_i64(INDEX_op_ext8u_i64, ret, arg1);
-            return;
-        }
-        break;
-    case 0xffff:
-        if (TCG_TARGET_HAS_ext16u_i64) {
-            tcg_gen_op2_i64(INDEX_op_ext16u_i64, ret, arg1);
-            return;
-        }
-        break;
-    case 0xffffffffu:
-        if (TCG_TARGET_HAS_ext32u_i64) {
-            tcg_gen_op2_i64(INDEX_op_ext32u_i64, ret, arg1);
-            return;
+    default:
+        /*
+         * Canonicalize on extract, if valid.  This aids x86 with its
+         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
+         * which does not require matching operands.  Other backends can
+         * trivially expand the extract to AND during code generation.
+         */
+        if (!(arg2 & (arg2 + 1))) {
+            unsigned len = ctz64(~arg2);
+            if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
+                tcg_gen_extract_i64(ret, arg1, 0, len);
+                return;
+            }
         }
         break;
     }
@@ -2136,77 +2053,32 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_ext8s_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-    } else if (TCG_TARGET_HAS_ext8s_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext8s_i64, ret, arg);
-    } else {
-        tcg_gen_shli_i64(ret, arg, 56);
-        tcg_gen_sari_i64(ret, ret, 56);
-    }
+    tcg_gen_sextract_i64(ret, arg, 0, 8);
 }
 
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_ext16s_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-    } else if (TCG_TARGET_HAS_ext16s_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext16s_i64, ret, arg);
-    } else {
-        tcg_gen_shli_i64(ret, arg, 48);
-        tcg_gen_sari_i64(ret, ret, 48);
-    }
+    tcg_gen_sextract_i64(ret, arg, 0, 16);
 }
 
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-    } else if (TCG_TARGET_HAS_ext32s_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext32s_i64, ret, arg);
-    } else {
-        tcg_gen_shli_i64(ret, arg, 32);
-        tcg_gen_sari_i64(ret, ret, 32);
-    }
+    tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
 void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_ext8u_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-    } else if (TCG_TARGET_HAS_ext8u_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext8u_i64, ret, arg);
-    } else {
-        tcg_gen_andi_i64(ret, arg, 0xffu);
-    }
+    tcg_gen_extract_i64(ret, arg, 0, 8);
 }
 
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_ext16u_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-    } else if (TCG_TARGET_HAS_ext16u_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext16u_i64, ret, arg);
-    } else {
-        tcg_gen_andi_i64(ret, arg, 0xffffu);
-    }
+    tcg_gen_extract_i64(ret, arg, 0, 16);
 }
 
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-    } else if (TCG_TARGET_HAS_ext32u_i64) {
-        tcg_gen_op2_i64(INDEX_op_ext32u_i64, ret, arg);
-    } else {
-        tcg_gen_andi_i64(ret, arg, 0xffffffffu);
-    }
+    tcg_gen_extract_i64(ret, arg, 0, 32);
 }
 
 /*
@@ -2757,54 +2629,20 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                 return;
             }
         }
-        /* To help two-operand hosts we prefer to zero-extend first,
-           which allows ARG to stay live.  */
-        switch (len) {
-        case 32:
-            if (TCG_TARGET_HAS_ext32u_i64) {
-                tcg_gen_ext32u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i64) {
-                tcg_gen_ext16u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i64) {
-                tcg_gen_ext8u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
+        /*
+         * To help two-operand hosts we prefer to zero-extend first,
+         * which allows ARG to stay live.
+         */
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
+            tcg_gen_extract_i64(ret, arg, 0, len);
+            tcg_gen_shli_i64(ret, ret, ofs);
+            return;
         }
         /* Otherwise prefer zero-extension over AND for code size.  */
-        switch (ofs + len) {
-        case 32:
-            if (TCG_TARGET_HAS_ext32u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext32u_i64(ret, ret);
-                return;
-            }
-            break;
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext16u_i64(ret, ret);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext8u_i64(ret, ret);
-                return;
-            }
-            break;
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
+            tcg_gen_shli_i64(ret, arg, ofs);
+            tcg_gen_extract_i64(ret, ret, 0, ofs + len);
+            return;
         }
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
         tcg_gen_shli_i64(ret, ret, ofs);
@@ -2824,10 +2662,6 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_shri_i64(ret, arg, 64 - len);
         return;
     }
-    if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-        return;
-    }
 
     if (TCG_TARGET_REG_BITS == 32) {
         /* Look for a 32-bit extract within one of the two words.  */
@@ -2841,39 +2675,34 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
             return;
         }
-        /* The field is split across two words.  One double-word
-           shift is better than two double-word shifts.  */
-        goto do_shift_and;
+
+        /* The field is split across two words. */
+        tcg_gen_extract2_i32(TCGV_LOW(ret), TCGV_LOW(arg),
+                             TCGV_HIGH(arg), ofs);
+        if (len <= 32) {
+            tcg_gen_extract_i32(TCGV_LOW(ret), TCGV_LOW(ret), 0, len);
+            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+        } else {
+            tcg_gen_extract_i32(TCGV_HIGH(ret), TCGV_HIGH(arg),
+                                ofs, len - 32);
+        }
+        return;
     }
 
     if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
         tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, ofs, len);
         return;
     }
+    if (ofs == 0) {
+        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
+        return;
+    }
 
     /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    switch (ofs + len) {
-    case 32:
-        if (TCG_TARGET_HAS_ext32u_i64) {
-            tcg_gen_ext32u_i64(ret, arg);
-            tcg_gen_shri_i64(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 16:
-        if (TCG_TARGET_HAS_ext16u_i64) {
-            tcg_gen_ext16u_i64(ret, arg);
-            tcg_gen_shri_i64(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8u_i64) {
-            tcg_gen_ext8u_i64(ret, arg);
-            tcg_gen_shri_i64(ret, ret, ofs);
-            return;
-        }
-        break;
+    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
+        tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, 0, ofs + len);
+        tcg_gen_shri_i64(ret, ret, ofs);
+        return;
     }
 
     /* ??? Ideally we'd know what values are available for immediate AND.
@@ -2881,7 +2710,6 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
        so that we get ext8u, ext16u, and ext32u.  */
     switch (len) {
     case 1 ... 8: case 16: case 32:
-    do_shift_and:
         tcg_gen_shri_i64(ret, arg, ofs);
         tcg_gen_andi_i64(ret, ret, (1ull << len) - 1);
         break;
@@ -2905,19 +2733,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_sari_i64(ret, arg, 64 - len);
         return;
     }
-    if (ofs == 0) {
-        switch (len) {
-        case 32:
-            tcg_gen_ext32s_i64(ret, arg);
-            return;
-        case 16:
-            tcg_gen_ext16s_i64(ret, arg);
-            return;
-        case 8:
-            tcg_gen_ext8s_i64(ret, arg);
-            return;
-        }
-    }
 
     if (TCG_TARGET_REG_BITS == 32) {
         /* Look for a 32-bit extract within one of the two words.  */
@@ -2957,52 +2772,17 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 
     /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    switch (ofs + len) {
-    case 32:
-        if (TCG_TARGET_HAS_ext32s_i64) {
-            tcg_gen_ext32s_i64(ret, arg);
-            tcg_gen_sari_i64(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 16:
-        if (TCG_TARGET_HAS_ext16s_i64) {
-            tcg_gen_ext16s_i64(ret, arg);
-            tcg_gen_sari_i64(ret, ret, ofs);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8s_i64) {
-            tcg_gen_ext8s_i64(ret, arg);
-            tcg_gen_sari_i64(ret, ret, ofs);
-            return;
-        }
-        break;
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, ofs + len)) {
+        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, 0, ofs + len);
+        tcg_gen_sari_i64(ret, ret, ofs);
+        return;
     }
-    switch (len) {
-    case 32:
-        if (TCG_TARGET_HAS_ext32s_i64) {
-            tcg_gen_shri_i64(ret, arg, ofs);
-            tcg_gen_ext32s_i64(ret, ret);
-            return;
-        }
-        break;
-    case 16:
-        if (TCG_TARGET_HAS_ext16s_i64) {
-            tcg_gen_shri_i64(ret, arg, ofs);
-            tcg_gen_ext16s_i64(ret, ret);
-            return;
-        }
-        break;
-    case 8:
-        if (TCG_TARGET_HAS_ext8s_i64) {
-            tcg_gen_shri_i64(ret, arg, ofs);
-            tcg_gen_ext8s_i64(ret, ret);
-            return;
-        }
-        break;
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, len)) {
+        tcg_gen_shri_i64(ret, arg, ofs);
+        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, ret, 0, len);
+        return;
     }
+
     tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
     tcg_gen_sari_i64(ret, ret, 64 - len);
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 27575a2c43..775d51953c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2239,14 +2239,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_HAS_muluh(TCG_TYPE_I32);
     case INDEX_op_mulsh_i32:
         return TCG_TARGET_HAS_mulsh(TCG_TYPE_I32);
-    case INDEX_op_ext8s_i32:
-        return TCG_TARGET_HAS_ext8s_i32;
-    case INDEX_op_ext16s_i32:
-        return TCG_TARGET_HAS_ext16s_i32;
-    case INDEX_op_ext8u_i32:
-        return TCG_TARGET_HAS_ext8u_i32;
-    case INDEX_op_ext16u_i32:
-        return TCG_TARGET_HAS_ext16u_i32;
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
         return TCG_TARGET_HAS_bswap(TCG_TYPE_I32);
@@ -2323,18 +2315,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_rot(TCG_TYPE_I64);
     case INDEX_op_extract2_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_extract2(TCG_TYPE_I64);
-    case INDEX_op_ext8s_i64:
-        return TCG_TARGET_HAS_ext8s_i64;
-    case INDEX_op_ext16s_i64:
-        return TCG_TARGET_HAS_ext16s_i64;
-    case INDEX_op_ext32s_i64:
-        return TCG_TARGET_HAS_ext32s_i64;
-    case INDEX_op_ext8u_i64:
-        return TCG_TARGET_HAS_ext8u_i64;
-    case INDEX_op_ext16u_i64:
-        return TCG_TARGET_HAS_ext16u_i64;
-    case INDEX_op_ext32u_i64:
-        return TCG_TARGET_HAS_ext32u_i64;
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
@@ -5364,32 +5344,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     /* emit instruction */
     switch (op->opc) {
-    case INDEX_op_ext8s_i32:
-        tcg_out_ext8s(s, TCG_TYPE_I32, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext8s_i64:
-        tcg_out_ext8s(s, TCG_TYPE_I64, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-        tcg_out_ext8u(s, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext16s_i32:
-        tcg_out_ext16s(s, TCG_TYPE_I32, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext16s_i64:
-        tcg_out_ext16s(s, TCG_TYPE_I64, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-        tcg_out_ext16u(s, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext32s_i64:
-        tcg_out_ext32s(s, new_args[0], new_args[1]);
-        break;
-    case INDEX_op_ext32u_i64:
-        tcg_out_ext32u(s, new_args[0], new_args[1]);
-        break;
     case INDEX_op_ext_i32_i64:
         tcg_out_exts_i32_i64(s, new_args[0], new_args[1]);
         break;
diff --git a/tcg/tci.c b/tcg/tci.c
index 9898551026..d0194dc5af 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -673,28 +673,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tmp64 = (int64_t)(int32_t)regs[r2] * (int32_t)regs[r3];
             tci_write_reg64(regs, r1, r0, tmp64);
             break;
-#if TCG_TARGET_HAS_ext8s_i32 || TCG_TARGET_HAS_ext8s_i64
-        CASE_32_64(ext8s)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = (int8_t)regs[r1];
-            break;
-#endif
-        CASE_32_64(ext16s)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = (int16_t)regs[r1];
-            break;
-#if TCG_TARGET_HAS_ext8u_i32 || TCG_TARGET_HAS_ext8u_i64
-        CASE_32_64(ext8u)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = (uint8_t)regs[r1];
-            break;
-#endif
-#if TCG_TARGET_HAS_ext16u_i32 || TCG_TARGET_HAS_ext16u_i64
-        CASE_32_64(ext16u)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = (uint16_t)regs[r1];
-            break;
-#endif
         CASE_32_64(bswap16)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap16(regs[r1]);
@@ -823,12 +801,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 tb_ptr = ptr;
             }
             break;
-        case INDEX_op_ext32s_i64:
         case INDEX_op_ext_i32_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (int32_t)regs[r1];
             break;
-        case INDEX_op_ext32u_i64:
         case INDEX_op_extu_i32_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (uint32_t)regs[r1];
@@ -1095,15 +1071,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
 
     case INDEX_op_mov_i32:
     case INDEX_op_mov_i64:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 0929abdaca..cc365220c2 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -396,20 +396,6 @@ Misc
      - | *t0* = *t1*
        | Move *t1* to *t0* (both operands must have the same type).
 
-   * - ext8s_i32/i64 *t0*, *t1*
-
-       ext8u_i32/i64 *t0*, *t1*
-
-       ext16s_i32/i64 *t0*, *t1*
-
-       ext16u_i32/i64 *t0*, *t1*
-
-       ext32s_i64 *t0*, *t1*
-
-       ext32u_i64 *t0*, *t1*
-
-     - | 8, 16 or 32 bit sign/zero extension (both operands must have the same type)
-
    * - bswap16_i32/i64 *t0*, *t1*, *flags*
 
      - | 16 bit byte swap on the low bits of a 32/64 bit input.
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index a05b3c1a34..c0fe10e657 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2511,17 +2511,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2998,16 +2988,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 44b7c6d185..cd770d2e20 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2157,10 +2157,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16u_i32:
     default:
         g_assert_not_reached();
     }
@@ -2181,9 +2177,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16u_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0ef94071c6..c73f1039e1 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3110,17 +3110,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -3756,18 +3746,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-        return C_O1_I1(r, q);
-
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 13debee683..395579774d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1705,17 +1705,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2250,16 +2240,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_brcond_i64:
         return C_O0_I2(rZ, rZ);
 
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 6acc2c99a4..a8987528e4 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -650,7 +650,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    tcg_debug_assert(TCG_TARGET_HAS_ext8s_i32);
+    tcg_debug_assert(use_mips32r2_instructions);
     tcg_out_opc_reg(s, OPC_SEB, rd, TCG_REG_ZERO, rs);
 }
 
@@ -661,7 +661,7 @@ static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
 
 static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    tcg_debug_assert(TCG_TARGET_HAS_ext16s_i32);
+    tcg_debug_assert(use_mips32r2_instructions);
     tcg_out_opc_reg(s, OPC_SEH, rd, TCG_REG_ZERO, rs);
 }
 
@@ -2160,15 +2160,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2191,8 +2183,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext16s_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
@@ -2207,10 +2197,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 0f337200eb..2b3d46af46 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3550,17 +3550,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -4185,8 +4175,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ctpop_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext16s_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
@@ -4201,9 +4189,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ctpop_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext32s_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index fb7cf0ca03..9e981c5111 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2386,17 +2386,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -2643,17 +2633,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ld_i64:
     case INDEX_op_not_i64:
     case INDEX_op_neg_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext32s_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 38c15c6ef8..9696ff6515 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2791,17 +2791,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -3349,16 +3339,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 3e4d8c3698..caa462249f 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1527,17 +1527,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
@@ -1567,8 +1557,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 94cf09322a..4ab19e93cc 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -58,16 +58,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_not_i64:
     case INDEX_op_neg_i32:
     case INDEX_op_neg_i64:
-    case INDEX_op_ext8s_i32:
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
@@ -558,76 +548,54 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     }
 }
 
+static void tcg_out_extract(TCGContext *s, TCGType type, TCGReg rd,
+                            TCGReg rs, unsigned pos, unsigned len)
+{
+    TCGOpcode opc = type == TCG_TYPE_I32 ?
+                    INDEX_op_extract_i32 :
+                    INDEX_op_extract_i64;
+    tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
+}
+
+static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
+                             TCGReg rs, unsigned pos, unsigned len)
+{
+    TCGOpcode opc = type == TCG_TYPE_I32 ?
+                    INDEX_op_sextract_i32 :
+                    INDEX_op_sextract_i64;
+    tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
+}
+
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    switch (type) {
-    case TCG_TYPE_I32:
-        tcg_debug_assert(TCG_TARGET_HAS_ext8s_i32);
-        tcg_out_op_rr(s, INDEX_op_ext8s_i32, rd, rs);
-        break;
-#if TCG_TARGET_REG_BITS == 64
-    case TCG_TYPE_I64:
-        tcg_debug_assert(TCG_TARGET_HAS_ext8s_i64);
-        tcg_out_op_rr(s, INDEX_op_ext8s_i64, rd, rs);
-        break;
-#endif
-    default:
-        g_assert_not_reached();
-    }
+    tcg_out_sextract(s, type, rd, rs, 0, 8);
 }
 
 static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_debug_assert(TCG_TARGET_HAS_ext8u_i64);
-        tcg_out_op_rr(s, INDEX_op_ext8u_i64, rd, rs);
-    } else {
-        tcg_debug_assert(TCG_TARGET_HAS_ext8u_i32);
-        tcg_out_op_rr(s, INDEX_op_ext8u_i32, rd, rs);
-    }
+    tcg_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 8);
 }
 
 static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
 {
-    switch (type) {
-    case TCG_TYPE_I32:
-        tcg_debug_assert(TCG_TARGET_HAS_ext16s_i32);
-        tcg_out_op_rr(s, INDEX_op_ext16s_i32, rd, rs);
-        break;
-#if TCG_TARGET_REG_BITS == 64
-    case TCG_TYPE_I64:
-        tcg_debug_assert(TCG_TARGET_HAS_ext16s_i64);
-        tcg_out_op_rr(s, INDEX_op_ext16s_i64, rd, rs);
-        break;
-#endif
-    default:
-        g_assert_not_reached();
-    }
+    tcg_out_sextract(s, type, rd, rs, 0, 16);
 }
 
 static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_debug_assert(TCG_TARGET_HAS_ext16u_i64);
-        tcg_out_op_rr(s, INDEX_op_ext16u_i64, rd, rs);
-    } else {
-        tcg_debug_assert(TCG_TARGET_HAS_ext16u_i32);
-        tcg_out_op_rr(s, INDEX_op_ext16u_i32, rd, rs);
-    }
+    tcg_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 16);
 }
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-    tcg_debug_assert(TCG_TARGET_HAS_ext32s_i64);
-    tcg_out_op_rr(s, INDEX_op_ext32s_i64, rd, rs);
+    tcg_out_sextract(s, TCG_TYPE_I64, rd, rs, 0, 32);
 }
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-    tcg_debug_assert(TCG_TARGET_HAS_ext32u_i64);
-    tcg_out_op_rr(s, INDEX_op_ext32u_i64, rd, rs);
+    tcg_out_extract(s, TCG_TYPE_I64, rd, rs, 0, 32);
 }
 
 static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
@@ -713,7 +681,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGOpcode exts;
+    int width;
 
     switch (opc) {
     case INDEX_op_goto_ptr:
@@ -803,18 +771,18 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_bswap16_i32: /* Optional (TCG_TARGET_HAS_bswap). */
-        exts = INDEX_op_ext16s_i32;
+        width = 16;
         goto do_bswap;
     case INDEX_op_bswap16_i64: /* Optional (TCG_TARGET_HAS_bswap). */
-        exts = INDEX_op_ext16s_i64;
+        width = 16;
         goto do_bswap;
     case INDEX_op_bswap32_i64: /* Optional (TCG_TARGET_HAS_bswap). */
-        exts = INDEX_op_ext32s_i64;
+        width = 32;
     do_bswap:
         /* The base tci bswaps zero-extend, and ignore high bits. */
         tcg_out_op_rr(s, opc, args[0], args[1]);
         if (args[2] & TCG_BSWAP_OS) {
-            tcg_out_op_rr(s, exts, args[0], args[0]);
+            tcg_out_sextract(s, TCG_TYPE_REG, args[0], args[0], 0, width);
         }
         break;
 
@@ -872,17 +840,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_ext8s_i32:  /* Always emitted via tcg_reg_alloc_op.  */
-    case INDEX_op_ext8s_i64:
-    case INDEX_op_ext8u_i32:
-    case INDEX_op_ext8u_i64:
-    case INDEX_op_ext16s_i32:
-    case INDEX_op_ext16s_i64:
-    case INDEX_op_ext16u_i32:
-    case INDEX_op_ext16u_i64:
-    case INDEX_op_ext32s_i64:
-    case INDEX_op_ext32u_i64:
-    case INDEX_op_ext_i32_i64:
+    case INDEX_op_ext_i32_i64:  /* Always emitted via tcg_reg_alloc_op.  */
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
-- 
2.43.0


