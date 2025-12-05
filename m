Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B1DD2CDE3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vROsb-0001LX-Qq; Fri, 05 Dec 2025 01:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vROsZ-0001Kt-RH
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:01:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vROsX-00018y-Lp
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764914472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QzOZA9ofFqC3CQ/vd2LYM15YPg6wVDoxA/oQPMApvqw=;
 b=A2vE4bi/z69dytU0rbTAOEvCSgjayxGC2UWQO/eI8xDp4J6a+clkRDswSAoMiNxkZVWH+z
 jv52IkIbFJ+aJ8Ee5qzEC+FmhF8RkHFX2YB9wuGgNCe0GVWBD+BrsIH5kpwKZhyjDyz07J
 mPEZ+nEfVgMY/giKZksBHdVOu8WBKg8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-1TVtwsuuNECx-LRdc6O4Gg-1; Fri,
 05 Dec 2025 01:01:08 -0500
X-MC-Unique: 1TVtwsuuNECx-LRdc6O4Gg-1
X-Mimecast-MFC-AGG-ID: 1TVtwsuuNECx-LRdc6O4Gg_1764914466
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5673019560A7; Fri,  5 Dec 2025 06:01:06 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.55])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F6673000701; Fri,  5 Dec 2025 06:01:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/15] python: drop qemu.qmp from qemu.git tree
Date: Fri,  5 Dec 2025 01:00:42 -0500
Message-ID: <20251205060058.1503170-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello!=0D
=0D
This series drops the in-tree version of our python-qemu-qmp package=0D
("qemu.qmp") in favor of the version hosted on PyPI, whose repository is=0D
located at https://gitlab.com/qemu-project/python-qemu-qmp.=0D
=0D
GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2197613036=0D
       (FreeBSD isn't my fault...!)=0D
=0D
The major effects of this patch series are:=0D
=0D
1. qemu.qmp will be installed from PyPI or vendored packages instead of=0D
   being utilized directly from the qemu.git tree.=0D
2. There are no new python dependencies checked or installed during=0D
   configure.  All test dependencies are installed post-hoc on an=0D
   as-needed basis.=0D
3. "make check-venv" is no longer required to be run manually before any=0D
   test that is integrated with meson; this includes "make check" and=0D
   "make check-functional".=0D
4. "make check-venv" no longer installs functional test dependencies: it=0D
   installs only the core suite of python test dependencies.=0D
5. "make check-venv" is now required as a pre-requisite for running=0D
   device-crash-test and manually executed iotests.=0D
6. Unfortunately, python3-wheel and python3-setuptools are now required=0D
   on the host system if tests are to be executed and >=3D Python 3.13 is=0D
   used.=0D
7. An awful lot of deleted lines of code, and a lot fewer headaches=0D
   managing two nearly-identical copies of this source code. O:-)=0D
=0D
Patches 1-5 are build system focused; they set up new pythondeps.toml,=0D
mkvenv, and meson systems in preparation for relying on an external=0D
qemu.qmp library, but does not yet make the switch.=0D
=0D
Patches 6-9 are testing and CI focused; they add necessary preparation=0D
steps to keep tests running happily once the in-tree qemu.qmp library is=0D
removed.=0D
=0D
Patches 10-15 are build system focused again; they implement the actual=0D
switchover to the external qemu.qmp library.=0D
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
John Snow (15):=0D
  python/mkvenv: create timestamp file for each group "ensured"=0D
  python/mkvenv: bump 'qemu.qmp' dependency for testdeps=0D
  python/mkvenv: add 'checktests' and 'functests' dependency groups=0D
  python/mkvenv: add mechanism to install local package(s)=0D
  meson, mkvenv: add checktests and functests custom targets=0D
  tests: Use configured python to run GitLab iotests=0D
  tests: run "make check-venv" before running iotests=0D
  tests: ensure "make check-venv" is run for crash tests=0D
  tests/lcitool: add python3 wheel and setuptools deps for qemu=0D
  python: add vendored qemu.qmp package=0D
  meson, mkvenv: make iotests depend on checktests group=0D
  meson, mkvenv: make functional tests depend on functests group=0D
  meson, mkvenv: add qemu.git/python/qemu package to pythondeps.toml=0D
  tests: replace old "check-venv" target with meson target=0D
  python: delete qemu.qmp=0D
=0D
 meson.build                                   |    1 +=0D
 .gitlab-ci.d/buildtest.yml                    |   11 +-=0D
 .gitlab-ci.d/cirrus/freebsd-14.vars           |    2 +-=0D
 .gitlab-ci.d/cirrus/macos-14.vars             |    2 +-=0D
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
 pyvenv/meson.build                            |   40 +=0D
 tests/Makefile.include                        |   25 +-=0D
 tests/docker/dockerfiles/alpine.docker        |    2 +=0D
 tests/docker/dockerfiles/centos9.docker       |    2 +=0D
 tests/functional/meson.build                  |    7 +-=0D
 tests/lcitool/projects/qemu.yml               |    2 +=0D
 tests/qemu-iotests/meson.build                |    2 +-=0D
 tests/vm/generated/freebsd.json               |    2 +=0D
 32 files changed, 126 insertions(+), 5570 deletions(-)=0D
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
2.51.1=0D
=0D


