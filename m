Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E070C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvEJ-0005wv-6I; Tue, 29 Jul 2025 21:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1ugv3D-00034S-5u
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:52:11 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1ugv3B-0003MY-Li
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:52:10 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3138b2f0249so321228a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753836727; x=1754441527; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7UmGBf5vh/Q/wne8pry56sgUlYe0f0m3Fibfm33iR4=;
 b=dQsl09Oe1RjMxs24V7/0EgoSuxKc9gX9dLCnWOAIx2MMEx9FAgGVrUOE/BxnVS4sYD
 5g5DZ8RmG8ESRPnZFfg5jKADeC8qBplf1IpaCItOq+fb8W24yMUArzny/I30MHHwkDi7
 2eheJvxHVHM/Ln08/TlSPQVUWWsiVyWpT3ZQJw1mhzSSOauhDoKJmyDWOLbPDywai2KI
 xJyjZcENS1v7NOWoxbm32CeJhF16smYhFWIye/a785Ju7kmprp74jhH+cXxwhWepP/Ox
 W+GdBbruFOq0Jx0+9VKZI3MNxzXsiy+qT/ZAVeGkH9bFodrz3PwtkEF9ksnoTNcNK9P2
 z/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753836727; x=1754441527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7UmGBf5vh/Q/wne8pry56sgUlYe0f0m3Fibfm33iR4=;
 b=q0HkevGHhhjNCkO9dbe26Ght9TX6+lgvn5mVOw+yTkU7af4OGQJCPBq9pON9cCFPL0
 /rafAYQA+tm0AIyvdfY9zdFT9kSTpXq1J+vr5zzBcBpcKORRjrvMG3vH70U7kNkW2Fi3
 6beJ6NndQPDbNggUaXMDLwpICsGhFjEvJnFd0fAYelYVqwHlMjz6RpNoQDD2IKlxlNYi
 3xcT31fJugaS9Ya11JqXh1c1yrVxwdo8A6P19hVd0eAbInYvrE3WuaMkBWgY6XklwveB
 DqO3FTrwwR3qQJQwWH7xL3pqh+X8MAGK6hSK15OjN78bOoi537B6EYE7kn64scrO65c0
 0VgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmsqAY/QRv635GWzeQqUAK48r9IvhrgJkZ65Dwh9uX+mZp/DaOr8qSwIiQkxBObVg2pySRSCbl6DiW@nongnu.org
X-Gm-Message-State: AOJu0YzxtcFCa53rjaeu5tw0LERzJhY671OqWttyuZlmGxE9iwghHnsx
 8GgOAUdVxd5q6+lENKAqFyIQkj6ika6fKR0tJD9Sh9N2Yz1qFEzRkWlbcKV27wz30J4+GLQ3z0f
 /cPUm1sUXKCoFWrUz2LG2y65u8UadvE274W1QyVE=
X-Gm-Gg: ASbGncuKxxzKAubU7qth6lLOXFwV9/kvsLt03KdoBE0fLX5csOa1RDh52frkn1r6mqO
 7I4bio9yJEsRjiOlCd6H9/tAyRaw51jzR2uYx5D2GW5FRqjRWLHsLb6VUp2By/U8hTlCkIM5pJ+
 FGNv+XC93KJjp8xCmJxXZIwWbylVUTowvORcM5Il4FDWtqg7/IRbyeMzaa5qMBzS4CfWX9+zaWi
 vK/Yg==
X-Google-Smtp-Source: AGHT+IH6UydLmP/44NCz7jv0df8THGV3svsKqG6+rJIZ8YHkccQ2Ejca4qY3k8VToc0/hsikAXxt39+qqhfDrQu1+uw=
X-Received: by 2002:a17:90b:35d1:b0:312:e6f1:c05d with SMTP id
 98e67ed59e1d1-31f5dd891dcmr1837425a91.2.1753836727286; Tue, 29 Jul 2025
 17:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250729111143.1011889-1-frolov@swemel.ru>
In-Reply-To: <20250729111143.1011889-1-frolov@swemel.ru>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 29 Jul 2025 17:51:56 -0700
X-Gm-Features: Ac12FXw5SG6436Vaii8XB4dS79jNp-46ZHE0ok2ThLDcRcNMSp5xoCHGpGkO8VU
Message-ID: <CAMo8BfJw_EUUuGT0qVwhfgEi_tLzSmrOdwAip1E08XNZ4XF=6Q@mail.gmail.com>
Subject: Re: [PATCH] target/xtensa: Replace malloc() with g_strdup_printf()
To: Dmitry Frolov <frolov@swemel.ru>
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.244,
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

On Tue, Jul 29, 2025 at 4:12=E2=80=AFAM Dmitry Frolov <frolov@swemel.ru> wr=
ote:
>
> malloc() return value is used without a check.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  target/xtensa/translate.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 34ae2f4e16..42ef8d3eb9 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -112,13 +112,8 @@ void xtensa_collect_sr_names(const XtensaConfig *con=
fig)
>
>              if (*pname) {
>                  if (strstr(*pname, name) =3D=3D NULL) {
> -                    char *new_name =3D
> -                        malloc(strlen(*pname) + strlen(name) + 2);
> -
> -                    strcpy(new_name, *pname);
> -                    strcat(new_name, "/");
> -                    strcat(new_name, name);
> -                    free(*pname);
> +                    char *new_name =3D g_strdup_printf("%s/%s", *pname, =
name);
> +                    g_free(*pname);
>                      *pname =3D new_name;
>                  }
>              } else {

I believe that
  *pname =3D strdup(name);
in the `else` clause should also be changed to
  *pname =3D g_strdup(name);
to maintain coupling between allocation and deallocation functions.

--=20
Thanks.
-- Max

