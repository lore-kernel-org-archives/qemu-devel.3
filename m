Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE5AC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQ6W-0001wz-V0; Tue, 05 Mar 2024 03:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rhQ6V-0001tL-7d; Tue, 05 Mar 2024 03:24:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rhQ6T-00065e-0k; Tue, 05 Mar 2024 03:24:50 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4258CYV9027906; Tue, 5 Mar 2024 08:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5loK+Mn5osnSFm2O7VOBgMZsOFa5THJOPY+KpquOHkE=;
 b=ZRQYNz/A3aFWuzqSa/ng+HMXJxF6wYtZfhdGJixr6YH2uLwWrES8CfvzbsiHqoObshxW
 +ICGK+mr/ttFeQJbgXx1NPIRZBxdhUX8fhlK3sX4kyzaY2HikYgIt1qDDvOhroF07NyQ
 +8w782W3zpeJ7lYEjdr7FGJgDC/kNWg/2Xwxih5yMlN9EyRtiuLRfVdAnTiBnWyomb5E
 cdaed/IyhzrZwakGQpgDlqDJORpkKrgulC/ZllSb8/ATaPj7oqLXCi0TnXg56gL9LFTy
 HseFJJ2m4ipZf06l4SOZg6o9nsYvA+eC03ObFAS+7bj8THjhrOYNbVqBm4WZYohnwf/O 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnyp8g8n5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 08:24:42 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4258CkbH028339;
 Tue, 5 Mar 2024 08:24:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnyp8g83q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 08:24:31 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4258GBHe026216; Tue, 5 Mar 2024 08:24:22 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfenp7pf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 08:24:22 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4258OJvl21627592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Mar 2024 08:24:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73D0858055;
 Tue,  5 Mar 2024 08:24:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B16875805D;
 Tue,  5 Mar 2024 08:24:16 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Mar 2024 08:24:16 +0000 (GMT)
Message-ID: <2f21d567-6f24-4dc4-8265-cf4c95f0561f@linux.ibm.com>
Date: Tue, 5 Mar 2024 13:54:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] spapr: nested: Introduce cap-nested-papr for
 Nested PAPR API
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-15-harshpb@linux.ibm.com>
 <CZFSC6VAMZY1.3ULCR8539CKCF@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZFSC6VAMZY1.3ULCR8539CKCF@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nQGmUT6IbFv-VZ59zfD_yBC5GaoeZhjF
X-Proofpoint-GUID: L5LxYDYuDRtmt3yDYKLSRWcbPc9cO4-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_05,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403050065
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 2/27/24 15:52, Nicholas Piggin wrote:
> On Tue Feb 20, 2024 at 6:36 PM AEST, Harsh Prateek Bora wrote:
>> Introduce a SPAPR capability cap-nested-papr which enables nested PAPR
>> API for nested guests. This new API is to enable support for KVM on PowerVM
>> and the support in Linux kernel has already merged upstream.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   include/hw/ppc/spapr.h |  6 ++++-
>>   hw/ppc/spapr.c         |  2 ++
>>   hw/ppc/spapr_caps.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/ppc/spapr_nested.c  | 19 ++++++++++++--
>>   4 files changed, 80 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 036a7db2bc..1b1d37123a 100644
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
>> @@ -994,6 +996,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbbc;
>>   extern const VMStateDescription vmstate_spapr_cap_ibs;
>>   extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
>>   extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>> +extern const VMStateDescription vmstate_spapr_cap_nested_papr;
>>   extern const VMStateDescription vmstate_spapr_cap_large_decr;
>>   extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>>   extern const VMStateDescription vmstate_spapr_cap_fwnmi;
>> @@ -1041,5 +1044,6 @@ void spapr_watchdog_init(SpaprMachineState *spapr);
>>   void spapr_register_nested_hv(void);
>>   void spapr_unregister_nested_hv(void);
>>   void spapr_register_nested_papr(void);
>> +void spapr_unregister_nested_papr(void);
>>   
>>   #endif /* HW_SPAPR_H */
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 3453b30a57..cb556ae6a8 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2120,6 +2120,7 @@ static const VMStateDescription vmstate_spapr = {
>>           &vmstate_spapr_cap_fwnmi,
>>           &vmstate_spapr_fwnmi,
>>           &vmstate_spapr_cap_rpt_invalidate,
>> +        &vmstate_spapr_cap_nested_papr,
>>           NULL
>>       }
>>   };
>> @@ -4688,6 +4689,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>       smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_WORKAROUND;
>>       smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
>>       smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>> +    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] = SPAPR_CAP_OFF;
>>       smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>       smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
>>       smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index 721ddad23b..9a29ce1872 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -487,12 +487,58 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
>>               error_append_hint(errp, "Try appending -machine cap-nested-hv=off "
>>                                       "or use threads=1 with -smp\n");
>>           }
>> +        if (spapr->nested.api) {
>> +            warn_report("nested.api already set as %d, re-init to kvm-hv",
>> +                        spapr->nested.api);
>> +        }
> 
> Does this warning trigger when you reset the machine?
> 
> It's trying to catch both caps enabled? I would make that an error and
> fail and tell user to enable only one or the other.
> 
> (In a future patch I think we should try permit both to be enabled at
> the same time, but for now restricting it is fine)

Yeh, we had kept it mutually exclusive initially in v1, and looks like 
we want it to be exclusive for now. Future possibilities can be explored 
later as suggested.


> 
>>           spapr->nested.api = NESTED_API_KVM_HV;
>>           spapr_unregister_nested_hv(); /* reset across reboots */
>>           spapr_register_nested_hv();
>>       }
>>   }
>>   
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
>> +    }
>> +    if (spapr->nested.api) {
>> +        warn_report("nested.api already set as %d, re-init to nested-papr",
>> +                    spapr->nested.api);
>> +    }
>> +    spapr->nested.api = NESTED_API_PAPR;
>> +    spapr->nested.capabilities_set = false;
>> +    spapr_unregister_nested_papr(); /* reset across reboots */
>> +    spapr_register_nested_papr();
>> +    spapr_nested_gsb_init();
>> +}
>> +
>>   static void cap_large_decr_apply(SpaprMachineState *spapr,
>>                                    uint8_t val, Error **errp)
>>   {
>> @@ -738,6 +784,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
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
>> @@ -922,6 +977,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>>   SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>>   SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>>   SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>> +SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
>>   SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>>   SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>>   SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index db1c59a8f5..6e6a90616e 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -13,8 +13,6 @@
>>   void spapr_nested_init(SpaprMachineState *spapr)
>>   {
>>       spapr->nested.api = 0;
>> -    spapr->nested.capabilities_set = false;
>> -    spapr_nested_gsb_init();
>>   }
>>   
>>   uint8_t spapr_nested_api(SpaprMachineState *spapr)
>> @@ -1821,6 +1819,18 @@ void spapr_register_nested_papr(void)
>>       spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu);
>>   }
>>   
>> +void spapr_unregister_nested_papr(void)
>> +{
>> +    spapr_unregister_hypercall(H_GUEST_GET_CAPABILITIES);
>> +    spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
>> +    spapr_unregister_hypercall(H_GUEST_CREATE);
>> +    spapr_unregister_hypercall(H_GUEST_DELETE);
>> +    spapr_unregister_hypercall(H_GUEST_CREATE_VCPU);
>> +    spapr_unregister_hypercall(H_GUEST_SET_STATE);
>> +    spapr_unregister_hypercall(H_GUEST_GET_STATE);
>> +    spapr_unregister_hypercall(H_GUEST_RUN_VCPU);
>> +}
> 
> Oh they all came at once here.
> 
> And... you're not doing the same thing with the register_hypercall I
> guess because then you have function defined but not used warnings?
> I would just add the unregister in the same patches that add the
> register.

Yeh, v5 shall have unregistrations and registrations for each hcall 
together.

regards,
Harsh
> 
> Thanks,
> Nick

