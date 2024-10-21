Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBBAD0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhL-0002Cs-OC; Mon, 21 Oct 2024 07:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qh9-00028S-O9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qh7-0001iB-Q4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMAUfatU4v8P6M6l9m7ZlyTq9+P6vVi+BYaO0qNGlTY=;
 b=bgQw7k4/oIZHNJAerrnpDiYNOtP5KSqo0FJgEpCxoW0f5qz9sE/WAwWRzzDu9+ab96R3Lw
 kP12jRusI5eQbAvcerq3+ARxO26ZPDITJUHmVhOUwkOpdyfWcDG45OKVg/jV4awsuORNJ6
 d6R/S5EWvX1u2i3KNPnXEmumKAT/HBg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-XyZNDfV8PmiHH3DA_XU9Uw-1; Mon,
 21 Oct 2024 07:35:22 -0400
X-MC-Unique: XyZNDfV8PmiHH3DA_XU9Uw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8CC21955EE9; Mon, 21 Oct 2024 11:35:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC27319560AA; Mon, 21 Oct 2024 11:35:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/21] tests/functional: Convert the Avocado aarch64 tuxrun
 tests
Date: Mon, 21 Oct 2024 13:34:44 +0200
Message-ID: <20241021113500.122500-8-thuth@redhat.com>
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
qemu-system-aarch64 in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-4-thuth@redhat.com>
---
 MAINTAINERS                             |  1 +
 tests/avocado/tuxrun_baselines.py       | 31 ---------------
 tests/functional/meson.build            |  2 +
 tests/functional/test_aarch64_tuxrun.py | 50 +++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 31 deletions(-)
 create mode 100755 tests/functional/test_aarch64_tuxrun.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f4a58f850..4f4f50711b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -987,6 +987,7 @@ F: hw/arm/virt*
 F: include/hw/arm/virt.h
 F: docs/system/arm/virt.rst
 F: tests/functional/test_aarch64_virt.py
+F: tests/functional/test_aarch64_tuxrun.py
 
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 56c8bdb2dc..dffa4f6339 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -192,37 +192,6 @@ def common_tuxrun(self,
     #        --kernel https://storage.tuxboot.com/{TUXBOOT}/{IMAGE}
     #
 
-    def test_arm64(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=machine:virt
-        :avocado: tags=tuxboot:arm64
-        :avocado: tags=console:ttyAMA0
-        :avocado: tags=shutdown:nowait
-        """
-        sums = {"Image" :
-                "ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7",
-                "rootfs.ext4.zst" :
-                "bbd5ed4b9c7d3f4ca19ba71a323a843c6b585e880115df3b7765769dbd9dd061"}
-        self.common_tuxrun(csums=sums)
-
-    def test_arm64be(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=endian:big
-        :avocado: tags=machine:virt
-        :avocado: tags=tuxboot:arm64be
-        :avocado: tags=console:ttyAMA0
-        :avocado: tags=shutdown:nowait
-        """
-        sums = { "Image" :
-                 "e0df4425eb2cd9ea9a283e808037f805641c65d8fcecc8f6407d8f4f339561b4",
-                 "rootfs.ext4.zst" :
-                 "e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7"}
-        self.common_tuxrun(csums=sums)
-
     def test_armv5(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c90c02517a..222bfbcc62 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -13,6 +13,7 @@ endif
 test_timeouts = {
   'aarch64_raspi4' : 120,
   'aarch64_sbsaref' : 600,
+  'aarch64_tuxrun' : 120,
   'aarch64_virt' : 360,
   'acpi_bits' : 240,
   'arm_raspi2' : 120,
@@ -41,6 +42,7 @@ tests_aarch64_system_thorough = [
   'aarch64_raspi3',
   'aarch64_raspi4',
   'aarch64_sbsaref',
+  'aarch64_tuxrun',
   'aarch64_virt',
   'multiprocess',
 ]
diff --git a/tests/functional/test_aarch64_tuxrun.py b/tests/functional/test_aarch64_tuxrun.py
new file mode 100755
index 0000000000..da56aee4ed
--- /dev/null
+++ b/tests/functional/test_aarch64_tuxrun.py
@@ -0,0 +1,50 @@
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
+class TuxRunAarch64Test(TuxRunBaselineTest):
+
+    ASSET_ARM64_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/arm64/Image',
+        'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7')
+    ASSET_ARM64_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/arm64/rootfs.ext4.zst',
+        'bbd5ed4b9c7d3f4ca19ba71a323a843c6b585e880115df3b7765769dbd9dd061')
+
+    def test_arm64(self):
+        self.set_machine('virt')
+        self.cpu='cortex-a57'
+        self.console='ttyAMA0'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_ARM64_KERNEL,
+                           rootfs_asset=self.ASSET_ARM64_ROOTFS)
+
+    ASSET_ARM64BE_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/arm64be/Image',
+        'e0df4425eb2cd9ea9a283e808037f805641c65d8fcecc8f6407d8f4f339561b4')
+    ASSET_ARM64BE_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/arm64be/rootfs.ext4.zst',
+        'e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7')
+
+    def test_arm64be(self):
+        self.set_machine('virt')
+        self.cpu='cortex-a57'
+        self.console='ttyAMA0'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_ARM64BE_KERNEL,
+                           rootfs_asset=self.ASSET_ARM64BE_ROOTFS)
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


