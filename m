Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF743D597B3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 22:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAzRc-00008l-0q; Tue, 12 Nov 2024 17:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jpruiz84@gmail.com>)
 id 1tAyyS-0003Ph-Jg
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 17:03:00 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jpruiz84@gmail.com>)
 id 1tAyyQ-0007iS-1W
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 17:03:00 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb561f273eso51391481fa.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 14:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731448975; x=1732053775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ugN7Gkg3dbnDBT76C0qyEdPsmiwDjNRo2jyXEz+6wsY=;
 b=MvQRrmoDs1xuLj6SS0oajY0nDk2rDKiGM/Ttgnfm+75hd3Aw2aEPij//pE0sGwL2D7
 PtYUfTp+EQHJOjjMsrNuLwucfwRxREZ5QgfhqlCjuIukEHL81HtwsX2vrdFk+Yw+86w8
 K9Ury6tzyoRWRQgj0FI+qcOyi0DyyViBENheq0iekT3fegPz6cWrVSQrMS/kC6FhmTEp
 5QYDzP9uqKOBxd6OE4bPkYzgD0AHeZSqizT9x0OxTWiYvchJwe+XfOixch5bBJ1PMSOs
 0ot7mRU1itr5XrEQE2XMdlQc50pWzz704ybs0Xqns4HSQJSMFSl2kXPg/JeBXUVhK6ef
 rGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731448975; x=1732053775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ugN7Gkg3dbnDBT76C0qyEdPsmiwDjNRo2jyXEz+6wsY=;
 b=NUYShMW+lttoaoUcW6dMp7qeU+le13hXT2UrSYu/m+OELdi5E2MT3JOC0R8cq079kV
 vGAdUSbPSCECD3UQpIPXAW+sgsLcmCQoTzf+f1K7biw8dZTLwt0cEA1xuOiQCXWhwD5e
 G001x5cXgAUEJvlyIHhw3oNuqAvBBJiQ1ta8lKuZ9iGdd/cV6y6g48/PeNVC/NgEOHqz
 f2Tor7uEaWHgJGDkgrB1UvhLQTD4RK0Hti2naUH+TG9tkSz1iBxikQo7bdoN1aR30WP0
 2IHcT10aqCYnx7Vw+0RilPxqZfkd+GI4c11ezvzpatXxo8w9kkTVhb8SyBvJWSds4jTc
 dVLw==
X-Gm-Message-State: AOJu0YxflBdF2XuVQsgKjnYJAKkOFM/OdI6UxVaISRlQ/+83IcKkhXmE
 PB3mMpwuLecxP9JNqbBzc5zEDut0NBJqd0v4wNohEXnst4ZEouG9+7MV+w==
X-Google-Smtp-Source: AGHT+IH986/3E6YjgvtPK95YFwsObQYCIiu+TJOpFQmYVJ0YSEKiSc2Wc+Ugz/JdLyb61yxIMGlp7Q==
X-Received: by 2002:a05:651c:2114:b0:2fa:d978:a6a2 with SMTP id
 38308e7fff4ca-2ff426fbb90mr23612571fa.27.1731448975070; 
 Tue, 12 Nov 2024 14:02:55 -0800 (PST)
Received: from localhost.localdomain (87-92-91-214.bb.dnainternet.fi.
 [87.92.91.214]) by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-2ff17991d27sm21660571fa.69.2024.11.12.14.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 14:02:53 -0800 (PST)
From: Juan Pablo Ruiz <jpruiz84@gmail.com>
X-Google-Original-From: Juan Pablo Ruiz <juanpablo.ruiz@unikie.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com,
	Juan Pablo Ruiz <juanpablo.ruiz@unikie.com>
Subject: [PATCH 1/1] vfio/platform: Add mmio-base property to define start
 address for MMIO mapping
Date: Tue, 12 Nov 2024 22:02:12 +0000
Message-Id: <20241112220212.2237-1-juanpablo.ruiz@unikie.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=jpruiz84@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 17:33:01 -0500
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

Some platform devices have large MMIO regions (e.g., GPU reserved memory). For
certain devices, it's preferable to have a 1:1 address translation in the VM to
avoid modifying driver source code.

This patch:

1. Increases the VFIO platform bus size from 32MB to 130GB.
2. Changes the mmio_size property from 32 to 64 bits.
3. Adds an mmio-base property to define the starting MMIO address for mapping
   the VFIO device.

Signed-off-by: Juan Pablo Ruiz juanpablo.ruiz@unikie.com
---
 hw/arm/virt.c                   |  6 +++---
 hw/core/platform-bus.c          | 28 ++++++++++++++++++++++++++--
 hw/vfio/platform.c              |  1 +
 include/hw/platform-bus.h       |  2 +-
 include/hw/vfio/vfio-platform.h |  1 +
 5 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1a381e9a2b..9fc8f4425a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -183,13 +183,13 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
-    [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
+    [VIRT_PLATFORM_BUS] =       { 0x60000000, 0x1FC0000000 },          // 130048MB
     [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
     [VIRT_PCIE_MMIO] =          { 0x10000000, 0x2eff0000 },
     [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
     [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
     /* Actual RAM size depends on initial RAM and device memory settings */
-    [VIRT_MEM] =                { GiB, LEGACY_RAMLIMIT_BYTES },
+    [VIRT_MEM] =                { 0x2000000000, LEGACY_RAMLIMIT_BYTES },
 };
 
 /*
@@ -1625,7 +1625,7 @@ static void create_platform_bus(VirtMachineState *vms)
     dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
     dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
     qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
-    qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
+    qdev_prop_set_uint64(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     vms->platform_bus_dev = dev;
 
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index dc58bf505a..f545fab6e5 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/platform-bus.h"
 #include "hw/qdev-properties.h"
+#include "hw/vfio/vfio-platform.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
@@ -130,11 +131,29 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
                                   int n)
 {
     MemoryRegion *sbdev_mr = sysbus_mmio_get_region(sbdev, n);
+    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
     uint64_t size = memory_region_size(sbdev_mr);
     uint64_t alignment = (1ULL << (63 - clz64(size + size - 1)));
     uint64_t off;
+    uint64_t mmio_base_off;
     bool found_region = false;
 
+    if (vdev->mmio_base) {
+        if(vdev->mmio_base < pbus->mmio.addr || 
+           vdev->mmio_base >= pbus->mmio.addr + pbus->mmio_size){
+            error_report("Platform Bus: MMIO base 0x%"PRIx64
+                " outside platform bus region [0x%"PRIx64",0x%"PRIx64"]",
+                vdev->mmio_base,
+                pbus->mmio.addr,
+                pbus->mmio.addr + pbus->mmio_size);
+            exit(1);
+        }
+        
+        mmio_base_off = vdev->mmio_base - pbus->mmio.addr;
+    } else {
+        mmio_base_off = 0;
+    }
+    
     if (memory_region_is_mapped(sbdev_mr)) {
         /* Region is already mapped, nothing to do */
         return;
@@ -144,7 +163,7 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
      * Look for empty space in the MMIO space that is naturally aligned with
      * the target device's memory region
      */
-    for (off = 0; off < pbus->mmio_size; off += alignment) {
+    for (off = mmio_base_off; off < pbus->mmio_size; off += alignment) {
         MemoryRegion *mr = memory_region_find(&pbus->mmio, off, size).mr;
         if (!mr) {
             found_region = true;
@@ -154,6 +173,11 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
         }
     }
 
+    if (vdev->mmio_base && vdev->mmio_base != off + pbus->mmio.addr) {
+        warn_report("Platform Bus: Not able to map in mmio base: 0x%"PRIx64, 
+            vdev->mmio_base);
+    }
+
     if (!found_region) {
         error_report("Platform Bus: Can not fit MMIO region of size %"PRIx64,
                      size);
@@ -206,7 +230,7 @@ static void platform_bus_realize(DeviceState *dev, Error **errp)
 
 static Property platform_bus_properties[] = {
     DEFINE_PROP_UINT32("num_irqs", PlatformBusDevice, num_irqs, 0),
-    DEFINE_PROP_UINT32("mmio_size", PlatformBusDevice, mmio_size, 0),
+    DEFINE_PROP_UINT64("mmio_size", PlatformBusDevice, mmio_size, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a85c199c76..cfac564093 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -640,6 +640,7 @@ static Property vfio_platform_dev_properties[] = {
     DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
+    DEFINE_PROP_UINT64("mmio-base", VFIOPlatformDevice, mmio_base, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
index 44f30c5353..4e9913a5d7 100644
--- a/include/hw/platform-bus.h
+++ b/include/hw/platform-bus.h
@@ -34,7 +34,7 @@ struct PlatformBusDevice {
     SysBusDevice parent_obj;
 
     /*< public >*/
-    uint32_t mmio_size;
+    uint64_t mmio_size;
     MemoryRegion mmio;
 
     uint32_t num_irqs;
diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
index c414c3dffc..90575b5852 100644
--- a/include/hw/vfio/vfio-platform.h
+++ b/include/hw/vfio/vfio-platform.h
@@ -59,6 +59,7 @@ struct VFIOPlatformDevice {
     uint32_t mmap_timeout; /* delay to re-enable mmaps after interrupt */
     QEMUTimer *mmap_timer; /* allows fast-path resume after IRQ hit */
     QemuMutex intp_mutex; /* protect the intp_list IRQ state */
+    uint64_t mmio_base; /* base address to start looking for mmio */
     bool irqfd_allowed; /* debug option to force irqfd on/off */
 };
 typedef struct VFIOPlatformDevice VFIOPlatformDevice;
-- 
2.34.1


