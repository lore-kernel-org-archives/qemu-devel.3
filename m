Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B42C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkEa-0004ns-2e; Fri, 19 Apr 2024 05:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkEY-0004nb-72; Fri, 19 Apr 2024 05:08:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkEU-0002dC-U0; Fri, 19 Apr 2024 05:08:37 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J8wQNn021656; Fri, 19 Apr 2024 09:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Iv+VUdJnEGYL4hSB3Jr6IiU6aynMxMDI8jThlvJXoGM=;
 b=PNwKiYactYEnyfgN8QnidDH6/mYk0h6nL84OwCDToGH7s585RjPNfOoq1VrbBuCQm+B1
 CqZMhIrC8H1SaJcbRgULkQrHf19PvZMzJOd9gpQv9CHUngiQJ6hgAzHNyRYG48zcGewI
 vu/iWMpa3vSX41ba7T4o+2eDJDwWgiZNWUU9MjSq/XQJhJdyMIV9c1Rzl0kO5ulUPsep
 GnmttkbJnq6kRQl+1HaJL6h56i4Zbpm3ePRiPHikB3gnnYiOkH7wOxvYN5gLGvj7EcsR
 5Jx6KiJeMmmIgOPMf+xMb8Z5PCotzS+mdb7JXV8GrQHCWS7DDk5F6DHJo7TpsJAOTdk+ Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xknje80s2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:08:27 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43J97lMP003132;
 Fri, 19 Apr 2024 09:08:27 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xknje80s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:08:27 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J8f4Fc030331; Fri, 19 Apr 2024 09:08:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xkbmcjpy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:08:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43J98LuD10158478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2024 09:08:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D64052006C;
 Fri, 19 Apr 2024 09:08:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A08320067;
 Fri, 19 Apr 2024 09:08:18 +0000 (GMT)
Received: from [9.171.89.59] (unknown [9.171.89.59])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Apr 2024 09:08:18 +0000 (GMT)
Message-ID: <2203447f-0e3d-4f75-abba-7b8e061783e6@linux.vnet.ibm.com>
Date: Fri, 19 Apr 2024 14:38:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] target/ppc: Move mul{li, lw, lwo, hw, hwu}
 instructions to decodetree.
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-2-rathc@linux.ibm.com>
 <1cb63686-bbb1-4c7a-89ad-51f5da248029@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <1cb63686-bbb1-4c7a-89ad-51f5da248029@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tPgPl8FfSu-KiAxfhpW_zIVpgulApja4
X-Proofpoint-ORIG-GUID: 83vYfzaCzICbqjfz9p4DVzfHhXNb7rYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 phishscore=0 clxscore=1011 spamscore=0 adultscore=0 mlxlogscore=966
 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190067
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

On 4/16/24 23:26, Richard Henderson wrote:
> On 4/15/24 23:39, Chinmay Rath wrote:
>> Moving the following instructions to decodetree specification :
>>     mulli                       : D-form
>>     mul{lw, lwo, hw, hwu}[.]    : XO-form
>>
>> The changes were verified by validating that the tcg ops generated by 
>> those
>> instructions remain the same, which were captured with the '-d 
>> in_asm,op' flag.
>>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   target/ppc/insn32.decode                   |  9 +++
>>   target/ppc/translate.c                     | 89 ----------------------
>>   target/ppc/translate/fixedpoint-impl.c.inc | 71 +++++++++++++++++
>>   3 files changed, 80 insertions(+), 89 deletions(-)
>
> This is an accurate reorg of the current code, so
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thank you.
>
> However, as follow-up, the code generation could be cleaned up:
>
>
>> +static bool trans_MULLW(DisasContext *ctx, arg_MULLW *a)
>> +{
>> +#if defined(TARGET_PPC64)
>> +    TCGv_i64 t0, t1;
>> +    t0 = tcg_temp_new_i64();
>> +    t1 = tcg_temp_new_i64();
>> +    tcg_gen_ext32s_tl(t0, cpu_gpr[a->ra]);
>> +    tcg_gen_ext32s_tl(t1, cpu_gpr[a->rb]);
>> +    tcg_gen_mul_i64(cpu_gpr[a->rt], t0, t1);
>> +#else
>> +    tcg_gen_mul_i32(cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb]);
>> +#endif
>> +    if (unlikely(a->rc)) {
>> +        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
>> +    }
>> +    return true;
>> +}
>
> Without ifdefs:
>
>     TCGv t0 = tcg_temp_new();
>     TCGv t1 = tcg_temp_new();
>
>     tcg_gen_ext32s_tl(t0, ra);
>     tcg_gen_ext32s_tl(t1, rb);
>     tcg_gen_mul_tl(rt, t0, t1);
>
> For ppc32, ext32s_tl will turn into a mov, which will be optimized 
> away.  So ideal code generation for both modes.
>
>
>> +static bool trans_MULLWO(DisasContext *ctx, arg_MULLWO *a)
>> +{
>> +    TCGv_i32 t0 = tcg_temp_new_i32();
>> +    TCGv_i32 t1 = tcg_temp_new_i32();
>> +
>> +    tcg_gen_trunc_tl_i32(t0, cpu_gpr[a->ra]);
>> +    tcg_gen_trunc_tl_i32(t1, cpu_gpr[a->rb]);
>> +    tcg_gen_muls2_i32(t0, t1, t0, t1);
>> +#if defined(TARGET_PPC64)
>> +    tcg_gen_concat_i32_i64(cpu_gpr[a->rt], t0, t1);
>> +#else
>> +    tcg_gen_mov_i32(cpu_gpr[a->rt], t0);
>> +#endif
>> +
>> +    tcg_gen_sari_i32(t0, t0, 31);
>> +    tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t1);
>> +    tcg_gen_extu_i32_tl(cpu_ov, t0);
>
> Usually hosts need to create the full 64-bit product and then break it 
> apart for tcg_gen_muls2_i32, so split followed immediately by 
> concatenate isn't great.
>
>
>     TCGv t0 = tcg_temp_new();
>     TCGv t1 = tcg_temp_new();
>
> #ifdef TARGET_PPC64
>     tcg_gen_ext32s_i64(t0, ra);
>     tcg_gen_ext32s_i64(t1, rb);
>     tcg_gen_mul_i64(rt, t0, t1);
>     tcg_gen_sextract_i64(t0, rt, 31, 1);
>     tcg_gen_sari_i64(t1, rt, 32);
> #else
>     tcg_gen_muls2_i32(rt, t1, ra, rb);
>     tcg_gen_sari_i32(t0, rt, 31);
> #endif
>     tcg_gen_setcond_tl(TCG_COND_NE, cpu_ov, t0, t1);
>
Sure, will update in v2.
Thanks,
Chinmay
>
>> +    if (is_isa300(ctx)) {
>> +        tcg_gen_mov_tl(cpu_ov32, cpu_ov);
>> +    }
>> +    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
>> +
>> +    if (unlikely(a->rc)) {
>> +        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
>> +    }
>> +    return true;
>> +}
>
>
> r~
>


