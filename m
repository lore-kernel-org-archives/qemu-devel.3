Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4615CE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbp-0007Yp-G3; Thu, 02 Jan 2025 13:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbN-00070i-KQ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:24 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbJ-0005Aa-8I
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:21 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21683192bf9so158297275ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841236; x=1736446036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=05xzsuBphAtDRkwps4iZi7cEWm0Ps2aIo0PphtO0hbE=;
 b=dtruV7Q8U9DjAXFMN3+56oa7I/pzH8cMGQ265VHWYbOIfuVxAPed8GTjxkJMUp85kJ
 YlTw28vaoOZ+2Q9h/hl+dZ3sa9RwSTCJDF1JxWAdftYTumXbKqeFnnVK9+6VhnJzX0Fb
 qiGfamdCw01aB0Y+MgutuXZw6EUY8206eU2aDENhRfYUQuCS+GNv/09uPX3fWWoNbwXQ
 hRyiJ4lXBkezaMupjE8ftDx1bSIZ7lLISaHOw/9/aIYuf01t99DxVKy9gII8nAQvbyR8
 GZquhrtQYB4dZAn6ZeEpRrmHmJE48XDO+f2sYwM+T1GbG8FVejYN5gWSTdjZVMy25W8i
 cBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841236; x=1736446036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05xzsuBphAtDRkwps4iZi7cEWm0Ps2aIo0PphtO0hbE=;
 b=PA6wd8atgy1rJJNFBkqFJZDyjGtkmFUsietIjrcp+D5Y0kjW1UcL4TiUX5saNSKV3R
 XumsRAUhVxflzPHSMCMvdccLyxMq02oM0mE6+qKfv/xM9Xu10FGVWDYbOKBtKQvvM6t0
 5C9Pb0fEjpBcljaLWl+G3Mb4o3ah0MxGN4xpPTvyF5mYvn2PXmqEktkV9Ff480VRaZOy
 H9ff+/kwdG9s+3Ar44lEeK4sWafIiTA0slIt6BHBfpJF34tP9XgX4Ay9dRD0649VeRU3
 cY26jJlAlo6wDLZFtBLCn8CmxCdn0srqWx7+I1GsPBzF6Oj/bZZ2DACW9sssbhKgEMLB
 Ofbw==
X-Gm-Message-State: AOJu0YynzX8ZbwdMWqtsQE2wctjkp/dt7DObUC8Eu3fFm62TwARPRhJF
 YdjLXEBy8FPEjLQKjch4sFgF/tfkJzf9oZWd0GlDvDyZ5o/UnAmDaIoByR5kHDcge7+pTVAFlTW
 j
X-Gm-Gg: ASbGnctnFDx8p1io6i+/nk23kD8p7Nt3OrFUzs0ryciynm5SFU5i9BMYVV2J+7A73il
 H/NGWuwEEjQFqUDwgz35TM7EEhu2AywSJyouvwSCWn66FIchxmiLN5urgMTQN/DlC9ebsNLIjQM
 cL+ApoVwH2f3RCTjdTF6jrIzQ/U6Q2A1E0+U/QDRjyez2Sv/Y2UZWhRBJuBOGQrvRr/J25LcEmR
 hTL3F1EqEGwCvhE/WMlERZcLAaJQ1VUaEmxFeZQ//hgAbTh6ur8tUzuz6D/Wg==
X-Google-Smtp-Source: AGHT+IGPFMwWgYAaYiHKtQJEfXv8xgagAnZNPOl7ey5QjpThHT+Np0GxzeWq1QTjyvIX4RGOXJv6WQ==
X-Received: by 2002:a05:6a00:35ca:b0:724:f86e:e3d9 with SMTP id
 d2e1a72fcca58-72abdecbdb4mr62493823b3a.14.1735841235744; 
 Thu, 02 Jan 2025 10:07:15 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/73] tcg: Merge TCG_TARGET_HAS_{clz,ctz,ctpop}
Date: Thu,  2 Jan 2025 10:06:06 -0800
Message-ID: <20250102180654.1420056-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-opc.h            |  12 +--
 tcg/aarch64/tcg-target-has.h     |   9 +-
 tcg/arm/tcg-target-has.h         |   6 +-
 tcg/i386/tcg-target-has.h        |   9 +-
 tcg/loongarch64/tcg-target-has.h |   9 +-
 tcg/mips/tcg-target-has.h        |   9 +-
 tcg/ppc/tcg-target-has.h         |   9 +-
 tcg/riscv/tcg-target-has.h       |   9 +-
 tcg/s390x/tcg-target-has.h       |   9 +-
 tcg/sparc64/tcg-target-has.h     |   9 +-
 tcg/tcg-has.h                    |   3 -
 tcg/tci/tcg-target-has.h         |   9 +-
 tcg/tcg-op.c                     | 142 ++++++++++++++++++-------------
 tcg/tcg.c                        |  12 +--
 tcg/tci.c                        |  12 ---
 15 files changed, 123 insertions(+), 145 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 511dd04b39..8d8fda39f8 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -106,9 +106,9 @@ DEF(orc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_orc(TCG_TYPE_I32)))
 DEF(eqv_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_eqv(TCG_TYPE_I32)))
 DEF(nand_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nand(TCG_TYPE_I32)))
 DEF(nor_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_nor(TCG_TYPE_I32)))
-DEF(clz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_clz_i32))
-DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))
-DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
+DEF(clz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_clz(TCG_TYPE_I32)))
+DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz(TCG_TYPE_I32)))
+DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop(TCG_TYPE_I32)))
 
 DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, IMPL64)
@@ -177,9 +177,9 @@ DEF(orc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_orc(TCG_TYPE_I64)))
 DEF(eqv_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_eqv(TCG_TYPE_I64)))
 DEF(nand_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nand(TCG_TYPE_I64)))
 DEF(nor_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_nor(TCG_TYPE_I64)))
-DEF(clz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_clz_i64))
-DEF(ctz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctz_i64))
-DEF(ctpop_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctpop_i64))
+DEF(clz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_clz(TCG_TYPE_I64)))
+DEF(ctz_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctz(TCG_TYPE_I64)))
+DEF(ctpop_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)))
 
 DEF(add2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_add2_i64))
 DEF(sub2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_sub2_i64))
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index fcf4b68454..247bf3e358 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -14,6 +14,9 @@
 
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)         1
+#define TCG_TARGET_HAS_clz(T)           1
+#define TCG_TARGET_HAS_ctpop(T)         0
+#define TCG_TARGET_HAS_ctz(T)           1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
@@ -30,9 +33,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
@@ -53,9 +53,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 1bc6081e17..29405706a4 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -25,6 +25,9 @@ extern bool use_neon_instructions;
 
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)         1
+#define TCG_TARGET_HAS_clz(T)           1
+#define TCG_TARGET_HAS_ctpop(T)         0
+#define TCG_TARGET_HAS_ctz(T)           use_armv7_instructions
 #define TCG_TARGET_HAS_div(T)           use_idiv_instructions
 #define TCG_TARGET_HAS_rem(T)           0
 #define TCG_TARGET_HAS_rot(T)           1
@@ -41,9 +44,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
-#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index ba6c9ff71a..a60e13616c 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -27,6 +27,9 @@
 
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)         1
+#define TCG_TARGET_HAS_clz(T)           1
+#define TCG_TARGET_HAS_ctpop(T)         have_popcnt
+#define TCG_TARGET_HAS_ctz(T)           1
 #define TCG_TARGET_HAS_div2(T)          1
 #define TCG_TARGET_HAS_rot(T)           1
 
@@ -42,9 +45,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        have_popcnt
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
@@ -66,9 +66,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        have_popcnt
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 0f15c678ce..b634baec4f 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -11,6 +11,9 @@
 
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)         1
+#define TCG_TARGET_HAS_clz(T)           1
+#define TCG_TARGET_HAS_ctpop(T)         0
+#define TCG_TARGET_HAS_ctz(T)           1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
@@ -38,9 +41,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_brcond2          0
 #define TCG_TARGET_HAS_setcond2         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -58,9 +58,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 14d8609d73..91ea0b56d5 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -40,6 +40,9 @@ extern bool use_mips32r2_instructions;
 
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)         1
+#define TCG_TARGET_HAS_clz(T)           use_mips32r2_instructions
+#define TCG_TARGET_HAS_ctpop(T)         0
+#define TCG_TARGET_HAS_ctz(T)           0
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           use_mips32r2_instructions
@@ -80,9 +83,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
-#define TCG_TARGET_HAS_clz_i32          use_mips32r2_instructions
-#define TCG_TARGET_HAS_ctz_i32          0
-#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -92,9 +92,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
-#define TCG_TARGET_HAS_clz_i64          use_mips32r2_instructions
-#define TCG_TARGET_HAS_ctz_i64          0
-#define TCG_TARGET_HAS_ctpop_i64        0
 #endif
 
 /* optional instructions automatically implemented */
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 68c7ff70c9..b593cd3308 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -18,6 +18,9 @@
 
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)         1
+#define TCG_TARGET_HAS_clz(T)           1
+#define TCG_TARGET_HAS_ctpop(T)         have_isa_2_06
+#define TCG_TARGET_HAS_ctz(T)           have_isa_3_00
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
@@ -36,9 +39,6 @@
 
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
-#define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -60,9 +60,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
-#define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index abc806ce4b..81f81787c0 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -11,6 +11,9 @@
 
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)         (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_clz(T)           (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_ctpop(T)         (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_ctz(T)           (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           (cpuinfo & CPUINFO_ZBB)
@@ -38,9 +41,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_brcond2          1
 #define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -57,9 +57,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 543fd146b3..c954a4c03e 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -30,6 +30,9 @@ extern uint64_t s390_facilities[3];
 
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)       1
+#define TCG_TARGET_HAS_clz(T)         (T == TCG_TYPE_I64)
+#define TCG_TARGET_HAS_ctpop(T)       1
+#define TCG_TARGET_HAS_ctz(T)         0
 #define TCG_TARGET_HAS_div2(T)        1
 #define TCG_TARGET_HAS_rot(T)         1
 
@@ -45,9 +48,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext16s_i32     1
 #define TCG_TARGET_HAS_ext8u_i32      1
 #define TCG_TARGET_HAS_ext16u_i32     1
-#define TCG_TARGET_HAS_clz_i32        0
-#define TCG_TARGET_HAS_ctz_i32        0
-#define TCG_TARGET_HAS_ctpop_i32      1
 #define TCG_TARGET_HAS_deposit_i32    1
 #define TCG_TARGET_HAS_extract_i32    1
 #define TCG_TARGET_HAS_sextract_i32   0
@@ -68,9 +68,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext8u_i64      1
 #define TCG_TARGET_HAS_ext16u_i64     1
 #define TCG_TARGET_HAS_ext32u_i64     1
-#define TCG_TARGET_HAS_clz_i64        1
-#define TCG_TARGET_HAS_ctz_i64        0
-#define TCG_TARGET_HAS_ctpop_i64      1
 #define TCG_TARGET_HAS_deposit_i64    1
 #define TCG_TARGET_HAS_extract_i64    1
 #define TCG_TARGET_HAS_sextract_i64   0
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index a3674cabe6..eaca708478 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -15,6 +15,9 @@ extern bool use_vis3_instructions;
 
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)         0
+#define TCG_TARGET_HAS_clz(T)           0
+#define TCG_TARGET_HAS_ctpop(T)         0
+#define TCG_TARGET_HAS_ctz(T)           0
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           0
 #define TCG_TARGET_HAS_rot(T)           0
@@ -31,9 +34,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext16s_i32       0
 #define TCG_TARGET_HAS_ext8u_i32        0
 #define TCG_TARGET_HAS_ext16u_i32       0
-#define TCG_TARGET_HAS_clz_i32          0
-#define TCG_TARGET_HAS_ctz_i32          0
-#define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -54,9 +54,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_clz_i64          0
-#define TCG_TARGET_HAS_ctz_i64          0
-#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 074c0bcbd2..b2f2cbf2ad 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -18,9 +18,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_clz_i64          0
-#define TCG_TARGET_HAS_ctz_i64          0
-#define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 28e413d5dc..957ed9e2b3 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -9,6 +9,9 @@
 
 /* optional integer instructions */
 #define TCG_TARGET_HAS_bswap(T)         1
+#define TCG_TARGET_HAS_clz(T)           1
+#define TCG_TARGET_HAS_ctpop(T)         1
+#define TCG_TARGET_HAS_ctz(T)           1
 #define TCG_TARGET_HAS_div(T)           1
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
@@ -29,9 +32,6 @@
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
@@ -50,9 +50,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        1
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_muls2_i64        1
 #define TCG_TARGET_HAS_add2_i32         1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8cfaad0ece..2fb4ce90dc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -714,9 +714,10 @@ void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_clz_i32) {
+    if (TCG_TARGET_HAS_clz(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_clz_i32, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_clz_i64) {
+    } else if (TCG_TARGET_REG_BITS == 64 &&
+               TCG_TARGET_HAS_clz(TCG_TYPE_I64)) {
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t1, arg1);
@@ -739,9 +740,9 @@ void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_ctz_i32) {
+    if (TCG_TARGET_HAS_ctz(TCG_TYPE_I32)) {
         tcg_gen_op3_i32(INDEX_op_ctz_i32, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_ctz_i64) {
+    } else if (TCG_TARGET_HAS_ctz(TCG_TYPE_I64)) {
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t1, arg1);
@@ -750,24 +751,26 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_extrl_i64_i32(ret, t1);
         tcg_temp_free_i64(t1);
         tcg_temp_free_i64(t2);
-    } else if (TCG_TARGET_HAS_ctpop_i32
-               || TCG_TARGET_HAS_ctpop_i64
-               || TCG_TARGET_HAS_clz_i32
-               || TCG_TARGET_HAS_clz_i64) {
-        TCGv_i32 z, t = tcg_temp_ebb_new_i32();
+    } else if (TCG_TARGET_HAS_ctpop(TCG_TYPE_I32) ||
+               TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)) {
+        TCGv_i32 t = tcg_temp_ebb_new_i32();
+        TCGv_i32 z = tcg_constant_i32(0);
 
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
+        tcg_gen_subi_i32(t, arg1, 1);
+        tcg_gen_andc_i32(t, t, arg1);
+        tcg_gen_ctpop_i32(t, t);
+        tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
+        tcg_temp_free_i32(t);
+    } else if (TCG_TARGET_HAS_clz(TCG_TYPE_I32) ||
+               TCG_TARGET_HAS_clz(TCG_TYPE_I64)) {
+        TCGv_i32 t = tcg_temp_ebb_new_i32();
+        TCGv_i32 z = tcg_constant_i32(0);
+
+        /* Since all non-x86 hosts have clz(0) == 32, don't fight it.  */
+        tcg_gen_neg_i32(t, arg1);
+        tcg_gen_and_i32(t, t, arg1);
+        tcg_gen_clzi_i32(t, t, 32);
+        tcg_gen_xori_i32(t, t, 31);
         tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
         tcg_temp_free_i32(t);
     } else {
@@ -777,7 +780,8 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
-    if (!TCG_TARGET_HAS_ctz_i32 && TCG_TARGET_HAS_ctpop_i32 && arg2 == 32) {
+    if (!TCG_TARGET_HAS_ctz(TCG_TYPE_I32) &&
+        TCG_TARGET_HAS_ctpop(TCG_TYPE_I32) && arg2 == 32) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_subi_i32(t, arg1, 1);
@@ -791,7 +795,7 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_clz_i32) {
+    if (TCG_TARGET_HAS_clz(TCG_TYPE_I32)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t, arg, 31);
         tcg_gen_xor_i32(t, t, arg);
@@ -805,9 +809,9 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 
 void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
 {
-    if (TCG_TARGET_HAS_ctpop_i32) {
+    if (TCG_TARGET_HAS_ctpop(TCG_TYPE_I32)) {
         tcg_gen_op2_i32(INDEX_op_ctpop_i32, ret, arg1);
-    } else if (TCG_TARGET_HAS_ctpop_i64) {
+    } else if (TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t, arg1);
         tcg_gen_ctpop_i64(t, t);
@@ -2475,7 +2479,8 @@ void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_clz_i64) {
+    if (TCG_TARGET_REG_BITS == 64 &&
+        TCG_TARGET_HAS_clz(TCG_TYPE_I64)) {
         tcg_gen_op3_i64(INDEX_op_clz_i64, ret, arg1, arg2);
     } else {
         gen_helper_clz_i64(ret, arg1, arg2);
@@ -2485,7 +2490,7 @@ void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
     if (TCG_TARGET_REG_BITS == 32
-        && TCG_TARGET_HAS_clz_i32
+        && TCG_TARGET_HAS_clz(TCG_TYPE_I32)
         && arg2 <= 0xffffffffu) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_clzi_i32(t, TCGV_LOW(arg1), arg2 - 32);
@@ -2500,44 +2505,53 @@ void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_ctz_i64) {
-        tcg_gen_op3_i64(INDEX_op_ctz_i64, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_ctpop_i64 || TCG_TARGET_HAS_clz_i64) {
-        TCGv_i64 z, t = tcg_temp_ebb_new_i64();
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (TCG_TARGET_HAS_ctz(TCG_TYPE_I64)) {
+            tcg_gen_op3_i64(INDEX_op_ctz_i64, ret, arg1, arg2);
+            return;
+        }
+        if (TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)) {
+            TCGv_i64 t = tcg_temp_ebb_new_i64();
+            TCGv_i64 z = tcg_constant_i64(0);
 
-        if (TCG_TARGET_HAS_ctpop_i64) {
             tcg_gen_subi_i64(t, arg1, 1);
             tcg_gen_andc_i64(t, t, arg1);
             tcg_gen_ctpop_i64(t, t);
-        } else {
+            tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
+            tcg_temp_free_i64(t);
+            return;
+        }
+        if (TCG_TARGET_HAS_clz(TCG_TYPE_I64)) {
+            TCGv_i64 t = tcg_temp_ebb_new_i64();
+            TCGv_i64 z = tcg_constant_i64(0);
+
             /* Since all non-x86 hosts have clz(0) == 64, don't fight it.  */
             tcg_gen_neg_i64(t, arg1);
             tcg_gen_and_i64(t, t, arg1);
             tcg_gen_clzi_i64(t, t, 64);
             tcg_gen_xori_i64(t, t, 63);
+            tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
+            tcg_temp_free_i64(t);
+            return;
         }
-        z = tcg_constant_i64(0);
-        tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
-        tcg_temp_free_i64(t);
-        tcg_temp_free_i64(z);
-    } else {
-        gen_helper_ctz_i64(ret, arg1, arg2);
     }
+    gen_helper_ctz_i64(ret, arg1, arg2);
 }
 
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32
-        && TCG_TARGET_HAS_ctz_i32
-        && arg2 <= 0xffffffffu) {
-        TCGv_i32 t32 = tcg_temp_ebb_new_i32();
-        tcg_gen_ctzi_i32(t32, TCGV_HIGH(arg1), arg2 - 32);
-        tcg_gen_addi_i32(t32, t32, 32);
-        tcg_gen_ctz_i32(TCGV_LOW(ret), TCGV_LOW(arg1), t32);
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-        tcg_temp_free_i32(t32);
-    } else if (!TCG_TARGET_HAS_ctz_i64
-               && TCG_TARGET_HAS_ctpop_i64
+    if (TCG_TARGET_REG_BITS == 32) {
+        if (TCG_TARGET_HAS_ctz(TCG_TYPE_I32) && arg2 <= 0xffffffffu) {
+            TCGv_i32 t32 = tcg_temp_ebb_new_i32();
+            tcg_gen_ctzi_i32(t32, TCGV_HIGH(arg1), arg2 - 32);
+            tcg_gen_addi_i32(t32, t32, 32);
+            tcg_gen_ctz_i32(TCGV_LOW(ret), TCGV_LOW(arg1), t32);
+            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+            tcg_temp_free_i32(t32);
+            return;
+        }
+    } else if (!TCG_TARGET_HAS_ctz(TCG_TYPE_I64)
+               && TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)
                && arg2 == 64) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i64 t = tcg_temp_ebb_new_i64();
@@ -2545,14 +2559,15 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
         tcg_gen_andc_i64(t, t, arg1);
         tcg_gen_ctpop_i64(ret, t);
         tcg_temp_free_i64(t);
-    } else {
-        tcg_gen_ctz_i64(ret, arg1, tcg_constant_i64(arg2));
+        return;
     }
+    tcg_gen_ctz_i64(ret, arg1, tcg_constant_i64(arg2));
 }
 
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_HAS_clz_i64 || TCG_TARGET_HAS_clz_i32) {
+    if (TCG_TARGET_HAS_clz(TCG_TYPE_I64) ||
+        TCG_TARGET_HAS_clz(TCG_TYPE_I32)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_sari_i64(t, arg, 63);
         tcg_gen_xor_i64(t, t, arg);
@@ -2566,16 +2581,21 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 
 void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
 {
-    if (TCG_TARGET_HAS_ctpop_i64) {
-        tcg_gen_op2_i64(INDEX_op_ctpop_i64, ret, arg1);
-    } else if (TCG_TARGET_REG_BITS == 32 && TCG_TARGET_HAS_ctpop_i32) {
-        tcg_gen_ctpop_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
-        tcg_gen_ctpop_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
-        tcg_gen_add_i32(TCGV_LOW(ret), TCGV_LOW(ret), TCGV_HIGH(ret));
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)) {
+            tcg_gen_op2_i64(INDEX_op_ctpop_i64, ret, arg1);
+            return;
+        }
     } else {
-        gen_helper_ctpop_i64(ret, arg1);
+        if (TCG_TARGET_HAS_ctpop(TCG_TYPE_I32)) {
+            tcg_gen_ctpop_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
+            tcg_gen_ctpop_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
+            tcg_gen_add_i32(TCGV_LOW(ret), TCGV_LOW(ret), TCGV_HIGH(ret));
+            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+            return;
+        }
     }
+    gen_helper_ctpop_i64(ret, arg1);
 }
 
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0f3e03b7f5..de22bdab85 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2266,11 +2266,11 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_nor_i32:
         return TCG_TARGET_HAS_nor(TCG_TYPE_I32);
     case INDEX_op_clz_i32:
-        return TCG_TARGET_HAS_clz_i32;
+        return TCG_TARGET_HAS_clz(TCG_TYPE_I32);
     case INDEX_op_ctz_i32:
-        return TCG_TARGET_HAS_ctz_i32;
+        return TCG_TARGET_HAS_ctz(TCG_TYPE_I32);
     case INDEX_op_ctpop_i32:
-        return TCG_TARGET_HAS_ctpop_i32;
+        return TCG_TARGET_HAS_ctpop(TCG_TYPE_I32);
 
     case INDEX_op_brcond2_i32:
     case INDEX_op_setcond2_i32:
@@ -2359,11 +2359,11 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_nor_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_nor(TCG_TYPE_I64);
     case INDEX_op_clz_i64:
-        return TCG_TARGET_HAS_clz_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_clz(TCG_TYPE_I64);
     case INDEX_op_ctz_i64:
-        return TCG_TARGET_HAS_ctz_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_ctz(TCG_TYPE_I64);
     case INDEX_op_ctpop_i64:
-        return TCG_TARGET_HAS_ctpop_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_ctpop(TCG_TYPE_I64);
     case INDEX_op_add2_i64:
         return TCG_TARGET_HAS_add2_i64;
     case INDEX_op_sub2_i64:
diff --git a/tcg/tci.c b/tcg/tci.c
index 54838650b7..eeea2a9094 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -596,26 +596,20 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint32_t)regs[r1] % (uint32_t)regs[r2];
             break;
-#if TCG_TARGET_HAS_clz_i32
         case INDEX_op_clz_i32:
             tci_args_rrr(insn, &r0, &r1, &r2);
             tmp32 = regs[r1];
             regs[r0] = tmp32 ? clz32(tmp32) : regs[r2];
             break;
-#endif
-#if TCG_TARGET_HAS_ctz_i32
         case INDEX_op_ctz_i32:
             tci_args_rrr(insn, &r0, &r1, &r2);
             tmp32 = regs[r1];
             regs[r0] = tmp32 ? ctz32(tmp32) : regs[r2];
             break;
-#endif
-#if TCG_TARGET_HAS_ctpop_i32
         case INDEX_op_ctpop_i32:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop32(regs[r1]);
             break;
-#endif
 
             /* Shift/rotate operations (32 bit). */
 
@@ -768,24 +762,18 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint64_t)regs[r1] % (uint64_t)regs[r2];
             break;
-#if TCG_TARGET_HAS_clz_i64
         case INDEX_op_clz_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
             break;
-#endif
-#if TCG_TARGET_HAS_ctz_i64
         case INDEX_op_ctz_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
             break;
-#endif
-#if TCG_TARGET_HAS_ctpop_i64
         case INDEX_op_ctpop_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop64(regs[r1]);
             break;
-#endif
 #if TCG_TARGET_HAS_mulu2_i64
         case INDEX_op_mulu2_i64:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
-- 
2.43.0


