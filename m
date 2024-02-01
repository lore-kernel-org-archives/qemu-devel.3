Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF230C48292
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDn-0007Ck-Pd; Thu, 01 Feb 2024 11:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaB2-0002tu-1l
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:36 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAt-0002Pt-RU
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=dpw3DRxnhjEAefg4lwR8FOrDMECu9upnm/FS6/8ckXY=; b=sMhEF2mohBz5yqjxntMPS1FtRH
 9iecihKVygOk9WKa3fBgtbjc+oZGxqvMLtie8nHqY7L9a/tQ8K8+VNZIL1PW96f/cL+/S1IFzAxrW
 aS8tTea7XynpySMhv8OGhbqRf0IrjHSMtBlJS0EKA2LI0icfTshqWL0ACi8KIqmnGHAdxli62P4hF
 IM3rf7CD2dUANkFtJK+iLLAMcjDvppxDnet97cP8zwOCf8b3E+VhHJnUXrcywK8o11sHCghi7EJ9E
 de/knMjW+dBsu4GlDYlSotfGGhtFezyt5MBJWoMUDwuscB8O9VhbLB/e6SueQOVuM+zr14YrbHdrH
 KipP/+eQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAe-0000000GIcw-1g7S for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:13 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAf-00000003IM2-148m for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:13 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/47] hw/pci: add pci_init_nic_devices(),
 pci_init_nic_in_slot()
Date: Thu,  1 Feb 2024 16:43:29 +0000
Message-ID: <20240201164412.785520-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

The loop over nd_table[] to add PCI NICs is repeated in quite a few
places. Add a helper function to do it.

Some platforms also try to instantiate a specific model in a specific
slot, to match the real hardware. Add pci_init_nic_in_slot() for that
purpose.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/pci/pci.c         | 45 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h |  4 +++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 76080af580..5849606f66 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1925,6 +1925,51 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
     return pci_dev;
 }
 
+void pci_init_nic_devices(PCIBus *bus, const char *default_model)
+{
+    qemu_create_nic_bus_devices(&bus->qbus, TYPE_PCI_DEVICE, default_model,
+                                "virtio", "virtio-net-pci");
+}
+
+bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
+                          const char *alias, const char *devaddr)
+{
+    NICInfo *nd = qemu_find_nic_info(model, true, alias);
+    int dom, busnr, devfn;
+    PCIDevice *pci_dev;
+    unsigned slot;
+    PCIBus *bus;
+
+    if (!nd) {
+        return false;
+    }
+
+    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) < 0) {
+        error_report("Invalid PCI device address %s for device %s",
+                     devaddr, model);
+        exit(1);
+    }
+
+    if (dom != 0) {
+        error_report("No support for non-zero PCI domains");
+        exit(1);
+    }
+
+    devfn = PCI_DEVFN(slot, 0);
+
+    bus = pci_find_bus_nr(rootbus, busnr);
+    if (!bus) {
+        error_report("Invalid PCI device address %s for device %s",
+                     devaddr, model);
+        exit(1);
+    }
+
+    pci_dev = pci_new(devfn, model);
+    qdev_set_nic_properties(&pci_dev->qdev, nd);
+    pci_realize_and_unref(pci_dev, bus, &error_fatal);
+    return true;
+}
+
 PCIDevice *pci_vga_init(PCIBus *bus)
 {
     vga_interface_created = true;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index fa6313aabc..6ff0b95a02 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -317,7 +317,9 @@ void pci_device_reset(PCIDevice *dev);
 PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
                                const char *default_model,
                                const char *default_devaddr);
-
+void pci_init_nic_devices(PCIBus *bus, const char *default_model);
+bool pci_init_nic_in_slot(PCIBus *rootbus, const char *default_model,
+                          const char *alias, const char *devaddr);
 PCIDevice *pci_vga_init(PCIBus *bus);
 
 static inline PCIBus *pci_get_bus(const PCIDevice *dev)
-- 
2.43.0


