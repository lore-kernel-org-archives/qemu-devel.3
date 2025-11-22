Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0634CCFC53B
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 21:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMus4-0001eP-SK; Sat, 22 Nov 2025 16:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMurs-0001Ya-ET; Sat, 22 Nov 2025 16:10:04 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMuri-0007K5-FC; Sat, 22 Nov 2025 16:10:01 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7504516D30E;
 Sun, 23 Nov 2025 00:03:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2B2D23223E2;
 Sun, 23 Nov 2025 00:03:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.22 20/25] hw/net/e1000e_core: Correct rx oversize packet
 checks
Date: Sat, 22 Nov 2025 23:55:38 +0300
Message-ID: <20251122210344.48374-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
References: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

In e1000e_write_packet_to_guest() we attempt to ensure that we don't
write more of a packet to a descriptor than will fit in the guest
configured receive buffers.  However, this code does not allow for
the "packet split" feature.  When packet splitting is enabled, the
first of up to 4 buffers in the descriptor is used for the packet
header only, with the payload going into buffers 2, 3 and 4.  Our
length check only checks against the total sizes of all 4 buffers,
which meant that if an incoming packet was large enough to fit in (1
+ 2 + 3 + 4) but not into (2 + 3 + 4) and packet splitting was
enabled, we would run into the assertion in
e1000e_write_hdr_frag_to_rx_buffers() that we had enough buffers for
the data:

qemu-system-i386: ../../hw/net/e1000e_core.c:1418: void e1000e_write_payload_frag_to_rx_buffers(E1000ECore *, hwaddr *, E1000EBAState *, const char *, dma_addr_t): Assertion `bastate->cur_idx < MAX_PS_BUFFERS' failed.

A malicious guest could provoke this assertion by configuring the
device into loopback mode, and then sending itself a suitably sized
packet into a suitably arrange rx descriptor.

The code also fails to deal with the possibility that the descriptor
buffers are sized such that the trailing checksum word does not fit
into the last descriptor which has actual data, which might also
trigger this assertion.

Rework the length handling to use two variables:
 * desc_size is the total amount of data DMA'd to the guest
   for the descriptor being processed in this iteration of the loop
 * rx_desc_buf_size is the total amount of space left in it

As we copy data to the guest (packet header, payload, checksum),
update these two variables.  (Previously we attempted to calculate
desc_size once at the top of the loop, but this is too difficult to
do correctly.) Then we can use the variables to ensure that we clamp
the amount of copied payload data to the remaining space in the
descriptor's buffers, even if we've used one of the buffers up in the
packet-split code, and we can tell whether we have enough space for
the full checksum word in this descriptor or whether we're going to
need to split that to the following descriptor.

I have included comments that hopefully help to make the loop
logic a little clearer.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/537
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 9d946d56a2ac8a6c2df186e20d24810255c83a3f)
(Mjt: rename e1000e_write_payload_frag_to_rx_buffers back to
 e1000e_write_to_rx_buffers for 7.2.x, to compensate for missing in 7.2.x
 v8.1.0-693-g17ccd0164796 "igb: RX payload guest writting refactoring")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index be9c15f01e..deb070d17e 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1526,6 +1526,13 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
     rxi = rxr->i;
 
     do {
+        /*
+         * Loop processing descriptors while we have packet data to
+         * DMA to the guest.  desc_offset tracks how much data we have
+         * sent to the guest in total over all descriptors, and goes
+         * from 0 up to total_size (the size of everything to send to
+         * the guest including possible trailing 4 bytes of CRC data).
+         */
         hwaddr ba[MAX_PS_BUFFERS];
         e1000e_ba_state bastate = { { 0 } };
         bool is_last = false;
@@ -1543,23 +1550,27 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
         e1000e_read_rx_descr(core, desc, &ba);
 
         if (ba[0]) {
-            size_t desc_size = total_size - desc_offset;
-
-            if (desc_size > core->rx_desc_buf_size) {
-                desc_size = core->rx_desc_buf_size;
-            }
+            /* Total amount of data DMA'd to the guest in this iteration */
+            size_t desc_size = 0;
+            /*
+             * Total space available in this descriptor (we will update
+             * this as we use it up)
+             */
+            size_t rx_desc_buf_size = core->rx_desc_buf_size;
 
             if (desc_offset < size) {
-                static const uint32_t fcs_pad;
                 size_t iov_copy;
+                /* Amount of data to copy from the incoming packet */
                 size_t copy_size = size - desc_offset;
-                if (copy_size > core->rx_desc_buf_size) {
-                    copy_size = core->rx_desc_buf_size;
-                }
 
                 /* For PS mode copy the packet header first */
                 if (do_ps) {
                     if (is_first) {
+                        /*
+                         * e1000e_do_ps() guarantees that buffer 0 has enough
+                         * space for the header; otherwise we will not split
+                         * the packet (i.e. do_ps is false).
+                         */
                         size_t ps_hdr_copied = 0;
                         do {
                             iov_copy = MIN(ps_hdr_len - ps_hdr_copied,
@@ -1579,14 +1590,26 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                         } while (ps_hdr_copied < ps_hdr_len);
 
                         is_first = false;
+                        desc_size += ps_hdr_len;
                     } else {
                         /* Leave buffer 0 of each descriptor except first */
                         /* empty as per spec 7.1.5.1                      */
                         e1000e_write_hdr_to_rx_buffers(core, &ba, &bastate,
                                                        NULL, 0);
                     }
+                    rx_desc_buf_size -= core->rxbuf_sizes[0];
                 }
 
+                /*
+                 * Clamp the amount of packet data we copy into what will fit
+                 * into the remaining buffers in the descriptor.
+                 */
+                if (copy_size > rx_desc_buf_size) {
+                    copy_size = rx_desc_buf_size;
+                }
+                desc_size += copy_size;
+                rx_desc_buf_size -= copy_size;
+
                 /* Copy packet payload */
                 while (copy_size) {
                     iov_copy = MIN(copy_size, iov->iov_len - iov_ofs);
@@ -1601,12 +1624,22 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                         iov_ofs = 0;
                     }
                 }
+            }
 
-                if (desc_offset + desc_size >= total_size) {
-                    /* Simulate FCS checksum presence in the last descriptor */
-                    e1000e_write_to_rx_buffers(core, &ba, &bastate,
-                          (const char *) &fcs_pad, e1000x_fcs_len(core->mac));
-                }
+            if (rx_desc_buf_size &&
+                desc_offset >= size && desc_offset < total_size) {
+                /*
+                 * We are in the last 4 bytes corresponding to the FCS checksum.
+                 * We only ever write zeroes here (unlike the hardware).
+                 */
+                static const uint32_t fcs_pad;
+                /* Amount of space for the trailing checksum */
+                size_t fcs_len = MIN(rx_desc_buf_size,
+                                     total_size - desc_offset);
+                e1000e_write_to_rx_buffers(core, &ba, &bastate,
+                                           (const char *)&fcs_pad,
+                                           fcs_len);
+                desc_size += fcs_len;
             }
             desc_offset += desc_size;
             if (desc_offset >= total_size) {
-- 
2.47.3


