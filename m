Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315D1E77171
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 02:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOIh-00032X-71; Thu, 05 Dec 2024 21:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJOIW-00031z-Ul
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 21:42:29 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJOIT-00031e-O3
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 21:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733452946; x=1764988946;
 h=message-id:date:mime-version:to:cc:from:subject:
 content-transfer-encoding;
 bh=BPAbfXQQYNvBKr+0fe03hKAUFPt0n+OzNTK11uRxPac=;
 b=k2VaqdSseRlsczURhL55zs7wDMVdFQO6zv6ACaUJnhNsqOpwrcT8Pi0h
 4bJRL9E6nQrCzBM5KABJzlTaf0vBu3ilH/u2hIBfbMksH9eoDySMlddBH
 ZC/Wg9NHBPtp3DWvdWGtiBLEqVquMifc5H3ZKcz2rh/uOonHN2Nw+wuV9
 TazjJP6hLJKFAXIjqdhrh8eZerBaXpSulEbqA6zWjHy5jK2Jmx68t4xZ7
 OZM8V/NWiGOtnQfQRTb8ybXAtoJ2JiXh37hoNfgwdzvWauSyog+VW0Eyv
 fVZoKkdk/U582NyJ22bTQWGVkhr8TMprjqocCx0ndRl4LxCtPz5qMIyrd g==;
X-CSE-ConnectionGUID: xWUhw9ywRNWsWZiDnMmKyg==
X-CSE-MsgGUID: I1af45qhQO+xajfvjGcTYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="36630569"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; d="scan'208";a="36630569"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 18:42:22 -0800
X-CSE-ConnectionGUID: sEnyYx90RsOGSQcQ3/QttA==
X-CSE-MsgGUID: KAie4NgqS9ObFneeGnR/sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; d="scan'208";a="99347225"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 18:42:18 -0800
Message-ID: <43b26df1-4c27-41ff-a482-e258f872cc31@intel.com>
Date: Fri, 6 Dec 2024 10:42:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Huang, Kai" <kai.huang@intel.com>,
 Tony Lindgren <tony.lindgren@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>, QEMU <qemu-devel@nongnu.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: (Proposal) New TDX Global Metadata To Report FIXED0 and FIXED1 CPUID
 Bits
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.822, RCVD_IN_DNSWL_MED=-2.3,
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

This is a proposal for a potential future TDX Module feature to assist 
QEMU/KVM in configuring CPUID leafs for TD guests. It is only in the 
idea stage and not currently being implemented. We are looking for 
comments on the suitability for QEMU/KVM.

# Background

To correctly virtualize CPUID for TD, the VMM needs to understand the 
behavior of CPUID configuration for each CPUID bit, including whether 
the bit can be configured by the VMM and what the allowed value is.

There is an interface to query the CPUID bit information after the TD 
has been configured. However, this interface does not work before the TD 
is configured. The TDX module, along with its release, provides a 
separate JSON format file, cpuid_virtualization.json, for CPUID 
virtualization information. This file can be used by the VMM even before 
the TD is configured. The TDX module also provides an interface to query 
some limited CPUID information, including:

  - The configurability of a subset of CPUIDs via global metadata 
CPUID_CONFIG_VALUES.

  - The 'fixed0' and 'fixed1' bits of ATTRIBUTES and XFAM via global 
metadata. The VMM can infer the 'configurable' bits related to 
ATTRIBUTES/XFAM indirectly (the bits that are neither 'fixed0' nor 
'fixed1' are 'configurable').

For the remaining CPUID bits not covered by the above two categories, no 
TDX module query interface exists.

# Problem

While the VMM can use the JSON format CPUID information and may embed or 
translate that information into the code, it may face several challenges:

  - The JSON file varies with each TDX module release, which can 
complicate the VMM code. Additionally, depending on its own needs, the 
VMM may require more information than what is provided in the JSON file.

  - The JSON format cannot be easily parsed with low-level programming 
languages like C, which is typically used to write VMMs.

There was objection from KVM community for parsing the JSON and requests 
for a more friendly interface to query CPUID information for each 
specific TDX module.[0][1]

# Analysis

There are many virtualization types defined for single bit or bitfields 
in JSON file, e.g., 12 types in TDX 1.5.06:

   - fixed
   - configured
   - configured & native
   - XFAM & native
   - XFAM & configured & native
   - attributes & native
   - attributes & configured & native
   - CPUID_enabled & native
   - attributes & CPUID_enabled & native
   - attributes & CPUID_enabled & configured & native
   - calculated
   - special

And more types are getting added as TDX evolves.

Though so many types defined, for a single bit, it can only be one of three:
   - fixed0
   - fixed1
   - configurable

For example:
1. For type "configured & native", the bit is “fixed0” bit if the native 
value is 0, and the “configurable” bit if native value is 1.

2. For type "XFAM & native",
    a) the CPUID is “fixed0” if the corresponding XFAM bit is reported 
in XFAM_FIXED0, or the native value is 0;

    b) the CPUID bit is ‘fixed1’ if the corresponding XFAM bit is set in 
XFAM_FIXED1;

    c) otherwise, the CPUID is ‘configurable’ (indirectly by TD_PRRAMS.XFAM)

# Proposal

Current TDX module provides interface to report the “configurable” bits 
via global metadata CPUID_CONFIG_VALUES directly or via global metadata 
ATTRIBUTES/XFAM_fixed0/1 indirectly. But it lacks the interface to 
report the “fixed0” and “fixed1” bits generally (it only reports the 
fixed bits for ATTRIBUTES and XFAM).

We propose to add two new global metadata fields, CPUID_FIXED0_BITS and 
CPUID_FIXED1_BITS, for “fixed0” and “fixed1” bits information respectively.

The encoding of the two fields uses the same format as TDCS field 
CPUID_VALUES:

   Field code is composed as follows:
     - Bits 31:17  Reserved, must be 0
     - Bit  16     Leaf number bit 31
     - Bits 15:9   Leaf number bit 6:0
     - Bit 8       Sub-leaf not applicable flag
     - Bits 7:1    Sub-leaf number bits 6:0
     - Bit 0       Element index within field

   The same for returned result:
     - Element 0[31:0]:   EAX
     - Element 0[63:32]:  EBX
     - Element 1[31:0]:   ECX
     - Element 1[63:32]:  EDX

For CPUID_FIXED0_BITS, any bit in E[A,B,C,D]X is 0, means the bit is fixed0.
For CPUID_FIXED1_BITS, any bit in E[A,B,C,D]X is 1, means the bit is fixed1.

# Interaction with TDX_FEATURES0.VE_REDUCTION

TDX introduces a new feature VE_REDUCTION[2]. From the perspective of 
host VMM, VE_REDUCTION turns several CPUID bits from fixed1 to 
configurable, e.g., MTRR, MCA, MCE, etc. However, from the perspective 
of TD guest, it’s an opt-in feature. The actual value seen by TD guest 
depends on multiple factors: 1). If TD guest enables REDUCE_VE in 
TDCS.TD_CTLS, 2) TDCS.FEATURE_PARAVIRT_CTRL, 3) CPUID value configured 
by host VMM via TD_PARAMS.CPUID_CONFIG[]. (Please refer to latest TDX 
1.5 spec for more details.)

Since host VMM has no idea on the setting of 1) and 2) when creating the 
TD. We make the design to treat them as configurable bits and the global 
metadata interface doesn’t report them as fixed1 bits for simplicity.

Host VMM must be aware itself that the value of these VE_REDUCTION 
related CPUID bits might not be what it configures. The actual value 
seen by TD guest also depends on the guest enabling and configuration of 
VE_REDUCTION.

# POC

We did a POC in QEMU to verify the fixed0/1 data by such an interface is 
enough for userspace to validate and generate a supported vcpu model for 
TD guest.[3]

It retrieves the “fixed” type in JSON file and hardcodes them into two 
arrays, tdx_fixed0_bits and tdx_fixed1_bits. Note, it doesn’t handle the 
other types than “fixed” because 1) just a few of them falls into fixed0 
or fixed1 and 2) turning them into fixed0 or fixed0 needs to check 
various condition which complicates the POC. And in the POC it uses 
value 1 in tdx_fixed0_bits for fixed0 bits, while the proposed metadata 
interface uses value 0 to indicate fixed0 bits.

With the hardcoded information, VMM can validate the TD configuration 
requested from user early by checking whether a feature requested from 
users is allowed to be enabled and is allowed to be disabled.

When TDX module provides fixed0 and fixed1 via global metadata, QEMU can 
change to requested them from KVM to replace the hardcoded one.

[0] https://lore.kernel.org/all/ZhVdh4afvTPq5ssx@google.com/
[1] https://lore.kernel.org/all/ZhVsHVqaff7AKagu@google.com/
[2] https://cdrdv2.intel.com/v1/dl/getContent/733575
[3] 
https://lore.kernel.org/qemu-devel/20241105062408.3533704-49-xiaoyao.li@intel.com/ 






