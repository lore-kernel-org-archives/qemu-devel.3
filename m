Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBD2CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 02:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC7Za-0001rw-Oh; Thu, 23 Oct 2025 22:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vC7ZY-0001ro-LT
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:30:33 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vC7ZV-0000a7-9l
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761273029; x=1792809029;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PX+eVf5i4pYVjX5/OhEJPZeGHVaKXl1t7iu4j85VAaw=;
 b=MGyU1PHem5O59WIeZAgitW5aiamcwf7hhjmM3graLaKRQ8j3Q22KnaH1
 /iDMg4QNYAsL1YIRF8oi1LVXocCl/6jR8Py8qSUyTB7CDxh2txehhh4JE
 PpvL0JnTih7pIQ9+dvqeYR9HPj8YPu295cwL29ABSLfi0zjICCvbfC2a5
 ID1DD/bPraCa2JvnvhAGv1HlII2SENdcDg8l5uIeoHSRoNR/iATsG7k4Z
 xWSz2xTqqYea0BLLQeIwiniWDuVUqjBZ2PVUd7QM4QQsDJPa9mmouLy5a
 YvVOSsJuWFwRyz61GqnVlLpWUwd8W/+xqALpU3OcOKmvunyWA7GhIFLl1 g==;
X-CSE-ConnectionGUID: FVtloujFQ5aqnf2pCuFn5w==
X-CSE-MsgGUID: 9yswrV+8QRaHVE8aIKdDSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74892986"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="74892986"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:30:25 -0700
X-CSE-ConnectionGUID: MDsBStKpQK6NIicOOyHanA==
X-CSE-MsgGUID: 5DeMk5hbQOC+NPgPg490Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184386427"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:30:22 -0700
Message-ID: <9614d727-97bf-4a50-be13-6754952bec96@intel.com>
Date: Fri, 24 Oct 2025 10:30:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] kvm: Allow kvm_guest_memfd_supported for non-private
 use case
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Chenyi Qiang <chenyi.qiang@intel.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Juraj Marcin <jmarcin@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-3-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251023185913.2923322-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/24/2025 2:59 AM, Peter Xu wrote:
> Guest-memfd is not 100% attached to private, it's a VM-specific memory
> provider.  Allow it to be created even without private attributes, for
> example, when the VM can use the guest-memfd memory completely shared.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f9254ae654..1425dfd8b3 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2779,10 +2779,8 @@ static int kvm_init(AccelState *as, MachineState *ms)
>       }
>   
>       kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
> -    kvm_guest_memfd_supported =
> -        kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> -        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
> -        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +    kvm_guest_memfd_supported = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> +        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
>       kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
>   
>       if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {


The check on KVM_MEMORY_ATTRIBUTE_PRIVATE is dropped silently. But using 
guest memfd to serve as private memory does requires the support of 
KVM_MEMORY_ATTRIBUTE_PRIVATE.

My version of the patch was


Author: Xiaoyao Li <xiaoyao.li@intel.com>
Date:   Sat Jul 19 00:56:57 2025 +0800

     kvm: Decouple memory attribute check from kvm_guest_memfd_supported

     With the mmap support of guest memfd, KVM allows usersapce to create
     guest memfd serving as normal non-private memory for X86 DEFEAULT VM.
     However, KVM doesn't support private memory attriute for X86 DEFAULT
     VM.

     Make kvm_guest_memfd_supported not rely on KVM_MEMORY_ATTRIBUTE_PRIVATE
     and check KVM_MEMORY_ATTRIBUTE_PRIVATE separately when the machine
     requires guest_memfd to serve as private memory.

     This allows QMEU to create guest memfd with mmap to serve as the memory
     backend for X86 DEFAULT VM.

     Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f9254ae65466..96c194ce54cd 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1501,6 +1501,11 @@ int kvm_set_memory_attributes_shared(hwaddr 
start, uint64_t size)
      return kvm_set_memory_attributes(start, size, 0);
  }

+bool kvm_private_memory_attribute_supported(void)
+{
+    return !!(kvm_supported_memory_attributes & 
KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
  /* Called with KVMMemoryListener.slots_lock held */
  static void kvm_set_phys_mem(KVMMemoryListener *kml,
                               MemoryRegionSection *section, bool add)
@@ -2781,8 +2786,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
      kvm_supported_memory_attributes = kvm_vm_check_extension(s, 
KVM_CAP_MEMORY_ATTRIBUTES);
      kvm_guest_memfd_supported =
          kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
-        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
-        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
      kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, 
KVM_CAP_PRE_FAULT_MEMORY);

      if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 68cd33ba9735..73f04eb589ef 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -125,3 +125,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t 
flags, Error **errp)
  {
      return -ENOSYS;
  }
+
+bool kvm_private_memory_attribute_supported(void)
+{
+    return false;
+}
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 8f9eecf044c2..b5811c90f1cc 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -561,6 +561,7 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t 
flags, Error **errp);

  int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
  int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
+bool kvm_private_memory_attribute_supported(void);

  int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);

diff --git a/system/physmem.c b/system/physmem.c
index a340ca3e6166..7704572a5745 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2211,6 +2211,14 @@ static void ram_block_add(RAMBlock *new_block, 
Error **errp)
                         object_get_typename(OBJECT(current_machine->cgs)));
              goto out_free;
          }
+
+        if (!kvm_private_memory_attribute_supported()) {
+            error_setg(errp, "cannot set up private guest memory for %s: "
+                       " KVM does not support private memory attribute",
+                       object_get_typename(OBJECT(current_machine->cgs)));
+            goto out_free;
+        }
+
          assert(new_block->guest_memfd < 0);

          ret = ram_block_coordinated_discard_require(true);

