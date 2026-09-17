Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FEDC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7D8B-0001ql-SG; Thu, 17 Sep 2026 10:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D82-0001nE-0R
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:22 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D7y-0007ex-Tq
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 935ACC097B;
 Thu, 17 Sep 2026 17:30:15 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b33::1:33])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id DUXfb20WRqM0-X5EaQAze; Thu, 17 Sep 2026 17:30:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789655415;
 bh=CtLpWH07Y8BwA6LCVWVsdqFQc/21RgOgfTEdimvuzC4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WDwchhRF+fG9qd8TTrHG8UNWvdlfPV2wYLCXffRkQrnsYi2J5jq64M5g4Sb+XjDqe
 sI9QAY9DwAOAuF/Ju/7/SWwxFeBVDlhfNZII0EzFrqgNh+Y8C+Ddu4r+Ab+/S9ey2t
 32wuyEpS7gSklJRra4fbZzZwp3ZcCOqWzxn3Qkcc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 2/8] vhost-user: introduce send_add_rem_mem_reg()
Date: Thu, 17 Sep 2026 17:30:05 +0300
Message-ID: <20260917143011.881361-3-vsementsov@yandex-team.ru>
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

Add a classic wrapper to send a protocol message. This simplifies
the logic a lot around vhost_user_add_remove_regions().

Feature: vhost-user-blk-fd-mig
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 111 +++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 49 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a10352016a5..8eaa65392a7 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -677,17 +677,61 @@ static inline bool reg_equal(struct vhost_memory_region *shadow_reg,
         shadow_reg->memory_size == vdev_reg->memory_size;
 }
 
+static int send_add_rem_mem_reg(struct vhost_dev *dev,
+                                struct vhost_memory_region *reg,
+                                bool add, uint64_t mmap_offset, int fd)
+{
+    int ret;
+    VhostUserMemoryRegion region_buffer;
+    bool reply_supported =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    VhostUserMsg msg = {
+        .hdr.flags = VHOST_USER_VERSION,
+    };
+    int *fds, fd_num;
+
+    msg.hdr.size = sizeof(msg.payload.mem_reg);
+
+    if (add) {
+        msg.hdr.request = VHOST_USER_ADD_MEM_REG;
+        fds = &fd;
+        fd_num = 1;
+    } else {
+        msg.hdr.request = VHOST_USER_REM_MEM_REG;
+        fds = NULL;
+        fd_num = 0;
+    }
+
+    if (reply_supported) {
+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    vhost_user_fill_msg_region(dev, &region_buffer, reg, mmap_offset);
+    msg.payload.mem_reg.region = region_buffer;
+
+    ret = vhost_user_write(dev, &msg, fds, fd_num);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (reply_supported) {
+        ret = process_message_reply(dev, &msg);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
 
 static int send_remove_regions(struct vhost_dev *dev,
                                struct scrub_regions *remove_reg,
-                               int nr_rem_reg, VhostUserMsg *msg,
-                               bool reply_supported)
+                               int nr_rem_reg)
 {
     struct vhost_user *u = dev->opaque;
     struct vhost_memory_region *shadow_reg;
     int i, fd, shadow_reg_idx, ret;
     ram_addr_t offset;
-    VhostUserMemoryRegion region_buffer;
 
     /*
      * The regions in remove_reg appear in the same order they do in the
@@ -701,21 +745,10 @@ static int send_remove_regions(struct vhost_dev *dev,
         vhost_user_get_mr_data(shadow_reg->userspace_addr, &offset, &fd);
 
         if (fd > 0) {
-            msg->hdr.request = VHOST_USER_REM_MEM_REG;
-            vhost_user_fill_msg_region(dev, &region_buffer, shadow_reg, 0);
-            msg->payload.mem_reg.region = region_buffer;
-
-            ret = vhost_user_write(dev, msg, NULL, 0);
+            ret = send_add_rem_mem_reg(dev, shadow_reg, false, 0, 0);
             if (ret < 0) {
                 return ret;
             }
-
-            if (reply_supported) {
-                ret = process_message_reply(dev, msg);
-                if (ret) {
-                    return ret;
-                }
-            }
         }
 
         /*
@@ -733,15 +766,12 @@ static int send_remove_regions(struct vhost_dev *dev,
 }
 
 static int send_add_regions(struct vhost_dev *dev,
-                            struct scrub_regions *add_reg, int nr_add_reg,
-                            VhostUserMsg *msg,
-                            bool reply_supported)
+                            struct scrub_regions *add_reg, int nr_add_reg)
 {
     struct vhost_user *u = dev->opaque;
     int i, fd, ret;
     struct vhost_memory_region *reg;
     ram_addr_t offset;
-    VhostUserMemoryRegion region_buffer;
 
     for (i = 0; i < nr_add_reg; i++) {
         reg = add_reg[i].region;
@@ -749,21 +779,10 @@ static int send_add_regions(struct vhost_dev *dev,
         vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
 
         if (fd > 0) {
-            msg->hdr.request = VHOST_USER_ADD_MEM_REG;
-            vhost_user_fill_msg_region(dev, &region_buffer, reg, offset);
-            msg->payload.mem_reg.region = region_buffer;
-
-            ret = vhost_user_write(dev, msg, &fd, 1);
+            ret = send_add_rem_mem_reg(dev, reg, true, offset, fd);
             if (ret < 0) {
                 return ret;
             }
-
-            if (reply_supported) {
-                ret = process_message_reply(dev, msg);
-                if (ret) {
-                    return ret;
-                }
-            }
         }
 
         /*
@@ -784,9 +803,7 @@ static int send_add_regions(struct vhost_dev *dev,
     return 0;
 }
 
-static int vhost_user_add_remove_regions(struct vhost_dev *dev,
-                                         VhostUserMsg *msg,
-                                         bool reply_supported)
+static int vhost_user_add_remove_regions(struct vhost_dev *dev)
 {
     struct vhost_user *u = dev->opaque;
     struct scrub_regions add_reg[VHOST_USER_MAX_RAM_SLOTS];
@@ -798,8 +815,6 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
     int i, j, add_idx = 0, rm_idx = 0;
     bool matching;
 
-    msg->hdr.size = sizeof(msg->payload.mem_reg);
-
     /* Ensure nregions fits the fixed-size arrays used below. */
     assert(dev->mem->nregions <= VHOST_USER_MAX_RAM_SLOTS);
 
@@ -857,16 +872,14 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
     nr_add_reg = add_idx;
 
     if (nr_rem_reg) {
-        ret = send_remove_regions(dev, rem_reg, nr_rem_reg, msg,
-                                  reply_supported);
+        ret = send_remove_regions(dev, rem_reg, nr_rem_reg);
         if (ret < 0) {
             return ret;
         }
     }
 
     if (nr_add_reg) {
-        ret = send_add_regions(dev, add_reg, nr_add_reg, msg,
-                               reply_supported);
+        ret = send_add_regions(dev, add_reg, nr_add_reg);
         if (ret < 0) {
             return ret;
         }
@@ -1006,20 +1019,20 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         return vhost_user_set_mem_table_postcopy(dev, mem, config_mem_slots);
     }
 
-    VhostUserMsg msg = {
-        .hdr.flags = VHOST_USER_VERSION,
-    };
-
-    if (reply_supported) {
-        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
-    }
-
     if (config_mem_slots) {
-        ret = vhost_user_add_remove_regions(dev, &msg, reply_supported);
+        ret = vhost_user_add_remove_regions(dev);
         if (ret < 0) {
             return ret;
         }
     } else {
+        VhostUserMsg msg = {
+            .hdr.flags = VHOST_USER_VERSION,
+        };
+
+        if (reply_supported) {
+            msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+        }
+
         ret = vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
                                                 false);
         if (ret < 0) {
-- 
2.43.0


