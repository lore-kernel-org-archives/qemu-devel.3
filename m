Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09619D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJBW-00048f-Ty; Fri, 11 Oct 2024 13:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szJ78-0001hX-Mj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szFZR-0004Ni-HF
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 09:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728652840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKbaSKgzF0euuiH9rV3sdS0N+O3fcLp7omaVV0/V7/U=;
 b=PAF+BjbXYSrnij6SbFXXgDgsMDPD3jFOTgbslXT6ACLhCXy32AoytuHHCW69zax8v7fDxF
 VA06he7HYlY6aixK9W+5MIZ5YcCUpl5O5TPvN1s2sbSMRwIbMJzNytuINQoNb4n64aBiYI
 W4DfZbQi3zzlLOuNRRAohEnTinLxn6c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-5gVXZP4HOLCtO4r1OzV9Sw-1; Fri,
 11 Oct 2024 09:20:37 -0400
X-MC-Unique: 5gVXZP4HOLCtO4r1OzV9Sw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82EBF1955F2E; Fri, 11 Oct 2024 13:20:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.77])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47A1F1955E8F; Fri, 11 Oct 2024 13:20:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 10/17] tests/functional: Convert the Avocado x86_64 tuxrun test
Date: Fri, 11 Oct 2024 15:19:27 +0200
Message-ID: <20241011131937.377223-11-thuth@redhat.com>
In-Reply-To: <20241011131937.377223-1-thuth@redhat.com>
References: <20241011131937.377223-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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
qemu-system-x86_64 in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/tuxrun_baselines.py      | 18 -------------
 tests/functional/meson.build           |  1 +
 tests/functional/test_x86_64_tuxrun.py | 36 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 18 deletions(-)
 create mode 100755 tests/functional/test_x86_64_tuxrun.py

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
2.46.1


