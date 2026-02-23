Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49934EC111E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 18:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuagY-0001ka-G7; Mon, 23 Feb 2026 13:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuagM-0001ix-4Z
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuagI-0001a1-Lr
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771871357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fcSHz949nQ7I7norBVBzRmJGThua92CU9GldbFCYWXA=;
 b=ffSTRsXyeGFnjKt/fEciu+A8qZuDrDCjJz+WZ+ZTSVB1pOj+S3+4Y6I7xJop2u/PD2TkjG
 WFOhdzrA9X7sdYSBTpbjq9MFMcQXAp8w90LXEb4yz3qSrOW4aveYBxc07gPIb0/YhivyZW
 fK94n+2dlbzItj4eZN+cVNWmfcy+9HM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-nyUAOvt2M5eMSWX19G2Ovw-1; Mon,
 23 Feb 2026 13:29:14 -0500
X-MC-Unique: nyUAOvt2M5eMSWX19G2Ovw-1
X-Mimecast-MFC-AGG-ID: nyUAOvt2M5eMSWX19G2Ovw_1771871351
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 168A71956057; Mon, 23 Feb 2026 18:29:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D6201955D71; Mon, 23 Feb 2026 18:29:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Warner Losh <imp@bsdimp.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 00/19] Python patches
Date: Mon, 23 Feb 2026 13:28:42 -0500
Message-ID: <20260223182902.739189-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit afe653676dc6dfd49f0390239ff90b2f0052c2b8=
:=0D
=0D
  Merge tag 'audio-pull-request' of https://gitlab.com/marcandre.lureau/qem=
u into staging (2026-02-23 14:03:50 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to f0c2b38df05dd642314a31c3d2c16bd4501cbe32:=0D
=0D
  python: add setuptools and wheel dependencies (2026-02-23 13:24:42 -0500)=
=0D
=0D
----------------------------------------------------------------=0D
Python pull request=0D
=0D
This drops qemu.qmp from the tree, finally O:-)=0D
=0D
----------------------------------------------------------------=0D
=0D
John Snow (19):=0D
  python/mkvenv: create timestamp file for each group "ensured"=0D
  python/mkvenv: bump 'qemu.qmp' dependency for testdeps=0D
  python/mkvenv: add 'tooling' and 'functests' dependency groups=0D
  python/mkvenv: add mechanism to install local package(s)=0D
  meson, mkvenv: add functests custom target=0D
  tests: Use configured python to run GitLab iotests=0D
  iotests: tolerate being run outside of pyvenv=0D
  tests: use "run" script to execute device-crash-test=0D
  tests/lcitool: update lcitool to latest version=0D
  tests/lcitool: add python3 wheel and setuptools deps for qemu=0D
  python: add vendored qemu.qmp package=0D
  meson, mkvenv: make functional tests depend on functests group=0D
  meson, mkvenv: add qemu.git/python/qemu package to pythondeps.toml=0D
  configure: unconditionally install "tooling" group=0D
  tests: replace check-venv with vm-venv target=0D
  scripts: nudge users to use 'run' script for scripts that import=0D
    qemu.qmp=0D
  python: delete qemu.qmp=0D
  python: update README.rst to reflect qemu.qmp's removal=0D
  python: add setuptools and wheel dependencies=0D
=0D
 python/README.rst                             |   52 +-=0D
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
 python/scripts/mkvenv.py                      |   43 +-=0D
 python/scripts/vendor.py                      |    2 +=0D
 python/setup.cfg                              |   31 +-=0D
 python/tests/minreqs.txt                      |    8 +-=0D
 python/tests/protocol.py                      |  596 ---------=0D
 pythondeps.toml                               |   21 +-=0D
 pyvenv/meson.build                            |   27 +=0D
 scripts/compare-machine-types.py              |    7 +-=0D
 scripts/device-crash-test                     |    5 +-=0D
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
 tests/docker/dockerfiles/alpine.docker        |    6 +-=0D
 tests/docker/dockerfiles/centos9.docker       |  242 ++--=0D
 .../dockerfiles/fedora-rust-nightly.docker    |  262 ++--=0D
 .../dockerfiles/fedora-win64-cross.docker     |  162 +--=0D
 tests/docker/dockerfiles/fedora.docker        |  262 ++--=0D
 tests/docker/dockerfiles/opensuse-leap.docker |    1 +=0D
 tests/functional/meson.build                  |    5 +-=0D
 tests/lcitool/libvirt-ci                      |    2 +-=0D
 tests/lcitool/mappings.yml                    |    2 +-=0D
 tests/lcitool/projects/qemu.yml               |    2 +=0D
 tests/lcitool/refresh                         |    8 +-=0D
 tests/migration-stress/guestperf/engine.py    |   15 +-=0D
 tests/qemu-iotests/testenv.py                 |   25 +-=0D
 tests/vm/Makefile.include                     |   20 +-=0D
 tests/vm/generated/freebsd.json               |    2 +=0D
 tests/vm/haiku.x86_64                         |    2 +=0D
 tests/vm/netbsd                               |    1 +=0D
 tests/vm/openbsd                              |    3 +=0D
 59 files changed, 766 insertions(+), 6142 deletions(-)=0D
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
 create mode 100644 pyvenv/meson.build=0D
=0D
-- =0D
2.53.0=0D
=0D


