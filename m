Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1150C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 21:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuHrF-00006r-Tt; Mon, 17 Mar 2025 17:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tuHr9-000066-Mk; Mon, 17 Mar 2025 17:18:46 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tuHr5-0006IT-Du; Mon, 17 Mar 2025 17:18:41 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3fa5d864b7fso2490722b6e.1; 
 Mon, 17 Mar 2025 14:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742246315; x=1742851115; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=06I0e5AXCnkyb4geHwy9FcehtId2AEXCfogzWLbrbio=;
 b=UWO0Ic/7pC5UOsKcBjDBCi0HOLcLsmN3UzWJT/8GNGQeC6daR9KYA4z5RCZHhSqoj1
 FpiUbqDhzonmgvwUYqAvINlqdJk+X9vFKen4lTubEnGDqxU7m+oyw0P5hTHIidCwy5Ra
 zRdMFBCyE63onX7xguEI53dvniAq2EKxzUdOhlYTb1zwFV+UmpZ28m6LPLw2k0HZDdDV
 Naa02HewrZgb+tgk5aoEvLLc0J5oMrComjytk+EvG4gQOyAsA0EbbK5eoLKt969bo1IY
 iAv6vLn6GcWDZA5idt2A9AkpIoc3wAcilTB9EO3BtbOEeO+qAySuimfK5swRCFMjAucM
 MdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742246315; x=1742851115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=06I0e5AXCnkyb4geHwy9FcehtId2AEXCfogzWLbrbio=;
 b=fZ7codab05U0vjwlqJzthpOE8v+CfhSGPZoi1z1U4F1tp1luI28xUOX4Ckl0HZ3I3g
 T+gDmfAOZwtLyHNe0Dr42SvFB7SLtg7QER5gOh4JcBQA9IAf6olbqJC2V7oQiU1AY6fO
 lUydB/P4QSsaRKegfT8sxY8tMtuFlY3/C0VpmES3WW8Jntj35YQUgDB90YHSdAPpndXy
 MmCQBvlNifZTfCppPeKW1r7AP513y3EpGjTkkL6vxYzSaha0iNZhOsmNmpV1Y+Q9Ij/O
 8o7IbmguyZY5QzC5dgUIjCs2pSFh5CPXjFVtG+ZbjkaK/PN5xMyaI9tgRwKC63twhlW/
 amPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWchFV33rae7ETYUKv5J+5dRMOi/yNeXt3BERAk/YzOY1gy3yJyTyQSlC/9bpt832IqDNj0OlAsTg==@nongnu.org
X-Gm-Message-State: AOJu0Yx9ZxVtJtX6MoibHqDjLuyPezB7mINQw+WiDuOZ7vo8gcrAuzz0
 ChRiiq0bueXr0WzL6H6wHCUT1u9kGrLFt5dhcrk4iA2kv7enccr4l18jRMNBilnZBLqYzLhvOPU
 QL9nMuKfzJAQvf9gzgTaj2sbPZs8=
X-Gm-Gg: ASbGncsfVKt29rnv6VUusxvXtBcqYwsgwaLFWf7RAtE9b4dDkdSBxnGNA/hdIgSD5h6
 KwWQXNoq5mYHPZKn5TIbbhC1mnhfTGu9CeNhM4uw+pPQpdNKVuVyDwxmz5TZtLiI21dX6icb+dG
 LTN7I+26lvS7TU860ZJINAAkiVrbuNORZQLV5xfkCFPhrZ3XiLbyJt30r7
X-Google-Smtp-Source: AGHT+IE0H4a/g0VqQezmaB5fd00AQb0X0AV/lTmhLGkwXqsB7Wy5jRXElXpwpl0xc99dqa1gv/5bDs9brr80UkaVQ54=
X-Received: by 2002:a05:6808:2289:b0:3f8:3489:d949 with SMTP id
 5614622812f47-3fdf026e003mr7259028b6e.24.1742246315168; Mon, 17 Mar 2025
 14:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250311160847.388670-1-thuth@redhat.com>
 <CAPan3WqXwAWeAqbQypF7PCXh_pjDUgbbiWwXkPSbXrFetfMZAQ@mail.gmail.com>
 <982cba8b-72e6-49d9-80bb-05053c00819c@redhat.com>
In-Reply-To: <982cba8b-72e6-49d9-80bb-05053c00819c@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 17 Mar 2025 22:18:23 +0100
X-Gm-Features: AQ5f1JrzzM8eBil77ABbygPTCRQeY7ZbX8UZrTOOZRme9MpqOQjfb2sC6kS_QPo
Message-ID: <CAPan3Wr=+Vrx9wi0JLjSP_ZU_Gxr+d3g_6PBSK7KePZjjSFJGg@mail.gmail.com>
Subject: Re: [PATCH] docs/system: Fix the information on how to run certain
 functional tests
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ba1c880630905496"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-oi1-x22a.google.com
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

--000000000000ba1c880630905496
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, Mar 17, 2025 at 7:50=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:

>   Hi!
>
> On 16/03/2025 21.21, Niek Linnenbank wrote:
> > Hi Thomas,
> >
> > On Tue, Mar 11, 2025 at 5:08=E2=80=AFPM Thomas Huth <thuth@redhat.com
> > <mailto:thuth@redhat.com>> wrote:
> >
> >     The tests have been converted to the functional framework, so
> >     we should not talk about Avocado here anymore.
> ...
> >     diff --git a/docs/system/arm/orangepi.rst
> b/docs/system/arm/orangepi.rst
> >     index db87e81fec4..8b9448ca7b0 100644
> >     --- a/docs/system/arm/orangepi.rst
> >     +++ b/docs/system/arm/orangepi.rst
> >     @@ -257,9 +257,9 @@ Orange Pi PC integration tests
> >
> > Perhaps for consistency, we can also rename to 'functional tests' here.
>
> Agreed, we don't use the term "integration tests" for this anymore.
>
> >
> >       The Orange Pi PC machine has several integration tests included.
> >
> > And same on this line.
> >
> >       To run the whole set of tests, build QEMU from source and simply
> >     -provide the following command:
> >     +provide the following command from the build directory:
> >
> >       .. code-block:: bash
> >
> >     -  $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes avocado --show=3Dapp,console=
 run \
> >     -     -t machine:orangepi-pc tests/avocado/boot_linux_console.py
> >     +  $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 \
> >     +    meson test --suite thorough func-arm-arm_orangepi
> >
> > I've tried to run on my Ubuntu 24.04.1 LTS based system using this exac=
t
> > same command, but got this error:
> >
> > $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 meson test --suite thorough func-ar=
m-
> > arm_orangepi
> >
> > ERROR: Build data file '/home/user/qemu/build/meson-private/build.dat'
> > references functions or classes that don't exist. This probably means
> that
> > it was generated with an old version of meson. Consider reconfiguring
> the
> > directory with "meson setup --reconfigure".
> >
> > The meson version I have installed via apt-get is 1.3.2-1ubuntu1. Only
> when
> > running using the 'meson' command from the pyvenv, it runs OK:
> >
> > $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 ./pyvenv/bin/meson test --suite
> thorough
> > func-arm-arm_orangepi
>
> Oh, you're right! Thanks for catching it!
>
> I guess I still had a "export PYTHONPATH=3D$HOME/qemu/python" in my
> environment, so I did not notice. Would you like to send a patch, or want
> me
> to do it?
>

Yes please feel free to go ahead with the patch. With the above minor
remarks resolved, it looks fine to me:

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek


>
>   Thomas
>
>

--=20
Niek Linnenbank

--000000000000ba1c880630905496
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Thomas,</div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 17, 2025 =
at 7:50=E2=80=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thut=
h@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">=C2=A0 Hi!<br>
<br>
On 16/03/2025 21.21, Niek Linnenbank wrote:<br>
&gt; Hi Thomas,<br>
&gt; <br>
&gt; On Tue, Mar 11, 2025 at 5:08=E2=80=AFPM Thomas Huth &lt;<a href=3D"mai=
lto:thuth@redhat.com" target=3D"_blank">thuth@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:thuth@redhat.com" target=3D"_blank">thuth=
@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The tests have been converted to the functional fra=
mework, so<br>
&gt;=C2=A0 =C2=A0 =C2=A0we should not talk about Avocado here anymore.<br>
...<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/docs/system/arm/orangepi.rst b/docs/sy=
stem/arm/orangepi.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0index db87e81fec4..8b9448ca7b0 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/docs/system/arm/orangepi.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/docs/system/arm/orangepi.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -257,9 +257,9 @@ Orange Pi PC integration tests<=
br>
&gt; <br>
&gt; Perhaps for consistency, we can also rename to &#39;functional tests&#=
39; here.<br>
<br>
Agreed, we don&#39;t use the term &quot;integration tests&quot; for this an=
ymore.<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0The Orange Pi PC machine has several integra=
tion tests included.<br>
&gt; <br>
&gt; And same on this line.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0To run the whole set of tests, build QEMU fr=
om source and simply<br>
&gt;=C2=A0 =C2=A0 =C2=A0-provide the following command:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+provide the following command from the build direc=
tory:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.. code-block:: bash<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes avocado=
 --show=3Dapp,console run \<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0-t machine:orangepi-pc tests/a=
vocado/boot_linux_console.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 meson test --suite thorough func-arm=
-arm_orangepi<br>
&gt; <br>
&gt; I&#39;ve tried to run on my Ubuntu 24.04.1 LTS based system using this=
 exact <br>
&gt; same command, but got this error:<br>
&gt; <br>
&gt; $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 meson test --suite thorough func-a=
rm- <br>
&gt; arm_orangepi<br>
&gt; <br>
&gt; ERROR: Build data file &#39;/home/user/qemu/build/meson-private/build.=
dat&#39; <br>
&gt; references functions or classes that don&#39;t exist. This probably me=
ans that <br>
&gt; it was generated with an old version of meson. Consider reconfiguring =
the <br>
&gt; directory with &quot;meson setup --reconfigure&quot;.<br>
&gt; <br>
&gt; The meson version I have installed via apt-get is 1.3.2-1ubuntu1. Only=
 when <br>
&gt; running using the &#39;meson&#39; command from the pyvenv, it runs OK:=
<br>
&gt; <br>
&gt; $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 ./pyvenv/bin/meson test --suite th=
orough <br>
&gt; func-arm-arm_orangepi<br>
<br>
Oh, you&#39;re right! Thanks for catching it!<br>
<br>
I guess I still had a &quot;export PYTHONPATH=3D$HOME/qemu/python&quot; in =
my <br>
environment, so I did not notice. Would you like to send a patch, or want m=
e <br>
to do it?<br></blockquote><div><br></div><div>Yes please feel free to go ah=
ead with the patch. With the above minor remarks resolved, it looks fine to=
 me:</div><div><br></div><div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"m=
ailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;</div><div>=
<br></div><div>Regards,</div><div>Niek</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 Thomas<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>

--000000000000ba1c880630905496--

