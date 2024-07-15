Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED01CC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TO-0005I9-Jv; Wed, 17 Jul 2024 07:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SR-0000h2-2r
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:29 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SN-0006yq-RP
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:26 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 334ED379630; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 14/26] hw/display/apple-gfx: Refactoring of realize function
Date: Mon, 15 Jul 2024 23:06:53 +0200
Message-Id: <20240715210705.32365-15-phil@philjordan.eu>
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

The apple_gfx_realize function was very long, with different
sections of the code doing mostly unrelated things.

This change groups some of the functionality into helper
functions, which hopefully makes the code easier to understand.

There are also some code formatting fixes in the general
vicinity of the refactored code.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 120 ++++++++++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 44 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 39e33ed999..f9046f41a0 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -360,26 +360,9 @@ static void apple_gfx_init(Object *obj)
     }
 }
 
-static void apple_gfx_realize(DeviceState *dev, Error **errp)
+static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
+                                                     PGDeviceDescriptor *desc)
 {
-    @autoreleasepool {
-    AppleGFXState *s = APPLE_GFX(dev);
-    PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
-    PGDisplayDescriptor *disp_desc = [PGDisplayDescriptor new];
-    PGIOSurfaceHostDeviceDescriptor *iosfc_desc = [PGIOSurfaceHostDeviceDescriptor new];
-    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
-        modes[i] =
-            [[PGDisplayMode alloc] initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
-    }
-
-    s->mtl = MTLCreateSystemDefaultDevice();
-
-    desc.device = s->mtl;
-    desc.usingIOSurfaceMapper = true;
-
     desc.createTask = ^(uint64_t vmSize, void * _Nullable * _Nonnull baseAddress) {
         AppleGFXTask *task = apple_gfx_new_task(s, vmSize);
         *baseAddress = (void*)task->address;
@@ -450,29 +433,18 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         return (bool)true;
     };
 
-    desc.readMemory = ^(uint64_t physicalAddress, uint64_t length, void * _Nonnull dst) {
+    desc.readMemory = ^(uint64_t physicalAddress, uint64_t length,
+                        void * _Nonnull dst) {
         trace_apple_gfx_read_memory(physicalAddress, length, dst);
         cpu_physical_memory_read(physicalAddress, dst, length);
         return (bool)true;
     };
 
-    desc.raiseInterrupt = ^(uint32_t vector) {
-        bool locked;
-
-        trace_apple_gfx_raise_irq(vector);
-        locked = bql_locked();
-        if (!locked) {
-            bql_lock();
-        }
-        qemu_irq_pulse(s->irq_gfx);
-        if (!locked) {
-            bql_unlock();
-        }
-    };
+}
 
-    s->pgdev = PGNewDeviceWithDescriptor(desc);
-    [desc release];
-    desc = nil;
+static PGDisplayDescriptor *apple_gfx_prepare_display_handlers(AppleGFXState *s)
+{
+    PGDisplayDescriptor *disp_desc = [PGDisplayDescriptor new];
 
     disp_desc.name = @"QEMU display";
     disp_desc.sizeInMillimeters = NSMakeSize(400., 300.); /* A 20" display */
@@ -484,7 +456,8 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         s->handles_frames = true;
         s->new_frame = true;
     };
-    disp_desc.modeChangeHandler = ^(PGDisplayCoord_t sizeInPixels, OSType pixelFormat) {
+    disp_desc.modeChangeHandler = ^(PGDisplayCoord_t sizeInPixels,
+                                    OSType pixelFormat) {
         trace_apple_gfx_mode_change(sizeInPixels.x, sizeInPixels.y);
         set_mode(s, sizeInPixels.x, sizeInPixels.y);
     };
@@ -517,15 +490,35 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         update_cursor(s);
     };
 
-    s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc port:0 serialNum:1234];
-    [disp_desc release];
-    s->pgdisp.modeList = [NSArray arrayWithObjects:modes count:ARRAY_SIZE(apple_gfx_modes)];
+    return disp_desc;
+}
+
+static NSArray<PGDisplayMode*>* apple_gfx_prepare_display_mode_array(void)
+{
+    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
+    NSArray<PGDisplayMode*>* mode_array = nil;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
+        modes[i] =
+            [[PGDisplayMode alloc] initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
+    }
+
+    mode_array = [NSArray arrayWithObjects:modes count:ARRAY_SIZE(apple_gfx_modes)];
 
     for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
         [modes[i] release];
         modes[i] = nil;
     }
 
+    return mode_array;
+}
+
+static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device(AppleGFXState *s)
+{
+    PGIOSurfaceHostDeviceDescriptor *iosfc_desc = [PGIOSurfaceHostDeviceDescriptor new];
+    PGIOSurfaceHostDevice *iosfc_host_dev = nil;
+
     iosfc_desc.mapMemory = ^(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
         trace_apple_iosfc_map_memory(phys, len, ro, va, e, f);
         MemoryRegion *tmp_mr;
@@ -551,13 +544,52 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         return (bool)true;
     };
 
-    s->pgiosfc =
-        [[PGIOSurfaceHostDevice alloc] initWithDescriptor:iosfc_desc];
+    iosfc_host_dev = [[PGIOSurfaceHostDevice alloc] initWithDescriptor:iosfc_desc];
     [iosfc_desc release];
+    return iosfc_host_dev;
+}
+
+static void apple_gfx_realize(DeviceState *dev, Error **errp)
+{
+    @autoreleasepool {
+        AppleGFXState *s = APPLE_GFX(dev);
+        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
+        PGDisplayDescriptor *disp_desc = nil;
+
+        QTAILQ_INIT(&s->tasks);
+        s->mtl = MTLCreateSystemDefaultDevice();
+
+        desc.device = s->mtl;
+        desc.usingIOSurfaceMapper = true;
+
+        apple_gfx_register_task_mapping_handlers(s, desc);
+
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
+        s->pgdev = PGNewDeviceWithDescriptor(desc);
+        [desc release];
+        desc = nil;
+
+        disp_desc = apple_gfx_prepare_display_handlers(s);
+        s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc port:0 serialNum:1234];
+        [disp_desc release];
+        s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
 
-    QTAILQ_INIT(&s->tasks);
+        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
 
-    create_fb(s);
+        create_fb(s);
     }
 }
 
-- 
2.39.3 (Apple Git-146)


