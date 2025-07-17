Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE8BC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLa8-0005fX-DP; Thu, 17 Jul 2025 06:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucLZy-0005Oc-3e
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:11:07 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucLZu-0006Xa-0W
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752747062; x=1784283062;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=4bez18kSk7CdJxRNEvzNlJaiYl78CBIZSkF8w1azpts=;
 b=LIkDJ5FKER8FB/F3lVQalHX+e9L+09/nA8crxeraBt7dRcMaFsVDk0GM
 iZZ7xiE/CuKjQbNQpsOWBwvWgQ6C4Fhl9A4nT+YrUcc9plYEHVdDHFy8L
 o4QSA89a7zikmq1w5bRuZEj/EXDm10cvuOVhkEpLIkrMPYZc8+YLgXsN7
 vxKkUqOuDMJVWxk4rFv4ns+GQ+ESc0R3/aTsWifUAG401fhumukVNfEGU
 Ec8F8Ep7Ap4ZqGPM/GzKwPYMyEF5aW+LLYunS5JMT2mw+ejt1iyKwuyRK
 Lia6FMdNhEDkBe5qqp1Ct1Z268xhHflULpuW3Id0xvZrT08JFMSlTnKWD A==;
X-CSE-ConnectionGUID: t4YM3xFLT4+PFAdk2dEruw==
X-CSE-MsgGUID: eRiErQ4kTkKZqimEdbE4KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80464389"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="80464389"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 03:10:58 -0700
X-CSE-ConnectionGUID: yCe6OiU2QEeBPxzFm6brQA==
X-CSE-MsgGUID: L+I9F28XQ72WXIThS376og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="163285783"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 03:10:56 -0700
Message-ID: <f2d9554b-a86b-427b-b1d3-cf0806212617@intel.com>
Date: Thu, 17 Jul 2025 18:10:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/77] i386/tdx: Initialize TDX before creating TD vcpus
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-21-pbonzini@redhat.com>
 <CAFEAcA8XdxQbvSJmo9BZOcxojTNgaFvCdO4xDuUi0eXcj13uAw@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAFEAcA8XdxQbvSJmo9BZOcxojTNgaFvCdO4xDuUi0eXcj13uAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
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

On 7/17/2025 5:40 PM, Peter Maydell wrote:
> On Fri, 30 May 2025 at 08:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> Invoke KVM_TDX_INIT_VM in kvm_arch_pre_create_vcpu() that
>> KVM_TDX_INIT_VM configures global TD configurations, e.g. the canonical
>> CPUID config, and must be executed prior to creating vCPUs.
>>
>> Use kvm_x86_arch_cpuid() to setup the CPUID settings for TDX VM.
>>
>> Note, this doesn't address the fact that QEMU may change the CPUID
>> configuration when creating vCPUs, i.e. punts on refactoring QEMU to
>> provide a stable CPUID config prior to kvm_arch_init().
> 
> Hi; I noticed something odd about this change when I was
> investigating a false-positive Coverity issue:
> 
>> @@ -162,6 +265,8 @@ static void tdx_guest_init(Object *obj)
>>       ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
>>       TdxGuest *tdx = TDX_GUEST(obj);
>>
>> +    qemu_mutex_init(&tdx->lock);
>> +
> 
> This adds a qemu_mutex_init() call, but we were already
> doing that later on in this function, so now we init the mutex twice.

It is 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>") that 
introduced the second qemu_mutext_init() by mistake.

I'll send an patch to fix it.

Thanks for catching and reporting it!


