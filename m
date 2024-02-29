Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC776C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfctT-0008Tu-13; Thu, 29 Feb 2024 04:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rfctO-0008TD-63; Thu, 29 Feb 2024 04:39:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rfctI-0006E3-Tb; Thu, 29 Feb 2024 04:39:52 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41T9BOCU011384; Thu, 29 Feb 2024 09:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LzyOsFqOqgVd6kGTYA1eer87ZhEKX0X6sNoE4rDJctA=;
 b=E9COtw4JLgDSZUvPt9/jQt4FLNxg6kqVINbWfCx0kbNAEJLOeyO3uaPs0rKI8JfZmzqy
 kfYepDghoVKOiaZQsh24SaEdlH/Xv8DX0Xsf/FOXvkq47e6e3DxgGH0kBMpVfDouLNf6
 KsswBgkTRkB5J/pAoiPeDbY5+e/bb0jBXQkvCJ1CxS+yjPuujbi1UGUGDnZEr836H3yx
 Ja5uPGBXjfzsw/QfLb1pU30jlQCGQtUypq0dOVh431ROmqXDSK5q6wyu87YRoO9MlXXE
 ZthAsZgeRztNE72aKj4+0f9mgb05wT+YErukswUVQ3ZGKO8x9dx1S5kAWRXvGEqFdyem kw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjpxg0yh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 09:39:44 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41T9VJsa019248;
 Thu, 29 Feb 2024 09:39:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjpxg0ygr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 09:39:44 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41T8d4Q2008189; Thu, 29 Feb 2024 09:39:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mm7vq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 09:39:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41T9deMA28574256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 09:39:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4531358055;
 Thu, 29 Feb 2024 09:39:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70B2058061;
 Thu, 29 Feb 2024 09:39:37 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Feb 2024 09:39:37 +0000 (GMT)
Message-ID: <d2c647c1-58bc-4073-b26c-54190e18ab82@linux.ibm.com>
Date: Thu, 29 Feb 2024 15:09:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] spapr: nested: Introduce H_GUEST_CREATE_VCPU
 hcall.
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-9-harshpb@linux.ibm.com>
 <CZFROUOXN7EA.3OBIZUXJPUNH5@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZFROUOXN7EA.3OBIZUXJPUNH5@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kgSVDBYiH4C42JVVdb3My9TDOf-FYduS
X-Proofpoint-ORIG-GUID: Od_cHSMZyQTFP-edMAIS1xZXAyLjyszF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2/27/24 15:21, Nicholas Piggin wrote:
> On Tue Feb 20, 2024 at 6:36 PM AEST, Harsh Prateek Bora wrote:
>> Introduce the nested PAPR hcall H_GUEST_CREATE_VCPU which is used to
>> create and initialize the specified VCPU resource for the previously
>> created guest. Each guest can have multiple VCPUs upto max 2048.
>> All VCPUs for a guest gets deallocated on guest delete.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   include/hw/ppc/spapr.h        |  2 +
>>   include/hw/ppc/spapr_nested.h | 10 ++++
>>   hw/ppc/spapr_nested.c         | 96 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 108 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index c4a79a1785..82b077bdd2 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -365,6 +365,7 @@ struct SpaprMachineState {
>>   #define H_UNSUPPORTED     -67
>>   #define H_OVERLAP         -68
>>   #define H_STATE           -75
>> +#define H_IN_USE          -77
>>   #define H_UNSUPPORTED_FLAG -256
>>   #define H_MULTI_THREADS_ACTIVE -9005
>>   
>> @@ -587,6 +588,7 @@ struct SpaprMachineState {
>>   #define H_GUEST_GET_CAPABILITIES 0x460
>>   #define H_GUEST_SET_CAPABILITIES 0x464
>>   #define H_GUEST_CREATE           0x470
>> +#define H_GUEST_CREATE_VCPU      0x474
>>   #define H_GUEST_DELETE           0x488
>>   
>>   #define MAX_HCALL_OPCODE         H_GUEST_DELETE
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index f282479275..24e87bca08 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -14,6 +14,8 @@ typedef struct SpaprMachineStateNested {
>>   
>>   typedef struct SpaprMachineStateNestedGuest {
>>       uint32_t pvr_logical;
>> +    unsigned long vcpus;
>> +    struct SpaprMachineStateNestedGuestVcpu *vcpu;
>>   } SpaprMachineStateNestedGuest;
>>   
>>   /* Nested PAPR API related macros */
>> @@ -27,6 +29,7 @@ typedef struct SpaprMachineStateNestedGuest {
>>   #define H_GUEST_CAP_P10_MODE_BMAP     2
>>   #define PAPR_NESTED_GUEST_MAX         4096
>>   #define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
>> +#define PAPR_NESTED_GUEST_VCPU_MAX    2048
>>   
>>   /*
>>    * Register state for entering a nested guest with H_ENTER_NESTED.
>> @@ -118,8 +121,15 @@ struct nested_ppc_state {
>>       uint64_t ppr;
>>   
>>       int64_t tb_offset;
>> +    /* Nested PAPR API */
>> +    uint64_t pvr;
>>   };
>>   
>> +typedef struct SpaprMachineStateNestedGuestVcpu {
>> +    bool enabled;
>> +    struct nested_ppc_state state;
>> +} SpaprMachineStateNestedGuestVcpu;
>> +
>>   void spapr_exit_nested(PowerPCCPU *cpu, int excp);
>>   typedef struct SpaprMachineState SpaprMachineState;
>>   bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index 09c4a35908..3cc704adda 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -428,6 +428,41 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>>       }
>>   }
>>   
>> +static
>> +SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
>> +                                                     target_ulong guestid)
>> +{
>> +    SpaprMachineStateNestedGuest *guest;
>> +
>> +    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(guestid));
>> +    return guest;
>> +}
>> +
>> +static bool spapr_nested_vcpu_check(SpaprMachineStateNestedGuest *guest,
>> +                                    target_ulong vcpuid)
>> +{
>> +    struct SpaprMachineStateNestedGuestVcpu *vcpu;
>> +    /*
>> +     * Perform sanity checks for the provided vcpuid of a guest.
>> +     * For now, ensure its valid, allocated and enabled for use.
>> +     */
>> +
>> +    if (vcpuid >= PAPR_NESTED_GUEST_VCPU_MAX) {
>> +        return false;
>> +    }
>> +
>> +    if (!(vcpuid < guest->vcpus)) {
>> +        return false;
>> +    }
>> +
>> +    vcpu = &guest->vcpu[vcpuid];
>> +    if (!vcpu->enabled) {
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
>>                                                SpaprMachineState *spapr,
>>                                                target_ulong opcode,
>> @@ -518,6 +553,7 @@ static void
>>   destroy_guest_helper(gpointer value)
>>   {
>>       struct SpaprMachineStateNestedGuest *guest = value;
>> +    g_free(guest->vcpu);
>>       g_free(guest);
>>   }
>>   
>> @@ -613,6 +649,65 @@ static target_ulong h_guest_delete(PowerPCCPU *cpu,
>>       return H_SUCCESS;
>>   }
>>   
>> +static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
>> +                                        SpaprMachineState *spapr,
>> +                                        target_ulong opcode,
>> +                                        target_ulong *args)
>> +{
>> +    CPUPPCState *env = &cpu->env;
>> +    struct nested_ppc_state *l2_state;
>> +    target_ulong flags = args[0];
>> +    target_ulong guestid = args[1];
>> +    target_ulong vcpuid = args[2];
>> +    SpaprMachineStateNestedGuest *guest;
>> +
>> +    if (flags) { /* don't handle any flags for now */
>> +        return H_UNSUPPORTED_FLAG;
>> +    }
>> +
>> +    guest = spapr_get_nested_guest(spapr, guestid);
>> +    if (!guest) {
>> +        return H_P2;
>> +    }
>> +
>> +    if (vcpuid < guest->vcpus) {
>> +        return H_IN_USE;
>> +    }
> 
> Linear allocation isn't really a constraint of the API right? I
> would add an UNIMP log message to say what the problem is otherwise
> hypervisor developer might struggle to understand the problem.
> 

Sure, will add an UNIMP log msg and move the below assert up here.

>> +
>> +    if (guest->vcpus >= PAPR_NESTED_GUEST_VCPU_MAX) {
>> +        return H_P3;
>> +    }
>> +
>> +    if (guest->vcpus) {
>> +        SpaprMachineStateNestedGuestVcpu *vcpus;
>> +        vcpus = g_try_renew(struct SpaprMachineStateNestedGuestVcpu,
>> +                            guest->vcpu,
>> +                            guest->vcpus + 1);
>> +        if (!vcpus) {
>> +            return H_NO_MEM;
>> +        }
>> +        memset(&vcpus[guest->vcpus], 0,
>> +               sizeof(SpaprMachineStateNestedGuestVcpu));
>> +        guest->vcpu = vcpus;
>> +    } else {
>> +        guest->vcpu = g_try_new0(SpaprMachineStateNestedGuestVcpu, 1);
>> +        if (guest->vcpu == NULL) {
>> +            return H_NO_MEM;
>> +        }
>> +    }
> 
> g_try_renew works with NULL AFAIKS, so no need for the branch. I would
> also create a local variable for the new nested guest vcpu created
> here so you only have to index it once.
> 

Ok, will update.

>> +    l2_state = &guest->vcpu[guest->vcpus].state;
>> +    guest->vcpus++;
>> +    assert(vcpuid < guest->vcpus); /* linear vcpuid allocation only */
> 
> Target can trigger this assert if using a smaller vcpu id number than
> already allocated? I would check above that it is exactly equal to
> vcpus, and remove it from here.

Moving up as suggested.

> 
>> +    /* Set L1 PVR as L2 default */
>> +    l2_state->pvr = env->spr[SPR_PVR];
> 
> Why is this here and not in H_GUEST_CREATE? I think you can use pcc->pvr
> for this?
> 
This is vcpu specific nested_ppc_state which needs to be initialized on 
vcpu creation. We can assign it to spapr->nested.pvr_base as well.

>> +    guest->vcpu[vcpuid].enabled = true;
>> +
>> +    if (!spapr_nested_vcpu_check(guest, vcpuid)) {
>> +        return H_PARAMETER;
>> +    }
> 
> This doesn't clean up on failure. Just remove "sanity" checks if they
> are already checked in the same function. Any useful ones should be
> properly hanlded or done before cleanup is needed.

We can actually remove this sanity check since it is already taken care 
above and move this helper in a later patch where used.

> 
> If you're respinning could you call vcpus nr_vcpus, then call vcpu
> (the array of vcpus) vcpus.

Sure, will update.

> 
> Thanks,
> Nick

