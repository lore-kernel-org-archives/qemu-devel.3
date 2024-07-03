Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EEBC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0dd-0001pv-7W; Wed, 03 Jul 2024 10:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sP0dK-0001lb-52; Wed, 03 Jul 2024 10:06:56 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sP0d1-0008Qr-1j; Wed, 03 Jul 2024 10:06:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 602F926018B;
 Wed,  3 Jul 2024 16:06:29 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PtAvdz8Fchpr; Wed,  3 Jul 2024 16:06:27 +0200 (CEST)
Received: from applejack.lan (83.8.74.165.ipv4.supernova.orange.pl
 [83.8.74.165])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 85BDB260757;
 Wed,  3 Jul 2024 16:06:26 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Date: Wed, 03 Jul 2024 16:06:11 +0200
Subject: [PATCH v4 1/2] tests/avocado: sbsa-ref: add FreeBSD tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240703-b4-move-to-freebsd-v4-1-07191f958530@linaro.org>
References: <20240703-b4-move-to-freebsd-v4-0-07191f958530@linaro.org>
In-Reply-To: <20240703-b4-move-to-freebsd-v4-0-07191f958530@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: b4 0.13.0
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
so we can stay on 14.x for longer. Tests done on OpenBSD will now be
done using FreeBSD.

OpenBSD 7.3 stays with Cortex-A57 test for local runs only.

Moved from Neoverse-N1 to Neoverse-N2 as sbsa-ref defaults were changed.

Timeout messages expanded to mention being affected by PAuth emulation.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 73 ++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index e920bbf08c..2e27d37cb8 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -1,4 +1,4 @@
-# Functional test that boots a Linux kernel and checks the console
+# Functional test that boots a kernel and checks the console
 #
 # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
 # SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
@@ -163,7 +163,8 @@ def test_sbsaref_alpine_linux_max_pauth_impdef(self):
         """
         self.boot_alpine_linux("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
     def test_sbsaref_alpine_linux_max(self):
         """
         :avocado: tags=cpu:max
@@ -171,7 +172,6 @@ def test_sbsaref_alpine_linux_max(self):
         """
         self.boot_alpine_linux("max")
 
-
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
@@ -198,6 +198,9 @@ def boot_openbsd73(self, cpu):
                                  "Welcome to the OpenBSD/arm64"
                                  " 7.3 installation program.")
 
+
+    # we keep OpenBSD 7.3 on Cortex-A57 by request
+    @skipUnless(os.getenv('AVOCADO_TEST_LEGACY_OS'), 'OpenBSD 7.3 is EOL')
     def test_sbsaref_openbsd73_cortex_a57(self):
         """
         :avocado: tags=cpu:cortex-a57
@@ -205,32 +208,66 @@ def test_sbsaref_openbsd73_cortex_a57(self):
         """
         self.boot_openbsd73("cortex-a57")
 
-    def test_sbsaref_openbsd73_neoverse_n1(self):
+
+    # This tests the whole boot chain from EFI to Userspace
+    # We only boot a whole OS for the current top level CPU and GIC
+    # Other test profiles should use more minimal boots
+    def boot_freebsd(self, cpu):
+        self.fetch_firmware()
+
+        img_url = (
+            "https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/"
+            "14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso"
+        )
+
+        img_hash = "44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461"
+        img_path = self.fetch_asset(img_url, algorithm="sha256", asset_hash=img_hash)
+
+        self.vm.set_console()
+        self.vm.add_args(
+            "-cpu",
+            cpu,
+            "-drive",
+            f"file={img_path},format=raw",
+        )
+
+        self.vm.launch()
+        wait_for_console_pattern(self, "Welcome to FreeBSD!")
+
+    def test_sbsaref_freebsd_cortex_a57(self):
         """
-        :avocado: tags=cpu:neoverse-n1
-        :avocado: tags=os:openbsd
+        :avocado: tags=cpu:cortex-a57
+        :avocado: tags=os:freebsd
+        """
+        self.boot_freebsd("cortex-a57")
+
+    # We use Neoverse-N2 as default cpu
+    def test_sbsaref_freebsd_neoverse_n2(self):
         """
-        self.boot_openbsd73("neoverse-n1")
+        :avocado: tags=cpu:neoverse-n2
+        :avocado: tags=os:freebsd
+        """
+        self.boot_freebsd("neoverse-n2")
 
-    def test_sbsaref_openbsd73_max_pauth_off(self):
+    def test_sbsaref_freebsd_max_pauth_off(self):
         """
         :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("max,pauth=off")
+        self.boot_freebsd("max,pauth=off")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-    def test_sbsaref_openbsd73_max_pauth_impdef(self):
+    def test_sbsaref_freebsd_max_pauth_impdef(self):
         """
         :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("max,pauth-impdef=on")
+        self.boot_freebsd("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
-    def test_sbsaref_openbsd73_max(self):
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'),
+                'Test might timeout due to PAuth emulation')
+    def test_sbsaref_freebsd_max(self):
         """
         :avocado: tags=cpu:max
-        :avocado: tags=os:openbsd
+        :avocado: tags=os:freebsd
         """
-        self.boot_openbsd73("max")
+        self.boot_freebsd("max")

-- 
2.45.2


