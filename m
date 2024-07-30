Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582DDC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqIN-0006B3-MD; Tue, 30 Jul 2024 13:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqI3-0004Bf-29
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHz-0002ls-UW
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3X8QT0MziXtNFJ8jwF/B9NxkQ6NFG/JRHV1G4q2/CAQ=;
 b=UMtC0u/M8ZHp2m3iMZwkxzdSt2lG9g62O7B898lN02SB6i+IfSs8MOQ8uxSyEf2NESGY/Q
 3ZdRo/71yp/lZBv3Ywv/g296cepUoSgEqjrSScvAYl1iSFiuEJ1+YJ8Pp5bBko6Zzjzu4X
 o0TLNh4UUZ1Ig/vdmnCcWUgOGOBCO90=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-5tjW2NZdPwm0KV35vPC-KA-1; Tue,
 30 Jul 2024 13:05:28 -0400
X-MC-Unique: 5tjW2NZdPwm0KV35vPC-KA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 449B31955D55; Tue, 30 Jul 2024 17:05:26 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE437300018D; Tue, 30 Jul 2024 17:05:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 23/24] tests/functional: Convert the rx_gdbsim avocado test
 into a standalone test
Date: Tue, 30 Jul 2024 18:03:43 +0100
Message-ID: <20240730170347.4103919-24-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Provide a "gzip_uncompress" function based on the standard "gzip" module
to avoid the usage of avocado.utils here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                  |  4 ++
 tests/functional/qemu_test/utils.py           | 12 ++++
 .../test_rx_gdbsim.py}                        | 57 ++++++++++---------
 3 files changed, 45 insertions(+), 28 deletions(-)
 rename tests/{avocado/machine_rx_gdbsim.py => functional/test_rx_gdbsim.py} (54%)
 mode change 100644 => 100755

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 439997a85d..b4889d8d7a 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -80,6 +80,10 @@ tests_riscv64_quick = [
   'riscv_opensbi',
 ]
 
+tests_rx_thorough = [
+  'rx_gdbsim',
+]
+
 tests_s390x_thorough = [
   's390x_ccw_virtio',
   's390x_topology',
diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index a12dac51b6..99eae5fc45 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -8,6 +8,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import gzip
 import lzma
 import os
 import shutil
@@ -23,6 +24,17 @@ def archive_extract(archive, dest_dir, member=None):
         else:
             tf.extractall(path=dest_dir)
 
+def gzip_uncompress(gz_path, output_path):
+    if os.path.exists(output_path):
+        return
+    with gzip.open(gz_path, 'rb') as gz_in:
+        try:
+            with open(output_path, 'wb') as raw_out:
+                shutil.copyfileobj(gz_in, raw_out)
+        except:
+            os.remove(output_path)
+            raise
+
 def lzma_uncompress(xz_path, output_path):
     if os.path.exists(output_path):
         return
diff --git a/tests/avocado/machine_rx_gdbsim.py b/tests/functional/test_rx_gdbsim.py
old mode 100644
new mode 100755
similarity index 54%
rename from tests/avocado/machine_rx_gdbsim.py
rename to tests/functional/test_rx_gdbsim.py
index 412a7a5089..9b2dcc4b90
--- a/tests/avocado/machine_rx_gdbsim.py
+++ b/tests/functional/test_rx_gdbsim.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a Linux kernel and checks the console
 #
 # Copyright (c) 2018 Red Hat, Inc.
@@ -10,11 +12,11 @@
 
 import os
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import archive
+from unittest import skipUnless
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import gzip_uncompress
 
 
 class RxGdbSimMachine(QemuSystemTest):
@@ -22,21 +24,24 @@ class RxGdbSimMachine(QemuSystemTest):
     timeout = 30
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    ASSET_UBOOT = Asset('https://acc.dl.osdn.jp/users/23/23888/u-boot.bin.gz',
+                        '9b78dbd43b40b2526848c0b1ce9de02c24f4dcdb')
+    ASSET_DTB = Asset('https://acc.dl.osdn.jp/users/23/23887/rx-virt.dtb',
+                      '7b4e4e2c71905da44e86ce47adee2210b026ac18')
+    ASSET_KERNEL = Asset('http://acc.dl.osdn.jp/users/23/23845/zImage',
+                         '39a81067f8d72faad90866ddfefa19165d68fc99')
 
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'),
+                'Test is unstable on GitLab')
     def test_uboot(self):
         """
         U-Boot and checks that the console is operational.
-
-        :avocado: tags=arch:rx
-        :avocado: tags=machine:gdbsim-r5f562n8
-        :avocado: tags=endian:little
-        :avocado: tags=flaky
         """
-        uboot_url = ('https://acc.dl.osdn.jp/users/23/23888/u-boot.bin.gz')
-        uboot_hash = '9b78dbd43b40b2526848c0b1ce9de02c24f4dcdb'
-        uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
-        uboot_path = archive.uncompress(uboot_path, self.workdir)
+        self.set_machine('gdbsim-r5f562n8')
+
+        uboot_path_gz = self.ASSET_UBOOT.fetch()
+        uboot_path = os.path.join(self.workdir, 'u-boot.bin')
+        gzip_uncompress(uboot_path_gz, uboot_path)
 
         self.vm.set_console()
         self.vm.add_args('-bios', uboot_path,
@@ -48,23 +53,16 @@ def test_uboot(self):
         # FIXME limit baudrate on chardev, else we type too fast
         #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'),
+                'Test is unstable on GitLab')
     def test_linux_sash(self):
         """
         Boots a Linux kernel and checks that the console is operational.
-
-        :avocado: tags=arch:rx
-        :avocado: tags=machine:gdbsim-r5f562n7
-        :avocado: tags=endian:little
-        :avocado: tags=flaky
         """
-        dtb_url = ('https://acc.dl.osdn.jp/users/23/23887/rx-virt.dtb')
-        dtb_hash = '7b4e4e2c71905da44e86ce47adee2210b026ac18'
-        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
-        kernel_url = ('http://acc.dl.osdn.jp/users/23/23845/zImage')
-        kernel_hash = '39a81067f8d72faad90866ddfefa19165d68fc99'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.set_machine('gdbsim-r5f562n7')
+
+        dtb_path = self.ASSET_DTB.fetch()
+        kernel_path = self.ASSET_KERNEL.fetch()
 
         self.vm.set_console()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon'
@@ -75,3 +73,6 @@ def test_linux_sash(self):
         wait_for_console_pattern(self, 'Sash command shell (version 1.1.1)',
                                  failure_message='Kernel panic - not syncing')
         exec_command_and_wait_for_pattern(self, 'printenv', 'TERM=linux')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


