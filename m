Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624D5EFCE58
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 02:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxydW-0001qr-DU; Wed, 04 Mar 2026 21:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxydS-0001qH-Bz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 21:40:22 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxydQ-0002sA-L3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 21:40:22 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65f92a597a1so10704428a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 18:40:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772678419; cv=none;
 d=google.com; s=arc-20240605;
 b=iyrZK+nDPx0O7jA2swtMDKlYm8DOKHyXh8AmCAjBXClJmHWI0h5Ox5kgfQyFXGrpQr
 x6BXG4xzJLhsfc9fCly9wfzaH0vKVIrE4PPaSiY8iuI1oA4dmKTVdnoOKxTs/22hzZjv
 k9Jny2s6gcL0mRBaqlY9GQTYOluy/QiA2dZDPO64EFxgO5GdCtKq4VpOZ9nGAQ+S1/3W
 bY7i0JwD3aYpG7c/CENP+knrvXjB2wGGGnk+TM9o3l/CTKxhp7muZi3ZeRV5sMaizXlz
 GZVhUHvFDrI4EN7EFFRlUdzjodbC1IVssswkP1tweofJYHtD/Pz0Z+p8qgbuUSjRp4wI
 lTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tZRoCi4mvd3uN3jjL/HgHcTpnPg8rwQ+rxkjkfQDndU=;
 fh=qVCHIBAmpZfRsxgXEvXh2s/XRWnqGWa8TXLczCTGhXs=;
 b=PxjVUgeG6MWnf3eUSPI6ay08rn5MuQkq45k4wnx1XzMOWdzep06swtZjv7H+VGrUxT
 XQvTx2qpQbXlpUEeLQEkxWSxnpRQI+kXPGEBmODvQVHe2JzcLsfIGl2zS8TCp1VYcCEM
 US6S1GpOA92fchSRnt9lwN/I3FHnxawZA76EH4R2CjJPHFgiPww8KaVQHENf+8EG0xgZ
 qi5HgloQ/NOTjk4/i0tvNzfFhwd2oa0dwpDy3/Y9XyQhHlT2kAs1GFwUpdlGj1dvQL6U
 GLqYex7qGs0ob/gx27Yac5cW0UQFt9/9yExRN7xMGfw/xyNqbzaWKatxBleIzCUZ8bHH
 oHZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772678419; x=1773283219; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZRoCi4mvd3uN3jjL/HgHcTpnPg8rwQ+rxkjkfQDndU=;
 b=AGoS0mmlD2xwoPgdPuRZZbucSkVRSm0YfykF6u8BVpuMzatSxln/72NLroL06YrBaO
 VghnadUGHXIjI+VBifmX+DYBlJ4rIszzAgq1woY4rTb2DG/KQ7wGzXc680x5StJkvkTW
 KGcaBrpUzaLdVuWkEpd5blPMeq6SNke5TXkDznkRw7hiDpzs0lKbB5w4hJD4R6U41B3L
 pupbn+UdfOQLjxa8J3gYRER3z0IQ50uitDwysckq0pMDfWmLUP0I/k02JfSQT9O9NGXo
 sSVRa8CfyMn7zvI9DAjM4ts7KfIG+DUu/kiBwrAHyCECy689HVhNSu03wF4GEBK+u3JZ
 QWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772678419; x=1773283219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tZRoCi4mvd3uN3jjL/HgHcTpnPg8rwQ+rxkjkfQDndU=;
 b=rotvWs6r/eJdklSqBlJBqFUc42VUFzyFR6trQex1ME60kJm5lwmQ1gYy9vl6NQ+Xql
 1mZQRugnrszK+yK4jgXLT+wkG5QVhRvxbFqjwDjkN4CB9KVu2Z9YFOyDdkQhDyATdHo9
 3eeCmqyS8GY9OHgnt+wM0r85kEiGbSMK2Le8k9xosWTPIH5EnD/EmLB1je2uqPKGeqAU
 kDj9CAN6c8KFTl9SYH/SL8rEisHH8cXq1Od2UCb25bHKAeX/Kp1aZYZssSaZmI/GzSFz
 Unv1GeVg83Wk4Uq8JwcO5+wDdsV9PA1qTLpMtQwzB0pBsjmFjvKSM+PhhuYv2hBA+BWU
 8UzA==
X-Gm-Message-State: AOJu0Yy6zYCAPEUGbx8uCyDOvHwiB2EoopXHNoGd7Ko5xLI2Ql6eg6cI
 S/QDT330n7KFvvIjOAU1vt4BAO1AvZ8fh9BcHxi8rRN6VudbMqEBZczzat/SOrvQyzpTn0rhkiY
 4jiPsyd8++ADz5qIbk+QTBBEZIWGBjW2Idg==
X-Gm-Gg: ATEYQzzX90QvuOsonMtzueEJZ/8yGZL4tAn1KLcjlHC6iLxsOWyE9Qdw/3APENnpYgg
 LK8gZGMXutLSZLjcDAvY9k6w2s5A0gPodCev4T7F2FWhbWrctykPCigGI1YVwLqLuix7OnKrt+W
 3TM2EQHCJKxZJu3Q08xszqch7vE3gg4GMFsGjx3xxRAxaF5MXFeix9ALE2qM94jz4DceTloWPqw
 N7rzj4wW7bTlEek7YbkH3cYxsTSIj+d1Bw4am8CRsr/8dmkO/oK0oZUzZ3LpLOMmVLtJQQ9kWhP
 3Ot8NdHZ1QOiw568iMtIapUF8HhB6wIGHIcOdQ==
X-Received: by 2002:a50:9e27:0:b0:661:2c94:b12c with SMTP id
 4fb4d7f45d1cf-6612c94b2e1mr575759a12.31.1772678418769; Wed, 04 Mar 2026
 18:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-3-max.chou@sifive.com>
In-Reply-To: <20260304134006.2908449-3-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2026 12:39:51 +1000
X-Gm-Features: AaiRm50DfcLwjO2Ol3saMwBCNbYkDkzMjp_GPIWEoD-6HOIQlTJ_JSPHzeypQE0
Message-ID: <CAKmqyKO=6pBxGX9-HFJ+KZ8bDfkO0RSNJJC3QZeLorqy5D_8Kw@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] target/riscv: Add cfg properity for Zvfofp8min
 extension
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
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

On Wed, Mar 4, 2026 at 11:43=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> According to the ISA spec of Zvfofp8min extension,
>
> "The Zvfofp8min extension requires on the Zve32f extension."
>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                | 1 +
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 5 +++++
>  target/riscv/vector_helper.c      | 3 ++-
>  4 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73cfcbdf6f..c3ddcefedc 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>      ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
>      ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
>      ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
>      ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 3696f02ee0..59302894af 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvfofp8min)
>  BOOL_FIELD(ext_smaia)
>  BOOL_FIELD(ext_ssaia)
>  BOOL_FIELD(ext_smctr)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 378b298886..ba89436f13 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -710,6 +710,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          return;
>      }
>
> +    if (cpu->cfg.ext_zvfofp8min && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfofp8min extension depends on Zve32f extensi=
on");
> +        return;
> +    }
> +
>      if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
>          error_setg(errp, "Zvfh extensions requires Zfhmin extension");
>          return;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index b2315ecf9c..57221ab884 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -38,7 +38,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, =
target_ulong vtype)
>      int xlen =3D riscv_cpu_xlen(env);
>      target_ulong reserved =3D 0;
>
> -    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
> +    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvfofp8min) {
>          reserved =3D vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                             xlen - 1 - R_VTYPE_RESERVED_S=
HIFT);
>      } else {
> --
> 2.52.0
>
>

