Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9CBCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6E9F-0004rG-Ej; Tue, 07 Oct 2025 16:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6E98-0004qO-67
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:18:54 -0400
Received: from p-east2-cluster4-host4-snip4-1.eps.apple.com ([57.103.78.142]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6E96-0007P6-7V
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:18:53 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 0C7BA1800150; Tue,  7 Oct 2025 20:18:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ntxelPjhpVZB8GftH09msxrtN1JthPRbSyeSqaae2eM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=L3i63lHEIRJwwe0etogSfRkICTQTujh+Lspe0e8y9sheCS1hDLABnYyzTkGFxh6bAPrKB6XoZjJwP5jHQyvttNY+EfFNZwrOE78Lkn2jHMyuRFdfbc9rhgLqFAzgp0t35yjqZgvNXcEySQIQOPIwx5AkeAsIvrfZZGLTkElxDpQObS5cDfgglBugX9QYyUK+MxJv3rBPVlFvgNUjO61+5jf5O4x07TrXnudImG/sYiEAmR32Ng7KXTiIuJ6obBoemjA6WWW5rijlPTwGdxfoZq2zNSilfV8G7abSvmtFKV6v3dgPfSBtJGN+Tg6p+Tu8HxPZszJ+XK9Lq6lusKa9RA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 1207618016EC; Tue,  7 Oct 2025 20:18:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC 3/4] vmapple: apple-gfx: make it work on the latest macOS release
Date: Tue,  7 Oct 2025 22:18:36 +0200
Message-ID: <20251007201837.28992-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251007201837.28992-1-mohamed@unpredictable.fr>
References: <20251007201837.28992-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OzvW8eRJQ-C1I683m4UAryZe6Cwihwyd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE1OSBTYWx0ZWRfX0KHVN4l6IeQI
 ZM9JT3xk7rFDyT4XXP586NOE2LUHJEFU2A6slnhAC+tlt2TrH5BxcBR4kXT4zKynfNH+z2O5PTm
 GgKzPzT1aP09VJI/Wyr6/LSWwPX04xtXgiqA1OarsFyAz/rFv4z3vRER5hzJ4OdVLf5wIDcyo46
 lXYY38CVFVj+tKjwoWAKIOQZEypn6V9KbFfutaY3HdyrZ6393fpC4pb+Wz8+YJ07ccwrJt5mNlQ
 8YK38KcavEIGje0kmd8Vt82zvUflyLJzzVozJb9ObaBfmTEs5PqeDcRgMkk9qq6d1B8wTRkFc=
X-Proofpoint-GUID: OzvW8eRJQ-C1I683m4UAryZe6Cwihwyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0
 bulkscore=0 clxscore=1030 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510070159
Received-SPF: pass client-ip=57.103.78.142;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Follow changes in memory management, and enable process isolation for a sandboxed GPU process when on a new OS.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/display/apple-gfx-mmio.m | 56 +++++++++++++++++++++++++++----------
 hw/display/apple-gfx.h      | 13 +++++++++
 hw/display/apple-gfx.m      | 42 +++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 16 deletions(-)

diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index b0b6e2993e..728441d490 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -19,6 +19,7 @@
 #include "hw/irq.h"
 #include "apple-gfx.h"
 #include "trace.h"
+#include "system/address-spaces.h"
 
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
 
@@ -34,14 +35,25 @@
 typedef bool(^IOSFCMapMemory)(uint64_t phys, uint64_t len, bool ro, void **va,
                               void *, void *);
 
+@interface PGMemoryMapDescriptor : NSObject
+-(void)addRange:(struct PGGuestPhysicalRange_s) range;
+@end
+
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
 
@@ -182,20 +194,28 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
     PGIOSurfaceHostDeviceDescriptor *iosfc_desc =
         [PGIOSurfaceHostDeviceDescriptor new];
     PGIOSurfaceHostDevice *iosfc_host_dev;
-
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
+    PGMemoryMapDescriptor* memoryMapDescriptor = [PGMemoryMapDescriptor new];
+
+    if (@available(macOS 15.4, *)) {
+        FlatView* fv = address_space_to_flatview(&address_space_memory);
+        flatview_for_each_range(fv, apple_gfx_register_memory_cb, memoryMapDescriptor);
+        iosfc_desc.mmioLength = 0x10000;
+        iosfc_desc.memoryMapDescriptor = memoryMapDescriptor;
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
@@ -223,13 +243,19 @@ static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)
         };
 
         desc.usingIOSurfaceMapper = true;
-        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
+        desc.enableArgumentBuffers = true;
+        // Process isolation needs to go through PGMemoryMapDescriptor
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
index a8b1d1efc0..0f7cf33adf 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -23,6 +23,13 @@
 @protocol MTLTexture;
 @protocol MTLCommandQueue;
 
+typedef struct PGGuestPhysicalRange_s
+{
+    uint64_t physicalAddress;
+    uint64_t physicalLength;
+    void *hostAddress;
+} PGGuestPhysicalRange_t;
+
 typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
 
 typedef struct AppleGFXDisplayMode {
@@ -68,6 +75,12 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
                                        uint64_t length, bool read_only,
                                        MemoryRegion **mapping_in_region);
 
+bool apple_gfx_register_memory_cb(Int128 start,
+                            Int128 len,
+                            const MemoryRegion *mr,
+                            hwaddr offset_in_region,
+                            void *opaque);
+
 extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
 
 #endif
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 174d56ae05..238b227176 100644
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
@@ -596,6 +597,41 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
     /* TODO: PVG framework supports serialising device state: integrate it! */
 }
 
+@interface PGMemoryMapDescriptor : NSObject
+-(void)addRange:(struct PGGuestPhysicalRange_s) range;
+@end
+
+@interface PGDeviceDescriptor (IOSurfaceMapper)
+@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
+@end
+
+bool apple_gfx_register_memory_cb(Int128 start,
+                            Int128 len,
+                            const MemoryRegion *mr,
+                            hwaddr offset_in_region,
+                            void *opaque) {
+    PGGuestPhysicalRange_t range;
+    PGMemoryMapDescriptor* memoryMapDescriptor = opaque;
+    if (mr->ram) {
+        range.physicalAddress = start;
+        range.physicalLength = len;
+        range.hostAddress = memory_region_get_ram_ptr(mr);
+        [memoryMapDescriptor addRange:range];
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
 static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
                                                      PGDeviceDescriptor *desc)
 {
@@ -763,7 +799,11 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
 
     desc.device = s->mtl;
 
-    apple_gfx_register_task_mapping_handlers(s, desc);
+    if (@available(macOS 15.4, *)) {
+        apple_gfx_register_memory(s, desc);
+    } else {
+        apple_gfx_register_task_mapping_handlers(s, desc);
+    }
 
     s->cursor_show = true;
 
-- 
2.50.1 (Apple Git-155)


