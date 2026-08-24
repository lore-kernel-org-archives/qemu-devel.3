Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4234C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyURn-0000Io-Li; Mon, 24 Aug 2026 09:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wyURL-00005F-FE; Mon, 24 Aug 2026 09:10:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wyURI-0002lW-HC; Mon, 24 Aug 2026 09:10:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1iPZ2004569; Mon, 24 Aug 2026 13:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+0FNdK
 gA1f372ZHDx1SjkzjZvsByxdqqc3t52em86cc=; b=Oajwsc8vg75I8DlvIE3Z5W
 FWXIIIIhIaxY4aPntQeFtNErjxMf9XjUVrr2e2/3XvHBMy5lkZoJ4HCOcnSlsP7V
 q6DDsS5vOOqMLAv1/71akRfrX+1tHGEav3u6Fos+rxW1g1xPOlY/CCFsSDkS1gw5
 SQnI1pcGb1UXypdLakczzyFrUf6/Sm4yEZpXOH1GzzETKxNp1sVrTzzCjAwIMyvr
 teiijlYQ98LDExb/efR7j/By+ezhnbhT2XnmVE037n5wkeM1oJ8HEfflO+O7F/My
 pH/cUJvTGn4UIoZuRreG9apL2iAXUxxV6JO5akyqDSdD+vjjvQP18mlZklXWQpdA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx19vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 13:10:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OCv9jI003490;
 Mon, 24 Aug 2026 13:10:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3px7cg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 13:10:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67ODA7On29884960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 13:10:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36F9558056;
 Mon, 24 Aug 2026 13:10:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABAFA58052;
 Mon, 24 Aug 2026 13:10:03 +0000 (GMT)
Received: from [9.124.213.171] (unknown [9.124.213.171])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 13:10:03 +0000 (GMT)
Message-ID: <874ba27e-c4bd-49d7-948b-abb211ffcd5e@linux.ibm.com>
Date: Mon, 24 Aug 2026 18:40:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/29] target/ppc: Refactor sleep and its variants to use
 a common helper
To: milesg@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 harshpb@linux.ibm.com
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-20-rathc@linux.ibm.com>
 <3fea696f5ee62656ecca7aa72118da1d458a6018.camel@linux.ibm.com>
 <2a98f24f-0af7-4778-a8f1-f813bc48139e@linux.ibm.com>
 <0652cff525cfb620198b1705ddbcb9c639faedf0.camel@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <0652cff525cfb620198b1705ddbcb9c639faedf0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfX+ydEDa3atlio
 XDSWH5OyDMSdXu9ASru3me39KH6Oilkoo8Ha92X3JzF4hKNEJCdmj4aqi4f6z3CnNUvxhiDwsqz
 uW6ZGYX1K7ximAeTYleKWkdCchWdHHo=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c42b2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=r64Nd-2NEfs6lehV-CwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qOlXmLI-srSsfzvbAkAjTE6psz1fETVJ
X-Proofpoint-GUID: qOlXmLI-srSsfzvbAkAjTE6psz1fETVJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfX7fDIQ7o3Kyir
 XmaghaPOCVyQoT4o+DhBGJ/vx/wZkSsvBuLBBOmIhMMpdgfL4kkymvjeyDt9g16fkmPe4X29VoJ
 qgTZCnmiXdizFIwdZJ1JKsbjDE5LJ2V3yO9U7Vhugfc/B4jPfwl/K+qpej3JX1dijHzlkP3wXe9
 72qOIE6hnKi9XlUjSU4bDEOGV0wjUv1Oler4V6ZScv9Q743ynnGdj2AQJJFo9UkAocFgwiHyFFp
 QEezA61MLPa+twBsMqJACiO8HT1JnHrY0Vs22Vbqmxad7ZJssQAy2XGnTFyo4g8Fof5X+8B/DJp
 WsFythX70cAPD9p23rmx/bysNSG+tXCJXmqCo4twxOiKzJHjA/6r186pLKa1HKOrWRZJWH5eY3Y
 N1ce+t7mI31bJdg4oxWOZcN3HEbew/VVwbrsiz1jOahITTZ+KgH1In+63c/xP28b/QM8rtmy+Fh
 bXF3t9kCej06ch3knCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 8/21/26 22:06, Miles Glenn wrote:
> Hi Chinmay,
>
> I was only suggesting that it might be good to add a comment to the
> commit message stating that this commit was preparatory to moving the
> sleep instructions to decodetree.  No need to squash them.
>
> On Fri, 2026-08-21 at 12:57 +0530, Chinmay Rath wrote:
>> On 8/20/26 20:45, Miles Glenn wrote:
>>> Chinmay,
>>>
>>> This commit seems out of the scope of moving instructions to
>>> decodetree.  Was this change necessary in order to move the
>>> instructions to decodetree?  If so, it would be helpful to add that to
>>> the commit message.  Otherwise, I would submit this separately from the
>>> decodetree commits.
>> Hi Glenn,
>>
>> It is common practice to merge helper functions in helper files and/or
>> translation functions in the translate.c or translate directory files
>> during instruction movement to decodetree, if they have common logic.
>> Speaking of which, ideally this commit should have been squashed along
>> with the previous commit where those insns were actually moved. The
>> author of the patch has instead created two separate patches. Though it
>> is not technically wrong, since neither of the patch are incomplete
>> functionally, let me know if you think this should be squashed with the
>> previous commit, will do that.
>>
>> PS: Please feel free to review other patches as well. It would be of
>> great help :)
>>
>> Regards,
>> Chinmay
> Hi Chinmay,
>
> I was only suggesting that it might be good to add a comment to the
> commit message stating that this commit was preparatory to moving the
> sleep instructions to decodetree.  No need to squash the two commits.
Sure Glenn, will do in v2 !
> Thanks,
>
> Glenn
>
>>> Thanks,
>>>
>>> Glenn
>>>
>>> On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
>>>> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>>>
>>>> Refactor sleep, doze, nap, rvwinkle and stop to use a common helper
>>>> since they share majority of the code. Also refactor gen_hlper_pminsn()
>>>> to gen_helper_PMINSN()
>>>>
>>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>>>> ---
>>>>    target/ppc/helper.h                           |  2 +-
>>>>    target/ppc/tcg-excp_helper.c                  |  2 +-
>>>>    .../ppc/translate/processor-ctrl-impl.c.inc   | 99 +++----------------
>>>>    3 files changed, 16 insertions(+), 87 deletions(-)
>>>>
>>>> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>>>> index cd2a0948a3..7e15676122 100644
>>>> --- a/target/ppc/helper.h
>>>> +++ b/target/ppc/helper.h
>>>> @@ -18,7 +18,7 @@ DEF_HELPER_1(rfdi, void, env)
>>>>    DEF_HELPER_1(rfmci, void, env)
>>>>    #if defined(TARGET_PPC64)
>>>>    DEF_HELPER_2(scv, noreturn, env, i32)
>>>> -DEF_HELPER_2(pminsn, void, env, i32)
>>>> +DEF_HELPER_2(PMINSN, void, env, i32)
>>>>    DEF_HELPER_1(rfid, void, env)
>>>>    DEF_HELPER_1(rfscv, void, env)
>>>>    DEF_HELPER_1(hrfid, void, env)
>>>> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
>>>> index b04f07a637..c4ffa2dfbb 100644
>>>> --- a/target/ppc/tcg-excp_helper.c
>>>> +++ b/target/ppc/tcg-excp_helper.c
>>>> @@ -459,7 +459,7 @@ void helper_scv(CPUPPCState *env, uint32_t lev)
>>>>        }
>>>>    }
>>>>    
>>>> -void helper_pminsn(CPUPPCState *env, uint32_t insn)
>>>> +void helper_PMINSN(CPUPPCState *env, uint32_t insn)
>>>>    {
>>>>        CPUState *cs = env_cpu(env);
>>>>    
>>>> diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
>>>> index bdbc195294..3b3ed3019a 100644
>>>> --- a/target/ppc/translate/processor-ctrl-impl.c.inc
>>>> +++ b/target/ppc/translate/processor-ctrl-impl.c.inc
>>>> @@ -104,103 +104,32 @@ static bool trans_MSGSYNC(DisasContext *ctx, arg_MSGSYNC *a)
>>>>        return true;
>>>>    }
>>>>    
>>>> -static bool do_doze(DisasContext *ctx, arg_DOZE *a)
>>>> -{
>>>> -    REQUIRE_64BIT(ctx);
>>>> -
>>>> -#if defined(CONFIG_USER_ONLY)
>>>> -    gen_priv_opc(ctx);
>>>> -#else
>>>> -    TCGv_i32 t;
>>>> -
>>>> -    REQUIRE_HV(ctx);
>>>> -    translator_io_start(&ctx->base);
>>>> -    t = tcg_constant_i32(PPC_PM_DOZE);
>>>> -    gen_helper_pminsn(tcg_env, t);
>>>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>>>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>>>> -#endif /* defined(CONFIG_USER_ONLY) */
>>>> -
>>>> -    return true;
>>>> -}
>>>> -TRANS_FLAGS2(PM_ISA206, DOZE, do_doze);
>>>> -
>>>> -static bool do_nap(DisasContext *ctx, arg_NAP *a)
>>>> -{
>>>> -    REQUIRE_64BIT(ctx);
>>>> -
>>>> -#if defined(CONFIG_USER_ONLY)
>>>> -    gen_priv_opc(ctx);
>>>> -#else
>>>> -    TCGv_i32 t;
>>>> -
>>>> -    REQUIRE_HV(ctx);
>>>> -    translator_io_start(&ctx->base);
>>>> -    t = tcg_constant_i32(PPC_PM_NAP);
>>>> -    gen_helper_pminsn(tcg_env, t);
>>>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>>>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>>>> -#endif /* defined(CONFIG_USER_ONLY) */
>>>> -    return true;
>>>> -}
>>>> -TRANS_FLAGS2(PM_ISA206, NAP, do_nap);
>>>> -
>>>> -static bool do_sleep(DisasContext *ctx, arg_SLEEP *a)
>>>> -{
>>>> -    REQUIRE_64BIT(ctx);
>>>> -
>>>> -#if defined(CONFIG_USER_ONLY)
>>>> -    gen_priv_opc(ctx);
>>>> -#else
>>>> -    TCGv_i32 t;
>>>> -
>>>> -    REQUIRE_HV(ctx);
>>>> -    translator_io_start(&ctx->base);
>>>> -    t = tcg_constant_i32(PPC_PM_SLEEP);
>>>> -    gen_helper_pminsn(tcg_env, t);
>>>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>>>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>>>> -#endif /* defined(CONFIG_USER_ONLY) */
>>>> -    return true;
>>>> -}
>>>> -TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep);
>>>> -
>>>> -static bool do_rvwinkle(DisasContext *ctx, arg_RVWINKLE *a)
>>>> +/*
>>>> + * Helper to handle DOZE, NAP, SLEEP, RVWINKLE & STOP. Since none of them use
>>>> + * any arguments just use a placeholder arg_SLEEP.
>>>> + */
>>>> +static bool do_sleep(DisasContext *ctx, arg_SLEEP *a, powerpc_pm_insn_t type)
>>>>    {
>>>>        REQUIRE_64BIT(ctx);
>>>>    
>>>>    #if defined(CONFIG_USER_ONLY)
>>>>        gen_priv_opc(ctx);
>>>> -#else
>>>> +#elif defined(TARGET_PPC64)
>>>>        TCGv_i32 t;
>>>>    
>>>>        REQUIRE_HV(ctx);
>>>>        translator_io_start(&ctx->base);
>>>> -    t = tcg_constant_i32(PPC_PM_RVWINKLE);
>>>> -    gen_helper_pminsn(tcg_env, t);
>>>> +    t = tcg_constant_i32(type);
>>>> +    gen_helper_PMINSN(tcg_env, t);
>>>>        /* Stop translation, as the CPU is supposed to sleep from now */
>>>>        gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>>>> -#endif /* defined(CONFIG_USER_ONLY) */
>>>> -    return true;
>>>> -}
>>>> -TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_rvwinkle);
>>>> -
>>>> -static bool do_stop(DisasContext *ctx, arg_STOP *a)
>>>> -{
>>>> -    REQUIRE_64BIT(ctx);
>>>> -
>>>> -#if defined(CONFIG_USER_ONLY)
>>>> -    gen_priv_opc(ctx);
>>>>    #else
>>>> -    TCGv_i32 t;
>>>> -
>>>> -    REQUIRE_HV(ctx);
>>>> -    translator_io_start(&ctx->base);
>>>> -    t = tcg_constant_i32(PPC_PM_STOP);
>>>> -    gen_helper_pminsn(tcg_env, t);
>>>> -    /* Stop translation, as the CPU is supposed to sleep from now */
>>>> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>>>> +    qemu_build_not_reached();
>>>>    #endif
>>>>        return true;
>>>>    }
>>>> -TRANS_FLAGS2(ISA300, STOP, do_stop);
>>>> +TRANS_FLAGS2(PM_ISA206, DOZE, do_sleep, PPC_PM_DOZE);
>>>> +TRANS_FLAGS2(PM_ISA206, NAP, do_sleep, PPC_PM_NAP);
>>>> +TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep, PPC_PM_SLEEP);
>>>> +TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_sleep, PPC_PM_RVWINKLE);
>>>> +TRANS_FLAGS2(ISA300, STOP, do_sleep, PPC_PM_STOP);
>

