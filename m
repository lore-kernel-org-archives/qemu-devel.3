Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF32606A322
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B+AHGaMA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqAO-0003lB-FU; Thu, 22 Oct 2026 06:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqAM-0003jD-60
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqAJ-0007nl-Pa
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r25DjAHGho+AEFthyQtdMaPP7Iap18O1a7YHfENK1Jk=;
 b=B+AHGaMAQ2OLqnNh8eMcWyl3GJZiAA3BJ+s6J8GiBtT6gcocZ4O7W74XB89Ij9GP+dLrvE
 KP5xBtBGCZBq2wS7/KdZX3ns3geSnMNxtHj8i3txRU+0FM31WPbJTasrcZkcurG1pBLUV8
 8K1gHFpC5PvEXoh5f35kNCbZVAIfWCo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-kynUN4iLNe2E4LLf1hLnpA-1; Thu,
 22 Oct 2026 06:36:47 -0400
X-MC-Unique: kynUN4iLNe2E4LLf1hLnpA-1
X-Mimecast-MFC-AGG-ID: kynUN4iLNe2E4LLf1hLnpA_1792665406
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72F12180058A; Thu, 22 Oct 2026 10:36:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E750230001B9; Thu, 22 Oct 2026 10:36:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Haotian Jiang <sundayjiang@tencent.com>,
	qemu-stable@nongnu.org
Subject: [PULL 08/11] usb-host: delete bottom halves during unrealize
Date: Thu, 22 Oct 2026 12:36:19 +0200
Message-ID: <20261022103622.1151089-9-thuth@redhat.com>
In-Reply-To: <20261022103622.1151089-1-thuth@redhat.com>
References: <20261022103622.1151089-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haotian Jiang <sundayjiang@tencent.com>

usb_host_nodev() lazily creates s->bh_nodev and
usb_host_post_load() lazily creates s->bh_postld, but
usb_host_unrealize() never calls qemu_bh_delete() on either.  If a BH
is still pending when unrealize returns, its callback dereferences the
freed USBHostDevice.

Delete both BHs in usb_host_unrealize() after usb_host_close()
returns.  They must be deleted after close because usb_host_close()
can process libusb callbacks that call usb_host_nodev(), which lazily
recreates bh_nodev.  Deleting it before close could therefore leave a
recreated BH alive after unrealize.

Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/3595
Fixes: 95efb20c7148 ("usb-host: live migration support for the libusb version")
Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <sundayjiang@tencent.com>
Signed-off-by: Haotian Jiang <sundayjiang@tencent.com>
Cc: qemu-stable@nongnu.org
---
 hw/usb/host-libusb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index bddd50903ae..8f7ced95cfe 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1275,6 +1275,21 @@ static void usb_host_unrealize(USBDevice *udev)
     qemu_remove_exit_notifier(&s->exit);
     QTAILQ_REMOVE(&hostdevs, s, next);
     usb_host_close(s);
+    /*
+     * Delete bottom halves after usb_host_close().  During close,
+     * libusb callbacks (usb_host_req_complete_ctrl/data) can call
+     * usb_host_nodev() which lazily creates bh_nodev.  If we
+     * deleted them before close, a newly created BH would leak and
+     * fire after unrealize, dereferencing freed USBHostDevice.
+     */
+    if (s->bh_nodev) {
+        qemu_bh_delete(s->bh_nodev);
+        s->bh_nodev = NULL;
+    }
+    if (s->bh_postld) {
+        qemu_bh_delete(s->bh_postld);
+        s->bh_postld = NULL;
+    }
 }
 
 static void usb_host_cancel_packet(USBDevice *udev, USBPacket *p)
-- 
2.56.0


