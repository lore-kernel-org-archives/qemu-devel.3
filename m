Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF88AC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2SF-0008No-ID; Wed, 17 Jul 2024 07:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SD-0008Fu-Hi
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:13 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SB-0006yq-D4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:13 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 61F2F379647; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 21/26] hw/display/apple-gfx: Implements texture syncing for
 non-UMA GPUs
Date: Mon, 15 Jul 2024 23:07:00 +0200
Message-Id: <20240715210705.32365-22-phil@philjordan.eu>
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

Renderable Metal textures are handled differently depending on
whether the GPU uses a unified memory architecture (no physical
distinction between VRAM and system RAM, CPU and GPU share the
memory bus) or not. (Traditional discrete GPU with its own VRAM)

In the discrete GPU case, textures must be explicitly
synchronised to the CPU or the GPU before use after being
modified by the other. In this case, we sync after the PV
graphics framework has rendered the next frame into the
texture using the GPU so that we can read out its contents using
the CPU. This fixes the issue where the guest screen stayed
black on AMD Radeon GPUs.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.h |  1 +
 hw/display/apple-gfx.m | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 9d6d40795e..995ecf7f4a 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -43,6 +43,7 @@ struct AppleGFXState {
     /* The following fields should only be accessed from render_queue: */
     bool gfx_update_requested;
     bool new_frame_ready;
+    bool using_managed_texture_storage;
     int32_t pending_frames;
     void *vram;
     DisplaySurface *surface;
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index bc9722b420..801ae4ad51 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -125,7 +125,12 @@ static void apple_gfx_render_new_frame(AppleGFXState *s)
         return;
     }
     [texture retain];
-
+    if (s->using_managed_texture_storage) {
+        /* "Managed" textures exist in both VRAM and RAM and must be synced. */
+        id<MTLBlitCommandEncoder> blit = [command_buffer blitCommandEncoder];
+        [blit synchronizeResource:texture];
+        [blit endEncoding];
+    }
     [command_buffer retain];
     [command_buffer addCompletedHandler:
         ^(id<MTLCommandBuffer> cb)
@@ -268,6 +273,9 @@ static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
         texture = [s->mtl newTextureWithDescriptor:textureDescriptor];
     }
 
+    s->using_managed_texture_storage =
+        (texture.storageMode == MTLStorageModeManaged);
+
     dispatch_sync(s->render_queue,
         ^{
             id<MTLTexture> old_texture = nil;
-- 
2.39.3 (Apple Git-146)


