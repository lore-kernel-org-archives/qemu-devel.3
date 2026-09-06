Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0463FC79FA0
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP4-0003vQ-MI; Sun, 06 Sep 2026 13:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOq-0003hA-Ag
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOm-0000BO-Ba
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6VWql7lcYSefgjxD/27wdMjccpJ+cidJ+niBD9/u4ts=;
 b=eLzmYnIq/FrYzHnTUhULohIwj77DmvkzjnrfdJrD3C/EJV0/m6IxhJ7qdkMqtG+HA7bcis
 w84tbnMrwD2pseAXGLNd5URnKgmaShWf2ruEJYLfbwWj427BwUFcYrrn2LFnmERAPTlPOr
 GGADnJW/RdXWSPtHS0SM6NnxFDGtOGE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-UJ3Ew7UtN_KL89DTu0cJog-1; Sun,
 06 Sep 2026 13:11:16 -0400
X-MC-Unique: UJ3Ew7UtN_KL89DTu0cJog-1
X-Mimecast-MFC-AGG-ID: UJ3Ew7UtN_KL89DTu0cJog_1788714675
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 344641800A7D; Sun,  6 Sep 2026 17:11:15 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A40A1955F06; Sun,  6 Sep 2026 17:11:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/40] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device
Date: Sun,  6 Sep 2026 19:10:03 +0200
Message-ID: <20260906171021.26568-23-clg@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Present the UDC gadget side to a USB host controller as a USB device
(TYPE_ASPEED_UDC_GADGET). This is a normal QEMU USB device, so it can be
attached to any USB host controller bus, not only the BMC's own EHCI. It
links back to its controller through the "udc" property.

This patch implements the control endpoint (EP0), which is enough for the
host to enumerate the gadget. Host control transfers are handled
asynchronously: the SETUP packet is mirrored into the SETUP data buffer,
the EP0 interrupt is raised and the host packet is parked (USB_RET_ASYNC).
The guest gadget driver then drives the data and status stages by writing
UDC_EP0_CTRL; that moves data to/from the driver's DMA buffer and completes
the parked packet back to the host.

SET_ADDRESS is the exception: it is applied synchronously, because the host
controller keeps the transfer bound to address 0 until it completes.

The gadget connects to / disconnects from the host bus when the driver
sets or clears the upstream-enable (pull-up) bit, and is detached on reset.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260902021542.3194812-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/usb/aspeed-udc.h |  28 +++
 hw/usb/aspeed-udc.c         | 382 +++++++++++++++++++++++++++++++++++-
 hw/usb/Kconfig              |   1 +
 hw/usb/trace-events         |   5 +
 4 files changed, 413 insertions(+), 3 deletions(-)

diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h
index 58fed5f9a2d2..ab9d016c613d 100644
--- a/include/hw/usb/aspeed-udc.h
+++ b/include/hw/usb/aspeed-udc.h
@@ -10,11 +10,19 @@
 #define HW_USB_ASPEED_UDC_H
 
 #include "hw/core/sysbus.h"
+#include "hw/usb/usb.h"
 #include "qom/object.h"
 
 #define TYPE_ASPEED_UDC "aspeed.udc"
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)
 
+/*
+ * The gadget side of the controller is presented to a USB host controller's
+ * bus as a single USB device that delegates back to the AspeedUDCState.
+ */
+#define TYPE_ASPEED_UDC_GADGET "aspeed.udc-gadget"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCGadget, ASPEED_UDC_GADGET)
+
 /*
  * Register map: root/global block at 0x000 - 0x087, then one 0x10 byte bank
  * per programmable endpoint from 0x200.
@@ -36,14 +44,34 @@ typedef struct AspeedUDCEP {
     int index;
 } AspeedUDCEP;
 
+struct AspeedUDCGadget {
+    USBDevice parent_obj;
+    AspeedUDCState *udc;
+};
+
 struct AspeedUDCState {
     SysBusDevice parent_obj;
 
     MemoryRegion udc_container;
     MemoryRegion root_mr;
+    MemoryRegion *dram_mr;
+    AddressSpace dram_as;
     uint32_t regs[ASPEED_UDC_ROOT_NR_REGS];
     AspeedUDCEP ep[ASPEED_UDC_NUM_EP];
     qemu_irq irq;
+
+    /* gadget USB device bound to this controller (set at its realize) */
+    AspeedUDCGadget *usbgadget;
+
+    /*
+     * In-flight EP0 control transfer (host side), deferred until the guest
+     * gadget driver responds via MMIO.
+     */
+    USBPacket *ep0_packet;
+    uint32_t ep0_setup_len;
+    uint32_t ep0_offset;
+    uint8_t *ep0_data;
+    bool ep0_dir_in;
 };
 
 #endif /* HW_USB_ASPEED_UDC_H */
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c
index cd773e979b60..70a22960622f 100644
--- a/hw/usb/aspeed-udc.c
+++ b/hw/usb/aspeed-udc.c
@@ -8,16 +8,26 @@
  * Models the ASPEED USB Device Controller (UDC). It implements one control
  * endpoint (EP0) and 4 programmable endpoints.
  *
- * This file is the system-bus side of the controller: the MMIO register map,
- * the interrupt and the soft reset. The gadget USB device presented to a host
- * controller (and the endpoint data path) is added on top of this.
+ * The model has two faces:
+ *   - a SysBus device exposing the MMIO register interface, the interrupt and
+ *     the integrated DMA engine to the guest gadget driver;
+ *   - a USBDevice presented on a host controller's bus, which forwards host
+ *     transactions to the guest gadget driver by raising the matching
+ *     controller interrupts and completes them once the guest gadget driver
+ *     responds via MMIO.
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "hw/core/irq.h"
 #include "hw/core/registerfields.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/usb/aspeed-udc.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
+#include "system/dma.h"
+#include "system/address-spaces.h"
 #include "trace.h"
 
 /* Root / Global registers (offset from the controller base) */
@@ -47,6 +57,7 @@ REG32(UDC_EP0_CTRL, 0x30)
     FIELD(UDC_EP0_CTRL, TX_RDY,             1, 1)
     FIELD(UDC_EP0_CTRL, STALL,              0, 1)
 REG32(UDC_EP0_DATA_BUFF, 0x34)
+    FIELD(UDC_EP0_DATA_BUFF, BASE_ADDR,     0, 31)
 /* EP0 SETUP packet buffer: SETUP0 = bytes 0...3, SETUP1 = bytes 4...7 */
 REG32(UDC_SETUP0, 0x80)
 REG32(UDC_SETUP1, 0x84)
@@ -66,6 +77,8 @@ REG32(EP_DMA_STS, 0x0C)
     FIELD(EP_DMA_STS, RPTR,                 8, 8)
     FIELD(EP_DMA_STS, WPTR,                 0, 8)
 
+#define ASPEED_UDC_EP0_MAXPKT      64
+
 static void aspeed_udc_update_irq(AspeedUDCState *s)
 {
     bool level;
@@ -78,6 +91,176 @@ static void aspeed_udc_update_irq(AspeedUDCState *s)
     qemu_set_irq(s->irq, level);
 }
 
+static void aspeed_udc_raise_isr(AspeedUDCState *s, uint32_t mask)
+{
+    s->regs[R_UDC_ISR] |= mask;
+    aspeed_udc_update_irq(s);
+}
+
+/*
+ * System bus device: MMIO register interface (guest gadget-driver facing)
+ */
+
+/* Connect/disconnect the gadget device from the host bus */
+static void aspeed_udc_set_pullup(AspeedUDCState *s, bool on)
+{
+    USBDevice *udev;
+    Error *err = NULL;
+
+    if (!s->usbgadget) {
+        /* no gadget device bound to this controller */
+        return;
+    }
+
+    udev = USB_DEVICE(s->usbgadget);
+    if (!udev->port) {
+        /* not attached to a host controller bus */
+        return;
+    }
+
+    trace_aspeed_udc_pullup(on, udev->attached);
+    if (on && !udev->attached) {
+        usb_device_attach(udev, &err);
+        if (err) {
+            warn_report_err(err);
+        }
+    } else if (!on && udev->attached) {
+        usb_device_detach(udev);
+    }
+}
+
+/* Complete the in-flight EP0 control transfer back to the host */
+static void aspeed_udc_ep0_complete(AspeedUDCState *s, uint32_t len)
+{
+    USBPacket *p = s->ep0_packet;
+
+    if (!p) {
+        return;
+    }
+
+    s->ep0_packet = NULL;
+    p->actual_length = s->ep0_dir_in ? MIN(len, s->ep0_setup_len)
+                                     : s->ep0_setup_len;
+    p->status = USB_RET_SUCCESS;
+    trace_aspeed_udc_ep0_complete(s->ep0_dir_in, p->actual_length);
+    usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);
+}
+
+static void aspeed_udc_ep0_tx_ready(AspeedUDCState *s, uint32_t val)
+{
+    uint32_t txlen = FIELD_EX32(val, UDC_EP0_CTRL, TX_LEN);
+    uint32_t data_buf_addr = s->regs[R_UDC_EP0_DATA_BUFF];
+    USBPacket *p;
+    uint32_t n;
+
+    if (!s->ep0_dir_in) {
+        /* Status stage IN (zero length) for an OUT / no-data transfer */
+        aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_IN_ACK_MASK);
+        aspeed_udc_ep0_complete(s, s->ep0_offset);
+        return;
+    }
+    /* no control transfer is waiting: nothing to send */
+    if (!s->ep0_packet) {
+        return;
+    }
+
+    /* IN data stage: copy from the guest gadget driver's DMA buffer */
+    n = MIN(txlen, s->ep0_setup_len - s->ep0_offset);
+    if (n && address_space_read(&s->dram_as, data_buf_addr,
+                                MEMTXATTRS_UNSPECIFIED,
+                                s->ep0_data + s->ep0_offset,
+                                n) != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: EP0 IN DMA read failed\n", __func__);
+        p = s->ep0_packet;
+        s->ep0_packet = NULL;
+        p->status = USB_RET_IOERROR;
+        usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);
+        return;
+    }
+    s->ep0_offset += n;
+    aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_IN_ACK_MASK);
+    if (txlen < ASPEED_UDC_EP0_MAXPKT || s->ep0_offset >= s->ep0_setup_len) {
+        aspeed_udc_ep0_complete(s, s->ep0_offset);
+    }
+}
+
+static void aspeed_udc_ep0_rx_ready(AspeedUDCState *s)
+{
+    uint32_t data_buf_addr = s->regs[R_UDC_EP0_DATA_BUFF];
+    USBPacket *p;
+    uint32_t n;
+
+    if (s->ep0_dir_in) {
+        /* Status stage OUT (zero length) for an IN transfer */
+        aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_OUT_ACK_MASK);
+        return;
+    }
+    /* no control transfer is waiting: nothing to receive */
+    if (!s->ep0_packet) {
+        return;
+    }
+
+    /* OUT data stage: hand host data to the guest gadget driver */
+    n = MIN(s->ep0_setup_len - s->ep0_offset, ASPEED_UDC_EP0_MAXPKT);
+    if (n && address_space_write(&s->dram_as, data_buf_addr,
+                                 MEMTXATTRS_UNSPECIFIED,
+                                 s->ep0_data + s->ep0_offset,
+                                 n) != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: EP0 OUT DMA write failed\n", __func__);
+        p = s->ep0_packet;
+        s->ep0_packet = NULL;
+        p->status = USB_RET_IOERROR;
+        usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);
+        return;
+    }
+    s->ep0_offset += n;
+    s->regs[R_UDC_EP0_CTRL] = FIELD_DP32(s->regs[R_UDC_EP0_CTRL],
+                                         UDC_EP0_CTRL, RX_LEN, n);
+    aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_OUT_ACK_MASK);
+}
+
+/*
+ * The guest gadget driver drives EP0 by writing UDC_EP0_CTRL. Translate
+ * those writes into data movement to/from the deferred host control packet
+ * plus the matching ACK interrupts the guest gadget driver expects.
+ */
+static void aspeed_udc_ep0_ctrl_write(AspeedUDCState *s, uint32_t val)
+{
+    USBPacket *p;
+
+    trace_aspeed_udc_ep0_ctrl_write(val, s->ep0_dir_in, s->ep0_offset);
+
+    if (val & R_UDC_EP0_CTRL_STALL_MASK) {
+        /* Gadget stalled EP0: fail the pending control transfer */
+        if (s->ep0_packet) {
+            p = s->ep0_packet;
+            s->ep0_packet = NULL;
+            p->status = USB_RET_STALL;
+            usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);
+        }
+    } else if (val & R_UDC_EP0_CTRL_TX_RDY_MASK) {
+        s->regs[R_UDC_EP0_CTRL] &= ~R_UDC_EP0_CTRL_TX_RDY_MASK;
+        aspeed_udc_ep0_tx_ready(s, val);
+    } else if (val & R_UDC_EP0_CTRL_RX_RDY_MASK) {
+        s->regs[R_UDC_EP0_CTRL] &= ~R_UDC_EP0_CTRL_RX_RDY_MASK;
+        aspeed_udc_ep0_rx_ready(s);
+    }
+}
+
+/* The upstream-enable bit connects/disconnects the gadget device */
+static void aspeed_udc_func_ctrl_write(AspeedUDCState *s, uint32_t val)
+{
+    bool was_on = FIELD_EX32(s->regs[R_UDC_FUNC_CTRL],
+                             UDC_FUNC_CTRL, UPSTREAM_EN);
+    bool now_on = FIELD_EX32(val, UDC_FUNC_CTRL, UPSTREAM_EN);
+
+    if (now_on != was_on) {
+        aspeed_udc_set_pullup(s, now_on);
+    }
+}
+
 static uint64_t aspeed_udc_read(void *opaque, hwaddr offset, unsigned size)
 {
     AspeedUDCState *s = ASPEED_UDC(opaque);
@@ -100,6 +283,11 @@ static void aspeed_udc_write(void *opaque, hwaddr offset, uint64_t data,
     trace_aspeed_udc_write(offset, val);
 
     switch (reg) {
+    case R_UDC_FUNC_CTRL:
+        val &= 0x000e1fff;
+        aspeed_udc_func_ctrl_write(s, val);
+        s->regs[R_UDC_FUNC_CTRL] = val;
+        break;
     case R_UDC_IER:
     case R_UDC_EP_ACK_IER:
     case R_UDC_EP_NAK_IER:
@@ -112,6 +300,16 @@ static void aspeed_udc_write(void *opaque, hwaddr offset, uint64_t data,
         s->regs[reg] &= ~val;
         aspeed_udc_update_irq(s);
         break;
+    case R_UDC_EP0_CTRL:
+        s->regs[reg] = val & (R_UDC_EP0_CTRL_STALL_MASK |
+                              R_UDC_EP0_CTRL_TX_RDY_MASK |
+                              R_UDC_EP0_CTRL_RX_RDY_MASK |
+                              R_UDC_EP0_CTRL_TX_LEN_MASK);
+        aspeed_udc_ep0_ctrl_write(s, val);
+        break;
+    case R_UDC_EP0_DATA_BUFF:
+        s->regs[reg] = val & R_UDC_EP0_DATA_BUFF_BASE_ADDR_MASK;
+        break;
     default:
         s->regs[reg] = val;
         break;
@@ -171,6 +369,7 @@ static const MemoryRegionOps aspeed_udc_ep_ops = {
 static void aspeed_udc_reset_hold(Object *obj, ResetType type)
 {
     AspeedUDCState *s = ASPEED_UDC(obj);
+    USBDevice *udev;
     int i;
 
     memset(s->regs, 0, sizeof(s->regs));
@@ -182,6 +381,21 @@ static void aspeed_udc_reset_hold(Object *obj, ResetType type)
     s->regs[R_UDC_DEV_RESET] = (R_UDC_DEV_RESET_ROOT_MASK |
                                 R_UDC_DEV_RESET_DMA_MASK |
                                 R_UDC_DEV_RESET_EP_POOL_MASK);
+    s->ep0_packet = NULL;
+
+    /*
+     * A guest reboot resets the controller but leaves the USB device
+     * attached to the host bus with no guest gadget driver behind it.
+     * Detach it, otherwise the rebooted host fails to re-enumerate the
+     * driverless gadget device; it re-attaches when the new driver asserts
+     * pull-up.
+     */
+    if (s->usbgadget) {
+        udev = USB_DEVICE(s->usbgadget);
+        if (udev->attached) {
+            usb_device_detach(udev);
+        }
+    }
 }
 
 static void aspeed_udc_realize(DeviceState *dev, Error **errp)
@@ -190,6 +404,12 @@ static void aspeed_udc_realize(DeviceState *dev, Error **errp)
     AspeedUDCState *s = ASPEED_UDC(dev);
     int i;
 
+    if (!s->dram_mr) {
+        error_setg(errp, TYPE_ASPEED_UDC ": 'dram' link not set");
+        return;
+    }
+    address_space_init(&s->dram_as, s->dram_mr, "dram");
+
     memory_region_init(&s->udc_container, OBJECT(s), TYPE_ASPEED_UDC,
                        ASPEED_UDC_MEM_SIZE);
     memory_region_init_io(&s->root_mr, OBJECT(s), &aspeed_udc_ops, s,
@@ -214,6 +434,20 @@ static void aspeed_udc_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(sbd, &s->irq);
 }
 
+static const Property aspeed_udc_properties[] = {
+    DEFINE_PROP_LINK("dram", AspeedUDCState, dram_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+};
+
+static void aspeed_udc_init(Object *obj)
+{
+    AspeedUDCState *s = ASPEED_UDC(obj);
+
+    object_property_add_link(obj, "usbgadget", TYPE_ASPEED_UDC_GADGET,
+                             (Object **)&s->usbgadget,
+                             object_property_allow_set_link, 0);
+}
+
 static void aspeed_udc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -222,6 +456,141 @@ static void aspeed_udc_class_init(ObjectClass *klass, const void *data)
     dc->desc = "ASPEED USB Device Controller";
     dc->realize = aspeed_udc_realize;
     rc->phases.hold = aspeed_udc_reset_hold;
+    device_class_set_props(dc, aspeed_udc_properties);
+}
+
+/*
+ * USB device: gadget device presented on a host controller's bus
+ *
+ * These callbacks run in the context of the host controller. They translate
+ * host transactions into the controller interrupts/state the guest gadget
+ * driver expects, then defer (USB_RET_ASYNC) until the driver responds
+ * through the MMIO register interface above.
+ */
+
+static void aspeed_udc_gadget_handle_reset(USBDevice *udev)
+{
+    AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
+
+    s->ep0_packet = NULL;
+    s->ep0_offset = 0;
+    /* The EHCI host is High-Speed; advertise it to the guest gadget driver */
+    s->regs[R_UDC_STS] = R_UDC_STS_HIGHSPEED_MASK;
+    trace_aspeed_udc_reset(s->regs[R_UDC_IER]);
+    aspeed_udc_raise_isr(s, R_UDC_ISR_BUS_RESET_MASK);
+}
+
+static void aspeed_udc_gadget_handle_control(USBDevice *udev, USBPacket *p,
+                                          int request, int value, int index,
+                                          int length, uint8_t *data)
+{
+    AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
+    uint8_t req = request & 0xff;
+    uint8_t type = request >> 8;
+
+    /*
+     * Reconstruct the 8-byte SETUP packet into the SETUP data buffer where
+     * the guest gadget driver reads it from.
+     */
+    s->regs[R_UDC_SETUP0] = type | (req << 8) | ((value & 0xffff) << 16);
+    s->regs[R_UDC_SETUP1] = (index & 0xffff) | ((length & 0xffff) << 16);
+
+    /* A new SETUP clears the EP0 STALL condition */
+    s->regs[R_UDC_EP0_CTRL] &= ~R_UDC_EP0_CTRL_STALL_MASK;
+
+    s->ep0_packet = p;
+    s->ep0_data = data;
+    s->ep0_setup_len = length;
+    s->ep0_offset = 0;
+    s->ep0_dir_in = (type & USB_DIR_IN);
+
+    trace_aspeed_udc_ep0_setup(type, req, value, index, length,
+                               s->ep0_dir_in, udev->addr);
+
+    /*
+     * SET_ADDRESS is delivered while the device still answers at the default
+     * address 0 and carries the new address in wValue. The host controller
+     * keeps this transfer's queue bound to address 0 until it completes, so
+     * apply the new address synchronously as the transfer completes.
+     * Completing it asynchronously (USB_RET_ASYNC) would change udev->addr
+     * while the queue is still bound to 0; the host controller sees the
+     * mismatch, tears the queue down and enumeration breaks. The guest gadget
+     * driver is still notified so its state machine advances.
+     */
+    if (type == 0 && req == USB_REQ_SET_ADDRESS) {
+        udev->addr = value;
+        s->ep0_packet = NULL;
+        aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_SETUP_MASK);
+        p->status = USB_RET_SUCCESS;
+        return;
+    }
+
+    aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_SETUP_MASK);
+    p->status = USB_RET_ASYNC;
+}
+
+static void aspeed_udc_gadget_handle_data(USBDevice *udev, USBPacket *p)
+{
+    /* Programmable endpoint (bulk) transfers are added in a later patch. */
+    p->status = USB_RET_STALL;
+}
+
+static void aspeed_udc_gadget_cancel_packet(USBDevice *udev, USBPacket *p)
+{
+    AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
+
+    if (s->ep0_packet == p) {
+        s->ep0_packet = NULL;
+    }
+}
+
+static void aspeed_udc_gadget_realize(USBDevice *udev, Error **errp)
+{
+    AspeedUDCGadget *dev = ASPEED_UDC_GADGET(udev);
+
+    if (!dev->udc) {
+        error_setg(errp, TYPE_ASPEED_UDC_GADGET ": 'udc' link is not set");
+        return;
+    }
+    /* Bind this gadget to its controller through the link property */
+    object_property_set_link(OBJECT(dev->udc), "usbgadget", OBJECT(dev),
+                             &error_abort);
+
+    udev->auto_attach = 0;
+    /* The ASPEED UDC is USB 2.0, so it only runs at High-Speed for now */
+    udev->speed = USB_SPEED_HIGH;
+    udev->speedmask = USB_SPEED_MASK_HIGH;
+}
+
+static void aspeed_udc_gadget_unrealize(USBDevice *udev)
+{
+    AspeedUDCGadget *dev = ASPEED_UDC_GADGET(udev);
+
+    if (dev->udc && dev->udc->usbgadget == dev) {
+        object_property_set_link(OBJECT(dev->udc), "usbgadget", NULL,
+                                 &error_abort);
+    }
+}
+
+static const Property aspeed_udc_gadget_props[] = {
+    DEFINE_PROP_LINK("udc", AspeedUDCGadget, udc, TYPE_ASPEED_UDC,
+                     AspeedUDCState *),
+};
+
+static void aspeed_udc_gadget_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
+
+    dc->desc           = "ASPEED UDC gadget device";
+    uc->product_desc   = "ASPEED UDC gadget";
+    uc->realize        = aspeed_udc_gadget_realize;
+    uc->unrealize      = aspeed_udc_gadget_unrealize;
+    uc->handle_reset   = aspeed_udc_gadget_handle_reset;
+    uc->handle_control = aspeed_udc_gadget_handle_control;
+    uc->handle_data    = aspeed_udc_gadget_handle_data;
+    uc->cancel_packet  = aspeed_udc_gadget_cancel_packet;
+    device_class_set_props(dc, aspeed_udc_gadget_props);
 }
 
 static const TypeInfo aspeed_udc_types[] = {
@@ -229,8 +598,15 @@ static const TypeInfo aspeed_udc_types[] = {
         .name          = TYPE_ASPEED_UDC,
         .parent        = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(AspeedUDCState),
+        .instance_init = aspeed_udc_init,
         .class_init    = aspeed_udc_class_init,
     },
+    {
+        .name          = TYPE_ASPEED_UDC_GADGET,
+        .parent        = TYPE_USB_DEVICE,
+        .instance_size = sizeof(AspeedUDCGadget),
+        .class_init    = aspeed_udc_gadget_class_init,
+    },
 };
 
 DEFINE_TYPES(aspeed_udc_types)
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index e4df15fe7c1f..e8c00f813a6a 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -149,3 +149,4 @@ config USB_CHIPIDEA
 
 config ASPEED_UDC
     bool
+    select USB
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index ed05304520a2..098c3d617952 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -383,4 +383,9 @@ aspeed_udc_read(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " value 0x%
 aspeed_udc_write(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " value 0x%x"
 aspeed_udc_ep_read(int ep, uint64_t offset, uint32_t value) "ep %d, offset 0x%" PRIx64 " value 0x%x"
 aspeed_udc_ep_write(int ep, uint64_t offset, uint32_t value) "ep %d, offset 0x%" PRIx64 " value 0x%x"
+aspeed_udc_pullup(int on, int attached) "on %d, attached %d"
 aspeed_udc_irq(uint32_t isr, uint32_t ier, int level) "isr 0x%x, ier 0x%x, level %d"
+aspeed_udc_reset(uint32_t ier) "bus reset, ier 0x%x"
+aspeed_udc_ep0_setup(uint8_t type, uint8_t req, uint16_t value, uint16_t index, uint16_t length, int dir_in, int addr) "bmRequestType 0x%02x, bRequest 0x%02x, wValue 0x%04x, wIndex 0x%04x, wLength %d, dir_in %d, addr %d"
+aspeed_udc_ep0_ctrl_write(uint32_t val, int dir_in, uint32_t offset) "val 0x%x, dir_in %d, off %u"
+aspeed_udc_ep0_complete(int dir_in, int actual) "dir_in %d, actual %d"
-- 
2.55.0


