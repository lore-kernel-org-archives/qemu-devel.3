Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AD3C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnrh-0005mS-13; Sun, 16 Feb 2025 18:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqD-000199-2O
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:26 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnq1-0005SG-9I
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:21 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2fc291f7ddbso3892413a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747640; x=1740352440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ODoI7kr0llM6ROXH5UcR+myCbUtvnqa2MUm384KotT0=;
 b=dL88Cp7kfevWKrmlwBPqnFVrFkpJEoiHLUPgMcbwmVIhAcLwyuFzyleZDKOfqNAkqh
 i7uJJJwjapwYwdRJGzH+Xbff0268tBFY1cyGm8HRaSopZ69jmfJz1lzLzEd/thwRXYrB
 PlIMeXsd2yO7ebgryUGb5z0GionfjaiRB7ndURIfxAY0foIT+DEG6c1qsueS2UyO9flE
 i3UihshRB/NwHguu0RKU3gGsq7uTP/+vyam8datHmp42uXS/bWfYPWTORXefJp4gq4/b
 NekaIUXMNxFP0IPydq2OVp+oebT+/nGtjKTD0PrWoh76Yn0sZuncISYWHTsT6fSQGeHY
 YutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747640; x=1740352440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ODoI7kr0llM6ROXH5UcR+myCbUtvnqa2MUm384KotT0=;
 b=W5rJmtmk3OisFoGJIcYhBlnT/aBYlNVmImCEXq2Y8wdJpsHqIWwK0Er9wjjc85/p2K
 MsSqnnVEkNNAt/KoHSkGyfDATQ2keXtpccPY9hVHc/BUXzVuXi4zq7yT+8hVwNfy6jtf
 B6mqIXHQkWmxp9jcOAsWLIFzlvfFgLDmzRQsqxWgvwKUI14qmxJ/RzlsvvYjRvpG+ucM
 gYOLv7YKBzUgnf6UQQW5LoDJesMDyCLFHV40V+wDG6Z8Qd8dxO/scdPYmu7TWG5FrRQB
 r4/Wh+B7TXxstvioPXWCUxiJyfWRVaYdp7Q7gZOjVq6Omf7I68bfFpaTlyVDVYjEBUt8
 JBHg==
X-Gm-Message-State: AOJu0Yx3LkEB2Ts1OWMVFyd1Ffdm3TmG3YkX5qQdMvLSk+iTIC3cEgQL
 MA3dDQbrXmW3h9b6AMFlKZz5Vvn+i2Vdoa982gnHWo0KWO8aH+ztIok0t1Fix+6tIzUqwCJSCxG
 H
X-Gm-Gg: ASbGncu7LzjkEApSKOBlC9smAu+8aMExgAu6g4HnnX/WTGdKZgSUS92tR9IdkqAQpE5
 REfeGoaggpyUQfPAtAF7qsmK1Xkft3a4xzVBu77+be4HyxKl54wUbQVQEYs+k9K6sE3t7cn7Je3
 f8/dxSepcDafhVnY8mv2wr9hkroGwKCRR/LH/axSusJfNMd3Bht3GmZHoCoLOxZYsSo7ZjB3u7b
 eTONc1+blX63RHpkRMfCvzVULIO8uPtYymrkzz6NtirXEwM6uw9LYSb7n5tMu8Ymagp/cybNLzl
 eyWleIs3QQ3c7Iiu6UzsYKPc9wlnQh6EMT3eC5QCSSLOBbE=
X-Google-Smtp-Source: AGHT+IHMO9Mh9TDryhWa6Q5W61MsmBVAdxo9oe5zx8zcvWUgGl0FDAHT69P3g6cLlbSxA8GmnhVY/g==
X-Received: by 2002:a17:90b:2789:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-2fc4116bc28mr12765839a91.33.1739747639453; 
 Sun, 16 Feb 2025 15:13:59 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 059/162] tcg: Convert rotl, rotr to TCGOutOpBinary
Date: Sun, 16 Feb 2025 15:08:28 -0800
Message-ID: <20250216231012.2808572-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

For aarch64, arm, loongarch64, mips, we can drop rotl.
For ppc, s390x we can drop rotr.
Only x86, riscv (and tci) have both rotl and rotr.

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
 tcg/tcg.c                        | 14 +++---
 tcg/tci.c                        | 12 ++---
 tcg/aarch64/tcg-target.c.inc     | 62 +++++++++---------------
 tcg/arm/tcg-target.c.inc         | 44 ++++++++---------
 tcg/i386/tcg-target.c.inc        | 62 ++++++++++++++++--------
 tcg/loongarch64/tcg-target.c.inc | 70 ++++++++++++---------------
 tcg/mips/tcg-target.c.inc        | 75 +++++++++++++----------------
 tcg/ppc/tcg-target.c.inc         | 70 ++++++++++++---------------
 tcg/riscv/tcg-target.c.inc       | 83 ++++++++++++++++++--------------
 tcg/s390x/tcg-target.c.inc       | 72 +++++++++++----------------
 tcg/sparc64/tcg-target.c.inc     |  8 +++
 tcg/tci/tcg-target-opc.h.inc     |  2 +
 tcg/tci/tcg-target.c.inc         | 34 ++++++++++---
 24 files changed, 306 insertions(+), 322 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 1fdff25d05..fa79cbc1f0 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -15,7 +15,6 @@
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -31,7 +30,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 32d73d3443..12ffbcda2b 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -26,7 +26,6 @@ extern bool use_neon_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
 #define TCG_TARGET_HAS_ctpop_i32        0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index aee6066579..a7199463df 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,7 +26,6 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_clz_i32          1
@@ -42,7 +41,6 @@
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 5dfc69ae6a..303134390a 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -11,7 +11,6 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_negsetcond_i32   0
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
@@ -26,7 +25,6 @@
 
 /* 64-bit operations */
 #define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_bswap16_i64      1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index ab6a134796..880eb084eb 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -60,7 +60,6 @@ extern bool use_mips32r2_instructions;
 
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_rot_i32          use_mips32r2_instructions
 #define TCG_TARGET_HAS_clz_i32          use_mips32r2_instructions
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -71,7 +70,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_rot_i64          use_mips32r2_instructions
 #define TCG_TARGET_HAS_clz_i64          use_mips32r2_instructions
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 37e88a3193..71c02d88b9 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -17,7 +17,6 @@
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_clz_i32          1
@@ -33,7 +32,6 @@
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index b3c6899887..c7745a6462 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -11,7 +11,6 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -25,7 +24,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index d61cc7a144..eaddf7005e 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -29,7 +29,6 @@ extern uint64_t s390_facilities[3];
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_rot_i32        1
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_clz_i32        0
@@ -44,7 +43,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
-#define TCG_TARGET_HAS_rot_i64        1
 #define TCG_TARGET_HAS_bswap16_i64    1
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 42de99efbf..1dd86c363d 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,7 +14,6 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_rot_i32          0
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_clz_i32          0
@@ -29,7 +28,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_rot_i64          0
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 0bb829be36..7bfa55adb1 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -12,7 +12,6 @@
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_rot_i64          0
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index bd51b9346d..04d341a8d2 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -13,7 +13,6 @@
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        1
-#define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -27,7 +26,6 @@
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
-#define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_muls2_i64        1
 #define TCG_TARGET_HAS_add2_i32         1
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0a7c9eb612..dfc5a6e4ce 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1042,6 +1042,10 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
+    OUTOP(INDEX_op_rotl_i32, TCGOutOpBinary, outop_rotl),
+    OUTOP(INDEX_op_rotl_i64, TCGOutOpBinary, outop_rotl),
+    OUTOP(INDEX_op_rotr_i32, TCGOutOpBinary, outop_rotr),
+    OUTOP(INDEX_op_rotr_i64, TCGOutOpBinary, outop_rotr),
     OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
@@ -2272,9 +2276,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_negsetcond_i32:
         return TCG_TARGET_HAS_negsetcond_i32;
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotr_i32:
-        return TCG_TARGET_HAS_rot_i32;
     case INDEX_op_extract2_i32:
         return TCG_TARGET_HAS_extract2_i32;
     case INDEX_op_add2_i32:
@@ -2323,9 +2324,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_negsetcond_i64:
         return TCG_TARGET_HAS_negsetcond_i64;
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i64:
-        return TCG_TARGET_HAS_rot_i64;
     case INDEX_op_extract2_i64:
         return TCG_TARGET_HAS_extract2_i64;
     case INDEX_op_extrl_i64_i32:
@@ -5414,6 +5412,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl_i64:
+    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr_i64:
     case INDEX_op_sar:
     case INDEX_op_shl:
     case INDEX_op_shr:
diff --git a/tcg/tci.c b/tcg/tci.c
index 2a2f216898..0fb13ff61d 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -630,16 +630,14 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = ((tcg_target_long)regs[r1]
                         >> (regs[r2] % TCG_TARGET_REG_BITS));
             break;
-#if TCG_TARGET_HAS_rot_i32
-        case INDEX_op_rotl_i32:
+        case INDEX_op_tci_rotl32:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = rol32(regs[r1], regs[r2] & 31);
             break;
-        case INDEX_op_rotr_i32:
+        case INDEX_op_tci_rotr32:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ror32(regs[r1], regs[r2] & 31);
             break;
-#endif
         case INDEX_op_deposit_i32:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit32(regs[r1], pos, len, regs[r2]);
@@ -788,7 +786,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (64 bit). */
 
-#if TCG_TARGET_HAS_rot_i64
         case INDEX_op_rotl_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = rol64(regs[r1], regs[r2] & 63);
@@ -797,7 +794,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ror64(regs[r1], regs[r2] & 63);
             break;
-#endif
         case INDEX_op_deposit_i64:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
@@ -1075,9 +1071,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_rotl_i32:
     case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
     case INDEX_op_rotr_i64:
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
@@ -1087,6 +1081,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_tci_divu32:
     case INDEX_op_tci_rems32:
     case INDEX_op_tci_remu32:
+    case INDEX_op_tci_rotl32:
+    case INDEX_op_tci_rotr32:
         tci_args_rrr(insn, &r0, &r1, &r2);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
                            op_name, str_r(r0), str_r(r1), str_r(r2));
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 90bdbf8387..00fca43840 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1347,20 +1347,6 @@ static inline void tcg_out_extr(TCGContext *s, TCGType ext, TCGReg rd,
     tcg_out_insn(s, 3403, EXTR, ext, rd, rn, rm, a);
 }
 
-static inline void tcg_out_rotr(TCGContext *s, TCGType ext,
-                                TCGReg rd, TCGReg rn, unsigned int m)
-{
-    int max = ext ? 63 : 31;
-    tcg_out_extr(s, ext, rd, rn, rn, m & max);
-}
-
-static inline void tcg_out_rotl(TCGContext *s, TCGType ext,
-                                TCGReg rd, TCGReg rn, unsigned int m)
-{
-    int max = ext ? 63 : 31;
-    tcg_out_extr(s, ext, rd, rn, rn, -m & max);
-}
-
 static inline void tcg_out_dep(TCGContext *s, TCGType ext, TCGReg rd,
                                TCGReg rn, unsigned lsb, unsigned width)
 {
@@ -2277,6 +2263,29 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tgen_rotr(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3508, RORV, type, a0, a1, a2);
+}
+
+static void tgen_rotri(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int max = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_extr(s, type, a0, a1, a1, a2 & max);
+}
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_rotr,
+    .out_rri = tgen_rotri,
+};
+
 static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2451,25 +2460,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_rotr_i64:
-    case INDEX_op_rotr_i32:
-        if (c2) {
-            tcg_out_rotr(s, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3508, RORV, ext, a0, a1, a2);
-        }
-        break;
-
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotl_i32:
-        if (c2) {
-            tcg_out_rotl(s, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3502, SUB, 0, TCG_REG_TMP0, TCG_REG_XZR, a2);
-            tcg_out_insn(s, 3508, RORV, ext, a0, a1, TCG_REG_TMP0);
-        }
-        break;
-
     case INDEX_op_clz_i64:
     case INDEX_op_clz_i32:
         tcg_out_cltz(s, ext, a0, a1, a2, c2, false);
@@ -3099,12 +3089,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i64:
-        return C_O1_I2(r, r, ri);
-
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
     case INDEX_op_clz_i64:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 3d08a87826..78120622e7 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1969,6 +1969,28 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tgen_rotr(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, a0, 0, a1, SHIFT_REG_ROR(a2));
+}
+
+static void tgen_rotri(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, a0, 0, a1, SHIFT_IMM_ROR(a2 & 0x1f));
+}
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_rotr,
+    .out_rri = tgen_rotri,
+};
+
 static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2177,24 +2199,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_muls2_i32:
         tcg_out_smull32(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
-    case INDEX_op_rotr_i32:
-        c = const_args[2] ? (args[2] & 0x1f) ? SHIFT_IMM_ROR(args[2] & 0x1f) :
-                SHIFT_IMM_LSL(0) : SHIFT_REG_ROR(args[2]);
-        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0, args[1], c);
-        break;
-
-    case INDEX_op_rotl_i32:
-        if (const_args[2]) {
-            tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0, args[1],
-                            ((0x20 - args[2]) & 0x1f) ?
-                            SHIFT_IMM_ROR((0x20 - args[2]) & 0x1f) :
-                            SHIFT_IMM_LSL(0));
-        } else {
-            tcg_out_dat_imm(s, COND_AL, ARITH_RSB, TCG_REG_TMP, args[2], 0x20);
-            tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0, args[1],
-                            SHIFT_REG_ROR(TCG_REG_TMP));
-        }
-        break;
 
     case INDEX_op_ctz_i32:
         tcg_out_dat_reg(s, COND_AL, INSN_RBIT, TCG_REG_TMP, 0, args[1], 0);
@@ -2348,10 +2352,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
 
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotr_i32:
-        return C_O1_I2(r, r, ri);
-
     case INDEX_op_brcond_i32:
         return C_O0_I2(r, rIN);
     case INDEX_op_deposit_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0ffbdc8f02..a01bb212cd 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2744,6 +2744,46 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_rotl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_SHIFT_cl + rexw, SHIFT_ROL, a0);
+}
+
+static void tgen_rotli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_shifti(s, SHIFT_ROL + rexw, a0, a2);
+}
+
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_O1_I2(r, 0, ci),
+    .out_rrr = tgen_rotl,
+    .out_rri = tgen_rotli,
+};
+
+static void tgen_rotr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_SHIFT_cl + rexw, SHIFT_ROR, a0);
+}
+
+static void tgen_rotri(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_shifti(s, SHIFT_ROR + rexw, a0, a2);
+}
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_O1_I2(r, 0, ci),
+    .out_rrr = tgen_rotr,
+    .out_rri = tgen_rotri,
+};
+
 static TCGConstraintSetIndex cset_shift(TCGType type, unsigned flags)
 {
     return have_bmi2 ? C_O1_I2(r, r, ri) : C_O1_I2(r, 0, ci);
@@ -2901,7 +2941,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGArg a0, a1, a2;
-    int c, const_a2, rexw;
+    int const_a2, rexw;
 
 #if TCG_TARGET_REG_BITS == 64
 # define OP_32_64(x) \
@@ -2976,20 +3016,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(rotl):
-        c = SHIFT_ROL;
-        goto gen_shift;
-    OP_32_64(rotr):
-        c = SHIFT_ROR;
-        goto gen_shift;
-    gen_shift:
-        if (const_a2) {
-            tcg_out_shifti(s, c + rexw, a0, a2);
-        } else {
-            tcg_out_modrm(s, OPC_SHIFT_cl + rexw, c, a0);
-        }
-        break;
-
     OP_32_64(ctz):
         tcg_out_ctz(s, rexw, args[0], args[1], args[2], const_args[2]);
         break;
@@ -3824,12 +3850,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotr_i64:
-        return C_O1_I2(r, 0, ci);
-
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         return C_O0_I2(r, reT);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 45d31c76b5..d7f4eeaa8b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1477,6 +1477,36 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tgen_rotr(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_rotr_w(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_rotr_d(s, a0, a1, a2);
+    }
+}
+
+static void tgen_rotri(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_rotri_w(s, a0, a1, a2 & 0x1f);
+    } else {
+        tcg_out_opc_rotri_d(s, a0, a1, a2 & 0x3f);
+    }
+}
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_rotr,
+    .out_rri = tgen_rotri,
+};
+
 static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1726,40 +1756,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_clzctz(s, OPC_CTZ_D, a0, a1, a2, c2, false);
         break;
 
-    case INDEX_op_rotl_i32:
-        /* transform into equivalent rotr/rotri */
-        if (c2) {
-            tcg_out_opc_rotri_w(s, a0, a1, (32 - a2) & 0x1f);
-        } else {
-            tcg_out_opc_sub_w(s, TCG_REG_TMP0, TCG_REG_ZERO, a2);
-            tcg_out_opc_rotr_w(s, a0, a1, TCG_REG_TMP0);
-        }
-        break;
-    case INDEX_op_rotl_i64:
-        /* transform into equivalent rotr/rotri */
-        if (c2) {
-            tcg_out_opc_rotri_d(s, a0, a1, (64 - a2) & 0x3f);
-        } else {
-            tcg_out_opc_sub_w(s, TCG_REG_TMP0, TCG_REG_ZERO, a2);
-            tcg_out_opc_rotr_d(s, a0, a1, TCG_REG_TMP0);
-        }
-        break;
-
-    case INDEX_op_rotr_i32:
-        if (c2) {
-            tcg_out_opc_rotri_w(s, a0, a1, a2 & 0x1f);
-        } else {
-            tcg_out_opc_rotr_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_rotr_i64:
-        if (c2) {
-            tcg_out_opc_rotri_d(s, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_rotr_d(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
         tcg_out_setcond(s, args[3], a0, a1, a2, c2);
@@ -2396,12 +2392,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotr_i64:
-        return C_O1_I2(r, r, ri);
-
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 82da14ca2d..f94c3678c1 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1914,6 +1914,39 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static TCGConstraintSetIndex cset_rotr(TCGType type, unsigned flags)
+{
+    return use_mips32r2_instructions ? C_O1_I2(r, r, ri) : C_NotImplemented;
+}
+
+static void tgen_rotr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_ROTRV : OPC_DROTRV;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_rotri(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sa(s, OPC_ROTR, a0, a1, a2);
+    } else {
+        tcg_out_opc_sa64(s, OPC_DROTR, OPC_DROTR32, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_rotr,
+    .out_rrr = tgen_rotr,
+    .out_rri = tgen_rotri,
+};
+
 static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2038,14 +2071,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    MIPSInsn i1, i2;
+    MIPSInsn i1;
     TCGArg a0, a1, a2;
-    int c2;
 
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
-    c2 = const_args[2];
 
     switch (opc) {
     case INDEX_op_goto_ptr:
@@ -2140,39 +2171,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_dsra(s, a0, a1, 32);
         break;
 
-    case INDEX_op_rotr_i32:
-        i1 = OPC_ROTRV, i2 = OPC_ROTR;
-        if (c2) {
-            tcg_out_opc_sa(s, i2, a0, a1, a2);
-            break;
-        }
-    do_shiftv:
-        tcg_out_opc_reg(s, i1, a0, a2, a1);
-        break;
-    case INDEX_op_rotl_i32:
-        if (c2) {
-            tcg_out_opc_sa(s, OPC_ROTR, a0, a1, 32 - a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_SUBU, TCG_TMP0, TCG_REG_ZERO, a2);
-            tcg_out_opc_reg(s, OPC_ROTRV, a0, TCG_TMP0, a1);
-        }
-        break;
-    case INDEX_op_rotr_i64:
-        if (c2) {
-            tcg_out_opc_sa64(s, OPC_DROTR, OPC_DROTR32, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DROTRV;
-        goto do_shiftv;
-    case INDEX_op_rotl_i64:
-        if (c2) {
-            tcg_out_opc_sa64(s, OPC_DROTR, OPC_DROTR32, a0, a1, 64 - a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_DSUBU, TCG_TMP0, TCG_REG_ZERO, a2);
-            tcg_out_opc_reg(s, OPC_DROTRV, a0, TCG_TMP0, a1);
-        }
-        break;
-
     case INDEX_op_clz_i32:
         tcg_out_clz(s, OPC_CLZ, OPC_CLZ_R6, 32, a0, a1, a2);
         break;
@@ -2337,11 +2335,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotr_i64:
-    case INDEX_op_rotl_i64:
-        return C_O1_I2(r, r, ri);
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rzW);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 24e8f675bb..687b66af54 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3122,6 +3122,36 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_rotl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out32(s, RLWNM | SAB(a1, a0, a2) | MB(0) | ME(31));
+    } else {
+        tcg_out32(s, RLDCL | SAB(a1, a0, a2) | MB64(0));
+    }
+}
+
+static void tgen_rotli(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_rlw(s, RLWINM, a0, a1, a2, 0, 31);
+    } else {
+        tcg_out_rld(s, RLDICL, a0, a1, a2, 0);
+    }
+}
+
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_rotl,
+    .out_rri = tgen_rotli,
+};
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3344,24 +3374,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
         break;
 
-    case INDEX_op_rotl_i32:
-        if (const_args[2]) {
-            tcg_out_rlw(s, RLWINM, args[0], args[1], args[2], 0, 31);
-        } else {
-            tcg_out32(s, RLWNM | SAB(args[1], args[0], args[2])
-                         | MB(0) | ME(31));
-        }
-        break;
-    case INDEX_op_rotr_i32:
-        if (const_args[2]) {
-            tcg_out_rlw(s, RLWINM, args[0], args[1], 32 - args[2], 0, 31);
-        } else {
-            tcg_out32(s, SUBFIC | TAI(TCG_REG_R0, args[2], 32));
-            tcg_out32(s, RLWNM | SAB(args[1], args[0], TCG_REG_R0)
-                         | MB(0) | ME(31));
-        }
-        break;
-
     case INDEX_op_brcond_i32:
         tcg_out_brcond(s, args[2], args[0], args[1], const_args[1],
                        arg_label(args[3]), TCG_TYPE_I32);
@@ -3374,22 +3386,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond2(s, args, const_args);
         break;
 
-    case INDEX_op_rotl_i64:
-        if (const_args[2]) {
-            tcg_out_rld(s, RLDICL, args[0], args[1], args[2], 0);
-        } else {
-            tcg_out32(s, RLDCL | SAB(args[1], args[0], args[2]) | MB64(0));
-        }
-        break;
-    case INDEX_op_rotr_i64:
-        if (const_args[2]) {
-            tcg_out_rld(s, RLDICL, args[0], args[1], 64 - args[2], 0);
-        } else {
-            tcg_out32(s, SUBFIC | TAI(TCG_REG_R0, args[2], 64));
-            tcg_out32(s, RLDCL | SAB(args[1], args[0], TCG_REG_R0) | MB64(0));
-        }
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
@@ -4232,12 +4228,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i64:
-        return C_O1_I2(r, r, ri);
-
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
     case INDEX_op_clz_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 8cab07a392..4dd892d98d 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2144,6 +2144,53 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static TCGConstraintSetIndex cset_rot(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_ZBB ? C_O1_I2(r, r, ri) : C_NotImplemented;
+}
+
+static void tgen_rotr(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_RORW : OPC_ROR;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_rotri(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_RORIW : OPC_RORI;
+    unsigned mask = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_opc_imm(s, insn, a0, a1, a2 & mask);
+}
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_rot,
+    .out_rrr = tgen_rotr,
+    .out_rri = tgen_rotri,
+};
+
+static void tgen_rotl(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_ROLW : OPC_ROL;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_rotli(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_rotri(s, type, a0, a1, -a2);
+}
+
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_rot,
+    .out_rrr = tgen_rotl,
+    .out_rri = tgen_rotli,
+};
+
 static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2320,36 +2367,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_rotl_i32:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_RORIW, a0, a1, -a2 & 0x1f);
-        } else {
-            tcg_out_opc_reg(s, OPC_ROLW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_rotl_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_RORI, a0, a1, -a2 & 0x3f);
-        } else {
-            tcg_out_opc_reg(s, OPC_ROL, a0, a1, a2);
-        }
-        break;
-
-    case INDEX_op_rotr_i32:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_RORIW, a0, a1, a2 & 0x1f);
-        } else {
-            tcg_out_opc_reg(s, OPC_RORW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_rotr_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_RORI, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_reg(s, OPC_ROR, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_bswap64_i64:
         tcg_out_opc_imm(s, OPC_REV8, a0, a1, 0);
         break;
@@ -2776,12 +2793,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i64:
-        return C_O1_I2(r, r, ri);
-
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 1cf4920276..76180dabcb 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2445,6 +2445,35 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_rotl_int(TCGContext *s, TCGType type, TCGReg dst,
+                          TCGReg src, TCGReg v, tcg_target_long i)
+{
+    S390Opcode insn = type == TCG_TYPE_I32 ? RSY_RLL : RSY_RLLG;
+    tcg_out_sh64(s, insn, dst, src, v, i);
+}
+
+static void tgen_rotl(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tgen_rotl_int(s, type, a0, a1, a2, 0);
+}
+
+static void tgen_rotli(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_rotl_int(s, type, a0, a1, TCG_REG_NONE, a2);
+}
+
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_rotl,
+    .out_rri = tgen_rotli,
+};
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_sar_int(TCGContext *s, TCGType type, TCGReg dst,
                          TCGReg src, TCGReg v, tcg_target_long i)
 {
@@ -2663,24 +2692,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_rotl_i32:
-        /* ??? Using tcg_out_sh64 here for the format; it is a 32-bit rol.  */
-        if (const_args[2]) {
-            tcg_out_sh64(s, RSY_RLL, args[0], args[1], TCG_REG_NONE, args[2]);
-        } else {
-            tcg_out_sh64(s, RSY_RLL, args[0], args[1], args[2], 0);
-        }
-        break;
-    case INDEX_op_rotr_i32:
-        if (const_args[2]) {
-            tcg_out_sh64(s, RSY_RLL, args[0], args[1],
-                         TCG_REG_NONE, (32 - args[2]) & 31);
-        } else {
-            tcg_out_insn(s, RR, LCR, TCG_TMP0, args[2]);
-            tcg_out_sh64(s, RSY_RLL, args[0], args[1], TCG_TMP0, 0);
-        }
-        break;
-
     case INDEX_op_bswap16_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
         tcg_out_insn(s, RRE, LRVR, a0, a1);
@@ -2806,26 +2817,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RRFa, MGRK, args[1], args[2], args[3]);
         break;
 
-    case INDEX_op_rotl_i64:
-        if (const_args[2]) {
-            tcg_out_sh64(s, RSY_RLLG, args[0], args[1],
-                         TCG_REG_NONE, args[2]);
-        } else {
-            tcg_out_sh64(s, RSY_RLLG, args[0], args[1], args[2], 0);
-        }
-        break;
-    case INDEX_op_rotr_i64:
-        if (const_args[2]) {
-            tcg_out_sh64(s, RSY_RLLG, args[0], args[1],
-                         TCG_REG_NONE, (64 - args[2]) & 63);
-        } else {
-            /* We can use the smaller 32-bit negate because only the
-               low 6 bits are examined for the rotate.  */
-            tcg_out_insn(s, RR, LCR, TCG_TMP0, args[2]);
-            tcg_out_sh64(s, RSY_RLLG, args[0], args[1], TCG_TMP0, 0);
-        }
-        break;
-
     case INDEX_op_add2_i64:
         if (const_args[4]) {
             if ((int64_t)args[4] >= 0) {
@@ -3390,11 +3381,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotr_i64:
-        return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
     case INDEX_op_setcond_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 42d81c1e6c..57b26ae33b 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1484,6 +1484,14 @@ static const TCGOutOpBinary outop_remu = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 82d2a38cae..cff215490a 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -6,3 +6,5 @@ DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_remu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rotl32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rotr32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index feaa13dff0..0a2da3ba47 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -79,10 +79,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotr_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
     case INDEX_op_deposit_i32:
@@ -772,6 +768,34 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_rotl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rotl32
+                     : INDEX_op_rotl_i64);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rotl,
+};
+
+static void tgen_rotr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rotr32
+                     : INDEX_op_rotr_i64);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rotr,
+};
+
 static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -897,8 +921,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
-    CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
     CASE_32_64(ctz)      /* Optional (TCG_TARGET_HAS_ctz_*). */
         tcg_out_op_rrr(s, opc, args[0], args[1], args[2]);
-- 
2.43.0


