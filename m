Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17961CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3P2U-000863-GD; Mon, 29 Sep 2025 21:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3P2O-00085u-Oj
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:20:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3P2I-00068L-2v
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:20:15 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b346142c74aso1023837666b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 18:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759195205; x=1759800005; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmL1j9UcZs2NdvkJSgBQZP5cVRDVPeKnhICaWaAClvQ=;
 b=RgwJxaMGnsOEJ3k5d1HZ5RhAq8jGJDoUoXO06IF+OPkV74eLkA45Dsxo0uezSTykAe
 HoGtY3aM1jGc33524f4W4MFL6XLWPJYipRX1oYGIZVvr/8YocjB1A1FcS9qwMw6DI7L7
 Jqt0NPponkr7DPFp7S2+2xB2uSCvSptvowsBkpz5TFK7ke9XiiY41RYMtrGkistp+Faj
 Qng6TG7ad+ASreGz6eAOi1MNd7u9kIuaUsGh/oJCBwIDT2lihQVsuWLQ23J8P24mkMCT
 R36LAd8Tjhy+c8Jo1eN5GQziBtWKI4ZM7zYjR72k/eKRnJnO9y24fc9k7WzgfgkH3QcC
 M9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759195205; x=1759800005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XmL1j9UcZs2NdvkJSgBQZP5cVRDVPeKnhICaWaAClvQ=;
 b=Yr8D4ybIcMwlwsH3KvNLwq0zIhPem6J1uDs/OMtkzBgZrol6wvcxsl9olXmP7PkDtH
 Z4jenIit08B1z05B9GRwIDqpI4OTJA6A8y5mIPQdUOhgbXHEpRXqpRnGVJkEILCWOMjm
 3k7AfzukBvUgL2N5YZszlVVBa2VznuMQpkQKgGcbQ2RMZ6WiLU27FywKZZZn6ybAnq0W
 b2YyoptX848Xsk9xhlBQxsRxnQ2P8e9WQamvFKZxAh9by1ZPrtZytWgwK61E0yKtnaQE
 ywdN8JWpNmDxdeektLQ+WA0rE7shWr7pt0+T5yfhITxEthb3Zs1BSgqrYgorpXgHtOw4
 mZxw==
X-Gm-Message-State: AOJu0YzdRX+subdzem8egzhprAaW4RuuHDTkqD5En/vA2DJiIdQAfc8R
 wHES4I601Zj3IPbuUSNOMBM8pw+AmdEjJxMh3SwlKBrTyLxF58Ksxh2AiXIA4E2vMgNwSPtE6na
 p2sxR847GoMf9OlJCLxLCaoZ0w2v7l1k=
X-Gm-Gg: ASbGncuAeGd/PQ3occspcEznff8JjOqeQ+KHUE9hoie3rBQz2T3Zza3BZ8TWEYbujUs
 oQhcTAUIhoAN3+VqylWEhEJBXTU99NubQitI0v0xTR16gDrLmPbE3bDORS+Pi6YpXppTpQe169i
 DG95897mP8Y3F9AkxEm2pD5eEziQ7WCZiHshW+3VmwC+liG22ta7xOTVdfYoTNdSX4uvkO31IGP
 j24+fWYQzBQq9fIPTN5GPO9f22MtkJ3/XTShHylq8pe1V46Hj6x3Maa4ZVxhg==
X-Google-Smtp-Source: AGHT+IF5+EBoI0TrNl30GY3rJ5CkoMF8uO4t42k6mTMPPqXSGAzgluB/BMcKiI+DyM9vFvl2KSQTLkppo4S5wSvucgM=
X-Received: by 2002:a17:907:940a:b0:b42:e3fb:c950 with SMTP id
 a640c23a62f3a-b42e3fbccdfmr96304166b.42.1759195205179; Mon, 29 Sep 2025
 18:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
 <20250924091746.1882125-7-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-7-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Sep 2025 11:19:38 +1000
X-Gm-Features: AS18NWDqPCOLDx26dsSax0OZNhHKvQcKkOGBT9xu5dmCrZ4W2829q72HlZjUoJE
Message-ID: <CAKmqyKP=DLAZ=io1hSr66sZQuWk7zvsAHi1yXtFYL4DhpU5-mw@mail.gmail.com>
Subject: Re: [PATCH v8 06/14] target/riscv: Add mips.pref instruction
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

On Wed, Sep 24, 2025 at 7:23=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add MIPS P8700 prefetch instruction defined by Xmipscbop.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c                        |  3 +++
>  target/riscv/cpu_cfg.h                    |  2 +-
>  target/riscv/cpu_cfg_fields.h.inc         |  1 +
>  target/riscv/insn_trans/trans_xmips.c.inc | 14 ++++++++++++++
>  target/riscv/xmips.decode                 |  1 +
>  5 files changed, 20 insertions(+), 1 deletion(-)
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
> index 045034ae32..95b8238081 100644
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
> @@ -30,3 +36,11 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *=
a)
>
>      return true;
>  }
> +
> +static bool trans_pref(DisasContext *ctx, arg_pref *a)
> +{
> +    REQUIRE_XMIPSCBOP(ctx);
> +
> +    /* Nop */

Can we add some documentation of these instructions? What does this
and the other instructions do? Maybe just one sentence for each and a
link to a datasheet

Alistair

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
>

