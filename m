Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C67CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHlB-0005og-6n; Wed, 24 Jun 2026 03:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjn-00055Z-0E
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:35 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjk-00034d-FW
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:30 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c88a4d79ba5so475485a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284966; x=1782889766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wF4pvmwVYou3lfdQWayK5t+Io4ErmW/eBy7uJJF0ZfA=;
 b=XZ0yvZ4l+K60V9q/fQW8lKC3GRYGC1DYzH1nNREG3F/Qqka1FmFh8pJH8wtjWHEFM+
 g3pPT2rPm/Jocu3XJddrCXk0/D7gesx2s5f6lDUlW+PlDA/Z4fay3WBGoWv02ToEQMos
 YjWbWm3UwabN9X+jw0gE1bzz4XYRN774gPMr7v7wxfSUXJECm6VKOqJOG6JHhNma8Q/9
 gvhJPGLg2fFNAGixqb18pR66duFEzSbTnEZ3WQxdnk4hKWz+RhpcryofmS9Ah3EAlL8r
 GWjxjdjp1mnw32h2WRO6Ggqnz5kzrXRqPDewrJCe5AX163ACsOTQ27Z0xI7t2PR0tT6J
 UHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284966; x=1782889766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wF4pvmwVYou3lfdQWayK5t+Io4ErmW/eBy7uJJF0ZfA=;
 b=eKrQ5ZYWaI8JaJKSqm48/RY7OqSRRoGWu9evRjAPAhGksqHXFq8406++GywsIgtX9R
 zc0KVFE6obANpqYgrAPm9XEhK5okpaI+A7NHPOod+Pdj1B5Q/NqQCVZT28GriNvdQFAn
 3BXKdFtmVUc8b7opsi2QiuK2swEd72JNQBEzX4o+7vAPPt9qKMPGDxXerUoDhrKPDVjM
 ChY9eHJXzLeq8ChoXNvT7TJS3NpZx0+H31wIKafY05oVjbjGeEsT0ltaDPK34pN7bvpT
 FRWLBB7HTi0DFUJqkKparruamCrSg0Hgb4VG16yre6bSYv2sHTBwhgOYUg1oZLPnfQYD
 SeXw==
X-Gm-Message-State: AOJu0YzZdARFIAAiJTYl/J182FSrZ0IBkMn1OEaLf/C1ggZzIUgW09Pn
 uyZ6GzQ7v1zHmuTTKhnTIt4wi4IdwiQTo5ho9btXVzwHQHX7sycYgcMLlVvUesjOhao=
X-Gm-Gg: AfdE7clX4JwnWcQ5ELTkzMjZOT5ARCazfb4gLj2GizU1DhO6+vQmIIG71rNcxDdL4uI
 IT/HoYERMKmlYFQ1mSYzyZktXvJfJJ3oAn8UslsEEkfak2AdcBT/6sdQmKPL9loAcpiKXTAnmTq
 GLQuFDpZeRAVLNIMRc6rHnRknnjLkwq1RWwqtntl9gQ3LVSGJ7biTWPXl8fbd//pXBHTq3NgZLa
 e7v3Qhsf31h9+9oo5RXENJnmQctZQPmdD3D1ll42c2idodcxvL6W6PGeh4B7HnbrBSaDvclLp9m
 rcM4AD8x8jRMIEAUbgu7P5NJ4G1tGws48WaM/IcrH1dUmkkKq7u5CPo1TKsCU0LNhXDRwhr2Fbh
 iXPG64bPxlZgA0YFTi3f3taH5PVYLM7lcfiK9JOEuX4/Ju5IjLp2JZyfZw48hfRh+0wzYJAvshJ
 uDhlNhJFO3Oj8Zabhhql9QFXyrOPjXKAilNrq25kFbYBOR4+qjEYeS
X-Received: by 2002:a05:6a21:a393:b0:3b4:b2d7:c146 with SMTP id
 adf61e73a8af0-3bd1513ab06mr8281377637.21.1782284966575; 
 Wed, 24 Jun 2026 00:09:26 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:26 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 06/17] monitor: refactor monitor_data_init() to pass ID
Date: Wed, 24 Jun 2026 15:08:40 +0800
Message-ID: <20260624070851.13342-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52c.google.com
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

Anonymous monitors (e.g., '-monitor stdio' or GDB stub) leave their 'id'
field as NULL. To allow downstream subsystems (like iothread tracking) to
identify these instances later, the initialization paths must propagate
the context.

Refactor monitor_data_init() to accept the 'id' parameters, and
update all internal QMP/HMP paths to pass these identifiers.

For anonymous monitors, 'mon->id' remains NULL at this stage to avoid
namespace pollution, setting up infrastructure for subsequent patches.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 chardev/char.c             | 2 +-
 gdbstub/system.c           | 3 ++-
 include/monitor/monitor.h  | 5 +++--
 monitor/hmp.c              | 5 +++--
 monitor/monitor-internal.h | 4 +++-
 monitor/monitor.c          | 9 ++++++---
 monitor/qmp-cmds.c         | 2 +-
 monitor/qmp.c              | 5 +++--
 stubs/monitor-internal.c   | 3 ++-
 9 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index ca8b37ed8d..f057247001 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -805,7 +805,7 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
 
     if (qemu_opt_get_bool(opts, "mux", 0)) {
         assert(permit_mux_mon);
-        monitor_init_hmp(chr, true, &err);
+        monitor_init_hmp(chr, true, NULL, &err);
         if (err) {
             error_report_err(err);
             object_unparent(OBJECT(chr));
diff --git a/gdbstub/system.c b/gdbstub/system.c
index e86c5870ab..50f934fde3 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -388,7 +388,8 @@ bool gdbserver_start(const char *device, Error **errp)
         /* Initialize a monitor terminal for gdb */
         mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
                                    NULL, NULL, &error_abort);
-        monitor_init_hmp(mon_chr, false, &error_abort);
+
+        monitor_init_hmp(mon_chr, false, NULL, &error_abort);
     } else {
         qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
         mon_chr = gdbserver_system_state.mon_chr;
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 55649a8664..4a5eb20bea 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -19,8 +19,9 @@ bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
-void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
-void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
+void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error **errp);
+void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
+                      Error **errp);
 int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_init_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index cc4390486e..4ee8cb58d1 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1522,7 +1522,8 @@ static void monitor_readline_flush(void *opaque)
     monitor_flush(&mon->common);
 }
 
-void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
+void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
+                      Error **errp)
 {
     MonitorHMP *mon = g_new0(MonitorHMP, 1);
 
@@ -1531,7 +1532,7 @@ void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
         return;
     }
 
-    monitor_data_init(&mon->common, false, false, false);
+    monitor_data_init(&mon->common, false, false, false, id);
 
     mon->use_readline = use_readline;
     if (mon->use_readline) {
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index a5c4aba306..f651ba6a90 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -108,6 +108,8 @@ struct Monitor {
     bool skip_flush;
     bool use_io_thread;
 
+    char *id;
+
     char *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
 
@@ -179,7 +181,7 @@ extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
 void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
-                       bool use_io_thread);
+                       bool use_io_thread, const char *id);
 void monitor_data_destroy(Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_list_append(Monitor *mon);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 00b93ed612..65749f931e 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -608,8 +608,10 @@ static void monitor_iothread_init(void)
 }
 
 void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
-                       bool use_io_thread)
+                       bool use_io_thread, const char *id)
 {
+    mon->id = id ? g_strdup(id) : NULL;
+
     if (use_io_thread && !mon_iothread) {
         monitor_iothread_init();
     }
@@ -629,6 +631,7 @@ void monitor_data_destroy(Monitor *mon)
     } else {
         readline_free(container_of(mon, MonitorHMP, common)->rs);
     }
+    g_free(mon->id);
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);
 }
@@ -732,7 +735,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
-        monitor_init_qmp(chr, opts->pretty, errp);
+        monitor_init_qmp(chr, opts->pretty, opts->id, errp);
         break;
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
@@ -743,7 +746,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
             error_setg(errp, "'pretty' is not compatible with HMP monitors");
             return -1;
         }
-        monitor_init_hmp(chr, true, errp);
+        monitor_init_hmp(chr, true, opts->id, errp);
         break;
     default:
         g_assert_not_reached();
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 0c409c27dc..e49b9cbf8b 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -168,7 +168,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     MonitorHMP hmp = {};
 
-    monitor_data_init(&hmp.common, false, true, false);
+    monitor_data_init(&hmp.common, false, true, false, NULL);
 
     if (has_cpu_index) {
         int ret = monitor_set_cpu(&hmp.common, cpu_index);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 687019811f..8fd71386e8 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -513,7 +513,7 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     monitor_list_append(&mon->common);
 }
 
-void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
+void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error **errp)
 {
     MonitorQMP *mon = g_new0(MonitorQMP, 1);
 
@@ -525,7 +525,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
 
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
     monitor_data_init(&mon->common, true, false,
-                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
+                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT),
+                      id);
 
     mon->pretty = pretty;
 
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 4fece49d53..325a559e62 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -8,6 +8,7 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
     return -1;
 }
 
-void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
+void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
+                      Error **errp)
 {
 }
-- 
2.49.0


