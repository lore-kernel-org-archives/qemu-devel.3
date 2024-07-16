Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D13C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 17:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmQn-0007SG-Kb; Tue, 16 Jul 2024 13:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTmQk-0007K6-M9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 13:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTmQg-0006hV-0h
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 13:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721152651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2bpiGsCmzvpnVpDv1m7d71cf7RS3IoARvHxbSKrHbRg=;
 b=hycHdH6oDcQbhWXNqgGkOocaeFVIa0wrGFHSHQyJkMTbobSMSVUNxzAxerI6OnZi3KTIPb
 Ab7e7BmsH3f4V87zi3HVsZwS5oNIF5fA0kEWJZ8NS//PTS2k9MauQGqsQzu7ahr/L+4Bii
 I1HdUPTpIPduDwYBDbFDTMN4EWNS6LI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-qYmyHUU_Ob2hVEWrqCszpQ-1; Tue, 16 Jul 2024 13:57:30 -0400
X-MC-Unique: qYmyHUU_Ob2hVEWrqCszpQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36805bfd95aso2960375f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 10:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721152649; x=1721757449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2bpiGsCmzvpnVpDv1m7d71cf7RS3IoARvHxbSKrHbRg=;
 b=B2g/nn1uZtwEAbCd+sFsJXvAYk5VipyBOxAvRYiSH85C4E9QbZ8C+rwJdhMEHL8/zc
 XtnO5LyfPS+IzcVr36XzV2HQooh6KsiNP6uxnGW5p5Uldn8O7PFb6TGBqjhas7tJoqru
 4OWJ8/kdXjNRt6JkNUo63h4JK9nVzJWv7nK+cznWeeS7whDMiCa6WCEM0M00DRo6NQ7k
 m4vfZ3l5tkPfKgKNp8W/ai9nR6SpPV5LzFiIMX6tW5zbFp295f1kvgkOGhrLqCgQbjne
 i7CeZFJvUZR1Gj9Kaf6Y1zJC6SLsLucYhA2cL/NgTenODZ3SKAFCeQwnGig1gb62ncY2
 aNwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb8IpK9Nm0KYELC08pt/2dgGz365CpzTFmX2W3xQS3xSpB4YTG4p9M6T+Q1FQwxyj7wko0tXhMhe+hPhmdtfw72fiAE8A=
X-Gm-Message-State: AOJu0YyfeA7QCxzwn6UvYvcZ0xnjlTq7Py/Qun2VXlXbSeYgRv3YgU2A
 vY3x1yQhYZZqW6fxAbs9AkHKQbjVRdfLeF/TLPht1EO24j/HL3KZjuZOMlBwQBm6ZUjiHkJK2uj
 0Nzl1p8esOHjHwFEcSCmYJnWcbsRVeK+QDOYPHF2ctWO3RmqFKseLCvWvn1cmcJwHHWnqGjobSf
 2zFDLlFGBQW54+jZo+Rvsn9PtOIqM=
X-Received: by 2002:adf:e8cb:0:b0:367:9803:bfe7 with SMTP id
 ffacd0b85a97d-3682635cff4mr1763125f8f.53.1721152648941; 
 Tue, 16 Jul 2024 10:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEff5sU2Mt6eK4HqED/AYDxtBAqH50w8kKluPRnpER27Ze/e7J1V5J56PUa/MCGt1Bu7Fub6RSOF5bfA3ERC4c=
X-Received: by 2002:adf:e8cb:0:b0:367:9803:bfe7 with SMTP id
 ffacd0b85a97d-3682635cff4mr1763121f8f.53.1721152648585; Tue, 16 Jul 2024
 10:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240716112614.1755692-1-thuth@redhat.com>
In-Reply-To: <20240716112614.1755692-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jul 2024 19:57:15 +0200
Message-ID: <CABgObfYV+oRp=AhuJmqrjbRR+pRmLKdd9VPjCh4mNLMeaAMW0A@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Convert avocado tests to normal Python unittests
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="000000000000394afa061d611443"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--000000000000394afa061d611443
Content-Type: text/plain; charset="UTF-8"

Il mar 16 lug 2024, 13:26 Thomas Huth <thuth@redhat.com> ha scritto:

> The Avocado v88 that we use in QEMU is already on a life support
> system: It is not supported by upstream anymore, and with the latest
> versions of Python, it won't work anymore since it depends on the
> "imp" module that has been removed in Python 3.12.
>
> There have been several attempts to update the test suite in QEMU
> to a newer version of Avocado, but so far no attempt has successfully
> been merged yet.
>

I think we should take another look at that. Avocado 92 should work, though
I am not sure if it's also depending on "imp", and if I recall correctly
the problem with more recent version was more that it conflicted with
distros that didn't have it packaged. That should also not be a problem
anymore with the pythondeps.toml mechanism.

Additionally, the whole "make check" test suite in QEMU is using the
> meson test runner nowadays, so running the python-based tests via the
> Avocodo test runner looks and feels quite like an oddball, requiring
> the users to deal with the knowledge of multiple test runners in
> parallel (e.g. the timeout settings work completely differently).
>

This is true.

Paolo


> So instead of trying to update the python-based test suite in QEMU
> to a newer version of Avocado, we should maybe try to better integrate
> it with the meson test runner instead. Indeed most tests work quite
> nicely without the Avocado framework already, as you can see with
> this patch series - it does not convert all tests, just a subset so
> far, but this already proves that many tests only need small modifi-
> cations to work without Avocado.
>
> Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
> classes (e.g. based on cloud-init images or using SSH) really depend
> on the Avocado framework, so we'd need a solution for those if we
> want to continue using them. One solution might be to simply use the
> required functions from avocado.utils for these tests, and still run
> them via the meson test runner instead, but that needs some further
> investigation that will be done later.
>
>
> Now if you want to try out these patches: Apply the patches, then
> recompile and then run:
>
>  make check-functional
>
> You can also run single targets e.g. with:
>
>  make check-functional-ppc
>
> You can also run the tests without any test runner now by
> setting the PYTHONPATH environment variable to the "python" folder
> of your source tree, and by specifying the build directory via
> QEMU_BUILD_ROOT (if autodetection fails) and by specifying the
> QEMU binary via QEMU_TEST_QEMU_BINARY. For example:
>
>  export PYTHONPATH=$HOME/qemu/python
>  export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
>  export PYTHONPATH=$HOME/qemu/build
>  ~/qemu/tests/functional/test_virtio_version.py
>
> The logs of the tests can be found in the build directory under
> tests/functional/<testname> - console log and general logs will
> be put in separate files there.
>
> Still to be done: Update the documentation for this new test framework.
>
> RFC -> v1:
> - Now using pycotap for running the tests instead of "pytest"
> - Change the name from "tests/pytest" to "tests/functional" accordingly
> - Make it possible to run the tests directly
> - Use Python's urllib instead of wget for downloading
> - Lots of makefile / meson integration improvements
> - Converted more tests
> - Update MAINTAINERS file accordingly
> - Added a patch to run check-functional in the gitlab-CI
> - ... lots of other changes I forgot about ... in fact, I changed so
>   many things that I also did not dare to pick up the Reviewed-bys
>   from the RFC
>
> Thomas Huth (11):
>   tests/functional: Add base classes for the upcoming pytest-based tests
>   tests/functional: Convert simple avocado tests into standalone python
>     tests
>   tests/functional: Convert avocado tests that just need a small
>     adjustment
>   tests/functional: Add python-based tests to the meson build system
>   tests/functional: Implement fetch_asset() method for downloading
>     assets
>   tests/functional: Convert some tests that download files via
>     fetch_asset()
>   tests/functional: Add a function for extracting files from an archive
>   tests/functional: Convert some avocado tests that needed
>     avocado.utils.archive
>   tests/functional: Set up logging
>   tests/functional: Convert the s390x avocado tests into standalone
>     tests
>   gitlab-ci: Add "check-functional" to the build tests
>
>  MAINTAINERS                                   |  22 +-
>  .gitlab-ci.d/buildtest-template.yml           |   3 +-
>  .gitlab-ci.d/buildtest.yml                    |  60 +--
>  pythondeps.toml                               |   3 +-
>  tests/Makefile.include                        |  18 +-
>  tests/functional/meson.build                  | 112 +++++
>  tests/functional/qemu_test/__init__.py        | 384 ++++++++++++++++++
>  tests/functional/qemu_test/utils.py           |  28 ++
>  .../test_arm_canona1100.py}                   |  21 +-
>  .../test_arm_n8x0.py}                         |  25 +-
>  .../test_avr_mega2560.py}                     |  11 +-
>  .../test_cpu_queries.py}                      |   7 +-
>  .../test_empty_cpu_model.py}                  |   7 +-
>  .../test_info_usernet.py}                     |  11 +-
>  .../test_loongarch64_virt.py}                 |  16 +-
>  .../test_mem_addr_space.py}                   |  53 +--
>  .../test_mips64el_loongson3v.py}              |  26 +-
>  .../test_netdev_ethtool.py}                   |  32 +-
>  .../test_pc_cpu_hotplug_props.py}             |  11 +-
>  .../ppc_405.py => functional/test_ppc_405.py} |  19 +-
>  .../test_ppc_74xx.py}                         |  74 ++--
>  .../test_ppc_bamboo.py}                       |  23 +-
>  .../test_s390x_ccw_virtio.py}                 |  32 +-
>  .../test_s390x_topology.py}                   |  70 ++--
>  .../test_sparc64_sun4u.py}                    |  25 +-
>  .../version.py => functional/test_version.py} |  13 +-
>  .../test_virtio_version.py}                   |   8 +-
>  tests/meson.build                             |   1 +
>  28 files changed, 795 insertions(+), 320 deletions(-)
>  create mode 100644 tests/functional/meson.build
>  create mode 100644 tests/functional/qemu_test/__init__.py
>  create mode 100644 tests/functional/qemu_test/utils.py
>  rename tests/{avocado/machine_arm_canona1100.py =>
> functional/test_arm_canona1100.py} (71%)
>  mode change 100644 => 100755
>  rename tests/{avocado/machine_arm_n8x0.py => functional/test_arm_n8x0.py}
> (71%)
>  mode change 100644 => 100755
>  rename tests/{avocado/machine_avr6.py => functional/test_avr_mega2560.py}
> (90%)
>  mode change 100644 => 100755
>  rename tests/{avocado/cpu_queries.py => functional/test_cpu_queries.py}
> (89%)
>  mode change 100644 => 100755
>  rename tests/{avocado/empty_cpu_model.py =>
> functional/test_empty_cpu_model.py} (84%)
>  mode change 100644 => 100755
>  rename tests/{avocado/info_usernet.py => functional/test_info_usernet.py}
> (87%)
>  mode change 100644 => 100755
>  rename tests/{avocado/machine_loongarch.py =>
> functional/test_loongarch64_virt.py} (89%)
>  mode change 100644 => 100755
>  rename tests/{avocado/mem-addr-space-check.py =>
> functional/test_mem_addr_space.py} (92%)
>  mode change 100644 => 100755
>  rename tests/{avocado/machine_mips_loongson3v.py =>
> functional/test_mips64el_loongson3v.py} (55%)
>  mode change 100644 => 100755
>  rename tests/{avocado/netdev-ethtool.py =>
> functional/test_netdev_ethtool.py} (81%)
>  mode change 100644 => 100755
>  rename tests/{avocado/pc_cpu_hotplug_props.py =>
> functional/test_pc_cpu_hotplug_props.py} (90%)
>  mode change 100644 => 100755
>  rename tests/{avocado/ppc_405.py => functional/test_ppc_405.py} (73%)
>  mode change 100644 => 100755
>  rename tests/{avocado/ppc_74xx.py => functional/test_ppc_74xx.py} (74%)
>  mode change 100644 => 100755
>  rename tests/{avocado/ppc_bamboo.py => functional/test_ppc_bamboo.py}
> (75%)
>  mode change 100644 => 100755
>  rename tests/{avocado/machine_s390_ccw_virtio.py =>
> functional/test_s390x_ccw_virtio.py} (95%)
>  mode change 100644 => 100755
>  rename tests/{avocado/s390_topology.py =>
> functional/test_s390x_topology.py} (90%)
>  mode change 100644 => 100755
>  rename tests/{avocado/machine_sparc64_sun4u.py =>
> functional/test_sparc64_sun4u.py} (60%)
>  mode change 100644 => 100755
>  rename tests/{avocado/version.py => functional/test_version.py} (78%)
>  mode change 100644 => 100755
>  rename tests/{avocado/virtio_version.py =>
> functional/test_virtio_version.py} (98%)
>  mode change 100644 => 100755
>
> --
> 2.45.2
>
>

--000000000000394afa061d611443
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 16 lug 2024, 13:26 Thomas Huth &lt;<a href=3D"m=
ailto:thuth@redhat.com">thuth@redhat.com</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">The Avocado v88 that we use in=
 QEMU is already on a life support<br>
system: It is not supported by upstream anymore, and with the latest<br>
versions of Python, it won&#39;t work anymore since it depends on the<br>
&quot;imp&quot; module that has been removed in Python 3.12.<br>
<br>
There have been several attempts to update the test suite in QEMU<br>
to a newer version of Avocado, but so far no attempt has successfully<br>
been merged yet.<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">I think we should take another look at that. Avocado 92 sho=
uld work, though I am not sure if it&#39;s also depending on &quot;imp&quot=
;, and if I recall correctly the problem with more recent version was more =
that it conflicted with distros that didn&#39;t have it packaged. That shou=
ld also not be a problem anymore with the pythondeps.toml mechanism.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
Additionally, the whole &quot;make check&quot; test suite in QEMU is using =
the<br>
meson test runner nowadays, so running the python-based tests via the<br>
Avocodo test runner looks and feels quite like an oddball, requiring<br>
the users to deal with the knowledge of multiple test runners in<br>
parallel (e.g. the timeout settings work completely differently).<br></bloc=
kquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">This is tr=
ue.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
So instead of trying to update the python-based test suite in QEMU<br>
to a newer version of Avocado, we should maybe try to better integrate<br>
it with the meson test runner instead. Indeed most tests work quite<br>
nicely without the Avocado framework already, as you can see with<br>
this patch series - it does not convert all tests, just a subset so<br>
far, but this already proves that many tests only need small modifi-<br>
cations to work without Avocado.<br>
<br>
Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn<br>
classes (e.g. based on cloud-init images or using SSH) really depend<br>
on the Avocado framework, so we&#39;d need a solution for those if we<br>
want to continue using them. One solution might be to simply use the<br>
required functions from avocado.utils for these tests, and still run<br>
them via the meson test runner instead, but that needs some further<br>
investigation that will be done later.<br>
<br>
<br>
Now if you want to try out these patches: Apply the patches, then<br>
recompile and then run:<br>
<br>
=C2=A0make check-functional<br>
<br>
You can also run single targets e.g. with:<br>
<br>
=C2=A0make check-functional-ppc<br>
<br>
You can also run the tests without any test runner now by<br>
setting the PYTHONPATH environment variable to the &quot;python&quot; folde=
r<br>
of your source tree, and by specifying the build directory via<br>
QEMU_BUILD_ROOT (if autodetection fails) and by specifying the<br>
QEMU binary via QEMU_TEST_QEMU_BINARY. For example:<br>
<br>
=C2=A0export PYTHONPATH=3D$HOME/qemu/python<br>
=C2=A0export QEMU_TEST_QEMU_BINARY=3Dqemu-system-x86_64<br>
=C2=A0export PYTHONPATH=3D$HOME/qemu/build<br>
=C2=A0~/qemu/tests/functional/test_virtio_version.py<br>
<br>
The logs of the tests can be found in the build directory under<br>
tests/functional/&lt;testname&gt; - console log and general logs will<br>
be put in separate files there.<br>
<br>
Still to be done: Update the documentation for this new test framework.<br>
<br>
RFC -&gt; v1:<br>
- Now using pycotap for running the tests instead of &quot;pytest&quot;<br>
- Change the name from &quot;tests/pytest&quot; to &quot;tests/functional&q=
uot; accordingly<br>
- Make it possible to run the tests directly<br>
- Use Python&#39;s urllib instead of wget for downloading<br>
- Lots of makefile / meson integration improvements<br>
- Converted more tests<br>
- Update MAINTAINERS file accordingly<br>
- Added a patch to run check-functional in the gitlab-CI<br>
- ... lots of other changes I forgot about ... in fact, I changed so<br>
=C2=A0 many things that I also did not dare to pick up the Reviewed-bys<br>
=C2=A0 from the RFC<br>
<br>
Thomas Huth (11):<br>
=C2=A0 tests/functional: Add base classes for the upcoming pytest-based tes=
ts<br>
=C2=A0 tests/functional: Convert simple avocado tests into standalone pytho=
n<br>
=C2=A0 =C2=A0 tests<br>
=C2=A0 tests/functional: Convert avocado tests that just need a small<br>
=C2=A0 =C2=A0 adjustment<br>
=C2=A0 tests/functional: Add python-based tests to the meson build system<b=
r>
=C2=A0 tests/functional: Implement fetch_asset() method for downloading<br>
=C2=A0 =C2=A0 assets<br>
=C2=A0 tests/functional: Convert some tests that download files via<br>
=C2=A0 =C2=A0 fetch_asset()<br>
=C2=A0 tests/functional: Add a function for extracting files from an archiv=
e<br>
=C2=A0 tests/functional: Convert some avocado tests that needed<br>
=C2=A0 =C2=A0 avocado.utils.archive<br>
=C2=A0 tests/functional: Set up logging<br>
=C2=A0 tests/functional: Convert the s390x avocado tests into standalone<br=
>
=C2=A0 =C2=A0 tests<br>
=C2=A0 gitlab-ci: Add &quot;check-functional&quot; to the build tests<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 22 +-<br>
=C2=A0.gitlab-ci.d/buildtest-template.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A03 +-<br>
=C2=A0.gitlab-ci.d/buildtest.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 60 +--<br>
=C2=A0pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 =
+-<br>
=C2=A0tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +-<br>
=C2=A0tests/functional/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 112 +++++<br>
=C2=A0tests/functional/qemu_test/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3=
84 ++++++++++++++++++<br>
=C2=A0tests/functional/qemu_test/utils.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 28 ++<br>
=C2=A0.../test_arm_canona1100.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 21 +-<br>
=C2=A0.../test_arm_n8x0.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 25 +-<br>
=C2=A0.../test_avr_mega2560.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +-<br>
=C2=A0.../test_cpu_queries.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +-<br>
=C2=A0.../test_empty_cpu_model.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +-<br>
=C2=A0.../test_info_usernet.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +-<br>
=C2=A0.../test_loongarch64_virt.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +-<br>
=C2=A0.../test_mem_addr_space.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 53 +--<br>
=C2=A0.../test_mips64el_loongson3v.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 26 +-<br>
=C2=A0.../test_netdev_ethtool.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 32 +-<br>
=C2=A0.../test_pc_cpu_hotplug_props.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 11 +-<br>
=C2=A0.../ppc_405.py =3D&gt; functional/test_ppc_405.py} |=C2=A0 19 +-<br>
=C2=A0.../test_ppc_74xx.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 74 ++--<br>
=C2=A0.../test_ppc_bamboo.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 23 +-<br>
=C2=A0.../test_s390x_ccw_virtio.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 32 +-<br>
=C2=A0.../test_s390x_topology.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 70 ++--<br>
=C2=A0.../test_sparc64_sun4u.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 25 +-<br>
=C2=A0.../version.py =3D&gt; functional/test_version.py} |=C2=A0 13 +-<br>
=C2=A0.../test_virtio_version.py}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +-<br>
=C2=A0tests/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A028 files changed, 795 insertions(+), 320 deletions(-)<br>
=C2=A0create mode 100644 tests/functional/meson.build<br>
=C2=A0create mode 100644 tests/functional/qemu_test/__init__.py<br>
=C2=A0create mode 100644 tests/functional/qemu_test/utils.py<br>
=C2=A0rename tests/{avocado/machine_arm_canona1100.py =3D&gt; functional/te=
st_arm_canona1100.py} (71%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/machine_arm_n8x0.py =3D&gt; functional/test_arm=
_n8x0.py} (71%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/machine_avr6.py =3D&gt; functional/test_avr_meg=
a2560.py} (90%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/cpu_queries.py =3D&gt; functional/test_cpu_quer=
ies.py} (89%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/empty_cpu_model.py =3D&gt; functional/test_empt=
y_cpu_model.py} (84%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/info_usernet.py =3D&gt; functional/test_info_us=
ernet.py} (87%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/machine_loongarch.py =3D&gt; functional/test_lo=
ongarch64_virt.py} (89%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/mem-addr-space-check.py =3D&gt; functional/test=
_mem_addr_space.py} (92%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/machine_mips_loongson3v.py =3D&gt; functional/t=
est_mips64el_loongson3v.py} (55%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/netdev-ethtool.py =3D&gt; functional/test_netde=
v_ethtool.py} (81%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/pc_cpu_hotplug_props.py =3D&gt; functional/test=
_pc_cpu_hotplug_props.py} (90%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/ppc_405.py =3D&gt; functional/test_ppc_405.py} =
(73%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/ppc_74xx.py =3D&gt; functional/test_ppc_74xx.py=
} (74%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/ppc_bamboo.py =3D&gt; functional/test_ppc_bambo=
o.py} (75%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/machine_s390_ccw_virtio.py =3D&gt; functional/t=
est_s390x_ccw_virtio.py} (95%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/s390_topology.py =3D&gt; functional/test_s390x_=
topology.py} (90%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/machine_sparc64_sun4u.py =3D&gt; functional/tes=
t_sparc64_sun4u.py} (60%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/version.py =3D&gt; functional/test_version.py} =
(78%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
=C2=A0rename tests/{avocado/virtio_version.py =3D&gt; functional/test_virti=
o_version.py} (98%)<br>
=C2=A0mode change 100644 =3D&gt; 100755<br>
<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div></div></div>

--000000000000394afa061d611443--


