Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0673C83F03
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 01:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYaI8-0006rq-Sk; Sun, 06 Jul 2025 21:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1uYaI1-0006nR-Ib
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 21:05:04 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1uYaHx-0003f2-GU
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 21:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751850297; x=1783386297;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=18w70AbRHpWSy5j2G/y4VtCWYM687MVLsKayc3psT8I=;
 b=IA4RNmWqBdHe3q2p/c5LUzM1kajWIXSH+RByk7s6O6qdojsgfdcdK3h+
 sP0ilhevbuyVl/k+zb8sIhxKZAPMgiAwMwy0TmWrtD8tNNxbsMa4DFyw0
 wyKCG6ZOAeegdKNQMsKJrkkE6k2eTHDDAJHuypYROd/8dp84UVhHHv3xo
 cKhPPdz/PnIQoh8ioKVtOgu7T66EMnuLj4scvNfQto+uroRdpotKI5buU
 6p8r0ubTwj7l4X9eCXvEU8Jb0692mzfYcglMwUasYiRbFm3ttj71J/3vG
 hU0I2EupByOvy+v6OLeeoEHfT95yvO43zTnq++FOYnYoxezA3TiP3LHnw w==;
X-CSE-ConnectionGUID: UUnWAgEKRPOehqPhxbr3vA==
X-CSE-MsgGUID: L9eH4DeLT7KTqQoRPduS/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="54205747"
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; d="scan'208";a="54205747"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 18:04:55 -0700
X-CSE-ConnectionGUID: N4x8my+ZQj2FM0JOtpW3Hw==
X-CSE-MsgGUID: M3X9hHV/RsiPTlzxQtAbvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; d="scan'208";a="159103532"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 18:04:52 -0700
Date: Mon, 7 Jul 2025 08:57:47 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>,
 Manish Mishra <manish.mishra@nutanix.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/8] i386/cpu: Introduce cache model for SierraForest
Message-ID: <aGsbiw8aa+gzjtNz@linux.bj.intel.com>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-2-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626083105.2581859-2-zhao1.liu@intel.com>
Received-SPF: none client-ip=192.198.163.15;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jun 26, 2025 at 04:30:58PM +0800, Zhao Liu wrote:
> Add the cache model to SierraForest (v3) to better emulate its
> environment.
> 
> The cache model is based on SierraForest-SP (Scalable Performance):
> 
>       --- cache 0 ---
>       cache type                         = data cache (1)
>       cache level                        = 0x1 (1)
>       self-initializing cache level      = true
>       fully associative cache            = false
>       maximum IDs for CPUs sharing cache = 0x0 (0)
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
>       --- cache 1 ---
>       cache type                         = instruction cache (2)
>       cache level                        = 0x1 (1)
>       self-initializing cache level      = true
>       fully associative cache            = false
>       maximum IDs for CPUs sharing cache = 0x0 (0)
>       maximum IDs for cores in pkg       = 0x3f (63)
>       system coherency line size         = 0x40 (64)
>       physical line partitions           = 0x1 (1)
>       ways of associativity              = 0x8 (8)
>       number of sets                     = 0x80 (128)
>       WBINVD/INVD acts on lower caches   = false
>       inclusive to lower caches          = false
>       complex cache indexing             = false
>       number of sets (s)                 = 128
>       (size synth)                       = 65536 (64 KB)
>       --- cache 2 ---
>       cache type                         = unified cache (3)
>       cache level                        = 0x2 (2)
>       self-initializing cache level      = true
>       fully associative cache            = false
>       maximum IDs for CPUs sharing cache = 0x7 (7)
>       maximum IDs for cores in pkg       = 0x3f (63)
>       system coherency line size         = 0x40 (64)
>       physical line partitions           = 0x1 (1)
>       ways of associativity              = 0x10 (16)
>       number of sets                     = 0x1000 (4096)
>       WBINVD/INVD acts on lower caches   = false
>       inclusive to lower caches          = false
>       complex cache indexing             = false
>       number of sets (s)                 = 4096
>       (size synth)                       = 4194304 (4 MB)
>       --- cache 3 ---
>       cache type                         = unified cache (3)
>       cache level                        = 0x3 (3)
>       self-initializing cache level      = true
>       fully associative cache            = false
>       maximum IDs for CPUs sharing cache = 0x1ff (511)
>       maximum IDs for cores in pkg       = 0x3f (63)
>       system coherency line size         = 0x40 (64)
>       physical line partitions           = 0x1 (1)
>       ways of associativity              = 0xc (12)
>       number of sets                     = 0x24000 (147456)
>       WBINVD/INVD acts on lower caches   = false
>       inclusive to lower caches          = false
>       complex cache indexing             = true
>       number of sets (s)                 = 147456
>       (size synth)                       = 113246208 (108 MB)
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
> index 28e5b7859fef..fcaa2625b023 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2883,6 +2883,97 @@ static const CPUCaches epyc_turin_cache_info = {
>          .no_invd_sharing = true,
>          .complex_indexing = false,
>          .share_level = CPU_TOPOLOGY_LEVEL_DIE,
> +    }
> +};
> +
> +static const CPUCaches xeon_srf_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        /* CPUID 0x4.0x0.EAX */
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .self_init = true,
> +
> +        /* CPUID 0x4.0x0.EBX */
> +        .line_size = 64,
> +        .partitions = 1,
> +        .associativity = 8,
> +
> +        /* CPUID 0x4.0x0.ECX */
> +        .sets = 64,
> +
> +        /* CPUID 0x4.0x0.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = false,
> +        .complex_indexing = false,
> +
> +        .size = 32 * KiB,
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
> +        .sets = 128,
> +
> +        /* CPUID 0x4.0x1.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = false,
> +        .complex_indexing = false,
> +
> +        .size = 64 * KiB,
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
> +        .sets = 4096,
> +
> +        /* CPUID 0x4.0x2.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = false,
> +        .complex_indexing = false,
> +
> +        .size = 4 * MiB,
> +        .share_level = CPU_TOPOLOGY_LEVEL_MODULE,
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
> +        .associativity = 12,
> +
> +        /* CPUID 0x4.0x3.ECX */
> +        .sets = 147456,
> +
> +        /* CPUID 0x4.0x3.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = false,
> +        .complex_indexing = true,
> +
> +        .size = 108 * MiB,
> +        .share_level = CPU_TOPOLOGY_LEVEL_SOCKET,
>      },
>  };
>  
> @@ -5008,6 +5099,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                      { /* end of list */ }
>                  }
>              },
> +            {
> +                .version = 3,
> +                .note = "with srf-sp cache model",
> +                .cache_info = &xeon_srf_cache_info,
> +            },
>              { /* end of list */ },
>          },
>      },

Reviewed-by: Tao Su <tao1.su@linux.intel.com>

> -- 
> 2.34.1
> 
> 

