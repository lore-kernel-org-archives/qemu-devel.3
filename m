Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D27CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ25S-00022d-0f; Thu, 21 May 2026 08:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ251-0000w1-2Q
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ24z-0005JX-36
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779364843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hd0xYnHBvyjtVBtRC55QRg5lDeTSmz6H7RfmG0DsJr0=;
 b=P3butxpKb7lufq+X13XBI5wwPm3bm6sE16NdpCuIXC7+Q8zUnKMdcU0CnELJDaBW/rijxW
 KBZv91orR6pdXn+of9SWnTsvXwy2Yi1Dco38YHxVpKD0xUuXYsETfCJpo26/nc3A+muxj0
 RCHDD0YxZlfVGVTX+xPNDWDK4XFs10k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-EdSrxksnMw6-k2E7ndOSkg-1; Thu,
 21 May 2026 08:00:40 -0400
X-MC-Unique: EdSrxksnMw6-k2E7ndOSkg-1
X-Mimecast-MFC-AGG-ID: EdSrxksnMw6-k2E7ndOSkg_1779364839
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4FDE180044D; Thu, 21 May 2026 12:00:39 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 48EE01800576; Thu, 21 May 2026 12:00:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 34/38] ui/vnc: Use Linux key codes
Date: Thu, 21 May 2026 15:57:11 +0400
Message-ID: <20260521115717.1701482-35-marcandre.lureau@redhat.com>
In-Reply-To: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
References: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-26-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/vnc.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index f521d9f2ad4..9042816ae6f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -43,6 +43,7 @@
 #include "qapi/qapi-events-ui.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "crypto/hash.h"
@@ -1797,13 +1798,10 @@ static void pointer_event(VncState *vs, int button_mask, int x, int y)
     qemu_input_event_sync();
 }
 
-static void press_key(VncState *vs, QKeyCode qcode)
+static void press_key(VncState *vs, unsigned int lnx)
 {
-    qkbd_state_key_event(vs->vd->kbd, qemu_input_map_qcode_to_linux[qcode],
-                         true);
-
-    qkbd_state_key_event(vs->vd->kbd, qemu_input_map_qcode_to_linux[qcode],
-                         false);
+    qkbd_state_key_event(vs->vd->kbd, lnx, true);
+    qkbd_state_key_event(vs->vd->kbd, lnx, false);
 }
 
 static void vnc_led_state_change(VncState *vs)
@@ -1844,15 +1842,15 @@ static void kbd_leds(void *opaque, int ledstate)
 
 static void do_key_event(VncState *vs, int down, int keycode, int sym)
 {
-    QKeyCode qcode = qemu_input_key_number_to_qcode(keycode);
+    unsigned int lnx = qemu_input_key_number_to_linux(keycode);
 
     /* QEMU console switch */
-    switch (qcode) {
-    case Q_KEY_CODE_1 ... Q_KEY_CODE_9: /* '1' to '9' keys */
+    switch (lnx) {
+    case KEY_1 ... KEY_9: /* '1' to '9' keys */
         if (down &&
             qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL) &&
             qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_ALT)) {
-            QemuConsole *con = qemu_console_lookup_by_index(qcode - Q_KEY_CODE_1);
+            QemuConsole *con = qemu_console_lookup_by_index(lnx - KEY_1);
             if (con) {
                 qemu_console_unregister_listener(&vs->vd->dcl);
                 qkbd_state_switch_console(vs->vd->kbd, con);
@@ -1877,12 +1875,12 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
         if (keysym_is_numlock(vs->vd->kbd_layout, sym & 0xFFFF)) {
             if (!qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK)) {
                 trace_vnc_key_sync_numlock(true);
-                press_key(vs, Q_KEY_CODE_NUM_LOCK);
+                press_key(vs, KEY_NUMLOCK);
             }
         } else {
             if (qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK)) {
                 trace_vnc_key_sync_numlock(false);
-                press_key(vs, Q_KEY_CODE_NUM_LOCK);
+                press_key(vs, KEY_NUMLOCK);
             }
         }
     }
@@ -1900,18 +1898,17 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
         if (capslock) {
             if (uppercase == shift) {
                 trace_vnc_key_sync_capslock(false);
-                press_key(vs, Q_KEY_CODE_CAPS_LOCK);
+                press_key(vs, KEY_CAPSLOCK);
             }
         } else {
             if (uppercase != shift) {
                 trace_vnc_key_sync_capslock(true);
-                press_key(vs, Q_KEY_CODE_CAPS_LOCK);
+                press_key(vs, KEY_CAPSLOCK);
             }
         }
     }
 
-    qkbd_state_key_event(vs->vd->kbd, qemu_input_map_qcode_to_linux[qcode],
-                         down);
+    qkbd_state_key_event(vs->vd->kbd, lnx, down);
     if (QEMU_IS_TEXT_CONSOLE(vs->vd->dcl.con)) {
         QemuTextConsole *con = QEMU_TEXT_CONSOLE(vs->vd->dcl.con);
         bool numlock = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK);
-- 
2.54.0


