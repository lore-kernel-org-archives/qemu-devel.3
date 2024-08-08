Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDD4C52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 09:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbzpv-0004Qo-TZ; Thu, 08 Aug 2024 05:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbzpk-0003dR-86
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 05:53:24 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbzpi-0007tm-Ln
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 05:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723110803; x=1754646803;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SQ3snLs1rMNACamIDOtNuTEg5+7GVw7FXY0RnSzfJKw=;
 b=ZtxVPtf+45ukkaO906ZjhJMh0EDlFa5nqzYHiCFI7ycVNdWTGsRVnaVG
 yNNAKqG9pofMuy+3dNUfqDHIpRcNOwTtnBmMo6f6B7Ekhzp+fiup2NSEn
 hjjliXjI8EXe8VaYDav3EfwjEl5dlJBDgnqyjKLhOL/8B5MFWEqF421/R
 KqwhyKGSDt/uxqAquCEbD8eCyUXHsELR9HU2mD8GXsU53IJUlCtYRmkii
 KzpAbmXqsZtoVQAiLJINRli6bg3rUjHDYS3U7bo1zDJrzJZlGpsbaX+hy
 1liwXZ9RVDSRkipkeuw8p9jQ+ju+p28Ul64U6LGTvNBY4np16oEAk8Rsa g==;
X-CSE-ConnectionGUID: OWeUjLB/QKmvN6uQPeW3fA==
X-CSE-MsgGUID: U+Ifj3LkT4morzlB64HNPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21345066"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="21345066"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 02:53:17 -0700
X-CSE-ConnectionGUID: SB3wIC6KSxSI7xZOv/Vxmw==
X-CSE-MsgGUID: NPgGoP74Rw2W+vTPSmUOqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="61265078"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 08 Aug 2024 02:53:14 -0700
Date: Thu, 8 Aug 2024 18:09:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Manish <manish.mishra@nutanix.com>, John Levon <john.levon@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/cpu: Introduce enable_cpuid_0x1f to force exposing
 CPUID 0x1f
Message-ID: <ZrSZQN/AQa6BiIUu@intel.com>
References: <20240802072426.4016194-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802072426.4016194-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Xiaoyao,

Patch is generally fine for me. Just a few nits:

On Fri, Aug 02, 2024 at 03:24:26AM -0400, Xiaoyao Li wrote:
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index dff49fce1154..b63bce2f4c82 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -207,13 +207,4 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
>      return x86_apicid_from_topo_ids(topo_info, &topo_ids);
>  }
>  
> -/*
> - * Check whether there's extended topology level (module or die)?
> - */
> -static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
> -{
> -    return test_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap) ||
> -           test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
> -}
> -

[snip]

> +/*
> + * Check whether there's v2 extended topology level (module or die)?
> + */
> +bool x86_has_v2_extended_topo(X86CPU *cpu)
> +{
> +    if (cpu->enable_cpuid_0x1f) {
> +        return true;
> +    }
> +
> +    return test_bit(CPU_TOPO_LEVEL_MODULE, cpu->env.avail_cpu_topo) ||
> +           test_bit(CPU_TOPO_LEVEL_DIE, cpu->env.avail_cpu_topo);
> +}
> +

I suggest to decouple 0x1f enablement and extended topo check, since as
the comment of CPUTopoLevel said:

/*
 * CPUTopoLevel is the general i386 topology hierarchical representation,
 * ordered by increasing hierarchical relationship.
 * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
 * or AMD (CPUID[0x80000026]).
 */

The topology enumeration is generic and is not bound to the vendor.

[snip]

> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index c6cc035df3d8..211a42ffbfa6 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2110,6 +2110,9 @@ struct ArchCPU {
>      /* Compatibility bits for old machine types: */
>      bool enable_cpuid_0xb;
>  
> +    /* Force to expose cpuid 0x1f */

Maybe "Force to enable cpuid 0x1f"?

> +    bool enable_cpuid_0x1f;
> +
>      /* Enable auto level-increase for all CPUID leaves */
>      bool full_cpuid_auto_level;i

Regards,
Zhao


