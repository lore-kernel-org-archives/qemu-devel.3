Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26619C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 16:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFFeJ-0007X5-TX; Thu, 06 Jun 2024 12:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sFFdx-0007FM-Gu
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 12:07:16 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sFFdn-0003ES-Kr
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 12:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717690023; x=1749226023;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1XKZ44WGUpAi2jpfzSWox24/x+wJ5NGoo2EUsQeEyrY=;
 b=R6jbvp2dLf1qPHZDdEnbk5ha5LTn2/Ljon4g2KMyLcpjQLVowHXrNiQU
 nqnC9BQXpE9HtFeULBtm/CdufaQVInjCBnZyvDir4W/nm9wL9gjd+hA3E
 UuI+jv2yIgMlRfL1XuLgXtC1a5o7Dtu8pGPLdUDHorQBSCWY0oDY/IWwX
 eBzliFE16w9R8+vnfnQz89+SwpUiHT7aU8JY+8wqr4y1Qom1N5JAgTlkY
 a55hmBmbCkfj7HoKqxxy7BNzy9MCq27/BjAQGFg2MOSwZ2hPgFKffai5U
 WfolTaPJbsyl/N0LmgOcxCSLQg2TB1QuqLrQoaxi/UTT3E3k+PKh1AxUS g==;
X-CSE-ConnectionGUID: BRHR61wORLC4nAp2qReb7g==
X-CSE-MsgGUID: JuStVgmRRVaUK4ZrEXL+fw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="18163172"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; d="scan'208";a="18163172"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 09:06:59 -0700
X-CSE-ConnectionGUID: IZxt733ORweHL9ZkiMauWQ==
X-CSE-MsgGUID: o7WjCEGRSpKC5jSCTYTpBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; d="scan'208";a="38083189"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.247.52])
 ([10.125.247.52])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 09:06:59 -0700
Message-ID: <ae827bce-41d7-450c-8fe8-69df55430bd0@intel.com>
Date: Fri, 7 Jun 2024 00:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: SEV: do not assume machine->cgs is SEV
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: pankaj.gupta@amd.com
References: <20240605224409.2103109-1-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240605224409.2103109-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.172, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/6/2024 6:44 AM, Paolo Bonzini wrote:
> There can be other confidential computing classes that are not derived
> from sev-common.  Avoid aborting when encountering them.

I hit it today when rebasing TDX patches to latest QEMU master, which 
has the SEV-SNP series merged. (I didn't get time to review it between 
it gets merged.)

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/sev.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 004c667ac14..97e15f8b7a9 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -1710,7 +1710,9 @@ void sev_es_set_reset_vector(CPUState *cpu)

my approach is to guard with sev_enabled() when calling 
sev_es_set_reset_vector() in kvm_arch_reset_vcpu(), because calling sev* 
specific function in generic kvm code doesn't look reasonable to me.

>   {
>       X86CPU *x86;
>       CPUX86State *env;
> -    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
> +    SevCommonState *sev_common = SEV_COMMON(
> +        object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON));
>   
>       /* Only update if we have valid reset information */
>       if (!sev_common || !sev_common->reset_data_valid) {


