Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A96C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 03:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scGFp-0004zs-Hm; Thu, 08 Aug 2024 23:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scGFm-0004xg-Tw
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:25:22 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scGFk-0005F2-6w
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723173921; x=1754709921;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Tw+oP3IUd1a2tjFWuBay+BRp/YDXjyJCFYsMxwsCFAA=;
 b=cUPweliK8Hfr4ejjoGnjfdeWdiAIc8i1+QZb49UWtwDOtWqW/IbQGqdN
 fhnL4nEE8+gX9aIgPkuUgd6yMI9+Bm7SrQu9sRQCXocCYvE5m1aRpiy8k
 Y4YcyGNH9NNC9VCcDtY5N9GFMKsx8o+4Jzpb9CRQQK43aKhT02neS0FEg
 KbJrRo7jw9IEfm7aPgobk0xKzf7Tt3RDW4OqZDZM/OMoYzNevDXMBUQy8
 VswqbG/Yiy+v9Kh1ebg7O+/9sSZEpm8K/Dpfv0Dop/y22dUe5+f2b6GbA
 5m0Q/EvlZcIjRy9uQaoXgJrM6rNsMMqZDCuIjRDWZtvOiiQysrBwGbtP9 g==;
X-CSE-ConnectionGUID: k0t38VKoQWKEfZBK5O2qXA==
X-CSE-MsgGUID: rcfnYlp6QeeL2KHp0CYFxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31909003"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="31909003"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 20:25:17 -0700
X-CSE-ConnectionGUID: TUDafeUTQROSXWiRTIUWbg==
X-CSE-MsgGUID: Z1EXJPldT+Sok75tUmhTgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="57306512"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 08 Aug 2024 20:25:15 -0700
Date: Fri, 9 Aug 2024 11:41:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] kvm: refactor core virtual machine creation into its
 own function
Message-ID: <ZrWP0fWPNzeAvjja@intel.com>
References: <20240808113838.1697366-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808113838.1697366-1-anisinha@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Ani,

On Thu, Aug 08, 2024 at 05:08:38PM +0530, Ani Sinha wrote:
> Date: Thu,  8 Aug 2024 17:08:38 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH v2] kvm: refactor core virtual machine creation into its
>  own function
> X-Mailer: git-send-email 2.45.2
> 
> Refactoring the core logic around KVM_CREATE_VM into its own separate function
> so that it can be called from other functions in subsequent patches. There is
> no functional change in this patch.
> 
> CC: pbonzini@redhat.com
> CC: zhao1.liu@intel.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 93 +++++++++++++++++++++++++++------------------
>  1 file changed, 56 insertions(+), 37 deletions(-)
> 
> changelog:
> v2: s/fprintf/warn_report as suggested by zhao

Thanks for your change!

> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 75d11a07b2..c2e177c39f 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2385,6 +2385,60 @@ uint32_t kvm_dirty_ring_size(void)
>      return kvm_state->kvm_dirty_ring_size;
>  }
>  
> +static int do_kvm_create_vm(MachineState *ms, int type)
> +{
> +    KVMState *s;
> +    int ret;
> +
> +    s = KVM_STATE(ms->accelerator);
> +
> +    do {
> +        ret = kvm_ioctl(s, KVM_CREATE_VM, type);
> +    } while (ret == -EINTR);
> +
> +    if (ret < 0) {
> +        warn_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
> +                    strerror(-ret));
> +
> +#ifdef TARGET_S390X
> +        if (ret == -EINVAL) {
> +            warn_report("Host kernel setup problem detected. Please verify:");
> +            warn_report("- for kernels supporting the switch_amode or"
> +                        " user_mode parameters, whether");
> +            warn_report("  user space is running in primary address space");
> +            warn_report("- for kernels supporting the vm.allocate_pgste "
> +                        "sysctl, whether it is enabled");
> +        }
> +#elif defined(TARGET_PPC)
> +        if (ret == -EINVAL) {
> +            warn_report("PPC KVM module is not loaded. Try modprobe kvm_%s.",
> +                        (type == 2) ? "pr" : "hv");
> +        }
> +#endif

I think error level message is more appropriate than warn because after
the print QEMU handles error and terminates the Guest startup.

What about the following change?

#ifdef TARGET_S390X
        if (ret == -EINVAL) {
            error_report("Host kernel setup problem detected");
            error_printf("Please verify:\n");
            error_printf("- for kernels supporting the switch_amode or"
                         " user_mode parameters, whether\n");
            error_printf("  user space is running in primary address space\n");
            error_printf("- for kernels supporting the vm.allocate_pgste "
                         "sysctl, whether it is enabled\n");
        }
#elif defined(TARGET_PPC)
        if (ret == -EINVAL) {
            error_report("PPC KVM module is not loaded");
            error_printf("Try modprobe kvm_%s.\n",
                         (type == 2) ? "pr" : "hv");
	}
#endif

The above uses error_report() to just print error reason/error code
since for error_report, "The resulting message should be a single
phrase, with no newline or trailing punctuation."

Other specific hints or information are printed by error_printf()
because style.rst suggests "Use error_printf() & friends to print
additional information."

Thanks,
Zhao

> +    }
> +
> +    return ret;
> +}
> +
> +static int find_kvm_machine_type(MachineState *ms)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    int type;
> +
> +    if (object_property_find(OBJECT(current_machine), "kvm-type")) {
> +        g_autofree char *kvm_type;
> +        kvm_type = object_property_get_str(OBJECT(current_machine),
> +                                           "kvm-type",
> +                                           &error_abort);
> +        type = mc->kvm_type(ms, kvm_type);
> +    } else if (mc->kvm_type) {
> +        type = mc->kvm_type(ms, NULL);
> +    } else {
> +        type = kvm_arch_get_default_type(ms);
> +    }
> +    return type;
> +}
> +
>  static int kvm_init(MachineState *ms)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> @@ -2467,49 +2521,14 @@ static int kvm_init(MachineState *ms)
>      }
>      s->as = g_new0(struct KVMAs, s->nr_as);
>  
> -    if (object_property_find(OBJECT(current_machine), "kvm-type")) {
> -        g_autofree char *kvm_type = object_property_get_str(OBJECT(current_machine),
> -                                                            "kvm-type",
> -                                                            &error_abort);
> -        type = mc->kvm_type(ms, kvm_type);
> -    } else if (mc->kvm_type) {
> -        type = mc->kvm_type(ms, NULL);
> -    } else {
> -        type = kvm_arch_get_default_type(ms);
> -    }
> -
> +    type = find_kvm_machine_type(ms);
>      if (type < 0) {
>          ret = -EINVAL;
>          goto err;
>      }
>  
> -    do {
> -        ret = kvm_ioctl(s, KVM_CREATE_VM, type);
> -    } while (ret == -EINTR);
> -
> +    ret = do_kvm_create_vm(ms, type);
>      if (ret < 0) {
> -        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret,
> -                strerror(-ret));
> -
> -#ifdef TARGET_S390X
> -        if (ret == -EINVAL) {
> -            fprintf(stderr,
> -                    "Host kernel setup problem detected. Please verify:\n");
> -            fprintf(stderr, "- for kernels supporting the switch_amode or"
> -                    " user_mode parameters, whether\n");
> -            fprintf(stderr,
> -                    "  user space is running in primary address space\n");
> -            fprintf(stderr,
> -                    "- for kernels supporting the vm.allocate_pgste sysctl, "
> -                    "whether it is enabled\n");
> -        }
> -#elif defined(TARGET_PPC)
> -        if (ret == -EINVAL) {
> -            fprintf(stderr,
> -                    "PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
> -                    (type == 2) ? "pr" : "hv");
> -        }
> -#endif
>          goto err;
>      }
>  
> -- 
> 2.45.2
> 

