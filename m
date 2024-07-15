Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF47C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2SF-0008M9-4s; Wed, 17 Jul 2024 07:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SC-0008AW-7l
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:12 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2S8-0006yB-QZ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:11 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 0E13837961F; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 10/26] hw/display/apple-gfx: Fixes ObjC new/init misuse,
 plugs leaks
Date: Mon, 15 Jul 2024 23:06:49 +0200
Message-Id: <20240715210705.32365-11-phil@philjordan.eu>
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

The creation of Objective-C objects is split between 'alloc' and
'init...' methods. The single 'new' method is shorthand for alloc+init.
Calling 'new' then 'init...' is therefore redundant. The instances of
new + initWith... are replaced with the alloc/initWith... pattern and
the zero-argument 'init' call is removed from instances of the
new + init pattern.

'new' and alloc+init return an object with a retain count of 1. The
change therefore also inserts release calls for temporary objects
created in this way to prevent them leaking.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 7f0a231d26..073741ede5 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -63,7 +63,7 @@ -(PGIOSurfaceHostDeviceDescriptor *)init;
 @end
 
 @interface PGIOSurfaceHostDevice : NSObject
--(void)initWithDescriptor:(PGIOSurfaceHostDeviceDescriptor *) desc;
+-(instancetype)initWithDescriptor:(PGIOSurfaceHostDeviceDescriptor *) desc;
 -(uint32_t)mmioReadAtOffset:(size_t) offset;
 -(void)mmioWriteAtOffset:(size_t) offset value:(uint32_t)value;
 @end
@@ -401,8 +401,8 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
     int i;
 
     for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
-        modes[i] = [PGDisplayMode new];
-        [modes[i] initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
+        modes[i] =
+            [[PGDisplayMode alloc] initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
     }
 
     s->mtl = MTLCreateSystemDefaultDevice();
@@ -499,8 +499,9 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
     };
 
     s->pgdev = PGNewDeviceWithDescriptor(desc);
+    [desc release];
+    desc = nil;
 
-    [disp_desc init];
     disp_desc.name = @"QEMU display";
     disp_desc.sizeInMillimeters = NSMakeSize(400., 300.); /* A 20" display */
     disp_desc.queue = dispatch_get_main_queue();
@@ -545,9 +546,14 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
     };
 
     s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc port:0 serialNum:1234];
+    [disp_desc release];
     s->pgdisp.modeList = [NSArray arrayWithObjects:modes count:ARRAY_SIZE(apple_gfx_modes)];
 
-    [iosfc_desc init];
+    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
+        [modes[i] release];
+        modes[i] = nil;
+    }
+
     iosfc_desc.mapMemory = ^(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
         trace_apple_iosfc_map_memory(phys, len, ro, va, e, f);
         MemoryRegion *tmp_mr;
@@ -573,8 +579,9 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         return (bool)true;
     };
 
-    s->pgiosfc = [PGIOSurfaceHostDevice new];
-    [s->pgiosfc initWithDescriptor:iosfc_desc];
+    s->pgiosfc =
+        [[PGIOSurfaceHostDevice alloc] initWithDescriptor:iosfc_desc];
+    [iosfc_desc release];
 
     QTAILQ_INIT(&s->mrs);
     QTAILQ_INIT(&s->tasks);
-- 
2.39.3 (Apple Git-146)


