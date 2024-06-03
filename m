Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDCDC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 10:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE4sS-0003hY-KK; Mon, 03 Jun 2024 06:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sE4sQ-0003gk-Aq; Mon, 03 Jun 2024 06:25:18 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sE4sH-0003Ws-7m; Mon, 03 Jun 2024 06:25:13 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3d1bb1c3b74so2175792b6e.2; 
 Mon, 03 Jun 2024 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717410305; x=1718015105; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TdaTaAGXGLWXadJo441KGFXl0Wn5JjyQATuZL7KUKmM=;
 b=h+hJcvrfh3O9eEWtEnjqpBUcMouBodjn7y2H0h/sg9svAKIw0T5yV47ayFgItiSXVz
 T9hvg4vCEv8TAsgtD9moX2PeM8wWF7n3PAw2bDxfBBxV8UxE2gIsVADxneB6p7Zoez2V
 ibK3/o7SIozoc6EOdbdowU7wBfyB4O0lLQmAb7vir+8omA/aNdknpgatDgctiANsBepy
 WbjuEEnliSsEZdLvNTNIdm60hb5ZAz1EdoRJrprrdeAqgKB9/BAQXl+tGakzlg6GNAan
 noJsyAuAuo0RHF4yG4DPdscV6SxM9wRML7wxkUpOJ8Wj2LJBNo8rtbpeHBkmNa5llUJw
 QQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717410305; x=1718015105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TdaTaAGXGLWXadJo441KGFXl0Wn5JjyQATuZL7KUKmM=;
 b=du+PtnoA3USqQWg3fCgJHkJbts7a6KnGiwR1nvBE8RqdWNtVt8xyTm6bXRufxF3jNB
 O+XmUmUs29UNRV5JsAyaSq0OMRafbsoKlXVorRjdWRKMFB6b0BQ8SGFDtzhNV3cVA1H3
 6GeT22YcCGP9/UOUWiKDzgOUBBJOXH6opnn++hFIBfA3Kgogirb5+9NkOLjCsxmS0jVm
 dMuEnprtdRVJw+PTD1u+biPVEfAfxqMmWrl7xfkRSLdoSAMN2EdDkBfNEAw9NU3DrILU
 KwEG2Yov0RBMel6BfTkX2rcqXwxAqXXSMprryGnjgRXvbw88gaq+Ph7sgPhQehCZpEGq
 GS/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4safQYxAH7+17YXzwN3MMhiz8H3f2trvOToPR0JI56bLLcuFaIjMOcqGpkPhmQXUxw8gdLWMTw91qOh5B0PBzXlgwepfu
X-Gm-Message-State: AOJu0Yy8eE2KEbtFAfuQOzBNtdpp10uYjLHFnNC5/siFZL792oojKud4
 tVrD8LzDWqXXe4/JWvwcz8/djX8VwWsJL5che48f4nXGbATLPVIU+NZjZvzbacGi7JyaGxXrlmp
 HcmOPaJlhxQXaAjC4bgsfVcUpbp4=
X-Google-Smtp-Source: AGHT+IEVH9Sc2SXSK1dQtDeUlQ7WCsYBY9L6N2E0dz8bdOR00rbn1q1+8+xkSkbnYzAWd5+HCA/iaqYfh5iHdqW5iDk=
X-Received: by 2002:a05:6808:2a8d:b0:3c9:96d2:fcea with SMTP id
 5614622812f47-3d1e3495438mr8242131b6e.17.1717410304569; Mon, 03 Jun 2024
 03:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240530110417.1724583-1-kraxel@redhat.com>
In-Reply-To: <20240530110417.1724583-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Jun 2024 14:24:52 +0400
Message-ID: <CAJ+F1CJMjq6SSwuW3E3CweVH_ftGJL0qF3QqKgGQMvt=_t8tKg@mail.gmail.com>
Subject: Re: [PATCH] stdvga: fix screen blanking
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000233a650619f9bfda"
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000233a650619f9bfda
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 30, 2024 at 3:05=E2=80=AFPM Gerd Hoffmann <kraxel@redhat.com> w=
rote:

> In case the display surface uses a shared buffer (i.e. uses vga vram
> directly instead of a shadow) go unshare the buffer before clearing it.
>
> This avoids vga memory corruption, which in turn fixes unblanking not
> working properly with X11.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2067
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 30facc6c8e33..34ab8eb9b745 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1762,6 +1762,12 @@ static void vga_draw_blank(VGACommonState *s, int
> full_update)
>      if (s->last_scr_width <=3D 0 || s->last_scr_height <=3D 0)
>          return;
>
> +    if (is_buffer_shared(surface)) {
>

It might be a good time to rename this function. surface_is_borrowed() ?


> +        /* unshare buffer, otherwise the blanking corrupts vga vram */
> +        qemu_console_resize(s->con, s->last_scr_width,
> s->last_scr_height);
>

If we want to guarantee that a new surface is created, we should leave a
comment on qemu_console_resize(), or perhaps make it take a new/alloc
argument?

+        surface =3D qemu_console_surface(s->con);
> +    }
> +
>      w =3D s->last_scr_width * surface_bytes_per_pixel(surface);
>      d =3D surface_data(surface);
>      for(i =3D 0; i < s->last_scr_height; i++) {
> --
> 2.45.1
>
>
>
thanks

--=20
Marc-Andr=C3=A9 Lureau

--000000000000233a650619f9bfda
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 30, 2024 at 3:05=
=E2=80=AFPM Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">In case the display surface uses a shared buffer (i.e. uses vga =
vram<br>
directly instead of a shadow) go unshare the buffer before clearing it.<br>
<br>
This avoids vga memory corruption, which in turn fixes unblanking not<br>
working properly with X11.<br>
<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2067" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2067</a><br>
Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" targe=
t=3D"_blank">kraxel@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/display/vga.c | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/hw/display/vga.c b/hw/display/vga.c<br>
index 30facc6c8e33..34ab8eb9b745 100644<br>
--- a/hw/display/vga.c<br>
+++ b/hw/display/vga.c<br>
@@ -1762,6 +1762,12 @@ static void vga_draw_blank(VGACommonState *s, int fu=
ll_update)<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;last_scr_width &lt;=3D 0 || s-&gt;last_scr_he=
ight &lt;=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
<br>
+=C2=A0 =C2=A0 if (is_buffer_shared(surface)) {<br></blockquote><div><br></=
div><div>It might be a good time to rename this function. surface_is_borrow=
ed() ?</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* unshare buffer, otherwise the blanking corr=
upts vga vram */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_console_resize(s-&gt;con, s-&gt;last_scr_=
width, s-&gt;last_scr_height);<br></blockquote><div><br></div><div>If we wa=
nt to guarantee that a new surface is created, we should leave a comment on=
 qemu_console_resize(), or perhaps make it take a new/alloc argument?</div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 surface =3D qemu_console_surface(s-&gt;con);<b=
r>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0w =3D s-&gt;last_scr_width * surface_bytes_per_pixel(su=
rface);<br>
=C2=A0 =C2=A0 =C2=A0d =3D surface_data(surface);<br>
=C2=A0 =C2=A0 =C2=A0for(i =3D 0; i &lt; s-&gt;last_scr_height; i++) {<br>
-- <br>
2.45.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"></div><div>thanks</div><div><br></div>=
<div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" =
class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div></div>

--000000000000233a650619f9bfda--

