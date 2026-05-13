Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7675CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 19:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNF8g-0003XB-S3; Wed, 13 May 2026 15:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wNF8R-0003WC-1n
 for qemu-devel@nongnu.org; Wed, 13 May 2026 15:20:50 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wNF8O-000808-QJ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 15:20:46 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67b8d9c26bbso13061535a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 12:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778700043; cv=none;
 d=google.com; s=arc-20240605;
 b=WvtbM/WtpObYcF1DJFhLeagaCObeRq8L5seEE8a4AAnjkqXscHhTEYki7RExoy9sdm
 hrYYktYv7y2WTr//bfTEqeMjXxAtivc/Q1DlZW3jEK02f5F4/D0Qzu3KMnqXov5PSPh8
 IE2NLgkxCcH32XIvpppRyAOq7hNxBNK9m78ahnATP7Gp++zDNkL3hxoQ7um2Gi4W6/Xs
 hdfXPj17V0UQTaNVsmqlvQq0wVEsaU8PEEpMjoNVinOVDvbuGjLae4luQsMPMthECCkH
 bxnuNa7u25C0NdoOxAY3H2KsxYEcF30qJIG845ihVYpCiNnFry92bFF8oRaekMby9/5K
 AOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=35cIhKXNT4SosenXEZ/NsYGgQb556rN2L9OOaTqOmzo=;
 fh=Bd1+Ll5QK3B2bZzgS7YzOYJO5c/w+Zc+CoVHwXb6vpM=;
 b=QAuVQKF9SD5sKsOpYLZh1Smjf6ezRkYpRE+rCys7XP7uOgCuNhEiKAz6a3MH4V/pb+
 mFkSrbTBR+C+JVKc2ZB7FP5ymXihuK76jHvkf9Fh4a2Pa0mKXHc3WgGeFfAp6KVearaf
 kuMsDKwvziebbCnEsNu/Pn/p7R6CVDeAfwX+RlWlJurQL56HHR3/HJswk2P5+Y1RHfpo
 rQ3PWWMueXbyoLTmoecBtB8wlhl9vr8PtchhMsfMWPaSDllbcGH/SNU42Kjvuke06ezC
 LMiQJm7+QBSt2bC7T/N+/HgBSGreXfUaIBVZKYXstZzcG5vZncAIFnd7BPedA8+XV25u
 tr7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778700043; x=1779304843; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=35cIhKXNT4SosenXEZ/NsYGgQb556rN2L9OOaTqOmzo=;
 b=Rjcs0vsgRM8h5rEtnAksYj3pGM0ZXy2MY6YbfutUbF3RWZAvIpO2emayvx1R/n2fyi
 Q2CiSZlLPkQCl8EPXLwNhUXZjUxCv7SY/t2ordI3OTkzu3WQwwKBGbWl/6lp7Us78XIo
 abio8rejt82GHCYjBeu6r4jD+H3sN/R+tYRUoHiBiloLjs2XR69Wi0voOf9h8KhKQ/06
 4o3sbwQhBcJVH3DIP+2DnrkTW+nQjzvpyZynrH8Tzflpttnc7cHmTGbbu2hEsWDfgu8n
 qbM2rXGbyTEztnXt14aqKEv10MnSdtfhHCzUJpwBrYlJ6bRTTspgO79xeFKaQXKOIhi3
 V9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778700043; x=1779304843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35cIhKXNT4SosenXEZ/NsYGgQb556rN2L9OOaTqOmzo=;
 b=AjznWWGrY9UfoiSJ7xoBEGrKSb9U+C+Rp3QA7AfrkuVdkWhyuLhEe7jI1tgMmDB+YK
 Ax/ddVbpKcrvhS4goUWUaHVtQ9U/9Lyy9iR3BqAweTjqqKM8koN4nTf5vnGJP3jOm8AS
 zFdblUsXCNMBjr2ITyAR0NL8CbH5n6fhWccX41C8JZdLXcatZ/UzXRjo6msSm4ufxbCq
 K+mkrfXBN73c4y2MKYwTcqAatVJ0Ky+VkeoFXMA1Vj9kTPMNOl3QiETMy66Mc9/v4t49
 nnXO8eeBAoA5stcKWbHmygK5M8SIjx+CVN2NbsN/ZpTuP9maJX9X8VHPH0A2tNwNcZKk
 qQvw==
X-Gm-Message-State: AOJu0YyYUTg+YhU2ZMf4+ZrZyiIKr2Ggc0lUs/EsEf1tEhhP8OzqyV0t
 p/3htZFk2o+Er9kweJQJZxd1hfmN0XjrTTaocP4nN+o5y3xelswvoIbYssg+ugTtAFz6soebYRp
 UO/CCZ/Mrui097X0t0ydoGIhlW82fzgo=
X-Gm-Gg: Acq92OFBOvM+xTLPbhSFdwT0b0jKZp5e8jdk9kOcANH9BKWPZIO3ZGFfEFPvOw/XxnL
 fnKpYHO/YuoG5pQcZxtCzAaqgMjoVgJHQjG2/XdtzLpq1esakpVUYx1+IvaViiMEZY8OANrjSQr
 8KErgkfvaxaxs7T17gA7qvZKvjGbYMemx+eM4Mnk8OJYYhFjkToApLAOJfg7ybtEoZ2AI8HK/yM
 vMRMYXo9avqeJ17EaNpHw94kJi4x7wtOwKFpwMLUEnUnYfjzJIBDb7Lz8ShNEZPNK5UNm8+gOI2
 nL7Em7EwrSUZRejQE+PjYFURjaSB6/RMUWf1SQ==
X-Received: by 2002:a05:6402:e10:b0:67c:57dc:eb45 with SMTP id
 4fb4d7f45d1cf-682a77ffe77mr2371017a12.18.1778700042891; Wed, 13 May 2026
 12:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
 <CAJSP0QVw+GHOC9_mOcn+V6BHZe5BR1jQyDJ1GocGaqiB_GSoBw@mail.gmail.com>
 <CAJ+F1C+-cr+Sa557xLFcHhCEOsccUHAJSyjPF5E8sGULEKQPhA@mail.gmail.com>
 <CAJSP0QVgGW74x4o3EfY09g0ErgoGvwBhck4iNC7RDe+9CC9zOw@mail.gmail.com>
 <CAJ+F1C+5szDcAd2ut4-=FEZLPXyZudwPiybFfgbMOGfj4fEOYQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+5szDcAd2ut4-=FEZLPXyZudwPiybFfgbMOGfj4fEOYQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 13 May 2026 15:20:29 -0400
X-Gm-Features: AVHnY4IsQPXHSI9XlUONKmYqgmD18otIqc5zA26ehWJlGdHVSMRqHULr_QM9ltQ
Message-ID: <CAJSP0QUbCKixqZ+8XFipivHt+JXOpj4Zrt-9kRWs8ZFbBicNqA@mail.gmail.com>
Subject: Re: [PULL 00/24] Qom patches
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000037f7b30651b7e0d1"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000037f7b30651b7e0d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026, 15:16 Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat=
.com>
wrote:

> Hi
>
> On Wed, May 13, 2026 at 11:05=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.=
com>
> wrote:
> >
> > On Wed, May 13, 2026 at 3:49=E2=80=AFAM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > >
> > > Hi Stefan
> > >
> > > On Wed, May 13, 2026 at 3:20=E2=80=AFAM Stefan Hajnoczi <stefanha@gma=
il.com>
> wrote:
> > > >
> > > > On Mon, May 11, 2026 at 4:21=E2=80=AFPM <marcandre.lureau@redhat.co=
m> wrote:
> > > > >
> > > > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > >
> > > > > The following changes since commit
> 5e61afe211e82a9af15a8794a0bd29bb574e953b:
> > > > >
> > > > >   Merge tag 'ui-pull-request' of
> https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11
> 10:49:53 -0400)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   https://gitlab.com/marcandre.lureau/qemu.git
> tags/qom-pull-request
> > > > >
> > > > > for you to fetch changes up to
> bc61a3209bf064826481a5f8f2b4feb47c70b02f:
> > > > >
> > > > >   target/s390x: add gen-features.h dependency to s390x_system_ss
> (2026-05-11 23:59:33 +0400)
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > QOM object lifecycle fixes
> > > > >
> > > > > ----------------------------------------------------------------
> > > >
> > > > Hi Marc-Andr=C3=A9,
> > > > I'm not sure if this CI failure is related to this pull request, bu=
t
> > > > there is a dbus-vnc issue:
> > > >
> > > > >>> ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summa=
ry=3D1
> QTEST_QEMU_VNC_BINARY=3D./tools/qemu-vnc/qemu-vnc MESON_TEST_ITERATION=3D=
1
> PYTHON=3D/home/gitlab-runner/builds/P3MFS4LUf/0/qemu-project/qemu/build/p=
yvenv/bin/python3
> QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon
> G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/P3MFS4LUf/0/qemu-project/=
qemu/tests/dbus-daemon.sh
> QTEST_QEMU_IMG=3D./qemu-img QTEST_QEMU_BINARY=3D./qemu-system-x86_64
> UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pr=
int_stacktrace=3D1
> RUST_BACKTRACE=3D1 MALLOC_PERTURB_=3D211
> MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pri=
nt_stacktrace=3D1
> /home/gitlab-runner/builds/P3MFS4LUf/0/qemu-project/qemu/build/tests/qtes=
t/dbus-vnc-test
> --tap -k
> > > >
> > > > 754/1075 /x86_64/dbus-vnc/password-auth -
> > > > ERROR:../tests/qtest/dbus-vnc-test.c:621:test_dbus_vnc_password_aut=
h:
> > > > assertion failed (qemu_vnc1_server_get_auth(proxy) =3D=3D "vnc"): (=
"none"
> > > > =3D=3D "vnc") FAIL
> > > >
> > > > https://gitlab.com/qemu-project/qemu/-/jobs/14337427774#L5512
> > > >
> > > > Any ideas?
> > >
> > > Embarrassingly, I have no idea. Before org.qemu.vnc is exposed by
> > > qemu-vnc (and the auth is checked by the test), qemu-vnc must have
> > > started a VNC server successfully (vnc_display_new)..
> > >
> > > Fwiw, the tests runs quite smoothly locally with meson test --repeat
> > > 1000  (some time out sometime, due to heavy load).
> > >
> > > Let's mark/run it as QEMU_TEST_FLAKY_TESTS until I figure out?
> >
> > If it helps, your last ui pull request seems to be the first
> > occurrence of this failure:
> >
> https://gitlab.com/qemu-project/qemu/-/commit/5e61afe211e82a9af15a8794a0b=
d29bb574e953b
> >
> > If you'd like me to run CI on a test branch, just let me know.
>
> It's new code, from the patches introducing qemu-vnc & the test. Let's
> just skip the test for now by default.
> (
> https://patchew.org/QEMU/20260513082517.1720433-1-marcandre.lureau@redhat=
.com/
> )
> Would you like me to send a new PR?
>

No, it's okay. I can merge your patch directly into master.

Stefan

>

--00000000000037f7b30651b7e0d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 13, 2026, 15:16 Marc=
-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marca=
ndre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Hi<br>
<br>
On Wed, May 13, 2026 at 11:05=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mai=
lto:stefanha@gmail.com" target=3D"_blank" rel=3D"noreferrer">stefanha@gmail=
.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, May 13, 2026 at 3:49=E2=80=AFAM Marc-Andr=C3=A9 Lureau<br>
&gt; &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hi Stefan<br>
&gt; &gt;<br>
&gt; &gt; On Wed, May 13, 2026 at 3:20=E2=80=AFAM Stefan Hajnoczi &lt;<a hr=
ef=3D"mailto:stefanha@gmail.com" target=3D"_blank" rel=3D"noreferrer">stefa=
nha@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Mon, May 11, 2026 at 4:21=E2=80=AFPM &lt;<a href=3D"mailt=
o:marcandre.lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcand=
re.lureau@redhat.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marc=
andre.lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lur=
eau@redhat.com</a>&gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The following changes since commit 5e61afe211e82a9af15a=
8794a0bd29bb574e953b:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0Merge tag &#39;ui-pull-request&#39; of <a h=
ref=3D"https://gitlab.com/marcandre.lureau/qemu" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://gitlab.com/marcandre.lureau/qemu</a> into sta=
ging (2026-05-11 10:49:53 -0400)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; are available in the Git repository at:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0<a href=3D"https://gitlab.com/marcandre.lur=
eau/qemu.git" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitla=
b.com/marcandre.lureau/qemu.git</a> tags/qom-pull-request<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; for you to fetch changes up to bc61a3209bf064826481a5f8=
f2b4feb47c70b02f:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0target/s390x: add gen-features.h dependency=
 to s390x_system_ss (2026-05-11 23:59:33 +0400)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -------------------------------------------------------=
---------<br>
&gt; &gt; &gt; &gt; QOM object lifecycle fixes<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -------------------------------------------------------=
---------<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hi Marc-Andr=C3=A9,<br>
&gt; &gt; &gt; I&#39;m not sure if this CI failure is related to this pull =
request, but<br>
&gt; &gt; &gt; there is a dbus-vnc issue:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt;&gt; ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=
=3D1:print_summary=3D1 QTEST_QEMU_VNC_BINARY=3D./tools/qemu-vnc/qemu-vnc ME=
SON_TEST_ITERATION=3D1 PYTHON=3D/home/gitlab-runner/builds/P3MFS4LUf/0/qemu=
-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D.=
/storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runne=
r/builds/P3MFS4LUf/0/qemu-project/qemu/tests/dbus-daemon.sh QTEST_QEMU_IMG=
=3D./qemu-img QTEST_QEMU_BINARY=3D./qemu-system-x86_64 UBSAN_OPTIONS=3Dhalt=
_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 RUS=
T_BACKTRACE=3D1 MALLOC_PERTURB_=3D211 MSAN_OPTIONS=3Dhalt_on_error=3D1:abor=
t_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 /home/gitlab-runner/b=
uilds/P3MFS4LUf/0/qemu-project/qemu/build/tests/qtest/dbus-vnc-test --tap -=
k<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 754/1075 /x86_64/dbus-vnc/password-auth -<br>
&gt; &gt; &gt; ERROR:../tests/qtest/dbus-vnc-test.c:621:test_dbus_vnc_passw=
ord_auth:<br>
&gt; &gt; &gt; assertion failed (qemu_vnc1_server_get_auth(proxy) =3D=3D &q=
uot;vnc&quot;): (&quot;none&quot;<br>
&gt; &gt; &gt; =3D=3D &quot;vnc&quot;) FAIL<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/14337=
427774#L5512" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitla=
b.com/qemu-project/qemu/-/jobs/14337427774#L5512</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Any ideas?<br>
&gt; &gt;<br>
&gt; &gt; Embarrassingly, I have no idea. Before org.qemu.vnc is exposed by=
<br>
&gt; &gt; qemu-vnc (and the auth is checked by the test), qemu-vnc must hav=
e<br>
&gt; &gt; started a VNC server successfully (vnc_display_new)..<br>
&gt; &gt;<br>
&gt; &gt; Fwiw, the tests runs quite smoothly locally with meson test --rep=
eat<br>
&gt; &gt; 1000=C2=A0 (some time out sometime, due to heavy load).<br>
&gt; &gt;<br>
&gt; &gt; Let&#39;s mark/run it as QEMU_TEST_FLAKY_TESTS until I figure out=
?<br>
&gt;<br>
&gt; If it helps, your last ui pull request seems to be the first<br>
&gt; occurrence of this failure:<br>
&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/commit/5e61afe211e82=
a9af15a8794a0bd29bb574e953b" rel=3D"noreferrer noreferrer" target=3D"_blank=
">https://gitlab.com/qemu-project/qemu/-/commit/5e61afe211e82a9af15a8794a0b=
d29bb574e953b</a><br>
&gt;<br>
&gt; If you&#39;d like me to run CI on a test branch, just let me know.<br>
<br>
It&#39;s new code, from the patches introducing qemu-vnc &amp; the test. Le=
t&#39;s<br>
just skip the test for now by default.<br>
(<a href=3D"https://patchew.org/QEMU/20260513082517.1720433-1-marcandre.lur=
eau@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://pa=
tchew.org/QEMU/20260513082517.1720433-1-marcandre.lureau@redhat.com/</a>)<b=
r>
Would you like me to send a new PR?<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">No, it&#39;s okay. I can merge your patc=
h directly into master.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Stefan</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_c=
ontainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>

--00000000000037f7b30651b7e0d1--

