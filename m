Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FACCCFA18
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 01:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIzrx-0001GT-M1; Tue, 11 Nov 2025 20:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIzrh-0001AW-44
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 20:41:42 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIzrf-0008LG-24
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 20:41:40 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b729f239b39so54609666b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 17:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762911697; x=1763516497; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYNY1PhL+a+57b28p45cNB4F1UrmOK6hyjyA5m67VL4=;
 b=B0DWakIIzn8ipZHCvbGv02BtuDqrrQhoug3D9AQG3ykt5WzUVTVJ50gucDIK+zuLKp
 OMZvObTQEjcQJADzdJfwzVzcNPYOIB8p8MnRXLYY8sx/Jjt3zqNFvHgcJ7OQXOP1V6wP
 bjJQkNfowgKMOaT1RJQrREcrm8t58588w8mGsgA4BPH+NM398TbMCen0UTTnR7o87Uoe
 tMuISbRt4mENRLs8Fjk2TLIhh8V0t6+m4uXj35fzT0U1FK3erxaSGibVhXz3VuKGXf4l
 81MDJ21hfvn3li3/kwYj47HmgljXxdPIEofckEnJzgukcP6/TvbE4f50Es+xWZeeSnmZ
 kHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762911697; x=1763516497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OYNY1PhL+a+57b28p45cNB4F1UrmOK6hyjyA5m67VL4=;
 b=lmS0DhnjtYWQ4OY621GLmv2ceJEsnW+Vpm61MDVpGIYw3fKGmz6PqfqRuyF2S6WzHH
 TSMNF2EtJ/pJVEY3WsX6kg3hbOKKSWj65C4PTOJ0DUZPIsvORxRwRwnDFfOog5rdEF//
 MZ0iwUKPXprRctdSvYnAX/hGI9BpWg3L13I5H77oiFp5Q3RZwRyBlXquvGjTNc1+twvr
 L9A6uAHpYOCHKI6hfo8QzbWbAFXySzCw2n3/znZJuXJQvwM1IsVGK82kEC1iC3Wd2vyD
 ar3XVnpsHBPjPvgqY0AWKibDgA3P+sP6aIFAZk+hDo3DvTmE17SeNHKJKRWk1bKxD9i7
 u0RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEnXNxx2D8dsuapG0k/L4BX0Se0VXH6cmjl8e2ndKjsEK3h9jm+uXafkdIjvQqpweyy7QHpj64EtFi@nongnu.org
X-Gm-Message-State: AOJu0Yz13DnDH1XjrPg5Kd7j+dtFdZDApx+0dkPYql3zXfrjGQ8H0Wto
 HvMC7HVY4Bxmyc+tW9FgWW9ni70lth/IqDSYJVMQSdezO5jKGwn7jg/lPFkrs+joJh6QZux5g0z
 ggprPfV4HhgOhYRs47d5p1bO86abBRFw=
X-Gm-Gg: ASbGncvN9JmXPoAwEd5Q0AfSF7VTN+q3wL9yPQf00zbgMC2r7OgsuEJ0gP2xqC2Ecw7
 veyt2rSUo4NWBCZIjCExzH3JDRB7giZsTMZ89iCPFH1fMr4TvjNWP3Nwdo8G+PAFniX2rQCie0v
 FH11e1KeLGd8Ao7DmxspjTyXgEpRVsgBELAkSzbIhdBnfBM1ZxcFwRQSnZiNbVHOEmJhi/Et7e1
 mwh8XfSVse2/HFDMR+vjW7pwa7IkPPvi6P94TL7fL59JkuEDsuVa0KCcvli0wf5f6OoPfgiqunH
 /Q1x82LUgE5Tww4=
X-Google-Smtp-Source: AGHT+IGvPtejJ0bBTf+PRteid/fSuYdzmOoL8tVD2vK4TdgnuOxGEBIbARMWxb5oOR14tcombSSAwNYD1NVZT+cqNek=
X-Received: by 2002:a17:906:730d:b0:b4a:e7c9:84c1 with SMTP id
 a640c23a62f3a-b7331189644mr134065666b.7.1762911696878; Tue, 11 Nov 2025
 17:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20251110090510.84103-1-roan.richmond@codethink.co.uk>
In-Reply-To: <20251110090510.84103-1-roan.richmond@codethink.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 11:41:10 +1000
X-Gm-Features: AWmQ_bkv2g0N_fILFix7BZhEj4LJx4OzD_1r9hdSJY7MpeaoiDwS4ohdf_7jC1I
Message-ID: <CAKmqyKPheAMZt6cn2d4bN2kPxXMrr5Vr8jY5+MBuqhptnc4wjw@mail.gmail.com>
Subject: Re: [PATCH v2] Add RISCV Zilsd extension
To: Roan Richmond <roan.richmond@codethink.co.uk>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
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

On Mon, Nov 10, 2025 at 7:05=E2=80=AFPM Roan Richmond
<roan.richmond@codethink.co.uk> wrote:
>
> This is based on v1.0 of the Zilsd extension [1].
> The specification is listed as in the Ratified state [2],
>  since Jan 30, 2025.
>
> [1]: https://github.com/riscv/riscv-zilsd
> [2]: https://riscv.atlassian.net/wiki/spaces/HOME/pages/16154861/RISC-V+S=
pecs+Under+Development
>
> Reviewed-by: Daniel Henrique barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson  <richard.henderson@linaro.org>
> Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
> ---
> v2:
>   - In `gen_load_zilsd` swapped `dest_gpr` with `tcg_temp_new`, this prev=
ents
>     writing to `r1/r0` in the case where `r0` is the set as `rd`.
>   - Removed unneeded brackets around `a->rd` + c expressions
>
>  target/riscv/cpu.c                      |  2 +
>  target/riscv/cpu_cfg_fields.h.inc       |  1 +
>  target/riscv/insn_trans/trans_rvi.c.inc | 57 ++++++++++++++++++++++++-
>  3 files changed, 58 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73d4280d7c..6e0d37fb96 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -121,6 +121,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> +    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_13_0, ext_zilsd),
>      ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>      ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -1247,6 +1248,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>      MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> +    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
>      MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
>      MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
>      MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index a154ecdc79..8d8e35e4cf 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -41,6 +41,7 @@ BOOL_FIELD(ext_zicond)
>  BOOL_FIELD(ext_zihintntl)
>  BOOL_FIELD(ext_zihintpause)
>  BOOL_FIELD(ext_zihpm)
> +BOOL_FIELD(ext_zilsd)
>  BOOL_FIELD(ext_zimop)
>  BOOL_FIELD(ext_zcmop)
>  BOOL_FIELD(ext_ztso)
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 54b9b4f241..20058bf483 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -18,6 +18,7 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> +#include "migration/multifd.h"
>  static bool trans_illegal(DisasContext *ctx, arg_empty *a)
>  {
>      gen_exception_illegal(ctx);
> @@ -370,6 +371,27 @@ static bool gen_load_tl(DisasContext *ctx, arg_lb *a=
, MemOp memop)
>      return true;
>  }
>
> +/* Zilsd extension adds load/store double for 32bit arch */
> +static bool gen_load_zilsd(DisasContext *ctx, arg_lb *a)
> +{
> +    TCGv dest_1 =3D tcg_temp_new();
> +    TCGv dest_2 =3D tcg_temp_new();
> +    TCGv addr_1 =3D get_address(ctx, a->rs1, a->imm);
> +    TCGv addr_2 =3D get_address(ctx, a->rs1, a->imm+4);
> +
> +    tcg_gen_qemu_ld_tl(dest_1, addr_1, ctx->mem_idx, MO_SL);
> +    tcg_gen_qemu_ld_tl(dest_2, addr_2, ctx->mem_idx, MO_SL);
> +
> +    /* If destination is x0 then result of the load is discarded */
> +    if (a->rd =3D=3D 0) {
> +        return true;
> +    }
> +
> +    gen_set_gpr(ctx, a->rd, dest_1);
> +    gen_set_gpr(ctx, a->rd+1, dest_2);
> +    return true;
> +}
> +
>  /* Compute only 64-bit addresses to use the address translation mechanis=
m */
>  static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
>  {
> @@ -409,6 +431,8 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, Me=
mOp memop)
>      decode_save_opc(ctx, 0);
>      if (get_xl(ctx) =3D=3D MXL_RV128) {
>          out =3D gen_load_i128(ctx, a, memop);
> +    } else if (memop =3D=3D MO_SQ && get_xl(ctx) =3D=3D MXL_RV32) {
> +        out =3D gen_load_zilsd(ctx, a);
>      } else {
>          out =3D gen_load_tl(ctx, a, memop);
>      }
> @@ -437,7 +461,10 @@ static bool trans_lw(DisasContext *ctx, arg_lw *a)
>
>  static bool trans_ld(DisasContext *ctx, arg_ld *a)
>  {
> -    REQUIRE_64_OR_128BIT(ctx);
> +    /* Check for Zilsd extension if 32bit */
> +    if (get_xl(ctx) =3D=3D MXL_RV32 && !ctx->cfg_ptr->ext_zilsd) {
> +        return false;
> +    }
>      return gen_load(ctx, a, MO_SQ);
>  }
>
> @@ -482,6 +509,27 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *=
a, MemOp memop)
>      return true;
>  }
>
> +/* Zilsd extension adds load/store double for 32bit arch */
> +static bool gen_store_zilsd(DisasContext *ctx, arg_sb *a)
> +{
> +    TCGv data_1 =3D tcg_temp_new();
> +    TCGv data_2 =3D tcg_temp_new();
> +    if (a->rs2 !=3D 0) {
> +        data_1 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +        data_2 =3D get_gpr(ctx, a->rs2+1, EXT_NONE);
> +    }

Don't mix code and declarations, otherwise

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +    TCGv addr_1 =3D get_address(ctx, a->rs1, a->imm);
> +    TCGv addr_2 =3D get_address(ctx, a->rs1, a->imm+4);
> +
> +    if (ctx->ztso) {
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
> +    }
> +
> +    tcg_gen_qemu_st_tl(data_1, addr_1, ctx->mem_idx, MO_SL);
> +    tcg_gen_qemu_st_tl(data_2, addr_2, ctx->mem_idx, MO_SL);
> +    return true;
> +}
> +
>  static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
>  {
>      TCGv src1l =3D get_gpr(ctx, a->rs1, EXT_NONE);
> @@ -511,6 +559,8 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, M=
emOp memop)
>      decode_save_opc(ctx, 0);
>      if (get_xl(ctx) =3D=3D MXL_RV128) {
>          return gen_store_i128(ctx, a, memop);
> +    } else if (memop =3D=3D MO_UQ && get_xl(ctx) =3D=3D MXL_RV32) {
> +        return gen_store_zilsd(ctx, a);
>      } else {
>          return gen_store_tl(ctx, a, memop);
>      }
> @@ -533,7 +583,10 @@ static bool trans_sw(DisasContext *ctx, arg_sw *a)
>
>  static bool trans_sd(DisasContext *ctx, arg_sd *a)
>  {
> -    REQUIRE_64_OR_128BIT(ctx);
> +    /* Check for Zilsd extension if 32bit */
> +    if (get_xl(ctx) =3D=3D MXL_RV32 && !ctx->cfg_ptr->ext_zilsd) {
> +        return false;
> +    }
>      return gen_store(ctx, a, MO_UQ);
>  }
>
> --
> 2.43.0
>

