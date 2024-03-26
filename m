Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F394BC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 08:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp2ZF-0001Qz-Nw; Tue, 26 Mar 2024 04:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rp2ZD-0001QX-6X
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 04:53:59 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rp2ZA-0003Y3-9x
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 04:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711443236; x=1742979236;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=o6CKEXzuWXuaqzz3HHRs/+rhhgDFmVWiIvroEDORB3A=;
 b=Xh9a8OxMapI4TnZd0Ecu5qM+L/9vQ0xkOCHtrvmsXoI0qE9XBhd94355
 feLdFmF0BbdaC0fAz8Kfudd293sd8zGYe1RXQzFWR/6VN7OfyiFjYQfIh
 rmwI7H6V8xauWUXOOu7Rn3eMorrkwxX0GNevJ9Andezwbo0tK9Cw0zv5j
 +s5UVfvXveVL0PNm9Q8e+23g96LLIPgfNNimO46d73Pa1ORhNB0ZlPEe2
 Ai5s6Y9JY6dA69tG3kZlHN0saj4FHUvN1CGHzlvEEKV9s85CL/B3DVYaw
 sNhA8ALCnT3ragXVukM2haXpF3wUbLoHOt942RtGAXD9X3cnJE7svISRH g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17873534"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; d="scan'208";a="17873534"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 01:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; d="scan'208";a="16285527"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.7])
 ([10.124.224.7])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 01:53:51 -0700
Message-ID: <52df5a0e-6812-41ae-a5c6-7d403b33f84a@intel.com>
Date: Tue, 26 Mar 2024 16:53:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/26] kvm: handle KVM_EXIT_MEMORY_FAULT
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, david@redhat.com
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-26-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240322181116.1228416-26-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/23/2024 2:11 AM, Paolo Bonzini wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> When geeting KVM_EXIT_MEMORY_FAULT exit, it indicates userspace needs to

typo: /s/geeting/getting

> do the memory conversion on the RAMBlock to turn the memory into desired
> attribute, i.e., private/shared.
> 
> Currently only KVM_MEMORY_EXIT_FLAG_PRIVATE in flags is valid when
> KVM_EXIT_MEMORY_FAULT happens.
> 
> Note, KVM_EXIT_MEMORY_FAULT makes sense only when the RAMBlock has
> guest_memfd memory backend.
> 
> Note, KVM_EXIT_MEMORY_FAULT returns with -EFAULT, so special handling is
> added.
> 
> When page is converted from shared to private, the original shared
> memory can be discarded via ram_block_discard_range(). Note, shared
> memory can be discarded only when it's not back'ed by hugetlb because
> hugetlb is supposed to be pre-allocated and no need for discarding.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> Message-ID: <20240320083945.991426-13-michael.roth@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/sysemu/kvm.h   |  2 +
>   accel/kvm/kvm-all.c    | 99 +++++++++++++++++++++++++++++++++++++-----
>   accel/kvm/trace-events |  2 +
>   3 files changed, 93 insertions(+), 10 deletions(-)
> 
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 2cb31925091..698f1640fe2 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -541,4 +541,6 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
>   
>   int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
>   int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
> +
> +int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
>   #endif
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 56b17cbd8aa..afd7f992e39 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2893,6 +2893,70 @@ static void kvm_eat_signals(CPUState *cpu)
>       } while (sigismember(&chkset, SIG_IPI));
>   }
>   
> +int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> +{
> +    MemoryRegionSection section;
> +    ram_addr_t offset;
> +    MemoryRegion *mr;
> +    RAMBlock *rb;
> +    void *addr;
> +    int ret = -1;
> +
> +    trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
> +
> +    if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
> +        !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
> +        return -1;
> +    }
> +
> +    if (!size) {
> +        return -1;
> +    }
> +
> +    section = memory_region_find(get_system_memory(), start, size);
> +    mr = section.mr;
> +    if (!mr) {
> +        return -1;
> +    }
> +
> +    if (!memory_region_has_guest_memfd(mr)) {
> +        error_report("Converting non guest_memfd backed memory region "
> +                     "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
> +                     start, size, to_private ? "private" : "shared");
> +        ret = -1;

No need for it. ret is initialized as -1 at the function start.

> +        goto out_unref;
> +    }
> +
> +    if (to_private) {
> +        ret = kvm_set_memory_attributes_private(start, size);
> +    } else {
> +        ret = kvm_set_memory_attributes_shared(start, size);
> +    }
> +    if (ret) {
> +        goto out_unref;
> +    }
> +
> +    addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
> +    rb = qemu_ram_block_from_host(addr, false, &offset);
> +
> +    if (to_private) {
> +        if (rb->page_size == qemu_real_host_page_size()) {
> +            /*
> +            * shared memory is back'ed by  hugetlb, which is supposed to be

Please fix the bad comment indentation for me, as well as the extra 
space before 'hugetlb'

> +            * pre-allocated and doesn't need to be discarded
> +            */
> +            goto out_unref;
> +        }
> +        ret = ram_block_discard_range(rb, offset, size);
> +    } else {
> +        ret = ram_block_discard_guest_memfd_range(rb, offset, size);
> +    }
> +
> +out_unref:
> +    memory_region_unref(section.mr);
> +    return ret;
> +}
> +
>   int kvm_cpu_exec(CPUState *cpu)
>   {
>       struct kvm_run *run = cpu->kvm_run;
> @@ -2960,18 +3024,20 @@ int kvm_cpu_exec(CPUState *cpu)
>                   ret = EXCP_INTERRUPT;
>                   break;
>               }
> -            fprintf(stderr, "error: kvm run failed %s\n",
> -                    strerror(-run_ret));
> +            if (!(run_ret == -EFAULT && run->exit_reason == KVM_EXIT_MEMORY_FAULT)) {
> +                fprintf(stderr, "error: kvm run failed %s\n",
> +                        strerror(-run_ret));
>   #ifdef TARGET_PPC
> -            if (run_ret == -EBUSY) {
> -                fprintf(stderr,
> -                        "This is probably because your SMT is enabled.\n"
> -                        "VCPU can only run on primary threads with all "
> -                        "secondary threads offline.\n");
> -            }
> +                if (run_ret == -EBUSY) {
> +                    fprintf(stderr,
> +                            "This is probably because your SMT is enabled.\n"
> +                            "VCPU can only run on primary threads with all "
> +                            "secondary threads offline.\n");
> +                }
>   #endif
> -            ret = -1;
> -            break;
> +                ret = -1;
> +                break;
> +            }
>           }
>   
>           trace_kvm_run_exit(cpu->cpu_index, run->exit_reason);
> @@ -3054,6 +3120,19 @@ int kvm_cpu_exec(CPUState *cpu)
>                   break;
>               }
>               break;
> +        case KVM_EXIT_MEMORY_FAULT:
> +            trace_kvm_memory_fault(run->memory_fault.gpa,
> +                                   run->memory_fault.size,
> +                                   run->memory_fault.flags);
> +            if (run->memory_fault.flags & ~KVM_MEMORY_EXIT_FLAG_PRIVATE) {
> +                error_report("KVM_EXIT_MEMORY_FAULT: Unknown flag 0x%" PRIx64,
> +                             (uint64_t)run->memory_fault.flags);
> +                ret = -1;
> +                break;
> +            }
> +            ret = kvm_convert_memory(run->memory_fault.gpa, run->memory_fault.size,
> +                                     run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE);
> +            break;
>           default:
>               ret = kvm_arch_handle_exit(cpu, run);
>               break;
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index e8c52cb9e7a..681ccb667d6 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -31,3 +31,5 @@ kvm_cpu_exec(void) ""
>   kvm_interrupt_exit_request(void) ""
>   kvm_io_window_exit(void) ""
>   kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index %d, system_even_type %"PRIu32
> +kvm_convert_memory(uint64_t start, uint64_t size, const char *msg) "start 0x%" PRIx64 " size 0x%" PRIx64 " %s"
> +kvm_memory_fault(uint64_t start, uint64_t size, uint64_t flags) "start 0x%" PRIx64 " size 0x%" PRIx64 " flags 0x%" PRIx64


