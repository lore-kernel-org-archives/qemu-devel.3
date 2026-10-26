Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C10606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=N2nAZyrd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLBt-00075D-RX; Mon, 26 Oct 2026 09:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLBS-0006dl-Ln; Mon, 26 Oct 2026 09:56:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLBR-0000Cw-02; Mon, 26 Oct 2026 09:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=Af45Vezz1SYz4Kf/Beskg1j3JPB59ge7yYAQllzek+s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N2nAZyrd/2VT5vcsozk2ZcFDeZlfGYRKexDhRK7f/riGig8+sNCBYIDT+2A5RTz2l
 zrW3kei3+wXBuzqqqmGY0zJDiMhX9jhwNWf5PVSqZHUdArGwO1rNM7TKTYbofXqxT8
 bxvzpIGBXK395/Mezp1rqxYs0b3ZVh/2Emr+LTkzh/1wbwse0Dgnhjqvo/b1RqsAYf
 34hEOcgaQzdvsAMPG809s99pwdX5W5Xk9rU4cgMwi+5D6wHB7OPIS5Wfmj82eoPThn
 Ua08GNqQbrxioJ76YVOxVaQsoXZUDS+plwUadTNUPSBFu5Vjo9pPlG8s/SXtHDjFgX
 8dOogi1BYBWlQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D38341E1289;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D118144B8D5;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AEFC4934A1; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Haotian Jiang <sundayjiang@tencent.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 83/91] usb-host: free request on libusb submit
 failure
Date: Mon, 26 Oct 2026 16:54:26 +0300
Message-ID: <20261026135441.1019505-20-mjt@tls.msk.ru>
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
(cherry picked from commit 59cb5109101330fdc4588cbd5a081deeed0cd493)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 88fea325531..45f7bab53fc 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1529,6 +1529,13 @@ static void usb_host_handle_control(USBDevice *udev, USBPacket *p,
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
@@ -1623,6 +1630,13 @@ static void usb_host_handle_data(USBDevice *udev, USBPacket *p)
 
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
2.47.3


