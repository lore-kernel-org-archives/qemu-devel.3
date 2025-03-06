Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6FCC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 04:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq2kZ-0001LG-GY; Wed, 05 Mar 2025 23:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tq2kX-0001Ky-Un; Wed, 05 Mar 2025 23:22:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tq2kV-0008Ig-Ci; Wed, 05 Mar 2025 23:22:21 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525KcZC7027401;
 Thu, 6 Mar 2025 04:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=x6/hwl
 4Psm9b54OfzeUMezvCwp5Ez3rVLEkGc0BQemY=; b=cS8LOBA5rnhYpfTA829+Mf
 sWf77Pa4l/fzlk/qFnLIy17k75vnCez6HzaYMoZfBYLEQ0K00yaINbJgRDHxK+N7
 rU3NJFMHqmYSiYQby3l2xvk7PZRNzXJ/MyKS47iegYPMQNvw7tCk6deESj95wEde
 OlyJ3AnMHVTyKN4+23VvfDhMRNSzhN3Ni9+ospqYRsg+orE701TioX5/mofB79+A
 OYtsOX53HH+xYGt37Tk8rhLT99Ep1RU1bKeHBRbErql86Ds1i/pPJ9S+eGkUrcCO
 QguALhWldxXlsYZuQ8DT77j5+ZiHzMuoKD2+XGnTaersmxwmawryj+WJ8LWiNxwA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wu01jve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 04:22:15 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5264HpHY011671;
 Thu, 6 Mar 2025 04:22:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wu01jva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 04:22:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52620DIt013776;
 Thu, 6 Mar 2025 04:22:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kxjdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 04:22:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5264MAX019595738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 04:22:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9BF52004B;
 Thu,  6 Mar 2025 04:22:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 876FD20040;
 Thu,  6 Mar 2025 04:22:08 +0000 (GMT)
Received: from [9.124.214.147] (unknown [9.124.214.147])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 04:22:08 +0000 (GMT)
Message-ID: <d141c027-72dc-40f0-be0a-303690dfd424@linux.ibm.com>
Date: Thu, 6 Mar 2025 09:52:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/ppc: Implement saving CPU state in Fadump
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-5-adityag@linux.ibm.com>
 <33bb8b6e-5a48-4242-9a52-598aff99fbbe@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <33bb8b6e-5a48-4242-9a52-598aff99fbbe@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y7nsN_XNqlkAFB9s4674ZzV6AKkFl4We
X-Proofpoint-ORIG-GUID: bDsB7--7nRIcXHzQ6NSLxV3zhggqzTtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_02,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060025
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 05/03/25 12:53, Harsh Prateek Bora wrote:

>
>
> On 2/17/25 12:47, Aditya Gupta wrote:
>> <...snip...>
>>
>> +        case FADUMP_CPU_STATE_DATA: {
>> +            struct rtas_fadump_reg_save_area_header reg_save_hdr;
>> +            struct rtas_fadump_reg_entry **reg_entries;
>> +            struct rtas_fadump_reg_entry *curr_reg_entry;
>> +
>> +            uint32_t fadump_reg_entries_size;
>> +            __be32 num_cpus = 0;
>> +            uint32_t num_regs_per_cpu = 0;
>> +            CPUState *cpu;
>> +            CPUPPCState *env;
>> +            PowerPCCPU *ppc_cpu;
>> +
>> +            CPU_FOREACH(cpu) {
>> +                ++num_cpus;
>> +            }
>> +
>> +            reg_save_hdr.version = cpu_to_be32(1);
>
> PAPR spec mentions version value as 0. Do we need to update ?
Yes, will fix, thanks Harsh.
>
>> +            reg_save_hdr.magic_number =
>> +                cpu_to_be64(fadump_str_to_u64("REGSAVE"));
>> +
>> +            /* Reg save area header is immediately followed by num 
>> cpus */
>> +            reg_save_hdr.num_cpu_offset =
>> +                cpu_to_be32(sizeof(struct 
>> rtas_fadump_reg_save_area_header));
>> +
>
> Above inits could go into a helper 
> fadump_init_reg_save_header(&reg_save_hdr);
> BTW, the PAPR spec also mentions about padding followed by 
> num_cpus_offset, see another comment later below.
>
>
>> +            fadump_reg_entries_size = num_cpus *
>> +                                      FADUMP_NUM_PER_CPU_REGS *
>> +                                      sizeof(struct 
>> rtas_fadump_reg_entry);
>> +
>> +            reg_entries = malloc(fadump_reg_entries_size);
>
> This was declared as double pointer, but being used as a pointer.
Agreed, not needed to keep it as double pointer. My initial plan for 
this variable was different, that's why i was using double pointer 
earlier to point to a list of CPU registers, and each CPU registers 
itself an array. Not needed in current implementation. Will fix it.
>
>> +            curr_reg_entry = (struct rtas_fadump_reg_entry 
>> *)reg_entries;
>> +
>> +            /* This must loop num_cpus time */
>> +            CPU_FOREACH(cpu) {
>> +                ppc_cpu = POWERPC_CPU(cpu);
>> +                env = cpu_env(cpu);
>> +                num_regs_per_cpu = 0;
>> +
>> +                curr_reg_entry->reg_id =
>> +                    cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
>> +                curr_reg_entry->reg_value = ppc_cpu->vcpu_id;
>> +                ++curr_reg_entry;
>> +
>> +#define REG_ENTRY(id, val) \
>> +                do { \
>> +                    curr_reg_entry->reg_id =                   \
>> +                        cpu_to_be64(fadump_str_to_u64(#id)); \
>> +                    curr_reg_entry->reg_value = val;           \
>> +                    ++curr_reg_entry; \
>> +                    ++num_regs_per_cpu; \
>> +                } while (0)
>> +
>> +                REG_ENTRY(ACOP, env->spr[SPR_ACOP]);
>> +                REG_ENTRY(AMR, env->spr[SPR_AMR]);
>> +                REG_ENTRY(BESCR, env->spr[SPR_BESCR]);
>> +                REG_ENTRY(CFAR, env->spr[SPR_CFAR]);
>> +                REG_ENTRY(CIABR, env->spr[SPR_CIABR]);
>> +
>> +                /* Save the condition register */
>> +                uint64_t cr = 0;
>> +                cr |= (env->crf[0] & 0xf);
>> +                cr |= (env->crf[1] & 0xf) << 1;
>> +                cr |= (env->crf[2] & 0xf) << 2;
>> +                cr |= (env->crf[3] & 0xf) << 3;
>> +                cr |= (env->crf[4] & 0xf) << 4;
>> +                cr |= (env->crf[5] & 0xf) << 5;
>> +                cr |= (env->crf[6] & 0xf) << 6;
>> +                cr |= (env->crf[7] & 0xf) << 7;
>> +                REG_ENTRY(CR, cr);
>
> ppc_get_cr ?
Thanks, will use it.
>
>> +
>> +                REG_ENTRY(CTR, env->spr[SPR_CTR]);
>> +                REG_ENTRY(CTRL, env->spr[SPR_CTRL]);
>> +                REG_ENTRY(DABR, env->spr[SPR_DABR]);
>> +                REG_ENTRY(DABRX, env->spr[SPR_DABRX]);
>> +                REG_ENTRY(DAR, env->spr[SPR_DAR]);
>> +                REG_ENTRY(DAWR0, env->spr[SPR_DAWR0]);
>> +                REG_ENTRY(DAWR1, env->spr[SPR_DAWR1]);
>> +                REG_ENTRY(DAWRX0, env->spr[SPR_DAWRX0]);
>> +                REG_ENTRY(DAWRX1, env->spr[SPR_DAWRX1]);
>> +                REG_ENTRY(DPDES, env->spr[SPR_DPDES]);
>> +                REG_ENTRY(DSCR, env->spr[SPR_DSCR]);
>> +                REG_ENTRY(DSISR, env->spr[SPR_DSISR]);
>> +                REG_ENTRY(EBBHR, env->spr[SPR_EBBHR]);
>> +                REG_ENTRY(EBBRR, env->spr[SPR_EBBRR]);
>> +
>> +                REG_ENTRY(FPSCR, env->fpscr);
>> +                REG_ENTRY(FSCR, env->spr[SPR_FSCR]);
>> +
>> +                /* Save the GPRs */
>> +                for (int gpr_id = 0; gpr_id < 32; ++gpr_id) {
>> +                    curr_reg_entry->reg_id =
>> + cpu_to_be64(fadump_gpr_id_to_u64(gpr_id));
>> +                    curr_reg_entry->reg_value = env->gpr[i];
>> +                    ++curr_reg_entry;
>> +                    ++num_regs_per_cpu;
>> +                }
>> +
>> +                REG_ENTRY(IAMR, env->spr[SPR_IAMR]);
>> +                REG_ENTRY(IC, env->spr[SPR_IC]);
>> +                REG_ENTRY(LR, env->spr[SPR_LR]);
>> +
>> +                REG_ENTRY(MSR, env->msr);
>> +                REG_ENTRY(NIA, env->nip);   /* NIA */
>> +                REG_ENTRY(PIR, env->spr[SPR_PIR]);
>> +                REG_ENTRY(PSPB, env->spr[SPR_PSPB]);
>> +                REG_ENTRY(PVR, env->spr[SPR_PVR]);
>> +                REG_ENTRY(RPR, env->spr[SPR_RPR]);
>> +                REG_ENTRY(SPURR, env->spr[SPR_SPURR]);
>> +                REG_ENTRY(SRR0, env->spr[SPR_SRR0]);
>> +                REG_ENTRY(SRR1, env->spr[SPR_SRR1]);
>> +                REG_ENTRY(TAR, env->spr[SPR_TAR]);
>> +                REG_ENTRY(TEXASR, env->spr[SPR_TEXASR]);
>> +                REG_ENTRY(TFHAR, env->spr[SPR_TFHAR]);
>> +                REG_ENTRY(TFIAR, env->spr[SPR_TFIAR]);
>> +                REG_ENTRY(TIR, env->spr[SPR_TIR]);
>> +                REG_ENTRY(UAMOR, env->spr[SPR_UAMOR]);
>> +                REG_ENTRY(VRSAVE, env->spr[SPR_VRSAVE]);
>> +                REG_ENTRY(VSCR, env->vscr);
>> +                REG_ENTRY(VTB, env->spr[SPR_VTB]);
>> +                REG_ENTRY(WORT, env->spr[SPR_WORT]);
>> +                REG_ENTRY(XER, env->spr[SPR_XER]);
>> +
>> +                /*
>> +                 * Ignoring transaction checkpoint and few other 
>> registers
>> +                 * mentioned in PAPR as not supported in QEMU
>> +                 */
>> +#undef REG_ENTRY
>> +
>> +                /* End the registers for this CPU with "CPUEND" reg 
>> entry */
>> +                curr_reg_entry->reg_id =
>> +                    cpu_to_be64(fadump_str_to_u64("CPUEND"));
>> +
>> +                /* Ensure the number of registers match (+2 for STRT 
>> & END) */
>> +                assert(FADUMP_NUM_PER_CPU_REGS == num_regs_per_cpu + 
>> 2);
>> +
>> +                ++curr_reg_entry;
>> +            }
>> +
>> +            cpu_state_len = 0;
>> +            cpu_state_len += sizeof(reg_save_hdr);     /* reg save 
>> header */
>> +            cpu_state_len += sizeof(__be32);           /* num_cpus */
>> +            cpu_state_len += fadump_reg_entries_size;  /* reg 
>> entries */
>> +
>
> above 4 inits could be a single line init.
Yes it could be, but i kept it this way as it looks more readable to me 
with the comments, what do you think ?
>
>> +            cpu_state_region = &fdm->rgn[i];
>> +            cpu_state_addr = dest_addr;
>> +            cpu_state_buffer = g_malloc(cpu_state_len);
>> +
>> +            uint64_t offset = 0;
>> +            memcpy(cpu_state_buffer + offset,
>> +                    &reg_save_hdr, sizeof(reg_save_hdr));
>> +            offset += sizeof(reg_save_hdr);
>> +
>> +            /* Write num_cpus */
>> +            num_cpus = cpu_to_be32(num_cpus);
>> +            memcpy(cpu_state_buffer + offset, &num_cpus, 
>> sizeof(__be32));
>> +            offset += sizeof(__be32);
>
> As per PAPR spec, NumCpusOffset is followed by a padding of 0xC bytes
> initialized to 0. Any reasons for skipping that here ?
Missed that padding, didn't notice as kernel also was picking up the 
correct num cpus in my testing, will fix this, and see how the kernel 
got the correct value then.
>
>> +
>> +            /* Write the register entries */
>> +            memcpy(cpu_state_buffer + offset,
>> +                    reg_entries, fadump_reg_entries_size);
>> +            offset += fadump_reg_entries_size;
>> +
>> +            /*
>> +             * We will write the cpu state data later, as otherwise it
>> +             * might get overwritten by other fadump regions
>> +             */
>> +
>
> Better to have a separate routine fadump_preserve_cpu_state_data() 
> when the switch case logic grows this large, applies wherever applicable.
Yes, multiple switch cases have huge logic in my patches, will move them 
to helpers.
>
>>               break;
>> +        }
>>           case FADUMP_HPTE_REGION:
>>               /* TODO: Add hpte state data */
>>               break;
>> @@ -455,6 +623,34 @@ static bool fadump_preserve_mem(void)
>>           }
>>       }
>>   +    /*
>> +     * Write the Register Save Area
>> +     *
>> +     * CPU State/Register Save Area should be written after dumping the
>> +     * memory to prevent overwritting while saving other memory regions
>> +     *
>> +     * eg. If boot memory region is 1G, then both the first 1GB 
>> memory, and
>> +     * the Register Save Area needs to be saved at 1GB.
>> +     * And as the CPU_STATE_DATA region comes first than the
>> +     * REAL_MODE_REGION region to be copied, the CPU_STATE_DATA will 
>> get
>> +     * overwritten if saved before the 0GB - 1GB region is copied after
>> +     * saving CPU state data
>> +     */
>> +    cpu_physical_memory_write(cpu_state_addr, cpu_state_buffer, 
>> cpu_state_len);
>> +    g_free(cpu_state_buffer);
>> +
>> +    /*
>> +     * Set bytes_dumped in cpu state region, so kernel knows 
>> platform have
>> +     * exported it
>> +     */
>> +    cpu_state_region->bytes_dumped = cpu_to_be64(cpu_state_len);
>> +
>> +    if (cpu_state_region->source_len != 
>> cpu_state_region->bytes_dumped) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                "CPU State region's length passed by kernel, doesn't 
>> match"
>> +                " with CPU State region length exported by QEMU");
>
>           return error ?

Yes, will return PARAM_ERROR here ?


Thanks Harsh for the detailed reviews.

- Aditya Gupta



