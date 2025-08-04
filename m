Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB95C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0x1-0005De-6p; Mon, 04 Aug 2025 15:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06W-0001B7-4p
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:13 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06P-00013u-FX
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:11 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76bdce2ee10so2488947b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754332803; x=1754937603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+UBZqDttGYfj8iBFfEmX5S23CgoyF14FdfzJLxCYYE=;
 b=NZ5E+KjF7uCcMifWTrG1se1FYXpOS/apP7A4CGddapbLVmQcEEKnriktiq3pN7uqIP
 QlXTAuqzPcHITYUiCm+6WTplKxbsBF7h7L3qFU0ZMU/cRMrlrs7LLaRlP/m3aB0laXYc
 Op8/Yve7L8iHwQ1V+TmnMexK4mfJYTpPZWtc6AeWMmTHacge/abKodbEx5fImsvI4QBQ
 jTf7KhBQamYbaeVyPS1UZP+wOqtRenCMGLUyrkyNUAy2V18gT4KGBfD39F2DkDAHDE+/
 g2fd3xcI01/ONBj2Necc0MTTVYpRulPXCbdqcHUGrwzJxuqNdVprTns8BVbvDbqbibqb
 b/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754332803; x=1754937603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+UBZqDttGYfj8iBFfEmX5S23CgoyF14FdfzJLxCYYE=;
 b=gJkc6U3muonyY803jra1P3gvYWyIb35EWwMqaTLeb0wYEx+kOcJ4kz9uKdKp4EdQDK
 UcuJo3fFRbMSz9OlRz/cGCt+P7489UpDq+vIsC/PnNaXzvhOrNutc577SlKEBJ6DwkZ0
 1Y/YNEqzpR5zfW/VNfON6iIDtZZ7TE4CDy2GhDhv4tT8PKmnDoXYBzZdJJ5Am4OOINZz
 AqccFdhS1L17zij8gYByvqdgwCQjv5n3+u+DLI21DGb8mapSGucC9fMI4KT/P9WmYDEO
 ihFWvfCNyRECd5oNAY8fUkzxOkYJF6Rp1L9iWPBCHPu1/zxRnNzNbJudJlBinRfCRQBi
 FeBQ==
X-Gm-Message-State: AOJu0YxyZYGzt3xK5dpL8jE4+loKVqy44UOMH6j+5eu1CIZnTAw5zNH/
 gqmUItQsHp5tVkLRAMLDtsUee433x3Y1rL1yLeBZLLTaGrKR4tIHRzhQC5P0vPIO68bF6womk9g
 0qiiu
X-Gm-Gg: ASbGncu6yBDHGmmij9C385uPGotndkrD/7l/WjMDFDOGZDOBvTanFEhThnXXeAkydYi
 Lkm6gPi3JGBUwxZAe3ZPSfzEi9oY7tkfci8bEJC06jE5pMeZ/lOpedhRdD1zkTh/CRkGeUfGflp
 gyLFxUxW3XJ+GoqkQTRY7EgxUD2UyLIsZpxN41FPef6nKH7+OX9vmzodOGp0ogcKDjoylDmTe83
 xeqgA7+a9LQN6UlWI06zORedXWGSUtIy2Bmt9iiyOaxMLR5Q+ZuloSqZboWTgpZW467GM2KHGN9
 U1MvzPCAquAa9sVc6GqY0isWyHBNJRLh+s+LoghuG2IqG3V0mlGwYLwtuZOP0A3xloT7Ghys8+e
 Elv11aYhMRCClgiN38XgFIvw0XD6OFt4/
X-Google-Smtp-Source: AGHT+IHN31UnwxogKhOBjyr/yOzuKJQLWZsxa9xqp1VJ8C/E2SwAK0SWIuVQjl+MkwdnD/swD0JSEA==
X-Received: by 2002:a05:6a00:1254:b0:76b:e109:a1f4 with SMTP id
 d2e1a72fcca58-76bec4812c8mr13953681b3a.12.1754332803385; 
 Mon, 04 Aug 2025 11:40:03 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd78875cesm9940171b3a.15.2025.08.04.11.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 11:40:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 07/12] include/semihosting/common-semi: extract common_semi
 API
Date: Mon,  4 Aug 2025 11:39:45 -0700
Message-ID: <20250804183950.3147154-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We transform target/{arm,riscv}/common-semi-target.h headers to proper
compilation units, and use them in arm-compat-semi.c.

This way, we can include only the declaration header (which is target
agnostic), and selectively link the appropriate implementation based on
current target.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/semihosting/common-semi.h             |  6 ++++++
 semihosting/arm-compat-semi.c                 |  3 +--
 ...mon-semi-target.h => common-semi-target.c} | 20 +++++++++----------
 ...mon-semi-target.h => common-semi-target.c} | 19 +++++++++---------
 target/arm/meson.build                        |  4 ++++
 target/riscv/meson.build                      |  4 ++++
 6 files changed, 33 insertions(+), 23 deletions(-)
 rename target/arm/{common-semi-target.h => common-semi-target.c} (64%)
 rename target/riscv/{common-semi-target.h => common-semi-target.c} (59%)

diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index 0a91db7c414..aa511a46f42 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -35,5 +35,11 @@
 #define COMMON_SEMI_H
 
 void do_common_semihosting(CPUState *cs);
+uint64_t common_semi_arg(CPUState *cs, int argno);
+void common_semi_set_ret(CPUState *cs, uint64_t ret);
+bool is_64bit_semihosting(CPUArchState *env);
+bool common_semi_sys_exit_is_extended(CPUState *cs);
+uint64_t common_semi_stack_bottom(CPUState *cs);
+bool common_semi_has_synccache(CPUArchState *env);
 
 #endif /* COMMON_SEMI_H */
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 1c593d5e0dc..5877214c47d 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -174,8 +174,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
 
 #endif
 
-#include "cpu.h"
-#include "common-semi-target.h"
+#include "semihosting/common-semi.h"
 
 /*
  * Read the input value from the argument block; fail the semihosting
diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.c
similarity index 64%
rename from target/arm/common-semi-target.h
rename to target/arm/common-semi-target.c
index 6775a270aaa..2b77ce9c17b 100644
--- a/target/arm/common-semi-target.h
+++ b/target/arm/common-semi-target.c
@@ -7,12 +7,12 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef TARGET_ARM_COMMON_SEMI_TARGET_H
-#define TARGET_ARM_COMMON_SEMI_TARGET_H
-
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "semihosting/common-semi.h"
 #include "target/arm/cpu-qom.h"
 
-static inline uint64_t common_semi_arg(CPUState *cs, int argno)
+uint64_t common_semi_arg(CPUState *cs, int argno)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -23,7 +23,7 @@ static inline uint64_t common_semi_arg(CPUState *cs, int argno)
     }
 }
 
-static inline void common_semi_set_ret(CPUState *cs, uint64_t ret)
+void common_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -34,27 +34,25 @@ static inline void common_semi_set_ret(CPUState *cs, uint64_t ret)
     }
 }
 
-static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
+bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
     return is_a64(cpu_env(cs));
 }
 
-static inline bool is_64bit_semihosting(CPUArchState *env)
+bool is_64bit_semihosting(CPUArchState *env)
 {
     return is_a64(env);
 }
 
-static inline uint64_t common_semi_stack_bottom(CPUState *cs)
+uint64_t common_semi_stack_bottom(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     return is_a64(env) ? env->xregs[31] : env->regs[13];
 }
 
-static inline bool common_semi_has_synccache(CPUArchState *env)
+bool common_semi_has_synccache(CPUArchState *env)
 {
     /* Ok for A64, invalid for A32/T32 */
     return is_a64(env);
 }
-
-#endif
diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.c
similarity index 59%
rename from target/riscv/common-semi-target.h
rename to target/riscv/common-semi-target.c
index 663dedfdad2..aeaeb88d536 100644
--- a/target/riscv/common-semi-target.h
+++ b/target/riscv/common-semi-target.c
@@ -8,43 +8,42 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef TARGET_RISCV_COMMON_SEMI_TARGET_H
-#define TARGET_RISCV_COMMON_SEMI_TARGET_H
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "semihosting/common-semi.h"
 
-static inline uint64_t common_semi_arg(CPUState *cs, int argno)
+uint64_t common_semi_arg(CPUState *cs, int argno)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     return env->gpr[xA0 + argno];
 }
 
-static inline void common_semi_set_ret(CPUState *cs, uint64_t ret)
+void common_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     env->gpr[xA0] = ret;
 }
 
-static inline bool is_64bit_semihosting(CPUArchState *env)
+bool is_64bit_semihosting(CPUArchState *env)
 {
     return riscv_cpu_mxl(env) != MXL_RV32;
 }
 
-static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
+bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
     return is_64bit_semihosting(cpu_env(cs));
 }
 
-static inline uint64_t common_semi_stack_bottom(CPUState *cs)
+uint64_t common_semi_stack_bottom(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     return env->gpr[xSP];
 }
 
-static inline bool common_semi_has_synccache(CPUArchState *env)
+bool common_semi_has_synccache(CPUArchState *env)
 {
     return true;
 }
-
-#endif
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 07d9271aa4d..688b50a2e26 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -27,12 +27,16 @@ arm_user_ss.add(files(
   'helper.c',
   'vfp_fpscr.c',
 ))
+arm_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
+		        if_true: files('common-semi-target.c'))
 
 arm_common_system_ss.add(files('cpu.c'))
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
+arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
+		                 if_true: files('common-semi-target.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index a4bd61e52a9..fdefe88ccdd 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -8,6 +8,10 @@ gen = [
 
 riscv_ss = ss.source_set()
 riscv_ss.add(gen)
+
+riscv_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
+		     if_true: files('common-semi-target.c'))
+
 riscv_ss.add(files(
   'cpu.c',
   'cpu_helper.c',
-- 
2.47.2


