Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22DBCD6E49
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 10:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSYA6-0008VH-Ry; Thu, 28 May 2026 06:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSYA3-0008Qr-6f
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:40:23 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSYA0-0000xE-Tw
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:40:22 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66043ecf6b3so227791d50.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 03:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779964818; cv=none;
 d=google.com; s=arc-20240605;
 b=NY9Cck2SAM0zh351wUrBkSRAOdzFmyX1LAEHdSziY9kneNuMR4qhJnpMyzzirhN8ck
 frSb9iXIo6GR18m8FSb6N2iTN2JpapfWOz/+HvO9sJfHMNwlZ8tmZvMQ0wsGUlm0Fr/Q
 jiNSnz6b65JxJ374MvQRG8rYlPshD3voQuOluFtDU3AiMc64avA1LBfxgBXAwyptdd5Q
 VBgTjW/3XqryMHAfL7UzjDQZlggTEQW2Hvf/h5T5EPkLI7suLaHCO3tLf3QtHiz9hyvb
 F/CThhhFC0zWExRd7Ni+351L3llAJf1Nr2eBfJPrX7k6tQQoSH4cPEtKbKe3rnADBqEx
 9qOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QhrKEQNZQJwZJj4PFhQODbUrn0jnDsRifxb+Tmoq+SU=;
 fh=FWtyXIX1K30Gh1JIPWWinn1E8IuOwxOeZI6Shz32Tr4=;
 b=h/e8aXsEUG4J0Yyi+qdocSJW7SvcbP5L+PBlS24SzVr+TllcBnR21jnYwR25F1WRmC
 IfU//F81Pt1SYC24M5p87qQGFcZY0Shx7h3OkEcAXck4L03+FrwX3IbeJBQH7l4sNjAF
 y3owArP/ANrvj0iCkn8r7dssftpAiwUOJCy0SB0h8cRuwIjuH/Vmph8SPTWcQMTXRNEo
 eB5qN6jrncq047V1QwY7RA53PZK7Dn3ZQWChcpRglsESZILTbB7JkTny4KRA3nlWeNVj
 95a7gVEQtrRUhWv52F+TE9MlpW/FBKx+zLhk6tTbeyNnosupldKUeLEk1B/UaIHwx238
 Up7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779964818; x=1780569618; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhrKEQNZQJwZJj4PFhQODbUrn0jnDsRifxb+Tmoq+SU=;
 b=Y2GcHbFuJcuFuj8L26ifLQWi92lUgqWSME4m/Ziz464aMLcnEBs50IQIS9TvaIVLhI
 kPaiKukezoeC4WVHIEA33PFyuAsoTJV6Z5FnDfk4Y8nNMnsssWc8piu7b2OnOBmqchRc
 U1Lri8bDxSIDlKs16oye8o9Xpr7IxnqyURhKzA+4of1JMzUKAT0lju6yWfK2T5bqjhCZ
 gynG6Po0sYPbaf5wWmvbnTgzRIyn9xDcjwMY/ssm8guq2k+irb1K41iDX+/LzhHCGNGa
 E6Dro6BmkFCpkHZ1cpiooIhUIUtmfgP0eykOwRyMAKxzc5b78vfEuodJY5DIJ8UHaYnh
 Xwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964818; x=1780569618;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QhrKEQNZQJwZJj4PFhQODbUrn0jnDsRifxb+Tmoq+SU=;
 b=SqasbNRvFIG2PwPLKJTdS6DO52khkbiBVKh9fuapyIjNA5J64wjVmYtOcWvCeaftCo
 1jFe3EFr42gdbaN8jLz7NShmB9d9C8iLxuGBf1T1RhDt+QC9YnLo0Hi4WdSBm6II+d1S
 5LMmLB7EK9Lt0KVvKL7Y/vZMRC03DTXlc6Qm8L4oNheQJbzNT9QyPoAaBhBUqUAYvV3b
 Z26IKF8OnrA5AwJ3H52OHfXQMtxUEGvQUj3YfY7PiDyaFM438F4NOE4BjUC6t/Ml7rHL
 YsFuW6FFEthAVeOJS9wdcTDtt6LRZTmd30oFxJPWoi8bEOaT9VQ0XtRECHXKzMz2HTyJ
 mcNA==
X-Gm-Message-State: AOJu0Yyf2Jlhmo7uMIbhaaqW12CVfrVJ44mzelEn5fOnbPHfxPC6t0hp
 9E4/DTi6lo3OQi1C5zG/R3FpCw7PswqjTFENBm06mw4VGzQElk6B/anH9iKLMq5q5TZmxnwgVL4
 qXhRfd69PnVDuTWF1s5tM91g3VXTeXRCzIOaC5SGNYw==
X-Gm-Gg: Acq92OHrnoLeGRp53g+TW7ecZq0d7b4XDOBUikB6jgtP+xLeIu54zeHxQ47/OjUEj+/
 SwCkrGkgW/2bH7CckksRanqsRegrinkOlLSyhjf9Rc9CO8Z74RQRDcRyNKnj6VKNxcynyArsO18
 vsA8Q5rLxKAYquFzUmeSNNqDz94am+pUUZfG92OX8lLJnCTD5b0FLQvwTbhvDaMLK6LDFaQp7Ze
 /+Gg9vHr+7B/Ltyl0ol8lRBuescBQ31xfdNT7/JNilPp83jKv4R/f9WxVqxra5sA5YNzOriI3Zg
 AS9Lqc8CrkChpa5DiBvtgFoZQygz5zyl23w871kyNkRXAE0bDqq7nmkiNxyomLpGJKby3ezoGAV
 Ckw==
X-Received: by 2002:a05:690e:12c7:b0:660:3a2b:73c with SMTP id
 956f58d0204a3-6603a2b0c9fmr2878519d50.25.1779964818523; Thu, 28 May 2026
 03:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
 <20260518-pr-pacbti-v1-2-8932a885b03d@foss.st.com>
In-Reply-To: <20260518-pr-pacbti-v1-2-8932a885b03d@foss.st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 11:40:07 +0100
X-Gm-Features: AVHnY4IS_4fEMPfoGyXrbvJy8U5Zh_40Ncd9TnhaHGM26G05DGm83BsAM_1QPQU
Message-ID: <CAFEAcA-n3CLVsdze_tQSLVDrs9+AcOKga70g_0Tc=QrWSsxhYg@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/arm/tcg: add PAC related instructions
To: =?UTF-8?Q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 18 May 2026 at 17:16, Torbj=C3=B6rn SVENSSON
<torbjorn.svensson@foss.st.com> wrote:
>
> This commit adds the pointer authentication instructions from the Arm
> v8.1-m PACBTI extension.
> While the instructions are properly recognized, they are all NOPs.
>
> Signed-off-by: Torbj=C3=B6rn SVENSSON <torbjorn.svensson@foss.st.com>

I think it's worth mentioning in the commit message that we previously
decoded these as SMMLA, and that changing what we do is OK because
for v7A and v8A these SMMLA etc encodings say that Rd =3D=3D 0b1111 is
UNPREDICTABLE.

> ---
>  target/arm/tcg/t32.decode  | 21 +++++++++++++---
>  target/arm/tcg/translate.c | 62 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
> index 49b8d0037e..a885eed101 100644
> --- a/target/arm/tcg/t32.decode
> +++ b/target/arm/tcg/t32.decode
> @@ -263,6 +263,7 @@ BFCI             1111 0011 011 0 .... 0 ... .... ..0.=
....     @bfi
>  @s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr s=
=3D0
>  @s0_rn0dm        .... .... .... rn:4 .... rd:4 .... rm:4      &s_rrrr ra=
=3D0 s=3D0
>  @rnadm           .... .... .... rn:4 ra:4 rd:4 .... rm:4      &rrrr
> +@rna0m           .... .... .... rn:4 ra:4 .... .... rm:4      &rrrr rd=
=3D0
>  @rn0dm           .... .... .... rn:4 .... rd:4 .... rm:4      &rrrr ra=
=3D0
>  @rndm            .... .... .... rn:4 .... rd:4 .... rm:4      &rrr
>  @rdm             .... .... .... .... .... rd:4 .... rm:4      &rr
> @@ -319,9 +320,18 @@ SMLALDX          1111 1011 1100 .... .... .... 1101 =
....      @rnadm
>  SMLSLD           1111 1011 1101 .... .... .... 1100 ....      @rnadm
>  SMLSLDX          1111 1011 1101 .... .... .... 1101 ....      @rnadm
>
> -SMMLA            1111 1011 0101 .... .... .... 0000 ....      @rnadm
> -SMMLAR           1111 1011 0101 .... .... .... 0001 ....      @rnadm
> -SMMLS            1111 1011 0110 .... .... .... 0000 ....      @rnadm
> +{
> +  AUTG           1111 1011 0101 .... .... 1111 0000 ....      @rna0m
> +  SMMLA          1111 1011 0101 .... .... .... 0000 ....      @rnadm
> +}
> +{
> +  BXAUT          1111 1011 0101 .... .... 1111 0001 ....      @rna0m
> +  SMMLAR         1111 1011 0101 .... .... .... 0001 ....      @rnadm
> +}
> +{
> +  PACG           1111 1011 0110 .... 1111 .... 0000 ....      @rndm
> +  SMMLS          1111 1011 0110 .... .... .... 0000 ....      @rnadm
> +}
>  SMMLSR           1111 1011 0110 .... .... .... 0001 ....      @rnadm
>
>  SDIV             1111 1011 1001 .... 1111 .... 1111 ....      @rndm
> @@ -375,6 +385,11 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 =
....      @rdm
>          # SEVL   1111 0011 1010 1111 1000 0000 0000 0101
>
>          ESB      1111 0011 1010 1111 1000 0000 0001 0000
> +
> +        # v8.1-m PACBTI extention
> +        AUT      1111 0011 1010 1111 1000 0000 0010 1101
> +        PAC      1111 0011 1010 1111 1000 0000 0001 1101
> +        PACBTI   1111 0011 1010 1111 1000 0000 0000 1101
>        ]
>
>        # The canonical nop ends in 0000 0000, but the whole rest
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index c744b16345..ae1351ef03 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -5012,6 +5012,68 @@ static bool trans_SMMLSR(DisasContext *s, arg_rrrr=
 *a)
>      return op_smmla(s, a, true, true);
>  }
>
> +static bool trans_PAC(DisasContext *s, arg_empty *a)
> +{
> +    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
> +        return false;
> +    }
> +
> +    /* Handle as if PACBTI is disabled. */
> +    return true;
> +}

I think the patchset would be clearer if we implemented
the insns (in whatever combinations make sense) in the same
patches as we add their decode, rather than adding decode
only in one patch and then implementation later.

thanks
-- PMM

