Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C56C54E66
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjbIg-0002Y6-QW; Mon, 11 Mar 2024 04:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rjbIA-0002Kk-8o
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:46:02 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rjbI7-0004mz-T8
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710146752; x=1741682752;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/F4x4ozVLeWf9qgvXPYCqWzDmTkI4g5EUawF7zHp6IA=;
 b=Uu2O2t6PNNFD67l74kFbQRFeHN6fnHjWCDWe2alSKJm1zrLCrpqeHWvg
 ih/VscLlJKq4khv8ujiOhuZbR4QVljOTVB4zML5pu6HETsyFeaq4a2d70
 6XduAy0QFQo+GI+ejngJMoNSxHaBcr0AotEaawmILw3MRR82ZC5FcurJ/
 OLdX65RMJ/eId6ik8K0MoKaSFXNS4gfkCQiOZYNYRBxvIJVhE7Acup5xJ
 ZTTAnvxFcy7Vv1e1HsEpnGnIGca+TQgHRqowbdDuLh3Eaul7EU1+bkaKT
 KmiLST+ibjauL0QcUej1QEJ/VZ3J7+LyknCEkB4rm0GtqddF8ezrqIe8B w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="8550333"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="8550333"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 01:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="11195125"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 01:45:44 -0700
Message-ID: <005c1649-43d3-494f-951a-166e7200ffd5@intel.com>
Date: Mon, 11 Mar 2024 16:45:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/21] i386/cpu: Decouple CPUID[0x1F] subleaf with
 specific topology level
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
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-12-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240227103231.1556302-12-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/27/2024 6:32 PM, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> At present, the subleaf 0x02 of CPUID[0x1F] is bound to the "die" level.
> 
> In fact, the specific topology level exposed in 0x1F depends on the
> platform's support for extension levels (module, tile and die).
> 
> To help expose "module" level in 0x1F, decouple CPUID[0x1F] subleaf
> with specific topology level.
> 
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Besides, some nits below.

> ---
> Changes since v7:
>   * Refactored the encode_topo_cpuid1f() to use traversal to search the
>     encoded level and avoid using static variables. (Xiaoyao)
>     - Since the total number of levels in the bitmap is not too large,
>       the overhead of traversing is supposed to be acceptable.
>   * Renamed the variable num_cpus_next_level to num_threads_next_level.
>     (Xiaoyao)
>   * Renamed the helper num_cpus_by_topo_level() to
>     num_threads_by_topo_level(). (Xiaoyao)
>   * Dropped Michael/Babu's Acked/Tested tags since the code change.
>   * Re-added Yongwei's Tested tag For his re-testing.
> 
> Changes since v3:
>   * New patch to prepare to expose module level in 0x1F.
>   * Moved the CPUTopoLevel enumeration definition from "i386: Add cache
>     topology info in CPUCacheInfo" to this patch. Note, to align with
>     topology types in SDM, revert the name of CPU_TOPO_LEVEL_UNKNOW to
>     CPU_TOPO_LEVEL_INVALID.
> ---
>   target/i386/cpu.c | 138 +++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 113 insertions(+), 25 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 88dffd2b52e3..b0f171c6a465 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -269,6 +269,118 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
>              (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
>   }
>   
> +static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
> +                                          enum CPUTopoLevel topo_level)
> +{
> +    switch (topo_level) {
> +    case CPU_TOPO_LEVEL_SMT:
> +        return 1;
> +    case CPU_TOPO_LEVEL_CORE:
> +        return topo_info->threads_per_core;
> +    case CPU_TOPO_LEVEL_DIE:
> +        return topo_info->threads_per_core * topo_info->cores_per_die;
> +    case CPU_TOPO_LEVEL_PACKAGE:
> +        return topo_info->threads_per_core * topo_info->cores_per_die *
> +               topo_info->dies_per_pkg;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return 0;
> +}
> +
> +static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
> +                                            enum CPUTopoLevel topo_level)
> +{
> +    switch (topo_level) {
> +    case CPU_TOPO_LEVEL_SMT:
> +        return 0;
> +    case CPU_TOPO_LEVEL_CORE:
> +        return apicid_core_offset(topo_info);
> +    case CPU_TOPO_LEVEL_DIE:
> +        return apicid_die_offset(topo_info);
> +    case CPU_TOPO_LEVEL_PACKAGE:
> +        return apicid_pkg_offset(topo_info);
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return 0;
> +}
> +
> +static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
> +{
> +    switch (topo_level) {
> +    case CPU_TOPO_LEVEL_INVALID:
> +        return CPUID_1F_ECX_TOPO_LEVEL_INVALID;
> +    case CPU_TOPO_LEVEL_SMT:
> +        return CPUID_1F_ECX_TOPO_LEVEL_SMT;
> +    case CPU_TOPO_LEVEL_CORE:
> +        return CPUID_1F_ECX_TOPO_LEVEL_CORE;
> +    case CPU_TOPO_LEVEL_DIE:
> +        return CPUID_1F_ECX_TOPO_LEVEL_DIE;
> +    default:
> +        /* Other types are not supported in QEMU. */
> +        g_assert_not_reached();
> +    }
> +    return 0;
> +}
> +
> +static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
> +                                X86CPUTopoInfo *topo_info,
> +                                uint32_t *eax, uint32_t *ebx,
> +                                uint32_t *ecx, uint32_t *edx)
> +{
> +    X86CPU *cpu = env_archcpu(env);
> +    unsigned long level;
> +    uint32_t num_threads_next_level, offset_next_level;
> +
> +    assert(count + 1 < CPU_TOPO_LEVEL_MAX);
> +
> +    /*
> +     * Find the No.count topology levels in avail_cpu_topo bitmap.
> +     * Start from bit 0 (CPU_TOPO_LEVEL_INVALID).

AFAICS, it starts from bit 1 (CPU_TOPO_LEVEL_SMT). Because the initial 
value of level is CPU_TOPO_LEVEL_INVALID, but the first round of the 
loop is to find the valid bit starting from (level + 1).

> +     */
> +    level = CPU_TOPO_LEVEL_INVALID;
> +    for (int i = 0; i <= count; i++) {
> +        level = find_next_bit(env->avail_cpu_topo,
> +                              CPU_TOPO_LEVEL_PACKAGE,
> +                              level + 1);
> +
> +        /*
> +         * CPUID[0x1f] doesn't explicitly encode the package level,
> +         * and it just encode the invalid level (all fields are 0)
> +         * into the last subleaf of 0x1f.
> +         */

QEMU will never set bit CPU_TOPO_LEVEL_PACKAGE in env->avail_cpu_topo.

So I think we should assert() it instead of fixing it silently.

> +        if (level == CPU_TOPO_LEVEL_PACKAGE) {
> +            level = CPU_TOPO_LEVEL_INVALID;
> +            break;
> +        }
> +    }
> +
> +    if (level == CPU_TOPO_LEVEL_INVALID) {
> +        num_threads_next_level = 0;
> +        offset_next_level = 0;
> +    } else {
> +        unsigned long next_level;

please define it at the beginning of the function. e.g.,

> +        next_level = find_next_bit(env->avail_cpu_topo,
> +                                   CPU_TOPO_LEVEL_PACKAGE,
> +                                   level + 1);
> +        num_threads_next_level = num_threads_by_topo_level(topo_info,
> +                                                           next_level);
> +        offset_next_level = apicid_offset_by_topo_level(topo_info,
> +                                                        next_level);
> +    }
> +
> +    *eax = offset_next_level;
> +    *ebx = num_threads_next_level;
> +    *ebx &= 0xffff; /* The count doesn't need to be reliable. */

we can combine them together. e.g.,

*ebx = num_threads_next_level & 0xffff; /* ... */

> +    *ecx = count & 0xff;
> +    *ecx |= cpuid1f_topo_type(level) << 8;

Ditto,

*ecx = count & 0xff | cpuid1f_topo_type(level) << 8;

> +    *edx = cpu->apic_id;
> +
> +    assert(!(*eax & ~0x1f));
> +}
> +
>   /* Encode cache info for CPUID[0x80000005].ECX or CPUID[0x80000005].EDX */
>   static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
>   {
> @@ -6287,31 +6399,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               break;
>           }
>   
> -        *ecx = count & 0xff;
> -        *edx = cpu->apic_id;
> -        switch (count) {
> -        case 0:
> -            *eax = apicid_core_offset(&topo_info);
> -            *ebx = topo_info.threads_per_core;
> -            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_SMT << 8;
> -            break;
> -        case 1:
> -            *eax = apicid_die_offset(&topo_info);
> -            *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
> -            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_CORE << 8;
> -            break;
> -        case 2:
> -            *eax = apicid_pkg_offset(&topo_info);
> -            *ebx = threads_per_pkg;
> -            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_DIE << 8;
> -            break;
> -        default:
> -            *eax = 0;
> -            *ebx = 0;
> -            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_INVALID << 8;
> -        }
> -        assert(!(*eax & ~0x1f));
> -        *ebx &= 0xffff; /* The count doesn't need to be reliable. */
> +        encode_topo_cpuid1f(env, count, &topo_info, eax, ebx, ecx, edx);
>           break;
>       case 0xD: {
>           /* Processor Extended State */


