Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3BBC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4m1c-0005PY-6U; Thu, 10 Sep 2026 17:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lIA-0001Yr-5E
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lHk-0007la-E5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlDAI3aXlBUqmLElEAtno+7cNgJBmTJIFkfsvSTRx+s=;
 b=bQ9HCr+78d73SVFaeJ5WaH8S936Q3OQXpm9ORlJ8nqvq+bIjBagxq6r7pqfNRVKTgS4xig
 I4iVPx9hkoJc3bO/Db12+K+3Ta+VN3zm1nu6+SLTUh4+cpCm/lezpBg0lJ9c3m7fIzSKrx
 d9RY1OXngUDaSGFGJmOb9rdp0CC4p4M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Lv1bhQHoOZGd-T4FPlWkwA-1; Thu, 10 Sep 2026 16:13:01 -0400
X-MC-Unique: Lv1bhQHoOZGd-T4FPlWkwA-1
X-Mimecast-MFC-AGG-ID: Lv1bhQHoOZGd-T4FPlWkwA_1789071180
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so2224265e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071180; x=1789675980; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HlDAI3aXlBUqmLElEAtno+7cNgJBmTJIFkfsvSTRx+s=;
 b=NetmzmEUwvwizLNzf/CjhAUGxxXZr3IaggOFKBiL77WdKZfgcHXBBOAs0maJN+S3+Z
 zu8KozzwhTIFpt1rwzVI0ixIQU4wDc04VjL4Rxh7O9wpBlxu7yAexlqz+tvkwlyFQerO
 TiI4ympvnTKsgqZDFdx/+dEc/vpoTx6qfJ8LpAycM1D8q56UvMHR8vT3ZaxE+2hnfsfh
 R0KyFxk20BiBujOOUkNr1UlG0FG4RqBiE7GZ3Ta+V4ID94qn5UBzMotGQd2CvIt+f/vH
 9di0c4S2dJ4pFI4Qkk1XZ7eu+S7PzJQp8u2DbLSJ0ABIaf8LrF/ILejDc5swoAVjGttq
 ofcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071180; x=1789675980;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HlDAI3aXlBUqmLElEAtno+7cNgJBmTJIFkfsvSTRx+s=;
 b=YOBmj0QEw9dy+t27IVAYahM+mvlblfEqzTst6izu9mu4w4a4HaYf8tqGJ3WQz5Dqn+
 G1+kd/kIYuSLUCZEjc2m2/PBkRs5bUdi1kpLb/wWX6k6NnREBM5eiyZMsCvOwq0YHi3M
 f85LtK/cok9DVLcO/oJfgOXbuQEVSd8h2AMrBpgJ3cOh+XHCO/XcwV8bgTHrcx5Nw2DQ
 lncowznv3aQV/rp75l0qYe3Q1+jXpbpNpBW6MvPmFP4xZl/2zXAR2TrDVg0NXIGnJw4t
 faWJi672wxQB7DLRz+9aYXLFh5024/0Hw8KmvqGMsF5W7lfpk8qCt7PLJO7sC9gsa2aQ
 IvWg==
X-Gm-Message-State: AFuF++kk8OC1julmHKF6q/49eE5PoZADvsH/521X387C5uCv1t5eSBsi
 mf5hPQ+rSWCMvr839a9gXA+UcAyxFR7Ocov85zgtvJqimmVIxWaBTywMK3DCVVMyPl/Bl5SRF/I
 NUPhN/xVngzF40wU+6u+xOxFe0kVwbdkADpD/gfogx32kEdAXh06u8ozYmyBjea3rFMt52iCej9
 nDlu01Ql2aR0XhP8TEdwflM8/nhWcCM9DfwA==
X-Gm-Gg: AYBFou3zYz1HHp2mvZJ0zy2bpGr/DXYQChxBK9CxR9DLjTRbiOBuM2MiGgFblWxolkN
 5f1RU6V9at/OgcCsRAnh3JphSTirTmRwiCDphN0PuatLHsADEbE3T0UGfwbndqnW+Tn/AfKXZfd
 NEaYA01yHYtjP/tClH++JWQ4CYLD103kTle1fD9xNWUD2HkWweUIbCpPiaF+EBv2OwUDBmwQ2G9
 IW+Pg3nUN969tXZsUgQMAOUfWgmF8IOAtbCwgmijIw6p2dk3PGa/VooQnk3JJx1DhhQAJgOKISY
 A1Pe4V28H+6xTVM+96aVMRcKFP1pHCh5pehH0PEcrQP4qGlsDtEfsTmAp0Xj94ZC8RhYiYj9GvS
 BPoy/GyQ04tcIDv9H0PXuyFk=
X-Received: by 2002:a05:600c:3115:b0:49c:f89b:f82 with SMTP id
 5b1f17b1804b1-49e619f687dmr14055395e9.12.1789071179750; 
 Thu, 10 Sep 2026 13:12:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3115:b0:49c:f89b:f82 with SMTP id
 5b1f17b1804b1-49e619f687dmr14054375e9.12.1789071179143; 
 Thu, 10 Sep 2026 13:12:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62232cb7sm1135575e9.4.2026.09.10.13.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:58 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 36/90] vhost: Fix SHMEM_MAP transaction ordering and resulting
 deadlock
Message-ID: <741ace9011d65ed8a34eb9f941f6355515ffe74b.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Dorinda Bassey <dbassey@redhat.com>

Commit the memory region transaction before sending the SHMEM_MAP reply
so the KVM memory slot exists before the guest can access the mapped
region.

This moves the commit to while the backend is still blocked waiting for
the reply, which can trigger ADD_MEM_REG back to the backend and
deadlock. Filter shmem mapping regions out of vhost_section() by
checking the MR owner type to prevent this.

The explicit transaction begin/commit wrapping is dropped since
virtio_add_shmem_map() already commits via memory_region_add_subregion().
The unmap handler keeps the original ordering: reply before delete, so
the backend is unblocked before the transaction commit.

Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
Suggested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Albert Esteve <aesteve@redhat.com>
Tested-by: Albert Esteve <aesteve@redhat.com>
Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260717134920.265128-2-dbassey@redhat.com>
---
 hw/virtio/vhost-user.c | 20 ++------------------
 hw/virtio/vhost.c      | 10 ++++++++++
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2881cec72d..fac02a1ffc 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1980,8 +1980,6 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
         }
     }
 
-    memory_region_transaction_begin();
-
     /* Create VirtioSharedMemoryMapping object */
     VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
         vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
@@ -1989,7 +1987,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
 
     if (!mapping) {
         ret = -EFAULT;
-        goto send_reply_commit;
+        goto send_reply;
     }
 
     /* Add the mapping to the shared memory region */
@@ -1997,23 +1995,9 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
         error_report("Failed to add shared memory mapping");
         object_unref(OBJECT(mapping));
         ret = -EFAULT;
-        goto send_reply_commit;
+        goto send_reply;
     }
 
-send_reply_commit:
-    /* Send reply and commit after transaction started */
-    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
-        payload->u64 = !!ret;
-        hdr->size = sizeof(payload->u64);
-        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
-            error_report_err(local_err);
-            memory_region_transaction_commit();
-            return -EFAULT;
-        }
-    }
-    memory_region_transaction_commit();
-    return 0;
-
 send_reply:
     if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
         payload->u64 = !!ret;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index a81cd94f90..838b1da739 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
 {
     MemoryRegion *mr = section->mr;
 
+    /*
+     * Skip shmem mapping regions, they are managed via SHMEM_MAP/UNMAP.
+     * Including them triggers ADD_MEM_REG during the SHMEM_MAP transaction
+     * commit, deadlocking the backend.
+     */
+    if (object_dynamic_cast(memory_region_owner(mr),
+                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {
+        return false;
+    }
+
     if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
         uint8_t dirty_mask = memory_region_get_dirty_log_mask(mr);
         uint8_t handled_dirty;
-- 
MST


