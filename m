Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC46CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4qM-0003Kh-Ql; Fri, 29 May 2026 17:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qK-0003KK-8B
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:12 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qI-0002uM-9K
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:12 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c855599a77aso1709690a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090449; x=1780695249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPhJtyZeuePVp/bJ9HJteGXBpxV9dgehSXmY6hUppoA=;
 b=nKxYeMRNKtYZzrJnzyM3n0eNWWLyRpWU+W3jOBo6jIsle7zgSiy7hMnQ9wKRvvW0Wu
 K8IdcGJw8ROU9TgarOsJzghbvsLa95UgPl8QNZc3knXB5N+HNk3OscvWbPgOPWLOOBaT
 EL73sRJj1t+yPqosomDZ4AvEhYyzevEe0UamEvf0J9HbU2O9A+nyICLc/bJ+pjPBwmth
 RMl0krSvHrNqMs5h3/hdPOzwyZNapwOTJuMX6fseu503P4ldhCUK0rHstfOyy3WCRoyQ
 GN8Iz4Fx+qBHAtM7aw+dU5WGZTFErW/GZwXdykFU2+rD8gClAArCu0LUKw8/h2SgdTKI
 WU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090449; x=1780695249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SPhJtyZeuePVp/bJ9HJteGXBpxV9dgehSXmY6hUppoA=;
 b=qIexhsU997g1PuupeivWyiKZ9KbtmmQnB3bAx4Uih/pYcIaMf/ZuHaOIKfQQh9rlFR
 drY8+TeWCzDB12jUoyhfpzcTqM1DVjLzGosF3aBwyn0/JbD/GTsSkaNxYrXDZHopr1q6
 e7sIuGLSy5uMlFRK0NiW0sgjZibgyg6YOY7FgeiYstcQny0hgzsZDDKPur/iiy9st9zi
 02UUps/eBf9/7sYYpuAbwHnts+rKTiGeD8Zsgpz/56npTKP11HfkhGH1sHisPAxMPrKJ
 yhGNgTtVa0gMNjvvbY0nbweBRzI7X34iKflV2k+wIlbcD0sMpPv0xG2ezviHL2+Jnycm
 L9lw==
X-Gm-Message-State: AOJu0YwHu7S624pAdG/uXVbsgseewn823b5Q2Nx4xnQ1WLvWxBbf0tiq
 DqQydx+k8idWoMJBExdkSZu0ZObDU/Zm9kKFUBhb398V5IDfrYp6F9uPgk4ajC1FkVA=
X-Gm-Gg: Acq92OHm2AM+eajPhcA0jDZhqzWFoMkOlOpo4g4d66AbOaHvdfxxRlieotuV3b9XLpk
 yOcOL3+43C5cr7IAkKm0h6+vAG/R+gkDhgFjWmqn61EA+iKEm2aNjR4h9SZZVA+AtEQTGNa1P17
 eLhIRHk80/Vhp5bq5ucf8HDCpQgRzTDzeW+C3Dcf/QEg8KlZSZTSy+E44DRYGx8bJvMABjg1TXr
 dIfvyJueHfTvpUUYDF26NIImNfzPaZfSKymbdR20gXVkVNd4VKaJWuKGnmqaN6KzdPVnTUwSnox
 FRGv8eLKQtGa8m7ciZWpnfQn5pLlhzhd0Ow/7+PsCyvlZmLpYGo90g4jvg8TQ2irnZNMEU9hE39
 HXX+sO2XZVhIaQzWdAvp4pFXElrgYK0eEK8og9uzS/g+3bGhyYiHE9cF9sMwHsxhh1xsiOk4H5m
 Jwk7gwY9cGNaxa6Dt7dxKy6lXocniZGMd6xCtSY83Orv7LoUf4aJon7btvHr9v0R6CDwmc4q0GB
 w==
X-Received: by 2002:a05:6a00:1a86:b0:841:89a4:5f86 with SMTP id
 d2e1a72fcca58-842253d6038mr1154021b3a.21.1780090448706; 
 Fri, 29 May 2026 14:34:08 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.34.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:34:08 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 06/15] monitor: assign unique default ID to anonymous
 monitors
Date: Sat, 30 May 2026 05:33:12 +0800
Message-ID: <20260529213321.96271-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52a.google.com
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

Currently, dynamically or implicitly created monitors (such as those
generated via '-monitor stdio', GDB stub terminals, or mux chardevs)
leave the 'id' field in the Monitor struct as NULL. But the original
@MonitorOptions have the @id field. This makes it difficult to track,
debug, or associate monitors with specific iothreads or
infrastructure components.

Fix this by introducing monitor_get_id(), which uses an atomic counter
to generate a unique fallback name ("mon_default_X") when 'id' is
not explicitly supplied in MonitorOptions. Update all internal HMP
and QMP initialization paths to propagate and store this string.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 chardev/char.c             |  2 +-
 gdbstub/system.c           |  3 ++-
 include/monitor/monitor.h  |  6 ++++--
 monitor/hmp.c              | 20 +++++++++++++++++++-
 monitor/monitor-internal.h |  2 ++
 monitor/monitor.c          |  4 ++--
 monitor/qmp.c              | 18 +++++++++++++++++-
 stubs/monitor-internal.c   |  3 ++-
 8 files changed, 49 insertions(+), 9 deletions(-)

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
index 55649a8664..c6ccd34cda 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -19,11 +19,13 @@ bool monitor_cur_is_qmp(void);
 
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
+char *monitor_get_id(void);
 
 int monitor_suspend(Monitor *mon);
 void monitor_resume(Monitor *mon);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index cc4390486e..47f57f69e5 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -43,6 +43,8 @@
 #include "system/block-backend.h"
 #include "trace.h"
 
+static int mon_hmp_id_counter;
+
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque)
 {
@@ -65,6 +67,14 @@ void monitor_read_command(MonitorHMP *mon, int show_prompt)
     }
 }
 
+static char *monitor_hmp_get_id(void)
+{
+    int id = qatomic_fetch_inc(&mon_hmp_id_counter);
+    char *name = g_strdup_printf("mon_default_hmp_%d", id);
+
+    return name;
+}
+
 int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
                           void *opaque)
 {
@@ -1522,10 +1532,18 @@ static void monitor_readline_flush(void *opaque)
     monitor_flush(&mon->common);
 }
 
-void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
+void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
+                      Error **errp)
 {
     MonitorHMP *mon = g_new0(MonitorHMP, 1);
 
+    if (!id) {
+        g_autofree char *mon_id =  monitor_hmp_get_id();
+        mon->common.id = g_strdup(mon_id);
+    } else {
+        mon->common.id = g_strdup(id);
+    }
+
     if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
         g_free(mon);
         return;
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index a5c4aba306..2060311b03 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -108,6 +108,8 @@ struct Monitor {
     bool skip_flush;
     bool use_io_thread;
 
+    char *id;
+
     char *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
 
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 00b93ed612..dafb4ad8b0 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -732,7 +732,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
-        monitor_init_qmp(chr, opts->pretty, errp);
+        monitor_init_qmp(chr, opts->pretty, opts->id, errp);
         break;
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
@@ -743,7 +743,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
             error_setg(errp, "'pretty' is not compatible with HMP monitors");
             return -1;
         }
-        monitor_init_hmp(chr, true, errp);
+        monitor_init_hmp(chr, true, opts->id, errp);
         break;
     default:
         g_assert_not_reached();
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 687019811f..b210850a15 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -56,6 +56,7 @@
  * Access must be atomic for thread safety.
  */
 static bool qmp_dispatcher_co_busy = true;
+static int mon_qmp_id_counter;
 
 struct QMPRequest {
     /* Owner of the request */
@@ -76,6 +77,14 @@ static bool qmp_oob_enabled(MonitorQMP *mon)
     return mon->capab[QMP_CAPABILITY_OOB];
 }
 
+static char *monitor_qmp_get_id(void)
+{
+    int id = qatomic_fetch_inc(&mon_qmp_id_counter);
+    char *name = g_strdup_printf("mon_default_qmp_%d", id);
+
+    return name;
+}
+
 static void monitor_qmp_caps_reset(MonitorQMP *mon)
 {
     memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
@@ -513,10 +522,17 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     monitor_list_append(&mon->common);
 }
 
-void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
+void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error **errp)
 {
     MonitorQMP *mon = g_new0(MonitorQMP, 1);
 
+    if (!id) {
+        g_autofree char *mon_id =  monitor_qmp_get_id();
+        mon->common.id = g_strdup(mon_id);
+    } else {
+        mon->common.id = g_strdup(id);
+    }
+
     if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
         g_free(mon);
         return;
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


