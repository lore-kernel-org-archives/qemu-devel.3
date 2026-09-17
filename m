Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD84C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7D8D-0001rr-BU; Thu, 17 Sep 2026 10:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D83-0001np-0H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:23 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D7z-0007fZ-7v
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id C4429C0A28;
 Thu, 17 Sep 2026 17:30:17 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b33::1:33])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id DUXfb20WRqM0-uAtyFnSS; Thu, 17 Sep 2026 17:30:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789655417;
 bh=3qqJClZdklWOU1cccdd9+lFLgjYbdoraqMIJSg2ic1E=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qf5paGipxbe4PS7Um4iFmZWDF5MKiVKs6i4gsH7EAYfMYR6DgqtHUgSFXIGceb6X/
 i8qQ8ikesOmuCk74C2vm6YQBkigfauzCi4RmcpcMmqtsHrqxFU3bygOqp5dSMHLvuz
 YZ9dSTenmnkF4Dqw0j3hO7bcsl6w9e3ZM5PD5RTA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 6/8] vhost-user: move to QLIST for shadow_regions
Date: Thu, 17 Sep 2026 17:30:09 +0300
Message-ID: <20260917143011.881361-7-vsementsov@yandex-team.ru>
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

And finally we get rid of extra intermediate
add/remove arrays.

Feature: vhost-user-blk-fd-mig
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 165 +++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 106 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 40f247a355e..100621a4329 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -322,6 +322,13 @@ static VhostUserMsg m __attribute__ ((unused));
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION    (0x1)
 
+typedef struct VhostShadowRegion {
+    uint64_t guest_phys_addr;
+    uint64_t memory_size; /* bytes */
+    uint64_t userspace_addr;
+    QLIST_ENTRY(VhostShadowRegion) next;
+} VhostShadowRegion;
+
 struct vhost_user {
     struct vhost_dev *dev;
     /* Shared between vhost devs of the same virtio device */
@@ -345,8 +352,7 @@ struct vhost_user {
     bool               postcopy_listen;
 
     /* Our current regions */
-    int num_shadow_regions;
-    struct vhost_memory_region shadow_regions[VHOST_USER_MAX_RAM_SLOTS];
+    QLIST_HEAD(, VhostShadowRegion) shadow_regions;
 
     /**
      * @protocol_features: the vhost-user protocol feature set by
@@ -613,6 +619,20 @@ static void vhost_user_fill_msg_region(struct vhost_dev *dev,
     dst->mmap_offset = mmap_offset;
 }
 
+static void vhost_user_fill_rem_msg_region(struct vhost_dev *dev,
+                                           VhostUserMemoryRegion *dst,
+                                           VhostShadowRegion *src)
+{
+    bool use_phys = vhost_user_gpa_addresses(dev);
+
+    assert(src != NULL && dst != NULL);
+
+    dst->userspace_addr = use_phys ? src->guest_phys_addr : src->userspace_addr;
+    dst->memory_size = src->memory_size;
+    dst->guest_phys_addr = src->guest_phys_addr;
+    dst->mmap_offset = 0;
+}
+
 static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                                              struct vhost_dev *dev,
                                              VhostUserMsg *msg,
@@ -669,7 +689,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
     return 0;
 }
 
-static inline bool reg_equal(struct vhost_memory_region *shadow_reg,
+static inline bool reg_equal(VhostShadowRegion *shadow_reg,
                              struct vhost_memory_region *vdev_reg)
 {
     return shadow_reg->guest_phys_addr == vdev_reg->guest_phys_addr &&
@@ -678,8 +698,9 @@ static inline bool reg_equal(struct vhost_memory_region *shadow_reg,
 }
 
 static int send_add_rem_mem_reg(struct vhost_dev *dev,
-                                struct vhost_memory_region *reg,
-                                bool add, uint64_t mmap_offset, int fd)
+                                struct vhost_memory_region *add_reg,
+                                VhostShadowRegion *rem_reg,
+                                uint64_t mmap_offset, int fd)
 {
     int ret;
     VhostUserMemoryRegion region_buffer;
@@ -690,23 +711,26 @@ static int send_add_rem_mem_reg(struct vhost_dev *dev,
     };
     int *fds, fd_num;
 
+    assert(!add_reg != !rem_reg);
+
     msg.hdr.size = sizeof(msg.payload.mem_reg);
 
-    if (add) {
+    if (add_reg) {
         msg.hdr.request = VHOST_USER_ADD_MEM_REG;
         fds = &fd;
         fd_num = 1;
+        vhost_user_fill_msg_region(dev, &region_buffer, add_reg, mmap_offset);
     } else {
         msg.hdr.request = VHOST_USER_REM_MEM_REG;
         fds = NULL;
         fd_num = 0;
+        vhost_user_fill_rem_msg_region(dev, &region_buffer, rem_reg);
     }
 
     if (reply_supported) {
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
-    vhost_user_fill_msg_region(dev, &region_buffer, reg, mmap_offset);
     msg.payload.mem_reg.region = region_buffer;
 
     ret = vhost_user_write(dev, &msg, fds, fd_num);
@@ -725,22 +749,17 @@ static int send_add_rem_mem_reg(struct vhost_dev *dev,
 }
 
 static int send_remove_region(struct vhost_dev *dev,
-                              int shadow_reg_idx)
+                              VhostShadowRegion *shadow_reg)
 {
-    struct vhost_user *u = dev->opaque;
-    struct vhost_memory_region *shadow_reg = &u->shadow_regions[shadow_reg_idx];
     int ret;
 
-    ret = send_add_rem_mem_reg(dev, shadow_reg, false, 0, 0);
+    ret = send_add_rem_mem_reg(dev, NULL, shadow_reg, 0, 0);
     if (ret < 0) {
         return ret;
     }
 
-    memmove(&u->shadow_regions[shadow_reg_idx],
-            &u->shadow_regions[shadow_reg_idx + 1],
-            sizeof(struct vhost_memory_region) *
-            (u->num_shadow_regions - shadow_reg_idx - 1));
-    u->num_shadow_regions--;
+    QLIST_REMOVE(shadow_reg, next);
+    g_free(shadow_reg);
 
     return 0;
 }
@@ -751,13 +770,14 @@ static int send_add_region(struct vhost_dev *dev,
     struct vhost_user *u = dev->opaque;
     int fd, ret;
     ram_addr_t offset;
+    VhostShadowRegion *new_reg;
 
     vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
     if (fd <= 0) {
         return 0;
     }
 
-    ret = send_add_rem_mem_reg(dev, reg, true, offset, fd);
+    ret = send_add_rem_mem_reg(dev, reg, NULL, offset, fd);
     if (ret < 0) {
         return ret;
     }
@@ -768,49 +788,13 @@ static int send_add_region(struct vhost_dev *dev,
      *
      * The region should now be added to the shadow table.
      */
-    u->shadow_regions[u->num_shadow_regions].guest_phys_addr =
-        reg->guest_phys_addr;
-    u->shadow_regions[u->num_shadow_regions].userspace_addr =
-        reg->userspace_addr;
-    u->shadow_regions[u->num_shadow_regions].memory_size =
-        reg->memory_size;
-    u->num_shadow_regions++;
-
-    return 0;
-}
-
-static int send_remove_regions(struct vhost_dev *dev,
-                               struct scrub_regions *remove_reg,
-                               int nr_rem_reg)
-{
-    int i, ret;
-
-    /*
-     * The regions in remove_reg appear in the same order they do in the
-     * shadow table. Therefore we can minimize memory copies by iterating
-     * through remove_reg backwards.
-     */
-    for (i = nr_rem_reg - 1; i >= 0; i--) {
-        ret = send_remove_region(dev, remove_reg[i].reg_idx);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-
-    return 0;
-}
-
-static int send_add_regions(struct vhost_dev *dev,
-                            struct scrub_regions *add_reg, int nr_add_reg)
-{
-    int i, ret;
-
-    for (i = 0; i < nr_add_reg; i++) {
-        ret = send_add_region(dev, add_reg[i].region);
-        if (ret < 0) {
-            return ret;
-        }
-    }
+    new_reg = g_new(VhostShadowRegion, 1);
+    *new_reg = (VhostShadowRegion) {
+        .guest_phys_addr = reg->guest_phys_addr,
+        .userspace_addr = reg->userspace_addr,
+        .memory_size = reg->memory_size,
+    };
+    QLIST_INSERT_HEAD(&u->shadow_regions, new_reg, next);
 
     return 0;
 }
@@ -818,26 +802,16 @@ static int send_add_regions(struct vhost_dev *dev,
 static int vhost_user_add_remove_regions(struct vhost_dev *dev)
 {
     struct vhost_user *u = dev->opaque;
-    struct scrub_regions add_reg[VHOST_USER_MAX_RAM_SLOTS];
-    struct scrub_regions rem_reg[VHOST_USER_MAX_RAM_SLOTS];
-    int nr_add_reg, nr_rem_reg;
     int ret;
     bool found[VHOST_USER_MAX_RAM_SLOTS] = {};
-    struct vhost_memory_region *shadow_reg;
-    int i, j, add_idx = 0, rm_idx = 0;
+    VhostShadowRegion *shadow_reg, *next_reg;
+    int i, j;
     bool matching;
 
-    /* Ensure nregions fits the fixed-size arrays used below. */
+    /* Ensure nregions fits the fixed-size array used below. */
     assert(dev->mem->nregions <= VHOST_USER_MAX_RAM_SLOTS);
 
-    /*
-     * Find memory regions present in our shadow state which are not in
-     * the device's current memory state.
-     *
-     * Mark regions in both the shadow and device state as "found".
-     */
-    for (i = 0; i < u->num_shadow_regions; i++) {
-        shadow_reg = &u->shadow_regions[i];
+    QLIST_FOREACH_SAFE(shadow_reg, &u->shadow_regions, next, next_reg) {
         matching = false;
 
         for (j = 0; j < dev->mem->nregions; j++) {
@@ -848,47 +822,20 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev)
             }
         }
 
-        /*
-         * If the region was not found in the current device memory state
-         * create an entry for it in the removed list.
-         */
         if (!matching) {
-            rem_reg[rm_idx].region = shadow_reg;
-            rem_reg[rm_idx++].reg_idx = i;
+            ret = send_remove_region(dev, shadow_reg);
+            if (ret) {
+                return ret;
+            }
         }
     }
 
-    /*
-     * For regions not marked "found", create entries in the added list.
-     *
-     * Note their indexes in the device memory state and the indexes of their
-     * file descriptors.
-     */
     for (i = 0; i < dev->mem->nregions; i++) {
-        /*
-         * If the region was in both the shadow and device state we don't
-         * need to send a VHOST_USER_ADD_MEM_REG message for it.
-         */
         if (found[i]) {
             continue;
         }
 
-        add_reg[add_idx].region = &dev->mem->regions[i];
-        add_reg[add_idx].reg_idx = i;
-        add_idx++;
-    }
-    nr_rem_reg = rm_idx;
-    nr_add_reg = add_idx;
-
-    if (nr_rem_reg) {
-        ret = send_remove_regions(dev, rem_reg, nr_rem_reg);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-
-    if (nr_add_reg) {
-        ret = send_add_regions(dev, add_reg, nr_add_reg);
+        ret = send_add_region(dev, &dev->mem->regions[i]);
         if (ret < 0) {
             return ret;
         }
@@ -2450,6 +2397,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
     u = g_new0(struct vhost_user, 1);
     u->user = vus;
     u->dev = dev;
+    QLIST_INIT(&u->shadow_regions);
     dev->opaque = u;
 
     err = vhost_user_get_features(dev, &features);
@@ -2592,6 +2540,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
 static int vhost_user_backend_cleanup(struct vhost_dev *dev)
 {
     struct vhost_user *u;
+    VhostShadowRegion *shadow_reg;
 
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
@@ -2614,6 +2563,10 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
     g_free(u->region_rb_offset);
     u->region_rb_offset = NULL;
     u->region_rb_len = 0;
+    while ((shadow_reg = QLIST_FIRST(&u->shadow_regions))) {
+        QLIST_REMOVE(shadow_reg, next);
+        g_free(shadow_reg);
+    }
     g_free(u);
     dev->opaque = 0;
 
-- 
2.43.0


