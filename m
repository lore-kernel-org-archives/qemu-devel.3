Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35232606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZDvEVov+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqAB-0003ZR-C0; Thu, 22 Oct 2026 06:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqA9-0003Yo-AH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqA7-0007mG-M2
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LoCHlSQDLiTPE8LozK4UlEsDixMwrRTMtvcOvGREKss=;
 b=ZDvEVov+qNtIcgGLkKw4FFLKDEyUPouUQ//8mGUreU+5iDFrW6vD02oJx1kAOl8vAbmRGB
 V/NKrY6Qr0buttm64F35YtyQZszltBxE46R8YSkTlgLVDk8BjPXxfRHZ3nWf2ltJHqaRHh
 kLJN2rd+DHppiMJf3Q0/iA1yDHRrtms=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-ZBBZ41YVMV6J1CwuB3Ct_w-1; Thu,
 22 Oct 2026 10:36:41 +0000
X-MC-Unique: ZBBZ41YVMV6J1CwuB3Ct_w-1
X-Mimecast-MFC-AGG-ID: ZBBZ41YVMV6J1CwuB3Ct_w_1792665400
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53C8E18007F1; Thu, 22 Oct 2026 10:36:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80E8C30000E7; Thu, 22 Oct 2026 10:36:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 05/11] usb-host: free configuration descriptors on error paths
Date: Thu, 22 Oct 2026 12:36:16 +0200
Message-ID: <20261022103622.1151089-6-thuth@redhat.com>
In-Reply-To: <20261022103622.1151089-1-thuth@redhat.com>
References: <20261022103622.1151089-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
---
 hw/usb/host-libusb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index fd4a16ee8ad..cd566b91a37 100644
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
2.56.0


