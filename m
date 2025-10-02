Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E944CAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 01:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48FW-00076n-LR; Wed, 01 Oct 2025 21:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v48FP-00073E-Tx
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:36:44 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v48F5-0004qz-Qj
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:36:33 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b4736e043f9so99011766b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 18:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759368977; x=1759973777; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqAIYH4cUrViqday2x3lYOEBhswzh2kJNYw97qnFaoA=;
 b=ER9hJcs5tfIsr88F6Q5Ra8TDxqf8VhTSfCaPecNi9jcQyg2JoxCIVHjnN75ZEWiNaP
 NnM8rBNK5zV3zp29M3lmUL5NNA1rFaslPsygjvLOR8aZFXYYWSaIUNk2NxP/MB0jsBeI
 ziL7mrGWnJUWudYgVRsqo7iOOXtFFTasKAsPWQ7rr1SfozQ8Esj/LIGfTYytaE3aLeoR
 XcMMutqnBtyeyfzcsNzhEaRxUyEOkiwGQkGhdEzNS6FJ7VJoglrMrxcmQB3RBcQ9t3qB
 SS2uI5iv6EW4LbwGjHlkeoZ8r4768HCBkPj7fpjRa5VddI7xa22oHHmyY7YjeJc1dliW
 CMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759368977; x=1759973777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqAIYH4cUrViqday2x3lYOEBhswzh2kJNYw97qnFaoA=;
 b=P1TqMr5/PhN+hBR3PJvMAzrLhCpcP8pTgLpUFvTo1hDOYlAyW5axGa+fnvRpEPuI02
 I5fLhuCUM9EpNCZ71CJqN6sNE1gf+2jceovTBg7q56SnWaADERO8xrl4TaLqg4/sdE1p
 AV0/GyKqFEyyRgPyR6nvUICYVWUvrWG+aWMRf7kaQMw3TU0VJOK/eqn8GOqBI1siWZG+
 T4tqYzsxHQjrVt3Fs/rnShpuUGHZyxMHteUck/GvPhRY9X6D73STivNvcHP8++pDEfaa
 IT4gvfXwTCdXdYuwGt3CFHmFe0H/eiAsAANcuqiPB/uxm2H6W1Qv9191QuuZ2gU/PwEw
 Lylw==
X-Gm-Message-State: AOJu0YyVppEsej3AG0SyVI55VR88M3eun5cffPMndivLxj5hRGgsQJ7X
 8sW8Dl9kg+XmJz00igHIyNFiQx4IBB+jcmvXACPO1C0/NlUfJnY1oqn7EquB5vBf2rblpk7nkPz
 GvLbTjxpN9srzc0CCmjfORxcbSvrrs60=
X-Gm-Gg: ASbGnctETUAxbRDDLfnLYJp7ko+oNeWsbvqGWxk4sdn1XBTMn6C9G/NNVbaGHrkPSn8
 T1D1Yi7kbDWMssVH/GnkZ/AUsKwQqC6sxlqvN5ftgUcn+KUQiyN3nOcn/9DKdJsndM0tTD6Rdih
 qr7EXAQkd5IjltA4aercE3NZ9rZ11GfmChkiJaiRYFDuU/VpUWxxCNd9XZBZQAHi+l4UEiXPwdW
 93wfHab/dLf+z76mlAw9DS4YdekaBYhoZMQYETkVL7TXohkvOzGDr0xTGa4zwC5lJZ4NtMJ
X-Google-Smtp-Source: AGHT+IGNTGOljeUReoRwLdHjNnv8Q75IRA0DHI8O+XxXvsVxISvRkWn0ng+tBewHS5AhE5ExgxvcYT0w+WdqMdFy6GA=
X-Received: by 2002:a17:907:7fa2:b0:b3e:9868:17b with SMTP id
 a640c23a62f3a-b46e516b5bfmr652721266b.19.1759368976565; Wed, 01 Oct 2025
 18:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
 <20251001094859.2030290-8-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-8-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Oct 2025 11:35:50 +1000
X-Gm-Features: AS18NWCxKWisNbA3u6FVSmY5Rr0P7nxEB2vzHKKNWa6YM1ns8CmZQqduvdSmEjc
Message-ID: <CAKmqyKM8XYqcxjSjtomX2kvqcQh6J9SigUjmOqHtbVD-Cc8k1w@mail.gmail.com>
Subject: Re: [PATCH v9 07/13] target/riscv: Add Xmipslsp instructions
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
> Add MIPS P8700 ldp, lwp, sdp, swp instructions.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                        |  3 +
>  target/riscv/cpu_cfg.h                    |  2 +-
>  target/riscv/cpu_cfg_fields.h.inc         |  1 +
>  target/riscv/insn_trans/trans_xmips.c.inc | 88 +++++++++++++++++++++++
>  target/riscv/xmips.decode                 | 23 ++++++
>  5 files changed, 116 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 87f9eb7ac4..964b995269 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>      ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
>      ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
> +    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>      ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> @@ -1383,6 +1384,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>      MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
>      MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
>      MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
> +    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
>
>      { },
>  };
> @@ -3297,6 +3299,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.pmp =3D true,
>          .cfg.ext_zba =3D true,
>          .cfg.ext_zbb =3D true,
> +        .cfg.ext_xmipslsp =3D true,
>          .cfg.ext_xmipscbop =3D true,
>          .cfg.ext_xmipscmov =3D true,
>          .cfg.marchid =3D 0x8000000000000201,
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e4d5039c49..cd1cba797c 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *=
cfg __attribute__((__unus
>
>  static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
>  {
> -    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
> +    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp=
;
>  }
>
>  static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index dd3ee7ba2b..7c624ab677 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -149,6 +149,7 @@ BOOL_FIELD(ext_xtheadsync)
>  BOOL_FIELD(ext_XVentanaCondOps)
>  BOOL_FIELD(ext_xmipscbop)
>  BOOL_FIELD(ext_xmipscmov)
> +BOOL_FIELD(ext_xmipslsp)
>
>  BOOL_FIELD(mmu)
>  BOOL_FIELD(pmp)
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/ins=
n_trans/trans_xmips.c.inc
> index bfe9046153..9a72f3392f 100644
> --- a/target/riscv/insn_trans/trans_xmips.c.inc
> +++ b/target/riscv/insn_trans/trans_xmips.c.inc
> @@ -21,6 +21,12 @@
>      }                                            \
>  } while (0)
>
> +#define REQUIRE_XMIPSLSP(ctx) do {               \
> +    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
> +        return false;                            \
> +    }                                            \
> +} while (0)
> +
>  /* Conditional move by MIPS. */
>  static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
>  {
> @@ -38,6 +44,88 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *=
a)
>      return true;
>  }
>
> +/* Load Doubleword Pair. */
> +static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
> +{
> +    REQUIRE_XMIPSLSP(ctx);
> +    REQUIRE_64_OR_128BIT(ctx);
> +
> +    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
> +    TCGv dest0 =3D dest_gpr(ctx, a->rd);
> +    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
> +    TCGv addr =3D tcg_temp_new();
> +
> +    tcg_gen_addi_tl(addr, src, a->imm_y);
> +    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
> +    gen_set_gpr(ctx, a->rd, dest0);
> +
> +    tcg_gen_addi_tl(addr, addr, 8);
> +    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
> +    gen_set_gpr(ctx, a->rs3, dest1);
> +
> +    return true;
> +}
> +
> +/* Load Word Pair. */
> +static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
> +{
> +    REQUIRE_XMIPSLSP(ctx);
> +
> +    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
> +    TCGv dest0 =3D dest_gpr(ctx, a->rd);
> +    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
> +    TCGv addr =3D tcg_temp_new();
> +
> +    tcg_gen_addi_tl(addr, src, a->imm_x);
> +    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
> +    gen_set_gpr(ctx, a->rd, dest0);
> +
> +    tcg_gen_addi_tl(addr, addr, 4);
> +    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
> +    gen_set_gpr(ctx, a->rs3, dest1);
> +
> +    return true;
> +}
> +
> +/* Store Doubleword Pair. */
> +static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
> +{
> +    REQUIRE_XMIPSLSP(ctx);
> +    REQUIRE_64_OR_128BIT(ctx);
> +
> +    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
> +    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
> +    TCGv addr =3D tcg_temp_new();
> +
> +    tcg_gen_addi_tl(addr, src, a->imm_w);
> +    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
> +
> +    tcg_gen_addi_tl(addr, addr, 8);
> +    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
> +
> +    return true;
> +}
> +
> +/* Store Word Pair. */
> +static bool trans_swp(DisasContext *ctx, arg_swp *a)
> +{
> +    REQUIRE_XMIPSLSP(ctx);
> +
> +    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
> +    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
> +    TCGv addr =3D tcg_temp_new();
> +
> +    tcg_gen_addi_tl(addr, src, a->imm_v);
> +    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
> +
> +    tcg_gen_addi_tl(addr, addr, 4);
> +    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
> +
> +    return true;
> +}
> +
>  /* Move data from memory into cache. */
>  static bool trans_pref(DisasContext *ctx, arg_pref *a)
>  {
> diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
> index 4215813b32..3174f17aa4 100644
> --- a/target/riscv/xmips.decode
> +++ b/target/riscv/xmips.decode
> @@ -8,5 +8,28 @@
>  # Reference: MIPS P8700 instructions
>  #            (https://mips.com/products/hardware/p8700/)
>
> +# Fields
> +%rs3       27:5
> +%rs2       20:5
> +%rs1       15:5
> +%rd        7:5
> +%imm_9     20:9
> +%imm_hint  7:5
> +%imm_v     25:2 9:3               !function=3Dex_shift_2
> +%imm_w     25:2 10:2              !function=3Dex_shift_3
> +%imm_x     22:5                   !function=3Dex_shift_2
> +%imm_y     23:4                   !function=3Dex_shift_3
> +
> +# Formats
> +@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
> +@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
> +@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
> +@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
> +
> +# *** RV64 MIPS Extension ***
>  ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
>  pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
> +ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
> +lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
> +sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
> +swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
> --
> 2.34.1

