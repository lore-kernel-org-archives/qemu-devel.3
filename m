Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C489C982D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7D85-0001oO-D4; Thu, 17 Sep 2026 10:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D81-0001nC-Km
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:21 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D7y-0007es-T0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id F2524C0933;
 Thu, 17 Sep 2026 17:30:14 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b33::1:33])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id DUXfb20WRqM0-qGjcvWIO; Thu, 17 Sep 2026 17:30:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789655414;
 bh=Xfkbyi87fRz5rDPa/M8HDUjZXHhRzlGN+HcbM3e2b4E=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dcRzPTnduTKIhRd9RlAXjw1O28PPhxFijTCn1Pf6i2HE512RyHvMmd694ySclC/mT
 i1VJfxmYRWaL5y6AkV4gCmwHCOnzwEHfGBq72NRa0n4pZAEB/VsC/1uzLWK2RYnPOM
 QyvkC03J4ynwjZ4glO4/uOVXgrWXrZWvfUXnM2Ow=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 1/8] vhost-user: inline scrub_shadow_regions() into the only
 caller
Date: Thu, 17 Sep 2026 17:30:04 +0300
Message-ID: <20260917143011.881361-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917143011.881361-1-vsementsov@yandex-team.ru>
References: <20260917143011.881361-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To simplify further refactoring.

Feature: vhost-user-blk-fd-mig
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 124 +++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 67 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index addbc59e704..a10352016a5 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -677,71 +677,6 @@ static inline bool reg_equal(struct vhost_memory_region *shadow_reg,
         shadow_reg->memory_size == vdev_reg->memory_size;
 }
 
-static void scrub_shadow_regions(struct vhost_dev *dev,
-                                 struct scrub_regions *add_reg,
-                                 int *nr_add_reg,
-                                 struct scrub_regions *rem_reg,
-                                 int *nr_rem_reg)
-{
-    struct vhost_user *u = dev->opaque;
-    bool found[VHOST_USER_MAX_RAM_SLOTS] = {};
-    struct vhost_memory_region *reg, *shadow_reg;
-    int i, j, add_idx = 0, rm_idx = 0;
-    bool matching;
-
-    /*
-     * Find memory regions present in our shadow state which are not in
-     * the device's current memory state.
-     *
-     * Mark regions in both the shadow and device state as "found".
-     */
-    for (i = 0; i < u->num_shadow_regions; i++) {
-        shadow_reg = &u->shadow_regions[i];
-        matching = false;
-
-        for (j = 0; j < dev->mem->nregions; j++) {
-            reg = &dev->mem->regions[j];
-
-            if (reg_equal(shadow_reg, reg)) {
-                matching = true;
-                found[j] = true;
-                break;
-            }
-        }
-
-        /*
-         * If the region was not found in the current device memory state
-         * create an entry for it in the removed list.
-         */
-        if (!matching) {
-            rem_reg[rm_idx].region = shadow_reg;
-            rem_reg[rm_idx++].reg_idx = i;
-        }
-    }
-
-    /*
-     * For regions not marked "found", create entries in the added list.
-     *
-     * Note their indexes in the device memory state and the indexes of their
-     * file descriptors.
-     */
-    for (i = 0; i < dev->mem->nregions; i++) {
-        reg = &dev->mem->regions[i];
-        /*
-         * If the region was in both the shadow and device state we don't
-         * need to send a VHOST_USER_ADD_MEM_REG message for it.
-         */
-        if (found[i]) {
-            continue;
-        }
-
-        add_reg[add_idx].region = reg;
-        add_reg[add_idx].reg_idx = i;
-        add_idx++;
-    }
-    *nr_rem_reg = rm_idx;
-    *nr_add_reg = add_idx;
-}
 
 static int send_remove_regions(struct vhost_dev *dev,
                                struct scrub_regions *remove_reg,
@@ -853,18 +788,73 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
                                          VhostUserMsg *msg,
                                          bool reply_supported)
 {
+    struct vhost_user *u = dev->opaque;
     struct scrub_regions add_reg[VHOST_USER_MAX_RAM_SLOTS];
     struct scrub_regions rem_reg[VHOST_USER_MAX_RAM_SLOTS];
     int nr_add_reg, nr_rem_reg;
     int ret;
+    bool found[VHOST_USER_MAX_RAM_SLOTS] = {};
+    struct vhost_memory_region *reg, *shadow_reg;
+    int i, j, add_idx = 0, rm_idx = 0;
+    bool matching;
 
     msg->hdr.size = sizeof(msg->payload.mem_reg);
 
     /* Ensure nregions fits the fixed-size arrays used below. */
     assert(dev->mem->nregions <= VHOST_USER_MAX_RAM_SLOTS);
 
-    /* Find the regions which need to be removed or added. */
-    scrub_shadow_regions(dev, add_reg, &nr_add_reg, rem_reg, &nr_rem_reg);
+    /*
+     * Find memory regions present in our shadow state which are not in
+     * the device's current memory state.
+     *
+     * Mark regions in both the shadow and device state as "found".
+     */
+    for (i = 0; i < u->num_shadow_regions; i++) {
+        shadow_reg = &u->shadow_regions[i];
+        matching = false;
+
+        for (j = 0; j < dev->mem->nregions; j++) {
+            reg = &dev->mem->regions[j];
+
+            if (reg_equal(shadow_reg, reg)) {
+                matching = true;
+                found[j] = true;
+                break;
+            }
+        }
+
+        /*
+         * If the region was not found in the current device memory state
+         * create an entry for it in the removed list.
+         */
+        if (!matching) {
+            rem_reg[rm_idx].region = shadow_reg;
+            rem_reg[rm_idx++].reg_idx = i;
+        }
+    }
+
+    /*
+     * For regions not marked "found", create entries in the added list.
+     *
+     * Note their indexes in the device memory state and the indexes of their
+     * file descriptors.
+     */
+    for (i = 0; i < dev->mem->nregions; i++) {
+        reg = &dev->mem->regions[i];
+        /*
+         * If the region was in both the shadow and device state we don't
+         * need to send a VHOST_USER_ADD_MEM_REG message for it.
+         */
+        if (found[i]) {
+            continue;
+        }
+
+        add_reg[add_idx].region = reg;
+        add_reg[add_idx].reg_idx = i;
+        add_idx++;
+    }
+    nr_rem_reg = rm_idx;
+    nr_add_reg = add_idx;
 
     if (nr_rem_reg) {
         ret = send_remove_regions(dev, rem_reg, nr_rem_reg, msg,
-- 
2.43.0


