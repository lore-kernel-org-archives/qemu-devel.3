Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C68CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs7u-0006WF-72; Wed, 17 Jun 2026 11:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs7q-0006Nu-Ma
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs7o-0004FK-Kb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJdx+GtfmUcKvBPQfDHf1MyZNQjHOQ/gxnkpV/U7Zbg=;
 b=FntzOhCW+CxFijeQY9gU86wUk4nwyBPyBbv8p8bjq6Q1zGzjMOQF1lBT+KnlbFIq+2LlXx
 33NJBfw4GBc8GivNR0vJ8LPj0v9MSge5nQd3W8+/tOQO/VCGUqcYOz/+AtcaYLy8UbseaD
 MzC1Nse80XiXXkv5PIMUiI17yCN+7zI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-1HQ2aOudPCuv9i_P5SDl0A-1; Wed,
 17 Jun 2026 11:24:17 -0400
X-MC-Unique: 1HQ2aOudPCuv9i_P5SDl0A-1
X-Mimecast-MFC-AGG-ID: 1HQ2aOudPCuv9i_P5SDl0A_1781709856
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9D6A1956068
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:24:16 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD2A81955BC2; Wed, 17 Jun 2026 15:24:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:06 +0400
Subject: [GIT PULL 09/27] ui/input: add LED state tracking to
 QemuInputHandlerState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-9-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5509;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LS0IYMR3aKAli1KvYahR8dddvg0ZlI8Myzv0qOA2FHk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvoHtwQVWISk4AffCgvU8DGSDtRF2SR/5FGf
 nQbKpG10rOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76AAKCRDa6OEJdZac
 5eBLEAC67s9GgF3X/lOc//vGnAsQQqXlchIW1Pc6NWq9WlZfRaI52KOS/DdzAjURkJFhzBqvQzf
 eqxGogv9dRIDBlD1+2rbHQz0ED4jvw4BLiXMyI40Q07PtarNz8HujehhcG8ATezLoEpumJIg1tU
 smRYVe9nFlCvjGpkK3+zLH3Uy74DO7IhmVqVRCoecjI8qir+elu7TQWj2tK+pNQDTRls0UUWO1t
 mj820upmg+tkfLBB2R4+2tFdhcsnWgwZKsZFn4j2ETj2yFhIhnQMvXk+Fpr6UYl+lVDuuQ9r61I
 ncX6GE6mF0qSL/hpzSjD3GANCwKEPtZiyvUvjRlSk7vxY6yzNwXyeasjuW5+kUv1DIOla/B9lVN
 Md2rTsu5MZy3Ur8JZn7ftzmkeZwsGMND/3evIJ6oKHwIJz4TEn+MMOS3cqVQ4lpnvpDggf0O3QC
 iq600gCMPcVY9XDB3pCCxYXjGyB+jMSOkYBLpWjlQxHQMDCBYtmzDVWbzOzqU/9N7wIKWBFmMZz
 grnegJUAoiLuLctL2tEez0txPMMUTb8rQdiPcMlrw4UOI6KU+hb7vS/Mmavz3vQCpm2X/D2hXSk
 CTKVNPkB7nulvUDcK+5es7CQapTOYWYW4vvKJZ9jYdeByvHaJ1BxI6JZabtQ9+XzzQDBsZpXjOX
 KLHQwbsPpdFCEig==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Add per-handler LED state and a NotifierList for UI backends to
subscribe to LED changes.

Devices call qemu_input_handler_set_led() to store their LED state and
notify backends. Notify also on focus change, or list update.

Note: I considered conflating mouse-mode & led-state changes, but those
are quite different events (from different source kinds etc) and we may
want to improve the internal implementation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/input.h | 11 +++++++++++
 ui/input.c         | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 6df8ae3a8a3..11146c92bd4 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -151,4 +151,15 @@ extern const guint16 qemu_input_map_xorgxwin_to_linux[];
 extern const guint qemu_input_map_osx_to_linux_len;
 extern const guint16 qemu_input_map_osx_to_linux[];
 
+/**
+ * qemu_input_get_leds_mask() - get the LED mask for the given console
+ * @con: a QemuConsole or NULL
+ *
+ * If @con is NULL, returns the LED state mask for the default console.
+ */
+uint32_t qemu_input_get_leds_mask(const QemuConsole *con);
+void qemu_input_handler_set_leds_mask(QemuInputHandlerState *s, uint32_t leds_mask);
+void qemu_input_led_notifier_add(Notifier *n);
+void qemu_input_led_notifier_remove(Notifier *n);
+
 #endif /* INPUT_H */
diff --git a/ui/input.c b/ui/input.c
index 15affeabf44..3e362c05787 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -14,6 +14,7 @@ struct QemuInputHandlerState {
     int               id;
     int               events;
     QemuConsole       *con;
+    uint32_t          leds_mask;
     QTAILQ_ENTRY(QemuInputHandlerState) node;
 };
 
@@ -38,6 +39,8 @@ static QTAILQ_HEAD(, QemuInputHandlerState) handlers =
     QTAILQ_HEAD_INITIALIZER(handlers);
 static NotifierList mouse_mode_notifiers =
     NOTIFIER_LIST_INITIALIZER(mouse_mode_notifiers);
+static NotifierList leds_notifiers =
+    NOTIFIER_LIST_INITIALIZER(leds_notifiers);
 
 static QemuInputEventQueueHead kbd_queue = QTAILQ_HEAD_INITIALIZER(kbd_queue);
 static QEMUTimer *kbd_timer;
@@ -45,6 +48,14 @@ static uint32_t kbd_default_delay_ms = 10;
 static uint32_t queue_count;
 static uint32_t queue_limit = 1024;
 
+static void notify_input_changed(uint32_t mask)
+{
+    notifier_list_notify(&mouse_mode_notifiers, NULL);
+    if (mask & INPUT_EVENT_MASK_KEY) {
+        notifier_list_notify(&leds_notifiers, NULL);
+    }
+}
+
 QemuInputHandlerState *qemu_input_handler_register(DeviceState *dev,
                                             const QemuInputHandler *handler)
 {
@@ -55,8 +66,8 @@ QemuInputHandlerState *qemu_input_handler_register(DeviceState *dev,
     s->handler = handler;
     s->id = id++;
     QTAILQ_INSERT_TAIL(&handlers, s, node);
+    notify_input_changed(handler->mask);
 
-    notifier_list_notify(&mouse_mode_notifiers, NULL);
     return s;
 }
 
@@ -64,21 +75,23 @@ void qemu_input_handler_activate(QemuInputHandlerState *s)
 {
     QTAILQ_REMOVE(&handlers, s, node);
     QTAILQ_INSERT_HEAD(&handlers, s, node);
-    notifier_list_notify(&mouse_mode_notifiers, NULL);
+    notify_input_changed(s->handler->mask);
 }
 
 void qemu_input_handler_deactivate(QemuInputHandlerState *s)
 {
     QTAILQ_REMOVE(&handlers, s, node);
     QTAILQ_INSERT_TAIL(&handlers, s, node);
-    notifier_list_notify(&mouse_mode_notifiers, NULL);
+    notify_input_changed(s->handler->mask);
 }
 
 void qemu_input_handler_unregister(QemuInputHandlerState *s)
 {
+    uint32_t mask = s->handler->mask;
+
     QTAILQ_REMOVE(&handlers, s, node);
     g_free(s);
-    notifier_list_notify(&mouse_mode_notifiers, NULL);
+    notify_input_changed(mask);
 }
 
 void qemu_input_handler_bind(QemuInputHandlerState *s,
@@ -98,7 +111,7 @@ void qemu_input_handler_bind(QemuInputHandlerState *s,
 }
 
 static QemuInputHandlerState*
-qemu_input_find_handler(uint32_t mask, QemuConsole *con)
+qemu_input_find_handler(uint32_t mask, const QemuConsole *con)
 {
     QemuInputHandlerState *s;
 
@@ -122,6 +135,23 @@ qemu_input_find_handler(uint32_t mask, QemuConsole *con)
     return NULL;
 }
 
+void qemu_input_handler_set_leds_mask(QemuInputHandlerState *s, uint32_t leds_mask)
+{
+    assert(s->handler->mask & INPUT_EVENT_MASK_KEY);
+    s->leds_mask = leds_mask;
+    notifier_list_notify(&leds_notifiers, NULL);
+}
+
+void qemu_input_led_notifier_add(Notifier *n)
+{
+    notifier_list_add(&leds_notifiers, n);
+}
+
+void qemu_input_led_notifier_remove(Notifier *n)
+{
+    notifier_remove(n);
+}
+
 void qmp_input_send_event(const char *device,
                           bool has_head, int64_t head,
                           InputEventList *events, Error **errp)
@@ -445,6 +475,17 @@ bool qemu_input_is_absolute(QemuConsole *con)
     return (s != NULL) && (s->handler->mask & INPUT_EVENT_MASK_ABS);
 }
 
+uint32_t qemu_input_get_leds_mask(const QemuConsole *con)
+{
+    QemuInputHandlerState *s;
+
+    s = qemu_input_find_handler(INPUT_EVENT_MASK_KEY, con);
+    if (s) {
+        return s->leds_mask;
+    }
+    return 0;
+}
+
 int qemu_input_scale_axis(int value,
                           int min_in, int max_in,
                           int min_out, int max_out)

-- 
2.54.0


