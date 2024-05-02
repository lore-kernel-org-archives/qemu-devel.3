Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006CEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 14:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Xir-0007XT-AW; Thu, 02 May 2024 10:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1s2Xig-0007V2-0V
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:47:35 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1s2Xic-0005qL-Hg
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:47:33 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5966ea4fafso181065866b.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1714661247; x=1715266047;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GCyA64rI17HZlRh09aqKxT+GaDvp1azIYtE1IY4FfgA=;
 b=f5Mx8J7lFLmkXMsLE3uP8vayf1Nl5ANXJgcoo6rXIP7sRDZQ0q+fMWkzXN0kkQnd4x
 YiQLV3WGKPQ597ZHQx6muOfk47c3hrI2U3+qLgb+TAd5Fh1+KT5LDetcjUu/1+NvrDgE
 fxaKtc3Nf71xO3eGMWWud7qR178HgxCAxKb0tauP5r47Sb7cEGiNi16i0sKtWzbIKf0c
 dXsgTDNAXPdqdsi4DUJ2zEKlIkHv4tOjOGOVDxMTtp7uyE+Fa2N89sA2VlaAsyzatNkd
 YKgbhdTyxjCHPcnNaRgib6V5FKeCOnwJzQu/NhtYc4lJNiJe+7uSMa05SvHp2wlyVfJr
 Gvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714661247; x=1715266047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GCyA64rI17HZlRh09aqKxT+GaDvp1azIYtE1IY4FfgA=;
 b=SxIK74cpsFQAdq+wjNyIQe1qca+4M5IvOyVy2jXHKyBMsERnBLhJkn6xNIirkSl0aO
 Uu0V3WlbvP9/aWbwORnE9Rwqepq4tm3IrmbClJWsOtj9vV9ZwS0kBmbxIg59+7pkTwqa
 m+4eIJgBN4wIwlbVJYGnjEfIYWg11OAxkVHIdXlFGEIxJ7XAcmsi824oHB7w0hdOwswY
 yXvdTfI4LU5EKGJOtDxllgPzo9HN3ynpwkiQaRKB5etokoR47b104Origsw4Ncti8oCR
 e3ntiAxVjgt81KAGKp4RnwgM5S7Ga8Ek852K2Adza+DCOaacDqBx8gORaqhH0TvbsBSg
 QX5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtFHTGYpxL9rwRILqo+yL6IZrWWm5axYFnYpA252EmXYhrb1N5myT7uMC7yB+yW/2KKc5cpC+NcDyRrrIeUQvoIXuyooA=
X-Gm-Message-State: AOJu0Yzkp1xJ5JxWggIUtdQPlr9mrj9ZWrmsQS5BFxH0iI6+sKQtJtY4
 Qkh82ikkL6GKvlqVz8GOC33dCvFkkwJHMy6RMxC2Rsml2x1ls3mxR+Niv9jy+l0/RJgxEVEXuql
 bWeSpsvqG7tfdSNHAw3Xdaeo9HBvS/zjNC7g4gA==
X-Google-Smtp-Source: AGHT+IEo9Xpn0k+s4Aa7+8/boyN8A+VOkfgA6y3BBplUxA3eWyNCtq+X2TYYRqe2I0AQ8JXPLGUyLv4xU5b9a0CJBgw=
X-Received: by 2002:a17:907:6012:b0:a59:8203:d5c3 with SMTP id
 fs18-20020a170907601200b00a598203d5c3mr105323ejc.1.1714661246915; Thu, 02 May
 2024 07:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGAQeq+Wu9wiBj+tF0PJHMZS-F4KnVBOXCyXhYQsm+REyLUpg@mail.gmail.com>
 <e04bd44b-8a91-48c0-9fbf-223d1b28e7cd@redhat.com>
In-Reply-To: <e04bd44b-8a91-48c0-9fbf-223d1b28e7cd@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 2 May 2024 08:47:15 -0600
Message-ID: <CANCZdfo-YFs+A_oW55qE6U4GdbHz7GaeqNqGofK2jgk+Y=L4SA@mail.gmail.com>
Subject: Re: QEMU headers in C++
To: Thomas Huth <thuth@redhat.com>
Cc: Roman Kiryanov <rkir@google.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>
Content-Type: multipart/alternative; boundary="000000000000886dae061779aea6"
Received-SPF: none client-ip=2a00:1450:4864:20::62e;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62e.google.com
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

--000000000000886dae061779aea6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 12:20=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 02/05/2024 06.40, Roman Kiryanov wrote:
> > Hi QEMU,
> >
> > I work in Android Studio Emulator and we would like to develop devices
> > in C++. Unfortunately, QEMU headers cannot be used with C++ as is
> > (e.g. they use C++ keywords as variable names or implicitly cast void*
> > to T*).
>
> Can't you simply use something like:
>
> extern "C" {
> #include <foo.h>
> }
>
> to include the QEMU headers?
>

No.

All that does is not mangle the functions and requires that none of them be
overloaded.
It doesn't otherwise change the language that you're compiling, so the
implicit casts
from void * to T * are still verboten. It also doesn't change the keywords
that are accepted.

I'm not in the main line of qemu development, but I'll share what FreeBSD
has done in
this area. We've bracketed the functions in our .h files with __BEGIN_DECLS
/ __END_DECLS
which are defined away in C but not C++ (to allow it to turn into extern
"C" { and } respectively).
We avoid C++ keywords (mostly the word class). Our headers don't have a lot
of inlines in them,
but the few that do we'll make sure they don't have the implicit casts
(though the style we inherited
from CSRG / Research Unix was to always cast). For FreeBSD, we have about a
dozen different
compilation environments that we need to work in, so we also have a bunch
of other macros that
let us use newer C features in headers, but that make them disappear when
someone is building
a pure C90 program. These are quite a bit more intrusive, imho, but still
not bad. So maybe that
context might explain why my initial reaction was "oh, that's not too bad".

If you didn't want to do the __BEGIN_DECLS / __END_DECLS dance (which isn't
a super unreasonable
position), then avoiding keywords is easy enough and usually unobtrusive...
but the implicit cast bits
might be harder to deal with if there's a lot of code that does it.

The hardest part for us has been keeping things working with C++. Though
90% of it naturally is tested
in building FreeBSD because we have just enough C++ that's old-school
enough to include many of
the system headers :). QEMU would need to test it, and that might otherwise
require a C++ compiler
for some builds that wouldn't need one today.

I don't know if the main line developers would be willing to pay this "tax"
or not. I'm not advocating
either way, per se, but would suggest that if the tax is super low and the
benefit to others high, I'd
go for it. In the absence of the scope of the patches, though, it's hard to
say of this amount of C++
would enable more technology than it inhibits by being a drag on future
development.

Warner

--000000000000886dae061779aea6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 2, 2024 at 12:20=E2=80=AF=
AM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 0=
2/05/2024 06.40, Roman Kiryanov wrote:<br>
&gt; Hi QEMU,<br>
&gt; <br>
&gt; I work in Android Studio Emulator and we would like to develop devices=
<br>
&gt; in C++. Unfortunately, QEMU headers cannot be used with C++ as is<br>
&gt; (e.g. they use C++ keywords as variable names or implicitly cast void*=
<br>
&gt; to T*).<br>
<br>
Can&#39;t you simply use something like:<br>
<br>
extern &quot;C&quot; {<br>
#include &lt;foo.h&gt;<br>
}<br>
<br>
to include the QEMU headers?<br></blockquote><div><br></div><div>No.</div><=
div><br></div><div>All that does is not mangle the functions and requires t=
hat none of them be overloaded.</div><div>It doesn&#39;t otherwise change t=
he language that you&#39;re compiling, so the implicit casts</div><div>from=
 void * to T * are still verboten. It also doesn&#39;t change the keywords =
that are accepted.</div><div><br></div><div>I&#39;m not in the main line of=
 qemu development, but I&#39;ll share what FreeBSD has done in</div><div>th=
is area. We&#39;ve bracketed the functions in our .h files with __BEGIN_DEC=
LS / __END_DECLS</div><div>which are defined away in C but not C++ (to allo=
w it to turn into extern &quot;C&quot; { and } respectively).</div><div>We =
avoid C++ keywords (mostly the word class). Our headers don&#39;t have a lo=
t of inlines in them,</div><div>but the few that do we&#39;ll make sure the=
y don&#39;t have the implicit casts (though the style we inherited</div><di=
v>from CSRG / Research Unix was to always cast). For FreeBSD, we have about=
 a dozen different</div><div>compilation environments that we need to work =
in, so we also have a bunch of other macros that</div><div>let us use newer=
 C features in headers, but that make them disappear when someone is buildi=
ng</div><div>a pure C90 program. These are quite a bit more intrusive, imho=
, but still not bad. So maybe that</div><div>context might explain why my i=
nitial reaction was &quot;oh, that&#39;s not too bad&quot;.<br></div><div><=
br></div><div>If you didn&#39;t want to do the __BEGIN_DECLS / __END_DECLS =
dance (which isn&#39;t a super unreasonable</div><div>position), then avoid=
ing keywords is easy enough and usually unobtrusive... but the implicit cas=
t bits</div><div>might be harder to deal with if there&#39;s a lot of code =
that does it.</div><div><br></div><div>The hardest part for us has been kee=
ping things working with C++. Though 90% of it naturally is tested</div><di=
v>in building FreeBSD because we have just enough C++ that&#39;s old-school=
 enough to include many of</div><div>the system headers :). QEMU would need=
 to test it, and that might otherwise require a C++ compiler</div><div>for =
some builds that wouldn&#39;t need one today.</div><div><br></div><div>I do=
n&#39;t know if the main line developers would be willing to pay this &quot=
;tax&quot; or not. I&#39;m not advocating</div><div>either way, per se, but=
 would suggest that if the tax is super low and the benefit to others high,=
 I&#39;d</div><div>go for it. In the absence of the scope of the patches, t=
hough, it&#39;s hard to say of this amount of C++</div><div>would enable mo=
re technology than it inhibits by being a drag on future development.<br></=
div><div><br></div><div>Warner<br></div></div></div>

--000000000000886dae061779aea6--

