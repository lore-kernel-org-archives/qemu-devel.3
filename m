Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEA4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAg6-0007BS-PK; Wed, 12 Aug 2026 11:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAg4-0006sZ-0s
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAg1-000779-4y
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786547732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O5FFCa47ef/OZEWEx9f76qW3xxrL0nngPfnEebtktI0=;
 b=RdLGMPYdquzJJnwXwuPYrtTTCVoA+nyaxLwmVyJDs9wNyLxyiFx+xB8gAmb0ynnn4HHp/V
 GfslkPPbB/22BW2rLmuRBD0x/vtZQISDILvELnlkBH0cSH4xW2fEnYtrkDlGfp+r6N1EV+
 NTu1kkIgWqIPs2fmALk/G0JNj9cL4zI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-lCFtXSIHPEWKnqinpeV2og-1; Wed, 12 Aug 2026 11:15:31 -0400
X-MC-Unique: lCFtXSIHPEWKnqinpeV2og-1
X-Mimecast-MFC-AGG-ID: lCFtXSIHPEWKnqinpeV2og_1786547730
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso10743111cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786547730; x=1787152530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O5FFCa47ef/OZEWEx9f76qW3xxrL0nngPfnEebtktI0=;
 b=egh1tld8mEfqvNrcFj3epTF7Ao9jZKDWTP28zkyw0MFXccoTt0FpZHXiJ287JQgNMD
 nuya9/4HI5hokW27fpIh97CRtpLIPET05+DX7Q9S6yZee6n5N/e00SAMw8Kzc/gUO+Ds
 HrzwWDZUb571C83WCYl9Oup9+7HbWAbt2YI1nkgwAfNX7f1Ia60P6sDb1Z4yHbB20a2s
 t8RM5I1yokXDQrEWCun4tLp8QY0MXGyijBylMgDbAs+AWmPM0Hh2L+kN4VeEr17jFWnp
 oOBnlKHXQXulerHUe/fbNJ0o7WADi65bC/GPCbolRxkt3uoeiFLfWt+2UEkGuB/SgEOy
 gcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547730; x=1787152530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O5FFCa47ef/OZEWEx9f76qW3xxrL0nngPfnEebtktI0=;
 b=OUP11W588jdBNhB8NsNtPrdNQPAAYBOLfpjNjUL/s8DrQYsfCPHelUgD0hI/Lj1STl
 iatqZS8r0cO7Q+oi3HO3E3oCBVo3j/u62m7dAZM3EtDtckEgIZTf0vk7c2l1PxRQV0X+
 OJNJXHAmmQHUDFZ+ZqqJSheNbg7B5T/haJBkVQyNniQtZFQdOA1huTLuen+qbtxHL0gf
 3dN2TsCSxnQ6RNTfwTANwLrUKREtrutaRIfEE4Y12Cuw0K3pK+nukaK9/eBtjTM2Jdww
 J+0zN1U+8g3B1ruVNkA+W6kqv7aP8YwjrFLdgp9wPU3TyEQka88GgPF4nQ119BO2cfsF
 iMGA==
X-Gm-Message-State: AOJu0YwL+Bgw8LF7wOQ/bqC0eb9XTvgvhpkkeO99ziBpPOYDgI7saP9m
 l+cw6YMc5T/I3dvz1AW+yypEKEi/wh7dZG+Pkq5JrH7DMCR0wOtFNwoGUC5lA2T+kVimm6qf4OM
 rafx36Qwxtm8Af0M5lbcf6N5QVjojxDhIGGBy1ni+POylM5LVRacpGD67DrRilA2RrwLUM8G3sX
 jvWX8AOwVDQ8ziWQlr/kOVSN8tifLQ9JoX8jwNfQ==
X-Gm-Gg: AR+sD11ZZvzR0BEfjmPQ99Kheff1FcmqpvV2M/zHfp9pgrC/tMDR4GM4qcTliZ5MFzd
 lkR/+z4TTamqC1bEGnnaDIQ0rJE+9D/83ib8x90friaS7jFpmIMlzYuQKqZh7j8Rf7rVFALIN48
 gLJamwrSZOB5ponJlM853BoND2EofUVYrlniu0/4qwq8ZPA9NOqWQ/eqXU7tpx0rfMrHiccaF1L
 UG5LdPUlUfHGTeLN6Qk5vI0Lq6p3u5dE/Pu9XSU02S6jAjDOFj6//zR+6y+z4rrml2Kwmajyn64
 SEQornthvfmDUwPbEDxug8s6bxk3Y7HrDXiyAZqUf+qUCcRDkkqD25mcBzpgZqKFcQ==
X-Received: by 2002:a05:622a:598a:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52d646bad9dmr53597611cf.9.1786547730086; 
 Wed, 12 Aug 2026 08:15:30 -0700 (PDT)
X-Received: by 2002:a05:622a:598a:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52d646bad9dmr53596271cf.9.1786547729286; 
 Wed, 12 Aug 2026 08:15:29 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d948d6sm19552841cf.15.2026.08.12.08.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:15:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Julia Graham <jugraham@redhat.com>, Liu Gang <liugang24219@sangfor.com.cn>,
 Ding Hui <dinghui@sangfor.com.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/10] system/memory: Use qemu_ram_move() for directly
 accessible regions
Date: Wed, 12 Aug 2026 11:14:37 -0400
Message-ID: <20260812151444.2611689-5-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812151444.2611689-1-peterx@redhat.com>
References: <20260812151444.2611689-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

From: Gavin Shan <gshan@redhat.com>

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

Besides, this also fixes the issue of the unexpected frozen reception on
e1000 NIC in the scenario of DPDK due to the wrong Rx queue full indication
caused by the following memcpy(), which is turned to 3 consective 'strb'
instructions to the same location by glibc-2.24+ for aarch64. With this
applied, the syntax of one-byte store is strictly ensured by a one-byte
qatomic set.

  QEMU
  ====
  e1000_receive_iov
    pci_dma_write
      pci_dma_rw
        dma_memory_rw
          dma_memory_rw_relaxed
            address_space_rw
              address_space_write
                flatview_write
                  flatview_write_continue
                    flatview_write_continue_step
                      memcpy    # 3 consective 'strb' instructions

Reported-by: Julia Graham <jugraham@redhat.com>
Reported-by: Liu Gang <liugang24219@sangfor.com.cn>
Reported-by: Ding Hui <dinghui@sangfor.com.cn>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Peter Xu <peterx@redhat.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260728031731.286666-3-gshan@redhat.com
[peterx: remove src==dst check, fix doc, enhance comments, per PeterM, add R-b]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h   | 35 +++++++++++++++++++++++++++-
 hw/remote/vfio-user-obj.c |  4 ++--
 system/physmem.c          | 48 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 336d4e84a6..4de5bf2577 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2668,6 +2668,39 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
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
+ * Move @n bytes from @src to @dst, the memory areas may overlap. This
+ * provides the same semantics as memmove(), plus an additional stronger
+ * guarantee: if @n is 1, 2 or 4 or 8 bytes, and @src and @dst are both
+ * naturally aligned for that access size, then both the load and the store
+ * will be done as a single atomic access (with the semantics of
+ * qatomic_read() and qatomic_set()).
+ *
+ * This is the underlying function that we use to implement accesses by
+ * a guest vCPU or a device DMA operation to a ram block. The atomic
+ * guarantee is needed for two major cases: (A) When the ram block is
+ * backed by a PCI BAR passed through from a host device (and so it might
+ * be hardware registers that must be accessed exactly once at the right
+ * width); (B) When an emulated device updates a data structure shared in
+ * guest memory with guest software (e.g. a network device's set of tx and
+ * rx descriptor blocks), if a write to memory is accidentally performed
+ * multiple times then it can break the guest code when it busy polls the
+ * guest memory.
+ *
+ * We don't attempt to perform the exact access when it would be unaligned
+ * because this can't be done on all host architectures. Although this is
+ * strictly speaking not doing what would happen on real hardware, we don't
+ * think there are going to be situations where that matters in practice.
+ */
+void qemu_ram_move(void *dst, const void *src, size_t n);
+
 MemTxResult address_space_read_full(const AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, void *buf, hwaddr len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
@@ -2741,7 +2774,7 @@ MemTxResult address_space_read(const AddressSpace *as, hwaddr addr,
             mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
             if (len == l && memory_access_is_direct(mr, false, attrs)) {
                 ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-                memmove(buf, ptr, len);
+                qemu_ram_move(buf, ptr, len);
             } else {
                 result = flatview_read_continue(fv, addr, attrs, buf, len,
                                                 addr1, l, mr);
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
diff --git a/system/physmem.c b/system/physmem.c
index 2c42e365cb..2f37cbeb07 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3158,6 +3158,50 @@ void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
     invalidate_and_set_dirty(mr, addr, size);
 }
 
+void qemu_ram_move(void *dst, const void *src, size_t n)
+{
+    uintptr_t test, len;
+
+    if (n == 0) {
+        return;
+    }
+
+    /*
+     * Calculate "the lowest set bit" over @src, @dst and @n, result put
+     * into @len (which guarantees a power-of-two).  With that and the
+     * later check (len!=n), it makes sure that we will only do the atomic
+     * ops when:
+     *
+     * (1) @n is a power-of-two
+     * (2) @src and @dst addresses are both aligned to @n
+     */
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
@@ -3270,7 +3314,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
                                                false, true);
 
-        memmove(ram_ptr, buf, *l);
+        qemu_ram_move(ram_ptr, buf, *l);
         invalidate_and_set_dirty(mr, mr_addr, *l);
 
         return MEMTX_OK;
@@ -3363,7 +3407,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
                                                false, false);
 
-        memmove(buf, ram_ptr, *l);
+        qemu_ram_move(buf, ram_ptr, *l);
 
         return MEMTX_OK;
     }
-- 
2.54.0


