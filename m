Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032C3E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdyk-0000OX-FU; Wed, 08 Jan 2025 16:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyi-0000Hw-Mh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:40 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyf-000434-Ej
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:40 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso135505f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373151; x=1736977951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhNLLMwi6Cebqx2oq1pwIo7rhsmfrdmF/Yz25JdLB8o=;
 b=zts8OzFi00nFa53uIDgsvvlG5IWrD9ke3rCviJ7N6Vw+pCZk40qjvlKCZajTR5EXB/
 dBG99tWudFFNEWnIY0fbHzcRwAjbfEPCZ09fjepnyVQmrq4Z9DeyyNHmJ1m8DxVFSbww
 Qo9OrlKxvhwBIwmuRr/Nhm0GNswM5F0m5ZFLihkMSxiU9SdxIpwN8dt14D2kshht3ywP
 bPZo+achqYMzwsmFCnWbznXu3H80bbYrSlKxNatrYzmMqhKk+O90d0tlhFsJPJg1us/v
 vRcPRJYc69rqeB6gXY8yZXUmnCmy++GKW0CzhYduqThZE3ESi5kOGt/IO0uyXDOaVRG3
 uciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373151; x=1736977951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mhNLLMwi6Cebqx2oq1pwIo7rhsmfrdmF/Yz25JdLB8o=;
 b=p0sLtumWN9k1XkwrIHeYusF0T7xpX4/PTr65nQ2Rcq+9f7hRM6tgBG9AqMlnQy74JR
 Owrw8uk32iRhiqvDrYbaf7yCICz3jZkTwcU4dEZDL7bAu/DNAmPkuNHT/s9TDivtrZ3F
 08nEhui5u2knmVgAz3Ms57ywN354ocUBmzbq8SQ5eOBQv6yiDHQoiiwW5YCganOWv4m3
 fXMnCvQl4vlVqeRc9iOPm8chXOFCZ34euyxsbbels9fZt+stWByywIV6L0L7JnvbD3pG
 UpAh1oOxztSxaGKyrycITahMC845ouhaZmE6QE2LgkozWOWnTpeOAELeZftG3flpx4XF
 YJtw==
X-Gm-Message-State: AOJu0Yz5c1XRVv7+uDLfJ7pZ8PqXCU3ddnwP8C9P6a/90QkEnmnEc6He
 b62y/x0Bkvl9J1W9AkC2QP5eG7ZTb/3SyJ2w5ARM2vtOqmIVtz9yYZcsAhNRMn5mpZt28qgpVzd
 8ies=
X-Gm-Gg: ASbGncvTPXYbgZw3oZKzOakfw/V0WQHFnXLv+SboVZAHCOagW+5SO19BvMonwl0BS82
 i1aH6JyaUlN7w1dFMqYX+yJtHRZx4/6FJ6nWM53WffgEn5YZ1uo+faZcUtCU53uYmA+PzdOW0N4
 h16RTbJn6xnoNChVtsPBqSezQaObTV1xUGZmtEtIgDWhdwwcxoMZmg1W3JIpjOpX7nS3AUtQXim
 9I0Ahh5dHdN+iWEs0pDVwjueLMfNJhNhwaASvI1gDWEdHXVgPlcNJsFHQRNVmloOSkfOCmPp/VG
 QKiHycQFYa1OrZLGXSvyvRvNCgDhDLk=
X-Google-Smtp-Source: AGHT+IFvH8G/ygEL2xC+w4pWsLdYPCr573mLVUE6BDSZCgcvrVGdVF/3mdihwRaEACDeqivf6/HVsw==
X-Received: by 2002:a05:6000:4012:b0:388:e2a7:74c8 with SMTP id
 ffacd0b85a97d-38a87308b75mr3411442f8f.44.1736373151448; 
 Wed, 08 Jan 2025 13:52:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da6336sm33756405e9.8.2025.01.08.13.52.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/14] tcg/mips: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Wed,  8 Jan 2025 22:51:48 +0100
Message-ID: <20250108215156.8731-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
 tcg/mips/tcg-target-has.h | 122 ++++++++++++++++++++++++++++++++++++++
 tcg/mips/tcg-target.h     | 112 +---------------------------------
 2 files changed, 123 insertions(+), 111 deletions(-)
 create mode 100644 tcg/mips/tcg-target-has.h

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
new file mode 100644
index 00000000000..5dbc63cef6d
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
index db60eb7c1b7..a34765b3894 100644
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
2.47.1


