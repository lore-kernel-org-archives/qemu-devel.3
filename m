Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9723DD13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 08:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5LIa-0006Tw-VU; Mon, 28 Oct 2024 04:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5LIQ-0006Se-EV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:40:19 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5LIO-0002jj-2p
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730104816; x=1761640816;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=giOUIlMYY9g+1lp8uUNbkptN/mLl6W7Jm/JD1/sGYxQ=;
 b=RM8RwWzp8o8sA91OsDeCcb0GtcVWJzG0IRP1d5glGL7OfooCfCEp00Kx
 3bDI8bEXffQFEI0gJJe80CT5Ne1DJBxFR8w/NDJSDoLCMPC+2nA3/Qvmd
 De3qFPiDcRxFs6KSfz7jfz8yO9mSaTrE2szGScbW74I4PkCZwQrEKNffI
 DB7c82a2x1yBlaRgLgsU7Pt3K4H6lIDz2n6REOxunVCx7fBDzd8bQjXZM
 PZ+5OMgFf15Oecbnjay41d29lCOii0AzbTUP5buNFqW7yo16D0xLwV6UY
 L2r1GsTdVDqeBAvJhSumK2Y13LJzviKcTqhUp1d5+aFX6PgRzeV+uHyOe A==;
X-CSE-ConnectionGUID: NXnVoC/7QOyRp37bh4o8rw==
X-CSE-MsgGUID: mSLpcJ6UTjO75bXoTWjExw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29553258"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29553258"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 01:39:57 -0700
X-CSE-ConnectionGUID: ePYqHz3ZTLCh3IhLXteREA==
X-CSE-MsgGUID: wxQqWWDYQZSja73delKz4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="86292516"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 28 Oct 2024 01:39:55 -0700
Date: Mon, 28 Oct 2024 16:56:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 5/7] target/i386: Expose bits related to SRSO
 vulnerability
Message-ID: <Zx9Rrtks38sqcn44@intel.com>
References: <cover.1729807947.git.babu.moger@amd.com>
 <dadbd70c38f4e165418d193918a3747bd715c5f4.1729807947.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dadbd70c38f4e165418d193918a3747bd715c5f4.1729807947.git.babu.moger@amd.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Babu

On Thu, Oct 24, 2024 at 05:18:23PM -0500, Babu Moger wrote:
> Date: Thu, 24 Oct 2024 17:18:23 -0500
> From: Babu Moger <babu.moger@amd.com>
> Subject: [PATCH v3 5/7] target/i386: Expose bits related to SRSO
>  vulnerability
> X-Mailer: git-send-email 2.34.1
> 
> Add following bits related Speculative Return Stack Overflow (SRSO).
> Guests can make use of these bits if supported.
> 
> These bits are reported via CPUID Fn8000_0021_EAX.
> ===================================================================
> Bit Feature Description
> ===================================================================
> 27  SBPB                Indicates support for the Selective Branch Predictor Barrier.
> 28  IBPB_BRTYPE         MSR_PRED_CMD[IBPB] flushes all branch type predictions.
> 29  SRSO_NO             Not vulnerable to SRSO.
> 30  SRSO_USER_KERNEL_NO Not vulnerable to SRSO at the user-kernel boundary.
> ===================================================================
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
> Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip

I suggest updating the description of SRSO-related mitigations in the
"Important CPU features for AMD x86 hosts" section of docs/system/
cpu-models-x86.rst.inc.

If you could also synchronize the CPU model (you added in this series)
in the "Preferred CPU models for AMD x86 hosts" section, that would be
even better. :-)

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v3: New patch
> ---
>  target/i386/cpu.c |  2 +-
>  target/i386/cpu.h | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 690efd4085..642e71b636 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1221,7 +1221,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, "sbpb",
> -            "ibpb-brtype", NULL, NULL, NULL,
> +            "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
>          },
>          .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
>          .tcg_features = 0,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e0dea1ba54..792518b62d 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1015,13 +1015,21 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>  #define CPUID_8000_0008_EBX_AMD_PSFD    (1U << 28)
>  
>  /* Processor ignores nested data breakpoints */
> -#define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP    (1U << 0)
> +#define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP            (1U << 0)
>  /* LFENCE is always serializing */
>  #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
>  /* Null Selector Clears Base */
> -#define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE    (1U << 6)
> +#define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
>  /* Automatic IBRS */
> -#define CPUID_8000_0021_EAX_AUTO_IBRS   (1U << 8)
> +#define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
> +/* Selective Branch Predictor Barrier */
> +#define CPUID_8000_0021_EAX_SBPB                         (1U << 27)
> +/* IBPB includes branch type prediction flushing */
> +#define CPUID_8000_0021_EAX_IBPB_BRTYPE                  (1U << 28)
> +/* Not vulnerable to Speculative Return Stack Overflow */
> +#define CPUID_8000_0021_EAX_SRSO_NO                      (1U << 29)
> +/* Not vulnerable to SRSO at the user-kernel boundary */
> +#define CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO          (1U << 30)

These feature bits defination could be added in patch 7 because only
patch 7 uses these macros.

BTW, which platform supports CPUID_8000_0021_EAX_SRSO_NO? I found that
even the Turin model added in patch 7 does not support this feature.

Thanks,
Zhao

>  /* Performance Monitoring Version 2 */
>  #define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
> -- 
> 2.34.1
> 
> 

