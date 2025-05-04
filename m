Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFAEC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 15:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbW4-0007ui-DV; Sun, 04 May 2025 11:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBbW1-0007uP-6Y
 for qemu-devel@nongnu.org; Sun, 04 May 2025 11:44:29 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBbVy-0002J2-Il
 for qemu-devel@nongnu.org; Sun, 04 May 2025 11:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746373467; x=1777909467;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LOKB0QwOMycqPouiOhUswgKkEgwBvNoaGnpWa+22M9U=;
 b=KQc9fsiYAJibVkTlm1UNSbGJXaRYpKMyo1XF2Z4lwxGjHSb8LOeq0FEe
 1jwOEkGctuJ+/pbfbozJ7Dr3CesHHVQSAI5yPvrcE/jxbMdc+Shi4cvqD
 5X/FVxNEpejGadeP/4070IYHXAHv+1eoLXatpxhFTp4Y42XlLbZ6KTsBR
 QOQXSV1wYZRhabuAp0aCVZGEhW/ebp5zuegUxOzpGyrklAPz/F9uEgE1T
 trtMShabFHEstqDFVuezVmg600IYStS3sZKI9UX9o9MBVBNAHAfjvSmJd
 P6o/pmN6KtfCp0/1TF1dC6jMXIP/7avuhlVMcGizOPVfaxnmVasdMSIZU g==;
X-CSE-ConnectionGUID: 8OmCn7TvScW34boeP7Qz9A==
X-CSE-MsgGUID: aUHRGSRNSj2zGk+/qIGAKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="65389068"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="65389068"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2025 08:44:23 -0700
X-CSE-ConnectionGUID: +byyRncxQlidwGes1Wy5hQ==
X-CSE-MsgGUID: 9YR/5jUsQJ6Ls8a6h51TCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="140196802"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 04 May 2025 08:44:19 -0700
Date: Mon, 5 May 2025 00:05:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 44/55] i386/tdx: Implement adjust_cpuid_features() for
 TDX
Message-ID: <aBeQP9Cc1nGqmfLQ@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-45-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-45-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
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

On Tue, Apr 01, 2025 at 09:01:54AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:54 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 44/55] i386/tdx: Implement adjust_cpuid_features() for
>  TDX
> X-Mailer: git-send-email 2.34.1
> 
> Maintain a TDX specific supported CPUID set, and use it to mask the
> common supported CPUID value of KVM. It can avoid newly added supported
> features (reported via KVM_GET_SUPPORTED_CPUID) for common VMs being
> falsely reported as supported for TDX.
> 
> As the first step, initialize the TDX supported CPUID set with all the
> configurable CPUID bits. It's not complete because there are other CPUID
> bits are supported for TDX but not reported as directly configurable.
> E.g. the XFAM related bits, attribute related bits and fixed-1 bits.
> They will be handled in the future.
> 
> Also, what matters are the CPUID bits related to QEMU's feature word.
> Only mask the CPUID leafs which are feature word leaf.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c          | 18 ++++++++++++++++++
>  target/i386/cpu.h          |  1 +
>  target/i386/kvm/kvm.c      |  2 +-
>  target/i386/kvm/kvm_i386.h |  1 +
>  target/i386/kvm/tdx.c      | 34 ++++++++++++++++++++++++++++++++++
>  5 files changed, 55 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f219961b62cd..4061d38d3fbe 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1655,6 +1655,24 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      },
>  };
>  
> +bool is_feature_word_cpuid(uint32_t feature, uint32_t index, int reg)
> +{
> +    FeatureWordInfo *wi;
> +    FeatureWord w;
> +
> +    for (w = 0; w < FEATURE_WORDS; w++)
> +    {

(style nit?) "{" should be at the end of the previous line?

> +        wi = &feature_word_info[w];
> +        if (wi->type == CPUID_FEATURE_WORD && wi->cpuid.eax == feature &&
> +            (!wi->cpuid.needs_ecx || wi->cpuid.ecx == index) &&
> +            wi->cpuid.reg == reg)
> +        {

ditto.

> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +

