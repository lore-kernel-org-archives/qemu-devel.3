Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E61FCA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 21:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slEkw-0003gP-4G; Mon, 02 Sep 2024 17:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slEkr-0003fp-J5
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 17:38:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slEkp-0007r0-UC
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 17:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=IHF8QA3Jkd4+btstC28ShQHVtDlsS4RsqKVOSDbRhMc=; b=zb5/WcBaShJktANAh6ogQGb+QU
 KMmY/UarGi/lKB/oL68vMsqbR5thQsQY51KqSDjBBsG71uh332RjgSyxAXSf8tokJtsFfM3Z1nL6b
 gMXWGn6JEBguQs7Ac94qoRXbX8wxrzAaz5Jr/f8+YxIgQUxY6fqkvFUzH1zCKpJZOOuIvy9coIni1
 ltzMCHnwlItOelqr9D1hj7oMB/ColX6xELVS4nf36ReQeS5N8HR0u70TVbc4/BNmqDOHuwNBK5TQk
 c2aDsFYzovMd5SssUO074mjKhKwzbHHWuMRagB5/pfbyyGoa1P28vtgqqMQ1ykagJILx44IHc1Qru
 FM42Q56rRcXCtElUU98BHnMrslBIcCBf+UZHoM+YMMkACzoNc5Mmi9KM9IR/1pvarJBcH+TU+w2yp
 Z6vdbT9zgjj+hP8LCymyFH/lPMZ8wvcnhCmpsUmpPIQ+52Cyw/+hOwyFIEYrXf8PSEkLvTrw3Mj/T
 P64ccgk/Hv7iZBMc8YlxuvDaRWG3Br9UQkOySSoJAzbG2Mrg4mml7x9QrmOKeVhPfTKrWHPlsU+13
 IoCFRUaVng4ZBHZk0h2eDNSLo9KxtO2O/+Y5YR3LNHM1rHDkYMboK29wAG6aUsqVn79ZeUR7aJlhG
 30jUAdbR9Gi35xLXTMujWvdHvY2wq/qbVYh5MWW9g=;
Received: from [2a00:23c4:8bb4:4000:fb99:dbc7:e0ba:aaf]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slEkQ-000CDb-Ih; Mon, 02 Sep 2024 22:38:10 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: chauser@pullman.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Date: Mon,  2 Sep 2024 22:38:16 +0100
Message-Id: <20240902213816.89071-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:fb99:dbc7:e0ba:aaf
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] escc: convert Sun mouse to use QemuInputHandler
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

Update the Sun mouse implementation to use QemuInputHandler instead of the
legacy qemu_add_mouse_event_handler() function.

Note that this conversion adds extra sunmouse_* members to ESCCChannelState
but they are not added to the migration stream (similar to the Sun keyboard
members). If this were desired in future, the Sun devices should be split
into separate devices and added to the migration stream there instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2518
---
 hw/char/escc.c         | 79 ++++++++++++++++++++++++++++++------------
 include/hw/char/escc.h |  3 ++
 roms/seabios           |  2 +-
 3 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index d450d70eda..6d4e3e3350 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -287,6 +287,7 @@ static void escc_reset_chn(ESCCChannelState *s)
     s->rxint = s->txint = 0;
     s->rxint_under_svc = s->txint_under_svc = 0;
     s->e0_mode = s->led_mode = s->caps_lock_mode = s->num_lock_mode = 0;
+    s->sunmouse_dx = s->sunmouse_dy = s->sunmouse_buttons = 0;
     clear_queue(s);
 }
 
@@ -952,53 +953,85 @@ static void handle_kbd_command(ESCCChannelState *s, int val)
     }
 }
 
-static void sunmouse_event(void *opaque,
-                               int dx, int dy, int dz, int buttons_state)
+static void sunmouse_handle_event(DeviceState *dev, QemuConsole *src,
+                                  InputEvent *evt)
 {
-    ESCCChannelState *s = opaque;
-    int ch;
+    ESCCChannelState *s = (ESCCChannelState *)dev;
+    InputMoveEvent *move;
+    InputBtnEvent *btn;
+    static const int bmap[INPUT_BUTTON__MAX] = {
+        [INPUT_BUTTON_LEFT]   = 0x4,
+        [INPUT_BUTTON_MIDDLE] = 0x2,
+        [INPUT_BUTTON_RIGHT]  = 0x1,
+        [INPUT_BUTTON_SIDE]   = 0x0,
+        [INPUT_BUTTON_EXTRA]  = 0x0,
+    };
+
+    switch (evt->type) {
+    case INPUT_EVENT_KIND_REL:
+        move = evt->u.rel.data;
+        if (move->axis == INPUT_AXIS_X) {
+            s->sunmouse_dx += move->value;
+        } else if (move->axis == INPUT_AXIS_Y) {
+            s->sunmouse_dy -= move->value;
+        }
+        break;
 
-    trace_escc_sunmouse_event(dx, dy, buttons_state);
-    ch = 0x80 | 0x7; /* protocol start byte, no buttons pressed */
+    case INPUT_EVENT_KIND_BTN:
+        btn = evt->u.btn.data;
+        if (btn->down) {
+            s->sunmouse_buttons |= bmap[btn->button];
+        } else {
+            s->sunmouse_buttons &= ~bmap[btn->button];
+        }
+        break;
 
-    if (buttons_state & MOUSE_EVENT_LBUTTON) {
-        ch ^= 0x4;
-    }
-    if (buttons_state & MOUSE_EVENT_MBUTTON) {
-        ch ^= 0x2;
-    }
-    if (buttons_state & MOUSE_EVENT_RBUTTON) {
-        ch ^= 0x1;
+    default:
+        /* keep gcc happy */
+        break;
     }
+}
 
-    put_queue(s, ch);
+static void sunmouse_sync(DeviceState *dev)
+{
+    ESCCChannelState *s = (ESCCChannelState *)dev;
+    int ch;
 
-    ch = dx;
+    trace_escc_sunmouse_event(s->sunmouse_dx, s->sunmouse_dy, 0);
+    ch = 0x80 | 0x7; /* protocol start byte, no buttons pressed */
+    ch ^= s->sunmouse_buttons;
+    put_queue(s, ch);
 
+    ch = s->sunmouse_dx;
     if (ch > 127) {
         ch = 127;
     } else if (ch < -127) {
         ch = -127;
     }
-
     put_queue(s, ch & 0xff);
+    s->sunmouse_dx = 0;
 
-    ch = -dy;
-
+    ch = s->sunmouse_dy;
     if (ch > 127) {
         ch = 127;
     } else if (ch < -127) {
         ch = -127;
     }
-
     put_queue(s, ch & 0xff);
+    s->sunmouse_dy = 0;
 
     /* MSC protocol specifies two extra motion bytes */
-
     put_queue(s, 0);
     put_queue(s, 0);
 }
 
+static const QemuInputHandler sunmouse_handler = {
+    .name  = "QEMU Sun Mouse",
+    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
+    .event = sunmouse_handle_event,
+    .sync  = sunmouse_sync,
+};
+
 static void escc_init1(Object *obj)
 {
     ESCCState *s = ESCC(obj);
@@ -1036,8 +1069,8 @@ static void escc_realize(DeviceState *dev, Error **errp)
     }
 
     if (s->chn[0].type == escc_mouse) {
-        qemu_add_mouse_event_handler(sunmouse_event, &s->chn[0], 0,
-                                     "QEMU Sun Mouse");
+        s->chn[0].hs = qemu_input_handler_register((DeviceState *)(&s->chn[0]),
+                                                   &sunmouse_handler);
     }
     if (s->chn[1].type == escc_kbd) {
         s->chn[1].hs = qemu_input_handler_register((DeviceState *)(&s->chn[1]),
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 5669a5b811..8c4c6a7730 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -46,6 +46,9 @@ typedef struct ESCCChannelState {
     uint8_t rx, tx;
     QemuInputHandlerState *hs;
     char *sunkbd_layout;
+    int sunmouse_dx;
+    int sunmouse_dy;
+    int sunmouse_buttons;
 } ESCCChannelState;
 
 struct ESCCState {
diff --git a/roms/seabios b/roms/seabios
index a6ed6b701f..7d0c606870 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit a6ed6b701f0a57db0569ab98b0661c12a6ec3ff8
+Subproject commit 7d0c6068703eae9f2498be0c900ab95b25b4f07a
-- 
2.39.2


