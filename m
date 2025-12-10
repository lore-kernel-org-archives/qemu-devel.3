Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF59D3C922
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 16:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTMhX-0004Y4-HZ; Wed, 10 Dec 2025 11:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTMhU-0004Xe-UR
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:06:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTMhP-000420-Lo
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765382754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9R8J0Xj4slRxR0f00c/bx/1Opk9xi75qjfB0jEWwLLU=;
 b=PxRPa2IpiIYFT77vtzYV++Rwqw+FKHJZKoBfnKwkBOrTCyK3j7mlmNTinV6S/1LDZep6CL
 5VPY2Jr4PqBDqpgZyzZ4Nujsp/new9HkyK4uuKPai7BPiHi0amvWdsPJuAfTW2WZSudKJs
 R2+as4lj8UJp91ew9DKZmmDywYqapOY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537--MwDyRNVPeu0qD1v8kWfNg-1; Wed,
 10 Dec 2025 11:05:50 -0500
X-MC-Unique: -MwDyRNVPeu0qD1v8kWfNg-1
X-Mimecast-MFC-AGG-ID: -MwDyRNVPeu0qD1v8kWfNg_1765382750
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2E9B1800675; Wed, 10 Dec 2025 16:05:49 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.162])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CA251800367; Wed, 10 Dec 2025 16:05:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] run: introduce a script for running devel commands
Date: Wed, 10 Dec 2025 16:05:44 +0000
Message-ID: <20251210160544.2265437-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Various aspects of the development workflow are complicated by the need
to set env variables ahead of time, or use specific paths. Introduce a
$BUILD_DIR/run script that will do a number of things

 * Set $PATH to point to $BUILD_DIR/qemu-bundle/$PREFIX/$BIN_DIR
 * Set $PYTHONPATH to point to $SRC_DIR/tests/functional
 * Source $BUILD_DIR/pyvenv/bin/activate

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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

Historical context: this 'run' script concept is something introduced
by libguestfs a decade & a half ago, and copied by libvirt shortly
after that. It has been very helpful in simplifying life for developers
and should do likewise for QEMU.

 docs/devel/build-system.rst       | 12 ++++++++++++
 docs/devel/testing/functional.rst | 17 ++++++++---------
 meson.build                       | 11 +++++++++++
 run.in                            | 15 +++++++++++++++
 4 files changed, 46 insertions(+), 9 deletions(-)
 create mode 100644 run.in

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 6204aa6a72..8ec8d20175 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -515,6 +515,18 @@ generates ``Makefile`` from ``Makefile.in``.
 
 Built by configure:
 
+``run``
+  Used to run commands / scripts from the git checkout. Sets ``$PATH``
+  to point to locally built binaries & activates the python venv before
+  running the requested command. Pass the command to run as args, for
+  example::
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
index d9293294d8..8f2320d362 100644
--- a/meson.build
+++ b/meson.build
@@ -3507,6 +3507,17 @@ endif
 config_host_h = configure_file(output: 'config-host.h', configuration: config_host_data)
 genh += config_host_h
 
+run_config = configuration_data(
+    {'build_dir': meson.current_build_dir(),
+     'src_dir': meson.current_source_dir(),
+     'bin_dir': get_option('prefix') / get_option('bindir')},
+)
+
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
index 0000000000..124f0daed2
--- /dev/null
+++ b/run.in
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Ensure that we find our local builds first
+PATH=@build_dir@/qemu-bundle/@bin_dir@:$PATH
+export PATH
+
+# Ensure that functional tests find their lib
+PYTHONPATH=@src_dir@/tests/functional${PYTHONPATH:+:${PYTHONPATH}}
+export PYTHONPATH
+
+# Ensure that everything uses the venv python & site packages
+source @build_dir@/pyvenv/bin/activate
+
+exec $@
-- 
2.51.1


