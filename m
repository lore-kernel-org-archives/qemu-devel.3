Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C93AE7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSilT-0002Ke-6u; Tue, 31 Dec 2024 15:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilS-0002KR-1N
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:22:54 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilQ-0000pL-6U
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:22:53 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361f796586so106894485e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676570; x=1736281370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCJRF8nuQG5tTIgpEkMZRXzly7JdxqT3IkSChLfB/Aw=;
 b=E5wpc+FT1Z4A0Z4IQArvNN0UPzcKFoyFEVofPXwiv6jycoCEQKmmX0Fk9XL1TDXQUK
 rSZGQ6ESDrk0Vrjd9rRgTTW9xO8PIYDI432sMDjMfEKWxsf2HzVF+51uHqRIB5yAVvNy
 t67YwTPlsgwRoCA54hI2+SWZ8BDiF822FQylO4sSmVWAT7RmOKUrx03MeuCR53l72QWg
 l4q9Ykj9Fd7L5NCrG+VOmjiseCh7v4z7VsWKXUo+01xCScN6odd05SoR4FB797mRA/x3
 sXvhVSuKso2dosCl/gWVPFzS63OdzTUdh3k9RjRuudP5Xtn1Gyt+zWIx8u/DcDmb2CPb
 K6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676570; x=1736281370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCJRF8nuQG5tTIgpEkMZRXzly7JdxqT3IkSChLfB/Aw=;
 b=logMu1FJiLJUrVMKyzhVcUKZziyJ7vDg2EwUNW+B8jOVTHw7B41I285M3GsYy1PREl
 xoHwuxW0BOHwVCWWN026Jmw4vw/pWlL4Rl+jnGN25BJNa1T5HHc1Blwe0gCvlMgelEOC
 JNXk90nLSetTiFhOgwFmtK+obirezBOoIs1IfaeHFGmQIrfagljkkCg/6Cdgb2w0d9y+
 bh8UAWmM/FNtXx8L+OpAwDoqia6MePaFuF/xZxlYdaDTAT9gLycMvjiJRUotG9LhPV0A
 tves/dLBd0T8VM3rtbxHqIgSfANgLlBH3yUMCORVlHs1vFsjtPmJPJaVkL6xmG8Js2LC
 kFgg==
X-Gm-Message-State: AOJu0YzHyIbLIn0E3yrf4nO2PyF+s17G0Ta31oiBPTg73ZXiV6QF+0Mf
 i4WpKO/rg6h/I0vhc4FeFZisRR+/cighhTr/QwjafjH6Nu39jXbCizYyU/Jc2PXayI1xvTNJdfE
 RdRI=
X-Gm-Gg: ASbGncu3wMrEqpNG10n3dnBw+fssQpJ0epstPnQFybVhTjnD5xyFPf5rkD2XBSq3Cli
 KDmze99gDAjwh0V7Z0+6+LoO1ZFS6L4c0BYivpE0tGvxRXXK+77BoJlb4l42bIdsetAizS6WtpG
 Zq+j/JCBc1r6oCaZskVMRmRRXAjU6V0rB7YFFtbsfovG3G7Oe9CQx5yEHSbRfaeEkIWKzprMMRH
 dnZkxKM8gF0OJ4WVjcmd978tBcwWLcsI08mqwDnqbrdKb9quyf0Y5OCHGhbipoGwC9olEsjLN2A
 ZhOQtsPWNgO+hniLJe+KtI340OPT3A4=
X-Google-Smtp-Source: AGHT+IGWXvd8Lu8TGXqjy+iMAMW0IVNvnXrewzYBUKeo0boOHMNHNhgI34wLFvs8TdPuhhdjbwUUJQ==
X-Received: by 2002:a05:600c:4709:b0:436:1ac2:1acf with SMTP id
 5b1f17b1804b1-43668a3a35dmr305419875e9.20.1735676570234; 
 Tue, 31 Dec 2024 12:22:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6c4esm432571125e9.4.2024.12.31.12.22.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:22:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/29] hw/usb/uhci: checkpatch cleanup
Date: Tue, 31 Dec 2024 21:22:03 +0100
Message-ID: <20241231202228.28819-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

Fix reported checkpatch issues to prepare for next patches
in the series.

No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20240906122542.3808997-2-linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-uhci.c | 90 +++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 0559b3ae3e1..7c0cc694554 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -67,7 +67,7 @@ struct UHCIPCIDeviceClass {
     UHCIInfo       info;
 };
 
-/* 
+/*
  * Pending async transaction.
  * 'packet' must be the first field because completion
  * handler does "(UHCIAsync *) pkt" cast.
@@ -220,8 +220,9 @@ static void uhci_async_cancel(UHCIAsync *async)
     uhci_async_unlink(async);
     trace_usb_uhci_packet_cancel(async->queue->token, async->td_addr,
                                  async->done);
-    if (!async->done)
+    if (!async->done) {
         usb_cancel_packet(&async->packet);
+    }
     uhci_async_free(async);
 }
 
@@ -322,7 +323,7 @@ static void uhci_reset(DeviceState *dev)
     s->fl_base_addr = 0;
     s->sof_timing = 64;
 
-    for(i = 0; i < UHCI_PORTS; i++) {
+    for (i = 0; i < UHCI_PORTS; i++) {
         port = &s->ports[i];
         port->ctrl = 0x0080;
         if (port->port.dev && port->port.dev->attached) {
@@ -387,7 +388,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
 
     trace_usb_uhci_mmio_writew(addr, val);
 
-    switch(addr) {
+    switch (addr) {
     case 0x00:
         if ((val & UHCI_CMD_RS) && !(s->cmd & UHCI_CMD_RS)) {
             /* start frame processing */
@@ -404,7 +405,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
             int i;
 
             /* send reset on the USB bus */
-            for(i = 0; i < UHCI_PORTS; i++) {
+            for (i = 0; i < UHCI_PORTS; i++) {
                 port = &s->ports[i];
                 usb_device_reset(port->port.dev);
             }
@@ -425,10 +426,13 @@ static void uhci_port_write(void *opaque, hwaddr addr,
         break;
     case 0x02:
         s->status &= ~val;
-        /* XXX: the chip spec is not coherent, so we add a hidden
-           register to distinguish between IOC and SPD */
-        if (val & UHCI_STS_USBINT)
+        /*
+         * XXX: the chip spec is not coherent, so we add a hidden
+         * register to distinguish between IOC and SPD
+         */
+        if (val & UHCI_STS_USBINT) {
             s->status2 = 0;
+        }
         uhci_update_irq(s);
         break;
     case 0x04:
@@ -436,8 +440,9 @@ static void uhci_port_write(void *opaque, hwaddr addr,
         uhci_update_irq(s);
         break;
     case 0x06:
-        if (s->status & UHCI_STS_HCHALTED)
+        if (s->status & UHCI_STS_HCHALTED) {
             s->frnum = val & 0x7ff;
+        }
         break;
     case 0x08:
         s->fl_base_addr &= 0xffff0000;
@@ -464,8 +469,8 @@ static void uhci_port_write(void *opaque, hwaddr addr,
             dev = port->port.dev;
             if (dev && dev->attached) {
                 /* port reset */
-                if ( (val & UHCI_PORT_RESET) &&
-                     !(port->ctrl & UHCI_PORT_RESET) ) {
+                if ((val & UHCI_PORT_RESET) &&
+                     !(port->ctrl & UHCI_PORT_RESET)) {
                     usb_device_reset(dev);
                 }
             }
@@ -487,7 +492,7 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
     UHCIState *s = opaque;
     uint32_t val;
 
-    switch(addr) {
+    switch (addr) {
     case 0x00:
         val = s->cmd;
         break;
@@ -533,12 +538,13 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
 }
 
 /* signal resume if controller suspended */
-static void uhci_resume (void *opaque)
+static void uhci_resume(void *opaque)
 {
     UHCIState *s = (UHCIState *)opaque;
 
-    if (!s)
+    if (!s) {
         return;
+    }
 
     if (s->cmd & UHCI_CMD_EGSM) {
         s->cmd |= UHCI_CMD_FGR;
@@ -674,7 +680,8 @@ static int uhci_handle_td_error(UHCIState *s, UHCI_TD *td, uint32_t td_addr,
     return ret;
 }
 
-static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async, uint32_t *int_mask)
+static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async,
+                            uint32_t *int_mask)
 {
     int len = 0, max_len;
     uint8_t pid;
@@ -682,8 +689,9 @@ static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async, uint32_
     max_len = ((td->token >> 21) + 1) & 0x7ff;
     pid = td->token & 0xff;
 
-    if (td->ctrl & TD_CTRL_IOS)
+    if (td->ctrl & TD_CTRL_IOS) {
         td->ctrl &= ~TD_CTRL_ACTIVE;
+    }
 
     if (async->packet.status != USB_RET_SUCCESS) {
         return uhci_handle_td_error(s, td, async->td_addr,
@@ -693,12 +701,15 @@ static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async, uint32_
     len = async->packet.actual_length;
     td->ctrl = (td->ctrl & ~0x7ff) | ((len - 1) & 0x7ff);
 
-    /* The NAK bit may have been set by a previous frame, so clear it
-       here.  The docs are somewhat unclear, but win2k relies on this
-       behavior.  */
+    /*
+     * The NAK bit may have been set by a previous frame, so clear it
+     * here.  The docs are somewhat unclear, but win2k relies on this
+     * behavior.
+     */
     td->ctrl &= ~(TD_CTRL_ACTIVE | TD_CTRL_NAK);
-    if (td->ctrl & TD_CTRL_IOC)
+    if (td->ctrl & TD_CTRL_IOC) {
         *int_mask |= 0x01;
+    }
 
     if (pid == USB_TOKEN_IN) {
         pci_dma_write(&s->dev, td->buffer, async->buf, len);
@@ -780,9 +791,11 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
 
     if (async) {
         if (queuing) {
-            /* we are busy filling the queue, we are not prepared
-               to consume completed packages then, just leave them
-               in async state */
+            /*
+             * we are busy filling the queue, we are not prepared
+             * to consume completed packages then, just leave them
+             * in async state
+             */
             return TD_RESULT_ASYNC_CONT;
         }
         if (!async->done) {
@@ -832,7 +845,7 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
     }
     usb_packet_addbuf(&async->packet, async->buf, max_len);
 
-    switch(pid) {
+    switch (pid) {
     case USB_TOKEN_OUT:
     case USB_TOKEN_SETUP:
         pci_dma_read(&s->dev, td->buffer, async->buf, max_len);
@@ -911,12 +924,15 @@ static void qhdb_reset(QhDb *db)
 static int qhdb_insert(QhDb *db, uint32_t addr)
 {
     int i;
-    for (i = 0; i < db->count; i++)
-        if (db->addr[i] == addr)
+    for (i = 0; i < db->count; i++) {
+        if (db->addr[i] == addr) {
             return 1;
+        }
+    }
 
-    if (db->count >= UHCI_MAX_QUEUES)
+    if (db->count >= UHCI_MAX_QUEUES) {
         return 1;
+    }
 
     db->addr[db->count++] = addr;
     return 0;
@@ -970,8 +986,10 @@ static void uhci_process_frame(UHCIState *s)
 
     for (cnt = FRAME_MAX_LOOPS; is_valid(link) && cnt; cnt--) {
         if (!s->completions_only && s->frame_bytes >= s->frame_bandwidth) {
-            /* We've reached the usb 1.1 bandwidth, which is
-               1280 bytes/frame, stop processing */
+            /*
+             * We've reached the usb 1.1 bandwidth, which is
+             * 1280 bytes/frame, stop processing
+             */
             trace_usb_uhci_frame_stop_bandwidth();
             break;
         }
@@ -1120,8 +1138,10 @@ static void uhci_frame_timer(void *opaque)
         uhci_async_validate_begin(s);
         uhci_process_frame(s);
         uhci_async_validate_end(s);
-        /* The spec says frnum is the frame currently being processed, and
-         * the guest must look at frnum - 1 on interrupt, so inc frnum now */
+        /*
+         * The spec says frnum is the frame currently being processed, and
+         * the guest must look at frnum - 1 on interrupt, so inc frnum now
+         */
         s->frnum = (s->frnum + 1) & 0x7ff;
         s->expire_time += frame_t;
     }
@@ -1174,7 +1194,7 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
 
     if (s->masterbus) {
         USBPort *ports[UHCI_PORTS];
-        for(i = 0; i < UHCI_PORTS; i++) {
+        for (i = 0; i < UHCI_PORTS; i++) {
             ports[i] = &s->ports[i].port;
         }
         usb_register_companion(s->masterbus, ports, UHCI_PORTS,
@@ -1200,8 +1220,10 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
     memory_region_init_io(&s->io_bar, OBJECT(s), &uhci_ioport_ops, s,
                           "uhci", 0x20);
 
-    /* Use region 4 for consistency with real hardware.  BSD guests seem
-       to rely on this.  */
+    /*
+     * Use region 4 for consistency with real hardware.  BSD guests seem
+     * to rely on this.
+     */
     pci_register_bar(&s->dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &s->io_bar);
 }
 
-- 
2.47.1


