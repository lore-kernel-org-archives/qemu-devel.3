Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8C0C369D1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPv4-0006mM-Ru; Wed, 25 Sep 2024 07:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPv2-0006eI-AC
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPuz-0003To-9K
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVYEzuB5cqmzOjLMihRhqH7KC/eEafKYByMVGtskclM=;
 b=XVkpL9LKQ1+OTO07pFX3qcFzuGKJoH+8K5o5U38Z7KaVS8oLtxQuyXZYOWBH2KIN6PLzRh
 K/dVQ06LqSkNw5+AVYryeXdV19wfJBMmXVOZ/KAhZzzsVfadhxoXLl3fwqWBLK+SsUnZdp
 yhlbB7x4iNA0FeETkIXjsCq6pFsjuCM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-Ju-PXrbgNMqGrNEtQ6pO8g-1; Wed,
 25 Sep 2024 07:10:46 -0400
X-MC-Unique: Ju-PXrbgNMqGrNEtQ6pO8g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67135193E8E8; Wed, 25 Sep 2024 11:10:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51E821956094; Wed, 25 Sep 2024 11:10:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/44] tests/functional: Convert the vexpressa9 Avocado test
Date: Wed, 25 Sep 2024 13:09:43 +0200
Message-ID: <20240925111029.24082-3-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use the new launch_kernel function to convert this test in a simple way.

Message-ID: <20240919185749.71222-3-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                           |  1 +
 tests/avocado/boot_linux_console.py   |  9 ---------
 tests/functional/meson.build          |  1 +
 tests/functional/test_arm_vexpress.py | 26 ++++++++++++++++++++++++++
 4 files changed, 28 insertions(+), 9 deletions(-)
 create mode 100755 tests/functional/test_arm_vexpress.py

diff --git a/MAINTAINERS b/MAINTAINERS
index ffacd60f40..7f7f4c2be6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1005,6 +1005,7 @@ S: Maintained
 F: hw/arm/vexpress.c
 F: hw/display/sii9022.c
 F: docs/system/arm/vexpress.rst
+F: tests/functional/test_arm_vexpress.py
 
 Versatile PB
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 6c50284986..7a776c2818 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -893,15 +893,6 @@ def do_test_advcal_2018(self, day, tar_hash, kernel_name, console=0):
         self.vm.launch()
         self.wait_for_console_pattern('QEMU advent calendar')
 
-    def test_arm_vexpressa9(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:vexpress-a9
-        """
-        tar_hash = '32b7677ce8b6f1471fb0059865f451169934245b'
-        self.vm.add_args('-dtb', self.workdir + '/day16/vexpress-v2p-ca9.dtb')
-        self.do_test_advcal_2018('16', tar_hash, 'winter.zImage')
-
     def test_arm_ast2600_debian(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8d5520349d..3fc1bb192d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -50,6 +50,7 @@ tests_arm_system_thorough = [
   'arm_canona1100',
   'arm_integratorcp',
   'arm_raspi2',
+  'arm_vexpress',
 ]
 
 tests_arm_linuxuser_thorough = [
diff --git a/tests/functional/test_arm_vexpress.py b/tests/functional/test_arm_vexpress.py
new file mode 100755
index 0000000000..cc6015112b
--- /dev/null
+++ b/tests/functional/test_arm_vexpress.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on an versatile express machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+
+class VExpressTest(LinuxKernelTest):
+
+    ASSET_DAY16 = Asset(
+        'https://www.qemu-advent-calendar.org/2018/download/day16.tar.xz',
+        '63311adb2d4c4e7a73214a86d29988add87266a909719c56acfadd026b4110a7')
+
+    def test_arm_vexpressa9(self):
+        self.set_machine('vexpress-a9')
+        file_path = self.ASSET_DAY16.fetch()
+        archive_extract(file_path, self.workdir)
+        self.launch_kernel(self.workdir + '/day16/winter.zImage',
+                           dtb=self.workdir + '/day16/vexpress-v2p-ca9.dtb',
+                           wait_for='QEMU advent calendar')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


