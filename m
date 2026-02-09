Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A4EE7C708
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLrv-0000rs-Ba; Mon, 09 Feb 2026 02:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLri-0000nD-Rb
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:27 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrg-0004gV-G4
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:26 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 7F2538083A;
 Mon, 09 Feb 2026 10:39:19 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:129::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BdLXu72As8c0-g7lEMdI3; Mon, 09 Feb 2026 10:39:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770622758;
 bh=XAmPKftnRzjPjPUy+fdcodUISY/Fbko68AsWLmE4fYk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=EHIs9MA8iMb3Momd9y0Vdz1JbVENzw5hmeWdqtY44f5Qu5w/WgfqoTf3ek3Jbp3aW
 MLKr4BAeFU3hbtO9/3lCDtn0Ep2jy/wRIb4vzBceqcuGTs05PPjZYTuHDNPIXL771Q
 sDna7Xd24/Zg0Vv3703c+Zbq9v0DUILKhYoQwKQE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 10/10] vhost-user: add VHOST_USER_PROTOCOL_F_GPA_ADDRESSES
Date: Mon,  9 Feb 2026 10:39:07 +0300
Message-ID: <20260209073908.2125178-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
References: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Unlike the kernel, vhost-user backend knows nothing about QEMU's
userspace addresses. We can pass GPA instead and nothing changes.
Generally, vhost-user servers need these addresses only to calculate
offsets inside memory regions. Still, some servers (QEMU's internal
is one example) may do checks for passed addresses to be "userspace
addresses", for example check for non-zero. That's why we need
additional negotiation for the feature.

The benefit: this opens the doors for further implementation of
local migration (live-update) with passing open vhost-related FDs
through UNIX domain socket. This way the connection with backend is
kept live and untouched.

Without this change, we would have to communicate with backend to
inform it about UVA address changes, but it's better to simply use
more stable GPA numbers, which don't change after migration.

Additionally, the current implementation exposes QEMU's process
address space by passing UVA, which breaks ASLR. New protocol
feature avoids that.

Note, that we do nothing with backend messages and replies.
Frontends have to work with backends userspace addresses anyway,
because they come from userfaultfd.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/interop/vhost-user.rst    | 21 +++++++++++++++++----
 hw/virtio/vhost-user.c         | 22 +++++++++++++++++-----
 include/hw/virtio/vhost-user.h |  1 +
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 137c9f3669..8dcb030c53 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -164,8 +164,16 @@ A vring address description
 
 :log: a 64-bit guest address for logging
 
-Note that a ring address is an IOVA if ``VIRTIO_F_IOMMU_PLATFORM`` has
-been negotiated. Otherwise it is a user address.
+.. Note::
+   When ``VIRTIO_F_IOMMU_PLATFORM`` is negotiated, ring addresses are IOVAs.
+
+   Otherwise, when ``VHOST_USER_PROTOCOL_F_GPA_ADDRESSES`` is negotiated, the
+   ring addresses are guest physical addresses for frontend messages. That
+   does not apply to backend replies.
+
+   Finally, when neither ``VIRTIO_F_IOMMU_PLATFORM`` nor
+   ``VHOST_USER_PROTOCOL_F_GPA_ADDRESSES`` features are negotiated, ring
+   addresses are user virtual addresses.
 
 .. _memory_region_description:
 
@@ -180,7 +188,9 @@ Memory region description
 
 :size: a 64-bit size
 
-:user address: a 64-bit user address
+:user address: a 64-bit user address. When ``VHOST_USER_PROTOCOL_F_GPA_ADDRESSES``
+  is negotiated, this field contain guest physical address instead and must
+  duplicate ``guest address`` field.
 
 :mmap offset: a 64-bit offset where region starts in the mapped memory
 
@@ -252,7 +262,9 @@ An IOTLB message
 
 :size: a 64-bit size
 
-:user address: a 64-bit user address
+:user address: a 64-bit user address. When ``VHOST_USER_PROTOCOL_F_GPA_ADDRESSES``
+  is negotiated, this field contain guest physical address instead, except for
+  ``VHOST_USER_BACKEND_IOTLB_MSG``, where it's user address anyway.
 
 :permissions flags: an 8-bit value:
   - 0: No access
@@ -1063,6 +1075,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT           18
   #define VHOST_USER_PROTOCOL_F_DEVICE_STATE            19
   #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
+  #define VHOST_USER_PROTOCOL_F_GPA_ADDRESSES           21
 
 Front-end message types
 -----------------------
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2e58f38ac5..125b170c5b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -568,12 +568,22 @@ static MemoryRegion *vhost_user_get_mr_data(uint64_t addr, ram_addr_t *offset,
     return mr;
 }
 
-static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,
+static bool vhost_user_gpa_addresses(struct vhost_dev *dev)
+{
+    return vhost_user_has_protocol_feature(
+        dev, VHOST_USER_PROTOCOL_F_GPA_ADDRESSES);
+}
+
+static void vhost_user_fill_msg_region(struct vhost_dev *dev,
+                                       VhostUserMemoryRegion *dst,
                                        struct vhost_memory_region *src,
                                        uint64_t mmap_offset)
 {
+    bool use_phys = vhost_user_gpa_addresses(dev);
+
     assert(src != NULL && dst != NULL);
-    dst->userspace_addr = src->userspace_addr;
+
+    dst->userspace_addr = use_phys ? src->guest_phys_addr : src->userspace_addr;
     dst->memory_size = src->memory_size;
     dst->guest_phys_addr = src->guest_phys_addr;
     dst->mmap_offset = mmap_offset;
@@ -611,7 +621,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                 error_report("Failed preparing vhost-user memory table msg");
                 return -ENOBUFS;
             }
-            vhost_user_fill_msg_region(&region_buffer, reg, offset);
+            vhost_user_fill_msg_region(dev, &region_buffer, reg, offset);
             msg->payload.memory.regions[*fd_num] = region_buffer;
             fds[(*fd_num)++] = fd;
         } else if (track_ramblocks) {
@@ -757,7 +767,7 @@ static int send_remove_regions(struct vhost_dev *dev,
 
         if (fd > 0) {
             msg->hdr.request = VHOST_USER_REM_MEM_REG;
-            vhost_user_fill_msg_region(&region_buffer, shadow_reg, 0);
+            vhost_user_fill_msg_region(dev, &region_buffer, shadow_reg, 0);
             msg->payload.mem_reg.region = region_buffer;
 
             ret = vhost_user_write(dev, msg, NULL, 0);
@@ -818,7 +828,7 @@ static int send_add_regions(struct vhost_dev *dev,
                 u->region_rb[reg_idx] = mr->ram_block;
             }
             msg->hdr.request = VHOST_USER_ADD_MEM_REG;
-            vhost_user_fill_msg_region(&region_buffer, reg, offset);
+            vhost_user_fill_msg_region(dev, &region_buffer, reg, offset);
             msg->payload.mem_reg.region = region_buffer;
 
             ret = vhost_user_write(dev, msg, &fd, 1);
@@ -3154,4 +3164,6 @@ const VhostOps user_ops = {
         .vhost_supports_device_state = vhost_user_supports_device_state,
         .vhost_set_device_state_fd = vhost_user_set_device_state_fd,
         .vhost_check_device_state = vhost_user_check_device_state,
+        .vhost_phys_vring_addr = vhost_user_gpa_addresses,
+        .vhost_phys_iotlb_msg = vhost_user_gpa_addresses,
 };
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 0e576fc538..5ab70dab7e 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -34,6 +34,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     VHOST_USER_PROTOCOL_F_DEVICE_STATE = 19,
     VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT = 20,
+    VHOST_USER_PROTOCOL_F_GPA_ADDRESSES = 21,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
-- 
2.52.0


