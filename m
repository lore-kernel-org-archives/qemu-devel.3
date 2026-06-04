Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F53CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 06:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV1ng-0006XH-Dz; Thu, 04 Jun 2026 02:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wV1ne-0006X8-0l
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 02:43:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wV1na-0007JG-Ji
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 02:43:29 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6546h03f047185
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Jun 2026 15:43:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=nMQzw+CgMK7MS3MPiZFgTDFS2ZlLnoQarKQ/wPen1/A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1780555392; v=1;
 b=NYqXTdTnT27bmNWJVMijUaihghhgnO3lM3H9L4uY5MwV6ZcZU0cxo6kL60QY7HL1
 /CEY2xXYv39H5s9q2HHaWa2k5giZPjrEMy9QLMnizH9fPzqt74XGKpqvaBn7bI99
 Uct7lmGpugptNRYVIWQSrIaiUD1ifksrX55v23BXefFyq3jJOityEzWK56hEdbZS
 HxrAVfFsNzaWvFN+qPAHnmZpRQxNRUCWiX55cxjyhx6JEw6CRJy2D8lgUr36cF0z
 3yXaN3ocNctmOac4fY074zbxLofRNkSJQ9+Kf6PuaG+dmmRDcqAoROlElGSyhdsf
 EwioCCDIvTQ06gUf4hq6iQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 04 Jun 2026 15:39:32 +0900
Subject: [PATCH v3] ui/cocoa: Use qemu_input_map_osx_to_linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-osx-v3-1-453b4ee0e072@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMSw4CIRAFrzLptRgaJI6uvIeZBfJxeiEYMITJh
 LuLJC7r5VXtkF0il+E67ZBcoUwxdJCHCcyqw9Mxsp1BcKE4IrKYK+M4S2e8Esg99Oc7OU91VO5
 L55XyJ6ZtRIv4rX9fDb8Ihkwb+ZCzvSCeTzert0D1aOILltbaF4h2YlCXAAAA
X-Change-ID: 20250111-osx-0183ecf5210f
To: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=6819;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=QKyBFJQFMyW9TtSZpljtNTCytut5HjQMPY8SgHuVDWg=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5aiXN2H4t2KTcJrTy8V0AnyOJQRGZJYySpVI1oZanpoa
 fzMwyUdpSwMYlwMsmKKLClFu7k1oms/FSbEt8DMYWUCGcLAxSkAExE7xPA/5oNp37RewUf+D6Yf
 u9ex71517/E/q199z3Kd2Xzn0NSjQgz/zF+Hu5/Rib4QHrrq+OkC95rtjeLyr/wPn7qbk3LiRdo
 LDgA=
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

ui/cocoa used to have a conversion table from macOS keycode to Linux
key code. It is an unnecessary redundancy as ui/input-keymap.c already
has such a table. Worse, I added an incorrect mapping of kVK_JIS_Eisu and
kVK_JIS_Kana with commit 708b72557ff5 ("ui/cocoa: Support unique keys of
JIS keyboards").

According to the following documentations, the definitions in
ui/keycodemapdb/keymaps.csv, which ui/input-keymap.c uses, are correct:
https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang1?language=objc
https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang2?language=objc
https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/keyboard-japan-ime

Use qemu_input_map_osx_to_linux to eliminate the redundancy and
incorrect mappings.

Fixes: 708b72557ff5 ("ui/cocoa: Support unique keys of JIS keyboards")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
ui/cocoa used to have a conversion table from macOS keycode to Linux
key code. It is an unnecessary redundancy as ui/input-keymap.c already
has such a table. Worse, I added an incorrect mapping of kVK_JIS_Eisu and
kVK_JIS_Kana with commit 708b72557ff5 ("ui/cocoa: Support unique keys of
JIS keyboards").

According to the following documentations, the definitions in
ui/keycodemapdb/keymaps.csv, which ui/input-keymap.c uses, are correct:
https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang1?language=objc
https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang2?language=objc
https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/keyboard-japan-ime

Use qemu_input_map_osx_to_linux to eliminate the redundancy and
incorrect mappings.
---
Changes in v3:
- Rebased.
- Link to v2: https://lore.kernel.org/r/20250115-osx-v2-1-ac3b38d91174@daynix.com
---
 ui/cocoa.m | 131 ++-----------------------------------------------------------
 1 file changed, 3 insertions(+), 128 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index c5e639ab98d6..e157ad01d851 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -141,138 +141,13 @@ static bool bool_with_bql(BoolCodeBlock block)
     return val;
 }
 
-// Mac to Linux conversion
-static const unsigned int mac_to_linux_map[] = {
-    [kVK_ANSI_A] = KEY_A,
-    [kVK_ANSI_B] = KEY_B,
-    [kVK_ANSI_C] = KEY_C,
-    [kVK_ANSI_D] = KEY_D,
-    [kVK_ANSI_E] = KEY_E,
-    [kVK_ANSI_F] = KEY_F,
-    [kVK_ANSI_G] = KEY_G,
-    [kVK_ANSI_H] = KEY_H,
-    [kVK_ANSI_I] = KEY_I,
-    [kVK_ANSI_J] = KEY_J,
-    [kVK_ANSI_K] = KEY_K,
-    [kVK_ANSI_L] = KEY_L,
-    [kVK_ANSI_M] = KEY_M,
-    [kVK_ANSI_N] = KEY_N,
-    [kVK_ANSI_O] = KEY_O,
-    [kVK_ANSI_P] = KEY_P,
-    [kVK_ANSI_Q] = KEY_Q,
-    [kVK_ANSI_R] = KEY_R,
-    [kVK_ANSI_S] = KEY_S,
-    [kVK_ANSI_T] = KEY_T,
-    [kVK_ANSI_U] = KEY_U,
-    [kVK_ANSI_V] = KEY_V,
-    [kVK_ANSI_W] = KEY_W,
-    [kVK_ANSI_X] = KEY_X,
-    [kVK_ANSI_Y] = KEY_Y,
-    [kVK_ANSI_Z] = KEY_Z,
-
-    [kVK_ANSI_0] = KEY_0,
-    [kVK_ANSI_1] = KEY_1,
-    [kVK_ANSI_2] = KEY_2,
-    [kVK_ANSI_3] = KEY_3,
-    [kVK_ANSI_4] = KEY_4,
-    [kVK_ANSI_5] = KEY_5,
-    [kVK_ANSI_6] = KEY_6,
-    [kVK_ANSI_7] = KEY_7,
-    [kVK_ANSI_8] = KEY_8,
-    [kVK_ANSI_9] = KEY_9,
-
-    [kVK_ANSI_Grave] = KEY_GRAVE,
-    [kVK_ANSI_Minus] = KEY_MINUS,
-    [kVK_ANSI_Equal] = KEY_EQUAL,
-    [kVK_Delete] = KEY_BACKSPACE,
-    [kVK_CapsLock] = KEY_CAPSLOCK,
-    [kVK_Tab] = KEY_TAB,
-    [kVK_Return] = KEY_ENTER,
-    [kVK_ANSI_LeftBracket] = KEY_LEFTBRACE,
-    [kVK_ANSI_RightBracket] = KEY_RIGHTBRACE,
-    [kVK_ANSI_Backslash] = KEY_BACKSLASH,
-    [kVK_ANSI_Semicolon] = KEY_SEMICOLON,
-    [kVK_ANSI_Quote] = KEY_APOSTROPHE,
-    [kVK_ANSI_Comma] = KEY_COMMA,
-    [kVK_ANSI_Period] = KEY_DOT,
-    [kVK_ANSI_Slash] = KEY_SLASH,
-    [kVK_Space] = KEY_SPACE,
-
-    [kVK_ANSI_Keypad0] = KEY_KP0,
-    [kVK_ANSI_Keypad1] = KEY_KP1,
-    [kVK_ANSI_Keypad2] = KEY_KP2,
-    [kVK_ANSI_Keypad3] = KEY_KP3,
-    [kVK_ANSI_Keypad4] = KEY_KP4,
-    [kVK_ANSI_Keypad5] = KEY_KP5,
-    [kVK_ANSI_Keypad6] = KEY_KP6,
-    [kVK_ANSI_Keypad7] = KEY_KP7,
-    [kVK_ANSI_Keypad8] = KEY_KP8,
-    [kVK_ANSI_Keypad9] = KEY_KP9,
-    [kVK_ANSI_KeypadDecimal] = KEY_KPDOT,
-    [kVK_ANSI_KeypadEnter] = KEY_KPENTER,
-    [kVK_ANSI_KeypadPlus] = KEY_KPPLUS,
-    [kVK_ANSI_KeypadMinus] = KEY_KPMINUS,
-    [kVK_ANSI_KeypadMultiply] = KEY_KPASTERISK,
-    [kVK_ANSI_KeypadDivide] = KEY_KPSLASH,
-    [kVK_ANSI_KeypadEquals] = KEY_KPEQUAL,
-    [kVK_ANSI_KeypadClear] = KEY_NUMLOCK,
-
-    [kVK_UpArrow] = KEY_UP,
-    [kVK_DownArrow] = KEY_DOWN,
-    [kVK_LeftArrow] = KEY_LEFT,
-    [kVK_RightArrow] = KEY_RIGHT,
-
-    [kVK_Help] = KEY_INSERT,
-    [kVK_Home] = KEY_HOME,
-    [kVK_PageUp] = KEY_PAGEUP,
-    [kVK_PageDown] = KEY_PAGEDOWN,
-    [kVK_End] = KEY_END,
-    [kVK_ForwardDelete] = KEY_DELETE,
-
-    [kVK_Escape] = KEY_ESC,
-
-    /* The Power key can't be used directly because the operating system uses
-     * it. This key can be emulated by using it in place of another key such as
-     * F1. Don't forget to disable the real key binding.
-     */
-    /* [kVK_F1] = KEY_POWER, */
-
-    [kVK_F1] = KEY_F1,
-    [kVK_F2] = KEY_F2,
-    [kVK_F3] = KEY_F3,
-    [kVK_F4] = KEY_F4,
-    [kVK_F5] = KEY_F5,
-    [kVK_F6] = KEY_F6,
-    [kVK_F7] = KEY_F7,
-    [kVK_F8] = KEY_F8,
-    [kVK_F9] = KEY_F9,
-    [kVK_F10] = KEY_F10,
-    [kVK_F11] = KEY_F11,
-    [kVK_F12] = KEY_F12,
-    [kVK_F13] = KEY_SYSRQ,
-    [kVK_F14] = KEY_SCROLLLOCK,
-    [kVK_F15] = KEY_PAUSE,
-
-    // JIS keyboards only
-    [kVK_JIS_Yen] = KEY_YEN,
-    [kVK_JIS_Underscore] = KEY_RO,
-    [kVK_JIS_KeypadComma] = KEY_KPCOMMA,
-    [kVK_JIS_Eisu] = KEY_MUHENKAN,
-    [kVK_JIS_Kana] = KEY_HENKAN,
-
-    /*
-     * The eject and volume keys can't be used here because they are handled at
-     * a lower level than what an Application can see.
-     */
-};
-
-static unsigned int cocoa_keycode_to_linux(int keycode)
+static int cocoa_keycode_to_linux(int keycode)
 {
-    if (ARRAY_SIZE(mac_to_linux_map) <= keycode) {
+    if (qemu_input_map_osx_to_linux_len <= keycode) {
         error_report("(cocoa) warning unknown keycode 0x%x", keycode);
         return 0;
     }
-    return mac_to_linux_map[keycode];
+    return qemu_input_map_osx_to_linux[keycode];
 }
 
 /* Displays an alert dialog box with the specified message */

---
base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
change-id: 20250111-osx-0183ecf5210f

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


