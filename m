Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F63FD2C11E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8L6O-0000re-KP; Tue, 05 Nov 2024 10:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8L67-0000qP-No
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:04:01 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8L65-0000sY-Ut
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:03:59 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43193678216so47929655e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730819036; x=1731423836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQYS0DlDBWW5TkKFH2M/YnaXSSYT19q0Qc+ybblli20=;
 b=pmlHLf8gJChHXGGiHXvQtUF0FHiLMxXQnaHMt6t09DqRKiQF+bEVuKsjrhJuC0OQpa
 RuIP8YtvlADxs1FIbLGVciTYkxtD0qK8tDGjmqQ36RucYb06NDfa9XruwuhoxNQg4+PI
 V2uhwmjMvUdUnAdrE5G10+BnArJgpTs07sPgq4wW3baAvVjzGlmjXzJ66I0NgfezAs+c
 N2X2R2Z0JForzZXW7VllmhQhIQ6wvDwKsXa28X2Ag0CowGeljIF9Ze9BiF+leIlO0jXi
 KS2FZLCpXg7UzEbe3cztmRvwzdXG02od5l9h4NFdBxFQPqc5hbmvBveSruYzoUoNtUYY
 qK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819036; x=1731423836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQYS0DlDBWW5TkKFH2M/YnaXSSYT19q0Qc+ybblli20=;
 b=fZY+HyKplZkNEht7GIfVYyzv9Pg1BzYftL/Rs9pAn2hDA7Up5OMmCDvASb1im9XmuG
 NamkM2hUFMv+sSXrsLLFUf92npwCfSEusWAVxXHes11x4PTwaUd7nAHvDShdBLS6ZsFj
 W7cGi0zpBMRT/E9EoqRgsp56LqqkKKoZXvaFd9Du+PcRDrhAq4XtTHQvVUv2UsBSISxk
 2wT4HmdaCKs9BRLepGPQjMduhOV8Vl7maiTvLO1oT2PD8KC1V2aKOm/HGkHI/4JURlS5
 YEvqHBkPgeLwUvjgr+t2i4VNX3AbwsDegDoE8SQOFiioqLOIyjZiF+8QACjIzJDen1i0
 0Pkw==
X-Gm-Message-State: AOJu0YxaKu/8O6FLLwqJA8zmf4iWWpTRuEAqLd2dyvNNxGbJQsP4nFeV
 oPskPRM0/Km4SEXHzRUdcihbwc5KghECZlAiMQxW5bTty739IxMimS37kpuuLkGt9jJq7/fmNOw
 oy+s=
X-Google-Smtp-Source: AGHT+IHfs0QLAR/HgRKbdDddYcw1+vZL+Io3azI+3PGkpBJGEPgyiHIpc47AqMmCQ54YV1/HlZhQNw==
X-Received: by 2002:a05:600c:458e:b0:42c:baf9:bee7 with SMTP id
 5b1f17b1804b1-4328250f211mr168768985e9.12.1730819035876; 
 Tue, 05 Nov 2024 07:03:55 -0800 (PST)
Received: from stoup.. ([154.14.63.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca6f8sm221301855e9.39.2024.11.05.07.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:03:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 4/4] tests/tcg: Add SIGRTMIN/SIGRTMAX test
Date: Tue,  5 Nov 2024 15:03:48 +0000
Message-ID: <20241105150348.446982-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241105150348.446982-1-richard.henderson@linaro.org>
References: <20241105150348.446982-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Test the lowest and the highest real-time signals. This requires
configuring the real-time signal mapping, and therefore some knowledge
about the host. To this end, pass the emulator path in the QEMU
environment variable to all tests (this should not disturb the existing
ones), and assume that all hosts have signals 36-39 available.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20241029232211.206766-3-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/linux/linux-sigrtminmax.c | 74 +++++++++++++++++++
 tests/tcg/Makefile.target                     |  4 +-
 2 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-sigrtminmax.c

diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
new file mode 100644
index 0000000000..a7059aacd9
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
@@ -0,0 +1,74 @@
+/*
+ * Test the lowest and the highest real-time signals.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+/* For hexagon and microblaze. */
+#ifndef __SIGRTMIN
+#define __SIGRTMIN 32
+#endif
+
+extern char **environ;
+
+static bool seen_sigrtmin, seen_sigrtmax;
+
+static void handle_signal(int sig)
+{
+    if (sig == SIGRTMIN) {
+        seen_sigrtmin = true;
+    } else if (sig == SIGRTMAX) {
+        seen_sigrtmax = true;
+    } else {
+        _exit(1);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    char *qemu = getenv("QEMU");
+    struct sigaction act;
+
+    assert(qemu);
+
+    if (!getenv("QEMU_RTSIG_MAP")) {
+        char **new_argv = malloc((argc + 2) + sizeof(char *));
+        int tsig1, hsig1, count1, tsig2, hsig2, count2;
+        char rt_sigmap[64];
+
+        /* Re-exec with a mapping that includes SIGRTMIN and SIGRTMAX. */
+        new_argv[0] = qemu;
+        memcpy(&new_argv[1], argv, (argc + 1) * sizeof(char *));
+        tsig1 = __SIGRTMIN;
+        /* The host must have a few signals starting from this one. */
+        hsig1 = 36;
+        count1 = SIGRTMIN - __SIGRTMIN + 1;
+        tsig2 = SIGRTMAX;
+        hsig2 = hsig1 + count1;
+        count2 = 1;
+        snprintf(rt_sigmap, sizeof(rt_sigmap), "%d %d %d,%d %d %d",
+                 tsig1, hsig1, count1, tsig2, hsig2, count2);
+        setenv("QEMU_RTSIG_MAP", rt_sigmap, 0);
+        assert(execve(new_argv[0], new_argv, environ) == 0);
+        return EXIT_FAILURE;
+    }
+
+    memset(&act, 0, sizeof(act));
+    act.sa_handler = handle_signal;
+    assert(sigaction(SIGRTMIN, &act, NULL) == 0);
+    assert(sigaction(SIGRTMAX, &act, NULL) == 0);
+
+    assert(kill(getpid(), SIGRTMIN) == 0);
+    assert(seen_sigrtmin);
+    assert(kill(getpid(), SIGRTMAX) == 0);
+    assert(seen_sigrtmax);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 9722145b97..95ff76ea44 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -179,10 +179,10 @@ run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true
 
 ifeq ($(filter %-softmmu, $(TARGET)),)
 run-%: %
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<)
+	$(call run-test, $<, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) $<)
 
 run-plugin-%:
-	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
+	$(call run-test, $@, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) \
 		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<))
-- 
2.43.0


