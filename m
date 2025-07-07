Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1122BC83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 01:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYaIw-0007oc-LZ; Sun, 06 Jul 2025 21:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1uYaIc-0007Wk-DU
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 21:05:43 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1uYaIW-0003vB-1J
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 21:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751850332; x=1783386332;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=f+HXhUakUn6hipy3M+NB7aTECc/FHQJ48kTCWPSKp3U=;
 b=HM+3Q+rDydfpq6Z24+g20l6y3+GhxRfpruy5TilMJrlDLBO9vsbtn1+P
 suWhBisxYmbjB/wxAryTYhOZh70JJmhtwsYma6p9DRSwpTzRkxAWbuQT/
 3klLywiR5BSp6ot3p3xuTrh8p0yEDavpXfZZCZvjKm92V0w9jKgQtyi/4
 VsRwo0X/1PE8NhKfZvhRucdKS8aBVNs9N/AVA2CkyfchbZz+V/SyZx44b
 0RyjW4LlKjyBvJFl83LPeJsWG55TFOmmHo7EBCeHAI1WkvfuDqUNzVI8y
 66Gapo/pnGf3Kyqa2s5dEzde7YYhOo8qGMuApUOFxF96u3xh1sDAz9gHb A==;
X-CSE-ConnectionGUID: Tzq6OlbWQB6YB5j1NYSFUg==
X-CSE-MsgGUID: qRRUfhGrQECUfPxZujLh5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="54205824"
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; d="scan'208";a="54205824"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 18:05:30 -0700
X-CSE-ConnectionGUID: qN3GQWrCT02cgDVhaz/j8Q==
X-CSE-MsgGUID: OIbV2dbQRP2rvTlVRekWhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; d="scan'208";a="155202347"
Received: from linux.bj.intel.com ([10.238.157.71])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 18:05:26 -0700
Date: Mon, 7 Jul 2025 08:58:21 +0800
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
Subject: Re: [PATCH 2/8] i386/cpu: Introduce cache model for GraniteRapids
Message-ID: <aGsbrZVaC4T3S69b@linux.bj.intel.com>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-3-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626083105.2581859-3-zhao1.liu@intel.com>
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

On Thu, Jun 26, 2025 at 04:30:59PM +0800, Zhao Liu wrote:
> Add the cache model to GraniteRapids (v3) to better emulate its
> environment.
> 
> The cache model is based on GraniteRapids-SP (Scalable Performance):
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
>       ways of associativity              = 0x10 (16)
>       number of sets                     = 0x40 (64)
>       WBINVD/INVD acts on lower caches   = false
>       inclusive to lower caches          = false
>       complex cache indexing             = false
>       number of sets (s)                 = 64
>       (size synth)                       = 65536 (64 KB)
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
>       maximum IDs for CPUs sharing cache = 0xff (255)
>       maximum IDs for cores in pkg       = 0x3f (63)
>       system coherency line size         = 0x40 (64)
>       physical line partitions           = 0x1 (1)
>       ways of associativity              = 0x10 (16)
>       number of sets                     = 0x48000 (294912)
>       WBINVD/INVD acts on lower caches   = false
>       inclusive to lower caches          = false
>       complex cache indexing             = true
>       number of sets (s)                 = 294912
>       (size synth)                       = 301989888 (288 MB)
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
> index fcaa2625b023..b40f1a5b6648 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2886,6 +2886,97 @@ static const CPUCaches epyc_turin_cache_info = {
>      }
>  };
>  
> +static const CPUCaches xeon_gnr_cache_info = {
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
> +        .associativity = 16,
> +
> +        /* CPUID 0x4.0x1.ECX */
> +        .sets = 64,
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
> +        .associativity = 16,
> +
> +        /* CPUID 0x4.0x3.ECX */
> +        .sets = 294912,
> +
> +        /* CPUID 0x4.0x3.EDX */
> +        .no_invd_sharing = false,
> +        .inclusive = false,
> +        .complex_indexing = true,
> +
> +        .size = 288 * MiB,
> +        .share_level = CPU_TOPOLOGY_LEVEL_SOCKET,
> +    },
> +};
> +
>  static const CPUCaches xeon_srf_cache_info = {
>      .l1d_cache = &(CPUCacheInfo) {
>          /* CPUID 0x4.0x0.EAX */
> @@ -4954,6 +5045,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>                      { /* end of list */ }
>                  }
>              },
> +            {
> +                .version = 3,
> +                .note = "with gnr-sp cache model",
> +                .cache_info = &xeon_gnr_cache_info,
> +            },
>              { /* end of list */ },
>          },
>      },

Reviewed-by: Tao Su <tao1.su@linux.intel.com>

> -- 
> 2.34.1
> 
> 

