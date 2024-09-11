Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D87EE4998
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJz-0003lw-9L; Wed, 11 Sep 2024 08:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJx-0003Mr-HH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJu-0007im-CE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb58d810eso5117355e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057176; x=1726661976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uAYQOz0f3NUUgtgEDr3l2InET86j9EqdXcrrlozEfg=;
 b=hGImCzJso1mf2mVeCB3eK/igCaUIZ4WxW4YNgxDAhXtGlQkleug2jAly+NguD2AgtR
 bKyOZ9YzY3LVBXjps0uhw6Xjr+m9z/IPNLdJXkdoF/XQ8WZLdTN/+di89NdIkOWi/Vy4
 ine97XlS4rhTUFtn8H0GbHybmZ4Kx1XjxE8Pc9z3JQ6w5xzwqrekjGPMvJL2oSoMCMDJ
 qxyyREwrpGI3ojBhsFGVxPCYQLg6o9tmkhQS6CsgFf2i71L1CbqLydprNZR9/Sx0LRBY
 SlJlsg+trXE/1fZikQX05LQ2RvqwfI1Dc9ywU8yScRurd+9HU73k2mUYBbZwOJl8NVkE
 mE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057176; x=1726661976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5uAYQOz0f3NUUgtgEDr3l2InET86j9EqdXcrrlozEfg=;
 b=BzlBlxAWmsdKou8E7sP26xl77X8x5cpDLpdqSFKCv1x52XLg6LacSuGtpMt+yIFS/W
 P2MVUKOqNE+2DI31Bw4JpOrejHE0CMgrDAgO6Cu8GMhLNRc7KuyFXHw0W9eUpXaAJ/94
 lZbfUPvwW0tWgdlFpeoN3axXKoifZH0hn8U2MH/OGi3gDR4L1v0CNZhwGSHkbgz0cOPw
 u2MRKsDccYteDp4UXBeIoCBxaAnkZmSuI01gS+S0fHVQlESI7dNXKum0rdW3lfTVYl3Z
 0e+NeTeoSRGypis9yzI7UTQ+EhFMiB3+jSD/MNW5zYSaNQFO61eBhZDAmQn0QXrTD1jj
 bzqw==
X-Gm-Message-State: AOJu0YyXDOirHH6WSAvUD61AvnZhCPkgOLVxVtlsJSv3gphIYy8HJhFe
 kqZYFtERHivNDufTUGfCxvFLK1a9vNk2i2O/YrKGhIK+olJBlZ1m6jH5LF8mPkkEYeNvAVgwL3f
 Q
X-Google-Smtp-Source: AGHT+IG6FBCLTgGRgxi4UDXuJoG/UDElP7Gs7bIVVsRgpuO8ZDjh/xXj+z8dGNRiHHI6+UousmNcLg==
X-Received: by 2002:a05:600c:450d:b0:426:5c36:f57a with SMTP id
 5b1f17b1804b1-42cbde01a6emr39184285e9.14.1726057176347; 
 Wed, 11 Sep 2024 05:19:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb4444asm140839205e9.22.2024.09.11.05.19.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:19:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 45/56] hw/input/adb-mouse: convert to use QemuInputHandler
Date: Wed, 11 Sep 2024 14:14:10 +0200
Message-ID: <20240911121422.52585-46-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Update the ADB mouse implementation to use QemuInputHandler instead of the
legacy qemu_add_mouse_event_handler() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240907173700.348818-1-mark.cave-ayland@ilande.co.uk>
[PMD: Add comment about .sync handler]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/input/adb-mouse.c | 63 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 144a0ccce7..15e6e91804 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -38,6 +38,7 @@ struct MouseState {
     ADBDevice parent_obj;
     /*< private >*/
 
+    QemuInputHandlerState *hs;
     int buttons_state, last_buttons_state;
     int dx, dy, dz;
 };
@@ -51,17 +52,57 @@ struct ADBMouseClass {
     DeviceRealize parent_realize;
 };
 
-static void adb_mouse_event(void *opaque,
-                            int dx1, int dy1, int dz1, int buttons_state)
-{
-    MouseState *s = opaque;
+#define ADB_MOUSE_BUTTON_LEFT   0x01
+#define ADB_MOUSE_BUTTON_RIGHT  0x02
 
-    s->dx += dx1;
-    s->dy += dy1;
-    s->dz += dz1;
-    s->buttons_state = buttons_state;
+static void adb_mouse_handle_event(DeviceState *dev, QemuConsole *src,
+                                   InputEvent *evt)
+{
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
+
+    default:
+        /* keep gcc happy */
+        break;
+    }
 }
 
+static const QemuInputHandler adb_mouse_handler = {
+    .name  = "QEMU ADB Mouse",
+    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
+    .event = adb_mouse_handle_event,
+    /*
+     * We do not need the .sync handler because unlike e.g. PS/2 where async
+     * mouse events are sent over the serial port, an ADB mouse is constantly
+     * polled by the host via the adb_mouse_poll() callback.
+     */
+};
 
 static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
 {
@@ -94,10 +135,10 @@ static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
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
 
@@ -236,7 +277,7 @@ static void adb_mouse_realizefn(DeviceState *dev, Error **errp)
 
     amc->parent_realize(dev, errp);
 
-    qemu_add_mouse_event_handler(adb_mouse_event, s, 0, "QEMU ADB Mouse");
+    s->hs = qemu_input_handler_register(dev, &adb_mouse_handler);
 }
 
 static void adb_mouse_initfn(Object *obj)
-- 
2.45.2


