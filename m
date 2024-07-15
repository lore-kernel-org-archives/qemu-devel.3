Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA70BC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TO-0005Ij-KP; Wed, 17 Jul 2024 07:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SV-0000xV-EP
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:36 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SR-00071K-DJ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:30 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 207E1379625; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 11/26] hw/display/apple-gfx: Uses ObjC category extension for
 private property
Date: Mon, 15 Jul 2024 23:06:50 +0200
Message-Id: <20240715210705.32365-12-phil@philjordan.eu>
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

The vmapple mmio implementation of the PG device uses an IOService
mapper for sharing video memory between host and guest. This is only
exposed via a private property on the PGDeviceDescriptor class. The
code has so far declared this in a dummy derived class; the idiomatic
Objective-C way of exposing private APIs on a class is via a category
extension. This change does exactly that; this also avoids the extra
cast to access the property.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 073741ede5..6537e32806 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -51,7 +51,7 @@
 typedef bool(^IOSFCUnmapMemory)(void *a, void *b, void *c, void *d, void *e, void *f);
 typedef bool(^IOSFCMapMemory)(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f);
 
-@interface PGDeviceDescriptorExt : PGDeviceDescriptor
+@interface PGDeviceDescriptor (IOSurfaceMapper)
 @property (readwrite, nonatomic) bool usingIOSurfaceMapper;
 @end
 
@@ -396,7 +396,6 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
     PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
     PGDisplayDescriptor *disp_desc = [PGDisplayDescriptor new];
     PGIOSurfaceHostDeviceDescriptor *iosfc_desc = [PGIOSurfaceHostDeviceDescriptor new];
-    PGDeviceDescriptorExt *desc_ext = (PGDeviceDescriptorExt *)desc;
     PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
     int i;
 
@@ -408,7 +407,7 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
     s->mtl = MTLCreateSystemDefaultDevice();
 
     desc.device = s->mtl;
-    desc_ext.usingIOSurfaceMapper = true;
+    desc.usingIOSurfaceMapper = true;
 
     desc.createTask = ^(uint64_t vmSize, void * _Nullable * _Nonnull baseAddress) {
         AppleGFXTask *task = apple_gfx_new_task(s, vmSize);
-- 
2.39.3 (Apple Git-146)


