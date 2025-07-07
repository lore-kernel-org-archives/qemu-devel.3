Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB44CC83F03
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 01:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYaJm-0008GD-Oe; Sun, 06 Jul 2025 21:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1uYaJ4-0007wB-A9
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 21:06:06 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1uYaJ2-000417-FP
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 21:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751850364; x=1783386364;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ToxmXaLsQNlK3QaYIfDs7YDpxVItDtnwa4wii+5k+do=;
 b=RcLunMM+FSFlx3wXz3+XCjPbf0/wJ30dYEw5BkaO1mF8iRqt1JP2Wo/F
 mvSAayTy6JjUWtK9SP4h8AoDNIAj7EotHGdBKM36dykwl/EOXNAYpoT1z
 EhJ7QK7++JKs6X7NI02zV9iwuJWcyZd1OAnglh3Qj6PKHkkbn5unoAZ3z
 jYc6PPw7xYxqZWEJgycJx/34aWa1CknfsODNZ6/44dSX2daCh2a192j2G
 6VAdXsy1EADahkXVOes0tBYDJcYYJL6GzRIvtUtYtn98UX5+0BXFmhIXJ
 1X5qco5/5RRydgyMfSgvpVy1ZVkqYMmsN7qLVrmfSaQfgaQ69ls+L3Vn8 w==;
X-CSE-ConnectionGUID: 9bljTI5bTB+PUuH3saDUJA==
X-CSE-MsgGUID: ibm6HjPkSAmOx0KDvawlWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="53189443"
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; d="scan'208";a="53189443"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 18:06:02 -0700
X-CSE-ConnectionGUID: oxNggD5MQNuASkZlWezRlg==
X-CSE-MsgGUID: 7Varrn6MQaix9GFq+9AAOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; d="scan'208";a="159352794"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 18:05:59 -0700
Date: Mon, 7 Jul 2025 08:58:54 +0800
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
Subject: Re: [PATCH 3/8] i386/cpu: Introduce cache model for SapphireRapids
Message-ID: <aGsbzuHnZcjciRxM@linux.bj.intel.com>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-4-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626083105.2581859-4-zhao1.liu@intel.com>
Received-SPF: none client-ip=192.198.163.19;
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

On Thu, Jun 26, 2025 at 04:31:00PM +0800, Zhao Liu wrote:
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

Reviewed-by: Tao Su <tao1.su@linux.intel.com>

> -- 
> 2.34.1
> 
> 

