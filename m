Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA0BC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqH6-0008Av-9e; Tue, 30 Jul 2024 13:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqGp-0007dG-RZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqGl-0002JM-8H
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZvMe+yjco9CNU9OSKya4TH5m9fSO3vkToAnQTBinzc=;
 b=g4HoaSolakF/tazbgsOGMBuzYMUVgFbwlcrjQ35VYN0rhsCQHt4kkWse100zvEZ9tkVcci
 bBDEEmOQtQazbu+tXQMbGZ8y9pGD5FPfeb+Kt1lAMBqTnISK6z428FY0rVbxhDy1jAkF63
 f6a5f8Cr4jyGuzFjHNQ7LFV61VLBiGM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-EfExVsU1P1ufxagvOwYCQg-1; Tue,
 30 Jul 2024 13:04:02 -0400
X-MC-Unique: EfExVsU1P1ufxagvOwYCQg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DF5F1955D4E; Tue, 30 Jul 2024 17:04:01 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F2A13000197; Tue, 30 Jul 2024 17:03:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 02/24] tests/functional: Add base classes for the upcoming
 pytest-based tests
Date: Tue, 30 Jul 2024 18:03:22 +0100
Message-ID: <20240730170347.4103919-3-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The file is mostly a copy of the tests/avocado/avocado_qemu/__init__.py
file with some adjustments to get rid of the Avocado dependencies (i.e.
we also have to drop the LinuxSSHMixIn and LinuxTest for now).

The emulator binary and build directory are now passed via
environment variables that will be set via meson.build later.

Signed-off-by: Thomas Huth <thuth@redhat.com>
[DB: split __init__.py into multiple files]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/__init__.py |  13 ++
 tests/functional/qemu_test/cmd.py      | 171 +++++++++++++++++++++++++
 tests/functional/qemu_test/config.py   |  36 ++++++
 tests/functional/qemu_test/testcase.py | 154 ++++++++++++++++++++++
 4 files changed, 374 insertions(+)
 create mode 100644 tests/functional/qemu_test/__init__.py
 create mode 100644 tests/functional/qemu_test/cmd.py
 create mode 100644 tests/functional/qemu_test/config.py
 create mode 100644 tests/functional/qemu_test/testcase.py

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
new file mode 100644
index 0000000000..2f1e0bc70d
--- /dev/null
+++ b/tests/functional/qemu_test/__init__.py
@@ -0,0 +1,13 @@
+# Test class and utilities for functional tests
+#
+# Copyright 2024 Red Hat, Inc.
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+
+from .config import BUILD_DIR
+from .cmd import has_cmd, has_cmds, run_cmd, is_readable_executable_file, \
+    interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
+    exec_command, exec_command_and_wait_for_pattern
+from .testcase import QemuSystemTest, QemuBaseTest
diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
new file mode 100644
index 0000000000..67e860e2c8
--- /dev/null
+++ b/tests/functional/qemu_test/cmd.py
@@ -0,0 +1,171 @@
+# Test class and utilities for functional tests
+#
+# Copyright 2018, 2024 Red Hat, Inc.
+#
+# Original Author (Avocado-based tests):
+#  Cleber Rosa <crosa@redhat.com>
+#
+# Adaption for standalone version:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import logging
+import os
+import os.path
+import subprocess
+
+
+def has_cmd(name, args=None):
+    """
+    This function is for use in a @skipUnless decorator, e.g.:
+
+        @skipUnless(*has_cmd('sudo -n', ('sudo', '-n', 'true')))
+        def test_something_that_needs_sudo(self):
+            ...
+    """
+
+    if args is None:
+        args = ('which', name)
+
+    try:
+        _, stderr, exitcode = run_cmd(args)
+    except Exception as e:
+        exitcode = -1
+        stderr = str(e)
+
+    if exitcode != 0:
+        cmd_line = ' '.join(args)
+        err = f'{name} required, but "{cmd_line}" failed: {stderr.strip()}'
+        return (False, err)
+    else:
+        return (True, '')
+
+def has_cmds(*cmds):
+    """
+    This function is for use in a @skipUnless decorator and
+    allows checking for the availability of multiple commands, e.g.:
+
+        @skipUnless(*has_cmds(('cmd1', ('cmd1', '--some-parameter')),
+                              'cmd2', 'cmd3'))
+        def test_something_that_needs_cmd1_and_cmd2(self):
+            ...
+    """
+
+    for cmd in cmds:
+        if isinstance(cmd, str):
+            cmd = (cmd,)
+
+        ok, errstr = has_cmd(*cmd)
+        if not ok:
+            return (False, errstr)
+
+    return (True, '')
+
+def run_cmd(args):
+    subp = subprocess.Popen(args,
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.PIPE,
+                            universal_newlines=True)
+    stdout, stderr = subp.communicate()
+    ret = subp.returncode
+
+    return (stdout, stderr, ret)
+
+def is_readable_executable_file(path):
+    return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
+
+def _console_interaction(test, success_message, failure_message,
+                         send_string, keep_sending=False, vm=None):
+    assert not keep_sending or send_string
+    if vm is None:
+        vm = test.vm
+    console = vm.console_file
+    console_logger = logging.getLogger('console')
+    while True:
+        if send_string:
+            vm.console_socket.sendall(send_string.encode())
+            if not keep_sending:
+                send_string = None # send only once
+        try:
+            msg = console.readline().decode().strip()
+        except UnicodeDecodeError:
+            msg = None
+        if not msg:
+            continue
+        console_logger.debug(msg)
+        if success_message is None or success_message in msg:
+            break
+        if failure_message and failure_message in msg:
+            console.close()
+            fail = 'Failure message found in console: "%s". Expected: "%s"' % \
+                    (failure_message, success_message)
+            test.fail(fail)
+
+def interrupt_interactive_console_until_pattern(test, success_message,
+                                                failure_message=None,
+                                                interrupt_string='\r'):
+    """
+    Keep sending a string to interrupt a console prompt, while logging the
+    console output. Typical use case is to break a boot loader prompt, such:
+
+        Press a key within 5 seconds to interrupt boot process.
+        5
+        4
+        3
+        2
+        1
+        Booting default image...
+
+    :param test: a  test containing a VM that will have its console
+                 read and probed for a success or failure message
+    :type test: :class:`qemu_test.QemuSystemTest`
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    :param interrupt_string: a string to send to the console before trying
+                             to read a new line
+    """
+    _console_interaction(test, success_message, failure_message,
+                         interrupt_string, True)
+
+def wait_for_console_pattern(test, success_message, failure_message=None,
+                             vm=None):
+    """
+    Waits for messages to appear on the console, while logging the content
+
+    :param test: a test containing a VM that will have its console
+                 read and probed for a success or failure message
+    :type test: :class:`qemu_test.QemuSystemTest`
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    """
+    _console_interaction(test, success_message, failure_message, None, vm=vm)
+
+def exec_command(test, command):
+    """
+    Send a command to a console (appending CRLF characters), while logging
+    the content.
+
+    :param test: a test containing a VM.
+    :type test: :class:`qemu_test.QemuSystemTest`
+    :param command: the command to send
+    :type command: str
+    """
+    _console_interaction(test, None, None, command + '\r')
+
+def exec_command_and_wait_for_pattern(test, command,
+                                      success_message, failure_message=None):
+    """
+    Send a command to a console (appending CRLF characters), then wait
+    for success_message to appear on the console, while logging the.
+    content. Mark the test as failed if failure_message is found instead.
+
+    :param test: a test containing a VM that will have its console
+                 read and probed for a success or failure message
+    :type test: :class:`qemu_test.QemuSystemTest`
+    :param command: the command to send
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    """
+    _console_interaction(test, success_message, failure_message, command + '\r')
diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
new file mode 100644
index 0000000000..edd75b7fd0
--- /dev/null
+++ b/tests/functional/qemu_test/config.py
@@ -0,0 +1,36 @@
+# Test class and utilities for functional tests
+#
+# Copyright 2018, 2024 Red Hat, Inc.
+#
+# Original Author (Avocado-based tests):
+#  Cleber Rosa <crosa@redhat.com>
+#
+# Adaption for standalone version:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+from pathlib import Path
+
+
+def _source_dir():
+    # Determine top-level directory of the QEMU sources
+    return Path(__file__).parent.parent.parent.parent
+
+def _build_dir():
+    root = os.getenv('QEMU_BUILD_ROOT')
+    if root is not None:
+        return Path(root)
+    # Makefile.mtest only exists in build dir, so if it is available, use CWD
+    if os.path.exists('Makefile.mtest'):
+        return Path(os.getcwd())
+
+    root = os.path.join(_source_dir(), 'build')
+    if os.path.exists(root):
+        return Path(root)
+
+    raise Exception("Cannot identify build dir, set QEMU_BUILD_ROOT")
+
+BUILD_DIR = _build_dir()
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
new file mode 100644
index 0000000000..82cc1d454f
--- /dev/null
+++ b/tests/functional/qemu_test/testcase.py
@@ -0,0 +1,154 @@
+# Test class and utilities for functional tests
+#
+# Copyright 2018, 2024 Red Hat, Inc.
+#
+# Original Author (Avocado-based tests):
+#  Cleber Rosa <crosa@redhat.com>
+#
+# Adaption for standalone version:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import logging
+import os
+import pycotap
+import sys
+import unittest
+import uuid
+
+from qemu.machine import QEMUMachine
+from qemu.utils import kvm_available, tcg_available
+
+from .cmd import run_cmd
+from .config import BUILD_DIR
+
+
+class QemuBaseTest(unittest.TestCase):
+
+    qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
+    arch = None
+
+    workdir = None
+    log = logging.getLogger('qemu-test')
+
+    def setUp(self, bin_prefix):
+        self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
+        self.arch = self.qemu_bin.split('-')[-1]
+
+        self.workdir = os.path.join(BUILD_DIR, 'tests/functional', self.arch,
+                                    self.id())
+        if not os.path.exists(self.workdir):
+            os.makedirs(self.workdir)
+
+    def main():
+        tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
+                                   test_output_log = pycotap.LogMode.LogToError)
+        path = os.path.basename(sys.argv[0])[:-3]
+        unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])
+
+
+class QemuSystemTest(QemuBaseTest):
+    """Facilitates system emulation tests."""
+
+    cpu = None
+    machine = None
+    _machinehelp = None
+
+    def setUp(self):
+        self._vms = {}
+
+        super().setUp('qemu-system-')
+
+    def set_machine(self, machinename):
+        # TODO: We should use QMP to get the list of available machines
+        if not self._machinehelp:
+            self._machinehelp = run_cmd([self.qemu_bin, '-M', 'help'])[0];
+        if self._machinehelp.find(machinename) < 0:
+            self.skipTest('no support for machine ' + machinename)
+        self.machine = machinename
+
+    def require_accelerator(self, accelerator):
+        """
+        Requires an accelerator to be available for the test to continue
+
+        It takes into account the currently set qemu binary.
+
+        If the check fails, the test is canceled.  If the check itself
+        for the given accelerator is not available, the test is also
+        canceled.
+
+        :param accelerator: name of the accelerator, such as "kvm" or "tcg"
+        :type accelerator: str
+        """
+        checker = {'tcg': tcg_available,
+                   'kvm': kvm_available}.get(accelerator)
+        if checker is None:
+            self.skipTest("Don't know how to check for the presence "
+                          "of accelerator %s" % accelerator)
+        if not checker(qemu_bin=self.qemu_bin):
+            self.skipTest("%s accelerator does not seem to be "
+                          "available" % accelerator)
+
+    def require_netdev(self, netdevname):
+        netdevhelp = run_cmd([self.qemu_bin,
+                             '-M', 'none', '-netdev', 'help'])[0];
+        if netdevhelp.find('\n' + netdevname + '\n') < 0:
+            self.skipTest('no support for " + netdevname + " networking')
+
+    def require_device(self, devicename):
+        devhelp = run_cmd([self.qemu_bin,
+                           '-M', 'none', '-device', 'help'])[0];
+        if devhelp.find(devicename) < 0:
+            self.skipTest('no support for device ' + devicename)
+
+    def _new_vm(self, name, *args):
+        vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir)
+        self.log.debug('QEMUMachine "%s" created', name)
+        self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
+        self.log.debug('QEMUMachine "%s" log_dir: %s', name, vm.log_dir)
+        if args:
+            vm.add_args(*args)
+        return vm
+
+    @property
+    def vm(self):
+        return self.get_vm(name='default')
+
+    def get_vm(self, *args, name=None):
+        if not name:
+            name = str(uuid.uuid4())
+        if self._vms.get(name) is None:
+            self._vms[name] = self._new_vm(name, *args)
+            if self.cpu is not None:
+                self._vms[name].add_args('-cpu', self.cpu)
+            if self.machine is not None:
+                self._vms[name].set_machine(self.machine)
+        return self._vms[name]
+
+    def set_vm_arg(self, arg, value):
+        """
+        Set an argument to list of extra arguments to be given to the QEMU
+        binary. If the argument already exists then its value is replaced.
+
+        :param arg: the QEMU argument, such as "-cpu" in "-cpu host"
+        :type arg: str
+        :param value: the argument value, such as "host" in "-cpu host"
+        :type value: str
+        """
+        if not arg or not value:
+            return
+        if arg not in self.vm.args:
+            self.vm.args.extend([arg, value])
+        else:
+            idx = self.vm.args.index(arg) + 1
+            if idx < len(self.vm.args):
+                self.vm.args[idx] = value
+            else:
+                self.vm.args.append(value)
+
+    def tearDown(self):
+        for vm in self._vms.values():
+            vm.shutdown()
+        super().tearDown()
-- 
2.45.2


