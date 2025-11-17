Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A76CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 18:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL4KK-0002cg-UC; Mon, 17 Nov 2025 13:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4KI-0002bl-4c
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:51:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4KE-00084Z-V8
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763405500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hRjly9qUuW80gfD02w+t21wQeZ/XgyOYiPwyKH4zVdk=;
 b=aiTT83hULJ4ZzbNuGed/ae7RTW1eBVz/SPLj2j1YLVQnWRO2P963jdgDhx76Aw9MAqQ2Tz
 vwOjHU3KKvZ/3yp9jl2swHMy/mygaF1B+x06wEphUt4f5Uki9FsE7OrNUbiZWmqoQuGM0q
 LiiCTkhV3jJ1vPCMtcjeGx6BE9jnWfw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-xGnTqVQHNM25GAyeMqxZjA-1; Mon,
 17 Nov 2025 13:51:37 -0500
X-MC-Unique: xGnTqVQHNM25GAyeMqxZjA-1
X-Mimecast-MFC-AGG-ID: xGnTqVQHNM25GAyeMqxZjA_1763405496
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE7851956055; Mon, 17 Nov 2025 18:51:35 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.81.70])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B382D180047F; Mon, 17 Nov 2025 18:51:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 00/22] python: drop qemu.qmp from qemu.git tree
Date: Mon, 17 Nov 2025 13:51:08 -0500
Message-ID: <20251117185131.953681-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, this series does a few things, but it's ultimately in service of=0D
dropping the python qemu.qmp package from the qemu.git tree in favor of=0D
using the standalone package instead, to prevent any further issues from=0D
the two codebases diverging.=0D
=0D
Patches 1-3: Fix linting issues that have cropped up with python=0D
Patches 4-8,12,16: Set up new python dependency targets in Meson=0D
Patches 9-10,17: Adjust test execution in GitLab to cope with new test=0D
                 dependency structure=0D
Patch 11: Add vendored qemu.qmp package for isolated/offline test=0D
          execution=0D
Patches 13-15: Fix meson build system (Paolo Bonzini)=0D
Patches 18-20: Teach mkvenv how to install local packages=0D
Patch 21: Replace "make check-venv" in Makefile with meson execution=0D
Patch 22: Drop qemu.qmp.=0D
=0D
There are some quality problems with Patches 18-20, but all GitLab tests=0D
are green and this is a great starting point to discuss this series.=0D
=0D
--js=0D
=0D
John Snow (19):=0D
  python/mkvenv: ensure HAVE_LIB variables are actually constants=0D
  python/qapi: add an ignore for Pylint 4.x=0D
  python/qapi: delint import statements=0D
  python/mkvenv: create timestamp file for each group "ensured"=0D
  python/mkvenv: bump 'qemu.qmp' dependency for testdeps=0D
  python/mkvenv: rename 'testdeps' to 'functests'=0D
  python/mkvenv: add "checktests" dependency group=0D
  meson, mkvenv: add checktests and functests custom targets=0D
  tests/iotests: Use configured python to run GitLab iotests=0D
  tests/iotests: use "make check-venv" to prepare for running iotests=0D
  python: add vendored qemu.qmp package=0D
  meson, mkvenv: make iotests depend on checktests group=0D
  meson, mkvenv: make functional tests depend on functests group=0D
  tests: forcibly run 'make check-venv' for crash tests=0D
  python/mkvenv: add mechanism to install local package(s)=0D
  mkvenv: add --no-build-isolation flag=0D
  meson, mkvenv: add qemu.git/python/qemu package to pythondeps.toml=0D
  tests/Makefile: replace old "check-venv" target with meson target=0D
  python: delete qemu.qmp=0D
=0D
Paolo Bonzini (3):=0D
  mtest2make: cleanup mtest-suites variables=0D
  mtest2make: add dependencies to the "speed-qualified" suite=0D
  mtest2make: do not repeat the same speed over and over=0D
=0D
 Makefile                                      |    4 +-=0D
 meson.build                                   |    1 +=0D
 .gitlab-ci.d/buildtest.yml                    |    9 +-=0D
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
 python/scripts/mkvenv.py                      |   35 +-=0D
 python/scripts/vendor.py                      |    2 +=0D
 python/setup.cfg                              |   32 +-=0D
 python/tests/minreqs.txt                      |    8 +-=0D
 python/tests/protocol.py                      |  596 ---------=0D
 python/wheels/qemu_qmp-0.0.5-py3-none-any.whl |  Bin 0 -> 72263 bytes=0D
 pythondeps.toml                               |    7 +-=0D
 pyvenv/meson.build                            |   34 +=0D
 scripts/mtest2make.py                         |   41 +-=0D
 scripts/qapi/commands.py                      |    5 +-=0D
 scripts/qapi/introspect.py                    |    2 +-=0D
 tests/Makefile.include                        |   25 +-=0D
 tests/functional/meson.build                  |    7 +-=0D
 tests/qemu-iotests/meson.build                |    2 +-=0D
 30 files changed, 116 insertions(+), 5598 deletions(-)=0D
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


