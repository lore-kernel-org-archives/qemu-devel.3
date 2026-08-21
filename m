Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAA9C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxJfa-00039w-16; Fri, 21 Aug 2026 03:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wxJfX-00036T-Nw; Fri, 21 Aug 2026 03:28:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wxJfV-0006t3-5s; Fri, 21 Aug 2026 03:28:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L5VkTD584806; Fri, 21 Aug 2026 07:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+xH46S
 Vdv8oh/X9w/9A1NR3vW34w0TpJHp+oPpsYJeU=; b=Fs+YNsd4cjhkdWmzp/3kYH
 3nkiHBdxQhSBLnY77z4TeqGa3LVZ/bFNJZfUy+SxuDD4H1tpuE0WeyCvp75Roymh
 GVSGhcSm4JYJ9OGFsorPqqVFRzPeAGd97iGIJe9d1eIUZirEbB9wjewoRaHVyxZi
 7nzZY7zUf3k6G0skdMZxw3V25rfDux1gIrDZ0ZdXKvpgynEcl/Itr9RKroPX0pML
 hDv0NuZFHvstTNYdc54f0oh++8SfU2rjZRIyVzltzXb1tcJyNzZX1xRtavS7TCPG
 mk0F7S0NFZ8F7G8ZXT3sBwZxWWJHCK8XzNdpTAmACPTsJdFoD/ZKrjvW1xYVf8vA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0qvt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 07:27:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L7QLIL001113;
 Fri, 21 Aug 2026 07:27:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekk7m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 07:27:57 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67L7Rqrl262746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2026 07:27:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA74C58056;
 Fri, 21 Aug 2026 07:27:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 891905803F;
 Fri, 21 Aug 2026 07:27:50 +0000 (GMT)
Received: from [9.124.214.111] (unknown [9.124.214.111])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Aug 2026 07:27:50 +0000 (GMT)
Message-ID: <2a98f24f-0af7-4778-a8f1-f813bc48139e@linux.ibm.com>
Date: Fri, 21 Aug 2026 12:57:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/29] target/ppc: Refactor sleep and its variants to use
 a common helper
To: milesg@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 harshpb@linux.ibm.com
Cc: ojaswin@linux.ibm.com
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-20-rathc@linux.ibm.com>
 <3fea696f5ee62656ecca7aa72118da1d458a6018.camel@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <3fea696f5ee62656ecca7aa72118da1d458a6018.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a87fdfe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=aZ7qpTgRukFWeUTEySUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LzpSk-cXQNz6IineB0AAXM7plLqZYaXg
X-Proofpoint-GUID: LzpSk-cXQNz6IineB0AAXM7plLqZYaXg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA0OSBTYWx0ZWRfXwBRoJev/imxr
 o0FUtcw+zjJwOmle2oodDvijs5YyFD/T7VbyWpglSYYCXBE+Tdas+uMmE/s1TZw1RibsSeE1x8V
 bVjRJb71ufpSi30NWv5FFWBDJK9eXJ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA0OSBTYWx0ZWRfX17YBkUgjVuKT
 4wmCB3J8RbxWCub9P/A72rajwyxilJs0dw+h55T8QaEzGiOugFdK8yo3YY1XolOvnVJoiJ+2Rl1
 EbtbdL0qNkstqeXh1rr0d8//kf5pFES1YXovgNZQd31qxfQzZOEs/Pl+flSK1kzjtqt2c9/tUMx
 E30WzTYBnv4jIYQFsHDo7mQcyH3Nb9B3kBcMQq8zwJ0x4B8euOVCjMDK7Q7ycq1n7MLh+AvP5uW
 fcS7NCZhG+fPqOQcij5TiW+IF6fWvwWFGb3158v2xW34wVHNLtjxY77xN7jEc6xDzsz3CkHCQga
 0rhraV91f1YDbiOzWY3tWNOxSupnHdl+JSSvqMOYCXkz4OaXfUG5sajl1mQM9yAkY3D4ExLtOQ3
 ndMawFx1FYDkE9Rh+5YirEncjVJ9UiriMYj9GDvRtEFu0wfOjn9Z0mslKKAIcDrtHZNZ7rdvCCO
 Nr48n3s+jGVk+JaGg7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210049
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 8/20/26 20:45, Miles Glenn wrote:
> Chinmay,
>
> This commit seems out of the scope of moving instructions to
> decodetree.  Was this change necessary in order to move the
> instructions to decodetree?  If so, it would be helpful to add that to
> the commit message.  Otherwise, I would submit this separately from the
> decodetree commits.
Hi Glenn,

It is common practice to merge helper functions in helper files and/or 
translation functions in the translate.c or translate directory files 
during instruction movement to decodetree, if they have common logic.
Speaking of which, ideally this commit should have been squashed along 
with the previous commit where those insns were actually moved. The 
author of the patch has instead created two separate patches. Though it 
is not technically wrong, since neither of the patch are incomplete 
functionally, let me know if you think this should be squashed with the 
previous commit, will do that.

PS: Please feel free to review other patches as well. It would be of 
great help :)

Regards,
Chinmay
>
> Thanks,
>
> Glenn
>
> On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
>> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>
>> Refactor sleep, doze, nap, rvwinkle and stop to use a common helper
>> since they share majority of the code. Also refactor gen_hlper_pminsn()
>> to gen_helper_PMINSN()
>>
>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   target/ppc/helper.h                           |  2 +-
>>   target/ppc/tcg-excp_helper.c                  |  2 +-
>>   .../ppc/translate/processor-ctrl-impl.c.inc   | 99 +++----------------
>>   3 files changed, 16 insertions(+), 87 deletions(-)
>>
>> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>> index cd2a0948a3..7e15676122 100644
>> --- a/target/ppc/helper.h
>> +++ b/target/ppc/helper.h
>> @@ -18,7 +18,7 @@ DEF_HELPER_1(rfdi, void, env)
>>   DEF_HELPER_1(rfmci, void, env)
>>   #if defined(TARGET_PPC64)
>>   DEF_HELPER_2(scv, noreturn, env, i32)
>> -DEF_HELPER_2(pminsn, void, env, i32)
>> +DEF_HELPER_2(PMINSN, void, env, i32)
>>   DEF_HELPER_1(rfid, void, env)
>>   DEF_HELPER_1(rfscv, void, env)
>>   DEF_HELPER_1(hrfid, void, env)
>> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
>> index b04f07a637..c4ffa2dfbb 100644
>> --- a/target/ppc/tcg-excp_helper.c
>> +++ b/target/ppc/tcg-excp_helper.c
>> @@ -459,7 +459,7 @@ void helper_scv(CPUPPCState *env, uint32_t lev)
>>       }
>>   }
>>   
>> -void helper_pminsn(CPUPPCState *env, uint32_t insn)
>> +void helper_PMINSN(CPUPPCState *env, uint32_t insn)
>>   {
>>       CPUState *cs = env_cpu(env);
>>   
>> diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
>> index bdbc195294..3b3ed3019a 100644
>> --- a/target/ppc/translate/processor-ctrl-impl.c.inc
>> +++ b/target/ppc/translate/processor-ctrl-impl.c.inc
>> @@ -104,103 +104,32 @@ static bool trans_MSGSYNC(DisasContext *ctx, arg_MSGSYNC *a)
>>       return true;
>>   }
>>   
>> -static bool do_doze(DisasContext *ctx, arg_DOZE *a)
>> -{
>> -    REQUIRE_64BIT(ctx);
>> -
>> -#if defined(CONFIG_USER_ONLY)
>> -    gen_priv_opc(ctx);
>> -#else
>> -    TCGv_i32 t;
>> -
>> -    REQUIRE_HV(ctx);
>> -    translator_io_start(&ctx->base);
>> -    t = tcg_constant_i32(PPC_PM_DOZE);
>> -    gen_helper_pminsn(tcg_env, t);
>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> -#endif /* defined(CONFIG_USER_ONLY) */
>> -
>> -    return true;
>> -}
>> -TRANS_FLAGS2(PM_ISA206, DOZE, do_doze);
>> -
>> -static bool do_nap(DisasContext *ctx, arg_NAP *a)
>> -{
>> -    REQUIRE_64BIT(ctx);
>> -
>> -#if defined(CONFIG_USER_ONLY)
>> -    gen_priv_opc(ctx);
>> -#else
>> -    TCGv_i32 t;
>> -
>> -    REQUIRE_HV(ctx);
>> -    translator_io_start(&ctx->base);
>> -    t = tcg_constant_i32(PPC_PM_NAP);
>> -    gen_helper_pminsn(tcg_env, t);
>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> -#endif /* defined(CONFIG_USER_ONLY) */
>> -    return true;
>> -}
>> -TRANS_FLAGS2(PM_ISA206, NAP, do_nap);
>> -
>> -static bool do_sleep(DisasContext *ctx, arg_SLEEP *a)
>> -{
>> -    REQUIRE_64BIT(ctx);
>> -
>> -#if defined(CONFIG_USER_ONLY)
>> -    gen_priv_opc(ctx);
>> -#else
>> -    TCGv_i32 t;
>> -
>> -    REQUIRE_HV(ctx);
>> -    translator_io_start(&ctx->base);
>> -    t = tcg_constant_i32(PPC_PM_SLEEP);
>> -    gen_helper_pminsn(tcg_env, t);
>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> -#endif /* defined(CONFIG_USER_ONLY) */
>> -    return true;
>> -}
>> -TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep);
>> -
>> -static bool do_rvwinkle(DisasContext *ctx, arg_RVWINKLE *a)
>> +/*
>> + * Helper to handle DOZE, NAP, SLEEP, RVWINKLE & STOP. Since none of them use
>> + * any arguments just use a placeholder arg_SLEEP.
>> + */
>> +static bool do_sleep(DisasContext *ctx, arg_SLEEP *a, powerpc_pm_insn_t type)
>>   {
>>       REQUIRE_64BIT(ctx);
>>   
>>   #if defined(CONFIG_USER_ONLY)
>>       gen_priv_opc(ctx);
>> -#else
>> +#elif defined(TARGET_PPC64)
>>       TCGv_i32 t;
>>   
>>       REQUIRE_HV(ctx);
>>       translator_io_start(&ctx->base);
>> -    t = tcg_constant_i32(PPC_PM_RVWINKLE);
>> -    gen_helper_pminsn(tcg_env, t);
>> +    t = tcg_constant_i32(type);
>> +    gen_helper_PMINSN(tcg_env, t);
>>       /* Stop translation, as the CPU is supposed to sleep from now */
>>       gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> -#endif /* defined(CONFIG_USER_ONLY) */
>> -    return true;
>> -}
>> -TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_rvwinkle);
>> -
>> -static bool do_stop(DisasContext *ctx, arg_STOP *a)
>> -{
>> -    REQUIRE_64BIT(ctx);
>> -
>> -#if defined(CONFIG_USER_ONLY)
>> -    gen_priv_opc(ctx);
>>   #else
>> -    TCGv_i32 t;
>> -
>> -    REQUIRE_HV(ctx);
>> -    translator_io_start(&ctx->base);
>> -    t = tcg_constant_i32(PPC_PM_STOP);
>> -    gen_helper_pminsn(tcg_env, t);
>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>> +    qemu_build_not_reached();
>>   #endif
>>       return true;
>>   }
>> -TRANS_FLAGS2(ISA300, STOP, do_stop);
>> +TRANS_FLAGS2(PM_ISA206, DOZE, do_sleep, PPC_PM_DOZE);
>> +TRANS_FLAGS2(PM_ISA206, NAP, do_sleep, PPC_PM_NAP);
>> +TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep, PPC_PM_SLEEP);
>> +TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_sleep, PPC_PM_RVWINKLE);
>> +TRANS_FLAGS2(ISA300, STOP, do_sleep, PPC_PM_STOP);

