Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA7BC19F38
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnY6M-0005in-QY; Thu, 27 Feb 2025 02:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tnY6I-0005hA-PE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:14:31 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tnY6D-0001QC-Bv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740640465; x=1772176465;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/4bM5WVvl/xKSckE8mEzDudjm5VU4avd8GctpWV7UdM=;
 b=Enpjl2NiN90qWJRvWQEw6hMqAT0FsrAWL9N27NlnmDn6YyR5YJhcW8gY
 xTaOgac/7p3Orj9n8V00EEFKj1Ihd1IUTT3PqNVHZ2WgKB+rhIypKMmXS
 90W+RhbIcK/idqSJnpuXJoWMOfWiaSwGDe2DJE/F5fGYv26BBjzY2OCIC
 sauelk8V2Z36uJFAyU7t1C4Gf9npzCf+nnyrBpQPY349V5C+d7LjwUVBv
 iVSgtQVDANJ/qEA7ImYXuUIE83C7I8EimDfiG/+dZ1n6LuMOvc6RJrkvm
 PDlV9UwqqUd1NAFnn2RN4fRZ7bUIDbqoGmOmaltnsgO7++Mr7wnL3H1S+ A==;
X-CSE-ConnectionGUID: yMJvzzoURLeOf3ODgGY9bg==
X-CSE-MsgGUID: DlRc+9kdScKrlDYWdWk8iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="66888435"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="66888435"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 23:14:24 -0800
X-CSE-ConnectionGUID: xfDBdqpFT+GRo8hpKlz3CQ==
X-CSE-MsgGUID: mMMt+2bUTxa79FHDQEkzVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="117117014"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 23:14:21 -0800
Message-ID: <9f193b96-a0de-47b5-b700-94ce25305600@intel.com>
Date: Thu, 27 Feb 2025 15:14:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] i386/cpu: Fix overflow of cache topology fields in
 CPUID.04H
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: qemu-devel@nongnu.org, Qian Wen <qian.wen@intel.com>
References: <20250227062523.124601-1-zhao1.liu@intel.com>
 <20250227062523.124601-4-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250227062523.124601-4-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/27/2025 2:25 PM, Zhao Liu wrote:
> From: Qian Wen <qian.wen@intel.com>
> 
> According to SDM, CPUID.0x4:EAX[31:26] indicates the Maximum number of
> addressable IDs for processor cores in the physical package. If we
> launch over 64 cores VM, the 6-bit field will overflow, and the wrong
> core_id number will be reported.
> 
> Since the HW reports 0x3f when the intel processor has over 64 cores,
> limit the max value written to EAX[31:26] to 63, so max num_cores should
> be 64.
> 
> For EAX[14:25], though at present Q35 supports up to 4096 CPUs, to
> prevent potential overflow issues from further increasing the number of
> CPUs in the future, check and honor the maximum value for EAX[14:25] as
> well.
> 
> In addition, for host-cache-info case, also apply the same checks and
> fixes.
> 
> Signed-off-by: Qian Wen <qian.wen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> Changes since original v4 [*]:
>   * Rebase on addressable ID fixup.
>   * Drop R/b tags since the code base changes.
>   * Teak bits 25-14 as well and add the comment.
>   * Fix overflow for host-cache-info case.
> 
> [*]: original v4: https://lore.kernel.org/qemu-devel/20230829042405.932523-3-qian.wen@intel.com/
> ---
>   target/i386/cpu.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ae6c8bfd8b5e..d75175b0850a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -280,11 +280,17 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
>       assert(cache->size == cache->line_size * cache->associativity *
>                             cache->partitions * cache->sets);
>   
> +    /*
> +     * The following fields have bit-width limitations, so consider the
> +     * maximum values to avoid overflow:
> +     * Bits 25-14: maximum 4095.
> +     * Bits 31-26: maximum 63.
> +     */
>       *eax = CACHE_TYPE(cache->type) |
>              CACHE_LEVEL(cache->level) |
>              (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
> -           (max_core_ids_in_package(topo_info) << 26) |
> -           (max_thread_ids_for_cache(topo_info, cache->share_level) << 14);
> +           (MIN(max_core_ids_in_package(topo_info), 63) << 26) |
> +           (MIN(max_thread_ids_for_cache(topo_info, cache->share_level), 4095) << 14);
>   
>       assert(cache->line_size > 0);
>       assert(cache->partitions > 0);
> @@ -6743,13 +6749,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>   
>                   *eax &= ~0xFC000000;
> -                *eax |= max_core_ids_in_package(topo_info) << 26;
> +                *eax |= MIN(max_core_ids_in_package(topo_info), 63) << 26;
>                   if (host_vcpus_per_cache > threads_per_pkg) {
>                       *eax &= ~0x3FFC000;
>   
>                       /* Share the cache at package level. */
> -                    *eax |= max_thread_ids_for_cache(topo_info,
> -                                CPU_TOPOLOGY_LEVEL_SOCKET) << 14;
> +                    *eax |= MIN(max_thread_ids_for_cache(topo_info,
> +                                CPU_TOPOLOGY_LEVEL_SOCKET), 4095) << 14;
>                   }
>               }
>           } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {


