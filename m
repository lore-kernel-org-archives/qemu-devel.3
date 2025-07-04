Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281F9C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbKY-0002Ix-Dw; Fri, 04 Jul 2025 03:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXbKW-0002Im-Rk
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 03:59:32 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXbKU-0000xl-59
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 03:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751615970; x=1783151970;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=h/yd3x62+ErzCjfz6VjlsW7DzyX0IY5tBB3jhhuP14Y=;
 b=E54YvNyEUEm+gwLnDvQpFbfXXNQvkzWxYk8M/ahRH9dbn8x9GGUdbmmW
 04nHtGLtgltIrPbKmqDyGfoah18WjfzetGfnPhd3xZy4qcYxTfhnrQ6uu
 LSJYVafMsMMoaSZ0KvugJ62cF5viYPeXRcSLKYHrjNLQ4jWbWi3AEqJJH
 HehkKEXb3srBhv5am2d/al2VPjHC8/0z7nOlYQh48rV8ajbkJg2nWKhOJ
 ktygubaga1jxbNWCDTeyLvFmyJDCEM1uPAaEklMQmHCXdwKg+4+X5tQ7b
 aIWSW0s4hFj1BqD4fCWK92oZ3CgupmdQ1bgf+8AVUeyHjMzvFqY/cvbOg Q==;
X-CSE-ConnectionGUID: L43nYgYpSyiWepk7FaqJvQ==
X-CSE-MsgGUID: DxhfyHfIS3u+rtLs7E0QvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53171239"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53171239"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 00:59:19 -0700
X-CSE-ConnectionGUID: YctiEbZmQMCJES7W1E/hZQ==
X-CSE-MsgGUID: rbERHeHpRDuVGDS98tCSWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154002583"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 04 Jul 2025 00:59:17 -0700
Date: Fri, 4 Jul 2025 16:20:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Kirill Martynov <stdcalllevi@yandex-team.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
Message-ID: <aGeO2zCKep7StDA8@intel.com>
References: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
 <3096f21e-d8dd-4434-afbd-ee2b56adb20f@intel.com>
 <6a18dfcc-1686-4e3e-8e0a-b96d7034f4ab@intel.com>
 <1d12e519-9f3c-41a0-90ff-8e4655000d21@intel.com>
 <09AD44D6-E381-46B0-9B86-B248EB9582D7@yandex-team.ru>
 <4985e648-6505-4321-8e3a-f987b9d03bde@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4985e648-6505-4321-8e3a-f987b9d03bde@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> yes, QEMU supports separate address space for SMM mode with KVM. It's just
> that QEMU doesn't connect it with the CPU address space.

Yes, you're right.

(But initially, it might have been intentional, as KVM's SMM address
space is global. It is consistent with the current KVM/memory interface.
Creating a separate CPUAddressSpace for each CPU would involve a lot of
redundant work.)

> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index a68485547d50..7d6f4a86d802 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -130,6 +130,8 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>   */
>  void cpu_address_space_destroy(CPUState *cpu, int asidx);
> 
> +void cpu_address_space_add(CPUState *cpu, AddressSpace *as);
> +

Instead of introducing a "redundant" interfaces, it's better to lift the
restrictions of cpu_address_space_init() on KVM and reuse it.  Moreover,
not explicitly setting asidx can be risky.

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index a68485547d50..e3c70ccb1ea0 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -106,6 +106,8 @@ size_t qemu_ram_pagesize_largest(void);
  * @asidx: integer index of this address space
  * @prefix: prefix to be used as name of address space
  * @mr: the root memory region of address space
+ * @as: the pre-created AddressSpace. If have, no need to
+ *      specify @mr.
  *
  * Add the specified address space to the CPU's cpu_ases list.
  * The address space added with @asidx 0 is the one used for the
@@ -117,10 +119,10 @@ size_t qemu_ram_pagesize_largest(void);
  * cpu->num_ases to the total number of address spaces it needs
  * to support.
  *
- * Note that with KVM only one address space is supported.
  */
 void cpu_address_space_init(CPUState *cpu, int asidx,
-                            const char *prefix, MemoryRegion *mr);
+                            const char *prefix, MemoryRegion *mr,
+                            AddressSpace *as);
 /**
  * cpu_address_space_destroy:
  * @cpu: CPU for which address space needs to be destroyed
diff --git a/system/physmem.c b/system/physmem.c
index ff0ca40222d3..15aedfb58055 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -776,16 +776,23 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
 #endif /* CONFIG_TCG */

 void cpu_address_space_init(CPUState *cpu, int asidx,
-                            const char *prefix, MemoryRegion *mr)
+                            const char *prefix, MemoryRegion *mr,
+                            AddressSpace *as)
 {
     CPUAddressSpace *newas;
-    AddressSpace *as = g_new0(AddressSpace, 1);
-    char *as_name;
+    AddressSpace *cpu_as;

-    assert(mr);
-    as_name = g_strdup_printf("%s-%d", prefix, cpu->cpu_index);
-    address_space_init(as, mr, as_name);
-    g_free(as_name);
+    if (!as) {
+        cpu_as = g_new0(AddressSpace, 1);
+        char *as_name;
+
+        assert(mr);
+        as_name = g_strdup_printf("%s-%d", prefix, cpu->cpu_index);
+        address_space_init(cpu_as, mr, as_name);
+        g_free(as_name);
+    } else {
+        cpu_as = as;
+    }

     /* Target code should have set num_ases before calling us */
     assert(asidx < cpu->num_ases);

     if (asidx == 0) {
         /* address space 0 gets the convenience alias */
-        cpu->as = as;
+        cpu->as = cpu_as;
     }

-    /* KVM cannot currently support multiple address spaces. */
-    assert(asidx == 0 || !kvm_enabled());
-
     if (!cpu->cpu_ases) {
         cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
         cpu->cpu_ases_count = cpu->num_ases;
@@ -805,12 +809,12 @@ void cpu_address_space_init(CPUState *cpu, int asidx,

     newas = &cpu->cpu_ases[asidx];
     newas->cpu = cpu;
-    newas->as = as;
+    newas->as = cpu_as;
     if (tcg_enabled()) {
         newas->tcg_as_listener.log_global_after_sync = tcg_log_global_after_sync;
         newas->tcg_as_listener.commit = tcg_commit;
         newas->tcg_as_listener.name = "tcg";
-        memory_listener_register(&newas->tcg_as_listener, as);
+        memory_listener_register(&newas->tcg_as_listener, cpu_as);
     }
 }

---

In this interface, whether to reuse the existing address space (@as
argument) or create a new one for the CPU depends on the maintainer's
final opinion anyway. If the choice is to reuse, as in the code above,
need to adjust other calling cases. If so, I suggest Kirill handle this
in a separate patch.

>  #include "kvm_i386.h"
> @@ -90,6 +91,12 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>          kvm_set_guest_phys_bits(cs);
>      }
> 
> +    for (int i = 0; i < kvm_state->nr_as; i++) {
> +        if (kvm_state->as[i].as) {
> +            cpu_address_space_add(cs, kvm_state->as[i].as);
> +        }
> +    }
> +

This will add smram twice, with the following cpu_address_space_add().

Why are all KVM as unconditionally added to each CPU?

Another issue is the SMM AS index would be "unknown"...

>      return true;
>  }
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 234878c613f6..3ba7b26e5a74 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2700,6 +2700,7 @@ static MemoryRegion smram_as_mem;
> 
>  static void register_smram_listener(Notifier *n, void *unused)
>  {
> +    CPUState *cpu;
>      MemoryRegion *smram =
>          (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
> 
> @@ -2724,6 +2725,9 @@ static void register_smram_listener(Notifier *n, void
> *unused)
>      address_space_init(&smram_address_space, &smram_as_root, "KVM-SMRAM");
>      kvm_memory_listener_register(kvm_state, &smram_listener,
>                                   &smram_address_space, 1, "kvm-smram");
> +    CPU_FOREACH(cpu) {
> +        cpu_address_space_add(cpu, &smram_address_space);
> +    }
>  }

With the cpu_address_space_init(), here could be:

CPU_FOREACH(cpu) {
	/* Ensure SMM Address Space has the index 1.  */
	assert(cpu->num_ases == 1);
	cpu->num_ases = 2;
	cpu_address_space_init(cpu, 1, NULL, NULL, &smram_address_space);
}




