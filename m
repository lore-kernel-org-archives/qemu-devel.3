Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1252EC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 15:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcgI-0003PS-6n; Tue, 01 Jul 2025 11:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWcgG-0003PC-9O; Tue, 01 Jul 2025 11:13:56 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWcg7-00012S-3y; Tue, 01 Jul 2025 11:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751382827; x=1782918827;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hcGGy5cmnJsNTiMK7Lwef975+eC1/j95aZrplOwmAxs=;
 b=WBmGe1boQKrDGauH4tLgwVj/sodCs/MZVAAvCZBce7kZXq9PMZyC69il
 ZpADFT38KQV/DZDeJKO1yeUrhxI3fupW/mMGfHk/ELw9+8YVaprslSVKR
 38gnqzblpyWqKnTXGfvu4Bp4vSJiKidxePp20BzAZUtM8VYXSqtEIvhaa
 hMkFv9CS4S+07NrzFXicJ+1uFQ/zEdxO62pTUs6rMkFh8a/dBPik/9xiH
 GPEMgfHA8buI4ssiliIYe4sYc7S66hY9tA+pTO+7jz7gbRqDWVQa2EeTW
 UsP01EnfTq/9tPo1hr6qfRv4ncmnmvgjAzYEnv4OB2J6aiLXTMATVc9LK Q==;
X-CSE-ConnectionGUID: oqTyTxGmRo+d0H0R09UpJA==
X-CSE-MsgGUID: Ui3W+6owRH2M2P+C2rMdbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71217148"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="71217148"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 08:13:41 -0700
X-CSE-ConnectionGUID: rABrkWjbQQyBLlPZQxR9ag==
X-CSE-MsgGUID: IKozC8+QS/iUjy+Ta7CQqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="159514178"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 08:13:38 -0700
Message-ID: <e19644ed-3e32-42f7-8d46-70f744ffe33b@intel.com>
Date: Tue, 1 Jul 2025 23:13:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
To: Alexandre Chartre <alexandre.chartre@oracle.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
 maciej.szmigiero@oracle.com, Sean Christopherson <seanjc@google.com>,
 kvm@vger.kernel.org
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com> <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
 <1ecfac9a-29c0-4612-b4d2-fd6f0e70de9d@oracle.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <1ecfac9a-29c0-4612-b4d2-fd6f0e70de9d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
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

On 7/1/2025 8:12 PM, Alexandre Chartre wrote:
> 
> On 7/1/25 13:12, Xiaoyao Li wrote:
>> On 7/1/2025 6:26 PM, Zhao Liu wrote:
>>>> unless it was explicitly requested by the user.
>>> But this could still break Windows, just like issue #3001, which enables
>>> arch-capabilities for EPYC-Genoa. This fact shows that even explicitly
>>> turning on arch-capabilities in AMD Guest and utilizing KVM's emulated
>>> value would even break something.
>>>
>>> So even for named CPUs, arch-capabilities=on doesn't reflect the fact
>>> that it is purely emulated, and is (maybe?) harmful.
>>
>> It is because Windows adds wrong code. So it breaks itself and it's 
>> just the regression of Windows.
>>
>> KVM and QEMU are not supposed to be blamed.
> 
> I can understand the Windows code logic, and I don't think it is 
> necessarily wrong,
> because it finds that the system has:
> 
> - an AMD cpu
> - an Intel-only feature/MSR
> 
> Then what should the code do? Trust the cpu type (AMD) or trust the MSR 
> (Intel).
> They decided not to choose, and for safety they stop because they have 
> an unexpected
> configuration.

It's not how software/OS is supposed to work with x86 architecture.

Though there are different vendors for x86, like Intel and AMD, they 
both implement x86 architecture. For x86 architecture, architectural 
features are enumerated by CPUID. If you read Intel SDM and AMD APM, you 
will find that Intel defines most features at range [0, x] while AMD 
defines most features at range [0x8000 000, 0x8000 000y]. But if a bit 
is defined by both Intel and AMD, it must have same meaning and 
enumerate the same feature.

Usually, a feature is first introduced by one vendor, then other vendors 
might implement the same one later. E.g., bus lock detection, which is 
enumerated via CPUID.7_0:ECX[bit 24] and first introduced by Intel in 
2020. Later, AMD implemented the same one from Zen 5. Before AMD 
implemented it, it was an Intel-only feature. Can we make code as below

    if (is_AMD && cpuid_enumerates_bus_lock_detect)
	error(unsupported CPU);

at that time? If we wrote such code, then it will fail on all the AMD 
Zen 5 CPUs.

Besides, I would like to talk about how software is supposed to deal 
with reserved bits on x86 architecture. In general, software should not 
set any expectation on the reserved bit. The value cannot be relied upon 
to be 0 since any reserved bit can have a meaning in the future. As Igor 
said:

   software shouldn't even try to use it or make any decisions
   based on that

For more information, you can refer to Intel SDM vol1. chapter 1.3.2 
Reserved Bits and Software compatibility. For AMD APM, you would need 
search yourself.

OK, back to the original question "what should the code do?"

My answer is, it can behave with any of below option:

- Be vendor agnostic and stick to x86 architecture. If CPUID enumerates 
a feature, then the feature is available architecturally.

- Based on AMD spec. Ignore the bit since it's a reserved bit. (Expect a 
reserved bit to be zero if not explicitly state by spec is totally wrong!)

> alex.
> 


