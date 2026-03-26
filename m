Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E194A109E535
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5a9f-0006si-6u; Wed, 25 Mar 2026 22:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5a9c-0006sN-Aj
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:09:00 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5a9a-0007yU-N2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:09:00 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-66a9a2187a5so688954a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774490937; cv=none;
 d=google.com; s=arc-20240605;
 b=ATA4V7kDnmSvfM9lpGBe4tZt6EhwvIABBwBvuNwjaQdfJd8xB15jl33+jlHx8AWdE/
 FYvWUn1BTlp+aMrWk8CHkvhDkby6KeFvjhacKXjweNBspRy8Ziy4DhqLdpyblMrIL3yg
 da+q9QydKxWA/gZU3B8qEjXXjS8+wyk+fmMroR5E2ZW/Bd5L+mux9kr6v5pARrVFbWf6
 4D1uEigBt8CUh5xzyjIlCw9e7Rkc+bA352pHneoYQ0CEX9nPgI+uXBVtB+DDfWcrJJ1h
 SijyKXmxoZd5npOeEvwczAnP4L1zlKA5Iv9ueWmFlDhChlj71nWdPwRLTwTceHZNzP5g
 3Fgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pokoASXITZz+FjH47nfafnqwOjIboGvs6RL+ukQljv0=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=WUaq8Ta1jXJQT+Sr5SbL68rA3138VMdipXUMWeTsR4hgQS+9hO9JwSwqP72Yc34Nqi
 AYz8p+A9we0LHF3QLSuLIhHqjrVEV+KEF5k5SAblSWdoiSSNFqEFKfvtLhmMEioIyP4z
 YBATqxxirmdPhfPyv7GK6N9XgxYkoJ3MnmmwBJbaD/nSSGTjQuQ6v8r0mLv+oPCytHjt
 DDZ7F44pZrnDFB4B/kPdT5K/qC6EwzNXYefevbAxQ6A41u516XC4WSJtmpJFWfq7zZ5F
 xXYmi9d8tv1JGjnDGN2iZY9Dp3x21UfJjakTVuQiKKMZjpxBhKIc5qPHksWDA+CieIix
 rpLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774490937; x=1775095737; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pokoASXITZz+FjH47nfafnqwOjIboGvs6RL+ukQljv0=;
 b=pKo7eucW2ULgrq5KLx741G/NwpuINjYZgqFmJ3iJLtXCCmE76IFqi3suXXKQIAXeBi
 SKT+jaQXPhsLcwIoMbnhdU4+uGGtZiFVOTzFlBIOJa3duKXvjKpg7nlL3sccKm9yMXjp
 jWsgOdtqFIrf3rGoCVoKqXTrgix1I+2TefTJYkL1zKvUc5I6F8+ySDX33rsk0/vsG0+R
 Ok6EOqvsv5JhD2aeOFI8IrvU0XZpe71UiOEnELXddg6gpeWEBTl53591m/JRoaRecCbr
 Aff90uWJ8EZNecnBAVgZEWujcVfzAyG5zX+e5a5x2ZSAt/AD8BpgcsaFgkhLSZg7utFL
 fw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774490937; x=1775095737;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pokoASXITZz+FjH47nfafnqwOjIboGvs6RL+ukQljv0=;
 b=IT4ToJHNZCDOFcM51R+DMnzLxkl3HirdkCnWblAwqE/8jW3Z5WnkspnVti3o0lvlht
 Di7v7QHXeIOyl5XWTEc05On9JSKnWvn2j3KGB3jO+WtVf3NebVi7o1riAcjIZBnvfl1j
 NfWVdIReHYkNWOO1B07RQ/cCwSyw4E0w/eyO8aUbAjShMr9EWJRknMqsTvNB1VAEkVLX
 fN93tgy1I0XayAsbCrvS9xbmnmF/JCFMvFmWb4qUfuyvn/O05sTP90m7iviYkRH/j2hL
 04tEluWlsDVby1iX5Xi38RuVTNgHlh6ercV2tzQfEMbtuRcsnF0MT6ZqKaunEGcbAmx3
 bVTQ==
X-Gm-Message-State: AOJu0Yy4O/BcPZQLA+Hw5r9wN7Xu2ehs6/jyHzcRjufwiQRtWiuUnfs9
 9BOEFA1av1AAEXMjVq/r3i5Yrq+NeHfN56tTl9156UuXEW2l4bBOWgwbh8p8rq3qnDv0HU0cbRA
 jEwj9T9BU/MR6iGHYfvFP/XNTlxhcOUw=
X-Gm-Gg: ATEYQzwi+BMMpfn7eEZN1IMAxU9nEyCNJQKdP06G0aG4GN3Qr2Ds6Bc7LiRXIUBH3dD
 6CdOocBiLbhiH0fUdZdiTzAhd9KrTmj++4hBId1DhUSRbvQxXplLpu/jjVg+G3V5ZqdbxkPQCDs
 WTufP7SPZqXDVFuoT/NJLtmtQy6td9KFmfciAWNoy+xRPYTP8s+tY6/rTdzz9wJ9GIkgRwUa5IN
 dIsRRTHP2T86uKXx8hTUcyp5s+gSZeXDEXJ89HXlOXt3YsOwUhR5LNCqLG8rDYZ8Dmk3LUqhQx8
 EcYPrnCb4ZOSfvOCORsqDoOrpKy5sxVudmNZQA==
X-Received: by 2002:a17:906:99d0:b0:b8f:848b:4456 with SMTP id
 a640c23a62f3a-b9a3f17daeemr375182966b.13.1774490937051; Wed, 25 Mar 2026
 19:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-7-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-7-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:08:30 +1000
X-Gm-Features: AQROBzBFyPfMOYLwMqXXk8khpnb4LbBOpiLzUluGgMq20bhdOaG3dzw-g87_Qu0
Message-ID: <CAKmqyKObjZs0gmkaU6Vd_kW6zD028gTbcEpdE7ORJBDdSUaM4g@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 06/16] target/riscv: Conceal MO_ALIGN|MO_TE
 within load_acquire / store_release
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
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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
> All callers of gen_load_acquire() and gen_store_release() set both
> the MO_ALIGN|MO_TE flags. Set them once in each callee.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvzalasr.c.inc | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/=
insn_trans/trans_rvzalasr.c.inc
> index 525f01ca347..2b1f73f650b 100644
> --- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
> @@ -29,6 +29,7 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_=
aqrl *a, MemOp memop)
>          return false;
>      }
>
> +    memop |=3D MO_ALIGN | MO_TE;
>      memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
>
>      tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
> @@ -43,26 +44,26 @@ static bool gen_load_acquire(DisasContext *ctx, arg_l=
b_aqrl *a, MemOp memop)
>  static bool trans_lb_aqrl(DisasContext *ctx, arg_lb_aqrl *a)
>  {
>      REQUIRE_ZALASR(ctx);
> -    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_SB));
> +    return gen_load_acquire(ctx, a, MO_SB);
>  }
>
>  static bool trans_lh_aqrl(DisasContext *ctx, arg_lh_aqrl *a)
>  {
>      REQUIRE_ZALASR(ctx);
> -    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_SW));
> +    return gen_load_acquire(ctx, a, MO_SW);
>  }
>
>  static bool trans_lw_aqrl(DisasContext *ctx, arg_lw_aqrl *a)
>  {
>      REQUIRE_ZALASR(ctx);
> -    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
> +    return gen_load_acquire(ctx, a, MO_SL);
>  }
>
>  static bool trans_ld_aqrl(DisasContext *ctx, arg_ld_aqrl *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_ZALASR(ctx);
> -    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
> +    return gen_load_acquire(ctx, a, MO_UQ);
>  }
>
>  static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp m=
emop)
> @@ -78,6 +79,7 @@ static bool gen_store_release(DisasContext *ctx, arg_sb=
_aqrl *a, MemOp memop)
>          return false;
>      }
>
> +    memop |=3D MO_ALIGN | MO_TE;
>      memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
>
>      /* Add a memory barrier implied by RL (mandatory) and AQ (optional) =
*/
> @@ -90,24 +92,24 @@ static bool gen_store_release(DisasContext *ctx, arg_=
sb_aqrl *a, MemOp memop)
>  static bool trans_sb_aqrl(DisasContext *ctx, arg_sb_aqrl *a)
>  {
>      REQUIRE_ZALASR(ctx);
> -    return gen_store_release(ctx, a, (MO_ALIGN | MO_SB));
> +    return gen_store_release(ctx, a, MO_SB);
>  }
>
>  static bool trans_sh_aqrl(DisasContext *ctx, arg_sh_aqrl *a)
>  {
>      REQUIRE_ZALASR(ctx);
> -    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_SW));
> +    return gen_store_release(ctx, a, MO_SW);
>  }
>
>  static bool trans_sw_aqrl(DisasContext *ctx, arg_sw_aqrl *a)
>  {
>      REQUIRE_ZALASR(ctx);
> -    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
> +    return gen_store_release(ctx, a, MO_SL);
>  }
>
>  static bool trans_sd_aqrl(DisasContext *ctx, arg_sd_aqrl *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_ZALASR(ctx);
> -    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
> +    return gen_store_release(ctx, a, MO_UQ);
>  }
> --
> 2.53.0
>
>

