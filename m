Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE211C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96yL-0004sY-33; Tue, 22 Sep 2026 16:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xl-0004Cu-Tn
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xk-00083Z-14
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RyfhKlZkwl5XMd0Mk7GKH6ETO4+1HsezyqdsV/FL+Iw=;
 b=WaPQYcIIHIksUw6LQkMac0NfvntMdJhenlifI4G3ERs0VUDyKNUbdoa5X6doUb89sNlU2l
 gn3+rA9TceVf8S5Vata1tlgm4xm35/CtR1h8Gl380fa3Iy2Bbq0tecThaaQm1qsXrPQMdi
 28VDr8WDCV4HDJcIKZQcqpsoXJBov/o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-WTtLw25oN4KY5FICm6yP8g-1; Tue,
 22 Sep 2026 16:19:32 -0400
X-MC-Unique: WTtLw25oN4KY5FICm6yP8g-1
X-Mimecast-MFC-AGG-ID: WTtLw25oN4KY5FICm6yP8g_1790108371
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 148C319541BB; Tue, 22 Sep 2026 20:19:31 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 48DD81800370; Tue, 22 Sep 2026 20:19:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:13 +0400
Subject: [PATCH 06/88] monitor: allow a bare Monitor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-6-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6564;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dMAhMQFKjXriER2uy0I1fY/g6vj1m7FbD22JhHV+4Lo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKuUoUMF0v22CIU4BqZIQWRPTufksv8wZDMa
 GlGaAsIoMyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5WCfD/43K2Nt4pu9UOA250C9OIcJDtspCmF7FqOajBLvIAkuk606AnrL7L6xgeoCF3YPh8D4QoP
 q99E79j3yWCCI5Q144MhtQDdwAmoAlKt4Oiz2k7HazF5BaclxsSv5FfdNkPm13yblQLnAcy/dA7
 VyzozsLQak3J8l1WIZAUBz9MMzOzG7kbzXph8nLCO34H8rRODo6NEO/oOrQ7XQ47f7f5BxK50wN
 CmzJ8KfcM5XziQ54rmwCVpj9zCEab29dr4RnXw8W1k1DvRwRoOkqhwyR4tkpZV0TL9UKZnRxdDP
 nZKHxmZkgW/jsmUKp48oPDQBKX43d2EqQQonwjgYG4B/xFSJ2+h8ZD76iKXpqiZQwq8BJ309EoV
 4bE0fiLxxdZitP9OB3NcGJ6Uo0V3AzZl6CX2rXfgbm8Q0BU3jrUhYdRAam/9YgeZmML6TNZZd3W
 ffE4gnzxYBZ2oKo4a0MoNoRiNl4r3If+6amRRqDQIndHeljwBh8EmVbv7b/NFACPWTly1VHiQrY
 M90uDLWWWEohzDMcR7k3KChU/97x+hok6zDET0sxplW90cryYJyR77YCyDMGQH0O0QqvNLlQgcM
 og30prHobAQxqR7iGwQ+BHDq0BQ1l+lHu+zgHByT6QlaYrLS1aZUKMp90Br5ybo9GrODeeXIGc8
 AMT+VDz7V2ovQsg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

For qemu-io commands, we want to capture qemu_printf() output. Let's
allow to instantiate a bare monitor and steal its output.

We move UserCreatable to the leaf HMP & QMP monitors, to only allow
-object on these.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/monitor.h |  2 ++
 monitor/hmp.c             | 12 ++++--------
 monitor/monitor.c         | 28 ++++++++++++++++------------
 monitor/qmp.c             | 12 ++++--------
 4 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 2a550aec023f..e8216b2f4cbf 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -29,6 +29,7 @@ void monitor_new_qmp(const char *id, const char *chardev_id,
                      bool pretty, Error **errp);
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_new_opts(QemuOpts *opts, Error **errp);
+bool monitor_complete(Monitor *mon, Error **errp);
 void monitor_cleanup(void);
 
 void monitor_suspend(Monitor *mon);
@@ -39,6 +40,7 @@ int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
 
 int monitor_puts(Monitor *mon, const char *str);
 void monitor_flush(Monitor *mon);
+GString *monitor_steal_output(Monitor *mon);
 
 int monitor_puts_locked(Monitor *mon, const char *str);
 void monitor_flush_locked(Monitor *mon);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 488ec23937df..53d84d160992 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -46,7 +46,9 @@
 #include "system/block-backend.h"
 #include "trace.h"
 
-OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(MonitorHMP, monitor_hmp,
+                                   MONITOR_HMP, MONITOR,
+                                   { TYPE_USER_CREATABLE });
 
 MonitorHMP *monitor_cur_hmp(void)
 {
@@ -1629,17 +1631,11 @@ void monitor_new_hmp(const char *id, const char *chardev_id,
 static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
 {
     MonitorHMP *hmp = MONITOR_HMP(uc);
-    UserCreatableClass *ucc_parent =
-        USER_CREATABLE_CLASS(
-            object_class_get_parent(
-                OBJECT_CLASS(MONITOR_HMP_GET_CLASS(hmp))));
     ERRP_GUARD();
 
-    ucc_parent->complete(uc, errp);
-    if (*errp) {
+    if (!monitor_complete(MONITOR(uc), errp)) {
         return;
     }
-
     if (hmp->parent_obj.chardev_id) {
         if (hmp->use_readline) {
             hmp->rs = readline_init(monitor_readline_printf,
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 2654b81890dd..ee462cade7d1 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -79,8 +79,7 @@ static bool monitor_destroyed;
 
 int monitor_device_index;
 
-OBJECT_DEFINE_TYPE_EXTENDED(Monitor, monitor, MONITOR, OBJECT, true,
-                            { TYPE_USER_CREATABLE }, {});
+OBJECT_DEFINE_TYPE(Monitor, monitor, MONITOR, OBJECT)
 
 static void monitor_finalize(Object *obj)
 {
@@ -110,17 +109,11 @@ static void monitor_set_chardev_id(Object *obj, const char *str, Error **errp)
     mon->chardev_id = g_strdup(str);
 }
 
-static void monitor_complete(UserCreatable *uc, Error **errp);
-
 static void monitor_class_init(ObjectClass *cls, const void *data)
 {
-    UserCreatableClass *ucc = USER_CREATABLE_CLASS(cls);
-
     object_class_property_add_str(cls, "chardev",
                                   monitor_get_chardev_id,
                                   monitor_set_chardev_id);
-
-    ucc->complete = monitor_complete;
 }
 
 static void monitor_init(Object *obj)
@@ -273,6 +266,16 @@ int monitor_puts(Monitor *mon, const char *str)
     return monitor_puts_locked(mon, str);
 }
 
+GString *monitor_steal_output(Monitor *mon)
+{
+    GString *output;
+
+    QEMU_LOCK_GUARD(&mon->mon_lock);
+    output = mon->outbuf;
+    mon->outbuf = g_string_new(NULL);
+    return output;
+}
+
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
@@ -658,20 +661,20 @@ char *monitor_compat_id(void)
     return g_strdup_printf("compat_monitor%d", monitor_device_index++);
 }
 
-static void monitor_complete(UserCreatable *uc, Error **errp)
+bool monitor_complete(Monitor *mon, Error **errp)
 {
-    Monitor *mon = MONITOR(uc);
     AioContext *ctx;
 
+    assert(!mon->accept_input_bh);
     if (mon->chardev_id) {
         Chardev *chr = qemu_chr_find(mon->chardev_id);
         if (chr == NULL) {
             error_setg(errp, "chardev \"%s\" not found", mon->chardev_id);
-            return;
+            return false;
         }
 
         if (!qemu_chr_fe_init(&mon->chr, chr, errp)) {
-            return;
+            return false;
         }
     }
 
@@ -685,6 +688,7 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
         ctx = qemu_get_aio_context();
     }
     mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
+    return true;
 }
 
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index aec03157750c..00126ae0983c 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -77,7 +77,9 @@ QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 /* Monitor being serviced by the dispatcher.  Protected by BQL. */
 static MonitorQMP *qmp_dispatcher_current_mon;
 
-OBJECT_DEFINE_TYPE(MonitorQMP, monitor_qmp, MONITOR_QMP, MONITOR);
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(MonitorQMP, monitor_qmp,
+                                   MONITOR_QMP, MONITOR,
+                                   { TYPE_USER_CREATABLE });
 
 static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon);
 
@@ -704,17 +706,11 @@ void monitor_new_qmp(const char *id, const char *chardev_id,
 static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
 {
     MonitorQMP *mon = MONITOR_QMP(uc);
-    UserCreatableClass *ucc_parent =
-        USER_CREATABLE_CLASS(
-            object_class_get_parent(
-                OBJECT_CLASS(MONITOR_QMP_GET_CLASS(mon))));
     ERRP_GUARD();
 
-    ucc_parent->complete(uc, errp);
-    if (*errp) {
+    if (!monitor_complete(MONITOR(uc), errp)) {
         return;
     }
-
     qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
 
     if (monitor_requires_iothread(MONITOR(mon))) {

-- 
2.56.0.rc0.29.g47ce80527c56


