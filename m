Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BCBC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWu9f-0002bR-NK; Wed, 02 Jul 2025 05:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWu9c-0002Zl-2Z
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:53:24 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWu9Z-0007UA-FD
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751450001; x=1782986001;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xsYSFyWfUP4dM60KShwxzL7P0YUz5LJGiSX5HfsrnFc=;
 b=VkXv1JepUFpWBEG5dsb0bWgVLKxVqOl/1/yY0QSvWGWitb/OyXUD4yqO
 VqHgt9yY8zdJ43rdEaK5isGZ7uyl7F5u9MD6qm49H8qfZLnYshJsgHq/b
 ZCQ7n5WX9MEUwg9e8b+hqeHnBQh1RRroVfig0an2TL7pqrdifEHQGoLZq
 rMa7QR59sXI30EIV6r0MplbFpnyjNBomk6FQAkw47PkL4m8p1FjqNyV07
 HkGNY1XXmlUToSywu9F0wnn8x3d9pe075MQ0HzDPjcZv0jkaWhY+RyrX1
 /WAlYt4kmWbz2BrBhbKdb5q5FDEa18lA++7M6QGCvAiMmI7rB10q7xdcN g==;
X-CSE-ConnectionGUID: du5l+wJrSWG8l7pgsIFaVQ==
X-CSE-MsgGUID: 9KLxujSyTqKcYwKU39nU+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="41366771"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="41366771"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 02:53:18 -0700
X-CSE-ConnectionGUID: Up+UuLpWRlWJglhROrKgsA==
X-CSE-MsgGUID: 0Dj1I1MSSpO91+cMObr0Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="153486819"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 02:53:14 -0700
Message-ID: <c93dce97-735b-4a1d-b766-f882e53eb50e@linux.intel.com>
Date: Wed, 2 Jul 2025 17:53:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] i386/cpu: Add default cache model for Intel CPUs
 with level < 4
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
 <20250620092734.1576677-4-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250620092734.1576677-4-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.16;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> Old Intel CPUs with CPUID level < 4, use CPUID 0x2 leaf (if available)
> to encode cache information.
>
> Introduce a cache model "legacy_intel_cpuid2_cache_info" for the CPUs
> with CPUID level < 4, based on legacy_l1d_cache, legacy_l1i_cache,
> legacy_l2_cache_cpuid2 and legacy_l3_cache. But for L2 cache, this
> cache model completes self_init, sets, partitions, no_invd_sharing and
> share_level fields, referring legacy_l2_cache, to avoid someone
> increases CPUID level manually and meets assert() error. But the cache
> information present in CPUID 0x2 leaf doesn't change.
>
> This new cache model makes it possible to remove legacy_l2_cache_cpuid2
> in X86CPUState and help to clarify historical cache inconsistency issue.
>
> Furthermore, apply this legacy cache model to all Intel CPUs with CPUID
> level < 4. This includes not only "pentium2" and "pentium3" (which have
> 0x2 leaf), but also "486" and "pentium" (which only have 0x1 leaf, and
> cache model won't be presented, just for simplicity).
>
> A legacy_intel_cpuid2_cache_info cache model doesn't change the cache
> information of the above CPUs, because they just depend on 0x2 leaf.
>
> Only when someone adjusts the min-level to >=4 will the cache
> information in CPUID leaf 4 differ from before: previously, the L2
> cache information in CPUID leaf 0x2 and 0x4 was different, but now with
> legacy_intel_cpuid2_cache_info, the information they present will be
> consistent. This case almost never happens, emulating a CPUID that is
> not supported by the "ancient" hardware is itself meaningless behavior.
>
> Therefore, even though there's the above difference (for really rare
> case) and considering these old CPUs ("486", "pentium", "pentium2" and
> "pentium3") won't be used for migration, there's no need to add new
> versioned CPU models
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 995766c9d74c..0a2c32214cc3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -710,6 +710,67 @@ static CPUCacheInfo legacy_l3_cache = {
>      .share_level = CPU_TOPOLOGY_LEVEL_DIE,
>  };
>  
> +/*
> + * Only used for the CPU models with CPUID level < 4.
> + * These CPUs (CPUID level < 4) only use CPUID leaf 2 to present
> + * cache information.
> + *
> + * Note: This cache model is just a default one, and is not
> + *       guaranteed to match real hardwares.
> + */
> +static const CPUCaches legacy_intel_cpuid2_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .size = 32 * KiB,
> +        .self_init = 1,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .sets = 64,
> +        .partitions = 1,
> +        .no_invd_sharing = true,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l1i_cache = &(CPUCacheInfo) {
> +        .type = INSTRUCTION_CACHE,
> +        .level = 1,
> +        .size = 32 * KiB,
> +        .self_init = 1,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .sets = 64,
> +        .partitions = 1,
> +        .no_invd_sharing = true,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l2_cache = &(CPUCacheInfo) {
> +        .type = UNIFIED_CACHE,
> +        .level = 2,
> +        .size = 2 * MiB,
> +        .self_init = 1,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .sets = 4096,
> +        .partitions = 1,
> +        .no_invd_sharing = true,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l3_cache = &(CPUCacheInfo) {
> +        .type = UNIFIED_CACHE,
> +        .level = 3,
> +        .size = 16 * MiB,
> +        .line_size = 64,
> +        .associativity = 16,
> +        .sets = 16384,
> +        .partitions = 1,
> +        .lines_per_tag = 1,
> +        .self_init = true,
> +        .inclusive = true,
> +        .complex_indexing = true,
> +        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
> +    },

Does this cache information match the real legacy HW or just an emulation
of Qemu?


> +};
> +
>  /* TLB definitions: */
>  
>  #define L1_DTLB_2M_ASSOC       1
> @@ -3043,6 +3104,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>              I486_FEATURES,
>          .xlevel = 0,
>          .model_id = "",
> +        .cache_info = &legacy_intel_cpuid2_cache_info,
>      },
>      {
>          .name = "pentium",
> @@ -3055,6 +3117,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>              PENTIUM_FEATURES,
>          .xlevel = 0,
>          .model_id = "",
> +        .cache_info = &legacy_intel_cpuid2_cache_info,
>      },
>      {
>          .name = "pentium2",
> @@ -3067,6 +3130,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>              PENTIUM2_FEATURES,
>          .xlevel = 0,
>          .model_id = "",
> +        .cache_info = &legacy_intel_cpuid2_cache_info,
>      },
>      {
>          .name = "pentium3",
> @@ -3079,6 +3143,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>              PENTIUM3_FEATURES,
>          .xlevel = 0,
>          .model_id = "",
> +        .cache_info = &legacy_intel_cpuid2_cache_info,
>      },
>      {
>          .name = "athlon",

