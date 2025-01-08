Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C28E7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdyW-0008Q4-UQ; Wed, 08 Jan 2025 16:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyT-0008Lg-Kn
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyR-000421-Di
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:25 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4368a293339so3574305e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373142; x=1736977942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsLfIB5HVYuIPzxAk6X9Uyz9K0eCu9XCNoN8YsZX/Hw=;
 b=SlLKAJDtG+GnPaTwEC7RzkpB29np92hgh3A/qZwJDOO3Ajvp8aQ6ETi2wJjYWeiUDd
 DpNT6kSNf1AmAqUiqRHIarBQqCTHH3u5BvvEFaaP3Ul0p4JSdgFyL7cLAgCzM9UN3zAH
 3I+9jezU2Iy0CAXyWe4leTxF8/4gDnfeo9KHHm1MFngG90fMl4/TYGBKnxzngXOujvlz
 R2jclnSTtm3kH0RKQiT4BjXVcTGjunhMdi5CS9TSnPaaI3tL2fyPH/6j/qT4fmYqiEBh
 csIZ/X12Jg9ZkHrsVj7eJknVh/Eznpyxziacqe6bkp7fwxBjN2DV9V7Zqz3eRZ9tx/Ku
 U4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373142; x=1736977942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsLfIB5HVYuIPzxAk6X9Uyz9K0eCu9XCNoN8YsZX/Hw=;
 b=YPJFDnGh3T2t9r6gFxV6B6GoutR4n+V+hWT71Fdq4VOGjeQNNYQ/tg6EoVMXKDOVit
 ulfSijtm182x6YKO1QoeihP/Rm5l58H5Cpn7va0Tb9zih5unNZq+egRWwrSRMkl/FqoN
 JF0oev1KmDVl/xy5/rzSuv+kUmJlYr413cDCIgmj5gVRSSeByf3dgMMug0cEiSIq6EW/
 5FpgCZ8AXwBEXBWGHiy9g3b1bmdBX+jyZ/X2RUTQYvLD0Y7U/h3OPUmD8AbxOP9Ge5XY
 YxSaKgv65yS8mF7iRy9xgV27XXMPwGnPrbQxK1HB3YCr9/533HJycHuicpy6GmqMMLYW
 SM+A==
X-Gm-Message-State: AOJu0Yww8RZNRxPfRwMy+ubD4hcD2LBZLVY5iqpYq7k4C0TgfuIOv5UJ
 RFFAAHq7s+qo6UiyREuifHFU5YShORZcKKTTvVX9FUSN0kh7ClVe7RZL6qhVTg2JgnJK086T4ZI
 bSnA=
X-Gm-Gg: ASbGncuf2sNYcDuk+YO2mE6S+LSebEjRm6JfQMWjvw7SbjeHcXkpgfNH/S1kudx/FKI
 0yLxW6b5KmliEVRLxTJLF3fEUgF48Kph8z3ssASvTnsX3EB6E6a8+AKEdc3TH57HEfTobDaVN87
 3VDAI/56inmwx+dDMFEUkQOTwNTkaUdeavHFDlGrint5Bh9ZTbpTDS9TePxMIbS1X97o8eKTU6z
 RGH9SPaP70tVwmi3wCfSa39DE49U3yqm9HSQ2wswduwqLzxOjNQZv+AxYorgbIuSPUnoejPS+Bl
 zvu57H+dQeQbCFxxFxVIcNCZKtDOp14=
X-Google-Smtp-Source: AGHT+IEl34f9WdHYt7tGa9BA3rP7nl+CcrQh5ck9KpwwL2pvZt8lz0JbssPd6rfIEFDW44tbAya6zg==
X-Received: by 2002:a05:6000:18ae:b0:38a:4b8b:1ba with SMTP id
 ffacd0b85a97d-38a873049e3mr3227272f8f.14.1736373141536; 
 Wed, 08 Jan 2025 13:52:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e99b4ff8sm750435e9.20.2025.01.08.13.52.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/14] tcg/i386: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Wed,  8 Jan 2025 22:51:46 +0100
Message-ID: <20250108215156.8731-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/i386/tcg-target-has.h | 139 ++++++++++++++++++++++++++++++++++++++
 tcg/i386/tcg-target.h     | 129 +----------------------------------
 2 files changed, 140 insertions(+), 128 deletions(-)
 create mode 100644 tcg/i386/tcg-target-has.h

diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
new file mode 100644
index 00000000000..3ea2eab8071
--- /dev/null
+++ b/tcg/i386/tcg-target-has.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#include "host/cpuinfo.h"
+
+#define have_bmi1         (cpuinfo & CPUINFO_BMI1)
+#define have_popcnt       (cpuinfo & CPUINFO_POPCNT)
+#define have_avx1         (cpuinfo & CPUINFO_AVX1)
+#define have_avx2         (cpuinfo & CPUINFO_AVX2)
+#define have_movbe        (cpuinfo & CPUINFO_MOVBE)
+
+/*
+ * There are interesting instructions in AVX512, so long as we have AVX512VL,
+ * which indicates support for EVEX on sizes smaller than 512 bits.
+ */
+#define have_avx512vl     ((cpuinfo & CPUINFO_AVX512VL) && \
+                           (cpuinfo & CPUINFO_AVX512F))
+#define have_avx512bw     ((cpuinfo & CPUINFO_AVX512BW) && have_avx512vl)
+#define have_avx512dq     ((cpuinfo & CPUINFO_AVX512DQ) && have_avx512vl)
+#define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
+
+/* optional instructions */
+#define TCG_TARGET_HAS_div2_i32         1
+#define TCG_TARGET_HAS_rot_i32          1
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        1
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_bswap16_i32      1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_andc_i32         have_bmi1
+#define TCG_TARGET_HAS_orc_i32          0
+#define TCG_TARGET_HAS_eqv_i32          0
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_nor_i32          0
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          1
+#define TCG_TARGET_HAS_ctpop_i32        have_popcnt
+#define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
+#define TCG_TARGET_HAS_extract2_i32     1
+#define TCG_TARGET_HAS_negsetcond_i32   1
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_mulu2_i32        1
+#define TCG_TARGET_HAS_muls2_i32        1
+#define TCG_TARGET_HAS_muluh_i32        0
+#define TCG_TARGET_HAS_mulsh_i32        0
+
+#if TCG_TARGET_REG_BITS == 64
+/* Keep 32-bit values zero-extended in a register.  */
+#define TCG_TARGET_HAS_extr_i64_i32     1
+#define TCG_TARGET_HAS_div2_i64         1
+#define TCG_TARGET_HAS_rot_i64          1
+#define TCG_TARGET_HAS_ext8s_i64        1
+#define TCG_TARGET_HAS_ext16s_i64       1
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext8u_i64        1
+#define TCG_TARGET_HAS_ext16u_i64       1
+#define TCG_TARGET_HAS_ext32u_i64       1
+#define TCG_TARGET_HAS_bswap16_i64      1
+#define TCG_TARGET_HAS_bswap32_i64      1
+#define TCG_TARGET_HAS_bswap64_i64      1
+#define TCG_TARGET_HAS_not_i64          1
+#define TCG_TARGET_HAS_andc_i64         have_bmi1
+#define TCG_TARGET_HAS_orc_i64          0
+#define TCG_TARGET_HAS_eqv_i64          0
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_nor_i64          0
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          1
+#define TCG_TARGET_HAS_ctpop_i64        have_popcnt
+#define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     1
+#define TCG_TARGET_HAS_negsetcond_i64   1
+#define TCG_TARGET_HAS_add2_i64         1
+#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_mulu2_i64        1
+#define TCG_TARGET_HAS_muls2_i64        1
+#define TCG_TARGET_HAS_muluh_i64        0
+#define TCG_TARGET_HAS_mulsh_i64        0
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+#else
+#define TCG_TARGET_HAS_qemu_st8_i32     1
+#endif
+
+#define TCG_TARGET_HAS_qemu_ldst_i128 \
+    (TCG_TARGET_REG_BITS == 64 && (cpuinfo & CPUINFO_ATOMIC_VMOVDQA))
+
+#define TCG_TARGET_HAS_tst              1
+
+/* We do not support older SSE systems, only beginning with AVX1.  */
+#define TCG_TARGET_HAS_v64              have_avx1
+#define TCG_TARGET_HAS_v128             have_avx1
+#define TCG_TARGET_HAS_v256             have_avx2
+
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          have_avx512vl
+#define TCG_TARGET_HAS_nand_vec         have_avx512vl
+#define TCG_TARGET_HAS_nor_vec          have_avx512vl
+#define TCG_TARGET_HAS_eqv_vec          have_avx512vl
+#define TCG_TARGET_HAS_not_vec          have_avx512vl
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_abs_vec          1
+#define TCG_TARGET_HAS_roti_vec         have_avx512vl
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         have_avx512vl
+#define TCG_TARGET_HAS_shi_vec          1
+#define TCG_TARGET_HAS_shs_vec          1
+#define TCG_TARGET_HAS_shv_vec          have_avx2
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
+#define TCG_TARGET_HAS_cmpsel_vec       1
+#define TCG_TARGET_HAS_tst_vec          have_avx512bw
+
+#define TCG_TARGET_deposit_i32_valid(ofs, len) \
+    (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
+     (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
+#define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
+
+/* Check for the possibility of high-byte extraction and, for 64-bit,
+   zero-extending 32-bit right-shift.  */
+#define TCG_TARGET_extract_i32_valid(ofs, len) ((ofs) == 8 && (len) == 8)
+#define TCG_TARGET_extract_i64_valid(ofs, len) \
+    (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
+
+#endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 9961d8e7576..a1dfdeb28d4 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -25,8 +25,6 @@
 #ifndef I386_TCG_TARGET_H
 #define I386_TCG_TARGET_H
 
-#include "host/cpuinfo.h"
-
 #define TCG_TARGET_INSN_UNIT_SIZE  1
 
 #ifdef __x86_64__
@@ -90,132 +88,7 @@ typedef enum {
     TCG_REG_CALL_STACK = TCG_REG_ESP
 } TCGReg;
 
-#define have_bmi1         (cpuinfo & CPUINFO_BMI1)
-#define have_popcnt       (cpuinfo & CPUINFO_POPCNT)
-#define have_avx1         (cpuinfo & CPUINFO_AVX1)
-#define have_avx2         (cpuinfo & CPUINFO_AVX2)
-#define have_movbe        (cpuinfo & CPUINFO_MOVBE)
-
-/*
- * There are interesting instructions in AVX512, so long as we have AVX512VL,
- * which indicates support for EVEX on sizes smaller than 512 bits.
- */
-#define have_avx512vl     ((cpuinfo & CPUINFO_AVX512VL) && \
-                           (cpuinfo & CPUINFO_AVX512F))
-#define have_avx512bw     ((cpuinfo & CPUINFO_AVX512BW) && have_avx512vl)
-#define have_avx512dq     ((cpuinfo & CPUINFO_AVX512DQ) && have_avx512vl)
-#define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
-
-/* optional instructions */
-#define TCG_TARGET_HAS_div2_i32         1
-#define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         have_bmi1
-#define TCG_TARGET_HAS_orc_i32          0
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        have_popcnt
-#define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
-#define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        1
-#define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
-
-#if TCG_TARGET_REG_BITS == 64
-/* Keep 32-bit values zero-extended in a register.  */
-#define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_div2_i64         1
-#define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      1
-#define TCG_TARGET_HAS_bswap32_i64      1
-#define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         have_bmi1
-#define TCG_TARGET_HAS_orc_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        have_popcnt
-#define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     1
-#define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        1
-#define TCG_TARGET_HAS_muls2_i64        1
-#define TCG_TARGET_HAS_muluh_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-#else
-#define TCG_TARGET_HAS_qemu_st8_i32     1
-#endif
-
-#define TCG_TARGET_HAS_qemu_ldst_i128 \
-    (TCG_TARGET_REG_BITS == 64 && (cpuinfo & CPUINFO_ATOMIC_VMOVDQA))
-
-#define TCG_TARGET_HAS_tst              1
-
-/* We do not support older SSE systems, only beginning with AVX1.  */
-#define TCG_TARGET_HAS_v64              have_avx1
-#define TCG_TARGET_HAS_v128             have_avx1
-#define TCG_TARGET_HAS_v256             have_avx2
-
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          have_avx512vl
-#define TCG_TARGET_HAS_nand_vec         have_avx512vl
-#define TCG_TARGET_HAS_nor_vec          have_avx512vl
-#define TCG_TARGET_HAS_eqv_vec          have_avx512vl
-#define TCG_TARGET_HAS_not_vec          have_avx512vl
-#define TCG_TARGET_HAS_neg_vec          0
-#define TCG_TARGET_HAS_abs_vec          1
-#define TCG_TARGET_HAS_roti_vec         have_avx512vl
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         have_avx512vl
-#define TCG_TARGET_HAS_shi_vec          1
-#define TCG_TARGET_HAS_shs_vec          1
-#define TCG_TARGET_HAS_shv_vec          have_avx2
-#define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
-#define TCG_TARGET_HAS_cmpsel_vec       1
-#define TCG_TARGET_HAS_tst_vec          have_avx512bw
-
-#define TCG_TARGET_deposit_i32_valid(ofs, len) \
-    (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
-     (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
-#define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
-
-/* Check for the possibility of high-byte extraction and, for 64-bit,
-   zero-extending 32-bit right-shift.  */
-#define TCG_TARGET_extract_i32_valid(ofs, len) ((ofs) == 8 && (len) == 8)
-#define TCG_TARGET_extract_i64_valid(ofs, len) \
-    (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
+#include "tcg-target-has.h"
 
 /* This defines the natural memory order supported by this
  * architecture before guarantees made by various barrier
-- 
2.47.1


