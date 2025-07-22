Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F74FC87FC5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 11:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueApW-0007Nw-BF; Tue, 22 Jul 2025 07:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueApK-0007Fx-A4
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:06:31 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ueApI-0000yU-1V
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753182388; x=1784718388;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HQfLQ1tiPCYXo8hIhl+T+tSiwKBGU63pShOT4PDGA9w=;
 b=VOLmOUiQMgyK1sURKFeOqjQzBbUZvVwHdRCB8OQhOS54Z/GhFXikcDEh
 SM+hm+CYVqLKw13UhFecCyc2/kqvjFD1x+Gp/PMg/bRRmH+lNe2m5co1n
 Z7TgVcl36wv/epzAtkNJmKJ9Fo5g7LlcyGirZ9pgXX2X1vKSFAWeN7AT+
 1NWjXDp6ShzFZ318T4y+8GwKsqey0gPDpFGfbvwLrSGLmjg1G6whciMrq
 t33b066X3QtkLdpAebJChmbLDCBFxnwAdPp07/PkN/rTXU30vKtmuAtWx
 HcatcvZ1hGuB2iZ2fhWWr6PJ/p1YM1/DpEg1b9qRu6KUXotqH4XTiQIMQ Q==;
X-CSE-ConnectionGUID: 9VFiX6qbQjCUd+kg3D3jnw==
X-CSE-MsgGUID: 1w0DKsDISjaV0hOJNS+PcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72880729"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="72880729"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 04:06:23 -0700
X-CSE-ConnectionGUID: aje7LPObQR63Ghn7LmUd1w==
X-CSE-MsgGUID: HFREgLGIRmiHtgVz+CWsWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="158423256"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 04:06:21 -0700
Message-ID: <0a700950-45b8-4f38-afe2-a1a261110d78@intel.com>
Date: Tue, 22 Jul 2025 19:06:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Disable hypercall patching quirk by default
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Mathias Krause <minipli@grsecurity.net>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
References: <20250619194204.1089048-1-minipli@grsecurity.net>
 <41a5767e-42d7-4877-9bc8-aa8eca6dd3e3@intel.com>
 <b8336828-ce72-4567-82df-b91d3670e26c@grsecurity.net>
 <3f58125c-183f-49e0-813e-d4cb1be724e8@intel.com>
 <317D3308-0401-4A36-A6B0-D2575869748D@unpredictable.fr>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <317D3308-0401-4A36-A6B0-D2575869748D@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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

On 7/22/2025 6:35 PM, Mohamed Mediouni wrote:
>> On 22. Jul 2025, at 12:27, Xiaoyao Li<xiaoyao.li@intel.com> wrote:
>>
>> On 7/22/2025 5:21 PM, Mathias Krause wrote:
>>> On 22.07.25 05:45, Xiaoyao Li wrote:
>>>> On 6/20/2025 3:42 AM, Mathias Krause wrote:
>>>>> KVM has a weird behaviour when a guest executes VMCALL on an AMD system
>>>>> or VMMCALL on an Intel CPU. Both naturally generate an invalid opcode
>>>>> exception (#UD) as they are just the wrong instruction for the CPU
>>>>> given. But instead of forwarding the exception to the guest, KVM tries
>>>>> to patch the guest instruction to match the host's actual hypercall
>>>>> instruction. That is doomed to fail as read-only code is rather the
>>>>> standard these days. But, instead of letting go the patching attempt and
>>>>> falling back to #UD injection, KVM injects the page fault instead.
>>>>>
>>>>> That's wrong on multiple levels. Not only isn't that a valid exception
>>>>> to be generated by these instructions, confusing attempts to handle
>>>>> them. It also destroys guest state by doing so, namely the value of CR2.
>>>>>
>>>>> Sean attempted to fix that in KVM[1] but the patch was never applied.
>>>>>
>>>>> Later, Oliver added a quirk bit in [2] so the behaviour can, at least,
>>>>> conceptually be disabled. Paolo even called out to add this very
>>>>> functionality to disable the quirk in QEMU[3]. So lets just do it.
>>>>>
>>>>> A new property 'hypercall-patching=on|off' is added, for the very
>>>>> unlikely case that there are setups that really need the patching.
>>>>> However, these would be vulnerable to memory corruption attacks freely
>>>>> overwriting code as they please. So, my guess is, there are exactly 0
>>>>> systems out there requiring this quirk.
>>>> The default behavior is patching the hypercall for many years.
>>>>
>>>> If you desire to change the default behavior, please at least keep it
>>>> unchanged for old machine version. i.e., introduce compat_property,
>>>> which sets KVMState->hypercall_patching_enabled to true.
>>> Well, the thing is, KVM's patching is done with the effective
>>> permissions of the guest which means, if the code in question isn't
>>> writable from the guest's point of view, KVM's attempt to modify it will
>>> fail. This failure isn't transparent for the guest as it sees a #PF
>>> instead of a #UD, and that's what I'm trying to fix by disabling the quirk.
>>> The hypercall patching was introduced in Linux commit 7aa81cc04781
>>> ("KVM: Refactor hypercall infrastructure (v3)") in v2.6.25. Until then
>>> it was based on a dedicated hypercall page that was handled by KVM to
>>> use the proper instruction of the KVM module in use (VMX or SVM).
>>> Patching code was fine back then, but the introduction of DEBUG_RO_DATA
>>> made the patching attempts fail and, ultimately, lead to Paolo handle
>>> this with commit c1118b3602c2 ("x86: kvm: use alternatives for VMCALL
>>> vs. VMMCALL if kernel text is read-only").
>>> However, his change still doesn't account for the cross-vendor live
>>> migration case (Intel<->AMD), which will still be broken, causing the
>>> before mentioned bogus #PF, which will just lead to misleading Oops
>>> reports, confusing the poor souls, trying to make sense of it.
>>> IMHO, there is no valid reason for still having the patching in place as
>>> the .text of non-ancient kernel's  will be write-protected, making
>>> patching attempts fail. And, as they fail with a #PF instead of #UD, the
>>> guest cannot even handle them appropriately, as there was no memory
>>> write attempt from its point of view. Therefore the default should be to
>>> disable it, IMO. This won't prevent guests making use of the wrong
>>> instruction from trapping, but, at least, now they'll get the correct
>>> exception vector and can handle it appropriately.
>> But you don't accout for the case that guest kernel is built without CONFIG_STRICT_KERNEL_RWX enabled, or without CONFIG_DEBUG_RO_DATA, or for whatever reason the guest's text is not readonly, and the VM needs to be migrated among different vendors (Intel <-> AMD).
>>
>> Before this patch, the above usecase works well. But with this patch, the guest will gets #UD after migrated to different vendors.
>>
>> I heard from some small CSPs that they do want to the ability to live migrate VMs among Intel and AMD host.
>>
> Is there a particular reason to not handle that #UD as a hypercall to support that scenario?

do you mean KVM handles the first hardware #UD due to the wrong opcode 
of hypercall by directly emulate the hypercall instead of going to 
emulator to patch the guest memory with modifying the guest memory?

If so, I agree with it. I thought the same solution and had no bandwidth 
and motivation to raise the idea to KVM community.

> Especially with some guest OS kernels having kernel patch protection with periodic scrubbing of r/o memory (ie Windows), doesn’t sound great to override anything in a way the guest OS kernel can notice…


