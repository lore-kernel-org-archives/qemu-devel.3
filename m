Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A49E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSwd-0000eP-R4; Thu, 19 Dec 2024 21:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOSwa-0000e7-1m
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 21:40:48 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOSwW-0007WB-RV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 21:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734662445; x=1766198445;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/pqf9h2qJXBBN2f+fR9Wh3ziCzf/Pma6YvbUywRpP9M=;
 b=N8flS3RnKKbhWyPjC+DFC1GQqb3GAB3LJVwsqTehhJCUf4ZfEp20l8X1
 oxD0A/0qnLaHRk0ND0/8ClbBQn8KK9+KvWnLM7ZhiZjuj7pGeZdYMe8vw
 iS6ls8pyXo4PHwzHp6iYJj+R4WOP4moPVHL6pMgOg2GzirB6KxgJfPMjw
 E+4lS8eWcFVfZiZV7ibrZridOBZYnYtB04FAHVRywvp2YBzhsiFCz6HAt
 SuOrRnsek+oGN4Is6L2WOBNkhACnXhqfvnRzyh1zYTHAII5FM3YUScLVk
 YuOcdwXZX1mcnbelczZSmpq/iEH3wCHoYnW3ajTVhbwzu0kcxiYJSXBbD Q==;
X-CSE-ConnectionGUID: NLHXSmxtR1ykN6gQ/tl8Sg==
X-CSE-MsgGUID: 0d7bM6pLT5WtNfDmqzuYeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35098343"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; d="scan'208";a="35098343"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 18:40:41 -0800
X-CSE-ConnectionGUID: 8L2xDTDdSsyhhJAYJya+Xg==
X-CSE-MsgGUID: zxpLWte8Q6uoBYmWUJjs6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="121660659"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 18:40:38 -0800
Message-ID: <88c87ff8-bae0-4522-bb65-109b959a7e52@intel.com>
Date: Fri, 20 Dec 2024 10:40:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (Proposal) New TDX Global Metadata To Report FIXED0 and FIXED1
 CPUID Bits
To: Sean Christopherson <seanjc@google.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kai Huang <kai.huang@intel.com>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Yan Y Zhao <yan.y.zhao@intel.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <43b26df1-4c27-41ff-a482-e258f872cc31@intel.com>
 <d63e1f3f0ad8ead9d221cff5b1746dc7a7fa065c.camel@intel.com>
 <e7ca010e-fe97-46d0-aaae-316eef0cc2fd@intel.com>
 <269199260a42ff716f588fbac9c5c2c2038339c4.camel@intel.com>
 <Z2DZpJz5K9W92NAE@google.com>
 <3ef942fa615dae07822e8ffce75991947f62f933.camel@intel.com>
 <Z2INi480K96q2m5S@google.com>
 <f58c24757f8fd810e5d167c8b6da41870dace6b1.camel@intel.com>
 <Z2OEQdxgLX0GM70n@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z2OEQdxgLX0GM70n@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/19/2024 10:33 AM, Sean Christopherson wrote:
>>> For all other CPUID bits, what the TDX Module thinks and/or presents to the guest
>>> is completely irrelevant, at least as far as KVM cares, and to some extent as far
>>> as QEMU cares.  This includes the TDX Module's FEATURE_PARAVIRT_CTRL, which frankly
>>> is asinine and should be ignored.  IMO, the TDX Module spec is entirely off the
>>> mark in its assessment of paravirtualization.  Injecting a #VE instead of a #GP
>>> isn't "paravirtualization".
>>>   
>>> Take TSC_DEADLINE as an example.  "Disabling" the feature from the guest's side
>>> simply means that WRMSR #GPs instead of #VEs.*Nothing* has changed from KVM's
>>> perspective.  If the guest makes a TDVMCALL to write IA32_TSC_DEADLINE, KVM has
>>> no idea if the guest has opted in/out of #VE vs #GP.  And IMO, a sane guest will
>>> never take a #VE or #GP if it wants to use TSC_DEADLINE; the kernel should instead
>>> make a direct TDVMCALL and save itself a pointless exception.
>>>
>>>    Enabling Guest TDs are not allowed to access the IA32_TSC_DEADLINE MSR directly.
>>>    Virtualization of IA32_TSC_DEADLINE depends on the virtual value of
>>>    CPUID(1).ECX[24] bit (TSC Deadline). The host VMM may configure (as an input to
>>>    TDH.MNG.INIT) virtual CPUID(1).ECX[24] to be a constant 0 or allow it to be 1
>>>    if the CPU’s native value is 1.
>>>
>>>    If the TDX module supports #VE reduction, as enumerated by TDX_FEATURES0.VE_REDUCTION
>>>    (bit 30), and the guest TD has set TD_CTLS.REDUCE_VE to 1, it may control the
>>>    value of virtual CPUID(1).ECX[24] by writing TDCS.FEATURE_PARAVIRT_CTRL.TSC_DEADLINE.
>>>
>>>    • If the virtual value of CPUID(1).ECX[24] is 0, IA32_TSC_DEADLINE is virtualized
>>>      as non-existent. WRMSR or RDMSR attempts result in a #GP(0).
>>>
>>>    • If the virtual value of CPUID(1).ECX[24] is 1, WRMSR or RDMSR attempts result
>>>      in a #VE(CONFIG_PARAVIRT). This enables the TD’s #VE handler.
>>>
>>> Ditto for TME, MKTME.
>>>
>>> FEATURE_PARAVIRT_CTRL.MCA is even weirder, but I still don't see any reason for
>>> KVM or QEMU to care if it's fixed or configurable.  There's some crazy logic for
>>> whether or not CR4.MCE can be cleared, but the host can't see guest CR4, and so
>>> once again, the TDX Module's view of MCA is irrelevant when it comes to handling
>>> TDVMCALL for the machine check MSRs.
>>>
>>> So I think this again purely comes to back to KVM correctness and safety.  More
>>> specifically, the TDX Module needs to report features that are unconditionally
>>> enabled or disabled and can't be emulated by KVM.  For everything else, I don't
>>> see any reason to care what the TDX module does.
>>>
>>> I'm pretty sure that gives us a way forward.  If there only a handful of features
>>> that are unconditionally exposed to the guest, then KVM forces those features in
>>> cpu_caps[*].
>> I see. Hmm. We could use this new interface to double check the fixed bits. It
>> seems like a relatively cheap sanity check.
>>
>> There already is an interface to get CPUID bits (fixed and dynamic). But it only
>> works after a TD is configured. So if we want to do extra verification or
>> adjustments, we could use it before entering the TD. Basically, if we delay this
>> logic we don't need to wait for the fixed bit interface.
> Oh, yeah, that'd work.  Grab the guest CPUID and then verify that bits KVM needs
> to be 0 (or 1) are set according, and WARN+kill if there's a mismatch.
> 
> Honestly, I'd probably prefer that over using the fixed bit interface, as my gut
> says it's less likely for the TDX Module to misreport what CPUID it has created
> for the guest, than it is for the TDX module to generate a "fixed bits" list that
> doesn't match the code.  E.g. KVM has (had?) more than a few CPUID features that
> KVM emulates without actually reporting support to userspace.

The original motivation of the proposed fxied0 and fixed1 data is to 
complement the CPUID configurability report, which is important for 
userspace. E.g., Currently, what QEMU is doing is hardcoding the fixed0 
and fixed1 information of a specific TDX release to adjust the 
KVM_GET_SUPPORTED_CPUID result and gets a final "supported" CPUID set 
for TDX. Hardcoding is not a good idea and it's better that KVM can get 
the data from TDX module, then pass to userspace (of course KVM can 
tweak the data based on its own requirement). So, do you think it's 
useful to have TDX module report the fixed0/fixed1 data for this purpose?

