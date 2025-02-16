Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F3CC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnub-0004wM-5c; Sun, 16 Feb 2025 18:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt8-00025x-IZ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:27 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt4-00060c-4M
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:26 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220d28c215eso52316845ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747839; x=1740352639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xsp4/C5RkZ/ThFcpy9cvrvmUu+nzaN3i791Tv21FXhk=;
 b=FvSnPSvwM9s7rKeGfQPCnTd+RtkWN+P0R+Gf43oCtWsqUhrKyaGhaS6bUEpL/yrp0M
 ysgiuwjwxFCEKajAT8Mawm3wtVB5BgNJ9EIgew6Vhu4fdlMgN4tvBSXia8k7Z+C+P3f+
 l570txuD+SyvRqdt8U90swD5WUnZ2A030ZfZ417LZ75Yuq7cXiCEu8lSRIJa5D4SXmmy
 YHSUd002LVkcPbvasM/x0Tht0qgM0GTdycOQoAMgE3A0GyQdFsA1bodJC88hUXtRD+LV
 u+W5chE3mnM0Mt4GCBPtZOqy2uo8BjaHWxeig/bnrW/fhzrUJqAG26DwJaCM3lITn8IM
 o4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747839; x=1740352639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xsp4/C5RkZ/ThFcpy9cvrvmUu+nzaN3i791Tv21FXhk=;
 b=oBiOKi6mjRPr8haPd0P2ekmLrFsYV+vWCQMGQKZ/SJpRWg+WlaUm2kmbbMcFiwsmWc
 f+tw5r/aFv9IhQUjEXC8kz2RxVUlZWFLwur8XJWZV6vMN8MzIvljDAqdhdNR4icJo9XQ
 g0pSNK7m2Regc8HyPEtN91OBdJuXNBFQOiKHOfXMjl/L2mf6jLXOPrzAGXaCtEZCvyqY
 FzSUhzmHpMEuiyvt3FhivplzOja400KjI0L0HyjN+cEoTIGUYNv/fb01PC1deuYzPY0R
 VPwbTGcCUSUlQtKb12zzEGxlVhpRYZp1fTKZbjphbk77xi4FeKehTKJ4U9cxmxKYyHRY
 iIFg==
X-Gm-Message-State: AOJu0YxYe+ZERgg4WAbvMAKjkZWazSXN+IHpwH2fRcTUcgAcVrs26GBu
 zWX6J9sUIu4xNDBC66rNP7Kib2kxkCv/kV7sgtgd+L/BeQDN2LIbAZwESs7ROYzoSuu1WJ6MSn4
 Q
X-Gm-Gg: ASbGncsI6WKRFK3tdn3ps5/A3GqONR1SeELsy+9NLwLjJgz01SwsUj/VOuCZzeoLFkj
 VLZscZJ4ROca/65wPP9+B1wVkCML3J4e+NxvnTP+EwKC0dAQ7bZXCRYbw5ddvsIav4VM6xJm98F
 jCqXNlMSXp5JTLWwo+aWbVMbT0mj2BeDwHJcGatzQuKtdw4/y+nbUv+ayt5MTUjTYW7OupkC8wm
 jWDk7daiULAVlHtt7i7sIGLoI1rZqs04NHlWmAmcn2pi2hx9JgFTrNqXX7BdNl8uWUIy24GDePW
 J6RdHqVL14BbW7mi8RyoOVMz5ldCLVO1UI8f1sYFKcCfrMU=
X-Google-Smtp-Source: AGHT+IG91v4ckVk0y9p1U/Wj6526jJn3+WvuCqPnhyoR0TMGaR7Wc1IdWfboFXlYN01xiXRFFZoI0Q==
X-Received: by 2002:a17:903:8c5:b0:220:c63b:d945 with SMTP id
 d9443c01a7336-22104030d60mr115475525ad.14.1739747839267; 
 Sun, 16 Feb 2025 15:17:19 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 088/162] tcg: Convert bswap32 to TCGOutOpBswap
Date: Sun, 16 Feb 2025 15:08:57 -0800
Message-ID: <20250216231012.2808572-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h     |  2 -
 tcg/arm/tcg-target-has.h         |  1 -
 tcg/i386/tcg-target-has.h        |  2 -
 tcg/loongarch64/tcg-target-has.h |  2 -
 tcg/mips/tcg-target-has.h        |  2 -
 tcg/ppc/tcg-target-has.h         |  2 -
 tcg/riscv/tcg-target-has.h       |  2 -
 tcg/s390x/tcg-target-has.h       |  2 -
 tcg/sparc64/tcg-target-has.h     |  2 -
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 -
 tcg/tcg-op.c                     |  4 +-
 tcg/tcg.c                        |  8 +--
 tcg/tci.c                        |  2 -
 tcg/aarch64/tcg-target.c.inc     | 25 +++++-----
 tcg/arm/tcg-target.c.inc         | 23 ++++-----
 tcg/i386/tcg-target.c.inc        | 23 +++++----
 tcg/loongarch64/tcg-target.c.inc | 33 +++++++------
 tcg/mips/tcg-target.c.inc        | 54 ++++++++++----------
 tcg/ppc/tcg-target.c.inc         | 84 ++++++++++++++++----------------
 tcg/riscv/tcg-target.c.inc       | 30 +++++++-----
 tcg/s390x/tcg-target.c.inc       | 31 ++++++------
 tcg/sparc64/tcg-target.c.inc     |  4 ++
 tcg/tci/tcg-target.c.inc         | 28 +++++------
 24 files changed, 182 insertions(+), 187 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 4797409467..7c3d3fc637 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -13,14 +13,12 @@
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 5972def558..c85b5da1e5 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,7 +24,6 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index fd44ed8168..ca533ab5cf 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,7 +26,6 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -34,7 +33,6 @@
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 11a93afd8b..e66df31954 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -13,13 +13,11 @@
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 6c967d9c9f..2391f5d8bf 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -39,7 +39,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap32_i32      1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
@@ -56,7 +55,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #endif
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index b73fca9789..ad0885d635 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -17,7 +17,6 @@
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -25,7 +24,6 @@
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 85bb5cd591..fbe294474a 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -13,12 +13,10 @@
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 6cd92fa240..76cfe4f323 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -29,14 +29,12 @@ extern uint64_t s390_facilities[3];
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_add2_i32       1
 #define TCG_TARGET_HAS_sub2_i32       1
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
-#define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_add2_i64       1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index eb1e16c0e2..22837beca9 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,14 +14,12 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 3d1c805d59..4034c73cca 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -12,7 +12,6 @@
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_add2_i64         0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index d7228246ab..c5c64f4f5d 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -7,13 +7,11 @@
 #ifndef TCG_TARGET_HAS_H
 #define TCG_TARGET_HAS_H
 
-#define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_add2_i32         1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 917f52b04a..68e53a9c85 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1294,7 +1294,7 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
  */
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_bswap32_i32) {
+    if (tcg_op_supported(INDEX_op_bswap32_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3i_i32(INDEX_op_bswap32_i32, ret, arg, 0);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2137,7 +2137,7 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         } else {
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         }
-    } else if (TCG_TARGET_HAS_bswap32_i64) {
+    } else if (tcg_op_supported(INDEX_op_bswap32_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3i_i64(INDEX_op_bswap32_i64, ret, arg, flags);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 26ac33edb3..1ab6c0f99c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1076,6 +1076,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_brcond, TCGOutOpBrcond, outop_brcond),
     OUTOP(INDEX_op_bswap16, TCGOutOpBswap, outop_bswap16),
+    OUTOP(INDEX_op_bswap32_i32, TCGOutOpBswap, outop_bswap32),
+    OUTOP(INDEX_op_bswap32_i64, TCGOutOpBswap, outop_bswap32),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
@@ -2342,8 +2344,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_add2_i32;
     case INDEX_op_sub2_i32:
         return TCG_TARGET_HAS_sub2_i32;
-    case INDEX_op_bswap32_i32:
-        return TCG_TARGET_HAS_bswap32_i32;
 
     case INDEX_op_brcond2_i32:
     case INDEX_op_setcond2_i32:
@@ -2372,8 +2372,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return TCG_TARGET_HAS_extr_i64_i32;
-    case INDEX_op_bswap32_i64:
-        return TCG_TARGET_HAS_bswap32_i64;
     case INDEX_op_bswap64_i64:
         return TCG_TARGET_HAS_bswap64_i64;
     case INDEX_op_add2_i64:
@@ -5476,6 +5474,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_bswap16:
+    case INDEX_op_bswap32_i32:
+    case INDEX_op_bswap32_i64:
         {
             const TCGOutOpBswap *out =
                 container_of(all_outop[op->opc], TCGOutOpBswap, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 905ca154fc..0cb89f3256 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -690,12 +690,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap16(regs[r1]);
             break;
-#if TCG_TARGET_HAS_bswap32_i32 || TCG_TARGET_HAS_bswap32_i64
         CASE_32_64(bswap32)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap32(regs[r1]);
             break;
-#endif
 #if TCG_TARGET_REG_BITS == 64
             /* Load/store operations (64 bit). */
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 03961b34aa..a2e45ca5c8 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2456,6 +2456,20 @@ static const TCGOutOpBswap outop_bswap16 = {
     .out_rr = tgen_bswap16,
 };
 
+static void tgen_bswap32(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_rev(s, TCG_TYPE_I32, MO_32, a0, a1);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_ext32s(s, a0, a0);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap32,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_XZR, a1);
@@ -2626,15 +2640,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     case INDEX_op_bswap64_i64:
         tcg_out_rev(s, TCG_TYPE_I64, MO_64, a0, a1);
         break;
-    case INDEX_op_bswap32_i64:
-        tcg_out_rev(s, TCG_TYPE_I32, MO_32, a0, a1);
-        if (a2 & TCG_BSWAP_OS) {
-            tcg_out_ext32s(s, a0, a0);
-        }
-        break;
-    case INDEX_op_bswap32_i32:
-        tcg_out_rev(s, TCG_TYPE_I32, MO_32, a0, a1);
-        break;
 
     case INDEX_op_deposit_i64:
     case INDEX_op_deposit_i32:
@@ -3154,8 +3159,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 65ddedb166..c0520fb774 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -975,12 +975,6 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rn)
     g_assert_not_reached();
 }
 
-static void tcg_out_bswap32(TCGContext *s, ARMCond cond, TCGReg rd, TCGReg rn)
-{
-    /* rev */
-    tcg_out32(s, 0x06bf0f30 | (cond << 28) | (rd << 12) | rn);
-}
-
 static void tcg_out_deposit(TCGContext *s, ARMCond cond, TCGReg rd,
                             TCGArg a1, int ofs, int len, bool const_a1)
 {
@@ -2163,6 +2157,18 @@ static const TCGOutOpBswap outop_bswap16 = {
     .out_rr = tgen_bswap16,
 };
 
+static void tgen_bswap32(TCGContext *s, TCGType type,
+                         TCGReg rd, TCGReg rn, unsigned flags)
+{
+    /* rev */
+    tcg_out32(s, 0x06bf0f30 | (COND_AL << 28) | (rd << 12) | rn);
+}
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap32,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_subfi(s, type, a0, 0, a1);
@@ -2384,10 +2390,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
         break;
 
-    case INDEX_op_bswap32_i32:
-        tcg_out_bswap32(s, COND_AL, args[0], args[1]);
-        break;
-
     case INDEX_op_deposit_i32:
         tcg_out_deposit(s, COND_AL, args[0], args[2],
                         args[3], args[4], const_args[2]);
@@ -2444,7 +2446,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 7caaeb1f0c..f0bf69db2f 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3090,6 +3090,20 @@ static const TCGOutOpBswap outop_bswap16 = {
     .out_rr = tgen_bswap16,
 };
 
+static void tgen_bswap32(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_bswap32(s, a0);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_ext32s(s, a0, a0);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_O1_I1(r, 0),
+    .out_rr = tgen_bswap32,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
@@ -3193,13 +3207,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(bswap32):
-        tcg_out_bswap32(s, a0);
-        if (rexw && (a2 & TCG_BSWAP_OS)) {
-            tcg_out_ext32s(s, a0, a0);
-        }
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, -1, a1, a2, TCG_TYPE_I32);
         break;
@@ -3972,8 +3979,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 2c2b6708d3..e518cd9477 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1739,6 +1739,24 @@ static const TCGOutOpBswap outop_bswap16 = {
     .out_rr = tgen_bswap16,
 };
 
+static void tgen_bswap32(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_opc_revb_2w(s, a0, a1);
+
+    /* All 32-bit values are computed sign-extended in the register.  */
+    if (type == TCG_TYPE_I32 || (flags & TCG_BSWAP_OS)) {
+        tcg_out_ext32s(s, a0, a0);
+    } else if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
+        tcg_out_ext32u(s, a0, a0);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap32,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
@@ -1830,19 +1848,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_bstrins_d(s, a0, a2, args[3], args[3] + args[4] - 1);
         break;
 
-    case INDEX_op_bswap32_i32:
-        /* All 32-bit values are computed sign-extended in the register.  */
-        a2 = TCG_BSWAP_OS;
-        /* fallthrough */
-    case INDEX_op_bswap32_i64:
-        tcg_out_opc_revb_2w(s, a0, a1);
-        if (a2 & TCG_BSWAP_OS) {
-            tcg_out_ext32s(s, a0, a0);
-        } else if ((a2 & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
-            tcg_out_ext32u(s, a0, a0);
-        }
-        break;
-
     case INDEX_op_bswap64_i64:
         tcg_out_opc_revb_d(s, a0, a1);
         break;
@@ -2448,8 +2453,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 351174ae73..1404df6211 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -710,26 +710,6 @@ static void tcg_out_bswap_subr(TCGContext *s, const tcg_insn_unit *sub)
     }
 }
 
-static void tcg_out_bswap32(TCGContext *s, TCGReg ret, TCGReg arg, int flags)
-{
-    if (use_mips32r2_instructions) {
-        tcg_out_opc_reg(s, OPC_WSBH, ret, 0, arg);
-        tcg_out_opc_sa(s, OPC_ROTR, ret, ret, 16);
-        if (flags & TCG_BSWAP_OZ) {
-            tcg_out_opc_bf(s, OPC_DEXT, ret, ret, 31, 0);
-        }
-    } else {
-        if (flags & TCG_BSWAP_OZ) {
-            tcg_out_bswap_subr(s, bswap32u_addr);
-        } else {
-            tcg_out_bswap_subr(s, bswap32_addr);
-        }
-        /* delay slot -- never omit the insn, like tcg_out_mov might.  */
-        tcg_out_opc_reg(s, OPC_OR, TCG_TMP0, arg, TCG_REG_ZERO);
-        tcg_out_mov(s, TCG_TYPE_I32, ret, TCG_TMP3);
-    }
-}
-
 static void tcg_out_bswap64(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
@@ -2176,6 +2156,32 @@ static const TCGOutOpBswap outop_bswap16 = {
     .out_rr = tgen_bswap16,
 };
 
+static void tgen_bswap32(TCGContext *s, TCGType type,
+                         TCGReg ret, TCGReg arg, unsigned flags)
+{
+    if (use_mips32r2_instructions) {
+        tcg_out_opc_reg(s, OPC_WSBH, ret, 0, arg);
+        tcg_out_opc_sa(s, OPC_ROTR, ret, ret, 16);
+        if (flags & TCG_BSWAP_OZ) {
+            tcg_out_opc_bf(s, OPC_DEXT, ret, ret, 31, 0);
+        }
+    } else {
+        if (flags & TCG_BSWAP_OZ) {
+            tcg_out_bswap_subr(s, bswap32u_addr);
+        } else {
+            tcg_out_bswap_subr(s, bswap32_addr);
+        }
+        /* delay slot -- never omit the insn, like tcg_out_mov might.  */
+        tcg_out_opc_reg(s, OPC_OR, TCG_TMP0, arg, TCG_REG_ZERO);
+        tcg_out_mov(s, TCG_TYPE_I32, ret, TCG_TMP3);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap32,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
@@ -2267,12 +2273,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_bswap32_i32:
-        tcg_out_bswap32(s, a0, a1, 0);
-        break;
-    case INDEX_op_bswap32_i64:
-        tcg_out_bswap32(s, a0, a1, a2);
-        break;
     case INDEX_op_bswap64_i64:
         tcg_out_bswap64(s, a0, a1);
         break;
@@ -2377,7 +2377,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
@@ -2387,7 +2386,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3454254624..4527ed3eee 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1012,41 +1012,6 @@ static void tcg_out_addpcis(TCGContext *s, TCGReg dst, intptr_t imm)
     tcg_out32(s, ADDPCIS | RT(dst) | (d1 << 16) | (d0 << 6) | d2);
 }
 
-static void tcg_out_bswap32(TCGContext *s, TCGReg dst, TCGReg src, int flags)
-{
-    TCGReg tmp = dst == src ? TCG_REG_R0 : dst;
-
-    if (have_isa_3_10) {
-        tcg_out32(s, BRW | RA(dst) | RS(src));
-        if (flags & TCG_BSWAP_OS) {
-            tcg_out_ext32s(s, dst, dst);
-        } else if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
-            tcg_out_ext32u(s, dst, dst);
-        }
-        return;
-    }
-
-    /*
-     * Stolen from gcc's builtin_bswap32.
-     * In the following,
-     *   dep(a, b, m) -> (a & ~m) | (b & m)
-     *
-     * Begin with:                              src = xxxxabcd
-     */
-    /* tmp = rol32(src, 8) & 0xffffffff             = 0000bcda */
-    tcg_out_rlw(s, RLWINM, tmp, src, 8, 0, 31);
-    /* tmp = dep(tmp, rol32(src, 24), 0xff000000)   = 0000dcda */
-    tcg_out_rlw(s, RLWIMI, tmp, src, 24, 0, 7);
-    /* tmp = dep(tmp, rol32(src, 24), 0x0000ff00)   = 0000dcba */
-    tcg_out_rlw(s, RLWIMI, tmp, src, 24, 16, 23);
-
-    if (flags & TCG_BSWAP_OS) {
-        tcg_out_ext32s(s, dst, tmp);
-    } else {
-        tcg_out_mov(s, TCG_TYPE_REG, dst, tmp);
-    }
-}
-
 static void tcg_out_bswap64(TCGContext *s, TCGReg dst, TCGReg src)
 {
     TCGReg t0 = dst == src ? TCG_REG_R0 : dst;
@@ -3384,6 +3349,47 @@ static const TCGOutOpBswap outop_bswap16 = {
     .out_rr = tgen_bswap16,
 };
 
+static void tgen_bswap32(TCGContext *s, TCGType type,
+                         TCGReg dst, TCGReg src, unsigned flags)
+{
+    TCGReg tmp = dst == src ? TCG_REG_R0 : dst;
+
+    if (have_isa_3_10) {
+        tcg_out32(s, BRW | RA(dst) | RS(src));
+        if (flags & TCG_BSWAP_OS) {
+            tcg_out_ext32s(s, dst, dst);
+        } else if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
+            tcg_out_ext32u(s, dst, dst);
+        }
+        return;
+    }
+
+    /*
+     * Stolen from gcc's builtin_bswap32.
+     * In the following,
+     *   dep(a, b, m) -> (a & ~m) | (b & m)
+     *
+     * Begin with:                              src = xxxxabcd
+     */
+    /* tmp = rol32(src, 8) & 0xffffffff             = 0000bcda */
+    tcg_out_rlw(s, RLWINM, tmp, src, 8, 0, 31);
+    /* tmp = dep(tmp, rol32(src, 24), 0xff000000)   = 0000dcda */
+    tcg_out_rlw(s, RLWIMI, tmp, src, 24, 0, 7);
+    /* tmp = dep(tmp, rol32(src, 24), 0x0000ff00)   = 0000dcba */
+    tcg_out_rlw(s, RLWIMI, tmp, src, 24, 16, 23);
+
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_ext32s(s, dst, tmp);
+    } else {
+        tcg_out_mov(s, TCG_TYPE_REG, dst, tmp);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap32,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out32(s, NEG | RT(a0) | RA(a1));
@@ -3506,12 +3512,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_bswap32_i32:
-        tcg_out_bswap32(s, args[0], args[1], 0);
-        break;
-    case INDEX_op_bswap32_i64:
-        tcg_out_bswap32(s, args[0], args[1], args[2]);
-        break;
     case INDEX_op_bswap64_i64:
         tcg_out_bswap64(s, args[0], args[1]);
         break;
@@ -4252,7 +4252,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
@@ -4264,7 +4263,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index c6cd2100f8..9b6ca54ae7 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2424,6 +2424,23 @@ static const TCGOutOpBswap outop_bswap16 = {
     .out_rr = tgen_bswap16,
 };
 
+static void tgen_bswap32(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
+    if (flags & TCG_BSWAP_OZ) {
+        tcg_out_opc_imm(s, OPC_SRLI, a0, a0, 32);
+    } else {
+        tcg_out_opc_imm(s, OPC_SRAI, a0, a0, 32);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_bswap,
+    .out_rr = tgen_bswap32,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
@@ -2509,17 +2526,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_bswap64_i64:
         tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
         break;
-    case INDEX_op_bswap32_i32:
-        a2 = 0;
-        /* fall through */
-    case INDEX_op_bswap32_i64:
-        tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
-        if (a2 & TCG_BSWAP_OZ) {
-            tcg_out_opc_imm(s, OPC_SRLI, a0, a0, 32);
-        } else {
-            tcg_out_opc_imm(s, OPC_SRAI, a0, a0, 32);
-        }
-        break;
 
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
@@ -2858,8 +2864,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
         return C_O1_I1(r, r);
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index e90c03628a..ed2da3f31d 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2760,6 +2760,22 @@ static const TCGOutOpBswap outop_bswap16 = {
     .out_rr = tgen_bswap16,
 };
 
+static void tgen_bswap32(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_insn(s, RRE, LRVR, a0, a1);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_ext32s(s, a0, a0);
+    } else if ((flags & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
+        tcg_out_ext32u(s, a0, a0);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap32,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     if (type == TCG_TYPE_I32) {
@@ -2846,19 +2862,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_bswap32_i32:
-        tcg_out_insn(s, RRE, LRVR, args[0], args[1]);
-        break;
-    case INDEX_op_bswap32_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        tcg_out_insn(s, RRE, LRVR, a0, a1);
-        if (a2 & TCG_BSWAP_OS) {
-            tcg_out_ext32s(s, a0, a0);
-        } else if ((a2 & (TCG_BSWAP_IZ | TCG_BSWAP_OZ)) == TCG_BSWAP_OZ) {
-            tcg_out_ext32u(s, a0, a0);
-        }
-        break;
-
     case INDEX_op_add2_i32:
         if (const_args[4]) {
             tcg_out_insn(s, RIL, ALFI, args[0], args[4]);
@@ -3459,8 +3462,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 5111f173e1..cbe9c759ec 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1729,6 +1729,10 @@ static const TCGOutOpBswap outop_bswap16 = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
      tgen_sub(s, type, a0, TCG_REG_G0, a1);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4d3d9569cc..1b2f18e370 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -57,8 +57,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap32_i32:
-    case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
@@ -916,6 +914,20 @@ static const TCGOutOpBswap outop_bswap16 = {
     .out_rr = tgen_bswap16,
 };
 
+static void tgen_bswap32(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_op_rr(s, INDEX_op_bswap32_i32, a0, a1);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 32);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap32,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
@@ -1026,8 +1038,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    int width;
-
     switch (opc) {
     case INDEX_op_goto_ptr:
         tcg_out_op_r(s, opc, args[0]);
@@ -1062,20 +1072,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rrbb(s, opc, args[0], args[1], args[2], args[3]);
         break;
 
-    case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap32_i32). */
     case INDEX_op_bswap64_i64: /* Optional (TCG_TARGET_HAS_bswap64_i64). */
         tcg_out_op_rr(s, opc, args[0], args[1]);
         break;
 
-    case INDEX_op_bswap32_i64: /* Optional (TCG_TARGET_HAS_bswap32_i64). */
-        width = 32;
-        /* The base tci bswaps zero-extend, and ignore high bits. */
-        tcg_out_op_rr(s, opc, args[0], args[1]);
-        if (args[2] & TCG_BSWAP_OS) {
-            tcg_out_sextract(s, TCG_TYPE_REG, args[0], args[0], 0, width);
-        }
-        break;
-
     CASE_32_64(add2)
     CASE_32_64(sub2)
         tcg_out_op_rrrrrr(s, opc, args[0], args[1], args[2],
-- 
2.43.0


