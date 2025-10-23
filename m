Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79286CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 08:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBqUz-0000XV-AO; Thu, 23 Oct 2025 04:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vBqUr-0000VD-94; Thu, 23 Oct 2025 04:16:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vBqUo-0006ZZ-H1; Thu, 23 Oct 2025 04:16:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N82eJa017699;
 Thu, 23 Oct 2025 08:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=O1xK3l
 tc35w70MbVIbjvTEvONBPVLzlD44wSktjnXOQ=; b=W8GcK/PalO/K829I5ZZ2Mp
 TWQB3ik9wDUbc2KU6Tcqu132cUZD8kRbQP2M5QqAsiwDjrga8Ln773mgeuhBu9ZI
 +kcf9C0VInUdS/xu/iVAMT+3wuDQqb489E5PIMlZN3LxVJG9pZxEmJtZ8cHEZR9o
 ErOY7nXqREOGEXd3Nn0XrEOc4M+xLoOZtjdMN6wi3oqY5WUVkptgXDzkno21Aq0w
 TQY0jCDvhRvinTTebzTWj8xQ/wnQSyGpF2efXRrZngBCyQi0lSr3nauouCRyJhxt
 MJEX9mmNQe5Rjh/RxQAc4uAPmkBvN+bX/OYbBlnrNzvAmzyUCsiz6Yc5shoP4JAQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vymmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 08:16:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59N87Fch019570;
 Thu, 23 Oct 2025 08:16:25 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vymms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 08:16:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7fdRB011066;
 Thu, 23 Oct 2025 08:16:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1cee0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 08:16:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59N8GLrU7274836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 08:16:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18D9F20043;
 Thu, 23 Oct 2025 08:16:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 642D020040;
 Thu, 23 Oct 2025 08:16:18 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 08:16:18 +0000 (GMT)
Message-ID: <6a198b3f-b9c1-4226-8e35-c853baf178b4@linux.ibm.com>
Date: Thu, 23 Oct 2025 13:46:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] hw/ppc: Implement fadump register command
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
 <20251021134823.1861675-2-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20251021134823.1861675-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -7jUu8dCJ5z1mQaYugZuoVVI_d2A2wNZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX6pvSOe4K/qRz
 j1fyQ01/vVPUgdDtuHRSDudtNIk3JeBVnpfj1MJdrffzf6mDTeWkwNdst7QN8OrnC9g/gSLx3oM
 5rhtftSOPCBbSYDHMpFmOpCL9sxrYe6fF9Jx/nAoNDoSayKvT9cJVgTRjFNYd45IK7rrzQgOOQi
 oeOs9kbXpo/6foIZ9GOd/ZTyhaSr9UG9GTLp8HFEKB49ovgug5L5m6WWtgQVB+bbOtsE+O2ODdn
 rAux60ME3+mVzKicKaSw/SLYM4myDuYE7ShCf7WNQVyAHrrDNMY9KkF3JoJR97tn+FAD60NonxR
 LJwr3hNI1Towi+q1RPUfKZVYGgPxNVB7aBTgt40y2/dK3SIGf477KA2296U9BtbKfIfGDKNXf5Y
 X/5eyIQBASy744lKuUQnjOKV5lLNXw==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f9e45a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=06ZVEh5DtaisDDS5Qd0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vjJvQiXxm1rQFrAbfG-LLzJeKkS0OBA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
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
> Add skeleton to handle "ibm,configure-kernel-dump" rtas call in QEMU,
> including register, unregister and invalidate commands.
>
> The register just verifies the structure of the fadump memory structure
> passed by kernel, and set fadump_registered in spapr state to true.
>
> Verify basic details mandated by the PAPR, such as number of
> inputs/output, and add handling for the three fadump commands:
> regiser/unregister/invalidate.
>
> The checks are based on the table in following requirement in PAPR v2.13:
>      "R1–7.3.30–1. For the Configure Platform Assisted Kernel Dump option ..."
>
> Relevant section for the register command in PAPR is:
>      Section 7.3.30: "ibm,configure-kernel-dump RTAS call" (PAPR v2.13)
>
> Note: Any modifications made by the kernel to the fadump memory
> structure after the 'ibm,configure-kernel-dump' RTAS call returns will
> not be reflected in QEMU, as QEMU retains the fadump memory structure
> that was provided during fadump registration.
>
> The kernel must unregister and re-register fadump to apply any changes
> to the fadump memory structure.
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/meson.build            |   1 +
>   hw/ppc/spapr_fadump.c         | 123 ++++++++++++++++++++++++++++++++++
>   hw/ppc/spapr_rtas.c           |  71 ++++++++++++++++++++
>   include/hw/ppc/spapr.h        |  11 ++-
>   include/hw/ppc/spapr_fadump.h |  69 +++++++++++++++++++
>   5 files changed, 274 insertions(+), 1 deletion(-)
>   create mode 100644 hw/ppc/spapr_fadump.c
>   create mode 100644 include/hw/ppc/spapr_fadump.h
>
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 170b90ae7d05..6b7c1f4f49fb 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -26,6 +26,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
>     'spapr_nvdimm.c',
>     'spapr_rtas_ddw.c',
>     'spapr_numa.c',
> +  'spapr_fadump.c',
>     'pef.c',
>   ))
>   ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> new file mode 100644
> index 000000000000..2c9f024c2d8c
> --- /dev/null
> +++ b/hw/ppc/spapr_fadump.c
> @@ -0,0 +1,123 @@
> +/*
> + * Firmware Assisted Dump in PSeries
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/ppc/spapr.h"
> +
> +/*
> + * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
> + *
> + * Note: Any changes made by the kernel to the fadump memory struct won't
> + * reflect in QEMU after the 'ibm,configure-kernel-dump' RTAS call has returned,
> + * as we store the passed fadump memory structure passed during fadump
> + * registration.

Seems like you forgot to update the above comment.

Rest all look good to me.
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

> + * Kernel has to invalidate & re-register fadump, if it intends to make any
> + * changes to the fadump memory structure
> + *
> + * Returns:
> + *  * RTAS_OUT_SUCCESS: On successful registration
> + *  * RTAS_OUT_PARAM_ERROR: If parameters are not correct, eg. too many
> + *                          sections, invalid memory addresses that we are
> + *                          unable to read, etc
> + *  * RTAS_OUT_DUMP_ALREADY_REGISTERED: Dump already registered
> + *  * RTAS_OUT_HW_ERROR: Misc issue such as memory access failures
> + */
> +uint32_t do_fadump_register(SpaprMachineState *spapr, target_ulong args)
> +{
> +    FadumpSectionHeader header;
> +    FadumpSection regions[FADUMP_MAX_SECTIONS] = {0};
> +    target_ulong fdm_addr = rtas_ld(args, 1);
> +    target_ulong fdm_size = rtas_ld(args, 2);
> +    AddressSpace *default_as = &address_space_memory;
> +    MemTxResult io_result;
> +    MemTxAttrs attrs;
> +    uint64_t next_section_addr;
> +    uint16_t dump_num_sections;
> +
> +    /* Mark the memory transaction as privileged memory access */
> +    attrs.user = 0;
> +    attrs.memory = 1;
> +
> +    if (spapr->fadump_registered) {
> +        /* FADump already registered */
> +        return RTAS_OUT_DUMP_ALREADY_REGISTERED;
> +    }
> +
> +    if (spapr->fadump_dump_active) {
> +        return RTAS_OUT_DUMP_ACTIVE;
> +    }
> +
> +    if (fdm_size < sizeof(FadumpSectionHeader)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: Header size is invalid: " TARGET_FMT_lu "\n", fdm_size);
> +        return RTAS_OUT_PARAM_ERROR;
> +    }
> +
> +    /* Ensure fdm_addr points to a valid RMR-memory/RMA-memory buffer */
> +    if ((fdm_addr <= 0) || ((fdm_addr + fdm_size) > spapr->rma_size)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: Invalid fdm address: " TARGET_FMT_lu "\n", fdm_addr);
> +        return RTAS_OUT_PARAM_ERROR;
> +    }
> +
> +    /* Try to read the passed fadump header */
> +    io_result = address_space_read(default_as, fdm_addr, attrs,
> +            &header, sizeof(header));
> +    if (io_result != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: Unable to read fdm: " TARGET_FMT_lu "\n", fdm_addr);
> +
> +        return RTAS_OUT_HW_ERROR;
> +    }
> +
> +    /* Verify that we understand the fadump header version */
> +    if (header.dump_format_version != cpu_to_be32(FADUMP_VERSION)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: Unknown fadump header version: 0x%x\n",
> +            header.dump_format_version);
> +        return RTAS_OUT_PARAM_ERROR;
> +    }
> +
> +    /* Reset dump status flags */
> +    header.dump_status_flag = 0;
> +
> +    dump_num_sections = be16_to_cpu(header.dump_num_sections);
> +
> +    if (dump_num_sections > FADUMP_MAX_SECTIONS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: Too many sections: %d sections\n", dump_num_sections);
> +        return RTAS_OUT_PARAM_ERROR;
> +    }
> +
> +    next_section_addr =
> +        fdm_addr +
> +        be32_to_cpu(header.offset_first_dump_section);
> +
> +    for (int i = 0; i < dump_num_sections; ++i) {
> +        /* Read the fadump section from memory */
> +        io_result = address_space_read(default_as, next_section_addr, attrs,
> +                &regions[i], sizeof(regions[i]));
> +        if (io_result != MEMTX_OK) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "FADump: Unable to read fadump %dth section\n", i);
> +            return RTAS_OUT_PARAM_ERROR;
> +        }
> +
> +        next_section_addr += sizeof(regions[i]);
> +    }
> +
> +    spapr->fadump_registered = true;
> +    spapr->fadump_dump_active = false;
> +
> +    /* Store the registered fadump memory struct */
> +    spapr->registered_fdm.header = header;
> +    for (int i = 0; i < dump_num_sections; ++i) {
> +        spapr->registered_fdm.rgn[i] = regions[i];
> +    }
> +
> +    return RTAS_OUT_SUCCESS;
> +}
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 143bc8c37947..6042fc72e57a 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -344,6 +344,73 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
>       rtas_st(rets, 0, ret);
>   }
>   
> +/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
> +static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
> +                                   SpaprMachineState *spapr,
> +                                   uint32_t token, uint32_t nargs,
> +                                   target_ulong args,
> +                                   uint32_t nret, target_ulong rets)
> +{
> +    target_ulong cmd = rtas_ld(args, 0);
> +    uint32_t ret_val;
> +
> +    /* Number of outputs has to be 1 */
> +    if (nret != 1) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: ibm,configure-kernel-dump called with nret != 1.\n");
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    /* Number of inputs has to be 3 */
> +    if (nargs != 3) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: ibm,configure-kernel-dump called with nargs != 3.\n");
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    switch (cmd) {
> +    case FADUMP_CMD_REGISTER:
> +        ret_val = do_fadump_register(spapr, args);
> +        if (ret_val != RTAS_OUT_SUCCESS) {
> +            rtas_st(rets, 0, ret_val);
> +            return;
> +        }
> +        break;
> +    case FADUMP_CMD_UNREGISTER:
> +        if (spapr->fadump_dump_active) {
> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
> +            return;
> +        }
> +
> +        spapr->fadump_registered = false;
> +        spapr->fadump_dump_active = false;
> +        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
> +        break;
> +    case FADUMP_CMD_INVALIDATE:
> +        if (!spapr->fadump_dump_active) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADump: Nothing to invalidate, no dump active\n");
> +
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        }
> +
> +        spapr->fadump_registered = false;
> +        spapr->fadump_dump_active = false;
> +        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADump: Unknown command: " TARGET_FMT_lu "\n", cmd);
> +
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +}
> +
>   static void rtas_ibm_os_term(PowerPCCPU *cpu,
>                               SpaprMachineState *spapr,
>                               uint32_t token, uint32_t nargs,
> @@ -659,6 +726,10 @@ static void core_rtas_register_types(void)
>       spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
>                           rtas_ibm_nmi_interlock);
>   
> +    /* Register fadump rtas call */
> +    spapr_rtas_register(RTAS_CONFIGURE_KERNEL_DUMP, "ibm,configure-kernel-dump",
> +                        rtas_configure_kernel_dump);
> +
>       qtest_set_command_cb(spapr_qtest_callback);
>   }
>   
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 39bd5bd5ed31..4c1636497e30 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -13,6 +13,7 @@
>   #include "hw/ppc/xics.h"        /* For ICSState */
>   #include "hw/ppc/spapr_tpm_proxy.h"
>   #include "hw/ppc/spapr_nested.h" /* For SpaprMachineStateNested */
> +#include "hw/ppc/spapr_fadump.h" /* For FadumpMemStruct */
>   
>   struct SpaprVioBus;
>   struct SpaprPhbState;
> @@ -283,6 +284,11 @@ struct SpaprMachineState {
>       Error *fwnmi_migration_blocker;
>   
>       SpaprWatchdog wds[WDT_MAX_WATCHDOGS];
> +
> +    /* Fadump State */
> +    bool fadump_registered;
> +    bool fadump_dump_active;
> +    FadumpMemStruct registered_fdm;
>   };
>   
>   #define H_SUCCESS         0
> @@ -708,6 +714,8 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
>   #define RTAS_OUT_PARAM_ERROR                    -3
>   #define RTAS_OUT_NOT_SUPPORTED                  -3
>   #define RTAS_OUT_NO_SUCH_INDICATOR              -3
> +#define RTAS_OUT_DUMP_ALREADY_REGISTERED        -9
> +#define RTAS_OUT_DUMP_ACTIVE                    -10
>   #define RTAS_OUT_NOT_AUTHORIZED                 -9002
>   #define RTAS_OUT_SYSPARM_PARAM_ERROR            -9999
>   
> @@ -770,8 +778,9 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
>   #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
>   #define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
>   #define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
> +#define RTAS_CONFIGURE_KERNEL_DUMP              (RTAS_TOKEN_BASE + 0x2D)
>   
> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2E)
>   
>   /* RTAS ibm,get-system-parameter token values */
>   #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
> diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
> new file mode 100644
> index 000000000000..f64f33920496
> --- /dev/null
> +++ b/include/hw/ppc/spapr_fadump.h
> @@ -0,0 +1,69 @@
> +/*
> + * Firmware Assisted Dump in PSeries
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef PPC_SPAPR_FADUMP_H
> +#define PPC_SPAPR_FADUMP_H
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +
> +/* Fadump commands */
> +#define FADUMP_CMD_REGISTER            1
> +#define FADUMP_CMD_UNREGISTER          2
> +#define FADUMP_CMD_INVALIDATE          3
> +
> +#define FADUMP_VERSION                 1
> +
> +/*
> + * The Firmware Assisted Dump Memory structure supports a maximum of 10 sections
> + * in the dump memory structure. Presently, three sections are used for
> + * CPU state data, HPTE & Parameters area, while the remaining seven sections
> + * can be used for boot memory regions.
> + */
> +#define FADUMP_MAX_SECTIONS            10
> +
> +typedef struct FadumpSection FadumpSection;
> +typedef struct FadumpSectionHeader FadumpSectionHeader;
> +typedef struct FadumpMemStruct FadumpMemStruct;
> +
> +struct SpaprMachineState;
> +
> +/* Kernel Dump section info */
> +/* All fields are in big-endian */
> +struct FadumpSection {
> +    uint32_t    request_flag;
> +    uint16_t    source_data_type;
> +    uint16_t    error_flags;
> +    uint64_t    source_address;
> +    uint64_t    source_len;
> +    uint64_t    bytes_dumped;
> +    uint64_t    destination_address;
> +};
> +
> +/* ibm,configure-kernel-dump header. */
> +struct FadumpSectionHeader {
> +    uint32_t    dump_format_version;
> +    uint16_t    dump_num_sections;
> +    uint16_t    dump_status_flag;
> +    uint32_t    offset_first_dump_section;
> +
> +    /* Fields for disk dump option. */
> +    uint32_t    dd_block_size;
> +    uint64_t    dd_block_offset;
> +    uint64_t    dd_num_blocks;
> +    uint32_t    dd_offset_disk_path;
> +
> +    /* Maximum time allowed to prevent an automatic dump-reboot. */
> +    uint32_t    max_time_auto;
> +};
> +
> +/* Note: All the data in these structures is in big-endian */
> +struct FadumpMemStruct {
> +    FadumpSectionHeader header;
> +    FadumpSection       rgn[FADUMP_MAX_SECTIONS];
> +};
> +
> +uint32_t do_fadump_register(struct SpaprMachineState *, target_ulong);
> +#endif /* PPC_SPAPR_FADUMP_H */


