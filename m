Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FADE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdyx-0001dW-VG; Wed, 08 Jan 2025 16:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyv-0001UC-QK
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:53 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyu-00044i-02
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:53 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43626213fffso8827985e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373170; x=1736977970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+z1jZmutXk7OoIDZIAMUy/XHUDd/igyf40XyyQ5ntQ=;
 b=lTJGWix3naqft3uApD4YsL+RAzgT6oab85DX8OPlW0mz/c/6q29jJgMknwUg2jDgxP
 um/AiZjvM0oAJdi9UOyPTWA7dd0J1hmZ8Jg2nDDuR5gK4EewIjMqkev8cSyYZNiVIkBi
 LLiISG8HW3Jf+xN8keuApEfqCY0LYZwn9AjACwvxxO6V/YK4gxdgenSWqRu1xmQ8hGU4
 0FfqzaotoGiDO+uN2cIxI1rQ8q/MRT2tcx8gvM4vtxHldsZ9SBEgTh8+AMz25N/DCSHF
 L0yh7ej9PII38GGGbjZbgzID3/e9Cg1qNyTxSIECwFRZLaXAT28HrTVdbUtkZFaLdeI5
 ilRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373170; x=1736977970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+z1jZmutXk7OoIDZIAMUy/XHUDd/igyf40XyyQ5ntQ=;
 b=U6HafCzPHYbxbfeoeNhcyAFZ5Xo4+VGROvvXQjQ1qC4Pe6hmW+1SCQLPlAn2zTBnLx
 ss8C3uNLPEYQ+m5ZlG51VSwnLj1X9inaugy9C2yUOK0kL3cWPLLxEYzzRJU7teYpXC+X
 DdiJRfhhXFomrttsyCXrlpkQhXRCPglMZVM2qf2ng1vA047NFPFzVsnIwX/zQZS8aRUZ
 PND5FNlIV8l/6pQ1riTQ/WuoQbW+gbVRhtI7l85qYRpi/t4/W2y7KEJpdU7WK1TAF/hN
 V66QYSXOtoq507fuAadhKmuY4cVN2F14IpmNqYXdFNKAyHZqY/h/DOE2AIrEek/10kWy
 mdwA==
X-Gm-Message-State: AOJu0YwB0YFyuCKlmCvrlmEYokZLekBM5ZfjxYAywxVuM3i52DkkhZS/
 6jUqopFlA5CZY9ODE2Cy/AO5fGHz7oN6cuETWmHMmoPbj+KnaFV+mZUJoeIIAlhcxhXO/PtHWAl
 8DgQ=
X-Gm-Gg: ASbGnctwB88xp7rartJYaw88v5aiBRb6uOhaZ6WZol2XEc++oIiZsZzCtUC8Z1/gupA
 uU8knopYV3ZHehBLyt+kE1t3vIrnF2EFbRGwb4poRdOntvF4U5hLLv3vUre0IWhWbQkkM90Bznk
 prEBxngSyo7oI/Vuj2J80dtogrYqbd5pWKM9eYeDY+D0fRoJKA69EaUKDP/TyrRsAVH7/ZJWY13
 wBkaD9ede73jrHZaVV8wwRmG6RXKqxcIIx2WD4DVnEHr+r/PoyFJUr+uoj3OpjrwR3xBgPr0j/s
 Pmw1bNnyPKOu+zRU5V0L2/gcwI5P4o8=
X-Google-Smtp-Source: AGHT+IFvC0dKcNC0cPzmCsrTjxmSYIgKSgh8lZPmLo41O5FpcthD+lrlz4cszfuHoevDkqPvoSQUCw==
X-Received: by 2002:a05:6000:1547:b0:386:34af:9bae with SMTP id
 ffacd0b85a97d-38a8b0b7fd0mr712034f8f.4.1736373169963; 
 Wed, 08 Jan 2025 13:52:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3834a6sm7614f8f.28.2025.01.08.13.52.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/14] tcg/sparc64: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Wed,  8 Jan 2025 22:51:52 +0100
Message-ID: <20250108215156.8731-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 tcg/sparc64/tcg-target-has.h | 86 ++++++++++++++++++++++++++++++++++++
 tcg/sparc64/tcg-target.h     | 78 +-------------------------------
 2 files changed, 88 insertions(+), 76 deletions(-)
 create mode 100644 tcg/sparc64/tcg-target-has.h

diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
new file mode 100644
index 00000000000..d9ca14cc3d4
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
index b560d43ed54..14621446312 100644
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
2.47.1


