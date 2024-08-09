Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634D7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 05:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scIVW-0005jv-5q; Fri, 09 Aug 2024 01:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1scIVU-0005hk-II
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 01:49:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1scIVS-0007jd-Ld
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 01:49:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3683178b226so670042f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 22:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1723182581; x=1723787381; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08Mevyt9VlIAkk+a+8MISScOtRMlRX6VMco+3MMFgic=;
 b=bfSAye0joMPBQikOCAOibXwQDyWhbaSgFkfyc5sacuZrN1ehesPoGUkgL2Rdye7kn/
 ztDwq2F2YwedhmXPB3RYnjqxVpngXGPQkI6ABPOgKM5pUyUmmRL51JhP+F9hHEtExh95
 lLNxQ+dhP1wQLT+cDhvZueg/MrcwMO/ECDNH8783dTrC7sfHUP2/VcRanvd8CfL8gkQ7
 eOEdNHRma36USaA/HChLzy/9W50aXuof9Vdwv0Lwjp35DQYTh5HG8dnXBC40spORVDIp
 asIYS1aS7R7MjRakvESgp9ZSd4MK1Ch6yi9YrnBW2Vy0UwfSq9dCeXBZfEMra51v45Bv
 T4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723182581; x=1723787381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08Mevyt9VlIAkk+a+8MISScOtRMlRX6VMco+3MMFgic=;
 b=qJYCpciwsEKnT1pK192vluzy/LO/wNy8tVI+LI+P9VBGnsojBvTtsfUfSOcbnnDUbA
 7nBnE3uX0PPEgeTM4jssDCXGw7yvw7dz259TUOaqxUQakVjnlGxtX3ENf2RwqRsnTA2n
 sxrncD6ot4TlnnR3GyCL7fzoobcJgoAPkkliHtfO2xhUpJYeWOvN367whkpBvQ66JUp1
 k0U5Gt5MyocNnymwbKX459S1QExKGu6SOQaQE20gZTPQBnTV8ki3EVBKra4Pk/pKy3uN
 LC7O3cof/Z6gTpiw3bxAl7ozHbqqvKZzuEdpqPFknyigvP6R/aTJa0jwedNeWGDsLwjL
 /kGw==
X-Gm-Message-State: AOJu0Yx8tKsWqUxMFyLXkm6IDNsfYNGC2S2KbyN2pf1fek3r5cU7wpcf
 1ZoHtO+w/njyOAdwd1o/OmoPfYuUM46y2nlcrRtEAIBePfd9vKguPkAH/zOswZrrYQDefnh69fq
 ocvHOsqyEkKjcFhBlNz+iGxTRHc7YqFvHEe7nrw==
X-Google-Smtp-Source: AGHT+IEM5VMkqE2oSwaiHB+m8+KcUT4XUd3rJnjRkNvC2PLX8EL+n901jtS16mA4Ms83jyxAQNRbA6cc8MSstFADhvY=
X-Received: by 2002:a05:6000:257:b0:368:460d:d942 with SMTP id
 ffacd0b85a97d-36d5efdc80dmr259753f8f.24.1723182580475; Thu, 08 Aug 2024
 22:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230608072314.3561109-1-tommy.wu@sifive.com>
 <20230608072314.3561109-2-tommy.wu@sifive.com>
 <20230608-7ebd80b284771a7478d3c6a0@orel>
In-Reply-To: <20230608-7ebd80b284771a7478d3c6a0@orel>
From: Tommy Wu <tommy.wu@sifive.com>
Date: Fri, 9 Aug 2024 13:49:30 +0800
Message-ID: <CANj3q_k=r5=-ym_skRKLXRYvX0Y0zjb1W_bTEixGwLLDL=FeJg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] target/riscv: Add Smrnmi cpu extension.
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, frank.chang@sifive.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=tommy.wu@sifive.com; helo=mail-wr1-x42a.google.com
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

On Thu, Jun 8, 2023 at 5:52=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
>
> Please add a commit message to all patches of the series.
>
> Another comment below.

Thanks for the suggestion, I'll add commit messages to all patches in
the v5 patches.

>
> On Thu, Jun 08, 2023 at 12:23:11AM -0700, Tommy Wu wrote:
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> > ---
> >  hw/riscv/riscv_hart.c         | 21 +++++++++++++++++++++
> >  include/hw/riscv/riscv_hart.h |  4 ++++
> >  target/riscv/cpu.c            | 13 +++++++++++++
> >  target/riscv/cpu.h            |  7 +++++++
> >  target/riscv/cpu_bits.h       | 12 ++++++++++++
> >  target/riscv/cpu_helper.c     | 24 ++++++++++++++++++++++++
> >  6 files changed, 81 insertions(+)
> >
> > diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> > index 613ea2aaa0..eac18f8c29 100644
> > --- a/hw/riscv/riscv_hart.c
> > +++ b/hw/riscv/riscv_hart.c
> > @@ -33,6 +33,12 @@ static Property riscv_harts_props[] =3D {
> >      DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
> >      DEFINE_PROP_UINT64("resetvec", RISCVHartArrayState, resetvec,
> >                         DEFAULT_RSTVEC),
> > +    DEFINE_PROP_ARRAY("rnmi-interrupt-vector", RISCVHartArrayState,
> > +                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64,
> > +                      uint64_t),
> > +    DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
> > +                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64=
,
> > +                      uint64_t),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > @@ -47,6 +53,21 @@ static bool riscv_hart_realize(RISCVHartArrayState *=
s, int idx,
> >  {
> >      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu=
_type);
> >      qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetv=
ec);
> > +
> > +    if (s->harts[idx].cfg.ext_smrnmi) {
> > +        if (s->rnmi_irqvec) {
> > +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> > +                                 "rnmi-interrupt-vector",
> > +                                 s->rnmi_irqvec[idx]);
> > +        }
> > +
> > +        if (s->rnmi_excpvec) {
> > +            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
> > +                                 "rnmi-exception-vector",
> > +                                 s->rnmi_excpvec[idx]);
> > +        }
> > +    }
> > +
> >      s->harts[idx].env.mhartid =3D s->hartid_base + idx;
> >      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
> >      return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
> > diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_har=
t.h
> > index bbc21cdc9a..99c0ac5009 100644
> > --- a/include/hw/riscv/riscv_hart.h
> > +++ b/include/hw/riscv/riscv_hart.h
> > @@ -38,6 +38,10 @@ struct RISCVHartArrayState {
> >      uint32_t hartid_base;
> >      char *cpu_type;
> >      uint64_t resetvec;
> > +    uint32_t num_rnmi_irqvec;
> > +    uint64_t *rnmi_irqvec;
> > +    uint32_t num_rnmi_excpvec;
> > +    uint64_t *rnmi_excpvec;
> >      RISCVCPU *harts;
> >  };
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index db0875fb43..c8dc0eaa87 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -119,6 +119,7 @@ static const struct isa_ext_data isa_edata_arr[] =
=3D {
> >      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
> >      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> >      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> > +    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
> >      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> >      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
> >      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> > @@ -1404,6 +1405,11 @@ static void riscv_cpu_set_irq(void *opaque, int =
irq, int level)
> >          g_assert_not_reached();
> >      }
> >  }
> > +
> > +static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
> > +{
> > +    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
> > +}
> >  #endif /* CONFIG_USER_ONLY */
> >
> >  static void riscv_cpu_init(Object *obj)
> > @@ -1420,6 +1426,8 @@ static void riscv_cpu_init(Object *obj)
> >  #ifndef CONFIG_USER_ONLY
> >      qdev_init_gpio_in(DEVICE(cpu), riscv_cpu_set_irq,
> >                        IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
> > +    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
> > +                            "riscv.cpu.rnmi", RNMI_MAX);
> >  #endif /* CONFIG_USER_ONLY */
> >  }
> >
> > @@ -1600,6 +1608,7 @@ static Property riscv_cpu_extensions[] =3D {
> >      DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
> >      DEFINE_PROP_BOOL("x-smaia", RISCVCPU, cfg.ext_smaia, false),
> >      DEFINE_PROP_BOOL("x-ssaia", RISCVCPU, cfg.ext_ssaia, false),
> > +    DEFINE_PROP_BOOL("x-smrnmi", RISCVCPU, cfg.ext_smrnmi, false),
> >
> >      DEFINE_PROP_BOOL("x-zvfh", RISCVCPU, cfg.ext_zvfh, false),
> >      DEFINE_PROP_BOOL("x-zvfhmin", RISCVCPU, cfg.ext_zvfhmin, false),
> > @@ -1644,6 +1653,10 @@ static Property riscv_cpu_properties[] =3D {
> >
> >      DEFINE_PROP_BOOL("rvv_ta_all_1s", RISCVCPU, cfg.rvv_ta_all_1s, fal=
se),
> >      DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, fal=
se),
> > +    DEFINE_PROP_UINT64("rnmi-interrupt-vector", RISCVCPU, env.rnmi_irq=
vec,
> > +                       DEFAULT_RNMI_IRQVEC),
> > +    DEFINE_PROP_UINT64("rnmi-exception-vector", RISCVCPU, env.rnmi_exc=
pvec,
> > +                       DEFAULT_RNMI_EXCPVEC),
>
> Why are these addresses user configurable? Shouldn't each board set them
> to whatever the real board uses and a generic board, like 'virt', set
> them to whatever works for it, considering the rest of its memory map?
> Also, looking ahead, I don't see where the addresses are described to the
> M-mode software in the DT, which implies board-specific M-mode software
> would hard code it, but generic M-mode software should get the addresses
> from the DT. And, presumably, M-mode software should protect and reserve
> these addresses from S-mode. It'd be nice to see an M-mode software PoC,
> but I didn't see anything on the opensbi mailing list.
>
> Thanks,
> drew

Because the RNMI interrupt trap handler address isn't software configurable=
,
it=E2=80=99s implementation-defined. Although the generic M-mode software g=
et the
addresses from the DT, the generic M-mode software cannot configure it like
`mtvec`. I think making it configurable in the QEMU helps users to test the
functionality of their own RNMI trap handler.

