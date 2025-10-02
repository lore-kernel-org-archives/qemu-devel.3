Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDCDCAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 01:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48BF-00051i-Up; Wed, 01 Oct 2025 21:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v48BB-000501-Hi
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:32:22 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v48Aw-0003fE-NA
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:32:20 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b3dbf11fa9eso94889766b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 18:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759368719; x=1759973519; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKMEKrqO1YJj+shF70GCJJYLhU8aHK7WLJNQcLbKw4s=;
 b=lUsl9BXoxWeQzX/91QiAdmEYX2IVB/NgzQoxzX7VRCdB5kzLmRDyfWnNyPZJ4U7Dzw
 VLQhDDOaz3yoD4tIkQRWrBBVRxSCSz1bbxd9HLaoUz+M0zseD7uakKdr8ahDY24ynTzD
 5dMg07fpKjmYwztWFUDQTy41cRvPJos2Bvvb10zBkNzC5XwAwa7dAWZHH609B/V850L2
 jleLWQGhxG/MR2FerFdKOqDA0NEzOfPUBwlqUG1usMyIn1OkZXBJzQeJtYudz1MjYQpN
 N7X8Cx1ZrLfGJ0SbR/sEqrTKyZWJboxlnq/LNlvf25OZSPZRegUJRroq+0RV+1y5HXt0
 PrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759368719; x=1759973519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKMEKrqO1YJj+shF70GCJJYLhU8aHK7WLJNQcLbKw4s=;
 b=Q2LB8DS4R9RWMaBboW4nHpd4HaAxiIptNYT4mz3fGxonoCBJsiJ6Ax/p/i5mRyKwZP
 M8t15C7i17WE3zFHXfo2A+k96IJf9Zvro6DKH51vcRWu0Bgt6tcFsCGEd56R+t8RfDjX
 1yMBNb8oHntgQkxOZdQCYWyGz28mg+vrcuZKRR4adcBpxD/ixTt4W1nLbVpZXlvSsyFn
 6fChut+sZuvWNrHcyXw244p980Y0V7R/xKOgYCmKHwwH+wWKfQa51F3rW6JkxFKfOp9J
 PSTUDIH6yjZw7lKRyCAUT6k8imxsHBK4Se4sxCi6h73Rm/KwtKbmeTcShLS6oCdjXyCK
 ezYQ==
X-Gm-Message-State: AOJu0Yxqpf9Fnr0370m/V4XFh/mVM4nOvtowPS47xV7AxQvLr3OUHl0+
 G/HzItUVRsX940FNLwmO4eCkwMKkzy35VL69PlWa53PoT//8/0a+C6MKhhCs+oA4xVSoVs6FcMV
 VNaa9qXVtIZnbzW4zSI3ccQLVxSTVxbo=
X-Gm-Gg: ASbGncsryKy3vjjuM/DYi1kyOLNyWaz9JR01hgDxRzTzu5dQGVpwVIJ5bMgx90c7C48
 GdPC4MuTxiK+hQQVZWPfEkg7RczC55w4641W+UdrZPGKNk5kO2caC06zTOTX98/lvgg9YDci0pg
 ZIh1jcZ+G/QLzwwxaZ+4cUzQNnbHMwpFivQA0EEHOWFQ3LJbXifiyHX2zDhBtAI3iJ9G9B+H18i
 ULAGhFyttN9cVx/iX8n4/VTqi6b5nRToMnKlYX0BivEIhwJzAyp9eunUZ20mA==
X-Google-Smtp-Source: AGHT+IHM5hqUkWweqPMLG/HbsvcPKqZEhyH67XjCRKTWCqL+c59jAP0aWDHuuohTdFBlmHbjPZw27DsWLh69WNJI52c=
X-Received: by 2002:a17:907:2d8d:b0:b3e:aef0:8e36 with SMTP id
 a640c23a62f3a-b46e700b982mr682768766b.51.1759368719030; Wed, 01 Oct 2025
 18:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
 <20251001094859.2030290-7-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-7-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Oct 2025 11:31:32 +1000
X-Gm-Features: AS18NWCCzMM65wE8Xvk_9Z1LDwxxmM4mpHou2jAP3B0Yie--o5JUBVEl21yhk2o
Message-ID: <CAKmqyKMJ6ufgSgmbcreVTw-O9v+P08MjiGFuFOtnS06jAsboSg@mail.gmail.com>
Subject: Re: [PATCH v9 06/13] target/riscv: Add mips.pref instruction
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 1, 2025 at 7:49=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add MIPS P8700 prefetch instruction defined by Xmipscbop.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                        |  3 +++
>  target/riscv/cpu_cfg.h                    |  2 +-
>  target/riscv/cpu_cfg_fields.h.inc         |  1 +
>  target/riscv/insn_trans/trans_xmips.c.inc | 15 +++++++++++++++
>  target/riscv/xmips.decode                 |  1 +
>  5 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 77fbf67776..87f9eb7ac4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -247,6 +247,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b=
),
>      ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>      ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
> +    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
>      ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
> @@ -1380,6 +1381,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>      MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
>      MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
>      MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
> +    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
>      MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
>
>      { },
> @@ -3295,6 +3297,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.pmp =3D true,
>          .cfg.ext_zba =3D true,
>          .cfg.ext_zbb =3D true,
> +        .cfg.ext_xmipscbop =3D true,
>          .cfg.ext_xmipscmov =3D true,
>          .cfg.marchid =3D 0x8000000000000201,
>          .cfg.mvendorid =3D MIPS_VENDOR_ID,
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 2db471ad17..e4d5039c49 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *=
cfg __attribute__((__unus
>
>  static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
>  {
> -    return cfg->ext_xmipscmov;
> +    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
>  }
>
>  static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index a290303ee7..dd3ee7ba2b 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
>  BOOL_FIELD(ext_xtheadmempair)
>  BOOL_FIELD(ext_xtheadsync)
>  BOOL_FIELD(ext_XVentanaCondOps)
> +BOOL_FIELD(ext_xmipscbop)
>  BOOL_FIELD(ext_xmipscmov)
>
>  BOOL_FIELD(mmu)
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/ins=
n_trans/trans_xmips.c.inc
> index 3202fd9cc0..bfe9046153 100644
> --- a/target/riscv/insn_trans/trans_xmips.c.inc
> +++ b/target/riscv/insn_trans/trans_xmips.c.inc
> @@ -9,6 +9,12 @@
>   *            (https://mips.com/products/hardware/p8700/)
>   */
>
> +#define REQUIRE_XMIPSCBOP(ctx) do {              \
> +    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
> +        return false;                            \
> +    }                                            \
> +} while (0)
> +
>  #define REQUIRE_XMIPSCMOV(ctx) do {              \
>      if (!ctx->cfg_ptr->ext_xmipscmov) {          \
>          return false;                            \
> @@ -31,3 +37,12 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *=
a)
>
>      return true;
>  }
> +
> +/* Move data from memory into cache. */
> +static bool trans_pref(DisasContext *ctx, arg_pref *a)
> +{
> +    REQUIRE_XMIPSCBOP(ctx);
> +
> +    /* Nop */
> +    return true;
> +}
> diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
> index fadcb78470..4215813b32 100644
> --- a/target/riscv/xmips.decode
> +++ b/target/riscv/xmips.decode
> @@ -9,3 +9,4 @@
>  #            (https://mips.com/products/hardware/p8700/)
>
>  ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
> +pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
> --
> 2.34.1

