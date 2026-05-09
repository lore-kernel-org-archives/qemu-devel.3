Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8265CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 10:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLfFW-0000CJ-JY; Sat, 09 May 2026 06:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfF2-0008Ke-82; Sat, 09 May 2026 06:49:05 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfEx-0001eB-Ir; Sat, 09 May 2026 06:49:02 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 649AlY2I090834
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 9 May 2026 19:48:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=kULJOiJnDDjssqVDbI5iwGpZTZrb3TnrgM+JgQAbtfc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778323681; v=1;
 b=U7FvxOZYb64dASiStS8BYG0QX9xqQOpZaG2vOiD81Rlf2Cp8TbwcgU5rr752oPph
 9MGipn7EliRW4uuk9qMoi9pOu95ZPjeniOhz7o+qts5lTr5BaGNHBGOhuxXY5vVr
 hdfTZqLO62gPqN/b10sJL7P9R0XtbF+hoMxRObdmwSC9LvEKTuiDkpM+pZauJPHK
 TUxbnx752HSlz6cyXbpPStsJAOOHc4TepjfXIhwFjRL7yS87EfDq8G8TG1oB0c6e
 WqtmQvkEmaINu/vsAx+5j0/zPSJeY4Oqw7GymMFtgb65PEQY4Nzhn3HpBA0Jsnmb
 m3wWx9gqG3w91Klt33dj3g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 09 May 2026 19:34:29 +0900
Subject: [PATCH RFC 17/28] ui/dbus: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-input-v1-17-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
References: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=xAuXkeg2eNkRQq4YBbr0QEEzWGOMz8DYnOVntd0qrj0=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ+Z/gWuXo1R/6JfWaxc65h9V3zL3t7zKKqktF+eICFUXP
 P+2uHl3RykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwETaYhkZjq0zP3c28VffKpVZ
 LtePbl/FyTF3+Tfb598vfFcvPqG1tobhf27D4/K9lk/2Gy7cnbYhUTByyZqIlb8/G5s7J1sHdQa
 fYAAA
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
 ui/dbus-console.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index a46c2531c6f8..c7f2c69baf2c 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -340,11 +340,11 @@ dbus_kbd_press(DBusDisplayConsole *ddc,
                GDBusMethodInvocation *invocation,
                guint arg_keycode)
 {
-    QKeyCode qcode = qemu_input_key_number_to_qcode(arg_keycode);
+    unsigned int lnx = qemu_input_key_number_to_linux(arg_keycode);
 
     trace_dbus_kbd_press(arg_keycode);
 
-    qkbd_state_key_event(ddc->kbd, qemu_input_map_qcode_to_linux[qcode], true);
+    qkbd_state_key_event(ddc->kbd, lnx, true);
 
     qemu_dbus_display1_keyboard_complete_press(ddc->iface_kbd, invocation);
 
@@ -356,11 +356,11 @@ dbus_kbd_release(DBusDisplayConsole *ddc,
                  GDBusMethodInvocation *invocation,
                  guint arg_keycode)
 {
-    QKeyCode qcode = qemu_input_key_number_to_qcode(arg_keycode);
+    unsigned int lnx = qemu_input_key_number_to_linux(arg_keycode);
 
     trace_dbus_kbd_release(arg_keycode);
 
-    qkbd_state_key_event(ddc->kbd, qemu_input_map_qcode_to_linux[qcode], false);
+    qkbd_state_key_event(ddc->kbd, lnx, false);
 
     qemu_dbus_display1_keyboard_complete_release(ddc->iface_kbd, invocation);
 

-- 
2.54.0


