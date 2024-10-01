Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CD9CEACC5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdYx-0001rj-Hn; Tue, 01 Oct 2024 10:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1svdYw-0001pr-1a
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:09:14 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1svdYu-00029j-5C
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:09:13 -0400
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7a99fd4ea26so481857685a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 07:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727791751; x=1728396551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8xgpnbokG+om7dpAa9n6IsHIRK4ZSoeDZAnfFMhIiAY=;
 b=nN7SnVrmnHbNrlzc4vB/gl8y7Wgdt6b65aXnzoyMg6ux1JJgodRpBR0ZRGmDVT0CMz
 xyyiXCSgIdcZsV6W0W358eYxywL9zS/lMn8zhe69jaEpVXd8C+QK+0v+BvsnQ32IezbO
 e0w1gZBg/VK13SF4QVN6lk4pVAcqbYa3R8bFyAZ10ZZQecmhoqrz5voXhnGu467o+D5y
 1+vDpzQr1vs1BF1vXqgu76q/ozODBYkBvA2smipRhWS0//W7SmG/NmRu7AkAsT1MqAFE
 aSvHgtoaKX+xHyIon8vEuYqQv/UdF5mXHY0XryRpu3Vm/XuWpZGAWrJd/NzNVjSpVljO
 1YGA==
X-Gm-Message-State: AOJu0Yyn1SRGBdTdCocS+vFDr6llXGawTi4iIKgiDKuyDsrryF07TYar
 yqrxCKHZfN39fJBp8UBQNwlbK0tSz5ylFXpsvsvesgAzxDXUHNcolKSknnUNxikJJezmuUasCAJ
 8U/PSGUmYRKn+UIewi5iirFd0U3PBg50Y
X-Google-Smtp-Source: AGHT+IGwrOONTaI58XAUyNq/rtXt0rc60zwjWM4UmEdl0aYePxSKYF+/nkVkdMLGx7MZhmjlBFO3mFBbDvz4H4MlqNA=
X-Received: by 2002:a05:6e02:18ca:b0:3a0:986e:e112 with SMTP id
 e9e14a558f8ab-3a3452d0434mr125571375ab.23.1727776592094; Tue, 01 Oct 2024
 02:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240930091101.40591-1-philmd@linaro.org>
 <20240930091101.40591-7-philmd@linaro.org>
In-Reply-To: <20240930091101.40591-7-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 1 Oct 2024 11:56:19 +0200
Message-ID: <CAAdtpL4EQh9jRMeXSQ=qX6XgL6tXJV+=_d_Dn44QNbtos3PVhA@mail.gmail.com>
Subject: Re: [PATCH 06/12] target/mips: Explode MO_TExx -> MO_TE | MO_xx
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.222.171;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qk1-f171.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 30, 2024 at 11:12=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Extract the implicit MO_TE definition in order to replace
> it by runtime variable in the next commit.
>
> Mechanical change using:
>
>   $ for n in UW UL UQ UO SW SL SQ; do \
>       sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>            $(git grep -l MO_TE$n target/mips); \
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/mips/tcg/mxu_translate.c           |   8 +-
>  target/mips/tcg/translate.c               | 120 +++++++++++-----------
>  target/mips/tcg/tx79_translate.c          |   8 +-
>  target/mips/tcg/micromips_translate.c.inc |  22 ++--
>  target/mips/tcg/mips16e_translate.c.inc   |  12 +--
>  target/mips/tcg/nanomips_translate.c.inc  |  32 +++---
>  6 files changed, 101 insertions(+), 101 deletions(-)
>
> diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_transl=
ate.c
> index c517258ac5..b221f7a4a0 100644
> --- a/target/mips/tcg/mxu_translate.c
> +++ b/target/mips/tcg/mxu_translate.c
> @@ -1533,7 +1533,7 @@ static void gen_mxu_s32ldxx(DisasContext *ctx, bool=
 reversed, bool postinc)
>      tcg_gen_add_tl(t0, t0, t1);
>
>      tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
> -                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
> +                       (MO_TE | MO_SL ^ (reversed ? MO_BSWAP : 0)) |

Hmm either I need to use parenthesis here or swap the arguments.

>                          ctx->default_tcg_memop_mask);
>      gen_store_mxu_gpr(t1, XRa);
>
> @@ -1569,7 +1569,7 @@ static void gen_mxu_s32stxx(DisasContext *ctx, bool=
 reversed, bool postinc)
>
>      gen_load_mxu_gpr(t1, XRa);
>      tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
> -                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
> +                       (MO_TE | MO_SL ^ (reversed ? MO_BSWAP : 0)) |
>                          ctx->default_tcg_memop_mask);
>
>      if (postinc) {
> @@ -1605,7 +1605,7 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, boo=
l reversed,
>      tcg_gen_add_tl(t0, t0, t1);
>
>      tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
> -                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
> +                       (MO_TE | MO_SL ^ (reversed ? MO_BSWAP : 0)) |
>                          ctx->default_tcg_memop_mask);
>      gen_store_mxu_gpr(t1, XRa);
>
> @@ -1675,7 +1675,7 @@ static void gen_mxu_s32stxvx(DisasContext *ctx, boo=
l reversed,
>
>      gen_load_mxu_gpr(t1, XRa);
>      tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
> -                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
> +                       (MO_TE | MO_SL ^ (reversed ? MO_BSWAP : 0)) |
>                          ctx->default_tcg_memop_mask);
>

