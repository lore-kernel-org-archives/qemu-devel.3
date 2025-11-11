Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01284CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlVs-0000ef-H7; Tue, 11 Nov 2025 05:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIlVr-0000cq-8F
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:22:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIlVo-0007YI-Fk
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762856527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdA/0YurBoYCyU7c6uV4yb0KbzFh7JxeG3Sw0XPSv+Q=;
 b=MQ2j3mswrtsqCYUiiGVoWaSwGsePr7pihccwhYJtO6jNuoG1iJt9fXASuXeh+sNumCK++t
 9ULhMp5bHgjHkT07IWUWXYcWO9HZuRaCJPSWXX0DodGaLWQ+hp4D1jLnkvnfQpFX9xhPmL
 mUPXdnj1VZkkmXs0NETxrRz9m+76glQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-oDJEeTONO1upspQL3aF3DQ-1; Tue,
 11 Nov 2025 05:22:03 -0500
X-MC-Unique: oDJEeTONO1upspQL3aF3DQ-1
X-Mimecast-MFC-AGG-ID: oDJEeTONO1upspQL3aF3DQ_1762856523
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A4F4193E8AC; Tue, 11 Nov 2025 10:22:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.97])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCBAA30044E0; Tue, 11 Nov 2025 10:22:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/4] tests/functional: Fix problems in testcase.py reported by
 pylint
Date: Tue, 11 Nov 2025 11:21:55 +0100
Message-ID: <20251111102158.92091-2-thuth@redhat.com>
In-Reply-To: <20251111102158.92091-1-thuth@redhat.com>
References: <20251111102158.92091-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

- put 3rd party "import pycotap" after the standard imports
- "help" is a built-in function in Python, don't use it as a variable name
- put the doc strings in the right locations (after the "def" line)
- use isinstance() instead of checking via type()

Message-Id: <a3413bbd-e98c-4267-81c7-aa42aeda8a09@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 243 +++++++++++++------------
 1 file changed, 122 insertions(+), 121 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 1d773dd697d..58f27401004 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -14,7 +14,6 @@
 import logging
 import os
 from pathlib import Path
-import pycotap
 import shutil
 from subprocess import run
 import sys
@@ -23,6 +22,8 @@
 import unittest
 import uuid
 
+import pycotap
+
 from qemu.machine import QEMUMachine
 from qemu.utils import hvf_available, kvm_available, tcg_available
 
@@ -34,50 +35,50 @@
 
 class QemuBaseTest(unittest.TestCase):
 
-    '''
-    @params compressed: filename, Asset, or file-like object to uncompress
-    @params format: optional compression format (gzip, lzma)
+    def uncompress(self, compressed, format=None):
+        '''
+        @params compressed: filename, Asset, or file-like object to uncompress
+        @params format: optional compression format (gzip, lzma)
 
-    Uncompresses @compressed into the scratch directory.
+        Uncompresses @compressed into the scratch directory.
 
-    If @format is None, heuristics will be applied to guess the format
-    from the filename or Asset URL. @format must be non-None if @uncompressed
-    is a file-like object.
+        If @format is None, heuristics will be applied to guess the
+        format from the filename or Asset URL. @format must be non-None
+        if @uncompressed is a file-like object.
 
-    Returns the fully qualified path to the uncompressed file
-    '''
-    def uncompress(self, compressed, format=None):
+        Returns the fully qualified path to the uncompressed file
+        '''
         self.log.debug(f"Uncompress {compressed} format={format}")
-        if type(compressed) == Asset:
+        if isinstance(compressed, Asset):
             compressed.fetch()
 
-        (name, ext) = os.path.splitext(str(compressed))
+        (name, _ext) = os.path.splitext(str(compressed))
         uncompressed = self.scratch_file(os.path.basename(name))
 
         uncompress(compressed, uncompressed, format)
 
         return uncompressed
 
-    '''
-    @params archive: filename, Asset, or file-like object to extract
-    @params format: optional archive format (tar, zip, deb, cpio)
-    @params sub_dir: optional sub-directory to extract into
-    @params member: optional member file to limit extraction to
-
-    Extracts @archive into the scratch directory, or a directory beneath
-    named by @sub_dir. All files are extracted unless @member specifies
-    a limit.
-
-    If @format is None, heuristics will be applied to guess the format
-    from the filename or Asset URL. @format must be non-None if @archive
-    is a file-like object.
-
-    If @member is non-None, returns the fully qualified path to @member
-    '''
     def archive_extract(self, archive, format=None, sub_dir=None, member=None):
+        '''
+        @params archive: filename, Asset, or file-like object to extract
+        @params format: optional archive format (tar, zip, deb, cpio)
+        @params sub_dir: optional sub-directory to extract into
+        @params member: optional member file to limit extraction to
+
+        Extracts @archive into the scratch directory, or a directory beneath
+        named by @sub_dir. All files are extracted unless @member specifies
+        a limit.
+
+        If @format is None, heuristics will be applied to guess the
+        format from the filename or Asset URL. @format must be non-None
+        if @archive is a file-like object.
+
+        If @member is non-None, returns the fully qualified path to @member
+        '''
         self.log.debug(f"Extract {archive} format={format}" +
                        f"sub_dir={sub_dir} member={member}")
-        if type(archive) == Asset:
+        if isinstance(archive, Asset):
             archive.fetch()
         if sub_dir is None:
             archive_extract(archive, self.scratch_file(), format, member)
@@ -89,108 +90,108 @@ def archive_extract(self, archive, format=None, sub_dir=None, member=None):
             return self.scratch_file(member)
         return None
 
-    '''
-    Create a temporary directory suitable for storing UNIX
-    socket paths.
-
-    Returns: a tempfile.TemporaryDirectory instance
-    '''
     def socket_dir(self):
+        '''
+        Create a temporary directory suitable for storing UNIX
+        socket paths.
+
+        Returns: a tempfile.TemporaryDirectory instance
+        '''
         if self.socketdir is None:
             self.socketdir = tempfile.TemporaryDirectory(
                 prefix="qemu_func_test_sock_")
         return self.socketdir
 
-    '''
-    @params args list of zero or more subdirectories or file
-
-    Construct a path for accessing a data file located
-    relative to the source directory that is the root for
-    functional tests.
-
-    @args may be an empty list to reference the root dir
-    itself, may be a single element to reference a file in
-    the root directory, or may be multiple elements to
-    reference a file nested below. The path components
-    will be joined using the platform appropriate path
-    separator.
-
-    Returns: string representing a file path
-    '''
     def data_file(self, *args):
+        '''
+        @params args list of zero or more subdirectories or file
+
+        Construct a path for accessing a data file located
+        relative to the source directory that is the root for
+        functional tests.
+
+        @args may be an empty list to reference the root dir
+        itself, may be a single element to reference a file in
+        the root directory, or may be multiple elements to
+        reference a file nested below. The path components
+        will be joined using the platform appropriate path
+        separator.
+
+        Returns: string representing a file path
+        '''
         return str(Path(Path(__file__).parent.parent, *args))
 
-    '''
-    @params args list of zero or more subdirectories or file
-
-    Construct a path for accessing a data file located
-    relative to the build directory root.
-
-    @args may be an empty list to reference the build dir
-    itself, may be a single element to reference a file in
-    the build directory, or may be multiple elements to
-    reference a file nested below. The path components
-    will be joined using the platform appropriate path
-    separator.
-
-    Returns: string representing a file path
-    '''
     def build_file(self, *args):
-        return str(Path(BUILD_DIR, *args))
+        '''
+        @params args list of zero or more subdirectories or file
 
-    '''
-    @params args list of zero or more subdirectories or file
+        Construct a path for accessing a data file located
+        relative to the build directory root.
 
-    Construct a path for accessing/creating a scratch file
-    located relative to a temporary directory dedicated to
-    this test case. The directory and its contents will be
-    purged upon completion of the test.
+        @args may be an empty list to reference the build dir
+        itself, may be a single element to reference a file in
+        the build directory, or may be multiple elements to
+        reference a file nested below. The path components
+        will be joined using the platform appropriate path
+        separator.
 
-    @args may be an empty list to reference the scratch dir
-    itself, may be a single element to reference a file in
-    the scratch directory, or may be multiple elements to
-    reference a file nested below. The path components
-    will be joined using the platform appropriate path
-    separator.
+        Returns: string representing a file path
+        '''
+        return str(Path(BUILD_DIR, *args))
 
-    Returns: string representing a file path
-    '''
     def scratch_file(self, *args):
+        '''
+        @params args list of zero or more subdirectories or file
+
+        Construct a path for accessing/creating a scratch file
+        located relative to a temporary directory dedicated to
+        this test case. The directory and its contents will be
+        purged upon completion of the test.
+
+        @args may be an empty list to reference the scratch dir
+        itself, may be a single element to reference a file in
+        the scratch directory, or may be multiple elements to
+        reference a file nested below. The path components
+        will be joined using the platform appropriate path
+        separator.
+
+        Returns: string representing a file path
+        '''
         return str(Path(self.workdir, *args))
 
-    '''
-    @params args list of zero or more subdirectories or file
-
-    Construct a path for accessing/creating a log file
-    located relative to a temporary directory dedicated to
-    this test case. The directory and its log files will be
-    preserved upon completion of the test.
-
-    @args may be an empty list to reference the log dir
-    itself, may be a single element to reference a file in
-    the log directory, or may be multiple elements to
-    reference a file nested below. The path components
-    will be joined using the platform appropriate path
-    separator.
-
-    Returns: string representing a file path
-    '''
     def log_file(self, *args):
+        '''
+        @params args list of zero or more subdirectories or file
+
+        Construct a path for accessing/creating a log file
+        located relative to a temporary directory dedicated to
+        this test case. The directory and its log files will be
+        preserved upon completion of the test.
+
+        @args may be an empty list to reference the log dir
+        itself, may be a single element to reference a file in
+        the log directory, or may be multiple elements to
+        reference a file nested below. The path components
+        will be joined using the platform appropriate path
+        separator.
+
+        Returns: string representing a file path
+        '''
         return str(Path(self.outputdir, *args))
 
-    '''
-    @params plugin name
-
-    Return the full path to the plugin taking into account any host OS
-    specific suffixes.
-    '''
     def plugin_file(self, plugin_name):
+        '''
+        @params plugin name
+
+        Return the full path to the plugin taking into account any host OS
+        specific suffixes.
+        '''
         sfx = dso_suffix()
         return os.path.join('tests', 'tcg', 'plugins', f'{plugin_name}.{sfx}')
 
     def assets_available(self):
         for name, asset in vars(self.__class__).items():
-            if name.startswith("ASSET_") and type(asset) == Asset:
+            if name.startswith("ASSET_") and isinstance(asset, Asset):
                 if not asset.available():
                     self.log.debug(f"Asset {asset.url} not available")
                     return False
@@ -216,9 +217,9 @@ def setUp(self):
         self.log.setLevel(logging.DEBUG)
         self._log_fh = logging.FileHandler(self.log_filename, mode='w')
         self._log_fh.setLevel(logging.DEBUG)
-        fileFormatter = logging.Formatter(
+        file_formatter = logging.Formatter(
             '%(asctime)s - %(levelname)s: %(name)s.%(funcName)s %(message)s')
-        self._log_fh.setFormatter(fileFormatter)
+        self._log_fh.setFormatter(file_formatter)
         self.log.addHandler(self._log_fh)
 
         # Capture QEMUMachine logging
@@ -260,7 +261,7 @@ def main():
         res = unittest.main(module = None, testRunner = tr, exit = False,
                             argv=[sys.argv[0], path] + sys.argv[1:])
         failed = {}
-        for (test, message) in res.result.errors + res.result.failures:
+        for (test, _message) in res.result.errors + res.result.failures:
             if hasattr(test, "log_filename") and not test.id() in failed:
                 print('More information on ' + test.id() + ' could be found here:'
                       '\n %s' % test.log_filename, file=sys.stderr)
@@ -279,7 +280,9 @@ def setUp(self):
     def add_ldpath(self, ldpath):
         self._ldpath.append(os.path.abspath(ldpath))
 
-    def run_cmd(self, bin_path, args=[]):
+    def run_cmd(self, bin_path, args=None):
+        if args is None:
+            args = []
         return run([self.qemu_bin]
                    + ["-L %s" % ldpath for ldpath in self._ldpath]
                    + [bin_path]
@@ -304,8 +307,8 @@ def setUp(self):
         self._console_log_fh = logging.FileHandler(self.console_log_name,
                                                    mode='w')
         self._console_log_fh.setLevel(logging.DEBUG)
-        fileFormatter = logging.Formatter('%(asctime)s: %(message)s')
-        self._console_log_fh.setFormatter(fileFormatter)
+        file_formatter = logging.Formatter('%(asctime)s: %(message)s')
+        self._console_log_fh.setFormatter(file_formatter)
         console_log.addHandler(self._console_log_fh)
 
     def set_machine(self, machinename):
@@ -343,17 +346,15 @@ def require_accelerator(self, accelerator):
                           "available" % accelerator)
 
     def require_netdev(self, netdevname):
-        help = run([self.qemu_bin,
-                    '-M', 'none', '-netdev', 'help'],
-                   capture_output=True, check=True, encoding='utf8').stdout;
-        if help.find('\n' + netdevname + '\n') < 0:
+        helptxt = run([self.qemu_bin, '-M', 'none', '-netdev', 'help'],
+                      capture_output=True, check=True, encoding='utf8').stdout
+        if helptxt.find('\n' + netdevname + '\n') < 0:
             self.skipTest('no support for " + netdevname + " networking')
 
     def require_device(self, devicename):
-        help = run([self.qemu_bin,
-                    '-M', 'none', '-device', 'help'],
-                   capture_output=True, check=True, encoding='utf8').stdout;
-        if help.find(devicename) < 0:
+        helptxt = run([self.qemu_bin, '-M', 'none', '-device', 'help'],
+                   capture_output=True, check=True, encoding='utf8').stdout
+        if helptxt.find(devicename) < 0:
             self.skipTest('no support for device ' + devicename)
 
     def _new_vm(self, name, *args):
@@ -415,7 +416,7 @@ def tearDown(self):
             try:
                 vm.shutdown()
             except Exception as ex:
-                self.log.error("Failed to teardown VM: %s" % ex)
+                self.log.error("Failed to teardown VM: %s", ex)
         logging.getLogger('console').removeHandler(self._console_log_fh)
         self._console_log_fh.close()
         super().tearDown()
-- 
2.51.1


