Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D295BC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkNAB-0000Pz-AL; Wed, 13 Mar 2024 07:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rkNA4-0000MW-Ib; Wed, 13 Mar 2024 07:52:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rkN9x-0004DN-IH; Wed, 13 Mar 2024 07:52:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42DBes3h020942; Wed, 13 Mar 2024 11:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=snu3Cje9b1hVIrPQR0zzRwfMwLOc1tjve8uIANffzmk=;
 b=s3Eaw8TEekDymeQvE8RWg5hd2YoP7+mU917mUDcnUJS9UY511XyXlIWTsKoK3k8jroGJ
 +naeM4Wh+52bYHjIqf8M8FtpnhpbiJ7ZOgSzuKyeiksIIHNbx+InWyY8ozlUhfHvkj2Y
 9yWsGl7c3xN0amShC0SWvaanDak+FtnNuUbnZMYB1/kMUlkhTGxyr0L9Et8sZPHtfek2
 u0pWBqKynaGvX7QJzLEVR2AuKmzPQlmJ+ogdH3AWumGoCiB64V6heM9IoxoEVweLgBDc
 5ycFp5PNqCR+mlHyG74m6Nk7NNnT/3nq1DK3T2ZFvg0HyK/vmeCyRw3oiV/+/uVyKYZJ 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuauf8p09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Mar 2024 11:52:31 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42DBhh9C026971;
 Wed, 13 Mar 2024 11:52:31 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuauf8p04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Mar 2024 11:52:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42D9Kmg5018128; Wed, 13 Mar 2024 11:52:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23tdtdg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Mar 2024 11:52:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42DBqPqI49217826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 11:52:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0C7920043;
 Wed, 13 Mar 2024 11:52:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 282C120040;
 Wed, 13 Mar 2024 11:52:23 +0000 (GMT)
Received: from [9.199.192.140] (unknown [9.199.192.140])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 Mar 2024 11:52:22 +0000 (GMT)
Message-ID: <a69ae066-defb-4a73-8867-bd582de04bf8@linux.vnet.ibm.com>
Date: Wed, 13 Mar 2024 17:22:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Move floating-point arithmetic instructions
 to decodetree.
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, richard.henderson@linaro.org,
 harshpb@linux.ibm.com, sbhat@linux.ibm.com
References: <20240307110318.170319-1-rathc@linux.ibm.com>
 <CZRONZ09DV9X.22XWTY7M4VBHO@wheely>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <CZRONZ09DV9X.22XWTY7M4VBHO@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S_VIGkV0EPoNDEJHJyU39t2b2EkbMApf
X-Proofpoint-GUID: PV6ql2RHhexeZJP9ysoPsZ4mHZXarjSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130088
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/12/24 15:31, Nicholas Piggin wrote:
> On Thu Mar 7, 2024 at 9:03 PM AEST, Chinmay Rath wrote:
>> diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
>> index 189cd8c979..03b84ba79b 100644
>> --- a/target/ppc/translate/fp-impl.c.inc
>> +++ b/target/ppc/translate/fp-impl.c.inc
>> @@ -30,96 +30,73 @@ static void gen_set_cr1_from_fpscr(DisasContext *ctx)
>>   #endif
>>   
>>   /***                       Floating-Point arithmetic                       ***/
>> -#define _GEN_FLOAT_ACB(name, op1, op2, set_fprf, type)                        \
>> -static void gen_f##name(DisasContext *ctx)                                    \
>> -{                                                                             \
>> -    TCGv_i64 t0;                                                              \
>> -    TCGv_i64 t1;                                                              \
>> -    TCGv_i64 t2;                                                              \
>> -    TCGv_i64 t3;                                                              \
>> -    if (unlikely(!ctx->fpu_enabled)) {                                        \
>> -        gen_exception(ctx, POWERPC_EXCP_FPU);                                 \
>> -        return;                                                               \
>> -    }                                                                         \
>> -    t0 = tcg_temp_new_i64();                                                  \
>> -    t1 = tcg_temp_new_i64();                                                  \
>> -    t2 = tcg_temp_new_i64();                                                  \
>> -    t3 = tcg_temp_new_i64();                                                  \
>> -    gen_reset_fpstatus();                                                     \
>> -    get_fpr(t0, rA(ctx->opcode));                                             \
>> -    get_fpr(t1, rC(ctx->opcode));                                             \
>> -    get_fpr(t2, rB(ctx->opcode));                                             \
>> -    gen_helper_f##name(t3, tcg_env, t0, t1, t2);                              \
>> -    set_fpr(rD(ctx->opcode), t3);                                             \
>> -    if (set_fprf) {                                                           \
>> -        gen_compute_fprf_float64(t3);                                         \
>> -    }                                                                         \
>> -    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
>> -        gen_set_cr1_from_fpscr(ctx);                                          \
>> -    }                                                                         \
>> +static bool do_helper_acb(DisasContext *ctx, arg_A *a,
>> +                          void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64,
>> +                                         TCGv_i64, TCGv_i64))
>> +{
>> +    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
>> +    REQUIRE_FPU(ctx);
>> +    TCGv_i64 t0, t1, t2, t3;
> Existing style prefers the variable declarations first I think.
>
>> +    t0 = tcg_temp_new_i64();
>> +    t1 = tcg_temp_new_i64();
>> +    t2 = tcg_temp_new_i64();
>> +    t3 = tcg_temp_new_i64();
>> +    gen_reset_fpstatus();
>> +    get_fpr(t0, a->fra);
>> +    get_fpr(t1, a->frc);
>> +    get_fpr(t2, a->frb);
>> +    helper(t3, tcg_env, t0, t1, t2);
>> +    set_fpr(a->frt, t3);
>> +    gen_compute_fprf_float64(t3);
>> +    if (unlikely(a->rc != false)) {
> This reads better without the double negative. I.e., just
>    if (unlikely(a->rc)) {
>
> Otherwise the decodetree parts look good, with those updated
> and split out from the helper generation:
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Thanks Nick, I shall post v2 with suggested updates.

Regards,
Chinmay
>
> Thanks,
> Nick
>
>> +        gen_set_cr1_from_fpscr(ctx);
>> +    }
>> +    return true;
>>   }
>
>>   
>> -#define GEN_FLOAT_ACB(name, op2, set_fprf, type)                              \
>> -_GEN_FLOAT_ACB(name, 0x3F, op2, set_fprf, type);                              \
>> -_GEN_FLOAT_ACB(name##s, 0x3B, op2, set_fprf, type);
>> -
>> -#define _GEN_FLOAT_AB(name, op1, op2, inval, set_fprf, type)                  \
>> -static void gen_f##name(DisasContext *ctx)                                    \
>> -{                                                                             \
>> -    TCGv_i64 t0;                                                              \
>> -    TCGv_i64 t1;                                                              \
>> -    TCGv_i64 t2;                                                              \
>> -    if (unlikely(!ctx->fpu_enabled)) {                                        \
>> -        gen_exception(ctx, POWERPC_EXCP_FPU);                                 \
>> -        return;                                                               \
>> -    }                                                                         \
>> -    t0 = tcg_temp_new_i64();                                                  \
>> -    t1 = tcg_temp_new_i64();                                                  \
>> -    t2 = tcg_temp_new_i64();                                                  \
>> -    gen_reset_fpstatus();                                                     \
>> -    get_fpr(t0, rA(ctx->opcode));                                             \
>> -    get_fpr(t1, rB(ctx->opcode));                                             \
>> -    gen_helper_f##name(t2, tcg_env, t0, t1);                                  \
>> -    set_fpr(rD(ctx->opcode), t2);                                             \
>> -    if (set_fprf) {                                                           \
>> -        gen_compute_fprf_float64(t2);                                         \
>> -    }                                                                         \
>> -    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
>> -        gen_set_cr1_from_fpscr(ctx);                                          \
>> -    }                                                                         \
>> +static bool do_helper_ab(DisasContext *ctx, arg_A_tab *a,
>> +                         void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64,
>> +                                        TCGv_i64))
>> +{
>> +    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
>> +    REQUIRE_FPU(ctx);
>> +    TCGv_i64 t0, t1, t2;
>> +    t0 = tcg_temp_new_i64();
>> +    t1 = tcg_temp_new_i64();
>> +    t2 = tcg_temp_new_i64();
>> +    gen_reset_fpstatus();
>> +    get_fpr(t0, a->fra);
>> +    get_fpr(t1, a->frb);
>> +    helper(t2, tcg_env, t0, t1);
>> +    set_fpr(a->frt, t2);
>> +    gen_compute_fprf_float64(t2);
>> +    if (unlikely(a->rc) != false) {
>> +        gen_set_cr1_from_fpscr(ctx);
>> +    }
>> +    return true;
>>   }
>> -#define GEN_FLOAT_AB(name, op2, inval, set_fprf, type)                        \
>> -_GEN_FLOAT_AB(name, 0x3F, op2, inval, set_fprf, type);                        \
>> -_GEN_FLOAT_AB(name##s, 0x3B, op2, inval, set_fprf, type);
>>   
>> -#define _GEN_FLOAT_AC(name, op1, op2, inval, set_fprf, type)                  \
>> -static void gen_f##name(DisasContext *ctx)                                    \
>> -{                                                                             \
>> -    TCGv_i64 t0;                                                              \
>> -    TCGv_i64 t1;                                                              \
>> -    TCGv_i64 t2;                                                              \
>> -    if (unlikely(!ctx->fpu_enabled)) {                                        \
>> -        gen_exception(ctx, POWERPC_EXCP_FPU);                                 \
>> -        return;                                                               \
>> -    }                                                                         \
>> -    t0 = tcg_temp_new_i64();                                                  \
>> -    t1 = tcg_temp_new_i64();                                                  \
>> -    t2 = tcg_temp_new_i64();                                                  \
>> -    gen_reset_fpstatus();                                                     \
>> -    get_fpr(t0, rA(ctx->opcode));                                             \
>> -    get_fpr(t1, rC(ctx->opcode));                                             \
>> -    gen_helper_f##name(t2, tcg_env, t0, t1);                                  \
>> -    set_fpr(rD(ctx->opcode), t2);                                             \
>> -    if (set_fprf) {                                                           \
>> -        gen_compute_fprf_float64(t2);                                         \
>> -    }                                                                         \
>> -    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
>> -        gen_set_cr1_from_fpscr(ctx);                                          \
>> -    }                                                                         \
>> +static bool do_helper_ac(DisasContext *ctx, arg_A_tac *a,
>> +                         void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64,
>> +                                        TCGv_i64))
>> +{
>> +    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
>> +    REQUIRE_FPU(ctx);
>> +    TCGv_i64 t0, t1, t2;
>> +    t0 = tcg_temp_new_i64();
>> +    t1 = tcg_temp_new_i64();
>> +    t2 = tcg_temp_new_i64();
>> +    gen_reset_fpstatus();
>> +    get_fpr(t0, a->fra);
>> +    get_fpr(t1, a->frc);
>> +    helper(t2, tcg_env, t0, t1);
>> +    set_fpr(a->frt, t2);
>> +    gen_compute_fprf_float64(t2);
>> +    if (unlikely(a->rc) != false) {
>> +        gen_set_cr1_from_fpscr(ctx);
>> +    }
>> +    return true;
>>   }
>> -#define GEN_FLOAT_AC(name, op2, inval, set_fprf, type)                        \
>> -_GEN_FLOAT_AC(name, 0x3F, op2, inval, set_fprf, type);                        \
>> -_GEN_FLOAT_AC(name##s, 0x3B, op2, inval, set_fprf, type);
>>   
>>   #define GEN_FLOAT_B(name, op2, op3, set_fprf, type)                           \
>>   static void gen_f##name(DisasContext *ctx)                                    \
>> @@ -145,64 +122,22 @@ static void gen_f##name(DisasContext *ctx)                                    \
>>       }                                                                         \
>>   }
>>   
>> -#define GEN_FLOAT_BS(name, op1, op2, set_fprf, type)                          \
>> -static void gen_f##name(DisasContext *ctx)                                    \
>> -{                                                                             \
>> -    TCGv_i64 t0;                                                              \
>> -    TCGv_i64 t1;                                                              \
>> -    if (unlikely(!ctx->fpu_enabled)) {                                        \
>> -        gen_exception(ctx, POWERPC_EXCP_FPU);                                 \
>> -        return;                                                               \
>> -    }                                                                         \
>> -    t0 = tcg_temp_new_i64();                                                  \
>> -    t1 = tcg_temp_new_i64();                                                  \
>> -    gen_reset_fpstatus();                                                     \
>> -    get_fpr(t0, rB(ctx->opcode));                                             \
>> -    gen_helper_f##name(t1, tcg_env, t0);                                      \
>> -    set_fpr(rD(ctx->opcode), t1);                                             \
>> -    if (set_fprf) {                                                           \
>> -        gen_compute_fprf_float64(t1);                                         \
>> -    }                                                                         \
>> -    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
>> -        gen_set_cr1_from_fpscr(ctx);                                          \
>> -    }                                                                         \
>> -}
>> -
>> -/* fadd - fadds */
>> -GEN_FLOAT_AB(add, 0x15, 0x000007C0, 1, PPC_FLOAT);
>> -/* fdiv - fdivs */
>> -GEN_FLOAT_AB(div, 0x12, 0x000007C0, 1, PPC_FLOAT);
>> -/* fmul - fmuls */
>> -GEN_FLOAT_AC(mul, 0x19, 0x0000F800, 1, PPC_FLOAT);
>> -
>> -/* fre */
>> -GEN_FLOAT_BS(re, 0x3F, 0x18, 1, PPC_FLOAT_EXT);
>> -
>> -/* fres */
>> -GEN_FLOAT_BS(res, 0x3B, 0x18, 1, PPC_FLOAT_FRES);
>> -
>> -/* frsqrte */
>> -GEN_FLOAT_BS(rsqrte, 0x3F, 0x1A, 1, PPC_FLOAT_FRSQRTE);
>> -
>> -/* frsqrtes */
>> -static void gen_frsqrtes(DisasContext *ctx)
>> +static bool do_helper_bs(DisasContext *ctx, arg_A_tb *a,
>> +                         void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64))
>>   {
>> -    TCGv_i64 t0;
>> -    TCGv_i64 t1;
>> -    if (unlikely(!ctx->fpu_enabled)) {
>> -        gen_exception(ctx, POWERPC_EXCP_FPU);
>> -        return;
>> -    }
>> +    REQUIRE_FPU(ctx);
>> +    TCGv_i64 t0, t1;
>>       t0 = tcg_temp_new_i64();
>>       t1 = tcg_temp_new_i64();
>>       gen_reset_fpstatus();
>> -    get_fpr(t0, rB(ctx->opcode));
>> -    gen_helper_frsqrtes(t1, tcg_env, t0);
>> -    set_fpr(rD(ctx->opcode), t1);
>> +    get_fpr(t0, a->frb);
>> +    helper(t1, tcg_env, t0);
>> +    set_fpr(a->frt, t1);
>>       gen_compute_fprf_float64(t1);
>> -    if (unlikely(Rc(ctx->opcode) != 0)) {
>> +    if (unlikely(a->rc != false)) {
>>           gen_set_cr1_from_fpscr(ctx);
>>       }
>> +    return true;
>>   }
>>   
>>   static bool trans_FSEL(DisasContext *ctx, arg_A *a)
>> @@ -228,10 +163,6 @@ static bool trans_FSEL(DisasContext *ctx, arg_A *a)
>>       return true;
>>   }
>>   
>> -/* fsub - fsubs */
>> -GEN_FLOAT_AB(sub, 0x14, 0x000007C0, 1, PPC_FLOAT);
>> -/* Optional: */
>> -
>>   static bool do_helper_fsqrt(DisasContext *ctx, arg_A_tb *a,
>>                               void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64))
>>   {
>> @@ -254,19 +185,33 @@ static bool do_helper_fsqrt(DisasContext *ctx, arg_A_tb *a,
>>       return true;
>>   }
>>   
>> +TRANS(FADD, do_helper_ab, gen_helper_FADD);
>> +TRANS(FADDS, do_helper_ab, gen_helper_FADDS);
>> +TRANS(FSUB, do_helper_ab, gen_helper_FSUB);
>> +TRANS(FSUBS, do_helper_ab, gen_helper_FSUBS);
>> +TRANS(FDIV, do_helper_ab, gen_helper_FDIV);
>> +TRANS(FDIVS, do_helper_ab, gen_helper_FDIVS);
>> +TRANS(FMUL, do_helper_ac, gen_helper_FMUL);
>> +TRANS(FMULS, do_helper_ac, gen_helper_FMULS);
>> +
>> +TRANS(FMADD, do_helper_acb, gen_helper_FMADD);
>> +TRANS(FMADDS, do_helper_acb, gen_helper_FMADDS);
>> +TRANS(FMSUB, do_helper_acb, gen_helper_FMSUB);
>> +TRANS(FMSUBS, do_helper_acb, gen_helper_FMSUBS);
>> +
>> +TRANS(FNMADD, do_helper_acb, gen_helper_FNMADD);
>> +TRANS(FNMADDS, do_helper_acb, gen_helper_FNMADDS);
>> +TRANS(FNMSUB, do_helper_acb, gen_helper_FNMSUB);
>> +TRANS(FNMSUBS, do_helper_acb, gen_helper_FNMSUBS);
>> +
>> +TRANS_FLAGS(FLOAT_EXT, FRE, do_helper_bs, gen_helper_FRE);
>> +TRANS_FLAGS(FLOAT_FRES, FRES, do_helper_bs, gen_helper_FRES);
>> +TRANS_FLAGS(FLOAT_FRSQRTE, FRSQRTE, do_helper_bs, gen_helper_FRSQRTE);
>> +TRANS_FLAGS(FLOAT_FRSQRTES, FRSQRTES, do_helper_bs, gen_helper_FRSQRTES);
>> +
>>   TRANS(FSQRT, do_helper_fsqrt, gen_helper_FSQRT);
>>   TRANS(FSQRTS, do_helper_fsqrt, gen_helper_FSQRTS);
>>   
>> -/***                     Floating-Point multiply-and-add                   ***/
>> -/* fmadd - fmadds */
>> -GEN_FLOAT_ACB(madd, 0x1D, 1, PPC_FLOAT);
>> -/* fmsub - fmsubs */
>> -GEN_FLOAT_ACB(msub, 0x1C, 1, PPC_FLOAT);
>> -/* fnmadd - fnmadds */
>> -GEN_FLOAT_ACB(nmadd, 0x1F, 1, PPC_FLOAT);
>> -/* fnmsub - fnmsubs */
>> -GEN_FLOAT_ACB(nmsub, 0x1E, 1, PPC_FLOAT);
>> -
>>   /***                     Floating-Point round & convert                    ***/
>>   /* fctiw */
>>   GEN_FLOAT_B(ctiw, 0x0E, 0x00, 0, PPC_FLOAT);
>> @@ -304,35 +249,29 @@ GEN_FLOAT_B(rip, 0x08, 0x0E, 1, PPC_FLOAT_EXT);
>>   /* frim */
>>   GEN_FLOAT_B(rim, 0x08, 0x0F, 1, PPC_FLOAT_EXT);
>>   
>> -static void gen_ftdiv(DisasContext *ctx)
>> +static bool trans_FTDIV(DisasContext *ctx, arg_X_bf *a)
>>   {
>> -    TCGv_i64 t0;
>> -    TCGv_i64 t1;
>> -    if (unlikely(!ctx->fpu_enabled)) {
>> -        gen_exception(ctx, POWERPC_EXCP_FPU);
>> -        return;
>> -    }
>> +    REQUIRE_INSNS_FLAGS2(ctx, FP_TST_ISA206);
>> +    REQUIRE_FPU(ctx);
>> +    TCGv_i64 t0, t1;
>>       t0 = tcg_temp_new_i64();
>>       t1 = tcg_temp_new_i64();
>> -    get_fpr(t0, rA(ctx->opcode));
>> -    get_fpr(t1, rB(ctx->opcode));
>> -    gen_helper_ftdiv(cpu_crf[crfD(ctx->opcode)], t0, t1);
>> +    get_fpr(t0, a->ra);
>> +    get_fpr(t1, a->rb);
>> +    gen_helper_FTDIV(cpu_crf[a->bf], t0, t1);
>> +    return true;
>>   }
>>   
>> -static void gen_ftsqrt(DisasContext *ctx)
>> +static bool trans_FTSQRT(DisasContext *ctx, arg_X_bf_b *a)
>>   {
>> -    TCGv_i64 t0;
>> -    if (unlikely(!ctx->fpu_enabled)) {
>> -        gen_exception(ctx, POWERPC_EXCP_FPU);
>> -        return;
>> -    }
>> -    t0 = tcg_temp_new_i64();
>> -    get_fpr(t0, rB(ctx->opcode));
>> -    gen_helper_ftsqrt(cpu_crf[crfD(ctx->opcode)], t0);
>> +    REQUIRE_INSNS_FLAGS2(ctx, FP_TST_ISA206);
>> +    REQUIRE_FPU(ctx);
>> +    TCGv_i64 t0 = tcg_temp_new_i64();
>> +    get_fpr(t0, a->rb);
>> +    gen_helper_FTSQRT(cpu_crf[a->bf], t0);
>> +    return true;
>>   }
>>   
>> -
>> -
>>   /***                         Floating-Point compare                        ***/
>>   
>>   /* fcmpo */
>> @@ -1111,14 +1050,7 @@ TRANS(STFDX, do_lsfp_X, false, true, false)
>>   TRANS(STFDUX, do_lsfp_X, true, true, false)
>>   TRANS(PSTFD, do_lsfp_PLS_D, false, true, false)
>>   
>> -#undef _GEN_FLOAT_ACB
>> -#undef GEN_FLOAT_ACB
>> -#undef _GEN_FLOAT_AB
>> -#undef GEN_FLOAT_AB
>> -#undef _GEN_FLOAT_AC
>> -#undef GEN_FLOAT_AC
>>   #undef GEN_FLOAT_B
>> -#undef GEN_FLOAT_BS
>>   
>>   #undef GEN_LDF
>>   #undef GEN_LDUF
>> diff --git a/target/ppc/translate/fp-ops.c.inc b/target/ppc/translate/fp-ops.c.inc
>> index d4c6c4bed1..cef4b5dfcb 100644
>> --- a/target/ppc/translate/fp-ops.c.inc
>> +++ b/target/ppc/translate/fp-ops.c.inc
>> @@ -1,36 +1,6 @@
>> -#define _GEN_FLOAT_ACB(name, op, op1, op2, isfloat, set_fprf, type)           \
>> -GEN_HANDLER(f##name, op1, op2, 0xFF, 0x00000000, type)
>> -#define GEN_FLOAT_ACB(name, op2, set_fprf, type)                              \
>> -_GEN_FLOAT_ACB(name, name, 0x3F, op2, 0, set_fprf, type),                     \
>> -_GEN_FLOAT_ACB(name##s, name, 0x3B, op2, 1, set_fprf, type)
>> -#define _GEN_FLOAT_AB(name, op, op1, op2, inval, isfloat, set_fprf, type)     \
>> -GEN_HANDLER(f##name, op1, op2, 0xFF, inval, type)
>> -#define GEN_FLOAT_AB(name, op2, inval, set_fprf, type)                        \
>> -_GEN_FLOAT_AB(name, name, 0x3F, op2, inval, 0, set_fprf, type),               \
>> -_GEN_FLOAT_AB(name##s, name, 0x3B, op2, inval, 1, set_fprf, type)
>> -#define _GEN_FLOAT_AC(name, op, op1, op2, inval, isfloat, set_fprf, type)     \
>> -GEN_HANDLER(f##name, op1, op2, 0xFF, inval, type)
>> -#define GEN_FLOAT_AC(name, op2, inval, set_fprf, type)                        \
>> -_GEN_FLOAT_AC(name, name, 0x3F, op2, inval, 0, set_fprf, type),               \
>> -_GEN_FLOAT_AC(name##s, name, 0x3B, op2, inval, 1, set_fprf, type)
>>   #define GEN_FLOAT_B(name, op2, op3, set_fprf, type)                           \
>>   GEN_HANDLER(f##name, 0x3F, op2, op3, 0x001F0000, type)
>> -#define GEN_FLOAT_BS(name, op1, op2, set_fprf, type)                          \
>> -GEN_HANDLER(f##name, op1, op2, 0xFF, 0x001F07C0, type)
>>   
>> -GEN_FLOAT_AB(add, 0x15, 0x000007C0, 1, PPC_FLOAT),
>> -GEN_FLOAT_AB(div, 0x12, 0x000007C0, 1, PPC_FLOAT),
>> -GEN_FLOAT_AC(mul, 0x19, 0x0000F800, 1, PPC_FLOAT),
>> -GEN_FLOAT_BS(re, 0x3F, 0x18, 1, PPC_FLOAT_EXT),
>> -GEN_FLOAT_BS(res, 0x3B, 0x18, 1, PPC_FLOAT_FRES),
>> -GEN_FLOAT_BS(rsqrte, 0x3F, 0x1A, 1, PPC_FLOAT_FRSQRTE),
>> -GEN_FLOAT_AB(sub, 0x14, 0x000007C0, 1, PPC_FLOAT),
>> -GEN_FLOAT_ACB(madd, 0x1D, 1, PPC_FLOAT),
>> -GEN_FLOAT_ACB(msub, 0x1C, 1, PPC_FLOAT),
>> -GEN_FLOAT_ACB(nmadd, 0x1F, 1, PPC_FLOAT),
>> -GEN_FLOAT_ACB(nmsub, 0x1E, 1, PPC_FLOAT),
>> -GEN_HANDLER_E(ftdiv, 0x3F, 0x00, 0x04, 1, PPC_NONE, PPC2_FP_TST_ISA206),
>> -GEN_HANDLER_E(ftsqrt, 0x3F, 0x00, 0x05, 1, PPC_NONE, PPC2_FP_TST_ISA206),
>>   GEN_FLOAT_B(ctiw, 0x0E, 0x00, 0, PPC_FLOAT),
>>   GEN_HANDLER_E(fctiwu, 0x3F, 0x0E, 0x04, 0, PPC_NONE, PPC2_FP_CVT_ISA206),
>>   GEN_FLOAT_B(ctiwz, 0x0F, 0x00, 0, PPC_FLOAT),
>> @@ -61,7 +31,6 @@ GEN_STXF(stfiw, st32fiw, 0x17, 0x1E, PPC_FLOAT_STFIWX)
>>   GEN_HANDLER_E(stfdepx, 0x1F, 0x1F, 0x16, 0x00000001, PPC_NONE, PPC2_BOOKE206),
>>   GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001, PPC_NONE, PPC2_ISA205),
>>   
>> -GEN_HANDLER(frsqrtes, 0x3B, 0x1A, 0xFF, 0x001F07C0, PPC_FLOAT_FRSQRTES),
>>   GEN_HANDLER(fcmpo, 0x3F, 0x00, 0x01, 0x00600001, PPC_FLOAT),
>>   GEN_HANDLER(fcmpu, 0x3F, 0x00, 0x00, 0x00600001, PPC_FLOAT),
>>   GEN_HANDLER(fabs, 0x3F, 0x08, 0x08, 0x001F0000, PPC_FLOAT),
>


