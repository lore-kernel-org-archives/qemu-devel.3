Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07876CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDL29-0001fM-Sy; Sun, 04 Oct 2026 08:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDDoz-0003O6-LR
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 00:27:35 -0400
Received: from out-183.mta0.migadu.com ([2001:41d0:1004:224b::b7]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDDox-0000Y9-Dx
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 00:27:33 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=ax9fBPctRI5VB/kXfed2tmuY2qzivcYEU3dHEb1DoD4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791088048; v=1; x=1791692848;
 b=XlgUQFTKeMibp6B0TiE8cgx5eI9jIikErBqLunVoEGS513/KIwYDg26suHURgGVvtErzMkaT
 wXjHsP9oXLgzws7RowUUpQBJi02wc1eUmAvQO14i6se5tkNv7XEwhGTFMDMXTCG9OS2MgPblS6e
 eic/n7hy2TvPLIunJ1d6qK4Y=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 864923f81ec86d8b;
 Sun, 04 Oct 2026 04:27:28 +0000
X-Mizu-Trace-ID: 864923f81ec86d8b
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, kraxel@redhat.com, philmd@oss.qualcomm.com,
 junjie.cao@linux.dev, qemu-stable@nongnu.org
Subject: [PATCH 1/2] usb-host: validate interface number before indexing
 altsetting
Date: Sat,  3 Oct 2026 23:27:21 -0500
Message-ID: <20261004042722.6937-2-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004042722.6937-1-junjie.cao@linux.dev>
References: <20261004042722.6937-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::b7;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 04 Oct 2026 08:09:34 -0400
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

usb_host_ep_update() indexes USBDevice.altsetting with the interface
number supplied by the active configuration descriptor. A descriptor
with bInterfaceNumber >= USB_MAX_INTERFACES reads past that array while
the host device is opened. Skip such interfaces before the lookup.

Record the descriptor's interface number on its endpoints as well. The
loop index identifies the descriptor's position in the configuration,
which need not equal bInterfaceNumber.

Fixes: 0dbe4768b95 ("usb-host: use correct altsetting in usb_host_ep_update")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3975
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/usb/host-libusb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 629505c6d3..fd4a16ee8a 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -895,6 +895,11 @@ static void usb_host_ep_update(USBHostDevice *s)
          * then correct the alternate setting value if necessary.
          */
         intf = &conf->interface[i].altsetting[0];
+        if (intf->bInterfaceNumber >= USB_MAX_INTERFACES) {
+            trace_usb_host_parse_error(s->bus_num, s->addr,
+                                       "invalid interface number");
+            continue;
+        }
         alt = udev->altsetting[intf->bInterfaceNumber];
 
         if (alt != 0) {
@@ -930,7 +935,7 @@ static void usb_host_ep_update(USBHostDevice *s)
             usb_ep_set_max_packet_size(udev, pid, ep,
                                        endp->wMaxPacketSize);
             usb_ep_set_type(udev, pid, ep, type);
-            usb_ep_set_ifnum(udev, pid, ep, i);
+            usb_ep_set_ifnum(udev, pid, ep, intf->bInterfaceNumber);
             usb_ep_set_halted(udev, pid, ep, 0);
 #ifdef HAVE_STREAMS
             if (type == LIBUSB_TRANSFER_TYPE_BULK &&
-- 
2.43.0


