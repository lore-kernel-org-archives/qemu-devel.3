Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3F0C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 13:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riwwx-0005ci-46; Sat, 09 Mar 2024 08:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riwwt-0005bd-Hs
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:41:15 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riwwr-0004cg-G0
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709991673; x=1741527673;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9R801M/RKXLR9NN8MIzCPaJSfWkUAq02qrdBXSRAmWc=;
 b=U3dvfSyNSBdxsJw6umYSdIMDpBG5B0fDrUs9cIjBBNMjSpG9N+vI+jBy
 APhfD7Ig1gRK8Wm/matvZUd6UOjvb99MgiXPhddes9vAHCDE+WJFsbD9o
 X3CrP6DaragwbaTNiNlIydEXp3LSnjbvUhOrmSkY0cyJ/cbXSEulVODUB
 f8LVTkTR67mCEiEdxAV9B/5zZF9NCW/OGpc7scrLJlFj8a4ZlKW8MRcaO
 xi1fXN460iiEYLyXuuch5F2zU/5SQUKMtyrKnmzBQ12hzqt6aSCNEDKPY
 ji8qY85Owt9xqMK428rbVofzJmWA9ILv9OZFO3rS3t5UZdzl5TtFYHfYM g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="8524674"
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="8524674"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2024 05:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; d="scan'208";a="15432603"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2024 05:41:06 -0800
Message-ID: <85cb99a6-dc91-4e62-aa7f-341280d5928d@intel.com>
Date: Sat, 9 Mar 2024 21:41:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/21] i386/cpu: Use APIC ID info get NumSharingCache
 for CPUID[0x8000001D].EAX[bits 25:14]
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
 <20240227103231.1556302-8-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240227103231.1556302-8-zhao1.liu@linux.intel.com>
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
> The commit 8f4202fb1080 ("i386: Populate AMD Processor Cache Information
> for cpuid 0x8000001D") adds the cache topology for AMD CPU by encoding
> the number of sharing threads directly.
> 
>  From AMD's APM, NumSharingCache (CPUID[0x8000001D].EAX[bits 25:14])
> means [1]:
> 
> The number of logical processors sharing this cache is the value of
> this field incremented by 1. To determine which logical processors are
> sharing a cache, determine a Share Id for each processor as follows:
> 
> ShareId = LocalApicId >> log2(NumSharingCache+1)
> 
> Logical processors with the same ShareId then share a cache. If
> NumSharingCache+1 is not a power of two, round it up to the next power
> of two.
> 
>  From the description above, the calculation of this field should be same
> as CPUID[4].EAX[bits 25:14] for Intel CPUs. So also use the offsets of
> APIC ID to calculate this field.
> 
> [1]: APM, vol.3, appendix.E.4.15 Function 8000_001Dh--Cache Topology
>       Information
> 
> Cc: Babu Moger <babu.moger@amd.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> Changes since v7:
>   * Moved this patch after CPUID[4]'s similar change ("i386/cpu: Use APIC
>     ID offset to encode cache topo in CPUID[4]"). (Xiaoyao)
>   * Dropped Michael/Babu's Acked/Reviewed/Tested tags since the code
>     change due to the rebase.
>   * Re-added Yongwei's Tested tag For his re-testing (compilation on
>     Intel platforms).
> 
> Changes since v3:
>   * Rewrote the subject. (Babu)
>   * Deleted the original "comment/help" expression, as this behavior is
>     confirmed for AMD CPUs. (Babu)
>   * Renamed "num_apic_ids" (v3) to "num_sharing_cache" to match spec
>     definition. (Babu)
> 
> Changes since v1:
>   * Renamed "l3_threads" to "num_apic_ids" in
>     encode_cache_cpuid8000001d(). (Yanan)
>   * Added the description of the original commit and add Cc.
> ---
>   target/i386/cpu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c77bcbc44d59..df56c7a449c8 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -331,7 +331,7 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>                                          uint32_t *eax, uint32_t *ebx,
>                                          uint32_t *ecx, uint32_t *edx)
>   {
> -    uint32_t l3_threads;
> +    uint32_t num_sharing_cache;
>       assert(cache->size == cache->line_size * cache->associativity *
>                             cache->partitions * cache->sets);
>   
> @@ -340,11 +340,11 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>   
>       /* L3 is shared among multiple cores */
>       if (cache->level == 3) {
> -        l3_threads = topo_info->cores_per_die * topo_info->threads_per_core;
> -        *eax |= (l3_threads - 1) << 14;
> +        num_sharing_cache = 1 << apicid_die_offset(topo_info);
>       } else {
> -        *eax |= ((topo_info->threads_per_core - 1) << 14);
> +        num_sharing_cache = 1 << apicid_core_offset(topo_info);
>       }
> +    *eax |= (num_sharing_cache - 1) << 14;
>   
>       assert(cache->line_size > 0);
>       assert(cache->partitions > 0);


