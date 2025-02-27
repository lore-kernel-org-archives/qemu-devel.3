Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB26C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXtU-0001EJ-Hz; Thu, 27 Feb 2025 02:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tnXtS-0001BH-71; Thu, 27 Feb 2025 02:01:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tnXtP-0006IH-Ro; Thu, 27 Feb 2025 02:01:13 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R21eAX006266;
 Thu, 27 Feb 2025 07:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YEwMoS
 do3MLtyCF91hsl4twJlBdvzco9K1z89F2qHLo=; b=r9m614YbWyUPupkiMEwfRA
 ja0q596HiudNLD1wzqZvqNq2IK8qqin+WLvB2/ZPw3/vBWJzdzOYESZM+lPDO5nB
 iGiHpRIQj4IgUd0sk6RV9zogmI8LB1j6x4Jq2k+Ih6PNuTizMwMzf8y8NuZppbF+
 r4tL4kMRAgMxuyzKBD3pFAYxe5laftzRXGFCynYFIxJQ8/DuR3qy0mv0Cg6lHXem
 6d4GGc0gfE3xIDd9z9giycjGTQ5tk9moke9bHS4Q5lIF1ueGK0u0i82Q3SctxJDQ
 3rRvYJMcfHCt96Z5WOFYzZmvgB6HfZF7XM/qX2327rtf9BSbA7sgazm1GbeiAMHw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452ew0h1ut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 07:01:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51R70c1O029311;
 Thu, 27 Feb 2025 07:01:09 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452ew0h1ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 07:01:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51R3Pek2027327;
 Thu, 27 Feb 2025 07:01:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum26t12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 07:01:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51R715fQ36962576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 07:01:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BE3D20043;
 Thu, 27 Feb 2025 07:01:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D35020040;
 Thu, 27 Feb 2025 07:01:03 +0000 (GMT)
Received: from [9.124.211.149] (unknown [9.124.211.149])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Feb 2025 07:01:03 +0000 (GMT)
Message-ID: <dec641b5-6baa-49f3-993d-2bb77694bcbc@linux.ibm.com>
Date: Thu, 27 Feb 2025 12:31:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/ppc: Implement saving CPU state in Fadump
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-5-adityag@linux.ibm.com>
 <D82WPYZ2R1DS.2JC91G6HRY0U7@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D82WPYZ2R1DS.2JC91G6HRY0U7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xKRuJ0ILvbfYjo_dBArnGrk4YQb3KYKt
X-Proofpoint-ORIG-GUID: Oh_962I_zfuQ0AmEMsG7EdTJJ6I4Jz5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270052
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On 27/02/25 08:57, Nicholas Piggin wrote:

> On Mon Feb 17, 2025 at 5:17 PM AEST, Aditya Gupta wrote:
>> <...snip...>
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index 9b29cadab2c9..0aca4270aee8 100644
>> <...snip...>
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -413,9 +416,174 @@ static bool fadump_preserve_mem(void)
>>           }
>>   
>>           switch (data_type) {
>> -        case FADUMP_CPU_STATE_DATA:
>> -            /* TODO: Add CPU state data */
>> +        case FADUMP_CPU_STATE_DATA: {
> I would split these out into their own functions if they grow more than
> a few lines.
Makes sense. Will add this into a new helper function.
>
>> +            struct rtas_fadump_reg_save_area_header reg_save_hdr;
>> +            struct rtas_fadump_reg_entry **reg_entries;
>> +            struct rtas_fadump_reg_entry *curr_reg_entry;
>> +
>> +            uint32_t fadump_reg_entries_size;
>> +            __be32 num_cpus = 0;
>> +            uint32_t num_regs_per_cpu = 0;
>> +            CPUState *cpu;
>> +            CPUPPCState *env;
>> +            PowerPCCPU *ppc_cpu;
>> +
>> +            CPU_FOREACH(cpu) {
>> +                ++num_cpus;
>> +            }
>> +
>> +            reg_save_hdr.version = cpu_to_be32(1);
>> +            reg_save_hdr.magic_number =
>> +                cpu_to_be64(fadump_str_to_u64("REGSAVE"));
>> +
>> +            /* Reg save area header is immediately followed by num cpus */
>> +            reg_save_hdr.num_cpu_offset =
>> +                cpu_to_be32(sizeof(struct rtas_fadump_reg_save_area_header));
>> +
>> +            fadump_reg_entries_size = num_cpus *
>> +                                      FADUMP_NUM_PER_CPU_REGS *
>> +                                      sizeof(struct rtas_fadump_reg_entry);
>> +
>> +            reg_entries = malloc(fadump_reg_entries_size);
>> +            curr_reg_entry = (struct rtas_fadump_reg_entry *)reg_entries;
>> +
>> +            /* This must loop num_cpus time */
>> +            CPU_FOREACH(cpu) {
>> +                ppc_cpu = POWERPC_CPU(cpu);
>> +                env = cpu_env(cpu);
>> +                num_regs_per_cpu = 0;
>> +
>> +                curr_reg_entry->reg_id =
>> +                    cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
>> +                curr_reg_entry->reg_value = ppc_cpu->vcpu_id;
>> +                ++curr_reg_entry;
>> +
>> +#define REG_ENTRY(id, val)                                     \
>> +                do {                                           \
>> +                    curr_reg_entry->reg_id =                   \
>> +                        cpu_to_be64(fadump_str_to_u64(#id));   \
>> +                    curr_reg_entry->reg_value = val;           \
>> +                    ++curr_reg_entry;                          \
>> +                    ++num_regs_per_cpu;                        \
>> +                } while (0)
>> +
>> +                REG_ENTRY(ACOP, env->spr[SPR_ACOP]);
>> +                REG_ENTRY(AMR, env->spr[SPR_AMR]);
>> +                REG_ENTRY(BESCR, env->spr[SPR_BESCR]);
>> +                REG_ENTRY(CFAR, env->spr[SPR_CFAR]);
>> +                REG_ENTRY(CIABR, env->spr[SPR_CIABR]);
>> +
>> +                /* Save the condition register */
>> +                uint64_t cr = 0;
>> +                cr |= (env->crf[0] & 0xf);
>> +                cr |= (env->crf[1] & 0xf) << 1;
>> +                cr |= (env->crf[2] & 0xf) << 2;
>> +                cr |= (env->crf[3] & 0xf) << 3;
>> +                cr |= (env->crf[4] & 0xf) << 4;
>> +                cr |= (env->crf[5] & 0xf) << 5;
>> +                cr |= (env->crf[6] & 0xf) << 6;
>> +                cr |= (env->crf[7] & 0xf) << 7;
> Shift values wrong here I think... Use ppc_get_cr()
Okay, I had some issues getting this CR. Will use 'ppc_get_cr', thanks !
>
>> +                REG_ENTRY(CR, cr);
>> +
>> +                REG_ENTRY(CTR, env->spr[SPR_CTR]);
>> +                REG_ENTRY(CTRL, env->spr[SPR_CTRL]);
>> +                REG_ENTRY(DABR, env->spr[SPR_DABR]);
>> +                REG_ENTRY(DABRX, env->spr[SPR_DABRX]);
>> +                REG_ENTRY(DAR, env->spr[SPR_DAR]);
>> +                REG_ENTRY(DAWR0, env->spr[SPR_DAWR0]);
>> +                REG_ENTRY(DAWR1, env->spr[SPR_DAWR1]);
>> +                REG_ENTRY(DAWRX0, env->spr[SPR_DAWRX0]);
>> +                REG_ENTRY(DAWRX1, env->spr[SPR_DAWRX1]);
>> +                REG_ENTRY(DPDES, env->spr[SPR_DPDES]);
>> +                REG_ENTRY(DSCR, env->spr[SPR_DSCR]);
>> +                REG_ENTRY(DSISR, env->spr[SPR_DSISR]);
>> +                REG_ENTRY(EBBHR, env->spr[SPR_EBBHR]);
>> +                REG_ENTRY(EBBRR, env->spr[SPR_EBBRR]);
>> +
>> +                REG_ENTRY(FPSCR, env->fpscr);
>> +                REG_ENTRY(FSCR, env->spr[SPR_FSCR]);
>> +
>> +                /* Save the GPRs */
>> +                for (int gpr_id = 0; gpr_id < 32; ++gpr_id) {
>> +                    curr_reg_entry->reg_id =
>> +                        cpu_to_be64(fadump_gpr_id_to_u64(gpr_id));
>> +                    curr_reg_entry->reg_value = env->gpr[i];
>> +                    ++curr_reg_entry;
>> +                    ++num_regs_per_cpu;
>> +                }
>> +
>> +                REG_ENTRY(IAMR, env->spr[SPR_IAMR]);
>> +                REG_ENTRY(IC, env->spr[SPR_IC]);
>> +                REG_ENTRY(LR, env->spr[SPR_LR]);
>> +
>> +                REG_ENTRY(MSR, env->msr);
>> +                REG_ENTRY(NIA, env->nip);   /* NIA */
>> +                REG_ENTRY(PIR, env->spr[SPR_PIR]);
>> +                REG_ENTRY(PSPB, env->spr[SPR_PSPB]);
>> +                REG_ENTRY(PVR, env->spr[SPR_PVR]);
>> +                REG_ENTRY(RPR, env->spr[SPR_RPR]);
>> +                REG_ENTRY(SPURR, env->spr[SPR_SPURR]);
>> +                REG_ENTRY(SRR0, env->spr[SPR_SRR0]);
>> +                REG_ENTRY(SRR1, env->spr[SPR_SRR1]);
>> +                REG_ENTRY(TAR, env->spr[SPR_TAR]);
>> +                REG_ENTRY(TEXASR, env->spr[SPR_TEXASR]);
>> +                REG_ENTRY(TFHAR, env->spr[SPR_TFHAR]);
>> +                REG_ENTRY(TFIAR, env->spr[SPR_TFIAR]);
>> +                REG_ENTRY(TIR, env->spr[SPR_TIR]);
>> +                REG_ENTRY(UAMOR, env->spr[SPR_UAMOR]);
>> +                REG_ENTRY(VRSAVE, env->spr[SPR_VRSAVE]);
>> +                REG_ENTRY(VSCR, env->vscr);
>> +                REG_ENTRY(VTB, env->spr[SPR_VTB]);
>> +                REG_ENTRY(WORT, env->spr[SPR_WORT]);
>> +                REG_ENTRY(XER, env->spr[SPR_XER]);
>> +
>> +                /*
>> +                 * Ignoring transaction checkpoint and few other registers
>> +                 * mentioned in PAPR as not supported in QEMU
>> +                 */
>> +#undef REG_ENTRY
>> +
>> +                /* End the registers for this CPU with "CPUEND" reg entry */
>> +                curr_reg_entry->reg_id =
>> +                    cpu_to_be64(fadump_str_to_u64("CPUEND"));
>> +
>> +                /* Ensure the number of registers match (+2 for STRT & END) */
>> +                assert(FADUMP_NUM_PER_CPU_REGS == num_regs_per_cpu + 2);
>> +
>> +                ++curr_reg_entry;
>> +            }
>> +
>> +            cpu_state_len = 0;
>> +            cpu_state_len += sizeof(reg_save_hdr);     /* reg save header */
>> +            cpu_state_len += sizeof(__be32);           /* num_cpus */
>> +            cpu_state_len += fadump_reg_entries_size;  /* reg entries */
>> +
>> +            cpu_state_region = &fdm->rgn[i];
>> +            cpu_state_addr = dest_addr;
>> +            cpu_state_buffer = g_malloc(cpu_state_len);
>> +
>> +            uint64_t offset = 0;
>> +            memcpy(cpu_state_buffer + offset,
>> +                    &reg_save_hdr, sizeof(reg_save_hdr));
>> +            offset += sizeof(reg_save_hdr);
>> +
>> +            /* Write num_cpus */
>> +            num_cpus = cpu_to_be32(num_cpus);
>> +            memcpy(cpu_state_buffer + offset, &num_cpus, sizeof(__be32));
>> +            offset += sizeof(__be32);
>> +
>> +            /* Write the register entries */
>> +            memcpy(cpu_state_buffer + offset,
>> +                    reg_entries, fadump_reg_entries_size);
>> +            offset += fadump_reg_entries_size;
>> +
>> +            /*
>> +             * We will write the cpu state data later, as otherwise it
>> +             * might get overwritten by other fadump regions
>> +             */
>> +
>>               break;
>> +        }
>>           case FADUMP_HPTE_REGION:
>>               /* TODO: Add hpte state data */
>>               break;
>> @@ -455,6 +623,34 @@ static bool fadump_preserve_mem(void)
>>           }
>>       }
>>   
>> +    /*
>> +     * Write the Register Save Area
>> +     *
>> +     * CPU State/Register Save Area should be written after dumping the
>> +     * memory to prevent overwritting while saving other memory regions
>> +     *
>> +     * eg. If boot memory region is 1G, then both the first 1GB memory, and
>> +     * the Register Save Area needs to be saved at 1GB.
>> +     * And as the CPU_STATE_DATA region comes first than the
>> +     * REAL_MODE_REGION region to be copied, the CPU_STATE_DATA will get
>> +     * overwritten if saved before the 0GB - 1GB region is copied after
>> +     * saving CPU state data
>> +     */
>> +    cpu_physical_memory_write(cpu_state_addr, cpu_state_buffer, cpu_state_len);
> Check docs/devel/loads-stores.rst, address_space_* is preferred to check
> for failures. It also says devices should operate on their own address
> spaces and that doesn't really apply to spapr since the "virtual
> hypervisor" doesn't really fit the model of a device...
>
> Perhaps look at h_enter_nested which uses CPU(cpu)->as.
Got it. Will try to use address_space_read/write in v2.
>> +    g_free(cpu_state_buffer);
>> +
>> +    /*
>> +     * Set bytes_dumped in cpu state region, so kernel knows platform have
>> +     * exported it
>> +     */
>> +    cpu_state_region->bytes_dumped = cpu_to_be64(cpu_state_len);
>> +
>> +    if (cpu_state_region->source_len != cpu_state_region->bytes_dumped) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                "CPU State region's length passed by kernel, doesn't match"
>> +                " with CPU State region length exported by QEMU");
>> +    }
>> +
>>       return true;
>>   }
>>   
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index a80704187583..0e8002bad9e0 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -792,6 +792,9 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
>>   #define FADUMP_HPTE_REGION      0x0002
>>   #define FADUMP_REAL_MODE_REGION 0x0011
>>   
>> +/* Number of registers stored per cpu */
>> +#define FADUMP_NUM_PER_CPU_REGS (32 /*GPR*/ + 45 /*others*/ + 2 /*STRT & END*/)
>> +
>>   /* OS defined sections */
>>   #define FADUMP_PARAM_AREA       0x0100
>>   
>> @@ -845,6 +848,86 @@ struct rtas_fadump_mem_struct {
>>       struct rtas_fadump_section        rgn[FADUMP_MAX_SECTIONS];
>>   };
>>   
>> +/*
>> + * The firmware-assisted dump format.
>> + *
>> + * The register save area is an area in the partition's memory used to preserve
>> + * the register contents (CPU state data) for the active CPUs during a firmware
>> + * assisted dump. The dump format contains register save area header followed
>> + * by register entries. Each list of registers for a CPU starts with "CPUSTRT"
>> + * and ends with "CPUEND".
>> + */
>> +
>> +/* Register save area header. */
>> +struct rtas_fadump_reg_save_area_header {
>> +    __be64    magic_number;
>> +    __be32    version;
>> +    __be32    num_cpu_offset;
>> +};
>> +
>> +/* Register entry. */
>> +struct rtas_fadump_reg_entry {
>> +    __be64    reg_id;
>> +    __be64    reg_value;
>> +};
>> +
>> +/*
>> + * Copy the ascii values for first 8 characters from a string into u64
>> + * variable at their respective indexes.
>> + * e.g.
>> + *  The string "FADMPINF" will be converted into 0x4641444d50494e46
>> + */
>> +static inline uint64_t fadump_str_to_u64(const char *str)
>> +{
>> +    uint64_t val = 0;
>> +    int i;
>> +
>> +    for (i = 0; i < sizeof(val); i++) {
>> +        val = (*str) ? (val << 8) | *str++ : val << 8;
>> +    }
>> +    return val;
>> +}
>> +
>> +/**
>> + * Get the identifier id for register entries of GPRs
>> + *
>> + * It gives the same id as 'fadump_str_to_u64' when the complete string id
>> + * of the GPR is given, ie.
>> + *
>> + *   fadump_str_to_u64("GPR05") == fadump_gpr_id_to_u64(5);
>> + *   fadump_str_to_u64("GPR12") == fadump_gpr_id_to_u64(12);
>> + *
>> + * And so on. Hence this can be implemented by creating a dynamic
>> + * string for each GPR, such as "GPR00", "GPR01", ... "GPR31"
>> + * Instead of allocating a string, an observation from the math of
>> + * 'fadump_str_to_u64' or from PAPR tells us that there's a pattern
>> + * in the identifier IDs, such that the first 8 bytes are affected only by
>> + * whether it is GPR0*, GPR1*, GPR2*, GPR3*. 9th byte is always 0x3. And
>> + * the the 10th byte is the index of the GPR modulo 10.
>> + */
>> +static inline uint64_t fadump_gpr_id_to_u64(uint32_t gpr_id)
>> +{
>> +    uint64_t val = 0;
>> +
>> +    /* Valid range of GPR id is only GPR0 to GPR31 */
>> +    assert(gpr_id < 32);
>> +
>> +    if (gpr_id <= 9) {
>> +        val = fadump_str_to_u64("GPR0");
>> +    } else if (gpr_id <= 19) {
>> +        val = fadump_str_to_u64("GPR1");
>> +    } else if (gpr_id <= 29) {
>> +        val = fadump_str_to_u64("GPR2");
>> +    } else {
>> +        val = fadump_str_to_u64("GPR3");
>> +    }
>> +
>> +    val |= 0x30000000;
>> +    val |= ((gpr_id % 10) << 12);
>> +
>> +    return val;
>> +}
> These two functions could probably go out of line, I doubt they
> are performance critical and make them static if not used outside
> the file.

True, have marked them static (but in a header file), can see I can move 
it into some .c file if not needed to be shared.


Thanks for your reviews Nick.


- Aditya G

>
> Thanks,
> Nick

