Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFD2CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbaCF-0006xx-Kj; Mon, 22 Jun 2026 04:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wbaCD-0006xh-JC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:39:57 -0400
Received: from [160.191.52.36] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wbaCA-0006eX-58
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:39:57 -0400
Received: from yuno-loong.localnet (unknown [IPv6:2400:e920:0:e::2c])
 by krgm.moe (Postfix) with ESMTPSA id 922D2240AE8F;
 Mon, 22 Jun 2026 16:39:35 +0800 (CST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: Re: [PATCH 3/4] target/loongarch: translate LVZ CSR and trap
 instructions
Date: Mon, 22 Jun 2026 16:39:40 +0800
Message-ID: <PpT5ef17QAWEJFKjwZZgyQ@krgm.moe>
In-Reply-To: <a2c3c1e6-ea1d-e889-808c-d7cb95de150d@loongson.cn>
References: <cover.1779171125.git.prcups@krgm.moe>
 <QcvEHw3eQdWKrgUEx8sb2A@krgm.moe>
 <a2c3c1e6-ea1d-e889-808c-d7cb95de150d@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Host-Lookup-Failed: Reverse DNS lookup failed for 160.191.52.36 (failed)
Received-SPF: pass client-ip=160.191.52.36; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_SBL_CSS=3.335,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026=E5=B9=B45=E6=9C=8826=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C =E4=B8=AD=
=E5=9B=BD=E6=A0=87=E5=87=86=E6=97=B6=E9=97=B4 12:07:35=EF=BC=8CBibo Mao wro=
te=EF=BC=9A
>=20
> On 2026/5/26 =E4=B8=8A=E5=8D=8811:50, SignKirigami wrote:
> > =E5=9C=A8 2026=E5=B9=B45=E6=9C=8822=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=94=
 =E4=B8=AD=E5=9B=BD=E6=A0=87=E5=87=86=E6=97=B6=E9=97=B4 11:16:39=EF=BC=8CBi=
bo Mao =E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2026/5/19 =E4=B8=8B=E5=8D=882:30, SignKirigami wrote:
> >>> Signed-off-by: SignKirigami <prcups@krgm.moe>
> >>> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> >>> ---
> >>>    target/loongarch/disas.c                      |   4 +
> >>>    target/loongarch/insns.decode                 |  11 +
> >>>    .../tcg/insn_trans/trans_privileged.c.inc     | 225 ++++++++++++++=
+++-
> >>>    target/loongarch/tcg/translate.c              |   6 +-
> >>>    target/loongarch/translate.h                  |   2 +
> >>>    5 files changed, 240 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
> >>> index 3249ab7ac6..cae416266b 100644
> >>> --- a/target/loongarch/disas.c
> >>> +++ b/target/loongarch/disas.c
> >>> @@ -698,6 +698,10 @@ INSN(tlbfill,      empty)
> >>>    INSN(tlbclr,       empty)
> >>>    INSN(tlbflush,     empty)
> >>>    INSN(invtlb,       i_rr)
> >>> +INSN(gcsrrd,       r_csr)
> >>> +INSN(gcsrwr,       r_csr)
> >>> +INSN(gcsrxchg,     rr_csr)
> >>> +INSN(hvcl,         i)
> >>>    INSN(cacop,        cop_r_i)
> >>>    INSN(lddir,        rr_i)
> >>>    INSN(ldpte,        j_i)
> >>> diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.d=
ecode
> >>> index 3089d42044..2ade384081 100644
> >>> --- a/target/loongarch/insns.decode
> >>> +++ b/target/loongarch/insns.decode
> >>> @@ -493,6 +493,17 @@ bgeu            0110 11 ................ ..... .=
=2E...     @rr_offs16
> >>>      csrxchg           0000 0100 .............. ..... .....     @rr_c=
sr
> >>>    }
> >>>   =20
> >>> +#
> >>> +# LVZ (LoongArch Virtualization) instructions
> >>> +#
> >>> +{
> >>> +  gcsrrd            0000 0101 .............. 00000 .....     @r_csr
> >>> +  gcsrwr            0000 0101 .............. 00001 .....     @r_csr
> >>> +  gcsrxchg          0000 0101 .............. ..... .....     @rr_csr
> >>> +}
> >>> +
> >>> +hvcl             0000 0000 0010 1011 1 ...............    @i15
> >>> +
> >>>    iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
> >>>    iocsrrd_h        0000 01100100 10000 00001 ..... .....    @rr
> >>>    iocsrrd_w        0000 01100100 10000 00010 ..... .....    @rr
> >>> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b=
/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> >>> index 2094d182ac..0cb629e5d7 100644
> >>> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> >>> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> >>> @@ -39,6 +39,10 @@ GEN_FALSE_TRANS(lddir)
> >>>    GEN_FALSE_TRANS(ertn)
> >>>    GEN_FALSE_TRANS(dbcl)
> >>>    GEN_FALSE_TRANS(idle)
> >>> +GEN_FALSE_TRANS(gcsrrd)
> >>> +GEN_FALSE_TRANS(gcsrwr)
> >>> +GEN_FALSE_TRANS(gcsrxchg)
> >>> +GEN_FALSE_TRANS(hvcl)
> >>>   =20
> >>>    #else
> >>>   =20
> >>> @@ -69,8 +73,25 @@ static bool set_csr_trans_func(unsigned int csr_nu=
m, GenCSRRead readfn,
> >>>        return true;
> >>>    }
> >>>   =20
> >>> +static bool set_gcsr_trans_func(unsigned int csr_num, GenCSRRead rea=
dfn,
> >>> +                                GenCSRWrite writefn)
> >>> +{
> >>> +    CSRInfo *csr;
> >>> +
> >>> +    csr =3D get_gcsr(csr_num);
> >>> +    if (!csr) {
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    csr->readfn =3D (GenCSRFunc)readfn;
> >>> +    csr->writefn =3D (GenCSRFunc)writefn;
> >>> +    return true;
> >>> +}
> >>> +
> >>>    #define SET_CSR_FUNC(NAME, read, write)                 \
> >>>            set_csr_trans_func(LOONGARCH_CSR_##NAME, read, write)
> >>> +#define SET_GCSR_FUNC(NAME, read, write)                \
> >>> +        set_gcsr_trans_func(LOONGARCH_CSR_##NAME, read, write)
> >>>   =20
> >>>    void loongarch_csr_translate_init(void)
> >>>    {
> >>> @@ -85,14 +106,28 @@ void loongarch_csr_translate_init(void)
> >>>        SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
> >>>        SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
> >>>        SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
> >>> +    SET_CSR_FUNC(GSTAT, NULL, gen_helper_csrwr_gstat);
> >>> +    SET_CSR_FUNC(GTLBC, NULL, gen_helper_csrwr_gtlbc);
> >>> +    SET_CSR_FUNC(GINTC, NULL, gen_helper_csrwr_gintc);
> >>> +
> >>> +    SET_GCSR_FUNC(ESTAT, NULL, gen_helper_gcsrwr_estat);
> >>> +    SET_GCSR_FUNC(ASID, NULL, gen_helper_gcsrwr_asid);
> >>> +    SET_GCSR_FUNC(PGD, gen_helper_gcsrrd_pgd, NULL);
> >>> +    SET_GCSR_FUNC(TCFG, NULL, gen_helper_gcsrwr_tcfg);
> >>> +    SET_GCSR_FUNC(TVAL, gen_helper_gcsrrd_tval, NULL);
> >>> +    SET_GCSR_FUNC(TICLR, NULL, gen_helper_gcsrwr_ticlr);
> >>>    }
> >>>    #undef SET_CSR_FUNC
> >>> +#undef SET_GCSR_FUNC
> >>>   =20
> >>>    static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr,=
 bool write)
> >>>    {
> >>>        if ((csr->flags & CSRFL_READONLY) && write) {
> >>>            return false;
> >>>        }
> >>> +    if ((csr->flags & CSRFL_GUEST_READONLY) && ctx->guest_mode && wr=
ite) {
> >>> +        return false;
> >>> +    }
> >>>        if ((csr->flags & CSRFL_IO) && translator_io_start(&ctx->base)=
) {
> >>>            ctx->base.is_jmp =3D DISAS_EXIT_UPDATE;
> >>>        } else if ((csr->flags & CSRFL_EXITTB) && write) {
> >>> @@ -110,12 +145,17 @@ static bool trans_csrrd(DisasContext *ctx, arg_=
csrrd *a)
> >>>        if (check_plv(ctx)) {
> >>>            return false;
> >>>        }
> >>> -    csr =3D get_csr(a->csr);
> >>> +    csr =3D ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
> >>>        if (csr =3D=3D NULL) {
> >>>            /* CSR is undefined: read as 0. */
> >>>            dest =3D tcg_constant_tl(0);
> >>>        } else {
> >>>            check_csr_flags(ctx, csr, false);
> >>> +        if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
> >>> +            gen_helper_gspr(tcg_env);
> >>> +            gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> >>> +            return true;
> >>> +        }
> >>>            dest =3D gpr_dst(ctx, a->rd, EXT_NONE);
> >>>            readfn =3D (GenCSRRead)csr->readfn;
> >>>            if (readfn) {
> >>> @@ -137,12 +177,17 @@ static bool trans_csrwr(DisasContext *ctx, arg_=
csrwr *a)
> >>>        if (check_plv(ctx)) {
> >>>            return false;
> >>>        }
> >>> -    csr =3D get_csr(a->csr);
> >>> +    csr =3D ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
> >>>        if (csr =3D=3D NULL) {
> >>>            /* CSR is undefined: write ignored, read old_value as 0. */
> >>>            gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> >>>            return true;
> >>>        }
> >>> +    if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
> >>> +        gen_helper_gspr(tcg_env);
> >>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> >>> +        return true;
> >>> +    }
> >>>        if (!check_csr_flags(ctx, csr, true)) {
> >>>            /* CSR is readonly: trap. */
> >>>            return false;
> >>> @@ -170,28 +215,35 @@ static bool trans_csrxchg(DisasContext *ctx, ar=
g_csrxchg *a)
> >>>        if (check_plv(ctx)) {
> >>>            return false;
> >>>        }
> >>> -    csr =3D get_csr(a->csr);
> >>> +    csr =3D ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
> >>>        if (csr =3D=3D NULL) {
> >>>            /* CSR is undefined: write ignored, read old_value as 0. */
> >>>            gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> >>>            return true;
> >>>        }
> >>> +    if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
> >>> +        gen_helper_gspr(tcg_env);
> >>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> >>> +        return true;
> >>> +    }
> >>>   =20
> >>>        if (!check_csr_flags(ctx, csr, true)) {
> >>>            /* CSR is readonly: trap. */
> >>>            return false;
> >>>        }
> >>>   =20
> >>> -    /* So far only readonly csrs have readfn. */
> >>> -    assert(csr->readfn =3D=3D NULL);
> >>> -
> >>>        src1 =3D gpr_src(ctx, a->rd, EXT_NONE);
> >>>        mask =3D gpr_src(ctx, a->rj, EXT_NONE);
> >>>        oldv =3D tcg_temp_new();
> >>>        newv =3D tcg_temp_new();
> >>>        temp =3D tcg_temp_new();
> >>>   =20
> >>> -    tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
> >>> +    if (csr->readfn) {
> >>> +        GenCSRRead readfn =3D (GenCSRRead)csr->readfn;
> >>> +        readfn(oldv, tcg_env);
> >>> +    } else {
> >>> +        tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
> >>> +    }
> >>>        tcg_gen_and_tl(newv, src1, mask);
> >>>        tcg_gen_andc_tl(temp, oldv, mask);
> >>>        tcg_gen_or_tl(newv, newv, temp);
> >>> @@ -212,6 +264,11 @@ static bool gen_iocsrrd(DisasContext *ctx, arg_r=
r *a,
> >>>        TCGv dest =3D gpr_dst(ctx, a->rd, EXT_NONE);
> >>>        TCGv src1 =3D gpr_src(ctx, a->rj, EXT_NONE);
> >>>   =20
> >>> +    if (ctx->guest_mode) {
> >>> +        gen_helper_gspr(tcg_env);
> >>> +        return true;
> >>> +    }
> >>> +
> >>>        if (check_plv(ctx)) {
> >>>            return false;
> >>>        }
> >>> @@ -225,6 +282,11 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_r=
r *a,
> >>>        TCGv val =3D gpr_src(ctx, a->rd, EXT_NONE);
> >>>        TCGv addr =3D gpr_src(ctx, a->rj, EXT_NONE);
> >>>   =20
> >>> +    if (ctx->guest_mode) {
> >>> +        gen_helper_gspr(tcg_env);
> >>> +        return true;
> >>> +    }
> >>> +
> >>>        if (check_plv(ctx)) {
> >>>            return false;
> >>>        }
> >>> @@ -400,6 +462,10 @@ static bool trans_dbcl(DisasContext *ctx, arg_db=
cl *a)
> >>>        if (check_plv(ctx)) {
> >>>            return false;
> >>>        }
> >>> +    if (ctx->guest_mode) {
> >>> +        gen_helper_gspr(tcg_env);
> >>> +        return true;
> >>> +    }
> >>>        generate_exception(ctx, EXCCODE_DBP);
> >>>        return true;
> >>>    }
> >>> @@ -410,9 +476,154 @@ static bool trans_idle(DisasContext *ctx, arg_i=
dle *a)
> >>>            return false;
> >>>        }
> >>>   =20
> >>> +    if (ctx->guest_mode) {
> >>> +        gen_helper_gspr(tcg_env);
> >>> +        return true;
> >>> +    }
> >>> +
> >>>        tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
> >>>        gen_helper_idle(tcg_env);
> >>>        ctx->base.is_jmp =3D DISAS_NORETURN;
> >>>        return true;
> >>>    }
> >>> +
> >>> +static bool trans_gcsrrd(DisasContext *ctx, arg_gcsrrd *a)
> >>> +{
> >>> +    TCGv dest;
> >>> +    const CSRInfo *csr;
> >>> +    GenCSRRead readfn;
> >>> +
> >>> +    if (check_plv(ctx)) {
> >>> +        return false;
> >>> +    }
> >>> +    if (!avail_LVZ(ctx) || ctx->guest_mode) {
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    csr =3D get_gcsr(a->csr);
> >>> +    if (csr =3D=3D NULL) {
> >>> +        dest =3D tcg_constant_tl(0);
> >>> +    } else {
> >>> +        dest =3D gpr_dst(ctx, a->rd, EXT_NONE);
> >>> +        if (csr->flags & CSRFL_GSPR) {
> >>> +            tcg_gen_movi_tl(dest, 0);
> >>> +        } else {
> >>> +            readfn =3D (GenCSRRead)csr->readfn;
> >>> +            if (readfn) {
> >>> +                readfn(dest, tcg_env);
> >>> +            } else {
> >>> +                tcg_gen_ld_tl(dest, tcg_env, csr->offset);
> >>> +            }
> >>> +        }
> >>> +    }
> >>> +    gen_set_gpr(a->rd, dest, EXT_NONE);
> >>> +    return true;
> >>> +}
> >>> +
> >>> +static bool trans_gcsrwr(DisasContext *ctx, arg_gcsrwr *a)
> >>> +{
> >>> +    TCGv dest, src1;
> >>> +    const CSRInfo *csr;
> >>> +    GenCSRWrite writefn;
> >>> +
> >>> +    if (check_plv(ctx)) {
> >>> +        return false;
> >>> +    }
> >>> +    if (!avail_LVZ(ctx) || ctx->guest_mode) {
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    csr =3D get_gcsr(a->csr);
> >>> +    if (csr =3D=3D NULL) {
> >>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> >>> +        return true;
> >>> +    }
> >>> +    if (!check_csr_flags(ctx, csr, true)) {
> >>> +        return false;
> >>> +    }
> >>> +    if (csr->flags & CSRFL_GSPR) {
> >>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> >>> +        return true;
> >>> +    }
> >>> +
> >>> +    src1 =3D gpr_src(ctx, a->rd, EXT_NONE);
> >>> +    writefn =3D (GenCSRWrite)csr->writefn;
> >>> +    if (writefn) {
> >>> +        dest =3D gpr_dst(ctx, a->rd, EXT_NONE);
> >>> +        writefn(dest, tcg_env, src1);
> >>> +    } else {
> >>> +        dest =3D tcg_temp_new();
> >>> +        tcg_gen_ld_tl(dest, tcg_env, csr->offset);
> >>> +        tcg_gen_st_tl(src1, tcg_env, csr->offset);
> >>> +    }
> >>> +    gen_set_gpr(a->rd, dest, EXT_NONE);
> >>> +    return true;
> >>> +}
> >>> +
> >>> +static bool trans_gcsrxchg(DisasContext *ctx, arg_gcsrxchg *a)
> >>> +{
> >>> +    TCGv src1, mask, oldv, newv, temp;
> >>> +    const CSRInfo *csr;
> >>> +    GenCSRRead readfn;
> >>> +    GenCSRWrite writefn;
> >>> +
> >>> +    if (check_plv(ctx)) {
> >>> +        return false;
> >>> +    }
> >>> +    if (!avail_LVZ(ctx) || ctx->guest_mode) {
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    csr =3D get_gcsr(a->csr);
> >>> +    if (csr =3D=3D NULL) {
> >>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> >>> +        return true;
> >>> +    }
> >>> +    if (!check_csr_flags(ctx, csr, true)) {
> >>> +        return false;
> >>> +    }
> >>> +    if (csr->flags & CSRFL_GSPR) {
> >>> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> >>> +        return true;
> >>> +    }
> >>> +
> >>> +    src1 =3D gpr_src(ctx, a->rd, EXT_NONE);
> >>> +    mask =3D gpr_src(ctx, a->rj, EXT_NONE);
> >>> +    oldv =3D tcg_temp_new();
> >>> +    newv =3D tcg_temp_new();
> >>> +    temp =3D tcg_temp_new();
> >>> +
> >>> +    readfn =3D (GenCSRRead)csr->readfn;
> >>> +    if (readfn) {
> >>> +        readfn(oldv, tcg_env);
> >>> +    } else {
> >>> +        tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
> >>> +    }
> >>> +    tcg_gen_and_tl(newv, src1, mask);
> >>> +    tcg_gen_andc_tl(temp, oldv, mask);
> >>> +    tcg_gen_or_tl(newv, newv, temp);
> >>> +
> >>> +    writefn =3D (GenCSRWrite)csr->writefn;
> >>> +    if (writefn) {
> >>> +        writefn(oldv, tcg_env, newv);
> >>> +    } else {
> >>> +        tcg_gen_st_tl(newv, tcg_env, csr->offset);
> >>> +    }
> >>> +    gen_set_gpr(a->rd, oldv, EXT_NONE);
> >>> +    return true;
> >>> +}
> >>> +
> >>> +static bool trans_hvcl(DisasContext *ctx, arg_hvcl *a)
> >>> +{
> >>> +    if (!avail_LVZ(ctx)) {
> >>> +        return false;
> >>> +    }
> >>> +    if (!ctx->guest_mode) {
> >>> +        return false;
> >>> +    }
> >>> +    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
> >>> +    gen_helper_hvcl(tcg_env, tcg_constant_i32(a->imm));
> >>> +    ctx->base.is_jmp =3D DISAS_NORETURN;
> >>> +    return true;
> >>> +}
> >>>    #endif
> >>> diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/=
translate.c
> >>> index 124dce6269..15c83ef72d 100644
> >>> --- a/target/loongarch/tcg/translate.c
> >>> +++ b/target/loongarch/tcg/translate.c
> >>> @@ -122,12 +122,16 @@ static void loongarch_tr_init_disas_context(Dis=
asContextBase *dcbase,
> >>>        CPULoongArchState *env =3D cpu_env(cs);
> >>>        DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
> >>>   =20
> >>> +    ctx->guest_mode =3D (ctx->base.tb->flags & HW_FLAGS_GUEST_MODE) =
!=3D 0;
> >>>        ctx->page_start =3D ctx->base.pc_first & TARGET_PAGE_MASK;
> >>>        ctx->plv =3D ctx->base.tb->flags & HW_FLAGS_PLV_MASK;
> >>>        if (ctx->base.tb->flags & HW_FLAGS_CRMD_PG) {
> >>>            ctx->mem_idx =3D ctx->plv;
> >>> +        if (ctx->guest_mode) {
> >>> +            ctx->mem_idx +=3D MMU_GUEST_IDX;
> >>> +        }
> >>>        } else {
> >>> -        ctx->mem_idx =3D MMU_DA_IDX;
> >>> +        ctx->mem_idx =3D ctx->guest_mode ? MMU_GUEST_DA_IDX : MMU_DA=
_IDX;
> >>>        }
> >>>   =20
> >>>        /* Bound the number of insns to execute to those left on the p=
age.  */
> >>> diff --git a/target/loongarch/translate.h b/target/loongarch/translat=
e.h
> >>> index 8aa8325dc6..db0650e713 100644
> >>> --- a/target/loongarch/translate.h
> >>> +++ b/target/loongarch/translate.h
> >>> @@ -26,6 +26,7 @@
> >>>    #define avail_FP_DP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
> >>>    #define avail_LSPW(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
> >>>    #define avail_LAM(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
> >>> +#define avail_LVZ(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LVZ))
> >>>    #define avail_LAM_BH(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM_BH))
> >>>    #define avail_LAMCAS(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAMCAS))
> >>>    #define avail_LSX(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
> >>
> >> static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
> >>                                               CPUState *cs)
> >> {
> >>
> >>       if (FIELD_EX64(env->cpucfg[2], CPUCFG2, LSX)) {
> >>           ctx->vl =3D LSX_LEN;
> >>       }
> >>       if (FIELD_EX64(env->cpucfg[2], CPUCFG2, LASX)) {
> >>           ctx->vl =3D LASX_LEN;
> >>       ctx->cpucfg1 =3D env->cpucfg[1];
> >>       ctx->cpucfg2 =3D env->cpucfg[2];
> >>       ctx->cpucfg3 =3D env->cpucfg[3];
> >> }
> >>
> >> There may be some problem with cpucfg configuration, for example host
> >> has LASX/LSX feature, however vCPU is configured with LASX/LSX feature
> >> disabled. With the upper piece of code, ctx->cpucfg1 comes from host
> >> feature setting instead.
> >>
> >> Regards
> >> Bibo Mao
> >>
> > When in guest mode, executing cpucfg will cause a gspr exception and ex=
it to
> > host mode, so these data may not be used.
> It influences resules of avail_LASX(c), macro avail_LASX(c) of=20
> host/guest should be different.
>=20
> #define avail_LASX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
>=20
> Here ctx->cpucfg2 =3D env->cpucfg[2]; they comes from env->cpucfg[2] both=
=2E=20
> so that avail_LASX(C) will be the same for both host/guest.
>=20
> Regards
> Bibo Mao
cpucfg value of L2 guest is set by L1 vmm and saved by L1 kernel, and it's =
hard
to get the value when not executing cpucfg command and trigger a gspr
exception. So, you may regard ctx->cpucfg as an ability to support these
function by L0 host.

Regards
SignKirigami
> >=20
> > Regards
> > SignKirigami
> >>> @@ -66,6 +67,7 @@ typedef struct DisasContext {
> >>>        TCGv zero;
> >>>        bool la64; /* LoongArch64 mode */
> >>>        bool va32; /* 32-bit virtual address */
> >>> +    bool guest_mode;
> >>>        uint32_t cpucfg1;
> >>>        uint32_t cpucfg2;
> >>>        uint32_t cpucfg3;
> >>>
> >>
> >>
> >=20
> >=20
> >=20
>=20
>=20





