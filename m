Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88438E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuwX-0000Ps-In; Thu, 12 Dec 2024 20:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1tLuwW-0000PY-EW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:58:12 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1tLuwU-0002l3-Fk
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734055090; x=1765591090;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=rEh6nEUB6b2gWFVudTedi+7SvZpJ1yXIcaAEvQ6Ls4c=;
 b=XWsq0kS13gsZ9N54CbCjahpuJOWQoS1n2aExAdWRTb4kLKLdZ4etZZkH
 UBkYwYZZVebvI6eRcSS/hoNEQL1udBCdxOJEMx/2+qBpcDz0VbPIUIN3F
 cXIpdJPGiZBD8JiY6E9wEh3HS/iCXDH/npe+zNp+bkV5XEfGryW/WXN60
 pwTFocpnmP7F0Efq/SMp23oqPScEtkswpXAnccYfj0ylKbhHcyenL9CxE
 0FJrxc7Z7l+OF8FfMRU/e5SjxdQ9nW7t1HqaCItX88D4ttk2a9CEFMubT
 cl21OfFw0WCoCFLn4M8ufVvZ45BI6Rm0m/MCkH2ZCLMVLqQCT2HZrz4cf Q==;
X-CSE-ConnectionGUID: lLx8B24tQRSl8RuvH3HmzQ==
X-CSE-MsgGUID: Hbb6vP/gTiavGxKK9iERNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45188815"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="45188815"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 17:58:07 -0800
X-CSE-ConnectionGUID: 3VN4NUYtTsGLF8+vnybM8g==
X-CSE-MsgGUID: 0ou1/nhkTMiLJu+On8Y/Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="101260708"
Received: from unknown (HELO [10.238.9.154]) ([10.238.9.154])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 17:52:36 -0800
Message-ID: <2cf8bf60-b36d-47ca-9aef-d477a841cbed@linux.intel.com>
Date: Fri, 13 Dec 2024 09:52:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Set return value after handling
 KVM_EXIT_HYPERCALL
From: Binbin Wu <binbin.wu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, michael.roth@amd.com, rick.p.edgecombe@intel.com,
 isaku.yamahata@intel.com, farrah.chen@intel.com, kvm@vger.kernel.org
References: <20241212032628.475976-1-binbin.wu@linux.intel.com>
 <Z1qZygKqvjIfpOXD@intel.com>
 <1a5e2988-9a7d-4415-86ad-8a7a98dbc5eb@redhat.com>
 <Z1s1yeWKnvmh718N@google.com>
 <5b8f7d63-ef0a-487f-bf9d-44421691fa85@redhat.com>
 <745b2b6e-7dd0-4437-bbbf-673ddc0df014@linux.intel.com>
Content-Language: en-US
In-Reply-To: <745b2b6e-7dd0-4437-bbbf-673ddc0df014@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.9;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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




On 12/13/2024 9:46 AM, Binbin Wu wrote:
>
>
>
> On 12/13/2024 5:28 AM, Paolo Bonzini wrote:
>> On 12/12/24 20:13, Sean Christopherson wrote:
>>> On Thu, Dec 12, 2024, Paolo Bonzini wrote:
>>>> On 12/12/24 09:07, Zhao Liu wrote:
>>>>> On Thu, Dec 12, 2024 at 11:26:28AM +0800, Binbin Wu wrote:
>>>>>> Date: Thu, 12 Dec 2024 11:26:28 +0800
>>>>>> From: Binbin Wu <binbin.wu@linux.intel.com>
>>>>>> Subject: [PATCH] i386/kvm: Set return value after handling
>>>>>>    KVM_EXIT_HYPERCALL
>>>>>> X-Mailer: git-send-email 2.46.0
>>>>>>
>>>>>> Userspace should set the ret field of hypercall after handling
>>>>>> KVM_EXIT_HYPERCALL.  Otherwise, a stale value could be returned to KVM.
>>>>>>
>>>>>> Fixes: 47e76d03b15 ("i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE")
>>>>>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>>>>>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>>>>>> Tested-by: Farrah Chen <farrah.chen@intel.com>
>>>>>> ---
>>>>>> To test the TDX code in kvm-coco-queue, please apply the patch to the QEMU,
>>>>>> otherwise, TDX guest boot could fail.
>>>>>> A matching QEMU tree including this patch is here:
>>>>>> https://github.com/intel-staging/qemu-tdx/releases/tag/tdx-qemu-upstream-v6.1-fix_kvm_hypercall_return_value
>>>>>>
>>>>>> Previously, the issue was not triggered because no one would modify the ret
>>>>>> value. But with the refactor patch for __kvm_emulate_hypercall() in KVM,
>>>>>> https://lore.kernel.org/kvm/20241128004344.4072099-7-seanjc@google.com/, the
>>>>>> value could be modified.
>>>>>
>>>>> Could you explain the specific reasons here in detail? It would be
>>>>> helpful with debugging or reproducing the issue.
>>>>>
>>>>>> ---
>>>>>>    target/i386/kvm/kvm.c | 8 ++++++--
>>>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>>>>>> index 8e17942c3b..4bcccb48d1 100644
>>>>>> --- a/target/i386/kvm/kvm.c
>>>>>> +++ b/target/i386/kvm/kvm.c
>>>>>> @@ -6005,10 +6005,14 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
>>>>>>    static int kvm_handle_hypercall(struct kvm_run *run)
>>>>>>    {
>>>>>> +    int ret = -EINVAL;
>>>>>> +
>>>>>>        if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
>>>>>> -        return kvm_handle_hc_map_gpa_range(run);
>>>>>> +        ret = kvm_handle_hc_map_gpa_range(run);
>>>>>> +
>>>>>> +    run->hypercall.ret = ret;
>>>>>
>>>>> ret may be negative but hypercall.ret is u64. Do we need to set it to
>>>>> -ret?
>>>>
>>>> If ret is less than zero, will stop the VM anyway as
>>>> RUN_STATE_INTERNAL_ERROR.
>>>>
>>>> If this has to be fixed in QEMU, I think there's no need to set anything
>>>> if ret != 0; also because kvm_convert_memory() returns -1 on error and
>>>> that's not how the error would be passed to the guest.
>>>>
>>>> However, I think the right fix should simply be this in KVM:
>>>>
>>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>>> index 83fe0a78146f..e2118ba93ef6 100644
>>>> --- a/arch/x86/kvm/x86.c
>>>> +++ b/arch/x86/kvm/x86.c
>>>> @@ -10066,6 +10066,7 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
>>>>           }
>>>>           vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
>>>> +        vcpu->run->ret                = 0;
>>>
>>>         vcpu->run->hypercall.ret
>>>
>>>> vcpu->run->hypercall.nr       = KVM_HC_MAP_GPA_RANGE;
>>>>           vcpu->run->hypercall.args[0]  = gpa;
>>>>           vcpu->run->hypercall.args[1]  = npages;
>>>>
>>>> While there is arguably a change in behavior of the kernel both with
>>>> the patches in kvm-coco-queue and with the above one, _in practice_
>>>> the above change is one that userspace will not notice.
>>>
>>> I agree that KVM should initialize "ret", but I don't think '0' is the right
>>> value.  KVM shouldn't assume userspace will successfully handle the hypercall.
>>> What happens if KVM sets vcpu->run->hypercall.ret to a non-zero value, e.g. -KVM_ENOSYS?
>>
>> Unfortunately QEMU is never writing vcpu->run->hypercall.ret, so the guest sees -KVM_ENOSYS; this is basically the same bug that Binbin is fixing, just with a different value passed to the guest.
>>
>> In other words, the above one-liner is pulling the "don't break userspace" card.
>>
>> Paolo
>>
>>
> If the change need to be done in KVM, there are other 3 functions that use
> KVM_EXIT_HYPERCALL based on the code in kvm-coco-queue.
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 40fe7258843e..a624f7289282 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3633,6 +3633,7 @@ static int snp_begin_psc_msr(struct vcpu_svm *svm, u64 ghcb_msr)
>         }
>
>         vcpu->run->exit_reason = KVM_EXIT_HYPERCALL;
> +       vcpu->run->ret         = 0;
>         vcpu->run->hypercall.nr = KVM_HC_MAP_GPA_RANGE;
>         vcpu->run->hypercall.args[0] = gpa;
>         vcpu->run->hypercall.args[1] = 1;
> @@ -3796,6 +3797,7 @@ static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc)
>         case VMGEXIT_PSC_OP_PRIVATE:
>         case VMGEXIT_PSC_OP_SHARED:
>                 vcpu->run->exit_reason = KVM_EXIT_HYPERCALL;
> +               vcpu->run->ret         = 0;
>                 vcpu->run->hypercall.nr = KVM_HC_MAP_GPA_RANGE;
>                 vcpu->run->hypercall.args[0] = gfn_to_gpa(gfn);
>                 vcpu->run->hypercall.args[1] = npages;
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 85c8aee263c1..c50c2edc8c56 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1161,6 +1161,7 @@ static void __tdx_map_gpa(struct vcpu_tdx * tdx)
>         pr_err("%s: gpa = 0x%llx, size = 0x%llx", __func__, gpa, size);
>
>         tdx->vcpu.run->exit_reason       = KVM_EXIT_HYPERCALL;
> +       tdx->vcpu->run->ret              = 0;
>         tdx->vcpu.run->hypercall.nr      = KVM_HC_MAP_GPA_RANGE;
>         tdx->vcpu.run->hypercall.args[0] = gpa & ~gfn_to_gpa(kvm_gfn_direct_bits(tdx->vcpu.kvm));
>         tdx->vcpu.run->hypercall.args[1] = size / PAGE_SIZE;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4f94b1e24eae..3f82bb2357e3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10070,6 +10070,7 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
>                 }
>
>                 vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
> +               vcpu->run->ret                = 0;
>                 vcpu->run->hypercall.nr       = KVM_HC_MAP_GPA_RANGE;
>                 vcpu->run->hypercall.args[0]  = gpa;
>                 vcpu->run->hypercall.args[1]  = npages;
>
Maybe we could add a helper to fill the vcpu->run?


