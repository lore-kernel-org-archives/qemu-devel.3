Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9959C982D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7D8A-0001qI-QD; Thu, 17 Sep 2026 10:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D83-0001oQ-PR
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:25 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D80-0007fz-66
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id CFB34C0A2B;
 Thu, 17 Sep 2026 17:30:18 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b33::1:33])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id DUXfb20WRqM0-lCITyc2b; Thu, 17 Sep 2026 17:30:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789655418;
 bh=jXtNyScx3RS9/pxq7vM9HasQv8AbMFT+TjkQxTj1mVU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=hL3Ta1mFQA4EAUXPmSaidy5IiwMvkZp2uWarXf3StwCSJw7FUA00a+HWdq16dfb+D
 AXhchsndmFEagnmwrcViAAXqA1t5G+Jajw+oBNGtK5h34+SNcRdIuZ94yLTib3XDG3
 NUqXVwrJnc+IU6s1t1xql9mI9hMss0GombZ3O4JM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 8/8] vhost-user: stop store userspace_addr for shadow when GPA
 negotiated
Date: Thu, 17 Sep 2026 17:30:11 +0300
Message-ID: <20260917143011.881361-9-vsementsov@yandex-team.ru>
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

This make the logic clear, that we don't need and don't use
userspace address when GPA negotiated. This helps to introduce
vhost-user local migration later (as we can't migrate userspace
addresses).

Feature: vhost-user-blk-fd-mig
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e677f1bd05d..4a29bb77dc9 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -325,7 +325,12 @@ static VhostUserMsg m __attribute__ ((unused));
 typedef struct VhostShadowRegion {
     uint64_t guest_phys_addr;
     uint64_t memory_size; /* bytes */
-    uint64_t userspace_addr;
+    /*
+     * @userspace_addr_or_zero is unused and must be zero
+     * when vhost_user_gpa_addresses(). Otherwise, it's
+     * a userspace address, sent to backend.
+     */
+    uint64_t userspace_addr_or_zero;
     QLIST_ENTRY(VhostShadowRegion) next;
 } VhostShadowRegion;
 
@@ -627,7 +632,8 @@ static void vhost_user_fill_rem_msg_region(struct vhost_dev *dev,
 
     assert(src != NULL && dst != NULL);
 
-    dst->userspace_addr = use_phys ? src->guest_phys_addr : src->userspace_addr;
+    dst->userspace_addr =
+        use_phys ? src->guest_phys_addr : src->userspace_addr_or_zero;
     dst->memory_size = src->memory_size;
     dst->guest_phys_addr = src->guest_phys_addr;
     dst->mmap_offset = 0;
@@ -689,11 +695,15 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
     return 0;
 }
 
-static inline bool reg_equal(VhostShadowRegion *shadow_reg,
+static inline bool reg_equal(struct vhost_dev *dev,
+                             VhostShadowRegion *shadow_reg,
                              struct vhost_memory_region *vdev_reg)
 {
+    bool use_phys = vhost_user_gpa_addresses(dev);
+
     return shadow_reg->guest_phys_addr == vdev_reg->guest_phys_addr &&
-        shadow_reg->userspace_addr == vdev_reg->userspace_addr &&
+        (use_phys ||
+         shadow_reg->userspace_addr_or_zero == vdev_reg->userspace_addr) &&
         shadow_reg->memory_size == vdev_reg->memory_size;
 }
 
@@ -767,6 +777,7 @@ static int send_remove_region(struct vhost_dev *dev,
 static int send_add_region(struct vhost_dev *dev,
                            struct vhost_memory_region *reg)
 {
+    bool use_phys = vhost_user_gpa_addresses(dev);
     struct vhost_user *u = dev->opaque;
     int fd, ret;
     ram_addr_t offset;
@@ -791,7 +802,7 @@ static int send_add_region(struct vhost_dev *dev,
     new_reg = g_new(VhostShadowRegion, 1);
     *new_reg = (VhostShadowRegion) {
         .guest_phys_addr = reg->guest_phys_addr,
-        .userspace_addr = reg->userspace_addr,
+        .userspace_addr_or_zero = use_phys ? 0 : reg->userspace_addr,
         .memory_size = reg->memory_size,
     };
     QLIST_INSERT_HEAD(&u->shadow_regions, new_reg, next);
@@ -814,7 +825,7 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev)
         bool matching = false;
 
         for (i = 0; i < dev->mem->nregions; i++) {
-            if (reg_equal(shadow_reg, &dev->mem->regions[i])) {
+            if (reg_equal(dev, shadow_reg, &dev->mem->regions[i])) {
                 matching = true;
                 found[i] = true;
                 break;
-- 
2.43.0


