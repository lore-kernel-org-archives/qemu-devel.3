Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF27DC4453F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPc-0008T6-Td; Wed, 22 Jul 2026 08:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWOx-0004gi-2E; Wed, 22 Jul 2026 08:50:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWOu-0001yz-Bx; Wed, 22 Jul 2026 08:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724391; bh=B8CzTrWFjDMpFD+y+AofC4iV2Gnd4/FxHOTRymy9Dto=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FzDyDbBAXHioQpgrPtfx3G+VXk9RrhhzDXKc+/07wDI6DNvIf98TNvDmQJBUxrPhX
 kB0DLvmRo2WWeGzM3qRs4YfAOldUxBSRcbLm1fl+4pApKp20PN5MUGx82AqhVxdfEf
 52BBoogf9efPdiKR1EZwi0sp8tL/TrMY6lKN26wt0VPGox7r4v28mcga9C56qYwy3T
 cVKyzNubCTlet9xDisMQnL0PrGps0ES+TNVCU3Bp7GA59J12BSKtZ90yGhdBttID9G
 TTy8yMoaQJFEtViqxj1y2YGbtEj29QIX4/spjW8l8QN5BIqGbPnmhsq5VrO4lEd8pU
 JImHUE0jJwseg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 03A821C3B1A;
 Wed, 22 Jul 2026 15:46:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4B31B3F3774;
 Wed, 22 Jul 2026 15:46:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8FF0017F1D; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 113/122] usbredir: fix infinite loop and SIGFPE
 with zero max_packet_size
Date: Wed, 22 Jul 2026 15:46:02 +0300
Message-ID: <20260722124622.31034-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

A malicious usbredir peer can send an ep_info message resetting
max_packet_size to 0 after bulk receiving has started. This causes:
- infinite loop in usbredir_buffered_bulk_packet() where the splitting
  loop increments by max_packet_size (0)
- SIGFPE in usbredir_buffered_bulk_in_complete_ftdi() from modulo by 0
- SIGFPE in usbredir_handle_buffered_bulk_in_data() from division by 0
  when computing bytes_per_transfer

Fix by stopping and disabling bulk receiving in usbredir_ep_info() when
max_packet_size is set to 0.

Add post-load check, and assert() for the invariant.

Fixes: CVE-2026-63319
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3995
Reported-by: Tristan @TristanInSec
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260716141107.3597076-1-marcandre.lureau@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit a002485bfef184f04a58adfd2a848c19f583f7d0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 72131289a8f..bbd3a7a47f8 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -690,6 +690,7 @@ static void usbredir_buffered_bulk_in_complete_ftdi(USBRedirDevice *dev,
     struct buf_packet *bulkp;
     int count;
 
+    assert(maxp != 0);
     while ((bulkp = QTAILQ_FIRST(&dev->endpoint[EP2I(ep)].bufpq)) &&
            p->actual_length < p->iov.size && p->status == USB_RET_SUCCESS) {
         if (bulkp->len < 2) {
@@ -739,6 +740,7 @@ static void usbredir_handle_buffered_bulk_in_data(USBRedirDevice *dev,
             .stream_id = 0,
             .no_transfers = 5,
         };
+        assert(dev->endpoint[EP2I(ep)].max_packet_size != 0);
         /* Round bytes_per_transfer up to a multiple of max_packet_size */
         bpt = 512 + dev->endpoint[EP2I(ep)].max_packet_size - 1;
         bpt /= dev->endpoint[EP2I(ep)].max_packet_size;
@@ -793,6 +795,7 @@ static void usbredir_handle_bulk_data(USBRedirDevice *dev, USBPacket *p,
     }
 
     if (dev->endpoint[EP2I(ep)].bulk_receiving_enabled) {
+        assert(maxp != 0);
         if (size != 0 && (size % maxp) == 0) {
             usbredir_handle_buffered_bulk_in_data(dev, p, ep);
             return;
@@ -1801,6 +1804,17 @@ static void usbredir_ep_info(void *priv,
         if (usbredirparser_peer_has_cap(dev->parser,
                                      usb_redir_cap_ep_info_max_packet_size)) {
             dev->endpoint[i].max_packet_size = ep_info->max_packet_size[i];
+            if (ep_info->max_packet_size[i] == 0 &&
+                dev->endpoint[i].bulk_receiving_enabled) {
+                USBPacket *p = dev->endpoint[i].pending_async_packet;
+                usbredir_stop_bulk_receiving(dev, I2EP(i));
+                dev->endpoint[i].bulk_receiving_enabled = 0;
+                if (p != NULL) {
+                    dev->endpoint[i].pending_async_packet = NULL;
+                    p->status = USB_RET_IOERROR;
+                    usb_packet_complete(&dev->dev, p);
+                }
+            }
         }
 #if USBREDIR_VERSION >= 0x000700
         if (usbredirparser_peer_has_cap(dev->parser,
@@ -2161,6 +2175,7 @@ static void usbredir_buffered_bulk_packet(void *priv, uint64_t id,
     }
 
     /* Data must be in maxp chunks for buffered_bulk_add_*_data_to_packet */
+    assert(dev->endpoint[EP2I(ep)].max_packet_size != 0);
     len = dev->endpoint[EP2I(ep)].max_packet_size;
     status = usb_redir_success;
     free_on_destroy = NULL;
@@ -2244,6 +2259,15 @@ static int usbredir_post_load(void *priv, int version_id)
     usbredir_setup_usb_eps(dev);
     usbredir_check_bulk_receiving(dev);
 
+    for (int i = 0; i < MAX_ENDPOINTS; i++) {
+        if (dev->endpoint[i].bulk_receiving_started &&
+            dev->endpoint[i].max_packet_size == 0) {
+            error_report("usbredir: endpoint %d has bulk receiving started "
+                         "with zero max_packet_size", i);
+            return -EINVAL;
+        }
+    }
+
     return 0;
 }
 
-- 
2.47.3


