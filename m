Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A63C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzI58-0004FL-0K; Tue, 23 Apr 2024 11:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzI56-0004F3-7o
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:29:16 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzI53-00047J-5L
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713886153; x=1745422153;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1l+oidzOuvYWURUwYvvIp/OgXD5oU/xEHOAOizJw52Y=;
 b=FcbuwizKABflXI7nGDUUrX2CXbA+2spu7aKOH58WE7BorN2rdyc3mUtC
 wuQpNxbbdNAZGeN6Aj+GltMZxcHAKrmjwbRUbpmCAIgf1/7dKWEpDFpsW
 Md8X7pcWZ4z4CWHRegFwTuKujlN0sEKmJ4GFkhpmVrNOD4DAtA/EulpgD
 VK42zPm68OHAlz/AoMFmbAkg9lO1SRKb9KrGXGsTSw7o6njnnGE5kzSGa
 it1sFnd/Mcw3Czd2RKucY7sGUi5baLri5ULuYVyE7mZPAd0qGqpv7/spf
 3oXtFVCqG/DL3l4kwFdYBRP78NLpHLIko6CvVR+Fn+CmbijJ1xDqKRuMe A==;
X-CSE-ConnectionGUID: qpxu+hL5Sn+VGUh8GeALlw==
X-CSE-MsgGUID: pW/LolbnTumjXH9WjAD1/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20088520"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="20088520"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 08:29:09 -0700
X-CSE-ConnectionGUID: 3fQQfOmzRsKsyu6yn16u5A==
X-CSE-MsgGUID: 1I4mI+9vTHOnizPgeDQUmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="28901123"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 08:29:07 -0700
Message-ID: <b9043b52-5fdf-4349-8a56-c1418feb1bbd@intel.com>
Date: Tue, 23 Apr 2024 23:29:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/63] i386/kvm: Move architectural CPUID leaf generation
 to separate helper
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
 <20240423150951.41600-26-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240423150951.41600-26-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/23/2024 11:09 PM, Paolo Bonzini wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Move the architectural (for lack of a better term) CPUID leaf generation
> to a separate helper so that the generation code can be reused by TDX,
> which needs to generate a canonical VM-scoped configuration.
> 
> For now this is just a cleanup, so keep the function static.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Message-ID: <20240229063726.610065-23-xiaoyao.li@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/kvm/kvm.c | 449 +++++++++++++++++++++---------------------
>   1 file changed, 227 insertions(+), 222 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index e68cbe92930..fcf9603d3e6 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1706,6 +1706,231 @@ static void kvm_init_nested_state(CPUX86State *env)
>       }
>   }
>   
> +static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
> +                                    struct kvm_cpuid_entry2 *entries,
> +                                    uint32_t cpuid_i)
> +{
> +    uint32_t limit, i, j;
> +    uint32_t unused;
> +    struct kvm_cpuid_entry2 *c;
> +
> +    cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
> +
> +    for (i = 0; i <= limit; i++) {
> +        j = 0;
> +        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> +            goto full;
> +        }
> +        c = &entries[cpuid_i++];
> +        switch (i) {
> +        case 2: {
> +            /* Keep reading function 2 till all the input is received */
> +            int times;
> +
> +            c->function = i;
> +            c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC |
> +                       KVM_CPUID_FLAG_STATE_READ_NEXT;
> +            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +            times = c->eax & 0xff;
> +
> +            for (j = 1; j < times; ++j) {
> +                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> +                    goto full;
> +                }
> +                c = &entries[cpuid_i++];
> +                c->function = i;
> +                c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC;
> +                cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +            }
> +            break;
> +        }
> +        case 0x1f:
> +            if (env->nr_dies < 2) {
> +                cpuid_i--;
> +                break;
> +            }
> +            /* fallthrough */
> +        case 4:
> +        case 0xb:
> +        case 0xd:
> +            for (j = 0; ; j++) {
> +                if (i == 0xd && j == 64) {
> +                    break;
> +                }
> +
> +                c->function = i;
> +                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +                c->index = j;
> +                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +
> +                if (i == 4 && c->eax == 0) {
> +                    break;
> +                }
> +                if (i == 0xb && !(c->ecx & 0xff00)) {
> +                    break;
> +                }
> +                if (i == 0x1f && !(c->ecx & 0xff00)) {
> +                    break;
> +                }
> +                if (i == 0xd && c->eax == 0) {
> +                    continue;
> +                }
> +                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> +                    goto full;
> +                }
> +                c = &entries[cpuid_i++];
> +            }
> +            break;
> +        case 0x12:
> +            for (j = 0; ; j++) {
> +                c->function = i;
> +                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +                c->index = j;
> +                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +
> +                if (j > 1 && (c->eax & 0xf) != 1) {
> +                    break;
> +                }
> +
> +                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> +                    goto full;
> +                }
> +                c = &entries[cpuid_i++];
> +            }
> +            break;
> +        case 0x7:
> +        case 0x14:
> +        case 0x1d:
> +        case 0x1e: {
> +            uint32_t times;
> +
> +            c->function = i;
> +            c->index = 0;
> +            c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +            times = c->eax;
> +
> +            for (j = 1; j <= times; ++j) {
> +                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> +                    goto full;
> +                }
> +                c = &entries[cpuid_i++];
> +                c->function = i;
> +                c->index = j;
> +                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +            }
> +            break;
> +        }
> +        default:
> +            c->function = i;
> +            c->flags = 0;
> +            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
> +                /*
> +                 * KVM already returns all zeroes if a CPUID entry is missing,
> +                 * so we can omit it and avoid hitting KVM's 80-entry limit.
> +                 */
> +                cpuid_i--;
> +            }
> +            break;
> +        }
> +    }
> +
> +    if (limit >= 0x0a) {
> +        uint32_t eax, edx;
> +
> +        cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
> +
> +        has_architectural_pmu_version = eax & 0xff;
> +        if (has_architectural_pmu_version > 0) {
> +            num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
> +
> +            /* Shouldn't be more than 32, since that's the number of bits
> +             * available in EBX to tell us _which_ counters are available.
> +             * Play it safe.
> +             */
> +            if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
> +                num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
> +            }
> +
> +            if (has_architectural_pmu_version > 1) {
> +                num_architectural_pmu_fixed_counters = edx & 0x1f;
> +
> +                if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
> +                    num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
> +                }
> +            }
> +        }
> +    }
> +
> +    cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused);
> +
> +    for (i = 0x80000000; i <= limit; i++) {
> +        j = 0;
> +        c = &entries[cpuid_i++];

the order is wrong, it needs to be after the "full" check below.

> +        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> +            goto full;
> +        }
> +
> +        switch (i) {
> +        case 0x8000001d:
> +            /* Query for all AMD cache information leaves */
> +            for (j = 0; ; j++) {
> +                c->function = i;
> +                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +                c->index = j;
> +                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +
> +                if (c->eax == 0) {
> +                    break;
> +                }
> +                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> +                    goto full;
> +                }
> +                c = &entries[cpuid_i++];
> +            }
> +            break;
> +        default:
> +            c->function = i;
> +            c->flags = 0;
> +            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
> +                /*
> +                 * KVM already returns all zeroes if a CPUID entry is missing,
> +                 * so we can omit it and avoid hitting KVM's 80-entry limit.
> +                 */
> +                cpuid_i--;
> +            }
> +            break;
> +        }
> +    }


