Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7620C53200
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 03:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woC0G-0000nX-Bg; Sun, 26 Jul 2026 23:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woC07-0000mt-4S
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 23:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woC05-0006TE-CM
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 23:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785122852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYn11vyCy6TCaFCUqhQ+iocYzDPUDip4Neds+TYO53U=;
 b=PxwQbQidN3Aw8BOdX1lroigQh/O/KUwoIG+seRp9wZbIvdypRSUyIVortf4NJ48a5GL0Y9
 uOJM5iq5O02DVoE2kPQFW2fFvc8iUqaEFnLJMdUeJ4GurOeHYmKA5O4YDOILyk39+J0Uz8
 vaoZ4QsrXpLUUBRyzm+QbcB2sa80swg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-71oG6kL5NM-X9-sxzZq6Hg-1; Sun,
 26 Jul 2026 23:27:28 -0400
X-MC-Unique: 71oG6kL5NM-X9-sxzZq6Hg-1
X-Mimecast-MFC-AGG-ID: 71oG6kL5NM-X9-sxzZq6Hg_1785122846
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C556180025F; Mon, 27 Jul 2026 03:27:25 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.50])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42F921955F75; Mon, 27 Jul 2026 03:27:16 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: [PATCH v4 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
Date: Mon, 27 Jul 2026 13:26:48 +1000
Message-ID: <20260727032649.145381-3-gshan@redhat.com>
In-Reply-To: <20260727032649.145381-1-gshan@redhat.com>
References: <20260727032649.145381-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This adds qemu_ram_move() where the aligned and small-sized accesses are
handled by qatomics, and fall back to memmove() otherwise. The memove()
for the directly accessible regions is replaced by qemu_ram_move() so that
the issue covered by commit 4a2e242bbb (MMIO access instructions were
optimized to SSE instructions) is fixed. This makes 'ram_device_mem_ops'
redundant, paving the way to revert that commit to make the ram device
region directly accessible again in the next patch.

Reported-by: Julia Graham <jugraham@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Peter Xu <peterx@redhat.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
v4: Unified qemu_ram_move() for all architectures where the qatomics are
    used for aligned and small-sized accesses, and fall back to memmove()
    otherwise. system/physmem.c::address_space_write_rom is removed from
    the listed sites.
---
 hw/remote/vfio-user-obj.c |  4 ++--
 include/system/memory.h   | 17 ++++++++++++++++-
 system/physmem.c          | 39 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index ea50270628..a0498d218f 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -375,9 +375,9 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
         ram_ptr = memory_region_get_ram_ptr(mr);
 
         if (is_write) {
-            memmove((ram_ptr + offset), buf, size);
+            qemu_ram_move((ram_ptr + offset), buf, size);
         } else {
-            memmove(buf, (ram_ptr + offset), size);
+            qemu_ram_move(buf, (ram_ptr + offset), size);
         }
 
         return 0;
diff --git a/include/system/memory.h b/include/system/memory.h
index d6ca431b6d..1a28f9b873 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2666,6 +2666,21 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
 void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
 
 /* Internal functions, part of the implementation of address_space_read.  */
+
+/**
+ * qemu_ram_move: move data from or to ramblock
+ *
+ * @dst: destination where the data is moved to
+ * @src: source where the data is moved from
+ * @n: length of data to be moved
+ *
+ * Move @n bytes from @src to @dst with the assumption that @src and @dst
+ * can overlap. The access is atomic if the source and destination buffer
+ * aren't overlapped for a well aligned and small-sized access. Otherwise,
+ * fall back to the standard memmove().
+ */
+void qemu_ram_move(void *dst, const void *src, size_t n);
+
 MemTxResult address_space_read_full(const AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, void *buf, hwaddr len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
@@ -2739,7 +2754,7 @@ MemTxResult address_space_read(const AddressSpace *as, hwaddr addr,
             mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
             if (len == l && memory_access_is_direct(mr, false, attrs)) {
                 ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-                memmove(buf, ptr, len);
+                qemu_ram_move(buf, ptr, len);
             } else {
                 result = flatview_read_continue(fv, addr, attrs, buf, len,
                                                 addr1, l, mr);
diff --git a/system/physmem.c b/system/physmem.c
index 2c42e365cb..18485f7b08 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3158,6 +3158,41 @@ void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
     invalidate_and_set_dirty(mr, addr, size);
 }
 
+void qemu_ram_move(void *dst, const void *src, size_t n)
+{
+    uintptr_t test, len;
+
+    if (src == dst || n == 0) {
+        return;
+    }
+
+    test = (uintptr_t)src | (uintptr_t)dst | n;
+    len = test & -test;
+
+    /* Overlapping buffers, unaligned or oversized access */
+    if (n > 8 || len != n) {
+        memmove(dst, src, n);
+        return;
+    }
+
+    switch (len) {
+    case 1:
+        qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
+        break;
+    case 2:
+        qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
+        break;
+    case 4:
+        qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
+        break;
+    case 8:
+        qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
 {
     unsigned access_size_max = mr->ops->valid.max_access_size;
@@ -3270,7 +3305,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
                                                false, true);
 
-        memmove(ram_ptr, buf, *l);
+        qemu_ram_move(ram_ptr, buf, *l);
         invalidate_and_set_dirty(mr, mr_addr, *l);
 
         return MEMTX_OK;
@@ -3363,7 +3398,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
                                                false, false);
 
-        memmove(buf, ram_ptr, *l);
+        qemu_ram_move(buf, ram_ptr, *l);
 
         return MEMTX_OK;
     }
-- 
2.55.0


