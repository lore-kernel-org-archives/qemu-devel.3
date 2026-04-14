Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45EBF531E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 02:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCTlE-0002eL-QU; Mon, 13 Apr 2026 22:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wCTlC-0002dk-1C
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 22:44:18 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wCTlA-000124-2s
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 22:44:17 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c76eea1672aso1734766a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 19:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776134653; cv=none;
 d=google.com; s=arc-20240605;
 b=XtmK75RN0jvq55oT4FI11WVyn/20wLGs12wy9CV5H+1OCMR93QRvvChyfQCOcIfDKI
 1fKFr9emkgp4PsEI7Gy7gO7eFfVzBqRzOklJ4yvp0W7Lx9+pYnOaGeQGu0ajNhW9IDjA
 hXO65poLhqibZNJt8n7LdiQxxpqxZ1aZ8BkFPtOvbN6vdl4Sfw5tiYTbhcvnGxTDpZdN
 10p9QUeYVvRmwrAE2u3OYBf2KvXfjhIMEEAkM1LicC233ZzEUzi0q6ZAWFGiesJrvbVL
 qxys3Ag1fdRZ1qkscKHgNlj+5Vk0AgCy8NgfW7hWKZZqa8k2+XXHXxMwzBH67NZirg++
 HkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jHnHwpU6+1fA7nzBnIVa04mhK2Yk89d9kJyilcrjSd0=;
 fh=GnmRbJ6oH7GfxUPIM2ND+IrLwiLhn2jdjMCJOqQX1fw=;
 b=P0RY3y/6QC5QpFj1yqZRSxScXIwbCj60ME23ADrdRyN35CLtLeqEltMn8LKmqyrnSn
 wQby1NqijqPEASIEbTdhN4+lgb4c/8TIeIiPRbcP3IefkmLZeqpRrlRlybJPXBTtdhFb
 plkJGSjlKJozfjPJSZ9bh8+Oql3jLITGmNmRkquveyUYu6TsZAcEKfSdmQTDZ2VFrTCP
 Uh8/fR8In5xKacBQ69vAVtpQ+L8XBcC2h3QVhbbUJ4GzS7ydiGTlsXe463ZtcxrEkLBA
 4QvNMVTE1I85YWKHDEJOoObFDXrmV2LVFXG7bIR2erBSRTAyVIpe0Co8CJDl3eLzbHMz
 D/gg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776134653; x=1776739453;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jHnHwpU6+1fA7nzBnIVa04mhK2Yk89d9kJyilcrjSd0=;
 b=0iafAlTDHSQPJtn3xW9s6znyZC65GFIO08RlvZFkwT7LZEQ4VB3TcSH1UwKHeQtZ6c
 rZv8tvoUAR90MQFv9+YeJWawmBjCUCJ3xebgMNAIwWiZ3bk+HheWR1ghcSNVeOB7N2XR
 qYdNWXxpYbDbzHvlUii7SezWChwZxrJRKfmUQx2tz/slU5DZYgwL0xSdGTwQv9x4Qfw3
 DfKmCIlaNaOe2ixVWIOrDeOQ8juKsu8Nmb43jjeoMngO1YFG9/CQFfmoOx5zbX214n/0
 /ER9BL3jXZ+m7Rw9NIRqKEH9wHrjwPEKFj7cOhf9i3uxK169A2SaxeYTWGfXZE6OFn/2
 SkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776134653; x=1776739453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHnHwpU6+1fA7nzBnIVa04mhK2Yk89d9kJyilcrjSd0=;
 b=gSjDVPtRyLgXqy4wx92gHHAF3Ug9/nIcKeqfLFqWm8k+QDvFSOmMjbeZaid3tvw80F
 ANN+TAz4wKsa+2y0QKamZdx/uQp1pr4HBF0AHICBrERKB+l04UqQ2ud97QNcvQu51yc3
 lALfHAl2nEFcS/jsPucX8EbfXouzKKohDEeCaNMLWq2RlyKWuptqVkye1rKwbZO+6CUx
 GdNhN1R8OyKPm84elC8Wuqjwap8tJ9begmramGsGd+f88xmp9koeeEeexngyqqxXJcvY
 IqkRNMWeQF756eR7bKOs0CVGOOOORIoSw3ovCAT58719kBI96P+UTfPcz/WSYwJlkNOi
 5TEQ==
X-Gm-Message-State: AOJu0Yzgj2LNF/NyvvKRgqRhF68fLAc123KqeXzszG3dPHyMlAv2hQsD
 eBw6Zk/4s33hZflQNaR8SKPmj5+HM2F2qoGOy9HgEe2/HziqJl2Z+T6OMtPXaDLnBb4ka8O3JRf
 AM5LKitv2WnlumDXM23dKf4+RQJztQDP4XyarwNMwFQ==
X-Gm-Gg: AeBDieuCPlIV6C6tcVFpmZfyoqVdsVj99NXJpNs32XuGmUR4HYgKpPCm18cF7eK4QFG
 cSbmCuahTqw+WNR+4azAtyn1K125Jz8d57eXHTusufEw8vcpbPHiF7zhSU1GEQjz3w5rtxbICA3
 ZHsDWm9m0TddAVkF6ZfO6NMylLnc1BYkNymKFxq1Bb2nKNihHizHG33cm4D5EGP7mGke38Zf1KK
 ySzYfVH8NaqE+1682HP7sFcwKJUlZtL2vPrB38giMu/icgKSbZ+2Qzi6MDjEO2CuiFaSlAWlAQE
 eSAxWCrQ9wfaj/p/mnN7pCyKiVmWFo3AkvZepg==
X-Received: by 2002:a05:6a20:7486:b0:398:b346:b13 with SMTP id
 adf61e73a8af0-39fe3d0dfafmr17613349637.16.1776134653447; Mon, 13 Apr 2026
 19:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
 <20260413-syscall-nr-v1-1-f70408d042ea@bsdimp.com>
 <934e73a1-0dcc-499c-b0c4-bbcc3cfe26f2@linaro.org>
In-Reply-To: <934e73a1-0dcc-499c-b0c4-bbcc3cfe26f2@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 13 Apr 2026 20:44:02 -0600
X-Gm-Features: AQROBzDQqUdIgPJ8mBkvq3qPOMtx8XA_jqvMXGJZknZ3VLpm_aVdFDHZbyYKPkY
Message-ID: <CANCZdfqwQKExBX-3g_+_0crJUi7qgU92PM7W2pAgBdRO0nO9FA@mail.gmail.com>
Subject: Re: [PATCH 1/5] bsd-user: Add syscall header generator for FreeBSD
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000017a48c064f629383"
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x536.google.com
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

--00000000000017a48c064f629383
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 4:21=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 13/4/26 17:31, Warner Losh wrote:
> > Generate the syscall numbers from the installed header that has them.
> > Ideally, we'd use FreeBSD's lua infra for this, but that requires that
> > we have those files installed, and they aren't quite the same across
> > supported versions yet, so use this simple, but effective hack.
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/freebsd/syscallhdr.sh | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/bsd-user/freebsd/syscallhdr.sh
> b/bsd-user/freebsd/syscallhdr.sh
> > new file mode 100644
> > index 0000000000..fa38500775
> > --- /dev/null
> > +++ b/bsd-user/freebsd/syscallhdr.sh
> > @@ -0,0 +1,9 @@
> > +#!/bin/sh
> > +# Copyright (c) 2026 Warner Losh <imp@bsdimp.com>
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +in=3D"$1"
> > +out=3D"$2"
> > +bsd=3D"$3"
> > +
>

Hey, thanks for the review.


> echo '/* This file is autogenerated by syscallhdr.sh, do not edit. */' >

$out
> echo '/* SPDX-License-Identifier: GPL-2.0-or-later */' >> $out
>

These aren't needed. The generated file starts off:
/*
 * System call numbers.
 *
 * DO NOT EDIT-- this file is automatically @generated.
 */
...
we're just doing sed -e s/SYS/TARGET_FREEBSD_NR/g on
that file (though awk is mildly more convenient). No need to add
a license, since it's already in the public domain, and you don't
need a license to do anything you want to public domain material
(including incorporating it into a GPL'd work). Since the generated
file isn't committed to the repo, there's no style checker to appease.

Warner

> +awk -v bsd=3D"$3" '{sub("SYS_", "TARGET_" bsd "_NR_", $0); print;}' < $i=
n
> > $out
>
>    ... >> $out
>
> With the header changes:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

--00000000000017a48c064f629383
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 13, 2026=
 at 4:21=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On 13/4/26 17:31, Warner L=
osh wrote:<br>
&gt; Generate the syscall numbers from the installed header that has them.<=
br>
&gt; Ideally, we&#39;d use FreeBSD&#39;s lua infra for this, but that requi=
res that<br>
&gt; we have those files installed, and they aren&#39;t quite the same acro=
ss<br>
&gt; supported versions yet, so use this simple, but effective hack.<br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/syscallhdr.sh | 9 +++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 9 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/syscallhdr.sh b/bsd-user/freebsd/syscall=
hdr.sh<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..fa38500775<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/freebsd/syscallhdr.sh<br>
&gt; @@ -0,0 +1,9 @@<br>
&gt; +#!/bin/sh<br>
&gt; +# Copyright (c) 2026 Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com=
" target=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; +# SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; +<br>
&gt; +in=3D&quot;$1&quot;<br>
&gt; +out=3D&quot;$2&quot;<br>
&gt; +bsd=3D&quot;$3&quot;<br>
&gt; +<br></blockquote><div><br></div><div>Hey, thanks for the review.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
echo &#39;/* This file is autogenerated by syscallhdr.sh, do not edit. */&#=
39; &gt;</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">$out=
<br>
echo &#39;/* SPDX-License-Identifier: GPL-2.0-or-later */&#39; &gt;&gt; $ou=
t<br></blockquote><div><br></div><div>These aren&#39;t needed. The generate=
d file starts off:</div><div>/*</div><div>=C2=A0* System call numbers.<br>=
=C2=A0*<br>=C2=A0* DO NOT EDIT-- this file is automatically @generated.<br>=
=C2=A0*/</div><div>...</div><div>we&#39;re just doing sed -e s/SYS/TARGET_F=
REEBSD_NR/g on</div><div>that file (though awk is mildly more convenient). =
No need to add</div><div>a license, since it&#39;s already in the public do=
main, and you don&#39;t</div><div>need a license to do anything you want to=
 public domain material</div><div>(including incorporating it into a GPL&#3=
9;d work). Since the generated</div><div>file isn&#39;t committed to the re=
po, there&#39;s no style checker to appease.</div><div><br></div><div>Warne=
r</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt=
; +awk -v bsd=3D&quot;$3&quot; &#39;{sub(&quot;SYS_&quot;, &quot;TARGET_&qu=
ot; bsd &quot;_NR_&quot;, $0); print;}&#39; &lt; $in &gt; $out<br>
<br>
=C2=A0 =C2=A0... &gt;&gt; $out<br>
<br>
With the header changes:<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
</blockquote></div></div>
</div>

--00000000000017a48c064f629383--

