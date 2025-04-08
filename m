Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40236C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 02:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1yqw-0004Vb-KY; Mon, 07 Apr 2025 22:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u1yqi-0004Uu-Mz
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 22:38:07 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u1yqf-0000tR-15
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 22:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744079881; x=1775615881;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vIPLsrfZJ0bLnSH54TT/qs9FQeX+cOvozcNTDRmj0bw=;
 b=Y5bAZtmuPYGb3qGg7xq0p/QOB/9/YJdMTUdqVvFUna6Bgx4RN2Q1nyAi
 /sZHOXLiL8ASmPKGvyVvpyxhcfnIPruSUNuGK5u37l1JqzZVXeD63B3mY
 s9Y0PVNdxmHVey05u1k+59RE6Rrai0J9NugzHluhQcOrcjc5v1gZwl6RT
 /Yx9wvPDV347mhpuSfQ61xA0YZq4KzxLxdLCmcZOBH3OqMMvyyYvhD7QM
 3ShWIFfXNR0n1RjHgpi9DibOrtv98r7GtjbgMjeawN8vSnH2ZeVXUTS3U
 8rwZ9RX0llOYsltdkGupAYpYHtlt7iNkOpmOqbtnAskY6C8npeT08AEM3 A==;
X-CSE-ConnectionGUID: 4okLrlqfStmePIfObfTBhg==
X-CSE-MsgGUID: Lh6//TiRQXGeaxYBCGiIXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56473991"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; d="scan'208";a="56473991"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 19:37:57 -0700
X-CSE-ConnectionGUID: fPpm8y+vQOu19j4jso+meg==
X-CSE-MsgGUID: ZvszTiUaT5mFn1VdlK0xrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; d="scan'208";a="151315060"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 19:37:54 -0700
Message-ID: <54c19255-0b05-4f50-83a5-256567724df4@intel.com>
Date: Tue, 8 Apr 2025 10:37:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/55] i386/tdx: Initialize TDX before creating TD vcpus
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-9-xiaoyao.li@intel.com> <Z-0iV-xIeu0hoaaC@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z-0iV-xIeu0hoaaC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/2/2025 7:41 PM, Daniel P. Berrangé wrote:
> On Tue, Apr 01, 2025 at 09:01:18AM -0400, Xiaoyao Li wrote:
>> Invoke KVM_TDX_INIT_VM in kvm_arch_pre_create_vcpu() that
>> KVM_TDX_INIT_VM configures global TD configurations, e.g. the canonical
>> CPUID config, and must be executed prior to creating vCPUs.
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
>> Changes in v8:
>> - Drop the code that initializes cpu->kvm_state before
>>    kvm_arch_pre_create_vcpu() because it's not needed anymore.
>>
>> Changes in v7:
>> - Add comments to explain why KVM_TDX_INIT_VM should retry on -EAGAIN;
>> - Add retry limit of 10000 times for -EAGAIN on KVM_TDX_INIT_VM;
>>
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
>>   target/i386/kvm/kvm.c       |  16 +++---
>>   target/i386/kvm/kvm_i386.h  |   5 ++
>>   target/i386/kvm/meson.build |   2 +-
>>   target/i386/kvm/tdx-stub.c  |  10 ++++
>>   target/i386/kvm/tdx.c       | 105 ++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h       |   6 +++
>>   6 files changed, 137 insertions(+), 7 deletions(-)
>>   create mode 100644 target/i386/kvm/tdx-stub.c
> 
> 
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 16f67e18ae78..0afaf739c09f 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
> 
>> +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>> +{
>> +    X86CPU *x86cpu = X86_CPU(cpu);
>> +    CPUX86State *env = &x86cpu->env;
>> +    g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>> +    Error *local_err = NULL;
>> +    int retry = 10000;
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
>> +    /*
>> +     * KVM_TDX_INIT_VM gets -EAGAIN when KVM side SEAMCALL(TDH_MNG_CREATE)
>> +     * gets TDX_RND_NO_ENTROPY due to Random number generation (e.g., RDRAND or
>> +     * RDSEED) is busy.
>> +     *
>> +     * Retry for the case.
>> +     */
>> +    do {
>> +        error_free(local_err);
>> +        local_err = NULL;
>> +        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm, &local_err);
>> +    } while (r == -EAGAIN && --retry);
>> +
>> +    if (r < 0) {
>> +        if (!retry) {
>> +            error_report("Hardware RNG (Random Number Generator) is busy "
>> +                         "occupied by someone (via RDRAND/RDSEED) maliciously, "
>> +                         "which leads to KVM_TDX_INIT_VM keeping failure "
>> +                         "due to lack of entropy.");
> 
> This needs to be
> 
>       error_append_hint(local_err, ....);
> 
> so that this message gets associated with the error object that
> is propagated, and the top level will print it all at once.

Good suggestion! Will change to it in the next version.

>> +        }
>> +        error_propagate(errp, local_err);
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


