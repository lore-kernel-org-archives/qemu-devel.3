Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F77CD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ25C-0000tT-KV; Thu, 21 May 2026 08:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ24J-0000BA-Ei
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ24E-00051O-0Z
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779364797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9poQTDTaxKmyym8x3VBqC5ljx/O722hhW1bSKyHHpE=;
 b=JDtpSHU9ubi3L81Z++UQvy82QhSVu3FQQNT3KJJ/IHIlZjYZhpwSKEgmzjyAmVPC9f2zUO
 vLY4drj9JyGaKz0mQ+rfCeZD3zA0fwEorbNxr7bLFuKot0xbgqy/tY9YZf3tTsnj0Y/Ojq
 +bFnQ7rRKGrWVTFc/GIIsJEG2iZ+eY4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-Yxj3nnFGMcSj3Ve4k1_WFw-1; Thu,
 21 May 2026 07:59:51 -0400
X-MC-Unique: Yxj3nnFGMcSj3Ve4k1_WFw-1
X-Mimecast-MFC-AGG-ID: Yxj3nnFGMcSj3Ve4k1_WFw_1779364790
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B19DC180060D; Thu, 21 May 2026 11:59:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7467300019F; Thu, 21 May 2026 11:59:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 25/38] ui/cocoa: Use Linux key codes
Date: Thu, 21 May 2026 15:57:02 +0400
Message-ID: <20260521115717.1701482-26-marcandre.lureau@redhat.com>
In-Reply-To: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
References: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Message-ID: <20260520-input-v3-17-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/cocoa.m | 328 ++++++++++++++++++++++++-----------------------------
 1 file changed, 148 insertions(+), 180 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index ee53e7c72ed..c5e639ab98d 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -30,6 +30,7 @@
 
 #include "qemu/help-texts.h"
 #include "qemu-main.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/clipboard.h"
 #include "ui/console.h"
 #include "ui/input.h"
@@ -140,124 +141,124 @@ static bool bool_with_bql(BoolCodeBlock block)
     return val;
 }
 
-// Mac to QKeyCode conversion
-static const int mac_to_qkeycode_map[] = {
-    [kVK_ANSI_A] = Q_KEY_CODE_A,
-    [kVK_ANSI_B] = Q_KEY_CODE_B,
-    [kVK_ANSI_C] = Q_KEY_CODE_C,
-    [kVK_ANSI_D] = Q_KEY_CODE_D,
-    [kVK_ANSI_E] = Q_KEY_CODE_E,
-    [kVK_ANSI_F] = Q_KEY_CODE_F,
-    [kVK_ANSI_G] = Q_KEY_CODE_G,
-    [kVK_ANSI_H] = Q_KEY_CODE_H,
-    [kVK_ANSI_I] = Q_KEY_CODE_I,
-    [kVK_ANSI_J] = Q_KEY_CODE_J,
-    [kVK_ANSI_K] = Q_KEY_CODE_K,
-    [kVK_ANSI_L] = Q_KEY_CODE_L,
-    [kVK_ANSI_M] = Q_KEY_CODE_M,
-    [kVK_ANSI_N] = Q_KEY_CODE_N,
-    [kVK_ANSI_O] = Q_KEY_CODE_O,
-    [kVK_ANSI_P] = Q_KEY_CODE_P,
-    [kVK_ANSI_Q] = Q_KEY_CODE_Q,
-    [kVK_ANSI_R] = Q_KEY_CODE_R,
-    [kVK_ANSI_S] = Q_KEY_CODE_S,
-    [kVK_ANSI_T] = Q_KEY_CODE_T,
-    [kVK_ANSI_U] = Q_KEY_CODE_U,
-    [kVK_ANSI_V] = Q_KEY_CODE_V,
-    [kVK_ANSI_W] = Q_KEY_CODE_W,
-    [kVK_ANSI_X] = Q_KEY_CODE_X,
-    [kVK_ANSI_Y] = Q_KEY_CODE_Y,
-    [kVK_ANSI_Z] = Q_KEY_CODE_Z,
-
-    [kVK_ANSI_0] = Q_KEY_CODE_0,
-    [kVK_ANSI_1] = Q_KEY_CODE_1,
-    [kVK_ANSI_2] = Q_KEY_CODE_2,
-    [kVK_ANSI_3] = Q_KEY_CODE_3,
-    [kVK_ANSI_4] = Q_KEY_CODE_4,
-    [kVK_ANSI_5] = Q_KEY_CODE_5,
-    [kVK_ANSI_6] = Q_KEY_CODE_6,
-    [kVK_ANSI_7] = Q_KEY_CODE_7,
-    [kVK_ANSI_8] = Q_KEY_CODE_8,
-    [kVK_ANSI_9] = Q_KEY_CODE_9,
-
-    [kVK_ANSI_Grave] = Q_KEY_CODE_GRAVE_ACCENT,
-    [kVK_ANSI_Minus] = Q_KEY_CODE_MINUS,
-    [kVK_ANSI_Equal] = Q_KEY_CODE_EQUAL,
-    [kVK_Delete] = Q_KEY_CODE_BACKSPACE,
-    [kVK_CapsLock] = Q_KEY_CODE_CAPS_LOCK,
-    [kVK_Tab] = Q_KEY_CODE_TAB,
-    [kVK_Return] = Q_KEY_CODE_RET,
-    [kVK_ANSI_LeftBracket] = Q_KEY_CODE_BRACKET_LEFT,
-    [kVK_ANSI_RightBracket] = Q_KEY_CODE_BRACKET_RIGHT,
-    [kVK_ANSI_Backslash] = Q_KEY_CODE_BACKSLASH,
-    [kVK_ANSI_Semicolon] = Q_KEY_CODE_SEMICOLON,
-    [kVK_ANSI_Quote] = Q_KEY_CODE_APOSTROPHE,
-    [kVK_ANSI_Comma] = Q_KEY_CODE_COMMA,
-    [kVK_ANSI_Period] = Q_KEY_CODE_DOT,
-    [kVK_ANSI_Slash] = Q_KEY_CODE_SLASH,
-    [kVK_Space] = Q_KEY_CODE_SPC,
-
-    [kVK_ANSI_Keypad0] = Q_KEY_CODE_KP_0,
-    [kVK_ANSI_Keypad1] = Q_KEY_CODE_KP_1,
-    [kVK_ANSI_Keypad2] = Q_KEY_CODE_KP_2,
-    [kVK_ANSI_Keypad3] = Q_KEY_CODE_KP_3,
-    [kVK_ANSI_Keypad4] = Q_KEY_CODE_KP_4,
-    [kVK_ANSI_Keypad5] = Q_KEY_CODE_KP_5,
-    [kVK_ANSI_Keypad6] = Q_KEY_CODE_KP_6,
-    [kVK_ANSI_Keypad7] = Q_KEY_CODE_KP_7,
-    [kVK_ANSI_Keypad8] = Q_KEY_CODE_KP_8,
-    [kVK_ANSI_Keypad9] = Q_KEY_CODE_KP_9,
-    [kVK_ANSI_KeypadDecimal] = Q_KEY_CODE_KP_DECIMAL,
-    [kVK_ANSI_KeypadEnter] = Q_KEY_CODE_KP_ENTER,
-    [kVK_ANSI_KeypadPlus] = Q_KEY_CODE_KP_ADD,
-    [kVK_ANSI_KeypadMinus] = Q_KEY_CODE_KP_SUBTRACT,
-    [kVK_ANSI_KeypadMultiply] = Q_KEY_CODE_KP_MULTIPLY,
-    [kVK_ANSI_KeypadDivide] = Q_KEY_CODE_KP_DIVIDE,
-    [kVK_ANSI_KeypadEquals] = Q_KEY_CODE_KP_EQUALS,
-    [kVK_ANSI_KeypadClear] = Q_KEY_CODE_NUM_LOCK,
-
-    [kVK_UpArrow] = Q_KEY_CODE_UP,
-    [kVK_DownArrow] = Q_KEY_CODE_DOWN,
-    [kVK_LeftArrow] = Q_KEY_CODE_LEFT,
-    [kVK_RightArrow] = Q_KEY_CODE_RIGHT,
-
-    [kVK_Help] = Q_KEY_CODE_INSERT,
-    [kVK_Home] = Q_KEY_CODE_HOME,
-    [kVK_PageUp] = Q_KEY_CODE_PGUP,
-    [kVK_PageDown] = Q_KEY_CODE_PGDN,
-    [kVK_End] = Q_KEY_CODE_END,
-    [kVK_ForwardDelete] = Q_KEY_CODE_DELETE,
-
-    [kVK_Escape] = Q_KEY_CODE_ESC,
+// Mac to Linux conversion
+static const unsigned int mac_to_linux_map[] = {
+    [kVK_ANSI_A] = KEY_A,
+    [kVK_ANSI_B] = KEY_B,
+    [kVK_ANSI_C] = KEY_C,
+    [kVK_ANSI_D] = KEY_D,
+    [kVK_ANSI_E] = KEY_E,
+    [kVK_ANSI_F] = KEY_F,
+    [kVK_ANSI_G] = KEY_G,
+    [kVK_ANSI_H] = KEY_H,
+    [kVK_ANSI_I] = KEY_I,
+    [kVK_ANSI_J] = KEY_J,
+    [kVK_ANSI_K] = KEY_K,
+    [kVK_ANSI_L] = KEY_L,
+    [kVK_ANSI_M] = KEY_M,
+    [kVK_ANSI_N] = KEY_N,
+    [kVK_ANSI_O] = KEY_O,
+    [kVK_ANSI_P] = KEY_P,
+    [kVK_ANSI_Q] = KEY_Q,
+    [kVK_ANSI_R] = KEY_R,
+    [kVK_ANSI_S] = KEY_S,
+    [kVK_ANSI_T] = KEY_T,
+    [kVK_ANSI_U] = KEY_U,
+    [kVK_ANSI_V] = KEY_V,
+    [kVK_ANSI_W] = KEY_W,
+    [kVK_ANSI_X] = KEY_X,
+    [kVK_ANSI_Y] = KEY_Y,
+    [kVK_ANSI_Z] = KEY_Z,
+
+    [kVK_ANSI_0] = KEY_0,
+    [kVK_ANSI_1] = KEY_1,
+    [kVK_ANSI_2] = KEY_2,
+    [kVK_ANSI_3] = KEY_3,
+    [kVK_ANSI_4] = KEY_4,
+    [kVK_ANSI_5] = KEY_5,
+    [kVK_ANSI_6] = KEY_6,
+    [kVK_ANSI_7] = KEY_7,
+    [kVK_ANSI_8] = KEY_8,
+    [kVK_ANSI_9] = KEY_9,
+
+    [kVK_ANSI_Grave] = KEY_GRAVE,
+    [kVK_ANSI_Minus] = KEY_MINUS,
+    [kVK_ANSI_Equal] = KEY_EQUAL,
+    [kVK_Delete] = KEY_BACKSPACE,
+    [kVK_CapsLock] = KEY_CAPSLOCK,
+    [kVK_Tab] = KEY_TAB,
+    [kVK_Return] = KEY_ENTER,
+    [kVK_ANSI_LeftBracket] = KEY_LEFTBRACE,
+    [kVK_ANSI_RightBracket] = KEY_RIGHTBRACE,
+    [kVK_ANSI_Backslash] = KEY_BACKSLASH,
+    [kVK_ANSI_Semicolon] = KEY_SEMICOLON,
+    [kVK_ANSI_Quote] = KEY_APOSTROPHE,
+    [kVK_ANSI_Comma] = KEY_COMMA,
+    [kVK_ANSI_Period] = KEY_DOT,
+    [kVK_ANSI_Slash] = KEY_SLASH,
+    [kVK_Space] = KEY_SPACE,
+
+    [kVK_ANSI_Keypad0] = KEY_KP0,
+    [kVK_ANSI_Keypad1] = KEY_KP1,
+    [kVK_ANSI_Keypad2] = KEY_KP2,
+    [kVK_ANSI_Keypad3] = KEY_KP3,
+    [kVK_ANSI_Keypad4] = KEY_KP4,
+    [kVK_ANSI_Keypad5] = KEY_KP5,
+    [kVK_ANSI_Keypad6] = KEY_KP6,
+    [kVK_ANSI_Keypad7] = KEY_KP7,
+    [kVK_ANSI_Keypad8] = KEY_KP8,
+    [kVK_ANSI_Keypad9] = KEY_KP9,
+    [kVK_ANSI_KeypadDecimal] = KEY_KPDOT,
+    [kVK_ANSI_KeypadEnter] = KEY_KPENTER,
+    [kVK_ANSI_KeypadPlus] = KEY_KPPLUS,
+    [kVK_ANSI_KeypadMinus] = KEY_KPMINUS,
+    [kVK_ANSI_KeypadMultiply] = KEY_KPASTERISK,
+    [kVK_ANSI_KeypadDivide] = KEY_KPSLASH,
+    [kVK_ANSI_KeypadEquals] = KEY_KPEQUAL,
+    [kVK_ANSI_KeypadClear] = KEY_NUMLOCK,
+
+    [kVK_UpArrow] = KEY_UP,
+    [kVK_DownArrow] = KEY_DOWN,
+    [kVK_LeftArrow] = KEY_LEFT,
+    [kVK_RightArrow] = KEY_RIGHT,
+
+    [kVK_Help] = KEY_INSERT,
+    [kVK_Home] = KEY_HOME,
+    [kVK_PageUp] = KEY_PAGEUP,
+    [kVK_PageDown] = KEY_PAGEDOWN,
+    [kVK_End] = KEY_END,
+    [kVK_ForwardDelete] = KEY_DELETE,
+
+    [kVK_Escape] = KEY_ESC,
 
     /* The Power key can't be used directly because the operating system uses
      * it. This key can be emulated by using it in place of another key such as
      * F1. Don't forget to disable the real key binding.
      */
-    /* [kVK_F1] = Q_KEY_CODE_POWER, */
-
-    [kVK_F1] = Q_KEY_CODE_F1,
-    [kVK_F2] = Q_KEY_CODE_F2,
-    [kVK_F3] = Q_KEY_CODE_F3,
-    [kVK_F4] = Q_KEY_CODE_F4,
-    [kVK_F5] = Q_KEY_CODE_F5,
-    [kVK_F6] = Q_KEY_CODE_F6,
-    [kVK_F7] = Q_KEY_CODE_F7,
-    [kVK_F8] = Q_KEY_CODE_F8,
-    [kVK_F9] = Q_KEY_CODE_F9,
-    [kVK_F10] = Q_KEY_CODE_F10,
-    [kVK_F11] = Q_KEY_CODE_F11,
-    [kVK_F12] = Q_KEY_CODE_F12,
-    [kVK_F13] = Q_KEY_CODE_PRINT,
-    [kVK_F14] = Q_KEY_CODE_SCROLL_LOCK,
-    [kVK_F15] = Q_KEY_CODE_PAUSE,
+    /* [kVK_F1] = KEY_POWER, */
+
+    [kVK_F1] = KEY_F1,
+    [kVK_F2] = KEY_F2,
+    [kVK_F3] = KEY_F3,
+    [kVK_F4] = KEY_F4,
+    [kVK_F5] = KEY_F5,
+    [kVK_F6] = KEY_F6,
+    [kVK_F7] = KEY_F7,
+    [kVK_F8] = KEY_F8,
+    [kVK_F9] = KEY_F9,
+    [kVK_F10] = KEY_F10,
+    [kVK_F11] = KEY_F11,
+    [kVK_F12] = KEY_F12,
+    [kVK_F13] = KEY_SYSRQ,
+    [kVK_F14] = KEY_SCROLLLOCK,
+    [kVK_F15] = KEY_PAUSE,
 
     // JIS keyboards only
-    [kVK_JIS_Yen] = Q_KEY_CODE_YEN,
-    [kVK_JIS_Underscore] = Q_KEY_CODE_RO,
-    [kVK_JIS_KeypadComma] = Q_KEY_CODE_KP_COMMA,
-    [kVK_JIS_Eisu] = Q_KEY_CODE_MUHENKAN,
-    [kVK_JIS_Kana] = Q_KEY_CODE_HENKAN,
+    [kVK_JIS_Yen] = KEY_YEN,
+    [kVK_JIS_Underscore] = KEY_RO,
+    [kVK_JIS_KeypadComma] = KEY_KPCOMMA,
+    [kVK_JIS_Eisu] = KEY_MUHENKAN,
+    [kVK_JIS_Kana] = KEY_HENKAN,
 
     /*
      * The eject and volume keys can't be used here because they are handled at
@@ -265,13 +266,13 @@ static bool bool_with_bql(BoolCodeBlock block)
      */
 };
 
-static int cocoa_keycode_to_qemu(int keycode)
+static unsigned int cocoa_keycode_to_linux(int keycode)
 {
-    if (ARRAY_SIZE(mac_to_qkeycode_map) <= keycode) {
+    if (ARRAY_SIZE(mac_to_linux_map) <= keycode) {
         error_report("(cocoa) warning unknown keycode 0x%x", keycode);
         return 0;
     }
-    return mac_to_qkeycode_map[keycode];
+    return mac_to_linux_map[keycode];
 }
 
 /* Displays an alert dialog box with the specified message */
@@ -766,9 +767,8 @@ - (void) setFullGrab:(id)sender
     CFRelease(tapEventsSrc);
 }
 
-- (void) toggleKey: (int)keycode {
-    unsigned int lnx = qemu_input_map_qcode_to_linux[keycode];
-    qkbd_state_key_event(kbd, lnx, !qkbd_state_key_get(kbd, lnx));
+- (void) toggleKey: (unsigned int)keycode {
+    qkbd_state_key_event(kbd, keycode, !qkbd_state_key_get(kbd, keycode));
 }
 
 // Does the work of sending input to the monitor
@@ -848,7 +848,7 @@ - (bool) handleEventLocked:(NSEvent *)event
     /* Return true if we handled the event, false if it should be given to OSX */
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
     InputButton button;
-    int keycode = 0;
+    unsigned int keycode;
     NSUInteger modifiers = [event modifierFlags];
 
     /*
@@ -890,62 +890,34 @@ - (bool) handleEventLocked:(NSEvent *)event
      */
     if (!!(modifiers & NSEventModifierFlagCapsLock) !=
         qkbd_state_modifier_get(kbd, QKBD_MOD_CAPSLOCK)) {
-        qkbd_state_key_event(kbd,
-                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_CAPS_LOCK],
-                             true);
-        qkbd_state_key_event(kbd,
-                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_CAPS_LOCK],
-                             false);
+        qkbd_state_key_event(kbd, KEY_CAPSLOCK, true);
+        qkbd_state_key_event(kbd, KEY_CAPSLOCK, false);
     }
 
     if (!(modifiers & NSEventModifierFlagShift)) {
-        qkbd_state_key_event(kbd,
-                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_SHIFT],
-                             false);
-        qkbd_state_key_event(kbd,
-                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_SHIFT_R],
-                             false);
+        qkbd_state_key_event(kbd, KEY_LEFTSHIFT, false);
+        qkbd_state_key_event(kbd, KEY_RIGHTSHIFT, false);
     }
     if (!(modifiers & NSEventModifierFlagControl)) {
-        qkbd_state_key_event(kbd,
-                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_CTRL],
-                             false);
-        qkbd_state_key_event(kbd,
-                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_CTRL_R],
-                             false);
+        qkbd_state_key_event(kbd, KEY_LEFTCTRL, false);
+        qkbd_state_key_event(kbd, KEY_RIGHTCTRL, false);
     }
     if (!(modifiers & NSEventModifierFlagOption)) {
         if (swap_opt_cmd) {
-            qkbd_state_key_event(kbd,
-                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_META_L],
-                                 false);
-            qkbd_state_key_event(kbd,
-                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_META_R],
-                                 false);
+            qkbd_state_key_event(kbd, KEY_LEFTMETA, false);
+            qkbd_state_key_event(kbd, KEY_RIGHTMETA, false);
         } else {
-            qkbd_state_key_event(kbd,
-                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_ALT],
-                                 false);
-            qkbd_state_key_event(kbd,
-                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_ALT_R],
-                                 false);
+            qkbd_state_key_event(kbd, KEY_LEFTALT, false);
+            qkbd_state_key_event(kbd, KEY_RIGHTALT, false);
         }
     }
     if (!(modifiers & NSEventModifierFlagCommand)) {
         if (swap_opt_cmd) {
-            qkbd_state_key_event(kbd,
-                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_ALT],
-                                 false);
-            qkbd_state_key_event(kbd,
-                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_ALT_R],
-                                 false);
+            qkbd_state_key_event(kbd, KEY_LEFTALT, false);
+            qkbd_state_key_event(kbd, KEY_RIGHTALT, false);
         } else {
-            qkbd_state_key_event(kbd,
-                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_META_L],
-                                 false);
-            qkbd_state_key_event(kbd,
-                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_META_R],
-                                 false);
+            qkbd_state_key_event(kbd, KEY_LEFTMETA, false);
+            qkbd_state_key_event(kbd, KEY_RIGHTMETA, false);
         }
     }
 
@@ -954,34 +926,34 @@ - (bool) handleEventLocked:(NSEvent *)event
             switch ([event keyCode]) {
                 case kVK_Shift:
                     if (!!(modifiers & NSEventModifierFlagShift)) {
-                        [self toggleKey:Q_KEY_CODE_SHIFT];
+                        [self toggleKey:KEY_LEFTSHIFT];
                     }
                     break;
 
                 case kVK_RightShift:
                     if (!!(modifiers & NSEventModifierFlagShift)) {
-                        [self toggleKey:Q_KEY_CODE_SHIFT_R];
+                        [self toggleKey:KEY_RIGHTSHIFT];
                     }
                     break;
 
                 case kVK_Control:
                     if (!!(modifiers & NSEventModifierFlagControl)) {
-                        [self toggleKey:Q_KEY_CODE_CTRL];
+                        [self toggleKey:KEY_LEFTCTRL];
                     }
                     break;
 
                 case kVK_RightControl:
                     if (!!(modifiers & NSEventModifierFlagControl)) {
-                        [self toggleKey:Q_KEY_CODE_CTRL_R];
+                        [self toggleKey:KEY_RIGHTCTRL];
                     }
                     break;
 
                 case kVK_Option:
                     if (!!(modifiers & NSEventModifierFlagOption)) {
                         if (swap_opt_cmd) {
-                            [self toggleKey:Q_KEY_CODE_META_L];
+                            [self toggleKey:KEY_LEFTMETA];
                         } else {
-                            [self toggleKey:Q_KEY_CODE_ALT];
+                            [self toggleKey:KEY_LEFTALT];
                         }
                     }
                     break;
@@ -989,9 +961,9 @@ - (bool) handleEventLocked:(NSEvent *)event
                 case kVK_RightOption:
                     if (!!(modifiers & NSEventModifierFlagOption)) {
                         if (swap_opt_cmd) {
-                            [self toggleKey:Q_KEY_CODE_META_R];
+                            [self toggleKey:KEY_RIGHTMETA];
                         } else {
-                            [self toggleKey:Q_KEY_CODE_ALT_R];
+                            [self toggleKey:KEY_RIGHTALT];
                         }
                     }
                     break;
@@ -1002,9 +974,9 @@ - (bool) handleEventLocked:(NSEvent *)event
                         !!(modifiers & NSEventModifierFlagCommand) &&
                         left_command_key_enabled) {
                         if (swap_opt_cmd) {
-                            [self toggleKey:Q_KEY_CODE_ALT];
+                            [self toggleKey:KEY_LEFTALT];
                         } else {
-                            [self toggleKey:Q_KEY_CODE_META_L];
+                            [self toggleKey:KEY_LEFTMETA];
                         }
                     }
                     break;
@@ -1013,16 +985,16 @@ - (bool) handleEventLocked:(NSEvent *)event
                     if (isMouseGrabbed &&
                         !!(modifiers & NSEventModifierFlagCommand)) {
                         if (swap_opt_cmd) {
-                            [self toggleKey:Q_KEY_CODE_ALT_R];
+                            [self toggleKey:KEY_RIGHTALT];
                         } else {
-                            [self toggleKey:Q_KEY_CODE_META_R];
+                            [self toggleKey:KEY_RIGHTMETA];
                         }
                     }
                     break;
             }
             return true;
         case NSEventTypeKeyDown:
-            keycode = cocoa_keycode_to_qemu([event keyCode]);
+            keycode = cocoa_keycode_to_linux([event keyCode]);
 
             // forward command key combos to the host UI unless the mouse is grabbed
             if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
@@ -1052,15 +1024,13 @@ - (bool) handleEventLocked:(NSEvent *)event
             }
 
             if (qemu_console_is_graphic(dcl.con)) {
-                qkbd_state_key_event(kbd,
-                                     qemu_input_map_qcode_to_linux[keycode],
-                                     true);
+                qkbd_state_key_event(kbd, keycode, true);
             } else {
                 [self handleMonitorInput: event];
             }
             return true;
         case NSEventTypeKeyUp:
-            keycode = cocoa_keycode_to_qemu([event keyCode]);
+            keycode = cocoa_keycode_to_linux([event keyCode]);
 
             // don't pass the guest a spurious key-up if we treated this
             // command-key combo as a host UI action
@@ -1069,9 +1039,7 @@ - (bool) handleEventLocked:(NSEvent *)event
             }
 
             if (qemu_console_is_graphic(dcl.con)) {
-                qkbd_state_key_event(kbd,
-                                     qemu_input_map_qcode_to_linux[keycode],
-                                     false);
+                qkbd_state_key_event(kbd, keycode, false);
             }
             return true;
         case NSEventTypeScrollWheel:
-- 
2.54.0


