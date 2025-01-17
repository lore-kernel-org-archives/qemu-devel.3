Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20660C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr2L-0004Bz-NB; Fri, 17 Jan 2025 13:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr24-00048t-B9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:24 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr21-0007tm-TS
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:24 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2163b0c09afso49198105ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138319; x=1737743119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Olp2IikocotZkCcicaB2gg9bPyZ2s29wbBM/SVUjWt0=;
 b=tKCvkgAMOp7OvdOvwmh33xjZLJIKqnaMC30dHqXClmW1SANE1XdJV1imUTqtLF12BL
 Lac4YozM+7brLXyfrypYOvW1N4vkvPArikReFEs/D9XAm1z0/GdbETCl7BjmFqDUblyg
 k4V0jbxdfpsq0Yj5l4gSkKvcBwYQM1VIxPWQR/y9Fnv9vLxYs9TjYjjJlgq3Qx+ZYrBC
 3RonZr2VWfAVr9vxHcAFlk3lgf/xvzIQ4UTlrPOxLON3Z61bTUgMGN2NLr8KQo46qwUl
 Zp3gFTlYTegWlf2Bfx5Q5Q8J+3SHQdak1/Nme2RcDeBRODn28FmMPvJaDI6/MK5L16rV
 +Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138319; x=1737743119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Olp2IikocotZkCcicaB2gg9bPyZ2s29wbBM/SVUjWt0=;
 b=kievKzJy3ojLH601FeMbHi6nNDXVSLrJQlCYZR0PcR2VaaLpsFztCU/RDfwTd98MQ9
 QXm5Dq1K1TtmjMzg1Wcuq9EXrTgIs9PA8+phIYmAVpjrll+BkBnCg9B/irYR/QcX06mZ
 wP6VXCjtJS1XAQxL6cg/fogjbw5B5wjpjurMBhd1bAkIeQ490nFXLCOaVQDdvpKIWnxr
 /ndhp9mNxiz8uXFnpm3hLN7c/93tvMMwEPQLOLCSCBJZWXf2Cdjz4frYgLyXRjZnva+e
 0cJvioSHlXFttHXjofmYzFURIc/UaI/+5gY35TAidupYCnsetHZOB4EY5qw2GdzazZOl
 sWPw==
X-Gm-Message-State: AOJu0YzIY/M3s/GamjQ1dxkj8ZfprCd2OUSiC0e8CJKc+p9Vd4Id0OXP
 qByMkirzk2GG7pZ0/Id3GI9xICjecgEMHmiHXc1ZQMXhYEzDYOZw0K8/Vfb+xZNxCwbBmyvnSWP
 L
X-Gm-Gg: ASbGncvwZwJpFVDjoyw1ohz6BsQ+D3tHt4j3Wb4zPAPaj/fSnxaiNRtcMnjx49FwH6P
 RA8Lnhz7JBbbAY73u3dqgwcVPzXb9r/seNGViL2YUMoqFYTWlPh3c3EJZyoqHPjkn8lkxkhx9l2
 BOKdFAJanZCijhvAKG/2aLZbtfrxh43qmPLMMZWN6QhhyMJa4knrT5OFU3RauXy1QU/SVoPllbR
 eYsecmiBx7/e95zp92oyveOKRkwa1ZDb1XEOBX0rBzDSNhnWbcN32eTCSFOCQB/yUu2p5I8O/lV
 qTnm6RCcPyrdx8s=
X-Google-Smtp-Source: AGHT+IEJ9CE14oZualMWqXrqrn/X7Bf/3boc3cOV7x4rKlcfLNuIbzfvkOxvWaL99E9cFSWzoVgwbg==
X-Received: by 2002:a17:902:cec3:b0:21a:7cbe:3a9a with SMTP id
 d9443c01a7336-21c353ee9cfmr56365985ad.14.1737138319517; 
 Fri, 17 Jan 2025 10:25:19 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/68] tcg/sparc64: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Fri, 17 Jan 2025 10:24:17 -0800
Message-ID: <20250117182456.2077110-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250108215156.8731-12-philmd@linaro.org>
---
 tcg/sparc64/tcg-target-has.h | 86 ++++++++++++++++++++++++++++++++++++
 tcg/sparc64/tcg-target.h     | 78 +-------------------------------
 2 files changed, 88 insertions(+), 76 deletions(-)
 create mode 100644 tcg/sparc64/tcg-target-has.h

diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
new file mode 100644
index 0000000000..d9ca14cc3d
--- /dev/null
+++ b/tcg/sparc64/tcg-target-has.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#if defined(__VIS__) && __VIS__ >= 0x300
+#define use_vis3_instructions  1
+#else
+extern bool use_vis3_instructions;
+#endif
+
+/* optional instructions */
+#define TCG_TARGET_HAS_div_i32		1
+#define TCG_TARGET_HAS_rem_i32		0
+#define TCG_TARGET_HAS_rot_i32          0
+#define TCG_TARGET_HAS_ext8s_i32        0
+#define TCG_TARGET_HAS_ext16s_i32       0
+#define TCG_TARGET_HAS_ext8u_i32        0
+#define TCG_TARGET_HAS_ext16u_i32       0
+#define TCG_TARGET_HAS_bswap16_i32      0
+#define TCG_TARGET_HAS_bswap32_i32      0
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_andc_i32         1
+#define TCG_TARGET_HAS_orc_i32          1
+#define TCG_TARGET_HAS_eqv_i32          0
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_nor_i32          0
+#define TCG_TARGET_HAS_clz_i32          0
+#define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_deposit_i32      0
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_negsetcond_i32   1
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_mulu2_i32        1
+#define TCG_TARGET_HAS_muls2_i32        1
+#define TCG_TARGET_HAS_muluh_i32        0
+#define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+
+#define TCG_TARGET_HAS_extr_i64_i32     0
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          0
+#define TCG_TARGET_HAS_rot_i64          0
+#define TCG_TARGET_HAS_ext8s_i64        0
+#define TCG_TARGET_HAS_ext16s_i64       0
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext8u_i64        0
+#define TCG_TARGET_HAS_ext16u_i64       0
+#define TCG_TARGET_HAS_ext32u_i64       1
+#define TCG_TARGET_HAS_bswap16_i64      0
+#define TCG_TARGET_HAS_bswap32_i64      0
+#define TCG_TARGET_HAS_bswap64_i64      0
+#define TCG_TARGET_HAS_not_i64          1
+#define TCG_TARGET_HAS_andc_i64         1
+#define TCG_TARGET_HAS_orc_i64          1
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
+#define TCG_TARGET_HAS_negsetcond_i64   1
+#define TCG_TARGET_HAS_add2_i64         1
+#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        use_vis3_instructions
+#define TCG_TARGET_HAS_mulsh_i64        0
+
+#define TCG_TARGET_HAS_qemu_ldst_i128   0
+
+#define TCG_TARGET_HAS_tst              1
+
+#endif
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index b560d43ed5..1462144631 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -64,84 +64,10 @@ typedef enum {
     TCG_REG_I7,
 } TCGReg;
 
-#if defined(__VIS__) && __VIS__ >= 0x300
-#define use_vis3_instructions  1
-#else
-extern bool use_vis3_instructions;
-#endif
-
-/* optional instructions */
-#define TCG_TARGET_HAS_div_i32		1
-#define TCG_TARGET_HAS_rem_i32		0
-#define TCG_TARGET_HAS_rot_i32          0
-#define TCG_TARGET_HAS_ext8s_i32        0
-#define TCG_TARGET_HAS_ext16s_i32       0
-#define TCG_TARGET_HAS_ext8u_i32        0
-#define TCG_TARGET_HAS_ext16u_i32       0
-#define TCG_TARGET_HAS_bswap16_i32      0
-#define TCG_TARGET_HAS_bswap32_i32      0
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          1
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          0
-#define TCG_TARGET_HAS_ctz_i32          0
-#define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
-#define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        1
-#define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          0
-#define TCG_TARGET_HAS_rot_i64          0
-#define TCG_TARGET_HAS_ext8s_i64        0
-#define TCG_TARGET_HAS_ext16s_i64       0
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      0
-#define TCG_TARGET_HAS_bswap32_i64      0
-#define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_orc_i64          1
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
-#define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        use_vis3_instructions
-#define TCG_TARGET_HAS_mulsh_i64        0
-
-#define TCG_TARGET_HAS_qemu_ldst_i128   0
-
-#define TCG_TARGET_HAS_tst              1
-
 #define TCG_AREG0 TCG_REG_I0
 
+#include "tcg-target-has.h"
+
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif
-- 
2.43.0


