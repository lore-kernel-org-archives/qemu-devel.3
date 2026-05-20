Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5114CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPald-0007Pd-ND; Wed, 20 May 2026 02:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPak0-0003Zs-Jj; Wed, 20 May 2026 02:49:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajv-0001ON-Ub; Wed, 20 May 2026 02:49:16 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbf096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=EwTrorDyTXNOzZprZQApTr28BF5pYHegnRMRkjFARHE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259697; v=1;
 b=rujf7fLVMfxH/kh0I12zNw2g0V0sHv+5x4K92ulxDgC2vqtpFX7y1Yyeh3heybxl
 44nWs0fCuYSlTUeMybgynSXPo1tHGwWyQ1xU6gbqCXC8VKvVd3U+421T2jjBjEPf
 9tfYpWLr2Ojd4m19tLvpQxHm3vK6FoqIMrl2XKnY24hb32S796MKI370PuZWBQjF
 jsGDoo80CPgM9Jkj6s/oPd2UEbynD203yeJm2wM7M8ThL+JbdsiMWT2sdWnchJNr
 I7WfgJm8NB2tshmUn6IEi7z7yNgTEiPHdEQO1CuD59pZmXboBSBqAhMZNhqjxP0i
 QTnMr6+3e10RuApDjwHuwQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:48:01 +0900
Subject: [PATCH v3 18/29] ui/dbus: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-18-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=gB8mTMZK4mduWPbSZb0FvUSTrDoOfUJgikz48+lTqJQ=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpIrE47OTZH9J+OqsPsVz+rhYOmf+kpnretmU/1Tdr
 RXxTzrUUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMBG9xQz/DFNb4+7Nv3JVUeF2
 lpzrQYv4d4wpTRffBiYbK33pSwh2YPgr8db1fqmJfLJ9/N++opzs6m8ys3MFw/e9vRNdq8/Tc5E
 XAA==
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
index 24f4542f3121..21eceb24362d 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -339,11 +339,11 @@ dbus_kbd_press(DBusDisplayConsole *ddc,
                GDBusMethodInvocation *invocation,
                guint arg_keycode)
 {
-    QKeyCode qcode = qemu_input_key_number_to_qcode(arg_keycode);
+    unsigned int lnx = qemu_input_key_number_to_linux(arg_keycode);
 
     trace_dbus_kbd_press(arg_keycode);
 
-    qkbd_state_key_event(ddc->kbd, qemu_input_map_qcode_to_linux[qcode], true);
+    qkbd_state_key_event(ddc->kbd, lnx, true);
 
     qemu_dbus_display1_keyboard_complete_press(ddc->iface_kbd, invocation);
 
@@ -355,11 +355,11 @@ dbus_kbd_release(DBusDisplayConsole *ddc,
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


