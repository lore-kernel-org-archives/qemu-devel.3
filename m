Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59473CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd6S-0004KL-Qs; Fri, 21 Nov 2025 21:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcjt-0000fc-3T; Fri, 21 Nov 2025 20:48:37 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMchq-0004oj-IV; Fri, 21 Nov 2025 20:48:32 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9971E16CA6E;
 Fri, 21 Nov 2025 21:44:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 54F0E321CAA;
 Fri, 21 Nov 2025 21:44:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 51/81] hw/net/e1000e_core: Don't advance desc_offset
 for NULL buffer RX descriptors
Date: Fri, 21 Nov 2025 21:43:50 +0300
Message-ID: <20251121184424.1137669-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

In e1000e_write_packet_to_guest() we don't write data for RX descriptors
where the buffer address is NULL (as required by the i82574 datasheet
section 7.1.7.2). However, when we do this we still update desc_offset
by the amount of data we would have written to the RX descriptor if
it had a valid buffer pointer, resulting in our dropping that data
entirely. The data sheet is not 100% clear on the subject, but this
seems unlikely to be the correct behaviour.

Rearrange the null-descriptor logic so that we don't treat these
do-nothing descriptors as if we'd really written the data.

This both fixes a bug and also is a prerequisite to cleaning up
the size calculation logic in the next patch.

(Cc to stable largely because it will be needed for the next patch,
which fixes a more serious bug.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 6da0c9828194eb21e54fe4264cd29a1b85a29f33)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 06657bb3ac..8e93bd3d81 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1481,7 +1481,6 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
     PCIDevice *d = core->owner;
     dma_addr_t base;
     union e1000_rx_desc_union desc;
-    size_t desc_size;
     size_t desc_offset = 0;
     size_t iov_ofs = 0;
 
@@ -1500,12 +1499,6 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
         E1000EBAState bastate = { { 0 } };
         bool is_last = false;
 
-        desc_size = total_size - desc_offset;
-
-        if (desc_size > core->rx_desc_buf_size) {
-            desc_size = core->rx_desc_buf_size;
-        }
-
         if (e1000e_ring_empty(core, rxi)) {
             return;
         }
@@ -1519,6 +1512,12 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
         e1000e_read_rx_descr(core, &desc, ba);
 
         if (ba[0]) {
+            size_t desc_size = total_size - desc_offset;
+
+            if (desc_size > core->rx_desc_buf_size) {
+                desc_size = core->rx_desc_buf_size;
+            }
+
             if (desc_offset < size) {
                 static const uint32_t fcs_pad;
                 size_t iov_copy;
@@ -1582,13 +1581,13 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                           (const char *) &fcs_pad, e1000x_fcs_len(core->mac));
                 }
             }
+            desc_offset += desc_size;
+            if (desc_offset >= total_size) {
+                is_last = true;
+            }
         } else { /* as per intel docs; skip descriptors with null buf addr */
             trace_e1000e_rx_null_descriptor();
         }
-        desc_offset += desc_size;
-        if (desc_offset >= total_size) {
-            is_last = true;
-        }
 
         e1000e_write_rx_descr(core, &desc, is_last ? core->rx_pkt : NULL,
                            rss_info, do_ps ? ps_hdr_len : 0, &bastate.written);
-- 
2.47.3


