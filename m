Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D548CD5BB4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3wR-0000lD-5A; Thu, 21 May 2026 10:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3w1-00083n-VS
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3vw-0002jc-4x
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMKHnD0kVwDZLeOgTTp7vD15iCZ6M7vbOvET2Qvd84w=;
 b=ILtWJegBwgrRJ0TgkYJ9777jBuXVlAtuKkoSLD+30z0aQsCpH/0bT/v6JqzmDbI933bXwQ
 jvi2LWWUb1NRgX4ztnWc6YOExLIFWlzm0EwNlOBa0nuYuY/6w34q/DqMC2hR0EYkD7Akwy
 3q8JmEHYReWcsvLx8qLEniny3xbY7Jc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-Jm9XGy3cN9-ipTwBymjWDQ-1; Thu,
 21 May 2026 09:59:27 -0400
X-MC-Unique: Jm9XGy3cN9-ipTwBymjWDQ-1
X-Mimecast-MFC-AGG-ID: Jm9XGy3cN9-ipTwBymjWDQ_1779371966
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2558D18002F3; Thu, 21 May 2026 13:59:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2AAE91956053; Thu, 21 May 2026 13:59:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 37/38] ui/input: Remove unused QKeyCode helpers and keymaps
Date: Thu, 21 May 2026 17:55:48 +0400
Message-ID: <20260521135551.1752945-38-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Their users have migrated to Linux key codes.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-29-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/input.h     | 50 ------------------------------------------
 tools/qemu-vnc/input.c |  6 -----
 ui/input-keymap.c      | 39 --------------------------------
 ui/input.c             | 16 --------------
 ui/meson.build         | 15 -------------
 5 files changed, 126 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index e76dd4b172a..ea2d944a7ed 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -58,18 +58,13 @@ void qemu_input_event_send_impl(QemuConsole *src, QemuInputEvent *evt);
 void qemu_input_event_sync(void);
 void qemu_input_event_sync_impl(void);
 
-void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down);
 void qemu_input_event_send_key_linux(QemuConsole *src, unsigned int lnx,
                                      bool down);
 void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down);
-void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down);
 void qemu_input_event_send_key_delay(uint32_t delay_ms);
 int qemu_input_key_number_to_qcode(unsigned int nr);
 unsigned int qemu_input_key_number_to_linux(unsigned int nr);
-int qemu_input_key_value_to_number(const KeyValue *value);
-int qemu_input_key_value_to_qcode(const KeyValue *value);
 unsigned int qemu_input_key_value_to_linux(const KeyValue *value);
-int qemu_input_qcode_to_scancode(QKeyCode qcode, bool down, int *codes);
 int qemu_input_linux_to_scancode(unsigned int lnx, bool down, int *codes);
 int qemu_input_linux_to_qcode(unsigned int lnx);
 
@@ -109,96 +104,51 @@ void qemu_input_check_mode_change(void);
 void qemu_add_mouse_mode_change_notifier(Notifier *notify);
 void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
 
-extern const guint qemu_input_map_atset1_to_qcode_len;
-extern const guint16 qemu_input_map_atset1_to_qcode[];
-
 extern const guint qemu_input_map_atset1_to_linux_len;
 extern const guint16 qemu_input_map_atset1_to_linux[];
 
 extern const guint qemu_input_map_linux_to_qcode_len;
 extern const guint16 qemu_input_map_linux_to_qcode[];
 
-extern const guint qemu_input_map_qcode_to_atset1_len;
-extern const guint16 qemu_input_map_qcode_to_atset1[];
-
 extern const guint qemu_input_map_linux_to_atset1_len;
 extern const guint16 qemu_input_map_linux_to_atset1[];
 
-extern const guint qemu_input_map_qcode_to_atset2_len;
-extern const guint16 qemu_input_map_qcode_to_atset2[];
-
 extern const guint qemu_input_map_linux_to_atset2_len;
 extern const guint16 qemu_input_map_linux_to_atset2[];
 
-extern const guint qemu_input_map_qcode_to_atset3_len;
-extern const guint16 qemu_input_map_qcode_to_atset3[];
-
 extern const guint qemu_input_map_linux_to_atset3_len;
 extern const guint16 qemu_input_map_linux_to_atset3[];
 
 extern const guint qemu_input_map_qcode_to_linux_len;
 extern const guint16 qemu_input_map_qcode_to_linux[];
 
-extern const guint qemu_input_map_qcode_to_qnum_len;
-extern const guint16 qemu_input_map_qcode_to_qnum[];
-
 extern const guint qemu_input_map_linux_to_qnum_len;
 extern const guint16 qemu_input_map_linux_to_qnum[];
 
-extern const guint qemu_input_map_qcode_to_sun_len;
-extern const guint16 qemu_input_map_qcode_to_sun[];
-
 extern const guint qemu_input_map_linux_to_sun_len;
 extern const guint16 qemu_input_map_linux_to_sun[];
 
-extern const guint qemu_input_map_qnum_to_qcode_len;
-extern const guint16 qemu_input_map_qnum_to_qcode[];
-
 extern const guint qemu_input_map_qnum_to_linux_len;
 extern const guint16 qemu_input_map_qnum_to_linux[];
 
-extern const guint qemu_input_map_usb_to_qcode_len;
-extern const guint16 qemu_input_map_usb_to_qcode[];
-
 extern const guint qemu_input_map_usb_to_linux_len;
 extern const guint16 qemu_input_map_usb_to_linux[];
 
-extern const guint qemu_input_map_win32_to_qcode_len;
-extern const guint16 qemu_input_map_win32_to_qcode[];
-
 extern const guint qemu_input_map_win32_to_linux_len;
 extern const guint16 qemu_input_map_win32_to_linux[];
 
-extern const guint qemu_input_map_x11_to_qcode_len;
-extern const guint16 qemu_input_map_x11_to_qcode[];
-
 extern const guint qemu_input_map_x11_to_linux_len;
 extern const guint16 qemu_input_map_x11_to_linux[];
 
-extern const guint qemu_input_map_xorgevdev_to_qcode_len;
-extern const guint16 qemu_input_map_xorgevdev_to_qcode[];
-
-extern const guint qemu_input_map_xorgkbd_to_qcode_len;
-extern const guint16 qemu_input_map_xorgkbd_to_qcode[];
-
 extern const guint qemu_input_map_xorgkbd_to_linux_len;
 extern const guint16 qemu_input_map_xorgkbd_to_linux[];
 
-extern const guint qemu_input_map_xorgxquartz_to_qcode_len;
-extern const guint16 qemu_input_map_xorgxquartz_to_qcode[];
-
 extern const guint qemu_input_map_xorgxquartz_to_linux_len;
 extern const guint16 qemu_input_map_xorgxquartz_to_linux[];
 
-extern const guint qemu_input_map_xorgxwin_to_qcode_len;
-extern const guint16 qemu_input_map_xorgxwin_to_qcode[];
-
 extern const guint qemu_input_map_xorgxwin_to_linux_len;
 extern const guint16 qemu_input_map_xorgxwin_to_linux[];
 
-extern const guint qemu_input_map_osx_to_qcode_len;
-extern const guint16 qemu_input_map_osx_to_qcode[];
-
 extern const guint qemu_input_map_osx_to_linux_len;
 extern const guint16 qemu_input_map_osx_to_linux[];
 
diff --git a/tools/qemu-vnc/input.c b/tools/qemu-vnc/input.c
index 90e2e79d1ea..6fb73b31248 100644
--- a/tools/qemu-vnc/input.c
+++ b/tools/qemu-vnc/input.c
@@ -81,12 +81,6 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms)
 {
 }
 
-void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down)
-{
-    unsigned int lnx = qemu_input_map_qcode_to_linux[q];
-    qemu_input_event_send_key_linux(src, lnx, down);
-}
-
 void qemu_input_event_send_key_linux(QemuConsole *src, unsigned int lnx,
                                      bool down)
 {
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 2b77ef09fd6..ec2a1fbc1a9 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -4,36 +4,21 @@
 
 #include "standard-headers/linux/input.h"
 
-#include "ui/input-keymap-atset1-to-qcode.c.inc"
 #include "ui/input-keymap-atset1-to-linux.c.inc"
 #include "ui/input-keymap-linux-to-qcode.c.inc"
-#include "ui/input-keymap-qcode-to-atset1.c.inc"
 #include "ui/input-keymap-linux-to-atset1.c.inc"
-#include "ui/input-keymap-qcode-to-atset2.c.inc"
 #include "ui/input-keymap-linux-to-atset2.c.inc"
-#include "ui/input-keymap-qcode-to-atset3.c.inc"
 #include "ui/input-keymap-linux-to-atset3.c.inc"
 #include "ui/input-keymap-qcode-to-linux.c.inc"
-#include "ui/input-keymap-qcode-to-qnum.c.inc"
 #include "ui/input-keymap-linux-to-qnum.c.inc"
-#include "ui/input-keymap-qcode-to-sun.c.inc"
 #include "ui/input-keymap-linux-to-sun.c.inc"
-#include "ui/input-keymap-qnum-to-qcode.c.inc"
 #include "ui/input-keymap-qnum-to-linux.c.inc"
-#include "ui/input-keymap-usb-to-qcode.c.inc"
 #include "ui/input-keymap-usb-to-linux.c.inc"
-#include "ui/input-keymap-win32-to-qcode.c.inc"
 #include "ui/input-keymap-win32-to-linux.c.inc"
-#include "ui/input-keymap-x11-to-qcode.c.inc"
 #include "ui/input-keymap-x11-to-linux.c.inc"
-#include "ui/input-keymap-xorgevdev-to-qcode.c.inc"
-#include "ui/input-keymap-xorgkbd-to-qcode.c.inc"
 #include "ui/input-keymap-xorgkbd-to-linux.c.inc"
-#include "ui/input-keymap-xorgxquartz-to-qcode.c.inc"
 #include "ui/input-keymap-xorgxquartz-to-linux.c.inc"
-#include "ui/input-keymap-xorgxwin-to-qcode.c.inc"
 #include "ui/input-keymap-xorgxwin-to-linux.c.inc"
-#include "ui/input-keymap-osx-to-qcode.c.inc"
 #include "ui/input-keymap-osx-to-linux.c.inc"
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
@@ -44,19 +29,6 @@ int qemu_input_linux_to_qcode(unsigned int lnx)
     return qemu_input_map_linux_to_qcode[lnx];
 }
 
-int qemu_input_key_value_to_number(const KeyValue *value)
-{
-    if (value->type == KEY_VALUE_KIND_QCODE) {
-        if (value->u.qcode.data >= qemu_input_map_qcode_to_qnum_len) {
-            return 0;
-        }
-        return qemu_input_map_qcode_to_qnum[value->u.qcode.data];
-    } else {
-        assert(value->type == KEY_VALUE_KIND_NUMBER);
-        return value->u.number.data;
-    }
-}
-
 int qemu_input_key_number_to_qcode(unsigned int nr)
 {
     return qemu_input_linux_to_qcode(qemu_input_key_number_to_linux(nr));
@@ -70,11 +42,6 @@ unsigned int qemu_input_key_number_to_linux(unsigned int nr)
     return qemu_input_map_qnum_to_linux[nr];
 }
 
-int qemu_input_key_value_to_qcode(const KeyValue *value)
-{
-    return qemu_input_linux_to_qcode(qemu_input_key_value_to_linux(value));
-}
-
 unsigned int qemu_input_key_value_to_linux(const KeyValue *value)
 {
     switch (value->type) {
@@ -89,12 +56,6 @@ unsigned int qemu_input_key_value_to_linux(const KeyValue *value)
     }
 }
 
-int qemu_input_qcode_to_scancode(QKeyCode qcode, bool down, int *codes)
-{
-    return qemu_input_linux_to_scancode(qemu_input_map_qcode_to_linux[qcode],
-                                        down, codes);
-}
-
 int qemu_input_linux_to_scancode(unsigned int lnx, bool down, int *codes)
 {
     int keycode = lnx < qemu_input_map_linux_to_qnum_len ?
diff --git a/ui/input.c b/ui/input.c
index 68c7ac6f1cc..c013cd9f7e0 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -365,14 +365,6 @@ void qemu_input_event_sync(void)
     replay_input_sync_event();
 }
 
-void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
-{
-    unsigned int lnx = qemu_input_key_value_to_linux(key);
-
-    g_free(key);
-    qemu_input_event_send_key_linux(src, lnx, down);
-}
-
 void qemu_input_event_send_key_linux(QemuConsole *src, unsigned int lnx,
                                      bool down)
 {
@@ -399,14 +391,6 @@ void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down)
     qemu_input_event_send_key_linux(src, lnx, down);
 }
 
-void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down)
-{
-    KeyValue *key = g_new0(KeyValue, 1);
-    key->type = KEY_VALUE_KIND_QCODE;
-    key->u.qcode.data = q;
-    qemu_input_event_send_key(src, key, down);
-}
-
 void qemu_input_event_send_key_delay(uint32_t delay_ms)
 {
     if (!runstate_is_running() && !runstate_check(RUN_STATE_SUSPENDED)) {
diff --git a/ui/meson.build b/ui/meson.build
index 1504e27248f..bb01f0728e2 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -1,34 +1,19 @@
 keymaps = [
-  ['atset1', 'qcode'],
   ['atset1', 'linux'],
   ['linux', 'qcode'],
-  ['qcode', 'atset1'],
   ['linux', 'atset1'],
-  ['qcode', 'atset2'],
   ['linux', 'atset2'],
-  ['qcode', 'atset3'],
   ['linux', 'atset3'],
   ['qcode', 'linux'],
-  ['qcode', 'qnum'],
   ['linux', 'qnum'],
-  ['qcode', 'sun'],
   ['linux', 'sun'],
-  ['qnum', 'qcode'],
   ['qnum', 'linux'],
-  ['usb', 'qcode'],
   ['usb', 'linux'],
-  ['win32', 'qcode'],
   ['win32', 'linux'],
-  ['x11', 'qcode'],
   ['x11', 'linux'],
-  ['xorgevdev', 'qcode'],
-  ['xorgkbd', 'qcode'],
   ['xorgkbd', 'linux'],
-  ['xorgxquartz', 'qcode'],
   ['xorgxquartz', 'linux'],
-  ['xorgxwin', 'qcode'],
   ['xorgxwin', 'linux'],
-  ['osx', 'qcode'],
   ['osx', 'linux'],
 ]
 
-- 
2.54.0


