Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43378606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=EtnemE+5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLB7-0005ys-G8; Mon, 26 Oct 2026 09:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLB5-0005rY-HV; Mon, 26 Oct 2026 09:55:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLB3-0000CW-KM; Mon, 26 Oct 2026 09:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=233LRo0IGktcak9JOfaIIOtJnNlll5N4dIygyOmHi7E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EtnemE+5qEYZHt5ANx7cKnsNV/Loz+eIzzyjndngv9NWTlOYBYcOUgzlD/VS3GlX2
 yqvZcCjL0KPDgGWvonemImVgmjJm9xZXNFv8kUMkaR5DJlkyjAi9SWPtoBRvKs5FQX
 Tsij2BbXxqvLYps9Fj2zZM1D6NWAJtK23/YDDmnOHyf+QGismiDEYW9UCj0f0yTVgK
 wAx/DRTdzZsUUUp1MERTC4sEcUm6kpdttn0hlhsfm69EHN2movlpJzgWxuvVujl65R
 3fB0TX5lURfoTMCpTF5XSuYKtO0KWLWx1Pr8VpTLubsSvdJhT3JF4gcPzV2ALMg7Hz
 ynRC1KHwsHxJA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CAF311E1287;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C8F2A44B8D3;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A94429349D; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 81/91] usb-host: free configuration descriptors on
 error paths
Date: Mon, 26 Oct 2026 16:54:24 +0300
Message-ID: <20261026135441.1019505-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@intel.com>

usb_host_ep_update() returns before freeing the active configuration
descriptor when an endpoint address is invalid or duplicated.
usb_host_claim_interfaces() also returns without freeing it when fewer
interfaces can be claimed than the descriptor declares. Each failure
leaves one descriptor allocated.

Fixes: 2b2325ff6491 ("use libusb for usb-host")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261005054626.131577-3-junjie.cao@linux.dev>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 322894eed304f7f96283206bd1c35ba7e8e11d62)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 03b2eb9ba9a..88fea325531 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -67,6 +67,10 @@ typedef struct USBHostRequest USBHostRequest;
 typedef struct USBHostIsoXfer USBHostIsoXfer;
 typedef struct USBHostIsoRing USBHostIsoRing;
 
+typedef struct libusb_config_descriptor libusb_config_descriptor;
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(libusb_config_descriptor,
+                            libusb_free_config_descriptor)
+
 struct USBAutoFilter {
     uint32_t bus_num;
     uint32_t addr;
@@ -867,7 +871,7 @@ static void usb_host_ep_update(USBHostDevice *s)
         [USB_ENDPOINT_XFER_INT]     = "int",
     };
     USBDevice *udev = USB_DEVICE(s);
-    struct libusb_config_descriptor *conf;
+    g_autoptr(libusb_config_descriptor) conf = NULL;
     const struct libusb_interface_descriptor *intf;
     const struct libusb_endpoint_descriptor *endp;
 #ifdef HAVE_STREAMS
@@ -946,8 +950,6 @@ static void usb_host_ep_update(USBHostDevice *s)
 #endif
         }
     }
-
-    libusb_free_config_descriptor(conf);
 }
 
 static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
@@ -1346,7 +1348,7 @@ static void usb_host_attach_kernel(USBHostDevice *s)
 static int usb_host_claim_interfaces(USBHostDevice *s, int configuration)
 {
     USBDevice *udev = USB_DEVICE(s);
-    struct libusb_config_descriptor *conf;
+    g_autoptr(libusb_config_descriptor) conf = NULL;
     int rc, i, claimed;
 
     for (i = 0; i < USB_MAX_INTERFACES; i++) {
@@ -1384,7 +1386,6 @@ static int usb_host_claim_interfaces(USBHostDevice *s, int configuration)
     udev->ninterfaces   = conf->bNumInterfaces;
     udev->configuration = configuration;
 
-    libusb_free_config_descriptor(conf);
     return USB_RET_SUCCESS;
 }
 
-- 
2.47.3


