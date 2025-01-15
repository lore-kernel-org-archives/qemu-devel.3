Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B360CC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2AG-0006ay-HS; Wed, 15 Jan 2025 07:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY2AC-0006Z7-7L
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:06:25 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY2A5-0000YF-PW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:06:20 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso112740995ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 04:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736942776; x=1737547576;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9vxz7RIhvN/lfoDLKobSUYEh7xaDg1HDK5A2IR5Jlvs=;
 b=OFio1n6UUBTkiC0zMi5clDGULwwWrzbNk4wuLTD+sRYg5V0HGhbnesAc87tQ5Bwe57
 1lazCA8qdTYvEDoPXfO0TW53EU2G08U1qjCgEFgdZdXBdx8zKk2QebGfOKjPx20mqK7v
 E03hRxw1j8LbZDKgDHHQsSN1bEwT7a2zKnajAZnUD7ghUSCL9y/iLinS7Vu5AGxjaWH9
 xMYY2SqcGGP8vBN1FNcyTbQSaltD0vgf/Is5lSbqJVcvUhUL3iITfl3bfvw3o+3iD04w
 m7tTx6ZBavcpsDeCG2yWLgXEpmjZGMfLvSqoU66p7Hv1Cwq0xI90Tc8aU8+y8JJL9DpB
 ps9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736942776; x=1737547576;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9vxz7RIhvN/lfoDLKobSUYEh7xaDg1HDK5A2IR5Jlvs=;
 b=bJvWqVHFAAijKvVooEDY8J8W7DAmcTrSBAPXYz888odXPlMZxWXeYuxHBk8W7V3N33
 rQy3KM4bc0Id4trBdARco1m9B5zNt08RyYErussG4TENEJyTGaq6nGZ8Bear1urcFdEw
 jXjbZH2PnVb2Vze6Vx/9Nb3NVQ85fA/jOeJBJXzYd4uGvOiHTnDSePSWI73iLApQd8lA
 4XUdnEdAl8rxkQ41W7tJQROIs6knvh2ho92rV1BV1Wa5FpR0HvTY/azeIDnA9UAXjvap
 7bWOnW+1WOev7U8vggcDeGq4NNAJ0QPfVmx/AE3CXkQfmcXYUxjwZ7VRaoE4yTLAJiCk
 d9wQ==
X-Gm-Message-State: AOJu0YxkqK2mgCex8WxUg34N0E8Q2SQckfiuOWae3DWoLzf49mUlMd28
 Kg39NQlq+0wo70O5naJ0LMWQZmEy9qwRVi5D1aCTRn68VZH5BE/LbYTrxezJyoc=
X-Gm-Gg: ASbGncvlIB72mhBdRMYTxsiLrFDPvYF2gMIcJVju/62pGJGli+FO/MoKnA6K/cd58aV
 wLtNZn4RxzPwHxL8RjtBRTAB64nvQxq2PvYDC1j2Uw9CiOr43YiS2YDcV7Q13w4N62Ys0JxuPAn
 M8lUwLolT7daNlvibwyRyDhkltT2HHCwrNNzKFw4SvKZwpdQPNYN1rqYRCgQVO4xZVcm5pKPHEI
 DzF3AGfqZu64uQTUhxidcGALPRtr4vxJehf+3GLsnhP3M6DKQbE/KmixtpF
X-Google-Smtp-Source: AGHT+IH74Mp66N3/gwxuUt1sQbNeCQPWo3F4igKz0NSm6AnfwlAuLJ8INpmbaDTHYPsR76H7f0IB3Q==
X-Received: by 2002:a17:902:d2d2:b0:21a:8382:fcbb with SMTP id
 d9443c01a7336-21a83f5db86mr448967775ad.25.1736942776097; 
 Wed, 15 Jan 2025 04:06:16 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a9f21ada1sm81545585ad.138.2025.01.15.04.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 04:06:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 21:06:08 +0900
Subject: [PATCH v2] ui/cocoa: Use qemu_input_map_osx_to_qcode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-osx-v2-1-ac3b38d91174@daynix.com>
X-B4-Tracking: v=1; b=H4sIAK+kh2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0ND3fziCl0DQwvj1OQ0UyNDgzQloMqCotS0zAqwKdGxtbUA8xhl1lU
 AAAA=
To: Gerd Hoffmann <kraxel@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ui/cocoa used to have a conversion table from macOS keycode to QKeyCode.
It is an unnecessary redundancy as ui/input-keymap.c already has such a
table. Worse, I added an incorrect mapping of kVK_JIS_Eisu and
kVK_JIS_Kana with commit 708b72557ff5 ("ui/cocoa: Support unique keys of
JIS keyboards").

According to the following documentations, the definitions in
ui/keycodemapdb/keymaps.csv, which ui/input-keymap.c uses, are correct:
https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang1?language=objc
https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang2?language=objc
https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/keyboard-japan-ime

Use qemu_input_map_osx_to_qcode to eliminate the redundancy and
incorrect mappings.

Fixes: 708b72557ff5 ("ui/cocoa: Support unique keys of JIS keyboards")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 129 +------------------------------------------------------------
 1 file changed, 2 insertions(+), 127 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 3a88535374de..e22c3c925678 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -139,138 +139,13 @@ static bool bool_with_bql(BoolCodeBlock block)
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
-
-    /* The Power key can't be used directly because the operating system uses
-     * it. This key can be emulated by using it in place of another key such as
-     * F1. Don't forget to disable the real key binding.
-     */
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
-
-    // JIS keyboards only
-    [kVK_JIS_Yen] = Q_KEY_CODE_YEN,
-    [kVK_JIS_Underscore] = Q_KEY_CODE_RO,
-    [kVK_JIS_KeypadComma] = Q_KEY_CODE_KP_COMMA,
-    [kVK_JIS_Eisu] = Q_KEY_CODE_MUHENKAN,
-    [kVK_JIS_Kana] = Q_KEY_CODE_HENKAN,
-
-    /*
-     * The eject and volume keys can't be used here because they are handled at
-     * a lower level than what an Application can see.
-     */
-};
-
 static int cocoa_keycode_to_qemu(int keycode)
 {
-    if (ARRAY_SIZE(mac_to_qkeycode_map) <= keycode) {
+    if (qemu_input_map_osx_to_qcode_len <= keycode) {
         error_report("(cocoa) warning unknown keycode 0x%x", keycode);
         return 0;
     }
-    return mac_to_qkeycode_map[keycode];
+    return qemu_input_map_osx_to_qcode[keycode];
 }
 
 /* Displays an alert dialog box with the specified message */

---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20250111-osx-0183ecf5210f

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


