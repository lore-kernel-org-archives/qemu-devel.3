Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9306CC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr21-00047b-Cq; Fri, 17 Jan 2025 13:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1x-000448-HS
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:17 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1v-0007sT-K2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:17 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166022c5caso43157515ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138314; x=1737743114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOSic346AHlhuVEPNh01g7q+WJfoUtr9PY21Tvlp0tM=;
 b=eyvTq1UH4FerUJqZjeTbukml+wY2jmRmlH+8YHL96a3HpNCBe5tk0jAfuqBbstHMcS
 9sT2E4XP1H6UOIHsUm08zw2tI7AkIYoBdZAC6kz9SmW+76teuiaUnZSPyX+54sH4iTbW
 0FQQTwgT26Jxr5/g3RMDAnncDSvOOB+XROZEdh6doLWPRnaEfzKPW2ZUzrYuJqDBmP42
 HOOInkbVqooM5rpguLU/nYCZ4/nJEwogpeBBXW1rFcwxK0Ai3vNGazXi5Dnyp+m23EiE
 GwE/UW7XyvoOJoM/m3wE/vREla31ffrbd/1xUIt5MqpEd3W08G8uKbO+xA/Mwe5qRDde
 WAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138314; x=1737743114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOSic346AHlhuVEPNh01g7q+WJfoUtr9PY21Tvlp0tM=;
 b=MtX2hZIwCU56/QB97WSZm4twJiypov3DSYqEfp9Nm4/lCAs7gEFojhVRpv72MqOJD6
 AJNG/zIqJAgq7PMS62RagQvykFhWgYbU3XPbe7fI3NiAtLr2Y4eNe9UoACTtUpVLyoLi
 Ub7faRdEKdEylYBSUaHLzz2aF2TkkzFBymcsFaxtE5Pd0X6RCpGYnItjuabrEOK/ilqM
 2Ynje8EOH2eiJ6F7A/z0qBwIF5+tnp0NGkSjyKHGhCttBczR+lkIKYqTMgFW1i0hNMOA
 YzBDjvIejQ3tLjePD/G/C+bz5ID3bd5qnsQefAzLE0bFeBNEGjoY3KF4vkEt7zEpAew9
 AFzA==
X-Gm-Message-State: AOJu0YyxlGpFpVQ4cfoFqR8MD33nCcX5Sjel0ojjBBSWcr6TSUZkUl3N
 CzlCPfBvXDGDCBRRgiye5rvxg68n9D3vyk7yXK6VyQQfyabTYR4YEo7nq6bFZ3sTp2+hfjP21IB
 r
X-Gm-Gg: ASbGnctEM4q2xSxDQs6lL7zPzuUCOgY7X3CkZYEXi6I4TyNtileTiGqq+FhsMB7/PAj
 bkSa1+CeKg3hIhlHaRucPpQK2MJdjhbfluCL/bJ82LcbhV4ei+aR5mtnG0xU2IxxeGvPuw5Zvqh
 ixSrAOWv0813PKO2Of516KNcBusxbgpqcDAO8tSOkEZUor3bXdOrTTkPeUIcoBhlbY3Idp5WX5+
 wnRpG+4sC4cMJR645rmCt+fs5UJYkGq/TXjS3fzDaNFVVUYPuG55t4ktLnQJA1nPp3u/N/y4oye
 LsxoJ7a6e8tRzLU=
X-Google-Smtp-Source: AGHT+IFyMjLoVlUoFqeP39e4dKFqWdd7ANAcBLQiUl/hKL+D2LrGf8b7pMCNAG+8n6oYlVvPd4aIIA==
X-Received: by 2002:a17:902:f105:b0:216:7c33:8994 with SMTP id
 d9443c01a7336-21c3561fef9mr40007565ad.53.1737138314049; 
 Fri, 17 Jan 2025 10:25:14 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/68] tcg/arm: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Fri, 17 Jan 2025 10:24:10 -0800
Message-ID: <20250117182456.2077110-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
Message-ID: <20250108215156.8731-5-philmd@linaro.org>
---
 tcg/arm/tcg-target-has.h | 85 ++++++++++++++++++++++++++++++++++++++++
 tcg/arm/tcg-target.h     | 74 +---------------------------------
 2 files changed, 86 insertions(+), 73 deletions(-)
 create mode 100644 tcg/arm/tcg-target-has.h

diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
new file mode 100644
index 0000000000..316185500d
--- /dev/null
+++ b/tcg/arm/tcg-target-has.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2008 Fabrice Bellard
+ * Copyright (c) 2008 Andrzej Zaborowski
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+extern int arm_arch;
+
+#define use_armv7_instructions  (__ARM_ARCH >= 7 || arm_arch >= 7)
+
+#ifdef __ARM_ARCH_EXT_IDIV__
+#define use_idiv_instructions  1
+#else
+extern bool use_idiv_instructions;
+#endif
+#ifdef __ARM_NEON__
+#define use_neon_instructions  1
+#else
+extern bool use_neon_instructions;
+#endif
+
+/* optional instructions */
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_bswap16_i32      1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_rot_i32          1
+#define TCG_TARGET_HAS_andc_i32         1
+#define TCG_TARGET_HAS_orc_i32          0
+#define TCG_TARGET_HAS_eqv_i32          0
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_nor_i32          0
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
+#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
+#define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
+#define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
+#define TCG_TARGET_HAS_extract2_i32     1
+#define TCG_TARGET_HAS_negsetcond_i32   1
+#define TCG_TARGET_HAS_mulu2_i32        1
+#define TCG_TARGET_HAS_muls2_i32        1
+#define TCG_TARGET_HAS_muluh_i32        0
+#define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_div_i32          use_idiv_instructions
+#define TCG_TARGET_HAS_rem_i32          0
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+
+#define TCG_TARGET_HAS_qemu_ldst_i128   0
+
+#define TCG_TARGET_HAS_tst              1
+
+#define TCG_TARGET_HAS_v64              use_neon_instructions
+#define TCG_TARGET_HAS_v128             use_neon_instructions
+#define TCG_TARGET_HAS_v256             0
+
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          1
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_not_vec          1
+#define TCG_TARGET_HAS_neg_vec          1
+#define TCG_TARGET_HAS_abs_vec          1
+#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_shi_vec          1
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       1
+#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          1
+
+#endif
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 7f6e24f861..e114f7ddf4 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -26,10 +26,6 @@
 #ifndef ARM_TCG_TARGET_H
 #define ARM_TCG_TARGET_H
 
-extern int arm_arch;
-
-#define use_armv7_instructions  (__ARM_ARCH >= 7 || arm_arch >= 7)
-
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define MAX_CODE_GEN_BUFFER_SIZE  UINT32_MAX
 
@@ -74,75 +70,7 @@ typedef enum {
 
 #define TCG_TARGET_NB_REGS 32
 
-#ifdef __ARM_ARCH_EXT_IDIV__
-#define use_idiv_instructions  1
-#else
-extern bool use_idiv_instructions;
-#endif
-#ifdef __ARM_NEON__
-#define use_neon_instructions  1
-#else
-extern bool use_neon_instructions;
-#endif
-
-/* optional instructions */
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          0
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
-#define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
-#define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_mulu2_i32        1
-#define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_div_i32          use_idiv_instructions
-#define TCG_TARGET_HAS_rem_i32          0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#define TCG_TARGET_HAS_qemu_ldst_i128   0
-
-#define TCG_TARGET_HAS_tst              1
-
-#define TCG_TARGET_HAS_v64              use_neon_instructions
-#define TCG_TARGET_HAS_v128             use_neon_instructions
-#define TCG_TARGET_HAS_v256             0
-
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          1
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
-#define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          1
-#define TCG_TARGET_HAS_abs_vec          1
-#define TCG_TARGET_HAS_roti_vec         0
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
-#define TCG_TARGET_HAS_shi_vec          1
-#define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
-#define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       1
-#define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          1
+#include "tcg-target-has.h"
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
-- 
2.43.0


