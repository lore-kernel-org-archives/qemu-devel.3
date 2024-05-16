Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65734C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 04:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Sn1-0002Go-U3; Thu, 16 May 2024 00:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7Smq-0002EY-Vh; Thu, 16 May 2024 00:32:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7Smk-00019a-CV; Thu, 16 May 2024 00:32:12 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44G3m8HD003211; Thu, 16 May 2024 04:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eokEHeKj2G2AlniVlq8pA/Xr4d9ASFXgGu/0c0SWIdc=;
 b=kJDM/fI4rulpjHKQ8HP44ZBjN7w4DP/dKdQYUR/B7qcj2VgQCd4Tyl8HXQz5aEtXOW3T
 tT/nDJCGyMNw/MHl1oBx4yoc6JVJQ2DhbgOWu1NVI2V9Ts3zmszDSI+Xj/yX89msBk8f
 ilMWIrgBJXS/J6zZl1itCaH1JC+mDOlhVmwRSTkvCdf6x8ykkCv0gRWH1YZM7lN2smBI
 lwwlk13o9xW3ldugNgtiw/niaX6bID/DQbjtig+B+OjbYyvigMAhnWnzvgyBjx+c9RAx
 4qU4HmI80kh8XMTjROfe61QSZKPdxaSyTnDu/7dCZpFnC0hhym+kmIknedfrgY/ai5vZ Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5767rgjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 04:32:02 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44G4W1R7013691;
 Thu, 16 May 2024 04:32:01 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5767rgjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 04:32:01 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44G30Hkj018828; Thu, 16 May 2024 04:32:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2k0tr4cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 04:32:01 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44G4VvjH13959816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2024 04:31:59 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A7DD58064;
 Thu, 16 May 2024 04:31:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 441FA5806A;
 Thu, 16 May 2024 04:31:54 +0000 (GMT)
Received: from [9.195.47.126] (unknown [9.195.47.126])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 May 2024 04:31:53 +0000 (GMT)
Message-ID: <170efe52-97c4-48dd-b4ce-097655a76d9f@linux.ibm.com>
Date: Thu, 16 May 2024 10:01:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: handle vcpu hotplug failure gracefully
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com
References: <20240423061058.595674-1-harshpb@linux.ibm.com>
 <a0f9b2fc-4c8a-4c37-bc36-26bbaa627fec@linux.ibm.com>
 <D191D2JFAR7L.2EH4S445M4TGK@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <D191D2JFAR7L.2EH4S445M4TGK@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kk-CzwFJwQJAGVNitY4wb14K_j4GOsJ4
X-Proofpoint-ORIG-GUID: HHt7AcnWCS9Dw1JGWkEKJLUXcVflSvde
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_01,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405160029
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Nick,

On 5/14/24 08:39, Nicholas Piggin wrote:
> On Tue Apr 23, 2024 at 4:30 PM AEST, Harsh Prateek Bora wrote:
>> + qemu-devel
>>
>> On 4/23/24 11:40, Harsh Prateek Bora wrote:
>>> On ppc64, the PowerVM hypervisor runs with limited memory and a VCPU
>>> creation during hotplug may fail during kvm_ioctl for KVM_CREATE_VCPU,
>>> leading to termination of guest since errp is set to &error_fatal while
>>> calling kvm_init_vcpu. This unexpected behaviour can be avoided by
>>> pre-creating vcpu and parking it on success or return error otherwise.
>>> This enables graceful error delivery for any vcpu hotplug failures while
>>> the guest can keep running.
> 
> So this puts in on the park list so when kvm_init_vcpu() later runs it
> will just take it off the park list instead of issuing another
> KVM_CREATE_VCPU ioctl.
> 
> And kvm_init_vcpu() runs in the vcpu thread function, which does not
> have a good way to indicate failure to the caller.
> 
> I'm don't know a lot about this part of qemu but it seems like a good
> idea to move fail-able initialisation out of the vcpu thread in that
> case. So the general idea seems good to me.
> 

Yeh ..

>>>
>>> Based on api refactoring to create/park vcpus introduced in 1/8 of patch series:
>>> https://lore.kernel.org/qemu-devel/20240312020000.12992-2-salil.mehta@huawei.com/
> 
> So from this series AFAIKS you're just using kvm_create / kvm_park
> routines? You could easily pull that patch 1 out ahead of that larger
> series if progress is slow on it, it's a decent cleanup by itself by
> the looks.
> 

Yeh, patch 1 of that series is only we need but the author mentioned on 
the list that he is about to post next version soon.

>>>
>>> Tested OK by repeatedly doing a hotplug/unplug of vcpus as below:
>>>
>>>    #virsh setvcpus hotplug 40
>>>    #virsh setvcpus hotplug 70
>>> error: internal error: unable to execute QEMU command 'device_add':
>>> kvmppc_cpu_realize: vcpu hotplug failed with -12
>>>
>>> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
>>> Suggested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>>> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>>> Signed-off by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> ---
>>> ---
>>>    target/ppc/kvm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 42 insertions(+)
>>>
>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>>> index 8231feb2d4..c887f6dfa0 100644
>>> --- a/target/ppc/kvm.c
>>> +++ b/target/ppc/kvm.c
>>> @@ -48,6 +48,8 @@
>>>    #include "qemu/mmap-alloc.h"
>>>    #include "elf.h"
>>>    #include "sysemu/kvm_int.h"
>>> +#include "sysemu/kvm.h"
>>> +#include "hw/core/accel-cpu.h"
>>>    
>>>    #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
>>>    
>>> @@ -2339,6 +2341,43 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
>>>        }
>>>    }
>>>    
>>> +static int max_cpu_index = 0;
>>> +
>>> +static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
>>> +{
>>> +    int ret;
>>> +
>>> +    cs->cpu_index = max_cpu_index++;
>>> +
>>> +    POWERPC_CPU(cs)->vcpu_id = cs->cpu_index;
> 
> So you're overriding the cpu_get_free_index() allocator here.
> And you need to because vcpu_id needs to be assigned before
> the KVM create, I guess.
> 

Yes ..

> I guess it works. I would add a comment like s390x has.
> 
Not sure which comment you were referring to but with exporting
cpu_get_free_index as suggested later, not sure if we still need any
comment.

>>> +
>>> +    if (cs->parent_obj.hotplugged) {
> 
> Can _all_ kvm cpu creation go via this path? Why just limit it to
> hotplugged?

For the initial bootup, we actually want to abort if the requested vCPUs
cant be allocated so that user can retry until the requested vCPUs are
allocated. For hotplug failure, bringing down entire guest isn't fair,
hence the fix.

> 
>>> +        /* create and park to fail gracefully in case vcpu hotplug fails */
>>> +        ret = kvm_create_vcpu(cs);
>>> +        if (!ret) {
>>> +            kvm_park_vcpu(cs);
> 
> Seems like a small thing, but I would add a new core kvm function
> that creates and parks the vcpu, so the target code doesn't have
> to know about the parking internals, just that it needs to be
> called.

Make sense, I will add another kvm helper: kvm_create_and_park_vcpu()

> 
> Unless I'm missing something, we could get all targets to move their kvm
> create to here and remove it removed from kvm_init_vcpu(), that would
> just expect it to be on the parked list. But that could be done
> incrementally.

Hmm ..

> 
>>> +        } else {
>>> +            max_cpu_index--;
>>> +            error_setg(errp, "%s: vcpu hotplug failed with %d",
>>> +                             __func__, ret);
>>> +            return false;
>>> +        }
>>> +    }
>>> +    return true;
>>> +}
>>> +
>>> +static void kvmppc_cpu_unrealize(CPUState *cpu)
>>> +{
>>> +    if (POWERPC_CPU(cpu)->vcpu_id == (max_cpu_index - 1)) {
>>> +    /* only reclaim vcpuid if its the last one assigned
>>> +     * as reclaiming random vcpuid for parked vcpus may lead
>>> +     * to unexpected behaviour due to an existing kernel bug
>>> +     * when drc_index doesnt get reclaimed as expected.
>>> +     */
>>> +        max_cpu_index--;
>>> +    }
> 
> This looks like a fairly lossy allocator. Using cpu_get_free_index()
> would be the way to go I think. I would export that and call it here,
> and then you don't need this. Just have to take care of the assert,
> something like this:
> 
> diff --git a/cpu-common.c b/cpu-common.c
> index ce78273af5..9f90c8ec9b 100644
> --- a/cpu-common.c
> +++ b/cpu-common.c
> @@ -57,14 +57,11 @@ void cpu_list_unlock(void)
>       qemu_mutex_unlock(&qemu_cpu_list_lock);
>   }
>   
> -static bool cpu_index_auto_assigned;
> -
> -static int cpu_get_free_index(void)
> +int cpu_get_free_index(void)
>   {
>       CPUState *some_cpu;
>       int max_cpu_index = 0;
>   
> -    cpu_index_auto_assigned = true;
>       CPU_FOREACH(some_cpu) {
>           if (some_cpu->cpu_index >= max_cpu_index) {
>               max_cpu_index = some_cpu->cpu_index + 1;
> @@ -83,8 +80,11 @@ unsigned int cpu_list_generation_id_get(void)
>   
>   void cpu_list_add(CPUState *cpu)
>   {
> +    static bool cpu_index_auto_assigned;
> +
>       QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
>       if (cpu->cpu_index == UNASSIGNED_CPU_INDEX) {
> +        cpu_index_auto_assigned = true;
>           cpu->cpu_index = cpu_get_free_index();
>           assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
>       } else {
> 

This indeed seems better, will update v2 as suggested.

Thanks
Harsh
> 
>>> +}
>>> +
>>>    static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
>>>    {
>>>        PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
>>> @@ -2963,4 +3002,7 @@ bool kvm_arch_cpu_check_are_resettable(void)
>>>    
>>>    void kvm_arch_accel_class_init(ObjectClass *oc)
>>>    {
>>> +    AccelClass *ac = ACCEL_CLASS(oc);
>>> +    ac->cpu_common_realize = kvmppc_cpu_realize;
>>> +    ac->cpu_common_unrealize = kvmppc_cpu_unrealize;
>>>    }
> 
> Thanks,
> Nick

