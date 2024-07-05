Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4827C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPebT-00010a-8T; Fri, 05 Jul 2024 04:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebE-0000tP-PY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:27 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeb2-0004AU-RS
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:24 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7541fad560so157277566b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169231; x=1720774031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U6hurhQTjp832TOlAx+LCodgHfvL9JAd0ZCjMoFRr6I=;
 b=tloXcRzD/TdeBgMvGcAJw7duetYDQWUVFysuCIMfYrG9Kjeku+naNCo53+rdsr/w2r
 7u2rotExWPqrDmprKCDnG+sUIDvAIW37KUO8tNcTFndzYBnGm0gLeAW0MPsX5C3kv8ep
 yOnu5fkhvPMjc+t5C8R7LLdep/AcnU1xu9DO8td8iCSYKYXhM18QSx9JO7JQF1b5pZZt
 cgru0a8gGyMwUfm87Q7SgSLozGRhgnX32sSK1WKREX0u3YF5X3W/ICD0Q7iSa5RFilaB
 KWjEatUVAWxbvj/SRm8GTnoySSFpPF+i1lptDyZ+/17sTAZQxH1r9JRnibk6IxDbqlJK
 coVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169231; x=1720774031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U6hurhQTjp832TOlAx+LCodgHfvL9JAd0ZCjMoFRr6I=;
 b=hjOr/kfLvTJSRQWEzm6dXEEukvn02Z2bv31/UtwSYuE68hseAOz7DDojKVxZDwaSnc
 aWLoD79jiev+CFxxHqxas+fXOQOmMu/BOVW36IYgWKN03DXmfs1aBBKpRhMIIkwtIWlZ
 4JJPcfLjJWvsauUuFoEoebZO454v5gE64uytE4UCwVqlhLDKT4sYC2N3B+U6WE238ze+
 Zz+DC2ACQjYRZEKV8kRc913cm7pbwcodPqlqczzQmRzwccJGGclEyzbLBqMm+8soWahc
 BGsLsERkRko3FBeGoW5jDdzkCaFIwY21FeYuCEKjDfvYjK08ztScIe8Ft+kUxd1xMwIE
 8qDw==
X-Gm-Message-State: AOJu0YwmKu+xTB8rM5utbBxkvmiFLcWCnu+810IYQWgaZLsEV2u87eJo
 c9NB9fCFjsYB/aCO5aR/tPpb47n7bbG4TmnqJ/ThDCH/2rnUZv417FZYx+aWsi4=
X-Google-Smtp-Source: AGHT+IEubJGY+NDAKB0/iFr5NUae5zedXOgoBWbSGzbBjmJUi4vwkha4pOXNA4h47JqROyILcck8cg==
X-Received: by 2002:a17:907:97c8:b0:a77:a58f:7f6a with SMTP id
 a640c23a62f3a-a77ba70e417mr395665766b.38.1720169230781; 
 Fri, 05 Jul 2024 01:47:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77cd9637f4sm30271366b.57.2024.07.05.01.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:47:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2244A62176;
 Fri,  5 Jul 2024 09:40:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v2 35/40] target/arm: Factor out code for setting MTE TCF0
 field
Date: Fri,  5 Jul 2024 09:40:42 +0100
Message-Id: <20240705084047.857176-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
vAJB:
  - clean-up includes, move MTE defines
---
 linux-user/aarch64/mte_user_helper.h | 32 +++++++++++++++++++++++++
 linux-user/aarch64/target_prctl.h    | 22 ++---------------
 linux-user/aarch64/mte_user_helper.c | 35 ++++++++++++++++++++++++++++
 linux-user/syscall.c                 |  9 -------
 linux-user/aarch64/meson.build       |  2 ++
 5 files changed, 71 insertions(+), 29 deletions(-)
 create mode 100644 linux-user/aarch64/mte_user_helper.h
 create mode 100644 linux-user/aarch64/mte_user_helper.c

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


