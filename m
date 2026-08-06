Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018AAC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wryqc-0003NO-VB; Thu, 06 Aug 2026 10:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bea1e@proton.me>) id 1wryqb-0003N1-B8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:13:25 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bea1e@proton.me>) id 1wryqY-0004Jo-GG
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786025589; x=1786284789;
 bh=NXSHtW8qDc7wlfrB+vA2ibpKtjZ1ya1mtVcYJ4jDhDo=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=E3xO4gIF7mG/YLcPHKsMFCb7tXx1pCFuLXpxaloHVPX06pHftbA5Mnnq+t9VZogL2
 zKhk1tqf2XUE+91yDr0rIzkmzZx1bcTURiOqvppU1PS/J7npG1OZa+wEB6yRIiqn7i
 1JtVAgEzKMfbaX53XypjJsbznNKRM79uFGVA1paxqs5qUKS77tfvZ7WHfxEPuhvxCG
 hfeSZkseqx67Ie16u3WlLIdNFCBnFxjZ3cFwAUfBq+Swmc7bof15koXl6GXxIG7ddB
 otW8tdbATCz3AIRJJ7p1aSNEQ9jIdoaTXyBfh3y/VNyj1Fjfawrkm+cU21Dary0d1N
 rvNERQC0EupGA==
Date: Thu, 06 Aug 2026 14:13:04 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Feifan Qian <bea1e@proton.me>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2] vhost-user: check memory slot availability for SHMEM_MAP
Message-ID: <adxbWKsBtk0YwbByScxXPz9_l5M7DLI6q01STBcfJICPOvOkwk16HKnu70fpfLqv7GbZk8g6s1M8iRvWEL_ixEabh0jipIChe6sGp-fSSB8=@proton.me>
Feedback-ID: 93226294:user:proton
X-Pm-Message-ID: 8988a1035ba1feb76228ee663dfced85aeaf7a70
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249; envelope-from=bea1e@proton.me;
 helo=mail-08.mail-europe.com
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

SHMEM_MAP creates a separate RAM MemoryRegion for every mapping. It can
therefore make a vhost-user memory table exceed the number of slots
negotiated with the backend.

Reject a mapping before changing the memory topology if KVM or a vhost
backend has no unreserved slot left. Also validate each memory table
against the negotiated vhost-user limit as a final defense for mappings
that become visible in a later memory transaction.

Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
Signed-off-by: Feifan Qian <bea1e@proton.me>
---
Tested with an ASan/UBSan x86_64 build and a vhost-user backend that
filled the negotiated 512-slot memory table.  The next SHMEM_MAP request
was rejected and QEMU remained alive, with no sanitizer report.
qtest-x86_64/qos-test also passed all 134 subtests.

 hw/virtio/vhost-user.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2881cec72d..3673653f67 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -10,6 +10,7 @@

 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/mem/memory-device.h"
 #include "hw/virtio/virtio-dmabuf.h"
 #include "hw/virtio/virtio-qmp.h"
 #include "hw/virtio/vhost.h"
@@ -1126,6 +1127,13 @@ static int vhost_user_set_mem_table(struct vhost_dev=
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
@@ -1940,6 +1948,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev =
*dev,
     VhostUserMMap *vu_mmap =3D &payload->mmap;
     VirtioSharedMemoryMapping *existing;
     Error *local_err =3D NULL;
+    unsigned int reserved_memslots;
     int ret =3D 0;

     if (fd < 0) {
@@ -1980,6 +1989,15 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev=
 *dev,
         }
     }

+    reserved_memslots =3D memory_devices_get_reserved_memslots();
+    if ((kvm_enabled() &&
+         kvm_get_free_memslots() <=3D reserved_memslots) ||
+        vhost_get_free_memslots() <=3D reserved_memslots) {
+        error_report("No free memory slots for shared memory mapping");
+        ret =3D -ENOSPC;
+        goto send_reply;
+    }
+
     memory_region_transaction_begin();

     /* Create VirtioSharedMemoryMapping object */
--
2.43.0

