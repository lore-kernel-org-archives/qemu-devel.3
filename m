Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAACEFCE5A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 03:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxzjb-00073U-18; Wed, 04 Mar 2026 22:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxzjZ-00072x-9p
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:50:45 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxzjX-0005l7-P1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:50:45 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-660b497acd1so1994535a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 19:50:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772682642; cv=none;
 d=google.com; s=arc-20240605;
 b=lEBqxsH5LFuXINcce4NMPr8MYfrrOv/UOfn0dWgXpDGuvNXCz3Eztdn0ggyHVtBvQ3
 HdoMZ3xkK4UBKYI3xOoe4GmPNHLy4rNx1l6Uhay8k2Go+yQ6kOFl+sRvLwkjPpvg5NGK
 LOMB478J7Dg12wAz3r82EZpxAiPzTjEGnOgqImW8bt7p7B0iNvkR9chQ67X6LS8Wm4nT
 o/R8ZTlcAg9+y5/10QFy7fq3dOnEonIebY6DkjitgH3XOudFTtIyXLrvKxJULztVLaNz
 IJwcEx9Oz4D16LMBp9e1dzhxsHQIkZT6YSVxDurfelUwjw8PKJ0w0DAYURqYa9OKJzsU
 emow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ekZaWANbPK7wiouMk/jrX4/9PXt72ytmEogpDA8lQwg=;
 fh=2PxklpQGkIG/DTOXfi2tMcVDxT3rSvTqUv/+HE+Ue2w=;
 b=hVkC2zJf+5KsyS9yyjGJZmD0zmu0JYYGtSBrIaRTg0/uby4pyi/IKOx8RuW5udX+QS
 zmBHcVhyMBMVRO1PtDdplyJ61EL5QuYwbOnuA9n9Iqdu6yhhCawBKYjUIFSD9UDBVkju
 8XqhjKLsCqBpgbU/GH8J9o2ytlLf+lwV6FuU8tQh0re6Rdkj60bqiILuy3s737RnA5Fj
 QIlQeDcbZdxUexB+GF+CtkaDpU5gkQ2iPQgfni78tFLVfwsw8p6jvZarDidaY0zKuWki
 ewD1x6o8TCX+/QQ4xBR1eZGnBY7kMyL64NX/hlHYXplwNhoqO/6r5bVIRlNCD46N7+fv
 AeZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772682642; x=1773287442; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekZaWANbPK7wiouMk/jrX4/9PXt72ytmEogpDA8lQwg=;
 b=S1eVjOqU4vkOzzJUjZsvLJ5Nun08meOGhf3yrtE/bo9T01TNs8OCR7fdG9yHvSihmr
 p0yTRuIn06vMuvAo8gjdd1zoFO6l++paAufJSF94lNNUcvdpLyNkRYxbpdRDd/P/Y4R5
 mh8r+Odu3wR9RiqQKW3jkTP47to/g1NR4id/NxHKGWABkrx71JJqLfyPGI+udLpxvav2
 6LalYYXiUq4cGDYTaN7IZZiI/rB7KwRfk35I4ZtHDZa+X9Ulf+SOVJG7s3fUdXCgYu3/
 XYHuJRAKLKY/WNci+IMbjGVVE77iSAttKqwiQGw61XQZuim/sWONu5DZ/NHIVGSzEnXP
 lqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772682642; x=1773287442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ekZaWANbPK7wiouMk/jrX4/9PXt72ytmEogpDA8lQwg=;
 b=g9m2Pzlkk2SHyYB7hJvoZ7aeHjl11NwOYHnp8rpOWTeSJj+M4N24415rbBeKIY+nYK
 8caKWpucDoWPMfRIGmL4u9ujybdhlAYVCAVVCVpOHsUTO7/vHvn6fsiJ66L2p6vFSsRd
 UQByopfQ767/naepMU1RUrZvisL8CgmR7iBJgxWw8UzqySuycQa+c7rNiH9GtKyh2IsK
 eQ0ju2ZsQtMAMMzVION4nEPCDZV8S6u7S4PsPhPVAvGit1Xvrg8t3VBuWiWYGprfyLI/
 GXj2hEWoWAhbeLKk/bNAmZi6jiKHBbI1FWbhrHjVHXNybLMr02ycjMIj964a1nIuvkMq
 9Jtw==
X-Gm-Message-State: AOJu0YyDSIUbCxnL6O2WNM3AbnkSmMfGIu5wHYt7vHNLxBCJFADY/rB1
 i8rVW/pLA10RxQn0vt1Rto7ZeZryLeyCDbxmB8hWcUvEFUmCnpBMM6qIjAEsBXXh6X+jKeu9WCb
 fkV3fRjmS5V+LdvOh1MT55qsQrriHqUU=
X-Gm-Gg: ATEYQzyCeqcWEyVEFNXOY4+X/josAnDcjT3qRjcgyQxhaTso24aAQA479hR9f2Nw34q
 KY4lt75Wx6liE6UhJmvtqwOL/CEFaVwD2kR6/596Ydeb/GoMtRwdOxxG5cXzkXnyQTy8arYPNMf
 lQgB09k7mW389eFaqAuqYs72y8NfzjUs2qAbt7W6vtffLvIbsO2xX+9o0ulH4XWTCdaaVMj5KLp
 GxplFvGI4mKJap6OttEBNoB30nep1Oco5A3o1Krg/sU8bdmGdUos1d9gYvn2jJpDtR2xB5THb9t
 sWQKKC14Zq7cRMhWd9ajqAz5K2e1+IScQB4BJg==
X-Received: by 2002:a05:6402:51d3:b0:658:b4b3:4258 with SMTP id
 4fb4d7f45d1cf-660efebffa0mr2558335a12.17.1772682642033; Wed, 04 Mar 2026
 19:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20260226071817.1417875-1-max.chou@sifive.com>
In-Reply-To: <20260226071817.1417875-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2026 13:50:15 +1000
X-Gm-Features: AaiRm52j8NjSqT7gs0jyRkyiwk9ponczgfAqjoNdnQJZXPmbkEQqUGQmbn_d7Xc
Message-ID: <CAKmqyKOiK8+-VvqXwed0FPZ23_iWSn4=-f-A_uUjK9waOoXB-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fpu: Fix OCP FP8 E4M3 conversion issues
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Thu, Feb 26, 2026 at 5:19=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> This series fix following issues related to OCP FP8 E4M3 conversion.
>
> - Numeric overflow to E4M3 produces incorrect exponent values due to a
>   missing local variable update after calling uncanon_e4m3_overflow.
> - Converting infinity to E4M3 incorrectly raises OF|NX exception flags.
>
> Changes in version 2:
> - The =E2=80=9Cfpu: Simplify OCP FP8 E4M3 NaN classification in parts_can=
onicalize=E2=80=9D
>   patch has been removed. This change retains the flexibility to classify=
 NaNs.
>
> rnax
>
> Max Chou (2):
>   fpu: Fix repacking issues in the uncanonical step for E4M3 overflow
>   fpu: Fix unexpected exception flags when converting infinity to OCP
>     E4M3

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  fpu/softfloat-parts.c.inc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --
> 2.52.0
>
>

