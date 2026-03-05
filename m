Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83B4F513E9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 23:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyIFy-0004L6-GZ; Thu, 05 Mar 2026 18:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyIFw-0004Kh-5l
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 18:37:24 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyIFu-00079L-8w
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 18:37:23 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 50303596D9A;
 Fri, 06 Mar 2026 00:37:19 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id N1zz8Y8xDN1a; Fri,  6 Mar 2026 00:37:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1D08F5969F6; Fri, 06 Mar 2026 00:37:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] ati-vga: Allow setting EDID parameters directly
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
    marcandre.lureau@redhat.com
Message-Id: <20260305233717.1D08F5969F6@zero.eik.bme.hu>
Date: Fri, 06 Mar 2026 00:37:17 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

The EDID generation has some parameters that can be set via properties
but since ati-vga uses i2c-ddc it is only accessible with -global
option. Expose these properties so users can more easily set it via
e.g. -device ati-vga,xres=1024,yres=768.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Based-on: 20260303024730.1489136-1-chad@jablonski.xyz

 hw/display/ati.c     | 13 ++++++++-----
 hw/display/ati_int.h |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index c93ef64525..bb9e0bba28 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -28,7 +28,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "ui/console.h"
-#include "hw/display/i2c-ddc.h"
 #include "trace.h"
 
 #define ATI_DEBUG_HW_CURSOR 0
@@ -1058,6 +1057,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
 {
     ATIVGAState *s = ATI_VGA(dev);
     VGACommonState *vga = &s->vga;
+    I2CBus *i2cbus;
     uint64_t aper_size;
 
 #ifndef CONFIG_PIXMAN
@@ -1106,11 +1106,10 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     }
 
     /* ddc, edid */
-    I2CBus *i2cbus = i2c_init_bus(DEVICE(s), "ati-vga.ddc");
+    i2cbus = i2c_init_bus(DEVICE(s), "ati-vga.ddc");
     bitbang_i2c_init(&s->bbi2c, i2cbus);
-    I2CSlave *i2cddc = I2C_SLAVE(qdev_new(TYPE_I2CDDC));
-    i2c_slave_set_address(i2cddc, 0x50);
-    qdev_realize_and_unref(DEVICE(i2cddc), BUS(i2cbus), &error_abort);
+    i2c_slave_set_address(I2C_SLAVE(&s->i2cddc), 0x50);
+    qdev_realize(DEVICE(&s->i2cddc), BUS(i2cbus), &error_abort);
 
     /* mmio register space */
     memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
@@ -1171,6 +1170,7 @@ static const Property ati_vga_properties[] = {
     DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, false),
     /* this is a debug option, prefer PROP_UINT over PROP_BIT for simplicity */
     DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, DEFAULT_X_PIXMAN),
+    DEFINE_EDID_PROPERTIES(ATIVGAState, i2cddc.edid_info),
 };
 
 static void ati_vga_class_init(ObjectClass *klass, const void *data)
@@ -1193,6 +1193,9 @@ static void ati_vga_class_init(ObjectClass *klass, const void *data)
 
 static void ati_vga_init(Object *o)
 {
+    ATIVGAState *s = ATI_VGA(o);
+
+    object_initialize_child(o, "edid", &s->i2cddc, TYPE_I2CDDC);
     object_property_set_description(o, "x-pixman", "Use pixman for: "
                                     "1: fill, 2: blit");
 }
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 28f4e9d977..21b74511e0 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -13,6 +13,7 @@
 #include "qemu/units.h"
 #include "hw/pci/pci_device.h"
 #include "hw/i2c/bitbang_i2c.h"
+#include "hw/display/i2c-ddc.h"
 #include "vga_int.h"
 #include "qom/object.h"
 
@@ -117,6 +118,7 @@ struct ATIVGAState {
     QEMUCursor *cursor;
     QEMUTimer vblank_timer;
     bitbang_i2c_interface bbi2c;
+    I2CDDCState i2cddc;
     MemoryRegion linear_aper;
     MemoryRegion io;
     MemoryRegion mm;
-- 
2.41.3


