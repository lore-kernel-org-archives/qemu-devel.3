Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064F8E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 07:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR55h-0004Lt-Dj; Fri, 27 Dec 2024 02:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR55f-0004Lg-Ph
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:48:59 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR55e-0000TS-51
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735285739; x=1766821739;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=O26pCzvHiGkbpriJ3YSQpIkeyU33iPS7TDnZGazAfuo=;
 b=KYGJwivL3GSj31orwvespY69mZlJgD9R7eagPiA9HFy9IEWo0K1zXQsK
 bUtiB0x7LJsmNjPB9jGQ3EXVjUe/cVtQY5AdCK57uYz/sPrLQdDlPZlHI
 R59wrdQ6tPxSMAW5o0IcZzaeIsOnn5Mg6Tz3UVf5Z0ufPKJYhVHrpflJg
 mJu57Q0GOv1QT0RYjvrz5FVvxuTpd9pL1b7+/0FFwkCHE2fcHDWjHy8Cu
 IUNO1dkmSQGhPQs2+nDmCpmE31z8gaTz1+/g2n41GXKovUt7JXCdpxuSe
 9O7+s8eNpN7L4azFa9S/lkxO9X5U4O8NT12ln/2nEoe6jJv6dwcoUX8O6 A==;
X-CSE-ConnectionGUID: zmJbzws4QHGomBBr4dwN1Q==
X-CSE-MsgGUID: cEAlGwCZToiqOQMlXjeRGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46689690"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; d="scan'208";a="46689690"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2024 23:48:56 -0800
X-CSE-ConnectionGUID: fAibczPOSEWGWEkwXQ8ZfQ==
X-CSE-MsgGUID: xUU2DtkwSiutCAi2eWX0pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; d="scan'208";a="100474532"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 26 Dec 2024 23:48:53 -0800
Date: Fri, 27 Dec 2024 16:07:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v2 07/10] i386/cpu: Hoist check of CPUID_EXT3_TOPOEXT
 against threads_per_core
Message-ID: <Z25gSWzeVNLqIAPc@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-8-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219110125.1266461-8-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Dec 19, 2024 at 06:01:22AM -0500, Xiaoyao Li wrote:
> Date: Thu, 19 Dec 2024 06:01:22 -0500
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v2 07/10] i386/cpu: Hoist check of CPUID_EXT3_TOPOEXT
>  against threads_per_core
> X-Mailer: git-send-email 2.34.1
> 
> Now it changes to use env->topo_info.threads_per_core and doesn't depend
> on qemu_init_vcpu() anymore. Drop the comment of the order dependency on
> qemu_init_vcpu() and hoist code to put it together with other feature
> checking.

The comment was dropped in patch 6. You could move such description to
there.

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d41768648ab9..fd59da5d445d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7880,6 +7880,21 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>       */
>      cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
>  
> +    /*
> +     * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
> +     * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
> +     * based on inputs (sockets,cores,threads), it is still better to give
> +     * users a warning.
> +     */
> +    if (IS_AMD_CPU(env) &&
> +        !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
> +        env->nr_threads > 1) {

Typo, env->topo_info.threads_per_core.

> +            warn_report_once("This family of AMD CPU doesn't support "
> +                             "hyperthreading(%d). Please configure -smp "
> +                             "options properly or try enabling topoext "
> +                             "feature.", env->nr_threads);
> +    }
> +
>      /* For 64bit systems think about the number of physical bits to present.
>       * ideally this should be the same as the host; anything other than matching
>       * the host can cause incorrect guest behaviour.

