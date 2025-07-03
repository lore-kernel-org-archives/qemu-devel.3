Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A0FC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJSA-0006Od-EC; Thu, 03 Jul 2025 08:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXJS6-0006Eu-UB
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:54:11 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXJS1-0000Fu-8Z
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751547245; x=1783083245;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NmGrJwlEm/qRmVp8Az6xKB1vcqWApT3CUAgNBkv/hf8=;
 b=IEFinq1XvJAZ5ddmwTTA2bKjGd9lGEMGVyiJGltTJgE5H58HZtb/vt/I
 YIlz6rU+aZ9rf+nkl/J3tzNQHMmR3RhDQH9M86CPhHbNkLaGtpRTRQWKR
 CijyjMGxJ1FRdW5LwdDQSNftUKJsP/9+rYZmecwyye7/OmzMpYR4ko0FT
 uuYGGOsrsCOw5MNP2IGFaLA/ZyC0D6QVt1OXc2Lsa+PxNm/IYQIlFTgvT
 pEPMJpZkQJVuRIIDItLtSxpNmWRS1blW8t2VIwTkNBUUpkSNX9JCa7EXy
 ei2H9virm6BSJAQXPT7tvnl3Eh0dAQ9v+1Aqok1lWw7Tb55MkJ6uOoqnu Q==;
X-CSE-ConnectionGUID: tGvsQudHRnyTUuRTqwbBQg==
X-CSE-MsgGUID: Llqr3zOJSwCy0vGWe/dv7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="54012763"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="54012763"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 05:54:00 -0700
X-CSE-ConnectionGUID: r4sVb1DfRHCUxZZuVCBdtg==
X-CSE-MsgGUID: H5bGqOhKRu2ou4mEu71KTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="185377074"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 05:53:59 -0700
Message-ID: <4985e648-6505-4321-8e3a-f987b9d03bde@intel.com>
Date: Thu, 3 Jul 2025 20:53:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
To: Kirill Martynov <stdcalllevi@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
 <3096f21e-d8dd-4434-afbd-ee2b56adb20f@intel.com>
 <6a18dfcc-1686-4e3e-8e0a-b96d7034f4ab@intel.com>
 <1d12e519-9f3c-41a0-90ff-8e4655000d21@intel.com>
 <09AD44D6-E381-46B0-9B86-B248EB9582D7@yandex-team.ru>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <09AD44D6-E381-46B0-9B86-B248EB9582D7@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/3/2025 5:25 PM, Kirill Martynov wrote:
> Hi, Xiaoyao!
> Hi, Zhao!
> Thank you for your feedback.
> You wrote:
>> QEMU allocates separate KVM address space for SMM in register_smram_listener(). But the address space doesn't associated with cpu's address space.
> 
> The address space allocated in register_sm_ram_listener() is  stored in KVMState::KVMAs::as
> 
> However, function cpu_asidx_from_attrs() returns index which is used to reference CPUState::cpu_ases
> These are different array used to store address spaces. In softmmu setup there is a function called for cpu initialisation qemu_init_vcpu() which has hardcoded number of address spaces used to 1
> 
> if (!cpu->as) {
>      /* If the target cpu hasn't set up any address spaces itself,
>       * give it the default one.
>       */
>      cpu->num_ases = 1;
>      cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
> }
> 
> Do I understand your concern correctly?
> The number of address spaces from KVM is allocated correctly (2 address spaces) however in QEMU CPUState is allocated only 1, so the correct fix would be to associate/map KVM allocated address spaces with
> QEMU CPUState address spaces ?

The address spaces are all allocated by QEMU. So it's not allocated from 
KVM, but for KVM.

yes, QEMU supports separate address space for SMM mode with KVM. It's 
just that QEMU doesn't connect it with the CPU address space.

I cook a draft code below, which passes the "make check" test. Could 
help test if it can resolve your issue? QEMU initializes 
smram_address_space later at machine done notifier, so that the code has 
to iterate the CPUs to add the address space of SMRAM to CPU address 
space. I will try to see if possible to make it happen earlier so that 
when kvm_cpu_realizefn() all the address spaces are here.


-------8<---------
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index a68485547d50..7d6f4a86d802 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -130,6 +130,8 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
   */
  void cpu_address_space_destroy(CPUState *cpu, int asidx);

+void cpu_address_space_add(CPUState *cpu, AddressSpace *as);
+
  void cpu_physical_memory_rw(hwaddr addr, void *buf,
                              hwaddr len, bool is_write);
  static inline void cpu_physical_memory_read(hwaddr addr,
diff --git a/system/physmem.c b/system/physmem.c
index ff0ca40222d3..289c06c2af77 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -814,6 +814,31 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
      }
  }

+void cpu_address_space_add(CPUState *cpu, AddressSpace *as)
+{
+    CPUAddressSpace *newas;
+    int asidx = cpu->num_ases;
+
+    cpu->num_ases++;
+
+    if(asidx == 0) {
+        /* address space 0 gets the convenience alias */
+        cpu->as = as;
+    }
+
+    if (!cpu->cpu_ases) {
+        cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
+        cpu->cpu_ases_count = cpu->num_ases;
+    } else {
+        cpu->cpu_ases = g_renew(CPUAddressSpace, cpu->cpu_ases,
+                                                cpu->num_ases);
+    }
+
+    newas = &cpu->cpu_ases[asidx];
+    newas->cpu = cpu;
+    newas->as = as;
+}
+
  void cpu_address_space_destroy(CPUState *cpu, int asidx)
  {
      CPUAddressSpace *cpuas;
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 16bde4de01e5..7b89326e34ca 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -12,6 +12,7 @@
  #include "host-cpu.h"
  #include "qapi/error.h"
  #include "system/system.h"
+#include "system/kvm_int.h"
  #include "hw/boards.h"

  #include "kvm_i386.h"
@@ -90,6 +91,12 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
          kvm_set_guest_phys_bits(cs);
      }

+    for (int i = 0; i < kvm_state->nr_as; i++) {
+        if (kvm_state->as[i].as) {
+            cpu_address_space_add(cs, kvm_state->as[i].as);
+        }
+    }
+
      return true;
  }

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 234878c613f6..3ba7b26e5a74 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2700,6 +2700,7 @@ static MemoryRegion smram_as_mem;

  static void register_smram_listener(Notifier *n, void *unused)
  {
+    CPUState *cpu;
      MemoryRegion *smram =
          (MemoryRegion *) object_resolve_path("/machine/smram", NULL);

@@ -2724,6 +2725,9 @@ static void register_smram_listener(Notifier *n, 
void *unused)
      address_space_init(&smram_address_space, &smram_as_root, "KVM-SMRAM");
      kvm_memory_listener_register(kvm_state, &smram_listener,
                                   &smram_address_space, 1, "kvm-smram");
+    CPU_FOREACH(cpu) {
+        cpu_address_space_add(cpu, &smram_address_space);
+    }
  }

  static void *kvm_msr_energy_thread(void *data)

