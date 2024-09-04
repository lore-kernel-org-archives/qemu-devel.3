Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB940CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnQt-0002Et-Vh; Wed, 04 Sep 2024 06:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQs-00029Y-K0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQq-0000Gh-HX
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCBapF9vzu117nF852AijK/jkG4aupXmCpmEI8JnxsM=;
 b=Nq7M0z2/V85OX4OruOx5TdC8BGagyW808u5y+3oc9e7QJKvABzCKfYD7jXHXVu6QlkHeF3
 ZScp9KU7LDSWdZiYTDPaHY7eBdnYz5Wu+PpFIDPaabfK8NRxhEe9i0M43wPQzXKWPRFb4t
 ElVN0P5VV2bErZVMeHjiiU9JgzM6Ivw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-ZQrKXp6aMTyNjcxo_rqZbw-1; Wed,
 04 Sep 2024 06:40:08 -0400
X-MC-Unique: ZQrKXp6aMTyNjcxo_rqZbw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF7BB1956048; Wed,  4 Sep 2024 10:40:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E658195605A; Wed,  4 Sep 2024 10:40:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/42] tests/functional: Convert avocado tests that just need a
 small adjustment
Date: Wed,  4 Sep 2024 12:38:48 +0200
Message-ID: <20240904103923.451847-14-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

These simple tests can be converted to stand-alone tests quite easily,
e.g. by just setting the machine to 'none' now manually or by adding
"-cpu" command line parameters, since we don't support the corresponding
avocado tags in the new python test framework.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240830133841.142644-14-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  3 +
 tests/functional/meson.build                  |  6 ++
 .../test_info_usernet.py}                     | 11 ++-
 .../test_ppc_74xx.py}                         | 74 ++++++++-----------
 .../version.py => functional/test_version.py} | 13 ++--
 5 files changed, 56 insertions(+), 51 deletions(-)
 rename tests/{avocado/info_usernet.py => functional/test_info_usernet.py} (87%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_74xx.py => functional/test_ppc_74xx.py} (74%)
 mode change 100644 => 100755
 rename tests/{avocado/version.py => functional/test_version.py} (78%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index b3a0ac0e8b..4912f8d0da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -318,6 +318,7 @@ F: configs/devices/ppc*
 F: docs/system/ppc/embedded.rst
 F: docs/system/target-ppc.rst
 F: tests/tcg/ppc*/*
+F: tests/functional/test_ppc_74xx.py
 
 RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
@@ -2107,6 +2108,7 @@ S: Odd Fixes
 F: hw/net/
 F: include/hw/net/
 F: tests/qtest/virtio-net-test.c
+F: tests/functional/test_info_usernet.py
 F: docs/virtio-net-failover.rst
 T: git https://github.com/jasowang/qemu.git net
 
@@ -2976,6 +2978,7 @@ S: Supported
 F: include/qemu/option.h
 F: tests/unit/test-keyval.c
 F: tests/unit/test-qemu-opts.c
+F: tests/functional/test_version.py
 F: util/keyval.c
 F: util/qemu-option.c
 
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 91201a2e26..f1f344f860 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -15,6 +15,12 @@ test_timeouts = {
 
 tests_generic_system = [
   'empty_cpu_model',
+  'info_usernet',
+  'version',
+]
+
+tests_ppc_quick = [
+  'ppc_74xx',
 ]
 
 tests_generic_linuxuser = [
diff --git a/tests/avocado/info_usernet.py b/tests/functional/test_info_usernet.py
old mode 100644
new mode 100755
similarity index 87%
rename from tests/avocado/info_usernet.py
rename to tests/functional/test_info_usernet.py
index e1aa7a6e0a..cd37524d94
--- a/tests/avocado/info_usernet.py
+++ b/tests/functional/test_info_usernet.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test for the hmp command "info usernet"
 #
 # Copyright (c) 2021 Red Hat, Inc.
@@ -8,18 +10,16 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest
 
 from qemu.utils import get_info_usernet_hostfwd_port
 
 
 class InfoUsernet(QemuSystemTest):
-    """
-    :avocado: tags=machine:none
-    """
 
     def test_hostfwd(self):
         self.require_netdev('user')
+        self.set_machine('none')
         self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22')
         self.vm.launch()
         res = self.vm.cmd('human-monitor-command',
@@ -31,3 +31,6 @@ def test_hostfwd(self):
         self.assertGreater(port, 0,
                            ('Found a redirected port that is not greater than'
                             ' zero'))
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/ppc_74xx.py b/tests/functional/test_ppc_74xx.py
old mode 100644
new mode 100755
similarity index 74%
rename from tests/avocado/ppc_74xx.py
rename to tests/functional/test_ppc_74xx.py
index f54757c243..5386016f26
--- a/tests/avocado/ppc_74xx.py
+++ b/tests/functional/test_ppc_74xx.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Smoke tests for 74xx cpus (aka G4).
 #
 # Copyright (c) 2021, IBM Corp.
@@ -5,132 +7,120 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
 
 class ppc74xxCpu(QemuSystemTest):
-    """
-    :avocado: tags=arch:ppc
-    :avocado: tags=accel:tcg
-    """
+
     timeout = 5
 
     def test_ppc_7400(self):
-        """
-        :avocado: tags=cpu:7400
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7400')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7410(self):
-        """
-        :avocado: tags=cpu:7410
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7410')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,74xx')
 
     def test_ppc_7441(self):
-        """
-        :avocado: tags=cpu:7441
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7441')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7445(self):
-        """
-        :avocado: tags=cpu:7445
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7445')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7447(self):
-        """
-        :avocado: tags=cpu:7447
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7447')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7447a(self):
-        """
-        :avocado: tags=cpu:7447a
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7447a')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7448(self):
-        """
-        :avocado: tags=cpu:7448
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7448')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,MPC86xx')
 
     def test_ppc_7450(self):
-        """
-        :avocado: tags=cpu:7450
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7450')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7451(self):
-        """
-        :avocado: tags=cpu:7451
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7451')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7455(self):
-        """
-        :avocado: tags=cpu:7455
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7455')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7457(self):
-        """
-        :avocado: tags=cpu:7457
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7457')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7457a(self):
-        """
-        :avocado: tags=cpu:7457a
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7457a')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/version.py b/tests/functional/test_version.py
old mode 100644
new mode 100755
similarity index 78%
rename from tests/avocado/version.py
rename to tests/functional/test_version.py
index c6139568a1..3ab3b67f7e
--- a/tests/avocado/version.py
+++ b/tests/functional/test_version.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Version check example test
 #
 # Copyright (c) 2018 Red Hat, Inc.
@@ -9,17 +11,18 @@
 # later.  See the COPYING file in the top-level directory.
 
 
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest
 
 
 class Version(QemuSystemTest):
-    """
-    :avocado: tags=quick
-    :avocado: tags=machine:none
-    """
+
     def test_qmp_human_info_version(self):
+        self.set_machine('none')
         self.vm.add_args('-nodefaults')
         self.vm.launch()
         res = self.vm.cmd('human-monitor-command',
                           command_line='info version')
         self.assertRegex(res, r'^(\d+\.\d+\.\d)')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


