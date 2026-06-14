Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6567BCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBy-0005pQ-4r; Sun, 14 Jun 2026 15:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBx-0005iU-6Y
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBv-0002A1-90
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O5nKD/4fkDkbf90rlckX3ZpTPGbqwwxuPCnIOHWj7n0=;
 b=Zoc4MNJ2dbCO8e1P1PW6PAEjvBd0Ej7ER7xOwrhUH0H0r9CK9GYxgmi20gJmOGOHayxSch
 pyfq/xTULrm/MxCwqlfcLt9sgGvFVlUJvYkzLR/TXosx85M8yQ3Z4QUQDridxuRDeXisZA
 lvmP2fwBa9ZKsGYqqni+xyeMeLPCTPg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-EFjpZo8WMHqbcWE18byiLA-1; Sun, 14 Jun 2026 15:08:17 -0400
X-MC-Unique: EFjpZo8WMHqbcWE18byiLA-1
X-Mimecast-MFC-AGG-ID: EFjpZo8WMHqbcWE18byiLA_1781464096
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490ae016853so16990335e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464096; x=1782068896; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O5nKD/4fkDkbf90rlckX3ZpTPGbqwwxuPCnIOHWj7n0=;
 b=LNnIaXf+mnYzGXei9I7deiqr1kDqSItWIm/+z9mSAttff9wd11e912dSOFkTbL0T3/
 GCehpuyw7lPEWIcKNCrOhTWr3KdfLTP1aHen3Ktp8VlQHL6Eegw0KnDZqgsKkte+abcE
 6mNnpXZ2U/KZaieQQrK18q9/PM6JwAht0P5Qj5zhLkeped4PZSdZYXgoMXX1mZNcSXlB
 SSCScePvWezYpArX7A3pikOjfxoZG6apzwG0HSXVa5OuTAByNXoaHT01IEJzEjYF9d5h
 EFnz+br1A4svj8pUjAGhe6bW/zMr/3hTUBaIpqF+vdrYqGWrHf/34cR7rOidgrUCr6Xw
 /mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464096; x=1782068896;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5nKD/4fkDkbf90rlckX3ZpTPGbqwwxuPCnIOHWj7n0=;
 b=B2A03umubap6E8IFExtLpU2SOCXzMyE/ATWMCS+mv5slfubbiD6coQjrUOGbr6DWHr
 z87FIyXJT9N3Y6k4l+vhj1x7KJ5YV8tjAN5gSudLUa4UV8SYW178GjhqD7e0Yd3eAxaf
 PdfPV/qvrOa4HQ8g3JVFBhUXeyudBOWcYwHfxNwvk2nvK3ZVCBx/RnwK7VSX3vU5uL0J
 i+29tURk6vFm62S0L5Yq5VKZPn/YxFKHkVVZQExZ5QVH+dDHd7XkQ3HIrAkpne5WH2sX
 Iovi21Ub2LKqv3PNf+tduWykzl2RkcbcgOCw5GJZQvgDqJdqEoDyIMpBe6XX3ijivHD5
 nnbw==
X-Gm-Message-State: AOJu0YwM/7iVUOF7oRpUlQVVsf8m8ErFBoell3vPhUxvyhtRh4BfWLiP
 /y/T50Rw48Yhz13C3mCaNgidSSWeGjGDv8CbmhLBRT7j4RXCt6jyr6c+9QsdoLOg+f7sWTgRMpE
 J+VkXuNCGD4xPjro+SHy4hJ+EJC1P0mZQG363Kn9rkmB/DxZdXd8TTISgT6poBr1crHSDfz1bT0
 UAk5VsKduwQIacNO64FjwNmd/eKKmbILp1uQ==
X-Gm-Gg: Acq92OFS5jlz5ugdJfbrzHpXqegWpt7YqK8oNsjyvn1K8y10J4Bjw0i5FVY0AEEQ+SF
 leHXmzaP12VzR3l0+PRBSa//86skAvFNwR67kLFbPMQfV4B9ND0yZ9K72fZIixKQLboGlO87fKD
 woQ7O53mrQu0QUrpwoloC/EkMOEh0HWVLbamJTOyrnzFqy4yJtuJb2DsQ85y6roC7zlcVkSExm7
 ZNbaqgprNb71jnTeJqSWjD+t67Wh/QdjRY5m+mLGie0BDxfrcQdlomZMXG8NlGuDbZXATkuCMUY
 ijVjWQFxJqSh8zVJMoWN82THH8Gv9Slp/09DQNgzeLJqKz/0UQf9ZX2+ikvGX7Q4cPYEF+VbfGw
 08pfJf2ZcUKZ8YzUtBZC6ddalrGQhq0iBbyAKMHTd7IU=
X-Received: by 2002:a7b:c7d2:0:b0:490:c2a2:e91c with SMTP id
 5b1f17b1804b1-490ec521e1cmr104464225e9.34.1781464096080; 
 Sun, 14 Jun 2026 12:08:16 -0700 (PDT)
X-Received: by 2002:a7b:c7d2:0:b0:490:c2a2:e91c with SMTP id
 5b1f17b1804b1-490ec521e1cmr104463945e9.34.1781464095350; 
 Sun, 14 Jun 2026 12:08:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203d2449sm168759905e9.14.2026.06.14.12.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:15 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 058/106] vhost-user: add VHOST_USER_PROTOCOL_F_GPA_ADDRESSES
Message-ID: <be51b7177c9c7c6f1e2ff1b4cd250649e1d6dcaf.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Based-on: <20260206095258.894504-1-vsementsov@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420202032.714884-11-vsementsov@yandex-team.ru>
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
index 78ffb25d6b..15042c0f3c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -563,12 +563,22 @@ static MemoryRegion *vhost_user_get_mr_data(uint64_t addr, ram_addr_t *offset,
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
@@ -606,7 +616,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                 error_report("Failed preparing vhost-user memory table msg");
                 return -ENOBUFS;
             }
-            vhost_user_fill_msg_region(&region_buffer, reg, offset);
+            vhost_user_fill_msg_region(dev, &region_buffer, reg, offset);
             msg->payload.memory.regions[*fd_num] = region_buffer;
             fds[(*fd_num)++] = fd;
         } else if (track_ramblocks) {
@@ -752,7 +762,7 @@ static int send_remove_regions(struct vhost_dev *dev,
 
         if (fd > 0) {
             msg->hdr.request = VHOST_USER_REM_MEM_REG;
-            vhost_user_fill_msg_region(&region_buffer, shadow_reg, 0);
+            vhost_user_fill_msg_region(dev, &region_buffer, shadow_reg, 0);
             msg->payload.mem_reg.region = region_buffer;
 
             ret = vhost_user_write(dev, msg, NULL, 0);
@@ -813,7 +823,7 @@ static int send_add_regions(struct vhost_dev *dev,
                 u->region_rb[reg_idx] = mr->ram_block;
             }
             msg->hdr.request = VHOST_USER_ADD_MEM_REG;
-            vhost_user_fill_msg_region(&region_buffer, reg, offset);
+            vhost_user_fill_msg_region(dev, &region_buffer, reg, offset);
             msg->payload.mem_reg.region = region_buffer;
 
             ret = vhost_user_write(dev, msg, &fd, 1);
@@ -3151,4 +3161,6 @@ const VhostOps user_ops = {
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
MST


