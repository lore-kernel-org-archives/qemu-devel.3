Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F33EE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bN-0003bL-9U; Tue, 07 Jan 2025 03:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ao-0000y1-H6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:38 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ag-0003du-0U
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:38 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21654fdd5daso206024635ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237129; x=1736841929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xARybZybc5i5mxKYNpGNbibAmHUJgP+BBjDtFu7SqPk=;
 b=BdrqymXWJzW3cFwZ2CWbAimsGjuFPx8e63khTftLg85Qz8pteiJ7oShwlqZlOYxeLk
 JdeIlp+L1uD6PNVSpu7mSP2oNwG5NcHn41f/TGZfyUYtRhniyRWj1PAI+zKbiabjp6NS
 /Y0Cp3zngm0TX5xe6j/dES6eSILFTqArs+wBLYYZpTz6PLGsWgHEBOLZc9eLgS5RQsmi
 O2v3WWN9bWO8pZi1JHMRRNfJ+qdK+1rGO+MZHvVkDSRm3QmCIgU3St16oJgfThdSczPO
 QK0zlTDzb8zUABAQvYF9rOTGoqokt0Ijo1xNrzm7NU2dBWeSrGvxLDtLS3sz7zo36c09
 YnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237129; x=1736841929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xARybZybc5i5mxKYNpGNbibAmHUJgP+BBjDtFu7SqPk=;
 b=w/nZ5oabZ9KqZI9oUfEtnpGHFnfot7juIi99KF2it4YAOGrlklKn9zxmwYsQf3kbOb
 7yHPdlirltwXqwfgV0qCUJ3bqs7JICpG4kUVdLNJYowSK5wZ06InXqyLVeIqdQm4/y8H
 ohuaGQV2A7WpWEMGqvO3oMEpAZM+P43tOfhKZ0ngxK/HQLlq2L6qzrPxqtwxC2eXghIN
 vsF7S0impVYeJsSgapBr6kzpDqMPh+6CrrtTBfMX7yoEPCpQcV2rp3wvbZCzh7h/h7Q5
 3t8RyBGMeXBpMYpqPQwIWk1ZpSQ3X5m5fbydWTdN43jFzm++liazWROGP4VIMkGymApF
 TQaQ==
X-Gm-Message-State: AOJu0YxHMNGdWXHggk/Lmi/GZ3FQ81WNSPdnhyDK6BFM4Omkv/BrCtbE
 DObWmTMeiw7QFhQN0LiLZuCEwuYYytctSEd3FBTzN5cIzdrG8bAHCl8JMisjXtPz8v+/YYh6nTV
 6
X-Gm-Gg: ASbGncveg5U1u+8HxtEvsVfSRiUqYVtzHJDAjdVHT3Jha5aztgA6Cjp/yN6m6fQoqpV
 bu1RhZFlU01ashI/Oe5kczkfUyJF98DW1U73hQ36rHlHXPgGkGnUuvrIA4RZb6tlCEvl0pVfIh2
 UNhAplg2nLcTgUoL0GyTyh8vTDAXcfVHWrn+Qu/owVM4aDvHaapKNbyf5ru2+XGImT9TrlUuDOE
 5A5nWfXOmR9nUGrcTmdqmV8N4xt+fYO4gvLjV/W2LgqmecmUs1jTbKD7AGVnjab0LAfEt1Ke8Fo
 c/Q2bPNJJhx9s58jaA==
X-Google-Smtp-Source: AGHT+IF8QSUKqXBZJPNQYtrSEEvPT2OEasrKpqYwE5InmHrhJ8poQPASgX7FIElvdGbAEHMGxj52bg==
X-Received: by 2002:a05:6a00:1702:b0:728:9d19:d2ea with SMTP id
 d2e1a72fcca58-72abddb2115mr88981836b3a.13.1736237128643; 
 Tue, 07 Jan 2025 00:05:28 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 70/81] tcg: Convert nand to TCGOutOpBinary
Date: Tue,  7 Jan 2025 00:01:01 -0800
Message-ID: <20250107080112.1175095-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
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
 tcg/sparc64/tcg-target-has.h     |  2 --
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 --
 tcg/tcg-op.c                     |  4 ++--
 tcg/tcg.c                        |  8 ++++----
 tcg/tci.c                        |  2 --
 tcg/aarch64/tcg-target.c.inc     |  4 ++++
 tcg/arm/tcg-target.c.inc         |  4 ++++
 tcg/i386/tcg-target.c.inc        |  4 ++++
 tcg/loongarch64/tcg-target.c.inc |  4 ++++
 tcg/mips/tcg-target.c.inc        |  4 ++++
 tcg/ppc/tcg-target.c.inc         | 17 +++++++++++------
 tcg/riscv/tcg-target.c.inc       |  4 ++++
 tcg/s390x/tcg-target.c.inc       | 24 ++++++++++++++++--------
 tcg/sparc64/tcg-target.c.inc     |  4 ++++
 tcg/tci/tcg-target.c.inc         | 14 +++++++++++---
 24 files changed, 72 insertions(+), 45 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index c17aafc3bb..2acc9bd3b7 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -19,7 +19,6 @@
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
@@ -42,7 +41,6 @@
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 9ed85798e7..8d7b176993 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -28,7 +28,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 0183cafe61..93552f2337 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -31,7 +31,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
@@ -54,7 +53,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 4c38ed7b42..27e36e87ff 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -25,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
@@ -46,7 +45,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 9745c64db1..2f8325d56f 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -43,7 +43,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muluh_i32        1
@@ -60,7 +59,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_nor_i64          1
-#define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 8ede19bfad..810f20d120 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -23,7 +23,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nand_i32         1
 #define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
@@ -47,7 +46,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nand_i64         1
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index b44cd71e9c..75a4f9149f 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -25,7 +25,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
@@ -45,7 +44,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 722a2ede1c..d8afd73814 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -34,7 +34,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nand_i32       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nor_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i32        0
 #define TCG_TARGET_HAS_ctz_i32        0
@@ -56,7 +55,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nand_i64       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_nor_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i64        1
 #define TCG_TARGET_HAS_ctz_i64        0
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 2ec5f5657c..9bc0474107 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -20,7 +20,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          0
 #define TCG_TARGET_HAS_ctz_i32          0
@@ -43,7 +42,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index a5808dcc0a..e2a99067ac 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -20,7 +20,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_not_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 2c0876a0fd..8be70297f5 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -12,7 +12,6 @@
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_nand_i32         1
 #define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
@@ -33,7 +32,6 @@
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_nand_i64         1
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2520a60cee..3921bac48d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -690,7 +690,7 @@ void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_nand_i32) {
+    if (tcg_op_supported(INDEX_op_nand_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_nand_i32, ret, arg1, arg2);
     } else {
         tcg_gen_and_i32(ret, arg1, arg2);
@@ -2292,7 +2292,7 @@ void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_nand_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_nand_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (TCG_TARGET_HAS_nand_i64) {
+    } else if (tcg_op_supported(INDEX_op_nand_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_nand_i64, ret, arg1, arg2);
     } else {
         tcg_gen_and_i64(ret, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 37ef2bb392..d40f1f2c25 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -995,6 +995,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
+    OUTOP(INDEX_op_nand_i32, TCGOutOpBinary, outop_nand),
+    OUTOP(INDEX_op_nand_i64, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
@@ -2274,8 +2276,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap32_i32;
     case INDEX_op_not_i32:
         return TCG_TARGET_HAS_not_i32;
-    case INDEX_op_nand_i32:
-        return TCG_TARGET_HAS_nand_i32;
     case INDEX_op_nor_i32:
         return TCG_TARGET_HAS_nor_i32;
     case INDEX_op_clz_i32:
@@ -2343,8 +2343,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap64_i64;
     case INDEX_op_not_i64:
         return TCG_TARGET_HAS_not_i64;
-    case INDEX_op_nand_i64:
-        return TCG_TARGET_HAS_nand_i64;
     case INDEX_op_nor_i64:
         return TCG_TARGET_HAS_nor_i64;
     case INDEX_op_clz_i64:
@@ -5421,6 +5419,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_eqv:
+    case INDEX_op_nand_i32:
+    case INDEX_op_nand_i64:
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 093a48ddfb..408bf8e574 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -569,12 +569,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] ^ regs[r2]);
             break;
-#if TCG_TARGET_HAS_nand_i32 || TCG_TARGET_HAS_nand_i64
         CASE_32_64(nand)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] & regs[r2]);
             break;
-#endif
 #if TCG_TARGET_HAS_nor_i32 || TCG_TARGET_HAS_nor_i64
         CASE_32_64(nor)
             tci_args_rrr(insn, &r0, &r1, &r2);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index e0d8a8e428..c2f97439b9 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2168,6 +2168,10 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index f1a6d89453..5ece4ad064 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1911,6 +1911,10 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 8c10668b65..a7310ffeff 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2702,6 +2702,10 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 55e3cc6244..bc300de523 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1327,6 +1327,10 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index c5589de2c6..a73bd3b6ed 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1739,6 +1739,10 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 32b18a2014..72f38ff3f3 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3003,6 +3003,17 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_nand(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, NAND | SAB(a1, a0, a2));
+}
+
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_nand,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3135,10 +3146,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
-        tcg_out32(s, NAND | SAB(args[1], args[0], args[2]));
-        break;
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
         tcg_out32(s, NOR | SAB(args[1], args[0], args[2]));
@@ -4246,11 +4253,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_nand_i32:
     case INDEX_op_nor_i32:
     case INDEX_op_muluh_i32:
     case INDEX_op_mulsh_i32:
-    case INDEX_op_nand_i64:
     case INDEX_op_nor_i64:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f468eff28f..ef6d337586 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2020,6 +2020,10 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index d7c3059e66..5bf2b0f455 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2258,6 +2258,22 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_nand(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, NNRK, a0, a1, a2);
+    } else {
+        tcg_out_insn(s, RRFa, NNGRK, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_misc3_rrr,
+    .out_rrr = tgen_nand,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2392,9 +2408,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_nand_i32:
-        tcg_out_insn(s, RRFa, NNRK, args[0], args[1], args[2]);
-        break;
     case INDEX_op_nor_i32:
         tcg_out_insn(s, RRFa, NORK, args[0], args[1], args[2]);
         break;
@@ -2608,9 +2621,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_nand_i64:
-        tcg_out_insn(s, RRFa, NNGRK, args[0], args[1], args[2]);
-        break;
     case INDEX_op_nor_i64:
         tcg_out_insn(s, RRFa, NOGRK, args[0], args[1], args[2]);
         break;
@@ -3294,8 +3304,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
         return C_O1_I2(r, r, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index f0d4d8a6ea..8e4929706b 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1346,6 +1346,10 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_ori(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index f2724d2cf3..808bb635e2 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -95,8 +95,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
     case INDEX_op_shl_i32:
@@ -693,6 +691,17 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_nand(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_nand_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_nand,
+};
+
 static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -770,7 +779,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     CASE_32_64(sub)
     CASE_32_64(mul)
-    CASE_32_64(nand)     /* Optional (TCG_TARGET_HAS_nand_*). */
     CASE_32_64(nor)      /* Optional (TCG_TARGET_HAS_nor_*). */
     CASE_32_64(shl)
     CASE_32_64(shr)
-- 
2.43.0


