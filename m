Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF14EA71B2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 00:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEcWv-0007YO-Gi; Sun, 19 Apr 2026 20:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wEcWo-0007Tp-VW
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 20:30:19 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wEcWn-0006Wv-FY
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 20:30:18 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-66b2d49ffb0so3241302a12.3
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 17:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776645014; cv=none;
 d=google.com; s=arc-20240605;
 b=IaU8a6ccDJGAtxaGtqzdlXh/6FR4spYIbR2XvpzduqqPa6Pu9lCG/5Hyzh4qgv1Yfc
 VO0EbS8YfxtA+ONxividbRO6P72Ev+aFgcXkXI+s1MpTr17K8FVqKOpvjUmZva8GYtsR
 cLJj480GdK1FrPqPDuOskgwVepdghQiL0pTvUYdT4boExTclc3oiuIC/e9RdRCjc0r4y
 JEatD4dv3QNlW3I7diEAWmith6Ujo0BdDDe7PgZFNDEItu+i/02wAST2MBS9R+V+nION
 JCg7nFfRWsCPLxcQitKdmPp+FbmD6l5JIHS90cSVOSR3Z1pYl6tnPfLTZEBUV2alesUj
 TjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HNI60lry+e395RJ3B1bc7vM81sAG+feoRYphSxNJjLc=;
 fh=wX0JiGB8tmI92WvDwlBr7AdoTDsWvyjYx1SZFvMyNUw=;
 b=K97za8xTufm4GLI/Spk+WcWo9gSXqn7peAC/sgz2sSCYgxwy2yloazmOQL1ItGdgRp
 v2Cf8JQLV34Or1ML44olWVQWZ11mUAk0u0XSjsjDFBrbBK+h+t0KTurzdLYjhsI2jig+
 XKsE/7fDOO2fa6wmhoB8I4xJCrbDX5EXnxHBJdgy+oTz9WFXJqev4EIcOoWJeEg2QVhS
 +GAiAHIS2oOB1gSNB2cDBhORyPsWQ+e9V4IX5y48c/TePQVK3Jg+ulIyRW05vnJdF1fr
 ug2qOkY5fZccBq3+IhnSkpC47GPhkc8z4hqcilA5ova99fdn22klXq29K1p+cdGqAJuh
 qWMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776645014; x=1777249814; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNI60lry+e395RJ3B1bc7vM81sAG+feoRYphSxNJjLc=;
 b=bjgk7mN9TxrQLs1xzejazhTtcgXnp1UdB8OsqLxqdZsj9zVSf9CDq8Gme3pnc9ovmJ
 W/FbzJhty60xZWQMC+VaK7xVmotwZHHV/gVg44w4flBszBIkGl7Kn0yyO7N/ttjvEaJG
 hPclnmHlQBvlJ8xX4LiwbfncL4QGTYHd1+xV3qZtt04kIhaaCC5fSylqztxBqi0cWsMr
 o0FtdblshQsQkysCm7c2mV/KFfpbukGRcf8XSQ/ROa9Kuyy80tXJnp8pA9pXb0YRKFiG
 pYJxf7HgEZuUFhs0nG8xebC2+osyl1qcIUpJkvSeYeAU5iRwrNLs9NJL5gbx20K4GUYs
 9tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776645014; x=1777249814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HNI60lry+e395RJ3B1bc7vM81sAG+feoRYphSxNJjLc=;
 b=shfaCbPXL2xOVdxR9dL5nDYmu9lQC1DAK6yIlwHHH1k3c8VAPneOj/FOcvjbPDlWLb
 nTB4M742dOw/FgNLmY/Xrzej0tnAnPtqV0Aoi4vO25j88mcRxmm4bjDwTTc9uYBkbCAf
 kzJ6hDjnkcqw2mYC7IBI5+UjS1hd1kHjM2YSjIGX9ZN2qa0UqI8nKBPPN6z+x9L/c3ms
 WD4zTgXo56RIk+3BFliVB3588p5HkPWR5Y+XEA17wwtEhXQxXUwJ4pO8hGzv/9hpymk+
 icJfo255zTP51f5bI6w8b12oGNywIudKOELk9BIDlDzHsBRWM2+hcfmxCN8HB6ZCqLJx
 0oqA==
X-Gm-Message-State: AOJu0Ywex3Op3b2+GOnwFRLCgHobfBxbEeol9OPr0k760WlxFeSTKuFd
 hjFKLLq/i8wgeDuYT2kNoOriSTibPTlvnpsoTIXPxpZ9m+vy9tiQbActQXr1BPD3euZSrV9CQZd
 MhoGotOxGIU0X8lXv/F3HrfXEcLfl+WY=
X-Gm-Gg: AeBDiesJ3+ZBCZXKx2n6R+aolX8xANg+2szCKISEKLry3C906D/Wn9UNJZ/PCXNyBpk
 NlddQHGEh4HXchnFXFFRSKAsOdbKerQxvbrQoOe9yo4TxVUkWoXNvlJ3XRXwyC6TZD5Ck9fb4g0
 SYujljmP2q/LlMIkhsC+O8k1w7xYnf/kD/fP6Bb+mVkrhFBRbV3IhJkPBp4B/bf+48NuFgr7Qh6
 aU+rlz+kTIPTIhIMJ2gzk8vaMIrzYaIpmOdB9UQnFD2+B/kQZgFzPbgaIekBaPS7CH1il2hI0XC
 xr6VlUmndfvztRw61YfY8bxKRNL3WTIWGOqrzGK+qg8xuUToclkbDCG8quk=
X-Received: by 2002:a17:906:4786:b0:b9d:2fce:308c with SMTP id
 a640c23a62f3a-ba41a0474d6mr528377166b.30.1776645014018; Sun, 19 Apr 2026
 17:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260417110550.70068-1-philmd@linaro.org>
 <20260417110550.70068-5-philmd@linaro.org>
In-Reply-To: <20260417110550.70068-5-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2026 10:29:47 +1000
X-Gm-Features: AQROBzCVoY_SUtfnDjFrz8xIp8AUXAlclj-M1rmKY0DRnSRKiwFLoGLJC2p7V8s
Message-ID: <CAKmqyKOunTTnTDjv0z4Wo1ooQavwausK8RX3t=1WnoMWLco3KQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] MAINTAINERS: Cover hexloader tests under the Generic
 Loader section
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Fri, Apr 17, 2026 at 9:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Drop the orphan 'Intel Hexadecimal Object File Loader' section
> but keep the tests covered under the Generic Loader section, since
> both loader.c and generic-loader.c calls load_targphys_hex_as().
>
> Cc: Alistair Francis <alistair@alistair23.me>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eccc0d64331..d5e766ca6c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2701,6 +2701,8 @@ F: hw/core/generic-loader.c
>  F: hw/core/uboot_image.h
>  F: include/hw/core/generic-loader.h
>  F: docs/system/generic-loader.rst
> +F: tests/qtest/hexloader-test.c
> +F: tests/data/hex-loader/test.hex
>
>  Guest Loader
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> @@ -2709,11 +2711,6 @@ F: hw/core/guest-loader.c
>  F: docs/system/guest-loader.rst
>  F: tests/functional/aarch64/test_xen.py
>
> -Intel Hexadecimal Object File Loader
> -S: Orphan
> -F: tests/qtest/hexloader-test.c
> -F: tests/data/hex-loader/test.hex
> -
>  CHRP NVRAM
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>  S: Maintained
> --
> 2.53.0
>
>

