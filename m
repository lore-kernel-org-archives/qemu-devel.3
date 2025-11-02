Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B79CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 11:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFWPb-0005F0-0b; Sun, 02 Nov 2025 06:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vFWPZ-0005EL-4H
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:38:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vFWPT-0002c6-RJ
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762083467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3c2aX98eiQP8stFgEHPfj2czOsSyCT7Fww5up+jd+ZQ=;
 b=Vh4Fc+PWqU6kP2fcHzhMN7/c9eQt1s6cvYswUTtPf11SI5EfLZDDgCyoBXg8hqZlwsfGia
 BtVlqKbp0IwDr+ED+XhfzfKgv4z20t9tAlIdXD+P2xL2X4poe8kL9L5yQSgu6GSw+ryZqG
 gfgTGqDfD6sTY6HsEF+Bkpmhd8qOgaM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-_2tznDOSMVaM_JCZf-brmg-1; Sun, 02 Nov 2025 06:37:31 -0500
X-MC-Unique: _2tznDOSMVaM_JCZf-brmg-1
X-Mimecast-MFC-AGG-ID: _2tznDOSMVaM_JCZf-brmg_1762083445
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2956a694b47so8772065ad.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 03:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762083445; x=1762688245; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3c2aX98eiQP8stFgEHPfj2czOsSyCT7Fww5up+jd+ZQ=;
 b=tgEVj5Iu6J/8BrYJQLwVH0/1eLJmE5biHHrM5n52NKyeBu9msqDH9QoCKk8iKC0+9r
 xkslK+GSAX1XnqCn0Z8ZiZUS2RWE8pTZ7vLleYoxRbCa1Xh98K+GlgjLKb+HUzbkIjzL
 nk1pnXFOR+tVvAYjwdyCW/EgPiTcN+h1aVY0ncGrk2Uz6HXXPbG0nYX1mFkecICNypYG
 H90X6RsR+wJ8G3qt4da/0CPTseDvzQq1oq5pCDfOIzfKP9KJIrbl7/UqNmJEFkskweU7
 Sawb/uSfgXCe4VDBwYde4JN8wl83rxXBvDhZjtFdNURf9YNfiDhD3MyBZWlEAiSRRSXo
 cayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762083445; x=1762688245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3c2aX98eiQP8stFgEHPfj2czOsSyCT7Fww5up+jd+ZQ=;
 b=s6tn9pyUDH24Yb6qPg7a9nketAZrmbyGVeLyXcSS+PPzQYU4tkeOnij/aI9KM5PW2v
 6sdpLivFZl3snWust5BZZyHCUzUyh6I3pf/2rnzXlS/wk/EEUweGKgslVvn2fpPZT0Gt
 XWTtFoOvS5QmRSe8syH2ZwEFAvoAQlIbMDNgFflhjaBlilvkS1QHKFx+fjCgD8uH315G
 kgj1X4TIU+17244h7GwSyaeqyN78kzYoToovXouGV77OXOjsfgoiLKEOoi+F5jwQs/9O
 nPAHkkotdKAkHSnXlFczvUlug6vGoIjjtAvFwCNGaQIi6+Qcn4SFrTc7kpSwK7eF8aO0
 mgDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVljk8gUfTiojBQsLGHy8dak8L0lNmHXz1dWd+wol4PCA7KhDhH/OOiRNfbJ1PB2lXe6NyxYbs+kY8t@nongnu.org
X-Gm-Message-State: AOJu0YxaxdvpS5f2ErLZX2GUdl51HDA7WiGt/6mrhIcd5HL7ddjYI4xu
 Fc6TIX7EIYmK4WSMEWlTMCmSPp32r6Ctbd+JNXOpI0sDlQMvlNANZxJv/EexK3FsYsQl36yh+LN
 dBZpo0xt1nkass7SWW5NHjN5MpGgwwJAJ05LeiXITKaRBawz0/gXsVQ+b4z43rVDulbJiRSxyks
 bFEdqHqED5LEO0HMw2PMh6dnishPlcEZw=
X-Gm-Gg: ASbGncsXPgRvEs48X7H7pcLLpauV/Wzp8Ds9Wb6l4qLtAEv5Uo0qdUT60ceh3e5qyhJ
 4uNF+xK3S6DA9IMiUKMbH+FE3k0AKRKoTgUdVKv9XY07dflM+OMklFFOmWeolIIeBk6wnny2ZdJ
 i11ScOOJhTtkcjgxSzjswH7PAuIAGW98va/ZFzpRohzsKEo49dBGy/J4Pz6dKE5Q==
X-Received: by 2002:a17:903:234b:b0:295:3e41:5aa1 with SMTP id
 d9443c01a7336-2953e415cc4mr92306175ad.21.1762083445487; 
 Sun, 02 Nov 2025 03:37:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrxNXw/KsjWf1f987IsVLt6DvI7WIgF3kBpYdG1CrpUtHcugulL6cm9kc2kbHWYR0qCdlH2E7usqeXwrTvfkw=
X-Received: by 2002:a17:903:234b:b0:295:3e41:5aa1 with SMTP id
 d9443c01a7336-2953e415cc4mr92305995ad.21.1762083445103; Sun, 02 Nov 2025
 03:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20251031155914.189112-1-vsementsov@yandex-team.ru>
 <20251031155914.189112-6-vsementsov@yandex-team.ru>
In-Reply-To: <20251031155914.189112-6-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 2 Nov 2025 15:37:12 +0400
X-Gm-Features: AWmQ_bk19VATMXCFnsLsulu1xJVtD8WCU1un9VkSNZHh-6IdVNcrW0d0fAHA_rs
Message-ID: <CAMxuvaybTyz97Pp1QeTQP1f7D4Gvf-yNRZRCM7zbbEPqgSUYkw@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] chardev/char: introduce .init() + .connect()
 initialization interface
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: multipart/alternative; boundary="000000000000cf73d406429b0512"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

--000000000000cf73d406429b0512
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 31, 2025 at 7:59=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> We'll need a possibility to postpone connect step to later point in
> time to implement backend-transfer migration feature for vhost-user-blk
> in further commits. Let's start with new char interface for backends.
>
> .init() takes QAPI parameters and should parse them, called early
>
> .connect() should actually establish a connection, and postponed to
> the point of attaching to frontend. Called at later point, either
> at time of attaching frontend, or from qemu_chr_wait_connected().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-fe.c      |  4 ++++
>  chardev/char.c         | 39 +++++++++++++++++++++++++++++++++++++--
>  include/chardev/char.h | 30 +++++++++++++++++++++++++++++-
>  3 files changed, 70 insertions(+), 3 deletions(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index 34b83fc1c4..c67b4d640f 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -193,6 +193,10 @@ bool qemu_chr_fe_init(CharFrontend *c, Chardev *s,
> Error **errp)
>  {
>      unsigned int tag =3D 0;
>
> +    if (!qemu_chr_connect(s, errp)) {
> +        return false;
> +    }
>

this should be after "if (s)" condition.

It is moved in a later patch, but better do it now.


> +
>      if (s) {
>          if (CHARDEV_IS_MUX(s)) {
>              MuxChardev *d =3D MUX_CHARDEV(s);
> diff --git a/chardev/char.c b/chardev/char.c
> index 7a029b0eb9..33eba0cdc0 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -33,6 +33,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-char.h"
>  #include "qapi/qmp/qerror.h"
> +#include "qom/object.h"
>  #include "system/replay.h"
>  #include "qemu/help_option.h"
>  #include "qemu/module.h"
> @@ -338,10 +339,29 @@ static bool qemu_chr_is_busy(Chardev *s)
>      }
>  }
>
> +bool qemu_chr_connect(Chardev *chr, Error **errp)
> +{
> +    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> +
> +    if (chr->connect_postponed) {
> +        assert(cc->connect);
> +        chr->connect_postponed =3D false;
> +        if (!cc->connect(chr, errp)) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  int qemu_chr_wait_connected(Chardev *chr, Error **errp)
>  {
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
>
> +    if (!qemu_chr_connect(chr, errp)) {
> +        return -1;
> +    }
> +
>      if (cc->chr_wait_connected) {
>          return cc->chr_wait_connected(chr, errp);
>      }
> @@ -1030,6 +1050,7 @@ static Chardev *chardev_new(const char *id, const
> char *typename,
>  {
>      Object *obj;
>      Chardev *chr =3D NULL;
> +    ChardevClass *cc;
>
>      assert(g_str_has_prefix(typename, "chardev-"));
>      assert(id);
> @@ -1044,8 +1065,22 @@ static Chardev *chardev_new(const char *id, const
> char *typename,
>          goto fail;
>      }
>
> -    if (!qemu_char_open(chr, backend, typename + 8, errp)) {
> -        goto fail;
> +    cc =3D CHARDEV_GET_CLASS(chr);
> +
> +    if (cc->init) {
> +        assert(!cc->open);
> +        assert(cc->connect);
> +
> +        if (!cc->init(chr, backend, errp)) {
> +            goto fail;
> +        }
> +        assert(chr->filename);
> +
> +        chr->connect_postponed =3D true;
> +    } else {
> +        if (!qemu_char_open(chr, backend, typename + 8, errp)) {
> +            goto fail;
> +        }
>      }
>
>      return chr;
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index b65e9981c1..24c449b07b 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -63,6 +63,7 @@ struct Chardev {
>      CharFrontend *fe;
>      char *label;
>      char *filename;
> +    bool connect_postponed;
>      int logfd;
>      int be_open;
>      /* used to coordinate the chardev-change special-case: */
> @@ -225,6 +226,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label,
> const char *filename,
>                                  bool permit_mux_mon);
>  int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool
> write_all);
>  #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true=
)
> +bool qemu_chr_connect(Chardev *chr, Error **errp);
>  int qemu_chr_wait_connected(Chardev *chr, Error **errp);
>
>  #define TYPE_CHARDEV "chardev"
> @@ -259,7 +261,33 @@ struct ChardevClass {
>      /* parse command line options and populate QAPI @backend */
>      void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
>
> -    /* called after construction, open/starts the backend */
> +    /*
> +     * Called after construction, create the backend, mutually exclusive
> +     * with @open, and should be followed by @connect().
> +     * Must set the Chardev's chr->filename on success.
> +     */
> +    bool (*init)(Chardev *chr, ChardevBackend *backend,
> +                 Error **errp);
> +
> +    /*
> +     * Called after @init(), starts the backend, mutually exclusive
> +     * with @open. Should care to send CHR_EVENT_OPENED when connected
> +     * (this may happen asynchronously after .connect() call alredy
> +     * returned).
> +     */
> +    bool (*connect)(Chardev *chr, Error **errp);
> +
> +    /*
> +     * Called after construction, an alternative to @init + @connect
> +     * and should do the work for both: create and start the backend.
> +     * Mutually exclusive with @init and @connect.
> +     *
> +     * May not set the Chardev's chr->filename (generic code will care),
> +     * and may not send CHR_EVENT_OPENED when connected (@be_opened
> +     * should not be touched in this case, to signal the generic code
> +     * to care about CHR_EVENT_OPENED). If the backend cares about
> +     * CHR_EVENT_OPENED, it should set @be_opened to false.
> +     */
>      void (*open)(Chardev *chr, ChardevBackend *backend,
>                   bool *be_opened, Error **errp);
>
> --
> 2.48.1
>
>

--000000000000cf73d406429b0512
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 31, 2=
025 at 7:59=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:v=
sementsov@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">We&#39;ll need a possibi=
lity to postpone connect step to later point in<br>
time to implement backend-transfer migration feature for vhost-user-blk<br>
in further commits. Let&#39;s start with new char interface for backends.<b=
r>
<br>
.init() takes QAPI parameters and should parse them, called early<br>
<br>
.connect() should actually establish a connection, and postponed to<br>
the point of attaching to frontend. Called at later point, either<br>
at time of attaching frontend, or from qemu_chr_wait_connected().<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br>
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++++<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 39 ++++++++++++++++=
+++++++++++++++++++++--<br>
=C2=A0include/chardev/char.h | 30 +++++++++++++++++++++++++++++-<br>
=C2=A03 files changed, 70 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/chardev/char-fe.c b/chardev/char-fe.c<br>
index 34b83fc1c4..c67b4d640f 100644<br>
--- a/chardev/char-fe.c<br>
+++ b/chardev/char-fe.c<br>
@@ -193,6 +193,10 @@ bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Err=
or **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0unsigned int tag =3D 0;<br>
<br>
+=C2=A0 =C2=A0 if (!qemu_chr_connect(s, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>this should be after &=
quot;if (s)&quot; condition.</div><div><br></div><div>It is moved in a late=
r patch, but better do it now.</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0if (s) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (CHARDEV_IS_MUX(s)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MuxChardev *d =3D MUX_CHARD=
EV(s);<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index 7a029b0eb9..33eba0cdc0 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -33,6 +33,7 @@<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-commands-char.h&quot;<br>
=C2=A0#include &quot;qapi/qmp/qerror.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
=C2=A0#include &quot;system/replay.h&quot;<br>
=C2=A0#include &quot;qemu/help_option.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
@@ -338,10 +339,29 @@ static bool qemu_chr_is_busy(Chardev *s)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+bool qemu_chr_connect(Chardev *chr, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);<br>
+<br>
+=C2=A0 =C2=A0 if (chr-&gt;connect_postponed) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(cc-&gt;connect);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;connect_postponed =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cc-&gt;connect(chr, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
=C2=A0int qemu_chr_wait_connected(Chardev *chr, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);<br>
<br>
+=C2=A0 =C2=A0 if (!qemu_chr_connect(chr, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (cc-&gt;chr_wait_connected) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return cc-&gt;chr_wait_connected(chr, err=
p);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1030,6 +1050,7 @@ static Chardev *chardev_new(const char *id, const cha=
r *typename,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Object *obj;<br>
=C2=A0 =C2=A0 =C2=A0Chardev *chr =3D NULL;<br>
+=C2=A0 =C2=A0 ChardevClass *cc;<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(g_str_has_prefix(typename, &quot;chardev-&quot;)=
);<br>
=C2=A0 =C2=A0 =C2=A0assert(id);<br>
@@ -1044,8 +1065,22 @@ static Chardev *chardev_new(const char *id, const ch=
ar *typename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!qemu_char_open(chr, backend, typename + 8, errp)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
+=C2=A0 =C2=A0 cc =3D CHARDEV_GET_CLASS(chr);<br>
+<br>
+=C2=A0 =C2=A0 if (cc-&gt;init) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!cc-&gt;open);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(cc-&gt;connect);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cc-&gt;init(chr, backend, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(chr-&gt;filename);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;connect_postponed =3D true;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!qemu_char_open(chr, backend, typename + 8=
, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return chr;<br>
diff --git a/include/chardev/char.h b/include/chardev/char.h<br>
index b65e9981c1..24c449b07b 100644<br>
--- a/include/chardev/char.h<br>
+++ b/include/chardev/char.h<br>
@@ -63,6 +63,7 @@ struct Chardev {<br>
=C2=A0 =C2=A0 =C2=A0CharFrontend *fe;<br>
=C2=A0 =C2=A0 =C2=A0char *label;<br>
=C2=A0 =C2=A0 =C2=A0char *filename;<br>
+=C2=A0 =C2=A0 bool connect_postponed;<br>
=C2=A0 =C2=A0 =C2=A0int logfd;<br>
=C2=A0 =C2=A0 =C2=A0int be_open;<br>
=C2=A0 =C2=A0 =C2=A0/* used to coordinate the chardev-change special-case: =
*/<br>
@@ -225,6 +226,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, cons=
t char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool permit_mux_mon);<br>
=C2=A0int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool writ=
e_all);<br>
=C2=A0#define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, t=
rue)<br>
+bool qemu_chr_connect(Chardev *chr, Error **errp);<br>
=C2=A0int qemu_chr_wait_connected(Chardev *chr, Error **errp);<br>
<br>
=C2=A0#define TYPE_CHARDEV &quot;chardev&quot;<br>
@@ -259,7 +261,33 @@ struct ChardevClass {<br>
=C2=A0 =C2=A0 =C2=A0/* parse command line options and populate QAPI @backen=
d */<br>
=C2=A0 =C2=A0 =C2=A0void (*parse)(QemuOpts *opts, ChardevBackend *backend, =
Error **errp);<br>
<br>
-=C2=A0 =C2=A0 /* called after construction, open/starts the backend */<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Called after construction, create the backend, mutua=
lly exclusive<br>
+=C2=A0 =C2=A0 =C2=A0* with @open, and should be followed by @connect().<br=
>
+=C2=A0 =C2=A0 =C2=A0* Must set the Chardev&#39;s chr-&gt;filename on succe=
ss.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 bool (*init)(Chardev *chr, ChardevBackend *backend,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp=
);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Called after @init(), starts the backend, mutually e=
xclusive<br>
+=C2=A0 =C2=A0 =C2=A0* with @open. Should care to send CHR_EVENT_OPENED whe=
n connected<br>
+=C2=A0 =C2=A0 =C2=A0* (this may happen asynchronously after .connect() cal=
l alredy<br>
+=C2=A0 =C2=A0 =C2=A0* returned).<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 bool (*connect)(Chardev *chr, Error **errp);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Called after construction, an alternative to @init +=
 @connect<br>
+=C2=A0 =C2=A0 =C2=A0* and should do the work for both: create and start th=
e backend.<br>
+=C2=A0 =C2=A0 =C2=A0* Mutually exclusive with @init and @connect.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* May not set the Chardev&#39;s chr-&gt;filename (gene=
ric code will care),<br>
+=C2=A0 =C2=A0 =C2=A0* and may not send CHR_EVENT_OPENED when connected (@b=
e_opened<br>
+=C2=A0 =C2=A0 =C2=A0* should not be touched in this case, to signal the ge=
neric code<br>
+=C2=A0 =C2=A0 =C2=A0* to care about CHR_EVENT_OPENED). If the backend care=
s about<br>
+=C2=A0 =C2=A0 =C2=A0* CHR_EVENT_OPENED, it should set @be_opened to false.=
<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0void (*open)(Chardev *chr, ChardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_ope=
ned, Error **errp);<br>
<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--000000000000cf73d406429b0512--


