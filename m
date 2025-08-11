Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78993C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 02:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulIEL-0000XS-3g; Sun, 10 Aug 2025 22:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ulIEI-0000Wz-Ns
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 22:25:42 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ulIEA-0003NV-I4
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 22:25:42 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so3764526fac.0
 for <qemu-devel@nongnu.org>; Sun, 10 Aug 2025 19:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1754879131; x=1755483931;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNzUxkh2hdgyT6uvgDCPc2UkmGjbQADhSXx3fx/51vA=;
 b=yEadS9MzxCTJB68kePy8WaV7XahKnstEvIYbERRMN7yi9hX4LZcHBE4jjFDrJMO714
 n+X2pa9t8ceGMjPQaj2+HM2518MyJEL5XTk/SMdSvb6cXzv84tljW6lfSHWw9q1H3CL+
 PiiVayWuqVHDRXX5FnNjB4YMd31OQSwlekk53Ej/+gBrG5x1RnBAQ/v5N0nt+5n94dW2
 3NH7N/EACoNzV2dX7m/Z9QOdQrFmyh08OcuyhtONc0Sgb6GeawXkOJ0GXRtDD+7O9FDD
 1NH2/74mRFkbajRcNPYWVdzD2sPg+lxufvG3f9uvPKbJdqgs4u8DrM6rak9GkQdH+nmr
 8Ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754879131; x=1755483931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZNzUxkh2hdgyT6uvgDCPc2UkmGjbQADhSXx3fx/51vA=;
 b=LXj8gSyo2NR/LB0h7mZCaq8Kdl8sGcbsOpcmHqzX/B3oz/tzGSPozFbRMaaCVd8+ru
 d5fMg/v12UmAeF8wrvypXGAvV0BuMo4lag9ejber1U46wKXu0Ywoo8H0W5gI9UvZyvk1
 pzFnp+nRXeT6xpj8VBqFDUjW/qpSUL0vn+lxeCNFm/wAlZGp9tpifJZCkw9sCTC7sL46
 G82yNcJVFaQtuPvEcuc/MHS0xqjHBMD6it++zE6G+560m6+UgO02WKv9o0Fi7nHlIS3V
 ky4Pb1aHsoyPbyTjcWvWDxGvyZx117m8qY5aHbVzGuuXRjYxLsb7mInrJK4HQqSGAqq4
 Mifg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy5cBA9t4ffsMLFnCl8Ap8IFKFJNvdYXRH31oKFFDIFIUhnyJ3vYCW+bbnyxK+q7YvRtfhLLsBwgbi@nongnu.org
X-Gm-Message-State: AOJu0YwHcBKGdXPaBG2JWJa1TV5YYDqU1liCov0UMm9gQw4b1avBXlii
 JuRgjjm2xCP2Mo+8pbzlem8eCGvdre/TfBHxoWJSYrLk/spdZymda2xIQ9SUs/y0pWsajFdaTEU
 R6dkOfApe7gW/ExH4rA0xkWDdn2cZ4+riWWaqUBgF2w==
X-Gm-Gg: ASbGncuxi5rdgfrDeXxL1LgOn5Uqr3p81hgi8z7HwQxqRk/Eovm4fTIpyjNVPMcGTtx
 e95neCxkPy3GPqAOprouf2I2DKagrktTsGuWgWv5Kgd/bgSJdAQqVVxtQab0WzotAdOTvAEed20
 YDF79C8TzUuRUbq2Bt0fWd7ppVpZjuqnR96yms9Z45AxkHTVbfJbu7mXAhIAIrKteAtJlhxw0+W
 e19Oyv86AZuxnJ/iDU=
X-Google-Smtp-Source: AGHT+IHN5gWiqw9xMZBZANUZNYgM17LdAkeTgyHsKTmuxxF1b0hmmT4Mc2K/3TOVi4uDij+XLbtdEvmXRhtSfMGvyrc=
X-Received: by 2002:a05:6870:65a1:b0:307:aaf0:9588 with SMTP id
 586e51a60fabf-30c234d4709mr6414041fac.1.1754879131046; Sun, 10 Aug 2025
 19:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <20250807113639.66d1c5bf@penguin>
 <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
 <20250808090054.13cb8342@penguin>
 <CAK9dgmbybw+WkC2C_qdZnwSYjGn3Q2Du4yjLOz+EmCx1po8YPg@mail.gmail.com>
 <87o6sp2a0i.fsf@suse.de> <aJYZs9NnAOqVMcd1@x1.local>
In-Reply-To: <aJYZs9NnAOqVMcd1@x1.local>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 11 Aug 2025 10:25:12 +0800
X-Gm-Features: Ac12FXy9q0kX4s_Q3jTaU9o26Vb-xkFknHunWXeQMH1D9SUtFub75nNTCuo-tPY
Message-ID: <CAK9dgmZyVb9fgYf2VSuTCCXr38rZXmA3qJQtSQYOYQ+QNXZrAQ@mail.gmail.com>
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003aed1e063c0da336"
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000003aed1e063c0da336
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 11:37=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:

> On Fri, Aug 08, 2025 at 10:55:25AM -0300, Fabiano Rosas wrote:
> > Please work with Lukas to figure out whether yank can be used here. I
> > think that's the correct approach. If the main loop is blocked, then
> > some out-of-band cancellation routine is needed. migrate_cancel() could
> > be it, but at the moment it's not. Yank is the second best thing.
>
> I agree.
>
> migrate_cancel() should really be an OOB command..  It should be a supers=
et
> of yank features, plus anything migration speficic besides yanking the
> channels, for example, when migration thread is blocked in PRE_SWITCHOVER=
.


> I'll add this into my todo; maybe I can do something with it this release=
.
> I'm happy if anyone would beat me to it.
>

Is there any suggestions if I can fix migrate_cancel with the
"OOB-command-way"?
Maybe these could be the preceding patchset of your work.


>
> >
> > The need for a timeout is usually indicative of a design issue. In this
> > case, the choice of a coroutine for the incoming side is the obvious
> > one. Peter will tell you all about it! =3D)
>
> Nah. :)
>
> --
> Peter Xu
>
>

--=20
Best regards

--0000000000003aed1e063c0da336
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Fri, Aug 8, 2025 at 11:37=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:=
peterx@redhat.com">peterx@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1e=
x">On Fri, Aug 08, 2025 at 10:55:25AM -0300, Fabiano Rosas wrote:<br>
&gt; Please work with Lukas to figure out whether yank can be used here. I<=
br>
&gt; think that&#39;s the correct approach. If the main loop is blocked, th=
en<br>
&gt; some out-of-band cancellation routine is needed. migrate_cancel() coul=
d<br>
&gt; be it, but at the moment it&#39;s not. Yank is the second best thing.<=
br>
<br>
I agree.<br>
<br>
migrate_cancel() should really be an OOB command..=C2=A0 It should be a sup=
erset<br>
of yank features, plus anything migration speficic besides yanking the<br>
channels, for example, when migration thread is blocked in PRE_SWITCHOVER.<=
/blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(20=
4,204,204);padding-left:1ex">
<br>
I&#39;ll add this into my todo; maybe I can do something with it this relea=
se.<br>
I&#39;m happy if anyone would beat me to it.<br></blockquote><div><br></div=
><div><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Is t=
here any suggestions if I can fix migrate_cancel with the &quot;OOB-command=
-way&quot;<span class=3D"gmail_default" style=3D"font-family:&quot;comic sa=
ns ms&quot;,sans-serif">?</span></span></div><div><div style=3D"font-family=
:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Maybe these =
could be the preceding patchset of your work.</div></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pa=
dding-left:1ex">
<br>
&gt; <br>
&gt; The need for a timeout is usually indicative of a design issue. In thi=
s<br>
&gt; case, the choice of a coroutine for the incoming side is the obvious<b=
r>
&gt; one. Peter will tell you all about it! =3D)<br>
<br>
Nah. :)<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>

--0000000000003aed1e063c0da336--

