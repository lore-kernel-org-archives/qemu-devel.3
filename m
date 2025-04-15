Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FEFC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lye-0006Zb-UY; Tue, 15 Apr 2025 15:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyI-00051R-Cq
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:26 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly6-0000r6-3k
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:20 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3014678689aso4739524a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745352; x=1745350152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pp8y8rjf74m/t+N6MFnav2QN18CPPqyiHnELy6hFHDg=;
 b=Mk+AMGoDrfEDZJ6QPYnNUZVF9SngrHnsi5Zd6PhnbLR9ZqR39UjABXoTphQL2h4iG7
 0KfRRnSjW4iEU17bAQpDEYS47eXcj81g7gCRJewP++HjrmN27NPztL3jyPjwuAzFWh/Z
 UX+ivGjh6PWJpFUeYbYiX8oPNVF6I6XNnch/3VhvdW1NHLbY+9r2145c56isuvDQzWOr
 bW0YRCEElud8AhGusCHXH0CNt4E3gp3dNBFjha8b8ZPPDB+3vFKP5XbbXC+MbVhPHTSw
 PlPP2V2D0Dw/5ELgA6YRnW1mNOaNo/Ux6ARQeviTJfIuefw/lbLQRvnvkUlrKWcx4vIh
 qrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745352; x=1745350152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pp8y8rjf74m/t+N6MFnav2QN18CPPqyiHnELy6hFHDg=;
 b=McxC+Y8jzC2+XpTFQXsDVuK5n3B4ncKfMCeGuOtuj34K6z8ksonOPxqCID8NGSlC/A
 o6M1k/8RO2SxXd6dV8rkg/6XLhzm7KW40BZCdB0LHGrBo5cyY7O7GUsSy/HzSU5fYtn1
 Y599fvRbCrB9wccQitK/S96LksZb2nm9FLsZIYH5uNAifIuEIcaEhlwj9Q2hPPn+z3Fx
 3DSd74w50bOk7LCG+LqdTjmfu2PREtQ2rv9ssyeU27r1ZxxZx+zkqUebSCiwKZHLDwe2
 h2XgIWgXrL+Pp3sxDDpYp5a/lIDuuvOuvKb8a78f2K4HjNjZSduhkI0Pkn0GqdGuFuXe
 cr7A==
X-Gm-Message-State: AOJu0YxN0H/HbwLI/UvSqh9243pbgMLGosxJFs8xbWUndeK7/Ta00Q3R
 gD3q6Gm10/yOp4R6g9cCbPRrrn43pqwB78qbIzJOSEEOwS8n1TPITwainZYVBEKea0woyueuOGF
 M
X-Gm-Gg: ASbGncuzqfOEP9bIlodyN+TqSd4wC6/QgLx2OF7GuKX/ChnoSNXSWulNj6x1qcVKDf/
 3Uk4FJJTClxP9kOjPsFN9AEMIYlYwFdfG03BTY3Ar4l8SmcyWdFhz0LrlXOQasx5f7PN+HQoS1x
 ZZ+ZKneEJ0ev4QRVb9kj0Z+0GUd/lZSttb48n/ts/e69ol5RsZ/tbJrm+5VTA0fm7mG3X2lYnCY
 CNM/JASpx9CiqMEn0uQdwvIWXj1NoPa9NSumlN2aUg79v95ICmnCVCvSy/yp4oi3VVZdzEP8B9C
 9qn59Cf7bt/dHgFPeU9+xwR0wcvkVn8cHY9rxKMOMVTFrnqaSEYUmHYCbzYQX45MJXf4lmJq2QO
 Z9cY6IH86lQ==
X-Google-Smtp-Source: AGHT+IGLGMUgJRDpRVroGDcsa8uVRCKVU99x+CGTKx301u6tHyJNYD13n7gQcz2++yLjk+6zU3C8Wg==
X-Received: by 2002:a17:90b:2811:b0:308:2b5b:d67f with SMTP id
 98e67ed59e1d1-3085eec352cmr519025a91.9.1744745351684; 
 Tue, 15 Apr 2025 12:29:11 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 064/163] tcg: Convert ctz to TCGOutOpBinary
Date: Tue, 15 Apr 2025 12:23:35 -0700
Message-ID: <20250415192515.232910-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
 tcg/tcg-op.c                     |  9 ++---
 tcg/tcg.c                        |  8 ++---
 tcg/tci.c                        |  8 ++---
 tcg/aarch64/tcg-target.c.inc     | 34 ++++++++++--------
 tcg/arm/tcg-target.c.inc         | 39 ++++++++++++++-------
 tcg/i386/tcg-target.c.inc        | 60 +++++++++++++++++++-------------
 tcg/loongarch64/tcg-target.c.inc | 60 ++++++++++++++------------------
 tcg/mips/tcg-target.c.inc        |  4 +++
 tcg/ppc/tcg-target.c.inc         | 39 ++++++++++++++-------
 tcg/riscv/tcg-target.c.inc       | 32 +++++++++++------
 tcg/s390x/tcg-target.c.inc       |  4 +++
 tcg/sparc64/tcg-target.c.inc     |  4 +++
 tcg/tci/tcg-target-opc.h.inc     |  1 +
 tcg/tci/tcg-target.c.inc         | 20 +++++++----
 25 files changed, 193 insertions(+), 149 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 8c839d8949..478d59676e 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -15,7 +15,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
@@ -29,7 +28,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_negsetcond_i64   1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index fceec2f0ca..1485a52c21 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -26,7 +26,6 @@ extern bool use_neon_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 2277872ff3..b8a0a5c619 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -28,7 +28,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        have_popcnt
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
@@ -43,7 +42,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        have_popcnt
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_negsetcond_i64   1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 2eba2132b8..f87d05efc6 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -18,7 +18,6 @@
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -29,7 +28,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index c27ca7e543..ca33c9b745 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -60,7 +60,6 @@ extern bool use_mips32r2_instructions;
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -69,7 +68,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
 #endif
 
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index cd7346011b..2b381b99a2 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -19,7 +19,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
@@ -34,7 +33,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 41e287130d..385a6736c0 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -18,7 +18,6 @@
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -28,7 +27,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 85a4f23e95..0794394fea 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -31,7 +31,6 @@ extern uint64_t s390_facilities[3];
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
-#define TCG_TARGET_HAS_ctz_i32        0
 #define TCG_TARGET_HAS_ctpop_i32      1
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_negsetcond_i32 1
@@ -45,7 +44,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i64    1
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
-#define TCG_TARGET_HAS_ctz_i64        0
 #define TCG_TARGET_HAS_ctpop_i64      1
 #define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_negsetcond_i64 1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 21fa0f3663..56262640ff 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -16,7 +16,6 @@ extern bool use_vis3_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
-#define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
@@ -30,7 +29,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 27d6ec7636..6bba845944 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -15,7 +15,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index ae1f724702..daa6db4799 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -10,7 +10,6 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
@@ -22,7 +21,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_muls2_i64        1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 76e9efc655..b117a59f05 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -750,11 +750,11 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i32 z, t;
 
-    if (TCG_TARGET_HAS_ctz_i32) {
+    if (tcg_op_supported(INDEX_op_ctz_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_ctz_i32, ret, arg1, arg2);
         return;
     }
-    if (TCG_TARGET_HAS_ctz_i64) {
+    if (tcg_op_supported(INDEX_op_ctz_i64, TCG_TYPE_I64, 0)) {
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t1, arg1);
@@ -788,7 +788,8 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
-    if (!TCG_TARGET_HAS_ctz_i32 && TCG_TARGET_HAS_ctpop_i32 && arg2 == 32) {
+    if (!tcg_op_supported(INDEX_op_ctz_i32, TCG_TYPE_I32, 0)
+        && TCG_TARGET_HAS_ctpop_i32 && arg2 == 32) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_subi_i32(t, arg1, 1);
@@ -2365,7 +2366,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     TCGv_i64 z, t;
 
-    if (TCG_TARGET_HAS_ctz_i64) {
+    if (tcg_op_supported(INDEX_op_ctz_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_ctz_i64, ret, arg1, arg2);
         return;
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 97bdb6241a..5b939c6a33 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1027,6 +1027,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
+    OUTOP(INDEX_op_ctz_i32, TCGOutOpBinary, outop_ctz),
+    OUTOP(INDEX_op_ctz_i64, TCGOutOpBinary, outop_ctz),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
@@ -2289,8 +2291,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap16_i32;
     case INDEX_op_bswap32_i32:
         return TCG_TARGET_HAS_bswap32_i32;
-    case INDEX_op_ctz_i32:
-        return TCG_TARGET_HAS_ctz_i32;
     case INDEX_op_ctpop_i32:
         return TCG_TARGET_HAS_ctpop_i32;
 
@@ -2332,8 +2332,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap32_i64;
     case INDEX_op_bswap64_i64:
         return TCG_TARGET_HAS_bswap64_i64;
-    case INDEX_op_ctz_i64:
-        return TCG_TARGET_HAS_ctz_i64;
     case INDEX_op_ctpop_i64:
         return TCG_TARGET_HAS_ctpop_i64;
     case INDEX_op_add2_i64:
@@ -5399,6 +5397,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_clz:
+    case INDEX_op_ctz_i32:
+    case INDEX_op_ctz_i64:
     case INDEX_op_divs:
     case INDEX_op_divu:
     case INDEX_op_eqv:
diff --git a/tcg/tci.c b/tcg/tci.c
index 7c2f2a524b..b505944b10 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -599,13 +599,11 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tmp32 = regs[r1];
             regs[r0] = tmp32 ? clz32(tmp32) : regs[r2];
             break;
-#if TCG_TARGET_HAS_ctz_i32
-        case INDEX_op_ctz_i32:
+        case INDEX_op_tci_ctz32:
             tci_args_rrr(insn, &r0, &r1, &r2);
             tmp32 = regs[r1];
             regs[r0] = tmp32 ? ctz32(tmp32) : regs[r2];
             break;
-#endif
 #if TCG_TARGET_HAS_ctpop_i32
         case INDEX_op_ctpop_i32:
             tci_args_rr(insn, &r0, &r1);
@@ -737,12 +735,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
             break;
-#if TCG_TARGET_HAS_ctz_i64
         case INDEX_op_ctz_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
             break;
-#endif
 #if TCG_TARGET_HAS_ctpop_i64
         case INDEX_op_ctpop_i64:
             tci_args_rr(insn, &r0, &r1);
@@ -1070,8 +1066,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
+    case INDEX_op_tci_ctz32:
     case INDEX_op_tci_clz32:
     case INDEX_op_tci_divs32:
     case INDEX_op_tci_divu32:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 3bd8231117..8441c5f4bf 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2129,6 +2129,26 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static void tgen_ctz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3507, RBIT, type, TCG_REG_TMP0, a1);
+    tgen_clz(s, type, a0, TCG_REG_TMP0, a2);
+}
+
+static void tgen_ctzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_insn(s, 3507, RBIT, type, TCG_REG_TMP0, a1);
+    tgen_clzi(s, type, a0, TCG_REG_TMP0, a2);
+}
+
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_O1_I2(r, r, rAL),
+    .out_rrr = tgen_ctz,
+    .out_rri = tgen_ctzi,
+};
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2468,16 +2488,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_ctz_i64:
-    case INDEX_op_ctz_i32:
-        tcg_out_insn(s, 3507, RBIT, ext, TCG_REG_TMP0, a1);
-        if (c2) {
-            tgen_clzi(s, ext, a0, TCG_REG_TMP0, a2);
-        } else {
-            tgen_clz(s, ext, a0, TCG_REG_TMP0, a2);
-        }
-        break;
-
     case INDEX_op_brcond_i32:
         a1 = (int32_t)a1;
         /* FALLTHRU */
@@ -3098,10 +3108,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
-        return C_O1_I2(r, r, rAL);
-
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         return C_O0_I2(r, rC);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 681eb5aba1..c05f21c82c 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1888,6 +1888,32 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static void tgen_ctz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, INSN_RBIT, TCG_REG_TMP, 0, a1, 0);
+    tgen_clz(s, TCG_TYPE_I32, a0, TCG_REG_TMP, a2);
+}
+
+static void tgen_ctzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_reg(s, COND_AL, INSN_RBIT, TCG_REG_TMP, 0, a1, 0);
+    tgen_clzi(s, TCG_TYPE_I32, a0, TCG_REG_TMP, a2);
+}
+
+static TCGConstraintSetIndex cset_ctz(TCGType type, unsigned flags)
+{
+    return use_armv7_instructions ? C_O1_I2(r, r, rIK) : C_NotImplemented;
+}
+
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctz,
+    .out_rrr = tgen_ctz,
+    .out_rri = tgen_ctzi,
+};
+
 static TCGConstraintSetIndex cset_idiv(TCGType type, unsigned flags)
 {
     return use_idiv_instructions ? C_O1_I2(r, r, r) : C_NotImplemented;
@@ -2220,15 +2246,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_smull32(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
 
-    case INDEX_op_ctz_i32:
-        tcg_out_dat_reg(s, COND_AL, INSN_RBIT, TCG_REG_TMP, 0, args[1], 0);
-        if (const_args[2]) {
-            tgen_clzi(s, TCG_TYPE_I32, args[0], TCG_REG_TMP, args[2]);
-        } else {
-            tgen_clz(s, TCG_TYPE_I32, args[0], TCG_REG_TMP, args[2]);
-        }
-        break;
-
     case INDEX_op_brcond_i32:
         c = tcg_out_cmp(s, args[2], args[0], args[1], const_args[1]);
         tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[3]));
@@ -2351,10 +2368,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
 
-    case INDEX_op_clz_i32:
-    case INDEX_op_ctz_i32:
-        return C_O1_I2(r, r, rIK);
-
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0edd4cbc07..f7d0b93af0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1851,24 +1851,6 @@ static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
     tcg_out_cmov(s, jcc, rexw, dest, v1);
 }
 
-static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
-                        TCGArg arg2, bool const_a2)
-{
-    if (have_bmi1) {
-        tcg_out_modrm(s, OPC_TZCNT + rexw, dest, arg1);
-        if (const_a2) {
-            tcg_debug_assert(arg2 == (rexw ? 64 : 32));
-        } else {
-            tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
-        }
-    } else {
-        tcg_debug_assert(dest != arg2);
-        tcg_out_modrm(s, OPC_BSF + rexw, dest, arg1);
-        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
-    }
-}
-
 static void tcg_out_branch(TCGContext *s, int call, const tcg_insn_unit *dest)
 {
     intptr_t disp = tcg_pcrel_diff(s, dest) - 5;
@@ -2646,6 +2628,41 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static void tgen_ctz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    int jcc;
+
+    if (have_bmi1) {
+        tcg_out_modrm(s, OPC_TZCNT + rexw, a0, a1);
+        jcc = JCC_JB;
+    } else {
+        tcg_out_modrm(s, OPC_BSF + rexw, a0, a1);
+        jcc = JCC_JE;
+    }
+    tcg_out_cmov(s, jcc, rexw, a0, a2);
+}
+
+static void tgen_ctzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_TZCNT + rexw, a0, a1);
+}
+
+static TCGConstraintSetIndex cset_ctz(TCGType type, unsigned flags)
+{
+    return have_bmi1 ? C_N1_I2(r, r, rW) : C_N1_I2(r, r, r);
+}
+
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctz,
+    .out_rrr = tgen_ctz,
+    .out_rri = tgen_ctzi,
+};
+
 static const TCGOutOpBinary outop_divs = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -3029,9 +3046,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(ctz):
-        tcg_out_ctz(s, rexw, args[0], args[1], args[2], const_args[2]);
-        break;
     OP_32_64(ctpop):
         tcg_out_modrm(s, OPC_POPCNT + rexw, a0, a1);
         break;
@@ -3913,10 +3927,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub2_i64:
         return C_N1_O1_I4(r, r, 0, 1, re, re);
 
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
-        return have_bmi1 ? C_N1_I2(r, r, rW) : C_N1_I2(r, r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, L);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 338e0b351a..ea0a92ece9 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -534,28 +534,6 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg ret, TCGReg arg)
     tcg_out_ext32s(s, ret, arg);
 }
 
-static void tcg_out_clzctz(TCGContext *s, LoongArchInsn opc,
-                           TCGReg a0, TCGReg a1, TCGReg a2,
-                           bool c2, bool is_32bit)
-{
-    if (c2) {
-        /*
-         * Fast path: semantics already satisfied due to constraint and
-         * insn behavior, single instruction is enough.
-         */
-        tcg_debug_assert(a2 == (is_32bit ? 32 : 64));
-        /* all clz/ctz insns belong to DJ-format */
-        tcg_out32(s, encode_dj_insn(opc, a0, a1));
-        return;
-    }
-
-    tcg_out32(s, encode_dj_insn(opc, TCG_REG_TMP0, a1));
-    /* a0 = a1 ? REG_TMP0 : a2 */
-    tcg_out_opc_maskeqz(s, TCG_REG_TMP0, TCG_REG_TMP0, a1);
-    tcg_out_opc_masknez(s, a0, a2, a1);
-    tcg_out_opc_or(s, a0, TCG_REG_TMP0, a0);
-}
-
 #define SETCOND_INV    TCG_TARGET_NB_REGS
 #define SETCOND_NEZ    (SETCOND_INV << 1)
 #define SETCOND_FLAGS  (SETCOND_INV | SETCOND_NEZ)
@@ -1343,6 +1321,33 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static void tgen_ctzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    /* a2 is constrained to exactly the type width. */
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_ctz_w(s, a0, a1);
+    } else {
+        tcg_out_opc_ctz_d(s, a0, a1);
+    }
+}
+
+static void tgen_ctz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tgen_ctzi(s, type, TCG_REG_TMP0, a1, /* ignored */ 0);
+    /* a0 = a1 ? REG_TMP0 : a2 */
+    tcg_out_opc_maskeqz(s, TCG_REG_TMP0, TCG_REG_TMP0, a1);
+    tcg_out_opc_masknez(s, a0, a2, a1);
+    tcg_out_opc_or(s, a0, a0, TCG_REG_TMP0);
+}
+
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_O1_I2(r, r, rW),
+    .out_rrr = tgen_ctz,
+    .out_rri = tgen_ctzi,
+};
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1769,13 +1774,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_revb_d(s, a0, a1);
         break;
 
-    case INDEX_op_ctz_i32:
-        tcg_out_clzctz(s, OPC_CTZ_W, a0, a1, a2, c2, true);
-        break;
-    case INDEX_op_ctz_i64:
-        tcg_out_clzctz(s, OPC_CTZ_D, a0, a1, a2, c2, false);
-        break;
-
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
         tcg_out_setcond(s, args[3], a0, a1, a2, c2);
@@ -2412,10 +2410,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
-        return C_O1_I2(r, r, rW);
-
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         /* Must deposit into the same register as input */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 5052d6481c..e8720b63ed 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1734,6 +1734,10 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 518cf1e9ef..2cdabcf610 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2974,6 +2974,32 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static void tgen_ctz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? CNTTZW : CNTTZD;
+    tcg_out_cntxz(s, type, insn, a0, a1, a2, false);
+}
+
+static void tgen_ctzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? CNTTZW : CNTTZD;
+    tcg_out_cntxz(s, type, insn, a0, a1, a2, true);
+}
+
+static TCGConstraintSetIndex cset_ctz(TCGType type, unsigned flags)
+{
+    return have_isa_3_00 ? C_O1_I2(r, r, rZW) : C_NotImplemented;
+}
+
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctz,
+    .out_rrr = tgen_ctz,
+    .out_rri = tgen_ctzi,
+};
+
 static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3370,18 +3396,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_ctz_i32:
-        tcg_out_cntxz(s, TCG_TYPE_I32, CNTTZW, args[0], args[1],
-                      args[2], const_args[2]);
-        break;
     case INDEX_op_ctpop_i32:
         tcg_out32(s, CNTPOPW | SAB(args[1], args[0], 0));
         break;
-
-    case INDEX_op_ctz_i64:
-        tcg_out_cntxz(s, TCG_TYPE_I64, CNTTZD, args[0], args[1],
-                      args[2], const_args[2]);
-        break;
     case INDEX_op_ctpop_i64:
         tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
         break;
@@ -4240,10 +4257,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
-        return C_O1_I2(r, r, rZW);
-
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         return C_O0_I2(r, rC);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 77eef02db5..1ceb1aeb1c 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2023,6 +2023,27 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static void tgen_ctz(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_CTZW : OPC_CTZ;
+    tcg_out_cltz(s, type, insn, a0, a1, a2, false);
+}
+
+static void tgen_ctzi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_CTZW : OPC_CTZ;
+    tcg_out_cltz(s, type, insn, a0, a1, a2, true);
+}
+
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_clzctz,
+    .out_rrr = tgen_ctz,
+    .out_rri = tgen_ctzi,
+};
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2424,13 +2445,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_imm(s, OPC_CPOP, a0, a1, 0);
         break;
 
-    case INDEX_op_ctz_i32:
-        tcg_out_cltz(s, TCG_TYPE_I32, OPC_CTZW, a0, a1, a2, c2);
-        break;
-    case INDEX_op_ctz_i64:
-        tcg_out_cltz(s, TCG_TYPE_I64, OPC_CTZ, a0, a1, a2, c2);
-        break;
-
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
                         const_args[4], const_args[5], false, true);
@@ -2813,10 +2827,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
-        return C_N1_I2(r, r, rM);
-
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         return C_O0_I2(rz, rz);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index adfe403bef..374136ed14 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2268,6 +2268,10 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const TCGOutOpBinary outop_divs = {
     .base.static_constraint = C_NotImplemented,
 };
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index a4fb41764b..a9257b8b93 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1322,6 +1322,10 @@ static const TCGOutOpBinary outop_clz = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divs_rJ(TCGContext *s, TCGType type,
                          TCGReg a0, TCGReg a1, TCGArg a2, bool c2)
 {
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 04774ca9c4..2bb346f4c8 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -3,6 +3,7 @@
 DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_clz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_ctz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 0fd1f5510a..47bdec5f44 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -83,8 +83,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i64:
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
         return C_O1_I2(r, r, r);
 
     case INDEX_op_brcond_i32:
@@ -642,6 +640,20 @@ static const TCGOutOpBinary outop_clz = {
     .out_rrr = tgen_clz,
 };
 
+static void tgen_ctz(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_ctz32
+                     : INDEX_op_ctz_i64);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_ctz,
+};
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -933,10 +945,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(ctz)      /* Optional (TCG_TARGET_HAS_ctz_*). */
-        tcg_out_op_rrr(s, opc, args[0], args[1], args[2]);
-        break;
-
     CASE_32_64(deposit)
         tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
         break;
-- 
2.43.0


