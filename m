Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1242BD0E6C5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 17:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2wW3-0004Fz-FK; Mon, 21 Oct 2024 13:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christophe.lyon@linaro.org>)
 id 1t2wW1-0004AS-4s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:48:25 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christophe.lyon@linaro.org>)
 id 1t2wVz-0006DP-7L
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:48:24 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6db20e22c85so40498067b3.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 10:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729532901; x=1730137701; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FE3GXLE/lB/LoWlxSBqXd6aROfRo6Djg7BwdUk4j77Q=;
 b=axMHU7MVTzGnbXBBWUijl3TTkmspFEgujFdz4ovNE7EsxRjmlyxanZMf/9dNdMlkdv
 GdaQ/DLmnN1AORzBC7gvbNN2pL9cOGY1BO0M9jNgUTypzifibdYZG22Pim/dRO8qsadD
 oerbvcZlHX8Vh43LDF0nY2oYMeArwd/ravpGMSnJ2oawB3ZEe7zz+UpinZjvJEKjV+Gw
 PFqllZGmaRarU6ZskpyVrHsYs9GhQNJ/DjDHncB65AZ1nI9HQtWC75MqnHq4Sw4/fDsO
 MxPHStoNoPGk542ysLS5zVVRgCCRWvDQubOtELCMFeQbKtKLBIeFEmoDI5+fOtvmfpPq
 J0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729532901; x=1730137701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FE3GXLE/lB/LoWlxSBqXd6aROfRo6Djg7BwdUk4j77Q=;
 b=QLLp2YbI96ZxN7uJlGKkYC4IzN61y7FZJpzNnZ1Zqy3HlYKgI0CUMOORRjlReLg6ND
 aMZqODiV3i3vdDCJFjKqtw2N7m5/OXY50tg6HEdm63GzOOQaFpCzqlAMKcONcCm3VYbV
 aCOH7bZLMJ+ssQ9W9NZUBP+DN0imOZ7MaL7Dv/VEKi+Ak5sniXCgBQwkSEy75gzP7mXr
 XFrwR0ZO4zE/33BOt1jDVfS6QTr43rbpnjAzKQ81ABkjad5eQ5XNvQV0GMo9ZVTAZzr5
 ExTSG543xmmNDnfIzJpMvYE1d8T8JGx5JtjCGaHnP9b8cw0b10tMOWzj7JUWSdREibpR
 9BRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTY1OELCfaVurAxOw9ph7+Zfmdg79J+caRlg/9zrInz5YgZx7M2h+Q2HF+nBSLo5uIVWb1NBBzvGPy@nongnu.org
X-Gm-Message-State: AOJu0Yz+Ctkemx0uWv6oNM3Dpg9Dh0v3TCJkwxGWky8zP++JaBqKej0J
 V2IwuD2v1/bwya8kKAfEQhoVamf1HVAa+V1i4VTpndg5R5wrLuL8bsutaBy19/egYsjQ31fLG0r
 7sA63QWKCSBKuOaS58paSgmAYNqx1TNsilrHifY+yhO9XKneL
X-Google-Smtp-Source: AGHT+IEXwRtxQ5FLOThahwuYjMysOrVkZDRk+MG6nvTOMMGYys+retLDNhNL1Xo36U3GV8UdQ/pnMp/vS8Cw0c+4e6k=
X-Received: by 2002:a05:690c:4c0f:b0:6dd:d119:58dd with SMTP id
 00721157ae682-6e5bfc3c1bbmr122256737b3.16.1729532901429; Mon, 21 Oct 2024
 10:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241018130852.931509-1-peter.maydell@linaro.org>
 <5135e8bb-945a-4385-88c0-1b79208e8d2b@linaro.org>
In-Reply-To: <5135e8bb-945a-4385-88c0-1b79208e8d2b@linaro.org>
From: Christophe Lyon <christophe.lyon@linaro.org>
Date: Mon, 21 Oct 2024 19:48:09 +0200
Message-ID: <CAPS5khZRQ+43n-N3iyhCNx+EXovWcFAEXEKVKf0RRcv7w8YAbQ@mail.gmail.com>
Subject: Re: [PATCH v4] scripts/symlink-install-tree.py: Fix MESONINTROSPECT
 parsing
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="00000000000037ad0a06250042dd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=christophe.lyon@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000037ad0a06250042dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,



Le lun. 21 oct. 2024, 19:27, Pierrick Bouvier <pierrick.bouvier@linaro.org>
a =C3=A9crit :

> On 10/18/24 06:08, Peter Maydell wrote:
> > From: Akihiko Odaki <akihiko.odaki@daynix.com>
> >
> > The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
> > must be parsed with shlex.split().  Otherwise the script will fail if
> > the build directory has a character like "~" in it.
> >
> > Note: this fix cannot be backported directly to any stable branch
> > that doesn't require Meson version 1.4.0 or better; otherwise it will
> > work OK on Linux but will break on Windows hosts.
> >
> > (Unfortunately, Meson prior to version 1.4.0 was inconsistent between
> > host OSes about how it quoted arguments, and used a different quoting
> > process on Windows hosts.  Our current git trunk already requires
> > 1.5.0 as of commit 07f0d32641e ("Require meson version 1.5.0"), but
> > the stable branches are still on older Meson.)
> >
> > Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
> > Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > [PMM: Updated commit message to give all the detail about the
> > Meson version compability requirements.]
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This is essentially back to version 1 of Akihiko's patch, now we
> > have a new enough Meson; I just updated the commit message.
> >
> https://patchew.org/QEMU/20230812061540.5398-1-akihiko.odaki@daynix.com/
> > (I have dropped the various reviewed-by and tested-by headers because
> > I figured the passage of time was enough to make them moot.)
> >
> >   scripts/symlink-install-tree.py | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/symlink-install-tree.py
> b/scripts/symlink-install-tree.py
> > index 8ed97e3c943..b72563895c5 100644
> > --- a/scripts/symlink-install-tree.py
> > +++ b/scripts/symlink-install-tree.py
> > @@ -4,6 +4,7 @@
> >   import errno
> >   import json
> >   import os
> > +import shlex
> >   import subprocess
> >   import sys
> >
> > @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
> >       return str(PurePath(d1, *PurePath(d2).parts[1:]))
> >
> >   introspect =3D os.environ.get('MESONINTROSPECT')
> > -out =3D subprocess.run([*introspect.split(' '), '--installed'],
> > +out =3D subprocess.run([*shlex.split(introspect), '--installed'],
> >                        stdout=3Dsubprocess.PIPE, check=3DTrue).stdout
> >   for source, dest in json.loads(out).items():
> >       bundle_dest =3D destdir_join('qemu-bundle', dest)
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>
> I confirm this fixes the error when the path to qemu src tree contains '~=
'.
>

I confirm this fixes the problem we detected in our CI (where some build
dirnames have '~'

Thanks

>

--00000000000037ad0a06250042dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi,=C2=A0<div dir=3D"auto"><br></div><br><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le lun. 21 oct. 2=
024, 19:27, Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.=
org">pierrick.bouvier@linaro.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On 10/18/24 06:08, Peter Maydell wrote:<br>
&gt; From: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" ta=
rget=3D"_blank" rel=3D"noreferrer">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; <br>
&gt; The arguments in MESONINTROSPECT are quoted with shlex.quote() so it<b=
r>
&gt; must be parsed with shlex.split().=C2=A0 Otherwise the script will fai=
l if<br>
&gt; the build directory has a character like &quot;~&quot; in it.<br>
&gt; <br>
&gt; Note: this fix cannot be backported directly to any stable branch<br>
&gt; that doesn&#39;t require Meson version 1.4.0 or better; otherwise it w=
ill<br>
&gt; work OK on Linux but will break on Windows hosts.<br>
&gt; <br>
&gt; (Unfortunately, Meson prior to version 1.4.0 was inconsistent between<=
br>
&gt; host OSes about how it quoted arguments, and used a different quoting<=
br>
&gt; process on Windows hosts.=C2=A0 Our current git trunk already requires=
<br>
&gt; 1.5.0 as of commit 07f0d32641e (&quot;Require meson version 1.5.0&quot=
;), but<br>
&gt; the stable branches are still on older Meson.)<br>
&gt; <br>
&gt; Fixes: cf60ccc330 (&quot;cutils: Introduce bundle mechanism&quot;)<br>
&gt; Reported-by: Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru" tar=
get=3D"_blank" rel=3D"noreferrer">mjt@tls.msk.ru</a>&gt;<br>
&gt; Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@dayni=
x.com" target=3D"_blank" rel=3D"noreferrer">akihiko.odaki@daynix.com</a>&gt=
;<br>
&gt; [PMM: Updated commit message to give all the detail about the<br>
&gt; Meson version compability requirements.]<br>
&gt; Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt=
;<br>
&gt; ---<br>
&gt; This is essentially back to version 1 of Akihiko&#39;s patch, now we<b=
r>
&gt; have a new enough Meson; I just updated the commit message.<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://patchew.org/QEMU/20230812061540.5398-1-=
akihiko.odaki@daynix.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">=
https://patchew.org/QEMU/20230812061540.5398-1-akihiko.odaki@daynix.com/</a=
><br>
&gt; (I have dropped the various reviewed-by and tested-by headers because<=
br>
&gt; I figured the passage of time was enough to make them moot.)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0scripts/symlink-install-tree.py | 3 ++-<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install=
-tree.py<br>
&gt; index 8ed97e3c943..b72563895c5 100644<br>
&gt; --- a/scripts/symlink-install-tree.py<br>
&gt; +++ b/scripts/symlink-install-tree.py<br>
&gt; @@ -4,6 +4,7 @@<br>
&gt;=C2=A0 =C2=A0import errno<br>
&gt;=C2=A0 =C2=A0import json<br>
&gt;=C2=A0 =C2=A0import os<br>
&gt; +import shlex<br>
&gt;=C2=A0 =C2=A0import subprocess<br>
&gt;=C2=A0 =C2=A0import sys<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -&gt; str:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return str(PurePath(d1, *PurePath(d2).parts[=
1:]))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0introspect =3D os.environ.get(&#39;MESONINTROSPECT&#39;)<b=
r>
&gt; -out =3D subprocess.run([*introspect.split(&#39; &#39;), &#39;--instal=
led&#39;],<br>
&gt; +out =3D subprocess.run([*shlex.split(introspect), &#39;--installed&#3=
9;],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 stdout=3Dsubprocess.PIPE, check=3DTrue).stdout<br>
&gt;=C2=A0 =C2=A0for source, dest in json.loads(out).items():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bundle_dest =3D destdir_join(&#39;qemu-bundl=
e&#39;, dest)<br>
<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro=
.org" target=3D"_blank" rel=3D"noreferrer">pierrick.bouvier@linaro.org</a>&=
gt;<br>
Tested-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.o=
rg" target=3D"_blank" rel=3D"noreferrer">pierrick.bouvier@linaro.org</a>&gt=
;<br>
<br>
I confirm this fixes the error when the path to qemu src tree contains &#39=
;~&#39;.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I confirm this fixes the problem we detected in our CI (where som=
e build dirnames have &#39;~&#39;</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000037ad0a06250042dd--

