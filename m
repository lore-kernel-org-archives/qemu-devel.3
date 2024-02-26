Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB16C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reY2o-0000a6-SE; Mon, 26 Feb 2024 05:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reY2m-0000Zg-RK
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:17:08 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reY2l-0006jd-8b
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:17:08 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3d5e77cfbeso503702866b.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 02:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708942625; x=1709547425; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSvUGzrgw3cgxACKJW5Fpr88Ba+8iZIoQ8NnPQNWZWk=;
 b=yHB0YICCkOCoyNmSdJaESj6v9rkaHjqDGxhy1ytmEJB6O/+TZQ1PudHsmJFTUdh1oL
 ZjjrbEcfI2Qlf2DxQ0xKkwAnoHKzrk8qDelbO+MvDOaBwKOKgdXM0SIerrDMSOg7B2Nx
 GvH1ho8S8gxAUcJgvSCvU2ofZWZt/f3iYXCWWOINPhhutq3wlFnasdbrSdsk3RP7dMRy
 Mt9OuPB7AxTunuWXd3nF2Q6kQggnJZ2xF0zVoD1TOVB/5JDtgbREN+X4fp0DpCITyP6c
 0+tEndrNcsY2PnschiQdkkdq7eJrVW9KJsP37zWHSBB+ockUIl5uXs6Qq+wJW7pOp+ZO
 KX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708942625; x=1709547425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSvUGzrgw3cgxACKJW5Fpr88Ba+8iZIoQ8NnPQNWZWk=;
 b=drJF7Nh5ks/lwZL41ObGkffJdWIJu9HYPP/tUwX2E8FNjz7PoDDy52zoFf2LYAmQ74
 EBZniZG97yJZVsevDqKmQiqcAv2XuvikRcGvsX6r9f5MJLgy4Z6OnuHujXdtoxbOXqns
 2Eid4yYjcZ25ESGOCW0DvOym3MwxUM6dskNbKSSCBVvKr/scl5P7+QQ5hevHjjYTDsdM
 FQXIy0RfA0g1udaN8q5wtSPAywrZVEntpQW8WvEWcV0+U6ZbQ+zI3WfRB1OC3ml9nA1r
 epXQs+RHrx1fd6U83wHtRvWGqhNJGY2UDrk0VfpO4v6Y7rJAINgSnlZB3HikY3FO94zj
 c7KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd9YZ1YTxerC7NDPjurzAYeauv+++Z278vjkyK0V5HwDUHe55pcu+EEox17djBrsD5j1IV9gDtiIQYUqDJRhcKcF+BhgE=
X-Gm-Message-State: AOJu0Ywe5mIFFgzULB/y0TRXYX2Wyqd3QT4ywPA/9pKTZh+iRkOUYCrY
 rT/5+jU+lIa3JptQe3xOS9qg1FPBPpA1Fxp/dpZUwHICfekRYLB5j7kYMMg9IOyK84ftg8pH3zI
 QKk9GTg2Ch8yrgWNGXK/3UzLqR40cRDUCFlOjPg==
X-Google-Smtp-Source: AGHT+IEgWp33X0w1QggRScd3WlZ1Yakbtd6LVSTLKAsal/xLmk0nxSkfcPFnR5CcHqJVXll6x3QjdGB3J3fqY8a24NI=
X-Received: by 2002:a17:906:3db:b0:a3f:b007:cfcd with SMTP id
 c27-20020a17090603db00b00a3fb007cfcdmr6185254eja.13.1708942625046; Mon, 26
 Feb 2024 02:17:05 -0800 (PST)
MIME-Version: 1.0
References: <20240226090628.1986-1-dinglimin@cmss.chinamobile.com>
 <2b3f15a8-93ba-4d4f-bfd6-7af11aade2dc@linaro.org>
In-Reply-To: <2b3f15a8-93ba-4d4f-bfd6-7af11aade2dc@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 10:16:54 +0000
Message-ID: <CAFEAcA_xJVrQZTMUM1x8+aiaABAs2Zg4ULP=ed7BzNQjn2_-vA@mail.gmail.com>
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: dinglimin <dinglimin@cmss.chinamobile.com>, richard.henderson@linaro.org, 
 qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 26 Feb 2024 at 09:49, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> On 26/2/24 10:06, dinglimin wrote:
> > Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
> > ---
> >   semihosting/uaccess.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> > index dc587d73bc..7788ead9b2 100644
> > --- a/semihosting/uaccess.c
> > +++ b/semihosting/uaccess.c
> > @@ -14,10 +14,10 @@
> >   void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
> >                           target_ulong len, bool copy)
> >   {
> > -    void *p =3D malloc(len);
> > +    void *p =3D g_try_malloc(len);
> >       if (p && copy) {
> >           if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
> > -            free(p);
> > +            g_free(p);
> >               p =3D NULL;
> >           }
> >       }
>
> This seems dangerous, now all users of uaccess_lock_user() must
> use g_free(), in particular lock_user_string() which is used more
> than a hundred of times:

Users of lock_user_string() and other lock_user() functions are
supposed to unlock via unlock_user(); if they directly call either
free() or g_free() they have a bug.

-- PMM

