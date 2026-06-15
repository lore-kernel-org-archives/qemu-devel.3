Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEE6CD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4A9-0000Fw-G5; Mon, 15 Jun 2026 06:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZ4A8-0000Fa-3p
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZ4A5-00008V-U6
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781517797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWvq31Zh1H2hKyGgJU+PYjypP4cxos7VLyfvMMTsWRU=;
 b=aloPWkFrH2aFXHboK4MkHIosH+GQDYH6aj/d7P0FyDF/LLf+uuTi3HH1NMA41BrvU5h8CD
 1OQ2PAmVHI2NOBx5pNE4PCggI/uXMl8IzbWCZmFtOyvZi3ReQlxlqGpvZNF6drSLtbLBeY
 kUSLGhTSoj32XVoRvzR8j6DceGe+OfI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-8MdvCU3zMRmxESAp_EahdQ-1; Mon,
 15 Jun 2026 06:03:13 -0400
X-MC-Unique: 8MdvCU3zMRmxESAp_EahdQ-1
X-Mimecast-MFC-AGG-ID: 8MdvCU3zMRmxESAp_EahdQ_1781517791
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E89A31805A06; Mon, 15 Jun 2026 10:03:10 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 451CD1954B00; Mon, 15 Jun 2026 10:03:01 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
Subject: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy,
 move}() in ram device region accessors
Date: Mon, 15 Jun 2026 20:01:58 +1000
Message-ID: <20260615100200.266968-2-gshan@redhat.com>
In-Reply-To: <20260615100200.266968-1-gshan@redhat.com>
References: <20260615100200.266968-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
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

All ram device regions were turned to be indirectly accessible by commit
4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
guest is started by the following command lines, with GH100 GPU card passed
from the host.

   host$ lspci | grep GH100
   0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
   host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64            \
         -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
         -accel kvm -cpu host -smp cpus=48 -m size=8G                       \
         -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
         -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
         -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
           :
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
the memory blocks residing in the PCI BAR#4 of the GH100 GPU card can
be presented to the guest through memory hot-add. The page cache can
then be allocated from the hot added memory blocks when cuda-samples
is being built. Afterwards, the page cache is sent to QEMU's virtio-blk
device as part of the DMA request, the bounce buffer has to be used to
accomodate the request as the corresponding memory region (MemoryRegion)
is an indirectly accessible ram device region in qemu. However, the max
bounce bufer size is only 4096 bytes by default and that is exhausted
quickly, leading to a reset on the virtio-blk device and frozen guest
eventually.

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
  memory-region: pci_bridge_pci
    0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
      0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
        0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
          0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]

This adds qemu_ram_{copy, move}() and replaces {memcpy, memmove}() with
them in the ram device memory region accessors, similar to what's done
in commit 4a2e242bbb so that the issue (MMIO access instructions were
optimized to SSE instructions) covered by that commit is fixed. This
makes 'ram_device_mem_ops' redundant, paving the way to revert that
commit to make ram device region directly accessible again in the next
patch.

Reported-by: Julia Graham <jugraham@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Peter Xu <peterx@redhat.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
v2: Rename address_space_{memcpy, memmove}() to qemu_ram_{copy, move}()
and move them to physmem.c and memory.h, the unaligned access is also
covered for all architectures except i386 and x86_64 as Richard suggested.
---
 hw/remote/vfio-user-obj.c |  4 +-
 include/system/memory.h   |  4 +-
 system/physmem.c          | 91 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 87fa7b6572..97a6c88780 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -375,9 +375,9 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
         ram_ptr = memory_region_get_ram_ptr(mr);
 
         if (is_write) {
-            memcpy((ram_ptr + offset), buf, size);
+            qemu_ram_copy(ram_ptr + offset, buf, size);
         } else {
-            memcpy(buf, (ram_ptr + offset), size);
+            qemu_ram_copy(buf, ram_ptr + offset, size);
         }
 
         return 0;
diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..5878727d09 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2897,6 +2897,8 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
 void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
 
 /* Internal functions, part of the implementation of address_space_read.  */
+void qemu_ram_copy(void *dest, const void *src, size_t n);
+void qemu_ram_move(void *dest, const void *src, size_t n);
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, void *buf, hwaddr len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
@@ -2970,7 +2972,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
             mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
             if (len == l && memory_access_is_direct(mr, false, attrs)) {
                 ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-                memcpy(buf, ptr, len);
+                qemu_ram_copy(buf, ptr, len);
             } else {
                 result = flatview_read_continue(fv, addr, attrs, buf, len,
                                                 addr1, l, mr);
diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf87573..7f98101612 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3160,6 +3160,90 @@ void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
     invalidate_and_set_dirty(mr, addr, size);
 }
 
+#if defined(__i386__) || defined(__x86_64__)
+#define HOST_UNALIGNED_MMIO_OK 1
+#else
+#define HOST_UNALIGNED_MMIO_OK 0
+#endif
+
+void qemu_ram_copy(void *dest, const void *src, size_t n)
+{
+    if (HOST_UNALIGNED_MMIO_OK) {
+        switch (n) {
+        case 1:
+            __builtin_memcpy(dest, src, 1);
+            break;
+        case 2:
+            __builtin_memcpy(dest, src, 2);
+            break;
+        case 4:
+            __builtin_memcpy(dest, src, 4);
+            break;
+        case 8:
+            __builtin_memcpy(dest, src, 8);
+            break;
+        default:
+            memcpy(dest, src, n);
+        }
+    } else {
+        uintptr_t test, lsb;
+
+        do {
+            test = (uintptr_t)dest | n;
+            lsb = test & -test;
+            switch (lsb) {
+            case 1:
+                *(uint8_t *)dest = *(uint8_t *)src;
+                src += 1;
+                dest += 1;
+                n -= 1;
+                break;
+            case 2:
+                *(uint16_t *)dest = *(uint16_t *)src;
+                src += 2;
+                dest += 2;
+                n -= 2;
+                break;
+            case 4:
+                *(uint32_t *)dest = *(uint32_t *)src;
+                src += 4;
+                dest += 4;
+                n -= 4;
+                break;
+            default:
+                *(uint64_t *)dest = *(uint64_t *)src;
+                src += 8;
+                dest += 8;
+                n -= 8;
+            }
+        } while (n != 0);
+    }
+}
+
+void qemu_ram_move(void *dest, const void *src, size_t n)
+{
+    if (HOST_UNALIGNED_MMIO_OK) {
+        switch (n) {
+        case 1:
+            __builtin_memmove(dest, src, 1);
+            break;
+        case 2:
+            __builtin_memmove(dest, src, 2);
+            break;
+        case 4:
+            __builtin_memmove(dest, src, 4);
+            break;
+        case 8:
+            __builtin_memmove(dest, src, 8);
+            break;
+        default:
+            memmove(dest, src, n);
+        }
+    } else {
+        qemu_ram_copy(dest, src, n);
+    }
+}
+
 int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
 {
     unsigned access_size_max = mr->ops->valid.max_access_size;
@@ -3272,7 +3356,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
                                                false, true);
 
-        memmove(ram_ptr, buf, *l);
+        qemu_ram_move(ram_ptr, buf, *l);
         invalidate_and_set_dirty(mr, mr_addr, *l);
 
         return MEMTX_OK;
@@ -3365,7 +3449,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
                                                false, false);
 
-        memcpy(buf, ram_ptr, *l);
+        qemu_ram_copy(buf, ram_ptr, *l);
 
         return MEMTX_OK;
     }
@@ -3503,8 +3587,7 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
             l = memory_access_size(mr, l, addr1);
         } else {
             /* ROM/RAM case */
-            void *ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-            memcpy(ram_ptr, buf, l);
+            qemu_ram_copy(qemu_map_ram_ptr(mr->ram_block, addr1), buf, l);
             invalidate_and_set_dirty(mr, addr1, l);
         }
         len -= l;
-- 
2.54.0


