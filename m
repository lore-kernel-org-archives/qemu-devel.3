Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE912CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPorZ-0000Hc-0c; Wed, 20 May 2026 17:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPor0-0007ms-EH
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqy-00051L-14
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779314003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RREV8hzA8/5WtMwkYEuhorHQd2Tymhqo2wbwMEUqD3w=;
 b=e3wfJaV8SxbvqEI7IkOy4bZ13r4+FM3kwov3KBiYsbjJobgfsUtrTv8MVa5wUCWmx8Rhg+
 Sb71rlvOt5It7bBj6lM3AikmNjddmA4IM2vkASl4jgaMaTjczzak4UiU7BEsJhevYEnRxv
 mtE9I/9UKFjNiorDXZH9RYuSz1jSyew=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-ebzaoaG9NaakWUG0AMlJFQ-1; Wed,
 20 May 2026 17:53:21 -0400
X-MC-Unique: ebzaoaG9NaakWUG0AMlJFQ-1
X-Mimecast-MFC-AGG-ID: ebzaoaG9NaakWUG0AMlJFQ_1779314001
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AFDB1800359
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:53:21 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1A001800465; Wed, 20 May 2026 21:53:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:34 +0400
Subject: [PATCH 33/40] monitor: guard HMP-specific code with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-33-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8115;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=x+A7gittc42wCYkzsQ0krT0K5pxUHKEFswcZ957WsS4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyE3M/Nrj8g1DDd/I/+F/onei+Srec/ZOtef
 MHigNzw0a2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4shAAKCRDa6OEJdZac
 5QJXD/9wRtePunmiojmr0qzXj6WfAFMlsdKUVChoqpZMUzAuQnmjDavA5gpKlmJmV7cZExNzqHC
 5eUtVkKb1IwFS1RRn+jpA72ZxmAILo6FXX62szW81hL+8rGukxO7vpxcYxbI3Zd66koPvO70OYw
 cpaaN7s4kSprG+QWlmFoonSJE8Cl5ngCWRw4FWdoHjCshpAgwCD6P6JsLWVMF4cPfyzyEKHbs8M
 oAAv5zUkHJISxV+U5KmhhcJsBKw3Yzl2XgX2PRjtG0d/EPlLl4ZSQf1vDlOAsHqO6v0DV7d8u/o
 mRyf/hT/fNXhaO3jZvORUYKZNKVCRCJK5OM1SMbANnGkMm2Qa3P49GymIVOaeFCL9BRn1uicYWI
 YWc5xUa30q53fVOGqW9m6dIYXWeS1T6v8ZWPAu3QEpxe1qltufa+4F9U2ASSx46gPCrnYr4J3S4
 2+K+vYbI4JSgGB4FP35MmFTK1A9I3IDpTblhk3k10qX3yzx+PMlWpuLrKjQjtdbI9mVAGhXSyZi
 /qFa4Ad0X/55CDIyuGxx6qz0tC4BXq6S5Q7bHCSWV6XQvDN7jNaa+PrPmq5OCB/SWzoTCME/HdP
 jjtY1Jtba0YjVYq5T1RtYkmGaBGiFIJqPVGdo6y2chmaQDZ3n0k4m8dyGXnKvfgc+4WbaLQgPKt
 VOH/4YKPCmy7QAw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add #ifdef CONFIG_HMP guards around HMP-specific declarations in
monitor headers and implementations:

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/hmp.h     |  2 ++
 include/monitor/monitor.h | 11 +++++++++++
 monitor/monitor.c         | 31 +++++++++++++++++++++++++++++++
 monitor/qmp-cmds.c        |  2 ++
 stubs/monitor-core.c      |  2 ++
 stubs/monitor-internal.c  |  2 ++
 6 files changed, 50 insertions(+)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 9258a049bff..7bc524cd4ff 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -14,6 +14,7 @@
 #ifndef HMP_H
 #define HMP_H
 
+#ifdef CONFIG_HMP
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
 #include "monitor/monitor.h"
@@ -195,3 +196,4 @@ void hmp_info_cmma(Monitor *mon, const QDict *qdict);
 void hmp_migrationmode(Monitor *mon, const QDict *qdict);
 
 #endif
+#endif
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 17182e626a7..3457f4a7f88 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -20,7 +20,9 @@ bool monitor_cur_is_qmp(void);
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
 void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
+#ifdef CONFIG_HMP
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
+#endif
 int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_init_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
@@ -32,28 +34,37 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp);
 int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
 
 int monitor_puts(Monitor *mon, const char *str);
+
+#ifdef CONFIG_HMP
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
     G_GNUC_PRINTF(2, 0);
 int monitor_printf(Monitor *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 void monitor_printc(Monitor *mon, int ch);
+#endif
+
 void monitor_flush(Monitor *mon);
 int monitor_get_cpu_index(Monitor *mon);
 
 int monitor_puts_locked(Monitor *mon, const char *str);
 void monitor_flush_locked(Monitor *mon);
 
+
+#ifdef CONFIG_HMP
 void monitor_read_command(MonitorHMP *mon, int show_prompt);
 int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
                           void *opaque);
+#endif
 
 AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
                                 const char *opaque, Error **errp);
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags, Error **errp);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 
+#ifdef CONFIG_HMP
 void monitor_register_hmp(const char *name, bool info,
                           void (*cmd)(Monitor *mon, const QDict *qdict));
 void monitor_register_hmp_info_hrt(const char *name,
                                    HumanReadableText *(*handler)(Error **errp));
+#endif
 
 #endif /* MONITOR_H */
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 2dec0e299af..096a5ee748d 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -116,6 +116,7 @@ bool monitor_cur_is_qmp(void)
     return cur_mon && monitor_is_qmp(cur_mon);
 }
 
+#ifdef CONFIG_HMP
 /**
  * Is @mon is using readline?
  * Note: not all HMP monitors use readline, e.g., gdbserver has a
@@ -134,6 +135,12 @@ static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
 
     return !monitor_uses_readline(container_of(mon, MonitorHMP, common));
 }
+#else
+static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
+{
+    return false;
+}
+#endif
 
 static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
                                   void *opaque)
@@ -211,6 +218,7 @@ int monitor_puts(Monitor *mon, const char *str)
     return monitor_puts_locked(mon, str);
 }
 
+#ifdef CONFIG_HMP
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
     char *buf;
@@ -267,6 +275,7 @@ void monitor_printc(Monitor *mon, int c)
     }
     monitor_printf(mon, "'");
 }
+#endif
 
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     /* Limit guest-triggerable events to 1 per second */
@@ -541,6 +550,7 @@ static void monitor_accept_input(void *opaque)
     Monitor *mon = opaque;
 
     qemu_mutex_lock(&mon->mon_lock);
+#ifdef CONFIG_HMP
     if (!monitor_is_qmp(mon)) {
         MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
         assert(hmp_mon->rs);
@@ -555,6 +565,9 @@ static void monitor_accept_input(void *opaque)
     } else {
         qemu_mutex_unlock(&mon->mon_lock);
     }
+#else
+    qemu_mutex_unlock(&mon->mon_lock);
+#endif
 
     qemu_chr_fe_accept_input(&mon->chr);
 }
@@ -631,9 +644,11 @@ void monitor_data_destroy(Monitor *mon)
     if (monitor_is_qmp(mon)) {
         monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
     } else {
+#ifdef CONFIG_HMP
         MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
         readline_free(hmp_mon->rs);
         g_free(hmp_mon->mon_cpu_path);
+#endif
     }
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);
@@ -733,13 +748,18 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
     }
 
     if (!opts->has_mode) {
+#ifdef CONFIG_HMP
         opts->mode = allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MODE_CONTROL;
+#else
+        opts->mode = MONITOR_MODE_CONTROL;
+#endif
     }
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
         monitor_init_qmp(chr, opts->pretty, errp);
         break;
+#ifdef CONFIG_HMP
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
             error_setg(errp, "Only QMP is supported");
@@ -751,6 +771,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
         }
         monitor_init_hmp(chr, true, errp);
         break;
+#endif
     default:
         g_assert_not_reached();
     }
@@ -764,6 +785,16 @@ int monitor_init_opts(QemuOpts *opts, Error **errp)
     MonitorOptions *options;
     int ret;
 
+#ifndef CONFIG_HMP
+    const char *mode = qemu_opt_get(opts, "mode");
+    /* readline is HMP..  */
+    if (mode && g_str_equal(mode, "readline")) {
+        error_setg(errp, "HMP monitor is not available,"
+                   " use '-qmp' instead of '-monitor'");
+        return -1;
+    }
+#endif
+
     v = opts_visitor_new(opts);
     visit_type_MonitorOptions(v, NULL, &options, errp);
     visit_free(v);
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 0c409c27dc3..cca25c18a15 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -162,6 +162,7 @@ void qmp_add_client(const char *protocol, const char *fdname,
     }
 }
 
+#ifdef CONFIG_HMP
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
                                 int64_t cpu_index, Error **errp)
 {
@@ -189,6 +190,7 @@ out:
     monitor_data_destroy(&hmp.common);
     return output;
 }
+#endif
 
 static void __attribute__((__constructor__)) monitor_init_qmp_commands(void)
 {
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 078a5012e9b..b4a4de41aa2 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -21,6 +21,7 @@ void qapi_event_emit(QAPIEvent event, QDict *qdict)
 {
 }
 
+#ifdef CONFIG_HMP
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
     /*
@@ -37,3 +38,4 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
     }
     return -1;
 }
+#endif
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 4fece49d531..29274bd2b4a 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -8,6 +8,8 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
     return -1;
 }
 
+#ifdef CONFIG_HMP
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
 }
+#endif

-- 
2.54.0


