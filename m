Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE83C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqH6-0008JX-HU; Tue, 30 Jul 2024 13:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqGz-0007vc-FU
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqGx-0002Os-Mp
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kf5PvJVoJdlSza/F8opy8B526MhxUoz+qgt0S2d6tN0=;
 b=Vigyfw+MX23VSsu+wDddwwZYzG7tJO+spvZewbgU05xk6p4NeiEDq0HCV+36A3xqD1X5bc
 6dEaZ2IjFn+rlJjv3w2B1ND1QROE8Hrutg5JrGT2RwWEQsp8J5KMGcrPUOHzIXSzuiuR/v
 HqQKx3Dp80vq4VuPNOS7u8GoLZPpbWQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-HEDQeAO7MtuG2rZIVXX_5w-1; Tue,
 30 Jul 2024 13:04:22 -0400
X-MC-Unique: HEDQeAO7MtuG2rZIVXX_5w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7310319560A2; Tue, 30 Jul 2024 17:04:21 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 035B43000192; Tue, 30 Jul 2024 17:04:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 07/24] tests/functional: Convert avocado tests that just
 need a small adjustment
Date: Tue, 30 Jul 2024 18:03:27 +0100
Message-ID: <20240730170347.4103919-8-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Thomas Huth <thuth@redhat.com>

These simple tests can be converted to stand-alone tests quite easily,
e.g. by just setting the machine to 'none' now manually or by adding
"-cpu" command line parameters, since we don't support the corresponding
avocado tags in the new python test framework.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                  |  6 ++
 .../test_info_usernet.py}                     | 11 ++-
 .../test_ppc_74xx.py}                         | 74 ++++++++-----------
 .../version.py => functional/test_version.py} | 13 ++--
 4 files changed, 53 insertions(+), 51 deletions(-)
 rename tests/{avocado/info_usernet.py => functional/test_info_usernet.py} (87%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_74xx.py => functional/test_ppc_74xx.py} (74%)
 mode change 100644 => 100755
 rename tests/{avocado/version.py => functional/test_version.py} (78%)
 mode change 100644 => 100755

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index a8cc0e6330..8a8fa0ab99 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -15,6 +15,12 @@ test_timeouts = {
 
 tests_generic = [
   'empty_cpu_model',
+  'info_usernet',
+  'version',
+]
+
+tests_ppc_quick = [
+  'ppc_74xx',
 ]
 
 tests_x86_64_quick = [
diff --git a/tests/avocado/info_usernet.py b/tests/functional/test_info_usernet.py
old mode 100644
new mode 100755
similarity index 87%
rename from tests/avocado/info_usernet.py
rename to tests/functional/test_info_usernet.py
index e1aa7a6e0a..ded973253a
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
+        self.machine = 'none'
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
index c6139568a1..5e566d76b1
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
+        self.machine = 'none'
         self.vm.add_args('-nodefaults')
         self.vm.launch()
         res = self.vm.cmd('human-monitor-command',
                           command_line='info version')
         self.assertRegex(res, r'^(\d+\.\d+\.\d)')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


