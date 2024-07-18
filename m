Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83252C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUYOs-0006DD-S0; Thu, 18 Jul 2024 17:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYOq-0005vz-BQ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:10:52 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYOn-0007fs-Vj
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721337050; x=1752873050;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5Mi5TH0Ap7UxduGwfjOU7rsOfiTEruZX2i1me2cV3SQ=;
 b=bpgcVUmfiiaYNP2G4RRIkyqUne+sI7wopBA7vRSkCLcXOdm51RjOJIf3
 rvPK1rW8JfcG7cOfjUlzXOzy/EifpwL1t0dNTkQM+ZT5r8OVqA9UNs9W/
 GhBeHVuES/IaSlXrgQ4giC30BCfmn85QCqwOsgn/4DLqiUEUB4piixEkI
 oyheXJX2FFyAc0oo8nAaTWoYc/Z8oAYk0fa2HOlCUuFFh1Pb+9WJuUaZj
 Ivs2WAnxiq9PgYaE6fVxOjG63FhlO2FCAGvoz7JdilG6GA1hTgdQnbD+1
 91N5Nm9AlKym247mPJukiZuj+0ElkjTB8b3zalyyhcY5T/rMX/ylQIjp+ Q==;
X-CSE-ConnectionGUID: BvZ/l5KlSr+Yy7N+IMJC2g==
X-CSE-MsgGUID: hcQPEgRgRFirIXRVX7jfTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="36370703"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="36370703"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 14:10:48 -0700
X-CSE-ConnectionGUID: VAr0j64QQPWS/v0wihZO+g==
X-CSE-MsgGUID: 2A9XI8++Sa6pFQYEUyvcqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="81935018"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.107]) ([10.24.10.107])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 14:10:47 -0700
Message-ID: <797fb06e-ed14-4b56-969f-df73d3487e30@intel.com>
Date: Thu, 18 Jul 2024 14:10:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] target/i386/kvm: Clean up return values of MSR
 filter related functions
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716161015.263031-1-zhao1.liu@intel.com>
 <20240716161015.263031-8-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240716161015.263031-8-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 7/16/2024 9:10 AM, Zhao Liu wrote:
> At present, the error code of MSR filter enablement attempts to print in
> error_report().
> 
> Unfortunately, this behavior doesn't work because the MSR filter-related
> functions return the boolean and current error_report() use the wrong
> return value.
> 
> So fix this by making MSR filter related functions return int type and
> printing such returned value in error_report().
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

 Reviewed-by: Zide Chen <zide.chen@intel.com>

> ---
> v4: Returned kvm_vm_ioctl() directly. (Zide)
> v3: new commit.
> ---
>  target/i386/kvm/kvm.c      | 34 ++++++++++++++--------------------
>  target/i386/kvm/kvm_i386.h |  4 ++--
>  2 files changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 4aae4ffc9ccd..f68be68eb411 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2780,8 +2780,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>              }
>      }
>      if (kvm_vm_check_extension(s, KVM_CAP_X86_USER_SPACE_MSR)) {
> -        bool r;
> -
>          ret = kvm_vm_enable_cap(s, KVM_CAP_X86_USER_SPACE_MSR, 0,
>                                  KVM_MSR_EXIT_REASON_FILTER);
>          if (ret) {
> @@ -2790,9 +2788,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>              exit(1);
>          }
>  
> -        r = kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
> -                           kvm_rdmsr_core_thread_count, NULL);
> -        if (!r) {
> +        ret = kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
> +                             kvm_rdmsr_core_thread_count, NULL);
> +        if (ret) {
>              error_report("Could not install MSR_CORE_THREAD_COUNT handler: %s",
>                           strerror(-ret));
>              exit(1);
> @@ -5274,13 +5272,13 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
>      }
>  }
>  
> -static bool kvm_install_msr_filters(KVMState *s)
> +static int kvm_install_msr_filters(KVMState *s)
>  {
>      uint64_t zero = 0;
>      struct kvm_msr_filter filter = {
>          .flags = KVM_MSR_FILTER_DEFAULT_ALLOW,
>      };
> -    int r, i, j = 0;
> +    int i, j = 0;
>  
>      for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
>          KVMMSRHandlers *handler = &msr_handlers[i];
> @@ -5304,18 +5302,13 @@ static bool kvm_install_msr_filters(KVMState *s)
>          }
>      }
>  
> -    r = kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
> -    if (r) {
> -        return false;
> -    }
> -
> -    return true;
> +    return kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
>  }
>  
> -bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
> -                    QEMUWRMSRHandler *wrmsr)
> +int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
> +                   QEMUWRMSRHandler *wrmsr)
>  {
> -    int i;
> +    int i, ret;
>  
>      for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
>          if (!msr_handlers[i].msr) {
> @@ -5325,16 +5318,17 @@ bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
>                  .wrmsr = wrmsr,
>              };
>  
> -            if (!kvm_install_msr_filters(s)) {
> +            ret = kvm_install_msr_filters(s);
> +            if (ret) {
>                  msr_handlers[i] = (KVMMSRHandlers) { };
> -                return false;
> +                return ret;
>              }
>  
> -            return true;
> +            return 0;
>          }
>      }
>  
> -    return false;
> +    return 0;
>  }
>  
>  static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> index 34fc60774b86..91c2d6e69163 100644
> --- a/target/i386/kvm/kvm_i386.h
> +++ b/target/i386/kvm/kvm_i386.h
> @@ -74,8 +74,8 @@ typedef struct kvm_msr_handlers {
>      QEMUWRMSRHandler *wrmsr;
>  } KVMMSRHandlers;
>  
> -bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
> -                    QEMUWRMSRHandler *wrmsr);
> +int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
> +                   QEMUWRMSRHandler *wrmsr);
>  
>  #endif /* CONFIG_KVM */
>  

