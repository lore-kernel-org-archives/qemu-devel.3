Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C3CC61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvOn-0000Pk-1A; Fri, 28 Aug 2026 08:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvON-0007d9-TR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvOJ-00043J-Dn
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BU3XyOErw8luR3kCSFDGSOIX8ngxhtAoyWC6Y5by9Ao=;
 b=ViLaj2QMFfYx3ZM9p4Fj7JdutbTss61Gwnw1j7mKb8Ibu+O/j/0iqzLB0Ly4uFdtf0reXY
 cczY+KAWyQ3upioeYWVsPxIjjNzXHqti3Q7/BNMRUsiPFd2DRt5OJ+9TQQO9g/xo1/rorD
 oo81oj45C0TLygJyQF7HzRL0k/CUbVY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-HWvTZ6utNumD4GW8d2G-Kg-1; Fri,
 28 Aug 2026 08:08:49 -0400
X-MC-Unique: HWvTZ6utNumD4GW8d2G-Kg-1
X-Mimecast-MFC-AGG-ID: HWvTZ6utNumD4GW8d2G-Kg_1787918928
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F20618C0F92; Fri, 28 Aug 2026 12:08:48 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41B121956049; Fri, 28 Aug 2026 12:08:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:45 +0400
Subject: [PATCH v5 48/50] monitor: move HMP-specific to monitor-hmp-internal.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-48-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=15461;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=v71I+AUny/r4SLFcOLmm+vIg8UScxhM3jIGdjgjtX3Q=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk619vl8JJJvh/GPD1tLj6jMSWk9l87Dl30L
 nyBcobzB3uJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OgAKCRDa6OEJdZac
 5Xv0D/dDAmId0qO6sngFNI8WaYD6rlMm1WbedPJT1wKOrrJ08EfBEilAB8Zuwe/WnbsCJHF0G1A
 F5U8cbWA5WyV8yUHuo/fx9g2L/3bHjd8rB7DGV3WQ4Kks4oNN0837LuIPLYtcqDUjaAyYqYnPjp
 0EwZCn8qo3VsmsUxeG8OKIvemkHCmVEdM4lQ5gMcAiPGL9U6u6dff7Y5hjUwAhkpmDuqislbSMR
 EXaLnksx3ETYcHTT2vcL78pEyoMM/+hQUV8uERQU8N0V1iJcN+7pIHT/DW19BTXNEGA6DOrjmvz
 S0cWm94ubLfrkKPtDYR4nS/4uKqgGXAYnycSL/kSVjnY+BtlPW94GQuxRLQ1hQNkUpxw/hrDcGd
 phhQcpY5ue7eMHdpfTNL9U23uQtGRwr0cWIkPdH1GrrAd0C4BU/zHaIfU1dNxBf1ZFMO60Mqwk5
 3yoSSm2NHnrrC87wr+zilYO1ID0raZ3dZULVgsn0SfUqLDLaOlu0cG0ty02G/5C1+kTcnyS1YFk
 p567dA2+AofyUu0Dj8I1jUvaNJ5cddc/iWOGvcTt9pRPuW3KcjwN2ESJFsvE3W61AME/1sAE3yw
 402CaHFKDGK3J0M8v5agPBxcwir8xgZKN3LLLql/zPNk/mqjXd0A999odQjYLZ+6LGtigR/yAeK
 J4YMsPSjMlkwZ
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Move HMP-specific declarations to its own CONFIG_HMP guarded header.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/hmp.h          |   8 +++-
 migration/migration-hmp-cmds.c |   1 +
 monitor/hmp-cmds.c             |   1 +
 monitor/hmp.c                  |   1 +
 monitor/monitor-hmp-internal.h | 106 +++++++++++++++++++++++++++++++++++++++++
 monitor/monitor-internal.h     |  99 --------------------------------------
 monitor/monitor.c              |   1 +
 monitor/qmp-cmds.c             |   1 +
 stubs/monitor-core.c           |   2 +
 stubs/monitor-internal.c       |   2 +
 tests/unit/test-util-sockets.c |   2 -
 tools/qemu-vnc/stubs.c         |   6 ---
 12 files changed, 121 insertions(+), 109 deletions(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index f10bf83df86d..ef53e87f7608 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -21,6 +21,10 @@
 #define TYPE_MONITOR_HMP "monitor-hmp"
 OBJECT_DECLARE_TYPE(MonitorHMP, MonitorHMPClass, MONITOR_HMP);
 
+MonitorHMP *monitor_cur_hmp(void);
+
+#ifdef CONFIG_HMP
+
 #define HMP_STUB(cmd) \
     void hmp_##cmd(MonitorHMP *hmp, const QDict *qdict) \
     { \
@@ -36,8 +40,6 @@ struct MonitorDef {
 void monitor_new_hmp(const char *id, const char *chardev_id,
                      bool use_readline, Error **errp);
 
-MonitorHMP *monitor_cur_hmp(void);
-
 int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
     G_GNUC_PRINTF(2, 0);
 int monitor_hmp_printf(MonitorHMP *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
@@ -218,4 +220,6 @@ void hmp_info_skeys(MonitorHMP *hmp, const QDict *qdict);
 void hmp_info_cmma(MonitorHMP *hmp, const QDict *qdict);
 void hmp_migrationmode(MonitorHMP *hmp, const QDict *qdict);
 
+#endif /* CONFIG_HMP */
+
 #endif
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 6fe189471899..27b38d0e5f85 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -21,6 +21,7 @@
 #include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "monitor/monitor-internal.h"
+#include "monitor/monitor-hmp-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 3ac70c3f1123..91701ddf331b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -25,6 +25,7 @@
 #include "monitor/hmp.h"
 #include "monitor/hmp-completion.h"
 #include "monitor/monitor-internal.h"
+#include "monitor/monitor-hmp-internal.h"
 #include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index e3fc05f521a8..488ec23937df 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -27,6 +27,7 @@
 #include "hw/core/qdev.h"
 #include "hw/core/sysemu-cpu-ops.h"
 #include "monitor-internal.h"
+#include "monitor-hmp-internal.h"
 #include "monitor/hmp.h"
 #include "qobject/qdict.h"
 #include "qobject/qnum.h"
diff --git a/monitor/monitor-hmp-internal.h b/monitor/monitor-hmp-internal.h
new file mode 100644
index 000000000000..4e2430551abf
--- /dev/null
+++ b/monitor/monitor-hmp-internal.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef MONITOR_HMP_INTERNAL_H
+#define MONITOR_HMP_INTERNAL_H
+
+#ifdef CONFIG_HMP
+#include "monitor/hmp.h"
+/*
+ * Supported types:
+ *
+ * 'F'          filename
+ * 'B'          block device name
+ * 's'          string (accept optional quote)
+ * 'S'          it just appends the rest of the string (accept optional quote)
+ * 'O'          option string of the form NAME=VALUE,...
+ *              parsed according to QemuOptsList given by its name
+ *              Example: 'device:O' uses qemu_device_opts.
+ *              Restriction: only lists with empty desc are supported
+ *              TODO lift the restriction
+ * 'i'          32 bit integer
+ * 'l'          target long (32 or 64 bit)
+ * 'M'          Non-negative target long (32 or 64 bit), in user mode the
+ *              value is multiplied by 2^20 (think Mebibyte)
+ * 'o'          octets (aka bytes)
+ *              user mode accepts an optional E, e, P, p, T, t, G, g, M, m,
+ *              K, k suffix, which multiplies the value by 2^60 for suffixes E
+ *              and e, 2^50 for suffixes P and p, 2^40 for suffixes T and t,
+ *              2^30 for suffixes G and g, 2^20 for M and m, 2^10 for K and k
+ * 'T'          double
+ *              user mode accepts an optional ms, us, ns suffix,
+ *              which divides the value by 1e3, 1e6, 1e9, respectively
+ * '/'          optional gdb-like print format (like "/10x")
+ *
+ * '?'          optional type (for all types, except '/')
+ * '.'          other form of optional type (for 'i' and 'l')
+ * 'b'          boolean
+ *              user mode accepts "on" or "off"
+ * '-'          optional parameter (eg. '-f'); if followed by a 's', it
+ *              specifies an optional string param (e.g. '-fs' allows '-f foo')
+ *
+ */
+
+typedef struct HMPCommand {
+    const char *name;
+    const char *args_type;
+    const char *params;
+    const char *help;
+    const char *flags; /* p=preconfig */
+    void (*cmd)(MonitorHMP *hmp, const QDict *qdict);
+    /*
+     * If implementing a command that takes no arguments and simply
+     * prints formatted data, then leave @cmd NULL, and then set
+     * @cmd_info_hrt to the corresponding QMP handler that returns
+     * the formatted text.
+     */
+    HumanReadableText *(*cmd_info_hrt)(Error **errp);
+    /*
+     * @sub_table is a list of 2nd level of commands. If it does not exist,
+     * cmd should be used. If it exists, sub_table[?].cmd should be
+     * used, and cmd of 1st level plays the role of help function.
+     */
+    struct HMPCommand *sub_table;
+    void (*command_completion)(ReadLineState *rs, int nb_args, const char *str);
+
+    /* Keep non-pointer data at the end to minimize holes. */
+
+    /**
+     * @arch_bitmask: bitmask of QEMU_ARCH_* constants
+     *     Allow to restrict the command for a particular set of
+     *     target architectures.
+     */
+    uint32_t arch_bitmask;
+    bool coroutine;
+} HMPCommand;
+
+struct MonitorHMPClass {
+    MonitorClass parent_class;
+};
+
+struct MonitorHMP {
+    Monitor parent_obj;
+    bool use_readline;
+    /*
+     * State used only in the thread "owning" the monitor.
+     * This is currently always the main thread, since
+     * HMP does not allow use of the I/O thread at this time.
+     * These members can be safely accessed without locks.
+     */
+    ReadLineState *rs;
+    char *mon_cpu_path;
+    int reset_seen;
+};
+
+int monitor_hmp_set_cpu(MonitorHMP *hmp, int cpu_index);
+void handle_hmp_command(MonitorHMP *hmp, const char *cmdline);
+int hmp_compare_cmd(const char *name, const char *list);
+
+/*
+ * hmp_cmds_for_target: Return array of HMPCommand entries
+ *
+ * If @info_command is true, return the particular 'info foo' commands array.
+ */
+HMPCommand *hmp_cmds_for_target(bool info_command);
+
+#endif /* CONFIG_HMP */
+#endif
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index c198c12eaa00..822a66d06d00 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -27,7 +27,6 @@
 
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp.h"
 #include "qapi/qapi-emit-events.h"
 #include "qapi/qapi-types-control.h"
 #include "qapi/qapi-types-qom.h"
@@ -36,75 +35,6 @@
 #include "qemu/readline.h"
 #include "system/iothread.h"
 
-/*
- * Supported types:
- *
- * 'F'          filename
- * 'B'          block device name
- * 's'          string (accept optional quote)
- * 'S'          it just appends the rest of the string (accept optional quote)
- * 'O'          option string of the form NAME=VALUE,...
- *              parsed according to QemuOptsList given by its name
- *              Example: 'device:O' uses qemu_device_opts.
- *              Restriction: only lists with empty desc are supported
- *              TODO lift the restriction
- * 'i'          32 bit integer
- * 'l'          target long (32 or 64 bit)
- * 'M'          Non-negative target long (32 or 64 bit), in user mode the
- *              value is multiplied by 2^20 (think Mebibyte)
- * 'o'          octets (aka bytes)
- *              user mode accepts an optional E, e, P, p, T, t, G, g, M, m,
- *              K, k suffix, which multiplies the value by 2^60 for suffixes E
- *              and e, 2^50 for suffixes P and p, 2^40 for suffixes T and t,
- *              2^30 for suffixes G and g, 2^20 for M and m, 2^10 for K and k
- * 'T'          double
- *              user mode accepts an optional ms, us, ns suffix,
- *              which divides the value by 1e3, 1e6, 1e9, respectively
- * '/'          optional gdb-like print format (like "/10x")
- *
- * '?'          optional type (for all types, except '/')
- * '.'          other form of optional type (for 'i' and 'l')
- * 'b'          boolean
- *              user mode accepts "on" or "off"
- * '-'          optional parameter (eg. '-f'); if followed by a 's', it
- *              specifies an optional string param (e.g. '-fs' allows '-f foo')
- *
- */
-
-typedef struct HMPCommand {
-    const char *name;
-    const char *args_type;
-    const char *params;
-    const char *help;
-    const char *flags; /* p=preconfig */
-    void (*cmd)(MonitorHMP *mon, const QDict *qdict);
-    /*
-     * If implementing a command that takes no arguments and simply
-     * prints formatted data, then leave @cmd NULL, and then set
-     * @cmd_info_hrt to the corresponding QMP handler that returns
-     * the formatted text.
-     */
-    HumanReadableText *(*cmd_info_hrt)(Error **errp);
-    /*
-     * @sub_table is a list of 2nd level of commands. If it does not exist,
-     * cmd should be used. If it exists, sub_table[?].cmd should be
-     * used, and cmd of 1st level plays the role of help function.
-     */
-    struct HMPCommand *sub_table;
-    void (*command_completion)(ReadLineState *rs, int nb_args, const char *str);
-
-    /* Keep non-pointer data at the end to minimize holes. */
-
-    /**
-     * @arch_bitmask: bitmask of QEMU_ARCH_* constants
-     *     Allow to restrict the command for a particular set of
-     *     target architectures.
-     */
-    uint32_t arch_bitmask;
-    bool coroutine;
-} HMPCommand;
-
-
 struct MonitorClass {
     ObjectClass parent_class;
 
@@ -149,24 +79,6 @@ struct Monitor {
     int mux_out;
 };
 
-struct MonitorHMPClass {
-    MonitorClass parent_class;
-};
-
-struct MonitorHMP {
-    Monitor parent_obj;
-    bool use_readline;
-    /*
-     * State used only in the thread "owning" the monitor.
-     * This is currently always the main thread, since
-     * HMP does not allow use of the I/O thread at this time.
-     * These members can be safely accessed without locks.
-     */
-    ReadLineState *rs;
-    char *mon_cpu_path;
-    int reset_seen;
-};
-
 struct MonitorQMPClass {
     MonitorClass parent_class;
 };
@@ -209,21 +121,10 @@ int monitor_can_read(void *opaque);
 void monitor_cancel_out_watch(Monitor *mon);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
-int monitor_hmp_set_cpu(MonitorHMP *mon, int cpu_index);
 
 void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
-void handle_hmp_command(MonitorHMP *hmp, const char *cmdline);
-int hmp_compare_cmd(const char *name, const char *list);
-
-/*
- * hmp_cmds_for_target: Return array of HMPCommand entries
- *
- * If @info_command is true, return the particular 'info foo' commands array.
- */
-HMPCommand *hmp_cmds_for_target(bool info_command);
-
 #endif
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 44f2339d31fc..2654b81890dd 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor-internal.h"
+#include "monitor-hmp-internal.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-emit-events.h"
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index c9f24febdc96..7525a88e0494 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/sockets.h"
 #include "monitor-internal.h"
+#include "monitor-hmp-internal.h"
 #include "monitor/qdev.h"
 #include "monitor/qmp-helpers.h"
 #include "system/system.h"
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 0e74d78d52e4..8dfd46d2a8a3 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "monitor/hmp.h"
 
+#ifdef CONFIG_HMP
 int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
 {
     /*
@@ -17,3 +18,4 @@ int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
     }
     return -1;
 }
+#endif
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 6f69f1f14ae4..4483ca25557f 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -8,8 +8,10 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
     return -1;
 }
 
+#ifdef CONFIG_HMP
 void monitor_new_hmp(const char *id, const char *chardev_id,
                      bool use_readline, Error **errp)
 {
     g_assert_not_reached();
 }
+#endif
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index 530a3fee3c13..006f5e579c6b 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -24,7 +24,6 @@
 #include "qapi/error.h"
 #include "socket-helpers.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp.h"
 
 static void test_fd_is_socket_bad(void)
 {
@@ -75,7 +74,6 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
  */
 Monitor *monitor_cur(void) { return cur_mon; }
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
-int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap) { abort(); }
 
 #ifndef _WIN32
 static void test_socket_fd_pass_name_good(void)
diff --git a/tools/qemu-vnc/stubs.c b/tools/qemu-vnc/stubs.c
index 0aa50a901d37..1e4c14913b56 100644
--- a/tools/qemu-vnc/stubs.c
+++ b/tools/qemu-vnc/stubs.c
@@ -9,7 +9,6 @@
 #include "system/runstate.h"
 #include "hw/core/qdev.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp.h"
 #include "migration/vmstate.h"
 
 bool runstate_is_running(void)
@@ -42,11 +41,6 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
     return NULL;
 }
 
-int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
-{
-    return -1;
-}
-
 /*
  * Link-time stubs for VMState symbols referenced by VNC code.
  * The standalone binary never performs migration, so these are

-- 
2.55.0.543.g5ebe2ebe4ea8


