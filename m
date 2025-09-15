Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C8BCAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6Ce-0004Jy-A1; Mon, 15 Sep 2025 06:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uy6Cb-00048z-6X; Mon, 15 Sep 2025 06:12:53 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uy6CH-0006sU-Rv; Mon, 15 Sep 2025 06:12:49 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58FA8uMG006344
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Sep 2025 19:09:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jD8xXCxKpQezlTUVEU/kFhHTu8Hn9yOq/MDXRMgQpcc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1757930941; v=1;
 b=l6DPKZhemiOw2o+r+Fl3WO0+RwdaEUYO78xzc4sCmJEkGwi+UOJ3ysMvy51MOBFM
 iwBqiKcVjKWGHj2eUDinbvKX8n+ksGjx7yZIIljdMp9mGjI6xPRS5FPg3U5y1BBY
 NQ4BcZ/kO4PeMSgP2XHRI+Hn4wZqLQbLlJ3mbECcuRbVYhm7IjrVlPkFCpUZV4LL
 dhlHx2+vlpN6Nxu1iXs6dT0SGLiVUbqCloxgAU7n11EM3jk7VhPGD7DukF6gPkeH
 zW7QUAmUdV9b/l+3oU+3UZBZCeLD6QRIwyYXh9N1EagYbhKdUC0s18HUbQHoB9Uc
 SduFEuo33esDyt1y8PB26w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Sep 2025 19:08:44 +0900
Subject: [PATCH v2 03/15] hw/pci-bridge: Do not assume immediate
 MemoryRegion finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-use-v2-3-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp>
References: <20250915-use-v2-0-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250915-use-v2-0-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When updating memory mappings, pci_bridge_update_mappings() performed
the following operations:
1. Start a transaction
2. Delete the subregions from the container
3. Unparent the subregions
4. Initialize the subregions
5. End the transaction

This assumes the old subregion instances are finalized immediately after
3, but it is not true; the finalization is delayed until 5. Remove the
assumption by using functions to dynamically update MemoryRegions.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/pci/pci.h |  1 +
 hw/pci/pci.c         |  2 +-
 hw/pci/pci_bridge.c  | 96 ++++++++++++++++++++++++++++------------------------
 3 files changed, 54 insertions(+), 45 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 6b7d3ac8a361..d0bd214b4e11 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -256,6 +256,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
                       uint8_t attr, MemoryRegion *memory);
 void pci_register_vga(PCIDevice *pci_dev, MemoryRegion *mem,
                       MemoryRegion *io_lo, MemoryRegion *io_hi);
+void pci_update_vga(PCIDevice *pci_dev);
 void pci_unregister_vga(PCIDevice *pci_dev);
 pcibus_t pci_get_bar_addr(PCIDevice *pci_dev, int region_num);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceebaf1..516029f66cda 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1521,7 +1521,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     }
 }
 
-static void pci_update_vga(PCIDevice *pci_dev)
+void pci_update_vga(PCIDevice *pci_dev)
 {
     uint16_t cmd;
 
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 76255c4cd892..240d0f904de9 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -145,11 +145,10 @@ pcibus_t pci_bridge_get_limit(const PCIDevice *bridge, uint8_t type)
     return limit;
 }
 
-static void pci_bridge_init_alias(PCIBridge *bridge, MemoryRegion *alias,
-                                  uint8_t type, const char *name,
-                                  MemoryRegion *space,
-                                  MemoryRegion *parent_space,
-                                  bool enabled)
+static void pci_bridge_update_alias(PCIBridge *bridge, bool init,
+                                    MemoryRegion *alias, uint8_t type,
+                                    const char *name, MemoryRegion *space,
+                                    MemoryRegion *parent_space, bool enabled)
 {
     PCIDevice *bridge_dev = PCI_DEVICE(bridge);
     pcibus_t base = pci_bridge_get_base(bridge_dev, type);
@@ -158,25 +157,37 @@ static void pci_bridge_init_alias(PCIBridge *bridge, MemoryRegion *alias,
      * Apparently no way to do this with existing memory APIs. */
     pcibus_t size = enabled && limit >= base ? limit + 1 - base : 0;
 
-    memory_region_init_alias(alias, OBJECT(bridge), name, space, base, size);
+    if (init) {
+        memory_region_init_alias(alias, OBJECT(bridge), name, space, base, size);
+    } else {
+        memory_region_set_size(alias, size);
+        memory_region_set_alias_offset(alias, base);
+    }
+
     memory_region_add_subregion_overlap(parent_space, base, alias, 1);
 }
 
-static void pci_bridge_init_vga_aliases(PCIBridge *br, PCIBus *parent,
-                                        MemoryRegion *alias_vga)
+static void pci_bridge_update_vga_aliases(PCIBridge *br, bool init,
+                                          PCIBus *parent,
+                                          MemoryRegion *alias_vga)
 {
     PCIDevice *pd = PCI_DEVICE(br);
     uint16_t brctl = pci_get_word(pd->config + PCI_BRIDGE_CONTROL);
 
-    memory_region_init_alias(&alias_vga[QEMU_PCI_VGA_IO_LO], OBJECT(br),
-                             "pci_bridge_vga_io_lo", &br->address_space_io,
-                             QEMU_PCI_VGA_IO_LO_BASE, QEMU_PCI_VGA_IO_LO_SIZE);
-    memory_region_init_alias(&alias_vga[QEMU_PCI_VGA_IO_HI], OBJECT(br),
-                             "pci_bridge_vga_io_hi", &br->address_space_io,
-                             QEMU_PCI_VGA_IO_HI_BASE, QEMU_PCI_VGA_IO_HI_SIZE);
-    memory_region_init_alias(&alias_vga[QEMU_PCI_VGA_MEM], OBJECT(br),
-                             "pci_bridge_vga_mem", &br->address_space_mem,
-                             QEMU_PCI_VGA_MEM_BASE, QEMU_PCI_VGA_MEM_SIZE);
+    if (init) {
+        memory_region_init_alias(&alias_vga[QEMU_PCI_VGA_IO_LO], OBJECT(br),
+                                 "pci_bridge_vga_io_lo", &br->address_space_io,
+                                 QEMU_PCI_VGA_IO_LO_BASE,
+                                 QEMU_PCI_VGA_IO_LO_SIZE);
+        memory_region_init_alias(&alias_vga[QEMU_PCI_VGA_IO_HI], OBJECT(br),
+                                 "pci_bridge_vga_io_hi", &br->address_space_io,
+                                 QEMU_PCI_VGA_IO_HI_BASE,
+                                 QEMU_PCI_VGA_IO_HI_SIZE);
+        memory_region_init_alias(&alias_vga[QEMU_PCI_VGA_MEM], OBJECT(br),
+                                 "pci_bridge_vga_mem", &br->address_space_mem,
+                                 QEMU_PCI_VGA_MEM_BASE,
+                                 QEMU_PCI_VGA_MEM_SIZE);
+    }
 
     if (brctl & PCI_BRIDGE_CTL_VGA) {
         pci_register_vga(pd, &alias_vga[QEMU_PCI_VGA_MEM],
@@ -185,33 +196,33 @@ static void pci_bridge_init_vga_aliases(PCIBridge *br, PCIBus *parent,
     }
 }
 
-static void pci_bridge_region_init(PCIBridge *br)
+static void pci_bridge_region_update(PCIBridge *br, bool init)
 {
     PCIDevice *pd = PCI_DEVICE(br);
     PCIBus *parent = pci_get_bus(pd);
     PCIBridgeWindows *w = &br->windows;
     uint16_t cmd = pci_get_word(pd->config + PCI_COMMAND);
 
-    pci_bridge_init_alias(br, &w->alias_pref_mem,
-                          PCI_BASE_ADDRESS_MEM_PREFETCH,
-                          "pci_bridge_pref_mem",
-                          &br->address_space_mem,
-                          parent->address_space_mem,
-                          cmd & PCI_COMMAND_MEMORY);
-    pci_bridge_init_alias(br, &w->alias_mem,
-                          PCI_BASE_ADDRESS_SPACE_MEMORY,
-                          "pci_bridge_mem",
-                          &br->address_space_mem,
-                          parent->address_space_mem,
-                          cmd & PCI_COMMAND_MEMORY);
-    pci_bridge_init_alias(br, &w->alias_io,
-                          PCI_BASE_ADDRESS_SPACE_IO,
-                          "pci_bridge_io",
-                          &br->address_space_io,
-                          parent->address_space_io,
-                          cmd & PCI_COMMAND_IO);
-
-    pci_bridge_init_vga_aliases(br, parent, w->alias_vga);
+    pci_bridge_update_alias(br, init, &w->alias_pref_mem,
+                            PCI_BASE_ADDRESS_MEM_PREFETCH,
+                            "pci_bridge_pref_mem",
+                            &br->address_space_mem,
+                            parent->address_space_mem,
+                            cmd & PCI_COMMAND_MEMORY);
+    pci_bridge_update_alias(br, init, &w->alias_mem,
+                            PCI_BASE_ADDRESS_SPACE_MEMORY,
+                            "pci_bridge_mem",
+                            &br->address_space_mem,
+                            parent->address_space_mem,
+                            cmd & PCI_COMMAND_MEMORY);
+    pci_bridge_update_alias(br, init, &w->alias_io,
+                            PCI_BASE_ADDRESS_SPACE_IO,
+                            "pci_bridge_io",
+                            &br->address_space_io,
+                            parent->address_space_io,
+                            cmd & PCI_COMMAND_IO);
+
+    pci_bridge_update_vga_aliases(br, init, parent, w->alias_vga);
 }
 
 static void pci_bridge_region_del(PCIBridge *br, PCIBridgeWindows *w)
@@ -237,14 +248,11 @@ static void pci_bridge_region_cleanup(PCIBridge *br, PCIBridgeWindows *w)
 
 void pci_bridge_update_mappings(PCIBridge *br)
 {
-    PCIBridgeWindows *w = &br->windows;
-
     /* Make updates atomic to: handle the case of one VCPU updating the bridge
      * while another accesses an unaffected region. */
     memory_region_transaction_begin();
-    pci_bridge_region_del(br, w);
-    pci_bridge_region_cleanup(br, w);
-    pci_bridge_region_init(br);
+    pci_bridge_region_del(br, &br->windows);
+    pci_bridge_region_update(br, false);
     memory_region_transaction_commit();
 }
 
@@ -386,7 +394,7 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
                        4 * GiB);
     address_space_init(&br->as_io, &br->address_space_io, "pci_bridge_pci_io");
-    pci_bridge_region_init(br);
+    pci_bridge_region_update(br, true);
     QLIST_INIT(&sec_bus->child);
     QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
 

-- 
2.51.0


