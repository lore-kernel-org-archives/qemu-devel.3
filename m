Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE106C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 05:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq46k-0004s2-Gl; Thu, 06 Mar 2025 00:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq46i-0004rm-VL; Thu, 06 Mar 2025 00:49:20 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq46h-0008Tk-5T; Thu, 06 Mar 2025 00:49:20 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86929964ed3so243443241.0; 
 Wed, 05 Mar 2025 21:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741240157; x=1741844957; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3rJG0ePzz2XmIZWNCI3Zgw7Yg7x1sbqwnNy4uRAv7M=;
 b=RNH5Gc0bxA6Jpblv6vj8/wtVM+boHH6cSNztdYmflKxbkwrr/xvg5nDBsPg0mLl27Z
 Zbchoz1kuk8UN0qo/hFliwPGZpgvW+gRztxpmp52lDlB6Aqt0ppZCyC4ZUAHxjVk4JII
 LdF9L/dtVQ+nqeqVMV96yuEsrMvK3iPFvDT216/LW0ghLOHnkFfJOK70LKVPF/hEyold
 7Ht6ZNwUqnOhhg56/9/0BC4aKzmy4dQjCJXuyfzZEzQXR0OW+ZeKTsMv9PVoIz7W95wK
 6dS8wDL1CwTjBJYgj9Ei5SCrrBHKM+cbR56TqkRJL3QbLhf7OlsbGv8e4XkzImXxS4pm
 0GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741240157; x=1741844957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3rJG0ePzz2XmIZWNCI3Zgw7Yg7x1sbqwnNy4uRAv7M=;
 b=fV/dR8xO+XfRFmtcmbaHUUM7Q7nv2W3p/i9q825Gweipv+TvPICCqACP2Y6V8LUPU1
 0bxydbxDv0EEs3Q7NGd+InwIpfaouZwy7JMmppxJqMAbbhwOiQ09Amu63Dli0wSIp8kL
 830wUjhwnHRP5tbBs2j4OPL7GVC9VHVkXGpWW4IaC8QDrhq/JZGDlaB5pNORds6zkXX2
 FwQgYezu2jbmIHrVflMFD652rkECxD7FJBaGIwuP7uSvybTi8BW9f+O/M3F0PGZGuAAq
 6pOUsS+oyvMQOXpBfSkF/gawA2H2zVVklsdKDnix39GAhvef/uHKLGvw7WrUaixlylUB
 N09g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcq8V5pITeiZuKN4lFiWKmbPe/Rw6l3EEecGuincF89oi2YNAYNfnWDmjIBvdLa+CMJgvO2V7QL5Ca@nongnu.org
X-Gm-Message-State: AOJu0YyYOu625iyGzaGmzb+xXQOk4DGlAfUfWT96Md6OTsD0MBG4JTho
 Rt/Ux6j4fhQzg4uGNOLrIcyu25ur4d3/UnOiRoRG5nLJpAAt6ElUb1ox9YNbanfxAvoDby63iAO
 29Z9RBrzOHp7P4dppYPpVxA8lhds=
X-Gm-Gg: ASbGncuK36GyoYixs2AtRyIj0ojAwG26Ucao89RsbIUZ9BWCfVFlsVkv5kCNIEjQa8o
 UzMimytjitTiMEaW4k5SgRBw6USl8xKHlHtvVzSo3jf0xYhkWmJWP2BNE1qgycpQM+uKACMHdtj
 X+DF1yF+SbSzJB71d2twgs34lVcMJLb3glqGjVk1q3S2bxz9lCZ/mT+XG3
X-Google-Smtp-Source: AGHT+IE4loaKfS40kOKsfdI5oxl3nsRuGPswH3JdtTiD8obLijizDXn9QLheCFEHjFSbrWrXkvGgs54OhPdSXMsGPh4=
X-Received: by 2002:a05:6102:c46:b0:4c1:9acb:a572 with SMTP id
 ada2fe7eead31-4c2e2969c37mr3660001137.21.1741240157568; Wed, 05 Mar 2025
 21:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20250303093155.35585-1-florian.lugou@provenrun.com>
 <20250303093155.35585-2-florian.lugou@provenrun.com>
In-Reply-To: <20250303093155.35585-2-florian.lugou@provenrun.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 15:48:51 +1000
X-Gm-Features: AQ5f1JrtjtTDx8vY236w4UcdDoSXykMHhtOJ0ilSDjYI92NXnQ9xQ-7SWYAYKS0
Message-ID: <CAKmqyKOhUpLbmj3ob7htaYdmqhZxOn2nJCyoerb=UsuLxECjig@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Add scontext CSR handling
To: Florian Lugou <florian.lugou@provenrun.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Mon, Mar 3, 2025 at 7:39=E2=80=AFPM Florian Lugou
<florian.lugou@provenrun.com> wrote:
>
> scontext size is 16 bits on RV32 and 32 bits on RV64, as recommended by
> version 1.0 2025-02-21 of the debug specification.

Section 5.7.8 indicates the register is XLEN bits wide, with data
being 32-bits wide for both RV32 and RV64.

Alistair

>
> When the Smstateen extension is implemented, accessibility to the
> scontext CSR is controlled by bit 57 of the [mh]stateen0 CSRs.
>
> Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
> ---
>  target/riscv/cpu.h      |  1 +
>  target/riscv/cpu_bits.h |  5 +++++
>  target/riscv/csr.c      | 36 ++++++++++++++++++++++++++++++++++++
>  target/riscv/debug.c    |  1 +
>  4 files changed, 43 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 616c3bdc1c..102e8285a6 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -440,6 +440,7 @@ struct CPUArchState {
>      target_ulong tdata2[RV_MAX_TRIGGERS];
>      target_ulong tdata3[RV_MAX_TRIGGERS];
>      target_ulong mcontext;
> +    target_ulong scontext;
>      struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
>      struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
>      QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index a30317c617..e8997f3153 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -258,6 +258,9 @@
>  /* VS-Level Control transfer records CSRs */
>  #define CSR_VSCTRCTL        0x24e
>
> +/* Supervisor-Level Sdtrig CSRs (debug) */
> +#define CSR_SCONTEXT        0x5a8
> +
>  /* Hpervisor CSRs */
>  #define CSR_HSTATUS         0x600
>  #define CSR_HEDELEG         0x602
> @@ -1103,4 +1106,6 @@ typedef enum CTRType {
>  #define MCONTEXT64                         0x0000000000001FFFULL
>  #define MCONTEXT32_HCONTEXT                0x0000007F
>  #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
> +#define SCONTEXT32                         0x0000FFFF
> +#define SCONTEXT64                         0x00000000FFFFFFFFULL
>  #endif
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 0ebcca4597..37b38f24a6 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3393,6 +3393,10 @@ static RISCVException write_mstateen0(CPURISCVStat=
e *env, int csrno,
>          wr_mask |=3D SMSTATEEN0_P1P13;
>      }
>
> +    if (riscv_cpu_cfg(env)->debug) {
> +        wr_mask |=3D SMSTATEEN0_HSCONTXT;
> +    }
> +
>      if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrin=
d) {
>          wr_mask |=3D SMSTATEEN0_SVSLCT;
>      }
> @@ -5321,6 +5325,35 @@ static RISCVException write_mcontext(CPURISCVState=
 *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException read_scontext(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
> +{
> +    RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT)=
;
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    *val =3D env->scontext;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_scontext(CPURISCVState *env, int csrno,
> +                                     target_ulong val)
> +{
> +    bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32 ? true : false;
> +
> +    RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT)=
;
> +    if (ret !=3D RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    /* Spec suggest 16-bit for RV32 and 34-bit for RV64 */
> +    target_ulong mask =3D rv32 ? SCONTEXT32 : SCONTEXT64;
> +
> +    env->scontext =3D val & mask;
> +    return RISCV_EXCP_NONE;
> +}
> +
>  static RISCVException read_mnscratch(CPURISCVState *env, int csrno,
>                                       target_ulong *val)
>  {
> @@ -5973,6 +6006,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_SIEH]       =3D { "sieh",   aia_smode32, NULL, NULL, rmw_sieh }=
,
>      [CSR_SIPH]       =3D { "siph",   aia_smode32, NULL, NULL, rmw_siph }=
,
>
> +    /* Supervisor-Level Sdtrig CSRs (debug) */
> +    [CSR_SCONTEXT]   =3D { "scontext", debug, read_scontext, write_scont=
ext },
> +
>      [CSR_HSTATUS]     =3D { "hstatus",     hmode,   read_hstatus, write_=
hstatus,
>                            .min_priv_ver =3D PRIV_VERSION_1_12_0         =
       },
>      [CSR_HEDELEG]     =3D { "hedeleg",     hmode,   read_hedeleg, write_=
hedeleg,
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 9db4048523..072593ab12 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -1088,4 +1088,5 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
>      }
>
>      env->mcontext =3D 0;
> +    env->scontext =3D 0;
>  }
> --
> 2.43.0
>
>

