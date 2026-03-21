Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C3E1094480
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 16:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3zDg-0006Ce-8H; Sat, 21 Mar 2026 12:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3zDZ-0006AR-Pm
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 12:30:30 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w3zDW-0002FI-Ql
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 12:30:29 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 39DB4596E01;
 Sat, 21 Mar 2026 17:30:19 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id tfUp1eLCUZaY; Sat, 21 Mar 2026 17:30:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 29B14596DFC; Sat, 21 Mar 2026 17:30:17 +0100 (CET)
Message-ID: <47cbdc7ad2291f22467f9fc86e7287eb8983c927.1774110169.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1774110169.git.balaton@eik.bme.hu>
References: <cover.1774110169.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 6/8] ati-vga: Add work around for fuloong2e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sat, 21 Mar 2026 17:30:17 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

With the linear aperture size fixed to match real card fuloong2e no
longer works due to running out of PCI memory because only one PCI bus
is emulated on that machine. Add a property to allow fuloong2e to set
a smaller linear aperture size to work around that problem until the
machine model is improved.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c     | 17 +++++++++++++----
 hw/display/ati_int.h |  1 +
 hw/mips/fuloong2e.c  |  1 +
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 705e4db6e4..fba73a9956 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1074,7 +1074,6 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     ATIVGAState *s = ATI_VGA(dev);
     VGACommonState *vga = &s->vga;
     I2CBus *i2cbus;
-    uint64_t aper_size;
 
 #ifndef CONFIG_PIXMAN
     if (s->use_pixman != 0) {
@@ -1138,10 +1137,19 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
      * Rage128 the upper half of the aperture is reserved for an AGP
      * window (which we do not emulate.)
      */
-    aper_size = s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
-                ATI_RAGE128_LINEAR_APER_SIZE : ATI_R100_LINEAR_APER_SIZE;
+    if (!s->linear_aper_sz) {
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            s->linear_aper_sz = ATI_RAGE128_LINEAR_APER_SIZE;
+        } else {
+            s->linear_aper_sz = ATI_R100_LINEAR_APER_SIZE;
+        }
+    }
+    if (s->linear_aper_sz < 16 * MiB) {
+        error_setg(errp, "x-linear-aper-size is too small (minimum 16 MiB)");
+        return;
+    }
     memory_region_init(&s->linear_aper, OBJECT(dev), "ati-linear-aperture0",
-                       aper_size);
+                       s->linear_aper_sz);
     memory_region_add_subregion(&s->linear_aper, 0, &vga->vram);
 
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->linear_aper);
@@ -1186,6 +1194,7 @@ static const Property ati_vga_properties[] = {
     DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, false),
     /* this is a debug option, prefer PROP_UINT over PROP_BIT for simplicity */
     DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, DEFAULT_X_PIXMAN),
+    DEFINE_PROP_UINT64("x-linear-aper-size", ATIVGAState, linear_aper_sz, 0),
     DEFINE_EDID_PROPERTIES(ATIVGAState, i2cddc.edid_info),
 };
 
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 21b74511e0..0c48934d33 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -119,6 +119,7 @@ struct ATIVGAState {
     QEMUTimer vblank_timer;
     bitbang_i2c_interface bbi2c;
     I2CDDCState i2cddc;
+    uint64_t linear_aper_sz;
     MemoryRegion linear_aper;
     MemoryRegion io;
     MemoryRegion mm;
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index d0efe36f7c..72ad4507df 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -316,6 +316,7 @@ static void mips_fuloong2e_init(MachineState *machine)
         dev = DEVICE(pci_dev);
         qdev_prop_set_uint32(dev, "vgamem_mb", 16);
         qdev_prop_set_uint16(dev, "x-device-id", 0x5159);
+        qdev_prop_set_uint64(dev, "x-linear-aper-size", 16 * MiB);
         pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
     }
 
-- 
2.41.3


