Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C458EF36B9B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB0RK-0003Vl-FX; Thu, 09 Apr 2026 21:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0RI-0003VT-Pr
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:13:40 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0RG-000705-T5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:13:40 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-66f8f556f39so2073775a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775783611; cv=none;
 d=google.com; s=arc-20240605;
 b=HRNwpLSXZf9GLSEQ5IyI1xlrZJcE0w26jBRMChgYQpl4uixnJaNKXEuQZu//x/bjLr
 Ywc0QgPoJF2Uk4KlEMfhQZ8zKt0x/3qZoDzWo795Ws7USyxVgZLTtiwmqP2SMzA+/fz6
 hW/rHSnsUss6Ym43JP4YkI4qBQ4kLTmjdZaMTT15sx6NwkgpQuOW6wDiocrdg0HfOZzn
 sVA+yke2Jx3DXukeM0JGgowtgoTzXQW8hTq0PNrzHpDZCIoY8BN0QyoA98ACGILIUag7
 QxYASShV559DFA+aIUx/57MCPtpAlUexkJID3XtlYBSMumlaO6YZfHNTjP+7I3D93Xpn
 ncQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XqUd/qrKeKF7MWtNKvhX+CsNzfQeCQ4VlflP/ZZVFlE=;
 fh=yA45nsw3/GlmR4yv0X4Y623/LexEZcgSQA1vCu7Dy/k=;
 b=XlA6Idtx4ePpm62u+N32no26QSgUPVG8hmFvuhlIdQNMTWyRHx+EfNn+1WE6bl5vGg
 HwDarhwjxfxeHVHmbPsw5wUET4K9p45rH6cmsloSVsFcEfCb0DyTxjczKMHO26igjb01
 lLfgq8ONKNqF8uH5Y+i/0uHv7DLgJey34vYoiMs7OhJSt5dsmZdF5IA83GWQ402PTm8N
 nnDbx9bCTX0hJE3OMj143QaoeOmHrqkOEvxZ7RLDajP19GwlfSiayQS8iTYLB3XA6jdH
 eQXn3iwaRi3KIiq7v1WA3Io7Lilcl3vMkkVHUoapbekbeMd3YVN9Ha1K6R/g22KU72co
 eb7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775783611; x=1776388411; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqUd/qrKeKF7MWtNKvhX+CsNzfQeCQ4VlflP/ZZVFlE=;
 b=SVHnLZNlZoqjG5zBNi7Z+8QRq8zw6Rb0kthWI1Fpa58JY1LkmVXnvPPAWr/tybHmsa
 leUG5QlYmLnJGlnavQ8La+d6RcQzJqnT6peItqSR4MCbtM6cOnhDC86VMdzec3fXbvtg
 kSrgLDxJh/MgTpCtJDXa3ifnGuuKkdMLuuaZv/d+MzL76eSvGs+BLZE6H2rNjIFE64vy
 2qFxr51W7k2PxzN6V/zQ949NxQXH3KHC3wDqH/lMf6XHc4GV4cu32mDkzeJ9Nfhs5Lm7
 sjQmib1FcrKUeDs5dMsF3nXADZZqWHDCkNzG+GTleVXNL9EygwGj8tG8lVESd1XK7dNk
 BkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775783611; x=1776388411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XqUd/qrKeKF7MWtNKvhX+CsNzfQeCQ4VlflP/ZZVFlE=;
 b=aO8DFBL/5eoa23bxo4idqlqXf2TLyw621xZ1xxTk0WdXH+HTSTHfu29mp0AVlzA6fP
 mO92ixAchDXyL0ec9No3/FK7FoTljV+5fTtoSoGtFAoR1fkC5XxSXCUV1bO/dAQAvbze
 EQWckdtbBcaVpYCQuIBwjJjg/ydeUM9x/OrIKHqnw0nOCyDkBl9G+jSwaUY9C0zc0+yG
 aRM2CGtIImytDVXexKEnA0qqL7lIezyyRRS23TYNSqbo0UWCQpRixaA1+/h+0IJOSaLe
 3bZ1gC1SnNpT3KxhLMQpBZGb+LOIVjfO139nRrKjCuotgZqDkvuJIHY5y8AqFnEc5XsH
 G6/g==
X-Gm-Message-State: AOJu0Yyrx6jHNI9x2xlftkpW4FwmVswyuyBXtiktxQ+VcOrzZYLBZXBh
 1ziI1W5NX0I80RMBnIx6tm4GXVEmsIWRWnJcdvQ+w/Xw7pD0+gJ0OrlWWB4O1yy0G+RVJFuha93
 iKPS/6eBNJoKhcvs8htKTi7p/rbG8iTg=
X-Gm-Gg: AeBDiesb6blO45l4OGLF/fSLSXR4cfqKMlxd8l8uUckmVFs0c7EHFpcoyjeIqUACL8D
 gxDb4lwo0YwVoeUNMsSl4aO8ekc46HykMn/dZqSCdLSGFK+4tNEwLaZhIAvPJJch1T7vMIFndlq
 y+gF+nmVHegPXGdMSnnjUW5iabna9r0tgGdKi4n0ankIUCd+l98n3cJsfUNRA65xr5qr27ZrkmP
 gzdy5YoIgtYJGr2zWutxtxKQTYsA+XT1tRmCFpNgbP9uxf499jLIri/b+Z4AorGo0zSoB5B8beu
 keCeJ4TA/Qbw+L22EJoMY+Xj+r3C2chGSFjuRQ==
X-Received: by 2002:a17:907:94d3:b0:b98:9da:4d94 with SMTP id
 a640c23a62f3a-b9d72ada081mr72793466b.48.1775783611103; Thu, 09 Apr 2026
 18:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
 <20260409155344.2849233-3-bruno.vilaca.sa@gmail.com>
In-Reply-To: <20260409155344.2849233-3-bruno.vilaca.sa@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 11:13:03 +1000
X-Gm-Features: AQROBzAHibk46k_F1a2HJF-1kynf5p4fUtsSm6Vr4pKMwH7FJuzTmohBJ4Mt31s
Message-ID: <CAKmqyKOhxsv5EOK7+t4+cM_QUHXtdqVJG1urkwYofuZfymPXxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: fix RV32 stateen CSR handling
To: Bruno Sa <bruno.vilaca.sa@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
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

On Fri, Apr 10, 2026 at 3:27=E2=80=AFAM Bruno Sa <bruno.vilaca.sa@gmail.com=
> wrote:
>
> The RV32 stateen CSRs are split between the low-half CSR and the
> corresponding xH CSR, but the current implementation still handles some
> upper-half bits through the low-half write paths and also accepts the
> xH CSRs on RV64.
>
> Fix this by:
> - rejecting mstateen*h and hstateen*h accesses on RV64
> - keeping the RV64-only writable bits in the low-half write paths
> - handling the RV32 upper-half writable bits in write_mstateen0h() and
>   write_hstateen0h()
> - dropping unsupported writable bits from write_sstateen0()
>
> Signed-off-by: Bruno Sa <bruno.vilaca.sa@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 112 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 77 insertions(+), 35 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d322bdbd47..015deca6dc 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -497,6 +497,15 @@ static RISCVException mstateen(CPURISCVState *env, i=
nt csrno)
>      return any(env, csrno);
>  }
>
> +static RISCVException mstateen_32(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return mstateen(env, csrno);
> +}
> +
>  static RISCVException hstateen_pred(CPURISCVState *env, int csrno, int b=
ase)
>  {
>      if (!riscv_cpu_cfg(env)->ext_smstateen) {
> @@ -528,6 +537,10 @@ static RISCVException hstateen(CPURISCVState *env, i=
nt csrno)
>
>  static RISCVException hstateenh(CPURISCVState *env, int csrno)
>  {
> +    if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
>      return hstateen_pred(env, csrno, CSR_HSTATEEN0H);
>  }
>
> @@ -3403,25 +3416,27 @@ static RISCVException write_mstateen0(CPURISCVSta=
te *env, int csrno,
>          wr_mask |=3D SMSTATEEN0_FCSR;
>      }
>
> -    if (env->priv_ver >=3D PRIV_VERSION_1_13_0) {
> -        wr_mask |=3D SMSTATEEN0_P1P13;
> -    }
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> +        if (env->priv_ver >=3D PRIV_VERSION_1_13_0) {
> +            wr_mask |=3D SMSTATEEN0_P1P13;
> +        }
>
> -    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrin=
d) {
> -        wr_mask |=3D SMSTATEEN0_SVSLCT;
> -    }
> +        if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smc=
srind) {
> +            wr_mask |=3D SMSTATEEN0_SVSLCT;
> +        }
>
> -    /*
> -     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if I=
MSIC is
> -     * implemented. However, that information is with MachineState and w=
e can't
> -     * figure that out in csr.c. Just enable if Smaia is available.
> -     */
> -    if (riscv_cpu_cfg(env)->ext_smaia) {
> -        wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> -    }
> +        /*
> +         * As per the AIA specification, SMSTATEEN0_IMSIC is valid only =
if IMSIC is
> +         * implemented. However, that information is with MachineState a=
nd we can't
> +         * figure that out in csr.c. Just enable if Smaia is available.
> +         */
> +        if (riscv_cpu_cfg(env)->ext_smaia) {
> +            wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> +        }
>
> -    if (riscv_cpu_cfg(env)->ext_ssctr) {
> -        wr_mask |=3D SMSTATEEN0_CTR;
> +        if (riscv_cpu_cfg(env)->ext_ssctr) {
> +            wr_mask |=3D SMSTATEEN0_CTR;
> +        }
>      }
>
>      return write_mstateen(env, csrno, wr_mask, new_val);
> @@ -3463,6 +3478,19 @@ static RISCVException write_mstateen0h(CPURISCVSta=
te *env, int csrno,
>          wr_mask |=3D SMSTATEEN0_P1P13;
>      }
>
> +    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrin=
d) {
> +        wr_mask |=3D SMSTATEEN0_SVSLCT;
> +    }
> +
> +    /*
> +     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if I=
MSIC is
> +     * implemented. However, that information is with MachineState and w=
e can't
> +     * figure that out in csr.c. Just enable if Smaia is available.
> +     */
> +    if (riscv_cpu_cfg(env)->ext_smaia) {
> +        wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> +    }
> +
>      if (riscv_cpu_cfg(env)->ext_ssctr) {
>          wr_mask |=3D SMSTATEEN0_CTR;
>      }
> @@ -3507,22 +3535,23 @@ static RISCVException write_hstateen0(CPURISCVSta=
te *env, int csrno,
>      if (!riscv_has_ext(env, RVF)) {
>          wr_mask |=3D SMSTATEEN0_FCSR;
>      }
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> +        if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_ssc=
srind) {
> +            wr_mask |=3D SMSTATEEN0_SVSLCT;
> +        }
>
> -    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrin=
d) {
> -        wr_mask |=3D SMSTATEEN0_SVSLCT;
> -    }
> -
> -    /*
> -     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if I=
MSIC is
> -     * implemented. However, that information is with MachineState and w=
e can't
> -     * figure that out in csr.c. Just enable if Ssaia is available.
> -     */
> -    if (riscv_cpu_cfg(env)->ext_ssaia) {
> -        wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> -    }
> +        /*
> +         * As per the AIA specification, SMSTATEEN0_IMSIC is valid only =
if IMSIC is
> +         * implemented. However, that information is with MachineState a=
nd we can't
> +         * figure that out in csr.c. Just enable if Ssaia is available.
> +         */
> +        if (riscv_cpu_cfg(env)->ext_ssaia) {
> +            wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> +        }
>
> -    if (riscv_cpu_cfg(env)->ext_ssctr) {
> -        wr_mask |=3D SMSTATEEN0_CTR;
> +        if (riscv_cpu_cfg(env)->ext_ssctr) {
> +            wr_mask |=3D SMSTATEEN0_CTR;
> +        }
>      }
>
>      return write_hstateen(env, csrno, wr_mask, new_val);
> @@ -3564,6 +3593,19 @@ static RISCVException write_hstateen0h(CPURISCVSta=
te *env, int csrno,
>  {
>      uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>
> +    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrin=
d) {
> +        wr_mask |=3D SMSTATEEN0_SVSLCT;
> +    }
> +
> +    /*
> +     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if I=
MSIC is
> +     * implemented. However, that information is with MachineState and w=
e can't
> +     * figure that out in csr.c. Just enable if Ssaia is available.
> +     */
> +    if (riscv_cpu_cfg(env)->ext_ssaia) {
> +        wr_mask |=3D (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
> +    }
> +
>      if (riscv_cpu_cfg(env)->ext_ssctr) {
>          wr_mask |=3D SMSTATEEN0_CTR;
>      }
> @@ -3613,7 +3655,7 @@ static RISCVException write_sstateen(CPURISCVState =
*env, int csrno,
>  static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
>                                        target_ulong new_val)
>  {
> -    uint64_t wr_mask =3D SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
> +    uint64_t wr_mask =3D 0;
>
>      if (!riscv_has_ext(env, RVF)) {
>          wr_mask |=3D SMSTATEEN0_FCSR;
> @@ -5861,25 +5903,25 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D =
{
>      /* Smstateen extension CSRs */
>      [CSR_MSTATEEN0] =3D { "mstateen0", mstateen, read_mstateen, write_ms=
tateen0,
>                          .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> -    [CSR_MSTATEEN0H] =3D { "mstateen0h", mstateen, read_mstateenh,
> +    [CSR_MSTATEEN0H] =3D { "mstateen0h", mstateen_32, read_mstateenh,
>                            write_mstateen0h,
>                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
>      [CSR_MSTATEEN1] =3D { "mstateen1", mstateen, read_mstateen,
>                          write_mstateen_1_3,
>                          .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> -    [CSR_MSTATEEN1H] =3D { "mstateen1h", mstateen, read_mstateenh,
> +    [CSR_MSTATEEN1H] =3D { "mstateen1h", mstateen_32, read_mstateenh,
>                           write_mstateenh_1_3,
>                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
>      [CSR_MSTATEEN2] =3D { "mstateen2", mstateen, read_mstateen,
>                          write_mstateen_1_3,
>                          .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> -    [CSR_MSTATEEN2H] =3D { "mstateen2h", mstateen, read_mstateenh,
> +    [CSR_MSTATEEN2H] =3D { "mstateen2h", mstateen_32, read_mstateenh,
>                           write_mstateenh_1_3,
>                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
>      [CSR_MSTATEEN3] =3D { "mstateen3", mstateen, read_mstateen,
>                          write_mstateen_1_3,
>                          .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> -    [CSR_MSTATEEN3H] =3D { "mstateen3h", mstateen, read_mstateenh,
> +    [CSR_MSTATEEN3H] =3D { "mstateen3h", mstateen_32, read_mstateenh,
>                           write_mstateenh_1_3,
>                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
>      [CSR_HSTATEEN0] =3D { "hstateen0", hstateen, read_hstateen, write_hs=
tateen0,
> --
> 2.43.0
>
>

