Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAA4CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3wV-0001EY-J6; Thu, 21 May 2026 10:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3vn-00082T-VI
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3vm-0002il-8O
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjoBPmei4647K9iNewDWHgX2To85h2zBJDJVBwfPIWo=;
 b=cZxiyNm+9qjBUjN5hcbUEAf0E7GYa+64ecLX+8ofIKdKr22F2U7927KuDTzNbsA516RUtf
 fVceWmwRvJPm0qqe96owKu3ZSzTKz0L6pMKkLkt7q9Zi++5qWj/DZz1h9lOUNwnDsl/6Ho
 dJdyvh9tdK+Qf98J62b7Mvt/sEGiQLg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-CmQZ4LOcNzmG3PK0em6-UQ-1; Thu,
 21 May 2026 09:59:17 -0400
X-MC-Unique: CmQZ4LOcNzmG3PK0em6-UQ-1
X-Mimecast-MFC-AGG-ID: CmQZ4LOcNzmG3PK0em6-UQ_1779371955
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50B6918005BE; Thu, 21 May 2026 13:59:15 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 578461800352; Thu, 21 May 2026 13:59:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL v2 35/38] qemu-keymap: Use Linux key codes
Date: Thu, 21 May 2026 17:55:46 +0400
Message-ID: <20260521135551.1752945-36-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-ID: <20260520-input-v3-27-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 qemu-keymap.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index d4dccf456ef..d63b6be8ce3 100644
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


