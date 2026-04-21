Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13941F94CB6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 23:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFKRz-0003oB-NJ; Tue, 21 Apr 2026 19:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFKRw-0003nd-9R
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:24:12 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFKRu-0006QJ-Qy
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:24:12 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9c01854477so835931566b.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 16:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776813848; cv=none;
 d=google.com; s=arc-20240605;
 b=NFsqZk4sS0Lr1eUWT4hN2UHvPMd/RvRT9bg/4hjcxhwweQg1xl25vrBruSKO2ux5Wu
 uQoINhnkscYED+0M4EUk///GDvNoO9Po7W/ujL70n7pno+YKPn1YEsscNMPnAboY72iR
 Ka8bIXbmOWnzWO5AuAlvrcPepUfFq29NtEynXhDj0wEJCx7MgX9Vy661we7+LxHhqFQC
 LYsWNpf4MJ5bgeKZjPCxCgA6w/oASgYhD8SeQFAGk/CXKX4I/kWNjVs9x74hajNaWbWd
 LGkzde+hDTg4LlSX1Cc2D6gOKvyKwY2cGFsxeK4EjMRAvOPUFRDKRcS6bAGxoRXsGU6f
 s08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sdeT6Vcg9AVShjDhV2xR/6Hz5472oW6NjV+GJWtaQAE=;
 fh=MTEhYzvJQzMmTBV1GXZoET6L4m83h50PkqH0pC/uKoY=;
 b=OulpBU8x/bwkk1wd59LhfzhH+ssaahyYa/itOWlKrwIoyD7WI4fTxM1M22vO/vmCEL
 5kF4mQOnPIn/QO8cul+AJaZEEil8dgFeMOI0PvPNlowqdn1dGCaVtg/tqFvIH3AM456j
 uarB53dQBjV0yKFCbloQV5dgnA9Kwi+5dVYgGBbOqoDcn3hIjssO7GJB8f7WDKepMdol
 VgD0M4k5NPIBMedbM03/xHHEjluLqK02zj5WhhqO7o4hPvjzVf3YXOpiSfHHOMx6RYn2
 7pN8Nfhj3sxVpL4ei5INPu6xp379+GbElHneX6sMHOjHqhXNzp2t2xzdujlHXCxHedBP
 1Iog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776813848; x=1777418648; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdeT6Vcg9AVShjDhV2xR/6Hz5472oW6NjV+GJWtaQAE=;
 b=IOTCqvK7wAs2Oq4Npl9R19Txf+flyO2TYi0Zl+Rg0xABwd9DElxzbGuQZFUExluYNC
 7Sq2stI/xMw/+9ic92biu00s4XbRHG1av3x7ud+4mq13fc0c60vVaUDuMe3aXDZfdniA
 3oZ2X7H73zvb9rRQiQvdcA2IJfxX1SPm8WKcDlNE5GpeHY3EBchMlFCN7g4uNAotT3Sz
 rBxaS04D9JgYEkpBjjnv3oQRcw/gHnqcV/Q/BM7t8pF8F8l6BknGSztaLvs67oBruy2D
 BBcXygM9oFUm26DPR1JHxN9b9tjJJAf7B/EFA67RNMxhuz/PDcvELh9n7ykRGiDEsNGD
 Xyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776813848; x=1777418648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sdeT6Vcg9AVShjDhV2xR/6Hz5472oW6NjV+GJWtaQAE=;
 b=cSbM89xgC5v980hNrIMxugoXMAUo7fqcU+8hlZZyVhr6rgsQZiSNSLIKnSWKax9P+Q
 dvoJ0nh0ZFVMhoqcuygXjvmBrEfsfyHflkGCFt1cnPM5qUySCYhDq5polpcvxm14m9Gj
 l9fkndWyGqxa4QBB1oi7AlhvkNFtqDT9cGEfPvbZ97eZTkzauZEiRC2qo8WmBPUog751
 5kN1gX+CWezI+jYTNwlKCJBOqoBGygPvlWeN8Oal2ixxXuKLotN6Dbv0gknIiGdrNkyD
 Wd8dBOWGC78W9biwJ2zRAhHPSMZ1rLI/lS8NU4I2T3TOZbvi06TX1rB47vEitGFmDWYK
 x5jw==
X-Gm-Message-State: AOJu0YxL/aEIe8w6tDWQbUd+xTu9lvIJSOXojCjtbDjAP2CzrMFQaoFz
 UsF4V4cHktJ5uxO61S+VAvoOgx/X8tdywLRqLsIGxt5HgSJazeYh3ELVCJegf7t9uRC8TQfqL90
 Zxowy7YUO7dRE6+ArX2VjrXENSNBKz5I=
X-Gm-Gg: AeBDieunTALbkSXSdIT/yxfed35UcuHwFK2p5Yksuya9h1NHR8esT7bbI1vyIEQQV47
 cfFO5UmRSrh7eKFY0JbGiBPwVWN/9lH0udL2ssJlnihhNu5zCpTXTkTbeW55aY8gOj7QGx4XaaJ
 6nT4vdXjcawWNn+vGBu+2A829BKkBomAYlc4OBGFMIjkNvXJKx+VFbMN3U6eADMCoCGsnqE0hJY
 AJ+PqTr67CUqmX4qwR1AqINENIJuaAETS2YwaHFw5espQAmxfgWNY+j4kBYdLN4LOxbbPdUnCjz
 ujXZJ7Z/BXWa795DV+F2Pu/8ib8fmsfFpSnbFc+iaJjI3Ml8
X-Received: by 2002:a17:907:1c10:b0:ba8:7b3:176b with SMTP id
 a640c23a62f3a-ba807b322c2mr229432266b.49.1776813848010; Tue, 21 Apr 2026
 16:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260421074204.2908422-1-frank.chang@sifive.com>
 <20260421074204.2908422-2-frank.chang@sifive.com>
In-Reply-To: <20260421074204.2908422-2-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Apr 2026 09:23:41 +1000
X-Gm-Features: AQROBzDZ39a6_tpEu43dFpeNCo8oer6kIXaUHZg6m4HDnIC_RWc5Jg9e_w1ALW8
Message-ID: <CAKmqyKMq5+LaPe0bThEwCc87y=TAqLVzta5Cvxe887z1v+fR-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Add the implied rule for G extension
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Apr 21, 2026 at 5:43=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Jim Shu <jim.shu@sifive.com>
>
> Add the missing implied rule from G to imafd_zicsr_zifencei.


> riscv_cpu_validate_g() is also removed as imafd_zicsr_zifencei
> can be enabled by the implied rule.

But what if a user enables G and disables one of these implied rules?

Alistair

>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/cpu.c         | 14 +++++++++++-
>  target/riscv/tcg/tcg-cpu.c | 44 --------------------------------------
>  2 files changed, 13 insertions(+), 45 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 72c6f4f0f14..7978b4fad43 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2247,6 +2247,18 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED =3D {
>      },
>  };
>
> +static RISCVCPUImpliedExtsRule RVG_IMPLIED =3D {
> +    .is_misa =3D true,
> +    .ext =3D RVG,
> +    .implied_misa_exts =3D RVI | RVM | RVA | RVF | RVD,
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +        CPU_CFG_OFFSET(ext_zifencei),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZCB_IMPLIED =3D {
>      .ext =3D CPU_CFG_OFFSET(ext_zcb),
>      .implied_multi_exts =3D {
> @@ -2634,7 +2646,7 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED =3D {
>
>  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
> -    &RVM_IMPLIED, &RVV_IMPLIED, NULL
> +    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
>  };
>
>  RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] =3D {
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f3f78088956..840ef82350d 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -532,46 +532,6 @@ static void riscv_cpu_update_named_features(RISCVCPU=
 *cpu)
>      cpu->cfg.ext_ziccrse =3D cpu->cfg.has_priv_1_11;
>  }
>
> -static void riscv_cpu_validate_g(RISCVCPU *cpu)
> -{
> -    const char *warn_msg =3D "RVG mandates disabled extension %s";
> -    uint32_t g_misa_bits[] =3D {RVI, RVM, RVA, RVF, RVD};
> -    bool send_warn =3D cpu_misa_ext_is_user_set(RVG);
> -
> -    for (int i =3D 0; i < ARRAY_SIZE(g_misa_bits); i++) {
> -        uint32_t bit =3D g_misa_bits[i];
> -
> -        if (riscv_has_ext(&cpu->env, bit)) {
> -            continue;
> -        }
> -
> -        if (!cpu_misa_ext_is_user_set(bit)) {
> -            riscv_cpu_write_misa_bit(cpu, bit, true);
> -            continue;
> -        }
> -
> -        if (send_warn) {
> -            warn_report(warn_msg, riscv_get_misa_ext_name(bit));
> -        }
> -    }
> -
> -    if (!cpu->cfg.ext_zicsr) {
> -        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicsr))) {
> -            cpu->cfg.ext_zicsr =3D true;
> -        } else if (send_warn) {
> -            warn_report(warn_msg, "zicsr");
> -        }
> -    }
> -
> -    if (!cpu->cfg.ext_zifencei) {
> -        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zifencei))) {
> -            cpu->cfg.ext_zifencei =3D true;
> -        } else if (send_warn) {
> -            warn_report(warn_msg, "zifencei");
> -        }
> -    }
> -}
> -
>  static void riscv_cpu_validate_b(RISCVCPU *cpu)
>  {
>      const char *warn_msg =3D "RVB mandates disabled extension %s";
> @@ -611,10 +571,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>      CPURISCVState *env =3D &cpu->env;
>      Error *local_err =3D NULL;
>
> -    if (riscv_has_ext(env, RVG)) {
> -        riscv_cpu_validate_g(cpu);
> -    }
> -
>      if (riscv_has_ext(env, RVB)) {
>          riscv_cpu_validate_b(cpu);
>      }
> --
> 2.43.0
>
>

