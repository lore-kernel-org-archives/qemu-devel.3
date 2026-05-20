Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617D1CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPakl-0003wa-K9; Wed, 20 May 2026 02:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajz-0003YS-AK; Wed, 20 May 2026 02:49:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajv-0001Ol-U0; Wed, 20 May 2026 02:49:15 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbn096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8soqAAF80Sr/QNu7vy2YY8c+Vx8TG6XRwo59Ykhi4vE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259699; v=1;
 b=b4mCHa2NETSAchcpT+DDJhOjCkFBZ83DGKCu6RbmtGc2yi7+OXXztCl73NALUYGv
 C+kv+u94m09iOr3PQKQ7BQ8Xv5wg6tnryOc5ewyuBug+Ypf/2qef0YnHXIESMXHr
 tqLV1xtBLEnRsGY5IG+hzw/d/Y1UTYQVSueqLcNtbsJl+lAk+Yab6pxC/lrIn2Ku
 VcwLKL+RK1lax/ZesDslcFiH0337Go7mQqbcvWWxaPz9txvwqxzK+L/Oihujja4b
 nwj65VxxavMPyuwWOtEQmNpSB/y/fJS0v+aU/dWhvyxgu1SJXKLQ2lAM3WYt2VWK
 pbIpJVO95PdqFHKQX6a/pg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:48:09 +0900
Subject: [PATCH v3 26/29] ui/vnc: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-26-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
References: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=3926;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=fVMHTWI13jVtYYp754ee7t/4i7+v9d4aNF/ntnvLwpw=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpNabm4H3F214Zqyo1xZaOHltueldu3VfWfpz+g2qd
 3pJ8d7pKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmEjMQ0aGLccWtf44u9UlcblP
 c8WkDXneTL6xb662rT00+0vb//S5dxj+il33qYsQs9EKczzm8GXbBVa+5elvpVkE916JOm9+76Q
 UCwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/vnc.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 4269b19d1489..e14287ca68af 100644
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


