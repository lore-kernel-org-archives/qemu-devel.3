Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BC0CD5BAC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPaks-0004Hj-CI; Wed, 20 May 2026 02:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPak0-0003Yv-17; Wed, 20 May 2026 02:49:17 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajv-0001Na-VQ; Wed, 20 May 2026 02:49:15 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbq096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=v5oajKDJ2YP9bhcBfkSr4KL2IJFfpzeJ/7HwEax+6jY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259700; v=1;
 b=XdHOHwArldSYnTOzcAE2IuevMxoOql51Y+NXPSdrIjvmqKsamS9kMxdJgwWbCaDm
 CfN9e616J4RdNqi57nQOk+Z1haNeSS8y6nMbdRG4AirX8C7862LhjPZLJsABQma7
 ZXEdkFwsdT5WaxsXv13kUPAVONn3cVsoBdK0NoRxiynJyqXUCT0WY8cvQrVRSHr7
 iOA0yNHx+GO3j8PU/kDPlxlhCxLDUifqG1t7aWFlvAbfXZNRC19aRnoC5WcnhZB8
 DS9Tt+ZVgTcIE1hQbg8BsYAsiM2wTk+lvWrRmPR0ch+tGljwfvKolzsn8blaZB8p
 wk94BT0dZulJhon0Vz8/0w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:48:12 +0900
Subject: [PATCH v3 29/29] ui/input: Remove unused QKeyCode helpers and keymaps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-29-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11471;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=SryqR7LwMB3RHLuoFp+AeD4HulyP9Esk0OCyFepCs1Y=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpE617ekyfRWx7k+lkQ7F/jEu2VMPur1/qxi5OfrM7
 LnpdYYdpSwMYlwMsmKKLClFu7k1oms/FSbEt8DMYWUCGcLAxSkAE2mVYfinvGrRbFvVh6KmbMYb
 3l/ldJP/wT4t0NHgNaO4bbmHmLsJI8Ph62smyBQwZXElOmxfUqM5tWNbm/rLD6rnn985e6B6+mR
 OAA==
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

Their users have migrated to Linux key codes.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/input.h     | 50 --------------------------------------------------
 tools/qemu-vnc/input.c |  6 ------
 ui/input-keymap.c      | 39 ---------------------------------------
 ui/input.c             | 16 ----------------
 ui/meson.build         | 15 ---------------
 5 files changed, 126 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index e76dd4b172aa..ea2d944a7ed5 100644
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
index 90e2e79d1ea7..6fb73b312483 100644
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
index 2b77ef09fd66..ec2a1fbc1a95 100644
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
index 68c7ac6f1ccb..c013cd9f7e04 100644
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
index 1504e27248f3..bb01f0728e28 100644
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


