Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B4CC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 09:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbGdI-0003pK-Oq; Tue, 06 Aug 2024 05:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sbGdH-0003me-5b
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sbGdF-0003aA-JR
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722937049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y043/K7nB0ES738Ru7zyw3j7IHFLYkdCff8anvZ/cJo=;
 b=arBL6r3a4jNH4EKdLjgXs0bc3W/vyezwD7rhaCX6YM/fafuM5FdJrhsU7yiUSy851g637j
 Fi6SxmhoPRQjrXMAvnE9/zesSMwEJNlCIZtpfEzL5n0T/c/76i67IXvfYJ6Cta1GQj/xp0
 PJx2oHjFXmxjA/Kn5lkOavO1V1DpTWg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-5blphtULNFuPZyU5rOmJGw-1; Tue,
 06 Aug 2024 05:37:23 -0400
X-MC-Unique: 5blphtULNFuPZyU5rOmJGw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55BAD1955BED; Tue,  6 Aug 2024 09:37:22 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 401E21955F66; Tue,  6 Aug 2024 09:37:18 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH v6] virtio-pci: Fix the use of an uninitialized irqfd
Date: Tue,  6 Aug 2024 17:37:12 +0800
Message-ID: <20240806093715.65105-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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
---
 hw/virtio/virtio-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 592fdaa10f..dc31a37ec0 100644
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
2.45.0


