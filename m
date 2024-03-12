Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BA3C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0yx-0006ha-M0; Tue, 12 Mar 2024 08:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rk0yp-0006fu-Bs; Tue, 12 Mar 2024 08:11:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rk0ym-0001rD-9V; Tue, 12 Mar 2024 08:11:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CBwIk2015591; Tue, 12 Mar 2024 12:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=h8BkAbvQQbrh30ngIqGo0XbgUAFC1m6wcHOoVqy8G6E=;
 b=J1B2Cw0VP415s3cPnBL1jCwSGVwv9mvdRH5uQPq1HdreaGSf7kfLEXdu5TVpzl45wqQV
 jG7QEPX9rbAon5oRxJptAclXFTsMiXFGL4qwSuDMc5ZltjD+2hc2jJYCeCz4rPbcygZS
 oOiT9dXsClLza7WSvv4+JJX7KqDqfOS8ass5JJt6AkP9v/QqOMakKpYiqtzIoHdWUaG6
 G5YxljQ8AlAWKQCk3YNwNt9ODQxBjrVZ2iC5RiSgfzRJ+Lw+0rnHafCT19pBnEhqYGiv
 j68M8OABvOyQjU8S0xsOKSYtrgGVuN5WgynuCXXLWNe8uB4zMfGdm3tpc/F7tPQ5/PLg ag== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtpmyr8gq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 12:11:24 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42CCBOct020883;
 Tue, 12 Mar 2024 12:11:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtpmyr8ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 12:11:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C9j09S020446; Tue, 12 Mar 2024 12:11:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3kkxs36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 12:11:23 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42CCBKji28705104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 12:11:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D5215803F;
 Tue, 12 Mar 2024 12:11:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0C6F5804E;
 Tue, 12 Mar 2024 12:11:15 +0000 (GMT)
Received: from [9.171.50.1] (unknown [9.171.50.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 12:11:15 +0000 (GMT)
Message-ID: <d7ca6bc6-ffe2-461f-b6b6-b4029f04f80f@linux.ibm.com>
Date: Tue, 12 Mar 2024 17:41:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] spapr: nested: Introduce cap-nested-papr for
 Nested PAPR API
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-15-harshpb@linux.ibm.com>
 <CZRQZUIK2SFV.1WJ6FACW9RGSQ@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZRQZUIK2SFV.1WJ6FACW9RGSQ@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O98sVOqKRT8nlCayn54ucx-tvC29ZA9D
X-Proofpoint-GUID: dvG9Gn0ZvfrKB08Vfo4pZKYJM1WrW3sK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120093
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

Hi Nick,

On 3/12/24 17:21, Nicholas Piggin wrote:
> On Fri Mar 8, 2024 at 9:19 PM AEST, Harsh Prateek Bora wrote:
>> Introduce a SPAPR capability cap-nested-papr which enables nested PAPR
>> API for nested guests. This new API is to enable support for KVM on PowerVM
>> and the support in Linux kernel has already merged upstream.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   include/hw/ppc/spapr.h |  6 +++-
>>   hw/ppc/spapr.c         |  2 ++
>>   hw/ppc/spapr_caps.c    | 62 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/ppc/spapr_nested.c  |  8 ++++--
>>   4 files changed, 74 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 6223873641..4aaf23d28f 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -81,8 +81,10 @@ typedef enum {
>>   #define SPAPR_CAP_RPT_INVALIDATE        0x0B
>>   /* Support for AIL modes */
>>   #define SPAPR_CAP_AIL_MODE_3            0x0C
>> +/* Nested PAPR */
>> +#define SPAPR_CAP_NESTED_PAPR           0x0D
>>   /* Num Caps */
>> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
>> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
>>   
>>   /*
>>    * Capability Values
>> @@ -592,6 +594,7 @@ struct SpaprMachineState {
>>   #define H_GUEST_CREATE_VCPU      0x474
>>   #define H_GUEST_GET_STATE        0x478
>>   #define H_GUEST_SET_STATE        0x47C
>> +#define H_GUEST_RUN_VCPU         0x480
>>   #define H_GUEST_DELETE           0x488
>>   
>>   #define MAX_HCALL_OPCODE         H_GUEST_DELETE
>> @@ -996,6 +999,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbbc;
>>   extern const VMStateDescription vmstate_spapr_cap_ibs;
>>   extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
>>   extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>> +extern const VMStateDescription vmstate_spapr_cap_nested_papr;
>>   extern const VMStateDescription vmstate_spapr_cap_large_decr;
>>   extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>>   extern const VMStateDescription vmstate_spapr_cap_fwnmi;
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 54fc01e462..beb23fae8f 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2121,6 +2121,7 @@ static const VMStateDescription vmstate_spapr = {
>>           &vmstate_spapr_cap_fwnmi,
>>           &vmstate_spapr_fwnmi,
>>           &vmstate_spapr_cap_rpt_invalidate,
>> +        &vmstate_spapr_cap_nested_papr,
>>           NULL
>>       }
>>   };
>> @@ -4687,6 +4688,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>       smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_WORKAROUND;
>>       smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
>>       smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>> +    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] = SPAPR_CAP_OFF;
>>       smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>       smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
>>       smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index e889244e52..d6d5a6b8df 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -487,6 +487,58 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
>>               error_append_hint(errp, "Try appending -machine cap-nested-hv=off "
>>                                       "or use threads=1 with -smp\n");
>>           }
>> +        if (spapr_nested_api(spapr) &&
>> +            spapr_nested_api(spapr) != NESTED_API_KVM_HV) {
>> +            error_setg(errp, "Nested-HV APIs are mutually exclusive/incompatible");
>> +            error_append_hint(errp, "Please use either cap-nested-hv or "
>> +                                    "cap-nested-papr to proceed.\n");
>> +            return;
>> +        } else {
>> +            spapr->nested.api = NESTED_API_KVM_HV;
>> +        }
>> +    }
>> +}
>> +
>> +static void cap_nested_papr_apply(SpaprMachineState *spapr,
>> +                                    uint8_t val, Error **errp)
>> +{
>> +    ERRP_GUARD();
>> +    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>> +    CPUPPCState *env = &cpu->env;
>> +
>> +    if (!val) {
>> +        /* capability disabled by default */
>> +        return;
>> +    }
>> +
>> +    if (tcg_enabled()) {
>> +        if (!(env->insns_flags2 & PPC2_ISA300)) {
>> +            error_setg(errp, "Nested-PAPR only supported on POWER9 and later");
>> +            error_append_hint(errp,
>> +                              "Try appending -machine cap-nested-papr=off\n");
>> +            return;
>> +        }
>> +        if (spapr_nested_api(spapr) &&
>> +            spapr_nested_api(spapr) != NESTED_API_PAPR) {
>> +            error_setg(errp, "Nested-HV APIs are mutually exclusive/incompatible");
>> +            error_append_hint(errp, "Please use either cap-nested-hv or "
>> +                                    "cap-nested-papr to proceed.\n");
>> +            return;
>> +        } else {
>> +            spapr->nested.api = NESTED_API_PAPR;
>> +        }
>> +
>> +    } else if (kvm_enabled()) {
>> +        /*
>> +         * this gets executed in L1 qemu when L2 is launched,
>> +         * needs kvm-hv support in L1 kernel.
>> +         */
>> +        if (!kvmppc_has_cap_nested_kvm_hv()) {
>> +            error_setg(errp,
>> +                       "KVM implementation does not support Nested-HV");
>> +        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
>> +            error_setg(errp, "Error enabling Nested-HV with KVM");
>> +        }
> 
> I'll just disable this on KVM for now. With that changed,
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 

AFAIK, v2 api also expects this capability to be enabled on L1 kernel.
I guess the reason is the L1 implementation has used the same capab and
extended to be used with v2 api. So, this check is needed in L1 Qemu for
now. We may revisit L1 implementation later to see if a change is
appropriate.

regards,
Harsh

>>       }
>>   }
>>   
>> @@ -735,6 +787,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>           .type = "bool",
>>           .apply = cap_nested_kvm_hv_apply,
>>       },
>> +    [SPAPR_CAP_NESTED_PAPR] = {
>> +        .name = "nested-papr",
>> +        .description = "Allow Nested HV (PAPR API)",
>> +        .index = SPAPR_CAP_NESTED_PAPR,
>> +        .get = spapr_cap_get_bool,
>> +        .set = spapr_cap_set_bool,
>> +        .type = "bool",
>> +        .apply = cap_nested_papr_apply,
>> +    },
>>       [SPAPR_CAP_LARGE_DECREMENTER] = {
>>           .name = "large-decr",
>>           .description = "Allow Large Decrementer",
>> @@ -919,6 +980,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>>   SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>>   SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>>   SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>> +SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
>>   SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>>   SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>>   SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index 597dba7fdc..8db9dc19e3 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -13,13 +13,15 @@
>>   void spapr_nested_reset(SpaprMachineState *spapr)
>>   {
>>       if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
>> -        spapr->nested.api = NESTED_API_KVM_HV;
>>           spapr_unregister_nested_hv();
>>           spapr_register_nested_hv();
>> -    } else {
>> -        spapr->nested.api = 0;
>> +    } else if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_PAPR)) {
>>           spapr->nested.capabilities_set = false;
>> +        spapr_unregister_nested_papr();
>> +        spapr_register_nested_papr();
>>           spapr_nested_gsb_init();
>> +    } else {
>> +        spapr->nested.api = 0;
>>       }
>>   }
>>   
> 

