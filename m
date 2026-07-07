Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2D7C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgy4N-0002J4-UA; Tue, 07 Jul 2026 01:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgy4G-0002Ia-7V
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:10:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgy4D-0005hP-An
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:09:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674IITX1651246
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 05:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2CqXHX
 n3CPxyJ8hrRAo8sAgeTwMW9XXEqYB79uTHMyk=; b=LP+wfMe6H2aF46BiXEsPe4
 wlOydQsg/akm5hhbTK8v2lwjdMK8b6Jqc+dpVwmTyua4+XzwvFPETLAS1PzdAAMz
 14NfW85VVQ8VLwrcQXiznDWhAdmouIfApCcUQBaNpzKYBGOON/oc5I9jgYkKmyI4
 yYtBEy2D+UVOuFDsgENIu8xKDKQjtJhc3KCueUQy9KZXYr3htu3/yzkrFDfYmXFx
 qJbe3fc69yk+gF9gtX79HAmKkuuEpEITgeApT9qAJB9oq88z5AwI/W+MsQLU26LD
 JpfXfiZymMOC4Cr+XKuk7PW+r3pzwWGQ2AfUTvcEhC8acpFj+CLXehc1emn0hvuQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdnr26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:09:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66754dNf005857
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 05:09:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg0rvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:09:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66759roB27329006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 05:09:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F00820040
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 05:09:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 726F520049
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 05:09:52 +0000 (GMT)
Received: from [9.67.174.189] (unknown [9.67.174.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 05:09:52 +0000 (GMT)
Message-ID: <7558650c-c813-4e88-bac7-4d7f5c9e9457@linux.ibm.com>
Date: Tue, 7 Jul 2026 10:39:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/28] target/ppc: Move sleep & friends to decodetree
To: qemu-devel@nongnu.org
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-19-rathc@linux.ibm.com>
 <8ae826c7-775c-4282-a734-9a18357f532c@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <8ae826c7-775c-4282-a734-9a18357f532c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4c8a24 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VIO1ikxMzf-woBsiIOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA0MyBTYWx0ZWRfX3MGI9CemB9ha
 jexXzkJ4dyZwY+Q4NkanMJ9lyr/Y0Kr108H+k35O2mJwt8SD4F2kwKDm1YscsbyJH0qnk3lz6cJ
 SvdoytRXeyVbKLp+OSa+Dd5KU5e9dllURHu5wLF1yT2bAu/ySCe153k8iMQVM6qnygMJmQJGSXl
 lEAVPqSPJ4lZRooLHwa5O2+PC//09PIUGY63h0Pjklme+z+cv5uTK9OAn9JyTMVfyQz2rlw5ggk
 WdLPci9Bu5uPlz7n90EiacYCIR6VdLrwcIzANXzUxpDn4gxVxeffZqtBFFntiSPkX7qY4gaWYym
 J9nuiGe1E5Egxg5HrkKGXLHfngQNv+A68a1+HOWpYs1FPoDEkFDJGHL5h+YJxKBkd6tlnT8Hwx0
 fnn3Zvw8iBN97mTrvGjVQvArHFetwaiovDhnKuK7z14FTMI3tIGRUoK2EdoIzMwt94bGYCt9YW/
 wsYZKRGcs6HL6mij5ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA0MyBTYWx0ZWRfXxgHL23tRbHNP
 Hq36DnjXVn5yt1Tt7Lhe2lafL1Ks+vqD37X8xgod/3J+0wAFt6vJaC4BAg1OG5tIFY9/aoq+umH
 1yYtjqXkCAeMd0JrIzOciO+tp+pKV7w=
X-Proofpoint-GUID: 36d_cH4chxsSm71e1EaSUEGtzYbTd8_T
X-Proofpoint-ORIG-GUID: 36d_cH4chxsSm71e1EaSUEGtzYbTd8_T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070043
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I guess in patch 19 Ojaswin has already refactored sleep, doze, nap, 
rvwinkle and stop to use a common helper. I missed that part earlier 
during my review.

Thanks,
~Nikhil

On 06/07/26 23:18, Nikhil Kumar Singh wrote:
>
> On 20/05/26 21:37, Chinmay Rath wrote:
>> From: Ojaswin Mujoo<ojaswin@linux.ibm.com>
>>
>> Convert the following instructions to decode tree specification:
>>
>> doze
>> nap
>> sleep
>> rvwinkle
>> stop
>>
>> The functionality was tested by comparing the qemu -D log -d op,in_asm
>> output as well as single stepping gdb to confirm behavior was not
>> changed for ISA3.x (stop) as well as ISA206 (doze, nap, sleep,
>> rvwinkle).
>>
>> Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>
>> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
>> ---
>>   target/ppc/insn32.decode                      |   8 ++
>>   target/ppc/translate.c                        |  85 ---------------
>>   .../ppc/translate/processor-ctrl-impl.c.inc   | 101 ++++++++++++++++++
>>   3 files changed, 109 insertions(+), 85 deletions(-)
>>
>> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
>> index 2c002f8513..a4454a2292 100644
>> --- a/target/ppc/insn32.decode
>> +++ b/target/ppc/insn32.decode
>> @@ -913,6 +913,14 @@ VPERMR          000100 ..... ..... ..... ..... 
>> 111011   @VA
>>     VSEL            000100 ..... ..... ..... ..... 101010   @VA
>>   +## Power Management Instructions
>> +
>> +DOZE            010011 ----- ----- ----- 0110010010 -
>> +NAP             010011 ----- ----- ----- 0110110010 -
>> +SLEEP           010011 ----- ----- ----- 0111010010 -
>> +RVWINKLE        010011 ----- ----- ----- 0111110010 -
>> +STOP            010011 ----- ----- ----- 0101110010 -
>> +
>>   ## Vector Integer Shift Instruction
>>     VSLB            000100 ..... ..... ..... 00100000100    @VX
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index 4a7fa6a6a9..d1e9ab61e9 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -2728,86 +2728,6 @@ static inline void 
>> gen_check_tlb_flush(DisasContext *ctx, bool global) { }
>>   #endif
>>     #if defined(TARGET_PPC64)
>> -static void gen_doze(DisasContext *ctx)
>> -{
>> -#if defined(CONFIG_USER_ONLY)
>> -    GEN_PRIV(ctx);
>> -#else
>> -    TCGv_i32 t;
>> -
>> -    CHK_HV(ctx);
>> -    translator_io_start(&ctx->base);
>> -    t = tcg_constant_i32(PPC_PM_DOZE);
>> -    gen_helper_pminsn(tcg_env, t);
>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> -#endif /* defined(CONFIG_USER_ONLY) */
>> -}
>> -
>> -static void gen_nap(DisasContext *ctx)
>> -{
>> -#if defined(CONFIG_USER_ONLY)
>> -    GEN_PRIV(ctx);
>> -#else
>> -    TCGv_i32 t;
>> -
>> -    CHK_HV(ctx);
>> -    translator_io_start(&ctx->base);
>> -    t = tcg_constant_i32(PPC_PM_NAP);
>> -    gen_helper_pminsn(tcg_env, t);
>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> -#endif /* defined(CONFIG_USER_ONLY) */
>> -}
>> -
>> -static void gen_stop(DisasContext *ctx)
>> -{
>> -#if defined(CONFIG_USER_ONLY)
>> -    GEN_PRIV(ctx);
>> -#else
>> -    TCGv_i32 t;
>> -
>> -    CHK_HV(ctx);
>> -    translator_io_start(&ctx->base);
>> -    t = tcg_constant_i32(PPC_PM_STOP);
>> -    gen_helper_pminsn(tcg_env, t);
>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> -#endif /* defined(CONFIG_USER_ONLY) */
>> -}
>> -
>> -static void gen_sleep(DisasContext *ctx)
>> -{
>> -#if defined(CONFIG_USER_ONLY)
>> -    GEN_PRIV(ctx);
>> -#else
>> -    TCGv_i32 t;
>> -
>> -    CHK_HV(ctx);
>> -    translator_io_start(&ctx->base);
>> -    t = tcg_constant_i32(PPC_PM_SLEEP);
>> -    gen_helper_pminsn(tcg_env, t);
>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> -#endif /* defined(CONFIG_USER_ONLY) */
>> -}
>> -
>> -static void gen_rvwinkle(DisasContext *ctx)
>> -{
>> -#if defined(CONFIG_USER_ONLY)
>> -    GEN_PRIV(ctx);
>> -#else
>> -    TCGv_i32 t;
>> -
>> -    CHK_HV(ctx);
>> -    translator_io_start(&ctx->base);
>> -    t = tcg_constant_i32(PPC_PM_RVWINKLE);
>> -    gen_helper_pminsn(tcg_env, t);
>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> -#endif /* defined(CONFIG_USER_ONLY) */
>> -}
>> -
>>   static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv 
>> mask, TCGv value)
>>   {
>>       TCGv_ptr tmp = tcg_temp_new_ptr();
>> @@ -5141,11 +5061,6 @@ GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 
>> 0x03FFF01E, PPC_NONE, PPC2_ISA300),
>>   GEN_HANDLER_E(scv, 0x11, 0x00, 0xFF, 0x03FFF01E, PPC_NONE, 
>> PPC2_ISA300),
>>   GEN_HANDLER_E(rfscv, 0x13, 0x12, 0x02, 0x03FF8001, PPC_NONE, 
>> PPC2_ISA300),
>>   #endif
>> -GEN_HANDLER_E(stop, 0x13, 0x12, 0x0b, 0x03FFF801, PPC_NONE, 
>> PPC2_ISA300),
>> -GEN_HANDLER_E(doze, 0x13, 0x12, 0x0c, 0x03FFF801, PPC_NONE, 
>> PPC2_PM_ISA206),
>> -GEN_HANDLER_E(nap, 0x13, 0x12, 0x0d, 0x03FFF801, PPC_NONE, 
>> PPC2_PM_ISA206),
>> -GEN_HANDLER_E(sleep, 0x13, 0x12, 0x0e, 0x03FFF801, PPC_NONE, 
>> PPC2_PM_ISA206),
>> -GEN_HANDLER_E(rvwinkle, 0x13, 0x12, 0x0f, 0x03FFF801, PPC_NONE, 
>> PPC2_PM_ISA206),
>>   GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
>>   #endif
>>   /* Top bit of opc2 corresponds with low bit of LEV, so use two 
>> handlers */
>> diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc 
>> b/target/ppc/translate/processor-ctrl-impl.c.inc
>> index 8abbb89630..bdbc195294 100644
>> --- a/target/ppc/translate/processor-ctrl-impl.c.inc
>> +++ b/target/ppc/translate/processor-ctrl-impl.c.inc
>> @@ -103,3 +103,104 @@ static bool trans_MSGSYNC(DisasContext *ctx, 
>> arg_MSGSYNC *a)
>>       /* interpreted as no-op */
>>       return true;
>>   }
>> +
>> +static bool do_doze(DisasContext *ctx, arg_DOZE *a)
>> +{
>> +    REQUIRE_64BIT(ctx);
>> +
>> +#if defined(CONFIG_USER_ONLY)
>> +    gen_priv_opc(ctx);
>> +#else
>> +    TCGv_i32 t;
>> +
>> +    REQUIRE_HV(ctx);
>> +    translator_io_start(&ctx->base);
>> +    t = tcg_constant_i32(PPC_PM_DOZE);
>> +    gen_helper_pminsn(tcg_env, t);
>> +    /* Stop translation, as the CPU is supposed to sleep from now */
>> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> +#endif /* defined(CONFIG_USER_ONLY) */
>> +
>> +    return true;
>> +}
>> +TRANS_FLAGS2(PM_ISA206, DOZE, do_doze);
>> +
>> +static bool do_nap(DisasContext *ctx, arg_NAP *a)
>> +{
>> +    REQUIRE_64BIT(ctx);
>> +
>> +#if defined(CONFIG_USER_ONLY)
>> +    gen_priv_opc(ctx);
>> +#else
>> +    TCGv_i32 t;
>> +
>> +    REQUIRE_HV(ctx);
>> +    translator_io_start(&ctx->base);
>> +    t = tcg_constant_i32(PPC_PM_NAP);
>> +    gen_helper_pminsn(tcg_env, t);
>> +    /* Stop translation, as the CPU is supposed to sleep from now */
>> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> +#endif /* defined(CONFIG_USER_ONLY) */
>> +    return true;
>> +}
>> +TRANS_FLAGS2(PM_ISA206, NAP, do_nap);
>> +
>> +static bool do_sleep(DisasContext *ctx, arg_SLEEP *a)
>> +{
>> +    REQUIRE_64BIT(ctx);
>> +
>> +#if defined(CONFIG_USER_ONLY)
>> +    gen_priv_opc(ctx);
>> +#else
>> +    TCGv_i32 t;
>> +
>> +    REQUIRE_HV(ctx);
>> +    translator_io_start(&ctx->base);
>> +    t = tcg_constant_i32(PPC_PM_SLEEP);
>> +    gen_helper_pminsn(tcg_env, t);
>> +    /* Stop translation, as the CPU is supposed to sleep from now */
>> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> +#endif /* defined(CONFIG_USER_ONLY) */
>> +    return true;
>> +}
>> +TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep);
>> +
>> +static bool do_rvwinkle(DisasContext *ctx, arg_RVWINKLE *a)
>> +{
>> +    REQUIRE_64BIT(ctx);
>> +
>> +#if defined(CONFIG_USER_ONLY)
>> +    gen_priv_opc(ctx);
>> +#else
>> +    TCGv_i32 t;
>> +
>> +    REQUIRE_HV(ctx);
>> +    translator_io_start(&ctx->base);
>> +    t = tcg_constant_i32(PPC_PM_RVWINKLE);
>> +    gen_helper_pminsn(tcg_env, t);
>> +    /* Stop translation, as the CPU is supposed to sleep from now */
>> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> +#endif /* defined(CONFIG_USER_ONLY) */
>> +    return true;
>> +}
>> +TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_rvwinkle);
>> +
>> +static bool do_stop(DisasContext *ctx, arg_STOP *a)
>> +{
>> +    REQUIRE_64BIT(ctx);
>> +
>> +#if defined(CONFIG_USER_ONLY)
>> +    gen_priv_opc(ctx);
>> +#else
>> +    TCGv_i32 t;
>> +
>> +    REQUIRE_HV(ctx);
>> +    translator_io_start(&ctx->base);
>> +    t = tcg_constant_i32(PPC_PM_STOP);
>> +    gen_helper_pminsn(tcg_env, t);
>> +    /* Stop translation, as the CPU is supposed to sleep from now */
>> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> +#endif
>> +    return true;
>> +}
>> +TRANS_FLAGS2(ISA300, STOP, do_stop);
>
> To me all these functions do_doze, do_nap, do_sleep, do_rvwinkle and 
> do_stop
> seem to be identical except  for the PPC_PM_* constant passed to 
> gen_helper_pminsn,
> you can eliminate over 50-60 lines  of boilerplate by creating a 
> single shared helper function.
>
> Thanks,
> ~ Nikhil
>

