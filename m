Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ED4D0E6F5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhO-0002G2-N7; Mon, 21 Oct 2024 07:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhK-0002Cd-Ta
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhJ-0001jn-3E
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lud35I1KX81mwxjQf4sAPd1yuLrHdIq58NZY9Nyi2ks=;
 b=E62elXR5gdhRJbTeJ5rw2CVv0AjydeCvakT2RwWl4hPsuAoLRJ24xDBV7Gle0LWR5si6gQ
 ZnPkVasEB8yGTtU6k8rbBLoNQIS9BFBAxX0+IPc8lSQjGgeDF/687c4tVbGhCDYqts4hJi
 JmAjeAo6YB48CiSlgU5EClTXcVrLRGw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-uFQyhOFKNPmilurcr2dwkQ-1; Mon,
 21 Oct 2024 07:35:35 -0400
X-MC-Unique: uFQyhOFKNPmilurcr2dwkQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24F6B19560B1; Mon, 21 Oct 2024 11:35:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90E6D1955F42; Mon, 21 Oct 2024 11:35:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/21] tests/functional: Convert the Avocado i386 tuxrun test
Date: Mon, 21 Oct 2024 13:34:50 +0200
Message-ID: <20241021113500.122500-14-thuth@redhat.com>
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
qemu-system-i386 in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-10-thuth@redhat.com>
---
 MAINTAINERS                          |  1 +
 tests/avocado/tuxrun_baselines.py    | 16 -------------
 tests/functional/meson.build         |  4 ++++
 tests/functional/test_i386_tuxrun.py | 35 ++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 16 deletions(-)
 create mode 100755 tests/functional/test_i386_tuxrun.py

diff --git a/MAINTAINERS b/MAINTAINERS
index ed06fce067..d97eeae02b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1783,6 +1783,7 @@ F: hw/isa/apm.c
 F: include/hw/isa/apm.h
 F: tests/unit/test-x86-topo.c
 F: tests/qtest/test-x86-cpuid-compat.c
+F: tests/functional/test_i386_tuxrun.py
 F: tests/functional/test_mem_addr_space.py
 F: tests/functional/test_pc_cpu_hotplug_props.py
 F: tests/functional/test_x86_cpu_model_versions.py
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index dcb6589f2f..72b0ad4951 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -192,22 +192,6 @@ def common_tuxrun(self,
     #        --kernel https://storage.tuxboot.com/{TUXBOOT}/{IMAGE}
     #
 
-    def test_i386(self):
-        """
-        :avocado: tags=arch:i386
-        :avocado: tags=cpu:coreduo
-        :avocado: tags=machine:q35
-        :avocado: tags=tuxboot:i386
-        :avocado: tags=image:bzImage
-        :avocado: tags=shutdown:nowait
-        """
-        sums = {"bzImage" :
-                "a3e5b32a354729e65910f5a1ffcda7c14a6c12a55e8213fb86e277f1b76ed956",
-                "rootfs.ext4.zst" :
-                "f15e66b2bf673a210ec2a4b2e744a80530b36289e04f5388aab812b97f69754a" }
-
-        self.common_tuxrun(csums=sums, drive="virtio-blk-pci")
-
     def test_mips32(self):
         """
         :avocado: tags=arch:mips
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 94270c798c..9cdfa1c257 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -68,6 +68,10 @@ tests_avr_system_thorough = [
   'avr_mega2560',
 ]
 
+tests_i386_system_thorough = [
+  'i386_tuxrun',
+]
+
 tests_loongarch64_system_thorough = [
   'loongarch64_virt',
 ]
diff --git a/tests/functional/test_i386_tuxrun.py b/tests/functional/test_i386_tuxrun.py
new file mode 100755
index 0000000000..c593ffbe8c
--- /dev/null
+++ b/tests/functional/test_i386_tuxrun.py
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
+class TuxRunI386Test(TuxRunBaselineTest):
+
+    ASSET_I386_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/i386/bzImage',
+        'a3e5b32a354729e65910f5a1ffcda7c14a6c12a55e8213fb86e277f1b76ed956')
+    ASSET_I386_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/i386/rootfs.ext4.zst',
+        'f15e66b2bf673a210ec2a4b2e744a80530b36289e04f5388aab812b97f69754a')
+
+    def test_i386(self):
+        self.set_machine('q35')
+        self.cpu="coreduo"
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_I386_KERNEL,
+                           rootfs_asset=self.ASSET_I386_ROOTFS,
+                           drive="virtio-blk-pci")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


