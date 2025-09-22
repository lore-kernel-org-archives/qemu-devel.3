Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AABCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ljI-0002vT-6w; Mon, 22 Sep 2025 14:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lgV-0006CY-IA
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfY-00053d-Pj
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2570bf6058aso63818925ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567224; x=1759172024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqQF3KdzeOa+e2b5cPo9hbNNnmvLOG1QQkCMhq6keuI=;
 b=lWmdYpuVhJKkAfxVpvC5jdbCNwdR5MpN1NljerfewHRjkPIzdCb3DMWwRIC9ETTMMa
 dWitmNWLZ8FTYNLBvhfLz1mS6iREZGbxCc5FSf9J/SS/SDVsfhR7vzm75CEnGbZ+papd
 RSTsnM87RqgkudccgGgkY1b4vqnSlQ7YXUw3hwxpckO4IzcLTIITf9FTxnJKVxRHFUMY
 G+wa8VxOUw0DeYfN0aU2094j37EVhJpgFmRBbs12PyB03S+NIzrKsnLlhooM8cG/UWeP
 TDdFmZ0CA2VujBz/vSAHo5gu83AsyreSPAk3pE1CL9XIIZiBOVTValFfCO14g5t4adJd
 7TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567224; x=1759172024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqQF3KdzeOa+e2b5cPo9hbNNnmvLOG1QQkCMhq6keuI=;
 b=HNeORfV3HZMQ33obCHdxknDuZfvrd50hw7Y9YjY8q6FkqbwgeCWS6zZPKBuvd24blt
 iAvcKGiMLfbLbCg/He9YU2GwmWSvJhjJEEe/AlKSqNMT6Det6tr0M+xvX6Zk9VwBkFEQ
 ipDeHJQqt2Rz1iyndt0eRvBP+Cz2x68LztooM4x/DaLu6/nC/9/s6RI4SbhsiFY00jp9
 DK7AGge+RNaBQLJx+TU7p8g5nqTzpH1r/YMtmkMhGDXXiX5ZID8UfJ32zW3NyXG5NJ/G
 IFsUkJVRL329qyeZ951stWY+nP+xN2V7TnVO5vf+uC5L6lPehEMTJs02FPDGlEWieRt7
 fvgQ==
X-Gm-Message-State: AOJu0Yz0AE4HCqlzLr0ttjmaJpk517WEOKPg8W5XNbXASz7U/DJZGong
 3d1v9xD93fNa1kLUbgC9dc+IVTf/3R/hC5/NOdjS9ylk2z0LydBbIozFKEXkmrdWWwoy3Owx7V7
 hlifP
X-Gm-Gg: ASbGncvQ6X9YYpj/fCFG0nYMK/5UkW/S3I6vO1gnpRMk+9jZ+6/iuZMNy73w5qArqUx
 Y2lDqYGS4jRdVMpv0MUZXIQkuKF04nBSJPYr6Y6U/3yRojXQtmH4S9iJopN7GpYNGs49xVJyvTC
 WBWCs8gWVBZzzLZ8+8VdqRmmNa60t85j5DvdygRj7w9V1+oc2sLvE6t+kEQ1/cu5jJ1fKH6+dAd
 xvWUIuanEuvIzLdQWK4MWZREbe+WnRPivChaElGyoWhX3xxdd8NzVrzA+A2B1pj/4elP/mCScW0
 WQKLI0IttetU8igN+qZN5sJxRa+DhPEFUf8bwOQjmoQamyzOW162Vb8mcLSdHvRvmwFtWjpceJB
 iHvvzdyJ8WvIh3Otx2CBV9dQ1qfPk
X-Google-Smtp-Source: AGHT+IERdfGOF+/TK4ebST3uTT2B5fMvjC1CwBiMDWf8Y8KEbhbcONUP7DEkrhZX7GHJbpcwGrid2g==
X-Received: by 2002:a17:903:44cb:b0:269:9719:fffd with SMTP id
 d9443c01a7336-269ba402239mr147127235ad.1.1758567224221; 
 Mon, 22 Sep 2025 11:53:44 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 74/76] tests/tcg/aarch64: Add gcsstr
Date: Mon, 22 Sep 2025 11:49:22 -0700
Message-ID: <20250922184924.2754205-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Add some infrastructure for testing gcs in userspace.
Validate successful and trapped executions of GCSSTR.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/gcs.h           | 71 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/gcsstr.c        | 48 +++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  5 +++
 3 files changed, 124 insertions(+)
 create mode 100644 tests/tcg/aarch64/gcs.h
 create mode 100644 tests/tcg/aarch64/gcsstr.c

diff --git a/tests/tcg/aarch64/gcs.h b/tests/tcg/aarch64/gcs.h
new file mode 100644
index 0000000000..99cb4d4e38
--- /dev/null
+++ b/tests/tcg/aarch64/gcs.h
@@ -0,0 +1,71 @@
+/*
+ * Linux kernel fallback API definitions for GCS and test helpers.
+ *
+ * Copyright (c) 2025 Linaro Ltd
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+
+#ifndef PR_GET_SHADOW_STACK_STATUS
+#define PR_GET_SHADOW_STACK_STATUS	74
+#endif
+#ifndef PR_SET_SHADOW_STACK_STATUS
+#define PR_SET_SHADOW_STACK_STATUS      75
+#endif
+#ifndef PR_LOCK_SHADOW_STACK_STATUS
+#define PR_LOCK_SHADOW_STACK_STATUS     76
+#endif
+#ifndef PR_SHADOW_STACK_ENABLE
+# define PR_SHADOW_STACK_ENABLE         (1 << 0)
+# define PR_SHADOW_STACK_WRITE		(1 << 1)
+# define PR_SHADOW_STACK_PUSH		(1 << 2)
+#endif
+#ifndef SHADOW_STACK_SET_TOKEN
+#define SHADOW_STACK_SET_TOKEN          (1 << 0)
+#endif
+#ifndef SHADOW_STACK_SET_MARKER
+#define SHADOW_STACK_SET_MARKER         (1 << 1)
+#endif
+#ifndef SEGV_CPERR
+#define SEGV_CPERR  10
+#endif
+#ifndef __NR_map_shadow_stack
+#define __NR_map_shadow_stack  453
+#endif
+
+/*
+ * Macros, and implement the syscall inline, lest we fail
+ * the checked return from any function call.
+ */
+#define enable_gcs(flags) \
+    do {                                                                     \
+        register long num  __asm__ ("x8") = __NR_prctl;                      \
+        register long arg1 __asm__ ("x0") = PR_SET_SHADOW_STACK_STATUS;      \
+        register long arg2 __asm__ ("x1") = PR_SHADOW_STACK_ENABLE | flags;  \
+        register long arg3 __asm__ ("x2") = 0;                               \
+        register long arg4 __asm__ ("x3") = 0;                               \
+        register long arg5 __asm__ ("x4") = 0;                               \
+        asm volatile("svc #0"                                                \
+                     : "+r"(arg1)                                            \
+                     : "r"(arg2), "r"(arg3), "r"(arg4), "r"(arg5), "r"(num)  \
+                     : "memory", "cc");                                      \
+        if (arg1) {                                                          \
+            errno = -arg1;                                                   \
+            perror("PR_SET_SHADOW_STACK_STATUS");                            \
+            exit(2);                                                         \
+        }                                                                    \
+    } while (0)
+
+#define gcspr() \
+    ({ uint64_t *r; asm volatile("mrs %0, s3_3_c2_c5_1" : "=r"(r)); r; })
diff --git a/tests/tcg/aarch64/gcsstr.c b/tests/tcg/aarch64/gcsstr.c
new file mode 100644
index 0000000000..b045aee925
--- /dev/null
+++ b/tests/tcg/aarch64/gcsstr.c
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "gcs.h"
+
+/*
+ * A single garbage store to the gcs stack.
+ * The asm inside must be unique, so disallow inlining.
+ */
+void __attribute__((noinline))
+test_gcsstr(void)
+{
+    register uint64_t *ptr __asm__("x0") = gcspr();
+    /* GCSSTR x1, x0 */
+    __asm__("inst_gcsstr: .inst 0xd91f1c01" : : "r"(--ptr));
+}
+
+static void test_sigsegv(int sig, siginfo_t *info, void *vuc)
+{
+    ucontext_t *uc = vuc;
+    uint64_t inst_gcsstr;
+
+    __asm__("adr %0, inst_gcsstr" : "=r"(inst_gcsstr));
+    assert(uc->uc_mcontext.pc == inst_gcsstr);
+    assert(info->si_code == SEGV_CPERR);
+    /* TODO: Dig for ESR and verify syndrome. */
+    exit(0);
+}
+
+int main()
+{
+    struct sigaction sa = {
+        .sa_sigaction = test_sigsegv,
+        .sa_flags = SA_SIGINFO,
+    };
+
+    /* Enable GCSSTR and test the store succeeds. */
+    enable_gcs(PR_SHADOW_STACK_WRITE);
+    test_gcsstr();
+
+    /* Disable GCSSTR and test the resulting sigsegv. */
+    enable_gcs(0);
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        exit(1);
+    }
+    test_gcsstr();
+    abort();
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 1755874bee..5e1b3a3385 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -75,6 +75,11 @@ AARCH64_TESTS += $(SME_TESTS)
 $(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
+# GCS Tests
+GCS_TESTS += gcsstr
+AARCH64_TESTS += $(GCS_TESTS)
+$(GCS_TESTS): gcs.h
+
 # System Registers Tests
 AARCH64_TESTS += sysregs
 
-- 
2.43.0


