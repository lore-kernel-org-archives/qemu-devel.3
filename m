Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5339D33980
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXcm-0002eS-Ce; Fri, 05 Dec 2025 10:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXcS-0002Yh-SF
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:21:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXcR-0003HP-60
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764948074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dT2EHjXcvZ1X8eY510f/VkwkrKCUeG5BUuqQLseT6Kw=;
 b=YOIGpcTmyafWrj9EIww2aZAhdUl/5Ms6TePjYR2UVUpVkwrVEIBAM4RIotDzfWu0DKUjem
 ASuHgEGXML6VG5sApAlQmYodm4oMKGd+6OAfE9NbYgEc/ME0M2DfGXKKYTnuTFvVFkZT1O
 Jw3hzQSCpODu1E99RwlKdTE0ulIvk8M=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-KUVoVDaiPDKXmS6PBrmXVA-1; Fri, 05 Dec 2025 10:21:12 -0500
X-MC-Unique: KUVoVDaiPDKXmS6PBrmXVA-1
X-Mimecast-MFC-AGG-ID: KUVoVDaiPDKXmS6PBrmXVA_1764948071
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3438744f12fso5601553a91.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764948071; x=1765552871; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dT2EHjXcvZ1X8eY510f/VkwkrKCUeG5BUuqQLseT6Kw=;
 b=t9NY0xD7dJxO2MmQYU+KbakQDpbIkDKQz+/uXT4jLiIZNHFJF1qgsRhTmZe9QBr/33
 vkn1XJhDN9u3G68rFMQ34z5VBwyyI/RxbK1W+iTis4JjzCb0W2g0G5a21mDkinMWEij9
 qOwXezPNsCS7b3u1CX9d8WT+cPxqMwhkIzqMPn2jym44UKSmAXgSlf60vXgnzOisLD0x
 4PzDdXkIMMhFTfp6NVCe3clTAeuLFJTumztqoT2kUz69puUv+wrw2ktkBYslzp/ZN8S9
 HyhuxH9FGui6rVUJYFEeJQo9GcWfhN/ZB+q6Y/PowBgLyLDBIhUxwywwtKMpLGiYify2
 Lm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764948071; x=1765552871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dT2EHjXcvZ1X8eY510f/VkwkrKCUeG5BUuqQLseT6Kw=;
 b=L36MdZgcZNQL+dzPJeeSHiuso4cPqky4nA4Hfom45pDkZ2rG3clLa4oVF5djyITDhU
 TYHh95UQQB6pTW8n+Z4hj9gx3iBeGEmgOG51kIUJkk045Im0Qyb15axwd2TfxGaJcc3n
 0g27PSYvmQfBTxM1z7rf6Zk83pDv3pDYgKv7OQ9FNNAXYFNGCNmGkteHgewBN49C1u6U
 T50u17iciiMnKNcJ7r4iyHPTisOvjNIZ/wyr6KcsK2I4vitkcoooIaZVkQswC4pnqJa2
 3pobnugLL2OJUBLjqhBPmWrxk+wx8aFBQhAG3yq3DBSFBDH3CBt8LDpgrhEbyJlaIouT
 TNBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNn+nusaxi61aREFM+NguKD2qtis45Cn8JVsoGwzNNg0cK9g0f7KCqp5MS94DZXv+iwNb7UjDafoRD@nongnu.org
X-Gm-Message-State: AOJu0Yz95vIf19atHN/kFxhDZgpYOYjYIA0CA/Wzy5h0fb+HxJdsui1X
 NqvY3L2IvgtKfUPV+6HENQ/p6iPVJmVtw2BGmJCyyuuNo9t7fKnniQSq7Ek8UogxAO20+YFvnEl
 ZebfFaVK/XT2t6JQIxTT3Qqez2il1mbLKzODfXo/9zlOjRoqIlxrejt9STBKQEGZ5wD5Ezc/dN4
 0BwIiELiXP3RWAefBope66pViBLmSOrnc=
X-Gm-Gg: ASbGncuFvW4AIjM1SCVx7ZVchlv9nvXQFpL4q4SX6ew8u8VbUV3zaCABbCGcUX1xJoV
 3t3VTHObqCFeSriF4RNr+QsXcefFjXqVyCDQUZqSaEPX+dDnG2w6AjHPhQGENHP8LisYGmM2Ccb
 zsF6ylQERfErVHgxhlf/oUb6MkhrVCT1AaJXcCYNNgmngbnnB9Tuac/I34r66mBowg4OJ8jIUPx
 P48XXUp1C7Nh/o/YBO4odGHtg==
X-Received: by 2002:a17:90b:4990:b0:349:7f02:d197 with SMTP id
 98e67ed59e1d1-3497f02d447mr1782664a91.5.1764948071464; 
 Fri, 05 Dec 2025 07:21:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbyBilv5ZYG/+CVngmk212fmSEcDGMN8IVXlkQLjfnrP/hJP+3Kj/kdoHPk/N0YCRqkOjCshy6IyZjJwIlzh4=
X-Received: by 2002:a17:90b:4990:b0:349:7f02:d197 with SMTP id
 98e67ed59e1d1-3497f02d447mr1782643a91.5.1764948070950; Fri, 05 Dec 2025
 07:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
 <20251204154235.149575-8-vsementsov@yandex-team.ru>
In-Reply-To: <20251204154235.149575-8-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Dec 2025 19:20:58 +0400
X-Gm-Features: AWmQ_blAoxRuVESqCWMz7YyMfbYeenixmglSg0ezxmkoJXHqOQmeKFdvMoWzKpQ
Message-ID: <CAMxuvayOyP19mPEASBqkuiLw=CiWqWE4hocM6v9tj5pOxZtFJA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] chardev/char-pty: store pty_name into PtyChardev
 state
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
Content-Type: multipart/alternative; boundary="000000000000d101ea064535fea0"
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

--000000000000d101ea064535fea0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> We'll use it in following commit.
>
> Note the bonus: stop use blind strcpy().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/char-pty.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 9e26e97baf..a582aa7bc7 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -43,6 +43,7 @@ struct PtyChardev {
>      int connected;
>      GSource *timer_src;
>      char *path;
> +    char *pty_name;
>  };
>  typedef struct PtyChardev PtyChardev;
>
> @@ -303,7 +304,7 @@ static void cfmakeraw (struct termios *termios_p)
>  #endif
>
>  /* like openpty() but also makes it raw; return master fd */
> -static int qemu_openpty_raw(int *aslave, char *pty_name)
> +static int qemu_openpty_raw(int *aslave, char **pty_name)
>  {
>      int amaster;
>      struct termios tty;
> @@ -324,9 +325,7 @@ static int qemu_openpty_raw(int *aslave, char
> *pty_name)
>      cfmakeraw(&tty);
>      tcsetattr(*aslave, TCSAFLUSH, &tty);
>
> -    if (pty_name) {
> -        strcpy(pty_name, q_ptsname(amaster));
> -    }
> +    *pty_name =3D g_strdup(q_ptsname(amaster));
>
>      return amaster;
>  }
> @@ -335,11 +334,12 @@ static bool pty_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>  {
>      PtyChardev *s;
>      int master_fd, slave_fd;
> -    char pty_name[PATH_MAX];
>      char *name;
>      char *path =3D backend->u.pty.data->path;
>
> -    master_fd =3D qemu_openpty_raw(&slave_fd, pty_name);
> +    s =3D PTY_CHARDEV(chr);
> +
> +    master_fd =3D qemu_openpty_raw(&slave_fd, &s->pty_name);
>      if (master_fd < 0) {
>          error_setg_errno(errp, errno, "Failed to create PTY");
>          return false;
> @@ -351,11 +351,10 @@ static bool pty_chr_open(Chardev *chr,
> ChardevBackend *backend, Error **errp)
>          return false;
>      }
>
> -    chr->filename =3D g_strdup_printf("pty:%s", pty_name);
> +    chr->filename =3D g_strdup_printf("pty:%s", s->pty_name);
>      qemu_printf("char device redirected to %s (label %s)\n",
> -                pty_name, chr->label);
> +                s->pty_name, chr->label);
>
> -    s =3D PTY_CHARDEV(chr);
>      s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
>      name =3D g_strdup_printf("chardev-pty-%s", chr->label);
>      qio_channel_set_name(s->ioc, name);
> @@ -364,7 +363,7 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend
> *backend, Error **errp)
>
>      /* create symbolic link */
>      if (path) {
> -        int res =3D symlink(pty_name, path);
> +        int res =3D symlink(s->pty_name, path);
>
>          if (res !=3D 0) {
>              error_setg_errno(errp, errno, "Failed to create PTY symlink"=
);
> --
> 2.48.1
>
>

--000000000000d101ea064535fea0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 4, =
2025 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:=
vsementsov@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">We&#39;ll use it in fol=
lowing commit.<br>
<br>
Note the bonus: stop use blind strcpy().<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br></=
blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a h=
ref=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&=
gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
---<br>
=C2=A0chardev/char-pty.c | 19 +++++++++----------<br>
=C2=A01 file changed, 9 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/chardev/char-pty.c b/chardev/char-pty.c<br>
index 9e26e97baf..a582aa7bc7 100644<br>
--- a/chardev/char-pty.c<br>
+++ b/chardev/char-pty.c<br>
@@ -43,6 +43,7 @@ struct PtyChardev {<br>
=C2=A0 =C2=A0 =C2=A0int connected;<br>
=C2=A0 =C2=A0 =C2=A0GSource *timer_src;<br>
=C2=A0 =C2=A0 =C2=A0char *path;<br>
+=C2=A0 =C2=A0 char *pty_name;<br>
=C2=A0};<br>
=C2=A0typedef struct PtyChardev PtyChardev;<br>
<br>
@@ -303,7 +304,7 @@ static void cfmakeraw (struct termios *termios_p)<br>
=C2=A0#endif<br>
<br>
=C2=A0/* like openpty() but also makes it raw; return master fd */<br>
-static int qemu_openpty_raw(int *aslave, char *pty_name)<br>
+static int qemu_openpty_raw(int *aslave, char **pty_name)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int amaster;<br>
=C2=A0 =C2=A0 =C2=A0struct termios tty;<br>
@@ -324,9 +325,7 @@ static int qemu_openpty_raw(int *aslave, char *pty_name=
)<br>
=C2=A0 =C2=A0 =C2=A0cfmakeraw(&amp;tty);<br>
=C2=A0 =C2=A0 =C2=A0tcsetattr(*aslave, TCSAFLUSH, &amp;tty);<br>
<br>
-=C2=A0 =C2=A0 if (pty_name) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 strcpy(pty_name, q_ptsname(amaster));<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 *pty_name =3D g_strdup(q_ptsname(amaster));<br>
<br>
=C2=A0 =C2=A0 =C2=A0return amaster;<br>
=C2=A0}<br>
@@ -335,11 +334,12 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PtyChardev *s;<br>
=C2=A0 =C2=A0 =C2=A0int master_fd, slave_fd;<br>
-=C2=A0 =C2=A0 char pty_name[PATH_MAX];<br>
=C2=A0 =C2=A0 =C2=A0char *name;<br>
=C2=A0 =C2=A0 =C2=A0char *path =3D backend-&gt;u.pty.data-&gt;path;<br>
<br>
-=C2=A0 =C2=A0 master_fd =3D qemu_openpty_raw(&amp;slave_fd, pty_name);<br>
+=C2=A0 =C2=A0 s =3D PTY_CHARDEV(chr);<br>
+<br>
+=C2=A0 =C2=A0 master_fd =3D qemu_openpty_raw(&amp;slave_fd, &amp;s-&gt;pty=
_name);<br>
=C2=A0 =C2=A0 =C2=A0if (master_fd &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, errno, &quot;Faile=
d to create PTY&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
@@ -351,11 +351,10 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 chr-&gt;filename =3D g_strdup_printf(&quot;pty:%s&quot;, pty=
_name);<br>
+=C2=A0 =C2=A0 chr-&gt;filename =3D g_strdup_printf(&quot;pty:%s&quot;, s-&=
gt;pty_name);<br>
=C2=A0 =C2=A0 =C2=A0qemu_printf(&quot;char device redirected to %s (label %=
s)\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pty_name, chr-&gt;=
label);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;pty_name, ch=
r-&gt;label);<br>
<br>
-=C2=A0 =C2=A0 s =3D PTY_CHARDEV(chr);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(maste=
r_fd));<br>
=C2=A0 =C2=A0 =C2=A0name =3D g_strdup_printf(&quot;chardev-pty-%s&quot;, ch=
r-&gt;label);<br>
=C2=A0 =C2=A0 =C2=A0qio_channel_set_name(s-&gt;ioc, name);<br>
@@ -364,7 +363,7 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend *=
backend, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* create symbolic link */<br>
=C2=A0 =C2=A0 =C2=A0if (path) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int res =3D symlink(pty_name, path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int res =3D symlink(s-&gt;pty_name, path);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, errn=
o, &quot;Failed to create PTY symlink&quot;);<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--000000000000d101ea064535fea0--


