Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA559D0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJCc-0006ub-RP; Fri, 11 Oct 2024 13:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szJ77-0003Vx-HS
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:07:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szFZl-0004UB-St
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 09:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728652861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDg0vyitJ62VONBC0A96zp3mijsQBxH/c04ECt3WkC4=;
 b=Qo4q3Bup96hzXs+AYoTSCYFKraPo8R8HfS/rz8UgG357NBqSmooI7Jdu0aalOCWKrnAdHw
 34S4q7A/JinDrB/2rZhcCru4hVqPhfmog/XOSMEloz0v8Y7apFjdOsRo5eTK+EIIeddilL
 rJ8ZkhDxAii7GClzIk7I8x6E/Ar7nAU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-G9cPMQ_5MCup-BXHkjGH_Q-1; Fri,
 11 Oct 2024 09:20:57 -0400
X-MC-Unique: G9cPMQ_5MCup-BXHkjGH_Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9837B1955F45; Fri, 11 Oct 2024 13:20:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.77])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88F4D1956052; Fri, 11 Oct 2024 13:20:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 15/17] tests/functional: Convert the Avocado ppc32 tuxrun test
Date: Fri, 11 Oct 2024 15:19:32 +0200
Message-ID: <20241011131937.377223-16-thuth@redhat.com>
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

Move the test into a new file so that it can be run via
qemu-system-ppc in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/tuxrun_baselines.py   | 16 -------------
 tests/functional/meson.build        |  1 +
 tests/functional/test_ppc_tuxrun.py | 35 +++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 16 deletions(-)
 create mode 100755 tests/functional/test_ppc_tuxrun.py

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 18dc7ddaab..c358095e1f 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -192,22 +192,6 @@ def common_tuxrun(self,
     #        --kernel https://storage.tuxboot.com/{TUXBOOT}/{IMAGE}
     #
 
-    def test_ppc32(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:ppce500
-        :avocado: tags=cpu:e500mc
-        :avocado: tags=tuxboot:ppc32
-        :avocado: tags=image:uImage
-        :avocado: tags=shutdown:nowait
-        """
-        sums = { "rootfs.ext4.zst" :
-                 "8885b9d999cc24d679542a02e9b6aaf48f718f2050ece6b8347074b6ee41dd09",
-                 "uImage" :
-                 "1a68f74b860fda022fb12e03c5efece8c2b8b590d96cca37a8481a3ae0b3f81f" }
-
-        self.common_tuxrun(csums=sums, drive="virtio-blk-pci")
-
     # Note: some segfaults caused by unaligned userspace access
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
     def test_sh4(self):
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 48445edfab..c17c9b0700 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -126,6 +126,7 @@ tests_ppc_system_thorough = [
   'ppc_bamboo',
   'ppc_mac',
   'ppc_mpc8544ds',
+  'ppc_tuxrun',
   'ppc_virtex_ml507',
 ]
 
diff --git a/tests/functional/test_ppc_tuxrun.py b/tests/functional/test_ppc_tuxrun.py
new file mode 100755
index 0000000000..50b76946c4
--- /dev/null
+++ b/tests/functional/test_ppc_tuxrun.py
@@ -0,0 +1,35 @@
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
+class TuxRunPPC32Test(TuxRunBaselineTest):
+
+    ASSET_PPC32_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/ppc32/uImage',
+        '1a68f74b860fda022fb12e03c5efece8c2b8b590d96cca37a8481a3ae0b3f81f')
+    ASSET_PPC32_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/ppc32/rootfs.ext4.zst',
+        '8885b9d999cc24d679542a02e9b6aaf48f718f2050ece6b8347074b6ee41dd09')
+
+    def test_ppc32(self):
+        self.set_machine('ppce500')
+        self.cpu='e500mc'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_PPC32_KERNEL,
+                           rootfs_asset=self.ASSET_PPC32_ROOTFS,
+                           drive="virtio-blk-pci")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.46.1


