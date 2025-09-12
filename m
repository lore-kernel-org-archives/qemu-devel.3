Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0958CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 05:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwwh5-0006ZT-1s; Fri, 12 Sep 2025 01:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwh2-0006WT-Ib
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:51:32 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwh0-0002bP-7T
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757656290; x=1789192290;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rEuVL1LbvxYOmb2mrqovPrb2OyKKTKcYdq1jQs3cW+0=;
 b=WgyL0PuzD2WdXnxGjypFglo5WmJCPmO3zY3lGg8uW6WRshNuudJ8JurA
 SSb/Eqxn0INulZnic7Dii4+4EouSx83kI+Jxm+tod4ZfR17J6CC1TBOmG
 kgJJmNVa//mDssNnZ16t16057tJrJW4gZw9guzwO8TYaNWluzNhutkw3T
 CRoyfHNtENikBAvCjXdfBTjNhoJ7ekABXljaZSOmXnRk/M6nScM2zWa16
 +JK3Epp9uxeuYPXNn4bMi6Cpz+zf9UB7OFNR22AtCEEOVXcNsOBAdpKwb
 CKvl1DJ/EbjRyS0q52VDDB+VWgSIs20QwqCa1GUAdn81hrESoJA00ecDA g==;
X-CSE-ConnectionGUID: RzjZhDpiQSCQrvdzD5LJUA==
X-CSE-MsgGUID: XcPWoOlVQhqjMborE3DGTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="63821159"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="63821159"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:51:21 -0700
X-CSE-ConnectionGUID: uOva7nDRR2qgi+r6SgYeig==
X-CSE-MsgGUID: bvEtj96lQXqQ6ekLQ5ofDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="173955292"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:51:19 -0700
Message-ID: <ff8e061d-96ed-4bbe-929b-a7149e801485@intel.com>
Date: Fri, 12 Sep 2025 13:51:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] i386/kvm: Enable SMM address space for i386 cpu
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250730095253.1833411-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250730095253.1833411-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
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

On 7/30/2025 5:52 PM, Xiaoyao Li wrote:
> Patch 1 enables the SMM address space i386 cpu under KVM.
> 
> Patch 2 gives name for each address space index.

Gentle ping.

> ---
> changes in v2:
> - collect Reviewed-by and Tested-by;
> - fix typos and refine changelog;
> 
> Xiaoyao Li (2):
>    i386/cpu: Enable SMM cpu address space under KVM
>    target/i386: Define enum X86ASIdx for x86's address spaces
> 
>   accel/kvm/kvm-all.c              |  2 +-
>   system/physmem.c                 |  5 -----
>   target/i386/cpu.h                |  5 +++++
>   target/i386/kvm/kvm-cpu.c        | 10 ++++++++++
>   target/i386/kvm/kvm.c            |  7 ++++++-
>   target/i386/tcg/system/tcg-cpu.c |  4 ++--
>   6 files changed, 24 insertions(+), 9 deletions(-)
> 


