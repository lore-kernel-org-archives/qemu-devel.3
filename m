Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C71BCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDL2C-0001fU-BP; Sun, 04 Oct 2026 08:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDDp4-0003Ot-5C
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 00:27:38 -0400
Received: from out-243.mta1.migadu.com ([2001:41d0:203:375::f3]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDDp2-0000Yc-Os
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 00:27:37 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=elPuTp0s27a7z8wLoajfymW/LnhbBjulq0S0uaBr+vU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791088054; v=1; x=1791692854;
 b=q1h2XGmlYawXl4UcADg7P9p3xZZ57aC6TfeFikLieNdG0MyWX2PdNP1Tw5NulCv41CpK8+24
 86oZHGH5T0C1TZJISg7Pfmz17qErhmW1MlLKVpGlQdQuiNenpNQaX/GgHaIxRVFsyRrY/EpdN3o
 OlNMQjZYggjhVEGQm0MqSzCw=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id a9a2d411480fa0b5;
 Sun, 04 Oct 2026 04:27:34 +0000
X-Mizu-Trace-ID: a9a2d411480fa0b5
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, kraxel@redhat.com, philmd@oss.qualcomm.com,
 junjie.cao@linux.dev, qemu-stable@nongnu.org
Subject: [PATCH 2/2] usb-host: free configuration descriptors on error paths
Date: Sat,  3 Oct 2026 23:27:22 -0500
Message-ID: <20261004042722.6937-3-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004042722.6937-1-junjie.cao@linux.dev>
References: <20261004042722.6937-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::f3;
 envelope-from=junjie.cao@linux.dev; helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 04 Oct 2026 08:09:35 -0400
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
---
 hw/usb/host-libusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index fd4a16ee8a..491302feb7 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -921,12 +921,12 @@ static void usb_host_ep_update(USBHostDevice *s)
             if (ep == 0) {
                 trace_usb_host_parse_error(s->bus_num, s->addr,
                                            "invalid endpoint address");
-                return;
+                goto out;
             }
             if (usb_ep_get_type(udev, pid, ep) != USB_ENDPOINT_XFER_INVALID) {
                 trace_usb_host_parse_error(s->bus_num, s->addr,
                                            "duplicate endpoint address");
-                return;
+                goto out;
             }
 
             trace_usb_host_parse_endpoint(s->bus_num, s->addr, ep,
@@ -949,6 +949,7 @@ static void usb_host_ep_update(USBHostDevice *s)
         }
     }
 
+out:
     libusb_free_config_descriptor(conf);
 }
 
@@ -1375,6 +1376,7 @@ static int usb_host_claim_interfaces(USBHostDevice *s, int configuration)
         }
     }
     if (claimed != conf->bNumInterfaces) {
+        libusb_free_config_descriptor(conf);
         return USB_RET_STALL;
     }
 
-- 
2.43.0


