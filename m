Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF90C79F9F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP5-0003w2-3O; Sun, 06 Sep 2026 13:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOq-0003h8-9K
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOm-0000BV-Gy
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UEsO+2xNApv91XhdDmiPrtB41JejI87dmh/IwFZh8y8=;
 b=RL3t4t7ygqCeD/2V8Hiq7ZHsUWZnAzQYNHq/OVW30+HOn3TNpbAF6RF4Vx5UPCvN1Ha2UQ
 w1v7/nXKZFjDk5F79L082uKsvFA13ZZduq2e7PmI3mpInrNOVMuUBMrEw3esAecy2I8GcX
 kS5MiFE13omXy3XOI9FxrjmlDTCJf6s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-xe2fPDNiPrCC-BdONIAbBA-1; Sun,
 06 Sep 2026 13:11:18 -0400
X-MC-Unique: xe2fPDNiPrCC-BdONIAbBA-1
X-Mimecast-MFC-AGG-ID: xe2fPDNiPrCC-BdONIAbBA_1788714677
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4090D1800D9D; Sun,  6 Sep 2026 17:11:17 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C4BB1955F06; Sun,  6 Sep 2026 17:11:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/40] hw/usb/aspeed-udc: Add programmable endpoint DMA
 transfers
Date: Sun,  6 Sep 2026 19:10:04 +0200
Message-ID: <20260906171021.26568-24-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add the bulk data plane for the four programmable endpoints. The gadget
driver queues IN data through the descriptor-list DMA ring and arms OUT
buffers through the single-stage DMA registers; host bulk transactions
are served from / delivered into those.

The DMA mode is taken from EP_DMA_CTRL.DESC_OP_EN: IN endpoints use the
descriptor-list ring, OUT endpoints use single-stage buffers.

A transfer larger than one host packet is served across several polls,
with the host packet parked (USB_RET_ASYNC) until the gadget queues (IN)
or arms (OUT) more data, then completed from the matching DMA kick.

With this the gadget data endpoints work, e.g. a mass-storage gadget can
be enumerated and read/written end to end.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260902021542.3194812-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/usb/aspeed-udc.h |   8 +
 hw/usb/aspeed-udc.c         | 456 +++++++++++++++++++++++++++++++++++-
 hw/usb/trace-events         |   4 +
 3 files changed, 463 insertions(+), 5 deletions(-)

diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h
index ab9d016c613d..7701c1aa342d 100644
--- a/include/hw/usb/aspeed-udc.h
+++ b/include/hw/usb/aspeed-udc.h
@@ -42,6 +42,14 @@ typedef struct AspeedUDCEP {
     MemoryRegion mr;
     uint32_t regs[ASPEED_UDC_EP_NR_REGS];
     int index;
+
+    /*
+     * host packet parked until the guest gadget driver queues (IN) or
+     * arms (OUT) data
+     */
+    USBPacket *pkt;
+    /* bytes of the current IN descriptor already served */
+    uint32_t desc_off;
 } AspeedUDCEP;
 
 struct AspeedUDCGadget {
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c
index 70a22960622f..4c90b4f4c239 100644
--- a/hw/usb/aspeed-udc.c
+++ b/hw/usb/aspeed-udc.c
@@ -72,12 +72,37 @@ REG32(EP_DMA_CTRL, 0x04)
     FIELD(EP_DMA_CTRL, PROC_STS,            4, 4)
     FIELD(EP_DMA_CTRL, DESC_OP_EN,          0, 1)
 REG32(EP_DMA_BUFF, 0x08)
+    FIELD(EP_DMA_BUFF, BASE_ADDR,           0, 31)
 REG32(EP_DMA_STS, 0x0C)
     FIELD(EP_DMA_STS, PKT_SIZE,            16, 11)
     FIELD(EP_DMA_STS, RPTR,                 8, 8)
     FIELD(EP_DMA_STS, WPTR,                 0, 8)
 
-#define ASPEED_UDC_EP0_MAXPKT      64
+#define ASPEED_UDC_EP0_MAXPKT   64
+#define ASPEED_UDC_EP_MAXPKT    1024
+
+/* DMA descriptor ring (256-stage mode) and descriptor data limits */
+#define ASPEED_UDC_DESCS_COUNT  256
+#define ASPEED_UDC_DESC_MAX_LEN 4096
+
+/* DMA processing-status idle codes */
+#define EP_DMA_CTRL_STS_RX_IDLE 0x0
+#define EP_DMA_CTRL_STS_TX_IDLE 0x8
+
+/* DMA descriptor (DES1) fields, in guest memory */
+#define ASPEED_EP_DESC1_IN_LEN(ctrl)   ((ctrl) & 0x1fff)
+/* interrupt-on-completion */
+#define ASPEED_EP_DESC1_INTR           BIT(31)
+
+/* Result of moving a host data packet through an endpoint's DMA */
+typedef enum {
+    /* whole packet transferred */
+    ASPEED_UDC_XFER_DONE,
+    /* not finished, keep parked */
+    ASPEED_UDC_XFER_MORE,
+    /* DMA failed */
+    ASPEED_UDC_XFER_ERROR,
+} AspeedUDCXferResult;
 
 static void aspeed_udc_update_irq(AspeedUDCState *s)
 {
@@ -97,6 +122,14 @@ static void aspeed_udc_raise_isr(AspeedUDCState *s, uint32_t mask)
     aspeed_udc_update_irq(s);
 }
 
+static void aspeed_udc_raise_ep_ack(AspeedUDCState *s, int ep)
+{
+    trace_aspeed_udc_ep_ack(ep);
+    s->regs[R_UDC_EP_ACK_ISR] |= BIT(ep);
+    s->regs[R_UDC_ISR] |= R_UDC_ISR_EP_POOL_ACK_MASK;
+    aspeed_udc_update_irq(s);
+}
+
 /*
  * System bus device: MMIO register interface (guest gadget-driver facing)
  */
@@ -330,6 +363,287 @@ static const MemoryRegionOps aspeed_udc_ops = {
     },
 };
 
+/*
+ * Copy len bytes from guest memory at addr into the IN packet, going through
+ * a bounce buffer one buf-full at a time. Returns false on DMA failure.
+ */
+static bool aspeed_udc_ep_copy_to_pkt(AspeedUDCState *s, int ep, uint32_t addr,
+                                      uint32_t len, USBPacket *p)
+{
+    uint8_t buf[ASPEED_UDC_EP_MAXPKT];
+    uint32_t copied = 0;
+    uint32_t seg;
+
+    while (copied < len) {
+        seg = MIN(len - copied, sizeof(buf));
+        if (address_space_read(&s->dram_as, addr + copied,
+                               MEMTXATTRS_UNSPECIFIED, buf, seg) != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: ep %d IN data DMA read failed\n", __func__,
+                          ep);
+            return false;
+        }
+        usb_packet_copy(p, buf, seg);
+        copied += seg;
+    }
+
+    return true;
+}
+
+/*
+ * IN transfer: send data to the host by filling its IN packet from the
+ * buffers the guest gadget driver queued in the descriptor ring (from the
+ * read pointer to the write pointer).
+ *
+ * One host packet can be bigger than one descriptor's buffer, so we copy from
+ * several descriptors in a row until the packet is full or the ring is empty.
+ * If a descriptor is too big for the space left in the packet, we copy only
+ * part of it now and copy the rest on the next call; desc_off remembers how
+ * far we got. We move the read pointer to the next descriptor only after a
+ * descriptor is fully copied, so the guest gadget driver can read the pointer
+ * and see how much was sent.
+ *
+ * This function raises the endpoint ACK by itself when the ring becomes empty
+ * or when a descriptor asks for an interrupt.
+ */
+static AspeedUDCXferResult aspeed_udc_ep_xfer_in(AspeedUDCState *s, int ep,
+                                                 USBPacket *p)
+{
+    QEMUIOVector *pktiov = p->combined ? &p->combined->iov : &p->iov;
+    AspeedUDCEP *e = &s->ep[ep];
+    uint32_t mps = FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, MAX_PKT);
+    uint32_t wptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);
+    uint32_t rptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);
+    uint32_t desc_base = e->regs[R_EP_DMA_BUFF];
+    uint32_t desc_addr;
+    uint32_t remaining;
+    uint32_t desc_ctrl;
+    uint32_t pkt_space;
+    /* des_0: data buffer base address, des_1: control/status */
+    uint32_t desc[2];
+    uint32_t offset;
+    uint32_t chunk;
+    uint32_t dlen;
+    bool done = false;
+    bool ack = false;
+
+    if (mps == 0) {
+        /* a MAX_PKT field of 0 means the maximum packet size */
+        mps = ASPEED_UDC_EP_MAXPKT;
+    }
+
+    trace_aspeed_udc_ep_data_in(ep, rptr, wptr, pktiov->size);
+
+    /* walk the queued descriptors, filling the packet */
+    while (rptr != wptr) {
+        if (address_space_read(&s->dram_as, desc_base + rptr * sizeof(desc),
+                               MEMTXATTRS_UNSPECIFIED, desc,
+                               sizeof(desc)) != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: ep %d descriptor DMA read failed\n",
+                          __func__, ep);
+            return ASPEED_UDC_XFER_ERROR;
+        }
+        desc_addr = le32_to_cpu(desc[0]) & R_EP_DMA_BUFF_BASE_ADDR_MASK;
+        desc_ctrl = le32_to_cpu(desc[1]);
+        dlen = ASPEED_EP_DESC1_IN_LEN(desc_ctrl);
+        offset = e->desc_off;
+        /* how much to copy: min(descriptor bytes left, packet space left) */
+        remaining = dlen > offset ? dlen - offset : 0;
+        pkt_space = pktiov->size > (uint32_t)p->actual_length ?
+                    pktiov->size - (uint32_t)p->actual_length : 0;
+        chunk = MIN(remaining, pkt_space);
+
+        if (!aspeed_udc_ep_copy_to_pkt(s, ep, desc_addr + offset, chunk, p)) {
+            return ASPEED_UDC_XFER_ERROR;
+        }
+        e->desc_off += chunk;
+
+        if (e->desc_off < dlen) {
+            /*
+             * The packet ran out of space in the middle of this descriptor,
+             * so only part of it was copied. Stop here, and leave the read
+             * pointer on this descriptor: the next call resumes copying the
+             * rest (desc_off remembers how far we got).
+             */
+            done = true;
+            break;
+        }
+
+        /*
+         * This descriptor was copied in full. Advance the read pointer to the
+         * next descriptor and reset desc_off so it starts from the beginning.
+         */
+        rptr = (rptr + 1) % ASPEED_UDC_DESCS_COUNT;
+        e->desc_off = 0;
+        if (desc_ctrl & ASPEED_EP_DESC1_INTR) {
+            ack = true;
+        }
+        /*
+         * This descriptor is shorter than the max packet size, i.e. a short
+         * (or zero-length) packet. In USB that marks the end of the transfer,
+         * so stop here.
+         */
+        if (dlen < mps) {
+            done = true;
+            break;
+        }
+        /*
+         * The packet is now completely full, so the host has received all the
+         * data it asked for. Stop here.
+         */
+        if ((uint32_t)p->actual_length >= pktiov->size) {
+            done = true;
+            break;
+        }
+    }
+
+    e->regs[R_EP_DMA_STS] = FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS,
+                                       RPTR, rptr);
+    e->regs[R_EP_DMA_CTRL] = FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL,
+                                        PROC_STS, EP_DMA_CTRL_STS_TX_IDLE);
+    /* The guest gadget driver completes its request when the ring drains */
+    if (rptr == wptr) {
+        ack = true;
+    }
+    if (ack) {
+        aspeed_udc_raise_ep_ack(s, ep);
+    }
+
+    return done ? ASPEED_UDC_XFER_DONE : ASPEED_UDC_XFER_MORE;
+}
+
+/*
+ * OUT transfer: receive data from the host by copying its OUT packet into the
+ * buffer the guest gadget driver set up (single-stage mode).
+ *
+ * A host packet can be bigger than one buffer, so we copy at most PKT_SIZE
+ * bytes per call, continuing from where the last call stopped
+ * (p->actual_length). The caller keeps the packet parked until it is fully
+ * copied.
+ */
+static AspeedUDCXferResult aspeed_udc_ep_xfer_out(AspeedUDCState *s, int ep,
+                                                  USBPacket *p)
+{
+    AspeedUDCEP *e = &s->ep[ep];
+    uint32_t chunk = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, PKT_SIZE);
+    uint32_t remaining = p->iov.size - (uint32_t)p->actual_length;
+    uint32_t data_buf_addr = e->regs[R_EP_DMA_BUFF];
+    uint32_t len = MIN(remaining, chunk);
+    g_autofree uint8_t *buf = g_malloc(len);
+
+    if (data_buf_addr && len) {
+        usb_packet_copy(p, buf, len);
+        if (address_space_write(&s->dram_as, data_buf_addr,
+                                MEMTXATTRS_UNSPECIFIED, buf,
+                                len) != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: ep %d OUT data DMA write failed\n",
+                          __func__, ep);
+            return ASPEED_UDC_XFER_ERROR;
+        }
+    }
+
+    e->regs[R_EP_DMA_STS] = FIELD_DP32(e->regs[R_EP_DMA_STS],
+                                       EP_DMA_STS, PKT_SIZE, len);
+    e->regs[R_EP_DMA_STS] = FIELD_DP32(e->regs[R_EP_DMA_STS],
+                                       EP_DMA_STS, WPTR, 0);
+    e->regs[R_EP_DMA_CTRL] = FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL,
+                                        PROC_STS, EP_DMA_CTRL_STS_RX_IDLE);
+    aspeed_udc_raise_ep_ack(s, ep);
+
+    if ((uint32_t)p->actual_length >= p->iov.size) {
+        return ASPEED_UDC_XFER_DONE;
+    }
+
+    return ASPEED_UDC_XFER_MORE;
+}
+
+/*
+ * IN kick: the guest gadget driver wrote EP_DMA_STS to tell us it queued more
+ * IN data to send to the host. If a host IN request is already waiting
+ * (parked because there was no data before), send the data now and finish it.
+ * If the request needs more data than was queued, keep it parked and wait for
+ * the next kick.
+ */
+static void aspeed_udc_ep_in_kick(AspeedUDCState *s, int ep, uint32_t val)
+{
+    AspeedUDCEP *e = &s->ep[ep];
+    uint32_t cur_rptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);
+    uint32_t new_rptr = FIELD_EX32(val, EP_DMA_STS, RPTR);
+    uint32_t new_wptr = FIELD_EX32(val, EP_DMA_STS, WPTR);
+    USBPacket *p = e->pkt;
+
+    /*
+     * A normal kick only sets the write pointer and leaves the read-pointer
+     * field 0 (the read pointer is ours to advance). The guest resets the ring
+     * by writing a read pointer that is non-zero and equal to the write
+     * pointer.
+     *
+     * We check non-zero as well as equal: on a normal kick whose write pointer
+     * just wrapped back to 0, both fields would be 0, so an "equal" test alone
+     * would look like a reset by mistake.
+     */
+    if (new_rptr != 0 && new_rptr == new_wptr) {
+        cur_rptr = new_rptr;
+        e->desc_off = 0;
+    }
+    /* store the guest's write, but keep our own read pointer */
+    e->regs[R_EP_DMA_STS] = FIELD_DP32(val, EP_DMA_STS, RPTR, cur_rptr);
+
+    /* nothing to do unless an IN packet is waiting and the ring has data */
+    if (!p || cur_rptr == new_wptr) {
+        return;
+    }
+
+    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {
+    case ASPEED_UDC_XFER_DONE:
+        e->pkt = NULL;
+        p->status = USB_RET_SUCCESS;
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);
+        break;
+    case ASPEED_UDC_XFER_ERROR:
+        e->pkt = NULL;
+        p->status = USB_RET_IOERROR;
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);
+        break;
+    case ASPEED_UDC_XFER_MORE:
+        break;
+    }
+}
+
+/*
+ * OUT kick: the guest gadget driver wrote EP_DMA_STS to give us a buffer for
+ * OUT data. If an OUT packet is already waiting (parked because there was no
+ * buffer before), copy its data into the buffer now and finish it. If the
+ * packet has more data than fits, keep it parked and wait for the next buffer.
+ */
+static void aspeed_udc_ep_out_kick(AspeedUDCState *s, int ep)
+{
+    AspeedUDCEP *e = &s->ep[ep];
+    USBPacket *p = e->pkt;
+
+    /* nothing to do unless an OUT packet is waiting and a buffer is ready */
+    if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {
+        return;
+    }
+
+    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {
+    case ASPEED_UDC_XFER_DONE:
+        e->pkt = NULL;
+        p->status = USB_RET_SUCCESS;
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);
+        break;
+    case ASPEED_UDC_XFER_ERROR:
+        e->pkt = NULL;
+        p->status = USB_RET_IOERROR;
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);
+        break;
+    case ASPEED_UDC_XFER_MORE:
+        break;
+    }
+}
+
 static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned size)
 {
     AspeedUDCEP *e = opaque;
@@ -346,10 +660,31 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr offset, uint64_t data,
                                 unsigned size)
 {
     AspeedUDCEP *e = opaque;
+    AspeedUDCState *s = container_of(e - e->index, AspeedUDCState, ep[0]);
     uint32_t reg = offset >> 2;
+    uint32_t val = data;
 
-    trace_aspeed_udc_ep_write(e->index, offset, data);
-    e->regs[reg] = data;
+    trace_aspeed_udc_ep_write(e->index, offset, val);
+
+    switch (reg) {
+    case R_EP_DMA_BUFF:
+        e->regs[reg] = val & R_EP_DMA_BUFF_BASE_ADDR_MASK;
+        break;
+    case R_EP_DMA_STS:
+        val &= 0x77ffffff;
+        if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {
+            /* IN, descriptor-list mode */
+            aspeed_udc_ep_in_kick(s, e->index, val);
+        } else {
+            /* OUT, single-stage mode */
+            e->regs[reg] = val;
+            aspeed_udc_ep_out_kick(s, e->index);
+        }
+        break;
+    default:
+        e->regs[reg] = val;
+        break;
+    }
 }
 
 static const MemoryRegionOps aspeed_udc_ep_ops = {
@@ -375,6 +710,8 @@ static void aspeed_udc_reset_hold(Object *obj, ResetType type)
     memset(s->regs, 0, sizeof(s->regs));
     for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
         memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));
+        s->ep[i].pkt = NULL;
+        s->ep[i].desc_off = 0;
     }
 
     /* Device-reset default: root, DMA and EP-pool soft-reset bits set */
@@ -468,6 +805,95 @@ static void aspeed_udc_class_init(ObjectClass *klass, const void *data)
  * through the MMIO register interface above.
  */
 
+static int aspeed_udc_find_ep(AspeedUDCState *s, int ep_nr, bool is_out)
+{
+    uint32_t cfg;
+    int i;
+
+    for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
+        cfg = s->ep[i].regs[R_EP_CONFIG];
+
+        if (!FIELD_EX32(cfg, EP_CONFIG, ENABLE) ||
+            FIELD_EX32(cfg, EP_CONFIG, EP_NUM) != ep_nr) {
+            continue;
+        }
+        if (FIELD_EX32(cfg, EP_CONFIG, DIR_OUT) == is_out) {
+            return i;
+        }
+    }
+
+    return -1;
+}
+
+static void aspeed_udc_ep_data_in(AspeedUDCState *s, int ep, USBPacket *p)
+{
+    AspeedUDCEP *e = &s->ep[ep];
+    uint32_t rptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);
+    uint32_t wptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);
+
+    if (rptr == wptr) {
+        /*
+         * No IN data is queued yet. Save the packet and return ASYNC
+         * instead of NAK. A NAK would make the host retry slowly.
+         * aspeed_udc_ep_in_kick() serves and completes this packet later,
+         * once the guest gadget driver queues descriptors.
+         */
+        e->pkt = p;
+        p->status = USB_RET_ASYNC;
+        return;
+    }
+
+    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {
+    case ASPEED_UDC_XFER_DONE:
+        p->status = USB_RET_SUCCESS;
+        break;
+    case ASPEED_UDC_XFER_MORE:
+        /* not fully sent yet: save the packet, wait for more descriptors */
+        e->pkt = p;
+        p->status = USB_RET_ASYNC;
+        break;
+    case ASPEED_UDC_XFER_ERROR:
+        p->status = USB_RET_IOERROR;
+        break;
+    }
+}
+
+static void aspeed_udc_ep_data_out(AspeedUDCState *s, int ep, USBPacket *p)
+{
+    AspeedUDCEP *e = &s->ep[ep];
+    uint32_t sts = e->regs[R_EP_DMA_STS];
+
+    trace_aspeed_udc_ep_data_out(ep, FIELD_EX32(sts, EP_DMA_STS, WPTR),
+                                 FIELD_EX32(sts, EP_DMA_STS, PKT_SIZE),
+                                 p->iov.size);
+    if (!FIELD_EX32(sts, EP_DMA_STS, WPTR)) {
+        /*
+         * No OUT buffer is ready yet. Save the packet and return ASYNC
+         * instead of NAK. Writing now could use an old buffer address and
+         * lose the data (for example a mass-storage CBW). A NAK would make
+         * the host retry slowly. aspeed_udc_ep_out_kick() delivers this
+         * packet later, once the guest gadget driver sets up a buffer.
+         */
+        e->pkt = p;
+        p->status = USB_RET_ASYNC;
+        return;
+    }
+
+    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {
+    case ASPEED_UDC_XFER_DONE:
+        p->status = USB_RET_SUCCESS;
+        break;
+    case ASPEED_UDC_XFER_MORE:
+        /* not fully received yet: save the packet, wait for the next buffer */
+        e->pkt = p;
+        p->status = USB_RET_ASYNC;
+        break;
+    case ASPEED_UDC_XFER_ERROR:
+        p->status = USB_RET_IOERROR;
+        break;
+    }
+}
+
 static void aspeed_udc_gadget_handle_reset(USBDevice *udev)
 {
     AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
@@ -531,17 +957,37 @@ static void aspeed_udc_gadget_handle_control(USBDevice *udev, USBPacket *p,
 
 static void aspeed_udc_gadget_handle_data(USBDevice *udev, USBPacket *p)
 {
-    /* Programmable endpoint (bulk) transfers are added in a later patch. */
-    p->status = USB_RET_STALL;
+    AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
+    bool is_out = (p->pid == USB_TOKEN_OUT);
+    int ep = aspeed_udc_find_ep(s, p->ep->nr, is_out);
+
+    trace_aspeed_udc_handle_data(p->ep->nr, is_out ? "OUT" : "IN",
+                                 p->iov.size, ep);
+    if (ep < 0) {
+        p->status = USB_RET_STALL;
+        return;
+    }
+
+    if (is_out) {
+        aspeed_udc_ep_data_out(s, ep, p);
+    } else {
+        aspeed_udc_ep_data_in(s, ep, p);
+    }
 }
 
 static void aspeed_udc_gadget_cancel_packet(USBDevice *udev, USBPacket *p)
 {
     AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
+    int i;
 
     if (s->ep0_packet == p) {
         s->ep0_packet = NULL;
     }
+    for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
+        if (s->ep[i].pkt == p) {
+            s->ep[i].pkt = NULL;
+        }
+    }
 }
 
 static void aspeed_udc_gadget_realize(USBDevice *udev, Error **errp)
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 098c3d617952..80ead23358f5 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -389,3 +389,7 @@ aspeed_udc_reset(uint32_t ier) "bus reset, ier 0x%x"
 aspeed_udc_ep0_setup(uint8_t type, uint8_t req, uint16_t value, uint16_t index, uint16_t length, int dir_in, int addr) "bmRequestType 0x%02x, bRequest 0x%02x, wValue 0x%04x, wIndex 0x%04x, wLength %d, dir_in %d, addr %d"
 aspeed_udc_ep0_ctrl_write(uint32_t val, int dir_in, uint32_t offset) "val 0x%x, dir_in %d, off %u"
 aspeed_udc_ep0_complete(int dir_in, int actual) "dir_in %d, actual %d"
+aspeed_udc_handle_data(int ep_nr, const char *dir, uint32_t iov, int ep_idx) "ep_nr %d, %s, iov %u, ep_idx %d"
+aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t iov) "ep %u, rptr %u, wptr %u, iov %u"
+aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_t iov) "ep %u, wptr %u, avail %u, iov %u"
+aspeed_udc_ep_ack(unsigned ep) "ep %u"
-- 
2.55.0


