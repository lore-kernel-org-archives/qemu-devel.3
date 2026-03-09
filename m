Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66490EA8554
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 04:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzSfC-0000Io-7N; Mon, 09 Mar 2026 00:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSfA-0000IH-F8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:56:16 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSf8-0006UP-M9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:56:16 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-660b497acd1so7919703a12.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 21:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773032173; cv=none;
 d=google.com; s=arc-20240605;
 b=INg0G7Ok30CjQ/vGNff6A5Qzdy8f5n23dlSMqyZ6SZSzKhTmdp4cc27l/f15IPh0uo
 CYspgdlS0pZk/gd2wJPj40ZxVDbyL6qBOFUd6TT5HQb5v7f1HQa743vSnpI/i74QphJQ
 Z7QxamXtKXQ2RtyUw7N8JFJMJNRRpoDdDExHe9uS4ZTbnBJVwTHusSlrJT0bhAea5PB8
 xbXvb4FM8MGxWBNmK7KSyr/49T/pkV1nseEwOEAofdf0rPpA3JbYewx0+A+wSphFlj3w
 UTd+60V9w9Q0Rvn2YF+qloA3XqFzA6myKGR/E5Y0szOdoCn34MVJ86kcIMMrtA0Qw7sh
 mwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x4SLxFLdp3FxOZeOLCCESkY6DOHUDpGMvCQs6+IU7f0=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=ViSBeuxe1oTGkhob6Yjw9wgpV7XUjte1aoxyCq3b40WNK9AKoN2q56Ztfj9eBuNiQi
 aggCkey+lCKdGXYUAjqeA76sIk6k9GJVcsFnDmyq+2QpXIUbxuSxoXrTtvmxRO1PCsa1
 kfnX7qqge63easRPoOkoHuk/Y+2r02rtMY2UNd4ud4O3c69GU8hi6Th0dQ5VCFc/pGWy
 9Jqyi2XbJLtVVFNZgajTp7IhKPimhpiifmKsq5UkjcpRdsOU6WeWuuBIlEcIuNagr6+W
 /c/2xq4eZwgCD8vFZJllu+H7p28EoC2jeJ0b2ol2S7xJNoKl+SIir+3paxoIZjjGHnG2
 2oLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773032173; x=1773636973; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4SLxFLdp3FxOZeOLCCESkY6DOHUDpGMvCQs6+IU7f0=;
 b=gS6b4zz9WbOoPp+OCoZvvcm6iebE8iJFASTnXNUSHDujm80Ol6hADMx7M2VwdqWcPZ
 jt2iRouHkVOjGFdSfNvsRC16ihUe1gKn3fBC0992IlBW0YqEv7+kRrI5ew+DwFSAO0K4
 TM+/NXCeVUI2lfELaQLGgWWpb0fwJin0vXnnLk/kXnbv1Ubx2H10i/mdMucbc6Hv3tPw
 eJ9aDHIbfHPAoK/bj+RzsmMKdTLOqB7yaNNi2u8+NuSH+jWEQ4Q+kN/jeweuJ1SC2t1O
 NINd/XGCCZEgo5LvGkn90nZeHzEWAHheD/24NZNGXTbsEq9eHDndwh6ss3hR9DZklSw4
 Eu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773032173; x=1773636973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x4SLxFLdp3FxOZeOLCCESkY6DOHUDpGMvCQs6+IU7f0=;
 b=CnxPxB3On+6+7mmW/Fy7qCDIRwbfqAsEzERIveZ/N40y4//+TbxC7GrTnhqN0Sv96C
 kzKgruWWroWQ+pNxkC02OISBVvGiBhu6HDujD+9Pn2jiHm50h8h6o5VdcI6zinNaoo/T
 PN2cU0LJknFAD8RImDavPhdA5QIATojOjd5TgdVejPVWgDudCQYsTDYnqnN2cy5WAte4
 u4sg2X7RSLLq+/lVkuQK9zz4R9+N5ujMDp3kKlwTpkm7C3d2o0P0mM9zhHs5iv1g9wpw
 NI05Yx73SNBCG4BkF3lDJUa9igovSrb5hJbbJZegqpd+S7pMKgTdLngolPdEeBiR8yqz
 gW6A==
X-Gm-Message-State: AOJu0YyLlo4Alkq0c6JgbxXUDkC4x9f9Jzf2WPI8vnSz1Do21RB6rXCh
 2ZkoEA84zYKAZz5vKl2Uv/y/LduS8V8Q5DfvucZxY4+nHS/0SbNit/U0jilNSsyv6Gb4q+k4c1s
 fp3Fz2Cm2WwgZ2/DIHIG3WcquIOuwyBU=
X-Gm-Gg: ATEYQzy8Z+Yb6wxt8H1rqsJ87Z64CbQH6e3ey/dU6vNOiV92ouCIHnOyEhYOSZMQ44C
 CR9GnRUG2Wo5rJr620tEEtOVef9BVMJziy3kTygRUl0VfgACmjRFpjjPKB0wDK1jd/LLRvHdrHL
 mgd1ohR7miXDdEzyibseySCApKU4/zYnzaow6fvJ1kRhkq7Npc1fQ0xwEPO16tncl/j3oFrI+YK
 f6TvBQzsqMexoZstR8gjj979l5P61C8iTR1m7c6fv+1Y5zxxjvAuXTQhdybwse8UDLsHz/2LIsr
 YLG1PmdtiEdz8d5Zis23rS6jOv5gkAuUADnOjw==
X-Received: by 2002:a05:6402:f12:b0:658:d1b0:9970 with SMTP id
 4fb4d7f45d1cf-6619d45a0edmr3335571a12.5.1773032172542; Sun, 08 Mar 2026
 21:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <20260306071105.3328365-5-max.chou@sifive.com>
In-Reply-To: <20260306071105.3328365-5-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Mar 2026 14:55:46 +1000
X-Gm-Features: AaiRm50_u4gmYIKQh3BeqEVxKIRP2bs6zMkfPEnI-jlDh5QjPQP18_6e3mD-vUA
Message-ID: <CAKmqyKPCuey3R-9oSNWQGyGMtTrG=bKy9QMDjCMet_vhAjNrrA@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] target/riscv: rvv: Introduce reset_ill_vtype to
 reset illegal vtype CSR
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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
> Replace the same vill reset flow by reset_ill_vtype function.
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 7575e24084..b7105627ed 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -49,6 +49,15 @@ static target_ulong vtype_reserved(CPURISCVState *env,=
 target_ulong vtype)
>      return reserved;
>  }
>
> +static inline void reset_ill_vtype(CPURISCVState *env)
> +{
> +    /* only set vill bit. */
> +    env->vill =3D 1;
> +    env->vtype =3D 0;
> +    env->vl =3D 0;
> +    env->vstart =3D 0;
> +}
> +
>  target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                              target_ulong s2, target_ulong x0)
>  {
> @@ -93,11 +102,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, targe=
t_ulong s1,
>      }
>
>      if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) !=3D 0=
)) {
> -        /* only set vill bit. */
> -        env->vill =3D 1;
> -        env->vtype =3D 0;
> -        env->vl =3D 0;
> -        env->vstart =3D 0;
> +        reset_ill_vtype(env);
>          return 0;
>      }
>
> @@ -113,11 +118,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, targ=
et_ulong s1,
>      }
>
>      if (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl !=3D vl)) {
> -        /* only set vill bit. */
> -        env->vill =3D 1;
> -        env->vtype =3D 0;
> -        env->vl =3D 0;
> -        env->vstart =3D 0;
> +        reset_ill_vtype(env);
>          return 0;
>      }
>
> --
> 2.52.0
>
>

