Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A022CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCO27-0005cB-Dt; Thu, 01 Oct 2026 17:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anbelski@linux.microsoft.com>)
 id 1xCO25-0005bu-7V
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:09:37 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anbelski@linux.microsoft.com>) id 1xCO22-0004mw-F8
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:09:36 -0400
Received: from frill.fritz.box (p508abfc2.dip0.t-ipconnect.de [80.138.191.194])
 by linux.microsoft.com (Postfix) with ESMTPSA id EA92520B7166;
 Thu,  1 Oct 2026 14:08:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA92520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1790888918;
 bh=XJ8K2celsQmqhzuZk7zWZRUiyLa2Qzcp/x+y0gU7anA=;
 h=From:To:Cc:Subject:Date:From;
 b=cTnIpLvyiW8M647E1QnpJZrzE+IqrdQh3AFgsdnoYCQ/rHrosurLibzBChLfaZaAh
 rhNeqauY+RLrwVZKnEzfKdOegjYm7KPpbhoAIGs6PvTc1vsIuxGdnVejfXxflsCZDY
 oDpmGm/4O2diYb6BLOHpGAn95lhj/7hetRXxdRVM=
From: Anatol Belski <anbelski@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC PATCH] tests/functional: Add virtio-villain fault injection test
Date: Thu,  1 Oct 2026 23:09:16 +0200
Message-ID: <20261001210916.1907716-1-anbelski@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a functional test that drives the virtio-villain harness against
the QEMU under test. virtio-villain is a guest side fault injection
tool that boots one short lived guest per case. Each case violates a
driver rule from the virtio spec and checks that the device model
handles the bad input without crashing, hanging, or corrupting state.

The harness is added as a git submodule under
tests/functional/virtio-villain. The test builds the static guest init
with the host compiler for a native guest, or an architecture cross
compiler for a foreign guest, then runs the whole supported suite one
guest per case and fails if any case reports FAIL, WEDGED, or XPASS.
Cases that need host support which is absent, such as vhost-vsock or a
virtiofs daemon, are skipped.

The guest kernel is fetched as a cached asset. The test lives in the
generic directory and is registered in the x86_64 and aarch64 thorough
suites, skipping any host that cannot provide a kernel or a compiler
for the guest architecture.

Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
---
 .gitmodules                                   |   3 +
 MAINTAINERS                                   |   6 +
 docs/devel/testing/functional.rst             |  27 +++
 tests/functional/aarch64/meson.build          |   2 +
 .../functional/generic/test_virtio_villain.py | 195 ++++++++++++++++++
 tests/functional/virtio-villain               |   1 +
 tests/functional/x86_64/meson.build           |   2 +
 7 files changed, 236 insertions(+)
 create mode 100755 tests/functional/generic/test_virtio_villain.py
 create mode 160000 tests/functional/virtio-villain

diff --git a/.gitmodules b/.gitmodules
index c307216d17..3a3b85c516 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -45,3 +45,6 @@
 [submodule "tests/lcitool/libvirt-ci"]
 	path = tests/lcitool/libvirt-ci
 	url = https://gitlab.com/libvirt/libvirt-ci.git
+[submodule "tests/functional/virtio-villain"]
+	path = tests/functional/virtio-villain
+	url = https://github.com/weltling/virtio-villain.git
diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd..0021e8498e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4647,6 +4647,12 @@ F: tests/functional/generic/test_linters.py
 F: tests/functional/pylintrc
 F: tests/functional/qemu_test/
 
+virtio-villain fault injection test
+M: Anatol Belski <anbelski@linux.microsoft.com>
+S: Maintained
+F: tests/functional/generic/test_virtio_villain.py
+F: tests/functional/virtio-villain
+
 Windows Hosted Continuous Integration
 M: Yonggang Luo <luoyonggang@gmail.com>
 S: Maintained
diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 60a427d175..963542f9b8 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -83,6 +83,33 @@ files around on disk by setting ``QEMU_TEST_KEEP_SCRATCH=1`` as an env
 variable.  Any preserved files will be deleted the next time the test is run
 without this variable set.
 
+The virtio-villain fault injection test
+---------------------------------------
+
+The ``virtio_villain`` test drives a guest side virtio fault injection
+harness against the QEMU under test. It is included as a git submodule
+under ``tests/functional/virtio-villain``. Initialize it before running
+the test::
+
+  $ git submodule update --init tests/functional/virtio-villain
+
+The harness boots one short lived guest per case. Each case violates a
+driver rule from the virtio spec and checks that the device model
+handles the bad input without crashing, hanging, or corrupting state.
+The test builds a static guest init and then runs the whole supported
+suite through the harness, failing if any case reports a failure.
+
+Building the guest init needs a static toolchain that targets the
+guest architecture. When the guest matches the host, musl-gcc or the
+host compiler is used. When it differs, a cross compiler such as
+``aarch64-linux-gnu-gcc`` is used. The test is skipped when no
+suitable kernel or compiler is available for the guest architecture.
+
+The test is part of the thorough suite for x86_64 and aarch64, so it
+runs with ``make check-functional-x86_64`` or on its own with::
+
+  $ meson test -C build --setup thorough func-x86_64-virtio_villain
+
 Logging
 -------
 
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index f0881bed16..28563655ae 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -18,6 +18,7 @@ test_aarch64_timeouts = {
   'virt' : 360,
   'virt_gpu' : 480,
   'virt_vbsa' : 240,
+  'virtio_villain' : 900,
 }
 
 tests_aarch64_system_quick = [
@@ -55,6 +56,7 @@ tests_aarch64_system_thorough = [
   'virt_aarch64_off',
   'virt_gpu',
   'virt_vbsa',
+  'virtio_villain',
   'xen',
   'xlnx_versal',
 ]
diff --git a/tests/functional/generic/test_virtio_villain.py b/tests/functional/generic/test_virtio_villain.py
new file mode 100755
index 0000000000..d4e656edc0
--- /dev/null
+++ b/tests/functional/generic/test_virtio_villain.py
@@ -0,0 +1,195 @@
+#!/usr/bin/env python3
+#
+# virtio-villain functional test
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This test drives the virtio-villain harness, a git submodule under
+# tests/functional/virtio-villain, against the QEMU under test. The
+# harness boots one short lived guest per case. Each case violates one
+# driver rule from the virtio spec and checks that the device model
+# handles it without crashing, hanging, or corrupting state.
+#
+# virtio-villain targets x86_64 and aarch64. The guest init is built
+# static with musl-gcc or the host compiler for a native guest, or with
+# an architecture cross compiler when the guest differs from the host.
+# The whole supported suite runs one guest per case and the test fails
+# if any case is FAIL, WEDGED, or XPASS. Cases needing host support that
+# is absent, such as vhost-vsock or a virtiofs daemon, are skipped by
+# --skip-unsupported.
+#
+# Run it directly with meson test -C <build> --setup thorough
+# func-<arch>-virtio_villain
+
+import ast
+import json
+import os
+import platform
+import re
+import shutil
+import subprocess
+import unittest
+from unittest import mock
+
+from qemu_test import Asset, QemuSystemTest, skipIfMissingCommands
+
+
+ASSET_KERNEL_X86_64 = Asset(
+    ('https://github.com/cloud-hypervisor/linux/releases/download/'
+     'ch-release-v6.16.9-20260508/vmlinux-x86_64'),
+    '9d3570b47d5abb069ca00edfbfcef4c68306a9c3d078a01f10082b258f1001b8')
+
+ASSET_KERNEL_AARCH64 = Asset(
+    ('https://github.com/cloud-hypervisor/linux/releases/download/'
+     'ch-release-v6.16.9-20260508/Image-arm64'),
+    '69d1b1235381ec50f1b45cf771a7dff4a9013d452833ab34682d6283e2114010')
+
+KERNELS = {
+    'x86_64': ASSET_KERNEL_X86_64,
+    'aarch64': ASSET_KERNEL_AARCH64,
+}
+
+
+def _native_compiler():
+    if shutil.which('musl-gcc'):
+        return 'musl-gcc'
+    build_root = os.environ.get('MESON_BUILD_ROOT')
+    if build_root:
+        cross = os.path.join(build_root, 'config-meson.cross')
+        try:
+            with open(cross) as f:
+                for line in f:
+                    if line.strip().startswith('c ='):
+                        val = ast.literal_eval(line.split('=', 1)[1].strip())
+                        return val[0] if isinstance(val, list) else val
+        except OSError:
+            pass
+    return 'cc'
+
+
+def _villain_compiler(arch):
+    if arch == platform.machine():
+        return _native_compiler()
+    for cc in (arch + '-linux-musl-gcc', arch + '-linux-gnu-gcc'):
+        if shutil.which(cc):
+            return cc
+    return None
+
+
+_ANSI_RE = re.compile(r'\x1b\[[0-9;?]*[ -/]*[@-~]')
+
+
+def _clean(text):
+    return _ANSI_RE.sub('', text.replace('\r', ''))
+
+
+class VirtioVillain(QemuSystemTest):
+
+    timeout = 900
+
+    @skipIfMissingCommands('make', 'strip', 'cpio', 'gzip')
+    def test_suite(self):
+        kernel = KERNELS.get(self.arch)
+        if kernel is None:
+            self.skipTest('no virtio-villain kernel for %s' % self.arch)
+        cc = _villain_compiler(self.arch)
+        if cc is None:
+            self.skipTest('no compiler to build the %s guest init'
+                          % self.arch)
+
+        villain_dir = os.path.join(os.path.dirname(__file__), '..',
+                                   'virtio-villain')
+        # The runner reads the initramfs from its own default target path.
+        subprocess.run(['make', '-C', villain_dir, 'initramfs',
+                        f'-j{os.cpu_count() or 1}',
+                        f'CC={cc}',
+                        'CFLAGS=-static -O2 -Wall -Wextra -Werror '
+                        '-Wno-unused-but-set-variable'],
+                       stdout=subprocess.DEVNULL, check=True)
+
+        report = self.scratch_file('villain-report.json')
+        runner = os.path.join(villain_dir, 'run')
+        result = subprocess.run(
+            [runner, '-m', self.qemu_bin,
+             '-k', kernel.fetch(),
+             '--skip-unsupported',
+             '-j', str(os.cpu_count() or 1),
+             '--format', 'json', '--output', report],
+            capture_output=True, text=True, check=False)
+
+        if not os.path.exists(report):
+            self.fail('virtio-villain runner produced no report:\n'
+                      + (result.stderr or result.stdout or '')[-2000:])
+
+        with open(report) as f:
+            data = json.load(f)
+        counts = data['counts']
+        self.log.info('virtio-villain: %d tests, %s', data['total'], counts)
+
+        bad = [t for t in data['tests']
+               if t['status'] in ('FAIL', 'WEDGED', 'XPASS')]
+
+        runlog = os.path.join(self.outputdir, 'villain-run.log')
+        with open(runlog, 'w') as f:
+            f.write(_clean(result.stdout or ''))
+            for t in bad:
+                f.write('\n===== %s %s (spec %s) %s =====\n'
+                        % (t['status'], t['name'], t.get('spec_section'),
+                           t.get('description')))
+                f.write(_clean(t.get('output') or ''))
+        self.log.info('virtio-villain full log: %s', runlog)
+
+        if bad:
+            detail = '\n  '.join(
+                '%s %s (spec %s) %s'
+                % (t['status'], t['name'], t.get('spec_section'),
+                   t.get('description'))
+                for t in bad)
+            self.fail('virtio-villain reported %d failing case(s):\n  %s\n'
+                      'full guest output in %s'
+                      % (len(bad), detail, runlog))
+
+
+class VillainHelpers(unittest.TestCase):
+
+    def test_kernels_cover_both_arches(self):
+        self.assertIn('x86_64', KERNELS)
+        self.assertIn('aarch64', KERNELS)
+
+    def test_native_prefers_musl(self):
+        with mock.patch.object(shutil, 'which',
+                               side_effect=lambda c: c == 'musl-gcc'):
+            self.assertEqual(_native_compiler(), 'musl-gcc')
+
+    def test_native_falls_back_to_cc(self):
+        with mock.patch.object(shutil, 'which', return_value=None), \
+             mock.patch.dict(os.environ, {}, clear=True):
+            self.assertEqual(_native_compiler(), 'cc')
+
+    def test_native_arch_uses_native(self):
+        with mock.patch.object(platform, 'machine', return_value='x86_64'), \
+             mock.patch.object(shutil, 'which',
+                               side_effect=lambda c: c == 'musl-gcc'):
+            self.assertEqual(_villain_compiler('x86_64'), 'musl-gcc')
+
+    def test_foreign_arch_uses_cross(self):
+        def which(cmd):
+            if cmd == 'aarch64-linux-gnu-gcc':
+                return '/usr/bin/' + cmd
+            return None
+        with mock.patch.object(platform, 'machine', return_value='x86_64'), \
+             mock.patch.object(shutil, 'which', side_effect=which):
+            self.assertEqual(_villain_compiler('aarch64'),
+                             'aarch64-linux-gnu-gcc')
+
+    def test_foreign_arch_without_cross_is_none(self):
+        with mock.patch.object(platform, 'machine', return_value='x86_64'), \
+             mock.patch.object(shutil, 'which', return_value=None):
+            self.assertIsNone(_villain_compiler('aarch64'))
+
+    def test_clean_strips_cr_and_escapes(self):
+        self.assertEqual(_clean('a\r\n\x1b[32mok\x1b[0m\r'), 'a\nok')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/virtio-villain b/tests/functional/virtio-villain
new file mode 160000
index 0000000000..59d02ac357
--- /dev/null
+++ b/tests/functional/virtio-villain
@@ -0,0 +1 @@
+Subproject commit 59d02ac35766732247670ae608177a6fd7181d7f
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 0353b2af8e..2a7c708ddb 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -7,6 +7,7 @@ test_x86_64_timeouts = {
   'netdev_ethtool' : 180,
   'replay' : 480,
   'virtio_balloon': 120,
+  'virtio_villain' : 900,
 }
 
 tests_x86_64_system_quick = [
@@ -50,5 +51,6 @@ tests_x86_64_system_thorough = [
   'vhost_user_bridge',
   'virtio_balloon',
   'virtio_gpu',
+  'virtio_villain',
   'rebuild_vmfd',
 ]
-- 
2.55.0


