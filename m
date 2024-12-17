Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B96E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTS5-0003R5-3K; Tue, 17 Dec 2024 04:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTRg-0003Mb-QJ; Tue, 17 Dec 2024 04:00:49 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTRd-0000cG-Pc; Tue, 17 Dec 2024 04:00:48 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so1011945866b.0; 
 Tue, 17 Dec 2024 01:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734426043; x=1735030843; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+LzTP/3ziMWZyIgIt6J9ELxiRIaifAzMwsXoTIUOeYw=;
 b=Th1VVqt2epLB+ZBGbyZXA+W9GPsuLVtU+woRt49wKno72BNpWWS35aWRPhFZbcf45H
 bQ1I6WAhmNPDdFeIl8P0JsVtGcvqzykXe/4F+H+e232XVT4rpSwm+GmK240vsG99xSxu
 +acqCA+6FP5AToqClQecSbDQpij57oV2CiJK/LlU1e7phjOMr7AFl/t0IM5R+4Qp7qwV
 nrC5EC9vJgbz+1FQkZUjTmAiNf0ve/ypCz2lJjCbsgJoq4hrK+49nrYzhCHEIelbcujN
 W2kA5qEvIbZy4wg3krjKTvCyCoFZCVuZkh4HQBtebz1KEmcTGO4G+ci0AScFtxEO9QzL
 Txjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734426043; x=1735030843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+LzTP/3ziMWZyIgIt6J9ELxiRIaifAzMwsXoTIUOeYw=;
 b=Zz3+sZvKpz1lOh9jeLJjJGUqlB0yvaa3qILO98tpl07Sw9pFQybLWnDACkkFECH5Z0
 VSi5nBUUfYVuNXaspH6pWup04PxJYDGk8I6C6bYKkRyNhCtKk7TwVTEtRFRe1tlrJOip
 ct7jVvu1UzQeAHHZvhMVme42mfhbp32rBQolAFdddxdQA0Sbd7joxjwZxBAf6dD4s03m
 qWGXfrK71YPiqIeyQi72UcJXUf1XVpcIeZkj1M144qDeLOOBD4Bz39dd/MWB37j8xQSp
 r3NwitTuDAWYSJc2MMMszFSQZxgpxmENhBOSqqvR8oeF5c6+LYeqRYfoeSi53t8KoA2Q
 Ltpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXquonQEplMwmoxcC3vva0vgEqcmAO6DfdaTBSI5M/9yxxKmwSrsmP9a4Kc11EExEoQCWBIi5n2CPS+@nongnu.org,
 AJvYcCXueTwILho//EpOfDXn57KFP0hfP4XaNwPEuCtOPj8eTlmPYeBnKOljmqUd3kbVssod+CorBnrKNpUyHA==@nongnu.org
X-Gm-Message-State: AOJu0Yzv1d7/EssY62MUT86qKP1kar/IdmV3E5Qx+68GWZs+1zNpYJ0M
 Z3nwB2Sog44tzNxW4VEb/M6XQEuLFrve3BziDcGgBZiOX8jQJRNF40O0Hg9QokD7bTcYITA60Ph
 Rcdz3ZKkYJ0E2CtyLh07I0R9VS6M=
X-Gm-Gg: ASbGncuiDqd5zh3OtnsXuhX6zZReZkldW4pMKxR14OwlXVE5HxCGJx3Y46/vLsPdDQO
 NL538BtpsHb1mfG6S58jvdxGQgoG3+s6vtcifwQ==
X-Google-Smtp-Source: AGHT+IHNfeR2QAgCUWM9CY6Dyjs94vp09Cn+HT/EidpRBHnlEhrC9mBl6fmCstv5gHaaHqGf+FD8Hy13vhdHeZjX7s0=
X-Received: by 2002:a17:906:d552:b0:aa6:4494:e354 with SMTP id
 a640c23a62f3a-aab77e7b8d0mr1458869766b.42.1734426043249; Tue, 17 Dec 2024
 01:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20241216121907.660504-1-baturo.alexey@gmail.com>
 <20241216121907.660504-7-baturo.alexey@gmail.com>
 <CAKmqyKMSmjJ5953vDcyDzwoYrk1CpBgYZ2yoGxQ80CYdXevhcQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMSmjJ5953vDcyDzwoYrk1CpBgYZ2yoGxQ80CYdXevhcQ@mail.gmail.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Tue, 17 Dec 2024 12:00:32 +0300
Message-ID: <CAFukJ-DFHzxNrf1xXVGOfSv7oHcxTr1e68PFpnbsH1iWV8a3jg@mail.gmail.com>
Subject: Re: [PATCH v13 6/7] target/riscv: Apply pointer masking for
 virtualized memory accesses
To: Alistair Francis <alistair23@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000328122062973886d"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000328122062973886d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

Thanks for the review. I've tried to address your comments and submitted a
new version.
Could you please take a look if it's ok with you and if so, could you
please put these patches to the queue for the next qemu update?

Thanks!

=D0=B2=D1=82, 17 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 09:13, Ali=
stair Francis <alistair23@gmail.com>:

> On Mon, Dec 16, 2024 at 10:19=E2=80=AFPM <baturo.alexey@gmail.com> wrote:
> >
> > From: Alexey Baturo <baturo.alexey@gmail.com>
> >
> > Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> > ---
> >  target/riscv/cpu.h           |  1 +
> >  target/riscv/cpu_helper.c    | 18 +++++++++++++++
> >  target/riscv/internals.h     | 44 ++++++++++++++++++++++++++++++++++++
> >  target/riscv/op_helper.c     | 16 ++++++-------
> >  target/riscv/vector_helper.c | 21 -----------------
> >  5 files changed, 71 insertions(+), 29 deletions(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 38231fe21e..536ad20fdd 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -773,6 +773,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
> >
> >  bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
> >  RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> > +RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
> >  uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
> >
> >  RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 480d2c2c8b..471d8d40a1 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -260,6 +260,24 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
> >      return pmm;
> >  }
> >
> > +RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
> > +{
> > +    RISCVPmPmm pmm =3D PMM_FIELD_DISABLED;
> > +#ifndef CONFIG_USER_ONLY
> > +    int priv_mode =3D cpu_address_mode(env);
> > +    if (priv_mode =3D=3D PRV_U) {
> > +        pmm =3D get_field(env->hstatus, HSTATUS_HUPMM);
> > +    } else {
> > +        if (get_field(env->hstatus, HSTATUS_SPVP)) {
> > +            pmm =3D get_field(env->henvcfg, HENVCFG_PMM);
> > +        } else {
> > +            pmm =3D get_field(env->senvcfg, SENVCFG_PMM);
> > +        }
> > +    }
> > +#endif
> > +    return pmm;
> > +}
> > +
> >  bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
> >  {
> >      bool virt_mem_en =3D false;
> > diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> > index ddbdee885b..017f33af1f 100644
> > --- a/target/riscv/internals.h
> > +++ b/target/riscv/internals.h
> > @@ -142,4 +142,48 @@ static inline float16 check_nanbox_h(CPURISCVState
> *env, uint64_t f)
> >  /* Our implementation of CPUClass::has_work */
> >  bool riscv_cpu_has_work(CPUState *cs);
> >
> > +/* Zjpm addr masking routine */
> > +static inline target_ulong adjust_addr_body(CPURISCVState *env,
> > +                                            target_ulong addr,
> > +                                            bool is_virt)
>
> Maybe is_virt_addr to be clear it's an address and not hypervisor
> virtulisation.
>
> > +{
> > +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > +        return addr;
> > +    }
> > +    RISCVPmPmm pmm =3D PMM_FIELD_DISABLED;
>
> Same comment about mixed code and declarations and some newlines would
> be great :)
>
> > +    if (is_virt) {
> > +        pmm =3D riscv_pm_get_virt_pmm(env);
> > +    } else {
> > +        pmm =3D riscv_pm_get_pmm(env);
> > +    }
> > +    if (pmm =3D=3D PMM_FIELD_DISABLED) {
> > +        return addr;
> > +    }
> > +    uint32_t pmlen =3D riscv_pm_get_pmlen(pmm);
> > +    bool signext =3D false;
> > +    if (!is_virt) {
> > +        signext =3D riscv_cpu_virt_mem_enabled(env);
> > +    }
> > +    addr =3D addr << pmlen;
> > +    /* sign/zero extend masked address by N-1 bit */
> > +    if (signext) {
> > +        addr =3D (target_long)addr >> pmlen;
> > +    } else {
> > +        addr =3D addr >> pmlen;
> > +    }
> > +    return addr;
> > +}
> > +
> > +static inline target_ulong adjust_addr(CPURISCVState *env,
> > +                                       target_ulong addr)
> > +{
> > +    return adjust_addr_body(env, addr, false);
> > +}
> > +
> > +static inline target_ulong adjust_addr_virt(CPURISCVState *env,
> > +                                            target_ulong addr)
> > +{
> > +    return adjust_addr_body(env, addr, true);
> > +}
>
> Otherwise looks good
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
> > +
> >  #endif
> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > index eddedacf4b..20e5bd5088 100644
> > --- a/target/riscv/op_helper.c
> > +++ b/target/riscv/op_helper.c
> > @@ -472,7 +472,7 @@ target_ulong helper_hyp_hlv_bu(CPURISCVState *env,
> target_ulong addr)
> >      int mmu_idx =3D check_access_hlsv(env, false, ra);
> >      MemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
> >
> > -    return cpu_ldb_mmu(env, addr, oi, ra);
> > +    return cpu_ldb_mmu(env, adjust_addr_virt(env, addr), oi, ra);
> >  }
> >
> >  target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
> > @@ -481,7 +481,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env,
> target_ulong addr)
> >      int mmu_idx =3D check_access_hlsv(env, false, ra);
> >      MemOpIdx oi =3D make_memop_idx(MO_TEUW, mmu_idx);
> >
> > -    return cpu_ldw_mmu(env, addr, oi, ra);
> > +    return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
> >  }
> >
> >  target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
> > @@ -490,7 +490,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env,
> target_ulong addr)
> >      int mmu_idx =3D check_access_hlsv(env, false, ra);
> >      MemOpIdx oi =3D make_memop_idx(MO_TEUL, mmu_idx);
> >
> > -    return cpu_ldl_mmu(env, addr, oi, ra);
> > +    return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
> >  }
> >
> >  target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
> > @@ -499,7 +499,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env,
> target_ulong addr)
> >      int mmu_idx =3D check_access_hlsv(env, false, ra);
> >      MemOpIdx oi =3D make_memop_idx(MO_TEUQ, mmu_idx);
> >
> > -    return cpu_ldq_mmu(env, addr, oi, ra);
> > +    return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
> >  }
> >
> >  void helper_hyp_hsv_b(CPURISCVState *env, target_ulong addr,
> target_ulong val)
> > @@ -508,7 +508,7 @@ void helper_hyp_hsv_b(CPURISCVState *env,
> target_ulong addr, target_ulong val)
> >      int mmu_idx =3D check_access_hlsv(env, false, ra);
> >      MemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
> >
> > -    cpu_stb_mmu(env, addr, val, oi, ra);
> > +    cpu_stb_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
> >  }
> >
> >  void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr,
> target_ulong val)
> > @@ -517,7 +517,7 @@ void helper_hyp_hsv_h(CPURISCVState *env,
> target_ulong addr, target_ulong val)
> >      int mmu_idx =3D check_access_hlsv(env, false, ra);
> >      MemOpIdx oi =3D make_memop_idx(MO_TEUW, mmu_idx);
> >
> > -    cpu_stw_mmu(env, addr, val, oi, ra);
> > +    cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
> >  }
> >
> >  void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr,
> target_ulong val)
> > @@ -526,7 +526,7 @@ void helper_hyp_hsv_w(CPURISCVState *env,
> target_ulong addr, target_ulong val)
> >      int mmu_idx =3D check_access_hlsv(env, false, ra);
> >      MemOpIdx oi =3D make_memop_idx(MO_TEUL, mmu_idx);
> >
> > -    cpu_stl_mmu(env, addr, val, oi, ra);
> > +    cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
> >  }
> >
> >  void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr,
> target_ulong val)
> > @@ -535,7 +535,7 @@ void helper_hyp_hsv_d(CPURISCVState *env,
> target_ulong addr, target_ulong val)
> >      int mmu_idx =3D check_access_hlsv(env, false, ra);
> >      MemOpIdx oi =3D make_memop_idx(MO_TEUQ, mmu_idx);
> >
> > -    cpu_stq_mmu(env, addr, val, oi, ra);
> > +    cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
> >  }
> >
> >  /*
> > diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.=
c
> > index 37c6c198a5..a0093bcc9c 100644
> > --- a/target/riscv/vector_helper.c
> > +++ b/target/riscv/vector_helper.c
> > @@ -105,27 +105,6 @@ static inline uint32_t vext_max_elems(uint32_t
> desc, uint32_t log2_esz)
> >      return scale < 0 ? vlenb >> -scale : vlenb << scale;
> >  }
> >
> > -static inline target_ulong adjust_addr(CPURISCVState *env, target_ulon=
g
> addr)
> > -{
> > -    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > -        return addr;
> > -    }
> > -    RISCVPmPmm pmm =3D riscv_pm_get_pmm(env);
> > -    if (pmm =3D=3D PMM_FIELD_DISABLED) {
> > -        return addr;
> > -    }
> > -    int pmlen =3D riscv_pm_get_pmlen(pmm);
> > -    bool signext =3D riscv_cpu_virt_mem_enabled(env);
> > -    addr =3D addr << pmlen;
> > -    /* sign/zero extend masked address by N-1 bit */
> > -    if (signext) {
> > -        addr =3D (target_long)addr >> pmlen;
> > -    } else {
> > -        addr =3D addr >> pmlen;
> > -    }
> > -    return addr;
> > -}
> > -
> >  /*
> >   * This function checks watchpoint before real load operation.
> >   *
> > --
> > 2.39.5
> >
>

--000000000000328122062973886d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alistair,<div><br></div><div>Thanks for the review. I&#=
39;ve tried to address your comments and submitted a new version.</div><div=
>Could you please take a look if it&#39;s ok with you and if so, could you =
please put these patches to the queue for the next qemu update?</div><div><=
br></div><div>Thanks!</div></div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=82, 17 =D0=B4=D0=
=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 09:13, Alistair Francis &lt;<a href=
=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt;:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Dec 16, 2024 at 10:1=
9=E2=80=AFPM &lt;<a href=3D"mailto:baturo.alexey@gmail.com" target=3D"_blan=
k">baturo.alexey@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail.com" tar=
get=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail=
.com" target=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 1 +<br>
&gt;=C2=A0 target/riscv/cpu_helper.c=C2=A0 =C2=A0 | 18 +++++++++++++++<br>
&gt;=C2=A0 target/riscv/internals.h=C2=A0 =C2=A0 =C2=A0| 44 +++++++++++++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 target/riscv/op_helper.c=C2=A0 =C2=A0 =C2=A0| 16 ++++++-------<b=
r>
&gt;=C2=A0 target/riscv/vector_helper.c | 21 -----------------<br>
&gt;=C2=A0 5 files changed, 71 insertions(+), 29 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; index 38231fe21e..536ad20fdd 100644<br>
&gt; --- a/target/riscv/cpu.h<br>
&gt; +++ b/target/riscv/cpu.h<br>
&gt; @@ -773,6 +773,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);<br>
&gt;<br>
&gt;=C2=A0 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);<br>
&gt;=C2=A0 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);<br>
&gt; +RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);<br>
&gt;=C2=A0 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);<br>
&gt;<br>
&gt;=C2=A0 RISCVException riscv_csrr(CPURISCVState *env, int csrno,<br>
&gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
&gt; index 480d2c2c8b..471d8d40a1 100644<br>
&gt; --- a/target/riscv/cpu_helper.c<br>
&gt; +++ b/target/riscv/cpu_helper.c<br>
&gt; @@ -260,6 +260,24 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 return pmm;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVPmPmm pmm =3D PMM_FIELD_DISABLED;<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 int priv_mode =3D cpu_address_mode(env);<br>
&gt; +=C2=A0 =C2=A0 if (priv_mode =3D=3D PRV_U) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pmm =3D get_field(env-&gt;hstatus, HSTATU=
S_HUPMM);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_field(env-&gt;hstatus, HSTATUS_SP=
VP)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmm =3D get_field(env-&gt;h=
envcfg, HENVCFG_PMM);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmm =3D get_field(env-&gt;s=
envcfg, SENVCFG_PMM);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 return pmm;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool virt_mem_en =3D false;<br>
&gt; diff --git a/target/riscv/internals.h b/target/riscv/internals.h<br>
&gt; index ddbdee885b..017f33af1f 100644<br>
&gt; --- a/target/riscv/internals.h<br>
&gt; +++ b/target/riscv/internals.h<br>
&gt; @@ -142,4 +142,48 @@ static inline float16 check_nanbox_h(CPURISCVStat=
e *env, uint64_t f)<br>
&gt;=C2=A0 /* Our implementation of CPUClass::has_work */<br>
&gt;=C2=A0 bool riscv_cpu_has_work(CPUState *cs);<br>
&gt;<br>
&gt; +/* Zjpm addr masking routine */<br>
&gt; +static inline target_ulong adjust_addr_body(CPURISCVState *env,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 target_ulong addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bool is_virt)<br>
<br>
Maybe is_virt_addr to be clear it&#39;s an address and not hypervisor virtu=
lisation.<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return addr;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 RISCVPmPmm pmm =3D PMM_FIELD_DISABLED;<br>
<br>
Same comment about mixed code and declarations and some newlines would<br>
be great :)<br>
<br>
&gt; +=C2=A0 =C2=A0 if (is_virt) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pmm =3D riscv_pm_get_virt_pmm(env);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pmm =3D riscv_pm_get_pmm(env);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (pmm =3D=3D PMM_FIELD_DISABLED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return addr;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 uint32_t pmlen =3D riscv_pm_get_pmlen(pmm);<br>
&gt; +=C2=A0 =C2=A0 bool signext =3D false;<br>
&gt; +=C2=A0 =C2=A0 if (!is_virt) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 signext =3D riscv_cpu_virt_mem_enabled(en=
v);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 addr =3D addr &lt;&lt; pmlen;<br>
&gt; +=C2=A0 =C2=A0 /* sign/zero extend masked address by N-1 bit */<br>
&gt; +=C2=A0 =C2=A0 if (signext) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D (target_long)addr &gt;&gt; pmlen=
;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D addr &gt;&gt; pmlen;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return addr;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline target_ulong adjust_addr(CPURISCVState *env,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0targe=
t_ulong addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return adjust_addr_body(env, addr, false);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline target_ulong adjust_addr_virt(CPURISCVState *env,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 target_ulong addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return adjust_addr_body(env, addr, true);<br>
&gt; +}<br>
<br>
Otherwise looks good<br>
<br>
Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.co=
m" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
<br>
Alistair<br>
<br>
&gt; +<br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c<br>
&gt; index eddedacf4b..20e5bd5088 100644<br>
&gt; --- a/target/riscv/op_helper.c<br>
&gt; +++ b/target/riscv/op_helper.c<br>
&gt; @@ -472,7 +472,7 @@ target_ulong helper_hyp_hlv_bu(CPURISCVState *env,=
 target_ulong addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mmu_idx =3D check_access_hlsv(env, false, ra);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);<br=
>
&gt;<br>
&gt; -=C2=A0 =C2=A0 return cpu_ldb_mmu(env, addr, oi, ra);<br>
&gt; +=C2=A0 =C2=A0 return cpu_ldb_mmu(env, adjust_addr_virt(env, addr), oi=
, ra);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong =
addr)<br>
&gt; @@ -481,7 +481,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env,=
 target_ulong addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mmu_idx =3D check_access_hlsv(env, false, ra);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemOpIdx oi =3D make_memop_idx(MO_TEUW, mmu_idx);<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 return cpu_ldw_mmu(env, addr, oi, ra);<br>
&gt; +=C2=A0 =C2=A0 return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi=
, ra);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong =
addr)<br>
&gt; @@ -490,7 +490,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env,=
 target_ulong addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mmu_idx =3D check_access_hlsv(env, false, ra);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemOpIdx oi =3D make_memop_idx(MO_TEUL, mmu_idx);<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 return cpu_ldl_mmu(env, addr, oi, ra);<br>
&gt; +=C2=A0 =C2=A0 return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi=
, ra);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong a=
ddr)<br>
&gt; @@ -499,7 +499,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, =
target_ulong addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mmu_idx =3D check_access_hlsv(env, false, ra);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemOpIdx oi =3D make_memop_idx(MO_TEUQ, mmu_idx);<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 return cpu_ldq_mmu(env, addr, oi, ra);<br>
&gt; +=C2=A0 =C2=A0 return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi=
, ra);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 void helper_hyp_hsv_b(CPURISCVState *env, target_ulong addr, tar=
get_ulong val)<br>
&gt; @@ -508,7 +508,7 @@ void helper_hyp_hsv_b(CPURISCVState *env, target_u=
long addr, target_ulong val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mmu_idx =3D check_access_hlsv(env, false, ra);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);<br=
>
&gt;<br>
&gt; -=C2=A0 =C2=A0 cpu_stb_mmu(env, addr, val, oi, ra);<br>
&gt; +=C2=A0 =C2=A0 cpu_stb_mmu(env, adjust_addr_virt(env, addr), val, oi, =
ra);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, tar=
get_ulong val)<br>
&gt; @@ -517,7 +517,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_u=
long addr, target_ulong val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mmu_idx =3D check_access_hlsv(env, false, ra);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemOpIdx oi =3D make_memop_idx(MO_TEUW, mmu_idx);<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 cpu_stw_mmu(env, addr, val, oi, ra);<br>
&gt; +=C2=A0 =C2=A0 cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, =
ra);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, tar=
get_ulong val)<br>
&gt; @@ -526,7 +526,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_u=
long addr, target_ulong val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mmu_idx =3D check_access_hlsv(env, false, ra);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemOpIdx oi =3D make_memop_idx(MO_TEUL, mmu_idx);<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 cpu_stl_mmu(env, addr, val, oi, ra);<br>
&gt; +=C2=A0 =C2=A0 cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, =
ra);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, tar=
get_ulong val)<br>
&gt; @@ -535,7 +535,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_u=
long addr, target_ulong val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mmu_idx =3D check_access_hlsv(env, false, ra);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemOpIdx oi =3D make_memop_idx(MO_TEUQ, mmu_idx);<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 cpu_stq_mmu(env, addr, val, oi, ra);<br>
&gt; +=C2=A0 =C2=A0 cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, =
ra);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt; diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper=
.c<br>
&gt; index 37c6c198a5..a0093bcc9c 100644<br>
&gt; --- a/target/riscv/vector_helper.c<br>
&gt; +++ b/target/riscv/vector_helper.c<br>
&gt; @@ -105,27 +105,6 @@ static inline uint32_t vext_max_elems(uint32_t de=
sc, uint32_t log2_esz)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return scale &lt; 0 ? vlenb &gt;&gt; -scale : vlen=
b &lt;&lt; scale;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static inline target_ulong adjust_addr(CPURISCVState *env, target_ulo=
ng addr)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return addr;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 RISCVPmPmm pmm =3D riscv_pm_get_pmm(env);<br>
&gt; -=C2=A0 =C2=A0 if (pmm =3D=3D PMM_FIELD_DISABLED) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return addr;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 int pmlen =3D riscv_pm_get_pmlen(pmm);<br>
&gt; -=C2=A0 =C2=A0 bool signext =3D riscv_cpu_virt_mem_enabled(env);<br>
&gt; -=C2=A0 =C2=A0 addr =3D addr &lt;&lt; pmlen;<br>
&gt; -=C2=A0 =C2=A0 /* sign/zero extend masked address by N-1 bit */<br>
&gt; -=C2=A0 =C2=A0 if (signext) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D (target_long)addr &gt;&gt; pmlen=
;<br>
&gt; -=C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D addr &gt;&gt; pmlen;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 return addr;<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* This function checks watchpoint before real load operati=
on.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; --<br>
&gt; 2.39.5<br>
&gt;<br>
</blockquote></div>

--000000000000328122062973886d--

