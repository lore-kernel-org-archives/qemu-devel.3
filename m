Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215EBFF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 04:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIf5i-0006wp-3E; Fri, 01 May 2026 00:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIf5d-0006tX-J3
 for qemu-devel@nongnu.org; Fri, 01 May 2026 00:02:58 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIf5a-0005SH-Tp
 for qemu-devel@nongnu.org; Fri, 01 May 2026 00:02:57 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so237153766b.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 21:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777608173; cv=none;
 d=google.com; s=arc-20240605;
 b=a6LPHB9JUh48Tq+B4fapSjz94/Bjb+Mii9E6kwEE3k3finNodJ43U8WPW0z6jzWV2P
 M6aWJ0isuFdwmDMsImJJvnlqF1vO1P9pl6ze1pQGhaTAJmjdIUkrr3oLXDWppg/vcusW
 3klQ8HbbvdJCPxWFVV7yly0B1ZX79p+qFjZasSqW6VisbangluO+3jdGw6vXalV97mxB
 duXM8gtfTdmvAem6c4orH7Qkw8+hSySuy0FW6L/4TFoi7yp1jFoaldbAQXjhFq28eFbL
 aRz89pN4qahBwqpGrxieOUXQzgTnA/ZKv/AOq8yEDjE1snWd+3hlUKKJwK1qMjqMg0f4
 VZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w3udHbp5sGzYNA3tVfG61j5Z/veoBxhG53xi2gQq55I=;
 fh=lldk3GMzpVPWJTS+jwmtnayOKLiGEFdBZLRTrAMdDxk=;
 b=BAykrB61MJjaCQG7q8se85tx52ng1Yuqxle9Xe143rujNsFCwlHGZ0HHb8PaeQM1UQ
 F8/i7OAPobkXky4tFAYDdI/c0KHy5KvgA6mrp2uMBvj/QDKO1LDu6eDd6IkdkzUGtT/H
 Ga7u0/Vgm1XO5zp9cHSVlMpxAKK0qxhanoZEOuBisi8w1ibrJn84BjlvG0mOqk6/zGrn
 aOJM6hp/e0qPRQmE1z/UIgXsgNEVbq6ehe9yeH3SJOQFd+iEcJSU6lmD/gox6Vg2qdX3
 A1HfdK5iyg258zzLB+ZrzcDX9AVT5nwTdamkVlaxK453YT1H/J0Z2HNVyedqvg9yQwQj
 7rwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777608173; x=1778212973; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3udHbp5sGzYNA3tVfG61j5Z/veoBxhG53xi2gQq55I=;
 b=GUVVMxV9lP+o+5Y5PfbAWEqh4bWxOEbX6hN7qjS7yYpuIkLDVIwJcWlE2i0+DLMw0z
 mhqB3/fb5Qdxpnmd0Tf3/1ahpv3DjknPyRDwRRWlgzcpXBDqj0ngzXpRozpC3PPo8sVb
 jQS8/nMcJW36PkR6DGfa2f47jALHVsJP9CPTXi/W0NJlKJGHjLhGezqUN1OJwb7i8Cv6
 uGsKbhswn4qvbTI4lEB6yFjoLZ3e6utahWnti3piOSYqlIBB7STDUeHfen2Oi/i+az2m
 7LVrwnb+tuAc9v0OvVnbEDr66rVVRApMKu76aX5haFXt47HyMEbogjFx20g3KoGTy0Si
 Slww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777608173; x=1778212973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w3udHbp5sGzYNA3tVfG61j5Z/veoBxhG53xi2gQq55I=;
 b=VvFkcKiTRzAsvpsBIcJGeQpWMb5EaROK0zIVzed0FneIv9ho2wMHHpETWIzCuqnPdP
 Iz3mN8BFrdtIbc+MCHtmAf0M78QB598IPGJh5XhHbAQklftGGsGfUHzNAK5o/JTgYz7E
 jSGZAdKG36rweg7m8jsNKS7OShYVylSJXFomB5UaVHmYQ0tsfnSBFIbAfQDxE9g6K8yG
 DgeZ6i26NsWaDlftMYjAVBx6IVFrxTiwH8JpMD7TddD6ejaU9EAqRe16LOsZTyhdQfyx
 V6KIPX2/BEwqIWKMTAG9YkxUXUq5IXNh7APhNEhaZRlm6TAmhCLyPnJlF13Qc5r0kHMo
 yROw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+poKZWChkt+OPWlUXyw/WaF6ff2tIjZHz9Ec5mHeb5ALOCA8OZyNv46kXgTDYb+yfQBqsqAXoojvz/@nongnu.org
X-Gm-Message-State: AOJu0YwtmlSHWq4y3o/EfEORyNgSL4WJJNYs3mwRma0gveVNkvRoyIyf
 Eom/JyD2gl/YxLeAJxydM+bjJGa0+WdcG3pvvAVWGj75MgcV/Yf3VViWJiS1RNipF8fZRXgpulE
 p338u+FkMnPMX5c8vjG6Kte+OhuSEaFg=
X-Gm-Gg: AeBDieuuSzfzaJ8WkAv8Mq1S3/Vy2vCEraebBPG6C1/ODjLHn2iKrI6gltduTbrJQY0
 2LszG764qak+cB0YyF655Lxa7F3CESHDLzR2ZASE2c+AGVw+iMeIZIwsQfEAIQW2QaiAZm75F+F
 znODkdPY0TRBrRK7YwhvsJyVEjqEP68ZeFTphQ4WZ3xsJiocMJ/vJguHx2aPpq0dLIl1ehFUqlc
 TzO7FY/tTFHqRiKwiAdfmjgAFuJomYt7ExpmfDIqDjoLMQ5iYoV/lepsho9mM9gb8BBpSUnRUGY
 999JJB5wVMwPIxssr1Xs1+McHJ2NR9Rd16OmVrKGBHAnmlhNtKjFYo4093g=
X-Received: by 2002:a17:907:782:b0:b9c:2c55:3384 with SMTP id
 a640c23a62f3a-bbac8181578mr387752066b.31.1777608173227; Thu, 30 Apr 2026
 21:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
In-Reply-To: <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 14:02:26 +1000
X-Gm-Features: AVHnY4JF9k5WiNMU1LNVj3WRmwproiwWwT__gmIRz3yxy-F8ZinddXixcSvRr1U
Message-ID: <CAKmqyKP2xqEcvp6HMgu4ieV9vf1g1aaFQt_VSxBwD6vd=SAzuA@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] target/riscv: add thead-c908 cpu support
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@zevorn.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>, Peng Jiang <3160104094@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Sat, Apr 18, 2026 at 1:13=E2=80=AFAM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:
>
> From: Chao Liu <chao.liu@zevorn.cn>
>
> The C908 processor is based on the RV64GCB[V] instruction
> set, compatible to RVA22 Profile and implements the XIE
> (XuanTie Instruction Extension) technology.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor@kernel.org>
> Reported-by: Peng Jiang <3160104094@zju.edu.cn>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu-qom.h |   2 +
>  target/riscv/cpu.c     |  51 ++++++
>  target/riscv/th_csr.c  | 380 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 432 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 30dcdcfaae..1a28f1369c 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -52,6 +52,8 @@
>  #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34"=
)
>  #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54"=
)
>  #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906"=
)
> +#define TYPE_RISCV_CPU_THEAD_C908       RISCV_CPU_TYPE_NAME("thead-c908"=
)
> +#define TYPE_RISCV_CPU_THEAD_C908V      RISCV_CPU_TYPE_NAME("thead-c908v=
")
>  #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>  #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon"=
)
>  #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-n=
anhu")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 72c6f4f0f1..870d0690fe 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3150,6 +3150,57 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>  #endif
>      ),
>
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
> +        .priv_spec =3D PRIV_VERSION_1_12_0,
> +
> +        /* ISA extensions */
> +        .cfg.ext_xtheadba =3D true,
> +        .cfg.ext_xtheadbb =3D true,
> +        .cfg.ext_xtheadbs =3D true,
> +        .cfg.ext_xtheadcmo =3D true,
> +        .cfg.ext_xtheadcondmov =3D true,
> +        .cfg.ext_xtheadfmv =3D true,
> +        .cfg.ext_xtheadfmemidx =3D true,
> +        .cfg.ext_xtheadmac =3D true,
> +        .cfg.ext_xtheadmemidx =3D true,
> +        .cfg.ext_xtheadmempair =3D true,
> +        .cfg.ext_xtheadsync =3D true,
> +        .cfg.ext_smepmp =3D true,
> +        .cfg.ext_sscofpmf =3D true,
> +        .cfg.ext_sstc =3D true,
> +        .cfg.ext_svpbmt =3D true,
> +        .cfg.ext_svinval =3D true,
> +        .cfg.ext_svnapot =3D true,
> +        .cfg.ext_zba =3D true,
> +        .cfg.ext_zbb =3D true,
> +        .cfg.ext_zbc =3D true,
> +        .cfg.ext_zbs =3D true,
> +        .cfg.ext_zkt =3D true,
> +        .cfg.ext_zbkc =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zihintpause =3D true,
> +        .cfg.ext_zicbom =3D true,
> +        .cfg.ext_zicboz =3D true,
> +
> +        .cfg.pmp =3D true,
> +        .cfg.mmu =3D true,
> +        .cfg.max_satp_mode =3D VM_1_10_SV48,
> +
> +        .cfg.marchid =3D 0x8d143000,
> +        .cfg.mvendorid =3D THEAD_VENDOR_ID,
> +#ifndef CONFIG_USER_ONLY
> +        .custom_csrs =3D th_csr_list,
> +#endif
> +    ),
> +
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908V, TYPE_RISCV_CPU_THEAD_C9=
08,
> +        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU | RV=
V,
> +        .vext_spec =3D VEXT_VERSION_1_00_0,
> +    ),
> +
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
>          .misa_mxl_max =3D MXL_RV64,
>          .misa_ext =3D RVG | RVC | RVS | RVU | RVH | RVV,
> diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> index 49eb7bbab5..e19cab5414 100644
> --- a/target/riscv/th_csr.c
> +++ b/target/riscv/th_csr.c
> @@ -2,6 +2,9 @@
>   * T-Head-specific CSRs.
>   *
>   * Copyright (c) 2024 VRULL GmbH
> + * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
> + *
> + * For more information, see XuanTie-C908-UserManual_xrvm_20240530.pdf
>   *
>   * This program is free software; you can redistribute it and/or modify =
it
>   * under the terms and conditions of the GNU General Public License,
> @@ -20,13 +23,88 @@
>  #include "cpu.h"
>  #include "cpu_vendorid.h"
>
> -#define CSR_TH_SXSTATUS 0x5c0
> +/* Extended M-mode control registers of T-Head */
> +#define CSR_TH_MXSTATUS        0x7c0
> +#define CSR_TH_MHCR            0x7c1
> +#define CSR_TH_MCOR            0x7c2
> +#define CSR_TH_MCCR2           0x7c3
> +#define CSR_TH_MHINT           0x7c5
> +#define CSR_TH_MRVBR           0x7c7
> +#define CSR_TH_MCOUNTERWEN     0x7c9
> +#define CSR_TH_MCOUNTERINTEN   0x7ca
> +#define CSR_TH_MCOUNTEROF      0x7cb
> +#define CSR_TH_MCINS           0x7d2
> +#define CSR_TH_MCINDEX         0x7d3
> +#define CSR_TH_MCDATA0         0x7d4
> +#define CSR_TH_MCDATA1         0x7d5
> +#define CSR_TH_MSMPR           0x7f3
> +#define CSR_TH_CPUID           0xfc0
> +#define CSR_TH_MAPBADDR        0xfc1
> +
> +/* TH_MXSTATUS bits */
> +#define TH_MXSTATUS_UCME        BIT(16)
> +#define TH_MXSTATUS_MAEE        BIT(21)
> +#define TH_MXSTATUS_THEADISAEE  BIT(22)
> +
> +/* Extended S-mode control registers of T-Head */
> +#define CSR_TH_SXSTATUS        0x5c0
> +#define CSR_TH_SHCR            0x5c1
> +#define CSR_TH_SCER2           0x5c2
> +#define CSR_TH_SCER            0x5c3
> +#define CSR_TH_SCOUNTERINTEN   0x5c4
> +#define CSR_TH_SCOUNTEROF      0x5c5
> +#define CSR_TH_SCYCLE          0x5e0
> +#define CSR_TH_SHPMCOUNTER3    0x5e3
> +#define CSR_TH_SHPMCOUNTER4    0x5e4
> +#define CSR_TH_SHPMCOUNTER5    0x5e5
> +#define CSR_TH_SHPMCOUNTER6    0x5e6
> +#define CSR_TH_SHPMCOUNTER7    0x5e7
> +#define CSR_TH_SHPMCOUNTER8    0x5e8
> +#define CSR_TH_SHPMCOUNTER9    0x5e9
> +#define CSR_TH_SHPMCOUNTER10   0x5ea
> +#define CSR_TH_SHPMCOUNTER11   0x5eb
> +#define CSR_TH_SHPMCOUNTER12   0x5ec
> +#define CSR_TH_SHPMCOUNTER13   0x5ed
> +#define CSR_TH_SHPMCOUNTER14   0x5ee
> +#define CSR_TH_SHPMCOUNTER15   0x5ef
> +#define CSR_TH_SHPMCOUNTER16   0x5f0
> +#define CSR_TH_SHPMCOUNTER17   0x5f1
> +#define CSR_TH_SHPMCOUNTER18   0x5f2
> +#define CSR_TH_SHPMCOUNTER19   0x5f3
> +#define CSR_TH_SHPMCOUNTER20   0x5f4
> +#define CSR_TH_SHPMCOUNTER21   0x5f5
> +#define CSR_TH_SHPMCOUNTER22   0x5f6
> +#define CSR_TH_SHPMCOUNTER23   0x5f7
> +#define CSR_TH_SHPMCOUNTER24   0x5f8
> +#define CSR_TH_SHPMCOUNTER25   0x5f9
> +#define CSR_TH_SHPMCOUNTER26   0x5fa
> +#define CSR_TH_SHPMCOUNTER27   0x5fb
> +#define CSR_TH_SHPMCOUNTER28   0x5fc
> +#define CSR_TH_SHPMCOUNTER29   0x5fd
> +#define CSR_TH_SHPMCOUNTER30   0x5fe
> +#define CSR_TH_SHPMCOUNTER31   0x5ff
> +#define CSR_TH_SMIR            0x9c0
> +#define CSR_TH_SMLO0           0x9c1
> +#define CSR_TH_SMEH            0x9c2
> +#define CSR_TH_SMCIR           0x9c3
> +
> +/* Extended U-mode control registers of T-Head */
> +#define CSR_TH_FXCR            0x800
>
>  /* TH_SXSTATUS bits */
>  #define TH_SXSTATUS_UCME        BIT(16)
>  #define TH_SXSTATUS_MAEE        BIT(21)
>  #define TH_SXSTATUS_THEADISAEE  BIT(22)
>
> +static RISCVException mmode(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_has_ext(env, RVM)) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
> +
>  static RISCVException smode(CPURISCVState *env, int csrno)
>  {
>      if (riscv_has_ext(env, RVS)) {
> @@ -36,11 +114,31 @@ static RISCVException smode(CPURISCVState *env, int =
csrno)
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
>
> +static RISCVException any(CPURISCVState *env, int csrno)
> +{
> +    return RISCV_EXCP_NONE;
> +}
> +
>  static bool test_thead_mvendorid(RISCVCPU *cpu)
>  {
>      return cpu->cfg.mvendorid =3D=3D THEAD_VENDOR_ID;
>  }
>
> +static RISCVException read_th_mxstatus(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
> +{
> +    /* We don't set MAEE here, because QEMU does not implement MAEE. */
> +    *val =3D TH_MXSTATUS_UCME | TH_MXSTATUS_THEADISAEE;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_unimp_th_csr(CPURISCVState *env, int csrno,
> +                                        target_ulong *val)
> +{
> +    *val =3D 0;
> +    return RISCV_EXCP_NONE;
> +}
> +
>  static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
>                                         target_ulong *val)
>  {
> @@ -50,10 +148,290 @@ static RISCVException read_th_sxstatus(CPURISCVStat=
e *env, int csrno,
>  }
>
>  const RISCVCSR th_csr_list[] =3D {
> +    {
> +        .csrno =3D CSR_TH_MXSTATUS,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mxstatus", mmode, read_th_mxstatus }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MHCR,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mhcr", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MCOR,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mcor", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MCCR2,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mccr2", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MHINT,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mhint", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MRVBR,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mrvbr", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MCOUNTERWEN,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mcounterwen", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MCOUNTERINTEN,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mcounterinten", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MCOUNTEROF,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mcounterof", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MCINS,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mcins", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MCINDEX,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mcindex", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MCDATA0,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mcdata0", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MCDATA1,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mcdata1", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MSMPR,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.msmpr", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_CPUID,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.cpuid", mmode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_MAPBADDR,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.mapbaddr", mmode, read_unimp_th_csr }
> +    },
>      {
>          .csrno =3D CSR_TH_SXSTATUS,
>          .insertion_test =3D test_thead_mvendorid,
>          .csr_ops =3D { "th.sxstatus", smode, read_th_sxstatus }
>      },
> +    {
> +        .csrno =3D CSR_TH_SHCR,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shcr", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SCER2,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.scer2", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SCER,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.scer", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SCOUNTERINTEN,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.scounterinten", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SCOUNTEROF,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.scounterof", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SCYCLE,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.scycle", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER3,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter3", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER4,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter4", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER5,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter5", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER6,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter6", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER7,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter7", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER8,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter8", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER9,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter9", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER10,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter10", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER11,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter11", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER12,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter12", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER13,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter13", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER14,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter14", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER15,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter15", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER16,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter16", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER17,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter17", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER18,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter18", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER19,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter19", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER20,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter20", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER21,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter21", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER22,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter22", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER23,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter23", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER24,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter24", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER25,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter25", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER26,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter26", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER27,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter27", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER28,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter28", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER29,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter29", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER30,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter30", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SHPMCOUNTER31,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.shpmcounter31", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SMIR,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.smir", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SMLO0,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.smlo0", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SMEH,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.smeh", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_SMCIR,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.smcir", smode, read_unimp_th_csr }
> +    },
> +    {
> +        .csrno =3D CSR_TH_FXCR,
> +        .insertion_test =3D test_thead_mvendorid,
> +        .csr_ops =3D { "th.fxcr", any, read_unimp_th_csr }
> +    },
>      { }
>  };
> --
> 2.53.0
>
>

