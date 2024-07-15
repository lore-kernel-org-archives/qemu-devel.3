Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65613C3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2T5-0003L0-S9; Wed, 17 Jul 2024 07:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SV-0000xX-EE
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:36 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SR-0006zN-5X
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:30 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 269E0379628; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 12/26] hw/display/apple-gfx: Task memory mapping cleanup
Date: Mon, 15 Jul 2024 23:06:51 +0200
Message-Id: <20240715210705.32365-13-phil@philjordan.eu>
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

macOS' PV Graphics framework first requests a contiguous host-virtual
address range ("PGTask"), and subsequently requests guest-physical
memory ranges to be mapped into subranges of the tasks.

It is easier (and less threading error prone) to use the host's Mach
memory subsystem on the host to perform this subsequent remapping,
rather than tracking the mapping state directly.

Additionally, there is absolutely no need to pick a magic number
for a virtual memory base address - we can simply allocate some
appropriate virtual memory pages and let the OS choose an available
address range.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m  | 106 +++++++++++++++-------------------------
 hw/display/trace-events |   2 +-
 2 files changed, 40 insertions(+), 68 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 6537e32806..a23f731ddc 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -26,6 +26,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
+#include <mach/mach_vm.h>
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
 
 #define TYPE_APPLE_GFX          "apple-gfx"
@@ -35,13 +36,6 @@
     { .x = 1280, .y = 1024 },
 };
 
-/*
- * We have to map PVG memory into our address space. Use the one below
- * as base start address. In normal linker setups it points to a free
- * memory range.
- */
-#define APPLE_GFX_BASE_VA ((void *)(uintptr_t)0x500000000000UL)
-
 /*
  * ParavirtualizedGraphics.Framework only ships header files for the x86
  * variant which does not include IOSFC descriptors and host devices. We add
@@ -68,18 +62,9 @@ -(uint32_t)mmioReadAtOffset:(size_t) offset;
 -(void)mmioWriteAtOffset:(size_t) offset value:(uint32_t)value;
 @end
 
-typedef struct AppleGFXMR {
-    QTAILQ_ENTRY(AppleGFXMR) node;
-    hwaddr pa;
-    void *va;
-    uint64_t len;
-} AppleGFXMR;
-
-typedef QTAILQ_HEAD(, AppleGFXMR) AppleGFXMRList;
-
 typedef struct AppleGFXTask {
     QTAILQ_ENTRY(AppleGFXTask) node;
-    void *mem;
+    mach_vm_address_t address;
     uint64_t len;
 } AppleGFXTask;
 
@@ -95,7 +80,6 @@ -(void)mmioWriteAtOffset:(size_t) offset value:(uint32_t)value;
     id<PGDevice> pgdev;
     id<PGDisplay> pgdisp;
     PGIOSurfaceHostDevice *pgiosfc;
-    AppleGFXMRList mrs;
     AppleGFXTaskList tasks;
     QemuConsole *con;
     void *vram;
@@ -115,37 +99,24 @@ -(void)mmioWriteAtOffset:(size_t) offset value:(uint32_t)value;
 
 static AppleGFXTask *apple_gfx_new_task(AppleGFXState *s, uint64_t len)
 {
-    void *base = APPLE_GFX_BASE_VA;
+    mach_vm_address_t task_mem;
     AppleGFXTask *task;
+    kern_return_t r;
 
-    QTAILQ_FOREACH(task, &s->tasks, node) {
-        if ((task->mem + task->len) > base) {
-            base = task->mem + task->len;
-        }
+    r = mach_vm_allocate(mach_task_self(), &task_mem, len, VM_FLAGS_ANYWHERE);
+    if (r != KERN_SUCCESS || task_mem == 0) {
+        return NULL;
     }
 
     task = g_new0(AppleGFXTask, 1);
 
+    task->address = task_mem;
     task->len = len;
-    task->mem = base;
     QTAILQ_INSERT_TAIL(&s->tasks, task, node);
 
     return task;
 }
 
-static AppleGFXMR *apple_gfx_mapMemory(AppleGFXState *s, AppleGFXTask *task,
-                                       uint64_t voff, uint64_t phys, uint64_t len)
-{
-    AppleGFXMR *mr = g_new0(AppleGFXMR, 1);
-
-    mr->pa = phys;
-    mr->len = len;
-    mr->va = task->mem + voff;
-    QTAILQ_INSERT_TAIL(&s->mrs, mr, node);
-
-    return mr;
-}
-
 static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned size)
 {
     AppleGFXState *s = opaque;
@@ -411,7 +382,7 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
 
     desc.createTask = ^(uint64_t vmSize, void * _Nullable * _Nonnull baseAddress) {
         AppleGFXTask *task = apple_gfx_new_task(s, vmSize);
-        *baseAddress = task->mem;
+        *baseAddress = (void*)task->address;
         trace_apple_gfx_create_task(vmSize, *baseAddress);
         return (PGTask_t *)task;
     };
@@ -420,60 +391,62 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         AppleGFXTask *task = (AppleGFXTask *)_task;
         trace_apple_gfx_destroy_task(task);
         QTAILQ_REMOVE(&s->tasks, task, node);
+        mach_vm_deallocate(mach_task_self(), task->address, task->len);
         g_free(task);
     };
 
     desc.mapMemory = ^(PGTask_t * _Nonnull _task, uint32_t rangeCount, uint64_t virtualOffset, bool readOnly, PGPhysicalMemoryRange_t * _Nonnull ranges) {
         AppleGFXTask *task = (AppleGFXTask*)_task;
-       mach_port_t mtask = mach_task_self();
+        kern_return_t r;
+        mach_vm_address_t target, source;
         trace_apple_gfx_map_memory(task, rangeCount, virtualOffset, readOnly);
         for (int i = 0; i < rangeCount; i++) {
             PGPhysicalMemoryRange_t *range = &ranges[i];
             MemoryRegion *tmp_mr;
             /* TODO: Bounds checks? r/o? */
             bql_lock();
-            AppleGFXMR *mr = apple_gfx_mapMemory(s, task, virtualOffset,
-                                                 range->physicalAddress,
-                                                 range->physicalLength);
 
-            trace_apple_gfx_map_memory_range(i, range->physicalAddress, range->physicalLength, mr->va);
+            trace_apple_gfx_map_memory_range(i, range->physicalAddress,
+                                             range->physicalLength);
 
-            vm_address_t target = (vm_address_t)mr->va;
-            uint64_t mask = 0;
-            bool anywhere = false;
-            vm_address_t source = (vm_address_t)gpa2hva(&tmp_mr, mr->pa, mr->len, NULL);
+            target = task->address + virtualOffset;
+            source = (mach_vm_address_t)gpa2hva(&tmp_mr,
+                                                range->physicalAddress,
+                                                range->physicalLength, NULL);
             vm_prot_t cur_protection = 0;
             vm_prot_t max_protection = 0;
-            kern_return_t retval = vm_remap(mtask, &target, mr->len, mask,
-                                            anywhere, mtask, source, false,
-                                            &cur_protection, &max_protection,
-                                            VM_INHERIT_DEFAULT);
-            trace_apple_gfx_remap(retval, source, target);
-            g_assert(retval == KERN_SUCCESS);
+            // Map guest RAM at range->physicalAddress into PG task memory range
+            r = mach_vm_remap(mach_task_self(),
+                              &target, range->physicalLength, vm_page_size - 1,
+                              VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE,
+                              mach_task_self(),
+                              source, false /* shared mapping, no copy */,
+                              &cur_protection, &max_protection,
+                              VM_INHERIT_COPY);
+            trace_apple_gfx_remap(r, source, target);
+            g_assert(r == KERN_SUCCESS);
 
             bql_unlock();
 
-            virtualOffset += mr->len;
+            virtualOffset += range->physicalLength;
         }
         return (bool)true;
     };
 
     desc.unmapMemory = ^(PGTask_t * _Nonnull _task, uint64_t virtualOffset, uint64_t length) {
         AppleGFXTask *task = (AppleGFXTask *)_task;
-        AppleGFXMR *mr, *next;
+        kern_return_t r;
+        mach_vm_address_t range_address;
 
         trace_apple_gfx_unmap_memory(task, virtualOffset, length);
-        bql_lock();
-        QTAILQ_FOREACH_SAFE(mr, &s->mrs, node, next) {
-            if (mr->va >= (task->mem + virtualOffset) &&
-                (mr->va + mr->len) <= (task->mem + virtualOffset + length)) {
-                vm_address_t addr = (vm_address_t)mr->va;
-                vm_deallocate(mach_task_self(), addr, mr->len);
-                QTAILQ_REMOVE(&s->mrs, mr, node);
-                g_free(mr);
-            }
-        }
-        bql_unlock();
+
+        /* Replace task memory range with fresh pages, undoing the mapping
+         * from guest RAM. */
+        range_address = task->address + virtualOffset;
+        r = mach_vm_allocate(mach_task_self(), &range_address, length,
+                             VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE);
+        g_assert(r == KERN_SUCCESS);
+
         return (bool)true;
     };
 
@@ -582,7 +555,6 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         [[PGIOSurfaceHostDevice alloc] initWithDescriptor:iosfc_desc];
     [iosfc_desc release];
 
-    QTAILQ_INIT(&s->mrs);
     QTAILQ_INIT(&s->tasks);
 
     create_fb(s);
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 98e1a3a3a0..4b897554c9 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -198,7 +198,7 @@ apple_gfx_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx6
 apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=0x%x base_addr=%p"
 apple_gfx_destroy_task(void *task) "task=%p"
 apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t virtual_offset, uint32_t read_only) "task=%p range_count=0x%x virtual_offset=0x%"PRIx64" read_only=%d"
-apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t phys_len, void *va) "[%d] phys_addr=0x%"PRIx64" phys_len=0x%"PRIx64" va=%p"
+apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t phys_len) "[%d] phys_addr=0x%"PRIx64" phys_len=0x%"PRIx64
 apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t target) "retval=%"PRId64" source=0x%"PRIx64" target=0x%"PRIx64
 apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t length) "task=%p virtual_offset=0x%"PRIx64" length=0x%"PRIx64
 apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void *dst) "phys_addr=0x%"PRIx64" length=0x%"PRIx64" dest=%p"
-- 
2.39.3 (Apple Git-146)


