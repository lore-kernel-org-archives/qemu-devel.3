Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED3DC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whNrM-0001uF-Pt; Wed, 08 Jul 2026 04:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1whNrK-0001tZ-NP; Wed, 08 Jul 2026 04:42:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1whNrI-0000ZI-KM; Wed, 08 Jul 2026 04:42:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6688IbQm2880565; Wed, 8 Jul 2026 08:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=oWNE/rNxc8Plv9gxqex68JA5ce0S9b
 4iyoe/gIWYLAM=; b=K3VYnweisRknC21ZDDZ+FWEXjMz6AJ0W736yEXw6Pbbt2o
 bK+hbmrqsgOOfOfKWogA1Ss7J1ZYk4VtMSH4T1rIODbV+M0bzEVOFPiXBYZjEo2F
 TnRZnBwpbbbO6LYtav1mYEhEkVpt0UEva3hdmbRTO63R00RtzEsNGBGQ09CF4Njk
 uTGMPz7dRKqj5gwKXKVKnUYr/fPZKkzeDkUL7ShY6tAiEAfJub3DXBm7VQG56R0r
 m9WJcGZJ+bMUYwIcZIrdBSiESMZ70ViXVXYOiGlCzHLXj4L3lJg2es3vtPMithsl
 /ABedY3Q0DQR0A1OT4a59MbLO1R4TeLAjb8QKu9Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknk2au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 08:42:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6688Yh9M020599;
 Wed, 8 Jul 2026 08:42:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg6mh5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 08:42:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6688gBhb53608954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 08:42:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 656282004D;
 Wed,  8 Jul 2026 08:42:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B911B20043;
 Wed,  8 Jul 2026 08:42:07 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  8 Jul 2026 08:42:07 +0000 (GMT)
Date: Wed, 8 Jul 2026 14:12:27 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 stefanha@redhat.com, milesg@linux.ibm.com, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com
Subject: Re: [RFC PATCH 11/28] target/ppc: Move fixed-point byte-reversal
 store insns to decodetree
Message-ID: <20260708141208.80b9e14d-03-amachhiw@linux.ibm.com>
Mail-Followup-To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, 
 harshpb@linux.ibm.com, richard.henderson@linaro.org, peter.maydell@linaro.org, 
 stefanha@redhat.com, milesg@linux.ibm.com, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, 
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 sv@linux.ibm.com, 
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-12-rathc@linux.ibm.com>
 <b1276790-9829-4a0f-9a28-fdd34f81881e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1276790-9829-4a0f-9a28-fdd34f81881e@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4e0d6a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=BJaDA7lOGnLh5Z4aDV4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: koZynDRDjzl16svRlIEDZL8VPsgM4O6m
X-Proofpoint-ORIG-GUID: 3EpCs7IM1nBSQtqQjV8mM6CdUE8ie5pg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA3OSBTYWx0ZWRfX03JiB3lI6G+F
 +0z2keX+6bLhVuPcJV6V87aujkliJDDh2FShkVZDlUXHyzdA/IR3f8bhAOv1MGa37sBbB8mmDUu
 2WHli4/E8gBazZYtaQjVQDOkc527KVU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA3OSBTYWx0ZWRfX6oJHdGBr84ar
 AzwpXixBubT94z1Jfyws3vtMpenohRRPcqjl0BXpr+5+cNO3smZQc9ocSRn+aiEQwmRYykgHHfg
 CIvFklofCKKBIFDh3iCO1KbcMQgWV2M77sJQ9cu1eIkgoPp9bE3JTCGi58Jqy2JmXc51qtJba5q
 VEDsIRZKqThTBPgW9zIYgEs7k00107Dekpju3/AFR0WpG1+HOEhQdWobX5i1jjp1NMEMSX2EEXW
 w9hl+xXyW/ti9ds4/Jidi96egWaXSrExbk3CPjngudcpOEd2VcUz+N6iAY8saXyvqBwnnhl19F/
 gQ2Y8q5VafOwxRuRPzCMWS3+xx5XXC1rL68sBJgPE3WUzqOXXRy99fVdD9XACN3u23pXGazTES1
 xTK2by7hYVLfQ6X+v8o+HA+w07jN2V1vDA9PcTcGlnBZmBl7oxDH+CEhSyneoP2k5jXwCtKDIpN
 c6nC71mltDFCFPovk5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080079
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2026/07/06 09:51 PM, Nikhil Kumar Singh wrote:
> The commit message mentions removing the |GEN_TX| macro, but it's likely a
> typo for |GEN_STX|.

Yes, thats a typo. Will fix this.

~Amit
> Rest the patch looks fine to me.
> |
> |Thanks,
> ~ Nikhil
> 
> On 20/05/26 21:37, Chinmay Rath wrote:
> > From: Amit Machhiwal<amachhiw@linux.ibm.com>
> > 
> > Move the below PPC instructions to decodetree specification:
> > 
> >    st{d,h,w}brx, st{d,w,h,b}cix				: X-form
> > 
> > The changes were verified by validating that the TCG micro-ops generated
> > by those insns remain the same. These TCG micro-ops were captured with
> > the `-d op,in_asm` QEMU flag.
> > 
> > Additionally, remove GEN_TX and GEN_STX_E macros as they are no longer
> > used anywhere else.
> > 
> > Signed-off-by: Amit Machhiwal<amachhiw@linux.ibm.com>
> > Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> > [cr: ppc32 build fix, EA calc fix]
> > ---
> >   target/ppc/insn32.decode                   |  8 +++
> >   target/ppc/translate.c                     | 52 +++-----------
> >   target/ppc/translate/fixedpoint-impl.c.inc | 79 ++++++++++++++++++++++
> >   3 files changed, 95 insertions(+), 44 deletions(-)
> > 
> > diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> > index 44ef814fb9..4a28fad64b 100644
> > --- a/target/ppc/insn32.decode
> > +++ b/target/ppc/insn32.decode
> > @@ -372,6 +372,14 @@ STVDX           011111 ..... ..... ..... 0010010001 -   @X
> >   STSKU           111110 ..... ..... ............. 0 11   @DD
> >   STCXU           111110 ..... ..... ............. 1 11   @DD
> > +STDBRX		011111 ..... ..... ..... 1010010100 -	@X
> > +STDCIX		011111 ..... ..... ..... 1111110101 -	@X
> > +STWCIX		011111 ..... ..... ..... 1110010101 -	@X
> > +STHCIX		011111 ..... ..... ..... 1110110101 -	@X
> > +STBCIX		011111 ..... ..... ..... 1111010101 -	@X
> > +STHBRX		011111 ..... ..... ..... 1110010110 -	@X
> > +STWBRX		011111 ..... ..... ..... 1010010110 -	@X
> > +
> >   ### Fixed-Point Compare Instructions
> >   CMP             011111 ... - . ..... ..... 0000000000 - @X_bfl
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index 1fc2cd0b14..7bfbba85d0 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -2529,23 +2529,6 @@ GEN_LDX_HVRM(lhzcix, ld16u, 0x15, 0x19, PPC_CILDST)
> >   GEN_LDX_HVRM(lbzcix, ld8u, 0x15, 0x1a, PPC_CILDST)
> >   #endif
> > -/***                              Integer store                            ***/
> > -#define GEN_STX_E(name, stop, opc2, opc3, type, type2, chk)                   \
> > -static void glue(gen_, name##x)(DisasContext *ctx)                            \
> > -{                                                                             \
> > -    TCGv EA;                                                                  \
> > -    chk(ctx);                                                                 \
> > -    gen_set_access_type(ctx, ACCESS_INT);                                     \
> > -    EA = tcg_temp_new();                                                      \
> > -    gen_addr_reg_index(ctx, EA);                                              \
> > -    gen_qemu_##stop(ctx, cpu_gpr[rS(ctx->opcode)], EA);                       \
> > -}
> > -#define GEN_STX(name, stop, opc2, opc3, type)                                 \
> > -    GEN_STX_E(name, stop, opc2, opc3, type, PPC_NONE, CHK_NONE)
> > -
> > -#define GEN_STX_HVRM(name, stop, opc2, opc3, type)                            \
> > -    GEN_STX_E(name, stop, opc2, opc3, type, PPC_NONE, CHK_HVRM)
> > -
> >   #define GEN_STEPX(name, stop, opc2, opc3)                                     \
> >   static void glue(gen_, name##epx)(DisasContext *ctx)                          \
> >   {                                                                             \
> > @@ -2565,12 +2548,6 @@ GEN_STEPX(stw, DEF_MEMOP(MO_UL), 0x1F, 0x04)
> >   GEN_STEPX(std, DEF_MEMOP(MO_UQ), 0x1d, 0x04)
> >   #endif
> > -#if defined(TARGET_PPC64)
> > -GEN_STX_HVRM(stdcix, st64_i64, 0x15, 0x1f, PPC_CILDST)
> > -GEN_STX_HVRM(stwcix, st32, 0x15, 0x1c, PPC_CILDST)
> > -GEN_STX_HVRM(sthcix, st16, 0x15, 0x1d, PPC_CILDST)
> > -GEN_STX_HVRM(stbcix, st8, 0x15, 0x1e, PPC_CILDST)
> > -#endif
> >   /***                Integer load and store with byte reverse               ***/
> >   /* lhbrx */
> > @@ -2582,15 +2559,8 @@ GEN_LDX(lwbr, ld32ur, 0x16, 0x10, PPC_INTEGER);
> >   #if defined(TARGET_PPC64)
> >   /* ldbrx */
> >   GEN_LDX_E(ldbr, ld64ur_i64, 0x14, 0x10, PPC_NONE, PPC2_DBRX, CHK_NONE);
> > -/* stdbrx */
> > -GEN_STX_E(stdbr, st64r_i64, 0x14, 0x14, PPC_NONE, PPC2_DBRX, CHK_NONE);
> >   #endif  /* TARGET_PPC64 */
> > -/* sthbrx */
> > -GEN_STX(sthbr, st16r, 0x16, 0x1C, PPC_INTEGER);
> > -/* stwbrx */
> > -GEN_STX(stwbr, st32r, 0x16, 0x14, PPC_INTEGER);
> > -
> >   /***                    Integer load and store multiple                    ***/
> >   /* lmw */
> > @@ -5117,9 +5087,17 @@ static int64_t dw_compose_ea(DisasContext *ctx, int x)
> >               return true;                            \
> >           }                                           \
> >       } while (0)
> > +#define REQUIRE_HVRM(CTX)                               \
> > +    do {                                                \
> > +        if (unlikely(ctx->pr || !ctx->hv || ctx->dr)) { \
> > +            gen_priv_opc(CTX);                          \
> > +            return true;                                \
> > +        }                                               \
> > +    } while (0)
> >   #else
> >   #define REQUIRE_SV(CTX) do { gen_priv_opc(CTX); return true; } while (0)
> >   #define REQUIRE_HV(CTX) do { gen_priv_opc(CTX); return true; } while (0)
> > +#define REQUIRE_HVRM(CTX) do { gen_priv_opc(CTX); return true; } while (0)
> >   #endif
> >   /*
> > @@ -5791,20 +5769,6 @@ GEN_LDEPX(lw, DEF_MEMOP(MO_UL), 0x1F, 0x00)
> >   GEN_LDEPX(ld, DEF_MEMOP(MO_UQ), 0x1D, 0x00)
> >   #endif
> > -#undef GEN_STX_E
> > -#define GEN_STX_E(name, stop, opc2, opc3, type, type2, chk)                   \
> > -GEN_HANDLER_E(name##x, 0x1F, opc2, opc3, 0x00000000, type, type2),
> > -
> > -#if defined(TARGET_PPC64)
> > -GEN_STX_E(stdbr, st64r_i64, 0x14, 0x14, PPC_NONE, PPC2_DBRX, CHK_NONE)
> > -GEN_STX_HVRM(stdcix, st64_i64, 0x15, 0x1f, PPC_CILDST)
> > -GEN_STX_HVRM(stwcix, st32, 0x15, 0x1c, PPC_CILDST)
> > -GEN_STX_HVRM(sthcix, st16, 0x15, 0x1d, PPC_CILDST)
> > -GEN_STX_HVRM(stbcix, st8, 0x15, 0x1e, PPC_CILDST)
> > -#endif
> > -GEN_STX(sthbr, st16r, 0x16, 0x1C, PPC_INTEGER)
> > -GEN_STX(stwbr, st32r, 0x16, 0x14, PPC_INTEGER)
> > -
> >   #undef GEN_STEPX
> >   #define GEN_STEPX(name, ldop, opc2, opc3)                                     \
> >   GEN_HANDLER_E(name##epx, 0x1F, opc2, opc3,                                    \
> > diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> > index 9f669894a3..25a60d3d3a 100644
> > --- a/target/ppc/translate/fixedpoint-impl.c.inc
> > +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> > @@ -566,6 +566,85 @@ TRANS(ADDIC_, do_add_D, false, true, false, true);
> >   TRANS(SLD, do_shift_X_rc, tcg_gen_shl_tl);
> >   TRANS(SRD, do_shift_X_rc, tcg_gen_shr_tl);
> > +static bool do_stxx(DisasContext *ctx, arg_X *a,
> > +                       void(*op)(DisasContext *, TCGv, TCGv), bool is_hvrm)
> > +{
> > +    TCGv ea;
> > +
> > +    if (is_hvrm) {
> > +            REQUIRE_HVRM(ctx);
> > +    }
> > +
> > +    gen_set_access_type(ctx, ACCESS_INT);
> > +    ea = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> > +    op(ctx, cpu_gpr[a->rt], ea);
> > +
> > +    return true;
> > +}
> > +
> > +TRANS(STHBRX, do_stxx, gen_qemu_st16r, 0);
> > +TRANS(STWBRX, do_stxx, gen_qemu_st32r, 0);
> > +
> > +static bool trans_STDBRX(DisasContext *ctx, arg_STDBRX *a)
> > +{
> > +    REQUIRE_64BIT(ctx);
> > +    REQUIRE_INSNS_FLAGS2(ctx, DBRX);
> > +#if defined(TARGET_PPC64)
> > +    return do_stxx(ctx, a, gen_qemu_st64r_i64, false);
> > +#else
> > +    qemu_build_not_reached();
> > +#endif
> > +    return true;
> > +}
> > +
> > +static bool trans_STDCIX(DisasContext *ctx, arg_STDCIX *a)
> > +{
> > +    REQUIRE_64BIT(ctx);
> > +    REQUIRE_INSNS_FLAGS(ctx, CILDST);
> > +#if defined(TARGET_PPC64)
> > +    return do_stxx(ctx, a, gen_qemu_st64_i64, true);
> > +#else
> > +    qemu_build_not_reached();
> > +#endif
> > +    return true;
> > +}
> > +
> > +static bool trans_STWCIX(DisasContext *ctx, arg_STWCIX *a)
> > +{
> > +    REQUIRE_64BIT(ctx);
> > +    REQUIRE_INSNS_FLAGS(ctx, CILDST);
> > +#if defined(TARGET_PPC64)
> > +    return do_stxx(ctx, a, gen_qemu_st32, true);
> > +#else
> > +    qemu_build_not_reached();
> > +#endif
> > +    return true;
> > +}
> > +
> > +static bool trans_STHCIX(DisasContext *ctx, arg_STHCIX *a)
> > +{
> > +    REQUIRE_64BIT(ctx);
> > +    REQUIRE_INSNS_FLAGS(ctx, CILDST);
> > +#if defined(TARGET_PPC64)
> > +    return do_stxx(ctx, a, gen_qemu_st16, true);
> > +#else
> > +    qemu_build_not_reached();
> > +#endif
> > +    return true;
> > +}
> > +
> > +static bool trans_STBCIX(DisasContext *ctx, arg_STBCIX *a)
> > +{
> > +    REQUIRE_64BIT(ctx);
> > +    REQUIRE_INSNS_FLAGS(ctx, CILDST);
> > +#if defined(TARGET_PPC64)
> > +    return do_stxx(ctx, a, gen_qemu_st8, true);
> > +#else
> > +    qemu_build_not_reached();
> > +#endif
> > +    return true;
> > +}
> > +
> >   static bool trans_SUBFIC(DisasContext *ctx, arg_D *a)
> >   {
> >       gen_op_arith_subf(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra],

