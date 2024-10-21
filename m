Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F46DD0E6F8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhM-0002Cv-2C; Mon, 21 Oct 2024 07:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhJ-0002By-Lp
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhH-0001jk-VP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XT2cB7WGAMZjGW51V7jm/XxHuwVLQF6R5HFCkWKf0Y=;
 b=BRIfO6Rn6fpOGFPDSfFUl0M8iqV8uPp/Vg9jYdZ/ALJNgZBGKtlnWJtuZD6Avq8XIeCncL
 TKkIM4YFUuzIAy4TZ9SGih811mRpFihFJ4Ziz9Cs6iyGgGbBgtbFDZTIuXuwLBFWIoOk+K
 y44n1Qzs4vG0sYlIDERYAkKUrc39II8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-qeIjrLgmPkCzYUdzVvnEpA-1; Mon,
 21 Oct 2024 07:35:36 -0400
X-MC-Unique: qeIjrLgmPkCzYUdzVvnEpA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9B2B1956096; Mon, 21 Oct 2024 11:35:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E2681955F42; Mon, 21 Oct 2024 11:35:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/21] tests/functional: Convert the Avocado x86_64 tuxrun test
Date: Mon, 21 Oct 2024 13:34:51 +0200
Message-ID: <20241021113500.122500-15-thuth@redhat.com>
In-Reply-To: <20241021113500.122500-1-thuth@redhat.com>
References: <20241021113500.122500-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
qemu-system-x86_64 in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-11-thuth@redhat.com>
---
 MAINTAINERS                            |  1 +
 tests/avocado/tuxrun_baselines.py      | 18 -------------
 tests/functional/meson.build           |  1 +
 tests/functional/test_x86_64_tuxrun.py | 36 ++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 18 deletions(-)
 create mode 100755 tests/functional/test_x86_64_tuxrun.py

diff --git a/MAINTAINERS b/MAINTAINERS
index d97eeae02b..1e8f77ab5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1786,6 +1786,7 @@ F: tests/qtest/test-x86-cpuid-compat.c
 F: tests/functional/test_i386_tuxrun.py
 F: tests/functional/test_mem_addr_space.py
 F: tests/functional/test_pc_cpu_hotplug_props.py
+F: tests/functional/test_x86_64_tuxrun.py
 F: tests/functional/test_x86_cpu_model_versions.py
 
 PC Chipset
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 72b0ad4951..6d00b06713 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -310,21 +310,3 @@ def test_sh4(self):
         time.sleep(0.1)
         exec_command_and_wait_for_pattern(self, 'halt',
                                           "reboot: System halted")
-
-    def test_x86_64(self):
-        """
-        :avocado: tags=arch:x86_64
-        :avocado: tags=machine:q35
-        :avocado: tags=cpu:Nehalem
-        :avocado: tags=tuxboot:x86_64
-        :avocado: tags=image:bzImage
-        :avocado: tags=root:sda
-        :avocado: tags=shutdown:nowait
-        """
-        sums = { "bzImage" :
-                 "2bc7480a669ee9b6b82500a236aba0c54233debe98cb968268fa230f52f03461",
-                 "rootfs.ext4.zst" :
-                 "b72ac729769b8f51c6dffb221113c9a063c774dbe1d66af30eb593c4e9999b4b" }
-
-        self.common_tuxrun(csums=sums,
-                           drive="driver=ide-hd,bus=ide.0,unit=0")
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 9cdfa1c257..84012810f7 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -169,6 +169,7 @@ tests_x86_64_system_quick = [
 
 tests_x86_64_system_thorough = [
   'acpi_bits',
+  'x86_64_tuxrun',
   'linux_initrd',
   'multiprocess',
   'netdev_ethtool',
diff --git a/tests/functional/test_x86_64_tuxrun.py b/tests/functional/test_x86_64_tuxrun.py
new file mode 100755
index 0000000000..4f96139871
--- /dev/null
+++ b/tests/functional/test_x86_64_tuxrun.py
@@ -0,0 +1,36 @@
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
+class TuxRunX86Test(TuxRunBaselineTest):
+
+    ASSET_X86_64_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/x86_64/bzImage',
+        '2bc7480a669ee9b6b82500a236aba0c54233debe98cb968268fa230f52f03461')
+    ASSET_X86_64_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/x86_64/rootfs.ext4.zst',
+        'b72ac729769b8f51c6dffb221113c9a063c774dbe1d66af30eb593c4e9999b4b')
+
+    def test_x86_64(self):
+        self.set_machine('q35')
+        self.cpu="Nehalem"
+        self.root='sda'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_X86_64_KERNEL,
+                           rootfs_asset=self.ASSET_X86_64_ROOTFS,
+                           drive="driver=ide-hd,bus=ide.0,unit=0")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


