Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1115EA8554
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 04:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzSep-0008Tf-IQ; Mon, 09 Mar 2026 00:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSeW-0008Ry-Om
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:55:37 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSeU-0006So-CI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:55:35 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9431300833so369421066b.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 21:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773032133; cv=none;
 d=google.com; s=arc-20240605;
 b=NzvLHb4870ROlWSe8cKckTAjsNfffs55pyTuAhrDyMVC2ZmLMVc0p4QU4z+wySyt8q
 0FWugSRIpAf+Pa6SLDO+ZWzuHPqFn1qf8n7U57WwfHXSnrSFcX72SsiIDSMJwtFvHTio
 9T/885NMXWt3ByDoEhBNJ7qU+XgPfoovV71KkcCeB5w7oTr4HFlxsinru3g2vjC7KOb5
 qyt+ERwMt9Vs9p1FGGlaNhlYpjf1s7XGnGK0dIUktMB7pl0usU0Rghral6usrd19wsvb
 1fdnxzAgJe/h8wP5OblLc6X7k7oyagL0i+N4eSQNIlsDvlnIieQFKO+Ap4wcYrIyHn7f
 pwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X8PXbDE/f5J2fv/A3/OvRsGcFVuUt1PRdqssI1rm+3c=;
 fh=6MaOGNVsLtWpl/iOCTF3OUzdeOcD/I/uUp4w5gfgKjI=;
 b=e7mgP4Ypty7RmRSt/D/J0NWKzVQWSBl8QJRcA/x4bIH704OK1d3Pf1VOuQ93M7vlM0
 c6VSXUvtwH9+WsvFnl0h+2VVa47EF1DpzSMoKxW3IYeZLjQVEg8hI8BZI56U5l8o9RLK
 20P3fvR5oUihVlki8WlcCj9FR428oSZMnSRjRWS0ixbWvw6Rk0wdcI1RLl6idFQ4p1eZ
 apEzXaUJhu3EOApzVi3FFzXX2ZhZHyVu0LaeZSCDVBwW4eV4fuvvt6/tpZ35C32PKswY
 ce0e6dwqzRaw0CPAstM0kIZGQCIHi3VQGJX/Kxvu4LngH+5cNbM2mrHb0WJCkLQa/wLA
 Xo3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773032133; x=1773636933; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8PXbDE/f5J2fv/A3/OvRsGcFVuUt1PRdqssI1rm+3c=;
 b=DYyh7BNwsEp5VIpOO93T+Xvr81gDge97GYkYAmW2lyXHsIzZRixTP+AEak/VZf0ntQ
 J3z31ZFGxJguGTwl4gV04B86gVpu9jM+SHPsTPz+KBFh/xyehvuWIz25lQER7Vs8uP+t
 Lexz0L8JsHdZDaFV58y4SQow4l/9uNIi/FIvIMtiOuvClIm4R1DKT3PI4GIT7uiS2O8e
 iIMyp/hKdN9aLWjvVVAb8Um43Yf8q9ZlbM+T1U4oI7mAzdL9ovxq2nvtNpQsUOKCYbK+
 qpH4Ou8JlxyetfcL66VxgGKDelEq7cpGcEtM6063sCJBoBo/e8TAYqjTueIukXiJQOq+
 X2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773032133; x=1773636933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X8PXbDE/f5J2fv/A3/OvRsGcFVuUt1PRdqssI1rm+3c=;
 b=dkd1uEE31R3KOjTGWrBIobr2IIRpMYUX1+kMTc83IRHt5LAP8YfdvlJ5MR3yoLThCJ
 T4lHirtT6iBJwztdn2ZWYzSTlvxqgW3+w+EvAZDAFZ5cRZfZRDY2vccmKj27TWRnm6cU
 7dDzOGn7uG1SSiqC3ARvofe+JH0xP/DJPY+2IeUYH+2ub5pZB9B0Uc4XCoiPe/tLLp7M
 u6WmXQaTeOf7N801GkQa7yjHoMZ/X6mVBE7UfO0rmdsvbUy35ODaCfb8ugPy8GiWrE9K
 C/gOMkHIeat313TGDFiTpJ0EGDK41F4L58auRceaEMMcSgngiOov9qFP5J4LRrv8VMrG
 f5Xw==
X-Gm-Message-State: AOJu0YyzU8a5RA0kwHKykU2bFt4MA1JxK58ab2Yh81Com5K1Go3+3iOP
 L61JIDwsSpuG3+5mY6ePMZGSGgCcQ7/p8L8QWDh/VQxRAsDGvdKiXrE8++3eTCvGGjet/jnMeea
 8FHKgjSlsLDJBF3pHxNz6fU+NQtJ1gE4=
X-Gm-Gg: ATEYQzyqK54H3bIkObgtUM4MmH3f3yDS85okZCueoqA2lx7ckqgX/Q9uBI35WdgAosO
 iCw57dwM55DIWAzkim8L7HuooOJn8TpljlsYVPcnmJJqv9TNvHGHF9N1xloAq98ycJBV/i/HDhB
 0BKxpnE97t4WrS6XFbQZdgqb6XwD9muS/QGkThEMTvFCsBqHvrIAHJHU7C83RTl9/tWi2xGGSAW
 7701OEFN4L/jSj5qjE9HXi0dO41TOymVYxz+wf5KNY1JAmWlu/tIRVg6D2O/EBVTF7+vUqgqgjB
 09C8jK5w2TgQARzzqRPY+5+3kkT/yPMqp6bn9Q==
X-Received: by 2002:a17:907:94d4:b0:b94:cfd:f37b with SMTP id
 a640c23a62f3a-b942dfbd50emr492724466b.45.1773032132467; Sun, 08 Mar 2026
 21:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <20260306071105.3328365-4-max.chou@sifive.com>
In-Reply-To: <20260306071105.3328365-4-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Mar 2026 14:55:06 +1000
X-Gm-Features: AaiRm52p3kL1LnsPLIsPUHVM7AaFNSSWKz0wSqL2ECu7qMdSCObxsNWK9tskDt0
Message-ID: <CAKmqyKN2ka35Qd2Zf8vbh8t7m+hmgdPY-tZQyGYOc97Gm648Rg@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] target/riscv: rvv: Add new VTYPE CSR field - altfmt
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
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

On Fri, Mar 6, 2026 at 5:13=E2=80=AFPM Max Chou <max.chou@sifive.com> wrote=
:
>
> According to the Zvfbfa ISA spec v0.1, the vtype CSR adds a new field:
> altfmt for BF16 support.
> This update changes the layout of the vtype CSR fields.
>
> - Removed VEDIV field (bits 8-9) since EDIV extension is not planned to
>   be part of the base V extension
> - Added ALTFMT field at bit 8
> - Changed RESERVED field to start from bit 9 instead of bit 10
>
> When Zvfbfa is disabled, bits 8+ are treated as reserved (preserving
> existing behavior for altfmt bit). When Zvfbfa is enabled, only bits 9+
> are reserved.
>
> Reference:
> - https://github.com/riscvarchive/riscv-v-spec/blob/master/ediv.adoc
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h           |  4 ++--
>  target/riscv/vector_helper.c | 39 +++++++++++++++++++++++++++++++-----
>  2 files changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 35d1f6362c..962cc45073 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -191,8 +191,8 @@ FIELD(VTYPE, VLMUL, 0, 3)
>  FIELD(VTYPE, VSEW, 3, 3)
>  FIELD(VTYPE, VTA, 6, 1)
>  FIELD(VTYPE, VMA, 7, 1)
> -FIELD(VTYPE, VEDIV, 8, 2)
> -FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
> +FIELD(VTYPE, ALTFMT, 8, 1)
> +FIELD(VTYPE, RESERVED, 9, sizeof(target_ulong) * 8 - 10)
>
>  typedef struct PMUCTRState {
>      /* Current value of a counter */
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index caa8dd9c12..7575e24084 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -33,6 +33,22 @@
>  #include "vector_internals.h"
>  #include <math.h>
>
> +static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtyp=
e)
> +{
> +    int xlen =3D riscv_cpu_xlen(env);
> +    target_ulong reserved =3D 0;
> +
> +    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
> +        reserved =3D vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> +                                           xlen - 1 - R_VTYPE_RESERVED_S=
HIFT);
> +    } else {
> +        reserved =3D vtype & MAKE_64BIT_MASK(R_VTYPE_ALTFMT_SHIFT,
> +                                           xlen - 1 - R_VTYPE_ALTFMT_SHI=
FT);
> +    }
> +
> +    return reserved;
> +}
> +
>  target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                              target_ulong s2, target_ulong x0)
>  {
> @@ -41,12 +57,10 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, targe=
t_ulong s1,
>      uint64_t vlmul =3D FIELD_EX64(s2, VTYPE, VLMUL);
>      uint8_t vsew =3D FIELD_EX64(s2, VTYPE, VSEW);
>      uint16_t sew =3D 8 << vsew;
> -    uint8_t ediv =3D FIELD_EX64(s2, VTYPE, VEDIV);
> +    uint8_t altfmt =3D FIELD_EX64(s2, VTYPE, ALTFMT);
> +    bool ill_altfmt =3D true;
>      int xlen =3D riscv_cpu_xlen(env);
>      bool vill =3D (s2 >> (xlen - 1)) & 0x1;
> -    target_ulong reserved =3D s2 &
> -                            MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> -                                            xlen - 1 - R_VTYPE_RESERVED_=
SHIFT);
>      uint16_t vlen =3D cpu->cfg.vlenb << 3;
>      int8_t lmul;
>
> @@ -63,7 +77,22 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target=
_ulong s1,
>          }
>      }
>
> -    if ((sew > cpu->cfg.elen) || vill || (ediv !=3D 0) || (reserved !=3D=
 0)) {
> +    switch (vsew) {
> +    case MO_8:
> +        ill_altfmt &=3D !(cpu->cfg.ext_zvfbfa);
> +        break;
> +    case MO_16:
> +        ill_altfmt &=3D !(cpu->cfg.ext_zvfbfa);
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    if (altfmt && ill_altfmt) {
> +        vill =3D true;
> +    }
> +
> +    if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) !=3D 0=
)) {
>          /* only set vill bit. */
>          env->vill =3D 1;
>          env->vtype =3D 0;
> --
> 2.52.0
>
>

