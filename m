Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D800ED0E6F8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhj-0002ow-Kr; Mon, 21 Oct 2024 07:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhT-0002cW-J0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhR-0001l4-Sl
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbzxD91CCBo5/JiF/A4EcwzHeb9RrnGWP/YQ07vRwyw=;
 b=H/6nXZfCPXlmDtxhVA3HwImvgFUHOhZuWGvzmoyD+NYn6LoZHz+RHh4zzJYJxEgaKby9WD
 oMi2WvD7cbtql+Rys9Nnda5p10S3xKTgGjf/MbSP5wlMIuMD/xClcugCzuUyN1VNmSCy1W
 ZfLAcUUHbA8neIPH+e8/8oLSyiZ7LLo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-idAvIawNMdurdo2O88nxVw-1; Mon,
 21 Oct 2024 07:35:45 -0400
X-MC-Unique: idAvIawNMdurdo2O88nxVw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A330D19560A2; Mon, 21 Oct 2024 11:35:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 656D419560AA; Mon, 21 Oct 2024 11:35:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 18/21] tests/functional: Convert the Avocado mips64el tuxrun
 test
Date: Mon, 21 Oct 2024 13:34:55 +0200
Message-ID: <20241021113500.122500-19-thuth@redhat.com>
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
qemu-system-mips64el in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-15-thuth@redhat.com>
---
 MAINTAINERS                              |  5 ++--
 tests/avocado/tuxrun_baselines.py        | 16 -----------
 tests/functional/meson.build             |  1 +
 tests/functional/test_mips64el_tuxrun.py | 35 ++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 19 deletions(-)
 create mode 100755 tests/functional/test_mips64el_tuxrun.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e8f77ab5d..2ec6724aff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1313,9 +1313,8 @@ F: hw/mips/malta.c
 F: hw/pci-host/gt64120.c
 F: include/hw/southbridge/piix.h
 F: tests/avocado/linux_ssh_mips_malta.py
-F: tests/functional/test_mips_malta.py
-F: tests/functional/test_mipsel_malta.py
-F: tests/functional/test_mips64el_malta.py
+F: tests/functional/test_mips*_malta.py
+F: tests/functional/test_mips*_tuxrun.py
 
 Mipssim
 R: Aleksandar Rikalo <arikalo@gmail.com>
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index e0e6a56067..18dc7ddaab 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -192,22 +192,6 @@ def common_tuxrun(self,
     #        --kernel https://storage.tuxboot.com/{TUXBOOT}/{IMAGE}
     #
 
-    def test_mips64el(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=tuxboot:mips64el
-        :avocado: tags=image:vmlinux
-        :avocado: tags=root:sda
-        :avocado: tags=shutdown:nowait
-        """
-        sums = { "rootfs.ext4.zst" :
-                 "fba585368f5915b1498ed081863474b2d7ec4e97cdd46d21bdcb2f9698f83de4",
-                 "vmlinux" :
-                 "d4e08965e2155c4cccce7c5f34d18fe34c636cda2f2c9844387d614950155266" }
-
-        self.common_tuxrun(csums=sums, drive="driver=ide-hd,bus=ide.0,unit=0")
-
     def test_ppc32(self):
         """
         :avocado: tags=arch:ppc
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index eef48edf52..48445edfab 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -108,6 +108,7 @@ tests_mips64el_system_thorough = [
   'mips64el_fuloong2e',
   'mips64el_loongson3v',
   'mips64el_malta',
+  'mips64el_tuxrun',
 ]
 
 tests_or1k_system_thorough = [
diff --git a/tests/functional/test_mips64el_tuxrun.py b/tests/functional/test_mips64el_tuxrun.py
new file mode 100755
index 0000000000..819549a27b
--- /dev/null
+++ b/tests/functional/test_mips64el_tuxrun.py
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
+class TuxRunMips64ELTest(TuxRunBaselineTest):
+
+    ASSET_MIPS64EL_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/mips64el/vmlinux',
+        'd4e08965e2155c4cccce7c5f34d18fe34c636cda2f2c9844387d614950155266')
+    ASSET_MIPS64EL_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/mips64el/rootfs.ext4.zst',
+        'fba585368f5915b1498ed081863474b2d7ec4e97cdd46d21bdcb2f9698f83de4')
+
+    def test_mips64el(self):
+        self.set_machine('malta')
+        self.root="sda"
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_MIPS64EL_KERNEL,
+                           rootfs_asset=self.ASSET_MIPS64EL_ROOTFS,
+                           drive="driver=ide-hd,bus=ide.0,unit=0")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


