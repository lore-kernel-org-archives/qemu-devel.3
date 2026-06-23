Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4E1CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbxtN-0000U5-7z; Tue, 23 Jun 2026 05:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbxtL-0000LB-C8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbxtJ-0003nj-4B
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782208680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lgb4rSfAZLz/aNf+5eG6humki6zdAtFbfFov9RCL7k0=;
 b=XSGMFhTKaeeAOXvpVJMx6iqS7SU/nlfnwGV0ixoh0JAnJQ9lYTcIQ3LAVBgudLGDYfyw8N
 cRPHvtG5EYmUTdQyJFuHi0oNZOMI0FVcEVUSy4YWNrpqyzNRMi47QQGigG2+YVHwcIN9yl
 yV6kptasLmQRLC0ORnfOpHgHjQ4y7lQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-gOOyAjBqOy6ljQmtbioh8A-1; Tue,
 23 Jun 2026 05:57:55 -0400
X-MC-Unique: gOOyAjBqOy6ljQmtbioh8A-1
X-Mimecast-MFC-AGG-ID: gOOyAjBqOy6ljQmtbioh8A_1782208672
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6C721801BE8; Tue, 23 Jun 2026 09:57:52 +0000 (UTC)
Received: from berrange.com (unknown [10.44.34.133])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B209DD6E; Tue, 23 Jun 2026 09:57:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 32/35] monitor: add support for auto-deleting monitors upon
 close
Date: Tue, 23 Jun 2026 10:55:48 +0100
Message-ID: <20260623095551.2106712-33-berrange@redhat.com>
In-Reply-To: <20260623095551.2106712-1-berrange@redhat.com>
References: <20260623095551.2106712-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The default monitor is usually a long lived object that will exist for
the entire lifetime of the VM. A monitor can only service a single
client at a time though, and so it might be desirable to hotplug
additional monitors at runtime for specific tasks. If doing that,
however, there is a need to remove the monitor when it is no longer
needed.

Allowing a client to run "object-del" against its own monitor adds
complex edge cases, as it would be desirable to send the QMP response
despite the monitor sending it being deleted. Doing "object-del" alone
will also result in orphaning a character device backend instance, as
there is no opportunity to run the companion "chardev-del" command.

A simpler way to ensure cleanup is to add the concept of auto-deleting
monitor objects. Specifically when the "CHR_EVENT_CLOSED" event is
emitted, the equivalent of "object-del" + "chardev-del" can be run
internally. Since the transient client has already droppped its
monitor connection, there is no synchronization to be concerned about.

This is implemented via a new "close-action=none|delete" property on
the 'monitor-qmp' object. This concept could be extended with further
actions in future, for example:

 * close-action=shutdown - graceful guest shutdown
 * close-action=terminate - immediate guest poweroff
 * close-action=stop - pause guest CPUs while the monitor is not
                       connected to any client

This is left as an exercise for future interested contributors.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor-internal.h                    |  3 +
 monitor/qmp.c                                 | 68 +++++++++++++++++++
 qapi/qom.json                                 | 21 +++++-
 .../generic/test_monitor_hotplug.py           | 55 +++++++++++++--
 4 files changed, 142 insertions(+), 5 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 5522e05464..23829f32f9 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -28,6 +28,7 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-types-control.h"
+#include "qapi/qapi-types-qom.h"
 #include "qapi/qmp-registry.h"
 #include "qobject/json-parser.h"
 #include "qemu/readline.h"
@@ -178,7 +179,9 @@ struct MonitorQMP {
     Monitor parent_obj;
     JSONMessageParser parser;
     bool pretty;
+    MonitorQMPCloseAction close_action;
     bool setup_pending; /* iothread BH has not yet set up chardev handlers */
+    bool delete_pending; /* close_action has started 'delete' process */
     /*
      * When a client connects, we're in capabilities negotiation mode.
      * @commands is &qmp_cap_negotiation_commands then.  When command
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 5301927f09..f6b7fe65bb 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -28,6 +28,7 @@
 #include "monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
+#include "qapi/qapi-commands-char.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
@@ -103,6 +104,20 @@ static void monitor_qmp_set_pretty(Object *obj, bool val, Error **errp)
     mon->pretty = val;
 }
 
+static int monitor_qmp_get_close_action(Object *obj, Error **errp)
+{
+    MonitorQMP *mon = MONITOR_QMP(obj);
+
+    return mon->close_action;
+}
+
+static void monitor_qmp_set_close_action(Object *obj, int val, Error **errp)
+{
+    MonitorQMP *mon = MONITOR_QMP(obj);
+
+    mon->close_action = val;
+}
+
 static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict);
 static bool monitor_qmp_requires_iothread(const Monitor *mon);
 static void monitor_qmp_complete(UserCreatable *uc, Error **errp);
@@ -117,6 +132,11 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
     object_class_property_add_bool(cls, "pretty",
                                    monitor_qmp_get_pretty,
                                    monitor_qmp_set_pretty);
+    object_class_property_add_enum(cls, "close-action",
+                                   "MonitorQMPCloseAction",
+                                   &MonitorQMPCloseAction_lookup,
+                                   monitor_qmp_get_close_action,
+                                   monitor_qmp_set_close_action);
 
     moncls->emit_event = monitor_qmp_emit_event;
     moncls->requires_iothread = monitor_qmp_requires_iothread;
@@ -550,11 +570,38 @@ static QDict *qmp_greeting(MonitorQMP *mon)
         ver, cap_list);
 }
 
+static void monitor_qmp_self_delete_bh(void *opaque)
+{
+    MonitorQMP *mon = opaque;
+    g_autofree char *mon_id = object_property_get_child_name(
+        object_get_objects_root(), OBJECT(mon));
+    g_autofree char *chardev_id = g_strdup(mon->parent_obj.chardev_id);
+    Error *local_error = NULL;
+
+    g_assert(mon_id);
+
+    user_creatable_del(mon_id, &local_error);
+    object_unref(mon);
+    if (local_error != NULL) {
+        error_report_err(local_error);
+    } else {
+        qmp_chardev_remove(chardev_id, NULL);
+    }
+}
+
 static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
 {
     QDict *data;
     MonitorQMP *mon = opaque;
 
+    /* Protect against race if a client drops & quickly
+     * reconnects - we'll have the delete BH scheduled
+     * so must not honour a new open request
+     */
+    if (mon->delete_pending) {
+        return;
+    }
+
     switch (event) {
     case CHR_EVENT_OPENED:
         WITH_QEMU_LOCK_GUARD(&mon->parent_obj.mon_lock) {
@@ -566,6 +613,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
         qobject_unref(data);
         break;
     case CHR_EVENT_CLOSED:
+        mon->delete_pending = true;
         /*
          * Note: this is only useful when the output of the chardev
          * backend is still open.  For example, when the backend is
@@ -577,6 +625,26 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
         json_message_parser_init(&mon->parser, handle_qmp_command,
                                  mon, NULL);
         monitor_fdsets_cleanup();
+        switch (mon->close_action) {
+        case MONITOR_QMP_CLOSE_ACTION_NONE:
+            break; /* nada */
+        case MONITOR_QMP_CLOSE_ACTION_DELETE:
+            /*
+             * Do NOT run in the AIO context associated with the
+             * monitor. We need to run in the default AIO context
+             * which is the same context in which 'qmp_object_del'
+             * will execute
+             *
+             * Hold an extra ref in case a separate monitor races
+             * with the BH by processing an expliciti 'object-del'
+             */
+            object_ref(mon);
+            aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                    monitor_qmp_self_delete_bh, mon);
+            break;
+        default:
+            g_assert_not_reached();
+        }
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/qapi/qom.json b/qapi/qom.json
index 6ed510858e..63335b8fd0 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1213,18 +1213,37 @@
   'base': 'MonitorProperties',
   'data': { '*readline': 'bool' } }
 
+
+##
+# @MonitorQMPCloseAction:
+#
+# Action to take when the character device backend is
+# closed.
+#
+# @none: take no action (the default)
+# @delete: delete both the 'monitor-qmp' object and its associated
+#          character device backend object
+#
+# Since 11.1
+##
+{ 'enum' : 'MonitorQMPCloseAction',
+  'data': ['none', 'delete'] }
+
 ##
 # @MonitorQMPProperties:
 #
 # Properties for the QMP monitor
 #
 # @pretty: whether to pretty print JSON responses (default: disabled)
+# @close-action: action to take when the character device backend
+#                is closed (default: none)
 #
 # Since: 11.1
 ##
 { 'struct': 'MonitorQMPProperties',
   'base': 'MonitorProperties',
-  'data': { '*pretty': 'bool' } }
+  'data': { '*pretty': 'bool',
+            '*close-action': 'MonitorQMPCloseAction' } }
 
 ##
 # @ObjectType:
diff --git a/tests/functional/generic/test_monitor_hotplug.py b/tests/functional/generic/test_monitor_hotplug.py
index 55af8a238f..f70aed814f 100755
--- a/tests/functional/generic/test_monitor_hotplug.py
+++ b/tests/functional/generic/test_monitor_hotplug.py
@@ -25,7 +25,7 @@ def setUp(self):
         sock_dir = self.socket_dir()
         self._sock_path = os.path.join(sock_dir.name, 'hotplug.sock')
 
-    def _add_monitor(self):
+    def _add_monitor(self, autodelete=False):
         """Create a chardev + monitor and return the socket path."""
         sock = self._sock_path
         self.vm.cmd('chardev-add', id='hotplug-chr', backend={
@@ -39,9 +39,15 @@ def _add_monitor(self):
                 'wait': False,
             }
         })
-        self.vm.cmd('object-add', id='hotplug-mon',
-                    qom_type='monitor-qmp',
-                    chardev='hotplug-chr')
+        if autodelete:
+            self.vm.cmd('object-add', id='hotplug-mon',
+                        qom_type='monitor-qmp',
+                        chardev='hotplug-chr',
+                        close_action='delete')
+        else:
+            self.vm.cmd('object-add', id='hotplug-mon',
+                        qom_type='monitor-qmp',
+                        chardev='hotplug-chr')
         return sock
 
     def _remove_monitor(self):
@@ -118,6 +124,47 @@ def test_self_removal(self):
         # Clean up the chardev
         self.vm.cmd('chardev-remove', id='hotplug-chr')
 
+    def test_auto_delete(self):
+        """
+        A dynamically-added monitor is configured with 'close-action=delete'
+        should see itself deleted when the client is closed.
+        """
+        self.set_machine('none')
+        self.vm.add_args('-nodefaults')
+        self.vm.launch()
+
+        sock = self._add_monitor(autodelete=True)
+
+        cdevs = [c["label"] for c in self.vm.cmd('query-chardev')]
+        objs = [o["name"] for o in self.vm.cmd('qom-list', path='/objects')]
+        assert ('hotplug-chr' in cdevs)
+        assert ('hotplug-mon' in objs)
+
+        qmp = QEMUMonitorProtocol(sock)
+        greeting = qmp.connect(negotiate=True)
+        self.assertIn('QMP', greeting)
+
+        cdevs = [c["label"] for c in self.vm.cmd('query-chardev')]
+        objs = [o["name"] for o in self.vm.cmd('qom-list', path='/objects')]
+        assert ('hotplug-chr' in cdevs)
+        assert ('hotplug-mon' in objs)
+
+        qmp.close()
+
+        # Wait upto 10 seconds max for chardev to auto-delete, which
+        # is hopefully enough for reliability under high load
+        for i in range(int(10 / 0.2)):
+            cdevs = [c["label"] for c in self.vm.cmd('query-chardev')]
+            if 'hotplug-chr' not in cdevs:
+                break
+            # Wait a little more then try again
+            time.sleep(0.2)
+
+        cdevs = [c["label"] for c in self.vm.cmd('query-chardev')]
+        objs = [o["name"] for o in self.vm.cmd('qom-list', path='/objects')]
+        assert ('hotplug-chr' not in cdevs)
+        assert ('hotplug-mon' not in objs)
+
     def test_large_response(self):
         """
         Send a command with a large response (query-qmp-schema) on a
-- 
2.54.0


