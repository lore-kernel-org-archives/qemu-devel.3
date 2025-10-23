Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE76CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 08:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBqXJ-0001cm-DD; Thu, 23 Oct 2025 04:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vBqXH-0001cE-9u; Thu, 23 Oct 2025 04:19:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vBqXF-0006gG-1v; Thu, 23 Oct 2025 04:19:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3qDaa013165;
 Thu, 23 Oct 2025 08:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mBOLp9
 7vyJpzz6KnIXUrsUZq5KrsfUC7vv4ROH0PTsk=; b=O6AreKsUKnGjb6cIZ4eh+2
 vyeRytLqrzdoXf120m335tW2pDSEh3It6d3Z0yEvFe07lt/MCibsGaD/3tIHWWQ3
 SBDHmOYnSMm028FWjpn2kZU7BDomnMcpbJeWAupurpJRakhzJAjqR6RyY1TgaP1w
 oHqfwX8hS4fgvF31Fl1WpEBiwdXG1UR96VLlsOG4q8x9Syn9uJZrirxfofuTmtUr
 gFIIlXAAQZMA3U2a7wqM0sUeqPUk8K9i/0rfHh4xB55/jL9UYmYV4bB6u1KcLUzi
 rju2A2tBjImg0QMMlgiLS0J2Zi7VAyeTPZLcb4kbqlE/5cI6VXPYp3Mvk38MTC7A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cfrnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 08:18:58 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59N7tHe3022642;
 Thu, 23 Oct 2025 08:18:58 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cfrnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 08:18:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7CQAc002488;
 Thu, 23 Oct 2025 08:18:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejmj49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 08:18:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59N8IrPx45547820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 08:18:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90FF3200B2;
 Thu, 23 Oct 2025 08:18:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6AED200B1;
 Thu, 23 Oct 2025 08:18:50 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 08:18:50 +0000 (GMT)
Message-ID: <ca496ba2-33dc-4570-a89f-2ce4d0e1acd8@linux.ibm.com>
Date: Thu, 23 Oct 2025 13:48:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] hw/ppc: Trigger Fadump boot if fadump is registered
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
 <20251021134823.1861675-3-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20251021134823.1861675-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bbut_AnV20EySg0KLMk8ITwIZqbM0AqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXw/M/iTgFf4z+
 gYzVsILg2vzwwx8zL7+Pk/0GXUP43b65gHrgOJhUD0lpAMv/xuvpPwweyRN2Zj9JKA+h7CQW/XH
 IgQU5hbXdXHar65m7RNQIA3SJGdClxSKWFeYq3VxcY6+Bhq7zRUOyVW0ewHQskBAbXsS5JBU4aX
 EpGx8NfHI56DyhH0u3AQqubfYcz1QX4OcAxQHFMwpsfQdrBrMmK4DAmGN80Pxwc6X6b9hBHVeEf
 oDANU4IOA2wiS0zS31uhubrlJ0MEZXcmkUNhNeJd9veuSdRHICxz10ayKZVOvslCuDfvutN87oU
 IsVN8dyDkGhdTDr+p74r8y08F+AxyHcURHZA8ENj8tS8mUh393bouz0zTjNy7FZEu0WnMsJjWwe
 9MOvAtvnDBpAS/9JT1ndjrqnf2qv0w==
X-Proofpoint-GUID: HSywofOiAE1eFeKG3YlnBwJQ8d6mXVTl
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f9e4f3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=-IKiK1kdgIJw1zaV0QEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 21/10/25 19:18, Aditya Gupta wrote:
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
>      * pause all vcpus (will need to save registers later)
>      * preserve memory regions specified by fadump (will be implemented
>        in future)
>      * do a memory preserving reboot (GUEST_RESET in QEMU doesn't clear
>        the memory)
>
> Memory regions registered by fadump will be handled in a later patch.
>
> Note: Preserving memory regions is not implemented yet so on an
> "ibm,os-term" call will just trigger a reboot in QEMU if fadump is
> registered, and the second kernel will boot as a normal boot (not
> fadump boot)
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/spapr_fadump.c         | 77 +++++++++++++++++++++++++++++++++++
>   hw/ppc/spapr_rtas.c           |  5 +++
>   include/hw/ppc/spapr_fadump.h |  6 +++
>   3 files changed, 88 insertions(+)
>
> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> index 2c9f024c2d8c..53e5c12c7641 100644
> --- a/hw/ppc/spapr_fadump.c
> +++ b/hw/ppc/spapr_fadump.c
> @@ -7,6 +7,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "hw/ppc/spapr.h"
> +#include "system/cpus.h"
>   
>   /*
>    * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
> @@ -121,3 +122,79 @@ uint32_t do_fadump_register(SpaprMachineState *spapr, target_ulong args)
>   
>       return RTAS_OUT_SUCCESS;
>   }
> +
> +/* Preserve the memory locations registered for fadump */
> +static bool fadump_preserve_mem(void)
> +{
> +    /*
> +     * TODO: Implement preserving memory regions requested during fadump
> +     * registration
> +     */
> +    return false;
> +}
> +
> +/*
> + * Trigger a fadump boot, ie. next boot will be a crashkernel/fadump boot
> + * with fadump dump active.
> + *
> + * This is triggered by ibm,os-term RTAS call, if fadump was registered.
> + *
> + * It preserves the memory and sets 'FADUMP_STATUS_DUMP_TRIGGERED' as
> + * fadump status, which can be used later to add the "ibm,kernel-dump"
> + * device tree node as presence of 'FADUMP_STATUS_DUMP_TRIGGERED' signifies
> + * next boot as fadump boot in our case
> + */
> +void trigger_fadump_boot(SpaprMachineState *spapr, target_ulong spapr_retcode)
> +{
> +    FadumpSectionHeader *header = &spapr->registered_fdm.header;
> +
> +    pause_all_vcpus();
> +
> +    /* Preserve the memory locations registered for fadump */
> +    if (!fadump_preserve_mem()) {
> +        /* Failed to preserve the registered memory regions */
> +        rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
> +
> +        /* Cause a reboot */
> +        qemu_system_guest_panicked(NULL);
> +        return;
> +    }
> +
> +    /*
> +     * Mark next boot as fadump boot
> +     *
> +     * Note: These is some bit of assumption involved here, as PAPR doesn't
> +     * specify any use of the dump status flags, nor does the kernel use it
> +     *
> +     * But from description in Table 136 in PAPR v2.13, it looks like:
> +     *   FADUMP_STATUS_DUMP_TRIGGERED
> +     *      = Dump was triggered by the previous system boot (PAPR says)
> +     *      = Next boot will be a fadump boot (Assumed)
> +     *
> +     *   FADUMP_STATUS_DUMP_PERFORMED
> +     *      = Dump performed (Set to 0 by caller of the
> +     *        ibm,configure-kernel-dump call) (PAPR says)
> +     *      = Firmware has performed the copying/dump of requested regions
> +     *        (Assumed)
> +     *      = Dump is active for the next boot (Assumed)
> +     */
> +    header->dump_status_flag = cpu_to_be16(
> +            FADUMP_STATUS_DUMP_TRIGGERED |  /* Next boot will be fadump boot */
> +            FADUMP_STATUS_DUMP_PERFORMED    /* Dump is active */
> +    );
> +
> +    /* Reset fadump_registered for next boot */
> +    spapr->fadump_registered = false;
> +    spapr->fadump_dump_active = true;
> +
> +    /*
> +     * Then do a guest reset
> +     *
> +     * Requirement:
> +     * GUEST_RESET is expected to NOT clear the memory, as is the case when
> +     * this is merged
> +     */
> +    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +
> +    rtas_st(spapr_retcode, 0, RTAS_OUT_SUCCESS);
> +}
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 6042fc72e57a..1f78fe406e75 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -420,6 +420,11 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
>       target_ulong msgaddr = rtas_ld(args, 0);
>       char msg[512];
>   
> +    if (spapr->fadump_registered) {
> +        /* If fadump boot works, control won't come back here */
> +        return trigger_fadump_boot(spapr, rets);
> +    }
> +
>       cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
>       msg[sizeof(msg) - 1] = 0;
>   
> diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
> index f64f33920496..1cb90c9d63af 100644
> --- a/include/hw/ppc/spapr_fadump.h
> +++ b/include/hw/ppc/spapr_fadump.h
> @@ -16,6 +16,11 @@
>   
>   #define FADUMP_VERSION                 1
>   
> +/* Dump status flags */
> +#define FADUMP_STATUS_DUMP_PERFORMED            0x8000
> +#define FADUMP_STATUS_DUMP_TRIGGERED            0x4000
> +#define FADUMP_STATUS_DUMP_ERROR                0x2000
> +
>   /*
>    * The Firmware Assisted Dump Memory structure supports a maximum of 10 sections
>    * in the dump memory structure. Presently, three sections are used for
> @@ -66,4 +71,5 @@ struct FadumpMemStruct {
>   };
>   
>   uint32_t do_fadump_register(struct SpaprMachineState *, target_ulong);
> +void     trigger_fadump_boot(struct SpaprMachineState *, target_ulong);
>   #endif /* PPC_SPAPR_FADUMP_H */

LKTM

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

