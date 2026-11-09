Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6892606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RGTFyV84
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLR1-0007mE-3t; Mon, 09 Nov 2026 04:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLQY-0007jO-OK
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:12:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLQX-0003ee-6i
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794215552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DyWbOXNc07Pa9OmhTHDAIAot2PqguaX4SGk36Ovfm+Q=;
 b=RGTFyV84hdcitiGIFW1if/WwE1zUhdllAJpkRbHeA06Ypn54pqC93HzvpfL9ib1FJNeMJ4
 545GjMqZQyyxiC7k+0L2RqfuHyEYx5Uq7kRU2ItmRCcIi8OsewtHIzu1uYf90G8Hv0CAdN
 p0St4AfWC2wI+Yq4gpP31hvJjDobHBk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-89aGL7zOM3uvknIuwCymmA-1; Mon,
 09 Nov 2026 04:12:30 -0500
X-MC-Unique: 89aGL7zOM3uvknIuwCymmA-1
X-Mimecast-MFC-AGG-ID: 89aGL7zOM3uvknIuwCymmA_1794215550
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5EC91955F05; Mon,  9 Nov 2026 09:12:29 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 000511956087; Mon,  9 Nov 2026 09:12:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-12.0] pcie: Model DLLLA transitions on Secondary Bus Reset
Date: Mon,  9 Nov 2026 10:12:25 +0100
Message-ID: <20261109091225.914552-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Per PCIe r6.5 sec 6.6.1 and 7.5.3.8, setting the Secondary Bus Reset
bit on a downstream port drives the Data Link Layer to DL_Down,
clearing the Data Link Layer Link Active bit (DLLLA). On de-assertion
the link retrains and DLLLA is re-asserted.

Currently DLLLA is only managed during plug/unplug events, so a
guest sees stale DLLLA=1 while SBR is in progress.

Handle both SBR transitions in pci_bridge_write_config(), the common
config write path for all bridge types, guarded by
pci_is_express_downstream_port(). Also restore DLLLA in
pcie_cap_slot_reset() so that a system reset while SBR is asserted
does not leave DLLLA stuck at 0.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci/pcie.h |  2 ++
 hw/pci/pci_bridge.c   | 13 ++++++++++++-
 hw/pci/pcie.c         | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index ec25e7a7de99..c362f55f9b58 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -112,6 +112,8 @@ void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta);
 void pcie_cap_slot_write_config(PCIDevice *dev,
                                 uint16_t old_slt_ctl, uint16_t old_slt_sta,
                                 uint32_t addr, uint32_t val, int len);
+void pcie_cap_slot_link_down(PCIDevice *dev);
+void pcie_cap_slot_link_up(PCIDevice *dev);
 int pcie_cap_slot_post_load(void *opaque, int version_id);
 void pcie_cap_slot_push_attention_button(PCIDevice *dev);
 void pcie_cap_slot_enable_power(PCIDevice *dev);
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index e85932e41a92..747d90e1ca46 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -33,6 +33,7 @@
 #include "qemu/units.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/pci/pcie.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
@@ -274,9 +275,19 @@ void pci_bridge_write_config(PCIDevice *d,
 
     newctl = pci_get_word(d->config + PCI_BRIDGE_CONTROL);
     if (~oldctl & newctl & PCI_BRIDGE_CTL_BUS_RESET) {
-        /* Trigger hot reset on 0->1 transition. */
+        /* SBR assertion (0->1): bring link down, then reset devices. */
+        if (pci_is_express_downstream_port(d)) {
+            pcie_cap_slot_link_down(d);
+        }
         bus_cold_reset(BUS(&s->sec_bus));
     }
+
+    if (oldctl & ~newctl & PCI_BRIDGE_CTL_BUS_RESET) {
+        /* SBR de-assertion (1->0): bring link back up. */
+        if (pci_is_express_downstream_port(d)) {
+            pcie_cap_slot_link_up(d);
+        }
+    }
 }
 
 void pci_bridge_disable_base_limit(PCIDevice *dev)
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index bd00305ecca6..e89a65eea37b 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -803,6 +803,7 @@ void pcie_cap_slot_reset(PCIDevice *dev)
                                  PCI_EXP_SLTSTA_PDC |
                                  PCI_EXP_SLTSTA_ABP);
 
+    pcie_cap_slot_link_up(dev);
     pcie_cap_update_power(dev);
     hotplug_event_update_event_status(dev);
 }
@@ -946,6 +947,38 @@ void pcie_cap_slot_push_attention_button(PCIDevice *dev)
     pcie_cap_slot_event(dev, PCI_EXP_HP_EV_ABP);
 }
 
+/*
+ * PCIe r6.5, sec 7.5.3.8: setting the SBR bit eventually transitions
+ * the port to DL_Down, clearing DLLLA.
+ */
+void pcie_cap_slot_link_down(PCIDevice *dev)
+{
+    assert(pci_is_express_downstream_port(dev));
+    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
+
+    pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+                                 PCI_EXP_LNKSTA_DLLLA);
+}
+
+/*
+ * PCIe r6.5, sec 7.5.3.8: on SBR de-assertion the link retrains and
+ * DLLLA is re-asserted if a device is still present.
+ */
+void pcie_cap_slot_link_up(PCIDevice *dev)
+{
+    assert(pci_is_express_downstream_port(dev));
+    PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
+    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
+    uint32_t lnkcap = pci_get_long(exp_cap + PCI_EXP_LNKCAP);
+
+    if (sec_bus->devices[0] &&
+        (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA ||
+         (lnkcap & PCI_EXP_LNKCAP_DLLLARC))) {
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                                   PCI_EXP_LNKSTA_DLLLA);
+    }
+}
+
 /* root control/capabilities/status. PME isn't emulated for now */
 void pcie_cap_root_init(PCIDevice *dev)
 {
-- 
2.56.0


