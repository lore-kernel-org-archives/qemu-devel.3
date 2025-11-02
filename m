Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B9ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 11:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFWR4-0005zo-HX; Sun, 02 Nov 2025 06:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vFWR3-0005z2-74
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vFWQz-0002pM-Uk
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762083582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oS2NCU11RFKB6GAk9tldlqoSpfyThgNzg4eP7f2KElE=;
 b=SuG2ZqHnepb8XFoaP8gnhNDZYaIoq8xoQja5kiHh0e/EOJ9bGJNeXUb2KcRYv0Anq16GvG
 siA2vxs4uy2DYWmLxlgCJpxS4IGiFWOm09nr6Y2p3iBxSj0e4LFTlbEBEdwE686rWWiZ66
 rjx1X1VM/wGBVWMSsD8egXdF4rqjq24=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-y-EnOBgTPf2nJ_kUd_-WmQ-1; Sun, 02 Nov 2025 06:39:21 -0500
X-MC-Unique: y-EnOBgTPf2nJ_kUd_-WmQ-1
X-Mimecast-MFC-AGG-ID: y-EnOBgTPf2nJ_kUd_-WmQ_1762083560
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7a9fb6fcc78so399238b3a.3
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 03:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762083560; x=1762688360; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oS2NCU11RFKB6GAk9tldlqoSpfyThgNzg4eP7f2KElE=;
 b=Omk8aKgUdC44gin9Q15ZmyWUOsKIJTHtlnbX0LkLMvemUMtTiP2y8NcsDawk7YLfVZ
 GLaIMxhyWM5/0bIYyHLVoG7xZ3PEAI7pdQ4MGuU2jLsUSbeD6jBHnc3lNPYEs2gNO6zz
 vdxUbWNstFxMg/U7qsOaoDH4pPu3lTmzmVN68JcbnpuwlYH52/uCRoHWk1OUhFIoYDc8
 4USQWB5yRNVRGHG6nyjQEyndIfZgd/OVAE14G0FjgqZMNm4KjV/pSlQ9lnLgtMKsFmVT
 wkRMpkKd+Fe3ume507DwI7KY4pgCFcX+5BQfF9Wy3EPG3X+mqLSZjUHQfNZXbYd0kJyW
 5K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762083560; x=1762688360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oS2NCU11RFKB6GAk9tldlqoSpfyThgNzg4eP7f2KElE=;
 b=dMqYqz4EVuhz87lAAn0Wj4Tx+QLmPR/gZJJIyToEkUKDp1di6tGcWd6Pt22fiOa+Jn
 6SuszhLYyb1sxoQiRzAlwJ5BHCZycUYr8DPDyWtFYTCk0bSBBzwyXqxq9io8R05ac9OL
 OcwuFemzElYYpq6x1enmtImbTawj2ObDx95V4KLfpE+ogoCtoVOMADze45weFwzdINUV
 Dx7Nnxo/pJvAzZO6oQl/OprJHFmN/cC+Y0B6b6thiwB6SQG4sBz1Fa8yKdUxh+5L4xFU
 MAy920eFM25Af2ijeij2EmY0JDByNxQ9Nr4mISC0CoYU93SoaxGvRXwp3/UI9oiHtOWx
 JFZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ8c/A+RQ/XvJF82GyBSz+xr+VJpJp9p09Bd/6NmZbvraJFhPE/U5CfYdjz5PDEKQ9YQIo2xZ0zllz@nongnu.org
X-Gm-Message-State: AOJu0YwXxOTisDY0/Z/hL09Q/OeLwA4gAJyRXr3StYWL9KtZoD/hBSSS
 ujWvNVKE6dsThhsfgdeffYGfGoiKJR620S1vdu7ZBZVOAfQXL9CGSMe2ZIHu1F6IsnCRJ3UAFZf
 kDbDVGU/zVIVJBdeSpouGtjicWuK6BqthB8pYqrZQZGupUc86JKIXYKPCsvM7oBZ2p7Mt/Z88d2
 1dtqKEpXK+/jcByXlCFMQ6l/EyU06xcyU=
X-Gm-Gg: ASbGncvcOaz3CPxYe38PyE1AA3ukdTtd6ttp1IGp/RYshGeAQcuFIybuqdbq0T24vHH
 /TXRJpFd4UZkedblKSpF9epklgn81uUX+qh1rKmQzX9SN6DbAPKRv1c6pwowYiealPbGvcugQN+
 xV3r0lA/iNxh6TwLGC10Z1Nu50HQHsF/kdbu9Y+DAyViGGx0pjCZjgrhVn3PFTvw==
X-Received: by 2002:a05:6a21:3282:b0:306:2a14:d0d4 with SMTP id
 adf61e73a8af0-348cc2d99c3mr13804252637.43.1762083560009; 
 Sun, 02 Nov 2025 03:39:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiYgf8ZdTlrUqyypD7I3Yu/j5hZ/Ept88nTYS3+ZYYnp7QJh5yZyiBgpNWQox8Hy4fdpQX7JeGsizPbPEsk5Y=
X-Received: by 2002:a05:6a21:3282:b0:306:2a14:d0d4 with SMTP id
 adf61e73a8af0-348cc2d99c3mr13804227637.43.1762083559620; Sun, 02 Nov 2025
 03:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20251031155914.189112-1-vsementsov@yandex-team.ru>
 <20251031155914.189112-8-vsementsov@yandex-team.ru>
In-Reply-To: <20251031155914.189112-8-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 2 Nov 2025 15:39:08 +0400
X-Gm-Features: AWmQ_bmCkj1ILU6lwehpOkebczTp56XUlRfRNr1lU9cB04ctO-KyDc3FMVB_S0U
Message-ID: <CAMxuvawdBHuHEkZSQw0LtLmNGwuBAYsh-k8CwX=jfH5T+BFWfA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] chardev: introduce DEFINE_PROP_CHR_NO_CONNECT
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: multipart/alternative; boundary="000000000000a2d86806429b0c44"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000a2d86806429b0c44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 31, 2025 at 7:59=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> For further vhost-user-blk backend-transfer migration realization we
> want to give it (vhost-user-blk) a possibility (and responsibility) to
> decide when do connect.
>
> For incoming migration we'll need to postpone connect at least until
> early stage of migrate-incoming command, when we already know all
> migration parameters and can decide, are we going to do incoming
> backend-transfer (and get chardev fd from incoming stream), or we
> finally need to connect.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  chardev/char-fe.c                   | 32 ++++++++++++++++++++++++-----
>  hw/core/qdev-properties-system.c    | 26 ++++++++++++++++++++---
>  include/chardev/char-fe.h           |  8 ++++++--
>  include/hw/qdev-properties-system.h |  3 +++
>  4 files changed, 59 insertions(+), 10 deletions(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index c67b4d640f..1132ec0501 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -189,15 +189,26 @@ bool qemu_chr_fe_backend_open(CharFrontend *c)
>      return c->chr && c->chr->be_open;
>  }
>
> -bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp)
> +bool qemu_chr_fe_init_ex(CharFrontend *c, Chardev *s, bool connect,
> +                         Error **errp)
>  {
>      unsigned int tag =3D 0;
>
> -    if (!qemu_chr_connect(s, errp)) {
> -        return false;
> -    }
> -
>      if (s) {
> +        if (connect) {
> +            if (!qemu_chr_connect(s, errp)) {
> +                return false;
> +            }
> +        } else {
> +            /* DEFINE_PROP_CHR_NO_CONNECT */
> +            if (!s->connect_postponed) {
> +                error_setg(errp,
> +                           "Chardev %s does not support postponed
> connect",
> +                           s->label);
> +                return false;
> +            }
> +        }
> +
>          if (CHARDEV_IS_MUX(s)) {
>              MuxChardev *d =3D MUX_CHARDEV(s);
>
> @@ -210,6 +221,12 @@ bool qemu_chr_fe_init(CharFrontend *c, Chardev *s,
> Error **errp)
>          } else {
>              s->fe =3D c;
>          }
> +    } else {
> +        /*
> +         * connect=3Dfalse comes only from DEFINE_PROP_CHR_NO_CONNECT,
> +         * through do_set_chr, which provides chardev ptr.
> +         */
> +        assert(connect);
>

Is this useful to assert?


>      }
>
>      c->fe_is_open =3D false;
> @@ -218,6 +235,11 @@ bool qemu_chr_fe_init(CharFrontend *c, Chardev *s,
> Error **errp)
>      return true;
>  }
>
> +bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp)
> +{
> +    return qemu_chr_fe_init_ex(c, s, true, errp);
> +}
> +
>  void qemu_chr_fe_deinit(CharFrontend *c, bool del)
>  {
>      assert(c);
> diff --git a/hw/core/qdev-properties-system.c
> b/hw/core/qdev-properties-system.c
> index 13cc91680b..00f4b19238 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -266,8 +266,8 @@ static void get_chr(Object *obj, Visitor *v, const
> char *name, void *opaque,
>      g_free(p);
>  }
>
> -static void set_chr(Object *obj, Visitor *v, const char *name, void
> *opaque,
> -                    Error **errp)
> +static void do_set_chr(Object *obj, Visitor *v, const char *name, void
> *opaque,
> +                       bool connect, Error **errp)
>  {
>      ERRP_GUARD();
>      const Property *prop =3D opaque;
> @@ -297,13 +297,25 @@ static void set_chr(Object *obj, Visitor *v, const
> char *name, void *opaque,
>      if (s =3D=3D NULL) {
>          error_setg(errp, "Property '%s.%s' can't find value '%s'",
>                     object_get_typename(obj), name, str);
> -    } else if (!qemu_chr_fe_init(fe, s, errp)) {
> +    } else if (!qemu_chr_fe_init_ex(fe, s, connect, errp)) {
>          error_prepend(errp, "Property '%s.%s' can't take value '%s': ",
>                        object_get_typename(obj), name, str);
>      }
>      g_free(str);
>  }
>
> +static void set_chr(Object *obj, Visitor *v, const char *name, void
> *opaque,
> +                    Error **errp)
> +{
> +    do_set_chr(obj, v, name, opaque, true, errp);
> +}
> +
> +static void set_chr_no_connect(Object *obj, Visitor *v, const char *name=
,
> +                               void *opaque, Error **errp)
> +{
> +    do_set_chr(obj, v, name, opaque, false, errp);
> +}
> +
>  static void release_chr(Object *obj, const char *name, void *opaque)
>  {
>      const Property *prop =3D opaque;
> @@ -320,6 +332,14 @@ const PropertyInfo qdev_prop_chr =3D {
>      .release =3D release_chr,
>  };
>
> +const PropertyInfo qdev_prop_chr_no_connect =3D {
> +    .type  =3D "str",
> +    .description =3D "ID of a chardev to use as a backend",
> +    .get   =3D get_chr,
> +    .set   =3D set_chr_no_connect,
> +    .release =3D release_chr,
> +};
> +
>  /* --- mac address --- */
>
>  /*
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index 5f8a6df17d..f3df57afa1 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -25,14 +25,18 @@ struct CharFrontend {
>  };
>
>  /**
> - * qemu_chr_fe_init:
> + * qemu_chr_fe_init(_ex):
>   *
>   * Initializes the frontend @c for the given Chardev backend @s. Call
>   * qemu_chr_fe_deinit() to remove the association and release the backen=
d.
> + * Call qemu_chr_connect(), except for the case when connect=3Dfalse
> + * parameter set for _ex() version.
>   *
>   * Returns: false on error.
>   */
> -bool qemu_chr_fe_init(CharFrontend *c, Chardev *be, Error **errp);
> +bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp);
> +bool qemu_chr_fe_init_ex(CharFrontend *c, Chardev *s, bool connect,
> +                         Error **errp);
>
>  /**
>   * qemu_chr_fe_deinit:
> diff --git a/include/hw/qdev-properties-system.h
> b/include/hw/qdev-properties-system.h
> index 5c6cc5eae8..a0b14a2f77 100644
> --- a/include/hw/qdev-properties-system.h
> +++ b/include/hw/qdev-properties-system.h
> @@ -7,6 +7,7 @@ bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm,
> const char *str,
>                                         Error **errp);
>
>  extern const PropertyInfo qdev_prop_chr;
> +extern const PropertyInfo qdev_prop_chr_no_connect;
>  extern const PropertyInfo qdev_prop_macaddr;
>  extern const PropertyInfo qdev_prop_reserved_region;
>  extern const PropertyInfo qdev_prop_multifd_compression;
> @@ -39,6 +40,8 @@ extern const PropertyInfo
> qdev_prop_virtio_gpu_output_list;
>
>  #define DEFINE_PROP_CHR(_n, _s, _f)             \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharFrontend)
> +#define DEFINE_PROP_CHR_NO_CONNECT(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_chr_no_connect, CharFrontend)
>  #define DEFINE_PROP_NETDEV(_n, _s, _f)             \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)
>  #define DEFINE_PROP_DRIVE(_n, _s, _f) \
> --
> 2.48.1
>
>
ok otherwise,
 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--000000000000a2d86806429b0c44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 31, 2=
025 at 7:59=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:v=
sementsov@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">For further vhost-user-b=
lk backend-transfer migration realization we<br>
want to give it (vhost-user-blk) a possibility (and responsibility) to<br>
decide when do connect.<br>
<br>
For incoming migration we&#39;ll need to postpone connect at least until<br=
>
early stage of migrate-incoming command, when we already know all<br>
migration parameters and can decide, are we going to do incoming<br>
backend-transfer (and get chardev fd from incoming stream), or we<br>
finally need to connect.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br>
---<br>
=C2=A0chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 32 ++++++++++++++++++++++++-----<br>
=C2=A0hw/core/qdev-properties-system.c=C2=A0 =C2=A0 | 26 ++++++++++++++++++=
++---<br>
=C2=A0include/chardev/char-fe.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 8 ++++++--<br>
=C2=A0include/hw/qdev-properties-system.h |=C2=A0 3 +++<br>
=C2=A04 files changed, 59 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/chardev/char-fe.c b/chardev/char-fe.c<br>
index c67b4d640f..1132ec0501 100644<br>
--- a/chardev/char-fe.c<br>
+++ b/chardev/char-fe.c<br>
@@ -189,15 +189,26 @@ bool qemu_chr_fe_backend_open(CharFrontend *c)<br>
=C2=A0 =C2=A0 =C2=A0return c-&gt;chr &amp;&amp; c-&gt;chr-&gt;be_open;<br>
=C2=A0}<br>
<br>
-bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp)<br>
+bool qemu_chr_fe_init_ex(CharFrontend *c, Chardev *s, bool connect,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0unsigned int tag =3D 0;<br>
<br>
-=C2=A0 =C2=A0 if (!qemu_chr_connect(s, errp)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (s) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (connect) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!qemu_chr_connect(s, errp)) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* DEFINE_PROP_CHR_NO_CONNECT */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!s-&gt;connect_postponed) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;Chardev %s does not support postponed connect=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;label);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (CHARDEV_IS_MUX(s)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MuxChardev *d =3D MUX_CHARD=
EV(s);<br>
<br>
@@ -210,6 +221,12 @@ bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;fe =3D c;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* connect=3Dfalse comes only from DEFINE=
_PROP_CHR_NO_CONNECT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* through do_set_chr, which provides cha=
rdev ptr.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(connect);<br></blockquote><div><br></di=
v><div>Is this useful to assert?</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0c-&gt;fe_is_open =3D false;<br>
@@ -218,6 +235,11 @@ bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
+bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 return qemu_chr_fe_init_ex(c, s, true, errp);<br>
+}<br>
+<br>
=C2=A0void qemu_chr_fe_deinit(CharFrontend *c, bool del)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0assert(c);<br>
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-sys=
tem.c<br>
index 13cc91680b..00f4b19238 100644<br>
--- a/hw/core/qdev-properties-system.c<br>
+++ b/hw/core/qdev-properties-system.c<br>
@@ -266,8 +266,8 @@ static void get_chr(Object *obj, Visitor *v, const char=
 *name, void *opaque,<br>
=C2=A0 =C2=A0 =C2=A0g_free(p);<br>
=C2=A0}<br>
<br>
-static void set_chr(Object *obj, Visitor *v, const char *name, void *opaqu=
e,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Erro=
r **errp)<br>
+static void do_set_chr(Object *obj, Visitor *v, const char *name, void *op=
aque,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bool connect, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0const Property *prop =3D opaque;<br>
@@ -297,13 +297,25 @@ static void set_chr(Object *obj, Visitor *v, const ch=
ar *name, void *opaque,<br>
=C2=A0 =C2=A0 =C2=A0if (s =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Property &#39;%s.%=
s&#39; can&#39;t find value &#39;%s&#39;&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 objec=
t_get_typename(obj), name, str);<br>
-=C2=A0 =C2=A0 } else if (!qemu_chr_fe_init(fe, s, errp)) {<br>
+=C2=A0 =C2=A0 } else if (!qemu_chr_fe_init_ex(fe, s, connect, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_prepend(errp, &quot;Property &#39;%=
s.%s&#39; can&#39;t take value &#39;%s&#39;: &quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0object_get_typename(obj), name, str);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_free(str);<br>
=C2=A0}<br>
<br>
+static void set_chr(Object *obj, Visitor *v, const char *name, void *opaqu=
e,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Erro=
r **errp)<br>
+{<br>
+=C2=A0 =C2=A0 do_set_chr(obj, v, name, opaque, true, errp);<br>
+}<br>
+<br>
+static void set_chr_no_connect(Object *obj, Visitor *v, const char *name,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 do_set_chr(obj, v, name, opaque, false, errp);<br>
+}<br>
+<br>
=C2=A0static void release_chr(Object *obj, const char *name, void *opaque)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const Property *prop =3D opaque;<br>
@@ -320,6 +332,14 @@ const PropertyInfo qdev_prop_chr =3D {<br>
=C2=A0 =C2=A0 =C2=A0.release =3D release_chr,<br>
=C2=A0};<br>
<br>
+const PropertyInfo qdev_prop_chr_no_connect =3D {<br>
+=C2=A0 =C2=A0 .type=C2=A0 =3D &quot;str&quot;,<br>
+=C2=A0 =C2=A0 .description =3D &quot;ID of a chardev to use as a backend&q=
uot;,<br>
+=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D get_chr,<br>
+=C2=A0 =C2=A0 .set=C2=A0 =C2=A0=3D set_chr_no_connect,<br>
+=C2=A0 =C2=A0 .release =3D release_chr,<br>
+};<br>
+<br>
=C2=A0/* --- mac address --- */<br>
<br>
=C2=A0/*<br>
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h<br>
index 5f8a6df17d..f3df57afa1 100644<br>
--- a/include/chardev/char-fe.h<br>
+++ b/include/chardev/char-fe.h<br>
@@ -25,14 +25,18 @@ struct CharFrontend {<br>
=C2=A0};<br>
<br>
=C2=A0/**<br>
- * qemu_chr_fe_init:<br>
+ * qemu_chr_fe_init(_ex):<br>
=C2=A0 *<br>
=C2=A0 * Initializes the frontend @c for the given Chardev backend @s. Call=
<br>
=C2=A0 * qemu_chr_fe_deinit() to remove the association and release the bac=
kend.<br>
+ * Call qemu_chr_connect(), except for the case when connect=3Dfalse<br>
+ * parameter set for _ex() version.<br>
=C2=A0 *<br>
=C2=A0 * Returns: false on error.<br>
=C2=A0 */<br>
-bool qemu_chr_fe_init(CharFrontend *c, Chardev *be, Error **errp);<br>
+bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp);<br>
+bool qemu_chr_fe_init_ex(CharFrontend *c, Chardev *s, bool connect,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_deinit:<br>
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properti=
es-system.h<br>
index 5c6cc5eae8..a0b14a2f77 100644<br>
--- a/include/hw/qdev-properties-system.h<br>
+++ b/include/hw/qdev-properties-system.h<br>
@@ -7,6 +7,7 @@ bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, c=
onst char *str,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **=
errp);<br>
<br>
=C2=A0extern const PropertyInfo qdev_prop_chr;<br>
+extern const PropertyInfo qdev_prop_chr_no_connect;<br>
=C2=A0extern const PropertyInfo qdev_prop_macaddr;<br>
=C2=A0extern const PropertyInfo qdev_prop_reserved_region;<br>
=C2=A0extern const PropertyInfo qdev_prop_multifd_compression;<br>
@@ -39,6 +40,8 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_lis=
t;<br>
<br>
=C2=A0#define DEFINE_PROP_CHR(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharFrontend)<br=
>
+#define DEFINE_PROP_CHR_NO_CONNECT(_n, _s, _f) \<br>
+=C2=A0 =C2=A0 DEFINE_PROP(_n, _s, _f, qdev_prop_chr_no_connect, CharFronte=
nd)<br>
=C2=A0#define DEFINE_PROP_NETDEV(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)<br>
=C2=A0#define DEFINE_PROP_DRIVE(_n, _s, _f) \<br>
-- <br>
2.48.1<br>
<br></blockquote><div><br></div><div>ok otherwise,</div><div>=C2=A0Reviewed=
-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.c=
om">marcandre.lureau@redhat.com</a>&gt;</div></div></div>

--000000000000a2d86806429b0c44--


