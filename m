Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146C9CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9GeV-00025e-P8; Thu, 16 Oct 2025 01:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9GeT-00025O-Rk
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:35:49 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9GeP-0004Tj-FP
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:35:49 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-634b774f135so462116a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760592944; x=1761197744; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCdFjs4XrjyJI2hjnHLkNo/JMrR4kwrg7b7RfrKnCe0=;
 b=DGwbeCU86Vd1GUdKZ+vij7ub8MZOdkk3IER5lKqoFz+persbmU3skrXpLVLsOz/0QN
 0gSr9RC6GlNS60FTnmDhWPvbdS+g6JpJqtRkPqwNGpBYvD/pLcxY45eKYABcCC1eDgnc
 l/kd98ziFe1c6/vo8oLgZ0u7WqxH9mr+4xx/+cepCDfrx9Afl5W1Uhi/ARpKCa1a/6yn
 pgNltHAVU6mdus3qqflyXIyydNxJmdZ0nsZbtLKDY76b3dR4JiLV97tdQPuTOGSU7xn8
 kHjCmbH22b9BhjTyj+b+jPK4mlNzmk+Ja/uEGhtZybDL83HeMclkjB9Bv+DaD5vvze2r
 BNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760592944; x=1761197744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCdFjs4XrjyJI2hjnHLkNo/JMrR4kwrg7b7RfrKnCe0=;
 b=BcaXvAvfG3gveAHnbK1xBp7fzhi2/47xygYlS27lDW1G4juc/m/VgxOIJfcd4xr8KR
 ahbonnVbPc9XWQ29wMv7UMgDzeFq3u71MzRnNBSRyhulumzRsxWMiD7UNUNlr+FG/nOl
 NrpZiTXcfnMUzy0RSzDnpv8bpy3Pc0Vek3wrc1OOiXDYtXxmpao1L2a6717bI1m5wcSD
 uZcY0DUN6qXVK+5Znbaq6GBR0XupuHBfWKG/tpey4a7vYMkHar09acPLaPIiDmNIHgZh
 +aOHwbi4K7Ms+nubDhD6SzRW2sEMS5WNNi0dgik7v3vwELabXQdAF6fed9UtQuZ754iS
 arow==
X-Gm-Message-State: AOJu0YzhL+7jtn5hfh0XjBY98gjy6eTtjDLxM6wbflwG5h9Uxw9xI0rt
 nGLbsJn8E6bSepx1gsTrZoHswl7Z/WjChi8FijQAe8sMZeDSwUWP6Ax+C7Rjz4yVvhkQPjSfldv
 1UMzIhtiD9qROfPAtsFpFe9amWpN/Bw8=
X-Gm-Gg: ASbGncvmD1ir+u/WoUWOAkVJ8cxWY7ODkm6N1zzgElhM6l09eUXuU1CZy3BPrUUItDL
 jnLafIacD7WqO4MvRwHYs6kx+LcrBu7oldcxhR9cAOQZgQzU4tPMsRkrQkg0Plv5DBcmvGElGwe
 XyBZyRywzApveSmN1PwGBJ2rR+anfc3aiANaB5wM8+8KN3BCYA3MYZvMyN1pUML00IdjJ1vqv/c
 dcTv6T9cP9/NkVSLgaPKj9Lht2zTG77/gJywPZBkIFQdPRCrRF8wrg/D1qGSAP5j9NCKgsUiDAd
 05oXNb//3KCDU5s=
X-Google-Smtp-Source: AGHT+IGhXLvFY4+shr18YC2vMCK7Wnoxd2kXOYMh6TbYQa+H8307P4bxyLsri9D5LikXc1/xqHWQv/rIOrgQNNAMw9E=
X-Received: by 2002:a05:6402:50c7:b0:634:ab36:3c74 with SMTP id
 4fb4d7f45d1cf-639d5b80653mr29414266a12.9.1760592943567; Wed, 15 Oct 2025
 22:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-19-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-19-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 15:35:17 +1000
X-Gm-Features: AS18NWCy14G_3c7flK3W1ZXlpOnsodGr1j1HtiISOtn7-7V08P6DUyMCEpYZRlk
Message-ID: <CAKmqyKPWK0OiYR2XRnea1JttHvhEQ5smRSL55Zbo_qTMvzeAYQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/34] target/riscv: Fix size of ssp
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
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

On Wed, Oct 15, 2025 at 6:39=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> As ssp holds a pointer, fix to 64 bits in size and make sure stores from
> TCG use the correct size to avoid problems on big endian hosts.
>
> Note, the cpu/ssp VMSTATE version is bumped, breaking migration from
> older versions.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h                            |  2 +-
>  target/riscv/machine.c                        |  6 +++---
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 18 +++++++++++++-----
>  3 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d7a41e6db5..2a71393118 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -255,7 +255,7 @@ struct CPUArchState {
>      /* elp state for zicfilp extension */
>      bool      elp;
>      /* shadow stack register for zicfiss extension */
> -    target_ulong ssp;
> +    uint64_t ssp;
>      /* env place holder for extra word 2 during unwind */
>      target_ulong excp_uw2;
>      /* sw check code for sw check exception */
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 1cf744c5f0..c55794c554 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -390,11 +390,11 @@ static bool ssp_needed(void *opaque)
>
>  static const VMStateDescription vmstate_ssp =3D {
>      .name =3D "cpu/ssp",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .needed =3D ssp_needed,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINTTL(env.ssp, RISCVCPU),
> +        VMSTATE_UINT64(env.ssp, RISCVCPU),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv=
/insn_trans/trans_rvzicfiss.c.inc
> index f4a1c12ca0..fa1489037d 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -32,7 +32,9 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspop=
chk *a)
>      TCGLabel *skip =3D gen_new_label();
>      uint32_t tmp =3D (get_xl(ctx) =3D=3D MXL_RV64) ? 8 : 4;
>      TCGv data =3D tcg_temp_new();
> -    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
> +    TCGv_i64 wide_addr =3D tcg_temp_new_i64();
> +    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
> +    tcg_gen_trunc_i64_tl(addr, wide_addr);
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
>                         mxl_memop(ctx) | MO_ALIGN);
> @@ -45,7 +47,8 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspop=
chk *a)
>                    tcg_constant_i32(RISCV_EXCP_SW_CHECK));
>      gen_set_label(skip);
>      tcg_gen_addi_tl(addr, addr, tmp);
> -    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
> +    tcg_gen_ext_tl_i64(wide_addr, addr);
> +    tcg_gen_st_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
>
>      return true;
>  }
> @@ -59,12 +62,15 @@ static bool trans_sspush(DisasContext *ctx, arg_sspus=
h *a)
>      TCGv addr =3D tcg_temp_new();
>      int tmp =3D (get_xl(ctx) =3D=3D MXL_RV64) ? -8 : -4;
>      TCGv data =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGv_i64 wide_addr =3D tcg_temp_new_i64();
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> -    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
> +    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
> +    tcg_gen_trunc_i64_tl(addr, wide_addr);
>      tcg_gen_addi_tl(addr, addr, tmp);
>      tcg_gen_qemu_st_tl(data, addr, SS_MMU_INDEX(ctx),
>                         mxl_memop(ctx) | MO_ALIGN);
> -    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
> +    tcg_gen_ext_tl_i64(wide_addr, addr);
> +    tcg_gen_st_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
>
>      return true;
>  }
> @@ -76,7 +82,9 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a=
)
>      }
>
>      TCGv dest =3D dest_gpr(ctx, a->rd);
> -    tcg_gen_ld_tl(dest, tcg_env, offsetof(CPURISCVState, ssp));
> +    TCGv_i64 wide_addr =3D tcg_temp_new_i64();
> +    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
> +    tcg_gen_trunc_i64_tl(dest, wide_addr);
>      gen_set_gpr(ctx, a->rd, dest);
>
>      return true;
> --
> 2.51.0
>
>

