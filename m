Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492CDC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmwOc-00041X-6C; Wed, 20 Mar 2024 09:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rmwOa-00041L-Rg
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rmwOZ-0000AO-Bu
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710942858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LS1W3pnEANMqrFyxGYWHsBrgCl9/zTnLL3xr58UeMCk=;
 b=Krmie0KBFsxEk9LqCRDYVe2FyG53fQdbwnOZbusr7hXlRAeh25VRKGjbIhw88sZNKK4n5K
 2/MR+cx4cwAPx2rqxeNmJ1MV6lb/EBD5xgm08umCj+pVv5GGqDQDmceJscI1htqlxOvEWD
 mwDnPLricj/6VZMXECZDufKqcxTApCk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-XWfW41nLP-28htymPsncMg-1; Wed,
 20 Mar 2024 09:54:14 -0400
X-MC-Unique: XWfW41nLP-28htymPsncMg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34D5338157A0;
 Wed, 20 Mar 2024 13:54:14 +0000 (UTC)
Received: from localhost (unknown [10.39.208.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5651A492BCA;
 Wed, 20 Mar 2024 13:54:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/5] ui/vnc: Do not use console_select()
Date: Wed, 20 Mar 2024 17:53:46 +0400
Message-ID: <20240320135349.2139402-3-marcandre.lureau@redhat.com>
In-Reply-To: <20240320135349.2139402-1-marcandre.lureau@redhat.com>
References: <20240320135349.2139402-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Akihiko Odaki <akihiko.odaki@daynix.com>

console_select() is shared by other displays and a console_select() call
from one of them triggers console switching also in ui/curses,
circumventing key state reinitialization that needs to be performed in
preparation and resulting in stuck keys.

Use its internal state to track the current active console to prevent
such a surprise console switch.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20240319-console-v2-2-3fd6feef321a@daynix.com>
---
 include/ui/console.h   |  1 +
 include/ui/kbd-state.h | 11 +++++++++++
 ui/console.c           | 12 ++++++++++++
 ui/kbd-state.c         |  6 ++++++
 ui/vnc.c               | 14 +++++++++-----
 5 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a4a49ffc64..3729d2db29 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -413,6 +413,7 @@ void qemu_console_early_init(void);
 
 void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx *ctx);
 
+QemuConsole *qemu_console_lookup_default(void);
 QemuConsole *qemu_console_lookup_by_index(unsigned int index);
 QemuConsole *qemu_console_lookup_by_device(DeviceState *dev, uint32_t head);
 QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
index fb79776128..1f37b932eb 100644
--- a/include/ui/kbd-state.h
+++ b/include/ui/kbd-state.h
@@ -99,4 +99,15 @@ bool qkbd_state_modifier_get(QKbdState *kbd, QKbdModifier mod);
  */
 void qkbd_state_lift_all_keys(QKbdState *kbd);
 
+/**
+ * qkbd_state_switch_console: Switch console.
+ *
+ * This sends key up events to the previous console for all keys which are in
+ * down state to prevent keys being stuck, and remembers the new console.
+ *
+ * @kbd: state tracker state.
+ * @con: new QemuConsole for this state tracker.
+ */
+void qkbd_state_switch_console(QKbdState *kbd, QemuConsole *con);
+
 #endif /* QEMU_UI_KBD_STATE_H */
diff --git a/ui/console.c b/ui/console.c
index 832055675c..fbc1b9b8b5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1325,6 +1325,18 @@ void graphic_console_close(QemuConsole *con)
     dpy_gfx_replace_surface(con, surface);
 }
 
+QemuConsole *qemu_console_lookup_default(void)
+{
+    QemuConsole *con;
+
+    QTAILQ_FOREACH(con, &consoles, next) {
+        if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
+            return con;
+        }
+    }
+    return QTAILQ_FIRST(&consoles);
+}
+
 QemuConsole *qemu_console_lookup_by_index(unsigned int index)
 {
     QemuConsole *con;
diff --git a/ui/kbd-state.c b/ui/kbd-state.c
index 62d42a7a22..52ed28b8a8 100644
--- a/ui/kbd-state.c
+++ b/ui/kbd-state.c
@@ -117,6 +117,12 @@ void qkbd_state_lift_all_keys(QKbdState *kbd)
     }
 }
 
+void qkbd_state_switch_console(QKbdState *kbd, QemuConsole *con)
+{
+    qkbd_state_lift_all_keys(kbd);
+    kbd->con = con;
+}
+
 void qkbd_state_set_delay(QKbdState *kbd, int delay_ms)
 {
     kbd->key_delay_ms = delay_ms;
diff --git a/ui/vnc.c b/ui/vnc.c
index fc12b343e2..b3fd78022b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1872,12 +1872,16 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
     /* QEMU console switch */
     switch (qcode) {
     case Q_KEY_CODE_1 ... Q_KEY_CODE_9: /* '1' to '9' keys */
-        if (vs->vd->dcl.con == NULL && down &&
+        if (down &&
             qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL) &&
             qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_ALT)) {
-            /* Reset the modifiers sent to the current console */
-            qkbd_state_lift_all_keys(vs->vd->kbd);
-            console_select(qcode - Q_KEY_CODE_1);
+            QemuConsole *con = qemu_console_lookup_by_index(qcode - Q_KEY_CODE_1);
+            if (con) {
+                unregister_displaychangelistener(&vs->vd->dcl);
+                qkbd_state_switch_console(vs->vd->kbd, con);
+                vs->vd->dcl.con = con;
+                register_displaychangelistener(&vs->vd->dcl);
+            }
             return;
         }
     default:
@@ -4206,7 +4210,7 @@ void vnc_display_open(const char *id, Error **errp)
             goto fail;
         }
     } else {
-        con = NULL;
+        con = qemu_console_lookup_default();
     }
 
     if (con != vd->dcl.con) {
-- 
2.44.0


