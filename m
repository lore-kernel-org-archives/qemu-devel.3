Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D577CC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 03:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXDP-0002lo-8I; Thu, 03 Jul 2025 23:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXXDM-0002lM-OT
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:35:52 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXXDK-0004Uj-Kr
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751600150; x=1783136150;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XoPWIZKkCRL/8ix/HMKgSPakKffs06qDGCjRZMWZfQ0=;
 b=A9GMR6yfgeSdyMqDft0+fDeCpC4rvjMgD9z2hYZxC1rxOAsfElHV+Din
 QSUz3aCJaMf9gQiE45e7yaQu+ggBdKRPopo5/e1aK+rG+oLOFs3K/prFB
 HgXja0vxX3139NoCWWDz8OsSHOWBkkpHFou40lmAnOEEAwX4xrOzc7Jo8
 oDY3X7rRqZaNi0/viugZTmFPwC8s0dHe9dMkLQ6ILEPUQz8rW6Ea5TMMl
 YZNkLZXyvWNZaztcs8QNto8qDgP+/YqP0uOIHdiLHEg0sLQyiKO4VGfLS
 asztLSDJSry9f6YyO6bA6/k6zuFQFAOmsUxye6Q9VABnxMdj96sEmPpJ5 w==;
X-CSE-ConnectionGUID: 01cfceWjTWyjcig04Y6RDA==
X-CSE-MsgGUID: axHmm6DlTbqF0ym8WQuyYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57707776"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="57707776"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:35:47 -0700
X-CSE-ConnectionGUID: tdvCNNEoS3efkA75dcrLIg==
X-CSE-MsgGUID: AhJ++w4/SHezeTgNbFiB8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="160223475"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.37])
 ([10.124.240.37])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:35:44 -0700
Message-ID: <526613c9-2e81-466f-997f-6d4aa694de70@linux.intel.com>
Date: Fri, 4 Jul 2025 11:35:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] i386/cpu: Introduce cache model for SapphireRapids
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-4-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250626083105.2581859-4-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.14;
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


On 6/26/2025 4:31 PM, Zhao Liu wrote:
> Add the cache model to SapphireRapids (v4) to better emulate its
> environment.
>
> The cache model is based on SapphireRapids-SP (Scalable Performance):
>
>       --- cache 0 ---
>       cache type                         = data cache (1)
>       cache level                        = 0x1 (1)
>       self-initializing cache level      = true
>       fully associative cache            = false
>       maximum IDs for CPUs sharing cache = 0x1 (1)
>       maximum IDs for cores in pkg       = 0x3f (63)
>       system coherency line size         = 0x40 (64)
>       physical line partitions           = 0x1 (1)
>       ways of associativity              = 0xc (12)
>       number of sets                     = 0x40 (64)
>       WBINVD/INVD acts on lower caches   = false
>       inclusive to lower caches          = false
>       complex cache indexing             = false
>       number of sets (s)                 = 64
>       (size synth)                       = 49152 (48 KB)
>       --- cache 1 ---
>       cache type                         = instruction cache (2)
>       cache level                        = 0x1 (1)
>       self-initializing cache level      = true
>       fully associative cache            = false
>       maximum IDs for CPUs sharing cache = 0x1 (1)
>       maximum IDs for cores in pkg       = 0x3f (63)
>       system coherency line size         = 0x40 (64)
>       physical line partitions           = 0x1 (1)
>       ways of associativity              = 0x8 (8)
>       number of sets                     = 0x40 (64)
>       WBINVD/INVD acts on lower caches   = false
>       inclusive to lower caches          = false
>       complex cache indexing             = false
>       number of sets (s)                 = 64
>       (size synth)                       = 32768 (32 KB)
>       --- cache 2 ---
>       cache type                         = unified cache (3)
>       cache level                        = 0x2 (2)
>       self-initializing cache level      = true
>       fully associative cache            = false
>       maximum IDs for CPUs sharing cache = 0x1 (1)
>       maximum IDs for cores in pkg       = 0x3f (63)
>       system coherency line size         = 0x40 (64)
>       physical line partitions           = 0x1 (1)
>       ways of associativity              = 0x10 (16)
>       number of sets                     = 0x800 (2048)
>       WBINVD/INVD acts on lower caches   = false
>       inclusive to lower caches          = false
>       complex cache indexing             = false
>       number of sets (s)                 = 2048
>       (size synth)                       = 2097152 (2 MB)
>       --- cache 3 ---
>       cache type                         = unified cache (3)
>       cache level                        = 0x3 (3)
>       self-initializing cache level      = true
>       fully associative cache            = false
>       maximum IDs for CPUs sharing cache = 0x7f (127)
>       maximum IDs for cores in pkg       = 0x3f (63)
>       system coherency line size         = 0x40 (64)
>       physical line partitions           = 0x1 (1)
>       ways of associativity              = 0xf (15)
>       number of sets                     = 0x10000 (65536)
>       WBINVD/INVD acts on lower caches   = false
>       inclusive to lower caches          = false
>       complex cache indexing             = true
>       number of sets (s)                 = 65536
>       (size synth)                       = 62914560 (60 MB)
>       --- cache 4 ---
>       cache type                         = no more caches (0)
>
> Suggested-by: Tejus GK <tejus.gk@nutanix.com>
> Suggested-by: Jason Zeng <jason.zeng@intel.com>
> Suggested-by: "Daniel P . Berrangé" <berrange@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b40f1a5b6648..a7f2e5dd3fcb 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2886,6 +2886,97 @@ static const CPUCaches epyc_turin_cache_info = {
>      }
>  };
>  
> +static const CPUCaches xeon_spr_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        /* CPUID 0x4.0x0.EAX */
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .self_init = true,
> +
> +        /* CPUID 0x4.0x0.EBX */
> +        .line_size = 64,
> +        .partitions = 1,
> +        .associativity = 12,
> +
> +        /* CPUID 0x4.0x0.ECX */
> +        .sets = 64,
> +
> +        /* CPUID 0x4.0x0.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = false,
> +        .complex_indexing = false,
> +
> +        .size = 48 * KiB,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l1i_cache = &(CPUCacheInfo) {
> +        /* CPUID 0x4.0x1.EAX */
> +        .type = INSTRUCTION_CACHE,
> +        .level = 1,
> +        .self_init = true,
> +
> +        /* CPUID 0x4.0x1.EBX */
> +        .line_size = 64,
> +        .partitions = 1,
> +        .associativity = 8,
> +
> +        /* CPUID 0x4.0x1.ECX */
> +        .sets = 64,
> +
> +        /* CPUID 0x4.0x1.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = false,
> +        .complex_indexing = false,
> +
> +        .size = 32 * KiB,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l2_cache = &(CPUCacheInfo) {
> +        /* CPUID 0x4.0x2.EAX */
> +        .type = UNIFIED_CACHE,
> +        .level = 2,
> +        .self_init = true,
> +
> +        /* CPUID 0x4.0x2.EBX */
> +        .line_size = 64,
> +        .partitions = 1,
> +        .associativity = 16,
> +
> +        /* CPUID 0x4.0x2.ECX */
> +        .sets = 2048,
> +
> +        /* CPUID 0x4.0x2.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = false,
> +        .complex_indexing = false,
> +
> +        .size = 2 * MiB,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l3_cache = &(CPUCacheInfo) {
> +        /* CPUID 0x4.0x3.EAX */
> +        .type = UNIFIED_CACHE,
> +        .level = 3,
> +        .self_init = true,
> +
> +        /* CPUID 0x4.0x3.EBX */
> +        .line_size = 64,
> +        .partitions = 1,
> +        .associativity = 15,
> +
> +        /* CPUID 0x4.0x3.ECX */
> +        .sets = 65536,
> +
> +        /* CPUID 0x4.0x3.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = false,
> +        .complex_indexing = true,
> +
> +        .size = 60 * MiB,
> +        .share_level = CPU_TOPOLOGY_LEVEL_SOCKET,
> +    },
> +};
> +
>  static const CPUCaches xeon_gnr_cache_info = {
>      .l1d_cache = &(CPUCacheInfo) {
>          /* CPUID 0x4.0x0.EAX */
> @@ -4892,6 +4983,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                      { /* end of list */ }
>                  }
>              },
> +            {
> +                .version = 4,
> +                .note = "with spr-sp cache model",
> +                .cache_info = &xeon_spr_cache_info,
> +            },
>              { /* end of list */ }
>          }
>      },

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



