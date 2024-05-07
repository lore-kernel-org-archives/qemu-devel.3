Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECF2C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EWS-0001T2-Ck; Tue, 07 May 2024 02:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1s4EWP-0001Ro-AN; Tue, 07 May 2024 02:41:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1s4EWI-000328-LY; Tue, 07 May 2024 02:41:50 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4476Mobb010008; Tue, 7 May 2024 06:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xw9cjdoifpy59lbZL1mPZTGfemtplTtKZDCQboN9OuQ=;
 b=exElJodW4BsbARfS4bVlzT/a4SFvvNGt0QMSEcYu29JZAGwBPCI0eJXc8TE6tHJxA3F2
 Wg0wuXSuBC4eX929ti8PeaVX1pnnUQZw5c9+ypzeIVYIa/2JLdX6tidlUw2zBeWa/juL
 yKaXItRSptsEeEbLrOfQbASsaxmha2ZK3n7hMl/rRcOYEvQ5SJITPN/foXwPHn/1yM/u
 /nCWPvk1PigEhFcA8N/x/K/PR/EFGOtOkpFPAoNFEOat67OhdUbpmkXDsQYO19VQM1+u
 ygUb9cb7p4UyEd2qau6piqRfLYGZ1aaMAmhNXg/loWmgygG7QotLClsjXjGQbh0Q7bS6 kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyeyn8224-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 06:41:42 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4476fgc8009405;
 Tue, 7 May 2024 06:41:42 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyeyn8222-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 06:41:42 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44741VSb013877; Tue, 7 May 2024 06:41:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xx222v4j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 06:41:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4476fcbd52953516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 May 2024 06:41:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F07B22004B;
 Tue,  7 May 2024 06:41:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5B2520040;
 Tue,  7 May 2024 06:41:36 +0000 (GMT)
Received: from [9.199.192.140] (unknown [9.199.192.140])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 May 2024 06:41:36 +0000 (GMT)
Message-ID: <fba61833-faeb-4c3e-bab2-87d1a99e7644@linux.vnet.ibm.com>
Date: Tue, 7 May 2024 12:11:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/ppc: Move sync instructions to decodetree
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20240501130435.941189-1-npiggin@gmail.com>
 <20240501130435.941189-2-npiggin@gmail.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <20240501130435.941189-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0bDVRuTcfKxhENIo4MLhyVUineDVt4b5
X-Proofpoint-GUID: KesI6-6i2GPyd-ND_mMbsqw8UBGQyizA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070045
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



On 5/1/24 18:34, Nicholas Piggin wrote:
> This tries to faithfully reproduce the odd BookE logic.
>
> It does change the handling of non-zero reserved bits outside the
> defined fields from being illegal to being ignored, which the
> architecture specifies ot help with backward compatibility of new
> fields. The existing behaviour causes illegal instruction exceptions
> when using new POWER10 sync variants that add new fields, after this
> the instructions are accepted and are implemented as supersets of
> the new behaviour, as intended.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/insn32.decode             |   7 ++
>   target/ppc/translate.c               | 102 +-------------------
>   target/ppc/translate/misc-impl.c.inc | 135 +++++++++++++++++++++++++++
>   3 files changed, 144 insertions(+), 100 deletions(-)
>   create mode 100644 target/ppc/translate/misc-impl.c.inc
>
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index eada59f59f..6b89804b15 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -998,3 +998,10 @@ MSGSND          011111 ----- ----- ..... 0011001110 -   @X_rb
>   MSGCLRP         011111 ----- ----- ..... 0010101110 -   @X_rb
>   MSGSNDP         011111 ----- ----- ..... 0010001110 -   @X_rb
>   MSGSYNC         011111 ----- ----- ----- 1101110110 -
> +
> +# Memory Barrier Instructions
> +
> +&X_sync         l
> +@X_sync         ...... ... l:2 ..... ..... .......... .           &X_sync
> +SYNC            011111 --- ..  ----- ----- 1001010110 -           @X_sync
> +EIEIO           011111 ----- ----- ----- 1101010110 -
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 93ffec787c..bb2cabae10 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3423,59 +3423,6 @@ static void gen_stswx(DisasContext *ctx)
>       gen_helper_stsw(tcg_env, t0, t1, t2);
>   }
>   
> -/***                        Memory synchronisation                         ***/
> -/* eieio */
> -static void gen_eieio(DisasContext *ctx)
> -{
> -    TCGBar bar = TCG_MO_ALL;
> -
> -    /*
> -     * eieio has complex semanitcs. It provides memory ordering between
> -     * operations in the set:
> -     * - loads from CI memory.
> -     * - stores to CI memory.
> -     * - stores to WT memory.
> -     *
> -     * It separately also orders memory for operations in the set:
> -     * - stores to cacheble memory.
> -     *
> -     * It also serializes instructions:
> -     * - dcbt and dcbst.
> -     *
> -     * It separately serializes:
> -     * - tlbie and tlbsync.
> -     *
> -     * And separately serializes:
> -     * - slbieg, slbiag, and slbsync.
> -     *
> -     * The end result is that CI memory ordering requires TCG_MO_ALL
> -     * and it is not possible to special-case more relaxed ordering for
> -     * cacheable accesses. TCG_BAR_SC is required to provide this
> -     * serialization.
> -     */
> -
> -    /*
> -     * POWER9 has a eieio instruction variant using bit 6 as a hint to
> -     * tell the CPU it is a store-forwarding barrier.
> -     */
> -    if (ctx->opcode & 0x2000000) {
> -        /*
> -         * ISA says that "Reserved fields in instructions are ignored
> -         * by the processor". So ignore the bit 6 on non-POWER9 CPU but
> -         * as this is not an instruction software should be using,
> -         * complain to the user.
> -         */
> -        if (!(ctx->insns_flags2 & PPC2_ISA300)) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "invalid eieio using bit 6 at @"
> -                          TARGET_FMT_lx "\n", ctx->cia);
> -        } else {
> -            bar = TCG_MO_ST_LD;
> -        }
> -    }
> -
> -    tcg_gen_mb(bar | TCG_BAR_SC);
> -}
> -
>   #if !defined(CONFIG_USER_ONLY)
>   static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
>   {
> @@ -3877,31 +3824,6 @@ static void gen_stqcx_(DisasContext *ctx)
>   }
>   #endif /* defined(TARGET_PPC64) */
>   
> -/* sync */
> -static void gen_sync(DisasContext *ctx)
> -{
> -    TCGBar bar = TCG_MO_ALL;
> -    uint32_t l = (ctx->opcode >> 21) & 3;
> -
> -    if ((l == 1) && (ctx->insns_flags2 & PPC2_MEM_LWSYNC)) {
> -        bar = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST;
> -    }
> -
> -    /*
> -     * We may need to check for a pending TLB flush.
> -     *
> -     * We do this on ptesync (l == 2) on ppc64 and any sync pn ppc32.
> -     *
> -     * Additionally, this can only happen in kernel mode however so
> -     * check MSR_PR as well.
> -     */
> -    if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
> -        gen_check_tlb_flush(ctx, true);
> -    }
> -
> -    tcg_gen_mb(bar | TCG_BAR_SC);
> -}
> -
>   /* wait */
>   static void gen_wait(DisasContext *ctx)
>   {
> @@ -6010,23 +5932,6 @@ static void gen_dlmzb(DisasContext *ctx)
>                        cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)], t0);
>   }
>   
> -/* mbar replaces eieio on 440 */
> -static void gen_mbar(DisasContext *ctx)
> -{
> -    /* interpreted as no-op */
> -}
> -
> -/* msync replaces sync on 440 */
> -static void gen_msync_4xx(DisasContext *ctx)
> -{
> -    /* Only e500 seems to treat reserved bits as invalid */
> -    if ((ctx->insns_flags2 & PPC2_BOOKE206) &&
> -        (ctx->opcode & 0x03FFF801)) {
> -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> -    }
> -    /* otherwise interpreted as no-op */
> -}
> -
>   /* icbt */
>   static void gen_icbt_440(DisasContext *ctx)
>   {
> @@ -6364,6 +6269,8 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
>   
>   #include "translate/storage-ctrl-impl.c.inc"
>   
> +#include "translate/misc-impl.c.inc"
> +
>   /* Handles lfdp */
>   static void gen_dform39(DisasContext *ctx)
>   {
> @@ -6492,7 +6399,6 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
>   GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
>   GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>   GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
> -GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
>   GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
>   GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
>   GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
> @@ -6510,7 +6416,6 @@ GEN_HANDLER_E(lqarx, 0x1F, 0x14, 0x08, 0, PPC_NONE, PPC2_LSQ_ISA207),
>   GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, PPC_64B),
>   GEN_HANDLER_E(stqcx_, 0x1F, 0x16, 0x05, 0, PPC_NONE, PPC2_LSQ_ISA207),
>   #endif
> -GEN_HANDLER(sync, 0x1F, 0x16, 0x12, 0x039FF801, PPC_MEM_SYNC),
>   /* ISA v3.0 changed the extended opcode from 62 to 30 */
>   GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
>   GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
> @@ -6633,9 +6538,6 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
>   GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
>   GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
>   GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
> -GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001FF801,
> -              PPC_BOOKE, PPC2_BOOKE206),
> -GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x039FF801, PPC_BOOKE),
>   GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
>                  PPC_BOOKE, PPC2_BOOKE206),
>   GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
> diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
> new file mode 100644
> index 0000000000..f58bf8b848
> --- /dev/null
> +++ b/target/ppc/translate/misc-impl.c.inc
> @@ -0,0 +1,135 @@
> +/*
> + * Power ISA decode for misc instructions
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * Memory Barrier Instructions
> + */
> +
> +static bool trans_SYNC(DisasContext *ctx, arg_X_sync *a)
> +{
> +    TCGBar bar = TCG_MO_ALL;
> +    uint32_t l = a->l;
> +
> +    /*
> +     * BookE uses the msync mnemonic. This means hwsync, except in the
> +     * 440, where it an execution serialisation point that requires all
> +     * previous storage accesses to have been performed to memory (which
> +     * doesn't matter for TCG).
> +     */
> +    if (!(ctx->insns_flags & PPC_MEM_SYNC)) {
> +        if (ctx->insns_flags & PPC_BOOKE) {
> +            /* msync replaces sync on 440, interpreted as nop */
> +            /* XXX: this also catches e200 */
> +            return true;
> +        }
> +
> +        return false;
> +    }
> +
> +    /* e500 family seems to treat reserved bits as invalid, this enforces l=0 */
> +    if ((ctx->insns_flags2 & PPC2_BOOKE206) && (ctx->opcode & 0x03FFF801)) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +    }
> +
> +    if ((l == 1) && (ctx->insns_flags2 & PPC2_MEM_LWSYNC)) {
> +        bar = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST;
> +    }
> +
> +    /*
> +     * We may need to check for a pending TLB flush.
> +     *
> +     * We do this on ptesync (l == 2) on ppc64 and any sync on ppc32.
> +     *
> +     * Additionally, this can only happen in kernel mode however so
> +     * check MSR_PR as well.
> +     */
> +    if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
> +        gen_check_tlb_flush(ctx, true);
> +    }
> +
> +    tcg_gen_mb(bar | TCG_BAR_SC);
> +
> +    return true;
> +}
> +
> +static bool trans_EIEIO(DisasContext *ctx, arg_EIEIO *a)
> +{
> +    TCGBar bar = TCG_MO_ALL;
> +
> +    /*
> +     * BookE uses the mbar instruction instead of eieio, which is basically
> +     * full hwsync memory barrier, but is not execution synchronising. For
> +     * the purpose of TCG the distinction is not relevant.
> +     */
> +    if (!(ctx->insns_flags & PPC_MEM_EIEIO)) {
> +        if ((ctx->insns_flags & PPC_BOOKE) ||
> +            (ctx->insns_flags2 & PPC2_BOOKE206)) {
> +            return true;
> +        }
> +        return false;
> +    }
> +
> +    /*
> +     * eieio has complex semanitcs. It provides memory ordering between
> +     * operations in the set:
> +     * - loads from CI memory.
> +     * - stores to CI memory.
> +     * - stores to WT memory.
> +     *
> +     * It separately also orders memory for operations in the set:
> +     * - stores to cacheble memory.
> +     *
> +     * It also serializes instructions:
> +     * - dcbt and dcbst.
> +     *
> +     * It separately serializes:
> +     * - tlbie and tlbsync.
> +     *
> +     * And separately serializes:
> +     * - slbieg, slbiag, and slbsync.
> +     *
> +     * The end result is that CI memory ordering requires TCG_MO_ALL
> +     * and it is not possible to special-case more relaxed ordering for
> +     * cacheable accesses. TCG_BAR_SC is required to provide this
> +     * serialization.
> +     */
> +
> +    /*
> +     * POWER9 has a eieio instruction variant using bit 6 as a hint to
> +     * tell the CPU it is a store-forwarding barrier.
> +     */
> +    if (ctx->opcode & 0x2000000) {
> +        /*
> +         * ISA says that "Reserved fields in instructions are ignored
> +         * by the processor". So ignore the bit 6 on non-POWER9 CPU but
> +         * as this is not an instruction software should be using,
> +         * complain to the user.
> +         */
> +        if (!(ctx->insns_flags2 & PPC2_ISA300)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "invalid eieio using bit 6 at @"
> +                          TARGET_FMT_lx "\n", ctx->cia);
> +        } else {
> +            bar = TCG_MO_ST_LD;
> +        }
> +    }
> +
> +    tcg_gen_mb(bar | TCG_BAR_SC);
> +
> +    return true;
> +}


