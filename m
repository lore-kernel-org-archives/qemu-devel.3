Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA2EC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr2C-0004Ao-Md; Fri, 17 Jan 2025 13:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr22-00047z-S0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:22 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr20-0007tY-5d
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:22 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21bc1512a63so49515445ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138318; x=1737743118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sA/doJH7ZeGKUSnoaEUxqrEsxSQmwTH08mJ/bqHWmSc=;
 b=BUKMBeLWYRkAN+8jQwJMZ1810BZDRlk+HWOdAWW8hGhrz79bGTxT+WEf1x34Q2JUq6
 dB2WLIUEGCe0y7MpgcvJjZwKl6ZGNN86r7sEi/O1c1n+/JS8rcM4h2B2Do3Gpf5nij17
 mB29nBzweIWRMEyV7AUCFnZhmr6LvIR6FIHKSswytCDuKMhcb7VGD3N7zlOTr8nlPml9
 cmTB/6+7dTsmWDrqOFpHUklDSPYyATqlauvQG7lXqFW1y7TH6vxwBi3zSFG7W9xgbXKp
 7yGK8/mqNAchj7u1oFchGeTq/k9XV6fm3IHqbdoAZMmlLqw3XEX9LsONteJsHCIFVDt/
 yx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138318; x=1737743118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sA/doJH7ZeGKUSnoaEUxqrEsxSQmwTH08mJ/bqHWmSc=;
 b=T37bjvg+TzVtyJV1PQb/iygEmsQhoFEhocH6rOXZrQvmS9oHlyD/5Zm3NW+uxsMq3r
 fJB21KasHKhqCZjVaYpFcebcTu9Dm4dPOszcgv+BV4wL0yiYRwQ6XyKZsZulo7bi3DVw
 trPt1PQvJnqBkQiF0pxZnChnAxtJ1zvpH+JC3N6PhE9Q/1tWn9HFysfV8pFWfTxc5CEm
 NooQKHeTszx+bKUL0PEhKav2Mt6qOmLL0S71vgw/KqxBWEd77SCu47MhR1Cmhw26/xWL
 6xoLeGcCKJ8SCUlgurkTTWXQLChv01YBfS79O4Pa9LCS96U6tPckNsa945AQafddPIzJ
 BFHw==
X-Gm-Message-State: AOJu0YzvzzecsJwqsZM8oxgSJwqFsw4TjCuyMliXLTOaFvDbCB0BObGw
 kHP+Dsn79h8VfeWns7N/x660m4fDt0BOXjVgPlEPIs5fmPknaSrrPkhH0Zood9d6/yq2TwmFQmk
 9
X-Gm-Gg: ASbGncunimRpx0eiOBifVeiABH12R8hgfYFwvQg0yXbxazhfpQDBOEPOuAjT/GIgyBN
 2FnIcw1kRt7kYfEVDaQ9ZDDn0AgFe0Ye+QMk+nyL+tb6AELE9u8P59j7DyB6O1jufxcYJY2wwYU
 JVGYfkpuaNxp4LkVOsdUwNpqrgFYmuTmHxhAX2IF5Oag8UwIAJHhxrz5SPygXllVSq8/8kch2Il
 NT2mCA8A0LITWxXvovAW5AB2XBCjpUQMAcNRVvwcfnsP4j2D9CRG77hql++B3jLo74T00EFCn17
 yQCn6iXNVGc4eIw=
X-Google-Smtp-Source: AGHT+IFJDDSYUKQXDqJTlFZ1cxBeIBhkg9vYakIH0/29ZFdYyK1bKoTAwL1Pd0Mo201yplTIctw3kg==
X-Received: by 2002:a17:903:32cf:b0:216:5af7:5a8e with SMTP id
 d9443c01a7336-21c355ec9c0mr55276985ad.26.1737138318206; 
 Fri, 17 Jan 2025 10:25:18 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/68] tcg/riscv: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Fri, 17 Jan 2025 10:24:15 -0800
Message-ID: <20250117182456.2077110-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
Message-ID: <20250108215156.8731-10-philmd@linaro.org>
---
 tcg/riscv/tcg-target-has.h | 112 +++++++++++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.h     | 102 +--------------------------------
 2 files changed, 113 insertions(+), 101 deletions(-)
 create mode 100644 tcg/riscv/tcg-target-has.h

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
index bfaa99ccdd..c710321bdb 100644
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
@@ -59,105 +57,7 @@ typedef enum {
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
+#include "tcg-target-has.h"
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
-- 
2.43.0


