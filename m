Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B485C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 10:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc0lR-0003D3-88; Thu, 08 Aug 2024 06:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sc0lP-0003CZ-2A
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:52:59 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sc0lM-00083Y-JK
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723114377; x=1754650377;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fL59EHgiBY/EiXLyPpY+nJV47MsHmte/G3P7ivTH8yQ=;
 b=YS+z7aCJuRm+94D57CGiw5oHK6KDYjcFQwmyqX3Fp5d9y8CH9WH0eIJs
 jYAl7Y3/NU19vYHBH5PDtn12dN0Wsf06/B5kVWuIjVPwXoz+TWd3cYCbU
 q0p3WfLngWB0oUJrYFbhW8dPg1yA1r1SSHkSB2ZIwmjpzpMgU5vCEA7my
 mrhAufzuKfdPEHQiLNYxQxi4mFp7YMiW8taSuhaGzc+/Ck3ZkqF/l0WpW
 mQwkwcS0dzKqIwZXP15iEfllRpS5Zmb8RlQGdOgV02DOV8WvDGMGKmsz6
 NcUDHcFL41L4j1c1N/LoR0L2lIgE76+x+N57qt8LCmrzvRqxykKC9KRVY Q==;
X-CSE-ConnectionGUID: CvDSyfKpRKuxX1VuA0nStw==
X-CSE-MsgGUID: 5NLOq0H4Span4zri+meRXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="24992635"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="24992635"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 03:52:53 -0700
X-CSE-ConnectionGUID: Ek273q0UR1WiHaYx5ZhjcQ==
X-CSE-MsgGUID: agGMBeypTqWrzNbX3LvoZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="57882279"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 08 Aug 2024 03:52:52 -0700
Date: Thu, 8 Aug 2024 19:08:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] kvm: refactor core virtual machine creation into its own
 function
Message-ID: <ZrSnOS0irW4vTMX/@intel.com>
References: <20240808103336.1675148-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808103336.1675148-1-anisinha@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Thu, Aug 08, 2024 at 04:03:36PM +0530, Ani Sinha wrote:
> Date: Thu,  8 Aug 2024 16:03:36 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH] kvm: refactor core virtual machine creation into its own
>  function
> X-Mailer: git-send-email 2.45.2
> 
> Refactoring the core logic around KVM_CREATE_VM into its own separate function
> so that it can be called from other functions in subsequent patches. There is
> no functional change in this patch.
> 
> CC: pbonzini@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 97 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 60 insertions(+), 37 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 75d11a07b2..2bcd00126a 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2385,6 +2385,64 @@ uint32_t kvm_dirty_ring_size(void)
>      return kvm_state->kvm_dirty_ring_size;
>  }
>  
> +static int do_create_vm(MachineState *ms, int type)
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
> +        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret,
> +                strerror(-ret));
> +
> +#ifdef TARGET_S390X
> +        if (ret == -EINVAL) {
> +            fprintf(stderr,
> +                    "Host kernel setup problem detected. Please verify:\n");
> +            fprintf(stderr, "- for kernels supporting the switch_amode or"
> +                    " user_mode parameters, whether\n");
> +            fprintf(stderr,
> +                    "  user space is running in primary address space\n");
> +            fprintf(stderr,
> +                    "- for kernels supporting the vm.allocate_pgste sysctl, "
> +                    "whether it is enabled\n");

Is it possible to convert fprintf to error_report()? Just like the
commit d0e16850eed3 ("hw/xen: convert stderr prints to error/warn
reports").

Regards,
Zhao

> +        }
> +#elif defined(TARGET_PPC)
> +        if (ret == -EINVAL) {
> +            fprintf(stderr,
> +                    "PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
> +                    (type == 2) ? "pr" : "hv");
> +        }
> +#endif
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
> @@ -2467,49 +2525,14 @@ static int kvm_init(MachineState *ms)
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
> +    ret = do_create_vm(ms, type);
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
> 

