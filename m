Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8225FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaFT-0001lw-Me; Tue, 19 Mar 2024 10:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmaFO-0001kl-71
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmaFH-00037o-Pu
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710857712;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=U3k1szDgkBmVCxczl3PRQZVYiTM0z0OWoBqF7mQu2hs=;
 b=DIDHw0IrA17ACJnMIxPMZKhTxXmOO+/ZgkLkRLl42HuAdZNVqIhnwDvFvy2mzGP/D2OvG2
 p1dP2J+/2a71da+BgixxawUh3VLbGYBQG2mzXhZxGzfbtvkgwL3I/3BvUq6STZF9RmKQlq
 5KZR02/1Sor8DZdcnjxJfrCPJXC8s8U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ZwmitBaHPdOqnWp8HpbRgg-1; Tue, 19 Mar 2024 10:15:10 -0400
X-MC-Unique: ZwmitBaHPdOqnWp8HpbRgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59141889064;
 Tue, 19 Mar 2024 14:15:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2C4610F53;
 Tue, 19 Mar 2024 14:15:09 +0000 (UTC)
Date: Tue, 19 Mar 2024 14:15:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, michael.roth@amd.com
Subject: Re: [PATCH 6/7] target/i386: Implement mc->kvm_type() to get VM type
Message-ID: <Zfmd55tus3nV5DJV@redhat.com>
References: <20240319140000.1014247-1-pbonzini@redhat.com>
 <20240319140000.1014247-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319140000.1014247-7-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 19, 2024 at 02:59:59PM +0100, Paolo Bonzini wrote:
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
>   qemu -machine ...,confidential-guest-support=sev0 \
>        -object sev-guest,id=sev0,...
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
> ---
>  target/i386/confidential-guest.h | 19 ++++++++++++++
>  target/i386/kvm/kvm_i386.h       |  2 ++
>  hw/i386/x86.c                    |  6 +++++
>  target/i386/kvm/kvm.c            | 44 ++++++++++++++++++++++++++++++++
>  4 files changed, 71 insertions(+)
> 
> diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
> index ca12d5a8fba..532e172a60b 100644
> --- a/target/i386/confidential-guest.h
> +++ b/target/i386/confidential-guest.h
> @@ -36,5 +36,24 @@ struct X86ConfidentialGuest {
>  struct X86ConfidentialGuestClass {
>      /* <private> */
>      ConfidentialGuestSupportClass parent;
> +
> +    /* <public> */
> +    int (*kvm_type)(X86ConfidentialGuest *cg);
>  };
> +
> +/**
> + * x86_confidential_guest_kvm_type:
> + *
> + * Calls #X86ConfidentialGuestClass.unplug callback of @plug_handler.
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
>  #endif
> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> index 30fedcffea3..02168122787 100644
> --- a/target/i386/kvm/kvm_i386.h
> +++ b/target/i386/kvm/kvm_i386.h
> @@ -37,6 +37,7 @@ bool kvm_hv_vpindex_settable(void);
>  bool kvm_enable_sgx_provisioning(KVMState *s);
>  bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
>  
> +int kvm_get_vm_type(MachineState *ms, const char *vm_type);
>  void kvm_arch_reset_vcpu(X86CPU *cs);
>  void kvm_arch_after_reset_vcpu(X86CPU *cpu);
>  void kvm_arch_do_init_vcpu(X86CPU *cs);
> @@ -49,6 +50,7 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask);
>  
>  #ifdef CONFIG_KVM
>  
> +bool kvm_is_vm_type_supported(int type);
>  bool kvm_has_adjust_clock_stable(void);
>  bool kvm_has_exception_payload(void);
>  void kvm_synchronize_all_tsc(void);
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index ffbda48917f..2d4b148cd25 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -1389,6 +1389,11 @@ static void machine_set_sgx_epc(Object *obj, Visitor *v, const char *name,
>      qapi_free_SgxEPCList(list);
>  }
>  
> +static int x86_kvm_type(MachineState *ms, const char *vm_type)
> +{
> +    return kvm_enabled() ? kvm_get_vm_type(ms, vm_type) : 0;
> +}
> +
>  static void x86_machine_initfn(Object *obj)
>  {
>      X86MachineState *x86ms = X86_MACHINE(obj);
> @@ -1413,6 +1418,7 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
>      mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
>      mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
> +    mc->kvm_type = x86_kvm_type;
>      x86mc->save_tsc_khz = true;
>      x86mc->fwcfg_dma_enabled = true;
>      nc->nmi_monitor_handler = x86_nmi;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 0ec69109a2b..e109648f260 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -31,6 +31,7 @@
>  #include "sysemu/kvm_int.h"
>  #include "sysemu/runstate.h"
>  #include "kvm_i386.h"
> +#include "../confidential-guest.h"
>  #include "sev.h"
>  #include "xen-emu.h"
>  #include "hyperv.h"
> @@ -161,6 +162,49 @@ static KVMMSRHandlers msr_handlers[KVM_MSR_FILTER_MAX_RANGES];
>  static RateLimit bus_lock_ratelimit_ctrl;
>  static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
>  
> +static const char *vm_type_name[] = {
> +    [KVM_X86_DEFAULT_VM] = "default",
> +};
> +
> +bool kvm_is_vm_type_supported(int type)
> +{
> +    uint32_t machine_types;
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

The 'vm_type' parameter is never used here. What value is it expected
to have, and should be diagnosing an error if some unexpected value
is provided.

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
>  bool kvm_has_smm(void)
>  {
>      return kvm_vm_check_extension(kvm_state, KVM_CAP_X86_SMM);
> -- 
> 2.44.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


