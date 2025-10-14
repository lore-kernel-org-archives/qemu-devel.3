Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BF9CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 07:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ZUy-0006J5-UA; Tue, 14 Oct 2025 03:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZUx-0006Il-CC
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:31:07 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZUv-0004t4-Hc
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:31:07 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-7900f7f4ba9so58875166d6.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760427064; x=1761031864; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBjNMBlmfg+GpyE8/JHfGudE6LK50p6tVlRvBQ9FnCY=;
 b=k5lLFG93XeMfI6vI0kTJas8mEDz52DFRnxlSc62D/HLlhlxO+EBucvE7dXAuWD7zQ3
 9jX27t3393fm91zU7oFFXEK9QQwP72C4fUsd3AV0Y5E0dB/iE93xnKkAI8V/Xb0G4AlW
 +QZkvNUb4kcOSv1BOJIrxnEOGpyl9SBroHEfxX527bGMM1F1yUgo7bzJAbNOeBwItUmy
 0py0vzFICK6TJY7uBUdZVyAeckqWCYj2zTNZycXa9XkKDsOQIRGXFNPz6TRYvXoc4pn4
 RKWGFfumTi6z+B5p4WWk2gcF4edgRhvTJSle7Cm9XwFHQ69EErmvee54ZV0oLUE1NBCJ
 xf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760427064; x=1761031864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBjNMBlmfg+GpyE8/JHfGudE6LK50p6tVlRvBQ9FnCY=;
 b=VheuC8m1n3uDBJhc0mnk0pOMYNGS9JCmRNsfE1ohZKOFa3JOvAdgpYmJRTefuSIigg
 0vev1/KGKhE4SZP6sAFFssjDQIhrpxUVWB0k0rhHmfvHplzOIQlxNC4nW43lK2BJ7zNE
 UjuJVXKpp8a/JD1mklYB6n7/DTVeKYarUE5U+jRzMNs8G+g/APJXBWB0pd+CyGFg9hCG
 8cVIAF0ggza17WUvgI/Fy6kSZIms3LmOw9uAMDPFHQw8MCm7CxJklT030GIOreyjBQug
 lhgxOC03O93/yK3eAKRV8u7yT2HjWQZkt9K5zjBpGD53KlyUO2gThevBtvLiKs6ZLIru
 LJyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdPhD+44DCrKPapLrhVXzMySU/+/oVmSnbEpi8KAMHDfXjUCUhvpp2OHCOL2zWkujnIpqbcdI9srnS@nongnu.org
X-Gm-Message-State: AOJu0YyHD3k5uVWyaxu4POUlw94kY/seI/GrqSnPB6UiP+KCjYZuprqe
 Z0wAPFxNqk5Z/fKNE7j/9+yrnOR8v/dBSDvcSvb43z3IGGBjBipz5ekHAjYePrqjepDxQ/3lNgQ
 c1wRv88RSK6MXpa4W0FKX+QOL2uB6vKE=
X-Gm-Gg: ASbGnctfGeZ3Oa1zwd0I4290iJ5MN3S+npZMgV+ICFkOT/gZKY8zh8kJU5q0H1wMtDu
 CC9ztDtpFgYsBMujhiaVuMi59HztecN2HldnZhfWv8yFIsqEKiXEOGydeOibKHKKVe0ADxDF3LG
 ATf6ivWuBb0d7D7Kek5ypOUitQczKFvbDvedKLFP07bbESvYpXw860KoP3jwqpC/cqA9Wtmto0O
 kPbPxXBSxut8iINwnS2cPxYMgxrlZWSfDp6d16ISqw7wCYu3qhAynT0SovLYeoR9mae
X-Google-Smtp-Source: AGHT+IG5oeCWQxebpEIpTiyRXHCrnyBM5bK7wtLQF0y2duKRXj4taSLy+C1Sorl7VA2OIyCOhXlK/PtqrJZQB+fanVA=
X-Received: by 2002:a05:622a:1346:b0:4d6:b374:fd80 with SMTP id
 d75a77b69052e-4e6ead5483fmr328821331cf.41.1760427064071; Tue, 14 Oct 2025
 00:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <20251013133836.852018-3-vsementsov@yandex-team.ru>
In-Reply-To: <20251013133836.852018-3-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Oct 2025 11:30:52 +0400
X-Gm-Features: AS18NWBEi4ovXNtMMhIQUgRofthys7nM-wR2TcmAgIpY8WV-FASG9Cp9muU0UB8
Message-ID: <CAJ+F1C+W+hUuu--QopWqB14w2VWeiPkOxxGdS-v2K7MB4eye-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] chardev/char: split chardev_init_logfd() out of
 qemu_char_open()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2b.google.com
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

On Mon, Oct 13, 2025 at 5:41=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We are going to share new chardev_init_logfd() with further
> alternative initialization interface. Let qemu_char_open() be
> a wrapper for .open(), and its artifacts (handle be_opened if
> was not set to false by backend, and filename).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char.c | 49 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index a43b7e5481..d5a2533e8e 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -250,22 +250,6 @@ static void qemu_char_open(Chardev *chr, ChardevBack=
end *backend,
>                             bool *be_opened, Error **errp)
>  {
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> -    /* Any ChardevCommon member would work */

maybe keep that comment?


> -    ChardevCommon *common =3D backend ? backend->u.null.data : NULL;
> -
> -    if (common && common->logfile) {
> -        int flags =3D O_WRONLY;
> -        if (common->has_logappend &&
> -            common->logappend) {
> -            flags |=3D O_APPEND;
> -        } else {
> -            flags |=3D O_TRUNC;
> -        }
> -        chr->logfd =3D qemu_create(common->logfile, flags, 0666, errp);
> -        if (chr->logfd < 0) {
> -            return;
> -        }
> -    }
>
>      if (cc->open) {
>          cc->open(chr, backend, be_opened, errp);
> @@ -1000,6 +984,28 @@ void qemu_chr_set_feature(Chardev *chr,
>      return set_bit(feature, chr->features);
>  }
>
> +static bool chardev_init_logfd(Chardev *chr, ChardevBackend *backend,
> +                                Error **errp)
> +{
> +    ChardevCommon *common =3D backend ? backend->u.null.data : NULL;
> +
> +    if (common && common->logfile) {
> +        int flags =3D O_WRONLY;
> +        if (common->has_logappend &&
> +            common->logappend) {
> +            flags |=3D O_APPEND;
> +        } else {
> +            flags |=3D O_TRUNC;
> +        }
> +        chr->logfd =3D qemu_create(common->logfile, flags, 0666, errp);
> +        if (chr->logfd < 0) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  static Chardev *chardev_new(const char *id, const char *typename,
>                              ChardevBackend *backend,
>                              GMainContext *gcontext,
> @@ -1020,11 +1026,14 @@ static Chardev *chardev_new(const char *id, const=
 char *typename,
>      chr->label =3D g_strdup(id);
>      chr->gcontext =3D gcontext;
>
> +    if (!chardev_init_logfd(chr, backend, errp)) {
> +        goto fail;
> +    }
> +
>      qemu_char_open(chr, backend, &be_opened, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        object_unref(obj);
> -        return NULL;
> +        goto fail;
>      }
>
>      if (!chr->filename) {
> @@ -1035,6 +1044,10 @@ static Chardev *chardev_new(const char *id, const =
char *typename,
>      }
>
>      return chr;
> +
> +fail:
> +    object_unref(obj);
> +    return NULL;
>  }
>
>  Chardev *qemu_chardev_new(const char *id, const char *typename,
> --
> 2.48.1
>
>


--
Marc-Andr=C3=A9 Lureau

