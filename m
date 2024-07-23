Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB16EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7fI-0004qk-Vr; Tue, 23 Jul 2024 01:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sW7fE-0004eJ-RV; Tue, 23 Jul 2024 01:02:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sW7fC-0006Im-GT; Tue, 23 Jul 2024 01:02:16 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N3e26F004202;
 Tue, 23 Jul 2024 05:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=D
 fR2pGyshMGVWkHCWAjjKn7FXXSQROJVrvCt0iaBFyc=; b=L3DCswCMV9D+Cejup
 /lzKJLd/xoQF6Yqrb8PxuUUJ5ZYIv9yITybhA7k06GCA7fSt/y6ys6vMwvLcVLsD
 JT7BYM4rCOfLsNRuxhGs5vrtJhj16x0EJ6mghhkSEnbNIoxsYMnScN+xHOiJJMUj
 0ZooABPmx0nRXfLRHHYxXslpHpzHs17eWxwVqPBJIVZwXTaceQR/8jtkjV8uo9gT
 c1so/YzWTLpXEvxtoNlaks7kVU60yBQGu1DV723RrwKWPnp89aEnJot2oGYh1Y+P
 r2ocSyJY8lnT35kBiX7IVkZ+sHt6IodzxLdC1AQ82Z6/zitnj9QdFV1kL07zb1zl
 PTDlQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3rv07qc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 05:02:04 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N523s3024358;
 Tue, 23 Jul 2024 05:02:03 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3rv07qb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 05:02:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46N2KtHq006250; Tue, 23 Jul 2024 05:02:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gqjua7qp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2024 05:02:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46N51vop31719770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 05:01:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D9DD2005A;
 Tue, 23 Jul 2024 05:01:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5DF220040;
 Tue, 23 Jul 2024 05:01:54 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2024 05:01:54 +0000 (GMT)
Message-ID: <c700721a-d45d-4ea4-a034-fb4c7a79f198@linux.ibm.com>
Date: Tue, 23 Jul 2024 10:31:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] target/ppc: Add Power11 DD2.0 processor
To: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20240606121657.254308-1-adityag@linux.ibm.com>
 <20240606121657.254308-3-adityag@linux.ibm.com>
 <D2WMX1EEJ7PM.11W1PP8D9HCUN@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D2WMX1EEJ7PM.11W1PP8D9HCUN@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xFTH97NMHFcTgzsWAfqPZsTEK78r6-cS
X-Proofpoint-GUID: O7_uiAeDI4mYdPpXFhZxI7lR7CIQA1LN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=744 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230034
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi Nick,


On 23/07/24 10:00, Nicholas Piggin wrote:
>> <...snip...>
>>
>> +    { /* POWER11, ISA3.10 */
>> +        .name = "power11",
>> +        .pvr = CPU_POWERPC_LOGICAL_3_10_PLUS,
> Might call that _P11 rather than _PLUS, but I can fold that in my tree.
Sure, makes sense, I can make these changes, and send a v2 soon.
>> <...snip...>
>>
>> +
>> +POWERPC_FAMILY(POWER11)(ObjectClass *oc, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>> +    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
>> +
>> +    dc->fw_name = "PowerPC,POWER11";
>> +    dc->desc = "POWER11";
>> +    pcc->pvr_match = ppc_pvr_match_power11;
>> +    pcc->pcr_mask = POWERPC_POWER10_PCC_PCR_MASK;
>> +    pcc->pcr_supported = POWERPC_POWER10_PCC_PCR_SUPPORTED;
>> +    pcc->init_proc = init_proc_POWER10;
>> +    pcc->check_pow = check_pow_nocheck;
>> +    pcc->check_attn = check_attn_hid0_power9;
>> +    pcc->insns_flags = POWERPC_FAMILY_POWER9_INSNS_FLAGS; /* same as P9 */
>> +    pcc->insns_flags2 = POWERPC_FAMILY_POWER10_INSNS_FLAGS2;
>> +    pcc->msr_mask = POWERPC_POWER10_PCC_MSR_MASK;
>> +    pcc->lpcr_mask = POWERPC_POWER10_PCC_LPCR_MASK;
> BTW., I still think all these new macros should be named after the exact
> CPU, e.g., all these should be called POWER11 and the differences or
> sameness should be handled in cpu_init.h.

Got it, can create macros for the Power11 things also.


Regarding this:

> +    pcc->check_attn = check_attn_hid0_power9;
> +    pcc->insns_flags = POWERPC_FAMILY_POWER9_INSNS_FLAGS; /* same as P9 */

Should I keep them same, or have *_POWER11_* counterparts ?
>
> I might tweak that and the names a bit locally (e.g., why is one type of
> define called POWERPC_FAMILY_x and another called POWERPC_x_PCC), but
> that's not a big deal and mostly an exercise in bike shed painting. The
> functionality of the patch looks okay.
I am okay if you want to do it, or i can do it in a separate follow up 
patch.
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks for the tag Nick !


- Aditya Gupta

>
>> +
>> +    pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
>> +    pcc->mmu_model = POWERPC_MMU_3_00;
>> +#if !defined(CONFIG_USER_ONLY)
>> +    /* segment page size remain the same */
>> +    pcc->hash64_opts = &ppc_hash64_opts_POWER7;
>> +    pcc->radix_page_info = &POWER10_radix_page_info;
>> +    pcc->lrg_decr_bits = 56;
>> +#endif
>> +    pcc->excp_model = POWERPC_EXCP_POWER10;
>> +    pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
>> +    pcc->bfd_mach = bfd_mach_ppc64;
>> +    pcc->flags = POWERPC_POWER10_PCC_FLAGS;
>> +    pcc->l1_dcache_size = 0x8000;
>> +    pcc->l1_icache_size = 0x8000;
>> +}
>> +
>>   #if !defined(CONFIG_USER_ONLY)
>>   void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>>   {

