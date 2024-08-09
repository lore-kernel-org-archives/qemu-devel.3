Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F53EC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 05:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scIWn-0008BK-8l; Fri, 09 Aug 2024 01:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1scIWl-000840-4I
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 01:51:03 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1scIWi-0008Bk-2n
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 01:51:02 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-368440b073bso964852f8f.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 22:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1723182658; x=1723787458; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbLqQMOuAKd7aCW4So6xCA7s6M4zjTvsQ8hGgjzXuTw=;
 b=Vp1xanU5iuOnsvtnXOjMOBCioNciliQqkiPjRdBbEhKjpeIik1yei6uinmekQl3V3P
 JzEziP74hTjqgAVZ7IAqo9PfrXQ9bVaERFA8C9AMYLCUoQUcSV/YEpdQrg5s6Dn9lftW
 HVB78SFFv2Boq+e5PE6rIeugVPcpoKixxesQxTooNy80DwTICTHULtgRiN/fkyWvAnaD
 Mem98F9rT25F3LTCXUzDx7GTS28f29MeB9PdW5EnqA2/mUV8EcMt3o8ipiIiE/bEEuVB
 okMdhAYeKqha9qKzMyzdsoMW/b/oRE+w3c4dMsPeBxwITVu8lp4s94C+dIHaWpgNs71v
 EuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723182658; x=1723787458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BbLqQMOuAKd7aCW4So6xCA7s6M4zjTvsQ8hGgjzXuTw=;
 b=R+U4XxHS+3SeLEhPt6Se+E/juqgkgHTFn+wr36JCJfTZtGsqu9h9fp8CIpbZD5C3VA
 JvTfoJd70SXGJB8JQDJyDAEqeiHz5gSVaCHQoWKGu4WAvHJAwE4bNFFgSredp160RBHI
 i2fcV/1qyzdkisio5UP9x01Gj2vfwSDpbbung0J7bpbtNj3ZXpOn7/siubCJS+YKQyIh
 u+utzu9LAaykuOQMIZs/4Q0KF3k2N6zGblqhEaERHV6CPIvKtN8k4ZvNAB3RDTfr03C/
 +46mI3yAUc34P0lybkppf6xz5kFIf+FKEj0GL96Fc/SMDv6UTADILD1pzDPLXryxqTk0
 llMQ==
X-Gm-Message-State: AOJu0YyqSXmyV9P5cEsifLEh4/jWxQHOwoM4mSHzWK0lkf1Ocpa7pwID
 8EUaxE0s1Wo0YC06/aagnN/PXNDqPUrFMEqU7ahawmTcIwYhC4zkGjw4IfQU6WWAgIt0HRF+P/3
 vktg6b7x/XNF09VJpYjq1lfVt+XZBqGtNwsOKWw==
X-Google-Smtp-Source: AGHT+IEEWhhv2O6ygVb7YFQm4/1ROkEkJ8ylBmfWPFyDr8krE2MQrpWlV8kcTD10PQZ75tD+EZ7Fq68fbOTiRfpt/hs=
X-Received: by 2002:adf:f9cb:0:b0:367:8fd9:db6b with SMTP id
 ffacd0b85a97d-36d68891671mr316096f8f.9.1723182657907; Thu, 08 Aug 2024
 22:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230608072314.3561109-1-tommy.wu@sifive.com>
 <20230608072314.3561109-2-tommy.wu@sifive.com>
 <CAKmqyKOve+ceaiVQbYWsLqLgtH6VCPHCuaZZJim3KHaQHcJyfQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOve+ceaiVQbYWsLqLgtH6VCPHCuaZZJim3KHaQHcJyfQ@mail.gmail.com>
From: Tommy Wu <tommy.wu@sifive.com>
Date: Fri, 9 Aug 2024 13:50:46 +0800
Message-ID: <CANj3q_mZ9Zhc9eCXBA+eePsaNAMF_mX5kegfFbFyM_1JcuATFw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] target/riscv: Add Smrnmi cpu extension.
To: Alistair Francis <alistair23@gmail.com>
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

On Mon, Jun 12, 2023 at 1:04=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Thu, Jun 8, 2023 at 5:25=E2=80=AFPM Tommy Wu <tommy.wu@sifive.com> wro=
te:
> >
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
>
> The extension should be added after the implementation, so this patch
> should be the last patch.
>
> Alistair

Thanks for the suggestion, I'll move this patch to the last patch.

>
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
> >
> >      /*
> >       * write_misa() is marked as experimental for now so mark
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index de7e43126a..6c14b93cb5 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -366,6 +366,11 @@ struct CPUArchState {
> >      uint64_t kvm_timer_compare;
> >      uint64_t kvm_timer_state;
> >      uint64_t kvm_timer_frequency;
> > +
> > +    /* RNMI */
> > +    target_ulong rnmip;
> > +    uint64_t rnmi_irqvec;
> > +    uint64_t rnmi_excpvec;
> >  };
> >
> >  /*
> > @@ -436,6 +441,7 @@ struct RISCVCPUConfig {
> >      bool ext_smaia;
> >      bool ext_ssaia;
> >      bool ext_sscofpmf;
> > +    bool ext_smrnmi;
> >      bool rvv_ta_all_1s;
> >      bool rvv_ma_all_1s;
> >
> > @@ -562,6 +568,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *=
env);
> >  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
> >  uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
> >                                uint64_t value);
> > +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
> >  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip va=
lue */
> >  void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *=
),
> >                               void *arg);
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 59f0ffd9e1..7cb43b88f3 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -659,6 +659,12 @@ typedef enum {
> >  /* Default Reset Vector adress */
> >  #define DEFAULT_RSTVEC      0x1000
> >
> > +/* Default RNMI Interrupt Vector address */
> > +#define DEFAULT_RNMI_IRQVEC     0x0
> > +
> > +/* Default RNMI Exception Vector address */
> > +#define DEFAULT_RNMI_EXCPVEC    0x0
> > +
> >  /* Exception causes */
> >  typedef enum RISCVException {
> >      RISCV_EXCP_NONE =3D -1, /* sentinel value */
> > @@ -705,6 +711,9 @@ typedef enum RISCVException {
> >  #define IRQ_LOCAL_MAX                      16
> >  #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
> >
> > +/* RNMI causes */
> > +#define RNMI_MAX                           16
> > +
> >  /* mip masks */
> >  #define MIP_USIP                           (1 << IRQ_U_SOFT)
> >  #define MIP_SSIP                           (1 << IRQ_S_SOFT)
> > @@ -896,6 +905,9 @@ typedef enum RISCVException {
> >  #define MHPMEVENT_IDX_MASK                 0xFFFFF
> >  #define MHPMEVENT_SSCOF_RESVD              16
> >
> > +/* RISC-V-specific interrupt pending bits. */
> > +#define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
> > +
> >  /* JVT CSR bits */
> >  #define JVT_MODE                           0x3F
> >  #define JVT_BASE                           (~0x3F)
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 56381aaf26..da477b6c99 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -636,6 +636,30 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, =
uint64_t mask,
> >      return old;
> >  }
> >
> > +void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
> > +{
> > +    CPURISCVState *env =3D &cpu->env;
> > +    CPUState *cs =3D CPU(cpu);
> > +    bool release_lock =3D false;
> > +
> > +    if (!qemu_mutex_iothread_locked()) {
> > +        release_lock =3D true;
> > +        qemu_mutex_lock_iothread();
> > +    }
> > +
> > +    if (level) {
> > +        env->rnmip |=3D 1 << irq;
> > +        cpu_interrupt(cs, CPU_INTERRUPT_RNMI);
> > +    } else {
> > +        env->rnmip &=3D ~(1 << irq);
> > +        cpu_reset_interrupt(cs, CPU_INTERRUPT_RNMI);
> > +    }
> > +
> > +    if (release_lock) {
> > +        qemu_mutex_unlock_iothread();
> > +    }
> > +}
> > +
> >  void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *=
),
> >                               void *arg)
> >  {
> > --
> > 2.31.1
> >
> >

