Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B29C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr2C-0004An-Lw; Fri, 17 Jan 2025 13:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr22-000480-TG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:22 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr20-0007th-O8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:22 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216426b0865so44701975ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138319; x=1737743119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfehOVGpYzJP7vz2pYEfQuMJrNb2n6xjeloWGc8gxK8=;
 b=A2hrSIniJ4KAi1gdqkwVpXd5e29kphY1Eiw0bk63Lr3+KbuoAvS9d7hqbeexi8g85B
 kddCFzpS1m9A40t3ovKwm4vX7Rj+HQjLm34Ux9goUJhpOyjL3nATH1z8BebXe0QO26qY
 txnj8ei7T0et/Ob4BzSc5kuCtE0QdAUuew+qc9dpUYBSutt03+fVjQB5GXmvDALl26Xs
 8lL3nfXQGwYb1WlL1ptVaLtsIKdMTrxeRn9GqobunL75sdppKPrycJbj6sSO0WIKwZBP
 rJ8vokMm1Yj5z41Mr8dd+g8/qF1QlW/YTnDC2CLVuFHaUajXmBe6Bfl+HKW//+NFGd92
 acVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138319; x=1737743119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RfehOVGpYzJP7vz2pYEfQuMJrNb2n6xjeloWGc8gxK8=;
 b=TwUkOUUakQe+Fowm5z24zCxFE3Laifn9nuaw9ZhmyVK1fEG4kwuXqZ07ex6Anz70Ey
 TgNKMcP5cYdkMn8ExX9KhvZraeTckaFh/UpoyOQxdd7LGXnEzKu/FBtppYfmGDU+12A0
 k3jOkqjbo9F71bdTJYmhkhz2yi18bp5PBQjbbG39qS47l6GlvanHi797s85BiKZVFPYm
 +AOpPpRewXbdZNzhbe+KChMaYzhKz6KuxC3g6DPi0tsV8DMP7daxhKKRIp54ds34T5+8
 8P7sIVQ96SlQceaFS67CfNZCcLPiQLGCA4qlH0thnBt6MNf2SKMoa2NNu56rLqADjcOE
 K/rg==
X-Gm-Message-State: AOJu0Yx1rjA2gd+RdiqelKyKalUwGruzJ17semBM/BLcKZr5MrLJa6W0
 Lw7HsvOet1bzHWKay7xDVpeZdidgdUIgWmr6oV/wCKsfzZQSwOJj1Bz4/XDdFP4zYd7Y4sL20KP
 6
X-Gm-Gg: ASbGncsOaZCF5T1lp8rwj2Lo5kmdKALQ4y9oo1eajTd6pPZGSnUkWPPp5QO+HMHwb8Z
 34d2lmI3G6Qwy3F0hTJOYdiyt5ot3grg/VLtk92gtF6/6V6iGAh6/0fNnbzrOo7c68lGrKlZycJ
 zTtiqF7gEKO0fIlWTSMRct2/w501dK6k0fLaogCOTiBgfuHKd8UoV3Gz+zcIwuFegv8rU6+YugJ
 pP5e/DIX/uAlOSpMjR7yxKR5r1EwD0nPrs71vYgO6cwK+d2zMPnCrePdFgByCzQ5kaNA4TwwTJO
 n1g6GGnp3ByabYU=
X-Google-Smtp-Source: AGHT+IF6ijrxRnmVt5ovijKbUn8cIc2F9LBix6b5JAoWLhYDv1y4dQWn6KYx45beRX53xsWr8HkIyw==
X-Received: by 2002:a17:902:e94f:b0:216:53fa:634f with SMTP id
 d9443c01a7336-21c355f6e31mr56756145ad.48.1737138318888; 
 Fri, 17 Jan 2025 10:25:18 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/68] tcg/s390x: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Fri, 17 Jan 2025 10:24:16 -0800
Message-ID: <20250117182456.2077110-29-richard.henderson@linaro.org>
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
Message-ID: <20250108215156.8731-11-philmd@linaro.org>
---
 tcg/s390x/tcg-target-has.h | 124 +++++++++++++++++++++++++++++++++++++
 tcg/s390x/tcg-target.h     | 114 +---------------------------------
 2 files changed, 125 insertions(+), 113 deletions(-)
 create mode 100644 tcg/s390x/tcg-target-has.h

diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
new file mode 100644
index 0000000000..4992d74f12
--- /dev/null
+++ b/tcg/s390x/tcg-target-has.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2009 Ulrich Hecht <uli@suse.de>
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+/* Facilities required for proper operation; checked at startup. */
+
+#define FACILITY_ZARCH_ACTIVE         2
+#define FACILITY_LONG_DISP            18
+#define FACILITY_EXT_IMM              21
+#define FACILITY_GEN_INST_EXT         34
+#define FACILITY_45                   45
+
+/* Facilities that are checked at runtime. */
+
+#define FACILITY_LOAD_ON_COND2        53
+#define FACILITY_MISC_INSN_EXT2       58
+#define FACILITY_MISC_INSN_EXT3       61
+#define FACILITY_VECTOR               129
+#define FACILITY_VECTOR_ENH1          135
+
+extern uint64_t s390_facilities[3];
+
+#define HAVE_FACILITY(X) \
+    ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
+
+/* optional instructions */
+#define TCG_TARGET_HAS_div2_i32       1
+#define TCG_TARGET_HAS_rot_i32        1
+#define TCG_TARGET_HAS_ext8s_i32      1
+#define TCG_TARGET_HAS_ext16s_i32     1
+#define TCG_TARGET_HAS_ext8u_i32      1
+#define TCG_TARGET_HAS_ext16u_i32     1
+#define TCG_TARGET_HAS_bswap16_i32    1
+#define TCG_TARGET_HAS_bswap32_i32    1
+#define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_andc_i32       HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_orc_i32        HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_eqv_i32        HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_nand_i32       HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_nor_i32        HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_clz_i32        0
+#define TCG_TARGET_HAS_ctz_i32        0
+#define TCG_TARGET_HAS_ctpop_i32      1
+#define TCG_TARGET_HAS_deposit_i32    1
+#define TCG_TARGET_HAS_extract_i32    1
+#define TCG_TARGET_HAS_sextract_i32   0
+#define TCG_TARGET_HAS_extract2_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32 1
+#define TCG_TARGET_HAS_add2_i32       1
+#define TCG_TARGET_HAS_sub2_i32       1
+#define TCG_TARGET_HAS_mulu2_i32      0
+#define TCG_TARGET_HAS_muls2_i32      0
+#define TCG_TARGET_HAS_muluh_i32      0
+#define TCG_TARGET_HAS_mulsh_i32      0
+#define TCG_TARGET_HAS_extr_i64_i32   0
+#define TCG_TARGET_HAS_qemu_st8_i32   0
+
+#define TCG_TARGET_HAS_div2_i64       1
+#define TCG_TARGET_HAS_rot_i64        1
+#define TCG_TARGET_HAS_ext8s_i64      1
+#define TCG_TARGET_HAS_ext16s_i64     1
+#define TCG_TARGET_HAS_ext32s_i64     1
+#define TCG_TARGET_HAS_ext8u_i64      1
+#define TCG_TARGET_HAS_ext16u_i64     1
+#define TCG_TARGET_HAS_ext32u_i64     1
+#define TCG_TARGET_HAS_bswap16_i64    1
+#define TCG_TARGET_HAS_bswap32_i64    1
+#define TCG_TARGET_HAS_bswap64_i64    1
+#define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_andc_i64       HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_orc_i64        HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_eqv_i64        HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_nand_i64       HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_nor_i64        HAVE_FACILITY(MISC_INSN_EXT3)
+#define TCG_TARGET_HAS_clz_i64        1
+#define TCG_TARGET_HAS_ctz_i64        0
+#define TCG_TARGET_HAS_ctpop_i64      1
+#define TCG_TARGET_HAS_deposit_i64    1
+#define TCG_TARGET_HAS_extract_i64    1
+#define TCG_TARGET_HAS_sextract_i64   0
+#define TCG_TARGET_HAS_extract2_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64 1
+#define TCG_TARGET_HAS_add2_i64       1
+#define TCG_TARGET_HAS_sub2_i64       1
+#define TCG_TARGET_HAS_mulu2_i64      1
+#define TCG_TARGET_HAS_muls2_i64      HAVE_FACILITY(MISC_INSN_EXT2)
+#define TCG_TARGET_HAS_muluh_i64      0
+#define TCG_TARGET_HAS_mulsh_i64      0
+
+#define TCG_TARGET_HAS_qemu_ldst_i128 1
+
+#define TCG_TARGET_HAS_tst            1
+
+#define TCG_TARGET_HAS_v64            HAVE_FACILITY(VECTOR)
+#define TCG_TARGET_HAS_v128           HAVE_FACILITY(VECTOR)
+#define TCG_TARGET_HAS_v256           0
+
+#define TCG_TARGET_HAS_andc_vec       1
+#define TCG_TARGET_HAS_orc_vec        HAVE_FACILITY(VECTOR_ENH1)
+#define TCG_TARGET_HAS_nand_vec       HAVE_FACILITY(VECTOR_ENH1)
+#define TCG_TARGET_HAS_nor_vec        1
+#define TCG_TARGET_HAS_eqv_vec        HAVE_FACILITY(VECTOR_ENH1)
+#define TCG_TARGET_HAS_not_vec        1
+#define TCG_TARGET_HAS_neg_vec        1
+#define TCG_TARGET_HAS_abs_vec        1
+#define TCG_TARGET_HAS_roti_vec       1
+#define TCG_TARGET_HAS_rots_vec       1
+#define TCG_TARGET_HAS_rotv_vec       1
+#define TCG_TARGET_HAS_shi_vec        1
+#define TCG_TARGET_HAS_shs_vec        1
+#define TCG_TARGET_HAS_shv_vec        1
+#define TCG_TARGET_HAS_mul_vec        1
+#define TCG_TARGET_HAS_sat_vec        0
+#define TCG_TARGET_HAS_minmax_vec     1
+#define TCG_TARGET_HAS_bitsel_vec     1
+#define TCG_TARGET_HAS_cmpsel_vec     1
+#define TCG_TARGET_HAS_tst_vec        0
+
+#endif
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 223d3f6ca1..220ed68b1f 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -51,119 +51,7 @@ typedef enum TCGReg {
 
 #define TCG_TARGET_NB_REGS 64
 
-/* Facilities required for proper operation; checked at startup. */
-
-#define FACILITY_ZARCH_ACTIVE         2
-#define FACILITY_LONG_DISP            18
-#define FACILITY_EXT_IMM              21
-#define FACILITY_GEN_INST_EXT         34
-#define FACILITY_45                   45
-
-/* Facilities that are checked at runtime. */
-
-#define FACILITY_LOAD_ON_COND2        53
-#define FACILITY_MISC_INSN_EXT2       58
-#define FACILITY_MISC_INSN_EXT3       61
-#define FACILITY_VECTOR               129
-#define FACILITY_VECTOR_ENH1          135
-
-extern uint64_t s390_facilities[3];
-
-#define HAVE_FACILITY(X) \
-    ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
-
-/* optional instructions */
-#define TCG_TARGET_HAS_div2_i32       1
-#define TCG_TARGET_HAS_rot_i32        1
-#define TCG_TARGET_HAS_ext8s_i32      1
-#define TCG_TARGET_HAS_ext16s_i32     1
-#define TCG_TARGET_HAS_ext8u_i32      1
-#define TCG_TARGET_HAS_ext16u_i32     1
-#define TCG_TARGET_HAS_bswap16_i32    1
-#define TCG_TARGET_HAS_bswap32_i32    1
-#define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_andc_i32       HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_orc_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_eqv_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nand_i32       HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nor_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_clz_i32        0
-#define TCG_TARGET_HAS_ctz_i32        0
-#define TCG_TARGET_HAS_ctpop_i32      1
-#define TCG_TARGET_HAS_deposit_i32    1
-#define TCG_TARGET_HAS_extract_i32    1
-#define TCG_TARGET_HAS_sextract_i32   0
-#define TCG_TARGET_HAS_extract2_i32   0
-#define TCG_TARGET_HAS_negsetcond_i32 1
-#define TCG_TARGET_HAS_add2_i32       1
-#define TCG_TARGET_HAS_sub2_i32       1
-#define TCG_TARGET_HAS_mulu2_i32      0
-#define TCG_TARGET_HAS_muls2_i32      0
-#define TCG_TARGET_HAS_muluh_i32      0
-#define TCG_TARGET_HAS_mulsh_i32      0
-#define TCG_TARGET_HAS_extr_i64_i32   0
-#define TCG_TARGET_HAS_qemu_st8_i32   0
-
-#define TCG_TARGET_HAS_div2_i64       1
-#define TCG_TARGET_HAS_rot_i64        1
-#define TCG_TARGET_HAS_ext8s_i64      1
-#define TCG_TARGET_HAS_ext16s_i64     1
-#define TCG_TARGET_HAS_ext32s_i64     1
-#define TCG_TARGET_HAS_ext8u_i64      1
-#define TCG_TARGET_HAS_ext16u_i64     1
-#define TCG_TARGET_HAS_ext32u_i64     1
-#define TCG_TARGET_HAS_bswap16_i64    1
-#define TCG_TARGET_HAS_bswap32_i64    1
-#define TCG_TARGET_HAS_bswap64_i64    1
-#define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_andc_i64       HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_orc_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_eqv_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nand_i64       HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_nor_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_clz_i64        1
-#define TCG_TARGET_HAS_ctz_i64        0
-#define TCG_TARGET_HAS_ctpop_i64      1
-#define TCG_TARGET_HAS_deposit_i64    1
-#define TCG_TARGET_HAS_extract_i64    1
-#define TCG_TARGET_HAS_sextract_i64   0
-#define TCG_TARGET_HAS_extract2_i64   0
-#define TCG_TARGET_HAS_negsetcond_i64 1
-#define TCG_TARGET_HAS_add2_i64       1
-#define TCG_TARGET_HAS_sub2_i64       1
-#define TCG_TARGET_HAS_mulu2_i64      1
-#define TCG_TARGET_HAS_muls2_i64      HAVE_FACILITY(MISC_INSN_EXT2)
-#define TCG_TARGET_HAS_muluh_i64      0
-#define TCG_TARGET_HAS_mulsh_i64      0
-
-#define TCG_TARGET_HAS_qemu_ldst_i128 1
-
-#define TCG_TARGET_HAS_tst            1
-
-#define TCG_TARGET_HAS_v64            HAVE_FACILITY(VECTOR)
-#define TCG_TARGET_HAS_v128           HAVE_FACILITY(VECTOR)
-#define TCG_TARGET_HAS_v256           0
-
-#define TCG_TARGET_HAS_andc_vec       1
-#define TCG_TARGET_HAS_orc_vec        HAVE_FACILITY(VECTOR_ENH1)
-#define TCG_TARGET_HAS_nand_vec       HAVE_FACILITY(VECTOR_ENH1)
-#define TCG_TARGET_HAS_nor_vec        1
-#define TCG_TARGET_HAS_eqv_vec        HAVE_FACILITY(VECTOR_ENH1)
-#define TCG_TARGET_HAS_not_vec        1
-#define TCG_TARGET_HAS_neg_vec        1
-#define TCG_TARGET_HAS_abs_vec        1
-#define TCG_TARGET_HAS_roti_vec       1
-#define TCG_TARGET_HAS_rots_vec       1
-#define TCG_TARGET_HAS_rotv_vec       1
-#define TCG_TARGET_HAS_shi_vec        1
-#define TCG_TARGET_HAS_shs_vec        1
-#define TCG_TARGET_HAS_shv_vec        1
-#define TCG_TARGET_HAS_mul_vec        1
-#define TCG_TARGET_HAS_sat_vec        0
-#define TCG_TARGET_HAS_minmax_vec     1
-#define TCG_TARGET_HAS_bitsel_vec     1
-#define TCG_TARGET_HAS_cmpsel_vec     1
-#define TCG_TARGET_HAS_tst_vec        0
+#include "tcg-target-has.h"
 
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
-- 
2.43.0


