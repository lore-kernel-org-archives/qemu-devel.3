Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9472D43369
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 03:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTtY9-0004a1-JL; Thu, 11 Dec 2025 22:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTtY8-0004Zn-5R
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 22:10:32 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTtY6-0002HK-E2
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 22:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765509031; x=1797045031;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Mocicri8CbMWrbM3/i9mesAEFKq87WkhQwfghecQekI=;
 b=kUb3RD1wDROEc1bk/Q6K7epJ9agon+be1acYkTcW4s7XrvfyrZvqpice
 Pe68+l39UgZ32gp1LdUFMRtUeHaqjvak4N68MDwXxURHWCAx6XW7f33tk
 WUsSZ1bv4rpkJEx8vjGqMJv4u5+ggC700oBLrAiuw3lzOGicDRi1w41Yz
 2G8bZLr5UPm/322LH8TsyU6gf3h/2/L5CxEzRdJ5c788o5Kdj5XQEKQsB
 6NuJsnv5a4I1otLYdrvVHCn1C8feuPNFAg1SHO+grYhIiQS4+Z6ToyBeT
 zeLoG8t336oCYkZL0bhM28ggdu2Oh+KDR43rInk7iJ8Jrq4Rovjdcoyxm g==;
X-CSE-ConnectionGUID: bPbuZAmhRaicUyA/WP+Wbw==
X-CSE-MsgGUID: HcvNr0bjSc29rJ/hue4UNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="90150769"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="90150769"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 19:10:29 -0800
X-CSE-ConnectionGUID: +AFvzj/YSpCUu/HZRkLC4A==
X-CSE-MsgGUID: FhvgMX1mTlOPFtcy6muZ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="197441386"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 19:10:26 -0800
Message-ID: <a958f847-78fc-4743-80bb-49aae5f37bcf@intel.com>
Date: Fri, 12 Dec 2025 11:10:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] kvm: Detect guest-memfd flags supported
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-3-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251119172913.577392-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
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
> Detect supported guest-memfd flags by the current kernel, and reject
> creations of guest-memfd using invalid flags.  When the cap isn't
> available, then no flag is supported.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 96c194ce54..f477014126 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -108,6 +108,7 @@ static int kvm_sstep_flags;
>   static bool kvm_immediate_exit;
>   static uint64_t kvm_supported_memory_attributes;
>   static bool kvm_guest_memfd_supported;
> +static uint64_t kvm_guest_memfd_flags_supported;
>   static hwaddr kvm_max_slot_size = ~0;
>   
>   static const KVMCapabilityInfo kvm_required_capabilites[] = {
> @@ -2787,6 +2788,10 @@ static int kvm_init(AccelState *as, MachineState *ms)
>       kvm_guest_memfd_supported =
>           kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
>           kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
> +
> +    ret = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
> +    kvm_guest_memfd_flags_supported = ret > 0 ? ret : 0;
> +
>       kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
>   
>       if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
> @@ -4492,6 +4497,12 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>           return -1;
>       }
>   
> +    if (flags & ~kvm_guest_memfd_flags_supported) {
> +        error_setg(errp, "KVM does not support guest-memfd flag: 0x%"PRIx64,

I'm thinking if need to add "for current VM" like:

	KVM does not support guest-memfd flag: xxx for current VM

because kvm_guest_memfd_flags_supported is got from VM-scope CAP and 
varies for different VM types.

> +                   flags & ~kvm_guest_memfd_flags_supported);
> +        return -1;
> +    }
> +
>       fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
>       if (fd < 0) {
>           error_setg_errno(errp, errno, "Error creating KVM guest_memfd");


