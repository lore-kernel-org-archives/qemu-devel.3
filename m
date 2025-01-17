Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A985C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr66-0007Yy-CP; Fri, 17 Jan 2025 13:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5p-0006CI-0p
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:17 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5k-0000JI-1X
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:16 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2165448243fso57223615ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138550; x=1737743350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABEAogJ0ZL+pHZwQxZUGpqsMmWqdOXA3SAPSsWYT7XY=;
 b=SsjbOcapY5zITLL4he5+6a0W80D+2el2Esynfp1drL/xiwYTwXJdNoJ/SOiDb/NsZ5
 doTTm8lI1YtIUbbTwoQM2NohU5W1nn6SaXqVnaGjAfwRCO9iXCysfO3/+PPmSK4/lqJS
 1Ezqi2up11DzYyMhMksl4SeyoZWJrKvLj63De6R5nOirWLATeoy9tLGzxSEV8TSUfAbH
 iXXfJ6C3CSGrU4CAJXeNovLzARrKrFCwCmXepsyqNxOGLdXYJ0ge1yGXiYU9KSCb7Hd9
 CecJzoszn0eW/xtDB5I4aTDMeDzmH1E3/sPe+aQi/NTmaawmyAvwVISTFA10OC8+X0zc
 KP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138550; x=1737743350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ABEAogJ0ZL+pHZwQxZUGpqsMmWqdOXA3SAPSsWYT7XY=;
 b=oHbVVdKWLu3a097eKTXG2IZB3eIhtEuQ+4wK9T60SI0GEfUMxrVCHUlqYck56OAPLw
 MZZHCNm9rqrPqRPUecGqgyutT4VB7R7qzhPW0eL6E9E3SyqwTP2GhgRMjmdJLiTsEpQ5
 DDQ0O6hkKR/zklMgJJ9KqEtkR6cAOpruWBXDhTvyuqiDxbH7DmukO6AtOC8g2un0Q7i/
 X6B0YcmXE8Cnu6w2cMIC7HaE6u9cUWIgaTZ+6x7Q61zZg8Lxz6G74WQ3qRtvSmQN5Pgx
 RI+wdxQ06fcBiSuWQ7zokLFiPmDr1kYuwQwOQXmSbe+vPExqviS0Cp/gOWWWG73CERLV
 ApLA==
X-Gm-Message-State: AOJu0Yxk+UoP3tVuZ8HxkLhvKOtyjGugKKeyyYL15Lh/3/IatV2V5q2q
 wBabslUItB9ZCZttgQQdqXM8DKJ+5nEybX67HHKEFeUC6XJPTb7D7hb2S2zeEDh0Mq6qsPfxmIS
 7
X-Gm-Gg: ASbGncvX9+B9gGrF/4OXELB3a8GmegbGTTu+eW53rmx6UvOkfW/XqLrl6g5jPMb75EF
 5oQ805urkv8dx2nFsShqqqKwc8Nk1zsqzUVAoI+8mSrd2hkYdoXAhWWmjz4eZMeDXeMPMnauh5Q
 oY9c9ac5G1OI7tYesqgX690Oz0u9T4whibat0ZaXWDPihbXq8BgAeqhkTtuXMO5ioOA2h8qxE/D
 aCXLWuT6LxuI67FTRCGPfLH+qO9EGC5Jykncsp/hfe22risfzvVeupku41S0riKMgumoxMX1o2H
 1UIazYCvqi73lBw=
X-Google-Smtp-Source: AGHT+IGViRmnl5Xemp8gCEW+ZCuJK34oXjGH0ldIr78glx72nAB+oIbkbpytLV05HsoA03cMmTff4g==
X-Received: by 2002:a17:90a:c883:b0:2ee:f687:6adb with SMTP id
 98e67ed59e1d1-2f782c62722mr4934892a91.3.1737138550024; 
 Fri, 17 Jan 2025 10:29:10 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 61/68] tcg: Remove TCG_TARGET_HAS_{s}extract_{i32,i64}
Date: Fri, 17 Jan 2025 10:24:49 -0800
Message-ID: <20250117182456.2077110-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Make extract and sextract "unconditional" in the sense
that the opcodes are always present.  Rely instead on
TCG_TARGET_HAS_{s}extract_valid, now always defined.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
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
 14 files changed, 8 insertions(+), 70 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 26ce65b6a5..43eaa2287c 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -32,8 +32,6 @@
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -67,8 +65,6 @@
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index d9f3311102..7152dd6f5e 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -41,8 +41,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        1
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index ad69f957a7..833ccc411a 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -44,8 +44,6 @@
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        have_popcnt
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -79,8 +77,6 @@
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        have_popcnt
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index ac7d2fcdf9..a15ab9cc28 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -16,8 +16,6 @@
 #define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
@@ -51,8 +49,6 @@
 #define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index e7914cc970..1bc14f65dd 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -80,8 +80,6 @@ extern bool use_mips32r2_instructions;
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
@@ -96,8 +94,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index d087189a77..fa9275264c 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -38,8 +38,6 @@
 #define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        0
@@ -74,8 +72,6 @@
 #define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index e890546c3a..5a39720ea9 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -16,8 +16,6 @@
 #define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -50,8 +48,6 @@
 #define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 72b57407d4..f3965c7df5 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -47,8 +47,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ctz_i32        0
 #define TCG_TARGET_HAS_ctpop_i32      1
 #define TCG_TARGET_HAS_deposit_i32    1
-#define TCG_TARGET_HAS_extract_i32    1
-#define TCG_TARGET_HAS_sextract_i32   1
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_negsetcond_i32 1
 #define TCG_TARGET_HAS_add2_i32       1
@@ -81,8 +79,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ctz_i64        0
 #define TCG_TARGET_HAS_ctpop_i64      1
 #define TCG_TARGET_HAS_deposit_i64    1
-#define TCG_TARGET_HAS_extract_i64    1
-#define TCG_TARGET_HAS_sextract_i64   1
 #define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_negsetcond_i64 1
 #define TCG_TARGET_HAS_add2_i64       1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index d3ec569592..4a621313b7 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -33,8 +33,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
@@ -68,8 +66,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 8ed35be8c3..c93a98fb86 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -35,8 +35,6 @@
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_add2_i64         0
@@ -56,16 +54,6 @@
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
 #if defined(TCG_TARGET_HAS_div_i32)
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 2f45ad614f..7a176b1fe5 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -17,8 +17,6 @@
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_eqv_i32          1
 #define TCG_TARGET_HAS_nand_i32         1
@@ -41,8 +39,6 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
diff --git a/tcg/optimize.c b/tcg/optimize.c
index cd8ad712c4..8c6303e3af 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2363,10 +2363,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
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
@@ -2376,10 +2376,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
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
index 9b54a8bec8..c584ca034f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2195,6 +2195,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
+    case INDEX_op_extract_i32:
+    case INDEX_op_sextract_i32:
         return true;
 
     case INDEX_op_negsetcond_i32:
@@ -2213,10 +2215,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_rot_i32;
     case INDEX_op_deposit_i32:
         return TCG_TARGET_HAS_deposit_i32;
-    case INDEX_op_extract_i32:
-        return TCG_TARGET_HAS_extract_i32;
-    case INDEX_op_sextract_i32:
-        return TCG_TARGET_HAS_sextract_i32;
     case INDEX_op_extract2_i32:
         return TCG_TARGET_HAS_extract2_i32;
     case INDEX_op_add2_i32:
@@ -2293,6 +2291,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sar_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i64:
         return TCG_TARGET_REG_BITS == 64;
 
     case INDEX_op_negsetcond_i64:
@@ -2311,10 +2311,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_rot_i64;
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
index 39a68db287..30d912d75d 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -657,18 +657,14 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
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
@@ -868,18 +864,14 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
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


