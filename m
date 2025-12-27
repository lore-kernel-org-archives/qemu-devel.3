Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC413E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQx7-0002bs-E0; Sat, 27 Dec 2025 04:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQx3-00029H-VY
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQx1-0007Rj-Ou
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VM5PP8BC0XUA3zL5E654yr1w20Sx2lVssb+lqRE2aqU=;
 b=eq0T5kPn1ZzF8L2AEP1ct+ze6W0bR3yEsfUwlN3t1LahixuWNUmhFKunDK5GUEp/iZdsBl
 97K4nx81NyDgtDp6tx1Ook+q+Lt/vJgT5DZQhHwrkKkgZ7+ldL757iGnZFkEgh2H8nG4xi
 nuA5ZUnxFPnTGBvQg8vJ2JfoQZXeFiA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-SUOexRxaNuGcYUqP2ihMGA-1; Sat, 27 Dec 2025 04:51:04 -0500
X-MC-Unique: SUOexRxaNuGcYUqP2ihMGA-1
X-Mimecast-MFC-AGG-ID: SUOexRxaNuGcYUqP2ihMGA_1766829063
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775d8428e8so65083705e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829062; x=1767433862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VM5PP8BC0XUA3zL5E654yr1w20Sx2lVssb+lqRE2aqU=;
 b=S1ULp+LL19pB1C47Rc20wZWZcG9uS15RLyGZ5cpUgErR7oBydGPn/DvhjgOOkuEFZ5
 n5WQvqVl2Fe/xiK3rXLVgtBQ1sHecX60iRKzRRaZ/KW7H5vV1dMEOdrAZRAeBDyeYV2g
 R4Tsr6inJFVXTA959Fa2r/LJmecarYoEvx2v0hjt5uZ/bWbuNfsUuagWJ6ROXFyBB9QX
 OkYj0qQZsk4qSjN8iDB434KazTqN7NTjqShOCpyKmsb/z20yOEtowz0TcC5Ba/BU1PZr
 UcAN+pAbZ55hT2QODIZTB+TeFK7a5j77BWhpsnemFUg5deL4BuNqLiCrDKhUfYnzJVpA
 UbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829062; x=1767433862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VM5PP8BC0XUA3zL5E654yr1w20Sx2lVssb+lqRE2aqU=;
 b=MsmUUCsnRCh0ITqU2YqKoTuFaY1nILaILxrAUGNMB4Lpevve1oVel9d+NzXFSjA9fI
 7qRqYZaQ/4Kns7I1H3HPJOwNEZHBoLViTZTGpUWMuOsxKpqcE/r3DFo2OASX07W42l+v
 I8wc9O53zMHbgBuym0MlylSD1wRogb1v3gPjpuspbZQ0yqCfC0WlFgVjDyJKlj+GptH9
 dOZthl7fsG4l3CfcXdtEh1+z9i7uD5GUbpMJ4VgGmTnvDo/l5aG4xcJdBRc1BVamMcP8
 rXu3s9Cip7qwpWVYmo8k9MJ3D1FJJcYpPTlYzTFHmO4fuZa/ig1zHY3p2WXAniLe4twX
 Nkxg==
X-Gm-Message-State: AOJu0YynbMTaWASWkxoBz8A8h2agJ/QxABzF0CCJspZ4dB7mI6et1sB3
 BEtJOCKfQJMI075WYtVQ57pqliyBwnkpgbY36fc+IyMC1ZsrJlIkpSzp/srbdRIUBWx25Gh9GAD
 QEknXDf/RO5Yr4QlJPOISzwXpkG+/ma15kIW8y8z0gdAN+b9QMvwgGJI9QYyh+Nv3us8lscXuJX
 QjN7tJLfBPXtHYLw8MyPG9iBc3r9jwlw19cqIifTlh
X-Gm-Gg: AY/fxX7634EzNLoE50fZO2VNkG26WKLcJlYmH+ULgVLFR1+8BUljZgJuq03j+E1J6Hs
 M8B+Qk8+H2fZjKigXTbpEO+mOsbxWNZcKWjvlXtiL/eZi7SBNhDLBsKM1ptP45cAtkN+jB2OZEE
 FKlzqKqyNG1PM5e7JdEadr37VVET0guoQ3quvwpugAkYlPNUr/APipSagUrk9OW6x2v4iYYoXEx
 iIYPcYvWWtDpGrrwXIvYeJGv8YLhSBgvS+doaqixY7iNFNaYADlKl0QGpBH94klfSS5kZeB647i
 pVFumNvWCPTZncctoRbSCmXUdjGXDg+pb5/5SzCbB8EIBSkt/titGNJW4m7dlSnDoODUmyQxPHk
 Cx1jQmgCgv9rBMlza/zWoJYYmXLpCXs5R1FEV3IVdqlxBaxzzDneUrYtrEv/nTjxk4pa+1sOdDx
 RH3WvYf4GY+aBvxQk=
X-Received: by 2002:a05:600c:4711:b0:477:9caa:1a26 with SMTP id
 5b1f17b1804b1-47d1959fadbmr275471605e9.29.1766829062167; 
 Sat, 27 Dec 2025 01:51:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtVN7G88XsQBl9m1DaxuMPV4s6zu+pdSnKuoG/lXkdU1CnoMpsveLXbGweMtDog6XV4HtJTg==
X-Received: by 2002:a05:600c:4711:b0:477:9caa:1a26 with SMTP id
 5b1f17b1804b1-47d1959fadbmr275471365e9.29.1766829061618; 
 Sat, 27 Dec 2025 01:51:01 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272e46fsm476183045e9.4.2025.12.27.01.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 135/153] run: introduce a script for running devel commands
Date: Sat, 27 Dec 2025 10:47:40 +0100
Message-ID: <20251227094759.35658-61-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
Link: https://lore.kernel.org/r/20251222113859.182395-1-berrange@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                       |  1 +
 docs/devel/build-system.rst       | 12 ++++++++++++
 docs/devel/testing/functional.rst | 15 +++++++--------
 meson.build                       | 16 ++++++++++++++--
 run.in                            |  4 ++++
 5 files changed, 38 insertions(+), 10 deletions(-)
 create mode 100644 run.in

diff --git a/MAINTAINERS b/MAINTAINERS
index a03898ccb63..81f48f0709c 100644
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
index 6204aa6a72e..b9797a374c7 100644
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
index fdeaebaadcb..1978f96eba1 100644
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
+execute the file directly by specifying the name of the emulator target
+binary as an env variable.
 
-  $ export PYTHONPATH=../python:../tests/functional
-  $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
-  $ pyvenv/bin/python3 ../tests/functional/test_file.py
+Assuming the current working directory is the top level source checkout
+and the build directory is './build'::
+
+  $ export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
+  $ ./build/run tests/functional/x86_64/test_virtio_version.py
 
 The test framework will automatically purge any scratch files created during
 the tests. If needing to debug a failed test, it is possible to keep these
diff --git a/meson.build b/meson.build
index 3790cf15f51..14b1160c15d 100644
--- a/meson.build
+++ b/meson.build
@@ -4,8 +4,6 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
                           'rust_std=2021', 'build.rust_std=2021'],
         version: files('VERSION'))
 
-meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
-
 add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
                env: ['RUST_BACKTRACE=1'])
 add_test_setup('slow', exclude_suites: ['thorough'],
@@ -3501,6 +3499,20 @@ endif
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
index 00000000000..1bb12272a72
--- /dev/null
+++ b/run.in
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+exec @build_dir@/pyvenv/bin/meson devenv -C @build_dir@ -w "$PWD" "$@"
-- 
2.52.0


