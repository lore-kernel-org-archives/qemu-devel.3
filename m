Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3F7CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGbA-0002rc-Fz; Wed, 24 Jun 2026 01:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wcGay-0001gm-U7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:56:21 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wcGav-0007JT-IX
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782280562; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=ofEdMY9zt99tdbxUiyYRHfOD4DlMcGw6BT6VQvKcGvo=;
 b=jpp3sfWXASU/J4e+DDnZfJIaGpPZqsS1MeWNcnnPQt5IZu+GNKaa7jsVVpPLuC6a8Tjgh4DJslPvNcv2m1Sr4bH8p3YzMy861MGoI1zD2Fp7hKRvPZ52vyZEkOapA+DU8wuMErjqM+Jw7BxejKuKl+z9jsR2mo5ykAAOUtr4m2w=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R251e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X5X3L9i_1782280560; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X5X3L9i_1782280560 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 24 Jun 2026 13:56:01 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: alex.bennee@linaro.org
Cc: mst@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 dmitry.osipenko@collabora.com, qemu-devel@nongnu.org
Subject: [PATCH 3/3] virtio-gpu: use unsigned shift for scanout bitmask
 operations
Date: Wed, 24 Jun 2026 13:55:57 +0800
Message-ID: <22d21cfbe4466c27e33e979717957f48673d4647.1782270919.git.guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1782270919.git.guobin@linux.alibaba.com>
References: <cover.1782270919.git.guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=guobin@linux.alibaba.com; helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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
occurrence with `1U << shift` to perform an unsigned shift, which is
well-defined for all bit positions 0-31.

No functional change; the result is already stored in a uint32_t, so
the generated code is identical on most platforms.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/display/virtio-gpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 88526051a9..9dfffa270a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -387,7 +387,7 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 
     res = virtio_gpu_find_resource(g, scanout->resource_id);
     if (res) {
-        res->scanout_bitmask &= ~(1 << scanout_id);
+        res->scanout_bitmask &= ~(1U << scanout_id);
     }
 
     qemu_console_set_surface(scanout->con, NULL);
@@ -405,7 +405,7 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
 
     if (res->scanout_bitmask) {
         for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-            if (res->scanout_bitmask & (1 << i)) {
+            if (res->scanout_bitmask & (1U << i)) {
                 virtio_gpu_disable_scanout(g, i);
             }
         }
@@ -571,7 +571,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
         QemuRect rect;
 
-        if (!(res->scanout_bitmask & (1 << i))) {
+        if (!(res->scanout_bitmask & (1U << i))) {
             continue;
         }
         scanout = &g->parent_obj.scanout[i];
@@ -605,10 +605,10 @@ void virtio_gpu_update_scanout(VirtIOGPU *g,
     scanout = &g->parent_obj.scanout[scanout_id];
     ores = virtio_gpu_find_resource(g, scanout->resource_id);
     if (ores) {
-        ores->scanout_bitmask &= ~(1 << scanout_id);
+        ores->scanout_bitmask &= ~(1U << scanout_id);
     }
 
-    res->scanout_bitmask |= (1 << scanout_id);
+    res->scanout_bitmask |= (1U << scanout_id);
     scanout->resource_id = res->resource_id;
     scanout->x = r->x;
     scanout->y = r->y;
@@ -1490,7 +1490,7 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
         if (scanout->cursor.resource_id) {
             update_cursor(g, &scanout->cursor);
         }
-        res->scanout_bitmask |= (1 << i);
+        res->scanout_bitmask |= (1U << i);
     }
 
     return 0;
-- 
2.50.1 (Apple Git-155)


