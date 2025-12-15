Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA10ED59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 02:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUylx-0002WW-Ih; Sun, 14 Dec 2025 21:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vUylt-0002W6-Ba
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 21:57:13 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vUylq-0003c1-5y
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 21:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765767430; x=1797303430;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=afAcQzxeWF59zCX64zClLvrKT6yOR52rSHxbHr+YOMM=;
 b=I0xMWVFTO1S6r8umYnjQ3SyzbWxUef3LnKWJ2PvyQYkBJh8rHXEQHQet
 VTNg6GhvUTewingcyH3AQu3TbszHVUBCbqa8/gUh1SKK3WWtI/3p53sAO
 XCsPJQqYdfaOFsILZppOOzi8w/cEllbnNpFaTBoJ0Xrk0neghhAvDV02o
 XOCHASoGBMliIPwoO3kCYDzSdE+FZxtNWWih5LPKOdUzE4dTLNCPWu9EO
 8Q/BsSbQ14R36QinS00ltv52pmP+JXPrZSPGAPVvv2UGf/+19aj3eUmP5
 etcN5l5+qCRqYYJ6GU6/gM4wDc5LpBR/WsMODwaAekVIBYdpJHAcLD7aT g==;
X-CSE-ConnectionGUID: miJFmSi0S5asK+jJgzs9kA==
X-CSE-MsgGUID: iCkv3m+YRC+MXJ+nE9dPeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="67551352"
X-IronPort-AV: E=Sophos;i="6.21,148,1763452800"; d="scan'208";a="67551352"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 18:57:06 -0800
X-CSE-ConnectionGUID: 5G/D9F4DQcaU+1zEn6rX8A==
X-CSE-MsgGUID: 3uf/zNm/RCymv8KM5WuUeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,148,1763452800"; d="scan'208";a="228679385"
Received: from unknown (HELO [10.238.0.255]) ([10.238.0.255])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 18:57:05 -0800
Message-ID: <e340ef03-13de-4d3b-a290-b42bd245272f@intel.com>
Date: Mon, 15 Dec 2025 10:57:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] hostmem: Support in-place guest memfd to back a VM
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-8-peterx@redhat.com>
 <2ee4383c-f21f-448e-ac3f-2b621d687bf2@intel.com> <aTrw6Xtg_GRh1DQO@x1.local>
 <b9309d98-381b-4531-925c-a4558be1428a@intel.com> <aTxT1SLlqhfb4QZZ@x1.local>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aTxT1SLlqhfb4QZZ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
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

On 12/13/2025 1:41 AM, Peter Xu wrote:
>>>> please add the following check as I commented in v1:
>>>>
>>>> 	if (!kvm_enabled()) {
>>>> 		error_setg(errp, "in-place guest-memfd requires KVM");
>>>> 		return false;
>>>> 	}
>>> IMHO it's redundant to set here, when kvm not enabled,
>>> kvm_create_guest_memfd() should be a stub.
>> No. The KVM stub is for the case where KVM is disable at compile time.
>>
>> The kvm_enabled() check here is for the case where users use different
>> accelerators other than KVM, e.g., -accel tcg.
> I thought the kvm-compiled case is already covered, at least the flags will
> be 0 here:
> 
>      if (!kvm_guest_memfd_supported) {
>          error_setg(errp, "KVM does not support guest_memfd");
>          return -1;
>      }
> 
> So I can change below stub patch into this one, would it look better (so
> that we'll provide explicit errors for all cases)?

It looks good to me.

> ===8<===
> commit 70012ceb70d3ffe624db33a8aeaaec581c7b4ccd
> Author: Peter Xu<peterx@redhat.com>
> Date:   Thu Dec 11 11:19:44 2025 -0500
> 
>      kvm: Provide explicit error for kvm_create_guest_memfd()
>      
>      So that there will be a verbal string returned when kvm not enabled, or kvm
>      not compiled.
>      
>      Signed-off-by: Peter Xu<peterx@redhat.com>
> ---
>   accel/kvm/kvm-all.c    | 5 +++++
>   accel/stubs/kvm-stub.c | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 68d57c1af0..c32fbcf9cc 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -4492,6 +4492,11 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>           .flags = flags,
>       };
>   
> +    if (!kvm_enabled()) {
> +        error_setg(errp, "guest-memfd requires KVM accelerator");
> +        return -1;
> +    }
> +
>       if (!kvm_guest_memfd_supported) {
>           error_setg(errp, "KVM does not support guest_memfd");
>           return -1;
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 73f04eb589..01b1d6285e 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -123,6 +123,7 @@ bool kvm_hwpoisoned_mem(void)
>   
>   int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>   {
> +    error_setg(errp, "KVM is not enabled");
>       return -ENOSYS;
>   }
> ===8<===
> 
> Thanks,


