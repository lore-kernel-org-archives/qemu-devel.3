Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F262FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkYP-0006av-8L; Fri, 19 Apr 2024 05:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkYN-0006aG-E9; Fri, 19 Apr 2024 05:29:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkYL-0005zu-Bu; Fri, 19 Apr 2024 05:29:07 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J8wWHS016096; Fri, 19 Apr 2024 09:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jIZW2RUExK6pZjoTO2hgaoc/QEZvaQ8aytOx2+e7P88=;
 b=O3PX3vIjPKwJ3erDN0Uu1dpWyULcm8N0cej43S+xBaOVVlOhdzNF40jV5sMYiBCWIKIe
 Wxi8+TR2D9kbKazF/2NtMhWv7V/t/NYnfNHL186sdtxcat4ybwnLH+V5dTzS7ynMbgb5
 PUMX7ps0FpVeT4z4GkzsJIFLf8rqiqX4ih+EcN1KmkUFHLp6UUZNewLJEQqecrC4MQE7
 0wJ+dF2VWz0yzxY/v9Ywhz3eK/lKxlDoSsdzCXX/zPx/mTbqYqRXXkjAjl/X2+iLsRJa
 0q5OPUl2MIBnYxN6HtIRdrJkKWRitMEPNGJ3D64URClsxDfVezU2zx2BJ8/gnpLylaED Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xknjmg2b4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:29:03 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43J9T2gW031906;
 Fri, 19 Apr 2024 09:29:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xknjmg2b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:29:02 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J8nZ6Z020993; Fri, 19 Apr 2024 09:29:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xkbm9js96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:29:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43J9Sunc45023582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2024 09:28:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 712D620040;
 Fri, 19 Apr 2024 09:28:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDDDA2004B;
 Fri, 19 Apr 2024 09:28:54 +0000 (GMT)
Received: from [9.171.89.59] (unknown [9.171.89.59])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Apr 2024 09:28:54 +0000 (GMT)
Message-ID: <0bc9e291-f072-42c2-b001-cf059f94291b@linux.vnet.ibm.com>
Date: Fri, 19 Apr 2024 14:58:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] target/ppc: Move cmp{rb, eqb}, tw[i], td[i], isel
 instructions to decodetree.
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-8-rathc@linux.ibm.com>
 <1f39a25e-6c64-4ff2-8521-7059c5ed2214@linaro.org>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <1f39a25e-6c64-4ff2-8521-7059c5ed2214@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dfC5aUFtjp72qVhlP7e_8yglkcKJvSMK
X-Proofpoint-ORIG-GUID: 7F59uBg5bO_sjAOY27jrmxWVpcz845_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190070
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Richard,

On 4/17/24 00:50, Richard Henderson wrote:
> On 4/15/24 23:39, Chinmay Rath wrote:
>> Moving the following instructions to decodetree specification :
>>
>>     cmp{rb, eqb}, t{w, d}    : X-form
>>     t{w, d}i        : D-form
>>     isel            : A-form
>>
>> The changes were verified by validating that the tcg ops generated by 
>> those
>> instructions remain the same, which were captured using the '-d 
>> in_asm,op' flag.
>>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>
> A faithful reorg of the existing code, so,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
Thank you.
> Notes for improvement:
>
>> +static bool trans_CMPRB(DisasContext *ctx, arg_CMPRB *a)
>> +{
>> +    TCGv_i32 src1 = tcg_temp_new_i32();
>> +    TCGv_i32 src2 = tcg_temp_new_i32();
>> +    TCGv_i32 src2lo = tcg_temp_new_i32();
>> +    TCGv_i32 src2hi = tcg_temp_new_i32();
>> +    TCGv_i32 crf = cpu_crf[a->bf];
>> +
>> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
>> +    tcg_gen_trunc_tl_i32(src1, cpu_gpr[a->ra]);
>> +    tcg_gen_trunc_tl_i32(src2, cpu_gpr[a->rb]);
>> +
>> +    tcg_gen_andi_i32(src1, src1, 0xFF);
>> +    tcg_gen_ext8u_i32(src2lo, src2);
>> +    tcg_gen_shri_i32(src2, src2, 8);
>> +    tcg_gen_ext8u_i32(src2hi, src2);
>
> tcg_gen_extract_i32(src2hi, src2, 8, 8);
>
>> +
>> +    tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
>> +    tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
>> +    tcg_gen_and_i32(crf, src2lo, src2hi);
>> +
>> +    if (a->l) {
>> +        tcg_gen_shri_i32(src2, src2, 8);
>> +        tcg_gen_ext8u_i32(src2lo, src2);
>
> tcg_gen_extract_i32(src2lo, src2, 16, 8);
>
>> +        tcg_gen_shri_i32(src2, src2, 8);
>> +        tcg_gen_ext8u_i32(src2hi, src2);
>
> tcg_gen_extract_i32(src2hi, src2, 24, 8);
>
Will update the above in v2.

Will implement the below improvements for trap insns as a separate patch 
later.

>> +/*
>> + * Fixed-Point Trap Instructions
>> + */
>> +
>> +static bool trans_TW(DisasContext *ctx, arg_TW *a)
>> +{
>> +    TCGv_i32 t0;
>> +
>> +    if (check_unconditional_trap(ctx, a->rt)) {
>> +        return true;
>> +    }
>> +    t0 = tcg_constant_i32(a->rt);
>> +    gen_helper_TW(tcg_env, cpu_gpr[a->ra], cpu_gpr[a->rb], t0);
>> +    return true;
>> +}
>> +
>> +static bool trans_TWI(DisasContext *ctx, arg_TWI *a)
>> +{
>> +    TCGv t0;
>> +    TCGv_i32 t1;
>> +
>> +    if (check_unconditional_trap(ctx, a->rt)) {
>> +        return true;
>> +    }
>> +    t0 = tcg_constant_tl(a->si);
>> +    t1 = tcg_constant_i32(a->rt);
>> +    gen_helper_TW(tcg_env, cpu_gpr[a->ra], t0, t1);
>> +    return true;
>> +}
>> +
>> +static bool trans_TD(DisasContext *ctx, arg_TD *a)
>> +{
>> +    TCGv_i32 t0;
>> +
>> +    REQUIRE_64BIT(ctx);
>> +    if (check_unconditional_trap(ctx, a->rt)) {
>> +        return true;
>> +    }
>> +    t0 = tcg_constant_i32(a->rt);
>> +    gen_helper_TD(tcg_env, cpu_gpr[a->ra], cpu_gpr[a->rb], t0);
>> +    return true;
>> +}
>> +
>> +static bool trans_TDI(DisasContext *ctx, arg_TDI *a)
>> +{
>> +    TCGv t0;
>> +    TCGv_i32 t1;
>> +
>> +    REQUIRE_64BIT(ctx);
>> +    if (check_unconditional_trap(ctx, a->rt)) {
>> +        return true;
>> +    }
>> +    t0 = tcg_constant_tl(a->si);
>> +    t1 = tcg_constant_i32(a->rt);
>> +    gen_helper_TD(tcg_env, cpu_gpr[a->ra], t0, t1);
>> +    return true;
>> +}
>
> See target/sparc/translate.c, delay_exception, for a method of 
> implementing compare-and-trap inline with no inline branch penalty.
>
> static void do_conditional_trap(DisasContext *ctx, unsigned to, TCGv 
> a, TCGv b)
> {
>     static const TCGCond ucond[8] = {
>         TCG_COND_NEVER, TCG_COND_GTU, TCG_COND_LTU, TCG_COND_NE,
>         TCG_COND_EQ,    TCG_COND_GEU, TCG_COND_LEU, TCG_COND_ALWAYS,
>     };
>     static const TCGCond scond[8] = {
>         TCG_COND_NEVER, TCG_COND_EQ,  TCG_COND_GT,  TCG_COND_GE,
>         TCG_COND_LT,    TCG_COND_LE,  TCG_COND_NE, TCG_COND_ALWAYS,
>     };
>
>     TCGCond uc = ucond[to & 7];
>     TCGCond sc = scond[to >> 2];
>
>     /* There is overlap with EQ; we may not need both comparisons. */
>     if (!(to & 0x18)) {
>         sc = TCG_COND_NEVER;
>     } else if (!(to & 0x03)) {
>         uc = TCG_COND_NEVER;
>     }
>
>     if (uc == TCG_COND_ALWAYS || sc == TCG_COND_ALWAYS) {
>         unconditional trap;
>         return true;
>     }
>     if (uc == TCG_COND_NEVER && sc == TCG_COND_NEVER) {
>         return true;
>     }
>
>     e = delay_exception(ctx, POWERPC_EXCP_TRAP);
>
>     if (uc != TCG_COND_NEVER) {
>         tcg_gen_brcond_tl(uc, a, b, e->lab);
>     }
>     if (sc != TCG_COND_NEVER) {
>         tcg_gen_brcond_tl(sc, a, b, e->lab);
>     }
>     return true;
> }
>
> bool trans_TW(...)
> {
>     TCGv a = tcg_temp_new();
>     TCGv b = tcg_temp_new();
>
>     /* Note that consistent sign extensions work for unsigned 
> comparisons. */
>     tcg_gen_exts_i32_tl(a, ra);
>     tcg_gen_exts_i32_tl(b, rb);
>     return do_conditional_trap(ctx, to, a, b);
> }
>
> etc.
>
>
Thanks,
Chinmay
> r~


