Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8533C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVz8-0003y8-94; Mon, 24 Aug 2026 10:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVz6-0003xm-O5; Mon, 24 Aug 2026 10:49:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVz4-0001l6-GQ; Mon, 24 Aug 2026 10:49:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1WiY1935729; Mon, 24 Aug 2026 14:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=y1Y+ydIAp3GwpNuBcqxgedeXDnj7DeoffdZQQlLd8t4=; b=U1W1Q6Z6XDdC
 cp0lSvk0OUsZAG9oAJrDlV1Ybbg3Y+GRs40kxJ2svzV+lxa8fMDzkLiNraR9bcS9
 0D+O2o5aDjF/J8Jcct+/kBXHmiQZXxCudtd52GzC4ekVfbaYhOpTlj1jesTxsMdX
 2CTxp3SYSYTk5hVbp+jhYv4+m7+Y98DCnkj3+5F934vBNdi8IAnA6dW73fmDnQlZ
 HHwwZ2AHSZ44Wzs9zgMv4o4cx7x5i1CWAj+uPMN/sV7F6IRvpp12Zrdq0mtuz0kn
 vNXKeHiZ/ukcN5QI02dJ07BJ7ojqLfvmhnT9EpsECBKKVayfXfWvGEPcg4AtQpIW
 sAkobIK0lw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393t3wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:49:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEfJou030273;
 Mon, 24 Aug 2026 14:49:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag6epa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:49:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEn3jf30212732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:49:03 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A78BF5805D;
 Mon, 24 Aug 2026 14:49:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54E885805C;
 Mon, 24 Aug 2026 14:49:02 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:49:02 +0000 (GMT)
Message-ID: <30e5c527ac0ef1fc6de9cfd93a82a5d526d6edd2.camel@linux.ibm.com>
Subject: Re: [PATCH 18/29] target/ppc: Move sleep & friends to decodetree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:49:01 -0500
In-Reply-To: <20260820140114.327023-19-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-19-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: RERKlkARh99Y-sCW6tAXVybFG6JBF8A_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX4ZrByz4uR7w/
 bA2hvXgitNS94Zda5TwCuzbR96fqrlwHf+nyV2h5GCViIKStyg0d09zsM6ihS45DRlq5JZRhU8G
 /+UoEq7kOYivsfVdMnEd8Yp9PKZcLJBKeYHlY2yIGXZjt/LDFDltTsDETLoKn0wnf+uOzzMewWm
 oQ89QFOnYpsC8vTuIeHwE3MVZIGeQtwlEa6DI3rMMTgmhbsPTutDthDr58N1NseJPhgEBW+JTz/
 d6vb7rvqQvQYZ+8oBi+q+XhpZ85pq8yF63jZYVBauNgyZpncLMh81SDttUgMetQHS/tpSCnpfrm
 rJ4YejUDFjbh7Fd/MBDQcXaMQKlTCI9SZb5kDtJc1cUjWbw3GyQt84E1B7+DpKsVT/xs3jJNNBs
 LmXT/qyPUAST9Qm7Wl/R8mIde3kzLSU6huHfQVff1dsC4t651k0lrPsR01pzBcHeNpeUyP3gLm8
 txDuJYzet5k49vNWdgA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c59e3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=sNU4IewoFw3Vy9snC_4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX7gkSLzC9ZhDh
 xC/qkGIYdwVcyGkTeuk3w3SIUy4SdqukjO4KRhSZXU+X8iKXUhCtu0gbR2bmJwlqIUMfp3UaE7n
 jBj/BaZAmDqICNFf/RTXPxSOrin89eQ=
X-Proofpoint-ORIG-GUID: MtDzvlpD6JSZoh4M9-VTAyUbs6-hRSZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Convert the following instructions to decode tree specification:
> 
> doze
> nap
> sleep
> rvwinkle
> stop
> 
> The functionality was tested by comparing the qemu -D log -d op,in_asm
> output as well as single stepping gdb to confirm behavior was not
> changed for ISA3.x (stop) as well as ISA206 (doze, nap, sleep,
> rvwinkle).
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode                      |   8 ++
>  target/ppc/translate.c                        |  85 ---------------
>  .../ppc/translate/processor-ctrl-impl.c.inc   | 101 ++++++++++++++++++
>  3 files changed, 109 insertions(+), 85 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 3b8387b60c..d23168a303 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -913,6 +913,14 @@ VPERMR          000100 ..... ..... ..... ..... 111011   @VA
>  
>  VSEL            000100 ..... ..... ..... ..... 101010   @VA
>  
> +## Power Management Instructions
> +
> +DOZE            010011 ----- ----- ----- 0110010010 -
> +NAP             010011 ----- ----- ----- 0110110010 -
> +SLEEP           010011 ----- ----- ----- 0111010010 -
> +RVWINKLE        010011 ----- ----- ----- 0111110010 -
> +STOP            010011 ----- ----- ----- 0101110010 -
> +
>  ## Vector Integer Shift Instruction
>  
>  VSLB            000100 ..... ..... ..... 00100000100    @VX
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 2d5157080c..f6f7bb4e6b 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2728,86 +2728,6 @@ static inline void gen_check_tlb_flush(DisasContext *ctx, bool global) { }
>  #endif
>  
>  #if defined(TARGET_PPC64)
> -static void gen_doze(DisasContext *ctx)
> -{
> -#if defined(CONFIG_USER_ONLY)
> -    GEN_PRIV(ctx);
> -#else
> -    TCGv_i32 t;
> -
> -    CHK_HV(ctx);
> -    translator_io_start(&ctx->base);
> -    t = tcg_constant_i32(PPC_PM_DOZE);
> -    gen_helper_pminsn(tcg_env, t);
> -    /* Stop translation, as the CPU is supposed to sleep from now */
> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> -#endif /* defined(CONFIG_USER_ONLY) */
> -}
> -
> -static void gen_nap(DisasContext *ctx)
> -{
> -#if defined(CONFIG_USER_ONLY)
> -    GEN_PRIV(ctx);
> -#else
> -    TCGv_i32 t;
> -
> -    CHK_HV(ctx);
> -    translator_io_start(&ctx->base);
> -    t = tcg_constant_i32(PPC_PM_NAP);
> -    gen_helper_pminsn(tcg_env, t);
> -    /* Stop translation, as the CPU is supposed to sleep from now */
> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> -#endif /* defined(CONFIG_USER_ONLY) */
> -}
> -
> -static void gen_stop(DisasContext *ctx)
> -{
> -#if defined(CONFIG_USER_ONLY)
> -    GEN_PRIV(ctx);
> -#else
> -    TCGv_i32 t;
> -
> -    CHK_HV(ctx);
> -    translator_io_start(&ctx->base);
> -    t = tcg_constant_i32(PPC_PM_STOP);
> -    gen_helper_pminsn(tcg_env, t);
> -    /* Stop translation, as the CPU is supposed to sleep from now */
> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> -#endif /* defined(CONFIG_USER_ONLY) */
> -}
> -
> -static void gen_sleep(DisasContext *ctx)
> -{
> -#if defined(CONFIG_USER_ONLY)
> -    GEN_PRIV(ctx);
> -#else
> -    TCGv_i32 t;
> -
> -    CHK_HV(ctx);
> -    translator_io_start(&ctx->base);
> -    t = tcg_constant_i32(PPC_PM_SLEEP);
> -    gen_helper_pminsn(tcg_env, t);
> -    /* Stop translation, as the CPU is supposed to sleep from now */
> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> -#endif /* defined(CONFIG_USER_ONLY) */
> -}
> -
> -static void gen_rvwinkle(DisasContext *ctx)
> -{
> -#if defined(CONFIG_USER_ONLY)
> -    GEN_PRIV(ctx);
> -#else
> -    TCGv_i32 t;
> -
> -    CHK_HV(ctx);
> -    translator_io_start(&ctx->base);
> -    t = tcg_constant_i32(PPC_PM_RVWINKLE);
> -    gen_helper_pminsn(tcg_env, t);
> -    /* Stop translation, as the CPU is supposed to sleep from now */
> -    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> -#endif /* defined(CONFIG_USER_ONLY) */
> -}
> -
>  static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv mask, TCGv value)
>  {
>      TCGv_ptr tmp = tcg_temp_new_ptr();
> @@ -5117,11 +5037,6 @@ GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(scv, 0x11, 0x00, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(rfscv, 0x13, 0x12, 0x02, 0x03FF8001, PPC_NONE, PPC2_ISA300),
>  #endif
> -GEN_HANDLER_E(stop, 0x13, 0x12, 0x0b, 0x03FFF801, PPC_NONE, PPC2_ISA300),
> -GEN_HANDLER_E(doze, 0x13, 0x12, 0x0c, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
> -GEN_HANDLER_E(nap, 0x13, 0x12, 0x0d, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
> -GEN_HANDLER_E(sleep, 0x13, 0x12, 0x0e, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
> -GEN_HANDLER_E(rvwinkle, 0x13, 0x12, 0x0f, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
>  GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
>  #endif
>  /* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
> diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
> index 8abbb89630..bdbc195294 100644
> --- a/target/ppc/translate/processor-ctrl-impl.c.inc
> +++ b/target/ppc/translate/processor-ctrl-impl.c.inc
> @@ -103,3 +103,104 @@ static bool trans_MSGSYNC(DisasContext *ctx, arg_MSGSYNC *a)
>      /* interpreted as no-op */
>      return true;
>  }
> +
> +static bool do_doze(DisasContext *ctx, arg_DOZE *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +
> +#if defined(CONFIG_USER_ONLY)
> +    gen_priv_opc(ctx);
> +#else
> +    TCGv_i32 t;
> +
> +    REQUIRE_HV(ctx);
> +    translator_io_start(&ctx->base);
> +    t = tcg_constant_i32(PPC_PM_DOZE);
> +    gen_helper_pminsn(tcg_env, t);
> +    /* Stop translation, as the CPU is supposed to sleep from now */
> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> +#endif /* defined(CONFIG_USER_ONLY) */
> +
> +    return true;
> +}
> +TRANS_FLAGS2(PM_ISA206, DOZE, do_doze);
> +
> +static bool do_nap(DisasContext *ctx, arg_NAP *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +
> +#if defined(CONFIG_USER_ONLY)
> +    gen_priv_opc(ctx);
> +#else
> +    TCGv_i32 t;
> +
> +    REQUIRE_HV(ctx);
> +    translator_io_start(&ctx->base);
> +    t = tcg_constant_i32(PPC_PM_NAP);
> +    gen_helper_pminsn(tcg_env, t);
> +    /* Stop translation, as the CPU is supposed to sleep from now */
> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> +#endif /* defined(CONFIG_USER_ONLY) */
> +    return true;
> +}
> +TRANS_FLAGS2(PM_ISA206, NAP, do_nap);
> +
> +static bool do_sleep(DisasContext *ctx, arg_SLEEP *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +
> +#if defined(CONFIG_USER_ONLY)
> +    gen_priv_opc(ctx);
> +#else
> +    TCGv_i32 t;
> +
> +    REQUIRE_HV(ctx);
> +    translator_io_start(&ctx->base);
> +    t = tcg_constant_i32(PPC_PM_SLEEP);
> +    gen_helper_pminsn(tcg_env, t);
> +    /* Stop translation, as the CPU is supposed to sleep from now */
> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> +#endif /* defined(CONFIG_USER_ONLY) */
> +    return true;
> +}
> +TRANS_FLAGS2(PM_ISA206, SLEEP, do_sleep);
> +
> +static bool do_rvwinkle(DisasContext *ctx, arg_RVWINKLE *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +
> +#if defined(CONFIG_USER_ONLY)
> +    gen_priv_opc(ctx);
> +#else
> +    TCGv_i32 t;
> +
> +    REQUIRE_HV(ctx);
> +    translator_io_start(&ctx->base);
> +    t = tcg_constant_i32(PPC_PM_RVWINKLE);
> +    gen_helper_pminsn(tcg_env, t);
> +    /* Stop translation, as the CPU is supposed to sleep from now */
> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> +#endif /* defined(CONFIG_USER_ONLY) */
> +    return true;
> +}
> +TRANS_FLAGS2(PM_ISA206, RVWINKLE, do_rvwinkle);
> +
> +static bool do_stop(DisasContext *ctx, arg_STOP *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +
> +#if defined(CONFIG_USER_ONLY)
> +    gen_priv_opc(ctx);
> +#else
> +    TCGv_i32 t;
> +
> +    REQUIRE_HV(ctx);
> +    translator_io_start(&ctx->base);
> +    t = tcg_constant_i32(PPC_PM_STOP);
> +    gen_helper_pminsn(tcg_env, t);
> +    /* Stop translation, as the CPU is supposed to sleep from now */
> +    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
> +#endif
> +    return true;
> +}
> +TRANS_FLAGS2(ISA300, STOP, do_stop);


