Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02A4C3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSI1-00026H-ON; Mon, 29 Jul 2024 11:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHs-0001eI-0W
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHn-0008GD-Kx
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-428035c0bb2so11104735e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266862; x=1722871662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBqoPLgA3/9ZofvfJWZLzCibdmlqkba0mV85fMinUUM=;
 b=NaVbAlV8HxrobbpIefSjgXnrcUi9fAD+gRb9ms6ED+AAHPLC7UpXdlKYJ6CgZqtzau
 lCCRxIpHKunZOJurmjjAliLLcChow9UjxV1+CiX8oLYwCmdPjgpsZMLhQRPD+pepVfO5
 MFBEQBQKY7Dblmk8TMLE850L7ZEIfk8+jahdscgMsUxr8LZRTOD2sUfuu8jvBbIjh3ip
 62bA4CwY4I7/J72TR5abRH6+KW7MCZQHSXnSrt4qLYj1CYZpPVXi2cnn48PejN2t2F4H
 QefIgwqMXveJ3S+ZLifpbdvOv/j4ernqgbJOuxyIuCcCv42LQiHza1ONe9vbHWW/vyfh
 p5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266862; x=1722871662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBqoPLgA3/9ZofvfJWZLzCibdmlqkba0mV85fMinUUM=;
 b=uEsX9OEihmem6C80GPjo3rjnRtEu7EP+mbCBV1T1A5S/SmtKqq45+4npGy9BwPxf6F
 VghtAk5ZaOvIGbPEJaKXHCyCHt5fXt74yENrnrLnNvy0Wg2nP/c1MoRaKjANMkB2vpJp
 b0FAC494c8lSwnXcMpefUM2m5MpYJaRCpxcwAo6+bgrhJNzEXTSFcsn+GQS0/068cg8A
 99Img+lDDbYECoBmly3eYi+RE9TRMgKUVCJod9V7cTRbIi4IZwn12yyQBooXw0HQc1sn
 1GQOEtFwvtjosjO1a/ckj1w4ISxfYNFFxbi020ApKhpl0TWtIE7SxdgSFLJs37w6PuRl
 tV1g==
X-Gm-Message-State: AOJu0YwecdaDf8Qwxk4AQ9dfzNdTb4M2gVf06SRyEYHqVBnvZobe0QtS
 M9hWS12aI/1pwPG6E9EdGaJgi9T8R4fuC0s8IOcNOGU4CnVIiJTPEiumMLCUzSIkPmPjK5fcNqT
 j
X-Google-Smtp-Source: AGHT+IHn86wfaegvqLnD9wAeQUtx58ySzifUNpxtIHWtP5P4MC/Sr0S9DkiDdbwpg2j3ernvMXJsdA==
X-Received: by 2002:a05:600c:1f96:b0:426:6252:61d9 with SMTP id
 5b1f17b1804b1-42811fcb0camr49031295e9.11.1722266861716; 
 Mon, 29 Jul 2024 08:27:41 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42805730bdbsm183391265e9.5.2024.07.29.08.27.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:27:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/14] tests/functional: Add base classes for the upcoming
 pytest-based tests
Date: Mon, 29 Jul 2024 17:27:04 +0200
Message-ID: <20240729152714.10225-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240724175248.1389201-3-thuth@redhat.com>
[PMD: Updated MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                            |   1 +
 tests/functional/qemu_test/__init__.py | 328 +++++++++++++++++++++++++
 2 files changed, 329 insertions(+)
 create mode 100644 tests/functional/qemu_test/__init__.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 98eddf7ae1..aa03a40d01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4127,6 +4127,7 @@ F: .travis.yml
 F: docs/devel/ci*
 F: scripts/ci/
 F: tests/docker/
+F: tests/functional/
 F: tests/vm/
 F: tests/lcitool/
 F: tests/avocado/tuxrun_baselines.py
diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
new file mode 100644
index 0000000000..fc98222c52
--- /dev/null
+++ b/tests/functional/qemu_test/__init__.py
@@ -0,0 +1,328 @@
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
+import shutil
+import subprocess
+import sys
+import tempfile
+import time
+import uuid
+import unittest
+
+from pathlib import Path
+from qemu.machine import QEMUMachine
+from qemu.utils import kvm_available, tcg_available
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


