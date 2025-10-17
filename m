Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAB7CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kHH-0001p7-RE; Fri, 17 Oct 2025 09:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1v9hAj-0001Nr-5E; Fri, 17 Oct 2025 05:54:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1v9hAe-0007SD-7e; Fri, 17 Oct 2025 05:54:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8qq9n020930;
 Fri, 17 Oct 2025 09:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5aJR/H
 Njjycyscge4fXNZCeuoXJGH1pmzTjpQvhCfjE=; b=JotSNWi6EOWUpB6My/AWHc
 IMj2Chmc3FJhy+tVoKV3J/s9cEkRBSPSRF+WQAfvUkPQEMNz4syfBX7bPrdrT0gf
 jnok5uuDhtTz30Nhwo1UHZmV1JGUCMKRtZiaM7I5Bv25occMgAeS3MGPUrmohzCz
 dazBgNg2ZNKK5gRlmn5RK+60nHEYw8p4dfSxjDKbmO13BO6R+r+NDsDlgmH50x6X
 lZ8MvygIdUVucO8ScrAkv0N8TCeZ4snyP4AkExG9bImgq2bGERsOfgtRjK5yhbG3
 3aBpYBz/0kzfPIF8U3RzjLIjtzUOJA9ZSUz8Pbc0d0SIq1jmH3SNfUMoMSQwYhQA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0ggtx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 09:54:44 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59H9YKiU000933;
 Fri, 17 Oct 2025 09:54:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0ggtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 09:54:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9Itkb018862;
 Fri, 17 Oct 2025 09:54:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jn4ph6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 09:54:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59H9scIe34865878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 09:54:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB50D200D5;
 Fri, 17 Oct 2025 09:54:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C36CF200D9;
 Fri, 17 Oct 2025 09:54:36 +0000 (GMT)
Received: from [9.124.221.21] (unknown [9.124.221.21])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 09:54:36 +0000 (GMT)
Message-ID: <c57386c9-4f55-4ab0-bf3a-082c4c010dc4@linux.ibm.com>
Date: Fri, 17 Oct 2025 15:24:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] hw/ppc: Implement fadump register command
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-3-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20250323174007.221116-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bk9SEc3A5fNeb_Db96ZI0u2fCvS1HSH3
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f21264 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=d7JIcH21TxKwP3S5C7sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX4FxuBxSrO4Cu
 RhZa/SeJr+BKGRopnMyBQrXJAACEbEZ7ETiu8la4oV9Om+YYiAcfGVVKPpSnDN879M6Sghj9hRZ
 Uph9NtRnOKjKaP1dk1N5SH4K6u99aJf/xPQX4IPo1gRN/Nsvhip4BgWhEfEG/bFRuEJCHuyl4+/
 RVj0hw9g3rZJOWGm8QVjq6SwruT5P2Yu7jY8y6ZiZjWR8JwLKQlarCYzQipNvw4xFpL6bI41tIP
 Y6AyksEJmO+nTlRTTSPlnj2AuyM8KC8dYaEqpILs1Xznx0FII3M+9+/LK7RMVORxOHj6dN+xaVc
 FEblE6CpfMZSVhAdNdTTxZkQ2go6QqF0tt/+2IyckIFaM1KbvtUKVOmEbxJFGjUgOBaCBIlftcB
 G9x3VYjcUNFuqZJDWysaYkjuq9dr0g==
X-Proofpoint-GUID: _t0dVwwuaVfE3ANFU28MSiXkODO298M1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, LONGWORDS=2.035, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 17 Oct 2025 09:13:19 -0400
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
> Implement the register command of "ibm,configure-kernel-dump" RTAS call.
> The register just verifies the structure of the fadump memory structure
> passed by kernel, and set fadump_registered in spapr state to true.
>
> We also store the passed fadump memory structure, which will later be
> used for preserving memory for fadump boot in case of a crash.
>
> The fadump memory structure isn't modified (other than .dump_status_flag
> after the fadump is triggered, that is in a later patch).
> So if the structure needs to updated, the kernel should first
> de-register and re-register the structure again.
>
> Relevant section for the register command in PAPR is:
>      Section 7.3.30: "ibm,configure-kernel-dump RTAS call" (PAPR v2.13)
>
> Note: The fadump registration is done, but triggering fadump on an
> os-term rtas call is done in later patches. Hence QEMU will just shutdown
> on a kernel crash due to no special handling for fadump in ibm,os-term
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/spapr_fadump.c         | 111 ++++++++++++++++++++++++++++++++--
>   hw/ppc/spapr_rtas.c           |   2 +-
>   include/hw/ppc/spapr_fadump.h |   2 +-
>   3 files changed, 108 insertions(+), 7 deletions(-)
>
> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> index 20b7b804c485..9c7fb9e12b16 100644
> --- a/hw/ppc/spapr_fadump.c
> +++ b/hw/ppc/spapr_fadump.c
> @@ -5,18 +5,119 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/log.h"
>   #include "hw/ppc/spapr.h"
>   
>   /*
>    * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
>    *
> + * Note: Any changes made by the kernel to the fadump memory struct won't
> + * reflect in QEMU after the 'ibm,configure-kernel-dump' RTAS call has returned,
> + * as we store the passed fadump memory structure passed during fadump
passed fadump memory structure passed... is not easy to understand; how 
about?

Note: Any modifications made by the kernel to the fadump memory structure
after the 'ibm,configure-kernel-dump' RTAS call returns will not be 
reflected
in QEMU as QEMU retains the fadump memory structure that was provided
during fadump registration.

The kernel must invalidate and re-register fadump to apply any changes
to the fadump memory structure.

> + * registration.
> + * Kernel has to invalidate & re-register fadump, if it intends to make any
> + * changes to the fadump memory structure
> + *
>    * Returns:
> - *  * RTAS_OUT_HW_ERROR: Not implemented/Misc issue such as memory access
> - *                       failures
> + *  * RTAS_OUT_SUCCESS: On successful registration
> + *  * RTAS_OUT_PARAM_ERROR: If parameters are not correct, eg. too many
> + *                          sections, invalid memory addresses that we are
> + *                          unable to read, etc
> + *  * RTAS_OUT_DUMP_ALREADY_REGISTERED: Dump already registered
> + *  * RTAS_OUT_HW_ERROR: Misc issue such as memory access failures
>    */
> -uint32_t do_fadump_register(void)
> +uint32_t do_fadump_register(SpaprMachineState *spapr, target_ulong args)
>   {
> -    /* WIP: FADUMP_CMD_REGISTER implemented in future patch */
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
> +    if (spapr->fadump_dump_active == 1) {

fadump_dump_active is bool, so comparing with an integer is not needed.

> +        return RTAS_OUT_DUMP_ACTIVE;
> +    }
> +
> +    if (fdm_size < sizeof(FadumpSectionHeader)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: Header size is invalid: %lu\n", fdm_size);
> +        return RTAS_OUT_PARAM_ERROR;
> +    }
> +
> +    /* Ensure fdm_addr points to a valid RMR-memory/RMA-memory buffer */
> +    if ((fdm_addr <= 0) || ((fdm_addr + fdm_size) > spapr->rma_size)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: Invalid fdm address: %ld\n", fdm_addr);
> +        return RTAS_OUT_PARAM_ERROR;
> +    }
> +
> +    /* Try to read the passed fadump header */
> +    io_result = address_space_read(default_as, fdm_addr, attrs,
> +            &header, sizeof(header));
> +    if (io_result != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: Unable to read fdm address: %ld\n", fdm_addr);
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

Setting fadump_dump_active is not really required. Ideally, we shouldn't 
reach here
if it is set to true, or am I missing something?

> +
> +    /* Store the registered fadump memory struct */
> +    spapr->registered_fdm.header = header;
> +    for (int i = 0; i < dump_num_sections; ++i) {
> +        spapr->registered_fdm.rgn[i] = regions[i];
> +    }
>   
> -    return RTAS_OUT_HW_ERROR;
> +    return RTAS_OUT_SUCCESS;
>   }
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index b8bfa9c33fb5..0454938a01e9 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -366,7 +366,7 @@ static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
>   
>       switch (cmd) {
>       case FADUMP_CMD_REGISTER:
> -        ret_val = do_fadump_register();
> +        ret_val = do_fadump_register(spapr, args);
>           if (ret_val != RTAS_OUT_SUCCESS) {
>               rtas_st(rets, 0, ret_val);
>               return;
> diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
> index 45109fd9e137..6abbcb44f353 100644
> --- a/include/hw/ppc/spapr_fadump.h
> +++ b/include/hw/ppc/spapr_fadump.h
> @@ -65,5 +65,5 @@ struct FadumpMemStruct {
>       FadumpSection       rgn[FADUMP_MAX_SECTIONS];
>   };
>   
> -uint32_t do_fadump_register(void);
> +uint32_t do_fadump_register(struct SpaprMachineState *, target_ulong);

Seems like the forward declaration of struct SpaprMachineState done in 
01/08 is
because of the above change. Should we do there forward declaration here 
instead?

>   #endif /* PPC_SPAPR_FADUMP_H */


