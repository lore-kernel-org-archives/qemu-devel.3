Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239C7C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPvE-0007KY-Ie; Wed, 25 Sep 2024 07:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPvB-0007BD-4c
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPv9-0003Uz-68
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+qZh8X5YOODyubFUBkugLUbAKVxUX51MP0XPwoFk7Y=;
 b=hASf2nHE/a2KVDeGrVvl2NLqNey+Izz5hCFWFcUb5kaUR70KonLAwJm+ZiwZQSwxQW0fUB
 dNHxf6npLCGMqCxUiw4A8RjVVNaqnxJOVMHyO1Cgv46cectNB9ajhLtmW0hsj6F0jGvie5
 bAudEhL1kMB9T5AKMprXApAKcTyK/dQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-pV2_dtsiNHuGmps_rI5xsQ-1; Wed,
 25 Sep 2024 07:10:57 -0400
X-MC-Unique: pV2_dtsiNHuGmps_rI5xsQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AF131944D41; Wed, 25 Sep 2024 11:10:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94B1D1956094; Wed, 25 Sep 2024 11:10:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 06/44] tests/functional: Convert the mac ppc Avocado tests
Date: Wed, 25 Sep 2024 13:09:47 +0200
Message-ID: <20240925111029.24082-7-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

The g3beige and mac99 tests use the same asset, so put them together
in a new test_ppc_mac.py file.

Message-ID: <20240919185749.71222-7-thuth@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                         |  2 ++
 tests/avocado/boot_linux_console.py | 30 -----------------------
 tests/functional/meson.build        |  1 +
 tests/functional/test_ppc_mac.py    | 38 +++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 30 deletions(-)
 create mode 100755 tests/functional/test_ppc_mac.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 3dd80a0138..63eb306d6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1474,6 +1474,7 @@ F: include/hw/ppc/mac_dbdma.h
 F: include/hw/pci-host/uninorth.h
 F: include/hw/input/adb*
 F: pc-bios/qemu_vga.ndrv
+F: tests/functional/test_ppc_mac.py
 
 Old World (g3beige)
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
@@ -1489,6 +1490,7 @@ F: include/hw/intc/heathrow_pic.h
 F: include/hw/input/adb*
 F: include/hw/pci-host/grackle.h
 F: pc-bios/qemu_vga.ndrv
+F: tests/functional/test_ppc_mac.py
 
 PReP
 M: Hervé Poussineau <hpoussin@reactos.org>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 344c7835a2..f5dc9e9cfa 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -965,36 +965,6 @@ def test_ppc_powernv10(self):
         """
         self.do_test_ppc64_powernv('P10')
 
-    def test_ppc_g3beige(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:g3beige
-        :avocado: tags=accel:tcg
-        """
-        # TODO: g3beige works with kvm_pr but we don't have a
-        # reliable way ATM (e.g. looking at /proc/modules) to detect
-        # whether we're running kvm_hv or kvm_pr. For now let's
-        # disable this test if we don't have TCG support.
-        self.require_accelerator("tcg")
-        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
-        self.vm.add_args('-M', 'graphics=off')
-        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
-
-    def test_ppc_mac99(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:mac99
-        :avocado: tags=accel:tcg
-        """
-        # TODO: mac99 works with kvm_pr but we don't have a
-        # reliable way ATM (e.g. looking at /proc/modules) to detect
-        # whether we're running kvm_hv or kvm_pr. For now let's
-        # disable this test if we don't have TCG support.
-        self.require_accelerator("tcg")
-        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
-        self.vm.add_args('-M', 'graphics=off')
-        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
-
     # This test has a 6-10% failure rate on various hosts that look
     # like issues with a buggy kernel. As a result we don't want it
     # gating releases on Gitlab.
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index bc33332313..449c6a95ea 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -106,6 +106,7 @@ tests_ppc_system_thorough = [
   'ppc_40p',
   'ppc_amiga',
   'ppc_bamboo',
+  'ppc_mac',
   'ppc_mpc8544ds',
   'ppc_virtex_ml507',
 ]
diff --git a/tests/functional/test_ppc_mac.py b/tests/functional/test_ppc_mac.py
new file mode 100755
index 0000000000..a6b1ca2d4c
--- /dev/null
+++ b/tests/functional/test_ppc_mac.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+#
+# Boot Linux kernel on a mac99 and g3beige ppc machine and check the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+
+class MacTest(LinuxKernelTest):
+
+    ASSET_DAY15 = Asset(
+        'https://www.qemu-advent-calendar.org/2018/download/day15.tar.xz',
+        '03e0757c131d2959decf293a3572d3b96c5a53587165bf05ce41b2818a2bccd5')
+
+    def do_day15_test(self):
+        # mac99 also works with kvm_pr but we don't have a reliable way at
+        # the moment (e.g. by looking at /proc/modules) to detect whether
+        # we're running kvm_hv or kvm_pr. For now let's disable this test
+        # if we don't have TCG support.
+        self.require_accelerator("tcg")
+
+        file_path = self.ASSET_DAY15.fetch()
+        archive_extract(file_path, self.workdir)
+        self.vm.add_args('-M', 'graphics=off')
+        self.launch_kernel(self.workdir + '/day15/invaders.elf',
+                           wait_for='QEMU advent calendar')
+
+    def test_ppc_g3beige(self):
+        self.set_machine('g3beige')
+        self.do_day15_test()
+
+    def test_ppc_mac99(self):
+        self.set_machine('mac99')
+        self.do_day15_test()
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


