Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3C6C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kcS-0008GD-Si; Wed, 23 Apr 2025 20:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kcR-0008G5-8W
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:39:11 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kcP-00033t-DO
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:39:10 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-524168b16d3so421816e0c.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745455148; x=1746059948; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yR8hKFT/n8M/XD6tkvtxBIJDS+jFN61Tv+RwkNbh5Zs=;
 b=SaY6SrCpNzGQBTKqBfTSZTpIZhx6lXlmQTXUXc6KStNXeYa0YGG8xlpInR2/M/6qK0
 ISDo55evHnpS4YEIYg+74Vb0njOKw2cBRpsnyk9Eh1Azen0LpDrpJ8fvnQA7p1iRy+U6
 pkF9sdK1Yc0oLaKFyGy2k8xhlXt9GzJ8DeYlvjZP/Odq8ksk5EL3ITqgLJJYcGG1Yhcl
 x2b1xdD0E/hoauciLIMv8ynFyZE0htrZp9FieuLm7BR2KoTd3qvlCiPvTj1RR6bkPGlE
 c99mc8cqrK8ulsA7SuS7yt/Ujm/xVu4uYVL8xnv94+PZ0nov4xihcK5DvJEx1byC0gky
 INUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455148; x=1746059948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yR8hKFT/n8M/XD6tkvtxBIJDS+jFN61Tv+RwkNbh5Zs=;
 b=g7FNoUx/NWeWruvP1S+Z6CaFnqBmL21eXAwZlnlNIQWinp6sl6vWxCmvC1U4uAKAFM
 G6tvmGvZBxoqPSw0ULK9WHteAYXhmeDDiKB5DJos0CeFg9J2RuVqwmzMp40EBzBkrkKy
 ue8K8sMg5PV8aqqoRit0QW2zvquwmyuvOkb44/5IXSHIf3CQf5p6Jwze31uN1g5g3NXN
 2Y9e/3UP6u50ekh+yb33Qwfl7/b8aZUqm1hBchaJk33mqxTo48n5gz7cH0fk/4jrwNvA
 2cwAFgeAv+Kt0RhTVOWFZuWVTUROBpdGKOSdY+/778o1Zf0zJzHU14n+59/zh778SOaz
 +5eg==
X-Gm-Message-State: AOJu0YxuLuyJCN/FVPjnflFW1FNrlNz1Gw+H1wBDCPbnU0/9FAPyFGIr
 r4C+sEjH5IuOd+af7yMt/HDUfb1zuqOXkWwaFXDs99hT/QL7oXASt8iH9mZasr6uUQNY7dowcPZ
 aRlAvs3PPcKVR9Fdss2nkia8vEAOuFQ==
X-Gm-Gg: ASbGncv79kwxkPDZ6xE1YpzSnNtELWiqb72Abv3pA2rxkchqix6WVHMlcjhS9kG7p6K
 YybAN4yRmV4vJ8xDsqk5+GM80y7OztcoBKXMFn5/+05sLixfeTawPemWcTcoD+U3EYrf+YIz/d5
 kKW95AStqy3nWfol4k4zurA2/UklZIl1ov4GHCDzZgmnROGLtJVmqb
X-Google-Smtp-Source: AGHT+IFIyuFM9gv7zfpL+Dg4WQVf9j5El3J7Xt5PVUNG5Ztb/g40c+Eet5A5XECjM084RE/8YMvdtXBD9rdEDzaMPgg=
X-Received: by 2002:a05:6102:3e06:b0:4bb:c24b:b61a with SMTP id
 ada2fe7eead31-4d38ebe8f51mr1111323137.19.1745455148198; Wed, 23 Apr 2025
 17:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-25-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-25-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:38:42 +1000
X-Gm-Features: ATxdqUFc2yf2nJ2Y-B9xLrurUfYdhLrVHsFagP_Ps6n8ACU-zMCIxT7YJh7_dxU
Message-ID: <CAKmqyKMaCLN22hZVFHvozUpBQwsGtTk==LR2gVAW5rZvBK+sHw@mail.gmail.com>
Subject: Re: [PATCH 24/27] target/riscv: convert TT Ascalon to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Sun, Apr 6, 2025 at 5:04=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 127 +++++++++++++++++++++------------------------
>  1 file changed, 60 insertions(+), 67 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 45bed28ea8a..616d89be17e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -540,72 +540,6 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
>  #endif
>  }
>
> -/* Tenstorrent Ascalon */
> -static void rv64_tt_ascalon_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
> -    env->priv_ver =3D PRIV_VERSION_1_13_0;
> -
> -    /* Enable ISA extensions */
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.vlenb =3D 256 >> 3;
> -    cpu->cfg.elen =3D 64;
> -    cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
> -    cpu->cfg.rvv_ma_all_1s =3D true;
> -    cpu->cfg.rvv_ta_all_1s =3D true;
> -    cpu->cfg.misa_w =3D true;
> -    cpu->cfg.pmp =3D true;
> -    cpu->cfg.cbom_blocksize =3D 64;
> -    cpu->cfg.cbop_blocksize =3D 64;
> -    cpu->cfg.cboz_blocksize =3D 64;
> -    cpu->cfg.ext_zic64b =3D true;
> -    cpu->cfg.ext_zicbom =3D true;
> -    cpu->cfg.ext_zicbop =3D true;
> -    cpu->cfg.ext_zicboz =3D true;
> -    cpu->cfg.ext_zicntr =3D true;
> -    cpu->cfg.ext_zicond =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zihintntl =3D true;
> -    cpu->cfg.ext_zihintpause =3D true;
> -    cpu->cfg.ext_zihpm =3D true;
> -    cpu->cfg.ext_zimop =3D true;
> -    cpu->cfg.ext_zawrs =3D true;
> -    cpu->cfg.ext_zfa =3D true;
> -    cpu->cfg.ext_zfbfmin =3D true;
> -    cpu->cfg.ext_zfh =3D true;
> -    cpu->cfg.ext_zfhmin =3D true;
> -    cpu->cfg.ext_zcb =3D true;
> -    cpu->cfg.ext_zcmop =3D true;
> -    cpu->cfg.ext_zba =3D true;
> -    cpu->cfg.ext_zbb =3D true;
> -    cpu->cfg.ext_zbs =3D true;
> -    cpu->cfg.ext_zkt =3D true;
> -    cpu->cfg.ext_zvbb =3D true;
> -    cpu->cfg.ext_zvbc =3D true;
> -    cpu->cfg.ext_zvfbfmin =3D true;
> -    cpu->cfg.ext_zvfbfwma =3D true;
> -    cpu->cfg.ext_zvfh =3D true;
> -    cpu->cfg.ext_zvfhmin =3D true;
> -    cpu->cfg.ext_zvkng =3D true;
> -    cpu->cfg.ext_smaia =3D true;
> -    cpu->cfg.ext_smstateen =3D true;
> -    cpu->cfg.ext_ssaia =3D true;
> -    cpu->cfg.ext_sscofpmf =3D true;
> -    cpu->cfg.ext_sstc =3D true;
> -    cpu->cfg.ext_svade =3D true;
> -    cpu->cfg.ext_svinval =3D true;
> -    cpu->cfg.ext_svnapot =3D true;
> -    cpu->cfg.ext_svpbmt =3D true;
> -
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
> -#endif
> -}
> -
>  static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
>  {
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> @@ -3217,7 +3151,66 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>  #endif
>      ),
>
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_asca=
lon_cpu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVG | RVC | RVS | RVU | RVH | RVV,
> +        .priv_spec =3D PRIV_VERSION_1_13_0,
> +        .vext_spec =3D VEXT_VERSION_1_00_0,
> +
> +        /* ISA extensions */
> +        .cfg.mmu =3D true,
> +        .cfg.vlenb =3D 256 >> 3,
> +        .cfg.elen =3D 64,
> +        .cfg.rvv_ma_all_1s =3D true,
> +        .cfg.rvv_ta_all_1s =3D true,
> +        .cfg.misa_w =3D true,
> +        .cfg.pmp =3D true,
> +        .cfg.cbom_blocksize =3D 64,
> +        .cfg.cbop_blocksize =3D 64,
> +        .cfg.cboz_blocksize =3D 64,
> +        .cfg.ext_zic64b =3D true,
> +        .cfg.ext_zicbom =3D true,
> +        .cfg.ext_zicbop =3D true,
> +        .cfg.ext_zicboz =3D true,
> +        .cfg.ext_zicntr =3D true,
> +        .cfg.ext_zicond =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zihintntl =3D true,
> +        .cfg.ext_zihintpause =3D true,
> +        .cfg.ext_zihpm =3D true,
> +        .cfg.ext_zimop =3D true,
> +        .cfg.ext_zawrs =3D true,
> +        .cfg.ext_zfa =3D true,
> +        .cfg.ext_zfbfmin =3D true,
> +        .cfg.ext_zfh =3D true,
> +        .cfg.ext_zfhmin =3D true,
> +        .cfg.ext_zcb =3D true,
> +        .cfg.ext_zcmop =3D true,
> +        .cfg.ext_zba =3D true,
> +        .cfg.ext_zbb =3D true,
> +        .cfg.ext_zbs =3D true,
> +        .cfg.ext_zkt =3D true,
> +        .cfg.ext_zvbb =3D true,
> +        .cfg.ext_zvbc =3D true,
> +        .cfg.ext_zvfbfmin =3D true,
> +        .cfg.ext_zvfbfwma =3D true,
> +        .cfg.ext_zvfh =3D true,
> +        .cfg.ext_zvfhmin =3D true,
> +        .cfg.ext_zvkng =3D true,
> +        .cfg.ext_smaia =3D true,
> +        .cfg.ext_smstateen =3D true,
> +        .cfg.ext_ssaia =3D true,
> +        .cfg.ext_sscofpmf =3D true,
> +        .cfg.ext_sstc =3D true,
> +        .cfg.ext_svade =3D true,
> +        .cfg.ext_svinval =3D true,
> +        .cfg.ext_svnapot =3D true,
> +        .cfg.ext_svpbmt =3D true,
> +
> +        .cfg.max_satp_mode =3D VM_1_10_SV57,
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_=
v1_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
>                                                   MXL_RV64, rv64_xiangsha=
n_nanhu_cpu_init),
> --
> 2.49.0
>

