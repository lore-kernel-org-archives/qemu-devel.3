Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62401CE7B04
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smX01-0000oB-DR; Fri, 06 Sep 2024 07:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWzy-0000Jp-LS; Fri, 06 Sep 2024 07:19:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWzw-0008Lz-CY; Fri, 06 Sep 2024 07:19:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ACB5C8C4B1;
 Fri,  6 Sep 2024 14:12:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id ACC7813371A;
 Fri,  6 Sep 2024 14:13:28 +0300 (MSK)
Received: (nullmailer pid 353756 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Cindy Lu <lulu@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 64/69] virtio-pci: Fix the use of an uninitialized irqfd
Date: Fri,  6 Sep 2024 14:13:13 +0300
Message-Id: <20240906111324.353230-64-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Cindy Lu <lulu@redhat.com>

The crash was reported in MAC OS and NixOS, here is the link for this bug
https://gitlab.com/qemu-project/qemu/-/issues/2334
https://gitlab.com/qemu-project/qemu/-/issues/2321

In this bug, they are using the virtio_input device. The guest notifier was
not supported for this device, The function virtio_pci_set_guest_notifiers()
was not called, and the vector_irqfd was not initialized.

So the fix is adding the check for vector_irqfd in virtio_pci_get_notifier()

The function virtio_pci_get_notifier() can be used in various devices.
It could also be called when VIRTIO_CONFIG_S_DRIVER_OK is not set. In this situation,
the vector_irqfd being NULL is acceptable. We can allow the device continue to boot

If the vector_irqfd still hasn't been initialized after VIRTIO_CONFIG_S_DRIVER_OK
is set, it means that the function set_guest_notifiers was not called before the
driver started. This indicates that the device is not using the notifier.
At this point, we will let the check fail.

This fix is verified in vyatta,MacOS,NixOS,fedora system.

The bt tree for this bug is:
Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7c817be006c0 (LWP 1269146)]
kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
817         if (irqfd->users == 0) {
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
Message-Id: <20240806093715.65105-1-lulu@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit a8e63ff289d137197ad7a701a587cc432872d798)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e04218a9fb..389bab003f 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -860,6 +860,9 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy *proxy, int queue_no,
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     VirtQueue *vq;
 
+    if (!proxy->vector_irqfd && vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)
+        return -1;
+
     if (queue_no == VIRTIO_CONFIG_IRQ_IDX) {
         *n = virtio_config_get_guest_notifier(vdev);
         *vector = vdev->config_vector;
-- 
2.39.2


