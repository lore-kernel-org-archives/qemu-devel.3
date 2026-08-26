Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7603C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDpy-0007OS-4W; Wed, 26 Aug 2026 09:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzDpw-0007Ft-6r; Wed, 26 Aug 2026 09:38:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzDpu-0004qF-4k; Wed, 26 Aug 2026 09:38:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCWCDL4003503; Wed, 26 Aug 2026 13:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=7mFyr0C7yXNf/n7EvbMb7H8HTyP0JV
 /x4u2DOm3DwBY=; b=NkTvWDTllHf3cuXCYtzvgCRAdvose3d+dnt7W8wE6y2iJV
 jFzsbqaXaLM96fmlms1bTAoy07S9YRGfWyf3ksg4SXZefp4dx95v3N4zL4T1FTkG
 vuTObzipI8rj4ci2bHzFJP5NAqdUdUgzG2lL5YhynX/lo55Mi8xfGYf0Fm+Oe+yO
 pIwi8R28PuiJ1MraQMlByXdBws123BEiURk1Ajo/oFpW0Uy6D6owMKtc3n2Ar5xh
 uJKmZz8ldIK6F7NU87Gb6HbL7dHVjfYxuwdViFp0kZ9VWMnElYK5bgJja1DU8/Q2
 Xe3J36jlJkIkSxkzEjI+XmPVBTiVo5s7wpXhd9VQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4xy1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 13:38:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QDQHIa029521;
 Wed, 26 Aug 2026 13:38:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k26cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 13:38:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QDcT9Q46006768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 13:38:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3598820040;
 Wed, 26 Aug 2026 13:38:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1663820043;
 Wed, 26 Aug 2026 13:38:26 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 13:38:25 +0000 (GMT)
Date: Wed, 26 Aug 2026 19:08:28 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 19/37] target/ppc: Refactor sleep and its variants to
 use a common helper
Message-ID: <20260826190655.dcb7940f-c3-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-20-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-20-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3URjozxg7rYh9TySsUoycXriDHTz8c-4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMiBTYWx0ZWRfX2h5RxogLEKH0
 5In9crpbzNqqsKqpswz5z0X1dTnI7ew0nfuQVs/NOzOfDbt7kCaQPgPaXiwyrODeW8YDeMBYryV
 ogvzD7CPoNTdgPX24ljyVAouTzVnSpk=
X-Proofpoint-GUID: xyPsTvnZYlrUkCkNskW4hN_e_YBwvqd8
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8eec5b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Sh8xzq_NNK_JfPLPuzwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMiBTYWx0ZWRfX9HBxSCFaKicf
 YUINa1KE5Xh/+RiJb79E8mDsodqpS4DaxToEEb+cYDDDmxDzM27B78rfupZkx/dDSRz3bq+gBP4
 TGE7WJSklWutRYk+fSXM9Cm59PkoCK3hZYd9nK7K/prdLOzHEYtaQuZuFovvtEoF6QohXnNa+ho
 r5COERV5zy/DixpwOucMmick+yRa7lbl6omyqd42FxE5i2quFQC0KLFIPC5FYC2ziOSrkUdC7sD
 h0+g5xzsq9ajmVRPbw1+xnk84FzB1gElb4mKGpz+2IfdtuMsqSrTyAUDvJwE0Epth4PlAyXFgXJ
 N3oVr5Cu9OUxmQ6clLGR+6RoR190j4Iji6brQ9naqDj/+X4spOopckQ+USf+6VkLgHbYLZfqQNA
 uN/gQq8PWKQLT/ZegP/ra+5C2LWCAzAJ0QZGCeKCDVcbqjcgoTj3Qdx6JrYS4bVVQT7u7AlDtZi
 M9hmdqjbcMYy8vh5sBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260112
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 2026/08/26 10:38 AM, Chinmay Rath wrote:
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> With sleep, doze, nap, rvwinkle and stop instructions moved to
> decodetree, the helper these instructions used : gen_helper_pminsn,
> should now be renamed to gen_helper_PMINSN, abiding by the decodetree
> standards. Do the same.
> Also refactor their translation routine to use a common do_sleep routine
> since they share majority of the code.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/helper.h                           |  2 +-
>  target/ppc/tcg-excp_helper.c                  |  2 +-
>  .../ppc/translate/processor-ctrl-impl.c.inc   | 99 +++----------------
>  3 files changed, 16 insertions(+), 87 deletions(-)

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index cd2a0948a3..7e15676122 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -18,7 +18,7 @@ DEF_HELPER_1(rfdi, void, env)
>  DEF_HELPER_1(rfmci, void, env)
>  #if defined(TARGET_PPC64)
>  DEF_HELPER_2(scv, noreturn, env, i32)
> -DEF_HELPER_2(pminsn, void, env, i32)
> +DEF_HELPER_2(PMINSN, void, env, i32)
>  DEF_HELPER_1(rfid, void, env)
>  DEF_HELPER_1(rfscv, void, env)
>  DEF_HELPER_1(hrfid, void, env)
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index b04f07a637..c4ffa2dfbb 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -459,7 +459,7 @@ void helper_scv(CPUPPCState *env, uint32_t lev)
>      }
>  }
>  
> -void helper_pminsn(CPUPPCState *env, uint32_t insn)
> +void helper_PMINSN(CPUPPCState *env, uint32_t insn)
>  {
>      CPUState *cs = env_cpu(env);
>  
> diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
> index bdbc195294..3b3ed3019a 100644
> --- a/target/ppc/translate/processor-ctrl-impl.c.inc
> +++ b/target/ppc/translate/processor-ctrl-impl.c.inc
> @@ -104,103 +104,32 @@ static bool trans_MSGSYNC(DisasContext *ctx, arg_MSGSYNC *a)
>      return true;
>  }
>  
> -static bool do_doze(DisasContext *ctx, arg_DOZE *a)
> -{
> -    REQUIRE_64BIT(ctx);
> -
> -#if defined(CONFIG_USER_ONLY)
> -    gen_priv_opc(ctx);
> -#else
> -    TCGv_i32 t;
> -
> -    REQUIRE_HV(ctx);
> -    translator_io_start(&ctx->base);
> -    t = tcg_constant_i32(PPC_PM_DOZE);
> -    gen_helper_pminsn(tcg_env, t);
> -    /* Stop translation, as the CPU is supposed to sleep from now */
> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> -#endif /* defined(CONFIG_USER_ONLY) */
> -
> -    return true;
> -}
> -TRANS_FLAGS2(PM_ISA206, DOZE, do_doze);
> -
> -static bool do_nap(DisasContext *ctx, arg_NAP *a)
> -{
> -    REQUIRE_64BIT(ctx);
> -
> -#if defined(CONFIG_USER_ONLY)
> -    gen_priv_opc(ctx);
> -#else
> -    TCGv_i32 t;
> -
> -    REQUIRE_HV(ctx);
> -    translator_io_start(&ctx->base);
> -    t = tcg_constant_i32(PPC_PM_NAP);
> -    gen_helper_pminsn(tcg_env, t);
> -    /* Stop translation, as the CPU is supposed to sleep from now */
> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> -#endif /* defined(CONFIG_USER_ONLY) */
> -    return true;
> -}
> -TRANS_FLAGS2(PM_ISA206, NAP, do_nap);
> -
> -static bool do_sleep(DisasContext *ctx, arg_SLEEP *a)
> -{
> -    REQUIRE_64BIT(ctx);
> -
> -#if defined(CONFIG_USER_ONLY)
> -    gen_priv_opc(ctx);
> -#else
> -    TCGv_i32 t;
> -
> -    REQUIRE_HV(ctx);
> -    translator_io_start(&ctx->base);
> -    t = tcg_constant_i32(PPC_PM_SLEEP);
> -    gen_helper_pminsn(tcg_env, t);
> -    /* Stop translation, as the CPU is supposed to sleep from now */
> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> -#endif /* defined(CONFIG_USER_ONLY) */
> -    return true;
> -}
> -TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep);
> -
> -static bool do_rvwinkle(DisasContext *ctx, arg_RVWINKLE *a)
> +/*
> + * Helper to handle DOZE, NAP, SLEEP, RVWINKLE & STOP. Since none of them use
> + * any arguments just use a placeholder arg_SLEEP.
> + */
> +static bool do_sleep(DisasContext *ctx, arg_SLEEP *a, powerpc_pm_insn_t type)
>  {
>      REQUIRE_64BIT(ctx);
>  
>  #if defined(CONFIG_USER_ONLY)
>      gen_priv_opc(ctx);
> -#else
> +#elif defined(TARGET_PPC64)
>      TCGv_i32 t;
>  
>      REQUIRE_HV(ctx);
>      translator_io_start(&ctx->base);
> -    t = tcg_constant_i32(PPC_PM_RVWINKLE);
> -    gen_helper_pminsn(tcg_env, t);
> +    t = tcg_constant_i32(type);
> +    gen_helper_PMINSN(tcg_env, t);
>      /* Stop translation, as the CPU is supposed to sleep from now */
>      gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> -#endif /* defined(CONFIG_USER_ONLY) */
> -    return true;
> -}
> -TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_rvwinkle);
> -
> -static bool do_stop(DisasContext *ctx, arg_STOP *a)
> -{
> -    REQUIRE_64BIT(ctx);
> -
> -#if defined(CONFIG_USER_ONLY)
> -    gen_priv_opc(ctx);
>  #else
> -    TCGv_i32 t;
> -
> -    REQUIRE_HV(ctx);
> -    translator_io_start(&ctx->base);
> -    t = tcg_constant_i32(PPC_PM_STOP);
> -    gen_helper_pminsn(tcg_env, t);
> -    /* Stop translation, as the CPU is supposed to sleep from now */
> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> +    qemu_build_not_reached();
>  #endif
>      return true;
>  }
> -TRANS_FLAGS2(ISA300, STOP, do_stop);
> +TRANS_FLAGS2(PM_ISA206, DOZE, do_sleep, PPC_PM_DOZE);
> +TRANS_FLAGS2(PM_ISA206, NAP, do_sleep, PPC_PM_NAP);
> +TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep, PPC_PM_SLEEP);
> +TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_sleep, PPC_PM_RVWINKLE);
> +TRANS_FLAGS2(ISA300, STOP, do_sleep, PPC_PM_STOP);
> -- 
> 2.55.0
> 

