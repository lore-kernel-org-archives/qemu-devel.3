Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC16C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 06:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz9g0-00051z-Lq; Tue, 23 Apr 2024 02:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rz9fv-00050r-AP; Tue, 23 Apr 2024 02:30:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rz9fs-0002pF-UP; Tue, 23 Apr 2024 02:30:43 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N5xIIH021922; Tue, 23 Apr 2024 06:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZrZ6v1BsxubdgToDDoKvSknFD+Xq7V5nY4217VZWvHk=;
 b=Y+LMpQCz/bm5Sx+fMWmye1oPYbF7w9R7xIJVixbA8VUPiu9G9yKOBWuYGWyGkCpeUSkf
 umpTaOOzcG8HLkU3exCbwQBLkar0vmemRgKT48etSMOmQtVZyp7xzHNKIAJGcNiPPga/
 Wik758Yd/1rEql/wWhRAjbrPxHZ48FYyG/dmMo1RbTfFQHs/QKOWGPhYkh5ZPHcAyffy
 M6DMRAPW2d1w0haS7TB8JTpdlXpOpiSwlJM7wJXgUO8p//WmWpj8eyXeCaotl+Kik37d
 KE0bcIMCCgZrN3pHQTrzNc+vUgcLrxIuU6VG7yYVqv62MmHO+daysbq4+PiHQYB3K5+k Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp4vr86s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:30:38 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N6UcGb013727;
 Tue, 23 Apr 2024 06:30:38 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp4vr86s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:30:38 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N5ZPYM005373; Tue, 23 Apr 2024 06:30:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3cat11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:30:37 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43N6UYA711600440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 06:30:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2CBD5805D;
 Tue, 23 Apr 2024 06:30:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1051958069;
 Tue, 23 Apr 2024 06:30:32 +0000 (GMT)
Received: from [9.109.243.194] (unknown [9.109.243.194])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Apr 2024 06:30:31 +0000 (GMT)
Message-ID: <a0f9b2fc-4c8a-4c37-bc36-26bbaa627fec@linux.ibm.com>
Date: Tue, 23 Apr 2024 12:00:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: handle vcpu hotplug failure gracefully
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, npiggin@gmail.com, qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com
References: <20240423061058.595674-1-harshpb@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240423061058.595674-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JbWTIlGxvJ1_X9-xmrWH6HtV1FIqTXbq
X-Proofpoint-ORIG-GUID: IsmzfxLxYS62LMI1ZzP5XIwuSwz5i4f_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230018
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

+ qemu-devel

On 4/23/24 11:40, Harsh Prateek Bora wrote:
> On ppc64, the PowerVM hypervisor runs with limited memory and a VCPU
> creation during hotplug may fail during kvm_ioctl for KVM_CREATE_VCPU,
> leading to termination of guest since errp is set to &error_fatal while
> calling kvm_init_vcpu. This unexpected behaviour can be avoided by
> pre-creating vcpu and parking it on success or return error otherwise.
> This enables graceful error delivery for any vcpu hotplug failures while
> the guest can keep running.
> 
> Based on api refactoring to create/park vcpus introduced in 1/8 of patch series:
> https://lore.kernel.org/qemu-devel/20240312020000.12992-2-salil.mehta@huawei.com/
> 
> Tested OK by repeatedly doing a hotplug/unplug of vcpus as below:
> 
>   #virsh setvcpus hotplug 40
>   #virsh setvcpus hotplug 70
> error: internal error: unable to execute QEMU command 'device_add':
> kvmppc_cpu_realize: vcpu hotplug failed with -12
> 
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Suggested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Signed-off by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
> ---
>   target/ppc/kvm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8231feb2d4..c887f6dfa0 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -48,6 +48,8 @@
>   #include "qemu/mmap-alloc.h"
>   #include "elf.h"
>   #include "sysemu/kvm_int.h"
> +#include "sysemu/kvm.h"
> +#include "hw/core/accel-cpu.h"
>   
>   #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
>   
> @@ -2339,6 +2341,43 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
>       }
>   }
>   
> +static int max_cpu_index = 0;
> +
> +static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
> +{
> +    int ret;
> +
> +    cs->cpu_index = max_cpu_index++;
> +
> +    POWERPC_CPU(cs)->vcpu_id = cs->cpu_index;
> +
> +    if (cs->parent_obj.hotplugged) {
> +        /* create and park to fail gracefully in case vcpu hotplug fails */
> +        ret = kvm_create_vcpu(cs);
> +        if (!ret) {
> +            kvm_park_vcpu(cs);
> +        } else {
> +            max_cpu_index--;
> +            error_setg(errp, "%s: vcpu hotplug failed with %d",
> +                             __func__, ret);
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
> +static void kvmppc_cpu_unrealize(CPUState *cpu)
> +{
> +    if (POWERPC_CPU(cpu)->vcpu_id == (max_cpu_index - 1)) {
> +    /* only reclaim vcpuid if its the last one assigned
> +     * as reclaiming random vcpuid for parked vcpus may lead
> +     * to unexpected behaviour due to an existing kernel bug
> +     * when drc_index doesnt get reclaimed as expected.
> +     */
> +        max_cpu_index--;
> +    }
> +}
> +
>   static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
>   {
>       PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> @@ -2963,4 +3002,7 @@ bool kvm_arch_cpu_check_are_resettable(void)
>   
>   void kvm_arch_accel_class_init(ObjectClass *oc)
>   {
> +    AccelClass *ac = ACCEL_CLASS(oc);
> +    ac->cpu_common_realize = kvmppc_cpu_realize;
> +    ac->cpu_common_unrealize = kvmppc_cpu_unrealize;
>   }

