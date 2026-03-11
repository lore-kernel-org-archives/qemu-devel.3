Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F76FD88FF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 05:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0CDP-00036k-83; Wed, 11 Mar 2026 01:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w0CDL-00036G-HU
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 01:34:35 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w0CDJ-0000In-Oj
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 01:34:35 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-5091d71aa11so7224881cf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 22:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773207272; cv=none;
 d=google.com; s=arc-20240605;
 b=WAsOZsx0WqfRddQswi7H7lODY/hnY7rixkGA5a85Pf5pm3vEcJ0t7A7bFP0CyaTSzC
 ibpTO4bNxQfsIyAMApIjoSRYi6WHYker8ZOQeZoLkcC8fg5PUpsgtLB84Za9N341d7nd
 9LVtjLqeqDKYoKHe/SKhyxWCjUa+gRuDIZVl72w27k5rM3s3RzrIoPnR8gUCoQskMbK4
 SXTyC+kk8tV5H52Ht618UwVyxFGmR1FGnwVzmc9P3OURI7WV4ZG3t6cx6aI+ErAjPHq2
 zLKgtVek6R05KT/K912aaNbTu8LFb63gwPzrcpiLh/QUrcIS3ogNHRyzOFfJ6Yqk54HN
 2zGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5PFW4axcmRCTFmUzUhsggxiPQKZwKwNTfkUJ8xgiFtE=;
 fh=CHQAzzRH9TUrMpU9lg17jvQiGfek9KUFLGKhGobLSRE=;
 b=B8xTDD9KPlRNxpYOUBEpZ2y4e6Ytt35Q0JhMnQCpjPaigF5da5qXBtju1OM5YCaZM1
 ZCVjhQY5cCFsuZ/dkHwVPTgWEsyNcTpAAwpBm+xVVjN6b//ytTCeHQJWzF4M6mB8uyFK
 6vegNX+Kb+M0Y9LUvIQ87G2ZwMGxPyYK9Z2iHeWE4nUdZyvz3HQxLbh3g81Mdoynm4BW
 uUstYGgsaB9M3SGi5WD4y20tJL81ReRAoHh2LDkEL4fTDZMO3XP/ZTTlKvpV5uVO/bKa
 jLXvYy4pGgUIHLIKOmeCv6C3gjmwGimAGQ4z3B7NbLhG+2C/7LtxdnPAU+AO24zXOYCj
 TAgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773207272; x=1773812072; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5PFW4axcmRCTFmUzUhsggxiPQKZwKwNTfkUJ8xgiFtE=;
 b=a+QTOlCWa1e/Auu3HOHqJl5wq6YGK2fvGvvaK4Ma7YG8NXlYJVGg1JnpgMlkSYRe1F
 tKUr0L2qL3GqrKQLeNwULbivNtQKs11dOsdjDnSGfFIZuc4XyLp+VxOpc2OeZeyPA24N
 4qhZkJFcE/bDfR/yHSTHpnxjryFJDX6URHQfohms+WLV4wYGz7j4rLdBo7U6hCpXNDDW
 A66wqnjDQjznrJ56sJqoUoZYBLspyop1eJ+6GpNCGpqA1VAwLUpW3LVbrxbHjsyLHe5V
 tTYEnXjX+SZVvtnN2ax3W1WzMApKvP8P4cTPj/+BdsfCV7Pn4jyp1oZSzvfzSQ0Moa9q
 U96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773207272; x=1773812072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5PFW4axcmRCTFmUzUhsggxiPQKZwKwNTfkUJ8xgiFtE=;
 b=aut0wkWrYNbAnVfnEes8mNOo13bDgZ25ZBlrFGH4zlEsUNjjkL89Cy86MjVVqsbbFE
 Nrs4P95z1xrjjoQPLdEOQ2NqXF+ErS2dh97p+hHWUJWrrn+KLUOS31LYEidwHQoo8zu1
 d/Zoj44tYkjpjy+Dw/HZCxo9PAzp8aPMJmxkIRQdC7A+GjqWd+UgSMJ7uhFc2KRViDd/
 jgiaRVp1BDt9pEiYeMzxWb0acVOdjiwjbZ83YX9cPSqH48f/kvTLSujFg3piH0o8O7vY
 8b44tvkZw0yQZQFDpFSZ+iCVFYFkQrdwqASEV0tWByLdEX2VSJR5acYv3RS7H7BU07xk
 I59Q==
X-Gm-Message-State: AOJu0YxAa9HQHsJ6UT5Vtrqkihu3nBDHseBVg5+GQU9kA/2Vd+yIJ8y+
 i/LPaB/hJVxFJ5RAOO1AefuLYYlNLjp8z1aDXFH4CJwW6fwDaJvm+n3/TClQ2B1+UR63GZKuIwa
 hLhWLTJl1xZ32ZrsbfWGVwIAvwMwKdRzpAkJahVuP0A==
X-Gm-Gg: ATEYQzx3dMsGtQw91fMrO7vrYdeIJgoKQkQIUqVg22fLLNHezL7vNns/3/qR1ivKlCq
 I+kARIOZAi28fll04mwUF6zsI5BX3WQMsJ3Sx/8w7lmwWpvdgEY8hNQ1xhVHuM5IteClihFOR2Y
 AZRh462KLZBohUoggcUzgYmzL/8tLDAj9WhaBkU6SDmQZwD6LtKl/ypY9QtS4oSN5CN/WgFIrfq
 DypSaJZIetCbhoPXBFCfO0t6SE39CVuDvU3EDqNfliAlv4GqGdP0hYjEAL8p5zOq+CSpZXrIegr
 5nQiCiAZ73wvBt4hlzCSbPX7lSYXd1Nez15/fSwZA0OVPc8pkQ==
X-Received: by 2002:a05:622a:15c1:b0:4ee:232e:4950 with SMTP id
 d75a77b69052e-50939eeca36mr13664431cf.8.1773207272444; Tue, 10 Mar 2026
 22:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260309214930.92616-1-lucaaamaral@gmail.com>
 <20260311022752.64192-1-lucaaamaral@gmail.com>
 <20260311022752.64192-2-lucaaamaral@gmail.com>
In-Reply-To: <20260311022752.64192-2-lucaaamaral@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 11 Mar 2026 06:34:21 +0100
X-Gm-Features: AaiRm52VEpBsOhQSizCTEm5feZda-qlYvvwDNipr0OKEMbBXYeloCS99DegbHiI
Message-ID: <CAJ+F1CKKwPDb759revxe8bFLL18ONbgtTdkcsqizoxUappy81Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ui: introduce GRAPHIC_FLAGS_VK for Vulkan scanout
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, Mar 11, 2026 at 6:29=E2=80=AFAM Lucas Amaral <lucaaamaral@gmail.com=
> wrote:
>
> Define GRAPHIC_FLAGS_VK (bit 2) in the console flags for future
> Vulkan scanout support.  The compatibility check currently returns
> an error indicating the feature is not yet implemented.
>
> This prepares the display framework for direct Vulkan scanout
> alongside the existing GL and DMABUF paths.
>
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/ui/console.h | 2 ++
>  ui/console.c         | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 98feaa5..6b8bbaf 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -361,6 +361,8 @@ enum {
>      GRAPHIC_FLAGS_GL       =3D 1 << 0,
>      /* require a console/display with DMABUF import */
>      GRAPHIC_FLAGS_DMABUF   =3D 1 << 1,
> +    /* TODO: require a console/display with Vulkan scanout */
> +    GRAPHIC_FLAGS_VK       =3D 1 << 2,
>  };
>
>  typedef struct GraphicHwOps {
> diff --git a/ui/console.c b/ui/console.c
> index f445db1..76d54bf 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -594,6 +594,12 @@ static bool console_compatible_with(QemuConsole *con=
,
>          return false;
>      }
>
> +    if (flags & GRAPHIC_FLAGS_VK) {
> +        /* TODO: check for Vulkan scanout support in display backend */
> +        error_setg(errp, "The console requires Vulkan scanout (not yet i=
mplemented).");
> +        return false;
> +    }
> +
>      return true;
>  }
>
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

