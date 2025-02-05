Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896C9C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 16:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfhox-0006pz-8d; Wed, 05 Feb 2025 11:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfhov-0006ph-Qa
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:00:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfhos-0001Xu-9B
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738771205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dL8Z/bhkQjotEMwlHIYSRAsV8q1dl/IpscxL1xN+G9A=;
 b=b3tr8279cmqO8/XaHPfIYQTIv7GLrh7M4r2RKpIxDN4TMALiAQCqmNZMreVrAijoyyIygj
 OtKX1hVKz7ky4s9g+Y5kV29yEbqWZVWrnJvlCYpak5CTIQttffZcUsLIOGNFOgnZCEObbu
 n97XQbMLSn5yqwDf/PrtL9kz+fTcERw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-LDAeOsESOduXAKajJTRhHQ-1; Wed,
 05 Feb 2025 11:00:04 -0500
X-MC-Unique: LDAeOsESOduXAKajJTRhHQ-1
X-Mimecast-MFC-AGG-ID: LDAeOsESOduXAKajJTRhHQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E916718011E6; Wed,  5 Feb 2025 16:00:02 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7908195608D; Wed,  5 Feb 2025 16:00:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] tests/functional: skip mem addr test on 32-bit hosts
Date: Wed,  5 Feb 2025 15:59:46 +0000
Message-ID: <20250205155946.2811296-6-berrange@redhat.com>
In-Reply-To: <20250205155946.2811296-1-berrange@redhat.com>
References: <20250205155946.2811296-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The test_mem_addr_space is validating handling of QEMU with various
memory address settings. All of the test cases are setting 'maxmem'
to a value that exceeds the 32-bit address space, so these must all
be skipped on 32-bit hosts.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/decorators.py | 12 ++++++++++++
 tests/functional/test_mem_addr_space.py  | 17 ++++++++++++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 5c972843a6..7a90311891 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -15,6 +15,6 @@
 from .linuxkernel import LinuxKernelTest
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
     skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
-    skipIfMissingImports
+    skipIfMissingImports, skipIf32BitTarget
 from .archive import archive_extract
 from .uncompress import uncompress
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index 1651eb739a..d3a8cf0483 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -5,6 +5,7 @@
 import importlib
 import os
 import platform
+import sys
 from unittest import skipUnless
 
 from .cmd import which
@@ -118,3 +119,14 @@ def skipIfMissingImports(*args):
 
     return skipUnless(has_imports, 'required import(s) "%s" not installed' %
                                    ", ".join(args))
+
+'''
+Decorator to skip execution of a test on 32-bit targets
+Example:
+
+  @skipIf32BitTarget()
+'''
+def skipIf32BitTarget():
+    enoughBits = sys.maxsize > 2**32
+    return skipUnless(enoughBits,
+                      'Test requires a host with 64-bit address space')
diff --git a/tests/functional/test_mem_addr_space.py b/tests/functional/test_mem_addr_space.py
index bb0cf062ca..3e0215beb3 100755
--- a/tests/functional/test_mem_addr_space.py
+++ b/tests/functional/test_mem_addr_space.py
@@ -10,7 +10,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import QemuSystemTest
+from qemu_test import QemuSystemTest, skipIf32BitTarget
 import time
 
 class MemAddrCheck(QemuSystemTest):
@@ -22,6 +22,7 @@ class MemAddrCheck(QemuSystemTest):
 
     # first, lets test some 32-bit processors.
     # for all 32-bit cases, pci64_hole_size is 0.
+    @skipIf32BitTarget()
     def test_phybits_low_pse36(self):
         """
         With pse36 feature ON, a processor has 36 bits of addressing. So it can
@@ -49,6 +50,7 @@ def test_phybits_low_pse36(self):
         self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_low_pae(self):
         """
         With pae feature ON, a processor has 36 bits of addressing. So it can
@@ -66,6 +68,7 @@ def test_phybits_low_pae(self):
         self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_ok_pentium_pse36(self):
         """
         Setting maxmem to 59.5G and making sure that QEMU can start with the
@@ -82,6 +85,7 @@ def test_phybits_ok_pentium_pse36(self):
         self.vm.shutdown()
         self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_ok_pentium_pae(self):
         """
         Test is same as above but now with pae cpu feature turned on.
@@ -99,6 +103,7 @@ def test_phybits_ok_pentium_pae(self):
         self.vm.shutdown()
         self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_ok_pentium2(self):
         """
         Pentium2 has 36 bits of addressing, so its same as pentium
@@ -115,6 +120,7 @@ def test_phybits_ok_pentium2(self):
         self.vm.shutdown()
         self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_low_nonpse36(self):
         """
         Pentium processor has 32 bits of addressing without pse36 or pae
@@ -135,6 +141,7 @@ def test_phybits_low_nonpse36(self):
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
     # now lets test some 64-bit CPU cases.
+    @skipIf32BitTarget()
     def test_phybits_low_tcg_q35_70_amd(self):
         """
         For q35 7.1 machines and above, there is a HT window that starts at
@@ -161,6 +168,7 @@ def test_phybits_low_tcg_q35_70_amd(self):
         self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_low_tcg_q35_71_amd(self):
         """
         AMD_HT_START is defined to be at 1012 GiB. So for q35 machines
@@ -181,6 +189,7 @@ def test_phybits_low_tcg_q35_71_amd(self):
         self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_ok_tcg_q35_70_amd(self):
         """
         Same as q35-7.0 AMD case except that here we check that QEMU can
@@ -197,6 +206,7 @@ def test_phybits_ok_tcg_q35_70_amd(self):
         self.vm.shutdown()
         self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_ok_tcg_q35_71_amd(self):
         """
         Same as q35-7.1 AMD case except that here we check that QEMU can
@@ -213,6 +223,7 @@ def test_phybits_ok_tcg_q35_71_amd(self):
         self.vm.shutdown()
         self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_ok_tcg_q35_71_intel(self):
         """
         Same parameters as test_phybits_low_tcg_q35_71_amd() but use
@@ -231,6 +242,7 @@ def test_phybits_ok_tcg_q35_71_intel(self):
         self.vm.shutdown()
         self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_low_tcg_q35_71_amd_41bits(self):
         """
         AMD processor with 41 bits. Max cpu hw address = 2 TiB.
@@ -255,6 +267,7 @@ def test_phybits_low_tcg_q35_71_amd_41bits(self):
         self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_ok_tcg_q35_71_amd_41bits(self):
         """
         AMD processor with 41 bits. Max cpu hw address = 2 TiB.
@@ -273,6 +286,7 @@ def test_phybits_ok_tcg_q35_71_amd_41bits(self):
         self.vm.shutdown()
         self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_low_tcg_q35_intel_cxl(self):
         """
         cxl memory window starts after memory device range. Here, we use 1 GiB
@@ -293,6 +307,7 @@ def test_phybits_low_tcg_q35_intel_cxl(self):
         self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
+    @skipIf32BitTarget()
     def test_phybits_ok_tcg_q35_intel_cxl(self):
         """
         Same as above but here we do not reserve any cxl memory window. Hence,
-- 
2.47.1


