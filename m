Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A456ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 16:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRv58-0006wj-On; Tue, 26 May 2026 12:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRv57-0006wD-Iq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:56:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRv55-0002fr-Fz
 for qemu-devel@nongnu.org; Tue, 26 May 2026 12:56:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-83659d38e38so4424481b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 09:56:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779814598; cv=none;
 d=google.com; s=arc-20240605;
 b=fyomblDpuj1WLfXDO0kF93FmmpUMeg/9IBT0mXkj3WkW6ftwhnG+RWYu9w/h6rBWXt
 xmB5HUXtFis4p9u7+pQorLKXdyQEi/014W/wnlstVYIzOceX8WezBX53m/3/gSQv1Yq5
 p4eWQUQZBxiiIns6vuEa8XUEL/xnZfJYO1scKSi0mofbNsxZQYVEkMSlOd+UdBFM7MNI
 gCTrPaHDP5rhyTrxWg3S1Ipv/c/kqZmOEYxrfTKBkg9TTLf6QqnD0KA44nZgR5xNXbhV
 b6oBrBmxXO+P4zxB7zTS2lKn8R7fHcmpF4C4Jwb2FYgx5C1e3XuHKFU/U7TrbIamHd1r
 0dCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+X7aV/3RP5tjKhYyDj+mT5Zwu0Ntbg07oxPKseqsyeY=;
 fh=1c2Hxpfbc48VpSNmApyL+VxGgxnbSmXA+2/V0vN06DE=;
 b=Do8ITg79zn4qrMN+96iVVy14qr2ziJezUNKjQPwbJpyoyd690z3MA84hsKNzuK4KmY
 9DNamfeyAhmYMB/tLb3GqJO5i8t2g0JSgMRV4pFC//AFU7rHW0aTMQKkpzEsBm8tj13v
 ZhM4UAX/dR1upnz6Q7RenCW3SqlZWyF7iZ3wNVflJMyGl4+Syn53UGsaB7my9NJ0h6/f
 WPhXw+AJJIOYtdh5stqXw1HRVIR9C9GyWPpq0Fzrjv82PKd0blFOmMxzQTgL7/f6cV8T
 ZWpCbGLfYMdPIt2FFkyOylSvu5YVtED4mJwwbXow5W3NTR6Z6uRYIiFyVKBtfphmT5/H
 oToA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779814598; x=1780419398;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+X7aV/3RP5tjKhYyDj+mT5Zwu0Ntbg07oxPKseqsyeY=;
 b=FQd65gG73a/Jdh88zTyvZ4NzqZQQa/b56w7iVylxkG/8XUbM1MNzizeCM1M/Fp8XKn
 c3AIXby7NdOn9x+3a7HXV2Aac08GRoEhZr7xh8ygT6m95CCjckawmdQ7grg6NmxzwlJ9
 6Z62yZa06yKqEgnqZaH2rfEMn+qwQf0cI+j6tmUavV3hCyZ8mTbfF5n8tKdORM+n3BfV
 kcMXc3evbysh4Gc63aBiEUQQAn58uk46vDLM0LTf3UUZ5JWy8uiI8I846o6WzxoQlIj5
 JOp29R/gfa6Dgnh100wDVuFdmYGun/vU0ALjXODQOMN6DS0DA4CxfaCHv7Ak80nKY5KU
 Audg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779814598; x=1780419398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+X7aV/3RP5tjKhYyDj+mT5Zwu0Ntbg07oxPKseqsyeY=;
 b=TShemAa58vYoHHdq7ZGcdOB51AWnvGherne4ezyneltlCkFHS2/ZtGoX17CebGvZMI
 jAlwyPf9J+sbcQjVR8iCaZLrKQswJFyLz0HXVU3dsVRTpWMH0pYz6K4zSUh1mj+Ql//D
 X2OUGZNg+Q3RW+I8sDlUwmCaLoMD4txWiG0mvd6Oj8/NazvD/Mchm4YBxSryMGcbP/JH
 rG/iyz+pPnxORjpjhHI3z69ejG9xX1rt1tUcus+HieoQhdoPGss/8zLf2fxbEN0TEb24
 b0QgMxtBReGEXP7TnhEIL/qtDMgHDz+qCH2MbSp2a5/tMZVLMazSpknJteGswfijuCgx
 w0vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QGXs11WvfCF+sk+AifbTke2z2Yhe+NEpzKtUk+WpxJ4Oyy/csgkcZBmSkAMkk9ncxd9/h74MB+8mD@nongnu.org
X-Gm-Message-State: AOJu0Yz+t9iaovVF/hx88c7e1C5Fh4bk1oDdrEklcA7z2EhTDvUzC4+r
 z6HgH9WLMonjH8ydU+wxfz+hadpFUWQOlQ7OmsSjLDoxA6NxElHW9CveterNg1rm9ldsDH5PPXQ
 ojvk9TD/3ue1CUAQV9G1Y8WtnW/VeE3O9R6nloVFbNQ==
X-Gm-Gg: Acq92OHhOiwsYzF6oxSER3mA1yJQebNWfWVRPc9Ztl0+JqFEt6xqgeFCmcjOxgf/hbn
 zavzlZKFGw+e6PsnLSVM3h3CsqOO8vrAQ3PjzAlpb5JaMIbtdLhkI3zQtMb4wOWJO5QJFVsfc2b
 q68jhmb9oNqk83s5hdGw47ge807wI89qI+i9tB2GAxFINPoYfWLqkrEXQ8FlRzew4ev6dSSJRyH
 DY7oFpKPqL3+AvZXlnewn65gdLJU2cjkm1BA55jFYX71drz2lf7t0TMAht9FS2EGIRA5rRu0JHn
 tX8rVcY=
X-Received: by 2002:a05:6a00:13a6:b0:83e:b22f:373a with SMTP id
 d2e1a72fcca58-8415f31db44mr17823650b3a.11.1779814597870; Tue, 26 May 2026
 09:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
 <875x8g1pmi.fsf@draig.linaro.org>
 <CANCZdfqT7r9jcTuiwe3=CcjRExL-FP1msx-Q8ftQM5amJ_t0YQ@mail.gmail.com>
 <1795fc9c-f82e-40f1-aab6-ec24ad02a918@linaro.org>
 <CANCZdfp=mCp89NdwVzy-tEo=FNiEu6_H79r5vFRD0-Nk=Cx54Q@mail.gmail.com>
 <CAFEAcA9QeSjN1JV6ieavrr+r7viNo5maAtz5OJctcbWwTNQq9Q@mail.gmail.com>
 <CAFEAcA-bW9zOW6o2OS5uy2Q=dWvq7xQKXeDciDVU5Qs65JekHA@mail.gmail.com>
In-Reply-To: <CAFEAcA-bW9zOW6o2OS5uy2Q=dWvq7xQKXeDciDVU5Qs65JekHA@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 26 May 2026 10:56:26 -0600
X-Gm-Features: AVHnY4LLcTa5kiiFgx5jze0kKBOPSD8HbK8fzcV7uZcmiMSpAD_X-JD9ySWEoxg
Message-ID: <CANCZdfpg1rPbvWaFOfmiiTX8Q=qNxMzRbpH_rVxCOUCxV+c-dw@mail.gmail.com>
Subject: Re: Question about tb_flush()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000df54290652bb60da"
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x432.google.com
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

--000000000000df54290652bb60da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 9:23=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 26 May 2026 at 15:52, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> > Some stuff has snuck back into qemu.h again (e.g. the
> > prototype of init_main_thread() could live in user-internals.h
> > but was put in the wrong place)
>
> I just sent a patchset moving a couple of prototypes out of qemu.h.
>
> > because this kind of "looks like
> > a good place to dump random stuff" header is hard to keep clean.
> > There's probably a better name than "qemu.h" for it.
>
> While I was doing it I thought about this part. I think in an
> ideal world we would split qemu.h into different parts, e.g.
> one header for the TaskState struct definition, one for the
> user-access functions and macros, and so on (most of the QEMU
> source files including qemu.h don't need everything it is
> providing, only one of the three or four groups of APIs).
> But doing this requires coordination across linux-user and bsd-user
> so they both split the functions/types out of their qemu.h headers
> together. That doesn't really seem worth doing to me, at least
> not now while you still have a large backlog of bsd-user work
> not upstream yet.
>

Yes. This is absolutely something that I want to do, which is why I asked
the
question. I'd like to get through the backlog first (or the bulk of the
backlog)
and then start to move to a common design pattern between linux-user and
bsd-user and maybe find ways to refactor. One issue that I know of right
now is we compile common-user once for all the builds, so it doesn't depend
on TARGET defines, while what we need to do is also have something that
compiles per TARGET for some of the sharing that I see as possible and
likely
desireable (see the recent thunk.c thread).

While not worth doing TODAY, I see the light at the end of the tunnel for
upstreaming and want to start thinking about it and start studying things
so I can start a discussion in the coming months in an intelligent way.

Warner

--000000000000df54290652bb60da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 26,=
 2026 at 9:23=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Tue, 26 May 2026 at 15:52, Peter May=
dell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">pete=
r.maydell@linaro.org</a>&gt; wrote:<br>
&gt; Some stuff has snuck back into qemu.h again (e.g. the<br>
&gt; prototype of init_main_thread() could live in user-internals.h<br>
&gt; but was put in the wrong place)<br>
<br>
I just sent a patchset moving a couple of prototypes out of qemu.h.<br>
<br>
&gt; because this kind of &quot;looks like<br>
&gt; a good place to dump random stuff&quot; header is hard to keep clean.<=
br>
&gt; There&#39;s probably a better name than &quot;qemu.h&quot; for it.<br>
<br>
While I was doing it I thought about this part. I think in an<br>
ideal world we would split qemu.h into different parts, e.g.<br>
one header for the TaskState struct definition, one for the<br>
user-access functions and macros, and so on (most of the QEMU<br>
source files including qemu.h don&#39;t need everything it is<br>
providing, only one of the three or four groups of APIs).<br>
But doing this requires coordination across linux-user and bsd-user<br>
so they both split the functions/types out of their qemu.h headers<br>
together. That doesn&#39;t really seem worth doing to me, at least<br>
not now while you still have a large backlog of bsd-user work<br>
not upstream yet.<br></blockquote><div><br></div><div>Yes. This is absolute=
ly something that I want to do, which is why I asked the</div><div>question=
. I&#39;d like to get through the backlog first (or the bulk of the backlog=
)</div><div>and then start to move to a common design pattern between linux=
-user and</div><div>bsd-user and maybe find ways to refactor. One issue tha=
t I know of right</div><div>now is we compile common-user once for all the =
builds, so it doesn&#39;t depend</div><div>on TARGET defines, while what we=
 need to do is also have something that</div><div>compiles per TARGET for s=
ome of the sharing that I see as possible and likely</div><div>desireable (=
see the recent thunk.c thread).</div><div><br></div><div>While not worth do=
ing TODAY, I see the light at the end of the tunnel for</div><div>upstreami=
ng and want to start thinking about it and start studying things</div><div>=
so I can start a discussion in the coming months in an intelligent way.</di=
v><div><br></div><div>Warner=C2=A0</div></div></div>

--000000000000df54290652bb60da--

