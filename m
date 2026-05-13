Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3807ACD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN705-0003vo-Pr; Wed, 13 May 2026 06:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN6zz-0003pD-Bs; Wed, 13 May 2026 06:39:31 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN6zv-0002P0-NE; Wed, 13 May 2026 06:39:31 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64DAcPdY044648
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 May 2026 19:38:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=w+G4mYrT3E579hEsUmrs6jCM3wwxrAco3XtOrTTZDg4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778668736; v=1;
 b=pxfbA1V9MSpA+URvfP2D0sZR3oZPBGQtGyVjKql1G0Dv7Kjn7wYSigPL33726gNv
 G/tRjOEDpoWqQ+supKYbPtVM1wUztlGpPgE05EK8+c+i+UGn8gGGKrUgsvZ/2D4R
 vu1cf4fUvjorsrk0fS7A7Bh0IlJfF9I2/TQ4mV7/OhR4TDRFgbufA21I5Ps2U6N4
 ctruCUzXQHJKkGtCC8WBGcw/1DAEnXoKCDj14v1N10FCMSthdP68ZKhVJFcktwjb
 xVLFDzGbZS4B9ok+jF4yrbTEYZtYk115DCyBequ4lczBYRvUPu7EQ9dbxfp2j+hV
 2YEYIBF/vQg30ESvA1Sctw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 13 May 2026 19:38:26 +0900
Subject: [PATCH v2 10/29] hw/display/xenfb: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-input-v2-10-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=XcfBuuudisNZMFU+Lz64jMl2gKGv+YTeVpp7yLYFGCs=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZLyDpG48/zzm+ctJ2nvXZH5pt7Cu36a18bLTYzvjnre
 dWeec4rOkpZGMS4GGTFFFlSinZza0TXfipMiG+BmcPKBDKEgYtTACayIYWR4V7AR59Qg6uhUz5Z
 PNkvp7jp9G7nrFfv5Dm+L1zp9MCPP4/hf7mRyGbVadbhkvPm5K//Ldzz9F1u+GpuneyOdbuDzcI
 ZGQA=
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
 hw/display/xenfb.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 218f37f07400..ae302b217fe9 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -191,29 +191,14 @@ static int xenfb_send_position(struct XenInput *xenfb,
     return xenfb_kbd_event(xenfb, &event);
 }
 
-/*
- * Send a key event from the client to the guest OS
- * QEMU gives us a QCode.
- * We have to turn this into a Linux Input layer keycode.
- *
- * Wish we could just send scancodes straight to the guest which
- * already has code for dealing with this...
- */
+/* Send a key event from the client to the guest OS */
 static void xenfb_key_event(DeviceState *dev, QemuConsole *src,
                             QemuInputEvent *evt)
 {
     struct XenInput *xenfb = (struct XenInput *)dev;
-    int qcode = qemu_input_linux_to_qcode(evt->key.key);
-    int lnx;
 
-    if (qcode < qemu_input_map_qcode_to_linux_len) {
-        lnx = qemu_input_map_qcode_to_linux[qcode];
-
-        if (lnx) {
-            trace_xenfb_key_event(xenfb, lnx, evt->key.down);
-            xenfb_send_key(xenfb, evt->key.down, lnx);
-        }
-    }
+    trace_xenfb_key_event(xenfb, evt->key.key, evt->key.down);
+    xenfb_send_key(xenfb, evt->key.down, evt->key.key);
 }
 
 /*

-- 
2.54.0


