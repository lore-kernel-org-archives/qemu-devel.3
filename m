Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73972CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 00:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUZC5-0003KY-Bs; Tue, 02 Jun 2026 20:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZC3-0003JQ-1F
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:10:47 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZC1-0004Gp-Av
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:10:46 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bec43ee8ff0so17384966b.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 17:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780445442; cv=none;
 d=google.com; s=arc-20240605;
 b=AUcxsTEL+92nTyD+ShrSCzDuqrTAPyfYd9bHQCtAzdA0gAOS3sieJ0ec5lJQ8KpXtH
 s1jbcU/FXuTJTlK1KBeaAcniL/vDo4XfXsPq4ZxP+W3cp4qyPEp3LGHJBo0ELkDohJmc
 1/ohiI58M72EcITOhqCUp0EeGdwvQkp61P3pnuIP0c7nd3VnsXrT/kZTNRyampO+1uP3
 MTm4/XsDVDpAXZMuA7A3i7RzLVxDWSHmiaktjQzq3eCIBc8w6rxihE6YKKsZEkYfw/zv
 5pf26RCXIOGXBKWREEfan3G3e8WmIkj8NHdqY7jt8VFGGc2ZYYTFDwT/j3ULz8Zekq48
 9YJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8RNs3Geg9Evb46SwG0cfcJx1uI5S3ioc7GbaugYW6ws=;
 fh=MTEhYzvJQzMmTBV1GXZoET6L4m83h50PkqH0pC/uKoY=;
 b=fuJZWoBUcv2Xcz7u3aISXv4TvYS1G8cJPju/DUzJy5IoydtOUwsQgcRClCgZVz2NV/
 LNtNS2nhL0RrniSjeRhQLzGKkum1mJvt1FH/9kMEIbZt0cOkererU55A9qIMxKFEnCT4
 DqXYoUm6bcb5Tq1S3oAVI43CqzedK1YG5DOARVqzFg7bh1oih0GsivnmF3Uk4XTf9oCT
 6U/mXwtIyCafLQHsi+ZLEqclPNa1ET8ysw9Gn9QoKvg3VRxvZJ7DzFESIf68R/ugwlZG
 s3EnUHYs2FMBSZDMuA+WgtlKldVGO5sQcR+LE3M1XU1kIS+scCOiZ9rd16Jfg2PRj/yY
 0xig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780445442; x=1781050242; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RNs3Geg9Evb46SwG0cfcJx1uI5S3ioc7GbaugYW6ws=;
 b=pX0hLqcwszu/YPtQ3ZaLG5gz4kca4cM/orctN3kEJK2fuyfyL8R6MECvMFB+TjZxb8
 IeJtoyYJxOguT05xRVmUJgElclM+Ou+zzCNTgAzglJvDLk1aPST4zlB22CIqF9jvKU9b
 n3vuGyyI7ApheshQEGsAPbm++GElmjQmwkFtQbQ8fDBYeVVsWRstcSsm6PqoiPC9Xg9W
 JHkFZFhZmeN16dxVScTF1EGLX2pzKnNSOET/vegJVhPjq0d7/+TUdznc+FhnHSK+wMAu
 B0Gp1s6WEaFtz88A7MGXrkcrPmeVXfq73fDQfeeFXPypl+DnpGoHJ6phuveBi280HDsu
 XE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780445442; x=1781050242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8RNs3Geg9Evb46SwG0cfcJx1uI5S3ioc7GbaugYW6ws=;
 b=m6IEOZLYadMCag7ZoSb4GjrqDjC84JZYsN1IXjLH/JfF//yAUrFKiI8Vy5qQmsa6+O
 9KdikxEtmAhNICAwO86R9tj37pPk2SXSGFj7HtCihnf/YeyxxWzZMfB7EciBIuKlsiKY
 Uc7N2+ZKrXPx9vzDOOJN5u//K1Ea+Nn9bGxXB//sEClvP3AeCZmYOlBFSrAKHhTKWEZi
 XL6YS+gdcEGDZsmyJnvwDMsBz6Rif0RO02ze4jRJarvRhK4I6Qdi1WcjsjXW6yhRFLjd
 mtc8XfbbWXGacOgKs1xWvwoxtmTAcIPJwCaRqtUp+ePcBm3YEYl+gpyf2Cb/tVRfM0sf
 8auQ==
X-Gm-Message-State: AOJu0YwK0UWQnj0gz1Wk3RThXoc1Vm17uaT/dW4tIZEMMiLWtC25p1wO
 VadwaaMdhi/SiMpP7VOinSTOVgaikYwuRe0bOBefPiZz/MdlYVinQQ/xF1r9ksAG/+IIH0FpM3z
 TX27JCg0JHEgQBuMHXOQIY6PQsoXd4Hk=
X-Gm-Gg: Acq92OGMcXW5Fr9xCQgyDaLcE0fXgDV3DQnfKCZ0NvzDKcGKCa2GC58BQJm5W59VRcI
 HxodAUxqRefxyY7XXFNlOirPE3AqzEQswMSXOXqHUqf3yWzw5hF9lKZg4OaeRhX/PQCZ58B12HZ
 YU9+/EUDXOBucNYTcC0EGqy4kJ84gzx3QrfhvM7SEj3IuqgFoijic6Zm4v8HWqwvp8MRMhNPNJM
 +aSyxQNTaihJDDKppGpPIDRXFPiQdt1TGd7PwyTagh4yFAoxy3cYr10Ylw+0b6cVwUKzfPHVyOu
 EC97PD2H/ijT8FbsumfMLxnMBPCeKA5+aaCIh6FXwsHyv64D
X-Received: by 2002:a17:907:3d03:b0:bee:9809:3cd1 with SMTP id
 a640c23a62f3a-bf09ea65288mr31153966b.17.1780445442088; Tue, 02 Jun 2026
 17:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260528054213.678458-1-frank.chang@sifive.com>
 <20260528054213.678458-2-frank.chang@sifive.com>
In-Reply-To: <20260528054213.678458-2-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 10:10:14 +1000
X-Gm-Features: AVHnY4KFeG1gb0X3BBTcYw9c41JURJvlojEU7474Kh-1c-pGOq3Imn_nXRADgUA
Message-ID: <CAKmqyKPUw1CFDW5xh0_Hk8eG6h1wmpUjbKbNzr9Uk1oD8yDamA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/riscv: Add the implied rule for G extension
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

On Thu, May 28, 2026 at 3:43=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Jim Shu <jim.shu@sifive.com>
>
> Add the missing implied rule from G to imafd_zicsr_zifencei.
> We can also remove the auto-enables in riscv_cpu_validate_g() as
> IMAFD, Zicsr, Zifencei extensions can be enabled by the implied rule.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 14 +++++++++++++-
>  target/riscv/tcg/tcg-cpu.c | 21 ++++-----------------
>  2 files changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 952e34fdf55..4246fb87c64 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2094,6 +2094,18 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED =3D {
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
> @@ -2501,7 +2513,7 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED =3D {
>
>  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
> -    &RVM_IMPLIED, &RVV_IMPLIED, NULL
> +    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
>  };
>
>  RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] =3D {
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 7e964e8f1aa..66ac011c54d 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -496,30 +496,17 @@ static void riscv_cpu_validate_g(RISCVCPU *cpu)
>              continue;
>          }
>
> -        if (!cpu_misa_ext_is_user_set(bit)) {
> -            riscv_cpu_write_misa_bit(cpu, bit, true);
> -            continue;
> -        }
> -
>          if (send_warn) {
>              warn_report(warn_msg, riscv_get_misa_ext_name(bit));
>          }
>      }
>
> -    if (!cpu->cfg.ext_zicsr) {
> -        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicsr))) {
> -            cpu->cfg.ext_zicsr =3D true;
> -        } else if (send_warn) {
> -            warn_report(warn_msg, "zicsr");
> -        }
> +    if (!cpu->cfg.ext_zicsr && send_warn) {
> +        warn_report(warn_msg, "zicsr");
>      }
>
> -    if (!cpu->cfg.ext_zifencei) {
> -        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zifencei))) {
> -            cpu->cfg.ext_zifencei =3D true;
> -        } else if (send_warn) {
> -            warn_report(warn_msg, "zifencei");
> -        }
> +    if (!cpu->cfg.ext_zifencei && send_warn) {
> +        warn_report(warn_msg, "zifencei");
>      }
>  }
>
> --
> 2.43.0
>
>

