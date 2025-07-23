Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9B0C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 13:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueZrC-0001Du-W2; Wed, 23 Jul 2025 09:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ueZr4-0001BI-IL
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ueZr1-0000kg-A9
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753278592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7VoeJRaZDxOhCaABj1EVH3adB5DrXHOoAi/AckRJUNE=;
 b=BhOdma5V1ub8oiC2bBE3NvrOemy9waFV0h7DxGBz7fZUkZhJigappEOz1GnFJdG9yCki1N
 d9cSdd2d4uDmOZmHuu9NUJSLuYxAONhmYLHt6LfYVBefT7SqoBzL8JR0znam5oNNPqz2ao
 WQSyb/BcU/ybYDCRvxnqL2oDesNEGIQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-XUz_oAa0NxeYD5znwkR4FA-1; Wed, 23 Jul 2025 09:49:51 -0400
X-MC-Unique: XUz_oAa0NxeYD5znwkR4FA-1
X-Mimecast-MFC-AGG-ID: XUz_oAa0NxeYD5znwkR4FA_1753278589
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-313d346dc8dso10197572a91.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 06:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753278589; x=1753883389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7VoeJRaZDxOhCaABj1EVH3adB5DrXHOoAi/AckRJUNE=;
 b=aLyj+lTq5qWGVaFDJwYxckx0MxEVVRGnBcxH0wZDpxLBhB+lGcbAOEKXKwEiMnE7Ms
 Jz0fVvFVMpoZePe1+USUhdVQlQZXoa5VPQJkqWGrdHSxBqqLodPvUyPzF8CN/AwJMvv/
 ViQzqo2wDd4VfIwD2rYGi+SRWmSrM0U3ezkcVX3nXnf5WdVX8eEUMc4Vl7flphdFENGG
 7BMK6zFE32ibDmMSlZki7p/KdTYHv8+ec6gAy08wOycO6MUq9a0P0EcaORKOhnt9zHK1
 95rHgZCAtIZGTrZyIEHgrESnqhlWDz8MAgw08Hnpy5i09WUlS8fE5Z8h8hi1RimEYeiP
 O2SA==
X-Gm-Message-State: AOJu0YwhqoxQRXDufk/A9NW6H3lORyzlTnYI9VosCPy6h2RwfC6+KiHv
 JibVsJbI3CoFDvwl9kNJ5c6zlkpuVdjhYeUrK/9+CLIsh+tOacZEAYvY14yGQdt656d2KgE//og
 K1hg2Nn9BsDQM5zKWZE4uDiHbUxnDY+S3s/+orO8ua604JjRkV6dp0TL0EQGpsEUsKABYDrV7Mt
 k1ZKBMq8ZBJSXBlpOm57pWPDnMzcOxPIqGtQgdt3Xdpn1e
X-Gm-Gg: ASbGncvvwzVcttqxiJ5Bjd8iq9OBF6cibZIyOTsrUCN7tXLu1YIM0Qh5qwZ0/z/py38
 y+GEuB2V0BQhTjT4kBlJdw3w8seUNi4eX/iQFclQfyD7PbsWs5YMTcWZC7eYu2qUOXAKRLMeo71
 olEtPQUyP+iQ5P4zbTY5BE3JBBcSTdexl0Af4ALO1rqZ3CTyqbqdL1yA==
X-Received: by 2002:a17:90b:2e0e:b0:313:23ed:701 with SMTP id
 98e67ed59e1d1-31e5078eb95mr4560471a91.4.1753278588916; 
 Wed, 23 Jul 2025 06:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGLA6MIkR+cE9PwRaf0PyIONp1S0egj+Yd6L6rmY1O+oFD9PnyoOr86o4RROEbD1g1QePz1WWYFaOfCxd96TM=
X-Received: by 2002:a17:90b:2e0e:b0:313:23ed:701 with SMTP id
 98e67ed59e1d1-31e5078eb95mr4560431a91.4.1753278588435; Wed, 23 Jul 2025
 06:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250723131504.1482657-1-armbru@redhat.com>
In-Reply-To: <20250723131504.1482657-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Jul 2025 17:49:37 +0400
X-Gm-Features: Ac12FXwLVCS0mQEcREg9HVxloGolJOYFlsAHWSmBO-UGhEVTIGBAdcBNfxAofaY
Message-ID: <CAMxuvay2YWOOWB0ak7y+eRpKwAUa68r0cym_MSsTqEcEHw1Fng@mail.gmail.com>
Subject: Re: [PATCH] ui/keymaps: Avoid trace crash and improve error messages
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="00000000000074d3b5063a98fb84"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000074d3b5063a98fb84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 5:15=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> parse_keyboard_layout() passes a possibly null @filename to
> trace_keymap_parse().  Trace backend log then formats it with %s,
> which crashes on some systems.
>
> Fix by moving the null check before the trace_keymap_parse().
>
> While there, improve the error messages a bit.
>
> Fixes: d3b787fa7dde (keymaps: add tracing)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/keymaps.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/ui/keymaps.c b/ui/keymaps.c
> index 6ceaa97085..2359dbfe7e 100644
> --- a/ui/keymaps.c
> +++ b/ui/keymaps.c
> @@ -86,19 +86,25 @@ static int parse_keyboard_layout(kbd_layout_t *k,
>                                   const name2keysym_t *table,
>                                   const char *language, Error **errp)
>  {
> +    g_autofree char *filename =3D NULL;
>      int ret;
>      FILE *f;
> -    char * filename;
>      char line[1024];
>      char keyname[64];
>      int len;
>
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_KEYMAP, language);
> +    if (!filename) {
> +        error_setg(errp, "could not find keymap file for language '%s'",
> +                   language);
> +        return -1;
> +    }
> +
>      trace_keymap_parse(filename);
> -    f =3D filename ? fopen(filename, "r") : NULL;
> -    g_free(filename);
> +
> +    f =3D fopen(filename, "r");
>      if (!f) {
> -        error_setg(errp, "could not read keymap file: '%s'", language);
> +        error_setg_file_open(errp, errno, filename);
>          return -1;
>      }
>
> --
> 2.49.0
>
>

--00000000000074d3b5063a98fb84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 23,=
 2025 at 5:15=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">parse_keyboard_layout() passes a possibly null @f=
ilename to<br>
trace_keymap_parse().=C2=A0 Trace backend log then formats it with %s,<br>
which crashes on some systems.<br>
<br>
Fix by moving the null check before the trace_keymap_parse().<br>
<br>
While there, improve the error messages a bit.<br>
<br>
Fixes: d3b787fa7dde (keymaps: add tracing)<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lur=
eau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/keymaps.c | 14 ++++++++++----<br>
=C2=A01 file changed, 10 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/ui/keymaps.c b/ui/keymaps.c<br>
index 6ceaa97085..2359dbfe7e 100644<br>
--- a/ui/keymaps.c<br>
+++ b/ui/keymaps.c<br>
@@ -86,19 +86,25 @@ static int parse_keyboard_layout(kbd_layout_t *k,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const name2keysym_t *table,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *language, Error *=
*errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 g_autofree char *filename =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0FILE *f;<br>
-=C2=A0 =C2=A0 char * filename;<br>
=C2=A0 =C2=A0 =C2=A0char line[1024];<br>
=C2=A0 =C2=A0 =C2=A0char keyname[64];<br>
=C2=A0 =C2=A0 =C2=A0int len;<br>
<br>
=C2=A0 =C2=A0 =C2=A0filename =3D qemu_find_file(QEMU_FILE_TYPE_KEYMAP, lang=
uage);<br>
+=C2=A0 =C2=A0 if (!filename) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;could not find keymap f=
ile for language &#39;%s&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0langu=
age);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0trace_keymap_parse(filename);<br>
-=C2=A0 =C2=A0 f =3D filename ? fopen(filename, &quot;r&quot;) : NULL;<br>
-=C2=A0 =C2=A0 g_free(filename);<br>
+<br>
+=C2=A0 =C2=A0 f =3D fopen(filename, &quot;r&quot;);<br>
=C2=A0 =C2=A0 =C2=A0if (!f) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;could not read keymap f=
ile: &#39;%s&#39;&quot;, language);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_file_open(errp, errno, filename);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--00000000000074d3b5063a98fb84--


