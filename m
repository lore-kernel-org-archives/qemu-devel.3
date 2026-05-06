Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1CCCD3440
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcvt-0004JR-51; Wed, 06 May 2026 10:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvp-0004AD-Qh
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvn-0002BV-4G
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891f625344so10925905e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076532; x=1778681332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a11/gtG0jF1VWPlJJVKlu/AgeHXIKLDxKd6uKAJXj/E=;
 b=oSNA+4qy11OTJDdXUEaeH1cec2PRL5IAk2GWBJsPPkZ+rgV3xX6IpEaGVDbOMOb3pj
 9PoxK/V4cboCklHCuaXU3pYuYRoaAkjv3acSnKY3RdGuwQcwb1uptEZkhXcM7b1Xy0Cj
 Ju6jpI4mYpRaRvAGqyMI8AnBJhVlc5SMCGWz/aOgjyStPM7BVkQkDp/IOUP1y4zuMJ3r
 pbjo2Yy6jUx3K1t2EAltaKhQ4N+QLTZ6oGj6C2QbSdG7E+mPoA4cQbrfSbi7JWs+flXk
 MFgRPLqoeJ8g5cxHj7gJMPaoST0DHRBEsHjXaW2ILAMW7gLkF/hZC2MD8ezoztTT48IA
 gDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076532; x=1778681332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a11/gtG0jF1VWPlJJVKlu/AgeHXIKLDxKd6uKAJXj/E=;
 b=ZqD92ffd6kCpDHrD8K3YwpuJCEq8X/nutXuH/xJjxDXVegmFEtPC3lPpDBv+92FnCu
 306oRpB0JOPFlj4psM+076T/M0M8BqgyngkjzhtTPAvomjH78eDhA9awF7QrlTyhEbwU
 zwE2fDhGKXieSrSqgGfekywTWRBg84u/pGLtrAeq14kITsukagSfVcPQK98xI4l6kLat
 kuHfBVXIH/ox5g436+bGVBGtvkiVrZ6e/ZQCWHw9QY/sz/CWgq4DnbUIgBbjq1PDT1ev
 3Rg0KP95k8UWPVmgwG07IC4gCVyC953bo2Gh+fCo/Fu3z+HBiJb0b9VcR2WwZs0r3RM5
 IV5g==
X-Gm-Message-State: AOJu0YzDfSbGOZ1ATqROzdFKMuuAJLxjyVdqy21JObZU3McvKKK2D5li
 WSdJY3svTVWWFV56XzLpLrYCbuPq968tm/OMstgEsvQPx5YZjBNRsHjAryhJP982EkEwwdHuM9w
 3//oO1Yg=
X-Gm-Gg: AeBDiesK/WHtX03M/Ha4C8bvzKsg4arPvo7BtNsN/2ZT7hyfFKCsqeujsi1+psJC9Iu
 NdyvOgJoTYa7IK6tQIcStfyZEfaJ7aGVIQ5BSNyT9/bjSIE7rFKuizrt2TKiN9rCEz75o0JCJfd
 qypfNb0VppeOAGtJoek9Rsb4H3yoUFQhTVWehBvyN7eovq0undiz5hm8YaAzvV4TQ+sY2vHlGRF
 riqstNEJ5MpGlxWEWTd4Q1gWXz3lwbYPkT6LHT0EdmqCrxgV1TpOb1wlgekifdzUWIuV4K1eTO5
 jFJE0PV+LuOauEdjxDE2J+zES7yw+HSMz2gtrrgL0F5t92iflsYg/nNCGf66N0BxoHbEJr8TC0n
 876wF3hXYfL7bSP2HJMxBYch5C/te0ylWONZ83500PxU7WXhis7MtS5uSYIa/dJP0khQQDn6adU
 CCM0p8hDjcRZ/ViqkNIvAUvHF5CfSbR7Ici2SG36WcPf8kcypjCX8zYyAeaIoqme1slTJ58O3wL
 cWDxQneuWc=
X-Received: by 2002:a05:600c:a305:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48e5227db96mr34234345e9.5.1778076532304; 
 Wed, 06 May 2026 07:08:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5389da63sm49794045e9.4.2026.05.06.07.08.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:08:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 102/110] io: use g_clear_handle_id() for GSource cleanup
Date: Wed,  6 May 2026 15:55:14 +0200
Message-ID: <20260506135524.20617-103-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Use g_clear_handle_id() instead of g_source_remove() with
manual ID checking and zeroing.

This simplifies the code and ensures consistent handling of
GSource IDs, since g_clear_handle_id() checks for a non-zero
ID before calling the cleanup function and zeros it afterwards.

No functional change intended.

Mechanical change using the following Coccinelle spatch script:

  @@
  expression TAG;
  @@
  -    if (TAG > 0) {
  +    if (TAG) {
           g_source_remove(TAG);
           <... when != TAG
           TAG = 0;
           ...>
       }

  @@
  expression TAG;
  @@
  -    g_source_remove(TAG);
  -    TAG = 0;
  +    g_clear_handle_id(&TAG, g_source_remove);

  @@
  expression TAG;
  @@
  -    if (TAG) {
           g_clear_handle_id(&TAG, g_source_remove);
  -    }

Inspired-by: Matthew Penney <matt@matthewpenney.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Matthew Penney <matt@matthewpenney.net>
Message-Id: <20260408100605.66795-3-philmd@linaro.org>
---
 hw/char/cmsdk-apb-uart.c  |  5 +----
 hw/char/nrf51_uart.c      |  5 +----
 hw/char/serial.c          |  6 +-----
 hw/char/stm32l4x5_usart.c |  5 +----
 hw/char/terminal3270.c    |  5 +----
 hw/char/virtio-console.c  | 10 ++--------
 hw/usb/redirect.c         |  5 +----
 io/channel-websock.c      | 13 +++----------
 net/passt.c               |  8 ++------
 net/stream.c              | 15 +++------------
 net/stream_data.c         |  5 +----
 net/vhost-user.c          |  8 ++------
 ui/dbus-clipboard.c       |  6 ++----
 ui/input-barrier.c        |  6 +-----
 ui/vnc-auth-vencrypt.c    |  6 +-----
 ui/vnc-ws.c               | 12 ++----------
 16 files changed, 25 insertions(+), 95 deletions(-)

diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index edb80f61819..0631821a571 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -236,10 +236,7 @@ buffer_drained:
 
 static void uart_cancel_transmit(CMSDKAPBUART *s)
 {
-    if (s->watch_tag) {
-        g_source_remove(s->watch_tag);
-        s->watch_tag = 0;
-    }
+    g_clear_handle_id(&s->watch_tag, g_source_remove);
 }
 
 static void uart_write(void *opaque, hwaddr offset, uint64_t value,
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index 73069232441..96f0d085fdd 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -104,10 +104,7 @@ buffer_drained:
 
 static void uart_cancel_transmit(NRF51UARTState *s)
 {
-    if (s->watch_tag) {
-        g_source_remove(s->watch_tag);
-        s->watch_tag = 0;
-    }
+    g_clear_handle_id(&s->watch_tag, g_source_remove);
 }
 
 static void uart_write(void *opaque, hwaddr addr,
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0f3469a1e8f..0729cd2ce9d 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -856,11 +856,7 @@ const VMStateDescription vmstate_serial = {
 static void serial_reset(void *opaque)
 {
     SerialState *s = opaque;
-
-    if (s->watch_tag > 0) {
-        g_source_remove(s->watch_tag);
-        s->watch_tag = 0;
-    }
+    g_clear_handle_id(&s->watch_tag, g_source_remove);
 
     s->rbr = 0;
     s->ier = 0;
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 736f1e764e6..dd1b0991956 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -280,10 +280,7 @@ buffer_drained:
 
 static void usart_cancel_transmit(Stm32l4x5UsartBaseState *s)
 {
-    if (s->watch_tag) {
-        g_source_remove(s->watch_tag);
-        s->watch_tag = 0;
-    }
+    g_clear_handle_id(&s->watch_tag, g_source_remove);
 }
 
 static void stm32l4x5_update_params(Stm32l4x5UsartBaseState *s)
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 1d857bad9bc..989b6f6ee1e 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -52,10 +52,7 @@ static int terminal_can_read(void *opaque)
 
 static void terminal_timer_cancel(Terminal3270 *t)
 {
-    if (t->timer_tag) {
-        g_source_remove(t->timer_tag);
-        t->timer_tag = 0;
-    }
+    g_clear_handle_id(&t->timer_tag, g_source_remove);
 }
 
 /*
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index efe7cd6772e..4737b9a56eb 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -159,10 +159,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
         virtio_serial_open(port);
         break;
     case CHR_EVENT_CLOSED:
-        if (vcon->watch) {
-            g_source_remove(vcon->watch);
-            vcon->watch = 0;
-        }
+        g_clear_handle_id(&vcon->watch, g_source_remove);
         virtio_serial_close(port);
         break;
     case CHR_EVENT_BREAK:
@@ -255,10 +252,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
 static void virtconsole_unrealize(DeviceState *dev)
 {
     VirtConsole *vcon = VIRTIO_CONSOLE(dev);
-
-    if (vcon->watch) {
-        g_clear_handle_id(&vcon->watch, g_source_remove);
-    }
+    g_clear_handle_id(&vcon->watch, g_source_remove);
 }
 
 static void virtconsole_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 100afbdb06a..bde821e214b 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1226,10 +1226,7 @@ static void usbredir_chardev_close_bh(void *opaque)
         usbredirparser_destroy(dev->parser);
         dev->parser = NULL;
     }
-    if (dev->watch) {
-        g_source_remove(dev->watch);
-        dev->watch = 0;
-    }
+    g_clear_handle_id(&dev->watch, g_source_remove);
 }
 
 static void usbredir_create_parser(USBRedirDevice *dev)
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 617d79c351a..1929abf56ac 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -1066,10 +1066,7 @@ static gboolean qio_channel_websock_flush(QIOChannel *ioc,
 
 static void qio_channel_websock_unset_watch(QIOChannelWebsock *ioc)
 {
-    if (ioc->io_tag) {
-        g_source_remove(ioc->io_tag);
-        ioc->io_tag = 0;
-    }
+    g_clear_handle_id(&ioc->io_tag, g_source_remove);
 }
 
 static void qio_channel_websock_set_watch(QIOChannelWebsock *ioc)
@@ -1246,12 +1243,8 @@ static int qio_channel_websock_close(QIOChannel *ioc,
     buffer_free(&wioc->encinput);
     buffer_free(&wioc->encoutput);
     buffer_free(&wioc->rawinput);
-    if (wioc->hs_io_tag) {
-        g_clear_handle_id(&wioc->hs_io_tag, g_source_remove);
-    }
-    if (wioc->io_tag) {
-        g_clear_handle_id(&wioc->io_tag, g_source_remove);
-    }
+    g_clear_handle_id(&wioc->hs_io_tag, g_source_remove);
+    g_clear_handle_id(&wioc->io_tag, g_source_remove);
     if (wioc->io_err) {
         g_clear_pointer(&wioc->io_err, error_free);
     }
diff --git a/net/passt.c b/net/passt.c
index 4ff94ee509d..d3b5ab426c9 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -90,10 +90,7 @@ static void net_passt_cleanup(NetClientState *nc)
         g_free(s->vhost_net);
         s->vhost_net = NULL;
     }
-    if (s->vhost_watch) {
-        g_source_remove(s->vhost_watch);
-        s->vhost_watch = 0;
-    }
+    g_clear_handle_id(&s->vhost_watch, g_source_remove);
     qemu_chr_fe_deinit(&s->vhost_chr, true);
     if (s->vhost_user) {
         vhost_user_cleanup(s->vhost_user);
@@ -421,8 +418,7 @@ static void passt_vhost_user_event(void *opaque, QEMUChrEvent event)
         if (s->vhost_watch) {
             AioContext *ctx = qemu_get_current_aio_context();
 
-            g_source_remove(s->vhost_watch);
-            s->vhost_watch = 0;
+            g_clear_handle_id(&s->vhost_watch, g_source_remove);
             qemu_chr_fe_set_handlers(&s->vhost_chr, NULL, NULL,  NULL, NULL,
                                      NULL, NULL, false);
 
diff --git a/net/stream.c b/net/stream.c
index ea83f4a763a..6df4e251feb 100644
--- a/net/stream.c
+++ b/net/stream.c
@@ -71,24 +71,15 @@ static gboolean net_stream_send(QIOChannel *ioc,
 static void net_stream_cleanup(NetClientState *nc)
 {
     NetStreamState *s = DO_UPCAST(NetStreamState, data.nc, nc);
-    if (s->timer_tag) {
-        g_source_remove(s->timer_tag);
-        s->timer_tag = 0;
-    }
+    g_clear_handle_id(&s->timer_tag, g_source_remove);
     if (s->addr) {
         qapi_free_SocketAddress(s->addr);
         s->addr = NULL;
     }
     if (s->data.ioc) {
         if (QIO_CHANNEL_SOCKET(s->data.ioc)->fd != -1) {
-            if (s->data.ioc_read_tag) {
-                g_source_remove(s->data.ioc_read_tag);
-                s->data.ioc_read_tag = 0;
-            }
-            if (s->data.ioc_write_tag) {
-                g_source_remove(s->data.ioc_write_tag);
-                s->data.ioc_write_tag = 0;
-            }
+            g_clear_handle_id(&s->data.ioc_read_tag, g_source_remove);
+            g_clear_handle_id(&s->data.ioc_write_tag, g_source_remove);
         }
         object_unref(OBJECT(s->data.ioc));
         s->data.ioc = NULL;
diff --git a/net/stream_data.c b/net/stream_data.c
index 03740e9f73e..73b45da9fe3 100644
--- a/net/stream_data.c
+++ b/net/stream_data.c
@@ -84,10 +84,7 @@ void net_stream_data_rs_finalize(SocketReadState *rs)
     if (qemu_send_packet_async(&d->nc, rs->buf,
                                rs->packet_len,
                                net_stream_data_send_completed) == 0) {
-        if (d->ioc_read_tag) {
-            g_source_remove(d->ioc_read_tag);
-            d->ioc_read_tag = 0;
-        }
+        g_clear_handle_id(&d->ioc_read_tag, g_source_remove);
     }
 }
 
diff --git a/net/vhost-user.c b/net/vhost-user.c
index a4bb49bbcff..2d0fc49b4d8 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -215,10 +215,7 @@ static void net_vhost_user_cleanup(NetClientState *nc)
         s->vhost_net = NULL;
     }
     if (nc->queue_index == 0) {
-        if (s->watch) {
-            g_source_remove(s->watch);
-            s->watch = 0;
-        }
+        g_clear_handle_id(&s->watch, g_source_remove);
         qemu_chr_fe_deinit(&s->chr, true);
         if (s->vhost_user) {
             vhost_user_cleanup(s->vhost_user);
@@ -356,8 +353,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
         if (s->watch) {
             AioContext *ctx = qemu_get_current_aio_context();
 
-            g_source_remove(s->watch);
-            s->watch = 0;
+            g_clear_handle_id(&s->watch, g_source_remove);
             qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
                                      NULL, NULL, false);
 
diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index 935b6b1a2ac..90318384ee4 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -80,8 +80,7 @@ dbus_clipboard_update_info(DBusDisplay *dpy, QemuClipboardInfo *info)
     if (req->invocation && info->types[req->type].data) {
         dbus_clipboard_complete_request(dpy, req->invocation, info, req->type);
         g_clear_object(&req->invocation);
-        g_source_remove(req->timeout_id);
-        req->timeout_id = 0;
+        g_clear_handle_id(&req->timeout_id, g_source_remove);
         return;
     }
 
@@ -183,8 +182,7 @@ dbus_clipboard_request_cancelled(DBusClipboardRequest *req)
         "Cancelled clipboard request");
 
     g_clear_object(&req->invocation);
-    g_source_remove(req->timeout_id);
-    req->timeout_id = 0;
+    g_clear_handle_id(&req->timeout_id, g_source_remove);
 }
 
 static void
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 74724be8f45..042f63cc5a1 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -518,11 +518,7 @@ static void input_barrier_complete(UserCreatable *uc, Error **errp)
 static void input_barrier_instance_finalize(Object *obj)
 {
     InputBarrier *ib = INPUT_BARRIER(obj);
-
-    if (ib->ioc_tag) {
-        g_source_remove(ib->ioc_tag);
-        ib->ioc_tag = 0;
-    }
+    g_clear_handle_id(&ib->ioc_tag, g_source_remove);
 
     if (ib->sioc) {
         qio_channel_close(QIO_CHANNEL(ib->sioc), NULL);
diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
index d9c212ff328..a1b8cde2292 100644
--- a/ui/vnc-auth-vencrypt.c
+++ b/ui/vnc-auth-vencrypt.c
@@ -101,11 +101,7 @@ static int protocol_client_vencrypt_auth(VncState *vs, uint8_t *data, size_t len
         QIOChannelTLS *tls;
         vnc_write_u8(vs, 1); /* Accept auth */
         vnc_flush(vs);
-
-        if (vs->ioc_tag) {
-            g_source_remove(vs->ioc_tag);
-            vs->ioc_tag = 0;
-        }
+        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
 
         tls = qio_channel_tls_new_server(
             vs->ioc,
diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
index 9e3503d93d8..65e8b344b65 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -54,11 +54,7 @@ gboolean vncws_tls_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
     VncState *vs = opaque;
     QIOChannelTLS *tls;
     Error *err = NULL;
-
-    if (vs->ioc_tag) {
-        g_source_remove(vs->ioc_tag);
-        vs->ioc_tag = 0;
-    }
+    g_clear_handle_id(&vs->ioc_tag, g_source_remove);
 
     if (condition & (G_IO_HUP | G_IO_ERR)) {
         vnc_client_error(vs);
@@ -123,11 +119,7 @@ gboolean vncws_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
 {
     VncState *vs = opaque;
     QIOChannelWebsock *wioc;
-
-    if (vs->ioc_tag) {
-        g_source_remove(vs->ioc_tag);
-        vs->ioc_tag = 0;
-    }
+    g_clear_handle_id(&vs->ioc_tag, g_source_remove);
 
     if (condition & (G_IO_HUP | G_IO_ERR)) {
         vnc_client_error(vs);
-- 
2.53.0


