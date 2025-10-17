Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEF8CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kH8-00013g-Pp; Fri, 17 Oct 2025 09:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1v9fb1-0006fd-Mb; Fri, 17 Oct 2025 04:13:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1v9faw-0008EN-Rq; Fri, 17 Oct 2025 04:13:55 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H6SrZj021059;
 Fri, 17 Oct 2025 08:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jE/ew2
 66+5wHl82JDcNmpsY0zWi4YVBbUe2r9CckZyk=; b=aKma4JmakE+MHtxijPmEkm
 2AFpyAUJncImzxkRKpO0CEjxNJl6D3oBUT5AD2D639ej+bPOBPyoUgs+IhFc2VBe
 5iQbxUq3K4FRIwvwEDNZq7bNWpuFXJJtjaYm6Gvb8Zm3g/uARyskoKuwRiZBsxTM
 09VQFOADefufOPE85NhvMV8JCwcG7q6dFQyX0IS9CUS9J23SkQZ9o5yaxzqylTAV
 D3Kau89c+VgLBTZ+xAxG0/oRH8RceuF8VieI086mD9tJRzPXpmkvUc7eOXWU2tGR
 Do1ZffCmykeBle7whqncBtQoGXvLSTGop1o1EQK3aneVeyVXtGCVu21izcgcOlxA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0e8c0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 08:13:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59H7v5UR008059;
 Fri, 17 Oct 2025 08:13:40 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0e8by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 08:13:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7Jrwn014981;
 Fri, 17 Oct 2025 08:13:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjswsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 08:13:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59H8DZlA49873226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 08:13:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEB08201F3;
 Fri, 17 Oct 2025 07:51:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0BA9201EC;
 Fri, 17 Oct 2025 07:51:35 +0000 (GMT)
Received: from [9.124.221.21] (unknown [9.124.221.21])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 07:51:35 +0000 (GMT)
Message-ID: <51a2ae35-a40c-44c3-b72f-aa5580433cbc@linux.ibm.com>
Date: Fri, 17 Oct 2025 13:21:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/ppc: Implement skeleton code for fadump in
 PSeries
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250313192341.132171-1-adityag@linux.ibm.com>
 <20250313192341.132171-2-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20250313192341.132171-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iGQrR3KuEOl9aC6IAP1t9sEjY_fR2d4v
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f1fab4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=4bwDFNG5ePBMsAPI1C8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXxwvis1d+twLh
 nZ5claqQXGUHuFd3kx3NcmTWoeDUP+77ZjsTbZZXiNYNGoI23k4HHNHsgmtWyLNvdEj1Z4UBD1f
 rc7Or+DkbiKy4jVYF/MVGvLgb10/Jb8PY+33PY1SBf+wmMU6KpzSaGBNFQvzb5yhzLzFcLUDU2T
 GtmEL6vDhHWDbwFgYB2ovRf9Rv/zxB8v5SpSy7IzsvAZ5TwHL2W6aOQ8aVGweAVLqjC5xQFtgf+
 akmo5tP938JWgJ1OSoY77y9LTqdL0PK/gpujrli+Fbo3zwBD3/oJoOlipzC8DX6ZbVeAqF25av2
 GJHX6CpKQs/ye6dETefTdb+SN2799JRDNjMfNUWfK41aJcKuej8OyWPHzia+dB3z7GmBAtU0inT
 96Bnd0nqyL25ZaQIZHIMt56zZL+fMQ==
X-Proofpoint-GUID: rFUnAT65FkE3TDAz-b17-jpaaRozrIBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 17 Oct 2025 09:13:15 -0400
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

Hello Aditya,

On 14/03/25 00:53, Aditya Gupta wrote:
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

No rtas_st for above failure?

> +        return;
> +    }
> +
> +    /* Number of inputs has to be 3 */
> +    if (nargs != 3) {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);

No qemu_log_mask for the above failure?

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

fadump_dump_active is bool, so comparing with an integer is not needed.

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
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADump: Nothing to invalidate, no dump active\n");
> +        }
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


As per the PAPR:
Error code -9 is for the case where dump is active and kernel try to 
register fadump.
The correct Error code for the case where kernel try to register fadump 
when it is already registered is -8.

Refer section R1–7.3.30–4 and R1–7.3.30–5

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

Please move RTAS_FADUMP_MAX_BOOT_MEM_REGS to the respective patch
if it’s used; otherwise, remove it if it’s not needed.

> +
> +typedef struct FadumpSection FadumpSection;
> +typedef struct FadumpSectionHeader FadumpSectionHeader;
> +typedef struct FadumpMemStruct FadumpMemStruct;
> +
> +struct SpaprMachineState;

Didn't understand the reason for the above forward declaration here?

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


