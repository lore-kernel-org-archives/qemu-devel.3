Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7496CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN70s-0004KQ-I4; Wed, 13 May 2026 06:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70T-00040l-41; Wed, 13 May 2026 06:40:04 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70M-0002MT-HJ; Wed, 13 May 2026 06:39:57 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64DAcPdp044648
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 May 2026 19:39:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1HZL/g+SoS2O30ERYe2Yb6nxo7jFOLr4qDArV1Di8vs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778668740; v=1;
 b=P01NLzRzzvogd8TC7cCmIkgRltpFT1xQ7Q6CTkL55ZJmzMiFpla7yteRqseZpuzo
 dos1VL2zDLgalmh21LTipFl3IosgQmS3wnuKWzfSWlCReOLuNixXZHp+jKoIfCwX
 uq2tuaI3DyhomGUmDokN3ciHe19++I9HLjggU7Po87xrI7w/IJ3n4g2YjDA4km6l
 KrGRb38iva0+uNqjuzF+O9grsu9+6/nOmupYgXW+zHs+ijaYuFA5KCcReLERqHVH
 YK6rR/DJm5D0LgezvseO3VkWUBYCz4sf0DP4VcyA9CKIe1ZKq4DMr70p2Ek5c4pU
 VeNn88+SVI09XX0bnthSLw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 13 May 2026 19:38:43 +0900
Subject: [PATCH v2 27/29] qemu-keymap: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-input-v2-27-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
References: <20260513-input-v2-0-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260513-input-v2-0-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4832;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=gcrDwacqS5bkEtnqJY5QTRr0nAfP9KdzJWUdu+r+4i4=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZLyO45gtd7fkffvbc5Ia1z1uGlvzpsDgTf/nYt+5z4k
 XtPIj787yhlYRDjYpAVU2RJKdrNrRFd+6kwIb4FZg4rE8gQBi5OAZjI7A8M/32OTpNPO6Fi7szE
 OLNvrhu/3qugmRJz/p1PlvrHcM7l7SOGPzwHs9JYmnl+2Hfb8lzPky1iDtc64vlbmrnr9KTrv11
 jOQA=
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
 qemu-keymap.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index d4dccf456ef3..d63b6be8ce32 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -11,6 +11,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/notify.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/input.h"
 
 #include <xkbcommon/xkbcommon.h>
@@ -32,19 +33,17 @@ static FILE *outfile;
 
 /* ------------------------------------------------------------------------ */
 
-static uint32_t qcode_to_number(uint32_t qcode)
+static uint32_t linux_to_number(uint32_t lnx)
 {
-    KeyValue keyvalue;
     uint32_t number;
 
-    keyvalue.type = KEY_VALUE_KIND_QCODE;
-    keyvalue.u.qcode.data = qcode;
-    number = qemu_input_key_value_to_number(&keyvalue);
+    assert(lnx < qemu_input_map_linux_to_qnum_len);
+    number = qemu_input_map_linux_to_qnum[lnx];
     assert(number != 0);
     return number;
 }
 
-static void print_sym(xkb_keysym_t sym, uint32_t qcode, const char *mod)
+static void print_sym(xkb_keysym_t sym, uint32_t lnx, const char *mod)
 {
     char name[64];
 
@@ -54,7 +53,7 @@ static void print_sym(xkb_keysym_t sym, uint32_t qcode, const char *mod)
     xkb_keysym_get_name(sym, name, sizeof(name));
 
     /* TODO: make ui/keymap.c parser accept QKeyCode names */
-    fprintf(outfile, "%s 0x%02x%s\n", name, qcode_to_number(qcode), mod);
+    fprintf(outfile, "%s 0x%02x%s\n", name, linux_to_number(lnx), mod);
 }
 
 static void walk_map(struct xkb_keymap *map, xkb_keycode_t code, void *data)
@@ -84,37 +83,37 @@ static void walk_map(struct xkb_keymap *map, xkb_keycode_t code, void *data)
     fprintf(outfile, "# evdev %d (0x%x), QKeyCode \"%s\", number 0x%x\n",
             evdev, evdev,
             QKeyCode_str(qcode),
-            qcode_to_number(qcode));
+            linux_to_number(evdev));
 
     /*
      * check which modifier states generate which keysyms
      */
     xkb_state_update_mask(state,  0, 0, 0,  0, 0, 0);
     kbase = xkb_state_key_get_one_sym(state, code);
-    print_sym(kbase, qcode, "");
+    print_sym(kbase, evdev, "");
 
     xkb_state_update_mask(state,  0, 0, numlock,  0, 0, 0);
     knumlock = xkb_state_key_get_one_sym(state, code);
     if (kbase != knumlock) {
-        print_sym(knumlock, qcode, " numlock");
+        print_sym(knumlock, evdev, " numlock");
     }
 
     xkb_state_update_mask(state,  shift, 0, 0,  0, 0, 0);
     kshift = xkb_state_key_get_one_sym(state, code);
     if (kbase != kshift && knumlock != kshift) {
-        print_sym(kshift, qcode, " shift");
+        print_sym(kshift, evdev, " shift");
     }
 
     xkb_state_update_mask(state,  altgr, 0, 0,  0, 0, 0);
     kaltgr = xkb_state_key_get_one_sym(state, code);
     if (kbase != kaltgr) {
-        print_sym(kaltgr, qcode, " altgr");
+        print_sym(kaltgr, evdev, " altgr");
     }
 
     xkb_state_update_mask(state,  altgr | shift, 0, 0,  0, 0, 0);
     kaltgrshift = xkb_state_key_get_one_sym(state, code);
     if (kshift != kaltgrshift && kaltgr != kaltgrshift) {
-        print_sym(kaltgrshift, qcode, " shift altgr");
+        print_sym(kaltgrshift, evdev, " shift altgr");
     }
 }
 
@@ -251,16 +250,16 @@ int main(int argc, char *argv[])
             "# keysyms.  So append them here.\n"
             "#\n"
             "\n");
-    print_sym(XKB_KEY_Print,            Q_KEY_CODE_SYSRQ,      "");
-    print_sym(XKB_KEY_Sys_Req,          Q_KEY_CODE_SYSRQ,      "");
-    print_sym(XKB_KEY_Execute,          Q_KEY_CODE_SYSRQ,      "");
+    print_sym(XKB_KEY_Print,            KEY_SYSRQ,    "");
+    print_sym(XKB_KEY_Sys_Req,          KEY_SYSRQ,    "");
+    print_sym(XKB_KEY_Execute,          KEY_SYSRQ,    "");
 
-    print_sym(XKB_KEY_KP_Decimal,       Q_KEY_CODE_KP_DECIMAL, " numlock");
-    print_sym(XKB_KEY_KP_Separator,     Q_KEY_CODE_KP_DECIMAL, " numlock");
+    print_sym(XKB_KEY_KP_Decimal,       KEY_KPDOT,    " numlock");
+    print_sym(XKB_KEY_KP_Separator,     KEY_KPDOT,    " numlock");
 
-    print_sym(XKB_KEY_Alt_R,            Q_KEY_CODE_ALT_R,      "");
-    print_sym(XKB_KEY_ISO_Level3_Shift, Q_KEY_CODE_ALT_R,      "");
-    print_sym(XKB_KEY_Mode_switch,      Q_KEY_CODE_ALT_R,      "");
+    print_sym(XKB_KEY_Alt_R,            KEY_RIGHTALT, "");
+    print_sym(XKB_KEY_ISO_Level3_Shift, KEY_RIGHTALT, "");
+    print_sym(XKB_KEY_Mode_switch,      KEY_RIGHTALT, "");
 
     fprintf(outfile,
             "\n"

-- 
2.54.0


