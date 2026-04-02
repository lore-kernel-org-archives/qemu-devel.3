Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD33DD6AB17
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8PS5-0003kH-NY; Thu, 02 Apr 2026 17:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w8PS4-0003k0-FC
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:19:44 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w8PS2-0004an-Ne
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:19:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E167F4084D;
 Thu,  2 Apr 2026 21:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BADC19424;
 Thu,  2 Apr 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775164772;
 bh=ieDCuJn1WMUVM16tnw255pab6Dta4Qq851/s71lqv+w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=TkdNgeJSUvsdY4wPbjLkkppe/fghaLg5v4a7/Qjm3eWTZD4JTJ3pxYJd+mPPXUgIs
 LwdqeSMhlVr04VmQbFqvDPRjlLlzte7cR/9kp0Mo84oR9/d6X2Q7ybg9xziAX2czeT
 i71gwMLT6KrdPl9eTfgMaZgs1slRg7rozzwIa7ei+BoYILND3SE82ATEy770+HyUUm
 0GMV5dMshFzVShH+qtxeiGmmgxW0w73QGMLD0Lcz8isSOaCqKNOSfjeM0ipotf4kWx
 fv43F/XfR6EsU8TRI+0U+J7OGLMFfYcjuRDwWdNYQ7TBvMEKKd1VJF6cNEx62YBhvg
 A+YgEIx9QdWaw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 02 Apr 2026 23:19:16 +0200
Subject: [PATCH 1/5] monitor: store monitor id and dynamic flag in Monitor
 struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-work-qmp-monitor-hotplug-v1-1-6313a5cdd574@kernel.org>
References: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
In-Reply-To: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4689; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ieDCuJn1WMUVM16tnw255pab6Dta4Qq851/s71lqv+w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSeuxu/WeyRxvau3op1t0xbqw/zf5qbJyzxwO166IGO2
 ftmC11d2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRZ1mMDEs4pFt/3jn8d9IW
 LaejU7T77W+UBv+RNVE4+XmCzs4swcOMDM8jp6WYlsYv/q8oL6pzkf9B87NL/gc51JKk6n7IdC3
 NZwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=brauner@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add 'id', 'dynamic', and 'dead' fields to struct Monitor. The id field
stores the monitor identifier from MonitorOptions which was previously
parsed but discarded. The dynamic flag marks monitors created at runtime
via the upcoming monitor-add command, and the dead flag will be used for
deferred destruction during monitor-remove.

Extend monitor_init_qmp() to accept id and dynamic parameters so these
are set before the monitor is added to mon_list -- this is important for
the BH/iothread path where the monitor becomes visible asynchronously.

Add monitor_find_by_id() to look up monitors by identifier, and free the
id string in monitor_data_destroy().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/monitor/monitor.h  |  3 ++-
 monitor/monitor-internal.h |  5 +++++
 monitor/monitor.c          | 15 ++++++++++++++-
 monitor/qmp.c              |  5 ++++-
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 296690e1f1..7a2bb603e4 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -19,7 +19,8 @@ bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
-void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
+void monitor_init_qmp(Chardev *chr, bool pretty, const char *id,
+                      bool dynamic, Error **errp);
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
 int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_init_opts(QemuOpts *opts, Error **errp);
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index feca111ae3..8f5fe7c111 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -98,7 +98,10 @@ struct Monitor {
     bool is_qmp;
     bool skip_flush;
     bool use_io_thread;
+    bool dynamic;               /* true if created via monitor-add */
+    bool dead;                  /* true if monitor-remove called, awaiting drain */
 
+    char *id;                   /* Monitor identifier (NULL for unnamed CLI monitors) */
     char *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
 
@@ -181,6 +184,8 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
+Monitor *monitor_find_by_id(const char *id);
+
 int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 00b93ed612..09e32b6364 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -622,6 +622,7 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
 
 void monitor_data_destroy(Monitor *mon)
 {
+    g_free(mon->id);
     g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
@@ -633,6 +634,18 @@ void monitor_data_destroy(Monitor *mon)
     qemu_mutex_destroy(&mon->mon_lock);
 }
 
+Monitor *monitor_find_by_id(const char *id)
+{
+    Monitor *mon;
+
+    QTAILQ_FOREACH(mon, &mon_list, entry) {
+        if (mon->id && strcmp(mon->id, id) == 0) {
+            return mon;
+        }
+    }
+    return NULL;
+}
+
 void monitor_cleanup(void)
 {
     /*
@@ -732,7 +745,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
-        monitor_init_qmp(chr, opts->pretty, errp);
+        monitor_init_qmp(chr, opts->pretty, opts->id, false, errp);
         break;
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 687019811f..5fbc7af074 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -513,7 +513,8 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     monitor_list_append(&mon->common);
 }
 
-void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
+void monitor_init_qmp(Chardev *chr, bool pretty, const char *id,
+                      bool dynamic, Error **errp)
 {
     MonitorQMP *mon = g_new0(MonitorQMP, 1);
 
@@ -527,6 +528,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
     monitor_data_init(&mon->common, true, false,
                       qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
 
+    mon->common.id = g_strdup(id);
+    mon->common.dynamic = dynamic;
     mon->pretty = pretty;
 
     qemu_mutex_init(&mon->qmp_queue_lock);

-- 
2.47.3


