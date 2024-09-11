Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF2EEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJu-0002ga-LG; Wed, 11 Sep 2024 08:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJr-00026Z-Ax
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJo-0007iN-UP
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso17434875e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057171; x=1726661971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NssZFsgofzGs2gp8p888uYqHLNroe1f/wyQ4Ij7Swyo=;
 b=S5X0A8UzOg0fuUQqQq7R+tH6//MUyARhZHOpfK7iy9MbuYU8lzm+v2f0L+a3aRVMNT
 ht6QkU43zJkgjv4H4PtKuSxMqUEMoDIIczzlha+APvSHCVHA6mdKunYV1zdoYfnndrCO
 2I+NEQ7A3FdM6P/1UJRLxckMnUWpEzxv13aPlFd++pqvs6l8HPXgKeXZMSZBmJdW3kZq
 /xmJsAW3aIsxpAyceTWHlHrlQW6rISDLC6EDF0AY471Fxbv/3OwR9F/6Y44jWjDppbJH
 eyR29QIqpe0XGtjufBVUlfw58iYnOEpEs4srPmK5bNGsVJJzsjsm6H+VuR6XDhlkfxjU
 8nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057171; x=1726661971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NssZFsgofzGs2gp8p888uYqHLNroe1f/wyQ4Ij7Swyo=;
 b=UtIX8UdQ1C6M6THIus/6cjKROC+JEoWdxnQzkj7qh2QJV7UdMLY8yncKDTW3wqJQNZ
 1mXJETWCdGqkyarIgIlJnWZJRSmxue7kmo4mdRu05UJUky/VDYkdDCXMnpAi2RcaxkJZ
 nyC3RBHZLuq/rvo4ST+gq2tjtOpgmfUi1NTgRTEyGcc3hMimJ5Uv8MmuHvMt5C8CABlA
 LNY15wAKcaMjTtYiN8nOYjqG9dK1+n5gxH5AKb29YkSw85LVq+rfoQjChMoz7LT037fM
 PsjEg4zkcU25MgXOQuaMoFidHinBMD9JRIYHq3H6to4I/VOKHhk8liTchQCUd2GFvVe8
 jjVw==
X-Gm-Message-State: AOJu0Yx3G7N5NC2LFzL8//cRl6lZBKnjQKAK2GHo2a2vUH0c7hmD2TYW
 wBHGdasckRtsvQsGdDgdpgvYBbL9F97kYu49CY1YPzD+xqWIQ6rIVt6ljLlLccBgh9bK1Q8yU+A
 0
X-Google-Smtp-Source: AGHT+IHQKMKWCPgxFOZhmzVhwSUA0KIaoz1nBAg1kItW9iP0BaeZxpyByes+Bf5YG4g4X/L6e9PUTA==
X-Received: by 2002:a05:600c:46ca:b0:42c:b1f0:f67 with SMTP id
 5b1f17b1804b1-42ccd35adf5mr20242215e9.27.1726057170789; 
 Wed, 11 Sep 2024 05:19:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb43d73sm146432955e9.24.2024.09.11.05.19.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:19:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Carl Hauser <chauser@pullman.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/56] hw/char/escc: convert Sun mouse to use QemuInputHandler
Date: Wed, 11 Sep 2024 14:14:09 +0200
Message-ID: <20240911121422.52585-45-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Update the Sun mouse implementation to use QemuInputHandler instead of the
legacy qemu_add_mouse_event_handler() function.

Note that this conversion adds extra sunmouse_* members to ESCCChannelState
but they are not added to the migration stream (similar to the Sun keyboard
members). If this were desired in future, the Sun devices should be split
into separate devices and added to the migration stream there instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2518
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Carl Hauser <chauser@pullman.com>
Message-ID: <20240904102301.175706-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/char/escc.h |  3 ++
 hw/char/escc.c         | 92 +++++++++++++++++++++++++++++++-----------
 2 files changed, 71 insertions(+), 24 deletions(-)

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
diff --git a/hw/char/escc.c b/hw/char/escc.c
index d450d70eda..245a7b19d3 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -287,6 +287,7 @@ static void escc_reset_chn(ESCCChannelState *s)
     s->rxint = s->txint = 0;
     s->rxint_under_svc = s->txint_under_svc = 0;
     s->e0_mode = s->led_mode = s->caps_lock_mode = s->num_lock_mode = 0;
+    s->sunmouse_dx = s->sunmouse_dy = s->sunmouse_buttons = 0;
     clear_queue(s);
 }
 
@@ -952,53 +953,96 @@ static void handle_kbd_command(ESCCChannelState *s, int val)
     }
 }
 
-static void sunmouse_event(void *opaque,
-                               int dx, int dy, int dz, int buttons_state)
+static void sunmouse_handle_event(DeviceState *dev, QemuConsole *src,
+                                  InputEvent *evt)
 {
-    ESCCChannelState *s = opaque;
+    ESCCChannelState *s = (ESCCChannelState *)dev;
+    InputMoveEvent *move;
+    InputBtnEvent *btn;
+    static const int bmap[INPUT_BUTTON__MAX] = {
+        [INPUT_BUTTON_LEFT]   = 0x4,
+        [INPUT_BUTTON_MIDDLE] = 0x2,
+        [INPUT_BUTTON_RIGHT]  = 0x1,
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
+
+    case INPUT_EVENT_KIND_BTN:
+        btn = evt->u.btn.data;
+        if (bmap[btn->button]) {
+            if (btn->down) {
+                s->sunmouse_buttons |= bmap[btn->button];
+            } else {
+                s->sunmouse_buttons &= ~bmap[btn->button];
+            }
+            /* Indicate we have a supported button event */
+            s->sunmouse_buttons |= 0x80;
+        }
+        break;
+
+    default:
+        /* keep gcc happy */
+        break;
+    }
+}
+
+static void sunmouse_sync(DeviceState *dev)
+{
+    ESCCChannelState *s = (ESCCChannelState *)dev;
     int ch;
 
-    trace_escc_sunmouse_event(dx, dy, buttons_state);
+    if (s->sunmouse_dx == 0 && s->sunmouse_dy == 0 &&
+        (s->sunmouse_buttons & 0x80) == 0) {
+            /* Nothing to do after button event filter */
+            return;
+    }
+
+    /* Clear our button event flag */
+    s->sunmouse_buttons &= ~0x80;
+    trace_escc_sunmouse_event(s->sunmouse_dx, s->sunmouse_dy,
+                              s->sunmouse_buttons);
     ch = 0x80 | 0x7; /* protocol start byte, no buttons pressed */
-
-    if (buttons_state & MOUSE_EVENT_LBUTTON) {
-        ch ^= 0x4;
-    }
-    if (buttons_state & MOUSE_EVENT_MBUTTON) {
-        ch ^= 0x2;
-    }
-    if (buttons_state & MOUSE_EVENT_RBUTTON) {
-        ch ^= 0x1;
-    }
-
+    ch ^= s->sunmouse_buttons;
     put_queue(s, ch);
 
-    ch = dx;
-
+    ch = s->sunmouse_dx;
     if (ch > 127) {
         ch = 127;
     } else if (ch < -127) {
         ch = -127;
     }
-
     put_queue(s, ch & 0xff);
+    s->sunmouse_dx -= ch;
 
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
+    s->sunmouse_dy -= ch;
 
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
@@ -1036,8 +1080,8 @@ static void escc_realize(DeviceState *dev, Error **errp)
     }
 
     if (s->chn[0].type == escc_mouse) {
-        qemu_add_mouse_event_handler(sunmouse_event, &s->chn[0], 0,
-                                     "QEMU Sun Mouse");
+        s->chn[0].hs = qemu_input_handler_register((DeviceState *)(&s->chn[0]),
+                                                   &sunmouse_handler);
     }
     if (s->chn[1].type == escc_kbd) {
         s->chn[1].hs = qemu_input_handler_register((DeviceState *)(&s->chn[1]),
-- 
2.45.2


