Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C63AFF60DC
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7U8V-0004p9-Nv; Tue, 31 Mar 2026 04:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7U8S-0004nE-9Z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:07:40 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7U8Q-0002Ae-RT
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:07:40 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6500040ef85so6166648d50.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 01:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774944457; cv=none;
 d=google.com; s=arc-20240605;
 b=BZXDZv4GDNcuFM21jO4C6Hixg6V9IqkAMWyDA1Vttwc9tWHP1w1UJtIcdNn1XwR+BF
 1mq4DytobFihVt3LJWS/GyIA3Bo/GHGyD8z6zGVIcB8QTOrNC386htWDA5H2jBLeOYxg
 scaPno69fQ3Q9QP52IaGc05Pv3D3j/F8FsLTOTuVdHnOBJ11OWTTr/r9PputQz6jMJi3
 eoxUgBJI5v39G1vVP8VGmypxg4wtEM+nAc8sWeenUbgWsGSxJq2XWmd+fFWqKnpP0GkX
 vjof0m+JlkuEcUm++M5F31NFex98Nz6dYpIvgW3qqEDtQr+hH+viH7yu4xhLQ6YmxP8H
 RkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/ehRP7EKw8h7MDm4UCqW+xjOw9C8D8FKNBarGP8i1/E=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=WhOhvqEXzQihS3eIgeoPcflZHkzkfsT/nmKFHR4nBgyStR3aROdzbh4lvZcQuzMOLd
 v2zkvP8kigDWR0MhnjFusPBZliIxO9M0Y5Y/Iq/LCZIq7/9MRYG9+iCC+Ysd4V/DWKMl
 UbsDWqVqfnIq4Rmf9zC2snn0YlcfJfEMultVXKd1kFU3MFtSrCsOlnKTU0/ktMaASacX
 jbnxJp9rjT2DQB1iv89J0zZL6OqBMYUgxpi9dXp26LB+2tBCVtk6dnGpuTYwHx44rG8R
 PHzD0koSowp4Q+CIvhARxcISnsqIiVHKizX8ngkOH+DFwh2k/gapfa2EjV/M7jhROrze
 xIDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774944457; x=1775549257; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ehRP7EKw8h7MDm4UCqW+xjOw9C8D8FKNBarGP8i1/E=;
 b=GJ3AfpQpsvYdM/U+X4UPvTwt1d01NW4OtuWVHmvRaW2SEkUrQsYT/oJRNu9ryBNbuP
 Etb0RGVxW2apNRyMrsPqS94GLzJovTOPocTsAFZotHYNZATNrQ/+t3m1IK60Pu5C3KIJ
 q5rAftyx90ifkie87/QJ4MzAO1EIbcPT6WE1DY37XLlG+uHVDZZkjkxza/b0hhwfsy6N
 WcDmjnhrOlyGxib3OV9sVDFyNsz7rvehpJ91Q9GW+HvmWwreDxEnR/6237Uq1Cv4QoE0
 g+XYxjQZIGE+5GlpEYWxO7haOOrN9ucTkvCMBbo/xH5+OUnFBq48wfZuvfSCYw2LJ4zD
 kolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774944457; x=1775549257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ehRP7EKw8h7MDm4UCqW+xjOw9C8D8FKNBarGP8i1/E=;
 b=B7im/0ff9qV35N5xQgswDG0b2znmvvxDSG1SUIqc6OPZBhuziUUH3sU641JPr4+zzc
 iuqa4Yn/qU9T3cJIYvF5Gy3Fviw9lm388Gmxz94R6Yv7Cd05thBAXLc8BdOXu3mCv3uc
 G+gVcE0CJixHUsY/Dzl+hEWJr/ozXRhhu6+UpA7b0fpwPepvN8Z0bOUZxzfEeXM64RdP
 y32AJB6+3ni7U8TYIRvWfiCfB4iQkS7kDVI6LsUIU2dZK00br+nMWkTEIIvWlDd5hIpX
 bJ30/kci8551GBN3CQmmljHIMshE7niIfglRKiGf/QNI0CwVv7m8u2wN53eLWnR3+ivr
 elIA==
X-Gm-Message-State: AOJu0Yz8jEXWcoLpxGFMj+l4YfEBYRwUT/IYPthCYR1pYU+kchrw/p1l
 bUaCM/RWYIZ015637P97VzK3XxEEw+hNJ/4/fpgUjd/oXBuUYh2wpglsBslgaTe5LT/yrvkEkDj
 nXg3oDhF2CbKdKRI2jtUXDUQHcx1Vt2UI0lpqicjC8w==
X-Gm-Gg: ATEYQzxgGyzHkgzFH5ojJk1R1tEn4KgSa5ASsET3Qtn33iCrD/YOVpfPUf1nYF11u9/
 c2Q6WSAlQ9CgMqhS9BLmLMwJspPmU7RT9nRcNXfydyRfAyo/VFuhWlL+fLbbMxhLScivB0coQXj
 6zD+YvsCxVAeWV44iEMFBuBvjCt5eZTeUoxEW5Ev/T9MSLgR9cJHITHLwA86cGvAZMdGKk5LA8O
 fQbse09O2CFBMjvq65w+E1VGnIFVO9R/i8qlaiV5nsVVBnhfxmvddrNjgMIR1Rr2N7K74NLC3Hr
 JUKingSw1cmm2hYguSxgaQQoCGCq0LJbZw8wp1+TPKceQ74mmHK/JZ1/zqNdnD9/48c=
X-Received: by 2002:a53:b10a:0:b0:649:ef87:5bc8 with SMTP id
 956f58d0204a3-64ff7198bddmr13943091d50.7.1774944457371; Tue, 31 Mar 2026
 01:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260331070401.1125840-1-alex.bennee@linaro.org>
In-Reply-To: <20260331070401.1125840-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 09:07:25 +0100
X-Gm-Features: AQROBzC5PU0-qCSPfY8C-0lI78nNcS1FvIPd2Pk82QRUncu_4FCrG9Q-MTcboi4
Message-ID: <CAFEAcA_jwG09k0nT62dyiXP6bqeQJbiF5hqzGkM7ASK50aW7Ng@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: fix OSUOSL typo
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 31 Mar 2026 at 08:04, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> It stands for Oregon State University Open Source Lab.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd8ba144506..84ea3f2469f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4526,7 +4526,7 @@ R: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  S: Maintained
>  F: tests/tcg/Makefile.target
>
> -GitLab custom runners (HW sponsored by Linaro, OSOUL and IBM)
> +GitLab custom runners (HW sponsored by Linaro, OSUOSL and IBM)
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  S: Maintained

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

