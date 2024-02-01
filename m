Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76612C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaCe-0004NC-Lr; Thu, 01 Feb 2024 11:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaB6-0002xg-DK
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:41 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAv-0002St-1p
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=aYJS/1ZmHvWqcX4ZFiiuaV9MoKjFfmvD/b97zwR6RTs=; b=Er0Jz5qlmqqRMlQldC8zhwLAIT
 9ukAVW2piO/2sdvnt9Td/W+G81N7Aj6ENE+Q//Q8hRSNKfSATColxhRP24Qe7yFxhuLnpWChIsKuz
 JxNPwOHhx0k2h0Cf6HVMxjNXfgesfzD6t413dI6R06nX7nukioi3oFZ+fUGULgejXJcP38z8vTZbk
 jrj3uUR1cciIpe3oiNc2NFuDGAB0tR1nql6IoCqp8DmnOHK46A4f5jBdExXUEZsVr/RLDg1kGkPh8
 khlYsVc7fCANFiVqNmBpyfaPyUevXeot+XB/q5Hp9ys4gdY/846PjnqPOa9n+8y8sWVN6/pfvRkof
 TGkN08yw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAg-00000009cLz-0m7K for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAf-00000003IM6-1LeT for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:13 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/47] hw/i386/pc: use qemu_get_nic_info() and
 pci_init_nic_devices()
Date: Thu,  1 Feb 2024 16:43:30 +0000
Message-ID: <20240201164412.785520-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
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

Eliminate direct access to nd_table[] and nb_nics by processing the the
Xen and ISA NICs first and then calling pci_init_nic_devices() for the
rest.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/i386/pc.c                | 31 +++++++++++++++++++------------
 include/hw/net/ne2000-isa.h |  2 --
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 803244e5cc..ebb0b1c667 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -654,15 +654,19 @@ static const int ne2000_io[NE2000_NB_MAX] = { 0x300, 0x320, 0x340, 0x360,
                                               0x280, 0x380 };
 static const int ne2000_irq[NE2000_NB_MAX] = { 9, 10, 11, 3, 4, 5 };
 
-static void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd)
+static gboolean pc_init_ne2k_isa(ISABus *bus, NICInfo *nd, Error **errp)
 {
     static int nb_ne2k = 0;
 
-    if (nb_ne2k == NE2000_NB_MAX)
-        return;
+    if (nb_ne2k == NE2000_NB_MAX) {
+        error_setg(errp,
+                   "maximum number of ISA NE2000 devices exceeded");
+        return false;
+    }
     isa_ne2000_init(bus, ne2000_io[nb_ne2k],
                     ne2000_irq[nb_ne2k], nd);
     nb_ne2k++;
+    return true;
 }
 
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
@@ -1297,23 +1301,26 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus,
                  BusState *xen_bus)
 {
     MachineClass *mc = MACHINE_CLASS(pcmc);
-    int i;
+    bool default_is_ne2k = g_str_equal(mc->default_nic, TYPE_ISA_NE2000);
+    NICInfo *nd;
 
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_NIC);
-    for (i = 0; i < nb_nics; i++) {
-        NICInfo *nd = &nd_table[i];
-        const char *model = nd->model ? nd->model : mc->default_nic;
 
-        if (xen_bus && (!nd->model || g_str_equal(model, "xen-net-device"))) {
+    if (xen_bus) {
+        while ((nd = qemu_find_nic_info("xen-net-device", true, NULL))) {
             DeviceState *dev = qdev_new("xen-net-device");
             qdev_set_nic_properties(dev, nd);
             qdev_realize_and_unref(dev, xen_bus, &error_fatal);
-        } else if (g_str_equal(model, "ne2k_isa")) {
-            pc_init_ne2k_isa(isa_bus, nd);
-        } else {
-            pci_nic_init_nofail(nd, pci_bus, model, NULL);
         }
     }
+
+    while ((nd = qemu_find_nic_info(TYPE_ISA_NE2000, default_is_ne2k, NULL))) {
+        pc_init_ne2k_isa(isa_bus, nd, &error_fatal);
+    }
+
+    /* Anything remaining should be a PCI NIC */
+    pci_init_nic_devices(pci_bus, mc->default_nic);
+
     rom_reset_order_override();
 }
 
diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index af59ee0b02..73bae10ad1 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -22,8 +22,6 @@ static inline ISADevice *isa_ne2000_init(ISABus *bus, int base, int irq,
 {
     ISADevice *d;
 
-    qemu_check_nic_model(nd, "ne2k_isa");
-
     d = isa_try_new(TYPE_ISA_NE2000);
     if (d) {
         DeviceState *dev = DEVICE(d);
-- 
2.43.0


