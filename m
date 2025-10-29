Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A268CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 18:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEBHz-0003Jk-DC; Wed, 29 Oct 2025 14:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vEBHw-0003JO-SG
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 14:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vEBHl-0008AV-E3
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 14:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761763951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9e/hObse3BAo5O3NWyShgmz3j/Vs/xAe45DGh6eVFeA=;
 b=Kso4m8E9WEz6S9FCSML7ZNo6/SwF1oWDaXgVtpms6WDYwlwmnjZ+D02uT37JcS4ZSU8meW
 jwZEIsh/ob1kEDcXd2pG1M1mdANLiYZSj9TtHRvEEUNMDeKF2aaKWHK8yXDYy1Blbpyk7s
 G3oCVOS+X1Ok7UsdhYeSQJ3toK0L+K4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-dpF7ytEwMoq7ThCPHvLeJw-1; Wed,
 29 Oct 2025 14:52:27 -0400
X-MC-Unique: dpF7ytEwMoq7ThCPHvLeJw-1
X-Mimecast-MFC-AGG-ID: dpF7ytEwMoq7ThCPHvLeJw_1761763947
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8E44195609D; Wed, 29 Oct 2025 18:52:26 +0000 (UTC)
Received: from localhost (unknown [10.2.17.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA37B30001A7; Wed, 29 Oct 2025 18:52:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peixiu Hou <phou@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] system/physmem: mark io_mem_unassigned lockless
Date: Wed, 29 Oct 2025 14:52:24 -0400
Message-ID: <20251029185224.420261-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

When the Bus Master bit is disabled in a PCI device's Command Register,
the device's DMA address space becomes unassigned memory (i.e. the
io_mem_unassigned MemoryRegion).

This can lead to deadlocks with IOThreads since io_mem_unassigned
accesses attempt to acquire the Big QEMU Lock (BQL). For example,
virtio-pci devices deadlock in virtio_write_config() ->
virtio_pci_stop_ioeventfd() when waiting for the IOThread while holding
the BQL. The IOThread is unable to acquire the BQL but the vcpu thread
won't release the BQL while waiting for the IOThread.

io_mem_unassigned is trivially thread-safe since it has no state, it
simply rejects all load/store accesses. Therefore it is safe to enable
lockless I/O on io_mem_unassigned to eliminate this deadlock.

Here is the backtrace described above:

  Thread 9 (Thread 0x7fccfcdff6c0 (LWP 247832) "CPU 4/KVM"):
  #0  0x00007fcd11529d46 in ppoll () from target:/lib64/libc.so.6
  #1  0x000056468a1a9bad in ppoll (__fds=<optimized out>, __nfds=<optimized out>, __timeout=0x0, __ss=0x0) at /usr/include/bits/poll2.h:88
  #2  0x000056468a18f9d9 in fdmon_poll_wait (ctx=0x5646c6a1dc30, ready_list=0x7fccfcdfb310, timeout=-1) at ../util/fdmon-poll.c:79
  #3  0x000056468a18f14f in aio_poll (ctx=<optimized out>, blocking=blocking@entry=true) at ../util/aio-posix.c:730
  #4  0x000056468a1ad842 in aio_wait_bh_oneshot (ctx=<optimized out>, cb=cb@entry=0x564689faa420 <virtio_blk_ioeventfd_stop_vq_bh>, opaque=<optimized out>) at ../util/aio-wait.c:85
  #5  0x0000564689faaa89 in virtio_blk_stop_ioeventfd (vdev=0x5646c8fd7e90) at ../hw/block/virtio-blk.c:1644
  #6  0x0000564689d77880 in virtio_bus_stop_ioeventfd (bus=bus@entry=0x5646c8fd7e08) at ../hw/virtio/virtio-bus.c:264
  #7  0x0000564689d780db in virtio_bus_stop_ioeventfd (bus=bus@entry=0x5646c8fd7e08) at ../hw/virtio/virtio-bus.c:256
  #8  0x0000564689d7d98a in virtio_pci_stop_ioeventfd (proxy=0x5646c8fcf8e0) at ../hw/virtio/virtio-pci.c:413
  #9  virtio_write_config (pci_dev=0x5646c8fcf8e0, address=4, val=<optimized out>, len=<optimized out>) at ../hw/virtio/virtio-pci.c:803
  #10 0x0000564689dcb45a in memory_region_write_accessor (mr=mr@entry=0x5646c6dc2d30, addr=3145732, value=value@entry=0x7fccfcdfb528, size=size@entry=2, shift=<optimized out>, mask=mask@entry=65535, attrs=...) at ../system/memory.c:491
  #11 0x0000564689dcaeb0 in access_with_adjusted_size (addr=addr@entry=3145732, value=value@entry=0x7fccfcdfb528, size=size@entry=2, access_size_min=<optimized out>, access_size_max=<optimized out>, access_fn=0x564689dcb3f0 <memory_region_write_accessor>, mr=0x5646c6dc2d30, attrs=...) at ../system/memory.c:567
  #12 0x0000564689dcb156 in memory_region_dispatch_write (mr=mr@entry=0x5646c6dc2d30, addr=addr@entry=3145732, data=<optimized out>, op=<optimized out>, attrs=attrs@entry=...) at ../system/memory.c:1554
  #13 0x0000564689dd389a in flatview_write_continue_step (attrs=..., attrs@entry=..., buf=buf@entry=0x7fcd05b87028 "", mr_addr=3145732, l=l@entry=0x7fccfcdfb5f0, mr=0x5646c6dc2d30, len=2) at ../system/physmem.c:3266
  #14 0x0000564689dd3adb in flatview_write_continue (fv=0x7fcadc0d8930, addr=3761242116, attrs=..., ptr=0xe0300004, len=2, mr_addr=<optimized out>, l=<optimized out>, mr=<optimized out>) at ../system/physmem.c:3296
  #15 flatview_write (fv=0x7fcadc0d8930, addr=addr@entry=3761242116, attrs=attrs@entry=..., buf=buf@entry=0x7fcd05b87028, len=len@entry=2) at ../system/physmem.c:3327
  #16 0x0000564689dd7191 in address_space_write (as=0x56468b433600 <address_space_memory>, addr=3761242116, attrs=..., buf=0x7fcd05b87028, len=2) at ../system/physmem.c:3447
  #17 address_space_rw (as=0x56468b433600 <address_space_memory>, addr=3761242116, attrs=attrs@entry=..., buf=buf@entry=0x7fcd05b87028, len=2, is_write=<optimized out>) at ../system/physmem.c:3457
  #18 0x0000564689ff1ef6 in kvm_cpu_exec (cpu=cpu@entry=0x5646c6dab810) at ../accel/kvm/kvm-all.c:3248
  #19 0x0000564689ff32f5 in kvm_vcpu_thread_fn (arg=arg@entry=0x5646c6dab810) at ../accel/kvm/kvm-accel-ops.c:53
  #20 0x000056468a19225c in qemu_thread_start (args=0x5646c6db6190) at ../util/qemu-thread-posix.c:393
  #21 0x00007fcd114c5b68 in start_thread () from target:/lib64/libc.so.6
  #22 0x00007fcd115364e4 in clone () from target:/lib64/libc.so.6

  Thread 3 (Thread 0x7fcd0503a6c0 (LWP 247825) "IO iothread1"):
  #0  0x00007fcd114c2d30 in __lll_lock_wait () from target:/lib64/libc.so.6
  #1  0x00007fcd114c8fe2 in pthread_mutex_lock@@GLIBC_2.2.5 () from target:/lib64/libc.so.6
  #2  0x000056468a192538 in qemu_mutex_lock_impl (mutex=0x56468b432e60 <bql>, file=0x56468a1e26a5 "../system/physmem.c", line=3198) at ../util/qemu-thread-posix.c:94
  #3  0x0000564689dc12e2 in bql_lock_impl (file=file@entry=0x56468a1e26a5 "../system/physmem.c", line=line@entry=3198) at ../system/cpus.c:566
  #4  0x0000564689ddc151 in prepare_mmio_access (mr=0x56468b433800 <io_mem_unassigned>) at ../system/physmem.c:3198
  #5  address_space_lduw_internal_cached_slow (cache=<optimized out>, addr=2, attrs=..., result=0x0, endian=DEVICE_LITTLE_ENDIAN) at ../system/memory_ldst.c.inc:211
  #6  address_space_lduw_le_cached_slow (cache=<optimized out>, addr=addr@entry=2, attrs=attrs@entry=..., result=result@entry=0x0) at ../system/memory_ldst.c.inc:253
  #7  0x0000564689fd692c in address_space_lduw_le_cached (result=0x0, cache=<optimized out>, addr=2, attrs=...) at /var/tmp/qemu/include/exec/memory_ldst_cached.h.inc:35
  #8  lduw_le_phys_cached (cache=<optimized out>, addr=2) at /var/tmp/qemu/include/exec/memory_ldst_phys.h.inc:66
  #9  virtio_lduw_phys_cached (vdev=<optimized out>, cache=<optimized out>, pa=2) at /var/tmp/qemu/include/hw/virtio/virtio-access.h:166
  #10 vring_avail_idx (vq=0x5646c8fe2470) at ../hw/virtio/virtio.c:396
  #11 virtio_queue_split_set_notification (vq=0x5646c8fe2470, enable=0) at ../hw/virtio/virtio.c:534
  #12 virtio_queue_set_notification (vq=0x5646c8fe2470, enable=0) at ../hw/virtio/virtio.c:595
  #13 0x000056468a18e7a8 in poll_set_started (ctx=ctx@entry=0x5646c6c74e30, ready_list=ready_list@entry=0x7fcd050366a0, started=started@entry=true) at ../util/aio-posix.c:247
  #14 0x000056468a18f2bb in poll_set_started (ctx=0x5646c6c74e30, ready_list=0x7fcd050366a0, started=true) at ../util/aio-posix.c:226
  #15 try_poll_mode (ctx=0x5646c6c74e30, ready_list=0x7fcd050366a0, timeout=<synthetic pointer>) at ../util/aio-posix.c:612
  #16 aio_poll (ctx=0x5646c6c74e30, blocking=blocking@entry=true) at ../util/aio-posix.c:689
  #17 0x000056468a032c26 in iothread_run (opaque=opaque@entry=0x5646c69f3380) at ../iothread.c:63
  #18 0x000056468a19225c in qemu_thread_start (args=0x5646c6c75410) at ../util/qemu-thread-posix.c:393
  #19 0x00007fcd114c5b68 in start_thread () from target:/lib64/libc.so.6
  #20 0x00007fcd115364e4 in clone () from target:/lib64/libc.so.6

Buglink: https://issues.redhat.com/browse/RHEL-71933
Reported-by: Peixiu Hou <phou@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 system/physmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index a340ca3e61..1dc2b46e12 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3011,6 +3011,9 @@ static void io_mem_init(void)
 {
     memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
                           NULL, UINT64_MAX);
+
+    /* Trivially thread-safe since memory accesses are rejected */
+    memory_region_enable_lockless_io(&io_mem_unassigned);
 }
 
 AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
-- 
2.51.0


