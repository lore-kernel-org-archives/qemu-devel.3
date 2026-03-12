Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C75106ACE5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 20:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0mVY-0006N5-KZ; Thu, 12 Mar 2026 16:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w0mVW-0006Mw-Qu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:19:46 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w0mVU-00082u-Ss
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:19:46 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35a08ce49dcso1313330a91.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 13:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773346783; cv=none;
 d=google.com; s=arc-20240605;
 b=Z8cEeR5hdjWVG4Y2cG/PW3IhYLgDY07LLnQgl2gNFSxdz8oj+Z0iyu5wpGUz/0hWpI
 7r9h65amDKPh5J3LIR2ulbjVfByOKSUnxyKsjiOCoFlq42eQAi6tnzYsyGVRC59xXPZx
 5V0gwRRH8M715mNRs3V7JD88mlvLXaUbYfl50iGSXDF93RMiCFkvrVkwgADFQxpwj98l
 mZSm7uXdISsLzAvycpoTiaOatCt2lf0274+qtWH3uyfzn8yrjfse9n1V9Qtn5I2PFlzU
 HTWKZmxws/duM2xVztb2erndheV6pKn/xNm23rJQ0Ja8yl92O9sNlrXBq1giyDy+WneU
 StUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9SY9zTO8ulP/nNqkYrzNQFw7y0T6U6G+bXtCK62Qjts=;
 fh=uZjA6eME2UYXWQGU+EK8sRcWyZEOpV51D9lL83dayHw=;
 b=YdX1cbDJjrPY0vwhxGWHomAy/uhjmuxaCMuNpSiGIuyilALp0XfVHIe+Azv78/O2UA
 CZST5/Xmk05rtnV90u91baeLRF2qBNK+urUkO7ioieYySrKmxOIbbU5pFFtdkKh0JVVn
 9CSKuQRrVRAHA+htBw2Und4HN16XgnUQIdwoiGvL8NEXEK9su+o2EZugG3mAhCcjsuBR
 +bhT+B5GEBaEI7/GeIJ+oYxALGPLLfCweiHTK8KAohfazAcUmne2NEmvHqS7BEE34V2r
 BQapAuFifoNy5nuI7YKxAhiLWGlrNvJsXf8qayZTmTYTkmm8uFnRU1rK0pWwRMrdZO0J
 7jyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1773346783; x=1773951583;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9SY9zTO8ulP/nNqkYrzNQFw7y0T6U6G+bXtCK62Qjts=;
 b=wdgi4NvtRT891HOMtBjvrtvCsSEXV7/UlkcepWdG8Yx7leFraRPm8g3Ki10GuS/F0I
 CG0PKXlcfGbyBIkgYctL8X2ZEeinVJT3WTrH8LUNyD1MtqfFBW6/CghCE6X5a8Wo94oE
 HiEClNX8nGhRpSWGIIlkMQcqzuFM7ZB+eybegOPjm8XOOMC2/ApHjMGHkVLavl4hR8xe
 TnpYjvOIL9uwihodWdl+rESidAhbLGyRkEttBI8Mnhow0M20xK4Z8vcsbgkPAO87TWlJ
 0Ryqmzvb4rIqcLF8CsZtpIFdjIAHeai42NQIAdn0Mnn/DYTSuwouTzgQuZP6CU1A9VEw
 c4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773346783; x=1773951583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SY9zTO8ulP/nNqkYrzNQFw7y0T6U6G+bXtCK62Qjts=;
 b=UmDttIxY+GGRpmeaoE1ku3GDV0ZElVli5Vs531QTeJY/NApvKs5W8NIImB/O4aw2Sn
 6Mni+nEcBmKRL+8T07buScaGvrcdlj6CS34PCk3TN+tciOgNuSaF/481gewt++7tqOHY
 4fn7kKs3TushChEdJwR0I0ytWkLBB+JCCNBysFGv40AvIS6YBrmo2XMCO2yiks157vip
 9UDtZ3MWTOdtXVKd0fkW2H2VeA0VTEjAoX6weacmL4zn5Z40dSWFqdjn09zDUHq44Jw9
 RVwkV7TlrrZwmBkRYwSYPGGZHJTzJcmbLkdVxlLMe4Rx1ezx9g2SxcAB0/fCoGjPBLfq
 qy5g==
X-Gm-Message-State: AOJu0Yzwh1eNFBFsXlGs+7PT8Bt1IZXj9UIu8y/j7P73Yt2DmZAp+TEU
 0JFbcxh4B1M/E34NjJktRm/c+y8i0voPCsX1LedyjVQSiwrnZVij/IPfKMkD/0pPq+bo6SAhBm9
 9vAryVVGtV1MPafoV775QwRLkmZru9f6E8NxlvuIslA==
X-Gm-Gg: ATEYQzw4Y3/w/8bUWMcqmVMVZApA3ME6HrW6CiqqpxgRNeMhQo9QFhb2LJWWWcI08NE
 j6V72v+uyvkYq7PxVe96jFvHwRMFVj4wvjvbYohZB52XQw4ziW3w0OoUP/Uh35jtShB4s4RTzPc
 xhPULsq2RZlyQZpBtP+vP5OgGPlX1rJ6c0zs/OzzYsvaGTu+MmFKWYudkPpdjmtoprmcb/VXJfT
 m7X+EyHBZlZ0qOgb7Bs2qyE6l1cdiydc3EAVPhgI5KfNrXmepxBspSc3x9i6M3mQeDSXKXD9T6I
 Q80Y1Vc=
X-Received: by 2002:a17:90b:1d08:b0:359:877:370f with SMTP id
 98e67ed59e1d1-35a2206402amr812845a91.17.1773346783325; Thu, 12 Mar 2026
 13:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com>
 <ffc224cc-72ed-49ee-93ea-8a28d220ae55@linaro.org>
In-Reply-To: <ffc224cc-72ed-49ee-93ea-8a28d220ae55@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 12 Mar 2026 14:19:32 -0600
X-Gm-Features: AaiRm50v707pwy0WBvWRbcr0qdtF_v34YgMSlaj04R2C3o2bXMwKFVsj3OHuBf8
Message-ID: <CANCZdfo8cEp8_078o4bEwCo63vL+W5NW9ukeQR0nMACJBQXysw@mail.gmail.com>
Subject: Re: [PATCH RFC] common-user: Share thunk.c between bsd-user and
 linux-user
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000157f08064cd979ce"
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1034.google.com
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

--000000000000157f08064cd979ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 11:52=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@linaro.org> wrote:

> On 3/12/26 6:10 AM, Warner Losh wrote:
> > thunk.c is the same between linux-user and bsd-user (out of tree),
> > so share it between the two.
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> > As part of upstream blitz bsd-user, I've discovered that bsd-user and
> > linux-user have the same thunk.c file. Rather than copy it, put it into
> > the common-user directory and share it. It has to be compiled
> > per-target, unlike the rest of common-user, so modify linux-user and
> > bsd-user to grab it from there.
> > ---
> >   bsd-user/meson.build                | 1 +
> >   {linux-user =3D> common-user}/thunk.c | 0
> >   linux-user/meson.build              | 2 +-
> >   3 files changed, 2 insertions(+), 1 deletion(-)
> >
>
> Indeed, thunk.c seems to be highly target specific.
> A good solution would be to move common functions to common-user/thunk.c
> and the rest in include/user/thunk.h. It may be cleaner than doing the
> meson hack. Or leave it duplicated for now, except if you plan on
> modifying it.
>

My concern with leaving it duplicated is the process. I create a patch to
create
bsd-user/thunk.c that's a verbatim copy of linux-user/thunk.c. Despite
putting in
my cover that this is copied code, if past is prologue, then I'll be asked
to fix the
copyright and style, plus lots of suggestions to improve the code. But it's
just a
verbatim copy, so that's a lot of hassle just to copy it.

Moving like this, though, is almost 0 friction. A small tweak to meson is
all that's
needed. I suppose I could do the #include "../linux-user/trunk.c" trick to
make it
less ugly in the build system, but then it's not clear it's shared, etc and
more ugly
in the code, imho.

I tried to move this stuff into thunk.h as much as possible so we could
have one
compilation, and that didn't work. It really assumes that it can include
qemu.h for
the tswap, etc macros. So it's impossible to just build once.

Now looking at the code, a lot of it would be a lot simpler with 'Generic',
but that's
a battle for another day. As is the notion of just generating this data
from the .h files
rather than hard-coding it here, but that too is a battle for another day.
I'd like to
get this upstreamed so I'm spending my time on these sorts of battle.s

Warner

--000000000000157f08064cd979ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12,=
 2026 at 11:52=E2=80=AFAM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.b=
ouvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On 3/12/26 6:10 AM, Warner Lo=
sh wrote:<br>
&gt; thunk.c is the same between linux-user and bsd-user (out of tree),<br>
&gt; so share it between the two.<br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt; As part of upstream blitz bsd-user, I&#39;ve discovered that bsd-user =
and<br>
&gt; linux-user have the same thunk.c file. Rather than copy it, put it int=
o<br>
&gt; the common-user directory and share it. It has to be compiled<br>
&gt; per-target, unlike the rest of common-user, so modify linux-user and<b=
r>
&gt; bsd-user to grab it from there.<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 1 +<br>
&gt;=C2=A0 =C2=A0{linux-user =3D&gt; common-user}/thunk.c | 0<br>
&gt;=C2=A0 =C2=A0linux-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 =C2=A03 files changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
<br>
Indeed, thunk.c seems to be highly target specific.<br>
A good solution would be to move common functions to common-user/thunk.c <b=
r>
and the rest in include/user/thunk.h. It may be cleaner than doing the <br>
meson hack. Or leave it duplicated for now, except if you plan on <br>
modifying it.<br></blockquote><div><br></div><div>My concern with leaving i=
t duplicated is the process. I create a patch to create</div><div>bsd-user/=
thunk.c that&#39;s a verbatim copy of linux-user/thunk.c. Despite putting i=
n</div><div>my cover that this is copied code, if past is prologue, then I&=
#39;ll be asked to fix the</div><div>copyright and style, plus lots of sugg=
estions to improve the code. But it&#39;s just a</div><div>verbatim copy, s=
o that&#39;s a lot of hassle just to copy it.</div><div><br></div><div>Movi=
ng like this, though, is almost 0 friction. A small tweak to meson is all t=
hat&#39;s</div><div>needed.=C2=A0I suppose I could do the #include &quot;..=
/linux-user/trunk.c&quot; trick to make it</div><div>less ugly in the build=
 system, but=C2=A0then it&#39;s not clear it&#39;s shared, etc and more ugl=
y</div><div>in the code, imho.</div><div><br></div><div><span style=3D"back=
ground-color:rgba(246,250,255,0.88)">I tried to move this stuff into thunk.=
h as much as possible so we could have=C2=A0</span><span style=3D"backgroun=
d-color:rgba(246,250,255,0.88)">one</span></div><div><span style=3D"backgro=
und-color:rgba(246,250,255,0.88)">compilation, and that didn&#39;t work. It=
 really assumes that it can include qemu.h for</span></div><div><span style=
=3D"background-color:rgba(246,250,255,0.88)">the tswap, etc macros. So it&#=
39;s impossible to just build once.</span></div><div><span style=3D"backgro=
und-color:rgba(246,250,255,0.88)"><br></span></div><div><span style=3D"back=
ground-color:rgba(246,250,255,0.88)">Now looking at the code, a lot of it w=
ould be a lot simpler with &#39;Generic&#39;, but that&#39;s</span></div><d=
iv><span style=3D"background-color:rgba(246,250,255,0.88)">a battle for ano=
ther day. As is the notion of just generating this data from the .h files</=
span></div><div><span style=3D"background-color:rgba(246,250,255,0.88)">rat=
her than hard-coding it here, but that too is a battle for another day. I&#=
39;d like to</span></div><div><span style=3D"background-color:rgba(246,250,=
255,0.88)">get this upstreamed so I&#39;m spending my time on these sorts o=
f battle.s</span></div><div><br></div><div>Warner</div></div></div>

--000000000000157f08064cd979ce--

