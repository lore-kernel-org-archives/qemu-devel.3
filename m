Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18FEC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 07:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Las-0007fk-H9; Mon, 29 Apr 2024 03:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1s1Lao-0007fE-W5
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:38:31 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1s1Lam-0008Kn-Vi
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:38:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ed01c63657so3946678b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1714376307; x=1714981107; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAXb+/s4aJtPkMUqgr5DUCkeodsEuGGthA+2aas1dow=;
 b=FK7WBaVNilvQ1Ohe7RY8Xsn9qG/xBpm4j0AGEZIEqAiAnv6vAamcX3kBnJoEuxeQwO
 C8KBDNFkA6mo5gKY30Uzq7+qqObsv+QpQvjjz1cGN2fONK/6GcZQRZhuvhrg9iKE+DKR
 V6EnC3lrZCKdM4MnEmJ6Om3pYQmMPuPXBzbLaJU+mMMMs4jf7tcmrvrUpsePOl+52S+c
 ZmeUtZ+HOSENsFcwUZObP2lytDsbe7mBNjC1pMH3oBqAad2KyIDgEsu4i54aG0LuUJkw
 vh7YJv9ZkdN6w5VAaf22zRc69gvJdi/Bs8bYTfc9UHqRHpRRARhiYpqYbz9te0sd1snK
 6msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714376307; x=1714981107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TAXb+/s4aJtPkMUqgr5DUCkeodsEuGGthA+2aas1dow=;
 b=rQIidJ/TXz/yMKqWOp7RgFviFOSaJY4GX1QDBI13fLBkpKAi0+Lg6WLhdoWyNFFLaT
 +xKk9b/e2yAeQ3tGfhoPcNK4CF9HOfe0GizzbaN/ztalz9gdXasDd+Hjw13f7nsH2Cpm
 suNHO4U+p+PBs1033hIQSylAO5XcHhl+I6MQ0fuEMosGOXcwSJhzM6ECuPaUWT8n9Cx8
 s5QZ5gyZ3ZV7bE8TX1oFIwbC92/4Ym6pcMrIh19AWp8ydm4j/xpXc3MNDjU/gK7h8tvO
 zQEQicGUHWf3IUw+lImWDYTTYgC3lCSiEbh8e6/gbQFm9kwHva6K4D3vtJU7weMYEkVz
 nVog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlxRu7mevctboYYyNyv2QsiuEMCy8iu7QOVPog0h2GQaJ/2QAX+4/3XLkeIKx8/D5t5veWsivVZCpUmNs6zRD7F+NOlAg=
X-Gm-Message-State: AOJu0YwwbpjLRA3S2Jc5scSWx1eqRQUIvFweusP1B2IZxRPyg42WVqyp
 Hng75tmFs5wrwnDPgmoJ86ZYJrZi3/K/r0cyqe+d7PgwGSjRPWuzu3kPcjXaYA/v7kRnyNU/iQ+
 xzLvM8wTzTrkFhCnAwV3y0N4SIxCL6D1qrHGh2Q==
X-Google-Smtp-Source: AGHT+IFI5zJJTu1xMF32CQ7ZMKjrzQhzHFktuzjTVI8Lks7AlmUPZ4LofWkbr0qF0kDs7cFBbalsN4L6Ohu7rywvUQY=
X-Received: by 2002:a05:6a21:8889:b0:1a7:79b2:ff1b with SMTP id
 tb9-20020a056a21888900b001a779b2ff1bmr6438343pzc.27.1714376307487; Mon, 29
 Apr 2024 00:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240422065208.1953562-1-christoph.muellner@vrull.eu>
 <CAKmqyKNM-WWtFsUf0vVDi94YD+mMM2AYHL_sT-PdHHeQc289-Q@mail.gmail.com>
In-Reply-To: <CAKmqyKNM-WWtFsUf0vVDi94YD+mMM2AYHL_sT-PdHHeQc289-Q@mail.gmail.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Mon, 29 Apr 2024 09:38:16 +0200
Message-ID: <CAEg0e7g5R0+Li_TU1inE0r=WeQTv85Oh8rtOn7TOepbBPGd__w@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: thead: Add th.sxstatus CSR emulation
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-pf1-x436.google.com
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

On Mon, Apr 29, 2024 at 5:29=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Mon, Apr 22, 2024 at 4:53=E2=80=AFPM Christoph M=C3=BCllner
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
> >  target/riscv/cpu.h       |  3 ++
> >  target/riscv/meson.build |  1 +
> >  target/riscv/th_csr.c    | 77 ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 82 insertions(+)
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
> > index 3b1a02b944..c9f8f06751 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -824,4 +824,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUSt=
ate *cs);
> >  uint8_t satp_mode_max_from_map(uint32_t map);
> >  const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
> >
> > +/* Implemented in th_csr.c */
> > +void th_register_custom_csrs(RISCVCPU *cpu);
> > +
> >  #endif /* RISCV_CPU_H */
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
> > index 0000000000..0eb3ad64f1
> > --- /dev/null
> > +++ b/target/riscv/th_csr.c
> > @@ -0,0 +1,77 @@
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
> > +static RISCVException smode(CPURISCVState *env, int csrno)
> > +{
> > +    if (riscv_has_ext(env, RVS)) {
> > +        return RISCV_EXCP_NONE;
> > +    }
> > +
> > +    return RISCV_EXCP_ILLEGAL_INST;
> > +}
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
>
> Checkpatch error here with missing brackets and some other places above

Sorry for that!
v5 has been sent, where all checkpatch issues have been addressed.

>
> Otherwise:
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
> > +    }
> > +}
> > --
> > 2.44.0
> >
> >

