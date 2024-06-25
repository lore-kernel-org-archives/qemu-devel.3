Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9BDC30659
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLyQ1-0001EM-B6; Tue, 25 Jun 2024 01:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sLyPz-0001Dq-CM; Tue, 25 Jun 2024 01:08:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sLyPw-0001aq-G7; Tue, 25 Jun 2024 01:08:35 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P4xg8C006292;
 Tue, 25 Jun 2024 05:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 pCSJbocnCoyyBGv6qcpbTUuJUcmofD0GSsobFwSbiUA=; b=Ma2nEWOaCy97YmiS
 jbX0Ij34869ULJnWczRdcTQK/EW6/I+kT+7kGcadWmg4LOM5CDhxABivxegYbB8P
 qBEpoP1jy70YIBPhdo9sCy599YS61NEz2sX/Vm13Rx1g865uPx55cf2E4YBBCjbq
 t7aeDsmgQuJ8TaBJTfnC/DZ1iXx7e2VTfnYN95gGsgqPVuZoybhnVy8Zy6+3xNrb
 9K4Dpw5G498mYDKrIfp+FdYDbBl2k6goVL8ySMdvDYqNZaD8LBahgiUcL7bCJrjA
 7gCCkGreyAL6TrHmKuWft/BeFZPZ/Ml0M2V1J9S3GHABPN5wHUslxznRnUNKevi4
 HS2lEg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyqb700t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jun 2024 05:08:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45P58KsN020970;
 Tue, 25 Jun 2024 05:08:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyqb700t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jun 2024 05:08:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45P2ma4x008162; Tue, 25 Jun 2024 05:08:20 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b0mt4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jun 2024 05:08:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45P58HU917826380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2024 05:08:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CFD758066;
 Tue, 25 Jun 2024 05:08:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E99A58053;
 Tue, 25 Jun 2024 05:08:13 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Jun 2024 05:08:12 +0000 (GMT)
Message-ID: <4512d9d5-a2ee-4d83-9c44-510241d72225@linux.ibm.com>
Date: Tue, 25 Jun 2024 10:38:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: Salil Mehta <salil.mehta@huawei.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
 "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-2-salil.mehta@huawei.com>
 <a9fe2b0f-baf2-4684-9e98-86f4df4e4ff5@linux.ibm.com>
 <66be5cd4b44f4ccebb00fd90ad145e48@huawei.com>
 <40196533-103c-42d8-9229-d394154affe6@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <40196533-103c-42d8-9229-d394154affe6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b1Qbfot74iX_iQiFW83MBRIjmknvNyx5
X-Proofpoint-GUID: CpGgDbGcTWVnya9622KnCrKu0N9p8o52
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_01,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250035
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

+qemu-devel, qemu-ppc

Ping!

On 6/17/24 15:18, Harsh Prateek Bora wrote:
> 
> + MST, Igor - to help with early review/merge. TIA.
> 
> On 6/14/24 16:06, Salil Mehta wrote:
>> Hello
>>
>>>   From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>   Sent: Friday, June 14, 2024 6:24 AM
>>>   Hi Paolo, Nick,
>>>   Can this patch 1/8 be merged earlier provided we have got 
>>> sufficient R-bys
>>>   for it and the review of entire series may take a longer time?
>>>   We have some ppc64 patches based on it, hence the ask.
>>>   Hi Salil,
>>>   I am hoping we are not expecting anymore changes to this patch, please
>>>   confirm.
>>
>>
>> I do not expect any change. I had requested Michael to merge the complete
>> series as it is stranding other users. He then requested Igor to take 
>> a final look but
>> he has not reverted yet. I'll remind Michael again. BTW, can you reply 
>> to below
>> patch explicitly indicating your interest in the series so that MST 
>> knows who else
>> are the stake holders here
>>
>> https://lore.kernel.org/qemu-devel/20240605160327.3c71f4ab@imammedo.users.ipa.redhat.com/
>>
>>
>> Hi Paolo,
>>
>> A request, would it be possible to skim through this series from KVM 
>> perspective?
>> (although nothing has changed which will affect the KVM and this is 
>> architecture
>> agnostic patch-set)
>>
>> Many thanks!
>>
>> Best
>> Salil.
>>
>>
>>>   regards,
>>>   Harsh
>>>   On 6/7/24 17:26, Salil Mehta wrote:
>>>   > KVM vCPU creation is done once during the vCPU realization when Qemu
>>>   > vCPU thread is spawned. This is common to all the architectures 
>>> as of now.
>>>   >
>>>   > Hot-unplug of vCPU results in destruction of the vCPU object in QOM
>>>   > but the corresponding KVM vCPU object in the Host KVM is not 
>>> destroyed
>>>   > as KVM doesn't support vCPU removal. Therefore, its 
>>> representative KVM
>>>   > vCPU object/context in Qemu is parked.
>>>   >
>>>   > Refactor architecture common logic so that some APIs could be reused
>>>   > by vCPU Hotplug code of some architectures likes ARM, Loongson etc.
>>>   > Update new/old APIs with trace events. No functional change is 
>>> intended
>>>   here.
>>>   >
>>>   > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>>   > Reviewed-by: Gavin Shan <gshan@redhat.com>
>>>   > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>>>   > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>   > Tested-by: Xianglai Li <lixianglai@loongson.cn>
>>>   > Tested-by: Miguel Luis <miguel.luis@oracle.com>
>>>   > Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>>>   > Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>>>   > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>>>   > Tested-by: Zhao Liu <zhao1.liu@intel.com>
>>>   > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>>   > Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>   > ---
>>>   >   accel/kvm/kvm-all.c    | 95 
>>> ++++++++++++++++++++++++++++------------
>>>   --
>>>   >   accel/kvm/kvm-cpus.h   |  1 -
>>>   >   accel/kvm/trace-events |  5 ++-
>>>   >   include/sysemu/kvm.h   | 25 +++++++++++
>>>   >   4 files changed, 92 insertions(+), 34 deletions(-)
>>>   >
>>>   > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
>>>   > c0be9f5eed..8f9128bb92 100644
>>>   > --- a/accel/kvm/kvm-all.c
>>>   > +++ b/accel/kvm/kvm-all.c
>>>   > @@ -340,14 +340,71 @@ err:
>>>   >       return ret;
>>>   >   }
>>>   >
>>>   > +void kvm_park_vcpu(CPUState *cpu)
>>>   > +{
>>>   > +    struct KVMParkedVcpu *vcpu;
>>>   > +
>>>   > +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>>   > +
>>>   > +    vcpu = g_malloc0(sizeof(*vcpu));
>>>   > +    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
>>>   > +    vcpu->kvm_fd = cpu->kvm_fd;
>>>   > +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node); }
>>>   > +
>>>   > +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id) {
>>>   > +    struct KVMParkedVcpu *cpu;
>>>   > +    int kvm_fd = -ENOENT;
>>>   > +
>>>   > +    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
>>>   > +        if (cpu->vcpu_id == vcpu_id) {
>>>   > +            QLIST_REMOVE(cpu, node);
>>>   > +            kvm_fd = cpu->kvm_fd;
>>>   > +            g_free(cpu);
>>>   > +        }
>>>   > +    }
>>>   > +
>>>   > +    trace_kvm_unpark_vcpu(vcpu_id, kvm_fd > 0 ? "unparked" : "not
>>>   > + found parked");
>>>   > +
>>>   > +    return kvm_fd;
>>>   > +}
>>>   > +
>>>   > +int kvm_create_vcpu(CPUState *cpu)
>>>   > +{
>>>   > +    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
>>>   > +    KVMState *s = kvm_state;
>>>   > +    int kvm_fd;
>>>   > +
>>>   > +    /* check if the KVM vCPU already exist but is parked */
>>>   > +    kvm_fd = kvm_unpark_vcpu(s, vcpu_id);
>>>   > +    if (kvm_fd < 0) {
>>>   > +        /* vCPU not parked: create a new KVM vCPU */
>>>   > +        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
>>>   > +        if (kvm_fd < 0) {
>>>   > +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU 
>>> %lu",
>>>   vcpu_id);
>>>   > +            return kvm_fd;
>>>   > +        }
>>>   > +    }
>>>   > +
>>>   > +    cpu->kvm_fd = kvm_fd;
>>>   > +    cpu->kvm_state = s;
>>>   > +    cpu->vcpu_dirty = true;
>>>   > +    cpu->dirty_pages = 0;
>>>   > +    cpu->throttle_us_per_full = 0;
>>>   > +
>>>   > +    trace_kvm_create_vcpu(cpu->cpu_index, vcpu_id, kvm_fd);
>>>   > +
>>>   > +    return 0;
>>>   > +}
>>>   > +
>>>   >   static int do_kvm_destroy_vcpu(CPUState *cpu)
>>>   >   {
>>>   >       KVMState *s = kvm_state;
>>>   >       long mmap_size;
>>>   > -    struct KVMParkedVcpu *vcpu = NULL;
>>>   >       int ret = 0;
>>>   >
>>>   > -    trace_kvm_destroy_vcpu();
>>>   > +    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>>   >
>>>   >       ret = kvm_arch_destroy_vcpu(cpu);
>>>   >       if (ret < 0) {
>>>   > @@ -373,10 +430,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>>>   >           }
>>>   >       }
>>>   >
>>>   > -    vcpu = g_malloc0(sizeof(*vcpu));
>>>   > -    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
>>>   > -    vcpu->kvm_fd = cpu->kvm_fd;
>>>   > -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
>>>   > +    kvm_park_vcpu(cpu);
>>>   >   err:
>>>   >       return ret;
>>>   >   }
>>>   > @@ -389,24 +443,6 @@ void kvm_destroy_vcpu(CPUState *cpu)
>>>   >       }
>>>   >   }
>>>   >
>>>   > -static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id) -{
>>>   > -    struct KVMParkedVcpu *cpu;
>>>   > -
>>>   > -    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
>>>   > -        if (cpu->vcpu_id == vcpu_id) {
>>>   > -            int kvm_fd;
>>>   > -
>>>   > -            QLIST_REMOVE(cpu, node);
>>>   > -            kvm_fd = cpu->kvm_fd;
>>>   > -            g_free(cpu);
>>>   > -            return kvm_fd;
>>>   > -        }
>>>   > -    }
>>>   > -
>>>   > -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
>>>   > -}
>>>   > -
>>>   >   int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>>   >   {
>>>   >       KVMState *s = kvm_state;
>>>   > @@ -415,19 +451,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>>   >
>>>   >       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>>   >
>>>   > -    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>>>   > +    ret = kvm_create_vcpu(cpu);
>>>   >       if (ret < 0) {
>>>   > -        error_setg_errno(errp, -ret, "kvm_init_vcpu: 
>>> kvm_get_vcpu failed
>>>   (%lu)",
>>>   > +        error_setg_errno(errp, -ret,
>>>   > +                         "kvm_init_vcpu: kvm_create_vcpu failed
>>>   > + (%lu)",
>>>   >                            kvm_arch_vcpu_id(cpu));
>>>   >           goto err;
>>>   >       }
>>>   >
>>>   > -    cpu->kvm_fd = ret;
>>>   > -    cpu->kvm_state = s;
>>>   > -    cpu->vcpu_dirty = true;
>>>   > -    cpu->dirty_pages = 0;
>>>   > -    cpu->throttle_us_per_full = 0;
>>>   > -
>>>   >       mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>>>   >       if (mmap_size < 0) {
>>>   >           ret = mmap_size;
>>>   > diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h index
>>>   > ca40add32c..171b22fd29 100644
>>>   > --- a/accel/kvm/kvm-cpus.h
>>>   > +++ b/accel/kvm/kvm-cpus.h
>>>   > @@ -22,5 +22,4 @@ bool kvm_supports_guest_debug(void);
>>>   >   int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, 
>>> vaddr
>>>   len);
>>>   >   int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, 
>>> vaddr
>>>   len);
>>>   >   void kvm_remove_all_breakpoints(CPUState *cpu);
>>>   > -
>>>   >   #endif /* KVM_CPUS_H */
>>>   > diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events index
>>>   > 681ccb667d..37626c1ac5 100644
>>>   > --- a/accel/kvm/trace-events
>>>   > +++ b/accel/kvm/trace-events
>>>   > @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) 
>>> "dev fd
>>>   %d, type 0x%x, arg %p"
>>>   >   kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: 
>>> Unable to
>>>   retrieve ONEREG %" PRIu64 " from KVM: %s"
>>>   >   kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: 
>>> Unable to
>>>   set ONEREG %" PRIu64 " to KVM: %s"
>>>   >   kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: 
>>> %d id:
>>>   %lu"
>>>   > +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id, int
>>>   kvm_fd) "index: %d, id: %lu, kvm fd: %d"
>>>   > +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index:
>>>   %d id: %lu"
>>>   > +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d
>>>   id: %lu"
>>>   > +kvm_unpark_vcpu(unsigned long arch_cpu_id, const char *msg) "id: 
>>> %lu
>>>   %s"
>>>   >   kvm_irqchip_commit_routes(void) ""
>>>   >   kvm_irqchip_add_msi_route(char *name, int vector, int virq) 
>>> "dev %s
>>>   vector %d virq %d"
>>>   >   kvm_irqchip_update_msi_route(int virq) "Updating MSI route 
>>> virq=%d"
>>>   > @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>>>   >   kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped 
>>> %"PRIu64" pages
>>>   (took %"PRIi64" us)"
>>>   >   kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>>>   >   kvm_dirty_ring_flush(int finished) "%d"
>>>   > -kvm_destroy_vcpu(void) ""
>>>   >   kvm_failed_get_vcpu_mmap_size(void) ""
>>>   >   kvm_cpu_exec(void) ""
>>>   >   kvm_interrupt_exit_request(void) ""
>>>   > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h index
>>>   > c31d9c7356..c4a914b3d8 100644
>>>   > --- a/include/sysemu/kvm.h
>>>   > +++ b/include/sysemu/kvm.h
>>>   > @@ -313,6 +313,31 @@ int kvm_create_device(KVMState *s, uint64_t
>>>   type, bool test);
>>>   >    */
>>>   >   bool kvm_device_supported(int vmfd, uint64_t type);
>>>   >
>>>   > +/**
>>>   > + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
>>>   > + * @cpu: QOM CPUState object for which KVM vCPU has to be
>>>   fetched/created.
>>>   > + *
>>>   > + * @returns: 0 when success, errno (<0) when failed.
>>>   > + */
>>>   > +int kvm_create_vcpu(CPUState *cpu);
>>>   > +
>>>   > +/**
>>>   > + * kvm_park_vcpu - Park QEMU KVM vCPU context
>>>   > + * @cpu: QOM CPUState object for which QEMU KVM vCPU context has
>>>   to be parked.
>>>   > + *
>>>   > + * @returns: none
>>>   > + */
>>>   > +void kvm_park_vcpu(CPUState *cpu);
>>>   > +
>>>   > +/**
>>>   > + * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
>>>   > + * @s: KVM State
>>>   > + * @vcpu_id: Architecture vCPU ID of the parked vCPU
>>>   > + *
>>>   > + * @returns: KVM fd
>>>   > + */
>>>   > +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
>>>   > +
>>>   >   /* Arch specific hooks */
>>>   >
>>>   >   extern const KVMCapabilityInfo kvm_arch_required_capabilities[];

