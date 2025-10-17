Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3039CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kHJ-00023X-Ne; Fri, 17 Oct 2025 09:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1v9kAT-0001zg-Dm; Fri, 17 Oct 2025 09:06:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1v9kAM-0003yl-2s; Fri, 17 Oct 2025 09:06:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8gqD6021747;
 Fri, 17 Oct 2025 13:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9jGg9J
 PdwGoyuLKlPLsy1dms3MUXOTYXDbheTRD0FJo=; b=JPIhFMDjjSl5uTsyhiGU1W
 STYRbjYIL1gdg+6yanWC2Fr5vtDNWbB83NYgT0KRxp0DAUF+OIH6F16kBQPMteAj
 oEeB28Ghpjcf3jKFDwqnMlQO8Ea3pizkv2sUxHd+jz8kuKFEJmWYIBUSAF1xv3s0
 YfF8Nju35ph9xdDY/wfFsIx/ATOKBvdeHJPm/HaXcWxlRfPDwILsNcUO2KJamfp1
 K9Ix6r0hmR4plB2HEEnJYHZcpAiS8/WpbR5KRyTKcfxx4ALlVLE64rK03hFIu2h1
 FLv83TpdbtDCVQ4+jf0R5CXKmm/izCE3hUveY0BQGW0ph52IMKpFe0/fgBoKzUfA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0hab3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 13:06:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HD6YRi018630;
 Fri, 17 Oct 2025 13:06:34 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0hab2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 13:06:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HD1Ymh015002;
 Fri, 17 Oct 2025 13:06:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjw4cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 13:06:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HD6U6751839454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 13:06:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25076200D2;
 Fri, 17 Oct 2025 13:06:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E2C52006A;
 Fri, 17 Oct 2025 13:06:28 +0000 (GMT)
Received: from [9.124.221.21] (unknown [9.124.221.21])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 13:06:27 +0000 (GMT)
Message-ID: <e032c9c2-1df3-40db-9d74-4a115f612da4@linux.ibm.com>
Date: Fri, 17 Oct 2025 18:36:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] hw/ppc: Preserve memory regions registered for
 fadump
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-5-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20250323174007.221116-5-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -8sgUpG9weV8CBwFbXih-Wh6L3hm-Rdt
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f23f5b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=nAr4IrdYd7bBxpyDJhUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX9BPzRkMEAwLV
 Jbd+YmHwAqA2VnvhT1HI7PiFHvHGFBC4HuNjYbckg62DbfeDdRp86PJ95NWVS0iBkY4YJwpyJjm
 OW5yyZPT/xMhg1flnGOjeQ1u3bdD1iNRg1kbuxnPsjAn2cvwJEoVTs6X0yHyFerRfoz0dIbMrE8
 ukXniJpSThMgWwYM6YG4nuUtimH9fx+ANzzY1Ah/DkNyqSRmjBOAXbg0R9Jn1mUh88x1DQcwHky
 WKjJXYif1PhYyVTg6YjKVAnnDokqowBozlSldD2akRMIow+iA4C1Y49LB3fvw376alXJNMhpRE2
 /n0GftaKb6n+ZkmeNjROyjyyL8evfzz6xeD4NYvlIPIY+1qAO3cBX+msD2YnY7yebv293FhDMF3
 PlA2fv3sB1FbtxkLT/lD2cOwU9l64Q==
X-Proofpoint-GUID: 4JQVm97dtJnNG3aX1Plcllc8FpEzbUGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
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
X-Mailman-Approved-At: Fri, 17 Oct 2025 09:13:28 -0400
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
> Note: As of this patch, the "kernel-dump" device tree entry is still not
> added for the second boot, so after crash, the second kernel will boot
> assuming fadump dump is "NOT" active, and try to register for fadump,
> but since we already have fadump registered in QEMU internal state, the
> register rtas call will fail with: "DUMP ACTIVE"
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/spapr_fadump.c         | 161 ++++++++++++++++++++++++++++++++--
>   include/hw/ppc/spapr_fadump.h |  18 ++++
>   2 files changed, 174 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> index fedd2cde9a4f..c105b8d21da5 100644
> --- a/hw/ppc/spapr_fadump.c
> +++ b/hw/ppc/spapr_fadump.c
> @@ -123,14 +123,165 @@ uint32_t do_fadump_register(SpaprMachineState *spapr, target_ulong args)
>       return RTAS_OUT_SUCCESS;
>   }
>   
> +/*
> + * Copy the source region of given fadump section, to the destination
> + * address mentioned in the region
> + *
> + * Also set the region's error flag, if the copy fails due to non-existent
> + * address (MEMTX_DECODE_ERROR) or permission issues (MEMTX_ACCESS_ERROR)
> + *
> + * Returns true if successful copy
> + *
> + * Returns false in case of any other error, being treated as hardware
> + * error for fadump purposes
> + */
> +static bool do_preserve_region(FadumpSection *region)
> +{
> +    AddressSpace *default_as = &address_space_memory;
> +    MemTxResult io_result;
> +    MemTxAttrs attrs;
> +    uint64_t src_addr, src_len, dest_addr;
> +    g_autofree void *copy_buffer = NULL;
> +
> +    src_addr  = be64_to_cpu(region->source_address);
> +    src_len   = be64_to_cpu(region->source_len);
> +    dest_addr = be64_to_cpu(region->destination_address);
> +
> +    /* Mark the memory transaction as privileged memory access */
> +    attrs.user = 0;
> +    attrs.memory = 1;
> +
> +    /*
> +     * Optimisation: Skip copy if source and destination are same
> +     * (eg. param area)
> +     */
> +    if (src_addr != dest_addr) {
> +        /*
> +         * Using 'g_try_malloc' as the source length is coming from kernel,
> +         * which can be invalid/huge, due to which allocation can fail
> +         */
> +        copy_buffer = g_try_malloc(src_len + 1);

The region size could be in GBs. I think it is better to do it in chunks.

And don't we need to free the copy_buffer?

> +        if (copy_buffer == NULL) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADump: Failed allocating memory (size: %ld) for copying"
> +                " reserved memory regions\n", src_len);
> +
> +            return false;
> +        }
> +
> +        /* Copy the source region to destination */
> +        io_result = address_space_read(default_as, src_addr, attrs,
> +                copy_buffer, src_len);
> +        if ((io_result & MEMTX_DECODE_ERROR) ||
> +            (io_result & MEMTX_ACCESS_ERROR)) {
> +            /*
> +             * Invalid source address is not an hardware error, instead
> +             * wrong parameter from the kernel.
> +             * Return true to let caller know to continue reading other
> +             * sections
> +             */
> +            region->error_flags = FADUMP_ERROR_INVALID_SOURCE_ADDR;
> +            region->bytes_dumped = 0;
> +            return true;
> +        } else if (io_result != MEMTX_OK) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADump: Failed to read source region in section: %d\n",
> +                region->source_data_type);
> +
> +            return false;
> +        }
> +
> +        io_result = address_space_write(default_as, dest_addr, attrs,
> +                copy_buffer, src_len);
> +        if ((io_result & MEMTX_DECODE_ERROR) ||
> +            (io_result & MEMTX_ACCESS_ERROR)) {
> +            /*
> +             * Invalid destination address is not an hardware error,
> +             * instead wrong parameter from the kernel.
> +             * Return true to let caller know to continue reading other
> +             * sections

Logging MEMTX_DECODE_ERROR would help identify kernel bugs. I think
we should log this for both read and write.

> +             */
> +            region->error_flags = FADUMP_ERROR_INVALID_DEST_ADDR;
> +            region->bytes_dumped = 0;

Seems like caller is already setting bytes_dump to 0. But even if you 
wanna do here.
How about setting region->bytes_dumped = 0 early to avoid setting at 
multiple
places?

In cases you need to free the copy_buffer I recommend having an exit label
in this function.

> +            return true;
> +        } else if (io_result != MEMTX_OK) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADump: Failed to write destination in section: %d\n",
> +                region->source_data_type);
> +
> +            return false;
> +        }
> +    }
> +
> +    /*
> +     * Considering address_space_write would have copied the
> +     * complete region
> +     */
> +    region->bytes_dumped = cpu_to_be64(src_len);
> +    return true;
> +}
> +
>   /* Preserve the memory locations registered for fadump */
> -static bool fadump_preserve_mem(void)
> +static bool fadump_preserve_mem(SpaprMachineState *spapr)
>   {
> +    FadumpMemStruct *fdm = &spapr->registered_fdm;
> +    uint16_t dump_num_sections, data_type;
> +
> +    assert(spapr->fadump_registered);
> +
>       /*
> -     * TODO: Implement preserving memory regions requested during fadump
> -     * registration
> +     * Handle all sections
> +     *
> +     * CPU State Data and HPTE regions are handled in their own cases
> +     *
> +     * RMR regions and any custom OS reserved regions such as parameter
> +     * save area, are handled by simply copying the source region to
> +     * destination address
>        */
> -    return false;
> +    dump_num_sections = be16_to_cpu(fdm->header.dump_num_sections);
> +    for (int i = 0; i < dump_num_sections; ++i) {
> +        data_type = be16_to_cpu(fdm->rgn[i].source_data_type);
> +
> +        /* Reset error_flags & bytes_dumped for now */
> +        fdm->rgn[i].error_flags = 0;
> +        fdm->rgn[i].bytes_dumped = 0;
> +
> +        /* If kernel did not request for the memory region, then skip it */
> +        if (be32_to_cpu(fdm->rgn[i].request_flag) != FADUMP_REQUEST_FLAG) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "FADump: Skipping copying region as not requested\n");
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
> +            /* Copy the memory region from region's source to its destination */
> +            if (!do_preserve_region(&fdm->rgn[i])) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                    "FADump: Failed to preserve dump section: %d\n",
> +                    be16_to_cpu(fdm->rgn[i].source_data_type));
> +                fdm->header.dump_status_flag |=
> +                    cpu_to_be16(FADUMP_STATUS_DUMP_ERROR);
> +            }
> +
> +            break;
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADump: Skipping unknown source data type: %d\n", data_type);
> +
> +            fdm->rgn[i].error_flags =
> +                cpu_to_be16(FADUMP_ERROR_INVALID_DATA_TYPE);
> +        }
> +    }
> +
> +    return true;

This function only returns true. Since caller has some action when this 
function
returns false I am considering there is something wrong in this function.

If this suppose to return true always then lets not have return at all.

>   }
>   
>   /*
> @@ -151,7 +302,7 @@ void trigger_fadump_boot(SpaprMachineState *spapr, target_ulong spapr_retcode)
>       pause_all_vcpus();
>   
>       /* Preserve the memory locations registered for fadump */
> -    if (!fadump_preserve_mem()) {
> +    if (!fadump_preserve_mem(spapr)) {
>           /* Failed to preserve the registered memory regions */
>           rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
>   
> diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
> index e484604c1c70..d56ca1d6d651 100644
> --- a/include/hw/ppc/spapr_fadump.h
> +++ b/include/hw/ppc/spapr_fadump.h
> @@ -16,11 +16,29 @@
>   
>   #define FADUMP_VERSION                 1
>   
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
>   /* Dump status flags */
>   #define FADUMP_STATUS_DUMP_PERFORMED            0x8000
>   #define FADUMP_STATUS_DUMP_TRIGGERED            0x4000
>   #define FADUMP_STATUS_DUMP_ERROR                0x2000
>   
> +/* Region dump error flags */
> +#define FADUMP_ERROR_INVALID_DATA_TYPE          0x8000
> +#define FADUMP_ERROR_INVALID_SOURCE_ADDR        0x4000
> +#define FADUMP_ERROR_LENGTH_EXCEEDS_SOURCE      0x2000
> +#define FADUMP_ERROR_INVALID_DEST_ADDR          0x1000
> +#define FAUDMP_ERROR_DEST_TOO_SMALL             0x0800
> +
>   /*
>    * The Firmware Assisted Dump Memory structure supports a maximum of 10 sections
>    * in the dump memory structure. Presently, three sections are used for


