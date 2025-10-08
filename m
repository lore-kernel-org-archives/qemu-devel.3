Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02F3CCD185
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NWt-0000at-Ib; Wed, 08 Oct 2025 02:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v6NWq-0000a4-Ay
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:20:00 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v6NWm-0002nS-Mw
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:20:00 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-639e34ffa69so199723a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1759904394; x=1760509194; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezIllkPDOWek3gY0yXtjvcY07Vsmuqc1hgf6X1qZDp0=;
 b=h2GEkYXeWwNBf6uH3OOYL+GqXS8p/HgrCG2ANJ7ea0tnSTMoboq2rkEHPIE1acFLLO
 qJQWPH2p+PxGEwxFQKew+qo8DQmNrhzOAaBymAKtcH4HU3RGDTQ7OpiuFgTI+2TSkxEp
 nrp9puVUOQRLXrEL/1KzubvsBPb3+EJ0BZGcBT5KiVYsL4SbLgxprZI7QmONKOEp7r+j
 IoMzWiOb+o915MUwN/42rJgsa+f4pLA2taWcpuqUFnc6Q1rF/Bn3I8Sx0SWF8dynrDqD
 uoKKcmBOBuKX0+nveHdHLjmrhlSAXapZCU3Dtj0I66gUv2MVEJd2O7iupHJZNB/oxuOQ
 e/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759904394; x=1760509194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezIllkPDOWek3gY0yXtjvcY07Vsmuqc1hgf6X1qZDp0=;
 b=hzOXBZLHb47sG5PFPlUNo0288S8iUq6iAq9voU1ulnvbgBAd5yW8sMl4UuI+q3SWwP
 6c1f+e+C5g0rON7EcmGzZbqZ15NafFKRnrGTB6nB/42vpYmg7gY9YJY3nZ2FiRQ8gMLg
 By/afJgcmOIYo4kNzUO7X6MkeLlzwQIOMQxn/YSJONXkAyHxGcsUr7clc6mh06PbxwBA
 DC5VVX7wRYnCHmdnx74gEOREHyuA2xsWpfRxGLcvD63b5T0DPXt64hmKvRIC6SpCnJan
 Cy5jDn6No07mBP7AjN7kTTJeVEl0gPExE7ZwFShSCtSTfaPg3UfDuFCUySGlKXddRRev
 aQBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvGUEPesOCbk4oZSSKAa46M5abc4OG2LcJGM9hTcFomDhSrzTjfwjicUu35dUvPUM44Aph7h3p/dbC@nongnu.org
X-Gm-Message-State: AOJu0YwSv4Hbpfbw3ZC2vbK/rZ08jPcPjiB3puNrqGS9W4EE52S1mgaV
 1s5VoDg7OMaRhDo9Ehsz+o6B24//UBbOdbCp0YzW/gq49UxpJiI6R12LEwbzaYG2KjsvPAjxzdd
 hywjaDGPRdqDkZSqC0Uyx3HuKJC/tn7JKqhzL0VJCPA==
X-Gm-Gg: ASbGnct7Mm7r6ihP09TSPjfPOAo2YM7o84UDsI992uSKkUd9Tdxm9oSQYS3iS8Z51I2
 4y1da64+mNWfk7KSl7Izn6LHlZGsLQPQgX3hEs94Tb2bMaPCjeyVY99YR1fU0qm19f/4Pf6X6tQ
 /ISIjduaTFJuUyEQvDRuHCVDtnpwbpjVAbYT8+CWYDE3XmQs83xbXh1fD3bLZqvkoZVJALw6vaA
 ApM9KDoQr4INurvyxaZYSINUv/t4yVp5g==
X-Google-Smtp-Source: AGHT+IGI2BO1iE0QzavqmaPr3PO53oOHjjqp0bgk1Ru5uEr5wfBPZDovA3NiNfCSyxMPa46eTNirZ0bNyzTS3I01X9s=
X-Received: by 2002:a05:6402:34c6:b0:634:4e0:836f with SMTP id
 4fb4d7f45d1cf-639d5b57a88mr1956076a12.1.1759904394488; Tue, 07 Oct 2025
 23:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20701dc8-d156-4ad9-8945-282321c15527@ventanamicro.com>
 <4d658cff-d8ab-4d95-b340-c6b7b5375395@yeah.net>
In-Reply-To: <4d658cff-d8ab-4d95-b340-c6b7b5375395@yeah.net>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 8 Oct 2025 14:19:42 +0800
X-Gm-Features: AS18NWCIS5O1I1BtYGVAvnrquVBQfb4fSNAzaZVeZk8Cm5VqiJ1WKZ6CtJKrwQU
Message-ID: <CALw707r3tBUGbZqYXbPc2B+so6AVhYqUr7ccYYjVidDqqAWemw@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] hw/misc: riscv_worldguard: Add API to enable WG
 extension of CPU
To: Chao Liu <chao.liu@yeah.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: alistair.francis@wdc.com, arikalo@gmail.com, atar4qemu@gmail.com, 
 aurelien@aurel32.net, david@redhat.com, deller@gmx.de, 
 edgar.iglesias@gmail.com, eduardo@habkost.net, gaosong@loongson.cn, 
 iii@linux.ibm.com, jcmvbkbc@gmail.com, jiaxun.yang@flygoat.com, 
 kbastian@mail.uni-paderborn.de, laurent@vivier.eu, liwei1518@gmail.com, 
 marcel.apfelbaum@gmail.com, mark.cave-ayland@ilande.co.uk, mrolnik@gmail.com, 
 npiggin@gmail.com, palmer@dabbelt.com, pbonzini@redhat.com, peterx@redhat.com, 
 philmd@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, richard.henderson@linaro.org, 
 shorne@gmail.com, thuth@redhat.com, wangyanan55@huawei.com, 
 zhao1.liu@intel.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Daniel and Chao,

I will replace qemu_get_cpu() with cpu_by_arch_id().
However, cpu_by_arch_id() can still return NULL if the hartid is
invalid, so I will handle that case with a clean exit.

I will fix these in the v3 patch.


Thanks,
Jim

On Wed, Aug 13, 2025 at 11:10=E2=80=AFAM Chao Liu <chao.liu@yeah.net> wrote=
:
>
> > On 4/17/25 7:52 AM, Jim Shu wrote:
> > > riscv_worldguard_apply_cpu() could enable WG CPU extension and set WG
> > > callback to CPUs. It is used by machine code after realizing global W=
G
> > > device.
> > >
> > > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > > ---
> > >   hw/misc/riscv_worldguard.c         | 87 +++++++++++++++++++++++++++=
+++
> > >   include/hw/misc/riscv_worldguard.h |  1 +
> > >   2 files changed, 88 insertions(+)
> > >
> > > diff --git a/hw/misc/riscv_worldguard.c b/hw/misc/riscv_worldguard.c
> > > index b02bd28d02..1a910f4cf3 100644
> > > --- a/hw/misc/riscv_worldguard.c
> > > +++ b/hw/misc/riscv_worldguard.c
> > > @@ -92,6 +92,93 @@ uint32_t mem_attrs_to_wid(MemTxAttrs attrs)
> > >       }
> > >   }
> > >
> > > +static void riscv_cpu_wg_reset(CPURISCVState *env)
> > > +{
> > > +    CPUState *cs =3D env_cpu(env);
> > > +    RISCVCPU *cpu =3D RISCV_CPU(cs);
> > > +    uint32_t mlwid, slwid, mwiddeleg;
> > > +    uint32_t trustedwid;
> > > +
> > > +    if (!riscv_cpu_cfg(env)->ext_smwg) {
> > > +        return;
> > > +    }
> > > +
> > > +    if (worldguard_config =3D=3D NULL) {
> > > +        /*
> > > +         * Note: This reset is dummy now and WG CSRs will be reset a=
gain
> > > +         * after worldguard_config is realized.
> > > +         */
> > > +        return;
> > > +    }
> > > +
> > > +    trustedwid =3D worldguard_config->trustedwid;
> > > +    if (trustedwid =3D=3D NO_TRUSTEDWID) {
> > > +        trustedwid =3D worldguard_config->nworlds - 1;
> > > +    }
> > > +
> > > +    /* Reset mlwid, slwid, mwiddeleg CSRs */
> > > +    if (worldguard_config->hw_bypass) {
> > > +        /* HW bypass mode */
> > > +        mlwid =3D trustedwid;
> > > +    } else {
> > > +        mlwid =3D 0;
> > > +    }
> > > +    slwid =3D 0;
> > > +    mwiddeleg =3D 0;
> > > +
> > > +    env->mlwid =3D mlwid;
> > > +    if (riscv_cpu_cfg(env)->ext_sswg) {
> > > +        env->slwid =3D slwid;
> > > +        env->mwiddeleg =3D mwiddeleg;
> > > +    }
> > > +
> > > +    /* Check mwid, mwidlist config */
> > > +    if (worldguard_config !=3D NULL) {
> > > +        uint32_t valid_widlist =3D MAKE_64BIT_MASK(0, worldguard_con=
fig->nworlds);
> > > +
> > > +        /* CPU use default mwid / mwidlist config if not set */
> > > +        if (cpu->cfg.mwidlist =3D=3D UINT32_MAX) {
> > > +            /* mwidlist contains all WIDs */
> > > +            cpu->cfg.mwidlist =3D valid_widlist;
> > > +        }
> > > +        if (cpu->cfg.mwid =3D=3D UINT32_MAX) {
> > > +            cpu->cfg.mwid =3D trustedwid;
> > > +        }
> > > +
> > > +        /* Check if mwid/mwidlist HW config is valid in NWorld. */
> > > +        g_assert((cpu->cfg.mwidlist & ~valid_widlist) =3D=3D 0);
> > > +        g_assert(cpu->cfg.mwid < worldguard_config->nworlds);
> > > +    }
> > > +}
> > > +
> > > +/*
> > > + * riscv_worldguard_apply_cpu - Enable WG extension of CPU
> > > + *
> > > + * Note: This API should be used after global WG device is created
> > > + * (riscv_worldguard_realize()).
> > > + */
> > > +void riscv_worldguard_apply_cpu(uint32_t hartid)
> > > +{
> > > +    /* WG global config should exist */
> > > +    g_assert(worldguard_config);
> >
> > We usually add g_asserts() after the variable declarations.
> >
> > > +
> > > +    CPUState *cpu =3D qemu_get_cpu(hartid);
>
> arm_get_cpu() uses CPUState::cpu_index to obtain the corresponding CPUSta=
te pointer.
>
> However, CPUState::cpu_index and the RISC-V HART index are not necessaril=
y strictly
> one-to-one (for instance, when the hartid base is non-zero or when hartid=
s are
> discontinuous).
>
> Typically, we use arm_get_cpu() at the accelerators, rather than in hw/co=
de.
>
> A better approach is to use cpu_by_arch_id() instead of qemu_get_cpu(),
> in RISC-V cpu_by_arch_id() uses the hartid.
>
> e.g.
>
>      CPUState *cpu =3D cpu_by_arch_id(hartid);
>
>
> Thanks,
>
> Chao
>
> > > +    RISCVCPU *rcpu =3D RISCV_CPU(cpu);
> > > +    CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
> > > +
> > > +    rcpu->cfg.ext_smwg =3D true;
> > > +    if (riscv_has_ext(env, RVS) && riscv_has_ext(env, RVU)) {
> > > +        rcpu->cfg.ext_sswg =3D true;
> > > +    }
> >
> > riscv_has_ext() will segfault if env =3D=3D NULL, and you're creating a=
 code
> > path where this might happen:
> >
> > > +    CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
> >
> > In fact, cpu =3D=3D NULL will explode on you earlier via this macro:
> >
> > > +    RISCVCPU *rcpu =3D RISCV_CPU(cpu);
> >
> > You can either handle cpu =3D=3D NULL with a clean exit before using 'c=
pu' to assign
> > stuff or g_assert(cpu !=3D NULL) for a more rude exit. But with this co=
de as is
> > you're gambling with segfaults.
> >
> >
> > Thanks,
> >
> > Daniel
> >
> >
> > > +
> > > +    /* Set machine specific WorldGuard callback */
> > > +    env->wg_reset =3D riscv_cpu_wg_reset;
> > > +    env->wid_to_mem_attrs =3D wid_to_mem_attrs;
> > > +
> > > +    /* Reset WG CSRs in CPU */
> > > +    env->wg_reset(env);
> > > +}
> > > +
> > >   bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock)
> > >   {
> > >       uint32_t wid =3D mem_attrs_to_wid(attrs);
> > > diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/ris=
cv_worldguard.h
> > > index 8a533a0517..211a72e438 100644
> > > --- a/include/hw/misc/riscv_worldguard.h
> > > +++ b/include/hw/misc/riscv_worldguard.h
> > > @@ -48,6 +48,7 @@ extern struct RISCVWorldGuardState *worldguard_conf=
ig;
> > >
> > >   DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t tru=
stedwid,
> > >                                        bool hw_bypass, bool tz_compat=
);
> > > +void riscv_worldguard_apply_cpu(uint32_t hartid);
> > >
> > >   uint32_t mem_attrs_to_wid(MemTxAttrs attrs);
> > >   bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock);
> >
>

