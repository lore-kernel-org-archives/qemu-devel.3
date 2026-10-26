Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63991606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=KdpR4Z28
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLCh-00083V-MC; Mon, 26 Oct 2026 09:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLBV-0006ii-H6; Mon, 26 Oct 2026 09:56:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLBT-0000ET-8K; Mon, 26 Oct 2026 09:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=KQbgQSRkldu3KRJ1i5juwgQbWFyYHpvfKAuf6OU0lOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KdpR4Z28Lj3KHD3Y5W/5aN7SFCCpjdUrMbQH21jZjco55hyL5fO8mBCvn9nrAMNqK
 Ghd4hT7oMTDIauuXYP57qdqk7EtlobfZIxAzt2JN4YT1Qch+ZsMC5F7F1jig3+OfkP
 H38Xgi4cq3ObmFMDB4RHl64XbCNaPBpuGdEpzxjaETS7DCHSAldVXKlGRy86ieSSvu
 MX+l3Fuxayi4WnSuWdccNagqXCD63vCpD5ZNQIoZhOGRcrEPoqdE20n51+pqM5y8eB
 9pIwoRdCbyUqA6z2RAWQZPbR2kEsv8dlIkcxkutZzme8L1nlU0z1M4AI7dHGVE1EJ8
 mffMo5iP+BGYQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D6FC51E128A;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D4FCA44B8D6;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B1ECC934A3; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Haotian Jiang <sundayjiang@tencent.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 84/91] usb-host: delete bottom halves during
 unrealize
Date: Mon, 26 Oct 2026 16:54:27 +0300
Message-ID: <20261026135441.1019505-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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
(cherry picked from commit a86338565ceaede2fd7d90a8e0376131a20f0655)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 45f7bab53fc..410b5e3402a 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1278,6 +1278,21 @@ static void usb_host_unrealize(USBDevice *udev)
         QTAILQ_REMOVE(&hostdevs, s, next);
     }
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
2.47.3


