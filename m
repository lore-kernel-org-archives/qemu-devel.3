Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D783AE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4as-00019L-9o; Tue, 07 Jan 2025 03:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aQ-0000ML-H7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:19 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aJ-0003Mz-EY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:13 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f13acbe29bso19710725a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237105; x=1736841905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROGyz5ggk1w0GerjpQhF6MhIhqE+rv58yIx3X1Kmqs4=;
 b=F9aQEFlmSGqBWbJ0mDJU4haBxPdPdqLZ690n3CQJyzyUJuHIdmQR9jWgzswjcpKMc2
 8LTtb7iFtypH49KoXr/zMxmi0vclFo8ZSnwBhsQ+lknbtxnjjpAFmHHdZ+A+aRkR9iAt
 tLQc1aectYY+SuVAkTiWxT6KvC7rIuCB7gXBNxMS0CrZ6Kwy/VEON1HZyIBt4ev1Vw8P
 2sKnX3MzvO5Yo5UYIsPkC0WIgpX5OP+SRWxIA3I+n+URYmy4q/iNMCnMjisggoALr40C
 9mACIfcN2lR6hU1zc72J+nclGoG1nZOc0Bo8r0Ks2eY+Zxv6QLbVGXM2u5gH8L3tHDtJ
 qDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237105; x=1736841905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROGyz5ggk1w0GerjpQhF6MhIhqE+rv58yIx3X1Kmqs4=;
 b=m3OCnByQ39ePDUcVP1VCfPazQqba364kqEGQ2aJyiJdP/K8leLDLVVErRWDOQhJ+zO
 60gO+xJlCoQio58ogCbWhQ0X3lyMmlKOrcDOOiqtQ90d13ygKYLC/6fyJUUOpebNAxpQ
 Gtm2uqljU6mrup1lK/dIGdqIUT8Ex3Ic6UDD5xSxq9AMIZdN08PQ9C3jqmaZg1eIuv2e
 cSkIgPP4ZTwX3H+XN4gLIEt6gS1bzBqechFIatKIhU6V7quyfseX/woR8/Hc+fjo4Bsq
 nAB3dXPcN/QdycBG5U4lBOPWoD+9oGfoWmpu1vZdigBUtpa1YEtAYqcC/VT1CcvS9GfC
 fOhg==
X-Gm-Message-State: AOJu0YyKQOjGTT8kuXn1xKvaE0SHXut7H2mawceCNZIFbaeRn4887777
 oZ0cEIMYDhtlEYKATkB/qUfuH0wz1XG6OLKIdODKWuhAobl55CP3MtkN3L/LqM8mN/5qR7sQumd
 5
X-Gm-Gg: ASbGncvx+yy2bGs3URxaugX7aBw4f+qC9hWxfTBgHI9r+Xl/MhI2ksHX2PsUe1J/Foy
 ldymwU9P361KqJRThpuW5eQ2YVXzFn60bnVvkCbDB6wwhixD5etgNfSuS2frOTQaY7hUN7DRjSA
 3L41bSq6cKMBlduQKm2aO5zpaAZ0jSazlUCCu6hXaeOUnMACuTwK6j5l3O0M3e5b2byr8dlGyR4
 qL6JZ0MG+Xai2cHZUgV1K9gDiQonBixa+wFNsyqitJhzDN9thi1MA5TKFwd65Lhs62D1z64RSOn
 u+LlTw6aRvRgUNohmQ==
X-Google-Smtp-Source: AGHT+IFIFxZi1bD+ByFmxFWGSf5xBUgMd/Cf8+GqDUURMURJNTBnzsHR2S3a8ri5B4EbG6W2n1WWzw==
X-Received: by 2002:a05:6a00:1148:b0:727:39a4:30cc with SMTP id
 d2e1a72fcca58-72d1036b1c8mr3898516b3a.1.1736237105123; 
 Tue, 07 Jan 2025 00:05:05 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 47/81] tcg: Remove TCG_TARGET_HAS_{s}extract_{i32,i64}
Date: Tue,  7 Jan 2025 00:00:38 -0800
Message-ID: <20250107080112.1175095-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
index d6ca35ed1a..7152dd6f5e 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -41,8 +41,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
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
index 2db461efed..4a621313b7 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -33,8 +33,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
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
index 350ab5948e..76aefda514 100644
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


