Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA752C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 05:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9zzk-0002D2-R8; Wed, 30 Apr 2025 01:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzg-0002B8-A4
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:28 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zza-0006hi-7U
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:27 -0400
Received: (qmail 1720 invoked by uid 484); 30 Apr 2025 05:28:03 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.012919 secs); 30 Apr 2025 05:28:03 -0000
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
Subject: [PATCH v2 05/20] mcd: Introduce MCD server stub
Date: Wed, 30 Apr 2025 07:27:26 +0200
Message-Id: <20250430052741.21145-6-mario.fleischmann@lauterbach.com>
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

To keep the MCD JSON protocol separate from QMP, a custom monitor has been
implemented in mcd_monitor.c which can be run in parallel to the QMP monitor.
It is responsible for handling the JSON communication and for dispatching
the corresponding functions in mcd_stub.c
The MCD server stub will call the corresponding server functions.

To start the MCD monitor, configure QEMU with --enable-mcd and start it
with the -mcd option.

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 MAINTAINERS            |  1 +
 docs/interop/mcd.rst   |  2 +
 include/exec/mcdstub.h | 17 ++++++++
 mcd/mcd_monitor.c      | 89 ++++++++++++++++++++++++++++++++++++++++++
 mcd/mcd_stub.c         | 11 ++++++
 mcd/meson.build        |  4 +-
 qemu-options.hx        | 11 ++++++
 system/vl.c            | 13 ++++++
 8 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 include/exec/mcdstub.h
 create mode 100644 mcd/mcd_monitor.c
 create mode 100644 mcd/mcd_stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c085dc..159a38f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3126,6 +3126,7 @@ S: Maintained
 F: mcd/*
 F: docs/interop/mcd.rst
 F: qapi/mcd.json
+F: include/exec/mcdstub.h
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
diff --git a/docs/interop/mcd.rst b/docs/interop/mcd.rst
index 13e81df..860fa8d 100644
--- a/docs/interop/mcd.rst
+++ b/docs/interop/mcd.rst
@@ -52,6 +52,8 @@ has been added to implement a remote procedure call mechanism.
 Each function within the API corresponds to one QAPI command, ensuring a
 one-to-one mapping between the API's functions and the QAPI commands.
 
+Use the option ``-mcd dev`` to start MCD's QAPI monitor.
+
 QAPI Reference
 --------------
 
diff --git a/include/exec/mcdstub.h b/include/exec/mcdstub.h
new file mode 100644
index 0000000..0513616
--- /dev/null
+++ b/include/exec/mcdstub.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef MCDSTUB_H
+#define MCDSTUB_H
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+
+bool mcd_monitor_start(const char *device, Error **errp);
+
+#endif /* MCDSTUB_H */
diff --git a/mcd/mcd_monitor.c b/mcd/mcd_monitor.c
new file mode 100644
index 0000000..7ee3eba
--- /dev/null
+++ b/mcd/mcd_monitor.c
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * mcdmonitor - MCD QAPI protocol handler
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/mcdstub.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "mcd/mcd-qapi-init-commands.h"
+#include "mcd/mcd-qapi-commands.h"
+#include "monitor/monitor-internal.h"
+
+typedef struct {
+    Monitor mon;
+    JSONMessageParser parser;
+} MonitorMCD;
+
+static QmpCommandList qapi_commands;
+static MonitorMCD mcd_mon;
+
+static int mcd_monitor_can_read(void *opaque)
+{
+    return true;
+}
+
+static void mcd_monitor_read(void *opaque, const uint8_t *buf, int size)
+{
+    json_message_parser_feed(&mcd_mon.parser, (const char *) buf, size);
+}
+
+static void mcd_monitor_handle_chr_event(void *opaque, QEMUChrEvent event)
+{
+    switch (event) {
+    default:
+        /* Ignore */
+        break;
+    }
+}
+
+static void handle_mcd_command(void *opaque, QObject *req, Error *err)
+{
+    QDict *rsp = qmp_dispatch(&qapi_commands, req, false, &mcd_mon.mon);
+    const QObject *data = QOBJECT(rsp);
+    GString *json = qobject_to_json_pretty(data, false);
+    assert(json != NULL);
+    g_string_append_c(json, '\n');
+    monitor_puts(&mcd_mon.mon, json->str);
+    g_string_free(json, true);
+}
+
+static void mcd_monitor_init(Chardev *chr, Error **errp)
+{
+    if (!qemu_chr_fe_init(&mcd_mon.mon.chr, chr, errp)) {
+        return;
+    }
+    qemu_chr_fe_set_echo(&mcd_mon.mon.chr, true);
+
+    /* For now, don't use the I/O thread */
+    monitor_data_init(&mcd_mon.mon, true, false, false);
+
+    json_message_parser_init(&mcd_mon.parser, handle_mcd_command,
+                             &mcd_mon.mon, NULL);
+
+    qemu_chr_fe_set_handlers(&mcd_mon.mon.chr, mcd_monitor_can_read,
+                             mcd_monitor_read, mcd_monitor_handle_chr_event,
+                             NULL, &mcd_mon.mon, NULL, true);
+}
+
+bool mcd_monitor_start(const char *device, Error **errp)
+{
+    Chardev *chr = qemu_chr_new_noreplay("mcd", device, true, NULL);
+    if (!chr) {
+        error_setg(errp, "mcdstub: couldn't create Chardev");
+        return false;
+    }
+    mcd_monitor_init(chr, errp);
+    return true;
+}
+
+static void __attribute__((__constructor__)) mcd_monitor_init_commands(void)
+{
+    mcd_qmp_init_marshal(&qapi_commands);
+}
diff --git a/mcd/mcd_stub.c b/mcd/mcd_stub.c
new file mode 100644
index 0000000..de679a4
--- /dev/null
+++ b/mcd/mcd_stub.c
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * mcdstub - Conversion of MCD QAPI requests to MCD server function calls
+ *
+ * Copyright (c) 2025 Lauterbach GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "mcd_api.h"
diff --git a/mcd/meson.build b/mcd/meson.build
index d62a625..191f0cc 100644
--- a/mcd/meson.build
+++ b/mcd/meson.build
@@ -28,7 +28,9 @@ mcd_ss = ss.source_set()
 
 mcd_ss.add(mcd_qapi_files.to_list())
 mcd_ss.add(files(
-  'mcd_server.c'))
+  'mcd_server.c',
+  'mcd_stub.c',
+  'mcd_monitor.c'))
 
 mcd_ss = mcd_ss.apply({})
 
diff --git a/qemu-options.hx b/qemu-options.hx
index dc694a9..2164ad3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4724,6 +4724,17 @@ SRST
     (see the :ref:`GDB usage` chapter in the System Emulation Users Guide).
 ERST
 
+
+#ifdef CONFIG_MCD
+DEF("mcd", HAS_ARG, QEMU_OPTION_mcd, \
+    "-mcd dev        accept MCD connection on 'dev'\n",
+    QEMU_ARCH_ALL)
+SRST
+``-mcd dev``
+    Start the MCD QAPI monitor and accept connections on device 'dev'.
+ERST
+#endif
+
 DEF("d", HAS_ARG, QEMU_OPTION_d, \
     "-d item1,...    enable logging of specified items (use '-d help' for a list of log items)\n",
     QEMU_ARCH_ALL)
diff --git a/system/vl.c b/system/vl.c
index 520956f..73dc786 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -71,6 +71,9 @@
 #include "system/numa.h"
 #include "system/hostmem.h"
 #include "exec/gdbstub.h"
+#ifdef CONFIG_MCD
+#include "exec/mcdstub.h"
+#endif
 #include "gdbstub/enums.h"
 #include "qemu/timer.h"
 #include "chardev/char.h"
@@ -1280,6 +1283,7 @@ struct device_config {
         DEV_PARALLEL,  /* -parallel      */
         DEV_DEBUGCON,  /* -debugcon */
         DEV_GDB,       /* -gdb, -s */
+        DEV_MCD,       /* -mcd */
         DEV_SCLP,      /* s390 sclp */
     } type;
     const char *cmdline;
@@ -2789,6 +2793,10 @@ static bool qemu_machine_creation_done(Error **errp)
 
     foreach_device_config_or_exit(DEV_GDB, gdbserver_start);
 
+#ifdef CONFIG_MCD
+    foreach_device_config_or_exit(DEV_MCD, mcd_monitor_start);
+#endif
+
     if (!vga_interface_created && !default_vga &&
         vga_interface_type != VGA_NONE) {
         warn_report("A -vga option was passed but this machine "
@@ -3150,6 +3158,11 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_gdb:
                 add_device_config(DEV_GDB, optarg);
                 break;
+#ifdef CONFIG_MCD
+            case QEMU_OPTION_mcd:
+                add_device_config(DEV_MCD, optarg);
+                break;
+#endif
             case QEMU_OPTION_L:
                 if (is_help_option(optarg)) {
                     list_data_dirs = true;
-- 
2.34.1


