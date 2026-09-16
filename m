Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5F3C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mRo-0008BG-SW; Wed, 16 Sep 2026 06:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRg-00087o-Fe
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:54 -0400
Received: from qs-2003c-snip6-11.eps.apple.com ([2a01:b747:3006:204::21]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRa-0005EP-TE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:50 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id
 3641418009FE; Wed, 16 Sep 2026 10:00:42 +0000 (UTC)
X-ICL-RepId: 01a0a9a9-5595-7a0e-b009-edd138a9faa8
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0IShMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLSAFbB1IDRghIA10FWhxHCkABWBpdHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789552845; x=1792144845;
 bh=X43fhFYPtF0mjqJMmFhMIodO6U95ZjocBPYULWRQocY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=QRWFJb+ppjsbu/cxRq+foxEmywxyHAqZqMKo4D61ygGIqTrb75iRyjaS5YfUg6O5PPKz1mx9CVKj2Ao+Jh9OrMIvns5FxOZWLTzDdlxipldoJWta1RG7QmlvikVS8hde/iM5n86elXjmMCgR7s6xCOepIB+NYffFXoODYn7Zwov8BD49zcQsQM8JO79f6vMNE/UFixGyDVcpS91J86kxlob0bzi0JvA4wGurGtI4p0KSeLLcgRqaGY/jtq7aBubSIZIiY0iqwOJQx6QTNOFGNX6ovX9y2+EyPGsmtw9Qrbdz++EICTbWvr2Po9kr4a640U2hVHwEA1rToI93RSEsZQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id
 190DC18000BF; Wed, 16 Sep 2026 10:00:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v8 05/10] vmapple: apple-gfx: make it work on the latest
 macOS release
Date: Wed, 16 Sep 2026 12:00:13 +0200
Message-ID: <20260916100021.73825-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916100021.73825-1-mohamed@unpredictable.fr>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfX3l0axmXKeZSI
 Dx1nv3vJ5B3OokI4gdjv2TZUshQY+flVAagHvRhHMafLhoMlSzkdOVwx+mK8FJ+pFCTubC6Su2P
 Fl0loInVUDieW/KO0nJZd46haf7xUnP9Wnij43acigO8hpvh+YIVzPsD/OaG9KKESw1VibCIhX9
 112Lf7GD9Xhi7b+99oJG5jtvbyXWk7ky2Ll4yjGicIznlhvQ6yHb+ZaJGEOuaI4EmcSjC0M9hqo
 f0Rls0VPot5SwD91IGxFLarQ2avkyA+EmrW2L74c6EjnJEJWiireQXu87NmqlAQ8aCriZH2+dk3
 /nyuh/L+ZUP86Y6wDljVMMOl99m8XOTnnuwDjK7H3d338vYIPykQYmK/Is9hPI=
X-Authority-Info-Out: v=2.4 cv=f51FxeyM c=1 sm=1 tr=0 ts=6aaa68cb
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=XaNHVGzJZ3ayr3Wv:21 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=_6z4mGRrJ5MUOnpCZZoA:9
X-Proofpoint-GUID: 2XJXUsEPn1Kp8y9Dd8iWsHjbOmsgSWfd
X-Proofpoint-ORIG-GUID: 2XJXUsEPn1Kp8y9Dd8iWsHjbOmsgSWfd
X-JNJ: AAAAAAAB3BVlHVz2hRU3b06Ye63weOhbJ+o3srlVAZsbBAeSccthi9IYotdfkj5uxuZmXIWemwXKA2j17XAmeXcAv49qRRiEGhuEVTR/ZC7lHl1ce6dHskjV0wSyJztt0HAHAGyEpoSXa37Gzk7NEyDuZ0vjxhDCjYPmEk1kQXXowL2Wv9GBfy0Krk4/LhN7db2jMERGRnh1sYsJDx08JiocmvhOXEzLD99vJC/LxZxCoW1a7HRiSNqvV5pxzQtKZYHdErNsHwTQZZ8f7NnnPOR87MZ1iigsypfYj9l5MOgVPcntzAVRlVLQcAO9xSJM+xD8NSiYkKfcNMLTZwiQvT6USslYJHKTdOvOdlSqkGV30gz5u3L61LOh2q2S6B9EchRvoYAhBuJSVQwcRI+AeSzil/SPJ0nntPkxzBloPtB6LBdpCtUhsGK5uJGWILkd2n2pVBUXzIbQZiQ8anqb5eMzyHBxRl1u15l+4+8pybXuv28+n63gjpZjdy3qofrRthgxe3nk7QskQ2COSQy3ESDY0rTKD5Qodf73V18REyT243f+p+RQvhdqjnhQB6aDrK2QqII0dvaiiUzSheG0kGa4ePHGQBNa/MN1kUdbLcNQSJXj1Sv7Seziu070m/aUllkQPn2hjeHHcQ643ERSzU7UKP1OMxrhJfnVbTXwt7xtH2EObnHZk4auWNVBK/jvYdvdRiQB5RK/cz29DV1Te4zIfC4LdCGlAETO5qZLR2opozhRxc5RipVToy2tsLh2Jumzwo9jMqp1Nfbt+dLXSmXKiCIcKo2HmLnwuxrXiC6G3cYvD2awcQb9Cgll0JODuwwfu6oBiZR8PXpYY1L+1LZBtfg9kthLgz/YJucf1QrVB+NvtsE=
Received-SPF: pass client-ip=2a01:b747:3006:204::21;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Follow changes in memory management introduced on macOS 15.4.

The legacy memory management API has been removed for the IOSurface mapper on that macOS version.

Also enable process isolation for a sandboxed GPU process when on a new OS.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/display/apple-gfx-mmio.m | 58 ++++++++++++++++++------
 hw/display/apple-gfx.h      | 16 +++++++
 hw/display/apple-gfx.m      | 90 ++++++++++++++++++++++++++++++++-----
 3 files changed, 138 insertions(+), 26 deletions(-)

diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 58beaadd1f..19e2d38a1e 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -19,6 +19,7 @@
 #include "hw/core/irq.h"
 #include "apple-gfx.h"
 #include "trace.h"
+#include "system/address-spaces.h"
 
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
 
@@ -36,12 +37,19 @@ typedef bool(^IOSFCMapMemory)(uint64_t phys, uint64_t len, bool ro, void **va,
 
 @interface PGDeviceDescriptor (IOSurfaceMapper)
 @property (readwrite, nonatomic) bool usingIOSurfaceMapper;
+@property (readwrite, nonatomic) bool enableArgumentBuffers;
+@property (readwrite, nonatomic) bool enableProcessIsolation;
+@property (readwrite, nonatomic) bool enableProtectedContent;
+
+@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
 @end
 
 @interface PGIOSurfaceHostDeviceDescriptor : NSObject
 -(PGIOSurfaceHostDeviceDescriptor *)init;
 @property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory mapMemory;
 @property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory unmapMemory;
+@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
+@property (readwrite, nonatomic) unsigned long long mmioLength;
 @property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt raiseInterrupt;
 @end
 
@@ -183,19 +191,32 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
         [PGIOSurfaceHostDeviceDescriptor new];
     PGIOSurfaceHostDevice *iosfc_host_dev;
 
-    iosfc_desc.mapMemory =
-        ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
-            *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
-
-            trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
-
-            return *va != NULL;
-        };
-
-    iosfc_desc.unmapMemory =
-        ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
-            return apple_gfx_mmio_unmap_surface_memory(va);
-        };
+    /*
+     * The legacy memory management API is no longer present
+     * for the IOSurface mapper as of macOS 15.4.
+     */
+    if (@available(macOS 15.4, *)) {
+        PGMemoryMapDescriptor *memory_map_descriptor = [PGMemoryMapDescriptor new];
+        FlatView* fv = address_space_to_flatview(&address_space_memory);
+        flatview_for_each_range(fv, apple_gfx_register_memory_cb, memory_map_descriptor);
+        /* the device model defines this as a single-page MMIO region, hence 16KB */
+        iosfc_desc.mmioLength = 0x10000;
+        iosfc_desc.memoryMapDescriptor = memory_map_descriptor;
+    } else {
+        iosfc_desc.mapMemory =
+            ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
+                *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
+
+                trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
+
+                return *va != NULL;
+            };
+
+        iosfc_desc.unmapMemory =
+            ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
+                return apple_gfx_mmio_unmap_surface_memory(va);
+            };
+    }
 
     iosfc_desc.raiseInterrupt = ^bool(uint32_t vector) {
         trace_apple_gfx_iosfc_raise_irq(vector);
@@ -223,13 +244,22 @@ static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)
         };
 
         desc.usingIOSurfaceMapper = true;
-        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
+        /* 
+         * Process isolation needs PGMemoryMapDescriptor instead of
+         * the legacy memory management interface present in releases
+         * older than macOS 15.4.
+         */
+        if (@available(macOS 15.4, *)) {
+            desc.enableProcessIsolation = true;
+        }
 
         if (!apple_gfx_common_realize(&s->common, dev, desc, errp)) {
             [s->pgiosfc release];
             s->pgiosfc = nil;
         }
 
+        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
+
         [desc release];
         desc = nil;
     }
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 3197bd853d..384aee0c5f 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -12,6 +12,7 @@
 #include "system/memory.h"
 #include "hw/core/qdev-properties.h"
 #include "ui/surface.h"
+#include "objc/NSObject.h"
 
 #define TYPE_APPLE_GFX_MMIO         "apple-gfx-mmio"
 #define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
@@ -23,6 +24,17 @@
 @protocol MTLTexture;
 @protocol MTLCommandQueue;
 
+typedef struct PGGuestPhysicalRange_s
+{
+    uint64_t physicalAddress;
+    uint64_t physicalLength;
+    void *hostAddress;
+} PGGuestPhysicalRange_t;
+
+@interface PGMemoryMapDescriptor : NSObject
+-(void)addRange:(PGGuestPhysicalRange_t) range;
+@end
+
 typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
 
 typedef struct AppleGFXDisplayMode {
@@ -68,6 +80,10 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
                                        uint64_t length, bool read_only,
                                        MemoryRegion **mapping_in_region);
 
+bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
+                                  const MemoryRegion *mr,
+                                  hwaddr offset_in_region, void *opaque);
+
 extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
 
 #endif
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index be0061b9db..4ef8f6dbf3 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -21,6 +21,7 @@
 #include "system/address-spaces.h"
 #include "system/dma.h"
 #include "migration/blocker.h"
+#include "system/memory.h"
 #include "ui/console.h"
 #include "apple-gfx.h"
 #include "trace.h"
@@ -79,6 +80,7 @@ static dispatch_queue_t get_background_queue(void)
     GPtrArray *mapped_regions;
 };
 
+API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, 27.0)) 
 static PGTask_t *apple_gfx_new_task(AppleGFXState *s, uint64_t len)
 {
     mach_vm_address_t task_mem;
@@ -102,6 +104,7 @@ static dispatch_queue_t get_background_queue(void)
     return task;
 }
 
+API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, 27.0))
 static void apple_gfx_destroy_task(AppleGFXState *s, PGTask_t *task)
 {
     GPtrArray *regions = task->mapped_regions;
@@ -151,6 +154,7 @@ static void apple_gfx_destroy_task(AppleGFXState *s, PGTask_t *task)
     return host_ptr;
 }
 
+API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, 27.0))
 static bool apple_gfx_task_map_memory(AppleGFXState *s, PGTask_t *task,
                                       uint64_t virtual_offset,
                                       PGPhysicalMemoryRange_t *ranges,
@@ -207,6 +211,7 @@ static bool apple_gfx_task_map_memory(AppleGFXState *s, PGTask_t *task,
     return success;
 }
 
+API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, 27.0))
 static void apple_gfx_task_unmap_memory(AppleGFXState *s, PGTask_t *task,
                                         uint64_t virtual_offset, uint64_t length)
 {
@@ -596,6 +601,36 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
     /* TODO: PVG framework supports serialising device state: integrate it! */
 }
 
+@interface PGDeviceDescriptor (IOSurfaceMapper)
+@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
+@end
+
+bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
+                                  const MemoryRegion *mr,
+                                  hwaddr offset_in_region, void *opaque) {
+    PGGuestPhysicalRange_t range;
+    PGMemoryMapDescriptor *memory_map_descriptor = opaque;
+    if (memory_access_is_direct(mr, true, MEMTXATTRS_UNSPECIFIED)) {
+        range.physicalAddress = start;
+        range.physicalLength = len;
+        range.hostAddress = memory_region_get_ram_ptr(mr);
+        [memory_map_descriptor addRange:range];
+    }
+    return false;
+}
+
+static void apple_gfx_register_memory(AppleGFXState *s,
+                                                     PGDeviceDescriptor *desc)
+{
+    PGMemoryMapDescriptor* memoryMapDescriptor = [PGMemoryMapDescriptor new];
+
+    FlatView* fv = address_space_to_flatview(&address_space_memory);
+    flatview_for_each_range(fv, apple_gfx_register_memory_cb, memoryMapDescriptor);
+
+    desc.memoryMapDescriptor = memoryMapDescriptor;
+}
+
+API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, 27.0))
 static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
                                                      PGDeviceDescriptor *desc)
 {
@@ -667,16 +702,25 @@ static void new_frame_handler_bh(void *opaque)
         BQL_LOCK_GUARD();
         set_mode(s, sizeInPixels.x, sizeInPixels.y);
     };
-    disp_desc.cursorGlyphHandler = ^(NSBitmapImageRep *glyph,
-                                     PGDisplayCoord_t hotspot) {
-        AppleGFXSetCursorGlyphJob *job = g_malloc0(sizeof(*job));
-        job->s = s;
-        job->glyph = glyph;
-        job->hotspot = hotspot;
-        [glyph retain];
-        aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                                set_cursor_glyph, job);
-    };
+
+    if (@available(macOS 27.0, *)) {
+
+    } else {
+#ifndef __MAC_27_0
+        disp_desc.cursorGlyphHandler = ^(NSBitmapImageRep *glyph,
+                                         PGDisplayCoord_t hotspot) {
+            AppleGFXSetCursorGlyphJob *job = g_malloc0(sizeof(*job));
+            job->s = s;
+            job->glyph = glyph;
+            job->hotspot = hotspot;
+            [glyph retain];
+            aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                    set_cursor_glyph, job);
+        };
+#else
+        abort();
+#endif
+    }
     disp_desc.cursorShowHandler = ^(BOOL show) {
         trace_apple_gfx_cursor_show(show);
         qatomic_set(&s->cursor_show, show);
@@ -763,11 +807,33 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
 
     desc.device = s->mtl;
 
-    apple_gfx_register_task_mapping_handlers(s, desc);
+    /* 
+     * The legacy memory management interface doesn't allow for
+     * vGPU sandboxing. As such, always use the new interface
+     * on macOS 15.4 onwards. 
+     */
+    if (@available(macOS 15.4, *)) {
+        apple_gfx_register_memory(s, desc);
+    } else {
+#ifndef __MAC_27_0
+        apple_gfx_register_task_mapping_handlers(s, desc);
+#else
+        abort();
+#endif
+    }
 
     s->cursor_show = true;
 
-    s->pgdev = PGNewDeviceWithDescriptor(desc);
+    if (@available(macOS 15.2, *)) {
+        s->pgdev = PGCreateDeviceWithDescriptor(desc);
+    }
+    else {
+#ifndef __MAC_27_0
+        s->pgdev = PGNewDeviceWithDescriptor(desc);
+#else
+        abort();
+#endif
+    }
 
     disp_desc = apple_gfx_prepare_display_descriptor(s);
     /*
-- 
2.54.0 (Apple Git-157)


