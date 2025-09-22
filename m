Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39296CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d0l-0004NV-02; Mon, 22 Sep 2025 05:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0czN-0002Ea-QA
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cz5-0000dw-CN
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:41 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46c889b310dso10739185e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533839; x=1759138639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S68QpsHReykX2B9M0K/3nvL5iS+xqDJkvSo3if0s2aI=;
 b=vsHsKGJkAXOMb4sNYH1hNwGMxUzlmntw3zgbQrq0p4MOnwdFJILHSnaWPKO9edMJQC
 u6m+OAG4IxN4ZAilJPUc9RfTm7W9o39VIR8/6j96BypKofS7S86wtbqgP/HEnwUNDsXz
 U5BX885a12/B5ImRlZiaQWdSBfFyjuAI4aKDwIAS5VDeXEsbksFUkmI/25rApeeRO6+k
 fVZoWSaY407LUKXur30DFxupmR+AlzHp5ZO7cFRkAWAUR8V543CNcvmmgX8npG75dEob
 vJfmX/Oij55dCuh9WHgGBXu8iokwnoVyUQy7dpXNipFDa0FRRGkITAg4e3q2MGdC3r9b
 hItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533839; x=1759138639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S68QpsHReykX2B9M0K/3nvL5iS+xqDJkvSo3if0s2aI=;
 b=kvJfoUr0nNF1SxQ3jUiDT2RF41XB8P7dFN9XFOcukvzVK9Fq5GjSvjJZq7RD03gL6a
 O/vfkYzIl6OOuPa2q9MCXKY5/LkVwOtw1lBW0BCsjmaXEmli27PbzdqpGnT+csohyp5p
 QTCPh98F8oVTZMUB/WuN5Nj4+A+0bhvpgdOtIvp+wA9x/4ySWmgQuDraHDKn3VfC+9Qk
 UrFeVPC3QtWe0Dj6xQrWiESzAHmpUyNro6JwVaEl7C23406shvxthQ6e6TgGrjuTPcsa
 w/gbUXLbILcBvBlWbq6YtcFI/+tK080lXOsemSmSuXLwUyx8sf8sHDBO2ApkhB2BLt0w
 +zuQ==
X-Gm-Message-State: AOJu0YyFaxkk5TTfH/EIbCf4RjGZHE8Iszg7Mw1FarAVWMHP5kFp/+hA
 fPK4SP/9woJpuHX5wkdwidtMubvGxXUf76tWybEqxdnsffiESNndzmu0uhSWp5uiv4I=
X-Gm-Gg: ASbGncu2ICmdNWFuDr2McALRa5ojU8vXLlSOtZkrdpTKJQedRBTE6Zp+9qt8V/4qRiO
 LRWm2scleIQIHFBhujOYExk8kfA7RxFSGPAsWnmV1CVkUx+OrQ9Hg7Y7wO+2h+AHJHhTuDq/kpF
 FV4jjtnP1YOE9GmFK6gKBvRfusE7vet+hg/V8wu5lYfuz2qvahfFPPTFt+yHEP81sMYGgjSX9dA
 DXssvhlO8tTNNcKfkHFRtiLXE0T2wfqA+p4Z8s3iUUT8zHjyhmaybGV8jTzPnIg5PzCySgE0AoM
 763Gu5nC3rv8iVm7cU71yisyyze1rb9aYq9sIaO3A0vvRmbmDQKko62ZXd1lZtHST9fUDM2hSzf
 tFmmpP1wnFD8f+ITxA/g2V95cWzIiM/5wNQ==
X-Google-Smtp-Source: AGHT+IFeOPrdmQ+WxCpZ0rgHiwmsA1CiCsZW8Euy1LaxjPRW6FsGah+A6P4UMQbCmou9rE1npfhClA==
X-Received: by 2002:a05:600c:4ec9:b0:46e:1a60:c995 with SMTP id
 5b1f17b1804b1-46e1a60cb3amr6265615e9.2.1758533839278; 
 Mon, 22 Sep 2025 02:37:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee073f4f3csm18495792f8f.2.2025.09.22.02.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:37:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 865CF5FA02;
 Mon, 22 Sep 2025 10:37:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 10/25] include/semihosting/common-semi: extract common_semi API
Date: Mon, 22 Sep 2025 10:36:55 +0100
Message-ID: <20250922093711.2768983-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


