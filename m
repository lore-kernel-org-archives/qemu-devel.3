Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EA2C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFcH-000726-LP; Thu, 03 Jul 2025 04:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXFcD-0006p0-7g
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:48:21 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXFcA-0004AF-JA
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751532498; x=1783068498;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TVqic+b8AVGUwxPElX65V0zWrqt8rFKvH8TJ7zuGHG8=;
 b=bokdecm4Mpmuf+QNIHyT+mS2RjBEo9AaXaczJnlbvR6lM7WIpvfruh3n
 adC9AUNUmm6JtYFTifrDMttNlWE4pDiPaI8XtveOfaTRhGn4sb8Jvboql
 D2h1JXB3EzaW9UG5QBzrXzqb+5+zogWJvBiTfDHA7RrmgB8zt+j6yuzV+
 HiuIeOjjl5DFSZ+bSBuML8MKSn+yzVb2vijnxQ7BZ1xUlF2CZ1LGxclFb
 nYwBzxh4oyHPqNccnjunY2Zr+w127DkrcwW2pInUnWlLMKXJWhPMeQnff
 X2ykjEFyi6vVOrGQ1F074S/6m9EdxzdIORJmCMZN2+6FhY0IZL6okjvN7 w==;
X-CSE-ConnectionGUID: LcYUbcQzRSyxlcNO3a3daQ==
X-CSE-MsgGUID: Nxj1PaSgQAuSjU2d93QRUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="56468912"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="56468912"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:48:05 -0700
X-CSE-ConnectionGUID: EGto2FLtQymYlGi9LsTHFA==
X-CSE-MsgGUID: cPaMJISUREu5N2A/94HLXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="154079941"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:48:02 -0700
Message-ID: <47aed1d6-c05d-4d60-a59c-49537a211d21@linux.intel.com>
Date: Thu, 3 Jul 2025 16:47:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] i386/cpu: Select legacy cache model based on vendor
 in CPUID 0x2
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-12-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250620092734.1576677-12-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.13;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 6/20/2025 5:27 PM, Zhao Liu wrote:
> As preparation for merging cache_info_cpuid4 and cache_info_amd in
> X86CPUState, set legacy cache model based on vendor in the CPUID 0x2
> leaf. For AMD CPU, select legacy AMD cache model (in cache_info_amd) as
> the default cache model, otherwise, select legacy Intel cache model (in
> cache_info_cpuid4) as before.
>
> To ensure compatibility is not broken, add an enable_legacy_vendor_cache
> flag based on x-vendor-only-v2 to indicate cases where the legacy cache
> model should be used regardless of the vendor. For CPUID 0x2 leaf,
> enable_legacy_vendor_cache flag indicates to pick legacy Intel cache
> model, which is for compatibility with the behavior of PC machine v10.0
> and older.
>
> The following explains how current vendor-based default legacy cache
> model ensures correctness without breaking compatibility.
>
> * For the PC machine v6.0 and older, vendor_cpuid_only=false, and
>   vendor_cpuid_only_v2=false.
>
>   - If the named CPU model has its own cache model, and doesn't use
>     legacy cache model (legacy_cache=false), then cache_info_cpuid4 and
>     cache_info_amd are same, so 0x2 leaf uses its own cache model
>     regardless of the vendor.
>
>   - For max/host/named CPU (without its own cache model), then the flag
>     enable_legacy_vendor_cache is true, they will use legacy Intel cache
>     model just like their previous behavior.
>
> * For the PC machine v10.0 and older (to v6.1), vendor_cpuid_only=true,
>   and vendor_cpuid_only_v2=false.
>
>   - If the named CPU model has its own cache model (legacy_cache=false),
>     then cache_info_cpuid4 & cache_info_amd both equal to its own cache
>     model, so it uses its own cache model in 0x2 leaf regardless of the
>     vendor. Only AMD CPUs have all-0 leaf due to vendor_cpuid_only=true,
>     and this is exactly the behavior of these old machines.
>
>   - For max/host/named CPU (without its own cache model), then the flag
>     enable_legacy_vendor_cache is true, they will use legacy Intel cache
>     model. Similarly, only AMD CPUs have all-0 leaf, and this is exactly
>     the behavior of these old machines.
>
> * For the PC machine v10.1 and newer, vendor_cpuid_only=true, and
>   vendor_cpuid_only_v2=true.
>
>   - If the named CPU model has its own cache model (legacy_cache=false),
>     then cache_info_cpuid4 & cache_info_amd both equal to its own cache
>     model, so it uses its own cache model in 0x2 leaf regardless of the
>     vendor. And AMD CPUs have all-0 leaf. Nothing will change.
>
>   - For max/host/named CPU (without its own cache model), then the flag
>     enable_legacy_vendor_cache is false, the legacy cache model is
>     selected based on vendor.
>
>     For AMD CPU, it will use legacy AMD cache but still get all-0 leaf
>     due to vendor_cpuid_only=true.
>
>     For non-AMD (Intel/Zhaoxin) CPU, it will use legacy Intel cache as
>     expected.
>
>     Here, selecting the legacy cache model based on the vendor does not
>     change the previous (before the change)  behavior.
>
> Therefore, the above analysis proves that, with the help of the flag
> enable_legacy_vendor_cache, it is acceptable to select the default
> legacy cache model based on the vendor.
>
> For the CPUID 0x2 leaf, in X86CPUState, a unified cache_info is enough.
> It only needs to be initialized and configured with the corresponding
> legacy cache model based on the vendor.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 47 +++++++++++++++++++++++++++++++++++++----------
>  target/i386/cpu.h |  1 +
>  2 files changed, 38 insertions(+), 10 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index bf8d7a19c88d..524d39de9ace 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -248,23 +248,17 @@ static const CPUCaches legacy_intel_cpuid2_cache_info;
>  
>  /* Encode cache info for CPUID[4] */
>  static void encode_cache_cpuid2(X86CPU *cpu,
> +                                const CPUCaches *caches,
>                                  uint32_t *eax, uint32_t *ebx,
>                                  uint32_t *ecx, uint32_t *edx)
>  {
>      CPUX86State *env = &cpu->env;
> -    const CPUCaches *caches;
>      int l1d, l1i, l2, l3;
>      bool unmatched = false;
>  
>      *eax = 1; /* Number of CPUID[EAX=2] calls required */
>      *ebx = *ecx = *edx = 0;
>  
> -    if (env->enable_legacy_cpuid2_cache) {
> -        caches = &legacy_intel_cpuid2_cache_info;
> -    } else {
> -        caches = &env->cache_info_cpuid4;
> -    }
> -
>      l1d = cpuid2_cache_descriptor(caches->l1d_cache, &unmatched);
>      l1i = cpuid2_cache_descriptor(caches->l1i_cache, &unmatched);
>      l2 = cpuid2_cache_descriptor(caches->l2_cache, &unmatched);
> @@ -7482,8 +7476,37 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *ecx &= ~CPUID_EXT_PDCM;
>          }
>          break;
> -    case 2:
> -        /* cache info: needed for Pentium Pro compatibility */
> +    case 2: { /* cache info: needed for Pentium Pro compatibility */
> +        const CPUCaches *caches;
> +
> +        if (env->enable_legacy_cpuid2_cache) {
> +            caches = &legacy_intel_cpuid2_cache_info;
> +        } else if (env->enable_legacy_vendor_cache) {
> +            caches = &legacy_intel_cache_info;
> +        } else {
> +            /*
> +             * FIXME: Temporarily select cache info model here based on
> +             * vendor, and merge these 2 cache info models later.
> +             *
> +             * This condition covers the following cases (with
> +             * enable_legacy_vendor_cache=false):
> +             *  - When CPU model has its own cache model and doesn't use legacy
> +             *    cache model (legacy_model=off). Then cache_info_amd and
> +             *    cache_info_cpuid4 are the same.
> +             *
> +             *  - For v10.1 and newer machines, when CPU model uses legacy cache
> +             *    model. Non-AMD CPUs use cache_info_cpuid4 like before and AMD
> +             *    CPU will use cache_info_amd. But this doesn't matter for AMD
> +             *    CPU, because this leaf encodes all-0 for AMD whatever its cache
> +             *    model is.
> +             */
> +            if (IS_AMD_CPU(env)) {
> +                caches = &env->cache_info_amd;
> +            } else {
> +                caches = &env->cache_info_cpuid4;
> +            }
> +        }
> +
>          if (cpu->cache_info_passthrough) {
>              x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
>              break;
> @@ -7491,8 +7514,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *eax = *ebx = *ecx = *edx = 0;
>              break;
>          }
> -        encode_cache_cpuid2(cpu, eax, ebx, ecx, edx);
> +        encode_cache_cpuid2(cpu, caches, eax, ebx, ecx, edx);
>          break;
> +    }
>      case 4:
>          /* cache info: needed for Core compatibility */
>          if (cpu->cache_info_passthrough) {
> @@ -8979,6 +9003,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>              env->enable_legacy_cpuid2_cache = true;
>          }
>  
> +        if (!cpu->vendor_cpuid_only_v2) {
> +            env->enable_legacy_vendor_cache = true;
> +        }
>          env->cache_info_cpuid4 = legacy_intel_cache_info;
>          env->cache_info_amd = legacy_amd_cache_info;
>      }
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 02cda176798f..243383efd602 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2078,6 +2078,7 @@ typedef struct CPUArchState {
>       */
>      CPUCaches cache_info_cpuid4, cache_info_amd;
>      bool enable_legacy_cpuid2_cache;
> +    bool enable_legacy_vendor_cache;
>  
>      /* MTRRs */
>      uint64_t mtrr_fixed[11];

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



