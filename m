Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D78CC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 12:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucNRM-0000Af-I2; Thu, 17 Jul 2025 08:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucNOQ-0007CV-LD
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:07:20 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucNOL-0003Av-Qo
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752754033; x=1784290033;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Pc3DZ+dmxEDo0TSAA9TvglQBr+MXdkDgJZulnqD3LSg=;
 b=OOgz0uy19RHMB9ggTCMJa8bpl6lMdeTPNz86xl3vlyyRj9l1M1hwW74p
 posfjjI7irDzgt5b0wmGolpTLMl3WKpGwglzFu6EEcOn4gbxHW34lnqV7
 Aik8DO/jWPcm0bfMTVC2EWEODQl5Eno5++NrPHiuHwdBVj2QV3nk+OetY
 QWnqQsP1CwSeSPSW0CUAI1poXFQRpAH4O3lYbjxhhcSxOVe2zY+gB3a4l
 y/aJvaW0Czhv1eFwqJAoEMumU2hw/36d8NEIYUr6x4sCJvyP6rE6Mjbqx
 L44s+T7GUVgsleagVbI24BVTZnOHoP+JczYRnRcVVTYpkP15YDDbqV+JI A==;
X-CSE-ConnectionGUID: qTISb6+RRoqOLWsw0fLyAQ==
X-CSE-MsgGUID: +6INQe5sQlOBp4uVm5cpOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72480078"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="72480078"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 05:07:10 -0700
X-CSE-ConnectionGUID: 5Wg7EdmLRzWrFuhKIutPeQ==
X-CSE-MsgGUID: bDKADs3OQp292iJhz0ZTFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="158481891"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 05:07:09 -0700
Message-ID: <74757211-2319-43b7-99fa-580803b88c42@intel.com>
Date: Thu, 17 Jul 2025 20:07:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250717103448.331037-1-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250717103448.331037-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 7/17/2025 6:34 PM, Paolo Bonzini wrote:
> KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
> cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
> MSR and it makes no sense to emulate it on AMD.
> 
> As a consequence, VMs created on AMD with qemu -cpu host and using
> KVM will advertise the ARCH_CAPABILITIES feature and provide the
> IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
> as the guest OS might not expect this MSR to exist on such cpus (the
> AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
> are not defined on the AMD architecture).
> 
> A fix was proposed in KVM code, however KVM maintainers don't want to
> change this behavior that exists for 6+ years and suggest changes to be
> done in QEMU instead.  Therefore, hide the bit from "-cpu host":
> migration of -cpu host guests is only possible between identical host
> kernel and QEMU versions, therefore this is not a problematic breakage.
> 
> If a future AMD machine does include the MSR, that would re-expose the
> Windows guest bug; but it would not be KVM/QEMU's problem at that
> point, as we'd be following a genuine physical CPU impl.
> 
> Reported-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

This looks reasonable to me.

Though it will break the usecase of people boot VM with "-cpu 
AMD-model,+arch_capabilities", like in [1], I think it's OK break it and 
force people to not do such thing any more.

[1] https://gitlab.com/qemu-project/qemu/-/issues/3001

> ---
>   target/i386/kvm/kvm.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index e8c8be09bae..369626f8c8d 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -503,8 +503,12 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>            * Linux v4.17-v4.20 incorrectly return ARCH_CAPABILITIES on SVM hosts.
>            * We can detect the bug by checking if MSR_IA32_ARCH_CAPABILITIES is
>            * returned by KVM_GET_MSR_INDEX_LIST.
> +         *
> +         * But also, because Windows does not like ARCH_CAPABILITIES on AMD
> +         * mcahines at all, do not show the fake ARCH_CAPABILITIES MSR that
> +         * KVM sets up.
>            */
> -        if (!has_msr_arch_capabs) {
> +        if (!has_msr_arch_capabs || !(edx & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
>               ret &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
>           }
>       } else if (function == 7 && index == 1 && reg == R_EAX) {


