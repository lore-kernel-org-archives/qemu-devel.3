Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44565E7719B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdz1-0001u8-GZ; Wed, 08 Jan 2025 16:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdz0-0001pA-Tp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:58 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyz-00046H-13
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:58 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so2291345e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373175; x=1736977975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PglmWIQ6EP3DNsd7PARfUW9vAcAZ+ITLQgm4ilFtvBg=;
 b=NGT/xLIR0KEx7Y8el/TAx6pi6HiK+XAmBdAyfi4SSMs8LI4URa3hE2jQa5eVqUh86a
 UfztghlUJ1xdlUyQIMteC8dYgystZId5v2dOlXl5F3X+keu3IFBpYKsOEVv20l8DEZ97
 NnlvofK+hScymoIw9oEeeHBdnftnd8spFSvtfj8RkdXIMmuMhiP1lsNGdDllF2vJgG7b
 ZlFvgbZ9BOkhP+srHtM02mFjocUXqSRqLtg0qTiCV9N4EF41NDCQeBGm2Y3kgquAjr7d
 z9mksOcWXPB7Ja4jHDz47iC8Pb8TUUxiod+SGWrSzuV6vK19Wb7P+q6UzSik1HA1uEcw
 E1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373175; x=1736977975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PglmWIQ6EP3DNsd7PARfUW9vAcAZ+ITLQgm4ilFtvBg=;
 b=rJ+0SoK/7K9LLI9FWkCiWq2p6JhlDBY4/A60WuxItQVZoSvcM+RCIqv7s2+UcRt6/m
 d1kF3+M2/8ADJ38LMDNuK+iwJjKICXlF5Tam8G/gghMcmfHWJMsXfp+M9nCW1e4e19wQ
 u8oHk68MS8ZN4N+9TZHh4LCyBOg+OPyg1k3PwRZ3tZBAjFOTCOQHWVq/LmOdohz/18VC
 EkovBrlQiMsMS05L3hXrIDMo1B2bnptKVemXSAhlahlzGJizPU3pFH8yrcE8mIK0FDgw
 AmLjfcEmob7No7WL9LWGuRamgwjllDpfjwxuBLmDu1XRaW9te/Kp2zO5MLbHUsTHRwLg
 CzPw==
X-Gm-Message-State: AOJu0YyeekVqKehqqW55NgUTd3AsPLWCoR6A06M/YuFFQ13wSYpOYDwV
 L9U4RXnE+OEKFA4iHQsyeJQlTd1Hz0RlygNXfeIEjnyGiPeeHgbcwMma+U2N1zYKdEmQEA08RNZ
 cOCE=
X-Gm-Gg: ASbGncuuqp6wNCnowZZf8kX0M6/3hYkA/9g5a9NA9MPqfDobrOsRsCgHMQCE/OxPj2Z
 7LseISuWAeY0ryu9sbGrP4pf1ytZrWXevyzU0VH2WxoSRvE6/wEU51dFf0tg/cVqQmtkCY/YQmR
 bRAMlBuEbIPATh4V/ZTUDIz4tJITyRUQjmDbuMQeYWB7Us7Et9iZ3QayhaVUIp1bjbns71kapCk
 fDkmhjUdAfLWi2bUChkp0RGNBj5TV8YqEFXLkTrqbMwTYpZc1H+SuX/schQ31iJGWP0UbzHRAVv
 X9kmuVNHqEZMLqYzmuMpUaOeN/IKck4=
X-Google-Smtp-Source: AGHT+IFTb46X50yEqsL8+RjQ0HmqncmsXiEaVukgqDZ53OEAkNlrGqvX24LowYaiPAqfhYJIjG4P8A==
X-Received: by 2002:a5d:64a3:0:b0:388:da2a:e48 with SMTP id
 ffacd0b85a97d-38a872e1554mr3704419f8f.23.1736373175124; 
 Wed, 08 Jan 2025 13:52:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d154sm10142f8f.10.2025.01.08.13.52.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/14] tcg/tci: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Wed,  8 Jan 2025 22:51:53 +0100
Message-ID: <20250108215156.8731-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
 tcg/tci/tcg-target-has.h | 83 ++++++++++++++++++++++++++++++++++++++++
 tcg/tci/tcg-target.h     | 75 +-----------------------------------
 2 files changed, 84 insertions(+), 74 deletions(-)
 create mode 100644 tcg/tci/tcg-target-has.h

diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
new file mode 100644
index 00000000000..33974039102
--- /dev/null
+++ b/tcg/tci/tcg-target-has.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2009, 2011 Stefan Weil
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#define TCG_TARGET_HAS_bswap16_i32      1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          1
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        1
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_andc_i32         1
+#define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
+#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_eqv_i32          1
+#define TCG_TARGET_HAS_nand_i32         1
+#define TCG_TARGET_HAS_nor_i32          1
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          1
+#define TCG_TARGET_HAS_ctpop_i32        1
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_orc_i32          1
+#define TCG_TARGET_HAS_rot_i32          1
+#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_muls2_i32        1
+#define TCG_TARGET_HAS_muluh_i32        0
+#define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_TARGET_HAS_extr_i64_i32     0
+#define TCG_TARGET_HAS_bswap16_i64      1
+#define TCG_TARGET_HAS_bswap32_i64      1
+#define TCG_TARGET_HAS_bswap64_i64      1
+#define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
+#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
+#define TCG_TARGET_HAS_ext8s_i64        1
+#define TCG_TARGET_HAS_ext16s_i64       1
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext8u_i64        1
+#define TCG_TARGET_HAS_ext16u_i64       1
+#define TCG_TARGET_HAS_ext32u_i64       1
+#define TCG_TARGET_HAS_andc_i64         1
+#define TCG_TARGET_HAS_eqv_i64          1
+#define TCG_TARGET_HAS_nand_i64         1
+#define TCG_TARGET_HAS_nor_i64          1
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          1
+#define TCG_TARGET_HAS_ctpop_i64        1
+#define TCG_TARGET_HAS_not_i64          1
+#define TCG_TARGET_HAS_orc_i64          1
+#define TCG_TARGET_HAS_rot_i64          1
+#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_muls2_i64        1
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_mulu2_i32        1
+#define TCG_TARGET_HAS_add2_i64         1
+#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_mulu2_i64        1
+#define TCG_TARGET_HAS_muluh_i64        0
+#define TCG_TARGET_HAS_mulsh_i64        0
+#else
+#define TCG_TARGET_HAS_mulu2_i32        1
+#endif /* TCG_TARGET_REG_BITS == 64 */
+
+#define TCG_TARGET_HAS_qemu_ldst_i128   0
+
+#define TCG_TARGET_HAS_tst              1
+
+#endif
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index d7650343a3b..899d9861a64 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -44,80 +44,7 @@
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
-/* Optional instructions. */
-
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
-#define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_eqv_i32          1
-#define TCG_TARGET_HAS_nand_i32         1
-#define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_orc_i32          1
-#define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_negsetcond_i32   0
-#define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_bswap16_i64      1
-#define TCG_TARGET_HAS_bswap32_i64      1
-#define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
-#define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_eqv_i64          1
-#define TCG_TARGET_HAS_nand_i64         1
-#define TCG_TARGET_HAS_nor_i64          1
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        1
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_orc_i64          1
-#define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_muls2_i64        1
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        1
-#define TCG_TARGET_HAS_muluh_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
-#else
-#define TCG_TARGET_HAS_mulu2_i32        1
-#endif /* TCG_TARGET_REG_BITS == 64 */
-
-#define TCG_TARGET_HAS_qemu_ldst_i128   0
-
-#define TCG_TARGET_HAS_tst              1
+#include "tcg-target-has.h"
 
 /* Number of registers available. */
 #define TCG_TARGET_NB_REGS 16
-- 
2.47.1


