Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B8DCCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GqK-0000dY-7v; Fri, 10 Oct 2025 13:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7GqD-0000ab-UU
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:23:42 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Gq8-0000iR-Ji
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:23:40 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71d60157747so23014787b3.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760117014; x=1760721814; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEf1LDgTIyRYjCZDBNr9veOvPr5gg2Q2jE95Itsg0hI=;
 b=IyQ8NWNWP5AByMiUwcHalmuEzJwbpGrLjEqjH4Z4y5nnzTorq1R8C1j0jahRntXIda
 H9+xt2zs+6OyzdoYtt4ZCwoH0/0DMARihdgKSSKDHJLe/Fgo0O05qi3D5nwfJQABHilP
 ZzqwOyYx/gborVds4II0uGaX5eDFc4dtldGlGoz5YdLmKFZIBZTDmqItTHVsjt+QYcSE
 DogLsXGgmT3GpcAW5K9QJaffYFP2h29606IdTe87/+99hGlIHNS1tBtwe6wdHGXJY9/n
 25cX2uWD3AYv47TftCNPcAc5GOkfRIZ1AgT56AFTSHS1WHd1PoZANf6YtNchGeMadAOw
 Vjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760117014; x=1760721814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEf1LDgTIyRYjCZDBNr9veOvPr5gg2Q2jE95Itsg0hI=;
 b=JCH4/XaulqJlZkzmTZyeXTeTUDZdou8op/0Eontj7Uvl0Ja6oQWhBENMy1UNVwN3O+
 HoqMjzoF0Qv6nwBafTtwxWqc5y8P9ged9BJwnOKPpA65Jvg4um8gqh/XsgculiSLZkCU
 OeizSEVXOznjUr/lhUOPsfdsG4GMe1jxdjyl80/G5NknmylmtNvQd9XP/73djz7CMAdi
 XAbCqWM6tKOcHnd7JUy5o7KynR/7i0fagxyIkOKmJDgx7Du+R1uJWHSmm2qBWtcNzygI
 UTXKPrFTsxR0iqtq3ElgCFK13xWMeJmw67eJuZh2ci/W7FG9GxVc/lIsuzeiD1SeirAr
 ScCA==
X-Gm-Message-State: AOJu0Yyj+3jzGkqxUEEuGRqZz+JOAP+dFJyQnlZo8P4UJpAdDwmRUEpZ
 DedmM2KibWs9DaKuKp1Rbc6+kaoYPy+B9todNnIBbF7INeURQuAWSKmr/KnIHMnbAeMkQkVf4tv
 OIBJnXB8B65mvVNhYj0LnsZTxxDn4X/HJZ1Bu0MwK9Q==
X-Gm-Gg: ASbGncugei4dopAjFM7W3OFkCg4X9DN77dcQnkdNabjRsziN5D4dVZ82A0NSGKM1zSo
 qnNaLbcNfD67rgucNpgs21loSZ6t/HfSTxG1OuHpjmKyGBcITjVIOnepEZ5dmHB+j5lmxZ3CZly
 +bqRP/1F7ko66UOcBKF/prRwHLK7o6Ggzdwi3lKT1/Pn7nS6nk8eqrOQ18eHuZuxsTSCf6x16O/
 S/l9lebbr3zBUx1bTyCbdX9XCb9Hq0=
X-Google-Smtp-Source: AGHT+IFoMC9zs8yEB2jxzrdpR8u5HYEWho8UaSI4FT7Hg6GxmIdM2BUBihZl7WVGHdOTbaYDNft7NOV387Tw4rjmG1I=
X-Received: by 2002:a05:690e:204:b0:636:f08:8ad2 with SMTP id
 956f58d0204a3-63ccb9047ecmr9471874d50.38.1760117014256; Fri, 10 Oct 2025
 10:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251010160545.144760-1-berrange@redhat.com>
In-Reply-To: <20251010160545.144760-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Oct 2025 18:23:22 +0100
X-Gm-Features: AS18NWA7JMAwjS8BekEa_C6Zj8jXBKs-tfGL_RaqJmQAZtpuIaWkQjvppd7R1BU
Message-ID: <CAFEAcA-9WfE_vNKewpe=05bLs+mi8tQSN-3cYnAWwC0ErfQBmA@mail.gmail.com>
Subject: Re: [PATCH] gitlab: purge msys pacman cache
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Fri, 10 Oct 2025 at 17:05, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> For the Windows msys2 CI job we install many packages using pacman
> and use the GitLab cache to preserve the pacman cache across CI
> runs. While metadata still needs downloading, this avoids pacman
> re-downloading packages from msys2 if they have not changed.
>
> The problem is that pacman never automatically purges anything
> from its package cache. Thus the GitLab cache is growing without
> bound and packing/unpacking the cache is consuming an increasing
> amount of time in the CI job.
>
> If we run 'pacman -Sc' /after/ installing our desired package set,
> it will purge any cached downloaded packages that are not matching
> any installed package.
>
> This will (currently) cap the pacman download cache at approx
> 256 MB.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .gitlab-ci.d/windows.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> See a test job with this change, plus a find across the msys
> pacman cache, showing the cleanup effects....
>
> Before cleanup:
>
>   https://gitlab.com/berrange/qemu/-/jobs/11679136531#L34
>
> After cleanup:
>
>   https://gitlab.com/berrange/qemu/-/jobs/11679136531#L1126
>
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 1e6a01bd9a..6e1135d8b8 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -87,6 +87,7 @@ msys2-64bit:
>        mingw-w64-x86_64-pkgconf
>        mingw-w64-x86_64-python
>        mingw-w64-x86_64-zstd"
> +  - .\msys64\usr\bin\bash -lc "pacman -Sc --noconfirm"
>    - Write-Output "Running build at $(Get-Date -Format u)"
>    - $env:JOBS =3D $(.\msys64\usr\bin\bash -lc nproc)
>    - $env:CHERE_INVOKING =3D 'yes'  # Preserve the current working direct=
ory
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Hopefully this will make the CI job take less time (for the
record, currently in the main CI run it takes about 70 minutes,
of which 10 minutes is "unpack the cache" at the start and
20 minutes is "repack the cache" at the end).

thanks
-- PMM

