Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C97FD3B983
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0gp-0005qs-2K; Tue, 09 Dec 2025 11:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vT0gk-0005q5-Tq
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vT0gh-0005An-4v
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765298136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7eRU99cMBLny45pOLuPBCMNj131GW8dS303AFmB+nA=;
 b=WR3V2bIBoC38utUnO0B/QMKYm9A8Jin/d84WEyCd7m2XSuZxa2xiPBl8kZaYiJgpEJTeU8
 qspFbZjjVY+U359QC3CekS5kaZ/MHqBlW4JQsF9NZXHGZ8v8qwqRFEAnGVFORMyPNIGKxK
 xFstQYYvxLQwWer7UviOfjwOs3ocGsE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-qT5mSYWBOTee-RFYxPee3Q-1; Tue, 09 Dec 2025 11:35:34 -0500
X-MC-Unique: qT5mSYWBOTee-RFYxPee3Q-1
X-Mimecast-MFC-AGG-ID: qT5mSYWBOTee-RFYxPee3Q_1765298128
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-78c38354edcso41620597b3.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765298128; x=1765902928; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7eRU99cMBLny45pOLuPBCMNj131GW8dS303AFmB+nA=;
 b=fmRLffq1gzZM85HsoyDdQNFAwtvpuimHfDWMIoVZhdhA9FFcXkGxti1cvgb7JTiuPj
 WPOTnT5dmu0jX42FAF+x0FUAwrNrgpDOxHL0S+391eaAvRFRizJE2xelhaen0Uiz8Y0X
 y8C7iWdXY4z09JIc3U0CHxgql5+ztlT5pI1PgphU6bbDgeJl+yAogac2jb2t9uOaW5Ve
 jPHyyPDB7khhCGazUhxFMouSw6fvnFkBI1Thmq0CmGff6ckyIMbK8mNXtNml7JXpTPHp
 KoYzIeKRXh10CNKMVARwjhEAx3mWbaGVrNcWd59dgbpNmEEah2yhkjPpPY1SLYPaVn45
 1/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765298128; x=1765902928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k7eRU99cMBLny45pOLuPBCMNj131GW8dS303AFmB+nA=;
 b=VLebHaid2U/obsz6PxeMkUcK3XVKDAzTzoonR16Gtc9Vlz9UJhlHwKOigirfe52Q+X
 jNvmbVJCfcEzkwBpITtdYdoDtO16WyUj3l2h2DCbPPOmdPLJ15lGU/asbrYLYkd4/cIc
 xxPtOgPlEJgjHHcH4JEDCXxRtNYhhiJwmWTG9yJt9pZvoGmZMHLQfwlUPuIiQCiK4mi7
 f6QvypZRfx6es2LllnQYzEyr+n9N1su5IzWDfznxENYUqKhRvwMBwVWa8jwEJ5upgi0T
 vb8DV94TH0jzDliEB66UbtpZUrLS/vP86kNX2S/ymnjtJOwzF/hxcPjv6jCHEKUHSY1l
 Hf2Q==
X-Gm-Message-State: AOJu0Yzl/MGC0R8stwFK14B879UwyrF8a8cI9rHvhe0+MMo6F8WiFzM9
 4j4fwjOzBT2N31VomOCLfLQQG3lf5y7VHLESZBu0CJaY88LrFpV17eNdD7Ut11sNQPydDdFaKiS
 OVhPeVC9CIhzsq+9g0OlC7a4br9MWWFiJhchEnABw3IA+GyDr9a7OkZxSjZ/SvPj53aEkHwqmn6
 T4UXj4XXf26bjFTZHYJnG+0A/c9xGS24NDtL27+RBExg==
X-Gm-Gg: AY/fxX58JqOriSfjkPc98WtC1oU4riGXIVltCsVFE1pf3DAvD6IVG1Kwbp566NF1vzu
 Pyr55iLLyBsJZQmErYehxjn4mU8RrAnKUpyP6cvIswCeAcbl8TGXQGV6oMNP3xwJyKK85gIn3Wk
 flUJtdZCmQbZH/wjXW9218Jf69gnGGI7jBVZTUsE3MLsm1t943LVSCEcFk7GHfwUJqZFvJnX/nS
 wk6Zg/fIMDivt2EG87CU8Jcuw==
X-Received: by 2002:a05:690e:1b65:b0:642:84a:7bdc with SMTP id
 956f58d0204a3-6444e7f3658mr8208136d50.83.1765298127594; 
 Tue, 09 Dec 2025 08:35:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDnZQFrtMugmOCUbAjUbfb+qT31UDx7ud+Rwuti4Didj9EKorI3o3dyxnb/pzonxZV5al+5bAq4CdOQWqK+YM=
X-Received: by 2002:a05:690e:1b65:b0:642:84a:7bdc with SMTP id
 956f58d0204a3-6444e7f3658mr8208118d50.83.1765298127210; Tue, 09 Dec 2025
 08:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20251205060058.1503170-1-jsnow@redhat.com>
In-Reply-To: <20251205060058.1503170-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Dec 2025 11:35:16 -0500
X-Gm-Features: AQt7F2ox1CVFGaUKZdjxLUPJNRog-MGpzcC7PatRghKeD2coC7zKPA7eCOcWAS0
Message-ID: <CAFn=p-YCnEk0T-mDZ5TfMDPfBonLbWzkFSyh_JW0Cz7ykZH4VA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] python: drop qemu.qmp from qemu.git tree
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ed Maste <emaste@freebsd.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

First of all: Ping!

Please-Review: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Please-Review: Paolo Bonzini <pbonzini@redhat.com>
Please-Review: Alex Benn=C3=A9e <alex.bennee@linaro.org>

It would be nice to get this series staged right as the tree opens so
that I can address any build issues it creates in a timely manner
during the next window.

Second, [below, in-line] ...

On Fri, Dec 5, 2025 at 1:01=E2=80=AFAM John Snow <jsnow@redhat.com> wrote:
>
> Hello!
>
> This series drops the in-tree version of our python-qemu-qmp package
> ("qemu.qmp") in favor of the version hosted on PyPI, whose repository is
> located at https://gitlab.com/qemu-project/python-qemu-qmp.
>
> GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2197613036
>        (FreeBSD isn't my fault...!)
>
> The major effects of this patch series are:
>
> 1. qemu.qmp will be installed from PyPI or vendored packages instead of
>    being utilized directly from the qemu.git tree.
> 2. There are no new python dependencies checked or installed during
>    configure.  All test dependencies are installed post-hoc on an
>    as-needed basis.
> 3. "make check-venv" is no longer required to be run manually before any
>    test that is integrated with meson; this includes "make check" and
>    "make check-functional".
> 4. "make check-venv" no longer installs functional test dependencies: it
>    installs only the core suite of python test dependencies.
> 5. "make check-venv" is now required as a pre-requisite for running
>    device-crash-test and manually executed iotests.
> 6. Unfortunately, python3-wheel and python3-setuptools are now required
>    on the host system if tests are to be executed and >=3D Python 3.13 is
>    used.
> 7. An awful lot of deleted lines of code, and a lot fewer headaches
>    managing two nearly-identical copies of this source code. O:-)
>
> Patches 1-5 are build system focused; they set up new pythondeps.toml,
> mkvenv, and meson systems in preparation for relying on an external
> qemu.qmp library, but does not yet make the switch.
>
> Patches 6-9 are testing and CI focused; they add necessary preparation
> steps to keep tests running happily once the in-tree qemu.qmp library is
> removed.
>
> Patches 10-15 are build system focused again; they implement the actual
> switchover to the external qemu.qmp library.
>
> v3:
>
>  - Fixed FreeBSD vm test
>  - Fixed Cirrus macOS test (Needed setuptools as a dep, "file:///" had
>    one too many forward slashes, which works fine for older
>    pip/setuptools, but was incompatibly fixed recently.)
>  - Fixed an issue that prevented installing the local python packages in
>    an offline, isolated build environment (need --no-isolated-build and
>    pip environment variable flags)
>  - Added the python3-wheel and python3-setuptools build dependencies to
>    lcitool, owing to the above issues
>  - Ensured that the $download flag (for PyPI access) from configure is
>    carried over into pytest/meson.build invocations.  This defaults to
>    "enabled", so test dependencies should not have any issue being
>    fetched on most developer workstations and build environments.
>  - Fixed several bugs in the mkvenv.py local package installation mechani=
sm.
>  - Flags and workarounds added for installing local packages offline now
>    apply *only* to local package installations, and not "normal"
>    depspecs.
>  - Reordered patches into more logical "phases" for easier review (I
>    hope...?)
>
> Known issues: "make check-build" still installs all of the test
> dependencies to the pyvenv. I'm not sure if this is desired or not, but
> I ran into problems preventing it from doing this without breaking a ton
> of CI tests. I'll continue to investigate this, but wanted to send this
> v3 out.

I sussed it out. I *can* remove the pyvenv targets from "check-build",
and the reason CI tests fail when I do this is because the build
templates use NINJA=3D":", so running "make check" suppresses the meson
dependencies. It can be rectified by setting eight of the twelve total
occurrences of "make check-build" in our CI files to also run "make
check-venv".

It's not clear if we want this or not. It depends on what
"check-build" semantically means. On the one hand, it doesn't do any
prefetch for the functional tests, so you could make the argument that
environment setup is similar. On the other hand, I think it's used
almost exclusively by and for the CI test suite, in which case it
running the environment setup is likely a pretty helpful/useful thing.
It's something Thomas pointed out, but I don't feel like I have a
strong opinion on it currently.

--js

>
> v2:
>
>  - move "make check-venv" earlier in GitLab CI/CD pipeline, to avoid
>    re-running configure
>  - Fix functional tests not using PyPI to fetch pygdbmi package
>  - Remove pre-requisites which are now merged
>
> --js
>
> John Snow (15):
>   python/mkvenv: create timestamp file for each group "ensured"
>   python/mkvenv: bump 'qemu.qmp' dependency for testdeps
>   python/mkvenv: add 'checktests' and 'functests' dependency groups
>   python/mkvenv: add mechanism to install local package(s)
>   meson, mkvenv: add checktests and functests custom targets
>   tests: Use configured python to run GitLab iotests
>   tests: run "make check-venv" before running iotests
>   tests: ensure "make check-venv" is run for crash tests
>   tests/lcitool: add python3 wheel and setuptools deps for qemu
>   python: add vendored qemu.qmp package
>   meson, mkvenv: make iotests depend on checktests group
>   meson, mkvenv: make functional tests depend on functests group
>   meson, mkvenv: add qemu.git/python/qemu package to pythondeps.toml
>   tests: replace old "check-venv" target with meson target
>   python: delete qemu.qmp
>
>  meson.build                                   |    1 +
>  .gitlab-ci.d/buildtest.yml                    |   11 +-
>  .gitlab-ci.d/cirrus/freebsd-14.vars           |    2 +-
>  .gitlab-ci.d/cirrus/macos-14.vars             |    2 +-
>  python/qemu/qmp/__init__.py                   |   60 -
>  python/qemu/qmp/error.py                      |   53 -
>  python/qemu/qmp/events.py                     |  751 -----------
>  python/qemu/qmp/legacy.py                     |  339 -----
>  python/qemu/qmp/message.py                    |  217 ----
>  python/qemu/qmp/models.py                     |  146 ---
>  python/qemu/qmp/protocol.py                   | 1101 -----------------
>  python/qemu/qmp/py.typed                      |    0
>  python/qemu/qmp/qmp_client.py                 |  732 -----------
>  python/qemu/qmp/qmp_shell.py                  |  689 -----------
>  python/qemu/qmp/qmp_tui.py                    |  665 ----------
>  python/qemu/qmp/util.py                       |  150 ---
>  python/qemu/utils/qom_fuse.py                 |    1 -
>  python/scripts/mkvenv.py                      |   44 +-
>  python/scripts/vendor.py                      |    2 +
>  python/setup.cfg                              |   31 +-
>  python/tests/minreqs.txt                      |    8 +-
>  python/tests/protocol.py                      |  596 ---------
>  python/wheels/qemu_qmp-0.0.5-py3-none-any.whl |  Bin 0 -> 72263 bytes
>  pythondeps.toml                               |   13 +-
>  pyvenv/meson.build                            |   40 +
>  tests/Makefile.include                        |   25 +-
>  tests/docker/dockerfiles/alpine.docker        |    2 +
>  tests/docker/dockerfiles/centos9.docker       |    2 +
>  tests/functional/meson.build                  |    7 +-
>  tests/lcitool/projects/qemu.yml               |    2 +
>  tests/qemu-iotests/meson.build                |    2 +-
>  tests/vm/generated/freebsd.json               |    2 +
>  32 files changed, 126 insertions(+), 5570 deletions(-)
>  delete mode 100644 python/qemu/qmp/__init__.py
>  delete mode 100644 python/qemu/qmp/error.py
>  delete mode 100644 python/qemu/qmp/events.py
>  delete mode 100644 python/qemu/qmp/legacy.py
>  delete mode 100644 python/qemu/qmp/message.py
>  delete mode 100644 python/qemu/qmp/models.py
>  delete mode 100644 python/qemu/qmp/protocol.py
>  delete mode 100644 python/qemu/qmp/py.typed
>  delete mode 100644 python/qemu/qmp/qmp_client.py
>  delete mode 100644 python/qemu/qmp/qmp_shell.py
>  delete mode 100644 python/qemu/qmp/qmp_tui.py
>  delete mode 100644 python/qemu/qmp/util.py
>  delete mode 100644 python/tests/protocol.py
>  create mode 100644 python/wheels/qemu_qmp-0.0.5-py3-none-any.whl
>  create mode 100644 pyvenv/meson.build
>
> --
> 2.51.1
>
>


