Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C720ECA5FD7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGSh-0006E8-1p; Tue, 20 Jan 2026 13:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1viGSf-0006Dg-5z
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:28:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1viGSc-0003nu-OR
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768933692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVUJ1JIRb1Q8VZzqOfuryykqdN+f2APx7/IZOrw9B5g=;
 b=JznvLCgg6vS4QVAdfFysr56OO7Vvza5khXULkGGAP5A6fnXVOWSRx9umSwMh0Ny0q7eSsd
 s91yLf40H5Owpaj3Errjun6Oti+krw8k4ixFCMRDAwxFjco4asShcSMivQa0gAZmNU9/1h
 3lZNBpWL0/Hgy+7bPo48GxVBCUGNrU0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-qX1K-lzkMeyRQKvUU5CvMQ-1; Tue, 20 Jan 2026 13:28:11 -0500
X-MC-Unique: qX1K-lzkMeyRQKvUU5CvMQ-1
X-Mimecast-MFC-AGG-ID: qX1K-lzkMeyRQKvUU5CvMQ_1768933691
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-792738a717fso65782357b3.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:28:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933689; cv=none;
 d=google.com; s=arc-20240605;
 b=EWTu1nlyN4pii+m7a1/67GNzxqHqqZwD4CQOyrNMt9GVnS9IpKTmFEMQLa/EYVkFuJ
 H9OYEHP3QixSL6eaKWIQbUt3u9s89JxYEMIpDdZYJtUg7S+W/M7tyXSd+dQbcSGFTcMF
 q33opBN5IGZ1ewvCwwOAAs7nfrpEcN4LVJzj6D4YpugtzpVHPGZSVI0/i31Mwsx7s/cJ
 qRsrevb3eZjy/1ypGXOBNYsV1UoFMX8i6SHigy/2OdlUC72lbVX9vaFwwFW8Fgg0Yn+Z
 yFeZKdNwg6RX/cA7WH3/WQfqCJEZnlM/HCZgzQf6NmeEfznQNl2fQuGcR/B3XEy2vKke
 WRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fVUJ1JIRb1Q8VZzqOfuryykqdN+f2APx7/IZOrw9B5g=;
 fh=3Vi40FEfOsRvAJsSQmHr3FcCQ3abLEDWYqfMpQJLGSk=;
 b=dvrHtFX14p+I9dtRh+oANPQ+6Ny4xsag4Qn7+FS0kAq92bkBMFz1Yk4+F4nn9SMLL4
 xyWclkV1J8IEWOqVp646hKh9mf8gdl2YUecZQLYIi5cN7g4y0Z1qwItBc70aOGULJnTS
 u7kTYrMxenUIXBOa3Hzz2fOcVWjlqO2Vao0pYXBpWx9F81TE2WlLBGGhNvE+F2r0cvew
 uXhr5QWc5zqx6Y/S6ATNL4GKxoj7jlPIfDhCI9pusk0+xENn8SOvgMeG/EM0fYA/Eeir
 g52Ria1ZPPIFjKgVPwGOLA04mdLlC5MraM/HGhnlZWVe9iJLsursCsTXV949lgha7xWh
 ODmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768933689; x=1769538489; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVUJ1JIRb1Q8VZzqOfuryykqdN+f2APx7/IZOrw9B5g=;
 b=JY/a37l5YgH/+xfoZheTpXRpuZDAgZU/e/61PNKXG4+LjVFYurjZJSoI05T9Gz2KXx
 XKpxepsQEF8qxgS7w8CKHHMmh5DYqTZJc9mRd4NFlnZYdfj7y+v4vd/9YikxnW0bSHO5
 E8EwGWgt51dU5NsiERQUBM0dfELogD9pksMepjJ+S/EIYSHXGAZdrwxLzFyCNlanb6jy
 xxZ9aQiU635FutpbbwzHE1OM/ZskDhNHZTs2U+XVpPiN/LzG1REO3nERvkRAp1Zy8sDE
 8g3Z6Mxgan231R6WIauNKWGwh2DiE447GbWsVqwuw44BlvU2zKt6KmOGTl1J3c7U3O8R
 7FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768933689; x=1769538489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fVUJ1JIRb1Q8VZzqOfuryykqdN+f2APx7/IZOrw9B5g=;
 b=B5xQeqdoKHh83XRPLjUZlQ8f7Fz0nXvFfcUR62T8s0H6UFJw4MH7kgKL3R9esj0B5a
 enDlbnLEvEIMA9SUbLqqM6o27Nop8xoF4JiJJNW/aPf5oHGi55xY+CexXFNoOZy5GPHW
 Ufmba++99/NuFsVcP7Vxb0RAe8u++zwH/cor+d4EQER4dB/pMhza3zJCiZYBdxfnKRvf
 Q85NqlrzD8xryrgFup12RVX9IcP5ezmSleeWerYZXG6rb42KFbV3odoqdTWyEkVMVQUR
 Zo+GWaeQmquq4MzAaomKpLql3Gd+YQ/KbdxOnLUyagg1tw+JZljozQRsNp4JP3hIRRLh
 vkyg==
X-Gm-Message-State: AOJu0YzPYY//BIz24c96L1zlynfnwtGbJVg67e6ITgWV5JFqrO69ur72
 Uq4jRRlA23RbkAaxV9rt4iVU8QPBVNpCpnr8gfMSMCGbEeqWEp7NsgT+8F6bPZ26zJnHBmUtaHZ
 wp8XupAavAKIOyvQKQyK6/6FgdMVuF9ngTh1LmBHMwGcY2I0TtQqDmYuQvpW0RH4DqeIIEbiGJo
 qqIgjc57hkH9lv7MO0kfIW2+Gxfm27H6nd1GrSCEJ65g==
X-Gm-Gg: AZuq6aJhRXrhSd5ZQERGX965DQ+OQigRQPUouWuZ23Qwr7tOq7En/GsVdZqEbCuuUWW
 QPkJP5px9eS975Ha6qz2mozFmHYPKOTr0/lGqH+pijC6V92VLdayy4SA5V8mKNmwwzBnRSdDWkU
 YMndAtu19/wlqUaeNBZOvtiBwdbWMe92x6NV3u1bFt7NNkWB4/BLZ7BvTti2K/46ADGdjktttA0
 05KA7ShnTL/VeiyaTLIsvJiOg==
X-Received: by 2002:a05:690e:4104:b0:644:60d9:7516 with SMTP id
 956f58d0204a3-6493c86574bmr2009862d50.90.1768933688806; 
 Tue, 20 Jan 2026 10:28:08 -0800 (PST)
X-Received: by 2002:a05:690e:4104:b0:644:60d9:7516 with SMTP id
 956f58d0204a3-6493c86574bmr2009830d50.90.1768933688319; Tue, 20 Jan 2026
 10:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20260119212744.1275455-1-jsnow@redhat.com>
In-Reply-To: <20260119212744.1275455-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 20 Jan 2026 13:27:57 -0500
X-Gm-Features: AZwV_Qj9W5zNIBIWyud6xaQv8-OPfCbNbnO9trK1dFzCxv_w_Oj4XUu2n7XMhQc
Message-ID: <CAFn=p-ZwZcvJM=essB8GU1+-P2Gi3xXCQVURvPWxB5qbq0AYbg@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] python: drop qemu.qmp from qemu.git tree
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Yonggang Luo <luoyonggang@gmail.com>, Ed Maste <emaste@freebsd.org>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jan 19, 2026 at 4:28=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> Hello!
>
> This series drops the in-tree version of our python-qemu-qmp package
> ("qemu.qmp") in favor of the version hosted on PyPI, whose repository is
> located at https://gitlab.com/qemu-project/python-qemu-qmp.
>
> GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2272170300

Current status of this series: all patches reviewed by either Thomas,
Dan or Vladimir; except:

[PATCH v4 04/17] python/mkvenv: add mechanism to install local package(s)
    - Review from Paolo would be nice, if he has the time.
[PATCH v4 05/17] meson, mkvenv: add functests custom target
    - Fixed comments as per Dan's review
[PATCH v4 11/17] meson, mkvenv: add qemu.git/python/qemu package to
pythondeps.toml
    - Probably fine, but a Paolo ACK would be nice.
[PATCH v4 13/17] tests: remove "make check-venv" target
    - I regress an optimization Alex Bennee made, would like to fix
this before merge.
[PATCH v4 16/17] python: update README.rst to reflect qemu.qmp's removal
    - Discussing this with Dan
[PATCH v4 17/17] RFC: exclude pyvenv targets from "make check-build"
    - Still not clear if we want this or not, I'm pretty neutral.

>
> This version reflects Dan's suggestion to always install the in-tree
> Python packages by default.
>
> The major effects of this patch series are:
>
> 1. qemu.qmp and the python/ directory will be installed to the
>    configure-time venv (build/pyvenv) by default.
> 2. qemu.qmp will be installed from PyPI or vendored packages instead of
>    being utilized directly from the qemu.git tree.
> 3. "make check-venv" is removed as it is no longer needed.
> 4. functional test dependencies are installed as-needed when running
>    those tests.
> 5. Unfortunately, python3-wheel and python3-setuptools are now required
>    on the host system if tests are to be executed and >=3D Python 3.13 is
>    used.
> 6. An awful lot of deleted lines of code, and a lot fewer headaches
>    managing two nearly-identical copies of this source code. O:-)
>
> v4:
>
>  - Rename "checktests" group to "tooling", install it by default
>    alongside meson at configure-time.
>  - Remove "check-venv" entirely.
>  - Update python/README.rst to reflect the new paradigm
>  - Update many scripts that import qemu.qmp to give new errors when they
>    are run outside of the configure venv
>
> KNOWN ISSUES IN V4:
>
>  - The last patch is an RFC based on Thomas' observations, I don't have
>    a strong opinion on if we want it or not.
>  - Removing "make check-venv" causes the VM tests to rebuild more often;
>    I was not sure how to replace the old conditional behavior in an
>    equivalent manner. Suggestions, anyone...?
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
> John Snow (17):
>   python/mkvenv: create timestamp file for each group "ensured"
>   python/mkvenv: bump 'qemu.qmp' dependency for testdeps
>   python/mkvenv: add 'tooling' and 'functests' dependency groups
>   python/mkvenv: add mechanism to install local package(s)
>   meson, mkvenv: add functests custom target
>   tests: Use configured python to run GitLab iotests
>   tests: use "run" script to execute device-crash-test
>   tests/lcitool: add python3 wheel and setuptools deps for qemu
>   python: add vendored qemu.qmp package
>   meson, mkvenv: make functional tests depend on functests group
>   meson, mkvenv: add qemu.git/python/qemu package to pythondeps.toml
>   configure: unconditionally install "tooling" group
>   tests: remove "make check-venv" target
>   scripts: nudge users to use 'run' script for scripts that import
>     qemu.qmp
>   python: delete qemu.qmp
>   python: update README.rst to reflect qemu.qmp's removal
>   RFC: exclude pyvenv targets from "make check-build"
>
>  python/README.rst                             |   50 +-
>  configure                                     |    2 +-
>  meson.build                                   |    1 +
>  .gitlab-ci.d/buildtest.yml                    |   26 +-
>  .gitlab-ci.d/cirrus/freebsd-14.vars           |    2 +-
>  .gitlab-ci.d/cirrus/macos-14.vars             |    2 +-
>  .gitlab-ci.d/windows.yml                      |    2 +
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
>  pyvenv/meson.build                            |   28 +
>  scripts/compare-machine-types.py              |    7 +-
>  scripts/device-crash-test                     |    5 +-
>  scripts/mtest2make.py                         |    4 +-
>  scripts/qmp/qemu-ga-client                    |   13 +-
>  scripts/qmp/qmp-shell                         |   13 +-
>  scripts/qmp/qmp-shell-wrap                    |   13 +-
>  scripts/qmp/qom-fuse                          |   13 +-
>  scripts/qmp/qom-get                           |   13 +-
>  scripts/qmp/qom-list                          |   13 +-
>  scripts/qmp/qom-set                           |   13 +-
>  scripts/qmp/qom-tree                          |   13 +-
>  scripts/qmp_helper.py                         |    9 +-
>  scripts/render_block_graph.py                 |   10 +-
>  scripts/simplebench/bench_block_job.py        |   10 +-
>  tests/Makefile.include                        |   22 +-
>  tests/docker/dockerfiles/alpine.docker        |    2 +
>  tests/docker/dockerfiles/centos9.docker       |    2 +
>  tests/functional/meson.build                  |    5 +-
>  tests/lcitool/projects/qemu.yml               |    2 +
>  tests/migration-stress/guestperf/engine.py    |   15 +-
>  tests/vm/Makefile.include                     |   24 +-
>  tests/vm/generated/freebsd.json               |    2 +
>  50 files changed, 250 insertions(+), 5684 deletions(-)
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
> 2.52.0
>
>


