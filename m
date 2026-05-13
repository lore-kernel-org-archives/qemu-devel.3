Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ED2CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 13:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNA2n-00044d-Pn; Wed, 13 May 2026 09:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wNA2g-00044D-Pc
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:54:31 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wNA2e-0005hI-Ou
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:54:30 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id B9D23240027
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 15:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1778680463; bh=syZLAxcjGGap8f6DZE9bB4VYVBS/CrHeqGgVrubXxHM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=Oi3U8spgMbcVVBy7KZrSXR+WmqbhF9cE/cJGYIQwuFgMBngNHmxDDnGwTcd+dDCWA
 Mpe1QVOHDvAiAxBXsd/ZGcQXZPuFDUhLWEys73+1oY76R6BDC3J5fHHOKYrFxgRntd
 WL9irhY9H9HVwA756XAeVI7arhAZV9Fof4uF2xIfDB2yMr5IdWbxxlJOwlTVP2iuIU
 HhonXJR4rC1qvuxnLowJyhERWmpTTk8SATveXOKQguNn4vf7Y9OE3WMmhpxzREnKXl
 xs/6ZBJw4HfEKE08LKBKag1onqs6jPz11690lagan696o97wqoDBMVC+A0BGRlRuRi
 Q7olP89dXHw7w==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gFw1W1w2lz9rxL;
 Wed, 13 May 2026 15:54:23 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: qemu-devel@nongnu.org
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] hw/pci: flap DLLLA across Secondary Bus Reset
Date: Wed, 13 May 2026 13:54:23 +0000
Message-ID: <20260513135412.4851-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65;
 envelope-from=mateusz.nowicki@posteo.net; helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When guest software asserts Secondary Bus Reset on a PCIe bridge by
setting PCI_BRIDGE_CTL_BUS_RESET, real hardware drops the data link
for the duration of the reset.  Software typically observes this as
the Data Link Layer Link Active (DLLLA) bit in the upstream port's
LNKSTA register going 1 -> 0 while the reset is held and 0 -> 1 once
the link retrains after de-assertion.

QEMU's pci_bridge_write_config() already triggers a cold reset of the
secondary bus on the 0 -> 1 SBR transition but never updates LNKSTA,
so DLLLA stays whatever it was before.  When the link advertises a
speed above 5.0 GT/s, the Linux PCI core polls DLLLA after the reset
(pci_bridge_wait_for_secondary_bus()) and logs

  pcieport 0000:00:03.0: pcie_failed_link_retrain: ...
  pcieport 0000:00:03.0: Data Link Layer Link Active not set in 100 msec

before returning -ENOTTY to the caller of sysfs reset.

Introduce pcie_cap_set_dllla() to toggle DLLLA on devices that report
DLLLA reporting capability (LNKCAP DLLLARC, or the
QEMU_PCIE_LNKSTA_DLLLA quirk), and call it from
pci_bridge_write_config() on both SBR transitions: clear on assert,
set on de-assert.

Reproducer (with this patch reverted):

  qemu-system-x86_64 -machine q35 ... \
      -device pcie-root-port,id=rp0,chassis=1,slot=1,bus=pcie.0 \
      -device nvme,bus=rp0,drive=nvm,serial=deadbeef ...

  echo bus > /sys/bus/pci/devices/0000:01:00.0/reset_method
  echo 1   > /sys/bus/pci/devices/0000:01:00.0/reset

Without the patch the reset returns -ENOTTY and dmesg shows the
"Data Link Layer Link Active not set in 100 msec" warning; with the
patch the reset returns 0 and the warning is gone.

Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---
 hw/pci/pci_bridge.c   | 16 +++++++++++++++-
 hw/pci/pcie.c         | 31 +++++++++++++++++++++++++++++++
 include/hw/pci/pcie.h |  1 +
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index e85932e41a9..3ddc572383d 100644
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
@@ -274,8 +275,21 @@ void pci_bridge_write_config(PCIDevice *d,
 
     newctl = pci_get_word(d->config + PCI_BRIDGE_CONTROL);
     if (~oldctl & newctl & PCI_BRIDGE_CTL_BUS_RESET) {
-        /* Trigger hot reset on 0->1 transition. */
+        /*
+         * SBR asserted: drop the data link on PCIe.  Real hardware
+         * brings the link down for as long as Secondary Bus Reset is
+         * held, which clears DLLLA in the port's LNKSTA.
+         */
         bus_cold_reset(BUS(&s->sec_bus));
+        pcie_cap_set_dllla(d, false);
+    } else if (oldctl & ~newctl & PCI_BRIDGE_CTL_BUS_RESET) {
+        /*
+         * SBR de-asserted: the link retrains and DLLLA goes back to 1.
+         * Software polling LNKSTA (e.g. Linux's
+         * pci_bridge_wait_for_secondary_bus) relies on this transition
+         * to declare the reset complete.
+         */
+        pcie_cap_set_dllla(d, true);
     }
 }
 
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4622c75e48c..fd81ac72873 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -396,6 +396,37 @@ void pcie_cap_lnkctl_reset(PCIDevice *dev)
                                  PCI_EXP_LNKCTL_CCC | PCI_EXP_LNKCTL_ES);
 }
 
+/*
+ * Toggle the Data Link Layer Link Active bit in LNKSTA.  Used to model
+ * the link-state transitions a real PCIe port exhibits around events
+ * such as Secondary Bus Reset.  No-op on devices that do not advertise
+ * DLLLA reporting.
+ */
+void pcie_cap_set_dllla(PCIDevice *dev, bool active)
+{
+    uint8_t *exp_cap;
+    uint32_t lnkcap;
+
+    if (!pci_is_express(dev) || !dev->exp.exp_cap) {
+        return;
+    }
+    exp_cap = dev->config + dev->exp.exp_cap;
+    lnkcap = pci_get_long(exp_cap + PCI_EXP_LNKCAP);
+
+    if (!(dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) &&
+        !(lnkcap & PCI_EXP_LNKCAP_DLLLARC)) {
+        return;
+    }
+
+    if (active) {
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                                   PCI_EXP_LNKSTA_DLLLA);
+    } else {
+        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+                                     PCI_EXP_LNKSTA_DLLLA);
+    }
+}
+
 static void hotplug_event_update_event_status(PCIDevice *dev)
 {
     uint32_t pos = dev->exp.exp_cap;
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 71ba94874b4..4d27c4eb835 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -105,6 +105,7 @@ void pcie_cap_deverr_reset(PCIDevice *dev);
 
 void pcie_cap_lnkctl_init(PCIDevice *dev);
 void pcie_cap_lnkctl_reset(PCIDevice *dev);
+void pcie_cap_set_dllla(PCIDevice *dev, bool active);
 
 void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s);
 void pcie_cap_slot_reset(PCIDevice *dev);
-- 
2.53.0


