Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B31C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TJ-0004hP-27; Wed, 17 Jul 2024 07:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SS-0000nw-Uo
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:36 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SQ-0006zO-47
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:28 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id E8418379615; Mon, 15 Jul 2024 23:07:37 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 06/26] hw/display/apple-gfx: Removes dead/superfluous code
Date: Mon, 15 Jul 2024 23:06:45 +0200
Message-Id: <20240715210705.32365-7-phil@philjordan.eu>
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

This removes a few chunks of code that do nothing useful.

 * MAX_MRS was not used anywhere.
 * The MMIO offset switch block had only a default case.
 * Generating mip maps for the texture is a waste of time as the
   texture is only used for read-out to a system memory buffer.
 * The trace range callbacks are used only when the device is
   handled by the (2D-only) UEFI guest driver, not by the macOS
   guest driver, hence the lack of observed use in the vmapple
   machine which does not use UEFI. Making these no-ops could
   potentially be harmful, whereas leaving them unimplemented
   is explicitly supported according to the framework header
   docs.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 8b0459f969..b10c060d9a 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -28,8 +28,6 @@
 
 #define TYPE_APPLE_GFX          "apple-gfx"
 
-#define MAX_MRS 512
-
 static const PGDisplayCoord_t apple_gfx_modes[] = {
     { .x = 1440, .y = 1080 },
     { .x = 1280, .y = 1024 },
@@ -149,11 +147,7 @@ static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned size)
     AppleGFXState *s = opaque;
     uint64_t res = 0;
 
-    switch (offset) {
-    default:
-        res = [s->pgdev mmioReadAtOffset:offset];
-        break;
-    }
+    res = [s->pgdev mmioReadAtOffset:offset];
 
     trace_apple_gfx_read(offset, res);
 
@@ -248,7 +242,6 @@ static void apple_gfx_fb_update_display(void *opaque)
     }
 
     id<MTLBlitCommandEncoder> blitCommandEncoder = [mipmapCommandBuffer blitCommandEncoder];
-    [blitCommandEncoder generateMipmapsForTexture:s->texture];
     [blitCommandEncoder endEncoding];
     [mipmapCommandBuffer commit];
     [mipmapCommandBuffer waitUntilCompleted];
@@ -460,14 +453,6 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         }
     };
 
-    desc.addTraceRange = ^(PGPhysicalMemoryRange_t * _Nonnull range, PGTraceRangeHandler _Nonnull handler) {
-        /* Never saw this called. Return a bogus pointer so we catch access. */
-        return (PGTraceRange_t *)(void *)(uintptr_t)0x4242;
-    };
-
-    desc.removeTraceRange = ^(PGTraceRange_t * _Nonnull range) {
-        /* Never saw this called. Nothing to do. */
-    };
     s->pgdev = PGNewDeviceWithDescriptor(desc);
 
     [disp_desc init];
-- 
2.39.3 (Apple Git-146)


