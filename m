Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083C606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=rGpRLChh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3D2-00017x-2K; Mon, 16 Nov 2026 15:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Cf-0000Bc-Is; Mon, 16 Nov 2026 15:21:28 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Cc-0003KX-FY; Mon, 16 Nov 2026 15:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860372; bh=4K0deh1TUCPZExMyE9ofNQyNqPD/A5/UPpEZQt1t4gs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rGpRLChh8zhd7eMJjiBN4f+TiDeP1T4Jyk5j+CW4LMgvzmvdvN0AkckhLyMQ0CQIF
 biL38BPG5KRvm+fpn2GaU7ALsnrULG+0y1YAgVOgWiGfT7lbNy+7o58vAA9Ujkur1Y
 0RtsLx/JUiCf0zC8JCIoyRLas1VDlj2vBS3ZrfgBzx9Ym0T02BlYlrPzXCb7MGrNT+
 4mY0F3CozHBAXFq7hR0Kmq7Zso2t1kkC1w9PX9yDcNlvDEOK+pys1ZqAqu8JDT05VA
 IIhHkJGJO4EDlSrsdeScpjfEkokwZD5TmA2vGkHIcLBMcFVYbz6Ta6Y/iD+eHv2avY
 S6ZZ9Nhh8uoGw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 516C81E714E;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4EF2845FB84;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4086CB8DFE; Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@linux.dev>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 24/59] hw/usb/hcd-xhci: fail Address Device when the
 DCBAA entry is unreadable
Date: Mon, 16 Nov 2026 23:18:28 +0300
Message-ID: <20261116201922.534306-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
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
(cherry picked from commit 8b604732242e7027f89d90dc117517a9694bdc66)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index faded9ac1ed..45587059ea1 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -536,6 +536,23 @@ static inline void xhci_dma_write_u32s(XHCIState *xhci, dma_addr_t addr,
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
@@ -2105,8 +2122,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, unsigned int slotid,
     XHCISlot *slot;
     USBPort *uport;
     USBDevice *dev;
-    dma_addr_t ictx, octx, dcbaap;
-    uint64_t poctx;
+    dma_addr_t ictx, octx;
     uint32_t ictl_ctx[2];
     uint32_t slot_ctx[4];
     uint32_t ep0_ctx[5];
@@ -2115,10 +2131,10 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, unsigned int slotid,
 
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
@@ -3524,24 +3540,21 @@ static int usb_xhci_post_load(void *opaque, int version_id)
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
2.47.3


