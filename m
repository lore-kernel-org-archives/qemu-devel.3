Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E53DC61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaD1-0002Q3-Tr; Thu, 27 Aug 2026 09:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaD0-0002Kz-NH; Thu, 27 Aug 2026 09:31:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaCx-0001dC-VG; Thu, 27 Aug 2026 09:31:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVeKh1871760; Thu, 27 Aug 2026 13:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HiaDqBdsBmZYki+ai
 bzwCWLK1k37YsR9z7dIrWQUKek=; b=l8fiiR1hCWTjRdV8sbO/eV1Y5xQScUh56
 936+r3+sdCfol49R8zEsjn7O5v9L4i4D6EL5MyWPCoUvNY9jZKGJHAlAOKWxil5o
 wq5keLAj/UQO+88+LEB+2s87qS0WWvfnk8P3elZAK78ybplaeb3y/l2ZYZnzdePG
 dgMtQoSri+4tmfZvdz8H5B563EMY6+i2NplUMktOmhHe5sBHnq13xwRPAV/xfA6a
 1FZ0inbyLUP0wPHxBVExKvQ6yPrnPgf396sgmqblyflNnyKbNcPTQ+poIhl2dMmY
 kFfd3BszmCVshZ/JQIkN9LJkDE0UEmQ++DBtBnGAYf6Z3c3YZB54w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ewgws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:31:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQNse027530;
 Thu, 27 Aug 2026 13:31:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyg1bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:31:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDVnsL47579556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:31:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1FA02004B;
 Thu, 27 Aug 2026 13:31:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E24B420040;
 Thu, 27 Aug 2026 13:31:42 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:31:42 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 12/37] target/ppc: Move GPR atomic load/store instructions
 to decodetree
Date: Thu, 27 Aug 2026 18:59:27 +0530
Message-ID: <20260827133010.278889-13-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a903c4a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=7_UP9IVFSEwWPGvGImoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX3wrwlPTaGcpx
 9sR9knehM4hBbVLX7lidPn4mbj6u4hjqbjUjJpFKzInYgbPxksxMBnG4z+F7iFqe/j1YwIvc4hH
 FYk96WgxoGDkz3rwGcl7/5lqlPg8p0o=
X-Proofpoint-GUID: dya8h7YRPrw1DCSyEHWde3UegC71sg7p
X-Proofpoint-ORIG-GUID: WdH5EIsWSpY10cyz63gE2Uzp0pSvEbvQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX4celQVxpW8EA
 yvBCzAE4lYqXmCFTyEnDaTjmW0EBaRpKydmFT4Nm2iJnAc2ExhDfLUgZTBew7zWGYZ83NjIqMTM
 XceQj624Twoff7YTqDVb92Kha7aO/lhUfEeAz9YXr+QQZHZw32nnt20wNB5iuaOVhyaKo09dqnK
 scIQufgWu75htMhYrbxEQku2zOn8So1cLecLPryDVjT1hUNbNcf1dfRDYcnP6BV311T9+ZY3BWc
 WP+XYrbmME8tAype2M4jjNpjBBHCGto7PI0e+dMkdu2LwvzKcwBNEPD9Ux7aOQH2L8bL75eQkD9
 KkY6JR9a+nkBigGmhPuInQ7Uua/6E7v77upAuDXybLeXZKL4QUDWEqM3ghQROe33nc52KqvAKA7
 c51Lriqbl1XJoeSmMRtdCSAg4tukUXeS95AZ6sAwQISLASdUJxbwE8rHL4M7rNOfpZm8KqjbyxM
 n7UuQWPQlKn+XQJwETw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270113
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

From: Aboorva Devarajan <aboorvad@linux.ibm.com>

Move below instructions to decodetree specification:

        lwat, stwat     : X-form (word atomic, ISA 3.0)
        ldat, stdat     : X-form (doubleword atomic, ISA 3.0)

The legacy gen_ld_atomic()/gen_st_atomic() functions that read register
fields and the function code from ctx->opcode are replaced by new
do_ld_atomic()/do_st_atomic() helpers in fixedpoint-impl.c.inc that
use the pre-extracted decodetree argument fields (a->rt, a->ra, a->rb)
directly.  The RB field carries the Function Code (FC) selecting the
atomic operation.

gen_fetch_inc_conditional() is similarly moved and refactored to accept
the destination register number as an explicit parameter instead of
extracting it from ctx->opcode.

Checked with '-d in_asm,op'.  The printed TCG ops may differ from the
pre-refactor log because EA now uses do_ea_calc(ctx, ra, 0), which lowers
as GPR[ra] + 0 (then narrow in 32-bit mode) instead of mov/ext32u from ra
alone.

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                   |   7 +
 target/ppc/translate.c                     | 212 --------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 214 +++++++++++++++++++++
 3 files changed, 221 insertions(+), 212 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 37f508a5c2..e8326a9d0b 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -343,6 +343,13 @@ LSKU            111010 ..... ..... ............. 0 11   @DD
 LCXU            111010 ..... ..... ............. 1 11   @DD
 
 
+### Fixed-Point Atomic Load/Store Instructions
+
+LWAT            011111 ..... ..... ..... 1001000110 -   @X
+STWAT           011111 ..... ..... ..... 1011000110 -   @X
+LDAT            011111 ..... ..... ..... 1001100110 -   @X
+STDAT           011111 ..... ..... ..... 1011100110 -   @X
+
 ### Fixed-Point Store Instructions
 
 STB             100110 ..... ..... ................     @D
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 749ae56cdf..c44cffb5e8 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2741,212 +2741,6 @@ static void gen_isync(DisasContext *ctx)
     ctx->base.is_jmp = DISAS_EXIT_UPDATE;
 }
 
-static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
-                                      TCGv EA, TCGCond cond, int addend)
-{
-    TCGv t = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv u = tcg_temp_new();
-
-    tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
-    tcg_gen_addi_tl(t2, EA, memop_size(memop));
-    tcg_gen_qemu_ld_tl(t2, t2, ctx->mem_idx, memop);
-    tcg_gen_addi_tl(u, t, addend);
-
-    /* E.g. for fetch and increment bounded... */
-    /* mem(EA,s) = (t != t2 ? u = t + 1 : t) */
-    tcg_gen_movcond_tl(cond, u, t, t2, u, t);
-    tcg_gen_qemu_st_tl(u, EA, ctx->mem_idx, memop);
-
-    /* RT = (t != t2 ? t : u = 1<<(s*8-1)) */
-    tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t,
-                       tcg_constant_tl(1 << (memop_size(memop) * 8 - 1)));
-}
-
-static void gen_ld_atomic(DisasContext *ctx, MemOp memop)
-{
-    uint32_t gpr_FC = FC(ctx->opcode);
-    TCGv EA = tcg_temp_new();
-    int rt = rD(ctx->opcode);
-    bool need_serial;
-    TCGv src, dst;
-
-    gen_addr_register(ctx, EA);
-    dst = cpu_gpr[rt];
-    src = cpu_gpr[(rt + 1) & 31];
-
-    need_serial = false;
-    memop |= MO_ALIGN;
-    switch (gpr_FC) {
-    case 0: /* Fetch and add */
-        tcg_gen_atomic_fetch_add_tl(dst, EA, src, ctx->mem_idx, memop);
-        break;
-    case 1: /* Fetch and xor */
-        tcg_gen_atomic_fetch_xor_tl(dst, EA, src, ctx->mem_idx, memop);
-        break;
-    case 2: /* Fetch and or */
-        tcg_gen_atomic_fetch_or_tl(dst, EA, src, ctx->mem_idx, memop);
-        break;
-    case 3: /* Fetch and 'and' */
-        tcg_gen_atomic_fetch_and_tl(dst, EA, src, ctx->mem_idx, memop);
-        break;
-    case 4:  /* Fetch and max unsigned */
-        tcg_gen_atomic_fetch_umax_tl(dst, EA, src, ctx->mem_idx, memop);
-        break;
-    case 5:  /* Fetch and max signed */
-        tcg_gen_atomic_fetch_smax_tl(dst, EA, src, ctx->mem_idx, memop);
-        break;
-    case 6:  /* Fetch and min unsigned */
-        tcg_gen_atomic_fetch_umin_tl(dst, EA, src, ctx->mem_idx, memop);
-        break;
-    case 7:  /* Fetch and min signed */
-        tcg_gen_atomic_fetch_smin_tl(dst, EA, src, ctx->mem_idx, memop);
-        break;
-    case 8: /* Swap */
-        tcg_gen_atomic_xchg_tl(dst, EA, src, ctx->mem_idx, memop);
-        break;
-
-    case 16: /* Compare and swap not equal */
-        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-            need_serial = true;
-        } else {
-            TCGv t0 = tcg_temp_new();
-            TCGv t1 = tcg_temp_new();
-
-            tcg_gen_qemu_ld_tl(t0, EA, ctx->mem_idx, memop);
-            if ((memop & MO_SIZE) == MO_64 || TARGET_LONG_BITS == 32) {
-                tcg_gen_mov_tl(t1, src);
-            } else {
-                tcg_gen_ext32u_tl(t1, src);
-            }
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t0, t1,
-                               cpu_gpr[(rt + 2) & 31], t0);
-            tcg_gen_qemu_st_tl(t1, EA, ctx->mem_idx, memop);
-            tcg_gen_mov_tl(dst, t0);
-        }
-        break;
-
-    case 24: /* Fetch and increment bounded */
-        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-            need_serial = true;
-        } else {
-            gen_fetch_inc_conditional(ctx, memop, EA, TCG_COND_NE, 1);
-        }
-        break;
-    case 25: /* Fetch and increment equal */
-        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-            need_serial = true;
-        } else {
-            gen_fetch_inc_conditional(ctx, memop, EA, TCG_COND_EQ, 1);
-        }
-        break;
-    case 28: /* Fetch and decrement bounded */
-        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-            need_serial = true;
-        } else {
-            gen_fetch_inc_conditional(ctx, memop, EA, TCG_COND_NE, -1);
-        }
-        break;
-
-    default:
-        /* invoke data storage error handler */
-        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);
-    }
-
-    if (need_serial) {
-        /* Restart with exclusive lock.  */
-        gen_helper_exit_atomic(tcg_env);
-        ctx->base.is_jmp = DISAS_NORETURN;
-    }
-}
-
-static void gen_lwat(DisasContext *ctx)
-{
-    gen_ld_atomic(ctx, DEF_MEMOP(MO_UL));
-}
-
-#ifdef TARGET_PPC64
-static void gen_ldat(DisasContext *ctx)
-{
-    gen_ld_atomic(ctx, DEF_MEMOP(MO_UQ));
-}
-#endif
-
-static void gen_st_atomic(DisasContext *ctx, MemOp memop)
-{
-    uint32_t gpr_FC = FC(ctx->opcode);
-    TCGv EA = tcg_temp_new();
-    TCGv src, discard;
-
-    gen_addr_register(ctx, EA);
-    src = cpu_gpr[rD(ctx->opcode)];
-    discard = tcg_temp_new();
-
-    memop |= MO_ALIGN;
-    switch (gpr_FC) {
-    case 0: /* add and Store */
-        tcg_gen_atomic_add_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
-        break;
-    case 1: /* xor and Store */
-        tcg_gen_atomic_xor_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
-        break;
-    case 2: /* Or and Store */
-        tcg_gen_atomic_or_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
-        break;
-    case 3: /* 'and' and Store */
-        tcg_gen_atomic_and_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
-        break;
-    case 4:  /* Store max unsigned */
-        tcg_gen_atomic_umax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
-        break;
-    case 5:  /* Store max signed */
-        tcg_gen_atomic_smax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
-        break;
-    case 6:  /* Store min unsigned */
-        tcg_gen_atomic_umin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
-        break;
-    case 7:  /* Store min signed */
-        tcg_gen_atomic_smin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
-        break;
-    case 24: /* Store twin  */
-        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-            /* Restart with exclusive lock.  */
-            gen_helper_exit_atomic(tcg_env);
-            ctx->base.is_jmp = DISAS_NORETURN;
-        } else {
-            TCGv t = tcg_temp_new();
-            TCGv t2 = tcg_temp_new();
-            TCGv s = tcg_temp_new();
-            TCGv s2 = tcg_temp_new();
-            TCGv ea_plus_s = tcg_temp_new();
-
-            tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
-            tcg_gen_addi_tl(ea_plus_s, EA, memop_size(memop));
-            tcg_gen_qemu_ld_tl(t2, ea_plus_s, ctx->mem_idx, memop);
-            tcg_gen_movcond_tl(TCG_COND_EQ, s, t, t2, src, t);
-            tcg_gen_movcond_tl(TCG_COND_EQ, s2, t, t2, src, t2);
-            tcg_gen_qemu_st_tl(s, EA, ctx->mem_idx, memop);
-            tcg_gen_qemu_st_tl(s2, ea_plus_s, ctx->mem_idx, memop);
-        }
-        break;
-    default:
-        /* invoke data storage error handler */
-        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);
-    }
-}
-
-static void gen_stwat(DisasContext *ctx)
-{
-    gen_st_atomic(ctx, DEF_MEMOP(MO_UL));
-}
-
-#ifdef TARGET_PPC64
-static void gen_stdat(DisasContext *ctx)
-{
-    gen_st_atomic(ctx, DEF_MEMOP(MO_UQ));
-}
-#endif
-
 /* wait */
 static void gen_wait(DisasContext *ctx)
 {
@@ -5571,12 +5365,6 @@ GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
 GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
-GEN_HANDLER_E(lwat, 0x1F, 0x06, 0x12, 0x00000001, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(stwat, 0x1F, 0x06, 0x16, 0x00000001, PPC_NONE, PPC2_ISA300),
-#if defined(TARGET_PPC64)
-GEN_HANDLER_E(ldat, 0x1F, 0x06, 0x13, 0x00000001, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(stdat, 0x1F, 0x06, 0x17, 0x00000001, PPC_NONE, PPC2_ISA300),
-#endif
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
 GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 25a60d3d3a..f9435f4a00 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1646,3 +1646,217 @@ static bool trans_SRAWI(DisasContext *ctx, arg_SRAWI *a)
     }
     return true;
 }
+
+static void do_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
+                                     TCGv EA, int rt,
+                                     TCGCond cond, int addend)
+{
+    TCGv t = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv u = tcg_temp_new();
+
+    tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
+    tcg_gen_addi_tl(t2, EA, memop_size(memop));
+    tcg_gen_qemu_ld_tl(t2, t2, ctx->mem_idx, memop);
+    tcg_gen_addi_tl(u, t, addend);
+
+    /* mem(EA,s) = (t cond t2 ? u = t + addend : t) */
+    tcg_gen_movcond_tl(cond, u, t, t2, u, t);
+    tcg_gen_qemu_st_tl(u, EA, ctx->mem_idx, memop);
+
+    /* RT = (t cond t2 ? t : 1<<(s*8-1)) */
+    tcg_gen_movcond_tl(cond, cpu_gpr[rt], t, t2, t,
+                       tcg_constant_tl(1 << (memop_size(memop) * 8 - 1)));
+}
+
+/*
+ * Fixed-Point Atomic Load/Store Instructions
+ *
+ * In the X-form encoding the RB field carries the Function Code (FC)
+ * that selects the atomic operation.  EA is computed from RA alone.
+ */
+static bool do_ld_atomic(DisasContext *ctx, arg_X *a, MemOp memop)
+{
+    TCGv EA, dst, src;
+    bool need_serial;
+
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+
+    EA = do_ea_calc(ctx, a->ra, tcg_constant_tl(0));
+    dst = cpu_gpr[a->rt];
+    src = cpu_gpr[(a->rt + 1) & 31];
+
+    need_serial = false;
+    memop |= MO_ALIGN;
+    switch (a->rb) {
+    case 0: /* Fetch and add */
+        tcg_gen_atomic_fetch_add_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 1: /* Fetch and xor */
+        tcg_gen_atomic_fetch_xor_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 2: /* Fetch and or */
+        tcg_gen_atomic_fetch_or_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 3: /* Fetch and 'and' */
+        tcg_gen_atomic_fetch_and_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 4: /* Fetch and max unsigned */
+        tcg_gen_atomic_fetch_umax_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 5: /* Fetch and max signed */
+        tcg_gen_atomic_fetch_smax_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 6: /* Fetch and min unsigned */
+        tcg_gen_atomic_fetch_umin_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 7: /* Fetch and min signed */
+        tcg_gen_atomic_fetch_smin_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 8: /* Swap */
+        tcg_gen_atomic_xchg_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+
+    case 16: /* Compare and swap not equal */
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            need_serial = true;
+        } else {
+            TCGv t0 = tcg_temp_new();
+            TCGv t1 = tcg_temp_new();
+
+            tcg_gen_qemu_ld_tl(t0, EA, ctx->mem_idx, memop);
+            if ((memop & MO_SIZE) == MO_64 || TARGET_LONG_BITS == 32) {
+                tcg_gen_mov_tl(t1, src);
+            } else {
+                tcg_gen_ext32u_tl(t1, src);
+            }
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t0, t1,
+                               cpu_gpr[(a->rt + 2) & 31], t0);
+            tcg_gen_qemu_st_tl(t1, EA, ctx->mem_idx, memop);
+            tcg_gen_mov_tl(dst, t0);
+        }
+        break;
+
+    case 24: /* Fetch and increment bounded */
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            need_serial = true;
+        } else {
+            do_fetch_inc_conditional(ctx, memop, EA, a->rt, TCG_COND_NE, 1);
+        }
+        break;
+    case 25: /* Fetch and increment equal */
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            need_serial = true;
+        } else {
+            do_fetch_inc_conditional(ctx, memop, EA, a->rt, TCG_COND_EQ, 1);
+        }
+        break;
+    case 28: /* Fetch and decrement bounded */
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            need_serial = true;
+        } else {
+            do_fetch_inc_conditional(ctx, memop, EA, a->rt, TCG_COND_NE, -1);
+        }
+        break;
+
+    default:
+        /* invoke data storage error handler */
+        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);
+    }
+
+    if (need_serial) {
+        /* Restart with exclusive lock.  */
+        gen_helper_exit_atomic(tcg_env);
+        ctx->base.is_jmp = DISAS_NORETURN;
+    }
+    return true;
+}
+
+static bool do_st_atomic(DisasContext *ctx, arg_X *a, MemOp memop)
+{
+    TCGv EA, src, discard;
+
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+
+    EA = do_ea_calc(ctx, a->ra, tcg_constant_tl(0));
+    src = cpu_gpr[a->rt];
+    discard = tcg_temp_new();
+
+    memop |= MO_ALIGN;
+    switch (a->rb) {
+    case 0: /* add and Store */
+        tcg_gen_atomic_add_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 1: /* xor and Store */
+        tcg_gen_atomic_xor_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 2: /* Or and Store */
+        tcg_gen_atomic_or_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 3: /* 'and' and Store */
+        tcg_gen_atomic_and_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 4: /* Store max unsigned */
+        tcg_gen_atomic_umax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 5: /* Store max signed */
+        tcg_gen_atomic_smax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 6: /* Store min unsigned */
+        tcg_gen_atomic_umin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 7: /* Store min signed */
+        tcg_gen_atomic_smin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
+    case 24: /* Store twin */
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            /* Restart with exclusive lock.  */
+            gen_helper_exit_atomic(tcg_env);
+            ctx->base.is_jmp = DISAS_NORETURN;
+        } else {
+            TCGv t = tcg_temp_new();
+            TCGv t2 = tcg_temp_new();
+            TCGv s = tcg_temp_new();
+            TCGv s2 = tcg_temp_new();
+            TCGv ea_plus_s = tcg_temp_new();
+
+            tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
+            tcg_gen_addi_tl(ea_plus_s, EA, memop_size(memop));
+            tcg_gen_qemu_ld_tl(t2, ea_plus_s, ctx->mem_idx, memop);
+            tcg_gen_movcond_tl(TCG_COND_EQ, s, t, t2, src, t);
+            tcg_gen_movcond_tl(TCG_COND_EQ, s2, t, t2, src, t2);
+            tcg_gen_qemu_st_tl(s, EA, ctx->mem_idx, memop);
+            tcg_gen_qemu_st_tl(s2, ea_plus_s, ctx->mem_idx, memop);
+        }
+        break;
+    default:
+        /* invoke data storage error handler */
+        gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);
+    }
+    return true;
+}
+
+TRANS(LWAT, do_ld_atomic, DEF_MEMOP(MO_UL))
+TRANS(STWAT, do_st_atomic, DEF_MEMOP(MO_UL))
+
+static bool trans_LDAT(DisasContext *ctx, arg_LDAT *a)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    return do_ld_atomic(ctx, a, DEF_MEMOP(MO_UQ));
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_STDAT(DisasContext *ctx, arg_STDAT *a)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    return do_st_atomic(ctx, a, DEF_MEMOP(MO_UQ));
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
-- 
2.55.0


