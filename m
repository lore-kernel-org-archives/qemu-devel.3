Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037AFD0E6F7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhG-00029u-Vp; Mon, 21 Oct 2024 07:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qh9-00028R-Is
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qh5-0001ht-LW
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RpMPpZ7pnQTOpE70JYMwnMCCXBLxyKK7KkYNRJZhdws=;
 b=iOtSjPrDGe0E8Bqd5qrOOakMAUB4Ui59cez9R+PBecIjLQ3P5u9Pagvp3mn1AHP9HAnFIh
 9rARwOXzOePlcIOUTyKrsHawF4dPkvz/k4gb4Rx3zu990J+e5ZTVBE4ySvsWEPmBQcCWdj
 38Ss8aGv2KXtB2fgBNZ34cURXihPORs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-Deifii_cOoataunRGT5lpg-1; Mon,
 21 Oct 2024 07:35:24 -0400
X-MC-Unique: Deifii_cOoataunRGT5lpg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0B54195608F; Mon, 21 Oct 2024 11:35:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5062719560AA; Mon, 21 Oct 2024 11:35:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/21] tests/functional: Convert the Avocado sparc64 tuxrun test
Date: Mon, 21 Oct 2024 13:34:45 +0200
Message-ID: <20241021113500.122500-9-thuth@redhat.com>
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

Move the test to a new file so that it can be run via
qemu-system-sparc64 in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-5-thuth@redhat.com>
---
 MAINTAINERS                             |  1 +
 tests/avocado/tuxrun_baselines.py       | 16 ------------
 tests/functional/meson.build            |  1 +
 tests/functional/test_sparc64_tuxrun.py | 34 +++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 16 deletions(-)
 create mode 100755 tests/functional/test_sparc64_tuxrun.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f4f50711b..778fb4d64b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1664,6 +1664,7 @@ F: hw/pci-bridge/simba.c
 F: include/hw/pci-bridge/simba.h
 F: pc-bios/openbios-sparc64
 F: tests/functional/test_sparc64_sun4u.py
+F: tests/functional/test_sparc64_tuxrun.py
 
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index dffa4f6339..dc32735c3f 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -462,22 +462,6 @@ def test_sh4(self):
         exec_command_and_wait_for_pattern(self, 'halt',
                                           "reboot: System halted")
 
-    def test_sparc64(self):
-        """
-        :avocado: tags=arch:sparc64
-        :avocado: tags=tuxboot:sparc64
-        :avocado: tags=image:vmlinux
-        :avocado: tags=root:sda
-        :avocado: tags=shutdown:nowait
-        """
-
-        sums = { "rootfs.ext4.zst" :
-                 "ad2f1dc436ab51583543d25d2c210cab478645d47078d30d129a66ab0e281d76",
-                 "vmlinux" :
-                 "e34313e4325ff21deaa3d38a502aa09a373ef62b9bd4d7f8f29388b688225c55" }
-
-        self.common_tuxrun(csums=sums, drive="driver=ide-hd,bus=ide.0,unit=0")
-
     def test_x86_64(self):
         """
         :avocado: tags=arch:x86_64
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 222bfbcc62..d598f43289 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -142,6 +142,7 @@ tests_sparc_system_thorough = [
 
 tests_sparc64_system_thorough = [
   'sparc64_sun4u',
+  'sparc64_tuxrun',
 ]
 
 tests_x86_64_system_quick = [
diff --git a/tests/functional/test_sparc64_tuxrun.py b/tests/functional/test_sparc64_tuxrun.py
new file mode 100755
index 0000000000..1c2c005630
--- /dev/null
+++ b/tests/functional/test_sparc64_tuxrun.py
@@ -0,0 +1,34 @@
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
+class TuxRunSparc64Test(TuxRunBaselineTest):
+
+    ASSET_SPARC64_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/sparc64/vmlinux',
+        'e34313e4325ff21deaa3d38a502aa09a373ef62b9bd4d7f8f29388b688225c55')
+    ASSET_SPARC64_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/sparc64/rootfs.ext4.zst',
+        'ad2f1dc436ab51583543d25d2c210cab478645d47078d30d129a66ab0e281d76')
+
+    def test_sparc64(self):
+        self.root='sda'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_SPARC64_KERNEL,
+                           rootfs_asset=self.ASSET_SPARC64_ROOTFS,
+                           drive="driver=ide-hd,bus=ide.0,unit=0")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


