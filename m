Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43634109E530
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5a7M-0005V7-5Y; Wed, 25 Mar 2026 22:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5a7L-0005Un-Fs
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:06:39 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5a7J-0007eI-SH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:06:39 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b97ba4c2be2so62170666b.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774490795; cv=none;
 d=google.com; s=arc-20240605;
 b=GYdxHeVLTS/AvsQTde9FFUO0gXrVjC+bSpoJwdg4i3fOaM+V77Xmy7OdihfKc7vYKw
 AN3RufbOHYWysHZmTFjPyOAUXtTpevEMa0two1yCwLnbJqRHXmpuJzoWPZXdn54ywl3e
 Ria3DlKxBHDPmWPvmqWN9PqbNJ35ryv8b5Ku6v8+VPQkqLbGzPWAmHv2AQHcrWfR4V3W
 MX6cXSwkU0+S7UkrZi3f5aUtfMkE/xcFXgEZ6GV+MOfI12S1iramI6sW7e5f+/3h66Fs
 ldozIV65g2OplTVf+MznR3TT1K0PQR/unJJF5ES16UoL39IieC70y+MO79weJe2J1J1b
 A7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ltQDW/PsjDZM1P5ztoIk6TbC2t56JUfC/0R+VubppuA=;
 fh=lFUxkpoCM9hr82iqiiFa4Ds135/KBT9UcU7ZSzbCbFA=;
 b=XsOcNLPBvA25R3nC8pELMM2Oje6ZN5MdcCS/N4sYzAOLWNof4XVGKEP9PSTttD5AY6
 Mk3KtgS2DQJHvB6mJRfPnVmnTV23ejCwTTtLaIm5T0Fko+bPNMVnWIlNHrm+XLbQqcoF
 0eIV1k49Io68fOsSqA/cITAQT/ZkIjVcRm/clDFDhTlTnSdkO9PwJJGXDc49lq0V/ilu
 q7Ksi6VXReL6RZGwYXHq0/JX++Az/neqcwyP8w7EexZJlLXFYJeSKqXqG9dkmAbrCgJ0
 D1NIcvUtr+4/bYMSGut52vmyACtlwBQYmp78yY3aiZtkAdXvFzlCSfx6yoAb5mnIf93G
 dOEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774490795; x=1775095595; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltQDW/PsjDZM1P5ztoIk6TbC2t56JUfC/0R+VubppuA=;
 b=mGKfLDncbZGKSszuCaYZdV39TlSYqp1RL6BA6FIy3Tf0B9Q4GqsyPBCj+XtXB1YdEO
 rlihjsqhzBiQuF905wBgWzwoOwYTwdaklAdlZRQ/AXHxHBdj4HSIyR72Hb5hb/ATq4mt
 Eiray39YCSks5xUX/miRDDs7dLPHAJmMEMkKh3EatIfeieDG1hdHQUnt+/2njtjZ9t5Z
 v6l3GLqqBSibGQwHOmudJi736N7DZLLT74gYY9mQ7I7m934bjPPBzCyOO7ZfDOZlxvIW
 QyOIWjhOCRbVRckQiRPceC19+fmGXXLmH2loIfUPcAjqZX0eWbFyFcR3EATCn27UokL8
 m6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774490795; x=1775095595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ltQDW/PsjDZM1P5ztoIk6TbC2t56JUfC/0R+VubppuA=;
 b=BTOVvLZSZTC7XxhaG+p0FWx4yQuDgnUWXyOsQ1uIUhkwpGc/LUoMqAJEHxm4UGRx1J
 WRW70oBrc9bieHNVaeu6r5u2CKm9XtCj9IkH+1gFit8TG07pHJXDRQkBlqe5uXd+rgoL
 h/XGhmOe4CKq23pl5rDaOEtS2Zv5rEWddpLtVrU8dEH/TJ2XLZYOE8eTbrHgFbKhAWAE
 j1LxvfFqiA/WNXxJWdzB9t+3cM84IsGS6q4kxiybke3KR/FP44oSpluOD27v9frURNCu
 qUXwUJMK+9Nc5T6ZG+L0yctpCIUZWl6jRj/dir11pzzXVuOm0zJ9/OTn7jjmYuoJF6i6
 eITg==
X-Gm-Message-State: AOJu0YylR7NRYuam7ag77yOSWb3YtDgyakD/KIHLs6Q7fsKlj0uPRmpd
 RjSw5NkhkynAYO07dy/ipOtB/T4loYW5vgjf0T4j8F5Hg042dEbZ6nnTpM1LKAqPYtKO2FNZ+He
 0GtOSdOvkR4lWOoPLTCeRYC8fMXn9OkQ=
X-Gm-Gg: ATEYQzzkwn96lOMFxV9vYKbpr69TknZWnPybROlZc44aNhxebfOGAQw9BNuL2MHs0Si
 aT5K+1GjOtJhZ6QkzqsLD4CfVPXwTcv42/CCuxEB160csdn/pCVqxQkblvDl/fdF+l+bFl/lYdJ
 gKZdyc0du4YQ1em4ajJEtbP1xfwmI1Rdk/HShpvWyRcS//kT2/6f/QEo/eG+Pm1GY2jB6BAmjsn
 Gz6G6jwNFR3VacqIPiedM7bhO94FixE/2zhY8Da+3CQtWWggb+6vwsmaSO/mWvx/v8tvVEV7qG9
 BTImxkpHE5lJMioiBast2l/WsNzPSunbOiflVQ==
X-Received: by 2002:a17:906:35c9:b0:b98:667:2e1d with SMTP id
 a640c23a62f3a-b9a3f1b0cb7mr282045966b.25.1774490794337; Wed, 25 Mar 2026
 19:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-4-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-4-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:06:08 +1000
X-Gm-Features: AQROBzBK9UvDAX6qerJ0r_r0-FIKhiMxPmcMjWfNegpd7VqVcdbHLqKQx0pRvas
Message-ID: <CAKmqyKNHo9d7waRTq9osMCQPsf1ZXdt=4DWo89M8hjip5xoBqQ@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 03/16] target/riscv: Make LQ and SQ use 128-bit
 ld/st
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
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

On Wed, Mar 18, 2026 at 8:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> From: Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-grenoble-alpes=
.fr>
>
> The lq and sq helpers for the experimental rv128 architecture
> currently use direct memory accesses.
> Replace these direct accesses with the standard
> tcg_gen_qemu_{ld,st}_i128 TCG helpers that handle endianness
> issues.
>
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-greno=
ble-alpes.fr>
> Message-ID: <20260101181442.2489496-2-frederic.petrot@univ-grenoble-alpes=
.fr>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvi.c.inc | 32 ++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 54b9b4f2413..2c82ae41a77 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -377,6 +377,9 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *=
a, MemOp memop)
>      TCGv destl =3D dest_gpr(ctx, a->rd);
>      TCGv desth =3D dest_gprh(ctx, a->rd);
>      TCGv addrl =3D tcg_temp_new();
> +    TCGv_i128 t16 =3D tcg_temp_new_i128();
> +    TCGv_i64 tl =3D tcg_temp_new_i64();
> +    TCGv_i64 th =3D tcg_temp_new_i64();
>
>      tcg_gen_addi_tl(addrl, src1l, a->imm);
>
> @@ -388,10 +391,14 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb=
 *a, MemOp memop)
>              tcg_gen_movi_tl(desth, 0);
>          }
>      } else {
> -        /* assume little-endian memory access for now */
> -        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, MO_TEUQ);
> -        tcg_gen_addi_tl(addrl, addrl, 8);
> -        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, MO_TEUQ);
> +        tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
> +        if (mo_endian(ctx) =3D=3D MO_LE) {
> +            tcg_gen_extr_i128_i64(tl, th, t16);
> +        } else {
> +            tcg_gen_extr_i128_i64(th, tl, t16);
> +        }
> +        tcg_gen_trunc_i64_tl(destl, tl);
> +        tcg_gen_trunc_i64_tl(desth, th);
>      }
>
>      gen_set_gpr128(ctx, a->rd, destl, desth);
> @@ -488,16 +495,25 @@ static bool gen_store_i128(DisasContext *ctx, arg_s=
b *a, MemOp memop)
>      TCGv src2l =3D get_gpr(ctx, a->rs2, EXT_NONE);
>      TCGv src2h =3D get_gprh(ctx, a->rs2);
>      TCGv addrl =3D tcg_temp_new();
> +    TCGv_i128 t16 =3D tcg_temp_new_i128();
> +    TCGv_i64 tl =3D tcg_temp_new_i64();
> +    TCGv_i64 th =3D tcg_temp_new_i64();
>
>      tcg_gen_addi_tl(addrl, src1l, a->imm);
>
>      if ((memop & MO_SIZE) <=3D MO_64) {
>          tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, memop);
>      } else {
> -        /* little-endian memory access assumed for now */
> -        tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, MO_TEUQ);
> -        tcg_gen_addi_tl(addrl, addrl, 8);
> -        tcg_gen_qemu_st_tl(src2h, addrl, ctx->mem_idx, MO_TEUQ);
> +
> +        tcg_gen_ext_tl_i64(tl, src2l);
> +        tcg_gen_ext_tl_i64(th, src2h);
> +
> +        if (mo_endian(ctx) =3D=3D MO_LE) {
> +            tcg_gen_concat_i64_i128(t16, tl, th);
> +        } else {
> +            tcg_gen_concat_i64_i128(t16, th, tl);
> +        }
> +        tcg_gen_qemu_st_i128(t16, addrl, ctx->mem_idx, memop);
>      }
>      return true;
>  }
> --
> 2.53.0
>
>

