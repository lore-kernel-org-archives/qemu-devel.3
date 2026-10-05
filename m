Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04C3CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 05:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDbXA-0004O6-OK; Mon, 05 Oct 2026 01:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDbX8-0004Mq-MQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 01:46:42 -0400
Received: from out-124.mta0.migadu.com ([2001:41d0:1004:224b::7c]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDbX7-0004N1-56
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 01:46:42 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=V5JbHUDQk9juK8ID8enOSJfvYH9uKTJ1dBJjdDogtsg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791179199; v=1; x=1791783999;
 b=UpXp+yRWzO2h+SaT9gZzD8BaJtYlkQnkU9ZrKuOXRzNElaaWkj/b/slecLFC9vDY6HhdyD5F
 0cuaRT7zYCUlTKKH6FOBLGNN5U8Du0gq3wQ0GLpWbnBdFH5rlhnxhF1eyI7y9LgSyZpUpoJs4MS
 lObac8XFh47OglOTeCzvKEHU=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id b07023f2fe71d6c0;
 Mon, 05 Oct 2026 05:46:39 +0000
X-Mizu-Trace-ID: b07023f2fe71d6c0
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, kraxel@redhat.com, philmd@oss.qualcomm.com,
 marcandre.lureau@redhat.com, junjie.cao@linux.dev, qemu-stable@nongnu.org
Subject: [PATCH v2 2/2] usb-host: free configuration descriptors on error paths
Date: Mon,  5 Oct 2026 00:46:26 -0500
Message-ID: <20261005054626.131577-3-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005054626.131577-1-junjie.cao@linux.dev>
References: <20261005054626.131577-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::7c;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Junjie Cao <junjie.cao@intel.com>

usb_host_ep_update() returns before freeing the active configuration
descriptor when an endpoint address is invalid or duplicated.
usb_host_claim_interfaces() also returns without freeing it when fewer
interfaces can be claimed than the descriptor declares. Each failure
leaves one descriptor allocated.

Fixes: 2b2325ff64 ("use libusb for usb-host")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/host-libusb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index fd4a16ee8a..cd566b91a3 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -68,6 +68,10 @@ typedef struct USBHostRequest USBHostRequest;
 typedef struct USBHostIsoXfer USBHostIsoXfer;
 typedef struct USBHostIsoRing USBHostIsoRing;
 
+typedef struct libusb_config_descriptor libusb_config_descriptor;
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(libusb_config_descriptor,
+                            libusb_free_config_descriptor)
+
 struct USBAutoFilter {
     uint32_t bus_num;
     uint32_t addr;
@@ -869,7 +873,7 @@ static void usb_host_ep_update(USBHostDevice *s)
         [USB_ENDPOINT_XFER_INT]     = "int",
     };
     USBDevice *udev = USB_DEVICE(s);
-    struct libusb_config_descriptor *conf;
+    g_autoptr(libusb_config_descriptor) conf = NULL;
     const struct libusb_interface_descriptor *intf;
     const struct libusb_endpoint_descriptor *endp;
 #ifdef HAVE_STREAMS
@@ -948,8 +952,6 @@ static void usb_host_ep_update(USBHostDevice *s)
 #endif
         }
     }
-
-    libusb_free_config_descriptor(conf);
 }
 
 static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
@@ -1343,7 +1345,7 @@ static void usb_host_attach_kernel(USBHostDevice *s)
 static int usb_host_claim_interfaces(USBHostDevice *s, int configuration)
 {
     USBDevice *udev = USB_DEVICE(s);
-    struct libusb_config_descriptor *conf;
+    g_autoptr(libusb_config_descriptor) conf = NULL;
     int rc, i, claimed;
 
     for (i = 0; i < USB_MAX_INTERFACES; i++) {
@@ -1381,7 +1383,6 @@ static int usb_host_claim_interfaces(USBHostDevice *s, int configuration)
     udev->ninterfaces   = conf->bNumInterfaces;
     udev->configuration = configuration;
 
-    libusb_free_config_descriptor(conf);
     return USB_RET_SUCCESS;
 }
 
-- 
2.43.0


