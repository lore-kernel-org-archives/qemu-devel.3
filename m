Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F600C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 00:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgXXK-0000jd-GH; Sun, 05 Jul 2026 20:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXXJ-0000f9-74
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:50:13 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXXH-0005qt-E9
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:50:12 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-698ab9aae16so4146365a12.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 17:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783299010; cv=none;
 d=google.com; s=arc-20260327;
 b=EeKGcyYR5FvWMQqGv7pwVOImOEQCsqQGWcLhCs2zXCBvg3NGo4hIS//xdC+kTyHoOZ
 6XoBTalBduGRmN5HoyI9E1z8TEDEbsr0aHmOV2YYoELi5fyeXOty5XMFGvvPTQyg9O04
 u2w1I0DZn6w+qZBEIW05vliI3nxBsMaQB/zO21qTsWqLO2LqLwXIYoYnL/05bSPfN757
 wyFdZ/BeIXCUl7mgs3FzJ4IAcgM7GY62ypGVnHga7yyxLI1heaGsWHRxeo7aduHZWd6M
 lct/yU1zBhGWc48d5Plfz99l8+R8Gput5GLKb+lYniesqTZwJC/CXdDrzImQNfCr3GmA
 qLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2/v+Kk6CtkIGTkRRylI0LFQlqR1zXlenuT6qZnX6RH4=;
 fh=F2jHHLOhAUdxIpT/mOESKAzlhKPgUW33d0+z1UtXHTg=;
 b=FVu9K4Oc0VOkoty5AB5vsA9cz86FP5iYghFSeZ3OWDiCq6g/Zoyzuer4QIdeFsApFW
 KBt5S7Qo0Cce/WXpsqlgP3s7e3fXFzgSNYmuS4pQqm+F3N0TvdST16bXgkltHODvDzxo
 E0ICjOOgA4EMM86jEL+O6oKb3YIipg0TfKHB64DbPOUrpzuJOrx9xG4QcUkhNw4hgwSL
 cHStaaL0HwkAG/IAtoHIpHgWqDBUxL3fhP5eQQaQ41mEQKGqS+u5RJo1V8YGARWM/4Pw
 5h0pJiSTuUnthnrGPAkiwj+q0hwP6Cz1ZZqpI1uSuk4vFWMYz7U+Tq0Rh59fLL64WF3/
 Zrcg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783299010; x=1783903810; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/v+Kk6CtkIGTkRRylI0LFQlqR1zXlenuT6qZnX6RH4=;
 b=XJ1VAB/PhJQ9p/vupxRkF9Q19mRqWR7317voctgqkwfGvHqRy+iLp55I2cV8chSmsV
 XbRdXRO5WyyDC/Wi4YGH5FOXlEGvQC3T1ndaChhosvcuHssyKi1Fyhe4Yr0/WKWwSNgE
 3H+MIc8H1+IWqFJEXWQv7QhM21QzIijg/yBgc+bKFasHXm48vTxvv2nuW1127z9zLlLC
 piE5SltmCoN9Nn08ClNVGOYm3KKUdvoRDz8xPbC0LBJOnqmkdBexVqgZuv5KFyTGtTRk
 NGwq/rRBzqz5lDgdf/JuSFWP0R1He8Zx1krMjOjrklng1ibapVf42jqaosV09VMBEOB7
 Yv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783299010; x=1783903810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2/v+Kk6CtkIGTkRRylI0LFQlqR1zXlenuT6qZnX6RH4=;
 b=IATOwS503ETFj0fHKq68/+gtzsMZpCViRXzSg+29RmWcQhpy4fHo9DNV3+3hwdNBXf
 +iFryRxDhnfYmdhPQ6AU/BVVcoCazXJWpYi0NIctJ5ztdd3plahZqAbgoYvzBGhJkKai
 GVCn+48PeA4lgb3h4Ii+P35rrvYz1taRCkoarS5EcBC80Ia2jq0xpDQTRN3JYpvjmobj
 vVKwg28G3RanPrUpgf9h1EP7b8f3HAcwGoPnKRh5LeJihj9iNUNK2t/M/70MJeE3jXPC
 vrI35S12A8E+HxZvmrY4SVm5ymgfyH1axDmIXO5tO9oTkJFiaNHRvBUMUd8OmU6X5m3p
 LdMQ==
X-Gm-Message-State: AOJu0YxttJqyFEf20RJyf/0zh5eLnOcFlLGo1OEhjCJU/sw4lPAcGBqn
 ksVTx/TAWvnXJlyXdLUsJFHijytFDXORAqjeiP48wXrxi7vgHzBYLDbWXWtHSpgonnSG41Tbhbb
 OKB1+kqQkpUH1N+0hXv1oiLOEHPZaGEY=
X-Gm-Gg: AfdE7cl3XpAqmFU6VY8WPVCOcqCVtMqdtHkruGzQODjZXBoZ1SGzpbptHJ1uidOOaCn
 1KQ1c8w+IKUeJ27jao/qTaV+TfMM5AOtxMYbNvhd1kJOPk1XYnmJ+a3Z9UDQvXBjkoeLIvchI0a
 j/NF6PWqw084OSCi2pEUKHmjnehdhRw+DCCUaSR8o6yYFljgRIcHAbllB4++eGKd+twW0rMY+Hk
 sm8Xn0jagG+UBcq+k/q0ZVzJGZXFrJKmvKIk74ZVRxItl+aFYxljRajmRM/0Jd/HO2h+dbkhBsJ
 PkWsohtDhSDjMHI1rEjIjpKH3pU=
X-Received: by 2002:a05:6402:51cc:b0:698:3e99:8146 with SMTP id
 4fb4d7f45d1cf-69a1a4c093amr2827856a12.40.1783299009812; Sun, 05 Jul 2026
 17:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
 <20260703180538.3346781-24-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260703180538.3346781-24-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 10:49:42 +1000
X-Gm-Features: AVVi8CdWK6NwF_AaXWsCW1CXhRgJwEpV1EXDv_kWc0XYYVRsEEQDYCa1guvJUio
Message-ID: <CAKmqyKM_2Aw8+cMiDQ_aTcKEVwSdnFzptZ4K2jBLydwHmAJLDQ@mail.gmail.com>
Subject: Re: [PATCH v4 23/24] target/riscv: move
 riscv_cpu_set_aia_ireg_rmw_cb() to riscv_imsic
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Sat, Jul 4, 2026 at 4:10=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> riscv_imsic.c is the only caller.  Having it sitting in the TCG only
> cpu_helper.c gets in the way of --disable-tcg for no good reason.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_imsic.c         | 11 +++++++++++
>  target/riscv/cpu.h            |  3 ---
>  target/riscv/tcg/cpu_helper.c | 10 ----------
>  3 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index ebb55191c7..d6b46cdca2 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -376,6 +376,17 @@ static void riscv_imsic_reset_enter(Object *obj, Res=
etType type)
>      }
>  }
>
> +static void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env,
> +                                          privilege_mode_t priv,
> +                                          aia_ireg_rmw_fn rmw_fn,
> +                                          void *rmw_fn_arg)
> +{
> +    if (priv <=3D PRV_M) {
> +        env->aia_ireg_rmw_cb[priv] =3D rmw_fn;
> +        env->aia_ireg_rmw_cb_arg[priv] =3D rmw_fn_arg;
> +    }
> +}
> +
>  static void riscv_imsic_realize(DeviceState *dev, Error **errp)
>  {
>      RISCVIMSICState *imsic =3D RISCV_IMSIC(dev);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7a4d8abe07..c9dfa7daff 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -680,9 +680,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uin=
t64_t mask,
>  void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
>  void riscv_cpu_interrupt(CPURISCVState *env);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip valu=
e */
> -void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t =
priv,
> -                                   aia_ireg_rmw_fn rmw_fn,
> -                                   void *rmw_fn_arg);
>
>  RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t =
bit);
>  #endif /* !CONFIG_USER_ONLY */
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.=
c
> index 71a96a20ef..07d9222652 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -590,16 +590,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, ui=
nt64_t mask, uint64_t value)
>      return old;
>  }
>
> -void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t =
priv,
> -                                   aia_ireg_rmw_fn rmw_fn,
> -                                   void *rmw_fn_arg)
> -{
> -    if (priv <=3D PRV_M) {
> -        env->aia_ireg_rmw_cb[priv] =3D rmw_fn;
> -        env->aia_ireg_rmw_cb_arg[priv] =3D rmw_fn_arg;
> -    }
> -}
> -
>  static void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask,
>                               bool virt)
>  {
> --
> 2.43.0
>
>

