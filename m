Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AFEE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJZ2-0007v0-Vx; Thu, 05 Dec 2024 16:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJJYy-0007uU-N8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:39:08 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJJYx-0000Bc-7u
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:39:08 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa531a70416so220328866b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733434746; x=1734039546; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buspJ033yI4KQQjeGpDIGExXi5v1uGBltcHsCX1LZuM=;
 b=gHpqvSVdE5d4w4SLWU6rGRURq2gUZGwLbuPEH8HpfT1y0hTx4zneUAqSq/CsXomk5s
 tUKtMOLoZzEF2fGsHcpLKa/V53xG0+nrm0846xRhGLsqMDXhDnV4pkyHMvLoxw78BG0P
 v0Jk94lPWuXzUmMFU/avLwJu0QvesndyJWJ2IFlV7clAs70CzrEvwOnG1XG7VsfWzBzC
 LTMy3L0JTfIV23BoaqEZcHAbJaslbqZOvVvbPBARy1muj9nUSzxHTC8y6qOOFCnZcS77
 1hXpw52vnXaKBjQOrsFUjhw6HYmzBLefd4F5kKl3OWn/w4uDx4NHgIatg8XfdxJFPriz
 Nkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733434746; x=1734039546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=buspJ033yI4KQQjeGpDIGExXi5v1uGBltcHsCX1LZuM=;
 b=YGzPauKWYEJyAlowiMHOfCupom/ERSNI88M6BTFT1n/yL5Lk5LsGVuA0dUFU1xigya
 YwHLxmRpeUwllYXNci1LuA2+yEtaG0PjMi2lpKk2KBk/bCxIyu0+OVvRmnW1VawekyGU
 hkgny6QXs/kqztgkt+aHJJeayGL8FvnXdZFDdL0UlNx3glApudJ2JTzZ/aDAtyk8YIdu
 6SDcLUQU/1XarPnWmfyRLNKXzs16MAo3WZDi7o3C2cGbPcK7go6P2gnOw9hJpf2AsxKF
 OxgJp9AgoPkbFqsJET7TgGdLz0fzYbp8b1MaNJRp10TkkEXcMmq+/tb5vqDnF0gquCXD
 790w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmR30PCWsaHdE5oRSxOnrFSRzPzkpCOn0XOoVtblYSXatP/GIWO7zL/rqUYO8eJw/FSZwJLdQXgziM@nongnu.org
X-Gm-Message-State: AOJu0YxId9PJcS4ZXUx6S61J3Pts1oNqpl4LD7JVOR/TRYcINhhpbmLD
 7GWWMdIeFTl42CmS0pNmUf5YaACA+q24/RVCENYcjUbMRt+R9i4Xage60B5zABIXlpCbe9ZeAGa
 vh0wLLRjquy6PDrUI02pWlv9bOS63/2NVGD2jGQ==
X-Gm-Gg: ASbGncuG7V5fYIrhKC2xly+ZQIaM6QRKUPsaeLFhtdYRIwjI5tdETkvIJ3zs3OiwZ9I
 eU5NoT9fOzkyK6U5pHP+rK0sKjLeb/nmt
X-Google-Smtp-Source: AGHT+IH4aFjTUbH14T+ax2YsWvF/3BaKAqNkfCjp160dxl25sfEhv1IYNhAlq3vfbiu0OJdVNOcR/XBnbTXtxLp4gY4=
X-Received: by 2002:a05:6402:458a:b0:5d0:fb1a:afe2 with SMTP id
 4fb4d7f45d1cf-5d3be680097mr1556576a12.10.1733434745776; Thu, 05 Dec 2024
 13:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-25-richard.henderson@linaro.org>
 <d02f5bc5-87b6-465e-871f-521a49a27b22@linaro.org>
In-Reply-To: <d02f5bc5-87b6-465e-871f-521a49a27b22@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 21:38:54 +0000
Message-ID: <CAFEAcA_dxY-mtq8Ys2ZWHQ9ugMnamhno3cUMcGUVpHMK2gAzEw@mail.gmail.com>
Subject: Re: [PATCH 24/67] target/arm: Pass fpstatus to vfp_sqrt*
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 5 Dec 2024 at 21:21, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 1/12/24 16:05, Richard Henderson wrote:
> > Pass fpstatus not env, like most other fp helpers.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   target/arm/helper.h            |  6 +++---
> >   target/arm/tcg/translate-a64.c | 15 +++++++--------
> >   target/arm/tcg/translate-vfp.c |  6 +++---
> >   target/arm/vfp_helper.c        | 12 ++++++------
> >   4 files changed, 19 insertions(+), 20 deletions(-)
>
>
> > @@ -10403,6 +10401,7 @@ static void disas_simd_two_reg_misc(DisasContex=
t *s, uint32_t insn)
> >               handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, r=
n, rd);
> >               return;
> >           case 0x7f: /* FSQRT */
> > +            need_fpstatus =3D true;
>
> Should this change be in a different patch?

No, this is correct. It tells the common code in this function
that it needs to set up tcg_fpstatus, because in the next change
in a later switch() in this function:

                 case 0x7f: /* FSQRT */
-                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
+                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_fpstatus);
                     break;

we will now want to use it.

-- PMM

