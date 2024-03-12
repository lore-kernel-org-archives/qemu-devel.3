Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BA7C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk223-0008AZ-N0; Tue, 12 Mar 2024 09:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rk21t-00087s-9s; Tue, 12 Mar 2024 09:18:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rk21q-0007eL-KE; Tue, 12 Mar 2024 09:18:53 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CD6An6027646; Tue, 12 Mar 2024 13:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EgAv+/NYSPVcKdE5keF3JTNIvvSQhtMWR+CfzZZ4fKs=;
 b=sRQpbYi295UFbOSfeBwGdlZvSEVPY72Eyqx5tXpqoK7Ya5mxjW2dsXytVobvjVq5IDeD
 Df59juBtNsIG+DWk+jiY2pY/3kMF89ClrbbTNTgiAnxRIWsd/cl3dlWtIqqxEYN4E7YN
 1zION4rNvonMQxL3PBla9Geib1jeKP2fULJmvulMa2glVPvcljGSSpEQgfuDatCbY4ox
 pEi46bUjX4Kft8w4uUuqPFCBi/F7DZJ5FJTCmQfvB1vAJ7cuo6760LgtJQr1Knw4bQ4o
 Fp7SSHuLo8+Y4GPImf3NvmH31xxrHGueNglt9o0iyG9Ozlw6ar5A9xmYc/NKqlFWKAMw pw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtq79rny5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:18:37 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42CD6EW7028160;
 Tue, 12 Mar 2024 13:18:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtq79rnxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:18:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CDFbvT020437; Tue, 12 Mar 2024 13:18:36 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3kky2qt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:18:36 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42CDIWsg21627268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 13:18:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF11358055;
 Tue, 12 Mar 2024 13:18:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1952D5804B;
 Tue, 12 Mar 2024 13:18:29 +0000 (GMT)
Received: from [9.171.52.145] (unknown [9.171.52.145])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 13:18:28 +0000 (GMT)
Message-ID: <c374d5f6-c99e-44ed-8e4e-09eb8e80e721@linux.ibm.com>
Date: Tue, 12 Mar 2024 18:48:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] spapr: nested: Introduce cap-nested-papr for
 Nested PAPR API
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-15-harshpb@linux.ibm.com>
 <CZRQZUIK2SFV.1WJ6FACW9RGSQ@wheely>
 <d7ca6bc6-ffe2-461f-b6b6-b4029f04f80f@linux.ibm.com>
 <85ef9f8f-15be-4c4c-aa25-ed9a8960b48f@linux.ibm.com>
 <c8f6dc45-33e0-431d-8650-bb7e7f516b54@linux.ibm.com>
In-Reply-To: <c8f6dc45-33e0-431d-8650-bb7e7f516b54@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ETYrbnWyvsjolAs0CdkeeYZN1-dav0Mi
X-Proofpoint-GUID: yw_m6Mweg0MJxiipJkjJ4k-PXzgvZl_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403120102
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Updated incremental fix below:

On 3/12/24 18:21, Harsh Prateek Bora wrote:
> 
> 
> On 3/12/24 18:17, Harsh Prateek Bora wrote:
>> Hi Nick,
>>
>> On 3/12/24 17:41, Harsh Prateek Bora wrote:
>>> Hi Nick,
>>>
>>> On 3/12/24 17:21, Nicholas Piggin wrote:
>>>> On Fri Mar 8, 2024 at 9:19 PM AEST, Harsh Prateek Bora wrote:
>>>>> Introduce a SPAPR capability cap-nested-papr which enables nested PAPR
>>>>> API for nested guests. This new API is to enable support for KVM on 
>>>>> PowerVM
>>>>> and the support in Linux kernel has already merged upstream.
>>>>>
>>>>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>>>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>>> ---
>>>>>   include/hw/ppc/spapr.h |  6 +++-
>>>>>   hw/ppc/spapr.c         |  2 ++
>>>>>   hw/ppc/spapr_caps.c    | 62 
>>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>>   hw/ppc/spapr_nested.c  |  8 ++++--
>>>>>   4 files changed, 74 insertions(+), 4 deletions(-)
>>>>>

<snip>

>>>>> +static void cap_nested_papr_apply(SpaprMachineState *spapr,
>>>>> +                                    uint8_t val, Error **errp)
>>>>> +{
>>>>> +    ERRP_GUARD();
>>>>> +    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>>>>> +    CPUPPCState *env = &cpu->env;
>>>>> +
>>>>> +    if (!val) {
>>>>> +        /* capability disabled by default */
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    if (tcg_enabled()) {
>>>>> +        if (!(env->insns_flags2 & PPC2_ISA300)) {
>>>>> +            error_setg(errp, "Nested-PAPR only supported on POWER9 
>>>>> and later");
>>>>> +            error_append_hint(errp,
>>>>> +                              "Try appending -machine 
>>>>> cap-nested-papr=off\n");
>>>>> +            return;
>>>>> +        }
>>>>> +        if (spapr_nested_api(spapr) &&
>>>>> +            spapr_nested_api(spapr) != NESTED_API_PAPR) {
>>>>> +            error_setg(errp, "Nested-HV APIs are mutually 
>>>>> exclusive/incompatible");
>>>>> +            error_append_hint(errp, "Please use either 
>>>>> cap-nested-hv or "
>>>>> +                                    "cap-nested-papr to proceed.\n");
>>>>> +            return;
>>>>> +        } else {
>>>>> +            spapr->nested.api = NESTED_API_PAPR;
>>>>> +        }
>>>>> +
>>>>> +    } else if (kvm_enabled()) {
>>>>> +        /*
>>>>> +         * this gets executed in L1 qemu when L2 is launched,
>>>>> +         * needs kvm-hv support in L1 kernel.
>>>>> +         */
>>>>> +        if (!kvmppc_has_cap_nested_kvm_hv()) {
>>>>> +            error_setg(errp,
>>>>> +                       "KVM implementation does not support 
>>>>> Nested-HV");
>>>>> +        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
>>>>> +            error_setg(errp, "Error enabling Nested-HV with KVM");
>>>>> +        }
>>>>
>>>> I'll just disable this on KVM for now. With that changed,
>>>>
>>>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>>>>
>>>
>>> AFAIK, v2 api also expects this capability to be enabled on L1 kernel.
>>> I guess the reason is the L1 implementation has used the same capab and
>>> extended to be used with v2 api. So, this check is needed in L1 Qemu for
>>> now. We may revisit L1 implementation later to see if a change is
>>> appropriate.
>>
>> Please ignore above response. I think my observation was based on 
>> older version of L1 implementation. This doesnt seem to be an issue 
>> with upstream L1. You may disable the kvm_enabled() path for now. I 
>> just tested and it works fine.
> 
> Here's the incremental fix:
> 

Updated to keep error_setg for kvm_enabled() case:

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index d6d5a6b8df..92d8966d60 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -527,18 +527,9 @@ static void cap_nested_papr_apply(SpaprMachineState 
*spapr,
          } else {
              spapr->nested.api = NESTED_API_PAPR;
          }
-
      } else if (kvm_enabled()) {
-        /*
-         * this gets executed in L1 qemu when L2 is launched,
-         * needs kvm-hv support in L1 kernel.
-         */
-        if (!kvmppc_has_cap_nested_kvm_hv()) {
              error_setg(errp,
-                       "KVM implementation does not support Nested-HV");
-        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
-            error_setg(errp, "Error enabling Nested-HV with KVM");
-        }
+                       "KVM implementation does not support Nested-PAPR");
      }
  }



> 
> regards,
> Harsh
>>
>> regards,
>> Harsh
>>
>>>
>>> regards,
>>> Harsh
>>>
>>>>>       }
>>>>>   }
>>>>> @@ -735,6 +787,15 @@ SpaprCapabilityInfo 
>>>>> capability_table[SPAPR_CAP_NUM] = {
>>>>>           .type = "bool",
>>>>>           .apply = cap_nested_kvm_hv_apply,
>>>>>       },
>>>>> +    [SPAPR_CAP_NESTED_PAPR] = {
>>>>> +        .name = "nested-papr",
>>>>> +        .description = "Allow Nested HV (PAPR API)",
>>>>> +        .index = SPAPR_CAP_NESTED_PAPR,
>>>>> +        .get = spapr_cap_get_bool,
>>>>> +        .set = spapr_cap_set_bool,
>>>>> +        .type = "bool",
>>>>> +        .apply = cap_nested_papr_apply,
>>>>> +    },
>>>>>       [SPAPR_CAP_LARGE_DECREMENTER] = {
>>>>>           .name = "large-decr",
>>>>>           .description = "Allow Large Decrementer",
>>>>> @@ -919,6 +980,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>>>>>   SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>>>>>   SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>>>>>   SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>>>>> +SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
>>>>>   SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>>>>>   SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>>>>>   SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
>>>>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>>>>> index 597dba7fdc..8db9dc19e3 100644
>>>>> --- a/hw/ppc/spapr_nested.c
>>>>> +++ b/hw/ppc/spapr_nested.c
>>>>> @@ -13,13 +13,15 @@
>>>>>   void spapr_nested_reset(SpaprMachineState *spapr)
>>>>>   {
>>>>>       if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
>>>>> -        spapr->nested.api = NESTED_API_KVM_HV;
>>>>>           spapr_unregister_nested_hv();
>>>>>           spapr_register_nested_hv();
>>>>> -    } else {
>>>>> -        spapr->nested.api = 0;
>>>>> +    } else if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_PAPR)) {
>>>>>           spapr->nested.capabilities_set = false;
>>>>> +        spapr_unregister_nested_papr();
>>>>> +        spapr_register_nested_papr();
>>>>>           spapr_nested_gsb_init();
>>>>> +    } else {
>>>>> +        spapr->nested.api = 0;
>>>>>       }
>>>>>   }
>>>>
> 

