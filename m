Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F686109E53D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5aJX-0002Do-Td; Wed, 25 Mar 2026 22:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aJU-0002Cz-KY
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:19:12 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5aJT-0000gS-4p
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:19:12 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9841aecf72so60668066b.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774491550; cv=none;
 d=google.com; s=arc-20240605;
 b=YVstCmRY4RCeI95iOhADPTsv6DiLru5ZZFsUT5+Caz8MNcCK7mDvm+8h76swDlKYHr
 W/+ZtHxwumw57Y3fULTp4XLL2JkuwAX8b4Xzl06vzxWmL/N3zGSxqnKkP4BKTATLvcDg
 wglXuSt7nJ+h7XB66xTwEWYqgzf9d/mPLXSBwp2BcYu++KWIiaHxwKK+M8QPqqHNhgIM
 sJCmpggpiY0Duv0ESUNsnatgjnW+Az7aMIlm2BPOEbmeK+xj9EYjHLeX6MLR1Xc765/Y
 fk/yDYfciEanY9/TsE3SW2aUVOpi+oc0XiqA1IiF8iHUe/DfusKiEvlDxzesk582zN6u
 tocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M5/JC3z7u73nOu98FxZEOkQH5S3UpJtV3J12vEpbDnU=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=DUIqIuHjGPFgFVzCetojBrd/STjEUoCIpsAFTB8Zt7hTwMgnDys26tr1OYhNYUMD4B
 3qrjgwgWpYNHauicSIXsS4KXGMdAvPYpAIlCvbCxeZlN+RMcnYcxJpclNTa7flwjOyff
 t+BYs8o66ztfYaDdi2CTwq2Jox4iNUA3X//LGGEymyNM7w3EOnyc6WtD84TOJnGkfeWR
 GZqzTIQjAlathiqZ9izfkAeGa1RHuiSpg4Q9w38scZnnSVqsUSXjp+c4/KH9v1wQkksu
 1IvVBfb20rziQfk6S1hG1kyorUS1LWt6XJ2LGCrPGqAxk90cBCthfW7Pf4hNpTWkoevm
 Mqng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774491550; x=1775096350; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5/JC3z7u73nOu98FxZEOkQH5S3UpJtV3J12vEpbDnU=;
 b=UroVjjxIVpOoQHDhTLucUdHTpAqqVeD4lEVGa/MnIzkJ7B0WeU0lAIHy3SXEjsSn+z
 3OAjcL7t/62Ic8F8+EddpXcDlOKw1m9kCNLlTIPtYc/iQN2TTAMhkbcSpZP17LAT/UIn
 +BnHFS330p7lAhMpkiphiNDrUgVlMCGWKBKGwh9vbHm49STD7skGc0ErHnnAb6WDf3kx
 uMTDl8Oi2h8n7TKdbjLvdtIfUGTq8hRRHPoI6WBS4gNHCxbwQw/LTKHX34XfUNfa4FLr
 RcbRgPNdClS9AvlceiUW8BVOBjZ0i7Lst3p2CkgRhZrnR0oR177KeO1QHByt96Q3CdsP
 7EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774491550; x=1775096350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M5/JC3z7u73nOu98FxZEOkQH5S3UpJtV3J12vEpbDnU=;
 b=OdFbqEzPykgwtw2R3viYV5Oxd2TUvJMnL3I2OKOVQaAV1pwTRsWrPELl3APjjHAuc7
 eBErFiqqmnQ97QpStMT36VKSKiUeZKPsCfKsHebvgKtNllyEzU5cmxg7A+DIl7YbNU5l
 7UC5jugrF6IMHFlko6BCf5wJW3YOh94afuC2DC00F2zxddLNvfhLrKcFtU+Yukn5lLN8
 YoBjWkeUjCj4zgetkUcSsvNhnTDjC42VpC9QAtSrzeo0YX8r/shVhQEXhCqa9B9DsNTy
 1NO7Lb+OMmRlSckRTQLVhMXmvoLb43eDuXrx8yqNlNsU1OXXebnUpyxeSq7P8OQRBxHC
 qtFA==
X-Gm-Message-State: AOJu0YybhjcRpgzrGtUxclBsuReXLppDo9RmngoZ7Apu/sdvxBzWimJd
 Wo/YWqd+A1uenuLBn/x+DKINKhV8+9E9dPA/cf0Ri3oI5WmklhH1NR3a1Eu1fXRD4kTdQqsrPzJ
 DXGxCQa1Wfa9RW7JzrLiTut7Y02E3bwU=
X-Gm-Gg: ATEYQzy9R8laOR2t5nFa4NCMZs1wppHuKzDiegO8llu0pqboq1w5/Y2FEgNL45E9wzO
 G2KhldpDAGLP+5ycVpncKWMJ1MlRk6RYIGqAb2OHzYLKpTCvn+0XFTGmL+9yyR0pEL7ST1KLbkV
 149ND/U4Jvhn8K1SZld3pbd86bTfRleSLwjpoSLVEU6PPeMNT20Ef+u9TMsSLyi+K4xY5azbOCC
 IKN97TAdwLkXBEUo5Ylf+mBsFfeSi2YnOYJtqTcEKXNFGG0TJR6BkJZeYMHh1t+6cBeZY+Wd2OX
 lhk5xEg2Q5jCfIPjOqgAsQJ7Y9BTWfmHExdpyw==
X-Received: by 2002:a17:907:c714:b0:b9b:207c:f7df with SMTP id
 a640c23a62f3a-b9b207dbe12mr107491966b.29.1774491549352; Wed, 25 Mar 2026
 19:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-13-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-13-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:18:43 +1000
X-Gm-Features: AQROBzAR1RZiPzyGuhBAlbNwejlotDSJryUWevxk37bPonDkfqu5j8cDgin14X0
Message-ID: <CAKmqyKPMLjWuUeTh-uB3mPvovgMsBtN6UMGuUVV3HPf_Jg8LZw@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 12/16] target/riscv: Replace MO_TE by mo_endian
 (Zilsd extension)
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
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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
> Replace compile-time MO_TE evaluation by runtime mo_endian()
> one, which expand target endianness from DisasContext.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_zilsd.c.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/ins=
n_trans/trans_zilsd.c.inc
> index 445406cf015..f50c52f22c9 100644
> --- a/target/riscv/insn_trans/trans_zilsd.c.inc
> +++ b/target/riscv/insn_trans/trans_zilsd.c.inc
> @@ -30,7 +30,7 @@ static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
>      TCGv addr =3D get_address(ctx, a->rs1, a->imm);
>      TCGv_i64 tmp =3D tcg_temp_new_i64();
>
> -    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TE | MO_SQ);
> +    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx))=
;
>
>      if (a->rd =3D=3D 0) {
>          return true;
> @@ -85,7 +85,7 @@ static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
>      } else {
>          tcg_gen_concat_tl_i64(tmp, data_low, data_high);
>      }
> -    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TE | MO_SQ);
> +    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx))=
;
>
>      return true;
>  }
> --
> 2.53.0
>
>

