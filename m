Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E4606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fA7P6i3z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMzub-0003qA-Nt; Fri, 30 Oct 2026 23:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMzuY-0003ok-PQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:37:42 -0400
Received: from out-4.mta1.migadu.com ([95.215.58.4] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMzuW-0003sr-DV
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:37:42 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=w7HhoT+HZlE5uIaC1kjOj9y3j81Oh6aWbF0ordaezyc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793417857; v=1; x=1794022657;
 b=fA7P6i3zIZZhz6YmyHIW24+iQNfs+9JnOuN/aJ1kboKB+dGkqJnh/nxcLKa/7oNQ59Osph/r
 Idjj+aNGbKJ4dcK4GeS30czZg9LLZcAbDSz7gme8mOXBM4pbOpRbsrGLGCZjS94/fwMgWJsHnjf
 yUQX5ri72lkZhu/58n1GgGGM=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id c7b862658f3f20ba;
 Sat, 31 Oct 2026 03:37:37 +0000
X-Mizu-Trace-ID: c7b862658f3f20ba
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 junjie.cao@linux.dev, qemu-stable@nongnu.org
Subject: [PATCH 1/2] hw/usb/hcd-xhci: fail Address Device when the DCBAA entry
 is unreadable
Date: Fri, 30 Oct 2026 22:37:24 -0500
Message-ID: <20261031033725.1275414-2-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031033725.1275414-1-junjie.cao@linux.dev>
References: <20261031033725.1275414-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.4; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 hw/usb/hcd-xhci.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 5d7a77b8bc..b5cc1ad2ff 100644
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
2.43.0


