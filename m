Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56784E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 05:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLyXZ-0004Bm-7Z; Fri, 13 Dec 2024 00:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLyXX-0004Bd-VL
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 00:48:39 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLyXU-0000QE-T4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 00:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734068917; x=1765604917;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vaybq7wSTE9kPY+MyW36fVpw/LZp5T3mCwA7s5tNDm4=;
 b=FiGgu0H/65Ax1tBJs97lWyWG1jUC/wlipxyZweFZO3eRFvZBrXjXcys9
 KopadHcMV6KybYqb5Un9YfQtDvJ4tLCFO93KvkK2f265/0kAt2j0oTdkT
 3E92nRKZUHs+gMmGX4gmTtSLiGfso4Cxo1TQ50Ch2SZsmeBOv13kBa5QJ
 qrc52fiAAh4hhtR2zu4jVFcZSSSjVC/qHH0Flo+b+lICEWReBnKLGvsgs
 L5CV1fEVDNbg+eVDJamavWIrF2JCWmi7lLtKGGnVvqvXl9nCN8ufl3BCs
 +q2KSZaS/e1+ygoVIK3CANWRYJVUuVOqAw5O1mFDraQATBqQUXhvgSgpD A==;
X-CSE-ConnectionGUID: UUGD4tOiRSa2uKY9faNePg==
X-CSE-MsgGUID: FTNFaJsPQIWrieCbbg6LYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34429127"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="34429127"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 21:48:32 -0800
X-CSE-ConnectionGUID: ukQOMKiRQQy3bv4dyvWy9A==
X-CSE-MsgGUID: IvhvFW6+SHKBcdKk19Wp2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="101539117"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 21:48:30 -0800
Message-ID: <45f6dd92-4976-4c0c-8222-c15139280824@intel.com>
Date: Fri, 13 Dec 2024 13:48:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: consistently return 0/-errno from kvm_convert_memory
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com, binbin.wu@linux.intel.com
References: <20241212155719.524637-1-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20241212155719.524637-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
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

On 12/12/2024 11:57 PM, Paolo Bonzini wrote:
> In case of incorrect parameters, kvm_convert_memory() was returning
> -1 instead of -EINVAL.  The guest won't notice because it will move
> anyway to RUN_STATE_INTERNAL_ERROR, but fix this for consistency and
> clarity.

I think we need add more clarification about "guest".

kvm_convert_memory() is also used to service the request of 
KVM_HC_MAP_GPA_RANGE from guest since commit 47e76d03b155 ("i386/kvm: 
Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE"). It might 
need to return error back to guest in case of incorrect parameters, in 
the future.

For the code change,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4c5cef766ad..81821af7d7a 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2998,17 +2998,17 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>       ram_addr_t offset;
>       MemoryRegion *mr;
>       RAMBlock *rb;
> -    int ret = -1;
> +    int ret = -EINVAL;
>   
>       trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
>   
>       if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
>           !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
> -        return -1;
> +        return ret;
>       }
>   
>       if (!size) {
> -        return -1;
> +        return ret;
>       }
>   
>       section = memory_region_find(get_system_memory(), start, size);
> @@ -3026,7 +3026,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>           if (!to_private) {
>               return 0;
>           }
> -        return -1;
> +        return ret;
>       }
>   
>       if (!memory_region_has_guest_memfd(mr)) {


