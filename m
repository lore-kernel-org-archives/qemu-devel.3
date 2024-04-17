Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4717C001CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 22:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxEAx-0000Vj-L5; Wed, 17 Apr 2024 18:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rxEAv-0000UM-1r
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 18:54:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rxEAs-0003Rp-V3
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 18:54:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e5aa82d1f6so8787015ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 15:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1713394481; x=1713999281; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nhFzDwMwsBmId2Yv/fozBSKG3x2HPZ/nSpW3DQKzUE=;
 b=jb4LOuJBEOEJVJZptTOC0UjK7BTWpjY2vb7YsoMBg+WoQBhF8YzlIDivb798SAifel
 0pIM6VVM9D6SrtztS2pUFt/CfTxCBUNNyfuEfQ/iPISHwDuEYeTh2yOVC9D/ZZfGUCXz
 ap7W4RLoPfE/jJ/mnEhrDcVWeBiabWfTH56gkoVS1ERfziz29kKmxFbPkOVLHhcta2yi
 OT5fAnb03R05h91PNLDNv45sqAxCSqf13hSJOpCUxXmvcdaekWDQWCvLov6bMfvVInKv
 nijp6fdXCBTaR9SJJLgzmYnBHrFtWK89Mf5H88N50MWwG/uoK2koh6FrH4/ZP9yAOmOA
 ACWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713394481; x=1713999281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nhFzDwMwsBmId2Yv/fozBSKG3x2HPZ/nSpW3DQKzUE=;
 b=AsdGdDgqVopL1GwN2jteEdqcXdGaOIq1TV73kWSE/6uT1G/QGqSlKzicGtbKL3c94i
 gFqTmllfUzreUZoQMNhvXoQFf5pAiIBModia1M2EpU5kHA+sDoA9sQFc34vBy1RJ763u
 doczcJMxqADYMdhEGyuELwE5j+msnfFlPEyclmBuvXMdQl7M8XNdq++DjyVI9D4/XPin
 TH5+LdEayncNLR1IRSv3y0IHLeYbQwHbJ2FR50XyxqsNgX7+I2zFSuqeVt1VTlJ7Z+cz
 nYhJYTzIOlNAnaCzVBisD/Qitg+S+ysnsx1nXYSGSBhTnfhX8NtQmLESox0n2cXoVmt+
 OMKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLADFu8ZGaUuaAh3pTQBzU4AvpNrOuEOy2j2a6I4Ad6cH3dVzuUcHRhQwUy9mf4TUISiEzNvolTSDdTbwGRpGv6LJvFow=
X-Gm-Message-State: AOJu0YyvcnY7g8DWo4nNKtw+Ut5PlOB3G4JH225ZdYGfR8hUCLa7RNZY
 xmDkjwQzaTB5MWZdfAQMJW66kPvD7RFyEbJMrxXezqT86RpF0i7oQMnen0hWLGFSu4mhHYchT70
 br4cdT26o+HMhQauUMe6jE8/MWytrB3cseWA2yQ==
X-Google-Smtp-Source: AGHT+IHSkeQa0ItnovW8NPslgtAD3ldSJi0dYQvmQRP/ttv1Fc6KtV9NxIQhB4kXHlU+Wtav4Wx+Ko49i31xC+kYp9g=
X-Received: by 2002:a17:90b:1896:b0:2a5:6753:98e0 with SMTP id
 mn22-20020a17090b189600b002a5675398e0mr751464pjb.0.1713394481310; Wed, 17 Apr
 2024 15:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240329120427.684677-1-christoph.muellner@vrull.eu>
 <4e07e450-9b79-42d9-9ac1-dc59849e175d@linux.alibaba.com>
In-Reply-To: <4e07e450-9b79-42d9-9ac1-dc59849e175d@linux.alibaba.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Thu, 18 Apr 2024 00:54:29 +0200
Message-ID: <CAEg0e7hc9Dnus5uz4eL0zHuW7hrpTr5Cyb9B=qQCnQLdKiaPrg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: thead: Add th.sxstatus CSR emulation
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cooper Qu <cooper.qu@linux.alibaba.com>, 
 Huang Tao <eric.huang@linux.alibaba.com>, Conor Dooley <conor@kernel.org>, 
 Andrew Jones <ajones@ventanamicro.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Vivian Wang <uwu@dram.page>, 
 Qingfang Deng <dqfext@gmail.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Weiwei Li <liwei1518@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-pl1-x633.google.com
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

On Fri, Apr 5, 2024 at 3:36=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
>
> On 2024/3/29 20:04, Christoph M=C3=BCllner wrote:
> > The th.sxstatus CSR can be used to identify available custom extension
> > on T-Head CPUs. The CSR is documented here:
> >    https://github.com/T-head-Semi/thead-extension-spec/pull/46
> >
> > An important property of this patch is, that the th.sxstatus MAEE field
> > is not set (indicating that XTheadMaee is not available).
> > XTheadMaee is a memory attribute extension (similar to Svpbmt) which is
> > implemented in many T-Head CPUs (C906, C910, etc.) and utilizes bits
> > in PTEs that are marked as reserved. QEMU maintainers prefer to not
> > implement XTheadMaee, so we need give kernels a mechanism to identify
> > if XTheadMaee is available in a system or not. And this patch introduce=
s
> > this mechanism in QEMU in a way that's compatible with real HW
> > (i.e., probing the th.sxstatus.MAEE bit).
> >
> > Further context can be found on the list:
> > https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html
> >
> > Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> > ---
> >   target/riscv/cpu.c       |  1 +
> >   target/riscv/cpu.h       |  3 ++
> >   target/riscv/meson.build |  1 +
> >   target/riscv/th_csr.c    | 78 +++++++++++++++++++++++++++++++++++++++=
+
> >   4 files changed, 83 insertions(+)
> >   create mode 100644 target/riscv/th_csr.c
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 36e3e5fdaf..b82ba95ae6 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -545,6 +545,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
> >       cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
> >   #ifndef CONFIG_USER_ONLY
> >       set_satp_mode_max_supported(cpu, VM_1_10_SV39);
> > +    th_register_custom_csrs(cpu);
> >   #endif
> >
> >       /* inherited from parent obj via riscv_cpu_init() */
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 3b1a02b944..c9f8f06751 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -824,4 +824,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUSt=
ate *cs);
> >   uint8_t satp_mode_max_from_map(uint32_t map);
> >   const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
> >
> > +/* Implemented in th_csr.c */
> > +void th_register_custom_csrs(RISCVCPU *cpu);
> > +
> >   #endif /* RISCV_CPU_H */
> > diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> > index a5e0734e7f..a4bd61e52a 100644
> > --- a/target/riscv/meson.build
> > +++ b/target/riscv/meson.build
> > @@ -33,6 +33,7 @@ riscv_system_ss.add(files(
> >     'monitor.c',
> >     'machine.c',
> >     'pmu.c',
> > +  'th_csr.c',
> >     'time_helper.c',
> >     'riscv-qmp-cmds.c',
> >   ))
> > diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> > new file mode 100644
> > index 0000000000..66d260cabd
> > --- /dev/null
> > +++ b/target/riscv/th_csr.c
> > @@ -0,0 +1,78 @@
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
> > +static RISCVException s_mode_csr(CPURISCVState *env, int csrno)
> > +{
> > +    if (env->debugger)
> > +        return RISCV_EXCP_NONE;
> > +
> > +    if (env->priv >=3D PRV_S)
> > +        return RISCV_EXCP_NONE;
> This will be checked by riscv_csrrw_check.

Indeed! I missed that.

> > +
> > +    return RISCV_EXCP_ILLEGAL_INST;
> > +}
> Insteadly, reuse the smode in csr.c, where it checks iscv_has_ext(env, RV=
S).

I saw that but preferred to not touch csr.c at all.
But you are right, removing the "static" from smode() is much better than
a useless duplication.

Thanks!

> > +
> > +static int test_thead_mvendorid(RISCVCPU *cpu)
> > +{
> > +    if (cpu->cfg.mvendorid !=3D THEAD_VENDOR_ID)
> > +        return -1;
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
> > +        .csr_ops =3D { "th.sxstatus", s_mode_csr, read_th_sxstatus }
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
>
> Otherwise,
>
> Reviewed-by: LIU Zhiwei <zhiwe_liu@linux.alibaba.com>
>
> Zhiwei
>

