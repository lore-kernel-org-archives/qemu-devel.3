Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BB5D33980
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXfc-00041R-W0; Fri, 05 Dec 2025 10:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXfb-00041D-Et
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXfZ-00046E-Ez
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764948268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wGQ3gSFXtAe+arpdzWG/ZFCjDKYAro2OI+h8YKyav2g=;
 b=ceuQC7ddjPqUpImMaeIbYamqOkbq5kDCSR15BHQQJpjjlo/PRmifl808tjIVW54YjHQVXt
 14bp099cTNzpHYtBBKWnqCjCfkzmhSMVCiWVU8h+3owe5BsZPWUkQsQ/vl33Ol79D0+YKO
 J187VgeX6+5KCxJ3wcuZc2rZvjWXe48=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-i-q78u0KPfemhJqVwiwzAw-1; Fri, 05 Dec 2025 10:24:26 -0500
X-MC-Unique: i-q78u0KPfemhJqVwiwzAw-1
X-Mimecast-MFC-AGG-ID: i-q78u0KPfemhJqVwiwzAw_1764948265
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34374bfbcccso1922612a91.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764948265; x=1765553065; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wGQ3gSFXtAe+arpdzWG/ZFCjDKYAro2OI+h8YKyav2g=;
 b=dplYTkMWro8B0uYP7vrQhlBGhNwg3heGR9/OF4DysY6/Eolplczm0ks9IpxVH0ODAR
 YkVb9zyizwhvU1Cvkopx3N80D/o+PD90kVLD05BEnDDTczmxTcAS6Ri4wR7sGXaFz2nm
 dQ7MdsxcU4iqtHmm+lSnQcLrEqXBacZUOCdApwiJYMNeE3MuMZdHKhzSPS4i7myb1RyE
 pG8ySzGLimql8RpijbNSgRzZoYKYIAVWHBnLkyHa/W+bOIapXBtf1fi5qTg/SxBAoj1K
 AajAfXvQeicQchSpxtzfoQTsTRdeozL/Lpjkb+cejeDD4uCLmi1M2bH+wuIeUFLPdOvu
 6u6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764948265; x=1765553065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGQ3gSFXtAe+arpdzWG/ZFCjDKYAro2OI+h8YKyav2g=;
 b=DtgtC2/xc6Zq0GZvaIoeqGpn0SU91pcCu9MwEk/Bw84E4Phz8fQjJOSUxeuk7HpbFn
 Bq6eEYB8XbRWsdcw9z2vOMG/OPpQadwn3GB1FlWelZDaHWWgmZJ7JGrtDb65JzqgGm2V
 YpNkJRd0KsgcpSLNtKpR7YGbn90o8DngAWOwDuzWe9BRSMDaj4cJnVoMLofQ6ZIg33p1
 1bfFxYgsjKj/HasgNF9Zib+TZLnD3XO95f0UAVvO/l+mCbQirdhYWsjlyAU8ZxoVuRXw
 t4Y8m+5GEfNpkeKnWlGWIMOdWHqKHGBcJHwZxRgHXxy/Haf+Wzt03aGE/4Hbvid8LjFh
 q4eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRUybA3th9GpDlb6IV2RR+Ju4q6KC3Qwid406Qy0DwE0ey9GtZi/9uLMqrqmSsbMVXqp2Zk1SSFg3z@nongnu.org
X-Gm-Message-State: AOJu0YxRTGZgOyc0KzPD9zfYqBWOnZ6Io6aIj8zVDQ4bQBowxs6V3rs2
 a6gD0EUtQ/U9cFy/wXwzaQE2g12dJfQ+AeQE2uXWaw/i98XGl4b/o/L66LFYMxircRcTyu7vzaj
 q81s4kXZrlMqDBGgGl1QHwTdcpkggWj6NwzPiLw6X0k0cjJEftAPyeM+wYa1ZB04hkW/8skXFO5
 hhtlFkrej2lB+6or0hyVvWCy524vsKKzk=
X-Gm-Gg: ASbGncsIhz6Icg0LkhK1m2KgbmlW7Z9dXpA9ljMXigklgMLTMAfSTwVdP+p/71Osm9V
 KL1luwRXlpwB2muCTDV2peTJ9hIt1LbB3hrdxfqiQ0Vk9esOt95jnCzeStZUZO4ZSuUtbr4VSOu
 5qI5dbcVJBst3QKq8E+zPtiu1iVS2Sw9R2PBYXR1IiW2V5LclnnrKRHXnvt3twLOlnPjVBBjTd+
 ihkMz8vwTE/+0fhAPdab/aAZg==
X-Received: by 2002:a17:90b:17ca:b0:341:124f:474f with SMTP id
 98e67ed59e1d1-34947f2b8a9mr6126522a91.32.1764948265414; 
 Fri, 05 Dec 2025 07:24:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRpg9e4hXez788TlRNE+96c2PecEZD4WmvaZztPCsU5od5++DBjY2+FjMhNqnJS1fhvh2lWcCIglVAtlI6HSE=
X-Received: by 2002:a17:90b:17ca:b0:341:124f:474f with SMTP id
 98e67ed59e1d1-34947f2b8a9mr6126494a91.32.1764948264985; Fri, 05 Dec 2025
 07:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
 <20251204154235.149575-9-vsementsov@yandex-team.ru>
In-Reply-To: <20251204154235.149575-9-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Dec 2025 19:24:13 +0400
X-Gm-Features: AWmQ_bnQfU7U8hjEbnC-2KmRzhX5UT8eWgvGZ0S0lfZmcWYtA3w-z4ubcFRlUIw
Message-ID: <CAMxuvawnLfV480yuELn2hvGcq8g3gwo2o_v5VNjdYG0Vpxd1_Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] chardev: introduce .chr_get_pty_name() handler
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 Paul Durrant <paul@xen.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Content-Type: multipart/alternative; boundary="00000000000061bcef0645360a46"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000061bcef0645360a46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Dec 4, 2025 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> Currently we do two wrong things:
>
> 1. Abuse s->filename to get pty_name from it
>
> 2. Violate layering with help of CHARDEV_IS_PTY()
>
> Let's get rid of both, and introduce correct way to get pty name in
> generic code, if available.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/char-pty.c     |  7 +++++++
>  chardev/char.c         | 19 +++++++++++++------
>  hw/char/xen_console.c  |  7 ++++---
>  include/chardev/char.h |  7 +++++--
>  4 files changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index a582aa7bc7..047aade09e 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -387,6 +387,12 @@ static void pty_chr_parse(QemuOpts *opts,
> ChardevBackend *backend, Error **errp)
>      pty->path =3D g_strdup(path);
>  }
>
> +static char *pty_chr_get_pty_name(Chardev *chr)
> +{
> +    PtyChardev *s =3D PTY_CHARDEV(chr);
> +    return g_strdup(s->pty_name);
> +}
> +
>  static void char_pty_class_init(ObjectClass *oc, const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
> @@ -396,6 +402,7 @@ static void char_pty_class_init(ObjectClass *oc, cons=
t
> void *data)
>      cc->chr_write =3D pty_chr_write;
>      cc->chr_update_read_handler =3D pty_chr_update_read_handler;
>      cc->chr_add_watch =3D pty_chr_add_watch;
> +    cc->chr_get_pty_name =3D pty_chr_get_pty_name;
>  }
>
>  static const TypeInfo char_pty_type_info =3D {
> diff --git a/chardev/char.c b/chardev/char.c
> index 44bfed3627..0dc792b88f 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -1090,9 +1090,7 @@ ChardevReturn *qmp_chardev_add(const char *id,
> ChardevBackend *backend,
>      }
>
>      ret =3D g_new0(ChardevReturn, 1);
> -    if (CHARDEV_IS_PTY(chr)) {
> -        ret->pty =3D g_strdup(chr->filename + 4);
> -    }
> +    ret->pty =3D qemu_chr_get_pty_name(chr);
>
>      return ret;
>
> @@ -1101,6 +1099,17 @@ err:
>      return NULL;
>  }
>
> +char *qemu_chr_get_pty_name(Chardev *chr)
> +{
> +    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> +
> +    if (cc->chr_get_pty_name) {
> +        return cc->chr_get_pty_name(chr);
> +    }
> +
> +    return NULL;
> +}
> +
>  ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backen=
d,
>                                    Error **errp)
>  {
> @@ -1192,9 +1201,7 @@ ChardevReturn *qmp_chardev_change(const char *id,
> ChardevBackend *backend,
>      object_unref(OBJECT(chr_new));
>
>      ret =3D g_new0(ChardevReturn, 1);
> -    if (CHARDEV_IS_PTY(chr_new)) {
> -        ret->pty =3D g_strdup(chr_new->filename + 4);
> -    }
> +    ret->pty =3D qemu_chr_get_pty_name(chr_new);
>
>      return ret;
>  }
> diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> index a639fb0b11..7502de46e4 100644
> --- a/hw/char/xen_console.c
> +++ b/hw/char/xen_console.c
> @@ -418,6 +418,7 @@ static void xen_console_realize(XenDevice *xendev,
> Error **errp)
>      XenConsole *con =3D XEN_CONSOLE_DEVICE(xendev);
>      Chardev *cs =3D qemu_chr_fe_get_driver(&con->chr);
>      unsigned int u;
> +    g_autofree char *pty_name =3D NULL;
>
>      if (!cs) {
>          error_setg(errp, "no backing character device");
> @@ -450,9 +451,9 @@ static void xen_console_realize(XenDevice *xendev,
> Error **errp)
>
>      trace_xen_console_realize(con->dev, object_get_typename(OBJECT(cs)))=
;
>
> -    if (CHARDEV_IS_PTY(cs)) {
> -        /* Strip the leading 'pty:' */
> -        xen_device_frontend_printf(xendev, "tty", "%s", cs->filename + 4=
);
> +    pty_name =3D qemu_chr_get_pty_name(cs);
> +    if (pty_name) {
> +        xen_device_frontend_printf(xendev, "tty", "%s", pty_name);
>      }
>
>      /* No normal PV driver initialization for the primary console under
> Xen */
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 23a227dca9..d36e50b99e 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -247,8 +247,6 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
>
>  #define CHARDEV_IS_RINGBUF(chr) \
>      object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)
> -#define CHARDEV_IS_PTY(chr) \
> -    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_PTY)
>
>  struct ChardevClass {
>      ObjectClass parent_class;
> @@ -306,6 +304,9 @@ struct ChardevClass {
>
>      /* handle various events */
>      void (*chr_be_event)(Chardev *s, QEMUChrEvent event);
> +
> +    /* return PTY name if available */
> +    char *(*chr_get_pty_name)(Chardev *s);
>  };
>
>  Chardev *qemu_chardev_new(const char *id, const char *typename,
> @@ -320,4 +321,6 @@ GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint
> ms,
>  void suspend_mux_open(void);
>  void resume_mux_open(void);
>
> +char *qemu_chr_get_pty_name(Chardev *chr);
> +
>  #endif
> --
> 2.48.1
>
>

--00000000000061bcef0645360a46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 4, 20=
25 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vs=
ementsov@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Currently we do two wrong=
 things:<br>
<br>
1. Abuse s-&gt;filename to get pty_name from it<br>
<br>
2. Violate layering with help of CHARDEV_IS_PTY()<br>
<br>
Let&#39;s get rid of both, and introduce correct way to get pty name in<br>
generic code, if available.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br></=
blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a h=
ref=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&=
gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
---<br>
=C2=A0chardev/char-pty.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 7 +++++++<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 19 +++++++++++++---=
---<br>
=C2=A0hw/char/xen_console.c=C2=A0 |=C2=A0 7 ++++---<br>
=C2=A0include/chardev/char.h |=C2=A0 7 +++++--<br>
=C2=A04 files changed, 29 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/chardev/char-pty.c b/chardev/char-pty.c<br>
index a582aa7bc7..047aade09e 100644<br>
--- a/chardev/char-pty.c<br>
+++ b/chardev/char-pty.c<br>
@@ -387,6 +387,12 @@ static void pty_chr_parse(QemuOpts *opts, ChardevBacke=
nd *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0pty-&gt;path =3D g_strdup(path);<br>
=C2=A0}<br>
<br>
+static char *pty_chr_get_pty_name(Chardev *chr)<br>
+{<br>
+=C2=A0 =C2=A0 PtyChardev *s =3D PTY_CHARDEV(chr);<br>
+=C2=A0 =C2=A0 return g_strdup(s-&gt;pty_name);<br>
+}<br>
+<br>
=C2=A0static void char_pty_class_init(ObjectClass *oc, const void *data)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
@@ -396,6 +402,7 @@ static void char_pty_class_init(ObjectClass *oc, const =
void *data)<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_write =3D pty_chr_write;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_update_read_handler =3D pty_chr_update_read_=
handler;<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;chr_add_watch =3D pty_chr_add_watch;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_get_pty_name =3D pty_chr_get_pty_name;<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo char_pty_type_info =3D {<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index 44bfed3627..0dc792b88f 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -1090,9 +1090,7 @@ ChardevReturn *qmp_chardev_add(const char *id, Charde=
vBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D g_new0(ChardevReturn, 1);<br>
-=C2=A0 =C2=A0 if (CHARDEV_IS_PTY(chr)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret-&gt;pty =3D g_strdup(chr-&gt;filename + 4)=
;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret-&gt;pty =3D qemu_chr_get_pty_name(chr);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
<br>
@@ -1101,6 +1099,17 @@ err:<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
+char *qemu_chr_get_pty_name(Chardev *chr)<br>
+{<br>
+=C2=A0 =C2=A0 ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);<br>
+<br>
+=C2=A0 =C2=A0 if (cc-&gt;chr_get_pty_name) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cc-&gt;chr_get_pty_name(chr);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
=C2=A0ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *bac=
kend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
@@ -1192,9 +1201,7 @@ ChardevReturn *qmp_chardev_change(const char *id, Cha=
rdevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0object_unref(OBJECT(chr_new));<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D g_new0(ChardevReturn, 1);<br>
-=C2=A0 =C2=A0 if (CHARDEV_IS_PTY(chr_new)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret-&gt;pty =3D g_strdup(chr_new-&gt;filename =
+ 4);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret-&gt;pty =3D qemu_chr_get_pty_name(chr_new);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c<br>
index a639fb0b11..7502de46e4 100644<br>
--- a/hw/char/xen_console.c<br>
+++ b/hw/char/xen_console.c<br>
@@ -418,6 +418,7 @@ static void xen_console_realize(XenDevice *xendev, Erro=
r **errp)<br>
=C2=A0 =C2=A0 =C2=A0XenConsole *con =3D XEN_CONSOLE_DEVICE(xendev);<br>
=C2=A0 =C2=A0 =C2=A0Chardev *cs =3D qemu_chr_fe_get_driver(&amp;con-&gt;chr=
);<br>
=C2=A0 =C2=A0 =C2=A0unsigned int u;<br>
+=C2=A0 =C2=A0 g_autofree char *pty_name =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!cs) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;no backing charact=
er device&quot;);<br>
@@ -450,9 +451,9 @@ static void xen_console_realize(XenDevice *xendev, Erro=
r **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_xen_console_realize(con-&gt;dev, object_get_typen=
ame(OBJECT(cs)));<br>
<br>
-=C2=A0 =C2=A0 if (CHARDEV_IS_PTY(cs)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Strip the leading &#39;pty:&#39; */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 xen_device_frontend_printf(xendev, &quot;tty&q=
uot;, &quot;%s&quot;, cs-&gt;filename + 4);<br>
+=C2=A0 =C2=A0 pty_name =3D qemu_chr_get_pty_name(cs);<br>
+=C2=A0 =C2=A0 if (pty_name) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 xen_device_frontend_printf(xendev, &quot;tty&q=
uot;, &quot;%s&quot;, pty_name);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* No normal PV driver initialization for the primary c=
onsole under Xen */<br>
diff --git a/include/chardev/char.h b/include/chardev/char.h<br>
index 23a227dca9..d36e50b99e 100644<br>
--- a/include/chardev/char.h<br>
+++ b/include/chardev/char.h<br>
@@ -247,8 +247,6 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)<br>
<br>
=C2=A0#define CHARDEV_IS_RINGBUF(chr) \<br>
=C2=A0 =C2=A0 =C2=A0object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)<=
br>
-#define CHARDEV_IS_PTY(chr) \<br>
-=C2=A0 =C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_PTY)<br>
<br>
=C2=A0struct ChardevClass {<br>
=C2=A0 =C2=A0 =C2=A0ObjectClass parent_class;<br>
@@ -306,6 +304,9 @@ struct ChardevClass {<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* handle various events */<br>
=C2=A0 =C2=A0 =C2=A0void (*chr_be_event)(Chardev *s, QEMUChrEvent event);<b=
r>
+<br>
+=C2=A0 =C2=A0 /* return PTY name if available */<br>
+=C2=A0 =C2=A0 char *(*chr_get_pty_name)(Chardev *s);<br>
=C2=A0};<br>
<br>
=C2=A0Chardev *qemu_chardev_new(const char *id, const char *typename,<br>
@@ -320,4 +321,6 @@ GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms=
,<br>
=C2=A0void suspend_mux_open(void);<br>
=C2=A0void resume_mux_open(void);<br>
<br>
+char *qemu_chr_get_pty_name(Chardev *chr);<br>
+<br>
=C2=A0#endif<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--00000000000061bcef0645360a46--


