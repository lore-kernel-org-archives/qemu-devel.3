Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9F7E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdyt-0001Gg-Rb; Wed, 08 Jan 2025 16:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyr-00012c-8g
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:49 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyp-00044R-53
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so3238375e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373165; x=1736977965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtnSTTCpVdWQWGkOoMv6FUutNJoBmMFz6ElIS3cget8=;
 b=Y++c56Z1DEshnwxA5NtTQ8D61Mn/omrwMChTdzR5bnhJiY4w3sSucIVQp7QeqTF7wQ
 yjZEHv6W9l3xTxLZFAoGZegj1TrDsDnNo+TOPBKTojdHvHEk2Xb86l0WL0hP2woyKnRl
 +LG+qGXldZPJoMDZS+R8Avtby4zo7e9FiTp/tmfmNwd7tKei1glsPyBs8wiOJM0TQQWG
 EDLpyAHmusSyaUCmrit37rZwFMlq007FQD9hUqNShnv3e7Y60zaJm9JtUaeD3HBQE0oh
 0OINAvwnVtDRF/i93jK4ZW/72DF+Ae3/8+bcSib/u2vO6B/UE1cpS4VRv1r0cqJzUneS
 P0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373165; x=1736977965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtnSTTCpVdWQWGkOoMv6FUutNJoBmMFz6ElIS3cget8=;
 b=Tgno4ZTZJyXvRtx7kZ/Rc69Z8vWtwtisN2kptOrfXsvXJKtrAwuZenoKzy08pp7e34
 6q+hHNGa0XahrHzrNOXJ3DqmSValuaXojmUu1qZoyXR+di6xMucHDjgrLlaePN8fRb/E
 /RnJr6/pSHF+48fOMRfbw47mkRMHnVe/xInZ5xH0DKaNHdrNdapLD4ctmOdVaYQ/eaCR
 0gPL9s8pw0Yk1UJVctmqhjgiYCICyatK+tJ5FIV8o51eLZs50QxIuop0legNLVlgLrtl
 +ZQKnh8zUEfxiDyrvCTgPKH8sB8uMBTKiKoeSsOo4E3K97KOyxSyeH7Q0zLSm7/nXepr
 k2iA==
X-Gm-Message-State: AOJu0Yyo5AhAUCQWTt4cQM54E/dfEMp86gBIY6DXMD2R8LoEUeUs85ed
 5bWhe5qsYCjC2yMLJvoIiiZoC1FFAqagiA17lYMjcM5FDqAkO9M3k+hhXKj0/RFHQRcyLqY88F3
 /1TM=
X-Gm-Gg: ASbGncse55gQ3UXNj1KVcw9khirn9PwvggynQ3hayJnrnZpYINlyTxSxtyU6BfWCX0R
 71QAfTDy/3edoOSIijnMqGgH2FAmoY8WhMhmTpe9ZsD/kG0yr42CRZBUR8O38xhKgKL8mB/PANO
 iD0cVoZ72Nz10dASphPoAR9vq1wEeIUMSN/r2W9VZzlge0VcaXjKKoyzy9ub/3fqfwxoAqz9d0x
 oxCZRD43lcF8Xh7pJQI5EZcdnd6K2C3Wew/moRA7udqHZbKKnWXP6norvgbUIs36i/a+ck2nLwD
 9AnXiTYejWnfYIZfHETkoZKEi5YkOR8=
X-Google-Smtp-Source: AGHT+IEdplNzewawSCySzKRhLh96ZrhP65W5Q6EXocshM8gte5IuyQPBa8N2M36luRtke1LY6p+DbQ==
X-Received: by 2002:a05:6000:1884:b0:385:f1d9:4b90 with SMTP id
 ffacd0b85a97d-38a8730531cmr3170355f8f.13.1736373165400; 
 Wed, 08 Jan 2025 13:52:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9a431a8sm622215e9.33.2025.01.08.13.52.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/14] tcg/s390x: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Wed,  8 Jan 2025 22:51:51 +0100
Message-ID: <20250108215156.8731-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 tcg/s390x/tcg-target-has.h | 124 +++++++++++++++++++++++++++++++++++++
 tcg/s390x/tcg-target.h     | 114 +---------------------------------
 2 files changed, 125 insertions(+), 113 deletions(-)
 create mode 100644 tcg/s390x/tcg-target-has.h

diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
new file mode 100644
index 00000000000..4992d74f121
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
index 223d3f6ca14..220ed68b1f4 100644
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
2.47.1


