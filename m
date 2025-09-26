Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440E3CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 09:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v24jo-0001h7-V3; Fri, 26 Sep 2025 05:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1v24ji-0001fg-0V
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:27:30 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1v24jY-0007H1-8R
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:27:29 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b346142c74aso376393466b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1758878832; x=1759483632; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKdVBBnye5hYazauF31jfjaAbCCM0bVkxQ66IvDK/B4=;
 b=IGZOE4GwGxgL8cWXrAF+yCHqKohkbv5WkkWxO0yeGfXf1mAAQI/BZkO7P/P+x/G9P+
 Gqdrf/M/RgpjlnotW908ru4tcd13YSP4Po41Kit8fGuZQiiVODkmEVpzWELOgfE4un86
 /YGMcSvccdEsAV/uwBSnHyIYvYUgjWqsJV9DANITSHe3JcgF+FDzIXW0A/j/uxdj/hJ3
 W5Q15tZmxY1zYfEJh3uVG71BI3j6yvGzSE6ugxjLBNcmXsICFXCdj8uHwLm1M2Sua7v6
 UEDhdptR2MopMPiJPPsNCJ87sqg6nssvfkB42K7JRJeFaYJBxHY0yxpzrU0pkXt14YLN
 pb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758878832; x=1759483632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKdVBBnye5hYazauF31jfjaAbCCM0bVkxQ66IvDK/B4=;
 b=DvsFnMbQkruMSMw6Hw2mYzJLDBDmVsuNkbOhENWy7Uh0665YAIdW05o3Vf+6wAHEHK
 zvSDc04WW40PYP30vzOcWdBoY3SgG3duIstJAHlmenP16PvJcWMbzsfQB0G+qgpcWiPM
 cJJQOEjy1LCe4q3/fk7tZ6rM9zuwJKz7DbODFrHsgaQ/WksESyxZsQd9wmx9GIOR8XXj
 D4wtKTWQKjdG26JvjtneiBhOv3BRY3Kzzj5n9Py+br5IeHUAXVI3eSos9eYkn42yGZo8
 5zhic+dntlszNOlxV0fMeJuZXWG7Y/gL+d9ekrrdT/7SCrfEHk/brrd/glD8fJ3jSBbm
 OlVg==
X-Gm-Message-State: AOJu0Yz+YPZndOqL2GPmn0mjXStyb4oI2B8lqkGFWE0cWYrZvcTmB1yX
 GUF9ldqmjNMHustRWk3GJuHZbdsiKWzhd6igZ7eyWHYLMMpiYHknhX3rreiIg4CSuDxyQuNrkHD
 4XEGQvr5we9nalnVkzvgozGUyaLdS7g6iV7cDqfiaNQ==
X-Gm-Gg: ASbGnctBA8jVUKGpW0nGDH+Yyatrlp3hVwVS54/0/cRdbdsEK5Q32ibnvBaDjPCIhdb
 /+E0Ih7bx8xUIzoraQ8t2HqSFvshIXTH8Yj8rLRy1u0NMfObFUuQ6kM5r0m7/V7ypUe7v/EcZd0
 5DR9d6gGq0uEf5Paal6PFE2Z1Z3LIvqYDp3vksidKfznWJuRyg6bKNf1aMrz2kr+UPzU3O1zX4n
 c4TBCVdE3x0iMKklMk=
X-Google-Smtp-Source: AGHT+IGOtCCH3o1QOyYUqchEncbRcaSNaYcmYMmUw12moqHBVBQ4LxbNiqVccLMbcTvQTS9DibYdKh/jrN4OejNDFog=
X-Received: by 2002:a17:907:702:b0:b04:7107:9758 with SMTP id
 a640c23a62f3a-b34baf43b3amr782178766b.43.1758878831964; Fri, 26 Sep 2025
 02:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250908141911.2546063-1-alex.bennee@linaro.org>
In-Reply-To: <20250908141911.2546063-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Fri, 26 Sep 2025 11:27:00 +0200
X-Gm-Features: AS18NWC2_3StMsGa2VBMjyate6b4-M4vikdzRGDSNne_rb-B5GAkfC_DxE93KNk
Message-ID: <CAEg0e7ic1yZw=XYVjE+FeXkwrN1NpWAm422=HtBfaTqcNKmwAg@mail.gmail.com>
Subject: Re: [PATCH] .gitmodules: move u-boot mirrors to qemu-project-mirrors
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 8, 2025 at 4:21=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> To continue our GitLab Open Source Program license we need to pass an
> automated license check for all repos under qemu-project. While U-Boot
> is clearly GPLv2 rather than fight with the automated validation
> script just move the mirror across to a separate project.

If I haven't missed anything, then it is currently not possible to
build any (recent?) QEMU release without this patch.
It would be great if this patch could be backported to at least the
stable-10.1 branch.
This patch landed as `a11d1847d5ef` on master and applies cleanly on
stable-10.1.

Thanks,
Christoph

>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: qemu-stable@nongnu.org
> ---
>  .gitmodules | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.gitmodules b/.gitmodules
> index 73cae4cd4da..e27dfe8c2c1 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -15,7 +15,7 @@
>         url =3D https://gitlab.com/qemu-project/qemu-palcode.git
>  [submodule "roms/u-boot"]
>         path =3D roms/u-boot
> -       url =3D https://gitlab.com/qemu-project/u-boot.git
> +       url =3D https://gitlab.com/qemu-project-mirrors/u-boot.git
>  [submodule "roms/skiboot"]
>         path =3D roms/skiboot
>         url =3D https://gitlab.com/qemu-project/skiboot.git
> @@ -27,7 +27,7 @@
>         url =3D https://gitlab.com/qemu-project/seabios-hppa.git
>  [submodule "roms/u-boot-sam460ex"]
>         path =3D roms/u-boot-sam460ex
> -       url =3D https://gitlab.com/qemu-project/u-boot-sam460ex.git
> +       url =3D https://gitlab.com/qemu-project-mirrors/u-boot-sam460ex.g=
it
>  [submodule "roms/edk2"]
>         path =3D roms/edk2
>         url =3D https://gitlab.com/qemu-project/edk2.git
> --
> 2.47.3
>
>

