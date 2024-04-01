Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C60BCD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 15:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrJCp-0004gt-9Z; Mon, 01 Apr 2024 11:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rrJCm-0004gf-PF
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 11:04:13 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rrJCi-0006ZI-HI
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 11:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711983848; x=1743519848;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xPpGuHd/GMWvMeoLMwJzWDzK/b/EcXCIhdiavosCfzk=;
 b=ZFwE0FIKMwJJXvwcqjSSlbIdxKKlhfCePLDdmRjNAQHwjJg+m1E3REsI
 nSkBo23s1FkJXjm3K7e6fqoF9mBLi+osPLk8ylz5+wZ/2G0gSJSEzD2o7
 5wMk493d9auMUikL5kC6UzYY0jHaJ5++mz/6AhsDmLku+eloZ9FwqtTVp
 iDn3EyG7JHrYLD8bTehTNhBXmR2vbIJqhoqNGIyQT+8Qt27xCqpH4iln1
 5Ola5ylIgRcNrgc3BbJkzRv/V1gzvo6cWkjx8dRUAdVHFYgrU3suM8mUl
 vNrMorkvV1U6GpZBwZaWfVUizoLTkc1qk0jmgIxgT0UCLLgi3cwS9EujL w==;
X-CSE-ConnectionGUID: NNMu7IoQRkGr1tFJQXV0UQ==
X-CSE-MsgGUID: JLuYjVkOQTilRTsolKNxRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18261434"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; d="scan'208";a="18261434"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2024 08:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; d="scan'208";a="18203872"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.7])
 ([10.124.224.7])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2024 08:04:02 -0700
Message-ID: <6024ca44-d91d-44d8-8698-93885ca77d39@intel.com>
Date: Mon, 1 Apr 2024 23:03:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/26] i386/kvm: Move architectural CPUID leaf generation
 to separate helper
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, david@redhat.com
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-27-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240322181116.1228416-27-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/23/2024 2:11 AM, Paolo Bonzini wrote:
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
> [Unify error reporting, rename function. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/kvm/kvm.c | 446 +++++++++++++++++++++---------------------
>   1 file changed, 224 insertions(+), 222 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 2577e345502..eab6261e1f5 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1752,6 +1752,228 @@ static void kvm_init_nested_state(CPUX86State *env)
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

here miss the check of

	if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
             goto full;
         }

Otherwise, it looks good to me.

Reviewed-by: Xiaoyao Li <xiaoyoa.li@intel.com>

> +        c = &entries[cpuid_i++];
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
> +
> +    /* Call Centaur's CPUID instructions they are supported. */
> +    if (env->cpuid_xlevel2 > 0) {
> +        cpu_x86_cpuid(env, 0xC0000000, 0, &limit, &unused, &unused, &unused);
> +
> +        for (i = 0xC0000000; i <= limit; i++) {
> +            j = 0;
> +            if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> +                goto full;
> +            }
> +            c = &entries[cpuid_i++];
> +
> +            c->function = i;
> +            c->flags = 0;
> +            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +        }
> +    }
> +
> +    return cpuid_i;
> +
> +full:
> +    fprintf(stderr, "cpuid_data is full, no space for "
> +            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
> +    abort();
> +}
> +
>   int kvm_arch_init_vcpu(CPUState *cs)
>   {
>       struct {
> @@ -1768,8 +1990,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>   
>       X86CPU *cpu = X86_CPU(cs);
>       CPUX86State *env = &cpu->env;
> -    uint32_t limit, i, j, cpuid_i;
> -    uint32_t unused;
> +    uint32_t cpuid_i;
>       struct kvm_cpuid_entry2 *c;
>       uint32_t signature[3];
>       int kvm_base = KVM_CPUID_SIGNATURE;
> @@ -1922,8 +2143,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           c->edx = env->features[FEAT_KVM_HINTS];
>       }
>   
> -    cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
> -
>       if (cpu->kvm_pv_enforce_cpuid) {
>           r = kvm_vcpu_enable_cap(cs, KVM_CAP_ENFORCE_PV_FEATURE_CPUID, 0, 1);
>           if (r < 0) {
> @@ -1934,224 +2153,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           }
>       }
>   
> -    for (i = 0; i <= limit; i++) {
> -        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> -            fprintf(stderr, "unsupported level value: 0x%x\n", limit);
> -            abort();
> -        }
> -        c = &cpuid_data.entries[cpuid_i++];
> -
> -        switch (i) {
> -        case 2: {
> -            /* Keep reading function 2 till all the input is received */
> -            int times;
> -
> -            c->function = i;
> -            c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC |
> -                       KVM_CPUID_FLAG_STATE_READ_NEXT;
> -            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> -            times = c->eax & 0xff;
> -
> -            for (j = 1; j < times; ++j) {
> -                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> -                    fprintf(stderr, "cpuid_data is full, no space for "
> -                            "cpuid(eax:2):eax & 0xf = 0x%x\n", times);
> -                    abort();
> -                }
> -                c = &cpuid_data.entries[cpuid_i++];
> -                c->function = i;
> -                c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC;
> -                cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> -            }
> -            break;
> -        }
> -        case 0x1f:
> -            if (env->nr_dies < 2) {
> -                cpuid_i--;
> -                break;
> -            }
> -            /* fallthrough */
> -        case 4:
> -        case 0xb:
> -        case 0xd:
> -            for (j = 0; ; j++) {
> -                if (i == 0xd && j == 64) {
> -                    break;
> -                }
> -
> -                c->function = i;
> -                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> -                c->index = j;
> -                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
> -
> -                if (i == 4 && c->eax == 0) {
> -                    break;
> -                }
> -                if (i == 0xb && !(c->ecx & 0xff00)) {
> -                    break;
> -                }
> -                if (i == 0x1f && !(c->ecx & 0xff00)) {
> -                    break;
> -                }
> -                if (i == 0xd && c->eax == 0) {
> -                    continue;
> -                }
> -                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> -                    fprintf(stderr, "cpuid_data is full, no space for "
> -                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
> -                    abort();
> -                }
> -                c = &cpuid_data.entries[cpuid_i++];
> -            }
> -            break;
> -        case 0x12:
> -            for (j = 0; ; j++) {
> -                c->function = i;
> -                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> -                c->index = j;
> -                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
> -
> -                if (j > 1 && (c->eax & 0xf) != 1) {
> -                    break;
> -                }
> -
> -                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> -                    fprintf(stderr, "cpuid_data is full, no space for "
> -                                "cpuid(eax:0x12,ecx:0x%x)\n", j);
> -                    abort();
> -                }
> -                c = &cpuid_data.entries[cpuid_i++];
> -            }
> -            break;
> -        case 0x7:
> -        case 0x14:
> -        case 0x1d:
> -        case 0x1e: {
> -            uint32_t times;
> -
> -            c->function = i;
> -            c->index = 0;
> -            c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> -            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> -            times = c->eax;
> -
> -            for (j = 1; j <= times; ++j) {
> -                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> -                    fprintf(stderr, "cpuid_data is full, no space for "
> -                                "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
> -                    abort();
> -                }
> -                c = &cpuid_data.entries[cpuid_i++];
> -                c->function = i;
> -                c->index = j;
> -                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> -                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
> -            }
> -            break;
> -        }
> -        default:
> -            c->function = i;
> -            c->flags = 0;
> -            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> -            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
> -                /*
> -                 * KVM already returns all zeroes if a CPUID entry is missing,
> -                 * so we can omit it and avoid hitting KVM's 80-entry limit.
> -                 */
> -                cpuid_i--;
> -            }
> -            break;
> -        }
> -    }
> -
> -    if (limit >= 0x0a) {
> -        uint32_t eax, edx;
> -
> -        cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
> -
> -        has_architectural_pmu_version = eax & 0xff;
> -        if (has_architectural_pmu_version > 0) {
> -            num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
> -
> -            /* Shouldn't be more than 32, since that's the number of bits
> -             * available in EBX to tell us _which_ counters are available.
> -             * Play it safe.
> -             */
> -            if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
> -                num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
> -            }
> -
> -            if (has_architectural_pmu_version > 1) {
> -                num_architectural_pmu_fixed_counters = edx & 0x1f;
> -
> -                if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
> -                    num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
> -                }
> -            }
> -        }
> -    }
> -
> -    cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused);
> -
> -    for (i = 0x80000000; i <= limit; i++) {
> -        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> -            fprintf(stderr, "unsupported xlevel value: 0x%x\n", limit);
> -            abort();
> -        }
> -        c = &cpuid_data.entries[cpuid_i++];
> -
> -        switch (i) {
> -        case 0x8000001d:
> -            /* Query for all AMD cache information leaves */
> -            for (j = 0; ; j++) {
> -                c->function = i;
> -                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> -                c->index = j;
> -                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
> -
> -                if (c->eax == 0) {
> -                    break;
> -                }
> -                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> -                    fprintf(stderr, "cpuid_data is full, no space for "
> -                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
> -                    abort();
> -                }
> -                c = &cpuid_data.entries[cpuid_i++];
> -            }
> -            break;
> -        default:
> -            c->function = i;
> -            c->flags = 0;
> -            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> -            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
> -                /*
> -                 * KVM already returns all zeroes if a CPUID entry is missing,
> -                 * so we can omit it and avoid hitting KVM's 80-entry limit.
> -                 */
> -                cpuid_i--;
> -            }
> -            break;
> -        }
> -    }
> -
> -    /* Call Centaur's CPUID instructions they are supported. */
> -    if (env->cpuid_xlevel2 > 0) {
> -        cpu_x86_cpuid(env, 0xC0000000, 0, &limit, &unused, &unused, &unused);
> -
> -        for (i = 0xC0000000; i <= limit; i++) {
> -            if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> -                fprintf(stderr, "unsupported xlevel2 value: 0x%x\n", limit);
> -                abort();
> -            }
> -            c = &cpuid_data.entries[cpuid_i++];
> -
> -            c->function = i;
> -            c->flags = 0;
> -            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> -        }
> -    }
> -
> +    cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
>       cpuid_data.cpuid.nent = cpuid_i;
>   
>       if (((env->cpuid_version >> 8)&0xF) >= 6


