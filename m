Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59435CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 07:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ZUk-0006GL-Db; Tue, 14 Oct 2025 03:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZUh-0006Fs-Pk
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:30:51 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZUf-0004sF-W1
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:30:51 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-7900f7f4ba9so58872696d6.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760427048; x=1761031848; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulClb2Ykb6HnoV2pD2vHzTnvCHvbkDlgy4oorUlAYAI=;
 b=jLPsm0ogme0UHnMZZ+twwT/anFEZjkptCxX/h32zunBhkQ5Q3XmlN8MNhMl9bj8U0x
 lEucXd4PxdObmweU9KOwnaSUK2e8hEKSgWERp6smHWc2SiZ2F+c5NcEUfC5J6j0dR+ho
 tq0pJ47sLNzwxc2Ck0XYaPCfuUK1joOJ6zSwDjDE+YvVy52fDuTZpnNgGBXF2tX2nar3
 2NdgJX7cpxEQ9pr1EQKXSkjGWqESYOJDVQvhcsvqQeQ7iA+CIJTvgeTZVDBRgdGRW2CR
 W3VbqOg1z9boeE+nDHMvDtJOVYbfcjALEdxpWI/aItDg/e6KBpBKgOI3qT71qyZgmACS
 nRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760427048; x=1761031848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulClb2Ykb6HnoV2pD2vHzTnvCHvbkDlgy4oorUlAYAI=;
 b=LDG6kQytHKPk9YnpVtj1oe7WqABh6iSwP39jarac/ldRgU1GxSKTRG8tvK3naiTfoc
 GE0mi8cit3Z1EP0FU+DmZPqv7qf1AkbMsMYvFOezcA3B6x8UjQW3Z6CAwpgBllHoGVZM
 yindjwgjmjgW0RvSixYysG1n9YKOrRBKOEjb1+MpD4jd5FfaDNof2O9nEManY3wUgVl8
 2AD8iB420ZA2yYNqlJAMiWDzriGvlvrI7uj9cAeGQ2gB+BaetBe8/qRL6O7W0zkt9j1N
 f72PsWFQpcH3qx1lL0j3We3PTxNjmPpcKka26X4HIix2OZcKJ+iHKZwCEGK2cwEZFF9r
 /Y5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFdPuuAOQx3pC6/TAnjpV6fwq1SjmSOMb6iFWDGhShcp3MKdUE/bZXseXOq6AL6GvHn04eWC8lte5K@nongnu.org
X-Gm-Message-State: AOJu0YxXCIEcRiOieWayngWsWESK3IpaL2N/veMeXHZNwnUn1hNhER68
 Zbh32M7nHGvHCMXdQNHDuB4PSOUnXFCtYVLQCQFC15or6AcWwKpD1RUeAwUjZYQkIgGWe8FQlnH
 e7RxQxyIoQv/lOF1tI2O/b49eepK8lUg=
X-Gm-Gg: ASbGncvdbaPKyb4kQLDrcnXq4gnasgAcKN5W32PcdQQWDEoXqw8562vq3zMONR61/Yf
 tJpTARfb7aqx2/Iwmb/52jNR3zFT/CPGZJETeU0B1KOhz2jCqaND2z31qz/gGZDuZE3wEcOboul
 uznDRCLWCnbT6d2KHEf5V1yrjcQUA00mXOr5YZFlIkSPSRn65NMqpgwr0o83Pzrnp2ADEVoW/Fk
 W7wW9nYFJsIz5FnbmiltbsVmIHZuk1oxUKJJ/hI2Htx4bfZo6dwBbmqow==
X-Google-Smtp-Source: AGHT+IEdEoxSunmYgOLbZt3aclImYkBsDRaOpVW9XKo8G/xwFTdjAATbgwEvNYWrsmOTKAj/cfVA7dOS8L4Tbm+CLV4=
X-Received: by 2002:ac8:7d86:0:b0:4e7:25ae:be92 with SMTP id
 d75a77b69052e-4e725aec4c2mr99997021cf.47.1760427047734; Tue, 14 Oct 2025
 00:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <20251013133836.852018-8-vsementsov@yandex-team.ru>
In-Reply-To: <20251013133836.852018-8-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Oct 2025 11:30:36 +0400
X-Gm-Features: AS18NWCZfpNAeZxzGpedXeh4iJK85btrXM8KJXsusuXQnhzlgT8ri1uX9fCNOkY
Message-ID: <CAJ+F1C+E6Q8V2_Qn14d490+qbLZTEf08hStC5w6=vV5ebNcvoA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] char: vhost-user-blk call connect by hand
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2e.google.com
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

Hi

On Mon, Oct 13, 2025 at 5:39=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Give vhost-user-blk a possibility (and responsibility) to decide when
> do connect. It will help us to realize vhost-user-blk backend-transfer
> migration feature:
>
> For incoming migration we'll need to postpone connect at least until
> early stage of migrate-incoming command, when we already know all
> migration parameters and can decide, are we going to do incoming
> backend-transfer (and get chardev fd from incoming stream), or we
> finally need to connect.
>
> With this patch, we don't modify vhost-user-blk.c: it already
> do call qemu_chr_fe_wait_connected(), which in turn calls
> qemu_chr_connect().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  chardev/char-fe.c                | 21 +++++++++++++++++----
>  hw/core/qdev-properties-system.c |  2 +-
>  include/chardev/char-fe.h        |  2 ++
>  3 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index 973fed5bea..9e2c658cb9 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -189,12 +189,20 @@ bool qemu_chr_fe_backend_open(CharBackend *be)
>      return be->chr && be->chr->be_open;
>  }
>
> -bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
> +bool qemu_chr_fe_init_ex(CharBackend *b, Chardev *s, ObjectClass *oc,
> +                         Error **errp)
>  {
>      unsigned int tag =3D 0;
> -
> -    if (!qemu_chr_connect(s, errp)) {
> -        return false;
> +    const char *driver =3D oc ? object_class_get_name(oc) : NULL;
> +
> +    /*
> +     * vhost-user-blk wants call qemu_chr_connect by hand,
> +     * to support backend-transfer migration feature.
> +     */
> +    if (!driver || !g_str_has_prefix(driver, "vhost-user-blk")) {
> +        if (!qemu_chr_connect(s, errp)) {
> +            return false;
> +        }

Why not pass a bool "connect" instead?

DEFINE_PROP_CHR() would use "true".

+ Introduce DEFINE_PROP_CHR_NO_CONNECT() that would use "false".

and wire it with a new PropertyInfo and modified callbacks.

>      }
>
>      if (s) {
> @@ -218,6 +226,11 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Er=
ror **errp)
>      return true;
>  }
>
> +bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
> +{
> +    return qemu_chr_fe_init_ex(b, s, NULL, errp);
> +}
> +
>  void qemu_chr_fe_deinit(CharBackend *b, bool del)
>  {
>      assert(b);
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
> index 1f810b7ddf..35eed17d4d 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -297,7 +297,7 @@ static void set_chr(Object *obj, Visitor *v, const ch=
ar *name, void *opaque,
>      if (s =3D=3D NULL) {
>          error_setg(errp, "Property '%s.%s' can't find value '%s'",
>                     object_get_typename(obj), name, str);
> -    } else if (!qemu_chr_fe_init(be, s, errp)) {
> +    } else if (!qemu_chr_fe_init_ex(be, s, obj->class, errp)) {
>          error_prepend(errp, "Property '%s.%s' can't take value '%s': ",
>                        object_get_typename(obj), name, str);
>      }
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index 8ef05b3dd0..f1c05cc5ed 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -34,6 +34,8 @@ struct CharBackend {
>   * Returns: false on error.
>   */
>  bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp);
> +bool qemu_chr_fe_init_ex(CharBackend *b, Chardev *s, ObjectClass *oc,
> +                         Error **errp);
>
>  /**
>   * qemu_chr_fe_deinit:
> --
> 2.48.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

