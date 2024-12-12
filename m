Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B98BE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 07:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLdKo-000634-Md; Thu, 12 Dec 2024 02:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLdKk-00060m-7Y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 02:10:02 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tLdKh-0004kV-BY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 02:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733987400; x=1765523400;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MSvkjbenIER/EkrASVrmQJf/AlKIKuUcYGtMbSesBcA=;
 b=JF3Y7Aq2KAIBrZrcDrMq6Ax61pxSm54A/GFJAXqEzWUfyM3FbPZd1KqA
 kiMnEgBWhS4vy37EIiEI7yCDskW1YnVPPapyUIvJBmI3teT10VJRpTieS
 qcOQo0WuZ3iiErJKmiIuCGY6UExt1DhtTSk6asPqyrdUv6WarcrEvw5sP
 1T/udi1GIvNp0XiVOjdQ91DcbFivu7m1Yaft/nonvHi8Eew+9ZMQ3kF0i
 9dDLsGGX3FBIYhMkaL2owYWhRrpftenIXSez54yLPFyxAttHgHzfK6E2E
 z7uiVF9EHFa8XvCFRjHm8I5LoVFaeFPWIH3vGSxPl/S8xSEVtX6OWMOos A==;
X-CSE-ConnectionGUID: yv9eXqhiR1uIcPRL1Ysyfg==
X-CSE-MsgGUID: rweVb0LxTh61+JzCKZw3aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38325079"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="38325079"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 23:09:56 -0800
X-CSE-ConnectionGUID: 4WFV7J6ERJeAks8Dy3h8oA==
X-CSE-MsgGUID: 7z1TwoDFRomdzhkX6c91nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; d="scan'208";a="96028385"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 23:09:52 -0800
Message-ID: <0d480d7e-3c8f-43b9-a123-11b23062669d@intel.com>
Date: Thu, 12 Dec 2024 15:09:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Set return value after handling
 KVM_EXIT_HYPERCALL
To: Binbin Wu <binbin.wu@linux.intel.com>, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Cc: seanjc@google.com, michael.roth@amd.com, rick.p.edgecombe@intel.com,
 isaku.yamahata@intel.com, farrah.chen@intel.com, kvm@vger.kernel.org
References: <20241212032628.475976-1-binbin.wu@linux.intel.com>
 <2144c2c0-4a5d-4efd-b5e2-f2b4096c08b5@intel.com>
 <72e1da62-5fd2-4633-b304-24be3dac1e7f@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <72e1da62-5fd2-4633-b304-24be3dac1e7f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/12/2024 1:18 PM, Binbin Wu wrote:
> 
> 
> 
> On 12/12/2024 11:44 AM, Xiaoyao Li wrote:
>> On 12/12/2024 11:26 AM, Binbin Wu wrote:
>>> Userspace should set the ret field of hypercall after handling
>>> KVM_EXIT_HYPERCALL.  Otherwise, a stale value could be returned to KVM.
>>>
>>> Fixes: 47e76d03b15 ("i386/kvm: Add KVM_EXIT_HYPERCALL handling for 
>>> KVM_HC_MAP_GPA_RANGE")
>>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>>> Tested-by: Farrah Chen <farrah.chen@intel.com>
>>> ---
>>> To test the TDX code in kvm-coco-queue, please apply the patch to the 
>>> QEMU,
>>> otherwise, TDX guest boot could fail.
>>> A matching QEMU tree including this patch is here:
>>> https://github.com/intel-staging/qemu-tdx/releases/tag/tdx-qemu- 
>>> upstream-v6.1-fix_kvm_hypercall_return_value
>>>
>>> Previously, the issue was not triggered because no one would modify 
>>> the ret
>>> value. But with the refactor patch for __kvm_emulate_hypercall() in KVM,
>>> https://lore.kernel.org/kvm/20241128004344.4072099-7- 
>>> seanjc@google.com/, the
>>> value could be modified.
>>> ---
>>>   target/i386/kvm/kvm.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>>> index 8e17942c3b..4bcccb48d1 100644
>>> --- a/target/i386/kvm/kvm.c
>>> +++ b/target/i386/kvm/kvm.c
>>> @@ -6005,10 +6005,14 @@ static int kvm_handle_hc_map_gpa_range(struct 
>>> kvm_run *run)
>>>     static int kvm_handle_hypercall(struct kvm_run *run)
>>>   {
>>> +    int ret = -EINVAL;
>>> +
>>>       if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
>>> -        return kvm_handle_hc_map_gpa_range(run);
>>> +        ret = kvm_handle_hc_map_gpa_range(run);
>>> +
>>> +    run->hypercall.ret = ret;
>>
>> Updating run->hypercall.ret is useful only when QEMU needs to re-enter 
>> the guest. For the case of ret < 0, QEMU will stop the vcpu.
> 
> IMHO, assign run->hypercall.ret anyway should be OK, no need to add a
> per-condition on ret, although the value is not used when ret < 0.
> 
> Currently, since QEMU will stop the vcpu when ret < 0, this patch doesn't
> convert ret to -Exxx that the ABI expects.

I was thinking if it is better to let each specific handling function to 
   update run->hypercall.ret with its own logic. E.g., for this case, 
let kvm_handle_hc_map_gpa_range() to update the run->hypercall.ret.

Reusing the return value of the handling function to update
run->hypercall.ret seems not logically correct to me.

>>
>> I think we might need re-think on the handling of KVM_EXIT_HYPERCALL. 
>> E.g., in what error case should QEMU stop the vcpu, and in what case 
>> can QEMU return the error back to the guest via run->hypercall.ret.
> 
> Actually, I had the similar question before.
> https://lore.kernel.org/kvm/ 
> d25cc62c-0f56-4be2-968a-63c8b1d63b5a@linux.intel.com/
> 
> It might depends on the hypercall number?
> Another option is QEMU always sets run->hypercall.ret appropriately and 
> continues the vcpu thread.
> 
> 
>>
>>> -    return -EINVAL;
>>> +    return ret;
>>>   }
>>>     #define VMX_INVALID_GUEST_STATE 0x80000021
>>>
>>> base-commit: ae35f033b874c627d81d51070187fbf55f0bf1a7
>>
> 


