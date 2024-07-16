Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583F5C3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlJ3-000408-SJ; Tue, 16 Jul 2024 12:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTlJ0-0003mn-36
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTlIv-0001wS-6n
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721148326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mXplYndQzXAecO/K5z735h9LkDNkoDepAbMOKZF//58=;
 b=Mg2Qk/63A4hU40dIgz2AZhkINqU0fwdvdnewb5BJQIFXMI/qnzesN0eaHCIbsCsVsos25B
 2UxZpMfUCswkong/kAs10IU0dgN4pRk98Rt2xI6K7/VeTSH6JX2/3Uz/sVSjgvUwGdi5e8
 9u9uwVy1TSXI2CEiLyCAcOhBUn/jm4E=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-qnOdnghePD6h2EW4-yVGDA-1; Tue, 16 Jul 2024 12:45:25 -0400
X-MC-Unique: qnOdnghePD6h2EW4-yVGDA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1fb05cfe1cbso46157265ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721148323; x=1721753123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mXplYndQzXAecO/K5z735h9LkDNkoDepAbMOKZF//58=;
 b=F9wVhBSlA0Bvzs203KfvdVuCN4otgoR8JGHgZEoqtWsSEjHkdeeOhGWbBIBKgv8Fog
 WcD1Yn3x+uhbeHqy883EPLJCPmPk0p1By56MXzfmsIJ1b8jBRGANKej0cCgTQLXkjVvW
 YhYBhHES3BDGNbhrTScRcohAWkjwHOyMUKIjlhbCQhZqZzLud2ydlBN5z40/EBcUUn3r
 1J3jmQEvXZgzW8GlbiwyxHc6mJdvup5DuNRBSD4tyM4Bfx37YC3ytXxWbSFsHlPHGCNe
 BUeDkJeRaVQsmzcS2Jxtk4MApX+IQPUq3t7vJC3vL2RrGro3Ijwk8Aqb8TFIyodZhKTa
 D3Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRGZLvrADHRvW3ELixhW6k8BtnvboViZhgkK8J9L48RyX1wf+6zdrY3GDz4aPqveznpbnJdFb8jjZFMv7bUsXAJh4qCps=
X-Gm-Message-State: AOJu0Yw+ZixpoMDIPna8PsD56w716Obxn8WWBabOuhTzH9UQ95uKWyU4
 nfgeQbDGxt7/UtMCK1vXeQP4RsDPZ4+EFbJuG/KyxgXWNnSP0o1T83WA0vhQBsKvUApQV6yRLJK
 4/ieOxqmYRsydO9KK4tcE/xJKyie98rNAz0SA89tEd9q3YdqvQsakYFNyAaxOs2iB8HN6rdyyBX
 +ByJIRxCkyMECn18yGt2vDRHj5zmYt1IY0E6E=
X-Received: by 2002:a05:6a21:6da9:b0:1c0:e629:3912 with SMTP id
 adf61e73a8af0-1c3f12a2231mr3489359637.48.1721148323063; 
 Tue, 16 Jul 2024 09:45:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3h1JNll7gpeeMKfHjsuE0SrTbxHbGemHrDMbJuFKErZIGCkykL8P+fN75HMzceQIxypzR48plme8r2POl7Yg=
X-Received: by 2002:a05:6a21:6da9:b0:1c0:e629:3912 with SMTP id
 adf61e73a8af0-1c3f12a2231mr3489318637.48.1721148322619; Tue, 16 Jul 2024
 09:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240711115546.40859-1-thuth@redhat.com>
In-Reply-To: <20240711115546.40859-1-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 Jul 2024 12:45:10 -0400
Message-ID: <CAFn=p-bMXm9qCD0hWiikyOmagFRryCZWrTx8xne9+x5j0QeNYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000603e09061d60122e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000603e09061d60122e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024, 7:55=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote:

> The Avocado v88 that we use in QEMU is already on a life support
> system: It is not supported by upstream anymore, and with the latest
> versions of Python, it won't work anymore since it depends on the
> "imp" module that has been removed in Python 3.12.
>
> There have been several attempts to update the test suite in QEMU
> to a newer version of Avocado, but so far no attempt has successfully
> been merged yet.
>
> Additionally, the whole "make check" test suite in QEMU is using the
> meson test runner nowadays, so running the python-based tests via the
> Avocodo test runner looks and feels quite like an oddball, requiring
> the users to deal with the knowledge of multiple test runners in
> parallel.
>
> So instead of trying to update the python-based test suite in QEMU
> to a newer version of Avocado, we should maybe try to better integrate
> it with the meson test runner instead. Indeed most tests work quite
> nicely without the Avocado framework already, as you can see with
> this patch series - it does not convert all tests, just a subset since
> it is just an RFC so far, but as you can see, many tests only need
> small modifications to work without Avocado.
>
> If you want to try it: Apply the patches, make sure that you have the
> "pytest" program installed, then recompile and then run:
>
>  make check-pytest
>
> Things that need further attention though:
>
> - All tests that use the LinuxTest / LinuxDistro classes (e.g. based
>   on cloud-init images) really depend on the Avocado framework,
>   thus we'd need a solution for those if we want to continue with
>   this approach
>
> - Same for all tests that require the LinuxSSHMixIn class - we'd
>   need to provide a solution for ssh-based tests, too.
>
> - We lose the way of running tests via the avocado tags this way...
>   single targets can still be tested by running "make check-pytest-arm"
>   for example, but running selected tests by other tags does not
>   work anymore.
>
> - I haven't looked into logging yet ... this still needs some work
>   so that you could e.g. inspect the console output of the guests
>   somewhere
>

This has spilled the most developer blood of any other problem with the
Python-based tests. Be very careful here.

I still have a prototype for replacing QMPMachine with an asyncio variant
that should have more robust logging features, but I put it on the
back-burner.

Avocado tests are the primary user of the QMP Machine interface I hate the
very most, a multi-threaded buffer-reader that works only by the grace of
god. If you do go down this path, I may want to take the opportunity to
abolish that interface once and for all.

I think simplifying the console buffering will help ease debuggability.

(Note, this isn't an avocado exclusive problem so much as it is the
emergent evolution of both qmp machine and avocado developing their own
solutions to console logging problems, resulting in two layers that are
trying to do similar things.)


> - I did not work on documentation updates yet (will do that if we
>   agree to continue with this patch series)
>
> What's your thoughts? Is it worth to continue with this approach?
> Or shall I rather forget about it and wait for the Avocado version
> update?
>

I'm personally ambivalent on avocado; I use it for the python self-tests as
dogfooding but I can likely switch back over to plain pytest if that's the
direction we head. I don't think I use any crazy features except some
asyncio helpers i advocated for. I'm not sure what pytest's asyncio support
looks like, but I have to imagine as the premier testing framework that it
has *something* for me to use.

My only ask is that we keep the tests running in the custom venv
environment we set up at build time. We have some funky post-hoc
initialization of avocado that allows us to use internet packages
post-config for testing purposes. If we move to pytest, it's possible we
can eliminate that funkiness, which would be a win.

I'm also not so sure about recreating all of the framework that pulls vm
images on demand, that sounds like it'd be a lot of work, but maybe I'm
wrong about that.

Tacit ACK from me on this project in general, provided we are still using
the configure venv.


>  Thomas
>
>
> Ani Sinha (1):
>   tests/pytest: add pytest to the meson build system
>
> Thomas Huth (7):
>   tests/pytest: Add base classes for the upcoming pytest-based tests
>   tests/pytest: Convert some simple avocado tests into pytests
>   tests/pytest: Convert info_usernet and version test with small
>     adjustments
>   tests_pytest: Implement fetch_asset() method for downloading assets
>   tests/pytest: Convert some tests that download files via fetch_asset()
>   tests/pytest: Add a function for extracting files from an archive
>   tests/pytest: Convert avocado test that needed avocado.utils.archive
>
>  tests/Makefile.include                        |   4 +-
>  tests/meson.build                             |   1 +
>  tests/pytest/meson.build                      |  74 ++++
>  tests/pytest/qemu_pytest/__init__.py          | 362 ++++++++++++++++++
>  tests/pytest/qemu_pytest/utils.py             |  21 +
>  .../test_arm_canona1100.py}                   |  16 +-
>  .../test_cpu_queries.py}                      |   2 +-
>  .../test_empty_cpu_model.py}                  |   2 +-
>  .../test_info_usernet.py}                     |   6 +-
>  .../test_machine_arm_n8x0.py}                 |  20 +-
>  .../test_machine_avr6.py}                     |   7 +-
>  .../test_machine_loongarch.py}                |  11 +-
>  .../test_machine_mips_loongson3v.py}          |  19 +-
>  .../test_mem_addr_space.py}                   |   3 +-
>  .../test_ppc_bamboo.py}                       |  18 +-
>  .../version.py =3D> pytest/test_version.py}     |   8 +-
>  .../test_virtio_version.py}                   |   2 +-
>  17 files changed, 502 insertions(+), 74 deletions(-)
>  create mode 100644 tests/pytest/meson.build
>  create mode 100644 tests/pytest/qemu_pytest/__init__.py
>  create mode 100644 tests/pytest/qemu_pytest/utils.py
>  rename tests/{avocado/machine_arm_canona1100.py =3D>
> pytest/test_arm_canona1100.py} (74%)
>  rename tests/{avocado/cpu_queries.py =3D> pytest/test_cpu_queries.py} (9=
6%)
>  rename tests/{avocado/empty_cpu_model.py =3D>
> pytest/test_empty_cpu_model.py} (94%)
>  rename tests/{avocado/info_usernet.py =3D> pytest/test_info_usernet.py}
> (91%)
>  rename tests/{avocado/machine_arm_n8x0.py =3D>
> pytest/test_machine_arm_n8x0.py} (71%)
>  rename tests/{avocado/machine_avr6.py =3D> pytest/test_machine_avr6.py}
> (91%)
>  rename tests/{avocado/machine_loongarch.py =3D>
> pytest/test_machine_loongarch.py} (89%)
>  rename tests/{avocado/machine_mips_loongson3v.py =3D>
> pytest/test_machine_mips_loongson3v.py} (59%)
>  rename tests/{avocado/mem-addr-space-check.py =3D>
> pytest/test_mem_addr_space.py} (99%)
>  rename tests/{avocado/ppc_bamboo.py =3D> pytest/test_ppc_bamboo.py} (75%=
)
>  rename tests/{avocado/version.py =3D> pytest/test_version.py} (82%)
>  rename tests/{avocado/virtio_version.py =3D> pytest/test_virtio_version.=
py}
> (99%)
>
> --
> 2.45.2
>
>

--000000000000603e09061d60122e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jul 11, 2024, 7:55=E2=80=AFAM Thomas Huth &lt;=
<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">The Avocado v88 that we use in QEMU is alr=
eady on a life support<br>
system: It is not supported by upstream anymore, and with the latest<br>
versions of Python, it won&#39;t work anymore since it depends on the<br>
&quot;imp&quot; module that has been removed in Python 3.12.<br>
<br>
There have been several attempts to update the test suite in QEMU<br>
to a newer version of Avocado, but so far no attempt has successfully<br>
been merged yet.<br>
<br>
Additionally, the whole &quot;make check&quot; test suite in QEMU is using =
the<br>
meson test runner nowadays, so running the python-based tests via the<br>
Avocodo test runner looks and feels quite like an oddball, requiring<br>
the users to deal with the knowledge of multiple test runners in<br>
parallel.<br>
<br>
So instead of trying to update the python-based test suite in QEMU<br>
to a newer version of Avocado, we should maybe try to better integrate<br>
it with the meson test runner instead. Indeed most tests work quite<br>
nicely without the Avocado framework already, as you can see with<br>
this patch series - it does not convert all tests, just a subset since<br>
it is just an RFC so far, but as you can see, many tests only need<br>
small modifications to work without Avocado.<br>
<br>
If you want to try it: Apply the patches, make sure that you have the<br>
&quot;pytest&quot; program installed, then recompile and then run:<br>
<br>
=C2=A0make check-pytest<br>
<br>
Things that need further attention though:<br>
<br>
- All tests that use the LinuxTest / LinuxDistro classes (e.g. based<br>
=C2=A0 on cloud-init images) really depend on the Avocado framework,<br>
=C2=A0 thus we&#39;d need a solution for those if we want to continue with<=
br>
=C2=A0 this approach<br>
<br>
- Same for all tests that require the LinuxSSHMixIn class - we&#39;d<br>
=C2=A0 need to provide a solution for ssh-based tests, too.<br>
<br>
- We lose the way of running tests via the avocado tags this way...<br>
=C2=A0 single targets can still be tested by running &quot;make check-pytes=
t-arm&quot;<br>
=C2=A0 for example, but running selected tests by other tags does not<br>
=C2=A0 work anymore.<br>
<br>
- I haven&#39;t looked into logging yet ... this still needs some work<br>
=C2=A0 so that you could e.g. inspect the console output of the guests<br>
=C2=A0 somewhere<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">This has spilled the most developer blood of any other prob=
lem with the Python-based tests. Be very careful here.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">I still have a prototype for replacing QMPMa=
chine with an asyncio variant that should have more robust logging features=
, but I put it on the back-burner.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Avocado tests are the primary user of the QMP Machine interface =
I hate the very most, a multi-threaded buffer-reader that works only by the=
 grace of god. If you do go down this path, I may want to take the opportun=
ity to abolish that interface once and for all.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">I think simplifying the console buffering will help=
 ease debuggability.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(No=
te, this isn&#39;t an avocado exclusive problem so much as it is the emerge=
nt evolution of both qmp machine and avocado developing their own solutions=
 to console logging problems, resulting in two layers that are trying to do=
 similar things.)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
- I did not work on documentation updates yet (will do that if we<br>
=C2=A0 agree to continue with this patch series)<br>
<br>
What&#39;s your thoughts? Is it worth to continue with this approach?<br>
Or shall I rather forget about it and wait for the Avocado version<br>
update?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">I&#39;m personally ambivalent on avocado; I use it for the python se=
lf-tests as dogfooding but I can likely switch back over to plain pytest if=
 that&#39;s the direction we head. I don&#39;t think I use any crazy featur=
es except some asyncio helpers i advocated for. I&#39;m not sure what pytes=
t&#39;s asyncio support looks like, but I have to imagine as the premier te=
sting framework that it has *something* for me to use.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">My only ask is that we keep the tests runnin=
g in the custom venv environment we set up at build time. We have some funk=
y post-hoc initialization of avocado that allows us to use internet package=
s post-config for testing purposes. If we move to pytest, it&#39;s possible=
 we can eliminate that funkiness, which would be a win.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">I&#39;m also not so sure about recreating a=
ll of the framework that pulls vm images on demand, that sounds like it&#39=
;d be a lot of work, but maybe I&#39;m wrong about that.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Tacit ACK from me on this project in gener=
al, provided we are still using the configure venv.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<br>
=C2=A0Thomas<br>
<br>
<br>
Ani Sinha (1):<br>
=C2=A0 tests/pytest: add pytest to the meson build system<br>
<br>
Thomas Huth (7):<br>
=C2=A0 tests/pytest: Add base classes for the upcoming pytest-based tests<b=
r>
=C2=A0 tests/pytest: Convert some simple avocado tests into pytests<br>
=C2=A0 tests/pytest: Convert info_usernet and version test with small<br>
=C2=A0 =C2=A0 adjustments<br>
=C2=A0 tests_pytest: Implement fetch_asset() method for downloading assets<=
br>
=C2=A0 tests/pytest: Convert some tests that download files via fetch_asset=
()<br>
=C2=A0 tests/pytest: Add a function for extracting files from an archive<br=
>
=C2=A0 tests/pytest: Convert avocado test that needed avocado.utils.archive=
<br>
<br>
=C2=A0tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0tests/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0tests/pytest/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 74 ++++<br>
=C2=A0tests/pytest/qemu_pytest/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 362 ++++++++++++++++++<br>
=C2=A0tests/pytest/qemu_pytest/utils.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 21 +<br>
=C2=A0.../test_arm_canona1100.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +-<br>
=C2=A0.../test_cpu_queries.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0.../test_empty_cpu_model.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0.../test_info_usernet.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
=C2=A0.../test_machine_arm_n8x0.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 20 +-<br>
=C2=A0.../test_machine_avr6.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +-<br>
=C2=A0.../test_machine_loongarch.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 11 +-<br>
=C2=A0.../test_machine_mips_loongson3v.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 19 +-<br>
=C2=A0.../test_mem_addr_space.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
=C2=A0.../test_ppc_bamboo.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +-<br>
=C2=A0.../version.py =3D&gt; pytest/test_version.py}=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A08 +-<br>
=C2=A0.../test_virtio_version.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A017 files changed, 502 insertions(+), 74 deletions(-)<br>
=C2=A0create mode 100644 tests/pytest/meson.build<br>
=C2=A0create mode 100644 tests/pytest/qemu_pytest/__init__.py<br>
=C2=A0create mode 100644 tests/pytest/qemu_pytest/utils.py<br>
=C2=A0rename tests/{avocado/machine_arm_canona1100.py =3D&gt; pytest/test_a=
rm_canona1100.py} (74%)<br>
=C2=A0rename tests/{avocado/cpu_queries.py =3D&gt; pytest/test_cpu_queries.=
py} (96%)<br>
=C2=A0rename tests/{avocado/empty_cpu_model.py =3D&gt; pytest/test_empty_cp=
u_model.py} (94%)<br>
=C2=A0rename tests/{avocado/info_usernet.py =3D&gt; pytest/test_info_userne=
t.py} (91%)<br>
=C2=A0rename tests/{avocado/machine_arm_n8x0.py =3D&gt; pytest/test_machine=
_arm_n8x0.py} (71%)<br>
=C2=A0rename tests/{avocado/machine_avr6.py =3D&gt; pytest/test_machine_avr=
6.py} (91%)<br>
=C2=A0rename tests/{avocado/machine_loongarch.py =3D&gt; pytest/test_machin=
e_loongarch.py} (89%)<br>
=C2=A0rename tests/{avocado/machine_mips_loongson3v.py =3D&gt; pytest/test_=
machine_mips_loongson3v.py} (59%)<br>
=C2=A0rename tests/{avocado/mem-addr-space-check.py =3D&gt; pytest/test_mem=
_addr_space.py} (99%)<br>
=C2=A0rename tests/{avocado/ppc_bamboo.py =3D&gt; pytest/test_ppc_bamboo.py=
} (75%)<br>
=C2=A0rename tests/{avocado/version.py =3D&gt; pytest/test_version.py} (82%=
)<br>
=C2=A0rename tests/{avocado/virtio_version.py =3D&gt; pytest/test_virtio_ve=
rsion.py} (99%)<br>
<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div></div></div>

--000000000000603e09061d60122e--


