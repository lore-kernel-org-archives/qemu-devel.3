Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA607CDB480
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 03:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJkng-0004Hk-3R; Thu, 13 Nov 2025 22:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJkne-0004GB-6U
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJknb-00031c-Ue
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763092115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDWe/Jo9s6GZSG2mE5uJkOLbe7w1tYW6LfnxEy7o6ng=;
 b=fm+jauwienQDTs/7Xp56pd9QqyLSuairds4OSOdMGtK0K+WQCO+sfsuoqoZhzzUAzIjoR0
 Oh66qaI1ZKlsw+BWHacsGS6xQtnYAR/juQEsOPkSc0/1mCaGkzpI0Wk94RztdmeFQOGR1b
 jw+LtqYUDO1bPSN3nmcbchuFvBEXjUM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-2bEDFVxxNEylr9mkZqfrsw-1; Thu,
 13 Nov 2025 22:48:33 -0500
X-MC-Unique: 2bEDFVxxNEylr9mkZqfrsw-1
X-Mimecast-MFC-AGG-ID: 2bEDFVxxNEylr9mkZqfrsw_1763092112
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 306381800473; Fri, 14 Nov 2025 03:48:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9A15180035F; Fri, 14 Nov 2025 03:48:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 3/5] hw/net/e1000e_core: Correct rx oversize packet checks
Date: Fri, 14 Nov 2025 11:48:04 +0800
Message-ID: <20251114034806.2440-4-jasowang@redhat.com>
In-Reply-To: <20251114034806.2440-1-jasowang@redhat.com>
References: <20251114034806.2440-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/net/e1000e_core.c | 61 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index ba77cb6011..471c3ed20b 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1495,6 +1495,13 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
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
         E1000EBAState bastate = { { 0 } };
         bool is_last = false;
@@ -1512,23 +1519,27 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
         e1000e_read_rx_descr(core, &desc, ba);
 
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
@@ -1550,14 +1561,26 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                         } while (ps_hdr_copied < ps_hdr_len);
 
                         is_first = false;
+                        desc_size += ps_hdr_len;
                     } else {
                         /* Leave buffer 0 of each descriptor except first */
                         /* empty as per spec 7.1.5.1                      */
                         e1000e_write_hdr_frag_to_rx_buffers(core, ba, &bastate,
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
@@ -1574,12 +1597,22 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                         iov_ofs = 0;
                     }
                 }
+            }
 
-                if (desc_offset + desc_size >= total_size) {
-                    /* Simulate FCS checksum presence in the last descriptor */
-                    e1000e_write_payload_frag_to_rx_buffers(core, ba, &bastate,
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
+                e1000e_write_payload_frag_to_rx_buffers(core, ba, &bastate,
+                                                        (const char *)&fcs_pad,
+                                                        fcs_len);
+                desc_size += fcs_len;
             }
             desc_offset += desc_size;
             if (desc_offset >= total_size) {
-- 
2.42.0


