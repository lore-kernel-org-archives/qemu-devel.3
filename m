Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1A5C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 05:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9zzj-0002Cb-MC; Wed, 30 Apr 2025 01:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzf-0002Ad-R5
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:27 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zza-0006hr-7g
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:27 -0400
Received: (qmail 1744 invoked by uid 484); 30 Apr 2025 05:28:04 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.012709 secs); 30 Apr 2025 05:28:04 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 30 Apr 2025 05:28:03 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: [PATCH v2 06/20] qtest: Introduce MCD test suite
Date: Wed, 30 Apr 2025 07:27:27 +0200
Message-Id: <20250430052741.21145-7-mario.fleischmann@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=mario.fleischmann@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qtest_qmp provides a convenient way to automatically serialize into the
client JSON protocol and to send the command to the QMP socket.
Since qtest has a strong dependency to the QMP monitor, a minimal number
of function has been added to mcd-test.c for interoperability with MCD's
protocol.

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 MAINTAINERS             |  1 +
 tests/qtest/mcd-test.c  | 82 +++++++++++++++++++++++++++++++++++++++++
 tests/qtest/mcd-util.h  | 21 +++++++++++
 tests/qtest/meson.build |  5 +++
 4 files changed, 109 insertions(+)
 create mode 100644 tests/qtest/mcd-test.c
 create mode 100644 tests/qtest/mcd-util.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 159a38f..cb4f9ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3127,6 +3127,7 @@ F: mcd/*
 F: docs/interop/mcd.rst
 F: qapi/mcd.json
 F: include/exec/mcdstub.h
+X: tests/qtest/mcd-*
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
diff --git a/tests/qtest/mcd-test.c b/tests/qtest/mcd-test.c
new file mode 100644
index 0000000..b9ee3f4
--- /dev/null
+++ b/tests/qtest/mcd-test.c
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * mcdtest - Test suite for the Multi-Core Debug (MCD) API implementation
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#ifndef _WIN32
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <sys/un.h>
+#endif /* _WIN32 */
+#ifdef __linux__
+#include <sys/prctl.h>
+#endif /* __linux__ */
+#ifdef __FreeBSD__
+#include <sys/procctl.h>
+#endif /* __FreeBSD__ */
+
+#include "libqtest.h"
+#include "mcd-util.h"
+
+#define QEMU_EXTRA_ARGS ""
+
+static bool verbose;
+
+static QTestStateMCD mcdtest_init(const char *extra_args)
+{
+    QTestStateMCD qts_mcd;
+    int sock;
+
+    g_autofree gchar *sock_path = g_strdup_printf("%s/qtest-%d.mcd",
+                                    g_get_tmp_dir(), getpid());
+
+    /* remove possible orphan from earlier test run */
+    unlink(sock_path);
+    sock = qtest_socket_server(sock_path);
+
+    g_autoptr(GString) args = g_string_new(extra_args);
+    g_string_append_printf(args, " -chardev socket,path=%s,id=mcdsock "
+                                 "-mcd chardev:mcdsock",
+                                 sock_path);
+
+    qts_mcd.qts = qtest_init_without_qmp_handshake(args->str);
+    g_assert(qts_mcd.qts);
+
+    qts_mcd.mcd_fd = accept(sock, NULL, NULL);
+    unlink(sock_path);
+    g_assert(qts_mcd.mcd_fd >= 0);
+
+    return qts_mcd;
+}
+
+static void mcdtest_quit(QTestStateMCD *qts)
+{
+    qtest_quit(qts->qts);
+    close(qts->mcd_fd);
+
+    qts->qts = NULL;
+    qts->mcd_fd = -1;
+}
+
+static void test_initialize_mcdtest(void)
+{
+    QTestStateMCD qts = mcdtest_init(QEMU_EXTRA_ARGS);
+    mcdtest_quit(&qts);
+}
+
+int main(int argc, char *argv[])
+{
+    char *v_env = getenv("V");
+    verbose = v_env && atoi(v_env) >= 1;
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("mcd/initialize-mcdtest", test_initialize_mcdtest);
+    return g_test_run();
+}
diff --git a/tests/qtest/mcd-util.h b/tests/qtest/mcd-util.h
new file mode 100644
index 0000000..18ff8bd
--- /dev/null
+++ b/tests/qtest/mcd-util.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * mcdutil - Utility functions for the MCD API test suite
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TEST_MCD_UTILS_H
+#define TEST_MCD_UTILS_H
+
+#include "libqtest.h"
+
+typedef struct {
+    QTestState *qts;
+    int mcd_fd;
+} QTestStateMCD;
+
+#endif /* TEST_MCD_UTILS_H */
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 3136d15..3dc9508 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -397,6 +397,11 @@ if dbus_display
   qtests += {'dbus-display-test': [dbus_display1, gio]}
 endif
 
+if get_option('mcd').enabled()
+  qtests += { 'mcd-test': files('mcd-test.c') }
+  qtests_generic += [ 'mcd-test' ]
+endif
+
 qtest_executables = {}
 foreach dir : target_dirs
   if not dir.endswith('-softmmu')
-- 
2.34.1


