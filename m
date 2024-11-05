Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2B8D12692
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8I6X-0003bx-Ms; Tue, 05 Nov 2024 06:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8I6V-0003bT-C4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:52:11 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8I6S-0001w0-1H
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730807528; x=1762343528;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=m0AxebZpLKwG+X7WVmxENM8YETuuhBkUO8Y2bjFZTF0=;
 b=D4z180lpngRICQdP0x2+Rj+U33hh3j+8TxH4oyGLmfoMsTunpIYzkVJO
 sj9ToysPSy1hWxl2Ccm2/TXwR0Oh0CtO8tX+Kame/cyTlOih28Tsahoyb
 pMOGZ4hFp+htO1DokbJ1u65mJk10/VQGT6ERwkcklEaZgOiAziG2aSpRV
 x6uwTSqhX5rpsl7pQtO9RbwsKTBVz9GRF+1mhpEb6KhG9atT8XrhoPOqZ
 +wZwp5PM76PAnxogiiHezyBERG3Llbzo1Tgq9tEzfxwJDfaKfXgDgA6i9
 cuQcw00l9zUYqsSOWrm0g6vL7FTxpEAn+3h3EnuALHlMM6SzCiaSS7DQM Q==;
X-CSE-ConnectionGUID: 8zAa0b2bTHytOEA3DDuuGg==
X-CSE-MsgGUID: zM5JopBuTpyEmwFGSaOp8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41096683"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="41096683"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:52:03 -0800
X-CSE-ConnectionGUID: kzJOCxgrQS25AqBT3aoJpg==
X-CSE-MsgGUID: avDtaManRsGA1HiflDMgAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="88767643"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:51:59 -0800
Message-ID: <f0283ac7-31bb-4d59-b45d-046f3e582d55@intel.com>
Date: Tue, 5 Nov 2024 19:51:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/60] i386/tdx: Initialize TDX before creating TD vcpus
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-10-xiaoyao.li@intel.com>
 <Zyn0oBKvOC9rvcqk@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Zyn0oBKvOC9rvcqk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/5/2024 6:34 PM, Daniel P. Berrangé wrote:
> On Tue, Nov 05, 2024 at 01:23:17AM -0500, Xiaoyao Li wrote:
>> Invoke KVM_TDX_INIT in kvm_arch_pre_create_vcpu() that KVM_TDX_INIT
>> configures global TD configurations, e.g. the canonical CPUID config,
>> and must be executed prior to creating vCPUs.
>>
>> Use kvm_x86_arch_cpuid() to setup the CPUID settings for TDX VM.
>>
>> Note, this doesn't address the fact that QEMU may change the CPUID
>> configuration when creating vCPUs, i.e. punts on refactoring QEMU to
>> provide a stable CPUID config prior to kvm_arch_init().
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> Changes in v6:
>> - setup xfam explicitly to fit with new uapi;
>> - use tdx_caps->cpuid to filter the input of cpuids because now KVM only
>>    allows the leafs that reported via KVM_TDX_GET_CAPABILITIES;
>>
>> Changes in v4:
>> - mark init_vm with g_autofree() and use QEMU_LOCK_GUARD() to eliminate
>>    the goto labels; (Daniel)
>> Changes in v3:
>> - Pass @errp in tdx_pre_create_vcpu() and pass error info to it. (Daniel)
>> ---
>>   accel/kvm/kvm-all.c         |  8 ++++
>>   target/i386/kvm/kvm.c       | 15 +++++--
>>   target/i386/kvm/kvm_i386.h  |  3 ++
>>   target/i386/kvm/meson.build |  2 +-
>>   target/i386/kvm/tdx-stub.c  |  8 ++++
>>   target/i386/kvm/tdx.c       | 87 +++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h       |  6 +++
>>   7 files changed, 125 insertions(+), 4 deletions(-)
>>   create mode 100644 target/i386/kvm/tdx-stub.c
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 1732fa1adecd..4a1c9950894c 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -536,8 +536,15 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>   
>>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   
>> +    /*
>> +     * tdx_pre_create_vcpu() may call cpu_x86_cpuid(). It in turn may call
>> +     * kvm_vm_ioctl(). Set cpu->kvm_state in advance to avoid NULL pointer
>> +     * dereference.
>> +     */
>> +    cpu->kvm_state = s;
>>       ret = kvm_arch_pre_create_vcpu(cpu, errp);
>>       if (ret < 0) {
>> +        cpu->kvm_state = NULL;
>>           goto err;
>>       }
>>   
>> @@ -546,6 +553,7 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>           error_setg_errno(errp, -ret,
>>                            "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
>>                            kvm_arch_vcpu_id(cpu));
>> +        cpu->kvm_state = NULL;
>>           goto err;
>>       }
>>   
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index afbf67a7fdaa..db676c1336ab 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -38,6 +38,7 @@
>>   #include "kvm_i386.h"
>>   #include "../confidential-guest.h"
>>   #include "sev.h"
>> +#include "tdx.h"
>>   #include "xen-emu.h"
>>   #include "hyperv.h"
>>   #include "hyperv-proto.h"
>> @@ -1824,9 +1825,8 @@ static void kvm_init_nested_state(CPUX86State *env)
>>       }
>>   }
>>   
>> -static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>> -                                    struct kvm_cpuid_entry2 *entries,
>> -                                    uint32_t cpuid_i)
>> +uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
>> +                             uint32_t cpuid_i)
>>   {
>>       uint32_t limit, i, j;
>>       uint32_t unused;
>> @@ -2358,6 +2358,15 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>       return r;
>>   }
>>   
>> +int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>> +{
>> +    if (is_tdx_vm()) {
>> +        return tdx_pre_create_vcpu(cpu, errp);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   int kvm_arch_destroy_vcpu(CPUState *cs)
>>   {
>>       X86CPU *cpu = X86_CPU(cs);
>> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
>> index efb0883bd968..b1baf9e7f910 100644
>> --- a/target/i386/kvm/kvm_i386.h
>> +++ b/target/i386/kvm/kvm_i386.h
>> @@ -24,6 +24,9 @@
>>   #define kvm_ioapic_in_kernel() \
>>       (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
>>   
>> +uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
>> +                             uint32_t cpuid_i);
>> +
>>   #else
>>   
>>   #define kvm_pit_in_kernel()      0
>> diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
>> index 466bccb9cb17..3f44cdedb758 100644
>> --- a/target/i386/kvm/meson.build
>> +++ b/target/i386/kvm/meson.build
>> @@ -8,7 +8,7 @@ i386_kvm_ss.add(files(
>>   
>>   i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
>>   
>> -i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'))
>> +i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'), if_false: files('tdx-stub.c'))
>>   
>>   i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
>>   
>> diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
>> new file mode 100644
>> index 000000000000..b614b46d3f4a
>> --- /dev/null
>> +++ b/target/i386/kvm/tdx-stub.c
>> @@ -0,0 +1,8 @@
>> +#include "qemu/osdep.h"
>> +
>> +#include "tdx.h"
>> +
>> +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>> +{
>> +    return -EINVAL;
>> +}
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index ff3ef9bd8657..1b7894e43c6f 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -137,6 +137,91 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
>>       return KVM_X86_TDX_VM;
>>   }
>>   
>> +static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
>> +{
>> +    CPUX86State *env = &x86cpu->env;
>> +    uint64_t xfam;
>> +
>> +    xfam = env->features[FEAT_XSAVE_XCR0_LO] |
>> +           env->features[FEAT_XSAVE_XCR0_HI] |
>> +           env->features[FEAT_XSAVE_XSS_LO] |
>> +           env->features[FEAT_XSAVE_XSS_HI];
>> +
>> +    if (xfam & ~tdx_caps->supported_xfam) {
>> +        error_setg(errp, "Invalid XFAM 0x%lx for TDX VM (supported: 0x%llx))",
>> +                   xfam, tdx_caps->supported_xfam);
>> +        return -1;
>> +    }
>> +
>> +    tdx_guest->xfam = xfam;
>> +    return 0;
>> +}
>> +
>> +static void tdx_filter_cpuid(struct kvm_cpuid2 *cpuids)
>> +{
>> +    int i, dest_cnt = 0;
>> +    struct kvm_cpuid_entry2 *src, *dest, *conf;
>> +
>> +    for (i = 0; i < cpuids->nent; i++) {
>> +        src = cpuids->entries + i;
>> +        conf = cpuid_find_entry(&tdx_caps->cpuid, src->function, src->index);
>> +        if (!conf) {
>> +            continue;
>> +        }
>> +        dest = cpuids->entries + dest_cnt;
>> +
>> +        dest->function = src->function;
>> +        dest->index = src->index;
>> +        dest->flags = src->flags;
>> +        dest->eax = src->eax & conf->eax;
>> +        dest->ebx = src->ebx & conf->ebx;
>> +        dest->ecx = src->ecx & conf->ecx;
>> +        dest->edx = src->edx & conf->edx;
>> +
>> +        dest_cnt++;
>> +    }
>> +    cpuids->nent = dest_cnt++;
>> +}
>> +
>> +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>> +{
>> +    X86CPU *x86cpu = X86_CPU(cpu);
>> +    CPUX86State *env = &x86cpu->env;
>> +    g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>> +    int r = 0;
>> +
>> +    QEMU_LOCK_GUARD(&tdx_guest->lock);
>> +    if (tdx_guest->initialized) {
>> +        return r;
>> +    }
>> +
>> +    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>> +                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>> +
>> +    r = setup_td_xfam(x86cpu, errp);
>> +    if (r) {
>> +        return r;
>> +    }
>> +
>> +    init_vm->cpuid.nent = kvm_x86_build_cpuid(env, init_vm->cpuid.entries, 0);
>> +    tdx_filter_cpuid(&init_vm->cpuid);
>> +
>> +    init_vm->attributes = tdx_guest->attributes;
>> +    init_vm->xfam = tdx_guest->xfam;
>> +
>> +    do {
>> +        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm);
>> +    } while (r == -EAGAIN);
> 
> Other calls to tdx_vm_ioctl don't loop on EAGAIN. Is the need to
> do this retry specific to only KVM_TDX_INIT_VM, or should we push
> the EAGAIN retry logic inside tdx_vm_ioctl_helper so all callers
> benefit ?

So far, only KVM_TDX_INIT_VM can get -EAGAIN due to KVM side 
TDH_MNG_CREATE gets TDX_RND_NO_ENTROPY because Random number generation 
(e.g., RDRAND or RDSEED) failed and in this case it should retry.

I think adding a commment to explain why it can get -EAGAIN and needs to 
retry should suffice?

>> +    if (r < 0) {
>> +        error_setg_errno(errp, -r, "KVM_TDX_INIT_VM failed");
>> +        return r;
>> +    }
>> +
>> +    tdx_guest->initialized = true;
>> +
>> +    return 0;
>> +}
> 
> With regards,
> Daniel


