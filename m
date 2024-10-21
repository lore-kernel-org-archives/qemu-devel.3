Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF438D0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhJ-0002Be-DW; Mon, 21 Oct 2024 07:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhA-00028T-HW
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qh8-0001iR-QX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WodJyivBnizcusThF1VuwYM8UfZBPnxBjQTblk2aN2Q=;
 b=V6ApLpj7Mwx4OZ21FpHaLq3RmPg5VQ+nDF+yFOw3I88PVileDU4qmiOPHimD+NaM6uIOrD
 z8WJIZoaVV51cglxzJNsZ6ARPYQsFzdzUZGj+FDgGST1t1/2E/DEvtZXRHpUnXX2l+rIeB
 vsR/wCqAOe+vX6RDJCAdJNzKuWkRzaM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-9nee-hURPMWazSeX3-HZVA-1; Mon,
 21 Oct 2024 07:35:26 -0400
X-MC-Unique: 9nee-hURPMWazSeX3-HZVA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E79419560AE; Mon, 21 Oct 2024 11:35:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 484D11955F42; Mon, 21 Oct 2024 11:35:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/21] tests/functional: Convert the Avocado s390x tuxrun test
Date: Mon, 21 Oct 2024 13:34:46 +0200
Message-ID: <20241021113500.122500-10-thuth@redhat.com>
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
qemu-system-s390x in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-6-thuth@redhat.com>
---
 MAINTAINERS                           |  2 +-
 tests/avocado/tuxrun_baselines.py     | 17 --------------
 tests/functional/test_s390x_tuxrun.py | 34 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 18 deletions(-)
 create mode 100755 tests/functional/test_s390x_tuxrun.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 778fb4d64b..a08beb9669 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1691,7 +1691,7 @@ S: Supported
 F: hw/s390x/
 F: include/hw/s390x/
 F: configs/devices/s390x-softmmu/default.mak
-F: tests/functional/test_s390x_ccw_virtio.py
+F: tests/functional/test_s390x_*
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index dc32735c3f..98dce857cf 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -410,23 +410,6 @@ def test_riscv64_maxcpu(self):
 
         self.common_tuxrun(csums=sums)
 
-    def test_s390(self):
-        """
-        :avocado: tags=arch:s390x
-        :avocado: tags=endian:big
-        :avocado: tags=tuxboot:s390
-        :avocado: tags=image:bzImage
-        :avocado: tags=shutdown:nowait
-        """
-        sums = { "bzImage" :
-                 "0414e98dd1c3dafff8496c9cd9c28a5f8d04553bb5ba37e906a812b48d442ef0",
-                 "rootfs.ext4.zst" :
-                 "88c37c32276677f873a25ab9ec6247895b8e3e6f8259134de2a616080b8ab3fc" }
-
-        self.common_tuxrun(csums=sums,
-                           drive="virtio-blk-ccw",
-                           haltmsg="Requesting system halt")
-
     # Note: some segfaults caused by unaligned userspace access
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
     def test_sh4(self):
diff --git a/tests/functional/test_s390x_tuxrun.py b/tests/functional/test_s390x_tuxrun.py
new file mode 100755
index 0000000000..dcab17c68b
--- /dev/null
+++ b/tests/functional/test_s390x_tuxrun.py
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
+class TuxRunS390xTest(TuxRunBaselineTest):
+
+    ASSET_S390X_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/s390/bzImage',
+        '0414e98dd1c3dafff8496c9cd9c28a5f8d04553bb5ba37e906a812b48d442ef0')
+    ASSET_S390X_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/s390/rootfs.ext4.zst',
+        '88c37c32276677f873a25ab9ec6247895b8e3e6f8259134de2a616080b8ab3fc')
+
+    def test_s390(self):
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_S390X_KERNEL,
+                           rootfs_asset=self.ASSET_S390X_ROOTFS,
+                           drive="virtio-blk-ccw",
+                           haltmsg="Requesting system halt")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


