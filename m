Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37579CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs8v-0002IG-5i; Wed, 17 Jun 2026 11:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8s-0001sX-3T
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8q-0004r4-3g
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0TufrWfNIzpsF2XRxjhb3IdpfDE1YSIkCHruo6etDk=;
 b=bt3ZfnHMCu8KLhlfZNDkJttd+YPs+/fIwArqwXRL87UAQDSH0tK69/TnG+t7nI1VjvZTI3
 KMHDlcCIUIolK7Xo7UWkr+rY5S4WQMDLJXYEgNwwfMfCBqeklZgRVSz6Kfcs0BlbF3DNe1
 9doDqyZaeWx5OYgVOwJ6QY+ZXVxluUs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-gw3dmBxPMkuK_T-v5cqFRg-1; Wed,
 17 Jun 2026 11:25:21 -0400
X-MC-Unique: gw3dmBxPMkuK_T-v5cqFRg-1
X-Mimecast-MFC-AGG-ID: gw3dmBxPMkuK_T-v5cqFRg_1781709920
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B712180130E
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:25:20 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AE2C18005B6; Wed, 17 Jun 2026 15:25:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:18 +0400
Subject: [GIT PULL 21/27] ui/dbus: switch LED handling to Notifier-based
 input API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-21-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2308;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6qtFXRNmxVwlC4tujuJ/AUY20kPa48OekN0GxXj/0F8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpiTdLRJiqMZp/+GlZku9kI8vd4kRH7r9Cx
 drPgDvh9iWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5UTgD/9rOQVaUt07uNAEDNS9x0/vwPkkzqKSnbiKjKqGUuzdJsbh12Y/OuS90bXTzNIsHLpJitp
 GrieYo4LlJXrl0X5u7sVn6HbIfSP/BLAKWpR5vyAWfuf3H2H7LLdVmq7ESfx2q4UgsYSBuOiJmx
 o4s6NMzPr4Qv6bJp9FqhJQtTY5EVq6NuS5sxVUwJXjh5fHVXNNzfC7jm6OAH5u7rCFRNJUPqlfV
 Y558Yio2CqijXBl9Wo+HHc53wqF0uEHncTJ3qMifrkXszUHZFq4RDzGblAA8QTkZH2v5m+0fw8W
 QvmYFKJs9Nx3xOgVfBK+9+vTt4CfzNug1nqqh+vGiVlA5+DYGvyx2zRtHML8cUjIfxkTNbtCOxB
 7v2QprSxwwS5xCQwx5OfakjA2Fv5HOYNlepktUTHhtxeSafBnLlnObwrhfeHhT+SfaGWo2vNOvm
 f8S5pQtRHFfndTOuhDsrUZfujanX3WKuKsKqdz4XAXXTYcmu2X+OJg+T9kAeiQDt6+TtQfSPPzw
 v+VZsgJdHJ9kxXhe4QU3GH2UHyflJI3ycV5LYdnq+4G9hDGFqHyfQQ22/t0j44i35E9ayDiYwKM
 MIH1J1GsmAi6yfpT7p4431qWD70VLv7F88tY0ZSQ6XCxlYfT5535bgRH96bD7vWAKbb3W0Up2q5
 8YEunzzirbMQwQQ==
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-console.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 21eceb24362..9e154da1eca 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -27,6 +27,7 @@
 #include "ui/input.h"
 #include "ui/kbd-state.h"
 #include "trace.h"
+#include <stdint.h>
 
 #ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
@@ -46,6 +47,7 @@ struct _DBusDisplayConsole {
 
     QemuDBusDisplay1Keyboard *iface_kbd;
     QKbdState *kbd;
+    Notifier led_notifier;
 
     QemuDBusDisplay1Mouse *iface_mouse;
     QemuDBusDisplay1MultiTouch *iface_touch;
@@ -150,6 +152,7 @@ dbus_display_console_dispose(GObject *object)
 {
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
+    qemu_input_led_notifier_remove(&ddc->led_notifier);
     qemu_console_unregister_listener(&ddc->dcl);
     g_clear_object(&ddc->iface_touch);
     g_clear_object(&ddc->iface_mouse);
@@ -367,11 +370,13 @@ dbus_kbd_release(DBusDisplayConsole *ddc,
 }
 
 static void
-dbus_kbd_qemu_leds_updated(void *data, int ledstate)
+dbus_kbd_qemu_leds_updated(Notifier *notifier, void *data)
 {
-    DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(data);
+    DBusDisplayConsole *ddc = container_of(notifier, DBusDisplayConsole,
+                                           led_notifier);
+    uint32_t leds_mask = qemu_input_get_leds_mask(ddc->dcl.con);
 
-    qemu_dbus_display1_keyboard_set_modifiers(ddc->iface_kbd, ledstate);
+    qemu_dbus_display1_keyboard_set_modifiers(ddc->iface_kbd, leds_mask);
 }
 
 static gboolean
@@ -577,7 +582,8 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
 
     ddc->kbd = qkbd_state_init(con);
     ddc->iface_kbd = qemu_dbus_display1_keyboard_skeleton_new();
-    qemu_add_led_event_handler(dbus_kbd_qemu_leds_updated, ddc);
+    ddc->led_notifier.notify = dbus_kbd_qemu_leds_updated;
+    qemu_input_led_notifier_add(&ddc->led_notifier);
     g_object_connect(ddc->iface_kbd,
         "swapped-signal::handle-press", dbus_kbd_press, ddc,
         "swapped-signal::handle-release", dbus_kbd_release, ddc,

-- 
2.54.0


