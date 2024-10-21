Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F27D0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhJ-0002Bu-Jp; Mon, 21 Oct 2024 07:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhA-00028V-RA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qh8-0001iP-PL
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewZR3nYAk+qO5BFsTcUa5aDZ8M5kPpP+SMJXglKDzJ4=;
 b=NJG3gDWSr/2C9vy56EQyZh5XoDJ8XIjuYCDPOoG6WUqqh9FUI+vm3MdFsZMJyXn+RsTpwb
 pM4T4NK3a1aWxAWGPmOu8tfDqpYF0TQdSwcaCl6AoOr82VjRBrJ66ukAkAk2YN/MJrPnVD
 zqCHUJl60YrbmX6JLaT5f7kqNLwIidI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-_KqOyRQWNeCdQPJV1CbD6w-1; Mon,
 21 Oct 2024 07:35:28 -0400
X-MC-Unique: _KqOyRQWNeCdQPJV1CbD6w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B76FF195608C; Mon, 21 Oct 2024 11:35:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CD1619560AA; Mon, 21 Oct 2024 11:35:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/21] tests/functional: Convert the Avocado arm tuxrun tests
Date: Mon, 21 Oct 2024 13:34:47 +0200
Message-ID: <20241021113500.122500-11-thuth@redhat.com>
In-Reply-To: <20241021113500.122500-1-thuth@redhat.com>
References: <20241021113500.122500-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Move the tests to a new file so that they can be run via
qemu-system-arm in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-7-thuth@redhat.com>
---
 MAINTAINERS                         |  1 +
 tests/avocado/tuxrun_baselines.py   | 56 -----------------------
 tests/functional/meson.build        |  2 +
 tests/functional/test_arm_tuxrun.py | 70 +++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 56 deletions(-)
 create mode 100755 tests/functional/test_arm_tuxrun.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a08beb9669..ed06fce067 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -988,6 +988,7 @@ F: include/hw/arm/virt.h
 F: docs/system/arm/virt.rst
 F: tests/functional/test_aarch64_virt.py
 F: tests/functional/test_aarch64_tuxrun.py
+F: tests/functional/test_arm_tuxrun.py
 
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 98dce857cf..59ca9f9706 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -192,62 +192,6 @@ def common_tuxrun(self,
     #        --kernel https://storage.tuxboot.com/{TUXBOOT}/{IMAGE}
     #
 
-    def test_armv5(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=cpu:arm926
-        :avocado: tags=machine:versatilepb
-        :avocado: tags=tuxboot:armv5
-        :avocado: tags=image:zImage
-        :avocado: tags=console:ttyAMA0
-        :avocado: tags=shutdown:nowait
-        """
-        sums = { "rootfs.ext4.zst" :
-                 "17177afa74e7294da0642861f08c88ca3c836764299a54bf6d1ce276cb9712a5",
-                 "versatile-pb.dtb" :
-                 "0bc0c0b0858cefd3c32b385c0d66d97142ded29472a496f4f490e42fc7615b25",
-                 "zImage" :
-                 "c95af2f27647c12265d75e9df44c22ff5228c59855f54aaa70f41ec2842e3a4d" }
-
-        self.common_tuxrun(csums=sums,
-                           drive="virtio-blk-pci",
-                           dt="versatile-pb.dtb")
-
-    def test_armv7(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=cpu:cortex-a15
-        :avocado: tags=machine:virt
-        :avocado: tags=tuxboot:armv7
-        :avocado: tags=image:zImage
-        :avocado: tags=console:ttyAMA0
-        :avocado: tags=shutdown:nowait
-        """
-        sums = { "rootfs.ext4.zst" :
-                 "ab1fbbeaddda1ffdd45c9405a28cd5370c20f23a7cbc809cc90dc9f243a8eb5a",
-                 "zImage" :
-                 "4c7a22e9f15875bec06bd2a29d822496571eb297d4f22694099ffcdb19077572" }
-
-        self.common_tuxrun(csums=sums)
-
-    def test_armv7be(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=cpu:cortex-a15
-        :avocado: tags=endian:big
-        :avocado: tags=machine:virt
-        :avocado: tags=tuxboot:armv7be
-        :avocado: tags=image:zImage
-        :avocado: tags=console:ttyAMA0
-        :avocado: tags=shutdown:nowait
-        """
-        sums = {"rootfs.ext4.zst" :
-                "42ed46dd2d59986206c5b1f6cf35eab58fe3fd20c96b41aaa16b32f3f90a9835",
-                "zImage" :
-                "7facc62082b57af12015b08f7fdbaf2f123ba07a478367853ae12b219afc9f2f" }
-
-        self.common_tuxrun(csums=sums)
-
     def test_i386(self):
         """
         :avocado: tags=arch:i386
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d598f43289..ae913781ec 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -17,6 +17,7 @@ test_timeouts = {
   'aarch64_virt' : 360,
   'acpi_bits' : 240,
   'arm_raspi2' : 120,
+  'arm_tuxrun' : 120,
   'mips_malta' : 120,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
@@ -56,6 +57,7 @@ tests_arm_system_thorough = [
   'arm_integratorcp',
   'arm_raspi2',
   'arm_vexpress',
+  'arm_tuxrun',
 ]
 
 tests_arm_linuxuser_thorough = [
diff --git a/tests/functional/test_arm_tuxrun.py b/tests/functional/test_arm_tuxrun.py
new file mode 100755
index 0000000000..944f0756e1
--- /dev/null
+++ b/tests/functional/test_arm_tuxrun.py
@@ -0,0 +1,70 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots known good tuxboot images the same way
+# that tuxrun (www.tuxrun.org) does. This tool is used by things like
+# the LKFT project to run regression tests on kernels.
+#
+# Copyright (c) 2023 Linaro Ltd.
+#
+# Author:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from qemu_test.tuxruntest import TuxRunBaselineTest
+
+class TuxRunArmTest(TuxRunBaselineTest):
+
+    ASSET_ARMV5_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/armv5/zImage',
+        'c95af2f27647c12265d75e9df44c22ff5228c59855f54aaa70f41ec2842e3a4d')
+    ASSET_ARMV5_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/armv5/rootfs.ext4.zst',
+        '17177afa74e7294da0642861f08c88ca3c836764299a54bf6d1ce276cb9712a5')
+    ASSET_ARMV5_DTB = Asset(
+        'https://storage.tuxboot.com/20230331/armv5/versatile-pb.dtb',
+        '0bc0c0b0858cefd3c32b385c0d66d97142ded29472a496f4f490e42fc7615b25')
+
+    def test_armv5(self):
+        self.set_machine('versatilepb')
+        self.cpu='arm926'
+        self.console='ttyAMA0'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_ARMV5_KERNEL,
+                           rootfs_asset=self.ASSET_ARMV5_ROOTFS,
+                           dtb_asset=self.ASSET_ARMV5_DTB,
+                           drive="virtio-blk-pci")
+
+    ASSET_ARMV7_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/armv7/zImage',
+        '4c7a22e9f15875bec06bd2a29d822496571eb297d4f22694099ffcdb19077572')
+    ASSET_ARMV7_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/armv7/rootfs.ext4.zst',
+        'ab1fbbeaddda1ffdd45c9405a28cd5370c20f23a7cbc809cc90dc9f243a8eb5a')
+
+    def test_armv7(self):
+        self.set_machine('virt')
+        self.cpu='cortex-a15'
+        self.console='ttyAMA0'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_ARMV7_KERNEL,
+                           rootfs_asset=self.ASSET_ARMV7_ROOTFS)
+
+    ASSET_ARMV7BE_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/armv7be/zImage',
+        '7facc62082b57af12015b08f7fdbaf2f123ba07a478367853ae12b219afc9f2f')
+    ASSET_ARMV7BE_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/armv7be/rootfs.ext4.zst',
+        '42ed46dd2d59986206c5b1f6cf35eab58fe3fd20c96b41aaa16b32f3f90a9835')
+
+    def test_armv7be(self):
+        self.set_machine('virt')
+        self.cpu='cortex-a15'
+        self.console='ttyAMA0'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_ARMV7BE_KERNEL,
+                           rootfs_asset=self.ASSET_ARMV7BE_ROOTFS)
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


