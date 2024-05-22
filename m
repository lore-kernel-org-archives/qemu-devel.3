Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD04C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 05:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9eFd-0006QK-Kq; Wed, 22 May 2024 01:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1s9eFb-0006PN-N2
 for qemu-devel@nongnu.org; Wed, 22 May 2024 01:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1s9eFZ-0002XI-TN
 for qemu-devel@nongnu.org; Wed, 22 May 2024 01:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716354653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rm7JFyuekwYkGdiZNv6/FbnOeDGJ/2t3JnDhFmq8++8=;
 b=faNeOUGaPUjc79XmR3VPXjTb7KdM5WZ7iQFKWmMm5dxIv6QwlTChlmTgmFa4BaVe++0bT8
 itBQERtFJiEgY9KVvsjiyKO2bkXJrGEnKUSz/cdMdd+bUr6GRMXIeiALfjc6eFt3fEmNbw
 A5DUbHfuIJ1u+syxDKX/kKcFmyG1wbQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-hE1NQZIrOuOS6ZVB-yAiUA-1; Wed,
 22 May 2024 01:10:49 -0400
X-MC-Unique: hE1NQZIrOuOS6ZVB-yAiUA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C1873806739;
 Wed, 22 May 2024 05:10:49 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B55B240004D;
 Wed, 22 May 2024 05:10:46 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] virtio-pci: Fix the use of an uninitialized irqfd.
Date: Wed, 22 May 2024 13:10:24 +0800
Message-ID: <20240522051042.985825-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The crash was reported in MAC OS and NixOS, here is the link for this bug
https://gitlab.com/qemu-project/qemu/-/issues/2334
https://gitlab.com/qemu-project/qemu/-/issues/2321

The root cause is that the function virtio_pci_set_guest_notifiers() only
initializes the irqfd when the use_guest_notifier_mask and guest_notifier_mask
are set.
However, this check is missing in virtio_pci_set_vector().
So the fix is to add this check.

This fix is verified in vyatta,MacOS,NixOS,fedora system.

The bt tree for this bug is:
Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7c817be006c0 (LWP 1269146)]
kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
817	    if (irqfd->users == 0) {
(gdb) thread apply all bt
...
Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
0  kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
1  kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:893
2  0x00005983657045e2 in memory_region_write_accessor () at ../qemu-9.0.0/system/memory.c:497
3  0x0000598365704ba6 in access_with_adjusted_size () at ../qemu-9.0.0/system/memory.c:573
4  0x0000598365705059 in memory_region_dispatch_write () at ../qemu-9.0.0/system/memory.c:1528
5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at ../qemu-9.0.0/system/physmem.c:2713
6  0x000059836570ba7d in flatview_write_continue () at ../qemu-9.0.0/system/physmem.c:2743
7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
8  0x000059836570bb76 in address_space_write () at ../qemu-9.0.0/system/physmem.c:2894
9  0x0000598365763afe in address_space_rw () at ../qemu-9.0.0/system/physmem.c:2904
10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
11 0x000059836576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel/kvm/kvm-accel-ops.c:50
12 0x0000598365926ca8 in qemu_thread_start () at ../qemu-9.0.0/util/qemu-thread-posix.c:541
13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6

Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
Cc: qemu-stable@nongnu.org

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/virtio-pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b1d02f4b3d..a7faee5b33 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1431,6 +1431,7 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
 {
     bool kvm_irqfd = (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
         msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
 
     if (new_vector == old_vector) {
         return;
@@ -1441,7 +1442,8 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
      * set, we need to release the old vector and set up the new one.
      * Otherwise just need to set the new vector on the device.
      */
-    if (kvm_irqfd && old_vector != VIRTIO_NO_VECTOR) {
+    if (kvm_irqfd && old_vector != VIRTIO_NO_VECTOR &&
+        vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
         kvm_virtio_pci_vector_release_one(proxy, queue_no);
     }
     /* Set the new vector on the device. */
@@ -1451,7 +1453,8 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
         virtio_queue_set_vector(vdev, queue_no, new_vector);
     }
     /* If the new vector changed need to set it up. */
-    if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR) {
+    if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR &&
+        vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
         kvm_virtio_pci_vector_use_one(proxy, queue_no);
     }
 }
-- 
2.43.0


