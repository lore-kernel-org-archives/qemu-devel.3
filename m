Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C213C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJu7-0007Om-36; Thu, 02 Jul 2026 12:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJu5-0007OC-59
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJu3-0006d1-HU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783008278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyZKgkYi38i3H2UU4JJJxd0jx79heVrx+k8ZLjD6WhA=;
 b=On6GzTvG2GeQHDUMMa7yXmN8srIGnqjRrabZ4DJntvpnn03epcp4J0FoLQOVf5yK0rx86m
 +LUf1ZYKkcOp4N7tqieBjEaIYAtyTHJg75kYJ+pbjs/sNymcr5aMzmwE4P7Lqi1OBikBhn
 wpiub+kYgfMW3R3Wxt6SKSt5RxmDNqw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-ZfsSMSv-OiaXNvWq4_drJw-1; Thu,
 02 Jul 2026 12:04:37 -0400
X-MC-Unique: ZfsSMSv-OiaXNvWq4_drJw-1
X-Mimecast-MFC-AGG-ID: ZfsSMSv-OiaXNvWq4_drJw_1783008276
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 767331944AAD; Thu,  2 Jul 2026 16:04:36 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.186])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC4B9194510E; Thu,  2 Jul 2026 16:04:32 +0000 (UTC)
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
Subject: [PATCH v6 12/34] monitor: use class methods for
 monitor_qapi_event_emit
Date: Thu,  2 Jul 2026 17:03:15 +0100
Message-ID: <20260702160337.1910921-13-berrange@redhat.com>
In-Reply-To: <20260702160337.1910921-1-berrange@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This removes the need for using monitor_is_qmp() to check the
subclass type, which is an anti-pattern.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/monitor/monitor.h  |  1 +
 monitor/monitor-internal.h |  5 +++++
 monitor/monitor.c          | 15 +++------------
 monitor/qmp.c              | 20 ++++++++++++++++++++
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index bfbeedec9b..821465f17e 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -3,6 +3,7 @@
 
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-emit-events.h"
 #include "qemu/readline.h"
 #include "exec/hwaddr.h"
 #include "qom/object.h"
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 23cef68153..763b5c9625 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -111,6 +111,11 @@ struct MonitorClass {
      */
     int (*vprintf)(Monitor *mon, const char *fmt, va_list ap)
         G_GNUC_PRINTF(2, 0);
+    /*
+     * If non-NULL, the monitor is able to send event
+     * notifications back to the client
+     */
+    void (*emit_event)(Monitor *mon, QAPIEvent event, QDict *qdict);
 };
 
 struct Monitor {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 0cb0930bf4..90cfb59c66 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -348,22 +348,13 @@ static inline QEMUClockType monitor_get_event_clock(void)
 static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
 {
     Monitor *mon;
-    MonitorQMP *qmp_mon;
 
     trace_monitor_protocol_event_emit(event, qdict);
     QTAILQ_FOREACH(mon, &mon_list, entry) {
-        if (!monitor_is_qmp(mon)) {
-            continue;
+        MonitorClass *cls = MONITOR_GET_CLASS(mon);
+        if (cls->emit_event) {
+            cls->emit_event(mon, event, qdict);
         }
-
-        qmp_mon = container_of(mon, MonitorQMP, parent_obj);
-        {
-            QEMU_LOCK_GUARD(&mon->mon_lock);
-            if (qmp_mon->commands == &qmp_cap_negotiation_commands) {
-                continue;
-            }
-        }
-        qmp_send_response(qmp_mon, qdict);
     }
 }
 
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 3574b9a339..d732fff9a3 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -99,11 +99,17 @@ static void monitor_qmp_set_pretty(Object *obj, bool val, Error **errp)
     mon->pretty = val;
 }
 
+static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict);
+
 static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
 {
+    MonitorClass *moncls = MONITOR_CLASS(cls);
+
     object_class_property_add_bool(cls, "pretty",
                                    monitor_qmp_get_pretty,
                                    monitor_qmp_set_pretty);
+
+    moncls->emit_event = monitor_qmp_emit_event;
 }
 
 static void handle_qmp_command(void *opaque, QObject *req, Error *err);
@@ -117,6 +123,20 @@ static void monitor_qmp_init(Object *obj)
     json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
 }
 
+static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict)
+{
+    MonitorQMP *qmp = MONITOR_QMP(mon);
+
+    WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
+        if (qmp->commands == &qmp_cap_negotiation_commands) {
+            return;
+        }
+    }
+
+    qmp_send_response(qmp, qdict);
+}
+
+
 static bool qmp_oob_enabled(MonitorQMP *mon)
 {
     return mon->capab[QMP_CAPABILITY_OOB];
-- 
2.54.0


