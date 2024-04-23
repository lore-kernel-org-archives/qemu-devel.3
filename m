Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C739EC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnb-0006yK-0I; Tue, 23 Apr 2024 11:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnI-00057X-8B
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnG-0000L6-7X
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6tUwxNFvDwg2j+J2ayrByxDVV2OoEExUkjc4qnuWI2Y=;
 b=OAA/EBrJLEHsPvejD8JbIAknIO9bpzmJphhYG6liZVwRiuZvxoelnG8ctJuL3pkvZPXuTR
 3GemaGPDbekNV7H4FNcYDISd9WJrKJDDQmrm6daj3Dx8u4UhsOmyzAn5fmr1hVSUML2cKh
 obdAbcGwzRD3YODtIpoR8jQeobOBGAU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-8E4S23jwMU-scPmni7FpVg-1; Tue, 23 Apr 2024 11:10:48 -0400
X-MC-Unique: 8E4S23jwMU-scPmni7FpVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2DDE1049881;
 Tue, 23 Apr 2024 15:10:47 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A08F203397E;
 Tue, 23 Apr 2024 15:10:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chao Peng <chao.p.peng@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 55/63] kvm: handle KVM_EXIT_MEMORY_FAULT
Date: Tue, 23 Apr 2024 17:09:43 +0200
Message-ID: <20240423150951.41600-56-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chao Peng <chao.p.peng@linux.intel.com>

Upon an KVM_EXIT_MEMORY_FAULT exit, userspace needs to do the memory
conversion on the RAMBlock to turn the memory into desired attribute,
switching between private and shared.

Currently only KVM_MEMORY_EXIT_FLAG_PRIVATE in flags is valid when
KVM_EXIT_MEMORY_FAULT happens.

Note, KVM_EXIT_MEMORY_FAULT makes sense only when the RAMBlock has
guest_memfd memory backend.

Note, KVM_EXIT_MEMORY_FAULT returns with -EFAULT, so special handling is
added.

When page is converted from shared to private, the original shared
memory can be discarded via ram_block_discard_range(). Note, shared
memory can be discarded only when it's not back'ed by hugetlb because
hugetlb is supposed to be pre-allocated and no need for discarding.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Message-ID: <20240320083945.991426-13-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h   |  2 +
 accel/kvm/kvm-all.c    | 98 +++++++++++++++++++++++++++++++++++++-----
 accel/kvm/trace-events |  2 +
 3 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 217f3fe17ba..47f9e8be1b3 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -542,4 +542,6 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
 int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
 
+int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
+
 #endif
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f49b2b95b54..9eef2c64003 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2900,6 +2900,69 @@ static void kvm_eat_signals(CPUState *cpu)
     } while (sigismember(&chkset, SIG_IPI));
 }
 
+int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+{
+    MemoryRegionSection section;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+    RAMBlock *rb;
+    void *addr;
+    int ret = -1;
+
+    trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
+
+    if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
+        !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
+        return -1;
+    }
+
+    if (!size) {
+        return -1;
+    }
+
+    section = memory_region_find(get_system_memory(), start, size);
+    mr = section.mr;
+    if (!mr) {
+        return -1;
+    }
+
+    if (!memory_region_has_guest_memfd(mr)) {
+        error_report("Converting non guest_memfd backed memory region "
+                     "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
+                     start, size, to_private ? "private" : "shared");
+        goto out_unref;
+    }
+
+    if (to_private) {
+        ret = kvm_set_memory_attributes_private(start, size);
+    } else {
+        ret = kvm_set_memory_attributes_shared(start, size);
+    }
+    if (ret) {
+        goto out_unref;
+    }
+
+    addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
+    rb = qemu_ram_block_from_host(addr, false, &offset);
+
+    if (to_private) {
+        if (rb->page_size != qemu_real_host_page_size()) {
+            /*
+             * shared memory is backed by hugetlb, which is supposed to be
+             * pre-allocated and doesn't need to be discarded
+             */
+            goto out_unref;
+        }
+        ret = ram_block_discard_range(rb, offset, size);
+    } else {
+        ret = ram_block_discard_guest_memfd_range(rb, offset, size);
+    }
+
+out_unref:
+    memory_region_unref(mr);
+    return ret;
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     struct kvm_run *run = cpu->kvm_run;
@@ -2967,18 +3030,20 @@ int kvm_cpu_exec(CPUState *cpu)
                 ret = EXCP_INTERRUPT;
                 break;
             }
-            fprintf(stderr, "error: kvm run failed %s\n",
-                    strerror(-run_ret));
+            if (!(run_ret == -EFAULT && run->exit_reason == KVM_EXIT_MEMORY_FAULT)) {
+                fprintf(stderr, "error: kvm run failed %s\n",
+                        strerror(-run_ret));
 #ifdef TARGET_PPC
-            if (run_ret == -EBUSY) {
-                fprintf(stderr,
-                        "This is probably because your SMT is enabled.\n"
-                        "VCPU can only run on primary threads with all "
-                        "secondary threads offline.\n");
-            }
+                if (run_ret == -EBUSY) {
+                    fprintf(stderr,
+                            "This is probably because your SMT is enabled.\n"
+                            "VCPU can only run on primary threads with all "
+                            "secondary threads offline.\n");
+                }
 #endif
-            ret = -1;
-            break;
+                ret = -1;
+                break;
+            }
         }
 
         trace_kvm_run_exit(cpu->cpu_index, run->exit_reason);
@@ -3061,6 +3126,19 @@ int kvm_cpu_exec(CPUState *cpu)
                 break;
             }
             break;
+        case KVM_EXIT_MEMORY_FAULT:
+            trace_kvm_memory_fault(run->memory_fault.gpa,
+                                   run->memory_fault.size,
+                                   run->memory_fault.flags);
+            if (run->memory_fault.flags & ~KVM_MEMORY_EXIT_FLAG_PRIVATE) {
+                error_report("KVM_EXIT_MEMORY_FAULT: Unknown flag 0x%" PRIx64,
+                             (uint64_t)run->memory_fault.flags);
+                ret = -1;
+                break;
+            }
+            ret = kvm_convert_memory(run->memory_fault.gpa, run->memory_fault.size,
+                                     run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE);
+            break;
         default:
             ret = kvm_arch_handle_exit(cpu, run);
             break;
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index e8c52cb9e7a..681ccb667d6 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -31,3 +31,5 @@ kvm_cpu_exec(void) ""
 kvm_interrupt_exit_request(void) ""
 kvm_io_window_exit(void) ""
 kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index %d, system_even_type %"PRIu32
+kvm_convert_memory(uint64_t start, uint64_t size, const char *msg) "start 0x%" PRIx64 " size 0x%" PRIx64 " %s"
+kvm_memory_fault(uint64_t start, uint64_t size, uint64_t flags) "start 0x%" PRIx64 " size 0x%" PRIx64 " flags 0x%" PRIx64
-- 
2.44.0



