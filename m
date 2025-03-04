Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA51C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 09:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpO9d-0007kj-9o; Tue, 04 Mar 2025 04:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tpO9Z-0007kC-Ji; Tue, 04 Mar 2025 04:01:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tpO9X-0000NW-6a; Tue, 04 Mar 2025 04:01:29 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523K08Rf022808;
 Tue, 4 Mar 2025 09:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Fiz9mG
 sD8kwTcpqeWFMbrywR9eZz3xhGXLuzZ+SH9n0=; b=Z1fJJfHN3PdDJj/rWH6I1e
 pTJ7hvMFfjj3xgUdMJGM9rd+4vjSeX2G2VwLV/GCspTUafDDjgeu+h6foLeLawWd
 wX3ul+RuyX/OqTtXjrb75dOGiPNI8Lq3OfLZg7LUypD7ZP+kdkV9KkbEM8kSfUIw
 LeIGrR67NLaoQYPLlBCCkDEu516D7ZA/Xj2UCWpW+0wiHtR39nVxeYNl1Idjenre
 IOUBpGKkXsmvGmAMgqynZnKPVLtJtaBJMteFzgNAlX4TGQ9i/lHRZrV3Up+nynDO
 xE3Yv1baZNHTRCNy5znLz5mYWx69mKD3pmlQMSTDLSnvrccoV8gTvS3RLokrHzjw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455dunwkqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 09:01:22 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5248t22c024949;
 Tue, 4 Mar 2025 09:01:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455dunwkqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 09:01:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52489urQ013776;
 Tue, 4 Mar 2025 09:01:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kmf26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 09:01:21 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52491KV224511130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Mar 2025 09:01:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0226A58062;
 Tue,  4 Mar 2025 09:01:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE76A58056;
 Tue,  4 Mar 2025 09:01:17 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Mar 2025 09:01:17 +0000 (GMT)
Message-ID: <8d530fc3-0b7f-4c2b-b8ad-fe41fbbd58e8@linux.ibm.com>
Date: Tue, 4 Mar 2025 14:31:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/ppc: Implement skeleton code for fadump in PSeries
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-2-adityag@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250217071711.83735-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: STF2sFXPyHTCAxzw9I2XBlqAhIgiuEFk
X-Proofpoint-GUID: tTvgDTy-lJFbf2kHUioCgef7FnJ6A9Sf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_04,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0
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
> Implement the handler for "ibm,configure-kernel-dump" rtas call in QEMU.
> 
> Currently the handler just does basic checks and handles
> register/unregister/invalidate requests from kernel.
> 
> Fadump will be enabled in a later patch.

Let's use FADump or fadump for consistency.

> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/spapr_rtas.c    | 99 ++++++++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/spapr.h | 59 +++++++++++++++++++++++++
>   2 files changed, 158 insertions(+)
> 
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index df2e837632aa..eebdf13b1552 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -341,6 +341,105 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
>       rtas_st(rets, 0, ret);
>   }
>   
> +struct fadump_metadata fadump_metadata;
> +
> +/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
> +static __attribute((unused)) void rtas_configure_kernel_dump(PowerPCCPU *cpu,

This __attribute shall be avoided if the function can be introduced when 
actually get used.

> +                                   SpaprMachineState *spapr,
> +                                   uint32_t token, uint32_t nargs,
> +                                   target_ulong args,
> +                                   uint32_t nret, target_ulong rets)
> +{
> +    struct rtas_fadump_section_header header;
> +    target_ulong cmd = rtas_ld(args, 0);
> +    target_ulong fdm_addr = rtas_ld(args, 1);
> +    target_ulong fdm_size = rtas_ld(args, 2);
> +
> +    /* Number outputs has to be 1 */
> +    if (nret != 1) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADUMP: ibm,configure-kernel-dump RTAS called with nret != 1.\n");

Some of the error cases are using hcall_dprintf below. Let's use same
for consistency. Also, shouldn't this case also return 
RTAS_OUT_PARAM_ERROR ?

> +        return;
> +    }
> +
> +    /* Number inputs has to be 3 */
> +    if (nargs != 3) {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);

Log error ?

> +        return;
> +    }
> +
> +    switch (cmd) {
> +    case FADUMP_CMD_REGISTER:
> +        if (fadump_metadata.fadump_registered) {
> +            /* Fadump already registered */
> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ALREADY_REGISTERED);

Log error ?

> +            return;
> +        }
> +
> +        if (fadump_metadata.fadump_dump_active == 1) {
> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);

Log error?

> +            return;
> +        }
> +
> +        if (fdm_size < sizeof(struct rtas_fadump_section_header)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADUMP: Header size is invalid: %lu\n", fdm_size);
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +            return;
> +        }
> +
> +        /* XXX: Can we ensure fdm_addr points to a valid RMR-memory buffer ? */
> +        if (fdm_addr <= 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADUMP: Invalid fdm address: %ld\n", fdm_addr);
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +            return;
> +        }
> +
> +        /* Verify that we understand the fadump header version */
> +        cpu_physical_memory_read(fdm_addr, &header, sizeof(header));
> +        if (header.dump_format_version != cpu_to_be32(FADUMP_VERSION)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADUMP: Unknown fadump header version: 0x%x\n",
> +                header.dump_format_version);
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +            return;
> +        }
> +
> +        fadump_metadata.fadump_registered = true;
> +        fadump_metadata.fadump_dump_active = false;
> +        fadump_metadata.fdm_addr = fdm_addr;
> +        break;
> +    case FADUMP_CMD_UNREGISTER:
> +        if (fadump_metadata.fadump_dump_active == 1) {
> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);

Log error?

> +            return;
> +        }
> +
> +        fadump_metadata.fadump_registered = false;
> +        fadump_metadata.fadump_dump_active = false;
> +        fadump_metadata.fdm_addr = -1;
> +        break;
> +    case FADUMP_CMD_INVALIDATE:
> +        if (fadump_metadata.fadump_dump_active) {
> +            fadump_metadata.fadump_registered = false;
> +            fadump_metadata.fadump_dump_active = false;
> +            fadump_metadata.fdm_addr = -1;
> +            memset(&fadump_metadata.registered_fdm, 0,
> +                    sizeof(fadump_metadata.registered_fdm));
> +        } else {
> +            hcall_dprintf("fadump: Nothing to invalidate, no dump active.\n");

Isnt this an error case? Should it return status as error or success ?

> +        }
> +        break;
> +    default:
> +        hcall_dprintf("Unknown RTAS token 0x%x\n", token);
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
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a6c0547e313d..efa2f891a8a7 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -704,6 +704,8 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
>   #define RTAS_OUT_PARAM_ERROR                    -3
>   #define RTAS_OUT_NOT_SUPPORTED                  -3
>   #define RTAS_OUT_NO_SUCH_INDICATOR              -3
> +#define RTAS_OUT_DUMP_ALREADY_REGISTERED        -9
> +#define RTAS_OUT_DUMP_ACTIVE                    -10
>   #define RTAS_OUT_NOT_AUTHORIZED                 -9002
>   #define RTAS_OUT_SYSPARM_PARAM_ERROR            -9999
>   
> @@ -769,6 +771,63 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
>   
>   #define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
>   
> +/* Fadump commands */
> +#define FADUMP_CMD_REGISTER            1
> +#define FADUMP_CMD_UNREGISTER          2
> +#define FADUMP_CMD_INVALIDATE          3
> +
> +#define FADUMP_VERSION    1
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
> +/* Kernel Dump section info */
> +struct rtas_fadump_section {
> +    __be32    request_flag;
> +    __be16    source_data_type;
> +    __be16    error_flags;
> +    __be64    source_address;
> +    __be64    source_len;
> +    __be64    bytes_dumped;
> +    __be64    destination_address;
> +};

Please refer docs/devel/style.rst for Naming style. CamelCase for structs.

> +
> +/* ibm,configure-kernel-dump header. */
> +struct rtas_fadump_section_header {
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
> +struct rtas_fadump_mem_struct {
> +    struct rtas_fadump_section_header header;
> +    struct rtas_fadump_section        rgn[FADUMP_MAX_SECTIONS];
> +};
> +
> +struct fadump_metadata {
> +    bool fadump_registered;
> +    bool fadump_dump_active;
> +    target_ulong fdm_addr;
> +    struct rtas_fadump_mem_struct registered_fdm;
> +};
> +extern struct fadump_metadata fadump_metadata;
> +
>   /* RTAS ibm,get-system-parameter token values */
>   #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
>   #define RTAS_SYSPARM_DIAGNOSTICS_RUN_MODE        42

