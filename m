Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60200C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 09:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8zkc-0000Uq-IL; Mon, 20 May 2024 05:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s8zkX-0000UP-2e; Mon, 20 May 2024 05:56:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s8zkR-0000V9-Oz; Mon, 20 May 2024 05:56:08 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44K7wB0B001839; Mon, 20 May 2024 09:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dLMxtDHxY2OuBeM7XRceWL3P8kqN/KJzyXkRJBBcVMw=;
 b=ezyDpGt2k7aiGXGgxrTy6NOOL/XpzHuAsuXaCYpwQWJSIRUWMdqvIZeHotFS8VkZU++e
 +aat6b4T8CdnLNe6UUD57CMaGsOocjoXGebASmwKX5rlR7ZFgcqlPyThiSCBFhQvQdJw
 IRXd/a0fozVCVoUGY+zMfFYzv8mkuuwCx3RFIlH+D/GMXmeubrkrApn0ASANDKnxJH3g
 aeEEoB0DENgBRifz2YUJWlBfFBtO6snK7XH1GanN9+1hY1oZeumF72Hp4431+WU/l8UN
 IEjo9dI7XzzWK1Y0Ml5mGXRZoWIPjlNjCNbq/x0IESoX5gu483lvIy6lgUkuNR6TJ/6I nw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y82k5881w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 09:56:01 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44K9u1Fa015732;
 Mon, 20 May 2024 09:56:01 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y82k5881u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 09:56:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44K7Ohhv008216; Mon, 20 May 2024 09:56:00 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y78vkpr33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 09:56:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44K9tuwA11797188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 May 2024 09:55:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCA4D5805B;
 Mon, 20 May 2024 09:55:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B79E58058;
 Mon, 20 May 2024 09:55:53 +0000 (GMT)
Received: from [9.124.210.220] (unknown [9.124.210.220])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 May 2024 09:55:52 +0000 (GMT)
Message-ID: <85fd9f8a-0a46-4a3e-ab8c-e63633760836@linux.ibm.com>
Date: Mon, 20 May 2024 15:25:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: handle vcpu hotplug failure gracefully
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com
References: <20240423061058.595674-1-harshpb@linux.ibm.com>
 <a0f9b2fc-4c8a-4c37-bc36-26bbaa627fec@linux.ibm.com>
 <D191D2JFAR7L.2EH4S445M4TGK@gmail.com>
 <170efe52-97c4-48dd-b4ce-097655a76d9f@linux.ibm.com>
 <D1BMB9HRF50E.2UC36WJ1ZHAFU@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <D1BMB9HRF50E.2UC36WJ1ZHAFU@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KKXBPYl7UuwfxzaOc-2IP4dnoD4_mDe3
X-Proofpoint-ORIG-GUID: vSLyaU9Uqi6YIrxg-xNKZifk-8TzSwiK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_05,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405200082
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 5/17/24 09:30, Nicholas Piggin wrote:
> On Thu May 16, 2024 at 2:31 PM AEST, Harsh Prateek Bora wrote:
>> Hi Nick,
>>
>> On 5/14/24 08:39, Nicholas Piggin wrote:
>>> On Tue Apr 23, 2024 at 4:30 PM AEST, Harsh Prateek Bora wrote:
>>>> + qemu-devel
>>>>
>>>> On 4/23/24 11:40, Harsh Prateek Bora wrote:
>>>>> On ppc64, the PowerVM hypervisor runs with limited memory and a VCPU
>>>>> creation during hotplug may fail during kvm_ioctl for KVM_CREATE_VCPU,
>>>>> leading to termination of guest since errp is set to &error_fatal while
>>>>> calling kvm_init_vcpu. This unexpected behaviour can be avoided by
>>>>> pre-creating vcpu and parking it on success or return error otherwise.
>>>>> This enables graceful error delivery for any vcpu hotplug failures while
>>>>> the guest can keep running.
>>>
>>> So this puts in on the park list so when kvm_init_vcpu() later runs it
>>> will just take it off the park list instead of issuing another
>>> KVM_CREATE_VCPU ioctl.
>>>
>>> And kvm_init_vcpu() runs in the vcpu thread function, which does not
>>> have a good way to indicate failure to the caller.
>>>
>>> I'm don't know a lot about this part of qemu but it seems like a good
>>> idea to move fail-able initialisation out of the vcpu thread in that
>>> case. So the general idea seems good to me.
>>>
>>
>> Yeh ..
>>
>>>>>
>>>>> Based on api refactoring to create/park vcpus introduced in 1/8 of patch series:
>>>>> https://lore.kernel.org/qemu-devel/20240312020000.12992-2-salil.mehta@huawei.com/
>>>
>>> So from this series AFAIKS you're just using kvm_create / kvm_park
>>> routines? You could easily pull that patch 1 out ahead of that larger
>>> series if progress is slow on it, it's a decent cleanup by itself by
>>> the looks.
>>>
>>
>> Yeh, patch 1 of that series is only we need but the author mentioned on
>> the list that he is about to post next version soon.
>>
>>>>>
>>>>> Tested OK by repeatedly doing a hotplug/unplug of vcpus as below:
>>>>>
>>>>>     #virsh setvcpus hotplug 40
>>>>>     #virsh setvcpus hotplug 70
>>>>> error: internal error: unable to execute QEMU command 'device_add':
>>>>> kvmppc_cpu_realize: vcpu hotplug failed with -12
>>>>>
>>>>> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
>>>>> Suggested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>>>>> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>>>>> Signed-off by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>>> ---
>>>>> ---
>>>>>     target/ppc/kvm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 42 insertions(+)
>>>>>
>>>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>>>>> index 8231feb2d4..c887f6dfa0 100644
>>>>> --- a/target/ppc/kvm.c
>>>>> +++ b/target/ppc/kvm.c
>>>>> @@ -48,6 +48,8 @@
>>>>>     #include "qemu/mmap-alloc.h"
>>>>>     #include "elf.h"
>>>>>     #include "sysemu/kvm_int.h"
>>>>> +#include "sysemu/kvm.h"
>>>>> +#include "hw/core/accel-cpu.h"
>>>>>     
>>>>>     #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
>>>>>     
>>>>> @@ -2339,6 +2341,43 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
>>>>>         }
>>>>>     }
>>>>>     
>>>>> +static int max_cpu_index = 0;
>>>>> +
>>>>> +static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    cs->cpu_index = max_cpu_index++;
>>>>> +
>>>>> +    POWERPC_CPU(cs)->vcpu_id = cs->cpu_index;
>>>
>>> So you're overriding the cpu_get_free_index() allocator here.
>>> And you need to because vcpu_id needs to be assigned before
>>> the KVM create, I guess.
>>>
>>
>> Yes ..
>>
>>> I guess it works. I would add a comment like s390x has.
>>>
>> Not sure which comment you were referring to but with exporting
>> cpu_get_free_index as suggested later, not sure if we still need any
>> comment.
> 
> Yeah that's true.
> 
>>>>> +
>>>>> +    if (cs->parent_obj.hotplugged) {
>>>
>>> Can _all_ kvm cpu creation go via this path? Why just limit it to
>>> hotplugged?
>>
>> For the initial bootup, we actually want to abort if the requested vCPUs
>> cant be allocated so that user can retry until the requested vCPUs are
>> allocated. For hotplug failure, bringing down entire guest isn't fair,
>> hence the fix.
> 
> But you could make the error handling depend on hotplugged, no?
> Perhaps put that error handling decision in common code so policy
> is the same for all targets and back ends.

Hmm, I think just setting errp appropriately would suffice for both
cases as existing behaviour takes care of the rest of handling.
Something like below:

+static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
+{
+    int ret;
+    const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
+                           "hotplug" : "create";
+    cs->cpu_index = cpu_get_free_index();
+
+    POWERPC_CPU(cs)->vcpu_id = cs->cpu_index;
+
+    /* create and park to fail gracefully in case vcpu hotplug fails */
+    ret = kvm_create_and_park_vcpu(cs);
+    if (ret) {
+        error_setg(errp, "%s: vcpu %s failed with %d",
+                         __func__, vcpu_str, ret);
+        return false;
+    }
+    return true;
+}


> 
> [...]
> 
>>>>> +}
>>>>> +
>>>>>     static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
>>>>>     {
>>>>>         PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
>>>>> @@ -2963,4 +3002,7 @@ bool kvm_arch_cpu_check_are_resettable(void)
>>>>>     
>>>>>     void kvm_arch_accel_class_init(ObjectClass *oc)
>>>>>     {
>>>>> +    AccelClass *ac = ACCEL_CLASS(oc);
>>>>> +    ac->cpu_common_realize = kvmppc_cpu_realize;
>>>>> +    ac->cpu_common_unrealize = kvmppc_cpu_unrealize;
>>>>>     }
> 
> One other thing I noticed -- cpu_common_realize seems to be for
> core code and cpu_target_realize for targets. Should we be
> using the latter here? If not, a comment would be warranted and
> probably also a comment in accel_cpu_common_realize().

Well, I looked at that initially but looks like accel_cpu itself (which
contains vector for cpu_target_realize) doesnt get initialized in case
of kvm on ppc for some reason and therefore wouldnt work. I think
this change is generic enough for cpu_common_realize as well (now having
similar behaviour for initial vcpus also), so I guess comment may not 
really be needed, but let me know if still need any comment.

Else, I can post next version with above proposed diff.

regards,
Harsh

> 
> Thanks,
> Nick

