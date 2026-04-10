Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C9DF45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHPn-0006TS-Cy; Fri, 10 Apr 2026 15:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPY-0005Qx-1W
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPV-0001YU-Ui
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJtPVEml1iOK2+K7tckw0IWuMjNfHvInu91vVbDRD40=;
 b=IJMjoJxMZZMM9xI/77POhJkmO1MiHAsBxL/riCiQEgsVP4LnJP8ekDkOolD3hiOhJd8lci
 u+zC2oIjU7Q4lZMsULAxWU4TIqhi0r34UxQHoAOfwaQ5hSIAiOcdWMFdBgqNewcIlXnr9T
 Q8N+DpPy7NkHw/mTfV6Fok8sGeqrAiM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-EIFxwp4OP1GJH1JKv9NcDg-1; Fri,
 10 Apr 2026 15:20:56 -0400
X-MC-Unique: EIFxwp4OP1GJH1JKv9NcDg-1
X-Mimecast-MFC-AGG-ID: EIFxwp4OP1GJH1JKv9NcDg_1775848855
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D8DA195608D
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:20:55 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BA913000C16; Fri, 10 Apr 2026 19:20:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:42 +0400
Subject: [PATCH v2 20/67] ui/console-vc: move cursor blinking logic into
 VT100 layer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-20-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5150;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=THg3kb3eky9MQNSqzzOIG7g/WozpZqAHz7OdHuv3imo=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGnZTRSix9Nz3xQgMaMgO+PKBvxcrO7zsLK3O1s5aVYSstfyB
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJp2U0UAAoJENro4Ql1lpzl7joP/jCu
 aJXbvew5GD+IMbRIrXTLZnImIhQgFaEMzci/Erq7eopbI0VqPZAyfJmO41ZR0n1MSe58pQC/ujj
 VEWepK6foHCrpPQ8g/AXAeFB5BZT8b9z1ll8SBvLYwMw1h1T/Y6QgPPon2z/uhdvrBqfIFySzf2
 OQutk/tqETjJ8KdC9PJ8L5rHEDXQvRaCTVkTvGPP/bgfe56sMp/u7AiIoo/qJZf0LtnYkMla9o2
 ZK/rcUdIgaHrGWWHEoHQ3Kcc6g/8OfpyN183Rr8xT2Zbq/89ZDKIntLpMskiFCZwsrUiOCU/r8x
 S420v0yNm3TqjGe/EepNJ3WjYLemgP90k/4QSlRw+mlmDC7i/Ps5v8oPIp9g+Q6wyq0ysDz5H//
 iwraXfz9cS9QragNShIhYZv1lpus8zKoUhCXDAofwdMwpQ70kDBya4FncWdH8Se2FDWSuI139Y8
 rII3BxKxQIsWzU0xw8Ecso2MwSpbDxYgougncF0WiSUM40gJsUEBm+9zhse+QBGWqEq59DbOMK4
 9QmoVgUjhqwjkzMRgotD5wSSl/qHOmNH4euQF4gampQFsPuAlN0H33mr5MqN7yNjOUOGvPDVoLs
 ooo+JPK8PwsT+pZXY6k9cWddOwo1yTXjZSucnqcGowXbNyAfJu7d5gj1r5+rjIX0JlZivf+FnOX
 XTij5
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Maintain a list of QemuVT100 instances so the cursor timer can directly
iterate over them and call vt100_refresh(), instead of going through
qemu_invalidate_text_consoles() which iterated over all consoles
(including graphic ones) and called back into the generic display layer.

This removes the qemu_invalidate_text_consoles() function from
console.c, further decoupling VT100 text rendering from the console
core.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h  |  1 -
 ui/console-priv.h     |  2 +-
 ui/console-vc-stubs.c |  2 +-
 ui/console-vc.c       | 28 +++++++++++++++++++++++-----
 ui/console.c          | 19 +------------------
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 395a723e318..5b5bba46ec2 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -416,7 +416,6 @@ void qemu_console_set_window_id(QemuConsole *con, int window_id);
 void qemu_console_resize(QemuConsole *con, int width, int height);
 DisplaySurface *qemu_console_surface(QemuConsole *con);
 void coroutine_fn qemu_console_co_wait_update(QemuConsole *con);
-int qemu_invalidate_text_consoles(void);
 
 /* console-gl.c */
 #ifdef CONFIG_OPENGL
diff --git a/ui/console-priv.h b/ui/console-priv.h
index 2c2cfd99570..8bcdb79d914 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -36,7 +36,7 @@ struct QemuConsole {
 };
 
 void qemu_text_console_update_size(QemuTextConsole *c);
-void qemu_text_console_update_cursor(void);
+void vt100_update_cursor(void);
 void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym);
 
 #endif
diff --git a/ui/console-vc-stubs.c b/ui/console-vc-stubs.c
index 8a7f19c1f44..d911a82f263 100644
--- a/ui/console-vc-stubs.c
+++ b/ui/console-vc-stubs.c
@@ -14,7 +14,7 @@ void qemu_text_console_update_size(QemuTextConsole *c)
 {
 }
 
-void qemu_text_console_update_cursor(void)
+void vt100_update_cursor(void)
 {
 }
 
diff --git a/ui/console-vc.c b/ui/console-vc.c
index d46dcb6a678..6694c5082f8 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -8,6 +8,7 @@
 #include "qapi/error.h"
 #include "qemu/fifo8.h"
 #include "qemu/option.h"
+#include "qemu/queue.h"
 #include "ui/console.h"
 #include "ui/cp437.h"
 
@@ -69,8 +70,13 @@ struct QemuVT100 {
     int update_y0;
     int update_x1;
     int update_y1;
+
+    QTAILQ_ENTRY(QemuVT100) list;
 };
 
+static QTAILQ_HEAD(QemuVT100Head, QemuVT100) vt100s =
+    QTAILQ_HEAD_INITIALIZER(vt100s);
+
 typedef struct QemuTextConsole {
     QemuConsole parent;
 
@@ -1103,20 +1109,28 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return len;
 }
 
-void qemu_text_console_update_cursor(void)
+void vt100_update_cursor(void)
 {
+    QemuVT100 *vt;
+
     cursor_visible_phase = !cursor_visible_phase;
 
-    if (qemu_invalidate_text_consoles()) {
-        timer_mod(cursor_timer,
-                  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + CONSOLE_CURSOR_PERIOD / 2);
+    if (QTAILQ_EMPTY(&vt100s)) {
+        return;
+    }
+
+    QTAILQ_FOREACH(vt, &vt100s, list) {
+        vt100_refresh(vt);
     }
+
+    timer_mod(cursor_timer,
+        qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + CONSOLE_CURSOR_PERIOD / 2);
 }
 
 static void
 cursor_timer_cb(void *opaque)
 {
-    qemu_text_console_update_cursor();
+    vt100_update_cursor();
 }
 
 static void text_console_invalidate(void *opaque)
@@ -1132,6 +1146,9 @@ static void text_console_invalidate(void *opaque)
 static void
 qemu_text_console_finalize(Object *obj)
 {
+    QemuTextConsole *s = QEMU_TEXT_CONSOLE(obj);
+
+    QTAILQ_REMOVE(&vt100s, &s->vt, list);
 }
 
 static void
@@ -1156,6 +1173,7 @@ qemu_text_console_init(Object *obj)
 {
     QemuTextConsole *c = QEMU_TEXT_CONSOLE(obj);
 
+    QTAILQ_INSERT_HEAD(&vt100s, &c->vt, list);
     fifo8_create(&c->out_fifo, 16);
     c->vt.total_height = DEFAULT_BACKSCROLL;
     QEMU_CONSOLE(c)->hw_ops = &text_console_ops;
diff --git a/ui/console.c b/ui/console.c
index 24e4761e1f9..8af1dee0e22 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -752,7 +752,7 @@ void register_displaychangelistener(DisplayChangeListener *dcl)
     } else if (QEMU_IS_TEXT_CONSOLE(dcl->con)) {
         qemu_text_console_update_size(QEMU_TEXT_CONSOLE(dcl->con));
     }
-    qemu_text_console_update_cursor();
+    vt100_update_cursor();
 }
 
 void update_displaychangelistener(DisplayChangeListener *dcl,
@@ -1457,23 +1457,6 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
     }
 }
 
-int qemu_invalidate_text_consoles(void)
-{
-    QemuConsole *s;
-    int count = 0;
-
-    QTAILQ_FOREACH(s, &consoles, next) {
-        if (qemu_console_is_graphic(s) ||
-            !qemu_console_is_visible(s)) {
-            continue;
-        }
-        count++;
-        graphic_hw_invalidate(s);
-    }
-
-    return count;
-}
-
 void qemu_console_resize(QemuConsole *s, int width, int height)
 {
     DisplaySurface *surface = qemu_console_surface(s);

-- 
2.53.0


