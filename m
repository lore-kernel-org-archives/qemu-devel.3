Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5FCC87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 03:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uilwn-0007Cn-2T; Sun, 03 Aug 2025 23:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uilwk-0007Aq-TO
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 23:33:11 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uilwh-0004NM-M9
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 23:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754278388; x=1785814388;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=v7YM17EEoPjCgYVxxeC3VS6wY83XauAuJa+XPjEz01s=;
 b=F8DsElhfDtSYPBZ2EMTi40+qSBmGI2jwJZe8xskiDCzjA+nZvsqZV+Oe
 6Qy15C92/yO3agUCtl+MAtGSxRU/OSQB3ER7NCmYTtMcl8CnFhMBRuxEA
 uKLFbDqPiN/FHP2u0Ru+K6w9dof5+jzP1j3qdLE0csFWiHHBBaR6F8Hnv
 EImbqXP8xDAGdZaQt6PJ9uigGch/HxULlQfFuj3aAVPX5LiiVFRLiAdlr
 s6jlA59VxYumPmSMvcOEbCQaAfzA1yQl9NsEx7/N1+AyACoRekGSW+WKe
 889qUyi2/CIQPiUNXURYON5Ffg9Ud+qetwW9KuMa0nVYZzNpO7w5H95FW g==;
X-CSE-ConnectionGUID: heAC4okdQM2qUWZ3TqSjdQ==
X-CSE-MsgGUID: s65HrmmgThOyMuMvzDjiNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="73988457"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; d="scan'208";a="73988457"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2025 20:33:00 -0700
X-CSE-ConnectionGUID: os7HehQUTJ6a0oWTOEyfVw==
X-CSE-MsgGUID: BYqcN+eCStWfDNDd6q9d0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; d="scan'208";a="169350591"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2025 20:32:58 -0700
Message-ID: <6bcf6108-2d0c-44ae-a9f7-2f53ca23af7a@intel.com>
Date: Mon, 4 Aug 2025 11:32:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i386/kvm: Provide knob to disable hypercall patching
 quirk
To: Mathias Krause <minipli@grsecurity.net>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
References: <20250801131226.2729893-1-minipli@grsecurity.net>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250801131226.2729893-1-minipli@grsecurity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/1/2025 9:12 PM, Mathias Krause wrote:
> KVM has a weird behaviour when a guest executes VMCALL on an AMD system
> or VMMCALL on an Intel CPU. Both naturally generate an invalid opcode
> exception (#UD) as they are just the wrong instruction for the CPU
> given. But instead of forwarding the exception to the guest, KVM tries
> to patch the guest instruction to match the host's actual hypercall
> instruction. That is doomed to fail for regular operating systems, as
> read-only code is rather the standard these days. But, instead of
> letting go the patching attempt and falling back to #UD injection, KVM
> propagates its failure and injects the page fault instead.
> 
> That's wrong on multiple levels. Not only isn't that a valid exception
> to be generated by these instructions, confusing attempts to handle
> them. It also destroys guest state by doing so, namely the value of CR2.
> 
> Sean attempted to fix that in KVM[1] but the patch was never applied.
> 
> Later, Oliver added a quirk bit in [2] so the behaviour can, at least,
> conceptually be disabled. Paolo even called out to add this very
> functionality to disable the quirk in QEMU[3]. So lets just do it.
> 
> Add a new property 'hypercall-patching=on|off' to the KVM accelerator
> but keep the default behaviour as-is as there are, unfortunately,
> systems out there relying on the patching, e.g. KUT[4,5].
> 
> For regular operating systems, however, the patching wouldn't be needed,
> nor work at all. If it would, these systrems would be vulnerable to
> memory corruption attacks, freely overwriting kernel code as they
> please.

For non-coco VMs, the systems are surely vulnerable to memory corruption 
attacks that the host VMM is free to modify the guest memory. It's 
irrelevant to whether hypercall patching is needed or works.

> [1] https://lore.kernel.org/kvm/20211210222903.3417968-1-seanjc@google.com/
> [2] https://lore.kernel.org/kvm/20220316005538.2282772-2-oupton@google.com/
> [3] https://lore.kernel.org/kvm/80e1f1d2-2d79-22b7-6665-c00e4fe9cb9c@redhat.com/
> [4] https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/blob/f045ea5627a3/x86/apic.c#L644
> [5] https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/blob/f045ea5627a3/x86/vmexit.c#L36
> 
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
> Xiaoyao, I left out your Tested-by and Reviewed-by as I changed the code
> (slightly) and it didn't felt right to pick these up. However, as only
> the default value changed, the functionality would be the same if you
> tested both cases explicitly (-accel kvm,hypercall-patching={on,off}).

No problem, I just re-tested it.

Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> v3:
> - switch default to 'on' to not change the default behaviour
> - reference KUT tests relying on hypercall patching
> 
> v2:
> - rename hypercall_patching_enabled to hypercall_patching (Xiaoyao Li)
> - make use of error_setg*() (Xiaoyao Li)
> 
>   accel/kvm/kvm-all.c      |  1 +
>   include/system/kvm_int.h |  1 +
>   qemu-options.hx          | 10 +++++++++
>   target/i386/kvm/kvm.c    | 45 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 57 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 890d5ea9f865..a68f779b6c1c 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3997,6 +3997,7 @@ static void kvm_accel_instance_init(Object *obj)
>       s->kvm_dirty_ring_size = 0;
>       s->kvm_dirty_ring_with_bitmap = false;
>       s->kvm_eager_split_size = 0;
> +    s->hypercall_patching = true;
>       s->notify_vmexit = NOTIFY_VMEXIT_OPTION_RUN;
>       s->notify_window = 0;
>       s->xen_version = 0;
> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> index 9247493b0299..ec891ca8e302 100644
> --- a/include/system/kvm_int.h
> +++ b/include/system/kvm_int.h
> @@ -160,6 +160,7 @@ struct KVMState
>       uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk size */
>       struct KVMDirtyRingReaper reaper;
>       struct KVMMsrEnergy msr_energy;
> +    bool hypercall_patching;
>       NotifyVmexitOption notify_vmexit;
>       uint32_t notify_window;
>       uint32_t xen_version;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ab23f14d2178..98af1a91e6e6 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -236,6 +236,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>       "                dirty-ring-size=n (KVM dirty ring GFN count, default 0)\n"
>       "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
>       "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
> +    "                hypercall-patching=on|off (disable KVM's VMCALL/VMMCALL hypercall patching quirk, x86 only)\n"

I would like to say "(configure KVM's VMCALL/VMCALL hypercall patching 
quirk, x86 only)" instead of "disable"

>       "                thread=single|multi (enable multi-threaded TCG)\n"
>       "                device=path (KVM device path, default /dev/kvm)\n", QEMU_ARCH_ALL)
>   SRST
> @@ -318,6 +319,15 @@ SRST
>           open up for a specified of time (i.e. notify-window).
>           Default: notify-vmexit=run,notify-window=0.
>   
> +    ``hypercall-patching=on|off``
> +        KVM tries to recover from the wrong hypercall instruction being used by
> +        a guest by attempting to rewrite it to the one supported natively by
> +        the host CPU (VMCALL on Intel, VMMCALL for AMD systems). However, this
> +        patching may fail if the guest memory is write protected, leading to a
> +        page fault getting propagated to the guest instead of an illegal
> +        instruction exception. As this may confuse guests, this option allows
> +        disabling it (x86 only, enabled by default).
> +
>       ``device=path``
>           Sets the path to the KVM device node. Defaults to ``/dev/kvm``. This
>           option can be used to pass the KVM device to use via a file descriptor
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 369626f8c8d7..a841d53c240f 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3228,6 +3228,26 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
>       return 0;
>   }
>   
> +static int kvm_vm_disable_hypercall_patching(KVMState *s, Error **errp)
> +{
> +    int valid_quirks = kvm_vm_check_extension(s, KVM_CAP_DISABLE_QUIRKS2);
> +    int ret = -1;
> +
> +    if (valid_quirks & KVM_X86_QUIRK_FIX_HYPERCALL_INSN) {
> +        ret = kvm_vm_enable_cap(s, KVM_CAP_DISABLE_QUIRKS2, 0,
> +                                KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "kvm: failed to disable "
> +                             "hypercall patching quirk: %s",
> +                             strerror(-ret));
> +        }
> +    } else {
> +        error_setg(errp, "kvm: disabling hypercall patching not supported");
> +    }
> +
> +    return ret;
> +}
> +
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
>       int ret;
> @@ -3367,6 +3387,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           }
>       }
>   
> +    if (!s->hypercall_patching) {
> +        if (kvm_vm_disable_hypercall_patching(s, &local_err)) {
> +            error_report_err(local_err);
> +        }
> +    }
> +
>       return 0;
>   }
>   
> @@ -6478,6 +6504,19 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask)
>       }
>   }
>   
> +static bool kvm_arch_get_hypercall_patching(Object *obj, Error **errp)
> +{
> +    KVMState *s = KVM_STATE(obj);
> +    return s->hypercall_patching;
> +}
> +
> +static void kvm_arch_set_hypercall_patching(Object *obj, bool value,
> +                                            Error **errp)
> +{
> +    KVMState *s = KVM_STATE(obj);
> +    s->hypercall_patching = value;
> +}
> +
>   static int kvm_arch_get_notify_vmexit(Object *obj, Error **errp)
>   {
>       KVMState *s = KVM_STATE(obj);
> @@ -6611,6 +6650,12 @@ static void kvm_arch_set_xen_evtchn_max_pirq(Object *obj, Visitor *v,
>   
>   void kvm_arch_accel_class_init(ObjectClass *oc)
>   {
> +    object_class_property_add_bool(oc, "hypercall-patching",
> +                                   kvm_arch_get_hypercall_patching,
> +                                   kvm_arch_set_hypercall_patching);
> +    object_class_property_set_description(oc, "hypercall-patching",
> +                                          "Disable hypercall patching quirk");

Ditto, Could we use "Configure hypercall patching quirk"? It's not only 
to disable it.

>       object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
>                                      &NotifyVmexitOption_lookup,
>                                      kvm_arch_get_notify_vmexit,


