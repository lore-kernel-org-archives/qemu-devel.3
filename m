Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F34C4450A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 01:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkXlW-0001Zu-Dt; Thu, 16 Jul 2026 21:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wkXlT-0001ZJ-5A
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 21:53:24 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wkXlJ-00029o-9A
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 21:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784253175; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=SSHr8TvCT7xeDPjBLGzUoDIlbiu1tCB3FhDjMALkW5g=;
 b=QEZ5ko/aqq4gZSbNMiDStf0PtZcg+7dToqBo4DP9vyAHMwicWjeLs8FJLONlymhy/5AALA1yz8gQuxSVJhVSL0+QH+0ideRySZPezQT4nSD0mNoBQrWbkgteySF2glyKcFR/B1YvWVf+qzHW9jPsUAhtMtXyz63KqIFWEstTzsY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0X7FeezJ_1784253173; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X7FeezJ_1784253173 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 17 Jul 2026 09:52:54 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 dmitry.osipenko@collabora.com, marcandre.lureau@redhat.com
Subject: [PATCH] virtio-gpu: use BIT() macro for scanout bitmask operations
Date: Fri, 17 Jul 2026 09:52:52 +0800
Message-ID: <20260717015252.25675-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The scanout_bitmask field is uint32_t, but all six bit operations used
the signed literal `1 << shift`.  When the shift count reaches 31 this
is undefined behavior (signed integer overflow).  Replace every
occurrence with the BIT() macro to perform an unsigned shift, which is
well-defined for all bit positions 0-31 and consistent with QEMU
bit-operation conventions.

No functional change; the result is already stored in a uint32_t, so
the generated code is identical on most platforms.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/display/virtio-gpu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index c20efe4fb9..cd07b70a05 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qemu/units.h"
 #include "qemu/iov.h"
 #include "system/cpus.h"
@@ -393,7 +394,7 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 
     res = virtio_gpu_find_resource(g, scanout->resource_id);
     if (res) {
-        res->scanout_bitmask &= ~(1 << scanout_id);
+        res->scanout_bitmask &= ~BIT(scanout_id);
     }
 
     qemu_console_set_surface(scanout->con, NULL);
@@ -411,7 +412,7 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
 
     if (res->scanout_bitmask) {
         for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-            if (res->scanout_bitmask & (1 << i)) {
+            if (res->scanout_bitmask & BIT(i)) {
                 virtio_gpu_disable_scanout(g, i);
             }
         }
@@ -577,7 +578,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
         QemuRect rect;
 
-        if (!(res->scanout_bitmask & (1 << i))) {
+        if (!(res->scanout_bitmask & BIT(i))) {
             continue;
         }
         scanout = &g->parent_obj.scanout[i];
@@ -611,10 +612,10 @@ void virtio_gpu_update_scanout(VirtIOGPU *g,
     scanout = &g->parent_obj.scanout[scanout_id];
     ores = virtio_gpu_find_resource(g, scanout->resource_id);
     if (ores) {
-        ores->scanout_bitmask &= ~(1 << scanout_id);
+        ores->scanout_bitmask &= ~BIT(scanout_id);
     }
 
-    res->scanout_bitmask |= (1 << scanout_id);
+    res->scanout_bitmask |= BIT(scanout_id);
     scanout->resource_id = res->resource_id;
     scanout->x = r->x;
     scanout->y = r->y;
@@ -1496,7 +1497,7 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
         if (scanout->cursor.resource_id) {
             update_cursor(g, &scanout->cursor);
         }
-        res->scanout_bitmask |= (1 << i);
+        res->scanout_bitmask |= BIT(i);
     }
 
     return 0;
-- 
2.50.1 (Apple Git-155)


