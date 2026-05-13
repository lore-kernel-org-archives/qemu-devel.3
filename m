Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416EBCD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN70e-0004Go-9U; Wed, 13 May 2026 06:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70P-00040I-09; Wed, 13 May 2026 06:39:58 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70M-0002Lx-Gy; Wed, 13 May 2026 06:39:56 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64DAcPdi044648
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 May 2026 19:38:58 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/WoU4lGhfUf+Gwfd7jBdTN2SQsh5aEl/Q6cpkMQSwyE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778668739; v=1;
 b=VHdfqrGAF2QfKayYJSIMj843aj67MY4rFgRyWgyBYMDpQPZv2bnnjK8FPXO7EqqR
 T4Wiry5mA44V30po9n/KQXDddIYNjaig+frXIu3fbuKZU+v5keuIlBMh/BV7hE6B
 UBs60aU8tglfdXOei0l4+BvbKFErhJUMJwCysrl5tb/hc0z0RItHYf3VxD+izX+o
 WUsmhR/KWCYM0SsXOTlNbwiBWizJcA3FPo51f+61qpvw7IFT+8Z0xXH/ILGF/44L
 C+Mfh54fz8A+jx8C1Nflvfan0pXEqqKIXrho1aL8oVi4iouaqogvaPcobBgvksHQ
 SZNCGlb5QaRqHY0/RrXvWQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 13 May 2026 19:38:36 +0900
Subject: [PATCH v2 20/29] ui/input-barrier: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-input-v2-20-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3193;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=S1Kp78IZinQdzXxZR0DnhehmbKKrJ9FGVU6iaznbTls=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZLyDaWJSc3ckRqXj++4XSV6sXLly+0pf4Pv1RjeWFCj
 +SzTWudOkpZGMS4GGTFFFlSinZza0TXfipMiG+BmcPKBDKEgYtTACZiYMLw35fr0BTVHHZnMy3t
 +Zdunby88/mdSW4TqxddSrRvzS5lj2BkWBJfvZfzXPy8U4t27rORb1T9sYKjjk3OVk7fV1NsytR
 ubgA=
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
 ui/input-barrier.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 042f63cc5a18..4c2ff847131a 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -84,11 +84,11 @@ static const char *cmd_names[] = {
 
 static kbd_layout_t *kbd_layout;
 
-static int input_barrier_to_qcode(uint16_t keyid, uint16_t keycode)
+static int input_barrier_to_linux(uint16_t keyid, uint16_t keycode)
 {
     /* keycode is optional, if it is not provided use keyid */
-    if (keycode && keycode <= qemu_input_map_xorgkbd_to_qcode_len) {
-        return qemu_input_map_xorgkbd_to_qcode[keycode];
+    if (keycode && keycode <= qemu_input_map_xorgkbd_to_linux_len) {
+        return qemu_input_map_xorgkbd_to_linux[keycode];
     }
 
     if (keyid >= 0xE000 && keyid <= 0xEFFF) {
@@ -99,10 +99,10 @@ static int input_barrier_to_qcode(uint16_t keyid, uint16_t keycode)
     if (kbd_layout) {
         keycode = keysym2scancode(kbd_layout, keyid, NULL, false);
 
-        return qemu_input_key_number_to_qcode(keycode);
+        return qemu_input_key_number_to_linux(keycode);
     }
 
-    return qemu_input_map_x11_to_qcode[keyid];
+    return qemu_input_map_x11_to_linux[keyid];
 }
 
 static int input_barrier_to_mouse(uint8_t buttonid)
@@ -431,23 +431,23 @@ static gboolean writecmd(InputBarrier *ib, struct barrierMsg *msg)
 
     /* keyboard */
     case barrierCmdDKeyDown:
-        qemu_input_event_send_key_qcode(NULL,
-                        input_barrier_to_qcode(msg->key.keyid, msg->key.button),
+        qemu_input_event_send_key_linux(NULL,
+                        input_barrier_to_linux(msg->key.keyid, msg->key.button),
                                         true);
         break;
     case barrierCmdDKeyRepeat:
         for (i = 0; i < msg->repeat.repeat; i++) {
-            qemu_input_event_send_key_qcode(NULL,
-                  input_barrier_to_qcode(msg->repeat.keyid, msg->repeat.button),
+            qemu_input_event_send_key_linux(NULL,
+                  input_barrier_to_linux(msg->repeat.keyid, msg->repeat.button),
                                             false);
-            qemu_input_event_send_key_qcode(NULL,
-                  input_barrier_to_qcode(msg->repeat.keyid, msg->repeat.button),
+            qemu_input_event_send_key_linux(NULL,
+                  input_barrier_to_linux(msg->repeat.keyid, msg->repeat.button),
                                             true);
         }
         break;
     case barrierCmdDKeyUp:
-        qemu_input_event_send_key_qcode(NULL,
-                        input_barrier_to_qcode(msg->key.keyid, msg->key.button),
+        qemu_input_event_send_key_linux(NULL,
+                        input_barrier_to_linux(msg->key.keyid, msg->key.button),
                                         false);
         break;
     default:

-- 
2.54.0


