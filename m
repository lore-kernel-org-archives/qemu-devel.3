Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E50CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 05:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwwdx-0004Us-O4; Fri, 12 Sep 2025 01:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwdv-0004UY-Uo
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:48:20 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwdu-00024S-EK
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757656099; x=1789192099;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=l/fz8e3A1LT1Ojjrl4SrFgeMpCn7Tn0ueX7nGpZ2TCg=;
 b=ITNclFImgfjpnUbuBsIo/DYY6LptYN1BX8PWrX5YtQHddCB9KANADycp
 fCul4rzd0PY3ayBsEBXInAc+X+Dj50Oef2zEMBg8Fzm/Hw5WJfg7PZB53
 e+Qk93N6T7WdYDZtvkNiV+ntFWXv1bsKwqolGM2pC4AvUrkZ5kYj5lDI7
 VsHWVr1DYO412zn6L0LkHhHxKM4hcsq0GPCU4z2d5WkENW1RhxYYO86cl
 aQGOftFvuTn2IRS5LZG4cWqXGsaYrNAKcgS/nzTp/dTMfVpS76Km6bqoz
 RaH9gJuzUIuzAC3UbZggTuUkm0vqoq4ULR99CuTF/awvscV3ajUOPgYuy w==;
X-CSE-ConnectionGUID: /YledEX+SdqwWCfeLgvPRA==
X-CSE-MsgGUID: 0mMdByLsRMKS0aO7XIetvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59855081"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="59855081"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:48:17 -0700
X-CSE-ConnectionGUID: aoUKmbQpTmqm9uM8ISdeCQ==
X-CSE-MsgGUID: zylQbzJOSYyS6anfYcGCLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="173447157"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:48:15 -0700
Message-ID: <6d17efbc-fec8-45da-967a-449f63f64482@intel.com>
Date: Fri, 12 Sep 2025 13:48:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] i386/kvm: Cleanups in kvm_arch_init()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org
References: <20250729062014.1669578-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250729062014.1669578-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/29/2025 2:20 PM, Xiaoyao Li wrote:
> Patch 1 removes the object_dynamic_cast() check in kvm_arch_init();
> 
> Patch 2 removes the unncessary kvm_check_extension(s, KVM_CAP_X86_SMM);

Gentle ping.

> Xiaoyao Li (2):
>    i386/kvm: Get X86MachineState in kvm_arch_init() without the cast
>      check
>    i386/kvm: Drop KVM_CAP_X86_SMM check in kvm_arch_init()
> 
>   target/i386/kvm/kvm.c | 23 +++++++++--------------
>   1 file changed, 9 insertions(+), 14 deletions(-)
> 


