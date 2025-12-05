Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C0CD32D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXoN-0007Be-HU; Fri, 05 Dec 2025 10:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXoM-0007BM-3L
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:33:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXoJ-0007JQ-KK
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764948810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FW6Jn0pX9TuCfhKKrhOW9M4PtMGwHHX8M6KhdV+3Dwg=;
 b=XE9J89EWbIq4ZNINVcta/mofGj1/LgxzbWE2mQ4DxERc8HeqK7uqiyGp6lXEy1BsmKkXk0
 tn06g/A5vIEaZuYdhrs/nbe4ZA1i/jYUmD8GWkx9uwuqs6VWdSOzwsqG1rNqnrsJ6gsqWf
 yJIraw+UK06oHXtX5dIjOaRnFS+xvvk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-RgA9ImfjOQS2sMtHByUB2Q-1; Fri, 05 Dec 2025 10:33:28 -0500
X-MC-Unique: RgA9ImfjOQS2sMtHByUB2Q-1
X-Mimecast-MFC-AGG-ID: RgA9ImfjOQS2sMtHByUB2Q_1764948807
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3436e9e3569so3804919a91.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764948806; x=1765553606; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FW6Jn0pX9TuCfhKKrhOW9M4PtMGwHHX8M6KhdV+3Dwg=;
 b=pYrqvquFaAfOmFb58K1ruYXX+orVwhYoL5Brb+lAkK+qeufiazxJYUF9kC664kAyru
 ayzLWQ2gnWAPrQKpX54/UhMDVaNTbWMBoWCot/uUSt76Siv6QIn9Z4kfGamBRnz/bSuq
 smhaoidST/Ocxr9KpnUNOpFxSiPPT0jo+1M96yCpH09PUUvHAhv85MrxF1INUOuSYLPn
 IyfqdYRwLgZA/ABcHKkbXfaUxpWwY0Sgq+if6jlW1drVywn5HETwzddfj7xZ7eM5E76u
 gIwV5bJpNIVU4RMFtXvuth2x2cLt4RNGnbyrKP4gIpdx60UtqhprdCkN88okjBytmfn+
 EIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764948806; x=1765553606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FW6Jn0pX9TuCfhKKrhOW9M4PtMGwHHX8M6KhdV+3Dwg=;
 b=sdCqBDNmVyFvXpx2bv8wSDdDRKIwODeIzyOB18SoXZO4kTMiYCI/mCUYCzHmEXYRW6
 eS6npcxAwr8xLcdoAB9MoyaaRpnvTWKDGWf7HZvnSV4g8cI3dO7NCIYFFPwWs+uhHmJn
 pv7f9ys0AwM+BSO5NNB6cCyD06DvuUQTdQLOjANU8hpBEJZheoLP+5ewAGkOypImjvzM
 EIgpxc6KbZBRtgvrJEWVZSVCv72qQRURMuhWJPlvMBCKWhVSb3tKLhmoN3ghDIxX62Jx
 CJl0ckkV25muqgCksvlmCLmmdSZFOFCxUzUGMo0llV72Cg3u8JFmT0wSI+XUZJUkMNHN
 oytg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoQPlTMD9ICDSmhx0GhxC6qKJk+x2CxL4ThgxWmVjt+Nr6hQzSnyF7wx8vZu0eITNa9ARbgG8hnuDr@nongnu.org
X-Gm-Message-State: AOJu0Yz5iSv1CiXRugoa4qv3P5ZB2/SiFJFudRJ8fhLxeaCxMnR5JYay
 RZXQ4PpdnL/omWGLktF8i6ZNaH8etRG1kKFlugdc1N5qMtrAlmtEWxQK6WCNKH6AUhwop8K4MI0
 ys5pb9lXM11L22JFyABkIUhzs+zjICnsbl32TEXn0Szbx0h39EFnbb7mIQLJna6DE34v+NOQ7tI
 KZB5ey6gO7BeGi9AiC5ombM7EC9PWcya8=
X-Gm-Gg: ASbGncucGkjTCXVRvIcIYgHeZptcdG2UvZeJ8h6ikgwS+hQpQmboqvwNTb66D1qArLT
 Yd7qaBe//8LTi3RveAWUFyu7vXruXopUBbhDoTPN/mOCofnpsJ7tIJu2OiKFiW5IinwE8topNGd
 c+LSjvx3kLiXGOljVTCT1aPCaEYZap42fLGuzgxtRCo9cTb4nkvDpWbCFaohA8k/b4HjTRHuxi7
 zoliYCIZZK+bYH8KoDN0hWkNw==
X-Received: by 2002:a17:90b:3a85:b0:343:66e2:5f9b with SMTP id
 98e67ed59e1d1-349126b9a04mr12924795a91.24.1764948806255; 
 Fri, 05 Dec 2025 07:33:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpjcc6BHV2f3DzWIOhxu9HKLt6wL8azb/wek8DaOo91AtMojLbwvqo9xaKmh+LhSfn4OEFDV1ZYUSus20remY=
X-Received: by 2002:a17:90b:3a85:b0:343:66e2:5f9b with SMTP id
 98e67ed59e1d1-349126b9a04mr12924776a91.24.1764948805846; Fri, 05 Dec 2025
 07:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
 <20251204154235.149575-10-vsementsov@yandex-team.ru>
In-Reply-To: <20251204154235.149575-10-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Dec 2025 19:33:13 +0400
X-Gm-Features: AWmQ_bkaJyMuLBWWS5hsZjXz_a9ceJr0eSyACtiK-G-OUePu5bDRIZuy4olP84U
Message-ID: <CAMxuvaw5MfXrSiqY3taObYn9cTAg6teJ5RYAjj+c6i3qip3Euw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] chardev: rework filename handling
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
Content-Type: multipart/alternative; boundary="0000000000009e9a520645362abc"
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

--0000000000009e9a520645362abc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Dec 4, 2025 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> We have the following flaws with it:
>
> 1. Layring violation by modifying generic state directly in backends
>
>
Well, it's a parent field that can be modified, I am not sure it qualifies
as such


> 2. Tricky generic logic: we should check, did backend set the
> generic state field, and fill it when not.
>
> Let's fix them all by making filename a private field with getter
> and setter. And move the "default logic" into getter.
>
>
The tradeoff is that your implementation will do more allocation/free, but
I don't think we care much here.

I am not sure we gain much overall.


> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

---
>  chardev/char-pty.c     |  4 +++-
>  chardev/char-socket.c  | 17 ++++++++---------
>  chardev/char.c         |  8 ++------
>  hw/misc/ivshmem-pci.c  |  4 ++--
>  include/chardev/char.h | 21 ++++++++++++++++++++-
>  5 files changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 047aade09e..f4294679be 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -336,6 +336,7 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>      int master_fd, slave_fd;
>      char *name;
>      char *path =3D backend->u.pty.data->path;
> +    g_autofree char *filename =3D NULL;
>
>      s =3D PTY_CHARDEV(chr);
>
> @@ -351,7 +352,8 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>          return false;
>      }
>
> -    chr->filename =3D g_strdup_printf("pty:%s", s->pty_name);
> +    filename =3D g_strdup_printf("pty:%s", s->pty_name);
> +    qemu_chr_set_filename(chr, filename);
>      qemu_printf("char device redirected to %s (label %s)\n",
>                  s->pty_name, chr->label);
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 31c9acd164..9387760009 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -384,8 +384,7 @@ static void tcp_chr_free_connection(Chardev *chr)
>      s->sioc =3D NULL;
>      object_unref(OBJECT(s->ioc));
>      s->ioc =3D NULL;
> -    g_free(chr->filename);
> -    chr->filename =3D NULL;
> +    qemu_chr_set_filename(chr, NULL);
>      tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
>  }
>
> @@ -443,11 +442,11 @@ static void
> update_disconnected_filename(SocketChardev *s)
>  {
>      Chardev *chr =3D CHARDEV(s);
>
> -    g_free(chr->filename);
>      if (s->addr) {
> -        chr->filename =3D qemu_chr_socket_address(s, "disconnected:");
> +        g_autofree char *filename =3D qemu_chr_socket_address(s,
> "disconnected:");
> +        qemu_chr_set_filename(chr, filename);
>      } else {
> -        chr->filename =3D g_strdup("disconnected:socket");
> +        qemu_chr_set_filename(chr, "disconnected:socket");
>      }
>  }
>
> @@ -638,9 +637,9 @@ static void tcp_chr_connect(void *opaque)
>  {
>      Chardev *chr =3D CHARDEV(opaque);
>      SocketChardev *s =3D SOCKET_CHARDEV(opaque);
> +    g_autofree char *filename =3D qemu_chr_compute_filename(s);
>
> -    g_free(chr->filename);
> -    chr->filename =3D qemu_chr_compute_filename(s);
> +    qemu_chr_set_filename(chr, filename);
>
>      tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTED);
>      update_ioc_handlers(s);
> @@ -1000,8 +999,8 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>      QIOChannelSocket *sioc;
> -    info_report("QEMU waiting for connection on: %s",
> -                chr->filename);
> +    g_autofree char *filename =3D qemu_chr_get_filename(chr);
> +    info_report("QEMU waiting for connection on: %s", filename);
>      tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
>      sioc =3D qio_net_listener_wait_client(s->listener);
>      tcp_chr_set_client_ioc_name(chr, sioc);
> diff --git a/chardev/char.c b/chardev/char.c
> index 0dc792b88f..bdd907f015 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -309,7 +309,7 @@ static void char_finalize(Object *obj)
>      if (chr->fe) {
>          chr->fe->chr =3D NULL;
>      }
> -    g_free(chr->filename);
> +    qemu_chr_set_filename(chr, NULL);
>      g_free(chr->label);
>      if (chr->logfd !=3D -1) {
>          close(chr->logfd);
> @@ -796,7 +796,7 @@ static int qmp_query_chardev_foreach(Object *obj, voi=
d
> *data)
>      ChardevInfo *value =3D g_malloc0(sizeof(*value));
>
>      value->label =3D g_strdup(chr->label);
> -    value->filename =3D g_strdup(chr->filename);
> +    value->filename =3D qemu_chr_get_filename(chr);
>      value->frontend_open =3D chr->fe && chr->fe->fe_is_open;
>
>      QAPI_LIST_PREPEND(*list, value);
> @@ -1025,10 +1025,6 @@ static Chardev *chardev_new(const char *id, const
> char *typename,
>          return NULL;
>      }
>
> -    if (!chr->filename) {
> -        chr->filename =3D g_strdup(typename + 8);
> -    }
> -
>      return chr;
>  }
>
> diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
> index 636d0b83de..2c7b987241 100644
> --- a/hw/misc/ivshmem-pci.c
> +++ b/hw/misc/ivshmem-pci.c
> @@ -873,10 +873,10 @@ static void ivshmem_common_realize(PCIDevice *dev,
> Error **errp)
>          host_memory_backend_set_mapped(s->hostmem, true);
>      } else {
>          Chardev *chr =3D qemu_chr_fe_get_driver(&s->server_chr);
> +        char *filename =3D qemu_chr_get_filename(chr);
>

Should be auto-free, since returned allocated


>          assert(chr);
>
> -        IVSHMEM_DPRINTF("using shared memory server (socket =3D %s)\n",
> -                        chr->filename);
> +        IVSHMEM_DPRINTF("using shared memory server (socket =3D %s)\n",
> filename);
>
>          /* we allocate enough space for 16 peers and grow as needed */
>          resize_peers(s, 16);
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index d36e50b99e..ffeb4a4e3b 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -62,7 +62,7 @@ struct Chardev {
>      QemuMutex chr_write_lock;
>      CharFrontend *fe;
>      char *label;
> -    char *filename;
> +    char *_filename;
>

Why rename the field? we don't have a  convention to have "private" fields
with _ prefix afaik.


>      int logfd;
>      int be_open;
>      /* used to coordinate the chardev-change special-case: */
> @@ -72,6 +72,25 @@ struct Chardev {
>      DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
>  };
>
> +static inline char *qemu_chr_get_filename(Chardev *chr)
>

Let's avoid code in headers.


> +{
> +    const char *typename;
> +
> +    if (chr->_filename) {
> +        return g_strdup(chr->_filename);
> +    }
> +
> +    typename =3D object_get_typename(OBJECT(chr));
> +    assert(g_str_has_prefix(typename, "chardev-"));
> +    return g_strdup(typename + 8);
> +}
> +
> +static inline void qemu_chr_set_filename(Chardev *chr, const char
> *filename)
> +{
> +    g_free(chr->_filename);
> +    chr->_filename =3D g_strdup(filename);
> +}
> +
>  /**
>   * qemu_chr_new_from_opts:
>   * @opts: see qemu-config.c for a list of valid options
> --
> 2.48.1
>
>

--0000000000009e9a520645362abc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 4, 20=
25 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vs=
ementsov@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">We have the following fla=
ws with it:<br>
<br>
1. Layring violation by modifying generic state directly in backends<br>
<br></blockquote><div><br></div><div>Well, it&#39;s a parent field that can=
 be modified, I am not sure it qualifies as such</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
2. Tricky generic logic: we should check, did backend set the<br>
generic state field, and fill it when not.<br>
<br>
Let&#39;s fix them all by making filename a private field with getter<br>
and setter. And move the &quot;default logic&quot; into getter.<br>
<br></blockquote><div><div><br></div><div>The tradeoff is that your impleme=
ntation will do more allocation/free, but I don&#39;t think we care much he=
re.</div><div><br></div><div>I am not sure we gain much overall.</div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;=C2=A0=
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0chardev/char-pty.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +++-<br>
=C2=A0chardev/char-socket.c=C2=A0 | 17 ++++++++---------<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++------<br=
>
=C2=A0hw/misc/ivshmem-pci.c=C2=A0 |=C2=A0 4 ++--<br>
=C2=A0include/chardev/char.h | 21 ++++++++++++++++++++-<br>
=C2=A05 files changed, 35 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/chardev/char-pty.c b/chardev/char-pty.c<br>
index 047aade09e..f4294679be 100644<br>
--- a/chardev/char-pty.c<br>
+++ b/chardev/char-pty.c<br>
@@ -336,6 +336,7 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend *=
backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0int master_fd, slave_fd;<br>
=C2=A0 =C2=A0 =C2=A0char *name;<br>
=C2=A0 =C2=A0 =C2=A0char *path =3D backend-&gt;u.pty.data-&gt;path;<br>
+=C2=A0 =C2=A0 g_autofree char *filename =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D PTY_CHARDEV(chr);<br>
<br>
@@ -351,7 +352,8 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend *=
backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 chr-&gt;filename =3D g_strdup_printf(&quot;pty:%s&quot;, s-&=
gt;pty_name);<br>
+=C2=A0 =C2=A0 filename =3D g_strdup_printf(&quot;pty:%s&quot;, s-&gt;pty_n=
ame);<br>
+=C2=A0 =C2=A0 qemu_chr_set_filename(chr, filename);<br>
=C2=A0 =C2=A0 =C2=A0qemu_printf(&quot;char device redirected to %s (label %=
s)\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;pty_nam=
e, chr-&gt;label);<br>
<br>
diff --git a/chardev/char-socket.c b/chardev/char-socket.c<br>
index 31c9acd164..9387760009 100644<br>
--- a/chardev/char-socket.c<br>
+++ b/chardev/char-socket.c<br>
@@ -384,8 +384,7 @@ static void tcp_chr_free_connection(Chardev *chr)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;sioc =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0object_unref(OBJECT(s-&gt;ioc));<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;ioc =3D NULL;<br>
-=C2=A0 =C2=A0 g_free(chr-&gt;filename);<br>
-=C2=A0 =C2=A0 chr-&gt;filename =3D NULL;<br>
+=C2=A0 =C2=A0 qemu_chr_set_filename(chr, NULL);<br>
=C2=A0 =C2=A0 =C2=A0tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED)=
;<br>
=C2=A0}<br>
<br>
@@ -443,11 +442,11 @@ static void update_disconnected_filename(SocketCharde=
v *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Chardev *chr =3D CHARDEV(s);<br>
<br>
-=C2=A0 =C2=A0 g_free(chr-&gt;filename);<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;addr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;filename =3D qemu_chr_socket_address(s=
, &quot;disconnected:&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *filename =3D qemu_chr_socket_=
address(s, &quot;disconnected:&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_set_filename(chr, filename);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;filename =3D g_strdup(&quot;disconnect=
ed:socket&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_set_filename(chr, &quot;disconnected:=
socket&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -638,9 +637,9 @@ static void tcp_chr_connect(void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Chardev *chr =3D CHARDEV(opaque);<br>
=C2=A0 =C2=A0 =C2=A0SocketChardev *s =3D SOCKET_CHARDEV(opaque);<br>
+=C2=A0 =C2=A0 g_autofree char *filename =3D qemu_chr_compute_filename(s);<=
br>
<br>
-=C2=A0 =C2=A0 g_free(chr-&gt;filename);<br>
-=C2=A0 =C2=A0 chr-&gt;filename =3D qemu_chr_compute_filename(s);<br>
+=C2=A0 =C2=A0 qemu_chr_set_filename(chr, filename);<br>
<br>
=C2=A0 =C2=A0 =C2=A0tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTED);<b=
r>
=C2=A0 =C2=A0 =C2=A0update_ioc_handlers(s);<br>
@@ -1000,8 +999,8 @@ static void tcp_chr_accept_server_sync(Chardev *chr)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SocketChardev *s =3D SOCKET_CHARDEV(chr);<br>
=C2=A0 =C2=A0 =C2=A0QIOChannelSocket *sioc;<br>
-=C2=A0 =C2=A0 info_report(&quot;QEMU waiting for connection on: %s&quot;,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;filename);=
<br>
+=C2=A0 =C2=A0 g_autofree char *filename =3D qemu_chr_get_filename(chr);<br=
>
+=C2=A0 =C2=A0 info_report(&quot;QEMU waiting for connection on: %s&quot;, =
filename);<br>
=C2=A0 =C2=A0 =C2=A0tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);<=
br>
=C2=A0 =C2=A0 =C2=A0sioc =3D qio_net_listener_wait_client(s-&gt;listener);<=
br>
=C2=A0 =C2=A0 =C2=A0tcp_chr_set_client_ioc_name(chr, sioc);<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index 0dc792b88f..bdd907f015 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -309,7 +309,7 @@ static void char_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0if (chr-&gt;fe) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chr-&gt;fe-&gt;chr =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 g_free(chr-&gt;filename);<br>
+=C2=A0 =C2=A0 qemu_chr_set_filename(chr, NULL);<br>
=C2=A0 =C2=A0 =C2=A0g_free(chr-&gt;label);<br>
=C2=A0 =C2=A0 =C2=A0if (chr-&gt;logfd !=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(chr-&gt;logfd);<br>
@@ -796,7 +796,7 @@ static int qmp_query_chardev_foreach(Object *obj, void =
*data)<br>
=C2=A0 =C2=A0 =C2=A0ChardevInfo *value =3D g_malloc0(sizeof(*value));<br>
<br>
=C2=A0 =C2=A0 =C2=A0value-&gt;label =3D g_strdup(chr-&gt;label);<br>
-=C2=A0 =C2=A0 value-&gt;filename =3D g_strdup(chr-&gt;filename);<br>
+=C2=A0 =C2=A0 value-&gt;filename =3D qemu_chr_get_filename(chr);<br>
=C2=A0 =C2=A0 =C2=A0value-&gt;frontend_open =3D chr-&gt;fe &amp;&amp; chr-&=
gt;fe-&gt;fe_is_open;<br>
<br>
=C2=A0 =C2=A0 =C2=A0QAPI_LIST_PREPEND(*list, value);<br>
@@ -1025,10 +1025,6 @@ static Chardev *chardev_new(const char *id, const ch=
ar *typename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!chr-&gt;filename) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;filename =3D g_strdup(typename + 8);<b=
r>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0return chr;<br>
=C2=A0}<br>
<br>
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c<br>
index 636d0b83de..2c7b987241 100644<br>
--- a/hw/misc/ivshmem-pci.c<br>
+++ b/hw/misc/ivshmem-pci.c<br>
@@ -873,10 +873,10 @@ static void ivshmem_common_realize(PCIDevice *dev, Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host_memory_backend_set_mapped(s-&gt;host=
mem, true);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Chardev *chr =3D qemu_chr_fe_get_driver(&=
amp;s-&gt;server_chr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *filename =3D qemu_chr_get_filename(chr);=
<br>
</blockquote><div><br></div><div>Should be auto-free, since returned alloca=
ted</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(chr);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 IVSHMEM_DPRINTF(&quot;using shared memory serv=
er (socket =3D %s)\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 chr-&gt;filename);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 IVSHMEM_DPRINTF(&quot;using shared memory serv=
er (socket =3D %s)\n&quot;, filename);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* we allocate enough space for 16 peers =
and grow as needed */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resize_peers(s, 16);<br>
diff --git a/include/chardev/char.h b/include/chardev/char.h<br>
index d36e50b99e..ffeb4a4e3b 100644<br>
--- a/include/chardev/char.h<br>
+++ b/include/chardev/char.h<br>
@@ -62,7 +62,7 @@ struct Chardev {<br>
=C2=A0 =C2=A0 =C2=A0QemuMutex chr_write_lock;<br>
=C2=A0 =C2=A0 =C2=A0CharFrontend *fe;<br>
=C2=A0 =C2=A0 =C2=A0char *label;<br>
-=C2=A0 =C2=A0 char *filename;<br>
+=C2=A0 =C2=A0 char *_filename;<br></blockquote><div><br></div><div>Why ren=
ame the field? we don&#39;t have a=C2=A0=C2=A0convention to have &quot;priv=
ate&quot; fields with _ prefix afaik.</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0int logfd;<br>
=C2=A0 =C2=A0 =C2=A0int be_open;<br>
=C2=A0 =C2=A0 =C2=A0/* used to coordinate the chardev-change special-case: =
*/<br>
@@ -72,6 +72,25 @@ struct Chardev {<br>
=C2=A0 =C2=A0 =C2=A0DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);<br>
=C2=A0};<br>
<br>
+static inline char *qemu_chr_get_filename(Chardev *chr)<br></blockquote><d=
iv><br></div><div>Let&#39;s avoid code in headers.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
+{<br>
+=C2=A0 =C2=A0 const char *typename;<br>
+<br>
+=C2=A0 =C2=A0 if (chr-&gt;_filename) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_strdup(chr-&gt;_filename);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 typename =3D object_get_typename(OBJECT(chr));<br>
+=C2=A0 =C2=A0 assert(g_str_has_prefix(typename, &quot;chardev-&quot;));<br=
>
+=C2=A0 =C2=A0 return g_strdup(typename + 8);<br>
+}<br>
+<br>
+static inline void qemu_chr_set_filename(Chardev *chr, const char *filenam=
e)<br>
+{<br>
+=C2=A0 =C2=A0 g_free(chr-&gt;_filename);<br>
+=C2=A0 =C2=A0 chr-&gt;_filename =3D g_strdup(filename);<br>
+}<br>
+<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_new_from_opts:<br>
=C2=A0 * @opts: see qemu-config.c for a list of valid options<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--0000000000009e9a520645362abc--


