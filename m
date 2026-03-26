Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11643109E530
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5a8r-0006PM-U6; Wed, 25 Mar 2026 22:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5a8r-0006Oy-3z
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:08:13 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5a8p-0007w8-7S
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:08:12 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-668e55bd36bso514185a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774490890; cv=none;
 d=google.com; s=arc-20240605;
 b=XGF/Tw1JIXdP6RZihwg/Nd6/R2E26VCN/0a4A8ljisyYYlRS2ie/XWWJU+N/F4lHou
 5fsav3J2aKYGfye9dRhXYn9SInWmdirkaZo5QPxTaJy/me9pGtYuEyg3xMhpAwdo54+o
 EQoMdv4dMy8TwBiYBX3HIGz6ezwfnJrvlR8jfxn/EUH02ZAfmuzqlr4TRtqHfzAdheuZ
 o6Q0ETMcCI41BhM4EjaM86gcX5u3kLXoIT8nN0ZCknwCstLj/C6FoBS5FYMJBqcrclZv
 1h2FJojtJ1BmvamqjLP5lfxr4rcdJC6z9csGApPthrwI6hAIlgcQkvb/QohLemmQHo0d
 OMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K8teYu27digd8EQrR9LwZ7wrtR40+mfBOeaHOY2yR64=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=gTfuBcJxRDylo65FnMwB7cMOyfB3dOz/SXnDOfs9QRq4/gv+31u5qGSVMl8XVKinDW
 dvDxlvqcd0oONactO5trwfY7RPz4SnzFuEmcQCdQVqX075CnKdZLWQ9DAKf9p/eDz/6R
 TGXCp7C8/FsLJ4K4sPIFeDrG5djbjwbn3oJvWIFPFoS3IIOmFSjOrD/gt5L+D5+wpOxd
 cjvawfBtXNVNAOpGBYyLyRt07NsbYspCZZycx7TsaRG8EYKT3ICc86Ti8FNO6PafjAnv
 RNrH87RSGhm55jhnNOZF2J08tSq2SwvmyaFIkXXAW8rTF6yfXaVBnsGrtZdCVpAhjzWB
 vk0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774490890; x=1775095690; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8teYu27digd8EQrR9LwZ7wrtR40+mfBOeaHOY2yR64=;
 b=FCEdpDY1KCPStbNivVRersj6RBVtzbK+Ktj1N4a3ULP6DvLMMF9xGpRx0Yr0tIoK4Q
 HESQZGxlF3FqmZmxjebkcoY5YAFyyWpaO9SvNVHaH7vGyUkt58ExTLSxHIX34Uigyi6O
 fRuF0ZNZNaLWOwPSRB7n9wFbuJEfTHTueOTfECpEEq9RJ8EdEp0p1xnmYCr9SunNbPj5
 ESWprPBmbdxpqCj7/R1vvTU7h7Uhpg/Tj7Nk9JkX4XssckIuDuiWTAc3oCgTQvHNZKLy
 seqwNbD0Jmgc7oDtBU2kIEUT5unTztKZsQRxjvp68AHQFQorwtI++9IpvN8vgzXZIal7
 X0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774490890; x=1775095690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K8teYu27digd8EQrR9LwZ7wrtR40+mfBOeaHOY2yR64=;
 b=Cg9PKnXkl0/gVmOmpZMnBwf2Riim0qripmauHkBsvbZfalV2xRCW03PmJgNy6yoiQx
 R6uawWlicky+/TrX92xJvrd6PWduO5y2AMA4dQ8MZOkklfxfqnEoB8h+tL+gZCCCbqsM
 kp0pHgpPdaiUdTIspfQ8QB3QbPrV+HvZTMjvWNSkgg/QwgdBKB6erAgCROk1zROR2msl
 GAtGJFN8vPq7bxowhveWqGlgvKHVxfXF8cOcR5MGvAbU1kk9hon7wvoS+pmTrwzPE58E
 5xmxG+tzd1rM8H0b2+WM1yfZYK7RHhSkEVp9ytn6Qr8RRz5r+JOboYtcB8Qr8oRNwzhS
 eswg==
X-Gm-Message-State: AOJu0YyJhnaG+VmG4ZsWWjaggh9KSzCJ397ZKyu9Q4J9B8cKIJsEeCeB
 gpzDm9bzP9iMSRUVKXy2UkFpXovJf97DStg2xRyN/QZ8ENf8us4HyE/bv2TN7QjwMHPJGSUE9wO
 5d4ilhTbxWvZjDtL9GZ//7nAFr3BXFyI=
X-Gm-Gg: ATEYQzxRnlu3Zw94R7xK6gfIng/vZAQlV7yHAxujhg33uwQGr0b48SXD9O36s5bLlcV
 R0+MTsj52XmTmh4/4gRqztnV2mDSOtTHwOG/9cTHGkbqNRgiXEUeG5R9gZpSS6E/opQr/C+5GSL
 S6+yXpZXtg+VQ9PZejUdj5HFNJwXb3T5ou3NbzrYzocEllWqo/dMmDDbK7KnSzbkUNQzTmGhQDe
 t2WBBKeW9NS35D7Xssn0kcCwunQUhe9F8Mr75GWU+DvL0srG4MkGeRLlHcsVf88uzZ3XS/pCvFV
 0mKpsKn1dSBuC2IquZFevsLlensbo5L/EFBurg==
X-Received: by 2002:a17:907:a286:b0:b93:7d70:20a0 with SMTP id
 a640c23a62f3a-b9a3f161d48mr372386166b.4.1774490889240; Wed, 25 Mar 2026
 19:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-6-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-6-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:07:42 +1000
X-Gm-Features: AQROBzABQBPxBf_I3xqf61OlCa8PMjy0dFseMNNiCp9zI3yUlQ9GV9lJbegxzZc
Message-ID: <CAKmqyKMkeZWrCoCcNKoONXuc6-9AxqdTPJAnRK_Q4aSBjuc1gw@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 05/16] target/riscv: Explode MO_TExx -> MO_TE |
 MO_xx (again)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Wed, Mar 18, 2026 at 8:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Following commit 73ae67fd4e6, extract the implicit MO_TE
> definition in order to replace it.
>
> Mechanical change using:
>
>   $ for n in UW UL UQ UO SW SL SQ; do \
>       sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>            $(git grep -l MO_TE$n target/riscv); \
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvzalasr.c.inc | 12 ++++++------
>  target/riscv/insn_trans/trans_xmips.c.inc    | 16 ++++++++--------
>  target/riscv/insn_trans/trans_zilsd.c.inc    |  4 ++--
>  3 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/=
insn_trans/trans_rvzalasr.c.inc
> index bf86805cef6..525f01ca347 100644
> --- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
> @@ -49,20 +49,20 @@ static bool trans_lb_aqrl(DisasContext *ctx, arg_lb_a=
qrl *a)
>  static bool trans_lh_aqrl(DisasContext *ctx, arg_lh_aqrl *a)
>  {
>      REQUIRE_ZALASR(ctx);
> -    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESW));
> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_SW));
>  }
>
>  static bool trans_lw_aqrl(DisasContext *ctx, arg_lw_aqrl *a)
>  {
>      REQUIRE_ZALASR(ctx);
> -    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESL));
> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
>  }
>
>  static bool trans_ld_aqrl(DisasContext *ctx, arg_ld_aqrl *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_ZALASR(ctx);
> -    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TEUQ));
> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
>  }
>
>  static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp m=
emop)
> @@ -96,18 +96,18 @@ static bool trans_sb_aqrl(DisasContext *ctx, arg_sb_a=
qrl *a)
>  static bool trans_sh_aqrl(DisasContext *ctx, arg_sh_aqrl *a)
>  {
>      REQUIRE_ZALASR(ctx);
> -    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESW));
> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_SW));
>  }
>
>  static bool trans_sw_aqrl(DisasContext *ctx, arg_sw_aqrl *a)
>  {
>      REQUIRE_ZALASR(ctx);
> -    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESL));
> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
>  }
>
>  static bool trans_sd_aqrl(DisasContext *ctx, arg_sd_aqrl *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_ZALASR(ctx);
> -    return gen_store_release(ctx, a, (MO_ALIGN | MO_TEUQ));
> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
>  }
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/ins=
n_trans/trans_xmips.c.inc
> index 9a72f3392f1..37572563ae9 100644
> --- a/target/riscv/insn_trans/trans_xmips.c.inc
> +++ b/target/riscv/insn_trans/trans_xmips.c.inc
> @@ -56,11 +56,11 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
>      TCGv addr =3D tcg_temp_new();
>
>      tcg_gen_addi_tl(addr, src, a->imm_y);
> -    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
> +    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TE | MO_SQ);
>      gen_set_gpr(ctx, a->rd, dest0);
>
>      tcg_gen_addi_tl(addr, addr, 8);
> -    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
> +    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TE | MO_SQ);
>      gen_set_gpr(ctx, a->rs3, dest1);
>
>      return true;
> @@ -77,11 +77,11 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
>      TCGv addr =3D tcg_temp_new();
>
>      tcg_gen_addi_tl(addr, src, a->imm_x);
> -    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
> +    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TE | MO_SL);
>      gen_set_gpr(ctx, a->rd, dest0);
>
>      tcg_gen_addi_tl(addr, addr, 4);
> -    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
> +    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TE | MO_SL);
>      gen_set_gpr(ctx, a->rs3, dest1);
>
>      return true;
> @@ -99,10 +99,10 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
>      TCGv addr =3D tcg_temp_new();
>
>      tcg_gen_addi_tl(addr, src, a->imm_w);
> -    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
> +    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TE | MO_UQ);
>
>      tcg_gen_addi_tl(addr, addr, 8);
> -    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
> +    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TE | MO_UQ);
>
>      return true;
>  }
> @@ -118,10 +118,10 @@ static bool trans_swp(DisasContext *ctx, arg_swp *a=
)
>      TCGv addr =3D tcg_temp_new();
>
>      tcg_gen_addi_tl(addr, src, a->imm_v);
> -    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
> +    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TE | MO_SL);
>
>      tcg_gen_addi_tl(addr, addr, 4);
> -    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
> +    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TE | MO_SL);
>
>      return true;
>  }
> diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/ins=
n_trans/trans_zilsd.c.inc
> index 369c33004b6..445406cf015 100644
> --- a/target/riscv/insn_trans/trans_zilsd.c.inc
> +++ b/target/riscv/insn_trans/trans_zilsd.c.inc
> @@ -30,7 +30,7 @@ static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
>      TCGv addr =3D get_address(ctx, a->rs1, a->imm);
>      TCGv_i64 tmp =3D tcg_temp_new_i64();
>
> -    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TE | MO_SQ);
>
>      if (a->rd =3D=3D 0) {
>          return true;
> @@ -85,7 +85,7 @@ static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
>      } else {
>          tcg_gen_concat_tl_i64(tmp, data_low, data_high);
>      }
> -    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TE | MO_SQ);
>
>      return true;
>  }
> --
> 2.53.0
>
>

