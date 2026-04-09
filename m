Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D040CE98FAF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 05:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAi6D-00059c-M8; Thu, 09 Apr 2026 01:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAi66-00058I-TD
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:38:35 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAi64-0002qz-Q9
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:38:34 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so67739166b.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 22:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775713111; cv=none;
 d=google.com; s=arc-20240605;
 b=CuuTHfQryYq0TQq/CJeO63AyynH+Yi/rrqgq1XXPqYBSKyzPzYbdk97KevoPLKtpZy
 QG6c4W+lqPpsQOqfrB+As4gPqLVr+z7cddG9pUtHOL0TY8b9SKmEeM6RUo1jy2UgX4dl
 qs0E9xRmXHreJbrWT5MmUxyYRNrK2OVaJQaR1WEmj/pLdWMiLnEcPHD+h8cGhRUUf7l2
 27ZLd8+A1cmDFIyEnln0JC0yPfVnct9T+N9WQHuIEmSqj8rMI1ytvbdF8+VoHFiSDHd0
 tpqcgMaC+sB+NC4XtTDQPtEBfSmIHaNP+P4nh9FhbbJsayP6wQcaTZ9wMePy39m+KqgV
 I8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q2WDs/N3FmYBogg8pYmgVJoLiFe1LAOOfDhScPeZ85I=;
 fh=Qd/ze66coMyOUagELzJHT65GZa6bS4Rhi3rjNufOSiw=;
 b=bnhRM8AK3zv+0vc24Nis7+BVmChO5Z/8GwkazlRdM/Q40xAjM0vL+WKzceo2Pwmi6y
 VY/lB5XzWsHdzOdb7R4br0SH+kAph+pe2NRmc26Eazo2ReRSzvLIPrL01N066xOio5mN
 y4nyhab5/Bo7yMPLCoC8LfxuykXpFvv5DsoD+WiVwZuNaak70RZdAgFPVXyUqPnvVcfr
 DGAXkAw6942A+C8eG2zWRRML6YdlgDmHqy6S4MaqN52Sd2CMNdyi0R61v0U2KM08f5Zc
 tzOxJ3cecD5A0l0mzYWleHRvrW/Sk4WffxNLr49JjB5CBJg2iSwiA4tUakNCyGgJ4ne5
 Tbsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775713111; x=1776317911; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2WDs/N3FmYBogg8pYmgVJoLiFe1LAOOfDhScPeZ85I=;
 b=WNRCllf/xQjQj49HkQfZCyLo48jonI6ruJdvkiq7Iu5INukUOB6SIex7oN8VyAAIi1
 SMzT4Ml1GX8vg+DaYxzE8yx859QL7k0DP098r9/lttNnxZO1NWI3cOXdDiwwQ1Hkt+IB
 GhpfW/+s6MKJURJIyPBVN1nxpY1sJIzN4/liASqJqx5xVzJ+x5qxR6suov3vA7E2MZ3k
 J+STJNL2nQJaetYmPl2e+ilcK4Yivzbm952afa4NNiadxwlqIKjPnnn9pXcqyYafiyXb
 zquhyuhnKzDp8jWRHBevqvuCVdUHpPK33MchYFtLnehsPGOVvxtLN/3692OnDMyS0FAm
 MUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775713111; x=1776317911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q2WDs/N3FmYBogg8pYmgVJoLiFe1LAOOfDhScPeZ85I=;
 b=KtJrb9ivHoXT3t6D76Vyo2+2lLkAdWwGhAPKroUhefjmrCOILw3nERHmAJ2UVryoPT
 O2UwJTt/kr3C4+dyXwpONkzw/Np/iQNt8pZU07brFj1OcEfoAlWbszEHXo02eHQbiSQP
 WcnlXX5PR7566J+bnZzvhqlyi7gfW0zeqZt9m99tHEXz8+TuWKsX25EGfSErbe9pFxlY
 xTH9c0emz4TZtWISsJiOE2Du/GD4fufUpxd9A49v37suvhIdD5I0GYyH/1GIT8W/UoXO
 cIz0xsz2CLrMgOUKsoigcEJ8s1tu5Hsq4GnLcoKslQ50I645mLKPVF1SuP3eE7Y9jXDZ
 BhUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWFn+Zr3RSHSlIKZ3swaQKe5vzPPo4O818iWDPSyqBO8xP6vA3EAav2ifdkz6ZevVuL1HHQ1eMLo1d@nongnu.org
X-Gm-Message-State: AOJu0YxEI9pONceg8jE3/ehAWyAYQ3Z695RY9c44aP6tsvvxHZrN++qE
 110qxDn7Sze7xDSMa7/aDcEUa8YNqeUA3je3cAiN+8gk4yh9BYI/HtvPBg738H67iQUCQ4cGVzO
 yoNK7jYg86IXNYvlSCNwayOhFFBjjEbI=
X-Gm-Gg: AeBDiesbxI+L0/0f9yFjeZOwBJAE5zAuiw6GfJllj8rn6B6BXBOF6EAeB177dbWnfMB
 RLJmbgHNb1H8r8DzekBJcpaDODuWhLNBRbBk+6ABBtkNx3Jh6S3BINjY8EMR+3UqwzmY1tVubj9
 yi4xfLBiXcNiAJo3/WXwQSl3m4dsh5wpHUDKKoA37GzWOpeVXw+hu32pZekqC7SqqggKZbsgqdi
 jSWo+1Pv2xzXf6mqutSs1Hp/HnDIFCeN+xM6j+YJ+iEqnsFV8m2D2Yc+Nr8+nXp9dUPVNdetKVx
 bPMX+1Lxt4XilC/PU+t8zDV1i/npxP+rKykonw==
X-Received: by 2002:a17:907:7fa6:b0:b9c:93f4:d8d9 with SMTP id
 a640c23a62f3a-b9c93f4da3dmr995755266b.33.1775713110786; Wed, 08 Apr 2026
 22:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-2-alistair.francis@wdc.com>
 <ad95d6bb-a483-4ef4-a217-a875b5f7a42f@oss.qualcomm.com>
In-Reply-To: <ad95d6bb-a483-4ef4-a217-a875b5f7a42f@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Apr 2026 15:38:04 +1000
X-Gm-Features: AQROBzCsgrh6cwXnWWPGB8MOE00sfMkIKiBn1V43DbufBsVt28uHbObK2IFtcp0
Message-ID: <CAKmqyKOg=mtUisSTA5+e9Hy2drnqesEZQEEv3XRyEty6N7rPNQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/riscv: Generate access fault if sc comparison
 fails
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Apr 7, 2026 at 7:38=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 4/7/2026 1:36 AM, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > The RISC-V spec states:
> >
> > "For the purposes of memory protection, a failed SC.W may be treated
> > like a store."
> >
> > So if the comparison in sc.w fails we should still check for alignment
> > and do a probe access to check permissions.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
> > Resoves: https://gitlab.com/qemu-project/qemu/-/work_items/3136
>
> Typo: "Resoves"
>
>
> Also, IIRC the bug URL that automatically closes Gitlab issues when
> merging the patch is on the format:
>
> "Resolves: https://gitlab.com/qemu-project/qemu/-/issues/(number)"

Interestingly trying to access

https://gitlab.com/qemu-project/qemu/-/issues/3196

takes me to

https://gitlab.com/qemu-project/qemu/-/work_items/3196

So I think Gitlab is changing from issues to work_items

>
>
> Maybe this URL with "work_items" also works, but even with the regular
> URL Gitlab fails to autoclose the bug sometimes.  I suggest changing the
> "work_items" to "issues" in all those URLs to be safe.

Maybe using "issues" is the problem?

I'm thinking of leaving these as-is, as issues seem to be replaced now.

I even see https://docs.gitlab.com/development/work_items/#migration-strate=
gy
and https://gitlab.com/groups/gitlab-org/-/work_items/6033 with more
details on this

Alistair

>
>
> That said,
>
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   target/riscv/helper.h                   |  3 +++
> >   target/riscv/op_helper.c                | 14 ++++++++++++++
> >   target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
> >   3 files changed, 23 insertions(+)
> >
> > diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> > index b785456ee0..af6cfcfc27 100644
> > --- a/target/riscv/helper.h
> > +++ b/target/riscv/helper.h
> > @@ -1289,3 +1289,6 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
> >   #ifndef CONFIG_USER_ONLY
> >   DEF_HELPER_1(ssamoswap_disabled, void, env)
> >   #endif
> > +
> > +/* Zalrsc" SC write probe */
> > +DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > index 6ccc127c30..b569366369 100644
> > --- a/target/riscv/op_helper.c
> > +++ b/target/riscv/op_helper.c
> > @@ -281,6 +281,20 @@ void helper_cbo_inval(CPURISCVState *env, target_u=
long address)
> >       /* We don't emulate the cache-hierarchy, so we're done. */
> >   }
> >
> > +void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
> > +                           target_ulong size)
> > +{
> > +    uintptr_t ra =3D GETPC();
> > +    int mmu_idx =3D riscv_env_mmu_index(env, false);
> > +
> > +    if (addr & (size - 1)) {
> > +        env->badaddr =3D addr;
> > +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ADDR_MIS, ra);
> > +    }
> > +
> > +    probe_write(env, addr, size, mmu_idx, ra);
> > +}
> > +
> >   #ifndef CONFIG_USER_ONLY
> >
> >   target_ulong helper_sret(CPURISCVState *env)
> > diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/ins=
n_trans/trans_rva.c.inc
> > index a7a3278d24..62c0fe673d 100644
> > --- a/target/riscv/insn_trans/trans_rva.c.inc
> > +++ b/target/riscv/insn_trans/trans_rva.c.inc
> > @@ -90,6 +90,12 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a,=
 MemOp mop)
> >        */
> >       TCGBar bar_strl =3D (ctx->ztso || a->rl) ? TCG_BAR_STRL : 0;
> >       tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + bar_strl);
> > +    /*
> > +     * "For the purposes of memory protection, a failed SC.W may be tr=
eated
> > +     * like a store." so let's check the write access permissions
> > +     */
> > +    gen_helper_sc_probe_write(tcg_env, src1,
> > +                              tcg_constant_tl(memop_size(mop)));
> >       gen_set_gpr(ctx, a->rd, tcg_constant_tl(1));
> >
> >       gen_set_label(l2);
>

