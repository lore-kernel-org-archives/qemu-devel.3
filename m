Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169EDC02193
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 00:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdebq-0000CP-CQ; Thu, 30 Jan 2025 19:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdebo-0000Bc-OD; Thu, 30 Jan 2025 19:10:08 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdebn-00071k-33; Thu, 30 Jan 2025 19:10:08 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4aff5b3845eso571523137.2; 
 Thu, 30 Jan 2025 16:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738282205; x=1738887005; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMfv1ZgFpHmPlUsVxLRCr1lTcgej3gR+soK5dpWwt7A=;
 b=fDWCnSNd5A4jAPgcRJ3YBTicC7SH5pG7SAIvsSBrg1b3XOtVkIVqnUwjS85DdR1GE1
 ZcWsjuBV17KBfdAmJShrap6Va1EB8Uee9kFW/Rfku8XtbQO2P/U3I+xMzLNwVbU0Ga3R
 Z4qeqPJMer+tOZLHMLKFLi8dxFRQl58AUcyC4anxk93dpEusdIvt3aq9XxkUJ/rVA7ee
 k75w1zxQcC2DgVed2xYxNKKucK2fepoUTupvbKUpqkJO8TPOmynH7eACY0yLY15NazCd
 VJw2BUdrDFWQDOpRBKlU3O31wjGKjt8z4QFNHHCxpX/D+fMmcazFCV5cHi1Q9R6wNPIH
 urUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738282205; x=1738887005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMfv1ZgFpHmPlUsVxLRCr1lTcgej3gR+soK5dpWwt7A=;
 b=Tu6H7EADXcwREotkJNgGgxUB3P/sYKiy5Fzkk/CbaBZll7+zrFp7jEZxk5UjgglGqz
 tFTwP180jeAehWXAIuZYC2AHCQhHzCZSLT44YmYpz56fGZVII/YyztJnikUlBHSuJtai
 rddKOU7z4o4pl2YL2YtjPbKeUBFFCfIn+A2rpY/NK+q/q31pZTsB6n9hJf42TsnkUYQQ
 tNvH/K2amCYTfh0KOIl5lTu888mHgLhltDq4+oavAJX71SIToXVG6HuGIwICeys/miPs
 RcJT1U6+zHtN9ZR/ze9Trqa9gRxTc+mWNCo6DQMyMcuN0WUPsoY9W2ZBQvnfyiSNNHCB
 tTZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMYQRGrYTmgj4P6IATaRjL+aNPp1OJkYxupxpbO5ZgbVoWh8+tq3sFAZmVqd8iOIkHbbE/VfZOgNEe@nongnu.org
X-Gm-Message-State: AOJu0YyI7gpqttEBIzWMUU+PaPb/60jfhtpseyWfeEruW+XITo/WZB0P
 /4zmh+roKEq809E9eJWIf3v2Jo2Aqzt+P0R1d7HTAAsr1cuoYvoGqtnVNR11jyt2fYQDmi24EYN
 2j1Kryai2KfngUUf8+PhaC40cHH8=
X-Gm-Gg: ASbGncsTVahJmhPGBZBoHT0IWkKIbPEqilh5VwQOq1UxSdA56up4X8evqWIW62o8hd0
 ptSt8fuIPyCoxBrWJs7rhi34KWltTSjtElXq7C15Oa38aBsDabJBG4dhX51FdVwtuPXI0hMdSta
 7B+fUGS9MetrDexieAK/3/YKqSPr8=
X-Google-Smtp-Source: AGHT+IEuzBlnGETzS2Hugg+UPtbkvjrubH/ZJDbEUqlkWOWQtRgZzjrdm0t7XW3oB9wsLKL6XYuJwXYCUHyfKThfBiU=
X-Received: by 2002:a05:6102:4a84:b0:4b6:5440:6cbb with SMTP id
 ada2fe7eead31-4b9a51df660mr9436849137.20.1738282205588; Thu, 30 Jan 2025
 16:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
 <20250115184316.2344583-6-dbarboza@ventanamicro.com>
In-Reply-To: <20250115184316.2344583-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 10:09:39 +1000
X-Gm-Features: AWEUYZn7N2PmvdDjFvmes38PVMmL0TTu2YgALGm2jEMQe1pwFA565GMoP1Udp34
Message-ID: <CAKmqyKNeh5xis_Rp6sECv6AexR0Nt4Ai+1p3f6efHXddngnTag@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] target/riscv: add RVA23U64 profile
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Thu, Jan 16, 2025 at 4:45=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Add RVA23U64 as described in [1]. Add it as a child of RVA22U64 since
> all RVA22U64 mandatory extensions are also present in RVA23U64. What's
> left then is to list the mandatory extensions that are RVA23 only.
>
> A new "rva23u64" CPU is also added.
>
> [1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.a=
doc
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index d56b067bf2..53ead481a9 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -40,6 +40,7 @@
>  #define TYPE_RISCV_CPU_RV64E            RISCV_CPU_TYPE_NAME("rv64e")
>  #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
> +#define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibe=
x")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31"=
)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e215b1004d..761da41e53 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2397,9 +2397,34 @@ static RISCVCPUProfile RVA22S64 =3D {
>      }
>  };
>
> +/*
> + * All mandatory extensions from RVA22U64 are present
> + * in RVA23U64 so set RVA22 as a parent. We need to
> + * declare just the newly added mandatory extensions.
> + */
> +static RISCVCPUProfile RVA23U64 =3D {
> +    .u_parent =3D &RVA22U64,
> +    .s_parent =3D NULL,
> +    .name =3D "rva23u64",
> +    .misa_ext =3D RVV,
> +    .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,
> +    .satp_mode =3D RISCV_PROFILE_ATTR_UNUSED,
> +    .ext_offsets =3D {
> +        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zvbb),
> +        CPU_CFG_OFFSET(ext_zvkt), CPU_CFG_OFFSET(ext_zihintntl),
> +        CPU_CFG_OFFSET(ext_zicond), CPU_CFG_OFFSET(ext_zimop),
> +        CPU_CFG_OFFSET(ext_zcmop), CPU_CFG_OFFSET(ext_zcb),
> +        CPU_CFG_OFFSET(ext_zfa), CPU_CFG_OFFSET(ext_zawrs),
> +        CPU_CFG_OFFSET(ext_supm),
> +
> +        RISCV_PROFILE_EXT_LIST_END
> +    }
> +};
> +
>  RISCVCPUProfile *riscv_profiles[] =3D {
>      &RVA22U64,
>      &RVA22S64,
> +    &RVA23U64,
>      NULL,
>  };
>
> @@ -2886,6 +2911,13 @@ static void rva22s64_profile_cpu_init(Object *obj)
>
>      RVA22S64.enabled =3D true;
>  }
> +
> +static void rva23u64_profile_cpu_init(Object *obj)
> +{
> +    rv64i_bare_cpu_init(obj);
> +
> +    RVA23U64.enabled =3D true;
> +}
>  #endif
>
>  static const gchar *riscv_gdb_arch_name(CPUState *cs)
> @@ -3165,6 +3197,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_c=
pu_init),
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_pro=
file_cpu_init),
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_pro=
file_cpu_init),
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_pro=
file_cpu_init),
>  #endif /* TARGET_RISCV64 */
>  };
>
> --
> 2.47.1
>
>

