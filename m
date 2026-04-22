Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8E1F9B612
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV2U-0006fo-9O; Wed, 22 Apr 2026 06:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV2N-000676-2W
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV2J-0002bi-8T
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdPo0VF+rmFefq/Qp3UuNmLrEm9l8ULREvMW1s7C/OA=;
 b=K7ciPqBQSdXMU62nubXAI0FxHH+Sa5+xkMKwYVOh9A2VYw4J2R30Wk/DQB5TqXAGln324C
 r0yz2XnYFbmHkvNQJ5wYzZ2ECZnIVmH82gsesaT3SvBrWEsG//BKOLpnVBoUmQXlpJ++zM
 oPsELxWNJO0DM9oKUMLBtDJWTNSJT7c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-Sj7Vx2BCMfiB3pFDpd-V2w-1; Wed,
 22 Apr 2026 06:42:22 -0400
X-MC-Unique: Sj7Vx2BCMfiB3pFDpd-V2w-1
X-Mimecast-MFC-AGG-ID: Sj7Vx2BCMfiB3pFDpd-V2w_1776854541
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C89261956095; Wed, 22 Apr 2026 10:42:21 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5FAA919560AB; Wed, 22 Apr 2026 10:42:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 15/40] ui/console: dispatch get_label() through QOM virtual
 method
Date: Wed, 22 Apr 2026 14:40:16 +0400
Message-ID: <20260422104042.3936506-16-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Replace the type-checking chain in qemu_console_get_label() (using
QEMU_IS_GRAPHIC_CONSOLE/QEMU_IS_TEXT_CONSOLE) with a QemuConsoleClass
virtual method, allowing each console subclass to provide its own
get_label implementation.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h  |   2 +
 ui/console-priv.h     |   1 -
 ui/console-vc-stubs.c |   6 ---
 ui/console-vc.c       |  12 +++--
 ui/console.c          | 101 ++++++++++++++++++++++--------------------
 5 files changed, 65 insertions(+), 57 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 08082389f71..788ff103ada 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -129,6 +129,8 @@ void console_handle_touch_event(QemuConsole *con,
 
 struct QemuConsoleClass {
     ObjectClass parent_class;
+
+    char * (*get_label)(const QemuConsole *con);
 };
 
 typedef struct ScanoutTexture {
diff --git a/ui/console-priv.h b/ui/console-priv.h
index 43ceb8122f1..2c2cfd99570 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -36,7 +36,6 @@ struct QemuConsole {
 };
 
 void qemu_text_console_update_size(QemuTextConsole *c);
-const char * qemu_text_console_get_label(QemuTextConsole *c);
 void qemu_text_console_update_cursor(void);
 void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym);
 
diff --git a/ui/console-vc-stubs.c b/ui/console-vc-stubs.c
index b63e2fb2345..8a7f19c1f44 100644
--- a/ui/console-vc-stubs.c
+++ b/ui/console-vc-stubs.c
@@ -14,12 +14,6 @@ void qemu_text_console_update_size(QemuTextConsole *c)
 {
 }
 
-const char *
-qemu_text_console_get_label(QemuTextConsole *c)
-{
-    return NULL;
-}
-
 void qemu_text_console_update_cursor(void)
 {
 }
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 0881a2148c1..ce35abaf402 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -122,10 +122,12 @@ static const pixman_color_t color_table_rgb[2][8] = {
 static bool cursor_visible_phase;
 static QEMUTimer *cursor_timer;
 
-const char *
-qemu_text_console_get_label(QemuTextConsole *c)
+static char *
+qemu_text_console_get_label(const QemuConsole *c)
 {
-    return c->chr ? c->chr->label : NULL;
+    QemuTextConsole *tc = QEMU_TEXT_CONSOLE(c);
+
+    return tc->chr ? g_strdup(tc->chr->label) : NULL;
 }
 
 static void qemu_console_fill_rect(QemuConsole *con, int posx, int posy,
@@ -1053,9 +1055,13 @@ qemu_text_console_finalize(Object *obj)
 static void
 qemu_text_console_class_init(ObjectClass *oc, const void *data)
 {
+    QemuConsoleClass *cc = QEMU_CONSOLE_CLASS(oc);
+
     if (!cursor_timer) {
         cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME, cursor_timer_cb, NULL);
     }
+
+    cc->get_label = qemu_text_console_get_label;
 }
 
 static const GraphicHwOps text_console_ops = {
diff --git a/ui/console.c b/ui/console.c
index f445db11389..beaef4ad8b8 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -436,9 +436,58 @@ qemu_graphic_console_prop_get_head(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &c->head, errp);
 }
 
+static bool
+qemu_graphic_console_is_multihead(QemuGraphicConsole *c)
+{
+    QemuConsole *con;
+
+    QTAILQ_FOREACH(con, &consoles, next) {
+        QemuGraphicConsole *candidate;
+
+        if (!QEMU_IS_GRAPHIC_CONSOLE(con)) {
+            continue;
+        }
+
+        candidate = QEMU_GRAPHIC_CONSOLE(con);
+        if (candidate->device != c->device) {
+            continue;
+        }
+
+        if (candidate->head != c->head) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static char *
+qemu_graphic_console_get_label(const QemuConsole *con)
+{
+    QemuGraphicConsole *c = QEMU_GRAPHIC_CONSOLE(con);
+
+    if (c->device) {
+        DeviceState *dev;
+        bool multihead;
+
+        dev = DEVICE(c->device);
+        multihead = qemu_graphic_console_is_multihead(c);
+        if (multihead) {
+            return g_strdup_printf("%s.%d", dev->id ?
+                                   dev->id :
+                                   object_get_typename(c->device),
+                                   c->head);
+        } else {
+            return g_strdup(dev->id ? : object_get_typename(c->device));
+        }
+    }
+    return g_strdup("VGA");
+}
+
 static void
 qemu_graphic_console_class_init(ObjectClass *oc, const void *data)
 {
+    QemuConsoleClass *cc = QEMU_CONSOLE_CLASS(oc);
+
     object_class_property_add_link(oc, "device", TYPE_DEVICE,
                                    offsetof(QemuGraphicConsole, device),
                                    object_property_allow_set_link,
@@ -446,6 +495,8 @@ qemu_graphic_console_class_init(ObjectClass *oc, const void *data)
     object_class_property_add(oc, "head", "uint32",
                               qemu_graphic_console_prop_get_head,
                               NULL, NULL, NULL);
+
+    cc->get_label = qemu_graphic_console_get_label;
 }
 
 static void
@@ -1347,56 +1398,12 @@ bool qemu_console_is_gl_blocked(QemuConsole *con)
     return con->gl_block;
 }
 
-static bool qemu_graphic_console_is_multihead(QemuGraphicConsole *c)
-{
-    QemuConsole *con;
-
-    QTAILQ_FOREACH(con, &consoles, next) {
-        QemuGraphicConsole *candidate;
-
-        if (!QEMU_IS_GRAPHIC_CONSOLE(con)) {
-            continue;
-        }
-
-        candidate = QEMU_GRAPHIC_CONSOLE(con);
-        if (candidate->device != c->device) {
-            continue;
-        }
-
-        if (candidate->head != c->head) {
-            return true;
-        }
-    }
-    return false;
-}
-
 char *qemu_console_get_label(QemuConsole *con)
 {
-    if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
-        QemuGraphicConsole *c = QEMU_GRAPHIC_CONSOLE(con);
-        if (c->device) {
-            DeviceState *dev;
-            bool multihead;
-
-            dev = DEVICE(c->device);
-            multihead = qemu_graphic_console_is_multihead(c);
-            if (multihead) {
-                return g_strdup_printf("%s.%d", dev->id ?
-                                       dev->id :
-                                       object_get_typename(c->device),
-                                       c->head);
-            } else {
-                return g_strdup(dev->id ? : object_get_typename(c->device));
-            }
-        }
-        return g_strdup("VGA");
-    } else if (QEMU_IS_TEXT_CONSOLE(con)) {
-        const char *label = qemu_text_console_get_label(QEMU_TEXT_CONSOLE(con));
-        if (label) {
-            return g_strdup(label);
-        }
+    char *label = QEMU_CONSOLE_GET_CLASS(con)->get_label(con);
+    if (label) {
+        return label;
     }
-
     return g_strdup_printf("vc%d", con->index);
 }
 
-- 
2.53.0


