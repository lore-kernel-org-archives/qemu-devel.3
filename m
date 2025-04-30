Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E27FC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAHK3-0007Vq-R8; Wed, 30 Apr 2025 19:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHK2-0007VI-FP; Wed, 30 Apr 2025 19:58:38 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHK0-0000q3-Tv; Wed, 30 Apr 2025 19:58:38 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-86dddba7e0eso109212241.1; 
 Wed, 30 Apr 2025 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746057515; x=1746662315; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjUsHPlXLPg22dIGhPPmvBlqIs5q79G6Kgt8Lyn/YCQ=;
 b=HbDCuoxJwRV3FCiz7/Rm5MVUG93HkQqDfMjBgHAplb3wNzG609G0TPzKVlzpAotqXp
 pI4h6isWsDund4R3IEOOG1sxO/CkIpcKNOFrNaXUc3ARvmezyv2/KLsOig7rrLOhVUnY
 ANd0EoemAgraiHW1IcHNDlrpKjSYEzh31sMJ0TSq1r5OTeiu8zBEz/HIruC6B9tnoBV6
 JST3t5CvKnIWxTWp5CmO03aRe9+hgigq8+hLipCVxHzrBTwpUaX8hXMkyffLbW7IAe0s
 hwpXSnQ4RcNuVpGa+O2qFQdpK5enhKiATWeAjNVT2Dwn6PxNo17wqoRFEl+9/iHh5hnr
 INoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746057515; x=1746662315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjUsHPlXLPg22dIGhPPmvBlqIs5q79G6Kgt8Lyn/YCQ=;
 b=fwrILDDs6lMv/aRoD954Czq5vlHwwZhJae1q3rNnCu+Py2R56bsF1Ao4jmmM5n1RKK
 j6YbBIdlA551pn/z0Y5sH8LOwanQGzH4qAiIOF6O+2ORLymo2sU481JQypNF0kvShtDm
 HJ7AAb6IFwZfaZmGXuqD/RUVQWv3z7yhOcXUUlSJk57EvAxi8QDPU1GjUIb0kk4dlWgg
 29fQtU4hBHhmHm0Rhm0D2vsxptm2ai7lEXaAbUlcTevb3tqh6NlbCCouYXA+KfqdS5Yq
 e80WwFc0+gCQhDhTr/maFVznx+QHj2KBobInB2HkXiyXblm+PMNWUtV+IPbre7/NazJJ
 FKWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT6tJlViiRA0BimXYn5Mk/BXyEs/QEWwf6RwdHcONjZER1kKwibNzo5DUcGocGuQTfMYRrNv7UERTO@nongnu.org
X-Gm-Message-State: AOJu0Yzdi17ePr13/i/4kqPRBXHcIa444DFMjwtI86f+gFVRr57rTUEB
 jeW4uGEJwEzPRGzPIneysOkMF95UtpXIpAvnijjzsY60Kr6uyD6YRESozvPYxgr5Hp6U3LbboBN
 7RN1JgvY68FxwA3Q4xdlEL34bYzQ=
X-Gm-Gg: ASbGncsvfmfZ/cKNd1/MUzhe0cwkF10SWGvNHX3BaluB5VXx8ZoqQqlCoWiHzi8N7IK
 pHnDxeEExEJUZHm58miKazkC5RBILpTrHkg5Jm9j6mhkycd4mT5g2SjOVgd+jiXtZHsTr3g/oJa
 Gv7ekYqDXkuy/eTLE/2PPy19ekEjk91ahdYu3ObveG/dJPlyBuirso
X-Google-Smtp-Source: AGHT+IH+R2TtKNDUYckgCtQAwvw+1g4q3bMgiCx8dsx6VyK+8qFfoRqDpjBfckBT6L4NDkcDuI97slwvxki6PjhslfA=
X-Received: by 2002:a05:6102:390d:b0:4c4:e3fe:4af9 with SMTP id
 ada2fe7eead31-4dae9184cc5mr229284137.12.1746057515521; Wed, 30 Apr 2025
 16:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250430082213.1418201-1-antonb@tenstorrent.com>
In-Reply-To: <20250430082213.1418201-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 09:58:08 +1000
X-Gm-Features: ATxdqUG8cfs3YB7fVnj1VUm1jwO-h6cbLVFXOzdEcEEuXRBE3V6WNaJHadBZA2Q
Message-ID: <CAKmqyKPz8cw=XN5D--aw2XBEEBSdpVNh0k_18H0-j6ea466fKw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix fcvt.s.bf16 NaN box checking
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Wed, Apr 30, 2025 at 6:23=E2=80=AFPM Anton Blanchard <antonb@tenstorrent=
.com> wrote:
>
> fcvt.s.bf16 uses the FP16 check_nanbox_h() which returns an FP16
> quiet NaN. Add check_nanbox_bf16() which returns a BF16 quiet NaN.

You are missing a Signed-off-by line

Alistair

> ---
>  target/riscv/fpu_helper.c |  2 +-
>  target/riscv/internals.h  | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index 91b1a56d10..31c17399fc 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -756,6 +756,6 @@ uint64_t helper_fcvt_bf16_s(CPURISCVState *env, uint6=
4_t rs1)
>
>  uint64_t helper_fcvt_s_bf16(CPURISCVState *env, uint64_t rs1)
>  {
> -    float16 frs1 =3D check_nanbox_h(env, rs1);
> +    float16 frs1 =3D check_nanbox_bf16(env, rs1);
>      return nanbox_s(env, bfloat16_to_float32(frs1, &env->fp_status));
>  }
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 213aff31d8..794c81bf7c 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -142,6 +142,22 @@ static inline float16 check_nanbox_h(CPURISCVState *=
env, uint64_t f)
>      }
>  }
>
> +static inline float16 check_nanbox_bf16(CPURISCVState *env, uint64_t f)
> +{
> +    /* Disable nanbox check when enable zfinx */
> +    if (env_archcpu(env)->cfg.ext_zfinx) {
> +        return (uint16_t)f;
> +    }
> +
> +    uint64_t mask =3D MAKE_64BIT_MASK(16, 48);
> +
> +    if (likely((f & mask) =3D=3D mask)) {
> +        return (uint16_t)f;
> +    } else {
> +        return 0x7FC0u; /* default qnan */
> +    }
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  /* Our implementation of SysemuCPUOps::has_work */
>  bool riscv_cpu_has_work(CPUState *cs);
> --
> 2.34.1
>
>

