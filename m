Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A1FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 02:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmP0H-00018u-TF; Mon, 18 Mar 2024 22:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rmP0F-00018m-1r
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 22:14:59 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rmP0D-0005qf-4V
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 22:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710814497; x=1742350497;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GLhds+4K7dc7u246W/UoQ0WN87K/fN2ZmsoMZyd0Dag=;
 b=n43E9lMI/aaA8pc+N8bVMuXKUscW07+LGsz/fg4AjYlJhQ/otlGrfG/J
 AtHUC9TPWx05B2SfADo7+aODRvICWcPiHeiPzKXqy1a0hwPpCbhs4jJZW
 G/YgmxR+4v/i2iLx5rVimPga4n0vobB8XeZeZOD7ZDdlFlqxt94lZ4Djh
 JAf8nfdfvKJlaTJmZMjtR5ib2/HB+ZwbAjvZccP9tIQhQRW+4C+N9WP8V
 ukJHkSvNhEcjKt8jEkU7WBxDHrLzMnuL/t7tig8YWBap2RoRkEo+5WgtT
 ET1lrR9O6FzZ4YlvsO4umbFtxptlaNhAws2yDhopSYt2Zp+D9/jZvAczr Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="31091304"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="31091304"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 19:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="44718549"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.124.244.145])
 ([10.124.244.145])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 19:14:49 -0700
Message-ID: <3d2655c7-74ad-49d9-a527-7648f8e565da@intel.com>
Date: Tue, 19 Mar 2024 10:14:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/65] kvm: handle KVM_EXIT_MEMORY_FAULT
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-9-xiaoyao.li@intel.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <20240229063726.610065-9-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/29/2024 14:36, Xiaoyao Li wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> When geeting KVM_EXIT_MEMORY_FAULT exit, it indicates userspace needs to
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
> ---
> Changes in v4:
> - open-coded ram_block_discard logic;
> - change warn_report() to error_report(); (Daniel)
> ---
>  accel/kvm/kvm-all.c | 94 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 84 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 70d482a2c936..87e4275932a7 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2903,6 +2903,68 @@ static void kvm_eat_signals(CPUState *cpu)
>      } while (sigismember(&chkset, SIG_IPI));
>  }
>  
> +static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> +{
> +    MemoryRegionSection section;
> +    ram_addr_t offset;
> +    MemoryRegion *mr;
> +    RAMBlock *rb;
> +    void *addr;
> +    int ret = -1;
> +
> +    if (!QEMU_PTR_IS_ALIGNED(start, qemu_host_page_size) ||
> +        !QEMU_PTR_IS_ALIGNED(size, qemu_host_page_size)) {
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
> +    if (memory_region_has_guest_memfd(mr)) {
> +        if (to_private) {
> +            ret = kvm_set_memory_attributes_private(start, size);
> +        } else {
> +            ret = kvm_set_memory_attributes_shared(start, size);
> +        }
> +
> +        if (ret) {
> +            memory_region_unref(section.mr);
> +            return ret;
> +        }
> +
> +        addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
> +        rb = qemu_ram_block_from_host(addr, false, &offset);
> +
> +        if (to_private) {
> +            if (rb->page_size != qemu_host_page_size) {
> +                /*
> +                * shared memory is back'ed by  hugetlb, which is supposed to be
> +                * pre-allocated and doesn't need to be discarded
> +                */

Nit: comment indentation is broken here.

> +                return 0;
> +            } else {
> +                ret = ram_block_discard_range(rb, offset, size);
> +            }
> +        } else {
> +            ret = ram_block_discard_guest_memfd_range(rb, offset, size);
> +        }
> +    } else {
> +        error_report("Convert non guest_memfd backed memory region "
> +                    "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",

Same as above.

> +                    start, size, to_private ? "private" : "shared");
> +    }
> +
> +    memory_region_unref(section.mr);
> +    return ret;
> +}
> +
>  int kvm_cpu_exec(CPUState *cpu)
>  {
>      struct kvm_run *run = cpu->kvm_run;
> @@ -2970,18 +3032,20 @@ int kvm_cpu_exec(CPUState *cpu)
>                  ret = EXCP_INTERRUPT;
>                  break;
>              }
> -            fprintf(stderr, "error: kvm run failed %s\n",
> -                    strerror(-run_ret));
> +            if (!(run_ret == -EFAULT && run->exit_reason == KVM_EXIT_MEMORY_FAULT)) {
> +                fprintf(stderr, "error: kvm run failed %s\n",
> +                        strerror(-run_ret));
>  #ifdef TARGET_PPC
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
>  #endif
> -            ret = -1;
> -            break;
> +                ret = -1;
> +                break;
> +            }
>          }
>  
>          trace_kvm_run_exit(cpu->cpu_index, run->exit_reason);
> @@ -3064,6 +3128,16 @@ int kvm_cpu_exec(CPUState *cpu)
>                  break;
>              }
>              break;
> +        case KVM_EXIT_MEMORY_FAULT:
> +            if (run->memory_fault.flags & ~KVM_MEMORY_EXIT_FLAG_PRIVATE) {
> +                error_report("KVM_EXIT_MEMORY_FAULT: Unknown flag 0x%" PRIx64,
> +                             (uint64_t)run->memory_fault.flags);
> +                ret = -1;
> +                break;
> +            }
> +            ret = kvm_convert_memory(run->memory_fault.gpa, run->memory_fault.size,
> +                                     run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE);
> +            break;
>          default:
>              ret = kvm_arch_handle_exit(cpu, run);
>              break;

