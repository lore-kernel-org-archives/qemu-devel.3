Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17EFC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPku8-0005o1-7P; Fri, 05 Jul 2024 11:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPku6-0005m6-6V
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:18 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktz-0000Sh-6e
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:17 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58b447c513aso2092292a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193470; x=1720798270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cFGUCF6aXfdVBiObpZIc6vFZvFIj8S4CeyY/mINKQs=;
 b=O0OcE8yq6tiE1hX795UrGKjsRy3xhJgfDvoLgmCSuOjVUsXwWMIhH+yK5N/QMVZPuj
 5iDO+WkCybMr01nkJMJpJn6htq3ulIpsTXmAqEXK4nkRObqOJ2+XxhSZ0BFZE1gFQEpx
 75HRdHGGLWWDDhobgRPJYbteyV4H7v1dE8PTsamynhwry4InFQS6WSi9zM7c9NKweGfE
 fBvM2CbFSRS9ZsVa/+SQ9b50M/AYKOlcJ3YfGh/qIL0wuQr0I7FQsOBKmI7h/ZwrErs8
 4iT7HWT2i44QiWyUCXqLM6Izzb5hqYzXtldLLgwxp0xTk6FMYCTAR6feBBfYNJRzbZ8/
 emgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193470; x=1720798270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cFGUCF6aXfdVBiObpZIc6vFZvFIj8S4CeyY/mINKQs=;
 b=j2NuYsWsOG7CdpHLQDg6rv/29Msd+kKVw4g3EQh0cfFMIP3va10x8dPvPp+QG4ZNoQ
 sh+cnq/3CMah3KPSHodJmTqZmXAb9+V7CqH6WoFyBtOw+hGmcXsU/oURFTJMhgvyBqeq
 E3HegEb6xyNODJqCjwY9JM6Oe69jQHDGGivHbyR6dGxBDtxwcHkeVwl9nsqxeMwZPIGi
 b7MVtSI0qna9moigCvBjTL/pQUXXATEUJ3mbUx1dSH9uoA3NuCDiM3USrD3P5oJkHwNu
 O44EB8+3ZZ3cXUgellm/QJIy1zPfikjViMbo3g1kTw1Jcidx7U7/KMO7x8+MBi52pAjf
 2dCA==
X-Gm-Message-State: AOJu0Yyw6jQyIGax3uqxbH9VCXJ9IT3aqOtxY7h1TKya0luuUwG5ZBSR
 Qfbdj68N04vaiyN1U0TeMxYVzzx/JMZVqRXDBY/H9exooXNUyiwAiXUoTJcAS9M=
X-Google-Smtp-Source: AGHT+IG2K7cA/ePZmnblXWY7PjDLAcdXRkoPuTCpt227Vdx7wfAi8XfRD8e+k7sEI4mPQ4ekceUU2A==
X-Received: by 2002:a05:6402:11c8:b0:58b:565d:ac92 with SMTP id
 4fb4d7f45d1cf-58e5b4a7759mr3682778a12.22.1720193468808; 
 Fri, 05 Jul 2024 08:31:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5907e4d79ddsm207464a12.59.2024.07.05.08.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:31:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5B65C62174;
 Fri,  5 Jul 2024 16:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 35/40] target/arm: Factor out code for setting MTE TCF0 field
Date: Fri,  5 Jul 2024 16:30:47 +0100
Message-Id: <20240705153052.1219696-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Factor out the code used for setting the MTE TCF0 field from the prctl
code into a convenient function. Other subsystems, like gdbstub, need to
set this field as well, so keep it as a separate function to avoid
duplication and ensure consistency in how this field is set across the
board.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240628050850.536447-7-gustavo.romero@linaro.org>
[AJB: clean-up includes, move MTE defines]
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-36-alex.bennee@linaro.org>

diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
new file mode 100644
index 0000000000..8685e5175a
--- /dev/null
+++ b/linux-user/aarch64/mte_user_helper.h
@@ -0,0 +1,32 @@
+/*
+ * ARM MemTag convenience functions.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef AARCH64_MTE_USER_HELPER_H
+#define AARCH64_MTE USER_HELPER_H
+
+#ifndef PR_MTE_TCF_SHIFT
+# define PR_MTE_TCF_SHIFT       1
+# define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TAG_SHIFT       3
+# define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
+#endif
+
+/**
+ * arm_set_mte_tcf0 - Set TCF0 field in SCTLR_EL1 register
+ * @env: The CPU environment
+ * @value: The value to be set for the Tag Check Fault in EL0 field.
+ *
+ * Only SYNC and ASYNC modes can be selected. If ASYMM mode is given, the SYNC
+ * mode is selected instead. So, there is no way to set the ASYMM mode.
+ */
+void arm_set_mte_tcf0(CPUArchState *env, abi_long value);
+
+#endif /* AARCH64_MTE_USER_HELPER_H */
diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index aa8e203c15..ed75b9e4b5 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -7,6 +7,7 @@
 #define AARCH64_TARGET_PRCTL_H
 
 #include "target/arm/cpu-features.h"
+#include "mte_user_helper.h"
 
 static abi_long do_prctl_sve_get_vl(CPUArchState *env)
 {
@@ -173,26 +174,7 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
     env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
 
     if (cpu_isar_feature(aa64_mte, cpu)) {
-        /*
-         * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
-         *
-         * The kernel has a per-cpu configuration for the sysadmin,
-         * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
-         * which qemu does not implement.
-         *
-         * Because there is no performance difference between the modes, and
-         * because SYNC is most useful for debugging MTE errors, choose SYNC
-         * as the preferred mode.  With this preference, and the way the API
-         * uses only two bits, there is no way for the program to select
-         * ASYMM mode.
-         */
-        unsigned tcf = 0;
-        if (arg2 & PR_MTE_TCF_SYNC) {
-            tcf = 1;
-        } else if (arg2 & PR_MTE_TCF_ASYNC) {
-            tcf = 2;
-        }
-        env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
+        arm_set_mte_tcf0(env, arg2);
 
         /*
          * Write PR_MTE_TAG to GCR_EL1[Exclude].
diff --git a/linux-user/aarch64/mte_user_helper.c b/linux-user/aarch64/mte_user_helper.c
new file mode 100644
index 0000000000..a5b1c8503b
--- /dev/null
+++ b/linux-user/aarch64/mte_user_helper.c
@@ -0,0 +1,35 @@
+/*
+ * ARM MemTag convenience functions.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "mte_user_helper.h"
+
+void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
+{
+    /*
+     * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
+     *
+     * The kernel has a per-cpu configuration for the sysadmin,
+     * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
+     * which qemu does not implement.
+     *
+     * Because there is no performance difference between the modes, and
+     * because SYNC is most useful for debugging MTE errors, choose SYNC
+     * as the preferred mode.  With this preference, and the way the API
+     * uses only two bits, there is no way for the program to select
+     * ASYMM mode.
+     */
+    unsigned tcf = 0;
+    if (value & PR_MTE_TCF_SYNC) {
+        tcf = 1;
+    } else if (value & PR_MTE_TCF_ASYNC) {
+        tcf = 2;
+    }
+    env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
+}
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e2804312fc..b8c278b91d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6281,15 +6281,6 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 # define PR_GET_TAGGED_ADDR_CTRL 56
 # define PR_TAGGED_ADDR_ENABLE  (1UL << 0)
 #endif
-#ifndef PR_MTE_TCF_SHIFT
-# define PR_MTE_TCF_SHIFT       1
-# define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TAG_SHIFT       3
-# define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
-#endif
 #ifndef PR_SET_IO_FLUSHER
 # define PR_SET_IO_FLUSHER 57
 # define PR_GET_IO_FLUSHER 58
diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.build
index 248c578d15..f75bb3cd75 100644
--- a/linux-user/aarch64/meson.build
+++ b/linux-user/aarch64/meson.build
@@ -9,3 +9,5 @@ vdso_le_inc = gen_vdso.process('vdso-le.so',
                                extra_args: ['-r', '__kernel_rt_sigreturn'])
 
 linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [vdso_be_inc, vdso_le_inc])
+
+linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [files('mte_user_helper.c')])
-- 
2.39.2


