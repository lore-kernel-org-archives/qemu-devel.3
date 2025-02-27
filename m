Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEB7C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXot-0005cr-3M; Thu, 27 Feb 2025 01:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tnXor-0005cX-TM; Thu, 27 Feb 2025 01:56:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tnXom-0005Y5-5A; Thu, 27 Feb 2025 01:56:25 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R5O01O019699;
 Thu, 27 Feb 2025 06:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=scZqbu
 EbM7ULeeKQQOawwCpo0fM7pj9pOSBk5IRE1ns=; b=KkAp8PF17xlZNUI5G2fsPR
 CPeSeKcqYi57Lu+Qum7fk38AYn8H9LMAYMc5Y/RJVFQeCwMKcQGYwCNEpai1o8ho
 F3EJsWcXWlKHiAXYG21Nw4doR6VnYVCcaJ8eLiKTeRaSVt0ZaU2FbiIpdIvCepx1
 fuJ4FpEtM2LkfdQG17UUBSvDbVGcO29GkhY4rGNQnCyq4ECM4C+1IetZbfR09ABu
 JnU4tNd+iDA99oTCjDP5NGxDgmUkgI4VPuEyHSmu4/4ZJ+6q4B50lzUY2Plfo1LR
 YtY9POeY4KcpDQpXNagHtklxQt3E1y/U2C7zCzkunf3URTAfcd2JhhgYfmWactmA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452hv8rce9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 06:56:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51R6l98k004165;
 Thu, 27 Feb 2025 06:56:21 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452hv8rce6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 06:56:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51R3fLsW027376;
 Thu, 27 Feb 2025 06:56:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum26rvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 06:56:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51R6uGml53608846
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 06:56:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A0A720040;
 Thu, 27 Feb 2025 06:56:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 916A520043;
 Thu, 27 Feb 2025 06:56:14 +0000 (GMT)
Received: from [9.124.211.149] (unknown [9.124.211.149])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Feb 2025 06:56:14 +0000 (GMT)
Message-ID: <9e937ba1-c243-4833-816e-8b26a9929670@linux.ibm.com>
Date: Thu, 27 Feb 2025 12:26:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] hw/ppc: Trigger Fadump boot if fadump is registered
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-3-adityag@linux.ibm.com>
 <D82WGEF9P3MM.10IKXK3R6Q13M@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D82WGEF9P3MM.10IKXK3R6Q13M@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SWkDswc4aG8Wvr9fHIF2bK10huOw_wDj
X-Proofpoint-GUID: qyUjOcAAMKaFkoaTKhlTRr_T_a75UtqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502270048
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 27/02/25 08:44, Nicholas Piggin wrote:
> On Mon Feb 17, 2025 at 5:17 PM AEST, Aditya Gupta wrote:
>> According to PAPR:
>>
>>      R1–7.3.30–3. When the platform receives an ibm,os-term RTAS call, or
>>      on a system reset without an ibm,nmi-interlock RTAS call, if the
>>      platform has a dump structure registered through the
>>      ibm,configure-kernel-dump call, the platform must process each
>>      registered kernel dump section as required and, when available,
>>      present the dump structure information to the operating system
>>      through the “ibm,kernel-dump” property, updated with status for each
>>      dump section, until the dump has been invalidated through the
>>      ibm,configure-kernel-dump RTAS call.
>>
>> If Fadump has been registered, trigger an Fadump boot (memory preserving
>> boot), if QEMU recieves a 'ibm,os-term' rtas call.
>>
>> Implementing the fadump boot as:
>>      * pause all vcpus (will save registers later)
>>      * preserve memory regions specified by fadump
>>      * do a memory preserving reboot (GUEST_RESET in QEMU doesn't clear
>>        the memory)
>>
>> Memory regions registered by fadump will be handled in a later patch.
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_rtas.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index eebdf13b1552..01c82375f03d 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -342,6 +342,43 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
>>   }
>>   
>>   struct fadump_metadata fadump_metadata;
>> +bool is_next_boot_fadump;
> Here's another one for spapr state.
Sure, will add.
>> +
>> +static void trigger_fadump_boot(target_ulong spapr_retcode)
>> +{
>> +    /*
>> +     * In PowerNV, SBE stops all clocks for cores, do similar to it
>> +     * QEMU's nearest equivalent is 'pause_all_vcpus'
>> +     * See 'stopClocksS0' in SBE source code for more info on SBE part
>> +     */
> Can probably remove this comment here.
Sure.
>> +    pause_all_vcpus();
>> +
>> +    if (true /* TODO: Preserve memory registered for fadump */) {
> If you're adding half the code to preserve memory but never actually
> calling it anyway, you don't need the pause_all_vcpus() call either.
>
> Again I would rather not adding unused code to the patches if possible.
> If you're really not able to find a nice way to split and add
> incrementally then okay, but try to take another look if possible.
>
Yes all this is unused. Will take another look to see how I can arrange it.
>> +        /* Failed to preserve the registered memory regions */
>> +        rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
>> +
>> +        /* Cause a reboot */
>> +        qemu_system_guest_panicked(NULL);
>> +        return;
>> +    }
>> +
>> +    /* Mark next boot as fadump boot */
>> +    is_next_boot_fadump = true;
>> +
>> +    /* Reset fadump_registered for next boot */
>> +    fadump_metadata.fadump_registered = false;
>> +    fadump_metadata.fadump_dump_active = true;
>> +
>> +    /* Then do a guest reset */
>> +    /*
>> +     * Requirement:
>> +     * This guest reset should not clear the memory (which is
>> +     * the case when this is merged)
>> +     */
>> +    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> Seems reasonable. What is the actual mechanism that clears the machine
> RAM anyway? I'm not able to find it...

I didn't find any too. There is a devices reset which happens at this 
guest_reset, during which some devices do clear their memory registers, 
eg. 'pnv_psi_reset', since it clears it's regs it's like it's cleared 
it's memory region.

There were few like that which cleared the data they pass in their 
memory regions, but nothing clearing the whole RAM/whole memory regions 
as such.


- Aditya G

>
> Thanks,
> Nick
>
>> +
>> +    rtas_st(spapr_retcode, 0, RTAS_OUT_SUCCESS);
>> +}
>>   
>>   /* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
>>   static __attribute((unused)) void rtas_configure_kernel_dump(PowerPCCPU *cpu,
>> @@ -449,6 +486,11 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
>>       target_ulong msgaddr = rtas_ld(args, 0);
>>       char msg[512];
>>   
>> +    if (fadump_metadata.fadump_registered) {
>> +        /* If fadump boot works, control won't come back here */
>> +        return trigger_fadump_boot(rets);
>> +    }
>> +
>>       cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
>>       msg[sizeof(msg) - 1] = 0;
>>   

