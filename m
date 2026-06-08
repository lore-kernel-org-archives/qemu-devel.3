Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62B5CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 00:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWNil-0004mw-77; Sun, 07 Jun 2026 20:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wWNij-0004mD-GZ
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 20:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wWNih-0004a2-Li
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 20:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780877998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5vaHIIQFViOS2iqOdyLp/QUUrpdLIRe+sbrKu+JL6xs=;
 b=IrZWSfyVHgMAm0nOmOt4+SXjmS3d7iX+7y4xPtKkJbiHKbguOIxRFfKmwdHjWvtZNBoLzM
 BfRCBMO4JsBSjjSRseW1AHQpczDW9pa1cl/DRjZ42XuQ/tF+7UR0JdbKWSREhBQ5Shzei0
 hsbAolLu0gbCk7dwNAngPaIEvhy8S9s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-MeEc67aQP7Ghu_Pt6rDX9Q-1; Sun,
 07 Jun 2026 20:18:37 -0400
X-MC-Unique: MeEc67aQP7Ghu_Pt6rDX9Q-1
X-Mimecast-MFC-AGG-ID: MeEc67aQP7Ghu_Pt6rDX9Q_1780877916
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCA6B18004A9; Mon,  8 Jun 2026 00:18:35 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D3BE1800480; Mon,  8 Jun 2026 00:18:31 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mst@redhat.com, jugraham@redhat.com,
 shan.gavin@gmail.com
Subject: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus parent
 if possible
Date: Mon,  8 Jun 2026 10:18:21 +1000
Message-ID: <20260608001821.850921-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On the guest where a NVidia's GH100 card is passed from the host, the
guest system hang can be observed on attempt to compile 'cuda-samples',
as reported by Julia.

   host$ lspci | grep GH100
   0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
   host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64 -accel kvm \
         -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
         -cpu host -smp cpus=32 -m size=8G                                  \
         -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
         -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
         -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0

   guest$ cd cuda-samples/build
   guest$ make -j 20 clean
   guest$ make -j 20
               :
   [ 54%] Linking CUDA executable graphMemoryNodes
   [ 54%] Built target graphMemoryNodes
   <no more output afterwards, guest becomes frozen here>

   guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
   [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)

When the GPU's driver (NVidia open driver) is loaded on guest bootup,
the memory blocks residing in the PCI BAR can be presented to the guest
through memory hot-add. The page cache can be allocated from the hot added
memory blocks when cuda-samples is being built. Afterwards, he page cache
is sent to QEMU's virtio-blk device as part of the DMA request, the bounce
buffer is used to accomodate the request as the corresponding memory
region (MemoryRegion) is a RAM DEVICE region in qemu. For this specific
case, false is returned from memory_access_is_direct() in the path where
the DMA request is handled.

  QEMU
  ====
  virtio_blk_handle_output
    virtio_blk_handle_vq
      virtio_blk_get_request
        virtqueue_pop
          virtqueue_split_pop
            virtqueue_map_desc
              address_space_map
                memory_access_is_direct         # Return false
                  memory_region_supports_direct_access

  (qemu) info mtree
          :
  memory-region: pci_bridge_pci
    0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
      0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
        0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
          0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]

By default, the max bounce buffer size is only 4096 bytes, even less
than one page when the guest page is 64KB. This tries to fix the issue
by inheriting the customized max bounce buffer size of the virtio bus's
parent through property 'x-max-bounce-buffer-size' when the customized
size is a larger one. With this applied, no guest system hang is seen
with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.

Reported-by: Julia Graham <jugraham@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/virtio/virtio-bus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index cef944e015..e0933823f3 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -42,6 +42,7 @@ do { printf("virtio_bus: " fmt , ## __VA_ARGS__); } while (0)
 /* A VirtIODevice is being plugged */
 void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
 {
+    AddressSpace *as;
     DeviceState *qdev = DEVICE(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(qdev));
     VirtioBusState *bus = VIRTIO_BUS(qbus);
@@ -100,6 +101,19 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
                 return;
             }
         }
+    } else {
+        /*
+         * The maximal bounce buffer size of the virtio bus's parent may
+         * have been customized by property 'x-max-bounce-buffer-size'.
+         * Lets inherit the customized size if it's larger than the
+         * current one.
+         */
+        as = klass->get_dma_as ? klass->get_dma_as(qbus->parent) : NULL;
+        if (as) {
+            vdev->dma_as->max_bounce_buffer_size = MAX(
+                    vdev->dma_as->max_bounce_buffer_size,
+                    as->max_bounce_buffer_size);
+        }
     }
 }
 
-- 
2.54.0


