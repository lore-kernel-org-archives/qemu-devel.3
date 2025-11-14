Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A39ECDB480
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 03:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJknc-0004BS-2I; Thu, 13 Nov 2025 22:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJkna-0004AB-JK
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJknX-0002s9-SS
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763092111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B12n4h98KrXE/P5ZV/agTiNlVPfk6RPTg54Baixv8Jo=;
 b=es0qj6Pcez3tsd1sFShREzBeN9Lg2Pxqfed2I4c95MCtvGTBbcDJufgoKJOZ9RxevD50aZ
 8R7JatzpcsC0rwaIyTXlSyfU2hXD+eo9yp5Oi0k1/leShRzaeJCKYTKA9zykI6xtxtfzbs
 Dt+bfGkWJBM2gP5aULe2LceO2/9dTnA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-VL4nS5Z4P02tMxXrQ2QrVg-1; Thu,
 13 Nov 2025 22:48:27 -0500
X-MC-Unique: VL4nS5Z4P02tMxXrQ2QrVg-1
X-Mimecast-MFC-AGG-ID: VL4nS5Z4P02tMxXrQ2QrVg_1763092107
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92ABB1956088; Fri, 14 Nov 2025 03:48:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3F0D180094C; Fri, 14 Nov 2025 03:48:21 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 2/5] hw/net/e1000e_core: Don't advance desc_offset for NULL
 buffer RX descriptors
Date: Fri, 14 Nov 2025 11:48:03 +0800
Message-ID: <20251114034806.2440-3-jasowang@redhat.com>
In-Reply-To: <20251114034806.2440-1-jasowang@redhat.com>
References: <20251114034806.2440-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/net/e1000e_core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 8fef598b49..ba77cb6011 100644
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
2.42.0


