Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32B8D3E797
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 06:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTab7-000871-09; Thu, 11 Dec 2025 01:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTab5-00085d-38
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:56:19 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTab3-0002r2-FA
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765436177; x=1796972177;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hwV6SO4dnMAkdF+7KToIlu3XTOdCNR+uEY9rLZTHs4I=;
 b=nLD1ZtTxJtgwxEB5d6Ty/rhid+gaqWabpDNvFXWdzwkTCWuPKJ9F6O6t
 n+982KuI6MAfU1upJsxkPOwg1cE4FujumHoRfPlalOCNPEhQse8mCRjEF
 seXrbn6ONeAFud1AbvrXFlJNPsnHwvQGv/FfELKwz76tVplswgZP1qdAC
 0lBl/hccjXRkxdowMRs/OD6CVfNPhtrFGWo1CNT2sG3uMU4addCkOXiaO
 i+sWd+PGgMgUMDFPvuS6TLl6sYd85GwzoFb99XjApq+S660Dg/A/cjlkX
 JFIVJnsdTvnPM4yPdAcp3u0crWbTFAwGMRRD4/aa8jz3N/EGIOZbuhbSA g==;
X-CSE-ConnectionGUID: y6QNUm9QQLmHWvHINvh6yw==
X-CSE-MsgGUID: VThL5qrvQJKOjcc7cbxD3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="85021699"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="85021699"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:56:15 -0800
X-CSE-ConnectionGUID: mZSZsQsjSzKoBkMpL8jNgw==
X-CSE-MsgGUID: 3RnaMyYzSc60hNi/p896Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="201817078"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:56:13 -0800
Message-ID: <1f119eca-d3c0-4b32-9c37-c82921245d6d@intel.com>
Date: Thu, 11 Dec 2025 14:56:09 +0800
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
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
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

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

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
> +                   flags & ~kvm_guest_memfd_flags_supported);
> +        return -1;
> +    }
> +
>       fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
>       if (fd < 0) {
>           error_setg_errno(errp, errno, "Error creating KVM guest_memfd");


