Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C5FC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVof-0007ul-AZ; Mon, 24 Aug 2026 10:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVod-0007uK-1m; Mon, 24 Aug 2026 10:38:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyVoa-00068o-AR; Mon, 24 Aug 2026 10:38:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1di22004233; Mon, 24 Aug 2026 14:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=/fJoUrqCcI+3+2b35D+nYjgJpgTzj5SMkp33FMHOGLQ=; b=N8Qrx1AuA7kf
 s3f4EesMHrGluiiN/wjt6qG07sl3zi3OiESh+ChI3W348Hf7fsm3nwu6FqVIbI7R
 uE5bQDVf357mhAwcWHeuXtjjtntxUWgY7lwwaYLjVynKxFlbmHwWXiCgvzL+hxoo
 U6IzpUCi+Xvk/uRcUmbwFUbJE/87IWwvBG24vqygtNLAMHB8Eo2pmxvE7roCsMPb
 RBuN9I0dOVaOYKgSe7CXvLv8ZbQtc/Z7lUBuIyJkkVKFv3fRNZNPG15ETVLwluiU
 JuWjVTq5RBknDDNjVpu8ak5ZzggmLzWj/IeVindRQktrDOC3XSBKU19nY0G6N1tE
 XeBEq2ZxCA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx1u56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQHVk009798;
 Mon, 24 Aug 2026 14:38:17 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxx9vr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEcFxa26739432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:38:15 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E45358060;
 Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0A055803F;
 Mon, 24 Aug 2026 14:38:13 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:38:13 +0000 (GMT)
Message-ID: <d74b597159d96bece829b53641f2939df9c29821.camel@linux.ibm.com>
Subject: Re: [PATCH 12/29] target/ppc: Move GPR atomic load/store
 instructions to decodetree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 09:38:13 -0500
In-Reply-To: <20260820140114.327023-13-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-13-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX4goGkV4siVwY
 C4zthzX15HcFX93K+bgxgxOkfJNXoSJz9kbHSyL39HZjPKpHCqlbQGWF9TKtwVMYZF38ztViYfF
 YyY4JkQKBWSTMkXu0lbL3ax5kfNAuns=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c575a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=W_Luzb46LwHYsPAzrjsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LYpZH4_a5MAUApv03WHqmvlmTPbi2Lpq
X-Proofpoint-GUID: 1E8KhiRHiXv_kvPiNSRUmUvDiBi3Vv2k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX7rBuWEaOMqhn
 uUW3xvfzdBECskdNrMYLkXWR4OJbYtWcMZWY2stCtM5UqkoAKbJo0nf2XOT1FmXhFvc9QhU3nVJ
 2kkKhC1G2l3CmUev+nDcR3D4dYUwwtYG1FHt5OmIGN+uYtfgBsHkAHdsVeTMBzSadDWFrgwkn97
 Kfd3EwUQFHBkVpTtTi5wbOzZOYvrAa/cwklEx2mmT82ECsOnpVaGXExPcJlRasbE6lEPxxB3XGQ
 N17LRA63DqvzSlq9tstt617dXf0b9tv4s3gu4J9gD+bV/pG5UbkqINceoXFd1szrlA5MTWMtmMZ
 9BNEREZbVKAw0OVrjqbVsG7BAW7/QEo3dwjCtigicdnJnGlmUjMHf7ifSduc5On+jzkX+nLjIFC
 gQr7HbqMQ5+oggO0LgE2SjbZLMFvdJ20OqsHSSHJIzjSq3JfazV/W9Pct4hgnRgMbDqCZMEGoM7
 3RiyPXOEx/8TlKvG9rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
> From: Aboorva Devarajan <aboorvad@linux.ibm.com>
> 
> Move below instructions to decodetree specification:
> 
>         lwat, stwat     : X-form (word atomic, ISA 3.0)
>         ldat, stdat     : X-form (doubleword atomic, ISA 3.0)
> 
> The legacy gen_ld_atomic()/gen_st_atomic() functions that read register
> fields and the function code from ctx->opcode are replaced by new
> do_ld_atomic()/do_st_atomic() helpers in fixedpoint-impl.c.inc that
> use the pre-extracted decodetree argument fields (a->rt, a->ra, a->rb)
> directly.  The RB field carries the Function Code (FC) selecting the
> atomic operation.
> 
> gen_fetch_inc_conditional() is similarly moved and refactored to accept
> the destination register number as an explicit parameter instead of
> extracting it from ctx->opcode.
> 
> Checked with '-d in_asm,op'.  The printed TCG ops may differ from the
> pre-refactor log because EA now uses do_ea_calc(ctx, ra, 0), which lowers
> as GPR[ra] + 0 (then narrow in 32-bit mode) instead of mov/ext32u from ra
> alone.
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode                   |   7 +
>  target/ppc/translate.c                     | 212 --------------------
>  target/ppc/translate/fixedpoint-impl.c.inc | 215 +++++++++++++++++++++
>  3 files changed, 222 insertions(+), 212 deletions(-)
> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 8425c70b9d..a1c2f549bd 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -343,6 +343,13 @@ LSKU            111010 ..... ..... ............. 0 11   @DD
>  LCXU            111010 ..... ..... ............. 1 11   @DD
>  
>  
> +### Fixed-Point Atomic Load/Store Instructions
> +
> +LWAT            011111 ..... ..... ..... 1001000110 -   @X
> +STWAT           011111 ..... ..... ..... 1011000110 -   @X
> +LDAT            011111 ..... ..... ..... 1001100110 -   @X
> +STDAT           011111 ..... ..... ..... 1011100110 -   @X
> +
>  ### Fixed-Point Store Instructions
>  
>  STB             100110 ..... ..... ................     @D
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 548a7c0437..179cb69dc5 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2741,212 +2741,6 @@ static void gen_isync(DisasContext *ctx)
>      ctx->base.is_jmp = DISAS_EXIT_UPDATE;
>  }
>  
> -static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
> -                                      TCGv EA, TCGCond cond, int addend)
> -{
> -    TCGv t = tcg_temp_new();
> -    TCGv t2 = tcg_temp_new();
> -    TCGv u = tcg_temp_new();
> -
> -    tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
> -    tcg_gen_addi_tl(t2, EA, memop_size(memop));
> -    tcg_gen_qemu_ld_tl(t2, t2, ctx->mem_idx, memop);
> -    tcg_gen_addi_tl(u, t, addend);
> -
> -    /* E.g. for fetch and increment bounded... */
> -    /* mem(EA,s) = (t != t2 ? u = t + 1 : t) */
> -    tcg_gen_movcond_tl(cond, u, t, t2, u, t);
> -    tcg_gen_qemu_st_tl(u, EA, ctx->mem_idx, memop);
> -
> -    /* RT = (t != t2 ? t : u = 1<<(s*8-1)) */
> -    tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t,
> -                       tcg_constant_tl(1 << (memop_size(memop) * 8 - 1)));
> -}
> -
> -static void gen_ld_atomic(DisasContext *ctx, MemOp memop)
> -{
> -    uint32_t gpr_FC = FC(ctx->opcode);
> -    TCGv EA = tcg_temp_new();
> -    int rt = rD(ctx->opcode);
> -    bool need_serial;
> -    TCGv src, dst;
> -
> -    gen_addr_register(ctx, EA);
> -    dst = cpu_gpr[rt];
> -    src = cpu_gpr[(rt + 1) & 31];
> -
> -    need_serial = false;
> -    memop |= MO_ALIGN;
> -    switch (gpr_FC) {
> -    case 0: /* Fetch and add */
> -        tcg_gen_atomic_fetch_add_tl(dst, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 1: /* Fetch and xor */
> -        tcg_gen_atomic_fetch_xor_tl(dst, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 2: /* Fetch and or */
> -        tcg_gen_atomic_fetch_or_tl(dst, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 3: /* Fetch and 'and' */
> -        tcg_gen_atomic_fetch_and_tl(dst, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 4:  /* Fetch and max unsigned */
> -        tcg_gen_atomic_fetch_umax_tl(dst, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 5:  /* Fetch and max signed */
> -        tcg_gen_atomic_fetch_smax_tl(dst, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 6:  /* Fetch and min unsigned */
> -        tcg_gen_atomic_fetch_umin_tl(dst, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 7:  /* Fetch and min signed */
> -        tcg_gen_atomic_fetch_smin_tl(dst, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 8: /* Swap */
> -        tcg_gen_atomic_xchg_tl(dst, EA, src, ctx->mem_idx, memop);
> -        break;
> -
> -    case 16: /* Compare and swap not equal */
> -        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> -            need_serial = true;
> -        } else {
> -            TCGv t0 = tcg_temp_new();
> -            TCGv t1 = tcg_temp_new();
> -
> -            tcg_gen_qemu_ld_tl(t0, EA, ctx->mem_idx, memop);
> -            if ((memop & MO_SIZE) == MO_64 || TARGET_LONG_BITS == 32) {
> -                tcg_gen_mov_tl(t1, src);
> -            } else {
> -                tcg_gen_ext32u_tl(t1, src);
> -            }
> -            tcg_gen_movcond_tl(TCG_COND_NE, t1, t0, t1,
> -                               cpu_gpr[(rt + 2) & 31], t0);
> -            tcg_gen_qemu_st_tl(t1, EA, ctx->mem_idx, memop);
> -            tcg_gen_mov_tl(dst, t0);
> -        }
> -        break;
> -
> -    case 24: /* Fetch and increment bounded */
> -        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> -            need_serial = true;
> -        } else {
> -            gen_fetch_inc_conditional(ctx, memop, EA, TCG_COND_NE, 1);
> -        }
> -        break;
> -    case 25: /* Fetch and increment equal */
> -        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> -            need_serial = true;
> -        } else {
> -            gen_fetch_inc_conditional(ctx, memop, EA, TCG_COND_EQ, 1);
> -        }
> -        break;
> -    case 28: /* Fetch and decrement bounded */
> -        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> -            need_serial = true;
> -        } else {
> -            gen_fetch_inc_conditional(ctx, memop, EA, TCG_COND_NE, -1);
> -        }
> -        break;
> -
> -    default:
> -        /* invoke data storage error handler */
> -        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);
> -    }
> -
> -    if (need_serial) {
> -        /* Restart with exclusive lock.  */
> -        gen_helper_exit_atomic(tcg_env);
> -        ctx->base.is_jmp = DISAS_NORETURN;
> -    }
> -}
> -
> -static void gen_lwat(DisasContext *ctx)
> -{
> -    gen_ld_atomic(ctx, DEF_MEMOP(MO_UL));
> -}
> -
> -#ifdef TARGET_PPC64
> -static void gen_ldat(DisasContext *ctx)
> -{
> -    gen_ld_atomic(ctx, DEF_MEMOP(MO_UQ));
> -}
> -#endif
> -
> -static void gen_st_atomic(DisasContext *ctx, MemOp memop)
> -{
> -    uint32_t gpr_FC = FC(ctx->opcode);
> -    TCGv EA = tcg_temp_new();
> -    TCGv src, discard;
> -
> -    gen_addr_register(ctx, EA);
> -    src = cpu_gpr[rD(ctx->opcode)];
> -    discard = tcg_temp_new();
> -
> -    memop |= MO_ALIGN;
> -    switch (gpr_FC) {
> -    case 0: /* add and Store */
> -        tcg_gen_atomic_add_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 1: /* xor and Store */
> -        tcg_gen_atomic_xor_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 2: /* Or and Store */
> -        tcg_gen_atomic_or_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 3: /* 'and' and Store */
> -        tcg_gen_atomic_and_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 4:  /* Store max unsigned */
> -        tcg_gen_atomic_umax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 5:  /* Store max signed */
> -        tcg_gen_atomic_smax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 6:  /* Store min unsigned */
> -        tcg_gen_atomic_umin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 7:  /* Store min signed */
> -        tcg_gen_atomic_smin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> -        break;
> -    case 24: /* Store twin  */
> -        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> -            /* Restart with exclusive lock.  */
> -            gen_helper_exit_atomic(tcg_env);
> -            ctx->base.is_jmp = DISAS_NORETURN;
> -        } else {
> -            TCGv t = tcg_temp_new();
> -            TCGv t2 = tcg_temp_new();
> -            TCGv s = tcg_temp_new();
> -            TCGv s2 = tcg_temp_new();
> -            TCGv ea_plus_s = tcg_temp_new();
> -
> -            tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
> -            tcg_gen_addi_tl(ea_plus_s, EA, memop_size(memop));
> -            tcg_gen_qemu_ld_tl(t2, ea_plus_s, ctx->mem_idx, memop);
> -            tcg_gen_movcond_tl(TCG_COND_EQ, s, t, t2, src, t);
> -            tcg_gen_movcond_tl(TCG_COND_EQ, s2, t, t2, src, t2);
> -            tcg_gen_qemu_st_tl(s, EA, ctx->mem_idx, memop);
> -            tcg_gen_qemu_st_tl(s2, ea_plus_s, ctx->mem_idx, memop);
> -        }
> -        break;
> -    default:
> -        /* invoke data storage error handler */
> -        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);
> -    }
> -}
> -
> -static void gen_stwat(DisasContext *ctx)
> -{
> -    gen_st_atomic(ctx, DEF_MEMOP(MO_UL));
> -}
> -
> -#ifdef TARGET_PPC64
> -static void gen_stdat(DisasContext *ctx)
> -{
> -    gen_st_atomic(ctx, DEF_MEMOP(MO_UQ));
> -}
> -#endif
> -
>  /* wait */
>  static void gen_wait(DisasContext *ctx)
>  {
> @@ -5584,12 +5378,6 @@ GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
>  GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
> -GEN_HANDLER_E(lwat, 0x1F, 0x06, 0x12, 0x00000001, PPC_NONE, PPC2_ISA300),
> -GEN_HANDLER_E(stwat, 0x1F, 0x06, 0x16, 0x00000001, PPC_NONE, PPC2_ISA300),
> -#if defined(TARGET_PPC64)
> -GEN_HANDLER_E(ldat, 0x1F, 0x06, 0x13, 0x00000001, PPC_NONE, PPC2_ISA300),
> -GEN_HANDLER_E(stdat, 0x1F, 0x06, 0x17, 0x00000001, PPC_NONE, PPC2_ISA300),
> -#endif
>  /* ISA v3.0 changed the extended opcode from 62 to 30 */
>  GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
>  GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 25a60d3d3a..4d35133adc 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -1646,3 +1646,218 @@ static bool trans_SRAWI(DisasContext *ctx, arg_SRAWI *a)
>      }
>      return true;
>  }
> +
> +static void do_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
> +                                     TCGv EA, int rt,
> +                                     TCGCond cond, int addend)
> +{
> +    TCGv t = tcg_temp_new();
> +    TCGv t2 = tcg_temp_new();
> +    TCGv u = tcg_temp_new();
> +
> +    tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
> +    tcg_gen_addi_tl(t2, EA, memop_size(memop));
> +    tcg_gen_qemu_ld_tl(t2, t2, ctx->mem_idx, memop);
> +    tcg_gen_addi_tl(u, t, addend);
> +
> +    /* mem(EA,s) = (t cond t2 ? u = t + addend : t) */
> +    tcg_gen_movcond_tl(cond, u, t, t2, u, t);
> +    tcg_gen_qemu_st_tl(u, EA, ctx->mem_idx, memop);
> +
> +    /* RT = (t cond t2 ? t : 1<<(s*8-1)) */
> +    tcg_gen_movcond_tl(cond, cpu_gpr[rt], t, t2, t,
> +                       tcg_constant_tl(1 << (memop_size(memop) * 8 - 1)));
> +}
> +
> +/*
> + * Fixed-Point Atomic Load/Store Instructions
> + *
> + * In the X-form encoding the RB field carries the Function Code (FC)
> + * that selects the atomic operation.  EA is computed from RA alone.
> + */
> +static bool do_ld_atomic(DisasContext *ctx, arg_X *a, MemOp memop)
> +{
> +    TCGv EA, dst, src;
> +    bool need_serial;
> +
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
> +
> +    EA = do_ea_calc(ctx, a->ra, tcg_constant_tl(0));
> +    dst = cpu_gpr[a->rt];
> +    src = cpu_gpr[(a->rt + 1) & 31];
> +
> +    need_serial = false;
> +    memop |= MO_ALIGN;
> +    switch (a->rb) {
> +    case 0: /* Fetch and add */
> +        tcg_gen_atomic_fetch_add_tl(dst, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 1: /* Fetch and xor */
> +        tcg_gen_atomic_fetch_xor_tl(dst, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 2: /* Fetch and or */
> +        tcg_gen_atomic_fetch_or_tl(dst, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 3: /* Fetch and 'and' */
> +        tcg_gen_atomic_fetch_and_tl(dst, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 4: /* Fetch and max unsigned */
> +        tcg_gen_atomic_fetch_umax_tl(dst, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 5: /* Fetch and max signed */
> +        tcg_gen_atomic_fetch_smax_tl(dst, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 6: /* Fetch and min unsigned */
> +        tcg_gen_atomic_fetch_umin_tl(dst, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 7: /* Fetch and min signed */
> +        tcg_gen_atomic_fetch_smin_tl(dst, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 8: /* Swap */
> +        tcg_gen_atomic_xchg_tl(dst, EA, src, ctx->mem_idx, memop);
> +        break;
> +
> +    case 16: /* Compare and swap not equal */
> +        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> +            need_serial = true;
> +        } else {
> +            TCGv t0 = tcg_temp_new();
> +            TCGv t1 = tcg_temp_new();
> +
> +            tcg_gen_qemu_ld_tl(t0, EA, ctx->mem_idx, memop);
> +            if ((memop & MO_SIZE) == MO_64 || TARGET_LONG_BITS == 32) {
> +                tcg_gen_mov_tl(t1, src);
> +            } else {
> +                tcg_gen_ext32u_tl(t1, src);
> +            }
> +            tcg_gen_movcond_tl(TCG_COND_NE, t1, t0, t1,
> +                               cpu_gpr[(a->rt + 2) & 31], t0);
> +            tcg_gen_qemu_st_tl(t1, EA, ctx->mem_idx, memop);
> +            tcg_gen_mov_tl(dst, t0);
> +        }
> +        break;
> +
> +    case 24: /* Fetch and increment bounded */
> +        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> +            need_serial = true;
> +        } else {
> +            do_fetch_inc_conditional(ctx, memop, EA, a->rt, TCG_COND_NE, 1);
> +        }
> +        break;
> +    case 25: /* Fetch and increment equal */
> +        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> +            need_serial = true;
> +        } else {
> +            do_fetch_inc_conditional(ctx, memop, EA, a->rt, TCG_COND_EQ, 1);
> +        }
> +        break;
> +    case 28: /* Fetch and decrement bounded */
> +        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> +            need_serial = true;
> +        } else {
> +            do_fetch_inc_conditional(ctx, memop, EA, a->rt, TCG_COND_NE, -1);
> +        }
> +        break;
> +
> +    default:
> +        /* invoke data storage error handler */
> +        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);
> +        return true;
> +    }
> +
> +    if (need_serial) {
> +        /* Restart with exclusive lock.  */
> +        gen_helper_exit_atomic(tcg_env);
> +        ctx->base.is_jmp = DISAS_NORETURN;
> +    }
> +    return true;
> +}
> +
> +static bool do_st_atomic(DisasContext *ctx, arg_X *a, MemOp memop)
> +{
> +    TCGv EA, src, discard;
> +
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
> +
> +    EA = do_ea_calc(ctx, a->ra, tcg_constant_tl(0));
> +    src = cpu_gpr[a->rt];
> +    discard = tcg_temp_new();
> +
> +    memop |= MO_ALIGN;
> +    switch (a->rb) {
> +    case 0: /* add and Store */
> +        tcg_gen_atomic_add_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 1: /* xor and Store */
> +        tcg_gen_atomic_xor_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 2: /* Or and Store */
> +        tcg_gen_atomic_or_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 3: /* 'and' and Store */
> +        tcg_gen_atomic_and_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 4: /* Store max unsigned */
> +        tcg_gen_atomic_umax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 5: /* Store max signed */
> +        tcg_gen_atomic_smax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 6: /* Store min unsigned */
> +        tcg_gen_atomic_umin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 7: /* Store min signed */
> +        tcg_gen_atomic_smin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
> +        break;
> +    case 24: /* Store twin */
> +        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> +            /* Restart with exclusive lock.  */
> +            gen_helper_exit_atomic(tcg_env);
> +            ctx->base.is_jmp = DISAS_NORETURN;
> +        } else {
> +            TCGv t = tcg_temp_new();
> +            TCGv t2 = tcg_temp_new();
> +            TCGv s = tcg_temp_new();
> +            TCGv s2 = tcg_temp_new();
> +            TCGv ea_plus_s = tcg_temp_new();
> +
> +            tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
> +            tcg_gen_addi_tl(ea_plus_s, EA, memop_size(memop));
> +            tcg_gen_qemu_ld_tl(t2, ea_plus_s, ctx->mem_idx, memop);
> +            tcg_gen_movcond_tl(TCG_COND_EQ, s, t, t2, src, t);
> +            tcg_gen_movcond_tl(TCG_COND_EQ, s2, t, t2, src, t2);
> +            tcg_gen_qemu_st_tl(s, EA, ctx->mem_idx, memop);
> +            tcg_gen_qemu_st_tl(s2, ea_plus_s, ctx->mem_idx, memop);
> +        }
> +        break;
> +    default:
> +        /* invoke data storage error handler */
> +        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);
> +    }
> +    return true;
> +}
> +
> +TRANS(LWAT, do_ld_atomic, DEF_MEMOP(MO_UL))
> +TRANS(STWAT, do_st_atomic, DEF_MEMOP(MO_UL))
> +
> +static bool trans_LDAT(DisasContext *ctx, arg_LDAT *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +#if defined(TARGET_PPC64)
> +    return do_ld_atomic(ctx, a, DEF_MEMOP(MO_UQ));
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
> +static bool trans_STDAT(DisasContext *ctx, arg_STDAT *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +#if defined(TARGET_PPC64)
> +    return do_st_atomic(ctx, a, DEF_MEMOP(MO_UQ));
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}


