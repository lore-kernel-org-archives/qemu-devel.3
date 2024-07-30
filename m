Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53ABC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqI3-0004AB-O6; Tue, 30 Jul 2024 13:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqI0-0003yN-4D
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHu-0002l7-Fv
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOkVbbOaEZMYX/QmI1GD5owKsxXtudaYNTwvs1rBL5Q=;
 b=T/MIo49d+wQ1TFaG2XiPgedYWSpdQX7IdIZ2CGUH2ctupP6Fk1osWhcJhU3U+o+w5ML46+
 7qBHIB8He1V7XlNpdLqCuEmnoSIoABsBZeqyM5XVo6EFPeUrF+5YZ28ZcOW6VjT84g+CiO
 P1mmA7iPwOXrLjo1Zh45TKC+cUs6ybU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-I7Q60Xo0MQS3DvXsL31J5Q-1; Tue,
 30 Jul 2024 13:05:23 -0400
X-MC-Unique: I7Q60Xo0MQS3DvXsL31J5Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 166221955BD0; Tue, 30 Jul 2024 17:05:22 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F2E4300018D; Tue, 30 Jul 2024 17:05:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 22/24] tests/functional: Convert the acpi-bits test into a
 standalone test
Date: Tue, 30 Jul 2024 18:03:42 +0100
Message-ID: <20240730170347.4103919-23-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
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

From: Thomas Huth <thuth@redhat.com>

Mostly a straight-forward conversion. Looks like we can simply drop
the avocado datadrainer stuff when not using the avocado framework
anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../acpi-bits/bits-config/bits-cfg.txt        |  0
 .../acpi-bits/bits-tests/smbios.py2           |  0
 .../acpi-bits/bits-tests/smilatency.py2       |  0
 .../acpi-bits/bits-tests/testacpi.py2         |  0
 .../acpi-bits/bits-tests/testcpuid.py2        |  0
 tests/functional/meson.build                  |  2 +
 .../test_acpi_bits.py}                        | 81 ++++++++++---------
 7 files changed, 43 insertions(+), 40 deletions(-)
 rename tests/{avocado => functional}/acpi-bits/bits-config/bits-cfg.txt (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/smbios.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/smilatency.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/testacpi.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/testcpuid.py2 (100%)
 rename tests/{avocado/acpi-bits.py => functional/test_acpi_bits.py} (86%)
 mode change 100644 => 100755

diff --git a/tests/avocado/acpi-bits/bits-config/bits-cfg.txt b/tests/functional/acpi-bits/bits-config/bits-cfg.txt
similarity index 100%
rename from tests/avocado/acpi-bits/bits-config/bits-cfg.txt
rename to tests/functional/acpi-bits/bits-config/bits-cfg.txt
diff --git a/tests/avocado/acpi-bits/bits-tests/smbios.py2 b/tests/functional/acpi-bits/bits-tests/smbios.py2
similarity index 100%
rename from tests/avocado/acpi-bits/bits-tests/smbios.py2
rename to tests/functional/acpi-bits/bits-tests/smbios.py2
diff --git a/tests/avocado/acpi-bits/bits-tests/smilatency.py2 b/tests/functional/acpi-bits/bits-tests/smilatency.py2
similarity index 100%
rename from tests/avocado/acpi-bits/bits-tests/smilatency.py2
rename to tests/functional/acpi-bits/bits-tests/smilatency.py2
diff --git a/tests/avocado/acpi-bits/bits-tests/testacpi.py2 b/tests/functional/acpi-bits/bits-tests/testacpi.py2
similarity index 100%
rename from tests/avocado/acpi-bits/bits-tests/testacpi.py2
rename to tests/functional/acpi-bits/bits-tests/testacpi.py2
diff --git a/tests/avocado/acpi-bits/bits-tests/testcpuid.py2 b/tests/functional/acpi-bits/bits-tests/testcpuid.py2
similarity index 100%
rename from tests/avocado/acpi-bits/bits-tests/testcpuid.py2
rename to tests/functional/acpi-bits/bits-tests/testcpuid.py2
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 46b6405a58..439997a85d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -11,6 +11,7 @@ endif
 
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
+  'acpi_bits' : 240,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
   'ppc64_powernv' : 120,
@@ -97,6 +98,7 @@ tests_x86_64_quick = [
 ]
 
 tests_x86_64_thorough = [
+  'acpi_bits',
   'netdev_ethtool',
   'virtio_gpu',
 ]
diff --git a/tests/avocado/acpi-bits.py b/tests/functional/test_acpi_bits.py
old mode 100644
new mode 100755
similarity index 86%
rename from tests/avocado/acpi-bits.py
rename to tests/functional/test_acpi_bits.py
index efe4f52ee0..e9f8381f84
--- a/tests/avocado/acpi-bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -1,5 +1,5 @@
 #!/usr/bin/env python3
-# group: rw quick
+#
 # Exercise QEMU generated ACPI/SMBIOS tables using biosbits,
 # https://biosbits.org/
 #
@@ -41,15 +41,16 @@
 import tempfile
 import time
 import zipfile
+
+from pathlib import Path
 from typing import (
     List,
     Optional,
     Sequence,
 )
 from qemu.machine import QEMUMachine
-from avocado import skipIf
-from avocado.utils import datadrainer as drainer
-from avocado_qemu import QemuBaseTest
+from unittest import skipIf
+from qemu_test import QemuBaseTest, Asset
 
 deps = ["xorriso", "mformat"] # dependent tools needed in the test setup/box.
 supported_platforms = ['x86_64'] # supported test platforms.
@@ -129,34 +130,32 @@ def base_args(self):
 class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
     """
     ACPI and SMBIOS tests using biosbits.
-
-    :avocado: tags=arch:x86_64
-    :avocado: tags=acpi
-
     """
     # in slower systems the test can take as long as 3 minutes to complete.
     timeout = BITS_TIMEOUT
 
+    # following are some standard configuration constants
+    # gitlab CI does shallow clones of depth 20
+    BITS_INTERNAL_VER = 2020
+    # commit hash must match the artifact tag below
+    BITS_COMMIT_HASH = 'c7920d2b'
+    # this is the latest bits release as of today.
+    BITS_TAG = "qemu-bits-10262023"
+
+    ASSET_BITS = Asset(("https://gitlab.com/qemu-project/"
+                        "biosbits-bits/-/jobs/artifacts/%s/"
+                        "download?job=qemu-bits-build" % BITS_TAG),
+                       'b22cdfcfc7453875297d06d626f5474ee36a343f')
+
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
         self._vm = None
         self._workDir = None
         self._baseDir = None
 
-        # following are some standard configuration constants
-        self._bitsInternalVer = 2020 # gitlab CI does shallow clones of depth 20
-        self._bitsCommitHash = 'c7920d2b' # commit hash must match
-                                          # the artifact tag below
-        self._bitsTag = "qemu-bits-10262023" # this is the latest bits
-                                             # release as of today.
-        self._bitsArtSHA1Hash = 'b22cdfcfc7453875297d06d626f5474ee36a343f'
-        self._bitsArtURL = ("https://gitlab.com/qemu-project/"
-                            "biosbits-bits/-/jobs/artifacts/%s/"
-                            "download?job=qemu-bits-build" %self._bitsTag)
         self._debugcon_addr = '0x403'
         self._debugcon_log = 'debugcon-log.txt'
-        logging.basicConfig(level=logging.INFO)
-        self.logger = logging.getLogger('acpi-bits')
+        self.logger = self.log
 
     def _print_log(self, log):
         self.logger.info('\nlogs from biosbits follows:')
@@ -171,7 +170,7 @@ def copy_bits_config(self):
         bits_config_dir = os.path.join(self._baseDir, 'acpi-bits',
                                        'bits-config')
         target_config_dir = os.path.join(self._workDir,
-                                         'bits-%d' %self._bitsInternalVer,
+                                         'bits-%d' %self.BITS_INTERNAL_VER,
                                          'boot')
         self.assertTrue(os.path.exists(bits_config_dir))
         self.assertTrue(os.path.exists(target_config_dir))
@@ -188,7 +187,7 @@ def copy_test_scripts(self):
         bits_test_dir = os.path.join(self._baseDir, 'acpi-bits',
                                      'bits-tests')
         target_test_dir = os.path.join(self._workDir,
-                                       'bits-%d' %self._bitsInternalVer,
+                                       'bits-%d' %self.BITS_INTERNAL_VER,
                                        'boot', 'python')
 
         self.assertTrue(os.path.exists(bits_test_dir))
@@ -248,9 +247,9 @@ def generate_bits_iso(self):
             test scripts
         """
         bits_dir = os.path.join(self._workDir,
-                                'bits-%d' %self._bitsInternalVer)
+                                'bits-%d' %self.BITS_INTERNAL_VER)
         iso_file = os.path.join(self._workDir,
-                                'bits-%d.iso' %self._bitsInternalVer)
+                                'bits-%d.iso' %self.BITS_INTERNAL_VER)
         mkrescue_script = os.path.join(self._workDir,
                                        'grub-inst-x86_64-efi', 'bin',
                                        'grub-mkrescue')
@@ -264,8 +263,12 @@ def generate_bits_iso(self):
 
         try:
             if os.getenv('V') or os.getenv('BITS_DEBUG'):
-                subprocess.check_call([mkrescue_script, '-o', iso_file,
-                                       bits_dir], stderr=subprocess.STDOUT)
+                proc = subprocess.run([mkrescue_script, '-o', iso_file,
+                                       bits_dir],
+                                      stdout=subprocess.PIPE,
+                                      stderr=subprocess.STDOUT,
+                                      check=True)
+                self.logger.info("grub-mkrescue output %s" % proc.stdout)
             else:
                 subprocess.check_call([mkrescue_script, '-o',
                                       iso_file, bits_dir],
@@ -282,8 +285,9 @@ def generate_bits_iso(self):
 
     def setUp(self): # pylint: disable=arguments-differ
         super().setUp('qemu-system-')
+        self.logger = self.log
 
-        self._baseDir = os.getenv('AVOCADO_TEST_BASEDIR')
+        self._baseDir = Path(__file__).parent
 
         # workdir could also be avocado's own workdir in self.workdir.
         # At present, I prefer to maintain my own temporary working
@@ -300,15 +304,14 @@ def setUp(self): # pylint: disable=arguments-differ
             os.mkdir(prebuiltDir, mode=0o775)
 
         bits_zip_file = os.path.join(prebuiltDir, 'bits-%d-%s.zip'
-                                     %(self._bitsInternalVer,
-                                       self._bitsCommitHash))
+                                     %(self.BITS_INTERNAL_VER,
+                                       self.BITS_COMMIT_HASH))
         grub_tar_file = os.path.join(prebuiltDir,
                                      'bits-%d-%s-grub.tar.gz'
-                                     %(self._bitsInternalVer,
-                                       self._bitsCommitHash))
+                                     %(self.BITS_INTERNAL_VER,
+                                       self.BITS_COMMIT_HASH))
 
-        bitsLocalArtLoc = self.fetch_asset(self._bitsArtURL,
-                                           asset_hash=self._bitsArtSHA1Hash)
+        bitsLocalArtLoc = self.ASSET_BITS.fetch()
         self.logger.info("downloaded bits artifacts to %s", bitsLocalArtLoc)
 
         # extract the bits artifact in the temp working directory
@@ -369,7 +372,7 @@ def test_acpi_smbios_bits(self):
         """The main test case implementation."""
 
         iso_file = os.path.join(self._workDir,
-                                'bits-%d.iso' %self._bitsInternalVer)
+                                'bits-%d.iso' %self.BITS_INTERNAL_VER)
 
         self.assertTrue(os.access(iso_file, os.R_OK))
 
@@ -393,12 +396,6 @@ def test_acpi_smbios_bits(self):
         self._vm.set_console()
         self._vm.launch()
 
-        self.logger.debug("Console output from bits VM follows ...")
-        c_drainer = drainer.LineLogger(self._vm.console_socket.fileno(),
-                                       logger=self.logger.getChild("console"),
-                                       stop_check=(lambda :
-                                                   not self._vm.is_running()))
-        c_drainer.start()
 
         # biosbits has been configured to run all the specified test suites
         # in batch mode and then automatically initiate a vm shutdown.
@@ -406,4 +403,8 @@ def test_acpi_smbios_bits(self):
         # with the avocado test timeout.
         self._vm.event_wait('SHUTDOWN', timeout=BITS_TIMEOUT)
         self._vm.wait(timeout=None)
+        self.logger.debug("Checking console output ...")
         self.parse_log()
+
+if __name__ == '__main__':
+    QemuBaseTest.main()
-- 
2.45.2


