Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D04C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2SF-0008OB-Lf; Wed, 17 Jul 2024 07:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SC-0008AZ-8P
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:12 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2S9-0006yE-Oa
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:11 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 01223379619; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 08/26] hw/display/apple-gfx: Adds migration blocker
Date: Mon, 15 Jul 2024 23:06:47 +0200
Message-Id: <20240715210705.32365-9-phil@philjordan.eu>
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

Although the underlying ParavirtualizedGraphics.framework does support
state (de-)serialisation, this is currently not yet integrated. We
therefore add a migration blocker for now.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 39aba8d143..c97bd40cb5 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -24,6 +24,8 @@
 #include "sysemu/cpus.h"
 #include "ui/console.h"
 #include "monitor/monitor.h"
+#include "qapi/error.h"
+#include "migration/blocker.h"
 #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
 
 #define TYPE_APPLE_GFX          "apple-gfx"
@@ -109,6 +111,8 @@ -(void)mmioWriteAtOffset:(size_t) offset value:(uint32_t)value;
 
 OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXState, APPLE_GFX)
 
+static Error *apple_gfx_mig_blocker;
+
 static AppleGFXTask *apple_gfx_new_task(AppleGFXState *s, uint64_t len)
 {
     void *base = APPLE_GFX_BASE_VA;
@@ -362,6 +366,8 @@ static void apple_gfx_reset(DeviceState *d)
 static void apple_gfx_init(Object *obj)
 {
     AppleGFXState *s = APPLE_GFX(obj);
+    Error *local_err = NULL;
+    int r;
 
     memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s, TYPE_APPLE_GFX, 0x4000);
     memory_region_init_io(&s->iomem_iosfc, obj, &apple_iosfc_ops, s, TYPE_APPLE_GFX, 0x10000);
@@ -369,6 +375,16 @@ static void apple_gfx_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem_iosfc);
     sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_gfx);
     sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq_iosfc);
+
+    /* TODO: PVG framework supports serialising device state: integrate it! */
+    if (apple_gfx_mig_blocker == NULL) {
+        error_setg(&apple_gfx_mig_blocker,
+                  "Migration state blocked by apple-gfx display device");
+        r = migrate_add_blocker(&apple_gfx_mig_blocker, &local_err);
+        if (r < 0) {
+            error_report_err(local_err);
+        }
+    }
 }
 
 static void apple_gfx_realize(DeviceState *dev, Error **errp)
-- 
2.39.3 (Apple Git-146)


