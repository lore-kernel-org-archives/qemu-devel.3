Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DEBC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2SD-0008C3-AX; Wed, 17 Jul 2024 07:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SA-00084J-Sv
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:10 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2S8-0006yC-Oh
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:10 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 075D137961B; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 09/26] hw/display/apple-gfx: Wraps ObjC autorelease code in
 pool
Date: Mon, 15 Jul 2024 23:06:48 +0200
Message-Id: <20240715210705.32365-10-phil@philjordan.eu>
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

Most Objective-C methods return objects with autorelease semantics.
These objects will have their retain count decremented once control
exits the scope of the current autorelease pool. A number of areas
in the code call such methods with autorelease semantics, but can't
make any guarantees about the presence of a surrounding pool.

We therefore wrap some code in explicit pool scopes to prevent
leaks.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 88 ++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index c97bd40cb5..7f0a231d26 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -228,54 +228,56 @@ static void apple_gfx_fb_update_display(void *opaque)
         return;
     }
 
-    s->new_frame = false;
+    @autoreleasepool {
+        s->new_frame = false;
 
-    BOOL r;
-    uint32_t width = surface_width(s->surface);
-    uint32_t height = surface_height(s->surface);
-    MTLRegion region = MTLRegionMake2D(0, 0, width, height);
-    id<MTLCommandQueue> commandQueue = [s->mtl newCommandQueue];
-    id<MTLCommandBuffer> mipmapCommandBuffer = [commandQueue commandBuffer];
+        BOOL r;
+        uint32_t width = surface_width(s->surface);
+        uint32_t height = surface_height(s->surface);
+        MTLRegion region = MTLRegionMake2D(0, 0, width, height);
+        id<MTLCommandQueue> commandQueue = [s->mtl newCommandQueue];
+        id<MTLCommandBuffer> mipmapCommandBuffer = [commandQueue commandBuffer];
 
-    r = [s->pgdisp encodeCurrentFrameToCommandBuffer:mipmapCommandBuffer
-                                             texture:s->texture
-                                              region:region];
+        r = [s->pgdisp encodeCurrentFrameToCommandBuffer:mipmapCommandBuffer
+                                                 texture:s->texture
+                                                  region:region];
 
-    if (r != YES) {
-        return;
-    }
+        if (r != YES) {
+            return;
+        }
 
-    id<MTLBlitCommandEncoder> blitCommandEncoder = [mipmapCommandBuffer blitCommandEncoder];
-    [blitCommandEncoder endEncoding];
-    [mipmapCommandBuffer commit];
-    [mipmapCommandBuffer waitUntilCompleted];
-    [s->texture getBytes:s->vram bytesPerRow:(width * 4)
-                                 bytesPerImage: (width * height * 4)
-                                 fromRegion: region
-                                 mipmapLevel: 0
-                                 slice: 0];
-
-    /* Need to render cursor manually if not supported by backend */
-    if (!dpy_cursor_define_supported(s->con) && s->cursor && s->cursor_show) {
-        pixman_image_t *image =
-            pixman_image_create_bits(PIXMAN_a8r8g8b8,
-                                     s->cursor->width,
-                                     s->cursor->height,
-                                     (uint32_t *)s->cursor->data,
-                                     s->cursor->width * 4);
-
-        pixman_image_composite(PIXMAN_OP_OVER,
-                               image, NULL, s->surface->image,
-                               0, 0, 0, 0, s->pgdisp.cursorPosition.x,
-                               s->pgdisp.cursorPosition.y, s->cursor->width,
-                               s->cursor->height);
-
-        pixman_image_unref(image);
-    }
+        id<MTLBlitCommandEncoder> blitCommandEncoder = [mipmapCommandBuffer blitCommandEncoder];
+        [blitCommandEncoder endEncoding];
+        [mipmapCommandBuffer commit];
+        [mipmapCommandBuffer waitUntilCompleted];
+        [s->texture getBytes:s->vram bytesPerRow:(width * 4)
+                                     bytesPerImage: (width * height * 4)
+                                     fromRegion: region
+                                     mipmapLevel: 0
+                                     slice: 0];
+
+        /* Need to render cursor manually if not supported by backend */
+        if (!dpy_cursor_define_supported(s->con) && s->cursor && s->cursor_show) {
+            pixman_image_t *image =
+                pixman_image_create_bits(PIXMAN_a8r8g8b8,
+                                         s->cursor->width,
+                                         s->cursor->height,
+                                         (uint32_t *)s->cursor->data,
+                                         s->cursor->width * 4);
+
+            pixman_image_composite(PIXMAN_OP_OVER,
+                                   image, NULL, s->surface->image,
+                                   0, 0, 0, 0, s->pgdisp.cursorPosition.x,
+                                   s->pgdisp.cursorPosition.y, s->cursor->width,
+                                   s->cursor->height);
+
+            pixman_image_unref(image);
+        }
 
-    dpy_gfx_update_full(s->con);
+        dpy_gfx_update_full(s->con);
 
-    [commandQueue release];
+        [commandQueue release];
+    }
 }
 
 static const GraphicHwOps apple_gfx_fb_ops = {
@@ -389,6 +391,7 @@ static void apple_gfx_init(Object *obj)
 
 static void apple_gfx_realize(DeviceState *dev, Error **errp)
 {
+    @autoreleasepool {
     AppleGFXState *s = APPLE_GFX(dev);
     PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
     PGDisplayDescriptor *disp_desc = [PGDisplayDescriptor new];
@@ -577,6 +580,7 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
     QTAILQ_INIT(&s->tasks);
 
     create_fb(s);
+    }
 }
 
 static void apple_gfx_class_init(ObjectClass *klass, void *data)
-- 
2.39.3 (Apple Git-146)


