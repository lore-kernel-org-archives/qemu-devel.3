Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5A606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cen1o3Zu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqAB-0003ZF-87; Thu, 22 Oct 2026 06:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqA8-0003Yc-Vc
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqA7-0007m8-7t
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7z3CZkKhLnq6xQGi3khZxgMwph5AE3TQ1rD/9vur7Q=;
 b=cen1o3ZuHEyMcxZxDa4bqi1DUbaR4J9h1ajAVn5irT7ShkzDenKHnk/zkKMyxR3f44goIf
 GVMG4g3h6oGhsI6XAYWoyHrTng627uAgKCdPxkBxZsEyFe3NwKDxDT5Lk1O2YqjjmH7Ggt
 DPQ2gaJ4BWOtLUcjWYSHXjLQpxwL+dw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-7LdTosYHO8W8CRuA71tk-A-1; Thu,
 22 Oct 2026 06:36:39 -0400
X-MC-Unique: 7LdTosYHO8W8CRuA71tk-A-1
X-Mimecast-MFC-AGG-ID: 7LdTosYHO8W8CRuA71tk-A_1792665398
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 266381955F6A; Thu, 22 Oct 2026 10:36:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 101B830000E7; Thu, 22 Oct 2026 10:36:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 04/11] usb-host: validate interface number before indexing
 altsetting
Date: Thu, 22 Oct 2026 12:36:15 +0200
Message-ID: <20261022103622.1151089-5-thuth@redhat.com>
In-Reply-To: <20261022103622.1151089-1-thuth@redhat.com>
References: <20261022103622.1151089-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@intel.com>

usb_host_ep_update() indexes USBDevice.altsetting with the interface
number supplied by the active configuration descriptor. A descriptor
with bInterfaceNumber >= USB_MAX_INTERFACES reads past that array while
the host device is opened. Skip such interfaces before the lookup.

Record the descriptor's interface number on its endpoints as well. The
loop index identifies the descriptor's position in the configuration,
which need not equal bInterfaceNumber.

Fixes: 0dbe4768b95e ("usb-host: use correct altsetting in usb_host_ep_update")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3975
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261005054626.131577-2-junjie.cao@linux.dev>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/host-libusb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 629505c6d35..fd4a16ee8ad 100644
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
2.56.0


