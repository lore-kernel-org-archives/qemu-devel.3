Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2357AE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XR-0000V7-HI; Tue, 07 Jan 2025 03:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wy-0000I1-IN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:41 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wu-0002vw-2f
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:40 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so22028872a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236894; x=1736841694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFQMmbDQ2gmLBFyHcjuN+GWBwn7qjz5izVCvwdvwP+4=;
 b=e5Q6TOvJfxxWPHSNDy95a7dZ1+OISr4gbBM4Bse14h1M/EbfN4ZL2RfOIKab62AOCI
 5zpJJ/nVxOl2vndGK3wNMoLPAMcsh2pElv4jD35ICGFNRY9M80u3uUEG33iFxnqd+Ayg
 A2oXFFdp4UBepx6S5SxhVwqHpXonlWR+WuhKWt6ZD+myZImN2rYyZb4fUuvIm3l3/4RN
 5liFIWN5FE+aG3gPc9tfbNJ/5DXJqgGm7ZiAqZ/Uo9+tvpPMx6AC1dNYVtgmBk+lbLnV
 0l/jlXMVUM9Dn1qlLAP0Qa+OEfp5GksfauZFL4K+p8JzDx5JR6g9L43P6EzyPx9+PfjN
 kx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236894; x=1736841694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFQMmbDQ2gmLBFyHcjuN+GWBwn7qjz5izVCvwdvwP+4=;
 b=Y9yXii02Pi1ByOztnPEab9L5Asv51k1XmKZqVyxpRhxK3n89PrErNhZeSvpm/ChHLn
 V91YwCXgrV3JqM5ihs7FAv5TH4iRed/YeeBzEGUQC+5KTPsHPff8YPay7pFFq7pVs15M
 YpRRWqR6JXdL/a/Qy3ftIIkWvXC+0qfWxwmpinyf3e/Wa8GDGMO25TDnw3iPlFZSodje
 6bf9HXi5w6RZPNF3PGcCbmInCD1rXs+Q0bkaDP9EzzHCGqZqaodJ72cjOc7C4NXFIaoX
 4mNCrnDYs+LmIig1cTKA6AnynjiypWaS0DZ2JJYw5zEwdJYAwGb95MOhm9IaB91P5HA8
 6hzQ==
X-Gm-Message-State: AOJu0YzVO3ZxuhL6USyuCYf7oe25ZNOE9b6OEBNC6tPtgFK+oGB8oaBL
 IGMHFZiyyZvhJ4XwJNChW1gkYCdJG3+QCcQ/glhUwQiD2nELn4/YjrjKJUxScnk85K4XANNEBSr
 V
X-Gm-Gg: ASbGncuZYHBXuYs5AP3Nd5JLIKH2R2IG+VWR7M9i2ZmH3dNT5Uj1ROEp4JIC88xKNC4
 BzlCdEUc0E1wzNBmXwBHSc57W5YV+fgLteGGG03eA37Cfd9Rn/GbMFBXX+e6oBmM6rJEvKFScDV
 YMKStez2IWNLaxjYQ2dTi6z9CEMR1bmCh5frN9ZKe5D3LekXOFo4FbQA0n+QajUt1lyakKGLyx4
 X0v6wmdIy2KCTphQVCW8kA6tFZRTpaakIsD2ljxPsNGCP3ehDxsAO/VclrjNOAbJbjhohhct3JQ
 pVPbFAoohDv/kZmLNA==
X-Google-Smtp-Source: AGHT+IFpkegn5KpYK3Q8gealIoSruCyMxRIW3I6tjOGDeop9wUZzxMyHXvAYq5Js+mHlKzXzyCJL+Q==
X-Received: by 2002:a17:90b:540f:b0:2ee:6db1:21d3 with SMTP id
 98e67ed59e1d1-2f452ec922bmr85140517a91.25.1736236893458; 
 Tue, 07 Jan 2025 00:01:33 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 18/81] tcg: Split out tcg-target-has.h and tcg-has.h
Date: Tue,  7 Jan 2025 00:00:09 -0800
Message-ID: <20250107080112.1175095-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Move all of the TCG_TARGET_HAS_* definitions to their own files.
These need not be exposed by include/tcg/tcg.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h                | 105 -----------------------
 tcg/aarch64/tcg-target-has.h     | 119 ++++++++++++++++++++++++++
 tcg/aarch64/tcg-target.h         | 109 ------------------------
 tcg/arm/tcg-target-has.h         |  85 +++++++++++++++++++
 tcg/arm/tcg-target.h             |  74 ----------------
 tcg/i386/tcg-target-has.h        | 139 +++++++++++++++++++++++++++++++
 tcg/i386/tcg-target.h            | 129 ----------------------------
 tcg/loongarch64/tcg-target-has.h | 113 +++++++++++++++++++++++++
 tcg/loongarch64/tcg-target.h     | 102 -----------------------
 tcg/mips/tcg-target-has.h        | 122 +++++++++++++++++++++++++++
 tcg/mips/tcg-target.h            | 112 -------------------------
 tcg/ppc/tcg-target-has.h         | 124 +++++++++++++++++++++++++++
 tcg/ppc/tcg-target.h             | 122 ---------------------------
 tcg/riscv/tcg-target-has.h       | 112 +++++++++++++++++++++++++
 tcg/riscv/tcg-target.h           | 102 -----------------------
 tcg/s390x/tcg-target-has.h       | 124 +++++++++++++++++++++++++++
 tcg/s390x/tcg-target.h           | 114 -------------------------
 tcg/sparc64/tcg-target-has.h     |  86 +++++++++++++++++++
 tcg/sparc64/tcg-target.h         |  76 -----------------
 tcg/tcg-has.h                    | 117 ++++++++++++++++++++++++++
 tcg/tci/tcg-target-has.h         |  83 ++++++++++++++++++
 tcg/tci/tcg-target.h             |  75 -----------------
 tcg/optimize.c                   |   1 +
 tcg/tcg-common.c                 |   1 +
 tcg/tcg-op-gvec.c                |   1 +
 tcg/tcg-op-ldst.c                |   2 +-
 tcg/tcg-op-vec.c                 |   1 +
 tcg/tcg-op.c                     |   2 +-
 tcg/tcg.c                        |   1 +
 tcg/tci.c                        |   1 +
 30 files changed, 1232 insertions(+), 1122 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target-has.h
 create mode 100644 tcg/arm/tcg-target-has.h
 create mode 100644 tcg/i386/tcg-target-has.h
 create mode 100644 tcg/loongarch64/tcg-target-has.h
 create mode 100644 tcg/mips/tcg-target-has.h
 create mode 100644 tcg/ppc/tcg-target-has.h
 create mode 100644 tcg/riscv/tcg-target-has.h
 create mode 100644 tcg/s390x/tcg-target-has.h
 create mode 100644 tcg/sparc64/tcg-target-has.h
 create mode 100644 tcg/tcg-has.h
 create mode 100644 tcg/tci/tcg-target-has.h

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 57f5fda109..4406fc6be0 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -64,111 +64,6 @@ typedef uint64_t TCGRegSet;
 #error unsupported
 #endif
 
-#if TCG_TARGET_REG_BITS == 32
-/* Turn some undef macros into false macros.  */
-#define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_div_i64          0
-#define TCG_TARGET_HAS_rem_i64          0
-#define TCG_TARGET_HAS_div2_i64         0
-#define TCG_TARGET_HAS_rot_i64          0
-#define TCG_TARGET_HAS_ext8s_i64        0
-#define TCG_TARGET_HAS_ext16s_i64       0
-#define TCG_TARGET_HAS_ext32s_i64       0
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_bswap16_i64      0
-#define TCG_TARGET_HAS_bswap32_i64      0
-#define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_not_i64          0
-#define TCG_TARGET_HAS_andc_i64         0
-#define TCG_TARGET_HAS_orc_i64          0
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
-#define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
-/* Turn some undef macros into true macros.  */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#endif
-
-#ifndef TCG_TARGET_deposit_i32_valid
-#define TCG_TARGET_deposit_i32_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_deposit_i64_valid
-#define TCG_TARGET_deposit_i64_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_extract_i32_valid
-#define TCG_TARGET_extract_i32_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_extract_i64_valid
-#define TCG_TARGET_extract_i64_valid(ofs, len) 1
-#endif
-
-/* Only one of DIV or DIV2 should be defined.  */
-#if defined(TCG_TARGET_HAS_div_i32)
-#define TCG_TARGET_HAS_div2_i32         0
-#elif defined(TCG_TARGET_HAS_div2_i32)
-#define TCG_TARGET_HAS_div_i32          0
-#define TCG_TARGET_HAS_rem_i32          0
-#endif
-#if defined(TCG_TARGET_HAS_div_i64)
-#define TCG_TARGET_HAS_div2_i64         0
-#elif defined(TCG_TARGET_HAS_div2_i64)
-#define TCG_TARGET_HAS_div_i64          0
-#define TCG_TARGET_HAS_rem_i64          0
-#endif
-
-#if !defined(TCG_TARGET_HAS_v64) \
-    && !defined(TCG_TARGET_HAS_v128) \
-    && !defined(TCG_TARGET_HAS_v256)
-#define TCG_TARGET_MAYBE_vec            0
-#define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_neg_vec          0
-#define TCG_TARGET_HAS_not_vec          0
-#define TCG_TARGET_HAS_andc_vec         0
-#define TCG_TARGET_HAS_orc_vec          0
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
-#define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_roti_vec         0
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
-#define TCG_TARGET_HAS_shi_vec          0
-#define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
-#define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_sat_vec          0
-#define TCG_TARGET_HAS_minmax_vec       0
-#define TCG_TARGET_HAS_bitsel_vec       0
-#define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          0
-#else
-#define TCG_TARGET_MAYBE_vec            1
-#endif
-#ifndef TCG_TARGET_HAS_v64
-#define TCG_TARGET_HAS_v64              0
-#endif
-#ifndef TCG_TARGET_HAS_v128
-#define TCG_TARGET_HAS_v128             0
-#endif
-#ifndef TCG_TARGET_HAS_v256
-#define TCG_TARGET_HAS_v256             0
-#endif
-
 typedef enum TCGOpcode {
 #define DEF(name, oargs, iargs, cargs, flags) INDEX_op_ ## name,
 #include "tcg/tcg-opc.h"
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
new file mode 100644
index 0000000000..0e79e01266
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
index d8ca52d32d..1ef8b2e300 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -13,8 +13,6 @@
 #ifndef AARCH64_TCG_TARGET_H
 #define AARCH64_TCG_TARGET_H
 
-#include "host/cpuinfo.h"
-
 #define TCG_TARGET_INSN_UNIT_SIZE  4
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
@@ -49,113 +47,6 @@ typedef enum {
 
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
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif /* AARCH64_TCG_TARGET_H */
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
index 7f6e24f861..21563e00f9 100644
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
 
@@ -74,76 +70,6 @@ typedef enum {
 
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
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
new file mode 100644
index 0000000000..3ea2eab807
--- /dev/null
+++ b/tcg/i386/tcg-target-has.h
@@ -0,0 +1,139 @@
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
+#define have_bmi1         (cpuinfo & CPUINFO_BMI1)
+#define have_popcnt       (cpuinfo & CPUINFO_POPCNT)
+#define have_avx1         (cpuinfo & CPUINFO_AVX1)
+#define have_avx2         (cpuinfo & CPUINFO_AVX2)
+#define have_movbe        (cpuinfo & CPUINFO_MOVBE)
+
+/*
+ * There are interesting instructions in AVX512, so long as we have AVX512VL,
+ * which indicates support for EVEX on sizes smaller than 512 bits.
+ */
+#define have_avx512vl     ((cpuinfo & CPUINFO_AVX512VL) && \
+                           (cpuinfo & CPUINFO_AVX512F))
+#define have_avx512bw     ((cpuinfo & CPUINFO_AVX512BW) && have_avx512vl)
+#define have_avx512dq     ((cpuinfo & CPUINFO_AVX512DQ) && have_avx512vl)
+#define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
+
+/* optional instructions */
+#define TCG_TARGET_HAS_div2_i32         1
+#define TCG_TARGET_HAS_rot_i32          1
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        1
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_bswap16_i32      1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_andc_i32         have_bmi1
+#define TCG_TARGET_HAS_orc_i32          0
+#define TCG_TARGET_HAS_eqv_i32          0
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_nor_i32          0
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          1
+#define TCG_TARGET_HAS_ctpop_i32        have_popcnt
+#define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
+#define TCG_TARGET_HAS_extract2_i32     1
+#define TCG_TARGET_HAS_negsetcond_i32   1
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_mulu2_i32        1
+#define TCG_TARGET_HAS_muls2_i32        1
+#define TCG_TARGET_HAS_muluh_i32        0
+#define TCG_TARGET_HAS_mulsh_i32        0
+
+#if TCG_TARGET_REG_BITS == 64
+/* Keep 32-bit values zero-extended in a register.  */
+#define TCG_TARGET_HAS_extr_i64_i32     1
+#define TCG_TARGET_HAS_div2_i64         1
+#define TCG_TARGET_HAS_rot_i64          1
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
+#define TCG_TARGET_HAS_andc_i64         have_bmi1
+#define TCG_TARGET_HAS_orc_i64          0
+#define TCG_TARGET_HAS_eqv_i64          0
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_nor_i64          0
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          1
+#define TCG_TARGET_HAS_ctpop_i64        have_popcnt
+#define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     1
+#define TCG_TARGET_HAS_negsetcond_i64   1
+#define TCG_TARGET_HAS_add2_i64         1
+#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_mulu2_i64        1
+#define TCG_TARGET_HAS_muls2_i64        1
+#define TCG_TARGET_HAS_muluh_i64        0
+#define TCG_TARGET_HAS_mulsh_i64        0
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+#else
+#define TCG_TARGET_HAS_qemu_st8_i32     1
+#endif
+
+#define TCG_TARGET_HAS_qemu_ldst_i128 \
+    (TCG_TARGET_REG_BITS == 64 && (cpuinfo & CPUINFO_ATOMIC_VMOVDQA))
+
+#define TCG_TARGET_HAS_tst              1
+
+/* We do not support older SSE systems, only beginning with AVX1.  */
+#define TCG_TARGET_HAS_v64              have_avx1
+#define TCG_TARGET_HAS_v128             have_avx1
+#define TCG_TARGET_HAS_v256             have_avx2
+
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          have_avx512vl
+#define TCG_TARGET_HAS_nand_vec         have_avx512vl
+#define TCG_TARGET_HAS_nor_vec          have_avx512vl
+#define TCG_TARGET_HAS_eqv_vec          have_avx512vl
+#define TCG_TARGET_HAS_not_vec          have_avx512vl
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_abs_vec          1
+#define TCG_TARGET_HAS_roti_vec         have_avx512vl
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         have_avx512vl
+#define TCG_TARGET_HAS_shi_vec          1
+#define TCG_TARGET_HAS_shs_vec          1
+#define TCG_TARGET_HAS_shv_vec          have_avx2
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
+#define TCG_TARGET_HAS_cmpsel_vec       1
+#define TCG_TARGET_HAS_tst_vec          have_avx512bw
+
+#define TCG_TARGET_deposit_i32_valid(ofs, len) \
+    (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
+     (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
+#define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
+
+/* Check for the possibility of high-byte extraction and, for 64-bit,
+   zero-extending 32-bit right-shift.  */
+#define TCG_TARGET_extract_i32_valid(ofs, len) ((ofs) == 8 && (len) == 8)
+#define TCG_TARGET_extract_i64_valid(ofs, len) \
+    (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
+
+#endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 9961d8e757..e6d7fd526e 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -25,8 +25,6 @@
 #ifndef I386_TCG_TARGET_H
 #define I386_TCG_TARGET_H
 
-#include "host/cpuinfo.h"
-
 #define TCG_TARGET_INSN_UNIT_SIZE  1
 
 #ifdef __x86_64__
@@ -90,133 +88,6 @@ typedef enum {
     TCG_REG_CALL_STACK = TCG_REG_ESP
 } TCGReg;
 
-#define have_bmi1         (cpuinfo & CPUINFO_BMI1)
-#define have_popcnt       (cpuinfo & CPUINFO_POPCNT)
-#define have_avx1         (cpuinfo & CPUINFO_AVX1)
-#define have_avx2         (cpuinfo & CPUINFO_AVX2)
-#define have_movbe        (cpuinfo & CPUINFO_MOVBE)
-
-/*
- * There are interesting instructions in AVX512, so long as we have AVX512VL,
- * which indicates support for EVEX on sizes smaller than 512 bits.
- */
-#define have_avx512vl     ((cpuinfo & CPUINFO_AVX512VL) && \
-                           (cpuinfo & CPUINFO_AVX512F))
-#define have_avx512bw     ((cpuinfo & CPUINFO_AVX512BW) && have_avx512vl)
-#define have_avx512dq     ((cpuinfo & CPUINFO_AVX512DQ) && have_avx512vl)
-#define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
-
-/* optional instructions */
-#define TCG_TARGET_HAS_div2_i32         1
-#define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         have_bmi1
-#define TCG_TARGET_HAS_orc_i32          0
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        have_popcnt
-#define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
-#define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        1
-#define TCG_TARGET_HAS_muls2_i32        1
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
-
-#if TCG_TARGET_REG_BITS == 64
-/* Keep 32-bit values zero-extended in a register.  */
-#define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_div2_i64         1
-#define TCG_TARGET_HAS_rot_i64          1
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
-#define TCG_TARGET_HAS_andc_i64         have_bmi1
-#define TCG_TARGET_HAS_orc_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        have_popcnt
-#define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     1
-#define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        1
-#define TCG_TARGET_HAS_muls2_i64        1
-#define TCG_TARGET_HAS_muluh_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-#else
-#define TCG_TARGET_HAS_qemu_st8_i32     1
-#endif
-
-#define TCG_TARGET_HAS_qemu_ldst_i128 \
-    (TCG_TARGET_REG_BITS == 64 && (cpuinfo & CPUINFO_ATOMIC_VMOVDQA))
-
-#define TCG_TARGET_HAS_tst              1
-
-/* We do not support older SSE systems, only beginning with AVX1.  */
-#define TCG_TARGET_HAS_v64              have_avx1
-#define TCG_TARGET_HAS_v128             have_avx1
-#define TCG_TARGET_HAS_v256             have_avx2
-
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          have_avx512vl
-#define TCG_TARGET_HAS_nand_vec         have_avx512vl
-#define TCG_TARGET_HAS_nor_vec          have_avx512vl
-#define TCG_TARGET_HAS_eqv_vec          have_avx512vl
-#define TCG_TARGET_HAS_not_vec          have_avx512vl
-#define TCG_TARGET_HAS_neg_vec          0
-#define TCG_TARGET_HAS_abs_vec          1
-#define TCG_TARGET_HAS_roti_vec         have_avx512vl
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         have_avx512vl
-#define TCG_TARGET_HAS_shi_vec          1
-#define TCG_TARGET_HAS_shs_vec          1
-#define TCG_TARGET_HAS_shv_vec          have_avx2
-#define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
-#define TCG_TARGET_HAS_cmpsel_vec       1
-#define TCG_TARGET_HAS_tst_vec          have_avx512bw
-
-#define TCG_TARGET_deposit_i32_valid(ofs, len) \
-    (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
-     (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
-#define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
-
-/* Check for the possibility of high-byte extraction and, for 64-bit,
-   zero-extending 32-bit right-shift.  */
-#define TCG_TARGET_extract_i32_valid(ofs, len) ((ofs) == 8 && (len) == 8)
-#define TCG_TARGET_extract_i64_valid(ofs, len) \
-    (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
-
 /* This defines the natural memory order supported by this
  * architecture before guarantees made by various barrier
  * instructions.
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
new file mode 100644
index 0000000000..e4333c36c6
--- /dev/null
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2021 WANG Xuerui <git@xen0n.name>
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#include "host/cpuinfo.h"
+
+/* optional instructions */
+#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          1
+#define TCG_TARGET_HAS_div2_i32         0
+#define TCG_TARGET_HAS_rot_i32          1
+#define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
+#define TCG_TARGET_HAS_mulu2_i32        0
+#define TCG_TARGET_HAS_muls2_i32        0
+#define TCG_TARGET_HAS_muluh_i32        1
+#define TCG_TARGET_HAS_mulsh_i32        1
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        1
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_bswap16_i32      1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_andc_i32         1
+#define TCG_TARGET_HAS_orc_i32          1
+#define TCG_TARGET_HAS_eqv_i32          0
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_nor_i32          1
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          1
+#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_brcond2          0
+#define TCG_TARGET_HAS_setcond2         0
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+
+/* 64-bit operations */
+#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
+#define TCG_TARGET_HAS_div2_i64         0
+#define TCG_TARGET_HAS_rot_i64          1
+#define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_extr_i64_i32     1
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
+#define TCG_TARGET_HAS_andc_i64         1
+#define TCG_TARGET_HAS_orc_i64          1
+#define TCG_TARGET_HAS_eqv_i64          0
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_nor_i64          1
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          1
+#define TCG_TARGET_HAS_ctpop_i64        0
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        1
+#define TCG_TARGET_HAS_mulsh_i64        1
+
+#define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
+
+#define TCG_TARGET_HAS_tst              0
+
+#define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_LSX)
+#define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
+#define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_LASX)
+
+#define TCG_TARGET_HAS_not_vec          1
+#define TCG_TARGET_HAS_neg_vec          1
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          1
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          1
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_shi_vec          1
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
+#define TCG_TARGET_HAS_roti_vec         1
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         1
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       1
+#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
+
+
+#endif
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 3bc9aafaf2..0432a4ebbd 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -29,8 +29,6 @@
 #ifndef LOONGARCH_TCG_TARGET_H
 #define LOONGARCH_TCG_TARGET_H
 
-#include "host/cpuinfo.h"
-
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_NB_REGS 64
 
@@ -87,106 +85,6 @@ typedef enum {
     TCG_VEC_TMP0 = TCG_REG_V23,
 } TCGReg;
 
-/* optional instructions */
-#define TCG_TARGET_HAS_negsetcond_i32   0
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_div2_i32         0
-#define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     0
-#define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
-#define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        1
-#define TCG_TARGET_HAS_mulsh_i32        1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          1
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_brcond2          0
-#define TCG_TARGET_HAS_setcond2         0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
-/* 64-bit operations */
-#define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_div2_i64         0
-#define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_extr_i64_i32     1
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
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_orc_i64          1
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          1
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
-
-#define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
-
-#define TCG_TARGET_HAS_tst              0
-
-#define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_LSX)
-#define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
-#define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_LASX)
-
-#define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          1
-#define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          1
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          1
-#define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_shi_vec          1
-#define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_roti_vec         1
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         1
-#define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       1
-#define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          0
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif /* LOONGARCH_TCG_TARGET_H */
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
index db60eb7c1b..210044ca12 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -70,118 +70,6 @@ typedef enum {
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
-
 #define TCG_TARGET_DEFAULT_MO           0
 
 #endif
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
index 8291e0127d..0bc13d7363 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -25,8 +25,6 @@
 #ifndef PPC_TCG_TARGET_H
 #define PPC_TCG_TARGET_H
 
-#include "host/cpuinfo.h"
-
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
 #define TCG_TARGET_NB_REGS 64
@@ -55,126 +53,6 @@ typedef enum {
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
-typedef enum {
-    tcg_isa_base,
-    tcg_isa_2_06,
-    tcg_isa_2_07,
-    tcg_isa_3_00,
-    tcg_isa_3_10,
-} TCGPowerISA;
-
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
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
new file mode 100644
index 0000000000..ddc759a533
--- /dev/null
+++ b/tcg/riscv/tcg-target-has.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2018 SiFive, Inc
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#include "host/cpuinfo.h"
+
+/* optional instructions */
+#define TCG_TARGET_HAS_negsetcond_i32   1
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          1
+#define TCG_TARGET_HAS_div2_i32         0
+#define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_deposit_i32      0
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_mulu2_i32        0
+#define TCG_TARGET_HAS_muls2_i32        0
+#define TCG_TARGET_HAS_muluh_i32        0
+#define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        1
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_andc_i32         (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_orc_i32          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_eqv_i32          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_nor_i32          0
+#define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_brcond2          1
+#define TCG_TARGET_HAS_setcond2         1
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+
+#define TCG_TARGET_HAS_negsetcond_i64   1
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
+#define TCG_TARGET_HAS_div2_i64         0
+#define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_deposit_i64      0
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_extr_i64_i32     1
+#define TCG_TARGET_HAS_ext8s_i64        1
+#define TCG_TARGET_HAS_ext16s_i64       1
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext8u_i64        1
+#define TCG_TARGET_HAS_ext16u_i64       1
+#define TCG_TARGET_HAS_ext32u_i64       1
+#define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_not_i64          1
+#define TCG_TARGET_HAS_andc_i64         (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_orc_i64          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_eqv_i64          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_nor_i64          0
+#define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_add2_i64         1
+#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        1
+#define TCG_TARGET_HAS_mulsh_i64        1
+
+#define TCG_TARGET_HAS_qemu_ldst_i128   0
+
+#define TCG_TARGET_HAS_tst              0
+
+/* vector instructions */
+#define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_ZVE64X)
+#define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_ZVE64X)
+#define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_ZVE64X)
+#define TCG_TARGET_HAS_andc_vec         0
+#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_not_vec          1
+#define TCG_TARGET_HAS_neg_vec          1
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_roti_vec         1
+#define TCG_TARGET_HAS_rots_vec         1
+#define TCG_TARGET_HAS_rotv_vec         1
+#define TCG_TARGET_HAS_shi_vec          1
+#define TCG_TARGET_HAS_shs_vec          1
+#define TCG_TARGET_HAS_shv_vec          1
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       1
+
+#define TCG_TARGET_HAS_tst_vec          0
+
+#endif
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index bfaa99ccdd..4c40662402 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -25,8 +25,6 @@
 #ifndef RISCV_TCG_TARGET_H
 #define RISCV_TCG_TARGET_H
 
-#include "host/cpuinfo.h"
-
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_NB_REGS 64
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
@@ -59,106 +57,6 @@ typedef enum {
     TCG_REG_TMP2       = TCG_REG_T4,
 } TCGReg;
 
-/* optional instructions */
-#define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_div2_i32         0
-#define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
-#define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_orc_i32          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_eqv_i32          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_brcond2          1
-#define TCG_TARGET_HAS_setcond2         1
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_div2_i64         0
-#define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_orc_i64          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_eqv_i64          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
-
-#define TCG_TARGET_HAS_qemu_ldst_i128   0
-
-#define TCG_TARGET_HAS_tst              0
-
-/* vector instructions */
-#define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_ZVE64X)
-#define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_ZVE64X)
-#define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_ZVE64X)
-#define TCG_TARGET_HAS_andc_vec         0
-#define TCG_TARGET_HAS_orc_vec          0
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
-#define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          1
-#define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_roti_vec         1
-#define TCG_TARGET_HAS_rots_vec         1
-#define TCG_TARGET_HAS_rotv_vec         1
-#define TCG_TARGET_HAS_shi_vec          1
-#define TCG_TARGET_HAS_shs_vec          1
-#define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       0
-#define TCG_TARGET_HAS_cmpsel_vec       1
-
-#define TCG_TARGET_HAS_tst_vec          0
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif
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
index 223d3f6ca1..f790b77075 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -51,120 +51,6 @@ typedef enum TCGReg {
 
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
-
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
 #endif
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
index b560d43ed5..5ecca5586b 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -64,82 +64,6 @@ typedef enum {
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
 
 #define TCG_TARGET_DEFAULT_MO (0)
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
new file mode 100644
index 0000000000..65b6a0b0cf
--- /dev/null
+++ b/tcg/tcg-has.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2024 Linaro, Ltd.
+ */
+
+#ifndef TCG_HAS_H
+#define TCG_HAS_H
+
+#include "tcg-target-has.h"
+
+#if TCG_TARGET_REG_BITS == 32
+/* Turn some undef macros into false macros.  */
+#define TCG_TARGET_HAS_extr_i64_i32     0
+#define TCG_TARGET_HAS_div_i64          0
+#define TCG_TARGET_HAS_rem_i64          0
+#define TCG_TARGET_HAS_div2_i64         0
+#define TCG_TARGET_HAS_rot_i64          0
+#define TCG_TARGET_HAS_ext8s_i64        0
+#define TCG_TARGET_HAS_ext16s_i64       0
+#define TCG_TARGET_HAS_ext32s_i64       0
+#define TCG_TARGET_HAS_ext8u_i64        0
+#define TCG_TARGET_HAS_ext16u_i64       0
+#define TCG_TARGET_HAS_ext32u_i64       0
+#define TCG_TARGET_HAS_bswap16_i64      0
+#define TCG_TARGET_HAS_bswap32_i64      0
+#define TCG_TARGET_HAS_bswap64_i64      0
+#define TCG_TARGET_HAS_not_i64          0
+#define TCG_TARGET_HAS_andc_i64         0
+#define TCG_TARGET_HAS_orc_i64          0
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
+#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        0
+#define TCG_TARGET_HAS_mulsh_i64        0
+/* Turn some undef macros into true macros.  */
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#endif
+
+#ifndef TCG_TARGET_deposit_i32_valid
+#define TCG_TARGET_deposit_i32_valid(ofs, len) 1
+#endif
+#ifndef TCG_TARGET_deposit_i64_valid
+#define TCG_TARGET_deposit_i64_valid(ofs, len) 1
+#endif
+#ifndef TCG_TARGET_extract_i32_valid
+#define TCG_TARGET_extract_i32_valid(ofs, len) 1
+#endif
+#ifndef TCG_TARGET_extract_i64_valid
+#define TCG_TARGET_extract_i64_valid(ofs, len) 1
+#endif
+
+/* Only one of DIV or DIV2 should be defined.  */
+#if defined(TCG_TARGET_HAS_div_i32)
+#define TCG_TARGET_HAS_div2_i32         0
+#elif defined(TCG_TARGET_HAS_div2_i32)
+#define TCG_TARGET_HAS_div_i32          0
+#define TCG_TARGET_HAS_rem_i32          0
+#endif
+#if defined(TCG_TARGET_HAS_div_i64)
+#define TCG_TARGET_HAS_div2_i64         0
+#elif defined(TCG_TARGET_HAS_div2_i64)
+#define TCG_TARGET_HAS_div_i64          0
+#define TCG_TARGET_HAS_rem_i64          0
+#endif
+
+#if !defined(TCG_TARGET_HAS_v64) \
+    && !defined(TCG_TARGET_HAS_v128) \
+    && !defined(TCG_TARGET_HAS_v256)
+#define TCG_TARGET_MAYBE_vec            0
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_andc_vec         0
+#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
+#else
+#define TCG_TARGET_MAYBE_vec            1
+#endif
+#ifndef TCG_TARGET_HAS_v64
+#define TCG_TARGET_HAS_v64              0
+#endif
+#ifndef TCG_TARGET_HAS_v128
+#define TCG_TARGET_HAS_v128             0
+#endif
+#ifndef TCG_TARGET_HAS_v256
+#define TCG_TARGET_HAS_v256             0
+#endif
+
+#endif
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
new file mode 100644
index 0000000000..3397403910
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
index d7650343a3..fea92f7848 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -44,81 +44,6 @@
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
-
 /* Number of registers available. */
 #define TCG_TARGET_NB_REGS 16
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6823569ee2..c363c5c04b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -28,6 +28,7 @@
 #include "qemu/interval-tree.h"
 #include "tcg/tcg-op-common.h"
 #include "tcg-internal.h"
+#include "tcg-has.h"
 
 #define CASE_OP_32_64(x)                        \
         glue(glue(case INDEX_op_, x), _i32):    \
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 35e7616ae9..fadc33c3d1 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
+#include "tcg-has.h"
 
 TCGOpDef tcg_op_defs[] = {
 #define DEF(s, oargs, iargs, cargs, flags) \
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 97e4df221a..d32a4f146d 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg-op-common.h"
 #include "tcg/tcg-op-gvec-common.h"
 #include "tcg/tcg-gvec-desc.h"
+#include "tcg-has.h"
 
 #define MAX_UNROLL  4
 
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 0d8fe3b4f5..ec3ef4dcb4 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -30,7 +30,7 @@
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
-
+#include "tcg-has.h"
 
 static void check_max_alignment(unsigned a_bits)
 {
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 364cd089df..893d68e7d8 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg-op-common.h"
 #include "tcg/tcg-mo.h"
 #include "tcg-internal.h"
+#include "tcg-has.h"
 
 /*
  * Vector optional opcode tracking.
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 872fb22ef8..ab5ccd8dcb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -29,7 +29,7 @@
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
-
+#include "tcg-has.h"
 
 /*
  * Encourage the compiler to tail-call to a function, rather than inlining.
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 505e43c128..3576299a1c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -56,6 +56,7 @@
 #include "tcg/tcg-temp-internal.h"
 #include "tcg-internal.h"
 #include "tcg/perf.h"
+#include "tcg-has.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/guest-base.h"
 #endif
diff --git a/tcg/tci.c b/tcg/tci.c
index 3eb95e20b6..39a68db287 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -22,6 +22,7 @@
 #include "tcg/helper-info.h"
 #include "tcg/tcg-ldst.h"
 #include "disas/dis-asm.h"
+#include "tcg-has.h"
 #include <ffi.h>
 
 
-- 
2.43.0


