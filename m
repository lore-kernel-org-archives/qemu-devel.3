Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F5CC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 13:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riww1-0005Gp-Lm; Sat, 09 Mar 2024 08:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riwvs-0005GN-63
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:40:13 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riwvo-0004Ca-Sg
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709991609; x=1741527609;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Wh5X3xK6drDmmUuz18/g5Tmd8p4VQW/BOReFTAX5vV4=;
 b=Y5/ahDMVhw2BzVFGZKvAnm9u+A/MgSMdbJSWSqCiR9DikF8WSkGgFmUt
 QQoLczcJ+02dKTH+XfxeYeKSxMxS++aD7mVR36Xrga2D/x2PlHG/NKcvS
 b8/XY49hzfz1KPiF9Y5GWGF6T8h694ObyltI1v62b+wNGh33yvTEskU/a
 D9iEr/OpOm0bEnXVU61heaWhT/c86/s88L2SUveWwRM3kGyGbs1WkBysn
 Xs8ng2Oo6w2KSr10V/s1hIdSfuHrSTnoVFt8LcY9dzFl+F4uMytUBSbhD
 vm2r2EVRJRYH3qYAKbkydvrsuW7Z2USnCFjGQMgkfTMbIrz7kjbT36uBD Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="8524610"
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="8524610"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2024 05:40:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; d="scan'208";a="15432355"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2024 05:39:58 -0800
Message-ID: <c88ee253-f212-4aa7-9db9-e90a99a9a1e3@intel.com>
Date: Sat, 9 Mar 2024 21:39:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/21] i386/cpu: Use APIC ID info to encode cache topo
 in CPUID[4]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-7-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240227103231.1556302-7-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.277, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/27/2024 6:32 PM, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Refer to the fixes of cache_info_passthrough ([1], [2]) and SDM, the
> CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26] should use the
> nearest power-of-2 integer.
> 
> The nearest power-of-2 integer can be calculated by pow2ceil() or by
> using APIC ID offset/width (like L3 topology using 1 << die_offset [3]).
> 
> But in fact, CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26]
> are associated with APIC ID. For example, in linux kernel, the field
> "num_threads_sharing" (Bits 25 - 14) is parsed with APIC ID. And for
> another example, on Alder Lake P, the CPUID.04H:EAX[bits 31:26] is not
> matched with actual core numbers and it's calculated by:
> "(1 << (pkg_offset - core_offset)) - 1".
> 
> Therefore the topology information of APIC ID should be preferred to
> calculate nearest power-of-2 integer for CPUID.04H:EAX[bits 25:14] and
> CPUID.04H:EAX[bits 31:26]:
> 1. d/i cache is shared in a core, 1 << core_offset should be used
>     instead of "cs->nr_threads" in encode_cache_cpuid4() for
>     CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 25:14].
> 2. L2 cache is supposed to be shared in a core as for now, thereby
>     1 << core_offset should also be used instead of "cs->nr_threads" in
>     encode_cache_cpuid4() for CPUID.04H.02H:EAX[bits 25:14].
> 3. Similarly, the value for CPUID.04H:EAX[bits 31:26] should also be
>     calculated with the bit width between the package and SMT levels in
>     the APIC ID (1 << (pkg_offset - core_offset) - 1).
> 
> In addition, use APIC ID bits calculations to replace "pow2ceil()" for
> cache_info_passthrough case.
> 
> [1]: efb3934adf9e ("x86: cpu: make sure number of addressable IDs for processor cores meets the spec")
> [2]: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")
> [3]: d65af288a84d ("i386: Update new x86_apicid parsing rules with die_offset support")
> 
> Fixes: 7e3482f82480 ("i386: Helpers to encode cache information consistently")
> Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v7:
>   * Fixed calculations in cache_info_passthrough case. (Xiaoyao)
>   * Renamed variables as *_width. (Xiaoyao)
>   * Unified variable names for encoding cache_info_passthrough case and
>     non-cache_info_passthrough case as addressable_cores_width and
>     addressable_threads_width.
>   * Fixed typos in commit message. (Xiaoyao)
>   * Dropped Michael/Babu's ACKed/Tested tags since the code change.
>   * Re-added Yongwei's Tested tag For his re-testing.
> 
> Changes since v3:
>   * Fixed compile warnings. (Babu)
>   * Fixed spelling typo.
> 
> Changes since v1:
>   * Used APIC ID offset to replace "pow2ceil()" for cache_info_passthrough
>     case. (Yanan)
>   * Split the L1 cache fix into a separate patch.
>   * Renamed the title of this patch (the original is "i386/cpu: Fix number
>     of addressable IDs in CPUID.04H").
> ---
>   target/i386/cpu.c | 37 ++++++++++++++++++++++++++++---------
>   1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 81d9046167e8..c77bcbc44d59 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6014,7 +6014,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>   {
>       X86CPU *cpu = env_archcpu(env);
>       CPUState *cs = env_cpu(env);
> -    uint32_t die_offset;
>       uint32_t limit;
>       uint32_t signature[3];
>       X86CPUTopoInfo topo_info;
> @@ -6086,7 +6085,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                  (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
>                  (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
>           break;
> -    case 4:
> +    case 4: {
> +        int addressable_cores_width;
> +        int addressable_threads_width;
> +
>           /* cache info: needed for Core compatibility */
>           if (cpu->cache_info_passthrough) {
>               x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
> @@ -6098,39 +6100,55 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>                   int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
>                   if (cs->nr_cores > 1) {
> +                    addressable_cores_width = apicid_pkg_offset(&topo_info) -
> +                                              apicid_core_offset(&topo_info);
> +
>                       *eax &= ~0xFC000000;
> -                    *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> +                    *eax |= ((1 << addressable_cores_width) - 1) << 26;
>                   }
>                   if (host_vcpus_per_cache > vcpus_per_socket) {
> +                    /* Share the cache at package level. */
> +                    addressable_threads_width = apicid_pkg_offset(&topo_info);
> +
>                       *eax &= ~0x3FFC000;
> -                    *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
> +                    *eax |= ((1 << addressable_threads_width) - 1) << 14;
>                   }
>               }
>           } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
>               *eax = *ebx = *ecx = *edx = 0;
>           } else {
>               *eax = 0;
> +            addressable_cores_width = apicid_pkg_offset(&topo_info) -
> +                                      apicid_core_offset(&topo_info);
> +
>               switch (count) {
>               case 0: /* L1 dcache info */
> +                addressable_threads_width = apicid_core_offset(&topo_info);
>                   encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
> -                                    cs->nr_threads, cs->nr_cores,
> +                                    (1 << addressable_threads_width),
> +                                    (1 << addressable_cores_width),
>                                       eax, ebx, ecx, edx);
>                   break;
>               case 1: /* L1 icache info */
> +                addressable_threads_width = apicid_core_offset(&topo_info);
>                   encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
> -                                    cs->nr_threads, cs->nr_cores,
> +                                    (1 << addressable_threads_width),
> +                                    (1 << addressable_cores_width),
>                                       eax, ebx, ecx, edx);
>                   break;
>               case 2: /* L2 cache info */
> +                addressable_threads_width = apicid_core_offset(&topo_info);
>                   encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
> -                                    cs->nr_threads, cs->nr_cores,
> +                                    (1 << addressable_threads_width),
> +                                    (1 << addressable_cores_width),
>                                       eax, ebx, ecx, edx);
>                   break;
>               case 3: /* L3 cache info */
> -                die_offset = apicid_die_offset(&topo_info);
>                   if (cpu->enable_l3_cache) {
> +                    addressable_threads_width = apicid_die_offset(&topo_info);

Please get rid of the local variable @addressable_threads_width.

It is truly confusing. In this patch, it is assigned to
  - apicid_pkg_offset(&topo_info);
  - apicid_core_offset(&topo_info);
  - apicid_die_offset(&topo_info);

in different cases.

I only suggested the name of addressable_core_width in v7, which is 
apicid_pkg_offset(&topo_info) - apicid_core_offset(&topo_info); 

And it is straightforward that it means the number of bits in x2APICID 
to encode different addressable cores.

But it is not similar to addressable_threads_width, the semantic changes 
per different cache level. In fact, you want something like 
bit_width_of_addressable_threads_sharing_this_level_of_cache.

So I suggest stop using the variable of "address_therads_width". Instead 
just apicid_*_offset() directly.


With above fixed, feel free to add my

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

>                       encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
> -                                        (1 << die_offset), cs->nr_cores,
> +                                        (1 << addressable_threads_width),
> +                                        (1 << addressable_cores_width),
>                                           eax, ebx, ecx, edx);
>                       break;
>                   }
> @@ -6141,6 +6159,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               }
>           }
>           break;
> +    }
>       case 5:
>           /* MONITOR/MWAIT Leaf */
>           *eax = cpu->mwait.eax; /* Smallest monitor-line size in bytes */


