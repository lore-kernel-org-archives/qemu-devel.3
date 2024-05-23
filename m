Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA20C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 18:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADLx-0005MN-Rv; Thu, 23 May 2024 14:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sADLw-0005M5-5z; Thu, 23 May 2024 14:39:48 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sADLu-0006U4-9D; Thu, 23 May 2024 14:39:47 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 90335260CC8;
 Thu, 23 May 2024 20:39:41 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id DPU9NPduMJWQ; Thu, 23 May 2024 20:39:39 +0200 (CEST)
Received: from applejack.lan (83.11.37.15.ipv4.supernova.orange.pl
 [83.11.37.15])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 1D0C326073E;
 Thu, 23 May 2024 20:39:38 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH 1/1] tests/avocado: sbsa-ref: switch from OpenBSD to FreeBSD
Date: Thu, 23 May 2024 20:39:28 +0200
Message-ID: <20240523183928.37809-1-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

FreeBSD has longer support cycle for stable release (14.x EoL in 2028)
than OpenBSD (7.3 we used is already EoL). Also bugfixes are backported
so we can stay on 14.x for longer.

Planned to upgrade to newer OpenBSD but we would have to wait for 7.6
release to get Neoverse-V1/N2 support.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 65 ++++++++++++++++--------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 98c76c1ff7..c3c7c0e639 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -1,4 +1,4 @@
-# Functional test that boots a Linux kernel and checks the console
+# Functional test that boots a kernel and checks the console
 #
 # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
 # SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
@@ -177,14 +177,14 @@ def test_sbsaref_alpine_linux_max(self):
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
-    def boot_openbsd73(self, cpu):
+    def boot_freebsd14(self, cpu):
         self.fetch_firmware()
 
         img_url = (
-            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img"
+            "https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.0/FreeBSD-14.0-RELEASE-arm64-aarch64-bootonly.iso"
         )
 
-        img_hash = "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5"
+        img_hash = "2f3ceb0ef6b1de53553abb9979a6d65f51b006dbfa985798b282812ecb758c1b"
         img_path = self.fetch_asset(img_url, algorithm="sha256", asset_hash=img_hash)
 
         self.vm.set_console()
@@ -196,43 +196,64 @@ def boot_openbsd73(self, cpu):
         )
 
         self.vm.launch()
-        wait_for_console_pattern(self,
-                                 "Welcome to the OpenBSD/arm64"
-                                 " 7.3 installation program.")
+        wait_for_console_pattern(self, "Welcome to FreeBSD!")
 
-    def test_sbsaref_openbsd73_cortex_a57(self):
+    def test_sbsaref_freebsd14_cortex_a57(self):
         """
         :avocado: tags=cpu:cortex-a57
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("cortex-a57")
+        self.boot_freebsd14("cortex-a57")
 
-    def test_sbsaref_openbsd73_neoverse_n1(self):
+    def test_sbsaref_freebsd14_neoverse_n1(self):
         """
         :avocado: tags=cpu:neoverse-n1
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("neoverse-n1")
+        self.boot_freebsd14("neoverse-n1")
 
-    def test_sbsaref_openbsd73_max_pauth_off(self):
+    def test_sbsaref_freebsd14_neoverse_n2_pauth_off(self):
+        """
+        :avocado: tags=cpu:neoverse-n2
+        :avocado: tags=os:freebsd
+        """
+        self.boot_freebsd14("neoverse-n2,pauth=off")
+
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    def test_sbsaref_freebsd14_neoverse_n2_pauth_impdef(self):
+        """
+        :avocado: tags=cpu:neoverse-n2
+        :avocado: tags=os:freebsd
+        """
+        self.boot_freebsd14("neoverse-n2,pauth-impdef=on")
+
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    def test_sbsaref_freebsd14_neoverse_n2(self):
+        """
+        :avocado: tags=cpu:neoverse-n2
+        :avocado: tags=os:freebsd
+        """
+        self.boot_freebsd14("neoverse-n2")
+
+    def test_sbsaref_freebsd14_max_pauth_off(self):
         """
         :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("max,pauth=off")
+        self.boot_freebsd14("max,pauth=off")
 
     @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-    def test_sbsaref_openbsd73_max_pauth_impdef(self):
+    def test_sbsaref_freebsd14_max_pauth_impdef(self):
         """
         :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("max,pauth-impdef=on")
+        self.boot_freebsd14("max,pauth-impdef=on")
 
     @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-    def test_sbsaref_openbsd73_max(self):
+    def test_sbsaref_freebsd14_max(self):
         """
         :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("max")
+        self.boot_freebsd14("max")
-- 
2.45.1


