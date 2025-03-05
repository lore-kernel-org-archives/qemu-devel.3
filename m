Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2095C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpj6j-00049r-2W; Wed, 05 Mar 2025 02:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tpj6U-00041i-VM; Wed, 05 Mar 2025 02:23:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tpj6P-0001py-9P; Wed, 05 Mar 2025 02:23:41 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524Mu6AX018948;
 Wed, 5 Mar 2025 07:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7wBl82
 JN8lCx0WdVytiZZHSdDhQgweYkbRic/gXt+hU=; b=qt4s1d1XFr482GF3zIzLvh
 tNdptH6lduKTgvYXhCZHqIP9RnZLuTG5d+68LoDm9CDfcq1xRc9Og7buVslnDV4T
 5jvozbHMSNTwoSozvfmMQfMUFcyunaawYz0P5gFNBI+WRqzJ4lS48yNLmh1EU+4m
 fS3gzV+txcmKXIsGf3dXcp/RDRChcZfOboQCCmcrutdR16f5sJVQcFB16JvIVS8x
 NkFDiakGfBNP6a9SnEXlGJ9lSaiGQ31iA8apwepUDPRjGf9lJpNmMQHYgd6Gs0z4
 Biy37hxk9OIEs08xIvSznyp29a34C0uYfTq+hB5RzzyGOEYq6bP2jK4SdkIRNtmA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4562xpm13p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 07:23:33 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5257Lr50012357;
 Wed, 5 Mar 2025 07:23:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4562xpm13k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 07:23:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5253fGuN013772;
 Wed, 5 Mar 2025 07:23:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2ksgp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 07:23:31 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5257NUdQ15467048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Mar 2025 07:23:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BD5358053;
 Wed,  5 Mar 2025 07:23:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 291B85805D;
 Wed,  5 Mar 2025 07:23:27 +0000 (GMT)
Received: from [9.39.18.13] (unknown [9.39.18.13])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Mar 2025 07:23:26 +0000 (GMT)
Message-ID: <33bb8b6e-5a48-4242-9a52-598aff99fbbe@linux.ibm.com>
Date: Wed, 5 Mar 2025 12:53:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/ppc: Implement saving CPU state in Fadump
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-5-adityag@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250217071711.83735-5-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: skNW-OFJtJiu0vf1S7_kfyf4UfSPUdoZ
X-Proofpoint-GUID: _ciEXMadOLTSdj7dgmRyvrY9JWICneS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050049
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
> Kernel expects CPU states/register states in the format mentioned in
> "Register Save Area" in PAPR.
> 
> The platform (in our case, QEMU) saves each CPU register in the form of
> an array of "register entries", the start and end of this array is
> signified by "CPUSTRT" and "CPUEND" register entries respectively.
> 
> The CPUSTRT and CPUEND register entry also has 4-byte logical CPU ID,
> thus storing the CPU ID corresponding to the array of register entries.
> 
> Each register, and CPUSTRT, CPUEND has a predefined identifier.
> Implement calculating identifier for a given register in
> 'fadump_str_to_u64', which has been taken from the linux kernel
> 
> Similarly GPRs also have predefined identifiers, and a corresponding
> 64-bit resiter value (split into two 32-bit cells). Implement
> calculation of GPR identifiers with 'fadump_gpr_id_to_u64'
> 
> PAPR has restrictions on particular order of few registers, and is
> free to be in any order for other registers.
> Some registers mentioned in PAPR have not been exported as they are not
> implemented in QEMU / don't make sense in QEMU.
> 
> Implement saving of CPU state according to the PAPR document
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/spapr_rtas.c    | 200 ++++++++++++++++++++++++++++++++++++++++-
>   include/hw/ppc/spapr.h |  83 +++++++++++++++++
>   2 files changed, 281 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 9b29cadab2c9..0aca4270aee8 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -348,9 +348,12 @@ bool is_next_boot_fadump;
>   static bool fadump_preserve_mem(void)
>   {
>       struct rtas_fadump_mem_struct *fdm = &fadump_metadata.registered_fdm;
> +    struct rtas_fadump_section *cpu_state_region;
>       uint64_t next_section_addr;
>       int dump_num_sections, data_type;
>       uint64_t src_addr, src_len, dest_addr;
> +    uint64_t cpu_state_addr, cpu_state_len = 0;
> +    void *cpu_state_buffer;
>       void *copy_buffer;
>   
>       assert(fadump_metadata.fadump_registered);
> @@ -413,9 +416,174 @@ static bool fadump_preserve_mem(void)
>           }
>   
>           switch (data_type) {
> -        case FADUMP_CPU_STATE_DATA:
> -            /* TODO: Add CPU state data */
> +        case FADUMP_CPU_STATE_DATA: {
> +            struct rtas_fadump_reg_save_area_header reg_save_hdr;
> +            struct rtas_fadump_reg_entry **reg_entries;
> +            struct rtas_fadump_reg_entry *curr_reg_entry;
> +
> +            uint32_t fadump_reg_entries_size;
> +            __be32 num_cpus = 0;
> +            uint32_t num_regs_per_cpu = 0;
> +            CPUState *cpu;
> +            CPUPPCState *env;
> +            PowerPCCPU *ppc_cpu;
> +
> +            CPU_FOREACH(cpu) {
> +                ++num_cpus;
> +            }
> +
> +            reg_save_hdr.version = cpu_to_be32(1);

PAPR spec mentions version value as 0. Do we need to update ?

> +            reg_save_hdr.magic_number =
> +                cpu_to_be64(fadump_str_to_u64("REGSAVE"));
> +
> +            /* Reg save area header is immediately followed by num cpus */
> +            reg_save_hdr.num_cpu_offset =
> +                cpu_to_be32(sizeof(struct rtas_fadump_reg_save_area_header));
> +

Above inits could go into a helper 
fadump_init_reg_save_header(&reg_save_hdr);
BTW, the PAPR spec also mentions about padding followed by 
num_cpus_offset, see another comment later below.


> +            fadump_reg_entries_size = num_cpus *
> +                                      FADUMP_NUM_PER_CPU_REGS *
> +                                      sizeof(struct rtas_fadump_reg_entry);
> +
> +            reg_entries = malloc(fadump_reg_entries_size);

This was declared as double pointer, but being used as a pointer.

> +            curr_reg_entry = (struct rtas_fadump_reg_entry *)reg_entries;
> +
> +            /* This must loop num_cpus time */
> +            CPU_FOREACH(cpu) {
> +                ppc_cpu = POWERPC_CPU(cpu);
> +                env = cpu_env(cpu);
> +                num_regs_per_cpu = 0;
> +
> +                curr_reg_entry->reg_id =
> +                    cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
> +                curr_reg_entry->reg_value = ppc_cpu->vcpu_id;
> +                ++curr_reg_entry;
> +
> +#define REG_ENTRY(id, val)                                     \
> +                do {                                           \
> +                    curr_reg_entry->reg_id =                   \
> +                        cpu_to_be64(fadump_str_to_u64(#id));   \
> +                    curr_reg_entry->reg_value = val;           \
> +                    ++curr_reg_entry;                          \
> +                    ++num_regs_per_cpu;                        \
> +                } while (0)
> +
> +                REG_ENTRY(ACOP, env->spr[SPR_ACOP]);
> +                REG_ENTRY(AMR, env->spr[SPR_AMR]);
> +                REG_ENTRY(BESCR, env->spr[SPR_BESCR]);
> +                REG_ENTRY(CFAR, env->spr[SPR_CFAR]);
> +                REG_ENTRY(CIABR, env->spr[SPR_CIABR]);
> +
> +                /* Save the condition register */
> +                uint64_t cr = 0;
> +                cr |= (env->crf[0] & 0xf);
> +                cr |= (env->crf[1] & 0xf) << 1;
> +                cr |= (env->crf[2] & 0xf) << 2;
> +                cr |= (env->crf[3] & 0xf) << 3;
> +                cr |= (env->crf[4] & 0xf) << 4;
> +                cr |= (env->crf[5] & 0xf) << 5;
> +                cr |= (env->crf[6] & 0xf) << 6;
> +                cr |= (env->crf[7] & 0xf) << 7;
> +                REG_ENTRY(CR, cr);

ppc_get_cr ?

> +
> +                REG_ENTRY(CTR, env->spr[SPR_CTR]);
> +                REG_ENTRY(CTRL, env->spr[SPR_CTRL]);
> +                REG_ENTRY(DABR, env->spr[SPR_DABR]);
> +                REG_ENTRY(DABRX, env->spr[SPR_DABRX]);
> +                REG_ENTRY(DAR, env->spr[SPR_DAR]);
> +                REG_ENTRY(DAWR0, env->spr[SPR_DAWR0]);
> +                REG_ENTRY(DAWR1, env->spr[SPR_DAWR1]);
> +                REG_ENTRY(DAWRX0, env->spr[SPR_DAWRX0]);
> +                REG_ENTRY(DAWRX1, env->spr[SPR_DAWRX1]);
> +                REG_ENTRY(DPDES, env->spr[SPR_DPDES]);
> +                REG_ENTRY(DSCR, env->spr[SPR_DSCR]);
> +                REG_ENTRY(DSISR, env->spr[SPR_DSISR]);
> +                REG_ENTRY(EBBHR, env->spr[SPR_EBBHR]);
> +                REG_ENTRY(EBBRR, env->spr[SPR_EBBRR]);
> +
> +                REG_ENTRY(FPSCR, env->fpscr);
> +                REG_ENTRY(FSCR, env->spr[SPR_FSCR]);
> +
> +                /* Save the GPRs */
> +                for (int gpr_id = 0; gpr_id < 32; ++gpr_id) {
> +                    curr_reg_entry->reg_id =
> +                        cpu_to_be64(fadump_gpr_id_to_u64(gpr_id));
> +                    curr_reg_entry->reg_value = env->gpr[i];
> +                    ++curr_reg_entry;
> +                    ++num_regs_per_cpu;
> +                }
> +
> +                REG_ENTRY(IAMR, env->spr[SPR_IAMR]);
> +                REG_ENTRY(IC, env->spr[SPR_IC]);
> +                REG_ENTRY(LR, env->spr[SPR_LR]);
> +
> +                REG_ENTRY(MSR, env->msr);
> +                REG_ENTRY(NIA, env->nip);   /* NIA */
> +                REG_ENTRY(PIR, env->spr[SPR_PIR]);
> +                REG_ENTRY(PSPB, env->spr[SPR_PSPB]);
> +                REG_ENTRY(PVR, env->spr[SPR_PVR]);
> +                REG_ENTRY(RPR, env->spr[SPR_RPR]);
> +                REG_ENTRY(SPURR, env->spr[SPR_SPURR]);
> +                REG_ENTRY(SRR0, env->spr[SPR_SRR0]);
> +                REG_ENTRY(SRR1, env->spr[SPR_SRR1]);
> +                REG_ENTRY(TAR, env->spr[SPR_TAR]);
> +                REG_ENTRY(TEXASR, env->spr[SPR_TEXASR]);
> +                REG_ENTRY(TFHAR, env->spr[SPR_TFHAR]);
> +                REG_ENTRY(TFIAR, env->spr[SPR_TFIAR]);
> +                REG_ENTRY(TIR, env->spr[SPR_TIR]);
> +                REG_ENTRY(UAMOR, env->spr[SPR_UAMOR]);
> +                REG_ENTRY(VRSAVE, env->spr[SPR_VRSAVE]);
> +                REG_ENTRY(VSCR, env->vscr);
> +                REG_ENTRY(VTB, env->spr[SPR_VTB]);
> +                REG_ENTRY(WORT, env->spr[SPR_WORT]);
> +                REG_ENTRY(XER, env->spr[SPR_XER]);
> +
> +                /*
> +                 * Ignoring transaction checkpoint and few other registers
> +                 * mentioned in PAPR as not supported in QEMU
> +                 */
> +#undef REG_ENTRY
> +
> +                /* End the registers for this CPU with "CPUEND" reg entry */
> +                curr_reg_entry->reg_id =
> +                    cpu_to_be64(fadump_str_to_u64("CPUEND"));
> +
> +                /* Ensure the number of registers match (+2 for STRT & END) */
> +                assert(FADUMP_NUM_PER_CPU_REGS == num_regs_per_cpu + 2);
> +
> +                ++curr_reg_entry;
> +            }
> +
> +            cpu_state_len = 0;
> +            cpu_state_len += sizeof(reg_save_hdr);     /* reg save header */
> +            cpu_state_len += sizeof(__be32);           /* num_cpus */
> +            cpu_state_len += fadump_reg_entries_size;  /* reg entries */
> +

above 4 inits could be a single line init.

> +            cpu_state_region = &fdm->rgn[i];
> +            cpu_state_addr = dest_addr;
> +            cpu_state_buffer = g_malloc(cpu_state_len);
> +
> +            uint64_t offset = 0;
> +            memcpy(cpu_state_buffer + offset,
> +                    &reg_save_hdr, sizeof(reg_save_hdr));
> +            offset += sizeof(reg_save_hdr);
> +
> +            /* Write num_cpus */
> +            num_cpus = cpu_to_be32(num_cpus);
> +            memcpy(cpu_state_buffer + offset, &num_cpus, sizeof(__be32));
> +            offset += sizeof(__be32);

As per PAPR spec, NumCpusOffset is followed by a padding of 0xC bytes
initialized to 0. Any reasons for skipping that here ?

> +
> +            /* Write the register entries */
> +            memcpy(cpu_state_buffer + offset,
> +                    reg_entries, fadump_reg_entries_size);
> +            offset += fadump_reg_entries_size;
> +
> +            /*
> +             * We will write the cpu state data later, as otherwise it
> +             * might get overwritten by other fadump regions
> +             */
> +

Better to have a separate routine fadump_preserve_cpu_state_data() when 
the switch case logic grows this large, applies wherever applicable.

>               break;
> +        }
>           case FADUMP_HPTE_REGION:
>               /* TODO: Add hpte state data */
>               break;
> @@ -455,6 +623,34 @@ static bool fadump_preserve_mem(void)
>           }
>       }
>   
> +    /*
> +     * Write the Register Save Area
> +     *
> +     * CPU State/Register Save Area should be written after dumping the
> +     * memory to prevent overwritting while saving other memory regions
> +     *
> +     * eg. If boot memory region is 1G, then both the first 1GB memory, and
> +     * the Register Save Area needs to be saved at 1GB.
> +     * And as the CPU_STATE_DATA region comes first than the
> +     * REAL_MODE_REGION region to be copied, the CPU_STATE_DATA will get
> +     * overwritten if saved before the 0GB - 1GB region is copied after
> +     * saving CPU state data
> +     */
> +    cpu_physical_memory_write(cpu_state_addr, cpu_state_buffer, cpu_state_len);
> +    g_free(cpu_state_buffer);
> +
> +    /*
> +     * Set bytes_dumped in cpu state region, so kernel knows platform have
> +     * exported it
> +     */
> +    cpu_state_region->bytes_dumped = cpu_to_be64(cpu_state_len);
> +
> +    if (cpu_state_region->source_len != cpu_state_region->bytes_dumped) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "CPU State region's length passed by kernel, doesn't match"
> +                " with CPU State region length exported by QEMU");

           return error ?

Thanks
Harsh
> +    }
> +
>       return true;
>   }
>   
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a80704187583..0e8002bad9e0 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -792,6 +792,9 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
>   #define FADUMP_HPTE_REGION      0x0002
>   #define FADUMP_REAL_MODE_REGION 0x0011
>   
> +/* Number of registers stored per cpu */
> +#define FADUMP_NUM_PER_CPU_REGS (32 /*GPR*/ + 45 /*others*/ + 2 /*STRT & END*/)
> +
>   /* OS defined sections */
>   #define FADUMP_PARAM_AREA       0x0100
>   
> @@ -845,6 +848,86 @@ struct rtas_fadump_mem_struct {
>       struct rtas_fadump_section        rgn[FADUMP_MAX_SECTIONS];
>   };
>   
> +/*
> + * The firmware-assisted dump format.
> + *
> + * The register save area is an area in the partition's memory used to preserve
> + * the register contents (CPU state data) for the active CPUs during a firmware
> + * assisted dump. The dump format contains register save area header followed
> + * by register entries. Each list of registers for a CPU starts with "CPUSTRT"
> + * and ends with "CPUEND".
> + */
> +
> +/* Register save area header. */
> +struct rtas_fadump_reg_save_area_header {
> +    __be64    magic_number;
> +    __be32    version;
> +    __be32    num_cpu_offset;
> +};
> +
> +/* Register entry. */
> +struct rtas_fadump_reg_entry {
> +    __be64    reg_id;
> +    __be64    reg_value;
> +};
> +
> +/*
> + * Copy the ascii values for first 8 characters from a string into u64
> + * variable at their respective indexes.
> + * e.g.
> + *  The string "FADMPINF" will be converted into 0x4641444d50494e46
> + */
> +static inline uint64_t fadump_str_to_u64(const char *str)
> +{
> +    uint64_t val = 0;
> +    int i;
> +
> +    for (i = 0; i < sizeof(val); i++) {
> +        val = (*str) ? (val << 8) | *str++ : val << 8;
> +    }
> +    return val;
> +}
> +
> +/**
> + * Get the identifier id for register entries of GPRs
> + *
> + * It gives the same id as 'fadump_str_to_u64' when the complete string id
> + * of the GPR is given, ie.
> + *
> + *   fadump_str_to_u64("GPR05") == fadump_gpr_id_to_u64(5);
> + *   fadump_str_to_u64("GPR12") == fadump_gpr_id_to_u64(12);
> + *
> + * And so on. Hence this can be implemented by creating a dynamic
> + * string for each GPR, such as "GPR00", "GPR01", ... "GPR31"
> + * Instead of allocating a string, an observation from the math of
> + * 'fadump_str_to_u64' or from PAPR tells us that there's a pattern
> + * in the identifier IDs, such that the first 8 bytes are affected only by
> + * whether it is GPR0*, GPR1*, GPR2*, GPR3*. 9th byte is always 0x3. And
> + * the the 10th byte is the index of the GPR modulo 10.
> + */
> +static inline uint64_t fadump_gpr_id_to_u64(uint32_t gpr_id)
> +{
> +    uint64_t val = 0;
> +
> +    /* Valid range of GPR id is only GPR0 to GPR31 */
> +    assert(gpr_id < 32);
> +
> +    if (gpr_id <= 9) {
> +        val = fadump_str_to_u64("GPR0");
> +    } else if (gpr_id <= 19) {
> +        val = fadump_str_to_u64("GPR1");
> +    } else if (gpr_id <= 29) {
> +        val = fadump_str_to_u64("GPR2");
> +    } else {
> +        val = fadump_str_to_u64("GPR3");
> +    }
> +
> +    val |= 0x30000000;
> +    val |= ((gpr_id % 10) << 12);
> +
> +    return val;
> +}
> +
>   struct fadump_metadata {
>       bool fadump_registered;
>       bool fadump_dump_active;

