Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDAFC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 02:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPBdM-0004We-J9; Tue, 10 Jun 2025 22:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uPBdK-0004WU-OS
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 22:56:10 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uPBdH-0000KO-NY
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 22:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749610568; x=1781146568;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6LXZz6IgAN1iDAFuO1Kwc4HLJ2YDwRixA1EX92EWwB0=;
 b=icm7ktb+OGsa31JyhMOyj4cE3Sj6wwOPKEs5Ss+4lbRQf+FRwioAxm6q
 2VRhY6texA6G54WzlUhtnsdjVLqwWzebZraig9kaF9IOhMHXLwYvRobXX
 BXc7W0UsJyU5ogwWWmfUMlIJNud9/unj9O2XJC8xiQrQGZTlh97J2lSUA
 zyM6KrWSHLJ0s8DWLnSneIJw8dbghiwwtx3oz9oxIVHnZzJqsSB5Z+Uzm
 090NFFahuwiawY5NNLr4xeLkROJi6vsfs0qV6qUy1i3eKIdk2+Sam0Akj
 KQ+jvoDhKxw1ojKCaaBOjS0yllaNhVfBe5Qo5bm5aFHMqJiokrpMC8940 Q==;
X-CSE-ConnectionGUID: EJOx+oYhQxWTgisrVX4nDg==
X-CSE-MsgGUID: Yq30YM4FTY+44HPigd+HiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51841562"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; d="scan'208";a="51841562"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 19:56:02 -0700
X-CSE-ConnectionGUID: /tjcpJDCQjSkGvHk/JgsNg==
X-CSE-MsgGUID: i2gRDDp7Si6IDXM9gR4hJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; d="scan'208";a="147598776"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 19:56:00 -0700
Message-ID: <92c90e43-35a6-48a9-8634-0075aed2988a@intel.com>
Date: Wed, 11 Jun 2025 10:55:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 16/31] i386/kvm: Prefault memory on page state change
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
 <20250606123447.538131-17-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250606123447.538131-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

Paolo,

This one is not supposed to be pulled until we fix KVM as you said:
https://lore.kernel.org/qemu-devel/d0983ba3-383b-4c81-9cfd-b5b0d26a5d17@redhat.com/

BTW, I have sent the KVM fix:
https://lore.kernel.org/all/20250611001018.2179964-1-xiaoyao.li@intel.com/

On 6/6/2025 8:34 PM, Paolo Bonzini wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> A page state change is typically followed by an access of the page(s) and
> results in another VMEXIT in order to map the page into the nested page
> table. Depending on the size of page state change request, this can
> generate a number of additional VMEXITs. For example, under SNP, when
> Linux is utilizing lazy memory acceptance, memory is typically accepted in
> 4M chunks. A page state change request is submitted to mark the pages as
> private, followed by validation of the memory. Since the guest_memfd
> currently only supports 4K pages, each page validation will result in
> VMEXIT to map the page, resulting in 1024 additional exits.
> 
> When performing a page state change, invoke KVM_PRE_FAULT_MEMORY for the
> size of the page state change in order to pre-map the pages and avoid the
> additional VMEXITs. This helps speed up boot times.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Link: https://lore.kernel.org/r/f5411c42340bd2f5c14972551edb4e959995e42b.1743193824.git.thomas.lendacky@amd.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/system/kvm.h  |  1 +
>   accel/kvm/kvm-all.c   |  2 ++
>   target/i386/kvm/kvm.c | 31 ++++++++++++++++++++++++++-----
>   3 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 62ec131d4d8..7cc60d26f24 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -42,6 +42,7 @@ extern bool kvm_gsi_routing_allowed;
>   extern bool kvm_gsi_direct_mapping;
>   extern bool kvm_readonly_mem_allowed;
>   extern bool kvm_msi_use_devid;
> +extern bool kvm_pre_fault_memory_supported;
>   
>   #define kvm_enabled()           (kvm_allowed)
>   /**
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 51526d301b9..a31778341c2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -99,6 +99,7 @@ bool kvm_allowed;
>   bool kvm_readonly_mem_allowed;
>   bool kvm_vm_attributes_allowed;
>   bool kvm_msi_use_devid;
> +bool kvm_pre_fault_memory_supported;
>   static bool kvm_has_guest_debug;
>   static int kvm_sstep_flags;
>   static bool kvm_immediate_exit;
> @@ -2745,6 +2746,7 @@ static int kvm_init(MachineState *ms)
>           kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
>           kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
>           (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +    kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
>   
>       if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
>           s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index a6bc089d020..56a6b9b6381 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -6018,9 +6018,11 @@ static bool host_supports_vmx(void)
>    * because private/shared page tracking is already provided through other
>    * means, these 2 use-cases should be treated as being mutually-exclusive.
>    */
> -static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
> +static int kvm_handle_hc_map_gpa_range(X86CPU *cpu, struct kvm_run *run)
>   {
> +    struct kvm_pre_fault_memory mem;
>       uint64_t gpa, size, attributes;
> +    int ret;
>   
>       if (!machine_require_guest_memfd(current_machine))
>           return -EINVAL;
> @@ -6031,13 +6033,32 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
>   
>       trace_kvm_hc_map_gpa_range(gpa, size, attributes, run->hypercall.flags);
>   
> -    return kvm_convert_memory(gpa, size, attributes & KVM_MAP_GPA_RANGE_ENCRYPTED);
> +    ret = kvm_convert_memory(gpa, size, attributes & KVM_MAP_GPA_RANGE_ENCRYPTED);
> +    if (ret || !kvm_pre_fault_memory_supported) {
> +        return ret;
> +    }
> +
> +    /*
> +     * Opportunistically pre-fault memory in. Failures are ignored so that any
> +     * errors in faulting in the memory will get captured in KVM page fault
> +     * path when the guest first accesses the page.
> +     */
> +    memset(&mem, 0, sizeof(mem));
> +    mem.gpa = gpa;
> +    mem.size = size;
> +    while (mem.size) {
> +        if (kvm_vcpu_ioctl(CPU(cpu), KVM_PRE_FAULT_MEMORY, &mem)) {
> +            break;
> +        }
> +    }
> +
> +    return 0;
>   }
>   
> -static int kvm_handle_hypercall(struct kvm_run *run)
> +static int kvm_handle_hypercall(X86CPU *cpu, struct kvm_run *run)
>   {
>       if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
> -        return kvm_handle_hc_map_gpa_range(run);
> +        return kvm_handle_hc_map_gpa_range(cpu, run);
>   
>       return -EINVAL;
>   }
> @@ -6137,7 +6158,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>           break;
>   #endif
>       case KVM_EXIT_HYPERCALL:
> -        ret = kvm_handle_hypercall(run);
> +        ret = kvm_handle_hypercall(cpu, run);
>           break;
>       case KVM_EXIT_SYSTEM_EVENT:
>           switch (run->system_event.type) {


