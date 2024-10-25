Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF36D1038E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 01:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t490H-0002LY-HI; Thu, 24 Oct 2024 21:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t490G-0002LP-5c
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 21:20:36 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t490D-0007JJ-Jf
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 21:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729819234; x=1761355234;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mpoLW05e3jF4o7qRMwpIu16Yxtqph0JcNqH3sEGtErI=;
 b=dwhtUxoVFeLYcN/VGGjzCaRWZoWa6gBukYSai6i3HTwt0/Q62gIkHcJT
 ruOXl3sekSg/GI92axwU12lZNEPEEmCDn86YeCc+WCXTnrUwhSmxvXhog
 Awpbjgq0T5x7T4nRpt0KCQCSwtIyAbv2GCoy0iyTrolbaIx7TQtDwHrDi
 8ryqn9qXSF3L7W2ehAbWlH4jHNxL0f+VAJOsVCxBU9rRd7UaxHFaDLAM9
 U1CCKJ8uFbV3JAPJGNcnMK6cHx+uJZr8NZCc2LionMEdc2xVUBc1Zk4bz
 eEZNL/5XryfaNUc+YmZ7A0Gs1+gO/P+MY200yQWuSkq6rTaV3lICagmky Q==;
X-CSE-ConnectionGUID: QSrnEFm7QmaLC5GhKkN5ag==
X-CSE-MsgGUID: mgeV5gHPSOa3thyKHfefXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="28922000"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; d="scan'208";a="28922000"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2024 18:20:27 -0700
X-CSE-ConnectionGUID: vuKO3D47RNGlsAeFVg6xjQ==
X-CSE-MsgGUID: dKHEtZ9+RNqT5UFHcnhFGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; d="scan'208";a="84731712"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.172])
 ([10.124.227.172])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2024 18:20:26 -0700
Message-ID: <f8370907-cc8d-41d0-bf9b-b9581d8a08fe@intel.com>
Date: Fri, 25 Oct 2024 09:20:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i386/cpu: Drop the check of phys_bits in
 host_cpu_realizefn()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org
References: <20240929085747.2023198-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240929085747.2023198-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

Ping.

Paolo, this is a simple clean up.

On 9/29/2024 4:57 PM, Xiaoyao Li wrote:
> The check of cpu->phys_bits to be in range between
> [32, TARGET_PHYS_ADDR_SPACE_BITS] in host_cpu_realizefn()
> is duplicated with check in x86_cpu_realizefn().
> 
> Since the ckeck in x86_cpu_realizefn() is called later and can cover all
> the x86 cases. Remove the one in host_cpu_realizefn().
> 
> Opportunistically adjust cpu->phys_bits directly in
> host_cpu_adjust_phys_bits(), which matches more with the function name.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes in v2:
>   - make host_cpu_adjust_phys_bits() return void and adjust
>     cpu->phys_bits inside it.
> ---
>   target/i386/host-cpu.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 8b8bf5afeccf..03b9d1b169a5 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -42,7 +42,7 @@ static uint32_t host_cpu_phys_bits(void)
>       return host_phys_bits;
>   }
>   
> -static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
> +static void host_cpu_adjust_phys_bits(X86CPU *cpu)
>   {
>       uint32_t host_phys_bits = host_cpu_phys_bits();
>       uint32_t phys_bits = cpu->phys_bits;
> @@ -66,7 +66,7 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>           }
>       }
>   
> -    return phys_bits;
> +    cpu->phys_bits = phys_bits;
>   }
>   
>   bool host_cpu_realizefn(CPUState *cs, Error **errp)
> @@ -75,17 +75,7 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp)
>       CPUX86State *env = &cpu->env;
>   
>       if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> -        uint32_t phys_bits = host_cpu_adjust_phys_bits(cpu);
> -
> -        if (phys_bits &&
> -            (phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
> -             phys_bits < 32)) {
> -            error_setg(errp, "phys-bits should be between 32 and %u "
> -                       " (but is %u)",
> -                       TARGET_PHYS_ADDR_SPACE_BITS, phys_bits);
> -            return false;
> -        }
> -        cpu->phys_bits = phys_bits;
> +        host_cpu_adjust_phys_bits(cpu);
>       }
>       return true;
>   }

