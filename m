Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BA4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3OxV-000764-UM; Mon, 29 Sep 2025 21:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3OxT-00075A-21
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:15:11 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3OxJ-0004x0-5G
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:15:10 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so794625066b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 18:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759194896; x=1759799696; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUaHeKW3RznchVI9deN0I8JLuVCHzEJg99UlwYB3Z9U=;
 b=m9B3dbOyE/Lk/vD+ndNzhWTxAf1OojHBJbxW7NKFpoeoQLvb2cl3f9FUzN9DYcvd9n
 yulMRpxc53yEgW+Miev7EZUCJjJW8TwG0TurAMH1gIV/wb7liuSUBqg96KERqC/TCAUe
 f1KVTF0mtdpMcUkNuGAcpQESza4KrNx00JNgwp15Ae7mCrNOiiQzSwr8hRS8m+PBCzME
 uh3jh/e2yzxLSks1wXHDYrFTlqeqAPNxbaWjMrK8/clTFR7Mjbg9wkQ/BXOUcGB1QEu8
 vZ3FQf3KIr2wJIZxwiBcfGWxs8Q7H7xWFJP3aNVdsBRtnMDwAvVlY76MnoNKQV9LA1uh
 fCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759194896; x=1759799696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUaHeKW3RznchVI9deN0I8JLuVCHzEJg99UlwYB3Z9U=;
 b=FasAcRonsR2Iuv81Q8q2ekRbUc+ajyNVnr9InygaKuxUhfA5T+OeObI7qHFqcSmEhv
 EUIprdP2rwRpQZKg3YC/VMZTWfTTIriK+LI0/xaZCxhgWzwwb4L3scuG8PftnDyyXh2w
 K9LRn0iYK0fH1ttxh1ZGCtDJwNRkCQy4R3S5WjrmakBzG0oR/KMNd1mwixfQnkTRBqk+
 KEO4mdv6Q0KwMoROwVilcM8cUEvECs7txOn/k090s7T7upEL81mCXRY1+m3J0EBWKMQu
 6AyRlZKhYquWYOUHtTYQ0K4llxJTydiWa6V1CbjfnrrT+31uqXRl49MIxEwWjoBT8jmg
 gKbQ==
X-Gm-Message-State: AOJu0Yyks3+0iC1gUFxf/bskrbQJKAzLQNss3phxjKza62R3KbJ2OJiQ
 HZHaHza/4ftMGA4lrlZr7RypP1oL5pC3RQ9z9kPkG3lGepl8kb5Q0KBTXiDqgwJI1+e6d2KojxV
 6kYuO6gMzllaB2kyJ7gu4/BsW0e0YKMoFMw==
X-Gm-Gg: ASbGnctHJ2O2V+LNvRkSeWkmvV/XfegJ5rRK6nSz34BHmeP9HunQf7QSpnyWAMuYUFG
 PT7QjA38WCkrR8oJF4/Re1TjssJYncImDYjLJvsag1rY3yYmVHkDElKl0dxCLohIt3dntqz6OMt
 gW5B9yQVeCdAhZ4G8OByxZ/pHuNf8g7yTKwsXla5CL3Me0SXkRj6wGG5mXcdcFd7Lij9cJN1s+d
 Ek0+0eDWSgrYITOdceufhFrMNk+RUZO41WQPQ==
X-Google-Smtp-Source: AGHT+IHkfsrhW2YGHA7dWhK8M6/7151TvS1Wx3ntEr/GL4PraSOYl0/8Ft7kq6Q18cZYgmghNRQkFf9+sdDPEC4p6uk=
X-Received: by 2002:a17:907:d90:b0:b40:e267:93dc with SMTP id
 a640c23a62f3a-b40e267e013mr311183266b.24.1759194895689; Mon, 29 Sep 2025
 18:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
 <20250924091746.1882125-6-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-6-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Sep 2025 11:14:29 +1000
X-Gm-Features: AS18NWCesDetdsX5S2nUL8EfjqI0dO8Xv3e0Du-5j1XFnuCgDY-27Th5hT60yZw
Message-ID: <CAKmqyKPB9P2GMn_cjPmFJFKh=fCj8=9Bc6qu=jWHB4K65dSM0g@mail.gmail.com>
Subject: Re: [PATCH v8 05/14] target/riscv: Add mips.ccmov instruction
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Sep 24, 2025 at 7:21=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add mips.ccmov defined by Xmipscmov.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                        |  3 +++
>  target/riscv/cpu_cfg.h                    |  5 ++++
>  target/riscv/cpu_cfg_fields.h.inc         |  1 +
>  target/riscv/insn_trans/trans_xmips.c.inc | 32 +++++++++++++++++++++++
>  target/riscv/meson.build                  |  1 +
>  target/riscv/translate.c                  |  3 +++
>  target/riscv/xmips.decode                 | 11 ++++++++
>  7 files changed, 56 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
>  create mode 100644 target/riscv/xmips.decode
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1a1ea7fe9a..77fbf67776 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -247,6 +247,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b=
),
>      ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>      ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
> +    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>      ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> @@ -1379,6 +1380,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>      MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
>      MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
>      MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
> +    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
>
>      { },
>  };
> @@ -3293,6 +3295,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.pmp =3D true,
>          .cfg.ext_zba =3D true,
>          .cfg.ext_zbb =3D true,
> +        .cfg.ext_xmipscmov =3D true,
>          .cfg.marchid =3D 0x8000000000000201,
>          .cfg.mvendorid =3D MIPS_VENDOR_ID,
>  #ifndef CONFIG_USER_ONLY
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index aa28dc8d7e..2db471ad17 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig =
*cfg __attribute__((__unus
>      return true;
>  }
>
> +static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
> +{
> +    return cfg->ext_xmipscmov;
> +}
> +
>  static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
>  {
>      return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index e2d116f0df..a290303ee7 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
>  BOOL_FIELD(ext_xtheadmempair)
>  BOOL_FIELD(ext_xtheadsync)
>  BOOL_FIELD(ext_XVentanaCondOps)
> +BOOL_FIELD(ext_xmipscmov)
>
>  BOOL_FIELD(mmu)
>  BOOL_FIELD(pmp)
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/ins=
n_trans/trans_xmips.c.inc
> new file mode 100644
> index 0000000000..045034ae32
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_xmips.c.inc
> @@ -0,0 +1,32 @@
> +/*
> + * RISC-V translation routines for the MIPS extensions (xmips*).
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Reference: MIPS P8700 instructions
> + *            (https://mips.com/products/hardware/p8700/)
> + */
> +
> +#define REQUIRE_XMIPSCMOV(ctx) do {              \
> +    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
> +        return false;                            \
> +    }                                            \
> +} while (0)
> +
> +static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
> +{
> +    REQUIRE_XMIPSCMOV(ctx);
> +
> +    TCGv zero, source1, source2, source3;
> +    zero =3D tcg_constant_tl(0);
> +    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
> +    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
> +
> +    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
> +                       source2, zero, source1, source3);
> +
> +    return true;
> +}
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index fbb6c8fb45..26cd11ec00 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -4,6 +4,7 @@ gen =3D [
>    decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddec=
ode_insn32'),
>    decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddec=
ode_xthead'),
>    decodetree.process('XVentanaCondOps.decode', extra_args: '--static-dec=
ode=3Ddecode_XVentanaCodeOps'),
> +  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddeco=
de_xmips'),
>  ]
>
>  riscv_ss =3D ss.source_set()
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9ddef2d6e2..66d31b67d3 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase=
, target_ulong pc)
>  #include "insn_trans/trans_svinval.c.inc"
>  #include "insn_trans/trans_rvbf16.c.inc"
>  #include "decode-xthead.c.inc"
> +#include "decode-xmips.c.inc"
>  #include "insn_trans/trans_xthead.c.inc"
>  #include "insn_trans/trans_xventanacondops.c.inc"
> +#include "insn_trans/trans_xmips.c.inc"
>
>  /* Include the auto-generated decoder for 16 bit insn */
>  #include "decode-insn16.c.inc"
> @@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>
>  const RISCVDecoder decoder_table[] =3D {
>      { always_true_p, decode_insn32 },
> +    { has_xmips_p, decode_xmips},
>      { has_xthead_p, decode_xthead},
>      { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
>  };
> diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
> new file mode 100644
> index 0000000000..fadcb78470
> --- /dev/null
> +++ b/target/riscv/xmips.decode
> @@ -0,0 +1,11 @@
> +#
> +# RISC-V translation routines for the MIPS extension
> +#
> +# Copyright (c) 2025 MIPS
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Reference: MIPS P8700 instructions
> +#            (https://mips.com/products/hardware/p8700/)
> +
> +ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
> --
> 2.34.1
>

