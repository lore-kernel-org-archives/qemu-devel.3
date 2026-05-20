Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8045BCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPalO-0005qK-Vj; Wed, 20 May 2026 02:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajz-0003Yl-SE; Wed, 20 May 2026 02:49:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajv-0001Of-VV; Wed, 20 May 2026 02:49:15 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbY096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ROUhaRxtDzPB8FJJRyCm0S9ppDBULPhLkvEBb93D+50=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259696; v=1;
 b=IiR2Odl2Ven3Rf7Q6eMyJ/eFED/n5UeWd9tzrkl6xEYowpalxuIgpwXQRSrfCilJ
 mqyZY+OvwufPRxhqxQ/gtOyug1A9LapPF43hO7kju0JwgKgr7keyuJv3vJeDODT9
 tRWx39ODZKIwJ2zWmKtS1oFAFeHqB4AJbaKpA1UCTDua1Rw91dblmThwDdEEuC/3
 7n1xRtm8z1nwbQURcbTa8sw7iCrYR2ZvGSNJRhiplIPpprnmBVhvTRuBy1/q1u9E
 5P/iG8w914t7Iao1Y08K4rntE+eMn8MDp7hLuk+8jZvXtk+FD59rex3Gwp8V7Tx4
 vcTAHGxvoD4jGePT/0/Xrg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:47:54 +0900
Subject: [PATCH v3 11/29] hw/input/adb-kbd: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-11-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11545;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=IuNc0nZq13Cfg85XfjaPn1/m1nF4glzSwdiuAeVhaoQ=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpLy4Xpb676Dn/98+emdeH8xza0f+Y6kDibJ+Opvzp
 Bwbiu92lLIwiHExyIopsqQU7ebWiK79VJgQ3wIzh5UJZAgDF6cATCTzBSPDgdkHswr1d3370GAg
 ftH2cMAx/mPVJTsXCPW+aTd6d9DhCMP/MoXKZf15y2zZpAvvebXf8wos+Ccc8vtZ5eQt1Rd6yow
 4AA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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
 hw/input/adb-kbd.c | 242 ++++++++++++++++++++++++++---------------------------
 1 file changed, 120 insertions(+), 122 deletions(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 060481d0db6d..c4ef9ebb90c8 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -26,6 +26,7 @@
 #include "hw/input/adb.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/input.h"
 #include "hw/input/adb-keys.h"
 #include "adb-internal.h"
@@ -55,124 +56,122 @@ struct ADBKeyboardClass {
 /* The adb keyboard doesn't have every key imaginable */
 #define NO_KEY 0xff
 
-int qcode_to_adb_keycode[] = {
+int linux_to_adb_keycode[] = {
      /* Make sure future additions are automatically set to NO_KEY */
-    [0 ... 0xff]               = NO_KEY,
-
-    [Q_KEY_CODE_SHIFT]         = ADB_KEY_LEFT_SHIFT,
-    [Q_KEY_CODE_SHIFT_R]       = ADB_KEY_RIGHT_SHIFT,
-    [Q_KEY_CODE_ALT]           = ADB_KEY_LEFT_OPTION,
-    [Q_KEY_CODE_ALT_R]         = ADB_KEY_RIGHT_OPTION,
-    [Q_KEY_CODE_CTRL]          = ADB_KEY_LEFT_CONTROL,
-    [Q_KEY_CODE_CTRL_R]        = ADB_KEY_RIGHT_CONTROL,
-    [Q_KEY_CODE_META_L]        = ADB_KEY_COMMAND,
-    [Q_KEY_CODE_META_R]        = ADB_KEY_COMMAND,
-    [Q_KEY_CODE_SPC]           = ADB_KEY_SPACEBAR,
-
-    [Q_KEY_CODE_ESC]           = ADB_KEY_ESC,
-    [Q_KEY_CODE_1]             = ADB_KEY_1,
-    [Q_KEY_CODE_2]             = ADB_KEY_2,
-    [Q_KEY_CODE_3]             = ADB_KEY_3,
-    [Q_KEY_CODE_4]             = ADB_KEY_4,
-    [Q_KEY_CODE_5]             = ADB_KEY_5,
-    [Q_KEY_CODE_6]             = ADB_KEY_6,
-    [Q_KEY_CODE_7]             = ADB_KEY_7,
-    [Q_KEY_CODE_8]             = ADB_KEY_8,
-    [Q_KEY_CODE_9]             = ADB_KEY_9,
-    [Q_KEY_CODE_0]             = ADB_KEY_0,
-    [Q_KEY_CODE_MINUS]         = ADB_KEY_MINUS,
-    [Q_KEY_CODE_EQUAL]         = ADB_KEY_EQUAL,
-    [Q_KEY_CODE_BACKSPACE]     = ADB_KEY_DELETE,
-    [Q_KEY_CODE_TAB]           = ADB_KEY_TAB,
-    [Q_KEY_CODE_Q]             = ADB_KEY_Q,
-    [Q_KEY_CODE_W]             = ADB_KEY_W,
-    [Q_KEY_CODE_E]             = ADB_KEY_E,
-    [Q_KEY_CODE_R]             = ADB_KEY_R,
-    [Q_KEY_CODE_T]             = ADB_KEY_T,
-    [Q_KEY_CODE_Y]             = ADB_KEY_Y,
-    [Q_KEY_CODE_U]             = ADB_KEY_U,
-    [Q_KEY_CODE_I]             = ADB_KEY_I,
-    [Q_KEY_CODE_O]             = ADB_KEY_O,
-    [Q_KEY_CODE_P]             = ADB_KEY_P,
-    [Q_KEY_CODE_BRACKET_LEFT]  = ADB_KEY_LEFT_BRACKET,
-    [Q_KEY_CODE_BRACKET_RIGHT] = ADB_KEY_RIGHT_BRACKET,
-    [Q_KEY_CODE_RET]           = ADB_KEY_RETURN,
-    [Q_KEY_CODE_A]             = ADB_KEY_A,
-    [Q_KEY_CODE_S]             = ADB_KEY_S,
-    [Q_KEY_CODE_D]             = ADB_KEY_D,
-    [Q_KEY_CODE_F]             = ADB_KEY_F,
-    [Q_KEY_CODE_G]             = ADB_KEY_G,
-    [Q_KEY_CODE_H]             = ADB_KEY_H,
-    [Q_KEY_CODE_J]             = ADB_KEY_J,
-    [Q_KEY_CODE_K]             = ADB_KEY_K,
-    [Q_KEY_CODE_L]             = ADB_KEY_L,
-    [Q_KEY_CODE_SEMICOLON]     = ADB_KEY_SEMICOLON,
-    [Q_KEY_CODE_APOSTROPHE]    = ADB_KEY_APOSTROPHE,
-    [Q_KEY_CODE_GRAVE_ACCENT]  = ADB_KEY_GRAVE_ACCENT,
-    [Q_KEY_CODE_BACKSLASH]     = ADB_KEY_BACKSLASH,
-    [Q_KEY_CODE_Z]             = ADB_KEY_Z,
-    [Q_KEY_CODE_X]             = ADB_KEY_X,
-    [Q_KEY_CODE_C]             = ADB_KEY_C,
-    [Q_KEY_CODE_V]             = ADB_KEY_V,
-    [Q_KEY_CODE_B]             = ADB_KEY_B,
-    [Q_KEY_CODE_N]             = ADB_KEY_N,
-    [Q_KEY_CODE_M]             = ADB_KEY_M,
-    [Q_KEY_CODE_COMMA]         = ADB_KEY_COMMA,
-    [Q_KEY_CODE_DOT]           = ADB_KEY_PERIOD,
-    [Q_KEY_CODE_SLASH]         = ADB_KEY_FORWARD_SLASH,
-    [Q_KEY_CODE_ASTERISK]      = ADB_KEY_KP_MULTIPLY,
-    [Q_KEY_CODE_CAPS_LOCK]     = ADB_KEY_CAPS_LOCK,
-
-    [Q_KEY_CODE_F1]            = ADB_KEY_F1,
-    [Q_KEY_CODE_F2]            = ADB_KEY_F2,
-    [Q_KEY_CODE_F3]            = ADB_KEY_F3,
-    [Q_KEY_CODE_F4]            = ADB_KEY_F4,
-    [Q_KEY_CODE_F5]            = ADB_KEY_F5,
-    [Q_KEY_CODE_F6]            = ADB_KEY_F6,
-    [Q_KEY_CODE_F7]            = ADB_KEY_F7,
-    [Q_KEY_CODE_F8]            = ADB_KEY_F8,
-    [Q_KEY_CODE_F9]            = ADB_KEY_F9,
-    [Q_KEY_CODE_F10]           = ADB_KEY_F10,
-    [Q_KEY_CODE_F11]           = ADB_KEY_F11,
-    [Q_KEY_CODE_F12]           = ADB_KEY_F12,
-    [Q_KEY_CODE_PRINT]         = ADB_KEY_F13,
-    [Q_KEY_CODE_SYSRQ]         = ADB_KEY_F13,
-    [Q_KEY_CODE_SCROLL_LOCK]   = ADB_KEY_F14,
-    [Q_KEY_CODE_PAUSE]         = ADB_KEY_F15,
-
-    [Q_KEY_CODE_NUM_LOCK]      = ADB_KEY_KP_CLEAR,
-    [Q_KEY_CODE_KP_EQUALS]     = ADB_KEY_KP_EQUAL,
-    [Q_KEY_CODE_KP_DIVIDE]     = ADB_KEY_KP_DIVIDE,
-    [Q_KEY_CODE_KP_MULTIPLY]   = ADB_KEY_KP_MULTIPLY,
-    [Q_KEY_CODE_KP_SUBTRACT]   = ADB_KEY_KP_SUBTRACT,
-    [Q_KEY_CODE_KP_ADD]        = ADB_KEY_KP_PLUS,
-    [Q_KEY_CODE_KP_ENTER]      = ADB_KEY_KP_ENTER,
-    [Q_KEY_CODE_KP_DECIMAL]    = ADB_KEY_KP_PERIOD,
-    [Q_KEY_CODE_KP_0]          = ADB_KEY_KP_0,
-    [Q_KEY_CODE_KP_1]          = ADB_KEY_KP_1,
-    [Q_KEY_CODE_KP_2]          = ADB_KEY_KP_2,
-    [Q_KEY_CODE_KP_3]          = ADB_KEY_KP_3,
-    [Q_KEY_CODE_KP_4]          = ADB_KEY_KP_4,
-    [Q_KEY_CODE_KP_5]          = ADB_KEY_KP_5,
-    [Q_KEY_CODE_KP_6]          = ADB_KEY_KP_6,
-    [Q_KEY_CODE_KP_7]          = ADB_KEY_KP_7,
-    [Q_KEY_CODE_KP_8]          = ADB_KEY_KP_8,
-    [Q_KEY_CODE_KP_9]          = ADB_KEY_KP_9,
-
-    [Q_KEY_CODE_UP]            = ADB_KEY_UP,
-    [Q_KEY_CODE_DOWN]          = ADB_KEY_DOWN,
-    [Q_KEY_CODE_LEFT]          = ADB_KEY_LEFT,
-    [Q_KEY_CODE_RIGHT]         = ADB_KEY_RIGHT,
-
-    [Q_KEY_CODE_HELP]          = ADB_KEY_HELP,
-    [Q_KEY_CODE_INSERT]        = ADB_KEY_HELP,
-    [Q_KEY_CODE_DELETE]        = ADB_KEY_FORWARD_DELETE,
-    [Q_KEY_CODE_HOME]          = ADB_KEY_HOME,
-    [Q_KEY_CODE_END]           = ADB_KEY_END,
-    [Q_KEY_CODE_PGUP]          = ADB_KEY_PAGE_UP,
-    [Q_KEY_CODE_PGDN]          = ADB_KEY_PAGE_DOWN,
-
-    [Q_KEY_CODE_POWER]         = ADB_KEY_POWER
+    [0 ... KEY_MAX]  = NO_KEY,
+
+    [KEY_LEFTSHIFT]  = ADB_KEY_LEFT_SHIFT,
+    [KEY_RIGHTSHIFT] = ADB_KEY_RIGHT_SHIFT,
+    [KEY_LEFTALT]    = ADB_KEY_LEFT_OPTION,
+    [KEY_RIGHTALT]   = ADB_KEY_RIGHT_OPTION,
+    [KEY_LEFTCTRL]   = ADB_KEY_LEFT_CONTROL,
+    [KEY_RIGHTCTRL]  = ADB_KEY_RIGHT_CONTROL,
+    [KEY_LEFTMETA]   = ADB_KEY_COMMAND,
+    [KEY_RIGHTMETA]  = ADB_KEY_COMMAND,
+    [KEY_SPACE]      = ADB_KEY_SPACEBAR,
+
+    [KEY_ESC]        = ADB_KEY_ESC,
+    [KEY_1]          = ADB_KEY_1,
+    [KEY_2]          = ADB_KEY_2,
+    [KEY_3]          = ADB_KEY_3,
+    [KEY_4]          = ADB_KEY_4,
+    [KEY_5]          = ADB_KEY_5,
+    [KEY_6]          = ADB_KEY_6,
+    [KEY_7]          = ADB_KEY_7,
+    [KEY_8]          = ADB_KEY_8,
+    [KEY_9]          = ADB_KEY_9,
+    [KEY_0]          = ADB_KEY_0,
+    [KEY_MINUS]      = ADB_KEY_MINUS,
+    [KEY_EQUAL]      = ADB_KEY_EQUAL,
+    [KEY_BACKSPACE]  = ADB_KEY_DELETE,
+    [KEY_TAB]        = ADB_KEY_TAB,
+    [KEY_Q]          = ADB_KEY_Q,
+    [KEY_W]          = ADB_KEY_W,
+    [KEY_E]          = ADB_KEY_E,
+    [KEY_R]          = ADB_KEY_R,
+    [KEY_T]          = ADB_KEY_T,
+    [KEY_Y]          = ADB_KEY_Y,
+    [KEY_U]          = ADB_KEY_U,
+    [KEY_I]          = ADB_KEY_I,
+    [KEY_O]          = ADB_KEY_O,
+    [KEY_P]          = ADB_KEY_P,
+    [KEY_LEFTBRACE]  = ADB_KEY_LEFT_BRACKET,
+    [KEY_RIGHTBRACE] = ADB_KEY_RIGHT_BRACKET,
+    [KEY_ENTER]      = ADB_KEY_RETURN,
+    [KEY_A]          = ADB_KEY_A,
+    [KEY_S]          = ADB_KEY_S,
+    [KEY_D]          = ADB_KEY_D,
+    [KEY_F]          = ADB_KEY_F,
+    [KEY_G]          = ADB_KEY_G,
+    [KEY_H]          = ADB_KEY_H,
+    [KEY_J]          = ADB_KEY_J,
+    [KEY_K]          = ADB_KEY_K,
+    [KEY_L]          = ADB_KEY_L,
+    [KEY_SEMICOLON]  = ADB_KEY_SEMICOLON,
+    [KEY_APOSTROPHE] = ADB_KEY_APOSTROPHE,
+    [KEY_GRAVE]      = ADB_KEY_GRAVE_ACCENT,
+    [KEY_BACKSLASH]  = ADB_KEY_BACKSLASH,
+    [KEY_Z]          = ADB_KEY_Z,
+    [KEY_X]          = ADB_KEY_X,
+    [KEY_C]          = ADB_KEY_C,
+    [KEY_V]          = ADB_KEY_V,
+    [KEY_B]          = ADB_KEY_B,
+    [KEY_N]          = ADB_KEY_N,
+    [KEY_M]          = ADB_KEY_M,
+    [KEY_COMMA]      = ADB_KEY_COMMA,
+    [KEY_DOT]        = ADB_KEY_PERIOD,
+    [KEY_SLASH]      = ADB_KEY_FORWARD_SLASH,
+    [KEY_CAPSLOCK]   = ADB_KEY_CAPS_LOCK,
+
+    [KEY_F1]         = ADB_KEY_F1,
+    [KEY_F2]         = ADB_KEY_F2,
+    [KEY_F3]         = ADB_KEY_F3,
+    [KEY_F4]         = ADB_KEY_F4,
+    [KEY_F5]         = ADB_KEY_F5,
+    [KEY_F6]         = ADB_KEY_F6,
+    [KEY_F7]         = ADB_KEY_F7,
+    [KEY_F8]         = ADB_KEY_F8,
+    [KEY_F9]         = ADB_KEY_F9,
+    [KEY_F10]        = ADB_KEY_F10,
+    [KEY_F11]        = ADB_KEY_F11,
+    [KEY_F12]        = ADB_KEY_F12,
+    [KEY_SYSRQ]      = ADB_KEY_F13,
+    [KEY_SCROLLLOCK] = ADB_KEY_F14,
+    [KEY_PAUSE]      = ADB_KEY_F15,
+
+    [KEY_NUMLOCK]    = ADB_KEY_KP_CLEAR,
+    [KEY_KPEQUAL]    = ADB_KEY_KP_EQUAL,
+    [KEY_KPSLASH]    = ADB_KEY_KP_DIVIDE,
+    [KEY_KPASTERISK] = ADB_KEY_KP_MULTIPLY,
+    [KEY_KPMINUS]    = ADB_KEY_KP_SUBTRACT,
+    [KEY_KPPLUS]     = ADB_KEY_KP_PLUS,
+    [KEY_KPENTER]    = ADB_KEY_KP_ENTER,
+    [KEY_KPDOT]      = ADB_KEY_KP_PERIOD,
+    [KEY_KP0]        = ADB_KEY_KP_0,
+    [KEY_KP1]        = ADB_KEY_KP_1,
+    [KEY_KP2]        = ADB_KEY_KP_2,
+    [KEY_KP3]        = ADB_KEY_KP_3,
+    [KEY_KP4]        = ADB_KEY_KP_4,
+    [KEY_KP5]        = ADB_KEY_KP_5,
+    [KEY_KP6]        = ADB_KEY_KP_6,
+    [KEY_KP7]        = ADB_KEY_KP_7,
+    [KEY_KP8]        = ADB_KEY_KP_8,
+    [KEY_KP9]        = ADB_KEY_KP_9,
+
+    [KEY_UP]         = ADB_KEY_UP,
+    [KEY_DOWN]       = ADB_KEY_DOWN,
+    [KEY_LEFT]       = ADB_KEY_LEFT,
+    [KEY_RIGHT]      = ADB_KEY_RIGHT,
+
+    [KEY_HELP]       = ADB_KEY_HELP,
+    [KEY_INSERT]     = ADB_KEY_HELP,
+    [KEY_DELETE]     = ADB_KEY_FORWARD_DELETE,
+    [KEY_HOME]       = ADB_KEY_HOME,
+    [KEY_END]        = ADB_KEY_END,
+    [KEY_PAGEUP]     = ADB_KEY_PAGE_UP,
+    [KEY_PAGEDOWN]   = ADB_KEY_PAGE_DOWN,
+
+    [KEY_POWER]      = ADB_KEY_POWER
 };
 
 static void adb_kbd_put_keycode(void *opaque, int keycode)
@@ -309,14 +308,13 @@ static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
                                QemuInputEvent *evt)
 {
     KBDState *s = (KBDState *)dev;
-    int qcode, keycode;
+    int keycode;
 
-    qcode = qemu_input_linux_to_qcode(evt->key.key);
-    if (qcode >= ARRAY_SIZE(qcode_to_adb_keycode)) {
+    if (evt->key.key >= ARRAY_SIZE(linux_to_adb_keycode)) {
         return;
     }
-    /* FIXME: take handler into account when translating qcode */
-    keycode = qcode_to_adb_keycode[qcode];
+    /* FIXME: take handler into account when translating evt->key.key */
+    keycode = linux_to_adb_keycode[evt->key.key];
     if (keycode == NO_KEY) {  /* We don't want to send this to the guest */
         trace_adb_device_kbd_no_key();
         return;

-- 
2.54.0


