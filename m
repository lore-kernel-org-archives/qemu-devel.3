Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0E4CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 07:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ZEc-000368-RO; Tue, 14 Oct 2025 03:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v8ZEa-00035l-Px; Tue, 14 Oct 2025 03:14:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v8ZEV-0002Ta-Gz; Tue, 14 Oct 2025 03:14:12 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DJcJWj004069;
 Tue, 14 Oct 2025 07:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pcnUwj
 1VCEbEl3lfKAIHu/ovYNaGYaQpzAC392Luafc=; b=brGVHwQGADw2c8p/FpcOJf
 ZjXyvGBPK1thAAw6kwRJkaqDULYVSDu+vAe5Uz1qWeLxmmbiz61SbsT2iDf4vi17
 RCmwlfjcDJCoGarMHwmUIe/Ym/OOM3FW7tpEK4ECU/YompZgh+V2dviims3CYjyu
 6yH1bNcWiwIyhwLOCcRpt6kX/Ae0b/cicy6uQ4ZYE54Kho+0/WqMt6ktvcmhClpR
 l/ssAx9H6rf92Dipr9xVS0x8/o45CKmDFfw2a9vvIjX3qw3xVPp8qrLMl1zSElGg
 qtkMWuyAWCJpe//L6wHzJtyHRo0z+UG9n3wvMAqxEn1P5op7702XvyPNe3KAXgBA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8n4qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 07:14:03 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59E7BFeB006751;
 Tue, 14 Oct 2025 07:14:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8n4qh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 07:14:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59E39NIW016759;
 Tue, 14 Oct 2025 07:14:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jsk9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 07:14:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59E7E1Qu21365466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 07:14:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F5BA5804B;
 Tue, 14 Oct 2025 07:14:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 998115805B;
 Tue, 14 Oct 2025 07:13:57 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Oct 2025 07:13:57 +0000 (GMT)
Message-ID: <dd198004-21e5-4e14-9a73-05be3bc0594e@linux.ibm.com>
Date: Tue, 14 Oct 2025 12:43:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] target/ppc: Replace HOST_BIG_ENDIAN #ifdef with
 runtime if() check
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org
References: <20251010134226.72221-1-philmd@linaro.org>
 <20251010134226.72221-13-philmd@linaro.org>
 <a8e70e2b-4511-4d7c-a95c-a02cb6e6dd0e@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <a8e70e2b-4511-4d7c-a95c-a02cb6e6dd0e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Z-bMi1PuKRdfyi8ZP8TUyoK_3Ln5BG4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX8vET8ZL01PKt
 6S5Je3Cu9uVP1ucS84b4dRQ37BdlpgGXnVoY0QeqI0tDiZ9AglCs0z9RWbUcG/IFDkYPV+FNC6f
 IMAwrvYjc2TCP8mv2YvyLDqlSZ7B9RVfDRe6XUB5Hiptw3iZMZY4fnlzrnrhCgQHEWIeN4VDDTB
 0WksK5EPJEq9yOnH7yeOEH4gy9Ufsy/Aqlp1KxJ8UoWZXWRR2brnozMKObwjOnku0xdgUYcdPsx
 g5aR4DB8em1a6dGIcNtplRqioikDVAqGYhN2hIsVdK1VFkeIBqPypiZ97U0KDiuNpfQuepMk5Zz
 w9ZcvBDv26YADZk+N8vSr79ZfIjAxiYHrpl1NfNt1aL/Ht9vgElTkefxuuYBBLb+UZ/oN/BQhoi
 tjMUM2OWYLXxpuihkKY8yHYPN2/TbA==
X-Proofpoint-GUID: hvodGjLgLG3OyHl3eTANSNoRSC2jxnH3
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68edf83b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=GBeU-aChTpiHtyJ2uCUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 10/14/25 12:18, Harsh Prateek Bora wrote:
> 
> 
> On 10/10/25 19:12, Philippe Mathieu-Daudé wrote:
>> Replace compile-time #ifdef with a runtime check to ensure all code
>> paths are built and tested. This reduces build-time configuration
>> complexity and improves maintainability.
>>
>> No functional change intended.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/ppc/arch_dump.c              |  9 ++-------
>>   target/ppc/int_helper.c             | 28 ++++++++++++++--------------
>>   target/ppc/kvm.c                    | 25 +++++++++----------------
>>   target/ppc/translate/vmx-impl.c.inc | 14 +++++++-------
>>   target/ppc/translate/vsx-impl.c.inc |  6 +++---
>>   tcg/ppc/tcg-target.c.inc            | 24 ++++++++++++------------
>>   6 files changed, 47 insertions(+), 59 deletions(-)
>>
>> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
>> index 80ac6c3e320..5cb8dbe9a6a 100644
>> --- a/target/ppc/arch_dump.c
>> +++ b/target/ppc/arch_dump.c
>> @@ -158,21 +158,16 @@ static void ppc_write_elf_vmxregset(NoteFuncArg 
>> *arg, PowerPCCPU *cpu, int id)
>>       struct PPCElfVmxregset *vmxregset;
>>       Note *note = &arg->note;
>>       DumpState *s = arg->state;
>> +    const int host_data_order = HOST_BIG_ENDIAN ? ELFDATA2MSB : 
>> ELFDATA2LSB;
> 
> I think the order of return values of ternary op needs to be swapped.
> 
>                              HOST_BIG_ENDIAN ? ELFDATA2LSB : ELFDATA2MSB;
> 
> Otherwise, looks fine. With that fixed:
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
> 
>> +    const bool needs_byteswap = s->dump_info.d_endian == 
>> host_data_order;

Or, a better fix would be to change == to != ?

>>       note->hdr.n_type = cpu_to_dump32(s, NT_PPC_VMX);
>>       vmxregset = &note->contents.vmxregset;
>>       memset(vmxregset, 0, sizeof(*vmxregset));
>>       for (i = 0; i < 32; i++) {
>> -        bool needs_byteswap;
>>           ppc_avr_t *avr = cpu_avr_ptr(&cpu->env, i);
>> -#if HOST_BIG_ENDIAN
>> -        needs_byteswap = s->dump_info.d_endian == ELFDATA2LSB;
>> -#else
>> -        needs_byteswap = s->dump_info.d_endian == ELFDATA2MSB;
>> -#endif
>> -
>>           if (needs_byteswap) {
>>               vmxregset->avr[i].u64[0] = bswap64(avr->u64[1]);
>>               vmxregset->avr[i].u64[1] = bswap64(avr->u64[0]);
>> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
>> index ef4b2e75d60..0c6f5b2e519 100644
>> --- a/target/ppc/int_helper.c
>> +++ b/target/ppc/int_helper.c
>> @@ -1678,13 +1678,13 @@ void helper_vslo(ppc_avr_t *r, ppc_avr_t *a, 
>> ppc_avr_t *b)
>>   {
>>       int sh = (b->VsrB(0xf) >> 3) & 0xf;
>> -#if HOST_BIG_ENDIAN
>> -    memmove(&r->u8[0], &a->u8[sh], 16 - sh);
>> -    memset(&r->u8[16 - sh], 0, sh);
>> -#else
>> -    memmove(&r->u8[sh], &a->u8[0], 16 - sh);
>> -    memset(&r->u8[0], 0, sh);
>> -#endif
>> +    if (HOST_BIG_ENDIAN) {
>> +        memmove(&r->u8[0], &a->u8[sh], 16 - sh);
>> +        memset(&r->u8[16 - sh], 0, sh);
>> +    } else {
>> +        memmove(&r->u8[sh], &a->u8[0], 16 - sh);
>> +        memset(&r->u8[0], 0, sh);
>> +    }
>>   }
>>   #if HOST_BIG_ENDIAN
>> @@ -1898,13 +1898,13 @@ void helper_vsro(ppc_avr_t *r, ppc_avr_t *a, 
>> ppc_avr_t *b)
>>   {
>>       int sh = (b->VsrB(0xf) >> 3) & 0xf;
>> -#if HOST_BIG_ENDIAN
>> -    memmove(&r->u8[sh], &a->u8[0], 16 - sh);
>> -    memset(&r->u8[0], 0, sh);
>> -#else
>> -    memmove(&r->u8[0], &a->u8[sh], 16 - sh);
>> -    memset(&r->u8[16 - sh], 0, sh);
>> -#endif
>> +    if (HOST_BIG_ENDIAN) {
>> +        memmove(&r->u8[sh], &a->u8[0], 16 - sh);
>> +        memset(&r->u8[0], 0, sh);
>> +    } else {
>> +        memmove(&r->u8[0], &a->u8[sh], 16 - sh);
>> +        memset(&r->u8[16 - sh], 0, sh);
>> +    }
>>   }
>>   void helper_vsumsws(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, 
>> ppc_avr_t *b)
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index 2521ff65c6c..c00d29ce2c8 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -651,13 +651,13 @@ static int kvm_put_fp(CPUState *cs)
>>               uint64_t *fpr = cpu_fpr_ptr(env, i);
>>               uint64_t *vsrl = cpu_vsrl_ptr(env, i);
>> -#if HOST_BIG_ENDIAN
>> -            vsr[0] = float64_val(*fpr);
>> -            vsr[1] = *vsrl;
>> -#else
>> -            vsr[0] = *vsrl;
>> -            vsr[1] = float64_val(*fpr);
>> -#endif
>> +            if (HOST_BIG_ENDIAN) {
>> +                vsr[0] = float64_val(*fpr);
>> +                vsr[1] = *vsrl;
>> +            } else {
>> +                vsr[0] = *vsrl;
>> +                vsr[1] = float64_val(*fpr);
>> +            }
>>               reg.addr = (uintptr_t) &vsr;
>>               reg.id = vsx ? KVM_REG_PPC_VSR(i) : KVM_REG_PPC_FPR(i);
>> @@ -728,17 +728,10 @@ static int kvm_get_fp(CPUState *cs)
>>                                           strerror(errno));
>>                   return ret;
>>               } else {
>> -#if HOST_BIG_ENDIAN
>> -                *fpr = vsr[0];
>> +                *fpr = vsr[!HOST_BIG_ENDIAN];
>>                   if (vsx) {
>> -                    *vsrl = vsr[1];
>> +                    *vsrl = vsr[HOST_BIG_ENDIAN];
>>                   }
>> -#else
>> -                *fpr = vsr[1];
>> -                if (vsx) {
>> -                    *vsrl = vsr[0];
>> -                }
>> -#endif
>>               }
>>           }
>>       }
>> diff --git a/target/ppc/translate/vmx-impl.c.inc 
>> b/target/ppc/translate/vmx-impl.c.inc
>> index 92d6e8c6032..ca9cf1823d4 100644
>> --- a/target/ppc/translate/vmx-impl.c.inc
>> +++ b/target/ppc/translate/vmx-impl.c.inc
>> @@ -134,9 +134,9 @@ static void gen_mtvscr(DisasContext *ctx)
>>       val = tcg_temp_new_i32();
>>       bofs = avr_full_offset(rB(ctx->opcode));
>> -#if HOST_BIG_ENDIAN
>> -    bofs += 3 * 4;
>> -#endif
>> +    if (HOST_BIG_ENDIAN) {
>> +        bofs += 3 * 4;
>> +    }
>>       tcg_gen_ld_i32(val, tcg_env, bofs);
>>       gen_helper_mtvscr(tcg_env, val);
>> @@ -1528,10 +1528,10 @@ static void gen_vsplt(DisasContext *ctx, int 
>> vece)
>>       /* Experimental testing shows that hardware masks the 
>> immediate.  */
>>       bofs += (uimm << vece) & 15;
>> -#if !HOST_BIG_ENDIAN
>> -    bofs ^= 15;
>> -    bofs &= ~((1 << vece) - 1);
>> -#endif
>> +    if (!HOST_BIG_ENDIAN) {
>> +        bofs ^= 15;
>> +        bofs &= ~((1 << vece) - 1);
>> +    }
>>       tcg_gen_gvec_dup_mem(vece, dofs, bofs, 16, 16);
>>   }
>> diff --git a/target/ppc/translate/vsx-impl.c.inc 
>> b/target/ppc/translate/vsx-impl.c.inc
>> index 00ad57c6282..8e5c75961f4 100644
>> --- a/target/ppc/translate/vsx-impl.c.inc
>> +++ b/target/ppc/translate/vsx-impl.c.inc
>> @@ -1642,9 +1642,9 @@ static bool trans_XXSPLTW(DisasContext *ctx, 
>> arg_XX2_uim *a)
>>       tofs = vsr_full_offset(a->xt);
>>       bofs = vsr_full_offset(a->xb);
>>       bofs += a->uim << MO_32;
>> -#if !HOST_BIG_ENDIAN
>> -    bofs ^= 8 | 4;
>> -#endif
>> +    if (!HOST_BIG_ENDIAN) {
>> +        bofs ^= 8 | 4;
>> +    }
>>       tcg_gen_gvec_dup_mem(MO_32, tofs, bofs, 16, 16);
>>       return true;
>> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
>> index b8b23d44d5e..61aa77f5454 100644
>> --- a/tcg/ppc/tcg-target.c.inc
>> +++ b/tcg/ppc/tcg-target.c.inc
>> @@ -3951,9 +3951,9 @@ static bool tcg_out_dupm_vec(TCGContext *s, 
>> TCGType type, unsigned vece,
>>               tcg_out_mem_long(s, 0, LVEBX, out, base, offset);
>>           }
>>           elt = extract32(offset, 0, 4);
>> -#if !HOST_BIG_ENDIAN
>> -        elt ^= 15;
>> -#endif
>> +        if (!HOST_BIG_ENDIAN) {
>> +            elt ^= 15;
>> +        }
>>           tcg_out32(s, VSPLTB | VRT(out) | VRB(out) | (elt << 16));
>>           break;
>>       case MO_16:
>> @@ -3964,9 +3964,9 @@ static bool tcg_out_dupm_vec(TCGContext *s, 
>> TCGType type, unsigned vece,
>>               tcg_out_mem_long(s, 0, LVEHX, out, base, offset);
>>           }
>>           elt = extract32(offset, 1, 3);
>> -#if !HOST_BIG_ENDIAN
>> -        elt ^= 7;
>> -#endif
>> +        if (!HOST_BIG_ENDIAN) {
>> +            elt ^= 7;
>> +        }
>>           tcg_out32(s, VSPLTH | VRT(out) | VRB(out) | (elt << 16));
>>           break;
>>       case MO_32:
>> @@ -3977,9 +3977,9 @@ static bool tcg_out_dupm_vec(TCGContext *s, 
>> TCGType type, unsigned vece,
>>           tcg_debug_assert((offset & 3) == 0);
>>           tcg_out_mem_long(s, 0, LVEWX, out, base, offset);
>>           elt = extract32(offset, 2, 2);
>> -#if !HOST_BIG_ENDIAN
>> -        elt ^= 3;
>> -#endif
>> +        if (!HOST_BIG_ENDIAN) {
>> +            elt ^= 3;
>> +        }
>>           tcg_out32(s, VSPLTW | VRT(out) | VRB(out) | (elt << 16));
>>           break;
>>       case MO_64:
>> @@ -3991,9 +3991,9 @@ static bool tcg_out_dupm_vec(TCGContext *s, 
>> TCGType type, unsigned vece,
>>           tcg_out_mem_long(s, 0, LVX, out, base, offset & -16);
>>           tcg_out_vsldoi(s, TCG_VEC_TMP1, out, out, 8);
>>           elt = extract32(offset, 3, 1);
>> -#if !HOST_BIG_ENDIAN
>> -        elt = !elt;
>> -#endif
>> +        if (!HOST_BIG_ENDIAN) {
>> +            elt = !elt;
>> +        }
>>           if (elt) {
>>               tcg_out_vsldoi(s, out, out, TCG_VEC_TMP1, 8);
>>           } else {
> 

