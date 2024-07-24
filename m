Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D588EC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWgDN-0002ik-GQ; Wed, 24 Jul 2024 13:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgCq-0000lH-1C
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgCg-00061J-Ic
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721843699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SD5m8qQwNcVObfcscMhGfK6HWkYOwHdm2EdrUNkLD8=;
 b=fuQSdBrvuIXnRT6/lRqckynnk0WCxWSbwxAlk+rgZLl+hNCh6glrK35j0tl2vB1YXVSq7z
 ocSvuQo7veU8sU3kHx1lk6ZZ4OY9kiJXkkYbskDtaOXmGJsKFBwuUvbVCYsIrEtkMTkUS0
 Qo5J2in/wpi2+VxlpfAjaL72xUjBRyA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-qbgQK-4BNTWv5V00bgo0Kw-1; Wed,
 24 Jul 2024 13:54:56 -0400
X-MC-Unique: qbgQK-4BNTWv5V00bgo0Kw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A09141944B29; Wed, 24 Jul 2024 17:54:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7068B1955D48; Wed, 24 Jul 2024 17:54:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 21/23] tests/functional: Convert the acpi-bits test into a
 standalone test
Date: Wed, 24 Jul 2024 19:52:39 +0200
Message-ID: <20240724175248.1389201-22-thuth@redhat.com>
In-Reply-To: <20240724175248.1389201-1-thuth@redhat.com>
References: <20240724175248.1389201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 tests/functional/meson.build                  |  2 ++
 .../test_acpi_bits.py}                        | 29 ++++++++-----------
 7 files changed, 14 insertions(+), 17 deletions(-)
 rename tests/{avocado => functional}/acpi-bits/bits-config/bits-cfg.txt (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/smbios.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/smilatency.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/testacpi.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/testcpuid.py2 (100%)
 rename tests/{avocado/acpi-bits.py => functional/test_acpi_bits.py} (95%)
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
index 109e0408e4..52328f44b6 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -11,6 +11,7 @@ endif
 
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
+  'acpi_bits' : 240,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
   'ppc64_powernv' : 120,
@@ -96,6 +97,7 @@ tests_x86_64_quick = [
 ]
 
 tests_x86_64_thorough = [
+  'acpi_bits',
   'netdev_ethtool',
   'virtio_gpu',
 ]
diff --git a/tests/avocado/acpi-bits.py b/tests/functional/test_acpi_bits.py
old mode 100644
new mode 100755
similarity index 95%
rename from tests/avocado/acpi-bits.py
rename to tests/functional/test_acpi_bits.py
index efe4f52ee0..697fa4e768
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
+from qemu_test import QemuBaseTest
 
 deps = ["xorriso", "mformat"] # dependent tools needed in the test setup/box.
 supported_platforms = ['x86_64'] # supported test platforms.
@@ -129,10 +130,6 @@ def base_args(self):
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
@@ -155,8 +152,7 @@ def __init__(self, *args, **kwargs):
                             "download?job=qemu-bits-build" %self._bitsTag)
         self._debugcon_addr = '0x403'
         self._debugcon_log = 'debugcon-log.txt'
-        logging.basicConfig(level=logging.INFO)
-        self.logger = logging.getLogger('acpi-bits')
+        self.logger = self.log
 
     def _print_log(self, log):
         self.logger.info('\nlogs from biosbits follows:')
@@ -282,8 +278,9 @@ def generate_bits_iso(self):
 
     def setUp(self): # pylint: disable=arguments-differ
         super().setUp('qemu-system-')
+        self.logger = self.log
 
-        self._baseDir = os.getenv('AVOCADO_TEST_BASEDIR')
+        self._baseDir = Path(__file__).parent
 
         # workdir could also be avocado's own workdir in self.workdir.
         # At present, I prefer to maintain my own temporary working
@@ -393,12 +390,6 @@ def test_acpi_smbios_bits(self):
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
@@ -406,4 +397,8 @@ def test_acpi_smbios_bits(self):
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


