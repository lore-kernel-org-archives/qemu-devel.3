Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC15CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 03:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC8qg-00027s-PH; Thu, 23 Oct 2025 23:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vC8qe-000279-1I
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 23:52:16 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vC8qb-0000nu-T6
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 23:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761277935; x=1792813935;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=AJ7UoWkceY2OSRMiA7porTtv2ydezDLqkoMDBq1MBFs=;
 b=ndICa3Wr1fcUulDYGycdo3+w/0fTMw7VWdng3GUPKt+KQP7IEKNJCasY
 6+72tTDac3bIKfFHG7lcxq0p84VXezZp9vuz6+mQXlHhuwJpxeA0MZZGs
 fm4/KaKrglwMrjs8VltLMbcjXvFmqpsr9QwMMH6V1aKDwoyhq+6aSkUuf
 KFpoHbnxL4azSeJ4S4FPznBOes67SdLKEnvd2uxhYU+TK0WgEoNXr3SUt
 mznLTxfryHIrFmeTwLQVsu8fu1gsgAfMaULQxsMqCRo6x0+3LIG6Fd1Ew
 +SM3YNtksxqi7LdMdgfDNEJrKZOaWwXYDy5PUY9n4Y3ksoLM55ikyiI4L A==;
X-CSE-ConnectionGUID: 9PflvZYzR2WlDRBHfiRdjA==
X-CSE-MsgGUID: 5hhnMynjT5OeNCwgbJ9QnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67102355"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="67102355"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 20:52:08 -0700
X-CSE-ConnectionGUID: eofsMfssQD2MqL7cpHotRA==
X-CSE-MsgGUID: sQD6NKesRUeJeqMnYzvSrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184399414"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 20:52:04 -0700
Message-ID: <30f9d0b9-0a27-4b78-9633-8912bc18998b@intel.com>
Date: Fri, 24 Oct 2025 11:52:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] kvm: Detect guest-memfd flags supported
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Chenyi Qiang <chenyi.qiang@intel.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Juraj Marcin <jmarcin@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-4-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251023185913.2923322-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
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
> Detect supported guest-memfd flags by the current kernel, and reject
> creations of guest-memfd using invalid flags.  When the cap isn't
> available, then no flag is supported.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 1425dfd8b3..48a8f6424f 100644
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
> @@ -2781,6 +2782,11 @@ static int kvm_init(AccelState *as, MachineState *ms)
>       kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
>       kvm_guest_memfd_supported = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
>           kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
> +    ret = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
> +    if (ret > 0)
> +        kvm_guest_memfd_flags_supported = (uint64_t)ret;
> +    else
> +        kvm_guest_memfd_flags_supported = 0;

Nit:
1. QEMU's coding style always requires curly braces.
2. is the (uint64_t) necessary?
3. can we name it "kvm_supported_guest_memfd_flags" to make it 
consistent with "kvm_supported_memory_attributes"?

so how about

kvm_supported_guest_memfd_flags = kvm_vm_check_extension(s, 
KVM_CAP_GUEST_MEMFD_FLAGS);
     if (kvm_supported_guest_memfd_flags < 0) {
         kvm_supported_guest_memfd_flags = 0;
     }

>       kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
>   
>       if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
> @@ -4486,6 +4492,12 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>           return -1;
>       }
>   
> +    if (flags & ~kvm_guest_memfd_flags_supported) {
> +        error_setg(errp, "KVM does not support guest-memfd flag: 0x%"PRIx64,
> +                   flags & ~kvm_guest_memfd_flags_supported);
> +        return -1;
> +    }
> +
>       fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
>       if (fd < 0) {
>           error_setg_errno(errp, errno, "Error creating KVM guest_memfd");


