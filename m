Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56C606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i4AFQ+AX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqAM-0003jL-K6; Thu, 22 Oct 2026 06:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqAK-0003h7-K3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqAI-0007nW-VR
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ORcjhMpW22RpgZ9kIm64ECA3lO/OZ4kfUGGGdG/6eNI=;
 b=i4AFQ+AXyEOby+qErtLs4aD3TVv3Coz8dsvFikSuQj7NYajguQmvWFKb+BjWcW3LGI6tUL
 qT/XB7fNwQHV7hhB85xycyGXRpaSvyPVYg3ybFgV3+NzfoRb2Rcu6K8d/QdapxuvWBwTz5
 BAG8zw1HGBuXedfMuqntTUOP/JwGTI8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-aOct88rrPYGnQAp3RG7Phw-1; Thu,
 22 Oct 2026 10:36:45 +0000
X-MC-Unique: aOct88rrPYGnQAp3RG7Phw-1
X-Mimecast-MFC-AGG-ID: aOct88rrPYGnQAp3RG7Phw_1792665404
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 772931955E7A; Thu, 22 Oct 2026 10:36:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD84A30000E7; Thu, 22 Oct 2026 10:36:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Haotian Jiang <sundayjiang@tencent.com>,
	qemu-stable@nongnu.org
Subject: [PULL 07/11] usb-host: free request on libusb submit failure
Date: Thu, 22 Oct 2026 12:36:18 +0200
Message-ID: <20261022103622.1151089-8-thuth@redhat.com>
In-Reply-To: <20261022103622.1151089-1-thuth@redhat.com>
References: <20261022103622.1151089-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Haotian Jiang <sundayjiang@tencent.com>

When libusb_submit_transfer() fails in usb_host_handle_control() or
usb_host_handle_data(), the USBHostRequest already queued via
usb_host_req_alloc() is never freed and its r->p pointer is never
cleared.  The caller (xHCI) may then complete and free the
XHCITransfer that embeds the USBPacket r->p points to, leaving a
dangling pointer in s->requests.  A subsequent
usb_host_abort_xfers() -> usb_host_req_abort() dereferences
r->p->state on already-freed memory.

Call usb_host_req_free(r) before returning, matching the existing
pattern in the #else branch of the BULK_STREAMS case.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3595
Fixes: 2b2325ff6491 ("use libusb for usb-host")
Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <sundayjiang@tencent.com>
Signed-off-by: Haotian Jiang <sundayjiang@tencent.com>
Cc: qemu-stable@nongnu.org
---
 hw/usb/host-libusb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index cd566b91a37..bddd50903ae 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1526,6 +1526,13 @@ static void usb_host_handle_control(USBDevice *udev, USBPacket *p,
                                  CONTROL_TIMEOUT);
     rc = libusb_submit_transfer(r->xfer);
     if (rc != 0) {
+        /*
+         * Free the request to avoid a dangling r->p pointer.
+         * When libusb_submit_transfer fails the caller (xHCI) may
+         * free the XHCITransfer that holds the USBPacket r->p points
+         * to, so we must remove r from s->requests before returning.
+         */
+        usb_host_req_free(r);
         p->status = USB_RET_NODEV;
         trace_usb_host_req_complete(s->bus_num, s->addr, p,
                                     p->status, p->actual_length);
@@ -1620,6 +1627,13 @@ static void usb_host_handle_data(USBDevice *udev, USBPacket *p)
 
     rc = libusb_submit_transfer(r->xfer);
     if (rc != 0) {
+        /*
+         * Free the request to avoid a dangling r->p pointer.
+         * When libusb_submit_transfer fails the caller (xHCI) may
+         * free the XHCITransfer that holds the USBPacket r->p points
+         * to, so we must remove r from s->requests before returning.
+         */
+        usb_host_req_free(r);
         p->status = USB_RET_NODEV;
         trace_usb_host_req_complete(s->bus_num, s->addr, p,
                                     p->status, p->actual_length);
-- 
2.56.0


