Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41002D0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhK-0002CW-K3; Mon, 21 Oct 2024 07:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhG-00029n-JH
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhE-0001jI-9f
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G00nWcgcXXtksK0wliCAbnVw0YAgUurNxOZlvq11elE=;
 b=iskf5Jd9gOSM3CRFG3z5PqiOkW/XO8u5Dqxsl9t4cG27j4VPvk0TEMQ1je8hVpYZ60HaIW
 UXELMtsEvi+R7dK2dKZIKI/2yWbPf2SR/lzOqhKVgVFPDyy7xP7kxZC4cdwwPofOAxOlKi
 EIzdTYDUoiLumpJQYDIQK1ByJhoF8JI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-BJFEnLRxMsSe3P12t-Ciag-1; Mon,
 21 Oct 2024 07:35:33 -0400
X-MC-Unique: BJFEnLRxMsSe3P12t-Ciag-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1A04195608F; Mon, 21 Oct 2024 11:35:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ADFAF19560AA; Mon, 21 Oct 2024 11:35:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/21] tests/functional: Convert the Avocado riscv64 tuxrun
 tests
Date: Mon, 21 Oct 2024 13:34:49 +0200
Message-ID: <20241021113500.122500-13-thuth@redhat.com>
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
qemu-system-riscv64 in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-9-thuth@redhat.com>
---
 tests/avocado/tuxrun_baselines.py       | 31 --------------------
 tests/functional/meson.build            |  4 +++
 tests/functional/test_riscv64_tuxrun.py | 38 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 31 deletions(-)
 create mode 100755 tests/functional/test_riscv64_tuxrun.py

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index e84fb9c3b9..dcb6589f2f 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -292,37 +292,6 @@ def test_ppc32(self):
 
         self.common_tuxrun(csums=sums, drive="virtio-blk-pci")
 
-    def test_riscv64(self):
-        """
-        :avocado: tags=arch:riscv64
-        :avocado: tags=machine:virt
-        :avocado: tags=tuxboot:riscv64
-        """
-        sums = { "Image" :
-                 "cd634badc65e52fb63465ec99e309c0de0369f0841b7d9486f9729e119bac25e",
-                 "fw_jump.elf" :
-                 "6e3373abcab4305fe151b564a4c71110d833c21f2c0a1753b7935459e36aedcf",
-                 "rootfs.ext4.zst" :
-                 "b18e3a3bdf27be03da0b285e84cb71bf09eca071c3a087b42884b6982ed679eb" }
-
-        self.common_tuxrun(csums=sums)
-
-    def test_riscv64_maxcpu(self):
-        """
-        :avocado: tags=arch:riscv64
-        :avocado: tags=machine:virt
-        :avocado: tags=cpu:max
-        :avocado: tags=tuxboot:riscv64
-        """
-        sums = { "Image" :
-                 "cd634badc65e52fb63465ec99e309c0de0369f0841b7d9486f9729e119bac25e",
-                 "fw_jump.elf" :
-                 "6e3373abcab4305fe151b564a4c71110d833c21f2c0a1753b7935459e36aedcf",
-                 "rootfs.ext4.zst" :
-                 "b18e3a3bdf27be03da0b285e84cb71bf09eca071c3a087b42884b6982ed679eb" }
-
-        self.common_tuxrun(csums=sums)
-
     # Note: some segfaults caused by unaligned userspace access
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
     def test_sh4(self):
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 1491b4492e..94270c798c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -133,6 +133,10 @@ tests_riscv32_system_thorough = [
   'riscv32_tuxrun',
 ]
 
+tests_riscv64_system_thorough = [
+  'riscv64_tuxrun',
+]
+
 tests_s390x_system_thorough = [
   's390x_ccw_virtio',
   's390x_topology',
diff --git a/tests/functional/test_riscv64_tuxrun.py b/tests/functional/test_riscv64_tuxrun.py
new file mode 100755
index 0000000000..13501628f9
--- /dev/null
+++ b/tests/functional/test_riscv64_tuxrun.py
@@ -0,0 +1,38 @@
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
+class TuxRunRiscV64Test(TuxRunBaselineTest):
+
+    ASSET_RISCV64_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/riscv64/Image',
+        'cd634badc65e52fb63465ec99e309c0de0369f0841b7d9486f9729e119bac25e')
+    ASSET_RISCV64_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/riscv64/rootfs.ext4.zst',
+        'b18e3a3bdf27be03da0b285e84cb71bf09eca071c3a087b42884b6982ed679eb')
+
+    def test_riscv64(self):
+        self.set_machine('virt')
+        self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
+                           rootfs_asset=self.ASSET_RISCV64_ROOTFS)
+
+    def test_riscv64_maxcpu(self):
+        self.set_machine('virt')
+        self.cpu='max'
+        self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
+                           rootfs_asset=self.ASSET_RISCV64_ROOTFS)
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


