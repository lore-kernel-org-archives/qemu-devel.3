Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035D1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsPB-0002H9-4l; Thu, 11 Jul 2024 07:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsP9-0002By-Mz
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsP6-00046k-AB
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720698963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erdYB82SWsESpyIDAkDTJBDapAsUIM7zIcvc71btW3U=;
 b=R4x9K/bB6grztvZJad2kBHvYkphtr1HwUmElvkHpiy6+yGfCaMOaFtg/MfZSKIEpFcwSy+
 D1rzjsdVcPmQxgnCj4wsOGTFF2qgYHmM0MKHVEIr6qDRJjRcXHJD4MOQ3aw4kfUunyhS3N
 Lanp/1bRS+gi/qebTMu2BpEwkXW1i+s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-Z4fZMx5wMqGIwaEd7ThW8A-1; Thu,
 11 Jul 2024 07:56:00 -0400
X-MC-Unique: Z4fZMx5wMqGIwaEd7ThW8A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 924FB1935843; Thu, 11 Jul 2024 11:55:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.118])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C1251954219; Thu, 11 Jul 2024 11:55:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 1/8] tests/pytest: Add base classes for the upcoming
 pytest-based tests
Date: Thu, 11 Jul 2024 13:55:39 +0200
Message-ID: <20240711115546.40859-2-thuth@redhat.com>
In-Reply-To: <20240711115546.40859-1-thuth@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The file is a copy of the tests/avocado/avocado_qemu/__init__.py file
with some adjustments to get rid of the Avocado dependencies (i.e.
we also have to drop the LinuxSSHMixIn and LinuxTest for now).

The emulator binary, source and build directory are now passed via
environment variables that will be set via meson.build later.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/pytest/qemu_pytest/__init__.py | 344 +++++++++++++++++++++++++++
 1 file changed, 344 insertions(+)
 create mode 100644 tests/pytest/qemu_pytest/__init__.py

diff --git a/tests/pytest/qemu_pytest/__init__.py b/tests/pytest/qemu_pytest/__init__.py
new file mode 100644
index 0000000000..e3ed32e3de
--- /dev/null
+++ b/tests/pytest/qemu_pytest/__init__.py
@@ -0,0 +1,344 @@
+# Test class and utilities for functional tests
+#
+# Copyright 2018, 2024 Red Hat, Inc.
+#
+# Original Author (Avocado-based tests):
+#  Cleber Rosa <crosa@redhat.com>
+#
+# Adaption for pytest based version:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import logging
+import os
+import shutil
+import subprocess
+import sys
+import tempfile
+import time
+import uuid
+import unittest
+
+from qemu.machine import QEMUMachine
+from qemu.utils import (get_info_usernet_hostfwd_port, kvm_available,
+                        tcg_available)
+
+BUILD_DIR = os.getenv('PYTEST_BUILD_ROOT')
+SOURCE_DIR = os.getenv('PYTEST_SOURCE_ROOT')
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
+    :type test: :class:`qemu_pytest.QemuSystemTest`
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
+    :type test: :class:`qemu_pytest.QemuSystemTest`
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
+    :type test: :class:`qemu_pytest.QemuSystemTest`
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
+    :type test: :class:`qemu_pytest.QemuSystemTest`
+    :param command: the command to send
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    """
+    _console_interaction(test, success_message, failure_message, command + '\r')
+
+class QemuBaseTest(unittest.TestCase):
+
+    # default timeout for all tests, can be overridden
+    timeout = 120
+
+    qemu_bin = os.getenv('PYTEST_QEMU_BINARY')
+
+    workdir = os.path.join(BUILD_DIR, 'tests/pytest')
+    logdir = os.path.join(BUILD_DIR, 'tests/pytest')
+
+    cpu = None
+    machine = None
+
+    log = logging.getLogger('qemu-pytest')
+
+    def setUp(self, bin_prefix):
+        self.assertIsNotNone(BUILD_DIR, 'PYTEST_BUILD_ROOT must be set')
+        self.assertIsNotNone(SOURCE_DIR,'PYTEST_SOURCE_ROOT must be set')
+        self.assertIsNotNone(self.qemu_bin, 'PYTEST_QEMU_BINARY must be set')
+
+    def fetch_asset(self, name,
+                    asset_hash, algorithm=None,
+                    locations=None, expire=None,
+                    find_only=False, cancel_on_missing=True):
+        return super().fetch_asset(name,
+                        asset_hash=asset_hash,
+                        algorithm=algorithm,
+                        locations=locations,
+                        expire=expire,
+                        find_only=find_only,
+                        cancel_on_missing=cancel_on_missing)
+
+
+class QemuSystemTest(QemuBaseTest):
+    """Facilitates system emulation tests."""
+
+    def setUp(self):
+        self._vms = {}
+
+        super().setUp('qemu-system-')
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
+            self.cancel("Don't know how to check for the presence "
+                        "of accelerator %s" % accelerator)
+        if not checker(qemu_bin=self.qemu_bin):
+            self.cancel("%s accelerator does not seem to be "
+                        "available" % accelerator)
+
+    def require_netdev(self, netdevname):
+        netdevhelp = run_cmd([self.qemu_bin,
+                             '-M', 'none', '-netdev', 'help'])[0];
+        if netdevhelp.find('\n' + netdevname + '\n') < 0:
+            self.cancel('no support for user networking')
+
+    def require_multiprocess(self):
+        """
+        Test for the presence of the x-pci-proxy-dev which is required
+        to support multiprocess.
+        """
+        devhelp = run_cmd([self.qemu_bin,
+                           '-M', 'none', '-device', 'help'])[0];
+        if devhelp.find('x-pci-proxy-dev') < 0:
+            self.cancel('no support for multiprocess device emulation')
+
+    def _new_vm(self, name, *args):
+        self._sd = tempfile.TemporaryDirectory(prefix="qemu_")
+        vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir,
+                         log_dir=self.logdir)
+        self.log.debug('QEMUMachine "%s" created', name)
+        self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
+        self.log.debug('QEMUMachine "%s" log_dir: %s', name, vm.log_dir)
+        if args:
+            vm.add_args(*args)
+        return vm
+
+    def get_qemu_img(self):
+        self.log.debug('Looking for and selecting a qemu-img binary')
+
+        # If qemu-img has been built, use it, otherwise the system wide one
+        # will be used.
+        qemu_img = os.path.join(BUILD_DIR, 'qemu-img')
+        if not os.path.exists(qemu_img):
+            qemu_img = find_command('qemu-img', False)
+        if qemu_img is False:
+            self.cancel('Could not find "qemu-img"')
+
+        return qemu_img
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
+        self._sd = None
+        super().tearDown()
+
+
+class QemuUserTest(QemuBaseTest):
+    """Facilitates user-mode emulation tests."""
+
+    def setUp(self):
+        self._ldpath = []
+        super().setUp('qemu-')
+
+    def add_ldpath(self, ldpath):
+        self._ldpath.append(os.path.abspath(ldpath))
+
+    def run(self, bin_path, args=[]):
+        qemu_args = " ".join(["-L %s" % ldpath for ldpath in self._ldpath])
+        bin_args = " ".join(args)
+        return process.run("%s %s %s %s" % (self.qemu_bin, qemu_args,
+                                            bin_path, bin_args))
-- 
2.45.2


