Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5315C109447F
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 13:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3wp3-0008Uy-DL; Sat, 21 Mar 2026 09:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3wp2-0008Ub-C5
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 09:57:00 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3wp0-0000W5-KE
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 09:57:00 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b0603ee486so19649295ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774101416; x=1774706216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lIthGQhk0jMuFWhQ1BF4ILV2kWgl3q/gQbn7PvztXD8=;
 b=SsCzNOPbPvxjt8qnrIKE1Cb4LHLPo4O+XXqGnFfTy+Ob8yvX5dYzL3cWjdJbr55970
 0oRW5tK67g2Dr0dBl4nlKvktnVijntdBJJ6/rgv7ckgEYB8Q00o/zuVn8EUTZfU7pbM/
 q32Ph610rgOUZTUainHq5jsfzzNY62+n14+wzfJrotQjYYc7Sdkp6ZVxL5HQtap2KeT6
 kQ0C+PD2HUa2ShDBGDTxd/uLojDACarguJy1hN3wkTtWSZncZ1zii13yfkyDCx0p2hxj
 L2Pb8B+Dj2MSZPPjga9ndv9b1NYOf+V0aW6vyFkga48ZLQlRRQe8cK5OH+YTd8sfv797
 kc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774101416; x=1774706216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lIthGQhk0jMuFWhQ1BF4ILV2kWgl3q/gQbn7PvztXD8=;
 b=IzBa3VGcR5iE72QxYUKVsWQ0zj+xpsgh7xKlqq5sKK7TmDHij7FdbfYbiiHc+4vwXx
 KTjhCCjOyzppumF08LspTBE33lNSc466iZcZiEJLjUCyAyT6vlIKWOVjUY4GxyveVEw9
 cjhUuhxfBPPVn0DIEkGFUnP0fMnVOHuCLCPBBot9AKUKF59SCDqHkg7RH4x6i96GvAvf
 WaVu0oNJW6DrgyG8EZmk4FQG6YMrK9aHIeIsLaD6NfeBQAfaX9mI6d+paeemikMfwfhp
 LWq0IB4Rl8wS5S2xywu10PXpTYK4uqeuh3P7C7UVk/ml6qKreqx2xBlmKUFJ9yBHXG3C
 UdlA==
X-Gm-Message-State: AOJu0YwwHnwnCz7XHdFA6IoGhLFQmRRIqc7oJXkCTO62+nqSy/VZZ8Yu
 Nj4uRxF+JCsXPvadB6AgnKPmpH/+zUaeB4f0yXot6N2diTkOy7Yr6bAbt3B8jg==
X-Gm-Gg: ATEYQzwTD28R9rBib3O0EEldDDOSdd8SqwuzTn1g80wyRdAs3s9jj2xIMowBMQ+EmTJ
 nEVjBUO3GCPAiZJeI7s0+fUc0DQCbBsyV/S8WO//gL+DwSLlaglfyRfFsCvliFfMLzHwMVeMfB/
 cBMofxs+4g+icL/lgOLVqxaowqCIvKPCmoVMbYMtJEoxRSaBonqeZvA8NvwAvMziQ0n+kz9qc4w
 EGr4WvN+7gk0xMJVVbdjlDsqh9y1S7z7LTojzpvJoZ6ATeZ2UcWRVspC7O3L57QVjG5atvrPmcg
 9r8nzAZdQ0o0xYC1nz6TPmSYDRvIDxNLDuCQWgXaytbTOdjiztwHIXa1ithrADcTh0ew7bePZ16
 PMa5ETcBrqKw22OA8FYhNlQu4d2uUZqSlqQ2qqQziQkzp83b9GhT4ybOpQHbFBVTtwzaiAeTAI9
 X/ZlnefEfOnK6XFb0kfc8z+kssM+O81qJfDo1llkjLNzs2+/V/q4BhKofXVEmrteyjlsXs
X-Received: by 2002:a17:902:e811:b0:2b0:7b57:830f with SMTP id
 d9443c01a7336-2b082769cccmr56869405ad.33.1774101415916; 
 Sat, 21 Mar 2026 06:56:55 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08354bce3sm66285675ad.32.2026.03.21.06.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 06:56:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/3] tests/tcg: add recursive signal delivery tests
Date: Sat, 21 Mar 2026 23:56:23 +1000
Message-ID: <20260321135624.581398-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321135624.581398-1-npiggin@gmail.com>
References: <20260321135624.581398-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add tests which exercise a synchronous signal being raised in
synchronous and asynchronous signal delivery paths. It does this by
delivering them with an altstack that is made inaccessible, then
catching the badframe SIGSEGV with a handler on the regular stack.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/tcg/multiarch/badsig.c | 226 +++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)
 create mode 100644 tests/tcg/multiarch/badsig.c

diff --git a/tests/tcg/multiarch/badsig.c b/tests/tcg/multiarch/badsig.c
new file mode 100644
index 0000000000..0f346f4147
--- /dev/null
+++ b/tests/tcg/multiarch/badsig.c
@@ -0,0 +1,226 @@
+/*
+ * linux-user "badframe" signal handling tests.
+ *
+ * Copyright (c) 2026 Tenstorrent USA, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Test "badframe" signal handling paths, which force a
+ * SIGSEGV signal from the signal handler setup code,
+ * which tests the recursive signal "restart_scan" logic
+ * in process_pending_signals().
+ */
+
+#include <stdarg.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <assert.h>
+#include <errno.h>
+#include <pthread.h>
+#include <string.h>
+#include <signal.h>
+#include <setjmp.h>
+#include <time.h>
+#include <sys/time.h>
+#include <sys/mman.h>
+
+#undef DEBUG
+#ifdef DEBUG
+#define dprintf(...) printf(__VA_ARGS__)
+#else
+#define dprintf(...)
+#endif
+
+static void error1(const char *filename, int line, const char *fmt, ...)
+{
+    va_list ap;
+    va_start(ap, fmt);
+    fprintf(stderr, "%s:%d: ", filename, line);
+    vfprintf(stderr, fmt, ap);
+    fprintf(stderr, "\n");
+    va_end(ap);
+    exit(1);
+}
+
+static int __chk_error(const char *filename, int line, int ret)
+{
+    if (ret < 0) {
+        error1(filename, line, "%m (ret=%d, errno=%d/%s)",
+               ret, errno, strerror(errno));
+    }
+    return ret;
+}
+
+#define error(fmt, ...) error1(__FILE__, __LINE__, fmt, ## __VA_ARGS__)
+
+#define chk_error(ret) __chk_error(__FILE__, __LINE__, (ret))
+
+static bool do_siglongjmp;
+static sigjmp_buf current_sigjmp_buf;
+
+static volatile int total_alarm_count;
+
+static void sig_alarm(int sig, siginfo_t *info, void *puc)
+{
+    if (sig != SIGRTMIN) {
+        error("unexpected signal");
+    }
+    dprintf("SIGRTMIN\n");
+    total_alarm_count++;
+}
+
+static volatile int total_segv_count;
+
+static void sig_segv(int sig, siginfo_t *info, void *puc)
+{
+    if (sig != SIGSEGV) {
+        error("unexpected signal");
+    }
+    dprintf("SIGSEGV\n");
+    total_segv_count++;
+    if (do_siglongjmp) {
+        dprintf("siglongjmp()\n");
+        siglongjmp(current_sigjmp_buf, 1);
+    }
+}
+
+static volatile int total_trap_count;
+
+static void sig_trap(int sig, siginfo_t *info, void *puc)
+{
+    if (sig == SIGTRAP) {
+        dprintf("SIGTRAP\n");
+    } else if (sig == SIGILL) {
+        dprintf("SIGILL\n");
+    } else if (sig == SIGABRT) {
+        dprintf("SIGABRT\n");
+    } else {
+        error("unexpected signal");
+    }
+    total_trap_count++;
+    if (do_siglongjmp) {
+        dprintf("siglongjmp()\n");
+        siglongjmp(current_sigjmp_buf, 1);
+    }
+}
+
+static void test_signals(void)
+{
+    struct sigaction act;
+    struct itimerspec it;
+    timer_t tid;
+    struct sigevent sev;
+    stack_t ss;
+    void *mem;
+
+    /* Set up SEGV handler */
+    act.sa_sigaction = sig_segv;
+    sigemptyset(&act.sa_mask);
+    act.sa_flags = SA_SIGINFO;
+    chk_error(sigaction(SIGSEGV, &act, NULL));
+
+    /* Set up an altstack */
+    mem = mmap(NULL, SIGSTKSZ, PROT_READ | PROT_WRITE,
+               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (mem == MAP_FAILED) {
+            fprintf(stderr, "out of memory");
+            exit(EXIT_FAILURE);
+    }
+
+    ss.ss_sp = mem;
+    ss.ss_flags = 0;
+    ss.ss_size = SIGSTKSZ;
+    chk_error(sigaltstack(&ss, NULL));
+
+    /* Async signal test */
+
+    /* Set up RTMIN handler on alt stack */
+    act.sa_sigaction = sig_alarm;
+    sigemptyset(&act.sa_mask);
+    act.sa_flags = SA_SIGINFO | SA_ONSTACK;
+    chk_error(sigaction(SIGRTMIN, &act, NULL));
+
+    /* Create POSIX timer */
+    sev.sigev_notify = SIGEV_SIGNAL;
+    sev.sigev_signo = SIGRTMIN;
+    sev.sigev_value.sival_ptr = &tid;
+    chk_error(timer_create(CLOCK_REALTIME, &sev, &tid));
+
+    it.it_interval.tv_sec = 0;
+    it.it_interval.tv_nsec = 1000000;
+    it.it_value.tv_sec = 0;
+    it.it_value.tv_nsec = 1000000;
+    chk_error(timer_settime(tid, 0, &it, NULL));
+
+    while (total_alarm_count == 0) {
+        usleep(1000);
+    }
+    total_alarm_count = 0;
+
+    chk_error(timer_delete(tid));
+
+    assert(total_segv_count == 0);
+
+    /* Make the alt stack bad */
+    chk_error(mprotect(mem, SIGSTKSZ, PROT_NONE));
+
+    chk_error(timer_create(CLOCK_REALTIME, &sev, &tid));
+    chk_error(timer_settime(tid, 0, &it, NULL));
+
+    while (total_segv_count == 0) {
+        usleep(1000);
+    }
+    total_segv_count = 0;
+
+    chk_error(timer_delete(tid));
+
+    assert(total_alarm_count == 0);
+
+    /* Make the alt stack good */
+    chk_error(mprotect(mem, SIGSTKSZ, PROT_READ | PROT_WRITE));
+
+    /* Bad sync signal test */
+
+    /* Set up SIGILL/TRAP/ABRT handler on alt stack */
+    act.sa_sigaction = sig_trap;
+    sigemptyset(&act.sa_mask);
+    act.sa_flags = SA_SIGINFO | SA_ONSTACK;
+    chk_error(sigaction(SIGTRAP, &act, NULL));
+    chk_error(sigaction(SIGILL, &act, NULL));
+    chk_error(sigaction(SIGABRT, &act, NULL));
+
+    if (sigsetjmp(current_sigjmp_buf, 1) == 0) {
+        do_siglongjmp = true;
+        /* Cause a synchronous signal */
+        dprintf("__builtin_trap()\n");
+        __builtin_trap();
+        assert(0);
+    }
+    do_siglongjmp = false;
+    assert(total_trap_count == 1);
+    total_trap_count = 0;
+    assert(total_segv_count == 0);
+
+    /* Make the alt stack bad */
+    chk_error(mprotect(mem, SIGSTKSZ, PROT_NONE));
+
+    if (sigsetjmp(current_sigjmp_buf, 1) == 0) {
+        do_siglongjmp = true;
+        /* Cause a synchronous signal */
+        dprintf("__builtin_trap()\n");
+        __builtin_trap();
+        assert(0);
+    }
+    do_siglongjmp = false;
+    assert(total_segv_count == 1);
+    total_segv_count = 0;
+    assert(total_trap_count == 0);
+}
+
+int main(int argc, char **argv)
+{
+    test_signals();
+    return 0;
+}
-- 
2.51.0


