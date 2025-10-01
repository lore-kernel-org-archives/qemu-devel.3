Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38161CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v40pq-00057I-UV; Wed, 01 Oct 2025 13:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v40pp-000573-4N
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v40pf-0007uU-P4
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759340484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7eqlr52bdrkvo/hFJyB1Giz+kk+aF72MiqvMj86z0D4=;
 b=HbWFHOO2J6V1zTyQMwMc6U3R0z74XR3oRvXPHXlzfs5CzybdO0/1Mj+52Z2i76FdxzUqWl
 bQdqsGEr1yUmEGGNcwdTUfPcfL3XxAtwM7j+MnqCBnMdAW5pWp2DpDZ+LC3Iwpz/LvLLaz
 j+MuCVhgG/eK85J3zj5sk2+AAJ7VrLg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-GA-KPu1GO5CKlyzwJhsx9A-1; Wed,
 01 Oct 2025 13:41:22 -0400
X-MC-Unique: GA-KPu1GO5CKlyzwJhsx9A-1
X-Mimecast-MFC-AGG-ID: GA-KPu1GO5CKlyzwJhsx9A_1759340482
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB5B418002CA
 for <qemu-devel@nongnu.org>; Wed,  1 Oct 2025 17:41:21 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.22])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC18F30002C5; Wed,  1 Oct 2025 17:41:20 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH WIP] Implement -run-with exit-with-parent=on
Date: Wed,  1 Oct 2025 18:40:56 +0100
Message-ID: <20251001174118.2756134-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This commit adds the same mechanism that the qemu test suite uses, and
that nbdkit has long implemented, to allow this feature to be used by
all qemu users.  The syntax is:

  qemu -run-with exit-with-parent=on [...]

This is not a feature that most typical users of qemu (for running
general purpose, long-lived VMs) should use, so it defaults to off.

The exit-with-parent.[ch] files are copied from nbdkit, where they
have a 3-clause BSD license which is compatible with qemu:

https://gitlab.com/nbdkit/nbdkit/-/tree/master/common/utils?ref_type=heads

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 include/qemu/exit-with-parent.h |  49 +++++++++
 qemu-options.hx                 |  13 ++-
 system/exit-with-parent.c       | 171 ++++++++++++++++++++++++++++++++
 system/meson.build              |   1 +
 system/vl.c                     |  13 +++
 5 files changed, 245 insertions(+), 2 deletions(-)

diff --git a/include/qemu/exit-with-parent.h b/include/qemu/exit-with-parent.h
new file mode 100644
index 0000000000..e907ccb5c9
--- /dev/null
+++ b/include/qemu/exit-with-parent.h
@@ -0,0 +1,49 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * nbdkit
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
+#include <stdbool.h>
+
+/* Test if the feature is available on the platform. */
+extern bool can_exit_with_parent(void);
+
+/*
+ * --exit-with-parent: kill the current process if the parent exits.
+ * This may return -1 on error.
+ */
+extern int set_exit_with_parent(void);
+
+#endif /* NBDKIT_EXIT_WITH_PARENT_H */
diff --git a/qemu-options.hx b/qemu-options.hx
index 075f4be2e3..9ff0346afe 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5437,15 +5437,18 @@ DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
 
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
@@ -5463,6 +5466,12 @@ SRST
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
index 0000000000..fa97b586f0
--- /dev/null
+++ b/system/exit-with-parent.c
@@ -0,0 +1,171 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * nbdkit
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
+#ifdef CONFIG_LINUX
+#include <sys/prctl.h>
+#endif
+
+#ifdef __FreeBSD__
+#include <sys/procctl.h>
+#endif
+
+#if defined(CONFIG_LINUX) && defined(PR_SET_PDEATHSIG)
+
+/* For Linux >= 2.1.57. */
+
+int
+set_exit_with_parent(void)
+{
+    return prctl(PR_SET_PDEATHSIG, SIGTERM);
+}
+
+bool
+can_exit_with_parent(void)
+{
+    return true;
+}
+
+#elif defined(__FreeBSD__) && defined(PROC_PDEATHSIG_CTL)
+
+/* For FreeBSD >= 11.2 */
+
+#include <sys/procctl.h>
+
+int
+set_exit_with_parent(void)
+{
+    const int sig = SIGTERM;
+    return procctl(P_PID, 0, PROC_PDEATHSIG_CTL, (void *) &sig);
+}
+
+bool
+can_exit_with_parent(void)
+{
+    return true;
+}
+
+#elif defined(__APPLE__)
+
+/* For macOS. */
+
+#include <unistd.h>
+#include <errno.h>
+#include <sys/event.h>
+#include <pthread.h>
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
+        /* Shut down the whole process when the parent dies. */
+        exit(0);
+    }
+
+    return NULL;
+}
+
+int
+set_exit_with_parent(void)
+{
+    int r;
+    pthread_attr_t attrs;
+    pthread_t exit_with_parent_thread;
+
+    /*
+     * We have to block waiting for kevent, so that requires that we
+     * start a background thread.
+     */
+    pthread_attr_init(&attrs);
+    pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
+    r = pthread_create(&exit_with_parent_thread, NULL,
+                       exit_with_parent_loop, NULL);
+    if (r != 0) {
+        errno = r;
+        return -1;
+    }
+
+    return 0;
+}
+
+bool
+can_exit_with_parent(void)
+{
+    return true;
+}
+
+#else /* any platform that doesn't support this function */
+
+#include <stdlib.h>
+
+int
+set_exit_with_parent(void)
+{
+    abort();
+}
+
+bool
+can_exit_with_parent(void)
+{
+    return false;
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
index 00f3694725..47b6e60b94 100644
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
@@ -3690,6 +3695,14 @@ void qemu_init(int argc, char **argv)
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
2.50.1


