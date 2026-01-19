Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93541D2ECE6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 21:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhwlJ-0006gn-Fi; Mon, 19 Jan 2026 16:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vhwlH-0006eN-QF
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:26:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vhwlE-0007J0-A5
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768857966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WZ1fSG2hthQl0V7L9uQ5Taj61grzEbXtUiCg3YVidJU=;
 b=YpWPlm1RF+x+OUpnr0WVy0IuQ3apQY/RWqomrS25Zfk3CnyJ59TD45Fxqd7vM/+iClbMvl
 Q2KrNdropE7MEqFo65v0wo2JVLChgn7T6BGOXIZSya1AkOJNmEcZazz9kTnpWJNpRiyes9
 Y/8Q+eDtBuzcDWJlnMtsyvRVT2au8Pg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-Av8DIo1oONWNEUZJTO6dBQ-1; Mon,
 19 Jan 2026 16:26:02 -0500
X-MC-Unique: Av8DIo1oONWNEUZJTO6dBQ-1
X-Mimecast-MFC-AGG-ID: Av8DIo1oONWNEUZJTO6dBQ_1768857961
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BD9F1800372; Mon, 19 Jan 2026 21:26:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.170])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87BBC1800285; Mon, 19 Jan 2026 21:25:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Maksim Davydov <davydov-max@yandex-team.ru>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 00/17] python: drop qemu.qmp from qemu.git tree
Date: Mon, 19 Jan 2026 16:25:36 -0500
Message-ID: <20260119212554.1274940-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello!=0D
=0D
This series drops the in-tree version of our python-qemu-qmp package=0D
("qemu.qmp") in favor of the version hosted on PyPI, whose repository is=0D
located at https://gitlab.com/qemu-project/python-qemu-qmp.=0D
=0D
GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2272170300=0D
=0D
This version reflects Dan's suggestion to always install the in-tree=0D
Python packages by default.=0D
=0D
The major effects of this patch series are:=0D
=0D
1. qemu.qmp and the python/ directory will be installed to the=0D
   configure-time venv (build/pyvenv) by default.=0D
2. qemu.qmp will be installed from PyPI or vendored packages instead of=0D
   being utilized directly from the qemu.git tree.=0D
3. "make check-venv" is removed as it is no longer needed.=0D
4. functional test dependencies are installed as-needed when running=0D
   those tests.=0D
5. Unfortunately, python3-wheel and python3-setuptools are now required=0D
   on the host system if tests are to be executed and >=3D Python 3.13 is=0D
   used.=0D
6. An awful lot of deleted lines of code, and a lot fewer headaches=0D
   managing two nearly-identical copies of this source code. O:-)=0D
=0D
v4:=0D
=0D
 - Rename "checktests" group to "tooling", install it by default=0D
   alongside meson at configure-time.=0D
 - Remove "check-venv" entirely.=0D
 - Update python/README.rst to reflect the new paradigm=0D
 - Update many scripts that import qemu.qmp to give new errors when they=0D
   are run outside of the configure venv=0D
=0D
KNOWN ISSUES IN V4:=0D
=0D
 - The last patch is an RFC based on Thomas' observations, I don't have=0D
   a strong opinion on if we want it or not.=0D
 - Removing "make check-venv" causes the VM tests to rebuild more often;=0D
   I was not sure how to replace the old conditional behavior in an=0D
   equivalent manner. Suggestions, anyone...?=0D
=0D
v3:=0D
=0D
 - Fixed FreeBSD vm test=0D
 - Fixed Cirrus macOS test (Needed setuptools as a dep, "file:///" had=0D
   one too many forward slashes, which works fine for older=0D
   pip/setuptools, but was incompatibly fixed recently.)=0D
 - Fixed an issue that prevented installing the local python packages in=0D
   an offline, isolated build environment (need --no-isolated-build and=0D
   pip environment variable flags)=0D
 - Added the python3-wheel and python3-setuptools build dependencies to=0D
   lcitool, owing to the above issues=0D
 - Ensured that the $download flag (for PyPI access) from configure is=0D
   carried over into pytest/meson.build invocations.  This defaults to=0D
   "enabled", so test dependencies should not have any issue being=0D
   fetched on most developer workstations and build environments.=0D
 - Fixed several bugs in the mkvenv.py local package installation mechanism=
.=0D
 - Flags and workarounds added for installing local packages offline now=0D
   apply *only* to local package installations, and not "normal"=0D
   depspecs.=0D
 - Reordered patches into more logical "phases" for easier review (I=0D
   hope...?)=0D
=0D
Known issues: "make check-build" still installs all of the test=0D
dependencies to the pyvenv. I'm not sure if this is desired or not, but=0D
I ran into problems preventing it from doing this without breaking a ton=0D
of CI tests. I'll continue to investigate this, but wanted to send this=0D
v3 out.=0D
=0D
v2:=0D
=0D
 - move "make check-venv" earlier in GitLab CI/CD pipeline, to avoid=0D
   re-running configure=0D
 - Fix functional tests not using PyPI to fetch pygdbmi package=0D
 - Remove pre-requisites which are now merged=0D
=0D
--js=0D
=0D
John Snow (17):=0D
  python/mkvenv: create timestamp file for each group "ensured"=0D
  python/mkvenv: bump 'qemu.qmp' dependency for testdeps=0D
  python/mkvenv: add 'tooling' and 'functests' dependency groups=0D
  python/mkvenv: add mechanism to install local package(s)=0D
  meson, mkvenv: add functests custom target=0D
  tests: Use configured python to run GitLab iotests=0D
  tests: use "run" script to execute device-crash-test=0D
  tests/lcitool: add python3 wheel and setuptools deps for qemu=0D
  python: add vendored qemu.qmp package=0D
  meson, mkvenv: make functional tests depend on functests group=0D
  meson, mkvenv: add qemu.git/python/qemu package to pythondeps.toml=0D
  configure: unconditionally install "tooling" group=0D
  tests: remove "make check-venv" target=0D
  scripts: nudge users to use 'run' script for scripts that import=0D
    qemu.qmp=0D
  python: delete qemu.qmp=0D
  python: update README.rst to reflect qemu.qmp's removal=0D
  RFC: exclude pyvenv targets from "make check-build"=0D
=0D
 python/README.rst                             |   50 +-=0D
 configure                                     |    2 +-=0D
 meson.build                                   |    1 +=0D
 .gitlab-ci.d/buildtest.yml                    |   26 +-=0D
 .gitlab-ci.d/cirrus/freebsd-14.vars           |    2 +-=0D
 .gitlab-ci.d/cirrus/macos-14.vars             |    2 +-=0D
 .gitlab-ci.d/windows.yml                      |    2 +=0D
 python/qemu/qmp/__init__.py                   |   60 -=0D
 python/qemu/qmp/error.py                      |   53 -=0D
 python/qemu/qmp/events.py                     |  751 -----------=0D
 python/qemu/qmp/legacy.py                     |  339 -----=0D
 python/qemu/qmp/message.py                    |  217 ----=0D
 python/qemu/qmp/models.py                     |  146 ---=0D
 python/qemu/qmp/protocol.py                   | 1101 -----------------=0D
 python/qemu/qmp/py.typed                      |    0=0D
 python/qemu/qmp/qmp_client.py                 |  732 -----------=0D
 python/qemu/qmp/qmp_shell.py                  |  689 -----------=0D
 python/qemu/qmp/qmp_tui.py                    |  665 ----------=0D
 python/qemu/qmp/util.py                       |  150 ---=0D
 python/qemu/utils/qom_fuse.py                 |    1 -=0D
 python/scripts/mkvenv.py                      |   44 +-=0D
 python/scripts/vendor.py                      |    2 +=0D
 python/setup.cfg                              |   31 +-=0D
 python/tests/minreqs.txt                      |    8 +-=0D
 python/tests/protocol.py                      |  596 ---------=0D
 python/wheels/qemu_qmp-0.0.5-py3-none-any.whl |  Bin 0 -> 72263 bytes=0D
 pythondeps.toml                               |   13 +-=0D
 pyvenv/meson.build                            |   28 +=0D
 scripts/compare-machine-types.py              |    7 +-=0D
 scripts/device-crash-test                     |    5 +-=0D
 scripts/mtest2make.py                         |    4 +-=0D
 scripts/qmp/qemu-ga-client                    |   13 +-=0D
 scripts/qmp/qmp-shell                         |   13 +-=0D
 scripts/qmp/qmp-shell-wrap                    |   13 +-=0D
 scripts/qmp/qom-fuse                          |   13 +-=0D
 scripts/qmp/qom-get                           |   13 +-=0D
 scripts/qmp/qom-list                          |   13 +-=0D
 scripts/qmp/qom-set                           |   13 +-=0D
 scripts/qmp/qom-tree                          |   13 +-=0D
 scripts/qmp_helper.py                         |    9 +-=0D
 scripts/render_block_graph.py                 |   10 +-=0D
 scripts/simplebench/bench_block_job.py        |   10 +-=0D
 tests/Makefile.include                        |   22 +-=0D
 tests/docker/dockerfiles/alpine.docker        |    2 +=0D
 tests/docker/dockerfiles/centos9.docker       |    2 +=0D
 tests/functional/meson.build                  |    5 +-=0D
 tests/lcitool/projects/qemu.yml               |    2 +=0D
 tests/migration-stress/guestperf/engine.py    |   15 +-=0D
 tests/vm/Makefile.include                     |   24 +-=0D
 tests/vm/generated/freebsd.json               |    2 +=0D
 50 files changed, 250 insertions(+), 5684 deletions(-)=0D
 delete mode 100644 python/qemu/qmp/__init__.py=0D
 delete mode 100644 python/qemu/qmp/error.py=0D
 delete mode 100644 python/qemu/qmp/events.py=0D
 delete mode 100644 python/qemu/qmp/legacy.py=0D
 delete mode 100644 python/qemu/qmp/message.py=0D
 delete mode 100644 python/qemu/qmp/models.py=0D
 delete mode 100644 python/qemu/qmp/protocol.py=0D
 delete mode 100644 python/qemu/qmp/py.typed=0D
 delete mode 100644 python/qemu/qmp/qmp_client.py=0D
 delete mode 100644 python/qemu/qmp/qmp_shell.py=0D
 delete mode 100644 python/qemu/qmp/qmp_tui.py=0D
 delete mode 100644 python/qemu/qmp/util.py=0D
 delete mode 100644 python/tests/protocol.py=0D
 create mode 100644 python/wheels/qemu_qmp-0.0.5-py3-none-any.whl=0D
 create mode 100644 pyvenv/meson.build=0D
=0D
-- =0D
2.52.0=0D
=0D


