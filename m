Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDF4CCF9EB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 02:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEIH2-0006Ra-Ms; Wed, 29 Oct 2025 22:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vEIH0-0006RF-LU
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 22:20:22 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vEIGo-0007B9-NF
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 22:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761790811; x=1793326811;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=viO1/E0SUULLfzjrQtI5K+c6ySbAiDEQEcdX2H3Z6/w=;
 b=T7iqlotqjs1++M5jJDCNSJOYfYfcdtS+Bj6trE1FdUyI+j1/bBjCBL7y
 eYFV+Hmb7xV9fe5VnpI30FiMNYB4v5n6iHtqRKgF+xgwc34AD6Pb87YDD
 Xa8VhFvSwjCzOsLVbDsUS+KZE7891QYPVBY6BRbmDPDCTfyP32PEyRl2N
 8/u4B7XaHVu+3QJntEtEQGfdrc0DW6sIi6ehhJWJ9TE0hVqBR+gdonL5/
 hOFfMi32Unf55talhR/XquLbrPldABTzsMYshFus8KzosSz4lTc7Tvbth
 QbbK/DDezBfB7dECKlTyDICO/zzwhB4fLvEhK4btzFqq2ghB4/YQQy/Sd g==;
X-CSE-ConnectionGUID: lPs3mdOtTAOa6N1KpzKCDQ==
X-CSE-MsgGUID: epVjfvulSgGde8YbuXscUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75045132"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="75045132"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 19:19:57 -0700
X-CSE-ConnectionGUID: x8Pts7mHTuiNEV7atB/wyA==
X-CSE-MsgGUID: KaMbK95vRWKQFmlX4R/MKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="190995310"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 19:19:55 -0700
Message-ID: <5a50deb8-c499-43b0-8456-ea784bc7f1fb@intel.com>
Date: Thu, 30 Oct 2025 10:19:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/18] i386/kvm/cpu: Init SMM cpu address space for
 hotplugged CPUs
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-3-pbonzini@redhat.com> <aQG7wdY/lBjgzho3@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aQG7wdY/lBjgzho3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.576, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/29/2025 3:01 PM, Zhao Liu wrote:
>> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
>> index 7512be64d67..5716191fff1 100644
>> --- a/hw/i386/x86-common.c
>> +++ b/hw/i386/x86-common.c
>> @@ -183,6 +183,17 @@ void x86_cpu_plug(HotplugHandler *hotplug_dev,
>>           fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
>>       }
>>   
>> +    /*
>> +     * Non-hotplugged CPUs get their SMM cpu address space initialized in
>> +     * machine init done notifier: register_smram_listener().
>> +     *
>> +     * We need initialize the SMM cpu address space for the hotplugged CPU
>> +     * specifically.
>> +     */
>> +    if (kvm_enabled() && dev->hotplugged && x86_machine_is_smm_enabled(x86ms)) {
>> +        kvm_smm_cpu_address_space_init(cpu);
>> +    }
>> +
> 
> Unfortunately, the original KVM SMM patch caused this bug, but even
> more unfortunately, CPU_FOREACH in the machine_done callback is more
> fragile than I originally anticipated, now requiring more hack checks to
> fix. :-(
> 
> IMO, the root of the chaos is that KVM SMM doesn't do this in the CPU
> context like TCG did for a long time. I'll find time to sort all this
> out.

I had this idea before. It needs to move the initialization of KVM SMM 
MemoryRegion a bit earlier at least. And it seems to require more time 
than I expected, especially the effort to test the SMM functionality 
after the change. So I went with the most straightforward fix.

It will be great if you can find time to clean it up. Looking forward to it.

> Regards,
> Zhao
> 


