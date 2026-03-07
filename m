Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753EBFC9ECB
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 04:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyjYj-0006ii-9N; Fri, 06 Mar 2026 23:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyjYZ-0006bZ-Hr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:46:27 -0500
Received: from p-west3-cluster5-host1-snip4-2.eps.apple.com ([57.103.72.65]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyjYW-0004eB-4M
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:46:25 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPS id
 198A5180010E; Sat,  7 Mar 2026 04:46:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772858782; x=1775450782;
 bh=ZJVcSZc2jz1RmlBIDBoh7aztxEppw3g/w6m9qrnvZME=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Q5j3UWPBbs7VsVfJx2jS2jYTI/yFkZG35Qq4RUU6NntbIggDrlhV7mwrqDPjMTwZqpfiiyNttZOu+Paher0iaYkVm7kYV4rSuqvla1ZrhmfrVQucdACiqRKipjWLl1gdltl9f8m25Kon8gtBINR5cpBddgADXuIWtI5zB3Fsirtv7VCtk9MG+JnWI5jBaZwS17lfE6R7AFnOTWpkl12muhrhy+r63kmdkfGyL6ZgrNoTvSL58kTdtjH0rLKpSW+aQQxHtLuHjjZeMTbEHqBizdQi3LABHmcmTk/p93ynxwyelIWDW9XpLR0Q91PSL+kkiFPSyIzGsvngiKQ09x0P6Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPSA id
 253EA18000A7; Sat,  7 Mar 2026 04:46:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 2/4] vmapple: apple-gfx: make it work on the latest macOS
 release
Date: Sat,  7 Mar 2026 05:46:06 +0100
Message-ID: <20260307044608.25486-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307044608.25486-1-mohamed@unpredictable.fr>
References: <20260307044608.25486-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=M4pA6iws c=1 sm=1 tr=0 ts=69abad9d
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=XaNHVGzJZ3ayr3Wv:21
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=2lQx5wYd1WNrG3klcQkA:9
X-Proofpoint-GUID: 7bnagjSh0IGKi_pcSxEwtxbmvn94X3Xc
X-Proofpoint-ORIG-GUID: 7bnagjSh0IGKi_pcSxEwtxbmvn94X3Xc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA0MCBTYWx0ZWRfXwTFq53vsVQyZ
 XSFM1Sik8jSj13ioXPyZ9/rkXDeRsK7mWsVpBbKYnYzb2DUUzSidEMCvYh0zbEeudIIV8HpknW2
 IxbQb73ENPzZhSaCGf0ybVUann/8jhSGdGF+KVwAZg3TxwbkaVosUivRkGigcdHFM/WbEhBrpkM
 SbIZMseQIGbRPz24r+g8ytO8nS++G4srXdfSWhQEI7K+HDP1aVImSOa5vWpIDJSNM63BBc55Js0
 +R4w0UTPMe0BMIXjaqXvUTSYsq5NOy2y/ptpKx8cNriZpKwCOSqIVjFECBLzlI/pH+ZJfXoxlxd
 DnU7SZeuYnPjX+KNUOOR5UTb8k/L0zcUM1bVu6hdJntMUDdx6oVd1ErrryjCw8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1030
 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070040
X-JNJ: AAAAAAABUaXafqnRoceutUA+TZcn1W7TZ/r3Es9kQQCKrfPv7Tjl80yKaYk7scZ2+GhXfRRAsRcfON2ZDNervZPP+0PwGC3hM6RhpRu6zYOehf8GNZzPYWtA/HcJJKisYaNCbFsnR4B20UsnTLhz/9wvx2Dc2ArLBOkNkK7jGQz2MmtELDOWbcSsGcaCHkjIOaLxkv0QQe1S45tGQ+9Q86ML9lcZ7/HnukESzLSWdBv0HmXmDAVAz2dF+KiLYvI5qxZO4yqqV9NCZIpWyxOZdvHAA3f0f+4bYXSyVlLdb0f7q8tn//ZXytF2r0QugMlCP3qcQ7rNlXRm4MSicLLgXopdjkQ4IyzADSZ6EjveMdHYMhtDLRJ6/hat8AxvTkQn+oKswH3rma17nz37kDrOZfjUAcVkQQNIGI0Ey0YevukMehvI8A3l/R5141AHSYDgoT5846IFwNcrtwIqSB6N1DFSIw+eL54kQJDOKJVLWAPs+2ctMnD+NjHfTjTx8hOAAD1gRZij++gV0tSJ58/UcW7WG9bFrbos5w0kWuTEG7JEsDtIXbgQmeYTedgvpjJhaQrlZ/hPj/3fFEgcRJLYZXHi3q0KjvXyoqsHQeqRvpC2vrNhKGCuMXKEc8zBK2MpyradTPMJziMtmsrguc62C9mc+TyfVkZi5gh+7Xom0ZwA1aO90o5Qof9V+qzs8LH3dRRnQavuhrZcbSlmKPHDNaZfnZ6wfJqpBt5hkDyWsVwZuvxCTmDfMrFuekD5SMHmtsg+XmeAiYMGwbf+wgml6uRpSw==
Received-SPF: pass client-ip=57.103.72.65;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 hw/display/apple-gfx-mmio.m | 59 ++++++++++++++++++++++++++++---------
 hw/display/apple-gfx.h      | 16 ++++++++++
 hw/display/apple-gfx.m      | 42 +++++++++++++++++++++++++-
 3 files changed, 102 insertions(+), 15 deletions(-)

diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 58beaadd1f..cc1f8cfcad 100644
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
@@ -223,13 +244,23 @@ static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)
         };
 
         desc.usingIOSurfaceMapper = true;
-        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
+        desc.enableArgumentBuffers = true;
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
index e0a765fcb1..24584bca5b 100644
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
@@ -596,6 +597,36 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
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
+        memory_region_ref(mr);
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
@@ -763,7 +794,16 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
 
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
+        apple_gfx_register_task_mapping_handlers(s, desc);
+    }
 
     s->cursor_show = true;
 
-- 
2.50.1 (Apple Git-155)


