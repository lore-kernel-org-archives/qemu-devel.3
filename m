Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B88C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcw5-0001jG-FW; Thu, 29 Feb 2024 04:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rfcw4-0001io-35; Thu, 29 Feb 2024 04:42:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rfcw2-0006i4-2a; Thu, 29 Feb 2024 04:42:39 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41T8veMD017474; Thu, 29 Feb 2024 09:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QkcijYIlcaJTZATKx2jwtNiYgU197S0XL8sGkZ2Z67c=;
 b=Uvk2BpBYubtThMFGPnWLr3D/taSj5Z58Bd9p8VYVgHuSEJ1m+1tfiUN/85vug2y+1iV8
 nCHcHPhyRM3T571a1gYryd+FKI+Xc3ebmkDfgvy4qjGFBXtvRc78FyO1vY65Lya9EE1Y
 3t28ARYpyRII5lPvQ19SZvEZHVzNp6eNCMjb5kmj27DGbkstStPkjOkHJZpa7kdbc1Zn
 JOK3aShoFySDnE9veoWbMMQM2/VjqpU6D7+mewLi/8Azr1djDmt8pmWTxEQrG3Fg4UwR
 lWCkIKHx667wJdzEi7Zhk4rDXckWNo9LTD8h6Eq9KS8vomg3uC+rk5MKT66W9nfejIy2 fA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjpv5sc9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 09:42:34 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41T9VbT9005142;
 Thu, 29 Feb 2024 09:42:33 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjpv5sc8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 09:42:33 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41T850kB008808; Thu, 29 Feb 2024 09:42:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftstvpdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 09:42:32 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41T9gSuH44040950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 09:42:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1CAA58068;
 Thu, 29 Feb 2024 09:42:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAB9C58063;
 Thu, 29 Feb 2024 09:42:25 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Feb 2024 09:42:25 +0000 (GMT)
Message-ID: <a24e18cb-85b5-47b3-ad61-cd9aaaec17fc@linux.ibm.com>
Date: Thu, 29 Feb 2024 15:12:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] spapr: nested: Extend nested_ppc_state for
 nested PAPR API
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-10-harshpb@linux.ibm.com>
 <CZFRUDQEDISV.EXR9E2TZQDP4@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZFRUDQEDISV.EXR9E2TZQDP4@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DLdD9NGAbZoixIBUlQLO3yKp7fV6oANR
X-Proofpoint-ORIG-GUID: -Uux8MasuBsJXKQIohCW0OBTgysqvixF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290072
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



On 2/27/24 15:29, Nicholas Piggin wrote:
> On Tue Feb 20, 2024 at 6:36 PM AEST, Harsh Prateek Bora wrote:
>> Currently, nested_ppc_state stores a certain set of registers and works
>> with nested_[load|save]_state() for state transfer as reqd for nested-hv API.
>> Extending these with additional registers state as reqd for nested PAPR API.
>>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   include/hw/ppc/spapr_nested.h |  49 ++++++++++++++++
>>   target/ppc/cpu.h              |   2 +
>>   hw/ppc/spapr_nested.c         | 106 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 157 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index 24e87bca08..a3b61eb79a 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -7,6 +7,7 @@ typedef struct SpaprMachineStateNested {
>>       uint64_t ptcr;
>>       uint8_t api;
>>   #define NESTED_API_KVM_HV  1
>> +#define NESTED_API_PAPR    2
>>       bool capabilities_set;
>>       uint32_t pvr_base;
>>       GHashTable *guests;
>> @@ -123,6 +124,54 @@ struct nested_ppc_state {
>>       int64_t tb_offset;
>>       /* Nested PAPR API */
>>       uint64_t pvr;
>> +    uint64_t amor;
>> +    uint64_t dawr0;
>> +    uint64_t dawrx0;
>> +    uint64_t ciabr;
>> +    uint64_t purr;
>> +    uint64_t spurr;
>> +    uint64_t ic;
>> +    uint64_t vtb;
>> +    uint64_t hdar;
>> +    uint64_t hdsisr;
>> +    uint64_t heir;
>> +    uint64_t asdr;
>> +    uint64_t dawr1;
>> +    uint64_t dawrx1;
>> +    uint64_t dexcr;
>> +    uint64_t hdexcr;
>> +    uint64_t hashkeyr;
>> +    uint64_t hashpkeyr;
>> +    ppc_vsr_t vsr[64] QEMU_ALIGNED(16);
>> +    uint64_t ebbhr;
>> +    uint64_t tar;
>> +    uint64_t ebbrr;
>> +    uint64_t bescr;
>> +    uint64_t iamr;
>> +    uint64_t amr;
>> +    uint64_t uamor;
>> +    uint64_t dscr;
>> +    uint64_t fscr;
>> +    uint64_t pspb;
>> +    uint64_t ctrl;
>> +    uint64_t vrsave;
>> +    uint64_t dar;
>> +    uint64_t dsisr;
>> +    uint64_t pmc1;
>> +    uint64_t pmc2;
>> +    uint64_t pmc3;
>> +    uint64_t pmc4;
>> +    uint64_t pmc5;
>> +    uint64_t pmc6;
>> +    uint64_t mmcr0;
>> +    uint64_t mmcr1;
>> +    uint64_t mmcr2;
>> +    uint64_t mmcra;
>> +    uint64_t sdar;
>> +    uint64_t siar;
>> +    uint64_t sier;
>> +    uint32_t vscr;
>> +    uint64_t fpscr;
>>   };
>>   
>>   typedef struct SpaprMachineStateNestedGuestVcpu {
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index a44de22ca4..11205bb9e3 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -1737,9 +1737,11 @@ void ppc_compat_add_property(Object *obj, const char *name,
>>   #define SPR_PSPB              (0x09F)
>>   #define SPR_DPDES             (0x0B0)
>>   #define SPR_DAWR0             (0x0B4)
>> +#define SPR_DAWR1             (0x0B5)
>>   #define SPR_RPR               (0x0BA)
>>   #define SPR_CIABR             (0x0BB)
>>   #define SPR_DAWRX0            (0x0BC)
>> +#define SPR_DAWRX1            (0x0BD)
>>   #define SPR_HFSCR             (0x0BE)
>>   #define SPR_VRSAVE            (0x100)
>>   #define SPR_USPRG0            (0x100)
> 
> Might try to put the DAWR1 enable ahead of this, but if not we'll have
> to drop these until that is done. Leave it in for now I'll sort it out
> if necessary.

Ok

> 
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index 3cc704adda..39d0c087f1 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -101,6 +101,7 @@ static target_ulong h_copy_tofrom_guest(PowerPCCPU *cpu,
>>   static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU *cpu)
>>   {
>>       CPUPPCState *env = &cpu->env;
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> 
> I hope that won't be a big overhead... nested entry/exit performance probably
> isn't top priority at the moment though, so for now okay. Should be
> something to look at though.

Hmm.. Ok

> 
> 
>>       memcpy(save->gpr, env->gpr, sizeof(save->gpr));
>>   
>> @@ -127,6 +128,58 @@ static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU *cpu)
>>       save->pidr = env->spr[SPR_BOOKS_PID];
>>       save->ppr = env->spr[SPR_PPR];
>>   
>> +    if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
>> +        save->pvr = env->spr[SPR_PVR];
>> +        save->amor = env->spr[SPR_AMOR];
>> +        save->dawr0 = env->spr[SPR_DAWR0];
>> +        save->dawrx0 = env->spr[SPR_DAWRX0];
>> +        save->ciabr = env->spr[SPR_CIABR];
>> +        save->purr = env->spr[SPR_PURR];
>> +        save->spurr = env->spr[SPR_SPURR];
>> +        save->ic = env->spr[SPR_IC];
>> +        save->vtb = env->spr[SPR_VTB];
>> +        save->hdar = env->spr[SPR_HDAR];
>> +        save->hdsisr = env->spr[SPR_HDSISR];
>> +        save->heir = env->spr[SPR_HEIR];
>> +        save->asdr = env->spr[SPR_ASDR];
>> +        save->dawr1 = env->spr[SPR_DAWR1];
>> +        save->dawrx1 = env->spr[SPR_DAWRX1];
>> +        save->dexcr = env->spr[SPR_DEXCR];
>> +        save->hdexcr = env->spr[SPR_HDEXCR];
>> +        save->hashkeyr = env->spr[SPR_HASHKEYR];
>> +        save->hashpkeyr = env->spr[SPR_HASHPKEYR];
>> +        memcpy(save->vsr, env->vsr, sizeof(save->vsr));
>> +        save->ebbhr = env->spr[SPR_EBBHR];
>> +        save->tar = env->spr[SPR_TAR];
>> +        save->ebbrr = env->spr[SPR_EBBRR];
>> +        save->bescr = env->spr[SPR_BESCR];
>> +        save->iamr = env->spr[SPR_IAMR];
>> +        save->amr = env->spr[SPR_AMR];
>> +        save->uamor = env->spr[SPR_UAMOR];
>> +        save->dscr = env->spr[SPR_DSCR];
>> +        save->fscr = env->spr[SPR_FSCR];
>> +        save->pspb = env->spr[SPR_PSPB];
>> +        save->ctrl = env->spr[SPR_CTRL];
>> +        save->vrsave = env->spr[SPR_VRSAVE];
>> +        save->dar = env->spr[SPR_DAR];
>> +        save->dsisr = env->spr[SPR_DSISR];
>> +        save->pmc1 = env->spr[SPR_POWER_PMC1];
>> +        save->pmc2 = env->spr[SPR_POWER_PMC2];
>> +        save->pmc3 = env->spr[SPR_POWER_PMC3];
>> +        save->pmc4 = env->spr[SPR_POWER_PMC4];
>> +        save->pmc5 = env->spr[SPR_POWER_PMC5];
>> +        save->pmc6 = env->spr[SPR_POWER_PMC6];
>> +        save->mmcr0 = env->spr[SPR_POWER_MMCR0];
>> +        save->mmcr1 = env->spr[SPR_POWER_MMCR1];
>> +        save->mmcr2 = env->spr[SPR_POWER_MMCR2];
>> +        save->mmcra = env->spr[SPR_POWER_MMCRA];
>> +        save->sdar = env->spr[SPR_POWER_SDAR];
>> +        save->siar = env->spr[SPR_POWER_SIAR];
>> +        save->sier = env->spr[SPR_POWER_SIER];
>> +        save->vscr = ppc_get_vscr(env);
>> +        save->fpscr = env->fpscr;
>> +    }
>> +
>>       save->tb_offset = env->tb_env->tb_offset;
>>   }
>>   
>> @@ -134,6 +187,7 @@ static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
>>   {
>>       CPUState *cs = CPU(cpu);
>>       CPUPPCState *env = &cpu->env;
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>   
>>       memcpy(env->gpr, load->gpr, sizeof(env->gpr));
>>   
>> @@ -160,6 +214,58 @@ static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
>>       env->spr[SPR_BOOKS_PID] = load->pidr;
>>       env->spr[SPR_PPR] = load->ppr;
>>   
>> +    if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
>> +        env->spr[SPR_PVR] = load->pvr;
>> +        env->spr[SPR_AMOR] = load->amor;
>> +        env->spr[SPR_DAWR0] = load->dawr0;
>> +        env->spr[SPR_DAWRX0] = load->dawrx0;
>> +        env->spr[SPR_CIABR] = load->ciabr;
>> +        env->spr[SPR_PURR] = load->purr;
>> +        env->spr[SPR_SPURR] = load->purr;
>> +        env->spr[SPR_IC] = load->ic;
>> +        env->spr[SPR_VTB] = load->vtb;
>> +        env->spr[SPR_HDAR] = load->hdar;
>> +        env->spr[SPR_HDSISR] = load->hdsisr;
>> +        env->spr[SPR_HEIR] = load->heir;
>> +        env->spr[SPR_ASDR] = load->asdr;
>> +        env->spr[SPR_DAWR1] = load->dawr1;
>> +        env->spr[SPR_DAWRX1] = load->dawrx1;
>> +        env->spr[SPR_DEXCR] = load->dexcr;
>> +        env->spr[SPR_HDEXCR] = load->hdexcr;
>> +        env->spr[SPR_HASHKEYR] = load->hashkeyr;
>> +        env->spr[SPR_HASHPKEYR] = load->hashpkeyr;
>> +        memcpy(env->vsr, load->vsr, sizeof(env->vsr));
>> +        env->spr[SPR_EBBHR] = load->ebbhr;
>> +        env->spr[SPR_TAR] = load->tar;
>> +        env->spr[SPR_EBBRR] = load->ebbrr;
>> +        env->spr[SPR_BESCR] = load->bescr;
>> +        env->spr[SPR_IAMR] = load->iamr;
>> +        env->spr[SPR_AMR] = load->amr;
>> +        env->spr[SPR_UAMOR] = load->uamor;
>> +        env->spr[SPR_DSCR] = load->dscr;
>> +        env->spr[SPR_FSCR] = load->fscr;
>> +        env->spr[SPR_PSPB] = load->pspb;
>> +        env->spr[SPR_CTRL] = load->ctrl;
>> +        env->spr[SPR_VRSAVE] = load->vrsave;
>> +        env->spr[SPR_DAR] = load->dar;
>> +        env->spr[SPR_DSISR] = load->dsisr;
>> +        env->spr[SPR_POWER_PMC1] = load->pmc1;
>> +        env->spr[SPR_POWER_PMC2] = load->pmc2;
>> +        env->spr[SPR_POWER_PMC3] = load->pmc3;
>> +        env->spr[SPR_POWER_PMC4] = load->pmc4;
>> +        env->spr[SPR_POWER_PMC5] = load->pmc5;
>> +        env->spr[SPR_POWER_PMC6] = load->pmc6;
>> +        env->spr[SPR_POWER_MMCR0] = load->mmcr0;
>> +        env->spr[SPR_POWER_MMCR1] = load->mmcr1;
>> +        env->spr[SPR_POWER_MMCR2] = load->mmcr2;
>> +        env->spr[SPR_POWER_MMCRA] = load->mmcra;
> 
> I worry that some other SPRs have "behaviour" we need
> to handle. DAWR and MMCR? for example set breakpoints
> and PMU beahviour. I don't know how well that is handled
> here.

I think for now we can keep it as-is. Any additional handling can be
taken care as separate patches in future?

regards,
Harsh

> 
> Thanks,
> Nick

