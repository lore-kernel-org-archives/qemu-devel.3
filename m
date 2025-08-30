Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AD3CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOHA-0004Su-N9; Sat, 30 Aug 2025 12:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEUx-0008VJ-SE
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:51:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEUw-0005k9-7f
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:51:35 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso2648961b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756533092; x=1757137892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SotLYLgeVo+CKYkDdlihGsrrJawGkZPr42hZuKBjr+k=;
 b=bNk0MudOEpp8F4Gesp7RBN8nKg5TB+bi/3CCIYrWk309CG8NopjogXXZ3PbabO0XV2
 NALyCS5MUOalgz4TBMnZp0i4E3zsxwKYfA2XnkvASWuINcuAh25m+MewkPDs5zILO821
 A9Su5bZWELV52SUGkAYtQc6zCXDLsq/IV7t/5VdkDsWHjoMQAyGbADjigfkNHftIRz7D
 TnTKUAxBKnbtSxQWWZrky+RwqIL9yJLK513MlSfE6jr+cmu2E+vf3hSzD0lXIDFCBFIG
 xXHR5rUU2XA435ZuEi898epqu8qklPYfSLgmsmxQv/sjkvmh0OgDy586LN5ZcAwUoCS2
 WmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756533092; x=1757137892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SotLYLgeVo+CKYkDdlihGsrrJawGkZPr42hZuKBjr+k=;
 b=nTqo037OJ9BzjVpD4V1sQ7Bw547u2aPM/Lyu6HRHYDrIpIJc7ggbHltzWkB5WgHmtJ
 rJWSOjOvbT5REP0J+GFUP0Eo2CpemYUBixjdKrt5Dk4vX+5tjQQTtKMBcYl+ozjqJkwU
 ihMSaEEn6bs+oQFhQDbQqkIdXCmBQZoiTqhmj35zUdhr8vhc/F1N+RhkwdlmjQt6HRPu
 jZR9dOsbYUN+bisumuZmG1B5+NueuYbk99R5wjjbnBCuyBDLA3hDALBMrCdWT3ZG6JS3
 riO8LLwPQLPv0vQ7XJy07sNtGr3cQPaEVrj53QWcLMg902sTv4/UI1vxMQSyTjGrVSBe
 AqeA==
X-Gm-Message-State: AOJu0Yxz99WOoPsvzNZsBcJSfQAFCKnkOz8WlOz7gKThAAPE02u9ppE0
 xYLbGnjADm1ur7An2PAU+nJNugCmupPNFoD7jqYVbkJ+5CW5kXHwg6W4nD9smrXP1et8oKEI+x0
 qsPRtxf0=
X-Gm-Gg: ASbGncsWSfq8QPDd9W8mBx0TruwWdPapzCQETpHq5DlcdcMBKOsqNg6aLtMxgxhWIni
 A7G5pN+DljAK4LyfsoZjj/hgN5/Yrz8A38ZTaYTC66bgdbQIPfDACfJCFkUwEss3na1NUgXdTbz
 KI9diOZVlqwJHR3xaHaevy+h3IPB7+4z8XqUAqv1UyDlelcrUN8vGGQHciIqRaWijnY6RYcJgk+
 RmeRgmrL5uBD4IDWcvayeqSnFNc/Scsk8np6XNcE5dcULGaXoq1nwD8FAlqDzm0V2iJ0n3zSGZc
 vQhevbwIOlI4moKw5RRWuIXgnPRHeV2K8p3xeKNZHrOLJ+crpbHK4OJlu+4pciyW9OOx29TwJfU
 EkX/AYqtxIn4vtDBceExXB/S3fFhRQgFEiMOnXzM1/2HrI07LrY/4tIUIxaK+x14SPSJYt3sEbl
 bsy2C5WA==
X-Google-Smtp-Source: AGHT+IFnQct13X/zMXZsI476o3PsQYu+kyPIDXA3oT8qSW/M4/Vr5KwexQUC9gldC3yql+SagrbjDA==
X-Received: by 2002:a05:6a20:6a11:b0:23f:f99d:4661 with SMTP id
 adf61e73a8af0-243d6f08ebemr1614038637.38.1756533092001; 
 Fri, 29 Aug 2025 22:51:32 -0700 (PDT)
Received: from stoup.. (122-150-204-64.dyn.ip.vocus.au. [122.150.204.64])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a2b7d10sm4198475b3a.33.2025.08.29.22.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:51:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 83/84] tests/tcg/aarch64: Add gcspushm
Date: Sat, 30 Aug 2025 15:41:27 +1000
Message-ID: <20250830054128.448363-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Validate successful and trapped executions of GCSPUSHM, GCSPOPM.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/gcspushm.c      | 71 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gcspushm.c

diff --git a/tests/tcg/aarch64/gcspushm.c b/tests/tcg/aarch64/gcspushm.c
new file mode 100644
index 0000000000..c330417a2f
--- /dev/null
+++ b/tests/tcg/aarch64/gcspushm.c
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "gcs.h"
+
+
+#define GCSPUSHM  "sys #3, c7, c7, #0, %[push]"
+#define GCSPOPM   "sysl %[pop], #3, c7, c7, #1"
+
+static void test_sigsegv(int sig, siginfo_t *info, void *vuc)
+{
+    ucontext_t *uc = vuc;
+    uint64_t inst_sigsegv;
+
+    __asm__("adr %0, inst_sigsegv" : "=r"(inst_sigsegv));
+    assert(uc->uc_mcontext.pc == inst_sigsegv);
+    assert(info->si_code == SEGV_CPERR);
+    /* TODO: Dig for ESR and verify syndrome. */
+    uc->uc_mcontext.pc += 4;
+}
+
+static void test_sigill(int sig, siginfo_t *info, void *vuc)
+{
+    ucontext_t *uc = vuc;
+    uint64_t inst_sigill;
+
+    __asm__("adr %0, inst_sigill" : "=r"(inst_sigill));
+    assert(uc->uc_mcontext.pc == inst_sigill);
+    assert(info->si_code == ILL_ILLOPC);
+    uc->uc_mcontext.pc += 4;
+}
+
+int main()
+{
+    struct sigaction sa = { .sa_flags = SA_SIGINFO };
+    uint64_t old, new;
+
+    sa.sa_sigaction = test_sigsegv;
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        exit(1);
+    }
+
+    sa.sa_sigaction = test_sigill;
+    if (sigaction(SIGILL, &sa, NULL) < 0) {
+        perror("sigaction");
+        exit(1);
+    }
+
+    /* Pushm is disabled -- SIGILL via EC_SYSTEMREGISTERTRAP */
+    asm volatile("inst_sigill:\t" GCSPUSHM
+                 : : [push] "r" (1));
+
+    enable_gcs(PR_SHADOW_STACK_PUSH);
+
+    /* Valid value -- low 2 bits clear */
+    old = 0xdeadbeeffeedcaec;
+    asm volatile(GCSPUSHM "\n\t" GCSPOPM
+                 : [pop] "=r" (new)
+                 : [push] "r" (old)
+                 : "memory");
+    assert(old == new);
+
+    /* Invalid value -- SIGSEGV via EC_GCS */
+    asm volatile(GCSPUSHM "\n"
+                 "inst_sigsegv:\t" GCSPOPM
+                 : [pop] "=r" (new)
+                 : [push] "r" (1)
+                 : "memory");
+
+    exit(0);
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 0347a36e8d..c6f401c317 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -76,7 +76,7 @@ $(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # GCS Tests
-GCS_TESTS += gcsstr
+GCS_TESTS += gcsstr gcspushm
 AARCH64_TESTS += $(GCS_TESTS)
 $(GCS_TESTS): gcs.h
 
-- 
2.43.0


