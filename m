Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195BDC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 09:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpOTW-00058z-Vg; Tue, 04 Mar 2025 04:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tpOTQ-00057u-0M; Tue, 04 Mar 2025 04:22:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tpOTC-00012p-NX; Tue, 04 Mar 2025 04:21:58 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5243jkrV021572;
 Tue, 4 Mar 2025 09:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=R+q1ML
 majr9kgzmjYWM0Fm/ZnNIJsXiep+W0AQBsYYk=; b=hMfEL+/8XgJUUsg8ObkpQN
 qmwrD2bR5ENNC7zGH6OHKjzTIOfWVrMBoSwiADpxZB98BejvqBDcUdGWKxiFDiPo
 t3NSbuOGDGIIrR696QuRuz8vce56vQUShTbqLbP8QTaFgeXJEHeuLak3eWOJm8a3
 nPu/h2tMiVoQBJNG8flLJz0KYJ+Em6vjULEz/x8JzQw3iaEY1g+0H7GPFtBus1UD
 EmCPRC/YJlTVrkUEaR08GScfgJwWr31Dl6bNVxNXaMgzZ3PyVkarrJQ2+PvyBdrD
 BHseAO/SHeY7iJri7AgnA6d8ZDMmoGPDpgrj+C6JIUQ6wF9c2rF3z1aNC82iD65A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7hfts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 09:21:43 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5249DuAQ017919;
 Tue, 4 Mar 2025 09:21:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7hftn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 09:21:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52480rYl013805;
 Tue, 4 Mar 2025 09:21:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kmhyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 09:21:41 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5249LetG26149368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Mar 2025 09:21:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FCCC58052;
 Tue,  4 Mar 2025 09:21:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 609BE5805A;
 Tue,  4 Mar 2025 09:21:38 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Mar 2025 09:21:38 +0000 (GMT)
Message-ID: <93a44d0c-1712-4535-a7d0-e4c285e0255f@linux.ibm.com>
Date: Tue, 4 Mar 2025 14:51:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] hw/ppc: Trigger Fadump boot if fadump is registered
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-3-adityag@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250217071711.83735-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t9CPVLqOwePFZaqQaKLzM5x8k-UAJySX
X-Proofpoint-GUID: 1V0-UaeTjYQuOvrcfbG8wBvsaM1CVKDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_04,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040075
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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



On 2/17/25 12:47, Aditya Gupta wrote:
> According to PAPR:
> 
>      R1–7.3.30–3. When the platform receives an ibm,os-term RTAS call, or
>      on a system reset without an ibm,nmi-interlock RTAS call, if the
>      platform has a dump structure registered through the
>      ibm,configure-kernel-dump call, the platform must process each
>      registered kernel dump section as required and, when available,
>      present the dump structure information to the operating system
>      through the “ibm,kernel-dump” property, updated with status for each
>      dump section, until the dump has been invalidated through the
>      ibm,configure-kernel-dump RTAS call.
> 
> If Fadump has been registered, trigger an Fadump boot (memory preserving
> boot), if QEMU recieves a 'ibm,os-term' rtas call.
> 
> Implementing the fadump boot as:
>      * pause all vcpus (will save registers later)
>      * preserve memory regions specified by fadump

Although mentioned later, but needs to call out here as not implemented
in this patch. Ideally, all the prep work patches should be introduced
earlier before enabling the trigger.

>      * do a memory preserving reboot (GUEST_RESET in QEMU doesn't clear
>        the memory)
> 
> Memory regions registered by fadump will be handled in a later patch.
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/spapr_rtas.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index eebdf13b1552..01c82375f03d 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -342,6 +342,43 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
>   }
>   
>   struct fadump_metadata fadump_metadata;
> +bool is_next_boot_fadump;
> +
> +static void trigger_fadump_boot(target_ulong spapr_retcode)
> +{
> +    /*
> +     * In PowerNV, SBE stops all clocks for cores, do similar to it
> +     * QEMU's nearest equivalent is 'pause_all_vcpus'
> +     * See 'stopClocksS0' in SBE source code for more info on SBE part
> +     */
> +    pause_all_vcpus();
> +
> +    if (true /* TODO: Preserve memory registered for fadump */) {
> +        /* Failed to preserve the registered memory regions */

Instead of this, it is better to introduce the dummy stub here now which 
can be populated in a later patch. That also helps in avoiding code 
changes in this hunk in future patch.

For eg:

static bool fadump_preserved_mem(void)
{
     return false; /* TBD */
}

...

if (!fadump_preserve_mem()) {
  ...
}

> +        rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
> +
> +        /* Cause a reboot */
> +        qemu_system_guest_panicked(NULL);
> +        return;
> +    }
> +
> +    /* Mark next boot as fadump boot */
> +    is_next_boot_fadump = true;
> +
> +    /* Reset fadump_registered for next boot */
> +    fadump_metadata.fadump_registered = false;
> +    fadump_metadata.fadump_dump_active = true;
> +
> +    /* Then do a guest reset */
> +    /*
> +     * Requirement:
> +     * This guest reset should not clear the memory (which is
> +     * the case when this is merged)
> +     */
> +    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +
> +    rtas_st(spapr_retcode, 0, RTAS_OUT_SUCCESS);
> +}
>   
>   /* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
>   static __attribute((unused)) void rtas_configure_kernel_dump(PowerPCCPU *cpu,
> @@ -449,6 +486,11 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
>       target_ulong msgaddr = rtas_ld(args, 0);
>       char msg[512];
>   
> +    if (fadump_metadata.fadump_registered) {
> +        /* If fadump boot works, control won't come back here */
> +        return trigger_fadump_boot(rets);
> +    }
> +
>       cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
>       msg[sizeof(msg) - 1] = 0;
>   

