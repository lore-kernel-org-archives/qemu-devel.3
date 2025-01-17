Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355B4C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr24-00048c-5r; Fri, 17 Jan 2025 13:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr21-000478-1M
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:21 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1y-0007sz-R0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:20 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2166f1e589cso61672665ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138316; x=1737743116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tRgoyvnnwIMvgwZ53Tf5jvPHSFGXWCXDFVkQ4d9r+w=;
 b=WDvwlQJe3Tn6yN3hghlp5jT/srHetJIsr/pcmD0rMEEwNpbYoAuxqpUUmMvv1nzY8H
 8Y6hp7XY+vXqNd5M+y5uyNHYVfioSgsLm00Wj1Kiq4zsmNar3N7LzHh/HfxHjjCpoaWZ
 R4vZlgSkkNCJ5D8YVtHy4U/G9OZhPsDs43gWo63Ur8X1MrZt6elsSI+Tk+9O/u0B5uRQ
 d2wjGOlT5mimzvI7tvNJOFsL0dkDNmut4JBIiBueKch42V4qKo34sm2XiyrMwbUjfvD0
 4BVeRK5ZJaOlpVyoFmYW3fVik49s1hS5xJ6JHXxhwbvGxuqTVbMdhdLt2XUzqgh+PQZf
 0LfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138316; x=1737743116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tRgoyvnnwIMvgwZ53Tf5jvPHSFGXWCXDFVkQ4d9r+w=;
 b=PAn11VdvqLcworKZVQTkfJYi7vCjX2h08Nf6uqFyllRqF4Mfy+JAS2T2GripShtbD6
 STP4G6Xzm3XedFCHpF7I5yNuXxmpVhS3AUDA5uedChwLqW7RUHoRaE70+fwdVGMeqsdI
 v0yWCvGbliwpy/+6v+rH7UPTu/27GH2KZYXzKl9ZgQAv3Hq9o4sU3SCB5Tx3OVIaDGhO
 P55OiOpzY9U4pQv0glnHw9gYRMq1HryIKHDvbVrn357LDgtY3HSgHbZwXYlQCvd1jLct
 T4ItDgqexNEH0PLHRKsURldBY0BxMCx52LVvBoyFwQbtIV57wRtvQ2xaLPWjX2rp7Iqc
 cP+w==
X-Gm-Message-State: AOJu0YyQIkUv4xMivS0L9jdoFRNAK/5j9kIfEuIhVTn4csJhRaEBg3aR
 NImdFvN5/WIqEgBc49b5sfYbtPDXcJI0rCqhgv5bixW8J64DnJi+/p8IRdb6iD2sFwK8sFymDtG
 V
X-Gm-Gg: ASbGncsemHE043PSeyM+2apoGlbEfDlJGYYL6A8Fx1wF2NbLwbT/i0+FZ4UazDmL5XA
 6GVDMmKgcgduEEo+jLyV7+mQV8OqCQ1ER1EmbpEiU2C5fZZPG62VbOEmYSCjY03xpH6Lqyu4BEu
 guJnWsIaWOJ/qMdY910Lt1VBH4o3l6bF0E5OKJN0EI6t1T3P0rqxNLDDdB4/yy+h/DZMxGMGRxA
 blW4viiCYk0vrJddmSRD1So0BDyxtmRuRDHZpuGTmZCkKZ+iF1PSdVm/smvfT+NmvtZ/I+ri3ZA
 Gnnyljc1/7zVOMs=
X-Google-Smtp-Source: AGHT+IFojYQMKyIccT/9U29l4j3LM1K3z8COX/eCI5WDCTTBV029ExznDfj9CZtUz2YH2IPwc8hU+w==
X-Received: by 2002:a17:902:e948:b0:215:6f9b:e447 with SMTP id
 d9443c01a7336-21c35621db7mr49816845ad.30.1737138316396; 
 Fri, 17 Jan 2025 10:25:16 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/68] tcg/mips: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Fri, 17 Jan 2025 10:24:13 -0800
Message-ID: <20250117182456.2077110-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
Message-ID: <20250108215156.8731-8-philmd@linaro.org>
---
 tcg/mips/tcg-target-has.h | 122 ++++++++++++++++++++++++++++++++++++++
 tcg/mips/tcg-target.h     | 112 +---------------------------------
 2 files changed, 123 insertions(+), 111 deletions(-)
 create mode 100644 tcg/mips/tcg-target-has.h

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
new file mode 100644
index 0000000000..5dbc63cef6
--- /dev/null
+++ b/tcg/mips/tcg-target-has.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2008-2009 Arnaud Patard <arnaud.patard@rtp-net.org>
+ * Copyright (c) 2009 Aurelien Jarno <aurelien@aurel32.net>
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+/* MOVN/MOVZ instructions detection */
+#if (defined(__mips_isa_rev) && (__mips_isa_rev >= 1)) || \
+    defined(_MIPS_ARCH_LOONGSON2E) || defined(_MIPS_ARCH_LOONGSON2F) || \
+    defined(_MIPS_ARCH_MIPS4)
+#define use_movnz_instructions  1
+#else
+extern bool use_movnz_instructions;
+#endif
+
+/* MIPS32 instruction set detection */
+#if defined(__mips_isa_rev) && (__mips_isa_rev >= 1)
+#define use_mips32_instructions  1
+#else
+extern bool use_mips32_instructions;
+#endif
+
+/* MIPS32R2 instruction set detection */
+#if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
+#define use_mips32r2_instructions  1
+#else
+extern bool use_mips32r2_instructions;
+#endif
+
+/* MIPS32R6 instruction set detection */
+#if defined(__mips_isa_rev) && (__mips_isa_rev >= 6)
+#define use_mips32r6_instructions  1
+#else
+#define use_mips32r6_instructions  0
+#endif
+
+/* optional instructions */
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          1
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_nor_i32          1
+#define TCG_TARGET_HAS_andc_i32         0
+#define TCG_TARGET_HAS_orc_i32          0
+#define TCG_TARGET_HAS_eqv_i32          0
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
+#define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
+#define TCG_TARGET_HAS_muluh_i32        1
+#define TCG_TARGET_HAS_mulsh_i32        1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_negsetcond_i32   0
+
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
+#define TCG_TARGET_HAS_extr_i64_i32     1
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
+#define TCG_TARGET_HAS_not_i64          1
+#define TCG_TARGET_HAS_nor_i64          1
+#define TCG_TARGET_HAS_andc_i64         0
+#define TCG_TARGET_HAS_orc_i64          0
+#define TCG_TARGET_HAS_eqv_i64          0
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
+#define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
+#define TCG_TARGET_HAS_muls2_i64        (!use_mips32r6_instructions)
+#define TCG_TARGET_HAS_muluh_i64        1
+#define TCG_TARGET_HAS_mulsh_i64        1
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext32u_i64       1
+#define TCG_TARGET_HAS_negsetcond_i64   0
+#endif
+
+/* optional instructions detected at runtime */
+#define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
+#define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
+#define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
+#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
+#define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
+#define TCG_TARGET_HAS_rot_i32          use_mips32r2_instructions
+#define TCG_TARGET_HAS_clz_i32          use_mips32r2_instructions
+#define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_TARGET_HAS_bswap16_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_bswap32_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_bswap64_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_extract_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
+#define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
+#define TCG_TARGET_HAS_rot_i64          use_mips32r2_instructions
+#define TCG_TARGET_HAS_clz_i64          use_mips32r2_instructions
+#define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_ctpop_i64        0
+#endif
+
+/* optional instructions automatically implemented */
+#define TCG_TARGET_HAS_ext8u_i32        0 /* andi rt, rs, 0xff   */
+#define TCG_TARGET_HAS_ext16u_i32       0 /* andi rt, rs, 0xffff */
+
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_TARGET_HAS_ext8u_i64        0 /* andi rt, rs, 0xff   */
+#define TCG_TARGET_HAS_ext16u_i64       0 /* andi rt, rs, 0xffff */
+#endif
+
+#define TCG_TARGET_HAS_qemu_ldst_i128   0
+#define TCG_TARGET_HAS_tst              0
+
+#endif
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index db60eb7c1b..a34765b389 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -70,117 +70,7 @@ typedef enum {
     TCG_AREG0 = TCG_REG_S8,
 } TCGReg;
 
-/* MOVN/MOVZ instructions detection */
-#if (defined(__mips_isa_rev) && (__mips_isa_rev >= 1)) || \
-    defined(_MIPS_ARCH_LOONGSON2E) || defined(_MIPS_ARCH_LOONGSON2F) || \
-    defined(_MIPS_ARCH_MIPS4)
-#define use_movnz_instructions  1
-#else
-extern bool use_movnz_instructions;
-#endif
-
-/* MIPS32 instruction set detection */
-#if defined(__mips_isa_rev) && (__mips_isa_rev >= 1)
-#define use_mips32_instructions  1
-#else
-extern bool use_mips32_instructions;
-#endif
-
-/* MIPS32R2 instruction set detection */
-#if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
-#define use_mips32r2_instructions  1
-#else
-extern bool use_mips32r2_instructions;
-#endif
-
-/* MIPS32R6 instruction set detection */
-#if defined(__mips_isa_rev) && (__mips_isa_rev >= 6)
-#define use_mips32r6_instructions  1
-#else
-#define use_mips32r6_instructions  0
-#endif
-
-/* optional instructions */
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_andc_i32         0
-#define TCG_TARGET_HAS_orc_i32          0
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muluh_i32        1
-#define TCG_TARGET_HAS_mulsh_i32        1
-#define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_negsetcond_i32   0
-
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
-#define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_nor_i64          1
-#define TCG_TARGET_HAS_andc_i64         0
-#define TCG_TARGET_HAS_orc_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-#define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muls2_i64        (!use_mips32r6_instructions)
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_negsetcond_i64   0
-#endif
-
-/* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_sextract_i32     0
-#define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
-#define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
-#define TCG_TARGET_HAS_rot_i32          use_mips32r2_instructions
-#define TCG_TARGET_HAS_clz_i32          use_mips32r2_instructions
-#define TCG_TARGET_HAS_ctz_i32          0
-#define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_bswap16_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_bswap32_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_bswap64_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
-#define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
-#define TCG_TARGET_HAS_rot_i64          use_mips32r2_instructions
-#define TCG_TARGET_HAS_clz_i64          use_mips32r2_instructions
-#define TCG_TARGET_HAS_ctz_i64          0
-#define TCG_TARGET_HAS_ctpop_i64        0
-#endif
-
-/* optional instructions automatically implemented */
-#define TCG_TARGET_HAS_ext8u_i32        0 /* andi rt, rs, 0xff   */
-#define TCG_TARGET_HAS_ext16u_i32       0 /* andi rt, rs, 0xffff */
-
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_ext8u_i64        0 /* andi rt, rs, 0xff   */
-#define TCG_TARGET_HAS_ext16u_i64       0 /* andi rt, rs, 0xffff */
-#endif
-
-#define TCG_TARGET_HAS_qemu_ldst_i128   0
-
-#define TCG_TARGET_HAS_tst              0
+#include "tcg-target-has.h"
 
 #define TCG_TARGET_DEFAULT_MO           0
 
-- 
2.43.0


