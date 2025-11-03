Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CD2CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFulG-0005GU-5m; Mon, 03 Nov 2025 08:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFulE-0005Fa-AW
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFukt-0004MA-Kw
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Co7PJ34fXM/JdygLYNIMosDdSA5UrYHDorKwVuhdI8=;
 b=Fck7Et1fLP83s7eH+zbCfj0WxCN04zpGw6Kjb3s6c2Iwhppi/L/NdiQICi3MvWWq8mlLkx
 3x31aGKAGZR5BIroTxvLTPWxe2xcrCWqqgSqARp+wExfG0jrSQdcjVVMU5M+Bdk8Sv1erO
 1nMP4tq3vKk48WoD8aiCsrlYOj+9ThA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-Fkmc2nHaPKW5aMXWMQuY6w-1; Mon,
 03 Nov 2025 08:37:47 -0500
X-MC-Unique: Fkmc2nHaPKW5aMXWMQuY6w-1
X-Mimecast-MFC-AGG-ID: Fkmc2nHaPKW5aMXWMQuY6w_1762177067
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9178195605A; Mon,  3 Nov 2025 13:37:46 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE68A1800451; Mon,  3 Nov 2025 13:37:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PULL 01/32] Implement -run-with exit-with-parent=on
Date: Mon,  3 Nov 2025 13:36:55 +0000
Message-ID: <20251103133727.423041-2-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard W.M. Jones <rjones@redhat.com>

Libguestfs wants to use qemu to run a captive appliance.  When the
program linked to libguestfs exits, we want qemu to be cleaned up.
Libguestfs goes to great lengths to do this at the moment: it either
forks a separate process to ensure clean-up is done, or it asks
libvirt to clean up the qemu process.  However this is complicated and
not totally reliable.

On Linux, FreeBSD and macOS, there are mechanisms to ensure a signal
or message is delivered to a process when its parent process goes
away.  The qemu test suite even uses this mechanism on Linux (see
PR_SET_PDEATHSIG in tests/qtest/libqtest.c).

In nbdkit we have long had the concept of running nbdkit captively,
and we have the nbdkit --exit-with-parent flag to help
(https://libguestfs.org/nbdkit-captive.1.html#EXIT-WITH-PARENT)

This commit adds the same mechanism.  The syntax is:

  qemu -run-with exit-with-parent=on [...]

This is not a feature that most typical users of qemu (for running
general purpose, long-lived VMs) should use, so it defaults to off.

The exit-with-parent.[ch] files are copied from nbdkit, where they
have a 3-clause BSD license which is compatible with qemu:

https://gitlab.com/nbdkit/nbdkit/-/tree/master/common/utils?ref_type=heads

Thanks: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/exit-with-parent.h |  57 +++++++++++++
 qemu-options.hx                 |  13 ++-
 system/exit-with-parent.c       | 140 ++++++++++++++++++++++++++++++++
 system/meson.build              |   1 +
 system/vl.c                     |  13 +++
 5 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100644 include/qemu/exit-with-parent.h
 create mode 100644 system/exit-with-parent.c

diff --git a/include/qemu/exit-with-parent.h b/include/qemu/exit-with-parent.h
new file mode 100644
index 0000000000..c00b863fe9
--- /dev/null
+++ b/include/qemu/exit-with-parent.h
@@ -0,0 +1,57 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Originally derived from nbdkit common/utils/exit-with-parent.h
+ * Copyright Red Hat
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * * Redistributions of source code must retain the above copyright
+ * notice, this list of conditions and the following disclaimer.
+ *
+ * * Redistributions in binary form must reproduce the above copyright
+ * notice, this list of conditions and the following disclaimer in the
+ * documentation and/or other materials provided with the distribution.
+ *
+ * * Neither the name of Red Hat nor the names of its contributors may be
+ * used to endorse or promote products derived from this software without
+ * specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY RED HAT AND CONTRIBUTORS ''AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+ * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL RED HAT OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef NBDKIT_EXIT_WITH_PARENT_H
+#define NBDKIT_EXIT_WITH_PARENT_H
+
+/* Test if the feature is available on the platform. */
+static inline bool can_exit_with_parent(void)
+{
+#if defined(__linux__) || defined(__FreeBSD__) || defined(__APPLE__)
+    return true;
+#else
+    return false;
+#endif
+}
+
+/*
+ * --exit-with-parent: kill the current process if the parent exits.
+ * This may return -1 on error.
+ *
+ * Note this will abort on platforms where can_exit_with_parent()
+ * returned false.
+ */
+extern int set_exit_with_parent(void);
+
+#endif /* NBDKIT_EXIT_WITH_PARENT_H */
diff --git a/qemu-options.hx b/qemu-options.hx
index 0223ceffeb..fca2b7bc74 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5467,15 +5467,18 @@ DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
 
 #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
-    "-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]\n"
+    "-run-with [async-teardown=on|off][,chroot=dir]\n" \
+    "          [,exit-with-parent=on|off][,user=username|uid:gid]\n"
     "                Set miscellaneous QEMU process lifecycle options:\n"
     "                async-teardown=on enables asynchronous teardown (Linux only)\n"
+    "                exit-with-parent=on causes QEMU to exit if the parent\n"
+    "                  process of QEMU exits (Linux, FreeBSD, macOS only)\n"
     "                chroot=dir chroot to dir just before starting the VM\n"
     "                user=username switch to the specified user before starting the VM\n"
     "                user=uid:gid ditto, but use specified user-ID and group-ID instead\n",
     QEMU_ARCH_ALL)
 SRST
-``-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]``
+``-run-with [async-teardown=on|off][,chroot=dir][,exit-with-parent=on|off][,user=username|uid:gid]``
     Set QEMU process lifecycle options.
 
     ``async-teardown=on`` enables asynchronous teardown. A new process called
@@ -5493,6 +5496,12 @@ SRST
     immediately before starting the guest execution. This is especially useful
     in combination with ``user=...``.
 
+    ``exit-with-parent=on`` causes QEMU to exit if the parent process of
+    QEMU exits.  This can be used when QEMU runs a captive appliance,
+    where the lifetime of the appliance is scoped to the parent process.
+    In case the parent process crashes, QEMU is still cleaned up.
+    This only works on Linux, FreeBSD and macOS platforms.
+
     ``user=username`` or ``user=uid:gid`` can be used to drop root privileges
     before starting guest execution. QEMU will use the ``setuid`` and ``setgid``
     system calls to switch to the specified identity.  Note that the
diff --git a/system/exit-with-parent.c b/system/exit-with-parent.c
new file mode 100644
index 0000000000..df65d2231a
--- /dev/null
+++ b/system/exit-with-parent.c
@@ -0,0 +1,140 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Originally derived from nbdkit common/utils/exit-with-parent.c
+ * Copyright Red Hat
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * * Redistributions of source code must retain the above copyright
+ * notice, this list of conditions and the following disclaimer.
+ *
+ * * Redistributions in binary form must reproduce the above copyright
+ * notice, this list of conditions and the following disclaimer in the
+ * documentation and/or other materials provided with the distribution.
+ *
+ * * Neither the name of Red Hat nor the names of its contributors may be
+ * used to endorse or promote products derived from this software without
+ * specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY RED HAT AND CONTRIBUTORS ''AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
+ * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+ * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL RED HAT OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+/*
+ * Implement the --exit-with-parent feature on operating systems which
+ * support it.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/exit-with-parent.h"
+
+#if defined(__linux__)
+
+#include <sys/prctl.h>
+
+/*
+ * Send SIGTERM to self when the parent exits.  This will cause
+ * qemu_system_killed() to be called.
+ *
+ * PR_SET_PDEATHSIG has been defined since Linux 2.1.57.
+ */
+int
+set_exit_with_parent(void)
+{
+    return prctl(PR_SET_PDEATHSIG, SIGTERM);
+}
+
+#elif defined(__FreeBSD__)
+
+#include <sys/procctl.h>
+
+/*
+ * Send SIGTERM to self when the parent exits.  This will cause
+ * qemu_system_killed() to be called.
+ *
+ * PROC_PDEATHSIG_CTL has been defined since FreeBSD 11.2.
+ */
+int
+set_exit_with_parent(void)
+{
+    const int sig = SIGTERM;
+    return procctl(P_PID, 0, PROC_PDEATHSIG_CTL, (void *) &sig);
+}
+
+#elif defined(__APPLE__)
+
+/* For macOS. */
+
+#include "qemu/thread.h"
+#include "qemu/error-report.h"
+#include "system/runstate.h"
+#include <sys/event.h>
+
+static void *
+exit_with_parent_loop(void *vp)
+{
+    const pid_t ppid = getppid();
+    int fd;
+    struct kevent kev, res[1];
+    int r;
+
+    /* Register the kevent to wait for ppid to exit. */
+    fd = kqueue();
+    if (fd == -1) {
+        error_report("exit_with_parent_loop: kqueue: %m");
+        return NULL;
+    }
+    EV_SET(&kev, ppid, EVFILT_PROC, EV_ADD | EV_ENABLE, NOTE_EXIT, 0, NULL);
+    if (kevent(fd, &kev, 1, NULL, 0, NULL) == -1) {
+        error_report("exit_with_parent_loop: kevent: %m");
+        close(fd);
+        return NULL;
+    }
+
+    /* Wait for the kevent to happen. */
+    r = kevent(fd, 0, 0, res, 1, NULL);
+    if (r == 1 && res[0].ident == ppid) {
+        /* Behave like Linux and FreeBSD above, as if SIGTERM was sent */
+        qemu_system_killed(SIGTERM, ppid);
+    }
+
+    return NULL;
+}
+
+int
+set_exit_with_parent(void)
+{
+    QemuThread exit_with_parent_thread;
+
+    /*
+     * We have to block waiting for kevent, so that requires that we
+     * start a background thread.
+     */
+    qemu_thread_create(&exit_with_parent_thread,
+                       "exit-parent",
+                       exit_with_parent_loop, NULL,
+                       QEMU_THREAD_DETACHED);
+    return 0;
+}
+
+#else /* any platform that doesn't support this function */
+
+int
+set_exit_with_parent(void)
+{
+    g_assert_not_reached();
+}
+
+#endif
diff --git a/system/meson.build b/system/meson.build
index 6d21ff9faa..4b69ef0f5f 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -15,6 +15,7 @@ system_ss.add(files(
   'datadir.c',
   'dirtylimit.c',
   'dma-helpers.c',
+  'exit-with-parent.c',
   'globals.c',
   'ioport.c',
   'ram-block-attributes.c',
diff --git a/system/vl.c b/system/vl.c
index 29f5389151..5091fe52d9 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -53,6 +53,7 @@
 #include "qemu/sockets.h"
 #include "qemu/accel.h"
 #include "qemu/async-teardown.h"
+#include "qemu/exit-with-parent.h"
 #include "hw/usb.h"
 #include "hw/isa/isa.h"
 #include "hw/scsi/scsi.h"
@@ -783,6 +784,10 @@ static QemuOptsList qemu_run_with_opts = {
             .name = "chroot",
             .type = QEMU_OPT_STRING,
         },
+        {
+            .name = "exit-with-parent",
+            .type = QEMU_OPT_BOOL,
+        },
         {
             .name = "user",
             .type = QEMU_OPT_STRING,
@@ -3691,6 +3696,14 @@ void qemu_init(int argc, char **argv)
                 if (str) {
                     os_set_chroot(str);
                 }
+                if (qemu_opt_get_bool(opts, "exit-with-parent", false)) {
+                    if (!can_exit_with_parent()) {
+                        error_report("exit-with-parent is not available"
+                                     " on this platform");
+                        exit(1);
+                    }
+                    set_exit_with_parent();
+                }
                 str = qemu_opt_get(opts, "user");
                 if (str) {
                     if (!os_set_runas(str)) {
-- 
2.51.1


