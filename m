Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18B5CD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPajc-00030C-SG; Wed, 20 May 2026 02:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajZ-0002wi-Bd; Wed, 20 May 2026 02:48:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajV-0001NU-3V; Wed, 20 May 2026 02:48:49 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbh096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:18 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0eT7hX3HV3jtywD8HqwQmd9aMXniTbXQ6Dq9OF92gew=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259698; v=1;
 b=j1JiKtHW1BYjsqDV9MArxxInyMgvJ/kRt9Mi2cwd9cDfEYrLHb1b8nEI1Ykyqiey
 94P49kJqae/b/m/EH4hegXGboE5a5cnMxPoQVyy014adkBhmDu+Uk0om75Q6aP3e
 lPy8iarqt6MjykxFY1n1OYvzi+P4gNQ250sfRVHeSYWr18OO3b/Q20wcGJ89FNPM
 RJI06Aq1zy7H7NlzaL57r6iaOijaBDM15u2/sMDJfBC+Eqrfj7BR0k+JiC+OX5kh
 2eG8OCd/XNWORUFBjunQ1Qn4B4c2ymjY0c1CS/PW5HOHDwwJbeMJj3qkjEv/CaU2
 ImHLAuEKHAl8u6Wz0mtQBA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:48:03 +0900
Subject: [PATCH v3 20/29] ui/input-barrier: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-20-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3202;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=jszjrXrN0NDUQge4WWTJc0rd7Wjhs0Zo8EoFTBwV4Eg=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpNqTWZu6fF88dNjwY421+iH/qu1vgt6xfOue+P9Sb
 eNEwWPpHaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABO5u4Phf8Uy/cdec3zP8yzd
 Wfqw2Xf1RlHn71pLX/41LFiadSIg1ZGRoUVodsD+R25vcj+G7bcMnbF90UKnv6+3Jngn9UX4aa2
 p4AYA
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
index 042f63cc5a18..d07027114af9 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -84,11 +84,11 @@ static const char *cmd_names[] = {
 
 static kbd_layout_t *kbd_layout;
 
-static int input_barrier_to_qcode(uint16_t keyid, uint16_t keycode)
+static unsigned int input_barrier_to_linux(uint16_t keyid, uint16_t keycode)
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


