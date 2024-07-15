Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED4EC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Sq-00027m-Me; Wed, 17 Jul 2024 07:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SV-0000xY-EE
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:36 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SQ-00070J-47
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:30 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 3A6A8379635; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 15/26] hw/display/apple-gfx: Separates generic &
 vmapple-specific functionality
Date: Mon, 15 Jul 2024 23:06:54 +0200
Message-Id: <20240715210705.32365-16-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715210705.32365-1-phil@philjordan.eu>
References: <20240715210705.32365-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

The apple-gfx paravirtualised graphics device can be used in a
MMIO mode with the 'vmapple' arm64 machine model, but also as
a PCI device, especially on x86-64 VMs. There are some
significant differences between these implementations, but
even more shared functionality.

This change prepares for a PCI based implementation by
splitting out the vmapple-specific code into a separate
code file.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/Kconfig             |   4 +
 hw/display/apple-gfx-vmapple.m | 194 +++++++++++++++++++++++++++++
 hw/display/apple-gfx.h         |  47 +++++++
 hw/display/apple-gfx.m         | 221 +++------------------------------
 hw/display/meson.build         |   3 +-
 hw/display/trace-events        |   2 +
 6 files changed, 266 insertions(+), 205 deletions(-)
 create mode 100644 hw/display/apple-gfx-vmapple.m
 create mode 100644 hw/display/apple-gfx.h

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 13cd256c06..e3d10bf6ff 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -146,4 +146,8 @@ config DM163
 
 config MAC_PVG
     bool
+    default y
 
+config MAC_PVG_VMAPPLE
+    bool
+    depends on MAC_PVG
diff --git a/hw/display/apple-gfx-vmapple.m b/hw/display/apple-gfx-vmapple.m
new file mode 100644
index 0000000000..6af8b7a292
--- /dev/null
+++ b/hw/display/apple-gfx-vmapple.m
@@ -0,0 +1,194 @@
+#include "apple-gfx.h"
+#include "monitor/monitor.h"
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+#include "trace.h"
+#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
+
+_Static_assert(__aarch64__, "");
+
+/*
+ * ParavirtualizedGraphics.Framework only ships header files for the x86
+ * variant which does not include IOSFC descriptors and host devices. We add
+ * their definitions here so that we can also work with the ARM version.
+ */
+typedef bool(^IOSFCRaiseInterrupt)(uint32_t vector);
+typedef bool(^IOSFCUnmapMemory)(
+    void *a, void *b, void *c, void *d, void *e, void *f);
+typedef bool(^IOSFCMapMemory)(
+    uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f);
+
+@interface PGDeviceDescriptor (IOSurfaceMapper)
+@property (readwrite, nonatomic) bool usingIOSurfaceMapper;
+@end
+
+@interface PGIOSurfaceHostDeviceDescriptor : NSObject
+-(PGIOSurfaceHostDeviceDescriptor *)init;
+@property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory mapMemory;
+@property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory unmapMemory;
+@property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt raiseInterrupt;
+@end
+
+@interface PGIOSurfaceHostDevice : NSObject
+-(instancetype)initWithDescriptor:(PGIOSurfaceHostDeviceDescriptor *) desc;
+-(uint32_t)mmioReadAtOffset:(size_t) offset;
+-(void)mmioWriteAtOffset:(size_t) offset value:(uint32_t)value;
+@end
+
+typedef struct AppleGFXVmappleState {
+    SysBusDevice parent_obj;
+
+    AppleGFXState common;
+
+    qemu_irq irq_gfx;
+    qemu_irq irq_iosfc;
+    MemoryRegion iomem_iosfc;
+    PGIOSurfaceHostDevice *pgiosfc;
+} AppleGFXVmappleState;
+
+OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXVmappleState, APPLE_GFX_VMAPPLE)
+
+
+static uint64_t apple_iosfc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AppleGFXVmappleState *s = opaque;
+    uint64_t res = 0;
+
+    bql_unlock();
+    res = [s->pgiosfc mmioReadAtOffset:offset];
+    bql_lock();
+
+    trace_apple_iosfc_read(offset, res);
+
+    return res;
+}
+
+static void apple_iosfc_write(
+    void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    AppleGFXVmappleState *s = opaque;
+
+    trace_apple_iosfc_write(offset, val);
+
+    [s->pgiosfc mmioWriteAtOffset:offset value:val];
+}
+
+static const MemoryRegionOps apple_iosfc_ops = {
+    .read = apple_iosfc_read,
+    .write = apple_iosfc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device(
+    AppleGFXVmappleState *s)
+{
+    PGIOSurfaceHostDeviceDescriptor *iosfc_desc =
+        [PGIOSurfaceHostDeviceDescriptor new];
+    PGIOSurfaceHostDevice *iosfc_host_dev = nil;
+
+    iosfc_desc.mapMemory =
+        ^(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
+            trace_apple_iosfc_map_memory(phys, len, ro, va, e, f);
+            MemoryRegion *tmp_mr;
+            *va = gpa2hva(&tmp_mr, phys, len, NULL);
+            return (bool)true;
+        };
+
+    iosfc_desc.unmapMemory =
+        ^(void *a, void *b, void *c, void *d, void *e, void *f) {
+            trace_apple_iosfc_unmap_memory(a, b, c, d, e, f);
+            return (bool)true;
+        };
+
+    iosfc_desc.raiseInterrupt = ^(uint32_t vector) {
+        trace_apple_iosfc_raise_irq(vector);
+        bool locked = bql_locked();
+        if (!locked) {
+            bql_lock();
+        }
+        qemu_irq_pulse(s->irq_iosfc);
+        if (!locked) {
+            bql_unlock();
+        }
+        return (bool)true;
+    };
+
+    iosfc_host_dev =
+        [[PGIOSurfaceHostDevice alloc] initWithDescriptor:iosfc_desc];
+    [iosfc_desc release];
+    return iosfc_host_dev;
+}
+
+static void apple_gfx_vmapple_realize(DeviceState *dev, Error **errp)
+{
+    @autoreleasepool {
+        AppleGFXVmappleState *s = APPLE_GFX_VMAPPLE(dev);
+
+        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
+        desc.usingIOSurfaceMapper = true;
+        desc.raiseInterrupt = ^(uint32_t vector) {
+            bool locked;
+
+            trace_apple_gfx_raise_irq(vector);
+            locked = bql_locked();
+            if (!locked) {
+                bql_lock();
+            }
+            qemu_irq_pulse(s->irq_gfx);
+            if (!locked) {
+                bql_unlock();
+            }
+        };
+
+        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
+
+        apple_gfx_common_realize(&s->common, desc);
+        [desc release];
+        desc = nil;
+    }
+}
+
+static void apple_gfx_vmapple_reset(DeviceState *d)
+{
+}
+
+static void apple_gfx_vmapple_init(Object *obj)
+{
+    AppleGFXVmappleState *s = APPLE_GFX_VMAPPLE(obj);
+
+    apple_gfx_common_init(obj, &s->common, TYPE_APPLE_GFX_VMAPPLE);
+
+    memory_region_init_io(&s->iomem_iosfc, obj, &apple_iosfc_ops, s,
+                          TYPE_APPLE_GFX_VMAPPLE, 0x10000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->common.iomem_gfx);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem_iosfc);
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_gfx);
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_iosfc);
+}
+
+static void apple_gfx_vmapple_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = apple_gfx_vmapple_reset;
+    dc->realize = apple_gfx_vmapple_realize;
+}
+
+static TypeInfo apple_gfx_vmapple_types[] = {
+    {
+        .name          = TYPE_APPLE_GFX_VMAPPLE,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AppleGFXVmappleState),
+        .class_init    = apple_gfx_vmapple_class_init,
+        .instance_init = apple_gfx_vmapple_init,
+    }
+};
+DEFINE_TYPES(apple_gfx_vmapple_types)
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
new file mode 100644
index 0000000000..fa7fea6368
--- /dev/null
+++ b/hw/display/apple-gfx.h
@@ -0,0 +1,47 @@
+#ifndef QEMU_APPLE_GFX_H
+#define QEMU_APPLE_GFX_H
+
+#define TYPE_APPLE_GFX_VMAPPLE      "apple-gfx-vmapple"
+#define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
+
+#include "qemu/typedefs.h"
+
+typedef struct AppleGFXState AppleGFXState;
+
+void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name);
+
+#ifdef __OBJC__
+
+#include "qemu/osdep.h"
+#include "exec/memory.h"
+#include "ui/surface.h"
+
+@class PGDeviceDescriptor;
+@protocol PGDevice;
+@protocol PGDisplay;
+@protocol MTLDevice;
+@protocol MTLTexture;
+
+typedef QTAILQ_HEAD(, PGTask_s) AppleGFXTaskList;
+
+struct AppleGFXState {
+    MemoryRegion iomem_gfx;
+    id<PGDevice> pgdev;
+    id<PGDisplay> pgdisp;
+    AppleGFXTaskList tasks;
+    QemuConsole *con;
+    void *vram;
+    id<MTLDevice> mtl;
+    id<MTLTexture> texture;
+    bool handles_frames;
+    bool new_frame;
+    bool cursor_show;
+    DisplaySurface *surface;
+    QEMUCursor *cursor;
+};
+
+void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc);
+
+#endif /* __OBJC__ */
+
+#endif
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index f9046f41a0..806feb58fa 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -12,16 +12,9 @@
  * implements support to drive that library from within QEMU.
  */
 
-#include "qemu/osdep.h"
-#include "hw/irq.h"
-#include "migration/vmstate.h"
-#include "qemu/log.h"
-#include "qemu/module.h"
+#include "apple-gfx.h"
 #include "trace.h"
-#include "hw/sysbus.h"
-#include "hw/pci/msi.h"
-#include "crypto/hash.h"
-#include "sysemu/cpus.h"
+#include "qemu/main-loop.h"
 #include "ui/console.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
@@ -29,72 +22,17 @@
 #include <mach/mach_vm.h>
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
 
-#define TYPE_APPLE_GFX          "apple-gfx"
-
 static const PGDisplayCoord_t apple_gfx_modes[] = {
     { .x = 1440, .y = 1080 },
     { .x = 1280, .y = 1024 },
 };
 
-/*
- * ParavirtualizedGraphics.Framework only ships header files for the x86
- * variant which does not include IOSFC descriptors and host devices. We add
- * their definitions here so that we can also work with the ARM version.
- */
-typedef bool(^IOSFCRaiseInterrupt)(uint32_t vector);
-typedef bool(^IOSFCUnmapMemory)(void *a, void *b, void *c, void *d, void *e, void *f);
-typedef bool(^IOSFCMapMemory)(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f);
-
-@interface PGDeviceDescriptor (IOSurfaceMapper)
-@property (readwrite, nonatomic) bool usingIOSurfaceMapper;
-@end
-
-@interface PGIOSurfaceHostDeviceDescriptor : NSObject
--(PGIOSurfaceHostDeviceDescriptor *)init;
-@property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory mapMemory;
-@property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory unmapMemory;
-@property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt raiseInterrupt;
-@end
-
-@interface PGIOSurfaceHostDevice : NSObject
--(instancetype)initWithDescriptor:(PGIOSurfaceHostDeviceDescriptor *) desc;
--(uint32_t)mmioReadAtOffset:(size_t) offset;
--(void)mmioWriteAtOffset:(size_t) offset value:(uint32_t)value;
-@end
-
 typedef struct PGTask_s { // Name matches forward declaration in PG header
     QTAILQ_ENTRY(PGTask_s) node;
     mach_vm_address_t address;
     uint64_t len;
 } AppleGFXTask;
 
-typedef QTAILQ_HEAD(, PGTask_s) AppleGFXTaskList;
-
-typedef struct AppleGFXState {
-    SysBusDevice parent_obj;
-
-    qemu_irq irq_gfx;
-    qemu_irq irq_iosfc;
-    MemoryRegion iomem_gfx;
-    MemoryRegion iomem_iosfc;
-    id<PGDevice> pgdev;
-    id<PGDisplay> pgdisp;
-    PGIOSurfaceHostDevice *pgiosfc;
-    AppleGFXTaskList tasks;
-    QemuConsole *con;
-    void *vram;
-    id<MTLDevice> mtl;
-    id<MTLTexture> texture;
-    bool handles_frames;
-    bool new_frame;
-    bool cursor_show;
-    DisplaySurface *surface;
-    QEMUCursor *cursor;
-} AppleGFXState;
-
-
-OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXState, APPLE_GFX)
-
 static Error *apple_gfx_mig_blocker;
 
 static AppleGFXTask *apple_gfx_new_task(AppleGFXState *s, uint64_t len)
@@ -154,43 +92,6 @@ static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val, unsigned
     },
 };
 
-static uint64_t apple_iosfc_read(void *opaque, hwaddr offset, unsigned size)
-{
-    AppleGFXState *s = opaque;
-    uint64_t res = 0;
-
-    bql_unlock();
-    res = [s->pgiosfc mmioReadAtOffset:offset];
-    bql_lock();
-
-    trace_apple_iosfc_read(offset, res);
-
-    return res;
-}
-
-static void apple_iosfc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
-{
-    AppleGFXState *s = opaque;
-
-    trace_apple_iosfc_write(offset, val);
-
-    [s->pgiosfc mmioWriteAtOffset:offset value:val];
-}
-
-static const MemoryRegionOps apple_iosfc_ops = {
-    .read = apple_iosfc_read,
-    .write = apple_iosfc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 8,
-    },
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 8,
-    },
-};
-
 static void apple_gfx_fb_update_display(void *opaque)
 {
     AppleGFXState *s = opaque;
@@ -325,29 +226,18 @@ static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
 
 static void create_fb(AppleGFXState *s)
 {
-
     s->con = graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
     set_mode(s, 1440, 1080);
 
     s->cursor_show = true;
 }
 
-static void apple_gfx_reset(DeviceState *d)
+void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
 {
-}
-
-static void apple_gfx_init(Object *obj)
-{
-    AppleGFXState *s = APPLE_GFX(obj);
     Error *local_err = NULL;
     int r;
 
-    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s, TYPE_APPLE_GFX, 0x4000);
-    memory_region_init_io(&s->iomem_iosfc, obj, &apple_iosfc_ops, s, TYPE_APPLE_GFX, 0x10000);
-    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem_gfx);
-    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem_iosfc);
-    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_gfx);
-    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_iosfc);
+    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s, obj_name, 0x4000);
 
     /* TODO: PVG framework supports serialising device state: integrate it! */
     if (apple_gfx_mig_blocker == NULL) {
@@ -514,101 +404,24 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
     return mode_array;
 }
 
-static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device(AppleGFXState *s)
-{
-    PGIOSurfaceHostDeviceDescriptor *iosfc_desc = [PGIOSurfaceHostDeviceDescriptor new];
-    PGIOSurfaceHostDevice *iosfc_host_dev = nil;
-
-    iosfc_desc.mapMemory = ^(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
-        trace_apple_iosfc_map_memory(phys, len, ro, va, e, f);
-        MemoryRegion *tmp_mr;
-        *va = gpa2hva(&tmp_mr, phys, len, NULL);
-        return (bool)true;
-    };
-
-    iosfc_desc.unmapMemory = ^(void *a, void *b, void *c, void *d, void *e, void *f) {
-        trace_apple_iosfc_unmap_memory(a, b, c, d, e, f);
-        return (bool)true;
-    };
-
-    iosfc_desc.raiseInterrupt = ^(uint32_t vector) {
-        trace_apple_iosfc_raise_irq(vector);
-        bool locked = bql_locked();
-        if (!locked) {
-            bql_lock();
-        }
-        qemu_irq_pulse(s->irq_iosfc);
-        if (!locked) {
-            bql_unlock();
-        }
-        return (bool)true;
-    };
-
-    iosfc_host_dev = [[PGIOSurfaceHostDevice alloc] initWithDescriptor:iosfc_desc];
-    [iosfc_desc release];
-    return iosfc_host_dev;
-}
-
-static void apple_gfx_realize(DeviceState *dev, Error **errp)
+void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
 {
-    @autoreleasepool {
-        AppleGFXState *s = APPLE_GFX(dev);
-        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
-        PGDisplayDescriptor *disp_desc = nil;
+    PGDisplayDescriptor *disp_desc = nil;
 
-        QTAILQ_INIT(&s->tasks);
-        s->mtl = MTLCreateSystemDefaultDevice();
+    QTAILQ_INIT(&s->tasks);
+    s->mtl = MTLCreateSystemDefaultDevice();
 
-        desc.device = s->mtl;
-        desc.usingIOSurfaceMapper = true;
+    desc.device = s->mtl;
 
-        apple_gfx_register_task_mapping_handlers(s, desc);
+    apple_gfx_register_task_mapping_handlers(s, desc);
 
-        desc.raiseInterrupt = ^(uint32_t vector) {
-            bool locked;
+    s->pgdev = PGNewDeviceWithDescriptor(desc);
 
-            trace_apple_gfx_raise_irq(vector);
-            locked = bql_locked();
-            if (!locked) {
-                bql_lock();
-            }
-            qemu_irq_pulse(s->irq_gfx);
-            if (!locked) {
-                bql_unlock();
-            }
-        };
+    disp_desc = apple_gfx_prepare_display_handlers(s);
+    s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
+                                              port:0 serialNum:1234];
+    [disp_desc release];
+    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
 
-        s->pgdev = PGNewDeviceWithDescriptor(desc);
-        [desc release];
-        desc = nil;
-
-        disp_desc = apple_gfx_prepare_display_handlers(s);
-        s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc port:0 serialNum:1234];
-        [disp_desc release];
-        s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
-
-        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
-
-        create_fb(s);
-    }
+    create_fb(s);
 }
-
-static void apple_gfx_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->reset = apple_gfx_reset;
-    dc->realize = apple_gfx_realize;
-}
-
-static TypeInfo apple_gfx_types[] = {
-    {
-        .name          = TYPE_APPLE_GFX,
-        .parent        = TYPE_SYS_BUS_DEVICE,
-        .instance_size = sizeof(AppleGFXState),
-        .class_init    = apple_gfx_class_init,
-        .instance_init = apple_gfx_init,
-    }
-};
-
-DEFINE_TYPES(apple_gfx_types)
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 713786bd07..70d855749c 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -65,7 +65,8 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
 
 system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
 
-system_ss.add(when: 'CONFIG_MAC_PVG', if_true: [files('apple-gfx.m'), pvg, metal])
+system_ss.add(when: 'CONFIG_MAC_PVG',         if_true: [files('apple-gfx.m'), pvg, metal])
+system_ss.add(when: 'CONFIG_MAC_PVG_VMAPPLE', if_true: [files('apple-gfx-vmapple.m'), pvg, metal])
 
 if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
   virtio_gpu_ss = ss.source_set()
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 4b897554c9..e35582d659 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -208,6 +208,8 @@ apple_gfx_mode_change(uint64_t x, uint64_t y) "x=%"PRId64" y=%"PRId64
 apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) "bpp=%d width=%"PRId64" height=0x%"PRId64
 apple_gfx_cursor_show(uint32_t show) "show=%d"
 apple_gfx_cursor_move(void) ""
+
+# apple-gfx-vmapple.m
 apple_iosfc_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
 apple_iosfc_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
 apple_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, void *va, void *e, void *f) "phys=0x%"PRIx64" len=0x%"PRIx64" ro=%d va=%p e=%p f=%p"
-- 
2.39.3 (Apple Git-146)


