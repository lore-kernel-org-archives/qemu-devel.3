Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0C3C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJtc-00062O-La; Thu, 02 Jul 2026 12:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJtY-00061W-Ni
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJtW-0006VN-Sf
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783008246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5FpvF4NohJGHtssMLb6IIzjd/3VWRN6AYr/EUEX952o=;
 b=IQPyUJJ1iqJfc1LPouerpdZ9Kp1Bxvh217MqEIrBoCRYq+S67bKjkJCRxVGtNgn+RMzeid
 hvaP+iAm7KH+ZskyxKFLa8tyxGFL7eSGUKNtb2W1cspwUjTPHsOioDIVKbWKUv9ox2iBKY
 vNNqSQhwjN1Mg7rcVRRXYGA7YRMsh8Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-BKXLz232P0SOf_Du5s_Zmw-1; Thu,
 02 Jul 2026 12:04:03 -0400
X-MC-Unique: BKXLz232P0SOf_Du5s_Zmw-1
X-Mimecast-MFC-AGG-ID: BKXLz232P0SOf_Du5s_Zmw_1783008241
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98C1C18CC497; Thu,  2 Jul 2026 16:04:01 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.186])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA170194510E; Thu,  2 Jul 2026 16:03:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PATCH v6 04/34] monitor: rename monitor_init* to monitor_new*
Date: Thu,  2 Jul 2026 17:03:07 +0100
Message-ID: <20260702160337.1910921-5-berrange@redhat.com>
In-Reply-To: <20260702160337.1910921-1-berrange@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

The current "monitor_init" functions will clash with the methods of the
same name that are required by QOM. To ease the transition to QOM,
rename them out of the way.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char.c                       |  2 +-
 gdbstub/system.c                     |  2 +-
 include/monitor/monitor.h            |  8 ++++----
 monitor/hmp.c                        |  2 +-
 monitor/monitor.c                    | 10 +++++-----
 monitor/qmp.c                        |  2 +-
 storage-daemon/qemu-storage-daemon.c |  2 +-
 stubs/monitor-internal.c             |  2 +-
 system/vl.c                          |  2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index ca8b37ed8d..813c04d953 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -805,7 +805,7 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
 
     if (qemu_opt_get_bool(opts, "mux", 0)) {
         assert(permit_mux_mon);
-        monitor_init_hmp(chr, true, &err);
+        monitor_new_hmp(chr, true, &err);
         if (err) {
             error_report_err(err);
             object_unparent(OBJECT(chr));
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 2063b63b2f..18f6a62b2e 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -389,7 +389,7 @@ bool gdbserver_start(const char *device, Error **errp)
         /* Initialize a monitor terminal for gdb */
         mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
                                    NULL, NULL, &error_abort);
-        monitor_init_hmp(mon_chr, false, &error_abort);
+        monitor_new_hmp(mon_chr, false, &error_abort);
     } else {
         qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
         mon_chr = gdbserver_system_state.mon_chr;
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 55649a8664..b9642b58ba 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -19,10 +19,10 @@ bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
-void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
-void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
-int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
-int monitor_init_opts(QemuOpts *opts, Error **errp);
+void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp);
+void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp);
+int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
+int monitor_new_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
 
 int monitor_suspend(Monitor *mon);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 3dde52ddbe..4e4468424a 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1524,7 +1524,7 @@ static void monitor_readline_flush(void *opaque)
     monitor_flush(&mon->parent_obj);
 }
 
-void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
+void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
     MonitorHMP *mon = g_new0(MonitorHMP, 1);
 
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 0b7b464ebe..a87597e606 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -715,7 +715,7 @@ void monitor_init_globals(void)
     aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
 }
 
-int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
+int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
 {
     ERRP_GUARD();
     Chardev *chr;
@@ -732,7 +732,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
-        monitor_init_qmp(chr, opts->pretty, errp);
+        monitor_new_qmp(chr, opts->pretty, errp);
         break;
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
@@ -743,7 +743,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
             error_setg(errp, "'pretty' is not compatible with HMP monitors");
             return -1;
         }
-        monitor_init_hmp(chr, true, errp);
+        monitor_new_hmp(chr, true, errp);
         break;
     default:
         g_assert_not_reached();
@@ -752,7 +752,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
     return *errp ? -1 : 0;
 }
 
-int monitor_init_opts(QemuOpts *opts, Error **errp)
+int monitor_new_opts(QemuOpts *opts, Error **errp)
 {
     Visitor *v;
     MonitorOptions *options;
@@ -765,7 +765,7 @@ int monitor_init_opts(QemuOpts *opts, Error **errp)
         return -1;
     }
 
-    ret = monitor_init(options, true, errp);
+    ret = monitor_new(options, true, errp);
     qapi_free_MonitorOptions(options);
     return ret;
 }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 27934206db..cb28a95efd 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -513,7 +513,7 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     monitor_list_append(&mon->parent_obj);
 }
 
-void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
+void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
 {
     MonitorQMP *mon = g_new0(MonitorQMP, 1);
 
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index eb72561358..50dbfbd97a 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -330,7 +330,7 @@ static void process_options(int argc, char *argv[], bool pre_init_pass)
                 visit_free(v);
 
                 /* TODO Catch duplicate monitor IDs */
-                monitor_init(monitor, false, &error_fatal);
+                monitor_new(monitor, false, &error_fatal);
                 qapi_free_MonitorOptions(monitor);
                 break;
             }
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 4fece49d53..23d58da184 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -8,6 +8,6 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
     return -1;
 }
 
-void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
+void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
 }
diff --git a/system/vl.c b/system/vl.c
index 1d14e2e207..6643242729 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1247,7 +1247,7 @@ static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 
 static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
-    return monitor_init_opts(opts, errp);
+    return monitor_new_opts(opts, errp);
 }
 
 static void monitor_parse(const char *str, const char *mode, bool pretty)
-- 
2.54.0


