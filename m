Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8B2C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 15:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX0pI-00045O-To; Mon, 05 Feb 2024 10:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rX0pF-000457-Ia
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:24:02 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rX0p9-0005DL-QJ
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:23:59 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5600c43caddso2481964a12.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 07:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1707146631; x=1707751431;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qKgC4fNkZjh0gZv9FplbaRUpAZRW+qJPZbdakJ9qLpI=;
 b=F8il129l2MM3YLwmguBLOj3ku7WZmyw1rNU3OUrYHa22NqVSWKTumKLR0kLVXbEBwc
 ge8z31/D5Hta4TlbSMcYMUsJ+wEX1oyvvoGBABvnz8Gu7vFPlbAFlVk9GyY5B8BAkGRt
 0QEQyeJ4J7DPFFM7VcnELwuYr+g2PkaTJ2JN6AQJxpd8sHAsxuyp8ZKOKRxMZUPaytxl
 a9o+4SOmo8/Uz/RPVOovJqdDMUYq6Z6LgmdvtA5DSgewNQS6DHWuXm4VUPBjsMpHMdwF
 UE5fC0l3skXyIL6Np9J67n8MqTLD67Xe1HsgLD9qFhrmZX7twSmFrsH4QNS71X9HFQOw
 8HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707146631; x=1707751431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qKgC4fNkZjh0gZv9FplbaRUpAZRW+qJPZbdakJ9qLpI=;
 b=h1wP9tAoskIQww3TEgTBExSObiGoCrI/Xtvkipn7G5ax6d0GBiB24ViWt2kJFibb2r
 n6RLEym4ZNdNi8ZJta07Rwzb/eZBtdHVr9zhc1jQzWNW/53fAlMxGanA1Qj9r+Z5C1BR
 d8AbumVcq5Jm/aDb3SkXuqfYbmjTZEgdfDswcABa1z2SYWyw90GSfeTAPejpSA4h8zZh
 tBjbFED/46c2QAR606QGm9RkPmdN03pnrptyOJJ0F54zrEKy9QRKMdNDbf+XxjoKDN9Z
 H/QY8qyC8nyImHRzxGgdbXxavWDqTWe601+oSw67Upey0/5XoHmkJtKuyYXUkhNGYhTb
 OeQQ==
X-Gm-Message-State: AOJu0Yz4fFp63BvgJ5QHefxx2ljzZpNiQOU8jV/wE3cHv7wH37XjRoRl
 cbqSGlQoEcRBUl+kd9SDpph0ucAuMJQFA/Dt9Tandhm8kJtymYo0lkM7IIYLS2FXfmIvBI0NFKS
 SCUFsMtDgbJrcUm4feLY6ZTXWI3AhgmlfIaxLcQ==
X-Google-Smtp-Source: AGHT+IGywm332YHpXvdCMZulAIBS3VzxYyhuGlknXBjJ9xXyFy0b+L5BAqnbRrA2+mGa2A12f0eQVgIIHlnE+Tqb7G4=
X-Received: by 2002:aa7:d58b:0:b0:55f:832f:97da with SMTP id
 r11-20020aa7d58b000000b0055f832f97damr5189797edq.23.1707146630333; Mon, 05
 Feb 2024 07:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20240125194840.1564-1-iii@linux.ibm.com>
 <20240125194840.1564-4-iii@linux.ibm.com>
 <33c9ccef-fa8f-41e4-a7a1-17c3dffb9d9d@linaro.org>
 <Zbp4ekYJLQB-BIFo@redhat.com>
In-Reply-To: <Zbp4ekYJLQB-BIFo@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 5 Feb 2024 08:23:41 -0700
Message-ID: <CANCZdfotNMgPadLA0o9+POcLeTN-rGoR+XkbqBHtjd+cZMy0Fg@mail.gmail.com>
Subject: Re: [PATCH 3/3] meson: Disable CONFIG_NOTIFY1 on FreeBSD
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007b1e6d0610a40cac"
Received-SPF: none client-ip=2a00:1450:4864:20::52b;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000007b1e6d0610a40cac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:42=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Wed, Jan 31, 2024 at 05:24:10PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi,
> >
> > Warner, do you remember what this is about?
> >
> > (
> https://cgit.freebsd.org/ports/commit/emulators/qemu-devel/files/patch-ut=
il_meson.build?id=3D2ab482e2c8f51eae7ffd747685b7f181fe1b3809
> > isn't very verbose).
>
> That's simply going to workaround our incomplete feature
> check. We look for sys/inotify.h and if present, we
> assume that is in the C library. That's true on Linux,
> but not true on *BSD, hence the undefined symbol.
>
> We need to augment the header file check with a linker
> symbol check for the C library.
>
> If we wanted to also check for -linotify that'd make
> it portable to BSD, but not the behaviour difference
> mentioned below.
>
> >
> > On 25/1/24 20:48, Ilya Leoshkevich wrote:
> > > make vm-build-freebsd fails with:
> > >
> > >      ld: error: undefined symbol: inotify_init1
> > >      >>> referenced by filemonitor-inotify.c:183
> (../src/util/filemonitor-inotify.c:183)
> > >      >>>
>  util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive
> libqemuutil.a
> > >
> > > On FreeBSD inotify functions are defined in libinotify.so, so it migh=
t
> > > be tempting to add it to the dependencies. Doing so, however, reveals
> > > that this library handles rename events differently from Linux:
> > >
> > >      $ FILEMONITOR_DEBUG=3D1 build/tests/unit/test-util-filemonitor
> > >      Rename /tmp/test-util-filemonitor-K13LI2/fish/one.txt ->
> /tmp/test-util-filemonitor-K13LI2/two.txt
> > >      Event id=3D200000000 event=3D2 file=3Done.txt
> > >      Queue event id 200000000 event 2 file one.txt
> > >      Queue event id 100000000 event 2 file two.txt
> > >      Queue event id 100000002 event 2 file two.txt
> > >      Queue event id 100000000 event 0 file two.txt
> > >      Queue event id 100000002 event 0 file two.txt
> > >      Event id=3D100000000 event=3D0 file=3Dtwo.txt
> > >      Expected event 0 but got 2
>
> Interesting. So In the "Rename" test, the destination already exists.
>
> BSD is thus reporting that 'two.txt' is deleted, before being (re)created
> Linux is only reporting 'two.txt' is created.
>
> I don't think we can easily paper over this difference. The easiest is
> probably to conditionalize the test
>
>  git diff
> diff --git a/tests/unit/test-util-filemonitor.c
> b/tests/unit/test-util-filemonitor.c
> index a22de27595..c3b2006365 100644
> --- a/tests/unit/test-util-filemonitor.c
> +++ b/tests/unit/test-util-filemonitor.c
> @@ -281,6 +281,14 @@ test_file_monitor_events(void)
>          { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
>            .filesrc =3D "one.txt", .watchid =3D &watch1,
>            .eventid =3D QFILE_MONITOR_EVENT_DELETED },
> +#ifdef __FreeBSD__
> +        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
> +          .filesrc =3D "two.txt", .watchid =3D &watch0,
> +          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
> +        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
> +          .filesrc =3D "two.txt", .watchid =3D &watch2,
> +          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
> +#endif
>          { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
>            .filesrc =3D "two.txt", .watchid =3D &watch0,
>            .eventid =3D QFILE_MONITOR_EVENT_CREATED },
>

I agree this is likely the best course of action. Has anybody filed a bug
at https://bugs.freebsd.org?

Warner

--0000000000007b1e6d0610a40cac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 31, 2024 at 9:42=E2=80=AF=
AM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berra=
nge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Wed, Jan 31, 2024 at 05:24:10PM +0100, Philippe Mathieu-Da=
ud=C3=A9 wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; Warner, do you remember what this is about?<br>
&gt; <br>
&gt; (<a href=3D"https://cgit.freebsd.org/ports/commit/emulators/qemu-devel=
/files/patch-util_meson.build?id=3D2ab482e2c8f51eae7ffd747685b7f181fe1b3809=
" rel=3D"noreferrer" target=3D"_blank">https://cgit.freebsd.org/ports/commi=
t/emulators/qemu-devel/files/patch-util_meson.build?id=3D2ab482e2c8f51eae7f=
fd747685b7f181fe1b3809</a><br>
&gt; isn&#39;t very verbose).<br>
<br>
That&#39;s simply going to workaround our incomplete feature<br>
check. We look for sys/inotify.h and if present, we<br>
assume that is in the C library. That&#39;s true on Linux,<br>
but not true on *BSD, hence the undefined symbol.<br>
<br>
We need to augment the header file check with a linker<br>
symbol check for the C library.<br>
<br>
If we wanted to also check for -linotify that&#39;d make<br>
it portable to BSD, but not the behaviour difference<br>
mentioned below.<br>
<br>
&gt; <br>
&gt; On 25/1/24 20:48, Ilya Leoshkevich wrote:<br>
&gt; &gt; make vm-build-freebsd fails with:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 ld: error: undefined symbol: inotify_init1<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; referenced by filemonitor-inotif=
y.c:183 (../src/util/filemonitor-inotify.c:183)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0util_filemonitor-inotify.c.o:(qemu_file_monitor_new=
) in archive libqemuutil.a<br>
&gt; &gt; <br>
&gt; &gt; On FreeBSD inotify functions are defined in libinotify.so, so it =
might<br>
&gt; &gt; be tempting to add it to the dependencies. Doing so, however, rev=
eals<br>
&gt; &gt; that this library handles rename events differently from Linux:<b=
r>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 $ FILEMONITOR_DEBUG=3D1 build/tests/unit/test=
-util-filemonitor<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Rename /tmp/test-util-filemonitor-K13LI2/fish=
/one.txt -&gt; /tmp/test-util-filemonitor-K13LI2/two.txt<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Event id=3D200000000 event=3D2 file=3Done.txt=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Queue event id 200000000 event 2 file one.txt=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Queue event id 100000000 event 2 file two.txt=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Queue event id 100000002 event 2 file two.txt=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Queue event id 100000000 event 0 file two.txt=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Queue event id 100000002 event 0 file two.txt=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Event id=3D100000000 event=3D0 file=3Dtwo.txt=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Expected event 0 but got 2<br>
<br>
Interesting. So In the &quot;Rename&quot; test, the destination already exi=
sts.<br>
<br>
BSD is thus reporting that &#39;two.txt&#39; is deleted, before being (re)c=
reated<br>
Linux is only reporting &#39;two.txt&#39; is created.<br>
<br>
I don&#39;t think we can easily paper over this difference. The easiest is<=
br>
probably to conditionalize the test<br>
<br>
=C2=A0git diff<br>
diff --git a/tests/unit/test-util-filemonitor.c b/tests/unit/test-util-file=
monitor.c<br>
index a22de27595..c3b2006365 100644<br>
--- a/tests/unit/test-util-filemonitor.c<br>
+++ b/tests/unit/test-util-filemonitor.c<br>
@@ -281,6 +281,14 @@ test_file_monitor_events(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .type =3D QFILE_MONITOR_TEST_OP_EVENT,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.filesrc =3D &quot;one.txt&quot;, =
.watchid =3D &amp;watch1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.eventid =3D QFILE_MONITOR_EVENT_D=
ELETED },<br>
+#ifdef __FreeBSD__<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { .type =3D QFILE_MONITOR_TEST_OP_EVENT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .filesrc =3D &quot;two.txt&quot;, .watc=
hid =3D &amp;watch0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .eventid =3D QFILE_MONITOR_EVENT_DELETE=
D },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { .type =3D QFILE_MONITOR_TEST_OP_EVENT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .filesrc =3D &quot;two.txt&quot;, .watc=
hid =3D &amp;watch2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .eventid =3D QFILE_MONITOR_EVENT_DELETE=
D },<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .type =3D QFILE_MONITOR_TEST_OP_EVENT,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.filesrc =3D &quot;two.txt&quot;, =
.watchid =3D &amp;watch0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.eventid =3D QFILE_MONITOR_EVENT_C=
REATED },<br></blockquote><div><br></div><div>I agree this is likely the be=
st course of action. Has anybody filed a bug at <a href=3D"https://bugs.fre=
ebsd.org">https://bugs.freebsd.org</a>?</div><div><br></div><div>Warner <br=
></div></div></div>

--0000000000007b1e6d0610a40cac--

