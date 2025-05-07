Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016B2C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCj86-000889-5i; Wed, 07 May 2025 14:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uCj83-00086t-AZ; Wed, 07 May 2025 14:04:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uCj81-00089l-Ct; Wed, 07 May 2025 14:04:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E112811FEF7;
 Wed, 07 May 2025 21:03:59 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BDA7A2066FC;
 Wed,  7 May 2025 21:04:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 02/21] hw/pci/pci.c: Turn DPRINTF into trace events
Date: Wed,  7 May 2025 21:03:53 +0300
Message-Id: <20250507180412.182797-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250507180412.182797-1-mjt@tls.msk.ru>
References: <20250507180412.182797-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Remove PCI_DPRINTF() macro and use trace events instead.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/pci/pci.c        | 19 ++++++-------------
 hw/pci/trace-events |  4 ++++
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fe38c4c028..352b3d12c8 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -54,13 +54,6 @@
 #include "hw/xen/xen.h"
 #include "hw/i386/kvm/xen_evtchn.h"
 
-//#define DEBUG_PCI
-#ifdef DEBUG_PCI
-# define PCI_DPRINTF(format, ...)       printf(format, ## __VA_ARGS__)
-#else
-# define PCI_DPRINTF(format, ...)       do { } while (0)
-#endif
-
 bool pci_available = true;
 
 static char *pcibus_get_dev_path(DeviceState *dev);
@@ -2439,12 +2432,12 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
     /* Only a valid rom will be patched. */
     rom_magic = pci_get_word(ptr);
     if (rom_magic != 0xaa55) {
-        PCI_DPRINTF("Bad ROM magic %04x\n", rom_magic);
+        trace_pci_bad_rom_magic(rom_magic, 0xaa55);
         return;
     }
     pcir_offset = pci_get_word(ptr + 0x18);
     if (pcir_offset + 8 >= size || memcmp(ptr + pcir_offset, "PCIR", 4)) {
-        PCI_DPRINTF("Bad PCIR offset 0x%x or signature\n", pcir_offset);
+        trace_pci_bad_pcir_offset(pcir_offset);
         return;
     }
 
@@ -2453,8 +2446,8 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
     rom_vendor_id = pci_get_word(ptr + pcir_offset + 4);
     rom_device_id = pci_get_word(ptr + pcir_offset + 6);
 
-    PCI_DPRINTF("%s: ROM id %04x%04x / PCI id %04x%04x\n", pdev->romfile,
-                vendor_id, device_id, rom_vendor_id, rom_device_id);
+    trace_pci_rom_and_pci_ids(pdev->romfile, vendor_id, device_id,
+                              rom_vendor_id, rom_device_id);
 
     checksum = ptr[6];
 
@@ -2462,7 +2455,7 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
         /* Patch vendor id and checksum (at offset 6 for etherboot roms). */
         checksum += (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id >> 8);
         checksum -= (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
-        PCI_DPRINTF("ROM checksum %02x / %02x\n", ptr[6], checksum);
+        trace_pci_rom_checksum_change(ptr[6], checksum);
         ptr[6] = checksum;
         pci_set_word(ptr + pcir_offset + 4, vendor_id);
     }
@@ -2471,7 +2464,7 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
         /* Patch device id and checksum (at offset 6 for etherboot roms). */
         checksum += (uint8_t)rom_device_id + (uint8_t)(rom_device_id >> 8);
         checksum -= (uint8_t)device_id + (uint8_t)(device_id >> 8);
-        PCI_DPRINTF("ROM checksum %02x / %02x\n", ptr[6], checksum);
+        trace_pci_rom_checksum_change(ptr[6], checksum);
         ptr[6] = checksum;
         pci_set_word(ptr + pcir_offset + 6, device_id);
     }
diff --git a/hw/pci/trace-events b/hw/pci/trace-events
index 6a9968962f..02c80d3ec8 100644
--- a/hw/pci/trace-events
+++ b/hw/pci/trace-events
@@ -6,6 +6,10 @@ pci_pm_transition(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, u
 pci_update_mappings_del(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
 pci_update_mappings_add(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
 pci_route_irq(int dev_irq, const char *dev_path, int parent_irq, const char *parent_path) "IRQ %d @%s -> IRQ %d @%s"
+pci_bad_rom_magic(uint16_t bad_rom_magic, uint16_t good_rom_magic) "Bad ROM magic number: %04"PRIX16". Should be: %04"PRIX16
+pci_bad_pcir_offset(uint16_t pcir_offset) "Bad PCIR offset 0x%"PRIx16" or signature"
+pci_rom_and_pci_ids(char *romfile, uint16_t vendor_id, uint16_t device_id, uint16_t rom_vendor_id, uint16_t rom_device_id) "%s: ROM ID %04"PRIx16":%04"PRIx16" | PCI ID %04"PRIx16":%04"PRIx16
+pci_rom_checksum_change(uint8_t old_checksum, uint8_t new_checksum) "ROM checksum changed from %02"PRIx8" to %02"PRIx8
 
 # pci_host.c
 pci_cfg_read(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, unsigned offs, unsigned val) "%s %02x:%02x.%x @0x%x -> 0x%x"
-- 
2.39.5


