Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C3606B0E4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GdA4PpxU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuw3-0007H7-Me; Mon, 02 Nov 2026 11:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuw1-00078W-NU
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:31:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuvz-0002Pk-Pw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=87ExfFHZFD95QHZX5dNBYrN9jmmMcRmJcsTv/jdDa/s=;
 b=GdA4PpxUWhdJ2UlCd0NQhHCaWUwWyrY9zRyEZVMS+nsBMu5ER0wUwzKaIsLE5XsC60todt
 h2cpN3aXO2JwmBqJ1tttEKTHOgocYlGKdpNgFonkzzmJykMSl7wTdldlWxD8oJzNdvDi6V
 hmTkrcCvkyL0EegWru1EW3fcSQ1hSTw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-ToivS_rxNZ-JbGS6VTZjJw-1; Mon,
 02 Nov 2026 11:30:56 -0500
X-MC-Unique: ToivS_rxNZ-JbGS6VTZjJw-1
X-Mimecast-MFC-AGG-ID: ToivS_rxNZ-JbGS6VTZjJw_1793637055
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71C071800661; Mon,  2 Nov 2026 16:30:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.50])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED66E1800444; Mon,  2 Nov 2026 16:30:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@linux.dev>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/5] hw/usb/hcd-xhci: fail Address Device when the DCBAA entry
 is unreadable
Date: Mon,  2 Nov 2026 17:30:43 +0100
Message-ID: <20261102163044.644663-5-thuth@redhat.com>
In-Reply-To: <20261102163044.644663-1-thuth@redhat.com>
References: <20261102163044.644663-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Junjie Cao <junjie.cao@linux.dev>

xhci_address_slot() ignores the result of reading the slot's DCBAA
entry. When that read fails the output context pointer is whatever the
failed read left behind, zero for unassigned memory, so the slot and
ep0 contexts land at guest address 0 and the command completes with
Success.

Log the failed read and raise HCE, as the context DMA helpers do, and
return TRB Error, as Address Device already does for an unreadable
input control context. xhci_die() only flags HCE and leaves the
controller running; the HSE and halt of xHCI 1.2 section 4.10.2.6 are
not added here.

usb_xhci_post_load() reads the same entry; a failure there now disables
the slot, as an unresolvable slot context already does.

Fixes: 62c6ae04cf43 ("xhci: Initial xHCI implementation")
Fixes: 37352df30fbc ("xhci: add live migration support")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4706
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
Message-ID: <20261031033725.1275414-2-junjie.cao@linux.dev>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-xhci.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 5d7a77b8bcf..b5cc1ad2ff5 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -534,6 +534,23 @@ static inline void xhci_dma_write_u32s(XHCIState *xhci, dma_addr_t addr,
     }
 }
 
+static bool xhci_read_dcbaa(XHCIState *xhci, unsigned int slotid,
+                            dma_addr_t *octx)
+{
+    dma_addr_t dcbaap = xhci_addr64(xhci->dcbaap_low, xhci->dcbaap_high);
+    uint64_t poctx;
+
+    if (ldq_le_dma(xhci->as, dcbaap + 8 * slotid, &poctx,
+                   MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: DMA memory access failed!\n",
+                      __func__);
+        xhci_die(xhci);
+        return false;
+    }
+    *octx = xhci_mask64(poctx);
+    return true;
+}
+
 static XHCIPort *xhci_lookup_port(XHCIState *xhci, struct USBPort *uport)
 {
     int index;
@@ -2103,8 +2120,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, unsigned int slotid,
     XHCISlot *slot;
     USBPort *uport;
     USBDevice *dev;
-    dma_addr_t ictx, octx, dcbaap;
-    uint64_t poctx;
+    dma_addr_t ictx, octx;
     uint32_t ictl_ctx[2];
     uint32_t slot_ctx[4];
     uint32_t ep0_ctx[5];
@@ -2113,10 +2129,10 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, unsigned int slotid,
 
     assert(slotid >= 1 && slotid <= xhci->numslots);
 
-    dcbaap = xhci_addr64(xhci->dcbaap_low, xhci->dcbaap_high);
-    ldq_le_dma(xhci->as, dcbaap + 8 * slotid, &poctx, MEMTXATTRS_UNSPECIFIED);
+    if (!xhci_read_dcbaa(xhci, slotid, &octx)) {
+        return CC_TRB_ERROR;
+    }
     ictx = xhci_mask64(pictx);
-    octx = xhci_mask64(poctx);
 
     DPRINTF("xhci: input context at "DMA_ADDR_FMT"\n", ictx);
     DPRINTF("xhci: output context at "DMA_ADDR_FMT"\n", octx);
@@ -3522,24 +3538,21 @@ static int usb_xhci_post_load(void *opaque, int version_id)
     XHCIState *xhci = opaque;
     XHCISlot *slot;
     XHCIEPContext *epctx;
-    dma_addr_t dcbaap, pctx;
+    dma_addr_t pctx;
     uint32_t slot_ctx[4];
     uint32_t ep_ctx[5];
     int slotid, epid, state;
-    uint64_t addr;
-
-    dcbaap = xhci_addr64(xhci->dcbaap_low, xhci->dcbaap_high);
 
     for (slotid = 1; slotid <= xhci->numslots; slotid++) {
         slot = &xhci->slots[slotid-1];
         if (!slot->addressed) {
             continue;
         }
-        ldq_le_dma(xhci->as, dcbaap + 8 * slotid, &addr, MEMTXATTRS_UNSPECIFIED);
-        slot->ctx = xhci_mask64(addr);
-
-        xhci_dma_read_u32s(xhci, slot->ctx, slot_ctx, sizeof(slot_ctx));
-        slot->uport = xhci_lookup_uport(xhci, slot_ctx);
+        slot->uport = NULL;
+        if (xhci_read_dcbaa(xhci, slotid, &slot->ctx)) {
+            xhci_dma_read_u32s(xhci, slot->ctx, slot_ctx, sizeof(slot_ctx));
+            slot->uport = xhci_lookup_uport(xhci, slot_ctx);
+        }
         if (!slot->uport) {
             /* should not happen, but may trigger on guest bugs */
             slot->enabled = 0;
-- 
2.56.0


