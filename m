Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C9EC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0U62-0006Kg-JU; Thu, 03 Apr 2025 19:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0U60-0006Jg-RN; Thu, 03 Apr 2025 19:35:40 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0U5z-0007ax-DQ; Thu, 03 Apr 2025 19:35:40 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-86d30787263so747977241.1; 
 Thu, 03 Apr 2025 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743723338; x=1744328138; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ei7yKqDw4j9hNFR1GqOb7rxG5UTvAzooq0onox2q9M=;
 b=bSqvVLAWgNI7lwzXLkGfHAbqBzeGrAM8Za4LAAQ+4cY95g+orwfBjiRusE29OB4vAe
 G3eDSg8RuCtCEGPgKhUyrbroLZHD0I5/g0j3RtK+wmafTkFudH0nw1x/168Fy919MbMz
 mJRkQ2crvuooTgTyVHNhuNxGXKWfThtMLY0zC2eGXW6VRkUp2XZmnab/sFjBa53gHwfH
 +REbib1YB71mWyYcSkSTZqjNV3fbEvYdwAcRpzCDyjsNvPZFq/sjJf0r0cpuxBB6EmVP
 oX4lrU8q5byNqn+0mI7F7Z4pDSLlm9lePJRD4W5X3004AJpCgqNfZskdlB/MZ0nc73JU
 3+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743723338; x=1744328138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ei7yKqDw4j9hNFR1GqOb7rxG5UTvAzooq0onox2q9M=;
 b=kPq5CNfFuNtiWW51R/+zzj6RCYAMDwvmljN7Ri7sOTeUfKrWIZeBBuJFhpmx7hTJV1
 6JBy/jMDVlGVi0mRmmvaKsRMLcTUPNaM5xeMWqXrPDxHEnu2BRYQcEbJ88OAzfOtv2Rf
 a0v8+Xx5rhrPPf5L+87417AYbUNhFJyne8jDzwT2OCUDK2wiK3juN+lPldN92ZtA6KWx
 bCSIUyJKfTvqu8QJdvKA4vf79S39UKgt/nJl8uLTG1iO4PZYtJzcQw1ZbfcVhsqdu8Al
 d0q2d0VJfAXGggsRH6ROTJC+wGPPie+0WeM67sSSABp/nzW1HVrDUm7BoK4aEWKkHyJh
 Hakg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBGwUXxsCpuBjTyhW0kKEUdBB90phL4Q6YBU0bLUTQlVqIcIiNHSI4A7UiESeOTpu2cm3RL1QN76ky@nongnu.org
X-Gm-Message-State: AOJu0Yzphf5w2FjeC/6KkjDdMqqprKhTmo+jKB3Wkgp3ExV4MIamEt6V
 Fr/w683HZCTfVfByKl2dYoJFF+s5cbsF6hTFek65P7DPC0YZopKmb3u7zWKmhQylboS0Gl/yUqG
 lM6v8I8zioolef7a9Gb8nAVBjVWZ5aw==
X-Gm-Gg: ASbGncu4SOt2qrmOvmeXPA41lchmCAkhBj4KRxa93FdrsfZnB4X6Z+k9CMhn7enzqe3
 umdFpezd+G/HgYGxGL/ujBHzxn2jgdSWmExgby6sgzuUgYMrqc7zVuf5zXHfJn+sOjGsQgswBcl
 LOSRT6jK5ErCn0UYcP6FQcfsa+bGMnWojl6hDcuBiS4CC0hcycc8QSuyij
X-Google-Smtp-Source: AGHT+IE3IzpLU0Q6gfRivGfkV+1kQF9+YCS1oSPgPU6NQXV+Oa8vfdAPwKdy28eOp1FxvFm/piEWD2RO3EVuL90imkQ=
X-Received: by 2002:a05:6102:3f0d:b0:4c3:6393:8448 with SMTP id
 ada2fe7eead31-4c85538128amr990009137.1.1743723337953; Thu, 03 Apr 2025
 16:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250401103344.84257-1-jay.chang@sifive.com>
In-Reply-To: <20250401103344.84257-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 09:35:11 +1000
X-Gm-Features: ATxdqUH4cczi4h8p3im-3kLlZL8YReaFswxbsDOZCt2SRwHG_RJRm7T9OB2mqpo
Message-ID: <CAKmqyKOircwxmpXPgvKGB27prtCQgpZWqXKbxAduAm-jF1fUMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Restrict mideleg/medeleg/medelegh
 access to S-mode harts
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
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

On Tue, Apr 1, 2025 at 8:35=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wro=
te:
>
> RISC-V Privileged Spec states:
> "In harts with S-mode, the medeleg and mideleg registers must exist, and
> setting a bit in medeleg or mideleg will delegate the corresponding trap
> , when occurring in S-mode or U-mode, to the S-mode trap handler. In
> harts without S-mode, the medeleg and mideleg registers should not
> exist."
>
> Add smode predicate to ensure these CSRs are only accessible when S-mode
> is supported.
>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 7948188356..975d6e307f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5783,8 +5783,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>                            NULL,                read_mstatus_i128        =
   },
>      [CSR_MISA]        =3D { "misa",       any,   read_misa,    write_mis=
a,
>                            NULL,                read_misa_i128           =
   },
> -    [CSR_MIDELEG]     =3D { "mideleg",    any,   NULL, NULL,   rmw_midel=
eg   },
> -    [CSR_MEDELEG]     =3D { "medeleg",    any,   read_medeleg, write_med=
eleg },
> +    [CSR_MIDELEG]     =3D { "mideleg",    smode,   NULL, NULL,   rmw_mid=
eleg   },
> +    [CSR_MEDELEG]     =3D { "medeleg",    smode,   read_medeleg, write_m=
edeleg },
>      [CSR_MIE]         =3D { "mie",        any,   NULL, NULL,   rmw_mie  =
     },
>      [CSR_MTVEC]       =3D { "mtvec",      any,   read_mtvec,   write_mtv=
ec   },
>      [CSR_MCOUNTEREN]  =3D { "mcounteren", umode, read_mcounteren,
> @@ -5792,7 +5792,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>
>      [CSR_MSTATUSH]    =3D { "mstatush",   any32, read_mstatush,
>                            write_mstatush                                =
   },
> -    [CSR_MEDELEGH]    =3D { "medelegh",   any32, read_zero, write_ignore=
,
> +    [CSR_MEDELEGH]    =3D { "medelegh",   smode32, read_zero, write_igno=
re,
>                            .min_priv_ver =3D PRIV_VERSION_1_13_0         =
     },
>      [CSR_HEDELEGH]    =3D { "hedelegh",   hmode32, read_hedelegh, write_=
hedelegh,
>                            .min_priv_ver =3D PRIV_VERSION_1_13_0         =
     },
> --
> 2.48.1
>
>

