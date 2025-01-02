Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AB3E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfO-0003IK-QF; Thu, 02 Jan 2025 13:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeT-0007Ge-4N
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:38 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeQ-0006Cw-RT
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:32 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so166245585ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841429; x=1736446229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MR9+FRi8VNgioGiOAYUPx+G1pfmyRHcV2/0d37HNVVA=;
 b=G88BrnPfPSCjF1ewu1sgym4LeM/DgPLe5x3oggfEccArHkNqauR0OtuINo/n3imjXI
 Mt4ZUYx15ttCSeNWVwaKKXXskmyB+ABmQhaupHjwm7Icvhl7Sl8jnyAwsbVNkSGBWfnZ
 BSqKCUQJ07SPAgA0WrDPvtjgOc+nROuAsaQBbjMJbZf4Kw0JF3yElkSj/lYaht1yngM8
 KnM3WD3M2egTQf7rM15XcQR1+xwqSo2IMNbC/z7FXxKWd3i4wX01nTy5iWWuUWElYGgt
 GkSx7FURGf+jtBEYaW+y/PpORp+/JKwWwRpywxnggB8C5A1y166+6ZTHmni3MTbeArH0
 dEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841429; x=1736446229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MR9+FRi8VNgioGiOAYUPx+G1pfmyRHcV2/0d37HNVVA=;
 b=v1s2jKVr/TjZNc4b2sZL7kIW4UPRWOmEWG1bJ21gQgQ4jFWfEUKd7BzURttA7jN/6K
 cmehHt2QxZljZ/bgzCX+Xr0MEJN9SnAQKJM7mYqJ7praz2yfUs0d0Njq7GXnLZqJfDK7
 XE0sPcn8UncPXPJRad5nfutHzz9jc33ngnQUlXx4gY37haugC8vrpE9uiQ2uIA10+GMu
 dLRCoIBvKVCGYT2zG0/8FYBIqUF9THXZzEFxXlZTbdvpMSXpDikUEOQrwOGPpBjwzLsa
 cHxn4PclVdPzdOJS2/FY7tZg3GkjDdAy+dh3125QA20gMRlg9O4dafuV77qpyznjT7Sv
 n+eg==
X-Gm-Message-State: AOJu0Yzym/ncBgx0VjluDvvi/KqqBrh+phBConm8rKnMWNuiUvNVquxg
 xwx9WTspALETuVsYlgurDZ4E/TyjsnJAT8L5OLeQSkouv2gmAme8RK7CvOAY2cc9sX3kOWsDbtY
 V
X-Gm-Gg: ASbGnctdkYuiJq+7Rm5UzJE96RucevrVZZAVzYac79OuRmCO5/2NNp0XhhBzP5aasXP
 eZPCziGEY8LvMrbfdwqVNepLyX5I7VfcMaexA+U16m4wrLtIRc4/Tm39tp3kKiuSSPfMUp6okNS
 xOqr9+L3ge/eierT3MfPIc2gotrz2ParD7ADYJl1t6R1+2iSoKAJpvbPRdUP3y6+RnGcTb1Mjnq
 OYDrxukeYQck+XTV+fOZrIoSe2yN/SW/bK6u8KGg7fZqNMPM1sz5s3bDs7X4g==
X-Google-Smtp-Source: AGHT+IEL5qPHZ2sM15C/se88R6Bs1DAAB68wE3q0Of8+hw0XN732Y2CHa1UfDjm5CXinkDvmW9dOqg==
X-Received: by 2002:a05:6a21:78aa:b0:1e4:745c:4965 with SMTP id
 adf61e73a8af0-1e5e1e26dc3mr69494020637.8.1735841429504; 
 Thu, 02 Jan 2025 10:10:29 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/73] tcg: Remove TCG_TARGET_HAS_{s}extract_{i32,i64}
Date: Thu,  2 Jan 2025 10:06:24 -0800
Message-ID: <20250102180654.1420056-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Make extract and sextract "unconditional" in the sense
that the opcodes are always present.  Rely instead on
TCG_TARGET_HAS_{s}extract_valid, now always defined.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  8 ++++----
 tcg/aarch64/tcg-target-has.h     |  4 ----
 tcg/arm/tcg-target-has.h         |  2 --
 tcg/i386/tcg-target-has.h        |  4 ----
 tcg/loongarch64/tcg-target-has.h |  4 ----
 tcg/mips/tcg-target-has.h        |  4 ----
 tcg/ppc/tcg-target-has.h         |  4 ----
 tcg/riscv/tcg-target-has.h       |  4 ----
 tcg/s390x/tcg-target-has.h       |  4 ----
 tcg/sparc64/tcg-target-has.h     |  4 ----
 tcg/tcg-has.h                    | 12 ------------
 tcg/tci/tcg-target-has.h         |  4 ----
 tcg/optimize.c                   |  8 ++++----
 tcg/tcg.c                        | 12 ++++--------
 tcg/tci.c                        |  8 --------
 15 files changed, 12 insertions(+), 74 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index beebba7c52..29ded40bb6 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -77,8 +77,8 @@ DEF(sar_i32, 1, 2, 0, 0)
 DEF(rotl_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I32)))
 DEF(rotr_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I32)))
 DEF(deposit_i32, 1, 2, 2, IMPL(TCG_TARGET_HAS_deposit_i32))
-DEF(extract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_extract_i32))
-DEF(sextract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_sextract_i32))
+DEF(extract_i32, 1, 1, 2, 0)
+DEF(sextract_i32, 1, 1, 2, 0)
 DEF(extract2_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_extract2_i32))
 
 DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
@@ -146,8 +146,8 @@ DEF(sar_i64, 1, 2, 0, IMPL64)
 DEF(rotl_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I64)))
 DEF(rotr_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I64)))
 DEF(deposit_i64, 1, 2, 2, IMPL64 | IMPL(TCG_TARGET_HAS_deposit_i64))
-DEF(extract_i64, 1, 1, 2, IMPL64 | IMPL(TCG_TARGET_HAS_extract_i64))
-DEF(sextract_i64, 1, 1, 2, IMPL64 | IMPL(TCG_TARGET_HAS_sextract_i64))
+DEF(extract_i64, 1, 1, 2, IMPL64)
+DEF(sextract_i64, 1, 1, 2, IMPL64)
 DEF(extract2_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_extract2_i64))
 
 /* size changing ops */
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index d750fccb30..8d3424e4d8 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -41,8 +41,6 @@
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -54,8 +52,6 @@
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     1
 
 /*
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 6990968b06..f06ba539d6 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -52,8 +52,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index c8ad17cf9f..5f90527e4b 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -53,8 +53,6 @@
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
 
 #if TCG_TARGET_REG_BITS == 64
@@ -67,8 +65,6 @@
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 48dc703ad5..45382ecf94 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -34,8 +34,6 @@
 #define TCG_TARGET_HAS_orc(T)           1
 
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
@@ -47,8 +45,6 @@
 
 /* 64-bit operations */
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 2932f99a97..718d71a972 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -71,8 +71,6 @@ extern bool use_mips32r2_instructions;
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
@@ -80,8 +78,6 @@ extern bool use_mips32r2_instructions;
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index b3a9526ee3..bee5b6b588 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -47,8 +47,6 @@
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -61,8 +59,6 @@
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       0
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #endif
 
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 2caec10a18..d27f6ee8e0 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -34,8 +34,6 @@
 #define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
 
 #define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
@@ -46,8 +44,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 075ce5c15c..20d2b90fdd 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -56,8 +56,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext8u_i32      1
 #define TCG_TARGET_HAS_ext16u_i32     1
 #define TCG_TARGET_HAS_deposit_i32    1
-#define TCG_TARGET_HAS_extract_i32    1
-#define TCG_TARGET_HAS_sextract_i32   1
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
@@ -69,8 +67,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext16u_i64     1
 #define TCG_TARGET_HAS_ext32u_i64     1
 #define TCG_TARGET_HAS_deposit_i64    1
-#define TCG_TARGET_HAS_extract_i64    1
-#define TCG_TARGET_HAS_sextract_i64   1
 #define TCG_TARGET_HAS_extract2_i64   0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 0acc5301ca..616744d57a 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -42,8 +42,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext8u_i32        0
 #define TCG_TARGET_HAS_ext16u_i32       0
 #define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -55,8 +53,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index e64ac9768e..b4e5c98041 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -19,8 +19,6 @@
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       0
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
 #endif
 
@@ -30,16 +28,6 @@
 #ifndef TCG_TARGET_deposit_i64_valid
 #define TCG_TARGET_deposit_i64_valid(ofs, len) 1
 #endif
-#ifndef TCG_TARGET_extract_valid
-#define TCG_TARGET_extract_valid(type, ofs, len) \
-    ((type) == TCG_TYPE_I32 ? TCG_TARGET_HAS_extract_i32 \
-     : TCG_TARGET_HAS_extract_i64)
-#endif
-#ifndef TCG_TARGET_sextract_valid
-#define TCG_TARGET_sextract_valid(type, ofs, len) \
-    ((type) == TCG_TYPE_I32 ? TCG_TARGET_HAS_sextract_i32 \
-     : TCG_TARGET_HAS_sextract_i64)
-#endif
 
 /* Only one of DIV or DIV2 should be defined.  */
 #if defined(TCG_TARGET_HAS_div)
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 41eb530d9b..f093547726 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -36,16 +36,12 @@
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
diff --git a/tcg/optimize.c b/tcg/optimize.c
index e427c643b1..6ca64b876a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2365,10 +2365,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         shr_opc = INDEX_op_shr_i32;
         neg_opc = INDEX_op_neg_i32;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
-            uext_opc = TCG_TARGET_HAS_extract_i32 ? INDEX_op_extract_i32 : 0;
+            uext_opc = INDEX_op_extract_i32;
         }
         if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, sh, 1)) {
-            sext_opc = TCG_TARGET_HAS_sextract_i32 ? INDEX_op_sextract_i32 : 0;
+            sext_opc = INDEX_op_sextract_i32;
         }
         break;
     case TCG_TYPE_I64:
@@ -2378,10 +2378,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         shr_opc = INDEX_op_shr_i64;
         neg_opc = INDEX_op_neg_i64;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
-            uext_opc = TCG_TARGET_HAS_extract_i64 ? INDEX_op_extract_i64 : 0;
+            uext_opc = INDEX_op_extract_i64;
         }
         if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, sh, 1)) {
-            sext_opc = TCG_TARGET_HAS_sextract_i64 ? INDEX_op_sextract_i64 : 0;
+            sext_opc = INDEX_op_sextract_i64;
         }
         break;
     default:
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f8f9f7d9f2..4e5dbedd3d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2206,6 +2206,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
+    case INDEX_op_extract_i32:
+    case INDEX_op_sextract_i32:
         return true;
 
     case INDEX_op_negsetcond_i32:
@@ -2224,10 +2226,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_HAS_rot(TCG_TYPE_I32);
     case INDEX_op_deposit_i32:
         return TCG_TARGET_HAS_deposit_i32;
-    case INDEX_op_extract_i32:
-        return TCG_TARGET_HAS_extract_i32;
-    case INDEX_op_sextract_i32:
-        return TCG_TARGET_HAS_sextract_i32;
     case INDEX_op_extract2_i32:
         return TCG_TARGET_HAS_extract2_i32;
     case INDEX_op_add2_i32:
@@ -2303,6 +2301,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sar_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i64:
         return TCG_TARGET_REG_BITS == 64;
 
     case INDEX_op_negsetcond_i64:
@@ -2321,10 +2321,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_rot(TCG_TYPE_I64);
     case INDEX_op_deposit_i64:
         return TCG_TARGET_HAS_deposit_i64;
-    case INDEX_op_extract_i64:
-        return TCG_TARGET_HAS_extract_i64;
-    case INDEX_op_sextract_i64:
-        return TCG_TARGET_HAS_sextract_i64;
     case INDEX_op_extract2_i64:
         return TCG_TARGET_HAS_extract2_i64;
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/tci.c b/tcg/tci.c
index c478988d60..8a02a7fff7 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -639,18 +639,14 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = deposit32(regs[r1], pos, len, regs[r2]);
             break;
 #endif
-#if TCG_TARGET_HAS_extract_i32
         case INDEX_op_extract_i32:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = extract32(regs[r1], pos, len);
             break;
-#endif
-#if TCG_TARGET_HAS_sextract_i32
         case INDEX_op_sextract_i32:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = sextract32(regs[r1], pos, len);
             break;
-#endif
         case INDEX_op_brcond_i32:
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
             if ((uint32_t)regs[r0]) {
@@ -817,18 +813,14 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
             break;
 #endif
-#if TCG_TARGET_HAS_extract_i64
         case INDEX_op_extract_i64:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = extract64(regs[r1], pos, len);
             break;
-#endif
-#if TCG_TARGET_HAS_sextract_i64
         case INDEX_op_sextract_i64:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = sextract64(regs[r1], pos, len);
             break;
-#endif
         case INDEX_op_brcond_i64:
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
             if (regs[r0]) {
-- 
2.43.0


