Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C08C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 06:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rynOJ-0000QV-ER; Mon, 22 Apr 2024 02:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rynOH-0000Px-7k
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 02:43:01 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rynOD-0005gp-Qy
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 02:43:00 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5d42e7ab8a9so2426101a12.3
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1713768175; x=1714372975; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrWw4q2Xm+oFKpa+35A1aBlxmx5TMxqjJGYk8G9bETI=;
 b=IyEWsnBRStn3iUEuyjBOxV8wUw11kwAjG2gpNas1JSRsX1D7IivGQudVerSZgnfJbP
 wbt4/MW3/S9V5dCYMD1woyM9Lvj1KfWp+Dms5r4lRUC91NNns25uweQcVcQ+BwBkxdDR
 CORn08XUFnzSdnPekYoQsUtW4uuzSQ3TUKfQw6j3lDZPGJOA2w2kHlSPG62dud2j9O8a
 SutqADsyN8+DaJsKA6okIxlJAGs3JzceY3sWT6iAedbBszVbyNMr0fgJylCmGzHhV1io
 vU4Bk88xOSnoNquObzEhEnOKJM1EZUWWi4+IEtJ/hX36rlbU/Gql8KYcv9JJWvZg3VaL
 YprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713768175; x=1714372975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrWw4q2Xm+oFKpa+35A1aBlxmx5TMxqjJGYk8G9bETI=;
 b=WTuNUL7LbkT47lVijCG9i5/AapMU/sA5NOPGQlf/IQnUenqU5QFYSXtII2Yz9vMUT+
 IsVd1Ty1c/FeBeJaCiRAPkr07KXxaoLkmCDz1J5aKG9nl+pE/m4x9iWLOldLhejovQVz
 gr7mtoguZ/iHvteUeQWj6F+0AEHJzbb/gxEqT/39RVajQNVeSTsDGypTh7FKprUjmc8i
 fMBV14MOQAYhAB44bvmjz06v+0P8m4JJSRY+AW8HwXPcVBEYGO9qR3QNDxCIh2gvis69
 hFZRxY/vhHSo4G8gOTf+IjiCQx4Df0kW6DYzmGc/edQNGS3p4D2a7YRM205RwrNti0ER
 i91Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5RDz7+cbVg6a4yEfx6jyIWmujdPQ42DF66yhH/c3LqgAaPl8oxN5rLIR9HXqr96TCEaAsmgd4voIRAyL/0E/CU0Xy4b8=
X-Gm-Message-State: AOJu0YyeFX0BdPyuh8LCUvF8umedCI0eA1Vpmj5T5C4fS+2G/Ge6I1jO
 K2ifrNIOv9//2nqFNMWWClZkIfJI6DcrEBt6sHRHHk9nP60WqaaMwvcoTjPscyKHlcKvi+Pchzr
 lJFxSfZOlLw0O4X3caNBm5G9fjYV9rBrNzTySZw==
X-Google-Smtp-Source: AGHT+IFuN02/yxqdRvVifxMzU5pZxt+/pM4sNxc3S6ATywSRpMtqLyGDR191Wug9JyTJh3ajipkjVHWDYsx9eziH6Ac=
X-Received: by 2002:a05:6a20:914d:b0:1a7:a21b:66f9 with SMTP id
 x13-20020a056a20914d00b001a7a21b66f9mr10724455pzc.43.1713768175294; Sun, 21
 Apr 2024 23:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240417225432.476505-1-christoph.muellner@vrull.eu>
 <CAKmqyKOPEZQoQqs+W5A68HK1W+9wbLrbKrG1d1Pq4ABnxcZWdg@mail.gmail.com>
In-Reply-To: <CAKmqyKOPEZQoQqs+W5A68HK1W+9wbLrbKrG1d1Pq4ABnxcZWdg@mail.gmail.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Mon, 22 Apr 2024 08:42:43 +0200
Message-ID: <CAEg0e7g2STB3U55EBWw9_busuCf8QhWbt0wW2gFpE0doLVgQ2Q@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: thead: Add th.sxstatus CSR emulation
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cooper Qu <cooper.qu@linux.alibaba.com>, 
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>, 
 Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Vivian Wang <uwu@dram.page>, 
 Qingfang Deng <dqfext@gmail.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 LIU Zhiwei <zhiwe_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-pg1-x529.google.com
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

On Mon, Apr 22, 2024 at 5:29=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Thu, Apr 18, 2024 at 8:55=E2=80=AFAM Christoph M=C3=BCllner
> <christoph.muellner@vrull.eu> wrote:
> >
> > The th.sxstatus CSR can be used to identify available custom extension
> > on T-Head CPUs. The CSR is documented here:
> >   https://github.com/T-head-Semi/thead-extension-spec/blob/master/xthea=
dsxstatus.adoc
> >
> > An important property of this patch is, that the th.sxstatus MAEE field
> > is not set (indicating that XTheadMae is not available).
> > XTheadMae is a memory attribute extension (similar to Svpbmt) which is
> > implemented in many T-Head CPUs (C906, C910, etc.) and utilizes bits
> > in PTEs that are marked as reserved. QEMU maintainers prefer to not
> > implement XTheadMae, so we need give kernels a mechanism to identify
> > if XTheadMae is available in a system or not. And this patch introduces
> > this mechanism in QEMU in a way that's compatible with real HW
> > (i.e., probing the th.sxstatus.MAEE bit).
> >
> > Further context can be found on the list:
> > https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html
> >
> > Reviewed-by: LIU Zhiwei <zhiwe_liu@linux.alibaba.com>
> > Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> > ---
> >  target/riscv/cpu.c       |  1 +
> >  target/riscv/cpu.h       |  4 +++
> >  target/riscv/csr.c       |  2 +-
> >  target/riscv/meson.build |  1 +
> >  target/riscv/th_csr.c    | 68 ++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 75 insertions(+), 1 deletion(-)
> >  create mode 100644 target/riscv/th_csr.c
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 36e3e5fdaf..b82ba95ae6 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -545,6 +545,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
> >      cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
> >  #ifndef CONFIG_USER_ONLY
> >      set_satp_mode_max_supported(cpu, VM_1_10_SV39);
> > +    th_register_custom_csrs(cpu);
> >  #endif
> >
> >      /* inherited from parent obj via riscv_cpu_init() */
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 3b1a02b944..fd9424c8e9 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -818,10 +818,14 @@ extern const bool valid_vm_1_10_32[], valid_vm_1_=
10_64[];
> >
> >  void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
> >  void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
> > +RISCVException smode(CPURISCVState *env, int csrno);
>
> I don't think we should make this public. Especially not the name `smode(=
)`.
>
> One option is to rename this, something like `riscv_csr_check_smode()` ma=
ybe?
>
> The better option is probably just to copy it to the vendor
> implementation as it's a pretty simple function.

Ok, I will copy it and create a v3.

Thanks!

>
> Alistair
>
> >
> >  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
> >
> >  uint8_t satp_mode_max_from_map(uint32_t map);
> >  const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
> >
> > +/* Implemented in th_csr.c */
> > +void th_register_custom_csrs(RISCVCPU *cpu);
> > +
> >  #endif /* RISCV_CPU_H */
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 726096444f..503eeb5f24 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -260,7 +260,7 @@ static RISCVException aia_any32(CPURISCVState *env,=
 int csrno)
> >      return any32(env, csrno);
> >  }
> >
> > -static RISCVException smode(CPURISCVState *env, int csrno)
> > +RISCVException smode(CPURISCVState *env, int csrno)
> >  {
> >      if (riscv_has_ext(env, RVS)) {
> >          return RISCV_EXCP_NONE;
> > diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> > index a5e0734e7f..a4bd61e52a 100644
> > --- a/target/riscv/meson.build
> > +++ b/target/riscv/meson.build
> > @@ -33,6 +33,7 @@ riscv_system_ss.add(files(
> >    'monitor.c',
> >    'machine.c',
> >    'pmu.c',
> > +  'th_csr.c',
> >    'time_helper.c',
> >    'riscv-qmp-cmds.c',
> >  ))
> > diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> > new file mode 100644
> > index 0000000000..44e28a9298
> > --- /dev/null
> > +++ b/target/riscv/th_csr.c
> > @@ -0,0 +1,68 @@
> > +/*
> > + * T-Head-specific CSRs.
> > + *
> > + * Copyright (c) 2024 VRULL GmbH
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITH=
OUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "cpu.h"
> > +#include "cpu_vendorid.h"
> > +
> > +#define CSR_TH_SXSTATUS 0x5c0
> > +
> > +/* TH_SXSTATUS bits */
> > +#define TH_SXSTATUS_UCME        BIT(16)
> > +#define TH_SXSTATUS_MAEE        BIT(21)
> > +#define TH_SXSTATUS_THEADISAEE  BIT(22)
> > +
> > +typedef struct {
> > +    int csrno;
> > +    int (*insertion_test)(RISCVCPU *cpu);
> > +    riscv_csr_operations csr_ops;
> > +} riscv_csr;
> > +
> > +static int test_thead_mvendorid(RISCVCPU *cpu)
> > +{
> > +    if (cpu->cfg.mvendorid !=3D THEAD_VENDOR_ID)
> > +        return -1;
> > +
> > +    return 0;
> > +}
> > +
> > +static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
> > +                                       target_ulong *val)
> > +{
> > +    /* We don't set MAEE here, because QEMU does not implement MAEE. *=
/
> > +    *val =3D TH_SXSTATUS_UCME | TH_SXSTATUS_THEADISAEE;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static riscv_csr th_csr_list[] =3D {
> > +    {
> > +        .csrno =3D CSR_TH_SXSTATUS,
> > +        .insertion_test =3D test_thead_mvendorid,
> > +        .csr_ops =3D { "th.sxstatus", smode, read_th_sxstatus }
> > +    }
> > +};
> > +
> > +void th_register_custom_csrs(RISCVCPU *cpu)
> > +{
> > +    for (size_t i =3D 0; i < ARRAY_SIZE(th_csr_list); i++) {
> > +        int csrno =3D th_csr_list[i].csrno;
> > +        riscv_csr_operations *csr_ops =3D &th_csr_list[i].csr_ops;
> > +        if (!th_csr_list[i].insertion_test(cpu))
> > +            riscv_set_csr_ops(csrno, csr_ops);
> > +    }
> > +}
> > --
> > 2.44.0
> >
> >

