Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EDDCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE28T-0000Ka-ID; Wed, 29 Oct 2025 05:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE28N-0000Gi-Kp
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:06:23 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE289-0003kV-Rg
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:06:22 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b4f323cf89bso1653426166b.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761728764; x=1762333564; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfivwcAV8lV0ugr8GXnfVmjPdjVqFmGNUu+eUNthIL0=;
 b=O0dGEzgsfz6nE2p13OE/fiEBmGqCyBa7GQ/G9V//oKc9WL8nfRVgmCEhbQoFhBeycC
 hHZ3SRmWlz9f4c2vXkVAwqgD7pnS7/gi20QgBREk8z70IcU4Ft3Q4LNcgbXUVsHN3JcX
 kQ8xSvKORnhLesuKJBlwoiSSERwVW4s2DceGnzq1Le8NL7EdiQvsU0NsOqEzdYy3VIkU
 meS8hdF0IJIFaigo2yaY1LRnUEzirsYm7U7f/k4FnFHmWiOZ6hyije5vYCS++dJ5n1vw
 xAdGKxiTipYCyCKPQjWXfAgNwshdBD7DQbOe0EyV+X608TCslCy+QOFRLWGobTa3U4uK
 iVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761728764; x=1762333564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfivwcAV8lV0ugr8GXnfVmjPdjVqFmGNUu+eUNthIL0=;
 b=ZsnTzadxvggSO4WsD/S1o9j0VO1MhfN3h9FlnvmjD7c3JucRwUArcWfXBVw8fb/o6l
 P29eBIopOE8x0u9wYiCAlBfMdgpamDX22waRLB76g3vIMxfKyAfzpaN80oXEjvDuWgHH
 5dBrkVnzjV8G+KBOp8W5NNLATBguXnlXK61vZ15kX3vNSEk98yxUKMvJSDJhpnMKQ9tM
 DZYE0Sw28v+RP3l/XoD3f2Lad/I+WYmM4/sQJ3g48hHjBXOcLG5Wjc4VxhEvaUR6vAc2
 xq6jr13RZEgLv5drDFgEf5aJL/ojRMD7fJfclb3ysWxRgAYlqLEgOsSPO7A76/bh6iH3
 TPaQ==
X-Gm-Message-State: AOJu0YxaS0s4bfWiT71wDhchOaEh8m90AJGdzDp+oiQNsYNu2PEFSYp8
 1BuyoTtv/aK440vcOUo46j1FH43ge9gbOSXOCSAGFAlGYX4cemCCYQUjP1zWy+iUZsSYDyb0cYm
 yK/ah8T99BW3EY/espAQL+/cX3yuaHSwi4yJ7xjTurw==
X-Gm-Gg: ASbGncvQ5jbFeWeSUoGnI5ZVlzO+4eJN5AbrvzeDIj/QS9a8Q4oX+NNgYAyn/1YwZto
 Me5P25gYnw/zDzgUMUe0+wmxFfG0joSHy/yF604PyOpx2XipOoQ4M4WNLRHA2glTXkhWuaAXFEF
 9l42Y5lXhL/Wfhd3K7aLUBIaxqrswxCcL5b2MKjGBLvE2zKSJXClhM/Q7hP28f/iXUc+Z7MH83R
 Lmbad5HUW26RyAVPu/SXhoe/hdPSjsTNpryA1XVdT/+gpPrXYqfmzZdh0AU
X-Google-Smtp-Source: AGHT+IGIEB5ciokg7Btgfiv6pF493QcyEZr2n6/rj0GHsdGfwKt0X7nNrI/m2J66U7BQPc+KnYMGgPzBRXZAQdovR+s=
X-Received: by 2002:a17:907:968c:b0:b3f:9b9c:d499 with SMTP id
 a640c23a62f3a-b703d53f5c2mr200426266b.51.1761728764030; Wed, 29 Oct 2025
 02:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250928163155.1472914-1-richard.henderson@linaro.org>
 <20250928163155.1472914-2-richard.henderson@linaro.org>
In-Reply-To: <20250928163155.1472914-2-richard.henderson@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 29 Oct 2025 11:05:37 +0200
X-Gm-Features: AWmQ_bl1YpFZSqQJK_pO0qkmKlNuPas6tkasTje4aJNgQW3aAYcoSJSIcYJRj34
Message-ID: <CAAjaMXYZPjcgKFYG3+b=3agTECD6EYaX03HOw4Ss-w7eZjaoZg@mail.gmail.com>
Subject: Re: [PATCH 1/5] tcg: Simplify extract2 usage in tcg_gen_shifti_i64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sun, Sep 28, 2025 at 7:33=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The else after the TCG_TARGET_HAS_extract2 test is exactly
> the same as what tcg_gen_extract2_i32 would emit itself.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  tcg/tcg-op.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index dfa5c38728..ab7b409be6 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1818,30 +1818,16 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 re=
t, TCGv_i64 arg1,
>              tcg_gen_movi_i32(TCGV_LOW(ret), 0);
>          }
>      } else if (right) {
> -        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
> -            tcg_gen_extract2_i32(TCGV_LOW(ret),
> -                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), c);
> -        } else {
> -            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
> -            tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(ret),
> -                                TCGV_HIGH(arg1), 32 - c, c);
> -        }
> +        tcg_gen_extract2_i32(TCGV_LOW(ret), TCGV_LOW(arg1),
> +                             TCGV_HIGH(arg1), c);
>          if (arith) {
>              tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
>          } else {
>              tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
>          }
>      } else {
> -        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
> -            tcg_gen_extract2_i32(TCGV_HIGH(ret),
> -                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), 32 - c=
);
> -        } else {
> -            TCGv_i32 t0 =3D tcg_temp_ebb_new_i32();
> -            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
> -            tcg_gen_deposit_i32(TCGV_HIGH(ret), t0,
> -                                TCGV_HIGH(arg1), c, 32 - c);
> -            tcg_temp_free_i32(t0);
> -        }
> +        tcg_gen_extract2_i32(TCGV_HIGH(ret), TCGV_LOW(arg1),
> +                             TCGV_HIGH(arg1), 32 - c);
>          tcg_gen_shli_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
>      }
>  }
> --
> 2.43.0
>
>

