Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA9AF3381D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QEC-00065V-En; Tue, 17 Mar 2026 04:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCp-0003SX-EL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCk-000727-Ga
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cTW6lO9YRG5qaKR/kxc3Wtw+Ba3ssnDvxbOSDxQ4xuk=;
 b=CVQm2d5w+DA69qLD4aSmd2ycMV5OEGmiFG1v44s74aLyRiz+18FTYwqgHIp+0Has5C4xDp
 qFdP/Xbvfs7a9vKsYWvMopa6nezDCClPD/3j5UI1pn3199piYyW5Ae+wcR1fGzS8G5t3AV
 3QG+RH4Nn0myib/fdSWj8mZ6o9t2sq8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-Szj6poL8ODyqnV1ofPe7WA-1; Tue,
 17 Mar 2026 04:55:04 -0400
X-MC-Unique: Szj6poL8ODyqnV1ofPe7WA-1
X-Mimecast-MFC-AGG-ID: Szj6poL8ODyqnV1ofPe7WA_1773737703
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EEA119560BE
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:03 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 741531955F19
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:59 +0400
Subject: [PATCH 45/60] ui/vnc: fix vnc_display_init() leak on failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-45-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4072;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fR1oB8ljP4opnh/NW5I2x4OFCScpcbx3pOr/dxjVmz4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXcjRHo7MEYnxHrqbw0hm4zERRnl/cO2+dOX
 WgwC6hkHm6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5avlEACEuYtH+7P2K7+ZH4PpOyNeKXAefy2rboq4PpOuyB22xgPBL7XCb0ym+qAnrdDBH63MFsR
 HcqJruq+5qyN+DrorhQ1jP351/+u1kdO8KtjUwQDusGOKicH2wlvVB/QO59LHZ2AyAtr2cPsh/c
 RZcAnSUrpKxSm1uxsjrysWeO1QCNMa8WPNi6j5dPDbZl+OLZNNvapeqIi7qJKiPohG82EBr+0/m
 S58QhHrjllJnjV9ivQ62LY3W0Kl07Z4sTMt5YCnnsQXzqWOuSLZe+4GIY4w0NECOMddpfb3Xek4
 e9SOe9OpZCcWNME5FJoVcTMkeGKq9xVxOvXUkYn+auEPJUw2+8vVQxrjuv/AdzrdU581XkCUQj5
 TryDppn3wkxTbfGoWFQWbKQyTPB92tAWuGUAWre0U6Wp1eWo6pYTcnmbS7XWB4I3f1IOQMArpv3
 J28cfH5YUnIVSu6Yha99hiswkM6qu8u26B7rNmuc7DNmNq53/pxeTl1y864evNi6XralvoqFn6c
 vQGfU72BcVrGn60k+etIu56tCvXcw13DPt6ile/i7rdDYtqV8V4FYxJe5vuTY8cZ+2ahRINXrwe
 IowV8aSKLs4UmE2gH54z4MrjDEmQg7cGIjtLtUxCUf4uaL25oQ3Tn75bERWpLOXyqCAnijr2AhX
 CnSXPUSQzyt2BrA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Do not add the display state to the vnc list, if the initialization
failed. Add vnc_display_free(), to free the display state and associated
data in such case. The function is meant to be public and reused in the
following changes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/keymaps.h |  1 +
 ui/keymaps.c | 13 ++++++++++---
 ui/vnc.c     | 30 ++++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/ui/keymaps.h b/ui/keymaps.h
index 3d52c0882a1..e8917e56404 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -54,6 +54,7 @@ typedef struct kbd_layout_t kbd_layout_t;
 
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
                                    const char *language, Error **errp);
+void kbd_layout_free(kbd_layout_t *k);
 int keysym2scancode(kbd_layout_t *k, int keysym,
                     QKbdState *kbd, bool down);
 int keycode_is_keypad(kbd_layout_t *k, int keycode);
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 2359dbfe7e6..d1b3f43dc8a 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -178,6 +178,14 @@ out:
     return ret;
 }
 
+void kbd_layout_free(kbd_layout_t *k)
+{
+    if (!k) {
+        return;
+    }
+    g_hash_table_unref(k->hash);
+    g_free(k);
+}
 
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
                                    const char *language, Error **errp)
@@ -185,10 +193,9 @@ kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
     kbd_layout_t *k;
 
     k = g_new0(kbd_layout_t, 1);
-    k->hash = g_hash_table_new(NULL, NULL);
+    k->hash = g_hash_table_new_full(NULL, NULL, NULL, g_free);
     if (parse_keyboard_layout(k, table, language, errp) < 0) {
-        g_hash_table_unref(k->hash);
-        g_free(k);
+        kbd_layout_free(k);
         return NULL;
     }
     return k;
diff --git a/ui/vnc.c b/ui/vnc.c
index 763b13acbde..115ff8a988e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3421,6 +3421,8 @@ static void vmstate_change_handler(void *opaque, bool running, RunState state)
     update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
 }
 
+static void vnc_display_free(VncDisplay *vd);
+
 void vnc_display_init(const char *id, Error **errp)
 {
     VncDisplay *vd;
@@ -3430,8 +3432,9 @@ void vnc_display_init(const char *id, Error **errp)
     }
     vd = g_malloc0(sizeof(*vd));
 
+    qemu_mutex_init(&vd->mutex);
     vd->id = g_strdup(id);
-    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
+    vd->dcl.ops = &dcl_ops;
 
     QTAILQ_INIT(&vd->clients);
     vd->expires = TIME_MAX;
@@ -3445,22 +3448,22 @@ void vnc_display_init(const char *id, Error **errp)
     }
 
     if (!vd->kbd_layout) {
+        vnc_display_free(vd);
         return;
     }
 
     vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
     vd->connections_limit = 32;
 
-    qemu_mutex_init(&vd->mutex);
     vnc_start_worker_thread();
 
-    vd->dcl.ops = &dcl_ops;
     register_displaychangelistener(&vd->dcl);
     vd->kbd = qkbd_state_init(vd->dcl.con);
     vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
         &vmstate_change_handler, vd);
-}
 
+    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
+}
 
 static void vnc_display_close(VncDisplay *vd)
 {
@@ -3504,6 +3507,25 @@ static void vnc_display_close(VncDisplay *vd)
 #endif
 }
 
+static void vnc_display_free(VncDisplay *vd)
+{
+    if (!vd) {
+        return;
+    }
+    vnc_display_close(vd);
+    unregister_displaychangelistener(&vd->dcl);
+    qkbd_state_free(vd->kbd);
+    qemu_del_vm_change_state_handler(vd->vmstate_handler_entry);
+    kbd_layout_free(vd->kbd_layout);
+    qemu_mutex_destroy(&vd->mutex);
+    if (QTAILQ_IN_USE(vd, next)) {
+        QTAILQ_REMOVE(&vnc_displays, vd, next);
+    }
+    g_free(vd->id);
+    g_free(vd);
+}
+
+
 int vnc_display_password(const char *id, const char *password, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);

-- 
2.53.0


