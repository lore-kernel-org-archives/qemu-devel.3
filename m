Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C24606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=ncBfrhWf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWH0-0000xy-Tx; Mon, 23 Nov 2026 10:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <81ec50e2d3721f7a855f988637dfa1dc0ef3a544@kylie.crudebyte.com>)
 id 1xVWGp-0000nY-76
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:47:55 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <81ec50e2d3721f7a855f988637dfa1dc0ef3a544@kylie.crudebyte.com>)
 id 1xVWGn-0005bX-A5
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=2eObQTVs6WyJZOi07U5Gx6HPUMg9YMYPOEz6SWEpePs=; b=ncBfr
 hWfKgBpM3xRBX1cWiOJOPxMe5bhyvwXnTAeRsrQqR+d9R5yGd0TKJEtglE9PSUmfSAPe856qfsuWV
 bmQmoSHgK3TCcUDZ8qY7KyHLW5yYwsFzd0jbiCj2mutG1PZuV5dgp1kZdvqGpaKr0eEF/xqmbpyx8
 a/yFwini8pS5QXzbELbAQVtY5J7JfuZLvzQOZ+L6oZrOYlxhW/KlYoc1aGA2COr8Bqc8B3ndefaIy
 5V2SI6Bqz2nRyWzUgRl9ByNlyh7j2Topzmc38Jqfnh5XH/4D/Ui9ze49poLaCg1x7xtjTNdYjShMr
 ToJrgQEXGjVozg5/KiO4/iOn4U201w1ox0+9CnVXAif3MdHUC3T4ett53fPUS0OcGSLufw4eSpXk/
 +VxAGKhaBJsKJrxQL4U7bZFbdPeZXi+SBM31dklPwLdmsEfAlgDK1lPJGs3/HjIxSPt4Pb+qJTV1e
 P5zEoJMjWhJ2X8OUGCZE7e7MSHaLkgVjAKcmt2wTPQoGGgnT14wBXXiFtHkU1HTGNo1GaHhdDfKm1
 8W26pRdQFvLEZFJTr3CK7nFZ6O6a9g/6J+c9nXN/CYfW7ZU4eEX62ZlFW7NznSPLK9bWZKeSc27fe
 7BkhquOQmjpDZ7q09tAoDrtkg1PLIwnG2QDl8npVWNp2YlpaoCR7SPjJgI7VMc=;
Message-ID: <81ec50e2d3721f7a855f988637dfa1dc0ef3a544.1795447869.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1795447869.git.qemu_oss@crudebyte.com>
References: <cover.1795447869.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 23 Nov 2026 16:24:59 +0100
Subject: [PATCH 4/7] tests/unit: add forktest.h, a forked-child run-and-verify
 helper
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=81ec50e2d3721f7a855f988637dfa1dc0ef3a544@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

We are going to test QEMU internal functions (actual tests added
by subsequent patch) which are expected to abort() the running
process on certain conditions. So we are going to simulate those
conditions, and aborting the process is hence the sane result of
those test cases.

Since aborting the process would also terminate the test and
falsely yield a failed test result; we therefore need to fork and
run these special tests from a separate subprocess. That way we
can detect from the parent process whether the subprocess was
aborted as expected, and then proclaim the test case as succeeded.

This header file provides the general purpose boilerplate code to
run this kind of forked test cases.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 MAINTAINERS           |   1 +
 tests/unit/forktest.h | 132 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 tests/unit/forktest.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 40bf63651c..0f4f1ee442 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2609,6 +2609,7 @@ X: hw/9pfs/xen-9p*
 F: fsdev/
 F: tests/qtest/virtio-9p-test.c
 F: tests/qtest/virtio-9p-race-test.c
+F: tests/unit/forktest.h
 F: tests/qtest/libqos/virtio-9p*
 T: git https://github.com/cschoenebeck/qemu.git 9p.next
 
diff --git a/tests/unit/forktest.h b/tests/unit/forktest.h
new file mode 100644
index 0000000000..ece5ccd835
--- /dev/null
+++ b/tests/unit/forktest.h
@@ -0,0 +1,132 @@
+/*
+ * Boilerplate code for running tests forked to a subprocess
+ * (e.g. for testing functions to abort() the running process as expected)
+ *
+ * Copyright (c) 2026 Christian Schoenebeck <qemu_oss@crudebyte.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef FORKTEST_H
+#define FORKTEST_H
+
+#include <signal.h>
+#include <sys/wait.h>
+
+/* Test case passed without aborting, as expected. */
+#define FORKTEST_EXIT_OK 0
+/* Test case failed because it did not abort even though expected to abort. */
+#define FORKTEST_EXIT_SURVIVED 124
+/* Test case (subprocess) returned without calling expected forktest_exit(). */
+#define FORKTEST_EXIT_MISSED 255
+
+/*
+ * The only way out of a forktest child: terminates it without
+ * running the atexit, glib or ASan teardown inherited from the
+ * parent. @code is one of the FORKTEST_EXIT codes above.
+ */
+static inline void forktest_exit(int code)
+{
+    _exit(code);
+}
+
+/* Wraps the actual test code to run, forked into a subprocess. */
+typedef struct {
+    /* entry point of the test case (to be executed on a subprocess) */
+    void (*child_fn)(void *);
+    /* user data passed to @child_fn */
+    void *opaque;
+    /* defines the success criteria: whether subprocess is expected to abort */
+    bool expect_abort;
+    /* printed as context on failure cases */
+    const char *name;
+} ForkTest;
+
+static inline bool forktest_aborted(int status)
+{
+    return WIFSIGNALED(status) && WTERMSIG(status) == SIGABRT;
+}
+
+static inline bool forktest_exited(int status, int code)
+{
+    return WIFEXITED(status) && WEXITSTATUS(status) == code;
+}
+
+/* launch (fork and run) the passed test case in a subprocess */
+static inline void forktest_run(ForkTest test)
+{
+    pid_t pid;
+    int status = 0;
+
+    pid = fork();
+    if (pid == -1) {
+        g_error("fork failed: %s", g_strerror(errno));
+    }
+    if (pid == 0) {
+        test.child_fn(test.opaque);
+        forktest_exit(FORKTEST_EXIT_MISSED);
+    }
+    if (waitpid(pid, &status, 0) != pid) {
+        g_error("waitpid failed: %s", g_strerror(errno));
+    }
+    if (forktest_aborted(status)) {
+        if (!test.expect_abort) {
+            g_error("child on %s aborted unexpectedly",
+                    test.name);
+        }
+    } else if (test.expect_abort &&
+               forktest_exited(status, FORKTEST_EXIT_SURVIVED)) {
+        g_error("child on %s survived; the case was expected to "
+                "abort", test.name);
+    } else if (!test.expect_abort &&
+               forktest_exited(status, FORKTEST_EXIT_OK)) {
+        /* passed cleanly */
+    } else {
+        g_error("child on %s died unexpectedly (status 0x%x)",
+                test.name, status);
+    }
+}
+
+/*
+ * Setup and teardown tasks to be executed before and after a test case
+ * respectively, sharable between several test cases.
+ */
+typedef struct {
+    void *(*setup_fn)(void);
+    void (*teardown_fn)(void *data);
+} ForkTestEnv;
+
+/* internal: g_test data of the trampoline below */
+struct ForkTestRun {
+    const ForkTestEnv *env;
+    void (*test_fn)(void *data);
+};
+
+/* internal trampoline function */
+static inline void forktest_case_run(const void *opaque)
+{
+    const struct ForkTestRun *tc = opaque;
+    void *state = NULL;
+
+    if (tc->env) {
+        state = tc->env->setup_fn();
+    }
+    tc->test_fn(state);
+    if (tc->env) {
+        tc->env->teardown_fn(state);
+    }
+}
+
+/* register a test case; @env may be NULL */
+static inline void forktest_add(const char *path,
+                                void (*test_fn)(void *data),
+                                const ForkTestEnv *env)
+{
+    struct ForkTestRun *tc = g_new(struct ForkTestRun, 1);
+
+    tc->test_fn = test_fn;
+    tc->env = env;
+    g_test_add_data_func_full(path, tc, forktest_case_run, g_free);
+}
+
+#endif
-- 
2.47.3


