Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9660AC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 16:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0Gf-0007oh-BM; Wed, 02 Jul 2025 12:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX0Ge-0007o7-2Q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:25:04 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX0Gb-0004qw-Co
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751473502; x=1783009502;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=nr5byySlXrN0IqchmO+iAIhBsh23cH/NfipECD75P2E=;
 b=Ev+tejzI1Vam70z+oz6aiKr9LfqM3luJDq058vC0L7tssdAfTz+oV4UM
 8apbcsYW6vNsuIaqPP/u6NQtSyaCmLMtf3pDqvG4B5H48Ao/OpbzCIJhj
 WYfnkchDz8ZL6ZD1AF5wpwilOBZvoBUEjxJffAEKaagO+GPJ+bycdatA8
 4/GliZFVH/rQ1cz0ZW5nmpquvVtsgmBTR94eEEWBRHqlp4lXebZAaDN2k
 MehPdJlocgD9lawlJDhZHrp3D6U559nQIuJSe8CAs6ckXQvkWnHZsRVGM
 vHo+kxTVQaLCTL21qmrNArZiYuCmR0j32WGTL+eYy6ywn2Wfrt8cuEuSK Q==;
X-CSE-ConnectionGUID: lz6XjHFSRIG82WUB/QR8EQ==
X-CSE-MsgGUID: 28+1eaHZS4CKwqjR9rkgHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53505182"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="53505182"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 09:24:59 -0700
X-CSE-ConnectionGUID: OrSOw8msTIWWIQRGWjs9kw==
X-CSE-MsgGUID: S9JccJyURtiv9mK4yoFW0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="154477408"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 09:24:57 -0700
Message-ID: <1d12e519-9f3c-41a0-90ff-8e4655000d21@intel.com>
Date: Thu, 3 Jul 2025 00:24:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Kirill Martynov <stdcalllevi@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
 <3096f21e-d8dd-4434-afbd-ee2b56adb20f@intel.com>
 <6a18dfcc-1686-4e3e-8e0a-b96d7034f4ab@intel.com>
Content-Language: en-US
In-Reply-To: <6a18dfcc-1686-4e3e-8e0a-b96d7034f4ab@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/2/2025 11:10 PM, Xiaoyao Li wrote:
> On 7/2/2025 10:16 PM, Xiaoyao Li wrote:
>> On 5/23/2025 11:44 PM, Kirill Martynov wrote:
>>> Certain error conditions can trigger x86_cpu_dump_state() to output 
>>> CPU state
>>> debug information e.g. KVM emulation failure due to misbehaving guest.
>>> However, if the CPU is in System Management Mode (SMM) when the 
>>> assertion
>>> in cpu_asidx_from_attrs failure happens because:
>>>
>>> 1. In SMM mode (smm=1), the CPU must use multiple address spaces
>>>     with a dedicated SMM address space
>>> 2. On machine types with softmmu, address spaces are hardcoded to 1
>>>     (no multiple address spaces available)
>>>
>>> The assertion occurs in cpu_asidx_from_attrs() when trying to
>>> access memory in SMM mode with insufficient address spaces.
>>>
>>> Fix this by:
>>> 1. If number of address spaces is 1 always use index 0
>>> 2. In other cases use attr.secure for identified proper index
>>>
>>> This prevents the assertion while still providing useful debug
>>> output during VM shutdown errors.
>>
>> To me,  it's just a workaround to avoid the assertion.
>>
>> When attrs.secure is 1, it means it's in SMM mode. As you describe above,
>>
>>  > 1. In SMM mode (smm=1), the CPU must use multiple address spaces
>>  >     with a dedicated SMM address space
>>
>> So I think we need to first figure out why it gets attrs.secure as 1 
>> when there is only 1 address space.
> 
> Ah, with KVM, QEMU can only support 1 address space.

In fact, KVM does support different address space for supporting SMM 
mode. There is KVM_CAP_MULTI_ADDRESS_SPACE to report how many address 
space is supported by KVM.

(It turns out my memory on KVM is correct. I was misled by QEMU code and 
comment)

QEMU allocates separate KVM address space for SMM in 
register_smram_listener(). But the address space doesn't associated with 
cpu's address space.

I think this patch can only avoid the assertion in you case when vcpu is 
in SMM mode with KVM. But with this patch, do you get the correct info 
of SMM mode dumped? I guess no, since the info is of address space 0, 
not the SMM address space.

If there is no reason of cannot associate KVM's address space with cpu's 
address space, I think the right fix is to enable the association with 
them.


> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Based on above, I need to withdraw my Reviewed-by.


>>>   }
>>>   static inline AddressSpace *cpu_addressspace(CPUState *cs, 
>>> MemTxAttrs attrs)
>>
> 
> 


