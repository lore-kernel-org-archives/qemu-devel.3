Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED19C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TF-0004KE-L6; Wed, 17 Jul 2024 07:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SS-0000mw-Li
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:33 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SP-00070G-4t
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:28 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 471CE37963C; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 17/26] hw/display/apple-gfx: Asynchronous rendering and
 graphics update
Date: Mon, 15 Jul 2024 23:06:56 +0200
Message-Id: <20240715210705.32365-18-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715210705.32365-1-phil@philjordan.eu>
References: <20240715210705.32365-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This change avoids doing expensive rendering while holding the BQL.
Rendering with the lock held is not only inefficient, it can also
cause deadlocks when the PV Graphics framework’s encode... method
causes a (synchronous) call to a callback, which in turn tries to
acquire the BQL.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.h |  15 +++-
 hw/display/apple-gfx.m | 193 +++++++++++++++++++++++++++--------------
 2 files changed, 138 insertions(+), 70 deletions(-)

diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index fa7fea6368..9d6d40795e 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -15,12 +15,14 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name);
 #include "qemu/osdep.h"
 #include "exec/memory.h"
 #include "ui/surface.h"
+#include <dispatch/dispatch.h>
 
 @class PGDeviceDescriptor;
 @protocol PGDevice;
 @protocol PGDisplay;
 @protocol MTLDevice;
 @protocol MTLTexture;
+@protocol MTLCommandQueue;
 
 typedef QTAILQ_HEAD(, PGTask_s) AppleGFXTaskList;
 
@@ -30,14 +32,21 @@ struct AppleGFXState {
     id<PGDisplay> pgdisp;
     AppleGFXTaskList tasks;
     QemuConsole *con;
-    void *vram;
     id<MTLDevice> mtl;
-    id<MTLTexture> texture;
+    id<MTLCommandQueue> mtl_queue;
     bool handles_frames;
     bool new_frame;
     bool cursor_show;
-    DisplaySurface *surface;
     QEMUCursor *cursor;
+
+    dispatch_queue_t render_queue;
+    /* The following fields should only be accessed from render_queue: */
+    bool gfx_update_requested;
+    bool new_frame_ready;
+    int32_t pending_frames;
+    void *vram;
+    DisplaySurface *surface;
+    id<MTLTexture> texture;
 };
 
 void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc);
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 48463e5a1f..5855d1d7f5 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -35,6 +35,9 @@
 
 static Error *apple_gfx_mig_blocker;
 
+static void apple_gfx_render_frame_completed(AppleGFXState *s, void *vram,
+                                             id<MTLTexture> texture);
+
 static AppleGFXTask *apple_gfx_new_task(AppleGFXState *s, uint64_t len)
 {
     mach_vm_address_t task_mem;
@@ -105,41 +108,63 @@ static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val,
     },
 };
 
-static void apple_gfx_fb_update_display(void *opaque)
+static void apple_gfx_render_new_frame(AppleGFXState *s)
 {
-    AppleGFXState *s = opaque;
-
-    if (!s->new_frame || !s->handles_frames) {
+    BOOL r;
+    void *vram = s->vram;
+    uint32_t width = surface_width(s->surface);
+    uint32_t height = surface_height(s->surface);
+    MTLRegion region = MTLRegionMake2D(0, 0, width, height);
+    id<MTLCommandBuffer> command_buffer = [s->mtl_queue commandBuffer];
+    id<MTLTexture> texture = s->texture;
+    r = [s->pgdisp encodeCurrentFrameToCommandBuffer:command_buffer
+                                             texture:texture
+                                              region:region];
+    if (!r) {
         return;
     }
+    [texture retain];
+
+    [command_buffer retain];
+    [command_buffer addCompletedHandler:
+        ^(id<MTLCommandBuffer> cb)
+        {
+            dispatch_async(s->render_queue, ^{
+                apple_gfx_render_frame_completed(s, vram, texture);
+                [texture release];
+            });
+            [command_buffer release];
+        }];
+    [command_buffer commit];
+}
 
-    @autoreleasepool {
-        s->new_frame = false;
-
-        BOOL r;
-        uint32_t width = surface_width(s->surface);
-        uint32_t height = surface_height(s->surface);
-        MTLRegion region = MTLRegionMake2D(0, 0, width, height);
-        id<MTLCommandQueue> commandQueue = [s->mtl newCommandQueue];
-        id<MTLCommandBuffer> mipmapCommandBuffer = [commandQueue commandBuffer];
-
-        r = [s->pgdisp encodeCurrentFrameToCommandBuffer:mipmapCommandBuffer
-                                                 texture:s->texture
-                                                  region:region];
+static void copy_mtl_texture_to_surface_mem(id<MTLTexture> texture, void *vram)
+{
+    /* TODO: Skip this entirely on a pure Metal or headless/guest-only
+     * rendering path, else use a blit command encoder? Needs careful
+     * (double?) buffering design. */
+    size_t width = texture.width, height = texture.height;
+    MTLRegion region = MTLRegionMake2D(0, 0, width, height);
+    [texture getBytes:vram
+          bytesPerRow:(width * 4)
+        bytesPerImage:(width * height * 4)
+           fromRegion:region
+          mipmapLevel:0
+                slice:0];
+}
 
-        if (r != YES) {
-            return;
-        }
+static void apple_gfx_render_frame_completed(AppleGFXState *s, void *vram,
+                                             id<MTLTexture> texture)
+{
+    --s->pending_frames;
+    assert(s->pending_frames >= 0);
 
-        id<MTLBlitCommandEncoder> blitCommandEncoder = [mipmapCommandBuffer blitCommandEncoder];
-        [blitCommandEncoder endEncoding];
-        [mipmapCommandBuffer commit];
-        [mipmapCommandBuffer waitUntilCompleted];
-        [s->texture getBytes:s->vram bytesPerRow:(width * 4)
-                                     bytesPerImage: (width * height * 4)
-                                     fromRegion: region
-                                     mipmapLevel: 0
-                                     slice: 0];
+    if (vram != s->vram) {
+        /* Display mode has changed, drop this old frame. */
+        assert(texture != s->texture);
+        g_free(vram);
+    } else {
+        copy_mtl_texture_to_surface_mem(texture, vram);
 
         /* Need to render cursor manually if not supported by backend */
         if (!dpy_cursor_define_supported(s->con) && s->cursor && s->cursor_show) {
@@ -159,14 +184,40 @@ static void apple_gfx_fb_update_display(void *opaque)
             pixman_image_unref(image);
         }
 
-        dpy_gfx_update_full(s->con);
-
-        [commandQueue release];
+        if (s->gfx_update_requested) {
+            s->gfx_update_requested = false;
+            dpy_gfx_update_full(s->con);
+            graphic_hw_update_done(s->con);
+            s->new_frame_ready = false;
+        } else {
+            s->new_frame_ready = true;
+        }
+    }
+    if (s->pending_frames > 0) {
+        apple_gfx_render_new_frame(s);
     }
 }
 
+static void apple_gfx_fb_update_display(void *opaque)
+{
+    AppleGFXState *s = opaque;
+
+    dispatch_async(s->render_queue, ^{
+        if (s->pending_frames > 0) {
+            s->gfx_update_requested = true;
+        } else {
+            if (s->new_frame_ready) {
+                dpy_gfx_update_full(s->con);
+                s->new_frame_ready = false;
+            }
+            graphic_hw_update_done(s->con);
+        }
+    });
+}
+
 static const GraphicHwOps apple_gfx_fb_ops = {
     .gfx_update = apple_gfx_fb_update_display,
+    .gfx_update_async = true,
 };
 
 static void update_cursor(AppleGFXState *s)
@@ -182,28 +233,23 @@ static void update_cursor(AppleGFXState *s)
 static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
 {
     void *vram = NULL;
-    void *old_vram = s->vram;
     DisplaySurface *surface;
     MTLTextureDescriptor *textureDescriptor;
-    id<MTLTexture> old_texture = nil;
     id<MTLTexture> texture = nil;
-    bool locking_required = false;
-
-    locking_required = !bql_locked();
-    if (locking_required) {
-        bql_lock();
-    }
-    if (s->surface &&
-        width == surface_width(s->surface) &&
-        height == surface_height(s->surface)) {
-        if (locking_required) {
-            bql_unlock();
-        }
+    __block bool no_change = false;
+
+    dispatch_sync(s->render_queue,
+        ^{
+            if (s->surface &&
+                width == surface_width(s->surface) &&
+                height == surface_height(s->surface)) {
+                no_change = true;
+            }
+        });
+
+    if (no_change) {
         return;
     }
-    if (locking_required) {
-        bql_unlock();
-    }
 
     vram = g_malloc0(width * height * 4);
     surface = qemu_create_displaysurface_from(width, height, PIXMAN_LE_a8r8g8b8,
@@ -220,21 +266,23 @@ static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
         texture = [s->mtl newTextureWithDescriptor:textureDescriptor];
     }
 
-    if (locking_required) {
-        bql_lock();
-    }
-    old_vram = s->vram;
-    s->vram = vram;
-    s->surface = surface;
-    dpy_gfx_replace_surface(s->con, surface);
-    old_texture = s->texture;
-    s->texture = texture;
-    if (locking_required) {
-        bql_unlock();
-    }
+    dispatch_sync(s->render_queue,
+        ^{
+            id<MTLTexture> old_texture = nil;
+            void *old_vram = s->vram;
+            s->vram = vram;
+            s->surface = surface;
 
-    g_free(old_vram);
-    [old_texture release];
+            dpy_gfx_replace_surface(s->con, surface);
+
+            old_texture = s->texture;
+            s->texture = texture;
+            [old_texture release];
+
+            if (s->pending_frames == 0) {
+                g_free(old_vram);
+            }
+        });
 }
 
 static void create_fb(AppleGFXState *s)
@@ -354,10 +402,18 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
     disp_desc.queue = dispatch_get_main_queue();
     disp_desc.newFrameEventHandler = ^(void) {
         trace_apple_gfx_new_frame();
-
-        /* Tell QEMU gfx stack that a new frame arrived */
-        s->handles_frames = true;
-        s->new_frame = true;
+        dispatch_async(s->render_queue, ^{
+            /* Drop frames if we get too far ahead. */
+            if (s->pending_frames >= 2)
+                return;
+            ++s->pending_frames;
+            if (s->pending_frames > 1) {
+                return;
+            }
+            @autoreleasepool {
+                apple_gfx_render_new_frame(s);
+            }
+        });
     };
     disp_desc.modeChangeHandler = ^(PGDisplayCoord_t sizeInPixels,
                                     OSType pixelFormat) {
@@ -422,7 +478,10 @@ void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
     PGDisplayDescriptor *disp_desc = nil;
 
     QTAILQ_INIT(&s->tasks);
+    s->render_queue = dispatch_queue_create("apple-gfx.render",
+                                            DISPATCH_QUEUE_SERIAL);
     s->mtl = MTLCreateSystemDefaultDevice();
+    s->mtl_queue = [s->mtl newCommandQueue];
 
     desc.device = s->mtl;
 
-- 
2.39.3 (Apple Git-146)


