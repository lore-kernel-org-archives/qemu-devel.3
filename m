Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56F6C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 17:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDn-0007CU-NF; Thu, 01 Feb 2024 11:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaB6-0002xh-Mc
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:41 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAv-0002Tk-1Y
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=/MTEStVe8JsIJfw31uF1pPqlJs68QbDUjigCzt5wrRY=; b=MN83k/OsTtGDYfxCHsF1QRBpBS
 H6KVR1OH6b7fXUxXcBrbp8Cf51izgrrmCF9bRph7zPJ6kqu5d8ZE+lMZTHsu8s44Ty1oWBzBEbWtZ
 iF2RUzru7uTVMDB1soWEEm63xgjjlq8IiFZ3fXYf926158X3qyqN8U2nPoNgaMHvNCh58pdCZwDH4
 MdT6ruEOjCzJCWqHW1QQ5yiT1ZYBbBYpLeVetd0uFOU1byMhKRoWi2BAY9cmwOlFsqDlexp1x0ehm
 6gMeq/DfiYT0tb7mX/04pJiZfh2WPoFUf06sxbbgoJ1armnu4kUQMuV0aGCPgrYhplKeZxttjg5cn
 oete+4wA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAf-0000000GIdi-2iUh for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003IOT-2wV4 for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/47] hw/net/lasi_i82596: use qemu_create_nic_device()
Date: Thu,  1 Feb 2024 16:44:03 +0000
Message-ID: <20240201164412.785520-39-dwmw2@infradead.org>
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

Create the device only if there is a corresponding NIC config for it.
Remove the explicit check on nd_table[0].used from hw/hppa/machine.c
which (since commit d8a3220005d7) tries to do the same thing.

The lasi_82596 support has been disabled since it was first introduced,
since enable_lasi_lan() has always been zero. This allows the user to
enable it by explicitly requesting a NIC model 'lasi_82596' or just
using the alias 'lasi'. Otherwise, it defaults to a PCI NIC as before.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/hppa/machine.c           | 11 ++++-------
 hw/net/lasi_i82596.c        | 12 +++++++-----
 include/hw/net/lasi_82596.h |  4 ++--
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a1045b48cc..5ae4f176f6 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -362,14 +362,11 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     }
 
     /* Network setup. */
-    if (nd_table[0].used && enable_lasi_lan()) {
-        lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
-                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
-    }
+    lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
+                    qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
+                    enable_lasi_lan());
 
-    if (!enable_lasi_lan()) {
-        pci_init_nic_devices(pci_bus, mc->default_nic);
-    }
+    pci_init_nic_devices(pci_bus, mc->default_nic);
 
     /* BMC board: HP Powerbar SP2 Diva (with console only) */
     pci_dev = pci_new(-1, "pci-serial");
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 09e830ba5f..fcf7fae941 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -118,19 +118,21 @@ static void lasi_82596_realize(DeviceState *dev, Error **errp)
     i82596_common_init(dev, s, &net_lasi_82596_info);
 }
 
-SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space,
-                  hwaddr hpa, qemu_irq lan_irq)
+SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space, hwaddr hpa,
+                                   qemu_irq lan_irq, gboolean match_default)
 {
     DeviceState *dev;
     SysBusI82596State *s;
     static const MACAddr HP_MAC = {
         .a = { 0x08, 0x00, 0x09, 0xef, 0x34, 0xf6 } };
 
-    qemu_check_nic_model(&nd_table[0], TYPE_LASI_82596);
-    dev = qdev_new(TYPE_LASI_82596);
+    dev = qemu_create_nic_device(TYPE_LASI_82596, match_default, "lasi");
+    if (!dev) {
+        return NULL;
+    }
+
     s = SYSBUS_I82596(dev);
     s->state.irq = lan_irq;
-    qdev_set_nic_properties(dev, &nd_table[0]);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     s->state.conf.macaddr = HP_MAC; /* set HP MAC prefix */
 
diff --git a/include/hw/net/lasi_82596.h b/include/hw/net/lasi_82596.h
index 3ef2f47ba2..439356ec19 100644
--- a/include/hw/net/lasi_82596.h
+++ b/include/hw/net/lasi_82596.h
@@ -25,7 +25,7 @@ struct SysBusI82596State {
     int val_index:1;
 };
 
-SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space,
-                                    hwaddr hpa, qemu_irq irq);
+SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space, hwaddr hpa,
+                                   qemu_irq irq, gboolean match_default);
 
 #endif
-- 
2.43.0


