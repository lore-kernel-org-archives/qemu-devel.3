Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC899C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dDv-0003MK-Cu; Thu, 10 Sep 2026 07:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDt-0003Lr-Ns
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:45 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1x4dDr-0000RI-Vj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:45 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 86A2E240034
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1789040742;
 bh=RQE8kVjM2ZpPb2hxTQo4STWGeSQiKv8zS+tFeXX1RhE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=XwMllBUiFP2AXtz4oJbApU3D0NIp3sxx5nOqFBcvdA0/h8dqCAKK1UcHwupCk9IRK
 sfSLIdKVYGB6hIqUL8p9AEKFGiIZr1aV9gEfNHVpOeu4DZ+J6B3w5I2nonFqwxA9YG
 rFs83jfZ7cegrcBfYheke/bnKBGyBgRJwGWuAIVPS6V3E18R/cI5nGpSiLMUvQNWI3
 7NUVBorpB3aGrgiK/85rZzj2HdWAJj3K9mQi1WN9vgdMLc9Qx7ziNHSnhlEDqAD13g
 PHQa7ISGHZiXXLMWemIdIm9WPFku8OyRvEomfuDcdB9QlPQe0ZQXWHo5ll8XNHSxb+
 YFxr039ae6AQA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hgbTd3n3kz6v1t;
 Thu, 10 Sep 2026 13:45:41 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 7/7] hw/usb/host-libusb: keep autoscan enabled for bus+addr
 selector
Date: Thu, 10 Sep 2026 11:45:42 +0000
Message-ID: <20260910114522.396396-8-th.huth@posteo.eu>
In-Reply-To: <20260910114522.396396-1-th.huth@posteo.eu>
References: <20260910114522.396396-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Timo Teräs <timo.teras@iki.fi>

This is partial revert of commit e058fa2dd599.

The portion to immediately validate the device is kept, but this
adds and enables again the autoscan functionality. This is needed
to detect and relay USB device disconnect event to the guest.

Fixes: e058fa2dd599 ("usb-host: add special case for bus+addr")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3111
Signed-off-by: Timo Teräs <timo.teras@iki.fi>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20250912-usbhost-disconnect-v1-1-9c7c5fa9b50a@iki.fi>
Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 hw/usb/host-libusb.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 564fe9a547..629505c6d3 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -91,7 +91,6 @@ struct USBHostDevice {
     uint32_t                         iso_urb_frames;
     uint32_t                         options;
     uint32_t                         loglevel;
-    bool                             needs_autoscan;
     bool                             allow_one_guest_reset;
     bool                             allow_all_guest_resets;
     bool                             suppress_remote_wake;
@@ -1214,7 +1213,6 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
 #if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN32)
     if (s->hostdevice) {
         int fd;
-        s->needs_autoscan = false;
         fd = qemu_open(s->hostdevice, O_RDWR, errp);
         if (fd < 0) {
             return;
@@ -1230,7 +1228,6 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
         !s->match.vendor_id &&
         !s->match.product_id &&
         !s->match.port) {
-        s->needs_autoscan = false;
         ldev = usb_host_find_ref(s->match.bus_num,
                                  s->match.addr);
         if (!ldev) {
@@ -1245,14 +1242,13 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
                        s->match.bus_num, s->match.addr);
             return;
         }
-    } else {
-        s->needs_autoscan = true;
-        QTAILQ_INSERT_TAIL(&hostdevs, s, next);
-        usb_host_auto_check(NULL);
     }
 
     s->exit.notify = usb_host_exit_notifier;
     qemu_add_exit_notifier(&s->exit);
+
+    QTAILQ_INSERT_TAIL(&hostdevs, s, next);
+    usb_host_auto_check(NULL);
 }
 
 static void usb_host_instance_init(Object *obj)
@@ -1270,9 +1266,7 @@ static void usb_host_unrealize(USBDevice *udev)
     USBHostDevice *s = USB_HOST_DEVICE(udev);
 
     qemu_remove_exit_notifier(&s->exit);
-    if (s->needs_autoscan) {
-        QTAILQ_REMOVE(&hostdevs, s, next);
-    }
+    QTAILQ_REMOVE(&hostdevs, s, next);
     usb_host_close(s);
 }
 
-- 
2.55.0


