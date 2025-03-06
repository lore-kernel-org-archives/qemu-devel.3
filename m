Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28FBC28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4LY-00018L-Su; Thu, 06 Mar 2025 01:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq4LK-00016R-DR; Thu, 06 Mar 2025 01:04:28 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq4LI-0001g4-Fj; Thu, 06 Mar 2025 01:04:26 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-86b6be2c480so89262241.0; 
 Wed, 05 Mar 2025 22:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741241062; x=1741845862; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JT672sFUaARLo+xAOg1ib1kW1Nt0+E5ZKP8pHGJ4cQA=;
 b=TuyjX9xnsnAACxUh3Z6qpHJWCzN35jSba7daMs/K2ezKnV/XEEpCcIGDrdh8AvVnwl
 VgaxCyxqQ5pYRYZ+5TmjKjksfZMT6kTKs1QdbTAI11oV3u90xWXaqyOlnPw8BFhTixcg
 GHtRRazHW+SkWpfpvy6sRmQgqslmCytlrbdCnkwU2K6MxIY66GbM3qY7QjpMbLFBW/Mx
 k0JJTac4OGWEsTkrBOg58Wq2chAAQrQCRfTTARYG6W1wEMlNzAQ23sBalXGxXDaH0+9V
 cZrT3rrrssH1oK444T9O/5yWq6cGK7cJKmQMNFf5ow4hFyachT4wfvgMw52C1n+UJrdB
 uvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741241062; x=1741845862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JT672sFUaARLo+xAOg1ib1kW1Nt0+E5ZKP8pHGJ4cQA=;
 b=e5gD4DX5BTJEsV9HiHJUE7YpkLdNbS+VVQ0M7ITLxNXRyhk+p1Rlc+GMfunHope8WL
 XJgodYABP0SHUz7E4+qMTlICZpgXaFPgOQFGxAW5qliKjXP7bClYDZDc2/ptEQ/LRTOC
 ntoUXmKpuC5xvM9V0qIJ9wOjyk2/Spyj6Bma3g9yncnCP1LtgQ4+SS5Xd976nqQlmjRQ
 UmrlbvcNWhkUgmmsPefMpj8klW7YmIzv11gOkf5w5X4vbN57IqrYfrIEYngkdZ1oRI/x
 zEk5bb4UyVURjAmD4rh0McG1pY+dSW63/WjPM2XGG5GxG/xmUcPU6DcSpglBiuRIN9na
 FgOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWeKJ4ffBTR+vIFTE5DP30BRKqMr1DhOt/kxn1mcKwmLKh+j0XQaAOCA5jQaPt/GzKIX8SxBW20X0U@nongnu.org
X-Gm-Message-State: AOJu0Yyz8/954u5eSRXVBrb1wIlFBQAoWH+VQGnfqO4pBG9ho6kkFAuU
 NJ/HxBiUfkbyFus8ueqLW96we9enEKOiq2M0Kdm75qou/NBQshlQU9q3brmSFHvQA/+NM0P6hWF
 d/MvKafevuk8XxPC/0R64smYsXT0=
X-Gm-Gg: ASbGncsB+2VFbKmfFOJIE/9TzbNvctFajTxbaCRSTePt5nnRRLr/x60Xj1E3QIrZ/W+
 zQCcJQrT0f+M1qVb8JboFUDHS0AF2ajeX9ahWG/k+EKjAoOdoY1dSBSNPzcN3xkXuOXIWCPZGA9
 /tmH0I7OmnA/SJFQjTyQAHFX+S1t+0TLSPvpzao99rxosoHCaFYl3DMwN8
X-Google-Smtp-Source: AGHT+IFxyrSZlA5APPJxp7C3F+DQBZoXhCNev8SjeAXKvumGIanxY50BxaKomW6+DxN48IcICu/yDLi5eTvWo7KGU0c=
X-Received: by 2002:a05:6102:50a3:b0:4c1:94c1:1c34 with SMTP id
 ada2fe7eead31-4c2e291086dmr3826594137.20.1741241062540; Wed, 05 Mar 2025
 22:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20250303093155.35585-1-florian.lugou@provenrun.com>
 <20250303093155.35585-2-florian.lugou@provenrun.com>
 <CAKmqyKOhUpLbmj3ob7htaYdmqhZxOn2nJCyoerb=UsuLxECjig@mail.gmail.com>
In-Reply-To: <CAKmqyKOhUpLbmj3ob7htaYdmqhZxOn2nJCyoerb=UsuLxECjig@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 16:03:56 +1000
X-Gm-Features: AQ5f1Jq35SeN9ke0GhHI5AoTqaF1EfvZ61Zg_VxWr5Jm30MStaBhhvUxffca8JI
Message-ID: <CAKmqyKP0ZcRXpPveDD3MpKDRATfeV+fsqg=+dWn+xGe-cBMjwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Add scontext CSR handling
To: Florian Lugou <florian.lugou@provenrun.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Thu, Mar 6, 2025 at 3:48=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Mon, Mar 3, 2025 at 7:39=E2=80=AFPM Florian Lugou
> <florian.lugou@provenrun.com> wrote:
> >
> > scontext size is 16 bits on RV32 and 32 bits on RV64, as recommended by
> > version 1.0 2025-02-21 of the debug specification.
>
> Section 5.7.8 indicates the register is XLEN bits wide, with data
> being 32-bits wide for both RV32 and RV64.

Note that QEMU supports the ratified 0.13 debug spec [1] (plus
mcontrol6), where scontext.data is XLEN bits wide, so that's what will
need to be done here.

If you want to support the new debug spec that's also fine, but we
need a way to expose that to users and ensure the spec is supported.

1: https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vote

Alistair

>
> Alistair
>
> >
> > When the Smstateen extension is implemented, accessibility to the
> > scontext CSR is controlled by bit 57 of the [mh]stateen0 CSRs.
> >
> > Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
> > ---
> >  target/riscv/cpu.h      |  1 +
> >  target/riscv/cpu_bits.h |  5 +++++
> >  target/riscv/csr.c      | 36 ++++++++++++++++++++++++++++++++++++
> >  target/riscv/debug.c    |  1 +
> >  4 files changed, 43 insertions(+)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 616c3bdc1c..102e8285a6 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -440,6 +440,7 @@ struct CPUArchState {
> >      target_ulong tdata2[RV_MAX_TRIGGERS];
> >      target_ulong tdata3[RV_MAX_TRIGGERS];
> >      target_ulong mcontext;
> > +    target_ulong scontext;
> >      struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
> >      struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
> >      QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index a30317c617..e8997f3153 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -258,6 +258,9 @@
> >  /* VS-Level Control transfer records CSRs */
> >  #define CSR_VSCTRCTL        0x24e
> >
> > +/* Supervisor-Level Sdtrig CSRs (debug) */
> > +#define CSR_SCONTEXT        0x5a8
> > +
> >  /* Hpervisor CSRs */
> >  #define CSR_HSTATUS         0x600
> >  #define CSR_HEDELEG         0x602
> > @@ -1103,4 +1106,6 @@ typedef enum CTRType {
> >  #define MCONTEXT64                         0x0000000000001FFFULL
> >  #define MCONTEXT32_HCONTEXT                0x0000007F
> >  #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
> > +#define SCONTEXT32                         0x0000FFFF
> > +#define SCONTEXT64                         0x00000000FFFFFFFFULL
> >  #endif
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 0ebcca4597..37b38f24a6 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -3393,6 +3393,10 @@ static RISCVException write_mstateen0(CPURISCVSt=
ate *env, int csrno,
> >          wr_mask |=3D SMSTATEEN0_P1P13;
> >      }
> >
> > +    if (riscv_cpu_cfg(env)->debug) {
> > +        wr_mask |=3D SMSTATEEN0_HSCONTXT;
> > +    }
> > +
> >      if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsr=
ind) {
> >          wr_mask |=3D SMSTATEEN0_SVSLCT;
> >      }
> > @@ -5321,6 +5325,35 @@ static RISCVException write_mcontext(CPURISCVSta=
te *env, int csrno,
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > +static RISCVException read_scontext(CPURISCVState *env, int csrno,
> > +                                    target_ulong *val)
> > +{
> > +    RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTX=
T);
> > +    if (ret !=3D RISCV_EXCP_NONE) {
> > +        return ret;
> > +    }
> > +
> > +    *val =3D env->scontext;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static RISCVException write_scontext(CPURISCVState *env, int csrno,
> > +                                     target_ulong val)
> > +{
> > +    bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32 ? true : false;
> > +
> > +    RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTX=
T);
> > +    if (ret !=3D RISCV_EXCP_NONE) {
> > +        return ret;
> > +    }
> > +
> > +    /* Spec suggest 16-bit for RV32 and 34-bit for RV64 */
> > +    target_ulong mask =3D rv32 ? SCONTEXT32 : SCONTEXT64;
> > +
> > +    env->scontext =3D val & mask;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >  static RISCVException read_mnscratch(CPURISCVState *env, int csrno,
> >                                       target_ulong *val)
> >  {
> > @@ -5973,6 +6006,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D =
{
> >      [CSR_SIEH]       =3D { "sieh",   aia_smode32, NULL, NULL, rmw_sieh=
 },
> >      [CSR_SIPH]       =3D { "siph",   aia_smode32, NULL, NULL, rmw_siph=
 },
> >
> > +    /* Supervisor-Level Sdtrig CSRs (debug) */
> > +    [CSR_SCONTEXT]   =3D { "scontext", debug, read_scontext, write_sco=
ntext },
> > +
> >      [CSR_HSTATUS]     =3D { "hstatus",     hmode,   read_hstatus, writ=
e_hstatus,
> >                            .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> >      [CSR_HEDELEG]     =3D { "hedeleg",     hmode,   read_hedeleg, writ=
e_hedeleg,
> > diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> > index 9db4048523..072593ab12 100644
> > --- a/target/riscv/debug.c
> > +++ b/target/riscv/debug.c
> > @@ -1088,4 +1088,5 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
> >      }
> >
> >      env->mcontext =3D 0;
> > +    env->scontext =3D 0;
> >  }
> > --
> > 2.43.0
> >
> >

