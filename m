Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06318CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 03:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBcO-0006dR-IA; Mon, 18 May 2026 23:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBcM-0006Xz-Op
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:59:42 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBcK-00081J-VL
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:59:42 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67be871ed3fso7037554a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 20:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779163179; cv=none;
 d=google.com; s=arc-20240605;
 b=el1x7q+5Mo2JTzSeSu6wJcC3Vqweu/TGmfkjc64S88Fmomx/vKDkhcit76FgKgivvo
 ms9oqkwN/dIu8ldVDfNgdOUYoqsWYMjDVAzwvoD9cr3tBBzZlzwKHKUSfrjBcr2dAjYx
 aeIpfCZ2JRniSnx49nVid3xovSOFaOI+VUFXJ6ZJKm4WosRfGkHUcNg93t43YpCQDvJV
 CeguGkd2yQ8+8pcKwIxa9LSxZqXIQ5K71D72wiAdzu8+wQhBKR9ECXmLzeDEWmzBUvng
 TXYP5+e0nSNCGRP3v0wZKEq/QI1shdU8poErl8QG8MpJJtRovZS+AItjhCOnhoMhnE22
 /spA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1XlpxuP36fWzHsVf26UQYF9pQjtD2oCrSA/780+hgk8=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=Obr0kkRFqyUEOd+pSYuExsnurE3mCZBQAUVRr/AygXcwu08jnLyMYfMwXLLLL0EoZg
 3nOf+WzSYhgNm9P+5pwsw+7BI+FHtUFGG872skbhDz93u3r9WJ1es/ZMlA5jAAp9lChS
 yoEOivV9KK2IFvGTG5puou2EcaIGfwBhXVD8fR9/ZnlasTsjX+u/SUG0041Ntnehj3E2
 JMSTlAbvDwHcIBGvwRzLGk1ofmEjbemeE4Pg93Snj3JLRLCQzA4m/HbnVAj1NR8tffVf
 x8wDLI4E3HtyisFQyY3kbiM5hgoi3bA5jFcDELcs+ohtE1RSLE/i+ah9xxBJlpJeBg+f
 EG1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779163179; x=1779767979; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XlpxuP36fWzHsVf26UQYF9pQjtD2oCrSA/780+hgk8=;
 b=TU/npO7N4E6miRTxJDKOc376mINxNpuzI5meQug3mXiuEOTZVe2q43e3Rdy6imtaoY
 mvzKmFAQQWA33bkSC6JCUIUXIEjrw8bKqAI6Djy82dj0otz7RjhbWuuSeH7kOZn67VKT
 ESabZmqEAHpfgw+i5v5/itbnA+Xm7gYdcryUndI56pGayHdwmJPMwehTgORYo8TwSq3Z
 JzpBwPI8sryYeh/AoNjH2iidtD0SY3l1HhfCLK+2XcXcrZKUAcHF91ERSvrVlU/aonSJ
 1MQU5+l00y3U81uPY2jOojjpk14amaXGZ3zQbS1NoD3nE0vulestgQAXUelSm4PkgZIg
 /zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163179; x=1779767979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1XlpxuP36fWzHsVf26UQYF9pQjtD2oCrSA/780+hgk8=;
 b=qm9RPgyISXPf4rveaodSwAGwMnpCSAeGpOkKObRROmOV+MpidOTdieHmLqj+LfRmLe
 uJMIchPCa9GpkoRnapfpDaaGf0Oe3Uhmm+2gOVbySWZ99X71Za16rLLYxzCF6D01bgqA
 39W+JqXIEvkM6olc3KLjuiVfRq+aeTfJV85qMPU1zHfRkyytGAVYxsRSKU1NXyd8JbPj
 h42cnvFCpkzaR8y19UmeJqW7q/Kd/PR3pQAn5UHnQOVWW9+lEB9hQmKexJiFHPQp+bf+
 E8q8cg9ndDZRw0PvDVSycuFd1do0hFXOktHyL7QxX/aSXU3H0s9WxTWc4bEETme3KsxB
 hapQ==
X-Gm-Message-State: AOJu0YzHMvZaHsZm3MetVzvFm9Gq9U3DiVbRV4Ml+PvlPNgjryrxqgaS
 iofGwNyrwS94foDyeYoVLvhu4IDwj22wlb9w1mbrmvocY0+0E+peo+S4UNXv2nWujNQt4z3pznq
 0ChI/D1oqgDHkVfc3bEORIuASWjbapPA=
X-Gm-Gg: Acq92OGPqgbDW+8Mu2ZuSrIY5dos/svYJkR53f4o/X3p4jJq8cw67App3e9JAOxP9fA
 hzDg2d1pquG718mMpEEr0JzImSHejBtC7gVixah0/h/6w5MUFty6aTe7Pv437vAqTcyFWTzkyIH
 RCQzSUpOblJFEicx6i2VRKEovwMFSQyRXDCvHxoRRbQRMc1eW3hKv6p4NoHGEJ14zpM8e7djjOj
 FqvqcrZUoXqgFW+kT1i2AW9aLKqmMKLwTTVX33iZMjq7ClgAPtrF8qwGRRt1zIzFFh/RVrvHvAK
 yvm2e3XBYX8BoqBFxQnys2QwgqlThN59OIGlqw==
X-Received: by 2002:a17:907:a807:b0:bd4:f854:27b5 with SMTP id
 a640c23a62f3a-bd5177da46bmr1091788266b.9.1779163178891; Mon, 18 May 2026
 20:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-7-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-7-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 13:59:12 +1000
X-Gm-Features: AVHnY4KOWHeExzQIyBCMiODTQfFqvZqjLJuk6IQkYFHk8mZCTkajJx8Ot4dqhWo
Message-ID: <CAKmqyKOvYUhCNa705mex69_Jw4f_Xc0+XSJ7TZYgKe-HcHaCTQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] target/riscv/cpu.c: remove
 riscv_cpu_enable_named_feat()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Tue, May 12, 2026 at 1:31=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Deprecate riscv_cpu_enable_named_feat() by creating implied rules for
> 'sha' and 'ssstateen'.  'zic64' is always true given that our default
> block size is set to 64.
>
> With this change we homogeneize extension handling when enabling
> profiles.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 25 ++++++++++++++++++++++--
>  target/riscv/tcg/tcg-cpu.c | 40 --------------------------------------
>  2 files changed, 23 insertions(+), 42 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 42555cb28f..047f81b163 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2595,6 +2595,17 @@ static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED =3D {
>      },
>  };
>
> +static RISCVCPUImpliedExtsRule SHA_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_sha),
> +    .implied_misa_exts =3D RVH,
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_smstateen),
> +        CPU_CFG_OFFSET(ext_ssstateen),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule SSCFG_IMPLIED =3D {
>      .ext =3D CPU_CFG_OFFSET(ext_ssccfg),
>      .implied_multi_exts =3D {
> @@ -2643,6 +2654,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED =3D {
>      },
>  };
>
> +static RISCVCPUImpliedExtsRule SSSTATEEN_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_ssstateen),
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_smstateen),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED =3D {
>      .ext =3D CPU_CFG_OFFSET(ext_zvfbfa),
>      .implied_multi_exts =3D {
> @@ -2669,8 +2689,9 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_ru=
les[] =3D {
>      &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
>      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
>      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
> -    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
> -    &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
> +    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
> +    &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
> +    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
>      NULL
>  };
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 704105d3df..c3e354b0ae 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -322,42 +322,6 @@ static const char *cpu_cfg_ext_get_name(uint32_t ext=
_offset)
>      g_assert_not_reached();
>  }
>
> -static bool cpu_cfg_offset_is_named_feat(uint32_t ext_offset)
> -{
> -    const RISCVCPUMultiExtConfig *feat;
> -
> -    for (feat =3D riscv_cpu_named_features; feat->name !=3D NULL; feat++=
) {
> -        if (feat->offset =3D=3D ext_offset) {
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_off=
set)
> -{
> -     /*
> -      * All other named features are already enabled
> -      * in riscv_tcg_cpu_instance_init().
> -      */
> -    switch (feat_offset) {
> -    case CPU_CFG_OFFSET(ext_zic64b):
> -        cpu->cfg.cbom_blocksize =3D 64;
> -        cpu->cfg.cbop_blocksize =3D 64;
> -        cpu->cfg.cboz_blocksize =3D 64;
> -        break;
> -    case CPU_CFG_OFFSET(ext_sha):
> -        if (!cpu_misa_ext_is_user_set(RVH)) {
> -            riscv_cpu_write_misa_bit(cpu, RVH, true);
> -        }
> -        /* fallthrough */
> -    case CPU_CFG_OFFSET(ext_ssstateen):
> -        cpu->cfg.ext_smstateen =3D true;
> -        break;
> -    }
> -}
> -
>  static void cpu_bump_multi_ext_priv_ver(CPURISCVState *env,
>                                          uint32_t ext_offset)
>  {
> @@ -1327,10 +1291,6 @@ static void riscv_cpu_set_profile(RISCVCPU *cpu,
>          ext_offset =3D profile->ext_offsets[i];
>
>          if (profile->enabled) {
> -            if (cpu_cfg_offset_is_named_feat(ext_offset)) {
> -                riscv_cpu_enable_named_feat(cpu, ext_offset);
> -            }
> -
>              cpu_bump_multi_ext_priv_ver(&cpu->env, ext_offset);
>          }
>
> --
> 2.43.0
>
>

