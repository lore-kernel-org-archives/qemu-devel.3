Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7135D2CE17
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Dec 2025 11:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSD2O-0003XO-UO; Sun, 07 Dec 2025 06:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vSD2H-0003X8-6z
 for qemu-devel@nongnu.org; Sun, 07 Dec 2025 06:34:42 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vSD2E-0008AH-Tv
 for qemu-devel@nongnu.org; Sun, 07 Dec 2025 06:34:40 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-343684a06b2so3689037a91.1
 for <qemu-devel@nongnu.org>; Sun, 07 Dec 2025 03:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1765107277; x=1765712077;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TdxHWrHPx7xiKEpiH6mMADi3aQNM4zvph163W5D1YJw=;
 b=ju/TD9GidAOZlbqiexL0aHXaR9mBDIi1wZfyXJ4axuozhTDT+NgObO9mC6tHGZQuAU
 PaSuhk1Bt6/NG3nR7sPOGXaxmvO8aTg3i9AHqnrgJvb8JGLc4+XNv9yiCI97/zMgmoyN
 HsKDeLuJacLI/iUPU8AEGAF9j5WurYR9ujnj5304PPNr7RXoGGg12GA4TvubQB1kc5nr
 s2rHQNt3+GU1tidqpVzb1yCsplhJb6EYhRmnPVQAXz1FAS4RnuKXMEZNhx4ru4S7CRw6
 Y4VRgNoFzCte05zYsU9YCZo6wwiSYq2SJmzz3Hn54sf92ZD6RsuMDQIepe77gVdVL1Ly
 JNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765107277; x=1765712077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdxHWrHPx7xiKEpiH6mMADi3aQNM4zvph163W5D1YJw=;
 b=TpYGNj3AwFQ4bGnNVksxx/4bT+ICC6HiHXqRq/WLoBoeQh6SctLanHqKCHHS1yIkqD
 govjX/ZUkpiBTlrh3RcE6f2hu/3HHJVIaLTBRhLQjR0PHh8T2LT9/qiAt+3sWt4noQbY
 4Hbftk+1DWIBLlLa/qr5Wq327IC1en/bBkRiO/n0T3UydK2Ao6HccBhUeEZng7o/lqyz
 A69URFCmFxfXkcKLBT6U6b3xfvdXe061YYH37QFEjHFop5Ycra7+wjzi7PFAonZGc0ru
 03UvbuO462uqY6Gq1NtHWuUgEA3UggPhRkEAx6aW5vRqdCC0KhX1mkVxG0gscUUWfeNX
 3wVQ==
X-Gm-Message-State: AOJu0YwkqYfGKeR18BCgQLNSLSxesTVDXb3swm1qJO5vwlzz/s0VPqij
 aF18ndidysjPsdHmKW1DrYVzAS48QQ4aaSRJ1upEM59/pEeeF+SnGtHP5dzlUGDaZqd3eDeWldr
 GJcCahq4rZ7/tg3yTm5g9GumGdN9l62FiIBwENSvzCw==
X-Gm-Gg: ASbGncvBHDwh8vjyrtoPM0ysrFZ2ysKj9PcA8Fsy+hi+IwqjhndClV3/3rzynsHfJjH
 07tfKrTqH1+Lrb3Slv/R7vMCSO92CJEsEULUKbIfQWyEVptTGTZ+yNKqI3a1rTgHFhtFXcHIU/N
 RYh8x5WvSgXLYyKURx+Lx+9U8ScAA1aJwiAGxQ9D6VoceASlwYZpMk/5xhrcTMUK/dni6A+NcZ3
 pqq5O0xuB2+JrImBCxgnGI+5PNUdnsUAHMUWmoSc85TnMfGroNHyKb9OW1YY1bB7Lnqd0b4qOzq
 Hqz9Qse+LSSCPR6Z89wSxSZiy1SUS6ejvaZY
X-Google-Smtp-Source: AGHT+IGVTM92GXtAjMUvOPRgjlQBEAdpWrPwMbBJByl/6hsr5pSkaTEbwQ3suHweD7FiP8fl8kMyPdm0nOnqHODa8rA=
X-Received: by 2002:a17:90b:3910:b0:343:688e:3252 with SMTP id
 98e67ed59e1d1-349a25190a0mr4166723a91.12.1765107276676; Sun, 07 Dec 2025
 03:34:36 -0800 (PST)
MIME-Version: 1.0
References: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
 <5030911.GXAFRqVoOG@weasel> <c2d79567-6b6c-4222-b1df-550db57ad626@gmail.com>
In-Reply-To: <c2d79567-6b6c-4222-b1df-550db57ad626@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 7 Dec 2025 04:34:24 -0700
X-Gm-Features: AQt7F2oJkMuNZEmZMqoQbURv6HZR98VoS6diJUisON-NATtZo09fAWMikZZq7Vg
Message-ID: <CANCZdfrkPrr-KQF800UVsQov8LpZte9x2ryRao7GGUyuxFwGeA@mail.gmail.com>
Subject: Re: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
To: Andrey Erokhin <language.lawyer@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: multipart/alternative; boundary="00000000000037911106455b10f2"
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1031.google.com
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

--00000000000037911106455b10f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025, 10:12=E2=80=AFAM Andrey Erokhin <language.lawyer@gmail=
.com>
wrote:

> On 03/12/2025 15:33, Christian Schoenebeck wrote:
> > On Monday, 1 December 2025 19:00:53 CET Andrey Erokhin wrote:
> >> I was trying to boot from a directory tree owned by an ordinary user,
> >> and some daemons weren't happy about non-root ownership of some files
> >>
> >> Example use:
> >> -virtfs
> local,path=3Drootfs,mount_tag=3Droot,security_model=3Dmapped,uid=3D0,gid=
=3D0
> >>
> >> Works with any security_model
> >
> > First I thought do we really want to open that rabbit hole and add
> permission management to the CLI options? However I get why this might be
> useful for  mapped[-*] security models.
> > But for passthrough it is not of any use, is it?
>
> Prolly none, just a side effect of how it's implemented.
> Can either make it an error when used with passthrough, or ignore them
> (use default -1 value) when copying options to 9p fs context (with or
> without a warning)
>
> > Also while it is very handy to have a short option name like "uid" and
> "gid", for the sake of long term progression and clarity an option name
> like "default-uid" would be more appropriate.
>
> Or rather default_uid, to match other options style? But uid/gid also
> kinda match fmode/dmode :\
>

FreeBSD has a mode where you can build the image where the files in the
filesystem are owned by the user with random permission bits, but the
actual owners / modes are in an mtree formatted file. The nopriv imagers
combine the two when making images. It would be nice to have p9 do a
simular mapping for the guest so I can boot test these images more directly
w/o the copyout to the "bootable image". The set the uid feature would
help, true, but leaves me wanting more.

Warner

> The patch is also missing the required documentation changes for these
> new options BTW.
>
> Haven=E2=80=99t added them yet, wasn=E2=80=99t sure there would be intere=
st in this feature
>
>

--00000000000037911106455b10f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Dec 6, 2025, 10:12=E2=80=
=AFAM Andrey Erokhin &lt;<a href=3D"mailto:language.lawyer@gmail.com">langu=
age.lawyer@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>On 03/12/2025 15:33, Christian Schoenebeck wrote:<br>
&gt; On Monday, 1 December 2025 19:00:53 CET Andrey Erokhin wrote:<br>
&gt;&gt; I was trying to boot from a directory tree owned by an ordinary us=
er,<br>
&gt;&gt; and some daemons weren&#39;t happy about non-root ownership of som=
e files<br>
&gt;&gt;<br>
&gt;&gt; Example use:<br>
&gt;&gt; -virtfs local,path=3Drootfs,mount_tag=3Droot,security_model=3Dmapp=
ed,uid=3D0,gid=3D0<br>
&gt;&gt;<br>
&gt;&gt; Works with any security_model<br>
&gt; <br>
&gt; First I thought do we really want to open that rabbit hole and add per=
mission management to the CLI options? However I get why this might be usef=
ul for=C2=A0 mapped[-*] security models.<br>
&gt; But for passthrough it is not of any use, is it?<br>
<br>
Prolly none, just a side effect of how it&#39;s implemented.<br>
Can either make it an error when used with passthrough, or ignore them (use=
 default -1 value) when copying options to 9p fs context (with or without a=
 warning)<br>
<br>
&gt; Also while it is very handy to have a short option name like &quot;uid=
&quot; and &quot;gid&quot;, for the sake of long term progression and clari=
ty an option name like &quot;default-uid&quot; would be more appropriate.<b=
r>
<br>
Or rather default_uid, to match other options style? But uid/gid also kinda=
 match fmode/dmode :\<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">FreeBSD has a mode where you can build the image where=
 the files in the filesystem are owned by the user with random permission b=
its, but the actual owners / modes are in an mtree formatted file. The nopr=
iv imagers combine the two when making images. It would be nice to have p9 =
do a simular mapping for the guest so I can boot test these images more dir=
ectly w/o the copyout to the &quot;bootable image&quot;. The set the uid fe=
ature would help, true, but leaves me wanting more.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Warner</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
&gt; The patch is also missing the required documentation changes for these=
 new options BTW.<br>
<br>
Haven=E2=80=99t added them yet, wasn=E2=80=99t sure there would be interest=
 in this feature<br>
<br>
</blockquote></div></div></div>

--00000000000037911106455b10f2--

