Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504E0E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEta-00007t-Af; Mon, 16 Dec 2024 12:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNEtY-00007d-Hj
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNEtV-0001sL-Gf
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734370111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HMJkkyR7sgMKNGc+S7+MJpnO3O5Hh3/bTITJGIiLBNE=;
 b=PiIncDmHqVzrWyA85jiM0A9umyDoFc8QVulxBsNiIlhp+QL3zLuRfaG6IocDnw9Pph4Ion
 ZZWvFkPywlVsJ+vY78k39BhBJufzwbu+18z+F3o5CO2xtPDC7M8g3I3waZNSgJ3sPI5Ska
 fB9WW3VUrt1ga+BNg0NvrNiENPlkhbQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-yyzb7U01OimdAt1jWvyrgg-1; Mon, 16 Dec 2024 12:28:30 -0500
X-MC-Unique: yyzb7U01OimdAt1jWvyrgg-1
X-Mimecast-MFC-AGG-ID: yyzb7U01OimdAt1jWvyrgg
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8edb40083so105304076d6.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734370110; x=1734974910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HMJkkyR7sgMKNGc+S7+MJpnO3O5Hh3/bTITJGIiLBNE=;
 b=II6+SqQpJ4k7bJhVfRUr0jHHs2dFcFV/+iE37zfaZsG7J9gP1RpnvBXb/lFqk+VScQ
 tu50Sl9w0aJLyRyvCFAPHxbEVOyJe3FOg7mwt/D2Mo7WNKaQXs535imUMFXV4tQ011KG
 ZsDcDUOm4X/DhYzb1QTrUc90AGtiOiCT/bdhCy7Hd8ew02wJm7uDae57YaYXrhdxrfni
 4X59rHrYP0yI8DHHkM5V7m3gQTUWKztmA4kaOK1wg+FQmwMBAPx4CTirUYG0xUhlqHw6
 A/mVYfX6iDIIV6EZ5N0WY48fHb1HxC5OPwE/sqHdTd7pHXLSU1k2KF/zf7evhsbaHR3v
 y1GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1AK+9vTXxr2SfqXHq0P0bmT7B+NlOQa5FpR5gzK6mYO2F+Erktx3Z7kcZDQYmajaQgftc9gIakP6B@nongnu.org
X-Gm-Message-State: AOJu0Yzy4QXQ0phrBVQSr0o41o2TqldzR9Ntq2hhhsGQ9SISF8C4CeY1
 OdOx9L3R8orK6C8Cm4i4IV3Q9qCGHYfMFdGtuw/o9rusCSpyw0R/GnGy7hvveNNeHOVnjmrMkNq
 nFeceldYEiYPO0YV+JKjUZUS+5DDYOhq/xI6u6qPIdrOToT/Jh/AOJRJz+u6nfPTx1xP14jXIP6
 ahC/bhQR8vFF//+Q19SoaatBlAhjY=
X-Gm-Gg: ASbGnctFJgU7od/HJvVph/XZdYk4YKCzdVLJr2UAwXe/VkB20QE+2s6gZwu+ha0ZxYR
 yrJ0Z6Dqg3w25Tyjbo72u+WpD2H8/uP6PU2qCN1Pg
X-Received: by 2002:a05:6214:202c:b0:6dc:c8bc:f913 with SMTP id
 6a1803df08f44-6dcf4c84ad6mr2060766d6.15.1734370110058; 
 Mon, 16 Dec 2024 09:28:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB30Z1z3mKBXF24asuySrQPsivaWfz7Ad2KSPVt3rk7MSK4l11foTqEEbLvJz/4rQmnwcEB21LqcR2vblO6as=
X-Received: by 2002:a05:6214:202c:b0:6dc:c8bc:f913 with SMTP id
 6a1803df08f44-6dcf4c84ad6mr2060516d6.15.1734370109824; Mon, 16 Dec 2024
 09:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20241216161413.1644171-1-peterx@redhat.com>
 <20241216161413.1644171-2-peterx@redhat.com>
 <CAFEAcA_u++fJudO1ca9q76NYWTg75PRGAEHBqDyjUDEnR5m8Cw@mail.gmail.com>
 <Z2BfhvPfYNYoHA5Z@x1n>
In-Reply-To: <Z2BfhvPfYNYoHA5Z@x1n>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 16 Dec 2024 19:28:19 +0200
Message-ID: <CAPMcbCq6bU_L3xgj1tC9hDpDSG5_ppHgxRYO8qww49PSAGdCWg@mail.gmail.com>
Subject: Re: [PATCH 1/3] osdep: Add qemu_mkdir_with_parents()
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="0000000000004e32410629668277"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--0000000000004e32410629668277
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 7:12=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:

> On Mon, Dec 16, 2024 at 04:56:33PM +0000, Peter Maydell wrote:
> > On Mon, 16 Dec 2024 at 16:14, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > QEMU uses g_mkdir_with_parents() a lot, especially in the case where
> the
> > > failure case is ignored so an abort is expected when happened.
> > >
> > > Provide a helper qemu_mkdir_with_parents() to do that, and use it in
> the
> > > two cases in qga/.  To be used in more places later.
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  include/qemu/osdep.h     | 7 +++++++
> > >  qga/commands-posix-ssh.c | 8 ++------
> > >  util/osdep.c             | 6 ++++++
> > >  3 files changed, 15 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > > index fdff07fd99..dc67fb2e5e 100644
> > > --- a/include/qemu/osdep.h
> > > +++ b/include/qemu/osdep.h
> > > @@ -828,6 +828,13 @@ static inline int
> platform_does_not_support_system(const char *command)
> > >  }
> > >  #endif /* !HAVE_SYSTEM_FUNCTION */
> > >
> > > +/**
> > > + * qemu_mkdir_with_parents:
> > > + *
> > > + * Create directories with parents.  Abort on failures.
> > > + */
> > > +void qemu_mkdir_with_parents(const char *dir, int mode);
> >
> > Don't put new function prototypes into osdep.h, please.
> > It is included by every single C file in the codebase.
> > There is always somewhere better to put things.
> >
> > QEMU shouldn't abort on things that are kind of expected
> > OS errors like "couldn't create a directory", so I'm
> > a bit dubious about this function.
>
> That's what qga/ is doing right now, rather than a decision made in this
> series, though.
>

I think we need to fix this behavior in QGA and report the real error,
instead of wrapping the `assert` into some function that will make
it not so obvious.


>
> >
> > The two use cases in this commit seem to be test code,
> > so asserting is reasonable. But a "for test code only"
> > function should go in a header file that's only included
> > by test cases and the comment should be clear about that,
> > and it shouldn't have a function name that implies
> > "this is the normal way any code in QEMU might want
> > to create directories".
> >
> > For the qtest tests, I currently ignore Coverity
> > reports in our test code unless it seems particularly
> > worthwhile to fix them. This is especially true for
> > complaints about unchecked return values and the like.
>
> OK.
>
> >
> > Even in a test case it is still not great to call
> > g_assert(), because this makes the test binary crash,
> > rather than reporting an error. The surrounding TAP
> > protocol parsing code then doesn't report the test
> > failure the way you might like.
>
> Hmm, I normally always think crash is better especially in tests to keep
> everything around when an error happens as general rule.
>
> TAP parsing especially on errors is more useful to me when we constantly
> expect failures, IIUC that's not the case for QEMU tests?  Because I do
> expect the CI to pass all the tests always.  But I also admit I don't kno=
w
> the whole picture of QEMU tests..
>
> If we don't care about retval checks in tests, we can definitely drop pat=
ch
> 1-2 here in all cases.
>
> Thanks,
>
> --
> Peter Xu
>
>

--0000000000004e32410629668277
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 16,=
 2024 at 7:12=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">=
peterx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Mon, Dec 16, 2024 at 04:56:33PM +0000, Peter Maydell wr=
ote:<br>
&gt; On Mon, 16 Dec 2024 at 16:14, Peter Xu &lt;<a href=3D"mailto:peterx@re=
dhat.com" target=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; QEMU uses g_mkdir_with_parents() a lot, especially in the case wh=
ere the<br>
&gt; &gt; failure case is ignored so an abort is expected when happened.<br=
>
&gt; &gt;<br>
&gt; &gt; Provide a helper qemu_mkdir_with_parents() to do that, and use it=
 in the<br>
&gt; &gt; two cases in qga/.=C2=A0 To be used in more places later.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" =
target=3D"_blank">peterx@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 include/qemu/osdep.h=C2=A0 =C2=A0 =C2=A0| 7 +++++++<br>
&gt; &gt;=C2=A0 qga/commands-posix-ssh.c | 8 ++------<br>
&gt; &gt;=C2=A0 util/osdep.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 6 ++++++<br>
&gt; &gt;=C2=A0 3 files changed, 15 insertions(+), 6 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h<br>
&gt; &gt; index fdff07fd99..dc67fb2e5e 100644<br>
&gt; &gt; --- a/include/qemu/osdep.h<br>
&gt; &gt; +++ b/include/qemu/osdep.h<br>
&gt; &gt; @@ -828,6 +828,13 @@ static inline int platform_does_not_support_=
system(const char *command)<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;=C2=A0 #endif /* !HAVE_SYSTEM_FUNCTION */<br>
&gt; &gt;<br>
&gt; &gt; +/**<br>
&gt; &gt; + * qemu_mkdir_with_parents:<br>
&gt; &gt; + *<br>
&gt; &gt; + * Create directories with parents.=C2=A0 Abort on failures.<br>
&gt; &gt; + */<br>
&gt; &gt; +void qemu_mkdir_with_parents(const char *dir, int mode);<br>
&gt; <br>
&gt; Don&#39;t put new function prototypes into osdep.h, please.<br>
&gt; It is included by every single C file in the codebase.<br>
&gt; There is always somewhere better to put things.<br>
&gt; <br>
&gt; QEMU shouldn&#39;t abort on things that are kind of expected<br>
&gt; OS errors like &quot;couldn&#39;t create a directory&quot;, so I&#39;m=
<br>
&gt; a bit dubious about this function.<br>
<br>
That&#39;s what qga/ is doing right now, rather than a decision made in thi=
s<br>
series, though.<br></blockquote><div><br></div>I think we need to fix this =
behavior in QGA and report the real error,</div><div class=3D"gmail_quote g=
mail_quote_container">instead of wrapping the `assert` into some function t=
hat will make</div><div class=3D"gmail_quote gmail_quote_container">it not =
so obvious.<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
&gt; <br>
&gt; The two use cases in this commit seem to be test code,<br>
&gt; so asserting is reasonable. But a &quot;for test code only&quot;<br>
&gt; function should go in a header file that&#39;s only included<br>
&gt; by test cases and the comment should be clear about that,<br>
&gt; and it shouldn&#39;t have a function name that implies<br>
&gt; &quot;this is the normal way any code in QEMU might want<br>
&gt; to create directories&quot;.<br>
&gt; <br>
&gt; For the qtest tests, I currently ignore Coverity<br>
&gt; reports in our test code unless it seems particularly<br>
&gt; worthwhile to fix them. This is especially true for<br>
&gt; complaints about unchecked return values and the like.<br>
<br>
OK.<br>
<br>
&gt; <br>
&gt; Even in a test case it is still not great to call<br>
&gt; g_assert(), because this makes the test binary crash,<br>
&gt; rather than reporting an error. The surrounding TAP<br>
&gt; protocol parsing code then doesn&#39;t report the test<br>
&gt; failure the way you might like.<br>
<br>
Hmm, I normally always think crash is better especially in tests to keep<br=
>
everything around when an error happens as general rule.<br>
<br>
TAP parsing especially on errors is more useful to me when we constantly<br=
>
expect failures, IIUC that&#39;s not the case for QEMU tests?=C2=A0 Because=
 I do<br>
expect the CI to pass all the tests always.=C2=A0 But I also admit I don&#3=
9;t know<br>
the whole picture of QEMU tests..<br>
<br>
If we don&#39;t care about retval checks in tests, we can definitely drop p=
atch<br>
1-2 here in all cases.<br>
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div></div>

--0000000000004e32410629668277--


