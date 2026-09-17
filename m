Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC0DC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7D8A-0001qG-TS; Thu, 17 Sep 2026 10:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D81-0001nB-JM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:21 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D7y-0007fD-Sg
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 9C650C0A03;
 Thu, 17 Sep 2026 17:30:16 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b33::1:33])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id DUXfb20WRqM0-0pBXwqeX; Thu, 17 Sep 2026 17:30:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789655416;
 bh=9QE9D3lTMKOnPjqRZYXLeS4RarnaWTjZlO8DhtdJJP0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lSoe7exIeAa0V+t/SI3mazwXLEOjBF5PeP3VPsVI8lBlMGMlqCqTAorGvGiQc4uyR
 t4xjyKknoMEMaNAOm41fRqMzjc49eskqi5z8qyU3orcYQPuav2wVyMYPPM4AWYm6cI
 4cGVprN7U8+Q7XKy3s8PZF7n+KnRe/Xr5dQgLGiE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 4/8] vhost-user: add send_add_region() and
 send_remove_region() helpers
Date: Thu, 17 Sep 2026 17:30:07 +0300
Message-ID: <20260917143011.881361-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917143011.881361-1-vsementsov@yandex-team.ru>
References: <20260917143011.881361-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Feature: vhost-user-blk-fd-mig
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 102 ++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 43 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 61208597c25..4492374eab0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -724,13 +724,66 @@ static int send_add_rem_mem_reg(struct vhost_dev *dev,
     return 0;
 }
 
+static int send_remove_region(struct vhost_dev *dev,
+                              int shadow_reg_idx)
+{
+    struct vhost_user *u = dev->opaque;
+    struct vhost_memory_region *shadow_reg = &u->shadow_regions[shadow_reg_idx];
+    int ret;
+
+    ret = send_add_rem_mem_reg(dev, shadow_reg, false, 0, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    memmove(&u->shadow_regions[shadow_reg_idx],
+            &u->shadow_regions[shadow_reg_idx + 1],
+            sizeof(struct vhost_memory_region) *
+            (u->num_shadow_regions - shadow_reg_idx - 1));
+    u->num_shadow_regions--;
+
+    return 0;
+}
+
+static int send_add_region(struct vhost_dev *dev,
+                           struct vhost_memory_region *reg)
+{
+    struct vhost_user *u = dev->opaque;
+    int fd, ret;
+    ram_addr_t offset;
+
+    vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
+    if (fd <= 0) {
+        return 0;
+    }
+
+    ret = send_add_rem_mem_reg(dev, reg, true, offset, fd);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /*
+     * At this point, we know the backend has mapped in the new
+     * region, if the region has a valid file descriptor.
+     *
+     * The region should now be added to the shadow table.
+     */
+    u->shadow_regions[u->num_shadow_regions].guest_phys_addr =
+        reg->guest_phys_addr;
+    u->shadow_regions[u->num_shadow_regions].userspace_addr =
+        reg->userspace_addr;
+    u->shadow_regions[u->num_shadow_regions].memory_size =
+        reg->memory_size;
+    u->num_shadow_regions++;
+
+    return 0;
+}
+
 static int send_remove_regions(struct vhost_dev *dev,
                                struct scrub_regions *remove_reg,
                                int nr_rem_reg)
 {
-    struct vhost_user *u = dev->opaque;
-    struct vhost_memory_region *shadow_reg;
-    int i, shadow_reg_idx, ret;
+    int i, ret;
 
     /*
      * The regions in remove_reg appear in the same order they do in the
@@ -738,23 +791,10 @@ static int send_remove_regions(struct vhost_dev *dev,
      * through remove_reg backwards.
      */
     for (i = nr_rem_reg - 1; i >= 0; i--) {
-        shadow_reg = remove_reg[i].region;
-        shadow_reg_idx = remove_reg[i].reg_idx;
-
-        ret = send_add_rem_mem_reg(dev, shadow_reg, false, 0, 0);
+        ret = send_remove_region(dev, remove_reg[i].reg_idx);
         if (ret < 0) {
             return ret;
         }
-
-        /*
-         * At this point we know the backend has unmapped the region. It is now
-         * safe to remove it from the shadow table.
-         */
-        memmove(&u->shadow_regions[shadow_reg_idx],
-                &u->shadow_regions[shadow_reg_idx + 1],
-                sizeof(struct vhost_memory_region) *
-                (u->num_shadow_regions - shadow_reg_idx - 1));
-        u->num_shadow_regions--;
     }
 
     return 0;
@@ -763,37 +803,13 @@ static int send_remove_regions(struct vhost_dev *dev,
 static int send_add_regions(struct vhost_dev *dev,
                             struct scrub_regions *add_reg, int nr_add_reg)
 {
-    struct vhost_user *u = dev->opaque;
-    int i, fd, ret;
-    struct vhost_memory_region *reg;
-    ram_addr_t offset;
+    int i, ret;
 
     for (i = 0; i < nr_add_reg; i++) {
-        reg = add_reg[i].region;
-
-        vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
-        if (fd <= 0) {
-            continue;
-        }
-
-        ret = send_add_rem_mem_reg(dev, reg, true, offset, fd);
+        ret = send_add_region(dev, add_reg[i].region);
         if (ret < 0) {
             return ret;
         }
-
-        /*
-         * At this point, we know the backend has mapped in the new
-         * region, if the region has a valid file descriptor.
-         *
-         * The region should now be added to the shadow table.
-         */
-        u->shadow_regions[u->num_shadow_regions].guest_phys_addr =
-            reg->guest_phys_addr;
-        u->shadow_regions[u->num_shadow_regions].userspace_addr =
-            reg->userspace_addr;
-        u->shadow_regions[u->num_shadow_regions].memory_size =
-            reg->memory_size;
-        u->num_shadow_regions++;
     }
 
     return 0;
-- 
2.43.0


