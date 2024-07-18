Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC29C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUYP2-00073e-Q2; Thu, 18 Jul 2024 17:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYOx-0006jO-6Z
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:10:59 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYOv-0007fs-39
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721337057; x=1752873057;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=m0/N8F93ymgUGd+cp9IcrwKS34MurLS7rkuJ++xQVwc=;
 b=eVXKR1reQHlj/wm9W6WssIzW7edRkyMLTHnd8ZWSidRnS166EDGqqDGn
 6XOMHu/peNKySYXEXv2JpkpbvXTdtZVK5wmt6p36gMFF5tyg18v8THvo6
 gJdNGmB1CgFfgYEx+NkkmB8ey6V1iveODe+i+4X/n9PlACavhmRQ1TQAr
 GwSqi8WhZxKzoEGO3HBCmUzCvC3ZirWDyHMktejxTo+s++0NmG1xkaFjp
 6qH1ATuy/7gKH4hfp2/Auh9cNQe3anD7XNtunSCn63OTgxLSYEM5KyHEB
 GUgDj7hJ6ITJhTKpWPmuD+kEJTdUU+0CRKwcT5GPxdTEiQnGvhqWZI4vK w==;
X-CSE-ConnectionGUID: NKwMsDJyTiGWMCeSAOZI/w==
X-CSE-MsgGUID: OqSrHqrvRo6A1rzhKpOtLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="36370711"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="36370711"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 14:10:56 -0700
X-CSE-ConnectionGUID: SqqwjxawRF2m8oA+QFUVDg==
X-CSE-MsgGUID: TffSMjvYTfeZCOkOneU1ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="81935053"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.107]) ([10.24.10.107])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 14:10:55 -0700
Message-ID: <93cb9db8-80cb-424e-8b2b-3e9fd9e6010e@intel.com>
Date: Thu, 18 Jul 2024 14:10:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] target/i386/kvm: Clean up error handling in
 kvm_arch_init()
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716161015.263031-1-zhao1.liu@intel.com>
 <20240716161015.263031-9-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240716161015.263031-9-zhao1.liu@intel.com>
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
> Currently, there're following incorrect error handling cases in
> kvm_arch_init():
> * Missed to handle failure of kvm_get_supported_feature_msrs().
> * Missed to return when KVM_CAP_X86_DISABLE_EXITS enabling fails.
> * MSR filter related cases called exit() directly instead of returning
>   to kvm_init().
> 
> Fix the above cases.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Zide Chen <zide.chen@intel.com>


> ---
> v3: new commit.
> ---
>  target/i386/kvm/kvm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index f68be68eb411..d47476e96813 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2682,7 +2682,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          return ret;
>      }
>  
> -    kvm_get_supported_feature_msrs(s);
> +    ret = kvm_get_supported_feature_msrs(s);
> +    if (ret < 0) {
> +        return ret;
> +    }
>  
>      uname(&utsname);
>      lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
> @@ -2740,6 +2743,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          if (ret < 0) {
>              error_report("kvm: guest stopping CPU not supported: %s",
>                           strerror(-ret));
> +            return ret;
>          }
>      }
>  
> @@ -2785,7 +2789,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          if (ret) {
>              error_report("Could not enable user space MSRs: %s",
>                           strerror(-ret));
> -            exit(1);
> +            return ret;
>          }
>  
>          ret = kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
> @@ -2793,7 +2797,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          if (ret) {
>              error_report("Could not install MSR_CORE_THREAD_COUNT handler: %s",
>                           strerror(-ret));
> -            exit(1);
> +            return ret;
>          }
>      }
>  

