Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56DDC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr24-00048b-5w; Fri, 17 Jan 2025 13:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1y-000454-GZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:18 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1w-0007sg-7L
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:18 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso32616045ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138315; x=1737743115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lE0h923NoKk15/QsPZdut8ARp6zLfAFkgoa9rjgCwZY=;
 b=oOj4XhmkNBG0Fra/WOqarJYl8o4BIdaStaa8dMwSL1Uw6qpTwuE7Ni97vCwOU9vNya
 wMIUi6CyAemSvpp8EThc3h5WoGNC2MgbCaCs26YWZBsoV41FGCMtZ2xNRTQ10qP1CRYh
 BLgLMXMH/7us6Sg03aW/odTrOWLXzm8EpaLutfXBHkpnUA61WD64+OkSSVg00HluX/h6
 NqK4F2nFt9wi2RV2qQny4vCshpqeh/AVUlQYNZtJjXNWH4htLbiut4RWxps+R0S8RvgQ
 NqkuvN6XkwasqgjYjk3DZRNV/D/GbfmDRALGJTvXCTHgeUxdFfVw4hMd2nHIay0ECSMN
 2O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138315; x=1737743115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lE0h923NoKk15/QsPZdut8ARp6zLfAFkgoa9rjgCwZY=;
 b=bipZRKGG7m9CSbJzBk+suIsv/3PmpSGA54OKUDgZbzKv419x9p0o7FUClE5B+Evaws
 xeZ2m7HB1cOmj9RsRn+NWnobeijcDyZPVAatcdCZ70ho5csmUSf4hZQT+GWjIq2zGEhN
 gbpM8hm6DKWHaMWJUF5UzpDXA5DMqMr3FS+Xbd+V7trgos0hJTBRIrnhRsXFZqZMMdFd
 3zSCcGC7kIyex5AdrDbIGG6HcWgo+QHm0gpe2zKzsUhvJUNIYynGdPcvMtgCzkkU/Vy6
 DWra5GKZyn/nk6CRsjtIvp9/yQfoqN+5Wv5K9XjJsJplV3LC1jh+q2gSr8AMAgyB9tr+
 TZZw==
X-Gm-Message-State: AOJu0YyznSyrfquY5gjran3oiPIXqBnP26c5dYigrkSKnIXXyuuDa+0i
 3fgF59OJAaBGHTIVqDuzEWjXLBTdNCAsZBnHF44nokDqc/MQxMRPrSi3uDkdNwYy/PI64371G31
 A
X-Gm-Gg: ASbGncvvJjaRphvBuThpqOiRP/2Sluhj77iZFN4fpvCUDl1tx3WNlZtG6IkUR6qRPTQ
 gX3hduRURzspqHK12+en3DtOotzRzV87d0tIviKfUVAgTIoLutno5BCSnA5QFzEeYfjRrnVOMBy
 v3FHPKzOwrvOH4sgCsguGkDYsVtgacSD62hUpwotB/43n9bcG1VgRe6YLVWZmkxFJE8f6QGw/5t
 hwVRNPfTHEGJWlRIzqyxhosST3SJDOtsZXEnU3hoNX8IWcCPHXzcQKB7/Ih0FHSEzNtuI1OF6/G
 QNJvToU0DVihcDw=
X-Google-Smtp-Source: AGHT+IFSzXtgnG+7ZWFk4SjbEHTBPzVt6Vvke0KNH55mcSuEdfKW88K7IQox+z/Q12ORLGPasKRjeQ==
X-Received: by 2002:a17:902:e810:b0:215:a412:4f12 with SMTP id
 d9443c01a7336-21c355bfa7cmr53360625ad.33.1737138314806; 
 Fri, 17 Jan 2025 10:25:14 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/68] tcg/i386: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Fri, 17 Jan 2025 10:24:11 -0800
Message-ID: <20250117182456.2077110-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250108215156.8731-6-philmd@linaro.org>
---
 tcg/i386/tcg-target-has.h | 139 ++++++++++++++++++++++++++++++++++++++
 tcg/i386/tcg-target.h     | 129 +----------------------------------
 2 files changed, 140 insertions(+), 128 deletions(-)
 create mode 100644 tcg/i386/tcg-target-has.h

diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
new file mode 100644
index 0000000000..3ea2eab807
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
index 9961d8e757..a1dfdeb28d 100644
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
2.43.0


