Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A6CCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CrK-0001JS-KG; Fri, 10 Oct 2025 09:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqn-00088X-OK
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:06 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cph-00043n-Ke
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:01 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso2102405f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101608; x=1760706408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3+Uyipy5WYcfFoRYRBjLlCVzYQeAzJFqsqmDid0vZ3g=;
 b=DN6E3Z/ZZw8Uj1gosFjkvifNPyWVvv1ggL4N192aSSUjufwvIBIEPZgsY7TpNn73OF
 MPe9rDio/7+G4+GvcIu59qzac68X4OaJfGrzkweqB/j91K7uA+hnAELc9Fsj8E24fJvW
 suqJ11K+wMpH2dTvpRLBrYn9reSMqDoVUPSf3ESHPbhEMyGokl+NcNdvhUYoe3Vz74Qp
 bhDam3iFIjUYGvJQG3UxYt9n9ZzMYOfQbsFf45Y4hOMf6EPjhnM68PY2g520RrorW+Z2
 53MtbJTMhe9wAhxTuVJuG/qchbAFvDGCsw7PP3pC4HJGwkT+cJ/Ma7mGkj/GiWc4GR0N
 +51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101608; x=1760706408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+Uyipy5WYcfFoRYRBjLlCVzYQeAzJFqsqmDid0vZ3g=;
 b=lnOalxtVXTwUWrcfAqLlA7NN6//snEfW6JS6LnGXjQiQ+0hgStPSyaR+qEHwYVYUsJ
 3m6ZpqlYHnHUSEPlrghvmEqSSXpytg0zjSpxj/lNzzIDWK+fjZzCyHQKE0WNui3ARhvv
 oNdeRWvnZ2ZKTUO188XfQeLo2XWUzKWORJnBB15GUK53j0kaAnQ5iuxpI9i5EWdBKJGS
 tAdYmbhqHSO1/khlpwPSfxJft6rAxmrOEh8NS0HJF7HHYuuYuTdRBO/6ymcom3qJl6yf
 8+VbXR13izIYRstjDljsPPY3+w080KR4Sl7AqKVXFSdOFYo1TMtijSD8roiDgbKyd+EO
 wLqQ==
X-Gm-Message-State: AOJu0YwAh/dEe0/9pKzjuQClt5S3pHGuoNBUetilllU0G2Lo08kj6h7m
 h4/9aUcl4tpgjIzkgwfx0aQ6/u29wfRZqYnnsc+jY7gM97hX9QiY1jl643+i4tmf/FVydocHcUd
 Oqlao
X-Gm-Gg: ASbGncv8gUsvjtW0eh861zPgB5fLOKJKjU0wkeAiQvxLy9LcutQ6r45Ct4ttivap5cl
 SrZXVj/npFqjYQWO9UIMakC4G376/meogK7Uxrgcxc4viNb9ST70iazRWICyquJ7Vot+bAjWQMX
 jmr1ojXo7bV+Qbj8SpQ663dVZcvU6ayVIbcu+xTocYMf+LJzqhijlEjy5cZ8iLw9ZXauf9COxcQ
 clQyQAB7KaaiWwWTRcxxvS70H2jQO62rQWghN4ohtV5KORxekvaGI5TSl+kb5ywyKDGZSl1Fihc
 zhfbe0MqvJAu4UiYi8FR9VZRx5hh0fvKhiV4kuy6oQN60iR02ZJINl0cV1K2dhlupDZuLMyMor/
 z3mrxtfF9/L/7PUnR87yr2mYxyeZGJZG8Q2erztt/UML2j3rOZ0Z9M7XUrA1Wnw==
X-Google-Smtp-Source: AGHT+IGdQOhAdYcUs0e1MDJZd7qHFE1wtsvVY1q0B3gvEGOwqxinBXq1Nd3arslnYORuGdupIy1Kkg==
X-Received: by 2002:a05:6000:26c9:b0:425:74e1:25f7 with SMTP id
 ffacd0b85a97d-4266e8e6d0amr7465295f8f.62.1760101607912; 
 Fri, 10 Oct 2025 06:06:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 71/76] tests/tcg/aarch64: Add gcsstr
Date: Fri, 10 Oct 2025 14:05:22 +0100
Message-ID: <20251010130527.3921602-72-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Add some infrastructure for testing gcs in userspace.
Validate successful and trapped executions of GCSSTR.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-72-richard.henderson@linaro.org
[PMM: fixed hardcoded tabs]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/gcs.h           | 71 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/gcsstr.c        | 48 +++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  5 +++
 3 files changed, 124 insertions(+)
 create mode 100644 tests/tcg/aarch64/gcs.h
 create mode 100644 tests/tcg/aarch64/gcsstr.c

diff --git a/tests/tcg/aarch64/gcs.h b/tests/tcg/aarch64/gcs.h
new file mode 100644
index 00000000000..770cde6a85a
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
+#define PR_GET_SHADOW_STACK_STATUS      74
+#endif
+#ifndef PR_SET_SHADOW_STACK_STATUS
+#define PR_SET_SHADOW_STACK_STATUS      75
+#endif
+#ifndef PR_LOCK_SHADOW_STACK_STATUS
+#define PR_LOCK_SHADOW_STACK_STATUS     76
+#endif
+#ifndef PR_SHADOW_STACK_ENABLE
+# define PR_SHADOW_STACK_ENABLE         (1 << 0)
+# define PR_SHADOW_STACK_WRITE          (1 << 1)
+# define PR_SHADOW_STACK_PUSH           (1 << 2)
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
index 00000000000..b045aee9251
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
index 1755874beed..5e1b3a33851 100644
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


