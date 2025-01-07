Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93316E77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bY-0004QJ-Rk; Tue, 07 Jan 2025 03:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ar-0001JR-OG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:41 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aj-0003eO-EJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:41 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso1653625ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237132; x=1736841932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ev2c8qUXL44JgWiOvIi+qeDhO9SoaX1XJzE2X4lpC4A=;
 b=w2IlxhO/zCMfI1NzjiMLIIP2TV8iaFclp9N5J+HkqZJ2QIrEmxX39aw8s5G5OEuBiH
 f6E5HPx+0tzyvb0dz/Zb7myKZlmlBIp7VicZHKYknCRIRUzLXCdCpnbKlKK8vUfuHYzX
 3FuCX/VT6z5H4jH78mEMmqlzfDEu0HIXK/1CXdHwymX8+uBOOCkkadBaaKxUIf+AvtkY
 GAIKUYZcc6cGTQloKq2sWIxsY69CFvq5M0e+YmdYLV9nx37azQ2AmKn1XsAQ0iWj8qR6
 XQUFfjSD7kIzs0zx6qxwfFtA4tqadknCpG53CKr3lMoCYpYpl1wfmXHfnIOYFfnHzh2c
 HXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237132; x=1736841932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ev2c8qUXL44JgWiOvIi+qeDhO9SoaX1XJzE2X4lpC4A=;
 b=N1Id9YhfxuiIACIpJR7UVp4u1gyJ4UHW7NKGNccxmOCFv3IGNnjGbEXuIqM6NqQqvQ
 MYZUQpXJcpqQEZ0RSbqLI0A8vK7yX6XfiYLsmg9cyhEZ3XfgkR+/9MNTLMObiQaM6tE3
 lfBGw9Vk7kb8ih16S90huYG98DHltxustwbvWrV8xT/CazpbeZwKtUscx/j8VKnM1NMF
 0BtUEYmJgnnINxt4SQXQdo02xphK1vTPShvNqOp8BM3T+3lWcM0tLNuNjSy5n1jkiC7O
 xQWhr/ywnhTPkNgvHz3/9/AWAkG7OqEJtSfqaOnq5WhLFVgB5+LhT+e8G7HRvuwbpF2V
 mshA==
X-Gm-Message-State: AOJu0YyhpZEZ0jt45SqQEoPb731UA9GTnqLkcvVOQpW30/oo4lR871tv
 FrnqTbL8XzPE8tWg5SwlnHNaGPAbBXjIkDRJ/l/aG+FOUJiFACwDE3Izyt3e0Qu7vJGtzwSI256
 h
X-Gm-Gg: ASbGncu+xrCHcu3rUZVDyfYP5S73/aYI8L5bdXtG3oZaQ9+9EhvbgMeFrn66/TLyO6v
 89gH7bce65w/GtAMvgK8N/wnoLN0M4840Q1r8i2WxYx6knINof20WgzbvYJf08wwnhFySFO5mO9
 Pqe2JHClE/l6jL7cDh2Pc+XsMJ0Th2LvCBUh9IdiilHlfpVFvpiC6OiFj/0qF+ob7iuIhIe4CS8
 DDN0iqTgkwXB6Q4TIhNssPOctGM4YdUvwCVl1p3HYVlDDvL4oTaPyNQEHx2z/T7/3oBdAfLqTXl
 N/YBaC7cxXqxgPK3jQ==
X-Google-Smtp-Source: AGHT+IE4KL+WhHFeR2O4bNYieDVnWIi4tF+VgRUAP5MFoCjmXe9I6p1FJ/VRCm0V9Txqe+Cyrqe53A==
X-Received: by 2002:a05:6a21:6da2:b0:1db:de38:294b with SMTP id
 adf61e73a8af0-1e5e0819216mr105402836637.38.1736237132011; 
 Tue, 07 Jan 2025 00:05:32 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 73/81] tcg: Convert nor to TCGOutOpBinary
Date: Tue,  7 Jan 2025 00:01:04 -0800
Message-ID: <20250107080112.1175095-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
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
 tcg/tci.c                        |  2 --
 tcg/aarch64/tcg-target.c.inc     |  4 ++++
 tcg/arm/tcg-target.c.inc         |  4 ++++
 tcg/i386/tcg-target.c.inc        |  4 ++++
 tcg/loongarch64/tcg-target.c.inc | 20 +++++++++++---------
 tcg/mips/tcg-target.c.inc        | 17 +++++++++++------
 tcg/ppc/tcg-target.c.inc         | 18 +++++++++++-------
 tcg/riscv/tcg-target.c.inc       |  4 ++++
 tcg/s390x/tcg-target.c.inc       | 28 ++++++++++++++++------------
 tcg/sparc64/tcg-target.c.inc     |  4 ++++
 tcg/tci/tcg-target.c.inc         | 14 +++++++++++---
 24 files changed, 86 insertions(+), 65 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 2acc9bd3b7..240fcac2cc 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -19,7 +19,6 @@
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -41,7 +40,6 @@
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 8d7b176993..e80711ee40 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -28,7 +28,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
 #define TCG_TARGET_HAS_ctpop_i32        0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 93552f2337..b27f853dcd 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -31,7 +31,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        have_popcnt
@@ -53,7 +52,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        have_popcnt
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 27e36e87ff..70bccdaa2e 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -25,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -45,7 +44,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 2f8325d56f..987f83f761 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -42,7 +42,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muluh_i32        1
@@ -58,7 +57,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 810f20d120..6be6d7f994 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -23,7 +23,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
@@ -46,7 +45,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 75a4f9149f..0c375e40bb 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -25,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
@@ -44,7 +43,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index d8afd73814..374db3cf9d 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -34,7 +34,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nor_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i32        0
 #define TCG_TARGET_HAS_ctz_i32        0
 #define TCG_TARGET_HAS_ctpop_i32      1
@@ -55,7 +54,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nor_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i64        1
 #define TCG_TARGET_HAS_ctz_i64        0
 #define TCG_TARGET_HAS_ctpop_i64      1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 9bc0474107..35ae536879 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -20,7 +20,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          0
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -42,7 +41,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index e2a99067ac..7de13ef383 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_not_i64          0
-#define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 8be70297f5..13c9dc3dfa 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -12,7 +12,6 @@
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        1
@@ -32,7 +31,6 @@
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 57782864fa..ac939bb4ea 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -700,7 +700,7 @@ void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_nor_i32) {
+    if (tcg_op_supported(INDEX_op_nor_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_nor_i32, ret, arg1, arg2);
     } else {
         tcg_gen_or_i32(ret, arg1, arg2);
@@ -2305,7 +2305,7 @@ void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_nor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_nor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (TCG_TARGET_HAS_nor_i64) {
+    } else if (tcg_op_supported(INDEX_op_nor_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_nor_i64, ret, arg1, arg2);
     } else {
         tcg_gen_or_i64(ret, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c419cf4a16..85101b36c6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -996,6 +996,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
+    OUTOP(INDEX_op_nor_i32, TCGOutOpBinary, outop_nor),
+    OUTOP(INDEX_op_nor_i64, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -2275,8 +2277,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap32_i32;
     case INDEX_op_not_i32:
         return TCG_TARGET_HAS_not_i32;
-    case INDEX_op_nor_i32:
-        return TCG_TARGET_HAS_nor_i32;
     case INDEX_op_clz_i32:
         return TCG_TARGET_HAS_clz_i32;
     case INDEX_op_ctz_i32:
@@ -2342,8 +2342,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap64_i64;
     case INDEX_op_not_i64:
         return TCG_TARGET_HAS_not_i64;
-    case INDEX_op_nor_i64:
-        return TCG_TARGET_HAS_nor_i64;
     case INDEX_op_clz_i64:
         return TCG_TARGET_HAS_clz_i64;
     case INDEX_op_ctz_i64:
@@ -5419,6 +5417,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_eqv:
     case INDEX_op_nand:
+    case INDEX_op_nor_i32:
+    case INDEX_op_nor_i64:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 9d89ca0a6b..de3edcc8d2 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -573,12 +573,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] & regs[r2]);
             break;
-#if TCG_TARGET_HAS_nor_i32 || TCG_TARGET_HAS_nor_i64
         CASE_32_64(nor)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] | regs[r2]);
             break;
-#endif
 
             /* Arithmetic operations (32 bit). */
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index c2f97439b9..966af79314 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2172,6 +2172,10 @@ static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 5ece4ad064..8e3448c7bd 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1915,6 +1915,10 @@ static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a7310ffeff..47d0323426 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2706,6 +2706,10 @@ static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 24d00af2ee..efc483a550 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1331,6 +1331,17 @@ static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_nor(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_nor(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_nor,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1418,11 +1429,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_nor(s, a0, a1, TCG_REG_ZERO);
         break;
 
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
-        tcg_out_opc_nor(s, a0, a1, a2);
-        break;
-
     case INDEX_op_extract_i32:
         if (a2 == 0 && args[3] <= 12) {
             tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
@@ -2320,10 +2326,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
-        return C_O1_I2(r, r, r);
-
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index a73bd3b6ed..3a039a805d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1743,6 +1743,17 @@ static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_nor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_NOR, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_nor,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1876,10 +1887,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             break;
         }
         goto do_binaryv;
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
-        i1 = OPC_NOR;
-        goto do_binaryv;
 
     case INDEX_op_mul_i32:
         if (use_mips32_instructions) {
@@ -2291,7 +2298,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_nor_i32:
     case INDEX_op_setcond_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_mulsh_i64:
@@ -2300,7 +2306,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
-    case INDEX_op_nor_i64:
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rZ, rZ);
     case INDEX_op_muls2_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 72f38ff3f3..fe43583e8b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3014,6 +3014,17 @@ static const TCGOutOpBinary outop_nand = {
     .out_rrr = tgen_nand,
 };
 
+static void tgen_nor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, NOR | SAB(a1, a0, a2));
+}
+
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_nor,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3146,11 +3157,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
-        tcg_out32(s, NOR | SAB(args[1], args[0], args[2]));
-        break;
-
     case INDEX_op_clz_i32:
         tcg_out_cntxz(s, TCG_TYPE_I32, CNTLZW, args[0], args[1],
                       args[2], const_args[2]);
@@ -4253,10 +4259,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_nor_i32:
     case INDEX_op_muluh_i32:
     case INDEX_op_mulsh_i32:
-    case INDEX_op_nor_i64:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index ef6d337586..6d600a9940 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2024,6 +2024,10 @@ static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 5bf2b0f455..3b55ec4ac8 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2274,6 +2274,22 @@ static const TCGOutOpBinary outop_nand = {
     .out_rrr = tgen_nand,
 };
 
+static void tgen_nor(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, NORK, a0, a1, a2);
+    } else {
+        tcg_out_insn(s, RRFa, NOGRK, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_misc3_rrr,
+    .out_rrr = tgen_nor,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2408,10 +2424,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_nor_i32:
-        tcg_out_insn(s, RRFa, NORK, args[0], args[1], args[2]);
-        break;
-
     case INDEX_op_neg_i32:
         tcg_out_insn(s, RR, LCR, args[0], args[1]);
         break;
@@ -2621,10 +2633,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_nor_i64:
-        tcg_out_insn(s, RRFa, NOGRK, args[0], args[1], args[2]);
-        break;
-
     case INDEX_op_neg_i64:
         tcg_out_insn(s, RRE, LCGR, args[0], args[1]);
         break;
@@ -3304,10 +3312,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
-        return C_O1_I2(r, r, r);
-
     case INDEX_op_mul_i32:
         return (HAVE_FACILITY(MISC_INSN_EXT2)
                 ? C_O1_I2(r, r, ri)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 8e4929706b..06772166bd 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1350,6 +1350,10 @@ static const TCGOutOpBinary outop_nand = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_ori(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 97f6c12749..d66176a81d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -95,8 +95,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
@@ -702,6 +700,17 @@ static const TCGOutOpBinary outop_nand = {
     .out_rrr = tgen_nand,
 };
 
+static void tgen_nor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_nor_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_nor,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -779,7 +788,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     CASE_32_64(sub)
     CASE_32_64(mul)
-    CASE_32_64(nor)      /* Optional (TCG_TARGET_HAS_nor_*). */
     CASE_32_64(shl)
     CASE_32_64(shr)
     CASE_32_64(sar)
-- 
2.43.0


