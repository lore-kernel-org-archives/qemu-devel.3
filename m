Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB729D3E79C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTaou-0004ZO-BQ; Thu, 11 Dec 2025 02:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTaot-0004YF-88
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:10:35 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTaor-0004VV-7d
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765437033; x=1796973033;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=t/Jh42dbT3IcDeJ6QMEAjPQaHaVHW4tz8MGnrSj/dwg=;
 b=PWYiwwIvUJdxvJlpz6UdkyuTRC3C+jRdo/+VyVeFJntEHuhuRkh8Yt9E
 L3ROD1jJRXw+iLjUKeaw1dSU52sm48QAw0sqw7xa7aS6w1FzFOu+Cz/Dx
 SxtPLa9o8nSm+68uPc4VxG0Wg4yqCkQh38OJG+lPnK70gjoYD1OHXbuHv
 XK7y5gfA7dgATVhUKAuTbhZ/3711I/C1RiSh6V8EYokuuWRhAuTLHusxU
 hwkTZ49i23PUldozwiy8KrtVdbMt7SpjHMqQu8CzBSsl4Ynfq8FLTJWli
 n1ms4EbGvuAZ3CsysDknRjdcO9XinoKlL0jlTzNoFdPU79s2SghgA6AVa w==;
X-CSE-ConnectionGUID: kEfJU6f3TwSl3CCk9Zjh/w==
X-CSE-MsgGUID: rw95hu4BRJaMobZFSKSVLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="78117720"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="78117720"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:10:30 -0800
X-CSE-ConnectionGUID: 06/fP7Y3R6O9q7yaRPOWwg==
X-CSE-MsgGUID: WPMOMn7dT5KPQ39mDl3dLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="201152012"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:10:27 -0800
Message-ID: <08309979-8a73-4e30-a574-2bf23124eac8@intel.com>
Date: Thu, 11 Dec 2025 15:10:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] memory: Rename memory_region_has_guest_memfd() to
 *_private()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-5-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251119172913.577392-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/20/2025 1:29 AM, Peter Xu wrote:
> Rename the function with "_private" suffix, to show that it returns true
> only if it has an internal guest-memfd to back private pages (rather than
> in-place guest-memfd).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/system/memory.h | 6 +++---
>   accel/kvm/kvm-all.c     | 6 +++---
>   system/memory.c         | 2 +-
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 2c1a5e06b4..4428701a9f 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1823,14 +1823,14 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
>   bool memory_region_is_protected(MemoryRegion *mr);
>   
>   /**
> - * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
> - *     associated
> + * memory_region_has_guest_memfd_private: check whether a memory region has
> + *     guest_memfd associated

Nit: maybe change it to "guest_memfd_private associated", and maybe put 
this patch after patch 5?

Otherwise,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

>    *
>    * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
>    *
>    * @mr: the memory region being queried
>    */
> -bool memory_region_has_guest_memfd(MemoryRegion *mr);
> +bool memory_region_has_guest_memfd_private(MemoryRegion *mr);
>   
>   /**
>    * memory_region_get_iommu: check whether a memory region is an iommu
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f477014126..320315f50c 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -666,7 +666,7 @@ static int kvm_mem_flags(MemoryRegion *mr)
>       if (readonly && kvm_readonly_mem_allowed) {
>           flags |= KVM_MEM_READONLY;
>       }
> -    if (memory_region_has_guest_memfd(mr)) {
> +    if (memory_region_has_guest_memfd_private(mr)) {
>           assert(kvm_guest_memfd_supported);
>           flags |= KVM_MEM_GUEST_MEMFD;
>       }
> @@ -1615,7 +1615,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>               abort();
>           }
>   
> -        if (memory_region_has_guest_memfd(mr)) {
> +        if (memory_region_has_guest_memfd_private(mr)) {
>               err = kvm_set_memory_attributes_private(start_addr, slot_size);
>               if (err) {
>                   error_report("%s: failed to set memory attribute private: %s",
> @@ -3101,7 +3101,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>           return ret;
>       }
>   
> -    if (!memory_region_has_guest_memfd(mr)) {
> +    if (!memory_region_has_guest_memfd_private(mr)) {
>           /*
>            * Because vMMIO region must be shared, guest TD may convert vMMIO
>            * region to shared explicitly.  Don't complain such case.  See
> diff --git a/system/memory.c b/system/memory.c
> index 81b7bff42d..15964160ee 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1897,7 +1897,7 @@ bool memory_region_is_protected(MemoryRegion *mr)
>       return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
>   }
>   
> -bool memory_region_has_guest_memfd(MemoryRegion *mr)
> +bool memory_region_has_guest_memfd_private(MemoryRegion *mr)
>   {
>       return mr->ram_block && mr->ram_block->guest_memfd >= 0;
>   }


