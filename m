Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B91CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnRN-00040Q-DU; Wed, 04 Sep 2024 06:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slnRI-0003KN-8p; Wed, 04 Sep 2024 06:40:40 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slnRE-0000HO-4l; Wed, 04 Sep 2024 06:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=q5vrSqwIdUHVmeZ5blcGcrtyUoI6ExqoUNdJbrXQlrI=; b=EkjLcihPptEioJ8CFCEv04PCHF
 9mT9m1azkrSZ9Byfvv4+IBuC2G7ScUY3Kk+DD5SqSQWKhPZdEBWNP83d2JFu2IsIq7QroZYRAcL7R
 kYWukpKLdwpRZ+LH3fBk2rJo+sk8uqZjzhRQCaPILvSbkgowc9mN4oEYXLOV9zAWeAp4C4ErducxM
 7NPkM0RbXrlm+glMig1Bh2uxQMgTZqIPOauJ2LzAyRCTWcN2OMmtisCHCYi8gDXjpvlIZ+XGPgtZR
 gqcqoJlgu6z+sFihs/hS6PwLUXznDGNzmu0MVNbZvtjXdIJkTufvO22J87KGX5BWv+jpygOHa6bRE
 S4sppV9lkmqL7SpciE5U4hsu7OBi7ORTEEDv6HiOrGGfgxZq6QHvQ/yJuP2Wb6SQH0Lku2OnmEgiK
 IWOEoZhBo5H339om45sfLA+Dt5GSVzcIjdu573Zqf8dLpyn3Bea5dcYVWDFBdI0W9O5u6vYfz93FI
 f1acM7ZvAded9OCx6Xg3A+KaJ1pquD6xEHGqKmxQbFE4CGmdr8yDbwsLorHVyBUkF7NOM+JmchqCB
 BTjCw8v6uWLAsXi22u7PuFBR9Kt+MfZowdJA/B1/pZoOoPHAyoYhKkFaLwZ+0dQPXUbv4vOAaOcDW
 s7ZEq7QwIPNGNj22nCc1kEkiwPIix73tJfZcyua5Q=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slnQo-0002Ly-Tb; Wed, 04 Sep 2024 11:40:15 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org,
	hsp.cat7@gmail.com
Date: Wed,  4 Sep 2024 11:40:07 +0100
Message-Id: <20240904104007.177239-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] adb-mouse: convert to use QemuInputHandler
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update the ADB mouse implementation to use QemuInputHandler instead of the
legacy qemu_add_mouse_event_handler() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/input/adb-mouse.c | 56 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 144a0ccce7..7aa36caf2f 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -38,6 +38,7 @@ struct MouseState {
     ADBDevice parent_obj;
     /*< private >*/
 
+    QemuInputHandlerState *hs;
     int buttons_state, last_buttons_state;
     int dx, dy, dz;
 };
@@ -51,17 +52,52 @@ struct ADBMouseClass {
     DeviceRealize parent_realize;
 };
 
-static void adb_mouse_event(void *opaque,
-                            int dx1, int dy1, int dz1, int buttons_state)
+#define ADB_MOUSE_BUTTON_LEFT   0x01
+#define ADB_MOUSE_BUTTON_RIGHT  0x02
+
+static void adb_mouse_handle_event(DeviceState *dev, QemuConsole *src,
+                                   InputEvent *evt)
 {
-    MouseState *s = opaque;
+    MouseState *s = (MouseState *)dev;
+    InputMoveEvent *move;
+    InputBtnEvent *btn;
+    static const int bmap[INPUT_BUTTON__MAX] = {
+        [INPUT_BUTTON_LEFT]   = ADB_MOUSE_BUTTON_LEFT,
+        [INPUT_BUTTON_RIGHT]  = ADB_MOUSE_BUTTON_RIGHT,
+    };
+
+    switch (evt->type) {
+    case INPUT_EVENT_KIND_REL:
+        move = evt->u.rel.data;
+        if (move->axis == INPUT_AXIS_X) {
+            s->dx += move->value;
+        } else if (move->axis == INPUT_AXIS_Y) {
+            s->dy += move->value;
+        }
+        break;
+
+    case INPUT_EVENT_KIND_BTN:
+        btn = evt->u.btn.data;
+        if (bmap[btn->button]) {
+            if (btn->down) {
+                s->buttons_state |= bmap[btn->button];
+            } else {
+                s->buttons_state &= ~bmap[btn->button];
+            }
+        }
+        break;
 
-    s->dx += dx1;
-    s->dy += dy1;
-    s->dz += dz1;
-    s->buttons_state = buttons_state;
+    default:
+        /* keep gcc happy */
+        break;
+    }
 }
 
+static const QemuInputHandler adb_mouse_handler = {
+    .name  = "QEMU ADB Mouse",
+    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
+    .event = adb_mouse_handle_event,
+};
 
 static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
 {
@@ -94,10 +130,10 @@ static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
     dx &= 0x7f;
     dy &= 0x7f;
 
-    if (!(s->buttons_state & MOUSE_EVENT_LBUTTON)) {
+    if (!(s->buttons_state & ADB_MOUSE_BUTTON_LEFT)) {
         dy |= 0x80;
     }
-    if (!(s->buttons_state & MOUSE_EVENT_RBUTTON)) {
+    if (!(s->buttons_state & ADB_MOUSE_BUTTON_RIGHT)) {
         dx |= 0x80;
     }
 
@@ -236,7 +272,7 @@ static void adb_mouse_realizefn(DeviceState *dev, Error **errp)
 
     amc->parent_realize(dev, errp);
 
-    qemu_add_mouse_event_handler(adb_mouse_event, s, 0, "QEMU ADB Mouse");
+    s->hs = qemu_input_handler_register((DeviceState *)s, &adb_mouse_handler);
 }
 
 static void adb_mouse_initfn(Object *obj)
-- 
2.39.2


