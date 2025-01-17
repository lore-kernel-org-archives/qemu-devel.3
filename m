Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC48C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr27-0004AD-RY; Fri, 17 Jan 2025 13:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr21-000477-1A
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:21 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1y-0007tM-RD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:20 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21654fdd5daso44791515ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138317; x=1737743117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuOvg1jVhP+07SLN4scRA4LJALOhPD2+nRCuijOhumU=;
 b=nk7NtPV28JoxB9VwpS2EAF5nbVVJZpOWVbDNhDpq5VZKCyUb4GWq+BAkL+2o9s3NmX
 pKwmY3zJ0imqYQ73fZ8sgWfUnBcrm9xp73s5a1JSwVZ7gBJ+tOWS4J0ML9sZj/iv1E3U
 7bNGE8xcGMjy5MCOYAxdv/r50PooB3iS9dK3Km3kgn0tPHGYHqjd2unmm9KcNLpnR12i
 jq51dm9JU/rFJ2gYLPIRDMp2P42Hb29TNEWpto9cNxpNG5URmU6GaUIdsg/37AQ0jIj3
 87ac0vG89RPAfEHLVBrwl1Le6PkdOE+mRtUunzxa5e4giYIVvwQI22vZoK0d7uNqDysf
 JaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138317; x=1737743117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CuOvg1jVhP+07SLN4scRA4LJALOhPD2+nRCuijOhumU=;
 b=Mi4SlODsdpj/1nLSll0Gyox3frjheU5SH93IierfBjl2wDQC6rSF5xPBzKbhV1Gapw
 /lV4cgXuoSyP+fHzGPYKP9u/knQUJ6kfnXXWkAXTdP1RgBYQ220NGFrs3Z265YmOrpKa
 d++qMBAciz6gCT6rwnuzm6C90CKYMqGN02KjR42Q5QEmKJuxqUi6MtNbuCmIE7GonsOK
 qa6Bp4hlemxEVlfN/rt4KfV4WBGOca+Giaspm9PoDt984uHGp996Q8OiZbt3z/kRlSKC
 aKSPg6mkDYwvU2PADM+emQ+zS62enxYajdhTJKSBIa6nnRDZ4yqidzOx+0hJvIzgqTxL
 ESIg==
X-Gm-Message-State: AOJu0Yy7SYhbCn9j98FahSFF8VqDSTqG/z/Fuh4Cx40Jl2L7NyWKaAW4
 hQuMY0KDU+J+PitFDOE7oDGT3YfpEyH1j0EUR2zwJ/ErUIaZyNJZPzdPaLMtmxpZkksLiiFd8MJ
 7
X-Gm-Gg: ASbGncvrI7IIEdyAVXP5+XhPMqrEARtasbYfjTu5vugVMxcasgQXaGWhKH9whj1kkfE
 NZDHB9cwdmaPLWlL5wXelv/YO98qKLhq8ofsuBCgxQRgr3mF3B2EOov8PJbZ+a9Kzm5xDB0vcI1
 cJJDXTfUwyU9FdUm9b/9bUBqYsrTqgJoAPfyoi1NN4n5fNkfPi0bQ1JB5VoJrICKRGBOAOZ6myh
 /Saaq2gY/KaQTCe266f35LE3W844UrQgZ8EVazSJ1vjLTb782kdPKsctmUpSlxN6JjP6ygPlOjS
 RXycwgNe/N2VVus=
X-Google-Smtp-Source: AGHT+IF2ujWdeCiCX5aN9RzEpfCWN58iwm8gip//cpiACNCB7NGpyEPrDOIHwxvseRm6v4aU6ue/ng==
X-Received: by 2002:a17:902:db10:b0:215:a2e2:53fe with SMTP id
 d9443c01a7336-21c355c7a3dmr58489785ad.40.1737138317161; 
 Fri, 17 Jan 2025 10:25:17 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/68] tcg/ppc: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Fri, 17 Jan 2025 10:24:14 -0800
Message-ID: <20250117182456.2077110-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
Message-ID: <20250108215156.8731-9-philmd@linaro.org>
---
 tcg/ppc/tcg-target-has.h | 124 +++++++++++++++++++++++++++++++++++++++
 tcg/ppc/tcg-target.h     | 114 +----------------------------------
 2 files changed, 125 insertions(+), 113 deletions(-)
 create mode 100644 tcg/ppc/tcg-target-has.h

diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
new file mode 100644
index 0000000000..a6c7cdba5d
--- /dev/null
+++ b/tcg/ppc/tcg-target-has.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#include "host/cpuinfo.h"
+
+#define have_isa_2_06  (cpuinfo & CPUINFO_V2_06)
+#define have_isa_2_07  (cpuinfo & CPUINFO_V2_07)
+#define have_isa_3_00  (cpuinfo & CPUINFO_V3_0)
+#define have_isa_3_10  (cpuinfo & CPUINFO_V3_1)
+#define have_altivec   (cpuinfo & CPUINFO_ALTIVEC)
+#define have_vsx       (cpuinfo & CPUINFO_VSX)
+
+/* optional instructions automatically implemented */
+#define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
+#define TCG_TARGET_HAS_ext16u_i32       0
+
+/* optional instructions */
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          have_isa_3_00
+#define TCG_TARGET_HAS_rot_i32          1
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_bswap16_i32      1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_andc_i32         1
+#define TCG_TARGET_HAS_orc_i32          1
+#define TCG_TARGET_HAS_eqv_i32          1
+#define TCG_TARGET_HAS_nand_i32         1
+#define TCG_TARGET_HAS_nor_i32          1
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
+#define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
+#define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_negsetcond_i32   1
+#define TCG_TARGET_HAS_mulu2_i32        0
+#define TCG_TARGET_HAS_muls2_i32        0
+#define TCG_TARGET_HAS_muluh_i32        1
+#define TCG_TARGET_HAS_mulsh_i32        1
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
+#define TCG_TARGET_HAS_extr_i64_i32     0
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          have_isa_3_00
+#define TCG_TARGET_HAS_rot_i64          1
+#define TCG_TARGET_HAS_ext8s_i64        1
+#define TCG_TARGET_HAS_ext16s_i64       1
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext8u_i64        0
+#define TCG_TARGET_HAS_ext16u_i64       0
+#define TCG_TARGET_HAS_ext32u_i64       0
+#define TCG_TARGET_HAS_bswap16_i64      1
+#define TCG_TARGET_HAS_bswap32_i64      1
+#define TCG_TARGET_HAS_bswap64_i64      1
+#define TCG_TARGET_HAS_not_i64          1
+#define TCG_TARGET_HAS_andc_i64         1
+#define TCG_TARGET_HAS_orc_i64          1
+#define TCG_TARGET_HAS_eqv_i64          1
+#define TCG_TARGET_HAS_nand_i64         1
+#define TCG_TARGET_HAS_nor_i64          1
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
+#define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
+#define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_negsetcond_i64   1
+#define TCG_TARGET_HAS_add2_i64         1
+#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        1
+#define TCG_TARGET_HAS_mulsh_i64        1
+#endif
+
+#define TCG_TARGET_HAS_qemu_ldst_i128   \
+    (TCG_TARGET_REG_BITS == 64 && have_isa_2_07)
+
+#define TCG_TARGET_HAS_tst              1
+
+/*
+ * While technically Altivec could support V64, it has no 64-bit store
+ * instruction and substituting two 32-bit stores makes the generated
+ * code quite large.
+ */
+#define TCG_TARGET_HAS_v64              have_vsx
+#define TCG_TARGET_HAS_v128             have_altivec
+#define TCG_TARGET_HAS_v256             0
+
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          have_isa_2_07
+#define TCG_TARGET_HAS_nand_vec         have_isa_2_07
+#define TCG_TARGET_HAS_nor_vec          1
+#define TCG_TARGET_HAS_eqv_vec          have_isa_2_07
+#define TCG_TARGET_HAS_not_vec          1
+#define TCG_TARGET_HAS_neg_vec          have_isa_3_00
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         1
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       have_vsx
+#define TCG_TARGET_HAS_cmpsel_vec       1
+#define TCG_TARGET_HAS_tst_vec          0
+
+#endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 4fa4a30de4..fa2cc28183 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -25,8 +25,6 @@
 #ifndef PPC_TCG_TARGET_H
 #define PPC_TCG_TARGET_H
 
-#include "host/cpuinfo.h"
-
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
 #define TCG_TARGET_NB_REGS 64
@@ -55,117 +53,7 @@ typedef enum {
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
-#define have_isa_2_06  (cpuinfo & CPUINFO_V2_06)
-#define have_isa_2_07  (cpuinfo & CPUINFO_V2_07)
-#define have_isa_3_00  (cpuinfo & CPUINFO_V3_0)
-#define have_isa_3_10  (cpuinfo & CPUINFO_V3_1)
-#define have_altivec   (cpuinfo & CPUINFO_ALTIVEC)
-#define have_vsx       (cpuinfo & CPUINFO_VSX)
-
-/* optional instructions automatically implemented */
-#define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
-#define TCG_TARGET_HAS_ext16u_i32       0
-
-/* optional instructions */
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          have_isa_3_00
-#define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          1
-#define TCG_TARGET_HAS_eqv_i32          1
-#define TCG_TARGET_HAS_nand_i32         1
-#define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
-#define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
-#define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     0
-#define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        1
-#define TCG_TARGET_HAS_mulsh_i32        1
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
-#define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          have_isa_3_00
-#define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_bswap16_i64      1
-#define TCG_TARGET_HAS_bswap32_i64      1
-#define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_orc_i64          1
-#define TCG_TARGET_HAS_eqv_i64          1
-#define TCG_TARGET_HAS_nand_i64         1
-#define TCG_TARGET_HAS_nor_i64          1
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
-#define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
-#define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
-#endif
-
-#define TCG_TARGET_HAS_qemu_ldst_i128   \
-    (TCG_TARGET_REG_BITS == 64 && have_isa_2_07)
-
-#define TCG_TARGET_HAS_tst              1
-
-/*
- * While technically Altivec could support V64, it has no 64-bit store
- * instruction and substituting two 32-bit stores makes the generated
- * code quite large.
- */
-#define TCG_TARGET_HAS_v64              have_vsx
-#define TCG_TARGET_HAS_v128             have_altivec
-#define TCG_TARGET_HAS_v256             0
-
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          have_isa_2_07
-#define TCG_TARGET_HAS_nand_vec         have_isa_2_07
-#define TCG_TARGET_HAS_nor_vec          1
-#define TCG_TARGET_HAS_eqv_vec          have_isa_2_07
-#define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          have_isa_3_00
-#define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_roti_vec         0
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         1
-#define TCG_TARGET_HAS_shi_vec          0
-#define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       have_vsx
-#define TCG_TARGET_HAS_cmpsel_vec       1
-#define TCG_TARGET_HAS_tst_vec          0
+#include "tcg-target-has.h"
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
-- 
2.43.0


