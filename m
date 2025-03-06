Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819DFC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 04:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq2Zn-0006Ij-In; Wed, 05 Mar 2025 23:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tq2Zl-0006IH-VD; Wed, 05 Mar 2025 23:11:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tq2Zj-0007Hv-Oy; Wed, 05 Mar 2025 23:11:13 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525KpkPr031874;
 Thu, 6 Mar 2025 04:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Yq3Hm8
 AGHWR0VT0yqVYN+SOOGap3B7fiqhHbSVrdqhk=; b=oPDam5/QJq32OgBmtLBtxx
 olBoCgBjeZ8fs7pmEB0Opk2O3ueNF+Fk+3gxVbBM60W8gZfD10T8pMJ1iPKldpl3
 4jK6sSOIYvFJjWXgC7NEXU2QqyKzNIXtKKLMZj4HFQmXHMB8J9J0jiyGTHlU3dEz
 6WNM717kv7ebW0hko7s/+DlYciat79/5SzApz5629mD2de8Vl/n/RyNN7lmzGzg1
 +vNeFb3SMd7QS99RlO2iILXjCfyZKGMjgQ8BA6YDhawb5bh6fOth7uGp/dDRymnY
 mmgboxd/lcKKJbfffJpx4Q/OofPuPomOP4l1+aw5Mt8qchekwKEvH+1EN669nFUA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456x15hghe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 04:11:10 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52646JcM029948;
 Thu, 6 Mar 2025 04:11:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456x15hghb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 04:11:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5261Frp3020936;
 Thu, 6 Mar 2025 04:11:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnpm73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 04:11:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5264B50w35193484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 04:11:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18B9C20040;
 Thu,  6 Mar 2025 04:11:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B557520043;
 Thu,  6 Mar 2025 04:11:02 +0000 (GMT)
Received: from [9.124.214.147] (unknown [9.124.214.147])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 04:11:02 +0000 (GMT)
Message-ID: <c82a0177-ba29-41ef-be7a-ad4ebb0dc966@linux.ibm.com>
Date: Thu, 6 Mar 2025 09:41:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] hw/ppc: Trigger Fadump boot if fadump is registered
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-3-adityag@linux.ibm.com>
 <93a44d0c-1712-4535-a7d0-e4c285e0255f@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <93a44d0c-1712-4535-a7d0-e4c285e0255f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L2_sM5YaBvajsEcNYtghO3zswv8XZNL0
X-Proofpoint-ORIG-GUID: ech1K4B4HE0313wJlS09GlLMliLnMXYG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_02,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060025
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 04/03/25 14:51, Harsh Prateek Bora wrote:
>
>
> On 2/17/25 12:47, Aditya Gupta wrote:
>> According to PAPR:
>>
>>      R1–7.3.30–3. When the platform receives an ibm,os-term RTAS 
>> call, or
>>      on a system reset without an ibm,nmi-interlock RTAS call, if the
>>      platform has a dump structure registered through the
>>      ibm,configure-kernel-dump call, the platform must process each
>>      registered kernel dump section as required and, when available,
>>      present the dump structure information to the operating system
>>      through the “ibm,kernel-dump” property, updated with status for 
>> each
>>      dump section, until the dump has been invalidated through the
>>      ibm,configure-kernel-dump RTAS call.
>>
>> If Fadump has been registered, trigger an Fadump boot (memory preserving
>> boot), if QEMU recieves a 'ibm,os-term' rtas call.
>>
>> Implementing the fadump boot as:
>>      * pause all vcpus (will save registers later)
>>      * preserve memory regions specified by fadump
>
> Although mentioned later, but needs to call out here as not implemented
> in this patch. Ideally, all the prep work patches should be introduced
> earlier before enabling the trigger.
>
Got it, will try rearranging the code. Though with current code, the 
trigger won't be called as fadump will not get registered (as of this 
patch the rtas call was not exposed to the kernel, this will likely 
change in v2).
>>      * do a memory preserving reboot (GUEST_RESET in QEMU doesn't clear
>>        the memory)
>>
>> Memory regions registered by fadump will be handled in a later patch.
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_rtas.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index eebdf13b1552..01c82375f03d 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -342,6 +342,43 @@ static void 
>> rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
>>   }
>>     struct fadump_metadata fadump_metadata;
>> +bool is_next_boot_fadump;
>> +
>> +static void trigger_fadump_boot(target_ulong spapr_retcode)
>> +{
>> +    /*
>> +     * In PowerNV, SBE stops all clocks for cores, do similar to it
>> +     * QEMU's nearest equivalent is 'pause_all_vcpus'
>> +     * See 'stopClocksS0' in SBE source code for more info on SBE part
>> +     */
>> +    pause_all_vcpus();
>> +
>> +    if (true /* TODO: Preserve memory registered for fadump */) {
>> +        /* Failed to preserve the registered memory regions */
>
> Instead of this, it is better to introduce the dummy stub here now 
> which can be populated in a later patch. That also helps in avoiding 
> code changes in this hunk in future patch.
>
> For eg:
>
> static bool fadump_preserved_mem(void)
> {
>     return false; /* TBD */
> }
>
> ...
>
> if (!fadump_preserve_mem()) {
>  ...
> }

Thanks, makes sense. I will do it this way.


Thanks,

- Aditya Gupta

>
>> +        rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
>> +
>> +        /* Cause a reboot */
>> +        qemu_system_guest_panicked(NULL);
>> +        return;
>> +    }
>> +
>> +    /* Mark next boot as fadump boot */
>> +    is_next_boot_fadump = true;
>> +
>> +    /* Reset fadump_registered for next boot */
>> +    fadump_metadata.fadump_registered = false;
>> +    fadump_metadata.fadump_dump_active = true;
>> +
>> +    /* Then do a guest reset */
>> +    /*
>> +     * Requirement:
>> +     * This guest reset should not clear the memory (which is
>> +     * the case when this is merged)
>> +     */
>> +    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>> +
>> +    rtas_st(spapr_retcode, 0, RTAS_OUT_SUCCESS);
>> +}
>>     /* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
>>   static __attribute((unused)) void 
>> rtas_configure_kernel_dump(PowerPCCPU *cpu,
>> @@ -449,6 +486,11 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
>>       target_ulong msgaddr = rtas_ld(args, 0);
>>       char msg[512];
>>   +    if (fadump_metadata.fadump_registered) {
>> +        /* If fadump boot works, control won't come back here */
>> +        return trigger_fadump_boot(rets);
>> +    }
>> +
>>       cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
>>       msg[sizeof(msg) - 1] = 0;

