Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2835ACD484B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnRX-0005Uj-PQ; Wed, 04 Sep 2024 06:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRU-0005Bo-HZ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRR-0000Nu-PB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nt9AzICbk4gZxdVkFY9UjvkgXQM8tAMN6F8SghD1MO8=;
 b=Yhqc5SaNav93nUikT2fvZKJDXwUoZ7mRf3JEKhSBhq8AkI7S+vg6Mx0AdqSveahuGYPdcY
 uqis6w/8VTXYXOZsYKq1qvzZvBcWtOEq3sV3E53olNN3WxvdlQ4/dVfLj0+JE0pIf8SuKP
 eRqbDMtF3tgWMEpMgUaVVIGMEQY51/A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360--KiR017JPT-okYgTX7bd-Q-1; Wed,
 04 Sep 2024 06:40:47 -0400
X-MC-Unique: -KiR017JPT-okYgTX7bd-Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C00A1955F0D; Wed,  4 Sep 2024 10:40:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8972195605A; Wed,  4 Sep 2024 10:40:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/42] tests/functional: Convert the acpi-bits test into a
 standalone test
Date: Wed,  4 Sep 2024 12:39:03 +0200
Message-ID: <20240904103923.451847-29-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Mostly a straight-forward conversion. Looks like we can simply drop
the avocado datadrainer stuff when not using the avocado framework
anymore.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240830133841.142644-30-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  4 +-
 docs/devel/acpi-bits.rst                      | 62 ++++++--------
 .../acpi-bits/bits-config/bits-cfg.txt        |  0
 .../acpi-bits/bits-tests/smbios.py2           |  0
 .../acpi-bits/bits-tests/smilatency.py2       |  0
 .../acpi-bits/bits-tests/testacpi.py2         |  0
 .../acpi-bits/bits-tests/testcpuid.py2        |  0
 tests/functional/meson.build                  |  2 +
 .../test_acpi_bits.py}                        | 83 ++++++++++---------
 9 files changed, 71 insertions(+), 80 deletions(-)
 rename tests/{avocado => functional}/acpi-bits/bits-config/bits-cfg.txt (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/smbios.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/smilatency.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/testacpi.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/testcpuid.py2 (100%)
 rename tests/{avocado/acpi-bits.py => functional/test_acpi_bits.py} (86%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 70dd2430db..f234464d11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2074,8 +2074,8 @@ ACPI/AVOCADO/BIOSBITS
 M: Ani Sinha <anisinha@redhat.com>
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
-F: tests/avocado/acpi-bits/*
-F: tests/avocado/acpi-bits.py
+F: tests/functional/acpi-bits/*
+F: tests/functional/test_acpi_bits.py
 F: docs/devel/acpi-bits.rst
 
 ACPI/HEST/GHES
diff --git a/docs/devel/acpi-bits.rst b/docs/devel/acpi-bits.rst
index 1ec394f5fb..78aeb6aa3c 100644
--- a/docs/devel/acpi-bits.rst
+++ b/docs/devel/acpi-bits.rst
@@ -1,6 +1,6 @@
-=============================================================================
-ACPI/SMBIOS avocado tests using biosbits
-=============================================================================
+==================================
+ACPI/SMBIOS testing using biosbits
+==================================
 ************
 Introduction
 ************
@@ -35,7 +35,7 @@ for developing biosbits and its real life uses can be found in [#a]_ and [#b]_.
 For QEMU, we maintain a fork of bios bits in gitlab along with all the
 dependent submodules `here <https://gitlab.com/qemu-project/biosbits-bits>`__.
 This fork contains numerous fixes, a newer acpica and changes specific to
-running this avocado QEMU tests using bits. The author of this document
+running these functional QEMU tests using bits. The author of this document
 is the sole maintainer of the QEMU fork of bios bits repository. For more
 information, please see author's `FOSDEM talk on this bios-bits based test
 framework <https://fosdem.org/2024/schedule/event/fosdem-2024-2262-exercising-qemu-generated-acpi-smbios-tables-using-biosbits-from-within-a-guest-vm-/>`__.
@@ -44,12 +44,12 @@ framework <https://fosdem.org/2024/schedule/event/fosdem-2024-2262-exercising-qe
 Description of the test framework
 *********************************
 
-Under the directory ``tests/avocado/``, ``acpi-bits.py`` is a QEMU avocado
-test that drives all this.
+Under the directory ``tests/functional/``, ``test_acpi_bits.py`` is a QEMU
+functional test that drives all this.
 
 A brief description of the various test files follows.
 
-Under ``tests/avocado/`` as the root we have:
+Under ``tests/functional/`` as the root we have:
 
 ::
 
@@ -60,12 +60,12 @@ Under ``tests/avocado/`` as the root we have:
    │   ├── smbios.py2
    │   ├── testacpi.py2
    │   └── testcpuid.py2
-   ├── acpi-bits.py
+   ├── test_acpi_bits.py
 
-* ``tests/avocado``:
+* ``tests/functional``:
 
-   ``acpi-bits.py``:
-   This is the main python avocado test script that generates a
+   ``test_acpi_bits.py``:
+   This is the main python functional test script that generates a
    biosbits iso. It then spawns a QEMU VM with it, collects the log and reports
    test failures. This is the script one would be interested in if they wanted
    to add or change some component of the log parsing, add a new command line
@@ -79,35 +79,22 @@ Under ``tests/avocado/`` as the root we have:
    you to inspect and run the specific commands manually.
 
    In order to run this test, please perform the following steps from the QEMU
-   build directory:
+   build directory (assuming that the sources are in ".."):
    ::
 
-     $ make check-venv (needed only the first time to create the venv)
-     $ ./pyvenv/bin/avocado run -t acpi tests/avocado
+     $ export PYTHONPATH=../python:../tests/functional
+     $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
+     $ python3 ../tests/functional/test_acpi_bits.py
 
-   The above will run all acpi avocado tests including this one.
-   In order to run the individual tests, perform the following:
-   ::
-
-     $ ./pyvenv/bin/avocado run tests/avocado/acpi-bits.py --tap -
-
-   The above will produce output in tap format. You can omit "--tap -" in the
-   end and it will produce output like the following:
-   ::
-
-      $ ./pyvenv/bin/avocado run tests/avocado/acpi-bits.py
-      Fetching asset from tests/avocado/acpi-bits.py:AcpiBitsTest.test_acpi_smbios_bits
-      JOB ID     : eab225724da7b64c012c65705dc2fa14ab1defef
-      JOB LOG    : /home/anisinha/avocado/job-results/job-2022-10-10T17.58-eab2257/job.log
-      (1/1) tests/avocado/acpi-bits.py:AcpiBitsTest.test_acpi_smbios_bits: PASS (33.09 s)
-      RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
-      JOB TIME   : 39.22 s
+   The above will run all acpi-bits functional tests (producing output in
+   tap format).
 
-   You can inspect the log file for more information about the run or in order
-   to diagnoze issues. If you pass V=1 in the environment, more diagnostic logs
-   would be found in the test log.
+   You can inspect the log files in tests/functional/x86_64/test_acpi_bits.*/
+   for more information about the run or in order to diagnoze issues.
+   If you pass V=1 in the environment, more diagnostic logs will be put into
+   the test log.
 
-* ``tests/avocado/acpi-bits/bits-config``:
+* ``tests/functional/acpi-bits/bits-config``:
 
    This location contains biosbits configuration files that determine how the
    software runs the tests.
@@ -117,7 +104,7 @@ Under ``tests/avocado/`` as the root we have:
    or actions are performed by bits. The description of the config options are
    provided in the file itself.
 
-* ``tests/avocado/acpi-bits/bits-tests``:
+* ``tests/functional/acpi-bits/bits-tests``:
 
    This directory contains biosbits python based tests that are run from within
    the biosbits environment in the spawned VM. New additions of test cases can
@@ -155,7 +142,8 @@ Under ``tests/avocado/`` as the root we have:
    (a) They are python2.7 based scripts and not python 3 scripts.
    (b) They are run from within the bios bits VM and is not subjected to QEMU
        build/test python script maintenance and dependency resolutions.
-   (c) They need not be loaded by avocado framework when running tests.
+   (c) They need not be loaded by the test framework by accident when running
+       tests.
 
 
 Author: Ani Sinha <anisinha@redhat.com>
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
index 61cdd1d598..3bbe80b05d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -11,6 +11,7 @@ endif
 
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
+  'acpi_bits' : 240,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
   'ppc64_hv' : 1000,
@@ -96,6 +97,7 @@ tests_x86_64_system_quick = [
 ]
 
 tests_x86_64_system_thorough = [
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
index efe4f52ee0..ee40647d5b
--- a/tests/avocado/acpi-bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -1,5 +1,5 @@
 #!/usr/bin/env python3
-# group: rw quick
+#
 # Exercise QEMU generated ACPI/SMBIOS tables using biosbits,
 # https://biosbits.org/
 #
@@ -24,7 +24,7 @@
 # pylint: disable=consider-using-f-string
 
 """
-This is QEMU ACPI/SMBIOS avocado tests using biosbits.
+This is QEMU ACPI/SMBIOS functional tests using biosbits.
 Biosbits is available originally at https://biosbits.org/.
 This test uses a fork of the upstream bits and has numerous fixes
 including an upgraded acpica. The fork is located here:
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
+                       '1b8dd612c6831a6b491716a77acc486666aaa867051cdc34f7ce169c2e25f487')
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
2.46.0


