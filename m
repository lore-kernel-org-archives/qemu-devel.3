Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE3BC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Sq-0001xQ-L0; Wed, 17 Jul 2024 07:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SR-0000iA-Ce
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:29 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SO-0006zP-OG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:27 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id EECB8379617; Mon, 15 Jul 2024 23:07:37 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 07/26] hw/display/apple-gfx: Makes set_mode thread & memory
 safe
Date: Mon, 15 Jul 2024 23:06:46 +0200
Message-Id: <20240715210705.32365-8-phil@philjordan.eu>
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

When the set_mode callback was invoked outside of the BQL, there
could be a race condition swapping out the resized render target
texture and VRAM. set_mode may be called inside or out of the
BQL depending on context (reentrant from a MMIO write or not)
so we need to check locking state first.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 54 +++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index b10c060d9a..39aba8d143 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -290,34 +290,60 @@ static void update_cursor(AppleGFXState *s)
 
 static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
 {
-    void *vram = g_malloc0(width * height * 4);
+    void *vram = NULL;
     void *old_vram = s->vram;
     DisplaySurface *surface;
     MTLTextureDescriptor *textureDescriptor;
-    id<MTLTexture> old_texture = s->texture;
+    id<MTLTexture> old_texture = nil;
+    id<MTLTexture> texture = nil;
+    bool locking_required = false;
 
+    locking_required = !bql_locked();
+    if (locking_required) {
+        bql_lock();
+    }
     if (s->surface &&
         width == surface_width(s->surface) &&
         height == surface_height(s->surface)) {
+        if (locking_required) {
+            bql_unlock();
+        }
         return;
     }
+    if (locking_required) {
+        bql_unlock();
+    }
+
+    vram = g_malloc0(width * height * 4);
     surface = qemu_create_displaysurface_from(width, height, PIXMAN_LE_a8r8g8b8,
                                               width * 4, vram);
-    s->surface = surface;
-    dpy_gfx_replace_surface(s->con, surface);
-    s->vram = vram;
-    g_free(old_vram);
 
-    textureDescriptor = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
-                                              width:width
-                                              height:height
-                                              mipmapped:NO];
-    textureDescriptor.usage = s->pgdisp.minimumTextureUsage;
-    s->texture = [s->mtl newTextureWithDescriptor:textureDescriptor];
+    @autoreleasepool {
+        textureDescriptor =
+            [MTLTextureDescriptor
+                texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
+                                             width:width
+                                            height:height
+                                         mipmapped:NO];
+        textureDescriptor.usage = s->pgdisp.minimumTextureUsage;
+        texture = [s->mtl newTextureWithDescriptor:textureDescriptor];
+    }
 
-    if (old_texture) {
-        [old_texture release];
+    if (locking_required) {
+        bql_lock();
+    }
+    old_vram = s->vram;
+    s->vram = vram;
+    s->surface = surface;
+    dpy_gfx_replace_surface(s->con, surface);
+    old_texture = s->texture;
+    s->texture = texture;
+    if (locking_required) {
+        bql_unlock();
     }
+
+    g_free(old_vram);
+    [old_texture release];
 }
 
 static void create_fb(AppleGFXState *s)
-- 
2.39.3 (Apple Git-146)


