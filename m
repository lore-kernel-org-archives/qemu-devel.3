Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880C4CCD1AB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 02:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBkiC-0001ZK-Bx; Wed, 22 Oct 2025 22:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBki9-0001YG-4h
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:05:53 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBki5-0001ZV-U6
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:05:51 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso391929a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 19:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761185147; x=1761789947; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZVwmQP2X+wB8q1nndMTrIWvY18mwhFhlhQ++O5WY5c=;
 b=X+Ji+LQnOlzNvrXT0QqbIQjhEIubXimvnQfvl2kDAXmbBf3Gq/Oz3BpT0G08MAXyLd
 zP2xjycPLhrMqv4dsqwG+bA/UL4tQVUprSNHrkh2Az0g95Az6Mv7+fz7P9qmGj5jK2qn
 oVtAUjCLMtSfk+uRftRVDaMwpwqNH4w2if1MQIqLJ+6eSgdJe70Dr6LhpmHP9mYz7wEU
 YdoAQ6dYA6YYNUKceNlPR1jAZL5Oon6cLNyleJ7x5kJq5skpif+DkeW3L/o7SLLnZQKV
 ETcSvZeSJlXKJgzHWo1LrCL0WyvE3XvIagEd+KlsVfW7PHECo1gJh6rNO8wKT06H1fuw
 481Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761185147; x=1761789947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZVwmQP2X+wB8q1nndMTrIWvY18mwhFhlhQ++O5WY5c=;
 b=SIhDFpKmk5EdYMWp2GLNWN6By552JuqUk9xC7tX4smjCjEBV3ZYdDvCL2sZlCgFcxY
 AgADFDTloraEqV9vV7K/OKqxk4iX1ONPnyHLWU31TyS5mpHo9QgCmSQcw29575zpBA7J
 aFi4l54LojKcxKfizn+D4cBZpwAw5eO3jOOkTvG6PAwfgZHgUCedm5QEHBE1QKVytS0o
 mI1zwUJEamTgiTkkq+HomKdSOIQTkJUXgsV1FXR9qTAVPp9T+7qq24vA8WkGnXfTKQ4t
 Jr4Ox69P0LjspDXj4OFFZxAEhPolTs5GaDooFivgzVFzuLNLK/dZUjok22vb5MXtIav3
 5pZw==
X-Gm-Message-State: AOJu0YzrgJ4kR9AqsHOEuSYzbVWv4abW4/URv9bnxfzmjifTafjlewmW
 dmtfeWhd+U3Yisbf6TnVHxe3GswrumOUo/Fm7kPRYD6mbqjQapl0y/6Zajm+F1R4eULPPhDItNo
 BGtmo4iLtzjiQbiNKcwkK6R/bpqh4vN8=
X-Gm-Gg: ASbGnctpwQ++/oUCjYUzss+pwxoW+guIXqRShekpdhQaDaNXUpRRN22jpec0Pw5bU5d
 swkmxjrU//szTTu8FqQOi0gVLYtX2SgR3r2HkwfE8e8Wgxv1oenltXlRbYvqL1NL71ddbktmF/v
 LFlKIklHzgNkdxjItAe8RroJJn03iBvKHbvdx/jWiu+OeJy2mNug1a+kE7AfZJnAxUsj8k+CVmH
 Ux+vUmGOMI74cwVUuXlcUxSK8mvreiSXF3flDp6y9EIb6etnLcIhcUAN/ft+JT52B7Cj/iFAcs2
 sikIdqwBM2cCPdTV7DadCcG4Nw==
X-Google-Smtp-Source: AGHT+IEqj0cqg55gxVrHELoM8riXaIg0wJvy1dyiMBMAK1MvWUX+o95JHBzc94gnyZhbL/oa1SlMF3Ejn01HLB7gW6Y=
X-Received: by 2002:a05:6402:2803:b0:63c:4d42:992b with SMTP id
 4fb4d7f45d1cf-63c4d429b05mr18096843a12.13.1761185147011; Wed, 22 Oct 2025
 19:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251022024141.42178-1-jay.chang@sifive.com>
 <20251022024141.42178-2-jay.chang@sifive.com>
In-Reply-To: <20251022024141.42178-2-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Oct 2025 12:05:19 +1000
X-Gm-Features: AS18NWAXLtOO3Uit-LyEPgJYwQydSjG5wHrB7qbj9ZPui3NFJnGP-2kIleMqZrI
Message-ID: <CAKmqyKMJioZTkok_DU1kq9hB-vcAp+Dwrp_=TCXu13qUDmHTkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/riscv: Make PMP granularity configurable
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Wed, Oct 22, 2025 at 12:43=E2=80=AFPM Jay Chang <jay.chang@sifive.com> w=
rote:
>
> Previously, the PMP granularity in qemu always used a minimum
> granularity of 4 bytes, this patch add pmp-granularity to allow
> platforms to configure the value.
>
> A new CPU parameter pmp-granularity has been introduced to the QEMU
> command line. For example:
>
>         -cpu rv64, g=3Dtrue, c=3Dtrue, pmp=3Dtrue, pmp-granularity=3D1024
>
> If no specific value is provided, the default value is 4 bytes.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                | 39 +++++++++++++++++++++++++++++++
>  target/riscv/cpu.h                |  1 +
>  target/riscv/cpu_cfg_fields.h.inc |  1 +
>  3 files changed, 41 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a877018ab0..73d4280d7c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1121,6 +1121,7 @@ static void riscv_cpu_init(Object *obj)
>      cpu->cfg.cbop_blocksize =3D 64;
>      cpu->cfg.cboz_blocksize =3D 64;
>      cpu->cfg.pmp_regions =3D 16;
> +    cpu->cfg.pmp_granularity =3D MIN_RISCV_PMP_GRANULARITY;
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>      cpu->cfg.max_satp_mode =3D -1;
>
> @@ -1606,6 +1607,43 @@ static const PropertyInfo prop_num_pmp_regions =3D=
 {
>      .set =3D prop_num_pmp_regions_set,
>  };
>
> +static void prop_pmp_granularity_set(Object *obj, Visitor *v, const char=
 *name,
> +                                     void *opaque, Error **errp)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> +    uint32_t value;
> +
> +    visit_type_uint32(v, name, &value, errp);
> +
> +    if ((value < MIN_RISCV_PMP_GRANULARITY) && (value & (value - 1))) {
> +        error_setg(errp, "PMP granularity must be a power of 2 and at le=
ast %d",
> +                   MIN_RISCV_PMP_GRANULARITY);
> +        return;
> +    }
> +
> +    if (cpu->cfg.pmp_granularity !=3D value && riscv_cpu_is_vendor(obj))=
 {
> +        cpu_set_prop_err(cpu, name, errp);
> +        return;
> +    }
> +
> +    cpu_option_add_user_setting(name, value);
> +    cpu->cfg.pmp_granularity =3D value;
> +}
> +
> +static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char=
 *name,
> +                                     void *opaque, Error **errp)
> +{
> +    uint32_t value =3D RISCV_CPU(obj)->cfg.pmp_granularity;
> +
> +    visit_type_uint32(v, name, &value, errp);
> +}
> +
> +static const PropertyInfo prop_pmp_granularity =3D {
> +    .description =3D "pmp-granularity",
> +    .get =3D prop_pmp_granularity_get,
> +    .set =3D prop_pmp_granularity_set,
> +};
> +
>  static int priv_spec_from_str(const char *priv_spec_str)
>  {
>      int priv_version =3D -1;
> @@ -2606,6 +2644,7 @@ static const Property riscv_cpu_properties[] =3D {
>      {.name =3D "mmu", .info =3D &prop_mmu},
>      {.name =3D "pmp", .info =3D &prop_pmp},
>      {.name =3D "num-pmp-regions", .info =3D &prop_num_pmp_regions},
> +    {.name =3D "pmp-granularity", .info =3D &prop_pmp_granularity},
>
>      {.name =3D "priv_spec", .info =3D &prop_priv_spec},
>      {.name =3D "vext_spec", .info =3D &prop_vext_spec},
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2c2266415e..04711f93a2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -176,6 +176,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_impli=
ed_rules[];
>
>  #define MAX_RISCV_PMPS (64)
>  #define OLD_MAX_RISCV_PMPS (16)
> +#define MIN_RISCV_PMP_GRANULARITY 4
>
>  #if !defined(CONFIG_USER_ONLY)
>  #include "pmp.h"
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index e2d116f0df..a154ecdc79 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -166,6 +166,7 @@ TYPED_FIELD(uint16_t, cbom_blocksize, 0)
>  TYPED_FIELD(uint16_t, cbop_blocksize, 0)
>  TYPED_FIELD(uint16_t, cboz_blocksize, 0)
>  TYPED_FIELD(uint8_t,  pmp_regions, 0)
> +TYPED_FIELD(uint32_t, pmp_granularity, 0)
>
>  TYPED_FIELD(int8_t, max_satp_mode, -1)
>
> --
> 2.48.1
>
>

