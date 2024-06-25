Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F751C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5ZW-0001aO-DU; Tue, 25 Jun 2024 08:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sM5ZT-0001Zy-1Y
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:46:51 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sM5ZQ-0003IN-0r
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:46:50 -0400
X-ASG-Debug-ID: 1719319578-086e231107134460001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx1.zhaoxin.com with ESMTP id RXG6L8YQHwsrUlpW (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 25 Jun 2024 20:46:18 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 20:46:18 +0800
Received: from [10.28.66.62] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 20:46:17 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <53119b66-3528-41d6-ac44-df166699500a@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.28.66.62
Date: Tue, 25 Jun 2024 08:46:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v3] target/i386/kvm: Refine VMX controls setting
 for backward compatibility
CC: Xiaoyao Li <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <mtosatti@redhat.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>
References: <20240624095806.214525-1-ewanhai-oc@zhaoxin.com>
 <ZnqSj4PGrUeZ7OT1@intel.com>
Content-Language: en-US
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <ZnqSj4PGrUeZ7OT1@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1719319578
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2922
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.126740
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/25/24 05:49, Zhao Liu wrote:
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 7ad8072748..a7c6c5b2d0 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -2386,6 +2386,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
>>   static int kvm_get_supported_feature_msrs(KVMState *s)
>>   {
>>       int ret = 0;
>> +    int i;
>>
>>       if (kvm_feature_msrs != NULL) {
>>           return 0;
>> @@ -2420,6 +2421,20 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
>>           return ret;
>>       }
>>
>> +   /*
>> +    * Compatibility fix:
>> +    * Older Linux kernels (4.17~5.2) report MSR_IA32_VMX_PROCBASED_CTLS2
>> +    * in KVM_GET_MSR_FEATURE_INDEX_LIST but not in KVM_GET_MSR_INDEX_LIST.
>> +    * This leads to an issue in older kernel versions where QEMU,
>> +    * through the KVM_GET_MSR_INDEX_LIST check, assumes the kernel
>> +    * doesn't maintain MSR_IA32_VMX_PROCBASED_CTLS2, resulting in
>> +    * incorrect settings by QEMU for this MSR.
>> +    */
>> +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
> nit: `i` could be declared here,
>
> for (int i = 0; i < kvm_feature_msrs->nmsrs; i++) {
do I need to send a v4 version patch,to do this fix?
>> +        if (kvm_feature_msrs->indices[i] == MSR_IA32_VMX_PROCBASED_CTLS2) {
>> +            has_msr_vmx_procbased_ctls2 = true;
>> +        }
>> +    }
>>       return 0;
>>   }
>>
>> --
>> 2.34.1
>>
> Since the minimum KVM version supported for i386 is v4.5 (docs/system/
> target-i386.rst), this fix makes sense, so for this patch,
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>
> Additionally, has_msr_vmx_vmfunc has the similar compat issue. I think
> it deserves a fix, too.
>
> -Zhao
Thanks for your reply. In fact, I've tried to process has_msr_vmx_vmfunc 
in the same
way as has_msr_vmx_procbased_ctls in this patch, but when I tested on 
Linux kernel
4.19.67, I encountered an "error: failed to set MSR 0x491 to 0x***".

This issue is due to Linux kernel commit 27c42a1bb ("KVM: nVMX: Enable 
VMFUNC
for the L1 hypervisor", 2017-08-03) exposing VMFUNC to the QEMU guest 
without
corresponding VMFUNC MSR modification code, leading to an error when 
QEMU attempts
to set the VMFUNC MSR. This bug affects kernels from 4.14 to 5.2, with a 
fix introduced
in 5.3 by Paolo (e8a70bd4e "KVM: nVMX: allow setting the VMFUNC controls 
MSR", 2019-07-02).

So the fix for has_msr_vmx_vmfunc is clearly different from 
has_msr_vmx_procbased_ctls2.
However, due to the different kernel support situations, I have not yet 
come up with a suitable
way to handle the compatibility of has_msr_vmx_procbased_ctls2 across 
different kernel versions.

Therefore, should we consider only fixing has_msr_vmx_procbased_ctls2 
this time and addressing
has_msr_vmx_vmfunc in a future patch when the timing is more appropriate?


