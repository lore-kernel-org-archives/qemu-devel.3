Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C07FD5C0C0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 04:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVMHh-0004wL-T1; Mon, 15 Dec 2025 23:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVMHf-0004w4-Nh
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 23:03:35 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVMHc-0002Sa-Nj
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 23:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765857813; x=1797393813;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=abwON3E2YIcE9S2F0i3N+pRkbKI9cTBnYNU+r8JpAtg=;
 b=El9dYVxnKTxUcPjr5OrgsGhHFDboE5UOkjSRixEa4rl7aMUsxOa9OiI8
 jRIYhx3SuU4RWD7dIAO8jZ8CgvkDAt1888mVVs2KvzNt9yrqzJ1QBeXiU
 zIhCjirjld7VbkeEvjxE/Ceca/Vc9PDdWeRBIFxS3a0Kkf72dyfX/s71c
 zTKDxiDCrS9nxYARnqXufihOavuQsLoZMDqJlj2hJp+EutRbAhSRTPHop
 sR8g8hUMymp+E9RbCX86nxKad//Jb/JsjBkx6u+zMD0A/NXTFImVWB1dB
 Qd1q5C1kxVjwOP9kvvYbuWCR9d+LQR2ilMCfW3jPzRCfgyX19hmxEjSrl Q==;
X-CSE-ConnectionGUID: T3YsbYwFR4mYTmTT46a+hg==
X-CSE-MsgGUID: SUABE54hQv6MYqxYhYk27w==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="71625191"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="71625191"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 20:03:28 -0800
X-CSE-ConnectionGUID: nBcm3xRTQtWdPcExUtLYhQ==
X-CSE-MsgGUID: CMS332vtQIWdiZRlm7i41w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="221271804"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 20:03:25 -0800
Message-ID: <ca14008d-e9fe-4185-bc09-915ecd9b99fa@intel.com>
Date: Tue, 16 Dec 2025 12:03:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-4-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251215205203.1185099-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
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

On 12/16/2025 4:51 AM, Peter Xu wrote:
> So that there will be a verbal string returned when kvm not enabled, or kvm
> not compiled.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

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
>   


