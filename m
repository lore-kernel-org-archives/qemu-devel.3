Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF66C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 02:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua3Ks-0007DD-Ea; Thu, 10 Jul 2025 22:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua3Kp-0007Bh-8p
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:17:59 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua3Kn-0007dn-9K
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752200277; x=1783736277;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GKUX10YV9HUquGjUg9E5BkRazDsgYD4I9MWWYPAdsAw=;
 b=SBE0VW8gL1MpeGjOWU3qRThonq7MAwjIWztsVMCJLPrSRwwUQuir5Drc
 zFbl7J6wFQhwbTyRTrJH+Ic+kDSoBbTQWOKKlbuvXp+q5JSkyoncFAzS9
 0TPIALIJiv96CMAhHwp7EMmJKDnsmZBWPVpGhPjZbUMrjS50/VZ16WZD4
 ZTQFbezk4sKN97MsrgHj6UOKo7zjLO+6h3qn+WAtY6TuliEmGe06rE/O4
 86DTy9wSlB6BRUhldxppDly6CF117FYBHkbpshatlop27eMtAehSD+dnD
 cd3djyCFpvy+Ql2HrxfHnvu6esMkNdaDrQPlhnYCRk8TFm0JBBeBg+ako A==;
X-CSE-ConnectionGUID: jiJV9D1EQpiChZHNdYgrtA==
X-CSE-MsgGUID: vWRyiQ0OTxGX20NH5JuyCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="79926115"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="79926115"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 19:17:55 -0700
X-CSE-ConnectionGUID: S9REfpoqSYGShySP9E92Hw==
X-CSE-MsgGUID: JdxU8wOxTrOtqz5vN0IOtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="161942809"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 19:17:53 -0700
Message-ID: <92d23086-7866-44a0-b54e-7690c0306248@intel.com>
Date: Fri, 11 Jul 2025 10:17:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/i386: nvmm, whpx: add accel/CPU class that
 sets host vendor
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-3-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250711000603.438312-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/11/2025 8:06 AM, Paolo Bonzini wrote:
> NVMM and WHPX are virtualizers, and therefore they need to use
> (at least by default) the host vendor for the guest CPUID.
> Add a cpu_instance_init implementation to these accelerators.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.c           |  8 +++++++-
>   target/i386/nvmm/nvmm-all.c | 23 +++++++++++++++++++++++
>   target/i386/whpx/whpx-all.c | 23 +++++++++++++++++++++++
>   3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 624cebc3ff7..69bdffbfe46 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -43,6 +43,7 @@
>   #include "hw/boards.h"
>   #include "hw/i386/sgx-epc.h"
>   #endif
> +#include "system/qtest.h"
>   #include "tcg/tcg-cpu.h"
>   
>   #include "disas/capstone.h"
> @@ -1943,7 +1944,7 @@ uint32_t xsave_area_size(uint64_t mask, bool compacted)
>   
>   static inline bool accel_uses_host_cpuid(void)
>   {
> -    return kvm_enabled() || hvf_enabled();
> +    return !tcg_enabled() && !qtest_enabled();
>   }
>   
>   static inline uint64_t x86_cpu_xsave_xcr0_components(X86CPU *cpu)
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index b4a4d50e860..69125230abb 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -1207,10 +1207,33 @@ static const TypeInfo nvmm_accel_type = {
>       .class_init = nvmm_accel_class_init,
>   };
>   
> +static void nvmm_cpu_instance_init(CPUState *cs)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +
> +    host_cpu_instance_init(cpu);
Besides, do we need to call host_cpu_max_instance_init() for the case of 
xcc->max_features, like what has been done for kvm and hvf?

