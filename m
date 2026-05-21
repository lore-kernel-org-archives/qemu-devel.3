Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0F1CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3us-0005Ta-9I; Thu, 21 May 2026 09:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3um-00058c-FH
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3uk-0002Hl-Nv
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97IDxt5ABrrAZRFp6P2Tjgy9nMAKPgPJxl//lYafjqE=;
 b=AslxClYHxSyHE82V/U2pYc/2oGJ/nZBiCWZYFJn4EsPnre7yjruc4m+6c6pAW+LRveW9tN
 yGWsS639us3XSUBHhbSZHNAZDclIBZtXYevt/IuOhEyurxdpoI7RdP7owFQqce605aAPEZ
 AGpe1l/ZedO5wslPa5U9igJmqufv2rI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-JfJP8dxaPWW4OmJP3daOWA-1; Thu,
 21 May 2026 09:58:10 -0400
X-MC-Unique: JfJP8dxaPWW4OmJP3daOWA-1
X-Mimecast-MFC-AGG-ID: JfJP8dxaPWW4OmJP3daOWA_1779371888
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 800CC180056E; Thu, 21 May 2026 13:58:08 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87BF61684; Thu, 21 May 2026 13:58:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <th.huth+qemu@posteo.eu>
Subject: [PULL v2 23/38] hw/m68k/next-kbd: Use Linux key codes
Date: Thu, 21 May 2026 17:55:34 +0400
Message-ID: <20260521135551.1752945-24-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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
Message-ID: <20260520-input-v3-15-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/m68k/next-kbd.c | 118 ++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 7efbd806b7c..7be5ab2fb79 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -31,6 +31,7 @@
 #include "qemu/log.h"
 #include "hw/core/sysbus.h"
 #include "hw/m68k/next-cube.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/console.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
@@ -165,59 +166,59 @@ static const MemoryRegionOps kbd_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static const int qcode_to_nextkbd_keycode[] = {
-    [Q_KEY_CODE_ESC]           = 0x49,
-    [Q_KEY_CODE_1]             = 0x4a,
-    [Q_KEY_CODE_2]             = 0x4b,
-    [Q_KEY_CODE_3]             = 0x4c,
-    [Q_KEY_CODE_4]             = 0x4d,
-    [Q_KEY_CODE_5]             = 0x50,
-    [Q_KEY_CODE_6]             = 0x4f,
-    [Q_KEY_CODE_7]             = 0x4e,
-    [Q_KEY_CODE_8]             = 0x1e,
-    [Q_KEY_CODE_9]             = 0x1f,
-    [Q_KEY_CODE_0]             = 0x20,
-    [Q_KEY_CODE_MINUS]         = 0x1d,
-    [Q_KEY_CODE_EQUAL]         = 0x1c,
-    [Q_KEY_CODE_BACKSPACE]     = 0x1b,
-
-    [Q_KEY_CODE_Q]             = 0x42,
-    [Q_KEY_CODE_W]             = 0x43,
-    [Q_KEY_CODE_E]             = 0x44,
-    [Q_KEY_CODE_R]             = 0x45,
-    [Q_KEY_CODE_T]             = 0x48,
-    [Q_KEY_CODE_Y]             = 0x47,
-    [Q_KEY_CODE_U]             = 0x46,
-    [Q_KEY_CODE_I]             = 0x06,
-    [Q_KEY_CODE_O]             = 0x07,
-    [Q_KEY_CODE_P]             = 0x08,
-    [Q_KEY_CODE_RET]           = 0x2a,
-    [Q_KEY_CODE_A]             = 0x39,
-    [Q_KEY_CODE_S]             = 0x3a,
-
-    [Q_KEY_CODE_D]             = 0x3b,
-    [Q_KEY_CODE_F]             = 0x3c,
-    [Q_KEY_CODE_G]             = 0x3d,
-    [Q_KEY_CODE_H]             = 0x40,
-    [Q_KEY_CODE_J]             = 0x3f,
-    [Q_KEY_CODE_K]             = 0x3e,
-    [Q_KEY_CODE_L]             = 0x2d,
-    [Q_KEY_CODE_SEMICOLON]     = 0x2c,
-    [Q_KEY_CODE_APOSTROPHE]    = 0x2b,
-    [Q_KEY_CODE_GRAVE_ACCENT]  = 0x26,
-    [Q_KEY_CODE_Z]             = 0x31,
-    [Q_KEY_CODE_X]             = 0x32,
-    [Q_KEY_CODE_C]             = 0x33,
-    [Q_KEY_CODE_V]             = 0x34,
-
-    [Q_KEY_CODE_B]             = 0x35,
-    [Q_KEY_CODE_N]             = 0x37,
-    [Q_KEY_CODE_M]             = 0x36,
-    [Q_KEY_CODE_COMMA]         = 0x2e,
-    [Q_KEY_CODE_DOT]           = 0x2f,
-    [Q_KEY_CODE_SLASH]         = 0x30,
-
-    [Q_KEY_CODE_SPC]           = 0x38,
+static const int linux_to_nextkbd_keycode[] = {
+    [KEY_ESC]        = 0x49,
+    [KEY_1]          = 0x4a,
+    [KEY_2]          = 0x4b,
+    [KEY_3]          = 0x4c,
+    [KEY_4]          = 0x4d,
+    [KEY_5]          = 0x50,
+    [KEY_6]          = 0x4f,
+    [KEY_7]          = 0x4e,
+    [KEY_8]          = 0x1e,
+    [KEY_9]          = 0x1f,
+    [KEY_0]          = 0x20,
+    [KEY_MINUS]      = 0x1d,
+    [KEY_EQUAL]      = 0x1c,
+    [KEY_BACKSPACE]  = 0x1b,
+
+    [KEY_Q]          = 0x42,
+    [KEY_W]          = 0x43,
+    [KEY_E]          = 0x44,
+    [KEY_R]          = 0x45,
+    [KEY_T]          = 0x48,
+    [KEY_Y]          = 0x47,
+    [KEY_U]          = 0x46,
+    [KEY_I]          = 0x06,
+    [KEY_O]          = 0x07,
+    [KEY_P]          = 0x08,
+    [KEY_ENTER]      = 0x2a,
+    [KEY_A]          = 0x39,
+    [KEY_S]          = 0x3a,
+
+    [KEY_D]          = 0x3b,
+    [KEY_F]          = 0x3c,
+    [KEY_G]          = 0x3d,
+    [KEY_H]          = 0x40,
+    [KEY_J]          = 0x3f,
+    [KEY_K]          = 0x3e,
+    [KEY_L]          = 0x2d,
+    [KEY_SEMICOLON]  = 0x2c,
+    [KEY_APOSTROPHE] = 0x2b,
+    [KEY_GRAVE]      = 0x26,
+    [KEY_Z]          = 0x31,
+    [KEY_X]          = 0x32,
+    [KEY_C]          = 0x33,
+    [KEY_V]          = 0x34,
+
+    [KEY_B]          = 0x35,
+    [KEY_N]          = 0x37,
+    [KEY_M]          = 0x36,
+    [KEY_COMMA]      = 0x2e,
+    [KEY_DOT]        = 0x2f,
+    [KEY_SLASH]      = 0x30,
+
+    [KEY_SPACE]      = 0x38,
 };
 
 static void nextkbd_put_keycode(NextKBDState *s, int keycode)
@@ -246,15 +247,14 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src,
                           QemuInputEvent *evt)
 {
     NextKBDState *s = NEXTKBD(dev);
-    int qcode, keycode;
+    int keycode;
 
-    qcode = qemu_input_linux_to_qcode(evt->key.key);
-    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
+    if (evt->key.key >= ARRAY_SIZE(linux_to_nextkbd_keycode)) {
         return;
     }
 
     /* Shift key currently has no keycode, so handle separately */
-    if (qcode == Q_KEY_CODE_SHIFT) {
+    if (evt->key.key == KEY_LEFTSHIFT) {
         if (evt->key.down) {
             s->shift |= KD_LSHIFT;
         } else {
@@ -262,7 +262,7 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src,
         }
     }
 
-    if (qcode == Q_KEY_CODE_SHIFT_R) {
+    if (evt->key.key == KEY_RIGHTSHIFT) {
         if (evt->key.down) {
             s->shift |= KD_RSHIFT;
         } else {
@@ -270,7 +270,7 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src,
         }
     }
 
-    keycode = qcode_to_nextkbd_keycode[qcode];
+    keycode = linux_to_nextkbd_keycode[evt->key.key];
     if (!keycode) {
         return;
     }
-- 
2.54.0


