Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0ABC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1z-00046W-VM; Fri, 17 Jan 2025 13:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1v-00041P-UT
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:15 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1t-0007ry-MT
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:15 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21675fd60feso55035485ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138312; x=1737743112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlY2d71bd16ZCSa+8arDxoe0WW5txCeM4kb+98ivaDc=;
 b=H2YbNLSr2T6mJA2R1ccZOfZBreeUSWwaUcMHGAyU30PnH/aEWKt2leMRDgQ7Ay5DGo
 LO1DlN+dphDH+jSJVF0UtYbPIGavU95JCx+gi2CkLVyfcM+GwcQgdMlKSKTOMihikw6m
 LNZrCRv7kQRqtw1J/0LLeGkHmi+NWhXAqU9PDHe+daydktvFqH0gNNLaljG37Hyxvhbz
 GPxifLK0G4h28ojoM7WfyB3eKDlGWod6fs5qp5nLXfIR7HZC9ycBmEWDck3sBfHMXrnD
 Kw3y+P5nCB5IMouf83+G52GhvmqZITr4sJqzm+hbjLriqilwFAXR+x6dLQaIgj197RzV
 qDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138312; x=1737743112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BlY2d71bd16ZCSa+8arDxoe0WW5txCeM4kb+98ivaDc=;
 b=iqrNCQmKSpgC4ElIfOKGsHy5r8+8m557PVuJWRDJWOarc3U/57EcowNuSpSp1yr1mf
 KQtOU5A2Bwsy+fRe25hxL1utQqkLBRQVcjl4NFH9X2AZiNUm8OKkF2k4dt2FwZQGgLdd
 4SaaqhZPbVKpffSJ3gTmqO6MJvClpsjdMHj8LNrpoFtn+sgez44oUoepl1Kj3G8v5TFk
 jExOD67fu3j0oscx2/DjoO3dEqrolplCyfX4GY4+vQTAdO1aUaIta8qUVlot/X7bowRV
 qGyfymSvGmNZQLNfnGSLylUBwPa00HV9X3qjPIvkp5WZD9YlN7Z9GDpdd90+zkPWnaP+
 b9kQ==
X-Gm-Message-State: AOJu0YyzXDYenH84jiYsmcVVdlLKCsQNhLfoRKTwbNow/X+40QWuU/Qy
 +nkcKdIqVu0yHISI7MPpBnvA6LVhtdm789mFaFqYrisgBy3iGFawGurF6ZYnC3ai+2aFd6oTZDM
 y
X-Gm-Gg: ASbGncusMp5d3gykL+7qw2NvdNNfDeaL2AuUh2lr+Dx2cW/P8bGqrku/jgDbLEe57k6
 zuBsKlhvuRgdJYj46gxOTEs3+4K+32AYCPHNtqomLrr5FQiOFnMVMntK5OrCBF7vdqJVhG3LhV+
 UKVRrqIr5z+mFtFKcwVxhaauT0DJE57byvIi5WtTkuXFo+DBzT4yZY1FcavOdMSQw2hn3E0J17O
 JQgswijnIg2ckS8aATyOtXjPKwaxKq1SbZ2kJ5r6/BpASwXHH9OolMjXAdWVrbdInZDm3Kuemhx
 tLHWYS4o4pmo5zA=
X-Google-Smtp-Source: AGHT+IFTYDcsgRtXBezxvRnm4PTplUKNmErU1HN7FT5B52He0ydJILH0Rsr/SBl3DP6Ek+e/ZKX0cw==
X-Received: by 2002:a17:903:2284:b0:216:48f4:4f3d with SMTP id
 d9443c01a7336-21c3550e86cmr45603415ad.13.1737138312133; 
 Fri, 17 Jan 2025 10:25:12 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/68] tcg: Extract default TCG_TARGET_HAS_foo definitions to
 'tcg-has.h'
Date: Fri, 17 Jan 2025 10:24:08 -0800
Message-ID: <20250117182456.2077110-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
Message-ID: <20250108215156.8731-3-philmd@linaro.org>
---
 include/tcg/tcg.h | 105 +-----------------------------------------
 tcg/tcg-has.h     | 115 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 104 deletions(-)
 create mode 100644 tcg/tcg-has.h

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index fc379bb122..4352ec012f 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -64,110 +64,7 @@ typedef uint64_t TCGRegSet;
 #error unsupported
 #endif
 
-#if TCG_TARGET_REG_BITS == 32
-/* Turn some undef macros into false macros.  */
-#define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_div_i64          0
-#define TCG_TARGET_HAS_rem_i64          0
-#define TCG_TARGET_HAS_div2_i64         0
-#define TCG_TARGET_HAS_rot_i64          0
-#define TCG_TARGET_HAS_ext8s_i64        0
-#define TCG_TARGET_HAS_ext16s_i64       0
-#define TCG_TARGET_HAS_ext32s_i64       0
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_bswap16_i64      0
-#define TCG_TARGET_HAS_bswap32_i64      0
-#define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_not_i64          0
-#define TCG_TARGET_HAS_andc_i64         0
-#define TCG_TARGET_HAS_orc_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          0
-#define TCG_TARGET_HAS_ctz_i64          0
-#define TCG_TARGET_HAS_ctpop_i64        0
-#define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
-/* Turn some undef macros into true macros.  */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#endif
-
-#ifndef TCG_TARGET_deposit_i32_valid
-#define TCG_TARGET_deposit_i32_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_deposit_i64_valid
-#define TCG_TARGET_deposit_i64_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_extract_i32_valid
-#define TCG_TARGET_extract_i32_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_extract_i64_valid
-#define TCG_TARGET_extract_i64_valid(ofs, len) 1
-#endif
-
-/* Only one of DIV or DIV2 should be defined.  */
-#if defined(TCG_TARGET_HAS_div_i32)
-#define TCG_TARGET_HAS_div2_i32         0
-#elif defined(TCG_TARGET_HAS_div2_i32)
-#define TCG_TARGET_HAS_div_i32          0
-#define TCG_TARGET_HAS_rem_i32          0
-#endif
-#if defined(TCG_TARGET_HAS_div_i64)
-#define TCG_TARGET_HAS_div2_i64         0
-#elif defined(TCG_TARGET_HAS_div2_i64)
-#define TCG_TARGET_HAS_div_i64          0
-#define TCG_TARGET_HAS_rem_i64          0
-#endif
-
-#if !defined(TCG_TARGET_HAS_v64) \
-    && !defined(TCG_TARGET_HAS_v128) \
-    && !defined(TCG_TARGET_HAS_v256)
-#define TCG_TARGET_MAYBE_vec            0
-#define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_neg_vec          0
-#define TCG_TARGET_HAS_not_vec          0
-#define TCG_TARGET_HAS_andc_vec         0
-#define TCG_TARGET_HAS_orc_vec          0
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
-#define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_roti_vec         0
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
-#define TCG_TARGET_HAS_shi_vec          0
-#define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
-#define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_sat_vec          0
-#define TCG_TARGET_HAS_minmax_vec       0
-#define TCG_TARGET_HAS_bitsel_vec       0
-#define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          0
-#else
-#define TCG_TARGET_MAYBE_vec            1
-#endif
-#ifndef TCG_TARGET_HAS_v64
-#define TCG_TARGET_HAS_v64              0
-#endif
-#ifndef TCG_TARGET_HAS_v128
-#define TCG_TARGET_HAS_v128             0
-#endif
-#ifndef TCG_TARGET_HAS_v256
-#define TCG_TARGET_HAS_v256             0
-#endif
+#include "tcg/tcg-has.h"
 
 typedef enum TCGOpcode {
 #define DEF(name, oargs, iargs, cargs, flags) INDEX_op_ ## name,
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
new file mode 100644
index 0000000000..c09ce13389
--- /dev/null
+++ b/tcg/tcg-has.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2024 Linaro, Ltd.
+ */
+
+#ifndef TCG_HAS_H
+#define TCG_HAS_H
+
+#if TCG_TARGET_REG_BITS == 32
+/* Turn some undef macros into false macros.  */
+#define TCG_TARGET_HAS_extr_i64_i32     0
+#define TCG_TARGET_HAS_div_i64          0
+#define TCG_TARGET_HAS_rem_i64          0
+#define TCG_TARGET_HAS_div2_i64         0
+#define TCG_TARGET_HAS_rot_i64          0
+#define TCG_TARGET_HAS_ext8s_i64        0
+#define TCG_TARGET_HAS_ext16s_i64       0
+#define TCG_TARGET_HAS_ext32s_i64       0
+#define TCG_TARGET_HAS_ext8u_i64        0
+#define TCG_TARGET_HAS_ext16u_i64       0
+#define TCG_TARGET_HAS_ext32u_i64       0
+#define TCG_TARGET_HAS_bswap16_i64      0
+#define TCG_TARGET_HAS_bswap32_i64      0
+#define TCG_TARGET_HAS_bswap64_i64      0
+#define TCG_TARGET_HAS_not_i64          0
+#define TCG_TARGET_HAS_andc_i64         0
+#define TCG_TARGET_HAS_orc_i64          0
+#define TCG_TARGET_HAS_eqv_i64          0
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_nor_i64          0
+#define TCG_TARGET_HAS_clz_i64          0
+#define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_ctpop_i64        0
+#define TCG_TARGET_HAS_deposit_i64      0
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        0
+#define TCG_TARGET_HAS_mulsh_i64        0
+/* Turn some undef macros into true macros.  */
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#endif
+
+#ifndef TCG_TARGET_deposit_i32_valid
+#define TCG_TARGET_deposit_i32_valid(ofs, len) 1
+#endif
+#ifndef TCG_TARGET_deposit_i64_valid
+#define TCG_TARGET_deposit_i64_valid(ofs, len) 1
+#endif
+#ifndef TCG_TARGET_extract_i32_valid
+#define TCG_TARGET_extract_i32_valid(ofs, len) 1
+#endif
+#ifndef TCG_TARGET_extract_i64_valid
+#define TCG_TARGET_extract_i64_valid(ofs, len) 1
+#endif
+
+/* Only one of DIV or DIV2 should be defined.  */
+#if defined(TCG_TARGET_HAS_div_i32)
+#define TCG_TARGET_HAS_div2_i32         0
+#elif defined(TCG_TARGET_HAS_div2_i32)
+#define TCG_TARGET_HAS_div_i32          0
+#define TCG_TARGET_HAS_rem_i32          0
+#endif
+#if defined(TCG_TARGET_HAS_div_i64)
+#define TCG_TARGET_HAS_div2_i64         0
+#elif defined(TCG_TARGET_HAS_div2_i64)
+#define TCG_TARGET_HAS_div_i64          0
+#define TCG_TARGET_HAS_rem_i64          0
+#endif
+
+#if !defined(TCG_TARGET_HAS_v64) \
+    && !defined(TCG_TARGET_HAS_v128) \
+    && !defined(TCG_TARGET_HAS_v256)
+#define TCG_TARGET_MAYBE_vec            0
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_andc_vec         0
+#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
+#else
+#define TCG_TARGET_MAYBE_vec            1
+#endif
+#ifndef TCG_TARGET_HAS_v64
+#define TCG_TARGET_HAS_v64              0
+#endif
+#ifndef TCG_TARGET_HAS_v128
+#define TCG_TARGET_HAS_v128             0
+#endif
+#ifndef TCG_TARGET_HAS_v256
+#define TCG_TARGET_HAS_v256             0
+#endif
+
+#endif
-- 
2.43.0


