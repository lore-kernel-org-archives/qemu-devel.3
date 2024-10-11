Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D21D0EE1E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJDQ-0000yu-Bn; Fri, 11 Oct 2024 13:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szJ7A-0003Vx-7m
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szFZI-0004MD-Cb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 09:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728652831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lz9EgXFU0lWj10nDNVRrBm6fkJnPfK29/UdEKCWZnFw=;
 b=LcpLhFJhrNeyTGcpV9NAbzgEffqbfDW+0aCNCVsAxZoXUK66CjF/AkhJDjkP2n3I7jnFpL
 uDWYC0KkqRQBCamXK+GBiio/rMcJMrOP9R4UIPh8KQntYAlFn0fYmJtPfJ52sHtNHr7Gko
 o5RKOmjSXqB0utKSn6BxKpUUfMER8zg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-FJleV-SWPbGU95I8dv1LgQ-1; Fri,
 11 Oct 2024 09:20:26 -0400
X-MC-Unique: FJleV-SWPbGU95I8dv1LgQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9531E19560B2; Fri, 11 Oct 2024 13:20:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.77])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCC7A1955E8F; Fri, 11 Oct 2024 13:20:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 07/17] tests/functional: Convert the Avocado riscv32 tuxrun
 tests
Date: Fri, 11 Oct 2024 15:19:24 +0200
Message-ID: <20241011131937.377223-8-thuth@redhat.com>
In-Reply-To: <20241011131937.377223-1-thuth@redhat.com>
References: <20241011131937.377223-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Move the tests to a new file so that they can be run via
qemu-system-riscv32 in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/tuxrun_baselines.py       | 31 --------------------
 tests/functional/meson.build            |  4 +++
 tests/functional/test_riscv32_tuxrun.py | 38 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 31 deletions(-)
 create mode 100755 tests/functional/test_riscv32_tuxrun.py

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 59ca9f9706..e84fb9c3b9 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -292,21 +292,6 @@ def test_ppc32(self):
 
         self.common_tuxrun(csums=sums, drive="virtio-blk-pci")
 
-    def test_riscv32(self):
-        """
-        :avocado: tags=arch:riscv32
-        :avocado: tags=machine:virt
-        :avocado: tags=tuxboot:riscv32
-        """
-        sums = { "Image" :
-                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
-                 "fw_jump.elf" :
-                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
-                 "rootfs.ext4.zst" :
-                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
-
-        self.common_tuxrun(csums=sums)
-
     def test_riscv64(self):
         """
         :avocado: tags=arch:riscv64
@@ -322,22 +307,6 @@ def test_riscv64(self):
 
         self.common_tuxrun(csums=sums)
 
-    def test_riscv32_maxcpu(self):
-        """
-        :avocado: tags=arch:riscv32
-        :avocado: tags=machine:virt
-        :avocado: tags=cpu:max
-        :avocado: tags=tuxboot:riscv32
-        """
-        sums = { "Image" :
-                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
-                 "fw_jump.elf" :
-                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
-                 "rootfs.ext4.zst" :
-                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
-
-        self.common_tuxrun(csums=sums)
-
     def test_riscv64_maxcpu(self):
         """
         :avocado: tags=arch:riscv64
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ae913781ec..1491b4492e 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -129,6 +129,10 @@ tests_rx_system_thorough = [
   'rx_gdbsim',
 ]
 
+tests_riscv32_system_thorough = [
+  'riscv32_tuxrun',
+]
+
 tests_s390x_system_thorough = [
   's390x_ccw_virtio',
   's390x_topology',
diff --git a/tests/functional/test_riscv32_tuxrun.py b/tests/functional/test_riscv32_tuxrun.py
new file mode 100755
index 0000000000..49b57cd428
--- /dev/null
+++ b/tests/functional/test_riscv32_tuxrun.py
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
+class TuxRunRiscV32Test(TuxRunBaselineTest):
+
+    ASSET_RISCV32_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/riscv32/Image',
+        '89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5')
+    ASSET_RISCV32_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/riscv32/rootfs.ext4.zst',
+        '7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba')
+
+    def test_riscv32(self):
+        self.set_machine('virt')
+        self.common_tuxrun(kernel_asset=self.ASSET_RISCV32_KERNEL,
+                           rootfs_asset=self.ASSET_RISCV32_ROOTFS)
+
+    def test_riscv32_maxcpu(self):
+        self.set_machine('virt')
+        self.cpu='max'
+        self.common_tuxrun(kernel_asset=self.ASSET_RISCV32_KERNEL,
+                           rootfs_asset=self.ASSET_RISCV32_ROOTFS)
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.46.1


