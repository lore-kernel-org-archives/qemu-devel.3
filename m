Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5432C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 02:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua3Fq-000326-NW; Thu, 10 Jul 2025 22:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua3FS-0002fT-Ek
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:12:26 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua3FP-0004Ky-DX
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752199943; x=1783735943;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=D6ZcnkUVrDDqaz+GNkf2mcurv1MFxqJ1NHqP5cT7dOQ=;
 b=TwgwI7fDPsUl7d9x1gAPnhFvZ/d9uUl17ar2bmOpCIpSqDnGy0co7Hna
 Y9m01gqPF0wTfPwltFlWupvkDErrMBcjv9wX+g+yX7zfKVxsucdu+/tAm
 FqRSvxQT+2fvpsRZgmlw5ZfuMgL7rAH1/HyyUsySLTN+UjrOoAhydxQCg
 zExX5VbiT6QGE/Hb/EAPTKwpFeglajrslKmvO6fSlQ33sffqzfX0boI75
 ZYx/9/50zCj4NuhMFD/WBRxvb14IwE7sjfOxTxYXuyuMsY+NwE8hPGM1W
 sGJcYfPBKpRtxEcON8KVo2CsNaiumXfluFMxv5EneeICuv6lC9AoSJHds g==;
X-CSE-ConnectionGUID: VRWRkoufS5iQVnZ4HXq/bg==
X-CSE-MsgGUID: uLWZxZNpTA+WIlmJZfdv0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65195833"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="65195833"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 19:12:20 -0700
X-CSE-ConnectionGUID: vq+0fkIdSSaM2Rdb5eYbZQ==
X-CSE-MsgGUID: U8Kme8+wQI+2Lh9wc4Uitw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="179947299"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 19:12:19 -0700
Message-ID: <05b53090-9d08-4af4-bf0b-c1aba9b791b1@intel.com>
Date: Fri, 11 Jul 2025 10:12:16 +0800
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
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
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

host_cpu_instance_init() only overwrites the "vendor" for "xcc->model" case.

So for "-cpu max/host" case, it will still use the one set in 
max_x86_cpu_class_init(), i.e., CPUID_VENDOR_AMD

I'm not sure if you saw my patch
https://lore.kernel.org/qemu-devel/20250701075738.3451873-2-xiaoyao.li@intel.com/

On top of it, we can simply make it

static void nvmm_cpu_instance_init(CPUState *cs)
{
     X86CPU *cpu = X86_CPU(cs);

     apply_host_vendor(cpu);
}

> +}
> +
> +static void nvmm_cpu_accel_class_init(ObjectClass *oc, const void *data)
> +{
> +    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
> +
> +    acc->cpu_instance_init = nvmm_cpu_instance_init;
> +}
> +
> +static const TypeInfo nvmm_cpu_accel_type = {
> +    .name = ACCEL_CPU_NAME("nvmm"),
> +
> +    .parent = TYPE_ACCEL_CPU,
> +    .class_init = nvmm_cpu_accel_class_init,
> +    .abstract = true,
> +};
> +
>   static void
>   nvmm_type_init(void)
>   {
>       type_register_static(&nvmm_accel_type);
> +    type_register_static(&nvmm_cpu_accel_type);
>   }
>   
>   type_init(nvmm_type_init);
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index faf56e19722..b380459d6fe 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2500,6 +2500,28 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
>       }
>   }
>   
> +static void whpx_cpu_instance_init(CPUState *cs)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +
> +    host_cpu_instance_init(cpu);
> +}
> +
> +static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
> +{
> +    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
> +
> +    acc->cpu_instance_init = whpx_cpu_instance_init;
> +}
> +
> +static const TypeInfo whpx_cpu_accel_type = {
> +    .name = ACCEL_CPU_NAME("whpx"),
> +
> +    .parent = TYPE_ACCEL_CPU,
> +    .class_init = whpx_cpu_accel_class_init,
> +    .abstract = true,
> +};
> +
>   /*
>    * Partition support
>    */
> @@ -2726,6 +2748,7 @@ static const TypeInfo whpx_accel_type = {
>   static void whpx_type_init(void)
>   {
>       type_register_static(&whpx_accel_type);
> +    type_register_static(&whpx_cpu_accel_type);
>   }
>   
>   bool init_whp_dispatch(void)


