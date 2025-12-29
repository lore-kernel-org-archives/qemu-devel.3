Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C6AE8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBOe-0001qP-0l; Mon, 29 Dec 2025 06:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBOZ-0001jR-73
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:26:39 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBOX-00072g-I9
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:26:38 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b832c65124cso423450666b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007596; x=1767612396; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ul3Tv58SXls2jedP06eMUjBkG32sTQXkT+XfhgUOYY=;
 b=fCpoUz9sILjCeFzltSk0cM8SOOEVot3ihcN1hlK8yWQEhNzhqk+ygoRfKoI1CmJ9Rs
 aeIWoYlcgfUCQjGOm6d/0hMTxc2DpbZ6bPg1SnlK+0gWUQMJpJaQcURe0GfHzS1dYl+V
 edwMQ4QMa4lO8A7Q6xcZkDoaZZuSqQ6xFGJJ5/si87789/HuemwViO8zSJMl4XkyVzlw
 yXMVSNk/ZLfiVOKWHJzUwElpV2A3ikzLWfemWDoKoHD7pdRFSuCpZLDLQMXQ0RcfhbUn
 sdr0KVtKyLTjrLqCztoQcjVfn6Il0llmUFEbhxol1EFSx3pzqobdAf5jyplyFGnuC2fH
 dbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007596; x=1767612396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7ul3Tv58SXls2jedP06eMUjBkG32sTQXkT+XfhgUOYY=;
 b=ryZ/wCNNBRYcFI48Kc+eMX7Arg7lOIUV7sJc4l9mouaR9K0h0Tle1/AGeL3WnR4nal
 h1toFu0Lgqntj6U3J3KDuUfLbUro1bUSi16pMVe8fjYQSmidvjd2oJzPSpOJdKP6tKL9
 pnSlrobZmrJsSyJylqbJSJ1uQRnALI+1gvEiosrKstt2I7rKq3hf1L+gEi8VX6eD+9Pk
 +2dO3tP62LAwOmOts/GsLU+pfUjfPudkWNmiEAHKdsw6btHhgWAEMcrU26wI/N1T5eB/
 RR9Yqg/VeJfxU/pM916tofwKlvi27Q90nSprJSkvQOj6p3KCsgTxS8peEx02zKkaoN3K
 Y9pw==
X-Gm-Message-State: AOJu0YxCGciaN+8N2Vodwi3LIPC01khG2ZQJCga6UJ3BcgWzMxyzSYR/
 SJEgrUkuU6+4JWOoyOKFWYU/ezzoiF2aibWyoZGTYfB9jghvSfjyM4Ip2fahhuEHSGBOdGnaEQ8
 yij8RY7xRuvZdshuW6a+bAju+65N+qqLfKnQmhhJJHQ==
X-Gm-Gg: AY/fxX6H/BkJ81JblDMVkRvh5V7UQLWIi+QsiXYKsxYC+sbR0O+nEr/DK9jB7vOUF+P
 BsXb0iks3xJ03kz0ejRETc8LadXfQHm99X+UUfSQNUmW+wXPUX0XEFEI91K+V/58s/VfgpkfReA
 3NWnuqbzTMuXNAsTI2t+GiIURCT/oe7rwF+7XtGUhKuV+tSlm6JRuL+kx0iSmak8i8uiuvnFxLP
 kXzIhdHCtiZrM2dhdn4lUFXXJoyeEp6AuoJCtYjxQYl8P5et1dbeqgrwAlJGBm+8mDwF9fed12t
 0MAfIyNkQ3RW9fNfteKPcVzrXUwTvRUaV7pRcLM=
X-Google-Smtp-Source: AGHT+IEEqDVwcz4e7SBakdrS8E3uUNbGmfXwkr2piwJsBsjmL/TAjC7NoxUA1UkZWFJoTo9SWHEtsdSNUo2PnOuiDwk=
X-Received: by 2002:a17:907:7e9a:b0:b76:6c85:9fd3 with SMTP id
 a640c23a62f3a-b8036960757mr3271624266b.0.1767007595945; Mon, 29 Dec 2025
 03:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20251224163304.91384-1-philmd@linaro.org>
 <20251224163304.91384-4-philmd@linaro.org>
In-Reply-To: <20251224163304.91384-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:26:09 +0200
X-Gm-Features: AQt7F2qv7_7en7hIz9nIy8MoSomSoEY5XdymrfvxNDl6Md_uJaj2hwyOoRH3oEk
Message-ID: <CAAjaMXaDGu4hGkd2-LG-Tqeuy-v+4+7JXxrvy7QrybSwCfQvtw@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/rx: Inline translator_lduw() and
 translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Dec 24, 2025 at 6:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> translator_lduw() and translator_ldl() are defined in
> "exec/translator.h" as:
>
>   192 static inline uint16_t
>   193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   194 {
>   195     return translator_lduw_end(env, db, pc, MO_TE);
>   196 }
>
>   198 static inline uint32_t
>   199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   200 {
>   201     return translator_ldl_end(env, db, pc, MO_TE);
>   202 }
>
> Directly use the inlined form, expanding MO_TE -> MO_LE
> since we only build the Renesas RX target as little-endian.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/rx/translate.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/rx/translate.c b/target/rx/translate.c
> index ef865f14bf5..d2f73221952 100644
> --- a/target/rx/translate.c
> +++ b/target/rx/translate.c
> @@ -101,16 +101,16 @@ static uint32_t li(DisasContext *ctx, int sz)
>          return (int8_t)translator_ldub(env, &ctx->base, addr);
>      case 2:
>          ctx->base.pc_next +=3D 2;
> -        return (int16_t)translator_lduw(env, &ctx->base, addr);
> +        return (int16_t) translator_lduw_end(env, &ctx->base, addr, MO_L=
E);
>      case 3:
>          ctx->base.pc_next +=3D 3;
>          tmp =3D (int8_t)translator_ldub(env, &ctx->base, addr + 2);
>          tmp <<=3D 16;
> -        tmp |=3D translator_lduw(env, &ctx->base, addr);
> +        tmp |=3D translator_lduw_end(env, &ctx->base, addr, MO_LE);
>          return tmp;
>      case 0:
>          ctx->base.pc_next +=3D 4;
> -        return translator_ldl(env, &ctx->base, addr);
> +        return translator_ldl_end(env, &ctx->base, addr, MO_LE);
>      default:
>          g_assert_not_reached();
>      }
> @@ -206,7 +206,8 @@ static TCGv_i32 rx_index_addr(DisasContext *ctx, TCGv=
_i32 mem,
>          ctx->base.pc_next +=3D 1;
>          return mem;
>      case 2:
> -        dsp =3D translator_lduw(ctx->env, &ctx->base, ctx->base.pc_next)=
 << size;
> +        dsp =3D translator_lduw_end(ctx->env, &ctx->base, ctx->base.pc_n=
ext,
> +                                  MO_LE) << size;
>          tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
>          ctx->base.pc_next +=3D 2;
>          return mem;
> --
> 2.52.0
>

