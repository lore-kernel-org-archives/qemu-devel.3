Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C949AC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 15:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rngTq-00055f-CI; Fri, 22 Mar 2024 11:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rngTo-00053e-7Y
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:06:48 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rngTl-0000Iv-Jg
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711120005; x=1742656005;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=o6YgWdJ2W/tOSmBuB3lQOVrBKLc7RJHcQpsAomtOSb4=;
 b=iJbRrBFLf4G24ym9uPFOl0xyAU+DN2iKoGLwCXKxPzCsC5LPrf5gDElg
 2IsK6srodiGSokrty83DL/rP2ra547ce9PsjIZdQH0E+E9Lksz0V7TGg2
 EOuGmS6aAU1rM1rc8dHYKzPyTBNWMI6nsKc8NB71216EK76LIqro2IfWb
 Met7JCQob/+S8eIQDb0mQf06w1digZ7q91zKZ59HPna6KUJShXC5N/4ov
 00Az+4ShDuiKETkgAly6WN2p7WZ8izF5ZeXHvmyMNTrDfREqDeM90EUdG
 XwGlmdWmBWZVXW4EFxmVhQryuh8kEh5QIzRQzU9ghkST+dhVwI8wIXGoG A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16898039"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; d="scan'208";a="16898039"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2024 08:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; d="scan'208";a="45924190"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2024 08:06:39 -0700
Message-ID: <0cca95e9-cde3-4139-8159-7de68d58fc83@intel.com>
Date: Fri, 22 Mar 2024 23:06:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/i386: Implement mc->kvm_type() to get VM type
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com
References: <20240319140000.1014247-1-pbonzini@redhat.com>
 <20240319140000.1014247-7-pbonzini@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240319140000.1014247-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 3/19/2024 9:59 PM, Paolo Bonzini wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> KVM is introducing a new API to create confidential guests, which
> will be used by TDX and SEV-SNP but is also available for SEV and
> SEV-ES.  The API uses the VM type argument to KVM_CREATE_VM to
> identify which confidential computing technology to use.
> 
> Since there are no other expected uses of VM types, delegate
> mc->kvm_type() for x86 boards to the confidential-guest-support
> object pointed to by ms->cgs.
> 
> For example, if a sev-guest object is specified to confidential-guest-support,
> like,
> 
>    qemu -machine ...,confidential-guest-support=sev0 \
>         -object sev-guest,id=sev0,...
> 
> it will check if a VM type KVM_X86_SEV_VM or KVM_X86_SEV_ES_VM
> is supported, and if so use them together with the KVM_SEV_INIT2
> function of the KVM_MEMORY_ENCRYPT_OP ioctl. If not, it will fall back to
> KVM_SEV_INIT and KVM_SEV_ES_INIT.
> 
> This is a preparatory work towards TDX and SEV-SNP support, but it
> will also enable support for VMSA features such as DebugSwap, which
> are only available via KVM_SEV_INIT2.
> 
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

some nits below.

> ---
>   target/i386/confidential-guest.h | 19 ++++++++++++++
>   target/i386/kvm/kvm_i386.h       |  2 ++
>   hw/i386/x86.c                    |  6 +++++
>   target/i386/kvm/kvm.c            | 44 ++++++++++++++++++++++++++++++++
>   4 files changed, 71 insertions(+)
> 
> diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
> index ca12d5a8fba..532e172a60b 100644
> --- a/target/i386/confidential-guest.h
> +++ b/target/i386/confidential-guest.h
> @@ -36,5 +36,24 @@ struct X86ConfidentialGuest {
>   struct X86ConfidentialGuestClass {
>       /* <private> */
>       ConfidentialGuestSupportClass parent;
> +
> +    /* <public> */
> +    int (*kvm_type)(X86ConfidentialGuest *cg);
>   };
> +
> +/**
> + * x86_confidential_guest_kvm_type:
> + *
> + * Calls #X86ConfidentialGuestClass.unplug callback of @plug_handler.

ah, forgot to change the callback name after copy+paste.

> + */
> +static inline int x86_confidential_guest_kvm_type(X86ConfidentialGuest *cg)
> +{
> +    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
> +
> +    if (klass->kvm_type) {
> +        return klass->kvm_type(cg);
> +    } else {
> +        return 0;
> +    }
> +}
>   #endif
> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> index 30fedcffea3..02168122787 100644
> --- a/target/i386/kvm/kvm_i386.h
> +++ b/target/i386/kvm/kvm_i386.h
> @@ -37,6 +37,7 @@ bool kvm_hv_vpindex_settable(void);
>   bool kvm_enable_sgx_provisioning(KVMState *s);
>   bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
>   
> +int kvm_get_vm_type(MachineState *ms, const char *vm_type);
>   void kvm_arch_reset_vcpu(X86CPU *cs);
>   void kvm_arch_after_reset_vcpu(X86CPU *cpu);
>   void kvm_arch_do_init_vcpu(X86CPU *cs);
> @@ -49,6 +50,7 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask);
>   
>   #ifdef CONFIG_KVM
>   
> +bool kvm_is_vm_type_supported(int type);
>   bool kvm_has_adjust_clock_stable(void);
>   bool kvm_has_exception_payload(void);
>   void kvm_synchronize_all_tsc(void);
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index ffbda48917f..2d4b148cd25 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -1389,6 +1389,11 @@ static void machine_set_sgx_epc(Object *obj, Visitor *v, const char *name,
>       qapi_free_SgxEPCList(list);
>   }
>   
> +static int x86_kvm_type(MachineState *ms, const char *vm_type)
> +{
> +    return kvm_enabled() ? kvm_get_vm_type(ms, vm_type) : 0;
> +}
> +
>   static void x86_machine_initfn(Object *obj)
>   {
>       X86MachineState *x86ms = X86_MACHINE(obj);
> @@ -1413,6 +1418,7 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
>       mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
>       mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
>       mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
> +    mc->kvm_type = x86_kvm_type;
>       x86mc->save_tsc_khz = true;
>       x86mc->fwcfg_dma_enabled = true;
>       nc->nmi_monitor_handler = x86_nmi;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 0ec69109a2b..e109648f260 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -31,6 +31,7 @@
>   #include "sysemu/kvm_int.h"
>   #include "sysemu/runstate.h"
>   #include "kvm_i386.h"
> +#include "../confidential-guest.h"
>   #include "sev.h"
>   #include "xen-emu.h"
>   #include "hyperv.h"
> @@ -161,6 +162,49 @@ static KVMMSRHandlers msr_handlers[KVM_MSR_FILTER_MAX_RANGES];
>   static RateLimit bus_lock_ratelimit_ctrl;
>   static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
>   
> +static const char *vm_type_name[] = {
> +    [KVM_X86_DEFAULT_VM] = "default",
> +};
> +
> +bool kvm_is_vm_type_supported(int type)
> +{
> +    uint32_t machine_types;

The name of machine_types confuses me a lot. why not supported_vm_types?

> +
> +    /*
> +     * old KVM doesn't support KVM_CAP_VM_TYPES but KVM_X86_DEFAULT_VM
> +     * is always supported
> +     */
> +    if (type == KVM_X86_DEFAULT_VM) {
> +        return true;
> +    }
> +
> +    machine_types = kvm_check_extension(KVM_STATE(current_machine->accelerator),
> +                                        KVM_CAP_VM_TYPES);
> +    return !!(machine_types & BIT(type));
> +}
> +
> +int kvm_get_vm_type(MachineState *ms, const char *vm_type)
> +{
> +    int kvm_type = KVM_X86_DEFAULT_VM;
> +
> +    if (ms->cgs) {
> +        if (!object_dynamic_cast(OBJECT(ms->cgs), TYPE_X86_CONFIDENTIAL_GUEST)) {
> +            error_report("configuration type %s not supported for x86 guests",
> +                         object_get_typename(OBJECT(ms->cgs)));
> +            exit(1);
> +        }
> +        kvm_type = x86_confidential_guest_kvm_type(
> +            X86_CONFIDENTIAL_GUEST(ms->cgs));
> +    }
> +
> +    if (!kvm_is_vm_type_supported(kvm_type)) {
> +        error_report("vm-type %s not supported by KVM", vm_type_name[kvm_type]);
> +        exit(1);
> +    }
> +
> +    return kvm_type;
> +}
> +
>   bool kvm_has_smm(void)
>   {
>       return kvm_vm_check_extension(kvm_state, KVM_CAP_X86_SMM);


