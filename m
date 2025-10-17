Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E600ECCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kH5-0000yE-LK; Fri, 17 Oct 2025 09:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1v9isN-0008Vm-Vm; Fri, 17 Oct 2025 07:44:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1v9isC-00070k-Kx; Fri, 17 Oct 2025 07:44:01 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H94tOa023481;
 Fri, 17 Oct 2025 11:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=45Ilpu
 LErj7HHTWuZ9TjUF7uQs9anRf09ZaZkUhsvrA=; b=fmfLyFEJV6S7Y7djDIFnOh
 aix+ondV51GEwcyn9uIBOJOdVTZ/RtFBg1sVI+S+FxlX/u0hWv8bbHY+5B/RD8+Y
 JUqSaenAM/X8eF3qFhSH2DswRwQ9duai4a+8zrwft5F9U15zVIvdYBfku1fSPRf6
 QLewe1F8eMT4Kfgau7DJUqIxkpEaeQmqIbcuK8V5s2BROeT6/9wu0y2iCmhtB8f3
 n2NUuTvr4Y87jfH85OoICEQ3iQ4B+4epMs1YxXMMeCJ8juySG7rxlb8mO8tNEbA5
 X2ldM2nUgtYr4+BFZ5XydErvZ2VOQfxHPJQLR22htdQWDw7rZjhumj0KEcV2N9VA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpuwbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:43:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HBhj8G000779;
 Fri, 17 Oct 2025 11:43:45 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpuwbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:43:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9MspI015041;
 Fri, 17 Oct 2025 11:43:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjvsub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:43:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HBhe3U29425934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 11:43:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B35AB200FB;
 Fri, 17 Oct 2025 11:26:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF695200FA;
 Fri, 17 Oct 2025 11:26:08 +0000 (GMT)
Received: from [9.124.221.21] (unknown [9.124.221.21])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 11:26:08 +0000 (GMT)
Message-ID: <0dda0c58-0351-41a6-bc76-56e46aa8f02c@linux.ibm.com>
Date: Fri, 17 Oct 2025 16:56:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] hw/ppc: Trigger Fadump boot if fadump is registered
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-4-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20250323174007.221116-4-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k8Jg8XxZXfD7M5gHrBeDMa--TtBvjnyZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDEyNSBTYWx0ZWRfXxwSCZU/ixwOz
 kW37vd1hXkiMkXWa/sqlE9G527a4nuMkleOhB1c5wEOnzCjd9K/CViWAs8bqSxJQKnd4Mbbijh+
 6DVK+FJOPuBUS1g+13nIrtZmdRE0nShvkzHEz/sH/8Fc4lRMznL20AnEgM9Ld+6oR7HchxVSd5Q
 musZ5yWM1oXgYwuS6rYKNbv+PaKpLJUZmZjEN0/gPIBMEUKxb/WJr17pcoROf3oWSvBkhGjasWV
 0ojdMh3T3VdhX2UZ8pOIwgrWleRTJyGMiio+/Uz2rTejvDlaaUbu1mnDtK+ZJaXdT2n9DxVrQAO
 lQ3tRXAkUNnOP2gVgEGNWzO0o2qa2NeqBq4kQ1uzSGH8hpIsTHQD3XQ35zUfuKAFerAenYAoefL
 YbFLQEH9BzPyzn73PHxXdp4I7l7A8Q==
X-Authority-Analysis: v=2.4 cv=R+wO2NRX c=1 sm=1 tr=0 ts=68f22bf1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=WzUm8aunDAuTTI20kp8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: A9Yf68WieKyujySKBAnWFjEtLLj6BA7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510150125
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 17 Oct 2025 09:13:21 -0400
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



On 23/03/25 23:10, Aditya Gupta wrote:
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
> index 9c7fb9e12b16..fedd2cde9a4f 100644
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
> +     *      = Next boot will be a fadump boot (My perception)

Can we say assumption made or assumed instead of My perception.

> +     *
> +     *   FADUMP_STATUS_DUMP_PERFORMED
> +     *      = Dump performed (Set to 0 by caller of the
> +     *        ibm,configure-kernel-dump call) (PAPR says)
> +     *      = Firmware has performed the copying/dump of requested regions
> +     *        (My perception)
> +     *      = Dump is active for the next boot (My perception)

Same here.

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
> index 0454938a01e9..14b954a05109 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -412,6 +412,11 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
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
> index 6abbcb44f353..e484604c1c70 100644
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


