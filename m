Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E5BCCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 11:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA5Sk-0004gS-5a; Sat, 18 Oct 2025 07:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vA5Sa-0004aA-P4; Sat, 18 Oct 2025 07:50:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vA5SW-00075z-QZ; Sat, 18 Oct 2025 07:50:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I5b0JA005744;
 Sat, 18 Oct 2025 11:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=v/ifDp
 Hc33C3hXgwnmf4rmc55hfkWMnui0tsdfTQarM=; b=YhfhR3KZjV9MhyLd/7DIEw
 3iQERgTKnMLCacPJjUGIGZymm4/aXvRLp23293P10JOKCA16g6o1Z4NqOI70Mam1
 BZuPDLjqQ11PyE2D4ZjmCwTmSIouXq0UA9RJTaaNKpRn2xV8gd5R6BrTifflBGJR
 x/sp6O0CZul+X+PTwkIWL823stkvmjPpngKZ90HnaS60lcXB2uoFitNb/zfoL5HQ
 V5KRf02uNW1lzC2x5B8vt4HX/yznWfjZciPVxAFg6eUkFYFbcMtuWJJcRiMgFlw6
 DXtTfOVdqbTDL+vevpQ8JLbUiWJiHrtpdnTF5NL5uE9gQpRt6Pe8DuvcEpkDb/mw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3269am6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 11:50:49 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59IBonUQ027252;
 Sat, 18 Oct 2025 11:50:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3269akw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 11:50:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59I9jI1r003603;
 Sat, 18 Oct 2025 11:50:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xyhw28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 11:50:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59IBoiWK39846184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 18 Oct 2025 11:50:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0A5220040;
 Sat, 18 Oct 2025 11:50:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5ECD20043;
 Sat, 18 Oct 2025 11:50:41 +0000 (GMT)
Received: from [9.39.28.54] (unknown [9.39.28.54])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 18 Oct 2025 11:50:41 +0000 (GMT)
Message-ID: <b0d6ce61-7e8e-4bf5-99b7-59e434ae0c48@linux.ibm.com>
Date: Sat, 18 Oct 2025 17:20:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] hw/ppc: Implement skeleton code for fadump in
 PSeries
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-2-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20250323174007.221116-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f37f19 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=92HFzz4cCZ6lP2WqRgoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwLVvu6aG8N5c
 L+ul5NaA5HyZ1mPZ0tGmkmCPJn/jo7ji9hSTQtaGeg74oHGkOJI35tWD9q4EjmTTm92uyh2h0RM
 mF6DxATaD2niYjt5g1m38pWmXgrpMBY1WfGnvqsQJWrwMztUkuZA+fVwxVVyCAzAMe3Xce62PUV
 p5Esn5UWcv+8KRRSlnBv4H+UHf/RayMmJ1ECiT8seLAEWLVfe8wkdP2BnuglTsfh/pqmTJJCGML
 HSWMlyEJGd7BTEZveAR5zUmNlISPJi9GQ3k4VdnNXWg3klrh++rbu7nFKrJykVsxjxI9Y6hUwF7
 UV4S4P4quYCsHjFxMj7+csD2gIXPHzRNS/LrDPzAIDK523zzOA+2xenp/PSGnE3LwAn0pKr8DZS
 xIxEIPGEj5t2SJ/DrMnuv2V5Mu+xPw==
X-Proofpoint-GUID: yAjXYrDnWuGFfatPB6-ZmJjBIDAR85eG
X-Proofpoint-ORIG-GUID: T28ykN1oTZfFJCbYkNcYHxaucXZJshCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 23/03/25 23:10, Aditya Gupta wrote:
> Add skeleton for handle "ibm,configure-kernel-dump" rtas call in QEMU.
>
> Verify basic details mandated by the PAPR, such as number of
> inputs/output, and add handling for the three fadump commands:
> regiser/unregister/invalidate.
>
> Currently fadump register will always return HARDWARE ERROR, since it's
> not implemented yet. So if the kernel's attempt to register fadump will
> itself fail as the support is not there yet in QEMU.
>
> The checks are based on the table in following requirement in PAPR v2.13:
>      "R1–7.3.30–1. For the Configure Platform Assisted Kernel Dump option ..."
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/meson.build            |  1 +
>   hw/ppc/spapr_fadump.c         | 22 +++++++++++
>   hw/ppc/spapr_rtas.c           | 66 +++++++++++++++++++++++++++++++++
>   include/hw/ppc/spapr.h        | 11 +++++-
>   include/hw/ppc/spapr_fadump.h | 69 +++++++++++++++++++++++++++++++++++
>   5 files changed, 168 insertions(+), 1 deletion(-)
>   create mode 100644 hw/ppc/spapr_fadump.c
>   create mode 100644 include/hw/ppc/spapr_fadump.h
>
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 9893f8adebb0..863972741b15 100644
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
> index 000000000000..20b7b804c485
> --- /dev/null
> +++ b/hw/ppc/spapr_fadump.c
> @@ -0,0 +1,22 @@
> +/*
> + * Firmware Assisted Dump in PSeries
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/ppc/spapr.h"
> +
> +/*
> + * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
> + *
> + * Returns:
> + *  * RTAS_OUT_HW_ERROR: Not implemented/Misc issue such as memory access
> + *                       failures
> + */
> +uint32_t do_fadump_register(void)
> +{
> +    /* WIP: FADUMP_CMD_REGISTER implemented in future patch */
> +
> +    return RTAS_OUT_HW_ERROR;
> +}
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 503d441b48e4..b8bfa9c33fb5 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -341,6 +341,68 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
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
> +                "FADump: ibm,configure-kernel-dump RTAS called with nret != 1.\n");
> +        return;
> +    }
> +
> +    /* Number of inputs has to be 3 */
> +    if (nargs != 3) {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    switch (cmd) {
> +    case FADUMP_CMD_REGISTER:
> +        ret_val = do_fadump_register();
> +        if (ret_val != RTAS_OUT_SUCCESS) {
> +            rtas_st(rets, 0, ret_val);
> +            return;
> +        }
> +        break;
> +    case FADUMP_CMD_UNREGISTER:
> +        if (spapr->fadump_dump_active == 1) {
> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
> +            return;
> +        }
> +
> +        spapr->fadump_registered = false;
> +        spapr->fadump_dump_active = false;
> +        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
> +        break;
> +    case FADUMP_CMD_INVALIDATE:
> +        if (spapr->fadump_dump_active) {
> +            spapr->fadump_registered = false;
> +            spapr->fadump_dump_active = false;
> +            memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));

I hope the above actions are good enough to make qemu ready for fadump 
registration.

> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADump: Nothing to invalidate, no dump active\n");
> +        }

No error code if the kernel issues an invalidate and fadump_dump_active 
is false?

As per the current kernel code, this situation should not occur, but to 
be on the safe side,
QEMU should not return RTAS_OUT_SUCCESS.

> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADump: Unknown command: %lu\n", cmd);
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
> @@ -656,6 +718,10 @@ static void core_rtas_register_types(void)
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
> index 000000000000..45109fd9e137
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
> +#define RTAS_FADUMP_MAX_BOOT_MEM_REGS  7
> +
> +typedef struct FadumpSection FadumpSection;
> +typedef struct FadumpSectionHeader FadumpSectionHeader;
> +typedef struct FadumpMemStruct FadumpMemStruct;
> +
> +struct SpaprMachineState;
> +
> +/* Kernel Dump section info */
> +struct FadumpSection {
> +    __be32    request_flag;
> +    __be16    source_data_type;
> +    __be16    error_flags;
> +    __be64    source_address;
> +    __be64    source_len;
> +    __be64    bytes_dumped;
> +    __be64    destination_address;
> +};
> +
> +/* ibm,configure-kernel-dump header. */
> +struct FadumpSectionHeader {
> +    __be32    dump_format_version;
> +    __be16    dump_num_sections;
> +    __be16    dump_status_flag;
> +    __be32    offset_first_dump_section;
> +
> +    /* Fields for disk dump option. */
> +    __be32    dd_block_size;
> +    __be64    dd_block_offset;
> +    __be64    dd_num_blocks;
> +    __be32    dd_offset_disk_path;
> +
> +    /* Maximum time allowed to prevent an automatic dump-reboot. */
> +    __be32    max_time_auto;
> +};
> +
> +/* Note: All the data in these structures is in big-endian */
> +struct FadumpMemStruct {
> +    FadumpSectionHeader header;
> +    FadumpSection       rgn[FADUMP_MAX_SECTIONS];
> +};
> +
> +uint32_t do_fadump_register(void);
> +#endif /* PPC_SPAPR_FADUMP_H */


