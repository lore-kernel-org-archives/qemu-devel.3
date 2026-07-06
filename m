Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44822C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjqq-0001sI-FF; Mon, 06 Jul 2026 09:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjqj-0001rN-7X
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjqf-0001cL-N0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783346340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mo8+0CeBpO/xq8m33uq8yDSNPTo4TkPck571PuAEanc=;
 b=XdW7Y0DmvJylwXxdtJmE3zTwNECDvsABbAbWyfEeU/CEvIfT1rTiNA51MUJVoHvwKsSb4n
 zTbEznO+5EKDjMjPUcqzpOPzUYMJjQG8bVGiX5cUb/TmEMaZ9MAr8KS1Hdv15x/CBitc5C
 d76w3emK61kNttzPavrSrh9g43slY+A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-zYx_4-tlOPWrLAgP7_YNaw-1; Mon,
 06 Jul 2026 09:58:56 -0400
X-MC-Unique: zYx_4-tlOPWrLAgP7_YNaw-1
X-Mimecast-MFC-AGG-ID: zYx_4-tlOPWrLAgP7_YNaw_1783346335
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ABF21955E74; Mon,  6 Jul 2026 13:58:55 +0000 (UTC)
Received: from berrange.com (unknown [10.44.48.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE9313000B4D; Mon,  6 Jul 2026 13:58:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v7 06/35] monitor: pass chardev ID into monitor constructor
 instead of object
Date: Mon,  6 Jul 2026 14:57:54 +0100
Message-ID: <20260706135824.2623960-7-berrange@redhat.com>
In-Reply-To: <20260706135824.2623960-1-berrange@redhat.com>
References: <20260706135824.2623960-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Current the monitor_new_hmp/monitor_new_qmp constructors accept
a Chardev object pointer. To facilitate the next commit which will
introduce a QOM property for the character device ID, switch to
accepting an chardev ID in the constructor.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char.c            |  3 ++-
 gdbstub/system.c          |  2 +-
 include/monitor/monitor.h |  4 ++--
 monitor/hmp.c             | 22 ++++++++++++++++------
 monitor/monitor.c         | 11 ++---------
 monitor/qmp.c             | 21 +++++++++++++++------
 stubs/monitor-internal.c  |  2 +-
 7 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index c71ffa7963..22e5bae388 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -804,8 +804,9 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
     }
 
     if (qemu_opt_get_bool(opts, "mux", 0)) {
+        const char *chardev_id = qemu_opts_id(opts);
         assert(permit_mux_mon);
-        monitor_new_hmp(NULL, chr, true, &err);
+        monitor_new_hmp(NULL, chardev_id, true, &err);
         if (err) {
             error_report_err(err);
             object_unparent(OBJECT(chr));
diff --git a/gdbstub/system.c b/gdbstub/system.c
index fda8ef9352..fd754e5664 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -389,7 +389,7 @@ bool gdbserver_start(const char *device, Error **errp)
         /* Initialize a monitor terminal for gdb */
         mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
                                    NULL, NULL, &error_abort);
-        monitor_new_hmp(NULL, mon_chr, false, &error_abort);
+        monitor_new_hmp(NULL, mon_chr->label, false, &error_abort);
     } else {
         qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
         mon_chr = gdbserver_system_state.mon_chr;
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 83723f705a..bfbeedec9b 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -29,9 +29,9 @@ bool monitor_cur_is_qmp(void);
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
 char *monitor_compat_id(void);
-void monitor_new_qmp(const char *id, Chardev *chr,
+void monitor_new_qmp(const char *id, const char *chardev_id,
                      bool pretty, Error **errp);
-void monitor_new_hmp(const char *id, Chardev *chr,
+void monitor_new_hmp(const char *id, const char *chardev_id,
                      bool use_readline, Error **errp);
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_new_opts(QemuOpts *opts, Error **errp);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index da11e56854..1704166326 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -39,6 +39,7 @@
 #include "qemu/base-arch-defs.h"
 #include "qemu/target-info.h"
 #include "qemu/units.h"
+#include "qapi/error.h"
 #include "exec/gdbstub.h"
 #include "system/block-backend.h"
 #include "trace.h"
@@ -1538,16 +1539,25 @@ static void monitor_readline_flush(void *opaque)
     monitor_flush(&mon->parent_obj);
 }
 
-void monitor_new_hmp(const char *id, Chardev *chr,
+void monitor_new_hmp(const char *id, const char *chardev_id,
                      bool use_readline, Error **errp)
 {
     MonitorHMP *mon;
     g_autofree char *autoid = id ? NULL : monitor_compat_id();
-    Object *obj = object_new_with_props(TYPE_MONITOR_HMP,
-                                        object_get_objects_root(),
-                                        id ? id : autoid,
-                                        errp,
-                                        NULL);
+    Chardev *chr;
+    Object *obj;
+
+    chr = qemu_chr_find(chardev_id);
+    if (chr == NULL) {
+        error_setg(errp, "chardev \"%s\" not found", chardev_id);
+        return;
+    }
+
+    obj = object_new_with_props(TYPE_MONITOR_HMP,
+                                object_get_objects_root(),
+                                id ? id : autoid,
+                                errp,
+                                NULL);
     if (!obj) {
         return;
     }
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 18a1d8ddde..cb0299a2f7 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -741,13 +741,6 @@ char *monitor_compat_id(void)
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
 {
     ERRP_GUARD();
-    Chardev *chr;
-
-    chr = qemu_chr_find(opts->chardev);
-    if (chr == NULL) {
-        error_setg(errp, "chardev \"%s\" not found", opts->chardev);
-        return -1;
-    }
 
     if (!opts->has_mode) {
         opts->mode = allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MODE_CONTROL;
@@ -755,7 +748,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
-        monitor_new_qmp(opts->id, chr, opts->pretty, errp);
+        monitor_new_qmp(opts->id, opts->chardev, opts->pretty, errp);
         break;
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
@@ -766,7 +759,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
             error_setg(errp, "'pretty' is not compatible with HMP monitors");
             return -1;
         }
-        monitor_new_hmp(opts->id, chr, true, errp);
+        monitor_new_hmp(opts->id, opts->chardev, true, errp);
         break;
     default:
         g_assert_not_reached();
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 1ef09352fc..e2f841212b 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -527,16 +527,25 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     monitor_list_append(&mon->parent_obj);
 }
 
-void monitor_new_qmp(const char *id, Chardev *chr,
+void monitor_new_qmp(const char *id, const char *chardev_id,
                      bool pretty, Error **errp)
 {
     MonitorQMP *mon;
     g_autofree char *autoid = id ? NULL : monitor_compat_id();
-    Object *obj = object_new_with_props(TYPE_MONITOR_QMP,
-                                        object_get_objects_root(),
-                                        id ? id : autoid,
-                                        errp,
-                                        NULL);
+    Chardev *chr;
+    Object *obj;
+
+    chr = qemu_chr_find(chardev_id);
+    if (chr == NULL) {
+        error_setg(errp, "chardev \"%s\" not found", chardev_id);
+        return;
+    }
+
+    obj = object_new_with_props(TYPE_MONITOR_QMP,
+                                object_get_objects_root(),
+                                id ? id : autoid,
+                                errp,
+                                NULL);
     if (!obj) {
         return;
     }
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 20367b7e9a..f94b5e5c21 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -8,7 +8,7 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
     return -1;
 }
 
-void monitor_new_hmp(const char *id, Chardev *chr,
+void monitor_new_hmp(const char *id, const char *chardev_id,
                      bool use_readline, Error **errp)
 {
 }
-- 
2.55.0


