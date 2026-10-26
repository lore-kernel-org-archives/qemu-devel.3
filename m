Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE3606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=aI59n0Jq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLEJ-0003wi-75; Mon, 26 Oct 2026 09:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLE7-0003ZR-2y; Mon, 26 Oct 2026 09:59:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLE5-0000YE-9E; Mon, 26 Oct 2026 09:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022944; bh=+QPRYrgJje2Xiy+M3lvolT3LsgK3X+p0Dm6gibHq57w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aI59n0JqkmNfpnKbAHxfybtbiAdvG+leX9mb/egwqFn98pC7lFN1MGcB88JaN6nun
 CR0Ksk4MgZwOLypkdGsXmUYW8eQy+SsZ8GPoamtQITRY0kAUQYkSTP4EpC03oOQa94
 v4OOPvJaX/F3OenFGDrI6kFVzpy8sylqYqsLYwSROibtYSJ/aW+0KBcfLKTh2uo24x
 w3FktOUuoPdNgjNJNYnbzL82ScMc4QfpsXQ1CC4cMN6RKkUaa7gEuwZu4A4zhfcNCp
 YnF46nZwIc8V3xPH/aMW1h9ovI7+Tb2u/Fcg1H9RvFniR5g0Ji6wvwkqXKpD3d+XsM
 FINIVyaZJiQSQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 392311E12A9;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 36D2A44B8FA;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 14B2B934D9; Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Haotian Jiang <sundayjiang@tencent.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 v2 92/98] usb-host: delete bottom halves during
 unrealize
Date: Mon, 26 Oct 2026 16:55:19 +0300
Message-ID: <20261026135529.1019772-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
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
index 735d7c1844a..8dbf66f37b0 100644
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


