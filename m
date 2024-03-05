Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D76DC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQpY-0001Xz-83; Tue, 05 Mar 2024 04:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1rhQp7-0001NY-M3
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:11:01 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1rhQp5-0005jG-1E
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709629855; x=1741165855;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rVIwlJM3IgwqSihvhW2HEaT8sLQNzBRHPyLxvk8Crcg=;
 b=LzrRWpYic5GFCsB3TbC2gtAFwQXVgA29t5wNRfqtK0i/cWkTLPzSF5m2
 UmA+B/JlJQpGma5gfJ+as+51WWxdAFZzy2Lkse/ssj8oeZ4YXS31nQMGM
 31AkwGEW/Zt8CNYK5BypfNTUL2B3FkDL9tZiBHCfWjCgRzHSHcWeQH3qn
 K4t1mW0iXmWsf7uxHnoDGwGj1FbwFumhUgwEBpDxEdiW5Dyt9u6x3zLql
 J86NFjCll5Be49UkzkEakMh462NPSCKL/4iIjyZLh3h4DY2Z97a9ZBUkg
 3HXpi1myRag1ueqaI1adoCWhk13j1JumHHejEcRHq/vqOv2TMdoy+uTJ7 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="29593507"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="29593507"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2024 01:10:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="13899085"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2024 01:10:50 -0800
Date: Tue, 5 Mar 2024 01:10:49 -0800
From: Isaku Yamahata <isaku.yamahata@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 isaku.yamahata@linux.intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH v5 08/65] kvm: handle KVM_EXIT_MEMORY_FAULT
Message-ID: <20240305091049.GA368614@ls.amr.corp.intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-9-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229063726.610065-9-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=isaku.yamahata@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, Feb 29, 2024 at 01:36:29AM -0500,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

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
> +                return 0;

The reference count leaks. Add memory_region_unref() is needed.

Otherwise looks good to me.
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

