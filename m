Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8CBC369C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lue-0008W6-EB; Tue, 15 Apr 2025 15:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lub-0008Ur-WA
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luV-0007z2-6H
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:35 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so5518817b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745129; x=1745349929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vfgg3MNPjObmqtzZ/G6Bu5QPBlCPNY6r/utSAijYmW0=;
 b=swvcr9p+lLbPAgeRVpcyBnEkpeveQeKnUmqKOGhdY9+L7TLaieHKJbUbmJFij+ohic
 fMzJC+DK/iYfyYTGtMiAehBL3N3S5AlDpn59gr4mPOo3iwosbWOPaMF4Po42dYoYn3mv
 UIBJk7H4yg3cHcXKpB5CVKEC38+VoM4v8vRqW1Tz9tnLGgz2sWZLghm/MqYalUS8334f
 oPtx+sdZm4lSp0Olze8jyXbSicwcJUWmB0m3JZDglEq6BSaekQ0Kp/PKh7+JvYNzfwWM
 aVsYEuWSOdrs5dg+Vx+/ZHFMnjnR6E1U+2CbrQUU6/R2oGToUECAISzQJQJgvV/Z1rXH
 7CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745129; x=1745349929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vfgg3MNPjObmqtzZ/G6Bu5QPBlCPNY6r/utSAijYmW0=;
 b=Lg6MJY9lVNVuR+n3ODCFuocQnFBay4//EIR9Lrb5JjQAjOPE+P/lbd4T/kAiaTI4pH
 WbsLJOYY1odg6Q2uyFFEO/dthPEQ9kAZKi5Hy+VnRnJFkth68e425ju8Xy4j30cxRCdg
 3QcaeUO3GW2XXbWb0ZWlNgh8yarY6f7B7F8AT5FsaoqPCYSO/TKzUVKNzok9Nj7dsBUw
 /NGO6HeIdkmzHFh47b1VB1K/1rE4ged+vI6CtJfNEk37kfGoL80C3wTVXXkSUmn4uJeg
 eDoZFkJICCG5es0RsTOQdDBgB8VNBRKY2yCbLi+C3LOGL+7dHEipTh5NxgUjxsb3uyWl
 9VlQ==
X-Gm-Message-State: AOJu0YxL1o8LQDbGe6UAaNEFXsHWfiAHbFL+bTMcRiljYEx6znISzjjZ
 qS5gJfJTD/ECeho04T06IyAOJc2aF3K6rZkxo9iL96/ZlulssjX7vgbAhAaJLNwV+HwnLwI5b8l
 T
X-Gm-Gg: ASbGnctfFocBUv8fENfiQ3q/7aP+pmhLjxod9B778hujH9A2W/ZzqhtbsAgLaA7J2NH
 uWxf6LxNWX0+WXgLyhxYaThXHqzaC9GAsb/lecUZU+k7jL4c1Mouui0h1cxohHqnp5uOVvr2Z/R
 QhP2+JKaAuO6ogUy4pCT38NbcdEE0LqqqNSd+rzSXwxoxXWqO0+6pFft3CjSqsboao1Uir85jhp
 2TreFyLa8QtI3+ltQiDxjXymLDTGngyPi72z+4HAkxn8mMRJB0tzkwRhmNPWtImpNSw1HLU/MJK
 EogCljb+2zSxjFh+gvFvNPr+t2bSdCjGMAQrvpluKojrHx59cCCMaaMjD/lG5fpFmsJaPvuMHNg
 =
X-Google-Smtp-Source: AGHT+IEfhJfB55ESc38RKSWLehPd0T9oo1CPCuPJO0kBzez/4DCrNWsWW26oivXFHCgAQCfUmtp7WA==
X-Received: by 2002:a05:6a00:3288:b0:736:a82a:58ad with SMTP id
 d2e1a72fcca58-73c1fb0500fmr903944b3a.15.1744745129393; 
 Tue, 15 Apr 2025 12:25:29 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 016/163] tcg: Convert orc to TCGOutOpBinary
Date: Tue, 15 Apr 2025 12:22:47 -0700
Message-ID: <20250415192515.232910-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 5cc6c293be..577a69fe3b 100644
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
@@ -5439,6 +5437,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index 0575d397c9..48cbcd67b9 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1899,6 +1899,10 @@ static const TCGOutOpBinary outop_or = {
     .out_rri = tgen_ori,
 };
 
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 813092622c..3fe1d9d9cc 100644
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


