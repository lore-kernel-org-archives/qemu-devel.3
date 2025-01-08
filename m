Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C794E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdyQ-0008JL-UO; Wed, 08 Jan 2025 16:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyL-0008HP-2X
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:18 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyI-000415-Sl
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:16 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so2394865e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373132; x=1736977932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bK0DLDa7yXdhLO72RuYI+semnMNUmEQT7VpS3MpFwG4=;
 b=aRDBuFsI2Af+gexMkJMN1RtrLoLKZeuRicpR+hIubLT2NuN8fhfa+NY2PLv0ehZDze
 UFAleDnMvurHl1JkYJZBWE7dIDInoEdQdYSw7cjxCCRmkeZun50iNidj657fI+UYVFWR
 h0Dy2YTPg6mRZ/N08fqNyYmlfjWc9xzeNQzvwXhyfwwDo9Cfk7wE+TTsofXHt41A5FIb
 7sBFOlUYdH4mapGAdnIZpCe9WSxAVnEvcfgXpNKSGKwoGM46FQLFPnNvA2H4EN19WKDw
 Yf15u0fH26swi5NJv7IrkDrDmQ6naUXSSbwdr2R0VhLQRbEE47HJ3fDTIUHc3q11aRwa
 af5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373132; x=1736977932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bK0DLDa7yXdhLO72RuYI+semnMNUmEQT7VpS3MpFwG4=;
 b=Eggb5giXdXyrpPUoggrrrvPWIQ7hI2lqrUyy61mNmTfOk4uAMVeY1Z+UQdiNLahWQn
 GmhEjIgVMfzfUBPVvHfenvHw5EWuwt++frX2AIAAFxj8LttAJV/viWE9XRHSc8yqFzyx
 rM3CEXgEnBpczzGvlqkUqodHupxrrV+hgyThQ12aQ3bdTrLN2FIGnwZYE2bNv67H74Vf
 mS9sM9IktI8fqzyssDFhX+md/zQscxhyigMC8LMaCJOWJOqoYQvyi5cBNt2nKupYvcC0
 bTa901o0DBtjdJ8MQQUUeOPw0sKyq/9kURgZRN0WrKYeFd/o7qUCI8zOnQYu00yHG+y4
 eHRw==
X-Gm-Message-State: AOJu0Yxe1GlJX3YizYTv0Zoj7oe/YckHiBSJvFcVd0Ab77H3olaRbmah
 YpSfjuIKDgU0HF9dCm2h2n3uU4hS07P6Ok23hOC7LQtFf8VZMaBCPLqYw6Wj4nPgWGPNTyH3BsN
 PTIU=
X-Gm-Gg: ASbGnctvhZbDlBD1b2fZD3QUKJ8YBYejMZWhdVJKBhJHpFae4OvWtvYnaBHS8J0bxiQ
 n/Wj8kBJ4bmtxI1DW4idH9zdGGyP1TWlBIULHX3ZHb/yRlk1KtUHuhbTo5+cdi11N9ivUUAbxUf
 CNan9XKCfacbuU8BRcoVgBZn7bQPehHs9kuY0t7ZflcwLUZVcMdhycKSG8/GaJ9/wXLa1vNgRkD
 lPGOwlLpgBW5inoUlvcnR6XbKX2SogWoOk0/U662+qGjdeRn/zteMZr5ARZRBHPY62h5eLSWHEc
 vJ+2NguaoyPXihb4T0hpU17KdfEa9gY=
X-Google-Smtp-Source: AGHT+IEZvCiEFDp2LhDBpYUaTzD4sqOMFbH1FxPsEZkbocU/g0btlsVAwaGo7tZ6d04/dXZyLXhvLQ==
X-Received: by 2002:a05:600c:3b91:b0:436:46f9:4fc6 with SMTP id
 5b1f17b1804b1-436e26928e6mr40467985e9.8.1736373132314; 
 Wed, 08 Jan 2025 13:52:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d050sm8784f8f.15.2025.01.08.13.52.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/14] tcg/aarch64: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Wed,  8 Jan 2025 22:51:44 +0100
Message-ID: <20250108215156.8731-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
 tcg/aarch64/tcg-target-has.h | 119 +++++++++++++++++++++++++++++++++++
 tcg/aarch64/tcg-target.h     | 109 +-------------------------------
 2 files changed, 120 insertions(+), 108 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target-has.h

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
new file mode 100644
index 00000000000..0e79e012666
--- /dev/null
+++ b/tcg/aarch64/tcg-target-has.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2013 Huawei Technologies Duesseldorf GmbH
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#include "host/cpuinfo.h"
+
+#define have_lse    (cpuinfo & CPUINFO_LSE)
+#define have_lse2   (cpuinfo & CPUINFO_LSE2)
+
+/* optional instructions */
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          1
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        1
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_bswap16_i32      1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_rot_i32          1
+#define TCG_TARGET_HAS_andc_i32         1
+#define TCG_TARGET_HAS_orc_i32          1
+#define TCG_TARGET_HAS_eqv_i32          1
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_nor_i32          0
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          1
+#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
+#define TCG_TARGET_HAS_extract2_i32     1
+#define TCG_TARGET_HAS_negsetcond_i32   1
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_mulu2_i32        0
+#define TCG_TARGET_HAS_muls2_i32        0
+#define TCG_TARGET_HAS_muluh_i32        0
+#define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_extr_i64_i32     0
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
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
+#define TCG_TARGET_HAS_rot_i64          1
+#define TCG_TARGET_HAS_andc_i64         1
+#define TCG_TARGET_HAS_orc_i64          1
+#define TCG_TARGET_HAS_eqv_i64          1
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_nor_i64          0
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          1
+#define TCG_TARGET_HAS_ctpop_i64        0
+#define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
+#define TCG_TARGET_HAS_extract2_i64     1
+#define TCG_TARGET_HAS_negsetcond_i64   1
+#define TCG_TARGET_HAS_add2_i64         1
+#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        1
+#define TCG_TARGET_HAS_mulsh_i64        1
+
+/*
+ * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
+ * which requires writable pages.  We must defer to the helper for user-only,
+ * but in system mode all ram is writable for the host.
+ */
+#ifdef CONFIG_USER_ONLY
+#define TCG_TARGET_HAS_qemu_ldst_i128   have_lse2
+#else
+#define TCG_TARGET_HAS_qemu_ldst_i128   1
+#endif
+
+#define TCG_TARGET_HAS_tst              1
+
+#define TCG_TARGET_HAS_v64              1
+#define TCG_TARGET_HAS_v128             1
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
+#define TCG_TARGET_HAS_shv_vec          1
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       1
+#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          1
+
+#endif
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index d8ca52d32da..9a682e51a47 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -13,8 +13,6 @@
 #ifndef AARCH64_TCG_TARGET_H
 #define AARCH64_TCG_TARGET_H
 
-#include "host/cpuinfo.h"
-
 #define TCG_TARGET_INSN_UNIT_SIZE  4
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
@@ -49,112 +47,7 @@ typedef enum {
 
 #define TCG_TARGET_NB_REGS 64
 
-#define have_lse    (cpuinfo & CPUINFO_LSE)
-#define have_lse2   (cpuinfo & CPUINFO_LSE2)
-
-/* optional instructions */
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          1
-#define TCG_TARGET_HAS_eqv_i32          1
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
-#define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
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
-#define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_orc_i64          1
-#define TCG_TARGET_HAS_eqv_i64          1
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        0
-#define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
-#define TCG_TARGET_HAS_extract2_i64     1
-#define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
-
-/*
- * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
- * which requires writable pages.  We must defer to the helper for user-only,
- * but in system mode all ram is writable for the host.
- */
-#ifdef CONFIG_USER_ONLY
-#define TCG_TARGET_HAS_qemu_ldst_i128   have_lse2
-#else
-#define TCG_TARGET_HAS_qemu_ldst_i128   1
-#endif
-
-#define TCG_TARGET_HAS_tst              1
-
-#define TCG_TARGET_HAS_v64              1
-#define TCG_TARGET_HAS_v128             1
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
-#define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       1
-#define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          1
+#include "tcg-target-has.h"
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
-- 
2.47.1


