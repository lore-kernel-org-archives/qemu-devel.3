Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244E4CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28L8-0007za-0T; Fri, 26 Sep 2025 09:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28L5-0007yW-FH
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kq-000434-T4
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso19540635e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892673; x=1759497473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BCG2zxRVNMR8qqgQNrkRM3H2KV89pqEU/0Kxiz6SNGs=;
 b=inb/EeDT92NDyOMLU3aCyMLXqU4mrNmN5/I67o7dI2JgVfpXA/ilfFqObJpfz9keyF
 jJhMqOOjJt3IfOAneWT/CkzsyMTgeqaSzeRoBLQ8APixnYHHKktGqXgAsiy+xGkC/bI5
 m57UdZ6AGIItfivCYLu1CQXGDvTOKrPt5Ew1stDywniAnCSbkgLCtKVAdFnfA8826PyA
 wfklX0FmS8vFNYJN+bZ/Q5+bEjS/nz6DK9MIFeD34BHkjgjnG6YeQx0H3L5Er9UX5k2C
 db91ZuwjKV6uMyxEpLKVu/pwOdeaJYTGAky6ZIowVErKIJ+JxdeyikF72wTlavYbmh9G
 4y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892673; x=1759497473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BCG2zxRVNMR8qqgQNrkRM3H2KV89pqEU/0Kxiz6SNGs=;
 b=khjVuCa6xnO2tPNjjp0XcSqG8RJyAoNSr1yOBc2verOXeuLfmKELndfYyZopjcMufb
 wWKptNtaiI6kVyYQUcKliXxKvdZLJjg7wZ2959HShPUqwQ34AlcQy7Xz7n4DKYxDkyDS
 FZogjmUB93djQkAQaXV5OYmu0Iok8pxxFrSOG61H8SvBIbBLqJ2kstpdnVEBvT7HeZZC
 vL9wThnXUw0f2ccYLqXL+UgWzu9oK5fCfdXJvupFA54Q4D2t2yd061HtPUrT5iRF6cVq
 6DIqgfzz7lJBRrI4cGma+7IGmOE2cZ7zE65Liyniu3tp5ez6P8GfynO15EdYGtJgmNHs
 Dq4w==
X-Gm-Message-State: AOJu0Yw+HNpe2mezh7EfhUOj6x/ZFs2i6FauIv9CvaKOHNV5N9pdsSf4
 QV+PQUCgFuCmI/xXoBMmhO2ODtB8sypjT0E5OFeYVQk35mxP8y9G9KlwWuwzNy46uO0=
X-Gm-Gg: ASbGncvIDh4+8irzh9gnDBy9VSWraVKTnlhI8BMSrhkBM1Y50oJHjuysAxN69QF6StV
 eVqOyNbwvKLIqTZzqYNeYZuxBvtt7754n5JmhXubOLBo7ZVjcShpv6jYaQDdqzd8gEtY3lEe03D
 aujcYj1w/7wJHIbz4auh5ysdv1Mi985+CQTruE19Fv5BVvYEROBcD+0Qdf86h3GOyvTksqxLoto
 YmoMVTFKG/j/ZU6q5j3PR0Q+LLWrPxXCsv+SP749xnKiSxeRhCdy3OKTFOKAJwuX0lxZjKb6pnu
 AAunbbx+S4mFbIr5OinTrTWoCBtWWaIPB1WYcBnL6kQehdCfFoAD9qKn0t7LDakZQk94rYGAH0D
 W1hDXk6VvaHKjMxqDGz2pAe23K4emkvEWPw==
X-Google-Smtp-Source: AGHT+IG/Z1CHmcnC8V6yiUjrh3LW698deD/3AqWNec9++O4aXrTGEA3ZBTGgV9oR3Qr4oAlOKRfbiA==
X-Received: by 2002:a05:600c:8b16:b0:45f:2bc1:22d0 with SMTP id
 5b1f17b1804b1-46e32aff787mr71284645e9.33.1758892673208; 
 Fri, 26 Sep 2025 06:17:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab6a514sm116613485e9.22.2025.09.26.06.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 978365F8EB;
 Fri, 26 Sep 2025 14:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 09/24] include/semihosting/common-semi: extract common_semi API
Date: Fri, 26 Sep 2025 14:17:28 +0100
Message-ID: <20250926131744.432185-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We transform target/{arm,riscv}/common-semi-target.h headers to proper
compilation units, and use them in arm-compat-semi.c.

This way, we can include only the declaration header (which is target
agnostic), and selectively link the appropriate implementation based on
current target.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-8-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-11-alex.bennee@linaro.org>

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
index 26263a06b7a..604a69e3646 100644
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
index 914f1498fc5..638ee62525f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -28,12 +28,16 @@ arm_user_ss.add(files(
   'vfp_fpscr.c',
   'el2-stubs.c',
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
2.47.3


