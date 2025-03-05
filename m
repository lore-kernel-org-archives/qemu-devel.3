Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F415C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiR1-0000eV-K6; Wed, 05 Mar 2025 01:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tpiQx-0000YN-7m; Wed, 05 Mar 2025 01:40:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tpiQu-0001OB-Si; Wed, 05 Mar 2025 01:40:46 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524Kqa59028078;
 Wed, 5 Mar 2025 06:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IIxgX4
 OOZFEsJ2xo0jkYDDu4mtv3lh1OW8naT5ofDBU=; b=InPsNeTQVLRTocVN22C1k9
 iLauItc4lLDPowI0zLKbPaNbky8sR6LvuQzGYLHZLxOC8hyo347BrAYteTjIkJY8
 vChIHu+gSfAqhPnFkA1R3NGVwhlD7+/3BIrn8Yl1dp8UlLGCkohxSvbReBTMqblU
 kj64Hb5eUmqBOA9yfkCf/Svoqqtu5+W8y0B+lW305lWUNyjVrT5N8O9+uovGrRcn
 UaRP3CJ4jKSckfDAVGADUKoUMPVn+tU5BPWJF+ukr4ErkvZTrl3yb24fB8fGLKz1
 9w2mAqEinb33mlWQnZ+1GqQhlrNgVvKSY8Te1IWCOLxdccMY2JQ5/EY8vZlFhXpg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568x51ux7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 06:40:42 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5256biCs025361;
 Wed, 5 Mar 2025 06:40:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568x51ux5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 06:40:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52532Hfg020846;
 Wed, 5 Mar 2025 06:40:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnhf5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 06:40:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5256eefj31916608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Mar 2025 06:40:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F17758053;
 Wed,  5 Mar 2025 06:40:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A91358043;
 Wed,  5 Mar 2025 06:40:37 +0000 (GMT)
Received: from [9.39.18.13] (unknown [9.39.18.13])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Mar 2025 06:40:36 +0000 (GMT)
Message-ID: <f5494f6f-599f-427b-8c37-42cc5396c35d@linux.ibm.com>
Date: Wed, 5 Mar 2025 12:10:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] hw/ppc: Preserve memory regions registered for fadump
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-4-adityag@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250217071711.83735-4-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GUVsRbEh0gSO_8TYx181df4cWzHKC6aN
X-Proofpoint-ORIG-GUID: oU6XtI3Pj2tRvmPklI1BwhCLXWunIqiW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050049
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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



On 2/17/25 12:47, Aditya Gupta wrote:
> While the first kernel boots, it registers memory regions for fadump
> such as:
>      * CPU state data  (has to be populated by the platform)
>      * HPTE state data (has to be populated by the platform)
>      * Real Mode Regions (platform should copy it to requested
>        destination addresses)
>      * OS defined regions (such as parameter save area)
> 
> Platform is also expected to modify the 'bytes_dumped' to the length of
> data preserved/copied by platform (ideally same as the source length
> passed by kernel).
> 
> The kernel passes source address and length for the memory regions, and
> a destination address to where the memory is to be copied.
> 
> Implement the preserving/copying of the Real Mode Regions and the
> Parameter Save Area in QEMU Pseries
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/spapr_rtas.c    | 117 ++++++++++++++++++++++++++++++++++++++++-
>   include/hw/ppc/spapr.h |  27 +++++++++-
>   2 files changed, 142 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 01c82375f03d..9b29cadab2c9 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -344,6 +344,120 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
>   struct fadump_metadata fadump_metadata;
>   bool is_next_boot_fadump;
>   
> +/* Preserve the memory locations registered for fadump */
> +static bool fadump_preserve_mem(void)
> +{
> +    struct rtas_fadump_mem_struct *fdm = &fadump_metadata.registered_fdm;
> +    uint64_t next_section_addr;
> +    int dump_num_sections, data_type;
> +    uint64_t src_addr, src_len, dest_addr;
> +    void *copy_buffer;
> +
> +    assert(fadump_metadata.fadump_registered);
> +    assert(fadump_metadata.fdm_addr != -1);
> +
> +    /* Read the fadump header passed during fadump registration */
> +    cpu_physical_memory_read(fadump_metadata.fdm_addr,
> +            &fdm->header, sizeof(fdm->header));
> +
> +    /* Verify that we understand the fadump header version */
> +    if (fdm->header.dump_format_version != cpu_to_be32(FADUMP_VERSION)) {
> +        /*
> +         * Dump format version is unknown and likely changed from the time
> +         * of fadump registration. Back out now.
> +         */
> +        return false;
> +    }
> +
> +    dump_num_sections = be16_to_cpu(fdm->header.dump_num_sections);
> +
> +    if (dump_num_sections > FADUMP_MAX_SECTIONS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADUMP: Too many sections: %d\n", fdm->header.dump_num_sections);
> +        return false;
> +    }
> +
> +    next_section_addr =
> +        fadump_metadata.fdm_addr +
> +        be32_to_cpu(fdm->header.offset_first_dump_section);
> +
> +    /*
> +     * Handle all sections
> +     *
> +     * CPU State Data and HPTE regions are handled in their own cases
> +     *
> +     * RMR regions and any custom OS reserved regions such as parameter
> +     * save area, are handled by simply copying the source region to
> +     * destination address
> +     */
> +    for (int i = 0; i < dump_num_sections; ++i) {
> +        /* Read the fadump section from memory */
> +        cpu_physical_memory_read(next_section_addr,
> +                &fdm->rgn[i], sizeof(fdm->rgn[i]));
> +
> +        next_section_addr += sizeof(fdm->rgn[i]);
> +
> +        data_type = be16_to_cpu(fdm->rgn[i].source_data_type);
> +        src_addr  = be64_to_cpu(fdm->rgn[i].source_address);
> +        src_len   = be64_to_cpu(fdm->rgn[i].source_len);
> +        dest_addr = be64_to_cpu(fdm->rgn[i].destination_address);
> +
> +        /* Reset error_flags & bytes_dumped for now */
> +        fdm->rgn[i].error_flags = 0;
> +        fdm->rgn[i].bytes_dumped = 0;
> +
> +        if (be32_to_cpu(fdm->rgn[i].request_flag) != FADUMP_REQUEST_FLAG) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "FADUMP: Skipping copying region as not requested\n");
> +            continue;
> +        }
> +
> +        switch (data_type) {
> +        case FADUMP_CPU_STATE_DATA:
> +            /* TODO: Add CPU state data */
> +            break;
> +        case FADUMP_HPTE_REGION:
> +            /* TODO: Add hpte state data */
> +            break;
> +        case FADUMP_REAL_MODE_REGION:
> +        case FADUMP_PARAM_AREA:
> +            /* Skip copy if source and destination are same (eg. param area) */
> +            if (src_addr != dest_addr) {
> +                copy_buffer = g_malloc(src_len + 1);
> +                if (copy_buffer == NULL) {
> +                    qemu_log_mask(LOG_GUEST_ERROR,
> +                        "FADUMP: Failed allocating memory for copying reserved memory regions\n");
> +                    fdm->rgn[i].error_flags =
> +                        cpu_to_be16(FADUMP_ERROR_LENGTH_EXCEEDS_SOURCE);
> +
> +                    continue;
> +                }
> +
> +                /* Copy the source region to destination */
> +                cpu_physical_memory_read(src_addr, copy_buffer, src_len);
> +                cpu_physical_memory_write(dest_addr, copy_buffer, src_len);
> +                g_free(copy_buffer);
> +            }
> +
> +            /*
> +             * Considering cpu_physical_memory_write would have copied the
> +             * complete region
> +             */
> +            fdm->rgn[i].bytes_dumped = cpu_to_be64(src_len);

Is this really valid for FADUMP_PARAM_AREA where we intend to skip copy?

> +
> +            break;
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADUMP: Skipping unknown source data type: %d\n", data_type);
> +
> +            fdm->rgn[i].error_flags =
> +                cpu_to_be16(FADUMP_ERROR_INVALID_DATA_TYPE);
> +        }
> +    }
> +
> +    return true;
> +}
> +
>   static void trigger_fadump_boot(target_ulong spapr_retcode)
>   {
>       /*
> @@ -353,7 +467,8 @@ static void trigger_fadump_boot(target_ulong spapr_retcode)
>        */
>       pause_all_vcpus();
>   
> -    if (true /* TODO: Preserve memory registered for fadump */) {
> +    /* Preserve the memory locations registered for fadump */
> +    if (!fadump_preserve_mem()) {

This change can be avoided as suggested in previous patch.

>           /* Failed to preserve the registered memory regions */
>           rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
>   
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index efa2f891a8a7..a80704187583 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -776,7 +776,32 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
>   #define FADUMP_CMD_UNREGISTER          2
>   #define FADUMP_CMD_INVALIDATE          3
>   
> -#define FADUMP_VERSION    1
> +#define FADUMP_VERSION                 1

This change can be avoided if taken care initially.

Thanks
Harsh
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
> +/* Firmware provided dump sections */
> +#define FADUMP_CPU_STATE_DATA   0x0001
> +#define FADUMP_HPTE_REGION      0x0002
> +#define FADUMP_REAL_MODE_REGION 0x0011
> +
> +/* OS defined sections */
> +#define FADUMP_PARAM_AREA       0x0100
> +
> +/* Dump request flag */
> +#define FADUMP_REQUEST_FLAG     0x00000001
> +
> +/* Dump status flag */
> +#define FADUMP_ERROR_INVALID_DATA_TYPE          0x8000
> +#define FADUMP_ERROR_INVALID_SOURCE_ADDR        0x4000
> +#define FADUMP_ERROR_LENGTH_EXCEEDS_SOURCE      0x2000
>   
>   /*
>    * The Firmware Assisted Dump Memory structure supports a maximum of 10 sections

