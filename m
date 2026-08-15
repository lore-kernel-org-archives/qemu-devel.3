Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786D8C5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 04:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wv5mO-0005nv-C5; Sat, 15 Aug 2026 00:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bea1e@proton.me>) id 1wv5mK-0005nV-Ey
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 00:13:53 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bea1e@proton.me>) id 1wv5mH-0006Ma-MK
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 00:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786767222; x=1787026422;
 bh=0tBD4UHfCIS+xD2u72G/Gyg7UWvz00WhOuoDQa5inkI=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=KQ8S8AS0DLAtFKH8IBROc3AjQXYF1d5yFzIe3yjApFs/mnMi/2i5VjoFqMAbkuJ4w
 6qMSdEC06ab44NeUsjdTq5NnDXkSERJIDZuc6jIkqh4eXHZSHeIinNu8+p+laIME83
 dmztQnXP56cxFJwC6E+3W8HVmZcW3tiuRzo+hR2Culbgy1XB+ijsErgvjnmD8N5jOr
 xQY2+xM7vEpfZqBMUXe14F1CcivwZi2fK9i5cbSEgP4mfd/WOZufB2r2YDAfyPzBuO
 N8wL+fnAUb7mrBSQBHcOWwkO8W0OcWF9OV5VZHLdCaAWkopS5oQrMI4MMUczeZ5876
 05fcEOJxik1/w==
Date: Sat, 15 Aug 2026 04:13:37 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Feifan Qian <bea1e@proton.me>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3] vhost-user: Reject SHMEM_MAP when no KVM memory slot is
 left
Message-ID: <HXrBMZ9Gx9L-VxdMEr26ORPUYQn99p4rgEYVkeMHA4-5M49Ax3_mx1euIWe7uj33nl5mZ19sZeUDyksqxKT7H1WPxWhYtxdomofcVTyMTjo=@proton.me>
Feedback-ID: 93226294:user:proton
X-Pm-Message-ID: 9ebbc2283cfd838f6c31dba93c532379d31cd75f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169; envelope-from=bea1e@proton.me;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Each SHMEM_MAP request creates a separate RAM MemoryRegion that
consumes a KVM memory slot. Once all KVM slots are in use, processing
another SHMEM_MAP request would make the KVM memory listener fail while
registering the new region.

Shared memory mappings are filtered out of the vhost memory table
(vhost_section() skips TYPE_VIRTIO_SHARED_MEMORY_MAPPING regions), so
they never count against the negotiated vhost-user slot limit; only
the KVM slot budget applies. Reject the request with ENOSPC before
changing the memory topology when KVM has no free slot left.

Also validate each vhost memory table against the slot limit negotiated
with the backend before sending regions via SET_MEM_TABLE or
ADD_MEM_REG.

Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
Signed-off-by: Feifan Qian <bea1e@proton.me>
---
Based-on: <20260717134920.265128-1-dbassey@redhat.com>
("vhost-user-gpu: Add blob resource and shared memory support" v4,
which filters TYPE_VIRTIO_SHARED_MEMORY_MAPPING regions out of
vhost_section())

v3:
- Rebased on Dorinda's series as suggested by Albert.
- SHMEM_MAP path now checks kvm_get_free_memslots() only; shmem
  mappings no longer reach SET_MEM_TABLE/ADD_MEM_REG, so the precheck
  no longer calls vhost_get_free_memslots() or uses reserved_memslots.
- Kept the set_mem_table check as a safety net for ADD_MEM_REG.

Tested with an ASan/UBSan x86_64 build on top of the base series.
qtest-x86_64/qos-test passed all 141 subtests.

 hw/virtio/vhost-user.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index fac02a1ffc..f737a05d07 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1126,6 +1126,13 @@ static int vhost_user_set_mem_table(struct vhost_dev=
 *dev,
             dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
     int ret;

+    if (mem->nregions > u->user->memory_slots) {
+        error_report("vhost-user memory table has %u regions, "
+                     "but the backend supports only %d",
+                     mem->nregions, u->user->memory_slots);
+        return -ENOSPC;
+    }
+
     if (do_postcopy) {
         /*
          * Postcopy has enough differences that it's best done in it's own
@@ -1980,6 +1987,17 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev=
 *dev,
         }
     }

+    /*
+     * Each SHMEM mapping becomes a separate RAM MemoryRegion and thus
+     * consumes a KVM memory slot. Reject the request before changing the
+     * memory topology if no slot is left.
+     */
+    if (kvm_enabled() && !kvm_get_free_memslots()) {
+        error_report("No free KVM memory slots for shared memory mapping")=
;
+        ret =3D -ENOSPC;
+        goto send_reply;
+    }
+
     /* Create VirtioSharedMemoryMapping object */
     VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_mapping_ne=
w(
         vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
--
2.43.0

