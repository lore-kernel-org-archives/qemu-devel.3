Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217A1D0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhU-0002dp-9z; Mon, 21 Oct 2024 07:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhR-0002Wk-Pc
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhL-0001kQ-Jx
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OIqKW7e8nNDKfVc6m/7aPzAn26FUoBGYbYOGDz6K1g=;
 b=WmoEslkx14Q6+m3vrbw1/l3ykWYGHbQIVTyfm6eC9mtBF2lJVaHrZvTnJSRFQvZZtG3/Xj
 uDDbbmN9qZ4zLyBz5gpL6Ny0lXxZaZJSItXiWnSi3RVLlKcqWZw8v83jrWd7EcHDzlzaPB
 dPatQjltEb2CJxaGNqBYLrTFE65e8Es=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-a8bfnBVqNdS-ecrvolWvtA-1; Mon,
 21 Oct 2024 07:35:41 -0400
X-MC-Unique: a8bfnBVqNdS-ecrvolWvtA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86ECC195608F; Mon, 21 Oct 2024 11:35:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0241919560AA; Mon, 21 Oct 2024 11:35:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/21] tests/functional: Convert the Avocado mipsel tuxrun test
Date: Mon, 21 Oct 2024 13:34:53 +0200
Message-ID: <20241021113500.122500-17-thuth@redhat.com>
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

Move the test into a new file so that it can be run via
qemu-system-mipsel in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-13-thuth@redhat.com>
---
 tests/avocado/tuxrun_baselines.py      | 17 ------------
 tests/functional/meson.build           |  1 +
 tests/functional/test_mipsel_tuxrun.py | 36 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 17 deletions(-)
 create mode 100755 tests/functional/test_mipsel_tuxrun.py

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 8593d204b7..d45c2ce35e 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -192,23 +192,6 @@ def common_tuxrun(self,
     #        --kernel https://storage.tuxboot.com/{TUXBOOT}/{IMAGE}
     #
 
-    def test_mips32el(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=cpu:mips32r6-generic
-        :avocado: tags=tuxboot:mips32el
-        :avocado: tags=image:vmlinux
-        :avocado: tags=root:sda
-        :avocado: tags=shutdown:nowait
-        """
-        sums = { "rootfs.ext4.zst" :
-                 "e799768e289fd69209c21f4dacffa11baea7543d5db101e8ce27e3bc2c41d90e",
-                 "vmlinux" :
-                 "8573867c68a8443db8de6d08bb33fb291c189ca2ca671471d3973a3e712096a3" }
-
-        self.common_tuxrun(csums=sums, drive="driver=ide-hd,bus=ide.0,unit=0")
-
     def test_mips64(self):
         """
         :avocado: tags=arch:mips64
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 4a78c5f8b6..813237e412 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -97,6 +97,7 @@ tests_mips_system_thorough = [
 
 tests_mipsel_system_thorough = [
   'mipsel_malta',
+  'mipsel_tuxrun',
 ]
 
 tests_mips64el_system_thorough = [
diff --git a/tests/functional/test_mipsel_tuxrun.py b/tests/functional/test_mipsel_tuxrun.py
new file mode 100755
index 0000000000..2965bbd913
--- /dev/null
+++ b/tests/functional/test_mipsel_tuxrun.py
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
+class TuxRunMipsELTest(TuxRunBaselineTest):
+
+    ASSET_MIPSEL_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/mips32el/vmlinux',
+        '8573867c68a8443db8de6d08bb33fb291c189ca2ca671471d3973a3e712096a3')
+    ASSET_MIPSEL_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/mips32el/rootfs.ext4.zst',
+        'e799768e289fd69209c21f4dacffa11baea7543d5db101e8ce27e3bc2c41d90e')
+
+    def test_mips32el(self):
+        self.set_machine('malta')
+        self.cpu="mips32r6-generic"
+        self.root="sda"
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_MIPSEL_KERNEL,
+                           rootfs_asset=self.ASSET_MIPSEL_ROOTFS,
+                           drive="driver=ide-hd,bus=ide.0,unit=0")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


