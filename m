Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23F1CDE00B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcv0M-0003ub-QM; Thu, 25 Jun 2026 21:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcv0L-0003uK-Gb
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:05:13 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcv0J-0002Jh-Pt
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:05:13 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so830759a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782435910; cv=none;
 d=google.com; s=arc-20260327;
 b=FGOh8V5zJPhuOifr2V9rxvekmnLkG8U+AeAyMJjArdErIuNiM/5KveM2LeoDIOWSwe
 zQrfzrBLCoS5Eg6IhgZxJB4CGjPb8NmSxwSyK5OwHhj3Q9VFFSmjJod+tBbwexB0JfpI
 lKd3TxodJ4keds7YrafkXr5AteAeWCHOQqUcSeEpsaw6ryKyKHzBMkEdmpSlhscwcPrr
 l2IEv9su6PMpN0z0owxuhn6vWeAtArWIAAeq78o5xgZZJRF7l32aFxTS6uF/12CF/2ld
 xJc6u8v1aySCC+An0Hip9+SUIUNoQZYAiOhW1uti5QYV9LliyPzeefNn0BL1T96q96sT
 Fsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vXrGs4zWxmGP3iIBXlLeu0ELJc4kvryidUP/YjP+LbU=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=hjTz+1/yFI+T3OzZLSZ+O97Yt2P2Bj8ond46gwB84AygN+bzbToOvVFYq257mMMzFQ
 mXJ3MGTQqToL0PCiaSix3pO9RtNWqpWMbs1szfuTp51C5m9KzU5X3HmTwjD5VuAOT76x
 UFmmdqEFzg24PS02DW7qD7wcRaAgO20U/yi3Gj9nuE3vYYf8nVLEKj8STv5mXYoMOwYn
 rn+des4iWDvO5sX1+TTgZZkv5bi0fxcR8kpy4/wLUDMGHKzxu6Ka2ioFAWcFia2Je3Q7
 KrDPNEnywCGmaCKpxTz+qp4v94SEt9XqcHlc0DOkUbVzR7Xit8znQRMHZvOUYerhIV7W
 83zA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782435910; x=1783040710; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXrGs4zWxmGP3iIBXlLeu0ELJc4kvryidUP/YjP+LbU=;
 b=Ch+VW3O8ETRkx0HrxpsGT0xMBO1YreS6yTQhIrZ+Zffg/Wh/TWjV7U5vo92m2oc8d/
 ZDXZrLKnxa1P3OJLjWJ5yVTjNORi2VKCXmPu5K4zppyvGEcfSYUxtrKjKTJBoUDwzy0I
 TEId6LgMIG9+jOJKUg1ZLKs+HrG+o0tbC+MCG2qrirAQ9JvxusB1GB+QnP0rMf4M4sqB
 w/Sd7vNQEVwqX3I/s0yzu0dEVw9ATLeXlJAU6l6NadJhdXmOb7rxeHPgM/ppeKuD8Mpq
 3rDYRjXQ4Vjw3AhmAas8KoRmtHUZ2nxp2Nz1/Zr0W69JDTmHs4aUE+IwybawAv+yqWBC
 mdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782435910; x=1783040710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vXrGs4zWxmGP3iIBXlLeu0ELJc4kvryidUP/YjP+LbU=;
 b=CPNvAkNuo4PgdL52Q8JgxJYiEprLxQATmcuopLFD9f7nET5rhN8jqhb9Oli4Fn1/EA
 FgY+jyEqgQMv4SwrfMi5X5dp5xTEaA9DSDOlAVI6GE0PotmHPQ76czckrEErT/3lHScp
 gcdmBB27ze4vcsQiFxhg8GaLj2MgNYPY/dxP4BJYFqPaQh+y89M8gxjg9pqh8gy/Oyz5
 Wb46Vgi4V7Ep3s1Rrs1J6ddebJlU30YZ9hxWkw3pxBFNT6+uJMmyuYozmE6Fa96v4IdM
 N5ujO1AG9NXEeoHZelm2f3cR8s6N3e3joxd2aqdnPxpwFw6bhPPJsEdC+sosQbhTxI0f
 w24w==
X-Gm-Message-State: AOJu0YyyyKTquRPtHKU1MqU38sIGvA+w14bYIP7mMKgw3+iU+kRocQrN
 3iG7yrBOVgLy9i8XMIuUiRxEic1ncMK29eKeBL8zmFxJffPA3kTgtljHG2Jr/hTD2LrWQt1rHT2
 tKohtJmYlIjMLEq4cSLYfubAcgdR3J/M=
X-Gm-Gg: AfdE7cmXF34qFV29cYnxqtrf7f8RAxDGq09P9Amb9wU2DvoPQ6v5I00O5X/IDOPdmdt
 TgpAuoCtdzikZTjQyBRQ/o9VGXBxu5NzHH2Y6BGVM1CGGjnfKjV4qHvri+ocBYMyoxEjJvV9Ube
 zIGMstPP9yjrnI/U7kaaB5pozijr0fhXDT/CmXiZppuIFH+8+OQYG6N1xnShnw5zJjTwocmzSgn
 VIWQfycYhjfTVu5SNOZsfeuof9KI7zlR0mXEE8UWlh2KiWts+A3rFJ7x/9po76/mW07BkAJzNf+
 V3JFjsa0pRQxeRsd5yxlS0s9H2E=
X-Received: by 2002:a05:6402:a29b:10b0:698:1504:e3db with SMTP id
 4fb4d7f45d1cf-6981504e48fmr544336a12.29.1782435910251; Thu, 25 Jun 2026
 18:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-15-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-15-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:04:41 +1000
X-Gm-Features: AVVi8CflFzKOdpfz0-uJ9mdqyR9-xQ925vMRsOUAjCCs9EDcYcxjkfjIen9EBVI
Message-ID: <CAKmqyKMKTZu4oufGM+KLJ8ZktvwPrRPW=ztZJsfm=kd+irDGEA@mail.gmail.com>
Subject: Re: [PATCH v2 14/24] target/riscv: move riscv_cpu_claim_interrupts to
 cpu.c
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
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

On Wed, Jun 24, 2026 at 10:10=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The function is used by hw/intc/ files that KVM cares about like
> riscv_aplic.c.  Move it to cpu.c to be accessible for --disable-tcg
> builds.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c            | 14 ++++++++++++++
>  target/riscv/tcg/cpu_helper.c | 11 -----------
>  2 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 483ac2e0d0..4fc0ee2823 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -566,6 +566,20 @@ target_ulong riscv_new_csr_seed(target_ulong new_val=
ue,
>      return rval;
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +/* Used by lots of folks in hw/intc */
> +int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +    if (env->miclaim & interrupts) {
> +        return -1;
> +    } else {
> +        env->miclaim |=3D interrupts;
> +        return 0;
> +    }
> +}
> +#endif
> +
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.=
c
> index b38f639dae..9237d2129b 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -572,17 +572,6 @@ void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq,=
 bool level)
>      }
>  }
>
> -int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
> -{
> -    CPURISCVState *env =3D &cpu->env;
> -    if (env->miclaim & interrupts) {
> -        return -1;
> -    } else {
> -        env->miclaim |=3D interrupts;
> -        return 0;
> -    }
> -}
> -
>  void riscv_cpu_interrupt(CPURISCVState *env)
>  {
>      uint64_t gein, vsgein =3D 0, vstip =3D 0, irqf =3D 0;
> --
> 2.43.0
>
>

