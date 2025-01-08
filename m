Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69727E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdyS-0008LQ-KD; Wed, 08 Jan 2025 16:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyP-0008IU-Lk
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:22 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyM-00041W-Pi
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:21 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e06af753so140724f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373137; x=1736977937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPc0RMXPFSRjmvC46uKlBuUNK0EsBD0eabl7VwWoO+8=;
 b=Ty71UYrhmIlS4zFTQwOS/uqWGnrg+TNNBCY+Mq4dHJN7ECytLQODUeLTFbxKLMD7pJ
 Bf2eJLUC5OVraO9NeMQCwn5ph9g4oXITnnoNCisTPU9RfU7kJzaeVbIJW9W2aKdTeO/3
 jVFQYNnDM4TXe/8dAA+pjTaGooonTtr34RcEms1emAdJx6uD+Xy12QRztc8OXZntssK5
 p6hiC27OpFRWgurMqGckFwVuQ7/+zcsiASlh8M3ErWk/pKvqHq3dQ4anssjfA+UHh0P7
 MYHJBpdlMDzpvZebsD4whfUP324WsMDUNEk7qdkzzGyITbTyBpQ+6GJa8CaN2yK6kxCK
 Nt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373137; x=1736977937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPc0RMXPFSRjmvC46uKlBuUNK0EsBD0eabl7VwWoO+8=;
 b=LmJpv3ISkxv6exmdMjJ/Wan55j31vm7zfq5djHr9YFPb8NGwKQrLGG4mNyNdWwrORp
 yTHbLRg9ZM3FbyxYeHFJPTHTahsW2hj45BcFPTQ07ywNVu3oqi6f3GBjx+kiyLsgXseG
 rwus3IFqoTtGsf7+83Lpo2VKRim32Lk1soGqIkBGDWqiOuTQm2Pll8U0CpjK/DBz3zDW
 ny6+ofFqlUphMWpa+vlYpw9imlOCCtWgtF77CXdxBpQVeQnA2wYIIMVcWRgqM1qMk5hQ
 37s+WTVBwyiAJeejzX8SMP/lhzbqEbjQVf6bsHBj+hg1u/+VktXJ403i7FAqnjeEpBIA
 Iddw==
X-Gm-Message-State: AOJu0YzzeMaKP7hinTAONP9+FttVwenbax2EIWBC7VAivLrMyRP6/BEY
 eBhpZnrZsQN54DLqfRga4Y1pFcb/8m4bTe+Fp0i7LocJ3q1bQIyZy4PX1DTB5n8LAhbTaAolaRI
 Ez1A=
X-Gm-Gg: ASbGncuVZRSTc5IW/jwCj898rwOJsCLFn1xQ0Ync5CnEWL576j3ymlgzoDXSRtjnBVw
 adpUPnq7N4KOpWS4Ci/Y53UlB7jrbojfORHfSlpwwNiXJnxG9aHTNh5k6EiLfUGHf57MrjR6DFh
 8NMp2EAdIszUQN06+yGxnc1h9NENNSvqCFBxMDf3b3chchspMaHoFGzLEa8ADpNtGxQNGilx3JV
 KdBGNfQZXi+krUCU0+9UFiD0FRVnfV75+NDRM0lbekiWhY0Te5kLXuGItBvp6FnXlzon7J5+xnK
 vwsOJ3Q6JrKAbpR5m8GJ0giOGUzN7X8=
X-Google-Smtp-Source: AGHT+IGsvvxY4jaTAhAtgS1ZgVuT3y6RhJDEwtNOUP/Qsox+r/Zc6L8dpRVgoBVNIdBXPfShgNtj8Q==
X-Received: by 2002:a5d:64eb:0:b0:38a:50fa:d582 with SMTP id
 ffacd0b85a97d-38a87363364mr2894960f8f.59.1736373136966; 
 Wed, 08 Jan 2025 13:52:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e4ebsm54316355f8f.85.2025.01.08.13.52.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/14] tcg/arm: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Wed,  8 Jan 2025 22:51:45 +0100
Message-ID: <20250108215156.8731-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
 tcg/arm/tcg-target-has.h | 85 ++++++++++++++++++++++++++++++++++++++++
 tcg/arm/tcg-target.h     | 74 +---------------------------------
 2 files changed, 86 insertions(+), 73 deletions(-)
 create mode 100644 tcg/arm/tcg-target-has.h

diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
new file mode 100644
index 00000000000..316185500d3
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
index 7f6e24f8610..e114f7ddf40 100644
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
 
@@ -74,75 +70,7 @@ typedef enum {
 
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
+#include "tcg-target-has.h"
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
-- 
2.47.1


