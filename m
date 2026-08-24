Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C9DC5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWXC-0004HZ-SQ; Mon, 24 Aug 2026 11:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWXB-0004FB-Aq; Mon, 24 Aug 2026 11:24:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWX9-00072E-BF; Mon, 24 Aug 2026 11:24:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1sS51846220; Mon, 24 Aug 2026 15:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=QelWI0vQK9zHeMyBPIaOPywWhHg0+l778PwrYLhJK2k=; b=pRs+pBR1Mthp
 bhXIWCHAUidYTgET9lSG+wUZJrT2LAazgCt210U1YENrCdps15Bq46ft1N9P3+BH
 2gODrY2WdQxztsFuR0ejkSiQn2kFXp0xa+r/P0yHBRvRGfDG/b3wIHEIhQWGfUPE
 iopk1I6vcLlym1rkgUM6hgai4dYwvVpCZya7zueiCtN+rGtT+4Ojoz5zFv4TMf3W
 zIh0XuVC4mhYmVfTEHoQG6cT1XVwDOVLRnnOASZc3okIAncb0ZggovEU6aL7v++1
 WnU2wu/XmSjylCC2xGPilM8R6u4gHFZyid58HVxG+NeCLx8gqdi3F0iyhTBnqpDV
 JUI6pTnepg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hjfwc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:24:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OFBHTw005993;
 Mon, 24 Aug 2026 15:24:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag6m28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:24:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OFOIoj19858132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 15:24:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86B5C58051;
 Mon, 24 Aug 2026 15:24:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD1445805A;
 Mon, 24 Aug 2026 15:24:17 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 15:24:17 +0000 (GMT)
Message-ID: <15ce490abc64c1b5ad4e5ca4dea97aafe1a599fb.camel@linux.ibm.com>
Subject: Re: [PATCH 26/29] target/ppc: Move lmw, stmw instructions to
 decodetree
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 10:24:17 -0500
In-Reply-To: <20260820140114.327023-27-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-27-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX/61kUtkDzJzV
 USEBVDWdjHaJqgvBBjxp7uktOPAw5rWgds6Uw55wpkYO+vWwg1xJEDp8iypCoAha7GNOpxjY8QO
 SMNHot6IYZ3BuOxxA1uEbJye0xj6QUM=
X-Proofpoint-GUID: MxO9AM7buEmkZIvuZfmK4PWdJhQKRGN2
X-Proofpoint-ORIG-GUID: zEjtMtyrWrgI0mPmwunTjHLGTpm32n2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX4P5q8NfBtGm1
 r+3khoWGOaELjBJSOuZ3KkN1E1GN+oCkaO1Pj211650ugjIa0n0160CT1++Zx9eiYoDHgLqLPMx
 HFsimugxpiRuP5gBa2A3R/FChv07HNC7embBeIQIc+llG3t76hAdZ7z/ng3ESlPJh84UN0ZRmP3
 dJYxDQUMSZI55hKIstPjhjx8u1/hEq6t9qlrm7ijRZFTrr7V2Yrp5gVYE83HxxMoRHrbjQlQj+d
 cakKtpTPPPTrN2u2GsuO+SZ9kS8mb65B/lcieS6KvkkZJqztUNiv9xQ6abJ1GISe9Gwha+SWd6P
 tHauKX3ztvS5oCDXkCd7s/Djkyu6V8/LlUDCzJkuMrZkPuAwBkCoharLz3mLXlPcaWc6dMtedU9
 +7dNPJnZZbebSAvVJ6aWbs1nPvrAf5l59u9KiDaWRiTfdtkCsOcroBRJbwN0Xc2npvfLjOS/Q3+
 brt5hTpQ//TqRrE0Krg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c6225 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=FzJZKgG2hrrCiWZZ3LgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240126
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
> From: Tanushree Shah <tshah@linux.ibm.com>
> 
> Moving the following instructions to decodetree specification:
>  lmw  : D-form
>  stmw : D-form
> 
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the
> "-d in_asm,op" flag.
> 
> Additionally, validated using small assembly tests confirming the
> the correct register store/load behavior. Also, confirmed the
> register values are same before and after the change.
> 
> Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/helper.h                        |  4 +--
>  target/ppc/insn32.decode                   |  3 ++
>  target/ppc/mem_helper.c                    |  4 +--
>  target/ppc/translate.c                     | 39 ----------------------
>  target/ppc/translate/fixedpoint-impl.c.inc | 32 ++++++++++++++++++
>  5 files changed, 39 insertions(+), 43 deletions(-)
> 
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 8425eceeb3..3659408c46 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -43,8 +43,8 @@ DEF_HELPER_1(check_tlb_flush_local, void, env)
>  DEF_HELPER_1(check_tlb_flush_global, void, env)
>  #endif
>  
> -DEF_HELPER_3(lmw, void, env, tl, i32)
> -DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
> +DEF_HELPER_3(LMW, void, env, tl, i32)
> +DEF_HELPER_FLAGS_3(STMW, TCG_CALL_NO_WG, void, env, tl, i32)
>  DEF_HELPER_4(LSW, void, env, tl, i32, i32)
>  DEF_HELPER_5(LSWX, void, env, tl, i32, i32, i32)
>  DEF_HELPER_FLAGS_4(STSW, TCG_CALL_NO_WG, void, env, tl, i32, i32)
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 8f027e7ff5..b0fa85b93e 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -354,6 +354,7 @@ LVDX            011111 ..... ..... ..... 0000010001 -   @X
>  LSKU            111010 ..... ..... ............. 0 11   @DD
>  LCXU            111010 ..... ..... ............. 1 11   @DD
>  
> +LMW             101110 ..... ..... ................     @D
>  
>  ### Fixed-Point Atomic Load/Store Instructions
>  
> @@ -399,6 +400,8 @@ STBCIX          011111 ..... ..... ..... 1111010101 -   @X
>  STHBRX          011111 ..... ..... ..... 1110010110 -   @X
>  STWBRX          011111 ..... ..... ..... 1010010110 -   @X
>  
> +STMW            101111 ..... ..... ................     @D
> +
>  ### Fixed-Point Compare Instructions
>  
>  CMP             011111 ... - . ..... ..... 0000000000 - @X_bfl
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 582180cf88..7517b3954b 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -73,7 +73,7 @@ static void *probe_contiguous(CPUPPCState *env, target_ulong addr, uint32_t nb,
>      return NULL;
>  }
>  
> -void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
> +void helper_LMW(CPUPPCState *env, target_ulong addr, uint32_t reg)
>  {
>      uintptr_t raddr = GETPC();
>      int mmu_idx = ppc_env_mmu_index(env, false);
> @@ -98,7 +98,7 @@ void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
>      }
>  }
>  
> -void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
> +void helper_STMW(CPUPPCState *env, target_ulong addr, uint32_t reg)
>  {
>      uintptr_t raddr = GETPC();
>      int mmu_idx = ppc_env_mmu_index(env, false);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index d2c51b4d59..9db9d1e070 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2455,43 +2455,6 @@ GEN_LDX(lwbr, ld32ur, 0x16, 0x10, PPC_INTEGER);
>  GEN_LDX_E(ldbr, ld64ur_i64, 0x14, 0x10, PPC_NONE, PPC2_DBRX, CHK_NONE);
>  #endif  /* TARGET_PPC64 */
>  
> -/***                    Integer load and store multiple                    ***/
> -
> -/* lmw */
> -static void gen_lmw(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    TCGv_i32 t1;
> -
> -    if (ctx->le_mode) {
> -        gen_align_no_le(ctx);
> -        return;
> -    }
> -    gen_set_access_type(ctx, ACCESS_INT);
> -    t0 = tcg_temp_new();
> -    t1 = tcg_constant_i32(rD(ctx->opcode));
> -    gen_addr_imm_index(ctx, t0, 0);
> -    gen_helper_lmw(tcg_env, t0, t1);
> -}
> -
> -/* stmw */
> -static void gen_stmw(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    TCGv_i32 t1;
> -
> -    if (ctx->le_mode) {
> -        gen_align_no_le(ctx);
> -        return;
> -    }
> -    gen_set_access_type(ctx, ACCESS_INT);
> -    t0 = tcg_temp_new();
> -    t1 = tcg_constant_i32(rS(ctx->opcode));
> -    gen_addr_imm_index(ctx, t0, 0);
> -    gen_helper_stmw(tcg_env, t0, t1);
> -}
> -
> -
>  #if !defined(CONFIG_USER_ONLY)
>  static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
>  {
> @@ -4708,8 +4671,6 @@ GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>  GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
>  /* handles stfdp, stxsd, stxssp */
>  GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
> -GEN_HANDLER(lmw, 0x2E, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
> -GEN_HANDLER(stmw, 0x2F, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>  /* ISA v3.0 changed the extended opcode from 62 to 30 */
>  GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
>  #if defined(TARGET_PPC64)
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 8fcee7a89d..a75279022c 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -288,6 +288,38 @@ static bool trans_STQCX(DisasContext *ctx, arg_STQCX *a)
>      return true;
>  }
>  
> +/* Load/Store Multiple Word */
> +static bool do_ldst_multiple(DisasContext *ctx, arg_D *a, bool store)
> +{
> +    TCGv ea;
> +    TCGv_i32 reg;
> +
> +    REQUIRE_INSNS_FLAGS(ctx, INTEGER);
> +
> +    /* Little-endian mode is not supported for multiple word operations */
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +
> +    gen_set_access_type(ctx, ACCESS_INT);
> +
> +    reg = tcg_constant_i32(a->rt);
> +    ea = do_ea_calc(ctx, a->ra, tcg_constant_tl(a->si));
> +
> +    /* Call the appropriate helper function */
> +    if (store) {
> +        gen_helper_STMW(tcg_env, ea, reg);
> +    } else {
> +        gen_helper_LMW(tcg_env, ea, reg);
> +    }
> +
> +    return true;
> +}
> +
> +TRANS(LMW, do_ldst_multiple, false)
> +TRANS(STMW, do_ldst_multiple, true)
> +
>  /*
>   * Fixed-Point Compare Instructions
>   */


