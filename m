Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5B8EB26F5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 18:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpsNh-0006M4-Dk; Tue, 10 Feb 2026 13:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpsNe-0006Lu-VU
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 13:22:35 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpsNc-0004Zp-BU
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 13:22:34 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c61342a69b9so1604761a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 10:22:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770747750; cv=none;
 d=google.com; s=arc-20240605;
 b=er9uPuRlCS8EKy/twEHlPigS8iK1D4p1xQDqKBjh+UExsX+p8G+xNgKPq1f0QFiTwd
 H2NLKu4j82AtZiiSEHNuRdEcbK64vTU1HugxPsdjP9iTFPtgVWHtPGdpKsZNydzN1QWk
 T+FJXeVkWpjofX3kHdb3Yoh/UbgJbHzGcopUQJFm0GSKUHlm8ZYyd0X3MVQkN4viFAjT
 ujU7XaNQmfArA+MsVracU/uVJH+CoUShY58NILawEcQ1wr2aayodc3qUruyV3QDEAcfL
 unz/DSsOqb7TPivYfmSM2cpwbBhHK0Wnfc9uqQ+QGjEZDlWitrQEGBXU/XpgZ3wPed1E
 dqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=slg+AesDuZmBwU2bflyanqaLk5t1rQ60A2fqkafJ1/M=;
 fh=M7XyAfrrmL95TYuUE/QGLprRPH62/7mQ6Rg7iNyGmg4=;
 b=hLEr5OY81yOrNOOvGFel/LPGv3vMKJYb5qdQ27rhanuy61Jfy2ZtBkHL/B8nugVxQb
 DiIs5e7k0dU8G6AsuCK2Vf5dbjDeI8P0jYkPzIrZxHD8j6PiGRMIomoO8kcjhc1YfLC1
 lPl+zvQ9RxLF6Kj1+ARHDa0qkLtsqHyqDWKNz9Uf2ZL7d1bBM9RFdJv/7uye94DvOZnm
 MKsTWgteSY+5Zx8OC13p1Mu0sw52YjlhHNuc9oACTz6CS/HrgV/xUOJfzlpu0jwlgOHa
 QdGg3dye4Sz/NmsIN7aD7GPqEtnn5kIb6IbqvX2o6X/y7csUz7L7XtAuf2Bec3Pr7U6/
 S/Lw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770747750; x=1771352550;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=slg+AesDuZmBwU2bflyanqaLk5t1rQ60A2fqkafJ1/M=;
 b=kJNMpPCk13nqmVqDQoNmmJ0oaEHnVJ8MaDditzQ4DPCP+0dwH2wg6QM/ov9GyVQol1
 VNR3Frxj1MI70YNA52hC5AvxP/g+TKzq0fBYki1rHM+JL0KoaqdNOT40M97W3TICWT6S
 HABCEZiYzLhpqKjxva59M11EPmQyQHlqIxVCkI32aiCWZDVzvwxgYlvcRjPl31aNfAvm
 DkRj1sMvR2PR8cqKxSU6WkrslnM81a6pmya7ERGUBZ1hLLLdFB1AF8veKRZeta+rZoOV
 G2pj21FU2Vy/lhj48xDl4paO6Sp4Z/1xqvlwbpoqzYpFegF4zgk6hPIc8xIpTIU2Vo1N
 2jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770747750; x=1771352550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slg+AesDuZmBwU2bflyanqaLk5t1rQ60A2fqkafJ1/M=;
 b=LQ7IELLDUZHWT19MAGzy34bFJERyj1Y93JHrpwjtxljq5+T05Og+Xix8PbHKzvd/z6
 EtG/di1inlIo0G3Oq8D85Xp6NWyeV4Fo1ApY995P2KcgOOUX8spfbN+4WnOQu2Cvwmwn
 Ms72FziqV+6+650Nkf5lCuh1XGLUvZE2/o5AT+zAgHzCjyW28ysFKAtwXwyXX+QrJy8Q
 Me+Ad6Z+f643gO854bX+ymwTsxGihhawEbNJv5IjcNj4CGaaUql04PDGVvQTCs86Ag+f
 2eYdHngRRfw3CuwAr8ml4scyHp9DcIWEzamRkI/9Z2ycs4F8yobhADD1IuKn0iG0sep3
 NKMw==
X-Gm-Message-State: AOJu0YyWPjmSIqwisbJWpokwQrAckLIOHloY/0auqYsMtGgoXZwKYiua
 8FFCA5UhXwwM2GCoBJAa6+B4H5U6kP+2BWdIWq0sZ1fVyMMty4fLYDef2I6xTZUo/lKblHoqdeM
 Bdaj8OWjChIoprE9Mm6BAThmnDpkcTJR1AaV5g6u/MA==
X-Gm-Gg: AZuq6aJGCsEbiL9NwzmyxfwDWZlBmcqnUYo4J0EfiHJw/qt07pgzEQcLa+fNTBDfSB3
 kUU/XDKgpLBzKgNU0wUsdqvpSCiYaSmaCjcDPHVY0y9hF8+0ifb9t5RdrxFRI2HATnhEGov6htq
 i5EUuIbLxY9ZifL41EWa4xXOs1ejSJxupJKNI3LO2nRACP+f7mZSvQHeDm3wfKKO3T1wMlC1vSA
 SgUn10JdjcSfqomrQ6v+SzhYYGL0C/X5+EF6ZUZjA+mOTi2PcPM9v/nEkzPfzsTj7jeNz4DFMkP
 JxukRQg=
X-Received: by 2002:a17:90b:3d8b:b0:352:f2a6:334 with SMTP id
 98e67ed59e1d1-3567b006342mr121502a91.16.1770747750406; Tue, 10 Feb 2026
 10:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20260210-freebsd-inotify-v1-1-009430118133@bsdimp.com>
 <aYtUqbgy_axpHfn2@redhat.com>
In-Reply-To: <aYtUqbgy_axpHfn2@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Feb 2026 11:22:19 -0700
X-Gm-Features: AZwV_QhfRXPiOBUNXnYfRMeETKmKpty7RvfW30PWDk6c0ofO3mVvTR5Wb0JNiCs
Message-ID: <CANCZdfptjiCo7MteVbxWOf_oPpX9nP4GQ-PUTUthYKBz4g5nNg@mail.gmail.com>
Subject: Re: [PATCH] freebsd: FreeBSD 15 has native inotify
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a66a4c064a7c5602"
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000a66a4c064a7c5602
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 8:54=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Tue, Feb 10, 2026 at 08:43:48AM -0700, Warner Losh wrote:
> > Check to make sure that we have inotify in libc, before looking for it
> > in libinotify.
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Daniel P. Berrange <berrange@redhat.com>
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> > FreeBSD 15 and newer now has a native inotify implementation. Check for
> > it before checking for the wrapper libinotify library which is needed i=
n
> > FreeBSD 14 and earlier. Make the check dependent on symbols, not host
> > version.
> >
> > Separate series because it's really independent of the two other
> > patch series I have submitted and it is more important.
> > ---
> >  meson.build | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 2d114e9018..537f50283f 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2662,13 +2662,15 @@ have_inotify_init =3D
> cc.has_header_symbol('sys/inotify.h', 'inotify_init')
> >  have_inotify_init1 =3D cc.has_header_symbol('sys/inotify.h',
> 'inotify_init1')
> >  inotify =3D not_found
> >  if (have_inotify_init or have_inotify_init1) and host_os =3D=3D 'freeb=
sd'
> > -  # libinotify-kqueue
> > -  inotify =3D cc.find_library('inotify')
> > -  if have_inotify_init
> > -    have_inotify_init =3D inotify.found()
> > -  endif
> > -  if have_inotify_init1
> > -    have_inotify_init1 =3D inotify.found()
> > +  if not cc.has_function('inotify_init') and not
> cc.has_function('inotify_init1')
> > +    inotify =3D cc.find_library('inotify')
> > +    # libinotify-kqueue
> > +    if have_inotify_init
> > +      have_inotify_init =3D inotify.found()
> > +    endif
> > +    if have_inotify_init1
> > +      have_inotify_init1 =3D inotify.found()
> > +    endif
> >    endif
> >  endif
> >  config_host_data.set('CONFIG_INOTIFY', have_inotify_init)
>
> So this ends up woth 'inotify =3D=3D not_found' with either Linux,
> or latest FreeBSD 15.
>

yes. And that turns out to be fine...


> Over in util/meson.build though we have
>
>     freebsd_dep =3D []
>     if host_os =3D=3D 'freebsd'
>       freebsd_dep =3D inotify
>     endif
>     util_ss.add(files('filemonitor-inotify.c'), freebsd_dep)
>
> Which seems to be trying to avoid adding "not_found" to the dep list.
>
> Either it is safe to add "not_found" to the dep list, and this code in
> util/meson.build can be simplified to just:
>
>     util_ss.add(files('filemonitor-inotify.c'), [inotify])
>

I don't think we need the [] here. It works without them on both FreeBSD 14
and 15. I tested on FreeBSD 14 with and without libinotify installed as
well, and both work


> or it is unsafe, and this code needs to be modified to look more like:
>
>     inotify_deps =3D []
>     if inotify.found()
>       inotify_deps =3D [inotify]
>     endif
>     util_ss.add(files('filemonitor-inotify.c'), inotify_deps)
>
>
> Assuming you've tested your patch here successfully, then it seems like
> the former case is valid, and we can simplify util/meson.dep to remove
> the conditional ?
>

That's a nice simplification. I've played around a bit to simplify things a
little
elsewhere as well. I'll send a v2 here in a few monites.

Warner

--000000000000a66a4c064a7c5602
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 10,=
 2026 at 8:54=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Tue, Feb 10, 2026 at 08:43:48AM -070=
0, Warner Losh wrote:<br>
&gt; Check to make sure that we have inotify in libc, before looking for it=
<br>
&gt; in libinotify.<br>
&gt; <br>
&gt; Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D=
"_blank">pbonzini@redhat.com</a>&gt;<br>
&gt; Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redh=
at.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; Cc: Daniel P. Berrange &lt;<a href=3D"mailto:berrange@redhat.com" targ=
et=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt; Cc: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.or=
g" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt; FreeBSD 15 and newer now has a native inotify implementation. Check fo=
r<br>
&gt; it before checking for the wrapper libinotify library which is needed =
in<br>
&gt; FreeBSD 14 and earlier. Make the check dependent on symbols, not host<=
br>
&gt; version.<br>
&gt; <br>
&gt; Separate series because it&#39;s really independent of the two other<b=
r>
&gt; patch series I have submitted and it is more important.<br>
&gt; ---<br>
&gt;=C2=A0 meson.build | 16 +++++++++-------<br>
&gt;=C2=A0 1 file changed, 9 insertions(+), 7 deletions(-)<br>
&gt; <br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index 2d114e9018..537f50283f 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -2662,13 +2662,15 @@ have_inotify_init =3D cc.has_header_symbol(&#3=
9;sys/inotify.h&#39;, &#39;inotify_init&#39;)<br>
&gt;=C2=A0 have_inotify_init1 =3D cc.has_header_symbol(&#39;sys/inotify.h&#=
39;, &#39;inotify_init1&#39;)<br>
&gt;=C2=A0 inotify =3D not_found<br>
&gt;=C2=A0 if (have_inotify_init or have_inotify_init1) and host_os =3D=3D =
&#39;freebsd&#39;<br>
&gt; -=C2=A0 # libinotify-kqueue<br>
&gt; -=C2=A0 inotify =3D cc.find_library(&#39;inotify&#39;)<br>
&gt; -=C2=A0 if have_inotify_init<br>
&gt; -=C2=A0 =C2=A0 have_inotify_init =3D inotify.found()<br>
&gt; -=C2=A0 endif<br>
&gt; -=C2=A0 if have_inotify_init1<br>
&gt; -=C2=A0 =C2=A0 have_inotify_init1 =3D inotify.found()<br>
&gt; +=C2=A0 if not cc.has_function(&#39;inotify_init&#39;) and not cc.has_=
function(&#39;inotify_init1&#39;)<br>
&gt; +=C2=A0 =C2=A0 inotify =3D cc.find_library(&#39;inotify&#39;)<br>
&gt; +=C2=A0 =C2=A0 # libinotify-kqueue<br>
&gt; +=C2=A0 =C2=A0 if have_inotify_init<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 have_inotify_init =3D inotify.found()<br>
&gt; +=C2=A0 =C2=A0 endif<br>
&gt; +=C2=A0 =C2=A0 if have_inotify_init1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 have_inotify_init1 =3D inotify.found()<br>
&gt; +=C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_INOTIFY&#39;, have_inotify_init=
)<br>
<br>
So this ends up woth &#39;inotify =3D=3D not_found&#39; with either Linux,<=
br>
or latest FreeBSD 15.<br></blockquote><div><br></div><div>yes. And that tur=
ns out to be fine...</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
Over in util/meson.build though we have<br>
<br>
=C2=A0 =C2=A0 freebsd_dep =3D []<br>
=C2=A0 =C2=A0 if host_os =3D=3D &#39;freebsd&#39;<br>
=C2=A0 =C2=A0 =C2=A0 freebsd_dep =3D inotify<br>
=C2=A0 =C2=A0 endif<br>
=C2=A0 =C2=A0 util_ss.add(files(&#39;filemonitor-inotify.c&#39;), freebsd_d=
ep)<br>
<br>
Which seems to be trying to avoid adding &quot;not_found&quot; to the dep l=
ist.<br>
<br>
Either it is safe to add &quot;not_found&quot; to the dep list, and this co=
de in<br>
util/meson.build can be simplified to just:<br>
<br>
=C2=A0 =C2=A0 util_ss.add(files(&#39;filemonitor-inotify.c&#39;), [inotify]=
)<br></blockquote><div><br></div><div>I don&#39;t think we need the [] here=
. It works without them on both FreeBSD 14 and 15. I tested on FreeBSD 14 w=
ith and without libinotify installed as well, and both work</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
or it is unsafe, and this code needs to be modified to look more like:<br>
<br>
=C2=A0 =C2=A0 inotify_deps =3D []<br>
=C2=A0 =C2=A0 if inotify.found()<br>
=C2=A0 =C2=A0 =C2=A0 inotify_deps =3D [inotify]<br>
=C2=A0 =C2=A0 endif<br>
=C2=A0 =C2=A0 util_ss.add(files(&#39;filemonitor-inotify.c&#39;), inotify_d=
eps)<br>
<br>
<br>
Assuming you&#39;ve tested your patch here successfully, then it seems like=
<br>
the former case is valid, and we can simplify util/meson.dep to remove<br>
the conditional ?<br></blockquote><div><br></div><div>That&#39;s a nice sim=
plification. I&#39;ve played around a bit to simplify things a little</div>=
<div>elsewhere as well. I&#39;ll send a v2 here in a few monites.</div><div=
><br></div><div>Warner</div></div></div>

--000000000000a66a4c064a7c5602--

