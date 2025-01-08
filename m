Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C475E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdyo-0000lu-Qy; Wed, 08 Jan 2025 16:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdym-0000cO-Lb
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:44 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyk-00043u-Js
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso2367995e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373161; x=1736977961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jmp/eIvUox9yzP6innBi1tkyaYkm/ULvVqWsjQV17u0=;
 b=pLoDqJMMiedSPIR6PUn/rDu8LWgUatvZ5dt9kzGcQpPjROru59fiZYMMIuho2e7t8A
 PUdx0LAURSWPKSdBTPbMsTrsRAcemKX/pQTJGqopi2T+dqApe65NV7U8rPm0wmzIoOOa
 +LC9YjQosLHxyBrDxaXjPLNDMjyIJTF1sgdzMOhcH05BciNFtP5NMQ6R62iPhP+wJMDn
 ZQDpi5HvtzC7lnUkwz5XBc6G7Ewb2EvhR2Dq2p0r0bfOHgrQtBs+GAhyCUESTiB2Jkrx
 pQ5TWEvtXE61bD0O3cTraDcwUYbXwJ17hjfayBLOMs3kFna6vgDh6oW80mj3qyMRw4lB
 HYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373161; x=1736977961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jmp/eIvUox9yzP6innBi1tkyaYkm/ULvVqWsjQV17u0=;
 b=ngVrK+6KK6Lvfug7v3r+Bkm8rD7wNaIha1XTAt+L3zjZhV1+uZDgqFKQITGHxv/97l
 RoQBJDpsUVaRap5ivVuy3G6wmf5AfbX8ory2QABQlYH0WNcfoZpy+cajZKta26G2qCT+
 5RrrgwrKoNmx+IhwpmLdWtkxDF+a3QOzV/lwyQbiFOvAynEhEKNvcB9w7cCCZKkjDDTU
 l0FBE2dTXBkZ06bqRnpc1wLd7ZkFPNx8aT5C4IHbuOlrdK8pW6ApZzjcTX76l7zT3i08
 wY9eKXlHr6ph8fkhmD1fXePVSodiWwpiw6VBUPWk3FIDTRcFFTmkBREBVmUcFD8zVjeg
 5JsA==
X-Gm-Message-State: AOJu0Yz17sEU6NCR76F8VwgCaxdx6EDD9XdgAHSoA38hOwyhzDeXHFx3
 H0EywejfhJzvS/TMRwfdzOa9olGiZ1HUp6a/6RoEmfbBb5WLkrZp4KD8zSLspzXaS2lmaMPaVAi
 bEW8=
X-Gm-Gg: ASbGncvUlEwKAtjoa+nxibNufNOxvLMt98sTmk0+eKjTwRT10cuERWCZpLycph4vYfC
 SllxVuSfFES6GwkwRlZnpHPezvaIpO2STmsGDE2nRqdZlEoM/jtSRW3VJRe6YK4vr+LVQI1vXC9
 SWqL8pnursF3dq2l5nVH/hOfCEzUmQQIGvov1nPXDpG+KnwPRnpvH40aM8OpblVzExcHMdo2DrR
 R9Btk7TpPuQHYjn27AkPSA2iVqdU3XibpY1eZN0MQ3Q4HcIonosuNFUUFqFwENS8TazYKEB6EWs
 Uo8sPSVDG6Lmv9Y/NkNKqONvLV7dA+M=
X-Google-Smtp-Source: AGHT+IHXc+piDVXHssXHIv+1pPXyEblpt+AzDjJcc+TRTZ6N7ucqvJnm4cMme+YHfE5eAlOxXUJCsg==
X-Received: by 2002:a5d:5985:0:b0:38a:2798:c3e0 with SMTP id
 ffacd0b85a97d-38a87358f3bmr3413659f8f.54.1736373160858; 
 Wed, 08 Jan 2025 13:52:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89df1sm33315515e9.27.2025.01.08.13.52.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/14] tcg/riscv: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Wed,  8 Jan 2025 22:51:50 +0100
Message-ID: <20250108215156.8731-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
 tcg/riscv/tcg-target-has.h | 112 +++++++++++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.h     | 102 +--------------------------------
 2 files changed, 113 insertions(+), 101 deletions(-)
 create mode 100644 tcg/riscv/tcg-target-has.h

diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
new file mode 100644
index 00000000000..ddc759a5339
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
index bfaa99ccddd..c710321bdb9 100644
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
2.47.1


