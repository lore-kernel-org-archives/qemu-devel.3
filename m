Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CE4D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 10:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSv7P-0007z9-A7; Tue, 09 Dec 2025 05:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vSv7M-0007z0-NO
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:38:53 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vSv7K-00054j-Hg
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:38:52 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-340a5c58bf1so3733615a91.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 02:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1765276726; x=1765881526;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CAPEBp5BK0txxnntzRpjPT81atM+jX6YV7E4P4Z4Tv0=;
 b=jamu0pT5hl3jcysNHav2s4sjQXR9P+Pjq9/xJRPoyDpu2nIGxKXlJipa5fS64pKoGI
 6bJxV4XIRaw0p1ySKkpb/5DSHTVSPi4RluZKpLCtzItK4TQmTHoF686uSsCW2io9k7wY
 Bl9iUmZDQxaLU8/DTogM/8JuFF+kFC93BHsPRpbXsTBXZMIqVimZIA39PI+T8qxIEeNE
 w3BXXe1tCiS35RseJSRyzzBK05/NeO48AvGAuDUIenkq3B9zJ6ufztPmf7UlALoQZfDz
 dRQBg+S3KFrHQP2k1bvxt12eus+ui/f1Xxorc3G0diE1woSuCBLpiSRPyHQeDzOafI5J
 BYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765276726; x=1765881526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAPEBp5BK0txxnntzRpjPT81atM+jX6YV7E4P4Z4Tv0=;
 b=GHK0ebdwBvjm7DmNKAQ4h6pkS7xtHdANleNl6bQROJiFdZPXXVcu9zbhEJ1cyzdBN7
 D7toPH2EaXQw1nQVsSqBg5ltejnN0Ccyu8Y8GVN/vaiAbXVEeI1TyAzZH5EJuMmw3PV1
 H41YnCeiEbCrzmXV/lByrRVr1iRYxTU110WCVxPOfR+FLFfzTOf9HBe0vevNb1MyEC8G
 G1BSRQLIu4JTo6sN+rnQ0uIZlKSbPgRQ7r2BWx7v6bgUFp3Aou6g8GNAqkIClJiTlJnn
 1TJ8ve68iGJflXgq+9Fz+/eVBbLEcA5xuI6tgEPkYMkAEpK4zx/7i+pCNQ/ZAAulPII6
 X86w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTeKuhLcvXxEXSf8fJBVwFRiEA7RdzWtLuRH/JnSt21OEIRC16FxXmGADEidSMOue+xCQRV8IpZ/Rj@nongnu.org
X-Gm-Message-State: AOJu0YyfCqFnQJrU2QSJfYwR4z/uff6Dvel0giNSM/1jltHVaVmFWSSp
 0UPVPprn8Xc+ALjK3MRqEY4pbBHz3GyyGlc6IoYBpU8HmGlBROlkN8ENfnzFIIkhXcLM0QXuvzh
 rjUxOYnbGbTAmMRSS76jECmantCq8HYOH2PNaJx1IsVdag1jkZCGCOhY=
X-Gm-Gg: ASbGnctJN4nfTmlhFuvWkv05jUzxesqftqh44aSnWQ0TGN3E+bsrJpi8E1fbRDj5MEW
 niNRFl/CGvghj72bs+NkQdmE5pjfAp9jKFMir+zc9ZD3vmy0uAhv7bJ0Z9MD5LT9Tqpfgghs6aH
 r1e/WBDQFJiE5VjmJhx6NJY2VgXl6Y9YhZODoUuLwKjw/YJ3T1cV8Vq/2KcWXV7tfSZPw8ZdDWB
 /rWgW3qjX5yadj5ec4A9qpcTIKCzT4w7ej7pcYcd+SEPfQ/iGJENhHDf8ig7Yi1I7ib0f68rT/J
 GYf4UuKDnau+ND2k
X-Google-Smtp-Source: AGHT+IFl1YwEtfli+qkBNuwDuPM0fZdFdvYn3TnhN6uICVtEc7sZd2q1L5GQh6wujGTh+6Hxxpo7JRFBzScSA8Av1q8=
X-Received: by 2002:a17:90b:4ad1:b0:32e:a4d:41cb with SMTP id
 98e67ed59e1d1-349a25c2e18mr8846199a91.1.1765276726448; Tue, 09 Dec 2025
 02:38:46 -0800 (PST)
MIME-Version: 1.0
References: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
 <c2d79567-6b6c-4222-b1df-550db57ad626@gmail.com>
 <CANCZdfrkPrr-KQF800UVsQov8LpZte9x2ryRao7GGUyuxFwGeA@mail.gmail.com>
 <2022919.PYKUYFuaPT@weasel>
In-Reply-To: <2022919.PYKUYFuaPT@weasel>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 9 Dec 2025 03:38:34 -0700
X-Gm-Features: AQt7F2rxf7bRFrZaryOOPyucxcp-68eTfmhSttNnSgnlNekDRGlr2xYLQF5mYFk
Message-ID: <CANCZdfpgLPyzJtz3RZQssAkWahmvpeAA-tKp7t_7BBdPMshajg@mail.gmail.com>
Subject: Re: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Andrey Erokhin <language.lawyer@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000035e42d0645828405"
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102d.google.com
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

--00000000000035e42d0645828405
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 3:21=E2=80=AFAM Christian Schoenebeck <qemu_oss@crud=
ebyte.com>
wrote:

> On Sunday, 7 December 2025 12:34:24 CET Warner Losh wrote:
> > On Sat, Dec 6, 2025, 10:12=E2=80=AFAM Andrey Erokhin <language.lawyer@g=
mail.com>
>
> > wrote:
> > > On 03/12/2025 15:33, Christian Schoenebeck wrote:
> > > > On Monday, 1 December 2025 19:00:53 CET Andrey Erokhin wrote:
> [...]
> > > > But for passthrough it is not of any use, is it?
> > >
> > > Prolly none, just a side effect of how it's implemented.
> > > Can either make it an error when used with passthrough, or ignore the=
m
> > > (use default -1 value) when copying options to 9p fs context (with or
> > > without a warning)
> > >
> > > > Also while it is very handy to have a short option name like "uid"
> and
> > >
> > > "gid", for the sake of long term progression and clarity an option na=
me
> > > like "default-uid" would be more appropriate.
> > >
> > > Or rather default_uid, to match other options style? But uid/gid also
> > > kinda match fmode/dmode :\
>
> Right, that would render it strange having default_uid/default_gid vs.
> fmod/
> gmode when all of them actually mean default values.
>
> OK, as fmode/dmode are already there, then let's stick to your initial
> suggestion of just using uid/gid.
>
> But similar to fmode/dmode it should be made clear on documentation level
> that
> uid/gid are only useful for mapped security models.
>
> > FreeBSD has a mode where you can build the image where the files in the
> > filesystem are owned by the user with random permission bits, but the
> > actual owners / modes are in an mtree formatted file. The nopriv imager=
s
> > combine the two when making images. It would be nice to have p9 do a
> > simular mapping for the guest so I can boot test these images more
> directly
> > w/o the copyout to the "bootable image". The set the uid feature would
> > help, true, but leaves me wanting more.
>
> And a host level (not yet existing) tool like qemu-9p-chown, qemu-9p-chmo=
d
> would be less appropriate for your use case?
>

I can't answer directly, since I can't look them up :)
But... I want to own all the files on the host, but I want them to conform
to a spec on
view p9 gives to the guest:

/etc/rc.d type=3Ddir uname=3Droot gname=3Dwheel mode=3D755
./etc/rc.d/accounting type=3Dfile uname=3Droot gname=3Dwheel mode=3D555
./usr/bin type=3Ddir uname=3Droot gname=3Dwheel mode=3D755
./usr type=3Ddir uname=3Droot gname=3Dwheel mode=3D755
./usr/bin/last type=3Dfile uname=3Droot gname=3Dwheel mode=3D555

is a small excerpt of the file we happen to use (though I'm agnostic as to
the actual
format). But these files are long:
wc _.armv7.14.3.metalog
    5316   26759  399552 _.armv7.14.3.metalog
which might pose problems...

Warner

--00000000000035e42d0645828405
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 9, =
2025 at 3:21=E2=80=AFAM Christian Schoenebeck &lt;<a href=3D"mailto:qemu_os=
s@crudebyte.com">qemu_oss@crudebyte.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">On Sunday, 7 December 2025 12:34:24 =
CET Warner Losh wrote:<br>
&gt; On Sat, Dec 6, 2025, 10:12=E2=80=AFAM Andrey Erokhin &lt;<a href=3D"ma=
ilto:language.lawyer@gmail.com" target=3D"_blank">language.lawyer@gmail.com=
</a>&gt; <br>
&gt; wrote:<br>
&gt; &gt; On 03/12/2025 15:33, Christian Schoenebeck wrote:<br>
&gt; &gt; &gt; On Monday, 1 December 2025 19:00:53 CET Andrey Erokhin wrote=
:<br>
[...]<br>
&gt; &gt; &gt; But for passthrough it is not of any use, is it?<br>
&gt; &gt; <br>
&gt; &gt; Prolly none, just a side effect of how it&#39;s implemented.<br>
&gt; &gt; Can either make it an error when used with passthrough, or ignore=
 them<br>
&gt; &gt; (use default -1 value) when copying options to 9p fs context (wit=
h or<br>
&gt; &gt; without a warning)<br>
&gt; &gt; <br>
&gt; &gt; &gt; Also while it is very handy to have a short option name like=
 &quot;uid&quot; and<br>
&gt; &gt; <br>
&gt; &gt; &quot;gid&quot;, for the sake of long term progression and clarit=
y an option name<br>
&gt; &gt; like &quot;default-uid&quot; would be more appropriate.<br>
&gt; &gt; <br>
&gt; &gt; Or rather default_uid, to match other options style? But uid/gid =
also<br>
&gt; &gt; kinda match fmode/dmode :\<br>
<br>
Right, that would render it strange having default_uid/default_gid vs. fmod=
/<br>
gmode when all of them actually mean default values.<br>
<br>
OK, as fmode/dmode are already there, then let&#39;s stick to your initial =
<br>
suggestion of just using uid/gid.<br>
<br>
But similar to fmode/dmode it should be made clear on documentation level t=
hat <br>
uid/gid are only useful for mapped security models.<br>
<br>
&gt; FreeBSD has a mode where you can build the image where the files in th=
e<br>
&gt; filesystem are owned by the user with random permission bits, but the<=
br>
&gt; actual owners / modes are in an mtree formatted file. The nopriv image=
rs<br>
&gt; combine the two when making images. It would be nice to have p9 do a<b=
r>
&gt; simular mapping for the guest so I can boot test these images more dir=
ectly<br>
&gt; w/o the copyout to the &quot;bootable image&quot;. The set the uid fea=
ture would<br>
&gt; help, true, but leaves me wanting more.<br>
<br>
And a host level (not yet existing) tool like qemu-9p-chown, qemu-9p-chmod =
<br>
would be less appropriate for your use case?<br></blockquote><div><br></div=
><div>I can&#39;t answer directly, since I can&#39;t look them=C2=A0up :)</=
div><div>But... I want to own all the files on the host, but I want them to=
 conform to a spec on</div><div>view p9 gives to the guest:</div><div><br><=
/div><div>/etc/rc.d type=3Ddir uname=3Droot gname=3Dwheel mode=3D755<br>./e=
tc/rc.d/accounting type=3Dfile uname=3Droot gname=3Dwheel mode=3D555<br>./u=
sr/bin type=3Ddir uname=3Droot gname=3Dwheel mode=3D755<br>./usr type=3Ddir=
 uname=3Droot gname=3Dwheel mode=3D755<br>./usr/bin/last type=3Dfile uname=
=3Droot gname=3Dwheel mode=3D555<br></div><div><br></div><div>is a small ex=
cerpt of the file we happen to use (though I&#39;m agnostic as to the actua=
l</div><div>format). But these files are long:=C2=A0</div><div>wc _.armv7.1=
4.3.metalog<br>=C2=A0 =C2=A0 5316 =C2=A0 26759 =C2=A0399552 _.armv7.14.3.me=
talog<br></div><div>which might pose problems...</div><div><br></div><div>W=
arner</div></div></div>

--00000000000035e42d0645828405--

