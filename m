Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBA606A326
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=nRFs7tix
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbI9-0007Gi-Ui; Sun, 01 Nov 2026 14:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anbelski@linux.microsoft.com>)
 id 1xNbI7-0007GF-V4
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 14:32:31 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anbelski@linux.microsoft.com>) id 1xNbI3-0002oL-Nw
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 14:32:31 -0500
Received: from frill.fritz.box (p5dd8eb1f.dip0.t-ipconnect.de [93.216.235.31])
 by linux.microsoft.com (Postfix) with ESMTPSA id 875E020B7166;
 Sun,  1 Nov 2026 11:32:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 875E020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1793561530;
 bh=ZKxRI0BXqFH124GNZ3BqcvenefampOwIQJMRdSUmIrA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nRFs7tixOnFTJl6LY5wI5Pbc0VzHRhVyXDSEgWc3yirvLEyaNPK3LxSgfjTv9PvFF
 2uhtZbsijzMYiqDDICEbFPluAgcJ3heKM4XPhqkMule0DFNhnsePT2drReisMtv3il
 K8A8hEvxrXw0M/vOV/2cMT9bZrxfxpIsvxXlSb7M=
From: Anatol Belski <anbelski@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: th.huth+qemu@posteo.eu, berrange@redhat.com, mvaralar@redhat.com,
 philmd@oss.qualcomm.com, pbonzini@redhat.com, zhao1.liu@intel.com
Subject: [PATCH v3] tests: Add virtio-villain fault injection suite
Date: Sun,  1 Nov 2026 20:28:29 +0100
Message-ID: <20261101193218.3612868-1-anbelski@linux.microsoft.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025234922.1766842-1-anbelski@linux.microsoft.com>
References: <20261025234922.1766842-1-anbelski@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=anbelski@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test suite that drives the virtio-villain harness against QEMU.
virtio-villain is a guest side fault injection tool that boots a
separate guest for each case. Each case supplies invalid virtio driver
input to test how the device model handles it.

The harness is added as a git submodule under tests/virtio-villain.
Case IDs are discovered from source filenames during configuration
and each case is registered as a Meson test. Meson controls parallel
execution and timeouts, with one case per runner invocation.

The suite builds the static guest initramfs and fetches kernels on
demand for native Linux x86_64 and aarch64 hosts. Generated artifacts
stay in the build directory and kernel downloads use the QEMU asset
cache. The build uses the C compiler configured by Meson. KVM is the
default, while QEMU_TEST_VIRTIO_VILLAIN_ACCEL=tcg selects TCG.

The check-virtio-villain make target builds and runs the suite without
adding it to the default check target. Each case retains readable logs
and JSON reports, with skipped cases reported separately from
successful tests. Embedded helper tests and documentation are
included. GitLab CI configuration is added for a Fedora job with TCG.

Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
---
Thanks for the review. I've adapted virtio-villain and subsequently
the current patch to fulfill the review points. TCG is now supported
along with KVM, as the latter can be useful for local runs.

I run the tests regularly, especially when developing new cases, and
compare the results across all supported VMMs. The failures
mentioned in the review are not unexpected.

I submitted a patch for some of the SND issues some time ago:
https://lore.kernel.org/qemu-devel/20261001224501.1952113-1-anbelski@linux.microsoft.com/T/#u

I also filed GitLab work item #4117 based on the findings from T0063
a couple of months ago. Those issues need follow up separately from
this integration patch.


 .gitlab-ci.d/buildtest.yml            |  13 +
 .gitmodules                           |   3 +
 MAINTAINERS                           |   7 +
 docs/devel/testing/index.rst          |   1 +
 docs/devel/testing/virtio-villain.rst |  98 ++++++++
 scripts/mtest2make.py                 |   3 +-
 tests/Makefile.include                |   3 +
 tests/meson.build                     |  54 ++++
 tests/virtio-villain                  |   1 +
 tests/virtio-villain-build.py         |  64 +++++
 tests/virtio-villain-list.py          |  53 ++++
 tests/virtio-villain-test.py          | 348 ++++++++++++++++++++++++++
 12 files changed, 647 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/testing/virtio-villain.rst
 create mode 160000 tests/virtio-villain
 create mode 100644 tests/virtio-villain-build.py
 create mode 100644 tests/virtio-villain-list.py
 create mode 100644 tests/virtio-villain-test.py

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index b1e95395d0..19d6d4c363 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -148,6 +148,19 @@ functional-system-fedora:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check-functional
 
+virtio-villain:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-fedora
+      artifacts: true
+  variables:
+    IMAGE: fedora
+    QEMU_TEST_VIRTIO_VILLAIN_ACCEL: tcg
+  script:
+    - cd build
+    - make -j"$JOBS" check-virtio-villain
+  allow_failure: true
+
 crash-test-fedora:
   extends: .native_test_job_template
   needs:
diff --git a/.gitmodules b/.gitmodules
index c307216d17..fd3083ca4b 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -45,3 +45,6 @@
 [submodule "tests/lcitool/libvirt-ci"]
 	path = tests/lcitool/libvirt-ci
 	url = https://gitlab.com/libvirt/libvirt-ci.git
+[submodule "tests/virtio-villain"]
+	path = tests/virtio-villain
+	url = https://github.com/weltling/virtio-villain.git
diff --git a/MAINTAINERS b/MAINTAINERS
index 70e9fed776..fa5efa27e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4698,6 +4698,13 @@ F: tests/functional/generic/test_linters.py
 F: tests/functional/pylintrc
 F: tests/functional/qemu_test/
 
+virtio-villain fault injection test
+M: Anatol Belski <anbelski@linux.microsoft.com>
+S: Maintained
+F: tests/virtio-villain
+F: tests/virtio-villain-*.py
+F: docs/devel/testing/virtio-villain.rst
+
 Windows Hosted Continuous Integration
 M: Yonggang Luo <luoyonggang@gmail.com>
 S: Maintained
diff --git a/docs/devel/testing/index.rst b/docs/devel/testing/index.rst
index ccc2fc6cbc..875ef92128 100644
--- a/docs/devel/testing/index.rst
+++ b/docs/devel/testing/index.rst
@@ -10,6 +10,7 @@ testing infrastructure.
    main
    qtest
    functional
+   virtio-villain
    acpi-bits
    ci
    fuzzing
diff --git a/docs/devel/testing/virtio-villain.rst b/docs/devel/testing/virtio-villain.rst
new file mode 100644
index 0000000000..45f43036e7
--- /dev/null
+++ b/docs/devel/testing/virtio-villain.rst
@@ -0,0 +1,98 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+virtio-villain
+==============
+
+The virtio-villain suite tests how QEMU handles invalid virtio driver
+input. The harness boots a separate guest for each case to isolate
+crashes. Meson registers each case individually and controls parallel
+execution, timeouts and results.
+
+Requirements
+------------
+
+The suite supports native Linux x86_64 and aarch64 builds with the
+matching system emulator enabled. It uses KVM by default. Set
+``QEMU_TEST_VIRTIO_VILLAIN_ACCEL=tcg`` to run with TCG. Cross builds are
+not supported.
+Building the static guest init requires make, strip, cpio, gzip and
+static C library support in the C compiler configured by Meson.
+
+Meson initializes the submodule at ``tests/virtio-villain`` during
+configuration.
+With automatic downloads disabled, initialize the submodule manually
+before configuring QEMU::
+
+  git submodule update --init tests/virtio-villain
+
+Running the suite
+-----------------
+
+From the QEMU checkout, run::
+
+  make check-virtio-villain
+
+Set the accelerator explicitly when running without KVM::
+
+  QEMU_TEST_VIRTIO_VILLAIN_ACCEL=tcg make check-virtio-villain
+
+The target builds the guest initramfs and fetches kernels on demand.
+Neither operation runs during a normal QEMU build. Generated files
+stay under the build directory. Kernel downloads
+reuse the QEMU asset cache and verify the SHA256 checksum. Set
+``QEMU_TEST_CACHE_DIR`` to override the cache location or
+``QEMU_TEST_NO_DOWNLOAD=1`` to require cached kernels.
+
+This standalone suite is not part of the functional tests or the
+default ``make check`` selection. Its Meson suite name is
+``virtio-villain-optional``, following the QEMU optional suite convention.
+To run one case directly through Meson::
+
+  $BUILD-DIR/run meson test RNG0001-basic
+
+Filtering cases
+---------------
+
+Meson test names combine the case ID with a description from the source
+filename, for example ``RNG0001-basic``. The suite identifies them as
+virtio-villain tests without repeating that prefix in every name.
+
+Pass Meson name filters through ``MTESTARGS`` to run one case by ID::
+
+  make check-virtio-villain MTESTARGS='RNG0001-*'
+
+Use a wildcard to run a group of cases::
+
+  make check-virtio-villain MTESTARGS='RNG*'
+
+Multiple filters select the union of their matches::
+
+  make check-virtio-villain \
+    MTESTARGS='RNG* B0196-*'
+
+List matching cases without running them::
+
+  $BUILD-DIR/run meson test --suite virtio-villain-optional --list 'RNG*'
+
+Quote wildcard filters to prevent shell expansion. These are Meson
+test name filters, not the directory filters of the villain runner.
+
+Results and logs
+----------------
+
+Each invocation runs one case with the QEMU binary from the build.
+
+PASS and REJECT pass. SKIP and XFAIL are reported as skipped.
+FAIL, WEDGED and XPASS fail. Runner errors and missing reports fail
+rather than appearing as successful tests. Unsupported devices and
+unavailable host services are skipped by the harness.
+
+Meson reports each case separately and writes its standard text and
+JUnit reports under ``<build>/meson-logs/``. Full readable case logs
+and JSON reports are retained under
+``<build>/tests/virtio-villain-build/logs/<case>.log`` and ``<case>.json``.
+The test output always points to its case log.
+
+The reporting helper has embedded unit tests that run without a VM::
+
+  python3 tests/virtio-villain-test.py --self-test
diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 383ea68b16..696c41e9f4 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -80,7 +80,8 @@ def emit_prolog(suites, prefix):
     print(f'all-{prefix}-targets = {all_targets}')
     print(f'all-{prefix}-xml = {all_xml}')
     print(f'.PHONY: {prefix} do-meson-{prefix} {prefix}-report.junit.xml $(all-{prefix}-targets) $(all-{prefix}-xml)')
-    print(f'ninja-cmd-goals += $(foreach s, $(.{prefix}.mtest-suites), $(.{prefix}-$s.deps))')
+    print(f'ninja-cmd-goals += $(foreach s, $(.{prefix}.mtest-suites), '
+          f'$(.{prefix}-$(patsubst %-optional,%,$s).deps))')
     print(f'{prefix}-build: run-ninja')
     print(f'{prefix} $(all-{prefix}-targets): do-meson-{prefix}')
     print(f'do-meson-{prefix}: run-ninja; $(if $(MAKE.n),,+)$(MESON) test $(.{prefix}.mtestargs)')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9f82552ab5..7d13a97f69 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -16,6 +16,7 @@ check-help:
 	@echo " $(MAKE) check-tracetool               Run tracetool generator tests"
 	@echo " $(MAKE) check-block                   Run block tests (all formats/protocols)"
 	@echo " $(MAKE) check-block-DRIVER            Run block tests (only for format/protocol 'DRIVER')"
+	@echo " $(MAKE) check-virtio-villain          Run the standalone virtio fault injection suite"
 ifneq ($(filter $(all-check-targets), check-softfloat),)
 	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
 	@echo " $(MAKE) check-tcg                     Run TCG tests"
@@ -64,6 +65,8 @@ check-build: run-ninja
 
 check-clean:
 	rm -rf $(BUILD_DIR)/tests/functional
+	rm -rf $(BUILD_DIR)/tests/virtio-villain-build
+	rm -f $(BUILD_DIR)/tests/virtio-villain-initramfs.stamp
 
 clean: check-clean
 
diff --git a/tests/meson.build b/tests/meson.build
index 5877d2f60b..369b73e29d 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -1,6 +1,60 @@
 subdir('bench')
 subdir('qemu-iotests')
 
+if host_os == 'linux' and not meson.is_cross_build() and \
+   cpu in ['x86_64', 'aarch64'] and \
+   emulators.has_key('qemu-system-' + cpu)
+
+  villain_make = find_program('make', required: false)
+  villain_strip = find_program('strip', required: false)
+  villain_cpio = find_program('cpio', required: false)
+  villain_gzip = find_program('gzip', required: false)
+
+  if villain_make.found() and villain_strip.found() and \
+     villain_cpio.found() and villain_gzip.found()
+    villain_list = files('virtio-villain-list.py')
+    villain_list_args = get_option('wrap_mode') == 'nodownload' ? \
+                        ['--no-download'] : []
+
+    villain_names = run_command(
+      python, villain_list, villain_list_args, check: true
+    ).stdout().strip().split()
+    villain_sources = run_command(
+      python, villain_list, villain_list_args, '--sources', check: true
+    ).stdout().strip().split('\n')
+
+    villain_cc = meson.get_compiler('c', native: true).cmd_array()
+    villain_build_dir = meson.current_build_dir() / 'virtio-villain-build'
+
+    villain_initramfs = custom_target(
+      'virtio-villain-initramfs',
+      output: 'virtio-villain-initramfs.stamp',
+      command: [python, files('virtio-villain-build.py'),
+                '--source', meson.current_source_dir() / 'virtio-villain',
+                '--build', villain_build_dir, '--arch', cpu,
+                '--stamp', '@OUTPUT@', '--make', villain_make.full_path(),
+                '--'] + villain_cc,
+      depend_files: files(villain_sources
+                          + ['functional/qemu_test/asset.py']),
+      build_by_default: false)
+
+    foreach name : villain_names
+      test(name, python,
+           args: [files('virtio-villain-test.py'),
+                  '--build', villain_build_dir,
+                  '--source', meson.current_source_dir() / 'virtio-villain',
+                  '--qemu', emulators['qemu-system-' + cpu].full_path(),
+                  name.split('-')[0]],
+           depends: [villain_initramfs, emulators['qemu-system-' + cpu]],
+           suite: ['virtio-villain-optional'], timeout: 90)
+    endforeach
+
+  else
+    message('virtio-villain requires make, strip, cpio and gzip')
+  endif
+endif
+
+
 test_qapi_outputs = [
   'qapi-builtin-types.c',
   'qapi-builtin-types.h',
diff --git a/tests/virtio-villain b/tests/virtio-villain
new file mode 160000
index 0000000000..5fda8d1a78
--- /dev/null
+++ b/tests/virtio-villain
@@ -0,0 +1 @@
+Subproject commit 5fda8d1a78f0238b3c952c454c2cf15b1bfd204e
diff --git a/tests/virtio-villain-build.py b/tests/virtio-villain-build.py
new file mode 100644
index 0000000000..9816980b69
--- /dev/null
+++ b/tests/virtio-villain-build.py
@@ -0,0 +1,64 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import argparse
+from pathlib import Path
+import runpy
+import shlex
+import shutil
+import subprocess
+
+
+KERNELS = {
+    'x86_64': (
+        'vmlinux-x86_64',
+        '9d3570b47d5abb069ca00edfbfcef4c68306a9c3d078a01f10082b258f1001b8'),
+    'aarch64': (
+        'Image-arm64',
+        '69d1b1235381ec50f1b45cf771a7dff4a9013d452833ab34682d6283e2114010'),
+}
+KERNEL_URL = ('https://github.com/cloud-hypervisor/linux/releases/download/'
+              'ch-release-v6.16.9-20260508/')
+MMIO_KERNEL = (
+    'bzImage-x86_64',
+    '58088758f601a04ef85b09cf23db5530d51edc039ed47afbf2264c5b762cb568')
+
+
+def main():
+    parser = argparse.ArgumentParser()
+    parser.add_argument('--source', type=Path, required=True)
+    parser.add_argument('--build', type=Path, required=True)
+    parser.add_argument('--arch', choices=KERNELS, required=True)
+    parser.add_argument('--stamp', type=Path, required=True)
+    parser.add_argument('--make', required=True)
+    parser.add_argument('compiler', nargs=argparse.REMAINDER)
+    args = parser.parse_args()
+    compiler = args.compiler
+    if compiler[:1] == ['--']:
+        compiler = compiler[1:]
+    if not compiler:
+        parser.error('a guest compiler is required')
+
+    args.build.mkdir(parents=True, exist_ok=True)
+    subprocess.run(
+        [args.make, '-C', str(args.source), 'initramfs',
+         f'TARGET={args.build / "target"}',
+         f'CC={shlex.join(compiler)}'], check=True)
+    # Load the cache helper without importing the functional test runner.
+    asset_path = (Path(__file__).resolve().parent
+                  / 'functional/qemu_test/asset.py')
+    asset_type = runpy.run_path(str(asset_path))['Asset']
+    filename, digest = KERNELS[args.arch]
+    kernel = asset_type(KERNEL_URL + filename, digest).fetch()
+    shutil.copyfile(kernel, args.build / 'kernel')
+    if args.arch == 'x86_64':
+        filename, digest = MMIO_KERNEL
+        kernel = asset_type(KERNEL_URL + filename, digest).fetch()
+        shutil.copyfile(kernel, args.build / 'mmio-kernel')
+    else:
+        shutil.copyfile(args.build / 'kernel', args.build / 'mmio-kernel')
+    args.stamp.touch()
+
+
+if __name__ == '__main__':
+    main()
diff --git a/tests/virtio-villain-list.py b/tests/virtio-villain-list.py
new file mode 100644
index 0000000000..5e58bd209c
--- /dev/null
+++ b/tests/virtio-villain-list.py
@@ -0,0 +1,53 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import argparse
+from pathlib import Path
+import re
+import subprocess
+import sys
+
+
+def test_names(source):
+    names = []
+    ids = set()
+    for path in sorted((source / 'tests').glob('*/*.c')):
+        parts = path.stem.split('_', 1)
+        name = parts[0].upper()
+        if not re.fullmatch(r'[A-Z]+[0-9]+', name):
+            continue
+        if name in ids:
+            raise ValueError(f'Duplicate virtio-villain test ID: {name}')
+        ids.add(name)
+        description = parts[1].replace('_', '-') if len(parts) == 2 else ''
+        names.append(f'{name}-{description}' if description else name)
+    if not names:
+        raise ValueError('Missing or duplicate virtio-villain test names')
+    return names
+
+
+def main():
+    parser = argparse.ArgumentParser()
+    parser.add_argument('--no-download', action='store_true')
+    parser.add_argument('--sources', action='store_true')
+    args = parser.parse_args()
+    root = Path(__file__).resolve().parent.parent
+    source = root / 'tests/virtio-villain'
+    if not (source / 'Makefile').exists():
+        if args.no_download or not (root / '.git').exists():
+            parser.error('Initialize tests/virtio-villain with '
+                         'git submodule update --init tests/virtio-villain')
+        subprocess.run(['git', 'submodule', 'update', '--init',
+                        'tests/virtio-villain'], cwd=root, check=True,
+                       stdout=sys.stderr)
+    if args.sources:
+        paths = [source / 'Makefile', source / 'run']
+        paths += sorted(source.glob('**/*.c'))
+        paths += sorted(source.glob('**/*.h'))
+        print('\n'.join(str(path) for path in paths))
+    else:
+        print('\n'.join(test_names(source)))
+
+
+if __name__ == '__main__':
+    main()
diff --git a/tests/virtio-villain-test.py b/tests/virtio-villain-test.py
new file mode 100644
index 0000000000..be831c4058
--- /dev/null
+++ b/tests/virtio-villain-test.py
@@ -0,0 +1,348 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import argparse
+import contextlib
+import importlib.machinery
+import importlib.util
+import io
+import json
+import os
+from pathlib import Path
+import re
+import runpy
+import subprocess
+import sys
+import tempfile
+import types
+import unittest
+from unittest import mock
+
+
+ANSI = re.compile(
+    r'\x1b\][^\x07\x1b]*(?:\x07|\x1b\\)|'
+    r'\x1b\[[0-?]*[ -/]*[@-~]|\x1b[ -/]*[@-Z\\-_a-z]')
+
+ACCEL_ENV = 'QEMU_TEST_VIRTIO_VILLAIN_ACCEL'
+ACCELERATORS = ('kvm', 'tcg')
+
+
+def clean(text):
+    return ANSI.sub('', text.replace('\r\n', '\n').replace('\r', '\n'))
+
+
+def selected_accel():
+    accel = os.environ.get(ACCEL_ENV, 'kvm')
+    if accel not in ACCELERATORS:
+        choices = ', '.join(ACCELERATORS)
+        raise ValueError(f'{ACCEL_ENV} must be one of {choices}')
+    return accel
+
+
+def outcome(report, name, returncode):
+    cases = report['tests']
+    if not cases and returncode == 0:
+        return 77
+    if len(cases) != 1 or cases[0]['name'] != name:
+        raise ValueError(f'Expected exactly one result for {name}')
+    status = cases[0]['status']
+    if status in ('FAIL', 'WEDGED', 'XPASS'):
+        return 1
+    if returncode != 0:
+        return 1
+    if status in ('SKIP', 'XFAIL'):
+        return 77
+    if status in ('PASS', 'REJECT'):
+        return 0
+    raise ValueError(f'Unknown virtio-villain status: {status}')
+
+
+def kernel_path(build, name):
+    filename = 'mmio-kernel' if name.startswith('M') else 'kernel'
+    return Path(build) / filename
+
+
+def run_runner(source, build, arguments):
+    loader = importlib.machinery.SourceFileLoader('virtio_villain', source)
+    spec = importlib.util.spec_from_loader(loader.name, loader)
+    runner = importlib.util.module_from_spec(spec)
+    loader.exec_module(runner)
+    # Separate runner processes otherwise allocate the same host vsock CIDs.
+    runner.Qemu._cid_counter = os.getpid() * 256
+    sys.argv = [
+        source,
+        '--init', str(Path(build) / 'target/init'),
+        '--initramfs', str(Path(build) / 'target/initramfs.cpio.gz'),
+        '--accel', selected_accel(),
+        *arguments,
+    ]
+    runner.main()
+
+
+def main():
+    parser = argparse.ArgumentParser()
+    parser.add_argument('--build', type=Path, required=True)
+    parser.add_argument('--source', type=Path, required=True)
+    parser.add_argument('--qemu', required=True)
+    parser.add_argument('name')
+    args = parser.parse_args()
+    try:
+        selected_accel()
+    except ValueError as error:
+        parser.error(str(error))
+    logs = args.build / 'logs'
+    logs.mkdir(exist_ok=True)
+    report_path = logs / f'{args.name}.json'
+    log_path = logs / f'{args.name}.log'
+    report_path.unlink(missing_ok=True)
+    log_path.unlink(missing_ok=True)
+    result = subprocess.run(
+        [sys.executable, '-B', str(Path(__file__).resolve()), '--runner',
+         str(args.source / 'run'), str(args.build),
+         '-m', args.qemu, '-k',
+         str(kernel_path(args.build, args.name)),
+         '--transport', 'mmio' if args.name.startswith('M') else 'pci',
+         '--skip-unsupported', '-j', '1',
+         '--log-dir', str(logs),
+         '--format', 'json', '--output', str(report_path),
+         args.name], capture_output=True, text=True, errors='replace',
+        check=False)
+    text = clean(result.stdout) + clean(result.stderr)
+    serial = clean(log_path.read_text(errors='replace')) \
+        if log_path.exists() else None
+    code = 1
+    try:
+        if not report_path.exists():
+            raise ValueError('virtio-villain produced no JSON report')
+        with report_path.open() as stream:
+            report = json.load(stream)
+        for case in report['tests']:
+            text += ('\n{status} {name} (spec {spec_section}) '
+                     '{description}\n').format(**case)
+            text += serial if serial is not None else \
+                clean(case.get('output') or '')
+        code = outcome(report, args.name, result.returncode)
+    except (OSError, ValueError, KeyError, TypeError) as error:
+        text += f'\nERROR: invalid virtio-villain result: {error}\n'
+    log_path.write_text(text)
+    print(text, end='')
+    print(f'\nFull virtio-villain log: {log_path}')
+    return code
+
+
+class Helpers(unittest.TestCase):
+    def test_clean(self):
+        self.assertEqual(clean('\x1bc\x1b[?7lA\r\nB\rC\x1b[0m'),
+                         'A\nB\nC')
+        self.assertEqual(clean('\x1b]0;title\x07text'), 'text')
+
+    def test_outcomes(self):
+        for status, expected in (
+                ('PASS', 0), ('REJECT', 0), ('SKIP', 77), ('XFAIL', 77),
+                ('FAIL', 1), ('WEDGED', 1), ('XPASS', 1)):
+            with self.subTest(status=status):
+                report = {'tests': [{'name': 'RNG0001', 'status': status}]}
+                self.assertEqual(outcome(report, 'RNG0001', 0), expected)
+
+    def test_runner_error_is_failure(self):
+        report = {'tests': [{'name': 'RNG0001', 'status': 'PASS'}]}
+        self.assertEqual(outcome(report, 'RNG0001', 1), 1)
+        self.assertEqual(outcome({'tests': []}, 'M0001', 0), 77)
+        with self.assertRaises(ValueError):
+            outcome({'tests': []}, 'RNG0001', 1)
+
+    def test_wrong_case_is_error(self):
+        with self.assertRaises(ValueError):
+            outcome({'tests': [{'name': 'OTHER', 'status': 'PASS'}]},
+                    'RNG0001', 0)
+
+    def test_unknown_status_is_error(self):
+        with self.assertRaises(ValueError):
+            outcome({'tests': [{'name': 'RNG0001', 'status': 'UNKNOWN'}]},
+                    'RNG0001', 0)
+
+    def test_runner_configuration(self):
+        runner = types.SimpleNamespace(
+            main=mock.Mock(),
+            Qemu=types.SimpleNamespace())
+        with mock.patch.object(importlib.machinery.SourceFileLoader,
+                               'exec_module'), \
+             mock.patch.object(importlib.util, 'module_from_spec',
+                               return_value=runner), \
+             mock.patch.object(sys, 'argv', []), \
+             mock.patch.object(os, 'getpid', return_value=123):
+            run_runner('/source/run', '/build', ['RNG0001'])
+            self.assertEqual(runner.Qemu._cid_counter, 123 * 256)
+            runner.main.assert_called_once_with()
+            accel = sys.argv[sys.argv.index('--accel') + 1]
+            self.assertIn(accel, ACCELERATORS)
+            self.assertEqual(sys.argv, [
+                '/source/run',
+                '--init', '/build/target/init',
+                '--initramfs', '/build/target/initramfs.cpio.gz',
+                '--accel', accel,
+                'RNG0001',
+            ])
+
+    def test_runner_can_select_tcg(self):
+        runner = types.SimpleNamespace(
+            main=mock.Mock(),
+            Qemu=types.SimpleNamespace())
+        with mock.patch.object(importlib.machinery.SourceFileLoader,
+                               'exec_module'), \
+             mock.patch.object(importlib.util, 'module_from_spec',
+                               return_value=runner), \
+             mock.patch.object(sys, 'argv', []), \
+             mock.patch.dict(os.environ,
+                             {'QEMU_TEST_VIRTIO_VILLAIN_ACCEL': 'tcg'}):
+            run_runner('/source/run', '/build', ['RNG0001'])
+            self.assertEqual(sys.argv[sys.argv.index('--accel') + 1], 'tcg')
+            runner.main.assert_called_once_with()
+
+    def test_kernel_selection(self):
+        for name in ('RNG0001', 'B0201', 'PCI0200'):
+            with self.subTest(name=name):
+                self.assertEqual(kernel_path(Path('/build'), name),
+                                 Path('/build/kernel'))
+        self.assertEqual(kernel_path(Path('/build'), 'M0010'),
+                         Path('/build/mmio-kernel'))
+
+    def test_build_uses_only_cloud_hypervisor_kernels(self):
+        script = Path(__file__).with_name('virtio-villain-build.py')
+        builder = runpy.run_path(str(script))
+        for arch in ('x86_64', 'aarch64'):
+            with self.subTest(arch=arch), \
+                 tempfile.TemporaryDirectory() as directory:
+                root = Path(directory)
+                kernel = root / 'download'
+                kernel.write_bytes(b'kernel')
+                asset_type = mock.Mock()
+                asset_type.return_value.fetch.return_value = kernel
+                argv = [
+                    'build', '--source', '/source', '--build', directory,
+                    '--arch', arch, '--stamp', str(root / 'stamp'),
+                    '--make', 'make', '--', 'cc',
+                ]
+                with mock.patch.object(sys, 'argv', argv), \
+                     mock.patch.object(subprocess, 'run') as build, \
+                     mock.patch.object(runpy, 'run_path',
+                                       return_value={'Asset': asset_type}):
+                    builder['main']()
+                expected = [
+                    mock.call(builder['KERNEL_URL'] + filename, digest)
+                    for filename, digest in [builder['KERNELS'][arch]]
+                    + ([builder['MMIO_KERNEL']] if arch == 'x86_64' else [])
+                ]
+                self.assertEqual(asset_type.call_args_list, expected)
+                self.assertEqual(asset_type.return_value.fetch.call_count,
+                                 len(expected))
+                build.assert_called_once_with(
+                    ['make', '-C', '/source', 'initramfs',
+                     f'TARGET={root / "target"}', 'CC=cc'], check=True)
+                self.assertEqual((root / 'kernel').read_bytes(), b'kernel')
+                self.assertEqual((root / 'mmio-kernel').read_bytes(),
+                                 b'kernel')
+                self.assertFalse((root / 'hotplug-kernel').exists())
+                self.assertTrue((root / 'stamp').exists())
+
+    def test_full_readable_log(self):
+        with tempfile.TemporaryDirectory() as directory:
+            root = Path(directory)
+            case = {'name': 'RNG0001', 'status': 'PASS',
+                    'spec_section': '5.4.6',
+                    'description': 'RNG basic request',
+                    'output': ''}
+
+            def run(*unused_args, **unused_kwargs):
+                (root / 'logs/RNG0001.json').write_text(
+                    json.dumps({'tests': [case]}))
+                (root / 'logs/RNG0001.log').write_bytes(
+                    b'\x1bcguest\r\n[PASS] RNG0001\r\n')
+                return subprocess.CompletedProcess([], 0, '[PASS]\n', '')
+
+            argv = ['test', '--build', directory, '--source', '/source',
+                    '--qemu', '/build/qemu-system-x86_64', 'RNG0001']
+            with mock.patch.object(sys, 'argv', argv), \
+                 mock.patch.object(subprocess, 'run', side_effect=run), \
+                 mock.patch('builtins.print') as output:
+                self.assertEqual(main(), 0)
+            text = (root / 'logs/RNG0001.log').read_bytes()
+            self.assertIn(b'guest\n[PASS] RNG0001\n', text)
+            self.assertNotIn(b'\r', text)
+            self.assertNotIn(b'\x1b', text)
+            self.assertIn(str(root / 'logs/RNG0001.log'),
+                          output.call_args.args[0])
+
+    def test_explicit_transport(self):
+        for name, transport in (('RNG0001', 'pci'), ('M0010', 'mmio')):
+            with self.subTest(name=name), \
+                 tempfile.TemporaryDirectory() as directory:
+                root = Path(directory)
+                case = {'name': name, 'status': 'PASS',
+                        'spec_section': '4', 'description': 'Test case'}
+
+                def run(command, **kwargs):
+                    index = command.index('--transport')
+                    self.assertEqual(command[index + 1], transport)
+                    (root / f'logs/{name}.json').write_text(
+                        json.dumps({'tests': [case]}))
+                    return subprocess.CompletedProcess(command, 0, '', '')
+
+                argv = ['test', '--build', directory, '--source', '/source',
+                        '--qemu', '/build/qemu-system-x86_64', name]
+                with mock.patch.object(sys, 'argv', argv), \
+                     mock.patch.object(subprocess, 'run', side_effect=run), \
+                     mock.patch('builtins.print'):
+                    self.assertEqual(main(), 0)
+
+    def test_source_discovery(self):
+        script = Path(__file__).with_name('virtio-villain-list.py')
+        discover = runpy.run_path(str(script))['test_names']
+        with tempfile.TemporaryDirectory() as directory:
+            root = Path(directory)
+            (root / 'tests/rng').mkdir(parents=True)
+            (root / 'tests/rng/rng0001_basic.c').touch()
+            (root / 'tests/rng/rng_helpers.c').touch()
+            self.assertEqual(discover(root), ['RNG0001-basic'])
+            (root / 'tests/rng/rng0002_invalid_length.c').touch()
+            self.assertEqual(discover(root),
+                             ['RNG0001-basic', 'RNG0002-invalid-length'])
+            (root / 'tests/rng/rng0001_duplicate.c').touch()
+            with self.assertRaises(ValueError):
+                discover(root)
+
+    def test_initialization_keeps_stdout_machine_readable(self):
+        script = Path(__file__).with_name('virtio-villain-list.py')
+        list_main = runpy.run_path(str(script))['main']
+        with tempfile.TemporaryDirectory() as directory:
+            root = Path(directory)
+            (root / '.git').mkdir()
+
+            def initialize(*unused_args, **kwargs):
+                print('Submodule initialized', file=kwargs['stdout'])
+                source = root / 'tests/virtio-villain'
+                (source / 'tests/rng').mkdir(parents=True)
+                (source / 'Makefile').touch()
+                (source / 'tests/rng/rng0001_basic.c').touch()
+
+            output, diagnostic = io.StringIO(), io.StringIO()
+            with mock.patch.dict(
+                    list_main.__globals__,
+                    {'__file__': str(root / 'tests' / script.name)}), \
+                 mock.patch.object(sys, 'argv', ['list']), \
+                 mock.patch.object(
+                     subprocess, 'run', side_effect=initialize), \
+                 contextlib.redirect_stdout(output), \
+                 contextlib.redirect_stderr(diagnostic):
+                list_main()
+            self.assertEqual(output.getvalue(), 'RNG0001-basic\n')
+            self.assertIn('Submodule initialized', diagnostic.getvalue())
+
+
+if __name__ == '__main__':
+    if sys.argv[1:] == ['--self-test']:
+        unittest.main(argv=[sys.argv[0]])
+    elif sys.argv[1:2] == ['--runner']:
+        run_runner(sys.argv[2], sys.argv[3], sys.argv[4:])
+    else:
+        sys.exit(main())
-- 
2.56.0


