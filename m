Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B923CFF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 15:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGfHY-0007sN-IG; Sat, 25 Apr 2026 11:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wGfHW-0007rx-Gd
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:50:58 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wGfHU-0000ho-6R
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:50:58 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64eaf8aa893so7193556d50.3
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 08:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777132255; cv=none;
 d=google.com; s=arc-20240605;
 b=YfQM895bXM+jOKnsUcOR7N4E+NhBJdRXhewUIERVzxBW3+mJaYlTf+pYYGtbAjLAHR
 kjXEW75LsyJ54ZHs7ptBiqxek5q/hJIVB36k4P+suPLUvoyUiOHOTZaiEU8mJWRsp6el
 EwZgzsfivpkyimSOsuTGexyp98H7FnUN3fgFs7Cjw9jAfLON0YkVQTnPRJfaA2buD0+6
 xbKd5rg2uceEDI9Cg6CMG0dQ2PDVpl1rEubZwtMu4MCRaFqRPXjf57kFVeJB7gMyUMl0
 F1VxMOY0Io49zEI8+QhtRZFPD/5ZPUCzl7056oNyHmhZ35AzY3ZsyHw2KZNkzu372i+Y
 DhSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VN+I/oYRXtQYVeOYXQe951JM8kxDzhFlEydwAG0o/FA=;
 fh=drSQbzwiT136Hv3I1ar5t/+ziT5vHvg0OV3ka/C/2MQ=;
 b=f3Nt3f5E+5lLEWXioXBfed1iceqxpjtOqFuLY4/RcWKGeva6g/TOGlBYNOHGXzUcc5
 gUJaCS4wsngYbm3vtKJWDLf8Zoqi39RU4k2olYg1hVj6DuEjZHG05Y7mYiSVQ3T0NovS
 +rzIOgxPlGVyG0neBz3epjUVM1SluRqjT/7gnBG8fIbEH3oMrIiRPSbKmwP1dZUhMAvN
 rzJYuGR8LsNz2p7isb/WlwEzB+K6cYJahwsWUHOf5RtQJ3QO+3k+DOQPsxCFxdZReNt1
 HU+Hv2jNR67HbmksFLY93yIVyxoBhc3j35N8ggmB3aQMcpjrWGKt2P6kewtIsrsKjCj3
 QQGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777132255; x=1777737055;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VN+I/oYRXtQYVeOYXQe951JM8kxDzhFlEydwAG0o/FA=;
 b=sixcttaoS3zovj0TLtC7grQ9AkU5skuHbUN+FRgRAzChBmxzhJmKMswqsSj2ROsCC2
 +RiMpA9qXwafEUgLF0vJVAT2NNpGj8mzxkME9asaBOWKjwmV75Wsamw3SPK1cJwoWZXm
 wSVXrEA2jqbwGgxgWpmr/++9ATD/6TplSf0biVdBlIzReKQ41o4mT/HmI4Ozpzwix3Yb
 Bk15QEzlq08XDIPxAXRHuE4whHaSuwZ7hL55YlQEsZ8itgthHK9q/eyahkSieweBhJ3k
 QWKQLUUM/ngNcd/g10chM73mAQfKy7p8XdPRSZxnSnpv/l0ip+uX3KiX+aMLOA1GkmfC
 +KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777132255; x=1777737055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VN+I/oYRXtQYVeOYXQe951JM8kxDzhFlEydwAG0o/FA=;
 b=VONqfbwbEE230gg+t1SK63eaElsEqYraphxm7dEfjDo+2G5xQDwJ3jZqguGixubBEJ
 nH+CtCzVlTAqPDzL0zttlPkQtm+iLOD9DO3szKn3g50X4wlu6YJYf+HJxJ+SCVsKJNMR
 xqXyTuHLQdxBtPMs6nxPKxPc8fs1ffU8iU8lALUlIXwluQ6GZf4v2XjOsv2V3Rr7c6KC
 f2vK4Lb+fkokh/FIsfuR0yTdbD5cawPvSOvot6kWDZn8HxxNxR01wzhX1K8EQ/gm2dul
 l5ofP5ESX2LZOP+6XkcvUGtEhwpXeiuy7p/r714BOGAs3D4WW2OsHzA+C6SqsH+a2Jau
 hAgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zdqvSof8nS4CxZuCacYJ83C1qUSDn1OQbVdVeOr78AF/OCGxHdhVLzKUet60LvGYcn4sX5mVpiRnh@nongnu.org
X-Gm-Message-State: AOJu0YxDWFxsqEfD723y1fB7dT6fHyVgJDDvgMIC6WceP+eanUyD7Viq
 IOum5Ce8K965NRUmEGB3OH2xu7wkDoqrSz0gwYMWD73cdwDTqWziT6lCPndPCNa/OJT8TQER8kL
 gl9lduYsj+UW6pmMGXz4TEV2BjHuB/HtaiYpSA4Mk4w==
X-Gm-Gg: AeBDietvMwEVkoVSlTQ8RB+2fy3ajW5zXqbJvmQfSnQpFUxcaupE4q0jRV/I7iHEb/i
 3jTkqZruaI4MGPHuM+xK+iB1if2plsrgl9dIEokOMmzA6gc6GlejNcTVLlXK7dh0gBTfX26rOWU
 Eb1cPazR5a4ibN6ZQcMGD6Cz9RhXtYl7b5Fr/e2Y6csB7/YSdXp54mP2MOTzV7Vp9Bzyxdcb6sj
 S2OYoQaf03M9ly8hS4ZhYtqprdy2xBswAAC+3McFjJXBxJpN4Flk/R5vFpx8FgRTzVGeOCpG/c3
 s57INpi3VjH6n2Hzs5x+P2igg+FgqJO3k0J8gc2068BGx6A=
X-Received: by 2002:a05:690e:e81:b0:64a:cf12:7a0d with SMTP id
 956f58d0204a3-65310b5d559mr34427499d50.60.1777132254856; Sat, 25 Apr 2026
 08:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260425144852.46590-1-deller@kernel.org>
 <CANCZdfoOPvn0JJiF5Nar_UNEWMzmQCvEiTKV1vbuVFy2qiMpfQ@mail.gmail.com>
 <d54586b6-8213-48e7-9e7e-2c966948872d@gmx.de>
In-Reply-To: <d54586b6-8213-48e7-9e7e-2c966948872d@gmx.de>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 25 Apr 2026 09:50:43 -0600
X-Gm-Features: AQROBzDO3n-vdu5ZXCrsRWZWreLauj1y2PdtkTFFZLHiAWPQceCsDN8xc2R55Y0
Message-ID: <CANCZdfqa2XU9OHt3kJATkaU2D+g2=afRdjNvYE0o6Hx8YvFy0g@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Flush errors by using exit() instead of
 _exit() in error path
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000c512e606504ad89f"
Received-SPF: none client-ip=2607:f8b0:4864:20::b132;
 envelope-from=wlosh@bsdimp.com; helo=mail-yx1-xb132.google.com
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

--000000000000c512e606504ad89f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[[ Oops, my last message cc'd Pierrick's old address, maybe my tree is old
or it needs to update in MAINTAINERS ]]

On Sat, Apr 25, 2026 at 9:17=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:

> On 4/25/26 17:02, Warner Losh wrote:
> >
> >
> > On Sat, Apr 25, 2026 at 8:50=E2=80=AFAM Helge Deller <deller@kernel.org=
 <mailto:
> deller@kernel.org>> wrote:
> >
> >     From: Helge Deller <deller@gmx.de <mailto:deller@gmx.de>>
> >
> >     Qemu user mode does not properly flushes error messages related to
> bad
> >     arguments when exiting (at least when the output is piped to a file
> >     instead of running on a terminal).
> >     Ensure that we always flush by using exit() instead of _exit().
> >
> >     Reported by: Tobias Bergkvist
> >     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2544 <
> https://gitlab.com/qemu-project/qemu/-/work_items/2544>
> >     Signed-off-by: Helge Deller <deller@gmx.de <mailto:deller@gmx.de>>
> >     ---
> >       linux-user/main.c | 2 +-
> >       1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >
> > Reviewed-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
>
> Thanks!
>
> > Note: I've added the linux-user maintainers to the CC list for
> visibility.
>
> Ok.
>
> > bsd-user has the same problem.
> I hesitate to change things I don't not test at all :-(
>

I can, since I do a lot with bsd-user.


> Even this patch here is not widely tested, but I think we need to add it.
> If things break we see reports anyway.
>

I don't think this will break anything. The printf can't possibly work,
either
we must change it to a write or do the exit. exit is done everywhere else.
This has been wrong since:

commit 03cfd8faa7ffb7201e2949b99c2f35b1fef7078b
Author: Laurent Vivier <laurent@vivier.eu>
Date:   Fri Aug 30 01:46:44 2013 +0200

    linux-user: add support of binfmt_misc 'O' flag
...
+    if (execfd < 0) {
+        printf("Error while loading %s: %s\n", filename,
strerror(-execfd));
+        _exit(1);
+    }
...
but the full commit log doesn't say why.  Laaurent was one of the people I
cc'd before
I chased this back to this commit. :).

I'll go ahead and make the bsd-user/main.c change (the error message is a
little different, and there's
a pull request against the bsd-user upstream I need to land in the area
around it, IIRC).

Warner

--000000000000c512e606504ad89f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div>[[ Oops, my last message cc&#39=
;d Pierrick&#39;s old address, maybe my tree is old or it needs to update i=
n MAINTAINERS ]]<div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Sat, Apr 25, 2026 at 9:17=E2=80=AFA=
M Helge Deller &lt;<a href=3D"mailto:deller@gmx.de">deller@gmx.de</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 4/25/26=
 17:02, Warner Losh wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Sat, Apr 25, 2026 at 8:50=E2=80=AFAM Helge Deller &lt;<a href=3D"ma=
ilto:deller@kernel.org" target=3D"_blank">deller@kernel.org</a> &lt;mailto:=
<a href=3D"mailto:deller@kernel.org" target=3D"_blank">deller@kernel.org</a=
>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0From: Helge Deller &lt;<a href=3D"mailto:deller@gmx=
.de" target=3D"_blank">deller@gmx.de</a> &lt;mailto:<a href=3D"mailto:delle=
r@gmx.de" target=3D"_blank">deller@gmx.de</a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Qemu user mode does not properly flushes error mess=
ages related to bad<br>
&gt;=C2=A0 =C2=A0 =C2=A0arguments when exiting (at least when the output is=
 piped to a file<br>
&gt;=C2=A0 =C2=A0 =C2=A0instead of running on a terminal).<br>
&gt;=C2=A0 =C2=A0 =C2=A0Ensure that we always flush by using exit() instead=
 of _exit().<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Reported by: Tobias Bergkvist<br>
&gt;=C2=A0 =C2=A0 =C2=A0Resolves: <a href=3D"https://gitlab.com/qemu-projec=
t/qemu/-/work_items/2544" rel=3D"noreferrer" target=3D"_blank">https://gitl=
ab.com/qemu-project/qemu/-/work_items/2544</a> &lt;<a href=3D"https://gitla=
b.com/qemu-project/qemu/-/work_items/2544" rel=3D"noreferrer" target=3D"_bl=
ank">https://gitlab.com/qemu-project/qemu/-/work_items/2544</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Helge Deller &lt;<a href=3D"mailto:d=
eller@gmx.de" target=3D"_blank">deller@gmx.de</a> &lt;mailto:<a href=3D"mai=
lto:deller@gmx.de" target=3D"_blank">deller@gmx.de</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0linux-user/main.c | 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-=
)<br>
&gt; <br>
&gt; <br>
&gt; Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=
=3D"_blank">imp@bsdimp.com</a> &lt;mailto:<a href=3D"mailto:imp@bsdimp.com"=
 target=3D"_blank">imp@bsdimp.com</a>&gt;&gt;<br>
<br>
Thanks!<br>
<br>
&gt; Note: I&#39;ve added the linux-user maintainers to the CC list for vis=
ibility. <br>
<br>
Ok.<br>
<br>
&gt; bsd-user has the same problem.<br>
I hesitate to change things I don&#39;t not test at all :-(<br></blockquote=
><div><br></div><div>I can, since I do a lot with bsd-user.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Even this patch here is not widely tested, but I think we need to add it.<b=
r>
If things break we see reports anyway.<br></blockquote><div><br></div><div>=
I don&#39;t think this will break anything. The printf can&#39;t possibly w=
ork, either</div><div>we must change it to a write or do the exit. exit is =
done everywhere else.</div><div>This has been wrong since:</div><div><br></=
div><div>commit 03cfd8faa7ffb7201e2949b99c2f35b1fef7078b<br>Author: Laurent=
 Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</a>&gt;<=
br>Date: =C2=A0 Fri Aug 30 01:46:44 2013 +0200<br><br>=C2=A0 =C2=A0 linux-u=
ser: add support of binfmt_misc &#39;O&#39; flag<br></div><div>...</div><di=
v>+ =C2=A0 =C2=A0if (execfd &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0print=
f(&quot;Error while loading %s: %s\n&quot;, filename, strerror(-execfd));<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0_exit(1);<br>+ =C2=A0 =C2=A0}<br></div><div>=
...</div><div>but the full commit log doesn&#39;t say why.=C2=A0 Laaurent w=
as one of the people I cc&#39;d before</div><div>I chased this back to this=
 commit. :).=C2=A0</div><div><br></div><div>I&#39;ll go ahead and make the =
bsd-user/main.c change (the error message is a little different, and there&=
#39;s</div><div>a pull request against the bsd-user upstream I need to land=
 in the area around it, IIRC).</div><div><br></div><div>Warner</div></div><=
/div></div>

--000000000000c512e606504ad89f--

