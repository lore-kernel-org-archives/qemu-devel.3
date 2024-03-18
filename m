Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4662CC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmEfO-0000tr-IL; Mon, 18 Mar 2024 11:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rmEfL-0000tb-96
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rmEfI-0001QI-FO
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710774759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dl4b7L7Ot8dh9gI32pUUoX8pbfUKU3URT27mZkop3SA=;
 b=DuZC1Uty1seVP2dkdPC899uUeTM0md9hBMn0QyyJDMC154d/Okt8J+v08yKeB6z9E83eyk
 znm4puI/fGJ+PydEg/JMZyvUmJ7dQ/8bNukVLHQV23x7k1BUhYUwjbsgD1hZMp0OQbZiqs
 +rpIRfVgac9Rklbw7H9IzOoI1JhX5wM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695--ZFCN13qOpSghCrpxMT2sQ-1; Mon, 18 Mar 2024 11:12:38 -0400
X-MC-Unique: -ZFCN13qOpSghCrpxMT2sQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E85F5855424
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 15:12:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51B7510F43;
 Mon, 18 Mar 2024 15:12:32 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com,
	mtosatti@redhat.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org, vchundur@redhat.com, rjarry@redhat.com,
 Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH v4 2/3] tools: build qemu-vmsr-helper
Date: Mon, 18 Mar 2024 16:12:15 +0100
Message-ID: <20240318151216.32833-3-aharivel@redhat.com>
In-Reply-To: <20240318151216.32833-1-aharivel@redhat.com>
References: <20240318151216.32833-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introduce a privileged helper to access RAPL MSR.

The privileged helper tool, qemu-vmsr-helper, is designed to provide
virtual machines with the ability to read specific RAPL (Running Average
Power Limit) MSRs without requiring CAP_SYS_RAWIO privileges or relying
on external, out-of-tree patches.

The helper tool leverages Unix permissions and SO_PEERCRED socket
options to enforce access control, ensuring that only processes
explicitly requesting read access via readmsr() from a valid Thread ID
can access these MSRs.

The list of RAPL MSRs that are allowed to be read by the helper tool is
defined in rapl-msr-index.h. This list corresponds to the RAPL MSRs that
will be supported in the next commit titled "Add support for RAPL MSRs
in KVM/QEMU."

The tool is intentionally designed to run on the Linux x86 platform.
This initial implementation is tailored for Intel CPUs but can be
extended to support AMD CPUs in the future.

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
---
 contrib/systemd/qemu-vmsr-helper.service |  15 +
 contrib/systemd/qemu-vmsr-helper.socket  |   9 +
 docs/tools/index.rst                     |   1 +
 docs/tools/qemu-vmsr-helper.rst          |  89 ++++
 meson.build                              |   5 +
 tools/i386/qemu-vmsr-helper.c            | 564 +++++++++++++++++++++++
 tools/i386/rapl-msr-index.h              |  28 ++
 7 files changed, 711 insertions(+)
 create mode 100644 contrib/systemd/qemu-vmsr-helper.service
 create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
 create mode 100644 docs/tools/qemu-vmsr-helper.rst
 create mode 100644 tools/i386/qemu-vmsr-helper.c
 create mode 100644 tools/i386/rapl-msr-index.h

diff --git a/contrib/systemd/qemu-vmsr-helper.service b/contrib/systemd/qemu-vmsr-helper.service
new file mode 100644
index 000000000000..8fd397bf79a9
--- /dev/null
+++ b/contrib/systemd/qemu-vmsr-helper.service
@@ -0,0 +1,15 @@
+[Unit]
+Description=Virtual RAPL MSR Daemon for QEMU
+
+[Service]
+WorkingDirectory=/tmp
+Type=simple
+ExecStart=/usr/bin/qemu-vmsr-helper
+PrivateTmp=yes
+ProtectSystem=strict
+ReadWritePaths=/var/run
+RestrictAddressFamilies=AF_UNIX
+Restart=always
+RestartSec=0
+
+[Install]
diff --git a/contrib/systemd/qemu-vmsr-helper.socket b/contrib/systemd/qemu-vmsr-helper.socket
new file mode 100644
index 000000000000..183e8304d6e2
--- /dev/null
+++ b/contrib/systemd/qemu-vmsr-helper.socket
@@ -0,0 +1,9 @@
+[Unit]
+Description=Virtual RAPL MSR helper for QEMU
+
+[Socket]
+ListenStream=/run/qemu-vmsr-helper.sock
+SocketMode=0600
+
+[Install]
+WantedBy=multi-user.target
diff --git a/docs/tools/index.rst b/docs/tools/index.rst
index 8e65ce0dfc7b..33ad438e86f6 100644
--- a/docs/tools/index.rst
+++ b/docs/tools/index.rst
@@ -16,3 +16,4 @@ command line utilities and other standalone programs.
    qemu-pr-helper
    qemu-trace-stap
    virtfs-proxy-helper
+   qemu-vmsr-helper
diff --git a/docs/tools/qemu-vmsr-helper.rst b/docs/tools/qemu-vmsr-helper.rst
new file mode 100644
index 000000000000..6ec87b49d962
--- /dev/null
+++ b/docs/tools/qemu-vmsr-helper.rst
@@ -0,0 +1,89 @@
+==================================
+QEMU virtual RAPL MSR helper
+==================================
+
+Synopsis
+--------
+
+**qemu-vmsr-helper** [*OPTION*]
+
+Description
+-----------
+
+Implements the virtual RAPL MSR helper for QEMU.
+
+Accessing the RAPL (Running Average Power Limit) MSR enables the RAPL powercap
+driver to advertise and monitor the power consumption or accumulated energy
+consumption of different power domains, such as CPU packages, DRAM, and other
+components when available.
+
+However those register are accesible under priviliged access (CAP_SYS_RAWIO).
+QEMU can use an external helper to access those priviliged register.
+
+:program:`qemu-vmsr-helper` is that external helper; it creates a listener
+socket which will accept incoming connections for communication with QEMU.
+
+If you want to run VMs in a setup like this, this helper should be started as a
+system service, and you should read the QEMU manual section on "RAPL MSR
+support" to find out how to configure QEMU to connect to the socket created by
+:program:`qemu-vmsr-helper`.
+
+After connecting to the socket, :program:`qemu-vmsr-helper` can
+optionally drop root privileges, except for those capabilities that
+are needed for its operation.
+
+:program:`qemu-vmsr-helper` can also use the systemd socket activation
+protocol.  In this case, the systemd socket unit should specify a
+Unix stream socket, like this::
+
+    [Socket]
+    ListenStream=/var/run/qemu-vmsr-helper.sock
+
+Options
+-------
+
+.. program:: qemu-vmsr-helper
+
+.. option:: -d, --daemon
+
+  run in the background (and create a PID file)
+
+.. option:: -q, --quiet
+
+  decrease verbosity
+
+.. option:: -v, --verbose
+
+  increase verbosity
+
+.. option:: -f, --pidfile=PATH
+
+  PID file when running as a daemon. By default the PID file
+  is created in the system runtime state directory, for example
+  :file:`/var/run/qemu-vmsr-helper.pid`.
+
+.. option:: -k, --socket=PATH
+
+  path to the socket. By default the socket is created in
+  the system runtime state directory, for example
+  :file:`/var/run/qemu-vmsr-helper.sock`.
+
+.. option:: -T, --trace [[enable=]PATTERN][,events=FILE][,file=FILE]
+
+  .. include:: ../qemu-option-trace.rst.inc
+
+.. option:: -u, --user=USER
+
+  user to drop privileges to
+
+.. option:: -g, --group=GROUP
+
+  group to drop privileges to
+
+.. option:: -h, --help
+
+  Display a help message and exit.
+
+.. option:: -V, --version
+
+  Display version information and exit.
diff --git a/meson.build b/meson.build
index b375248a7614..376da49b60ab 100644
--- a/meson.build
+++ b/meson.build
@@ -4052,6 +4052,11 @@ if have_tools
                dependencies: [authz, crypto, io, qom, qemuutil,
                               libcap_ng, mpathpersist],
                install: true)
+
+    executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.c'),
+               dependencies: [authz, crypto, io, qom, qemuutil,
+                              libcap_ng, mpathpersist],
+               install: true)
   endif
 
   if have_ivshmem
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
new file mode 100644
index 000000000000..d8439dc173af
--- /dev/null
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -0,0 +1,564 @@
+/*
+ * Privileged RAPL MSR helper commands for QEMU
+ *
+ * Copyright (C) 2024 Red Hat, Inc. <aharivel@redhat.com>
+ *
+ * Author: Anthony Harivel <aharivel@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include <getopt.h>
+#include <stdbool.h>
+#include <sys/ioctl.h>
+#ifdef CONFIG_LIBCAP_NG
+#include <cap-ng.h>
+#endif
+#include <pwd.h>
+#include <grp.h>
+
+#include "qemu/help-texts.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "qemu/config-file.h"
+#include "qemu-version.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/systemd.h"
+#include "io/channel.h"
+#include "io/channel-socket.h"
+#include "trace/control.h"
+#include "qemu-version.h"
+#include "rapl-msr-index.h"
+
+#define MSR_PATH_TEMPLATE "/dev/cpu/%u/msr"
+
+static char *socket_path;
+static char *pidfile;
+static enum { RUNNING, TERMINATE, TERMINATING } state;
+static QIOChannelSocket *server_ioc;
+static int server_watch;
+static int num_active_sockets = 1;
+
+#ifdef CONFIG_LIBCAP_NG
+static int uid = -1;
+static int gid = -1;
+#endif
+
+static void compute_default_paths(void)
+{
+    g_autofree char *state = qemu_get_local_state_dir();
+
+    socket_path = g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
+    pidfile = g_build_filename(state, "run", "qemu-vmsr-helper.pid", NULL);
+}
+
+static int is_intel_processor(void)
+{
+    int result;
+    int ebx, ecx, edx;
+
+    /* Execute CPUID instruction with eax=0 (basic identification) */
+    asm volatile (
+        "cpuid"
+        : "=b" (ebx), "=c" (ecx), "=d" (edx)
+        : "a" (0)
+    );
+
+    /*
+     *  Check if processor is "GenuineIntel"
+     *  0x756e6547 = "Genu"
+     *  0x49656e69 = "ineI"
+     *  0x6c65746e = "ntel"
+     */
+    result = (ebx == 0x756e6547) && (edx == 0x49656e69) && (ecx == 0x6c65746e);
+
+    return result;
+}
+
+static int is_rapl_enabled(void)
+{
+    const char *path = "/sys/class/powercap/intel-rapl/enabled";
+    FILE *file = fopen(path, "r");
+    int value = 0;
+
+    if (file != NULL) {
+        if (fscanf(file, "%d", &value) != 1) {
+            error_report("INTEL RAPL not enabled");
+        }
+        fclose(file);
+    } else {
+        error_report("Error opening %s", path);
+    }
+
+    return value;
+}
+
+/*
+ * Check if the TID that request the MSR read
+ * belongs to the peer. It be should a TID of a vCPU.
+ */
+static bool is_tid_present(pid_t pid, pid_t tid)
+{
+    g_autofree char *pidStr;
+    g_autofree char *tidStr;
+
+    pidStr = g_strdup_printf("%d", pid);
+    tidStr = g_strdup_printf("%d", tid);
+
+    char *tidPath;
+
+    tidPath = g_strdup_printf("/proc/%s/task/%s", pidStr, tidStr);
+
+    /* Check if the TID directory exists within the PID directory */
+    if (access(tidPath, F_OK) == 0) {
+        return true;
+    }
+
+    error_report("Failed to open /proc at %s", tidPath);
+    return false;
+}
+
+/*
+ * Only the RAPL MSR in target/i386/cpu.h are allowed
+ */
+static bool is_msr_allowed(uint32_t reg)
+{
+    switch (reg) {
+    case MSR_RAPL_POWER_UNIT:
+    case MSR_PKG_POWER_LIMIT:
+    case MSR_PKG_ENERGY_STATUS:
+    case MSR_PKG_POWER_INFO:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static uint64_t vmsr_read_msr(uint32_t msr_register, unsigned int cpu_id)
+{
+    int fd;
+    uint64_t result = 0;
+
+    g_autofree char *path;
+    path = g_strdup_printf(MSR_PATH_TEMPLATE, cpu_id);
+
+    /*
+     * Check if the specified CPU is included in the thread's affinity
+     */
+    cpu_set_t cpu_set;
+    CPU_ZERO(&cpu_set);
+    sched_getaffinity(0, sizeof(cpu_set_t), &cpu_set);
+
+    if (!CPU_ISSET(cpu_id, &cpu_set)) {
+        fprintf(stderr, "CPU %u is not in the thread's affinity.\n", cpu_id);
+        return result;
+    }
+
+    fd = open(path, O_RDONLY);
+    if (fd < 0) {
+        error_report("Failed to open MSR file at %s", path);
+        return result;
+    }
+
+    if (pread(fd, &result, sizeof(result), msr_register) != sizeof(result)) {
+        error_report("Failed to read MSR");
+        result = 0;
+    }
+
+    close(fd);
+    return result;
+}
+
+static void usage(const char *name)
+{
+    (printf) (
+"Usage: %s [OPTIONS] FILE\n"
+"Virtual RAPL MSR helper program for QEMU\n"
+"\n"
+"  -h, --help                display this help and exit\n"
+"  -V, --version             output version information and exit\n"
+"\n"
+"  -d, --daemon              run in the background\n"
+"  -f, --pidfile=PATH        PID file when running as a daemon\n"
+"                            (default '%s')\n"
+"  -k, --socket=PATH         path to the unix socket\n"
+"                            (default '%s')\n"
+"  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
+"                            specify tracing options\n"
+#ifdef CONFIG_LIBCAP_NG
+"  -u, --user=USER           user to drop privileges to\n"
+"  -g, --group=GROUP         group to drop privileges to\n"
+#endif
+"\n"
+QEMU_HELP_BOTTOM "\n"
+    , name, pidfile, socket_path);
+}
+
+static void version(const char *name)
+{
+    printf(
+"%s " QEMU_FULL_VERSION "\n"
+"Written by Anthony Harivel.\n"
+"\n"
+QEMU_COPYRIGHT "\n"
+"This is free software; see the source for copying conditions.  There is NO\n"
+"warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n"
+    , name);
+}
+
+typedef struct VMSRHelperClient {
+    QIOChannelSocket *ioc;
+    Coroutine *co;
+} VMSRHelperClient;
+
+static void coroutine_fn vh_co_entry(void *opaque)
+{
+    VMSRHelperClient *client = opaque;
+    Error *local_err = NULL;
+    unsigned int peer_pid;
+    uint32_t request[3];
+    uint64_t vmsr;
+    int r;
+
+    qio_channel_set_blocking(QIO_CHANNEL(client->ioc),
+                             false, NULL);
+
+    qio_channel_set_follow_coroutine_ctx(QIO_CHANNEL(client->ioc), true);
+
+    /*
+     * Check peer credentials
+     */
+    qio_channel_get_peerpid(QIO_CHANNEL(client->ioc), &peer_pid, &local_err);
+
+    if (peer_pid == 0) {
+        if (local_err != NULL) {
+            error_report_err(local_err);
+        }
+        error_report("Failed to get peer credentials");
+        goto out;
+    }
+
+    /*
+     * Read the requested MSR
+     * Only RAPL MSR in rapl-msr-index.h is allowed
+     */
+    r = qio_channel_read_all(QIO_CHANNEL(client->ioc),
+                             (char *) &request, sizeof(request), &local_err);
+    if ((local_err != NULL) || r < 0) {
+        error_report("Read request fail");
+        error_report_err(local_err);
+        goto out;
+    }
+    if (!is_msr_allowed(request[0])) {
+        error_report("Requested unallowed msr: %d", request[0]);
+        goto out;
+    }
+
+    vmsr = vmsr_read_msr(request[0], request[1]);
+
+    if (!is_tid_present(peer_pid, request[2])) {
+        error_report("Requested TID not in peer PID: %d %d",
+            peer_pid, request[2]);
+        vmsr = 0;
+    }
+
+    r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
+                         (char *) &vmsr, sizeof(vmsr), &local_err);
+    if ((local_err != NULL) || r < 0) {
+        error_report("Write request fail");
+        error_report_err(local_err);
+        goto out;
+    }
+
+out:
+    object_unref(OBJECT(client->ioc));
+}
+
+static gboolean accept_client(QIOChannel *ioc,
+                              GIOCondition cond,
+                              gpointer opaque)
+{
+    QIOChannelSocket *cioc;
+    VMSRHelperClient *vmsrh;
+
+    cioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
+                                     NULL);
+    if (!cioc) {
+        return FALSE;
+    }
+
+    vmsrh = g_new(VMSRHelperClient, 1);
+    vmsrh->ioc = cioc;
+    vmsrh->co = qemu_coroutine_create(vh_co_entry, vmsrh);
+    qemu_coroutine_enter(vmsrh->co);
+
+    return TRUE;
+}
+
+static void termsig_handler(int signum)
+{
+    qatomic_cmpxchg(&state, RUNNING, TERMINATE);
+    qemu_notify_event();
+}
+
+static void close_server_socket(void)
+{
+    assert(server_ioc);
+
+    g_source_remove(server_watch);
+    server_watch = -1;
+    object_unref(OBJECT(server_ioc));
+    num_active_sockets--;
+}
+
+#ifdef CONFIG_LIBCAP_NG
+static int drop_privileges(void)
+{
+    /* clear all capabilities */
+    capng_clear(CAPNG_SELECT_BOTH);
+
+    if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
+                     CAP_SYS_RAWIO) < 0) {
+        return -1;
+    }
+
+    /*
+     * Change user/group id, retaining the capabilities.
+     * Because file descriptors are passed via SCM_RIGHTS,
+     * we don't need supplementary groups (and in fact the helper
+     * can run as "nobody").
+     */
+    if (capng_change_id(uid != -1 ? uid : getuid(),
+                        gid != -1 ? gid : getgid(),
+                        CAPNG_DROP_SUPP_GRP | CAPNG_CLEAR_BOUNDING)) {
+        return -1;
+    }
+
+    return 0;
+}
+#endif
+
+int main(int argc, char **argv)
+{
+    const char *sopt = "hVk:f:dT:u:g:vq";
+    struct option lopt[] = {
+        { "help", no_argument, NULL, 'h' },
+        { "version", no_argument, NULL, 'V' },
+        { "socket", required_argument, NULL, 'k' },
+        { "pidfile", required_argument, NULL, 'f' },
+        { "daemon", no_argument, NULL, 'd' },
+        { "trace", required_argument, NULL, 'T' },
+        { "user", required_argument, NULL, 'u' },
+        { "group", required_argument, NULL, 'g' },
+        { "verbose", no_argument, NULL, 'v' },
+        { NULL, 0, NULL, 0 }
+    };
+    int opt_ind = 0;
+    int ch;
+    Error *local_err = NULL;
+    bool daemonize = false;
+    bool pidfile_specified = false;
+    bool socket_path_specified = false;
+    unsigned socket_activation;
+
+    struct sigaction sa_sigterm;
+    memset(&sa_sigterm, 0, sizeof(sa_sigterm));
+    sa_sigterm.sa_handler = termsig_handler;
+    sigaction(SIGTERM, &sa_sigterm, NULL);
+    sigaction(SIGINT, &sa_sigterm, NULL);
+    sigaction(SIGHUP, &sa_sigterm, NULL);
+
+    signal(SIGPIPE, SIG_IGN);
+
+    error_init(argv[0]);
+    module_call_init(MODULE_INIT_TRACE);
+    module_call_init(MODULE_INIT_QOM);
+    qemu_add_opts(&qemu_trace_opts);
+    qemu_init_exec_dir(argv[0]);
+
+    compute_default_paths();
+
+    /*
+     * Sanity check
+     * 1. cpu must be Intel cpu
+     * 2. RAPL must be enabled
+     */
+    if (!is_intel_processor()) {
+        error_report("error: CPU is not INTEL cpu");
+        exit(EXIT_FAILURE);
+    }
+
+    if (!is_rapl_enabled()) {
+        error_report("error: RAPL driver not enable");
+        exit(EXIT_FAILURE);
+    }
+
+    while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
+        switch (ch) {
+        case 'k':
+            g_free(socket_path);
+            socket_path = g_strdup(optarg);
+            socket_path_specified = true;
+            if (socket_path[0] != '/') {
+                error_report("socket path must be absolute");
+                exit(EXIT_FAILURE);
+            }
+            break;
+        case 'f':
+            g_free(pidfile);
+            pidfile = g_strdup(optarg);
+            pidfile_specified = true;
+            break;
+#ifdef CONFIG_LIBCAP_NG
+        case 'u': {
+            unsigned long res;
+            struct passwd *userinfo = getpwnam(optarg);
+            if (userinfo) {
+                uid = userinfo->pw_uid;
+            } else if (qemu_strtoul(optarg, NULL, 10, &res) == 0 &&
+                       (uid_t)res == res) {
+                uid = res;
+            } else {
+                error_report("invalid user '%s'", optarg);
+                exit(EXIT_FAILURE);
+            }
+            break;
+        }
+        case 'g': {
+            unsigned long res;
+            struct group *groupinfo = getgrnam(optarg);
+            if (groupinfo) {
+                gid = groupinfo->gr_gid;
+            } else if (qemu_strtoul(optarg, NULL, 10, &res) == 0 &&
+                       (gid_t)res == res) {
+                gid = res;
+            } else {
+                error_report("invalid group '%s'", optarg);
+                exit(EXIT_FAILURE);
+            }
+            break;
+        }
+#else
+        case 'u':
+        case 'g':
+            error_report("-%c not supported by this %s", ch, argv[0]);
+            exit(1);
+#endif
+        case 'd':
+            daemonize = true;
+            break;
+        case 'T':
+            trace_opt_parse(optarg);
+            break;
+        case 'V':
+            version(argv[0]);
+            exit(EXIT_SUCCESS);
+            break;
+        case 'h':
+            usage(argv[0]);
+            exit(EXIT_SUCCESS);
+            break;
+        case '?':
+            error_report("Try `%s --help' for more information.", argv[0]);
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    if (!trace_init_backends()) {
+        exit(EXIT_FAILURE);
+    }
+    trace_init_file();
+    qemu_set_log(LOG_TRACE, &error_fatal);
+
+    socket_activation = check_socket_activation();
+    if (socket_activation == 0) {
+        SocketAddress saddr;
+        saddr = (SocketAddress){
+            .type = SOCKET_ADDRESS_TYPE_UNIX,
+            .u.q_unix.path = socket_path,
+        };
+        server_ioc = qio_channel_socket_new();
+        if (qio_channel_socket_listen_sync(server_ioc, &saddr,
+                                           1, &local_err) < 0) {
+            object_unref(OBJECT(server_ioc));
+            error_report_err(local_err);
+            return 1;
+        }
+    } else {
+        /* Using socket activation - check user didn't use -p etc. */
+        if (socket_path_specified) {
+            error_report("Unix socket can't be set when"
+                         "using socket activation");
+            exit(EXIT_FAILURE);
+        }
+
+        /* Can only listen on a single socket.  */
+        if (socket_activation > 1) {
+            error_report("%s does not support socket activation"
+                         "with LISTEN_FDS > 1",
+                        argv[0]);
+            exit(EXIT_FAILURE);
+        }
+        server_ioc = qio_channel_socket_new_fd(FIRST_SOCKET_ACTIVATION_FD,
+                                               &local_err);
+        if (server_ioc == NULL) {
+            error_reportf_err(local_err,
+                              "Failed to use socket activation: ");
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    qemu_init_main_loop(&error_fatal);
+
+    server_watch = qio_channel_add_watch(QIO_CHANNEL(server_ioc),
+                                         G_IO_IN,
+                                         accept_client,
+                                         NULL, NULL);
+
+    if (daemonize) {
+        if (daemon(0, 0) < 0) {
+            error_report("Failed to daemonize: %s", strerror(errno));
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    if (daemonize || pidfile_specified) {
+        qemu_write_pidfile(pidfile, &error_fatal);
+    }
+
+#ifdef CONFIG_LIBCAP_NG
+    if (drop_privileges() < 0) {
+        error_report("Failed to drop privileges: %s", strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+#endif
+
+    info_report("Listening on %s", socket_path);
+
+    state = RUNNING;
+    do {
+        main_loop_wait(false);
+        if (state == TERMINATE) {
+            state = TERMINATING;
+            close_server_socket();
+        }
+    } while (num_active_sockets > 0);
+
+    exit(EXIT_SUCCESS);
+}
diff --git a/tools/i386/rapl-msr-index.h b/tools/i386/rapl-msr-index.h
new file mode 100644
index 000000000000..9a7118639ae3
--- /dev/null
+++ b/tools/i386/rapl-msr-index.h
@@ -0,0 +1,28 @@
+/*
+ * Allowed list of MSR for Privileged RAPL MSR helper commands for QEMU
+ *
+ * Copyright (C) 2023 Red Hat, Inc. <aharivel@redhat.com>
+ *
+ * Author: Anthony Harivel <aharivel@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Should stay in sync with the RAPL MSR
+ * in target/i386/cpu.h
+ */
+#define MSR_RAPL_POWER_UNIT             0x00000606
+#define MSR_PKG_POWER_LIMIT             0x00000610
+#define MSR_PKG_ENERGY_STATUS           0x00000611
+#define MSR_PKG_POWER_INFO              0x00000614
-- 
2.44.0


