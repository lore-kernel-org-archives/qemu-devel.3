Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE23E6748D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 11:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXeFz-0007hk-NY; Mon, 22 Dec 2025 06:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vXeFr-0007h7-NN
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 06:39:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vXeFo-0007wY-RS
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 06:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766403545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9MbtQKOF4vdSKZInoD1mkY/LrvFiJKFQfC51oh5teXc=;
 b=gONDxzg2QgV5c5nRpo24zWqGN1OFXE0y5CaXLcWqn97C/qH4YgUU8SlbbbM14XDy3ze0d3
 /LNGFuKxRrGBushM3bdDw3+LnGZGj/4qCfni/VaivM03FTL8Zy6EO17/U44XLGup7oH5aq
 NuTyfFz6mz9VSffC4z2Dou9wu0cMpsA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-kslgK61KPxyLKGxhTW-GiQ-1; Mon,
 22 Dec 2025 06:39:04 -0500
X-MC-Unique: kslgK61KPxyLKGxhTW-GiQ-1
X-Mimecast-MFC-AGG-ID: kslgK61KPxyLKGxhTW-GiQ_1766403543
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10CFD1956088; Mon, 22 Dec 2025 11:39:03 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.75])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A0DE19560AB; Mon, 22 Dec 2025 11:39:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] run: introduce a script for running devel commands
Date: Mon, 22 Dec 2025 11:38:59 +0000
Message-ID: <20251222113859.182395-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Various aspects of the development workflow are complicated by the need
to set env variables ahead of time, or use specific paths. Meson
provides a 'devenv' command that can be used to launch a command with a
number of appropriate project specific environment variables preset.

By default it will modify $PATH to point to any build directory that
contains a binary built by the project.

This further augments that to replicate the venv 'activate' script:

 * Add $BUILD_DIR/pyvenv/bin to $PATH
 * Set VIRTUAL_ENV to $BUILD_DIR/pyvenv

And then makes functional tests more easily executable

 * Add $SRC_DIR/tests/functional and $SRC_DIR/python to $PYTHONPATH

To see the benefits of this consider this command:

  $ source ./build/pyvenv/bin/activate
  $ ./scripts/qmp/qmp-shell-wrap ./build/qemu-system-x86_64

which is now simplified to

  $ ./build/run ./scripts/qmp/qmp-shell-wrap qemu-system-x86_64 [args..]

This avoids the need repeat './build' several times and avoids polluting
the current terminal's environment and/or avoids errors from forgetting
to source the venv settings.

As another example running functional tests

  $ export PYTHONPATH=./python:./tests/functional
  $ export QEMU_TEST_QEMU_BINARY=./build/qemu-system-x86_64
  $ build/pyvenv/bin/python3 ./tests/functional/x86_64/test_virtio_version.py

which is now simplified to

  $ export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
  $ ./build/run ./tests/functional/x86_64/test_virtio_version.py

This usefulness of this will be further enhanced with the pending
removal of the QEMU python APIs from git, as that will require the use
of the python venv in even more scenarios that today.

The 'run' script does not let 'meson devenv' directly launch the command
to be run because it always requires $BUILD_DIR as the current working
directory. It is desired that 'run' script always honour the current
working directory of the terminal that invokes is. Thus the '--dump'
flag is used to export the devenv variables into the 'run' script's
shell.

This takes the liberty to assign 'run.in' to the "Build system" section
in the MAINTAINERS file, given that it leverages meson's 'devenv'
feature.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

Changed in v2:

 * Switch to use meson's  "devenv" framework
 * Fix some typos

 MAINTAINERS                       |  1 +
 docs/devel/build-system.rst       | 12 ++++++++++++
 docs/devel/testing/functional.rst | 17 ++++++++---------
 meson.build                       | 16 ++++++++++++++--
 run.in                            |  6 ++++++
 5 files changed, 41 insertions(+), 11 deletions(-)
 create mode 100644 run.in

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..f21b2927a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4479,6 +4479,7 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: meson.build
 F: meson_options.txt
+F: run.in
 F: scripts/check_sparse.py
 F: scripts/symlink-install-tree.py
 
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 6204aa6a72..b9797a374c 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -515,6 +515,18 @@ generates ``Makefile`` from ``Makefile.in``.
 
 Built by configure:
 
+``run``
+  Used to run commands / scripts from the git checkout. Sets ``$PATH``
+  to point to locally built binaries, and activates the python venv
+  before running the requested command. Pass the command to run as
+  args, for example::
+
+    $ ./build/run ./script/qmp/qmp-shell-wrap qemu-system-x86_64
+
+  will use the ``python3`` binary and site-packages from the local
+  venv to run ``qmp-shell-wrap`` and spawn the QEMU emulator from
+  the build directory.
+
 ``config-host.mak``
   When configure has determined the characteristics of the build host it
   will write the paths to various tools to this file, for use in ``Makefile``
diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index fdeaebaadc..1978f96eba 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -53,15 +53,14 @@ the following line will only run the tests for the x86_64 target:
   make check-functional-x86_64
 
 To run a single test file without the meson test runner, you can also
-execute the file directly by specifying two environment variables first,
-the PYTHONPATH that has to include the python folder and the tests/functional
-folder of the source tree, and QEMU_TEST_QEMU_BINARY that has to point
-to the QEMU binary that should be used for the test. The current working
-directory should be your build folder. For example::
-
-  $ export PYTHONPATH=../python:../tests/functional
-  $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
-  $ pyvenv/bin/python3 ../tests/functional/test_file.py
+execute the file directly by specifying the name of the emulator target
+binary as an env variable.
+
+Assuming the current working directory is the top level source checkout
+and the build directory is './build'::
+
+  $ export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
+  $ ./build/run tests/functional/x86_64/test_virtio_version.py
 
 The test framework will automatically purge any scratch files created during
 the tests. If needing to debug a failed test, it is possible to keep these
diff --git a/meson.build b/meson.build
index d9293294d8..320fecf372 100644
--- a/meson.build
+++ b/meson.build
@@ -3,8 +3,6 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
         version: files('VERSION'))
 
-meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
-
 add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
                env: ['RUST_BACKTRACE=1'])
 add_test_setup('slow', exclude_suites: ['thorough'],
@@ -3507,6 +3505,20 @@ endif
 config_host_h = configure_file(output: 'config-host.h', configuration: config_host_data)
 genh += config_host_h
 
+devenv = environment()
+devenv.set('MESON_BUILD_ROOT', meson.project_build_root())
+devenv.set('VIRTUAL_ENV', meson.project_build_root() / 'pyvenv')
+devenv.prepend('PATH', meson.project_build_root() / 'pyvenv'/ 'bin')
+devenv.prepend('PYTHONPATH', meson.current_source_dir() / 'tests' / 'functional')
+devenv.prepend('PYTHONPATH', meson.current_source_dir() / 'python')
+meson.add_devenv(devenv)
+
+run_config = configuration_data({'build_dir': meson.current_build_dir()})
+run = configure_file(input: 'run.in',
+                     output: 'run',
+                     configuration: run_config)
+run_command('chmod', 'a+x', meson.current_build_dir() / 'run', check: true)
+
 hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.py')
 qapi_gen = find_program('scripts/qapi-gen.py')
diff --git a/run.in b/run.in
new file mode 100644
index 0000000000..cf4821311d
--- /dev/null
+++ b/run.in
@@ -0,0 +1,6 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+eval $(meson devenv -C @build_dir@ --dump --dump-format export)
+
+exec "$@"
-- 
2.52.0


